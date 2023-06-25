-- challenge ****
-- get a list of sales people and rank the car models they've sold the most.
-- Window Function:
-- AGGREGATION FUNCTIONS: AVG(), MIN(), MAX(), SUM(), COUNT()
-- RANKING FUNCTIONS: ROW_NUMBER(), RANK(), DENSE_RANK(), PERCENT_RANK(), NTILE()
-- VALUE FUNCTIONS: LAG(), LEAD(), FIRST_VALUE(), NTH_VALUE()


-- TEST01: Testing window function: AGGREGATION FUNCTIONS
-- AVG(), MIN(), MAX(), SUM(), COUNT()
SELECT emp.employeeId AS EmpID,
  sls.salesId AS SlID,
  emp.managerId AS MngrID,
  FORMAT("$%.2f", sls.salesAmount) AS salesAmount,
  FORMAT("$%.2f", AVG(sls.salesAmount)
    OVER (PARTITION BY emp.employeeId)) AS 'AvgSlAmt',
  FORMAT("$%.2f", MAX(sls.salesAmount)
    OVER (PARTITION BY emp.employeeId)) AS 'MaxSlAmt',
  FORMAT("$%.2f", MIN(sls.salesAmount)
    OVER (PARTITION BY emp.employeeId)) AS 'MinSlAmt',
  FORMAT("$%.2f", SUM(sls.salesAmount)
    OVER (PARTITION BY emp.employeeId)) AS 'TtlSlAmt',
  COUNT(sls.salesAmount)
    OVER (PARTITION BY emp.employeeId) AS 'CountSls'
FROM sales sls
LEFT JOIN employee emp
  ON sls.employeeId = emp.employeeId
ORDER BY emp.employeeId


-- TEST02: Testing window function: RANKING FUNCTIONS
-- ROW_NUMBER()
-- RANK(), it's hard to see the difference of RANK() and ROW_NUMBER() in this case,
-- because the car sales amounts are hardly the same.
-- RANK() split a position into two or more numbers if the value in the column
-- being compared is the exact same, and continue the rank list considering
-- one position. DENSE_RANK() would then do the same as RANK() but making the
-- list continue from the position left.
-- PERCENT_RANK() uses the total amount and split the percent of each amount
-- compared to the total amount in the list.
-- NTILE() uses a number of "buckets" that you can specify for the list
-- to be devided and then categorize each row in one of these buckets.
SELECT emp.employeeId AS EmpID,
  sls.salesId AS SlID,
  emp.managerId AS MngrID,
  sls.salesAmount AS SlAmt,
  ROW_NUMBER() OVER (PARTITION BY emp.employeeId
  ORDER BY sls.salesAmount DESC) AS 'SlAmtRowN',
  RANK() OVER (PARTITION BY emp.employeeId
  ORDER BY sls.salesAmount DESC) AS 'SlAmtRank',
  FORMAT("%.2f", PERCENT_RANK() OVER (PARTITION BY emp.employeeId
  ORDER BY sls.salesAmount DESC)) AS 'SlAmt%',
  NTILE(4) OVER (PARTITION BY emp.employeeId
  ORDER BY sls.salesAmount DESC) AS 'SlAmtBckts'
FROM sales sls
LEFT JOIN employee emp
  ON sls.employeeId = emp.employeeId


-- TEST03: Testing window function: VALUE FUNCTIONS
-- This window function is used to compare the rows of a specific
-- column with the rows that come before (LAG) and after (LEAD).
-- LAG()
SELECT emp.employeeId AS EmpID,
  sls.salesId AS SlID,
  emp.managerId AS MngrID,
  sls.salesAmount AS SlAmt,
  LAG(sls.salesAmount) OVER (PARTITION BY emp.employeeId
  ORDER BY sls.salesAmount) AS 'LAG'
FROM sales sls
LEFT JOIN employee emp
  ON sls.employeeId = emp.employeeId

-- LEAD()
SELECT emp.employeeId AS EmpID,
  sls.salesId AS SlID,
  emp.managerId AS MngrID,
  sls.salesAmount AS SlAmt,
  LEAD(sls.salesAmount) OVER (PARTITION BY emp.employeeId
  ORDER BY sls.salesAmount) AS 'LEAD'
FROM sales sls
LEFT JOIN employee emp
  ON sls.employeeId = emp.employeeId

-- FIRST_VALUE()
SELECT emp.employeeId AS EmpID,
  sls.salesId AS SlID,
  emp.managerId AS MngrID,
  sls.salesAmount AS SlAmt,
  FIRST_VALUE(sls.salesAmount) OVER (PARTITION BY emp.employeeId
  ORDER BY sls.salesAmount) AS 'FirstValue'
FROM sales sls
LEFT JOIN employee emp
  ON sls.employeeId = emp.employeeId

-- NTH_VALUE() Compares a specific column with the amount of the 'NthValue'
-- of the column itself.
  SELECT emp.employeeId AS EmpID,
  sls.salesId AS SlID,
  emp.managerId AS MngrID,
  sls.salesAmount AS SlAmt,
  NTH_VALUE(sls.salesAmount, 5) OVER (PARTITION BY emp.employeeId
  ORDER BY sls.salesAmount) AS 'NthValue'
FROM sales sls
LEFT JOIN employee emp
  ON sls.employeeId = emp.employeeId




-- Back to the challenge...
-- get a list of sales people and rank the car models they've sold the most.
SELECT emp.employeeId AS 'empId'
  ,emp.firstName AS 'firstName'
  ,emp.lastName AS 'lastName'
  ,mdl.model AS 'carModel'
  ,COUNT(mdl.model) AS 'countMdlSold'
  ,RANK() OVER (PARTITION BY emp.employeeId
    ORDER BY COUNT(mdl.model) DESC) AS 'ModelRank'
FROM employee emp
  INNER JOIN sales sls ON emp.employeeId = sls.employeeId
  INNER JOIN inventory inv ON sls.inventoryId = inv.inventoryId
  INNER JOIN model mdl ON inv.modelId = mdl.modelId
GROUP BY emp.firstName, emp.lastName , mdl.model
ORDER BY emp.firstName, emp.lastName


