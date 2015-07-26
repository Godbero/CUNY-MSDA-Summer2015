-- SQL Week 5 Final Assignment

-- An organization grants key-card access to rooms based on groups that key-card holders belong to. You may assume that users below to only one group. 
-- Your job is to design the database that supports the key-card system.

-- There are six users, and four groups. Modesto and Ayine are in group “I.T.” Christopher and Cheong Woo are in group “Sales”. There are four rooms: 
-- “101”, “102”, “Auditorium A”, and “Auditorium B”. Saulat is in group “Administration.” Group “Operations” currently doesn’t have any users assigned. 
-- I.T. should be able to access Rooms 101 and 102. Sales should be able to access Rooms 102 and Auditorium A. Administration does not have access to any rooms. 
-- Heidy is a new employee, who has not yet been assigned to any group.

-- After you determine the tables any relationships between the tables (One to many? Many to one? Many to many?), you should create the tables and populate 
-- them with the information indicated above.

-- Next, write SELECT statements that provide the following information:
-- 	All groups, and the users in each group. A group should appear even if there are no users assigned to the group.
--	All rooms, and the groups assigned to each room. The rooms should appear even if no groups have been assigned to them. 
--	A list of users, the groups that they belong to, and the rooms to which they are assigned. This should be sorted alphabetically 
-- 	by user, then by group, then by room.

DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS groups;


CREATE TABLE groups
	(
	group_id SERIAL PRIMARY KEY,
	group_name VARCHAR(20)
	);

INSERT INTO groups VALUES (20, 'I.T.');
INSERT INTO groups VALUES (21, 'Sales');
INSERT INTO groups VALUES (22, 'Administration');
INSERT INTO groups VALUES (23, 'Operations');


CREATE TABLE people
	(
	person_id SERIAL PRIMARY KEY,
	person_name VARCHAR (20),
	group_id INT REFERENCES "groups" (group_id),
	key_card BOOLEAN
	);

INSERT INTO people VALUES (1, 'Modesto', 20, TRUE);
INSERT INTO people VALUES (2, 'Ayine', 20, TRUE);
INSERT INTO people VALUES (3, 'Christopher', 21, TRUE);
INSERT INTO people VALUES (4, 'Cheong Woo', 21, TRUE);
INSERT INTO people VALUES (5, 'Saulat', 22, TRUE);
INSERT INTO people VALUES (6, 'Heidy', NULL, FALSE);


CREATE TABLE rooms
	(
	room_id SERIAL PRIMARY KEY,
	room_name VARCHAR (20)
	);

INSERT INTO rooms VALUES (11, '101');
INSERT INTO rooms VALUES (12, '102');
INSERT INTO rooms VALUES (13, 'Auditorium A');
INSERT INTO rooms VALUES (14, 'Auditorium B');

CREATE TABLE grouprooms
	(
	id SERIAL PRIMARY KEY,
	group_id INT REFERENCES "groups" (group_id),
	room_id INT REFERENCES "rooms" (room_id)
	);
INSERT INTO grouprooms VALUES (30, 20, 11);
INSERT INTO grouprooms VALUES (31, 20, 12);
INSERT INTO grouprooms VALUES (32, 21, 12);
INSERT INTO grouprooms VALUES (33, 21, 13);

SELECT * FROM groups;
SELECT * FROM people;
SELECT * FROM rooms;
SELECT * FROM grouprooms;

-- All groups, and the users in each group. A group should appear even if there are no users assigned to the group.

-- A LEFT JOIN shows all Groups even if there are no users assigned. A FULL JOIN shows all Group and all members even if they are mot in a group.

SELECT
	groups.group_name AS "Group",
	people.person_name AS "Member"
	FROM groups
	LEFT JOIN people
	ON groups.group_id = people.group_id
	ORDER BY groups.group_name;

SELECT
	groups.group_name AS "Group",
	people.person_name AS "Member"
	FROM groups
	FULL JOIN people
	ON groups.group_id = people.group_id
	ORDER BY groups.group_name;

-- All rooms, and the groups assigned to each room. The rooms should appear even if no groups have been assigned to them. 

-- Again we get missing groups with the FULL JOIN.

SELECT
	rooms.room_name AS "Room",
	groups.group_name AS "Assigned Group"
	FROM rooms
	LEFT JOIN grouprooms
	ON rooms.room_id = grouprooms.room_id
	LEFT JOIN groups
	ON grouprooms.group_id = groups.group_id
	ORDER BY rooms.room_name;

SELECT
	rooms.room_name AS "Room",
	groups.group_name AS "Assigned Group"
	FROM rooms
	FULL JOIN grouprooms
	ON rooms.room_id = grouprooms.room_id
	FULL JOIN groups
	ON grouprooms.group_id = groups.group_id
	ORDER BY rooms.room_name;

-- A list of users, the groups that they belong to, and the rooms to which they are assigned. This should be sorted alphabetically 
-- by user, then by group, then by room.

SELECT
	people.person_name AS "User",
	groups.group_name AS "Group",
	rooms.room_name AS "Room"
	FROM people
	FULL JOIN groups
	ON people.group_id = groups.group_id
	FULL JOIN grouprooms
	ON groups.group_id = grouprooms.group_id
	FULL JOIN rooms
	ON grouprooms.room_id = rooms.room_id
	ORDER BY people.person_name, groups.group_name, rooms.room_name;

