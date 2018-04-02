if object_id('Employee','U') is not null
  drop table Employee;
go



select sum(empsalary) from employee
select empname, empsalary*0.1 as Bonus from employee

select empname+'-->'+convert(varchar(10),empsalary) from employee

create table Calc_Area(Length int, Breadth int, Area As Length*Breadth)

select * from department

-- To update all data in the specific column.
update department set deptlocation='Delhi' 

update department set deptlocation='Delhi' where deptno=10
update department set deptlocation='Bangalore' where deptno=20
update department set deptlocation='Mumbai' where deptno=30
update department set deptlocation='Kolkata' where deptno=40

delete from department

delete from department where deptno=40

select * from tempdepartment

