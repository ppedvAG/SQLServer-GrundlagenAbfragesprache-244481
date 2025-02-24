USE Northwind
GO

/*
	JOIN SYNTAX:

	SELECT * FROM [A]
	INNER JOIN [B] ON [A].KeySpalte = [B].KeySpalte
*/

-- Verknüpfung zwischen Orders und Customers
SELECT Orders.CustomerID, Customers.* FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID


-- JOIN zwischen Customers - Orders - Order Details
SELECT * FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
WHERE Country = 'Germany'


-- das gleiche als Alias
SELECT * FROM Customers as cus
INNER JOIN Orders as o ON cus.CustomerID = o.CustomerID
INNER JOIN [Order Details] as od ON o.OrderID = od.OrderID

-- Übungen:
-- 1. Welche Produkte (ProductName) hat "Leverling" bisher verkauft?
-- Tabellen: Employees - Orders - [Order Details] - Products
SELECT DISTINCT ProductName, LastName FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE LastName = 'Leverling'

-- 2. Wieviele Bestellungen haben Kunden aus Argentinien aufgegeben? (Anzahl OrderIDs bzw.
-- Anzahl Ergebniszeilen)
-- Tabellen: Customers - Orders
SELECT OrderID FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'Argentina'


-- 3. Was war die größte Bestellmenge (Quantity) von Chai Tee (ProductName = 'Chai')?
-- Tabellen: [Order Details] - Products
SELECT TOP 1 ProductName, Quantity FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
WHERE ProductName = 'Chai'
ORDER BY Quantity DESC

-- 4. Alle Produkte (ProductNames) aus den Kategorien "Beverages" und "Produce"
-- (CategoryName in Categories)
SELECT * FROM Products
JOIN Categories ON Categories.CategoryID = Products.CategoryID
WHERE CategoryName IN ('Beverages', 'Produce')

-- OUTER JOINS

-- LEFT
-- Alle Datensätze aus der Linken Tabelle haben, auch wenn es keine passenden Verknüpfungen gibt
SELECT * FROM Orders as o
LEFT JOIN Customers as cus ON o.CustomerID = cus.CustomerID
-- Haben wir Bestellungen, wo kein Kunde hinterlegt ist?

-- RIGHT: Z. 189 & Z.502
-- Alle Datensätze aus der Rechten Tabelle haben, auch wenn es keine passenden Verknüpfungen gibt
SELECT * FROM Orders as o
RIGHT JOIN Customers as cus ON o.CustomerID = cus.CustomerID
-- Haben wir Kunden, die nicht bestellt haben

-- FULL OUTER
SELECT * FROM Orders as o
FULL OUTER JOIN Customers as cus ON o.CustomerID = cus.CustomerID


-- JOIN "invertieren", d.h keine Schnittmenge anzeigen, durch filtern nach NULL:
SELECT * FROM Orders as o
FULL OUTER JOIN Customers as cus ON o.CustomerID = cus.CustomerID
WHERE o.CustomerID IS NULL OR cus.CustomerID IS NULL

-- CROSS JOIN: Erstellt ein karthesisches Produkt zweier Tabellen (A x B) (830 x 91)
SELECT * FROM Orders CROSS JOIN Customers

-- SELF JOIN
SELECT E1.EmployeeID, E1.LastName as Vorgesetzter, E2.EmployeeID, E2.LastName as Angestellter
FROM Employees as E1
JOIN Employees as E2 ON E1.EmployeeID = E2.ReportsTo