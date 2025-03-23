COPY Hotel_Reviews( review_date,average_score,hotel_name,reviewer_nationality,total_no_of_reviews,reviewer_score,score_group,has_pet,trip,companion,night_stayed)
FROM 'D:\cs coding files\data analysis\Hotel_Review_Analysis\excel_file\Hotel_Reviews.csv'
DELIMITER ',' CSV HEADER;