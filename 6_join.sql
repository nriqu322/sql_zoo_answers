SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'

SELECT DISTINCT id,stadium,team1,team2
  FROM game
  JOIN goal
  ON goal.matchid = game.id AND game.id = 1012;

SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (id = matchid)
    AND goal.teamid = 'GER';

SELECT team1, team2, player
  FROM game JOIN goal ON id = matchid
    AND player LIKE 'Mario%';

SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam ON teamid = id
    AND gtime <= 10;

SELECT mdate, teamname
  FROM game JOIN eteam ON team1 = eteam.id
    WHERE coach = 'Fernando Santos'; 

SELECT player
  FROM game JOIN goal ON game.id = goal.matchid
    WHERE stadium = 'National Stadium, Warsaw';

SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER' OR team2='GER') AND teamid != 'GER'

SELECT DISTINCT teamname, COUNT(goal.player)
  FROM eteam JOIN goal ON id = teamid
 GROUP BY teamname;

SELECT stadium, COUNT(goal.player)
  FROM game JOIN goal ON id = matchid
 GROUP BY stadium;

SELECT matchid,mdate, COUNT(goal.player) AS goals
  FROM game JOIN goal ON id = matchid
 WHERE (team1 = 'POL' OR team2 = 'POL')
 GROUP BY mdate
 ORDER BY goals DESC;

SELECT matchid, mdate, COUNT(goal.player)
  FROM game JOIN goal ON id = matchid
 WHERE (team1 = 'GER' OR team2 = 'GER') AND teamid = 'GER'
 GROUP BY mdate
 ORDER BY matchid;

SELECT mdate,
  team1,
  sum(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) score1,
  team2,
  sum(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) score2
  FROM game JOIN goal ON matchid = id
GROUP BY mdate, team1, team2
ORDER BY mdate, matchid, team1, team2;
