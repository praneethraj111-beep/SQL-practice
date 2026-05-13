create table real_estate_pro.fact_transactions (
transaction_id serial primary key, 
property_id integer references real_estate_pro.dim_properties(property_id),
transaction_date date not null, 
transaction_type varchar(10) not null,
amount_inr numeric(15,2) not null, 
brokerage_paid numeric(10,2) );

-- 1. Update Brokerage for the Buy deals (2% Commission)
UPDATE real_estate_pro.fact_transactions
SET brokerage_paid = amount_inr * 0.02
WHERE transaction_type = 'BUY';

-- 2. Update Brokerage for the Rent deals (1 Month Rent)
-- Since amount_inr is the rent, brokerage is usually equal to it
UPDATE real_estate_pro.fact_transactions
SET brokerage_paid = amount_inr
WHERE transaction_type = 'RENT';

UPDATE real_estate_pro.fact_transactions
SET brokerage_paid = amount_inr * 0.05
WHERE brokerage_paid IS NULL;