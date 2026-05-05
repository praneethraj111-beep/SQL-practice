-- SQLZoo Tutorial : -- SELECT fron Nobel

-- Task : -- Winners from 1950
SELECT yr,subject,winner
  FROM nobel
 WHERE yr = 1950;

-- Task : -- 1962 Literature
-- Show who won the 1962 prize for literature.
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature';

-- Task : -- Albert Einstein
-- Show the year and subject that won 'Albert Einstein' his prize.
select yr,subject from nobel where winner = 'Albert Einstein';

-- Task : -- Give the name of the 'Peace' winners since the year 2000, including 2000.
select winner from nobel where yr >= 2000 and subject = 'peace';

-- Task : -- Show all details (yr, subject, winner) of the literature prize winners for 1980 to 1989 inclusive.
select yr,subject,winner from nobel where yr between 1980 and 1989 and subject = 'literature';

-- Task : Show all details of the presidential winners:
SELECT * FROM nobel WHERE winner IN('Theodore Roosevelt','Thomas Woodrow Wilson','Jimmy Carter','Barack Obama');

-- Task : -- Show the winners with first name John
select winner from nobel where winner like 'John%';

-- Task : -- Show the year, subject, and name of physics winners for 1980 together with the chemistry winners for 1984.
select yr,subject,winner from nobel where (subject = 'Physics' and yr = 1980) OR ( subject = 'Chemistry' and yr = 1984);

-- Task : -- Show the year, subject, and name of winners for 1980 excluding chemistry and medicine
SELECT yr,subject,winner from nobel where yr = 1980 and subject not in ('Chemistry','Medicine');

-- Task : -- Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004)
select yr,subject,winner from nobel where (subject = 'Medicine' and yr<1910) or (subject = 'Literature' and yr>=2004);
