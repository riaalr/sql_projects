--11-30-2021 SUBQUERIES

--What is the difference between the product price and the highest product’s price?
--it is important to find out the highest item FIRST
SELECT menuitem.name, price,
(SELECT max(price)
FROM menuitem) as max_price,
(SELECT max(price)
FROM menuitem)- price as price_difference_from_max
FROM menuitem

--what products are above the avg product price

--avg product price (1)
select avg(menuitem.price) as average_product_price
from menuitem

--product above the avg (2)
select name, price 
from menuitem
where price > (select avg(menuitem.price)
from menuitem)

--customers that bought at least one burger and at least two salads 
select distinct loyaltycard_number
from table_order join lineitem
on table_order.order_id = lineitem.order_id
join menuitem
on lineitem.item_id = menuitem.item_id
where menuitem.name like '%burger%'
and loyaltycard_number in (
select loyaltycard_number
from table_order join lineitem
on table_order.order_id = lineitem.order_id
join menuitem
on lineitem.item_id = menuitem.item_id
where menuitem.name like '%salad%'
group by loyaltycard_number
having sum(quantity) >= 2)
