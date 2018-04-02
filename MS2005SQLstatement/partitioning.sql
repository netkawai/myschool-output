use aptDatabase

-- create the condition for separating each data.
create partition function PF_EmployeeP (int)
as range left for Values (3,5)
-- create the assignment of partitioning for the above condition.
-- Also see create parition in the Microsoft help.
create partition scheme PS_EmployeeP
as partition PF_EmployeeP all to ((primary))

-- create table on the above partition.
create table EmployeeP
(
EmpID int NOT NULL primary key,
Name varchar(30) NOT NULL,
DateofBirth datetime NOT NULL,
City varchar(40) NOT NULL
) on PS_Employee_Partition(EmpID)

-- create index on the same partition.
create nonclustered index IX_City
on EmployeeP(City) on PS_EmployeeP (EmpID)
