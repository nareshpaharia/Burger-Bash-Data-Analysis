

#Q1. How many burgers were ordered?

select count(*) as 'no of order' 
from runner_orders;

#Q2.How many unique custmer orders were made?

SELECT count(distinct order_id) as unique_orders 
from customer_orders;

-- -------------------------------------------------
SELECT count(distinct customer_id) as unique_customer 
from customer_orders;
-- -------------------------------------------------


#Q3. How many successful orders were delivered by each runner ?

select runner_id,
count(distinct order_id) as sucessful_orders
from runner_orders
where cancellation is null
group by runner_id;


#Q4.How many each type of burger was delivered?

select p.burger_name,count(c.burger_id) as delivered_burger_count
from customer_orders as c join runner_orders as r on c.order_id=r.order_id
join burger_name as p on c.burger_id=p.burger_id
where r.distance!=0 
group by p.burger_name;

#Q5.How many vegetarian and meatlovers were order by each customer?

select c.customer_id,b.burger_name,count(b.burger_name) as order_count
from customer_orders as c join burger_name as b on c.burger_id=b.burger_id
group by c.customer_id,b.burger_name
order by c.customer_id;


#Q6. What was the maximum numbe of burgers delieverd in a single day?

with burger_count_cte as 
(select c.order_id, count(c.burger_id) as burger_per_order
from customer_orders as c join runner_orders as r on c.order_id = r.order_id
where r.distance!=0
group by c.order_id )
select max(burger_per_order) as burger_
from burger_count_cte;


#Q7. For which customer, how many delieverd burgers had atleast 1 change and how many have no change?

select c.customer_id,
sum(case when c.exclusions<> ' ' or c.extras <>' '
then 1
else 0 
end) as at_least_1_change,
sum(case when c.exclusions=' ' and c.extras =' '
then 1 
else 0 
end ) as no_change 
from customer_orders as c
join runner_orders as r
on c.order_id =r.order_id
where r.distance!=0
group by c.customer_id 
order by c.customer_id ;


#Q8. What was the total volumme of burgers order for each hour of the day?

SELECT EXTRACT(HOUR from order_time) AS hour_of_day, 
COUNT(order_id) AS burger_count
FROM customer_orders
GROUP BY EXTRACT(HOUR from order_time);



#Q9.How many runners signed up for each I week period?  

select extract(week from registration_date) as registration_Week ,
count(runner_id) as runner_signup 
from burger_runner 
group by extract(week from registration_date);


#Q10. What was the average distance travelled for each customer?

select c.customer_id,round(avg(r.distance),0) as average_distance 
from customer_orders as c join runner_orders as r on c.order_id=r.order_id
where r.duration!=0
group by c.customer_id;


-- ------------------------------------END---------------------------------------------------
-- ------------------------------------------------------------------------------------------
