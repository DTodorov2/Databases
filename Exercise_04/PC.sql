--tuka nqma li da stane taka, smsl ako model v product nqma s kvo da se zapulni to shte e NULL
--ne stava, shtoto realno nqmam dopulnitelna kolona, na koqto da izpishe null i da moga da proverq chrez neq
SELECT DISTINCT product.maker, product.model, product.type
FROM product
left JOIN pc ON product.model = pc.model
LEFT JOIN printer ON product.model = printer.model
LEFT JOIN laptop ON product.model = laptop.model

SELECT * 
FROM product
WHERE product.model NOT IN (SELECT laptop.model FROM laptop) AND
product.model NOT IN (SELECT pc.model FROM pc) AND
product.model NOT IN (SELECT printer.model FROM printer)
--
SELECT DISTINCT p1.maker
FROM product AS p1
JOIN product AS p2 ON p1.maker = p2.maker
WHERE ((p1.type = 'Laptop' AND p2.type = 'Printer') OR (p1.type = 'Printer' AND p2.type = 'Laptop'))

(SELECT product.maker
FROM product 
WHERE product.type = 'Printer')
INTERSECT
(SELECT product.maker
FROM product
WHERE product.type = 'Laptop')
--

SELECT DISTINCT l1.hd
FROM laptop AS l1
JOIN laptop AS l2 ON l1.hd = l2.hd
WHERE l1.model < l2.model

SELECT *
FROM pc
LEFT JOIN product ON pc.model = product.model
WHERE product.model IS NULL

