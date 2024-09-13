SELECT maker, speed FROM product, laptop
WHERE product.model = laptop.model AND laptop.hd >= 9

(SELECT laptop.model, price from laptop join product ON product.model = laptop.model WHERE product.maker = 'B')
UNION
(SELECT printer.model, price from printer join product ON product.model = printer.model WHERE product.maker = 'B')
UNION
(SELECT pc.model, price from pc join product ON product.model = pc.model WHERE product.maker = 'B')

(SELECT maker FROM product WHERE product.type LIKE 'Laptop')
EXCEPT
(SELECT maker FROM product WHERE product.type LIKE 'PC')

SELECT distinct p1.hd FROM pc p1
JOIN pc p2 ON p1.hd = p2.hd
WHERE p1.model != p2.model

SELECT p1.model, p2.model FROM pc p1, pc p2
where p1.speed = p2.speed
AND p1.ram = p2.ram
AND p1.model < p2.model
ORDER BY p1.model, p2.model

SELECT DISTINCT p1.maker FROM product p1
JOIN product p2 ON p1.maker = p2.maker  and p1.type = p2.type AND p1.type LIKE 'PC'
JOIN pc p3 ON p1.model = p3.model
WHERE p1.model != p2.model
AND speed > 400
