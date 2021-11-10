--2a
CREATE VIEW a AS
SELECT date, count(c.id), avg(amount), sum(amount)
FROM sell
LEFT JOIN client c on c.id = sell.client_id
GROUP BY date;

SELECT * from a;
--DROP VIEW a;
--2b
CREATE VIEW b as
SELECT date,sum
FROM a
ORDER BY sum DESC limit 5;

SELECT * from b;
DROP VIEW b;
--2c
CREATE VIEW c AS
    SELECT dealer.name as "dealer",COUNT(sell.id) as "number_of_salss",AVG(amount) as "average",SUM(amount) as "total"
    FROM dealer INNER JOIN sell ON dealer.id=sell.dealer_id
    GROUP BY dealer.id;

SELECT * from c;
DROP VIEW c;

--2d
CREATE VIEW d AS
    SELECT location,SUM(charge*amount)
    FROM dealer INNER JOIN sell ON dealer.id = sell.dealer_id
    GROUP BY location;

SELECT * from d;
DROP VIEW d;
--2e
CREATE VIEW e AS
    SELECT location,COUNT(sell.id) as "number_of_sales",AVG(amount) as "average",SUM(amount) as "total"
    FROM dealer INNER JOIN sell ON dealer.id=sell.dealer_id
    GROUP BY location;

SELECT * from e;
--DROP VIEW e;

--2f
CREATE VIEW f AS
    SELECT city,COUNT(sell.id) as "number_of_sales",AVG(amount) as "average",SUM(amount) as "total"
    FROM client INNER JOIN sell ON client.id=sell.client_id
    GROUP BY city;

SELECT * from f;
--DROP VIEW f;
--2g
CREATE VIEW g AS
    SELECT *
    FROM e INNER JOIN f on e.location = f.city
    WHERE f.total>e.total;

SELECT * from g;
DROP VIEW g;