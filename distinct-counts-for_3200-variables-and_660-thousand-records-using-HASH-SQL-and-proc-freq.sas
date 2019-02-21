Distinct counts for 3,200 variables and 660 thousand records using HASH SQL and proc freq

  800 numeric and 800 character variables

  github
  https://tinyurl.com/yymhk4yw
  https://github.com/rogerjdeangelis/distinct-counts-for_3200-variables-and_660-thousand-records-using-HASH-SQL-and-proc-freq

  macros
  https://tinyurl.com/y9nfugth
  https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories


  Distinct counts for 3,200 variables and 660,000 records

  It took 92 seconds to get count distinct on 1,000 varables and 3 million obs.

  The Muti Pass HASH is the fastest

   Benchmarks for Distinct counts for 3,200 variables and 660,000 records (8 parallel tasks 400 variables per task)
   =================================================================================================================

        Seconds  Variables   Method
        ------   ---------   ------

     1.   84     3,200   HASH multiple passes, one per variable 3,200 passes

                             1 of 8
                             20FEB2019:17:05:15.51
                             20FEB2019:17:06:38.77
                             elap seconds  83.2599999904632

                             8 of 8
                             20FEB2019:17:05:25.90
                             20FEB2019:17:06:50.15
                             elap seconds  84.2550001144409

     2.  245     3,200   SQL count(distinct) (magic=103 hash)

                             1 of 8
                             MLOGIC(SQLUNQ):  %PUT &beg
                             20FEB2019:17:14:04.90
                             20FEB2019:17:18:02.56
                             elap seconds  237.659000158309

                             8 of 8
                             20FEB2019:17:14:12.09
                             20FEB2019:17:18:17.21
                             elap seconds  245.119000196456


     3.  250     3,200   Hash One Pass (My attempt at a a one pass solution with both numeric and character variables.
                         I am not a skilled HASH programmer,)

                             1 of 8
                             20FEB2019:16:08:38.07
                             20FEB2019:16:13:02.02
                             elap seconds  263.953999996185

                             8 of 8
                             20FEB2019:16:08:47.82
                             20FEB2019:16:13:05.20
                             elap seconds  257.385999917984

     4.  440     3,200   Freq nlevels Outputs one dataset
                             1 of 8
                             20FEB2019:16:25:54.06
                             20FEB2019:16:25:54.06
                             elap seconds  440.25200009346

                             8 of 8
                             20FEB2019:16:18:45.12
                             20FEB2019:16:26:06.68
                             elap seconds  441.558000087738


     ** for more normalized tables the differences are nuch less (ie 50 variables and a million obs)

  github
  https://tinyurl.com/y8srtnsz
  https://github.com/rogerjdeangelis/utl-fast-algorithms-for-count-distinct-levels-for-10000-variables-and-3-million-records-sort-sql-fre

  inspired by
  https://communities.sas.com/t5/SAS-Programming/Distinct-values-for-all-columns-in-dataset/m-p/530918


INPUT
=====

 3,200 variables and 660.000 observations  (800 numeric and 800 character)

 Middle Observation(330,000 ) of Last dataset = WORK.ALL - Total Obs 660.000


  -- CHARACTER --  (1,600 Variables)

 namMaleChild1          C6       EBBFBB
 namMaleChild2          C6       BDAECB
 namMaleChild3          C6       ECFABF
 namMaleChild4          C6       EBBE
 namMaleChild5          C6       AFAF
 namMaleChild6          C6       EFDD
 namMaleChild7          C6       FBAA
 namMaleChild8          C6       ABAC
 namMaleChild9          C6       FFAF
 namMaleChild10         C6       EEF
 ....
 namMaleChild1591       C6       ECD
 namMaleChild1592       C6       ECC
 namMaleChild1593       C6       FAF
 namMaleChild1594       C6       CBA
 namMaleChild1595       C6       CCF
 namMaleChild1596       C6       FCD
 namMaleChild1597       C6       BDD
 namMaleChild1598       C6       DDB
 namMaleChild1599       C6       AFD
 namMaleChild1600       C6       CBD
...
...
...
  -- numeric --  (1,600 variables)

 ageMaleChild1          N8       76
 ageMaleChild2          N8       57
 ageMaleChild3          N8       95
 ageMaleChild4          N8       192
 ageMaleChild5          N8       11
 ageMaleChild6          N8       96
 ageMaleChild7          N8       133
 ageMaleChild8          N8       11
 ageMaleChild9          N8       114
 ageMaleChild10         N8       197
...
 AgeMaleChild1591       N8       9294
 AgeMaleChild1592       N8       1158
 AgeMaleChild1593       N8       655
 AgeMaleChild1594       N8       7788
 AgeMaleChild1595       N8       9731
 AgeMaleChild1596       N8       3276
 AgeMaleChild1597       N8       9376
 AgeMaleChild1598       N8       4687
 AgeMaleChild1599       N8       770
 AgeMaleChild1600       N8       203


* slit the data up for fasting I/O could use SPDE and have one dataset;
* spread the data around (note Dell T7400 has a 1000 watt power supply so it supports many SSDs;
* 250gd SSDs at about $35 each;
* too lazy to try SPDE;

libname d1 "c:/wrk/";
libname d2 "d:/wrk/";
libname d3 "e:/wrk/";
libname d4 "c:/wrk/";
libname d5 "d:/wrk/";
libname d6 "e:/wrk/";
libname d7 "d:/wrk/";
libname d8 "e:/wrk/";

data
     d1.d1( keep=   num1-num200     chr1-chr200
           rename=(   num1-num200 = ageMaleChild1   -ageMaleChild200      chr1-chr200 = namMaleChild1   -namMaleChild200 ))
     d2.d2( keep= num201-num400   chr201-chr400
           rename=( num201-num400 = ageMaleChild201 -ageMaleChild400    chr201-chr400 = namMaleChild201 -namMaleChild400 ))
     d3.d3( keep= num401-num600   chr401-chr600
           rename=( num401-num600 = ageMaleChild401 -ageMaleChild600    chr401-chr600 = namMaleChild401 -namMaleChild600 ))
     d4.d4( keep= num601-num800   chr601-chr800
           rename=( num601-num800 = ageMaleChild601 -ageMaleChild800    chr601-chr800 = namMaleChild601 -namMaleChild800 ))
     d5.d5( keep= num801-num1000  chr801-chr1000
           rename=( num801-num1000= ageMaleChild801 -ageMaleChild1000   chr801-chr1000= namMaleChild801 -namMaleChild1000))
     d6.d6( keep=num1001-num1200 chr1001-chr1200
           rename=(num1001-num1200= ageMaleChild1001-ageMaleChild1200  chr1001-chr1200= namMaleChild1001-namMaleChild1200))
     d7.d7( keep=num1201-num1400 chr1201-chr1400
           rename=(num1201-num1400= ageMaleChild1201-ageMaleChild1400  chr1201-chr1400= namMaleChild1201-namMaleChild1400))
     d8.d8( keep=num1401-num1600 chr1401-chr1600
           rename=(num1401-num1600= ageMaleChild1401-ageMaleChild1600  chr1401-chr1600= namMaleChild1401-namMaleChild1600))
     ;

     retain seq;

     call streaminit(1234);

     array nums[1600]    num1-num1600;
     array chrs[1600] $6 chr1-chr1600;
     array ltrs[6] $1 ltr1-ltr6 ("A","B","C","D","E","F");

     do seq=1 to 660000;
        do i=1 to 1600;
             select;
                when (i<4)  nums[i]=ceil(100*rand('uniform'));
                when (i<12) nums[i]=ceil(200*rand('uniform'));
                otherwise   nums[i]=ceil(10000*rand('uniform'));
             end;
             select;
                when (i<4)  do; link cattle; chrs[i]=catLtr; end;
                when (i<10) do; link cattle; chrs[i]=Substr(catLtr,3); end;
                otherwise   do; link cattle; chrs[i]=Substr(catLtr,4); end;
             end;
        end;
        output;
     end;

     return;
     cattle:
       catLtr=cats(
          ltrs[ceil(6*rand('uniform'))]
         ,ltrs[ceil(6*rand('uniform'))]
         ,ltrs[ceil(6*rand('uniform'))]
         ,ltrs[ceil(6*rand('uniform'))]
         ,ltrs[ceil(6*rand('uniform'))]
         ,ltrs[ceil(6*rand('uniform'))]
       );
    return;
run;quit;

*                            _   _           _
 _ __ ___   __ _ _ __  _   _| | | | __ _ ___| |__
| '_ ` _ \ / _` | '_ \| | | | |_| |/ _` / __| '_ \
| | | | | | (_| | | | | |_| |  _  | (_| \__ \ | | |
|_| |_| |_|\__,_|_| |_|\__, |_| |_|\__,_|___/_| |_|
                       |___/
;


filename ft15f001 "c:/oto/hashUnq.sas"; * thanks Data_null_;
parmcards4;
%macro hashUnq(drv,inp);

    %utlnopts;

    /*
    %let inp=d1.d1;
    %let drv=c;
    */
    %local ref;

    *options nothreads nosymbolgen nomlogic nomacrogen nosource nosource2 nonotes nofullstimer NOQUOTELENMAX;

    %let beg = %sysfunc(putn(%sysfunc(datetime()), datetime23.2));
    %let begsec = %sysfunc(datetime());

    %let ref = %scan(&inp,1,%str(.));

    libname &ref "&drv.:/wrk/" /*filelockwait=10*/;

    libname sd1 "d:/sd1" /*filelockwait=10*/;

    proc transpose data=&inp(obs=1) out=xpo;
    var _all_;
    run;quit;

    proc sql noprint;
       select _name_ into :nam1- from xpo
    ;quit;

    %let namn=&sqlobs;

    sasfile &inp load;

    data _null_;

      length tbl $32; * important;

      do tbl=%do_over(nam,phrase="?  ",between=comma);

         call symputx('tbl',tbl);

         call execute('
            data &tbl;
              if _n_=0 then set &inp(keep=&tbl);
              if _n_ = 1 then do;
                dcl hash h(dataset:"&inp.(keep=&tbl)", duplicate: "r");
                h.defineKey("&tbl");
                h.defineDone();
                call missing(&tbl);
              end;
              cnt&tbl = h.num_items;
              drop &tbl;
              output;
              stop;
            run;
         ');

      end;

      stop;

    run;quit;

    data sd1.mrg&ref;
      merge
        %do_over(nam,phrase=?)
      ;
    run;quit;

    proc transpose data=sd1.mrg&ref out=sd1.mini&ref;
    var _all_;
    run;quit;

    %put &beg;
    %put %sysfunc(putn(%sysfunc(datetime()), datetime23.2));
    %put elap seconds  %sysevalf(%sysfunc(datetime())-&begsec);

    sasfile &inp close;

%mend hashUnq;
;;;;
run;quit;

%hashUnq(c,d1.d1);

* pause for a second between submission. May not be needed;
%macro paus;
 data _null_;
   put "begin";
   call sleep(1,1);
   put "end";
 run;quit;
%mend paus;

%let _s=%sysfunc(compbl(C:\Progra~1\SASHome\SASFoundation\9.4\sas.exe -sysin c:\nul -rsasuser
  -sasautos c:\oto -work d:\wrk -config c:\cfg\cfgsas.cfg -autoexec c:/oto/tut_oto.sas));

%utlopts;
* set up;

systask kill sys1 sys2 sys3 sys4 sys5 sys6 sys7 sys8;
systask command "&_s -termstmt %nrstr(%hashUnq(c,d1.d1);) -log d:\log\a1.log" taskname=sys1; %paus;
systask command "&_s -termstmt %nrstr(%hashUnq(d,d2.d2);) -log d:\log\a2.log" taskname=sys2; %paus;
systask command "&_s -termstmt %nrstr(%hashUnq(e,d3.d3);) -log d:\log\a3.log" taskname=sys3; %paus;
systask command "&_s -termstmt %nrstr(%hashUnq(c,d4.d4);) -log d:\log\a4.log" taskname=sys4; %paus;
systask command "&_s -termstmt %nrstr(%hashUnq(d,d5.d5);) -log d:\log\a5.log" taskname=sys5; %paus;
systask command "&_s -termstmt %nrstr(%hashUnq(e,d6.d6);) -log d:\log\a6.log" taskname=sys6; %paus;
systask command "&_s -termstmt %nrstr(%hashUnq(d,d7.d7);) -log d:\log\a7.log" taskname=sys7; %paus;
systask command "&_s -termstmt %nrstr(%hashUnq(e,d8.d8);) -log d:\log\a8.log" taskname=sys8; %paus;

*          _
 ___  __ _| |
/ __|/ _` | |
\__ \ (_| | |
|___/\__, |_|
        |_|
;


filename ft15f001 "c:/oto/sqlUnq.sas"; * thanks Data_null_;
parmcards4;
%macro sqlUnq(drv,inp);

    /*
    %let inp=d1.d1;
    %let drv=c;
    */
    %local ref;

    %utlopts;

    %let beg = %sysfunc(putn(%sysfunc(datetime()), datetime23.2));
    %let begsec = %sysfunc(datetime());

    %let ref = %scan(&inp,1,%str(.));

    libname &ref "&drv.:/wrk/" /*filelockwait=10*/;

    libname sd1 "d:/sd1" /*filelockwait=10*/;

    proc transpose data=&inp(obs=1) out=xpo;
    var _all_;
    run;quit;

    proc sql noprint;
       select _name_ into :nams1- from xpo
    ;quit;

    %let namsn=&sqlobs;

    sasfile &inp load;

    proc sql magic=103;
       create
         table sd1.sql&ref as
       select
         %do_over(nams,between=comma,phrase=
           count(distinct ?) as ?
         )
       from
         &inp
    ;quit;

    %put &beg;
    %put %sysfunc(putn(%sysfunc(datetime()), datetime23.2));
    %put elap seconds  %sysevalf(%sysfunc(datetime())-&begsec);

    sasfile &inp close;

%mend sqlUnq;
;;;;
run;quit;

* test interactively;
options obs=100;
%utlopts;
%sqlUnq(c,d1.d1);
options obs=max;


* pause for a second between submission. May not be needed;
%macro paus;
 data _null_;
   put "begin";
   call sleep(1,1);
   put "end";
 run;quit;
%mend paus;


%let _s=%sysfunc(compbl(C:\Progra~1\SASHome\SASFoundation\9.4\sas.exe -sysin c:\nul -rsasuser
  -sasautos c:\oto -work i:\wrk -config c:\cfg\cfgsas.cfg));

%utlopts;
* set up;

systask kill sys1 sys2 sys3 sys4 sys5 sys6 sys7 sys8;
systask command "&_s -termstmt %nrstr(%sqlUnq(c,d1.d1);) -log d:\log\a1.log" taskname=sys1; %paus;
systask command "&_s -termstmt %nrstr(%sqlUnq(d,d2.d2);) -log d:\log\a2.log" taskname=sys2; %paus;
systask command "&_s -termstmt %nrstr(%sqlUnq(e,d3.d3);) -log d:\log\a3.log" taskname=sys3; %paus;
systask command "&_s -termstmt %nrstr(%sqlUnq(c,d4.d4);) -log d:\log\a4.log" taskname=sys4; %paus;
systask command "&_s -termstmt %nrstr(%sqlUnq(d,d5.d5);) -log d:\log\a5.log" taskname=sys5; %paus;
systask command "&_s -termstmt %nrstr(%sqlUnq(e,d6.d6);) -log d:\log\a6.log" taskname=sys6; %paus;
systask command "&_s -termstmt %nrstr(%sqlUnq(d,d7.d7);) -log d:\log\a7.log" taskname=sys7; %paus;
systask command "&_s -termstmt %nrstr(%sqlUnq(e,d8.d8);) -log d:\log\a8.log" taskname=sys8; %paus;

* there appears to be a bug with wait for it termonates some tasks prematurely?;
*waitfor sys1 sys2 sys3 sys4 sys5 sys6 sys7 sys8;
systask kill sys1 sys2 sys3 sys4 sys5 sys6 sys7 sys8;

*
  ___  _ __   ___   _ __   __ _ ___ ___
 / _ \| '_ \ / _ \ | '_ \ / _` / __/ __|
| (_) | | | |  __/ | |_) | (_| \__ \__ \
 \___/|_| |_|\___| | .__/ \__,_|___/___/
                   |_|
;

* load macro into autocall libarary;

filename ft15f001 "c:/oto/hashTwo.sas"; * thanks Data_null_;
parmcards4;
%macro hashTwo(drv,tbl);

/*
 %let drv=c;
 %let tbl=d1.d1;
sasfile &tbl CLOSE;
%utlnopts;
*/

%let libLnk = %scan(&tbl.,1,%str(.));
libname &libLnk. "&drv.:/wrk/" /*filelockwait=10*/;

* output;
libname sd1 "d:/sd1" /*filelockwait=10*/;

sasfile &tbl load;

* just in case;
%symdel chrs nums / nowarn;

%let beg = %sysfunc(putn(%sysfunc(datetime()), datetime23.2));
%let begsec = %sysfunc(datetime());

%let nums=%utl_varlist(&tbl,keep=_numeric_);
%let chrs=%utl_varlist(&tbl,keep=_character_);

data _null_ ;

  * get variable name meta data;
  if _n_=0 then set &tbl;

  dcl hash h1 (ordered:"A") ;
  h1.definekey  ("nvar", "_n_") ;
  h1.definedata ("nvar") ;
  h1.definedone () ;
  dcl hash h2 (ordered:"A") ;
  h2.definekey  ("cvar", "cnt") ;
  h2.definedata ("cvar") ;
  h2.definedone () ;
  do until (end) ;
    set &tbl  end = end ;
    array nn (Nvar) &nums;
    array cc (Cvar) &chrs;
    cnt=put(_n_,z7.);
    do over nn ;
      h1.ref (key:nvar, key:nn, data:nvar) ;
    end ;
    do over cc ;
      h2.ref (key:cvar, key:cc, data:cvar) ;
    end ;
  end ;
  h1.output (dataset: "hash1");
  h2.output (dataset: "hash2");
  STOP;
run;quit;

* Quickly count levels;
data sd1.&libLnk. ;
  array chrs &chrs;
  array nums &chrs;
  do Count = 1 by 1 until (last.NVAR) ;
    set hash1 ;
    by NVAR ;
  end ;
  cntC+1;
  var=vname(nums[cntC]);
  output;
  do Count = 1 by 1 until (last.CVAR) ;
    set hash2 ;
    by CVAR ;
  end ;
  cntN+1;
  var=vname(chrs[cntN]);
  output;
  keep count var;
run ;

%put &beg;
%put %sysfunc(putn(%sysfunc(datetime()), datetime23.2));
%put elap seconds  %sysevalf(%sysfunc(datetime())-&begsec);

sasfile &tbl close;

%mend hashTwo;
;;;;
run;quit;


* test interactively;
%utlnopts;
sasfile d1.d1 close;
libname d1 clear;
%hashtwo(c,d1.d1);


* pause for a second between submission. May not be needed;
%macro paus;
 data _null_;
   put "begin";
   call sleep(1,1);
   put "end";
 run;quit;
%mend paus;


%let _s=%sysfunc(compbl(C:\Progra~1\SASHome\SASFoundation\9.4\sas.exe -sysin c:\nul -rsasuser
  -sasautos c:\oto -work d:\wrk -config c:\cfg\cfgsas.cfg -autoexec c:/oto/tut_oto.sas));

%utlopts;
* set up;

systask kill sys1 sys2 sys3 sys4 sys5 sys6 sys7 sys8;
systask command "&_s -termstmt %nrstr(%hashTwo(c,d1.d1);) -log d:\log\a1.log" taskname=sys1; %paus;
systask command "&_s -termstmt %nrstr(%hashTwo(d,d2.d2);) -log d:\log\a2.log" taskname=sys2; %paus;
systask command "&_s -termstmt %nrstr(%hashTwo(e,d3.d3);) -log d:\log\a3.log" taskname=sys3; %paus;
systask command "&_s -termstmt %nrstr(%hashTwo(c,d4.d4);) -log d:\log\a4.log" taskname=sys4; %paus;
systask command "&_s -termstmt %nrstr(%hashTwo(d,d5.d5);) -log d:\log\a5.log" taskname=sys5; %paus;
systask command "&_s -termstmt %nrstr(%hashTwo(e,d6.d6);) -log d:\log\a6.log" taskname=sys6; %paus;
systask command "&_s -termstmt %nrstr(%hashTwo(d,d7.d7);) -log d:\log\a7.log" taskname=sys7; %paus;
systask command "&_s -termstmt %nrstr(%hashTwo(e,d8.d8);) -log d:\log\a8.log" taskname=sys8;

* __
 / _|_ __ ___  __ _
| |_| '__/ _ \/ _` |
|  _| | |  __/ (_| |
|_| |_|  \___|\__, |
                 |_|
;

filename ft15f001 "c:/oto/frq8.sas"; * thanks Data_null_;
parmcards4;
%macro frq8(drv,tbl);

    %utlopts;
    %let libLnk = %scan(&tbl.,1,%str(.));
    libname &libLnk. "&drv.:/wrk/" /*filelockwait=10*/;

    * output;
    libname sd1 "d:/sd1" /*filelockwait=10*/;

    sasfile &tbl load;

    * just in case;
    %symdel chrs nums / nowarn;

    %let beg = %sysfunc(putn(%sysfunc(datetime()), datetime23.2));
    %let begsec = %sysfunc(datetime());

    ods exclude all;
    ods output nlevels=sd1.&libLnk.;
    proc freq data=&tbl nlevels;
    run;quit;
    ods select all;

    %put &beg;
    %put %sysfunc(putn(%sysfunc(datetime()), datetime23.2));
    %put elap seconds  %sysevalf(%sysfunc(datetime())-&begsec);

    sasfile &tbl. close;

%mend frq8;
;;;;
run;quit;

* interactive;

%let beg = %sysfunc(putn(%sysfunc(datetime()), datetime23.2));
%let begsec = %sysfunc(datetime());

%frq8(c,d1.d1);

libname d1 clear;
sasfile d1.d1 close;

%put &beg;
%put %sysfunc(putn(%sysfunc(datetime()), datetime23.2));
%put elap seconds  %sysevalf(%sysfunc(datetime())-&begsec);


%let _s=%sysfunc(compbl(C:\Progra~1\SASHome\SASFoundation\9.4\sas.exe -sysin c:\nul -rsasuser
  -sasautos c:\oto -work d:\wrk -config c:\cfg\cfgsas.cfg -autoexec c:/oto/tut_oto.sas));

%utlopts;
* set up;

systask kill sys1 sys2 sys3 sys4 sys5 sys6 sys7 sys8;
systask command "&_s -termstmt %nrstr(%frq8(c,d1.d1);) -log d:\log\a1.log" taskname=sys1; %paus;
systask command "&_s -termstmt %nrstr(%frq8(d,d2.d2);) -log d:\log\a2.log" taskname=sys2; %paus;
systask command "&_s -termstmt %nrstr(%frq8(e,d3.d3);) -log d:\log\a3.log" taskname=sys3; %paus;
systask command "&_s -termstmt %nrstr(%frq8(c,d4.d4);) -log d:\log\a4.log" taskname=sys4; %paus;
systask command "&_s -termstmt %nrstr(%frq8(d,d5.d5);) -log d:\log\a5.log" taskname=sys5; %paus;
systask command "&_s -termstmt %nrstr(%frq8(e,d6.d6);) -log d:\log\a6.log" taskname=sys6; %paus;
systask command "&_s -termstmt %nrstr(%frq8(d,d7.d7);) -log d:\log\a7.log" taskname=sys7; %paus;
systask command "&_s -termstmt %nrstr(%frq8(e,d8.d8);) -log d:\log\a8.log" taskname=sys8;

* there appears to be a bug with wait for it termonates some tasks prematurely?;
*waitfor sys1 sys2 sys3 sys4 sys5 sys6 sys7 sys8;
systask kill sys1 sys2 sys3 sys4 sys5 sys6 sys7 sys8;



