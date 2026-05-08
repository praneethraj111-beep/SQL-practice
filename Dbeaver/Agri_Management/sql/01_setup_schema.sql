
-- =========================================================
-- 1. CLEANUP: Remove old versions (Reverse order of dependency)
-- =========================================================
DROP TABLE IF EXISTS expenditures;
DROP TABLE IF EXISTS growth_cycles;
DROP TABLE IF EXISTS crops;

-- =========================================================
-- 2. SCHEMA: Create the tables (Parent -> Child -> Grandchild)
-- =========================================================
CREATE TABLE crops (
    crop_id SERIAL PRIMARY KEY,
    crop_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    typical_duration_days INTEGER
);

CREATE TABLE growth_cycles (
    cycle_id SERIAL PRIMARY KEY,
    crop_id INTEGER NOT NULL REFERENCES crops(crop_id),
    planting_date DATE NOT NULL,
    expected_harvest_date DATE,
    yield_kg DECIMAL(12,2),
    status VARCHAR(20) DEFAULT 'Active'
);

DROP TABLE IF EXISTS public.expenditures;

CREATE TABLE public.expenditures (
    expense_id SERIAL PRIMARY KEY,
    cycle_id INTEGER NOT NULL REFERENCES public.growth_cycles(cycle_id),
    category VARCHAR(100) NOT NULL, -- Matches CSV header
    amount DECIMAL(12,2) NOT NULL,   -- Matches CSV header
    expense_date DATE DEFAULT CURRENT_DATE -- Matches CSV header
);
