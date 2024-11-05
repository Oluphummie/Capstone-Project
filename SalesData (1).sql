--Overview of the sales table
SELECT 
	*
FROM dbo.['LITA Capstone Dataset salesdata$']

--Total sales by product Category
SELECT 
	Product,
	SUM (Quantity*UnitPrice) AS "Total Sales"
FROM 
	dbo.['LITA Capstone Dataset salesdata$']
GROUP BY
	Product

	--Number of Sales Transaction by Region
SELECT
	Region,
	COUNT(OrderID) AS "Number of Sales Transaction"
FROM
	dbo.['LITA Capstone Dataset salesdata$']
GROUP BY
	Region

SELECT
	Top 1
	Product,
	SUM(Quantity*UnitPrice) AS TotalSales
FROM
	dbo.['LITA Capstone Dataset salesdata$']
GROUP BY
	Product
ORDER BY 
    TotalSales DESC

--Total Revenue by Product
SELECT 
	Product,
	SUM (Quantity*UnitPrice) AS "Total Revenue"
FROM 
	dbo.['LITA Capstone Dataset salesdata$']
GROUP BY
	Product

SELECT 
    DATENAME(month, OrderDate) AS MonthName,
    COUNT(*) AS OrderCount
FROM 
    dbo.['LITA Capstone Dataset salesdata$']
GROUP BY 
    DATENAME(month, OrderDate);

--Monthly Total Sales for the Current Year
SELECT 
    DATENAME(month, OrderDate) AS MonthName,
    MONTH(OrderDate) AS MonthNumber,
    SUM(Quantity*UnitPrice) AS MonthlyTotal
FROM 
    dbo.['LITA Capstone Dataset salesdata$']
WHERE 
    YEAR(OrderDate) = 2024
GROUP BY 
    DATENAME(month, OrderDate),
    MONTH(OrderDate)
ORDER BY 
    MonthNumber;

--Top 5 customers by total purchase amount
SELECT TOP 5 
    "Customer Id",
    SUM(Quantity*UnitPrice) AS TotalPurchaseAmount
FROM 
    dbo.['LITA Capstone Dataset salesdata$']
GROUP BY 
    "Customer Id"
ORDER BY 
    TotalPurchaseAmount DESC;

-- calculate the percentage of total sales contributed by each region. 
SELECT 
    Region,
    SUM(Quantity*UnitPrice) AS RegionalSales,
    ROUND((SUM(Quantity*UnitPrice) * 100.0) / (SELECT SUM(Quantity*UnitPrice) 
FROM dbo.['LITA Capstone Dataset salesdata$']), 2) AS PercentageOfTotalSales
FROM 
    dbo.['LITA Capstone Dataset salesdata$']
GROUP BY 
    Region
ORDER BY 
    PercentageOfTotalSales DESC;

--Products with no sales in the last quarter. 
-- Calculate the start and end dates for the last quarter
DECLARE @StartDate DATE = DATEADD(qq, DATEDIFF(qq, 0, GETDATE()) - 1, 0);
DECLARE @EndDate DATE = DATEADD(qq, DATEDIFF(qq, 0, GETDATE()), 0);

-- Find products with no sales in the last quarter
SELECT 
    Product
FROM 
    SalesData
GROUP BY 
    Product
HAVING 
    SUM(CASE WHEN OrderDate >= @StartDate AND OrderDate < @EndDate THEN 1 ELSE 0 END) = 0;

