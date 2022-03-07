USE publications;

    -- In table sales, a title can appear several times. The royalties need to be calculated for each sale.
    -- Despite a title can have multiple sales records, the advance must be calculated only once for each title.
    -- In your eventual solution, you need to sum up the following profits for each individual author:
      --   All advances, which are calculated exactly once for each title.
      --   All royalties in each sale.

-- 1  Calculate the royalty of each sale for each author and the advance for each author and publication.
-- 2   Using the output from Step 1 as a subquery, aggregate the total royalties for each title and author.
-- 3   Using the output from Step 2 as a subquery, calculate the total profits of each author by aggregating the advances and total royalties of each title.

-- CHALLENGE 1
-- Step1
 SELECT ta.au_id, ta.title_id, t.advance*ta.royaltyper/100 AS advance, t.price*s.qty*t.royalty/100*ta.royaltyper/100 AS royalty
 
 FROM titleauthor ta
 INNER JOIN titles t
 ON t.title_id=ta.title_id
 INNER JOIN sales s
 ON ta.title_id=s.title_id
 ;
 
 -- Step2
 
CREATE TEMPORARY TABLE advance_royalty (au_id VARCHAR(11), title_id VARCHAR(6), royalty INT, advance INT)
 SELECT ta.au_id, ta.title_id, t.advance*ta.royaltyper/100 AS advance, t.price*s.qty*t.royalty/100*ta.royaltyper/100 AS royalty
 FROM titleauthor ta
 INNER JOIN titles t
 ON t.title_id=ta.title_id
 INNER JOIN sales s
 ON ta.title_id=s.title_id
 ;

SELECT au_id, title_id, SUM(royalty)
FROM advance_royalty
GROUP BY title_id, au_id
ORDER BY au_id;

-- Step3

CREATE TEMPORARY TABLE agg_royalty(au_id VARCHAR(11),title_id VARCHAR(6))
SELECT au_id, title_id, SUM(royalty) AS agg_royalty
FROM advance_royalty
GROUP BY title_id, au_id
ORDER BY au_id;

CREATE TEMPORARY TABLE agg_advance(au_id VARCHAR(11),title_id VARCHAR(6))
SELECT au_id, title_id, SUM(advance) AS agg_advance
	FROM advance_royalty
	GROUP BY title_id, au_id
ORDER BY au_id;

SELECT 
   ar.au_id, (aa.agg_advance + ar.agg_royalty) AS total_profit
FROM
    agg_royalty ar
        INNER JOIN
    agg_advance aa ON ar.au_id = aa.au_id
GROUP BY ar.au_id
ORDER BY total_profit DESC
LIMIT 3;

-- CHALLENGE 2 (with subqueries instead of temporary tables)

SELECT 
    au_id, title_id, SUM(royalty) AS total_royalty
FROM
    (SELECT 
        ta.au_id,
            ta.title_id,
            t.advance * ta.royaltyper / 100 AS advance,
            t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 AS royalty
    FROM
        titleauthor ta
    INNER JOIN titles t ON t.title_id = ta.title_id
    INNER JOIN sales s ON ta.title_id = s.title_id) AS derived_table_1
GROUP BY au_id
;

-- CHALLENGE 3
CREATE TABLE most_profitable_authors (au_id VARCHAR(11)) 
SELECT 
   ar.au_id, (aa.agg_advance + ar.agg_royalty) AS total_profit
FROM
    agg_royalty ar
        INNER JOIN
    agg_advance aa ON ar.au_id = aa.au_id
GROUP BY ar.au_id
ORDER BY total_profit DESC
;

SELECT * FROM most_profitable_authors