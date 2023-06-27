-- 1. What is the total amount each customer spent at the restaurant?

        SELECT s.customer_id,
            sum(m.price) AS total_amount
        FROM sales s
        JOIN menu m
            ON s.product_id = m.product_id
        GROUP BY  s.customer_id
        ORDER BY  total_amount desc


 
-- 2.How many days has each customer visited the restaurant?

        SELECT customer_id,
            count(distinct order_date) AS no_of_days
        FROM sales
        GROUP BY  customer_id
        ORDER BY  no_of_days desc

 

-- 3. What was the first item from the menu purchased by each customer?
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

 

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

        SELECT b.product_name,
                count(a.product_id) AS purchase_count
        FROM sales a
        INNER JOIN menu b
            ON a.product_id = b.product_id
        GROUP BY  b.product_name
        ORDER BY  purchase_count desc

 

-- 5. Which item was the most popular for each customer?

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



-- 6. Which item was purchased first by the customer after they became a member?

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



-- 7. Which item was purchased just before the customer became a member?

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

 

8. What is the total items and amount spent for each member before they became a member?

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

 















9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

with points_table AS 
	(SELECT b.customer_id,
		 c.product_name,
		c.price,
		
		CASE
		WHEN product_name = 'sushi' THEN
		c.price * 2
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

 






10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

with points_table AS 
	(SELECT b.customer_id,
		 a.join_date,
		 c.product_name,
		 c.price,
		
		CASE
		WHEN product_name = 'sushi' THEN
		c.price * 2
		WHEN b.order_date
		BETWEEN a.join_date
			AND (a.join_date + 6) THEN
		c.price * 2
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

 

BONUS QUESTIONS:

SELECT
  b.customer_id,
  b.order_date,
  c.product_name,
  c.price,
  CASE
    WHEN b.order_date<a.join_date THEN 'N'
    WHEN a.join_date IS NULL THEN 'N'
    WHEN b.order_date>=a.join_date THEN 'Y'
  END AS MEMBER
FROM
  members a
  RIGHT JOIN sales b ON a.customer_id=b.customer_id
  JOIN menu c ON b.product_id=c.product_id























WITH
  ranking AS (
    SELECT
      b.customer_id,
      b.order_date,
      c.product_name,
      c.price,
      CASE
        WHEN b.order_date<a.join_date THEN 'N'
        WHEN a.join_date IS NULL THEN 'N'
        WHEN b.order_date>=a.join_date THEN 'Y'
      END AS MEMBER
    FROM
      members a
      RIGHT JOIN sales b ON a.customer_id=b.customer_id
      JOIN menu c ON b.product_id=c.product_id
  )
SELECT
  *,
  CASE
    WHEN MEMBER='N' THEN NULL
    ELSE RANK() OVER (
      PARTITION BY
        customer_id,
        MEMBER
      ORDER BY
        order_date
    )
  END AS rankcalc
FROM
  ranking




https://8weeksqlchallenge.com/case-study-1/


		
