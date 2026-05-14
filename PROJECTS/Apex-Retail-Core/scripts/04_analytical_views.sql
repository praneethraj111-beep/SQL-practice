-- 1. Executive Sales Overview
-- Consolidates Orders, Items, and Customers for a master dashboard view
CREATE OR REPLACE VIEW apex_core.v_sales_performance AS
SELECT 
    o.order_id,
    o.order_date,
    c.first_name || ' ' || c.last_name AS customer_name,
    p.product_name,
    v.variant_name,
    oi.quantity,
    oi.unit_price,
    oi.line_total,
    o.order_status
FROM apex_core.orders o
JOIN apex_core.customers c ON o.customer_id = c.customer_id
JOIN apex_core.order_items oi ON o.order_id = oi.order_id
JOIN apex_core.product_variants v ON oi.variant_id = v.variant_id
JOIN apex_core.products p ON v.product_id = p.product_id;

-- 2. Low Stock Alert View
-- A "Data Ops" essential to prevent stockouts
CREATE OR REPLACE VIEW apex_core.v_low_stock_alerts AS
SELECT 
    p.product_name,
    v.variant_name,
    w.warehouse_name,
    i.physical_stock,
    CASE 
        WHEN i.physical_stock < 10 THEN 'CRITICAL'
        WHEN i.physical_stock < 50 THEN 'WARNING'
        ELSE 'HEALTHY'
    END AS stock_status
FROM apex_core.inventory i
JOIN apex_core.product_variants v ON i.variant_id = v.variant_id
JOIN apex_core.products p ON v.product_id = p.product_id
JOIN apex_core.warehouses w ON i.warehouse_id = w.warehouse_id
WHERE i.physical_stock < 50;

-- 3. Customer VIP Ranking
-- Analyzing total spend to segment customers
CREATE OR REPLACE VIEW apex_core.v_customer_segments AS
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS lifetime_value,
    CASE 
        WHEN SUM(o.total_amount) > 5000 THEN 'Platinum'
        WHEN SUM(o.total_amount) > 1000 THEN 'Gold'
        ELSE 'Silver'
    END AS customer_tier
FROM apex_core.customers c
LEFT JOIN apex_core.orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

SELECT * FROM apex_core.v_sales_performance;

-- =============================================
-- SCRIPT 04: ANALYTICAL VIEWS
-- Purpose: Business Intelligence & Dashboards
-- =============================================

-- [EXISTING VIEWS]
-- 1. v_sales_performance (The Order Tracker)
-- 2. v_low_stock_alerts (The Inventory Guard)
-- 3. v_customer_segments (The VIP Ranker)

-- [ADD THIS NEW VIEW UNDERNEATH]

-- 4. Daily Revenue Report
-- Purpose: To see how much money is actually hitting the bank each day.
CREATE OR REPLACE VIEW apex_core.v_daily_revenue AS
SELECT 
    DATE(paid_at) AS transaction_date,
    payment_method,
    COUNT(payment_id) AS number_of_transactions,
    SUM(amount_paid) AS daily_total
FROM apex_core.payments
WHERE payment_status = 'success'
GROUP BY DATE(paid_at), payment_method
ORDER BY transaction_date DESC;

CREATE OR REPLACE VIEW apex_core.v_customer_segments AS
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(o.order_id) AS total_orders,
    -- COALESCE replaces NULL with 0.00
    COALESCE(SUM(o.total_amount), 0.00) AS lifetime_value,
    CASE 
        WHEN SUM(o.total_amount) > 5000 THEN 'Platinum'
        WHEN SUM(o.total_amount) > 1000 THEN 'Gold'
        WHEN SUM(o.total_amount) > 0 THEN 'Silver'
        ELSE 'New/Prospect' -- Better than leaving it empty
    END AS customer_tier
FROM apex_core.customers c
LEFT JOIN apex_core.orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;


CREATE OR REPLACE VIEW apex_core.v_mom_growth AS
WITH monthly_revenue AS (
    SELECT 
        DATE_TRUNC('month', paid_at) AS revenue_month,
        SUM(amount_paid) AS current_month_revenue
    FROM apex_core.payments
    WHERE payment_status = 'success'
    GROUP BY 1
)
SELECT 
    revenue_month,
    current_month_revenue,
    -- If there's no previous month, show 0 instead of NULL
    COALESCE(LAG(current_month_revenue) OVER (ORDER BY revenue_month), 0) AS previous_month_revenue,
    -- Handle the first month: if previous is 0, growth is 100% (or 0% depending on preference)
    CASE 
        WHEN LAG(current_month_revenue) OVER (ORDER BY revenue_month) IS NULL THEN 0 -- First month ever
        ELSE ((current_month_revenue - LAG(current_month_revenue) OVER (ORDER BY revenue_month)) 
             / NULLIF(LAG(current_month_revenue) OVER (ORDER BY revenue_month), 0) * 100)
    END AS growth_percentage
FROM monthly_revenue;