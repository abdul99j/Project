create database GameX8

use GameX8
select *from users

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
	 check(gender='Male' OR gender='Female')
);
alter table users DROP constraint CK__users__gender__5EBF139D
alter table users alter column gender char
alter table users ADD CONSTRAINT CEHCK_GENDER CHECK(gender='M' OR gender='F')

create procedure 

exec dbo.ins

select *from users

create table reviewGiven(
	reviewID int NOT NULL,
	gameID int NOT NULL,
	userName nvarchar(30) NOT NULL,
);


create table review(
	reviewID int NOT NULL,
	rating int,
	reviewDescription int,
	dateGive date, 
	check(rating BETWEEN 1 AND 5)
);


create table UserGames(
    gameID int NOT NULL,
	userName nvarchar(30) NOT NULL,
	orderDate datetime,
);




create table Media(
	MediaID int NOT NULL,
	gameID int NOT NULL,
	MediaLink nvarchar(100),
);


-- TO CHECK FOR CURRENT LOGIN SESSION ONLY

--PRIMARY KEYS FOR ALL TABLES

alter table games add constraint PK_GAME primary key(gameID)
alter table users add constraint PK_USERS primary key (userName)
alter table UserGames add constraint PK_USERSGAMES primary key (gameID,userName)


alter table Media add constraint PK_MEDIA primary key (MediaID,gameID)
alter table review add constraint PK_REVIEW primary key (reviewID)
alter table reviewGiven add constraint PK_REVIEW_GIVEN primary key(reviewID,userName,gameID)
.--alter table MediaFor add constraint PK_MEDIA_FOR primary key(mediaID,gameID)
--FORIEGN KEYS FOR ALL TABLES

ALTER TABLE reviewGiven
ADD CONSTRAINT FK_REVIEWS
FOREIGN KEY(reviewID) REFERENCES review(reviewID) ON UPDATE CASCADE ON DELETE CASCADE


ALTER TABLE reviewGiven
ADD CONSTRAINT FK_REVIEWS_ONE
FOREIGN KEY (gameID) REFERENCES games(gameID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE reviewGiven
ADD CONSTRAINT FK_REVIEWS_TWO
FOREIGN KEY (userName) REFERENCES users(userName) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE UserGames
ADD CONSTRAINT FK_USER_GAMES
FOREIGN KEY (gameID) REFERENCES games(gameID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE UserGames
ADD CONSTRAINT FK_UG_ONE
FOREIGN KEY (userName) REFERENCES users(userName) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE Media
ADD CONSTRAINT FK_MEDIA
FOREIGN KEY (gameID) REFERENCES games(gameID) ON UPDATE CASCADE ON DELETE CASCADE;
-- END OF FOREIGN_KEYS 
