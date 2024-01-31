-- find out how many units are sold for different type of unit --

SELECT sum(1room_sold), sum(2room_sold), sum(3room_sold), sum(4room_sold), sum(5room_sold), sum(exec_sold), sum(multigen_sold), sum(studio_apartment_sold), 
sum(1room_sold + 2room_sold + 3room_sold + 4room_sold + 5room_sold + exec_sold + multigen_sold + studio_apartment_sold) AS Total
FROM hdb_properties_info.hdbpropertyinformation;

-- Find out the most popular type of unit sold --

SELECT  CASE GREATEST(sum(1room_sold), sum(2room_sold), sum(3room_sold), sum(4room_sold), sum(5room_sold), sum(exec_sold), sum(multigen_sold), sum(studio_apartment_sold))
			WHEN sum(1room_sold)				THEN '1room'
            WHEN sum(2room_sold)				THEN '2room'
            WHEN sum(3room_sold)				THEN '3room'
            WHEN sum(4room_sold)				THEN '4room'
            WHEN sum(5room_sold)				THEN '5room'
            WHEN sum(exec_sold)					THEN 'exec'
            WHEN sum(multigen_sold)				THEN 'multigen'
            WHEN sum(studio_apartment_sold)		THEN 'studio'
		END AS Most_popular
FROM hdb_properties_info.hdbpropertyinformation;

-- find out the percentage of 3room sold / total units sold --

SELECT ROUND((3room / Total) * 100, 2)  AS Percentage_3room_sold
FROM (
		SELECT
			sum(3room_sold) AS 3room,
            sum(1room_sold + 2room_sold + 3room_sold + 4room_sold + 5room_sold + exec_sold + multigen_sold + studio_apartment_sold) AS Total
		FROM hdb_properties_info.hdbpropertyinformation
	) sub;
    
-- which building has the highest floor --

SELECT blk_no, street, max_floor_lvl
FROM hdb_properties_info.hdbpropertyinformation
ORDER BY (max_floor_lvl) DESC
LIMIT 1;

-- list of building that complete between year 200 and 2010 --

SELECT *
FROM hdb_properties_info.hdbpropertyinformation
WHERE year_completed BETWEEN 2001 AND 2010
ORDER BY year_completed DESC;

-- The numbers of building completed in the year of 2005 --
SELECT count(blk_no) AS Buildings_completed_in_2005
FROM hdb_properties_info.hdbpropertyinformation
WHERE year_completed = 2005;

-- The number of building completed in the year between 2001 and 2010 --

SELECT count(blk_no) AS Number_of_Buildings, year_completed
FROM hdb_properties_info.hdbpropertyinformation
WHERE year_completed BETWEEN 2001 AND 2010
GROUP BY year_completed
ORDER BY year_completed DESC;
		