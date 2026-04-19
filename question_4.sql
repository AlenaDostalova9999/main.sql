WITH wage_growth AS (
    SELECT 
        payroll_year,
        AVG(value) AS avg_wage_year
    FROM czechia_payroll
    WHERE value_type_code = '5958' 
      AND calculation_code = '200'
    GROUP BY payroll_year
),
food_growth AS (
    SELECT 
        DATE_PART('year', date_from) AS year,
        AVG(value) AS avg_price_year
    FROM czechia_price
    GROUP BY year
),
calculation AS (
    SELECT 
        w.payroll_year AS year,
        w.avg_wage_year,
        f.avg_price_year,
        LAG(w.avg_wage_year) OVER (ORDER BY w.payroll_year) AS prev_wage,
        LAG(f.avg_price_year) OVER (ORDER BY w.payroll_year) AS prev_price
    FROM wage_growth w
    JOIN food_growth f ON w.payroll_year = f.year
)
SELECT 
    year,
    ROUND(((avg_price_year - prev_price) / prev_price * 100)::numeric, 2) AS food_growth_pct,
    ROUND(((avg_wage_year - prev_wage) / prev_wage * 100)::numeric, 2) AS wage_growth_pct,
    ROUND((((avg_price_year - prev_price) / prev_price * 100) - 
           ((avg_wage_year - prev_wage) / prev_wage * 100))::numeric, 2) AS difference
FROM calculation
WHERE prev_wage IS NOT NULL AND prev_price IS NOT NULL
ORDER BY year;
