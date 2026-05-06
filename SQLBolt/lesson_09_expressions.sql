-- SQLBolt Lesson 9 : -- Expressions

-- Task 1 : -- List all movies and their combined sales in millions of dollars 
SELECT title,(domestic_sales+international_sales)/1000000 as combined_sales_millions FROM movies join boxoffice on movies.id = boxoffice.movie_id;

-- Task 2 : -- List all movies and their ratings in percent 
SELECT title, rating * 10 AS rating_percent
FROM movies
  JOIN boxoffice
    ON movies.id = boxoffice.movie_id;

-- Task 3 : -- List all movies that were released on even number years
SELECT title,year from movies where year % 2 = 0;