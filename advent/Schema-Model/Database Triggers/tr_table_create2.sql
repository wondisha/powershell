﻿/*
    This script was generated by SQL Change Automation to help provide object-level history. This script should never be edited manually.
    For more information see: https://www.red-gate.com/sca/dev/offline-schema-model
*/

IF EXISTS (SELECT * FROM sys.triggers WHERE parent_class_desc = 'DATABASE' AND name = N'tr_table_create2')
	DROP TRIGGER [tr_table_create2] ON DATABASE;

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 CREATE  trigger  [tr_table_create2]
  on database 
   AFTER  CREATE_TABLE 
   AS 
    BEGIN 
	PRINT  'U CANT CREATE A DATABASE'
	END
GO