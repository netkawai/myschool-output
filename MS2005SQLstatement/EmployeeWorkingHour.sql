-- test1 sequence
declare @stdt as datetime
declare @enddt as datetime
declare @Timediff int
set @stdt = '10-jan-2010 8:45:00'
set @enddt = '10-jan-2010 18:21:00'
set @Timediff=datediff(mi,@stdt,@enddt)
print CAST(@Timediff / 1440 AS VARCHAR(12)) + ' day(s) ' + CONVERT(CHAR(8), DATEADD(MINUTE, @Timediff % 1440, '00:00'), 108) 
print @Timediff
-- test2 sequence
declare @month int;
declare @year int;
declare @curMonthTime datetime;
set @month = 3;
set @year = 2008;
set @curMonthTime = convert(datetime, cast(@month as nchar(2)) + '/01/' +  cast(@year as nchar(4)));
print @curMonthTime
-- test3 sequence
declare @myyear int;
declare @mymonth int;
declare @numdays int;
set @myyear = 2008;
set @mymonth = 3;
--exec @numdays = retNumberOfDays '2008','3';
exec @numdays = retNumberOfDays @myyear,@mymonth;
print @numdays
-- can't execute sequence
declare @tablename char(20);
declare @empid int;
set @empid = 12;
set @tablename = 'WorkRecord' + convert(char(2),@empid);
print @tablename
create table @tablename (EmpId int)
go;


drop procedure retNumberOfDays

use aptDatabase
-- Counting the number of days in the specific month.
create procedure retNumberOfDays
	@year  int,
	@month int
as
	begin
		declare @curMonth datetime;
		declare @nextMonth datetime;
		set @curMonth = convert(datetime, cast(@month as nchar(2)) + '/01/' +  cast(@year as nchar(4)));
		set @nextMonth = convert(datetime, cast((@month+1) as nchar(2)) + '/01/' +  cast(@year as nchar(4)));
--		print @curMonth;
--		print @nextMonth;
		return datediff(day, @curMonth,@nextMonth);
	end


-- To record the time starting work.
create procedure procStartWork
	@empid int
as
begin
	declare @curTime datetime;
	set @curTime = getdate()
update WorkTimeRecord set [StartTime] = @curTime
	where EmpId=@empid 
		and WorkYear = year(@curTime) 
		and WorkDay = day(@curTime)
		and WorkMonth = month(@curTime)
end
-- To record the time finishing time.
create procedure procFinishWork
	@empid int
as
begin
	declare @curTime datetime;
	set @curTime = getdate()
update WorkTimeRecord set [FinishTime] = @curTime
	where EmpId=@empid 
		and WorkYear = year(@curTime) 
		and WorkDay = day(@curTime)
		and WorkMonth = month(@curTime)
end

-- To add the one month records
create procedure addWorkRecordMonth
	@empid int,
	@myyear int,
	@mymonth smallint
as
begin
declare @dayscount int;
declare @numofday int;
if object_id('WorkTimeRecord', 'U') is null
begin
	create table WorkTimeRecord
	(EmpId int /*foreign key references EmployeeTable(EmpId)*/ not null default(0),
	WorkYear int not null default(0), 
	WorkMonth smallint not null default(0),
	WorkDay smallint not null default(0),
	StartTime datetime null,
	FinishTime datetime null,
	WorkMinute as datediff(mi,[StartTime],[FinishTime]));
end
if(((@myyear) in (select WorkYear from WorkTimeRecord))
and ((@mymonth) in (select WorkMonth from WorkTimeRecord))
and ((@empid) in (select EmpId from WorkTimeRecord)))
	begin
		print 'its data has already added.'
	end
else
begin 
	exec @numofday = retNumberOfDays @myyear, @mymonth;
	print @numofday;
	set @dayscount = 1;
		while(@dayscount <= @numofday)
		begin
			insert into WorkTimeRecord values(@empid,@myyear, @mymonth, @dayscount, null,null);
			set @dayscount = @dayscount  + 1;
		end
	end
end


create procedure updateWorkRecord
	@empid int
as
begin
	declare @curTime datetime;
	declare @curYear int;
	declare @curMonth smallint;
	set @curTime = getdate();
	set @curYear = year(@curTime);
	set @curMonth = month(@curTime);
	exec addWorkRecordMonth @empid, @curYear , @curMonth;	
end
-- To initial record.
exec updateWorkRecord 1
exec updateWorkRecord 2
exec updateWorkRecord 3
exec updateWorkRecord 4
exec updateWorkRecord 5

exec procStartWork 1
exec procStartWork 2
exec procStartWork 3
exec procStartWork 4
exec procStartWork 5

exec procFinishWork 1
exec procFinishWork 2
exec procFinishWork 3
exec procFinishWork 4
exec procFinishWork 5


create table EmployeeTable
(EmpId int primary key,
 EmpName varchar(20) not null,
 EmpAddr varchar(50) null,
 EmpLevel smallint not null
)
insert into EmployeeTable values(1,'James','Koramagala',9)
insert into EmployeeTable values(2,'David','Brigade',7)
insert into EmployeeTable values(3,'Charles','Jantinagra',5)
insert into EmployeeTable values(4,'Thomas', 'M.G. Road',4)
insert into EmployeeTable values(5,'Richard', NULL, 3)
drop table EmployeeTable

create table SalaryLevelTable
(EmpLevel smallint primary key,
 Salary money
)
insert into SalaryLevelTable values(9,100000)
insert into SalaryLevelTable values(8,70000)
insert into SalaryLevelTable values(7,50000)
insert into SalaryLevelTable values(6,30000)
insert into SalaryLevelTable values(5,25000)
insert into SalaryLevelTable values(4,20000)
insert into SalaryLevelTable values(3,18000)
insert into SalaryLevelTable values(2,16000)
insert into SalaryLevelTable values(1,14000)

-- To create the view for calcurating the hour of employee
-- group by empid and pick up them on current month/year
create view TotalWorkHourView
as
select r.empid, (sum(r.WorkMinute)/60.0) as Totalhour from 
	  WorkTimeRecord r 
	  where WorkYear = year(getdate()) 
		and WorkMonth = month(getdate())
		group by r.empid

drop view TotalWorkHourView

select * from TotalWorkHourView

create view EmployeeSalaryView
as
select e.empid, m.Salary
from SalaryLevelTable m, EmployeeTable e 
where m.emplevel = e.emplevel

create view SalaryView
as
select e.empid, e.empname, t.totalhour, (t.totalhour*m.Salary) as TotalSalary
from
	EmployeeTable e,TotalWorkHourView t,EmployeeSalaryView m
	where e.empid = t.empid and e.empid = m.empid
drop view SalaryView

select * from SalaryView
select * from employeetable

select * from salaryview where
			empid=(select empid from employeetable where emplevel=9)


-- can't multiple column
select e.EmpId, e.EmpName, (sum(r.WorkMinute)/60.0) as Totalhour from 
	EmployeeTable e, WorkTimeRecord r
where e.EmpId = r.EmpId order by r.EmpId

-- select the multiple sum records
select r.empid, (sum(r.WorkMinute)/60.0) as Totalhour from 
	  WorkTimeRecord r group by r.empid

-- you should mind the one record and the number of records
-- if you want to combine the multiple colums, 
-- the number of records should be the same.
-- select only one record
select r.empid,(sum(r.WorkMinute)/60.0) as Totalhour from 
	 WorkTimeRecord r where r.empid=1 group by r.empid

-- only tempolary table
create view EmployeeWorkTimeView
as
select e.EmpId, e.EmpName, (sum(r.WorkMinute)/60.0) as Totalhour from 
	EmployeeTable e, WorkTimeRecord r
where e.EmpId = r.EmpId order by r.EmpId asc
