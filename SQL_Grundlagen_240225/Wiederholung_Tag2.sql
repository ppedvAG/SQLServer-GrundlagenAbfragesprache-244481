-- 1. Was war das meistverkaufte Produkt im Jahr 1998 (Productname)? Wieviel Stück (Quantity)?
SELECT TOP 1 ProductName, SUM(Quantity) as Verkaufsmenge FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
WHERE DATEPART(YEAR, OrderDate) = 1998
GROUP BY ProductName
ORDER BY Verkaufsmenge DESC

-- 2. Ist der Spediteur "Speedy Express"
-- über die Jahre durschnittlich teurer geworden (Freight pro Jahr)
SELECT CompanyName, DATEPART(YEAR, OrderDate) as Geschäftsjahr, AVG(Freight) as AvgFreight FROM Orders
JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
WHERE CompanyName = 'Speedy Express'
GROUP BY CompanyName, DATEPART(YEAR, OrderDate)
GO

--> Erweiterung:
-- Jahrweiser Vergleich unserer 3. Spediteure: (Shippers Tabelle): 
-- Lieferkosten (Freight) gesamt, Durchschnitt (freight)
-- pro Lieferung und Anzahl an Lieferungen
--> in eine View speichern
/*
	Ergebnis in etwa so:
	SpediteurName, Geschäftsjahr, FreightGesamt, FreightAvg, AnzBestellungen
	Sped 1		 ,1996			, xy		   , xy		   , xy
	Sped 1		 ,1996			, xy		   , xy		   , xy
	Sped 1		 ,1996			, xy		   , xy		   , xy
	usw....
*/

CREATE VIEW vSpediteurVergleich 
AS
SELECT CompanyName, 
DATEPART(YEAR, OrderDate) as Geschäftsjahr, 
SUM(Freight) as FreightGesamt,
AVG(Freight) as AvgFreight,
COUNT(OrderID) as AnzBestellungen
FROM Orders
JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
GROUP BY CompanyName, DATEPART(YEAR, OrderDate)
ORDER BY Geschäftsjahr, AvgFreight
GO

-- Erstelle eine Procedure, der man als Parameter eine OrderID übergeben kann.
-- Bei Ausführung soll der Rechnungsbetrag dieser Order ausgegeben werden 
-- SUM(Quantity * UnitPrice) + Freight = RechnungsSumme.

CREATE PROCEDURE sp_RechnungsSumme @OrderID INT
AS
SELECT Orders.OrderID ,SUM(Quantity * UnitPrice) + Freight as RechnungsSumme FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
WHERE Orders.OrderID = @OrderID
GROUP BY Orders.OrderID, Freight
GO

-- Ausgeben
EXEC sp_RechnungsSumme 10250
GO