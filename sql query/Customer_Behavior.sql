USE restaurant_db
-- 1. Combine the menu_items and order_details tables into a single table.
SELECT * 
FROM order_details AS o
LEFT JOIN menu_items AS m
	ON o.item_id = m.menu_item_id

-- 2. What were the least and most ordered items? What categories were they in?
SELECT 
	m.category,
    m.item_name,
    COUNT(*) AS num_purchases
FROM order_details AS o
LEFT JOIN menu_items AS m
	ON o.item_id = m.menu_item_id
GROUP BY m.item_name, category
ORDER BY num_purchases ASC;


SELECT 
	m.category,
    m.item_name,
    COUNT(*) AS num_purchases
FROM order_details AS o
LEFT JOIN menu_items AS m
	ON o.item_id = m.menu_item_id
GROUP BY m.item_name, category
ORDER BY num_purchases DESC;


-- 3. What were the top 5 orders that spent the most money?
SELECT 
	o.order_id,
    ROUND(SUM(m.price),2) AS total_spend
FROM order_details AS o
LEFT JOIN menu_items AS m
	ON o.item_id = m.menu_item_id
GROUP BY o.order_id
ORDER BY total_spend DESC
LIMIT 5;

-- 4. View the details of the highest spend order. What insights can you gather from the results?
SELECT 
	m.category, 
    COUNT(*) AS num_items
FROM order_details AS o
LEFT JOIN menu_items AS m
	ON o.item_id = m.menu_item_id
WHERE order_id = 440
GROUP BY category

-- 5. View the details of the top 5 highest spend orders. What insights can you gather from the results?
SELECT 
	o.order_id,
	m.category,
    COUNT(*) AS num_items
FROM order_details AS o
LEFT JOIN menu_items AS m
	ON o.item_id = m.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY m.category, o.order_Id