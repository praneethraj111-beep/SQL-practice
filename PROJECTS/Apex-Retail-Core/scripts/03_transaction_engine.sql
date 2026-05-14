-- 1. Tell the database to look into our schema for everything in this session
SET search_path TO apex_core, public;

-- 2. Now create the table (Notice we use dm_email directly now)
CREATE TABLE apex_core.customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email dm_email UNIQUE NOT NULL, -- The search_path makes this visible
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- . Orders Table (The High-Level Transaction)
CREATE TABLE apex_core.orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES apex_core.customers(customer_id),
    order_status apex_core.order_status DEFAULT 'pending', -- Using our custom ENUM
    total_amount DECIMAL(15, 2) DEFAULT 0.00,
    shipping_address TEXT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--4 . Order Items (The Granular Detail)
CREATE TABLE apex_core.order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES apex_core.orders(order_id) ON DELETE CASCADE,
    variant_id INT REFERENCES apex_core.product_variants(variant_id),
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(12, 2) NOT NULL, -- Price at the time of purchase
    line_total DECIMAL(12, 2) GENERATED ALWAYS AS (quantity * unit_price) STORED
);

-- 5. Apply the Automation Trigger to the Orders table
CREATE TRIGGER trg_update_order_time
BEFORE UPDATE ON apex_core.orders
FOR EACH ROW
EXECUTE FUNCTION apex_core.update_timestamp();

-- 6. Payments Table (Operational Record)
CREATE TABLE apex_core.payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES apex_core.orders(order_id),
    payment_method VARCHAR(50), -- 'Credit Card', 'UPI', 'NetBanking'
    transaction_id VARCHAR(100) UNIQUE,
    amount_paid DECIMAL(15, 2) NOT NULL,
    payment_status VARCHAR(20) CHECK (payment_status IN ('success', 'failed', 'refunded')),
    paid_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);