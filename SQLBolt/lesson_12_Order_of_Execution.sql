-- SQLBolt Lesson 12 : -- Order of execution
-- Task 1 : Find the number of movies each director has directed
SELECT director, COUNT(id) as Num_movies_directed FROM movies GROUP BY director;

-- Task 2 : -- Find the total domestic and international sales that can be attributed to each director
SELECT Director, SUM(domestic_sales + international_sales) as cumulative_sales_from_all_movies FROM movies INNER JOIN boxoffice ON movies.id = boxoffice.movie_id GROUP BY Director;