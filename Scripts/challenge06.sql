-- challenge **
-- List of Sales People with more than 5 sales this year
-- LEFT JOIN, WHERE, GROUP BY, MIN(), MAX(), COUNT(), HAVING

SELECT
      emp.employeeId,
      emp.firstName,
      emp.lastName,
      MIN(salesAmount) as 'CheapestSale(MIN)',
      MAX(salesAmount) as 'MostExpSale(MAX)',
      COUNT(*) AS NumbOfSales
FROM sales sls
LEFT JOIN employee emp
      ON sls.employeeId = emp.employeeId
WHERE sls.soldDate >= date('now','start of year')
GROUP BY emp.employeeId
HAVING count(*) >= 5
