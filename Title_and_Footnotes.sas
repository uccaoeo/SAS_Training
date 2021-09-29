title1 "Class Report";  *You can have up to 10 titles*;
title2 "All Students";
footnote1 "Report Generated on 01SEP2018";

proc print data=pg1.class_birthdate;
run;

title; footnote;  *This clears all title and footnotes;
ods noproctitle; *turns off procedure titles*;
proc means data=sashelp.heart;
	var height weight;
run;

title1 "Storm Analysis";
title2 "Summary Statistic for MaxWind and MinPressure";

proc means data=pg1.storm_final;
	var MaxWindMPH MinPressure;
run;
title2 " Frequency Report for Basin";
proc freq data=pg1.storm_final;
	tables BasinName;
run;

*USING MACRO-VARIABLES IN TITLES*;
%let age=13;
title1 "Class Report";
title2 "Age=&age";
footnote1 "School USe Only";

proc print data=Pg1.class_birthdate;
	where age = &age;
run;
title;
footnote;  *clear the title and footnote, this is useful in SAS enterprise
as it does not clear the title..this prevent the title from running in another sas program*;