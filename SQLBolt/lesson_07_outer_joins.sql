-- SQLBolt Lesson 7 : OUTER JOINs

-- Task 1 : Find the list of all buildings that have employees
SELECT distinct building FROM employees;

-- Task 2 : Find the list of all buildings and their capacity
SELECT * FROM buildings;

-- Task 3 : List all buildings and the distinct employee roles in each building (including empty buildings)
SELECT distinct Building_name,role FROM buildings LEFT JOIN employees on building_name = building;