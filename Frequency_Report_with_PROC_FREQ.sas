proc freq data=sashelp.heart;
	tables Chol_Status;
run;

proc freq data=pg1.storm_final order=freq nlevels; 
/*Order=freq sort the levels according to descending frequency,
originally it was arranged in alphabetical or numerical order
while nlevels tells us the unique values present in each colums(BasinName and Season)
nocum eliminates the cumulative table*/
	tables BasinName Season /nocum;
run;

*TURN ON GRAPHICS*;
ODS GRAPHICS ON;
ODS NOPROCTITLE; *turn off proc freq title in result*;
title "Frequency Report for Basin Name and Storm Month";
proc freq data=pg1.storm_final order=freq nlevels; 
	tables BasinName StartDate /nocum plots=freqplot(orient=HORIZONTAL scale=percent); 
/* 	by default orient is vertical and scale is frequency count.
freqplot creates a plot and ODS GRAPHICS ON helps to turn on graphics for the SAS session */
*the startdate is clumsy as all the dates are showing, it would be interesting to group the date by month name*;
	format StartDate monname.;
	label BasinName="Basin"
	StartDate="Storm Month";
run;
title; * It sis good practice to set title to null after initializing title above*;
ODS proctitle; *Good practice to turn it on after switching it off above*;

*Class Activity*;
title "Frequency Report for Basin and Storm Month";

proc freq data=pg1.storm_final order=freq noprint; *noprint suppress the printed output*;
	tables StartDate / out=storm_count;
	format StartDate monname.;
run;