
--1a--

SELECT * FROM dealer CROSS JOIN client;

--1b--
SELECT dealer.name as dealer_name,client.name as client_name, client.priority as grade,sell.id as sell_number,date,amount
FROM dealer INNER JOIN client ON client.dealer_id=dealer.id INNER JOIN sell ON client.id = sell.client_id;

--1c--
SELECT dealer.name as dealer_name,client.name as client_name
FROM dealer INNER JOIN client ON dealer.location=client.city;

--1d--
SELECT sell.id as sell_id,amount,client.name as client_name,city
FROM sell INNER JOIN client ON sell.client_id=client.id
WHERE amount >=100 AND amount <= 500;

--1e--
SELECT * FROM dealer LEFT JOIN client ON dealer.id=client.dealer_id;

--1f--
SELECT client.name as "name",client.city,dealer.name as "dealer", dealer.charge as "commission"
FROM dealer INNER JOIN client ON dealer.id = client.dealer_id;

--1g--
SELECT client.name as "name",client.city,dealer.name as "dealer", dealer.charge as "commission"
FROM dealer INNER JOIN client ON dealer.id = client.dealer_id WHERE dealer.charge>0.12;

--1h--
SELECT client.name as client_name,client.city as client_city,sell.id as sell_id, sell.date as sell_date,sell.amount as sell_amount,dealer.name as dealer_name,dealer.charge as comission
FROM client LEFT OUTER JOIN sell ON client.id = sell.client_id LEFT OUTER JOIN dealer on dealer.id = sell.dealer_id;

--1i--
SELECT client.name as "client name",client.priority as "grade",dealer.name as "dealer_name", sell.id as "sell_id",sell.amount as "sell_amount"
    FROM client LEFT OUTER JOIN sell ON client.id = sell.client_id LEFT OUTER JOIN dealer on dealer.id = sell.dealer_id
    WHERE sell.amount >= 2000;
    --2a--
CREATE VIEW a AS
SELECT date, count(c.id), avg(amount), sum(amount)
FROM sell
LEFT JOIN client c on c.id = sell.client_id
GROUP BY date;

SELECT * from a;
--DROP VIEW a;
--2b--
CREATE VIEW b as
SELECT date,sum
FROM a
ORDER BY sum DESC limit 5;

SELECT * from b;
DROP VIEW b;
--2c--
CREATE VIEW c AS
    SELECT dealer.name as "dealer",COUNT(sell.id) as "number_of_salss",AVG(amount) as "average",SUM(amount) as "total"
    FROM dealer INNER JOIN sell ON dealer.id=sell.dealer_id
    GROUP BY dealer.id;

SELECT * from c;
DROP VIEW c;

--2d--
CREATE VIEW d AS
    SELECT location,SUM(charge*amount)
    FROM dealer INNER JOIN sell ON dealer.id = sell.dealer_id
    GROUP BY location;

SELECT * from d;
DROP VIEW d;
--2e--
CREATE VIEW e AS
    SELECT location,COUNT(sell.id) as "number_of_sales",AVG(amount) as "average",SUM(amount) as "total"
    FROM dealer INNER JOIN sell ON dealer.id=sell.dealer_id
    GROUP BY location;

SELECT * from e;
--DROP VIEW e;

--2f--
CREATE VIEW f AS
    SELECT city,COUNT(sell.id) as "number_of_sales",AVG(amount) as "average",SUM(amount) as "total"
    FROM client INNER JOIN sell ON client.id=sell.client_id
    GROUP BY city;

SELECT * from f;
--DROP VIEW f;
--2g--
CREATE VIEW g AS
    SELECT *
    FROM e INNER JOIN f on e.location = f.city
    WHERE f.total>e.total;

SELECT * from g;
DROP VIEW g;