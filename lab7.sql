CREATE table customers (
    id integer primary key,
    name varchar(255),
    birth_date date
);

create table accounts(
    account_id varchar(40) primary key ,
    customer_id integer references customers(id),
    currency varchar(3),
    balance float,
    "limit" float
);

create table transactions (
    id serial primary key ,
    date timestamp,
    src_account varchar(40) references accounts(account_id),
    dst_account varchar(40) references accounts(account_id),
    amount float,
    status varchar(20)
);

INSERT INTO customers VALUES (201, 'John', '2021-11-05');
INSERT INTO customers VALUES (202, 'Anny', '2021-11-02');
INSERT INTO customers VALUES (203, 'Rick', '2021-11-24');

INSERT INTO accounts VALUES ('NT10204', 201, 'KZT', 1000, null);
INSERT INTO accounts VALUES ('AB10203', 202, 'USD', 100, 0);
INSERT INTO accounts VALUES ('DK12000', 203, 'EUR', 500, 200);
INSERT INTO accounts VALUES ('NK90123', 201, 'USD', 400, 0);
INSERT INTO accounts VALUES ('RS88012', 203, 'KZT', 5000, -100);

INSERT INTO transactions VALUES (1, '2021-11-05 18:00:34.000000', 'NT10204', 'RS88012', 1000, 'commited');
INSERT INTO transactions VALUES (2, '2021-11-05 18:01:19.000000', 'NK90123', 'AB10203', 500, 'rollback');
INSERT INTO transactions VALUES (3, '2021-06-05 18:02:45.000000', 'RS88012', 'NT10204', 400, 'init');
--Task1
--Large objects (photos, videos, CAD files, etc.) are stored as a large object:
-- •blob: binary large object -- object is a large collection of uninterpreted
-- binary data (whose interpretation is left to an application outside of the database system)•
-- clob: character large object
-- object is a large collection of character data

--Task2
--You can give users access to tables. These privileges can be any combination
--of SELECT, INSERT, UPDATE, DELETE, REFERENCES, ALTER, INDEX, or others
--A role is  a way to distinguish among various users as far as what
--these users can access/update in the database.
--A user is a database level security principal.
--Logins must be mapped to a database user to connect to a database.

--2.1
create role accountant;
create role administrator;
create role support;
grant select on accounts, transactions to accountant;
grant update on transactions to accountant;
grant delete on transactions to accountant;
grant all privileges on accounts, customers, transactions to administrator;
grant select on accounts, customers, transactions to support;

--2.2
create user student;
grant accountant to student;

create user professor;
grant administrator to professor;

--2.3
grant support to accountant;

--2.4
revoke select on transactions from student;

--Task3
alter table accounts
add constraint acc_con check (accounts.currency is not null);

--Task5
--5.1
create unique index acc_ind on accounts(account_id, currency);
--5.2
create index acc_tran on accounts(currency, balance);

--Task6
begin;

create view task6 as
    select src_account,dst_account,amount,status
    from transactions
    where transactions.status='init';

create view task62 as
    select transactions.src_account,transactions.dst_account,accounts.balance+ transactions.amount as now
    from transactions,accounts
    where transactions.status='init' and transactions.dst_account = accounts.account_id;

create view task622 as
    select transactions.src_account,transactions.dst_account,accounts.balance- transactions.amount as now
    from transactions,accounts
    where transactions.status='init' and transactions.src_account = accounts.account_id;

update transactions
set status='commited'
where status='init';

rollback;

commit;