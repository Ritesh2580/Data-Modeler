drop table IF EXISTS Parent;
drop table IF EXISTS child;

Create table Parent(
code INT  NOT NULL AUTO_INCREMENT , 
name CHAR(50)  NOT NULL , 
Primary Key (code))ENGINE=InnoDB;



Create table child(
code INT  NOT NULL AUTO_INCREMENT , 
name CHAR(50)  NOT NULL , 
parent_code INT  NOT NULL , 
Primary Key (code))ENGINE=InnoDB;




Alter table child add  Foreign Key (parent_code ) references Parent(code)on delete  restrict on update  restrict;
