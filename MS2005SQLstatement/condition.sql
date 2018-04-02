use LocalDatabase



select Empname from Employee where Empcode between [102] and [103]

-- if colume name is the same with keyword and contains a space, you should use [ ].
select empsalaray*0.1 as [Employee bonus] from employee

select deptno,sum(empsalary) from employee group by depno
select deptno,sum(empsalary) from employee where empsalary>2000 group by deptno
select deptno,sum(empsalary) from employee where empsalary>2000 group by deptno having sum(empsalary)  >= 10000


select * from employee where empname in ('Mames','Jacks')
select * from employee where empname like 'Ja%'

