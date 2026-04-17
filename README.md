# SQL Projekt: Analýza mezd a cen potravin

## Popis projektu
Cílem projektu je porovnat dostupnost základních potravin s ohledem na průměrné mzdy v České republice mezi lety 2006–2018.

## Datové sady
- **Primary table:** Sjednocená data o cenách a mzdách v ČR (`t_alena_dostalova_project_SQL_primary_final`).
- **Secondary table:** Ekonomická data o evropských státech (`t_alena_dostalova_project_SQL_secondary_final`).

## Výzkumné otázky
________________________________________________________________________________________________________________
**1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**
_Upravíme skript následovně, do konečné části přidáme where._

FROM vypocet_prumernych_mezd v
JOIN ceny_potravin c ON v.payroll_year = c.rok
WHERE v.prumerna_mzda < v.predchozi_prumerna_mzda -- Tady filtrujeme jen pokles
ORDER BY rok, jmeno_odvetvi;

 _Odpověď_
   Je i pokles, například: těžba a dobývání, Ubytování, stravování a pohostinství, Zemědělství, lesnictví, rybářství atd.

_________________________________________________________________________________________________________________
**2. Kolik litrů mléka a kg chleba si lze koupit za první a poslední srovnatelné období?**
_Upravíme skript následovně, do konečné části přidáme where._

FROM vypocet_prumernych_mezd v
JOIN ceny_potravin c ON v.payroll_year = c.rok
WHERE 
    -- 1. Filtrujeme jen chleba a mléko
    (c.nazev_produktu LIKE '%Chléb%' OR c.nazev_produktu LIKE '%Mléko%')
    -- 2. Filtrujeme jen první a poslední srovnatelný rok
    AND v.payroll_year IN (
        (SELECT MIN(payroll_year) FROM vypocet_prumernych_mezd WHERE payroll_year IN (SELECT rok FROM ceny_potravin)),
        (SELECT MAX(payroll_year) FROM vypocet_prumernych_mezd WHERE payroll_year IN (SELECT rok FROM ceny_potravin))
    )
ORDER BY rok ASC, nazev_produktu DESC;

_Odpověď_
Administrativní a podpůrné činnosti koupí za průměrnou mzdu 14444 Kč Chléb konzumní kmínový 895.0 kg v roce 2006.
Doprava a skladování koupí za průměrnou mzdu 19256.75 Kč Mléko polotučné pasterované 1333.0 l v roce 2006.

Pozn. Kdybychom nechtěli rozdělení na jednotlivá odvětví, upravil by se začátek skriptu takto:
WITH vypocet_prumernych_mezd AS (
    SELECT 
        cp.payroll_year,
        AVG(cp.value) AS prumerna_mzda,
        LAG(AVG(cp.value)) OVER (ORDER BY cp.payroll_year) AS predchozi_prumerna_mzda
    FROM czechia_payroll cp
    WHERE cp.value_type_code = '5958'
      AND cp.calculation_code = '200'
    GROUP BY cp.payroll_year -- odstraníme cpib.name, takže název odvětví
),
_________________________________________________________________________________________________________________
**3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?**
_Upravíme skript následovně, v konečné části uděláme tuto změnu:_

SELECT 
    v.payroll_year AS rok,
    v.jmeno_odvetvi,
    v.prumerna_mzda,
    c.nazev_produktu,
    c.prumerna_cena,
    -- 1. Rostou nebo klesají mzdy?
    CASE
        WHEN v.prumerna_mzda > v.predchozi_prumerna_mzda THEN 'Růst'
        WHEN v.prumerna_mzda < v.predchozi_prumerna_mzda THEN 'Pokles'
        ELSE 'Stagnace/První rok'
    END AS trend_mezd,
    -- 2. Kolik si jich koupím?
    FLOOR(v.prumerna_mzda / c.prumerna_cena) AS pocet_kusu_za_mzdu,
    c.price_unit,
    -- 3. Meziroční změna ceny v %
    ROUND(((c.prumerna_cena - c.predchozi_prumerna_cena) / c.predchozi_prumerna_cena * 100)::numeric, 2) AS zmena_ceny_procenta,
    -- NOVINKA: Průměrná změna této konkrétní potraviny za všechna období; počítá průměr všech meziročních změn pro daný produkt
    ROUND(AVG(((c.prumerna_cena - c.predchozi_prumerna_cena) / c.predchozi_prumerna_cena * 100)) OVER (PARTITION BY c.nazev_produktu)::numeric, 2) AS celkovy_prumerny_narust_kategorie,
    -- 4. Rozdíl temp
    ROUND((((c.prumerna_cena - c.predchozi_prumerna_cena) / c.predchozi_prumerna_cena * 100) - ((v.prumerna_mzda - v.predchozi_prumerna_mzda) / v.predchozi_prumerna_mzda * 100))::numeric, 2) AS rozdil_tempa_rustu
FROM vypocet_prumernych_mezd v
JOIN ceny_potravin c ON v.payroll_year = c.rok
ORDER BY celkovy_prumerny_narust_kategorie ASC, rok, jmeno_odvetvi; -- úprava seřazení, abychom viděli, která potravina zdražuje nejpomaleji

_Odpověď:_
Cukr krystalový

__________________________________________________________________________________________________________________
**4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?**

_Upravíme skript následovně, v konečné části uděláme změnu:_

SELECT 
    v.payroll_year AS rok,
    v.jmeno_odvetvi,
    v.prumerna_mzda,
    c.nazev_produktu,
    c.prumerna_cena,
    -- 1. Rostou nebo klesají mzdy?
    CASE
        WHEN v.prumerna_mzda  > v.predchozi_prumerna_mzda  THEN 'Růst'
        WHEN v.prumerna_mzda  < v.predchozi_prumerna_mzda  THEN 'Pokles'
        ELSE 'Stagnace/První rok'
    END AS trend_mezd,
    -- 2. Kolik si jich koupím?
    FLOOR(v.prumerna_mzda  / c.prumerna_cena) AS pocet_kusu_za_mzdu,
    c.price_unit,
    -- 3. Procento změny ceny
    ROUND(((c.prumerna_cena - c.predchozi_prumerna_cena) / c.predchozi_prumerna_cena * 100)::numeric, 2) AS zmena_ceny_procenta,
    -- 4. Rozdíl temp (ceny vs mzdy)
    ROUND((((c.prumerna_cena - c.predchozi_prumerna_cena) / c.predchozi_prumerna_cena * 100) - ((v.prumerna_mzda  - v.predchozi_prumerna_mzda ) / v.predchozi_prumerna_mzda  * 100))::numeric, 2) AS rozdil_tempa_rustu,
    -- NOVINKA: hledá se rozdíl o 10 %
    CASE 
        WHEN (((c.prumerna_cena - c.predchozi_prumerna_cena) / c.predchozi_prumerna_cena * 100) - ((v.prumerna_mzda  - v.predchozi_prumerna_mzda ) / v.predchozi_prumerna_mzda  * 100)) > 10 THEN 'ANO'
        ELSE 'NE'
    END AS narust_ceny_o_10_procent_vyssi_nez_mzdy

FROM vypocet_prumernych_mezd v
JOIN ceny_potravin c ON v.payroll_year = c.rok
WHERE 
    -- Tady aplikujeme filtr na 10% rozdíl
    (((c.prumerna_cena - c.predchozi_prumerna_cena) / c.predchozi_prumerna_cena * 100) - ((v.prumerna_mzda  - v.predchozi_prumerna_mzda ) / v.predchozi_prumerna_mzda  * 100)) > 10
ORDER BY rok, rozdil_tempa_rustu DESC;

_Odpověď:_
Rok 2007, 2008, 2010
_________________________________________________________________________________________________________________
**5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?**

1. Vliv HDP na průměrné mzdy
Z analýzy vyplývá, že HDP má vliv na vývoj mezd. Pokud ekonomika roste, průměrné mzdy obvykle rostou také, ale často až s odstupem zhruba jednoho roku.

3. Vliv HDP na ceny potravin
U cen potravin se naopak nepodařilo prokázat přímou souvislost s vývojem HDP. Ceny se totiž mění nezávisle na tom, jak se ekonomice daří, a mohou jak růst, tak klesat.
___________________________________________________________________________________________________________________
