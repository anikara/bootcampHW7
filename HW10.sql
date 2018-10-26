use sakila;

-- 1a)

select first_name, last_name from actor;

-- 1b)
 SELECT  CONCAT(first_name, ' ', last_name) AS `full_name` FROM `actor`;
 
 -- 2a)
 select actor_id, first_name, last_name from actor
	where first_name = 'Joe' or first_name = 'JOE';
    
 -- 2b)
 
 select * from actor
	where last_name like '%GEN%';
    
-- 2c)
select last_name, first_name from actor
	where last_name like '%LI%';
    
-- 2d)

select country_id, country from country
	-- where country = 'Bangladesh' or country = 'Afghanistan' or country = 'China';
    where country in ('Bangladesh', 'China', 'Afghanistan');

-- 3a)
alter table actor
	add description BLOB;
select * from actor;

-- 3b) 
alter table actor drop column description;
select * from actor;

-- 4a)

select last_name, count(*) from actor group by last_name;

-- 4b)
select last_name, count(*) as Counts from actor group by last_name
	having Counts > 1;
    
-- 4c)
update actor
	set first_name = 'HARPO'
	where first_name = 'GROUCHO' and last_name = 'WILLIAMS';
select * from actor 
	where last_name = 'WILLIAMS';

-- 4d)
update actor 
	set first_name = 'GROUCHO'
	where first_name = 'HARPO';
select * from actor 
	where first_name = 'GROUCHO';


-- 5a) *************************
show create table address;

-- 6a)

select staff.first_name, staff.last_name, address.address
	from staff
    join address
		on staff.address_id = address.address_id;
        
-- 6b)  

select staff.first_name, staff.last_name, sum(payment.amount)
	from staff
    join payment
		on staff.staff_id = payment.staff_id
	group by staff.staff_id;



-- 6c)

select  film.title, count(film_actor.actor_id)
	from film_actor
    join film
		on film_actor.film_id = film.film_id
	group by film.title;
    

-- 6d)

 select film.title, count(film.title)
	from film
    join inventory
		on film.film_id = inventory.film_id
	where film.title ='Hunchback Impossible'
    group by film.title;

-- 6e)

select customer.first_name, customer.last_name, sum(payment.amount)
	from payment
    join customer
		on customer.customer_id = payment.customer_id
	group by customer.customer_id
    order by customer.last_name;


-- 7a)
select title
from film 
where (title like 'Q%' or title like 'K%') and language_id in
(
select language_id
from language
where name = 'English'
);



-- 7b)
    
select first_name, last_name
from actor
where actor_id in
	(
	select actor_id
	from film_actor
	where film_id in
		(
		select film_id
        from film
        where title = 'Alone Trip'



		)


	);
    
 
 -- 7c)
 
 select customer.first_name, customer.last_name, customer.email, country.country
 from customer
 join address
    on address.address_id = customer.address_id
    
join city
 on city.city_id = address.city_id
 
 join country
  on country.country_id = city.country_id
  
where country = 'Canada';

-- 7d)

select title
from film
where film_id in

	(
    select film_id
    from film_category
    where category_id in
		(
        select category_id
        from category
        where name = 'Family'
        )
        );
    
-- 7e) 


select film.title, count(rental.inventory_id)
from film
join inventory
	on film.film_id  = inventory.film_id
join rental
	on rental.inventory_id = inventory.inventory_id
group by rental.inventory_id
order by count(rental.inventory_id) DESC;



-- 7f)

select store.store_id, sum(payment.amount)
from store
join customer
 on customer.store_id = store.store_id
join payment
 on payment.customer_id = customer.customer_id


group by store_id;
    
-- 7g)

select store.store_id, city.city, country.country
from store
join address
	on store.address_id = address.address_id
join city
	on address.city_id = city.city_id
join country
 on city.country_id = country.country_id;
 
 
 -- 7h)
 
 select category.name as Category, sum(payment.amount) as Revenue
 from category
 join film_category
  on category.category_id = film_category.category_id
join inventory
 on inventory.film_id = film_category.film_id
 join rental
  on rental.inventory_id = inventory.inventory_id
  join payment
  on payment.rental_id = rental.rental_id
 

group by name
order by Revenue DESC ;


-- 8a)
create view top_five_genres as


 select category.name as Category, sum(payment.amount) as Revenue
 from category
 join film_category
  on category.category_id = film_category.category_id
join inventory
 on inventory.film_id = film_category.film_id
 join rental
  on rental.inventory_id = inventory.inventory_id
  join payment
on payment.rental_id = rental.rental_id
group by name
order by Revenue DESC;
               

-- 8b)

select * from top_five_genres;



-- 8c)

DROP VIEW top_five_genres;
    

