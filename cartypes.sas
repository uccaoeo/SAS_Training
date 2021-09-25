data favcars;
	set sashelp.cars;
	MPGAVG = mean(MPG_City, MPG_Highway);
run;

title "Cars with Average MPG over 35";
proc print data=favcars;
	var make model type MPGAVG;
	where MPGAVG > 35;
run;

title "Average MPG by car type";
proc means data=favcars mean min max maxdec=1;
	var MPGAVG;
	class type;
run;

title;