---------------------------------------------------------------------------------------
/* Hello! We're going to practice some SQL with a database
   from Oracle. This database covers:
   - PC component products
   - categories, orders and order items for said products
   - customers and employees
   - warehouses and their inventories
   - locations, countries, regions
   Hoowhee! That's a lot of tables. But when it comes to
   data, the more the merrier :) */
use ot;
---------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------
/*  	*
	1a.) Select the region_id and count of all rows from the countries table. Group 
	by the region_id and order by count descending. Limit to 1 to find the region 
	with the most countries that have company locations. */
---------------------------------------------------------------------------------------
select * from countries;
select region_id, count(*) as count_countries
from countries
group by region_id
order by count_countries desc
limit 1;


---------------------------------------------------------------------------------------
/* 	*
	1b.) Looks like we found the region with the most countries, but we don't know 
	the name of the region. Fortunately, that can be found in the regions table. 
	Using the results of the previous problem, find the name of the region with the
	most countries. We want to use an alias of 'region with most locations' for the 
        column label, as well. */
---------------------------------------------------------------------------------------
select region_name as 'region with the most countries', count(*) as 'count_countries'
from countries
join regions on countries.region_id = regions.region_id
group by countries.region_id
order by count_countries desc
limit 1;


---------------------------------------------------------------------------------------
/* 	**
	 1c.) Nice job! Now, here's a more difficult one. Using the locations table, 
	 select the state, city, and postal_code from locations where the country is 
	 NOT the United States (country_id != "US") and the name of the city starts
	 with "S". 
         Hint: Use LIKE and a wildcard. */
---------------------------------------------------------------------------------------
select state, city, postal_code
from locations
where city like 'S%' and country_id != 'US';


---------------------------------------------------------------------------------------
/*  	*
	1d.) As you may have seen in the problem above, there's a "state" column in the 
        locations table, but not all locations are in a state. Select all entries for 
        the locations that are NOT in a state. */
---------------------------------------------------------------------------------------
select * from locations
where state is NULL;


---------------------------------------------------------------------------------------
/* 	**
	1e.) Your employer wants an update on the number of countries that have locations. 
	They note that they want unique countries but they're not sure how to do that 
	and they're asking you for help. Write a query for them. */
---------------------------------------------------------------------------------------
select count(distinct country_id) as 'Number of Countries with locations'
from locations;


---------------------------------------------------------------------------------------
/* 	**
	2a.) Why don't we switch gears? Let's take a look at the products in this
	database. Find the product names and prices of all products that have a 
	list_price between 100 and 500. You'll have to find the right table yourself on 
	this one. */
---------------------------------------------------------------------------------------
select product_name, list_price
from products
where list_price between 100 and 500
order by list_price asc;


---------------------------------------------------------------------------------------
/* 	**
	2b.) What do those product names even MEAN? If you don't know much about PC 
       components, it can be difficult to distinguish between different kinds of 
       products. Good thing we have a table for product categories! 
       
       Select the product_name, list_price, and category_name (from product category) 
       rows from the products table joined to the product_categories table on 
       category_id (using an inner join). */
---------------------------------------------------------------------------------------
select p.product_name, p.list_price, pc.category_name
from products p
inner join product_categories pc
on p.category_id = pc.category_id;


---------------------------------------------------------------------------------------
/* 	****
	2c.) Let's try joining more than two tables. You're looking for a popular CPU 
	that has more than 100 units in stock at your local warehouse in Toronto. You 
	only need to find the names of the products, but you'll need to join these 
	tables:
        - warehouses
        - inventories
        - products
        - product_categories
        The only info you need is the product_name and the list_price. */
---------------------------------------------------------------------------------------
select product_name, list_price
from products 
inner join product_categories on products.category_id = product_categories.category_id
inner join inventories on products.product_id = inventories.product_id
inner join warehouses on inventories.warehouse_id = warehouses.warehouse_id
where warehouse_name = 'Toronto'
and category_name like 'CPU'
and quantity > 100;


---------------------------------------------------------------------------------------



