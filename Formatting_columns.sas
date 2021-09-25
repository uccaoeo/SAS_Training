proc print data=PG1.class_birthdate (obs=10);
	format height weight 6.1 Birthdate date9.;
run;

proc print data=PG1.class_birthdate (obs=10); 
	format height weight dollar6.1 Birthdate date9.;
run;
/* w.d, COMMAw.d, DOLLARw.d, YENw.d, EUROw.d, examples DOLLAR10.2 DOLLAR10. */
/* The w is width and must accomodate both the whole length of the word or number including  */
/* the dots, commas and dollar sign (if any) and tthe length of the number itself, */
/* the width must be long enough to also accomodate the number of decimal places that is specified. */

proc print data=PG1.storm_damage;
	format Date mmddyy10. Cost dollar16.;
run;

proc print data=pg1.storm_summary(obs=20);
	format Lat Lon 4. StartDate EndDate date11.;
run;

proc freq data=pg1.storm_summary order=freq;
	tables StartDate;
	*Add a FORMAT statement;
	format StartDate MONNAME.;
run;

