WITH cte AS (
    SELECT
        user_id,
        course_name AS first_course,
        LEAD(course_name) OVER (
            PARTITION BY user_id
            ORDER BY completion_date
        ) AS second_course,
        COUNT(*) OVER (PARTITION BY user_id) AS cnt,
        AVG(course_rating) OVER (PARTITION BY user_id) AS rating
    FROM course_completions
)
SELECT
    first_course,
    second_course,
    COUNT(*) AS transition_count
FROM cte
WHERE cnt > 4
  AND rating >= 4
  AND second_course IS NOT NULL
GROUP BY first_course, second_course
ORDER BY transition_count DESC, first_course, second_course;
