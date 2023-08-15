--PIZZA SALES QUERY

select *
from pizza_sales

--To calculate sum of total price
select sum(total_price) as Total_Revenue
from pizza_sales

--The avg amount spent per order,cal by div the total revenue by total no. of orders
select sum(total_price) / count(distinct order_id) as Avg_order_value
from pizza_sales

--The sum of quantities of all pizzas sold
select count(quantity) as Total_pizza_sold
from pizza_sales

--The total no. of orders placed
select count(distinct order_id) as order_placed
from pizza_sales

--The avg no. of pizzas sold per order, cal by div the total no. of pizzas sold by total no. of orders
select CAST(CAST(count(quantity) as decimal(10,2)) / CAST(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as Avg_pizza_sold_per_order
from pizza_sales

--For excel charts(visuals)

--Daily Trend for total orders
select DATENAME(dw, order_date) as order_day, count(distinct order_id) as Total_orders
from pizza_sales
group by DATENAME(dw, order_date)

--Hourly Trend
select DATEPART(HOUR, order_time) as order_time,count(distinct Order_id) as Total_orders
from pizza_sales
group by DATEPART(HOUR, order_time)
order by datepart(hour, order_time)

--Percentage of sales by pizza category
select pizza_category,sum(total_price) as Total_sales, sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as Total_sales_category_percent
from pizza_sales
group by pizza_category

--To see the pizza_category sales by particular month
select pizza_category,sum(total_price) as Total_sales, sum(total_price) * 100 / (select sum(total_price) from pizza_sales where month(order_date) = 1) as Total_sales_category_percent
from pizza_sales
where month(order_date) = 1-->(1 indicates January month)
group by pizza_category

--Percentage of sales by pizza size
select pizza_size,cast(sum(total_price) as decimal(10,2)) as Total_sales, cast(sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as decimal(10,2)) as sales_pizza_size_percent
from pizza_sales
group by pizza_size
order by sales_pizza_size_percent desc

--first quarter
select pizza_size,cast(sum(total_price) as decimal(10,2)) as Total_sales, cast(sum(total_price) * 100 / (select sum(total_price) from pizza_sales where datepart(quarter, order_date)=1) as decimal(10,2)) as sales_pizza_size_percent
from pizza_sales
where datepart(quarter, order_date)=1
group by pizza_size
order by sales_pizza_size_percent desc

--toal pizas sold by pizza category
select pizza_category, sum(quantity) as total_pizzas_sold
from pizza_sales
group by pizza_category
order by total_pizzas_sold desc

--Top 5 best sellers by total pizzas sold
select top 5 pizza_name, sum(quantity) as total_pizzas_sold
from pizza_sales
group by pizza_name
order by sum(quantity) desc 

--bottom 5 worst sellers by total pizzas sold
select top 5 pizza_name, sum(quantity) as total_pizzas_sold
from pizza_sales
group by pizza_name
order by sum(quantity) asc 

--bottom 5 worst sellers by total pizzas sold in first month
select top 5 pizza_name, sum(quantity) as total_pizzas_sold
from pizza_sales
where month(order_date) = 1
group by pizza_name
order by sum(quantity) asc