--Maria Alrammah
--12-6-2021

use chinook

--1. What customer(s) that purchased any Foo Fighters track in 2015 also purchased a track called "The Job" in 2017? 
select customer.customerid --display customers id
from customer join Invoice --join invoice
on customer.customerid = invoice.customerid
join invoiceline --join invoice line table
on invoice.invoiceid = invoiceline.invoiceid
join track --join track table
on track.trackid = invoiceline.trackid
join album --join album table
on album.albumid = track.albumid
join artist --join artist table
on artist.artistid = album.artistid
where year (invoicedate) = 2015 --specifying year for foo fighters
and customer.customerid in ( --opening inner query
select invoice.customerid
from track join invoiceline 
on track.trackid = invoiceline.trackid
join invoice --joining tables
on invoiceline.invoiceid = invoice.invoiceid 
where track.[name] = 'The Job' and year (invoicedate) = 2017 --specfying year for "The Job"
) --close inner query
group by customer.customerid, year (invoicedate), artist.[name] --grouping by year and artist name
having artist.[name] = 'Foo Fighters' --specfying artist name

--2. What customers purchased more tracks in 2018 than the average amount of tracks purchased by customers in 2017? 
select customerid, sum(quantity), year(invoicedate) --summming quantity
from invoice join invoiceline
on invoiceline.invoiceid = invoice.invoiceid --joining tables
where year(invoicedate) = 2018 --specifying year
group by customerid, year(invoicedate) --grouping by year and date
having sum(quantity) > --where sum is more the avg amount
( --open inner query for the avg
select sum(quantity) / count(distinct customerid) --find avg
from invoiceline join invoice --joining tables
on invoiceline.invoiceid = invoice.invoiceid
where year (invoicedate) = 2017  --specfying year
) --close inner query