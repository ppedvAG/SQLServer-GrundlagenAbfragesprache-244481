USE Northwind
GO
-- Views: Erzeugen eine Ansicht, deren Inhalt durch eine Abfrage definiert wird
/*
	Vorteile:
		- Um komplexere Afragen speichern
		- Sicherheit: User erlauben nur die View zu lesen, nicht zu verändern
		- Views immer aktuell (aktuelle Daten)
			=> beim Aufruf einer View wird das hinterlegte Statement ausgeführt
*/


CREATE VIEW vRechnungsDaten AS
SELECT
Orders.OrderID, 
Customers.CustomerID, Customers.CompanyName, Customers.Country, Customers.City, Customers.PostalCode, Customers.Address,
Orders.Freight, Orders.OrderDate,
Employees.LastName,
CAST(SUM((UnitPrice * Quantity) * (1 - Discount)) + Freight as decimal(10,2)) as SummeBestPosi 
FROM [Order Details]
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
JOIN Customers ON Customers.CustomerID = Orders.CustomerID
JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Orders.OrderID, 
Customers.CustomerID, Customers.CompanyName, Customers.Country, Customers.City, Customers.PostalCode, Customers.Address,
Orders.Freight, Orders.OrderDate,
Employees.LastName
GO

-- Aufruf der View
SELECT * FROM vRechnungsDaten
GO

-- View Löschen
-- DROP VIEW vRechnungsDaten

-- Code hinter einer View (oder anderem DB Objekt) ansehen über Objekt Explorere
-- Rechtsklick --> SKRIPT ALS --> CREATE IN --> Neuen Abfragefenster
-- ODER: Entwerfen

-- View ändern:
ALTER VIEW vRechnungsDaten AS
SELECT
Orders.OrderID, 
Customers.CustomerID, Customers.CompanyName, Customers.Country, Customers.City, Customers.PostalCode, Customers.Address,
Orders.Freight, Orders.OrderDate,
Employees.LastName,
CAST(SUM((UnitPrice * Quantity) * (1 - Discount)) + Freight as decimal(10,2)) as SummeBestPosi 
FROM [Order Details]
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
JOIN Customers ON Customers.CustomerID = Orders.CustomerID
JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Orders.OrderID, 
Customers.CustomerID, Customers.CompanyName, Customers.Country, Customers.City, Customers.PostalCode, Customers.Address,
Orders.Freight, Orders.OrderDate,
Employees.LastName
GO

-- Neue Ansicht: Alle Kunden aus Deutschland und Frankreich rausziehen
CREATE VIEW vKunden AS
SELECT CompanyName, Country FROM Customers
WHERE Country = 'France' OR Country = 'Germany'
GO

SELECT * FROM vKunden

-- 1. Wieviel Umsatz haben wir in jedem Geschäftsjahr insgesamt gemacht?
-- Benoetigt: SUM(SummeBestPosi)
-- View: vRechnungsDaten
SELECT DATEPART(YEAR, OrderDate) as GeschäftsJahr, SUM(SummeBestPosi) as GesamtUmsatz FROM vRechnungsDaten
GROUP BY DATEPART(YEAR, OrderDate)
ORDER BY GeschäftsJahr DESC

-- 2.  Wieviel Umsatz haben wir in Q1 1998 mit Kunden aus den USA gemacht?
SELECT  DATEPART(QUARTER, OrderDate) as Quartal, SUM(SummeBestPosi) as GesamtUmsatz FROM vRechnungsDaten
WHERE Country = 'USA' AND DATEPART(YEAR, OrderDate) = 1998 AND DATEPART(QUARTER, OrderDate) = 1
GROUP BY DATEPART(QUARTER, OrderDate)

SELECT  SUM(SummeBestPosi) as GesamtUmsatz FROM vRechnungsDaten
WHERE Country = 'USA' AND DATEPART(YEAR, OrderDate) = 1998 AND DATEPART(QUARTER, OrderDate) = 1
GO

-- Erstelle mir ein Bericht, der die Gesamtzahl der Bestellungen nach Kunde seit dem 31.Dezember 1996 anzeigt
-- Der Bericht soll nur Zeilen zurückgeben, wo die Gesamtzahl der Aufträge größer als 15 ist (5 Zeilen)
-- => in einer View gespeichert werden

CREATE VIEW vBericht AS
-- 1. CustomerID, die aufgezählten OrderId ausgeben
SELECT CustomerID, COUNT(OrderID) as Zahl FROM Orders
-- 2. Filtern nach 31. Dezember 1996
WHERE OrderDate > '31.12.1996'
-- 3. Gruppieren nach der CUstomerID
GROUP BY CustomerID
-- 4. Aggregierten Wert filtern (größer als 15)
HAVING COUNT(OrderID) > 15
-- BONUS: Sortieren 
-- 5. in eine View abspeichern
GO

SELECT * FROM vBericht