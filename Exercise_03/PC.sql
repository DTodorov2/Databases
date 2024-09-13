--1. Напишете заявка, която извежда производителите на персонални
--компютри с честота над 500.
SELECT DISTINCT product.maker
FROM product, pc
WHERE product.model = pc.model
AND product.model IN (SELECT pc.model FROM pc WHERE pc.speed > 500)

--2. Напишете заявка, която извежда код, модел и цена на принтерите с найвисока цена.
SELECT code, model, price 
FROM printer
WHERE price = (SELECT TOP 1 printer.price FROM printer ORDER BY printer.price DESC)

--3. Напишете заявка, която извежда лаптопите, чиято честота е по-ниска от
--честотата на всички персонални компютри.
SELECT * 
FROM laptop 
WHERE laptop.speed < ALL (SELECT pc.speed FROM pc)

SELECT TOP 1 model, price
FROM ((SELECT model, price FROM pc) UNION (SELECT model, price FROM printer) UNION (SELECT model, price FROM laptop)) t
ORDER BY price DESC

--4. Напишете заявка, която извежда модела и цената на продукта (PC,
--лаптоп или принтер) с най-висока цена
--v1
SELECT  product.maker
FROM product
WHERE product.model = (SELECT TOP 1 printer.model FROM printer WHERE color = 'y' ORDER BY printer.price)
--v2
SELECT DISTINCT product.maker
FROM product
WHERE product.model IN 
(SELECT pc.model FROM pc WHERE pc.speed =
(SELECT TOP 1 pc.speed FROM pc WHERE pc.ram <= ALL (SELECT ram from pc)ORDER BY pc.speed DESC)
AND pc.ram = (SELECT TOP 1 ram from pc order by pc.ram))

--5. Напишете заявка, която извежда производителите на тези персонални
--компютри с най-малко RAM памет, които имат най-бързи процесори
SELECT DISTINCT product.maker FROM product
JOIN pc ON pc.model = product.model
WHERE pc.speed = (SELECT MAX(speed) FROM pc
WHERE pc.ram = (SELECT MIN(pc.ram) FROM pc))
