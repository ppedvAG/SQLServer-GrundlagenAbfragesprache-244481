USE Northwind

-- CREATE

-- Ich möchte eine Tabelle erstellen:

CREATE TABLE PurchasingOrders
(
	-- Spaltennamen [Datentyp], weitere Spezifikationen
	ID INT IDENTITY(1, 1) PRIMARY KEY,
	OrderDate DATE NOT NULL, -- => Spalte muss beim INSERT befüllt werden (pflicht!)
	ProductID INT NOT NULL
)

SELECT * FROM PurchasingOrders

-- Beziehung zwischen PurchasingOrders und Products anlegen über ProductID:
-- ALTER: Bearbeitungen an Tabellen durchführen
ALTER TABLE PurchasingOrders
ADD FOREIGN KEY (ProductID) REFERENCES Products (ProductID)

-- Mit ALTER auch Spalten hinzufügen
ALTER TABLE PurchasingOrders
ADD TestDaten FLOAT NULL

-- Spalten auch entfernen mit ALTER
ALTER TABLE PurchasingOrders
DROP COLUMN TestDaten

-- Möchte Spalte nach Datentyp ändern
ALTER TABLE PurchasingOrders
ALTER COLUMN TestDaten INT NULL


-- INSERT - Hinzufügen von Datensätzen in bestehnder Table

-- Alle Spalten befüllen
SELECT * FROM PurchasingOrders

INSERT INTO PurchasingOrders
VALUES('26.02.2025', 5, 5.99)

-- Explizite Spalten befüllen
INSERT INTO PurchasingOrders (OrderDate, ProductID)
VALUES (GETDATE(), 10)

-- Ergebnis einer SELECT-Abfrage direkt Inserten
-- (Wenn Spaltenanzahl passt & die Datentypen kompatibel sind
INSERT INTO PurchasingOrders
SELECT GETDATE(), 3, 20

-- DELETE - Löschen von Datensätzen in einem Bestehendem Table

-- AUfpassen! Ohne Where-filter wird alles gelöscht
DELETE FROM PurchasingOrders
WHERE ID = 14

-- Primär-/Fremdschlüsselbeziehungen verhinder das löschen von Datensätzen, wenn andere Datensätze
-- sonst "ins Leere laufen würden"
DELETE FROM Customers
WHERE CustomerID = 'ALFKI'

-- UPDATE - Ändern von Werten in einem vorhandenen Datensatz

SELECT * FROM PurchasingOrders

UPDATE PurchasingOrders
SET TestDaten = 8
WHERE ID = 17

-- "Löschen" von Werten: SET = NULL
UPDATE PurchasingOrders
SET TestDaten = NULL

--Trage dich selber in die Tabelle ein (Employees). Bei den folgenden Spalten: 
--LastName, FirstName, Title, TitleOfCourtesy, BirthDate, 
--HireDate, City, Region, PostalCode, Country, HomePhone, ReportsTo
INSERT INTO Employees
(LastName, FirstName, Title, TitleOfCourtesy, BirthDate,
HireDate, City, Region, PostalCode, Country, HomePhone, ReportsTo)
VALUES ('Libowicz', 'Philipp', 'IT-Trainer', 'Mr.', '13.02.2005', '01.09.2023',
'Burghausen', 'Bayern', '84489', 'Deutschland', '--', 2)

SELECT * FROM Employees

-- Transactions

SELECT * FROM PurchasingOrders

BEGIN TRANSACTION

UPDATE PurchasingOrders
SET TestDaten = 5

COMMIT		--> Führt aus
ROLLBACK	--> Zurücksetzen
