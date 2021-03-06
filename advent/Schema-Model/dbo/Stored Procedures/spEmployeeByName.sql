/*
    This script was generated by SQL Change Automation to help provide object-level history. This script should never be edited manually.
    For more information see: https://www.red-gate.com/sca/dev/offline-schema-model
*/

IF OBJECT_ID('[dbo].[spEmployeeByName]') IS NOT NULL
	DROP PROCEDURE [dbo].[spEmployeeByName];

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE    PROC [dbo].[spEmployeeByName]
@LastName nvarchar(50)  = NULL 
AS
   SET NOCOUNT ON
    BEGIN 
	   IF @LastName IS NULL
	       SELECT p.LastName, p.FirstName, e.JobTitle, e.HireDate
		   FROM Person.Person p
		   JOIN HumanResources.Employee e
		   ON p. BusinessEntityID = e.BusinessEntityID
	   ELSE 
		   SELECT p.LastName, p.FirstName, e.JobTitle, e.HireDate
		   FROM Person.Person p
		   JOIN HumanResources.Employee e
		   ON p. BusinessEntityID = e.BusinessEntityID
		   WHERE p.LastName LIKE @LastName + '%';
	END 
GO
