###Q1. What is a Common Table Expression (CTE), and how does it improve SQL query readability?
##A Common Table Expression (CTE) is a named temporary result set defined using the WITH clause that exists only during the execution of a single query. 
##It functions as a "virtual table" that can be referenced within SELECT, INSERT, UPDATE, or DELETE statements.
###How CTEs Improve Readability:
##CTEs allow you to decompose complex, tangled queries into smaller, logical building blocks.
##Unlike subqueries, which are often "buried" in the middle of a statement, CTEs are defined at the beginning. 
##This allows developers to read the query from top to bottom, following the data transformation steps in order. 
###You can assign descriptive names to each CTE (e.g., MonthlySales or ActiveCustomers), making the purpose of each data subset immediately clear.
##A single CTE can be referenced multiple times within the same main query, preventing the need to copy and paste the same subquery logic repeatedly.
##Recursive CTEs provide a structured way to handle tree-like data (e.g., organizational charts or file systems) that would otherwise require complex self-joins
##Basic Syntax
#A CTE is initiated with the WITH keyword:
#WITH MyCTE AS (
   # SELECT Column1, Column2
    #FROM MyTable
    #WHERE Condition)
    #SELECT * FROM MyCTE;
    
###Q2. Why are some views updatable while others are read-only? Explain with an example
      ##Views are updatable only if there is a 1:1, unambiguous mapping to a single underlying table,
      ## allowing the database to directly modify the base data. 
	  ##Views become read-only when they involve complexities like joins, aggregations (SUM, AVG), GROUP BY, DISTINCT, or calculations,
      # making it impossible to determine which specific row or column to change.
##Why Views Are Updatable
    ##A view is generally updatable if it fulfills these conditions: 
    #Single Table: It is derived from only one base table.
    #No Aggregation/Grouping: It does not use GROUP BY, HAVING, or aggregate functions (e.g., SUM(), COUNT()).
    #No Distinct: The DISTINCT keyword is not used.
    #Direct Mapping: Columns are direct references, not calculations or expressions.
#Example of an Updatable View:
    #CREATE VIEW ActiveEmployees AS
    #SELECT employee_id, name, department, salary
    #FROM Employees
    #WHERE status = 'Active';
#This view directly maps to one table (Employees) and includes the primary key (employee_id). 
#An UPDATE statement on this view, such as changing a salary, will directly update the Employees table.

###Why Views Are Read-Only (Non-Updatable)
   #Views are read-only if the database cannot accurately propagate changes back to the base tables. 
   #Joins: If a view combines data from multiple tables, the database cannot determine which table should receive the update.
   #Calculated Columns: If a column is a result of a formula (e.g., Salary * 12), it cannot be updated.
   #Grouped Data: Summarized data (GROUP BY) cannot be updated because the view shows one row representing multiple base rows
###Example of a Read-Only View:
   ##CREATE VIEW DepartmentSalarySummary AS
   #SELECT department_id, SUM(salary) AS total_salary
   #FROM Employees
   #GROUP BY department_id;

###Q3. What advantages do stored procedures offer compared to writing raw SQL queries repeatedly?
       ##Stored procedures offer several key advantages over raw,
       ##ad-hoc SQL queries by centralizing logic and optimizing how the database interacts with applications:
       ###Improved Performance:
       ##Pre-compilation: Stored procedures are compiled once and stored in an executable form, 
       ##reducing the overhead of parsing and compiling queries during every execution
       ##Plan Caching: Databases typically cache the execution plan for stored procedures,
       ##leading to faster response times for frequently called operations.
       ###Reduced Network Traffic
       ##Pre-compilation: Stored procedures are compiled once and stored in an executable form,
       ##reducing the overhead of parsing and compiling queries during every execution.
       ##Plan Caching: Databases typically cache the execution plan for stored procedures, 
       ## leading to faster response times for frequently called operations.
       ###Reduced Network Traffic:
           ##Single Calls: Instead of sending multiple raw SQL statements over the network, an application sends only the procedure name and its parameters.
           ##Server-Side Processing: Complex calculations are performed on the database server itself, sending only the final result back to the client.
	   ###Enhanced Security:
           ##Access Control: Permissions can be granted to execute a procedure without giving users direct access to the underlying tables.
           ##SQL Injection Prevention: Using strongly typed parameters ensures that user input is treated as data rather than executable code, 
           ##significantly reducing the risk of injection attacks.
           ##Code Sharing: The same stored procedure can be reused across different applications or modules, ensuring consistent results.
     ###Encapsulation of Complexity:
           ##Simplified Application Code: Developers can call a single, named procedure for complex multi-step transactions, 
           ##keeping the application code cleaner and more readable.
           
###Q4. What is the purpose of triggers in a database? Mention one use case where a trigger is essential.
       ##The primary purpose of a database trigger is to automatically execute a set of predefined SQL statements in response to specific events, such as inserting, updating, or deleting data.
       ##Triggers serve as "invisible helpers" that operate in the background to ensure data stays accurate and consistent without manual intervention
       ###Key Purposes of Triggers
       ##Enforcing Business Rules: 
                    ##They ensure that specific organizational policies are followed, such as preventing a sale if stock is out or blocking negative salary entries.
       ##Maintaining Data Integrity: 
					##Triggers can validate complex conditions that standard constraints cannot, such as checking that an end date always comes after a start date.
	##Automating Related Updates: 
                    ##Triggers can keep related tables in sync, such as automatically updating a total order amount when an individual item's quantity is change
    
    ##Essential Use Case: Maintaining an Audit Trail:
                    ##In financial or banking systems, a trigger is often essential for maintaining an audit log of sensitive data changes
	##Scenario: Whenever a user's account balance is updated (an UPDATE event), 
                ## a trigger automatically inserts the old balance, the new balance, the timestamp, 
                ##and the user ID of the person who made the change into a separate audit_log table.
    ##Why it's essential: 
				##This ensures that every change is captured immediately at the database level, regardless of which application or user made the change, preventing human error and providing a non-bypassable record for regulatory compliance. 
    
    ##Q5. Explain the need for data modelling and normalization when designing a database.
                ##Designing a database without a plan is like building a house without a blueprint. 
                ##Data modeling and normalization are the two foundational processes used to ensure the structure is stable, logical, and efficient.
		 ##1. The Need for Data Modeling
             #Data modeling is the process of creating a visual representation of how data is connected.
             ##Data modeling is the process of creating a visual representation of how data is connected.
             ##Clarity and Communication: 
                  ##it helps stakeholders and developers agree on what data is being stored and how entities (like "Customers" and "Orders") relate to one another.
			 ##Error Prevention: 
                  ##By defining data types and relationships upfront, you avoid building a system that can't handle complex business requirements later.
			##Performance Optimization: 
                  ##A well-modeled database ensures that queries run faster by organizing data in a way that minimizes search paths.
		##2. The Need for Normalization:
		          ##Normalization is the systematic process of organizing data into tables to eliminate redundancy.
			##Reducing Data Redundancy: 
                  ##Without normalization, the same information (like a customer’s address) might be stored in ten different places. 
                  ##Normalization ensures each piece of data is stored in one place only.
		    ##Preventing Anomalies:
				##Insertion Anomaly: You can’t add a new product because no one has bought it yet.
            ##Update Anomaly: 
                ##You change a price in one row but forget to change it in others, leading to inconsistent data.
            ##Deletion Anomaly: Deleting an order accidentally deletes the entire customer record.
            ##Storage Efficiency: Storing data once instead of multiple times saves disk space and reduces the risk of data corruption.
		
        ###create table Products
        
        create database advancesql;
        use advancesql;
        create table Products
        (productID int primary key,
         ProductName varchar(100),
         Category varchar(50),
         Price decimal(10,2)
		);
        insert into products
        values
        (1,"Keyboards","Electronics",1200),
		(2,"Mouse","Electronics",800),
		(3,"Chair","Furniture",2500),
		(4,"Desk","Furniture",5500);
        
	##create table Sales
    
       create table Sales
       (SaleID int primary key,
        ProductID int,
        Quantity int,
        SaleDate date,
        foreign key (productID) references Products(productID) 
        );
        
         insert into Sales
         values
         (1,1,4,"2024-01-05"),
         (2,2,10,"2024-01-06"),
         (3,3,2,"2024-01-10"), 
         (4,4,1,"2024-01-11");
         
##Q6. Write a CTE to calculate the total revenue for each product 
## (Revenues = Price × Quantity), and return only products where  revenue > 3000.

with productrevenue as( select p.ProductID,
                               p.ProductName,
                               round(sum(quantity * price),0) as TotalRevenue 
                               FROM products p 
                               join Sales s
                               on p.productid = s.productid
                               group by p.ProductID,p.ProductName
                               )
	select * 
    from productrevenue
    where TotalRevenue > 3000;
    
###Create a view named vw_CategorySummary that shows: Category, TotalProducts, AveragePrice.

 create view vw_CategorySummary
 as select 
    Category,
   count(ProductID) AS TotalProducts,
   round(avg(Price),0)  as AveragePrice
   from Products
   group by category;
   
   select * from vw_CategorySummary;
   
   ###.Q8 Create an updatable view containing ProductID, ProductName, and Price.
   ##Then update the price of ProductID = 1 using the view.
 
 create view vw_productDetails as 
 select 
 ProductID,
 ProductName,
 Price
 from products;
 
 update vw_productDetails 
 set price = 1300
 where ProductID = 1;
 
 select * from products
 where ProductID = 1;
 
 ##Q9. Create a stored procedure that accepts a category name and returns all products belonging to that category.
DELIMITER //

create PROCEDURE ProductsByCategory(IN categoryname VARCHAR(50))
BEGIN
    SELECT 
    ProductID,
    productname,
    category
    FROM Products 
    WHERE CategoryName = categoryname;
END //

DELIMITER ;

##Q10. Create an AFTER DELETE trigger on the table that archives deleted product rows into a new
#table . #The archive should store ProductID, ProductName, Category, Price, and DeletedAt
#timestamp.
##step 1 create archive table
create table ProductArchive(
 ProductID int,
 Productname varchar(100),
 Category varchar(50),
 Price decimal(10,2),
 DeletedAt timestamp);
 
 ##step2 create trigger 
 delimiter // 
 create trigger after_product_delete
 after delete on products
 for each row
 begin
 insert into ProductArchive
 values(
 old.ProductID,
 old.Productname,
 old.category,
 old.price,
 now()
 );
 end //
 delimiter ;
 
 ##lets try testing delete some id first from column
 delete from sales where productid = 3;
 delete from products where productid = 3;
 
##run to check  if trigger worked
select * from ProductArchive;










 
 

 
 
   
 
   
    
    
 

     
     

                               
        
     
        
        



