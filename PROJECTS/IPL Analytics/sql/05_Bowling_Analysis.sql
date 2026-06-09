-- BOWLING ANALYSIS

-- 1. Most Wickets

select 
	bowler,
	COUNT(player_dismissed) as wickets
from ipl_analytics.deliveries
where player_dismissed is not null
	AND LENGTH(player_dismissed) > 0
  AND dismissal_kind NOT IN ('run out', 'retired hurt', 'obstructing the field')
group by bowler 
order by wickets desc;

-- 2. Top 10 Wicket Takers

select 
	bowler,
	COUNT(*) as wickets
from ipl_analytics.deliveries
where player_dismissed is not null
	AND LENGTH(player_dismissed) > 0
	AND dismissal_kind NOT IN ('run out', 'retired hurt', 'obstructing the field')
group by bowler 
order by wickets desc
limit 10;

-- 3. Purple Cap Winners By Season

WITH season_wickets AS
(
SELECT
    m.season,
    d.bowler,
    COUNT(d.player_dismissed) AS wickets
FROM ipl_analytics.deliveries d
JOIN ipl_analytics.matches m
ON d.match_id = m.id
WHERE d.player_dismissed IS NOT null
	AND d.player_dismissed <> ''          -- Exclude empty strings
    AND d.player_dismissed <> 'None'      -- Exclude literal 'None' text
    AND d.dismissal_kind NOT IN ('run out', 'retired hurt', 'obstructing the field')
GROUP BY m.season,d.bowler
)
SELECT *
FROM
(
SELECT *,
       RANK() OVER
       (PARTITION BY season ORDER BY wickets DESC) rnk
FROM season_wickets
)x
WHERE rnk = 1;


-- 4. Most Dot Balls

SELECT
    bowler,
    COUNT(*) AS dot_balls
FROM ipl_analytics.deliveries
WHERE total_runs = 0
GROUP BY bowler
ORDER BY dot_balls DESC;


-- 5. Economy Rate

SELECT
    bowler,
    ROUND(
      SUM(total_runs)*6.0/COUNT(*),
      2
    ) AS economy
FROM ipl_analytics.deliveries
GROUP BY bowler
HAVING COUNT(*) > 500
ORDER BY economy;


-- 6. Best Bowling Figures


SELECT
    match_id,
    bowler,
    COUNT(player_dismissed) AS wickets
FROM ipl_analytics.deliveries
GROUP BY match_id,bowler
ORDER BY wickets DESC;

-- 7. Bowlers Conceding Least Runs

SELECT
    bowler,
    SUM(total_runs) AS runs_given
FROM ipl_analytics.deliveries
GROUP BY bowler
ORDER BY runs_given;


-- 8. Most Wickets Per Season

WITH season_wickets AS
(
SELECT
    m.season,
    d.bowler,
    COUNT(*) wickets
FROM ipl_analytics.deliveries d
JOIN ipl_analytics.matches m
ON d.match_id = m.id
WHERE d.player_dismissed IS NOT NULL
GROUP BY m.season,d.bowler
)
SELECT *,
       DENSE_RANK() OVER
       (PARTITION BY season ORDER BY wickets DESC) ranking
FROM season_wickets;


-- 9. Wickets By Dismissal Type

SELECT
    dismissal_kind,
    COUNT(*) AS dismissals
FROM ipl_analytics.deliveries
WHERE dismissal_kind IS NOT null
GROUP BY dismissal_kind
ORDER BY dismissals DESC;



-- 10. Most Caught-and-Bowled Dismissals

SELECT
    bowler,
    COUNT(*) AS wickets
FROM ipl_analytics.deliveries
WHERE dismissal_kind = 'caught and bowled'
GROUP BY bowler
ORDER BY wickets DESC;


-- 11. Bowlers In Super Overs

SELECT
    bowler,
    COUNT(*) balls_bowled
FROM ipl_analytics.deliveries
WHERE is_super_over = 1
GROUP BY bowler
ORDER BY balls_bowled DESC;


-- 12. Five-Wicket Hauls

SELECT
    match_id,
    bowler,
    COUNT(player_dismissed) AS wickets
FROM ipl_analytics.deliveries
GROUP BY match_id,bowler
HAVING COUNT(player_dismissed) >= 5
ORDER BY wickets DESC;