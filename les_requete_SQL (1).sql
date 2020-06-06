CREATE TABLE client(id_client INT AUTO_INCREMENT NOT NULL,
First_name VARCHAR(50),
last_name VARCHAR(50),
gender ENUM('F','M'),phone_Number INT,
UNIQUE(First_name,last_name),
primary key(id_client))ENGINE=INNODB;




CREATE TABLE commande(id_order INT  PRIMARY KEY AUTO_INCREMENT NOT NULL,
Qantity int,
ID_c int,
ORDER_TIME datetime,
foreign key(ID_c) references client(id_client)
)ENGINE=InnoDB;

alter table commande drop column Qantity


CREATE TABLE produit(id_produit INT  AUTO_INCREMENT NOT NULL,
name_prod VARCHAR(50),
price DECIMAL(9,2) CHECK(price>0),PRIMARY KEY(id_produit))ENGINE=InnoDB;

alter table produit add column Product_origin varchar(50) 

CREATE TABLE contient(Fk_prod INT,
FK_cmd INT,
FOREIGN KEY (FK_prod) REFERENCES produit(id_produit) ON UPDATE CASCADE 
ON DELETE CASCADE,
FOREIGN KEY (FK_cmd) REFERENCES commande(id_order) ON UPDATE CASCADE 
ON DELETE CASCADE,
CONSTRAINT pK_2 PRIMARY KEY(FK_prod,FK_cmd))ENGINE=InnoDB;

insert into client(First_name,last_name,gender,phone_Number)values
('Chris','Martin','M','01123147789'),
('Emma','Law','F','01123439899'),
('Mark','Watkins','M','01174592013'),
('Daniel','Williams','M',NULL),
('Sarah','Taylor','M','01176348290'),
('Katie','Armstrong','F','01145787353'),
('Michael','Bluth','M','01980289282'),
('Kat','Nash','F','01176987789'),
('Buster','Bluth','M','01173456782'),
('Charlie',NULL,'F','01139287883'),
('Lindsay','Bluth','F','01176923804'),
('Harry','Johnson','M',NULL),
('John','Taylor','M',NULL),
('Emma','Smith','F','01176984116'),
('Gob','Bluth','M','01176985498'),
('George','Bluth','M','01176984303'),
('Lucille','Bluth','F','01198773214'),
('George','Evans','M','01174502933'),
('Emily','Simmonds','F','01899284352'),
('John','Smith','M','01144473330'),
('Jennifer',NULL,'F',NULL),
('Toby','West','M','01176009822'),
('Paul','Edmonds','M','01966947113');

insert into produit(id_produit,name_prod,price,Product_origin) values
(1,'special coffee', 7.5,'Brazil'),
(2,'coffee family', 8,'Cuba'),
(13,'coffee 2.0', 8.5,'Ethopia'),
(3,'animal coffee',2.5,'Indonesia'),
(22,'coffe plus', 5.5,'Italy'),
(14,'coffee ++',3.00,'Maroc');


insert into commande(ID_c,ORDER_TIME) values
(1,'2017-01-01 08-02-11'),
(2,'2017-02-01 08-05-16'),
(12,'2017-01-01 08-44-34'),
(4,'2017-01-01 09-20-02'),
(9,'2017-01-01 11-51-56'),
(22,'2017-01-01 13-07-10'),
(1,'2017-02-02 08-03-41'),
(10,'2017-01-02 09-15-22'),
(2,'2017-02-02 10-10-10'),
(13,'2017-02-02 12-07-23'),
(1,'2017-01-03 08-13-50'),
(16,'2017-01-03 08-47-09'),
(21,'2017-01-03 09-12-11'),
(22,'2017-01-03 11-05-33'),
(3,'2017-01-03 11-08-55'),
(11,'2017-01-03 12-02-14'),
(23,'2017-01-03 13-41-22'),
(1,'2017-01-04 08-08-56'),
(10,'2017-02-04 11-23-43'),
(12,'2017-01-05 08-30-09'),
(1,'2017-01-06 09-02-47'),
(18,'2017-01-06 13-23-34'),
(16,'2017-01-07 09-12-39'),
(14,'2017-01-07 11-24-15'),
(5,'2017-01-08 08-54-11'),
(1,'2017-01-09 08-03-11'),
(20,'2017-01-10 10-34-12'),
(3,'2017-01-10 11-02-11'),
(23,'2017-02-11 08-39-11'),
(8,'2017-01-12 13-20-13'),
(1,'2017-01-14 08-27-10'),
(15,'2017-01-15 08-30-56'),
(7,'2017-01-16 10-02-11');



update produit set price=5.5*5 where name_prod='special coffee';

update produit set Product_origin='EST Europe' where id_produit=22;



SELECT FK_cmd ,max(ORDER_TIME) as las_date from contient ;


select id_client,First_name,gender,phone_number,count(ID_c) as count
from client,commande
where client.id_client=commande.ID_c
group by id_client,First_name,gender,phone_number
LIMIT 1;

select ID_c, count(*) as max_client
from commande 
group by ID_c
order by  count(*)  desc LIMIT 1

select COUNt(gender) from client where gender="F" 
select*from produit
select count(gender)from client where gender="M"

select *from produit where price>15

select name_prod,price from produit where name_prod like '%special%'

select name_prod from produit where price<>8.5

select name_prod,price from produit where price<>8.5

select name_prod,price from produit where Product_origin='cuba' or Product_origin='Indonesia'  order by name_prod asc


select name_prod,price as retail_price  from produit 

select First_name,phone_Number from client where last_name='Bluth'

select count(*) from client where gender='M' and phone_Number is NULL

select First_name,phone_Number from client where last_name like '%ar%'

select  DISTINCT last_name from client order by last_name asc



select * from commande where YEAR(ORDER_TIME)=2017 AND MONTH(ORDER_TIME)=2 and (ID_c=2 or ID_c=4 or ID_c=6 or ID_c=8)
 
 select * from produit
 where YEAR(ORDER_TIME)=2017 AND MONTH(ORDER_TIME)=1 and ID_c=1  LIMIT 3 
 
 select id_order,phone_Number
 from client,contient,commande,produit
 where  commande.id_order=contient.FK_cmd and produit.id_produit=contient.Fk_prod and id_produit=3
group by FK_cmd,phone_Number
 select*from commande
 
 select name_prod,ORDER_TIME 
 from produit,contient,commande
 where (commande.id_order=contient.FK_cmd and produit.id_produit=contient.Fk_prod )and
 ORDER_TIME between CAST('2017-01-15' AS DATE) AND CAST('2017-02-14' AS DATE);
 
  select name_prod,price,ORDER_TIME
  from produit,commande,contient,client
  where (commande.id_order=contient.FK_cmd and produit.id_produit=contient.Fk_prod) 
  and(client.id_client=commande.ID_c)
  and gender="F" and (YEAR(ORDER_TIME)=2017 AND MONTH(ORDER_TIME)=1)
  group by name_prod,price,ORDER_TIME
  
