-- Contents
-- 1	1962 movies
SELECT
  id,
  title
FROM
  movie
WHERE
  yr = 1962



-- 2	When was Citizen Kane released?
select
  yr
from
  movie
where
  title = 'Citizen Kane'


-- 3	Star Trek movies
select
  id,
  title,
  yr
from
  movie
where
  title like '%Star Trek%'


-- 4	id for actor Glenn Close
select
  id
from
  actor
where
  name = 'Glenn Close'


-- 5	id for Casablanca
select
  id
from
  movie
where
  title = 'Casablanca' 


-- 6	Cast list for Casablanca
select
  actor.name
from
  casting
  join actor on actorid = actor.id
where
  movieid = 27 
  

-- 7	Alien cast list
select
  actor.name
from
  casting
  join actor on actorid = actor.id
  join movie on movieid = movie.id
where
  movie.title = 'Alien' 
  
-- 8	Harrison Ford movies

select movie.title from movie 
join casting on movie.id = movieid 
join actor on actorid = actor.id 
where actor.name = 'Harrison Ford' 

-- 9	Harrison Ford as a supporting actor
select
  movie.title
from
  movie
  join casting on movie.id = movieid
  join actor on actorid = actor.id
where
  actor.name = 'Harrison Ford'
  and casting.ord <> 1


-- 10	Lead actors in 1962 movies
select
  movie.title,
  actor.name
from
  movie
  join casting on movie.id = movieid
  join actor on actorid = actor.id
where
  yr = 1962
  and casting.ord = 1
order by
  movie.title,
  actor.name


-- 11	Busy years for Rock Hudson
SELECT
  yr,
  COUNT(title)
FROM
  movie
  JOIN casting ON movie.id = movieid
  JOIN actor ON actorid = actor.id
WHERE
  name = 'Rock Hudson'
GROUP BY
  yr
HAVING
  COUNT(title) > 1

-- 12	Lead actor in Julie Andrews movies
SELECT
  movie.title,
  actor.name
from
  movie
  JOIN casting ON (
    movie.id = movieid
    and ord = 1
  )
  JOIN actor ON actorid = actor.id
where
  movieid in (
    select
      movieid
    from
      casting
      JOIN actor ON actorid = actor.id
    where
      actor.name = 'Julie Andrews'
  ) 
  
-- 13	Actors with 15 leading roles
SELECT
  name
FROM
  actor
  JOIN casting ON (
    id = actorid
    AND (
      SELECT
        COUNT(ord)
      FROM
        casting
      WHERE
        actorid = actor.id
        AND ord = 1
    ) >= 15
  )
GROUP BY
  name
order by
  name 
  
-- 14	released in the year 1978

SELECT title, COUNT(actorid) as cast
FROM movie JOIN casting on id=movieid
WHERE yr = 1978
GROUP BY title
ORDER BY cast DESC,title


-- 15	with 'Art Garfunkel'
select name from actor 
join casting on actor.id = actorid
where  movieid in 
(select movieid from casting 
join actor on (actor.id = actorid)
where actor.name = 'Art Garfunkel' 
) and name<>'Art Garfunkel'
order by name

