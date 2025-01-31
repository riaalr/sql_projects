--Maria Alrammah
use itunestest

--what songs have a filesize greater than 200?
select songid, songtitle, filesize --we list these cause it will be the only columns that show up (which colums we wanna see)
from song --what table is the data coming from? song
where filesize > 200;

--how many song have the word "rain" in their title? --the word rain within other words>> ex. brain
select count(songid) --add count because "how MANY"
from song
where songtitle like '%rain%'; --were using like to show that any character can come before or after rain
--the percent means 0 or many characters 

--how many songs with word "rain" in their title also have a filsize greater than 250
select count(songid)
from song
where songtitle like '%rain%' and filesize > 250; --"and" is when we want BOTH conditions to be true

--what is the total price of the songs on albumID 6? 
select sum(price)
from song 
where albumid = 6;

--what states have at least one customer in the customer table?
select distinct billstate
from customer;

--how many customers are from New Hampshire, Massachusetts, or New York?
select count(customerid)
from customer 
where billstate in ('NH','MA','NY'); --"IN" is the same as listing "OR"'s but its just less typing 


--between SELECT STMT
select songtitle, filesize
from song
where filesize between 250 and 300;

--using scalar functions // 
select purchaseid, pdate, year(pdate), month(pdate)
from purchase
where year(pdate) = 2002