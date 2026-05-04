-- SQLBolt Lesson 2 : Queries with constraints (where clause)

-- Task 1 : Find the movie with a row id of 6
SELECT title FROM movies WHERE id = 6;

-- Task 2 : Find the movies released in the years between 2000 and 2010
SELECT title FROM movies WHERE year BETWEEN 2000 AND 2010;

-- Task 3 : Find the movies not released in the years between 2000 and 2010
SELECT title FROM movies WHERE year NOT BETWEEN 2000 AND 2010;

-- Task 4 : Find the first 5 pixar movies and their release year
SELECT title FROM movies where year limit 5;