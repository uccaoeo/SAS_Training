proc print data=sashelp.cars;
where type = "Wagon";
var Type Make Model MSRP;
run;

proc means data=sashelp.cars;
where type = "Wagon";
var MSRP  MPG_Highway;
run;

proc freq data=sashelp.cars;
where type = "Wagon";
tables origin Make;
run;

/* To Make a MACRO VARIABLE */
/* %let CarType=Wagon; */
%let CarType=SUV;
proc print data=sashelp.cars;
where type = "&CarType";
var Type Make Model MSRP;
run;

proc means data=sashelp.cars;
where type = "&CarType";
var MSRP  MPG_Highway;
run;

proc freq data=sashelp.cars;
where type = "&CarType";
tables origin Make;
run;

%let WindSpeed=156;
%let BasinCode=NA;
%let Date=01JAN2000;

proc print data=PG1.storm_summary;
where MaxWindMPH>156 and Basin="NA" and Startdate>="01jan2000"d;
var Basin Name StartDate EndDate MaxWindMPH;
run;

proc print data=PG1.storm_summary;
where MaxWindMPH>&WindSpeed and Basin="&BasinCode" and Startdate>="&Date"d;
var Basin Name StartDate EndDate MaxWindMPH;
run;

proc means data=PG1.storm_summary;
where MaxWindMPH>156 and Basin="NA" and Startdate>="01jan2000"d;
var MaxWindMPH MinPressure;
run;

proc means data=PG1.storm_summary;
where MaxWindMPH>&WindSpeed and Basin="&BasinCode" and Startdate>="&Date"d;
var MaxWindMPH MinPressure;
run;

