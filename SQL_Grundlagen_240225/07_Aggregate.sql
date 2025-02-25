USE Northwind
GO

-- Aggregatfunktionen: Führt eine Berechnung auf einer Menge von Werten durch und gibt
--					   einen einzigen Wert zurück
-- Ausnahme: COUNT(*) ignoriert keine NULL Werte, Aggregatfunktionen schon

-- 5 grundsätzliche verschiedene Funktionen

SELECT 
SUM(Freight) as Summe,
MIN(Freight) as Minimum,
MAX(Freight) as Maximum,
AVG(Freight) as Durchschnitt,
Count(ShippedDate) as ZähleDatum, COUNT(*) as ZähleAlles
FROM Orders

-- AVG selber berechnen
SELECT SUM(Freight) / COUNT(*) as Average FROM Orders

-- Fehler: weil kein GROUP BY
SELECT CustomerID, SUM(Freight) FROM Orders

SELECT CustomerID, Freight FROM Orders
ORDER BY CustomerID

-- Freight Summe haben pro CustomerID als Gruppe
SELECT CustomerID, SUM(Freight) FROM Orders
GROUP BY CustomerID

-- Verkaufte Stueckzahlen pro Produkt haben, aber nur über 1000
-- Geht so nicht
SELECT ProductName as Produkt, SUM(Quantity) as SummeStueck FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
--WHERE SUM(Quantity) > 1000
GROUP BY ProductName
ORDER BY SummeStueck

-- HAVING nutzen: funktioniert 1zu1 wie WHERE, kann aber 
-- gruppierte/aggregierte Werte nachträglich filtern
SELECT ProductName as Produkt, SUM(Quantity) as SummeStueck FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
--WHERE SUM(Quantity) > 1000
GROUP BY ProductName
HAVING SUM(Quantity) > 1000
ORDER BY SummeStueck

