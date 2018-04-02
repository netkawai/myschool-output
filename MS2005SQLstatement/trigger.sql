-- create the trigger for checking the limitation of salary.
create trigger UpdateSalaryEmployeeTrigger on Employee for update
as
begin
	declare @salary money;
	set @salary = (select top(1) EmpSalary from inserted order by empsalary desc);
--  select the multiple records(rows). can't set the @salary valuable.
--  set @salary = select EmpSalary from inserted
	if(@salary > 10000)
	begin
		print 'Execeds the limit 10000'
		rollback transaction
	end
end


drop trigger UpdateSalaryEmployeeTrigger
-- update the date , however, the below transaction is rejected by trigger.
update employee set empsalary=110000 where empcode='E101'

-- update the deptno, also the below transaction is rejected by trigger
-- because the trigger transaction can't handle the mutiple of EmpSaray for
-- comparing.
update employee set deptno=20 where deptno=22

create trigger UpdateEmpDept on Department for update
as
	begin
		update employee set deptno = (select deptno from inserted)
			where dept = (select deptno from deleted)	
	end

update department set deptno=25 where deptname='develop'

create trigger InsertEmpDept on Employee for insert
as
	begin
	end

-- instead of trigger for the view of multiple tables
use aptDatabase

create table StudentTable(RoNo int primary key, StudName varchar(20), StudAddress varchar(20))

create table MarkTable(RoNo int foreign key references StudentTable(RoNo), Semister int, Mark int)

create view MarkDetailView 
as
select s.RoNo, s.StudName, m.Semister, m.Mark 
from StudentTable s, MarkTable m 
where s.RoNo = m.RoNo
 
select * from MarkDetailView

-- the below statement cause the error.
-- View or function 'MarkDetailView' is not updatable because the modification affects multiple base tables.
insert into MarkDetailView values(1013,'Thomas',2,450)

insert into MarkTable values(1011,3,440)

-- the below statement is the set variable using the select statement.
create trigger MarkDetailTrigger on MarkDetailView 
instead of insert
as
begin
	declare @semi int;
	select * from inserted; 
	select @semi = Semister from inserted;
	print @semi;
end

drop trigger MarkDetailTrigger

-- and then, we create the insted of trigger.
create trigger MarkDetailTrigger on MarkDetailView 
instead of insert
as
	begin
		declare @rno int;
		declare @semi int;
		declare @mark int;
		declare @name varchar(20);
		select @rno = RoNo from inserted;
		select @semi = Semister from inserted;
		select @mark = Mark from inserted;
		select @name = StudName from inserted;
		if((select RoNo from inserted) in (select RoNo from StudentTable))
			begin
				insert into MarkTable values(@rno,@semi,@mark);
			end
		else
			begin
				-- coming the new student.
				insert into StudentTable (RoNo, StudName) values(@rno,@name);
				insert into MarkTable values(@rno,@semi,@mark);
			end
	end

insert into MarkDetailView values(1013,'Thomas',2,450)

select * from studentTable
select * from MarkTable

