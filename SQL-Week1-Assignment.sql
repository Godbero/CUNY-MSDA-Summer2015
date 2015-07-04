-- SQL WEEK 1 Assignment

-- 1. Show the total number of flights.
-- This depends on how we define a flight. If each row is a flight, then this gives 336,776
SELECT
COUNT(*) AS "Number of Flights"
FROM flights;

-- If we check a field to verify we flew, we might check air time and get 327,346
SELECT
COUNT(*) AS "Number of Flights"
FROM flights
WHERE air_time > 0;

-- Or, we might check distance and get 336,776, which makes mw think air_time is not a great field
SELECT
COUNT(*) AS "Number of Flights"
FROM flights
WHERE distance > 0;

-- 2. Show the total number of flights by airline (carrier).
SELECT
carrier AS "Airline", COUNT(*) AS "Number of Flights"
FROM flights
GROUP BY carrier
ORDER BY carrier;

-- 3. Show all of the airlines, ordered by number of flights in descending order.
SELECT
carrier AS "Airline", COUNT(*) AS "Number of Flights"
FROM flights
GROUP BY carrier
ORDER BY "Number of Flights" DESC;

-- 4. Show only the top 5 airlines, by number of flights, ordered by number of flights in descending order.
SELECT
carrier AS "Airline", COUNT(*) AS "Number of Flights"
FROM flights
GROUP BY carrier
ORDER BY "Number of Flights" DESC
LIMIT 5;

-- 5. Show only the top 5 airlines, by number of flights of distance 1,000 miles or greater, ordered by number of flights in descending order.
SELECT
carrier AS "Airline", COUNT(*) AS "Number of Flights"
FROM flights
WHERE distance >= 1000
GROUP BY carrier
ORDER BY "Number of Flights" DESC
LIMIT 5;

-- 6. Create a question that (a) uses data from the flights database, and (b) requires aggregation to answer it, and write down both the question, and the query that answers the question.
-- In what month do airlines have the most departure delays and what airlines have the most
SELECT
month AS "Month", carrier AS "Airline", count(*) AS "Delays"
FROM flights
WHERE dep_delay >0
GROUP BY month, carrier
ORDER BY month, "Delays" DESC;
