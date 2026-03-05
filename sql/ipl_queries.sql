CREATE DATABASE ipl_analytics;
use ipl_analytics;

SELECT COUNT(*) FROM matches;
SELECT COUNT(*) FROM deliveries;

SELECT 
    batter,
    SUM(runs_batter) AS total_runs
FROM deliveries
GROUP BY batter
ORDER BY total_runs DESC
LIMIT 10;
SELECT 
    bowler,
    SUM(bowler_wicket) AS total_wickets
FROM deliveries
GROUP BY bowler
ORDER BY total_wickets DESC
LIMIT 10;

SELECT 
    m.venue,
    ROUND(AVG(d.runs_total), 2) AS avg_score
FROM deliveries d
JOIN matches m ON d.match_id = m.match_id
WHERE d.innings = 1
GROUP BY m.venue
ORDER BY avg_score DESC;

DESCRIBE matches;

SELECT 
    toss_decision,
    COUNT(*) AS matches,
    ROUND(
        SUM(CASE WHEN toss_winner = match_won_by THEN 1 ELSE 0 END) 
        / COUNT(*) * 100,
        2
    ) AS toss_win_match_win_pct
FROM matches
GROUP BY toss_decision;


SELECT 
    batter,
    SUM(runs_batter) AS total_runs,
    COUNT(*) AS balls_faced,
    ROUND(SUM(runs_batter) / COUNT(*) * 100, 2) AS strike_rate
FROM deliveries
WHERE runs_batter IS NOT NULL
GROUP BY batter
HAVING total_runs >= 1000
ORDER BY strike_rate DESC
LIMIT 10;

SELECT 
    d.batter,
    SUM(d.runs_batter) AS total_runs_in_wins
FROM deliveries d
JOIN matches m ON d.match_id = m.match_id
WHERE 
    (m.match_won_by = m.team1 AND d.innings = 1)
    OR
    (m.match_won_by = m.team2 AND d.innings = 2)
GROUP BY d.batter
ORDER BY total_runs_in_wins DESC
LIMIT 10;

SELECT 
    batter,
    COUNT(*) AS sixes
FROM deliveries
WHERE runs_batter = 6
GROUP BY batter
ORDER BY sixes DESC
LIMIT 10;

SELECT 
    batter,
    COUNT(*) AS fours
FROM deliveries
WHERE runs_batter = 4
GROUP BY batter
ORDER BY fours DESC
LIMIT 10;

SELECT 
    batter,
    COUNT(*) AS fifties
FROM (
    SELECT 
        match_id,
        batter,
        SUM(runs_batter) AS match_runs
    FROM deliveries
    GROUP BY match_id, batter
    HAVING match_runs >= 50
) AS sub
GROUP BY batter
ORDER BY fifties DESC
LIMIT 10;

SELECT 
    batter,
    COUNT(*) AS centuries
FROM (
    SELECT 
        match_id,
        batter,
        SUM(runs_batter) AS match_runs
    FROM deliveries
    GROUP BY match_id, batter
    HAVING match_runs >= 100
) AS sub
GROUP BY batter
ORDER BY centuries DESC
LIMIT 10;

SELECT 
    batter,
    SUM(runs_batter) AS runs,
    COUNT(*) AS balls,
    ROUND(SUM(runs_batter) / COUNT(*) * 100, 2) AS death_strike_rate
FROM deliveries
WHERE `over` >= 15
GROUP BY batter
HAVING balls >= 300
ORDER BY death_strike_rate DESC
LIMIT 10;

SELECT 
    batter,
    SUM(runs_batter) AS runs,
    COUNT(*) AS balls,
    ROUND(SUM(runs_batter) / COUNT(*) * 100, 2) AS pp_strike_rate
FROM deliveries
WHERE `over` < 6
GROUP BY batter
HAVING balls >= 300
ORDER BY pp_strike_rate DESC
LIMIT 10;

SELECT 
    bowler,
    SUM(bowler_wicket) AS total_wickets
FROM deliveries
GROUP BY bowler
ORDER BY total_wickets DESC
LIMIT 10;

SELECT 
    bowler,
    SUM(runs_total) AS runs_conceded,
    COUNT(*) AS balls_bowled,
    ROUND(SUM(runs_total) / COUNT(*) * 6, 2) AS economy
FROM deliveries
GROUP BY bowler
HAVING balls_bowled >= 1000
ORDER BY economy ASC
LIMIT 10;

SELECT 
    bowler,
    SUM(bowler_wicket) AS wickets,
    COUNT(*) AS balls_bowled,
    ROUND(COUNT(*) / SUM(bowler_wicket), 2) AS strike_rate
FROM deliveries
GROUP BY bowler
HAVING wickets >= 50
ORDER BY strike_rate ASC
LIMIT 10;

SELECT 
    bowler,
    COUNT(*) AS three_wicket_hauls
FROM (
    SELECT 
        match_id,
        bowler,
        SUM(bowler_wicket) AS match_wickets
    FROM deliveries
    GROUP BY match_id, bowler
    HAVING match_wickets >= 3
) AS sub
GROUP BY bowler
ORDER BY three_wicket_hauls DESC
LIMIT 10;

SELECT 
    bowler,
    COUNT(*) AS four_wicket_hauls
FROM (
    SELECT 
        match_id,
        bowler,
        SUM(bowler_wicket) AS match_wickets
    FROM deliveries
    GROUP BY match_id, bowler
    HAVING match_wickets >= 4
) AS sub
GROUP BY bowler
ORDER BY four_wicket_hauls DESC
LIMIT 10;

SELECT 
    bowler,
    SUM(bowler_wicket) AS death_wickets,
    COUNT(*) AS balls,
    ROUND(SUM(runs_total) / COUNT(*) * 6, 2) AS death_economy
FROM deliveries
WHERE `over` >= 15
GROUP BY bowler
HAVING balls >= 300
ORDER BY death_economy ASC
LIMIT 10;

SELECT 
    bowler,
    SUM(bowler_wicket) AS pp_wickets,
    COUNT(*) AS balls,
    ROUND(SUM(runs_total) / COUNT(*) * 6, 2) AS pp_economy
FROM deliveries
WHERE `over` < 6
GROUP BY bowler
HAVING balls >= 500
ORDER BY pp_economy ASC
LIMIT 10;

SELECT 
    d.bowler,
    SUM(d.bowler_wicket) AS wickets_in_wins
FROM deliveries d
JOIN matches m ON d.match_id = m.match_id
WHERE 
    (m.match_won_by = m.team1 AND d.innings = 2)
    OR
    (m.match_won_by = m.team2 AND d.innings = 1)
GROUP BY d.bowler
ORDER BY wickets_in_wins DESC
LIMIT 10;


SELECT 
    team,
    SUM(wins) AS total_wins,
    SUM(matches_played) AS total_matches,
    ROUND(SUM(wins) / SUM(matches_played) * 100, 2) AS win_percentage
FROM (
    SELECT team1 AS team,
           COUNT(*) AS matches_played,
           SUM(CASE WHEN match_won_by = team1 THEN 1 ELSE 0 END) AS wins
    FROM matches
    GROUP BY team1
    
    UNION ALL
    
    SELECT team2 AS team,
           COUNT(*) AS matches_played,
           SUM(CASE WHEN match_won_by = team2 THEN 1 ELSE 0 END) AS wins
    FROM matches
    GROUP BY team2
) AS combined
GROUP BY team
ORDER BY win_percentage DESC;

SELECT 
    ipl_season,
    team,
    SUM(wins) AS total_wins,
    SUM(matches_played) AS total_matches,
    ROUND(SUM(wins) / SUM(matches_played) * 100, 2) AS win_percentage
FROM (
    SELECT 
        ipl_season,
        team1 AS team,
        COUNT(*) AS matches_played,
        SUM(CASE WHEN match_won_by = team1 THEN 1 ELSE 0 END) AS wins
    FROM matches
    GROUP BY ipl_season, team1
    
    UNION ALL
    
    SELECT 
        ipl_season,
        team2 AS team,
        COUNT(*) AS matches_played,
        SUM(CASE WHEN match_won_by = team2 THEN 1 ELSE 0 END) AS wins
    FROM matches
    GROUP BY ipl_season, team2
) AS combined
GROUP BY ipl_season, team
ORDER BY ipl_season, win_percentage DESC;

SELECT 
    match_won_by AS team,
    COUNT(*) AS chasing_wins
FROM matches
WHERE win_type = 'wickets'
GROUP BY match_won_by
ORDER BY chasing_wins DESC;

SELECT 
    match_won_by AS team,
    COUNT(*) AS defending_wins
FROM matches
WHERE win_type = 'runs'
GROUP BY match_won_by
ORDER BY defending_wins DESC;

SELECT 
    team1,
    venue,
    COUNT(*) AS matches_played,
    SUM(CASE WHEN match_won_by = team1 THEN 1 ELSE 0 END) AS wins,
    ROUND(SUM(CASE WHEN match_won_by = team1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS win_pct
FROM matches
GROUP BY team1, venue
ORDER BY win_pct DESC;

SELECT 
    venue,
    ROUND(AVG(first_innings_score), 2) AS avg_first_innings_score
FROM (
    SELECT 
        m.match_id,
        m.venue,
        SUM(d.runs_total) AS first_innings_score
    FROM deliveries d
    JOIN matches m ON d.match_id = m.match_id
    WHERE d.innings = 1
    GROUP BY m.match_id, m.venue
) AS match_scores
GROUP BY venue
HAVING COUNT(*) >= 20
ORDER BY avg_first_innings_score DESC;

SELECT 
    venue,
    COUNT(*) AS total_matches,
    SUM(CASE WHEN win_type = 'wickets' THEN 1 ELSE 0 END) AS chasing_wins,
    ROUND(SUM(CASE WHEN win_type = 'wickets' THEN 1 ELSE 0 END) 
          / COUNT(*) * 100, 2) AS chasing_win_pct
FROM matches
GROUP BY venue
HAVING total_matches >= 20
ORDER BY chasing_win_pct DESC;

SELECT 
    venue,
    COUNT(*) AS total_matches,
    ROUND(
        COUNT(*) / (SELECT COUNT(*) FROM matches) * 100,
        2
    ) AS venue_match_percentage
FROM matches
GROUP BY venue
ORDER BY total_matches DESC;

SELECT 
    LEAST(team1, team2) AS team_a,
    GREATEST(team1, team2) AS team_b,
    COUNT(*) AS matches_played
FROM matches
GROUP BY team_a, team_b
ORDER BY matches_played DESC
LIMIT 10;

SELECT 
    match_won_by,
    COUNT(*) AS wins
FROM matches
WHERE (team1 = 'Chennai Super Kings' AND team2 = 'Mumbai Indians')
   OR (team1 = 'Mumbai Indians' AND team2 = 'Chennai Super Kings')
GROUP BY match_won_by;

SELECT 
    team_a,
    team_b,
    SUM(CASE WHEN match_won_by = team_a THEN 1 ELSE 0 END) AS team_a_wins,
    SUM(CASE WHEN match_won_by = team_b THEN 1 ELSE 0 END) AS team_b_wins,
    COUNT(*) AS total_matches
FROM (
    SELECT 
        LEAST(team1, team2) AS team_a,
        GREATEST(team1, team2) AS team_b,
        match_won_by
    FROM matches
) AS rivalry
GROUP BY team_a, team_b
HAVING total_matches >= 10
ORDER BY total_matches DESC;