Proc sql;
	 select Name, Age, Height format 3., BirthDate format date9.
	 	from PG1.class_birthdate;
quit;

proc sql;
	select Name, Age, height *2.54 as HEIGHTCM format 5.1, BirthDate format date9.
	from PG1.class_birthdate;
quit;

**DIFFERENCE & SIMILARITIES BETWEEN PROC PRINT AND PROCSQL OUTPUTS***;
title "PROC PRINT Output";
proc print data=pg1.class_birthdate noobs;
	var Name Age Height Birthdate;
	format Birthdate date9.;
run;

title "PROC SQL Output";
proc sql;
select Name, Age, Height*2.54 as HeightCM format=5.1, Birthdate format=date9.
    from pg1.class_birthdate;
quit;

title;
*****END***************************************************************;


****SORTING AND FILTERING DATA IN PROC SQL WITH WHERE CLASUE *****************;
Proc sql;
	 select Name, Age, Height format 3., BirthDate format date9.
	 	from PG1.class_birthdate
	 	where Age > 14   
	 	order by Height desc; *condition using where and order by SQL clause**;
quit;

proc sql;
select *
	from PG1.storm_final;
quit;

proc sql;
select Season, Name, StartDate format=mmddyy10., MaxWindMPH
	from PG1.storm_final;
quit;

proc sql;
select Season, Propcase(Name) as Name, StartDate format=mmddyy10., MaxWindMPH
	from PG1.storm_final;
quit;


title "International Storms since 2000";
title2 "Category 5 (Wind>156)";
proc sql;
select Season, Propcase(Name) as Name, StartDate format=mmddyy10., MaxWindMPH
	from PG1.storm_final
	where MaxWIndMPH > 156 and Season > 2000
	order by MAxWindMPH desc, Name;
quit;
title;

title "Most Costly Storms";
proc sql;
*Add a SELECT statment;
Select Event, Cost format dollar18., year(Date) as Season 
	from PG1.storm_damage
	where Cost > 25000000000
	order by cost desc;	
quit;
title;

****CREATING AND DROPPING (DELETING ) TABLES IN PROC SQL***;
proc sql; *you can add outobs= to specify the number of rows you want in the output*;
create table work.myclass as 
select Name, Age, Height
	 	from PG1.class_birthdate
	 	where Age > 14
	 	order by Height desc;
quit;
***DELETING TABLE***; *the table is created in the work library and also deleted from there*;
proc sql;
drop table work.myclass;
quit;

****JOINING TABLES IN PROC SQL USING  INNER JOINS OUTER LEFT RIGHT FULL JOINS****;
proc sql;
select Grade as Student_Grade , Age, Teacher
	from PG1.class_update a inner join PG1.class_teachers b
	ON class_update.Name = class_teachers.Name;
quit;
**Testing my alias knowledge***;
proc sql;
select Grade, Age, Teacher
	from PG1.class_update a inner join PG1.class_teachers b
	ON a.Name = b.Name;
quit;

proc sql;
select class_update.Name, Grade, Age, Teacher
	from PG1.class_update  inner join PG1.class_teachers 
	ON class_update.Name = class_teachers.Name;
quit;
**NOTE: Use the class_update.Name to specify which name to use since both (class_update and classteachers)
tables both have the column Name*;

proc sql;
select Season, Name, storm_summary.Basin,BasinName, MaxWindMPH
    from pg1.storm_summary inner join PG1.storm_basincodes
    ON storm_summary.basin = storm_basincodes.basin
    order by Season desc, Name;
quit;

****USING ALIASES, SINCE TYPING FULL TABLE NAME CAN BE TEDIOUS****;
proc sql;
select u.Name, Grade, Age, Teacher
	from PG1.class_update as u inner join PG1.class_teachers as t
	ON u.Name=t.Name;
quit;

proc sql;
select Season, Name, a.Basin, BasinName, MaxWindMPH 
    from pg1.storm_summary as a inner join pg1.storm_basincodes as b
		on  UPCASE(a.Basin)=b.Basin
    order by Season desc, Name;
quit;
**SOME VALUES WERE SMALl letter in THE  STORM SUMMARY BASIN COLUMN..so use UPCASE to include them in the join**;	










