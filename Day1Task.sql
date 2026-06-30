****SQL DAY 1 *****

create table customer1(
	cid int PRIMARY KEY,
	cname VARCHAR(25),
	emai VARCHAR(30),
	phone VARCHAR(15),
	city VARCHAR(50)
);
INSERT into customer1 VALUES (&cid,'&cname','&email','&phone','&city');
INSERT into customer1 VALUES (102,'Rahul','rahul52@gmail.com','9685741244','Ahemdabad');
INSERT into customer1 VALUES (103,'Mohit','mohil55@gmail.com','7845789955','Surat');
INSERT into customer1 VALUES (104,'Krishana','krishna2004@gmail.com','8596741245','Vadodara');
INSERT into customer1 VALUES (105,'Raj','raj788@gmail.com','9968574855','Botad');

> select * from customer1;

    CID CNAME                     EMAI                           PHONE           CITY
------- ------------------------- ------------------------------ --------------- ------------
      1 Darshan                   darshan52@gmail.com            9316021319      Botad
    102 Rahul                     rahul52@gmail.com              9685741244      Ahemdabad
    103 Mohit                     mohil55@gmail.com              7845789955      Surat
    104 Krishana                  krishna2004@gmail.com          8596741245      Vadodara
    105 Raj                       raj788@gmail.com               9968574855      Botad

CREATE TABLE product(
	pid int PRIMARY KEY,
	pname VARCHAR(25),
	category VARCHAR(50),
	price int
);

INSERT into product VALUES(&pid,'&pname','&category',&price);
INSERT into product VALUES(20,'Mobile','smart phone',15000);
INSERT into product VALUES(30,'Watch','Digital',500);
INSERT into product VALUES(40,'Watch','Smart',1500);
INSERT into product VALUES(50,'Computer','System',25000);

> select * from product;

    PID PNAME                     CATEGORY                                                PRICE
------- ------------------------- -------------------------------------------------- ----------
     10 Fan                       Electric                                                  450
     20 Mobile                    smart phone                                             15000
     30 Watch                     Digital                                                   500
     40 Watch                     Smart                                                    1500
     50 Computer                  System                                                  25000

create TABLE orders(
 oid int PRIMARY KEY,
 cid int,
 pid int,
 Qty int,
 orderDate date,
 totalAmt int,
 foreign key (cid) REFERENCES customer1(cid),
 foreign key (pid) REFERENCES product(pid)
);

insert into orders values(&oid,&cid,&pid,&Qty,'&orderDate',&totalAmt);
insert into orders values(22,102,10,3,'20-May-24',5800);
insert into orders values(33,103,10,30,'25-jan-26',5800);
insert into orders values(44,104,10,20,'10-mar-25',5800);
insert into orders values(55,10,10,10,'15-May-24',5800);

insert into orders values(67,55,22,10,'15-May-24',5800);

update orders set totalAmt=&totalAmt where oid=&oid;

 SQL> select * from orders;

       OID        CID        PID        QTY ORDERDATE   TOTALAMT
---------- ---------- ---------- ---------- --------- ----------
        11          1         10          5 10-JUN-26       8900
        22        102         20          3 20-MAY-24       4500
        33        103         30         30 25-JAN-26       2500
        44        104         40         20 10-MAR-25       8540
        55        105         50         10 15-MAY-24       7890
        66        105         10         10 15-MAY-24       3000

6 rows selected.


Query :- 

(1)Display list of all customers
select * from customer1;

   CID CNAME                     EMAI                           PHONE           CITY
------ ------------------------- ------------------------------ --------------- -------------------------------------------------
     1 Darshan                   darshan52@gmail.com            9316021319      Botad
   102 Rahul                     rahul52@gmail.com              9685741244      Ahemdabad
   103 Mohit                     mohil55@gmail.com              7845789955      Surat
   104 Krishana                  krishna2004@gmail.com          8596741245      Vadodara
   105 Raj                       raj788@gmail.com               9968574855      Botad


(2)Display list of all product name 
select * from product;

 PID PNAME                     CATEGORY                                                PRICE
---- ------------------------- -------------------------------------------------- ----------
  10 Fan                       Electric                                                  450
  20 Mobile                    smart phone                                             15000
  30 Watch                     Digital                                                   500
  40 Watch                     Smart                                                    1500
  50 Computer                  System                                                  25000


(3)Display product purchased by each customer

SELECT c.cname , sum(o.Qty) from orders o join customer1 c on o.cid=c.cid group by c.cname;


CNAME                     SUM(O.QTY)
------------------------- ----------
Mohit                             30
Rahul                              3
Raj                               20
Krishana                          20
Darshan                            5

(4)Quantity of each product purchased by particular Customer

SELECT c.cid,
       c.cname,
       p.pid,
       p.pname,
       o.qty
FROM customer1 c
JOIN orders o
ON c.cid = o.cid
JOIN product p
ON o.pid = p.pid
WHERE c.cid = 104;


      CID CNAME                            PID PNAME                            QTY
--------- ------------------------- ---------- ------------------------- ----------
      104 Krishana                          40 Watch                             20

QL> 

(5)customer invoice showing customer name ,product name ,qauntity price,total amount 

select c.cname ,p.pname ,o.Qty ,p.price ,o.totalAmt 
from orders o 
join 
customer1 c 
ON
o.cid=c.cid
join
product p 
on 
o.pid=p.pid 
;

CNAME                     PNAME                            QTY      PRICE   TOTALAMT
------------------------- ------------------------- ---------- ---------- ----------
Raj                       Fan                               10        450       5800
Darshan                   Fan                                5        450       4500
Rahul                     Mobile                             3      15000       5800
Mohit                     Watch                             30        500       5800
Krishana                  Watch                             20       1500       5800
Raj                       Computer                          10      25000       5800

6 rows selected.

(6)customer who purchased product worth more than 5000

select c.cname ,o.totalAmt from 
orders o 
join 
customer1 c 
on 
o.cid=c.cid
where o.totalAmt>5000;


CNAME                       TOTALAMT
------------------------- ----------
Darshan                         8900
Krishana                        8540
Raj                             7890