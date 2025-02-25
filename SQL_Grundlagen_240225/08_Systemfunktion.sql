USE Northwind
GO


-- 1. String Funktionen bzw Text-Datentyp manipulation

-- LEN gibt die länge des Strings zurück (Anzahl Symbole) als Zahl zurück (int)
SELECT CompanyName, LEN(CompanyName) FROM Customers

-- LEFT/RIGHT geben die "linken" oder "rechten" x Zeichen eines Strings zurück
SELECT CompanyName, LEFT(CompanyName, 5) FROM Customers
SELECT CompanyName, RIGHT(CompanyName, 5) FROM Customers

-- SUBSTRING(Spalte, x, y) springt zur Position x in einem String und gibt y Zeichen zurück
SELECT SUBSTRING(CompanyName, 5, 5), CompanyName FROM Customers

-- STUFF(Spalte, x, y, replace) ersetzt y Zeichen eins Strings ab Position x
-- "mit dem replace Wert" (optional)
SELECT STUFF(Phone, LEN(Phone) - 4, 5, 'XXXXX') FROM Customers

-- PATINDEX sucht nach "Schema" (wie LIKE) in einem String und gibt die Position aus,
-- an der das Schema das erste mal gefunden wurde
SELECT PATINDEX('%m%', CompanyName), CompanyName FROM Customers

-- CONCAT fügt mehrere Strings in die selbe Spalte ein
SELECT CONCAT(FirstName, ' ', LastName) as GanzerName FROM Employees
SELECT FirstName + ' ' + LastName as GanzerName FROM Employees

-- 2. Datumsfunktionen

-- aktuelle Systemzeit mit Zeitstempel
SELECT GETDATE()
SELECT CURRENT_TIMESTAMP

-- Ein gewünschtes Zeitintervall aus einem Datum ziehen

-- Option 1:
SELECT
YEAR(OrderDate) as Jahr,
MONTH(OrderDate) as Monat,
DAY(OrderDate) as Tag,
OrderDate
FROm Orders

-- Option 2:
SELECT
DATEPART(YEAR, OrderDate) as Jahr,
DATEPART(QUARTER, OrderDate) as Quartal,
DATEPART(WEEK, OrderDate) as KW,
DATEPART(WEEKDAY, OrderDate) as Wochentag,
DATEPART(HOUR, OrderDate) as Stunde
FROM Orders


-- Intervall Namen aus einem Datum ziehen
SELECT DATENAME(MONTH, OrderDate), DATENAME(WEEKDAY, OrderDate),
DATEPART(WEEKDAY, OrderDate), OrderDate FROM Orders

-- Datum addieren oder subtrahieren
SELECT DATEADD(DAY, 14, GETDATE())
SELECT DATEADD(DAY, -14, GETDATE())

-- Differenz zwischen zwei Datums berechnen
SELECT DATEDIFF(YEAR, '20050213', GETDATE())
SELECT DATEDIFF(YEAR, OrderDate, GETDATE()), OrderDate FROM Orders


-- 3. Formatierungs/Typumwandlungsfunktionen
