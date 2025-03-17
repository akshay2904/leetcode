SELECT user_id AS buyer_id, join_date, COALESCE(a.orders_in_2019, 0) AS orders_in_2019
FROM users
LEFT JOIN
(
    SELECT buyer_id, COALESCE(COUNT(*), 0) AS orders_in_2019
    FROM orders o
    JOIN users u
    ON u.user_id = o.buyer_id
    WHERE YEAR(order_date) = 2019
    GROUP BY buyer_id
) a
ON users.user_id = a.buyer_id;
