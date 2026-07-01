-- 1. Total Revenue Generated
-- Problem Statement 1: "What is the total revenue generated?"
SELECT SUM(price) FROM olist;

-- 2. Monthly Sales Trend (Find Peak Month)
-- Problem Statement 2: "Which month had the highest sales?"
SELECT
    DATE_TRUNC('month', order_purchase_timestamp) AS month,
    SUM(price) AS total_sales
FROM olist
GROUP BY DATE_TRUNC('month', order_purchase_timestamp)
ORDER BY month;

-- 3. Top 10 Product Categories by Revenue
-- Problem Statement 3: Which product categories generate the most revenue?
SELECT SUM(price),product_category_name FROM olist
GROUP BY product_category_name 
ORDER BY SUM(price) DESC LIMIT 10;

-- 4. Top 10 States by Revenue
-- Problem Statement 4: Which states generate the highest revenue?
SELECT SUM(price),customer_state FROM olist
GROUP BY customer_state 
ORDER BY SUM(price) DESC LIMIT 10;

-- 5. Repeat Customer Percentage
-- Problem Statement 5: What percentage of customers are repeat buyers?
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(order_id) AS total_orders
    FROM olist
    GROUP BY customer_id
)

SELECT
    ROUND(
        COUNT(CASE WHEN total_orders > 1 THEN 1 END) * 100.0
        / COUNT(*),
        2
    ) AS repeat_customer_percentage
FROM customer_orders;


-- 6. Average Delivery Time by State
-- Problem Statement 6: What is the average delivery time by state?
SELECT ROUND(AVG(delivery_time_days)), customer_state FROM olist
GROUP BY  customer_state;


-- 7. Percentage of Late Deliveries
-- Problem Statement 7: What percentage of orders were delivered late?
SELECT
    ROUND(
        COUNT(CASE
            WHEN order_delivered_customer_date > order_estimated_delivery_date
            THEN 1
        END) * 100.0
        / COUNT(*),
        2
    ) AS late_delivery_percentage
FROM olist
WHERE order_delivered_customer_date IS NOT NULL;


-- 8. Top Sellers by Revenue (FIXED)
-- Problem Statement 8: Which sellers generate the most revenue?
SELECT SUM(price), seller_id FROM olist
GROUP BY seller_id 
ORDER BY  AVG(price) DESC LIMIT 10;