USE ecomm_sales_project;

-- Drop segmented table if exists
DROP TABLE IF EXISTS rfm_segmented;

-- Create segmentation table
CREATE TABLE rfm_segmented AS
WITH scored AS (
    SELECT
        CustomerID,
        Recency_Days,
        Frequency_Count,
        Monetary_Value,

        -- Recency score (lower is better)
        NTILE(5) OVER (ORDER BY Recency_Days ASC) AS R_score,

        -- Frequency score
        NTILE(5) OVER (ORDER BY Frequency_Count DESC) AS F_score,

        -- Monetary score
        NTILE(5) OVER (ORDER BY Monetary_Value DESC) AS M_score

    FROM rfm_metrics
)

SELECT
    *,
    CONCAT(R_score, F_score, M_score) AS RFM_Score,

    CASE
        WHEN R_score = 5 AND F_score >= 4 AND M_score >= 4 THEN 'Champions'
        WHEN R_score >= 4 AND F_score >= 3 THEN 'Loyal Customers'
        WHEN R_score >= 3 AND F_score >= 3 THEN 'Potential Loyalists'
        WHEN R_score = 5 AND M_score <= 2 THEN 'Big Spenders Slipping'
        WHEN R_score <= 2 AND F_score <= 2 THEN 'At Risk'
        ELSE 'Others'
    END AS Segment

FROM scored;