--in class 11/16/2021 practice using JOINS
use flowerdb;

--we can only join tables with existing relationships

--join between customer and order_header
select *
from customer inner join order_header
on customer.customerID = order_header.customerID --what is the relationship
--result gives us 20 ROWS

select * from order_header --has 20 rows

select * from customer --has 7 rows 

--join between customer, order_header, and order_item (WE MUST START FROM THE END)
select *
from customer inner join order_header
on customer.customerID = order_header.customerID
inner join order_item --adding a 3rd 
on order_header.orderID = order_item.orderID --order header and order item are related through ORDER ID
--49 rows// 49 ordered items

--how many items did each customer (by name) purchase?
select customer.customerID, fname, lname, sum(quantity) as total_quantity_sold --how many did they PURCHASE
from customer inner join order_header
on customer.customerID = order_header.customerID
inner join order_item --adding a 3rd 
on order_header.orderID = order_item.orderID 
group by customer.customerID, fname, lname --we must specify "customer" table because it wont know which table to pull customer id from
--we will use the group by stmt in our SELECT STMT TOO

--what is the total quantity sold of each item (by name)?
select item.itemID, name, sum(quantity) as total_quantity_sold
from item inner join order_item
on item.itemID = order_item.itemID
group by item.itemID, name --GROUP BY NUMBER FOR EACH ITEM thats why we have ITEM IN HERE