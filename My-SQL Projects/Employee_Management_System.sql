create database employee_salary_details;
use employee_salary_details;

create table Employee ( Employee_id int primary key , Employee_name varchar(255), department varchar(100), position varchar(100), hire_date date ,base_salary decimal(10,2));
create table Attendance (Attendence_id int primary key , Employee_id int ,Attendence_date date ,emp_Status enum('present','absent','leave'),foreign key(Employee_id )references Employee(Employee_id));
create table Salaries (Salary_id int primary key ,Employee_id int, Base_salary decimal(10,2),Bonus decimal(10,2),Deductions decimal(10,2),This_Month varchar(20),This_year int ,foreign key(Employee_id)references Employee(Employee_id));
create table Payroll (Payroll_id int primary key,Employee_id int,Total_salary decimal(10,2),Payment_date date ,foreign key(Employee_id)references Employee(Employee_id));

insert into Employee ( Employee_id , Employee_name, department, position , hire_date,base_salary) values (001,'Anand','IT','Software engineer','2020-02-01',38000),(002,'Anamika','IT','Data scientist','2023-02-15',32000),(003,'Divya','IT','Data Analist','2025-08-01',29000),(004,'Vibin','IT','Software engineer','2024-05-15',34000);
insert into  Attendance (Attendence_id, Employee_id,Attendence_date,emp_Status )values(1,001,'2026-02-01','present'),(2,002,'2026-02-01','present'),(3,003,'2026-02-01','leave'),(4,004,'2026-02-01','present');
insert into Salaries (Salary_id,Employee_id, Base_salary,Bonus ,Deductions,This_Month,This_year)values(010,001,38000,1000,500,'january',2026),(020,002,32000,1000,1500,'january',2026),(030,003,29000,2000,500,'january',2026),(040,004,34000,1000,0,'january',2026);
insert into Payroll (Payroll_id,Employee_id ,Total_salary,Payment_date)values(011,001,38500,'2026-02-28'),(012,002,31500,'2026-02-28'),(013,003,30500,'2026-02-28'),(014,004,35000,'2026-02-28');

 -- Add New Employees: 
insert into Employee ( Employee_id , Employee_name, department, position , hire_date,base_salary) values (005,'Siva','IT','Software engineer','2025-12-01',29000);

 -- Update Employee Information: 
update Salaries set Deductions=500 where Employee_id=004; 

 -- Delete Employee Records: 
delete from Employee where Employee_id=005;

-- Track Employee Attendance:
select e.Employee_id ,e.Employee_name ,a.emp_Status from Attendance a join Employee e on  e.Employee_id =a. Employee_id;

 -- Calculate Salary: 
select e.Employee_id ,e.Employee_name ,(s.Base_salary+s.Bonus-Deductions) as total_salary from Salaries s join Employee e on  e.Employee_id =s.Employee_id;

-- Manage Deductions and Bonuses:
update Salaries set Bonus=2000 where Employee_id=003;

 -- Update Payroll Records: 
select  e.Employee_id ,e.Employee_name,p.Total_salary,p.Payment_date from Payroll p join Employee e on e.Employee_id=p.Employee_id;

 -- Generate Pay Slips: 
select  e.Employee_id ,e.Employee_name,p.Payment_date,s.Base_salary,s.Bonus,s.Deductions,p.Total_salary from Employee e join Salaries s on  e.Employee_id =s.Employee_id join Payroll p on e.Employee_id=p.Employee_id where e.Employee_id=001;
select  e.Employee_id ,e.Employee_name,p.Payment_date,s.Base_salary,s.Bonus,s.Deductions,p.Total_salary from Employee e join Salaries s on  e.Employee_id =s.Employee_id join Payroll p on e.Employee_id=p.Employee_id where e.Employee_id=002;
select  e.Employee_id ,e.Employee_name,p.Payment_date,s.Base_salary,s.Bonus,s.Deductions,p.Total_salary from Employee e join Salaries s on  e.Employee_id =s.Employee_id join Payroll p on e.Employee_id=p.Employee_id where e.Employee_id=003;
select  e.Employee_id ,e.Employee_name,p.Payment_date,s.Base_salary,s.Bonus,s.Deductions,p.Total_salary from Employee e join Salaries s on  e.Employee_id =s.Employee_id join Payroll p on e.Employee_id=p.Employee_id where e.Employee_id=004;

 -- Generate Payroll Reports: 
select  e.Employee_id ,e.Employee_name,e.department,e.position , e.hire_date,a.Attendence_id,a.Attendence_date,a.emp_Status,s.Salary_id, s.Base_salary,s.Bonus ,s.Deductions,s.This_Month,s.This_year,p.Payroll_id,p.Total_salary,p.Payment_date  from Employee e join Salaries s on  e.Employee_id =s.Employee_id join Attendance a on  e.Employee_id =a. Employee_id join Payroll p on e.Employee_id=p.Employee_id;

-- Employees earning above average salary :
SELECT Employee_id, Employee_name, Base_salary FROM Employee WHERE Base_salary > (SELECT AVG(Base_salary) FROM Employee);

-- Highest Paid Employee :
SELECT * FROM Employee ORDER BY Base_salary DESC LIMIT 1;

-- Lowest Paid Employee :
SELECT * FROM Employee ORDER BY Base_salary LIMIT 1;

-- Department-wise Salary Report :
SELECT Department, COUNT(*) AS Total_Employees, SUM(Base_salary) AS Total_Salary, AVG(Base_salary) AS Average_Salary, MAX(Base_salary) AS Highest_Salary, MIN(Base_salary) AS Lowest_Salary FROM Employee GROUP BY Department;

-- Attendance Summary :
SELECT Employee_id, COUNT(CASE WHEN emp_Status='present' THEN 1 END) AS Present_Days, COUNT(CASE WHEN emp_Status='absent' THEN 1 END) AS Absent_Days, COUNT(CASE WHEN emp_Status='leave' THEN 1 END) AS Leave_Days FROM Attendance GROUP BY Employee_id;

-- Employees hired after 2023 :
SELECT * FROM Employee WHERE Hire_Date>'2023-12-31';

-- Common Table Expression (CTE) :
WITH SalaryCTE AS(SELECT Employee_id, Base_salary+Bonus-Deductions AS NetSalary FROM Salaries)SELECT * FROM SalaryCTE WHERE NetSalary>32000;