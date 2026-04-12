CREATE TABLE t_alena_dostalova_project_SQL_primary_final AS
WITH vypocet_prumernych_mezd AS (
    -- Mzdy podle odvětví a let, počítáme průměrnou mzdu pro jednotlivá odvětví a roky, musíme spojit 2 tabulky – czechia_payroll a czechia_payroll_industry_branch, použijeme jenom kód pro průměrné mzdy
    SELECT 
        cp.payroll_year,
        cpib.name AS jmeno_odvetvi,
        AVG(cp.value) AS prumerna_mzda,
        LAG(AVG(cp.value)) OVER (PARTITION BY cpib.name ORDER BY cp.payroll_year) AS predchozi_prumerna_mzda -- Tady zobrazujeme průměrnou mzdu pro dané období z předchozího roku
    FROM czechia_payroll cp
    JOIN czechia_payroll_industry_branch cpib ON cp.industry_branch_code = cpib.code
    WHERE cp.value_type_code = '5958' -- Kód průměrné mzdy
     AND cp.calculation_code = '200'
    GROUP BY cp.payroll_year, cpib.name
),
ceny_potravin AS (
    -- Ceny potravin podle kategorií a let, další pomocný výpočet, musíme si vyextrahovat rok, pak udělat posun
    SELECT 
    cpc.price_unit,
    DATE_PART('year', cpr.date_from) AS rok,
        cpc.name AS nazev_produktu,
        AVG(cpr.value) AS prumerna_cena,
       LAG(AVG(cpr.value)) OVER (PARTITION BY cpc.name ORDER BY DATE_PART('year', cpr.date_from)) AS predchozi_prumerna_cena  -- Výpočet průměrné ceny z předchozího roku pro danou kategorii potravin
    FROM czechia_price cpr
    JOIN czechia_price_category cpc ON cpr.category_code = cpc.code -- Abychom ke kódu přiřadili název produktu
    GROUP BY rok, nazev_produktu, cpc.price_unit
)
SELECT 
    v.payroll_year AS rok,
    v.jmeno_odvetvi,
    v.prumerna_mzda,
    c.nazev_produktu,
    c.prumerna_cena,
    -- 1. Pro otázku mezd: Rostou nebo klesají?
    CASE
        WHEN v.prumerna_mzda  > v.predchozi_prumerna_mzda  THEN 'Růst'
        WHEN v.prumerna_mzda  < v.predchozi_prumerna_mzda  THEN 'Pokles'
        ELSE 'Stagnace/První rok'
    END AS trend_mezd,
    -- 2. Pro otázku chleba/mléka: Kolik si jich koupím?
    FLOOR(v.prumerna_mzda  / c.prumerna_cena) AS pocet_kusu_za_mzdu,
-- tato fce zaokrouhluje dolů
    c.price_unit,
    -- 3. Pro otázku zdražování potravin: % změna ceny
    ROUND(((c.prumerna_cena - c.predchozi_prumerna_cena) / c.predchozi_prumerna_cena * 100)::numeric, 2) AS zmena_ceny_procenta,
-- :: vemzi prosím výsledek toho výpočtu a pracuj s ním jako s numeric (a zaokrouhli ho na dvě desetinná místa)
    -- 4. Pro otázku 10% rozdílu: Rozdíl mezi růstem ceny a růstem mzdy (celorepublikový průměr mzdy by byl přesnější, ale toto srovnává odvětví vs potravina)
    ROUND((((c.prumerna_cena - c.predchozi_prumerna_cena) / c.predchozi_prumerna_cena * 100) - ((v.prumerna_mzda  - v.predchozi_prumerna_mzda ) / v.predchozi_prumerna_mzda  * 100))::numeric, 2) AS rozdil_tempa_rustu
-- Tady to taky musíme ošetřit :: numeric, abychom dostali číslo
FROM vypocet_prumernych_mezd v
JOIN ceny_potravin c ON v.payroll_year = c.rok
ORDER BY rok, jmeno_odvetvi, nazev_produktu;
