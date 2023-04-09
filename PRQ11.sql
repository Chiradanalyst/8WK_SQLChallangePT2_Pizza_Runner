/*

1. How many runners signed up for each 1 week period? 
 
*/

SELECT EXTRACT('week' FROM registration_date) as week, count(runner_id)
FROM pizza_runner.runners
GROUP BY EXTRACT('week' FROM registration_date)
ORDER BY week
