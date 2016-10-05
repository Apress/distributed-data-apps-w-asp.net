update orders
set shipcity='Graz8'
where orderid=11072
or orderid=11008

update [order details]
set quantity=8
where productid=2
and orderid=11072
or orderid=11008