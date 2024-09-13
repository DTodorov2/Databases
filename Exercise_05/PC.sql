SELECT CONVERT(decimal(20,2), AVG(pc.speed)) AS 'AVG.SPEED'
FROM pc

SELECT product.maker, CONVERT(DECIMAL(20, 0), AVG(laptop.screen)) as 'AVG.SCREEN'
FROM laptop
JOIN product ON product.model = laptop.model
GROUP BY product.maker

SELECT CONVERT(DECIMAL(20, 2), AVG(laptop.speed))
FROM laptop
WHERE laptop.price > 1000 

SELECT CONVERT(DECIMAL(20, 2), AVG(pc.price)) AS AvgPrice
FROM pc
JOIN product ON product.model = pc.model
WHERE maker = 'A'

SELECT CONVERT(DECIMAL(20,2), AVG(PRICE))
FROM (SELECT laptop.model, laptop.price FROM laptop
	  UNION ALL
	  SELECT pc.model, pc.price FROM pc) AS t
JOIN product ON product.model = t.model
WHERE product.maker = 'B'

SELECT pc.speed, AVG(pc.price) as AvgPrice
FROM pc
GROUP BY pc.speed

SELECT product.maker, COUNT(pc.code)
FROM product
JOIN pc ON pc.model = product.model
GROUP BY product.maker
HAVING count(pc.code) >= 3

SELECT product.maker, pc.price
FROM product
JOIN pc ON product.model = pc.model
WHERE pc.price = (SELECT MAX(pc.price) FROM pc)

SELECT pc.speed, AVG(pc.price) AS AvgPrice
FROM pc
WHERE pc.speed > 800
GROUP BY pc.speed

SELECT product.maker, CONVERT(DECIMAL(20,2),AVG(PC.hd)) AS AvgHD
FROM pc
JOIN product ON product.model = pc.model
WHERE product.maker IN
((SELECT DISTINCT product.maker FROM product WHERE product.type = 'PC')
INTERSECT
(SELECT DISTINCT product.maker FROM product WHERE product.type = 'Printer'))
GROUP BY product.maker



