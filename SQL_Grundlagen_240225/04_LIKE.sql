USE Northwind
GO

-- LIKE: F�r ungenaue Filterung/Suche k�nnen wir Like verwenden
-- (statt Vergleichsoperatoren)

-- "%"-Zeichen: Beliebige Symbole, beliebig viele davon
SELECT ContactName, ContactTitle FROM Customers
WHERE ContactTitle LIKE '%Manager%'

-- "_"-Zeichen: EIN beliebiges Symbol
SELECT CompanyName FROM Customers
WHERE CompanyName LIKE '_l%'

-- "[]"-Zeichen: Alles was in den Klammern steht ist ein g�ltiges Symbol
SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[012346]%'

-- "[a-z]" oder Gegenteil mit ^ [^a-z]
SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[0-3]%'

SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[^0-3]%'

SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[0-3 a-g]%'

-- Sonderf�lle: % '
SELECT * FROM Customers
WHERE CompanyName LIKE '%[%]%'

SELECT * FROM Customers
WHERE CompanyName LIKE '%['']%'

-- �bung:
-- 1. Alle ShipPostalCode's anzeigen lassen, die mit 0,2,4 beginnen
SELECT * FROM Orders
WHERE ShipPostalCode like '[024]%'