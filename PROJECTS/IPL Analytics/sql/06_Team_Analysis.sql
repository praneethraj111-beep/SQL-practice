-- 1. Most Successful Teams

select 
	winner, 
	COUNT(*) as wins
from ipl_analytics.matches 
where winner is not null 
group by winner 
order by wins desc;

-- 2. Win Percentage


WITH AllParticipants AS (
    -- Dynamically extract all unique team names
    SELECT team1 AS team FROM ipl_analytics.matches
    UNION
    SELECT team2 AS team FROM ipl_analytics.matches
),
MatchStats AS (
    SELECT 
        ap.team,
        -- Count total matches per team
        (SELECT COUNT(*) FROM ipl_analytics.matches WHERE team1 = ap.team OR team2 = ap.team) AS total_played,
        -- Count wins per team
        (SELECT COUNT(*) FROM ipl_analytics.matches WHERE winner = ap.team) AS wins
    FROM AllParticipants ap
)
SELECT 
    team,
    total_played,
    wins,
    ROUND(100.0 * wins / total_played, 2) AS win_percentage
FROM MatchStats
ORDER BY win_percentage DESC;

-- 3. Toss Winner vs Match Winner

SELECT 
    COUNT(*) AS total_matches,
    SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) AS toss_winner_matches_won,
    ROUND(100.0 * SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) / COUNT(*), 2) AS win_percentage
FROM ipl_analytics.matches
WHERE winner IS NOT NULL;

-- 4. Toss Decision Analysis

SELECT
    toss_decision,
    COUNT(*) AS total_toss_decisions,
    SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) AS successful_outcomes,
    ROUND(100.0 * SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) / COUNT(*), 2) AS success_rate
FROM ipl_analytics.matches
WHERE toss_decision IS NOT NULL
GROUP BY toss_decision;

-- 5. Team-wise Toss Wins

SELECT toss_winner, COUNT(*) 
FROM ipl_analytics.matches 
GROUP BY toss_winner;


