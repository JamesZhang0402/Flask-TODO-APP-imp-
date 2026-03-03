USE WideWorldImporters;
GO

-- Long Query
SELECT *
FROM [Sales].[InvoiceLines] AS il
INNER JOIN [Sales].[Invoices] AS i ON i.InvoiceID = il.InvoiceID
INNER JOIN [Sales].[OrderLines] AS ol ON ol.OrderID = i.OrderID
INNER JOIN [Sales].[Orders] AS o ON o.OrderID = ol.OrderID;
GO

-- Long Query
SELECT *
FROM [Sales].[InvoiceLines] AS il
INNER JOIN [Sales].[Invoices] AS i ON i.InvoiceID = il.InvoiceID
WHERE il.StockItemID > 100;
GO

-- Long Query
SELECT *
FROM [Sales].[InvoiceLines] AS il
INNER JOIN [Sales].[Invoices] AS i ON i.InvoiceID = il.InvoiceID
WHERE i.ConfirmedReceivedBy = 'Alinne Matos';
GO

-- Query with INSERT
CREATE TABLE #Test (ID INT);

INSERT INTO #Test (ID)
SELECT OrderID
FROM [Sales].[Orders];
GO

DROP TABLE #Test;
GO

-- Estimated Execution Plan
-- Note: SHOWPLAN_ALL and SHOWPLAN_XML are typically run one at a time.
SET SHOWPLAN_ALL ON;
GO
SET SHOWPLAN_ALL OFF;
GO

SET SHOWPLAN_XML ON;
GO
SET SHOWPLAN_XML OFF;
GO
