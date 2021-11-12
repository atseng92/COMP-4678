USE CHINOOK;
GO

--Get a list of all orders by country (from Invoices table) with total amount (in descending order), include a ROW_NUMBER function
SELECT ROW_NUMBER() OVER (
		PARTITION BY BillingCountry ORDER BY Total DESC
		) AS RowNum
	,InvoiceId
	,BillingCountry
	,Total
FROM dbo.Invoice

--Use above query to get three largest orders for each country.
SELECT RowNum
	,InvoiceId
	,BillingCountry
	,Total
FROM (
	SELECT ROW_NUMBER() OVER (
			PARTITION BY BillingCountry ORDER BY Total DESC
			) AS RowNum
		,InvoiceId
		,BillingCountry
		,Total
	FROM dbo.Invoice
	) AS SQ
WHERE ROWNUM <= 3

--Use the second one and modify it to use a CTE instead of nested query
WITH CTE_SQ AS (
		SELECT ROW_NUMBER() OVER (
				PARTITION BY BillingCountry ORDER BY Total DESC
				) AS RowNum
			,InvoiceId
			,BillingCountry
			,Total
		FROM dbo.Invoice
		)

SELECT RowNum
	,InvoiceId
	,BillingCountry
	,Total
FROM CTE_SQ
WHERE ROWNUM <= 3