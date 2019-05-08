CREATE VIEW ReviewForGames
AS
SELECT R.reviewID,R.rating,R.reviewDescription,R.dateGive,RG.gameID,RG.userName FROM review AS R JOIN reviewGiven AS RG
ON (R.reviewID=RG.reviewID)
GO




--SHOW ALL REVIEWS PER GAME
ALTER PROCEDURE REVIEWS_PER_GAME

@gameID int,
@returnValue int OUTPUT
AS
BEGIN
	IF EXISTS(SELECT* FROM ReviewForGames 
			  WHERE  ReviewForGames.gameID=@gameID)
	BEGIN
		      SELECT* FROM ReviewForGames 
			  WHERE  ReviewForGames.gameID=@gameID
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
JOIN reviewgiven ON(reviewGiven.gameID=games.gameID)
JOIN review ON(reviewGiven.reviewID=review.reviewID)
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
	
	IF NOT EXISTS(SELECT* FROM reviewGiven where userName=@userName AND gameID=@gameID AND reviewID=@reviewID)
	BEGIN
	insert into reviewGiven Values(@reviewID,@gameID,@userName)
	insert into review VALUES(@reviewID,@rating,@reviewDescription,@dateGiven)
	SET @returnFlag=0
	END

	ELSE
	BEGIN
	SET @returnFlag=1
	END
END
GO





ALTER PROCEDURE UPDATE_BY_USERNAME
@userName nvarchar(30),
@gameID int,
@rating int,
@Comments nvarchar(300),
@returnValue int OUTPUT
AS
BEGIN
	DECLARE @reviewID int
	IF EXISTS(SELECT* FROM reviewGiven where gameID=@gameID AND userName=@userName)
	BEGIN
		SELECT @reviewID=review.reviewID FROM reviewGiven 
		JOIN review ON(review.reviewID=reviewGiven.reviewID)
		WHERE (gameID=@gameID AND userName=@userName)
		
		UPDATE review SET review.reviewDescription=@Comments WHERE (review.reviewID=@reviewID)
	END

END
GO

ALTER PROCEDURE DELETE_REVIEW
@reviewID int,
@returnValue int OUTPUT
AS 
BEGIN
	IF EXISTS(SELECT * FROM review WHERE review.reviewID=@reviewID)
	
	BEGIN
	DELETE FROM review WHERE reviewID=@reviewID
	DELETE FROM reviewGiven WHERE reviewID=@reviewID
	SET @returnValue=0
	END

	ELSE
		BEGIN
		SET @returnValue=1
		END
END
GO

ALTER Procedure ShowReviewGivenByUser
@UserName nvarchar(30),
@out_flag int OUTPUT
As
Begin
	IF Not Exists (Select* from users where userName=@UserName)
	Begin
	Set @out_flag=1 --User Does not Exist
	End
	Else If Not Exists(Select* from reviewGiven where userName=@UserName)
	Begin
	Set @out_flag=2 --User has Not Given Any Review
	END
	Else
	Begin 
		Select *
		from reviewGiven
		JOIN review ON (review.reviewID=reviewGiven.reviewID)
		where reviewGiven.userName=@UserName
		set @out_flag=0
	End
End
GO
--USER GOT GAME BUT NOT GIVEN REVIEW
ALTER PROCEDURE REVIEWS_TO_BE_GIVEN
@userName nvarchar(30)
AS
BEGIN
	SELECT*
	FROM users
	JOIN UserGames ON(users.userName=UserGames.userName)
	LEFT JOIN reviewGiven ON (UserGames.gameID=reviewGiven.gameID)
	LEFT JOIN review ON (reviewGiven.reviewID=review.reviewID)
	WHERE review.rating IS NULL OR review.reviewID IS NULL
END
GO

CREATE PROCEDURE SORT_REVIEW_BY_DATE_DESC
@gameID int
AS
BEGIN
	
	SELECT rating,reviewDescription,dateGive
	FROM ReviewForGames
	WHERE ReviewForGames.gameID=@gameID
	ORDER BY ReviewForGames.dateGive DESC
END
GO

ALTER PROCEDURE SORT_REVIEW_BY_DATE_ASC
@gameID int
AS
BEGIN
	
	SELECT rating,reviewDescription,dateGive
	FROM ReviewForGames
	WHERE ReviewForGames.gameID=@gameID
	ORDER BY ReviewForGames.dateGive ASC
END