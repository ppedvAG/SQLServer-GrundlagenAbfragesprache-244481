USE Northwind
GO

-- CASE - unterscheiden wir definierte Fälle, die die Ausgabe ändern:

-- Wenn ein Fall gefunden wird, dann passiert xyz, wenn nicht, dann ist das Ergebnis NULL
SELECT UnitsInStock,
CASE
	WHEN UnitsInStock < 10 THEN 'Nachbestellen'
	WHEN UnitsInStock >= 10 THEN 'Passt.'
END as Pruefung
FROM Products

-- Alternativ mit ELSE einen "Notausgang" 
SELECT UnitsInStock,
CASE
	WHEN UnitsInStock < 10 THEN 'Nachbestellen'
	WHEN UnitsInStock > 10 THEN 'Passt.'
	ELSE 'Kein Fall wurde angewendet'
END as Pruefung
FROM Products

-- Funktioniert auch mit Update
UPDATE Customers
SET City =
CASE
	WHEN Country = 'Germany' THEN 'Berlin'
	WHEN Country = 'France' THEN 'Paris'
	ELSE City
END

-- IM group by
SELECT SUM(UnitsInStock),
CASE
	WHEN UnitsInStock < 10 THEN 'Nachbestellen'
	WHEN UnitsInStock >= 10 THEN 'Passt.'
END as Pruefung
FROM Products
GROUP BY 
CASE
	WHEN UnitsInStock < 10 THEN 'Nachbestellen'
	WHEN UnitsInStock >= 10 THEN 'Passt.'
END

-- In der Orders Tabelle, das alle ShippedDate die NULL sind auf das heutige Datum gesetzt werden
-- CASE benutzen
SELECT OrderId, ShippedDate,
CASE 
	WHEN ShippedDate is null THEN GETDATE()
	ELSE ShippedDate
END as heute
FROM Orders


-- Aufgabe:
-- Wenn ShippedDate kleiner als RequiredDate => "Pünktlich versendet!"
-- Wenn ShippedDate gleich 0 ist => 'Noch nicht versendet'
-- Ansonsten: "Verspätet versendet"
SELECT OrderID, ShippedDate, CustomerID, OrderDate, RequiredDate,
CASE
	WHEN ShippedDate <= RequiredDate THEN 'Pünktlich versendet!'
	WHEN ShippedDate IS NULL THEN 'Noch nicht versendet!'
	ELSE 'Verspätet versendet!'
END as OrderStatus
FROM Orders