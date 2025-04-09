-- database creation
CREATE DATABASE network_uptime;
USE network_uptime;
-- Uptime table
CREATE TABLE network (
    server_id INT,
    server_name VARCHAR(100),
    status_code INT,
    timestamp DATETIME,
    total_uptime INT,
    total_downtime INT
);

-- Insert sample data
INSERT INTO network (server_id, server_name, status_code, timestamp, total_uptime, total_downtime)
VALUES 
(1, 'Server_A', 1, '2025-04-09 08:00:00', 3600, 0),  -- Server A up for 1 hour
(1, 'Server_A', 0, '2025-04-09 09:00:00', 0, 1800),  -- Server A down for 30 minutes
(1, 'Server_A', 1, '2025-04-09 09:30:00', 3600, 0),  -- Server A back up for 1 hour
(2, 'Server_B', 1, '2025-04-09 08:00:00', 3600, 0),  -- Server B up for 1 hour
(2, 'Server_B', 0, '2025-04-09 09:00:00', 0, 1800),  -- Server B down for 30 minutes
(2, 'Server_B', 1, '2025-04-09 09:30:00', 3600, 0),  -- Server B back up for 1 hour
(3, 'Server_C', 1, '2025-04-09 08:00:00', 3600, 0),  -- Server C up for 1 hour
(3, 'Server_C', 1, '2025-04-09 09:00:00', 3600, 0),  -- Server C up for 1 more hour
(4, 'Server_D', 0, '2025-04-09 08:00:00', 0, 3600),  -- Server D down for 1 hour
(4, 'Server_D', 1, '2025-04-09 09:00:00', 3600, 0);  -- Server D back up for 1 hour

USE server_details;
-- Server Details
CREATE TABLE server_details (
    server_id INT PRIMARY KEY,
    server_name VARCHAR(100),
    location VARCHAR(100),
    os VARCHAR(50),
    purpose VARCHAR(100),
    purchase_date DATE
);

INSERT INTO server_details (server_id, server_name, location, os, purpose, purchase_date)
VALUES
(1, 'Server_A', 'Portugal', 'Linux', 'Web Server', '2023-01-15'),
(2, 'Server_B', 'China', 'Windows', 'Database Server', '2022-07-25'),
(3, 'Server_C', 'France', 'Linux', 'File Server', '2021-05-30'),
(4, 'Server_D', 'Japan', 'Windows', 'Backup Server', '2020-10-05');





