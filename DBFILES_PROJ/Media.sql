--VALIDATE DELTE MEDIA
CREATE PROCEDURE DELTE_VALID_MEDIA
@mediaID int,
@returnValue int OUTPUT
AS
BEGIN
	IF EXISTS(SELECT *FROM Media WHERE MediaID=@mediaID)
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

--GET ALL MEDIA PER GAME
CREATE PROCEDURE GET_MEDIA_FOR_GAME
@gameID int,
@returnValue int OUTPUT
AS
BEGIN
	SELECT Media.MediaID,Media.MediaLink FROM Media
	JOIN games ON(Media.gameID=games.gameID)
	WHERE Media.gameID=@gameID
	SET @returnValue=0
END
GO
--DELETE MEDIA RELATIVE TO GAME
CREATE PROCEDURE DELTE_MEDIA_GAME
@gameID int,
@returnValue int OUTPUT
AS 
BEGIN
	IF EXISTS(SELECT *FROM games JOIN Media ON(games.gameID=Media.gameID)
	WHERE Media.gameID=@gameID)
	
	BEGIN
		DELETE FROM Media WHERE gameID=@gameID
		SET @returnValue=0	
	END

	ELSE
	BEGIN
		SET @returnValue=1
	END
END
GO

ALTER PROCEDURE INSERT_MEDIA
@MediaID int,
@gameID  int,
@MediaLink nvarchar(100),
@returnValue int OUTPUT
AS
BEGIN
	IF NOT EXISTS(SELECT *FROM Media WHERE MediaID=@MediaID)
	BEGIN
		insert into Media values(@MediaID,@gameID,@MediaLink)
		SET @returnValue=0
	END

	ELSE IF EXISTS(SELECT *FROM Media WHERE MediaID=@MediaID)
	BEGIN
		SET @returnValue=1
	END

	ELSE
		BEGIN
			SET @returnValue=2
		END
END
GO


CREATE VIEW ALL_SITE_MEDIA AS
SELECT* FROM Media
GO

CREATE VIEW MEDIA_RELATIVE_TO_GAME
AS
SELECT Media.MediaID,Media.MediaLink,games.gameID,games.gameName,games.developer,games.genre
FROM Media
JOIN games ON(Media.gameID=games.gameID)
GO


CREATE TRIGGER DUP_EXCEPT_MEDIA
ON Media
instead of insert
AS
BEGIN
	DECLARE @gameID int,
			@MediaLink nvarchar(100)

			SELECT @gameID=gameID,@MediaLink=MediaLink
			FROM inserted

			IF EXISTS(SELECT *FROM Media WHERE  gameID=@gameID AND MediaLink=@MediaLink)
			BEGIN
				PRINT 'NO DUPLICATE ENTRY ALLOWED'
			END
			
			ELSE
			BEGIN
				insert into Media
				SELECT* FROM inserted
			ENd
END

			
GO

CREATE PROCEDURE DELETE_ALL_MEDIA
AS
BEGIN
	DELETE FROM Media
END
GO

CREATE PROCEDURE ShowMediaForGame
@gameID int
AS
BEGIN
	SELECT *FROM MEDIA_RELATIVE_TO_GAME WHERE gameID=@gameID
END
