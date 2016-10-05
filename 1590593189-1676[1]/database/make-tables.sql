if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Products_Categories]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Products] DROP CONSTRAINT FK_Products_Categories
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_CustomerCustomerDemo]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[CustomerCustomerDemo] DROP CONSTRAINT FK_CustomerCustomerDemo
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_CustomerCustomerDemo_Customers]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[CustomerCustomerDemo] DROP CONSTRAINT FK_CustomerCustomerDemo_Customers
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Orders_Customers]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT FK_Orders_Customers
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Employees_Employees]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Employees] DROP CONSTRAINT FK_Employees_Employees
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_EmployeeTerritories_Employees]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[EmployeeTerritories] DROP CONSTRAINT FK_EmployeeTerritories_Employees
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Orders_Employees]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT FK_Orders_Employees
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Order_Details_Orders]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Order Details] DROP CONSTRAINT FK_Order_Details_Orders
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Order_Details_Products]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Order Details] DROP CONSTRAINT FK_Order_Details_Products
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Territories_Region]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Territories] DROP CONSTRAINT FK_Territories_Region
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Orders_Shippers]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT FK_Orders_Shippers
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Products_Suppliers]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Products] DROP CONSTRAINT FK_Products_Suppliers
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_EmployeeTerritories_Territories]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[EmployeeTerritories] DROP CONSTRAINT FK_EmployeeTerritories_Territories
GO

/****** Object:  Stored Procedure dbo.AllProductsList    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AllProductsList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AllProductsList]
GO

/****** Object:  Stored Procedure dbo.AllShippersList    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AllShippersList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AllShippersList]
GO

/****** Object:  Stored Procedure dbo.DeleteExistingOrder    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeleteExistingOrder]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeleteExistingOrder]
GO

/****** Object:  Stored Procedure dbo.DeleteExistingOrderLine    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeleteExistingOrderLine]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeleteExistingOrderLine]
GO

/****** Object:  Stored Procedure dbo.GetCustomerListByIdOrName    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetCustomerListByIdOrName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetCustomerListByIdOrName]
GO

/****** Object:  Stored Procedure dbo.GetOrderByOrderID    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetOrderByOrderID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetOrderByOrderID]
GO

/****** Object:  Stored Procedure dbo.GetOrderLinesByCustomer    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetOrderLinesByCustomer]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetOrderLinesByCustomer]
GO

/****** Object:  Stored Procedure dbo.GetOrderLinesByOrderID    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetOrderLinesByOrderID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetOrderLinesByOrderID]
GO

/****** Object:  Stored Procedure dbo.GetOrdersByCustomer    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetOrdersByCustomer]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetOrdersByCustomer]
GO

/****** Object:  Stored Procedure dbo.GetSupplierList    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetSupplierList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetSupplierList]
GO

/****** Object:  Stored Procedure dbo.GetSupplierName    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetSupplierName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetSupplierName]
GO

/****** Object:  Stored Procedure dbo.GetSupplierXml    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetSupplierXml]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetSupplierXml]
GO

/****** Object:  Stored Procedure dbo.InsertNewOrder    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[InsertNewOrder]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[InsertNewOrder]
GO

/****** Object:  Stored Procedure dbo.InsertNewOrderLine    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[InsertNewOrderLine]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[InsertNewOrderLine]
GO

/****** Object:  Stored Procedure dbo.OrderLinesDelete    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OrderLinesDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[OrderLinesDelete]
GO

/****** Object:  Stored Procedure dbo.OrderLinesForEditByCustID    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OrderLinesForEditByCustID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[OrderLinesForEditByCustID]
GO

/****** Object:  Stored Procedure dbo.OrderLinesForEditByOrderID    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OrderLinesForEditByOrderID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[OrderLinesForEditByOrderID]
GO

/****** Object:  Stored Procedure dbo.OrderLinesInsert    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OrderLinesInsert]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[OrderLinesInsert]
GO

/****** Object:  Stored Procedure dbo.OrderLinesUnderlyingValuesByOrderID    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OrderLinesUnderlyingValuesByOrderID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[OrderLinesUnderlyingValuesByOrderID]
GO

/****** Object:  Stored Procedure dbo.OrderLinesUpdate    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OrderLinesUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[OrderLinesUpdate]
GO

/****** Object:  Stored Procedure dbo.OrderUnderlyingValuesByOrderID    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OrderUnderlyingValuesByOrderID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[OrderUnderlyingValuesByOrderID]
GO

/****** Object:  Stored Procedure dbo.OrdersDelete    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OrdersDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[OrdersDelete]
GO

/****** Object:  Stored Procedure dbo.OrdersForEditByCustID    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OrdersForEditByCustID]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[OrdersForEditByCustID]
GO

/****** Object:  Stored Procedure dbo.OrdersInsert    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OrdersInsert]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[OrdersInsert]
GO

/****** Object:  Stored Procedure dbo.OrdersUpdate    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OrdersUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[OrdersUpdate]
GO

/****** Object:  Stored Procedure dbo.SetFreightCost    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SetFreightCost]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SetFreightCost]
GO

/****** Object:  Stored Procedure dbo.UpdateExistingOrder    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateExistingOrder]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[UpdateExistingOrder]
GO

/****** Object:  Stored Procedure dbo.UpdateExistingOrderLine    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateExistingOrderLine]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[UpdateExistingOrderLine]
GO

/****** Object:  Table [dbo].[Categories]    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Categories]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Categories]
GO

/****** Object:  Table [dbo].[CustomerCustomerDemo]    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CustomerCustomerDemo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CustomerCustomerDemo]
GO

/****** Object:  Table [dbo].[CustomerDemographics]    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CustomerDemographics]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CustomerDemographics]
GO

/****** Object:  Table [dbo].[Customers]    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Customers]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Customers]
GO

/****** Object:  Table [dbo].[EmployeeTerritories]    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[EmployeeTerritories]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[EmployeeTerritories]
GO

/****** Object:  Table [dbo].[Employees]    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Employees]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Employees]
GO

/****** Object:  Table [dbo].[Order Details]    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Order Details]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Order Details]
GO

/****** Object:  Table [dbo].[Orders]    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Orders]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Orders]
GO

/****** Object:  Table [dbo].[Products]    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Products]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Products]
GO

/****** Object:  Table [dbo].[Region]    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Region]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Region]
GO

/****** Object:  Table [dbo].[Shippers]    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Shippers]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Shippers]
GO

/****** Object:  Table [dbo].[Suppliers]    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Suppliers]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Suppliers]
GO

/****** Object:  Table [dbo].[Territories]    Script Date: 09/12/2001 17:18:32 ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Territories]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Territories]
GO

/****** Object:  Login anon    Script Date: 09/12/2001 17:18:30 ******/
if not exists (select * from master.dbo.syslogins where loginname = N'anon')
BEGIN
  declare @logindb nvarchar(132), @loginlang nvarchar(132) select @logindb = N'Northwind', @loginlang = N'us_english'
  if @logindb is null or not exists (select * from master.dbo.sysdatabases where name = @logindb)
    select @logindb = N'master'
  if @loginlang is null or (not exists (select * from master.dbo.syslanguages where name = @loginlang) and @loginlang <> N'us_english')
    select @loginlang = @@language
  exec sp_addlogin N'anon', null, @logindb, @loginlang
END
GO

/****** Object:  User anon    Script Date: 09/12/2001 17:18:30 ******/
if not exists (select * from dbo.sysusers where name = N'anon' and uid < 16382)
  EXEC sp_grantdbaccess N'anon', N'anon'
GO

/****** Object:  Table [dbo].[Categories]    Script Date: 09/12/2001 17:18:34 ******/
CREATE TABLE [dbo].[Categories] (
  [CategoryID] [int] IDENTITY (1, 1) NOT NULL ,
  [CategoryName] [nvarchar] (15) NOT NULL ,
  [Description] [ntext] NULL ,
  [Picture] [image] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[CustomerCustomerDemo]    Script Date: 09/12/2001 17:18:34 ******/
CREATE TABLE [dbo].[CustomerCustomerDemo] (
  [CustomerID] [nchar] (5) NOT NULL ,
  [CustomerTypeID] [nchar] (10) NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[CustomerDemographics]    Script Date: 09/12/2001 17:18:34 ******/
CREATE TABLE [dbo].[CustomerDemographics] (
  [CustomerTypeID] [nchar] (10) NOT NULL ,
  [CustomerDesc] [ntext] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Customers]    Script Date: 09/12/2001 17:18:34 ******/
CREATE TABLE [dbo].[Customers] (
  [CustomerID] [nchar] (5) NOT NULL ,
  [CompanyName] [nvarchar] (40) NOT NULL ,
  [ContactName] [nvarchar] (30) NULL ,
  [ContactTitle] [nvarchar] (30) NULL ,
  [Address] [nvarchar] (60) NULL ,
  [City] [nvarchar] (15) NULL ,
  [Region] [nvarchar] (15) NULL ,
  [PostalCode] [nvarchar] (10) NULL ,
  [Country] [nvarchar] (15) NULL ,
  [Phone] [nvarchar] (24) NULL ,
  [Fax] [nvarchar] (24) NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[EmployeeTerritories]    Script Date: 09/12/2001 17:18:35 ******/
CREATE TABLE [dbo].[EmployeeTerritories] (
  [EmployeeID] [int] NOT NULL ,
  [TerritoryID] [nvarchar] (20) NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Employees]    Script Date: 09/12/2001 17:18:35 ******/
CREATE TABLE [dbo].[Employees] (
  [EmployeeID] [int] IDENTITY (1, 1) NOT NULL ,
  [LastName] [nvarchar] (20) NOT NULL ,
  [FirstName] [nvarchar] (10) NOT NULL ,
  [Title] [nvarchar] (30) NULL ,
  [TitleOfCourtesy] [nvarchar] (25) NULL ,
  [BirthDate] [datetime] NULL ,
  [HireDate] [datetime] NULL ,
  [Address] [nvarchar] (60) NULL ,
  [City] [nvarchar] (15) NULL ,
  [Region] [nvarchar] (15) NULL ,
  [PostalCode] [nvarchar] (10) NULL ,
  [Country] [nvarchar] (15) NULL ,
  [HomePhone] [nvarchar] (24) NULL ,
  [Extension] [nvarchar] (4) NULL ,
  [Photo] [image] NULL ,
  [Notes] [ntext] NULL ,
  [ReportsTo] [int] NULL ,
  [PhotoPath] [nvarchar] (255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Order Details]    Script Date: 09/12/2001 17:18:35 ******/
CREATE TABLE [dbo].[Order Details] (
  [OrderID] [int] NOT NULL ,
  [ProductID] [int] NOT NULL ,
  [UnitPrice] [money] NOT NULL ,
  [Quantity] [smallint] NOT NULL ,
  [Discount] [real] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Orders]    Script Date: 09/12/2001 17:18:35 ******/
CREATE TABLE [dbo].[Orders] (
  [OrderID] [int] IDENTITY (1, 1) NOT NULL ,
  [CustomerID] [nchar] (5) NULL ,
  [EmployeeID] [int] NULL ,
  [OrderDate] [datetime] NULL ,
  [RequiredDate] [datetime] NULL ,
  [ShippedDate] [datetime] NULL ,
  [ShipVia] [int] NULL ,
  [Freight] [money] NULL ,
  [ShipName] [nvarchar] (40) NULL ,
  [ShipAddress] [nvarchar] (60) NULL ,
  [ShipCity] [nvarchar] (15) NULL ,
  [ShipRegion] [nvarchar] (15) NULL ,
  [ShipPostalCode] [nvarchar] (10) NULL ,
  [ShipCountry] [nvarchar] (15) NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Products]    Script Date: 09/12/2001 17:18:35 ******/
CREATE TABLE [dbo].[Products] (
  [ProductID] [int] IDENTITY (1, 1) NOT NULL ,
  [ProductName] [nvarchar] (40) NOT NULL ,
  [SupplierID] [int] NULL ,
  [CategoryID] [int] NULL ,
  [QuantityPerUnit] [nvarchar] (20) NULL ,
  [UnitPrice] [money] NULL ,
  [UnitsInStock] [smallint] NULL ,
  [UnitsOnOrder] [smallint] NULL ,
  [ReorderLevel] [smallint] NULL ,
  [Discontinued] [bit] NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Region]    Script Date: 09/12/2001 17:18:35 ******/
CREATE TABLE [dbo].[Region] (
  [RegionID] [int] NOT NULL ,
  [RegionDescription] [nchar] (50) NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Shippers]    Script Date: 09/12/2001 17:18:36 ******/
CREATE TABLE [dbo].[Shippers] (
  [ShipperID] [int] IDENTITY (1, 1) NOT NULL ,
  [CompanyName] [nvarchar] (40) NOT NULL ,
  [Phone] [nvarchar] (24) NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Suppliers]    Script Date: 09/12/2001 17:18:36 ******/
CREATE TABLE [dbo].[Suppliers] (
  [SupplierID] [int] IDENTITY (1, 1) NOT NULL ,
  [CompanyName] [nvarchar] (40) NOT NULL ,
  [ContactName] [nvarchar] (30) NULL ,
  [ContactTitle] [nvarchar] (30) NULL ,
  [Address] [nvarchar] (60) NULL ,
  [City] [nvarchar] (15) NULL ,
  [Region] [nvarchar] (15) NULL ,
  [PostalCode] [nvarchar] (10) NULL ,
  [Country] [nvarchar] (15) NULL ,
  [Phone] [nvarchar] (24) NULL ,
  [Fax] [nvarchar] (24) NULL ,
  [HomePage] [ntext] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Territories]    Script Date: 09/12/2001 17:18:36 ******/
CREATE TABLE [dbo].[Territories] (
  [TerritoryID] [nvarchar] (20) NOT NULL ,
  [TerritoryDescription] [nchar] (50) NOT NULL ,
  [RegionID] [int] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Categories] WITH NOCHECK ADD
  CONSTRAINT [PK_Categories] PRIMARY KEY  CLUSTERED
  (
    [CategoryID]
  )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Customers] WITH NOCHECK ADD
  CONSTRAINT [PK_Customers] PRIMARY KEY  CLUSTERED
  (
    [CustomerID]
  )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Employees] WITH NOCHECK ADD
  CONSTRAINT [PK_Employees] PRIMARY KEY  CLUSTERED
  (
    [EmployeeID]
  )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Order Details] WITH NOCHECK ADD
  CONSTRAINT [PK_Order_Details] PRIMARY KEY  CLUSTERED
  (
    [OrderID],
    [ProductID]
  )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Orders] WITH NOCHECK ADD
  CONSTRAINT [PK_Orders] PRIMARY KEY  CLUSTERED
  (
    [OrderID]
  )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Products] WITH NOCHECK ADD
  CONSTRAINT [PK_Products] PRIMARY KEY  CLUSTERED
  (
    [ProductID]
  )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Shippers] WITH NOCHECK ADD
  CONSTRAINT [PK_Shippers] PRIMARY KEY  CLUSTERED
  (
    [ShipperID]
  )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Suppliers] WITH NOCHECK ADD
  CONSTRAINT [PK_Suppliers] PRIMARY KEY  CLUSTERED
  (
    [SupplierID]
  )  ON [PRIMARY]
GO

 CREATE  INDEX [CategoryName] ON [dbo].[Categories]([CategoryName]) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CustomerCustomerDemo] WITH NOCHECK ADD
  CONSTRAINT [PK_CustomerCustomerDemo] PRIMARY KEY  NONCLUSTERED
  (
    [CustomerID],
    [CustomerTypeID]
  )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[CustomerDemographics] WITH NOCHECK ADD
  CONSTRAINT [PK_CustomerDemographics] PRIMARY KEY  NONCLUSTERED
  (
    [CustomerTypeID]
  )  ON [PRIMARY]
GO

 CREATE  INDEX [City] ON [dbo].[Customers]([City]) ON [PRIMARY]
GO

 CREATE  INDEX [CompanyName] ON [dbo].[Customers]([CompanyName]) ON [PRIMARY]
GO

 CREATE  INDEX [PostalCode] ON [dbo].[Customers]([PostalCode]) ON [PRIMARY]
GO

 CREATE  INDEX [Region] ON [dbo].[Customers]([Region]) ON [PRIMARY]
GO

ALTER TABLE [dbo].[EmployeeTerritories] WITH NOCHECK ADD
  CONSTRAINT [PK_EmployeeTerritories] PRIMARY KEY  NONCLUSTERED
  (
    [EmployeeID],
    [TerritoryID]
  )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Employees] WITH NOCHECK ADD
  CONSTRAINT [CK_Birthdate] CHECK ([BirthDate] < getdate())
GO

 CREATE  INDEX [LastName] ON [dbo].[Employees]([LastName]) ON [PRIMARY]
GO

 CREATE  INDEX [PostalCode] ON [dbo].[Employees]([PostalCode]) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Order Details] WITH NOCHECK ADD
  CONSTRAINT [DF_Order_Details_UnitPrice] DEFAULT (0) FOR [UnitPrice],
  CONSTRAINT [DF_Order_Details_Quantity] DEFAULT (1) FOR [Quantity],
  CONSTRAINT [DF_Order_Details_Discount] DEFAULT (0) FOR [Discount],
  CONSTRAINT [CK_Discount] CHECK ([Discount] >= 0 and [Discount] <= 1),
  CONSTRAINT [CK_Quantity] CHECK ([Quantity] > 0),
  CONSTRAINT [CK_UnitPrice] CHECK ([UnitPrice] >= 0)
GO

 CREATE  INDEX [OrderID] ON [dbo].[Order Details]([OrderID]) ON [PRIMARY]
GO

 CREATE  INDEX [OrdersOrder_Details] ON [dbo].[Order Details]([OrderID]) ON [PRIMARY]
GO

 CREATE  INDEX [ProductID] ON [dbo].[Order Details]([ProductID]) ON [PRIMARY]
GO

 CREATE  INDEX [ProductsOrder_Details] ON [dbo].[Order Details]([ProductID]) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Orders] WITH NOCHECK ADD
  CONSTRAINT [DF_Orders_Freight] DEFAULT (0) FOR [Freight]
GO

 CREATE  INDEX [CustomerID] ON [dbo].[Orders]([CustomerID]) ON [PRIMARY]
GO

 CREATE  INDEX [CustomersOrders] ON [dbo].[Orders]([CustomerID]) ON [PRIMARY]
GO

 CREATE  INDEX [EmployeeID] ON [dbo].[Orders]([EmployeeID]) ON [PRIMARY]
GO

 CREATE  INDEX [EmployeesOrders] ON [dbo].[Orders]([EmployeeID]) ON [PRIMARY]
GO

 CREATE  INDEX [OrderDate] ON [dbo].[Orders]([OrderDate]) ON [PRIMARY]
GO

 CREATE  INDEX [ShippedDate] ON [dbo].[Orders]([ShippedDate]) ON [PRIMARY]
GO

 CREATE  INDEX [ShippersOrders] ON [dbo].[Orders]([ShipVia]) ON [PRIMARY]
GO

 CREATE  INDEX [ShipPostalCode] ON [dbo].[Orders]([ShipPostalCode]) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Products] WITH NOCHECK ADD
  CONSTRAINT [DF_Products_UnitPrice] DEFAULT (0) FOR [UnitPrice],
  CONSTRAINT [DF_Products_UnitsInStock] DEFAULT (0) FOR [UnitsInStock],
  CONSTRAINT [DF_Products_UnitsOnOrder] DEFAULT (0) FOR [UnitsOnOrder],
  CONSTRAINT [DF_Products_ReorderLevel] DEFAULT (0) FOR [ReorderLevel],
  CONSTRAINT [DF_Products_Discontinued] DEFAULT (0) FOR [Discontinued],
  CONSTRAINT [CK_Products_UnitPrice] CHECK ([UnitPrice] >= 0),
  CONSTRAINT [CK_ReorderLevel] CHECK ([ReorderLevel] >= 0),
  CONSTRAINT [CK_UnitsInStock] CHECK ([UnitsInStock] >= 0),
  CONSTRAINT [CK_UnitsOnOrder] CHECK ([UnitsOnOrder] >= 0)
GO

 CREATE  INDEX [CategoriesProducts] ON [dbo].[Products]([CategoryID]) ON [PRIMARY]
GO

 CREATE  INDEX [CategoryID] ON [dbo].[Products]([CategoryID]) ON [PRIMARY]
GO

 CREATE  INDEX [ProductName] ON [dbo].[Products]([ProductName]) ON [PRIMARY]
GO

 CREATE  INDEX [SupplierID] ON [dbo].[Products]([SupplierID]) ON [PRIMARY]
GO

 CREATE  INDEX [SuppliersProducts] ON [dbo].[Products]([SupplierID]) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Region] WITH NOCHECK ADD
  CONSTRAINT [PK_Region] PRIMARY KEY  NONCLUSTERED
  (
    [RegionID]
  )  ON [PRIMARY]
GO

 CREATE  INDEX [CompanyName] ON [dbo].[Suppliers]([CompanyName]) ON [PRIMARY]
GO

 CREATE  INDEX [PostalCode] ON [dbo].[Suppliers]([PostalCode]) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Territories] WITH NOCHECK ADD
  CONSTRAINT [PK_Territories] PRIMARY KEY  NONCLUSTERED
  (
    [TerritoryID]
  )  ON [PRIMARY]
GO

GRANT  REFERENCES ,  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[Categories]  TO [public]
GO

GRANT  REFERENCES ,  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[CustomerCustomerDemo]  TO [public]
GO

GRANT  REFERENCES ,  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[CustomerDemographics]  TO [public]
GO

GRANT  REFERENCES ,  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[Customers]  TO [public]
GO

GRANT  REFERENCES ,  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[EmployeeTerritories]  TO [public]
GO

GRANT  REFERENCES ,  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[Employees]  TO [public]
GO

GRANT  REFERENCES ,  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[Order Details]  TO [public]
GO

GRANT  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[Order Details]  TO [anon]
GO

GRANT  REFERENCES ,  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[Orders]  TO [public]
GO

GRANT  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[Orders]  TO [anon]
GO

GRANT  REFERENCES ,  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[Products]  TO [public]
GO

GRANT  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[Products]  TO [anon]
GO

GRANT  REFERENCES ,  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[Region]  TO [public]
GO

GRANT  REFERENCES ,  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[Shippers]  TO [public]
GO

GRANT  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[Shippers]  TO [anon]
GO

GRANT  REFERENCES ,  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[Suppliers]  TO [public]
GO

GRANT  REFERENCES ,  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[Territories]  TO [public]
GO

ALTER TABLE [dbo].[CustomerCustomerDemo] ADD
  CONSTRAINT [FK_CustomerCustomerDemo] FOREIGN KEY
  (
    [CustomerTypeID]
  ) REFERENCES [dbo].[CustomerDemographics] (
    [CustomerTypeID]
  ),
  CONSTRAINT [FK_CustomerCustomerDemo_Customers] FOREIGN KEY
  (
    [CustomerID]
  ) REFERENCES [dbo].[Customers] (
    [CustomerID]
  )
GO

ALTER TABLE [dbo].[EmployeeTerritories] ADD
  CONSTRAINT [FK_EmployeeTerritories_Employees] FOREIGN KEY
  (
    [EmployeeID]
  ) REFERENCES [dbo].[Employees] (
    [EmployeeID]
  ),
  CONSTRAINT [FK_EmployeeTerritories_Territories] FOREIGN KEY
  (
    [TerritoryID]
  ) REFERENCES [dbo].[Territories] (
    [TerritoryID]
  )
GO

ALTER TABLE [dbo].[Employees] ADD
  CONSTRAINT [FK_Employees_Employees] FOREIGN KEY
  (
    [ReportsTo]
  ) REFERENCES [dbo].[Employees] (
    [EmployeeID]
  )
GO

ALTER TABLE [dbo].[Order Details] ADD
  CONSTRAINT [FK_Order_Details_Orders] FOREIGN KEY
  (
    [OrderID]
  ) REFERENCES [dbo].[Orders] (
    [OrderID]
  ),
  CONSTRAINT [FK_Order_Details_Products] FOREIGN KEY
  (
    [ProductID]
  ) REFERENCES [dbo].[Products] (
    [ProductID]
  )
GO

ALTER TABLE [dbo].[Orders] ADD
  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY
  (
    [CustomerID]
  ) REFERENCES [dbo].[Customers] (
    [CustomerID]
  ),
  CONSTRAINT [FK_Orders_Employees] FOREIGN KEY
  (
    [EmployeeID]
  ) REFERENCES [dbo].[Employees] (
    [EmployeeID]
  ),
  CONSTRAINT [FK_Orders_Shippers] FOREIGN KEY
  (
    [ShipVia]
  ) REFERENCES [dbo].[Shippers] (
    [ShipperID]
  )
GO

ALTER TABLE [dbo].[Products] ADD
  CONSTRAINT [FK_Products_Categories] FOREIGN KEY
  (
    [CategoryID]
  ) REFERENCES [dbo].[Categories] (
    [CategoryID]
  ),
  CONSTRAINT [FK_Products_Suppliers] FOREIGN KEY
  (
    [SupplierID]
  ) REFERENCES [dbo].[Suppliers] (
    [SupplierID]
  )
GO

ALTER TABLE [dbo].[Territories] ADD
  CONSTRAINT [FK_Territories_Region] FOREIGN KEY
  (
    [RegionID]
  ) REFERENCES [dbo].[Region] (
    [RegionID]
  )
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/****** Object:  Stored Procedure dbo.AllProductsList    Script Date: 09/12/2001 17:18:37 ******/
CREATE PROCEDURE AllProductsList
AS SELECT
  ProductID, ProductName, QtyPerUnit = QuantityPerUnit,
  UnitPrice, Available = UnitsInStock + UnitsOnOrder
FROM Products ORDER BY ProductName
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[AllProductsList]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[AllProductsList]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.AllShippersList    Script Date: 09/12/2001 17:18:37 ******/
CREATE PROCEDURE AllShippersList
AS SELECT
  ShipperID, ShipperName = CompanyName,
  ShipperPhone = Phone
FROM Shippers
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[AllShippersList]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[AllShippersList]  TO [anon]
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/****** Object:  Stored Procedure dbo.DeleteExistingOrder    Script Date: 09/12/2001 17:18:37 ******/
CREATE PROCEDURE DeleteExistingOrder

@OrderID varchar(5),
@RequiredWas datetime,
@ShippedWas datetime,
@FreightWas money,
@NameWas varchar(40),
@AddressWas varchar(60),
@CityWas varchar(15),
@PostalCodeWas varchar(10),
@CountryWas varchar(15),
@ShipViaWas int

AS

SELECT OrderID
FROM Orders
WHERE
  OrderID = @OrderID AND
  Freight = @FreightWas AND
  ShipVia = @ShipViaWas AND
  ShipName = @NameWas AND
  ShipAddress = @AddressWas AND
  ShipCity = @CityWas AND
  ShipPostalCode = @PostalCodeWas AND
  ShipCountry = @CountryWas AND
  CONVERT(varchar, ISNULL(RequiredDate, 1), 0) = CONVERT(varchar, ISNULL(@RequiredWas, 1), 0) AND
  CONVERT(varchar, ISNULL(ShippedDate,1), 0) = CONVERT(varchar, ISNULL(@ShippedWas, 1), 0)

IF @@ROWCOUNT = 1
  BEGIN

    BEGIN TRANSACTION

    SET NOCOUNT ON
    DELETE FROM [Order Details] WHERE OrderID = @OrderID
    SET NOCOUNT OFF

    DELETE FROM Orders WHERE
      OrderID = @OrderID AND
      Freight = @FreightWas AND
      ShipVia = @ShipViaWas AND
      ShipName = @NameWas AND
      ShipAddress = @AddressWas AND
      ShipCity = @CityWas AND
      ShipPostalCode = @PostalCodeWas AND
      ShipCountry = @CountryWas AND
      CONVERT(varchar, ISNULL(RequiredDate, 1), 0) = CONVERT(varchar, ISNULL(@RequiredWas, 1), 0) AND
      CONVERT(varchar, ISNULL(ShippedDate,1), 0) = CONVERT(varchar, ISNULL(@ShippedWas, 1), 0)

    COMMIT TRANSACTION

  END
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[DeleteExistingOrder]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[DeleteExistingOrder]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.DeleteExistingOrderLine    Script Date: 09/12/2001 17:18:37 ******/
CREATE PROCEDURE DeleteExistingOrderLine

@OrderID int,
@ProductID int,
@UnitPriceWas money,
@QuantityWas int,
@DiscountWas real

AS

DELETE FROM [Order Details] WHERE
  OrderID = @OrderID AND
  ProductID = @ProductID AND
  Quantity = @QuantityWas AND
  UnitPrice = @UnitPriceWas AND
  Discount = @DiscountWas
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[DeleteExistingOrderLine]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[DeleteExistingOrderLine]  TO [anon]
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/****** Object:  Stored Procedure dbo.GetCustomerListByIdOrName    Script Date: 27/09/2001 14:20:15 ******/
CREATE PROCEDURE GetCustomerListByIdOrName
@CustID nvarchar(5), @CustName nvarchar(40)
AS
IF @CustName=''
 BEGIN
  IF LEN(@CustID) < 5 BEGIN SET @CustID = @CustID + '%' END
  SELECT CustomerID, CompanyName, City FROM Customers
  WHERE CustomerID LIKE @CustID ORDER BY CustomerID
 END
ELSE
 BEGIN
  SET @CustName = '%' + @CustName + '%'
  SELECT CustomerID, CompanyName, City
  FROM Customers
  WHERE CompanyName LIKE @CustName ORDER BY CompanyName
 END

GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[GetCustomerListByIdOrName]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[GetCustomerListByIdOrName]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.GetOrderByOrderID    Script Date: 26/09/2001 18:30:09 ******/
CREATE PROCEDURE GetOrderByOrderID @OrderID int
AS
SELECT Orders.OrderID, Orders.CustomerID, Orders.ShipName,
OrderAddress=ISNULL(Orders.ShipAddress, '') + ', ' + ISNULL(Orders.ShipCity, '') + ', ' + ISNULL(Orders.ShipRegion, '') + ', ' + ISNULL(Orders.ShipPostalCode, '') + ', ' +ISNULL(Orders.ShipCountry, ''),
Orders.OrderDate, Orders.ShippedDate, Shippers.CompanyName
FROM ORDERS JOIN Shippers ON Orders.ShipVia=Shippers.ShipperID
WHERE Orders.OrderID = @OrderID

GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[GetOrderByOrderID]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[GetOrderByOrderID]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.GetOrderLinesByCustomer    Script Date: 26/09/2001 18:30:10 ******/
CREATE PROCEDURE GetOrderLinesByCustomer @CustID nvarchar(5)
AS
SELECT  Orders.OrderID, Products.ProductName, Products.QuantityPerUnit, [Order Details].UnitPrice,
[Order Details].Quantity, [Order Details].Discount
FROM ([Order Details] JOIN Orders ON [Order Details].OrderID = Orders.OrderID)
  JOIN Products ON [Order Details].ProductID = Products.ProductID
WHERE Orders.CustomerID LIKE @CustID

GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[GetOrderLinesByCustomer]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[GetOrderLinesByCustomer]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.GetOrderLinesByOrderID    Script Date: 26/09/2001 18:30:09 ******/
CREATE PROCEDURE GetOrderLinesByOrderID @OrderID nvarchar(5)
AS
SELECT OrderID, ProductName, QuantityPerUnit, [Order Details].UnitPrice,
Quantity, Discount
FROM [Order Details] JOIN Products ON [Order Details].ProductID = Products.ProductID
WHERE OrderID = @OrderID

GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[GetOrderLinesByOrderID]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[GetOrderLinesByOrderID]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.GetOrdersByCustomer    Script Date: 26/09/2001 18:30:09 ******/
CREATE PROCEDURE GetOrdersByCustomer @CustID nvarchar(5)
AS
SELECT Orders.OrderID, Orders.CustomerID, Orders.ShipName,
OrderAddress=ISNULL(Orders.ShipAddress, '') + ', ' + ISNULL(Orders.ShipCity, '') + ', ' + ISNULL(Orders.ShipRegion, '') + ', ' + ISNULL(Orders.ShipPostalCode, '') + ', ' +ISNULL(Orders.ShipCountry, ''),
Orders.OrderDate, Orders.ShippedDate, Shippers.CompanyName
FROM ORDERS JOIN Shippers ON Orders.ShipVia=Shippers.ShipperID
WHERE Orders.CustomerID LIKE @CustID

GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[GetOrdersByCustomer]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[GetOrdersByCustomer]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.GetSupplierList    Script Date: 26/09/2001 18:30:09 ******/
CREATE PROCEDURE GetSupplierList AS SELECT
  SupplierName=CompanyName,
  SupplierAddress=ISNULL(Address, '') + ', ' + ISNULL(City,'') + ', ' + ISNULL(Region,'') + ', ' + ISNULL(PostalCode,'')+ ', ' + ISNULL(Country,''),
  SupplierContact=ISNULL(ContactName,'') + ' - Phone:' + ISNULL(Phone,'') + ' Fax:' + ISNULL(Fax,'')
  FROM Suppliers

GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[GetSupplierList]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[GetSupplierList]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.GetSupplierName    Script Date: 26/09/2001 18:30:09 ******/
CREATE PROCEDURE GetSupplierName AS SELECT
  SupplierName=CompanyName
  FROM Suppliers

GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[GetSupplierName]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[GetSupplierName]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

/****** Object:  Stored Procedure dbo.GetSupplierXml    Script Date: 26/09/2001 18:30:09 ******/
CREATE PROCEDURE GetSupplierXml AS SELECT
  SupplierName=CompanyName,
  SupplierAddress=ISNULL(Address, '') + ', ' + ISNULL(City,'') + ', ' + ISNULL(Region,'') + ', ' + ISNULL(PostalCode,'')+ ', ' + ISNULL(Country,''),
  SupplierContact=ISNULL(ContactName,'') + ' - Phone:' + ISNULL(Phone,'') + ' Fax:' + ISNULL(Fax,'')
  FROM Suppliers FOR XML AUTO

GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[GetSupplierXml]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[GetSupplierXml]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.InsertNewOrder    Script Date: 09/12/2001 17:18:37 ******/
CREATE PROCEDURE InsertNewOrder
  @CustID varchar (5), @OrderID int OUTPUT

AS

  DECLARE @CompanyName varchar(40)
  DECLARE @Address varchar(60)
  DECLARE @City varchar(15)
  DECLARE @Region varchar(15)
  DECLARE @PostalCode varchar(10)
  DECLARE @Country varchar(15)

  SELECT @CompanyName = CompanyName, @Address = Address,
                 @City = City, @Region = Region, @PostalCode = PostalCode,
                 @Country = Country
  FROM Customers WHERE CustomerID = @CustID

  INSERT INTO Orders (CustomerID, OrderDate, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry, ShipVia, Freight)
    VALUES (@CustID, GETDATE(), @CompanyName, @Address, @City, @Region, @PostalCode, @Country, 1, 15)

  SELECT @OrderID = @@IDENTITY
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[InsertNewOrder]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[InsertNewOrder]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.InsertNewOrderLine    Script Date: 09/12/2001 17:18:37 ******/
CREATE PROCEDURE InsertNewOrderLine
  @OrderID int, @ProductID int

AS

  DECLARE @UnitPrice money

  SELECT @UnitPrice = UnitPrice
  FROM Products WHERE ProductID = @ProductID

  INSERT INTO [Order details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
    VALUES (@OrderID, @ProductID, @UnitPrice, 1, 0)
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[InsertNewOrderLine]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[InsertNewOrderLine]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.OrderLinesDelete    Script Date: 09/12/2001 17:18:37 ******/
/* ------ Delete existing order detail row based on Order ID and Product ID----- */
/* Used by 4923 Customer Orders Update sample */
CREATE PROCEDURE OrderLinesDelete
  @OrderID int,
  @ProductID int,
  @OldUnitPrice money,
  @OldQuantity smallint,
  @OldDiscount real
AS DELETE FROM [Order Details] WHERE
  OrderID = @OrderID AND
  ProductID = @ProductID AND
  UnitPrice = @OldUnitPrice AND
  Quantity = @OldQuantity AND
  Discount = @OldDiscount
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[OrderLinesDelete]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[OrderLinesDelete]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.OrderLinesForEditByCustID    Script Date: 09/12/2001 17:18:37 ******/
CREATE PROCEDURE OrderLinesForEditByCustID
  @CustID nvarchar(5)
AS SELECT
  [Order Details].*,
  Products.ProductName,
  QtyPerUnit = Products.QuantityPerUnit
FROM (Orders JOIN [Order Details]
            ON Orders.OrderID = [Order Details].OrderID)
    JOIN Products
            ON [Order Details].ProductID = Products.ProductID
  WHERE Orders.CustomerID = @CustID
  ORDER BY Orders.OrderID
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[OrderLinesForEditByCustID]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[OrderLinesForEditByCustID]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.OrderLinesForEditByOrderID    Script Date: 09/12/2001 17:18:37 ******/
CREATE PROCEDURE OrderLinesForEditByOrderID
  @OrderID int
AS SELECT * FROM [Order Details]
  WHERE [Order Details].OrderID = @OrderID ORDER BY OrderID
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[OrderLinesForEditByOrderID]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[OrderLinesForEditByOrderID]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.OrderLinesInsert    Script Date: 09/12/2001 17:18:37 ******/
/* ------ Insert new order detail row including Order ID and Product ID----- */
/* Used by 4923 Customer Orders Update sample */
CREATE PROCEDURE OrderLinesInsert
  @OrderID int,
  @ProductID int,
  @NewUnitPrice money,
  @NewQuantity smallint,
  @NewDiscount real
AS INSERT INTO [Order Details]
  (OrderID,
  ProductID,
  UnitPrice,
  Quantity,
  Discount)
VALUES
  (@OrderID,
  @ProductID,
  @NewUnitPrice,
  @NewQuantity,
  @NewDiscount)
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[OrderLinesInsert]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[OrderLinesInsert]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.OrderLinesUnderlyingValuesByOrderID    Script Date: 09/12/2001 17:18:37 ******/
CREATE PROCEDURE OrderLinesUnderlyingValuesByOrderID
  @OrderID int,
  @ProductID int
AS SELECT * FROM  [Order Details]
WHERE OrderID = @OrderID AND ProductID = @ProductID
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[OrderLinesUnderlyingValuesByOrderID]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[OrderLinesUnderlyingValuesByOrderID]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.OrderLinesUpdate    Script Date: 09/12/2001 17:18:37 ******/
/* ------ Update existing order detail row based on Order ID and Product ID----- */
/* Used by 4923 Customer Orders Update sample */
CREATE PROCEDURE OrderLinesUpdate
  @OrderID int,
  @ProductID int,
  @OldUnitPrice money,
  @OldQuantity smallint,
  @OldDiscount real,
  @NewUnitPrice money,
  @NewQuantity smallint,
  @NewDiscount real
AS UPDATE [Order Details] SET
  UnitPrice = @NewUnitPrice,
  Quantity = @NewQuantity,
  Discount = @NewDiscount
WHERE
  OrderID = @OrderID AND
  ProductID = @ProductID AND
  UnitPrice = @OldUnitPrice AND
  Quantity = @OldQuantity AND
  Discount = @OldDiscount
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[OrderLinesUpdate]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[OrderLinesUpdate]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.OrderUnderlyingValuesByOrderID    Script Date: 09/12/2001 17:18:37 ******/
CREATE PROCEDURE OrderUnderlyingValuesByOrderID
  @OrderID int
AS SELECT
  OrderID, CustomerID, OrderDate, RequiredDate,
  ShippedDate, ShipVia, Freight, ShipName,
  ShipAddress, ShipCity, ShipPostalCode, ShipCountry
FROM Orders WHERE OrderID = @OrderID
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[OrderUnderlyingValuesByOrderID]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[OrderUnderlyingValuesByOrderID]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.OrdersDelete    Script Date: 09/12/2001 17:18:37 ******/
/* ------ Delete Orders row ----- */
/* Used by 4923 Customer Orders Update sample */
CREATE PROCEDURE OrdersDelete
  @OrderID int,
  @OldCustomerID nvarchar(5),
  @OldOrderDate datetime,
  @OldRequiredDate datetime,
  @OldShippedDate datetime,
  @OldShipVia int,
  @OldFreight money,
  @OldShipName  nvarchar(40),
  @OldShipAddress nvarchar(60),
  @OldShipCity nvarchar(15),
  @OldShipPostalCode nvarchar(10),
  @OldShipCountry nvarchar(15)
AS
DELETE FROM Orders WHERE
  OrderID = @OrderID AND
  CustomerID = @OldCustomerID AND
  OrderDate = @OldOrderDate AND
  RequiredDate = @OldRequiredDate AND
  ShippedDate = @OldShippedDate AND
  ShipVia = @OldShipVia AND
  Freight = @OldFreight AND
  ShipName = @OldShipName AND
  ShipAddress = @OldShipAddress AND
  ShipCity = @OldShipCity AND
  ShipPostalCode = @OldShipPostalCode AND
  ShipCountry = @OldShipCountry
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[OrdersDelete]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[OrdersDelete]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.OrdersForEditByCustID    Script Date: 09/12/2001 17:18:37 ******/
CREATE PROCEDURE OrdersForEditByCustID
  @CustID nvarchar(5)
AS SELECT
  OrderID, CustomerID, OrderDate, RequiredDate,
  ShippedDate, ShipVia, Freight, ShipName,
  ShipAddress, ShipCity, ShipPostalCode,
  ShipCountry, ShipperName = CompanyName
FROM Orders JOIN Shippers
ON Shippers.ShipperID = Orders.ShipVia
  WHERE CustomerID = @CustID ORDER BY CustomerID, OrderID DESC
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[OrdersForEditByCustID]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[OrdersForEditByCustID]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.OrdersInsert    Script Date: 09/12/2001 17:18:37 ******/
/* ----- Insert new order row including Order ID ----- */
/* Used by 4923 Customer Orders Update sample */
CREATE PROCEDURE OrdersInsert
  @OrderID int,
  @NewCustomerID nvarchar(5),
  @NewOrderDate datetime,
  @NewRequiredDate datetime,
  @NewShippedDate datetime,
  @NewShipVia int,
  @NewFreight money,
  @NewShipName nvarchar(40),
  @NewShipAddress nvarchar(60),
  @NewShipCity nvarchar(15),
  @NewShipPostalCode nvarchar(10),
  @NewShipCountry nvarchar(15)
AS
INSERT INTO Orders
 (CustomerID,
  OrderDate,
  RequiredDate,
  ShippedDate,
  ShipVia,
  Freight,
  ShipName,
  ShipAddress,
  ShipCity,
  ShipPostalCode,
  ShipCountry)
VALUES
 (@NewCustomerID,
  @NewOrderDate,
  @NewRequiredDate,
  @NewShippedDate,
  @NewShipVia,
  @NewFreight,
  @NewShipName,
  @NewShipAddress,
  @NewShipCity,
  @NewShipPostalCode,
  @NewShipCountry)
SELECT OrderID = @@IDENTITY
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[OrdersInsert]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[OrdersInsert]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.OrdersUpdate    Script Date: 09/12/2001 17:18:37 ******/
/* ------ Update existing order row based on Order ID ----- */
/* Used by 4923 Customer Orders Update sample */
CREATE PROCEDURE OrdersUpdate
  @OrderID int,
  @OldCustomerID nvarchar(5),
  @OldOrderDate datetime,
  @OldRequiredDate datetime,
  @OldShippedDate datetime,
  @OldShipVia int,
  @OldFreight money,
  @OldShipName  nvarchar(40),
  @OldShipAddress nvarchar(60),
  @OldShipCity nvarchar(15),
  @OldShipPostalCode nvarchar(10),
  @OldShipCountry nvarchar(15),
  @NewCustomerID nvarchar(5),
  @NewOrderDate datetime,
  @NewRequiredDate datetime,
  @NewShippedDate datetime,
  @NewShipVia int,
  @NewFreight money,
  @NewShipName nvarchar(40),
  @NewShipAddress nvarchar(60),
  @NewShipCity nvarchar(15),
  @NewShipPostalCode nvarchar(10),
  @NewShipCountry nvarchar(15)
AS UPDATE Orders SET
  RequiredDate = @NewRequiredDate,
  ShippedDate = @NewShippedDate,
  ShipVia = @NewShipVia,
  Freight = @NewFreight,
  ShipName = @NewShipName,
  ShipAddress = @NewShipAddress,
  ShipCity = @NewShipCity,
  ShipPostalCode = @NewShipPostalCode,
  ShipCountry = @NewShipCountry
WHERE
  OrderID = @OrderID AND
  CustomerID = @OldCustomerID AND
  ShipVia = @OldShipVia AND
  Freight = @OldFreight AND
  ShipName = @OldShipName AND
  ShipAddress = @OldShipAddress AND
  ShipCity = @OldShipCity AND
  ShipPostalCode = @OldShipPostalCode AND
  ShipCountry = @OldShipCountry
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[OrdersUpdate]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[OrdersUpdate]  TO [anon]
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/****** Object:  Stored Procedure dbo.SetFreightCost    Script Date: 09/12/2001 17:18:37 ******/
CREATE PROCEDURE SetFreightCost
@OrderID int
AS
DECLARE @ItemCount int, @Shipper int
SELECT @ItemCount = COUNT(Quantity) FROM [Order Details] WHERE OrderID = @OrderID
SELECT @Shipper = ShipVia FROM Orders WHERE OrderID = @OrderID
UPDATE Orders SET Freight = (@ItemCount * (1.75 + (ISNULL(@Shipper, 1) * 0.23)) + 15)
WHERE OrderID = @OrderID
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[SetFreightCost]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[SetFreightCost]  TO [anon]
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/****** Object:  Stored Procedure dbo.UpdateExistingOrder    Script Date: 09/12/2001 17:18:37 ******/
CREATE PROCEDURE UpdateExistingOrder

@OrderID varchar(5),
@Required datetime,
@Shipped datetime,
@Freight money,
@ShipName varchar(40),
@Address varchar(60),
@City varchar(15),
@PostalCode varchar(10),
@Country varchar(15),
@ShipVia int,
@RequiredWas datetime,
@ShippedWas datetime,
@FreightWas money,
@NameWas varchar(40),
@AddressWas varchar(60),
@CityWas varchar(15),
@PostalCodeWas varchar(10),
@CountryWas varchar(15),
@ShipViaWas int

AS

UPDATE Orders SET
  RequiredDate = @Required,
  ShippedDate = @Shipped,
  Freight = @Freight,
  ShipVia = @ShipVia,
  ShipName = @ShipName,
  ShipAddress = @Address,
  ShipCity = @City,
  ShipPostalCode = @PostalCode,
  ShipCountry = @Country

WHERE
  OrderID = @OrderID AND
  Freight = @FreightWas AND
  ShipVia = @ShipViaWas AND
  ShipName = @NameWas AND
  ShipAddress = @AddressWas AND
  ShipCity = @CityWas AND
  ShipPostalCode = @PostalCodeWas AND
  ShipCountry = @CountryWas AND
  CONVERT(varchar, ISNULL(RequiredDate, 1), 0) = CONVERT(varchar, ISNULL(@RequiredWas, 1), 0) AND
  CONVERT(varchar, ISNULL(ShippedDate,1), 0) = CONVERT(varchar, ISNULL(@ShippedWas, 1), 0)
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[UpdateExistingOrder]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[UpdateExistingOrder]  TO [anon]
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

/****** Object:  Stored Procedure dbo.UpdateExistingOrderLine    Script Date: 09/12/2001 17:18:37 ******/
CREATE PROCEDURE UpdateExistingOrderLine

@OrderID varchar(5),
@ProductID int,
@UnitPrice money,
@Quantity int,
@Discount real,
@UnitPriceWas money,
@QuantityWas int,
@DiscountWas real

AS

UPDATE [Order Details] SET
  UnitPrice = ROUND(@UnitPrice, 2),
  Quantity = ROUND(@Quantity, 0),
  Discount = ROUND(@Discount, 2)

WHERE
  OrderID = @OrderID AND
  ProductID = @ProductID AND
  Quantity = @QuantityWas AND
  UnitPrice = @UnitPriceWas AND
  Discount = @DiscountWas
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

GRANT  EXECUTE  ON [dbo].[UpdateExistingOrderLine]  TO [public]
GO

GRANT  EXECUTE  ON [dbo].[UpdateExistingOrderLine]  TO [anon]
GO

