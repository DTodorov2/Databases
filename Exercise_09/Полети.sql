CREATE TABLE Airline (
	code int,
	name varchar(20),
	country varchar(20)
);

ALTER TABLE Airline ADD CONSTRAINT pk_code PRIMARY KEY(code)
ALTER TABLE Airline ADD CONSTRAINT name_validation UNIQUE(name)
ALTER TABLE Airline ALTER COLUMN name varchar(20) NOT NULL

CREATE TABLE Agency (
	name varchar(20),
	country varchar(20),
	city varchar(20),
	phone varchar(20)
);

ALTER TABLE Agency ADD CONSTRAINT pr_key_name PRIMARY KEY(name)

CREATE TABLE Airport (
	code int,
	name varchar(20),
	country varchar(20),
	city varchar(20)
);

ALTER TABLE Airport ADD CONSTRAINT pk_code PRIMARY KEY(code)
ALTER TABLE Airport ADD CONSTRAINT ime UNIQUE (name, country)

CREATE TABLE Airplane (
	code int,
	type varchar(10),
	seats int check (seats > 0),
	year int
	
);

ALTER TABLE Airplane ADD CONSTRAINT pk_code PRIMARY KEY(code)
ALTER TABLE Airplane ADD CONSTRAINT check_year CHECK (year > 0 AND year < 2025)

CREATE TABLE Flight (
	fnumber char(4),
	airline_operator int ,
	dep_airport int,
	arr_airport int,
	flight_time varchar(10),
	flight_duration decimal(10, 1),
	airplaneCode int,
);

ALTER TABLE Flight ADD CONSTRAINT pk_fnumber PRIMARY KEY(fnumber)
ALTER TABLE Flight ADD CONSTRAINT ref_airline_code FOREIGN KEY (dep_airport) REFERENCES Airport(code)
ALTER TABLE Flight ALTER COLUMN dep_airport int NOT NULL
ALTER TABLE Flight ADD CONSTRAINT air_op_fk FOREIGN KEY (airline_operator) REFERENCES Airline(code)
ALTER TABLE Flight ALTER COLUMN airline_operator int NOT NULL
ALTER TABLE Flight ADD CONSTRAINT arr_airport_fk FOREIGN KEY(arr_airport) REFERENCES Airport(code)
ALTER TABLE Flight ALTER COLUMN arr_airport int NOT NULL
ALTER TABLE Flight ADD CONSTRAINT air_code_fk FOREIGN KEY(airplaneCode) REFERENCES Airplane(code)
ALTER TABLE Flight ALTER COLUMN airplaneCode int NOT NULL
ALTER TABLE Flight DROP CONSTRAINT pk_fnumber

CREATE TABLE Customer (
	id int,
	fname varchar(20),
	lname varchar(20),
	email varchar(20)
);

ALTER TABLE Customer ADD CONSTRAINT id_pk PRIMARY KEY(id)
ALTER TABLE Customer ADD CONSTRAINT email_validation check (email LIKE '%@%.%' AND LEN(email) >= 6)
ALTER TABLE Customer ALTER COLUMN fname_fk varchar(20) NOT NULL
ALTER TABLE Customer ALTER COLUMN lname_fk varchar(20) NOT NULL
ALTER TABLE Customer ALTER COLUMN email_fk varchar(20) NOT NULL

CREATE TABLE Booking (
	code int,
	agency varchar(20),
	airline_code int,
	flight_number char(4),
	customer_id int,
	booking_date date,
	flight_date date,
	price decimal(10, 2),
	status char(1)
);

ALTER TABLE Booking ADD CONSTRAINT PK_booking PRIMARY KEY (code, flight_number, flight_date)

ALTER TABLE Booking ADD CONSTRAINT fk_agency FOREIGN KEY (agency) REFERENCES Agency(name)
ALTER TABLE Booking DROP CONSTRAINT fk_agency
ALTER TABLE Booking ADD CONSTRAINT fk_airline_code FOREIGN KEY (airline_code) REFERENCES Airline(code)
ALTER TABLE Booking ADD CONSTRAINT fk_flight_number FOREIGN KEY (flight_number) REFERENCES Flight(fnumber)
ALTER TABLE Booking ADD CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES Customer(id)
ALTER TABLE Booking ALTER COLUMN agency varchar(20) NOT NULL
ALTER TABLE Booking ALTER COLUMN airline_code int NOT NULL
ALTER TABLE Booking ALTER COLUMN flight_number char(4) NOT NULL
ALTER TABLE Booking ALTER COLUMN customer_id int NOT NULL
ALTER TABLE Booking ALTER COLUMN price decimal(10, 2) NOT NULL
ALTER TABLE Booking ADD CONSTRAINT check_status CHECK(status IN (0,1))
ALTER TABLE Booking ALTER COLUMN status char(1) NOT NULL
ALTER TABLE Booking ADD CONSTRAINT vreme1 CHECK (flight_date >= booking_date)

/* INSERT DATA */
--airlines
INSERT INTO Airline
VALUES  ('AZ', 'Alitalia', 'Italy'),
		('BA', 'British Airways', 'United Kingdom'),
		('LH', 'Lufthansa', 'Germany'),
		('SR', 'Swissair', 'Switzerland'),
		('FB', 'Bulgaria Air', 'Bulgaria'),
		('SU', 'Aeroflot', 'Russian Federation'),
		('AF', 'Air France', 'France'),
		('TK', 'Turkish Airlines', 'Turkey'),
		('AA', 'American Airlines', 'United States'),
		('OA', 'Olympic Air', 'Greece'),
		('A3', 'Aegean Airlines', 'Greece'),
		('ET', 'Ethiopian Airlines', 'Ethiopia'),
		('U2', 'EasyJet', 'United Kingdom'),
		('DL', 'Delta Air Lines', 'France');
--airports
INSERT INTO Airport
VALUES	('SVO', 'Sheremetyevo', 'Russian Federation', 'Moscow'),
		('DME', 'Domodedovo', 'Russian Federation', 'Moscow'),
		('SOF', 'Sofia International', 'Bulgaria', 'Sofia'),
		('BOJ', 'Burgas International', 'Bulgaria', 'Burgas'),
		('CDG', 'Charles De Gaulle', 'France', 'Paris'),
		('ORY', 'Orly', 'France', 'Paris'),
		('LBG', 'Le Bourget', 'France', 'Paris'),
		('JFK', 'John F Kennedy International', 'United States','New York'),
		('ORD', 'Chicago O''Hare International', 'United States', 'Chicago'),
		('IST', 'Ataturk International', 'Turkey', 'Istanbul'),
		('ESB', 'Esenboga International', 'Turkey', 'Ankara'),
		('AHN', 'Athens', 'Greece', 'Athens'),
		('FKB', 'Karlsruhe', 'Germany', 'Karlsruhe'),
		('TXL', 'Tegel', 'Germany', 'Berlin'),
		('BER', 'Berlin Metropolitan Area', 'Germany', 'Berlin'),
		('MUC', 'Franz Josef Strauss', 'Germany', 'Munich'),
		('GVA', 'Geneve-Cointrin', 'Switzerland', 'Geneve'),
		('BRN', 'Belp', 'Switzerland', 'Berne'),
		('FCO', 'Leonardo da Vinci International', 'Italy', 'Rome'),
		('LIN', 'Linate', 'Italy', 'Milan'),
		('LHR', 'London Heathrow', 'United Kingdom', 'London');
--airplanes
INSERT INTO Airplane
VALUES	('319', 'Airbus A319', 150, 2003),
		('320', 'Airbus A320', 280, 2013),
		('321', 'Airbus A321', 150, 2018),
		('100', 'Fokker 100', 80, 2000),
		('738', 'Boeing 737-800', 90, 2020),
		('735', 'Boeing 737-800', 90, 2016),
		('AT5', 'ATR 42�0', 50, 1995),
		('DH4', 'De Havilland DHC-8-400', 70, 1992);
--flights
INSERT INTO Flight
VALUES	('FB1363', 'SU', 'SOF', 'SVO', '12:45', 100, '738'),
		('FB1364', 'SU', 'SVO', 'SOF', '10:00', 120, '321'),
		('SU2060', 'SU', 'SVO', 'SOF', '11:10', 110, '738'),
		('SU2061', 'SU', 'SOF', 'SVO', '13:00', 110, '320'),
		('FB363', 'FB', 'SOF', 'SVO', '15:10', 110, '738'),
		('FB364', 'FB', 'SVO', 'SOF', '21:05', 120, '738'),
		('FB437', 'FB', 'SOF', 'MUC', '09:10', 120, '319'),
		('FB438', 'FB', 'MUC', 'SOF', '12:10', 90, '738'),
		('TK1027', 'TK', 'IST', 'SOF', '07:00', 100, '738'),
		('TK1028', 'TK', 'SOF', 'IST', '10:00', 100, 'AT5'),
		('OA307', 'OA', 'AHN', 'SOF', '09:25', 40, '738'),
		('OA308', 'OA', 'SOF', 'AHN', '10:25', 40, '738'),
		('EZY3159', 'U2', 'LHR', 'SOF', '10:05', 90, '738'),
		('EZY3160', 'U2', 'SOF', 'LHR', '12:45', 90, '738'),
		('EZY1931', 'U2', 'LHR', 'SOF', '10:15', 90, '738'),
		('EZY1932', 'U2', 'SOF', 'LHR', '13:05', 90, '738'),
		('LH1702', 'LH', 'MUC', 'SOF', '10:10', 100, '738'),
		('LH1703', 'LH', 'SOF', 'MUC', '13:10', 100, '738'),
		('FB851', 'FB', 'SOF', 'LHR', '13:30', 100, '738'),
		('FB852', 'FB', 'LHR', 'SOF', '16:30', 100, '100'),
		('LH1426', 'LH', 'FKB', 'SOF', '11:05', 120, '738'),
		('LH1427', 'LH', 'SOF', 'FKB', '13:45', 120, '735'),
		('FB457', 'FB', 'SOF', 'CDG', '09:10', 100, '319'),
		('FB458', 'FB', 'ORY', 'SOF', '12:10', 100, '738'),
		('TK1037', 'TK', 'ESB', 'SOF', '07:00', 90, '738'),
		('TK1038', 'TK', 'SOF', 'ESB', '10:00', 90, 'AT5');
INSERT INTO Customer (id, fname, lname, email)
VALUES	(1, 'Petar', 'Milenov', 'petter@mail.com'),
		(2, 'Dimitar', 'Petrov', 'petrov@mail.com'),
		(3, 'Ivan', 'Ivanov', 'ivanov@mail.com'),
		(4, 'Petar', 'Slavov', 'slavov@mail.com'),
		(5, 'Bogdan', 'Bobov', 'bobov@mail.com'),
		(6, 'Petar', 'Kirov', 'kirov@mail.com'),
		(7, 'Vladimir', 'Petrov', 'vladov@mail.com');
INSERT INTO Agency
VALUES	('Travel One', 'Bulgaria', 'Sofia', '0783482233'),
		('Travel Two', 'Bulgaria', 'Plovdiv', '02882234'),
		('Travel Tour', 'Bulgaria', 'Sofia', NULL),
		('Aerotravel', 'Bulgaria', 'Varna', '02884233'),
		('Aerofly', 'Bulgaria', 'Sofia', '02882533'),
		('Fly Tour', 'Bulgaria', 'Sofia', '02881233');
INSERT INTO Booking
VALUES	('YN298P', 'Travel One', 'FB', 'FB1363', 1, '2023-04-20', '2023-12-25', 300, 0),
		('YA298P', 'Travel Two', 'TK', 'TK1038', 2, '2023-04-20', '2023-12-25', 300, 1),
		('YB298P', 'Travel Tour', 'TK', 'TK1037', 3, '2023-04-20', '2023-05-25', 400, 0),
		('YC298P', 'Travel One', 'TK', 'TK1028', 4, '2023-04-21', '2023-11-25', 350, 0),
		('YD298P', 'Travel Tour', 'TK', 'TK1028', 1, '2023-04-21', '2023-12-20', 250, 1),
		('YE298P', 'Aerofly', 'TK', 'TK1027', 2, '2023-04-21', '2023-12-21', 150, 0),
		('YJ298P', 'Aerofly', 'SU', 'SU2061', 3, '2023-04-22', '2023-12-05', 500, 1),
		('YS298P', 'Aerofly', 'SU', 'SU2061', 4, '2023-04-22', '2023-11-15', 400, 0),
		('YK298P', 'Aerofly', 'SU', 'SU2060', 1, '2023-04-22', '2023-08-08', 350, 0),
		('YM298P', 'Aerotravel', 'OA', 'OA308', 2, '2023-04-23', '2023-07-10', 350, 1),
		('YN198P', 'Aerotravel', 'OA', 'OA307', 3, '2023-04-23', '2023-11-25', 450, 0),
		('YN498P', 'Aerofly', 'LH', 'LH1703', 1, '2023-04-24', '2023-05-25', 300, 1),
		('YN598P', 'Aerotravel', 'FB', 'FB1363', 5, '2023-04-24', '2023-06-25', 300, 0),
		('YN698P', 'Fly Tour', 'FB', 'FB852', 6, '2023-04-24', '2023-07-25', 330, 1),
		('YL298P', 'Fly Tour', 'FB', 'FB851', 7, '2023-04-24', '2023-05-25', 360, 0),
		('YZ298P', 'Fly Tour', 'FB', 'FB458', 1, '2023-04-25', '2023-06-25', 380, 1),
		('YN268P', 'Fly Tour', 'FB', 'FB457', 2, '2023-04-25', '2023-12-21', 390, 0);
