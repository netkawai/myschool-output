select * from Person.Address
select * from Person.AddressType

sp_helptext 'Person.Address'

select * from HumanResources.EmployeeAddress
select * from HumanResources.Employee

sp_helptext 'HumanResources.vEmployee'
select * from HumanResources.vEmployee

sp_helptext 'dbo.uspGetManagerEmployees'

sp_helptext 'HumanResources.uspUpdateEmployeeLogin'

sp_helptext 'HumanResources.vJobCandidate'
sp_helptext 'HumanResources.vJobCandidateEducation'

select * from HumanResources.vJobCandidate
select * from HumanResources.vJobCandidateEducation

select * from HumanResources.JobCandidate


--Important 
--This feature(sp_depends) will be removed in a future version of Microsoft SQL Server. 
--Avoid using this feature in new development work, and plan to modify applications that currently use this feature. 
--Use sys.dm_sql_referencing_entities and sys.dm_sql_referenced_entities instead.
 
