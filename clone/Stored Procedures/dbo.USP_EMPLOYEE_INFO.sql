SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE    PROC [dbo].[USP_EMPLOYEE_INFO] (@VAR VARCHAR(50))
   AS 
   DECLARE @VAL VARCHAR(50)
   PRINT 'NAME :'+ @VAL
   SET @VAL=@VAR
    PRINT 'NAME2 :'+ @VAL
   SELECT * 
    FROM HumanResources.Employee E JOIN
	     Person.ContactType C  ON C.ContactTypeID = E.BusinessEntityID
		 WHERE  JobTitle = @VAR
GO
