create temporary table employees.start_employee_date
	select e.emp_no, min(t.from_date) as start_date 
	from employees.employees e join employees.titles t on e.emp_no = t.emp_no
	group by e.emp_no;

create temporary table employees.end_employee_date
	select e.emp_no, max(t.to_date) as end_date 
	from employees.employees e join employees.titles t on e.emp_no = t.emp_no
	group by e.emp_no;	

create temporary table employees.current_employee_title
	select e.emp_no, e.first_name, e.last_name, t.title as end_title, t.to_date as end_date from 
	employees.employees e join employees.titles t on e.emp_no = t.emp_no
	where t.to_date = "9999-01-01";
    
create temporary table employees.end_employee_title
	select e.emp_no, t.title as end_title from 
	employees.end_employee_date e join employees.titles t on e.emp_no = t.emp_no
	where e.end_date = t.to_date;

create temporary table employees.start_employee_title
	select e.emp_no, t.title as start_title from 
	employees.start_employee_date e join employees.titles t on e.emp_no = t.emp_no
	where e.start_date = t.from_date;

create temporary table employees.start_employee
	select e.emp_no, t.start_title, e.start_date from
	employees.start_employee_date e join employees.start_employee_title t on e.emp_no = t.emp_no;

create temporary table employees.end_employee
	select e.emp_no, t.end_title, e.end_date from
	employees.end_employee_date e join employees.end_employee_title t on e.emp_no = t.emp_no;

select a.last_name, a.first_name, b.end_title, b.end_date, b.start_title, b.start_date
from employees.employees a join (select e.emp_no, e.end_title, e.end_date, t.start_title, t.start_date from
employees.end_employee e join employees.start_employee t on e.emp_no = t.emp_no) b on a.emp_no = b.emp_no
order by a.last_name, a.first_name
limit 20;