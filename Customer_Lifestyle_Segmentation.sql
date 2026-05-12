CREATE DATABASE customer_project;
USE customer_project;

CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    city VARCHAR(50),
    country VARCHAR(50),
    signup_date DATE
);

CREATE TABLE orders (
    order_id VARCHAR(20),
    customer_id VARCHAR(10),
    order_date DATE,
    product_category VARCHAR(50),
    quantity INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    discount_pct DECIMAL(5,2),
    net_amount DECIMAL(10,2),
    order_status VARCHAR(20),
    channel VARCHAR(20)
);

SELECT * FROM orders;

SELECT * FROM customers;

ALTER TABLE orders
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);


-- View all customers
SELECT * FROM customers;

-- Customers from Pune
SELECT * FROM customers
WHERE city = 'Pune';

-- Orders with net amount greater than 5000
SELECT * FROM orders
WHERE net_amount > 5000;

-- Total number of customers
SELECT COUNT(*) AS total_customers FROM customers;

-- Total revenue
SELECT SUM(net_amount) AS total_revenue FROM orders;

-- Average order value
SELECT AVG(net_amount) AS avg_order_value FROM orders;

-- Total orders per customer
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id;

-- Customer name with their orders
SELECT c.customer_name, o.order_id, o.net_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;
-- Total spending per customer
SELECT c.customer_name, SUM(o.net_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- Customers with no orders
SELECT c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Top 5 customers by spending
SELECT customer_id, SUM(net_amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- Revenue by product category
SELECT product_category, SUM(net_amount) AS revenue
FROM orders
GROUP BY product_category;

-- Orders by channel (Online/Offline)
SELECT channel, COUNT(*) AS total_orders
FROM orders
GROUP BY channel;

-- Monthly revenue trend
SELECT MONTH(order_date) AS month, SUM(net_amount) AS revenue
FROM orders
GROUP BY MONTH(order_date)
ORDER BY month;

-- Rank customers by spending
SELECT customer_id,
       SUM(net_amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(net_amount) DESC) AS rank
FROM orders
GROUP BY customer_id;

-- Top customer in each city
SELECT city, customer_name, total_spent
FROM (
    SELECT c.city, c.customer_name,
           SUM(o.net_amount) AS total_spent,
           RANK() OVER (PARTITION BY c.city ORDER BY SUM(o.net_amount) DESC) AS rnk
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.city, c.customer_name
) t
WHERE rnk = 1;
 
-- Customers with above average spending
SELECT customer_id, SUM(net_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING total_spent > (SELECT AVG(net_amount) FROM orders);

--  Repeat customers (more than 1 order)
SELECT customer_id, COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;

-- Revenue after discount impact
SELECT SUM(total_amount) AS total_before_discount,
       SUM(net_amount) AS total_after_discount
FROM orders;

-- Order status distribution
SELECT order_status, COUNT(*) AS count
FROM orders
GROUP BY order_status;


