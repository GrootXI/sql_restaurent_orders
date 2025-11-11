-- Order_Details Table

-- 1. View the order_details table.
SELECT *
FROM order_details

-- 2. What is the date range of the table?
SELECT 
	min(order_date) AS min_order_date,
    max(order_date) AS max_order_date
FROM order_details;

-- 3. How many orders were made within this date range?
SELECT 
	COUNT(DISTINCT(order_id)) AS tota_orders
FROM order_details

-- 4.How many items were orders were made within this date range?
SELECT 
	COUNT(*) AS total_items
FROM order_details

-- 5. Which orders had the most number of items?
SELECT 
	order_id,
	COUNT(*) AS num_item
FROM order_details
GROUP BY order_id
ORDER BY num_item DESC

-- 6. How many orders had more than 12 items?
SELECT COUNT(*) AS Num_orders
FROM (SELECT 
	order_id,
	COUNT(*) AS num_item
FROM order_details
GROUP BY order_id
HAVING num_item > 12) AS Num_orders;