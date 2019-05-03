SELECT *FROM UserGames
GO

ALTER PROCEDURE ADD_NEW_ORDER
@gameID int,
@userName nvarchar(30),
@returnValue int
AS
BEGIN
	IF NOT EXISTS(SELECT *FROM UserGames 
				 WHERE gameID=@gameID AND userName=@userName)
	  BEGIN
		insert into UserGames values(@gameID,@userName,GETDATE())
		SET @returnValue=0
	  END
	ELSE
		BEGIN
		SET @returnValue=1
		END
END
GO
--EXCEPTION TO DUPLICATE ORDER DOESN't ALLOW
CREATE TRIGGER DUP_EXCEPT_ORDER
ON UserGames
INSTEAD OF INSERT 
AS 
BEGIN
DECLARE @gameID int,
		@userName nvarchar(30)
		SELECT @gameID=gameID,@userName=userName FROM inserted

		IF EXISTS(SELECT gameID,userName
				  FROM UserGames
				  WHERE gameID=@gameID AND userName=@userName)
				  
				  BEGIN
					PRINT 'ERROR 606 CANT INSERT'
				  END
		ELSE
			insert into UserGames
			SELECT *FROM inserted
END
GO

CREATE PROCEDURE REMOVE_USER_GAME
@userName nvarchar(30),
@gameID int,
@returnValue int OUTPUT
AS
BEGIN
	IF EXISTS(SELECT *FROM UserGames WHERE userName=@userName AND gameID=@gameID)
	BEGIN
		DELETE FROM UserGames WHERE (userName=@userName AND gameID=@gameID)
		SET @returnValue=0
	END

ELSE
	BEGIN
		SET @returnValue=1
	END
END
GO

CREATE PROCEDURE SHOW_USER_WITH_GAMES
@userName nvarchar(30)
AS
BEGIN
	SELECT UserGames.userName,games.gameName,games.genre FROM UserGames
	JOIN games ON(UserGames.gameID=games.gameID)
END
GO


CREATE PROCEDURE HIGHEST_NO_OF_GAMES
@Nth int
AS
BEGIN
	SELECT TOP (@Nth) users.userName,COUNT(*) AS NoOfGames FROM users
	JOIN UserGames ON(users.userName=UserGames.userName)
	JOIN games ON(games.gameID=UserGames.gameID)
	GROUP BY users.userName
	ORDER BY NoOfGames DESC
END
GO

CREATE PROCEDURE LOWEST_NO_OF_GAMES
@Nth int
AS
BEGIN
	SELECT TOP (@Nth) users.userName,COUNT(*) AS NoOfGames FROM users
	JOIN UserGames ON(users.userName=UserGames.userName)
	JOIN games ON(games.gameID=UserGames.gameID)
	GROUP BY users.userName
	ORDER BY NoOfGames ASC
END
GO



