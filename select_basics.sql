-- SQLZOO:SELECT basics

-- 1.
-- The example uses a WHERE clause to show the population of 'France'. Note that strings (pieces of text that are data) should be in 'single quotes';

-- Modify it to show the population of Germany

SELECT population FROM world
  WHERE name = 'Germany'
;



-- 2.
-- The query shows the name and population density
-- for each country where the area is over 5,000,000 km2. Population density is not a column in the World table, but we

-- can calculate it as population/area.
-- Modify it to show the name and per capita gdp: gdp/population for each country where the area is over 5,000,000 km2


SELECT name, gdp/population FROM world
  WHERE area > '5000000'
;


-- 3.
-- Checking a list The word IN allows us to check if an item is in a list. The example shows the name and population for the countries 'Luxembourg', 'Mauritius' and 'Samoa'.

-- Show the name and the population for 'Ireland', 'Iceland' and 'Denmark'.


SELECT name, population FROM world
  WHERE name IN ('Ireland', 'Iceland', 'Denmark')
;



-- 4.
-- Which countries are not too small and not too big? BETWEEN allows range checking (range specified is inclusive of boundary values). The example below shows countries with an area of 250,000-300,000 sq. km. Modify it to show the country and the area for countries with an area between 200,000 and 250,000.


SELECT name, area
  FROM world
  WHERE area BETWEEN 200000 AND 250000
;



