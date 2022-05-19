--Display the age and name for the pilot who was the oldest when HIRED.
SELECT * from (select pil_pilotname, round((pil_hiredate- pil_brthdate) / 365.242199, 2) as Age FROM pilots order by age desc) where ROWNUM <= 1; 

--Using a SET OPERATOR, display the pilots and the number of miles flown as "Miles Flown", include pilots who have not yet flown (for those pilots, display “0” for miles flown”). 
select p.pil_pilotname, case 
    when sum(f.fl_distance)=0 then 0 
    else sum(f.fl_distance)
end  as "Miles Flown" 
from pilots p 
inner join departures d on ( p.pil_pilot_id=d.dep_pilot_id or (p.pil_pilot_id is null and d.dep_pilot_id is null ) )
inner join flight f on (f.fl_flight_no=d.dep_flight_no or (f.fl_flight_no is null and d.dep_flight_no is null))
inner join ticket t on d.dep_dep_date = t.tic_flight_date
and d.dep_flight_no = t.tic_flight_no
group by p.pil_pilotname;

--Parse Pilot Names into First Name / Middle Initial, and Last Name
select 
  TRIM(trailing ',' from substr(pil_pilotname, 1, instr(pil_pilotname, ','))) as "FIRST NAME",
  substr(pil_pilotname, instr(pil_pilotname, ' '))    as "LAST NAME"
from pilots;

--List the pilots that are paid above the average for their state and the state average pay.
with temp as(
select pil_pilotname, pil_state, pil_flight_pay as "Flight Pay",
AVG(pil_flight_pay) OVER(PARTITION BY pil_state) AS "Average State Pay"
from pilots)
select * from  temp where "Flight Pay"<"Average State Pay";

--Display the name of the pilot, pay and age of the pilot who has the maximum pay of pilots under the age of 50 (Hint, you must calculate age using pil_birthdate and sysdate).
select pil_pilotname, pil_flight_pay, round((sysdate - pil_brthdate) / 365.242199, 2) as Age 
from pilots where round((sysdate - pil_brthdate) / 365.242199, 2) < 50;

--Using a SUB QUERY, display the flight number, originating airport, destination airport, departure time as "Departure Time", and arrival time as "Arrival Time" for flights not departing on May 17, 2017.
select f.fl_flight_no,f.fl_orig,f.fl_dest,
to_char(f.fl_orig_time, 'HH24:MI') as "Departure Time", 
to_char(f.fl_dest_time, 'HH24:MI') as "Arrival Time"
from Flight f where f.fl_orig_time  not in (select fl_orig_time from Flight where fl_orig_time='17-MAY-17') order by f.fl_flight_no ;

--Using a SET OPERATION, display the flight number, originating airport, destination airport, departure time as "Departure Time", and arrival time as "Arrival Time" for flights not departing on May 17, 2017.
select f.fl_flight_no,f.fl_orig,f.fl_dest,
to_char(f.fl_orig_time, 'HH24:MI') as "Departure Time" , 
to_char(f.fl_dest_time, 'HH24:MI') as "Arrival Time"  from Flight f 
union 
select f1.fl_flight_no,f1.fl_orig,f1.fl_dest,
to_char(f1.fl_orig_time, 'HH24:MI') as "Departure Time" , 
to_char(f1.fl_dest_time, 'HH24:MI') as "Arrival Time" 
from Flight f1 where f1.fl_orig <> '17-MAY-17';

--Using a SUB QUERY, list pilot names for pilots who have no scheduled departures in May 2017. 
select p.pil_pilotname from pilots p where p.pil_pilot_id
not in(select d.dep_pilot_id from departures d WHERE to_char(to_date(d.dep_dep_date), 'MON-YYYY') = 'MAY-2017')
order by p.pil_pilotname;

--Using a SET OPERATION, list pilot names for pilots who have no scheduled departures in May 2017
select p.pil_pilotname from pilots p
minus
select p1.pil_pilotname from departures d, pilots p1 
WHERE p1.pil_pilot_id = d.dep_pilot_id and to_char((d.dep_dep_date), 'MON-YYYY') = 'MAY-2017';

--Find the number of passengers that have the same last name. Display the number of passengers with each last name, ordered by number of passengers per last name in descending order.
select  substr(pas_name, instr(pas_name, ' ')) as "Last Name", count(*) as Passengers
from passenger group by substr(pas_name, instr(pas_name, ' ')) order by  count(*) desc;
