-- challenge **
-- Total number of sales by employee
-- COUNT, LEFT JOIN, WHERE, GROUP BY, ORDER BY

SELECT
      emp.employeeId,
      emp.firstName,      
      emp.lastName,
      COUNT(*) AS TtlNumbSales
FROM sales sls
LEFT JOIN employee emp
      ON sls.employeeId = emp.employeeId
WHERE
      emp.title = 'Sales Person'
GROUP BY
      emp.employeeId
ORDER BY
      TtlNumbSales DESC;


-- Checking selection of LEFT JOIN

SELECT *
FROM sales sls
LEFT JOIN employee emp
      ON sls.employeeId = emp.employeeId