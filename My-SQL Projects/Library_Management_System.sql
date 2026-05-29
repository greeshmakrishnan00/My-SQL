create database LibraryCB;
use LibraryCB;
create table Books( book_id int auto_increment primary key, Title varchar(255) not null,Author varchar(255) not null,Genre varchar(100),published_year year, Is_available boolean default true);
create table Members(Members_id int auto_increment primary key, Member_name varchar(255) not null,email varchar(255),phone_number varchar(15),join_date date default (current_date));
create table Librarians(Librarian_id int auto_increment primary key,Librarian_name varchar(255) not null,email varchar(255),phone_number varchar(15),hire_date date default(current_date));
create table Borrowing (Loan_id int auto_increment primary key,Book_id int,Member_id int,Borrow_date date default (current_date) ,Return_date date,Librarian_id int, foreign key(Book_id)references Books(Book_id),foreign key(Member_id)references Members(Members_id),foreign key(Librarian_id)references Librarians(Librarian_id));

insert into Books(Title,Author,Genre,published_year)values ('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925),('1984', 'George Orwell', 'Dystopian', 1949),('To Kill a Mockingbird', 'Harper Lee', 'Classic', 1960);
insert into Members(Member_name,email,phone_number)values ('Alen King', 'alenking@example.com', '1234567890'),('Alece Hofman', 'alecehofman@example.com', '9876543210');
insert into Librarians(Librarian_name,email,phone_number)values ('Nail Horn', 'nail@example.com', '4567891230'),('Garden McGraw', 'garden@example.com', '7894561230');
insert into Borrowing (Book_id,Member_id,Librarian_id)values(1,1,1);

update Books set is_available= false where Book_id=1;
update Borrowing set Return_date= (current_date) where Loan_id=1;
update Books set is_available= true where Book_id=1;

select*from Books where Is_available=true;

select m.Member_name,b.Title,br.Borrow_date,br.Return_date from Borrowing br join Members m on br.Member_id=m.Members_id join Books b on br.Book_id=b.Book_id where m.members_id=1; -- Member Loan History 

select m.Member_name,b.Title,br.Borrow_date from Borrowing br join Members m on br.Member_id=m.Members_id join Books b on br.Book_id=b.Book_id where br.Return_date is null and br.Borrow_date<current_date-interval 14 day; -- Overdue books (>14 days) 

select Title,Genre,published_year from Books where Author='George Orwell'; -- Books by 'George Orwell' 

select Title,Genre,published_year from Books where published_year>2000; -- Book published after 2000

select count(*) as Total_books from Books; --  Total books in library

select m.Member_name,br.Borrow_date,br.Return_date from Borrowing br join Members m on br.Member_id=m.Members_id join Books b on br.Book_id=b.Book_id where b.Title='1984'; -- Members who borrowed '1984'

select b.Title,br.Borrow_date,br.Return_date from Borrowing br join Books b on br.Book_id=b.Book_id where br.member_id=1; -- Bor;rowing history for member 1 

select Title,Author,published_year from Books where Genre='Fiction' and Is_available=True; -- Available Fiction books 

select m.Member_name,count(br.Loan_id)as Total_Books_Borrowed from Borrowing br join  Members m on br.Member_id=m.Members_id group by m.Member_name; -- Total books borrowed per member 

select m.Member_name,br.Borrow_date,b.Title  from Borrowing br join Members m on br.Member_id=m.Members_id join Books b on br.Book_id=b.Book_id where br.Return_date is null and br.Borrow_date<current_date-interval 30 day; -- Overdue books not returned (>30 days)

select l.Librarian_name,count(br.Loan_id) as Total_borrowings from Borrowing br join Librarians l on br.Librarian_id=l.Librarian_id group by l.Librarian_name order by Total_borrowings desc; -- Top librarians by borrowings

select m.Member_name,br.Borrow_date,b.Title  from Borrowing br join Members m on br.Member_id=m.Members_id join Books b on br.Book_id=b.Book_id where br.Return_date is null; -- Currently borrowed books 
 






 


