DROP TABLE IF EXISTS Netflix;
CREATE TABLE Netflix(
show_id VARCHAR(10),
type VARCHAR(10),
title VARCHAR(1000),
director VARCHAR(300),
casts VARCHAR(1000),
country VARCHAR(300),
date_added VARCHAR(50),
release_year INT,
rating VARCHAR(500),
duration VARCHAR(500),
listed_in VARCHAR(100),
description VARCHAR(500)
);
SELECT * FROM Netflix;
SELECT COUNT(*) FROM Netflix;

-- 1. count the number of total movies and tv shows
SELECT Type, COUNT(*)
FROM Netflix
GROUP BY Type;

-- 2. Find the most common rating for movies and TV shows
SELECT type, rating
FROM 
(
SELECT type,rating, COUNT(*),
RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
FROM Netflix
GROUP BY 1, 2
-- ORDER BY 1, 3 
) as t1
  where
      ranking = 1

-- 3.List all movies released a specific year (e.g. 2020)
SELECT title, release_year
FROM Netflix
WHERE release_year = 2020;

-- 4. Find the top 5 countries with the most content on Netflix
SELECT
UNNEST(STRING_TO_ARRAY(country, ',')) as new_country,
COUNT(show_id)
FROM Netflix
GROUP BY 1
ORDER BY 2 DESC   -- to get top contries with most content
LIMIT 5;   -- To get only top 5 countries

SELECT    --there are multiple country in a list. converting countries from string to array and unnest it show single country
    UNNEST(STRING_TO_ARRAY(country, ',')) as new_country
FROM Netflix;

-- 5. Identify the longest movie
SELECT title, duration
FROM Netflix
WHERE 
     type = 'Movie'
	 AND
	 duration = (SELECT MAX(duration) FROM Netflix)

-- 6. Find content added in last 5 years


SELECT *	 
FROM Netflix
WHERE TO_DATE(date_added, 'month DD,YYYY ') >= CURRENT_DATE - INTERVAL '5 years'

SELECT CURRENT_DATE - INTERVAL '5 years'; -- to get 5 years age exact date from today

-- 7. Find all movies/tv shows directed by 'Rajiv Chilaka'
SELECT *
FROM Netflix
WHERE director LIKE '%Rajiv Chilaka%'

-- 8. List all TV Shows with more than 5 seasons
SELECT *
FROM Netflix
WHERE 
   type = 'TV Show'
   AND
   SPLIT_PART(duration, ' ', 1)::numeric > 5  -- use SPLIT_PART to split the string from the numeric part

-- 9. Count the number of content items in each genre(linked_in)
SELECT UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre,
COUNT(show_id)
FROM Netflix
GROUP BY 1

-- 10. Find each year and the average number of content realease by India on Netflix
--     return top 5 year with highest avg content released.
SELECT 
    EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD,YYYY')) as year,
COUNT(*) AS yearly_content,
COUNT(*)::numeric/(SELECT COUNT(*) FROM Netflix WHERE country = 'India')::numeric * 100 AS avg_per_year
FROM Netflix
WHERE country LIKE 'India'
GROUP BY 1

(SELECT COUNT(*) FROM Netflix WHERE country = 'India') -- to get total content release by india

-- 11. List all the movies that are documentaries
SELECT *
FROM Netflix
WHERE 
     listed_in LIKE '%Documentaries%'

-- 12. Find all content without a director
SELECT * FROM Netflix
WHERE director IS NULL

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years
SELECT 
    EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD,YYYY')) as year,
	*
FROM Netflix
WHERE casts ILIKE '%Salman Khan%'
LIMIT 10

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in india
SELECT UNNEST(STRING_TO_ARRAY(casts, ',')) AS cast,
COUNT(show_id) AS total_shows
FROM  Netflix
WHERE country LIKE '%India%'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10

-- 15. Ctagorize the content baesd on the presence of the keyboard 'kill' and 'violence'
--      in the description field. Lebel content containing these
--      keyboard as 'Bad' and all other content as 'Good'. Count how many items falll into each category.
WITH new_table AS(
SELECT
    *,
	CASE 
	WHEN description ILIKE '%kill%' 
	       OR 
	      description ILIKE '%violence%' THEN 'Bad Content'
	  ELSE 'Good Content'
	END category
FROM Netflix
)
SELECT category, COUNT(*) as total_content
FROM new_table
GROUP BY 1


WHERE description ILIKE '%kill%'
    OR
	  description ILIKE '%violence%'

