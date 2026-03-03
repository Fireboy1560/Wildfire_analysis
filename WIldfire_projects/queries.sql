
SELECT 
    COUNT(*) AS total_fires,
    SUM(FIRE_SIZE) AS total_acres_burned
FROM Fires;

SELECT 
    FIRE_YEAR,
    COUNT(*) AS number_of_fires,
    SUM(FIRE_SIZE) AS total_acres,
    AVG(FIRE_SIZE) AS avg_fire_size
FROM Fires
GROUP BY FIRE_YEAR
ORDER BY FIRE_YEAR;

SELECT 
    STAT_CAUSE_DESCR AS cause,
    COUNT(*) AS fire_count,
    SUM(FIRE_SIZE) AS total_acres,
    AVG(FIRE_SIZE) AS avg_size
FROM Fires
GROUP BY STAT_CAUSE_DESCR
ORDER BY fire_count DESC;


SELECT 
    STAT_CAUSE_DESCR,
    COUNT(*) AS fire_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM Fires
GROUP BY STAT_CAUSE_DESCR
ORDER BY fire_count DESC;

SELECT 
    STATE,
    COUNT(*) AS fire_count,
    SUM(FIRE_SIZE) AS total_acres
FROM Fires
WHERE STATE IS NOT NULL AND STATE != ''
GROUP BY STATE
ORDER BY fire_count DESC
LIMIT 10;

SELECT 
    STATE,
    AVG(FIRE_SIZE) AS avg_size
FROM Fires
GROUP BY STATE
ORDER BY avg_size DESC
LIMIT 10;

SELECT 
    strftime('%m', DISCOVERY_DATE) AS month,
    COUNT(*) AS fire_count
FROM Fires
WHERE DISCOVERY_DATE IS NOT NULL
GROUP BY month
ORDER BY month;

SELECT 
    strftime('%m', DISCOVERY_DATE) AS month,
    COUNT(*) AS fire_count,
    AVG(FIRE_SIZE) AS avg_size
FROM Fires
WHERE DISCOVERY_DATE IS NOT NULL
GROUP BY month
ORDER BY avg_size DESC;

SELECT 
    FIRE_SIZE_CLASS,
    COUNT(*) AS fires,
    SUM(FIRE_SIZE) AS total_acres
FROM Fires
GROUP BY FIRE_SIZE_CLASS
ORDER BY FIRE_SIZE_CLASS;

SELECT 
    FIRE_NAME,
    STATE,
    FIRE_YEAR,
    FIRE_SIZE,
    STAT_CAUSE_DESCR
FROM Fires
ORDER BY FIRE_SIZE DESC
LIMIT 5;

SELECT *
FROM (
    SELECT 
        FIRE_YEAR,
        FIRE_NAME,
        FIRE_SIZE,
        ROW_NUMBER() OVER (PARTITION BY FIRE_YEAR ORDER BY FIRE_SIZE DESC) AS rn
    FROM Fires
) 
WHERE rn = 1;