DROP VIEW IF EXISTS ev_ops.daily_performance_summary;

CREATE VIEW ev_ops.daily_performance_summary AS
SELECT 
    t.trip_id, -- Adding this now works because we dropped the old view
    v.model_name,
    v.battery_type,
    t.trip_date,
    t.distance_km,
    (t.start_soc - t.end_soc) AS soc_consumed,
    ROUND((t.energy_consumed_kwh * 1000 / NULLIF(t.distance_km, 0)), 2) AS wh_per_km,
    ROUND((t.distance_km / NULLIF((t.start_soc - t.end_soc), 0) * 100), 2) AS est_range_km
FROM ev_ops.trip_logs t
JOIN ev_ops.vehicles v ON t.vehicle_id = v.vehicle_id
ORDER BY t.trip_id ASC;