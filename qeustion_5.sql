WITH gdp_growth AS (
    SELECT 
        year,
        gdp,
        ROUND(
            ((gdp - LAG(gdp) OVER (ORDER BY year)) / LAG(gdp) OVER (ORDER BY year) * 100)::numeric, 
            2
        ) AS gdp_growth_pct
    FROM t_alena_dostalova_project_SQL_secondary_final
    WHERE country = 'Czech Republic'
),
wage_price_growth AS (
    SELECT 
        year,
        ROUND(AVG((average_wage - previous_average_wage) / previous_average_wage * 100)::numeric, 2) AS avg_wage_growth,
        ROUND(AVG((average_price - previous_average_price) / previous_average_price * 100)::numeric, 2) AS avg_food_growth
    FROM t_alena_dostalova_project_SQL_primary_final
    WHERE previous_average_wage IS NOT NULL 
      AND previous_average_price IS NOT NULL
    GROUP BY year
)
SELECT 
    g.year,
    g.gdp_growth_pct AS gdp_growth,
    -- Růst HDP v předchozím roce (pro sledování zpožděného vlivu)
    LAG(g.gdp_growth_pct) OVER (ORDER BY g.year) AS gdp_growth_lagged,
    wp.avg_wage_growth AS wage_growth,
    wp.avg_food_growth AS food_growth
FROM gdp_growth g
JOIN wage_price_growth wp ON g.year = wp.year
ORDER BY g.year;
