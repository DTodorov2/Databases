--1. Напишете заявка, която извежда името на корабите с водоизместимост над
--50000.
SELECT name FROM ships
JOIN classes ON classes.CLASS LIKE ships.CLASS
WHERE CLASSES.DISPLACEMENT	> 50000

--2. Напишете заявка, която извежда имената, водоизместимостта и броя оръдия на
--всички кораби, участвали в битката при Guadalcanal.
SELECT DISTINCT NAME, CLASSES.DISPLACEMENT, CLASSES.NUMGUNS FROM SHIPS
JOIN CLASSES ON CLASSES.CLASS LIKE SHIPS.CLASS
JOIN OUTCOMES ON name LIKE OUTCOMES.SHIP
WHERE BATTLE = 'Guadalcanal'

--3. Напишете заявка, която извежда имената на тези държави, които имат както
--бойни кораби, така и бойни крайцери.
SELECT DISTINCT c1.COUNTRY FROM CLASSES c1
JOIN classes c2 ON c1.COUNTRY LIKE c2.COUNTRY
WHERE c1.TYPE LIKE 'bb' AND c2.TYPE = 'bc'

--4. Напишете заявка, която извежда имената на тези кораби, които са били
--повредени в една битка, но по-късно са участвали в друга битка.
SELECT O1.SHIP
FROM OUTCOMES O1, OUTCOMES O2, BATTLES B1, BATTLES B2
WHERE O1.SHIP = O2.SHIP AND
B1.NAME = O1.BATTLE AND
B2.NAME = O2.BATTLE AND
O1.RESULT LIKE 'damaged' AND
B1.DATE < B2.DATE
