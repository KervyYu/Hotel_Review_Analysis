/* - Top 10 hotels for Business Trip
First, get the distinct hotel with the most trips under Business
Second, under those hotel, get the top 10 highest average score
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
)

SELECT
    *
FROM (
    SELECT
        *
    FROM
        business_trip
    ORDER BY trip_count DESC
    LIMIT 10
    ) AS top_hotels

ORDER BY top_hotels.average_score DESC




