INSERT INTO ships
VALUES ('Nelson', 'Nelson', 1927), ('Rodney', 'Nelson', 1927)
INSERT INTO CLASSES
VALUES ('Nelson', 'bb', 'Gt.Britain', 9, 16, 34000), ('Rodney', 'bb', 'Gt.Britain', 9, 16, 34000)

DELETE FROM ships
WHERE name IN
(SELECT ship FROM outcomes WHERE result = 'sunk')

UPDATE CLASSES
SET bore = 2.5*bore, DISPLACEMENT = DISPLACEMENT*1.1