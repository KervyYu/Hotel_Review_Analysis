/*
This will be based for Top rated and Lowest rated hotels
- What types of companions are more common in top-rated vs low-rated hotels?
Goal:
- To identify which companion types are associated with higher or lower hotel ratings.
*/ 


---- top hotels ----


WITH high_hotel AS (
    SELECT
        hotel_name,
        average_score,
        COUNT(*) AS review_count
    FROM hotel_reviews
    GROUP BY hotel_name, average_score
),

ranked_hotels AS (
    SELECT
        hotel_name,
        average_score,
        review_count,
        ROW_NUMBER() OVER (
            ORDER BY average_score DESC, review_count DESC
        ) AS rank
    FROM high_hotel
    WHERE
        review_count > 2000
),


num_companion AS (
    SELECT
        hotel_name,
        companion,
        COUNT(*) AS companion_count
    FROM
        hotel_reviews
    GROUP BY hotel_name, companion
)


SELECT
    rh.hotel_name,
    c.companion,
    rh.average_score,
    c.companion_count
FROM
    ranked_hotels AS rh
INNER JOIN num_companion AS c ON rh.hotel_name = c.hotel_name
WHERE
    rank <=10
ORDER BY rh.average_score DESC, rh.hotel_name DESC, c.companion_count DESC;
