/*
Since I wasn't able to fully clean the data in Excel, I will perform the following steps in PostgreSQL:
- Data Cleaning: Remove records with NULL values in the 'night_stayed' column.
- Data Preparation: Add new fields to support grouping and filtering by night stay ranges.
- Data Transformation: Create categorical groupings based on 'night_stayed' for easier analysis.
*/

/*
Data Cleaning
First, I excluded the records with no indicated night stayed.
Since there are only 192 such records—just 0.038% of the total dataset—it's safe to remove them. 
Keeping these could distort insights or introduce bias if we tried to impute missing values.
*/

SELECT 
    COUNT(*) AS null_night_count
FROM hotel_reviews
WHERE night_stayed IS NULL;

------------------

/*
- Data Preparation:
  - Add the `night_group` field to group the number of nights stayed for more compact and readable results.
  - Add the `nights_category` field to simplify analysis by labeling each night group as short, medium, or long stay.
*/

ALTER TABLE hotel_reviews
ADD nights_group TEXT,
ADD nights_category TEXT

-----------------

UPDATE hotel_reviews
SET nights_group =
CASE
    WHEN night_stayed BETWEEN 1 AND 2 THEN '1-2'
    WHEN night_stayed BETWEEN 3 AND 31 THEN '3-31'
END,
    nights_category =
CASE
    WHEN nights_group = '1-2' THEN 'Short Stay'
    WHEN nights_group = '3-31' THEN 'Extended Stay'
    ELSE 'not indicated'
END;


----------------
/*
This will be based for Top hotels with the most reviews and highest overall average
- How long do different types of travelers stay? 
- Followup: How stable are ratings across different stay lengths, and how does review volume affect the overall average? 
Goal:
- To understand the typical length of stay for guests at top hotels.
- To assess rating stability across stay lengths and examine how review volume influences the overall average score.
*/ 


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

review_stay AS(
    SELECT
        hotel_name,
        nights_category,
        nights_group,
        COUNT(*) AS review_count,
        ROUND(AVG(reviewer_score)::numeric, 1) AS stay_score
    FROM
        hotel_reviews
    WHERE
        nights_category <> 'not indicated'
    GROUP BY hotel_name,nights_category, nights_group
)




SELECT
    rh.hotel_name,
    rs.review_count,
    rs.nights_group,
    rs.nights_category,
    rs.stay_score

FROM
    ranked_hotels AS rh
INNER JOIN review_stay AS rs ON rh.hotel_name = rs.hotel_name
WHERE
    rank <= 10
ORDER BY rh.average_score DESC, rh.hotel_name DESC, rs.nights_category DESC;
