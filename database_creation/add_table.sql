--xreating hotel table

CREATE TABLE public.Hotel_Reviews
(
    hotel_id SERIAL PRIMARY KEY,
    review_date DATE,
    average_score REAL,
    hotel_name TEXT,
    reviewer_nationality TEXT,
    total_no_of_reviews INT,
    reviewer_score REAL,
    score_group TEXT,
    has_pet TEXT,
    trip TEXT,
    companion TEXT,
    night_stayed INT
);




--set owneship of table
ALTER TABLE public.Hotel_Reviews OWNER to postgres;