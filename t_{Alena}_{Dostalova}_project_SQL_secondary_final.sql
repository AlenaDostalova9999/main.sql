CREATE TABLE t_alena_dostalova_project_SQL_secondary_final AS
SELECT 
    e.country,
    e.year,
    e.gdp,
    e.gini,
    e.population,
    c.continent,
    c.region
FROM economies e
JOIN countries c ON e.country = c.country
WHERE c.continent = 'Europe' 
  AND e.year BETWEEN 2006 AND 2018;
