Title "Homework 7";
title2 "Cambrey Sullivan";
Title3 "Problem 1";
proc freq data=orion.orders;
   tables Customer_ID Employee_ID;
run;
*no, I would imagine that the ids are unique, so the freq would be one;
proc freq data=orion.orders nlevels;
   tables Customer_ID Employee_ID/ noprint;
   where Order_Type = 1;
run;
proc freq data=orion.orders;
   tables Customer_ID /nocum;
   where Order_Type <> 1;
run;
proc freq  data=orion.shoes_tracker nlevels;
	tables Supplier_Name Supplier_ID;
	where Supplier_Name not in ('3Top Sports', 'Greenline Sports Ltd') or
			Supplier_ID not in (2963, 14682);
run;
*Supplier_Name is mislabeled twice as 3op Sports;
proc format;
   value ordertypes
      1='Retail'
      2='Catalog'
      3='Internet';
run;
proc freq data=orion.orders;
	tables Order_Date;
	format Order_Date YEAR4. Order_Type ORDERTYPES.;
run;
proc freq data=orion.orders;
	tables Order_Type /nocum NOPERCENT;
	format Order_Date YEAR4. Order_Type ORDERTYPES.;
run;
proc freq data=orion.orders;
	tables Order_Date*Order_Type/NOPERCENT;
	format Order_Date YEAR4. Order_Type ORDERTYPES.;
run;
proc freq data=orion.qtr2_2011 nlevels;
	tables Order_ID Order_Type;
	where Order_ID is missing or
		Order_Type not in (1, 2, 3);
run;
proc freq data=orion.order_fact;
   tables Product_ID / out=Orders;
run;
data concatenation;
   set Orders orion.product_list;
run;
proc print data=concatenation noobs;
run;
proc format;
   value ordertypes
      1='Retail'
      2='Catalog'
      3='Internet';
run;
title 'Revenue from All Orders';
proc means data=orion.order_fact sum;
	var Total_Retail_Price;
	class Order_Date Order_Type;
	format Order_Date YEAR4. Order_Type ORDERTYPES.;
run;
title;
proc univariate data=orion.price_current;
	var Unit_Sales_Price Factor;
run;
title 'Number of Missing and Non-Missing Date Values';
proc means data=orion.staff nmiss;
	var Birth_Date Emp_Hire_Date Emp_Term_Date;
	class Gender;
run;
title;
PROC UNIVARIATE data= orion.shoes_tracker;
	var Product_ID;
run;
*4 Product_IDs are too small and 8 Product_IDs are too large;

