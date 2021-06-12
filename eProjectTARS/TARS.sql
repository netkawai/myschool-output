
-- EmployeeTable
create table EMPLOYEE(
EMPLOYEE_ID int not null identity(1,1) primary key,
[NAME]   char(32),
PASSWORD char(32)
)
drop table EMPLOYEE

select * from EMPLOYEE

insert into EMPLOYEE([NAME],PASSWORD) values('Johne','123')
insert into EMPLOYEE([NAME],PASSWORD) values('Thomas','456')

select * from EMPLOYEE

create xml schema collection ServiceCollection
as N'<xs:schema version="1.0"
	 targetNamespace="http://xml.tars.net/service"
     xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xs:element name="ServiceType">
	  <xs:simpleType>
		<xs:restriction base="xs:string">
		  <xs:enumeration value="NormalPost"/>
		  <xs:enumeration value="SpeedPost"/>
		</xs:restriction>
	  </xs:simpleType>
  </xs:element>
</xs:schema>'


create table POST_COST(
COST_ID int not null identity(1,1) primary key,
WEIGHT char(6) not null,
--SERVICE_TYPE xml(ServiceCollection) not null,
SERVICE_TYPE char(10) not null,
COST money not null)


-- insert into POST_COST(WEIGHT,SERVICE_NAME,COST) values('50g', '<ServiceType xmlns="http://xml.tars.net/service">NormalPost</ServiceType>', 100)
insert into POST_COST(WEIGHT,SERVICE_TYPE,COST) values('250', 'normal', 100)
insert into POST_COST(WEIGHT,SERVICE_TYPE,COST) values('500', 'normal', 200)
insert into POST_COST(WEIGHT,SERVICE_TYPE,COST) values('1000', 'normal', 400)
insert into POST_COST(WEIGHT,SERVICE_TYPE,COST) values('250', 'speed', 300)
insert into POST_COST(WEIGHT,SERVICE_TYPE,COST) values('500', 'speed', 500)
insert into POST_COST(WEIGHT,SERVICE_TYPE,COST) values('1000', 'speed', 700)

select * from POST_COST
drop table POST_COST

create xml schema collection TrackingCollection
as N'<xs:schema version="1.0"
     targetNamespace="http://xml.tars.net/tracking"
     xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xs:element name="trackings">
		<xs:complexType>
			<xs:sequence>
				<xs:element name="tracking" maxOccurs="unbounded">
					<xs:complexType>
						<xs:sequence>
							<xs:element name="date"    type="xs:date"/>
							<xs:element name="address" type="xs:string"/>
							<xs:element name="receiver" type="xs:string"/>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
			</xs:sequence>
		</xs:complexType>
	</xs:element>
</xs:schema>'

create table POST_ORDER(
EMPLOYEE_ID int constraint FK_EMPLOYEE_ID foreign key references EMPLOYEE(EMPLOYEE_ID),
ORDER_NUM   int not null identity primary key,
CUSTOMER_CONTACT char(12),
SRC_ADDR    varchar(64),
DST_ADDR	varchar(64),
QUANTITY    int,
TRACKING    xml(TrackingCollection),
COST_ID     int constraint FK_COST_ID foreign key references POST_COST(COST_ID))

drop table POST_ORDER

insert into POST_ORDER(EMPLOYEE_ID, CUSTOMER_CONTACT,SRC_ADDR,DST_ADDR,QUANTITY,TRACKING,COST_ID) 
values(1,'123-456','Bangalore','Delhi',3,'<ns:trackings xmlns:ns="http://xml.tars.net/tracking"><tracking><date>2010-10-03Z</date><address>Bangalore</address><receiver>John</receiver></tracking></ns:trackings>',1)

select * from POST_ORDER

delete from POST_ORDER where ORDER_NUM = 1
