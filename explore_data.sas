libname PG1 "S:/workshop/EPG1V2/data";

proc print data=pg1.storm_summary (obs=10);
run;
/* list first ten rows */

proc print data=pg1.storm_summary (obs=10);
	var  Season Name Basin MaxWindMPH MinPressure StartDate EndDate;
run;

/* Calculate statistical summary */
proc means data=pg1.storm_summary; /*Proc means can only calculate numerical variables */
	var MaxWindMPH MinPressure;
run;

/*Examine extreme values */
proc univariate data=pg1.storm_summary; 
	var MaxWindMPH MinPressure;
run;

/*List unique values and frequencies*/
proc freq data=pg1.storm_summary; 
	tables Basin Type Season;
run;


