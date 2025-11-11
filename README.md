##  Menu Performance Analysis SQL Project

## Project Overview
**Project Title:** Menu Performance Analysis<br>
**Database:** restaurant_db <br>
<br>
This project analyzes customer and order data to understand how the cafe’s newly launched menu is performing. Identify which menu items sell the most and the least, determine revenue-driving categories, and discover what the top-spending customers prefer. This project helps develop SQL skills for real business analysis, including joins, aggregations, filtering, and insight generation.

## Objectives
1. Explore the menu_items table to understand the full list of items included in the new menu.

2. Analyze the order_details table to review all collected order-level data and understand customer purchasing behavior.

3. Combine both tables to evaluate how customers are reacting to the new menu, including identifying popular items, underperforming items, and spending patterns.

## Dataset Overview

**The database contains two key tables:**

**1. menu_items**

Contains information about each dish offered on the new menu.<br>
**Key columns:**<br>
menu_item_id<br>
item_name<br>
category<br>
price

**2. order_details**

Contains customer order transaction data.<br>
**Key columns:**<br>
order_id<br>
item_id<br>
quantity<br>
order_date


## Explore the menu_items table to get an idea of what's on the new menu

1. **View the menu_items table.**
```sql
SELECT *
FROM menu_items
```
2. **Find the number of items on the menu.**
```sql
SELECT
  COUNT(*) AS Number_of_items
FROM menu_items
```
3. **What are the least and most expensive items on the menu?**
```sql
SELECT *
FROM menu_items
ORDER BY price;
```
```sql
SELECT *
FROM menu_items
ORDER BY price DESC;
```
4. **How many Italian dishes on the menu?**
```sql
SELECT *
FROM menu_items
WHERE category ='Italian'
```
5. **What are the least and most expensive Italian dishes on the menu?**
```sql
SELECT *
FROM menu_items
WHERE category ='Italian'
ORDER BY price ASC;
```

```sql
SELECT *
FROM menu_items
WHERE category ='Italian'
ORDER BY price DESC;
```
6. **How many dishes are in each category?**
```sql
SELECT 
	category,
    COUNT(*) AS num_dishes
FROM menu_items
GROUP BY category
```
7. **What is the Average dishes price within each category?**
```sql
SELECT
	category,
    ROUND(AVG(price),2) AS avg_price
FROM menu_items
GROUP BY category
```
## Explore the order_details table to get an idea of the data that's been collected
1. **View the order_details table.**
```sql
SELECT *
FROM order_details
```
2. **What is the date range of the table?**
```sql
SELECT 
	min(order_date) AS min_order_date,
    max(order_date) AS max_order_date
FROM order_details;
```
3. **How many orders were made within this date range?**
```sql
SELECT 
	COUNT(DISTINCT(order_id)) AS tota_orders
FROM order_details
```
4. **How many items were orders were made within this date range?**
```sql
SELECT 
	COUNT(*) AS total_items
FROM order_details
```
5. **Which orders had the most number of items?**
```sql
SELECT 
	order_id,
	COUNT(*) AS num_item
FROM order_details
GROUP BY order_id
ORDER BY num_item DESC
```
6. **How many orders had more than 12 items?**
```sql
SELECT COUNT(*) AS Num_orders
FROM (SELECT 
	order_id,
	COUNT(*) AS num_item
FROM order_details
GROUP BY order_id
HAVING num_item > 12) AS Num_orders;
```
## Use both tables to understand how customers are reacting to the new menu
1. **Combine the menu_items and order_details tables into a single table.**
```sql
SELECT * 
FROM order_details AS o
LEFT JOIN menu_items AS m
	ON o.item_id = m.menu_item_id
```
2. **What were the least and most ordered items? What categories were they in?**
```sql
SELECT 
	m.category,
    m.item_name,
    COUNT(*) AS num_purchases
FROM order_details AS o
LEFT JOIN menu_items AS m
	ON o.item_id = m.menu_item_id
GROUP BY m.item_name, category
ORDER BY num_purchases ASC;
```
```sql
SELECT 
	m.category,
    m.item_name,
    COUNT(*) AS num_purchases
FROM order_details AS o
LEFT JOIN menu_items AS m
	ON o.item_id = m.menu_item_id
GROUP BY m.item_name, category
ORDER BY num_purchases DESC;
```
3. **What were the top 5 orders that spent the most money?**
```sql
SELECT 
	o.order_id,
    ROUND(SUM(m.price),2) AS total_spend
FROM order_details AS o
LEFT JOIN menu_items AS m
	ON o.item_id = m.menu_item_id
GROUP BY o.order_id
ORDER BY total_spend DESC
LIMIT 5
```
4. **View the details of the highest spend order.**
```sql
SELECT 
	m.category, 
    COUNT(*) AS num_items
FROM order_details AS o
LEFT JOIN menu_items AS m
	ON o.item_id = m.menu_item_id
WHERE order_id = 440
GROUP BY category
```
5. **View the details of the top 5 highest spend orders.**
```sql
SELECT 
	o.order_id,
	m.category,
    COUNT(*) AS num_items
FROM order_details AS o
LEFT JOIN menu_items AS m
	ON o.item_id = m.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY m.category, o.order_Id
```
## Key Insights 


**Italian Cuisine:** Top revenue contributor; appears in all high-value orders.<br>
**Asian & Mexican Cuisines:** Consistently in demand; steady performers.<br>
**American Items:** Appear in smaller quantities; act as complementary dishes.<br>
**Multi-Cuisine Orders:** Most high-value orders include 3–4 cuisines; indicates variety preference.<br>
**Customer Behavior:** Menu variety drives higher order value.<br>
**Opportunities:** Focus marketing and promotions on Italian, Asian, and Mexican categories.
