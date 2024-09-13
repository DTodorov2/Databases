--1. Напишете заявка, която извежда цялата налична информация за всеки
--кораб, включително и данните за неговия клас. В резултата не трябва да
--се включват тези класове, които нямат кораби.
SELECT *
FROM SHIPS
LEFT JOIN CLASSES ON ships.class = CLASSES.CLASS

--2. Повторете горната заявка, като този път включите в резултата и
--класовете, които нямат кораби, но съществуват кораби със същото име
--като тяхното.
SELECT *
FROM ships
RIGHT JOIN classes ON ships.class = CLASSES.CLASS
WHERE SHIPS.class IS NOT NULL OR classes.class IN (SELECT ships.NAME FROM ships)

--3. За всяка страна изведете имената на корабите, които никога не са
--участвали в битка.
SELECT DISTINCT CLASSES.COUNTRY, SHIPS.NAME
FROM CLASSES
JOIN SHIPS ON SHIPS.CLASS = CLASSES.CLASS
LEFT JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
WHERE RESULT IS NULL

--4. Намерете имената на всички кораби с поне 7 оръдия, пуснати на вода
--през 1916, но наречете резултатната колона Ship Name.
SELECT SHIPS.NAME AS 'Ship Name' 
FROM SHIPS
JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS
WHERE NUMGUNS >= 7
AND LAUNCHED = 1916

--5. Изведете имената на всички потънали в битка кораби, името и дата на
--провеждане на битките, в които те са потънали. Подредете резултата по
--име на битката.
SELECT SHIPS.NAME, BATTLES.DATE, BATTLES.NAME
FROM SHIPS
JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
JOIN BATTLES ON OUTCOMES.BATTLE = BATTLES.NAME
WHERE OUTCOMES.RESULT = 'sunk'

--6. Намерете името, водоизместимостта и годината на пускане на вода на
--всички кораби, които имат същото име като техния клас.
SELECT SHIPS.NAME, SHIPS.LAUNCHED, CLASSES.DISPLACEMENT
FROM SHIPS
JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS
WHERE SHIPS.NAME = CLASSES.CLASS

--7. Намерете всички класове кораби, от които няма пуснат на вода нито един
--кораб.
SELECT *
FROM CLASSES
LEFT JOIN SHIPS ON SHIPS.CLASS = CLASSES.CLASS
WHERE SHIPS.LAUNCHED IS NULL

--8. Изведете името, водоизместимостта и броя оръдия на корабите,
--участвали в битката ‘North Atlantic’, а също и резултата от битката.
SELECT ships.NAME, CLASSES.DISPLACEMENT, CLASSES.NUMGUNS, OUTCOMES.RESULT
FROM ships
JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS
JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
WHERE OUTCOMES.BATTLE = 'North Atlantic'
