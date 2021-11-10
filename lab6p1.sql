
--1a

SELECT * FROM dealer CROSS JOIN client;

--1b
SELECT dealer.name as dealer_name,client.name as client_name, client.priority as grade,sell.id as sell_number,date,amount
FROM dealer INNER JOIN client ON client.dealer_id=dealer.id INNER JOIN sell ON client.id = sell.client_id;

--1c
SELECT dealer.name as dealer_name,client.name as client_name
FROM dealer INNER JOIN client ON dealer.location=client.city;

--1d
SELECT sell.id as sell_id,amount,client.name as client_name,city
FROM sell INNER JOIN client ON sell.client_id=client.id
WHERE amount >=100 AND amount <= 500;

--1e
SELECT * FROM dealer LEFT JOIN client ON dealer.id=client.dealer_id;

--1f
SELECT client.name as "name",client.city,dealer.name as "dealer", dealer.charge as "commission"
FROM dealer INNER JOIN client ON dealer.id = client.dealer_id;

--1g
SELECT client.name as "name",client.city,dealer.name as "dealer", dealer.charge as "commission"
FROM dealer INNER JOIN client ON dealer.id = client.dealer_id WHERE dealer.charge>0.12;

--1h
SELECT client.name as client_name,client.city as client_city,sell.id as sell_id, sell.date as sell_date,sell.amount as sell_amount,dealer.name as dealer_name,dealer.charge as comission
FROM client LEFT OUTER JOIN sell ON client.id = sell.client_id LEFT OUTER JOIN dealer on dealer.id = sell.dealer_id;

--1i
SELECT client.name as "client name",client.priority as "grade",dealer.name as "dealer_name", sell.id as "sell_id",sell.amount as "sell_amount"
    FROM client LEFT OUTER JOIN sell ON client.id = sell.client_id LEFT OUTER JOIN dealer on dealer.id = sell.dealer_id
    WHERE sell.amount >= 2000;