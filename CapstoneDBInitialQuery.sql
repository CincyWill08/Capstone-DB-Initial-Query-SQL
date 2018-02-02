use master
go
drop database if exists PRSTEST
go
create database PRSTEST
go
use PRSTEST
go

drop table if exists [User]
drop table if exists Vendor
drop table if exists Product
drop table if exists PurchaseRequest
drop table if exists PurchaseRequestLineItems

create table [User] (
	Id int not null primary key identity(1,1),
	UserName nvarchar(30) not null unique,
	Password nvarchar(30) not null,
	FirstName nvarchar(30) not null,
	LastName nvarchar(30) not null,
	Phone nvarchar(12),
	Email nvarchar(80),
	IsReviewer bit not null default 0,
	IsAdmin bit not null default 0,
	Active bit not null default 1 
	);

Insert into [User] (UserName, Password, FirstName, LastName, Phone, Email, IsReviewer, IsAdmin)
values ('willrob0804', 'askjasei', 'Michael', 'Robinson', '859-750-1038', 'willrob08@msn.com', 1, 1);
Insert into [User] (UserName, Password, FirstName, LastName, Phone, Email, IsReviewer, IsAdmin)
values ('rgreen1968', 'dkdkdkdross', 'Rachel', 'Green', '555-555-1111', 'rgreen@gmail.com', 0, 0);
Insert into [User] (UserName, Password, FirstName, LastName, Email, IsReviewer, IsAdmin)
values ('cbing2003', 'dfetffhrehjk', 'Chandler', 'Bing', 'cbingh@gmail.com', 1, 0);
Insert into [User] (UserName, Password, FirstName, LastName, Phone, IsReviewer, IsAdmin)
values ('mgellar2004', 'dfhjkju668k', 'Monica', 'Gellar', '555-555-5555', 0, 1);

select * from [User]

create table Vendor (
	Id int not null primary key identity(1,1),
	Code nvarchar(10) not null unique,
	Name nvarchar(30) not null,
	Address nvarchar(30) not null,
	City nvarchar(30) not null,
	State nvarchar(2) not null,
	Zip nvarchar(10) not null,
	Phone nvarchar(12),
	Email nvarchar(80),
	IsRecommended bit not null default 0,
	Active bit not null default 1
	);

Insert into Vendor (Code, Name, Address, City, State, Zip, Phone, Email, IsRecommended, Active)
values ('aaaaa11111', 'Amazon', '3434 Amazon Way', 'Seattle', 'WA', '55555', '555-555-5555', 'amazon@amazon.com', 1, 1);
Insert into Vendor (Code, Name, Address, City, State, Zip, Phone, Email, IsRecommended, Active)
values ('trg2222', 'Target', '1212 Target Blvd', 'Minneapolis', 'MN', '22222', '555-555-2222', 'target@target.com', 1, 1);
Insert into Vendor (Code, Name, Address, City, State, Zip, Phone, Email, IsRecommended, Active)
values ('sears3333', 'Sears', '4545 Sears Way', 'El Centro', 'CA', '99999', '555-555-9999', 'sears@sears.com', 0, 1);
Insert into Vendor (Code, Name, Address, City, State, Zip, IsRecommended, Active)
values ('blockb4444', 'Blockbuster', '888 Defunct St', 'New York', 'NY', '88888', 0, 0);

select * from Vendor;

create table Product (
	Id int not null primary key identity(1,1),
	Name nvarchar(130) not null,
	VendorPartNumber nvarchar(50) not null,
	Price decimal(14,2) not null default 0,
	Unit nvarchar(10) not null,
	PhotoPath nvarchar(255),
	VendorId int not null foreign key references Vendor,
	Active bit not null default 1
	);

Insert into Product (Name, VendorPartNumber, Price, Unit, PhotoPath, VendorId)
values ('Echo', 'E338OFGIJGSR8JS', 150.00, 'One', 'http://amazon.com/photo.jpg', 1)
Insert into Product (Name, VendorPartNumber, Price, Unit, VendorId)
values ('Pencils', 'PEN0JLKEJSJFOE', 0.25, 'Individual', 2)
Insert into Product (Name, VendorPartNumber, Price, Unit, VendorId)
values ('Paper', 'PPRJ909JD', 25.00, 'Box', 3)

select * from Product;

create table PurchaseRequest (
	Id int not null primary key identity(1,1),
	Description nvarchar(80) not null,
	Justification nvarchar(255),
	DateNeeded date not null default (getdate() + 7),
	DeliveryMode nvarchar(25),
	Status nvarchar(10) not null default 'NEW',
	Total decimal(14,2) not null default 0.0,
	UserId int not null foreign key references [User],
	Active bit not null default 1
	)

insert into PurchaseRequest (Description, Justification, DeliveryMode, Status, Total, UserId)
values ('Initial Purchase', 'Business start up', 'Mail', 'CLOSED', 10000.00, 1)
insert into PurchaseRequest (Description, Justification, DateNeeded, Status, Total, UserId)
values ('2nd Purchase', 'Addl Supplies', '2017-12-31', 'CLOSED', 5000.00, 2)
insert into PurchaseRequest (Description, Justification, DeliveryMode, Status, Total, UserId)
values ('Third Purchase', 'Re-Stock', 'Mail', 'CLOSED', 25.00, 3)
insert into PurchaseRequest (Description, DeliveryMode, Total, UserId)
values ('4th Purchase', 'Mail', 200.00, 4)
insert into PurchaseRequest (Description,  UserId)
values ('Future Purchase', 4)

select * from PurchaseRequest;

create table PurchaseRequestLineItems (
	Id int not null primary key identity(1,1),
	PurchaseRequestId int not null foreign key references [PurchaseRequest],
	ProductId int not null foreign key references [Product],
	Quantity int not null default 1
	)

insert into PurchaseRequestLineItems (PurchaseRequestId, ProductId, Quantity)
values (1,1,25)
insert into PurchaseRequestLineItems (PurchaseRequestId, ProductId, Quantity)
values (1,2,25)
insert into PurchaseRequestLineItems (PurchaseRequestId, ProductId, Quantity)
values (1,3,25)

select * from PurchaseRequestLineItems;