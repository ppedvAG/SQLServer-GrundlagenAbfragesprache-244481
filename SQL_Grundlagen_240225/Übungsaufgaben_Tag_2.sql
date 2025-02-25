USE Northwind
go

-- 1. Verkaufte Stueckzahlen (Quantity) pro ProduktKategorie (CategoryName) (8 Ergebniszeilen)
-- Categories - Order Details - Products
SELECT CategoryName, SUM(Quantity) FROM [Order Details]
join Products ON Products.ProductID = [Order Details].ProductId
JOIN Categories ON Categories.CategoryID = Products.CategoryID
GROUP BY CategoryName

-- 2. Wieviele Bestellungen hat jeder Mitarbeiter bearbeitet? (9 Ergebniszeilen)
SELECT LastName, COUNT(OrderID) as Bestellungen FROM Employees
JOIN Orders on Orders.EmployeeID = Employees.EmployeeID
GROUP BY LastName
ORDER BY Bestellungen DESC

-- 3. In welcher Stadt (City) waren „Wimmers gute Semmelknödel“ am beliebtesten (Quantity)?
SELECT TOP 1 ShipCity, SUM(Quantity) as Verkaufsmenge FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
WHERE ProductName = 'Wimmers gute Semmelknödel'
GROUP BY ShipCity
Order BY Verkaufsmenge DESC

-- Auch richtig
-- 3. In welcher Stadt (City) waren „Wimmers gute Semmelknödel“ am beliebtesten (Quantity)?
SELECT TOP 1 City, SUM(Quantity) as Verkaufsmenge FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
JOIN Customers ON Customers.CustomerID = Orders.CustomerID
WHERE ProductName = 'Wimmers gute Semmelknödel'
GROUP BY City
Order BY Verkaufsmenge DESC

-- 4. Welcher Spediteur (Shippers) war durchschnittlich am günstigsten? (Freight)
SELECT CompanyName, AVG(Freight) AS AvgFreight FROM Orders
JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
GROUP BY CompanyName
ORDER BY AvgFreight


-- Datumsfunktionen:

-- Übungen:
-- 1. Alle Bestellungen (Orders) aus Q2 in 1997
SELECT * FROM Orders 
WHERE DATEPART(YEAR, OrderDate) = 1997 AND DATEPART(QUARTER, OrderDate) = 2

-- 2. Alle Produkte (ProductName) die um Weihnachten herum (+-10 Tage) in
-- 1996 verkauft wurden 
SELECT ProductName FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
WHERE OrderDate BETWEEN '14.12.1996' AND '03.01.1997'

-- 3. Alle Bestellungen (Orders) aus den USA (Customers Country) die im Jahr 1997 aufgegeben wurden
-- (OrderDate in Orders) 'YYYYMMDD'
SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'USA' AND OrderDate BETWEEN '01.01.1997' AND '31.12.1997'

SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'USA' AND DATEPART(YEAR, OrderDate) = 1997

-- 4. Welches Produkt (ProductName) hatte die groeßte Bestellmenge (Quantity in OD) im Februar 1998?
SELECT TOP 1 ProductName FROM Products
JOIN [Order Details] ON [Order Details].ProductID = Products.ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
WHERE DATEPART(YEAR, OrderDate) = 1998 AND DATEPART(MONTH, OrderDate) = 2
ORDER BY Quantity DESC

-- 5. Wieviele Bestellungen kamen aus Spain (Customers) in Quartal 2 1997?
--   Sind es mehr oder weniger als aus Frankreich? (2. Abfrage)
SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'Spain' AND DATEPART(QUARTER, OrderDate) = 2
AND DATEPART(YEAR, OrderDate) = 1997
UNION ALL
SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'France' AND DATEPART(QUARTER, OrderDate) = 2
AND DATEPART(YEAR, OrderDate) = 1997

-- Hatten wir Bestellungen, die wir zu spaet ausgeliefert haben? Wenn 
-- ja, welche OrderIDs waren das und wieviele Tage
-- waren wir zu spaet dran? (Verzoegerung = Unterschied zwischen Shipped 
-- & Required Date in Orders) Tipp: DATEDIFF & ISNULL
-- ISNULL prueft auf Null Werte und ersetzt diese wenn gewuenscht
-- SELECT ISNULL(Fax, 'Nicht vorhanden!') as KeineFax, Fax FROM Customers
/* 37
OrderID, "TageZuSpaet"
OrderID, "TageZuSpaet"
OrderID, "TageZuSpaet"
usw...
*/

SELECT * FROM Orders

--„Zensiere“ alle Telefonnummern der Kunden (Phone): 
--Es sollen immer nur noch die letzten 4 Ziffern/Symbole angezeigt werden. 
--Alles davor soll mit einem X pro Symbol ersetzt werden.
--Beispiel: Phone „08677 9889 0“; danach „XXXXXXXX89 0“
