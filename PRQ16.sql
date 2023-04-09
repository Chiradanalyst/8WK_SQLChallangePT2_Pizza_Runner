/*
What was the average speed for each runner for each delivery and do you notice any trend for these values?
	STEP 1
		- CREATE distance CTE to clean data
			- remove all text from distance and duration using REPLACE FUNCTION
			-USE CAST to turn the columns into NUMERIC to aggregate 
	STEP 2 
		- In the main query, divide distance(km) by minutes. This gives me km traveled per minute
		- multiply this by 60 to get km traveled per hour
*/

With distance as(
SELECT order_id,
	CAST(REPLACE(distance, 'km', '') AS NUMERIC) as distance,
	CAST(REPLACE(REPLACE(REPLACE(duration, 'mins',''), 'minutes', ''),' minute','') AS NUMERIC) as duration
FROM pizza_runner.runner_orders
WHERE distance <> 'null')
SELECT order_id, ROUND(distance/duration * 60) as KM_PER_HR
FROM distance