use employees;
create temporary table female_salary
	select avg(bb.b) as female_salary from
	(select s.salary as b from
	employees e join salaries s on e.emp_no = s.emp_no
	where e.gender = "F") bb; 

create temporary table male_salary
	select avg(aa.a) as male_salary from
	(select s.salary as a from
	employees e join salaries s on e.emp_no = s.emp_no
	where e.gender = "M") aa; 
    
select a. female_salary, b.male_salary from female_salary a
, male_salary b;
