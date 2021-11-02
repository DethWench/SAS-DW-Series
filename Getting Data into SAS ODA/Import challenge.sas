%web_drop_table(WORK.IMPORT);


FILENAME REFFILE '/home/dethwench0/MA/Facilities.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT; RUN;


%web_open_table(WORK.IMPORT);

LIBNAME MA "/home/dethwench0/MA";

data MA.Facilities_SAS;
%let _EFIERR_ = 0; 
infile '/home/dethwench0/MA/Facilities.csv' delimiter = ',' firstobs=2
	MISSOVER DSD lrecl=32767;
	informat 	BedCt 3.;
	informat 	AreaCd 3.;
	informat	Phone 7.;
	informat	PerDiem 3.2;
	format 	BedCt 3.;
	format 	AreaCd 3.;
	format	Phone 7.;
	format	PerDiem 3.;
input
	BedCt
	AreaCd
	Phone 
	PerDiem
;
if _ERROR_ then call symputx('_EFIERR_',1);  
run;