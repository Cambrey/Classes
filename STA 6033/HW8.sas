ods pdf
file="\\Client\E$\Stats1\HW\Homework8.pdf";

data Clinic;
   informat Date mmddyy10. Subj $3.;
   input Subj Date Heart_Rate Weight;
   format Date date9.;
datalines;
001 10/1/2015 68 150
003 6/25/2015 75 185
001 12/4/2015 66 148
001 11/5/2015 72 152
002 1/1/2014 75 120
003 4/25/2015 80 200
003 5/25/2015 78 190
003 8/20/2015 70 179
;
Title "Homework 8";
title2 "Cambrey Sullivan";
title3 "Problem 1";
proc sort data=Clinic;
	by Subj Date;
run;
data Diff;
	set Clinic;
	by Subj;
	if First.Subj and Last.Subj then delete;
	Diff_HR=dif(Heart_Rate);
	Diff_Weight=dif(Weight);
	if not First.Subj then output;
run;
	
proc print data=Diff;
run;
Title "Homework 8";
title2 "Cambrey Sullivan";
title3 "Problem 2";




ods pdf close;
run;
