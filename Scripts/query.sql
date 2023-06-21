SELECT firstname, lastname, title
FROM employee
LIMIT 5;

GO

SELECT model, EngineType
FROM model
LIMIT 5;

GO

SELECT sql
FROM sqlite_schema
WHERE name = 'employee'
