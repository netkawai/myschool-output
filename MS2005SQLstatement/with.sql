use LocalDatabase
if object_id('dbo.Department','U') is not null
  drop table Department;
go
create table Department
(DeptNo int,DeptName varchar(20),DeptLocation varchar(20));
go
insert into Department values(10,'Devlop','Bangalore');
insert into Department values(20,'Market','Munbai');
insert into Department values(30,'Advertise','Kolkata');
insert into Department values(40,'H.R','Delhi');
insert into Department (Deptno,Deptname) values(50,'Admin');
go
select * from Department

if object_id('dbo.dept2','U') is not null
  drop table dept2;
go
create table dept2 (DeptNo int,DeptName varchar(20));
go
select * from dept2;
-- To mainly execute 'insert into' with tdept_CTE as as select * from Departmet where DeptNo>=30
with tdept_CTE (dno,dname)
as (
select DeptNo,DeptName from Department where deptno>=30
)
insert into dept2 select * from tdept_CTE; 
go
select * from dept2;
go
