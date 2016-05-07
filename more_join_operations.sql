-- More JOIN operations




-- 1.
-- List the films where the yr is 1962 [Show id, title]



SELECT id, title
 FROM movie
 WHERE yr=1962
;


-- 2.
-- Give year of 'Citizen Kane'.


SELECT yr 
  FROM movie 
  WHERE title='Citizen Kane'
;



-- 3.
-- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.


SELECT id,title, yr FROM movie
 WHERE title LIKE 'Star Trek%'
 ORDER BY yr
;



-- 4.
-- What are the titles of the films with id 11768, 11955, 21191



SELECT title 
  FROM movie 
  WHERE id IN (11768, 11955, 21191)
;


-- 5.
-- What id number does the actress 'Glenn Close' have?


SELECT id FROM actor
  WHERE name= 'Glenn Close'
;


-- 6.
-- What is the id of the film 'Casablanca'



SELECT id 
  FROM movie 
  WHERE title='Casablanca'
;


-- 7.
-- Obtain the cast list for 'Casablanca'.

-- what is a cast list?
-- Use movieid=11768, this is the value that you obtained in the previous question.


SELECT name
  FROM casting, actor
  WHERE movieid=(SELECT id 
             FROM movie 
             WHERE title='Casablanca')
    AND actorid=actor.id
;


-- 8.
-- Obtain the cast list for the film 'Alien'

SELECT name
  FROM movie, casting, actor
  WHERE title='Alien'
    AND movieid=movie.id
    AND actorid=actor.id
;



-- 9.
-- List the films in which 'Harrison Ford' has appeared


SELECT title
  FROM movie, casting, actor
 WHERE name='Harrison Ford'
    AND movieid=movie.id
    AND actorid=actor.id
;



-- 10.
-- List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]


SELECT title
  FROM movie, casting, actor
 WHERE name='Harrison Ford'
    AND movieid=movie.id
    AND actorid=actor.id
  AND ord<>1
;


-- 11.
-- List the films together with the leading star for all 1962 films.


SELECT title, name
  FROM movie, casting, actor
 WHERE yr=1962
    AND movieid=movie.id
    AND actorid=actor.id
    AND ord=1
;


-- 12.
-- Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies.



SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
WHERE name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
movie JOIN casting ON movie.id=movieid 
JOIN actor   ON actorid=actor.id
 WHERE name='John Travolta'
 GROUP BY yr) AS t
)
;



-- 13.
-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.

-- Did you get "Little Miss Marker twice"?


SELECT title, name
  FROM movie, casting, actor
  WHERE movieid=movie.id
    AND actorid=actor.id
    AND ord=1
    AND movieid IN
    (SELECT movieid FROM casting, actor
     WHERE actorid=actor.id
     AND name='Julie Andrews')
;



-- 14.
-- Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.


SELECT name
    FROM casting JOIN actor
      ON  actorid = actor.id
    WHERE ord=1
    GROUP BY name
    HAVING COUNT(movieid)>=30
;


-- 15.
-- List the films released in the year 1978 ordered by the number of actors in the cast.


SELECT title, COUNT(actorid)
  FROM casting,movie                
  WHERE yr=1978
        AND movieid=movie.id
  GROUP BY title
  ORDER BY 2 DESC
;



-- 16.
-- List all the people who have worked with 'Art Garfunkel'.

SELECT DISTINCT d.name
FROM actor d JOIN casting a ON (a.actorid=d.id)
   JOIN casting b ON (a.movieid=b.movieid)
   JOIN actor c ON (b.actorid=c.id 
                AND c.name='Art Garfunkel')
  WHERE d.id!=c.id
;









































