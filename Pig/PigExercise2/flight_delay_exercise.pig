-- 0. Load Data
flights = load '/data/flights.csv' using PigStorage(',') as (YEAR:int,MONTH:int,DAY:int,DAY_OF_WEEK:int,AIRLINE:chararray,FLIGHT_NUMBER:chararray,TAIL_NUMBER:chararray,ORIGIN_AIRPORT:chararray,DESTINATION_AIRPORT:chararray,SCHEDULED_DEPARTURE:int,DEPARTURE_TIME:int,TAXI_OUT:int,WHEELS_OFF:int,SCHEDULED_TIME:int,ELAPSED_TIME:int,AIR_TIME:int,DISTANCE:int,WHEELS_ON:int,TAXI_IN:int,SCHEDULED_ARRIVAL:int,ARRIVAL_TIME:int,DIVERTED:chararray,CANCELLED:chararray,CANCELLATION_REASON:chararray,AIR_SYSTEM_DELAY:int,SECURITY_DELAY:int,AIRLINE_DELAY:int,LATE_AIRCRAFT_DELAY:int,WEATHER_DELAY:int);

airports = load '/data/airports.csv' using PigStorage(',') as (IATA_CODE:chararray,AIRPORT:chararray,CITY:chararray,STATE:chararray,COUNTRY:chararray,LATITUDE:chararray,LONGITUDE:chararray);

--1. Filter airports to those only in Texas

airports_filtered = ?

--2. calculate flight departure delays

flight_with_delay = foreach flights generate YEAR,MONTH,DAY,DAY_OF_WEEK,AIRLINE,FLIGHT_NUMBER,TAIL_NUMBER,ORIGIN_AIRPORT, DESTINATION_AIRPORT,SCHEDULED_DEPARTURE, DEPARTURE_TIME, TAXI_OUT,WHEELS_OFF,SCHEDULED_TIME,ELAPSED_TIME,AIR_TIME,DISTANCE,WHEELS_ON,TAXI_IN,SCHEDULED_ARRIVAL,ARRIVAL_TIME, DIVERTED,CANCELLED,CANCELLATION_REASON,AIR_SYSTEM_DELAY,SECURITY_DELAY,AIRLINE_DELAY,LATE_AIRCRAFT_DELAY,WEATHER_DELAY,? AS DEPARTURE_DELAY,? AS ARRIVAL_DELAY;

--3. filter out nulls in delay time
flight_with_delay_no_null = ?;


--4. summary of amount of delayed flights over a certain amount of time by month, departure airport, and airline 

flight_airport_departure = ?;



--5. Calculate average departure delay, count the number of delays over 20 minutes, calculate max and min
summary_data = foreach flight_airport_departure {
    average_delay = ?
    limited = ? 
    count = ? 
    max = ?
    min = ?
    GENERATE FLATTEN(group),count,average_delay as AVG, min as MIN, max as MAX;
}

--6. JOIN WITH AIRPORT DATA using REPLICATED JOIN
joined_data = ?;

describe joined_data;

--7. Sort data by AIRPORT, YEAR, MONTH
final = ?;
dump final;
