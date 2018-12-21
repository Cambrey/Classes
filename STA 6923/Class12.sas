title "make a dataset (table) from HEART with Status = Dead";
proc sql; 
create table dead as select *
from sashelp.heart
where status = "Dead";
quit;
title "Selectign three variables of interest from HEART";
proc sql; 
select height, weight,sex
from sashelp.heart
quit;
proc sql;
create table direct_reports as
select employee_id, job_title, salary
   from orion.sales;
quit;
proc sql;
   create table sales as
  select d.Product_ID, Product_Name, Order_Date, Discount
    from orion.order_fact as d, orion.product_dim as p
    where d.Product_ID=p.Product_ID and Discount >= .1;
quit;
proc sql;
   create table CLOTHES as
  select d.Product_ID, Product_Name, Order_Date, Discount
    from orion.order_fact as d, orion.product_dim as p
    where d.Product_ID=p.Product_ID and PRODUCT_CATEGORY="Clothes";
quit;
