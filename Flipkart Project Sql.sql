--  Which region generates the highest total sales revenue, and how do sales trends vary
 -- across different regions?

select region, sum(total_sales) as sales, 
sum(total_profit) as profit
from orders
group by region
order by profit desc;

-- top payment methodes uses by customers to place orders by spending.

select payment_method, sum(total_sales) 
as total_sales
from orders
group by payment_method
order by total_sales;

--  Which payment method contributes the most to total transactions and revenue, and how
--  do customer preferences differ by region or order value?

select region, payment_method, sum(total_sales) 
as sales
from orders
group by region, payment_method
order by sales desc
limit 5;

--  What are the peak hours of customer purchases during the day, and how does order
--  volume fluctuate hourly?

select hour, count(*) as volume, max(total_sales) as sales
from orders
group by hour
order by hour asc;

--  What is the current distribution of order statuses (Delivered, Shipped, Pending, Returned),
--  and what percentage of total orders are successfully delivered?

select order_id, customer_id, shipping_address, total_sales as price,
case 
when delivery_status = 'Delivered' then 'Successfull' 
when delivery_status = 'Shipped' then 'On the way'
when delivery_status = 'Returned' then 'Failed'
else 'Pending' end as distribution
from orders;

select delivery_status, count(*) as total_orders,
round(count(*) * 100.0 / sum(count(*))
over(),2) as percentage
from orders
group by delivery_status
order by total_orders desc;

--  During which month and hour does the platform experience peak sales activity, and are
--  there any recurring seasonal trends?

select monthname(order_date) as month_name, 
count(*) as total_orders, sum(total_sales) as peak_sales
from orders
group by month_name;

select hour, count(*) as volume, max(total_sales) as sales
from orders
group by hour
order by hour asc;

--  Which region demonstrates the highest successful order delivery rate, and how does
--  delivery performance compare across regions?

select region, 
sum(case when delivery_status = 'Delivered' then 1 else 0 end) as Successfull,
sum(case when delivery_status = 'Shipped' then 1 else 0 end) as On_the_way,
sum(case when delivery_status = 'Returned' then 1 else 0 end) as Failed,
sum(case when delivery_status = 'Pending' then 1 else 0 end) as Yet_to_ship
from orders
group by region;
