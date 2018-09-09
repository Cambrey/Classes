title "Problem 1";
proc contents data=sashelp.Heart;
run;

proc contents data=sashelp.Heart Varnum;
run;

title "Problem 2";

data work.Heart_Vars;
	set sashelp.heart(keep=BP_Status Chol_Status Systolic Diastolic Status);
run;

title "Problem 3";
libname Data 'E:\Stats1\Data';
data Data.Heart_Vars;
	set sashelp.heart(keep=BP_Status Chol_Status Systolic Diastolic Status);
run;

title "Problem 4";
data work.Alive;
	set sashelp.heart(keep=BP_Status Chol_Status Systolic Diastolic);
	set sashelp.heart(where=(Status='Alive'));
run;

proc print data=Alive(obs=10);
run;

title "Problem 6";
* there is no = after 'keep'. Also, the second asterisk is not necessary. 
