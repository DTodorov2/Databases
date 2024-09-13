--1. Напишете заявка, която извежда заглавие и година на всички филми, които са
--по-дълги от 120 минути и са снимани преди 2000 г. Ако дължината на филма е
--неизвестна, заглавието и годината на този филм също да се изведат.
SELECT MOVIE.TITLE, MOVIE.YEAR, MOVIE.LENGTH
FROM MOVIE
WHERE ((MOVIE.LENGTH > 120 AND MOVIE.YEAR < 2000) OR MOVIE.LENGTH IS NULL)

--2. Напишете заявка, която извежда име и пол на всички актьори (мъже и жени),
--чието име започва с 'J' и са родени след 1948 година. Резултатът да бъде
--подреден по име в намаляващ ред.
SELECT MOVIESTAR.NAME, MOVIESTAR.GENDER
FROM MOVIESTAR
WHERE MOVIESTAR.BIRTHDATE > 1948
AND MOVIESTAR.NAME LIKE 'J%'
ORDER BY MOVIESTAR.NAME DESC

--3. Напишете заявка, която извежда име на студио и брой на актьорите,
--участвали във филми, които са създадени от това студио.
SELECT STUDIONAME, COUNT(DISTINCT STARSIN.STARNAME) AS NumActors
FROM MOVIE
JOIN STARSIN ON STARSIN.MOVIETITLE = MOVIE.TITLE
GROUP BY STUDIONAME

--4. Напишете заявка, която за всеки актьор извежда име на актьора и броя на
--филмите, в които актьорът е участвал.
SELECT MOVIESTAR.NAME, COUNT(MOVIETITLE) AS NumMovies
FROM MOVIESTAR
LEFT JOIN STARSIN ON STARSIN.STARNAME = MOVIESTAR.NAME
GROUP BY MOVIESTAR.NAME

--5. Напишете заявка, която за всяко студио извежда име на студиото и заглавие
--на филма, излязъл последно на екран за това студио.
select movietitle, starname, birthdate
from StarsIn s
JOIN (select name, birthdate
from MovieStar
where gender='M') t ON s.STARNAME = t.NAME

--6. Напишете заявка, която извежда името на най-младия актьор (мъж).
SELECT MOVIESTAR.NAME
FROM MOVIESTAR
WHERE MOVIESTAR.BIRTHDATE = (SELECT TOP 1 MOVIESTAR.BIRTHDATE FROM MOVIESTAR WHERE MOVIESTAR.GENDER = 'M' ORDER BY MOVIESTAR.BIRTHDATE DESC)

--8. Напишете заявка, която извежда заглавие и година на филма, и брой на
--актьорите, участвали в този филм за тези филми с повече от двама актьори.
SELECT MOVIE.TITLE, MOVIE.YEAR, COUNT(DISTINCT STARSIN.STARNAME) AS Count_Actors
FROM MOVIE
JOIN STARSIN ON STARSIN.MOVIETITLE = MOVIE.TITLE
GROUP BY TITLE, MOVIE.YEAR
HAVING COUNT(DISTINCT STARSIN.STARNAME) > 2
