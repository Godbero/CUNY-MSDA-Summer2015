-- SQL Week 2 Assignment

-- 1. What weather conditions are associated with New York City departure delays?

-- First I wanted to understand something about delays. Out of a total of 336,776 flights, 128,432
-- had a departure delay, or over 38% of the flights. If we look at delays over 30 minutes we get 
-- 48,291 or 14.3%, over 60 minutes were 27,059 or 8.0% and delays over 120 minutes were 9,723 or 
-- 2.9%. -- So, delays are not unusual, they happened over a third of the time. However, they seem
-- to drop of fast.

SELECT month, day, dep_time, dep_delay, origin
	FROM flights
	WHERE dep_delay > 0
	ORDER BY dep_delay DESC;

-- Now I need to understand the weather table. There are 8,719 records in the table: 8.709 are from
-- EWR (Newark), 9 are from JFK, and 1 is from LGA. We can only use ERW weather data for NYC, since
-- that's all we have. There 52,711 delayed flights from EWR in the flights table.

SELECT * FROM weather
	WHERE origin = 'EWR';

-- Next let's work on a usuable view of the weather data where we combine the date and time fields
-- to link with flights

SELECT 
	year || '-' || month || '-' || day || '-' || hour AS Time,
	temp,
	dewp,
	humid,
	wind_dir,
	wind_speed,
	wind_gust,
	precip,
	pressure,
	visib
	FROM weather
	WHERE origin = 'EWR';

-- Now let's work on combining the date and time in flights to make a subset. I cannot think of 
-- another way to create a field to join on besides making a Time subset for each hour.

SELECT 
	year || '-' || month || '-' || day || '-' || '0' AS Time,
	dep_time,
	dep_delay,
	arr_time,
	arr_delay,
	carrier,
	tailnum,
	flight,
	origin,
	dest,
	air_time,
	distance
	FROM flights
	WHERE origin = 'EWR' AND dep_time >= 0 AND dep_time < 100;

SELECT 
	year || '-' || month || '-' || day || '-' || '1' AS Time,
	dep_time,
	dep_delay,
	arr_time,
	arr_delay,
	carrier,
	tailnum,
	flight,
	origin,
	dest,
	air_time,
	distance
	FROM flights
	WHERE origin = 'EWR' AND dep_time >= 100 AND dep_time < 200;

SELECT 
	year || '-' || month || '-' || day || '-' || '2' AS Time,
	dep_time,
	dep_delay,
	arr_time,
	arr_delay,
	carrier,
	tailnum,
	flight,
	origin,
	dest,
	air_time,
	distance
	FROM flights
	WHERE origin = 'EWR' AND dep_time >= 200 AND dep_time < 300;

SELECT 
	year || '-' || month || '-' || day || '-' || '3' AS Time,
	dep_time,
	dep_delay,
	arr_time,
	arr_delay,
	carrier,
	tailnum,
	flight,
	origin,
	dest,
	air_time,
	distance
	FROM flights
	WHERE origin = 'EWR' AND dep_time >= 300 AND dep_time < 400;

SELECT 
	year || '-' || month || '-' || day || '-' || '4' AS Time,
	dep_time,
	dep_delay,
	arr_time,
	arr_delay,
	carrier,
	tailnum,
	flight,
	origin,
	dest,
	air_time,
	distance
	FROM flights
	WHERE origin = 'EWR' AND dep_time >= 400 AND dep_time < 500;


SELECT 
	year || '-' || month || '-' || day || '-' || '5' AS Time,
	dep_time,
	dep_delay,
	arr_time,
	arr_delay,
	carrier,
	tailnum,
	flight,
	origin,
	dest,
	air_time,
	distance
	FROM flights
	WHERE origin = 'EWR' AND dep_time >= 500 AND dep_time < 600;


-- I am not sure if doing this 24 times is the best way, but I am geting what I visualized. I also
-- discovered that although there no flights between 3 and 4 AM, there were over 300 between 4 and 5.
-- My plan is to UNION my 24 flight tables (or views) into one new flights table with the Time column.
-- I would then JOIN this new flights table with my new weather table above on Time, adding the 
-- weather data to each flight

CREATE VIEW NEWflights AS
SELECT 
	year || '-' || month || '-' || day || '-' || '4' AS Time,
	dep_time,
	dep_delay,
	arr_time,
	arr_delay,
	carrier,
	tailnum,
	flight,
	origin,
	dest,
	air_time,
	distance
	FROM flights
	WHERE origin = 'EWR' AND dep_time >= 400 AND dep_time < 500
	UNION
	SELECT 
	year || '-' || month || '-' || day || '-' || '5' AS Time,
	dep_time,
	dep_delay,
	arr_time,
	arr_delay,
	carrier,
	tailnum,
	flight,
	origin,
	dest,
	air_time,
	distance
	FROM flights
	WHERE origin = 'EWR' AND dep_time >= 500 AND dep_time < 600;

-- We would need to UNION a few more times for the complete new flights table.
-- Here is the new weather table biew.

CREATE VIEW NEWweather AS
SELECT 
	year || '-' || month || '-' || day || '-' || hour AS Time,
	temp,
	dewp,
	humid,
	wind_dir,
	wind_speed,
	wind_gust,
	precip,
	pressure,
	visib
	FROM weather
	WHERE origin = 'EWR';

-- Now we can JOIN these new tables to get weather and flights together

SELECT
	*
	FROM NEWflights
	INNER JOIN NEWweather
	ON NEWFlights.time = NEWweather.time
	WHERE dep_delay > 0
	ORDER BY dep_delay DESC;

-- This seems to give me the results table I had in mind with the weather info for a given hour
-- added to each flight in that hour. My time filed is now character, so sorting is a problem with
-- 1, 10, 11 coming together. Ordering by dep_delay may work best. I also could have selected for
-- dep_delay > 0 for each subset before the UNIONS to leave the non-delays behind.

2. Are older planes more likely to be delayed?

-- I can start by looking at what fields I want from flights and planes. Including making Age.

SELECT month, day, dep_time, dep_delay, origin, tailnum
	FROM flights
	WHERE dep_delay > 0
	ORDER BY dep_delay DESC;

SELECT tailnum, manufacturer, (2015 - year) AS Age
	FROM planes;

-- Then I can do a JOIN yo bting the info together

SELECT 
	month, 
	flights.day, 
	flights.dep_time, 
	flights.dep_delay, 
	flights.origin, 
	flights.tailnum,
	planes.tailnum, 
	planes.manufacturer, 
	(2015 - planes.year) AS Age
	FROM flights
	INNER JOIN planes
	ON flights.tailnum = planes.tailnum
	WHERE dep_delay > 0
	ORDER BY dep_delay DESC;

-- The result is interesting. The longest delay was for relatively young 4 year old plane, however 
-- the rest of the top 10 are all 13 years old or older, with number 2 being 28 years old. This 
-- trend continues with 11 planes over 20 years old out of the top 20 delays and the next "low" 
-- being 11 years old. There would appear to be a correlation between length of delay and age.
-- However, looking at the other end of the table shows a lot of vriation of plane age with short
-- delays of a few minutes. i keep wanting to plot these variables to "see" if there is a trend.

-- 3. Ask (and if possible answer) a third question that also requires joining information from two 
-- or more tables in the flights database, and/or assumes that additional information can be 
-- collected in advance of answering your question.

-- The questions I have now are any plane characteristics related to delays. The hope would be no
-- correltion between plane type, maufacturer, model engines (number of), size (from seats), engine
-- type. I would do a similar JOIN as above with all of planes fields.

SELECT 
	month, 
	flights.day, 
	flights.dep_time, 
	flights.dep_delay, 
	flights.origin, 
	flights.tailnum,
	planes.tailnum, 
	(2015 - planes.year) AS Age,
	planes.type,
	planes.manufacturer,
	planes.model,
	planes.engines,
	planes.seats,
	planes.speed,
	planes.engine
	FROM flights
	INNER JOIN planes
	ON flights.tailnum = planes.tailnum
	WHERE dep_delay > 0
	ORDER BY dep_delay DESC;

-- Does length of delay relate to any plane attribute? Looking at the top 30 delay times they are 
-- all "fixed wing nulti engine", they were all 2 engines, and they were all had turbo-fan engines.
-- This gives me the idea that these may not be important fields. The number of seats giving us a 
-- size, is 100 and above for all but 1 plane (55) in the top 30. Telling me I may want to look at
-- plane size.
