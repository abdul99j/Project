-- ADDITTIONAL COLUMS FOR CURRENT LOGIN SESSION
alter table loginTable add userID int NOT NULL;


--PRIMARY KEYS FOR ALL TABLES

alter table games add constraint PK_GAME primary key(gameID)  
alter table users add constraint PK_USERS primary key (userID)
alter table UserGames add constraint PK_USERSGAMES primary key (orderID)

alter table Media add constraint PK_MEDIA primary key (MediaID)
alter table loginTable add constraint PK_LOGINTABLE primary key (loginID)
alter table review add constraint PK_REVIEW primary key (reviewID)

--FORIEGN KEYS FOR ALL TABLES
ALTER TABLE review
ADD CONSTRAINT FK_REVIEWS
FOREIGN KEY (userName) REFERENCES users(userName)
ON DELETE CASCADE ON UPDATE CASCADE


ALTER TABLE review
ADD CONSTRAINT FK_REVIEWS_ONE
FOREIGN KEY (gameID) REFERENCES games(gameID)
ON DELETE CASCADE ON UPDATE CASCADE

alter table review drop FK_REVIEWS_ONE

ALTER TABLE UserGames
ADD CONSTRAINT FK_USER_GAMES
FOREIGN KEY (gameID) REFERENCES games(gameID)
ON DELETE CASCADE ON UPDATE CASCADE

alter table UserGames drop constraint FK_USER_GAMES

ALTER TABLE UserGames
ADD CONSTRAINT FK_UG_ONE
FOREIGN KEY (userName) REFERENCES users(userName)
ON DELETE CASCADE ON UPDATE CASCADE

alter table UserGames drop constraint FK_UG_ONE

ALTER TABLE loginTable
ADD CONSTRAINT FK_LOGIN
FOREIGN KEY (userName) REFERENCES users(userName)
ON DELETE CASCADE ON UPDATE CASCADE 
alter table loginTable drop constraint FK_LOGIN

ALTER TABLE Media
ADD CONSTRAINT FK_MEDIA
FOREIGN KEY (gameID) REFERENCES games(gameID)
ON UPDATE CASCADE ON DELETE CASCADE

-- END OF FOREIGN_KEYS 

--UNIQUE KEYS



