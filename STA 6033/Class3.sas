title "Problem 1";
proc print data=orion.order_fact;
	sum Total_Retail_Price;
	ID Customer_ID;
	where Total_Retail_Price > 500;
	var Order_ID Order_Type Quantity Total_Retail_Price;
run;

title "Problem 2";

proc print data=orion.customer_dim;
run;

proc print data=orion.customer_dim ;
	where Customer_Age between 30 and 40;
run;
proc print data=orion.customer_dim NOOBS;
	where Customer_Age between 30 and 40;
run;
proc print data=orion.customer_dim;
	where Customer_Age between 30 and 40;
	id Customer_ID;
run;
proc print data=orion.customer_dim;
	where Customer_Age between 30 and 40;
	id Customer_ID;
	var Customer_ID Customer_Name Customer_Age Customer_Type;
run;

title "Problem 3";


title "Problem 5";
proc sort data=orion.employee_payroll
		out=work.sort_salary;
	by Salary;
run;

proc print data=work.sort_salary;
run;
proc sort data=orion.employee_payroll
		out=work.sort_salary2;
	by Employee_Gender descending Salary ;
run;
proc print data=work.sort_salary2;
run;
