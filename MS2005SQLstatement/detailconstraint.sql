create table Account_Transactions
(
	TransID	int NOT NULL,
	EmpID	int NOT NULL,
	CustID	varchar(5) NOT NULL,
	TransTypeID int NOT NULL,
	TransDate datetime NOT NULL,
	TransNumber varchar(5) NOT NULL,
	Deposit money NULL,
	Withdrawal money NULL,
constraint PK_Account_Transaction primary key(TransID, CustID)
)

create table Account_Types
(
	AccTypeID int primary key,
	AccNo int NOT NULL
constraint check (AccNo between 1 and 9999),
)

create table Customers_Details
(
	CustID varchar(5) primary key,
	AccNo	int NOT NULL,
	AccTypeID int NOT NULL
constraint FK_AccTypeID foreign key references Account_Type(AccTypeID),
	AccName		varchar(50) NOT NULL,
	DateOfBirth datetime NULL,
	Email		varchar(50) NULL,
	Address		varchar(50) NOT NULL
)

alter table department add constraint pk_deptno primary key (deptno)

-- Primary key is createed by combination two more than columns.
alter table department add constraint pk_deptno_name primary key (deptno,deptname)

