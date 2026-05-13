-- 1. Add a status column if not already there (Our previous script had 'is_active')
-- 2. "Deactivate" the property instead of deleting it
UPDATE real_estate_pro.dim_properties
SET is_active = FALSE
WHERE property_name = 'La Pulga Estate';

-- 3. Now, your reports should only show active properties
SELECT * FROM real_estate_pro.v_investor_summary
WHERE property IN (SELECT property_name FROM real_estate_pro.dim_properties WHERE is_active = TRUE);