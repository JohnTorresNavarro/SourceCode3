000100220107
000200210910       ctl-opt option(*noDebugIo) DftActGrp(*no) bnddir('GBSBIND');
000300200121
000400210413      *-----------------------------------------------------------------------
000500200106      *
000600210412      *  Description: Format the GBS 3.0 Data File
000700160708      *
000800200106      *  Programmer.: Brian Rees
000900210412      *  Date.......: 04/12/2021
001000200106      *
001100210910      *  Copied from GBS0060R1
001200210413      *-----------------------------------------------------------------------
001300200106      * Change Log
001400200106      *
001500200903      * 09/03/2020  B.Rees
001600200903      *  Added EASE Cross reference files.
001700201104      * 11/4/2020   B.Rees  Added EASE EOI Text
001800201105      * 11/5/2020   B.Rees  Added Additional Fields for EASE
001900201105      *    Med-A Date, Med-B Date, Med-C Date, Med-D Date, Cost Center.
002000201216      * 12/16/2020   B.Rees  Added Waive Records for EASE
002100220211      * 02/11/2022   B.Rees  Added MEMEXTP Data.
002200220214      * 02/14/2022   B.Rees  Check Member File for Waived Status
002300210413      *-----------------------------------------------------------------------
002400170112
002500200121       dcl-f ADPOutputp keyed usage(*output);
002600200121
002700210412       dcl-f GBS30Mbr  keyed usropn;
002800200121
002900200121       dcl-f PlnMst Keyed ExtDesc('F.PLNMST') ExtFile(*extdesc);
003000200121
003100200121       dcl-f Gbs0029P keyed; // Location Cross Reference
003200200121       Dcl-f Member keyed ExtDesc('F.MEMBER') ExtFile(*extdesc);
003300200121
003400200903       dcl-f EasePlanl1 keyed;
003500200903       dcl-f EaseQEl1 keyed;
003600200904       dcl-f EaseClasl1 keyed;
003700201104       dcl-f EaseEOI keyed;
003800201105       dcl-f EaseCostl1 keyed;
003900201216       dcl-f EaseWaive keyed;
004000200903
004100210910       dcl-f gbsDiffp keyed;
004200210910       dcl-f PlanxRefp keyed;
004300220104       dcl-f CcntrxRefp keyed;
004400220307       dcl-f Code20P keyed;
004500210910
004600210413      *-----------------------------------------------------------------------
004700170112
004800210412       dcl-s PlanArry Char(20) dim(26);
004900210412       dcl-s EnrlArry Char(3) dim(26);
005000210412       dcl-s EffDtArry Char(10) dim(26);
005100210413       dcl-s TermDtArry Char(10) dim(26);
005200210412       dcl-s TermRsnArry Char(15) dim(26);
005300210412       dcl-s VolAmtArry Char(11) dim(26);
005400210412       dcl-s FSAAnnArry Char(10) dim(26);
005500210412       dcl-s FSAPPArry Char(9) dim(26);
005600210412
005700210412
005800210412       dcl-s PCP#Arry Char(20) dim(26);
005900210412       dcl-s PCPNameArry Char(50) dim(26);
006000210412       dcl-s PCPEfdtArry Char(8) dim(26);
006100210412       dcl-s PCPTmdtArry Char(8) dim(26);
006200220107
006300210412
006400210910       dcl-s PlnCnt Zoned(3);
006500210910       dcl-s i Zoned(2) inz;
006600210910       dcl-s count Zoned(5);
006700210910       dcl-s VolAmt$ Zoned(11);
006800210910       dcl-s FSAAmt$ Zoned(7:2);
006900210910
007000210910
007100230419       dcl-s wSalary Zoned(11:2);
007200230419       dcl-s wSalary2 Zoned(9:0);
007300210910
007400210910
007500210413      *-----------------------------------------------------------------------
007600200121      *
007700200121      * *Entry Procedure
007800200121      *
007900210413      *-----------------------------------------------------------------------
008000210910       Dcl-pr Main ExtPgm;
008100210910         *N  char(1);
008200210910       End-Pr;
008300210910
008400210910       dcl-pi Main;
008500210910         hasOrphan Char(1);
008600210910       End-Pi;
008700210910
008800210910       dcl-s S_Type Char(1);
008900230418       dcl-s E_COMPEN char(20);
009000230418       dcl-s J_COMPEN char(20);
009100200121
009200210910
009300210413      *-----------------------------------------------------------------------
009400200121      *
009500160926      * Mainline Program
009600200121      *
009700210413      *-----------------------------------------------------------------------
009800230418
009900230418        // J_compen = %ScanRpl('$':'':%trim(e_Compen));
010000230418        // j_compen = %ScanRpl(',':'':%trim(J_compen));
010100191205
010200210412       open GBS30Mbr ;
010300210910
010400210910         setll *loval GBS30Mbr;
010500210910         dou %Eof(GBS30Mbr);
010600210910           read GBS30Mbr;
010700210910
010800210910           if %eof(GBS30Mbr);
010900210910             leave;
011000210910           endif;
011100230419
011200230419           //  l1_sal = '25000000.00';
011300230419            wsalary2 = 51000;
011400210910
011500230418           wSalary = %Dec( %Trim( l1_Sal ) : 11 : 2 );
011600230419             if wSalary <> wSalary2;
011700230419             wsalary2 = wsalary2;
011800230419             EndIf;
011900210910
012000210910           enddo;
012100230418
012200230418           return;
012300210910
