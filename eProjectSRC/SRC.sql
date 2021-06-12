--create database SRC

-- City

create table tCity(
cID int not null identity primary key,
cName char(64),
cZone int
)

insert into tCity(cName,cZone) values('Bangalore','1')
insert into tCity(cName,cZone) values('Channai','1')
insert into tCity(cName,cZone) values('New Delhi','2')



-- Bus

--create table tBus(
--bID int not null identity primary key,
--bName char(64),
--bType char(64),
--bSeat int,
--From_cID int constraint FK_From_cID foreign key references tCity(cID),
--To_cID int constraint FK_To_cID foreign key references tCity(cID),
--)

--insert into tBus(bName,bType,bSeat,From_cID,To_cID) values('SH002','Express',100,1,2)
--insert into tBus(bName,bType,bSeat,From_cID,To_cID) values('NH029','Volvo non A/C',100,2,3)

create table tBus(
bID int not null identity primary key,
bName char(64),
bType int constraint FK_From_tID foreign key references tType(tID),
bSeat int,
bDepart smalldatetime,
From_cID int constraint FK_From_cID foreign key references tCity(cID),
To_cID int constraint FK_To_cID foreign key references tCity(cID),
)


insert into tBus(bName,bType,bSeat,bDepart,From_cID,To_cID) values('SH002',1,100,'1990-1-1 10:30',1,2)
insert into tBus(bName,bType,bSeat,bDepart,From_cID,To_cID) values('NH029',3,100,'1990-1-1 14:15',2,3)

create table tType(
tID int not null identity primary key,
tName char(64)
)

insert into tType(tName) values('Express');
insert into tType(tName) values('Luxury');
insert into tType(tName) values('Volvo non A/C');
insert into tType(tName) values('Volvo A/C');


-- Employee

create table tEmployee(
eID int not null identity primary key,
eName char(64),
eContact char(64),
ePassword char (32)
)



insert into tEmployee(eName,eContact,ePassword) values('Johne', 'johne@src.co.in', '123')
insert into tEmployee(eName,eContact,ePassword) values('Thomas','thomas@src.co.in', '456')

-- Book

create table tBook(
refID int not null primary key,
bID int constraint FK_bID foreign key references tBus(bID),
eID int constraint FK_eID foreign key references tEmployee(eID),
cName char(64),
cAge int,
depDate datetime,
)



insert into tBook(refID, bID, eID, cName, cAge, depDate)  values(298798, 1, 1, 'Tom', 31, '2010-09-11')
insert into tBook(refID, bID, eID, cName, cAge, depDate)  values(849871, 1, 1, 'Sum', 5, '2010-09-10')
insert into tBook(refID, bID, eID, cName, cAge, depDate)  values(874977, 2, 2, 'Mari', 35, '2010-09-09')

select * from tBook
select * from tEmployee
select * from tCity
select * from tBus


--drop table tCity
--drop table tBook
---drop table tEmployee
