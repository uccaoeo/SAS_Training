/* DATE FUNCTIONS; */
/* MONTH, YEAR, DAY, WEEKDAY, QTR, */
/* TODAY(), MDY(month, day, year), YRDIF(startdate, enddate, 'age') */

***********************************************************;
*  Using Date Functions                                   *;
***********************************************************;
*  Syntax                                                 *;
*                                                         *;
*  Date function examples:                                *;
*    YEAR (SAS-date)                                      *;
*    MONTH (SAS-date)                                     *;
*    DAY (SAS-date)                                       *;
*    WEEKDAY (SAS-date)                                   *;
*    TODAY ()                                             *;
*    MDY (month, day, year)                               *;
*    YRDIF (startdate, enddate, 'AGE')                    *;
***********************************************************;

***********************************************************;
*  Demo                                                   *;
*    1) Create the column YearsPassed and use the YRDIF   *;
*       function. The difference in years should be based *;
*       on each Date value and today's date.              *;
*    2) Create Anniversary as the day and month of each   *;
*       storm in the current year.                        *;
*    3) Format YearsPassed to round the value to one      *;
*       decimal place, and Date and Anniversary as        *;
*       MM/DD/YYYY. Highlight the DATA step and run the   *;
*       selected code.                                    *;
***********************************************************;

data storm_new;
	set pg1.storm_damage;
	drop Summary;
	YearsPassed = yrdif(Date, today(), 'age');
	Anniversary = mdy(month(Date), day(Date), year(today()));
	format YearsPassed 4.1 Date Anniversary MMDDYY10.;
	*Add assignment and FORMAT statements;
run;

data eu_occ_total;
	set PG1.eu_occ;
	Year = Substr(YearMon, 1, 4);
	Month = Substr(YearMon, 6, 2);
	ReportDate = MDY(Month, 1, Year);
	Total =SUM(Hotel, ShortStay, Camp);
	format Hotel shortStay Camp Total COMMA17. ReportDate monyy7.;
	keep Country Hotel ShortStay Camp ReportDate Total;
	*keep _all_;
run;

data np_summary2;
	set PG1.np_summary;
	*ParkType = scan(ParkName, 2);
	ParkType = scan(ParkName, -1);
/* 	*the scan picks on each word.. positive from left to right and negative from right to left */
	keep Reg Type ParkName ParkType;
run;






