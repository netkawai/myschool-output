--use BookLibrary
--go
use LocalDatabase
-- define BookType as varchar(40) not null
create type BookType From varchar(40) not null;
go
-- create table Book
if object_id 'dbo.Book' is not null
  drop table Book;
go
create table Book(
BookCode int identity primary key,
BookTitle BookType, Author usertype, Edition int,
BookPrice money, Copies int);
go
-- create table Member
if object_id 'dbo.Member' is not null
  drop table Member;
go
create table Member(
MemberCode int identity primary key, Name BookType,
Address usertype, PhoneNumber int);
go
-- create table IssueDetails
if object_id 'dbo.IssueDetails' is not null
  drop table IssueDetails;
go
create table IssueDetails(
BookCode int foreign key references Book(BookCode),
MemberCode int foreign key references Member(MemberCode),
IssueData datetime, 
ReturnDate datetime);
go
-- insert data


