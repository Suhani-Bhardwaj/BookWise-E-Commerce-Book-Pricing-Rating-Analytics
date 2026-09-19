CREATE DATABASE bookwise_analytics;

USE bookwise_analytics; 

CREATE TABLE books (
    Title VARCHAR(255),
    Price DECIMAL(10,2),
    Rating VARCHAR(20),
    Availability VARCHAR(50),
    Link VARCHAR(500),
    Category VARCHAR(100),
    Description TEXT,
    UPC VARCHAR(50),
    Product_Type VARCHAR(50),
    Tax DECIMAL(10,2),
    Number_Available VARCHAR(50),
    Number_of_Reviews INT,
    Stock_Quantity INT,
    Rating_Category VARCHAR(20),
    Price_Band VARCHAR(20),
    Stock_Status VARCHAR(20),
    Title_Length INT,
    Description_Length INT,
    Description_Word_Count INT
); 

DESCRIBE books; 

USE bookwise_analytics;

# Database and Table Validation
# Before performing analysis, the SQL table is validated to confirm the number of records, available columns, duplicate records, and missing values.

SELECT COUNT(*) AS Total_Records
FROM books;  

SELECT *
FROM books
LIMIT 5; 

SELECT COUNT(*) AS Total_Columns
FROM information_schema.columns
WHERE table_schema = 'bookwise_analytics'
  AND table_name = 'books'; 
  
SELECT
    Title,
    Price,
    Rating,
    Category,
    Stock_Quantity,
    Rating_Category,
    Price_Band,
    Stock_Status
FROM books
LIMIT 10;

# Price Analysis
# This section analyzes book pricing using minimum, maximum, average, and total price values.

SELECT
    MIN(Price) AS Minimum_Price,
    MAX(Price) AS Maximum_Price,
    ROUND(AVG(Price), 2) AS Average_Price,
    ROUND(SUM(Price), 2) AS Total_Price
FROM books;       

# Rating Analysis
# This section analyzes the distribution of book ratings and identifies the average rating across the dataset. 

SELECT
    MIN(Rating) AS Minimum_Rating,
    MAX(Rating) AS Maximum_Rating,
    ROUND(AVG(Rating), 2) AS Average_Rating
FROM books;  

SELECT
    Rating,
    COUNT(*) AS Number_of_Books
FROM books
GROUP BY Rating
ORDER BY Rating;                


# Rating Category Analysis
# The predefined rating categories are analyzed to understand the proportion of Low, Average, and High rated books. 

SELECT
    Rating_Category,
    COUNT(*) AS Number_of_Books,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM books),
        2
    ) AS Percentage
FROM books
GROUP BY Rating_Category
ORDER BY Number_of_Books DESC; 


# Category Analysis
# This section examines the distribution of books across categories and identifies the categories with the highest number of books. 

SELECT
    Category,
    COUNT(*) AS Number_of_Books
FROM books
GROUP BY Category
ORDER BY Number_of_Books DESC; 

SELECT
    Category,
    COUNT(*) AS Number_of_Books
FROM books
GROUP BY Category
ORDER BY Number_of_Books DESC
LIMIT 10;     


# Category Pricing Analysis
# This section compares the average price of books across different categories.

SELECT
    Category,
    COUNT(*) AS Number_of_Books,
    ROUND(AVG(Price), 2) AS Average_Price,
    ROUND(MIN(Price), 2) AS Minimum_Price,
    ROUND(MAX(Price), 2) AS Maximum_Price
FROM books
GROUP BY Category
HAVING COUNT(*) >= 5
ORDER BY Average_Price DESC; 


# Stock Analysis
# This section analyzes book inventory levels and identifies categories and individual books with different stock availability.

SELECT
    MIN(Stock_Quantity) AS Minimum_Stock,
    MAX(Stock_Quantity) AS Maximum_Stock,
    ROUND(AVG(Stock_Quantity), 2) AS Average_Stock,
    SUM(Stock_Quantity) AS Total_Stock
FROM books;

SELECT
    Stock_Status,
    COUNT(*) AS Number_of_Books,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM books),
        2
    ) AS Percentage
FROM books
GROUP BY Stock_Status
ORDER BY Number_of_Books DESC; 



# Category-wise Stock Analysis
# This analysis compares inventory levels across book categories to identify categories with higher or lower average stock.

SELECT
    Category,
    COUNT(*) AS Number_of_Books,
    ROUND(AVG(Stock_Quantity), 2) AS Average_Stock,
    SUM(Stock_Quantity) AS Total_Stock
FROM books
GROUP BY Category
HAVING COUNT(*) >= 5
ORDER BY Average_Stock DESC;


# Low-Stock Books

SELECT
    Title,
    Category,
    Price,
    Stock_Quantity,
    Stock_Status
FROM books
WHERE Stock_Status = 'Low Stock'
ORDER BY Stock_Quantity ASC, Price DESC
LIMIT 20;


# High-Value Low-Stock Books

SELECT
    Title,
    Category,
    Price,
    Stock_Quantity,
    Stock_Status
FROM books
WHERE Stock_Status = 'Low Stock'
ORDER BY Price DESC
LIMIT 20; 


# Price Band Analysis
# This section analyzes the distribution of books across Budget, Mid-Range, and Premium price bands and compares their average ratings and stock levels. 

SELECT
    Price_Band,
    COUNT(*) AS Number_of_Books,
    ROUND(AVG(Price), 2) AS Average_Price,
    ROUND(AVG(Rating), 2) AS Average_Rating,
    ROUND(AVG(Stock_Quantity), 2) AS Average_Stock
FROM books
GROUP BY Price_Band
ORDER BY Average_Price DESC;


# Price and Rating Relationship

SELECT
    Price_Band,
    Rating_Category,
    COUNT(*) AS Number_of_Books,
    ROUND(AVG(Price), 2) AS Average_Price,
    ROUND(AVG(Rating), 2) AS Average_Rating
FROM books
GROUP BY
    Price_Band,
    Rating_Category
ORDER BY
    Price_Band,
    Average_Rating DESC;  
    
    
    
# Category Performance Analysis
# This analysis combines pricing, ratings, and inventory to identify categories with strong overall performance.

SELECT
    Category,
    COUNT(*) AS Number_of_Books,
    ROUND(AVG(Price), 2) AS Average_Price,
    ROUND(AVG(Rating), 2) AS Average_Rating,
    ROUND(AVG(Stock_Quantity), 2) AS Average_Stock
FROM books
GROUP BY Category
HAVING COUNT(*) >= 5
ORDER BY Average_Rating DESC, Average_Price DESC;



# CASE-Based Business Classification

SELECT
    Title,
    Category,
    Price,
    Rating,
    Stock_Quantity,

    CASE
        WHEN Price >= 40 THEN 'Premium'
        WHEN Price >= 20 THEN 'Mid-Range'
        ELSE 'Budget'
    END AS Price_Segment,

    CASE
        WHEN Rating >= 4 THEN 'Highly Rated'
        WHEN Rating >= 3 THEN 'Average Rated'
        ELSE 'Low Rated'
    END AS Rating_Segment,

    CASE
        WHEN Stock_Quantity <= 5 THEN 'Reorder Required'
        WHEN Stock_Quantity <= 10 THEN 'Monitor Stock'
        ELSE 'Sufficient Stock'
    END AS Inventory_Action

FROM books
LIMIT 20;  



# Inventory Action Summary

SELECT
    CASE
        WHEN Stock_Quantity <= 5 THEN 'Reorder Required'
        WHEN Stock_Quantity <= 10 THEN 'Monitor Stock'
        ELSE 'Sufficient Stock'
    END AS Inventory_Action,

    COUNT(*) AS Number_of_Books,

    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM books),
        2
    ) AS Percentage

FROM books

GROUP BY
    CASE
        WHEN Stock_Quantity <= 5 THEN 'Reorder Required'
        WHEN Stock_Quantity <= 10 THEN 'Monitor Stock'
        ELSE 'Sufficient Stock'
    END

ORDER BY Number_of_Books DESC;
 
 
 
# High-Value Books Requiring Reorder

SELECT
    Title,
    Category,
    Price,
    Rating,
    Stock_Quantity,

    CASE
        WHEN Price >= 40 AND Stock_Quantity <= 5
        THEN 'High Priority Reorder'
        ELSE 'Normal'
    END AS Reorder_Priority

FROM books

WHERE Price >= 40
  AND Stock_Quantity <= 5

ORDER BY Price DESC;



# Subquery Analysis

SELECT
    Title,
    Category,
    Price,
    Rating
FROM books
WHERE Price > (
    SELECT AVG(Price)
    FROM books
)
ORDER BY Price DESC;



# Books Above Average Price and Rating

SELECT
    Title,
    Category,
    Price,
    Rating
FROM books
WHERE Price > (
    SELECT AVG(Price)
    FROM books
)
AND Rating > (
    SELECT AVG(Rating)
    FROM books
)
ORDER BY Rating DESC, Price DESC;



# Common Table Expression (CTE)

WITH category_summary AS (
    SELECT
        Category,
        COUNT(*) AS Book_Count,
        ROUND(AVG(Price), 2) AS Average_Price,
        ROUND(AVG(Rating), 2) AS Average_Rating
    FROM books
    GROUP BY Category
)

SELECT
    Category,
    Book_Count,
    Average_Price,
    Average_Rating
FROM category_summary
WHERE Book_Count >= 5
ORDER BY Average_Rating DESC;




# CTE for Price Band Performance

WITH price_band_summary AS (
    SELECT
        Price_Band,
        COUNT(*) AS Book_Count,
        ROUND(AVG(Price), 2) AS Average_Price,
        ROUND(AVG(Rating), 2) AS Average_Rating,
        ROUND(AVG(Stock_Quantity), 2) AS Average_Stock
    FROM books
    GROUP BY Price_Band
)

SELECT
    Price_Band,
    Book_Count,
    Average_Price,
    Average_Rating,
    Average_Stock
FROM price_band_summary
ORDER BY Average_Price DESC;



# Ranking Books by Price

SELECT
    Title,
    Category,
    Price,
    Rating,
    RANK() OVER (ORDER BY Price DESC) AS Price_Rank
FROM books
ORDER BY Price_Rank
LIMIT 20;




# Ranking Books Within Each Price Band

SELECT
    Title,
    Category,
    Price_Band,
    Price,
    Rating,
    RANK() OVER (
        PARTITION BY Price_Band
        ORDER BY Price DESC
    ) AS Price_Rank_Within_Band
FROM books
ORDER BY Price_Band, Price_Rank_Within_Band
LIMIT 30;




# Compare Each Book's Price with the Category Average

SELECT
    Title,
    Category,
    Price,
    ROUND(
        AVG(Price) OVER (PARTITION BY Category),
        2
    ) AS Category_Average_Price,
    ROUND(
        Price - AVG(Price) OVER (PARTITION BY Category),
        2
    ) AS Price_Difference
FROM books
ORDER BY Price_Difference DESC
LIMIT 20;




# Assigning a unique sequential number to each book and assigning the same rank to books with equal prices without gaps.

SELECT
    Title,
    Category,
    Price,
    Rating,
    ROW_NUMBER() OVER (ORDER BY Price DESC) AS Price_Row_Number,
    DENSE_RANK() OVER (ORDER BY Price DESC) AS Price_Dense_Rank
FROM books
ORDER BY Price DESC
LIMIT 20;




# Identify the Most Expensive Books Within Each Category

SELECT
    Title,
    Category,
    Price,
    Rating,
    ROW_NUMBER() OVER (
        PARTITION BY Category
        ORDER BY Price DESC
    ) AS Category_Price_Rank
FROM books
ORDER BY Category, Category_Price_Rank
LIMIT 50;




# Category-wise Inventory Value Analysis

SELECT
    Category,
    COUNT(*) AS Book_Count,
    ROUND(SUM(Price * Stock_Quantity), 2) AS Inventory_Value,
    ROUND(AVG(Price * Stock_Quantity), 2) AS Avg_Book_Inventory_Value
FROM books
GROUP BY Category
ORDER BY Inventory_Value DESC;




# Revenue by Price Band

SELECT
    Price_Band,
    COUNT(*) AS Book_Count,
    ROUND(SUM(Price), 2) AS Total_Price,
    ROUND(AVG(Price), 2) AS Average_Price
FROM books
GROUP BY Price_Band
ORDER BY Total_Price DESC;




# Stock Status by Price Band

SELECT
    Price_Band,
    Stock_Status,
    COUNT(*) AS Book_Count,
    ROUND(AVG(Stock_Quantity), 2) AS Avg_Stock_Quantity,
    ROUND(AVG(Price), 2) AS Avg_Price
FROM books
GROUP BY Price_Band, Stock_Status
ORDER BY Price_Band, Stock_Status;




# Category-wise total inventory value

SELECT
    category,
    COUNT(*) AS total_books,
    ROUND(SUM(price), 2) AS total_inventory_value,
    ROUND(AVG(price), 2) AS average_price
FROM books
GROUP BY category
ORDER BY total_inventory_value DESC;




# Price Band and Stock Status Analysis

SELECT
    Price_Band,
    Stock_Status,
    COUNT(*) AS Book_Count,
    ROUND(SUM(Price), 2) AS Total_Book_Value,
    ROUND(AVG(Price), 2) AS Average_Price,
    ROUND(AVG(Stock_Quantity), 2) AS Average_Stock
FROM books
GROUP BY Price_Band, Stock_Status
ORDER BY Price_Band, Stock_Status; 




# CTE for High-Value Low-Stock Books

WITH low_stock_books AS (
    SELECT
        Title,
        Category,
        Price,
        Stock_Quantity,
        Stock_Status,
        Price_Band
    FROM books
    WHERE Stock_Status = 'Low Stock'
)
SELECT
    Title,
    Category,
    Price,
    Stock_Quantity,
    Price_Band
FROM low_stock_books
ORDER BY Price DESC
LIMIT 20;




# Highest-Value Low-Stock Categories

SELECT
    Category,
    COUNT(*) AS Low_Stock_Books,
    ROUND(SUM(Price), 2) AS Low_Stock_Value,
    ROUND(AVG(Price), 2) AS Average_Price
FROM books
WHERE Stock_Status = 'Low Stock'
GROUP BY Category
ORDER BY Low_Stock_Value DESC;




# High-Rated Low-Stock Books

SELECT
    Title,
    Category,
    Price,
    Rating,
    Stock_Quantity,
    Price_Band
FROM books
WHERE Stock_Status = 'Low Stock'
  AND Rating >= 4
ORDER BY Rating DESC, Price DESC
LIMIT 20;




# Category-Level Rating and Inventory Risk
# Identify categories with strong average ratings but relatively low average stock, helping prioritize inventory management.

SELECT
    Category,
    COUNT(*) AS Book_Count,
    ROUND(AVG(Rating), 2) AS Average_Rating,
    ROUND(AVG(Stock_Quantity), 2) AS Average_Stock,
    SUM(CASE WHEN Stock_Status = 'Low Stock' THEN 1 ELSE 0 END) AS Low_Stock_Books
FROM books
GROUP BY Category
HAVING AVG(Rating) >= 4
ORDER BY Average_Rating DESC, Average_Stock ASC;




# Overall BookWise Business KPI Summary

SELECT
    COUNT(*) AS Total_Books,
    ROUND(AVG(Price), 2) AS Average_Price,
    ROUND(AVG(Rating), 2) AS Average_Rating,
    ROUND(AVG(Stock_Quantity), 2) AS Average_Stock,
    SUM(Stock_Quantity) AS Total_Stock,
    SUM(CASE WHEN Stock_Status = 'Low Stock' THEN 1 ELSE 0 END) AS Low_Stock_Books,
    SUM(CASE WHEN Stock_Status = 'Medium Stock' THEN 1 ELSE 0 END) AS Medium_Stock_Books,
    SUM(CASE WHEN Stock_Status = 'High Stock' THEN 1 ELSE 0 END) AS High_Stock_Books
FROM books;




# Category Performance Ranking

WITH category_performance AS (
    SELECT
        Category,
        COUNT(*) AS Book_Count,
        ROUND(SUM(Price), 2) AS Total_Inventory_Value,
        ROUND(AVG(Price), 2) AS Average_Price
    FROM books
    GROUP BY Category
)
SELECT
    Category,
    Book_Count,
    Total_Inventory_Value,
    Average_Price,
    DENSE_RANK() OVER (
        ORDER BY Total_Inventory_Value DESC
    ) AS Category_Rank
FROM category_performance
ORDER BY Category_Rank;





# Top 10 Most Expensive Books

SELECT
    Title,
    Category,
    Price,
    Rating,
    Stock_Quantity,
    Price_Band
FROM books
ORDER BY Price DESC
LIMIT 10;




# Top 10 Highest-Rated Books

SELECT
    Title,
    Category,
    Rating,
    Price,
    Stock_Quantity,
    Price_Band
FROM books
ORDER BY Rating DESC, Price DESC
LIMIT 10;




# Category-wise Price and Rating Comparison

SELECT
    Category,
    COUNT(*) AS Book_Count,
    ROUND(AVG(Price), 2) AS Average_Price,
    ROUND(AVG(Rating), 2) AS Average_Rating
FROM books
GROUP BY Category
ORDER BY Average_Price DESC;




# Stock Quantity Ranking

SELECT
    Title,
    Category,
    Stock_Quantity,
    Price,
    DENSE_RANK() OVER (
        PARTITION BY Category
        ORDER BY Stock_Quantity DESC
    ) AS Stock_Rank
FROM books
ORDER BY Category, Stock_Rank;




# Low Stock Books

SELECT
    Title,
    Category,
    Stock_Quantity,
    Price,
    Price_Band
FROM books
WHERE Stock_Quantity <= 5
ORDER BY Stock_Quantity ASC, Price DESC;