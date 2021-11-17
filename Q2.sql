create temporary table employees.female_salary
	select avg(bb.b) as female_salary from
	(select s.salary as b from
	employees.employees e join employees.salaries s on e.emp_no = s.emp_no
	where e.gender = "F") bb; 

create temporary table employees.male_salary
	select avg(aa.a) as male_salary from
	(select s.salary as a from
	employees.employees e join employees.salaries s on e.emp_no = s.emp_no
	where e.gender = "M") aa; 
    
select a.female_salary as female_avg_salary, b.male_salary as male_avg_salary from employees.female_salary a
, employees.male_salary b;
