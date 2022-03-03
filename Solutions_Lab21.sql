use publications;
-- what titles each author has published at which publishers.

    -- AUTHOR ID - the ID of the author
   --  LAST NAME - author last name
  --  FIRST NAME - author first name
  --  TITLE - name of the published title
--     PUBLISHER - name of the publisher where the title was published

SELECT 
    authors.au_id,
    authors.au_lname,
    authors.au_fname,
    titles.title,
    publishers.pub_name
FROM
    authors
        INNER JOIN
    titleauthor ON authors.au_id = titleauthor.au_id
        INNER JOIN
    titles ON titles.title_id = titleauthor.title_id
        INNER JOIN
    publishers ON titles.pub_id = publishers.pub_id;

select * from titleauthor;

-- query how many titles each author has published at each publisher.

SELECT 
    authors.au_lname,
    authors.au_fname,
    publishers.pub_name,
    COUNT(titles.title) AS num_of_titles
FROM
    authors
        INNER JOIN
    titleauthor ON authors.au_id = titleauthor.au_id
        INNER JOIN
    titles ON titles.title_id = titleauthor.title_id
        INNER JOIN
    publishers ON titles.pub_id = publishers.pub_id
GROUP BY publishers.pub_name;

-- Who are the top 3 authors who have sold the highest number of titles? 

SELECT 
    authors.au_id,
    authors.au_lname,
    authors.au_fname,
	count(distinct sales.title_id) AS titles_sold
FROM
    authors
        INNER JOIN
    titleauthor ON authors.au_id = titleauthor.au_id
        INNER JOIN
    titles ON titles.title_id = titleauthor.title_id
        INNER JOIN
    sales ON titles.title_id=sales.title_id
GROUP BY authors.au_id
ORDER BY titles_sold DESC
LIMIT 3;

-- Who are the top 3 best-selling authors?
SELECT 
    authors.au_id,
    authors.au_lname,
    authors.au_fname,
	sum(sales.qty) AS qty_sold
FROM
    authors
        INNER JOIN
    titleauthor ON authors.au_id = titleauthor.au_id
        INNER JOIN
    titles ON titles.title_id = titleauthor.title_id
        INNER JOIN
    sales ON titles.title_id=sales.title_id
GROUP BY authors.au_id
ORDER BY qty_sold DESC
LIMIT 3;
