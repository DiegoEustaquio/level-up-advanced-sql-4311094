-- challenge ****
-- Generate a sales report showing total sales per month and an annual running tatal.
-- CTE, Window function: AGGREGATION FUNCTIONS: SUM(), COUNT()
-- Obs.: The GROUP BY and ORDER BY in the second query are key to the answer.


-- My answer:
SELECT salesId
  ,strftime('%Y', soldDate) AS 'SoldYear'
  ,strftime('%m', soldDate) AS 'SoldMonth'
  ,COUNT(salesId) OVER
    (PARTITION BY strftime('%m', soldDate), strftime('%Y', soldDate)) AS 'numbSlsMth'
  ,COUNT(salesId) OVER
    (PARTITION BY strftime('%Y', soldDate)) AS 'numbSlsYear'
  ,FORMAT("$%.2f", salesAmount) AS 'salesAmount'
  ,FORMAT("$%.2f", SUM(salesAmount) OVER
    (PARTITION BY strftime('%m', soldDate))) AS 'TtlSlsMonth'
  ,FORMAT("$%.2f", SUM(salesAmount) OVER
    (PARTITION BY strftime('%Y', soldDate))) AS 'TtlSlsYear'
FROM sales
ORDER BY soldDate


-- ...applying the running total sales per year:
WITH cte_salesYear AS(
  SELECT strftime('%Y', soldDate) AS 'soldYear'
    ,strftime('%m', soldDate) AS 'soldMonth'
    ,SUM(salesAmount) AS 'salesAmount'
  FROM sales
  GROUP BY soldYear, soldMonth
)
SELECT soldYear
  ,soldMonth
  ,salesAmount
  ,SUM(salesAmount) OVER (PARTITION BY soldYear
    ORDER BY soldYear, soldMonth) AS annualSales_runningTotal
FROM cte_salesYear
ORDER BY soldYear, soldMonth


-- Appling logic to the number of sales
WITH cte_numbSalesYear AS (
  SELECT strftime('%Y', soldDate) AS 'soldYear'
    ,strftime('%m', soldDate) AS 'soldMonth'
    ,COUNT(salesId) AS 'countSales'
  FROM sales
  GROUP BY soldYear, soldMonth
)
SELECT soldYear
  ,soldMonth
  ,countSales
  ,SUM(countSales) OVER
    (PARTITION BY soldYear ORDER BY soldYear, soldMonth) AS numbSales_runningYear
FROM cte_numbSalesYear
ORDER BY soldYear, soldMonth

