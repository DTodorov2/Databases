--1. Напишете заявка, която извежда страните, чиито кораби са с най-голям
--брой оръдия.
SELECT DISTINCT CLASSES.COUNTRY
FROM CLASSES
WHERE CLASSES.NUMGUNS >= ALL (SELECT CLASSES.NUMGUNS FROM CLASSES)

--2. Напишете заявка, която извежда класовете, за които поне един от
--корабите е потънал в битка.
SELECT DISTINCT SHIPS.CLASS
FROM SHIPS
WHERE SHIPS.NAME IN
(SELECT OUTCOMES.SHIP FROM OUTCOMES WHERE OUTCOMES.RESULT = 'sunk')

--3. Напишете заявка, която извежда името и класа на корабите с 16 инчови
--оръдия.
SELECT ships.CLASS, ships.NAME 
FROM ships
WHERE ships.CLASS IN
(SELECT CLASSES.CLASS FROM CLASSES WHERE BORE = 16)

--4. Напишете заявка, която извежда имената на битките, в които са
--участвали кораби от клас ‘Kongo’.
SELECT OUTCOMES.BATTLE
FROM OUTCOMES
WHERE outcomes.SHIP IN
(SELECT SHIPS.NAME FROM SHIPS WHERE SHIPS.CLASS = 'Kongo')

--5. Напишете заявка, която извежда класа и името на корабите, чиито брой
--оръдия е по-голям или равен на този на корабите със същия калибър
--оръдия.
SELECT SHIPS.NAME, SHIPS.CLASS
FROM SHIPS
WHERE SHIPS.CLASS IN 
(SELECT c.CLASS FROM CLASSES AS c 
WHERE c.NUMGUNS >= ALL (SELECT NUMGUNS FROM CLASSES
WHERE CLASSES.BORE = c.BORE))
