use employees;
create temporary table current_employee_salaries
	select a.emp_no, a.title, b.salary
	from titles a join salaries b on a.emp_no = b.emp_no
	where a.to_date = '9999-01-01' and b.to_date = '9999-01-01';

create temporary table current_female_table
	select a.emp_no, a.salary, b.gender
    from current_employee_salaries a join employees b on a.emp_no = b.emp_no
    where b.gender = "F";

create temporary table current_male_table
	select a.emp_no, a.salary, b.gender
    from current_employee_salaries a join employees b on a.emp_no = b.emp_no
    where b.gender = "M";

create temporary table high_female
	select count(distinct emp_no) as hf
    from current_female_table
    where salary >= 100000;

create temporary table high_male
	select count(distinct emp_no) as hm
    from current_male_table
    where salary >= 100000;

create temporary table female
	select count(distinct emp_no) as f
    from current_female_table;
    
create temporary table male
	select count(distinct emp_no) as m
    from current_male_table;

select a.hf/c.f as female_proporation, b.hm/d.m as male_proportion
from high_female a, high_male b, female c, male d; 
    
