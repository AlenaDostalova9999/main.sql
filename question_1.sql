WITH average_wage_calculation AS (
    SELECT 
        cp.payroll_year,
        cpib.name AS industry_name,
        AVG(cp.value) AS average_wage,
        LAG(AVG(cp.value)) OVER (PARTITION BY cpib.name ORDER BY cp.payroll_year) AS previous_average_wage
    FROM czechia_payroll cp
    JOIN czechia_payroll_industry_branch cpib ON cp.industry_branch_code = cpib.code
    WHERE cp.value_type_code = '5958' 
      AND cp.calculation_code = '200'
    GROUP BY cp.payroll_year, cpib.name
)
SELECT 
    payroll_year AS year,
    industry_name,
    average_wage,
    previous_average_wage,
    -- Výpočet rozdílu pro jasný důkaz poklesu
    ROUND(average_wage - previous_average_wage, 2) AS rozdil_v_penezich
FROM average_wage_calculation
WHERE average_wage < previous_average_wage -- Tady filtrujeme jen ty poklesy
ORDER BY year, industry_name;
