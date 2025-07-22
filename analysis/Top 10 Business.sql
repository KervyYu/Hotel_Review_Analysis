SELECT
    DISTINCT hotel_name,
    average_score,
    trip,
    COUNT(trip) AS trip_count
FROM
    hotel_reviews
WHERE
    trip = 'Business'
GROUP BY hotel_name, average_score, trip
ORDER BY trip_count DESC
LIMIT 10
