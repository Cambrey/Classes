
*Program 19-1: Creating the Blood_Pressure Data Set;
libname Trial "/folders/myfolders";


data Blood_Pressure;
   call streaminit(37373);
   do Drug = 'Placebo','Drug A','Drug B';
      do i = 1 to 20;
         Subj + 1;
         if mod(Subj,2) then Gender = 'M';
         else Gender = 'F';
         SBP = rand('normal',130,10) +
               7*(Drug eq 'Placebo') - 6*(Drug eq 'Drug B');
         SBP = round(SBP,2);
         DBP = rand('normal',80,5) +
               3*(Drug eq 'Placebo') - 2*(Drug eq 'Drug B');
         DBP = round(DBP,2);
         Age = int(rand('normal',50,10) + .1*SBP);         
         if Subj in (5,15,25,55) then call missing(SBP, DBP);
         if Subj in (4,18) then call missing(Gender);
         output;
      end;
   end;
   drop i;
run;
title "Listing of Data Set DRUG_TRIAL (first 10 observtions)";
proc print data=Work.Blood_Pressure(obs=10);
   id Subj;
run;


























*Program 19-2: Running PROC MEANS on the Blood_Pressure Data Set (using all the default options);
title "Running PROC MEANS with all the Defaults";
proc means data=Work.Blood_Pressure;
run;
*Program 19-3: Adding Options to Control PROC MEANS Output;
title "Running PROC MEANS with Selected Options";
proc means data=Sashelp.Heart n nmiss mean std cv stderr clm maxdec=3;
   var Diastolic Systolic;
run;
*Program 19-4: Adding a BY Statement with PROC MEANS;
title "Statistics for Blood Pressure Study Broken Down by Gender";
proc sort data=Sashelp.Heart out=Blood_Pressure;
   by Sex;
run;
proc means data=Blood_Pressure n nmiss mean std maxdec=2;
   by Sex;
   var Diastolic Systolic;
run;
*Program 19-5: Using a CLASS Statement to see Statistics Broken Down by Region;
title "Using a CLASS Statement with PROC MEANS";
proc means data=Work.Blood_Pressure n nmiss mean std maxdec=2;
   class Gender;
   var SBP DBP;
run;
*Program 19-6: Using Two CLASS Variables with PROC MEANS;
title "Using a CLASS Statement with Two CLASS Variables";
proc means data=Work.Blood_Pressure n nmiss mean std maxdec=2;
   class Gender Drug;
   var SBP DBP;
run;
*Program 19-7: Adding the PRINTALLTYPES Option to PROC MEANS;
proc means data=Work.Blood_Pressure n nmiss mean std maxdec=2
   printalltypes;
   class Gender Drug;
   var SBP DBP;
run;
*Program 19-8: Using PROC MEANS to Create a Data Set Containing the Grand Mean;
proc means data=Work.Blood_Pressure noprint;
   var SBP DBP;
   output out=Grand_Mean mean=Grand_SBP Grand_DBP 
          n=Nonmiss_SBP Nonmiss_DBP;   
run;
*Program 19-9: Listing of Data Set Grand_Mean;
title "Listing of Data Set Grand_Mean";
proc print data=Grand_Mean noobs;
run;
*Program 19-10: Using AUTONAME to Name the Variables in the Output Data Set;
proc means data=Heart noprint;
   var Systolic Diastolic;
   output out=Grand_Mean mean= n= / autoname;   
run;
title "Listing of Data Set GRAND_MEAN";
title2 "Using the AUTONAME Output Option";
proc print data=Grand_Mean noobs;
run;
*Program 19-11: Creating a Summary Data Set with Two Class Variables;
proc means data=Work.Blood_Pressure noprint;
   class Gender Drug;
   var SBP DBP;
   output out=Summary mean= n= std= / autoname;
run;
title "Listing of Data Set SUMMARY";
proc print data=Summary noobs;
run;
*Program 19-12: Adding the NWAY Option to PROC MEANS;
proc means data=Work.Blood_Pressure noprint nway;
   class Gender Drug;
   var SBP DBP;
   output out=Summary mean= n= std= / autoname;
run;
title "Listing of Data Set SUMMARY";
title2 "NWAY Option Added";
proc print data=Summary noobs;
run;
*Program 19-13: Using a Formatted CLASS Variable;
proc format;
   value AgeGroup low-50  = '50 and Lower'
                   51-70   = '51 to 70'
                   71-high = '71 +';
run;
title "Using a Formatted CLASS Variable";
proc means data=Work.Blood_Pressure n nmiss mean std maxdec=2;
   class Age;
   format Age AgeGroup.;
   var SBP DBP;
run;
*Program 19-14: Demonstrating PROC UNIVARIATE
title "Demonstrating PROC UNIVARIATE";
proc univariate data=Work.Blood_Pressure;
   var Systolic;
   histogram;
   qqplot / normal (mu=est sigma=est);
run;
*Program 20-1: Program to Generate Test Data Set Risk;
proc format;
   value yesno 1 = '1-Yes'
               0 = '2-No';
run;
data Risk;
   call streaminit(12345678);
   length Age_Group $ 7;
   do Subj = 1 to 250;
      do Gender = 'F','M';
         Age = round(rand('uniform')*30 + 50);
         if Age lt 60 then Age_Group = '1:< 60';
         else if Age le 70 then Age_Group = '2:60-70';
         else Age_Group = '3:71+';
         if rand('uniform') lt .3 then BP_Status = 'High';
         else BP_Status = 'Low';
         Chol = rand('normal',200,30) + rand('uniform')*8*(Gender='M');
         Chol = round(Chol);
         if Chol gt 240 then Chol_Status = 'High';
         else Chol_Status = 'Low';
         Score = .1*Chol + age + 8*(Gender eq 'M') + 
         10*(BP_Status = 'High');
         Heart_Attack = (Score gt 100)*(rand('uniform') lt .6);
         output;
       end;
   end;
   keep Subj Gender Age Chol Chol_Status BP_Status Heart_Attack;
   format Heart_Attack yesno.;
run;
title "Listing of Data Set RISK (first 10 observations)";
proc print data=Risk(obs=10);
   id Subj;
run;
*Program 20-2: Using PROC FREW to Generate One-way Frequency Tables;
title "One-way Frequency Tables";
proc freq data=Risk;
   tables Gender Heart_Attack;
run;
*Program 20-3: Changing the Table Order and Removing the Cumulative Statistics;
title "One-way Frequency Tables";
proc freq data=Risk order=formatted;
   tables Gender Heart_Attack / nocum;
run;
*Program 20-4: Creating a Two-way Frequency Table;
title "Two-way Frequency Table of BP_Status by Heart_Attack";
proc freq data=Risk order=formatted;
   tables BP_Status * Heart_Attack;
run;
*Program 20-5: Adding a Request for a Chi-square Test;
title "Two-way Frequency Table of BP_Status by Heart_Attack";
proc freq data=Risk order=formatted;
   tables BP_Status * Heart_Attack / chisq;
run;
*Program 20-6: Creating a Three-way Table;
title "Three-way Table of Gender by BP_Status by Heart_Attack";
proc freq data=Risk order=formatted;
   tables Gender * BP_Status * Heart_Attack;
run;
*Program 20-7: Using Formats to Group a Numeric Variable;
proc format;
   value Agegroup low-19 = '<20'
                  20-39  = '20 to 39'
                  40-59  = '40 to 59'
                  60-79  = '60 to 79'
                  80-high= '80+'
                     .   = 'Missing';
run;
title "Using a Format to Group a Numeric Variable";
proc freq data=Risk;
   tables Age / nocum;
   format Age Agegroup.;
run;
