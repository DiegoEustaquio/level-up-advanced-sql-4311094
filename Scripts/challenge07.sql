-- challenge **
-- Report showing total sales per year
-- Common table expression (CTE), FORMAT(), strftime(), FORMAT(), GROUP BY, ORDER BY

WITH TotalSalesYear AS (
    SELECT
      strftime('%Y', soldDate) AS 'SoldYear',
      salesAmount
    FROM sales
)
SELECT
    SoldYear,
    FORMAT("$%.2f", sum(salesAmount)) AS 'AnnualSales'
FROM TotalSalesYear
GROUP BY SoldYear
ORDER BY SoldYear;