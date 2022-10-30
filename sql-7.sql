Create database Sql2Inclass3;
use Sql2Inclass3;

-- ------------------------------------------------------------------------------------------

-- 1. Create a table Airline_Details. Follow the instructions given below: 
-- -- Q1. Values in the columns Flight_ID should not be null and Integer type.
-- -- Q2. Each name of the airline should be unique.
-- -- Q3. No country other than United Kingdom, USA, India, Canada and Singapore should beaccepted
-- -- Q4. Assign primary key to Flight_ID
create table if not exists airline_details
(
	flight_id int not null,
    name varchar(20) unique,
    country varchar(20) null check(country in('USA','India','Canada','Singapore')),
    primary key(flight_id)
);

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Create a table Passengers. Follow the instructions given below: 
-- -- Q1. Values in the columns Traveller_ID and PNR should not be null.
-- -- Q2. Name of the passenger should be not null
-- -- Q3. Only passengers having age greater than 18 are allowed.
-- -- Q4. Assign primary key to Traveller_ID
-- -- Q5. Flight_ID integer type and not null
-- -- Q6. Ticket_Price integer type and not null

create table passengers
(
	Traveller_id int not null,
    pnr int not null,
    passenger_name varchar(13) not null,
    age int check(age>18),
    primary key(traveller_id),
    flight_id int not null,
    ticket_price int not null
);


-- ----------------------------------------------------------------------------------
-- Questions for table Passengers:  
-- -- Q3. PNR status should be unique as well  .
-- -- Q4. Flight Id should not be null.

alter table passengers modify pnr int not null unique;
alter table passengers modify flight_id int not null;


-- ---------------------------------------------------------------------------------- 
-- Q5. Create a table Senior_Citizen_Details. Follow the instructions given below: 
-- -- Q1. Assign foreign key constraint on Traveller_ID such that if any row from passenger table is updated, then the Senior_Citizen_Details table should also get updated.
-- -- Q2. Also deletion of any row from passenger table should not be allowed.
-- -- Q3. Create Discounted_Price column of varchar type 20 size with not null property.
 
 create table senior_citizen_details
 (
	traveller_id int,
    discounted_price varchar(20) not null,
    foreign key(traveller_id) references passengers(traveller_id) 
    on update cascade
    on delete restrict 											# not need to enter
);
 
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- Q6. Create a table books. Follow the instructions given below: 
-- -- Columns: books_no, description, author_name, cost
-- -- Q1. The cost should not be less than or equal to 0.
-- -- Q2. The cost column should not be null.
-- -- Q3. Assign a primary key to the column books_no.
create table books
(
	books_no int primary key,
    description varchar(20) null,
    author_name varchar(10) null,
    cost int not null check(cost>1)
);

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
# Q7. Update the table 'books' to add columns 'description' and 'author' and must be unique
# of varchar type.
alter table books
modify description varchar(20) unique,
modify author_name varchar(20) unique; 

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- Q8. Create a table bike_sales. Follow the instructions given below: 
-- -- Columns: id, product, quantity, release_year, release_month
-- -- Q1. Assign a primary key to ID. Also the id should auto increment.
-- -- Q2. None of the columns should be left null.
-- -- Q3. The release_month should be between 1 and 12 (including the boundries i.e. 1 and 12).
-- -- Q4. The release_year should be between 2000 and 2010.
-- -- Q5. The quantity should be greater than 0.
create table bike_sales
(
	id int auto_increment primary key,
    products varchar(20) not null,
    quantity int not null check(quantity>0),
    release_year int not null,
    check(release_year>=2000 and release_year<=2010),
    release_month int not null,
    check(release_month>=1 and release_month<=12)
);







