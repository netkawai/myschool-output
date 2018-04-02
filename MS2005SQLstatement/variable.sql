select @@version as sqlServerVersionDetails
select @@identity as [Identity]

declare @salary int;
declare @tempEmployee table(
  EmpName varchar(20), EmpSalary money);
insert into @tempEmployee values('James',1000);
insert into @tempEmployee values('Thomas',2000);
insert into @tempEmployee values('Jack',3000);
set @salary=1500;
select * from @tempEmployee where EmpSalary>@salary

