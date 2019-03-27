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
FOREIGN KEY (userID) REFERENCES users(userID);

ALTER TABLE review
ADD CONSTRAINT FK_REVIEWS_ONE
FOREIGN KEY (gameID) REFERENCES games(gameID);

ALTER TABLE UserGames
ADD CONSTRAINT FK_USER_GAMES
FOREIGN KEY (gameID) REFERENCES games(gameID);

ALTER TABLE UserGames
ADD CONSTRAINT FK_UG_ONE
FOREIGN KEY (userID) REFERENCES users(userID);

ALTER TABLE loginTable
ADD CONSTRAINT FK_LOGIN
FOREIGN KEY (userID) REFERENCES users(userID);

ALTER TABLE Media
ADD CONSTRAINT FK_MEDIA
FOREIGN KEY (gameID) REFERENCES games(gameID);

-- END OF FOREIGN_KEYS 

--UNIQUE KEYS



