/*
select * 
from employees 
limit 10;

select * 
from employees 
where birth_date = '1953-09-02'
limit 10;

select * 
from employees 
where year(birth_date) = 1953
limit 10;

select year(hire_date) - year(birth_date)
from employees 
limit 10;

select floor(datediff(hire_date, birth_date)/365)
from employees 
limit 10;

select floor(datediff(to_date, from_date)/365), salary
from salaries
where emp_no=10001;

select count(*)
from salaries
where '2001-12-31' between from_date and to_date;

select monthname('2001-12-31'), year('2001-12-31'), sum(salary)
from salaries
where '2001-12-31' between from_date and to_date;

select year(from_date), sum(salary) as total
from salaries
group by year(from_date) 
order by total desc;

select distinct(title)
from titles;

select emp_no
from titles
where title = 'Senior Engineer' and
'2001-12-31' between from_date and to_date

select first_name, last_name, salary
from employees inner join salaries on employees.emp_no = salaries.emp_no
where employees.emp_no IN(
select emp_no
from titles
where title = 'Senior Engineer' and
'2001-12-31' between from_date and to_date) and 
'2001-12-31' between from_date and to_date
order by salary desc;
*/