SELECT laptop.model, laptop.code, laptop.screen
FROM laptop
WHERE laptop.model IN 
((SELECT laptop.model FROM laptop WHERE laptop.screen = 15)
INTERSECT
(SELECT laptop.model FROM laptop WHERE laptop.screen = 11))
AND laptop.screen = 15 OR laptop.screen = 11

SELECT DISTINCT pc.model
FROM pc
JOIN product AS p1 ON pc.model = p1.model
WHERE pc.price < (SELECT MIN(laptop.price) FROM laptop JOIN product as p2 ON laptop.model = p2.model WHERE p2.maker = p1.maker)

SELECT pc.model, AVG(pc.price) AS AvgPrice
FROM pc
JOIN product p1 ON pc.model = p1.model
GROUP BY p1.maker, pc.model
HAVING AVG(pc.price) < (SELECT MIN(laptop.price) FROM laptop JOIN product AS p2 ON p2.model = laptop.model WHERE p1.maker = p2.maker)

--da pitam
SELECT p1.code, product.maker ,(SELECT COUNT(DISTINCT pc.code) FROM pc WHERE pc.price >= p1.price AND pc.code != p1.code) AS MOREPRICY
FROM pc p1
JOIN product ON product.model = p1.model