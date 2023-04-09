/*

What was the difference between the longest and shortest delivery times for all orders?

	STEP 1 
		- CREATE distance CTE to clean data
	STEP 2
		- CREATE m_m CTE to identify the max_distance & min_distance
	STEP 3
		- In main query subtract the max_distance from the min_distance to get the answer
		- 15
*/

With distance as(
SELECT order_id,
	CAST(REPLACE(distance, 'km', '') AS NUMERIC) as distance
FROM pizza_runner.runner_orders
WHERE distance <> 'null'),

m_m as (
SELECT  max(distance) as max_distance,
	min(distance) as min_distance
from distance)

SELECT max_distance - min_distance as answer
FROM m_m
