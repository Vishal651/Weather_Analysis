/* SHOW ALL DATABASES */

SHOW DATABASES;

/*CREATE A DATABASE*/

CREATE DATABASE STATION;

/*USE DATA DATABASE*/

USE STATION;

/* Q1: CREATE A TABLE “STATION ” TO STORE INFORMATION ABOUT WEATHER OBSERVATION STATIONS:
      ID          	NUMBER        PRIMARY KEY
      CITY		CHAR(20)
      STATE		CHAR(2)
      LAT_N		REAL
      LONG_W		REAL*/
      
CREATE TABLE STATION(
ID INTEGER PRIMARY KEY,
CITY CHAR(20),
STATE CHAR(2),
LAT_N REAL,
LONG_W REAL);

/*Q2: Insert the following records into the table:
ID		CITY		STATE			LAT_N		LONG_W
13		PHOENIX		AZ			33			112
44		DENVER		CO			40			10
66		CARIBOU		ME			47			68*/

INSERT INTO STATION VALUES (13, 'Phoenix', 'AZ', 33, 112);
INSERT INTO STATION VALUES (44, 'Denver', 'CO', 40, 105);
INSERT INTO STATION VALUES (66, 'Caribou', 'ME', 47, 68);

/*Q3 Execute a query to look at table STATION in undefined order.*/

SELECT * FROM STATION;

/* Q4) Execute a query to select Northern stations (Northern latitude > 39.7).*/ 

SELECT * FROM STATION WHERE LAT_N >39.7;

/* Q5) Create another table, ‘STATS’, to store normalized temperature and precipitation data:
Column					Data type					Remark
ID					Number						ID must match with some ID from the STATION
											table(so name & location will be known).
MONTH					Number						The range of months is between (1 and 12)
TEMP_F					Number						Temperature is in Fahrenheit degrees, Ranging between (80 and 150)
RAIN_I					Number						Rain is in inches, Ranging between (0 and 100)
There will be no Duplicate ID and MONTH combination.*/

CREATE TABLE STATS(
ID INTEGER REFERENCES STATION(ID),
MONTH INTEGER CHECK (MONTH BETWEEN 1 AND 12),
TEMP_F REAL CHECK (TEMP_F BETWEEN 80 AND 150),
RAIN_I REAL CHECK (RAIN_I BETWEEN 0 AND 100),
PRIMARY KEY (ID, MONTH)
);

/* Q6) Populate the table STATS with some statistics for January and July:
ID		MONTH			TEMP_F		RAIN_I
13		1			57.4		.31
13		7			91.7		5.15
44		1			27.3		.18
44		7			74.8		2.11
66		1			6.7		2.1
66		7			65.8		4.52*/

INSERT INTO STATS VALUE (13,1,57.4,.31);
INSERT INTO STATS VALUE (13,7,91.4,5.15);
INSERT INTO STATS VALUE (44,1,27.3,.18);
INSERT INTO STATS VALUE (44,7,74.8,2.11);
INSERT INTO STATS VALUE (66,1,6.7,2.1);
INSERT INTO STATS VALUE (66,7,65.8,4.52);

/* Q7) Execute a query to look at table STATS in undefined order.*/

SELECT * FROM STATS;

/*Q8) Execute a query to display temperature stats (from the STATS table)
 for each city (from the STATION table).*/

SELECT * FROM STATION, STATS WHERE STATION.ID = STATS.ID;

/*Q9) Execute a query to look at the table STATS, ordered by month and greatest rainfall, with columns rearranged.
It should also show the corresponding cities.*/

SELECT CITY, MONTH, STATION.ID, RAIN_I, TEMP_F
FROM STATS
RIGHT JOIN STATION ON STATS.ID = STATION.ID
ORDER BY MONTH, RAIN_I DESC;

/*Q10) Q9) Execute a query to look at temperatures for July from table STATS, lowest temperatures first,
picking up city name and latitude.*/

SELECT TEMP_F, CITY, LAT_N
FROM STATS, Station
WHERE MONTH = 7
AND STATS.ID = Station.ID
ORDER BY TEMP_F;

/*Q11) Execute a query to display each city’s monthly temperature in
Celcius and rainfall in Centimeter.*/

SELECT ST.CITY,S.MONTH,
ROUND(((S.TEMP_F-32) * 5/9), 2) AS TEMPERATURE_CELCIUS,
ROUND((S.RAIN_I * 2.54), 2) AS RAINFALL_CENTIMETER FROM STATS S
JOIN STATION ST
ON S.ID=ST.ID;

/*Q12) Update Denver's July temperature reading as 74.9.*/

UPDATE STATS
SET TEMP_F = 74.9
WHERE ID = 44
AND MONTH = 7;
