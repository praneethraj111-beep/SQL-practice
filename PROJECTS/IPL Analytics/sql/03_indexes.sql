CREATE INDEX idx_match_id
ON ipl_analytics.deliveries(match_id);

CREATE INDEX idx_batsman
ON ipl_analytics.deliveries(batsman);

CREATE INDEX idx_bowler
ON ipl_analytics.deliveries(bowler);

CREATE INDEX idx_batting_team
ON ipl_analytics.deliveries(batting_team);

CREATE INDEX idx_bowling_team
ON ipl_analytics.deliveries(bowling_team);

CREATE INDEX idx_winner
ON ipl_analytics.matches(winner);

CREATE INDEX idx_season
ON ipl_analytics.matches(season);