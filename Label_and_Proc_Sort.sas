proc means data=sashelp.cars;
	where Type ="Sedan";
	var MSRP MPG_Highway;
	label MSRP="Manufacturing Suggested Retail Price"
				MPG_Highway="Highway Miles Per Gallon";
run;

proc print data=sashelp.cars label; * for proc print, you have to include the label to the data option*;
	where Type ="Sedan";
	var Make Model MSRP MPG_Highway;
	label MSRP="Manufacturing Suggested Retail Price"
				MPG_Highway="Highway Miles Per Gallon";
run;
/* FOR DATA SETUP, THE LABELS ARE ASSIGNED PERMANENTLY */
data cars_update; 
	set sashelp.cars;
	keep Make Model Type MSRP AvgMPG;
	AvgMPG = Mean(MPG_Highway, MPG_City);
	label MSRP="Manufacturing Suggested Retail Price"
				AvgMPG="Avergae Miles Per Gallon";
run;
proc contents data=cars_update;
run;
/* CLASS ACTIVITY */
data cars_update;
    set sashelp.cars;
	keep Make Model MSRP Invoice AvgMPG;
	AvgMPG=mean(MPG_Highway, MPG_City);
	label MSRP="Manufacturer Suggested Retail Price"
          AvgMPG="Average Miles per Gallon"
          Invoice="Invoice Price";
run;

proc means data=cars_update min mean max;
    var MSRP Invoice;
run;

proc print data=cars_update label;
    var Make Model MSRP Invoice AvgMPG;
run;

/* ACTIVITY END */

	
proc sort data=sashelp.cars out=cars_sort;
	by Origin;
run;
proc freq data=cars_sort;
	by Origin;  *by origin from the proc sort output*;
	tables Type;
run;

/* CATEGORIZING GROUP 5 STORMS */
title1 "Category 5 Storms";
proc sort data=PG1.storm_final out=storm_sort;
by BasinName descending MaxWIndMPH;
where MaxWindMPH >156;
run;

proc print data=storm_sort label noobs;
	var Season Name MaxWindMPH MinPressure StartDate StormLength;
	label MaxWindMPH="Max Wind (MPH)"
			MinPressure = "Minimum Pressure"
			StartDate = "Start Date"
			StormLength ="Length of Storm (Days)";
	by BasinName;
run;

title;