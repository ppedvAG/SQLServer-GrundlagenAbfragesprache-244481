USE Northwind
GO


-- 1. String Funktionen bzw Text-Datentyp manipulation

-- LEN gibt die l‰nge des Strings zur¸ck (Anzahl Symbole) als Zahl zur¸ck (int)
SELECT CompanyName, LEN(CompanyName) FROM Customers

-- LEFT/RIGHT geben die "linken" oder "rechten" x Zeichen eines Strings zur¸ck
SELECT CompanyName, LEFT(CompanyName, 5) FROM Customers
SELECT CompanyName, RIGHT(CompanyName, 5) FROM Customers

-- SUBSTRING(Spalte, x, y) springt zur Position x in einem String und gibt y Zeichen zur¸ck
SELECT SUBSTRING(CompanyName, 5, 5), CompanyName FROM Customers

-- STUFF(Spalte, x, y, replace) ersetzt y Zeichen eins Strings ab Position x
-- "mit dem replace Wert" (optional)
SELECT STUFF(Phone, LEN(Phone) - 4, 5, 'XXXXX') FROM Customers

-- PATINDEX sucht nach "Schema" (wie LIKE) in einem String und gibt die Position aus,
-- an der das Schema das erste mal gefunden wurde
SELECT PATINDEX('%m%', CompanyName), CompanyName FROM Customers

-- CONCAT f¸gt mehrere Strings in die selbe Spalte ein
SELECT CONCAT(FirstName, ' ', LastName) as GanzerName FROM Employees
SELECT FirstName + ' ' + LastName as GanzerName FROM Employees

-- 2. Datumsfunktionen

-- aktuelle Systemzeit mit Zeitstempel
SELECT GETDATE()
SELECT CURRENT_TIMESTAMP

-- Ein gew¸nschtes Zeitintervall aus einem Datum ziehen

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

-- CAST oder CONVERT, wandeln Datentypen in der Ausgabe um
-- konvertierung von datetime --> date
SELECT CAST(OrderDate as date) FROM Orders
SELECT CONVERT(date, OrderDate) FROM Orders

-- ISNULL pr¸ft auf NULL Werte und ersetzt wenn gew¸nscht
SELECT ISNULL(Fax, 'Nicht vorhanden') as KeineFax, Fax FROM Customers

-- Format:
-- Datumskonvertierungen:
SELECT FORMAT((SELECT CONVERT(date, '20050213')), 'D', 'de-de')

-- Datum
DECLARE @d AS DATE = '08/09/2024';
SELECT FORMAT(@d, 'd', 'en-US') AS 'US English',
       FORMAT(@d, 'd', 'en-gb') AS 'British English',
       FORMAT(@d, 'd', 'de-de') AS 'German',
       FORMAT(@d, 'd', 'zh-cn') AS 'Chinese Simplified (PRC)';

SELECT FORMAT(@d, 'D', 'en-US') AS 'US English',
       FORMAT(@d, 'D', 'en-gb') AS 'British English',
       FORMAT(@d, 'D', 'de-de') AS 'German',
       FORMAT(@d, 'D', 'zh-cn') AS 'Chinese Simplified (PRC)';

-- W‰hrung
SELECT TOP (5) Freight,
               FORMAT(Freight, 'N', 'en-us') AS 'Numeric Format',
               FORMAT(Freight, 'G', 'en-us') AS 'General Format',
               FORMAT(Freight, 'C', 'en-us') AS 'Currency Format',
			   FORMAT(Freight, 'C', 'de-de') AS 'German Currency'
FROM Orders

-- REPLACE(x, y, z) => "y" sucht in "x" den String um Ihn mit "z" zu ersetzen
SELECT REPLACE('Hallo Welt!', 'Welt!', 'und Willkommen!')

-- REPLICATE(x, y) => Setze "y" mal die "x" vor der Spalte
SELECT REPLICATE('0', 3) + Phone FROM Customers
SELECT '000' + Phone FROM Customers

-- Reverse(Spaltennamen) => Gibt den Inhalt als r¸ckw‰rts schreibweise aus
SELECT CompanyName, REVERSE(CompanyName) FROM Customers

-- UPPER/LOWER (SPALTENNAME) => alles in Groﬂ- / Kleinbuchstaben
SELECT CompanyName, UPPER(CompanyName) FROM Customers
SELECT CompanyName, LOWER(CompanyName) FROM Customers
