USE Northwind
GO

/*
	Temporäre Tabellen / Temp Tables / #Tables

	- SELECT INTO #TableNamen => Ergebnisse werden in eine Temporäre Tabelle geschrieben
	- existiert nur innerhalb meiner Session (Skriptfenster / Query)
	- werden in SystemDB => tempdb angelegt
	- Ergebnisse werden nur einmal generiert --> TempTables sehr schnell aber nicht aktuell von den Daten
	- mit einem # = "lokal"
	- mit zwei ## = "global"

*/

-- Erstellen
SELECT * INTO #TempTable
FROM Customers
WHERE Country = 'Germany'

-- Aufrufen
SELECT * FROM ##TempTable

-- manuell löschen
DROP TABLE #TempTable

-- Erstellen einer globalen TempTable
SELECT * INTO ##TempTable
FROM Customers
WHERE Country = 'Germany'