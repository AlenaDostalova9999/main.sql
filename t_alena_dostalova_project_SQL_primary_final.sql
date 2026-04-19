CREATE TABLE t_alena_dostalova_project_SQL_primary_final AS
WITH wage_prep AS (
    -- Příprava mezd: průměr za odvětví a rok
    SELECT 
        cp.payroll_year AS year,
        cpib.name AS industry_name,
        AVG(cp.value) AS average_wage
    FROM czechia_payroll cp
    JOIN czechia_payroll_industry_branch cpib ON cp.industry_branch_code = cpib.code
    WHERE cp.value_type_code = '5958' 
      AND cp.calculation_code = '200'
    GROUP BY cp.payroll_year, cpib.name
),
price_prep AS (
    -- Příprava cen: průměr za potravinu a rok
    SELECT 
        DATE_PART('year', cpr.date_from) AS year,
        cpc.name AS product_name,
        cpc.price_unit,
        AVG(cpr.value) AS average_price
    FROM czechia_price cpr
    JOIN czechia_price_category cpc ON cpr.category_code = cpc.code
    GROUP BY year, product_name, cpc.price_unit
)
SELECT 
    w.year,
    w.industry_name,
    w.average_wage,
    -- Pomocný výpočet pro mzdu z předchozího roku v daném odvětví
    LAG(w.average_wage) OVER (PARTITION BY w.industry_name ORDER BY w.year) AS previous_average_wage,
    p.product_name,
    p.average_price,
    p.price_unit,
    -- Pomocný výpočet pro cenu z předchozího roku u daného produktu
    LAG(p.average_price) OVER (PARTITION BY w.industry_name, p.product_name ORDER BY w.year) AS previous_average_price
FROM wage_prep w
JOIN price_prep p ON w.year = p.year;
