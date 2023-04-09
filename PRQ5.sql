/*
How many Vegetarian and Meatlovers were ordered by each customer?
	STEP 1
		- used customer_orders_cte to remove null values
	STEP 2
		- Created meetlovers_CTE to isolate and group meetlovers_orders
			- USED a LEFT JOIN function join to bring in the pizza_names table for the pizza_name.pizza_names column
				- joined on pizza_id
			- WHERE function to isolate pizza_id 1 IE 'meet_lovers.'
		- Repeated this step with Vegetarian pizzas and created Vegetarian CTE
	Step 3
		- Ran main Query 
			- Used a FULL JOIN to combine Vegetarian & Meetlovers
		- Replaced NULL Values with COALESCE Function on all columns.

*/


WITH customer_orders_cte AS (
SELECT order_id,
	customer_id,
	pizza_id,
	COALESCE(exclusions,'NA') AS exclusions,
	COALESCE(extras,'NA') AS extras,
	order_time
FROM pizza_runner.customer_orders
),
meetlovers AS(
SELECT customer_orders_cte.customer_id, 
		COUNT(pizza_names.pizza_name) AS Meetlovers_orders
FROM customer_orders_cte
LEFT JOIN pizza_runner.pizza_names
ON customer_orders_cte.pizza_id = pizza_names.pizza_id
WHERE customer_orders_cte.pizza_id = 1
GROUP BY customer_orders_cte.customer_id),

Vegetarian AS(
SELECT customer_orders_cte.customer_id, 
		COUNT(pizza_names.pizza_name) AS Vegetarian_orders
FROM customer_orders_cte
FULL JOIN pizza_runner.pizza_names
ON customer_orders_cte.pizza_id = pizza_names.pizza_id
WHERE customer_orders_cte.pizza_id = 2
GROUP BY customer_orders_cte.customer_id)


SELECT COALESCE(meetlovers.customer_id,0) AS customer_id,
COALESCE(Meetlovers_orders,0) AS Meetlovers_orders,
COALESCE(Vegetarian_orders, 0) AS Vegetarian_orders
FROM meetlovers
FULL JOIN Vegetarian
ON meetlovers.customer_id = Vegetarian.customer_id
