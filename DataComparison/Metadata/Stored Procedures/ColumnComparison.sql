--CREATE PROCEDURE [Metadata].[ColumnComparison]
--	@table_a varchar(255),
--	@table_b varchar(255)
--AS
--BEGIN


DECLARE
  @table_a VARCHAR(255);

SET @table_a='SalesOrderDetail';

DECLARE
  @table_b VARCHAR(255);

SET @table_b='SalesOrderDetail_Update';

IF OBJECT_ID('tempdb..#a', 'U') IS NOT NULL
BEGIN
DROP TABLE #a;
END;

IF OBJECT_ID('tempdb..#b', 'U') IS NOT NULL
BEGIN
DROP TABLE #b;
END;

SELECT *
INTO #a
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME=@table_a;

SELECT *
INTO #b
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME=@table_b;

SELECT Base.COLUMN_NAME AS ColumnName,
       Base.ORDINAL_POSITION AS OrdinalPosition,
       Base.DATA_TYPE AS DataType,
       OrdinalCheck.COLUMN_NAME AS OrdinalEquivalent,
	  LevenshteinCheck.COLUMN_NAME AS ClosestLevenshteinMatch,
	  LevenshteinCheck.Distance AS LevenshteinDistance,
       CASE WHEN Base.COLUMN_NAME=NameCheck.COLUMN_NAME
         THEN 1 ELSE 0 END AS NameMatch,
       CASE WHEN Base.ORDINAL_POSITION=NameCheck.ORDINAL_POSITION
         THEN 1 ELSE 0 END AS OrdinalMatch,
       CASE WHEN Base.DATA_TYPE=NameCheck.DATA_TYPE
         THEN 1 ELSE 0 END AS TypeMatch,
	  CASE WHEN LevenshteinCheck.Distance = 0
         THEN 1 ELSE 0 END AS LevenshteinMatch
FROM #a
AS Base
FULL OUTER JOIN
#b
AS NameCheck
ON Base.COLUMN_NAME=NameCheck.COLUMN_NAME
   OR Base.COLUMN_NAME IS NULL
   OR NameCheck.COLUMN_NAME IS NULL
    LEFT OUTER JOIN
    #b
AS OrdinalCheck
    ON Base.ORDINAL_POSITION=OrdinalCheck.ORDINAL_POSITION
        CROSS APPLY
(
  SELECT TOP 1 dbo.LevenshteinDistance
  (Base.COLUMN_NAME, Compare.COLUMN_NAME, 0)
  AS Distance,
               Compare.COLUMN_NAME
  FROM #b
  AS Compare
  ORDER BY Distance
)
AS LevenshteinCheck


--END

