TASK 1
Calculate total sales for each order
Business question: How much money is represented by the products in each order?

SELECT order_id, SUM(quantity*unit_price) AS order_total
FROM order_items 
GROUP BY order_id
ORDER BY order_id;

TASK 2
Calculate total value by product
Business question: Which products generate the highest value in orders?

SELECT p.product_name, SUM(oi.quantity) AS total_quantity, SUM(oi.quantity*oi.unit_price) AS total_value
FROM products AS p JOIN order_items AS oi 
ON p.product_id = oi.product_id 
GROUP BY p.product_id, p.product_name 
ORDER BY total_value DESC;

Task 3
Calculate monthly sales
Business question: How does the companys order value change from month to month?

SELECT
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date)
ORDER BY
    order_year,
    order_month;


Task 4:
Customer Spending Analysis
Find the total amount spent by each customer and rank customers from highest to lowest spending.

SELECT c.customer_id, CONCAT(c.first_name,' ', c.last_name) AS customer_name, SUM(oi.quantity * oi.unit_price) AS Total_Spending
FROM customers AS c JOIN orders AS o
ON c.customer_id = o.customer_id
JOIN order_items AS oi 
ON o.order_id = oi.order_id
WHERE o.order_status='Delivered'
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY Total_Spending DESC;

Task 5: 
Find Customers Who Have Never Placed an Order

SELECT c.customer_id, CONCAT(c.first_name,' ',c.last_name) AS customer_name, c.city, c.signup_date
FROM customers AS c LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

Task 6:
Find the Top 5 Highest-Spending Customers

SELECT c.customer_id, CONCAT(c.first_name,' ',c.last_name) AS customer_name, SUM(oi.quantity * oi.unit_price) AS Total_Spending
FROM customers AS c JOIN orders AS o
ON c.customer_id = o.customer_id
JOIN order_items AS oi
ON o.order_id = oi.order_id
GROUP BY  
	c.customer_id,
    c.first_name,
    c.last_name
ORDER BY Total_Spending DESC LIMIT 5;

Task 7: 
Find Products That Have Never Been Ordered

SELECT p.product_id, p.product_name, p.category, p.price 
FROM products AS p LEFT JOIN order_items AS oi
ON p.product_id = oi.product_id
WHERE oi.order_item_id IS NULL
ORDER BY p.product_name;


Task 8: 
Find the Best-Selling Product in Each Category

WITH product_sales AS (
    SELECT
        p.category,
        p.product_id,
        p.product_name,
        SUM(oi.quantity) AS total_quantity_sold
    FROM products AS p
    JOIN order_items AS oi
        ON p.product_id = oi.product_id
    GROUP BY
        p.category,
        p.product_id,
        p.product_name
),
ranked_products AS (
    SELECT
        category,
        product_id,
        product_name,
        total_quantity_sold,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY total_quantity_sold DESC
        ) AS rn
    FROM product_sales
)
SELECT
    category,
    product_name,
    total_quantity_sold
FROM ranked_products
WHERE rn = 1
ORDER BY category;


Task 9: 
Calculate Monthly Sales Growth

WITH monthly_sales AS (
    SELECT
        YEAR(o.order_date) AS sales_year,
        MONTH(o.order_date) AS sales_month,
        SUM(oi.quantity * oi.unit_price) AS monthly_sales
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    GROUP BY
        YEAR(o.order_date),
        MONTH(o.order_date)
),
sales_comparison AS (
    SELECT
        sales_year,
        sales_month,
        monthly_sales,
        LAG(monthly_sales) OVER (
            ORDER BY sales_year, sales_month
        ) AS prev_month_sales
    FROM monthly_sales
)
SELECT
    sales_year,
    sales_month,
    monthly_sales,
    prev_month_sales,
    ROUND(
        ((monthly_sales - prev_month_sales)
        / NULLIF(prev_month_sales, 0)) * 100,
        2
    ) AS growth_percentage
FROM sales_comparison
ORDER BY sales_year, sales_month;


Task 10: 
Find Customers Who Place More Orders Than Average

WITH customer_orders AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COUNT(o.order_id) AS total_orders
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
)
SELECT
    customer_id,
    customer_name,
    total_orders
FROM customer_orders
WHERE total_orders > (
    SELECT AVG(total_orders)
    FROM customer_orders
)
ORDER BY total_orders DESC;

Task 11: 
Find Each Customers Most Recent Order

WITH most_recent_orders AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        o.order_id,
        o.order_date,
        o.order_status
    FROM customers AS c
    LEFT JOIN orders AS o
        ON c.customer_id = o.customer_id
),
ranked_orders AS (
    SELECT
        customer_id,
        customer_name,
        order_id,
        order_date,
        order_status,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_date DESC, order_id DESC
        ) AS rn
    FROM most_recent_orders
)
SELECT
    customer_id,
    customer_name,
    order_id,
    order_date,
    order_status
FROM ranked_orders
WHERE rn = 1
ORDER BY customer_id;

Task 12: 
Identify Customers Who Purchased from Multiple Product Categories


SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(DISTINCT p.category) AS category_count
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Delivered'
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING COUNT(DISTINCT p.category) > 1
ORDER BY category_count DESC;

Task 13: 
Calculate Total Revenue for Each Product Category

SELECT 
	p.category, 
	SUM(oi.quantity) AS total_products_sold, SUM(oi.quantity * oi.unit_price) total_revenue
FROM products as p 
JOIN order_items AS oi
	ON p.product_id = oi.product_id
JOIN orders AS o
	ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY  p.category
ORDER BY total_revenue DESC;

Task 14: 
Analyze Payment Statuses

SELECT payment_status, COUNT(payment_id) AS total_payments, SUM(amount) AS total_amount
FROM payments
GROUP BY payment_status
ORDER BY total_payments DESC;

Task 15: 
Analyze Product Returns and Refunds

SELECT return_status, COUNT(return_id) AS total_returns, SUM(refund_amount) AS total_refund_amount
FROM returns 
GROUP BY return_status
ORDER BY total_refund_amount DESC;

Which retuen reasons occur most frequently?
SELECT COUNT(return_id) AS total_returns, return_reason
FROM returns 
GROUP BY return_reason
ORDER BY total_returns DESC;

Task 16: 
Analyze Monthly Customer Signups

SELECT 
DATE_FORMAT(signup_date, '%Y-%m') AS signup_date,
COUNT(customer_id) AS total_new_customers
FROM customers
GROUP BY signup_date
ORDER BY signup_date;

Task 17: 
Identify Repeat Customers

SELECT c.customer_id, 
CONCAT(c.first_name, ' ', c.last_name) AS customer_name, COUNT(order_id) AS total_orders
FROM customers AS c JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(order_id) > 1
ORDER BY total_orders DESC;

Task 18: 
Find the Products Generating the Highest Revenue

SELECT 
p.product_id, p.product_name, 
p.category, SUM(oi.quantity) AS total_quantity_sold, 
SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM products AS p JOIN order_items AS oi
ON p.product_id = oi.product_id
JOIN orders AS o
ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC LIMIT 5;


Task 19: 
Customer Segmentation Based on Spending and Order Frequency

WITH customer_summary AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COUNT(DISTINCT o.order_id) AS total_orders,
        COALESCE(
            SUM(oi.quantity * oi.unit_price), 0
        ) AS total_spending
    FROM customers AS c
    LEFT JOIN orders AS o
        ON c.customer_id = o.customer_id
        AND o.order_status = 'Delivered'
    LEFT JOIN order_items AS oi
        ON o.order_id = oi.order_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
)
SELECT
    customer_id,
    customer_name,
    total_orders,
    total_spending,
    CASE
        WHEN total_spending >= 50000
             AND total_orders >= 2
            THEN 'High-Value Customer'

        WHEN total_spending >= 50000
             AND total_orders < 2
            THEN 'Big Spender'

        WHEN total_spending < 50000
             AND total_orders >= 2
            THEN 'Loyal Customer'

        ELSE 'Occasional Customer'
    END AS customer_segment
FROM customer_summary
ORDER BY total_spending DESC;

Task 20: 
What is the payment success situation?

SELECT
    payment_status,
    COUNT(payment_id) AS total_payments,
    SUM(amount) AS total_amount
FROM payments
GROUP BY payment_status
ORDER BY total_payments DESC;