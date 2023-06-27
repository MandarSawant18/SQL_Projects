
# Case Study 1: Danny's Diner Solution

**1. What is the total amount each customer spent at the restaurant?**
```bash
SELECT s.customer_id,
       sum(m.price) AS total_amount
FROM sales s
JOIN menu m
  ON s.product_id = m.product_id
GROUP BY  s.customer_id
ORDER BY  total_amount desc
```

![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%201%20-%20Danny's%20Diner/Screenshots/Q1.png?raw=true)

Customer A spent $76, Customer B spent $74, and Customer C spent $36. Therefore, Customer A is currently the most valuable customer.
## 
**2. How many days has each customer visited the restaurant?**
```bash
SELECT customer_id,
       count(distinct order_date) AS no_of_days
FROM sales
GROUP BY  customer_id
ORDER BY  no_of_days desc
```

![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%201%20-%20Danny's%20Diner/Screenshots/Q2.png?raw=true)

B had the highest number of visits with 6, whereas C had the lowest number of visits with only 2.
## 

**3. What was the first item from the menu purchased by each customer?**
```bash
with table1 AS 
  (SELECT a.customer_id,
          a.order_date,
          b.product_name,
          rank()over(partition by customer_id ORDER BY  a.order_date) AS ranking
   FROM sales a
   JOIN menu b
      ON a.product_id = b.product_id)

SELECT *
FROM table1
WHERE ranking = 1
```

![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%201%20-%20Danny's%20Diner/Screenshots/Q3.png?raw=true)

The first order of Customer A includes curry and sushi. Customer B's first order is curry while Customer C's first order is ramen.
## 
**4. What is the most purchased item on the menu and how many times was it purchased by all customers?**
```bash
SELECT b.product_name,
       count(a.product_id) AS purchase_count
FROM sales a
INNER JOIN menu b
  ON a.product_id = b.product_id
GROUP BY  b.product_name
ORDER BY  purchase_count desc
```

![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%201%20-%20Danny's%20Diner/Screenshots/Q4.png?raw=true)

Ramen is the item that has been purchased the most with a total of 8 purchases.
## 
**5. Which item was the most popular for each customer?**
```bash
with table1 AS 
  (SELECT a.customer_id,
          b.product_name,
          count(a.product_id) AS purchase_count,
          rank()over(partition by a.customer_id ORDER BY count(a.product_id) desc) AS ranking
  FROM sales a
  INNER JOIN menu b
     ON a.product_id = b.product_id
  GROUP BY  a.customer_id, b.product_name)
            
SELECT *
FROM table1
WHERE ranking = 1
```

![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%201%20-%20Danny's%20Diner/Screenshots/Q5.png?raw=true)

The favourite dish of Customer A and C is ramen, while Customer B likes sushi, ramen and curry equally.
## 
**6. Which item was purchased first by the customer after they became a member?**
```bash
with table1 AS 
  (SELECT a.customer_id,
          b.join_date,
          a.order_date,
          c.product_name,
          rank()over(partition by a.customer_id ORDER BY  a.order_date) AS ranking
  FROM members b
  JOIN sales a
    ON b.customer_id = a.customer_id
  JOIN menu c
    ON a.product_id = c.product_id
   WHERE a.order_date >= b.join_date)
            
SELECT *
FROM table1
WHERE ranking =1
```

![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%201%20-%20Danny's%20Diner/Screenshots/Q6.png?raw=true)

After becoming members, Customer A purchased curry and Customer B purchased sushi as their first purchases respectively.
## 
**7. Which item was purchased just before the customer became a member?**
```bash
with table1 AS 
  (SELECT a.customer_id,
          b.join_date,
          a.order_date,
          c.product_name,
          rank()over(partition by a.customer_id ORDER BY  a.order_date desc) AS ranking
  FROM members b
  JOIN sales a
    ON b.customer_id = a.customer_id
  JOIN menu c
    ON a.product_id = c.product_id
  WHERE a.order_date < b.join_date)

SELECT *
FROM table1
WHERE ranking =1

```

![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%201%20-%20Danny's%20Diner/Screenshots/Q7.png?raw=true)

Customer A purchased sushi and curry right before becoming a member, whereas Customer B only bought sushi.
## 
**8. What is the total items and amount spent for each member before they became a member?**
```bash
SELECT a.join_date,
       b.customer_id,
       count(b.product_id) AS total_items,
       count(distinct b.product_id) AS unique_items,
       sum(c.price) AS total_cost
FROM members a
JOIN sales b
  ON a.customer_id = b.customer_id
JOIN menu c
  ON b.product_id = c.product_id
WHERE b.order_date < a.join_date
GROUP BY  a.join_date,b.customer_id
```

![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%201%20-%20Danny's%20Diner/Screenshots/Q8.png?raw=true)

Customer A spent $25 on 2 items before becoming a member, while Customer B spent $40 on 2 items (3 orders).
## 
**9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?**
```bash
with points_table AS 
	(SELECT b.customer_id,
		    c.product_name,
		    c.price,
	        CASE
		      WHEN product_name = 'sushi' THEN c.price * 2
		      ELSE c.price
		    END AS new_price
	FROM sales b
	JOIN menu c
		ON b.product_id = c.product_id)	

SELECT customer_id,
	   sum(new_price)*10 AS points
FROM points_table
GROUP BY  customer_id
ORDER BY  points DESC
```

![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%201%20-%20Danny's%20Diner/Screenshots/Q9.png?raw=true)

Customer A got 860 points, customer B got 940 points, and customer C got 360 points.
## 
**10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?**
```bash
with points_table AS 
	(SELECT b.customer_id,
		    a.join_date,
		    c.product_name,
		    c.price,
		    CASE
		      WHEN product_name = 'sushi' THEN c.price * 2
		      WHEN b.order_date BETWEEN a.join_date AND (a.join_date + 6) THEN c.price * 2
		      ELSE c.price
		    END AS new_price
	FROM members a
	JOIN sales b
		ON a.customer_id = b.customer_id
	JOIN menu c
		ON b.product_id = c.product_id
	WHERE b.order_date <= '2021-01-31')

SELECT customer_id,
	   sum(new_price)*10 AS points
FROM points_table
GROUP BY  customer_id
ORDER BY  points DESC
```

![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%201%20-%20Danny's%20Diner/Screenshots/Q10.png?raw=true)

Customer A got 1370 points and customer B got 820 points.

##
Click [here](https://github.com/MandarSawant18/SQL_Projects/tree/4af383de97d9fa7b402d3dde82391c68ff845298/Data%20with%20Danny%20SQL%20Challenge) for more case studies


