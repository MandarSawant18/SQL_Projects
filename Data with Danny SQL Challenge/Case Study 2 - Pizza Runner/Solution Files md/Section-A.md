
# Section A - Pizza Metrics

1. How many pizzas were ordered?
```bash
SELECT count(pizza_id) AS pizza_count
FROM customer_orders;
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/A1.png?raw=true)

A total of 14 pizzas were ordered. 
##
2. How many unique customer orders were made?
```bash
SELECT count(distinct order_id) AS orders
FROM customer_orders;
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/A2.png?raw=true)

In total, 10 unique orders were placed
##
3. How many successful orders were delivered by each runner?
```bash
SELECT  runner_id,
        count(distinct order_id) AS delivered_orders
FROM runner_orders
WHERE pickup_time <> 'null'
GROUP BY  runner_id;
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/A3.png?raw=true)

Runner 1 finished four orders, runner 2 finished three orders, but runner 3 only finished one order.
##
4. How many of each type of pizza was delivered?
```bash
SELECT  pz.pizza_name,
        count (co.pizza_id)
FROM customer_orders co
JOIN pizza_names pz
    ON co.pizza_id = pz.pizza_id
JOIN runner_orders ro
    ON co.order_id = ro.order_id
WHERE ro.pickup_time <> 'null'
GROUP BY  pz.pizza_name;
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/A4.png?raw=true)

A total of 12 pizzas were delivered, with 9 being Meatlovers and 3 being Vegetarian.
##
5. How many Vegetarian and Meatlovers were ordered by each customer?
```bash
SELECT  co.customer_id,
        pz.pizza_name,
        count (co.pizza_id) AS ordered_pizzas
FROM customer_orders co
JOIN pizza_names pz
    ON co.pizza_id = pz.pizza_id
GROUP BY  co.customer_id,pz.pizza_name
ORDER BY  co.customer_id;  
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/A5.png?raw=true)

- Customer 101 placed an order for 2 Meatlovers pizzas and 1 Vegetarian pizza.
- Customer 102 placed an order for 2 Meatlovers pizzas and 1 Vegetarian pizza. 
- Customer 103 placed an order for 3 Meatlovers pizzas and 1 Vegetarian pizza.
- Customer 104 placed an order for 3 Meatlovers pizzas
- Customer 105 placed an order for 1 Vegetarian pizza.
##
6. What was the maximum number of pizzas delivered in a single order?
```bash
SELECT  co.order_id,
        count (co.pizza_id) AS pizza_count
FROM customer_orders co
JOIN runner_orders ro
    ON co.order_id = ro.order_id
WHERE ro.pickup_time <> 'null'
GROUP BY  co.order_id
ORDER BY  pizza_count DESC 
LIMIT 1;  
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/A6.png?raw=true)

The highest number of pizzas that were delivered in a single order was 3.
##
7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
```bash
SELECT  customer_id,
        SUM(CASE
                WHEN((exclusions IS NOT NULL AND exclusions<>'null' AND LENGTH(exclusions)>0) AND (extras IS NOT NULL AND extras<>'null' AND LENGTH(extras)>0))=TRUE 
                THEN 1 
                ELSE 0 
            END) AS changed, 
        SUM(CASE
                WHEN((exclusions IS NOT NULL AND exclusions<>'null'AND LENGTH(exclusions)>0) AND (extras IS NOT NULL AND extras<>'null' AND LENGTH(extras)>0))=TRUE 
                THEN 0 
                ELSE 1 
            END) AS unchanged
FROM customer_orders AS co
INNER JOIN runner_orders AS ro
    ON ro.order_id = co.order_id
WHERE pickup_time<>'null'
GROUP BY  customer_id
ORDER BY  customer_id; 
```
![](https://miro.medium.com/v2/resize:fit:618/format:webp/1*vjmE3ZOjXDRyRM4cp85-UQ.png)

Only 40% of the customers, specifically Customer 101 and 102, opted for their pizzas with the standard set of toppings, while the rest were willing to experiment with different toppings.
##
8. How many pizzas were delivered that had both exclusions and extras?
```bash
SELECT COUNT(pizza_id) AS pizzas_delivered_with_exclusions_and_extras
FROM customer_orders AS co
INNER JOIN runner_orders AS ro
    ON ro.order_id = co.order_id
WHERE pickup_time<>'null' AND (exclusions IS NOT NULL AND exclusions<>'null'AND LENGTH(exclusions)>0) AND (extras IS NOT NULL AND extras<>'null' AND LENGTH(extras)>0);  
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/A8.png?raw=true)

Only one pizza was delivered with both exclusions and extras.
##
9. What was the total volume of pizzas ordered for each hour of the day?
```bash
SELECT  extract(hour FROM order_time) AS hour_of_day, 
        count(pizza_id) AS ordered_pizzas
FROM customer_orders co
GROUP BY  extract(hour FROM order_time)
ORDER BY  extract(hour FROM order_time); 
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/A9.png?raw=true)

The busiest hours of the day are the 13th (1pm), the 18th(6pm), the 21st(9pm), and the 23rd (11pm). The least busy hours are the 11th (11am) and the 19th (7pm).
##
10. What was the volume of orders for each day of the week?
```bash
SELECT  to_char(order_time,'Dy') AS day_of_week, 
        count(pizza_id) AS ordered_pizzas
FROM customer_orders co
GROUP BY  to_char(order_time, 'Dy');  
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/A10.png?raw=true)

Saturdays and Wednesdays are the busiest days of the week, with 5 orders each, while Friday is the least busy.
##
Solutions to- \
[Section B](https://github.com/MandarSawant18/SQL_Projects/blob/d4a619eaa45241305c915a78e5eb83189eb4b816/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Solution%20Files%20md/Section-B.md) \
[Section C](https://github.com/MandarSawant18/SQL_Projects/blob/d4a619eaa45241305c915a78e5eb83189eb4b816/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Solution%20Files%20md/Section-C.md) \
[Section D](https://github.com/MandarSawant18/SQL_Projects/blob/d4a619eaa45241305c915a78e5eb83189eb4b816/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Solution%20Files%20md/Section-D.md)

##
View other case studies [here](https://github.com/MandarSawant18/SQL_Projects/tree/4af383de97d9fa7b402d3dde82391c68ff845298/Data%20with%20Danny%20SQL%20Challenge)