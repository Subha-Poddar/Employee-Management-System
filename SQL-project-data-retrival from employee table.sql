use db6
go

select * from Employee;

--1.Create the following tables from the flat file - Employee.csv

--creating table Emp_USA
select * into EMP_USA from Employee where Country = 'USA';
--creating table Emp_UK
select * into Emp_UK from Employee where Country = 'UK';
--creating table Emp_AUS
select * into Emp_AUS from Employee where Country = 'Australia';
--creating table Emp_CAN
select * into Emp_CAN from Employee where Country = 'Canada';
--creating table Emp_FRA
select * into Emp_FRA from Employee where Country = 'France';

select * from EMP_USA;
select * from Emp_UK;
select * from Emp_AUS;
select * from Emp_CAN;
select * from Emp_FRA;

--2. Write SQL queries for the following, data to be fetched from all the above tables -  
 --Problem 1: List all employees who have more than 7 years of experience.
 select * 
 from Employee 
 where YearsOfExperience > 7;

-- Problem 2: Calculate the average salary for each department.

select Department,
avg(Salary) as AverageSalary
from Employee
group by Department;

-- Problem 3: Find the employee with the highest salary.
--using sub query
select EmployeeName, Salary 
from Employee 
where Salary = (select max(Salary) as Salary from Employee);

--using CTE:
with ranked_salary as(select EmployeeName, salary, dense_rank() over (order by salary desc) as salary_rank from Employee)
select EmployeeName, Salary 
from ranked_salary where salary_rank = 1 

--Another Method (Using TOP):
select top 1 EmployeeName, 
Salary 
from Employee
order by Salary desc;

-- Problem 4: Get the total number of employees in each location.

select Location, 
count(EmployeeID) as NumberOfemployees
from Employee
group by Location;

--Problem 5:  List all employees in the 'IT' department who are located in 'San Francisco'.
Select * from Employee
where Department = 'IT' and Location = 'San Francisco';

--Problem 6: Calculate the total salary expense for the 'HR' department.

select Department , 
sum( Salary) as TotalSalary 
from Employee
where Department = 'HR'
group by department;

-- Problem 7: Find the average years of experience for employees in each country.

Select Country, 
avg(YearsOfExperience) as AverageExperience
from Employee
Group by Country;

-- Problem 8: List employees whose salary is above the average salary of their respective department.

select EmployeeID, EmployeeName, Department, Salary
from Employee as emp
where Salary > (select avg(Salary) from  Employee Where Department = emp.Department group by Department);

-- Problem 9: Get the details of employees who have the same number of years of experience as the average for their department.
select EmployeeID, EmployeeName, Department, YearsOfExperience
from Employee as emp
where YearsOfExperience in (select avg(YearsOfExperience) from  Employee Where Department = emp.Department group by Department);

---Problem 10: List the departments in descending order of their total salary expense.

Select Department, 
sum( Salary) as TotalSalary 
from  Employee
group by Department
order by TotalSalary desc;