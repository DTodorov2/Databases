SELECT DISTINCT product.maker
FROM product, pc
WHERE product.model = pc.model
AND product.model IN (SELECT pc.model FROM pc WHERE pc.speed > 500)

SELECT code, model, price 
FROM printer
WHERE price = (SELECT TOP 1 printer.price FROM printer ORDER BY printer.price DESC)

SELECT * 
FROM laptop 
WHERE laptop.speed < ALL (SELECT pc.speed FROM pc)

SELECT TOP 1 model, price
FROM ((SELECT model, price FROM pc) UNION (SELECT model, price FROM printer) UNION (SELECT model, price FROM laptop)) t
ORDER BY price DESC

SELECT  product.maker
FROM product
WHERE product.model = (SELECT TOP 1 printer.model FROM printer WHERE color = 'y' ORDER BY printer.price)
--taq i sledvashtata sa ednakvi--
SELECT DISTINCT product.maker
FROM product
WHERE product.model IN 
(SELECT pc.model FROM pc WHERE pc.speed =
(SELECT TOP 1 pc.speed FROM pc WHERE pc.ram <= ALL (SELECT ram from pc)ORDER BY pc.speed DESC)
AND pc.ram = (SELECT TOP 1 ram from pc order by pc.ram))

--vajno--
SELECT DISTINCT product.maker FROM product
JOIN pc ON pc.model = product.model
WHERE pc.speed = (SELECT MAX(speed) FROM pc
WHERE pc.ram = (SELECT MIN(pc.ram) FROM pc))