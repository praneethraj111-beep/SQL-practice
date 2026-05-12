CREATE OR REPLACE VIEW volt_stream.v_fleet_performance_master AS
SELECT 
    t.trip_id,
    v.model_name,
    v.battery_type,
    v.segment,
    d.driver_name,
    t.trip_date,
    t.distance_km,
    t.energy_consumed_kwh,
    ROUND((t.energy_consumed_kwh / NULLIF(t.distance_km, 0)) * 1000, 2) AS efficiency_wh_km,
    ROUND(t.charging_cost_inr / NULLIF(t.distance_km, 0), 2) AS energy_cost_per_km,
    ROUND((v.battery_capacity_kwh / NULLIF((t.energy_consumed_kwh / NULLIF(t.distance_km, 0)), 0)), 2) AS projected_range_km
FROM 
    volt_stream.trip_logs t
JOIN 
    volt_stream.vehicles v ON t.vehicle_id = v.vehicle_id
JOIN 
    volt_stream.drivers d ON t.driver_id = d.driver_id;