# Call-Center-Performance-CX-Analytics-
End-to-end call center analytics project using Excel, SQL Server, and Power BI to evaluate agent performance, operational efficiency, and customer experience (NPS &amp; escalations).

📊 Call Center Performance & Customer Experience Analytics
🔍 Project Overview
This project delivers an end-to-end call center analytics solution, covering data generation, SQL-based analysis, and interactive Power BI dashboards to evaluate operational efficiency and customer experience.
The analysis focuses on understanding what drives customer satisfaction (NPS) and why escalations occur, translating raw call data into actionable business insights.

🧠 Business Problem
Call centers struggle with:
High escalation rates

Inconsistent agent performance

Poor visibility into CX drivers

Reactive decision-making instead of proactive improvement

This project answers:
Which agents and LOBs perform best — and why?

How does Avg Handle Time impact NPS?

What operational factors lead to escalations?

Where should managers focus coaching and staffing?


❓ Key Business Questions Answered
1. How is call volume distributed across LOBs and time?
Calls are evenly distributed across CnS, EnL, and MnR (~33% each)

Monthly trends reveal seasonal workload variations

2. Why do escalations occur?
Overall escalation rate: 66%

Certain agents show escalation rates 15–20% higher than average

Higher AHT and queue time correlate with higher escalations

3. What drives customer satisfaction (NPS)?
Agents with lower AHT (<4.2 mins) show ~25% higher NPS

EnL LOB has the highest Avg NPS (5.79) compared to others

4. So what? (Business Impact)
Identified bottom-quartile agents for targeted coaching

Highlighted staffing gaps during high-queue periods

Enabled supervisor-level accountability

5. What not?
Not a predictive model (yet)

No speech/text sentiment analysis (data limitation)

6. Why not?
Dataset intentionally limited to simulate real-world early-stage analytics projects

Designed to emphasize decision-making, not ML complexity


📈 Key Metrics Tracked
Total Calls: 100

Avg Handle Time (AHT): 4.40 mins

Escalation Rate: 66%

Avg NPS: 4.63


🛠️ Tools & Workflow
Step 1 – Data Creation (Excel)
Generated realistic call center dummy data

Built pivot tables for early trend validation

Step 2 – SQL Analysis
Imported data into SQL Server

Answered business questions using:

Aggregations

GROUP BY

CASE logic

Time-based analysis

Step 3 – Power BI Dashboard
Connected SQL Server to Power BI

Built interactive dashboards with:

KPIs

Agent-level performance

LOB comparisons

Monthly trends

Drill-downs and slicers


📊 Dashboard Highlights
Executive KPI overview

Agent-wise NPS & AHT comparison

Escalation rate diagnostics

LOB performance benchmarking

Time-based operational insights


🎯 Key Outcomes & Learnings
Business Impact
Translated raw call logs into CX insights

Identified operational inefficiencies affecting NPS

Enabled data-driven performance reviews

Skills Demonstrated
Data modeling & cleaning

SQL business analysis

KPI design

Power BI dashboarding

CX & operations analytics thinking

Storytelling with data


🚀 Future Enhancements
Predictive escalation modeling

Agent performance clustering

Sentiment analysis from call transcripts

SLA breach forecasting


📁 Repository Guide
/data → raw & cleaned datasets

/sql → table creation & analysis queries

/excel → pivot-based analysis screenshots

/powerbi → dashboard template & visuals


👤 Author
Shatansh Arora
Business Analyst | Data Analytics 
 ---

## 📊 Excel Dashboard Snapshots

### Excel_Exploratory_Analysis
![Excel_Exploratory_Analysis](https://github.com/shatansh-arora/Call-Center-Performance-CX-Analytics-/blob/main/excel/Excel_Exploratory_Analysis.png?raw=true)

## 📊 Power BI Dashboard Snapshots

### Executive Overview
![Executive Overview](https://github.com/shatansh-arora/Call-Center-Performance-CX-Analytics-/blob/main/powerBI/dashboard_screenshots/Executive%20Overview.png?raw=true)

### Agent Performance Deep Dive
![Agent Performance Deep Dive](https://github.com/shatansh-arora/Call-Center-Performance-CX-Analytics-/blob/main/powerBI/dashboard_screenshots/Agent%20Performance%20Deep%20Dive.png?raw=true)


