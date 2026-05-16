create schema if not exists pulsepoint;

-- The "Landing Zone" - Everything is TEXT because we don't trust raw data yet
drop table if exists pulsepoint.stg_hospital_data;
create table pulsepoint.stg_hospital_data (
	pat_name TEXT, 
	age TEXT, 
	sex TEXT, 
	physician TEXT, 
	dept TEXT, 
	adm_date TEXT, 
	dis_date TEXT, 
	bill TEXT, 
	diagnosis TEXT 
);

-- The "Gold Standard" Table - Clean data types
drop table if exists pulsepoint.fact_admissions;
create table pulsepoint.fact_admissions (
	admission_id serial primary key, 
	patient_name varchar(100), 
	admission_date date,
	billing_amount numeric(10,2),
	diagnosis varchar(255)
);