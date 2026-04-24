USE ecomm_sales_project;

-- Drop cleaned table if exists
DROP TABLE IF EXISTS retail_transactions;

-- Create cleaned table
CREATE TABLE retail_transactions AS
SELECT
    Invoice AS InvoiceNo,
    StockCode,
    Description,

    -- Convert Quantity safely
    CAST(NULLIF(Quantity_Text, '') AS SIGNED) AS Quantity,

    -- Convert date
    STR_TO_DATE(InvoiceDate_Text, '%Y-%m-%d %H:%i') AS InvoiceDate,

    -- Convert price safely
    CAST(NULLIF(Price_Text, '') AS DECIMAL(10,2)) AS UnitPrice,

    -- Convert CustomerID
    CAST(NULLIF(CustomerID_Text, '') AS UNSIGNED) AS CustomerID,

    Country,

    -- Calculate Total Sales
    (CAST(NULLIF(Quantity_Text, '') AS SIGNED) *
     CAST(NULLIF(Price_Text, '') AS DECIMAL(10,2))) AS TotalSales

FROM stage_combined

WHERE
    Quantity_Text REGEXP '^[0-9]+$'
    AND Price_Text REGEXP '^[0-9.]+$'
    AND InvoiceDate_Text IS NOT NULL
    AND Quantity_Text <> ''
    AND Price_Text <> '';