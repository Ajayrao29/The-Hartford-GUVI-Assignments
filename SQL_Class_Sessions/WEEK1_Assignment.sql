CREATE DATABASE WA1;
USE WA1;

CREATE TABLE Client (
    ClientNo VARCHAR(6) PRIMARY KEY,
    Name VARCHAR(20) NOT NULL,
    Address1 VARCHAR(30),
    Address2 VARCHAR(30),
    City VARCHAR(15),
    Pincode NUMERIC(8),
    State VARCHAR(15),
    BalDue NUMERIC(10,2)
);

DROP TABLE Client;

CREATE TABLE CLIENT_MASTER (
    CLIENTNO VARCHAR(6) PRIMARY KEY
        CHECK (CLIENTNO LIKE 'C%'),
    NAME VARCHAR(20) NOT NULL,
    ADDRESS1 VARCHAR(30),
    ADDRESS2 VARCHAR(30),
    CITY VARCHAR(15),
    PINCODE NUMERIC(8),
    STATE VARCHAR(15),
    BALDUE NUMERIC(10,2)
);


CREATE TABLE PRODUCT_MASTER (
    PRODUCTNO VARCHAR(6) PRIMARY KEY
        CHECK (PRODUCTNO LIKE 'P%'),
    DESCRIPTION VARCHAR(15) NOT NULL,
    PROFITPERC NUMERIC(4,2) NOT NULL,
    UNITMEASURE VARCHAR(10) NOT NULL,
    QTYONHAND NUMERIC(8) NOT NULL,
    REORDERLVL NUMERIC(8) NOT NULL,
    SELLPRICE NUMERIC(8,2) NOT NULL
        CHECK (SELLPRICE <> 0),
    COSTPRICE NUMERIC(8,2) NOT NULL
        CHECK (COSTPRICE <> 0)
);

CREATE TABLE SALESMAN_MASTER (
    SALESMANNO VARCHAR(6) PRIMARY KEY
        CHECK (SALESMANNO LIKE 'S%'),
    SALESMANNAME VARCHAR(20) NOT NULL,
    ADDRESS1 VARCHAR(30) NOT NULL,
    ADDRESS2 VARCHAR(30),
    CITY VARCHAR(20),
    PINCODE NUMERIC(8),
    STATE VARCHAR(20),
    SALAMT NUMERIC(8,2) NOT NULL
        CHECK (SALAMT <> 0),
    TGTTOGET NUMERIC(6,2) NOT NULL,
    YTDSALES NUMERIC(6,2) NOT NULL,
    REMARKS VARCHAR(60)
);

CREATE TABLE SALES_ORDER (
    ORDERNO VARCHAR(6) PRIMARY KEY
        CHECK (ORDERNO LIKE 'O%'),
    CLIENTNO VARCHAR(6),
    ORDERDATE DATE,
    DELYADDR VARCHAR(25),
    SALESMANNO VARCHAR(6),
    DELYTYPE CHAR(1)
        CHECK (DELYTYPE IN ('P','F')),
    BILLEDYN CHAR(1)
        CHECK (BILLEDYN IN ('Y','N')),
    DELYDATE DATE,
    ORDERSTATUS VARCHAR(10)
        CHECK (ORDERSTATUS IN 
            ('In Process','Fulfilled','Backorder','Cancelled')),

    CONSTRAINT FK_SO_CLIENT
        FOREIGN KEY (CLIENTNO)
        REFERENCES CLIENT_MASTER(CLIENTNO),

    CONSTRAINT FK_SO_SALESMAN
        FOREIGN KEY (SALESMANNO)
        REFERENCES SALESMAN_MASTER(SALESMANNO)
);


CREATE TABLE SALES_ORDER_DETAILS (
    ORDERNO VARCHAR(6),
    PRODUCTNO VARCHAR(6),
    QTYORDERED NUMERIC(8),
    QTYDISP NUMERIC(8),
    PRODUCTRATE NUMERIC(10,2),

    CONSTRAINT PK_SALES_ORDER_DETAILS
        PRIMARY KEY (ORDERNO, PRODUCTNO),

    CONSTRAINT FK_SOD_ORDER
        FOREIGN KEY (ORDERNO)
        REFERENCES SALES_ORDER(ORDERNO),

    CONSTRAINT FK_SOD_PRODUCT
        FOREIGN KEY (PRODUCTNO)
        REFERENCES PRODUCT_MASTER(PRODUCTNO)
);

INSERT INTO CLIENT_MASTER VALUES ('C00001','Ivan Bayross','Addr1','Addr2','Mumbai',400054,'Maharashtra',15000);
INSERT INTO CLIENT_MASTER VALUES ('C00002','Rohit Sharma','Addr1','Addr2','Delhi',110001,'Delhi',12000);
INSERT INTO CLIENT_MASTER VALUES ('C00003','Anita Desai','Addr1','Addr2','Chennai',600001,'Tamil Nadu',18000);
INSERT INTO CLIENT_MASTER VALUES ('C00004','Kiran Rao','Addr1','Addr2','Hyderabad',500001,'Telangana',9000);
INSERT INTO CLIENT_MASTER VALUES ('C00005','Neha Singh','Addr1','Addr2','Bangalore',560001,'Karnataka',20000);

INSERT INTO PRODUCT_MASTER VALUES ('P00001','T-Shirts',5,'Piece',200,50,350,250);
INSERT INTO PRODUCT_MASTER VALUES ('P00002','Jeans',6,'Piece',150,40,1200,900);
INSERT INTO PRODUCT_MASTER VALUES ('P00003','Shoes',8,'Pair',100,30,2500,2000);
INSERT INTO PRODUCT_MASTER VALUES ('P00004','Jackets',7,'Piece',80,20,3000,2500);
INSERT INTO PRODUCT_MASTER VALUES ('P00005','Caps',4,'Piece',300,60,250,150);

INSERT INTO SALESMAN_MASTER VALUES ('S00001','Aman','A/14','Worli','Mumbai',400002,'Maharashtra',3000,100,50,'Good');
INSERT INTO SALESMAN_MASTER VALUES ('S00002','Ravi','B/22','Karol Bagh','Delhi',110005,'Delhi',4000,150,70,'Excellent');
INSERT INTO SALESMAN_MASTER VALUES ('S00003','Sunita','C/11','Adyar','Chennai',600020,'Tamil Nadu',3500,120,60,'Good');
INSERT INTO SALESMAN_MASTER VALUES ('S00004','Arjun','D/45','Banjara Hills','Hyderabad',500034,'Telangana',4500,180,90,'Very Good');
INSERT INTO SALESMAN_MASTER VALUES ('S00005','Meena','E/78','Indiranagar','Bangalore',560038,'Karnataka',5000,200,110,'Excellent');


INSERT INTO SALES_ORDER VALUES ('O19001','C00001','2002-06-12','Mumbai','S00001','F','N','2002-07-20','In Process');
INSERT INTO SALES_ORDER VALUES ('O19002','C00002','2002-06-15','Delhi','S00002','P','Y','2002-07-25','Fulfilled');
INSERT INTO SALES_ORDER VALUES ('O19003','C00003','2002-06-18','Chennai','S00003','F','N','2002-07-30','Backorder');
INSERT INTO SALES_ORDER VALUES ('O19004','C00004','2002-06-20','Hyderabad','S00004','P','Y','2002-08-05','Fulfilled');
INSERT INTO SALES_ORDER VALUES ('O19005','C00005','2002-06-25','Bangalore','S00005','F','N','2002-08-10','Cancelled');

INSERT INTO SALES_ORDER_DETAILS VALUES ('O19001','P00001',4,4,525);
INSERT INTO SALES_ORDER_DETAILS VALUES ('O19002','P00002',2,2,1250);
INSERT INTO SALES_ORDER_DETAILS VALUES ('O19003','P00003',1,0,2600);
INSERT INTO SALES_ORDER_DETAILS VALUES ('O19004','P00004',3,3,3200);
INSERT INTO SALES_ORDER_DETAILS VALUES ('O19005','P00005',5,5,300);

--Weeekly Assignment Commands

--1. 
Select name from CLIENT_MASTER;
--2.
Select * from Client_Master where City='Mumbai';
--3.
Select * from Product_Master where SELLPRICE BETWEEN 2000 and 5000;
--4.
Select name,city,state from Client_Master where state!='Maharashtra';
--5 
Select * from CLIENT_MASTER where CLIENTNO IN ('C00001','C00002');
--6
UPDATE Product_Master set sellprice=1150.50 Where Description='Jeans';
--7.
ALTER TABLE SALES_ORDER DROP CONSTRAINT FK_SO_CLIENT;
ALTER TABLE SALES_ORDER ADD CONSTRAINT FK_SO_CLIENT FOREIGN KEY (CLIENTNO)
REFERENCES CLIENT_MASTER(CLIENTNO) ON DELETE CASCADE;

ALTER TABLE SALES_ORDER_DETAILS DROP CONSTRAINT FK_SOD_ORDER;
ALTER TABLE SALES_ORDER_DETAILS ADD CONSTRAINT FK_SOD_ORDER
FOREIGN KEY (ORDERNO) REFERENCES SALES_ORDER(ORDERNO)
ON DELETE CASCADE;

Delete from CLIENT_MASTER where CLIENTNO='C00005';
--8.
Select * from CLIENT_MASTER where city like '_a%';
--9.
Select count(*) from PRODUCT_MASTER where SELLPRICE>=1500;
--10.
Select QTYORDERED, QTYDISP,(QTYORDERED - QTYDISP) AS BalancedQty from SALES_ORDER_DETAILS;

--Next part
--1.
--ClientNo is already a primary key in Client_Master
--2.
ALTER TABLE CLIENT_MASTER ADD PhoneNo Varchar(15) ;
--3.
/*In creation Commands NOT NULL is already added to columns description, 
profit percent, sell price and cost price in Product_Master table.*/
--4.
ALTER TABLE CLIENT_MASTER ALTER COLUMN NAME VARCHAR(60) NOT NULL;
--5.
ALTER TABLE CLIENT_MASTER DROP COLUMN PINCODE;

-- Joins(7)
INSERT INTO PRODUCT_MASTER VALUES
('P00006','Trousers',6,'Piece',120,30,1800,1400);

INSERT INTO PRODUCT_MASTER VALUES
('P00007','Pull Overs',5,'Piece',90,20,2200,1800);

-- Ivan Bayross buys Trousers
INSERT INTO SALES_ORDER_DETAILS VALUES
('O19006','P00006',6,6,1800);

-- Less than 5 Pull Overs (for query 5)
INSERT INTO SALES_ORDER_DETAILS VALUES
('O19006','P00007',3,3,2200);

INSERT INTO SALES_ORDER VALUES
('O19007','C00002',GETDATE(),'Delhi','S00002','F','Y',GETDATE(),'Fulfilled');

INSERT INTO SALES_ORDER_DETAILS VALUES
('O19007','P00006',4,4,1800);
INSERT INTO SALES_ORDER VALUES
('O19006','C00001',GETDATE(),'Mumbai','S00001','F','Y',GETDATE(),'Fulfilled');

--1.
select distinct p.description from client_master c 
join sales_order o on c.clientno = o.clientno
join sales_order_details d on o.orderno = d.orderno
join product_master p on d.productno = p.productno
where c.name = 'Ivan Bayross';
--2.

select p.description, d.qtydisp
from sales_order o
join sales_order_details d on o.orderno = d.orderno
join product_master p on d.productno = p.productno
where month(o.delydate) = month(getdate())
  and year(o.delydate) = year(getdate());
--3.
select p.productno, p.description
from product_master p
join sales_order_details d on p.productno = d.productno
group by p.productno, p.description
having count(d.productno) > 1;
--4.
select distinct c.name from client_master c
join sales_order o on c.clientno = o.clientno
join sales_order_details d on o.orderno = d.orderno
join product_master p on d.productno = p.productno
where p.description = 'Trousers';
--5.
select o.orderno, p.description, d.qtyordered from sales_order o
join sales_order_details d on o.orderno = d.orderno
join product_master p on d.productno = p.productno
where p.description = 'Pull Overs'and d.qtyordered < 5;

--SubQueries(8)
--1.
select description from product_master
where productno not in (select productno from sales_order_details);
--2.
select name, address1, address2, city, state from client_master
where clientno =(select clientno from sales_order where orderno = 'O19001');
--3.
select name from client_master where clientno in (select clientno from sales_order
where orderdate < '2002-05-01');

--  Commands(9)
--1.
select format(cast('2012-02-11' as date), 'dddd, MMMM dd, yyyy') as system_date;
--2.
select format(99999.99, 'C') as balance_due;
--3.
select 'Salesman Aman sold goods of 50 while given target was 100' as message;
--4.
select datediff(year, '2003-06-15', getdate()) as age_in_years;
