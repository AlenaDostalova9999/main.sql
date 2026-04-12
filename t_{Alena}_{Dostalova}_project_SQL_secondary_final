CREATE TABLE t_{Alena}_{Dostalova}_project_SQL_secondary_final
WITH vypocet_prumernych_mezd AS (
    SELECT 
        cp.payroll_year,
        cpib.name AS jmeno_odvetvi,
        AVG(cp.value) AS prumerna_mzda,
        LAG(AVG(cp.value)) OVER (PARTITION BY cpib.name ORDER BY cp.payroll_year) AS predchozi_prumerna_mzda
    FROM czechia_payroll cp
    JOIN czechia_payroll_industry_branch cpib ON cp.industry_branch_code = cpib.code
    WHERE cp.value_type_code = '5958' 
      AND cp.calculation_code = '200'
    GROUP BY cp.payroll_year, cpib.name
),
ceny_potravin AS (
    SELECT 
        DATE_PART('year', cpr.date_from) AS rok,
        cpc.name AS nazev_produktu,
        AVG(cpr.value) AS prumerna_cena,
        LAG(AVG(cpr.value)) OVER (PARTITION BY cpc.name ORDER BY DATE_PART('year', cpr.date_from)) AS predchozi_prumerna_cena,
        cpc.price_unit
    FROM czechia_price cpr
    JOIN czechia_price_category cpc ON cpr.category_code = cpc.code
    GROUP BY rok, nazev_produktu, cpc.price_unit
),
hdp_zaklad AS (
    SELECT
        c.country,
        e.year,
        e.gini,
        e.gdp,
        LAG(e.gdp) OVER (PARTITION BY c.country ORDER BY e.year) AS predchozi_HDP,
        -- TADY BYLA CHYBA (DOPLNĚNO): Výpočet procentuálního růstu HDP
        ROUND(((e.gdp - LAG(e.gdp) OVER (PARTITION BY c.country ORDER BY e.year)) / LAG(e.gdp) OVER (PARTITION BY c.country ORDER BY e.year) * 100)::numeric, 2) AS zmena_hdp_procenta
    FROM economies e
    JOIN countries c ON e.country = c.country
    WHERE c.country ILIKE 'Czech Republic'
      AND e.gdp IS NOT NULL
)
SELECT
    h.country,
    h.year,
    h.gdp,
    -- Růst HDP v tomto roce (v %)
    h.zmena_hdp_procenta AS hdp_growth_current_year,
    -- Růst HDP v MINULÉM roce (v %) - pro sledování zpožděného vlivu
    LAG(h.zmena_hdp_procenta) OVER (ORDER BY h.year) AS hdp_growth_previous_year,
    h.gini,
    -- Trendy HDP
    CASE
        WHEN h.predchozi_HDP IS NULL THEN 'První dostupný rok'    
        WHEN h.gdp > h.predchozi_HDP THEN 'Růst'
        WHEN h.gdp < h.predchozi_HDP THEN 'Pokles'
        ELSE 'Stagnace'
    END AS trend_HDP,
    m.jmeno_odvetvi,
    m.prumerna_mzda,
    -- Procentuální změna mzdy (pro srovnání s HDP)
    ROUND(((m.prumerna_mzda - m.predchozi_prumerna_mzda) / m.predchozi_prumerna_mzda * 100)::numeric, 2) AS zmena_mzdy_procenta,
    p.nazev_produktu,
    p.prumerna_cena,
    -- Trendy mezd
    CASE
        WHEN m.prumerna_mzda > m.predchozi_prumerna_mzda THEN 'Růst'
        WHEN m.prumerna_mzda < m.predchozi_prumerna_mzda THEN 'Pokles'
        ELSE 'První rok / Stagnace'
    END AS trend_mezd,
    FLOOR(m.prumerna_mzda / p.prumerna_cena) AS pocet_kusu_za_mzdu,  
    price_unit,
    ROUND(((p.prumerna_cena - p.predchozi_prumerna_cena) / p.predchozi_prumerna_cena * 100)::numeric, 2) AS zmena_ceny_procenta,
    ROUND((((p.prumerna_cena - p.predchozi_prumerna_cena) / p.predchozi_prumerna_cena * 100) - 
           ((m.prumerna_mzda - m.predchozi_prumerna_mzda) / m.predchozi_prumerna_mzda * 100))::numeric, 2) AS rozdil_tempa_rustu
FROM hdp_zaklad h
JOIN vypocet_prumernych_mezd m ON h.year = m.payroll_year
JOIN ceny_potravin p ON h.year = p.rok
ORDER BY h.year, m.jmeno_odvetvi, p.nazev_produktu;
