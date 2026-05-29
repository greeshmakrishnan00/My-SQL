create database Student_Result_data;
use Student_Result_data;
 -- Tables 
create table Students(student_id int primary key,student_name varchar(200),student_department varchar(200),stud_year int);
create table Subjects(stuject_id int primary key,subject_name varchar(200),credits int);
create table Marks (mark_id int primary key,student_id int ,stuject_id int, marks int,foreign key(student_id) references Students(student_id),foreign key (stuject_id) references Subjects(stuject_id));

-- Insert values 
INSERT INTO Students (student_id,student_name,student_department,stud_year) VALUES
(1, 'Amit Sharma', 'Computer Science', 3),
(2, 'Priya Verma', 'Computer Science', 2),
(3, 'Rahul Mehta', 'Electronics', 3),
(4, 'Sneha Iyer', 'Mechanical', 1),
(5, 'Arjun Patel', 'Computer Science', 4);
INSERT INTO Subjects (stuject_id,subject_name,credits) VALUES
(101, 'Database Management Systems', 4),
(102, 'Data Structures', 3),
(103, 'Operating Systems', 4),
(104, 'Mathematics', 3),
(105, 'Computer Networks', 3);
INSERT INTO Marks (mark_id,student_id,stuject_id,marks) VALUES
-- DBMS (101)
(1, 1, 101, 85),
(2, 2, 101, 92),
(3, 3, 101, 78),
(4, 4, 101, 88),
(5, 5, 101, 95),
-- Data Structures (102)
(9, 1, 102, 90),
(10, 2, 102, 84),
(11, 3, 102, 76),
(12, 4, 102, 91),
(13, 5, 102, 87),
-- Operating Systems (103)
(17, 1, 103, 82),
(18, 2, 103, 79),
(19, 3, 103, 88),
(20, 4, 103, 85),
(21, 5, 103, 91),
-- Mathematics (104)
(25, 1, 104, 75),
(26, 2, 104, 89),
(27, 3, 104, 84),
(28, 4, 104, 92),
(29, 5, 104, 86),
-- Computer Networks (105)
(33, 1, 105, 88),
(34, 2, 105, 91),
(35, 3, 105, 79),
(36, 4, 105, 83),
(37, 5, 105, 94);

 --  Get top 3 students in each subject
select s.student_id,s.student_name,sj.subject_name,m.marks from Marks m join Subjects sj on m.stuject_id=sj.stuject_id join Students s on m.student_id=s.student_id where sj.subject_name='Database Management Systems' group by s.student_id,s.student_name,sj.subject_name,m.marks order by marks desc LIMIT 3; 
select s.student_id,s.student_name,sj.subject_name,m.marks from Marks m join Subjects sj on m.stuject_id=sj.stuject_id join Students s on m.student_id=s.student_id where sj.subject_name='Data Structures' group by s.student_id,s.student_name,sj.subject_name,m.marks order by marks desc LIMIT 3;
select s.student_id,s.student_name,sj.subject_name,m.marks from Marks m join Subjects sj on m.stuject_id=sj.stuject_id join Students s on m.student_id=s.student_id where sj.subject_name='Operating Systems' group by s.student_id,s.student_name,sj.subject_name,m.marks order by marks desc LIMIT 3;
select s.student_id,s.student_name,sj.subject_name,m.marks from Marks m join Subjects sj on m.stuject_id=sj.stuject_id join Students s on m.student_id=s.student_id where sj.subject_name='Mathematics' group by s.student_id,s.student_name,sj.subject_name,m.marks order by marks desc LIMIT 3;
select s.student_id,s.student_name,sj.subject_name,m.marks from Marks m join Subjects sj on m.stuject_id=sj.stuject_id join Students s on m.student_id=s.student_id where sj.subject_name='Computer Networks' group by s.student_id,s.student_name,sj.subject_name,m.marks order by marks desc LIMIT 3;

-- Calculate average marks per department
select s.student_department ,avg(m.marks) as average_mark from Marks m join Students s on m.student_id=s.student_id where s.student_department='Computer Science';
select s.student_department ,avg(m.marks) as average_mark from Marks m join Students s on m.student_id=s.student_id where s.student_department='Electronics';
select s.student_department ,avg(m.marks) as average_mark from Marks m join Students s on m.student_id=s.student_id where s.student_department='Mechanical';

-- Find students who failed in more than 2 subjects
select s.student_name, COUNT(*) AS failed_subjects from Marks m join Students s on m.student_id=s.student_id where m.Marks<80 group by s.student_id,s.student_name having COUNT(*)>2;

