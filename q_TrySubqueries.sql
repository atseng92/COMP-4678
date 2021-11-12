USE CHINOOK;
GO

--Write a statement to return first invoice for each customer
SELECT I1.CustomerId
	,I1.InvoiceID
	,I1.InvoiceDate
FROM [Chinook].[dbo].[Invoice] AS I1
WHERE InvoiceDate IN (
		SELECT MIN(InvoiceDate)
		FROM [Chinook].[dbo].[Invoice] AS I2
		WHERE I2.CustomerId = I1.CustomerId
		)

--Now list all customers from Canada (using a subquery)
SELECT CustomerId
	,FirstName
	,LastName
FROM [Chinook].[dbo].[Customer]
WHERE Country = (
		SELECT Country
		FROM [Chinook].[dbo].[Customer]
		WHERE Country = N'Canada'
		GROUP BY Country
		)

--List all customers from Germany and include when it was invoiced first
SELECT I1.CustomerId
	,I1.InvoiceID
	,I1.InvoiceDate
FROM [Chinook].[dbo].[Invoice] AS I1
WHERE InvoiceDate IN (
		SELECT MIN(InvoiceDate)
		FROM [Chinook].[dbo].[Invoice] AS I2
		WHERE I2.CustomerId = I1.CustomerId
		)
	AND I1.CustomerId IN (
		SELECT CustomerID
		FROM [Chinook].[dbo].[Customer]
		WHERE Country = N'Germany'
		)