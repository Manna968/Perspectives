create temporary table employees.current_employee_salaries
	select a.emp_no, a.title, b.salary
	from employees.titles a join employees.salaries b on a.emp_no = b.emp_no
	where a.to_date = '9999-01-01' and b.to_date = '9999-01-01';

create temporary table employees.current_female_table
	select a.emp_no, a.salary, b.gender
    from employees.current_employee_salaries a join employees.employees b on a.emp_no = b.emp_no
    where b.gender = "F";

create temporary table employees.current_male_table
	select a.emp_no, a.salary, b.gender
    from employees.current_employee_salaries a join employees.employees b on a.emp_no = b.emp_no
    where b.gender = "M";

create temporary table employees.high_female
	select count(distinct emp_no) as hf
    from employees.current_female_table
    where salary >= 100000;

create temporary table employees.high_male
	select count(distinct emp_no) as hm
    from employees.current_male_table
    where salary >= 100000;

create temporary table employees.female
	select count(distinct emp_no) as f
    from employees.current_female_table;
    
create temporary table employees.male
	select count(distinct emp_no) as m
    from employees.current_male_table;

select a.hf/c.f as female_proporation, b.hm/d.m as male_proportion
from employees.high_female a, employees.high_male b, employees.female c, employees.male d; 
    
