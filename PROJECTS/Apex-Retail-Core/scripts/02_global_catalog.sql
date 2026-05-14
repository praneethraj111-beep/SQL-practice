-- 1. Categories Table (The Tree)
create table apex_core.categories (
	category_id serial primary key, 
	category_name varchar(100) not null unique, 
	slug varchar(120) unique,  -- For SEO-friendly URLs (e.g., 'smart-electronics')
	created_at timestamp default current_timestamp 
);

-- 2. Brands Table
create table apex_core.brands (
	brand_id serial primary key, 
	brand_name varchar(100) not null unique, 
	origin_country varchar(50), 
	created_at timestamp default current_timestamp
);

-- 3. Products Table (The Core)
CREATE TABLE apex_core.products (
    product_id SERIAL PRIMARY KEY,
    sku VARCHAR(50) UNIQUE NOT NULL, -- Stock Keeping Unit
    product_name VARCHAR(255) NOT NULL,
    brand_id INT REFERENCES apex_core.brands(brand_id) ON DELETE SET NULL,
    category_id INT REFERENCES apex_core.categories(category_id) ON DELETE CASCADE,
    base_price DECIMAL(12, 2) NOT NULL CHECK (base_price > 0),
    discount_pct DECIMAL(5, 2) DEFAULT 0 CHECK (discount_pct >= 0 AND discount_pct <= 100),
    stock_quantity INT DEFAULT 0 CHECK (stock_quantity >= 0),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Renaming the function from the mistake (plural) to the correct (singular)
ALTER FUNCTION apex_core.update_timestamps() RENAME TO update_timestamp;

--  Remove the trigger that was using the old name
DROP TRIGGER IF EXISTS trg_update_product_time ON apex_core.products;

--  Create the trigger again using the correct singular name
CREATE TRIGGER trg_update_product_time
BEFORE UPDATE ON apex_core.products
FOR EACH ROW
EXECUTE FUNCTION apex_core.update_timestamp();

-- 4. Product Variants (Handles Sizes, Colors, etc.)
CREATE TABLE apex_core.product_variants (
    variant_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES apex_core.products(product_id) ON DELETE CASCADE,
    sku_variant VARCHAR(50) UNIQUE NOT NULL,
    variant_name VARCHAR(100), -- e.g., 'Large / Blue'
    additional_price DECIMAL(10, 2) DEFAULT 0, -- Cost extra for premium variants
    stock_qty INT DEFAULT 0 CHECK (stock_qty >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Warehouses (Where the goods live)
CREATE TABLE apex_core.warehouses (
    warehouse_id SERIAL PRIMARY KEY,
    warehouse_name VARCHAR(100) NOT NULL,
    location_city VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE
);

-- 6. Inventory (Linking Variants to Warehouses)
CREATE TABLE apex_core.inventory (
    inventory_id SERIAL PRIMARY KEY,
    variant_id INT REFERENCES apex_core.product_variants(variant_id) ON DELETE CASCADE,
    warehouse_id INT REFERENCES apex_core.warehouses(warehouse_id),
    physical_stock INT DEFAULT 0 CHECK (physical_stock >= 0),
    reserved_stock INT DEFAULT 0, -- Stock promised to customers but not yet shipped
    last_restock_date TIMESTAMP
);