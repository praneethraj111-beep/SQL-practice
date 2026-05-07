-- SQLBolt Leson 15 : -- Deleting rows

-- Task 1 : -- This database is getting too big, lets remove all movies that were released before 2005.
DELETE FROM movies WHERE year < 2005;

-- Task 2 : -- Andrew Stanton has also left the studio, so please remove all movies directed by him.
DELETE from movies WHERE director = "Andrew Stanton";