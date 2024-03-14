create database Library;
use Library;
create table Branch(
Branch_no int primary key,
Manager_Id int,
Branch_address varchar(50),
Contact_no varchar(15));
insert into Branch(Branch_no,Manager_Id,Branch_address,Contact_no)
values(1,1001,'123 Main Street','555-5678'),
(2,1002,'456 Oak Avenue','555-1234'),
(3,1003,'789 Maple Lane','555-9101');
select * from Branch;

create table Employee(
Emp_id int primary key,
Emp_name varchar(30),
Position varchar(35),
Salary float,
Branch_no int,
foreign key (Branch_no)
references Branch(Branch_no));

insert into Employee(Emp_id,Emp_name,Position,Salary,Branch_no)
values(101,'John Doe','Librarian',60000,1),
(102,'Jane Smith','Assistant Librarian',55000,1),
(103,'Robert Johnson','Bookkeeper',48000,1),
(104,'Samantha Rodriguez','Cataloging Specialist',58000,1),
(105,'Michelle Nguyen','Archivist',50000,1),
(106,' Kimberly Scott','Collection Development Specialist',58000,1),
(1001,'Emily Davis','Manager',65000,1),
(201,'Michael White','Librarian',60000,2),
(202,'Sarah Brown','Assistant Librarian',55000,2),
(203,'Daniel Lee','Bookkeeper',48000,2),
(204,'Logan Price','Archivist',50000,2),
(205,'Madison Hill','Collection Development Specialist',58000,2),
(1002,'Christopher Evans','Manager',65000,2),
(301,'Amanda Miller','Librarian',60000,3),
(302,'Benjamin Hall','Assistant Librarian',55000,3),
(303,'Sophia Allen','Bookkeeper',48000,3),
(1003,'Joseph Garcia','Manager',65000,3);
select * from Employee;

create table Books(
ISBN varchar(13) primary key,
Book_title varchar(80),
Category varchar(30),
Rental_Price float,
Status varchar(4),
Author varchar(30),
Publisher varchar(50));

insert into Books(ISBN,Book_title,Category,Rental_Price,Status,Author,Publisher)
values('9780135166307','Introduction to SQL','Programming',10.99,'Yes','John Smith','Tech Publishing'),
('9781451673319','The Great Gatsby','Fiction',8.99,'No','F.Scott Fitzgerald','Classic Books'),
('9780596007126','Head First Java','Programming',15.99,'No','Kathy Sierra','Tech Publishing'),
('9780061120084','To Kill a Mockingbird','Fiction',9.99,'Yes','Harper Lee','Harper Collins'),
('9781449331818','Learning Python','Programming',14.99,'No','Mark Lutz','Tech Publishing'),
('9780062315007','The Hunger Games','Young Adult',12.99,'No','Suzanne Collins','Scholastic'),
('9780262530875','Artificial Intelligence','Technology',18.99,'Yes','Stuart Russel','MIT Press'),
('9780743273565','The Catcher in the Rye','Fiction',7.99,'Yes','J.D.Salinger','Little Brown'),
('9780596100990','Clean Code','Programming',20.99,'Yes','Robert C Martin','Prentice Hall'),
('9780307277195','World History','History',16.99,'No','Roger B Beck','McDougal Littell'),
('9780345538376','The Night Circus','Fiction',12.99,'Yes','Erin Morgenstern','Doubleday'),
('9780062457738','Educated: A Memoir','Biography',14.99,'No','Tara Westover','Random House'),
('9781984822185','Where the Crawdads Sing','Mystery',11.99,'Yes','Delia Owens',"G.P. Putnam's Sons");
select * from Books;

create table Customer(
Customer_Id int primary key,
Customer_name varchar(40),
Customer_address varchar(70),
Reg_date date);

insert into Customer(Customer_Id,Customer_name,Customer_address,Reg_date)
values(501, 'Alice Johnson', '456 Birch Street', '2020-06-15'),
(502, 'Bob Anderson', '789 Oak Avenue', '2022-02-20'),
(503, 'Catherine Davis', '123 Maple Lane', '2021-09-10'),
(504, 'David Smith', '890 Elm Road', '2020-11-25'),
(505, 'Eva Wilson', '234 Pine Drive', '2021-06-28'),
(506, 'Frank Thompson', '567 Cedar Avenue', '2022-01-05'),
(507, 'Grace Evans', '789 Pine Lane', '2021-08-12'),
(508, 'Henry Miller', '321 Elm Drive', '2022-06-25'),
(509, 'Isabel Brown', '654 Oak Road', '2020-12-11'),
(510, 'Jack Taylor', '987 Birch Avenue', '2022-06-10'),
(511, 'Karen Martinez', '123 Cedar Drive', '2021-07-22'),
(512, 'Leo White', '456 Maple Road', '2022-02-28');
select * from Customer;

create table IssueStatus(
Issue_Id int primary key,
Issued_cust int,
Issued_book_name varchar(80),
Issue_date date,
Isbn_book varchar(13),
foreign key (Issued_cust)
references customer(Customer_Id),
foreign key (Isbn_book)
references books(ISBN));

insert into IssueStatus(Issue_id,Issued_cust,Issued_book_name,Issue_date,Isbn_book)
values(10010,502,'Head First Java','2023-06-25','9780596007126'),
(10011,507,'The Hunger Games','2021-08-18','9780062315007'),
(10012,512,'Learning Python','2022-03-11','9781449331818'),
(10013,510,'The Great Gatsby','2022-07-14','9781451673319'),
(10014,508,'Educated: A Memoir','2023-06-20','9780062457738'),
(10015,506,'World History','2022-02-17','9780307277195');
select * from IssueStatus;

create table ReturnStatus(
Return_Id int primary key,
Return_cust varchar(40),
Return_book_name varchar(80),
Return_date date,
Isbn_book2 varchar(13),
foreign key (Isbn_book2)
references Books(ISBN));

insert into ReturnStatus(Return_id,Return_cust,Return_book_name,Return_date,Isbn_book2)
values(20010,502,'Head First Java','2023-08-12','9780596007126'),
(20011,512,'Learning Python','2022-04-28','9781449331818'),
(20012,508,'Educated: A Memoir','2023-07-28','9780062457738'),
(20013,507,'The Hunger Games','2021-09-25','9780062315007');
select * from ReturnStatus;

#Retrieve the book title, category, and rental price of all available books.
select Book_title,Category,Rental_Price from Books where Status='Yes';

# List the employee names and their respective salaries in descending order of salary.
select Emp_name,Salary from Employee order by Salary desc;

# Retrieve the book titles and the corresponding customers who have issued those books.
Select BK.Book_title as BookTitle,C.Customer_name as CustomerName from Books BK
join
    IssueStatus IUS on BK.ISBN = IUS.Isbn_book
join 
    Customer C on IUS.Issued_cust = C.Customer_Id;
    
 # Display the total count of books in each category.   
select Category,count(*) from Books group by Category;

# Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
select Emp_name,Position from Employee where Salary>50000;

#  List the customer names who registered before 2022-01-01 and have not issued any books yet.
select Customer_name from Customer where Reg_date<'2022-01-01' and Customer_Id not in (select Issued_cust from IssueStatus);

# Display the branch numbers and the total count of employees in each branch.
select Branch_no,count(*) as Total_Employees from Employee group by Branch_no;

# Display the names of customers who have issued books in the month of June 2023.
select distinct C.Customer_name as CustomerName from Customer C
join IssueStatus IUS on C.Customer_Id = IUS.Issued_cust
where month(IUS.Issue_date) = 6 and year(IUS.Issue_date) = 2023;

# Retrieve book_title from book table containing history.
select Book_title from Books where Category like '%history%';

# Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
select Branch_no,count(*) as TotalEmployees from Employee
group by Branch_no having count(*) > 5;






