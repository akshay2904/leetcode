# Write your MySQL query statement below
SELECT IFNULL((
    SELECT num
    FROM mynumbers
    GROUP BY num
    HAVING count(1) = 1
    ORDER BY num DESC
    LIMIT 0, 1), NULL) AS num