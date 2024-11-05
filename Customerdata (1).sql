--Number of Customer by region
SELECT 
    Region,
    COUNT(DISTINCT CustomerID) AS TotalCustomers
FROM 
    dbo.customerdata
GROUP BY 
    Region;

--The most common type of Subscription type by customer count
SELECT TOP 1
    SubscriptionType,
    COUNT(DISTINCT CustomerID) AS CustomerCount
FROM 
    dbo.customerdata
GROUP BY 
    SubscriptionType
ORDER BY 
    CustomerCount DESC;

--Customer who cancelled their subscription within 6 Months
SELECT 
    CustomerID,
    SubscriptionStart,
    SubscriptionEnd
FROM 
    dbo.customerdata
WHERE 
    Canceled = 'TRUE'
    AND DATEDIFF(month, SubscriptionStart, SubscriptionEnd) <= 6;

--Average subscription duration for all customers
SELECT 
    AVG(DATEDIFF(MONTH, SubscriptionStart, SubscriptionEnd)) 
	AS AverageSubscriptionDurationInDays
FROM 
    dbo.customerdata

SELECT 
    AVG(DATEDIFF(day, SubscriptionStart, SubscriptionEnd)) AS AverageSubscriptionDurationInDays
FROM 
    Subscriptions;

--Customer with subscrition loger than 12 months
SELECT 
    CustomerID,
    SubscriptionStart,
    SubscriptionEnd,
    DATEDIFF(month, SubscriptionStart, SubscriptionEnd) AS SubscriptionDurationInMonths
FROM 
    dbo.customerdata
WHERE 
    DATEDIFF(month, SubscriptionStart, SubscriptionEnd) > 12;

--Total revenue by subscription type
SELECT 
    SubscriptionType,
    SUM(Revenue) AS TotalRevenue
FROM 
    dbo.customerdata
GROUP BY 
    SubscriptionType
ORDER BY 
    TotalRevenue DESC;

	--Top 3 regions by subcription cancellation
SELECT TOP 3
    Region,
    COUNT(DISTINCT CustomerID) AS CancellationCount
FROM 
    dbo.customerdata
WHERE 
    Canceled = 'TRUE'
GROUP BY 
    Region
ORDER BY 
    CancellationCount DESC;

--Total number of active and canceled subscriptions. 
SELECT 
    CASE 
        WHEN Canceled = 'TRUE' THEN 'Canceled'
        WHEN Canceled = 'FALSE' THEN 'Active'
    END AS SubscriptionStatus,
    COUNT(DISTINCT CustomerId) AS TotalCount
FROM 
    dbo.customerdata
GROUP BY 
    Canceled;