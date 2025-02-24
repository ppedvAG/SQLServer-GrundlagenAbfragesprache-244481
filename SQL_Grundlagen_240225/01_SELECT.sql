-- Zwei Methoden: 1. USE Datenbankname oder per 2. Dropdown-Menü oben links
USE Northwind
GO

/*
	SELECT [Spalten] FROM [Tabelle]
*/

SELECT CompanyName, Country FROM Customers

SELECT [CustomerID] FROM Customers

-- SQL ist NICHT CASE-SENSITIVE
SelEct				CouNtRy,
			ComPanYnAmE
FrOm						Customers

-- Holt mir alle Spalten aus der Tabelle Customers
Select * from Customers

-- "Custom"-Werte und mathematische Operationen

SELECT 100

SELECT 10 * 5

SELECT 'Hallo', 5, 'Was geht', 10 * 8

-- Duplikate "filtern" mit SELECT DISTINCT
-- Filtert alle Ergebnisse/Datensätze deren Werte exakt gleich sind

SELECT Country FROM Customers

SELECT DISTINCT Country FROM Customers

SELECT DISTINCT * FROM Customers

-- Aliase => Spalten umbennen über "as"
SELECT 100 as Zahl, 'Hallo' as Begrüßung

SELECT Country as Land, City as Stadt FROM Customers 

-- Aliase können auch für Tabellennamen vergeben werden
SELECT * FROM Customers as cus

-- Order by: Sortiert Spalten
/*
	SELECT [Spalten] FROM [Tabelle]
	ORDER BY [Spalte] [Sortiermethode]
*/

-- Aufsteigend
SELECT * FROM Customers
ORDER BY Country ASC

-- Absteigend
SELECT * FROM Customers
ORDER BY Country DESC

-- Order by ist syntaktisch immer am Ende
-- ASC = ASCENDING = aufsteigend (default)
-- DESC = DESCENDING = absteigend

-- Sortieren nach mehreren Spalten
SELECT * FROM Customers
ORDER BY City, CompanyName DESC

SELECT Country, City FROM Customers
ORDER BY City, Country DESC

-- Spaltenreihenfolge angeben (als Zahl)
SELECT CompanyName, Country, City FROM Customers
ORDER BY 1

-- TOP X gibt nur die ersten X Zeilen aus:
SELECT TOP 10 * FROM Customers

SELECT TOP 100 * FROM Customers -- gibt alles aus

-- Geht auch mit %-Angabe
-- TOP X Percent
SELECT TOP 10 PERCENT * FROM Customers

-- Übung:

-- 1. Die 20 größten Frachtkosten aus der Tabelle Orders
SELECT TOP 20 * FROM Orders
ORDER BY Freight ASC

-- 2. Die 20 größten Frachtkosten aus der Tabelle Orders
SELECT TOP 20 * FROM Orders
ORDER BY Freight DESC

/*
	WICHTIG!: "BOTTOM" X existiert nicht, Ergebnisse einfach umdrehen mit "ORDER BY"
*/

-- UNION führt mehrere Ergebnistabellen vertikal in eien Tabelle zusammen
-- UNION macht automatisch ein DISTINCT MIT
-- Spaltenanzahl muss gleich, Datentypen müssen gleich sein

SELECT * FROM Customers
UNION
SELECT * FROM Customers

-- mit UNION ALL wird KEIN DISTINCT ausgeführt
SELECT * FROM Customers
UNION ALL
SELECT * FROM Customers

SELECT 100, 'Hallo'
UNION
SELECT 'Welt!', 20

SELECT 100, 'Hallo'
UNION 
SELECT 20.00, 'Welt!'