-- SQLZoo : SELECT basics
-- Exercises to repeat SELECT and WHERE logic

-- Task 1 : show the population of Germany
SELECT population FROM world
  WHERE name = 'Germany'

-- Task 2 : Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.
SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');

-- Task 3 : Shows countries with an area of 250,000-300,000 sq. km. Modify it to show the country and the area for countries with an area between 200,000 and 250,000.
SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000


-- SELECT BASICS QUIZ

-- Quiz Q1 : -- Select the code which name and popuation for
--countries with a population between 1000000 and 1250000
SELECT name, population FROM world WHERE population BETWEEN 1000000 AND 1250000;

-- Quiz Q2 : -- countries starting with 'AL'
SELECT name, population FROM world WHERE name LIKE "Al%";
-- Result : Table E (Albania,Algeria)

--Quiz Q3 : -- Select the code which shows the countries that end in A or L
SELECT name FROM world
 WHERE name LIKE '%a' OR name LIKE '%l';

-- Quiz Q4 : -- Show the countries in Europe with a name length of 5 
SELECT name,length(name) FROM world WHERE length(name) = 5 and region = 'Europe';
-- Result Table showing Italy ,Malta ,Spain

--Quiz Q5 : -- Show the name and double the area for countries with 64000 population(area*2)
SELECT name, area*2 FROM world WHERE population = 64000;
-- Result : Andorra - 936

--Quiz Q6 : -- Countries with area larger than 50000 and population smaller than 10000000
SELECT name, area, population FROM world WHERE area > 50000 AND population < 10000000;

 Question Q7 : -- shows the population density of China, Australia, Nigeria and France
SELECT name, population/area FROM world WHERE name IN ('China', 'Nigeria', 'France', 'Australia');