use LocalDatabase
select * from sys.partitions
select object_name(4)
select object_name(5)
select object_name(85575343)

select db_id('LocalDataBase')
select db_name(5)
select object_id('Employee')
select object_name(2073058421)

create nonclustered index IX_Employee10City on Employee10(City)
select EmployeeID,FirstName,City from Employee10 where City='Bangalore'

-- Create index to avoid the calculation of every column.
create index IX_Area on Calc_Area(Area); 
