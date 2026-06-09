-- csv files uploaded from dataset folder for macthes and deliveries data
-- ROW COUNTS

select COUNT(*) as total_matches
from ipl_analytics.matches;

SELECT COUNT(*) AS total_deliveries
FROM ipl_analytics.deliveries;

-- Null Checks

SELECT COUNT(*)
FROM ipl_analytics.matches
WHERE winner IS NULL;

SELECT COUNT(*)
FROM ipl_analytics.deliveries
WHERE batsman IS NULL;
