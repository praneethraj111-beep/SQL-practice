-- 1. Create the Master Vehicle Data (The Parent)
INSERT INTO ev_ops.vehicles (model_name, battery_type, total_capacity_kwh, purchase_date) 
VALUES 
('Tata Nexon EV MR', 'LFP', 30.00, '2024-01-19'),
('Tata Nexon EV LR', 'LFP', 40.50, '2025-02-10');

-- 2. Create the Trip Logs (The Children)
INSERT INTO ev_ops.trip_logs (vehicle_id, trip_date, distance_km, start_soc, end_soc, energy_consumed_kwh) 
VALUES 
(1, '2026-05-10', 120.5, 100, 20, 24.00),
(2, '2026-05-11', 200.0, 95, 15, 32.40);