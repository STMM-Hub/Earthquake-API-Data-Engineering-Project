-- This is auto-generated code
SELECT
    TOP 10 *
FROM
    OPENROWSET(
        BULK 'https://earthquakedatadb.dfs.core.windows.net/gold/earthquake_events_gold/**',
        FORMAT = 'PARQUET'
    ) AS [result]

-- Basic Summary Statistics
SELECT 
    COUNT(*) AS Total_Events,
    MIN(mag) AS Min_Magnitude,
    MAX(mag) AS Max_Magnitude,
    AVG(mag) AS Avg_Magnitude
FROM OPENROWSET(
    BULK 'https://earthquakedatadb.dfs.core.windows.net/gold/earthquake_events_gold/**',
    FORMAT = 'PARQUET'
) AS [result];

-- Frequency of Earthquakes by Country
SELECT 
    country_name,
    COUNT(*) AS Earthquake_Count
FROM OPENROWSET(
    BULK 'https://earthquakedatadb.dfs.core.windows.net/gold/earthquake_events_gold/**',
    FORMAT = 'PARQUET'
) AS [result]
GROUP BY country_name
ORDER BY Earthquake_Count DESC;

-- Yearly Earthquake Trend
SELECT 
    YEAR(time) AS Event_Year,
    COUNT(*) AS Earthquake_Count
FROM OPENROWSET(
    BULK 'https://earthquakedatadb.dfs.core.windows.net/gold/earthquake_events_gold/**',
    FORMAT = 'PARQUET'
) AS [result]
GROUP BY YEAR(time)
ORDER BY Event_Year;

-- Earthquake Magnitude Distribution
SELECT 
    CASE 
        WHEN mag < 4 THEN 'Minor (<4)'
        WHEN mag BETWEEN 4 AND 4.9 THEN 'Light (4-4.9)'
        WHEN mag BETWEEN 5 AND 5.9 THEN 'Moderate (5-5.9)'
        WHEN mag BETWEEN 6 AND 6.9 THEN 'Strong (6-6.9)'
        ELSE 'Major (>=7)'
    END AS Magnitude_Category,
    COUNT(*) AS Count
FROM OPENROWSET(
    BULK 'https://earthquakedatadb.dfs.core.windows.net/gold/earthquake_events_gold/**',
    FORMAT = 'PARQUET'
) AS [result]
GROUP BY 
    CASE 
        WHEN mag < 4 THEN 'Minor (<4)'
        WHEN mag BETWEEN 4 AND 4.9 THEN 'Light (4-4.9)'
        WHEN mag BETWEEN 5 AND 5.9 THEN 'Moderate (5-5.9)'
        WHEN mag BETWEEN 6 AND 6.9 THEN 'Strong (6-6.9)'
        ELSE 'Major (>=7)'
    END;

-- Top 10 Strongest Earthquakes
SELECT TOP 10
    time,
    country_name,
    mag,
    depth
FROM OPENROWSET(
    BULK 'https://earthquakedatadb.dfs.core.windows.net/gold/earthquake_events_gold/**',
    FORMAT = 'PARQUET'
) AS [result]
ORDER BY mag DESC;

-- Average Depth by Country
SELECT 
    country_name,
    AVG(depth) AS Avg_Depth
FROM OPENROWSET(
    BULK 'https://earthquakedatadb.dfs.core.windows.net/gold/earthquake_events_gold/**',
    FORMAT = 'PARQUET'
) AS [result]
GROUP BY country_name
ORDER BY Avg_Depth DESC;

-- Earthquake Count by Depth Range
SELECT 
    CASE 
        WHEN depth < 70 THEN 'Shallow (<70km)'
        WHEN depth BETWEEN 70 AND 300 THEN 'Intermediate (70-300km)'
        ELSE 'Deep (>300km)'
    END AS Depth_Category,
    COUNT(*) AS Count
FROM OPENROWSET(
    BULK 'https://earthquakedatadb.dfs.core.windows.net/gold/earthquake_events_gold/**',
    FORMAT = 'PARQUET'
) AS [result]
GROUP BY 
    CASE 
        WHEN depth < 70 THEN 'Shallow (<70km)'
        WHEN depth BETWEEN 70 AND 300 THEN 'Intermediate (70-300km)'
        ELSE 'Deep (>300km)'
    END;

-- Monthly Seasonality of Earthquakes
SELECT 
    MONTH(time) AS Event_Month,
    COUNT(*) AS Earthquake_Count
FROM OPENROWSET(
    BULK 'https://earthquakedatadb.dfs.core.windows.net/gold/earthquake_events_gold/**',
    FORMAT = 'PARQUET'
) AS [result]
GROUP BY MONTH(time)
ORDER BY Event_Month;


