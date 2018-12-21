title "Homework 9";
title2 "Cambrey Sullivan";
data Wide;
   input Subj $ Wt1-Wt5;
datalines;
001 120 122 124 123 128
002 200 190 188 180 173
003 115 114 113 110 90
;
title "Listing of Data Set Wide";
proc print data=Wide noobs;
run;
proc transpose data=Wide out=Wide_Transposed name=Observation_number;
	id Subj;
run;
proc print data=Wide_Transposed noobs;
    title 'Wide Transposed';
run;

data Thin;
   set Wide;
   array wt[5];
   do Time = 1 to 5;
      Weight = Wt[Time];
      output;
   end;
   drop Wt1-Wt5;
run;
title "Listing of data set THIN";
proc print data=Thin noobs;
run;
proc transpose data=Thin out=Thin_Transposed;
run;
proc print data=Thin_Transposed noobs;
    title 'Thin Transposed';
run;
proc sort data=Thin;
   by Subj;
run;
data Wide;
   set Thin;
   by Subj;
   array Wt[5];
   retain Wt1-Wt5;
   if first.Subj then call missing(of Wt1-Wt5);
   Wt[Time] = Weight;
   if last.Subj then output;
   keep Subj Wt1-Wt5;
run;
