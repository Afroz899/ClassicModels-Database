-- Prepare a list of offices sorted by country, state, city.
SELECT * FROM classicmodels.offices
order by country,state,city;

-- How many employees are there in the company?
select count(*) as 'number_of_employees' from employees;

-- What is the total of payments received?
Select count(checknumber) as Number_of_payments , round(sum(amount) ,2)as total_payments  from payments;

-- List the product lines that contain 'Cars'.
select * from Products where productline = 'Classic Cars';

-- Report total payments for October 28, 2004.
select  amount as total_payment from payments where paymentdate = '2004-10-28';

-- Report those payments greater than $100,000.
select * from payments where amount > 100000 ;

-- List the products in each product line.
select productline ,productName  from products order by productLine ;

-- How many products in each product line?

select productline , count(productName) as Number_of_products from Products
group by productline;

-- What is the minimum payment received?
select * from  payments order by amount asc limit 1;

-- List all payments greater than twice the average payment.
Select * from payments where amount > 2 * (select avg(amount) from payments) ;

--  What is the average percentage markup of the MSRP on buyPrice?
Select  avg((MSRP-buyPrice/MSRP)*100) as average_percentage_markup from products ;
 
 -- How many distinct products does ClassicModels sell?
select count(distinct productName ) from products;

-- Report the name and city of customers who don't have sales representatives?
Select customerName , city from customers where salesRepemployeeNumber is null; 

-- What are the names of executives with VP or Manager in their title? 
-- Use the CONCAT function to combine the employee's first name and last name into a single field for reporting.
Select  concat(firstName,' ' , lastName) as FullName , jobTitle From employees where jobtitle like '%VP%';
Select concat(firstName,' ' , lastName) as FullName   From employees where jobtitle like   '%Manager%' ;

-- Which orders have a value greater than $5,000?
SELECT orderNumber,sum(priceEach*quantityOrdered)
from orderdetails
group by orderNumber
having sum(priceEach*quantityOrdered) > 5000
order by sum(priceEach*quantityOrdered);

--  Retrieve details of all the customers in the United States who have made payments between April 1st 2003 and March 31st 2004.
Select * from customers
 where country = 'USA' 
 and 
 customerNumber
 in 
 (Select customerNumber from payments
 where paymentdate  
 between '2003-04-01' and '2004-03-31'
) ;

-- Determine the total number of units sold for each product ???
SELECT productLine , count(*) as Number_of_product FROM classicmodels.products  group by productLine;
-- Find the total no. of payments and total payment amount for each customer for payments made before October 28, 2004.
SELECT customerNumber, 
  COUNT(*) as numberOfPayments,  
  SUM(amount) as totalPayment 
  FROM payments 
  WHERE paymentDate<"2004-10-28" 
  GROUP BY customerNumber;
  -- Modify the above query to also show the minimum, maximum and average payment value for each customer.???
SELECT customerNumber, 
  COUNT(*) as numberOfPayments,  
  min(amount),
  max(amount),
  avg(amount),
  SUM(amount) as totalPayment 
  FROM payments 
  WHERE paymentDate<"2004-10-28" 
  GROUP BY customerNumber;
  
  -- ( Display the product code, product name, buy price,
  -- sale price and profit margin percentage ((MSRP - buyPrice)*100/buyPrice) for the 10 products with the highest profit margin.
  -- Round the profit margin to 2 decimals.)
  Select productCode ,
        ProductName , 
        BuyPrice , 
        MSRP as SalesPrice , 
       round(((MSRP - buyPrice)*100/buyPrice) )as product_Margin
 from products
order by product_Margin desc  limit 10;

-- Show the total payments received month by month for every year.
select round(sum(amount) ,2),
       month(paymentDate) as `Month` ,
       year(paymentDate) as `Year`
from payments
group by  `Year` ,`month`
order by  `Year` ,`month`;

-- For the above query, format the amount properly with a dollar symbol and comma separation (e.g $26,267.62), and also show the month as a string.
select concat('$',FORMAT(sum(amount) ,2)) as `total_amount`,
       Date_format(paymentDate , '%b') as `Month` ,
       year(paymentDate) as `Year`
from payments
group by  `Year` ,`month`
order by  `Year` ,`month`;




