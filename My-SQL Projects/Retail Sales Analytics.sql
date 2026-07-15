-- CREATE DATABASE--

create database retail_sales;
use retail_sales;

-- CREATE CUSTOMERS TABLE --

create table customers(customer_id int primary key, customer_name varchar(50),gender varchar(10),age int,city varchar(50));

-- INSERT CUSTOMER DATA --

insert into customers values
(101,'Asha','Female',24,'Kochi'),
(102,'Rahul','Male',30,'Thrissur'),
(103,'Anjali','Female',28,'Kozhikode'),
(104,'Arjun','Male',35,'Kannur'),
(105,'Meera','Female',27,'Kochi'),
(106,'Nikhil','Male',31,'Palakkad'),
(107,'Sneha','Female',29,'Malappuram'),
(108,'Vishnu','Male',26,'Ernakulam'),
(109,'Riya','Female',23,'Alappuzha'),
(110,'Adithya','Male',33,'Kollam');

-- CREATE PRODUCTS TABLE --

create table products (
    product_id int primary key,
    product_name varchar(50),
    category varchar(30),
    brand varchar(30),
    price decimal(10,2),
    stock int
);

-- INSERT PRODUCTS --

insert into products values
(201,'Laptop','Electronics','Dell',55000,25),
(202,'Smartphone','Electronics','Samsung',28000,40),
(203,'Headphones','Electronics','Boat',1500,80),
(204,'Running Shoes','Fashion','Nike',4500,35),
(205,'T-Shirt','Fashion','Puma',900,100),
(206,'Backpack','Accessories','Skybags',1800,50),
(207,'Smart Watch','Electronics','Noise',3500,60),
(208,'Water Bottle','Accessories','Milton',500,120),
(209,'Office Chair','Furniture','GreenSoul',8500,15),
(210,'Study Table','Furniture','IKEA',6500,20);

-- CREATE ORDER TABLE --

create table orders (
    order_id int primary key,
    customer_id int,
    order_date date,
    payment_method varchar(20),
    foreign key (customer_id) references customers(customer_id)
);

-- INSERT ORDERS --

insert into orders values
(1001,101,'2026-01-05','UPI'),
(1002,102,'2026-01-07','Card'),
(1003,103,'2026-01-10','Cash'),
(1004,104,'2026-01-12','UPI'),
(1005,105,'2026-01-15','Card'),
(1006,106,'2026-01-18','UPI'),
(1007,107,'2026-01-20','Cash'),
(1008,108,'2026-01-22','Card'),
(1009,109,'2026-01-25','UPI'),
(1010,110,'2026-01-28','Card');

-- CREATE ORDER ITEMS TABLE

create table order_items (
    order_item_id int primary key,
    order_id int,
    product_id int,
    quantity int,
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

-- INSERT ORDER ITEMS --

insert into order_items values
(1,1001,201,1),
(2,1001,203,2),
(3,1002,202,1),
(4,1003,205,3),
(5,1004,204,2),
(6,1005,207,1),
(7,1006,206,2),
(8,1007,208,5),
(9,1008,210,1),
(10,1009,209,1),
(11,1010,202,2),
(12,1010,203,1);

-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-- View All Customers --
select*from customers;

-- View All Products --
select*from products;

-- View All Orders --
select*from orders;

-- View All Order Items --
select*from order_items;

-- Display Customer Name and City --
select customer_name,city from customers;

-- Display Electronic Products --
select*from products where category='Electronics';

-- Products Cost more than RS.5000 --
select*from products where price>5000;

-- sort products by price (Highest First)
select*from products order by price desc;

-- Count Total Customers --
select count(*) as total_customers from customers;

-- Count Total Products --
select count(*) as total_products from products;

-- Calculate Inventory Vaqlue --
select sum(price*stock)as inventory_value from products;

-- Total Revenue Generated --
select sum(oi.quantity*p.price) as total_revenue from order_items oi join products p on oi.product_id =p.product_id;

-- Total Revenue by Category --
select sum(oi.quantity*p.price) as total_revenue from order_items oi join products p on oi.product_id =p.product_id group by p.category;

-- Total Stock Available --
select sum(stock)as total_stock from products;

-- Customers Orders (INNER JOIN) --
select o.order_id,c.customer_name,o.order_date from orders o inner join customers c on o.customer_id=c.customer_id;

-- Best Selling Products --
select p.product_name,sum(oi.quantity)as total_quantity from products p join order_items oi on oi.product_id =p.product_id group by p.product_name order by total_quantity desc; 

-- Revenue by City --
select c.city, SUM(p.price * oi.quantity) as revenue from customers c join orders o on c.customer_id = o.customer_id join order_items oi on o.order_id = oi.order_id join  products p on oi.product_id = p.product_id group by c.city order by revenue desc;

-- Customers who Placed more than One Order --
select customer_id, COUNT(order_id) as total_orders from orders group by customer_id having COUNT(order_id) > 1;

-- Products Never Ordered (LEFT JOIN)
select p.product_name from products p left join order_items oi on p.product_id = oi.product_id where oi.product_id is null;

-- Customer Lifetime Value (CLV) --
select c.customer_name, SUM(p.price * oi.quantity) as lifetime_value from customers c join orders o on c.customer_id = o.customer_id join order_items oi on o.order_id = oi.order_id join products p on oi.product_id = p.product_id group by c.customer_name order by lifetime_value desc;

-- Monthly Sales Trend --
select DATE_FORMAT(o.order_date,'%Y-%m') as month, SUM(p.price * oi.quantity) as revenue from orders o join order_items oi on o.order_id = oi.order_id join products p on oi.product_id = p.product_id group by month;








