-- challenge *
-- Create a list of employees and their immediate managers.
-- INNER JOIN

SELECT
      emp.firstName AS 'emp.firstName',
      emp.lastName AS 'emp.lastName',
      emp.title AS 'emp.title',
      mng.firstName AS 'man.firstName',
      mng.lastName AS 'man.lastName'
FROM employee emp
INNER JOIN employee mng
      ON emp.managerId = mng.employeeId
ORDER BY mng.firstName;
