-- SQLBolt Lesson 5 : Simple select Queries Review

-- Task 1 : List all the canadian cities and their population
SELECT city,population FROM north_american_cities WHERE country = "Canada";

-- Task 2 : Order all the cities in the United States by their latitude from north to south
SELECT city,latitude FROM north_american_cities WHERE country = "United States" order by latitude DESC;

-- Task 3 : List all the cities west of chicago,ordered from west to east
SELECT city,longitude FROM north_american_cities where longitude < -87.629798 order by longitude ASC;

-- Task 4 : List the two largest cities in Mexico (by population)
SELECT city, population FROM north_american_cities WHERE country LIKE "Mexico" ORDER BY population DESC LIMIT 2;

-- Task 5 : List the third and fourth largest cities (by population) in the United States and their population
SELECT city, population FROM north_american_cities where country = "United States" order by population DESC limit 2 offset 2;