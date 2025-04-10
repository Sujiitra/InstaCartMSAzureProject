-- Query example
-- 1. See 10 random orders
SELECT TOP 10 * FROM gold.orders_view;

-- 2. Get number of orders by user
SELECT user_id, COUNT(*) AS order_count
FROM gold.orders_view
GROUP BY user_id
ORDER BY order_count DESC;

-- 3. Most reordered products from prior dataset
SELECT product_id, COUNT(*) AS reorder_count
FROM gold.order_products_prior_view
WHERE reordered = 1
GROUP BY product_id
ORDER BY reorder_count DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

-- 4. Orders by hour of the day
SELECT order_hour_of_day, COUNT(*) AS total_orders
FROM gold.orders_view
GROUP BY order_hour_of_day
ORDER BY order_hour_of_day;

-- 5. Total products per department (after joining views)
SELECT d.department_name, COUNT(p.product_id) AS total_products
FROM gold.products_view p
JOIN gold.departments_view d ON p.department_id = d.department_id
GROUP BY d.department_name
ORDER BY total_products DESC;
