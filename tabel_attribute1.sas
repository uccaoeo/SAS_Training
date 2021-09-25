****View the table and column attribute of any tables***;

proc contents data="S:\workshop\EPG1V2\data\storm_summary.sas7bdat";
run;

*****OR you can also use LIBREF to get to the data***;

libname mylib base "S:\workshop\EPG1V2\data";

proc contents data=mylib.storm_summary; **you don't have to add the extension*;
run;

**libname mylib clear;* This is used to clear the Library,
 it is active until you delete or end SAS session **;