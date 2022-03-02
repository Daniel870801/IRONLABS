use olist;
--  From the order_items table, find the price of the highest priced order and lowest price order.
SELECT 
    MAX(price)
FROM
    order_items;
SELECT 
    MIN(price)
FROM
    order_items;

-- From the order_items table, what is range of the shipping_limit_date of the orders?
SELECT 
    DATEDIFF(MAX(shipping_limit_date),
            MIN(shipping_limit_date))
FROM
    order_items;

-- From the customers table, find the states with the greatest number of customers.
SELECT 
    customer_state, COUNT(customer_id) AS number_of_customers
FROM
    customers
GROUP BY customer_state
ORDER BY number_of_customers DESC;

--  From the customers table, within the state with the greatest number of customers, 
-- find the cities with the greatest number of customers.

SELECT customer_city, count(customer_id) as number_of_customers
FROM
	customers
WHERE
    customer_state='SP'
GROUP BY customer_city
ORDER BY number_of_customers 
DESC;

-- From the closed_deals table, how many distinct business segments are there (not including null)?
SELECT 
    COUNT(DISTINCT business_segment)
FROM
    closed_deals
WHERE
    business_segment IS NOT NULL;

-- From the closed_deals table, sum the declared_monthly_revenue for duplicate row values in business_segment 
-- and find the 3 business segments with the highest declared monthly revenue (of those that declared revenue).

select * from closed_deals;

SELECT 
    business_segment,
    SUM(declared_monthly_revenue) AS BS_revenue
FROM
    closed_deals
GROUP BY business_segment
ORDER BY BS_revenue DESC;

-- From the order_reviews table, find the total number of distinct review score values.

SELECT COUNT(DISTINCT review_score) FROM order_reviews;

-- In the order_reviews table, create a new column with a description that corresponds to each number category 
-- for each review score from 1 - 5, then find the review score and category occurring most frequently in the table.

ALTER TABLE order_reviews ADD COLUMN review_description VARCHAR(55) AFTER review_score;
UPDATE order_reviews SET review_description='Very bad' WHERE review_score=1;
UPDATE order_reviews SET review_description='Bad' WHERE review_score=2;
UPDATE order_reviews SET review_description='Average' WHERE review_score=3;
UPDATE order_reviews SET review_description='Good' WHERE review_score=4;
UPDATE order_reviews SET review_description='Very good' WHERE review_score=5;

SELECT 
    review_description, COUNT(review_description) AS frequency
FROM
    order_reviews
GROUP BY review_description
ORDER BY frequency DESC;