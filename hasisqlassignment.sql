CREATE TABLE SALESPEOPLE (
    SNUM INT PRIMARY KEY,
    SNAME VARCHAR(50),
    CITY VARCHAR(50),
    COMM DECIMAL(3,2)
);

INSERT INTO SALESPEOPLE (SNUM, SNAME, CITY, COMM) VALUES
(1001, 'Peel', 'London', 0.12),
(1002, 'Serres', 'San Jose', 0.13),
(1004, 'Motika', 'London', 0.11),
(1007, 'Rafkin', 'Barcelona', 0.15),
(1003, 'Axelrod', 'New York', 0.10);

CREATE TABLE CUST (
    CNUM INT PRIMARY KEY,
    CNAME VARCHAR(50),
    CITY VARCHAR(50),
    RATING INT,
    SNUM INT,
    FOREIGN KEY (SNUM) REFERENCES SALESPEOPLE(SNUM)
);

INSERT INTO CUST (CNUM, CNAME, CITY, RATING, SNUM) VALUES
(2001, 'Hoffman', 'London', 100, 1001),
(2002, 'Giovanne', 'Rome', 200, 1003),
(2003, 'Liu', 'San Jose', 300, 1002),
(2004, 'Grass', 'Brelin', 100, 1002),
(2006, 'Clemens', 'London', 300, 1007),
(2007   , 'Pereira', 'Rome', 100, 1004);

CREATE TABLE ORDERS (
    ONUM INT PRIMARY KEY,
    AMT DECIMAL(10,2),
    ODATE DATE,
    CNUM INT,
    SNUM INT,
    FOREIGN KEY (CNUM) REFERENCES CUST(CNUM),
    FOREIGN KEY (SNUM) REFERENCES SALESPEOPLE(SNUM)
);


INSERT INTO CUST (CNUM, CNAME, CITY, RATING, SNUM) VALUES
(2008, 'Smith', 'Barcelona', 250, 1007);

INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES
(3001, 18.69, TO_DATE('03-OCT-1994', 'DD-MON-YYYY'), 2008, 1007),
(3003, 767.19, TO_DATE('03-OCT-1994', 'DD-MON-YYYY'), 2001, 1001),
(3002, 1900.10, TO_DATE('03-OCT-1994', 'DD-MON-YYYY'), 2007, 1004),
(3005, 5160.45, TO_DATE('03-OCT-1994', 'DD-MON-YYYY'), 2003, 1002),
(3006, 1098.16, TO_DATE('04-OCT-1994', 'DD-MON-YYYY'), 2008, 1007),
(3009, 1713.23, TO_DATE('04-OCT-1994', 'DD-MON-YYYY'), 2002, 1003),
(3007, 75.75, TO_DATE('05-OCT-1994', 'DD-MON-YYYY'), 2004, 1002),
(3008, 4723.00, TO_DATE('05-OCT-1994', 'DD-MON-YYYY'), 2006, 1001),
(3010, 1309.95, TO_DATE('06-OCT-1994', 'DD-MON-YYYY'), 2004, 1002),
(3011, 9891.88, TO_DATE('06-OCT-1994', 'DD-MON-YYYY'), 2006, 1001);

select * from cust;

select * from orders;

delete from cust where city='Barcelona' and cname='Smith';

--1.Display snum,sname,city and comm of all salespeople.
Select snum, sname, city, comm
from salespeople;   

--2.Display all snum without duplicates from all orders.
Select distinct snum 
from orders; 

-- 3. Display names and commissions of all salespeople in London.
SELECT SNAME, COMM FROM SALESPEOPLE WHERE CITY = 'London';

-- 4. All customers with a rating of 100.
SELECT * FROM CUST WHERE RATING = 100;

-- 5. Produce order number, amount, and date from all rows in the order table.
SELECT ONUM, AMT, ODATE FROM ORDERS;

-- 6. All customers in San Jose, who have a rating more than 200.
SELECT * FROM CUST WHERE CITY = 'San Jose' AND RATING > 200;

-- 7. All customers who were either located in San Jose or had a rating above 200.
SELECT * FROM CUST WHERE CITY = 'San Jose' OR RATING > 200;

-- 8. All orders for more than $1000.
SELECT * FROM ORDERS WHERE AMT > 1000;

-- 9. Names and cities of all salespeople in London with commission above 0.10.
SELECT SNAME, CITY FROM SALESPEOPLE WHERE CITY = 'London' AND COMM > 0.10;

-- 10. All customers excluding those with rating <= 100 unless they are located in Rome.
SELECT * FROM CUST WHERE RATING > 100 OR CITY = 'Rome';

-- 11. All salespeople either in Barcelona or in London.
SELECT * FROM SALESPEOPLE WHERE CITY IN ('Barcelona', 'London');

-- 12. All salespeople with commission between 0.10 and 0.12 (Boundary values should be excluded).
SELECT * FROM SALESPEOPLE WHERE COMM > 0.10 AND COMM < 0.12;

-- 13. All customers with NULL values in the city column.
SELECT * FROM CUST WHERE CITY IS NULL;

-- 14. All orders taken on Oct 3rd and Oct 4th, 1994.
SELECT * FROM ORDERS WHERE ODATE IN (TO_DATE('03-OCT-1994', 'DD-MON-YYYY'), TO_DATE('04-OCT-1994', 'DD-MON-YYYY'));

-- 15. All customers serviced by Peel or Motika.
SELECT * FROM CUST WHERE SNUM IN (SELECT SNUM FROM SALESPEOPLE WHERE SNAME IN ('Peel', 'Motika'));

-- 16. All customers whose names begin with a letter from A to B.
SELECT * FROM CUST WHERE CNAME LIKE 'A%' OR CNAME LIKE 'B%';

-- 17. All orders except those with 0 or NULL value in amt field.
SELECT * FROM ORDERS WHERE AMT IS NOT NULL AND AMT > 0;

-- 18. Count the number of salespeople currently listing orders in the order table.
SELECT COUNT(DISTINCT SNUM) FROM ORDERS;

-- 19. Largest order taken by each salesperson, datewise.
SELECT SNUM, ODATE, MAX(AMT) AS MAX_AMT FROM ORDERS GROUP BY SNUM, ODATE;

-- 20. Largest order taken by each salesperson with order value more than $3000.
SELECT SNUM, MAX(AMT) AS MAX_AMT FROM ORDERS WHERE AMT > 3000 GROUP BY SNUM;

-- 21. Which day had the highest total amount ordered.
SELECT ODATE, SUM(AMT) AS TOTAL_AMT FROM ORDERS GROUP BY ODATE ORDER BY TOTAL_AMT DESC FETCH FIRST 1 ROW ONLY;

-- 22. Count all orders for Oct 3rd.
SELECT COUNT(*) FROM ORDERS WHERE ODATE = TO_DATE('03-OCT-1994', 'DD-MON-YYYY');

-- 23. Count the number of different non-NULL city values in customers table.
SELECT COUNT(DISTINCT CITY) FROM CUST WHERE CITY IS NOT NULL;

-- 24. Select each customer’s smallest order.
SELECT CNUM, MIN(AMT) AS SMALLEST_ORDER FROM ORDERS GROUP BY CNUM;

-- 25. First customer in alphabetical order whose name begins with G.
SELECT * FROM CUST WHERE CNAME LIKE 'G%' ORDER BY CNAME FETCH FIRST 1 ROW ONLY;

-- 26. Get the output like “For dd/mm/yy there are ___ orders.”
SELECT TO_CHAR(ODATE, 'DD/MM/YY') AS ORDER_DATE, COUNT(*) AS ORDER_COUNT
FROM ORDERS
GROUP BY ODATE;

-- 27. Assume that each salesperson has a 12% commission. Produce order no., salesperson no., and amount of salesperson’s commission for that order.
SELECT ONUM, SNUM, AMT, AMT * 0.12 AS COMMISSION
FROM ORDERS;

-- 28. Find highest rating in each city. Put the output in this form: "For the city (city), the highest rating is : (rating)."
SELECT 'For the city ' || CITY || ', the highest rating is: ' || MAX(RATING) AS RESULT
FROM CUST
GROUP BY CITY;

-- 29. Display the totals of orders for each day and place the results in descending order.
SELECT ODATE, SUM(AMT) AS TOTAL_ORDERS
FROM ORDERS
GROUP BY ODATE
ORDER BY TOTAL_ORDERS DESC;

-- 30. All combinations of salespeople and customers who shared a city (i.e., same city).
SELECT S.SNAME, C.CNAME, S.CITY
FROM SALESPEOPLE S
JOIN CUST C ON S.CITY = C.CITY;

-- 31. Name of all customers matched with the salespeople serving them.
SELECT C.CNAME, S.SNAME
FROM CUST C
JOIN SALESPEOPLE S ON C.SNUM = S.SNUM;

-- 32. List each order number followed by the name of the customer who made the order.
SELECT O.ONUM, C.CNAME
FROM ORDERS O
JOIN CUST C ON O.CNUM = C.CNUM;

-- 33. Names of salesperson and customer for each order after the order number.
SELECT O.ONUM, S.SNAME, C.CNAME
FROM ORDERS O
JOIN SALESPEOPLE S ON O.SNUM = S.SNUM
JOIN CUST C ON O.CNUM = C.CNUM;

-- 34. Produce all customers serviced by salespeople with a commission above 12%.
SELECT C.*
FROM CUST C
JOIN SALESPEOPLE S ON C.SNUM = S.SNUM
WHERE S.COMM > 0.12;

-- 35. Calculate the amount of the salesperson’s commission on each order with a rating above 100.
SELECT O.ONUM, O.AMT, O.AMT * S.COMM AS COMMISSION
FROM ORDERS O
JOIN CUST C ON O.CNUM = C.CNUM
JOIN SALESPEOPLE S ON O.SNUM = S.SNUM
WHERE C.RATING > 100;

-- 36. Find all pairs of customers having the same rating.
SELECT C1.CNAME AS CUSTOMER_1, C2.CNAME AS CUSTOMER_2, C1.RATING
FROM CUST C1
JOIN CUST C2 ON C1.RATING = C2.RATING AND C1.CNUM < C2.CNUM;

-- 37. Find all pairs of customers having the same rating, each pair coming once only.
SELECT DISTINCT LEAST(C1.CNAME, C2.CNAME) AS CUSTOMER_1, 
                GREATEST(C1.CNAME, C2.CNAME) AS CUSTOMER_2, 
                C1.RATING
FROM CUST C1
JOIN CUST C2 ON C1.RATING = C2.RATING AND C1.CNUM < C2.CNUM;

-- 38. Policy is to assign three salespeople to each customer. Display all such combinations.
SELECT C.CNAME, S.SNAME
FROM CUST C, SALESPEOPLE S
ORDER BY C.CNAME, S.SNAME;

-- 39. Display all customers located in cities where salesman Serres has customers.
SELECT DISTINCT C.*
FROM CUST C
JOIN CUST C_SERRES ON C_SERRES.SNUM = 1002 AND C.CITY = C_SERRES.CITY;

-- 40. Find all pairs of customers served by a single salesperson.
SELECT C1.CNAME AS CUSTOMER_1, C2.CNAME AS CUSTOMER_2, C1.SNUM
FROM CUST C1
JOIN CUST C2 ON C1.SNUM = C2.SNUM AND C1.CNUM < C2.CNUM;

-- 41. Produce all pairs of salespeople who are living in the same city. 
-- Exclude combinations of salespeople with themselves as well as duplicates with the order reversed.
SELECT S1.SNAME AS SALESPERSON_1, S2.SNAME AS SALESPERSON_2, S1.CITY
FROM SALESPEOPLE S1
JOIN SALESPEOPLE S2 ON S1.CITY = S2.CITY AND S1.SNUM < S2.SNUM;

-- 42. Produce all pairs of orders by a given customer, naming that customer and eliminating duplicates.
SELECT DISTINCT C.CNAME, O1.ONUM AS ORDER_1, O2.ONUM AS ORDER_2
FROM ORDERS O1
JOIN ORDERS O2 ON O1.CNUM = O2.CNUM AND O1.ONUM < O2.ONUM
JOIN CUST C ON O1.CNUM = C.CNUM;

-- 43. Produce names and cities of all customers with the same rating as Hoffman.
SELECT CNAME, CITY
FROM CUST
WHERE RATING = (SELECT RATING FROM CUST WHERE CNAME = 'Hoffman');

-- 44. Extract all the orders of Motika.
SELECT O.*
FROM ORDERS O
JOIN SALESPEOPLE S ON O.SNUM = S.SNUM
WHERE S.SNAME = 'Motika';

-- 45. All orders credited to the same salesperson who services Hoffman.
SELECT O.*
FROM ORDERS O
WHERE SNUM = (SELECT SNUM FROM CUST WHERE CNAME = 'Hoffman');

-- 46. All orders that are greater than the average for Oct 4.
SELECT *
FROM ORDERS
WHERE AMT > (SELECT AVG(AMT) FROM ORDERS WHERE ODATE = TO_DATE('04-OCT-1994', 'DD-MON-YYYY'));

-- 47. Find the average commission of salespeople in London.
SELECT AVG(COMM) AS AVG_COMMISSION
FROM SALESPEOPLE
WHERE CITY = 'London';

-- 48. Find all orders attributed to salespeople servicing customers in London.
SELECT O.*
FROM ORDERS O
JOIN CUST C ON O.CNUM = C.CNUM
WHERE C.CITY = 'London';

-- 49. Extract commissions of all salespeople servicing customers in London.
SELECT DISTINCT S.SNAME, S.COMM
FROM SALESPEOPLE S
JOIN CUST C ON S.SNUM = C.SNUM
WHERE C.CITY = 'London';

-- 50. Find all customers whose CNUM is 1000 above the SNUM of Serres.
SELECT *
FROM CUST
WHERE CNUM = (SELECT SNUM + 1000 FROM SALESPEOPLE WHERE SNAME = 'Serres');

-- 51. Count the customers with a rating above San Jose’s average.
SELECT COUNT(*)
FROM CUST
WHERE RATING > (SELECT AVG(RATING) FROM CUST WHERE CITY = 'San Jose');

-- 52. Obtain all orders for the customer named Cisneros (assume you don’t know his customer number).
SELECT O.*
FROM ORDERS O
JOIN CUST C ON O.CNUM = C.CNUM
WHERE C.CNAME = 'Cisneros';

-- 53. Produce the names and ratings of all customers who have above-average orders.
SELECT DISTINCT C.CNAME, C.RATING
FROM CUST C
JOIN ORDERS O ON C.CNUM = O.CNUM
WHERE O.AMT > (SELECT AVG(AMT) FROM ORDERS);

-- 54. Find total amount in orders for each salesperson for whom this total is greater than the amount of the largest order in the table.
SELECT SNUM, SUM(AMT) AS TOTAL_SALES
FROM ORDERS
GROUP BY SNUM
HAVING SUM(AMT) > (SELECT MAX(AMT) FROM ORDERS);

-- 55. Find all customers with an order on Oct 3rd.
SELECT DISTINCT C.*
FROM CUST C
JOIN ORDERS O ON C.CNUM = O.CNUM
WHERE O.ODATE = TO_DATE('03-OCT-1994', 'DD-MON-YYYY');

-- 56. Find names and numbers of all salespeople who have more than one customer.
SELECT S.SNUM, S.SNAME
FROM SALESPEOPLE S
JOIN CUST C ON S.SNUM = C.SNUM
GROUP BY S.SNUM, S.SNAME
HAVING COUNT(C.CNUM) > 1;

-- 57. Check if the correct salesperson was credited with each sale.
SELECT O.ONUM, O.SNUM, C.SNUM AS EXPECTED_SNUM, 
       CASE WHEN O.SNUM = C.SNUM THEN 'CORRECT' ELSE 'INCORRECT' END AS STATUS
FROM ORDERS O
JOIN CUST C ON O.CNUM = C.CNUM;

-- 58. Find all orders with above-average amounts for their customers.
SELECT O.*
FROM ORDERS O
WHERE O.AMT > (SELECT AVG(O2.AMT) FROM ORDERS O2 WHERE O2.CNUM = O.CNUM);

-- 59. Find the sums of the amounts from the order table grouped by date, eliminating all those dates where the sum was not at least 2000 above the maximum amount.
SELECT ODATE, SUM(AMT) AS TOTAL_AMOUNT
FROM ORDERS
GROUP BY ODATE
HAVING SUM(AMT) >= (SELECT MAX(AMT) FROM ORDERS) + 2000;

-- 60. Find names and numbers of all customers with ratings equal to the maximum for their city.
SELECT CNUM, CNAME, CITY, RATING
FROM CUST C1
WHERE RATING = (SELECT MAX(RATING) FROM CUST C2 WHERE C1.CITY = C2.CITY);

-- 61. Find all salespeople who have customers in their cities who they don’t service. (Both ways using JOIN and Correlated Subquery)
-- Using JOIN
SELECT DISTINCT S.SNUM, S.SNAME, S.CITY
FROM SALESPEOPLE S
JOIN CUST C ON S.CITY = C.CITY AND S.SNUM <> C.SNUM;

-- Using Correlated Subquery
SELECT SNUM, SNAME, CITY
FROM SALESPEOPLE S
WHERE EXISTS (
    SELECT 1 FROM CUST C 
    WHERE C.CITY = S.CITY AND C.SNUM <> S.SNUM
);

-- 62. Extract CNUM, CNAME, and CITY from the customer table if and only if one or more customers are in San Jose.
SELECT CNUM, CNAME, CITY
FROM CUST
WHERE EXISTS (SELECT 1 FROM CUST WHERE CITY = 'San Jose');

-- 63. Find salespeople numbers who have multiple customers.
SELECT SNUM
FROM CUST
GROUP BY SNUM
HAVING COUNT(CNUM) > 1;

-- 64. Find salespeople numbers, names, and cities who have multiple customers.
SELECT S.SNUM, S.SNAME, S.CITY
FROM SALESPEOPLE S
JOIN CUST C ON S.SNUM = C.SNUM
GROUP BY S.SNUM, S.SNAME, S.CITY
HAVING COUNT(C.CNUM) > 1;

-- 65. Find salespeople who serve only one customer.
SELECT S.SNUM, S.SNAME
FROM SALESPEOPLE S
JOIN CUST C ON S.SNUM = C.SNUM
GROUP BY S.SNUM, S.SNAME
HAVING COUNT(C.CNUM) = 1;

-- 66. Extract rows of all salespeople with more than one current order.
SELECT S.*
FROM SALESPEOPLE S
JOIN ORDERS O ON S.SNUM = O.SNUM
GROUP BY S.SNUM, S.SNAME, S.CITY, S.COMM
HAVING COUNT(O.ONUM) > 1;

-- 67. Find all salespeople who have customers with a rating of 300. (Use EXISTS)
SELECT DISTINCT S.SNUM, S.SNAME, S.CITY
FROM SALESPEOPLE S
WHERE EXISTS (SELECT 1 FROM CUST C WHERE C.SNUM = S.SNUM AND C.RATING = 300);

-- 68. Find all salespeople who have customers with a rating of 300. (Use JOIN)
SELECT DISTINCT S.SNUM, S.SNAME, S.CITY
FROM SALESPEOPLE S
JOIN CUST C ON S.SNUM = C.SNUM
WHERE C.RATING = 300;

-- 69. Select all salespeople with customers located in their cities who are not assigned to them. (Use EXISTS)
SELECT DISTINCT S.SNUM, S.SNAME, S.CITY
FROM SALESPEOPLE S
WHERE EXISTS (
    SELECT 1 FROM CUST C 
    WHERE C.CITY = S.CITY AND C.SNUM <> S.SNUM
);

-- 70. Extract from the customers table every customer assigned to a salesperson who currently has at least one other customer (besides the customer being selected) with orders in the order table.
SELECT DISTINCT C.*
FROM CUST C
WHERE EXISTS (
    SELECT 1 FROM ORDERS O 
    WHERE O.SNUM = C.SNUM 
    AND O.CNUM <> C.CNUM
);

-- 71. Find salespeople with customers located in their cities. (Using BOTH ANY and IN)
SELECT DISTINCT S.SNUM, S.SNAME, S.CITY
FROM SALESPEOPLE S
WHERE S.CITY IN (SELECT CITY FROM CUST);

-- Using ANY
SELECT DISTINCT S.SNUM, S.SNAME, S.CITY
FROM SALESPEOPLE S
WHERE S.CITY = ANY (SELECT CITY FROM CUST);

-- 72. Find all salespeople for whom there are customers that follow them in alphabetical order. (Using ANY and EXISTS)
SELECT DISTINCT S.SNUM, S.SNAME
FROM SALESPEOPLE S
WHERE S.SNAME < ANY (SELECT C.CNAME FROM CUST C WHERE C.SNUM = S.SNUM);

SELECT DISTINCT S.SNUM, S.SNAME
FROM SALESPEOPLE S
WHERE EXISTS (SELECT 1 FROM CUST C WHERE C.SNUM = S.SNUM AND C.CNAME > S.SNAME);

-- 73. Select customers who have a greater rating than any customer in Rome.
SELECT * FROM CUST
WHERE RATING > ANY (SELECT RATING FROM CUST WHERE CITY = 'Rome');

-- 74. Select all orders that had amounts greater than at least one of the orders from Oct 6th.
SELECT * FROM ORDERS
WHERE AMT > ANY (SELECT AMT FROM ORDERS WHERE ODATE = TO_DATE('06-OCT-1994', 'DD-MON-YYYY'));

-- 75. Find all orders with amounts smaller than any amount for a customer in San Jose. (Using ANY and without ANY)
SELECT * FROM ORDERS
WHERE AMT < ANY (SELECT AMT FROM ORDERS WHERE CNUM IN (SELECT CNUM FROM CUST WHERE CITY = 'San Jose'));

SELECT * FROM ORDERS
WHERE AMT < (SELECT MIN(AMT) FROM ORDERS WHERE CNUM IN (SELECT CNUM FROM CUST WHERE CITY = 'San Jose'));

-- 76. Select those customers whose ratings are higher than every customer in Paris. (Using BOTH ALL and NOT EXISTS)
SELECT * FROM CUST
WHERE RATING > ALL (SELECT RATING FROM CUST WHERE CITY = 'Paris');

SELECT * FROM CUST C1
WHERE NOT EXISTS (
    SELECT 1 FROM CUST C2 
    WHERE C2.CITY = 'Paris' AND C1.RATING <= C2.RATING
);

-- 77. Select all customers whose ratings are equal to or greater than ANY of the Serres.
SELECT * FROM CUST
WHERE RATING >= ANY (SELECT RATING FROM CUST WHERE SNUM = (SELECT SNUM FROM SALESPEOPLE WHERE SNAME = 'Serres'));

-- 78. Find all salespeople who have no customers located in their city. (Using BOTH ANY and ALL)
SELECT * FROM SALESPEOPLE
WHERE CITY <> ALL (SELECT CITY FROM CUST);

SELECT * FROM SALESPEOPLE S
WHERE NOT EXISTS (SELECT 1 FROM CUST C WHERE C.CITY = S.CITY);

-- 79. Find all orders for amounts greater than any for the customers in London.
SELECT * FROM ORDERS
WHERE AMT > ANY (SELECT AMT FROM ORDERS WHERE CNUM IN (SELECT CNUM FROM CUST WHERE CITY = 'London'));

-- 80. Find all salespeople and customers located in London.
SELECT S.SNAME AS SALESPERSON, C.CNAME AS CUSTOMER
FROM SALESPEOPLE S
JOIN CUST C ON S.CITY = C.CITY
WHERE S.CITY = 'London';

-- 81. For every salesperson, dates on which highest and lowest orders were brought.
SELECT SNUM, 
       MAX(ODATE) AS HIGHEST_ORDER_DATE, 
       MIN(ODATE) AS LOWEST_ORDER_DATE
FROM ORDERS
GROUP BY SNUM;

-- 82. List all of the salespeople and indicate those who don’t have customers in their cities as well as those who do.
SELECT S.SNUM, S.SNAME, S.CITY,
       CASE 
           WHEN EXISTS (SELECT 1 FROM CUST C WHERE C.CITY = S.CITY) THEN 'HAS CUSTOMERS'
           ELSE 'NO CUSTOMERS'
       END AS CUSTOMER_STATUS
FROM SALESPEOPLE S;

-- 83. Append strings to indicate whether a salesperson was matched to a customer in his city.
SELECT 
    S.SNUM, 
    S.SNAME, 
    S.CITY, 
    CASE 
        WHEN C.CNUM IS NOT NULL THEN 'Matched to a customer'
        ELSE 'No customer in city'
    END AS MATCH_STATUS
FROM SALESPEOPLE S
LEFT JOIN CUST C ON S.CITY = C.CITY;

-- 84. Create a union of two queries for customers with rating categories.
SELECT CNAME, CITY, RATING, 'High Rating' AS RATING_CATEGORY
FROM CUST
WHERE RATING >= 200
UNION ALL
SELECT CNAME, CITY, RATING, 'Low Rating' AS RATING_CATEGORY
FROM CUST
WHERE RATING < 200;

-- 85. List salespeople and customers with more than one current order, ordered alphabetically.
SELECT S.SNUM, S.SNAME AS NAME, 'Salesperson' AS ROLE
FROM SALESPEOPLE S
JOIN ORDERS O ON S.SNUM = O.SNUM
GROUP BY S.SNUM, S.SNAME
HAVING COUNT(O.ONUM) > 1
UNION
SELECT C.CNUM, C.CNAME AS NAME, 'Customer' AS ROLE
FROM CUST C
JOIN ORDERS O ON C.CNUM = O.CNUM
GROUP BY C.CNUM, C.CNAME
HAVING COUNT(O.ONUM) > 1
ORDER BY NAME;

-- 86. Form a union of three queries for salespeople, customers, and orders.
SELECT SNUM FROM SALESPEOPLE WHERE CITY = 'San Jose'
UNION
SELECT CNUM FROM CUST WHERE CITY = 'San Jose'
UNION ALL
SELECT ONUM FROM ORDERS WHERE ODATE = TO_DATE('03-OCT-1994', 'DD-MON-YYYY');

-- 87. Find all salespeople in London who had at least one customer there.
SELECT DISTINCT S.SNUM, S.SNAME, S.CITY
FROM SALESPEOPLE S
JOIN CUST C ON S.SNUM = C.SNUM
WHERE S.CITY = 'London';

-- 88. Find all salespeople in London who did not have any customers there.
SELECT S.SNUM, S.SNAME, S.CITY
FROM SALESPEOPLE S
LEFT JOIN CUST C ON S.SNUM = C.SNUM AND S.CITY = C.CITY
WHERE S.CITY = 'London' AND C.CNUM IS NULL;

-- 89.We want to see salespeople matched to their customers without excluding those salesperson who were not currently assigned to any customers. (User OUTER join and UNION)
SELECT S.SNUM, S.SNAME, S.CITY AS SALES_CITY, C.CNUM, C.CNAME, C.CITY AS CUSTOMER_CITY
FROM SALESPEOPLE S
LEFT JOIN CUST C ON S.SNUM = C.SNUM

UNION

SELECT S.SNUM, S.SNAME, S.CITY AS SALES_CITY, C.CNUM, C.CNAME, C.CITY AS CUSTOMER_CITY
FROM SALESPEOPLE S
RIGHT JOIN CUST C ON S.SNUM = C.SNUM;