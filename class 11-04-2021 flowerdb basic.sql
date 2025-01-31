use flowerdb;

select * 
from customer; -- select stmt is retreiving data from somewhere 
-- star brought us all 4 columns **

select customerID, fname
from customer;

select * 
from customer;

select top 3 customerID, fname
from customer;
--restrict how many rows you get back (top feature) ex. top 3 

select distinct lname --"distinct" removes duplicates after it retrieves the data
from customer;

select * 
from ORDER_ITEM

--what itemIDs have been ordered at least one time?
select distinct itemID
from ORDER_ITEM

--what customers (by ID) have placed at least one order?
select distinct customerID
from order_header;