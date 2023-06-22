-- challenge **
-- Find all sales where the car purchased was electric
-- LEFT JOIN, WHERE, WHERE SUBQUERY


SELECT sls.salesId, sls.inventoryId, inv.modelId
FROM sales sls
LEFT JOIN inventory inv ON inv.inventoryId = sls.inventoryId
WHERE inv.modelId IN (
  SELECT modelId
  FROM model
  WHERE EngineType = 'Electric');