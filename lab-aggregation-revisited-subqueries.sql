SELECT concat((first_name), ' ', (last_name)) rental_customers, email FROM rental r INNER JOIN customer USING (customer_id) GROUP BY 2 ORDER BY 1;
#What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
SELECT c.customer_id, concat((c.first_name), ' ', (c.last_name)) rental_customers, c.email,
    format(avg(p.amount), 2, 'de_DE') average_payment_made FROM payment p
    INNER JOIN customer c USING (customer_id) GROUP BY 1 ORDER BY 2;
#Select the name and email address of all the customers who have rented the "Action" movies.
SELECT DISTINCT concat(c.first_name, ' ', c.last_name) customer_name, c.email, cat.name type_movies_rented FROM rental r
    INNER JOIN customer c USING (customer_id)
    INNER JOIN inventory i USING (inventory_id)
    INNER JOIN film_category fc ON i.film_id = fc.film_id
    INNER JOIN category cat USING (category_id)
WHERE cat.name = 'Action' ORDER BY customer_name;
#Write the query using sub queries with multiple WHERE clause and IN condition
SELECT
    DISTINCT concat(first_name, ' ', last_name) customer_name,
    email,
    (
        SELECT
            'Action'
    ) type_movies_rented
FROM
    customer
WHERE
    customer_id IN (
        SELECT
            customer_id
        FROM
            rental
        WHERE
            inventory_id IN (
                SELECT
                    inventory_id
                FROM
                    inventory
                WHERE
                    film_id IN (
                        SELECT
                            film_id
                        FROM
                            film_category
                        WHERE
                            category_id IN (
                                SELECT
                                    category_id
                                FROM
                                    category
                                WHERE
                                    name = 'Action'
                            )
                    )
            )
    )
ORDER BY
    customer_name;
#Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. 
#If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4,
# the label should be medium, and if it is more than 4, then it should be high.
SELECT
    *,
    CASE
        WHEN amount <= 2 THEN "low"
        WHEN amount <= 4 THEN "medium"
        WHEN amount > 4 THEN "high"
    END AS classified_as
FROM payment;