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
select * from airport where air_location LIKE '%TX';
/*8*/
select dep_pilot_id as Pilot_ID from departures group by dep_pilot_id HAVING count(dep_flight_no)>'20' order by dep_pilot_id asc;
/*9 wrong output given in question*/
select fl_flight_no as Flight_Number ,fl_fare as Fare,fl_distance as Distance,CAST((fl_distance/fl_fare)as NUMERIC(12,2)) as Miles_Flown_Per_Dollar from flight where (fl_distance/fl_fare)>'5.50' order by Miles_Flown_Per_Dollar desc;
/*10 Number_of_departing_Flights vary*/
select airport.air_location, count(flight.fl_dest) as Number_of_departing_Flights from airport inner join flight on  flight.fl_dest=airport.air_code group by airport.air_location; 
/*11*/
select * from pilots;

