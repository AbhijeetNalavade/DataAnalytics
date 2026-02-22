###Create the following dummy tables in MySQL Workbench using CREATE FUNCTION-
use world;
create table customers
(customerId int,customerName varchar(20),City varchar(20));

insert into customers
values
(1,"John Smith","New York"),
(2,"Mary Johnson","Chicago"),
(3,"Peter Adams","Los Angeles"),
(4,"Nancy Miller","Houston"),
(5,"Robert White","Miami");

select * from customers;

create table orders
(OrderID int,CustomerID int, OrderDate date , Amount int);
insert into orders
values
(101,1,'2024-10-01',250),
(102,2,'2024-10-05',300),
(103,1,'2024-10-07',150),
(104,3,'2024-10-10',450),
(105,6,'2024-10-12',400);
select * from orders;
create table Payments
(PaymentID char(10),CustomerID int,PaymentDate date ,Amount int);
insert into Payments
values
("P001",1,"2024-10-02",250),
("P002",2,"2024-10-02",300),
("P003",3,"2024-10-02",450),
("P004",4,"2024-10-02",200);

create table Employees
(EmployeeID int , EmployeeName varchar(50), ManagerID int );
insert into Employees
values
(1,"Alex Green",null),
(1,"Alex Green",1),
(1,"Alex Green",1),
(1,"Alex Green",2),
(1,"Alex Green",2);

select * from Employees;
###Question 1. Retrieve all customers who have placed at least one order.
select c.* 
from 
customers c inner join orders o 
on c.customerid = o.customerid;

###Question 2. Retrieve all customers and their orders, including customers who have not placed any orders.
select c.*,o.*
from 
customers c left join orders o 
on c.customerid = o.customerid;
##since left join retrieve all the data from both tables we use left join here

###Question 3. Retrieve all orders and their corresponding customers, including orders placed by unknown customers.
select o.*,c.*
from 
orders o left join  customers c 
on o.customerid = c.customerid;

###Question 4. Display all customers and orders, whether matched or not.

select c.*,o.*
from 
customers c left join orders o 
on c.customerid = o.customerid

union

select c.*,o.*
from 
customers c right join orders o 
on c.customerid = o.customerid;
### here since we have retrieve all the data from both tables we will use full outer join 
### but full outer join not available in mysql we can use union for both joins

##Question 5. Find customers who have not placed any orders.
select c.*
from 
customers c left join orders o 
on c.customerid = o.customerid
where o.customerid is null;

###Question 6. Retrieve customers who made payments but did not place any orders.
select c.*,p.*
from customers c inner join payments p 
on c.customerid = p.customerid
left join orders o 
on c.customerid = o.customerid
where o.customerid is null;

###Question 7. Generate a list of all possible combinations between Customers and Orders
select *
from customers c
cross join orders o;

###Question 8. Show all customers along with order and payment amounts in one table.

select 
c.customerid,
c.customername,
c.city,
o.orderid,
o.orderdate,
o.amount as orderAmount,
p.paymentid,
p.paymentdate,
p.amount as paymentamount
from customers c
left join orders o 
on c.customerid = o.customerid
left join payments p 
on c.customerid = p.customerid;
## since some table data have same column  name it will be tough to jugde which data from which
##hence one by one name all require data to show all data from each column

###Question 9. Retrieve all customers who have both placed orders and made payments.

select distinct 
c.customerid,
c.customername,
c.city
from customers c 
inner join orders o 
on c.customerid = o.customerid
inner join 
payments p 
on c.customerid = p.customerid;

 



  







 

