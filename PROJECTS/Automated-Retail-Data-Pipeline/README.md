\# EV Fleet Operations \& Battery Analytics



\## Project Overview

This project is a functional Data Engineering pipeline designed to track and analyze Electric Vehicle (EV) performance. It focuses on battery efficiency (Wh/km) and range estimation across different battery chemistries (LFP vs. NMC).



The pipeline ingests raw trip data into a \*\*PostgreSQL\*\* database, processes it via \*\*SQL Views\*\*, and visualizes the results through an automated \*\*Excel Dashboard\*\*.



\## Technical Stack

\* \*\*Database:\*\* PostgreSQL 16

\* \*\*Database Management:\*\* DBeaver

\* \*\*Data Modeling:\*\* SQL (Views, Constraints, Foreign Keys)

\* \*\*Analytics \& Visualization:\*\* Microsoft Excel (via ODBC)

\* \*\*Version Control:\*\* Git \& GitHub



\## Data Architecture

The database consists of two primary tables and a calculated view:

1\.  `ev\_ops.vehicles`: Master data containing vehicle models, battery types (LFP/NMC), and capacities.

2\.  `ev\_ops.trip\_logs`: Transactional data recording distance, State of Charge (SoC), and energy consumption.

3\.  `ev\_ops.daily\_performance\_summary`: A business intelligence view calculating:

&#x20;   \* \*\*Efficiency (Wh/km):\*\* Energy used per kilometer.

&#x20;   \* \*\*Estimated Full Range:\*\* Real-world projected range based on current driving efficiency.



\## How to Run

1\.  \*\*Database Setup:\*\* Execute `sql/01\_setup\_tables.sql` to create the schema and tables.

2\.  \*\*Data Ingestion:\*\* Run `sql/02\_insert\_data.sql` to populate the tables with sample trip logs.

3\.  \*\*View Creation:\*\* Run `sql/03\_create\_views.sql` to generate the analytical layer.

4\.  \*\*Excel Connection:\*\* Open the `.xlsx` file in the `dashboards/` folder and refresh the data connection via ODBC.



\## Key Insights Captured

\* Comparison of efficiency between LFP and NMC battery platforms.

\* Tracking of battery degradation through State of Charge (SoC) analysis.

\* Automated range projection for fleet planning.

