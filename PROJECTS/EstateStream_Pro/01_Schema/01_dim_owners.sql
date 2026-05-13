create table real_estate_pro.dim_owners (
owner_id serial primary key, 
full_name varchar(100) not null, 
contact_number varchar(15) unique, 
email_address varchar(100), 
owner_type varchar(20) default 'Individual' -- Individual or Company
);