#Create a view for employees table
create view emp_salary as 
select emp_id, f_name, l_name, sex, b_date, salary from employees;

#Create view 
create or replace view emp_salary as 
select emp_id, f_name, l_name, sex, b_date, salary, 
job_title, min_salary, max_salary from employees as e, jobs as j
where e.job_id=j.job_ident;

select * from emp_salary;


