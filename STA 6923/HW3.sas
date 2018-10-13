
data health;
	infile '\\Client\E$\Stats1\Data\orion\health.txt' pad;
	input	Subj	$ 1-3
			Gender	$ 4
			Age		5-6
			HR		7-8
			SBP		9-11
			DBP		12-14
			Chol	15-17;
run;

proc sort data=Health;
	by Gender;
run;

title "Listing of Data Set HEALTH - by Gender";
proc print data=health;
	ID Subj;
	by Gender;
run;
			
