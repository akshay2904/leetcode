# Write your MySQL query statement below
SELECT customer_id
FROM customer_transactions
GROUP BY customer_id
HAVING
    SUM(CASE WHEN transaction_type = 'purchase' THEN 1 ELSE 0 END) > 2
    AND DATEDIFF(MAX(transaction_date), MIN(transaction_date)) > 29
        AND SUM(CASE WHEN transaction_type = 'refund' THEN 1 ELSE 0 END) / COUNT(*) < 0.2
ORDER BY
    customer_id;