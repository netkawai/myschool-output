use LocalDatabase



select * from employee
select * from department

SELECT e.EmpName, e.EmpPhone, d.deptName, d.deptLocation
FROM Employee e JOIN Department d on e.deptno = d.deptno


-- This is only to display the result using the condition of index data.
select EmpName,deptname,deplocation from employee,department
		where employee.deparno=department.deptno

-- This is to create the view for the above result.
create view EmpDeptView
as
select EmpName,deptname,deptlocation from employee,department
		where employee.deptno=department.deptno

create view EmpBonusView
as
select e10.FirstName as FirstName, eb.Salary as Salary
from Employee10 e10, EmployeeBonus eb
where e10.EmployeeID = eb.EmployeeID

-- create EmpDeptBonusView
create view EmpDeptBonusView
as
select e10.FirstName as FirstName,d.DeptName as DepartName
from Department d join Employee e on d.DeptNo = e.DeptNo
join Employee10 e10 on e.EmployeeID = e10.EmployeeID

select * from EmpDeptBonusView order by DepartName asc

alter view EmpDeptBonus
as
select e.EmpName as FirstName,d.DeptName as DepartName
from Department d join Employee e on d.DeptNo = e.DeptNo

sp_helptext 'EmpDeptBonusView'
sp_depends 'EmpDeptBonusView'

sp_rename 'EmpDeptBounusView', 'EmpDeptNewView'

sp_helptext 'EmpView'
sp_depends 'EmpView'

-- alter EmpView to add schemabing again.
-- you should specify the same select statement.
alter view EmpView
with schemabinding
as
select EmpCode,EmpName,EmpSalary
from dbo.Employee

create view EmpBonusView
as
select e10.FirstName as FirstName, eb.Salary as Salary
from Employee10 e10, EmployeeBonus eb
where e10.EmployeeID = eb.EmployeeID and eb.Salary > 400000
with check option

-- the below statement can't execute 
update EmpBonusView set Salary=300000 where FirstName='John'

-- create view using table schema
create view EmpView
with schemabinding
as
select EmpCode,EmpName,EmpSalary
from dbo.Employee

alter table dbo.Employee alter column EmpName varchar(25)

-- create indexs for the view 
-- which should specify the schemabinding(the extension of microsoft)
create unique clustered index IX_View_EmpID
on EmpView(EmpCode)

insert into EmpView value('E111','Donal','2000')


create table sqltest(testid smallint, name nchar(10))
-- does not execute.
sp_helptext 'sqltest'

-- use the view
select * from EmpDeptView

-- can't create the below view
create view VersionView as select @@version
