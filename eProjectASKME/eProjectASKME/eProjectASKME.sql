-- select with random
DECLARE @counter smallint;
SET @counter = 1;
WHILE @counter < 5
   BEGIN
--      SELECT convert(int,(3*RAND()+1)) Random_Number
      select * from BrandList where BrandId=convert(int,(3*RAND()+1))
      SET @counter = @counter + 1
   END;
GO
declare @totalrecord int
select @totalrecord=count(*) from BrandList
print convert(varchar(5),@totalrecord) 





use aptDatabase

use StudyDatabase

create procedure LatestBrand
as
begin
declare @year int;
set @year = year(getdate());
select * from MobilePhoneList where ReleaseYear=@year;
end

exec LatestBrand

create table BrandList(
BrandId int identity(1,1) primary key,
BrandName varchar(50)
)
insert into BrandList(BrandName) values('Nokia')
insert into BrandList(BrandName) values('Samsung')
insert into BrandList(BrandName) values('Sony Ericsson')
insert into BrandList(BrandName) values('Apple')
insert into BrandList(BrandName) values('LG')
insert into BrandList(BrandName) values('BlackBerry')
insert into BrandList(BrandName) values('Motorola')

select * from BrandList

create procedure getProcBrand
	@main varchar(30) output,
	@sub1 varchar(30) output,
	@sub2 varchar(30) output
as
begin
declare @curTime datetime;
declare @year int;
declare @month int;
declare @totalmonth int;
declare @totalbrand int;
declare @mainbrand int;
declare @subbrand1 int;
declare @subbrand2 int;
select @totalbrand=count(*) from BrandList;
set @curTime=getdate();
set @totalmonth = (year(@curTime)-1900)*12 + (month(@curTime)-1);
set @mainbrand = @totalmonth%@totalbrand+1;
set @subbrand1 = @mainbrand-1;
set @subbrand2 = @mainbrand+1;
if @subbrand1 = 0
  set @subbrand1=@totalbrand;
if @subbrand2 > @totalbrand
  set @subbrand2=1;
select @main=BrandName from BrandList where BrandId=@mainbrand;
select @sub1=BrandName from BrandList where BrandId=@subbrand1;
select @sub2=BrandName from BrandList where BrandId=@subbrand2;
end
-- drop procedure getProcBrand

-- To obtain the 5 Phones Records
create procedure MainBrand
as
begin
declare @main varchar(30);
declare @sub1 varchar(30);
declare @sub2 varchar(30);
exec getProcBrand @main output,@sub1 output,@sub2 output;
select * from MobilePhoneList where Brand=@main;
end

-- To obtain other 1 Phone
create procedure SubBrand1
as
begin
declare @main varchar(30);
declare @sub1 varchar(30);
declare @sub2 varchar(30);
exec getProcBrand @main output,@sub1 output,@sub2 output;
select top 1 * from MobilePhoneList where Brand=@sub1;
end

-- To obtain another 1 Phone
create procedure SubBrand2
as
begin
declare @main varchar(30);
declare @sub1 varchar(30);
declare @sub2 varchar(30);
exec getProcBrand @main output,@sub1 output,@sub2 output;
select top 1 * from MobilePhoneList where Brand=@sub2;
end

create table MobilePhoneList(
  productId int identity(1,1) primary key,
  ModelName varchar(50),
  Brand varchar(50),
  Price money,
  Description varchar(512),
  Design varchar(5),
  ExtMem varchar(200),
  Color1 varchar(50),
  Color2 varchar(50),
  ReleaseYear int
)
drop table MobilePhoneList

--update MobilePhoneList set ReleaseYear=2010 where ModelName='iPhone 4 16G'
--update MobilePhoneList set ReleaseYear=2010 where ModelName='iPhone 3GS 32GB'
--update MobilePhoneList set ReleaseYear=2010 where ModelName='iPhone 3GS 16GB'
--update MobilePhoneList set ReleaseYear=2010 where ModelName='iPhone 3GS 16GB'


select * from MobilePhoneList where Brand='Sony Ericsson'

-- Apple
insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('iPhone 8GB','Apple',27884,'Bar','No','Black','White',2008,
'The Apple iPhone provides its user with the ultimate mobile device which include high quality features & stunning design concept. it is a mobile phone, a highly useable widescreen iPod with touch screen controls & a Internet communications device.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('iPhone 16GB','Apple',34615,'Bar','No','Black','White',2008,
'The Apple iPhone provides its user with the ultimate mobile device which include high quality features & stunning design concept.its is a mobile phone,a highly useable widescreen iPod with touch screen controls & a Internet communications device.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('iPhone 3GS 16GB','Apple',32692,'Bar','No','Black','White',2010,
'The first thing you will notice about iPhone 3GS is how quickly you can launch applications. Web pages render in a fraction of the time, and you can view email attachments faster. Improved performance and updated 3D graphics deliver an incredible gaming experience, too. In fact, everything you do on iPhone 3G S is up to 2x faster and more responsive than iPhone 3G.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('iPhone 3GS 32GB','Apple',39903,'Bar','No','Black','White',2010,
'The first thing you will notice about iPhone 3GS is how quickly you can launch applications. Web pages render in a fraction of the time, and you can view email attachments faster. Improved performance and updated 3D graphics deliver an incredible gaming experience, too. In fact, everything you do on iPhone 3G S is up to 2x faster and more responsive than iPhone 3G.')


insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('iPhone 4 16G','Apple',19999,'Bar','No','Black','White',2010,
'While everyone else was busy trying to keep up with iPhone, we were busy creating amazing new features that make iPhone more powerful, easier to use, and more indispensable than ever. The result is iPhone 4. The biggest thing to happen to iPhone since iPhone.')

-- Nokia
insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('Nokia 1200','Nokia',1201,'Bar','No','Black','Blue',2007,
'The Nokia 1200 mobile phone has been designed as a reliable, affordable and practical communications tool that helps you to get on with your day-to day business with the minimum of fuss.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('Nokia 1202C','Nokia',1048,'Bar','No','Midnight black','Violet blue',2007,
'A slim, durable, and user-friendly mobile device that helps you stay in touch with your friends and family throughout the day.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('Nokia 1203','Nokia',1048,'Bar','No','Sliver Grey','No',2008,
'Nokia 1203 is a durable and user-friendly handset that helps you stay in touch with your friends and family.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('Nokia 1208','Nokia',1442,'Bar','No','Black','Red',2009,
'The Nokia 1208 is a small candy-bar style phone. Affordable and easy-to-use, with handy One Touch shortcut keys, unique cost management features, and a vibrant color display screen to make your connections hassle-free.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('Nokia 1209','Nokia',1201,'Bar','No','Black','No',2010,
'With a premium designer body of durable material an antislip backing and the ability to display more colors onscreen the Nokia 1209 is a stylish affordable package of simple but practical features')

-- Sony Ericsson
insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('Sony Ericsson Anio','Sony Ericsson',19230 ,'Slide','microSD','Luminous White', 'Obsidian Black',2007,
'Sony Ericsson Aino is the touchscreen & numeric keypad feature phone and its key points are Remote Play with PLAYSTATION 3l and the PlayTV service support. It also sports an 8-megapixel camera, 3"" touchscreen with 16 mln colors and a resolution of 240x432 pixels. In addition, Sony Ericsson Aino has Wi-Fi, A-GPS, 3G support and Stereo Bluetooth.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('Sony Ericsson C510','Sony Ericsson',7596,'Bar','Memory Stick Micro','Future Black','Radiation Silver',2007,
'Sony Ericsson C510 is a 3.2-megapixel cameraphone. It is a quad-band GSM with HSPA support and features 262k color TFT display, Stereo Bluetooth, M2 slot for memory and FM radio.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('Sony Ericsson C702','Sony Ericsson',14288,'Bar','Memory Stick Micro (M2)','Antique Copper', 'Steel Black',2007,
'Sony Ericsson C702 is a 3-megapixel cameraphone with GPS and splash-proofed housing. It is a quad-band GSM with HSDPA support and features 262k color TFT display, Stereo Bluetooth, M2 slot for memory and FM radio.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('Sony Ericsson C902','Sony Ericsson',17740,'Bar','Memory Stick Micro (M2)','Luscious Red', 'Titanium Silver',2009,
'The C902 Cyber-shot comes with a 160MB built-in memory - the equivalent of storage for up to 100 full resolution photos - plus the possibility to add even more memory with the Memory Stick Micro (M2) that can be bundled with the phone depending on the market.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('Sony Ericsson C903','Sony Ericsson',9615,'Slide','Memory Stick Micro (M2)','Lacquer Black', 'Techno White',2010,
'Sony Ericsson C903 is a slider cameraphone with 5-megapixel camera with photo flash and Smile Shutter. It is quad-band GSM with HSPA support, features 262k color TFT display, Stereo Bluetooth, A-GPS, M2 slot for memory and FM radio')

-- Blackberry
insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('BlackBerry 7100G','BlackBerry',10230,'Bar','No','Sliver','No',2008,
'Blackberry 7100g is a quad-band GSM phone. It features 65k LCD display, full QWERTY keyboard, Bluetooth, IMAP/POP3 e-mail client, 32 MB flash memory, 4 MB SRAM, Java support and built-in speakerphone.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('BlackBerry 7130G','BlackBerry',13874,'Bar','No','Sliver','No',2009,
'The 7130G is a quad-band GSM part of the 7100 series phones with 240x260 pixels display and SureType keyboard. It has high-speed EDGE data and runs on 312MHz Intel processor')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('BlackBerry 7290','BlackBerry',17807,'Bar','No','Cosmos Black', 'Satin Blue',2007,
'The BlackBerry 7290 looks like a more traditional handheld-style BlackBerry device than its slimmer cousin.BlackBerry 7290 is a simple and sleek interpretation.And its a smaller side, Styled and metallic blue.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('BlackBerry 8110 pearl','BlackBerry',22836,'Bar','microSD','Black','Blue',2008,
'The BlackBerry® Pearl 8110 smartphone is designed to help you do everything you want with your life1. It comes complete with advanced phone features, multimedia, digital camera, video recording, built-in GPS1 and expandable memory.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('BlackBerry 8120 pearl','BlackBerry',11538,'Bar','microSD','Titanium', 'Blue',2010,
'The BlackBerry® Pearl 8120 smartphone is designed to help you do everything you want with your life. It comes complete with advanced phone features, multimedia, digital camera, video recording, Wi-Fi capabilities* and expandable memory.')

-- Samsung
insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('Samsung B100','Samsung',1432,'Bar','No','Black','No',2006,
'The B100 is an incredible looking handset, totally unique and, in our spot poll, a real object of lust for both sexes of all ages. it''s compact, while not featherweight. It''s shorter and narrower than one would expect, and thicker, too.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('Samsung B100i','Samsung',1413,'Bar','No','Black','No',2007,
'Bar type form factor offers a hassle-free no nonsense style that is slim and compact enough to be portable,yet also offers a great grip for easy manageability.Nicely compact dimensions of 104x44x16.3mm fits perfectly in hand.Advanced Mobile Tracker.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('Samsung B130','Samsung',1461,'Bar','No','Black','No',2008,
'The Samsung B130''s bar-type form factor offers a hassle-free no-nonsense style that is slim and compact enough to be portable, yet also offers a great grip for easy manageability. It''s nicely compact dimensions.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('Samsung B200','Samsung',1961,'Bar','No','Black','No',2009,
'Samsung B200 measures 104 x 44.5 x 16 millimeters, weighs about 80 grams and comes in a classic candybar form factor. The phone features a 1.5 inch CSTN display with 128 x 128 pixels and 65K colors')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('Samsung B210','Samsung',1923,'Bar','No','Black','No',2009,
'Consumers will appreciate both the design of this highly coveted bar form and its usability. Small to hold and comfortable to grip, the Guru 210 is ideal for users who want unobtrusive handset who?ll enjoy its compactness and simplicity.')

-- LG
insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('LG 3600','LG',1600,'Bar','No','Black','No',2008,
'FM Radio and FM as alarm, 65000 color display, 32 polyphonic ringtone, Reliance Mobile World, Speaker, Hindi user interface and Hindi SMS')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('LG 5600','LG',3038,'Bar','No','Black','No',2008,
'Built in games (no.) 1 - Space Ball ,Built in games (no.) 1 - Space Ball ,Built in games (no.) 1 - Space Ball , Voice Memo 20 secs WAP 2')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('LG B2150','LG',2663,'Bar','No','Black','No',2009,
'This is a middle class model with FM-tuner, a usual screen and characteristics typical of LG. It shows neither peculiarities nor differences from LG B2100.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('LG B2000','LG',2163,'Bar','No','Black','No',2008,
'This phone is simple, light weight and the features are all very convenient to someone who just need a simple but at the same time flushy way to communicate. Other aspect include GPRS function, SMS/EMS/MMS, FM radio.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('LG B2050','LG',1874 ,'Bar','No','Black','No',2008,
'The ultra thin, strong and lightweight design makes the LG B2050 easily portable, no matter what the occasion. It has a high resolution 64k colour screen and is set up (MMS enabled) for picture messaging, so it''s easy to send and receive images.')

-- Motorola
insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('Motorola F3','Motorola',30000,'Bar','No','Black','No',2007,
'Motorola MILESTONE XT720 is an Android 2.1 smartphone, ready to take great images with its 8MP camera with Xenon flash. This really looks to be the most camera-centric Android handset to date, especially when you throw 720p HD video recording into the deal. Other than that, the Motorola MILESTONE XT720 seems to be a very good looking handset with characteristic design, large 3.7-inch, 480x854 resolution capacitive screen, HDMI interface, 3.5mm jack, and all other kinds of stuff.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('Motorola A1200','Motorola',9855,'Bar','No','Black','No',2009,
'Motorola A1200 is a QVGA colour touch display phone with a 2 megapixel camera. This linux operating GSM phone has a transparent front cover. The internal memory is extended through microSD memory cards, which can store music in various formats.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('Motorola A1600','Motorola',13942,'Bar','No','Black','No',2008,
'This bugger will sport quad-band GSM connectivity, a 3.2-megapixel camera (with autofocus), WiFi, assisted-GPS, a couple of built-in games, a ""talking dictionary"" and a Linux-based OS')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('Motorola A810','Motorola',4327,'Bar','No','Black','No',2009,
'With a large touch screen display and Motorola''s advanced handwriting recognition, it''s easy to communicate whether you are sending or receiving SMS or email.Text entry is as easy as using the stylus to write directly on the 2.2? interactive screen.')

insert into MobilePhoneList(ModelName,Brand,Price,Design,ExtMem,Color1,Color2,ReleaseYear,Description)
values('Motorola Aura','Motorola',100962,'Bar','No','Black','No',2010,
'Motorola AURA is a luxury handset that not only looks unique, but is manufactured uniquely as well - with high-end materials.It has anodized aluminum buttons, stainless steel with chemically etched textures, grade 1 sapphire crystal over the display.')


select * from MobilePhoneList


update MobilePhoneList set ExtMem='No'
update MobilePhoneList set Color1='Black'
update MobilePhoneList set ReleaseYear=2009
