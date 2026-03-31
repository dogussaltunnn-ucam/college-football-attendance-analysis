SELECT name
FROM sqlite_master
WHERE type = 'table';
SELECT COUNT(*) AS total_rows
FROM "games_attendance";
SELECT name
FROM sqlite_master
WHERE type = 'table';
SELECT COUNT(*) AS total_rows
FROM "CFBeattendance";
SELECT *
FROM "CFBeattendance"
LIMIT 10;
PRAGMA table_info("CFBeattendance");
ALTER TABLE "CFBeattendance" RENAME TO games_attendance;
SELECT 
    COUNT(*) AS total_games,
    SUM(Attendance) AS total_attendance,
    ROUND(AVG(Attendance), 0) AS avg_attendance,
    MAX(Attendance) AS max_attendance,
    MIN(Attendance) AS min_attendance
FROM games_attendance;
SELECT
    SUBSTR(Date, LENGTH(Date) - 3, 4) AS season_year,
    COUNT(*) AS total_games,
    ROUND(AVG(Attendance), 0) AS avg_attendance
FROM games_attendance
GROUP BY season_year
ORDER BY season_year;
SELECT
    Team,
    COUNT(*) AS total_games,
    ROUND(AVG(Attendance), 0) AS avg_attendance
FROM games_attendance
GROUP BY Team
HAVING COUNT(*) >= 20
ORDER BY avg_attendance DESC
LIMIT 15;
SELECT
    CASE
        WHEN Opponent LIKE 'No.%' THEN 'Ranked Opponent'
        ELSE 'Unranked Opponent'
    END AS opponent_type,
    COUNT(*) AS total_games,
    ROUND(AVG(Attendance), 0) AS avg_attendance
FROM games_attendance
GROUP BY opponent_type
ORDER BY avg_attendance DESC;
SELECT
    CASE
        WHEN Time LIKE '%AM' THEN 'Day Game'
        WHEN Time LIKE '12:% PM' OR Time LIKE '1:% PM' OR Time LIKE '2:% PM' THEN 'Afternoon'
        WHEN Time LIKE '3:% PM' OR Time LIKE '4:% PM' OR Time LIKE '5:% PM' THEN 'Late Afternoon'
        ELSE 'Evening'
    END AS time_bucket,
    COUNT(*) AS total_games,
    ROUND(AVG(Attendance), 0) AS avg_attendance
FROM games_attendance
GROUP BY time_bucket
ORDER BY avg_attendance DESC;
SELECT
    Date,
    Team,
    Opponent,
    Attendance,
    Result
FROM games_attendance
ORDER BY Attendance DESC
LIMIT 15;