﻿/*
    This script was generated by SQL Change Automation to help provide object-level history. This script should never be edited manually.
    For more information see: https://www.red-gate.com/sca/dev/offline-schema-model
*/

IF OBJECT_ID('[dbo].[vw_Salesterritory]') IS NOT NULL
	DROP VIEW [dbo].[vw_Salesterritory];

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE  VIEW [dbo].[vw_Salesterritory]
AS ( SELECT [Name]  FROM Sales.SalesTerritory )
GO