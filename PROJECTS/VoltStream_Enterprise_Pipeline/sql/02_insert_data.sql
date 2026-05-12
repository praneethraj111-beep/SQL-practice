-- ==========================================================
-- DATA INGESTION: Master Vehicles & Drivers
-- ==========================================================

-- 1 : -- Insert Vehicles (The Diverse Fleet)
insert into volt_stream.vehicles (model_name,battery_capacity_kwh,battery_type,segment) values 
('Harrier EV', 75.0, 'LFP', 'SUV'),
('XEV 9e', 79.0, 'LFP', 'SUV'),
('Hyundai Ioniq 5 LR', 72.6, 'NMC', 'Luxury'),
('Kia EV6 LR', 77.4, 'NMC', 'Luxury'),
('Ather 450S', 2.9, 'NMC', '2W'),
('Ola S1 Pro', 4.0, 'NMC', '2W'),
('Tiago EV', 24.0, 'LFP', 'Taxi'),
('Mahindra XUV 400', 39.4, 'LFP', 'Taxi'),
('BYD Atto 3', 60.4, 'LFP', 'SUV');

-- 2. Insert 15 Drivers (Cricket Legends Theme)
insert into volt_stream.drivers (driver_name,rating) values 
('Sachin Tendulkar', 5.0),
('Steve Waugh', 4.8),
('Brian Lara', 4.7),
('Ricky Ponting', 4.5),
('Jacques Kallis', 4.9),
('MS Dhoni', 5.0),
('Virat Kohli', 4.6),
('Kane Williamson', 4.8),
('Ben Stokes', 4.3),
('Kumar Sangakkara', 4.9),
('AB de Villiers', 4.7),
('Shane Warne', 4.2),
('Wasim Akram', 4.5),
('Glenn McGrath', 4.8),
('Viv Richards', 4.4);

-- 3 : -- trip logs
insert into volt_stream.trip_logs (vehicle_id,driver_id,trip_date,distance_km,soc_start,soc_end,energy_consumed_kwh,charging_cost_inr) values 
-- Harrier EV (SUV - LFP)
(1, 6, '2026-05-10', 120.5, 100, 75, 18.75, 150.00), -- MS Dhoni (Efficient)
(1, 7, '2026-05-11', 200.0, 100, 50, 37.50, 300.00), -- Virat Kohli (Aggressive/Fast)

-- XEV 9e (SUV - LFP)
(2, 1, '2026-05-10', 150.0, 95, 65, 23.70, 190.00), -- Sachin (Steady)
(2, 11, '2026-05-12', 45.0, 80, 70, 7.90, 65.00),   -- AB de Villiers (City Traffic)

-- Hyundai Ioniq 5 (Luxury - NMC)
(3, 10, '2026-05-10', 300.0, 100, 40, 43.56, 435.00), -- Sangakkara (Highway)
(3, 5, '2026-05-11', 80.0, 60, 45, 10.89, 110.00),  -- Kallis (Smooth)

-- Kia EV6 (Luxury - NMC)
(4, 9, '2026-05-10', 250.0, 90, 40, 38.70, 380.00), -- Ben Stokes (Performance)

 -- Ather 450S (2W - NMC) 
(5, 8, '2026-05-13', 45.0, 100, 25, 2.18, 20.00),  -- Williamson (Office commute)
(5, 14, '2026-05-14', 15.0, 80, 55, 0.73, 8.00),   -- McGrath (Market run)

-- Tiago EV (Taxi - LFP)
(7, 12, '2026-05-10', 60.0, 100, 70, 7.20, 50.00),  -- Shane Warne (Taxi Duty)
(7, 12, '2026-05-10', 85.0, 70, 25, 10.80, 80.00),  -- Night Shift

-- Ola S1 Pro (2W - NMC)
(6, 15, '2026-05-12', 30.0, 100, 60, 1.60, 15.00),  -- Viv Richards (Short sprint)

-- Mahindra XUV 400 (Taxi - LFP)
(8, 13, '2026-05-11', 110.0, 90, 50, 15.76, 120.00), -- Wasim Akram (Consistent)
(8, 14, '2026-05-12', 140.0, 100, 45, 21.67, 170.00), -- McGrath (Planned route)

-- BYD Atto 3 (SUV - LFP)
(9, 5, '2026-05-13', 180.0, 100, 45, 33.22, 280.00), -- Kallis (Inter-city trip)
(9, 10, '2026-05-14', 60.0, 90, 70, 12.08, 100.00);  -- Sangakkara (City driving)

INSERT INTO volt_stream.service_logs 
(vehicle_id, service_date, service_type, cost_inr, odometer_reading, service_center, remarks) 
VALUES
-- Harrier EV (New Vehicle Check)
(1, '2026-04-05', 'First Service', 0.00, 1000, 'Tata Motors Prolife', 'General inspection, all systems green'),

-- Hyundai Ioniq 5 (Performance Maintenance)
(3, '2026-04-15', 'Tire Rotation & Alignment', 4500.00, 5000, 'Hyundai Signature', 'Aligning for highway stability'),

-- Kia EV6 (High Tech Maintenance)
(4, '2026-05-01', 'Coolant Flush', 8500.00, 12000, 'Kia Premium Hub', 'Coolant replaced for battery thermal management'),

-- Ather 450S (Affordable 2W Service)
(5, '2026-04-20', 'Brake Pad Replacement', 1200.00, 3500, 'Ather Space', 'Rear pads replaced'),

-- Tiago EV (Taxi Workhorse - High Mileage)
(7, '2026-03-25', 'Suspension Overhaul', 12000.00, 45000, 'Local EV Works', 'Essential for taxi comfort in city roads'),

-- BYD Atto 3 (Software & Electronics)
(9, '2026-05-10', 'Software Update', 0.00, 8000, 'BYD Landmark', 'Blade battery firmware updated to v2.1'),

-- Mahindra XUV 400 (Body & Paint)
(8, '2026-05-12', 'Dent Repair', 6500.00, 15000, 'Mahindra Rise', 'Minor scratch repair on rear bumper');