# 	Q1)CREATE A NEW DATABASE AND TABLE FOR EMPLOYEES
## CREATE A NEW DB COMPNAY_DB AND CREATE A TABLE NAMED EMPLOYEES WITH FOLLOWING COLUMNS

# CREATING DB COMPANY_DB
create database company_db;

# USING DB COMPANY_DB
use company_db;
create table employees    #adding employee_id as primary key
(employee_id int primary key,
First_name varchar(50),
Last_name varchar(50),
Department varchar(50),
Salary int,
Hire_date date);

## Q2) Insert given data Data into employee table
insert into employees
values
(101,"Amit","Sharma","HR" ,50000,"2020-01-15"),
(102,"Riya","Kapoor","Sales",75000,"2019-03-22"),
(103,"Raj","Mehta","IT",90000,"2018-07-11"),
(104,"Neha","Verma","IT",85000,"2021-09-01"),
(105,"Arjun","Singh","Finance",60000,"2022-02-10");


#to see the database on cosole
 

#Q3)display all employee records sorted by salary 
##to use sorting we use ORDER BY statement
select * from employees
order by salary asc;    #bydefault even without using ASC SQL gives orders in ascending order

##Q4) show employees sorted by department (A-Z) and Salary(high-low)
select * from employees
order by Department asc, Salary desc;

## Q5) list all employees in IT department , order by hire date(new one first)
#using where statemnt to give conditions
select * from employees
where Department = "IT"
order by Hire_date desc;

# Q6) create another table "Sales" to track sales data
create table Sales
(sale_id int , 
customer_name varchar(50),
amount int,
sale_date date);

## Insert given data Data into sales table

insert into Sales
values
(1,"Aditi",1500,"2024-08-01"),
(2,"Rohan",2200,"2024-08-03"),
(3,"Aditi",3500,"2024-09-05"),
(4,"Meena",2700,"2024-09-15"),
(5,"Rohan",4500,"2024-09-25");
#lets see out sales table on console
select * from Sales;

## Q7) sort all the data by amount(high-low)

select * from Sales
order by amount desc;

##Q8) show all sales made by customer "aditi"
select * from Sales
where customer_name = "Aditi"
order by amount desc;

##Q9) What is the difference between a primary key and foreign key?
#Ans:
#In database management, primary keys and foreign keys are the fundamental tools used to organize data and create relationships between different tables.
###Primary Key: The Unique Identifier
#A primary key ensures that every piece of data in a table is reachable and distinct. It is the "source of truth" for that specific row. 

##Example: In a Students table, the StudentID is the primary key. Even if two students are named "John Smith," their StudentID (e.g., 101 and 102) ensures the database can tell them apart

#Foreign Key: The Connector
#A foreign key is a column in one table that points to the primary key of another table. It creates a bridge between the two.

#Example: In an Enrollments table, you might have a column called StudentID. This isn't the primary key of the enrollments; instead, it points back to the Students table to show which student is taking the class.#

##Q10) WHAT ARE THE CONSTRAINTS IN SQL AND WHY ARE THEY USED
#In SQL, constraints are a set of rules or restrictions applied to table columns to control the type of data that can be input. 
#They act as "guardrails" at the database level to ensure that the information stored remains accurate, reliable, and consistent.
#Why Constraints are Used?
#Constraints are essential for maintaining data integrity and enforcing business rules directly within the database architecture.
#Ensures Accuracy: They prevent invalid or corrupt data (like a negative age or a blank name) from being saved.
#Enforces Relationships: They maintain links between tables, 
#ensuring that "orphaned" records (e.g., an order for a customer who doesn't exist) cannot be created.
#Eliminates Redundancy: By enforcing uniqueness, they prevent duplicate entries that could lead to errors in reporting or operations.
#Improves Performance: Certain constraints, like PRIMARY KEY and UNIQUE, automatically create indexes that speed up data retrieval.







 
