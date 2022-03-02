USE appledatabase;

 SELECT DISTINCT(prime_genre) FROM apple;
 
 SELECT 
    prime_genre, rating_count_tot
FROM
    apple
GROUP BY prime_genre
ORDER BY rating_count_tot DESC
LIMIT 1;
 
 
 
 SELECT 
    prime_genre, COUNT(*)
FROM
    apple
GROUP BY prime_genre
ORDER BY COUNT(*) DESC;

SELECT 
    prime_genre, COUNT(*)
FROM
    apple
GROUP BY prime_genre
ORDER BY COUNT(*) ASC
LIMIT 1;

SELECT 
    track_name
FROM
    apple

ORDER BY rating_count_tot DESC
LIMIT 10;

SELECT 
    track_name, user_rating
FROM
    apple
ORDER BY user_rating DESC
LIMIT 10;


SELECT 
    track_name,rating_count_tot,user_rating
FROM
    apple
WHERE user_rating=5
ORDER BY rating_count_tot DESC
LIMIT 3;

-- Last question
SELECT 
    track_name, price, rating_count_tot
FROM
    apple
WHERE price>2
ORDER BY rating_count_tot  DESC 
LIMIT 10;

SELECT 
    track_name, price, max(rating_count_tot)
FROM
    apple
WHERE price<2

LIMIT 10;


