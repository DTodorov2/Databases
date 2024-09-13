--Задача 2
--а) Нека създадем мини вариант на Facebook. Искаме да имаме следните
--релации (може да предложите и друг вариант):
-- -Users: уникален номер (id), email, парола, дата на регистрация.
-- -Friends: двойки от номера на потребители, напр. ако 12 е приятел на 21, 25 и
--40, ще има кортежи (12,21), (12,25), (12,40).
-- -Walls: номер на потребител, номер на потребител написал съобщението,
--текст на съобщението, дата.
-- -Groups: уникален номер, име, описание (по подразбиране - празен низ).
-- -GroupMembers: двойки от вида номер на група - номер на потребител.
--б) Добавете кортежи с примерни данни към новосъздадените релации.

CREATE DATABASE Facebook
GO
USE Facebook
GO

CREATE TABLE Users (
	id int PRIMARY KEY,
	email varchar(20),
	password varchar(25),
	regDate date
);

CREATE TABLE Friends (
	user_id int,
	friend_id int,
	PRIMARY KEY(user_id, friend_id),
	FOREIGN KEY(user_id) REFERENCES Users(id),
	FOREIGN KEY(friend_id) REFERENCES Users(id)
)

CREATE TABLE Walls (
	user_id int,
	write_id int,
	content varchar(100),
	write_date date,
	FOREIGN KEY(user_id) REFERENCES Users(id),
	FOREIGN KEY(write_id) REFERENCES Users(id)
);

CREATE TABLE Groups (
	id int PRIMARY KEY,
	name varchar(10),
	description varchar(100) DEFAULT '',
);

CREATE TABLE GroupMembers (
	group_id int,
	user_id int,
	PRIMARY KEY(group_id, user_id),
	FOREIGN KEY(group_id) REFERENCES Groups(id),
	FOREIGN KEY(user_id) REFERENCES Users(id)
);

INSERT INTO Users
VALUES (1, 'haknatsum@abv.bg', 'haha', '01-02-2017'), (2, 'kopirni@abv.bg', 'kopiram vsichko', '04- 07 - 2020')

INSERT INTO Friends
VALUES (1, 2)
