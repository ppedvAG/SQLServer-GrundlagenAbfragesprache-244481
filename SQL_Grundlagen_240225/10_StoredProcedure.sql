USE Northwind
GO

-- Stored Procedures / gespeicherte Prozeduren

CREATE PROCEDURE spOrderId @OrderId INT
as
SELECT * FROM Orders
WHERE OrderId = @OrderId
GO

-- Prozedur aufrufen? --> execute 
EXEC spOrderId 10248
GO

CREATE PROCEDURE spProductId @ProductId INT
as
SELECT * FROM Products
WHERE ProductID = @ProductId
GO

EXEC spProductId 20
GO


-- INSERT in der Prozedur
CREATE PROCEDURE spNewCustomer
@CustomerID char(5), @CompanyName varchar(40),
@Country VARCHAR(30), @City VARCHAR(30)
AS
INSERT INTO Customers (CustomerID, CompanyName, Country, City)
VALUES (@CustomerID, @CompanyName, @Country, @City)
GO

EXEC spNewCustomer 'ALDIS', 'PPEDV AG', 'Germany', 'Burghausen'
EXEC spNewCustomer ALDII, 'PPEDV AG', Germany, Burghausen


SELECT * FROM Customers
GO

-- Default Werte
CREATE PROCEDURE spKundeLC 
@Country varchar(50) = 'Germany', @City varchar(50) = 'Berlin'
AS
SELECT * FROM Customers
WHERE Country = @Country AND City = @City
GO

EXEC spKundeLC