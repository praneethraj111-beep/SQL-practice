-- 1. Protect Property Area (No negative square footage)
ALTER TABLE real_estate_pro.dim_properties 
ADD CONSTRAINT check_positive_area CHECK (sq_ft_area > 0);

-- 2. Protect Transaction Amounts (Minimum real estate value)
ALTER TABLE real_estate_pro.fact_transactions 
ADD CONSTRAINT check_min_amount CHECK (amount_inr >= 1000);

-- 3. Protect Transaction Types (Standardize the logic)
ALTER TABLE real_estate_pro.fact_transactions 
ADD CONSTRAINT check_valid_type CHECK (transaction_type IN ('BUY', 'RENT', 'LEASE'));

-- 4. Protect Dates (No transactions from the distant past)
ALTER TABLE real_estate_pro.fact_transactions 
ADD CONSTRAINT check_logical_date CHECK (transaction_date > '2000-01-01');

-- This is a two-step process in PostgreSQL: First, you define a Function, then you attach a Trigger to the table.
-- Step A: The Function (The "Brain")
CREATE OR REPLACE FUNCTION real_estate_pro.fn_deactivate_property()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.transaction_type = 'BUY' THEN
        UPDATE real_estate_pro.dim_properties
        SET is_active = FALSE
        WHERE property_id = NEW.property_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Step B: The Trigger (The "Watcher")
CREATE TRIGGER trg_after_buy
AFTER INSERT ON real_estate_pro.fact_transactions
FOR EACH ROW
EXECUTE FUNCTION real_estate_pro.fn_deactivate_property();