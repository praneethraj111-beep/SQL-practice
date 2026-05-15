CREATE OR REPLACE VIEW real_estate_pro.v_investor_summary AS
SELECT 
    o.full_name AS investor,
    p.property_name AS property,
    p.location,
    p.property_type,
    t.transaction_type,
    t.amount_inr AS gross_value,
    t.brokerage_paid,
    (t.amount_inr - COALESCE(t.brokerage_paid, 0)) AS net_value,
    t.transaction_date
FROM real_estate_pro.fact_transactions t
JOIN real_estate_pro.dim_properties p ON t.property_id = p.property_id
JOIN real_estate_pro.dim_owners o ON p.owner_id = o.owner_id;


-- CORRECT STRUCTURE
UPDATE real_estate_pro.fact_transactions
SET brokerage_paid = amount_inr * 0.05    -- Action: What to change
<<<<<<< HEAD
WHERE brokerage_paid IS NULL;             -- Filter: Which rows to change
=======
WHERE brokerage_paid IS NULL;             -- Filter: Which rows to change
>>>>>>> f244aa3 (completed estate pro)
