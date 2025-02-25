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
