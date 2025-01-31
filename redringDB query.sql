--Maria Alrammah
--Assignment 7
Use redringDB;

--1 // How many table orders have been placed in total?
select count(order_id) --total number
from table_order

--2 // How many table orders were placed between October 23, 2020 and October 30, 2020, inclusively?
select order_id, order_datetime
from table_order
where order_datetime between 'October 23,2020' and 'October 30, 2020' --between stmt 

--#3 // How many table orders were placed on or before September 30, 2018? (Hint: The resulting value is 5000+.)
select count(order_id) --counting how mnay order
from table_order
where order_datetime <= 'September 30, 2018' --must before or on september 30, 2018

--#4 // How many items have been ordered in total?
select sum(quantity) --finds the sum of items
from lineitem --what table we are retrieving the data from 

--5 // How many items have been ordered in total by customers with a loyalty card? 
select count(order_id)
from lineitem
where loyaltycard_number is not null --we write "not null" because we want the ones who do have a loyalty card 

--6 // What menu items are in menu category 1 “Small Eats” ?
select [name], category_id
from menuitem
where category_id = 1 --how many items are specifically in category 1

--7 // What is the average price for menu items in category 2?
select avg(price) --use "avg"
from menuitem
where category_id = 2 --specifying the category ID

--8 // How many menu items have the word “cheese” anywhere in the description (the entire word or as part of word)?
select count(item_id)
from menuitem
where [name] like '%cheese%' --% indicates it can have words after or before it

--9 // What were the minimum, maximum, and average credit card payment amounts (payment types 1, 2, 3, and 4)?  
select min(payment_amount), max(payment_amount), avg(payment_amount)
from payment 
where pt_id between 1 and 4 --specifiying what payment types we want to display

--10 // How many loyalty card members are in each customer type?
select ct_id, count(loyaltycard_number)
from loyal_customer
group by ct_id --grouping the data based on customer type

--11 // How many orders were taken each month in the first half of 2019?  Display the results chronologically.
select count(order_id) 
from table_order
where year(order_datetime) = 2019 and month(order_datetime) <= 6  --never use between with DATES
group by month(order_datetime)

--12 // What is the average payment amount for each payment type ordered from high to low based on the average?
select pt_id, avg(payment_amount) 
from payment 
group by pt_id --grouping the data based on payment type
order by avg(payment_amount) desc --"desc" because we want it from high to low

--13 // What is the total of all of the cash payments?
select sum(payment_amount) --use sum to find the total number
from payment 
where pt_id = 6 --6 is the ID for cash payments

--14 // What loyal customer number purchased the most items and how many did he/she purchase? 
select top 1 loyaltycard_number, sum(quantity) as 'Sum of quantity'     
from lineitem
where loyaltycard_number is not null
group by loyaltycard_number 
order by sum(quantity) desc --desc will show who purchased the most
--we must use top and desc TOGETHER

--15 // How many loyal customers are not from the zip codes of 15209, 15210, or 15250?
select count(loyaltycard_number)
from loyal_customer
where zip not in (15209, 15210, 15250) --NOT in these zipcodes

--16 // What is the least popular menu item among all customers (based on the total quantity purchased of each menu item)?
select top 1 item_id, sum(quantity) --how we are measuring popularity 
as 'Quantity Purchased' 
from LINEITEM 
group by item_id  
order by 'Quantity Purchased'

--17// During what months in 2019 did the total quantity of orders exceed 200? 
select month(order_datetime), count(order_id)
from table_order
where year(order_datetime) = 2019 --we must filter the raw data
group by month(order_datetime) --we are grouping the data by month
having count(order_id)>200 --we have to filter an aggregated value (EXCEED 200) 
--january and april is exceeding 200

--18 // What loyal customer numbers have purchased at least four out of these seven item_IDs: 12, 13, 14, 15, 30, 31, 32? (Hint: There are three rows in the results.)
select loyaltycard_number, count (distinct item_id) --its distinct because we only want to see if a customer purchased an item/doesnt matter how many times
from lineitem
where item_id IN (12,13,14,15,30,31,32) 
AND loyaltycard_number is not null --is not null because we only want loyalty customers/// we CONNECT it with AND 
--specifying the item ids
group by loyaltycard_number 
having count(distinct item_id) >= 4 ----at least four of of the seven item id's 
-- HAVING IS FILTERING ON AN AGGREGATE

--19 // How many menu items have the word salad in it? 
select item_id, name --we want to see our salad options
from menuitem
where [name] like '%salad%' --words can come either before or after the word salad 

