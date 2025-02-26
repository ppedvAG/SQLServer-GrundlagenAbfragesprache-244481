USE Northwind
GO

-- Variablen allgemein

-- DECLARE: deklariert eine Variable
DECLARE @OrderID int = 10250

SELECT * FROM vRechnungsDaten
WHERE OrderID = @OrderID

SET @OrderID = 10251

SELECT * FROM vRechnungsDaten
WHERE OrderID = @OrderID

-- WHILE
DECLARE @Counter INT = 0

WHILE @Counter <= 5
BEGIN
SELECT 10
SET @Counter += 1
END

WHILE 1=1
BEGIN
SELECT 10
END


-- IF Prüfung:

DECLARE @CounterTwo int = 0

WHILE @CounterTwo <= 5
BEGIN
	IF @CounterTwo = 2 
		BEGIN SELECT 'Bin bei 2' END
		ELSE 
		BEGIN SELECT @CounterTwo END
SET @CounterTwo = @CounterTwo + 1
END
SELECT 'Ende'