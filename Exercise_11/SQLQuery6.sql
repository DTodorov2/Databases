--1. Добавете нова колона num_pass към таблицата Flights, която ще съдържа броя на
пътниците, потвърдили резервация за съответния полет.
ALTER TABLE FLIGHTS
ADD num_pass int;

INSERT INTO BOOKINGS
VALUES ('YY298P', 'Aerofly', 'TK', 'TK1028', 6, '2021-04-27' , '2021-12-20', 400, 1)
('YN298P', 'Travel One', 'FB', 'FB1363', 1, '2021-04-27', '2021-12-25', 300, 0),

UPDATE FLIGHTS
SET num_pass = (
SELECT COUNT(BOOKINGS.CUSTOMER_ID) FROM BOOKINGS
LEFT JOIN FLIGHTS AS F1 ON F1.FNUMBER = BOOKINGS.FLIGHT_NUMBER
WHERE STATUS = 1 AND FLIGHTS.FNUMBER = F1.FNUMBER
GROUP BY bookings.FLIGHT_NUMBER
)

UPDATE FLIGHTS
SET num_pass = 0
WHERE num_pass IS NULL

--2. Добавете нова колона num_book към таблицата Agencies, която ще съдържа броя на
резервациите към съответната агенция.
ALTER TABLE AGENCIES
ADD num_book int;

UPDATE AGENCIES
SET num_book = (
SELECT COUNT(bookings.code)
FROM BOOKINGS
WHERE AGENCIES.NAME = BOOKINGS.AGENCY
GROUP BY AGENCY
)

UPDATE AGENCIES
SET num_book = 0
WHERE num_book IS NULL

--3. Създайте тригер за таблицата Bookings, който да се задейства при вмъкване на
--резервация в таблицата и да увеличава с единица броя на пътниците, потвърдили
--резервация за таблицата Flights, както и броя на резервациите към съответната агенция.
CREATE TRIGGER task03
ON BOOKINGS AFTER INSERT
AS
UPDATE FLIGHTS
SET num_pass = num_pass + 1
WHERE FLIGHTS.FNUMBER IN (SELECT FNUMBER FROM inserted)
UPDATE AGENCIES
SET num_book = num_book + 1
WHERE AGENCIES.NAME IN (SELECT NAME FROM inserted)

INSERT INTO BOOKINGS
VALUES ('YN298P', 'Travel One', 'FB', 'FB1363', 1, '2021-04-27', '2021-12-25', 300, 0)

--4. Създайте тригер за таблицата Bookings, който да се задейства при изтриване на
--резервация в таблицата и да намалява с единица броя на пътниците, потвърдили
--резервация за таблицата Flights, както и броя на резервациите към съответната агенция.
CREATE TRIGGER task04
ON BOOKINGS AFTER DELETE
AS BEGIN
UPDATE FLIGHTS
SET num_pass = num_pass - 1
WHERE FLIGHTS.FNUMBER IN (SELECT FNUMBER FROM deleted)
UPDATE AGENCIES
SET num_book = num_book - 1
WHERE AGENCIES.NAME IN (SELECT NAME FROM deleted)
END

--5. Създайте тригер за таблицата Bookings, който да се задейства при обновяване на
--резервация в таблицата и да увеличава или намалява с единица броя на пътниците,
--потвърдили резервация за таблицата Flights при промяна на статуса на резервацията.
CREATE TRIGGER task05
ON BOOKINGS AFTER UPDATE
AS BEGIN
UPDATE FLIGHTS
SET num_pass = num_pass + 1
WHERE FNUMBER IN (SELECT FLIGHT_NUMBER FROM inserted WHERE inserted.STATUS = 1)
UPDATE FLIGHTS
SET num_pass = num_pass - 1
WHERE FNUMBER IN (SELECT FLIGHT_NUMBER FROM deleted WHERE deleted.STATUS = 1)
END

DROP TRIGGER task05
