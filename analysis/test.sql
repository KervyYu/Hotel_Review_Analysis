SELECT DISTINCT 
    hotel_name, 
    average_score,
    EXTRACT(YEAR FROM review_date) AS years,
   RANK() OVER(PARTITION BY EXTRACT(YEAR FROM review_date) ORDER BY average_score DESC) AS rankings
FROM 
    hotel_reviews
WHERE 
    score_group = 'Positive';