ods pdf
file="\\Client\E$\Stats1\HW\Homework6";
Title "Homework 6";
title2 "Cambrey Sullivan";
data work.birthday;
	set orion.customer;
	Bday2018=mdy(month(Birth_Date),day(Birth_Date),2018);
	BdayDOW2018=weekday(Bday2018);
	Age2018=int((Bday2018-Birth_Date)/365.25);
	AGE=yrdif(Birth_Date, Bday2018);
run;
title3 "Part 1";
proc print data=work.birthday;
	format Bday2018 date9.;
run;
data FirstQtr;
	input Name $ Quantity Cost;
datalines;
Fred 100 3000
Jane 90 4000
April 120 5000
;
data SecondQtr;
	input Name $ Quantity Cost;
datalines;
Ron 200 9000
Jan 210 9500
Steve 177 5400
;
data FirstHalf;
	set FirstQtr SecondQtr;
run;
title3 "Part 2";
title4 "Cody, Chapter 14, Problem 5";
proc print data=FirstHalf;
run;
data work.First_Half;
	set FirstQtr;
run;
proc append base=First_Half Data=SecondQtr;
run;
title4 "Cody, Chapter 14, Problem 6";
proc print data=First_Half;
run;
data First;
	input ID $ X Y Z;
datalines;
001 1 2 3
004 3 4 5
002 5 7 8
006 8 9 6
;
data Second;
	input ID $ Name $;
datalines;
002 Jim
003 Fred
001 Susan
004 Jane
;
proc sort data=First;
	by ID;
run;
proc sort data=Second;
	by ID;
run;

data Both;
	merge First(in=In_One) Second(in=In_Two);
	by ID;
	if In_One and In_Two;
run;
title4 "Cody, Chapter 14, Problem 7";
proc print data=Both;
run;
ods pdf close;
run;
