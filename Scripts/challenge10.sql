-- challenge ****
-- get a list of sales people and rank the car models they've sold the most.
-- Window Function:
-- AGGREGATION FUNCTIONS: AVG(), MIN(), MAX(), SUM(), COUNT()
-- RANKING FUNCTIONS: ROW_NUMBER(), RANK(), DENSE_RANK(), PERCENT_RANK(), NTILE()
-- VALUE FUNCTIONs:



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
  COUNT(sls.salesAmount) OVER (PARTITION BY emp.employeeId) AS 'CountSls'
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


-- TEST02: Testing window function: VALUE FUNCTIONS
-- LAG(), 