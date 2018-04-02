create database [TestDB] on primary
( name =N'TestDB', filename = N'D:\Kawai\DB\TestDB.mdf')
LOG ON
( name = N'TestDB_log', filename = N'D:Kawai\DB\TestDB_log.ldf')
collate SQL_Latin1_General_CP1_CI_AS

-- rename TestDB
alter database TestDB modify name = StudentDB

create database CustomDB
on
( name = Customer_data,
	filename = 'D:\Kawai\DB\CustomerDat.mdf',
	size = 10,
	maxsize = 50,
	filegrowth = 5)
log on
( name = Customer_log,
	filename = 'D:\Kawai\DB\Customer.ldf',
	size = 5MB,
	maxsize = 25MB,
	filegrowth = 5MB)


use StudentDB;
create database StudentDB_snapshot1 on
( name= StudentDB, filename= 'D:\Kawai\Data\StudentDB_snapshot_june072010.ss'),
( name= Student_Data, filename = 'D:\Kawai\Data\StudentDB2_snapshot_june072010.ss')
as snapshot of studentDB;

drop database StudentDB_snapshot1