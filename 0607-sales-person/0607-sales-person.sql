# Write your MySQL query statement below
select s.name from salesperson s where s.name not in
(select s.name from salesperson s left join orders o on s.sales_id=o.sales_id
left join company c on c.com_id=o.com_id where c.name = 'RED')


