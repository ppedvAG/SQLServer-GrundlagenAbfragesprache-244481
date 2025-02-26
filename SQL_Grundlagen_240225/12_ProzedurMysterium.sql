-- Versuch Nr.1
-- Eine beliebe Variable mit Varchar(20) => Default Value muss H?HER SEIN!
-- @CustomerID = char(5), @CompanyName von varchar(40)
-- @Country varchar(20), @City = varchar(30)
-- Default Wert ben?tigt!!!, Country Default Wert muss die 20 Zeichenketten ?berschreiben
CREATE Procedure spTest_1
@CustomerID CHAR(5) = '12345', @CompanyName VARCHAR(40) = 'TestUnternehmen',
@Country VARCHAR(20) = 'GermanyGermanyGermanyGermany', @City VARCHAR(30) = 'Berlin'
AS
INSERT INTO Customers (CustomerID, CompanyName, Country, City)
VALUES (@CustomerID, @CompanyName, @Country, @City)
GO

EXEC spTest_1 

SELECT * FROM Customers
GO

-- Versuch Nr.2
-- Keine Defaultwerte:
-- @CustomerID = char(5), @CompanyName von varchar 40
-- @Country varchar(20), @City = varchar(30)
-- Beim Exec muss der WERT größer sein als der Datentyp es zulässt
CREATE Procedure spTest_2
@CustomerID CHAR(5), @CompanyName VARCHAR(40),
@Country VARCHAR(20), @City VARCHAR(30)
AS
INSERT INTO Customers (CustomerID, CompanyName, Country, City)
VALUES (@CustomerID, @CompanyName, @Country, @City)
GO

EXEC spTest_2 12345, TestUnternehmen, GermanyGermanyGermanyGermany, Berlin

SELECT * FROM Customers
GO

-- Versuch Nr.3
-- Keine Defaultwerte:
-- @CustomerID = char(5), @CompanyName von varchar 40
-- @Country varchar(10), @City = varchar(30)
-- Beim Exec muss der WERT größer sein als der Datentyp es zulässt
CREATE Procedure spTest_3
@CustomerID CHAR(5), @CompanyName VARCHAR(40),
@Country VARCHAR(10), @City VARCHAR(30)
AS
INSERT INTO Customers (CustomerID, CompanyName, Country, City)
VALUES (@CustomerID, @CompanyName, @Country, @City)
GO

EXEC spTest_3 12345, TestUnternehmen, GermanyGermanyGermanyGermany, Berlin

SELECT * FROM Customers
GO
-- Versuch Nr.4
-- Defaultwerte:
-- @CustomerID = char(5), @CompanyName von varchar 40
-- @Country varchar(10), @City = varchar(30)
-- Beim Exec muss der WERT größer sein als der Datentyp es zulässt
CREATE Procedure spTest_4
@CustomerID CHAR(5) = 'ABCDE', @CompanyName VARCHAR(40) = 'TestUnternehmen',
@Country VARCHAR(10) = 'GermanyGermanyGermanyGermany', @City VARCHAR(30) = 'Berlin'
AS
INSERT INTO Customers (CustomerID, CompanyName, Country, City)
VALUES (@CustomerID, @CompanyName, @Country, @City)
GO

EXEC spTest_4
