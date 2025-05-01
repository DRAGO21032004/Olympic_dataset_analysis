# Olympics Data Analysis using SQL

## Overview

This project involves an in-depth analysis of 120+ years of Olympic Games data using PostgreSQL. By executing over 30 SQL queries, the project extracts key insights related to countries, athletes, sports, and medals, helping to understand historical patterns and performance trends in the Olympics.

## Dataset

- **Primary Table**: `olympic_history`
  - Contains details of athletes, events, sports, medals, age, team, year, city, season, etc.
- **Supporting Table**: `noc_reg`
  - Maps National Olympic Committees (NOC codes) to country/region names.

## Key Insights Extracted

-  **Total Olympic Games held** and the **list of host cities** by year.
-  **Number of nations** participating in each edition of the Olympics.
-  **Year with highest and lowest participation** by country count.
-  **Sports played in all Summer Olympics** and **sports played only once**.
-  **Total sports played** in each Olympic edition.
-  **Oldest gold medal-winning athlete**.
-  **Top 5 athletes** with most gold medals and total medals.
-  **Country-wise medal breakdown** (gold, silver, bronze).
-  **Medal counts by country and Olympic year**.
-  **Countries that never won gold** but won other medals.
-  **India’s top-performing sport** and a detailed **Hockey medal timeline**.

## Technologies Used

- **SQL (PostgreSQL)** – for querying and data exploration
- **pgAdmin / DBeaver / Any SQL IDE** – for executing and testing queries
- *(Optional)* Power BI or Tableau can be used for visualizing results.

## Sample Queries

```sql
-- How many Olympic Games have been held?
SELECT COUNT(DISTINCT games) AS total_olympic_games FROM olympic_history;

-- Which sport has been played in all Summer Olympics?
SELECT sport
FROM olympic_history
WHERE season = 'Summer'
GROUP BY sport
HAVING COUNT(DISTINCT games) = (
    SELECT COUNT(DISTINCT games) FROM olympic_history WHERE season = 'Summer'
);
