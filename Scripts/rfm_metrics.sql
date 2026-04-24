USE ecomm_sales_project;

-- Drop table if exists
DROP TABLE IF EXISTS rfm_metrics;

-- Create RFM metrics table
CREATE TABLE rfm_metrics AS
SELECT
    CustomerID,

    -- Recency: days since last purchase
    DATEDIFF(
        (SELECT MAX(InvoiceDate) FROM retail_transactions) + INTERVAL 1 DAY,
        MAX(InvoiceDate)
    ) AS Recency_Days,

    -- Frequency: number of invoices
    COUNT(DISTINCT InvoiceNo) AS Frequency_Count,

    -- Monetary: total spending
    SUM(TotalSales) AS Monetary_Value

FROM retail_transactions
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID;