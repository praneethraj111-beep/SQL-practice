-- BATTING ANALYSIS

-- TASK 1 : TOP RUN SCORERS
select batsman, SUM(batsman_runs) as total_runs
from ipl_analytics.deliveries 
group by batsman 
order by total_runs desc;

-- TASK 2 : TOP 10 RUN SCORERS
select batsman,SUM(batsman_runs) as total_runs
from ipl_analytics.deliveries d group by batsman 
order by total_runs desc
limit 10;

--TASK 3 : MOST SIXES
select batsman, 
count(*) as sixes
from ipl_analytics.deliveries
where batsman_runs = 6
group by batsman 
order by sixes desc;

-- TASK 4 : MOST FOURS
select batsman, 
count(*) as fours
from ipl_analytics.deliveries
where batsman_runs = 4
group by batsman 
order by fours desc;

-- task 5 : HIGHEST INDIVIDUAL SEASON RUNS
select m.season,
	d.batsman,SUM(d.batsman_runs) as runs
	from ipl_analytics.deliveries d
	join ipl_analytics.matches m 
	on d.match_id = m.id 
	group by m.season, d.batsman
	order by runs desc;
	
-- TASK 6 : ORANGE CAP WINNER EVERY SEASON

with season_runs as 
(
	select 
		m.season,d.batsman,
		SUM(d.batsman_runs) as runs
		from ipl_analytics.deliveries d
		join ipl_analytics.matches m
		on d.match_id = m.id 
		group by m.season, d.batsman
)
select *
from 
(
	select *,
		rank() over
		(partition by season order by runs DESC) rnk
	from season_runs
)x
where rnk = 1;

-- TASK 7 : CAREER STRIKE RATE

select
	batsman,
	ROUND(
		SUM(batsman_runs)*100.0/COUNT(*),
		2
	) as strike_rate
from ipl_analytics.deliveries d 
group by batsman 
having count(*) > 500
order by strike_rate desc;

-- TASK 8 : PLAYERS WITH MOST BALLS FACED

select 
	batsman, 
	COUNT(*) as balls_faced
from ipl_analytics.deliveries d 
group by batsman 
order by balls_faced desc;

--TASK 9 : BATTING AVERAGE

WITH runs_cte AS
(
    SELECT
        batsman,
        SUM(batsman_runs) AS runs
    FROM ipl_analytics.deliveries
    GROUP BY batsman
),
dismissals_cte AS
(
    SELECT
        player_dismissed AS batsman,
        COUNT(*) AS dismissals
    FROM ipl_analytics.deliveries
    WHERE player_dismissed IS NOT NULL
    GROUP BY player_dismissed
)
SELECT
    r.batsman,
    r.runs,
    COALESCE(d.dismissals,0) AS dismissals,
    ROUND(
        r.runs * 1.0 /
        NULLIF(d.dismissals,0),
        2
    ) AS batting_average
FROM runs_cte r
LEFT JOIN dismissals_cte d
ON r.batsman = d.batsman
WHERE r.runs > 1000
ORDER BY batting_average DESC;

-- TASK 10 : MOST PLAYER OF MATCH AWARDS

select 
	player_of_match,
	COUNT(*) as awards
from ipl_analytics.matches 
group by player_of_match 
order by awards desc;

-- TASK 11 : TOP RUN SCORERS PER SEASON

with season_runs as 
(
select
	m.season,
	d.batsman,
	SUM(batsman_runs) as runs
from ipl_analytics.deliveries d
join ipl_analytics.matches m
on d.match_id = m.id
group by m.season, d.batsman
)
SELECT *
FROM (
    SELECT 
        season,
        batsman,
        runs,
        DENSE_RANK() OVER (PARTITION BY season ORDER BY runs DESC) AS ranking
    FROM season_runs
) AS ranked_stats
WHERE ranking <= 10;

-- TASK 12 : Century Scores (100+ Runs)
select 
	match_id,
	batsman,
	SUM(batsman_runs) as runs
from ipl_analytics.deliveries 
group by match_id,batsman 
having SUM(batsman_runs) >= 100
order by runs desc;