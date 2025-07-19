SELECT
    hotel_name AS hotel,
   COUNT(score_group) AS rating
FROM hotel_reviews
WHERE
    score_group = 'Negative'
GROUP BY hotel_name
ORDER BY rating ASC;




SELECT
    hotel_name,
    COUNT(score_group) AS rating,
   RANK() OVER( ORDER BY COUNT(score_group) DESC) AS ranking
FROM hotel_reviews
WHERE
    score_group = 'Negative'
GROUP BY hotel_name
