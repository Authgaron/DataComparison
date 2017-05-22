--CREATE PROCEDURE [Metadata].[ColumnComparison]
--	@table_a varchar(255),
--	@table_b varchar(255)
--AS
--BEGIN

DECLARE @table_a varchar(255);
SET @table_a = 'SalesOrderDetail'; 
DECLARE @table_b varchar(255);
SET @table_b = 'SalesOrderDetail_Update'; 

	IF OBJECT_ID('tempdb..#a', 'U') IS NOT NULL
		DROP TABLE #a
	IF OBJECT_ID('tempdb..#b', 'U') IS NOT NULL
		DROP TABLE #b

	SELECT * 
	INTO #a
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = @table_a

	SELECT * 
	INTO #b
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = @table_b

	SELECT #a.COLUMN_NAME AS COLUMNS_A, #b.COLUMN_NAME AS COLUMNS_B,
		#a.ORDINAL_POSITION AS ORDINAL_A,#b.ORDINAL_POSITION AS ORDINAL_B,
		#a.DATA_TYPE AS TYPE_A, #b.DATA_TYPE AS TYPE_B,
		CASE WHEN #a.COLUMN_NAME = #b.COLUMN_NAME THEN 1 
			 ELSE 0 
		END AS Name_Match,
		CASE WHEN #a.ORDINAL_POSITION = #b.ORDINAL_POSITION THEN 1 
			 ELSE 0 
		END AS Ordinal_Match,
		CASE WHEN #a.DATA_TYPE = #b.DATA_TYPE THEN 1 
			 ELSE 0 
		END AS Type_Match
	--INTO Metadata.ColumnOrdinalMatch
	FROM 
	#a FULL OUTER JOIN #b
	ON #a.COLUMN_NAME = #b.COLUMN_NAME
	OR (#a.COLUMN_NAME <> #b.COLUMN_NAME AND #a.ORDINAL_POSITION = #b.ORDINAL_POSITION)
	ORDER BY Name_Match DESC, Ordinal_Match DESC, Type_Match DESC


--END

