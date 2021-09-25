data new_cars;
	set sashelp.cars;
	where Origin ne "USA";
	profit = MSRP - Invoice;
	Source = "Non-USA Cars";
	format profit dollar10.;
	Keep make model MSRP profit Invoice Source;
run;

data tropical_storm;
	set PG1.storm_summary;
	drop HEM_EW Hem_NS Lat Lon;
	where Type = "TS";
	MaxWindKM = MaxWIndMPH * 1.60934;
	format MaxWindKM 3.;
	Storm_Type = "Tropical Storm";
run;

data storm_length;
	set pg1.storm_summary;
	drop Hem_EW Hem_NS Lat Lon;
	StormLength = EndDate - StartDate;  *Subtract Dates from each other*;
	*Add assignment statement;
run;

/* NUMERICA FUNCTIONS CAN ALSO BE USED. E.G SUM MEAN MEDIAN RANGE MIN MAX N NMISS */

data storm_wingavg;
	set pg1.storm_range;
	WindAVg = Mean(Wind1, Wind2, Wind3, WInd4);
	WindRange = Range(Wind1, Wind2, Wind3, Wind4);
	*Add assignment statements;
run;
/* CHARACTER FUNCTIONS FOR CREATING NEW COLUMNS */

UPCASE, LOWCASE PROPCASE, CATS, SUBSTR
data storm_new;
	set pg1.storm_summary;
	drop Type Hem_EW Hem_NS MinPressure Lat Lon;
	Basin = UPCASE(basin);
	Name =PropCase(Name);
	Hemisphere = CATS(Hem_NS, Hem_EW);
	Ocean = SUBSTR(Basin, 2, 1); 
	Na = SUBSTR(Name, 1,2);
/* 	"First character is column to manipulate, the second number(2) is the position you want to */
/* 	start from, and the last number (1), How many characters to the right you want to pick and that is just 1. */
run;
***********************************************************;
*  Activity 4.06                                          *;
*    1) Add a WHERE statement that uses the SUBSTR        *;
*       function to include rows where the second letter  *;
*       of Basin is P (Pacific ocean storms).             *;
*    2) Run the program and view the log and data. How    *;
*       many storms were in the Pacific basin?            *;
***********************************************************;
*  Syntax                                                 *;
*     SUBSTR (char, position, <length>)                   *;
***********************************************************;

data pacific;
	set pg1.storm_summary;
	drop Type Hem_EW Hem_NS MinPressure Lat Lon;
	where SUBSTR(Basin, 2,1) = "P";
	*Add a WHERE statement that uses the SUBSTR function;
run;





