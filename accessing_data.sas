
libname out "s:\workshop\EPG1V2\output";

data pgcopy1 out.pgcopy2;
	set sashelp.class;
run;

***Reading Excel Files***;
Options VALIDVARNAME=v7;  *format excel file to SAS naming convention for the columns*;
libname xlclass xlsx "s:\workshop\EPG1V2\data\class.xlsx";

proc contents data=xlclass.class_birthdate;
 *the .class_birthdate access the sheets of the workbook xlclas*;
run;

libname xlclass CLEAR; ***clear the library. the data can maintain an active connection which does not make sense***;

***IMPORTING OTHER FILE TYPE ASIDE FROM EXCel or SAS FILE (UNSTruCTURed DATA);
Proc import datafile="path/filename" DBMS=filetype OUT=output_table <REPLACE>;
	<GUESSINGROWS=n/MAX;> **;
run;

proc import datafile=s:\workshop\EPG1V2\data\storm_damage.csv" DBMS=csv 