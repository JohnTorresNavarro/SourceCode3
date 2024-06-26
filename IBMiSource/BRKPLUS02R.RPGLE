000100171229
000200180131       Ctl-Opt option(*noDebugIo) DftActGrp(*no) ActGrp(*New);
000300171227
000400171229      *-------------------------------------------------------------------------
000500171229      *
000600180228      *  Description: Broker Plus - Broker Agency
000700180131      *  Programmer.: Jon Allen
000800180228      *  Date.......: 02/28/2018
000900171229      *
001000180201      *
001100180201      *
001200171229      *-------------------------------------------------------------------------
001300180131      *
001400180131      * File specifications
001500180131      *
001600180131      *-------------------------------------------------------------------------
001700180220
001800180228       Dcl-f brkplus02d WorkStn
001900190520         Handler('PROFOUNDUI(HANDLER)')
002000190520         SFILE(SFL1:rrn);
002100180227
002200190520       dcl-f sman keyed usage(*Input)
002300190520         extdesc('F.SMAN') extfile(*extdesc);
002400180227
002500190520       dcl-f sman2l keyed usage(*Input)
002600190520         extdesc('F.SMAN2L') extfile(*extdesc);
002700180227
002800190520       dcl-f accmst5 keyed usage(*Input)
002900190520         extdesc('F.ACCMST5') extfile(*extdesc);
003000180227
003100190520       dcl-f accmstp keyed usage(*Input)
003200190520         extdesc('GALIB/ACCMSTP') extfile(*extdesc);
003300180228
003400190520       dcl-f brkprdl3 keyed usage(*Input)
003500190520         extdesc('GALIB/BRKPRDL3') extfile(*extdesc);
003600180131
003700190520       dcl-f smanrlt1 keyed usage(*Input)
003800190520         extdesc('F.SMANRLT1') extfile(*extdesc);
003900180228
004000190520       dcl-f spragxr2 keyed usage(*Input)
004100190520         extdesc('F.SPRAGXR2') extfile(*extdesc);
004200180228
004300190520       dcl-f agency keyed usage(*Input)
004400190520         extdesc('F.AGENCY') extfile(*extdesc);
004500180228
004600190520       dcl-f supragcy keyed usage(*Input)
004700190520         extdesc('F.SUPRAGCY') extfile(*extdesc) prefix(s_) ;
004800180228
004900170420
005000171229      *-------------------------------------------------------------------------
005100171229      *
005200171229      * Global Variables
005300171229      *
005400171229      *-------------------------------------------------------------------------
005500171227
005600180228       dcl-s rrn Zoned(5) inz;
005700180228       dcl-s x Zoned(5) inz;
005800180228       dcl-s y Zoned(5) inz;
005900190522       dcl-s gac char(10) dim(9999) inz;
006000180227
006100180131       dcl-s @today zoned(8) inz ;
006200180228       dcl-s @isotoday date(*iso);
006300190520       dcl-s wPhone Char(7);
006400190520
006500180131
006600190520      *-------------------------------------------------------------------------
006700190520      *
006800190520      * *Entry Procedure
006900190520      *
007000190520      *-------------------------------------------------------------------------
007100190520       Dcl-pr Main ExtPgm;
007200190520         *N char(3);
007300190520       End-Pr;
007400190520
007500190520       dcl-pi Main;
007600190520         wmancd char(3);
007700190520       End-Pi;
007800190520
007900190520
008000190520
008100171227
008200180102      *-------------------------------------------------------------------------
008300171229      *
008400180102      * Mainline Program
008500171229      *
008600180102      *-------------------------------------------------------------------------
008700180220
008800190520       @today = %DEC(%Date);
008900190520       @isotoday = %date(@today : *iso);
009000180131
009100190520       Dou btnBack = *on;
009200180227
009300190520         Clear_All();
009400180227
009500190520         load_sman();
009600190522         load_agency();
009700190520         load_subfile();
009800180227
009900190520         // Display Screen
010000190520         Disp_All();
010100180227
010200180227       enddo;
010300180220
010400190520       *inlr = *on;
010500190520       return ;
010600180131
010700180131      *-------------------------------------------------------------------------
010800180131      *
010900180227      * Load SMAN
011000180131      *
011100180131      *-------------------------------------------------------------------------
011200190520       Dcl-Proc  load_sman;
011300180131
011400190520         chain (wmancd) sman;
011500190520         if %found(sman);
011600180227
011700190520           wsname = %trim(SLNAME) + ', ' + %trim(SFNAME) + ' ' +
011800190520             %trim(SMI);
011900190520           wsadr1 = %trim(SADDR);
012000190524           if %subst(%editc(SZIPCD:'X'):6:4) <> '0000';
012100190520             wsadr2 = %trim(SCITY) + ', ' + %trim(SSTATE) +
012200190520               %editw(SZIPCD:'         -    ');
012300190520           else;
012400190520             wsadr2 = %trim(SCITY) + ', ' + %trim(SSTATE) + ' ' +
012500190524               %subst(%EDITC(SZIPCD:'X'):1:5);
012600190520           endif;
012700190520           if  SPHONE <> 0;
012800190520             wPhone = %editc(SPHONE:'X');
012900190520
013000190520             wsPhone = %Editc( SAREA: 'X') + '-' +
013100190520               %Subst(wPhone:1:3) + '-' + %Subst(WPhone:4);
013200190520
013300190520
013400190520
013500190520           else ;
013600190520             wsphone = *blanks;
013700190520           endif;
013800180227
013900190520           chain (sgrp) sman2l;
014000190520           if %found(sman2l);
014100180227
014200190520             if sbrfax <> 0 ;
014300190520               wsfax   = %editw(SBRFAX:'0   -   -    ');
014400190520             else ;
014500190520               wsfax = *blanks;
014600190520             endif;
014700190520             wsemail = %trim(SBREML);
014800180227
014900190520           endif;
015000190520         endif;
015100180216
015200190520       End-Proc ;
015300180227      *-------------------------------------------------------------------------
015400180227      *
015500180227      * Load Agency
015600180227      *
015700180227      *-------------------------------------------------------------------------
015800190520       Dcl-Proc  load_agency;
015900180227
016000190520         clear acctot1;
016100190520         clear emptot1;
016200180227
016300190520         setll (wmancd) accmst5;
016400190520         reade (wmancd) accmst5;
016500190520         dow not %eof(accmst5);
016600180228
016700190520           if atrmdt = 0 or atrmdt >= @today;
016800180227
016900190520             acctot1 += 1;
017000190520             emptot1 += noempl;
017100190520             premtot1 += apremi;
017200190520           //   RRN += 1;
017300190520           //   Write SFL1;
017400180228
017500190520           endif;
017600180227
017700190520           reade (wmancd) accmst5;
017800190520         enddo;
017900180227
018000190520         // GA
018100180228
018200190520         clear acctot2;
018300190520         clear emptot2;
018400180228
018500190520         setll (wmancd) brkprdl3;
018600190520         reade (wmancd) brkprdl3;
018700190520         dow not %eof(brkprdl3);
018800180228
018900190520           if BPTRDT = *hival or BPTRDT > @ISOTODAY;
019000190520             if BPSPLIT = 0 or BPSPLIT > 0.5;
019100180228
019200190520               x = %lookup(BPACCT:GAC);
019300190520               if x = 0;
019400190520                 y = y+1;
019500190520                 GAC(y) = BPACCT;
019600180227
019700190520                 chain (BPACCT) accmstp;
019800190520                 if %found(accmstp);
019900180228
020000190520                   if ADTRDT = *hival or ADTRDT > @ISOTODAY;
020100180227
020200190520                     acctot2 += 1;
020300190520                     emptot2 += ADBENR;
020400190520                     premtot2 += ADPAMT;
020500180227
020600190520                   //  RRN += 1;
020700190520                   //  Write SFL1;
020800180228
020900190520                   endif;
021000190520                 endif;
021100190520               endif;
021200180228
021300190520             endif;
021400190520           endif;
021500190520           reade (wmancd) brkprdl3;
021600190520         enddo;
021700180227
021800190520       End-Proc ;
021900180228      *-------------------------------------------------------------------------
022000180228      *
022100180228      * Load subfile
022200180228      *
022300180228      *-------------------------------------------------------------------------
022400190520       Dcl-Proc  load_subfile;
022500180228
022600190520         setll (wmancd) smanrlt1;
022700190520         reade (wmancd) smanrlt1;
022800190520         dow not %eof(smanrlt1);
022900180228
023000190520           chain (srasid) spragxr2;
023100190520           if %found(spragxr2);
023200180228
023300190520             chain (sxagcy) agency;
023400190520             if %found(agency);
023500180228
023600190520               chain (sxsuper) supragcy;
023700190520               if %found(supragcy);
023800180228
023900190520                 clear dat01;
024000190520                 if sreffdte > 0;
024100190520                   dat01 = %Char(%Date(sreffdte:*iso):*Usa);
024200190520                 endif;
024300180228
024400190520                 clear dat02;
024500190520                 if srtrmdte > 0;
024600190520                   dat02 = %Char(%Date(srtrmdte:*iso):*Usa);
024700190520                 endif;
024800180228
024900190520                 RRN += 1;
025000190520                 Write SFL1;
025100180228
025200190520               endif;
025300190520             endif;
025400190520           endif;
025500180228
025600190520           reade (wmancd) smanrlt1;
025700190520         enddo;
025800180228
025900190520       End-Proc ;
026000180227      *-------------------------------------------------------------------------
026100180227      *
026200180227      * Clear the Subfiles...
026300180227      *
026400180227      *-------------------------------------------------------------------------
026500180227       dcl-proc Clear_All;
026600180227
026700190520         // Clear the Subfile.
026800190520         SFLCLR = *on;
026900190520         Write SFLCTL;
027000190520         SFLCLR = *off;
027100190520         rrn = 0;
027200180227
027300180227
027400180227       end-proc;
027500180227
027600180227      *-------------------------------------------------------------------------
027700180227      *
027800180227      * Display The Subfiles...
027900180227      *
028000180227      *-------------------------------------------------------------------------
028100180227       dcl-proc Disp_All;
028200180227
028300190520         // Display the Subfile.
028400190520         SFLDSP = *on  ;
028500190520         exfmt SFLCTL;
028600190520         SFLDSP = *off;
028700180227
028800180227       end-proc;
028900180227
