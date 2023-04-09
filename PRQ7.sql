/*
For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
	STEP 1
		- Created customer_orders_no_changes CTE to isolate orders that had no changes
			- used the WHERE function to isolate all orders with blank exclusions and extras columns
			- Used count function on order_id to count all remaining orders
			- grouped by customer_id to count total orders with no change for every customer
	Step 2 
		- Created customer_orders_with_changes CTE to isolate orders that had changes
			- used the WHERE function to isolate all orders with changes or Null values in the exclusions and extras columns
			- Used count function on order_id to count all remaining orders
			- grouped by customer_id to count total orders with changes or NULLS for every customer
	Step 3
		- Ran main query to FULL JOIN both CTEs
			- joined on customer_id
		- USED COALESCE to remove all NULL values in orders_with_no_change columns	
*/

With customer_orders_no_changes AS (
SELECT customer_id,
	count(order_id) AS Orders_with_no_change
FROM pizza_runner.customer_orders
WHERE exclusions = '' AND extras = ''
GROUP BY customer_id
),

customer_orders_with_change AS (
SELECT customer_id,
COUNT(order_id) AS Orders_with_change
FROM pizza_runner.customer_orders
WHERE exclusions != '' AND extras != ''
GROUP BY customer_id)

SELECT customer_orders_with_change.customer_id,
	customer_orders_with_change.orders_with_change,
	COALESCE(customer_orders_no_changes.orders_with_no_change,0) AS orders_with_no_change
FROM customer_orders_with_change
FULL JOIN customer_orders_no_changes
ON customer_orders_with_change.customer_id = customer_orders_no_changes.customer_id