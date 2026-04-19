SELECT 
    year,
    industry_name,
    average_wage,
    product_name,
    average_price,
    FLOOR(average_wage / average_price) AS units_per_wage,
    price_unit
FROM t_alena_dostalova_project_SQL_primary_final
WHERE 
    -- 1. Filtrujeme jen chleba a mléko
    (product_name LIKE '%Chléb%' OR product_name LIKE '%Mléko%')
    -- 2. Filtrujeme dynamicky jen první a poslední dostupný rok v naší vytvořené tabulce
    AND year IN (
        (SELECT MIN(year) FROM t_alena_dostalova_project_SQL_primary_final),
        (SELECT MAX(year) FROM t_alena_dostalova_project_SQL_primary_final)
    )
ORDER BY year, product_name, industry_name;
