--GET INACTIVE USERS
CREATE PROCEDURE GET_INACTIVE_USERS
@returnValue int OUTPUT
AS 
BEGIN
	SELECT users.userName,users.userEmail,UserGames.gameID FROM users 
			  JOIN UserGames ON(users.userName=UserGames.userName)
			  GROUP BY users.userName,users.userEmail,UserGames.gameID 
			  HAVING COUNT(users.userName)<=1
END
GO
--DELETE ALL USERS EXCEPT ADMIN
create procedure delete_users
@returnValue int output
AS
BEGIN
	DELETE FROM users Where users.userStatus!='admin'
	SET @returnValue=0;
END
GO

CREATE PROCEDURE ADD_ADMIN
@userName nvarchar(30),
@Fname nvarchar(30),
@Lname nvarchar(30),
@userPassword nvarchar(100),
@userEmail nvarchar(100),
@dateOfBirth date,
@gender char,
@returnValue int OUTPUT
AS
BEGIN
	IF NOT EXISTS(SELECT *FROM users WHERE userName=@userName)
	BEGIN
		insert into users values(@userName,@Fname,@Lname,@userPassword,'admin',@userEmail,@dateOfBirth
		,@gender)
		SET @returnValue=0
	END
	ELSE IF EXISTS(SELECT* FROM users WHERE userName=@userName)
	
	BEGIN
		SET @returnValue=1
	END
END
GO

--INSERT NEW USER (ADMIN MODE)
create procedure insert_user
@userName nvarchar(30),
@Fname nvarchar(30),
@Lname nvarchar(30),
@userPassword nvarchar(100),
@userStatus nvarchar(10),
@userEmail nvarchar(100),
@dateOfBirth date,
@gender char,
@returnValue int OUTPUT
AS
BEGIN
	IF NOT EXISTS(SELECT *FROM users WHERE userName=@userName)
	BEGIN
		insert into users values(@userName,@Fname,@Lname,@userPassword,@userStatus,@userEmail,@dateOfBirth
		,@gender)
		SET @returnValue=0
	END
	ELSE IF EXISTS(SELECT* FROM users WHERE userName=@userName)
	
	BEGIN
		SET @returnValue=1
	END
END
GO

--VALIDATE DELETE USER
CREATE PROCEDURE DELTE_VALID_USER
@userName nvarchar(30),
@returnValue int OUTPUT
AS
BEGIN
	IF EXISTS(SELECT *FROM users WHERE userName=@userName)
	BEGIN
		DELETE FROM users WHERE userName=@userName
		SET @returnValue=0
	END
	ELSE
	BEGIN
		SET @returnValue=1
	END
END
GO
--VIEW_SHOW_ALL
CREATE VIEW SHOW_ALL_USERS
AS
SELECT *FROM users
GO
--VIEW_SHOW_ADMIN
CREATE VIEW SHOW_ADMINS
AS
SELECT *FROM users WHERE userStatus='admin'
GO

CREATE TRIGGER SINGLE_ADMIN
ON users
after delete
AS
BEGIN
DECLARE @ADMIN_COUNT int
	SELECT @ADMIN_COUNT=COUNT(*) FROM users
	WHERE userStatus='admin'

	IF(@ADMIN_COUNT=1)
		PRINT 'ERROR 404 DELETE NOT FOUND'
		rollback transaction
END
GO
