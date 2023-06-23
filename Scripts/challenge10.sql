-- challenge ****
-- get a list of sales people and rank the car models they've sold the most.













-- Testing window function. AVG() function
SELECT emp.lastName, sls.salesId, sls.salesAmount,
  AVG(sls.salesAmount) OVER (PARTITION BY emp.lastName) AS 'AvgSalesAmount'
FROM sales sls
LEFT JOIN employee emp
  ON sls.employeeId = emp.employeeId
--GROUP BY emp.lastName, emp.firstName
