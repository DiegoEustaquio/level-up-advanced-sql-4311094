-- challenge ****
-- create a report that shows the number of cars sold this month, and last month.
-- CTE, Window function: VALUE FUNCTIONS: LAG(), including a variation of WINDOW FUNCTION

WITH cte_salesPrevMonth AS(
  SELECT strftime('%Y', soldDate) AS 'soldYear'
    ,strftime('%m', soldDate) AS 'soldMonth'
    ,COUNT(salesId) AS 'salesCurrentMonth'
  FROM sales
  GROUP BY soldYear, soldMonth
)
SELECT soldYear
  ,soldMonth
  ,salesCurrentMonth
  ,LAG(salesCurrentMonth, 1, 0) OVER (PARTITION BY soldYear
  ORDER BY soldYear, soldMonth) AS 'salesPrevMonth'
FROM cte_salesPrevMonth
ORDER BY soldYear, soldMonth


-- Applying a counter to compare to the previous month
WITH cte_salesPrevMonth AS(
  SELECT strftime('%Y', soldDate) AS 'soldYear'
    ,strftime('%m', soldDate) AS 'soldMonth'
    ,COUNT(salesId) AS 'salesCurrentMonth'
  FROM sales
  GROUP BY soldYear, soldMonth
)
SELECT soldYear
  ,soldMonth
  ,salesCurrentMonth
  ,LAG(salesCurrentMonth) OVER (PARTITION BY soldYear
  ORDER BY soldYear, soldMonth) AS 'salesPrevMonth'
  ,(salesCurrentMonth - LAG(salesCurrentMonth) OVER (PARTITION BY soldYear
  ORDER BY soldYear, soldMonth)) AS 'difference'
FROM cte_salesPrevMonth
ORDER BY soldYear, soldMonth



-- A different approach to the challenge:
-- This approach is even more interesting as it takes into account the number of the
-- last month of the previous year, in the first month of the next year.
-- Note the format of the date.
SELECT strftime('%Y-%m', soldDate) AS 'monthSold'
  ,COUNT(*) AS 'numberCarsSold'
  ,LAG(COUNT(*), 1, 0) OVER calMonth AS lastMonthCarsSold
FROM sales
GROUP BY strftime('%Y-%m', soldDate)
WINDOW calMonth AS (ORDER BY strftime('%Y-%m', soldDate))
ORDER BY strftime('%Y-%m', soldDate)