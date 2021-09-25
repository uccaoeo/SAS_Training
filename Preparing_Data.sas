data myclass;
	set sashelp.class;
	where Age >= 15;
	*keep Name Age Sex;
	*drop sex weight;
	format height 4.1 weight 3.;
run;

data PG2.storm_cat5;
	set PG1.storm_summary;
	where MaxWindMPH >= 156 and StartDate >= "01JAN2000"d;
	keep Season Basin Name Type MaxWIndMPH;
run;

data PG2.eu_occ2016;
	set PG1.eu_occ;
	where YearMon like "2016%";
	format Hotel ShortStay Camp COMMA17.;
	DROP Geo;
run;

data PG2.fox;
	set PG1.np_species;
	where Category="Mammal" and UPCASE(Common_Names) like "%FOX%" and UPCASE(Common_Names) not like "%SQUIRREL%";
	DROP Category Record_Status Occurence Nativeness;
run;

proc sort data=PG2.fox out=PG2.fox_sort;
BY common_names;
run;
	
data mammal;
set PG1.np_species;
drop Abundance Seasonality Conservation_Status;
run;

Proc freq data=work.mammal;
tables record_Status;
run;

%let cat = Mammal;
data &cat;
set PG1.np_species;
drop Abundance Seasonality Conservation_Status;
where category = "&cat";
run;

title "The Frequency Table for the &cat Category";
Proc freq data=work.&cat;
tables record_Status;
run;






	
	
