# Case Study 3 - Foodie-Fi
![](https://8weeksqlchallenge.com/images/case-study-designs/3.png)

View the case study [here](https://8weeksqlchallenge.com/case-study-3/)

## Introduction
Subscription based businesses are super popular and Danny realised that there was a large gap in the market - he wanted to create a new streaming service that only had food related content - something like Netflix but with only cooking shows!

Danny finds a few smart friends to launch his new startup Foodie-Fi in 2020 and started selling monthly and annual subscriptions, giving their customers unlimited on-demand access to exclusive food videos from around the world!

Danny created Foodie-Fi with a data driven mindset and wanted to ensure all future investment decisions and new features were decided using data. This case study focuses on using subscription style digital data to answer important business questions.

## Data Preview
- Table 1 - `plans`

    Customers can choose which plans to join Foodie-Fi when they first sign up.

    Basic plan customers have limited access and can only stream their videos and is only available monthly at $9.90

    Pro plan customers have no watch time limits and are able to download videos for offline viewing. Pro plans start at $19.90 a month or $199 for an annual subscription.

    Customers can sign up to an initial 7 day free trial will automatically continue with the pro monthly subscription plan unless they cancel, downgrade to basic or upgrade to an annual pro plan at any point during the trial.

    When customers cancel their Foodie-Fi service - they will have a churn plan record with a null price but their plan will continue until the end of the billing period.

    ![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%203%20-%20Foodie-fi/Screenshots/Table%201.png?raw=true)

- Table 2 - `subscriptions`

    Customer subscriptions show the exact date where their specific plan_id starts.

    If customers downgrade from a pro plan or cancel their subscription - the higher plan will remain in place until the period is over - the start_date in the subscriptions table will reflect the date that the actual plan changes.

    When customers upgrade their account from a basic plan to a pro or annual pro plan - the higher plan will take effect straightaway.

    When customers churn - they will keep their access until the end of their current billing period but the start_date will be technically the day they decided to cancel their service.

    ![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%203%20-%20Foodie-fi/Screenshots/Table%202.png?raw=true)

## Entity Relationship Diagram
    
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%203%20-%20Foodie-fi/ER%20Diagram.png?raw=true)

## Case Study Questions
To ensure that every aspect of the business's operations is addressed and to derive effective insights, the case study has been split into different sections.

- Section A - Customer Journey
- Section B - Data Analysis Questions

## Case Study Solutions
[Section A](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%203%20-%20Foodie-fi/Solution%20files%20md/Section-A.md)\
[Section B](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%203%20-%20Foodie-fi/Solution%20files%20md/Section-B.md)

##
View other case studies [here](https://github.com/MandarSawant18/SQL_Projects/tree/main/Data%20with%20Danny%20SQL%20Challenge)

