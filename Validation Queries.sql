# Total Reviews
select count(distinct review_id)
from `marts.fact_reviews`; #6,990,275

# Overall Average Star Rating
select round(avg(f.stars),1) as avg_rating
from `marts.fact_reviews` f
join `marts.dim_business` d
on f.business_id = d.business_id
where d.business_name = 'Starbucks'; #3.1

# Top 10 Most Popular Businesses 
select d.business_name, 
count(distinct f.review_id) as total_reviews, 
round(avg(f.stars),1) as avg_rating
from `marts.fact_reviews` f
join `marts.dim_business` d
on f.business_id = d.business_id
group by d.business_name
order by total_reviews DESC
LIMIT 10;

# Show Categories of different restaurants
SELECT
DISTINCT
  b.business_name,
  c.category_name
FROM `project-9b9e551b-e2f7-46a3-b22.marts.dim_business` b
JOIN `project-9b9e551b-e2f7-46a3-b22.marts.bridge_business_category` bc
  ON b.business_id = bc.business_id
JOIN `project-9b9e551b-e2f7-46a3-b22.marts.dim_category` c
  ON bc.category_id = c.category_id
WHERE b.business_name = 'Acme Oyster House'
ORDER BY c.category_name;


# Which businesses have reviews with the most engagement?
SELECT
  b.business_name,
  l.city,
  SUM(f.useful + f.funny +f.cool) AS total_review_engagement,
  AVG(f.stars) AS avg_rating
FROM `project-9b9e551b-e2f7-46a3-b22.marts.fact_reviews` f
JOIN `project-9b9e551b-e2f7-46a3-b22.marts.dim_business` b
  ON f.business_id = b.business_id
JOIN `project-9b9e551b-e2f7-46a3-b22.marts.dim_location` l
  ON b.location_id = l.location_id
GROUP BY b.business_name, l.city
ORDER BY total_review_engagement DESC
LIMIT 10;



