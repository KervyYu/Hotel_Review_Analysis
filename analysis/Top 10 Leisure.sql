/* - Top 10 hotels for Leisure, or Business Trips
First, get the distinct hotel with the most trips under leisure
Second, under those hotel, get the top 10 highest average score
Required query: CTE */


SELECT
     *
FROM (
    SELECT
        hotel_name,
        average_score,
        COUNT(trip) AS trip_count
    FROM
        hotel_reviews
    WHERE
        trip = 'Leisure'
    GROUP BY hotel_name, average_score
    ORDER BY trip_count DESC
    LIMIT 10
) AS top_hotels
ORDER BY average_score DESC