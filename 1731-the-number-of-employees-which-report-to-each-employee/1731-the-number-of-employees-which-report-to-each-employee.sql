SELECT E1.employee_id, E1.name, COUNT(E2.employee_id) as reports_count, round(avg(E2.age)) AS average_age
FROM Employees E1
INNER JOIN Employees E2
ON E1.employee_id = E2.reports_to
group by E1.employee_id
order by E1.employee_id