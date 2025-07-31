/*- Nationalities with the most common reviewers 
 - What are the most common nationalities that give the most reviews
 - Do the most common nationality give more positive or negative reviews
 Goal: To understand which nationalities give most to reviews, and whether their feedback is helping or harming the hotels.
*/




WITH nationalities AS (
    SELECT
        reviewer_nationality,
        COUNT(reviewer_nationality) AS nationality_count
    FROM
        hotel_reviews
    GROUP BY
        reviewer_nationality
),

top_nationalities AS (
    SELECT
        *
    FROM
        nationalities
    ORDER BY nationality_count DESC
    LIMIT 10
),

total_positive AS (
    SELECT
        reviewer_nationality,
        COUNT(score_group) AS positive_count
    FROM
        hotel_reviews
    WHERE
        score_group = 'Positive'
    GROUP BY reviewer_nationality
),

total_negative AS (
    SELECT
        reviewer_nationality,
        COUNT(score_group) AS negative_count
    FROM
        hotel_reviews
    WHERE
        score_group = 'Negative'
    GROUP BY reviewer_nationality
)


SELECT
    tn.reviewer_nationality,
    tn.nationality_count,
    positive.positive_count,
    negative.negative_count
FROM
    top_nationalities AS tn
INNER JOIN total_positive AS positive ON tn.reviewer_nationality = positive.reviewer_nationality
INNER JOIN total_negative AS negative ON tn.reviewer_nationality = negative.reviewer_nationality
ORDER BY tn.nationality_count DESC


