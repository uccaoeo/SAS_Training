/* CONDITIONAL PROCESSING IF THEN STATEMENT */

data  cars1;
	set sashelp.cars;
	if MSRP<30000 then cost_group = 1;
	if MSRP>=30000 then cost_group = 2;
	keep make model Type MSRP cost_group;
run;

data  cars2;
	set sashelp.cars;
	if MSRP<20000 then cost_group = 1;
	else if MSRP<40000 then cost_group = 2;
	else if MSRP<60000 then cost_group = 3;
	else Cost_group = 4;
	keep make model Type MSRP cost_group;
run;

data  cars3;
	set sashelp.cars;
	if MPG_city >26 and MPG_highway>30 then Efficiency = 1;
	else if MPG_city >20 and MpG_highway >25 then efficiency =2;
	else efficiency=3;
	keep make model MPG_city MpG_highway Efficiency;
run;

data  cars4;
	set sashelp.cars;
	length CarType $ 6;  *Before the conditional statement, define the length of the new variable*;
	if MSRP<60000 then CarType="Basic";
	else CarType = "Luxury";
	keep make model MSRP CarType;
run;

data  cars5;
	set sashelp.cars;
	length Cost_type  $ 4;
	if MSRP<20000 then cost_group=1 and cost_type="Low";
	else if MSRP < 40000 then cost_group=2 and cost_type="Mid";
	else cost_group=3 and cost_type = "High";
run;  * IMPOSSIBLE TO RUN, after THEN, you can only have a STATEMENT not multiple statments*;

data under40 over40;
	set sashelp.cars;
	Length cost_type $ 4;
	keep make model MSRP cost_group cost_type;
	if MSRP<20000 then do;
	Cost_Group=1;
	cost_type="Low";
	output= under40;
	END;
	ELSE IF MSRP<40000 then do;
	cost_group=2;
	cost_type="Mid";
	output=under40;
	end;
	else do;
	cost_group=3;
	cost_type="High";
	output=over40;
	end;
run;

data front rear;
    set sashelp.cars;
    if DriveTrain="Front" then do;
        DriveTrain="FWD";
        output front;
    end;
    else if DriveTrain='Rear' then do;
        DriveTrain="RWD";
        output rear;
    end;
run;




data storm_new;
	set Pg1.storm_summary;
	keep Season Name Basin MinPressure PressureGroup;
	if 0<MinPRessure <= 920 then PressureGroup = 1;
	if MinPressure > 920 then PressureGroup =0;
run;


data storm_cat;
	set pg1.storm_summary;
	keep Name Basin MinPressure StartDate PressureGroup;
	*add ELSE keyword and remove final condition;
	if MinPressure=. then PressureGroup=.;
	else if MinPressure<=920 then PressureGroup=1;
	else PressureGroup=0;
run;

proc freq data=storm_cat;
	tables PressureGroup;
run;


data storm_summary2;
	set pg1.storm_summary;
	*Add a LENGTH statement;
	Length Ocean $ 8;
	keep Basin Season Name MaxWindMPH Ocean;
	*Add assignment statement;
	Basin=UPCASE(Basin);
	OceanCode=substr(Basin,2,1);
	if OceanCode="I" then Ocean="Indian";
	else if OceanCode="A" then Ocean="Atlantic";
	else Ocean="Pacific";
	run;

data Indian Atlantic Pacific;
	set pg1.storm_summary;
	*Add a LENGTH statement;
	Length Ocean $ 8;
	keep Basin Season Name MaxWindMPH Ocean;
	*Add assignment statement;
	Basin=UPCASE(Basin);
	OceanCode=substr(Basin,2,1);
	if OceanCode="I" then do;
	Ocean="Indian";
	output Indian;
	end;
	else if OceanCode="A" then do;
	Ocean="Atlantic";
	output Atlantic;
	end;
	else do;
	Ocean="Pacific";
	output Pacific;
	end;
run;


data park_type;
	set pg1.np_summary;
	Length ParkType $ 8;
	if Type = "NM" then ParkType="Monument";
	else if Type="NP" then ParkType="Park";
	*else if Type="NPRE" or Type= "PRE" or Type= "PRESERVE" then ParkType="Preserve";
	else if Type in ("NPRE", "PRE", "PRESERVE") then ParkType="Preserve";
	else if Type="NS" then ParkType = "Seashore";
	else ParkType="River";
	*Add IF-THEN-ELSE statements;
run;

proc freq data=park_type;
	tables ParkType;
run;


data parks monuments;
	set PG1.np_summary;
	where Type in ("NP", "NM");
	Campers =sum(TentCampers, RVCampers, backcountryCampers, otherCamping);
	format Campers COMMA17.; 
	length ParkType $8;
	if Type ="NP" then do;
	ParkType ="Park";
	output parks;
	end;
	else if Type = "NM" then do;
	ParkType = "Monument";
	output monuments;
	end;
	keep Reg ParkName DayVisits OtherLodging Campers ParkType;
run;


/* SELECT WHEN DO END OTHERWISE DO END END */
data parks monuments;
	set PG1.np_summary;
	where Type in ("NP", "NM");
	Campers =sum(TentCampers, RVCampers, backcountryCampers, otherCamping);
	format Campers COMMA17.; 
	length ParkType $8;
	select (type);
		when ('NP') do;
		ParkType ="Park";
		output parks;
		end;
		otherwise do;
		ParkType="Monument";
		output monuments;
		end;
	end;
	keep Reg ParkName DayVisits OtherLodging Campers ParkType;
run;




