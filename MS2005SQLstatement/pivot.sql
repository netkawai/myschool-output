use LocalDatabase
-- sample1
if object_id('dbo.myPurchasing', 'U') is not null
  drop table dbo.myPurchasing
go
create table myPurchasing
(
)
go
select EmployeeID, [2002]Y2002, [2003]Y2003
from
(select year(OrderDate)OrderYear,
EmployeeID, TotalDue
from myPurchasing)
pivot
(
SUM(TotalDue)
For OrderYear in ([2002],[2003])
)pvt


-- sample2
if object_id('dbo.Batch', 'U') is not null
	drop table dbo.Batch
go
create table Batch
(BatchNo nvarchar(5),
Subject nvarchar(25),
SubjDesc nvarchar(25),
StartDt datetime,
ENdDt datetime,
Hours int);
go
insert into Batch values
('A01', 'Java', 'Database', '01-12-2006', '05-15-2006', 96);
insert into Batch values
('A02', 'Oracle', 'Forms', '08-12-2006', '09-15-2006', 55);
insert into Batch values
('A03', 'SQL Server', 'Queries', '09-12-2006', '10-11-2006', 46);
insert into Batch values
('A04', 'Networking', 'Protocols', '10-12-2006', '11-15-2006', 48);
insert into Batch values
('A05', 'JFS & Structure', 'CustomControls', '09-12-2005', '10-15-2006', 120);
select * from Batch
select datediff(month,StartDt, EndDt) From Batch
select BatchNo, [2005] Y2005, [2006] Y2006 from
(select year(StartDt) StartYear, BatchNo, Hours from Batch) p
pivot
(
sum(Hours)
for StartYear in ([2005],[2006])
)  as pvt
go