--1. Напишете заявка, която извежда имената на всички кораби без повторения,
--които са участвали в поне една битка и чиито имена започват с C или K.
SELECT DISTINCT OUTCOMES.SHIP 
FROM OUTCOMES
WHERE OUTCOMES.SHIP LIKE 'C%' OR OUTCOMES.SHIP LIKE 'K%'

--2. Напишете заявка, която извежда име и държава на всички кораби, които
--никога не са потъвали в битка (може и да не са участвали).
SELECT DISTINCT SHIPS.NAME, CLASSES.COUNTRY
FROM SHIPS
JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS
LEFT JOIN OUTCOMES ON OUTCOMES.SHIP = SHIPS.NAME
WHERE RESULT IS NULL OR RESULT = 'ok' OR RESULT = 'damaged'

--3. Напишете заявка, която извежда държавата и броя на потъналите кораби за
--тази държава. Държави, които нямат кораби или имат кораб, но той не е
--участвал в битка, също да бъдат изведени.
SELECT DISTINCT C1.COUNTRY, (SELECT COUNT(DISTINCT OUTCOMES.SHIP) FROM OUTCOMES JOIN SHIPS ON SHIPS.NAME = OUTCOMES.SHIP right JOIN CLASSES AS C2 ON C2.CLASS = SHIPS.CLASS WHERE C1.COUNTRY = C2.COUNTRY AND (RESULT = 'sunk' OR ships.NAME is null))
FROM CLASSES C1
LEFT JOIN SHIPS ON SHIPS.CLASS = C1.CLASS
LEFT JOIN OUTCOMES ON OUTCOMES.SHIP = SHIPS.NAME
WHERE RESULT IS NULL OR SHIPS.NAME IS NULL

--4. Напишете заявка, която извежда име на битките, които са по-мащабни (с
--повече участващи кораби) от битката при Guadalcanal.
SELECT OUTCOMES.BATTLE 
FROM OUTCOMES
GROUP BY OUTCOMES.BATTLE
HAVING COUNT(DISTINCT OUTCOMES.SHIP) > (SELECT COUNT(DISTINCT OUTCOMES.SHIP) FROM OUTCOMES WHERE OUTCOMES.BATTLE = 'Guadalcanal' GROUP BY OUTCOMES.BATTLE)

--5. Напишете заявка, която извежда име на битките, които са по-мащабни (с
--повече участващи страни) от битката при Surigao Strait.
SELECT OUTCOMES.BATTLE
FROM OUTCOMES
JOIN SHIPS ON SHIPS.NAME = OUTCOMES.SHIP
JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS
GROUP BY OUTCOMES.BATTLE
HAVING COUNT(DISTINCT CLASSES.COUNTRY) > (SELECT COUNT(DISTINCT CLASSES.COUNTRY) FROM CLASSES JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP WHERE OUTCOMES.BATTLE = 'Surigao Strait' )

--6. Напишете заявка, която извежда имената на най-леките кораби с най-много
--оръдия.
SELECT DISTINCT SHIPS.NAME, CLASSES.DISPLACEMENT, CLASSES.NUMGUNS
FROM SHIPS
JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS
WHERE CLASSES.NUMGUNS >= ALL (SELECT CLASSES.NUMGUNS FROM CLASSES WHERE CLASSES.DISPLACEMENT <= ALL (SELECT DISPLACEMENT FROM CLASSES))
AND CLASSES.DISPLACEMENT <= ALL (SELECT DISPLACEMENT FROM CLASSES)

--7. Изведете броя на корабите, които са били увредени в битка, но са били
--поправени и по-късно са победили в друга битка.
SELECT COUNT(O1.SHIP) AS NumShips
FROM OUTCOMES AS O1
JOIN OUTCOMES AS O2 ON O1.SHIP = O2.SHIP
JOIN BATTLES AS B1 ON O1.BATTLE = B1.NAME
JOIN BATTLES AS B2 ON O2.BATTLE = B2.NAME
WHERE O1.RESULT = 'damaged' AND O2.RESULT = 'ok'
AND B1.DATE < B2.DATE

--8. Изведете име на корабите, които са били увредени в битка, но са били
--поправени и по-късно са победили в по-мащабна битка (с повече кораби).
SELECT O1.SHIP
FROM OUTCOMES AS O1
JOIN OUTCOMES AS O2 ON O1.SHIP = O2.SHIP
JOIN BATTLES AS B1 ON O1.BATTLE = B1.NAME
JOIN BATTLES AS B2 ON O2.BATTLE = B2.NAME
WHERE O1.RESULT = 'damaged' AND O2.RESULT = 'ok'
AND B1.DATE < B2.DATE
AND (SELECT COUNT(DISTINCT O3.SHIP) FROM OUTCOMES AS O3 WHERE O3.BATTLE = O1.BATTLE) <
(SELECT COUNT(DISTINCT O4.SHIP) FROM OUTCOMES AS O4 WHERE O4.BATTLE = O2.BATTLE)

