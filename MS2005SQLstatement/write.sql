create table RoleDetail
(
EmployeeRole varchar(max),
Summary varchar(max)
)
insert into RoleDetail(EmployeeRole, Summary)
values('Reserch','This is a very long non-unicode string')

select * from RoleDetail

update RoleDetail set Summary .Write('n incredibly',9,5)
where EmployeeRole like 'Reserch'

select * from RoleDetail

