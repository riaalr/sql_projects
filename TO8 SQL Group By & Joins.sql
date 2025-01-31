--Maria Alrammah 
--TO8

use itunestest;

--1) How many phone numbers are recorded of each phone type?
select phonetype, count(phonenumber) --counting how many phone numbers
from customer_phone
group by phonetype --grouping the PHONE TYPE

--2) How many songs are on each album?
select album.albumid, count(song.songid) as 'Number of songs' --counting how many songs
from album inner join song 
on album.albumid = song.albumid
group by album.albumid --grouping by ALBUM

--3) What albums have more than 20 songs? 
select album.albumid, count(songid) 
from album inner join song
on album.albumid = song.albumid
group by album.albumid --grouping by album
having count(songid) > 20 --MORE THAN 20 song (having stmt)

--4) How many songs were purchased each year?  
select count(song.songid) as 'Number of Songs', year(pdate) as 'Year' --counting songs, displaying year
from song inner join purchase
on song.songid = purchase.songid
group by year(pdate) --grouping by year

--5) How many songs were purchased each year with a discount vs. without a discount?  
select year(pdate), albumdiscount, count(songid)
from purchase
group by albumdiscount, year(pdate) --group by YEAR and DISCOUNT

--6) How many songs does each artist have in the data?
select artistname, count(song.songid) as 'Number of Songs'
from artist inner join album
on artist.artistid = album.artistid
inner join song
on album.albumid = song.albumid
group by artist.artistid, artistname --we must add ARTIST ID in case two artists have the SAME name
--ANYTHING ON GROUP BY LINE DOES NOT HAVE TO BE IN SELECT LINE

--7)	During what months in 2009 was a song purchased with the word “rain” in the song title? (Hint: the correct query returns 8 months)
select month(pdate) as 'month', count(songtitle) as 'song count'
from song inner join purchase
on song.songid = purchase.songid 
where year(pdate) = 2009 AND songtitle like '%rain%' 
group by month(pdate)
