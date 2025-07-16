# Write your MySQL query statement below
select project_id,
ROUND(AVG(experience_years), 2) AS average_years
from project join employee using(employee_id) group by 1 