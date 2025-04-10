--Create views from complex queries

-- 1. Top 10 Most Reordered Products
CREATE OR ALTER VIEW gold.top_reordered_products AS
SELECT TOP 10
    p.product_id,
    p.product_name,
    COUNT(pr.reordered) AS total_reorders
FROM gold.order_products_prior_view pr
JOIN gold.products_view p ON pr.product_id = p.product_id
WHERE pr.reordered = '1'
GROUP BY p.product_id, p.product_name
ORDER BY total_reorders DESC;
GO

-- 2. Orders by Day of Week
CREATE OR ALTER VIEW gold.orders_by_dayofweek AS
SELECT 
    order_dow AS day_of_week,
    COUNT(order_id) AS total_orders
FROM gold.orders_view
GROUP BY order_dow;
GO

-- 3. Top Departments by Orders
CREATE OR ALTER VIEW gold.top_departments_by_orders AS
SELECT 
    d.department_name,
    COUNT(op.product_id) AS total_ordered
FROM gold.order_products_prior_view op
JOIN gold.products_view p ON op.product_id = p.product_id
JOIN gold.departments_view d ON p.department_id = d.department_id
GROUP BY d.department_name;
GO

-- 4. Orders by Hour of Day
CREATE OR ALTER VIEW gold.orders_by_hour AS
SELECT 
    o.order_hour_of_day,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(pr.product_id) AS total_products_ordered
FROM gold.orders_view o
JOIN gold.order_products_prior_view pr ON o.order_id = pr.order_id
GROUP BY o.order_hour_of_day;
GO

-- 5. Average Cart Size Per User
CREATE OR ALTER VIEW gold.avg_cart_size_per_user AS
SELECT 
    order_summary.user_id,
    AVG(order_summary.product_count) AS avg_cart_size
FROM (
    SELECT o.order_id, o.user_id, COUNT(op.product_id) AS product_count
    FROM gold.orders_view o
    JOIN gold.order_products_prior_view op ON o.order_id = op.order_id
    GROUP BY o.order_id, o.user_id
) AS order_summary
GROUP BY order_summary.user_id;
GO