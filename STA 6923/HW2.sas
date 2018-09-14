ods pdf
file="\\Client\E$\Stats1\HW\HW2\Homework2";
title "Problem 1";
title2 "Listing of the First 10 Observations in Data Set Fish";
title3 "Prepared by: Cambrey Sullivan";
title4 "----------------------------------------------";
proc print data=sashelp.Fish (obs= 10);
	id Species;
	var Species Weight Height Width;
run;

title "Problem 2";
title2 "Listing of Data Set Fish by Species";
title3 "Prepared by: Cambrey Sullivan";
title4 "----------------------------------------------";
proc print data=sashelp.Fish NOOBS;
	by Species;
	var  Species Weight Height Width;
run;

proc sort data=sashelp.Fish 
		out=work.Fish;
	by Species;
run;
title "Problem 3";
title2 "Listing of Data Set Fish by Species with Species ID";
title3 "Prepared by: Cambrey Sullivan";
title4 "----------------------------------------------";
proc print data=work.Fish(drop=Length1-Length3);
	by Species;
	id Species;
	*the Species is only displayed once in Problem 3 (as opposed to every entry in Problem 2). Also, the Species is displayed in the table, rather than over it.;
run;
proc sort data=sashelp.Retail 
		out=work.Retail;
	by YEAR;
run;
title "Problem 4";
title2 "Listing of Data Set Retail by YEAR";
title3 "Prepared by: Cambrey Sullivan";
title4 "----------------------------------------------";
proc print data=work.Retail n = "Total Observations =" label;
	by YEAR;
	id YEAR;
run;
ods pdf close;
run;
