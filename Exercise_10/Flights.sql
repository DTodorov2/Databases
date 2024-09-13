--1. Създайте изглед, който извежда име на авиокомпания оператор на полета, номер на полет
--и брой пътници, потвърдили резервация за този полет. Тествайте изгледa.
CREATE VIEW flight_info
AS
SELECT AIRLINES.NAME, flights.AIRLINE_OPERATOR, flights.FNUMBER, COUNT(BOOKINGS.CUSTOMER_ID) as customers_count
FROM AIRLINES 
LEFT JOIN FLIGHTS ON AIRLINE_OPERATOR = AIRLINES.CODE
LEFT JOIN BOOKINGS ON FLIGHTS.FNUMBER = BOOKINGS.FLIGHT_NUMBER
GROUP BY BOOKINGS.CUSTOMER_ID, BOOKINGS.STATUS, AIRLINES.NAME, FLIGHTS.AIRLINE_OPERATOR, FLIGHTS.FNUMBER
HAVING BOOKINGS.STATUS = 1

SELECT * FROM flight_info

--2. Създайте изглед за таблицата Agencies, който извежда всички данни за агенциите от град
--София. Дефинирайте изгледa с CHECK OPTION. Тествайте изгледa.
CREATE VIEW agency_cities
AS
SELECT * FROM AGENCIES
WHERE CITY='Sofia'
WITH CHECK OPTION

SELECT * FROM agency_cities

--3. Създайте изглед за таблицата Agencies, който извежда всички данни за агенциите, такива
--че телефонните номера на тези агенции да имат стойност NULL. Дефинирайте изгледa с
CHECK OPTION. Тествайте изгледa
CREATE VIEW agencies_phone
AS
SELECT * FROM AGENCIES
WHERE PHONE	is NULL
WITH CHECK OPTION

SELECT * FROM agencies_phone

--4. Опитайте се да вмъкнете следните редове през изгледите от задачи 2 и 3
INSERT INTO agency_cities
VALUES('T1 Tour', 'Bulgaria', 'Sofia','+359')
INSERT INTO agencies_phone
VALUES('T2 Tour', 'Bulgaria', 'Sofia',null);
INSERT INTO flight_info
VALUES('T2 Tour', 'Bulgaria', 'Sofia',null);

DROP VIEW agency_cities
DROP VIEW agencies_phone
DROP VIEW flight_info
