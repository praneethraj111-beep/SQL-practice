CREATE OR REPLACE VIEW real_estate_pro.v_dashboard_kpis AS
SELECT 
    p.location,
    p.property_type,
    COUNT(t.transaction_id) AS total_deals,
    SUM(CASE WHEN t.transaction_type = 'BUY' THEN t.amount_inr ELSE 0 END) AS total_sales_value,
    SUM(CASE WHEN t.transaction_type = 'RENT' THEN t.amount_inr ELSE 0 END) AS total_rental_income,
    ROUND(AVG(t.brokerage_paid), 2) AS avg_brokerage_cost,
    ROUND(SUM(t.brokerage_paid) / NULLIF(SUM(t.amount_inr), 0) * 100, 2) AS brokerage_yield_pct
FROM real_estate_pro.dim_properties p
JOIN real_estate_pro.fact_transactions t ON p.property_id = t.property_id
GROUP BY p.location, p.property_type;