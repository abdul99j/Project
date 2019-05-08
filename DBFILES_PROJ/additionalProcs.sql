use gameX8
CREATE PROCEDURE DELETE_MEDIA
@mediaID int,
@returnValue int
AS
BEGIN
	IF EXISTS(SELECT* FROM Media WHERE MediaID=@mediaID)
	BEGIN
		DELETE FROM Media WHERE MediaID=@mediaID
		SET @returnValue=0
	END
	ELSE
	BEGIN
		SET @returnValue=1
	END
END
GO

SELECT* FROM ReviewForGames
SELECT * FROM games
insert into games values(0,'Rainbow six','DESC','12-JUL-2017','Action','Ubisoft');
insert into games values(1,'Assasin s Creed Unity','DESC','12-JUL-2018','Action','Ubisoft');
insert into games values(2,'Far Cry','DESC','12-JUL-2018','Action','action');
insert into games values(3,'Fornite','DESC','12-JUL-2017','Action','epic games');

update users set userStatus='admin' where userName='abdul99j'



select * from games
select *from Media
select *from review



insert into Media values(0,1,'~/Media/asu1.jpg')
insert into Media values(1,1,'~/Media/asu2.jpg')
insert into Media values(2,1,'~/Media/asu3.jpg')
insert into Media values(3,2,'~/Media/fc1.jpg')
insert into Media values(4,2,'~/Media/fc2.jpg')
insert into Media values(5,2,'~/Media/fc3.jpg')
insert into Media values(6,3,'~/Media/fortnite.jpg')
insert into Media values(7,3,'~/Media/fortnite1.jpg')
insert into Media values(8,3,'~/Media/fortnite2.jpg')

SELECT *FROM  UserGames

select *from media where MediaID=1 
GO
CREATE PROCEDURE InsertUserGames
@userName nvarchar(30),
@gameID int,
@orderDate datetime,
@returnValue int output
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM UserGames WHERE userName=@userName AND gameID=@gameID)
	BEGIN
		INSERT INTO UserGames VALUES(@gameID,@userName,@orderDate)
		SET @returnValue=0
	END

	ELSE
		BEGIN
			SET @returnValue=1
		END
END
GO		

  