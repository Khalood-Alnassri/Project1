create database Library_System

use Library_System

--Library table

create table Library
(
ID int primary key IDENTITY (1, 1),
Lib_name nvarchar (100) not null,
Location nvarchar (50) not null,
ConcatNo int not null, 
Stablish_year date
)

--Staff table

create table Staff
(
ID int primary key IDENTITY (1, 1),
Fname nvarchar (90),
Position nvarchar (20),
Concat_num int,
Lib_id int,
foreign key (Lib_id) references Library (ID) ON DELETE CASCADE ON UPDATE CASCADE
)

drop table Staff

--Member table

create table Member
(
ID int primary key IDENTITY (1, 1),
Full_name nvarchar (70),
Phone_num int,
Email nvarchar (250) UNIQUE not null,
mem_ship_start date,
lib_ID int,
foreign key (lib_ID) references Library (ID) ON DELETE CASCADE ON UPDATE CASCADE
)

--Book table

create table Book
(
ID int primary key IDENTITY (1, 1),
ISBN int UNIQUE not null,
Title nvarchar (100) not null,
Genre nvarchar (100) CONSTRAINT ck_book_genre check (Genre IN ('Fiction', 'Non-fiction', 'Reference', 'Children')) not null,
Price decimal CONSTRAINT ck_book_price check (Price > 0),
Self_location nvarchar (50) not null,
Avilability nvarchar (10) DEFAULT 'TRUE',
Lib_id int,
foreign key (Lib_id) references Library (ID) ON DELETE CASCADE ON UPDATE CASCADE,
mem_id int,
foreign key (mem_id) references Member (ID) 
)

--Reviev table 

create table Reviw 
(
Rev_ID int primary key IDENTITY (1, 1) not null,
Review_date date,
Rating int CONSTRAINT ck_review_rating check (Rating between 1 and 5) not null,
Comment nvarchar (200) DEFAULT 'No comments',
bookID int,
foreign key (bookID) references Book (ID) ON DELETE CASCADE ON UPDATE CASCADE,
memID int,
foreign key (memID) references Member (ID)
)

drop table Reviw

--Loan table 

create table loan
(
Loan_ID int primary key IDENTITY (1, 1) not null,
Loan_date date,
Due_date date not null,
Status nvarchar (10) CONSTRAINT ck_loan_status check (Status IN ('Issued', 'Returned', 'Overdue')) DEFAULT 'Issued' not null,
Return_date date,
CONSTRAINT ck_loan_return check (Return_date >= Loan_date),
memb_id int,
foreign key (memb_id) references Member (ID) ON DELETE CASCADE ON UPDATE CASCADE,
book_id int, 
foreign key (book_id) references Book (ID)
)

drop table loan 

--payment table 

create table payment
(
pay_ID int primary key IDENTITY (1, 1) not null,
Payment_date date, 
Amount decimal  CONSTRAINT ck_payment_amount check (Amount > 0) not null,
Method nvarchar (20),
loanID int,
foreign key (loanID) references loan (Loan_ID) ON DELETE CASCADE ON UPDATE CASCADE
)

drop table payment

select * from Library

select * from Staff

select * from Member

select * from Book

select * from Reviw

select * from loan

select * from payment

INSERT INTO Library (Lib_name, Location, ConcatNo, Stablish_year) 
            VALUES  ('Central Library', 'Riyadh', 112233, '2005-03-15'),
			        ('City Library', 'Jeddah', 223344, '1998-07-20'),
                    ('University Library', 'Dammam', 334455, '2010-01-10'),
                    ('Public Library', 'Makkah', 445566, '2001-09-05'),
                    ('Knowledge Hub',  'Madinah', 556677, '2015-06-18'),
                    ('National Library', 'Taif', 667788, '1985-12-01'),
                    ('Research Library', 'Abha', 778899, '2008-04-25'),
                    ('Children Library', 'Jazan', 889900, '2012-08-30'),
                    ('Digital Library', 'Buraidah', 990011, '2019-11-11'),
                    ('Community Library', 'Alkhobar', 101112, '2003-02-14');

INSERT INTO Staff (Fname, Position, Concat_num, Lib_id) 
           VALUES (N'Ahmed Ali',    N'Librarian',  5011, 3),
                  (N'Sara Hassan',  N'Assistant',  5012, 1),
                  (N'Omar Khaled',  N'Librarian',  5013, 2),
                  (N'Noor Salem',   N'Assistant',  5014, 4),
                  (N'Mohammed Saad',N'Manager',    5015, 10),
                  (N'Layla Nasser', N'Librarian',  5016, 7),
                  (N'Yousef Adel',  N'Assistant',  5017, 6),
                  (N'Huda Faris',   N'Librarian',  5018, 5),
                  (N'Faisal Ahmed', N'Staff',      5019, 9),
                  (N'Reem Majed',   N'Assistant',  5020, 8);

insert into Member (Full_name, Phone_num, Email, mem_ship_start, lib_ID)
            values ('Ahmed Ali', 501234567, 'ahmed.ali@gmail.com', '2023-01-10', 1),
                   ('Sara Mohamed', 501234568, 'sara.mohamed@email.com', '2023-02-15', 9),
                   ('Khaled Hassan', 501234569, 'khaled.hassan@email.com', '2023-03-20', 2),
                   ('Mona Ibrahim', 501234570, 'mona.ibrahim@gmail.com', '2023-04-05', 10),
                   ('Omar Youssef', 501234571, 'omar.youssef@email.com', '2023-05-12', 5),
                   ('Laila Ahmed', 501234572, 'laila.ahmed@email.com', '2023-06-18', 7),
                   ('Hassan Nabil', 501234573, 'hassan.nabil@gmail.com', '2023-07-01', 8),
                   ('Noor Salem', 501234574, 'noor.salem@email.com', '2023-08-09', 3),
                   ('Yara Fathi', 501234575, 'yara.fathi@email.com', '2023-09-14', 4),
                   ('Mahmoud Adel', 501234576, 'mahmoud.adel@gmail.com', '2023-10-22', 6);



insert into Book (ISBN, Title, Genre, Price, Avilability, Self_location, Lib_id, mem_id )
          values (100001, 'Database Fundamentals', 'Reference', 45.50, 'TRUE',  'A1', 1, 1),
                 (100002, 'Learning SQL', 'Non-fiction', 39.99, 'TRUE',  'A2', 3, 2),
                 (100003, 'The Great Adventure', 'Fiction', 25.00, 'FALSE', 'B1', 2, 3),
                 (100004, 'Children Stories Vol 1', 'Children', 15.75, 'TRUE',  'C1', 10, 4),
                 (100005, 'Advanced Programming', 'Reference', 60.00, 'TRUE',  'A3', 5, 5),
                 (100006, 'History of Science', 'Non-fiction', 42.25, 'FALSE', 'B2', 8, 6),
                 (100007, 'Mystery Night', 'Fiction', 30.00, 'TRUE',  'B3', 6, 7),
                 (100008, 'Kids Learning ABC', 'Children', 18.90, 'TRUE',  'C2', 7, 8),
                 (100009, 'Artificial Intelligence', 'Reference', 75.00, 'FALSE', 'A4', 4, 9),
                 (100010, 'Life Stories', 'Non-fiction', 28.50, 'TRUE',  'B4', 9, 10);

insert into Reviw (Rating, Review_date, Comment,  bookID, memID)
           values (5, '2023-01-15', 'Excellent book, very useful', 1, 1),
                  (4, '2023-01-20', 'Good content and easy to understand', 2, 2),
                  (3, '2023-02-05', 'Average, could be better', 3, 3),
                  (5, '2023-02-18', 'Highly recommended', 4, 6),
                  (2, '2023-03-01', 'Not what I expected', 5, 5),
                  (4, '2023-03-10', 'Well written and informative', 6, 7),
                  (1, '2023-03-22', 'Poor quality content', 7, 4),
                  (5, '2023-04-02', 'Perfect for beginners', 8, 8),
                  (3, '2023-04-15', 'Decent but a bit long', 9, 9),
                  (4, '2023-04-25', 'Enjoyed reading it', 10, 10);

insert into loan ( Loan_date, Due_date, Status, Return_date, memb_id, book_id)
          values ('2023-01-05', '2023-01-20', 'Returned', '2023-01-18', 5, 1),
                 ('2023-01-10', '2023-01-25', 'Returned', '2023-01-25', 2, 6),
                 ('2023-02-01', '2023-02-15', 'Issued',   NULL,         8, 3),
                 ('2023-02-05', '2023-02-20', 'Overdue',  NULL,         4, 2),
                 ('2023-03-01', '2023-03-15', 'Returned', '2023-03-14', 10, 5),
                 ('2023-03-10', '2023-03-25', 'Issued',   NULL,         6, 4),
                 ('2023-04-01', '2023-04-15', 'Returned', '2023-04-10', 7, 9),
                 ('2023-04-05', '2023-04-20', 'Overdue',  NULL,         3, 8),
                 ('2023-05-01', '2023-05-15', 'Returned', '2023-05-15', 9, 7),
                 ('2023-05-10', '2023-05-25', 'Issued',   NULL,         1, 10);

insert into payment (Amount, Payment_date, Method, loanID)
             values (5.00,  '2023-01-12', 'Cash',        10),
                    (12.50, '2023-01-20', 'Credit Card', 1),
                    (8.00,  '2023-02-05', 'Cash',        9),
                    (15.75, '2023-02-18', 'Debit Card',  3),
                    (6.25,  '2023-03-01', 'Online',      5),
                    (20.00, '2023-03-15', 'Credit Card', 4),
                    (9.50,  '2023-04-02', 'Cash',        7),
                    (14.00, '2023-04-18', 'Online',      6),
                    (7.75,  '2023-05-05', 'Debit Card',  2),
                    (18.30, '2023-05-22', 'Credit Card', 8);

--use SELECT to Selecting Specific Columns

select Lib_name, Location from Library;

select Title, Genre, Price from Book;

select Full_name, Email from Member;

select ID, Fname, Position from Staff;

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

select * from Book where Price >= 15; 

select * from Reviw where Rating != 5;

--Logical Operators (AND, OR, NOT)

select * from Book where Genre = 'Fiction' AND Avilability = 'True';

select * from Book where Genre = 'Fiction' OR Genre = 'Children';

select * from Library where YEAR (Stablish_year) < 2016 AND Location = 'Dammam';

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

select * from Library where Lib_name like '%Library';

select * from Book where Title LIKE '%Adventure%';

select * from Staff where Fname LIKE 'O%';

--Working with NULL Values

select * from loan where Return_date IS NULL;

select * from loan where Return_date IS NOT NULL;

select * from Reviw where Comment IS NULL OR Comment = 'No comments';

--Complex Combined Queries

select * from Book where Genre = 'Fiction' AND Avilability = 'TRUE' AND Price < 100 ORDER BY Price ASC;

select TOP 5 * from loan where Status = 'Overdue' ORDER BY Due_date DESC;

select * from Library where ( Location = 'Jeddah' OR Location = ' Riyadh') AND year (Stablish_year) < 2005 ORDER BY Lib_name;

select * from Book where (Genre = 'Fiction' OR Genre = 'Children') AND Price between 10 AND 30 AND Avilability = 'TRUE';

select * from Member where ( year (mem_ship_start) >= 2023 AND year (mem_ship_start) < 2024) AND Email LIKE '%@gmail.com' ORDER BY mem_ship_start ASC;

--Challenge Queries

select TOP 10 * from Book where Genre IN ('Fiction', 'Non-fiction') AND Avilability = 'TRUE' ORDER BY Price DESC;

select * from loan where (year (Loan_date) >= 2023 AND year (Loan_date) < 2024) AND Return_date IS NULL ORDER BY Loan_date ASC;

select Fname, Lib_name from Staff, Library L where L.ID = Lib_id AND year (L.Stablish_year) < 2010 AND (Position = 'Librarian' OR Position = 'Assistant');

select Title from Book B LEFT OUTER JOIN Reviw ON B.ID = bookID where Review_date = '2023-04-25';

--Two-Table INNER JOINs

select ID, Title, Loan_date, Due_date from loan, Book B where B.ID = book_id;

select Fname, Position, Lib_name,Location from Staff, Library L where L.ID = Lib_id;

select Title, Genre, Price, Lib_name, Location from Book, Library L where L.ID = Lib_id;

select Full_name, Rating, Comment, Review_date from Reviw, Member M where M.ID = memID;

select Title, Rating, Comment, Review_date from Reviw, Book B where B.ID = bookID;

select Payment_date, Amount, Method, Status from payment P, loan L where L.Loan_ID = P.loanID;