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

/****** Object:  Stored Procedure dbo.GetOrderByOrderID    Script Date: 09/12/2001 17:18:37 ******/

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
/* ------ Delete Orders table row ----- */
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
DECLARE  @@NewOrderID int
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

