WITH department_ranking AS (
SELECT Name AS Employee, Salary,DepartmentId,DENSE_RANK() OVER (PARTITION BY DepartmentId ORDER BY Salary DESC) AS rnk FROM Employee)
SELECT d.Name AS Department, r.Employee, r.Salary
FROM department_ranking AS r JOIN Department AS d
ON r.DepartmentId= d.Id
WHERE r.rnk <= 3
ORDER BY d.Name ASC, r.Salary DESC;