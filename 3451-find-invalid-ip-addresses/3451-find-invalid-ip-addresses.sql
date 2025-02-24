SELECT 
    ip,
    COUNT(*) AS invalid_count
FROM 
    logs
WHERE 
    -- Check for invalid number of octets
    (
        LENGTH(ip) - LENGTH(REPLACE(ip, '.', '')) != 3 -- Ensures exactly 3 dots
    )
    OR 
    (
        -- Check each octet for invalidity
        CASE 
            WHEN ip NOT REGEXP '^[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+$' THEN 1  -- Ensure only digits and dots
            WHEN CAST(SUBSTRING_INDEX(ip, '.', 1) AS UNSIGNED) > 255 THEN 1 
            WHEN LENGTH(SUBSTRING_INDEX(ip, '.', 1)) > 1 AND SUBSTRING_INDEX(ip, '.', 1) LIKE '0%' THEN 1 
            WHEN CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 2), '.', -1) AS UNSIGNED) > 255 THEN 1
            WHEN LENGTH(SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 2), '.', -1)) > 1 AND SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 2), '.', -1) LIKE '0%' THEN 1 
            WHEN CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 3), '.', -1) AS UNSIGNED) > 255 THEN 1
            WHEN LENGTH(SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 3), '.', -1)) > 1 AND SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 3), '.', -1) LIKE '0%' THEN 1 
            WHEN CAST(SUBSTRING_INDEX(ip, '.', -1) AS UNSIGNED) > 255 THEN 1 
            WHEN LENGTH(SUBSTRING_INDEX(ip, '.', -1)) > 1 AND SUBSTRING_INDEX(ip, '.', -1) LIKE '0%' THEN 1 
            ELSE 0 
        END = 1
    )
GROUP BY 
    ip
ORDER BY 
    invalid_count DESC, 
    ip DESC;
