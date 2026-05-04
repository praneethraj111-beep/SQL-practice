--SQLBolt Lesson 3 : Queries with constraints (String operators)

-- Task 1 : find all the Toy story movies
SELECT title FROM movies WHERE title like "Toy story%";

-- Task 2 : Find all the movies directed by John Lasseter
SELECT title FROM movies WHERE director like "John Lasseter";

-- Task 4 : Find all the movies (and diretor) not directed by John Lasseter
SELECT title FROM movies WHERE director not like "John Lasseter";

-- Task 4 : Find all the WALL-* movies
SELECT title FROM movies where title like "WALL-%";