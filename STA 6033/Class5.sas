title "Slides problems";
data work.nonsales2;
	infile "\\Client\E$\Stats1\Data\orion\nonsales.csv" dlm=',';
	input Employee_ID First $ Last $;
run;
Data work.salaries;
	infile "\\Client\E$\Stats1\Data\orion\salary.dat";
	input Name $
		HireDate :date.
		Age State $
		Salary :comma. ;
run;
proc print data=work.salaries;
run;

proc contents data=orion.staff;
run;





title "In Class Problem Handout";
title2 "6.1";
title3 "Problem 4";
data work.increase;
   set orion.staff;
   where Emp_Hire_Date >= "07JUL2010" d;
   Increase=Salary*0.10;
   NewSalary=Salary+Increase;
run;

proc print data=work.increase;
run;

Data work.donations;
      infile "\\Client\E$\Stats1\Data\orion\donation.dat" dlm='  ' missover;
      INPUT  EmpID  Q1  Q2  Q3  Q4;
run;
