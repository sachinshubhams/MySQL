/*1*/
select pas_name,pas_itinerary_no, pas_fare, pas_confirm_no from passenger ;
/*2*/
select pil_pilotname,pil_state,pil_city,pil_zip,pil_flight_pay from pilots where pil_state='TX' or  pil_state='AZ' and pil_flight_pay>'2500' order by pil_flight_pay desc;
/*3*/
select pil_pilotname,pil_state,pil_city,pil_zip,pil_flight_pay from pilots where pil_state IN ('TX','AZ') and pil_flight_pay>'2500' order by pil_flight_pay desc;
/*4 Not matching*/
select pil_pilotname,pil_state,pil_city,pil_zip,pil_flight_pay from pilots where pil_state='TX' and pil_flight_pay>'2500' UNION
select pil_pilotname,pil_state,pil_city,pil_zip,pil_flight_pay from pilots where pil_state='AZ' and pil_flight_pay>'2500' order by pil_flight_pay desc;
/*5 Not matching*/
select eq_equip_no,eq_equip_type,eq_seat_capacity,eq_fuel_capacity,eq_miles_per_gal from equip_type where eq_seat_capacity>'300' or eq_miles_per_gal>'3.5'
and eq_seat_capacity<2500 order by eq_equip_no;
/*6 Not matching*/
select eq_equip_no,eq_equip_type,eq_seat_capacity,eq_fuel_capacity,eq_miles_per_gal from equip_type where eq_seat_capacity>'300' and eq_seat_capacity<2500 UNION 
select eq_equip_no,eq_equip_type,eq_seat_capacity,eq_fuel_capacity,eq_miles_per_gal from equip_type where eq_miles_per_gal>'3.5' and eq_seat_capacity<2500 order by eq_equip_no;
/*7*/
select AIR_CODE,AIR_LOCATION,AIR_ELEVATION,AIR_PHONE,AIR_HUB_AIRLINE from airport where air_location LIKE '%TX';
/*8*/
select dep_pilot_id as "Pilot ID" from departures group by dep_pilot_id HAVING count(dep_flight_no)>'20' order by dep_pilot_id asc;
/*9 wrong output given in question*/
select fl_flight_no as "Flight Number" ,fl_fare as "Fare",fl_distance as "Distance",CAST((fl_distance/fl_fare)as NUMERIC(12,2)) as "Miles Flown Per Dollar" from flight where (fl_distance/fl_fare)>'5.50' order by "Miles Flown Per Dollar" desc;
/*10 Number_of_departing_Flights vary*/
select airport.air_location, count(flight.fl_dest) as Number_of_departing_Flights from airport inner join flight on  flight.fl_dest=airport.air_code group by airport.air_location; 
/*11*/
select Upper(pil_state) as States ,max(pil_flight_pay) as Max_Pay, min(pil_flight_pay) as Min_Pay, avg(pil_flight_pay) as Avg_Pay from pilots group by Upper(pil_state);
/*12*/
select pilots.PIL_PILOTNAME, min(departures.DEP_DEP_DATE) as First_Departure  from pilots inner join departures on  pilots.PIL_PILOT_ID =departures.DEP_PILOT_ID group by pilots.PIL_PILOTNAME order by pilots.PIL_PILOTNAME;
/*13*/
select eq_equip_type, max(EQ_miles_per_gal * EQ_fuel_capacity) as "Maximum Distance Flown" from equip_type group by eq_equip_type order by "Maximum Distance Flown" desc;
/*14*/
select FL_ORIG, count(FL_ORIG) as NUMBER_OF_FLIGHTS from flight group by FL_ORIG;
/*15 wrong output given in question*/
select eq_equip_type, max(eq_miles_per_gal*eq_fuel_capacity) as "Maximum Distance Flown" from equip_type group by eq_equip_type order by "Maximum Distance Flown" asc;