-- Testing : -- The Integrity Tally
-- verify that every expenditure is correctly linked to a crop and a growth cyclE.
SELECT 
    c.crop_name, 
    gc.planting_date, 
    e.category AS expense_type, 
    e.amount AS cost_inr
FROM public.crops c
JOIN public.growth_cycles gc ON c.crop_id = gc.crop_id
JOIN public.expenditures e ON gc.cycle_id = e.cycle_id
ORDER BY c.crop_name, gc.planting_date;

-- Task 1 : -- Business Intelligence Queries
-- Total Investment per Crop
-- Find out which crop is the most expensive to maintain.
SELECT c.crop_name, SUM(e.amount) AS total_investment
FROM crops c
JOIN growth_cycles gc ON c.crop_id = gc.crop_id
JOIN expenditures e ON gc.cycle_id = e.cycle_id
GROUP BY c.crop_name
ORDER BY total_investment DESC;

-- Task 2 : -- Yield Efficiency
SELECT crop_name, AVG(yield_kg) AS average_yield
FROM crops c
JOIN growth_cycles gc ON c.crop_id = gc.crop_id
GROUP BY crop_name;

-- Task 3 : -- Expense Distribution
--See where the most money is being spent across the entire farm (Seeds, Fertilizer, Labor, etc.)
SELECT category, SUM(amount) AS total_spent
FROM expenditures
GROUP BY category
ORDER BY total_spent DESC;