/* =========================================================
Project      : Call Center Performance & CX Analytics
Author       : Shatansh Arora
Created On   : 2025
Database     : SQL Server
Purpose     : 
    - Clean and standardize raw call center interaction data
    - Calculate operational KPIs (AHT, Escalation Rate)
    - Derive customer experience metrics (NPS, UES)
    - Enable agent-, LOB-, and time-based performance analysis

Key Outputs  :
    - Agent-level performance metrics
    - LOB-wise call distribution
    - Monthly trends for AHT, NPS, and escalations

Business Use :
    Supports workforce planning, agent coaching, and CX improvement initiatives.
*/
   ========================================================= */


/* ---------------------------------------------------------
   TOTAL CALL VOLUME METRICS
   --------------------------------------------------------- */

-- Total number of calls throughout the year 2025
SELECT
    COUNT(*) AS Total_No_Of_Calls
FROM dbo.call_center_data
WHERE Start_Time >= '2025-01-01'
  AND Start_Time <  '2026-01-01';


-- Total number of calls received in March 2025
SELECT
    COUNT(*) AS Total_No_Of_Calls
FROM dbo.call_center_data
WHERE Start_Time >= '2025-03-01'
  AND Start_Time <  '2025-04-01';


-- Total number of calls handled by agent Daisy
SELECT
    COUNT(*) AS Total_Calls_Handled_By_Daisy
FROM dbo.call_center_data
WHERE Agent = 'Daisy';


/* ---------------------------------------------------------
   ESCALATION ANALYSIS
   --------------------------------------------------------- */

-- Total number of calls that resulted in escalation
SELECT
    COUNT(*) AS Calls_Resulted_In_Escalation
FROM dbo.call_center_data
WHERE Escalated = 'Yes';


-- Agent-wise escalation rate
SELECT
    Agent,
    COUNT(*) AS Total_Calls,
    SUM(CASE WHEN Escalated = 'Yes' THEN 1 ELSE 0 END) AS Escalated_Calls,
    CAST(
        100.0 * SUM(CASE WHEN Escalated = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)
        AS DECIMAL(5,2)
    ) AS Escalation_Rate_Percent
FROM dbo.call_center_data
GROUP BY Agent
ORDER BY Escalation_Rate_Percent DESC;


/* ---------------------------------------------------------
   DATE-BASED QUERIES
   --------------------------------------------------------- */

-- Call ID, agent, start & end time for calls on 19th September 2025
SELECT
    Call_ID,
    Agent,
    Start_Time,
    End_Time
FROM dbo.call_center_data
WHERE Start_Time >= '2025-09-19'
  AND Start_Time <  '2025-09-20';


-- Number of days agent Harry was present to take calls
SELECT
    Agent,
    COUNT(DISTINCT CAST(Start_Time AS DATE)) AS Days_Present
FROM dbo.call_center_data
WHERE Agent = 'Harry'
GROUP BY Agent;


-- Dates on which agent Daniel was absent
WITH All_Days AS (
    SELECT DISTINCT CAST(Start_Time AS DATE) AS Call_Date
    FROM dbo.call_center_data
),
Daniel_Days AS (
    SELECT DISTINCT CAST(Start_Time AS DATE) AS Call_Date
    FROM dbo.call_center_data
    WHERE Agent = 'Daniel'
)
SELECT
    a.Call_Date AS Daniel_Absent_Days
FROM All_Days a
LEFT JOIN Daniel_Days d
    ON a.Call_Date = d.Call_Date
WHERE d.Call_Date IS NULL
ORDER BY a.Call_Date;


/* ---------------------------------------------------------
   AVERAGE HANDLING TIME (AHT)
   --------------------------------------------------------- */

-- Overall Average Handling Time (seconds)
SELECT
    AVG(Total_Handle_Time * 1.0) AS Avg_AHT_Seconds
FROM dbo.call_center_data;


-- Overall Average Handling Time (minutes)
SELECT
    CAST(
        ROUND(AVG(Total_Handle_Time * 1.0) / 60, 1)
        AS DECIMAL(10,1)
    ) AS Avg_AHT_Minutes
FROM dbo.call_center_data;


-- Average AHT on 2nd April 2025 (seconds)
SELECT
    CAST(AVG(Total_Handle_Time * 1.0) AS INT) AS Avg_AHT_2_April_2025_Seconds
FROM dbo.call_center_data
WHERE CAST(Start_Time AS DATE) = '2025-04-02';


-- Average AHT in December 2025 (seconds)
SELECT
    CAST(AVG(Total_Handle_Time * 1.0) AS INT) AS Avg_AHT_Dec_2025_Seconds
FROM dbo.call_center_data
WHERE Start_Time >= '2025-12-01'
  AND Start_Time <  '2026-01-01';


/* ---------------------------------------------------------
   AGENT & LOB PERFORMANCE
   --------------------------------------------------------- */

-- Maximum AHT for each agent
SELECT
    Agent,
    MAX(Total_Handle_Time) AS Max_AHT_Seconds
FROM dbo.call_center_data
GROUP BY Agent
ORDER BY Max_AHT_Seconds DESC;


-- Second maximum AHT for each agent
SELECT
    Agent,
    Total_Handle_Time AS Second_Max_AHT_Seconds
FROM (
    SELECT
        Agent,
        Total_Handle_Time,
        DENSE_RANK() OVER (
            PARTITION BY Agent
            ORDER BY Total_Handle_Time DESC
        ) AS rnk
    FROM dbo.call_center_data
) t
WHERE rnk = 2
ORDER BY Agent;


-- Agent-wise Average AHT and Average NPS
SELECT
    Agent,
    CAST(AVG(Total_Handle_Time * 1.0) AS INT) AS Avg_AHT_Seconds,
    CAST(AVG(NPS * 1.0) AS DECIMAL(4,2)) AS Avg_NPS
FROM dbo.call_center_data
GROUP BY Agent
ORDER BY Agent;


-- Average AHT for each Line of Business (minutes)
SELECT
    LOB,
    CAST(
        ROUND(AVG(Total_Handle_Time * 1.0) / 60, 2)
        AS DECIMAL(10,2)
    ) AS Avg_AHT_Minutes
FROM dbo.call_center_data
GROUP BY LOB
ORDER BY LOB;


/* ---------------------------------------------------------
   CALL-LEVEL DEEP DIVES
   --------------------------------------------------------- */

-- Top 20 worst-performing calls (escalated & longest duration)
SELECT TOP 20
    Call_ID,
    Agent,
    LOB,
    Total_Handle_Time AS Call_Duration_Seconds,
    Escalated,
    NPS
FROM dbo.call_center_data
WHERE Escalated = 'Yes'
ORDER BY Total_Handle_Time DESC;


-- Top 10 longest calls by duration (seconds)
SELECT TOP 10
    Call_ID,
    Agent,
    LOB,
    Total_Handle_Time AS Call_Duration_Seconds,
    Start_Time
FROM dbo.call_center_data
ORDER BY Total_Handle_Time DESC;


/* ---------------------------------------------------------
   CUSTOMER SENTIMENT
   --------------------------------------------------------- */

-- Identify customer sentiment based on NPS & escalation
SELECT
    Call_ID,
    Agent,
    NPS,
    Escalated,
    CASE
        WHEN NPS >= 8 AND Escalated = 'No' THEN 'Happy'
        WHEN NPS BETWEEN 6 AND 7          THEN 'Neutral'
        ELSE 'Unhappy'
    END AS Customer_Sentiment
FROM dbo.call_center_data;


/* ---------------------------------------------------------
   MONTHLY TREND ANALYSIS
   --------------------------------------------------------- */

-- Month-wise trend of average handling time & total calls
SELECT
    FORMAT(Start_Time, 'yyyy-MM') AS Month,
    CAST(AVG(Total_Handle_Time * 1.0) AS INT) AS Avg_AHT_Seconds,
    COUNT(*) AS Total_Calls
FROM dbo.call_center_data
GROUP BY FORMAT(Start_Time, 'yyyy-MM')
ORDER BY Month;
