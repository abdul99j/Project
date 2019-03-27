--SHOW ALL REVIEWS PER GAME
CREATE PROCEDURE REVIEWS_PER_GAME

@gameID int,
@returnValue int OUTPUT
AS
BEGIN
	IF EXISTS(SELECT* FROM games 
			  JOIN review ON(games.gameID=review.gameID)
			  WHERE  games.gameID=@gameID)
	BEGIN
		      SELECT* FROM games 
			  JOIN review ON(games.gameID=review.gameID)
			  WHERE  games.gameID=@gameID
			  SET @returnValue=0
	END
	ELSE 
		BEGIN
			SET @returnValue=1
		END
END
GO

--SHOW GAMES WITH LOWEST RATING
--LOWEST
ALTER procedure Nth_lowest_rating
@Nth int,
@out_flag int OUTPUT
AS
BEGIN
	SELECT TOP(@Nth) *
    from AVG_RATINGS
	ORDER BY AVG_RATING DESC
	SET @out_flag=1
END



GO

--3 SHOW GAMES BY HIGHEST RATINGS
-- HIGHEST
create procedure NTh_highest_rating
@Nth int,
@out_flag int OUTPUT
AS
BEGIN
    SELECT TOP (@Nth) *FROM AVG_RATINGS
	ORDER BY AVG_RATING DESC
END


--AVG_RATING PER GAMES
ALTER VIEW AVG_RATINGS
AS
SELECT games.gameID,games.gameName,AVG(CAST(review.rating AS float)) AS AVG_RATING FROM games
JOIN review ON(review.gameID=games.gameID)
GROUP BY games.gameID,games.gameName
GO

--SHOW AVG RATING PER GAME
ALTER PROCEDURE SHOW_AVG_RATING
@gameID int, 
@returnValue int OUTPUT
AS
BEGIN
IF EXISTS(SELECT *FROM AVG_RATINGS WHERE gameID=@gameID)
	BEGIN
	  SELECT *FROM AVG_RATINGS WHERE gameID=@gameID
	  SET @returnValue=0
	END
ELSE IF NOT EXISTS(SELECT *FROM AVG_RATINGS WHERE gameID=@gameID)
	  BEGIN
		SET @returnValue=1
	  END
ELSE
	BEGIN 
		SET @returnValue=2
	END
END
GO

CREATE TRIGGER DUP_EXCEPT --DUPlICATE_EXCEPTION
ON review
instead of insert
AS
BEGIN
DECLARE @gameID int,
		@userName nvarchar(30)

		SELECT @gameID=gameID,@userName=userName FROM  inserted

		IF EXISTS(SELECT gameID,userName FROM review WHERE
				  gameID=@gameID AND userName=@userName)
		BEGIN
			PRINT 'DUPLICATE ENTRIES NOT ALLOWED BY SINGLE USER'
		END

		ELSE
			INSERT INTO review
			SELECT* FROM inserted
END
GO


CREATE PROCEDURE ADD_REVIEW
@reviewID int,
@gameID int,
@userName nvarchar(30),
@rating int,
@reviewDescription nvarchar(500),
@dateGiven date,
@returnFlag int OUTPUT
AS
BEGIN
	insert into review values(@reviewID,@gameID,@userName,@rating,@reviewDescription,@dateGiven)
	SET @returnFlag=0
END
GO

CREATE PROCEDURE UPDATE_BY_USERNAME
@userName nvarchar(30),
@gameID int,
@rating int,
@Comments nvarchar(300),
@returnValue int OUTPUT
AS
BEGIN
	IF EXISTS(SELECT userName,gameID FROM review WHERE userName=@userName AND gameID=@gameID)
	BEGIN
		IF(@Comments!=NULL)
		BEGIN
			UPDATE review SET reviewDescription=@Comments,rating=@rating
			SET @returnValue=0
		END
		ELSE IF(@Comments=NULL)
		BEGIN
			UPDATE review SET rating=@rating
			SET @returnValue=0
		END
	END
	ELSE
	BEGIN
		SET @returnValue=1
	END
END
GO

CREATE PROCEDURE DELETE_REVIEW
@reviewID int,
@returnValue int OUTPUT
AS 
BEGIN
	IF EXISTS(SELECT * FROM review WHERE review.reviewID=@reviewID)
	
	BEGIN
	DELETE FROM review WHERE reviewID=@reviewID
	SET @returnValue=0
	END

	ELSE
		BEGIN
		SET @returnValue=1
		END
END
GO

Create Procedure ShowReviewGivenByUser
@UserName nvarchar(30),
@out_flag int OUTPUT
As
Begin
	IF Not Exists (Select* from users where userName=@UserName)
	Begin
	Set @out_flag=1 --User Does not Exist
	End
	Else If Not Exists(Select* from review where userName=@UserName)
	Begin
	Set @out_flag=2 --User has Not Given Any Review
	END
	Else
	Begin 
		Select *
		from review
		where review.userName=@UserName
		set @out_flag=0
	End
End
GO
--USER GOT GAME BUT NOT GIVEN REVIEW
CREATE PROCEDURE REVIEWS_TO_BE_GIVEN
@userName nvarchar(30)
AS
BEGIN
	SELECT*
	FROM users
	JOIN UserGames ON(users.userName=UserGames.userName)
	LEFT JOIN review ON (UserGames.gameID=review.gameID)
	WHERE review.rating IS NULL OR review.reviewID IS NULL
END
GO

CREATE PROCEDURE SORT_REVIEW_BY_DATE_DESC
@gameID int
AS
BEGIN
	SELECT review.rating,review.reviewDescription,review.dateGiven
	FROM review
	JOIN users ON (review.userName=users.userName)
	JOIN games ON (games.gameID=review.gameID)
	WHERE games.gameID=@gameID
	ORDER BY review.dateGiven DESC
END
GO

CREATE PROCEDURE SORT_REVIEW_BY_DATE_ASC
@gameID int
AS
BEGIN
	SELECT review.rating,review.reviewDescription,review.dateGiven
	FROM review
	JOIN users ON (review.userName=users.userName)
	JOIN games ON (games.gameID=review.gameID)
	WHERE games.gameID=@gameID
	ORDER BY review.dateGiven ASC
END