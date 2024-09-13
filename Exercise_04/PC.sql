--1. Напишете заявка, която извежда производител, модел и тип на продукт
--за тези производители, за които съответният продукт не се продава
--(няма го в таблиците PC, Laptop или Printer)
--v1
SELECT DISTINCT product.maker, product.model, product.type
FROM product
left JOIN pc ON product.model = pc.model
LEFT JOIN printer ON product.model = printer.model
LEFT JOIN laptop ON product.model = laptop.model
--v2
SELECT * 
FROM product
WHERE product.model NOT IN (SELECT laptop.model FROM laptop) AND
product.model NOT IN (SELECT pc.model FROM pc) AND
product.model NOT IN (SELECT printer.model FROM printer)
  
--2. Намерете всички производители, които правят както лаптопи, така и
--принтери.
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

--3. Намерете размерите на тези твърди дискове, които се появяват в два
--или повече модела лаптопи.
SELECT DISTINCT l1.hd
FROM laptop AS l1
JOIN laptop AS l2 ON l1.hd = l2.hd
WHERE l1.model < l2.model

--4. Намерете всички модели персонални компютри, които нямат регистриран
--производител.
SELECT *
FROM pc
LEFT JOIN product ON pc.model = product.model
WHERE product.model IS NULL

