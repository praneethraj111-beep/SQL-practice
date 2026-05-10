-- REPORT: Detailed Order History
-- Purpose: Combine users, products, and orders to see total spend per transaction.

-- TASK -- A Filter to only show items that cost more than 5,000.
--A Sort to show the highest price first.

select  u.full_name,p.product_name,p.price 
from orders o join users u on o.user_id = u.user_id 
join products p on o.product_id = p.product_id 
where p.price > 5000 order by p.price desc;

-- "What is the total revenue we have made across all orders?"
select sum(o.quantity * p.price) as grand_total_revenue
from orders o join products p on o.product_id = p.product_id;

-- The manager now wants to see the total revenue per customer.

select u.full_name,sum(o.quantity * p.price) as total_customer_spend 
from orders o join users u on o.user_id = u.user_id 
join products p on o.product_id = p.product_id group by u.full_name 
order by total_customer_spend desc;

-- find people who haven't spent any money. This is how marketing teams find people to send "Discount Emails" to.

select u.full_name,u.email from users u
left join orders o on u.user_id = o.user_id
where o.order_id is null;

-- Imagine the "Professional Laptop" isn't selling well, and the boss wants to drop the price to 68,000.
update products set price = 68000.00 where product_name = 'Professional Laptop';

-- A customer changes their professional email.
update users set email = 'christiano.ronaldo@gmail.com' where full_name = 'Christiano Ronaldo';

-- The manager wants to know which "Country" or "City" orders are coming from. You need to add a column that wasn't there before.
alter table users add column city varchar(50) default 'Hyderabad';

--  We want to find all orders where the quantity is greater than the average quantity of all orders in the system.
select order_id,user_id,quantity from orders 
where quantity > (select avg(quantity) from orders);

-- Managers often want to see names, not IDs. Let's find the names of users who bought the most expensive product in the database without knowing what that product is.
select distinct full_name from users where user_id in (select  user_id from orders  
where product_id = (select product_id from products order by price desc limit 1) );