proc freq data=sashelp.heart;
	tables BP_status*Chol_Status;
run;
*PROC FREQ creates a two way frequency report when asterisk is placed between two columns*;
proc freq data=sashelp.heart;
	tables Chol_Status*BP_Status;
run;

proc freq data=pg1.storm_final;
	tables BasinName*StartDate /norow nocol nopercent; 
	*remove column, rows and percent, left with frequency count alone*;
	format StartDate monname.;
	label BasinName="Basin"
		  StartDate="Storm Month";
run;

proc freq data=pg1.storm_final;
	tables BasinName*StartDate /crosslist; *display the table in cross style*;
	*remove column, rows and percent, left with frequency count alone*;
	format StartDate monname.;
	label BasinName="Basin"
		  StartDate="Storm Month";
run;

proc freq data=pg1.storm_final;
	tables BasinName*StartDate /list; *display the table in table style like one way*;
	*remove column, rows and percent, left with frequency count alone*;
	format StartDate monname.;
	label BasinName="Basin"
		  StartDate="Storm Month";
run;
proc freq data=pg1.storm_final noprint; *usuppress print display*;
	tables BasinName*StartDate /out=stomrcounts; *use output in another process*;
	*remove column, rows and percent, left with frequency count alone*;
	format StartDate monname.;
	label BasinName="Basin"
		  StartDate="Storm Month";
run;

*ACTIVITY*;
ODS GRAPHICS ON;
ODS NOPROCTITLE;
title1 "Category of Reported Species";
title2 "In the Everglades";
proc freq data=PG1.np_species order=freq;
	where UPCASE(species_ID) like "EVER%" and Category ^= "Vascular Plant";
	tables Category /nocum plots=freqplot(orient=Horizontal scale=percent);
run;
title;
ODS PROCTITLE;

data looki;
	set PG1.np_codelookup;
	where Type like "%Other%";
run;
*ACTIVITY 2*;
title "Park Types by Region";
proc freq data=pg1.np_codelookup order=freq;
	tables Type*region /nocol;
	where Type not like "%Other%";
	
run;
title;

*ACTIVITY 2*;
title "Selected Park Types by Region";
proc freq data=pg1.np_codelookup order=freq;
	tables Type*region /nocol crosslist plots=freqplot(groupby=row scale=grouppercent orient=horizontal);
	where Type in ("National Historic Site" "National Monument" "National Park");
run;
title;

title 'Counts of Selected Park Types by Park Region';
proc sgplot data=pg1.np_codelookup;
	where Type in ("National Historic Site" "National Monument" "National Park");
	hbar region / group=Type;
	keylegend / opaque across = 1 position=bottomright location=inside;
	xaxis grid;
run;

title 'Counts of Selected Park Types by Park Region';
proc sgplot data=pg1.np_codelookup;
	where Type in ("National Historic Site" "National Monument" "National Park");
	hbar region / group=Type seglabel fillattrs=(transparency=0.5) dataskin=gloss;
	keylegend / opaque across = 1 position=bottomright location=inside;
	xaxis grid;
run;


title1 'Counts of Selected Park Types by Park Region';
ods graphics on;
proc freq data=pg1.np_codelookup order=freq;
	tables Type*Region / crosslist plots=freqplot(twoway=stacked orient=horizontal);
	where type in ('National Historic Site', 'National Monument', 'National Park');
run;

/*part b*/
title1 'Counts of Selected Park Types by Park Region';
proc sgplot data=pg1.np_codelookup;
    where Type in ('National Historic Site', 'National Monument', 'National Park');
    hbar region / group=type;
    keylegend / opaque across=1 position=bottomright location=inside;
    xaxis grid;
run;


