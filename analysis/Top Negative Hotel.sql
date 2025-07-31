/* - Top 10 hotels with the most negative ratings overall
- Whhich hotel gave the most negative feedback
- Are those hotel more business or leisure trip
- Which companion type does the hotel cater the most
Goal: Identify which hotels receive the most positive or negative reviews, and understand who is giving those reviews.*/




WITH negative_hotel AS (
    SELECT
        hotel_name,
        COUNT(score_group) AS feedback_type
    FROM 
        hotel_reviews
    WHERE
        score_group = 'Negative'
    GROUP BY hotel_name
),


 business_trip AS (
    SELECT
        hotel_name,
        COUNT(trip) AS business_count
    FROM hotel_reviews
    WHERE
        score_group = 'Negative' AND trip = 'Business'
    GROUP BY hotel_name
),

leisure_trip AS (
     SELECT
        hotel_name,
        COUNT(trip) AS leisure_count
    FROM hotel_reviews
    WHERE
        score_group = 'Negative' AND trip = 'Leisure'
    GROUP BY hotel_name
),

random_trip AS (
     SELECT
        hotel_name,
        COUNT(trip) AS random_count
    FROM hotel_reviews
    WHERE
        score_group = 'Negative' AND trip = 'Not Indicated'
    GROUP BY hotel_name
),


top_hotel AS(
    SELECT
        *
    FROM negative_hotel
    ORDER BY feedback_type DESC
    LIMIT 10
)


SELECT
    t.hotel_name,
    t.feedback_type,
    b.business_count,
    l.leisure_count,
    r.random_count
FROM
    top_hotel AS t
JOIN business_trip AS b ON t.hotel_name = b.hotel_name
JOIN leisure_trip AS l ON t.hotel_name = l.hotel_name
JOIN random_trip AS r ON t.hotel_name = r.hotel_name
ORDER BY t.feedback_type DESC





