create database GameX8

create table games(
    gameID int NOT NULL,
	gameName nvarchar(50) NOT NULL,
    gameDescription nvarchar(1000),
	ReleaseDate date,
	genre nvarchar(20),
	developer nvarchar(20)
);

create table users(
     userName nvarchar(30) NOT NULL,
	 Fname nvarchar(30),
	 Lname nvarchar(30),
	 userPassword nvarchar(100),
	 userStatus nvarchar(10) NOT NULL DEFAULT 'user',
	 userEmail nvarchar(100) NOT NULL,
	 dateOfBirth date,
	 gender char,
	 check(userStatus='admin'OR userStatus='user'),
	 check(gender='M' OR gender='F')
);

create table review(
	reviewID int NOT NULL,
	gameID int NOT NULL,
	userName nvarchar(30) NOT NULL,
	dateGiven date,
	rating int,
	reviewDescription int, 
	check(rating BETWEEN 1 AND 5)
);

create table UserGames(
    orderID int NOT NULL,
	gameID int NOT NULL,
	userName nvarchar(30) NOT NULL,
	orderDate date,
);

create table Media(
	MediaID int NOT NULL,
	gameID  int NOT NULL,
	MediaLink nvarchar(100),
	dated date
);

-- TO CHECK FOR CURRENT LOGIN SESSION ONLY
create Table loginTable(
    loginID int NOT NULL,
	userName nvarchar(30), --NOTNULL NEEDS TO BE ADDED HERE
	userPassword nvarchar(100),
);
