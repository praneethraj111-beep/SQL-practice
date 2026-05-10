-- 1 : -- Insert Users
insert into users (full_name,email) values 
('Adam Gilchrist','adam.gilly3@gmail.com'),
('Dale Steyn','dale.steyngun@gmail.com'),
('Christiano Ronaldo','ronaldo.christiano@gmail.com');

-- 2 : -- Insert Products
INSERT INTO products (product_name, price)
VALUES 
('Professional Laptop', 75000.00),
('Ergonomic Chair', 12500.00),
('Mechanical Keyboard', 4500.00);


--3 : -- Insert Orders
insert into orders (user_id,product_id,quantity) values 
(1,1,1),(2,2,2),(3,3,1),(1,3,2),(2,1,3);