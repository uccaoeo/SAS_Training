**working with CSV files**;
proc import datafile="S:/workshop/EPG1V2/data/storm_damage.csv" dbms=csv
			out=storm_damage_import replace;  /*the OUT tells you where you want to store your output data..by default is 
			is saved to the work library, you can also specify the library you wan to save it;
			the REPLACE  functions tells you that the file should be replace peradventure it already exists*/
run;
proc contents data=storm_damage_import;
run;
/* CLASS ACTIVITY*/

proc import datafile="S:/workshop/EPG1V2/data/storm_damage.tab" dbms=tab 
			out=storm_damage_tab replace;
run;
proc contents data=storm_damage_tab;
run;

/* YOu can also use the proc import to read Excel files too, but it only read one sheet at atime*/
proc import datafile="S:/workshop/EPG1V2/data/class.xlsx" dbms=xlsx out=class_excel replace;
sheet=class_test;
run;
proc contents data=class_excel;
run;

/*CLASS ACTIVITY 2*/
proc import datafile="S:/workshop/EPG1V2/data/np_traffic.csv" dbms=csv out=traffic replace;
guessingrows=max;
run;
proc contents data=traffic;
run;

proc import datafile="S:/workshop/EPG1V2/data/np_traffic.dat" dbms=dlm out=traffic2 replace;
guessingrows=3000; delimiter="|";
run;
proc contents data=traffic2;
run;
