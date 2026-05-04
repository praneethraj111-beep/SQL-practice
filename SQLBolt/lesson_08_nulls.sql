-- SQLBolt Lessons 8 : A short note on NULLs

-- Task 1 : Find the name and role of all employees who have not been assigned to a building
SELECT name,role FROM employees where building is null;

-- Task 2 : Find the names of the buildings that hold no employees
select building_name from buildings left join employees on building_name = building where name is null;