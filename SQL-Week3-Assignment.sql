-- SQL Week 3 Assignment

-- In this assignment, we’ll practice working with one-to-many relationships in SQL. Suppose you are tasked with keeping track of a database that contain 
-- the best “how-to” videos on reading data from HTML pages.

-- For you to receive full credit, I should be able to run your delivered script twice consecutively without errors. It's acceptable to create your 
-- database using pgadmin, instead of scripting the database create in code.


-- 1. Videos table. Create one table to keep track of the videos. This table should include a unique ID, the title of the video, the length in minutes, 
-- and the URL. Populate the table with at least three related videos from YouTube or other publicly available resources.

-- I started with creating the tables. I soon learned I couldn NOT start over with videos table if the connected reviewers was still around.
DROP TABLE IF EXISTS reviewers;
DROP TABLE IF EXISTS videos;

-- In the Postgesql documentation I read that SERIAL PRIMARY KEY = INT SERIAL PRIMARY KEY NOT NULL, however I saw a lot of code that spelled out all of it.

CREATE TABLE videos (
	video_id SERIAL PRIMARY KEY,
	title VARCHAR (100),
	length SMALLINT,
	url VARCHAR (150) NOT NULL
	);
	
-- I found it more convenient to read in data from a file, so once I started testing I used the file read. I use INSERT statements below. Video_id is 
-- supposed to be NOT NULL and I made the URL NOT NULL, because no URL no video. The title and length can be NULL, but I did not put in any NULL values.

COPY videos(video_id, title, length, url) 
	FROM 'C:\Users\Robert\Documents\CUNY\Bridge Classes\SQL Bridge\Week3\videos.txt' DELIMITERS ',' CSV;

-- My first test is almost always to see the data.

SELECT * FROM videos;


-- 2. Reviewers table. Create a second table that provides at least two user reviews for each of at least two of the videos. These should be imaginary 
-- reviews that include columns for the user’s name (“Mohan”, “Joy”, etc.), the rating (which could be NULL, or a number between 0 and 5), and a short 
-- text review (“Loved it!”). There should be a column that links back to the ID column in the table of videos.

-- Same process for reviewers ... I made the foreign key video_id NOT NULL, so there would be no reviews not linked to a video. The primary key review_id
-- should be NOT NULL too. Everything else can be NULL and I put in a NULL rating value. Two videos have no reviews.

CREATE TABLE reviewers (
	review_id SERIAL PRIMARY KEY,
	name varchar (50),
	rating smallint CHECK (rating >= 0 AND rating <= 5),
	review varchar (140),
	video_id INT REFERENCES "videos" (video_id) NOT NULL
	);

COPY reviewers(name, rating, review, video_id) 
	FROM 'C:\Users\Robert\Documents\CUNY\Bridge Classes\SQL Bridge\Week3\reviewers.txt' DELIMITERS ',' CSV;

SELECT * FROM reviewers;


-- 3. Report on Video Reviews.** Write a JOIN statement that shows information from both tables.

-- In addition to the full selects on each table, I did a FULL JOIN to see the data (and holes) that I thought should be there. I then did a rating summary.

SELECT * FROM videos;

SELECT * FROM reviewers;

SELECT * 
	FROM videos
	FULL JOIN reviewers
	ON videos.video_id = reviewers.video_id
	ORDER BY videos.video_id;
	
SELECT  videos.title AS "Video Title",
	videos.length AS "Run Time",
	ROUND(AVG(reviewers.rating) :: NUMERIC, 1) AS "Average Rating"
	FROM videos
	LEFT JOIN reviewers
	ON videos.video_id = reviewers.video_id
	GROUP BY videos.title, videos.length
	ORDER BY "Average Rating" DESC;

-- Full script all together without comments and using table inserts ...

DROP TABLE IF EXISTS reviewers;
DROP TABLE IF EXISTS videos;

CREATE TABLE videos (
	video_id SERIAL PRIMARY KEY,
	title VARCHAR (100),
	length SMALLINT,
	url VARCHAR (150) NOT NULL
	);

INSERT INTO videos VALUES (29, 'Web scraping with R and rvest', 4, 'http://www.computerworld.com/article/2909560/business-intelligence/web-scraping-with-r-and-rvest-includes-video-code.html');
INSERT INTO videos VALUES (30, 'Scraping Web Page Data Automatically with Excel VBA', 24, 'https://www.youtube.com/watch?v=uWoxx235fkc');
INSERT INTO videos VALUES (31, 'Intermediate Java Tutorial - 32 - Getting the Data from the HTML File', 10, '"https://www.youtube.com/watch?v=FMV1eMapiSY"');
INSERT INTO videos VALUES (32, 'An Introduction to Analytical Webscraping With R', 51, '"https://www.youtube.com/watch?v=m6zMBFCfgto"');
INSERT INTO videos VALUES (33, 'Web Scraping Techniques (with Perl)', 60, '"https://www.youtube.com/watch?v=SFnNMQ_6mQw"');
INSERT INTO videos VALUES (34, 'Python Web Scraping Tutorial 2 (Getting Page Source)', 10, 'https://www.youtube.com/watch?v=kPhZDsJUXic');
INSERT INTO videos VALUES (35, 'How to Scrape Data From the Web Using Google Spreadsheet', 10, 'https://www.youtube.com/watch?v=hjRCdaG1WYY');
	
CREATE TABLE reviewers (
	review_id SERIAL PRIMARY KEY,
	name varchar (50),
	rating smallint CHECK (rating >= 0 AND rating <= 5),
	review varchar (140),
	video_id INT REFERENCES "videos" (video_id) NOT NULL
	);

INSERT INTO reviewers (name, rating, review, video_id) VALUES ('Odell', 3, 'Hello. Thanks for this example. I am trying to do something similar with amazon.com and I am getting a error. Do you know why?', 30);
INSERT INTO reviewers (name, rating, review, video_id) VALUES ('Lynda', 5, 'Very good video, good work. May I know what is the best programming language to do web data scraping please?', 30);
INSERT INTO reviewers (name, rating, review, video_id) VALUES ('Swede', 3, 'I have just started to learn Java and have a background in JavaScript. I get a sense that Java is somehow over-complicated.', 31);
INSERT INTO reviewers (name, rating, review, video_id) VALUES ('Holmes' ,NULL, 'Who is the douche bag who would dislike this video?!', 31);
INSERT INTO reviewers (name, rating, review, video_id) VALUES ('Antonio', 4, 'Hello, I found your video very interesting. I am an R newbie and I got very interested in the Web Scrapping topic.', 32);
INSERT INTO reviewers (name, rating, review, video_id) VALUES ('Scott', 5, 'Great presentation, really loved it. Really love you videos. Keep up the good work.', 33);
INSERT INTO reviewers (name, rating, review, video_id) VALUES ('Jay', 5, 'AMAZING TUTORIALS! I am actually getting what I wanted without having to invest time in the language itself. I love you man.', 34);
INSERT INTO reviewers (name, rating, review, video_id) VALUES ('Joey', 4, 'Always amazed at how people in comments can cut someone down so much. This particular video, for me, was a great lesson.', 34);

SELECT * 
	FROM videos
	FULL JOIN reviewers
	ON videos.video_id = reviewers.video_id
	ORDER BY videos.video_id;
	
-- I do not need to list fields for the videos table, since I am filling them in order.

-- I need to list the fields for reviewers tables, because I am not using the first field. I do not need to specify the primary key here. The SERIAL in the 
-- CREATE table will automatically fill this field, if not specified. I do need to specify the foreign key in order to link the tables.
