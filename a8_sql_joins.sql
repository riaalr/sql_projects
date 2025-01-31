--Maria Alrammah
use basketco;

--1.	How many customers have placed at least one order? 
select customer_id, count(order_id) as 'Order Count' --counting only customers who purchased at least one order
from xorder
group by customer_id --grouping by customer 

--2.	How many products have been rated as 5 at least one time?
select count (distinct product_id) as num_products_rated_5_stars--distinct becuase we dont want repeated products
from RATING
where rating_stars = 5 --filtering to 5 stars 

--3.	How many orders did employees 1 and 2 take in 2017 combined?  
select count(order_id) --counting how many orders the employees took
from employee inner join xorder --join tables
on employee.employee_id = xorder.taken_by_employee_id
where employee_id in (1,2) and year(pickup_date) = 2017 --specifying the year and employee 1 and 2 

--4.	How many orders were taken each month in the second half of 2017?  Sort the results chronologically.
select count(order_id) as 'Orders Taken', month(pickup_date) --counting how many orders were taken
from xorder
where year(pickup_date) = 2017 and month(pickup_date) >= 6  --specifying second half of 2017 in where line
group by month(pickup_date) --***whats on the group by should be on select line// we are grouping by month

--5.	What is the least popular product based on purchase history?  Report the name and product_ID.
select top 1 [name], count(quantity) --counting the quantity to determine least popular product
from product inner join PRODUCT_ORDER
on product.product_id = PRODUCT_ORDER.product_id
group by product.product_id, name
order by count(quantity) asc --ordering by asc because it is the LEAST popular

--6.	What is the busiest month of the year for orders based on purchase history?
select top 1 [name], count(quantity)  
from product inner join PRODUCT_ORDER
on product.product_id = PRODUCT_ORDER.product_id
group by product.product_id, name --we want to show the name of the product 
order by count(quantity) desc --ordering by desc because it is the MOST popular

--7.	What product has received the most ratings? Report the name and product_ID.
select top 1 [name], count(quantity) --counting the quantity
from product inner join PRODUCT_ORDER
on product.product_id = PRODUCT_ORDER.product_id
group by product.product_id, name --grouping by product name and ID
order by count(quantity) asc --ordering by asc because we want MOST ratings

--8.	What employees recorded more than 3 orders to be picked up in Nov. 2014?  Specify the employees full name. 
select fname, lname, count(order_id) as 'Orders Recorded'
from employee inner join xorder 
on employee.employee_id = xorder.taken_by_employee_id
where year(pickup_date) = 2014 and month(pickup_date) = '11' --specfiying month and year
group by employee_id, fname, lname --we want first and last name 
having count(order_id) > 3 --aggregating to more than 3 orders

--9.	What orders were for more than 9 items in total in 2016?
select sum(quantity), xorder.order_id --summing the quantity 
from xorder inner join PRODUCT_ORDER
on xorder.order_id = PRODUCT_ORDER.order_id
where year(pickup_date) = 2016 --specifying year 
group by xorder.order_id --grouping by order
having sum(quantity) > 9 --aggregatinig to more than 9 items 

--10.	What customers have 2 or more types of phone numbers recorded in the data?  Prepare a list of customer_ids.
select customer.customer_id, count(distinct customer_phone.xtype) --distinct because types of phone #'s can be repeated but we dont want it to repeat
from customer inner join CUSTOMER_PHONE
on customer.customer_id = customer_phone.customer_id
group by customer.customer_id
having count(distinct customer_phone.xtype) >= 2 --ex. they have a home and cellphone number

--11.	What customers have an office phone number in the 113 or 115 area code?  
select customer.customer_id, fname, lname
from customer inner join CUSTOMER_PHONE
on customer.customer_id = customer_phone.customer_id
where phone_number like '113%' or phone_number like  '115%' --doesnt have aggregation so it is on the WHERE line 
--% does not go in front because it is the area code
group by customer.customer_id, fname, lname --we are grouping Id, fname, and lname

--12.	What product has received the highest average rating?
select top 1 product.product_id, name, avg(CAST(rating_stars AS decimal(10,6))) --we are averaging and casting becuase we dont only want whole numbers
from rating inner join product
on rating.product_id = product.product_id
group by product.product_id, name --grouping by product and we want to display the name of the product too
order by avg(CAST(rating_stars AS decimal(10,6))) desc --we want to order by but it must have the same wording as the select line
--desc order becuase we want HIGHEST avg

--13.	What customers living in New York have placed 2 or more orders?
select customer.customer_id, count(order_id)
from customer inner join xorder
on customer.customer_id = xorder.customer_id
where xstate like 'NY' --specifying STATE
group by customer.customer_id --grouping by customer
having count(order_id) >= 2 --aggregating 2 or more orders

--14.	How many orders has each customer placed?
select customer.customer_id, fname, lname, count(xorder.order_id) as 'Orders Placed'
from customer left outer join xorder --we are asking for the results of the inner join but to look at the table to the left
--it is including every data from the left but the right can be NULL
on customer.customer_id = xorder.customer_id
group by customer.customer_id, fname, lname --grouping by id, fname, and lname
--The results show customers with 0 orders as well

--15.	What customers purchased cookies in both 2014 and 2015?  (Hint: There is one customer that did this.)
select customer.customer_id, count(distinct year(pickup_date)) 
from customer inner join xorder --first join
on customer.customer_id = xorder.customer_id
inner join PRODUCT_ORDER --second join
on XORDER.order_id = product_order.order_id
inner join PRODUCT --third join
on PRODUCT_ORDER.product_id = product.product_id
where [name] like '%cookie%' and (year(pickup_date) = 2014 or year(pickup_date)=2015) --when we write "and", the results will not include it unless all stmts are true
--we must put 2014 and 2015 in parenthesis cause it could be either
group by customer.customer_id --grouping by customers
having count(distinct year(pickup_date))=2 

--16.	What products were included in at least 20 different orders in 2016?  Specify the product names.
select product_id, count(distinct xorder.order_id) --showing the product ids and how many orders
from xorder inner join product_order
on xorder.order_id = product_order.order_id
where year(pickup_date) = 2016 --specifying year
group by product_id --grouping by product
having count(distinct xorder.order_id) >= 20 --at least 20 diff orders

--17.	What products had a total quantity sold greater than 70 in 2017? Specify the product names.
select product_id,  sum(quantity) --"total quantity" so we are summing// we also do not need to include "year" in select stmt
from xorder inner join product_order
on xorder.order_id = product_order.order_id
where year(pickup_date) = 2017 --specifying year
group by product_id --grouping by product
having sum(quantity) > 70 --greater than 70

--18.	From what city/state combinations have at least 3 orders been placed?
select xstate, city, count(xorder.order_id) --we want to show state, city, and amount of orders placed
from customer join xorder
on customer.customer_id = xorder.customer_id
group by xstate, city --we are grouping by state AND city
having count(xorder.order_id) >=3 --must be at least 3 orders

--19.	Generate a list of ALL customers, how many ratings each customer has submitted, the lowest rating for each customer, and the highest rating for each customer. 
select customer.customer_id,  fname, lname, count(rating_id), min(rating_stars), max(rating_stars)
from customer left outer join rating --customers that did and did not rate (WILL HAVE NULLS) but we want ALL customers
on customer.customer_id = rating.customer_id
group by customer.customer_id, fname, lname --must be on select and group by (BOTH)

--20. How many customers placed an order in 2015?
select customer.customer_id
from customer inner join xorder
on customer.customer_id = xorder.customer_id
where year(pickup_date)=2015 --specifying year
group by customer.customer_id --grouping by customer
