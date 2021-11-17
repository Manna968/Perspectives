select a.title, a.gender, avg(a.salary)
from ( select s.emp_no, s.salary, e.gender, t.title
    from employees.salaries s join employees.employees e
       on s.emp_no = e.emp_no
       join employees.titles t
       on s.emp_no = t.emp_no
       where s.to_date = '9999-01-01' and t.to_date = '9999-01-01'
       ) a
       group by a.gender, a.title;