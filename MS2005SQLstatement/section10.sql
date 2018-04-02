use LocalDatabase

if object_id 'dbo.Employee10' is not null
	drop table dbo.Employee10
go
create table Employee10
(
)
insert into dbo.Employee10 values
()
insert into dbo.Employee10 values
()

-- show
select * from Employee10

if object_id('dbo.EmployeeBonus','U') is not null
	drop table dbo.EmployeeBonus
go
-- create new table from Employee10
select EmployeeID,FirstName,Department,Salary, Salary*0.05 as YearlyBonous into EmployeeBonus from Employee10
select * from EmployeeBonus

select FirstName, Department from Employee10 where FirstName like 'J%'
select Department, count(*) 'NumberofEmployees' from Employee10 group by Department
select Department, sum(Salary) as 'SalaryTotal', count(EmployeeID) as 'NumberOfEmployees' from Employee10 group by Department

-- add a new column DepartmentNumber
alter table Employee10 add DepartmentNumber int
-- drop the column
alter table Employee10 drop column DepartmentNumber
