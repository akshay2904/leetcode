# Write your MySQL query statement below
SELECT product_name, SUM(unit) AS unit
FROM Products JOIN Orders
ON Products.product_id = Orders.product_id
where SUBSTRING(order_date, 1, 7) = '2020-02'
GROUP BY Products.product_id
HAVING SUM(unit)>=100