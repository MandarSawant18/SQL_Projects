# Case Study 2 - Pizza Runner
![](https://8weeksqlchallenge.com/images/case-study-designs/2.png)

View the case study [here](https://8weeksqlchallenge.com/case-study-2/)

## Introduction
Did you know that over 115 million kilograms of pizza is consumed daily worldwide??? (Well according to Wikipedia anyway…)

Danny was scrolling through his Instagram feed when something really caught his eye - “80s Retro Styling and Pizza Is The Future!”

Danny was sold on the idea, but he knew that pizza alone was not going to help him get seed funding to expand his new Pizza Empire - so he had one more genius idea to combine with it - he was going to Uberize it - and so Pizza Runner was launched!

Danny started by recruiting “runners” to deliver fresh pizza from Pizza Runner Headquarters (otherwise known as Danny’s house) and also maxed out his credit card to pay freelance developers to build a mobile app to accept orders from customers.

## Data Preview
- Table 1 - `runners`

    The runners table shows the registration_date for each new runner

    ![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/Table%201.png?raw=true)

- Table 2 - `customer_orders`

    Customer pizza orders are captured in the customer_orders table with 1 row for each individual pizza that is part of the order.

    The pizza_id relates to the type of pizza which was ordered whilst the exclusions are the ingredient_id values which should be removed from the pizza and the extras are the ingredient_id values which need to be added to the pizza.

    Note that customers can order multiple pizzas in a single order with varying exclusions and extras values even if the pizza is the same type!

    The exclusions and extras columns will need to be cleaned up before using them in your queries

    ![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/Table%202.png?raw=true)

- Table 3 - `runner_orders`

    After each orders are received through the system - they are assigned to a runner - however not all orders are fully completed and can be cancelled by the restaurant or the customer.

    The pickup_time is the timestamp at which the runner arrives at the Pizza Runner headquarters to pick up the freshly cooked pizzas. The distance and duration fields are related to how far and long the runner had to travel to deliver the order to the respective customer.

    There are some known data issues with this table so be careful when using this in your queries - make sure to check the data types for each column in the schema SQL!

    ![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/Table%203.png?raw=true)

- Table 4 - `pizza_names`

    At the moment - Pizza Runner only has 2 pizzas available the Meat Lovers or Vegetarian!

    ![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/Table%204.png?raw=true)

- Table 5 - `pizza_recipes`
    
    Each pizza_id has a standard set of toppings which are used as part of the pizza recipe.

    ![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/Table%205.png?raw=true)

- Table 6 - `pizza_toppings`

    This table contains all of the topping_name values with their corresponding topping_id value
    
    ![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/Table%206.png?raw=true)

## Entity Relationship Diagram
    
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/ER%20Diagram.png?raw=true)

## Case Study Questions
To ensure that every aspect of the business's operations is addressed and to derive effective insights, the case study has been split into four sections.

- Section A - Pizza Metrics
- Section B - Runner and Customer Experience
- Section C - Ingredient Optimisation
- Section D - Pricing and Ratings

## Case Study Solutions
[Section A](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Solution%20Files%20md/Section-A.md)\
[Section B](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Solution%20Files%20md/Section-B.md)\
[Section C](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Solution%20Files%20md/Section-C.md)\
[Section D](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Solution%20Files%20md/Section-D.md)

##
View other case studies [here](https://github.com/MandarSawant18/SQL_Projects/tree/main/Data%20with%20Danny%20SQL%20Challenge)

