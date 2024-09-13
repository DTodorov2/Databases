CREATE DATABASE FurnitureCompany
Go


CREATE TABLE CUSTOMER (
	Customer_id int NOT NULL IDENTITY PRIMARY KEY,
	Customer_name varchar(20) NOT NULL,
	Customer_address varchar(30) NOT NULL,
	Customer_city varchar(20),
	City_code int NOT NULL
)


CREATE TABLE ORDER_T (
	Order_id int NOT NULL PRIMARY KEY,
	Order_date date NOT NULL,
	Customer_id int NOT NULL FOREIGN KEY REFERENCES CUSTOMER(Customer_id)
)

CREATE TABLE PRODUCT1 (
	Product_id int NOT NULL PRIMARY KEY,
	Product_Description varchar(100),
	Product_finish varchar(20) check (Product_finish IN ('череша', 'естествен ясен', 'бял ясен',
'червен дъб', 'естествен дъб', 'орех')),
	Standart_price int NOT NULL,
	Product_line_ID int NOT NULL

)

CREATE TABLE ORDER_LINE (
	Order_id int NOT NULL FOREIGN KEY REFERENCES ORDER_T(Order_id),
	Product_id int NOT NULL FOREIGN KEY REFERENCES PRODUCT1(Product_id),
	Ordered_quantity int NOT NULL
)

DROP TABLE CUSTOMER
DROP TABLE ORDER_T
DROP TABLE ORDER_LINE
DROP TABLE PRODUCT1

insert into CUSTOMER values
('Не знам', 'ул. лелеле', 'Каспичан', '3000');

insert into CUSTOMER values
('Иван Петров', 'ул. Лавеле 8', 'София', '1000'),
('Камелия Янева', 'ул. Иван Шишман 3', 'Бургас', '8000'),
('Васил Димитров', 'ул. Абаджийска 87', 'Пловдив', '4000'),
('Ани Милева', 'бул. Владислав Варненчик 56', 'Варна','9000');

insert into PRODUCT1 values
(1000, 'офис бюро', 'череша', 195, 10),
(1001, 'директорско бюро', 'червен дъб', 250, 10),
(2000, 'офис стол', 'череша', 75, 20),
(2001, 'директорски стол', 'естествен дъб', 129, 20),
(3000, 'етажерка за книги', 'естествен ясен', 85, 30),
(4000, 'настолна лампа', 'естествен ясен', 35, 40);

insert into ORDER_T values
(100, '2013-01-05', 1),
(101, '2013-12-07', 2),
(102, '2014-10-03', 3),
(103, '2014-10-08', 2),
(104, '2015-10-05', 1),
(105, '2015-10-05', 4),
(106, '2015-10-06', 2),
(107, '2016-01-06', 1);

insert into ORDER_LINE values
(100, 4000, 1),
(101, 1000, 2),
(101, 2000, 2),
(102, 3000, 1),
(102, 2000, 1),
(106, 4000, 1),
(103, 4000, 1),
(104, 4000, 1),
(105, 4000, 1),
(107, 4000, 1);

SELECT PRODUCT1.Product_id, PRODUCT1.Product_Description ,SUM(ORDER_LINE.Ordered_quantity) AS NUM_ORDERED FROM PRODUCT1
LEFT JOIN ORDER_LINE ON PRODUCT1.Product_id = ORDER_LINE.Product_id
WHERE ORDER_LINE.Ordered_quantity > 0
GROUP BY PRODUCT1.Product_id, PRODUCT1.Product_Description

SELECT CUSTOMER.Customer_name, COUNT(CUSTOMER.Customer_id) AS NUM_ORDERS FROM CUSTOMER
RIGHT JOIN ORDER_T ON CUSTOMER.Customer_id = ORDER_T.Customer_id
GROUP BY ORDER_T.Customer_id, CUSTOMER.Customer_name
