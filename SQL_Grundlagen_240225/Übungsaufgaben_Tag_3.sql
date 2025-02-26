-- 1. Gab es Bestellungen (OrderID) an Wochenendtagen (OrderDate)?
SELECT OrderID from Orders
WHERE DATEPART(WEEKDAY, OrderDate) IN (6 ,7)

-- 2. Alle Contactnames die als Title "Owner" haben (Tabelle Customers)
SELECT ContactName, ContactTitle FROM Customers
WHERE ContactTitle LIKE '%Owner%'

-- 3. Den Gesamtumsatz pro Kategorie und Land berechnen (5 Tabellen)
SELECT DISTINCT CategoryName, Country, SUM([Order Details].UnitPrice * Quantity) AS Gesamt
FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON Products.ProductID = [Order Details].ProductID
JOIN Categories ON Categories.CategoryID = Products.CategoryID
JOIN Customers ON Customers.CustomerID = Orders.CustomerID
GROUP BY CategoryName, Country
ORDER BY Gesamt DESC

-- 4. Neuen Datensatz in Orders einfügen
-- (CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName,
-- ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
-- Info: RequiredDate soll +7 Tage vom OrderDate sein
-- & ShippedDate muss +3 Tage vom OrderDate sein
-- OrderDate = aktuelles Datum
INSERT INTO Orders(CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName,
ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES('ALFKI', 5, GETDATE(), DATEADD(DAY, 7, GETDATE()), DATEADD(DAY, 3, GETDATE()), 3, 50.00, 'Alfredi Dedidi', 'Beispiel Str', 'Berlin', NULL, '84489', 'Germany')