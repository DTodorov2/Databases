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