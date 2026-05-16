-- Project: PulsePoint Healthcare Analytics
-- Script: 03_transform_load.sql

-- 1. Clear the final production table so we don't duplicate data if we rerun this
truncate table pulsepoint.fact_admissions;

-- 2. Move data from Staging (TEXT) to Production (Structured Types)
INSERT INTO pulsepoint.fact_admissions (
    patient_name, 
    admission_date, 
    billing_amount, 
    diagnosis
)
SELECT 
    pat_name,                           -- This is already capitalized by Python
    CAST(adm_date AS DATE),             -- Converts the text date into a real database DATE type
    CAST(bill AS NUMERIC(10,2)),        -- Converts the text billing amount into a clean decimal number
    diagnosis                           -- Direct move
FROM pulsepoint.stg_hospital_data;