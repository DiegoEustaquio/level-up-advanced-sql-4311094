-- challenge ***
-- Report showing amount of sales per employee for each month in 2021
-- 

WITH SalesYear AS (
  SELECT
    emp.employeeId AS 'empID',
    emp.firstName AS 'FistName',
    emp.lastName AS 'LastName',
    strftime('%Y', sls.soldDate) AS 'SoldYear',
    strftime('%M', sls.soldDate) AS 'SoldMonth',
    salesAmount
  FROM sales sls
  LEFT JOIN employee emp
    ON emp.employeeId = sls.employeeId
WHERE SoldYear = 2021
)
SELECT
    empID,
    FistName,
    LastName,
    SoldMonth,
    FORMAT("$%.2f", sum(salesAmount)) AS 'MonthSales'
FROM SalesYear
GROUP BY empID