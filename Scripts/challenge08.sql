-- challenge ***
-- Report showing amount of sales per employee for each month in 2021, the goal in
-- this case is to return a report that shows the First Name and Last Name, and 
-- a new column for each month, showing the amount of sales for the respective
-- employee.
-- PRAGMA table_info(), CTE, LEFT JOIN, WHERE, GROUP BY, ORDER BY


-- Try00 challenge08(v1) - now deleted (broken)
-- challenge ***
-- Report showing amount of sales per employee for each month in 2021
-- CTE, LEFT JOIN, WHERE, GROUP BY, ORDER BY
WITH SalesYear AS (
  SELECT
    emp.firstName AS 'FirstName',
    emp.lastName AS 'LastName',
    sls.soldDate AS 'Date',
    strftime('%Y', sls.soldDate) AS 'SoldYear',
    strftime('%m', sls.soldDate) AS 'SoldMonth',
    salesAmount AS 'Amount' 
  FROM sales sls
  LEFT JOIN employee emp
    ON emp.employeeId = sls.employeeId
)
SELECT
    FirstName,
    LastName,
    SoldMonth,
    SoldYear,
    FORMAT("$%.2f", sum(Amount)) AS 'MonthSales'
FROM SalesYear
WHERE SoldYear = '2021' AND SoldMonth = '01'
GROUP BY FirstName
ORDER BY FirstName ,SoldMonth



-- Try01 (broken)
SELECT
  emp.firstName, emp.lastName,
  CASE
    WHEN
      sls.salesAmount >= 0 AND
      sls.soldDate BETWEEN '2021-01-01 00:00:00' AND '2021-01-31 00:00:00'
    THEN
      ':)'
    ELSE 'NULL'
  END AS 'Jan21'
FROM employee emp
RIGHT JOIN sales sls
  ON sls.employeeId = emp.employeeId
GROUP BY emp.employeeId


-- Try02 (broken)
SELECT
  emp.firstName,
  emp.lastName,
  CASE
    WHEN
      --sl.salesAmount > 0 AND
      --strftime('%Y', sl.soldDate) = '2021' AND
      strftime('%m', sl.soldDate) = '02'
    THEN sum(sl.salesAmount)
    ELSE 'null'
  END AS 'SalesAmount'--,
  --strftime('%m', sl.soldDate) AS 'Month',
  --strftime('%Y', sl.soldDate) AS 'Year'
FROM employee emp
RIGHT JOIN sales sl
ON emp.employeeId = sl.employeeId
GROUP BY emp.firstName



-- Try03 (broken)
WITH salesBegin AS(
  SELECT
    employeeId AS 'EmpId',
    sum(salesAmount) AS 'SlAmount',
    strftime('%m', soldDate) AS 'Month'
  FROM sales
  WHERE strftime('%Y', soldDate) = '2021'
)
SELECT
  emp.firstName,
  emp.lastName,
  CASE
    WHEN sb.Month = '01' THEN sb.SlAmount
    ELSE '0'
  END AS 'SalesFeb'
FROM
salesBegin sb
LEFT JOIN employee emp
ON sb.EmpId = emp.employeeId
--ORDER BY emp.firstName
GROUP BY emp.firstName, emp.lastName



-- Answer challenge
-- 1. start with a query to get the data.
SELECT 
  emp.firstName, emp.lastName, sls.soldDate, sls.salesAmount
FROM
sales sls
INNER JOIN employee emp
  ON sls.employeeId = emp.employeeId
WHERE sls.soldDate >= '2021-01-01'
  AND sls.soldDate < '2022-01-01'

-- 2. implement case statements for each month
SELECT emp.firstName, emp.lastName,
  FORMAT("$%.2f", SUM(CASE WHEN strftime('%m', soldDate) = '01'
      THEN salesAmount END)) AS 'JanSales',
  FORMAT("$%.2f", SUM(CASE WHEN strftime('%m', soldDate) = '02'
      THEN salesAmount END)) AS 'FebSales',
  FORMAT("$%.2f", SUM(CASE WHEN strftime('%m', soldDate) = '03'
      THEN salesAmount END)) AS 'MarSales',
  FORMAT("$%.2f", SUM(CASE WHEN strftime('%m', soldDate) = '04'
      THEN salesAmount END)) AS 'AprSales',
  FORMAT("$%.2f", SUM(CASE WHEN strftime('%m', soldDate) = '05'
      THEN salesAmount END)) AS 'MaySales',
  FORMAT("$%.2f", SUM(CASE WHEN strftime('%m', soldDate) = '06'
      THEN salesAmount END)) AS 'JunSales',
  FORMAT("$%.2f", SUM(CASE WHEN strftime('%m', soldDate) = '07'
      THEN salesAmount END)) AS 'JulSales',
  FORMAT("$%.2f", SUM(CASE WHEN strftime('%m', soldDate) = '08'
      THEN salesAmount END)) AS 'AugSales',
  FORMAT("$%.2f", SUM(CASE WHEN strftime('%m', soldDate) = '09'
      THEN salesAmount END)) AS 'SepSales',
  FORMAT("$%.2f", SUM(CASE WHEN strftime('%m', soldDate) = '10'
      THEN salesAmount END)) AS 'OctSales',
  FORMAT("$%.2f", SUM(CASE WHEN strftime('%m', soldDate) = '11'
      THEN salesAmount END)) AS 'NovSales',
  FORMAT("$%.2f", SUM(CASE WHEN strftime('%m', soldDate) = '12'
      THEN salesAmount END)) AS 'DecSales'
FROM
sales sls
INNER JOIN employee emp
  ON sls.employeeId = emp.employeeId
WHERE sls.soldDate >= '2021-01-01'
  AND sls.soldDate < '2022-01-01'
GROUP BY emp.firstName, emp.lastName
ORDER BY emp.lastName, emp.firstName


-- Check the data type inside a table
PRAGMA table_info(sales)


-- Checking amount of lines, distinct EmployeeIDs (37), as well as total lines in sales (386)
SELECT
  --DISTINCT employeeId
  *
FROM sales
ORDER BY employeeId