proc export data=sashelp.cars 
	outfile="S:/workshop/EPG1V2/output/cars.txt" 
	dbms=tab REPLACE;
run;

proc export data=PG1.storm_final
	outfile="S:/workshop/EPG1V2/output/storm_final.csv" dbms=csv REPLACE;
run;

proc export data=PG1.storm_final
	outfile="&outpath/storm_final.csv" dbms=csv REPLACE; 
	*make sure the path has no quotation marks, if not it will lead to double quotation marks and will
	generate errors*;
run;

libname myxls xlsx "&outpath/cars.xlsx"; *New WOrkbook*;

data myxls.asia_cars; *asia_cars is a worksheet in the myxls workbook*;
	set sashelp.cars;
	where Origin = 'Asia';
run;
libname myxls clear;

*ACTIVITY*;
libname xl_lib xlsx "&outpath/storm.xlsx" ;
data xl_lib.storm_final;
	set pg1.storm_final;
	drop Lat Lon Basin OceanCode;
run;
libname xl_lib clear;

data South_Pacific;
	set pg1.storm_final;
	where Basin="SP";
run;

proc means data=pg1.storm_final noprint maxdec=1;
	where Basin="SP";
	var MaxWindKM;
	class Season;
	ways 1;
	output out=Season_Stats n=Count mean=AvgMaxWindKM max=StrongestWindKM;
run;

libname xlout xlsx "&outpath/South_pacific.xlsx";
data xlout.South_Pacific;  *"xlout addede before the output table"*;
	set pg1.storm_final;
	where Basin="SP";
run;

proc means data=pg1.storm_final noprint maxdec=1;
	where Basin="SP";
	var MaxWindKM;
	class Season;
	ways 1;
	output out=xlout.Season_Stats n=Count mean=AvgMaxWindKM max=StrongestWindKM;
run;
libname xlout clear;

*ODS PROCEDURE for EXPORTING FILES (CSV)*;
ODS csvall file="&outpath/cars.csv";
proc print data=sashelp.cars noobs;
	var Make Model Type MSRP MPG_City MPG_Highway;
	format MSRP dollar8.;
run;
ODS csvall close;

*EXPORTING EXCEL FILES*;
proc template;
	list styles;
run;
*Add ODS statement; 
ODS EXCEL file="&outpath/wind.xlsx" style=sasdocprinter options(sheet_name='Wind Stats');
title "Wind Statistics by Basin";
ods noproctitle;
proc means data=pg1.storm_final min mean median max maxdec=0;
    class BasinName;
    var MaxWindMPH;
run;
ODS EXCEL options(sheet_name='Wind Distribution');
title "Distribution of Maximum Wind";
proc sgplot data=pg1.storm_final;
    histogram MaxWindMPH;
    density MaxWindMPH;
run; 
title;  
ods proctitle;
*Add ODS statement;
ODS EXCEl close;
*CLASS ACTIVITY*;
*Add ODS statement;
ODS EXCEL file="&outpath/pressure.xlsx";
*ODS EXCEL file="&outpath/pressure.xlsx" style=analysis;
title "Minimum Pressure Statistics by Basin";
ods noproctitle;
proc means data=pg1.storm_final mean median min maxdec=0;
    class BasinName;
    var MinPressure;
run;

title "Correlation of Minimum Pressure and Maximum Wind";
proc sgscatter data=pg1.storm_final;
	plot minpressure*maxwindmph;
run;
title;  

*Add ODS statement;
ODS EXCEL CLOSE;
ods proctitle;


ods PowerPoint file="&outpath/pressure.pptx" style=powerpointlight;

title "Minimum Pressure Statistics by Basin";
ods noproctitle;
proc means data=pg1.storm_final mean median min maxdec=0;
    class BasinName;
    var MinPressure;
run;

title "Correlation of Minimum Pressure and Maximum Wind";
proc sgscatter data=pg1.storm_final;
	plot minpressure*maxwindmph;
run;
title;  

ods Powerpoint close;
*MICROSOFT WORD OR RICH TEXT FORMAT(RTF);
ods RTF file="&outpath/pressure.rtf" style=sapphire STARTPAGE=NO;
*Startpage removes the pagebreaks and allows both graph to be on the same page*;

title "Minimum Pressure Statistics by Basin";
ods noproctitle;
proc means data=pg1.storm_final mean median min maxdec=0;
    class BasinName;
    var MinPressure;
run;

title "Correlation of Minimum Pressure and Maximum Wind";
proc sgscatter data=pg1.storm_final;
	plot minpressure*maxwindmph;
run;
title;  

ods RTF close;

***PDF EXPORT USING ODS PROCEDURE***;
ods pdf file="&outpath/wind.pdf" startpage=NO  style=journal pdftoc=1;
ods noproctitle;
ods proclabel "Wind Statistics";
title "Wind Statistics by Basin";
proc means data=pg1.storm_final min mean median max maxdec=0;
    class BasinName;
    var MaxWindMPH;
run;
ods proclabel 'Wind Distribution';
title "Distribution of Maximum Wind";
proc sgplot data=pg1.storm_final;
    histogram MaxWindMPH;
    density MaxWindMPH;
run; 
title;  

ods proctitle;
ods pdf close;

*CLASS ACTIVITY 1*;
ODS EXCEL file="&outpath/StormStats.xlsx" style=snow options(sheet_name='South Pacific Summary');
ODS noproctitle;
title;
proc means data=pg1.storm_detail maxdec=0 median max;
    class Season;
    var Wind;
    where Basin='SP' and Season in (2014,2015,2016);
run;
ODS EXCEL options(sheet_name='Detail');
proc print data=pg1.storm_detail noobs;
    where Basin='SP' and Season in (2014,2015,2016);
    by Season;
run;
ODS proctitle;
ODS EXCEL CLOSE;

*CLASS ACTIVITY 2*;
ODS RTF file="&outpath/ParkReport.rtf" style=journal startpage=No ;
options Nodate;
ODS noproctitle;
title "US National Park Regional Usage Summary";


proc freq data=pg1.np_final;
    tables Region /nocum;
run;
ODS RTF style=journal;
proc means data=pg1.np_final mean median max nonobs maxdec=0;
    class Region;
    var DayVisits Campers;
run;
ODS RTF style=sasdocprinter;
title2 'Day Visits vs. Camping';
proc sgplot data=pg1.np_final;
    vbar  Region / response=DayVisits;
    vline Region / response=Campers ;
run;
title;
ODS proctitle;
ODS RTF close;
options date;

*CLASS ACTIVITY 3*;
options orientation=landscape; *change th elayout to landscape*;
ODS PDF file="&ouTPATH/STORMSUMMARY.PDF" STYLE=JOURNAL nobookmarkgen;
title1 "2016 Northern Atlantic Storms";
ods layout gridded columns=2 rows=1;
ods region;
proc sgmap plotdata=pg1.storm_final;
    *openstreetmap;
    esrimap url='http://services.arcgisonline.com/arcgis/rest/services/World_Physical_Map';
    bubble x=lon y=lat size=maxwindmph / datalabel=name datalabelattrs=(color=red size=8);
    where Basin='NA' and Season=2016;
    keylegend 'wind';
run;
ods region;
proc print data=pg1.storm_final noobs;
	var name StartDate MaxWindMPH StormLength;
	where Basin="NA" and Season=2016;
	format StartDate monyy7.;
run;
ods layout end;
ods pdf close;
options orientation=portrait;



