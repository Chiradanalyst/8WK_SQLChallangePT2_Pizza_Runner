/*
What was the most commonly added extra?

	STEP 1 
		- Remove All NULL values with customer_orders_cte
	STEP 2
		- Clean data with Extras CTE
	Step 3
		- Continue to clean data with E CTE
	STEP 4
		- LEFT JOIN topping names into data
		- Count how many times these extras are ordered
			- this is grouped by extras
	
*/ 

With customer_orders_cte AS (
SELECT order_id,
	customer_id,
	pizza_id,
	COALESCE(exclusions,'NA') AS exclusions,
	COALESCE(extras,'NA') AS extras,
	order_time
FROM pizza_runner.customer_orders
),
extra AS (
SELECT order_id, 
	extras
FROM customer_orders_cte
WHERE extras <> '' AND extras <> 'NA' AND extras <> 'null'),
E AS (
Select CAST(UNNEST(STRING_TO_ARRAY(extras,',')) AS INTEGER) as extras,
	order_id
FROM extra)

SELECT topping_name, 
	COUNT(order_id) as extra_count
FROM E
LEFT JOIN pizza_runner.pizza_toppings 
ON pizza_toppings.topping_id = E.extras
GROUP BY topping_name
order by extra_count DESC







