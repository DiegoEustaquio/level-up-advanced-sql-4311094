-- challenge **
-- Find the MIN and MAX of sales amount by employee, this year
-- LEFT JOIN, WHERE date(), GROUP BY, MIN(), MAX(), COUNT()

SELECT
      emp.employeeId,
      emp.firstName,
      emp.lastName,
      MIN(salesAmount) as 'CheapestSale(MIN)',
      MAX(salesAmount) as 'MostExpSale(MAX)',
      COUNT(*) as 'NumSales(COUNT)'
FROM sales sls
LEFT JOIN employee emp
      ON sls.employeeId = emp.employeeId
WHERE sls.soldDate >= date('now','start of year')
GROUP BY emp.employeeId