SELECT
    hotel_name,
    score_group,
    COUNT(hotel_id) OVER(PARTITION BY score_group) AS all_group
FROM hotel_reviews;