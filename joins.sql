/* INNER JOIN
Find total revenue by country
*/

SELECT
    c.country_name,
    SUM(o.revenue) AS total_revenue
FROM operations o
INNER JOIN countries c
    ON o.country_id = c.country_id
GROUP BY c.country_name
ORDER BY total_revenue DESC;


/* LEFT JOIN
Show all countries, including those with no operations
*/

SELECT
    c.country_name,
    COUNT(o.operation_id) AS total_operations
FROM countries c
LEFT JOIN operations o
    ON c.country_id = o.country_id
GROUP BY c.country_name;


/* Multiple JOINs
Performance by country and team
*/

SELECT
    c.country_name,
    t.team_name,
    COUNT(o.operation_id) AS cases_handled,
    AVG(o.tat_days) AS avg_tat
FROM operations o
INNER JOIN countries c
    ON o.country_id = c.country_id
INNER JOIN teams t
    ON o.team_id = t.team_id
GROUP BY
    c.country_name,
    t.team_name
ORDER BY
    c.country_name,
    cases_handled DESC;


/* KPI Dashboard Query
*/

SELECT
    c.country_name,
    COUNT(o.operation_id) AS total_cases,
    AVG(o.tat_days) AS avg_tat,
    SUM(o.revenue) AS revenue,
    ROUND(
        SUM(o.completed_cases) * 100.0 /
        NULLIF(SUM(o.total_cases),0),
        2
    ) AS conversion_rate
FROM operations o
INNER JOIN countries c
    ON o.country_id = c.country_id
GROUP BY c.country_name
ORDER BY revenue DESC;
