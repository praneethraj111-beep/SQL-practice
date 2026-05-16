\# PulsePoint Healthcare Analytics Pipeline



An end-to-end data operations and analytics pipeline that extracts raw hospital admission records, cleanses and stages the data using an automated Python ETL script, structures it via a PostgreSQL data warehouse, and delivers an interactive executive dashboard in Power BI.



\## Data Pipeline Architecture

1\. \*\*Extraction:\*\* Ingests unstructured, third-party raw patient data (`.csv`).

2\. \*\*Ingestion \& Staging (Python):\*\* Automatically processes files via `pandas` and pipes data into a PostgreSQL staging area utilizing `SQLAlchemy`.

3\. \*\*Transformation \& Load (SQL):\*\* Converts data types from string formats into native SQL relational database types (`DATE`, `NUMERIC`) inside final production fact tables.

4\. \*\*Analytics \& Visualization (Power BI):\*\* Connects directly to the production schema to calculate key operational KPIs and financial distributions.



\## Project Structure

\* `01\_infrastructure.sql` - Database schema and table structures (Staging and Production layers).

\* `02\_etl\_pipeline.py` - Automated Python script for data extraction, string mapping, and database loading.

\* `03\_transform\_load.sql` - Production-level SQL script executing data type casting and final insertion.

\* `04\_executive\_dashboard.pbix` - Finished Power BI Desktop dashboard tracking total revenue and case breakdowns.



\## Tech Stack

\* \*\*Language:\*\* Python 3.x

\* \*\*Database engine:\*\* PostgreSQL

\* \*\*Libraries:\*\* Pandas, SQLAlchemy, Psycopg2-binary

\* \*\*BI Tool:\*\* Power BI Desktop

