-- ==========================================================
-- PROJECT: VoltStream Enterprise EV Pipeline
-- SCHEMA: volt_stream
-- ==========================================================

create schema if not exists volt_stream;

-- 1 : VEHICLE MASTER : Specs for every model
create table volt_stream.vehiucles (
	vehicle_id serial primary key, 
	model_name varchar(50) not null, 
	battery_capacity_kwh decimal(5,2) not null, 
	battery_type varchar (10) check (battery_type in ('LFP','NMC') ), 
	segment varchar(20) --Taxi,Luxury,2W,SUV
	);
alter table volt_stream.vehiucles rename to vehicles;

-- 2 : DRIVER MASTER: Tracking the human element
create table volt_stream.drivers (
driver_id serial primary key, 
driver_name varchar(100) not null, 
joining_date date default current_date,
rating decimal(2,1) check (rating<=5.0) );

-- 3 :  TRIP LOGS: The transactional data
create table volt_stream.trip_logs (
trip_id serial primary key, 
vehicle_id int references volt_stream.vehicles (vehicle_id),
driver_id int references volt_stream.drivers (driver_id),
trip_date date not null,
distance_km decimal(6,2) not null, 
soc_start int check (soc_start <=100), 
soc_end int check (soc_end>=0), 
energy_consumed_kwh decimal(5,2),
charging_cost_inr decimal(8,2) -- New for VoltStream
);

-- 4 : -- Maintenance & Service Tracking
create table if not exists volt_stream.service_logs (
service_id serial primary key, 
vehicle_id int references volt_stream.vehicles (vehicle_id),
service_date date not null,
service_type varchar(50), -- e.g., 'Battery Health Check', 'Tire Rotation'
cost_inr decimal(10,2) not null,
odometer_reading integer not null, 
service_center varchar(100),
remarls text );

alter table volt_stream.service_logs rename column remarls to remarks;