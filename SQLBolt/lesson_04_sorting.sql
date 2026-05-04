-- SQLBolt Lesson 4 : Filtering and Sorting Query results

-- Task 1 : List all the directors of pixar movies (alphabetically),without duplicates
SELECT distinct director FROM movies order by director ASC;

-- Task 2 : List the last four pixar movies released (order from most recent to least)
SELECT title FROM movies order by year DESC limit 4;

-- Task 3 : List the first five pixar movies sorted alphabetically
SELECT title FROM movies order by titles ASC limit 5;

-- Task 4 : List the next five pixar movies sorted alphabetically
SELECT title FROM movies order by title ASC limit 5 offset 5;