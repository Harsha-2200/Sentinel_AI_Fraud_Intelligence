-- ============================================================
-- SENTINEL AI — Day 8: SQL Schema Setup (Final, Verified Version)
-- ============================================================
-- This file sets up the SQL database, loads the cleaned transaction
-- data, and confirms everything loaded correctly.
-- Cleaning (filling missing values) was done in Python first, 
-- so this file loads data that is already clean.
-- ============================================================

-- ------------------------------------------------------------
-- Turn on settings needed to load a file from the computer
-- ------------------------------------------------------------
SET GLOBAL local_infile = 1;

-- ------------------------------------------------------------
-- Create a fresh database and select it
-- ------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS sentinel_ai;
USE sentinel_ai;

-- ------------------------------------------------------------
-- Remove old table if it exists, so we start clean
-- ------------------------------------------------------------
DROP TABLE IF EXISTS transactions;

-- ------------------------------------------------------------
-- Create the transactions table
-- Column order here MUST match the CSV file's column order exactly,
-- or data will load into the wrong columns
-- ------------------------------------------------------------
CREATE TABLE transactions (
    TransactionID INT PRIMARY KEY,
    isFraud INT,
    TransactionDT INT,
    TransactionAmt FLOAT,
    ProductCD VARCHAR(10),
    DeviceType VARCHAR(20),
    card1 INT,
    card2 FLOAT,
    card3 FLOAT,
    card4 VARCHAR(20),
    card5 FLOAT,
    card6 VARCHAR(20),
    addr1 FLOAT,
    addr2 FLOAT,
    dist1 FLOAT,
    dist2 FLOAT,
    C1 FLOAT,
    C2 FLOAT,
    C3 FLOAT,
    C4 FLOAT,
    hour INT
);

-- ------------------------------------------------------------
-- Load the cleaned CSV file into the table
-- ------------------------------------------------------------
LOAD DATA LOCAL INFILE 'C:/Users/harsh/python/Projects/IEEE-CIS project/Notebook/sample_transaction_cleaned.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- ------------------------------------------------------------
-- Check 1: Did all 25,000 rows load in?
-- ------------------------------------------------------------
SELECT COUNT(*) AS total_rows FROM transactions;

-- ------------------------------------------------------------
-- Check 2: Is TransactionID still unique for every row?
-- ------------------------------------------------------------
SELECT COUNT(*) AS total, COUNT(DISTINCT TransactionID) AS unique_ids 
FROM transactions;

-- ------------------------------------------------------------
-- Check 3: Did the fraud rate stay the same as before (around 3.5%)?
-- ------------------------------------------------------------
SELECT AVG(isFraud) * 100 AS fraud_rate FROM transactions;

-- ------------------------------------------------------------
-- Check 4: Are there any missing values left in the columns 
-- we cleaned earlier?
-- ------------------------------------------------------------
SELECT 
    SUM(CASE WHEN card2 IS NULL THEN 1 ELSE 0 END) AS null_card2,
    SUM(CASE WHEN dist2 IS NULL THEN 1 ELSE 0 END) AS null_dist2
FROM transactions;

-- ------------------------------------------------------------
-- Check 5: Does card2 still have a reasonable number of different 
-- values (not squashed into one number by mistake)?
-- ------------------------------------------------------------
SELECT COUNT(DISTINCT card2) AS unique_card2 FROM transactions;

-- ------------------------------------------------------------
-- Check 6: Does DeviceType only show real, expected values?
-- ------------------------------------------------------------
SELECT DISTINCT DeviceType FROM transactions;

-- ------------------------------------------------------------
-- Check 7: Look at a few real rows to make sure everything looks right
-- ------------------------------------------------------------
SELECT * FROM transactions LIMIT 5;

-- ============================================================
-- Load the identity table
-- ============================================================
DROP TABLE IF EXISTS identity;

CREATE TABLE identity (
    TransactionID INT PRIMARY KEY,
    DeviceType VARCHAR(20),
    DeviceInfo VARCHAR(100),
    id_07 FLOAT,
    id_08 FLOAT,
    FOREIGN KEY (TransactionID) REFERENCES transactions(TransactionID)
);

LOAD DATA LOCAL INFILE 'C:/Users/harsh/python/Projects/IEEE-CIS project/Notebook/sample_identity.csv'
INTO TABLE identity
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_rows FROM identity;
SELECT COUNT(*) AS total, COUNT(DISTINCT TransactionID) AS unique_ids FROM identity;


-- Insights

-- Found a real bug: device type values ("mobile"/"desktop") were loading into the wrong column because the table structure didn't match the file's column order. 
-- Fixed by matching the order exactly.
-- Found a second bug: some missing values were secretly turning into zero instead of staying empty, which could have hidden real gaps in the data.
-- Fixed missing values in Python instead of SQL, since it worked correctly and predictably.
-- Used different fill methods per column type: most common value for coded fields like card details, middle value for spread-out fields like distance.
-- Confirmed card numbers are not unique — many transactions share the same card2 value, proving it's a category, not an ID.
-- Lesson: no error message doesn't mean the data loaded correctly. Always double-check with real numbers.