SELECT 
    o.full_name AS "Investor",
    p.property_name AS "Property",
    t.transaction_type AS "Action",
    t.amount_inr AS "Gross Value",
    t.brokerage_paid AS "Brokerage",
    (t.amount_inr - COALESCE(t.brokerage_paid, 0)) AS "Net Value"
FROM real_estate_pro.fact_transactions t
JOIN real_estate_pro.dim_properties p ON t.property_id = p.property_id
JOIN real_estate_pro.dim_owners o ON p.owner_id = o.owner_id;

SELECT 
    p.property_name,
    COUNT(t.transaction_id) as transaction_count,
    SUM(t.amount_inr) as total_value,
    SUM(t.brokerage_paid) as total_brokerage
FROM real_estate_pro.dim_properties p
LEFT JOIN real_estate_pro.fact_transactions t ON p.property_id = t.property_id
GROUP BY p.property_name;

SELECT 
    investor,
    COUNT(property) AS total_properties,
    SUM(gross_value) AS total_investment_inr,
    SUM(brokerage_paid) AS total_brokerage_spent,
    SUM(net_value) AS portfolio_net_worth
FROM real_estate_pro.v_investor_summary
GROUP BY investor
ORDER BY portfolio_net_worth DESC;

SELECT 
    investor,
    ROUND((SUM(brokerage_paid) / SUM(gross_value)) * 100, 2) AS brokerage_percent_impact
FROM real_estate_pro.v_investor_summary
GROUP BY investor
ORDER BY brokerage_percent_impact ASC;

This query uses your v_investor_summary view to find the "Top Investor."
SELECT 
    investor,
    COUNT(property) AS assets_owned,
    SUM(gross_value) AS total_invested,
    SUM(brokerage_paid) AS total_fees,
    SUM(net_value) AS actual_equity
FROM real_estate_pro.v_investor_summary
GROUP BY investor
ORDER BY actual_equity DESC;

In a professional environment, we always check for "leakage." This query tells us which legend is losing the most money to brokers.
SELECT 
    investor,
    ROUND((SUM(brokerage_paid) / SUM(gross_value)) * 100, 2) AS fee_percentage
FROM real_estate_pro.v_investor_summary
GROUP BY investor
ORDER BY fee_percentage DESC;