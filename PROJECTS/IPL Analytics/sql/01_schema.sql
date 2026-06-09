-- CREATE SCHEMA
create schema ipl_analytics;

--CREATE TABLE FOR MATCHES
create table ipl_analytics.matches (
	 id INT PRIMARY KEY,
    season INT,
    city VARCHAR(100),
    match_date DATE,
    team1 VARCHAR(100),
    team2 VARCHAR(100),
    toss_winner VARCHAR(100),
    toss_decision VARCHAR(20),
    result VARCHAR(50),
    dl_applied INT,
    winner VARCHAR(100),
    win_by_runs INT,
    win_by_wickets INT,
    player_of_match VARCHAR(100),
    venue VARCHAR(255),
    umpire1 VARCHAR(100),
    umpire2 VARCHAR(100),
    umpire3 VARCHAR(100)
);

--CREATE TABLE FOR DELIVERIES
create table ipl_analytics.deliveries (
	 match_id INT,
    inning INT,
    batting_team VARCHAR(100),
    bowling_team VARCHAR(100),
    over_no INT,
    ball INT,
    batsman VARCHAR(100),
    non_striker VARCHAR(100),
    bowler VARCHAR(100),
    is_super_over INT,
    wide_runs INT,
    bye_runs INT,
    legbye_runs INT,
    noball_runs INT,
    penalty_runs INT,
    batsman_runs INT,
    extra_runs INT,
    total_runs INT,
    player_dismissed VARCHAR(100),
    dismissal_kind VARCHAR(100),
    fielder VARCHAR(100),
    
    foreign key (match_id)
    references ipl_analytics.matches(id)
    
);

alter table ipl_analytics.matches
alter column season type varchar(20);

ALTER table ipl_analytics.matches DROP COLUMN match_date;
ALTER TABLE ipl_analytics.matches ADD COLUMN match_date DATE;