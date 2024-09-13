INSERT INTO product(maker, model, type)
VALUES ('C', 1100, 'PÇ');
INSERT INTO pc
VALUES (12, 1100, 2400, 2048, 500, '52х', 299)

DELETE FROM pc WHERE model = 1100

UPDATE product
SET maker = 'B'
WHERE maker = 'A'

UPDATE pc
SET price = price / 2, hd = hd + 20

UPDATE laptop
SET screen = screen + 1
WHERE model IN
(SELECT model FROM product WHERE maker = 'B' AND type = 'laptop')
