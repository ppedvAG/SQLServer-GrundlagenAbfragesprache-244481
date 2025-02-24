-- 1. Alle Bestellungen (Orders) bei denen ein Produkt 
-- verkauft wurde, das nicht mehr gefuehrt wird
-- (Discontinued = 1 in Products)
SELECT * FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
WHERE Discontinued = 1

-- 2. Alle Produkte der Category "Beverages" (Tabelle Categories)
SELECT * FROM Products
JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE CategoryName = 'Beverages'

-- 3. Haben wir Produkteinheiten im Lager (UnitsInStock), die aber nicht
-- mehr verkauft werden (Discontinued)? Wenn ja, wieviel "Geld" liegt dort im Lager?
-- Rechnung: UnitsInStock * UnitPrice
SELECT ProductName, UnitsInStock * UnitPrice as Rechnungs FROM Products
WHERE Discontinued = 1 AND UnitsInStock != 0
Order BY Rechnungs
