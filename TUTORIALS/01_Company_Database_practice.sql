create  schema Company_Database;

-- 1. create employee table

CREATE TABLE company_database.Employee (
    emp_id  INT PRIMARY KEY UNIQUE, 
    first_name varchar(100), 
    last_name varchar (50) , 
    birth_date DATE, 
    sex varchar(1), 
    salary INTEGER, 
    super_id INTEGER, 
    BRANCH_ID INTEGER, 
   
    FOREIGN KEY (super_id)
        REFERENCES company_database.employee(emp_id)
        ON DELETE SET NULL
);

-- 2. create branch table
create table company_database.branch (
	branch_id INT primary key, 
	branch_name VARCHAR(50) not null, 
	mgr_id INT references company_database.employee(emp_id) on delete set null,
	mgr_start_date DATE,
	  FOREIGN KEY (branch_id)
        REFERENCES company_database.branch(branch_id)
        ON DELETE SET NULL
);

 -- 3. create client table
create table company_database.client (
	client_id int primary key, 
	client_name varchar(100),
	branch_id int references company_database.branch(branch_id) on delete set null
);

-- 4. create works_with table

create table company_database.works_with (
	emp_id int, 
	client_id int, 
	total_sales integer, 
	primary key (emp_id,client_id),
	foreign key(emp_id) references company_database.employee(emp_id) on delete cascade ,
	foreign key(client_id) references company_database.client(client_id) on delete cascade
);

--5. create branch supplier table
create table company_database.branch_supplier (
	branch_id int, 
	supplier_name varchar(50),
	supply_type varchar(50), 
	primary key (branch_id, supplier_name),
	foreign key (branch_id) references company_database.branch(branch_id) on delete cascade
);

====================================================================
-- Insert data into tables -------------
====================================================

-- INSERT DATA INTO EMPLOYEE TABLE
insert into company_database.employee values
	(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, 1), 
	(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1), 
	(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, 2), 
	(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2), 
	(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2), 
	(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2), 
	(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, 3), 
	(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3), 
	(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- INSERT DATA INTO BRANCH TABLE
insert into company_database.branch values
	(1, 'Corporate', 100, '2006-02-09'), 
	(2, 'Scranton', 102, '1992-04-06'), 
	(3, 'Stamford', 106, '1998-02-13');

-- INSERT DATA INTO CLIENT TABLE
insert into company_database.client values
	(400, 'Dunmore Highschool', 2),
	(401, 'Lackawana Country', 2), 
	(402, 'FedEX', 3), 
	(403, 'John Daly Law, LLC', 3), 
	(404, 'Scranton Whitepages', 2), 
	(405, 'Times Newspaper', 3), 
	(406, 'FedEx', 2);

-- INSERT DATA INTO WORKS_WITH TABLE
insert into company_database.works_with values
	(105, 400, 55000), 
	(102, 401, 267000), 
	(108, 402, 22500), 
	(107, 403, 5000), 
	(108, 403, 12000), 
	(105, 404, 33000), 
	(107, 405, 26000), 
	(102, 406, 15000), 
	(105, 406, 130000);

-- INSERT DATA INTO BRANCH_SUPPLIER TABLE
insert into company_database.branch_supplier values
	(2, 'Hammer Mill', 'Paper'), 
	(2, 'Uni-ball', 'Writing Utensils'), 
	(3, 'Patriot Paper', 'Paper'), 
	(2, 'J.T.Forms & Labels', 'Custom Forms'), 
	(3, 'Uni-ball', 'Writing Utensils'), 
	(3, 'Hammer Mill', 'Paper'), 
	(3, 'Stamford', 'Custom Forms');

 update company_database.branch_supplier 
 set supplier_name = 'Stamford Labels'
 where supplier_name = 'Stamford';

===================================================================

-- BASIC QUERIES----------------------------

====================================================================

--FIND ALL EMPLOYEES
select * 
from company_database.employee;

-- FIND ALL CLIENTS
select * 
from company_database.client;

--FIND ALL EMPLOYEES ORDERED BY SALARY
select * 
from company_database.employee 
order by salary; 

-- FIND ALL EMPLOYEES ORDER NY SEX THEN NAME
select * 
from company_database.employee 
order by sex, first_name, last_name;

-- FIND THE FIRST 5 EMPLOYEES IN THE TABLE
select * 
from company_database.employee 
order by emp_id asc limit 5;

--FIND THE FIRST AND LAST NAMES OF ALL EMPLOYEES
select first_name, last_name 
from company_database.employee;

-- FIND THE FORENAME AND SURNAMES OF ALL EMPLOYEES
select first_name as forename, last_name as surname 
from company_database.employee; 

--FIND ALL THE DIFFERENT GENDERS
select distinct sex as gender 
from company_database.employee; 

--FIND THE NUMBER OF EMPLOYEES
select COUNT(emp_id) 
from company_database.employee;

--FIND THE NUMBER OF EMPLOYEES HAVE SUPER_ID
select COUNT(super_id) 
from company_database.employee;

--FIND THE NUMBER OF FEMALE EMPLOYEE BORN AFTER 1970
select COUNT(emp_id) 
from company_database.employee 
where sex = 'F' and birth_date > '1971-01-01';

--FIND THE AVG OF ALL EMPLOYEE SALARIES
select avg(salary)
from company_database.employee;

--FIND THE SUM OF ALL EMPLOYEE SALARIES
select SUM(salary) 
from company_database.employee;

-- FIND HOW MANY MALES AND FEMALES THERE ARE
select COUNT(sex),sex 
from company_database.employee 
group by sex;

--FIND THE TOTAL SALES OF EACH SALESMAN
select SUM(total_sales), emp_id 
from company_database.works_with 
group by emp_id 
order by emp_id;

--FIND THE TOTAL SALES OF EACH CLIENT
select SUM(total_sales), client_id 
from company_database.works_with 
group by client_id
order by client_id;


--FIND ANY CLIENT 's WHO ARE AN LLC
select * 
from company_database.client 
where client_name LIKE '%LLC%';

--FIND ANY BRANCH SUPPLIERS WHO ARE IN THE LABEL BUSINESS
 select * 
from company_database.branch_supplier 
where supplier_name LIKE '%Label%';

--FIND ANY EMPLOYEE BORN IN OCTOBER
select *
from company_database.employee 
where EXTRACT(month from birth_date) = 10;

--FIND A LIST OF EMPLOYEE AND BRANCH NAME
select e.first_name, e.last_name, b.branch_name 
from company_database.employee e 
join company_database.branch b 
on e.branch_id = b.branch_id;

-- FIND TEH LIST OF ALL CLIENT &  BRANCH SUPPLIER NAMEs
select c.client_name, bs.supplier_name 
from company_database.client c 
join company_database.branch_supplier bs 
on c.branch_id = bs.branch_id;

--FIND A LIST OF ALL MONEY SPENT OR EARNED BY THE COMPANY
select 
	SUM(e.salary) as total_salary_spent, 
	SUM(w.total_sales)  as total_sales_earned
from company_database.employee e 
join company_database.works_with w
on e.emp_id = w.emp_id;

--FIND ALL BRANCHES AND THEIR MANAGER NAMES
select b.branch_name, e.first_name as manager_name
from company_database.branch b
join company_database.employee e 
on b.mgr_id = e.emp_id;

--FIND NAMES OF ALL EMPLOYEE WHO HAVE
--SOLD OVER 30,000 TO A SINGLE CLIENT
select e.first_name, c.client_name 
from company_database.employee e 
join company_database.works_with w 
on e.emp_id = w.emp_id
join company_database.client c 
on w.client_id = c.client_id
where total_sales > 30000;

--FIND ALL CLIENTS WHO ARE HANDLED BY THE BRANCH
--THAT MICHAEL SCOTT MANAGES
--ASSUME YOU KNOW MKICHAEL's ID
--1ST METHOD
select c.client_name 
from company_database.client c 
where c.branch_id = (
	select b.branch_id 
	from company_database.branch b
	where b.mgr_id = 102
	limit 1
);
=====================0R==========================
-- 2ND METHOD
select c.client_name  
from company_database.client c 
join company_database.branch b 
on c.branch_id = b.branch_id 
where b.mgr_id = 102; 
