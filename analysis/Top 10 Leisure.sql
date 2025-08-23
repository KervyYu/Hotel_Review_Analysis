/* - Top 10 hotels for Leisure Trip
First, get the distinct hotel with the most trips under leisure
Second, under those hotel, get the top 10 highest average score
Goal: To find the most famous hotel for business trips, and among those hotel, which ones are actually delivering the best experience?
Required query: CTE or Subquery */




WITH leisure_trip AS (
    SELECT
        hotel_name,
        average_score,
        COUNT(trip) AS trip_count
    FROM 
        hotel_reviews
    WHERE
        trip = 'Leisure'
    GROUP BY hotel_name, average_score
),

avg_leisure AS(
    SELECT
        hotel_name,
        ROUND(AVG(reviewer_score)::numeric, 1) AS leisure_score
    FROM hotel_reviews
    WHERE trip = 'Leisure'
    GROUP BY hotel_name
),

top_hotel AS (
    SELECT
        *
    FROM
        leisure_trip
    ORDER BY trip_count DESC
    LIMIT 10
)






SELECT
    th.hotel_name,
    th.trip_count,
    th.average_score AS overall_score,
    al.leisure_score AS leisure_averagescore
FROM 
    top_hotel AS th
INNER JOIN avg_leisure AS al ON th.hotel_name = al.hotel_name
ORDER BY leisure_averagescore DESC





