-- Queries for Network Uptime table
USE network_uptime;
USE server_details;


-- Retrieving every piece of data and overall structure from the table.
SELECT 
    *
FROM
    network;

-- Counting Status. Grouping 
SELECT 
    status_code, COUNT(status_code)
FROM
    network
GROUP BY status_code;

-- Total Uptime and Downtime Per Server + net uptime (Uptime-Downtime) + % of uptime.

SELECT 
    server_id,
    SUM(total_uptime) AS total_uptime,
    SUM(total_downtime) AS total_downtime,
    SUM(total_uptime) - SUM(total_downtime) AS net_uptime,
    ROUND(CASE
                WHEN (SUM(total_uptime) + SUM(total_downtime)) = 0 THEN 0
                ELSE (SUM(total_uptime) / (SUM(total_uptime) + SUM(total_downtime))) * 100
            END,
            2) AS uptime_percentage
FROM
    network
GROUP BY server_id;

-- Orders servers with most downtime by descending order
SELECT 
    server_name, SUM(total_downtime) AS total_downtime
FROM
    network
GROUP BY server_name
ORDER BY total_downtime DESC;

-- Same but for most  uptime
SELECT 
    server_name, SUM(total_uptime) AS total_uptime
FROM
    network
GROUP BY server_name
ORDER BY total_uptime DESC;

-- Identifies servers that had 0 downtime
SELECT 
    server_name
FROM
    network
GROUP BY server_name
HAVING SUM(total_downtime) = 0;

-- Uptime Percentage Over Time (By day)
SELECT 
    server_name,
    DATE(timestamp) AS day,
    SUM(total_uptime) AS total_uptime,
    SUM(total_downtime) AS total_downtime,
    CASE
        WHEN (SUM(total_uptime) + SUM(total_downtime)) = 0 THEN 0
        ELSE (SUM(total_uptime) / (SUM(total_uptime) + SUM(total_downtime))) * 100
    END AS uptime_percentage
FROM
    network
GROUP BY server_name , day
ORDER BY day DESC;

-- Queries using 2 tables. 
-- Total Uptime by Server Location descending Order (INNER JOIN)

SELECT 
    server_details.server_name,
    server_details.location,
    SUM(network.total_uptime) AS total_uptime
FROM
    network
        JOIN
    server_details ON network.server_id = server_details.server_id
GROUP BY server_details.server_name , server_details.location
ORDER BY total_uptime DESC;
    
    -- Total Downtime by Server ascending order.
SELECT 
    server_details.server_name,
    server_details.location,
    SUM(network.total_downtime) AS total_downtime
FROM
    network
        JOIN
    server_details ON network.server_id = server_details.server_id
GROUP BY server_details.server_name , server_details.location
ORDER BY total_downtime ASC;

-- Count of Status Changes for Each Server by location and name.

SELECT 
    server_details.server_name,
    server_details.location,
    COUNT(*) AS status_changes
FROM
    network
        JOIN
    server_details ON network.server_id = server_details.server_id
GROUP BY server_details.location , server_details.server_name;



    
    
    










