if object_id('Pets','U') is not null
	drop table Pets
go
create table Pets (Type varchar(10), Store varchar(10), Number int)

insert into Pets values('Dog', 'Miami', 12)
insert into Pets values('Cat', 'Miami', 18)
insert into Pets values('Turtle', 'Tampa', 4)
insert into Pets values('Dog', 'Tampa', 14)
insert into Pets values('Cat', 'Naples', 9)
insert into Pets values('Dog', 'Naples', 5)
insert into Pets values('Turtle', 'Naples', 1)
select * from Pets

select Type, Store, sum(Number) as Number
from Pets
group by type, store
with cube

-- this rollup aggregate the first colume group only.
select Type, Store, sum(Number) as Number
from Pets
group by type, store
with rollup

