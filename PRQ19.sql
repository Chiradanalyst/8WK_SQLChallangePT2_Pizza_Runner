/*

What was the most common exclusion?
	STEP 1 
		- Remove All NULL values with customer_orders_cte
	STEP 2
		- Clean data with Exclusions CTE
	Step 3
		- Continue to clean data with E CTE
	STEP 4
		- LEFT JOIN topping names into data
		- Count how many times these extras are ordered
			- this is grouped by exclusions

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
exclusions AS (
SELECT order_id, 
	exclusions
FROM customer_orders_cte
WHERE exclusions <> '' AND exclusions <> 'NA' AND exclusions <> 'null'),
E AS (
Select CAST(UNNEST(STRING_TO_ARRAY(exclusions,',')) AS INTEGER) as exclusions,
	order_id
FROM exclusions)

SELECT topping_name, 
	COUNT(order_id) as exclusions_count
FROM E
LEFT JOIN pizza_runner.pizza_toppings 
ON pizza_toppings.topping_id = E.exclusions
GROUP BY topping_name
order by exclusions_count DESC
