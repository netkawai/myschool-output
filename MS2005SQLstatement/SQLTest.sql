use StudyDatabase

create table MobilePhoneList(
  productId int identity(1,1) primary key,
  ModelName varchar(50),
  Brand varchar(50),
  Price money,
  Description varchar(512),
  Design varchar(5),
  ExtMem varchar(200),
  Color1 varchar(50),
  Color2 varchar(50)
)

-- Apple
insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,Description)
values('iPhone 8GB','Apple',27884,'Bar','No','Black','White',
'The Apple iPhone provides its user with the ultimate mobile device which include high quality features & stunning design concept. it is a mobile phone, a highly useable widescreen iPod with touch screen controls & a Internet communications device.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,Description)
values('iPhone 16GB','Apple',34615,'Bar','No','Black','White',
'The Apple iPhone provides its user with the ultimate mobile device which include high quality features & stunning design concept.its is a mobile phone,a highly useable widescreen iPod with touch screen controls & a Internet communications device.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,Description)
values('iPhone 3GS 16GB','Apple',32692,'Bar','No','Black','White',
'The first thing you will notice about iPhone 3GS is how quickly you can launch applications. Web pages render in a fraction of the time, and you can view email attachments faster. Improved performance and updated 3D graphics deliver an incredible gaming experience, too. In fact, everything you do on iPhone 3G S is up to 2x faster and more responsive than iPhone 3G.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,Description)
values('iPhone 3GS 32GB','Apple',39903,'Bar','No','Black','White',
'The first thing you will notice about iPhone 3GS is how quickly you can launch applications. Web pages render in a fraction of the time, and you can view email attachments faster. Improved performance and updated 3D graphics deliver an incredible gaming experience, too. In fact, everything you do on iPhone 3G S is up to 2x faster and more responsive than iPhone 3G.')

select * from MobilePhoneList