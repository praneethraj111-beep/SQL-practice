-- 1 : Create the dedicated schema for our high-volume engine
create schema if not exists apex_core;

-- 2 : create a custom domain for Email validation (High- Volume requirement : Data Quality)
-- Note: 'VALUE' is a reserved keyword in constraints representing the data being checked.
create domain dm_email as text 
check (value ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$');

-- 3: Order Status Type (Scoped to our schema)
create type apex_core.order_status as enum (
'pending', 'processed', 'shipped', 'delivered', 'cancelled', 'returned');

-- 4 : The Automation Function
create or replace function apex_core.update_timestamps() 
returns trigger as $$ 
begin 
	new.updated_at = current_timestamp;
	return new;
end;
$$ language plpgsql;