-- query 3
use ecommerce;

SELECT COUNT(B.CUS_GENDER), B.CUS_GENDER from (
SELECT COUNT(P.CUS_ID), P.CUS_ID, P.CUS_NAME, P.ORD_AMOUNT, P.CUS_GENDER FROM(
select orders.*, customer.cus_gender, customer.cus_name from orders inner join customer where
orders.cus_id=customer.cus_id having orders.ord_amount >=3000) AS P GROUP BY P.CUS_ID) AS B GROUP BY B.CUS_GENDER;

-- query 4
SELECT O.*, P.PRO_NAME FROM orders O, Product P, supplier_pricing SP
WHERE O.CUS_ID = 2
AND O.PRICING_ID = SP.PRICING_ID
AND SP.PRO_ID = P.PRO_ID;

-- 5)	Display the Supplier details who can supply more than one product.
SELECT S.* FROM supplier S WHERE S.SUPP_ID IN
(SELECT SUPP_ID FROM SUPPLIER_PRICING AS SP GROUP BY SP.SUPP_ID HAVING COUNT(SUPP_ID)>1);

-- 6)Find the least expensive product from each category and 
-- print the table with category id, name, product name and price of the product
SELECT P.PRO_ID, P.PRO_NAME, P.CAT_ID, S.SUPP_PRICE FROM CATEGORY C, Product P, supplier_pricing SP
WHERE O.ORD_DATE >= '2021-10-05'
AND O.PRICING_ID = SP.PRICING_ID
AND SP.PRO_ID = P.PRO_ID group by P.PRO_ID;

SELECT
  P.PRO_ID, P.PRO_NAME, P.CAT_ID
FROM Product P
JOIN supplier_pricing
  ON supplier_pricing.PRO_ID = P.PRO_ID
JOIN Category
  ON Category.CAT_ID = P.CAT_ID group by P.CAT_ID;

-- 7)	Display the Id and Name of the Product ordered after “2021-10-05”.
SELECT  P.PRO_ID, P.PRO_NAME FROM orders O, Product P, supplier_pricing SP
WHERE O.ORD_DATE > '2021-10-05'
AND O.PRICING_ID = SP.PRICING_ID
AND SP.PRO_ID = P.PRO_ID group by P.PRO_ID;

-- 8)	Display customer name and gender whose names start or end with character 'A'.
SELECT CUS_NAME, CUS_GENDER FROM customer WHERE CUS_NAME LIKE 'A%' OR CUS_NAME LIKE '%A';