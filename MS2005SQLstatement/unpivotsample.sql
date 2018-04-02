use aptDatabase
if object_id('dbo.Teams', 'U') is not null 
	drop table dbo.Teams
go
create table Teams (TeamName char(10), Player1 int, Player2 int, Player3 int, Player4 int)
go
insert into Teams values ('Manchester', 4, 10, 12, 15)
insert into Teams values ('Bolton', 5, 6, 11, 16)
insert into Teams values ('Liverpool', 2, 4, 5, 16)
go
select TeamName, Player, Goals
from
	-- The blow statement is sub-statement.This statement executes at the first.
	(select TeamName, Player1, Player2, Player3, Player4 from Teams)
	unpivot (Goals for Player in
				(Player1, Player2, Player3, Player4)
)as unpvt
go