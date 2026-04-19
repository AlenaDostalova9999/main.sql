# SQL Projekt: Analýza mezd a cen potravin

## Popis projektu
Cílem projektu je porovnat dostupnost základních potravin s ohledem na průměrné mzdy v České republice mezi lety 2006–2018.

## Datové sady
- **Primary table:** Sjednocená data o cenách a mzdách v ČR (`t_alena_dostalova_project_SQL_primary_final`).
- **Secondary table:** Ekonomická data o evropských státech (`t_alena_dostalova_project_SQL_secondary_final`).

## Výzkumné otázky
________________________________________________________________________________________________________________
**1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?** I klesají, viz tabulka níže.
**| Year | Industry_name | wage_difference |**
|  |  |  |
|---|---|---|
| 2009 | Těžba a dobývání | -912.00 |
| 2009 | Ubytování, stravování a pohostinství | -138.00 |
| 2009 | Zemědělství, lesnictví, rybářství | -119.25 |
| 2009 | Činnosti v oblasti nemovitostí | -84.25 |
| 2010 | Profesní, vědecké a technické činnosti | -189.50 |
| 2010 | Veřejná správa a obrana; povinné sociální zabezpečení | -91.00 |
| 2010 | Vzdělávání | -393.00 |
| 2011 | Doprava a skladování | -0.50 |
| 2011 | Ubytování, stravování a pohostinství | -74.00 |
| 2011 | Veřejná správa a obrana; povinné sociální zabezpečení | -612.75 |
| 2011 | Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu | -94.25 |
| 2013 | Administrativní a podpůrné činnosti | -211.25 |
| 2013 | Informační a komunikační činnosti | -486.00 |
| 2013 | Kulturní, zábavní a rekreační činnosti | -297.75 |
| 2013 | Peněžnictví a pojišťovnictví | -4484.00 |
| 2013 | Profesní, vědecké a technické činnosti | -992.00 |
| 2013 | Stavebnictví | -470.50 |
| 2013 | Těžba a dobývání | -1053.75 |
| 2013 | Velkoobchod a maloobchod; opravy a údržba motorových vozidel | -194.00 |
| 2013 | Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu | -1895.50 |
| 2013 | Zásobování vodou; činnosti související s odpady a sanacemi | -101.75 |
| 2013 | Činnosti v oblasti nemovitostí | -401.00 |
| 2014 | Těžba a dobývání | -184.75 |
| 2015 | Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu | -641.25 |
| 2016 | Těžba a dobývání | -182.25 |
| 2020 | Ubytování, stravování a pohostinství | -1031.75 |
| 2020 | Činnosti v oblasti nemovitostí | -2150.25 |
| 2021 | Kulturní, zábavní a rekreační činnosti | -1048.00 |
| 2021 | Stavebnictví | -195.00 |
| 2021 | Veřejná správa a obrana; povinné sociální zabezpečení | -913.00 |
| 2021 | Vzdělávání | -1086.25 |
| 2021 | Zemědělství, lesnictví, rybářství | -1079.00 |

_________________________________________________________________________________________________________________
**2. Kolik litrů mléka a kg chleba si lze koupit za první a poslední srovnatelné období?**
| Year |Industry_name  |product_name  |units_per_wage  |price_unit  |
|---|---|---|---|---|
| 2006 | Administrativní a podpůrné činnosti | Chléb konzumní kmínový | 895.0 | kg |
| 2006 | Doprava a skladování | Chléb konzumní kmínový | 1194.0 | kg |
| 2006 | Informační a komunikační činnosti | Chléb konzumní kmínový | 2219.0 | kg |
| 2006 | Kulturní, zábavní a rekreační činnosti | Chléb konzumní kmínový | 1043.0 | kg |
| 2006 | Ostatní činnosti | Chléb konzumní kmínový | 1022.0 | kg |
| 2006 | Peněžnictví a pojišťovnictví | Chléb konzumní kmínový | 2482.0 | kg |
| 2006 | Profesní, vědecké a technické činnosti | Chléb konzumní kmínový | 1528.0 | kg |
| 2006 | Stavebnictví | Chléb konzumní kmínový | 1107.0 | kg |
| 2006 | Těžba a dobývání | Chléb konzumní kmínový | 1492.0 | kg |
| 2006 | Ubytování, stravování a pohostinství | Chléb konzumní kmínový | 724.0 | kg |
| 2006 | Velkoobchod a maloobchod; opravy a údržba motorových vozidel | Chléb konzumní kmínový | 1130.0 | kg |
| 2006 | Veřejná správa a obrana; povinné sociální zabezpečení | Chléb konzumní kmínový | 1444.0 | kg |
| 2006 | Vzdělávání | Chléb konzumní kmínový | 1242.0 | kg |
| 2006 | Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu | Chléb konzumní kmínový | 1811.0 | kg |
| 2006 | Zdravotní a sociální péče | Chléb konzumní kmínový | 1180.0 | kg |
| 2006 | Zemědělství, lesnictví, rybářství | Chléb konzumní kmínový | 919.0 | kg |
| 2006 | Zpracovatelský průmysl | Chléb konzumní kmínový | 1146.0 | kg |
| 2006 | Zásobování vodou; činnosti související s odpady a sanacemi | Chléb konzumní kmínový | 1162.0 | kg |
| 2006 | Činnosti v oblasti nemovitostí | Chléb konzumní kmínový | 1193.0 | kg |
| 2006 | Administrativní a podpůrné činnosti | Mléko polotučné pasterované | 1000.0 | l |
| 2006 | Doprava a skladování | Mléko polotučné pasterované | 1333.0 | l |
| 2006 | Informační a komunikační činnosti | Mléko polotučné pasterované | 2479.0 | l |
| 2006 | Kulturní, zábavní a rekreační činnosti | Mléko polotučné pasterované | 1165.0 | l |
| 2006 | Ostatní činnosti | Mléko polotučné pasterované | 1141.0 | l |
| 2006 | Peněžnictví a pojišťovnictví | Mléko polotučné pasterované | 2772.0 | l |
| 2006 | Profesní, vědecké a technické činnosti | Mléko polotučné pasterované | 1706.0 | l |
| 2006 | Stavebnictví | Mléko polotučné pasterované | 1236.0 | l |
| 2006 | Těžba a dobývání | Mléko polotučné pasterované | 1666.0 | l |
| 2006 | Ubytování, stravování a pohostinství | Mléko polotučné pasterované | 808.0 | l |
| 2006 | Velkoobchod a maloobchod; opravy a údržba motorových vozidel | Mléko polotučné pasterované | 1262.0 | l |
| 2006 | Veřejná správa a obrana; povinné sociální zabezpečení | Mléko polotučné pasterované | 1612.0 | l |
| 2006 | Vzdělávání | Mléko polotučné pasterované | 1387.0 | l |
| 2006 | Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu | Mléko polotučné pasterované | 2023.0 | l |
| 2006 | Zdravotní a sociální péče | Mléko polotučné pasterované | 1318.0 | l |
| 2006 | Zemědělství, lesnictví, rybářství | Mléko polotučné pasterované | 1026.0 | l |
| 2006 | Zpracovatelský průmysl | Mléko polotučné pasterované | 1280.0 | l |
| 2006 | Zásobování vodou; činnosti související s odpady a sanacemi | Mléko polotučné pasterované | 1297.0 | l |
| 2006 | Činnosti v oblasti nemovitostí | Mléko polotučné pasterované | 1332.0 | l |
| 2018 | Administrativní a podpůrné činnosti | Chléb konzumní kmínový | 864.0 | kg |
| 2018 | Doprava a skladování | Chléb konzumní kmínový | 1215.0 | kg |
| 2018 | Informační a komunikační činnosti | Chléb konzumní kmínový | 2340.0 | kg |
| 2018 | Kulturní, zábavní a rekreační činnosti | Chléb konzumní kmínový | 1171.0 | kg |
| 2018 | Ostatní činnosti | Chléb konzumní kmínový | 977.0 | kg |
| 2018 | Peněžnictví a pojišťovnictví | Chléb konzumní kmínový | 2264.0 | kg |
| 2018 | Profesní, vědecké a technické činnosti | Chléb konzumní kmínový | 1608.0 | kg |
| 2018 | Stavebnictví | Chléb konzumní kmínový | 1162.0 | kg |
| 2018 | Těžba a dobývání | Chléb konzumní kmínový | 1486.0 | kg |
| 2018 | Ubytování, stravování a pohostinství | Chléb konzumní kmínový | 794.0 | kg |
| 2018 | Velkoobchod a maloobchod; opravy a údržba motorových vozidel | Chléb konzumní kmínový | 1236.0 | kg |
| 2018 | Veřejná správa a obrana; povinné sociální zabezpečení | Chléb konzumní kmínový | 1498.0 | kg |
| 2018 | Vzdělávání | Chléb konzumní kmínový | 1297.0 | kg |
| 2018 | Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu | Chléb konzumní kmínový | 1913.0 | kg |
| 2018 | Zdravotní a sociální péče | Chléb konzumní kmínový | 1397.0 | kg |
| 2018 | Zemědělství, lesnictví, rybářství | Chléb konzumní kmínový | 1050.0 | kg |
| 2018 | Zpracovatelský průmysl | Chléb konzumní kmínový | 1315.0 | kg |
| 2018 | Zásobování vodou; činnosti související s odpady a sanacemi | Chléb konzumní kmínový | 1185.0 | kg |
| 2018 | Činnosti v oblasti nemovitostí | Chléb konzumní kmínový | 1159.0 | kg |
| 2018 | Administrativní a podpůrné činnosti | Mléko polotučné pasterované | 1057.0 | l |
| 2018 | Doprava a skladování | Mléko polotučné pasterované | 1486.0 | l |
| 2018 | Informační a komunikační činnosti | Mléko polotučné pasterované | 2862.0 | l |
| 2018 | Kulturní, zábavní a rekreační činnosti | Mléko polotučné pasterované | 1433.0 | l |
| 2018 | Ostatní činnosti | Mléko polotučné pasterované | 1195.0 | l |
| 2018 | Peněžnictví a pojišťovnictví | Mléko polotučné pasterované | 2769.0 | l |
| 2018 | Profesní, vědecké a technické činnosti | Mléko polotučné pasterované | 1967.0 | l |
| 2018 | Stavebnictví | Mléko polotučné pasterované | 1421.0 | l |
| 2018 | Těžba a dobývání | Mléko polotučné pasterované | 1818.0 | l |
| 2018 | Ubytování, stravování a pohostinství | Mléko polotučné pasterované | 972.0 | l |
| 2018 | Velkoobchod a maloobchod; opravy a údržba motorových vozidel | Mléko polotučné pasterované | 1512.0 | l |
| 2018 | Veřejná správa a obrana; povinné sociální zabezpečení | Mléko polotučné pasterované | 1832.0 | l |
| 2018 | Vzdělávání | Mléko polotučné pasterované | 1586.0 | l |
| 2018 | Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu | Mléko polotučné pasterované | 2340.0 | l |
| 2018 | Zdravotní a sociální péče | Mléko polotučné pasterované | 1708.0 | l |
| 2018 | Zemědělství, lesnictví, rybářství | Mléko polotučné pasterované | 1285.0 | l |
| 2018 | Zpracovatelský průmysl | Mléko polotučné pasterované | 1609.0 | l |
| 2018 | Zásobování vodou; činnosti související s odpady a sanacemi | Mléko polotučné pasterované | 1449.0 | l |
| 2018 | Činnosti v oblasti nemovitostí | Mléko polotučné pasterované | 1418.0 | l |
_________________________________________________________________________________________________________________
**3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?**
_Odpověď:_ cukr krystalový, viz tabulka niže 

| product_name |avg_yoy_growth_percentage|
|---|---|
| Cukr krystalový | -1,92 |
| Rajská jablka červená kulatá | -0,74 |
| Banány žluté | 0,81 |
| Vepřová pečeně s kostí | 0,99 |
| Přírodní minerální voda uhličitá | 1,03 |
| Šunkový salám | 1,85 |
| Jablka konzumní | 2,01 |
| Pečivo pšeničné bílé | 2,2 |
| Hovězí maso zadní bez kosti | 2,53 |
| Kapr živý | 2,6 |
| Jakostní víno bílé | 2,7 |
| Pivo výčepní, světlé, lahvové | 2,85 |
| Eidamská cihla | 2,92 |
| Mléko polotučné pasterované | 2,98 |
| Rostlinný roztíratelný tuk | 3,23 |
| Kuřata kuchaná celá | 3,38 |
| Pomeranče | 3,6 |
| Jogurt bílý netučný | 3,96 |
| Chléb konzumní kmínový | 3,97 |
| Konzumní brambory | 4,18 |
| Rýže loupaná dlouhozrnná | 5 |
| Mrkev | 5,24 |
| Pšeničná mouka hladká | 5,24 |
| Těstoviny vaječné | 5,26 |
| Vejce slepičí čerstvá | 5,55 |
| Máslo | 6,67 |
| Papriky | 7,29 |
__________________________________________________________________________________________________________________
**4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?**
_Odpověď:_
V období mezi lety 2007 a 2018 takový rok neexistuje.

| Year | food_growth_pct | wage_growth_pct | difference |
|  |  |  |  |
|---|---|---|---|
| 2007 | 6,34 | 6,89 | -0,55 |
| 2008 | 6,41 | 7,7 | -1,29 |
| 2009 | -6,8 | 3,09 | -9,89 |
| 2010 | 1,77 | 1,92 | -0,16 |
| 2011 | 3,5 | 2,34 | 1,15 |
| 2012 | 6,92 | 2,91 | 4,01 |
| 2013 | 5,55 | -1,49 | 7,04 |
| 2014 | 0,89 | 2,59 | -1,7 |
| 2015 | -0,56 | 2,62 | -3,18 |
| 2016 | -1,12 | 3,68 | -4,8 |
| 2017 | 9,98 | 6,19 | 3,78 |
| 2018 | 1,94 | 7,72 | -5,78 |
_________________________________________________________________________________________________________________
**5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?**

1. Vliv HDP na průměrné mzdy
Z analýzy vyplývá, že HDP má vliv na vývoj mezd. Pokud ekonomika roste, průměrné mzdy obvykle rostou také, ale často až s odstupem zhruba jednoho roku.

3. Vliv HDP na ceny potravin
U cen potravin se naopak nepodařilo prokázat přímou souvislost s vývojem HDP. Ceny se totiž mění nezávisle na tom, jak se ekonomice daří, a mohou jak růst, tak klesat.
___________________________________________________________________________________________________________________
