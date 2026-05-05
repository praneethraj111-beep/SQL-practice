-- SELECT from WORLD Tutorial

Task : Per capita GDP
-- Give the name and the per capita GDP for those countries with a population of at least 200 million.
select name , GDP/population as per_capita_GDP from world where population > 200000000;
-- Result : i changed the GDP/Population to Per_capita_GDP so the task matches exactly

-- Task : South America In millions
-- Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions.
 select name,population/1000000 from world where continent = 'South America'; 

-- Task :  Two way to be big
-- Two ways to be big: A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million.
--Show the countries that are big by area or big by population. Show name, population and area.
select name,population,area from world where area>3000000 or population>250000000;

-- Task : One or the other (but not both)
-- Exclusive OR (XOR). Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both. Show name, population and area.
-- Australia has a big area but a small population, it should be included.
-- Indonesia has a big population but a small area, it should be included.
-- China has a big population and big area, it should be excluded.
-- United Kingdom has a small population and a small area, it should be excluded.
SELECT name,population,area FROM world WHERE (population > 250000000 or area > 3000000 ) AND NOT (population > 250000000 and area > 3000000);

-- Task : Rounding
--Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places.
-- For Americas show population in millions and GDP in billions both to 2 decimal places.
select name, ROUND(population/1000000,2),ROUND(gdp/1000000000,2) from world where continent = 'South America';
-- Note :-- Divide by 1000000 (6 zeros) for millions. Divide by 1000000000 (9 zeros) for billions.

-- Task : Trillion dollar economies
-- Show the name and per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000.
-- Show per-capita GDP for the trillion dollar countries to the nearest $1000.
SELECT name,ROUND(gdp/population,-3) from world where gdp>=1000000000000;

-- Task :-- Name and capital have the same length
-- Greece has capital Athens.Each of the strings 'Greece', and 'Athens' has 6 characters.
-- Show the name and capital where the name and the capital have the same number of characters.
--You can use the LENGTH function to find the number of characters in a string
SELECT name,capital from world where LENGTH(name)= LENGTH(capital);

-- Task : -- Matching name and capital
-- The capital of Sweden is Stockholm. Both words start with the letter 'S'.
--Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
SELECT name,capital FROM world where LEFT(name,1) = LEFT(capital,1) and name<>capital;

-- Task : All the vowels
-- Equatorial Guinea and Dominican Republic have all of the vowels (a e i o u) in the name. They don't count because they have more than one word in the name.
-- Find the country that has all the vowels and no spaces in its name.
SELECT name FROM world WHERE name LIKE '%a%'
and name like '%e%'
and name like '%i%'
and name like '%o%'
and name like '%u%'
and name not like '% %';

-- QUIZ 1 : -- Select the code which gives the name of countries beginning with U
SELECT name FROM world WHERE name LIKE 'U%';

-- QUIZ 2 : -- Select the code which shows just the population of United Kingdom?
SELECT population FROM world WHERE name = 'United Kingdom';

--QUIZ 3 : -- Select the answer which shows the problem with this SQL code - the intended result should be the continent of France:
--SELECT continent --FROM world --WHERE 'name' = 'France'
SELECT continent FROM world WHERE name = 'France';
-- Result 'name' is wrong here in the task instead of name they gave task 'name' to confuse.

--QUIZ 4 : --Select the result that would be obtained from the following code:
SELECT name, population / 10 FROM world WHERE population < 10000;
-- Result : Nauru - 990

--QUIZ 5 :-- Select the code which would reveal the name and population of countries in Europe and Asia
SELECT name, population FROM world WHERE continent IN ('Europe', 'Asia');

--QUIZ 6 : -- Select the code which would give two rows
 SELECT name FROM world WHERE name IN ('Cuba', 'Togo');

 --QUIZ 7 : Select the result that would be obtained from this code:
 -- SELECT name FROM world WHERE continent = 'South America' AND population > 40000000
 SELECT name FROM world
 WHERE continent = 'South America'
   AND population > 40000000;
 Result : Brazil,Colombia