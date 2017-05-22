CREATE TABLE [Comparisons].[SalesOrderDetail] (
    [SalesOrderID]          INT              NOT NULL,
    [SalesOrderDetailID]    INT              IDENTITY (1, 1) NOT NULL,
    [CarrierTrackingNumber] NVARCHAR (25)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [OrderQty]              SMALLINT         NOT NULL,
    [ProductID]             INT              NOT NULL,
    [SpecialOfferID]        INT              NOT NULL,
    [UnitPrice]             MONEY            NOT NULL,
    [UnitPriceDiscount]     MONEY            NOT NULL,
    [LineTotal]             NUMERIC (38, 6)  NOT NULL,
    [rowguid]               UNIQUEIDENTIFIER NOT NULL,
    [ModifiedDate]          DATETIME         NOT NULL
);

