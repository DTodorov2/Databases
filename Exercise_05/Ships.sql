--1. Напишете заявка, която извежда броя на класовете бойни кораби.
SELECT COUNT(CLASSES.TYPE)
FROM CLASSES
WHERE CLASSES.TYPE = 'bb'

--2. Напишете заявка, която извежда средния брой оръдия за всеки клас боен кораб.
SELECT CLASSES.CLASS, AVG(CLASSES.NUMGUNS) AS AvgNumGuns
FROM CLASSES
WHERE CLASSES.TYPE = 'bb'
GROUP BY CLASSES.CLASS

--3. Напишете заявка, която извежда средния брой оръдия за всички бойни кораби.
SELECT AVG(CLASSES.NUMGUNS) AS AvgNumGuns
FROM CLASSES
WHERE CLASSES.TYPE = 'bb'

--4. Напишете заявка, която извежда за всеки клас първата и последната година, в
--която кораб от съответния клас е пуснат на вода.
SELECT SHIPS.CLASS, MIN(SHIPS.LAUNCHED) AS FirstYear, MAX(SHIPS.LAUNCHED) AS SecondYear
FROM SHIPS
GROUP BY SHIPS.CLASS

--5. Напишете заявка, която извежда броя на корабите, потънали в битка според
--класа, за тези класове с повече от 2 кораба.
SELECT SHIPS.CLASS, COUNT(OUTCOMES.RESULT) AS No_Sunk
FROM OUTCOMES
JOIN SHIPS ON SHIPS.NAME = OUTCOMES.SHIP
WHERE OUTCOMES.RESULT = 'sunk' AND 
SHIPS.CLASS IN (SELECT SHIPS.CLASS FROM SHIPS GROUP BY SHIPS.CLASS HAVING COUNT(SHIPS.NAME) > 2)
GROUP BY SHIPS.CLASS

--6. Напишете заявка, която извежда средния калибър на оръдията на корабите за
--всяка страна.
SELECT CLASSES.COUNTRY, CONVERT(DECIMAL(20, 2), AVG(CLASSES.BORE)) AS AvgBore
FROM CLASSES
JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
GROUP BY COUNTRY
