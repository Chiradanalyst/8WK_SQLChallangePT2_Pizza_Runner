/*

What are the standard ingredients for each pizza?
	
	Step 1 : Create CTE's to capture pizza 1 toppings as P1 & pizza 2 toppings as P2
		- Broke string in columns apart using a combination of UNNEST & STRING_TO_ARRAY
		- Used a CAST function to turn string into a Numeric value for when we join on pizza_toppings
		- Used where to single out the pizza in the CTE
	Step 2
		- Left joined P1 & P2 with pizza_toppings
		- this created two new CTEs with the pizza toping names 
			- pizza_topping_1
			- pizza_topping_2
	STEP 3
		- Unioned the two new CTEs( pizza_topping_1 & pizza_topping_2) together
		to get my list of ingredients


*/

WITH P1 as(
SELECT pizza_id,
	CAST(UNNEST(STRING_TO_ARRAY(toppings,',')) AS NUMERIC) as topping_pizza1
FROM pizza_runner.pizza_recipes
WHERE pizza_id = 1), 

P2 as (
SELECT pizza_id, 
		CAST(UNNEST(STRING_TO_ARRAY(toppings,',')) AS NUMERIC) as topping_pizza2
FROM pizza_runner.pizza_recipes
WHERE pizza_id = 2),

pizza_one_toppings AS (
SELECT pizza_id,
	topping_pizza1,
	topping_name
FROM P1
LEFT JOIN pizza_runner.pizza_toppings
ON pizza_toppings.topping_id = P1.topping_pizza1),

pizza_two_toppings AS (
SELECT pizza_id,
	topping_pizza2,
	topping_name
FROM P2
LEFT JOIN pizza_runner.pizza_toppings
ON pizza_toppings.topping_id = P2.topping_pizza2)

SELECT pizza_id, 
	topping_pizza1 as topping, 
	topping_name
FROM pizza_one_toppings
UNION
SELECT *
FROM pizza_two_toppings
ORDER BY pizza_id



