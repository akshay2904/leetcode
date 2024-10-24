# Write your MySQL query statement below
select id, case when p_id is null then 'Root' 
when id IN (SELECT p_id FROM Tree)THEN 'Inner'
        ELSE 'Leaf' end as type from tree