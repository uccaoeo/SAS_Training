proc means data=pg1.storm_final;
	var MaxWindMPH;
run;

proc means data=sashelp.heart mean median std maxdec=1;
	var Height Weight Cholesterol;
	class Chol_Status BP_Status;
	ways 1;
run;   


proc means data=pg1.storm_final mean median min max maxdec=0;
	var MaxWindMPH;
run;

proc means data=pg1.storm_final mean median min max maxdec=0;
	var MaxWindMPH;
	class BasinName; *The class function helps you group the data by BasinName and calculate
	summary statistics for the grouped BasinName*;
run;


proc means data=pg1.storm_final mean median min max maxdec=0;
	var MaxWindMPH;
	class BasinName StormType; *The class function helps you group the data by BasinName and calculate
	summary statistics for the grouped BasinName*;
run;

proc means data=pg1.storm_final mean median min max maxdec=0;
	var MaxWindMPH;
	class BasinName StormType;
	ways 1;
run;

proc means data=pg1.storm_final mean median min max maxdec=0;
	var MaxWindMPH;
	class BasinName StormType;
	ways 0 1 2; 
	*0 is for overall statistics, 1 will split the result by Class, 2 will combine the Class together in a table*;
run;