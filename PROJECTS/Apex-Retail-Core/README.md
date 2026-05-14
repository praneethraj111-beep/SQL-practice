\# Apex Retail Core: SQL \& BI Portfolio (Data Operations)



\## Project Overview

An end-to-end Data Operations project simulating a high-volume retail environment. This project covers database architecture, transaction handling, and executive analytics.



\## Tech Stack

\- \*\*Database:\*\* PostgreSQL 16

\- \*\*Analytics:\*\* Power BI Desktop

\- \*\*Version Control:\*\* Git



\## 🏗️ Architecture

\- \*\*Normalization:\*\* 3NF compliant schema for Customers, Products, and Orders.

\- \*\*Automation:\*\* PL/pgSQL Triggers handle real-time inventory adjustments.

\- \*\*Business Intelligence:\*\* Custom SQL Views for MoM Growth and Stock Alerts.

\- \*\*Analytics:** 5 specialized Views handle complex logic (MoM growth, RFM segments).



## 📈 Key Insights Delivered

1. **Financials:** Daily revenue trends and Month-over-Month growth.

2. **Operations:** Real-time stock alerts (Critical vs. Warning).

3. **CRM:** Customer tiering based on Lifetime Value (LTV).



\## How to Run

1\. Execute scripts `01\_infrastructure.sql` through `05\_seed\_data.sql` in order.

2\. Connect Power BI to the PostgreSQL instance.

3\. Import the `v\_` prefix views for the dashboard.

