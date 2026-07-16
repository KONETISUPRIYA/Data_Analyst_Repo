CREATE TABLE customers(
customer_id INT primary key,
customer_name varchar(50),
city varchar(30),
account_type varchar(20)
);
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    balance DECIMAL(10,2),
    branch VARCHAR(50)
);
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_date DATE,
    transaction_amount DECIMAL(10,2),
    transaction_type VARCHAR(20)
);
USE bank_analysis;
insert into customers values(1,'Rahul','banglore','Savings');
insert into customers values(2,'Priya','Hyderabad','Current');
insert into customers values(3,'Arjun','chennai','Savings');
insert into customers values(4,'Sneha','Mumbai','Current');
insert into customers values(5,'Kiran','pune','Savings');
insert into customers values(6,'Anjali','Delhi','Savings');
insert into customers values(7,'Vikram','banglore','current');
insert into customers values(8,'Neha','Hyderabad','Savings');
insert into customers values(9,'Rohit','Chennai','Current');
insert into customers values(10,'Pooja','Mumbai','Savings');

USE bank_analysis;
insert into accounts values(101,1,50000,'Banglore');
insert into accounts values(102,2,75000,'Hyderabad');
insert into accounts values(103,3,62000,'Chennai');
insert into accounts values(104,4,88000,'Mumbai');
insert into accounts values(105,5,45000,'pune');
insert into accounts values(106,6,55000,'delhi');
insert into accounts values(107,7,92000,'Banglore');
insert into accounts values(108,8,47000,'Hyderabad');
insert into accounts values(109,9,87000,'Chennai');
insert into accounts values(110,10,69000,'mumbai');

USE bank_analysis;
insert into transactions values(1001,101,DATE '2021-01-05',5000,'Deposit');
insert into transactions values(1002,101,DATE '2021-01-08',2000,'Withdraw');
insert into transactions values(1003,102,DATE '2021-01-10',10000,'Deposit');
insert into transactions values(1004,103,DATE '2021-01-12',3000,'Withdraw');
insert into transactions values(1005,104,DATE '2021-01-15',7000,'Deposit');
insert into transactions values(1006,105,DATE '2021-01-18',2500,'Withdraw');
insert into transactions values(1007,106,DATE '2021-01-20',6000,'Deposit');
insert into transactions values(1008,107,DATE '2021-01-22',4000,'withdraw');
insert into transactions values(1009,108,DATE '2021-01-25',8000,'Deposit');
insert into transactions values(1010,109,DATE '2021-01-28',3500,'Withdaw');
insert into transactions values(1011,110,DATE '2021-01-30',9000,'Deposit');

-- Queries

-- 1.Total Customers
select count(*) as total_customers
from customers;

-- 2. total bank balance

select sum(balance) as total_balance
from accounts;

-- 3. average customer balance

select round(Avg(balance),2) as average_balance
from accounts;

-- 4. highest customer balance

select max(balance) as Highest_balance
from accounts;

-- 5. branch-wise total balance

select branch,sum(balance) as total_balance
from accounts
group by branch
order by total_balance DESC;

SHOW tables;

-- 6. Branch-wise customer count

select branch,count(*) as customer_count
from accounts
group by branch
order by customer_count DESC;

-- 7. Deposit vs Withdrawl count

select transaction_type,count(*) as transaction_count
from transactions
group by transaction_type;

-- 8. Deposit vs withdrawl amount 

select transaction_type,sum(transaction_amount) as total_amount
from transactions
group by transaction_type;

-- 9 . Customer name with balance

select c.customer_name,a.balance
from customers c
join accounts  a
ON c.customer_id = a.customer_id;

-- 10. Customer,Branch,Balance (Richest Customer)

select c.customer_name,a.branch,a.balance
from customers c
join accounts a
ON c.customer_id = a.customer_id
Order By a.balance DESC;

-- 11. Customer Transaction History

select c.customer_name,t.transaction_type,t.transaction_amount
from customers c
join accounts a
ON c.customer_id = a.customer_id
Join transactions t
ON a.account_id=t.account_id;

-- Subquery section

-- 12. Second Highest Balance

select max(balance) from accounts
where balance<(select max(balance) from accounts);

-- 13. Customers above average balance

select customer_id,balance
from accounts
where balance>(select avg(balance)
from accounts);

-- 14. branch with highest total balance

select branch,sum(balance) total_balance
from accounts
group by branch
having sum(balance)=(select max(total_balance)
from (select sum(balance) as total_balance
from accounts
group by branch) t
);
