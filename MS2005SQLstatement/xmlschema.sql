use LocalDatabase

-- create xml schema
create xml schema collection CricketSchemaCollection
as N'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <xsd:element name="MatchDetails">
    <xsd:complexType>
      <xsd:complexContent>
        <xsd:restriction base="xsd:anyType">
          <xsd:sequence>
            <xsd:element name="Team" minOccurs="0" maxOccurs="unbounded">
              <xsd:complexType>
                <xsd:complexContent>
                  <xsd:restriction base="xsd:anyType">
                    <xsd:sequence />
                    <xsd:attribute name="country" type="xsd:string" />                    		
					<xsd:attribute name="score" type="xsd:string"/>
                  </xsd:restriction>
                </xsd:complexContent>
              </xsd:complexType>
            </xsd:element>
          </xsd:sequence>
        </xsd:restriction>
      </xsd:complexContent>
    </xsd:complexType>
  </xsd:element>
</xsd:schema>'


if object_id('CricketPlayer','U') is not null
  drop table CricketPlayer
go
create table CricketPlayer(
  PlayerName varchar(15), 
  PlayerSalary money, 
  CallDetails xml, /* xml */
  RecordInfo xml(CricketSchemaCollection)); /* constraint xml with xml schema */
-- inset new data
insert into CricketPlayer(PlayerName,PlayerSalary,CallDetails) values(
'Alan',4500,
'<Info><Call>Local</Call><Time>45 minutes</Time><Charges>200</Charges></Info>');
insert into CricketPlayer(PlayerName,PlayerSalary,CallDetails) values(
'Jack',3500,
'<Info><Call>Local</Call><Time>35 minutes</Time><Charges>100</Charges></Info>');
insert into CricketPlayer(PlayerName,PlayerSalary,CallDetails) values(
'Thomas',100,
'<Info><Call>Global</Call><Time>10 minutes</Time><Charges>150</Charges></Info>');

select PlayerName, CallDetails from CricketPlayer

update CricketPlayer set RecordInfo='<MatchDetails><Team country="Australia" score="355"></Team>
<Team country="Zimbabwe" score="200"></Team>
<Team country="England" score="475"></Team></MatchDetails>'
where PlayerName = 'Alan'
update CricketPlayer set RecordInfo='<MatchDetails><Team country="USA" score="155"></Team>
<Team country="French" score="300"></Team>
<Team country="Germany" score="100"></Team></MatchDetails>'
where PlayerName = 'Jack'
select PlayerName, RecordInfo from CricketPlayer
-- the below command causes error
update CricketPlayer set RecordInfo='<MatchDetails><Team winner="USA"></Team>
<Team winner="French"></Team>
<Team winner="Germany"></Team></MatchDetails>'
where PlayerName = 'Thomas'

select * from CricketPlayer

-- XQuery
select PlayerName,CallDetails.query('/Info/Time') as CallTime 
  from CricketPlayer where CallDetails.exist('(/Info/Time)') = 1;

select PlayerName,RecordInfo.query('/MatchDetails/Team') as Info 
  from CricketPlayer where RecordInfo.exist('(/MatchDetails/Team)') = 1;
