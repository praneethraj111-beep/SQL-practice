-- STEP 1: DROP EVERYTHING TO START CLEAN
-- We use CASCADE to make sure any views or links are cleared
DROP TABLE IF EXISTS volt_stream.service_logs CASCADE;
DROP TABLE IF EXISTS volt_stream.dim_vehicles CASCADE;

-- Create the Parent Table
CREATE TABLE volt_stream.dim_vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    model_name VARCHAR(50) UNIQUE NOT NULL,
    segment VARCHAR(20),
    battery_type VARCHAR(20)
);

-- Create the new, empty Service Logs table (The Child)
CREATE TABLE volt_stream.service_logs (
    service_id SERIAL PRIMARY KEY,
    vehicle_id INTEGER REFERENCES volt_stream.dim_vehicles(vehicle_id),
    service_date DATE NOT NULL,
    service_type VARCHAR(50),
    cost_inr NUMERIC(10, 2),
    odometer_reading INTEGER CHECK (odometer_reading >= 0),
    service_center VARCHAR(100),
    remarks TEXT
);

INSERT INTO volt_stream.dim_vehicles (model_name)
SELECT DISTINCT vehicle_id::TEXT 
FROM volt_stream.service_logs_old;

INSERT INTO volt_stream.service_logs 
(vehicle_id, service_date, service_type, cost_inr, odometer_reading, service_center, remarks)
SELECT 
    v.vehicle_id, 
    s.service_date, 
    s.service_type, 
    s.cost_inr, 
    s.odometer_reading, 
    s.service_center, 
    s.remarks
FROM volt_stream.service_logs_old s
JOIN volt_stream.dim_vehicles v ON s.vehicle_id::TEXT = v.model_name;

SELECT 
    v.model_name, 
    v.battery_type,
    s.service_date, 
    s.service_type, 
    s.cost_inr, 
    s.odometer_reading
FROM volt_stream.service_logs s
JOIN volt_stream.dim_vehicles v ON s.vehicle_id = v.vehicle_id
ORDER BY s.service_date DESC;

SELECT vehicle_id, model_name FROM volt_stream.dim_vehicles;

-- Replace the IDs with your actual vehicle details
UPDATE volt_stream.dim_vehicles
SET model_name = 'Harrier', battery_type = 'N/A', segment = '4W'
WHERE model_name = '1'; -- Change '1' to whichever ID is the Harrier

UPDATE volt_stream.dim_vehicles
SET model_name = 'BYD Atto 3', battery_type = 'LFP', segment = '4W'
WHERE model_name = '2'; -- Change '2' to whichever ID is the BYD

UPDATE volt_stream.dim_vehicles
SET model_name = 'Ather 450X', battery_type = 'NMC', segment = '2W'
WHERE model_name = '3'; -- Change '3' to whichever ID is the Ather

-- This prevents future "Unknown" battery types
ALTER TABLE volt_stream.dim_vehicles 
ALTER COLUMN battery_type SET NOT NULL;

ALTER TABLE volt_stream.dim_vehicles 
ALTER COLUMN segment SET NOT NULL;

 -- Fix the 4W (Cars)
UPDATE volt_stream.dim_vehicles
SET segment = '4W', 
    battery_type = CASE 
        WHEN model_name ILIKE '%Harrier%' THEN 'N/A'
        ELSE 'LFP' -- Assuming XEV and BYD are LFP
    END
WHERE model_name ILIKE ANY (ARRAY['%Harrier%', '%XEV%', '%BYD%']);

-- Fix the 2W (Scooters)
UPDATE volt_stream.dim_vehicles
SET segment = '2W', 
    battery_type = 'NMC' -- Most common for Ather/Ola
WHERE model_name ILIKE ANY (ARRAY['%Ather%', '%Ola%']);

-- Final safety net: If anything is still NULL, give it a default
UPDATE volt_stream.dim_vehicles SET segment = 'Other' WHERE segment IS NULL;
UPDATE volt_stream.dim_vehicles SET battery_type = 'N/A' WHERE battery_type IS NULL;

SELECT * FROM volt_stream.dim_vehicles 
WHERE segment IS NULL OR battery_type IS NULL;

ALTER TABLE volt_stream.dim_vehicles ALTER COLUMN segment SET NOT NULL;
ALTER TABLE volt_stream.dim_vehicles ALTER COLUMN battery_type SET NOT NULL;

SELECT 
    v.segment,
    v.battery_type,
    COUNT(s.service_id) as total_services,
    SUM(s.cost_inr) as total_spent,
    ROUND(AVG(s.cost_inr), 2) as avg_service_cost
FROM volt_stream.service_logs s
JOIN volt_stream.dim_vehicles v ON s.vehicle_id = v.vehicle_id
GROUP BY v.segment, v.battery_type
ORDER BY total_spent DESC;