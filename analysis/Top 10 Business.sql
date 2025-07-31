/* - Top 10 hotels for Business Trip
First, get the distinct hotel with the most trips under Business
Second, under those hotel, get the top 10 highest average score for business and leisure
Goal: To find the most famous hotel for business trips, and among those hotel, which ones are actually delivering the best experience?
Required query: CTE or Subquery */




WITH business_trip AS (
    SELECT
        hotel_name,
        average_score,
        COUNT(trip) AS trip_count
    FROM 
        hotel_reviews
    WHERE
        trip = 'Business'
    GROUP BY hotel_name, average_score
),

avg_business AS(
    SELECT
        hotel_name,
        ROUND(AVG(reviewer_score)::numeric, 1) AS business_score
    FROM hotel_reviews
    WHERE trip = 'Business'
    GROUP BY hotel_name
),

top_hotel AS (
    SELECT
        *
    FROM
        business_trip
    ORDER BY trip_count DESC
    LIMIT 10
)






SELECT
    th.hotel_name,
    th.trip_count,
    th.average_score AS overall_score,
    bl.business_score AS business_averagescore
FROM 
    top_hotel AS th
INNER JOIN avg_business AS bl ON th.hotel_name = bl.hotel_name
ORDER BY th.trip_count DESC





