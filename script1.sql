-- ---------------------------------
-- SCRIPT 1

-- Set up the database
SHOW DATABASES;
DROP DATABASE IF EXISTS assign2db;
CREATE DATABASE assign2db;
USE assign2db; 

-- Create the tables for the database
SHOW TABLES;

CREATE TABLE customer(cusid CHAR(4) NOT NULL, firstname VARCHAR(20) NOT NULL, lastname VARCHAR(20) NOT NULL, cellnum CHAR(10) not NULL, PRIMARY KEY(cusid));

CREATE TABLE driver(driverid CHAR(4) NOT NULL, firstname VARCHAR(20) NOT NULL, lastname VARCHAR(20) NOT NULL, cellnum CHAR(10) not NULL, PRIMARY KEY(driverid));

CREATE TABLE menuitem(menuitemid CHAR(4) NOT NULL,dishname VARCHAR(60) NOT NULL, price DECIMAL(5,2), caloriecount INT NOT NULL, veggie CHAR(1) NOT NULL, PRIMARY KEY(menuitemid));

CREATE TABLE cusorder (orderid CHAR(4) NOT NULL, deladdress VARCHAR(20), dateplaced DATE, timeplaced TIME, timedelivered TIME, pickuporder CHAR(1) NOT NULL, deliveryrating SMALLINT, driverid CHAR(4), cusid CHAR(4), PRIMARY KEY(orderid), FOREIGN KEY(cusid) REFERENCES customer(cusid) ON DELETE CASCADE, FOREIGN KEY (driverid) REFERENCES driver(driverid));

CREATE TABLE overallorder (orderid CHAR(4) NOT NULL, menuitemid CHAR(4) NOT NULL, quantity INT, PRIMARY KEY (orderid, menuitemid), FOREIGN KEY(orderid) REFERENCES cusorder(orderid), FOREIGN KEY (menuitemid) REFERENCES menuitem(menuitemid));

SHOW TABLES;

-- ------------------------------------
-- insert some data

-- insert into the customer table
SELECT * FROM customer;
INSERT INTO customer (cusid, firstname, lastname, cellnum) VALUES
('CRRR', 'Sue', 'Tanaka', '5196817624'),
('CGD5', 'Sean', 'Aziz', '5196817509'),
('CIT4', 'Scott', 'Mortensen', '5196726721'),
('CT67', 'Gerry', 'Webster', '5488887524'),
('CK78', 'Jon', 'Joselyn', '9051234444'),
('CE66', 'Colleen', 'Tyler', '5197776666');
SELECT * FROM customer;

-- insert into the driver table
SELECT * FROM driver;
INSERT INTO driver (driverid, firstname, lastname, cellnum) VALUES
('D111', 'Homer', 'Simpson', '5191111111'),
('D222', 'Marge', 'Simpson', '5192222222'),
('D333', 'Bart', 'Simpson', '5193333333'),
('D444', 'Lisa', 'Simpson', '9054444444'),
('D555', 'Maggie', 'Simpson', '5488885555'),
('D666', 'Ned', 'Flanders', '5197776666');
SELECT * FROM driver;

-- insert into the menuitem table
SELECT * FROM menuitem;
INSERT INTO menuitem (menuitemid, dishname, price, caloriecount, veggie) VALUES ('MAAA', 'Beef Lasagna', 22.50, 610, "N"),
('MBBB', 'Spagetti and Meatballs', 21.50, 490, 'N'),
('MCCC', 'Ratatouille', 19.95, 370, 'Y'),
('MDDD', 'Margherita Pizza', 22.50, 505,'Y'),
('MEEE', 'Gnocchi Pomodoro', 18.95, 490, 'Y'),
('MFFF', 'Chicken Marsala', 25.00, 390, 'N'),
('MGGG', 'Chicken Parmesan', 26.50, 620, 'N' ),
('MHHH', 'Pasta alla Brenda', 16.80 , 500, 'N');
SELECT * FROM menuitem;

-- insert into the customer order table
SELECT * FROM cusorder;
INSERT INTO cusorder (orderid, deladdress, dateplaced,timeplaced,timedelivered, pickuporder, deliveryrating, driverid, cusid) VALUES
('C100','20 Main Street','2025-01-01','17:30:00','17:50:00','N',5,'D222','CRRR'),
('C111','24 Elm Street','2025-02-19','17:00:00','18:00:00','N',4,'D222','CE66'),
('C122','5 Oxford Street','2024-11-21','18:15:00','18:59:00','N',5,'D222','CK78'),
('C133','29 Western Road','2025-02-21','17:00:00','19:50:00','N',1,'D333','CK78'),
('C144','2 Ridout Street','2025-01-01','17:30:00',NULL,'Y',NULL,NULL,'CIT4'),
('C155','20 Main Street','2025-02-02','17:30:00','17:50:00','N',5,'D333','CRRR');
SELECT * FROM cusorder;

-- insert into the overall order table
SELECT * FROM overallorder;
INSERT INTO overallorder (orderid, menuitemid, quantity) VALUES
('C100','MBBB',4),('C100', 'MCCC', 2),
('C111','MAAA',3 ),('C111','MEEE',5),
('C122','MCCC',1 ),
('C133','MBBB',1),('C133','MEEE',2),('C133','MAAA',2),('C133','MHHH',1),
('C144','MHHH',3),
('C155','MEEE',3),('C155','MHHH',2),('C155','MCCC',4);
SELECT * FROM overallorder;
