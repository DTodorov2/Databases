--1. Напишете заявка, която извежда средната честота на персоналните компютри.
SELECT CONVERT(decimal(20,2), AVG(pc.speed)) AS 'AVG.SPEED'
FROM pc

--2. Напишете заявка, която извежда средния размер на екраните на лаптопите за
--всеки производител.
SELECT product.maker, CONVERT(DECIMAL(20, 0), AVG(laptop.screen)) as 'AVG.SCREEN'
FROM laptop
JOIN product ON product.model = laptop.model
GROUP BY product.maker

--3. Напишете заявка, която извежда средната честота на лаптопите с цена над 1000.
SELECT CONVERT(DECIMAL(20, 2), AVG(laptop.speed))
FROM laptop
WHERE laptop.price > 1000 

--4. Напишете заявка, която извежда средната цена на персоналните компютри,
--произведени от производител ‘A’
SELECT CONVERT(DECIMAL(20, 2), AVG(pc.price)) AS AvgPrice
FROM pc
JOIN product ON product.model = pc.model
WHERE maker = 'A'

--5. Напишете заявка, която извежда средната цена на персоналните компютри и
--лаптопите за производител ‘B’.
SELECT CONVERT(DECIMAL(20,2), AVG(PRICE))
FROM (SELECT laptop.model, laptop.price FROM laptop
	  UNION ALL
	  SELECT pc.model, pc.price FROM pc) AS t
JOIN product ON product.model = t.model
WHERE product.maker = 'B'

--6. Напишете заявка, която извежда средната цена на персоналните компютри
--според различните им честоти.
SELECT pc.speed, AVG(pc.price) as AvgPrice
FROM pc
GROUP BY pc.speed

--7. Напишете заявка, която извежда производителите, които са произвели поне 3
--различни персонални компютъра (с различен код).
SELECT product.maker, COUNT(pc.code)
FROM product
JOIN pc ON pc.model = product.model
GROUP BY product.maker
HAVING count(pc.code) >= 3

--8. Напишете заявка, която извежда производителите с най-висока цена на
--персонален компютър.
SELECT product.maker, pc.price
FROM product
JOIN pc ON product.model = pc.model
WHERE pc.price = (SELECT MAX(pc.price) FROM pc)

--9. Напишете заявка, която извежда средната цена на персоналните компютри за
--всяка честота по-голяма от 800.
SELECT pc.speed, AVG(pc.price) AS AvgPrice
FROM pc
WHERE pc.speed > 800
GROUP BY pc.speed

--10.Напишете заявка, която извежда средния размер на диска на тези персонални
--компютри, произведени от производители, които произвеждат и принтери.
--Резултатът да се изведе за всеки отделен производител.
SELECT product.maker, CONVERT(DECIMAL(20,2),AVG(PC.hd)) AS AvgHD
FROM pc
JOIN product ON product.model = pc.model
WHERE product.maker IN
((SELECT DISTINCT product.maker FROM product WHERE product.type = 'PC')
INTERSECT
(SELECT DISTINCT product.maker FROM product WHERE product.type = 'Printer'))
GROUP BY product.maker



