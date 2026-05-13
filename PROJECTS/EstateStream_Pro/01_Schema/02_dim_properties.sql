create table real_estate_pro.dim_properties (
property_id serial primary key, 
owner_id integer references real_estate_pro.dim_owners(owner_id),
property_name varchar(100) not null, 
property_type varchar(20) not null,
location varchar(50) not null, 
sq_ft_area integer not null, 
is_active boolean default true );