use tdaydata;

--showing us all data in servings_sides
select * from servings_sides

--how many sides is each house serving?
--changing the aggregation to the HOUSE
select house_number, count(servingID) --showing the house number but it is counting the side dishes
from servings_sides
group by house_number --its grouping the data by the amount of serving sides each house is providing

--NOW, we are changing the LEVEL of agg to the SIDE DISH
--how many houses are serving each side dish?
select side_dish, count(servingID)
from servings_sides
group by side_dish;

--how many dishes are being served that are premade vs. homemade? 
select homemade_or_premade, count(servingID) --THE FIRST ATTRIBUTE IN THE SELECT STMT WILL BE OUR GROUP BY ATTRIBUTE
from servings_sides 
group by homemade_or_premade;

--what houses are serving at least 3 sides? /// FIRST we need to know how many sides are being served at EACH HOUSE
select house_number, count(servingID) 
from servings_sides
group by house_number
having count(servingID)>=3; --allows us to take these groups one step further 