**************************************************;
*  Activity 5.07                                 *;
*    Run the program and examine the results to  *;
*    see examples of other procedures that       *;
*    analyze and report on the data.             *;
**************************************************;

%let Year=2016;
%let basin=NA;

**************************************************;
*  Creating a Map with PROC SGMAP                *;
*   Requires SAS 9.4M5 or later                  *;
**************************************************;
data mapee;
	set pg1.storm_final;
	where season = 2016;	
run;
proc freq data=mapee order=freq;
	tables BasinName /nocum;
run;
*Preparing the data for map labels;
data map;
	set pg1.storm_final;
	length maplabel $ 20;
	where season=&year and basin="&basin";
	if maxwindmph<100 then MapLabel=" ";
	else maplabel=cats(name,"-",maxwindmph,"mph");
	keep lat lon maplabel maxwindmph;
run;

*Creating the map;
title1 "Tropical Storms in &year Season";
title2 "Basin=&basin";
footnote1 "Storms with MaxWind>100mph are labeled";

proc sgmap plotdata=map;
    *openstreetmap;
    esrimap url='http://services.arcgisonline.com/arcgis/rest/services/World_Physical_Map';
            bubble x=lon y=lat size=maxwindmph / datalabel=maplabel datalabelattrs=(color=red size=8);
run;
title;footnote;

**************************************************;
*  Creating a Bar Chart with PROC SGPLOT         *;
**************************************************;
title "Number of Storms in &year";
proc sgplot data=pg1.storm_final;
	where season=&year;
	vbar BasinName / datalabel dataskin=matte categoryorder=respdesc;
	xaxis label="Basin";
	yaxis label="Number of Storms";
run;

**************************************************;
*  Creating a Line PLOT with PROC SGPLOT         *;
**************************************************;
title "Number of Storms By Season Since 2010";
proc sgplot data=pg1.storm_final;
	where Season>=2010;
	vline Season / group=BasinName lineattrs=(thickness=1);
	yaxis label="Number of Storms";
	xaxis label="Basin";
run;

**************************************************;
*  Creating a Report with PROC TABULATE          *;
**************************************************;

proc format;
    value count 25-high="lightsalmon";
    value maxwind 90-high="lightblue";
run;

title "Storm Summary since 2000";
footnote1 "Storm Counts 25+ Highlighted";
footnote2 "Max Wind 90+ Highlighted";

proc tabulate data=pg1.storm_final format=comma5.;
	where Season>=2000;
	var MaxWindMPH;
	class BasinName;
	class Season;
	table Season={label=""} all={label="Total"}*{style={background=white}},
		BasinName={LABEL="Basin"}*(MaxWindMPH={label=" "}*N={label="Number of Storms"}*{style={background=count.}} 
		MaxWindMPH={label=" "}*Mean={label="Average Max Wind"}*{style={background=maxwind.}}) 
		ALL={label="Total"  style={vjust=b}}*(MaxWindMPH={label=" "}*N={label="Number of Storms"} 
		MaxWindMPH={label=" "}*Mean={label="Average Max Wind"})/style_precedence=row;
run;
title;
footnote;

title1 'Weather Statistics by Park and Year';
proc means data=pg1.np_westweather mean min max maxdec=2;
	var precip Snow Tempmin Tempmax;
	class Year Name;
run;

proc means data=pg1.np_westweather noprint;
where precip ne 0;
	var precip;
	class Name year;
	ways 2;
	output out=rainstats n=RainDays sum=TotalRain;
run;

title1 'Rain Statistics by Year and Park';
proc print data=rainstats label noobs;
	var Name Year Raindays TotalRain;
	label Name="Park Name"
	RainDays ="Number of days raining"
	TotalRain="Total rain Amount (inches)";
run;
title;

proc means data=Pg1.np_multiyr noprint;
	var Visitors;
	Class Region Year;
	Ways 2;
	output out=top3parks(drop=_freq_ _type_)
	sum=TotalVisitors /*sum total visitors* */
	idgroup (max(Visitors) /*find the max of visitors*; */
	out [3] /*top3*; */
	(Visitors ParkName)=); *output column for top 3 parks*;
run;
	



