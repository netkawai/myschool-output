use LocalDatabase
-- sample1
if object_id('dbo.StoreTable','U') is not null
  drop table StoreTable;
go
-- create StoreTable
create table StoreTable(
	KeyID int identity,
	PersonalName char(20))
-- only insert PersonalName into OutputTable, because KeyID has the constraint of Identity.
-- it is automatically inserted by system.
insert into StoreTable (PersonalName) values ('Jim')
insert into StoreTable (PersonalName) values ('Markus')
select * from StoreTable

-- declare local variable with table
declare @tempTable table(
	KeyID int, OldName varchar(20), NewName varchar(20));
-- To output the deleted data and inserted data into @tempTable on updating StoreData
update StoreTable set PersonalName=UPPER(PersonalName)
output Inserted.KeyID,Deleted.PersonalName,Inserted.PersonalName into @tempTable;
select * from @tempTable
go



-- sample2
use LocalDatabase
if object_id('dbo.HotelPriceList','U') is not null
  drop table HotelPriceList;
go
create table HotelPriceList(
  HotelNumber int identity(100,1), HotelName varchar(20),Price money);
-- insert list data
insert into HotelPriceList(HotelName,Price) values ('Marriott', 1000);
insert into HotelPriceList(HotelName,Price) values ('BestWestern',800);
insert into HotelPriceList(HotelName,Price) values ('Hampton Inn',700);
select * from HotelPriceList
declare @PriceChangeDetails table(
	HotelNumber int,Price money, NewPrice money);
update HotelPriceList /* This statement update HotelPriceList table where's HotelNumber = 101 */
set Price = 1200 -- continue and the update statement creates a trigger value, one is deleted value(1000), another is inserted(e.g.updated).value(3000)  
output INSERTED.HotelNumber, DELETED.Price, INSERTED.Price into @PriceChangeDetails
where HotelNumber = 101
select * from @PriceChangeDetails
