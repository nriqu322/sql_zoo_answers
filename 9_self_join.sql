SELECT COUNT(*)
  FROM stops;

SELECT id FROM stops
  WHERE name = 'Craiglockhart';

SELECT id, name FROM stops JOIN route ON id = stop
  WHERE num = '4' AND company = 'LRT';

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) > 1;

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop=149;

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name = 'Craiglockhart' and stopb.name = 'London Road';

SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Haymarket' and stopb.name='Leith';

SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name = 'Craiglockhart' and stopb.name = 'Tollcross';

SELECT stopb.name, a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name = 'Craiglockhart' and a.company = 'LRT';

SELECT fbus.num, fbus.company, fbus.name, sbus.num, sbus.company 
  FROM (SELECT a.num, a.company, stopa.name as namea, b.stop, stopb.name
         FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
           JOIN stops stopa ON (a.stop=stopa.id)
           JOIN stops stopb ON (b.stop=stopb.id)
         WHERE stopa.name = 'Craiglockhart') AS fbus
  JOIN (SELECT a.num, a.company, stopa.name, b.stop
          FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
            JOIN stops stopa ON (a.stop=stopa.id)
            JOIN stops stopb ON (b.stop=stopb.id)
          WHERE stopa.name = 'Lochend') AS sbus
    ON fbus.stop = sbus.stop
  ORDER BY fbus.num, fbus.name, sbus.num;
