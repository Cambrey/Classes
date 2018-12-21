
%macro age_STA6033 (agevar= ,decage=, dob=,eventdate=);
&agevar.=floor((intck('month',&dob.,&eventdate.)-(day(&eventdate.)<day(&dob.)))/12);
&decage.=yrdif(&dob.,&eventdate.);
%mend age_STA6033;

data patients;
input name $char5. birthdate mmddyy10. ;
cards;
Sally 6/17/2009 
Joe   2/29/2000 
;

data clinic_visits;
input name $char5. v1 mmddyy10. v2 mmddyy10.  v3 mmddyy10. v4 mmddyy10. v5 mmddyy10. ;
cards;
Joe   2/22/2028 2/28/2048 2/29/2048 3/1/2048 4/1/2048
Sally 6/16/2010 6/17/2010 6/18/2010 
;
proc sort data=clinic_visits;by name; run;
proc sort data=patients;by name; run;

data calculate_age_at_visit;
format birthdate v1 v2 v3 v4 v5 mmddyy10.;
merge patients(in=a) clinic_visits(in=B); by name; if a and b;
%age_STA6033 (agevar=integerAGE, decage=decimalAGE, dob=birthdate, eventdate=v1)
run;



data calculate_age_at_EACH_visit;
format decimalAGEatVisit1 decimalAGEatVisit2 decimalAGEatVisit3 6.3;
merge patients(in=a) clinic_visits(in=B); by name; if a and b;
%age_sta6033 (agevar=AGE1, decage=decimalAGEatVisit1, dob=birthdate, eventdate=v1)
%age_sta6033 (agevar=AGE2, decage=decimalAGEatVisit2, dob=birthdate, eventdate=v2)
%age_sta6033 (agevar=AGE3, decage=decimalAGEatVisit3, dob=birthdate, eventdate=v3)
run;

proc print data=calculate_age_at_EACH_visit;
format  birthdate v1 v2 v3 v4 v5 mmddyy10.;
title " patient ages  on each visit";
run;
