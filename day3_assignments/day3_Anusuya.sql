select * from products where productid=100 ;

insert into products (productid,productname,quantityperunit,unitprice,discontinued,categoryid)
values(100,'WheatBread','1',13,0,5)
on conflict (productid)
do update 
set productname=excluded.productname,
    quantityperunit=excluded.quantityperunit,
	unitprice=excluded.unitprice,
	discontinued=excluded.discontinued,
	categoryid=excluded.categoryid;

insert into products (productid,productname,quantityperunit,unitprice,discontinued,categoryid)
values(101,'WheatBread','5 boxes',13,0,5)
on conflict (productid)
do update 
set productname=excluded.productname,
    quantityperunit=excluded.quantityperunit,
	unitprice=excluded.unitprice,
	discontinued=excluded.discontinued,
	categoryid=excluded.categoryid;
select * from products where productid=101 ;

insert into products (productid,productname,quantityperunit,unitprice,discontinued,categoryid)
values(100,'WheatBread','10 boxes',13,0,5)
on conflict (productid)
do update 
set productname=excluded.productname,
    quantityperunit=excluded.quantityperunit,
	unitprice=excluded.unitprice,
	discontinued=excluded.discontinued,
	categoryid=excluded.categoryid;
select * from products where productid=100 ;

select  * from products where productid in('100','101');

merge into products p
using (
values(100,'WheatBread','10',20,1,5),
        (101,'WhiteBread','5 boxes',19.99,0,5),
		(102,'Midnight Mango Fizz','24 - 12 oz bottles',19,0,2),
		(103,'Savory Fire Sauce','12 - 550 ml bottles',10,0,2 ))
		as updatedproducts(productid,productname,quantityperunit,unitprice,discontinued,categoryid)
		on p.productid=updatedproducts.productid
		When matched and updatedproducts.discontinued=0 then 
		update set 
		unitprice =updatedproducts.unitprice,
	    discontinued=updatedproducts.discontinued
		When not matched and updatedproducts.discontinued=0 then
		insert (productid,productname,quantityperunit,unitprice,discontinued,categoryid)
		values(updatedproducts.productid,updatedproducts.productname,updatedproducts.quantityperunit,updatedproducts.unitprice,updatedproducts.discontinued,updatedproducts.categoryid)
		When matched and updatedproducts.discontinued=1 then
		delete;
		

		select * from products where productid in ('100','101','102','103');
		
		

----------------------NORTHWIND__DB_________--
Select o.employee_id ,o.order_id,o.order_date,o.customer_id,
e.first_name || ''||e.last_name as employeefullname from orders o
inner join employees e 
on o.employee_id=e.employee_id;



