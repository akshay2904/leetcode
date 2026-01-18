# Write your MySQL query statement below
/* Write your T-SQL query statement below */
with cte as (
select user_id,reaction as dominant_reaction ,
        count(*) over (partition by user_id ) as cnt  ,
        round(count(*) over (partition by user_id ,reaction  )*1.00
        /count(*) over (partition by user_id),2) as reaction_ratio 
from reactions) 

select distinct user_id ,dominant_reaction ,reaction_ratio 
from cte
where cnt >=5 and reaction_ratio >=0.6 
order by reaction_ratio desc ,user_id asc 