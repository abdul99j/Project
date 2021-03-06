--login & signup procedures
--OUTPUT FLAGS SUCCESS=0
--NULL VALUES FAILURE=1
--KEY VIOLATION FAILURE=2
use gameX8
GO

CREATE PROCEDURE SIGN_UP
@UserName nvarchar(30),
@fname nvarchar(30),
@lname nvarchar(30),
@UserPassword nvarchar(100),
@UserStatus nvarchar(10),
@UserEmail nvarchar(100),
@DateOfBirth date,
@Gender char,
@out_flag int OUTPUT

AS 
BEGIN 
	IF NOT EXISTS(SELECT *FROM users WHERE userName=@UserName)
	
	BEGIN
	

	insert into users values(@UserName,@fname,@lname,@UserPassword,
	@UserStatus,@UserEmail,@DateOfBirth,@Gender)
	SET @out_flag=0
	
	END

	ELSE IF EXISTS(SELECT *FROM users WHERE userName=@UserName)
	BEGIN
		SET @out_flag=1
	END

	ELSE
	BEGIN 
		SET @out_flag=2
	END 


END
GO



--TEST
DECLARE @return_value int 
EXEC SIGN_UP 'raptoMod','raptor','mod','090078601','admin','raptor@gmail.com','17-JUL-1990','M',@return_value
SELECT @return_value
GO

ALTER PROCEDURE LOG_IN
@UserName nvarchar(30),
@UserPassword nvarchar(30),
@Out_Flag int OUTPUT
AS 
BEGIN
	IF EXISTS(SELECT userName=@UserName 
			  FROM users
			  WHERE userPassword=@UserPassword)

	BEGIN
		SET @Out_Flag=0
	 END
	ELSE
	BEGIN 
		SET @Out_Flag=1
	END
END
GO



declare
@return_value int
EXEC LOG_IN 'abdul99j','090078601',@return_value output 
SELECT @return_value


