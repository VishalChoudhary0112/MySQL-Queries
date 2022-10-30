Create database Sql2Inclass2;
use Sql2Inclass2;

-- --------------------------------------------------------------
# Dataset Used: wine.csv
-- --------------------------------------------------------------
# Q1. Give a dense rank to the wine varities on the basis of the price.

select variety,price,dense_rank()
over(partition by variety order by price desc)
from wine;
 
# Q2. Use aggregate window functions to find the average of points for each row within
# its partition (country) and also arrange the final result in the descending order by country.
# print country,province,winery,variety

select country,province,winery,variety,
avg(points)over(partition by country order by country desc)
from wine;


# Dataset Used: students.csv
-- --------------------------------------------------------------
# Q3. Provide the new roll numbers to the students on the basis of their names alphabetically.
select * from
(select row_number()over(order by name asc)`Roll no.`,subject,name,marks from students)t;

-----------------------------------------------------------------
# Dataset Used: website_stats.csv and web.csv
-----------------------------------------------------------------

# Q4. Display the difference in ad_clicks between the current day and the next day for 
# the website 'Olympus'

select *,ad_clicks-next_day_adclicks
from (
select website_id,day,ad_clicks,lead(ad_clicks)
over(partition by website_id order by day) as next_day_adclicks
from website_stats where website_id=
(select id from web where name like 'olympus'))t;




# Q5. Write a query that displays the statistics for website_id = 3 such that for each row,
# show the day, the number of users and the smallest number of users ever.


select name,day,no_users,mini from web join
(select website_id,day,no_users,min(no_users)over() mini from website_stats)t
on web.id=t.website_id
where web.id=3;


# Dataset Used: play_store.csv and sale.csv
-- ---------------------------------------------------------------

# Q6. Write a query thats orders games in the play store into three buckets as 
#per editor ratings received  from higher to lowest

select *,ntile(3)over(order by editor_rating) from play_store;





# Q7. Write a query that displays the name of the game, the price, the sale date and 
#the 4th column should display # the sales consecutive number i.e. ranking of game as 
#per the sale took place, so that the latest game sold gets number 1. 
#Order the result by editor's rating of the game

select p.name,s.price,str_to_date(date,'%d-%m-%y') as date,
row_number() over(order by str_to_date(date,'%d-%m-%y')desc)
from play_store p
join sale s
using(id)
order by editor_rating;

-----------------------------------------------------------------
# Dataset Used: movies.csv, ratings.csv, rent.csv
-----------------------------------------------------------------
# Q8. Write a query that displays basic movie informations as well as the previous rating 
#provided by customer for that same movie 
# make sure that the list is sorted by the id of the reviews.

select m.title,m.id,m.genre,r.rating,
lag(r.rating) over(partition by m.id)
from movies m 
join ratings r
on m.id=r.movie_id
order by r.id;




# Q9. For each movie, show the following information: title, genre, average user rating for 
#that movie  and its rank in the respective genre based on that average rating in descending 
#order (so that the best movies will be shown first).

select *,dense_rank()over(partition by genre order by avg_rating desc) as rnk from
(select m.title,m.genre,avg(r.rating) avg_rating
from movies m 
join ratings r
on m.id=r.movie_id
group by m.title,m.genre)t
order by avg_rating;



# Q10. For each rental date, show the rental_date, the sum of payment amounts 
#(column name payment_amounts) from rent 
#on that day, the sum of payment_amounts on the previous day and the difference between 
#these two values.


select *,lag(payment)over(order by rental_date),payment - lag(payment) over(order by rental_date)

from(
select str_to_date(rental_date,'%d-%m-%y') rental_date
,sum(payment_amount) as payment
from rent
group by str_to_date(rental_date,'%d-%m-%y')
order by str_to_date(rental_date,'%d-%m-%y'))t;



