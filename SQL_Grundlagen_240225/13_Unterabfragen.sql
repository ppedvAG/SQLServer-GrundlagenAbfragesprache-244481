USE Northwind
GO


-- Subqueries / Unterabfragen / nested queries

-- Zeige mir alle Ordes an, deren Freight Wert über dem Durchschnitt liegt
-- Geht nicht: Nur mit Unterabfrage
SELECT OrderID, AVG(Freight) FROm Orders
GROUP BY OrderID
HAVING Freight > AVG(Freight)

-- Richtig!
SELECT * FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders) -- 78,2442

-- Produktliste mir ausgeben lassen (ID, ProductName, UnitPrice), die sollen einen überdurchschnittlichen Wert haben
SELECT ProductID, ProductName, UnitPrice FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)
