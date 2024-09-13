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