# Write your MySQL query statement below
select round(sum(tiv_2016),2) as tiv_2016 from insurance
where tiv_2015 in (select tiv_2015 from insurance group by tiv_2015 having count(*)> 1)
AND (lat, lon) IN (SELECT lat, lon FROM Insurance GROUP BY lat, lon HAVING COUNT(*) = 1)