-- 1. Index for Location (Speeds up city-based searches)
CREATE INDEX idx_property_location ON real_estate_pro.dim_properties(location);

-- 2. Index for Transaction Dates (Speeds up monthly/yearly reports)
CREATE INDEX idx_transaction_date ON real_estate_pro.fact_transactions(transaction_date);

-- 3. Foreign Key Indexes (Speeds up our JOINS)
CREATE INDEX idx_prop_owner_id ON real_estate_pro.dim_properties(owner_id);
<<<<<<< HEAD
CREATE INDEX idx_fact_property_id ON real_estate_pro.fact_transactions(property_id);
=======
CREATE INDEX idx_fact_property_id ON real_estate_pro.fact_transactions(property_id);
>>>>>>> f244aa3 (completed estate pro)
