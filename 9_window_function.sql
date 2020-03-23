SELECT lastName, party, votes
  FROM ge
 WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY votes DESC;

SELECT party, votes,
       RANK() OVER (ORDER BY votes DESC) as posn
  FROM ge
 WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY party;

SELECT yr, party, votes,
      RANK() OVER (PARTITION BY yr ORDER BY votes DESC) as posn
  FROM ge
 WHERE constituency = 'S14000021'
ORDER BY party, yr;

SELECT constituency, party, votes,
       RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) as posn
  FROM ge
 WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
   AND yr  = 2017
ORDER BY posn, constituency;

SELECT constituency, party
  FROM (SELECT constituency, party,
               RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) as posn
          FROM ge
          WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
          AND yr  = 2017
          ORDER BY constituency, votes DESC) as t
  WHERE posn = 1;

SELECT party, COUNT(*)
  FROM (SELECT party,
               RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) as posn
          FROM ge
          WHERE constituency LIKE 'S%'
          AND yr  = 2017
          ORDER BY constituency, votes DESC) as t
   WHERE posn = 1
   GROUP BY party;
