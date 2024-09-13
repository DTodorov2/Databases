--1. Напишете заявка, която извежда името на продуцента и имената на
--филмите, продуцирани от продуцента на филма ‘Star Wars’.
SELECT MOVIEEXEC.NAME, MOVIE.TITLE
FROM MOVIEEXEC
JOIN MOVIE ON MOVIEEXEC.CERT# = MOVIE.PRODUCERC#
WHERE MOVIEEXEC.CERT# =
(SELECT MOVIE.PRODUCERC# FROM MOVIE WHERE MOVIE.TITLE = 'Star Wars')

--2. Напишете заявка, която извежда имената на продуцентите на филмите, в
--които е участвал ‘Harrison Ford’
SELECT DISTINCT MOVIEEXEC.NAME 
FROM MOVIEEXEC
JOIN MOVIE ON MOVIEEXEC.CERT# = MOVIE.PRODUCERC#
WHERE MOVIE.TITLE IN
(SELECT STARSIN.MOVIETITLE FROM STARSIN WHERE STARSIN.STARNAME = 'Harrison Ford')

--3. Напишете заявка, която извежда името на студиото и имената на
--актьорите, участвали във филми, произведени от това студио, подредени
--по име на студио.
SELECT DISTINCT MOVIE.STUDIONAME, STARSIN.STARNAME
FROM MOVIE
JOIN STARSIN ON STARSIN.MOVIETITLE = MOVIE.TITLE
ORDER BY MOVIE.STUDIONAME

--4. Напишете заявка, която извежда имената на актьорите, участвали във
--филми на продуценти с най-големи нетни активи.
SELECT DISTINCT STARSIN.STARNAME, MOVIEEXEC.NETWORTH, MOVIE.TITLE
FROM STARSIN
JOIN MOVIE ON MOVIE.TITLE = STARSIN.MOVIETITLE
JOIN MOVIEEXEC ON  MOVIEEXEC.CERT# = MOVIE.PRODUCERC#
WHERE MOVIE.PRODUCERC# IN
(SELECT MOVIEEXEC.CERT# FROM MOVIEEXEC WHERE NETWORTH >= ALL (SELECT NETWORTH FROM MOVIEEXEC))

--5. Напишете заявка, която извежда имената на актьорите, които не са
--участвали в нито един филм.
SELECT MOVIESTAR.NAME, STARSIN.MOVIETITLE
FROM MOVIESTAR
LEFT JOIN STARSIN ON MOVIESTAR.NAME = STARSIN.STARNAME
WHERE MOVIETITLE IS NULL
