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
	rating int,
	reviewDescription int,
	dateGive date, 
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

--PRIMARY KEYS FOR ALL TABLES

alter table games add constraint PK_GAME primary key(gameID)
alter table users add constraint PK_USERS primary key (userName)
alter table UserGames add constraint PK_USERSGAMES primary key (orderID)

alter table Media add constraint PK_MEDIA primary key (MediaID)
alter table loginTable add constraint PK_LOGINTABLE primary key (loginID)
alter table review add constraint PK_REVIEW primary key (reviewID)

--FORIEGN KEYS FOR ALL TABLES
ALTER TABLE review
ADD CONSTRAINT FK_REVIEWS
FOREIGN KEY (userName) REFERENCES users(userName);

ALTER TABLE review
ADD CONSTRAINT FK_REVIEWS_ONE
FOREIGN KEY (gameID) REFERENCES games(gameID);

ALTER TABLE UserGames
ADD CONSTRAINT FK_USER_GAMES
FOREIGN KEY (gameID) REFERENCES games(gameID);

ALTER TABLE UserGames
ADD CONSTRAINT FK_UG_ONE
FOREIGN KEY (userName) REFERENCES users(userName);

ALTER TABLE loginTable
ADD CONSTRAINT FK_LOGIN
FOREIGN KEY (userName) REFERENCES users(userName);

ALTER TABLE Media
ADD CONSTRAINT FK_MEDIA
FOREIGN KEY (gameID) REFERENCES games(gameID);

-- END OF FOREIGN_KEYS 
