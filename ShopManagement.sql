USE [master]
GO
drop database ShopManagement
go

CREATE DATABASE [ShopManagement] 
go
USE [ShopManagement]
go
CREATE TABLE tbl_Users(
userID NVARCHAR(50) NOT NULL PRIMARY KEY,
fullName NVARCHAR(30) NOT NULL,
password NVARCHAR(50) NOT NULL,
roleID NVARCHAR(20) NOT NULL,
status BIT NOT NULL DEFAULT 1,
)

CREATE TABLE tbl_Order(
orderID NVARCHAR(50) NOT NULL PRIMARY KEY,
userID NVARCHAR(50) NOT NULL,
total FLOAT NOT NULL,
date DATE NOT NULL,--YYYY-MM-DD
status BIT NOT NULL DEFAULT 1,
FOREIGN KEY (userID) REFERENCES tbl_Users(userID),
)


CREATE TABLE tbl_Products(
productID NVARCHAR(50) NOT NULL PRIMARY KEY,
name NVARCHAR(50) NOT NULL,
price FLOAT,
quantity INT,
status BIT NOT NULL DEFAULT 1,
)

CREATE TABLE tbl_OrderDetail(
orderID NVARCHAR(50) NOT NULL,
productID NVARCHAR(50) NOT NULL,
price FLOAT,
quantity INT,
status BIT NOT NULL DEFAULT 1,
PRIMARY KEY(orderID,productID),
FOREIGN KEY(orderID) REFERENCES tbl_Order(orderID),
FOREIGN KEY(productID) REFERENCES tbl_Products(productID),
)

go
INSERT [dbo].[tbl_Users] ([userID], [fullName], [password], [roleID], [status]) VALUES (N'admin', N'Toi la admin', N'1', N'AD', 1)
INSERT [dbo].[tbl_Users] ([userID], [fullName], [password], [roleID], [status]) VALUES (N'Hoadnt', N'Hoa Doan', N'1', N'US', 1)
INSERT [dbo].[tbl_Users] ([userID], [fullName], [password], [roleID], [status]) VALUES (N'SE130363', N'Ngo Ha Tri Bao', N'1', N'AD', 1)
INSERT [dbo].[tbl_Users] ([userID], [fullName], [password], [roleID], [status]) VALUES (N'SE140103', N'Phuoc Ha', N'1', N'US', 1)
INSERT [dbo].[tbl_Users] ([userID], [fullName], [password], [roleID], [status]) VALUES (N'SE140119', N'Trai Nguyen', N'1', N'AD', 1)
INSERT [dbo].[tbl_Users] ([userID], [fullName], [password], [roleID], [status]) VALUES (N'SE140130', N'Tam Tran', N'1', N'AD', 1)
INSERT [dbo].[tbl_Users] ([userID], [fullName], [password], [roleID], [status]) VALUES (N'SE140201', N'PHAM HOANG TU', N'1', N'AD', 1)
INSERT [dbo].[tbl_Users] ([userID], [fullName], [password], [roleID], [status]) VALUES (N'SE140969', N'Nguyen Gia Tin', N'123', N'US', 1)
INSERT [dbo].[tbl_Users] ([userID], [fullName], [password], [roleID], [status]) VALUES (N'SE150443', N'LE MINH KHOA', N'1', N'US', 1)
go
INSERT INTO [tbl_Products] (productID, name, price, quantity, status) VALUES (N'PR001',N'Pen', 1.25, 100, 1); 
INSERT INTO [tbl_Products] (productID, name, price, quantity, status) VALUES (N'NTBK01',N'Notebook', 5.99, 50, 1); 
INSERT INTO [tbl_Products] (productID, name, price, quantity, status) VALUES (N'BOKR01',N'Book', 2.50, 25, 1);  
INSERT INTO [tbl_Products] (productID, name, price, quantity, status) VALUES (N'Rul05',N'Ruler', 3.50, 25, 1);  
INSERT INTO [tbl_Products] (productID, name, price, quantity, status) VALUES (N'CAL03',N'Calculator', 20.50, 25, 1);  
go
INSERT INTO tbl_OrderDetail (orderID, productID, price, quantity, status) VALUES (N'OP1',N'PR001', 1.25, 2, 1); -- 2 Pens
INSERT INTO tbl_OrderDetail (orderID, productID, price, quantity, status) VALUES (N'OP2',N'NTBK01', 5.99, 1, 1); -- 1 Notebook
INSERT INTO tbl_OrderDetail (orderID, productID, price, quantity, status) VALUES (N'OP2',N'CAL03', 20.50, 3, 0); -- 3 Cals (out of stock)
INSERT INTO tbl_OrderDetail (orderID, productID, price, quantity, status) VALUES (N'OP3',N'PR001', 1.25, 1, 1); -- 1 Pen
INSERT INTO tbl_OrderDetail (orderID, productID, price, quantity, status) VALUES (N'OP4',N'NTBK01', 5.99, 2, 1); -- 2 Notebooks

select * from  tbl_OrderDetail od
join tbl_Order o  ON o.orderID = od.orderID
join tbl_Users u on o.userID = u.userID
join tbl_Products p ON p.productID = od.productID