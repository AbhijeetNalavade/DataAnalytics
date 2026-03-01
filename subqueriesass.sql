create database subqueries;
use subqueries;
create table Employee
(emp_id int, name varchar(50), department_id varchar(10), salary int);
insert into Employee
values
(101,"Abhishek","D01",62000),
(102,"Shubham","D01",58000),
(103,"Priya","D02",67000),
(104,"Rohit","D02",64000),
(105,"Neha","D03",72000),
(106,"Aman","D03",55000),
(107,"Ravi","D04",60000),
(108,"Sneha","D04",75000),
(109,"Kiran","D05",70000),
(110,"Tanuja","D05",65000);

select * from employee;

create table Department
(department_id varchar(10),department_name varchar(50),location varchar(50));
insert into Department
values
("D01","Sales","Mumbai"),
("D02","Marketing","Delhi"),
("D03","Finance","Pune"),
("D04","HR","Bengaluru"),
("D05","IT","Hyderabad");

select * from Department;

create table Sales
(sale_id int,emp_id int,sale_amount int,sale_date date);
insert into Sales
values
(201,101,4500,"2025-01-05"),
(202,102,7800,"2025-01-10"),
(203,103,6700,"2025-01-14"),
(204,104,12000,"2025-01-20"),
(205,105,9800,"2025-02-02"),
(206,106,10500,"2025-02-05"),
(207,107,3200,"2025-02-09"),
(208,108,5100,"2025-02-15"),
(209,109,3900,"2025-02-20"),
(210,110,7200,"2025-03-01");

select * from sales;

###15 Daily Practice Problems (DPP) on Subqueries
###Basic Level
##Q1.Retrieve the names of employees who earn more than the average salary of all employees.
##average salary is 64800 of all employees
select 
`name`,
round(avg(salary),0) as averagesalary
from employee
where salary > (select avg(salary)
               from employee)
group by `name`
order by averagesalary desc;

###Find the employees who belong to the department with the highest average salary.
select `name`, department_id,salary
from employee
where department_id = ( select department_id
					 from employee
                     group by department_id 
                     order by avg(salary) desc
                     limit 1
                     );

##List all employees who have made at least one sale.
select e.`name`
from employee e join sales s 
on e.emp_id = s.emp_id;

##Find the employee with the highest sale amount
select e.emp_id,e.`name`,max(sale_amount) as highest_sales_amount
from employee e join sales s 
on e.emp_id = s.emp_id
group by  e.name,e.emp_id
order by highest_sales_amount desc
limit 1;

###Retrieve the names of employees whose salaries are higher than Shubham’s salary.

select name,salary
from employee
where salary > (select salary
                from employee
                where name = "shubham");
                
##Intermediate Level

##Find employees who work in the same department as Abhishek.

select name
from employee
where department_id = ( select department_id 
                        from employee
                        where name = "abhishek")
                        AND name != "Abhishek";
  
###List departments that have at least one employee earning more than ₹60,000.
select distinct d.department_name
from department d join employee e
on d.department_id = e.department_id
where e.salary > 60000
group by d.department_name;

##Find the department name of the employee who made the highest sale. 
select 
d.department_name
from department d
join employee e
on d.department_id = e.department_id
join sales s 
on s.emp_id = e.emp_id
where s.sale_amount = ( select max(sale_amount)
                        from sales
					  );

##Retrieve employees who have made sales greater than the average sale amount.
select e.name,
s.sale_amount
from employee e join sales s 
on e.emp_id = s.emp_id
where s.sale_amount > ( select avg(sale_amount)
                        from sales)
group by e.name,s.sale_amount
order by s.sale_amount;

###Find the total sales made by employees who earn more than the average salary

select e.name, 
max(e.salary) as maximumsalary,
sum(sale_amount) as total_sales
from employee e join sales s 
on e.emp_id = s.emp_id
where e.salary > ( select avg(salary)
                        from employee)
group by e.name
order by total_sales desc;

###Advanced Level
##Find employees who have not made any sales.
select e.*
from employee e
left join sales s
on e.emp_id = s.emp_id
where s.emp_id is null;
#since no empolyee who havent made any sales no row will occur

###List departments where the average salary is above ₹55,000.

select 
d.department_name , round(avg(e.salary),0)  as avg_sal_above_55000
from department d  join employee e
on d.department_id = e.department_id
group by d.department_name
having avg(e.salary)> 55000
order by avg_sal_above_55000 desc;

##Retrieve department names where the total sales exceed ₹10,000.
select d.department_name, sum(s.sale_amount) as totalsales
from department d join employee e
on d.department_id = e.department_id
join sales s
on s.emp_id = e.emp_id
group by d.department_name
having sum(s.sale_amount) > 10000
order by totalsales desc;

##Find the employee who has made the second-highest sale.
select 
 e.name,
 s.sale_amount
 from employee e join sales s
 on e.emp_id = s.emp_id
 group by e.name,s.sale_amount
 order by s.sale_amount desc
 limit 1
 offset 1;
 
 ##Retrieve the names of employees whose salary is greater than the highest sale amount recorded.
 
 select 
 name,
 salary
 from employee
where salary > (select max(sale_amount)
                from sales)
order by salary desc;
                

 
 
 
 


 








  








