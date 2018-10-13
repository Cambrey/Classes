Title "Homework 4";
title2 "Cambrey Sullivan";
title3 "Infile Used for 8.4:";
title4 "infile '\\Client\E$\Stats1\Data\orion\health.txt' pad";
data Health;
   infile '\\Client\E$\Stats1\Data\orion\health.txt' pad;
   input Subj   $ 1-3
         Gender $ 4
         Age      5-6
         HR       7-8
         SBP      9-11
         DBP      12-14
         Chol     15-17;
run;
proc print data=Health;
   ID Subj;
run;
title3 "Problem 5";
title4 " ";

	
title3 "Problem 7";

title3 "Problem 10";
