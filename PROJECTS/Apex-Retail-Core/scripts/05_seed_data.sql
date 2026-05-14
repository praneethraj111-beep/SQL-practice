-- 1. Seed Categories & Brands
INSERT INTO apex_core.categories (category_name, slug) VALUES 
('Rackets', 'tennis-rackets'),
('Footwear', 'tennis-shoes'),
('Apparel', 'tennis-apparel');

INSERT INTO apex_core.brands (brand_name, origin_country) VALUES 
('Wilson', 'USA'),
('Nike', 'USA'),
('Babolat', 'France');

-- 2. Seed Products
INSERT INTO apex_core.products (sku, product_name, brand_id, category_id, base_price) VALUES 
('W-PRO-STAFF', 'Pro Staff 97', 1, 1, 249.00),
('N-VAPOR-11', 'Nike Vapor 11', 2, 2, 160.00),
('B-AERO-DRIVE', 'Pure Aero', 3, 1, 239.00);

-- 3. Seed Variants (The SKU Level)
INSERT INTO apex_core.product_variants (product_id, sku_variant, variant_name, additional_price) VALUES 
(1, 'W-PRO-97-G3', 'Grip Size 3', 0.00),
(1, 'W-PRO-97-G4', 'Grip Size 4', 5.00),
(2, 'N-VAP-11-RED', 'University Red - Size 10', 0.00);

-- 4. Seed Customers (The Big Three)
INSERT INTO apex_core.customers (first_name, last_name, email) VALUES 
('Roger', 'Federer', 'rf.goat@example.com'),
('Rafael', 'Nadal', 'king.clay@example.com'),
('Novak', 'Djokovic', 'nole.djoker@example.com');

-- 5. Seed Warehouse & Inventory
INSERT INTO apex_core.warehouses (warehouse_name, location_city) VALUES 
('Main Hub', 'Hyderabad'),
('Regional Depot', 'Mumbai');

INSERT INTO apex_core.inventory (variant_id, warehouse_id, physical_stock) VALUES 
(1, 1, 100), -- Federer's Racket in Hyderabad
(2, 1, 5),   -- LOW STOCK WARNING TEST
(3, 2, 50);

-- 6. Create a Transaction (The First Order)
INSERT INTO apex_core.orders (customer_id, shipping_address, total_amount) 
VALUES (1, 'Basel, Switzerland', 249.00);

-- 7. Create the Order and get the ID
INSERT INTO apex_core.orders (customer_id, shipping_address, total_amount) 
VALUES (1, 'Basel, Switzerland', 249.00)
RETURNING order_id;

-- Use the ID from the previous step (Replace 'X' with that number)
INSERT INTO apex_core.order_items (order_id, variant_id, quantity, unit_price) 
VALUES (
    (SELECT order_id FROM apex_core.orders WHERE customer_id = 1 ORDER BY order_date DESC LIMIT 1),
    1, 
    1, 
    249.00
);


-- Update the Order Status to 'processed' now that it is paid
UPDATE apex_core.orders 
SET order_status = 'processed' 
WHERE order_id = 101;


-- 8. 
INSERT INTO apex_core.payments (
    order_id, 
    payment_method, 
    transaction_id, 
    amount_paid, 
    payment_status
) VALUES (
    (SELECT order_id FROM apex_core.orders WHERE customer_id = 1 ORDER BY order_date DESC LIMIT 1), 
    'Credit Card', 
    'TXN_RF_999888', 
    249.00, 
    'success'
);

SELECT 
    o.order_id, 
    o.order_status, 
    p.payment_status, 
    p.transaction_id
FROM apex_core.orders o
JOIN apex_core.payments p ON o.order_id = p.order_id
WHERE o.customer_id = 1;