--List all the people in the passenger table, including their name, itinerary number, fare, and confirmation number. Order by name and fare
select pas_name,pas_itinerary_no, pas_fare, pas_confirm_no from passenger ;

--Using an “OR” operator, list pilot name, state, zip code, and flight pay for pilots who make more than $2,500 per flight and live in either the state TX or AZ. Order by pay in descending order.
select pil_pilotname,pil_state,pil_city,pil_zip,pil_flight_pay from pilots where pil_state='TX' or  pil_state='AZ' and pil_flight_pay>'2500' order by pil_flight_pay desc;

--Using an “IN”, list pilot names, zip and flight pay for pilots who make more than $2,500 per flight and live in either the state TX or AZ. Order by pay in descending order.
select pil_pilotname,pil_state,pil_city,pil_zip,pil_flight_pay from pilots where pil_state IN ('TX','AZ') and pil_flight_pay>'2500' order by pil_flight_pay desc;

--Using a SET OPERATOR, list pilot names, zip and flight pay for pilots who make more than $2,500 per flight and live in either the state TX or AZ. Order by pay in descending order.
select pil_pilotname,pil_state,pil_city,pil_zip,pil_flight_pay from pilots where pil_state='TX' and pil_flight_pay>'2500' UNION
select pil_pilotname,pil_state,pil_city,pil_zip,pil_flight_pay from pilots where pil_state='AZ' and pil_flight_pay>'2500' order by pil_flight_pay desc;

--Using an “AND” and an “OR”, list all information (Equipment Number, Equipment Type, Seat Capacity, Fuel Capacity, and Miles per Gallon) on aircraft that have a seat capacity greater than 300, or aircraft that have a miles per gallon greater than 3.0 miles per gallon and fuel capacity less than 2500. Order by EQ_EQUIP_No.
select eq_equip_no,eq_equip_type,eq_seat_capacity,eq_fuel_capacity,eq_miles_per_gal from equip_type where eq_seat_capacity>'300' or eq_miles_per_gal>'3.5'
and eq_seat_capacity<2500 order by eq_equip_no;

--Using a SET OPERATION, list all information (Equipment Number, Equipment Type, Seat Capacity, Fuel Capacity, and Miles per Gallon) on aircraft that have a seat capacity greater than 300, or aircraft that have a miles per gallon greater than 3.0 miles per gallon and fuel capacity less than 2500. Order by EQ_EQUIP_No.
select eq_equip_no,eq_equip_type,eq_seat_capacity,eq_fuel_capacity,eq_miles_per_gal from equip_type where eq_seat_capacity>'300' and eq_seat_capacity<2500 UNION 
select eq_equip_no,eq_equip_type,eq_seat_capacity,eq_fuel_capacity,eq_miles_per_gal from equip_type where eq_miles_per_gal>'3.5' and eq_seat_capacity<2500 order by eq_equip_no;

--Using PATTERN MATCHING, select all information for airports in TX.
select AIR_CODE,AIR_LOCATION,AIR_ELEVATION,AIR_PHONE,AIR_HUB_AIRLINE from airport where air_location LIKE '%TX';

--Using a HAVING statement, produce a unique list of pilot Id's as "Pilot ID" of pilots who piloted more than 20 departures. Order by pilot id ascending.
select dep_pilot_id as "Pilot ID" from departures group by dep_pilot_id HAVING count(dep_flight_no)>'20' order by dep_pilot_id asc;

--List all flights showing flight number, flight fare, flight distance, and the miles flown per dollar (distance/fare) as “Miles Flown Per Dollar” that have miles per dollar greater than $5.50, and sort by miles flown per dollar descending.
select fl_flight_no as "Flight Number" ,fl_fare as "Fare",fl_distance as "Distance",CAST((fl_distance/fl_fare)as NUMERIC(12,2)) as "Miles Flown Per Dollar" from flight where (fl_distance/fl_fare)>'5.50' order by "Miles Flown Per Dollar" desc;

--Display airport location and number of departing flights as "Number of departing Flights".
select airport.air_location, count(flight.fl_dest) as Number_of_departing_Flights from airport inner join flight on  flight.fl_dest=airport.air_code group by airport.air_location; 

--List the maximum pay, minimum pay and average flight pay by state for pilots. Make sure to name the attributes as shown in the example output.
select Upper(pil_state) as States ,max(pil_flight_pay) as Max_Pay, min(pil_flight_pay) as Min_Pay, avg(pil_flight_pay) as Avg_Pay from pilots group by Upper(pil_state);

--Display pilot name and departure date of his first flight. Order by pilot name.
select pilots.PIL_PILOTNAME, min(departures.DEP_DEP_DATE) as First_Departure  from pilots inner join departures on  pilots.PIL_PILOT_ID =departures.DEP_PILOT_ID group by pilots.PIL_PILOTNAME order by pilots.PIL_PILOTNAME;

--For each unique equipment type, List the equipment types and maximum miles that can be flown as "Maximum Distance Flown". Order by maximum distance descending.
select eq_equip_type, max(EQ_miles_per_gal * EQ_fuel_capacity) as "Maximum Distance Flown" from equip_type group by eq_equip_type order by "Maximum Distance Flown" desc;

--List the number of flights originating from each airport as NUMBER_OF_FLIGHTS.
select FL_ORIG, count(FL_ORIG) as NUMBER_OF_FLIGHTS from flight group by FL_ORIG;

--List the equipment type and max distance possible on a full tank of fuel for each plane with a maximum distance greater than 8600. Order by maximum distance, from lowest to highest
select eq_equip_type, max(eq_miles_per_gal*eq_fuel_capacity) as "Maximum Distance Flown" from equip_type group by eq_equip_type order by "Maximum Distance Flown" asc;