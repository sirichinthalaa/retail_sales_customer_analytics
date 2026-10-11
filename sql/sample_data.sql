USE retail_analytics;

-- 1. Customers table

INSERT INTO customers
(first_name, last_name, email, city, state, signup_date)
VALUES
('Rahul', 'Sharma', 'rahul@example.com', 'Hyderabad', 'Telangana', '2025-01-10'),
('Priya', 'Reddy', 'priya@example.com', 'Warangal', 'Telangana', '2025-02-15'),
('Arjun', 'Kumar', 'arjun@example.com', 'Bengaluru', 'Karnataka', '2025-03-20'),
('Sneha', 'Patel', 'sneha@example.com', 'Mumbai', 'Maharashtra', '2025-04-05'),
('Kiran', 'Rao', 'kiran@example.com', 'Hyderabad', 'Telangana', '2025-05-12'),
('Ananya', 'Das', 'ananya@example.com', 'Chennai', 'Tamil Nadu', '2025-06-18'),
('Vikram', 'Singh', 'vikram@example.com', 'Delhi', 'Delhi', '2025-07-22'),
('Meera', 'Nair', 'meera@example.com', 'Kochi', 'Kerala', '2025-08-09'),
('Rohit', 'Verma', 'rohit@example.com', 'Pune', 'Maharashtra', '2025-09-14'),
('Divya', 'Rao', 'divya@example.com', 'Hyderabad', 'Telangana', '2025-10-30'),
('Sanjay', 'Gupta', 'sanjay@example.com', 'Jaipur', 'Rajasthan', '2025-11-11'),
('Kavya', 'Reddy', 'kavya@example.com', 'Warangal', 'Telangana', '2025-12-01');


--  2. Products table

INSERT INTO products
(product_name, category, price, stock_quantity)
VALUES
('Laptop', 'Electronics', 55000.00, 20),
('Smartphone', 'Electronics', 25000.00, 35),
('Headphones', 'Electronics', 2000.00, 50),
('Office Chair', 'Furniture', 7500.00, 15),
('Study Table', 'Furniture', 6000.00, 12),
('Running Shoes', 'Fashion', 3000.00, 40),
('T-Shirt', 'Fashion', 800.00, 100),
('Backpack', 'Accessories', 1500.00, 60),
('Smartwatch', 'Electronics', 5000.00, 25),
('Water Bottle', 'Accessories', 500.00, 80),
('Keyboard', 'Electronics', 1800.00, 30),
('Desk Lamp', 'Home & Living', 1200.00, 45);

3. Orders table

INSERT INTO orders
(customer_id, order_date, order_status)
VALUES
(1, '2026-01-05 10:30:00', 'Delivered'),
(2, '2026-01-12 14:15:00', 'Delivered'),
(3, '2026-02-03 11:20:00', 'Delivered'),
(1, '2026-02-18 16:45:00', 'Delivered'),
(4, '2026-03-07 09:10:00', 'Delivered'),
(5, '2026-03-15 13:30:00', 'Delivered'),
(6, '2026-04-02 17:00:00', 'Delivered'),
(7, '2026-04-19 12:25:00', 'Cancelled'),
(8, '2026-05-08 15:40:00', 'Delivered'),
(9, '2026-05-21 10:05:00', 'Delivered'),
(2, '2026-06-11 11:50:00', 'Delivered'),
(10, '2026-06-25 18:20:00', 'Delivered'),
(3, '2026-07-04 09:35:00', 'Delivered'),
(11, '2026-07-16 14:00:00', 'Shipped'),
(12, '2026-08-09 16:10:00', 'Delivered'),
(1, '2026-08-22 12:00:00', 'Delivered'),
(5, '2026-09-03 10:45:00', 'Delivered'),
(6, '2026-09-14 13:15:00', 'Processing'),
(9, '2026-09-20 15:30:00', 'Delivered'),
(4, '2026-09-25 17:45:00', 'Pending');


4. Order items table

INSERT INTO order_items
(order_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 55000.00),
(1, 3, 2, 2000.00),
(2, 6, 1, 3000.00),
(2, 7, 3, 800.00),
(3, 2, 1, 25000.00),
(3, 9, 1, 5000.00),
(4, 3, 1, 2000.00),
(4, 8, 2, 1500.00),
(5, 4, 1, 7500.00),
(5, 12, 2, 1200.00),
(6, 5, 1, 6000.00),
(6, 10, 4, 500.00),
(7, 11, 2, 1800.00),
(7, 3, 1, 2000.00),
(8, 1, 1, 55000.00),
(9, 7, 2, 800.00),
(9, 8, 1, 1500.00),
(10, 2, 1, 25000.00),
(10, 3, 2, 2000.00),
(11, 6, 2, 3000.00),
(11, 10, 2, 500.00),
(12, 9, 1, 5000.00),
(12, 12, 1, 1200.00),
(13, 1, 1, 55000.00),
(13, 11, 1, 1800.00),
(14, 4, 2, 7500.00),
(14, 5, 1, 6000.00),
(15, 2, 1, 25000.00),
(15, 8, 2, 1500.00),
(16, 3, 3, 2000.00),
(16, 7, 2, 800.00),
(17, 5, 1, 6000.00),
(17, 12, 1, 1200.00),
(18, 6, 1, 3000.00),
(18, 10, 3, 500.00),
(19, 2, 1, 25000.00),
(19, 9, 1, 5000.00),
(20, 4, 1, 7500.00),
(20, 8, 1, 1500.00);

5. Payments table

INSERT INTO payments
(order_id, payment_date, payment_method, amount, payment_status)
VALUES
(1, '2026-01-05 10:35:00', 'UPI', 59000.00, 'Completed'),
(2, '2026-01-12 14:20:00', 'Credit Card', 5400.00, 'Completed'),
(3, '2026-02-03 11:25:00', 'Debit Card', 30000.00, 'Completed'),
(4, '2026-02-18 16:50:00', 'UPI', 5000.00, 'Completed'),
(5, '2026-03-07 09:15:00', 'Credit Card', 9900.00, 'Completed'),
(6, '2026-03-15 13:35:00', 'UPI', 8000.00, 'Completed'),
(7, '2026-04-02 17:05:00', 'Net Banking', 5600.00, 'Completed'),
(8, NULL, 'Credit Card', 55000.00, 'Failed'),
(9, '2026-05-08 15:45:00', 'UPI', 3100.00, 'Completed'),
(10, '2026-05-21 10:10:00', 'Credit Card', 29000.00, 'Completed'),
(11, '2026-06-11 11:55:00', 'UPI', 7000.00, 'Completed'),
(12, '2026-06-25 18:25:00', 'Debit Card', 6200.00, 'Completed'),
(13, '2026-07-04 09:40:00', 'Credit Card', 56800.00, 'Completed'),
(14, NULL, 'UPI', 21000.00, 'Pending'),
(15, '2026-08-09 16:15:00', 'Net Banking', 28000.00, 'Completed'),
(16, '2026-08-22 12:05:00', 'UPI', 7600.00, 'Completed'),
(17, '2026-09-03 10:50:00', 'Credit Card', 7200.00, 'Completed'),
(18, NULL, 'UPI', 4500.00, 'Pending'),
(19, '2026-09-20 15:35:00', 'Debit Card', 30000.00, 'Completed'),
(20, NULL, 'UPI', 9000.00, 'Pending');

6. Returns table

INSERT INTO returns
(order_item_id, return_date, return_reason, refund_amount, return_status)
VALUES
(3, '2026-01-20', 'Wrong size', 3000.00, 'Completed'),
(5, '2026-02-10', 'Damaged product', 25000.00, 'Completed'),
(10, '2026-03-20', 'Product not as expected', 2400.00, 'Approved'),
(15, '2026-04-25', 'Order cancelled before delivery', 55000.00, 'Rejected'),
(19, '2026-05-30', 'Defective product', 25000.00, 'Completed'),
(24, '2026-07-10', 'Wrong product delivered', 55000.00, 'Requested'),
(29, '2026-08-15', 'Size issue', 1500.00, 'Completed'),
(32, '2026-09-10', 'Quality issue', 6000.00, 'Approved');

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM payments;
SELECT * FROM returns;
