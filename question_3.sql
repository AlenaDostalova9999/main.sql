SELECT 
    product_name,
    ROUND(
        AVG(
            (average_price - previous_average_price) / NULLIF(previous_average_price, 0) * 100
        )::numeric, 2
    ) AS avg_yoy_growth_percentage
FROM t_alena_dostalova_project_SQL_primary_final
WHERE previous_average_price IS NOT NULL -- Vyřadíme první rok, kde ještě nemáme s čím porovnávat
GROUP BY product_name
ORDER BY avg_yoy_growth_percentage ASC;
