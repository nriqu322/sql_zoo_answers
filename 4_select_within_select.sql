SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

SELECT name FROM world
  WHERE continent = 'Europe' AND gdp/population >
    (SELECT gdp/population FROM world
     WHERE name = 'United Kingdom');

SELECT name, continent FROM world
  WHERE continent IN
    ((SELECT continent FROM world WHERE name = 'Argentina'),
     (SELECT continent FROM world WHERE name = 'Australia'))
  ORDER BY name;

SELECT name, population FROM world
  WHERE population >
    (SELECT population FROM world WHERE name = 'Canada')
    AND population <
    (SELECT population FROM world WHERE name = 'Poland');

SELECT name, 
  CONCAT(ROUND((population/(SELECT population FROM world WHERE name = 
    'Germany')*100),0),'%') 
 FROM world
 WHERE continent = 'Europe';

SELECT name FROM world
  WHERE gdp > ALL
    (SELECT gdp FROM world 
      WHERE continent = 'Europe' AND gdp > 0);

SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent = x.continent
          AND area > 0);

SELECT continent, name FROM world x
  WHERE name <= ALL
    (SELECT name FROM world y
      WHERE y.continent = x.continent);

SELECT name, continent, population FROM world
  WHERE continent NOT IN
    (SELECT continent FROM world
       WHERE population > 25000000);

SELECT name, continent FROM world x
  WHERE population >
    (SELECT MAX(population) FROM world y
       WHERE y.continent = x.continent 
         AND y.name != x.name)*3;
