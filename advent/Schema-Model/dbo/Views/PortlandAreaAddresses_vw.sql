/*
    This script was generated by SQL Change Automation to help provide object-level history. This script should never be edited manually.
    For more information see: https://www.red-gate.com/sca/dev/offline-schema-model
*/

IF OBJECT_ID('[dbo].[PortlandAreaAddresses_vw]') IS NOT NULL
	DROP VIEW [dbo].[PortlandAreaAddresses_vw];

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE  VIEW [dbo].[PortlandAreaAddresses_vw] WITH ENCRYPTION  
AS
SELECT AddressID,
AddressLine1,
City,
StateProvinceID,
PostalCode,
ModifiedDate
FROM Person.Address
WHERE PostalCode LIKE '970%'
OR PostalCode LIKE '971%'
OR PostalCode LIKE '972%'
OR PostalCode LIKE '986[6-9]%'
WITH CHECK OPTION;
GO
