-- challenge *
-- Select all the sales from the sales and customer tables
-- UNION, INNER JOIN, LEFT JOIN

SELECT
      ctmr.firstName, ctmr.lastName, ctmr.email,
      sls.salesId, sls.salesAmount, sls.soldDate
FROM customer ctmr
INNER JOIN sales sls
      ON  ctmr.customerId = sls.customerId
UNION

-- Select all the data missing from the customer table, by selecting NULL sales

SELECT
      ctmr.firstName, ctmr.lastName, ctmr.email,
      sls.salesId, sls.salesAmount, sls.soldDate
FROM customer ctmr
LEFT JOIN sales sls
      ON  ctmr.customerId = sls.customerId
WHERE sls.salesId IS NULL
UNION

-- Select all the data missing from the sales table, by selecting NULL sales

SELECT
      ctmr.firstName, ctmr.lastName, ctmr.email,
      sls.salesId, sls.salesAmount, sls.soldDate
FROM sales sls
LEFT JOIN customer ctmr
      ON  ctmr.customerId = sls.customerId
WHERE sls.salesId IS NULL
ORDER BY sls.salesId