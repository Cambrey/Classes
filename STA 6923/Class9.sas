ods html
file="\\Client\E$\Stats1\myreport1.html" style=htmlblue;
Title "Class9";
title2 "Cambrey Sullivan";
title3 "Part 1";
proc freq data=orion.sales;
	tables Country; 
run;

ods html close;
run;

ods html
file="\\Client\E$\Stats1\myreport2.html" style=default;
Title "Class9";
title2 "Cambrey Sullivan";
title3 "Part 2";
proc freq data=orion.sales;
	tables Country; 
run;

ods html close;
run;

ods html
file="\\Client\E$\Stats1\myreport3.html" style=sasweb;
Title "Class9";
title2 "Cambrey Sullivan";
title3 "Part 3";
proc freq data=orion.sales;
	tables Country; 
run;

ods pdf close;
run;

ods pdf file="\\Client\E$\Stats1\myreport1.pdf" style=pearl;
Title "Class9";
title2 "Cambrey Sullivan";
title3 "Part 4";
proc freq data=orion.sales;
	tables Country; 
run;
ods pdf close;
run;

ods pdf file="\\Client\E$\Stats1\myreport2.pdf" style=printer;
Title "Class9";
title2 "Cambrey Sullivan";
title3 "Part 5";
proc freq data=orion.sales;
	tables Country; 
run;
ods pdf close;
run;

ods pdf file="\\Client\E$\Stats1\myreport3.pdf" style=journal;
Title "Class9";
title2 "Cambrey Sullivan";
title3 "Part 6";
proc freq data=orion.sales;
	tables Country; 
run;
ods pdf close;
run;
Title "Class9";
title2 "Cambrey Sullivan";
title3 "Part 7";
title4 "There are 52 styles";
ods listing;
proc template;

list styles;
run;
ods listing close;
