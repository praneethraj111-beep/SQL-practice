-- SQLBolt Lesson 10 : -- Queries with aggregates Part. 1

-- Task : -- Find the longest time that an employee has been at the studio
SELECT MAX(years_employed) as Max_years_employed FROM employees;

-- Task : -- For each role, find the average number of years employed by employees in that role
SELECT role,AVG(years_employed) FROM employees GROUP BY role;

-- Task : -- Find the total number of employee years worked in each building
SELECT building, SUM(years_employed) as Total_years_employed FROM employees GROUP BY building;
