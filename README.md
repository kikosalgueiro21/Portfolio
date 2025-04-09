# SQL Network Uptime Monitor Portfolio Project

## Description

This is an SQL portfolio project aimed at monitoring and analyzing network uptime and downtime for multiple servers. The project utilizes SQL to aggregate uptime and downtime data, calculate uptime percentages, and retrieve meaningful insights about server health. 

This project demonstrates the ability to design and query a relational database, using MySQL for the backend.

## Database Schema

- **network_uptime**: Stores data about the uptime and downtime of each server.
- **server_details**: Contains additional details about the servers, such as location and type.

### Example Tables:

- network_uptime:  
  - server_id: ID of the server (foreign key to server_details).
  - server_name: Name of the server.
  - status_code: 1 for up, 0 for down.
  - timestamp: Date and time of the status change.
  - total_uptime: Time the server was up (in seconds).
  - total_downtime: Time the server was down (in seconds).

- server_details:  
  - server_id: ID of the server.
  - server_name: Name of the server.
  - location: The physical location of the server (e.g., "New York", "London").
  - server_type: Type of server (e.g., "Database", "Web Server").




## Queries

## Queries 
USE network_uptime;
USE server_details;


## Retrieving every piece of data and overall structure from the table.
SELECT 
    *
FROM
    network;

## Counting Status. Grouping 
SELECT 
    status_code, COUNT(status_code)
FROM
    network
GROUP BY status_code;

## Total Uptime and Downtime Per Server + net uptime (Uptime-Downtime) + % of uptime.

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

## Orders servers with most downtime by descending order
SELECT 
    server_name, SUM(total_downtime) AS total_downtime
FROM
    network
GROUP BY server_name
ORDER BY total_downtime DESC;

## Same but for most downtime
SELECT 
    server_name, SUM(total_uptime) AS total_uptime
FROM
    network
GROUP BY server_name
ORDER BY total_uptime DESC;

## Identifies servers that had 0 downtime
SELECT 
    server_name
FROM
    network
GROUP BY server_name
HAVING SUM(total_downtime) = 0;

## Uptime Percentage Over Time (By day)
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


## Total Uptime by Server Location descending Order (INNER JOIN)

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
    
    ## Total Downtime by Server ascending order.
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

## Count of Status Changes for Each Server by location and name.

SELECT 
    server_details.server_name,
    server_details.location,
    COUNT(*) AS status_changes
FROM
    network
        JOIN
    server_details ON network.server_id = server_details.server_id
GROUP BY server_details.location , server_details.server_name;

   

## Usage

1. Create the database:

sql
   CREATE DATABASE network_monitor;
   

2. Import the schema and data:

sql
   SOURCE setup.sql;
   

3. Run the queries to retrieve network uptime information.

## Installation

1. Install MySQL (if not already installed).
2. Clone this repository:

bash
   git clone https://github.com/yourusername/SQL-Portfolio.git
   

3. Import the database schema and data by running `setup.sql` file.

4. Execute the queries to see results.

## License

This project is licensed under the MIT License. 