copSELECT "categoryID", "categoryName", description, "regionID"
	FROM public.categories;y public.order_details(orderid, produc-- Table: public.orders

-- DROP TABLE IF EXISTS public.orders;

CREATE TABLE IF NOT EXISTS public.orders
(
    orderid integer NOT NULL,
    customerid character varying(40) COLLATE pg_catalog."default" NOT NULL,
    employeeid integer NOT NULL,
    orderdate date,
    requireddate date,
    shippeddate date,
    shipperid integer NOT NULL,
    freight integer,
    CONSTRAINT orders_pkey PRIMARY KEY (orderid, customerid, employeeid, shipperid),
    CONSTRAINT orders_customerid_fkey FOREIGN KEY (customerid)
        REFERENCES public.customers ("customerID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT orders_employeeid_fkey FOREIGN KEY (employeeid)
        REFERENCES public.employees (employeeid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT orders_shipperid_fkey FOREIGN KEY (shipperid)
        REFERENCES public.shippers (shipperid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.orders
    OWNER to postgres;tid, unitprice, quantity, discount) from 'C:\CVS\order_details.csv' DELIMITER ',' CSV HEADER encoding 'windows-1251';
	SELECT * FROM public.orders
ORDER BY orderid ASC, customerid ASC, employeeid ASC, shipperid ASC 
SELECT orderid, productid, unitprice, quantity, discount
	FROM public.order_details;
SELECT * FROM public.order_details
ORDER BY orderid ASC 

SELECT * FROM public.order_details
ORDER BY orderid ASC, productid ASC 



	
