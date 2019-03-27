--SHOW USER BY GAME
CREATE PROCEDURE SHOW_BY_GAMES
@returnValue int OUTPUT
AS
BEGIN
	SELECT DISTINCT users.userName,users.userEmail,games.gameName,games.genre FROM users
	JOIN UserGames ON(users.userName=UserGames.userName)
	JOIN games ON (UserGames.gameID=games.gameID)
	GROUP BY users.userName,users.userEmail,games.gameName,games.genre
	HAVING COUNT(games.gameID)>=1 
	SET @returnValue=0
END
GO
--VALIDATE DELETE FOR GAMES
CREATE PROCEDURE DELTE_VALID_GAME
@gameID int,
@returnValue int OUTPUT
AS
BEGIN
	IF EXISTS(SELECT *FROM games WHERE gameID=@gameID)
	BEGIN
		DELETE FROM games WHERE gameID=@gameID
		SET @returnValue=0
	END
	ELSE
	BEGIN
		SET @returnValue=1
	END
END
GO

--VALIDATE DELETE USER GAMES
CREATE PROCEDURE DELTE_VALID_USERGAMES
@userName nvarchar(30),
@gameID int,
@returnValue int OUTPUT
AS
BEGIN
	IF EXISTS(SELECT *FROM UserGames WHERE gameID=@gameID AND userName=@userName)
	BEGIN
		DELETE FROM UserGames WHERE gameID=@gameID AND userName=@userName
		SET @returnValue=0
	END
	ELSE
	BEGIN
		SET @returnValue=1
	END
END
GO

CREATE PROCEDURE SHOW_GAMES
AS
BEGIN
	SELECT* FROM games
END
GO

CREATE VIEW ALL_GAMES
AS
SELECT * FROM games
GO

Create Procedure ShowUserGames
@UserName nvarchar(30),
@out_flag int OUTPUT
As
Begin
	IF Not Exists (Select* from users where userName=@UserName)
	Begin
	Set @out_flag=1 --User Does not Exist
	End
	Else If Not Exists(Select* from UserGames where userName=@UserName)
	Begin
	Set @out_flag=2 --User Does not Own any Game
	END
	Else
	Begin 
		Select UserGames.userName,games.gameID,games.gameName,games.genre,games.developer,
		games.gameDescription,games.ReleaseDate,UserGames.orderDate
		from games join UserGames 
		on games.gameID=UserGames.gameID 
		where userName=@UserName
		set @out_flag=0
	End
End
go




DECLARE @return_value int 
Exec ShowUserGames @userName='ABDUL SAMAD',@out_flag=@return_value output
Select @return_value AS STATUS
GO

--Show User Games Sorted By ReleaseDate

Create Procedure ShowUserGamesSortedByReleaseDate 
@UserName nvarchar(30),
@out_flag int OUTPUT
As
Begin
	IF Not Exists (Select* from users where userName=@UserName)
	Begin
	Set @out_flag=1 --User Does not Exist
	End
	Else If Not Exists(Select* from UserGames where userName=@UserName)
	Begin
	Set @out_flag=2 --User Does not Own any Game
	END
	Else
	Begin 
		Select UserGames.userName,games.gameID,games.gameName,games.genre,games.developer,games.gameDescription,games.ReleaseDate,UserGames.orderDate
		from games join UserGames 
		on games.gameID=UserGames.gameID 
		where userName=@UserName
		order by games.ReleaseDate
		set @out_flag=0
	End
End
go

DECLARE @return_value int 
Exec ShowUserGamesSortedByReleaseDate @userName='ABDUL SAMAD',@out_flag=@return_value output
Select @return_value AS STATUS
GO

--Show User Games Sorted By OrderDate
Create Procedure ShowUserGamesSortedByOrderDate 
@UserName nvarchar(30),
@out_flag int OUTPUT
As
Begin

	IF Not Exists (Select* from users where userName=@UserName)
	Begin
	Set @out_flag=1 --User Does not Exist
	End
	Else If Not Exists(Select* from UserGames where userName=@UserName)
	Begin
	Set @out_flag=2 --User Does not Own any Game
	END
	Else
	Begin 
		Select UserGames.userName,games.gameID,games.gameName,games.genre,games.developer,games.gameDescription,games.ReleaseDate,UserGames.orderDate
		from games join UserGames 
		on games.gameID=UserGames.gameID 
		where userName=@UserName
		order by UserGames.orderDate
		set @out_flag=0
	End
End
go

DECLARE @return_value int 
Exec ShowUserGamesSortedByOrderDate @userName='ABDUL SAMAD',@out_flag=@return_value output
Select @return_value AS STATUS
GO

-- SHOW ALL GAMES OF USER MADE BY PARTICULAR DEVELOPER

Create Procedure ShowUserGamesByDeveloper 
@UserName nvarchar(30),
@developer nvarchar(30),
@out_flag int OUTPUT
As
Begin

	IF Not Exists (Select* from users where userName=@UserName)
	Begin
	Set @out_flag=1 --User Does not Exist
	End
	Else If Not Exists(Select* from UserGames where userName=@UserName)
	Begin
	Set @out_flag=2 --User Does not Own any Game
	END
	Else If Not Exists(Select* from games where developer=@developer)
	Begin
	Set @out_flag=3 --Developer Does not Exist
	END
	Else If Not Exists(Select* from games join  UserGames on games.gameID=UserGames.gameID where developer=@developer)
	Begin
	Set @out_flag=4 --User Does Not Own Any Games Made By this Developer
	END
	Else
	Begin 
		Select UserGames.userName,games.gameID,games.gameName,games.genre,games.developer,games.gameDescription,games.ReleaseDate,UserGames.orderDate
		from games join UserGames 
		on games.gameID=UserGames.gameID 
		where userName=@UserName And developer=@developer
		set @out_flag=0
	End
End
go


DECLARE @return_value int 
Exec ShowUserGamesByDeveloper @userName='ABDUL SAMAD',@developer='EA',@out_flag=@return_value output
Select @return_value AS STATUS
GO

-- SHOW ALL GAMES OF USER PER GENRE

Create Procedure ShowUserGamesByGenre
@UserName nvarchar(30),
@genre nvarchar(30),
@out_flag int OUTPUT
As
Begin

	IF Not Exists (Select* from users where userName=@UserName)
	Begin
	Set @out_flag=1 --User Does not Exist
	End
	Else If Not Exists(Select* from UserGames where userName=@UserName)
	Begin
	Set @out_flag=2 --User Does not Own any Game
	END
	Else If Not Exists(Select* from games where genre=@genre)
	Begin
	Set @out_flag=3 --Genre Does not Exist
	END
	Else If Not Exists(Select* from games join  UserGames on games.gameID=UserGames.gameID where genre=@genre)
	Begin
	Set @out_flag=4 --User Does Not Own Any Games of this Genre
	END
	Else
	Begin 
		Select UserGames.userName,games.gameID,games.gameName,games.genre,games.developer,games.gameDescription,games.ReleaseDate,UserGames.orderDate
		from games join UserGames 
		on games.gameID=UserGames.gameID 
		where userName=@UserName And genre=@genre
		set @out_flag=0
	End
End
go

SELECT* FROM games

DECLARE @return_value int 
Exec ShowUserGamesByGenre @userName='ABDUL SAMAD',@genre='FPS',@out_flag=@return_value output
Select @return_value AS STATUS
GO



CREATE TRIGGER VALID_RELEASE_DATE
ON games
INSTEAD OF INSERT
AS
BEGIN

DECLARE @testDate date
		SELECT @testDate=ReleaseDate FROM inserted
	IF (@testDate>GETDATE())
	BEGIN
	    PRINT 'INVALID RELEASE DATE'
	END

	ELSE
		INSERT INTO games
		SELECT* FROM games
	
END
GO

