reviews = LOAD '/user/aiml/reviews/reviews.csv'
          USING PigStorage(',')
          AS (review_id:int, product_category:chararray, rating:double);

filtered_reviews = FILTER reviews BY rating IS NOT NULL AND rating >= 1.0;

grouped_reviews = GROUP filtered_reviews BY product_category;

average_ratings = FOREACH grouped_reviews
                  GENERATE group AS product_category,
                  AVG(filtered_reviews.rating) AS average_rating;

DUMP average_ratings;
