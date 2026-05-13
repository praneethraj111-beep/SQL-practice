-- 1. INSERT THE LEGENDS (Owners)
INSERT INTO real_estate_pro.dim_owners (full_name, contact_number, email_address, owner_type)
VALUES 
('Zinedine Zidane', '+33-10101010', 'zidane@madrid.com', 'Individual'),
('Cristiano Ronaldo', '+351-07070707', 'cr7@lisbon.com', 'Individual'),
('Lionel Messi', '+54-10101010', 'leo.messi@barca.com', 'Individual'),
('Ronaldinho Gaucho', '+55-80808080', 'joga.bonito@rio.com', 'Individual'),
('Thierry Henry', '+44-14141414', 'king.henry@london.com', 'Individual');

-- 2. INSERT THE PROPERTIES
-- Note: owner_id 1 is Zidane, 2 is Ronaldo, etc. 
INSERT INTO real_estate_pro.dim_properties (owner_id, property_name, property_type, location, sq_ft_area)
VALUES 
(1, 'Galactico Manor', 'Villa', 'Madrid', 8500),
(2, 'CR7 Museum View', 'Penthouse', 'Lisbon', 4200),
(3, 'La Pulga Estate', 'Mansion', 'Barcelona', 12000),
(4, 'Joga Bonito Loft', 'Apartment', 'Rio', 2500),
(5, 'Highbury Heights', 'Penthouse', 'London', 3800);

-- 3. INSERT THE TRANSACTIONS
-- Note: property_id links back to the properties above
INSERT INTO real_estate_pro.fact_transactions (property_id, transaction_date, transaction_type, amount_inr)
VALUES 
(1, '2026-01-15', 'BUY', 250000000.00),
(2, '2026-02-10', 'RENT', 1500000.00),
(3, '2026-03-05', 'BUY', 450000000.00),
(4, '2026-04-12', 'RENT', 500000.00),
(5, '2026-05-01', 'RENT', 800000.00);