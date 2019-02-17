create database GameX8

create table games(
    gameID int NOT NULL,
	gameName nvarchar(50) NOT NULL,
    gameDescription nvarchar(400),
	ReleaseDate date,
	genre nvarchar(20),
	developer nvarchar(20)
);

create table users(
     userID int NOT NULL,
	 userName nvarchar(100),
	 Fname nvarchar(30),
	 Lname nvarchar(30),
	 userPassword nvarchar(100),
	 userStatus nvarchar(10) NOT NULL,
	 userEmail nvarchar(100) NOT NULL,
	 dateOfBirth date,
	 gender char,
	 check(userStatus='admin'OR userStatus='user'),
	 check(gender='M' OR gender='F')
);

create table review(
	reviewID int NOT NULL,
	gameID int NOT NULL,
	userID int NOT NULL,
	rating int,
	reviewDescription int 
);

create table UserGames(
    orderID int NOT NULL,
	gameID int NOT NULL,
	userID int NOT NULL,
	orderDate date,
);

create table Media(
	MediaID int NOT NULL,
	gameID  int NOT NULL,
	MediaLink nvarchar(100),
	dateed date
);

-- TO CHECK FOR CURRENT LOGIN SESSION ONLY
create Table loginTable(
    loginID int NOT NULL,
	userName nvarchar(100), --NOTNULL NEEDS TO BE ADDED HERE
	userPassword nvarchar(100),
);
-- FURTHER CONSTRAINTS TO BE ADDED