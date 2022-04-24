--1
select f.fl_flight_no,f.fl_orig,f.fl_dest, a.air_hub_airline 
from Flight f 
inner join Airport a on a.air_code=f.fl_dest
where a.air_hub_airline is null or a.air_hub_airline='American'
order by f.fl_orig;

--2
select * from 
(
select f.fl_flight_no, f.fl_orig, f.fl_dest, a.air_hub_airline from flight f inner join Airport a on (f.fl_dest = a.air_code)
where a.air_hub_airline='American' 
union all
select f.fl_flight_no, f.fl_orig, f.fl_dest, a.air_hub_airline from flight f inner join Airport a on (f.fl_dest = a.air_code)
where a.air_hub_airline is null
)
flight 
order by fl_orig;

--3
select d.dep_flight_no, d.dep_dep_date, e.eq_equip_type 
from departures d 
inner join equip_type e 
on d.dep_equip_no=e.eq_equip_no 
where e.eq_equip_type='CONCORDE'
order by d.dep_dep_date, d.dep_flight_no;

--4
select p.pil_pilot_id, p.pil_pilotname from pilots p
MINUS
select distinct(d.dep_pilot_id), p.pil_pilotname from departures d, pilots p;

--5
select p.pil_pilot_id, p.pil_pilotname 
from pilots p 
where p.pil_pilot_id 
not in (select dep_pilot_id from departures) ;

--6
select p.pil_pilot_id, p.pil_pilotname 
from pilots p 
left join departures d 
on  p.pil_pilot_id= d.dep_pilot_id 
where d.dep_pilot_id is null;

--7
select p.pas_name, t.tic_seat as "Seat Number"
from passenger p 
inner join ticket t 
on p.pas_itinerary_no=t.tic_itinerary_no 
where t.tic_flight_no='101' and t.tic_flight_date='15-JUL-17' order by t.tic_seat;

--8
select d.dep_flight_no, d.dep_dep_date, count(t.tic_itinerary_no) as "Number of Passengers"
from departures d 
inner join ticket  t 
on d.dep_flight_no=t.tic_flight_no
group by D.DEP_Flight_no, d.dep_dep_date having count(t.tic_itinerary_no)>'5';

--9
select f.fl_flight_no, f.fl_orig, f.fl_dest 
from Flight f 
inner join reservation r 
on f.fl_flight_no=r.res_flight_no 
where r.res_name='Andy Anderson' order by f.fl_flight_no;

--10
select 
(select air_location from airport where air_code = f.fl_orig) as "Departs From",
(select air_location from airport where air_code = f.fl_dest) as "Arrives At", 
min(f.fl_fare) AS "Minimum Fare" 
from flight f 
CROSS join airport a
group by f.fl_orig, f.fl_dest ;

