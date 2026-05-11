-- 1 : -- Clean setup
drop schema if exists ev_ops cascade;
create schema ev_ops;

-- 2 : -- Vehicle Master Data 
create table ev_ops.vehicles (vehicle_id serial primary key,
model_name text not null,
battery_type text check (battery_type in ('LFP','NMC') ),
-- your chemistry interest
total_capacity_kwh decimal (5,2),
purchase_date date );

-- 3 : -- Daily Trip & Battery Logs
create table ev_ops.trip_logs (trip_id serial primary key,
vehicle_id int references ev_ops.vehicles (vehicle_id),
trip_date date default current_date, 
distance_km decimal (6,2),
start_soc INT check (start_soc <= 100), -- state of charge
end_soc INT check (end_soc >= 0),
energy_consumed_kwh decimal (5,2) );

alter table ev_ops.trip_logs 
rename column energu_consumed_kwh to energy_consumed_kwh;