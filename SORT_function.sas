proc sort data=PG1.class_test2 out=test_sort;
by Name;
run;

proc sort data=PG1.class_test2 out=test_sort;
by Name TestScore;
run;

proc sort data=PG1.class_test2 out=test_sort;
by Subject Descending TestScore;
run;

proc sort data=pg1.storm_summary out=storm_sort;
	*where Basin= "NA" or Basin="na";
	where Basin in ("NA" "na");
	by descending MaxWindMPH;
run;


