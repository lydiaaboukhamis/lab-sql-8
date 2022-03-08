
/*Rank films by length (filter out the rows that have nulls or 0s in length column). 
In your output, only select the columns title, length, and the rank.*/

select title, length, RANK() over (ORDER BY length) ranks
from sakila.film
where length is not null and length > 0;


/* Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
In your output, only select the columns title, length, rating and the rank*/

select title, length, rating, rank() over (partition by rating order by length desc) as ranks
from sakila.film
where length is not null and length > 0;

/*how many films are there for each of the categories in the category table. 
Use appropriate join to write this query*/

select name as category_name, count(*) as num_films
from sakila.category inner join sakila.film_category using (category_id)
group by name
order by num_films desc;

-- Which actor has appeared in the most films?

select actor.actor_id, actor.first_name, actor.last_name,
count(actor_id) as film_count
from sakila.actor join sakila.film_actor using (actor_id)
group by actor_id
order by film_count desc
limit 1;

-- Most active customer (the customer that has rented the most number of films)

select customer.*,
count(rental_id) as rental_count
from sakila.customer join sakila.rental using (customer_id)
group by customer_id
order by rental_count desc
limit 1;

/*Bonus: Which is the most rented film? 
The answer is Bucket Brotherhood This query might require using more than one join statement. 
Give it a try. We will talk about queries with multiple join statements later in the lessons*/

select film.title, count(rental_id) as rental_count
from sakila.film inner join sakila.inventory using (film_id)
inner join sakila.rental using (inventory_id)
group by film_id
order by rental_count desc
limit 1;