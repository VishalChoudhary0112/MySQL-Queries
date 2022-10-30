##################################################################################
create database SQL2TakeHome4;
use SQL2TakeHome4;
# Datset Used: admission_predict.csv
-- --------------------------------------------------------------------------------------------------------------------------------------------
# Q.1 A university is looking for candidates with GRE score between 330 and 340. 
# Also they should be proficient in english i.e. their Total score should not be less than 115. Create a view for this university.
#Solution:	
create view university as
select * from admission_predict
where `toefl score`>=115  and `gre score` between 330 and 340;


-- ----------------------------------------------------------------------------
# Q.2 Create a view of the candidates with the CGPA greater than the average CGPA.
#Solution:	
create view candidates as
select * from admission_predict
where cgpa > (select avg(cgpa) from admission_predict);

-- ----------------------------------------------------------------------------
 # Datsets Used: world_cup_2015.csv and world_cup_2016.csv 
-- -------------------------------------------------------------------------------------
# Q.3 Create a view "team_1516" of the players who played in world cup 2015 as well as in world cup 2016.
#Solution:	
create view team_1516 as
select a.player_id,a.player_name,a.runs,a.popularity,b.Charisma
from world_cup_2015 a join world_cup_2016 b
using(player_id);



# Q.4 Create a view "All_From_15" that contains all the players who played in world cup 2015 but not in the year 2016
# Along with those players who played in both the world cup matches.
#Solution:	
create view all_from_15 as
select a.player_id,a.player_name,a.runs,a.popularity,b.charisma
from world_cup_2015 a left join world_cup_2016 b
using(player_id);


# Q.5 Create a view "All_From_16" that contains all the players who played in world cup 2016 but not in the year 2015 Along with those players who played in both the world cup matches.
#Solution:
create view all_from_16 as
select a.player_id,a.player_name,a.runs,a.popularity,b.charisma
from world_cup_2015 a right join world_cup_2016 b
using(player_id);

# Q.6 Drop multiple views "all_from_16", "all_from_15", "players_ranked"
#Solution:
drop view all_from_16,all_from_15;


