-- SQL Week 4 Assignment

-- Please create an organization chart for a real or imagined organization, implemented in a single SQL table. Your deliverable script should:
-- 1. Create the table. Each row should minimally include the person’s name, the person’s supervisor, and the person’s job title. Using ID columns is encouraged.
-- 2. Populate the table with a few sample rows.
-- 3. Provide a single SELECT statement that displays the information in the table, showing who reports to whom.
-- You might have an organization with a depth of three levels. For example: there could be a CEO, two vice presidents that report to the CEO, and two 
-- managers that report to each of the two vice presidents. An assistant might also report directly to the CEO. Your table should be designed so that 
-- the reporting hierarchy could go to any practical depth. You may use the example below if you are not able to come up with your own hierarchical data example.


-- 1. Create the table. I decided to use Apple and to include a Team field for grouping people

DROP TABLE IF EXISTS apple;

CREATE TABLE apple
	(
	person_id SERIAL PRIMARY KEY,
	person_name VARCHAR (30),
	job_title VARCHAR (30),
	team VARCHAR (30),
	manager_id SMALLINT
	);

-- 2. Populate the table with a few sample rows. I didn't do the whole chart, but I think I covered must relationship types.
-- I did discover that the Apple chart contains two real-life problems and at least one is difficult to represent in a table.
-- There are people with no supervisor shown on the chart: Greg Gilley and Roger Rosner (lower right). Just leave their manager_id NULL, 
-- but means NULL in manager_id cannot mean ultimate boss.
-- The other relationship is Bob Mansfield and Jeffery Williams reporting both to the CEO and COO. The matrix org could be hard in 1 SQL table.

INSERT INTO apple VALUES (1, 'Steve Jobs', 'CEO', 'Executive Team', 0);
INSERT INTO apple VALUES (2, 'Timothy Cook', 'Chief Operating Officer','Executive Team', 1);
INSERT INTO apple VALUES (3, 'Jeffery Williams', 'SVP Operations','Executive Team', 1);
INSERT INTO apple VALUES (4, 'Jonathan Ive', 'SVP Industrial Design','Executive Team', 1);
INSERT INTO apple VALUES (5, 'Ronald Johnson', 'SVP Retail','Executive Team', 1);
INSERT INTO apple VALUES (6, 'Scott Forstall', 'SVP IOS Software','Executive Team', 1);
INSERT INTO apple VALUES (7, 'Phillip Schiller', 'SVP Marketing','Executive Team', 1);
INSERT INTO apple VALUES (8, 'Peter Oppenheimer', 'SVP Chief Financial Officer','Executive Team', 1);
INSERT INTO apple VALUES (9, 'Bruce Sewell', 'SVP General Counsel','Executive Team', 1);
INSERT INTO apple VALUES (10, 'Bob Mansfield', 'Mac Hardware Engineering', 'Executive Team', 1);
INSERT INTO apple VALUES (11, 'Katie Cotton', 'VP Communications', 'VP Reports to Jobs', 1);
INSERT INTO apple VALUES (12, 'Joel Poolney', 'VP HR', 'VP Reports to Jobs', 1);
INSERT INTO apple VALUES (13, 'Hiroki Asai', 'VP Creative Director', 'VP Reports to Jobs', 1);
INSERT INTO apple VALUES (14, 'Andy Miller', 'VP Mobile Advertising/IAD', 'VP Reports to Jobs', 1);
INSERT INTO apple VALUES (15, 'Eddie Cue', 'VP Internet Services', 'VP Reports to Jobs', 1);
INSERT INTO apple VALUES (16, 'Craig Federighi', 'VP Mac Software Engineering', 'VP Reports to Jobs', 1);
INSERT INTO apple VALUES (17, 'John Couch', 'VP Education Sales', 'Vice Presidents', 2);
INSERT INTO apple VALUES (18, 'John Brandon', 'VP Channel Sales', 'Vice Presidents', 2);
INSERT INTO apple VALUES (19, 'Michael Fenger', 'VP iPhone Sales', 'Vice Presidents', 2);
INSERT INTO apple VALUES (20, 'Douglas Beck', 'VP Apple Japan', 'Vice Presidents', 2);
INSERT INTO apple VALUES (21, 'Jennifer Bailey', 'VP Online Stores', 'Vice Presidents', 2);
INSERT INTO apple VALUES (22, 'John McDougal', 'VP Retail', 'Vice Presidents', 5);
INSERT INTO apple VALUES (23, 'Betsy Rafael', 'VP Controller', 'Vice Presidents', 8);
INSERT INTO apple VALUES (24, 'Gary Wipfler', 'VP Treasurer', 'Vice Presidents', 8);
INSERT INTO apple VALUES (25, 'John Theriault', 'VP Global Security', 'Vice Presidents', 9);
INSERT INTO apple VALUES (26, 'Jeff Robbin', 'VP Consumer Apps', 'Vice Presidents', 15);

-- 3. Provide a single SELECT statement that displays the information in the table, showing who reports to whom.

SELECT
	employees.person_name AS "Name",
	employees.job_title AS "Tilte",
	bosses.job_title AS "Reports To",
	bosses.person_name AS "Supervisor"
	FROM apple AS employees
	LEFT JOIN apple AS bosses
	ON employees.manager_id = bosses.person_id
	ORDER BY employees.person_id;

