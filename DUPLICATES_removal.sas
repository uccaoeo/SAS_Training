/* REMOVING DUPLICATE ROWS FROM TABLE */

proc sort data=PG1.class_test3 out=test_clean * keeps the clean table without duplcates*
 	nodupkey /*only first occurence is kept*; */
	dupout=test_dups; *this table stores the duplcated rows*;
	by _all_; *removes all identical rows*;
run;

proc sort data=PG1.class_test3 out=test_clean
	nodupkey
	dupout=test_dups;
	by Name;  *removes the duplcate in the COLUMN (Name)*;
run;

*Step 1;
proc sort data=pg1.storm_detail out=storm_clean nodupkey dupout=storm_dups;
	by _all_;
run;

*Step 2;
proc sort data=pg1.storm_detail out=min_pressure;
	where Pressure is not missing and Name is not missing;
	by descending Season Basin Name Pressure;
run;

*Step 3;
proc sort data=min_pressure nodupkey;
	by  descending Season Basin Name;
run;

proc sort data=PG1.np_summary out=np_sort;
by Reg descending DayVisits;
where Type = "NP";
run;

proc sort data=Pg1.np_largeparks out=park_clean dupout=park_dups nodupkey;
by _all_;
run;


proc sort data=PG1.eu_occ (keep= Geo Country) out=countrylist nodupkey;
by Geo Country;
run;  *The keep function allows you to show only the two columns (Geo and Country)

