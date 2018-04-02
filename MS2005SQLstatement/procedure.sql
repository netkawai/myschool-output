use LocalDatabase

-- SQL login
exec sp_who 'Kawai';
go

-- display the data in bulit-in memory without from.
select getdate()
select datepart(day,getdate())
select datepart(month,getdate())
select sqrt(16)

select getdate();
go;

declare @code char(4);
declare @cid int;
set @code = '101';
set @cid = convert(int, @code);
print @cid;
go;

exec sp_helptext 'xp_fileexist'
exec sp_helptext 'xp_grantlogin'
exec sp_helptext 'sp_rename'
exec sp_helpindex 'Employee'
go;

-- can't execute the below.
sp_helptext 'dbo.CricketSchemaCollection'
go;

create procedure proc_empdetails
as
select * from employee where empcode='E101'
go;

exec proc_empdetails
go;

create procedure procEmpInfo(@code char(4))
as
select * from employee where empcode=@code;
go;

exec procEmpInfo 'E100'
go;

-- create procedure for getting the maximum salary.
create procedure procMax_SalaryProc 
	@code char(4), 
-- this argument is input/output value.
	@max_sal int output
as
select @max_sal = MAX(EmpSalary) from Employee where empcode>@code
go;

-- use the above procedure for using input value(@code), reference value(@max_sal)
declare @max_sal int
execute procMax_SalaryProc 'E102', @max_sal output
print 'Maximun Salary is' + convert(varchar(20), @max_sal);
go;

select * from sys.sql_modules
sp_helptext 'sys.sql_modules'
go;

-- Altering Procedure
alter procedure procEmpInfo
as
-- new defn
select * from employee
go;

-- You can store the below procedure but you can't execute it
create procedure retNameProc
	@code char(4)
as
	begin
		declare @ename varchar(20);
		select @ename = EmpName from Employee where EmpCode=@code;
		return @ename; -- can't convert varchar(20) to int
	end
go;

declare @ename varchar(20);
exec @ename=retNameProc 'E101';
print @ename;
go;

-- convert date of any type to int
create procedure getEmpIdproc
	@code char(4)
as
	begin
		-- convert ascii integer
		return convert(int, (substring(@code, 2, 4)))
	end
go;

declare @num int;
exec @num=getEmpIdproc 'E102';
print @num
go;