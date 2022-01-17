#Retrieve all employees whose address is in Elgin,IL.
select * from employees where address like '%Elgin,IL%';

##Retrieve all employees who were born during the 1970's.
select * from employees where B_DATE like '197%';

#Retrieve all employees in department 5 whose salary is between 60000 and 70000.
select * from employees where salary >= '60000'
and salary <= '70000'  and DEP_ID='5';

#Retrieve a list of employees ordered by department ID.
select * from employees order by dep_id

#Retrieve a list of employees ordered in descending order by department ID and within each department ordered alphabetically in descending order by last name.
select * from employees order by dep_id desc, l_name desc;

#In previous problem, use department name instead of department ID. Retrieve a list of employees ordered by department name, and within each department ordered alphabetically in descending order by last name.
select d.dep_name, e.f_name, e.l_name 
from employees as e, departments as d 
where e.dep_id=d.DEPT_ID_DEP 
order by d.dep_name, e.l_name desc;
select * from departments;

#For each department ID retrieve the number of employees in the department.
select dep_id ,count(emp_id) as NUM_EMPLOYEES 
from employees group by dep_id;

#For each department retrieve the number of employees in the department, and the average employee salary in the department..
select dep_id, avg(salary) as AVG_SALARY,count(emp_id) as NUM_EMPLOYEES 
from employees group by dep_id;

#In previous problem order the result set by Average Salary.
select dep_id, avg(salary) as AVG_SALARY,count(emp_id) as NUM_EMPLOYEES 
from employees group by dep_id order by AVG_SALARY;

#In previous problem  limit the result to departments with fewer than 4 employees.
select dep_id, avg(salary) as AVG_SALARY,count(emp_id) as NUM_EMPLOYEES 
from employees group by dep_id having count(*) < 4 order by AVG_SALARY;



