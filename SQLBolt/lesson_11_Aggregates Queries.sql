-- SQLBolt Lesson 11 : -- Queries with aggregates Part. 2
-- Task 1 : -- Find the number of Artists in the studio (without a HAVING clause)
SELECT role, COUNT(*) as Number_of_artists FROM employees WHERE role = "Artists";

-- Task 2 : -- Find the number of Employees of each role in the studio
SELECT role, COUNT(*) FROM employees GROUP BY role;

-- Task 3 : -- Find the total number of years employed by all Engineers
SELECT role, SUM(years_employed) FROM employees GROUP BY role HAVING role = "Engineer";