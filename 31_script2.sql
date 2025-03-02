USE assign2db;

-- Part 1 SQL Updates
SELECT * FROM menuitem;
SELECT * FROM cusorder;
SELECT * FROM driver;

UPDATE menuitem
SET dishname = 'Pasta alla Norma', veggie = 'Y'
WHERE dishname = 'Pasta alla Brenda';

UPDATE cusorder
JOIN driver ON cusorder.driverid = driver.driverid
SET deliveryrating = 3
WHERE driver.firstname = 'Marge';

SELECT * FROM menuitem;
SELECT * FROM cusorder;

-- Part 2 SQL Inserts
INSERT INTO customer(cusid, firstname, lastname, cellnum)
VALUES('CXYZ','Homer','Simpson','1112223333');

INSERT INTO driver(driverid, firstname, lastname, cellnum)
VALUES('DXYZ','Bart','Simpson','9998887777');

INSERT INTO menuitem(menuitemid, dishname, price, caloriecount, veggie)
VALUES('MXYZ','Taco Supreme',5.99,450,'N');

INSERT INTO cusorder(orderid, deladdress, dateplaced, timeplaced, timedelivered,
                     pickuporder, deliveryrating, driverid, cusid)
VALUES('O555','742 Evergreen','2025-05-12','18:00:00','19:00:00','N',5,'DXYZ','CXYZ');

INSERT INTO overallorder(orderid, menuitemid, quantity)
VALUES('O555','MXYZ',3);

SELECT * FROM customer;
SELECT * FROM driver;
SELECT * FROM menuitem;
SELECT * FROM cusorder;
SELECT * FROM overallorder;

-- Part 3 SQL Queries
SELECT lastname FROM driver;
SELECT DISTINCT lastname FROM driver;
SELECT * FROM menuitem ORDER BY caloriecount;
SELECT dishname, caloriecount, price
FROM menuitem
WHERE veggie='Y'
ORDER BY price;
SELECT c.orderid, c.deladdress, c.deliveryrating
FROM cusorder c
JOIN driver d ON c.driverid = d.driverid
WHERE d.lastname='Simpson';
SELECT d.firstname, d.lastname
FROM driver d
LEFT JOIN cusorder c ON d.driverid = c.driverid
WHERE c.orderid IS NULL;
SELECT cu.firstname AS cusF, cu.lastname AS cusL,
       co.orderid, co.dateplaced,
       dr.firstname AS drvF, dr.lastname AS drvL
FROM cusorder co
LEFT JOIN customer cu ON co.cusid = cu.cusid
LEFT JOIN driver dr ON co.driverid = dr.driverid;
SELECT co.orderid, co.dateplaced, m.dishname, m.price, o.quantity
FROM cusorder co
JOIN overallorder o ON co.orderid = o.orderid
JOIN menuitem m ON o.menuitemid = m.menuitemid
ORDER BY co.orderid;
SELECT d.firstname, d.lastname, COUNT(c.orderid) AS numDelivered
FROM driver d
LEFT JOIN cusorder c ON d.driverid = c.driverid
GROUP BY d.driverid
ORDER BY numDelivered DESC;
SELECT co.orderid, m.dishname, o.quantity,
       CONCAT('$', FORMAT(m.price,2)) AS `Unit Price`,
       CONCAT('$', FORMAT(m.price*o.quantity,2)) AS `Total Cost For This Item`
FROM cusorder co
JOIN overallorder o ON co.orderid = o.orderid
JOIN menuitem m ON o.menuitemid = m.menuitemid
WHERE co.deladdress = '20 Main Street'
ORDER BY co.orderid;
SELECT cu.firstname, cu.lastname, co.orderid, m.dishname
FROM cusorder co
JOIN overallorder o ON co.orderid = o.orderid
JOIN menuitem m ON o.menuitemid = m.menuitemid
JOIN customer cu ON co.cusid = cu.cusid
GROUP BY co.orderid, m.menuitemid
HAVING SUM(CASE WHEN m.veggie='N' THEN 1 ELSE 0 END)=0;
SELECT c.firstname, c.lastname, MAX(totalSpent) AS maxSpent
FROM (
  SELECT co.cusid, SUM(m.price*o.quantity) AS totalSpent
  FROM cusorder co
  JOIN overallorder o ON co.orderid = o.orderid
  JOIN menuitem m ON o.menuitemid = m.menuitemid
  GROUP BY co.orderid
) AS sub
JOIN customer c ON c.cusid = sub.cusid;
SELECT d.firstname, d.lastname
FROM driver d
LEFT JOIN cusorder co ON d.driverid = co.driverid
LEFT JOIN overallorder oo ON co.orderid = oo.orderid
LEFT JOIN menuitem mi ON oo.menuitemid = mi.menuitemid
WHERE mi.dishname = 'Beef Lasagna'
GROUP BY d.driverid
HAVING COUNT(co.orderid)=0 OR COUNT(mi.menuitemid)=0;
SELECT m.dishname, m.menuitemid, COUNT(DISTINCT o.orderid) AS numOrders, SUM(o.quantity) AS totalQty
FROM overallorder o
JOIN menuitem m ON o.menuitemid = m.menuitemid
GROUP BY m.menuitemid
HAVING totalQty>=6
ORDER BY totalQty DESC;
SELECT co.orderid, co.deliveryrating, dr.firstname AS drvF, dr.lastname AS drvL
FROM cusorder co
JOIN driver dr ON co.driverid = dr.driverid
WHERE co.deliveryrating>=4
ORDER BY co.deliveryrating DESC;

-- Part 4 SQL Views/Deletes
CREATE VIEW mydriverinfo AS
SELECT d.driverid, d.firstname, d.lastname,
       co.orderid, co.timeplaced, co.timedelivered, co.deliveryrating
FROM driver d
JOIN cusorder co ON d.driverid = co.driverid
WHERE co.deliveryrating IS NOT NULL;

SELECT driverid, orderid, timeplaced, timedelivered, deliveryrating
FROM mydriverinfo
WHERE TIMESTAMPDIFF(MINUTE, timeplaced, timedelivered)<=60;

SELECT * FROM driver;

DELETE FROM driver WHERE driverid='D666';
SELECT * FROM driver;

DELETE FROM driver WHERE driverid='D333';
SELECT * FROM driver;

