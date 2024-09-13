--Задача 1
--а) Дефинирайте следните релации:
---Product (maker, model, type), където:
-- -модел е низ от точно 4 символа,
-- -производител е низ от точно 1 символ,
-- -тип е низ до 7 символа;
---Printer (code, model, price), където:
-- -код е цяло число,
-- -модел е низ от точно 4 символа,
-- -цена с точност до два знака след десетичната запетая;
--б) Добавете кортежи с примерни данни към новосъздадените релации.
--в) Добавете към релацията Printer атрибути:
-- -type - низ до 6 символа (забележка: type може да приема
--стойност 'laser', 'matrix' или 'jet'),
-- -color - низ от точно 1 символ, стойност по подразбиране 'n'
--(забележка: color може да приема стойност 'y' или 'n').
--г) Напишете заявка, която премахва атрибута price от релацията Printer.
--д) Изтрийте релациите, които сте създали в Задача 1.

CREATE TABLE Product (
	model char(4),
	maker char(1),
	type varchar(7)
)

CREATE TABLE Printer (
	code int,
	model char(4),
	price decimal(10, 2)
);

INSERT INTO Product
VALUES ('haha', 'A', 'laptop'), ('nene', 'B', 'printer'), ('dada', 'C', 'PC')

INSERT INTO Printer
VALUES (1234, 'opaa', 56.34), (5678, 'yess', 678), (9012, 'nope', 234245.563)

ALTER TABLE Printer ADD type varchar(6) CHECK (type IN ('laser', 'matrix', 'jet')), color char(1) CHECK (color IN ('y', 'n'));

INSERT INTO Printer
VALUES (3456, 'hehe', 14.345, 'laser', 'y');

ALTER TABLE Printer DROP COLUMN price

DROP TABLE Product, Printer
