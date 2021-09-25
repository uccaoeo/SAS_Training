libname PG1 "s:/workshop/EPG1V2/data";

proc print data=PG1.storm_summary;
run;
	
proc print data=Pg1.storm_summary; 
	where MaxWindMPH > 156;
run;

proc print data=Pg1.storm_summary;
	where MaxWindMPH > 156 and MinPressure < 900;
run;

proc print data=Pg1.storm_summary;
	where MaxWindMPH > 156 or 0<MinPressure < 920;
run;

proc print data=Pg1.storm_summary;
	where StartDate >= "01jan2010"d;
run;

proc print data=Pg1.storm_summary;
	where Basin = "WP";
run;

proc print data=Pg1.storm_summary;
	where MinPressure is missing;  /*It can also be "not missing" or "is null" */
run;

proc print data=Pg1.storm_summary;
	where MaxWindMPH between 100 AND 200;  
run;

proc print data=Pg1.storm_summary;
 	where Name like "A%";   /*wild card for many characters */
run;


proc print data=Pg1.storm_summary;
	where Name like "AGATH_"; /*wild card for single character*/  
run;

proc print data=Pg1.storm_summary;
	where Basin in ("WP", "SI");
run;

proc print data=Pg1.storm_summary;
	where Type="TS" and Hem_EW= "W";
run;

/* ACTIVITY FOR THE WHERE STATEMENT */
libname PG1 "S:/workshop/EPG1V2/data";

proc print data=pg1.np_summary;
	var Type ParkName;
	*Add a WHERE statement;
	where ParkName like '%Preserve%';
run;

proc print data=PG1.eu_occ;
	where  Hotel IS MISSING and ShortStay IS MISSING and Camp IS MISSING;
run;

proc print data=PG1.eu_occ;
	where Hotel > 40000000 ;
run;

proc print data=PG1.np_species;
	where SPECIES_ID like "YOSE%" AND Category ="Mammal";
run;


proc freq data=PG1.np_species;
	where SPECIES_ID like "YOSE%" AND Category ="Mammal";
	tables Abundance Conservation_Status;
run;

proc print data=PG1.np_species;
	var Species_ID Category Scientific_Name Common_Names;
	where SPECIES_ID like "YOSE%" AND Category ="Mammal";
run;

%let ParkCode=YOSE;
%let Category=Mammal;

%let ParkCode=ZION;
%let Category=Bird;

proc print data=PG1.np_species;
	var Species_ID Category Scientific_Name Common_Names;
	where SPECIES_ID like "&ParkCode%" AND Category ="&Category";
run;

proc print data=PG1.np_traffic;
	var ParkName Location Count;
	where Count ne 0 and Location like '%MAIN ENTRANCE%';
run;

proc print data=PG1.np_traffic;
	var ParkName Location Count;
	where Count ne 0 and upcase(Location) like '%MAIN ENTRANCE%';
run;



