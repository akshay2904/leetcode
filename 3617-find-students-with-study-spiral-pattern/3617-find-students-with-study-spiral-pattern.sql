WITH RankedSessions AS (
    SELECT ss.*,
        LAG(session_date) OVER (PARTITION BY student_id ORDER BY session_date) AS prev_date
    FROM study_sessions ss
),
SessionGroups AS (
    SELECT *,
        SUM(CASE WHEN prev_date IS NULL
                   OR DATEDIFF(DAY, prev_date, session_date) > 2
                 THEN 1 ELSE 0 END)
            OVER (PARTITION BY student_id ORDER BY session_date) AS grp
    FROM RankedSessions
),
Streaks AS (
    SELECT *,
        COUNT(*)           OVER (PARTITION BY student_id, grp) AS total_cnt,
        SUM(hours_studied) OVER (PARTITION BY student_id, grp) AS total_hours,
        LEAD(subject, 3) OVER (PARTITION BY student_id, grp ORDER BY session_date) AS s3,
        LEAD(subject, 4) OVER (PARTITION BY student_id, grp ORDER BY session_date) AS s4,
        LEAD(subject, 5) OVER (PARTITION BY student_id, grp ORDER BY session_date) AS s5,
        LEAD(subject, 6) OVER (PARTITION BY student_id, grp ORDER BY session_date) AS s6
    FROM SessionGroups
),
PatternCheck AS (
    SELECT student_id, grp, k.cycle_length, MAX(total_hours) AS total_hours
    FROM Streaks
    CROSS APPLY (VALUES (3, s3), (4, s4), (5, s5), (6, s6)) k(cycle_length, nxt)
    WHERE total_cnt >= k.cycle_length * 2
    GROUP BY student_id, grp, k.cycle_length
    HAVING COUNT(CASE WHEN nxt IS NOT NULL AND subject <> nxt THEN 1 END) = 0
)
SELECT
    s.student_id, s.student_name, s.major,
    p.cycle_length, p.total_hours AS total_study_hours
FROM PatternCheck p
JOIN students s ON s.student_id = p.student_id
ORDER BY p.cycle_length DESC, total_study_hours DESC;