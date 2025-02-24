USE Northwind
GO

-- WHERE: filtert Ergebniszeilen
SELECT * FROM Customers
WHERE Country = 'Germany'

-- = wird nach exakten Treffern gefiltert
SELECT * FROM Customers
WHERE Country = ' Germany'

-- alle Vergleichsoperatoren
-- (!= bzw <>, <, >, <=, >=)

-- Alle Frachtkosten holen, die größer als 500 sind
SELECT * FROM Orders
WHERE Freight > 500

-- Alle Kunden haben, die nicht aus Deutschland sind
SELECT * FROM Customers
WHERE Country != 'Germany'

-- Kombinieren von WHERE Ausdrücken mit AND oder OR
SELECT * FROM Customers
WHERE Country = 'Germany' AND City = 'Berlin'

SELECT * FROM Customers
WHERE Country = 'Germany' OR Country = 'Argentina'

-- AND = "Beide Bedingungen müssen "wahr" sein"
-- OR = Ein Ausdruck muss wahr sein
-- Können beliebig kombiniert werden

SELECT * FROM Customers
WHERE Country = 'Germany' AND (City = 'Berlin' OR City = 'Paris')
-- AND "ist stärker bindenter" als OR; Notfalls klammern setzen!

SELECT * FROM Orders
WHERE Freight >= 100 AND Freight <= 500

-- Alternativ mit BETWEEN, Randwerte mit dabei => kürzer
SELECT * FROM Orders
WHERE Freight BETWEEN 100 AND 500

SELECT * FROM Customers
WHERE Country = 'Brazil' OR Country = 'Germany' OR Country = 'France'

-- Alternative IN (Wert1, Wert2, usw)
SELECT * FROM Customers
WHERE Country IN ('Brazil', 'Germany', 'France')

-- IN verbindet mehrere OR Bedingungen, ABER diese beziehen sich alle auf die selbe Spalte

-- Übungen:
-- 1. Alle ContactNames die als Title "Owner" haben
SELECT * FROM Customers
WHERE ContactTitle = 'Owner'

-- 2. Alle Order Details die ProductID 43 bestellt haben
Select * FROM [Order Details]
WHERE ProductID = 43

-- 3. Alle Kunden aus Paris, Berlin, Madrid und Brazilien
SELECT * FROM Customers
WHERE City IN ('Paris', 'Berlin', 'Madrid') OR Country = 'Brazil'

-- 4. Alle Kunden haben, die keine Fax haben
SELECT * FROM Customers
WHERE Fax IS NULL

-- Umkehrfall
SELECT * FROM Customers
WHERE Fax IS NOT NULL

