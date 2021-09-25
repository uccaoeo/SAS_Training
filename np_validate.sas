***********************************************************;
*  LESSON 2, PRACTICE 1                                   *;
*    a) Complete the PROC PRINT statement to list the     *;
*       first 20 observations in PG1.NP_SUMMARY.          *;
*    b) Add a VAR statement to include only the following *;
*       variables: Reg, Type, ParkName, DayVisits,        *;
*       TentCampers, and RVCampers. Highlight the step    *;
*       and run the selected code.                        *;
*       Do you observe any possible inconsistencies in    *;
*       the data?                                         *;
*    c) Copy the PROC PRINT step and paste it at the end  *;
*       of the program. Change PRINT to MEANS and remove  *;
*       the OBS= data set option. Modify the VAR          *;
*       statement to calculate summary statistics for     *;
*       DayVisits, TentCampers, and RVCampers. Highlight  *;
*       the step and run the selected code.               *;
*       What is the minimum value for tent campers? Is    *;
*       that value unexpected?                            *;
*    d) Copy the PROC MEANS step and paste it at the end  *;
*       of the program. Change MEANS to UNIVARIATE.       *;
*       Highlight the step and run the selected code.     *;
*       Are there negative values for any of the columns? *;
*    e) Copy the PROC UNIVARIATE step and paste it at the *;
*       end of the program. Change UNIVARIATE to FREQ.    *;
*       Change the VAR statement to a TABLES statement to *;
*       produce frequency tables for Reg and Type.        *;
*       Highlight the step and run the selected code.     *;
*       Are there any lowercase codes? Are there any      *;
*       codes that occur only once in the table?          *;
*    f) Add comments before each step to document the     *;
*       program. Save the program as np_validate.sas in   *;
*       the output folder.                                *;
***********************************************************;

proc print data=PG1.np_summary (obs=20);
run;

/* Proc print for the first 20 observations for specified variables */
proc print data=PG1.np_summary(obs=20);
	var Reg Type ParkName DayVisits TentCampers RVCampers;
run;
/* Proc means step */
proc means data=PG1.np_summary;
	var DayVisits TentCampers RVCampers;
run;
/* Proc univariate step */
proc univariate data=PG1.np_summary;
	var DayVisits TentCampers RVCampers;
run;
/* Proc Freq step */
proc freq data=PG1.NP_SUMMARY;
 	tables Reg Type;
run; 
/* LEVEL 2 */
proc freq data=PG1.NP_SUMMARY;
	tables Reg Type;
run;

run;
/* Proc univariate step */
proc univariate data=PG1.np_summary;
	var Acres;
run;

data acre1;
	set PG1.np_summary;
run;

proc means data=acre1 min max;
	var acres;
run;

ODS TRACE ON;
/* CHALLENGE */
proc univariate data=pg1.eu_occ;
	var Camp;
run;
ODS TRACE OFF;



ODS SELECT ExtremeObs;
/* CHALLENGE */
proc univariate data=pg1.eu_occ;
	var Camp;
run;

ODS SELECT ExtremeObs;
/* CHALLENGE */
proc univariate data=pg1.eu_occ nextrobs=10;
	var Camp;
run;


