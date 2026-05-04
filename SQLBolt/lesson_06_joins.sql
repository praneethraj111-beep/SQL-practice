-- SQLBolt Lesson 6 : Multi-table Queries with JOINS

-- Task 1 : Find the domestic and international sales for each movies
SELECT title,domestic_sales,international_sales FROM movies inner join boxoffice on movies.id = boxoffice.movie_id;

-- Task 2 : Show the sales numbers for each movie that did better internationally rather than domestically
SELECT title,domestic_sales,international_sales FROM movies inner join boxoffice on movies.id = boxoffice.movie_id where international_sales > Domestic_sales;

-- Task 3 : List all the movies by their ratings in descending order
SELECT title,domestic_sales,international_sales FROM movies inner join boxoffice on movies.id = boxoffice.movie_id order by rating DESC;