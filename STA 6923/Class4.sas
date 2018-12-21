title "In Class";
title2 "5.1";
title3 "Problem 1";
title4 "----------------------------------------------";
data work.salessubset;
	set orion.sales;
	keep Employee_ID First_Name Last_Name Salary Job_Title Hire_Date;
	where Salary < 26000 and Employee_ID > 120175; 
run;
proc sort data=work.salessubset
	out=work.sales;
	by Employee_ID;
run;
proc print data=work.sales label noobs;
	format Salary dollar10.
	Hire_Date monyy7.;
	label Job_Title='Title'
	Hire_Date='Date Hired'
	First_Name='First Name'
	Last_Name='Last Name';
run;
data work.subset2;
	set orion.sales;
	keep Employee_ID First_Name Last_Name Salary Job_Title Hire_Date;
	format  First_Name$MSGCASE. 
			Last_Name$MSGCASE. 
			Job_Title$QUOTE.;
	where Salary < 26000;
run;
proc sort data=work.subset2;
	by Employee_ID;
run;
title "In Class";
title2 "5.1";
title3 "Problem 2";
title4 "----------------------------------------------";
proc print data=work.subset2;
	ID Employee_ID;
	where Employee_ID>120175;
run;
title "In Class";
title2 "5.1";
title3 "Problem 3";
title4 "----------------------------------------------";
data work.salesupper;
	set orion.sales;
	keep Employee_ID First_Name Last_Name Job_Title;
run;
proc print data=work.salesupper noobs;
	format First_Name Last_Name $UPCASE100.
		 Job_Title $QUOTE100.;
run;
title2 "5.2";
title3 "Demonstration";
title4 "----------------------------------------------";
proc format;
   value tiers 0-49999='Tier 1'                  
           50000-99999='Tier 2'
         100000-250000='Tier 3';
run;

data work.salaries;
	input Name $ Salary;
	Original_Salary=Salary;
	datalines;
Abi 50000
Mike 65000
Jose 50000.00
Joe 37000.50
Ursula 142000
Lu 49999.99
;

proc print data=work.salaries;
   format Salary tiers.;
run;

proc print data=work.salaries;
   format Salary tiers8.;
run;
title2 "5.3";
title3 "Problem 4";
title4 "----------------------------------------------";
data Q1Birthdays;
   set orion.employee_payroll;
   BirthMonth=month(Birth_Date);
   if BirthMonth le 3;
run;
proc format;
	value $Gender 'F'='Female'
				'M'='Male';
	value _MNAME 1='January'
				2='February'
				3='March';
run;
proc print data=Q1Birthdays;
	var Employee_ID Employee_Gender BirthMonth;
	format Employee_Gender $Gender.
			BirthMonth _MNAME.;
run;
title2 "5.3";
title3 "Problem 5";
title4 "----------------------------------------------";
proc format;
	value $Gender 'F'='Female'
				'M'='Male'
				other='Invalid code';
run;

proc format;
	value _SALRANGE 20000-110000='Below $110,000'
					110000-500000='$110,000 or more'
					.='Missing salary'
					other='Invalid salary';
run;
proc print data=orion.nonsales;
	format Salary _SALRANGE.
			Gender $Gender.;
run;
data work.nonsales2;
	set orion.nonsales;
	format Salary _SALRANGE.
			Gender $Gender.;
run;

proc freq data=work.nonsales2;
   tables Salary;
run;
title2 "5.3";
title3 "Problem 6";
title4 "----------------------------------------------";
proc print;
	*libname;
	*options fmtsearch -> libref;
run;
title2 "6.1";
title3 "Problem 1";
title4 "----------------------------------------------";
