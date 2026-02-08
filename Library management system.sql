create database Library_Management_System

use Library_Management_System

--Library table

create table Library
(
ID int primary key IDENTITY (1, 1),
Lib_name nvarchar (20) not null,
Location nvarchar (20) not null,
ConcatNo int not null, 
Stablish_year date
)

--Staff table

create table Staff
(
ID int primary key IDENTITY (1, 1),
Fname nvarchar (20),
Lname nvarchar (20),
Position nvarchar (20),
Concat_num int,
Lib_id int,
foreign key (Lib_id) references Library (ID)
)

--Book table

create table Book
(
ID int primary key IDENTITY (1, 1),
ISBN int not null,
Title nvarchar (20) not null,
Genre nvarchar (20) CONSTRAINT ck_book_genre check (Genre IN ('Fiction', 'Non-fiction', 'Reference', 'Children')) not null,
Price decimal CONSTRAINT ck_book_price check (Price > 0),
Self_location nvarchar (20) not null,
Avilability nvarchar (10) DEFAULT 'TRUE'
)

--Member table

create table Member
(
ID int primary key IDENTITY (1, 1),
Fname nvarchar (20),
Lname nvarchar (20),
Phone_num int,
Email nvarchar not null,
mem_ship_start date,
lib_ID int,
foreign key (lib_ID) references Library (ID)
)
--Review table

create table Reviw 
(
Review_date date primary key not null,
Rating int CONSTRAINT ck_review_rating check (Rating between 1 and 5) not null,
Comment nvarchar (200) DEFAULT 'No comments'
)

create table loan
(
Loan_date date primary key not null,
Due_date date not null,
Status nvarchar (10) CONSTRAINT ck_loan_status check (Status IN ('Issued', 'Returned', 'Overdue')) DEFAULT 'Issued' not null,
Return_date date,
memb_id int,
foreign key (memb_id) references Member (ID),
book_id int, 
foreign key (book_id) references Book (ID)
)

create table payment
(
Payment_date date primary key not null,
Amount decimal  CONSTRAINT ck_payment_amount check (Amount > 0) not null,
Method nvarchar (20),
loan_date date,
foreign key (loan_date) references loan (Loan_date)
)


--add foriegn keys in book table
alter table Book
    add Lib_id int foreign key references Library 

alter table Book 
    add mem_id int foreign key references Member (ID)

alter table Reviw 
    add memID int foreign key references Member (ID)

alter table Reviw 
    add bookID int foreign key references Book (ID)

alter table loan
    add CONSTRAINT ck_loan_return check (Return_date >= Loan_date)

alter table Member
    alter  COLUMN Email nvarchar (255)

alter table Library
    add UNIQUE (Lib_name)

alter table Book
    add UNIQUE (ISBN)

alter table Member 
    add UNIQUE (Email)

Delete from Book

--use SELECT to Retrieving All Data

select * from Library

select * from Staff

select * from Book

select * from Member

select * from Reviw

select * from loan

select * from payment

-- data for library table

insert into Library (Lib_name, Location, ConcatNo, Stablish_year) 
		     values ('Central', 'Sur', '71669914', '1824'),
				    ('Knowledge', 'Jeddah', '0123456789', '1995'),
                    ('Science', 'Dammam', '0134567890', '2005'),
                    ('National', 'Abha', '0171234567', '1978'),
                    ('Future', 'Makkah', '0129876543', '2010'),
                    ('Global', 'Madinah', '0148765432', '2000'),
                    ('Digital', 'Taif', '0121122334', '2015'),
                    ('Academic', 'Tabuk', '0143344556', '1990'),
                    ('Open Mind', 'Hail', '0169988776', '1985'),
                    ('Innovation', 'Najran', '0176655443', '2020');

-- data for staff table

insert into Staff (Fname, Lname, Position, Concat_num, Lib_id)
           values ('John', 'Smith', 'Manager', '0501234567', 1),
                  ('Emily', 'Johnson', 'Librarian', '0552345678', 3),
                  ('Michael', 'Brown', 'Assistant', '0533456789', 7),
                  ('Sarah', 'Davis', 'Archivist', '0544567890', 2),
                  ('David', 'Wilson', 'IT Support', '0565678901', 6),
                  ('Laura', 'Miller', 'Catalog', '0576789012', 4),
                  ('James', 'Taylor', 'Research', '0587890123', 5),
                  ('Anna', 'Anderson', 'Service', '0598901234', 9),
                  ('Robert', 'Thomas', 'Security', '0529012345', 10),
                  ('Sophia', 'Moore', 'Administrative', '0510123456', 8);

-- data for book table

insert into Book (ISBN, Title, Genre, Price, Avilability, Self_location, Lib_id, mem_id )
          values ('2256', 'The Odyssey', 'Reference', 45.00, 'True', 'A1', 4, 12),
                 ('5413', 'Mockingbird', 'Fiction', 39.99, 'True', 'A2', 5, 3),
                 ('0984', 'Gatsby', 'Non-fiction', 29.50, 'False', 'A3', 6, 11),
                 ('3568', '1984', 'Non-fiction', 34.00, 'True', 'B1', 7, 8),
                 ('1246', 'Harry Potter', 'Children', 59.90, 'True', 'B2', 10, 4),
                 ('9753', 'The Code', 'Non-fiction', 42.75, 'True', 'B3', 8, 10),
                 ('5446', 'Alchemist', 'Reference', 31.00, 'False', 'C1', 2, 6),
                 ('5558', 'The Rings', 'Fiction', 120.00, 'Trure', 'C2', 1, 5),
                 ('7643', 'Pride', 'Children', 27.80, 'True', 'C3', 3, 7),
                 ('7549', 'The Power', 'Non-fiction', 36.60, 'True', 'D1', 5, 9);

--data for member table

insert into Member (Fname, Lname, Phone_num, Email, mem_ship_start, lib_ID)
            values ('Alex', 'Johnson', '0501112233', 'alex.johnson@email.com', '2021-01-15', 2),
                   ('Emma', 'Williams', '0552223344', 'emma.williams@email.com', '2020-06-10', 6),
                   ('Daniel', 'Brown', '0533334455', 'daniel.brown@email.com', '2019-09-25', 10),
                   ('Olivia', 'Taylor', '0544445566', 'olivia.taylor@email.com', '2022-03-05', 7),
                   ('Liam', 'Anderson', '0565556677', 'liam.anderson@email.com', '2018-11-30', 5),
                   ('Sophia', 'Thomas', '0576667788', 'sophia.thomas@email.com', '2021-07-18',2),
                   ('Noah', 'Moore', '0587778899', 'noah.moore@email.com', '2020-02-01', 4),
                   ('Ava', 'Martin', '0598889900', 'ava.martin@email.com', '2022-10-12', 9),
                   ('William', 'Lee', '0529990011', 'william.lee@email.com', '2019-05-20', 8),
                   ('Mia', 'Clark', '0510001122', 'mia.clark@email.com', '2023-01-08', 3);

-- data for review 

insert into Reviw (Rating, Review_date, Comment,  bookID, memID)
           values (5, '2023-01-10', 'Excellent book, very informative and enjoyable.', 15, 4),
                  (4, '2023-02-15', 'Good content but some chapters were a bit long.', 16, 8),
                  (3, '2023-03-05', 'Average book, useful but not outstanding.', 17, 9),
                  (5, '2023-04-20', 'Amazing experience, highly recommended!', 14, 5),
                  (2, '2023-05-18', 'Not what I expected, writing style was weak.', 22, 3),
                  (4, '2023-06-22', 'Well written and easy to understand.', 21, 6),
                  (1, '2023-07-01', 'Poor quality and disappointing overall.', 19, 7),
                  (5, '2023-08-14', 'One of the best books I have read this year.', 18, 12),
                  (3, '2023-09-30', 'Decent book, but could be improved.', 20, 10),
                  (4, '2023-10-12', 'Interesting ideas and clear explanations.', 23, 11);

-- data fot loan

insert into loan ( Loan_date, Due_date, Status, Return_date, memb_id, book_id)
          values ('2023-01-05', '2023-01-19', 'Returned', '2023-01-17', 9, 15),
                 ('2023-01-20', '2023-02-03', 'Returned', '2023-02-02', 12, 18),
                 ('2023-02-10', '2023-02-24', 'Overdue', NULL, 7, 16),
                 ('2023-03-01', '2023-03-15', 'Returned', '2023-03-14', 6, 14),
                 ('2023-03-20', '2023-04-03', 'Returned', '2023-04-01', 4, 22),
                 ('2023-04-10', '2023-04-24', 'Overdue', NULL, 8, 20),
                 ('2023-05-05', '2023-05-19', 'Returned', '2023-05-18', 5, 19),
                 ('2023-06-01', '2023-06-15', 'Returned', '2023-06-13', 3, 17),
                 ('2023-06-20', '2023-07-04', 'Overdue', NULL, 10, 21),
                 ('2023-07-10', '2023-07-24', 'Returned', '2023-07-22', 11, 23);

--data for payment

insert into payment (Amount, Payment_date, Method, loan_date)
             values (25.00, '2023-01-10', 'Cash', '2023-03-01'),
                    (40.50, '2023-02-05', 'Credit Card', '2023-01-05'),
                    (15.75, '2023-02-20', 'Debit Card', '2023-07-10'),
                    (60.00, '2023-03-12', 'Online', '2023-05-05'),
                    (30.00, '2023-04-01', 'Cash','2023-06-01'),
                    (45.25, '2023-04-18', 'Credit Card', '2023-02-10'),
                    (20.00, '2023-05-06', 'Online', '2023-04-10'),
                    (55.00, '2023-06-14', 'Debit Card', '2023-06-20'),
                    (35.90, '2023-07-02', 'Cash', '2023-03-20'),
                    (70.00, '2023-07-25', 'Credit Card', '2023-01-20');


--use SELECT to Selecting Specific Columns

select Lib_name, Location from Library;

select Title, Genre, Price from Book;

select Fname, Lname, Email from Member;

select ID, Fname, Lname, Position from Staff;

--Using WHERE Clause - Simple Conditions

select * from Book where Genre = 'Fiction';

select * from Library where Location = 'New York';

select * from Book where Avilability = 'True';

select * from Staff where Position = 'Librarian';

select * from loan where Status = 'Overdue';

--Comparison Operators

select * from Book where Price > 20;

select * from Library where year (Stablish_year) < 2000;

select * from payment where Amount >= 10;

select * from Book where Price <= 15; 

select * from Reviw where Rating != 5;

--Logical Operators (AND, OR, NOT)

select * from Book where Genre = 'Fiction' AND Avilability = 'True';

select * from Book where Genre = 'Fiction' OR Genre = 'Children';

select * from Library where YEAR (Stablish_year) < 2010 AND Location = 'Dammam';

select * from Book where Price >= 10 AND Price <= 30;

select * from loan where Status <> 'Returned';

--ORDER BY Clause

select * from Book ORDER BY Title ASC;

select * from Book ORDER BY Price DESC;

select * from Member ORDER BY mem_ship_start DESC;

select * from Library ORDER BY Stablish_year ASC;

select * from Reviw ORDER BY Rating DESC;

select * from Reviw ORDER BY Review_date ASC;

--DISTINCT Keyword

select DISTINCT Genre from Book ORDER BY Genre ASC; 

select DISTINCT Location from Library ORDER BY Location ASC; 

select DISTINCT Position from Staff ORDER BY Position ASC; 

select DISTINCT Status from loan ORDER BY Status ASC; 

--TOP/LIMIT Clause

select TOP 5 * from Book ORDER BY Price DESC;

select TOP 10 * from Member ORDER BY mem_ship_start ASC;

select TOP 3 * from Library ORDER BY Stablish_year ASC;

select TOP 5 * from Reviw ORDER BY Rating DESC;

--LIKE Operator for Pattern Matching

select * from Book where Title LIKE 'The %';

select * from Member where Email LIKE '%email.com%';

select * from Library where Lib_name like '%Innovation';

select * from Book where Title LIKE '%Adventure%';

select * from Staff where Fname LIKE 'J%';

--Working with NULL Values

select * from loan where Return_date IS NULL;

select * from loan where Return_date IS NOT NULL;

select * from Reviw where Comment IS NULL OR Comment = 'No comments';

--Complex Combined Queries

select * from Book where Genre = 'Fiction' AND Avilability = 'TRUE' AND Price < 100 ORDER BY Price ASC;

select TOP 5 * from loan where Status = 'Overdue' ORDER BY Due_date DESC;

select * from Library where ( Location = 'Makkah' OR Location = ' Najran') AND year (Stablish_year) > 2005 ORDER BY Lib_name;

select * from Book where (Genre = 'Fiction' OR Genre = 'Children') AND Price between 10 AND 30 AND Avilability = 'TRUE';

select * from Member where ( year (mem_ship_start) >= 2019 AND year (mem_ship_start) < 2023) AND Email LIKE '%@email.com' ORDER BY mem_ship_start ASC;

--Challenge Queries

select TOP 10 * from Book where Genre IN ('Fiction', 'Non-fiction') AND Avilability = 'TRUE' ORDER BY Price DESC;

select * from loan where (year (Loan_date) >= 2023 AND year (Loan_date) < 2024) AND Return_date IS NULL ORDER BY Loan_date ASC;
