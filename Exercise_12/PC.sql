USE pc1 
GO
--v.1
SELECT maker FROM product
WHERE type = 'printer' AND maker IN (SELECT maker FROM product WHERE type = 'laptop')

--v.2
(SELECT maker FROM product
WHERE type = 'printer')

INTERSECT

(SELECT maker FROM product
WHERE type = 'laptop')

--
UPDATE pc
SET price = (0.95*price)
WHERE model IN (SELECT model FROM product 
WHERE type = 'PC' AND maker IN 
(SELECT product.maker FROM product
RIGHT JOIN printer ON product.model = printer.model
GROUP BY product.maker
HAVING AVG(price) > 280))

SELECT hd, MIN(price) FROM pc
WHERE hd < 31 and hd > 9
GROUP BY hd