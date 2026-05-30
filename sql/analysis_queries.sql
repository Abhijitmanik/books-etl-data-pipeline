

SELECT * FROM books;

SELECT COUNT(*) FROM books;

SELECT * FROM books LIMIT 99;

-- Total Books
SELECT COUNT(*) FROM books;

-- Average Price
SELECT ROUND(AVG(price)::numeric, 2) AS avg_price
FROM books;

-- Top 10 Most Expensive Books
SELECT *
FROM books
ORDER BY price DESC
LIMIT 20;

-- Rating Distribution
SELECT rating, COUNT(*)
FROM books
GROUP BY rating
ORDER BY rating;

-- Average Price by Rating
SELECT rating,
    ROUND(AVG(price)::numeric, 2) AS avg_price
FROM books
GROUP BY rating
ORDER BY rating;


SELECT * 
from books 
order by price ASC
LIMIT 1;


SELECT rating,
max(price)as highest_price
from books
group by rating
order by rating;

select * from books 
where price >
(select avg(price) from books);


select rating,
Round(count(*)*100/sum(count(*))over (),2) AS percenatge 
from books
group by rating
order by rating;


select title, price ,
rank()over(order by price desc) as price_rank
from books;

-----Top 5 price book by rating 

with cte as 
(
    SELECT
        title,
        rating,
        price,
        ROW_NUMBER() OVER
        (
            PARTITION BY rating
            ORDER BY price DESC
        ) rn
    FROM books
) 

select * from cte 
WHERE rn <= 5;


SELECT
    title,
    price,
    ROW_NUMBER() OVER(ORDER BY price DESC) AS row_num,
    RANK() OVER(ORDER BY price DESC) AS rank_num,
    DENSE_RANK() OVER(ORDER BY price DESC) AS dense_rank_num
FROM books;


--Books With Rating 5 and Price Above Average

select * from books
where rating = 5
and price > (select avg(price)from books);

--Price Ctaegories 
select case when price < 20 then 'cheap'
	        when price between 20 and 40 then 'median'
			else 'expensive'
		end as category ,
		count(*)as total_counts
from books 
group by category;

--Top 3 Most Expensive Books Per Rating
with cte as(
select  * ,
row_number()over(partition by rating order by price desc)rn
 from books)
select * from cte 
where rn<=3;

--Running Total of price 

select *,
sum(price)over(order by price)as running_tottal
from books;

---moving averge
SELECT
    title,
    price,
    ROUND(
        AVG(price) OVER(
            ORDER BY price
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        )::numeric,
        2
    ) AS moving_avg
FROM books;

--find duplicates

select title ,
count(*)
from books
group by title
having count(*)>1;


-- Highest Priced Book in Each Rating

with cte as(

select * ,
rank() over(partition by rating order by price desc)
rnk from books)

select * from cte 
where rnk=1;

--price difference from average 
SELECT
   *,
    ROUND(
        (price - AVG(price) OVER())::numeric,
        2
    ) AS diff_from_avg
FROM books;

--NTILE USE 
select *,
NTILE(4)OVER(order by price)as QUIZ
from books;

--Percent Rank

select *,
PERCENT_RANK()over(order by price)as pct_RAN
from books;

--lead 
select rating, title,
lead(price) over(order by price ) as next_order
from books;


--next

select rating, title,
lag(price) over(order by price ) as next_order
from books;


-- Book in TOP 10% by price 

WITH cte AS
(
    SELECT *,
           PERCENT_RANK() OVER(
               ORDER BY price
           ) pct
    FROM books
)
SELECT *
FROM cte
WHERE pct >= 0.90;


--median 
select percentile_cont(0.5)
within group (order by price) as median
from books;














