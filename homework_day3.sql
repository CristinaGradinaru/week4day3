-- Week 4 - Wednesday
-- Questions

-- 1. List all customers who live in Texas (use
-- JOINs)

SELECT *
FROM address
WHERE district LIKE 'Texas';

SELECT first_name, last_name, customer_id, address, district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full
-- Name

SELECT customer.customer_id, first_name, last_name, amount
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;

-- 3. Show all customers names who have made payments over $175(use
-- subqueries)

SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount)>175
);

-- 4. List all customers that live in Nepal (use the city
-- table)

SELECT *
FROM country;

SELECT *
FROM city;

SELECT country.country_id, country, city
FROM city
JOIN country
ON country.country_id = city.country_id
WHERE country = 'Nepal';

-- 5. Which staff member had the most
-- transactions?

SELECT staff.staff_id, first_name, last_name, COUNT(payment_id) 
FROM payment
INNER JOIN staff
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id; 

-- 6. What film had the most actors in it? THIS DOESNT WORK

SELECT film_actor.film_id, COUNT(DISTINCT film_actor.actor_id), title
FROM film
JOIN film_actor
ON film_actor.film_id = film.film_id
GROUP BY film.title;


-- 7.Show all customers who have made a single payment
-- above $6.99 (Use Subqueries)
					 
SELECT COUNT(customer.customer_id)
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99
HAVING COUNT(customer.customer_id) = 1;

--Which category is the most prevalent in the films?
SELECT *
FROM film;

SELECT *
FROM film_category;

SELECT film.film_id, category_id
FROM film_category
JOIN film
ON film.film_id= film_category.film_id
GROUP BY category_id
ORDER BY COUNT(category_id) DESC;