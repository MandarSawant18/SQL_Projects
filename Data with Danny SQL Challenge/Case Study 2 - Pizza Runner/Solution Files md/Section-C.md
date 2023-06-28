## Section C - Ingredient Optimisation

1. What are the standard ingredients for each pizza?
```bash
-- Normalize/Unpivot Pizza Recipe table so that we can use them in a join
CREATE TABLE pizza_recipes1 
    (pizza_id int,topping_id int);
INSERT INTO pizza_recipes1
    (pizza_id, topping_id) 
VALUES
    (1,1),
    (1,2),
    (1,3),
    (1,4),
    (1,5),
    (1,6),
    (1,8),
    (1,10),
    (2,4),
    (2,6),
    (2,7),
    (2,9),
    (2,11),
    (2,12);

WITH table1 AS
    (SELECT pn.pizza_name,
            pt.topping_name
    FROM pizza_recipes1 pr
    JOIN pizza_toppings pt 
        ON pr.topping_id = pt.topping_id
    JOIN pizza_names pn 
        ON pn.pizza_id = pr.pizza_id
    ORDER BY 1,2)

SELECT  pizza_name,
        string_agg(topping_name, ',') AS standard_toppings
FROM table1
GROUP BY pizza_name
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/C1.png?raw=true)

These are the standard toppings for both the pizzas
##
2. What was the most commonly added extra?
```bash
WITH extras AS
    (SELECT order_id,
            unnest(string_to_array(extras, ','))::integer AS extra_topping_id
    FROM customer_orders
    WHERE length(extras)>0 AND extras <> 'null')

SELECT  b.topping_name,
        count(a.extra_topping_id) extra_count
FROM extras a
JOIN pizza_toppings b 
    ON a.extra_topping_id = b.topping_id
GROUP BY b.topping_name
ORDER BY extra_count DESC

-- unnest(string_to_array(extras, ',')) will unpivot the extras column and the data type will be string
-- It is typecasted into integer so that we can join it with topping_id (int), else we cannot join a string with an integer
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/C2.png?raw=true)

Extra bacon is the most requested item.
##
3. What was the most common exclusion?
```bash
WITH exclusion_table AS
    (SELECT *,
            unnest(string_to_array(exclusions, ',')):: integer AS exclusion_id
    FROM customer_orders
    WHERE length(exclusions) >0 AND exclusions <> 'null')

SELECT  topping_name,
        count(exclusion_id) AS exclusion_count
FROM exclusion_table a
JOIN pizza_toppings b 
    ON a.exclusion_id = b.topping_id
GROUP BY topping_name
ORDER BY exclusion_count DESC


--unnest(string_to_array(exclusions,',')) will unpivot the exclusions column and the data type will be string
-- It is typecasted into integer so that we can join it with topping_id (int), else we cannot join a string with an integer
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/C3.png?raw=true)

The most commonly requested exclusion is cheese.


























##
Other section [solutions](https://github.com/MandarSawant18/SQL_Projects/tree/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Solution%20Files%20md)

View other case studies [here](https://github.com/MandarSawant18/SQL_Projects/tree/main/Data%20with%20Danny%20SQL%20Challenge)