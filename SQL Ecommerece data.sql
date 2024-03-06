-- (Join)Retrieve customer names and their corresponding order details.


SELECT C.customer_name, O.order_id, O.order_date, O.payment, O.delivery_date
FROM customers C
JOIN orders O ON C.customer_id = O.customer_id;


-- (Join)Get product details for each sale.


SELECT S.sales_id, P.product_id, P.product_type, P.product_name, P.size, P.Colour, P.price, P.quantity, P.description
FROM Products P
JOIN Sales S ON S.product_id = P.product_id;


-- (Subqueries) Find customers who made an order in a specific date range.


SELECT C.customer_name, O.order_date
FROM customers C
JOIN orders O ON O.customer_id = C.customer_id 
WHERE C.customer_id IN (SELECT customer_id FROM orders WHERE order_date BETWEEN '2021-01-01' AND '2021-12-31')
ORDER BY O.order_date Desc;


-- (Subqueries) Retrieve sales with quantities greater than the average quantity.


SELECT *
FROM sales
WHERE quantity > (SELECT Avg(quantity) FROM sales);


-- (Aggregation) Find the total sales for each customer.


Select C.customer_name, Sum(S.total_price) as Total_Sales
From Customers C
Join Orders O ON C.customer_id = O.customer_id
Join Sales S On S.order_id = O.order_id
Group by C.customer_name;


-- Identify high-value customers based on total spending.


Select C.customer_name, Sum(S.total_price) as total_spending
from customers C
Join orders O ON C.customer_id = O.customer_id
Join Sales S ON S.order_id = O.order_id
group by customer_name
order by 2 desc;


-- Identify high-value customers with spending value greater than 1000


Select C.customer_name, Sum(S.total_price) as total_spending
from customers C
Join orders O ON C.customer_id = O.customer_id
Join Sales S ON S.order_id = O.order_id
group by customer_name
HAVING SUM(S.total_price) > 1000
order by total_spending desc;


-- Find the average quantity sold per product.


Select P.product_name, AVG(S.quantity) as AvgQuantity
From products P
Join Sales S On S.product_id = P.product_id
Group by P.product_name 
order by AVG(S.quantity) Desc;

-- Find products with quantities sold and their total sales:


Select P.product_name, Sum(S.quantity) as Total_QTY, Sum(S.total_price) As Total_sales
From Products P
Join Sales S ON S.product_id = P.product_id
Group by P.product_name
order by Sum(S.quantity) Desc;


-- Get the latest order details for each customer:


Select C.customer_name, Max(O.order_date) as Latest_Order_date
from customers C
Join orders O ON C.customer_id = O.customer_id
group by C.customer_name;


-- Identify customers who haven't placed any orders:


SELECT C.customer_name, Count(O.order_id) As Number_of_orders
FROM customers C
LEFT JOIN orders O ON C.customer_id = O.customer_id
WHERE O.customer_id IS NULL
group by C.customer_name;


-- Retrieve product details and their sales using a subquery:


SELECT ProductSales.product_name, ProductSales.quantity, ProductSales.total_price
FROM (SELECT P.product_name, S.quantity, S.total_price
      FROM products P
      JOIN sales S ON P.product_id = S.product_id) AS ProductSales;


-- Retrieve the top 5 selling products based on total sales

 
Select TOP 5 P.product_name, Sum(S.total_price) as Total_sales 
From products P
Join Sales S ON P.product_id = S.product_id
Group by product_name
Order by Total_sales Desc;


-- List customers and their total spending, sorted by total spending


Select C.customer_name,SUM(S.total_price) AS Total_Spending
From Customers C
Join Orders O ON C.customer_id = O.customer_id
Join Sales S ON O.order_id = S.order_id
group by C.customer_name
order by Total_Spending desc;


-- Retrieve products and their details for a specific order


SELECT P.product_name, S.order_id, P.size, P.colour, S.quantity
FROM products P
JOIN sales S ON P.product_ID = S.product_id
WHERE S.order_id = 1;


-- Find the customer who made the most orders


SELECT Top 1 C.customer_name, COUNT(O.order_id) AS Number_of_orders
FROM customers C
JOIN orders O ON C.customer_id = O.customer_id
GROUP BY C.customer_name
ORDER BY Number_of_orders DESC


-- List products with their sales details and filter by a specific colour


SELECT P.product_name, P.colour, S.quantity, S.total_price, S.price_per_unit
FROM products P
JOIN sales S ON P.product_ID = S.product_id
WHERE P.colour = 'red';


-- Find orders placed in the same city


SELECT C.customer_name, C.city, O.order_id
FROM customers C
JOIN Orders O ON C.customer_id = O.customer_id
WHERE city = 'Johnstonhaven';


-- List products and their total sales where the quantity sold is more than 2


SELECT P.product_name, Sum(S.quantity) As Total_QTY, SUM(S.total_price) AS Total_Sales
FROM products P
JOIN sales S ON S.product_id = P.product_ID
WHERE S.quantity > 2
GROUP BY P.product_name
ORDER BY Total_QTY ASC;


-- List the products with their highest and lowest quantities sold per order


SELECT P.product_name, MAX(S.quantity) AS max_quantity_ordered, MIN(S.quantity) AS min_quantity_ordered
FROM products P
JOIN sales S ON P.product_ID = S.product_id
GROUP BY product_name;