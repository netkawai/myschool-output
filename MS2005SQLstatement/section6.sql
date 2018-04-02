-- For Microsoft SQL 2005

use AdventureWorks
-- distinct column
select distinct(City) from Person.Address
-- count column
select count(EmployeeID) as TitleCount from HumanResources.Employee
-- avg column
select avg(Rate) from HumanResources.EmployeePayHistory

-- partical select
select top 25 percent * from Person.Address

-- To show the definition of sp_rename
exec sp_helptext 'sp_rename'

-- Different database
-- select database
use LocalDatabase
-- check already created table.
if object_id('dbo.Student', 'U') is not null
	drop table dbo.Student
go
-- create table
create table Student
(StudNo int primary key,
StudName nvarchar(50) not null,
StudAddr nvarchar(50),
StudPhone bigint,
BirthDate DateTime);
go
-- insert new data
insert into Student values
(1, 'Micahel John', 'New York', 9145247891, '12-01-1999');
insert into Student values
(2, 'Name2', 'Addr2', 2345567, '08-25-1989');
insert into Student values
(3, 'Name3', 'Addr3', 3455678, '02-15-1999');
insert into Student values
(4, 'Name4', 'Addr4', 34556789, '07-11-1990');
go
-- show
select * from Student
-- add new column
alter table Student add Country nvarchar (20) null
-- update table for all rows
update Student set Country='USA'
-- show
select * from Student
-- rename the column name
exec sp_rename 'dbo.Student.BirthData','BOD','column'
select * from Student
