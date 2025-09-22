WITH SessionMetrics AS (
    SELECT
        session_id,
        user_id,
        TIMESTAMPDIFF(MINUTE, MIN(event_timestamp), MAX(event_timestamp)) AS session_duration_minutes,
        SUM(CASE WHEN event_type = 'scroll' THEN 1 ELSE 0 END) AS scroll_count,
        SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) AS click_count,
        SUM(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchase_count
    FROM
        app_events
    GROUP BY
        session_id, user_id
)
SELECT
    session_id,
    user_id,
    session_duration_minutes,
    scroll_count
FROM
    SessionMetrics
WHERE
    session_duration_minutes > 30
    AND scroll_count >= 5    AND purchase_count = 0
    AND (CAST(click_count AS DECIMAL) / scroll_count) < 0.20
ORDER BY
    scroll_count DESC,
    session_id ASC;
