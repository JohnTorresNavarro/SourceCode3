000100140611     H DFTACTGRP(*NO) ACTGRP(*CALLER) BNDDIR('ALLSRVPGMN')
000200000000      *_________________________________________________________________________
000300000000      *
000400000000      *  Description:  DB014R - Member/Dependent Audit
000500000000      *
000600140225      *  (c)Copyright 2014 by GBS, Inc.
000700000000      *
000800000000      *    Created by:  JALLEN - February 25, 2014
000900000000      *_________________________________________________________________________
001000140227     FACCMST    if   e           k Disk    extfile('F.ACCMST') prefix(A_)
001100140227     FAC2MST    if   e           k Disk    extfile('F.AC2MST')
001200140225     FMEMBER    if   e           k Disk    extfile('F.MEMBER')
001300140225     FDEPNDC    if   e           k Disk    extfile('F.DEPNDC')
001400140227     FPLNMST    if   e           k Disk    extfile('F.PLNMST')
001500140227     FAACODE    if   e           k Disk
001600140225     FDB014P    o  a e           k Disk
001700140226
001800140226   X***X
001900140226      /DEFINE CHK_ACA_PLAN_PR
002000140226      /DEFINE CHK_ACA_PLAN_FIELDS
002100140611      /COPY QCPYSRC,ACASRVPGMP
002200140226      /UNDEFINE CHK_ACA_PLAN_PR
002300140226      /UNDEFINE CHK_ACA_PLAN_FIELDS
002400140226   X***X
002500140226
0026001402260125 D YES             S               N   INZ(*ON)
0027001402260125 D NO              S               N   INZ(*OFF)
0028001402260125 D AM_I_ACA        S               N   INZ(*OFF)
002900140226     D @1              S              1A   INZ
003000140226
003100140226
003200140225     D zero            S              8S 0   inz
003300140225     D today           S              8S 0
003400140225     D mcount          S              3S 0
003500140225
003600140225     D dcovc         e ds                  inz
003700140225
003800140225     D mcovc         e ds                  inz
003900140225
004000000000      * Program status data structure
004100000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
004200140225
004300140225
004400140225      /free
004500140225
004600140225       //?select active dependent coverages...
004700140225       exec sql declare d1 cursor for select * from "F.DCOVC"
004800140307         where  CCANDT = :zero or CCANDT >= :today ;
004900140225
005000140225       exec sql open d1 ;
005100140225
005200140225       //?read all...
005300140225         dou       sqlcod <> *zeros ;
005400140225
005500140225       exec sql fetch next from d1 into :DCOVC ;
005600140225
005700140225         If        sqlcod = 0 ;
005800140225
005900140225         exsr      chk_member ;
006000140225
006100140225         endif ;
006200140225
006300140225         enddo ;
006400140225
006500140225       exec sql close d1 ;
006600140225
006700140225          return ;
006800140225
006900140225      /end-free
007000140225
007100000000      *___________________________________________________________________
007200140225      * check for active member coverage
007300000000      *___________________________________________________________________
007400140225     C     chk_member    begsr
007500140225
007600140225      /free
007700140225
007800140307       //?skip same day terms...
007900140307          if  DENRDT = CCANDT ;
008000140307          leaveSR ;
008100140307          endif ;
008200140307
008300140307
008400140307          mcount = 0 ;
008500140225
008600140225       //?select active dependent coverages...
008700140225       exec sql declare m1 cursor for select * from "F.MCOVC"
008800140225         where  MCSSNO = :SSNO and MCPLAN = :DVPLAN and
008900140804                ENRLDT <> CANDT and
009000140225                (CANDT = :zero or CANDT >= :today) ;
009100140225
009200140225       exec sql open m1 ;
009300140225
009400140225       //?read all...
009500140225         dou       sqlcod <> *zeros ;
009600140225
009700140225       exec sql fetch next from m1 into :MCOVC ;
009800140225
009900140225         If        sqlcod = 0 ;
010000140225
010100140225         mcount = mcount + 1 ;
010200140225
010300140225         endif ;
010400140225
010500140225         enddo ;
010600140225
010700140225       exec sql close m1 ;
010800140225
010900140226       If  mcount = 0 ;
011000140225       exsr  wrt_audit ;
011100140225       endif ;
011200140225
011300140225      /end-free
011400140225
011500140225     C                   endsr
011600140225
011700140225      *___________________________________________________________________
011800140225      * write audit report
011900140225      *___________________________________________________________________
012000140225     C     wrt_audit     begsr
012100140225
012200140225      /free
012300140225
012400140225         clear db014r ;
012500140307
012600140307       //?Get TSA
012700140307         chain (SSNO) MEMBER ;
012800140307         if %found ;
012900140227
013000140227       //?exclude OLE/Payroll Luminx Accounts
013100140227         chain ('F':MBTRST:MBSUB#:MBACCT) AC2MST ;
013200140227         if %found ;
013300140227         if  %trim(A2LUMINX) = 'Y' ;
013400140227         LeaveSR ;
013500140227         endif ;
013600140227         endif ;
013700140307         endif ;
013800140225
013900140225         chain (MBTRST:MBSUB#:MBACCT) ACCMST ;
014000140225         if %found ;
014100140227         d14acn = %trim(A_ACNAM1) ;
014200140225         endif ;
014300140227
014400140227         chain (A_AACODE) AACODE ;
014500140227         if %found ;
014600140227         d14aaa = %trim(AFNAM) + ' ' + %trim(ALNAM) ;
014700140227         endif ;
014800140225
014900140225         chain (SSNO:DSEQ#) DEPNDC ;
015000140225         if %found ;
015100140225         d14nam = %trim(DLNAME) + ', ' + %trim(DFNAME) ;
015200140225         endif ;
015300140225
015400140225         chain (DVTRST:DVSUB#:DVPLAN) PLNMST ;
015500140225         if %found ;
015600140225         d14dsc = %trim(PDESCR) ;
015700140225         endif ;
015800140225
015900140226         d14pln = %trim(DVPLAN) ;
016000140225         D14SSN = %editw(SSNO:'   -  -    ') ;
016100140225         D14SEQ = %char(DSEQ#) ;
016200140225         D14TSA = %char(DVTRST) + '-' + %char(DVSUB#) + '-' + %char(MBACCT);
016300140226
016400140226         exsr  FMTDATE ;
016500140226         D14EFF = %trim(Output_Date) ;
016600140226         D14TRM = *blanks ;
016700140226
016800140226         exsr  $ACA_CHK ;
016900140226         If    AM_I_ACA = YES ;
017000140226         D14ACA = 'Y' ;
017100140226         Else  ;
017200140226         D14ACA = ' ' ;
017300140226         Endif ;
017400140227
017500140227         d14err = 'Dependent coverage active; Member coverage termed' ;
017600140225
017700140225         write db014r ;
017800140225
017900140225      /end-free
018000140225
018100140225     C                   endsr
018200140225      *___________________________________________________________________
018300140225      * Formate Date
018400140225      *___________________________________________________________________
018500140225     C     FMTDATE       BEGSR
018600140226     C                   Movel     DENRDT        Input_Date
018700140225     C                   Call      'FMTDATE'
018800140225     C                   Parm                    Input_Date       32
018900140225     C                   Parm      'YYYYMMDD'    Input_Format     32
019000140225     C                   Parm      'MM/DD/YYYY'  Output_Format    32
019100140225     C                   Parm                    Output_Date      32
019200140225     C                   Parm                    Output_Error     10
019300140225     C                   ENDSR
019400140226      *****************************************************************
019500140226     C     $ACA_CHK      BEGSR
019600140226    ***
019700140226     C                   EVAL      AM_I_ACA = NO
019800140226     C                   EVAL      @1 = #CHK_ACA_PLAN(DVTRST:DVSUB#:DVPLAN)
019900140226    ***
020000140226     C                   IF        @1 = 'Y'
020100140226     C                   EVAL      AM_I_ACA = YES
020200140226     C                   ENDIF
020300140226    ***
020400140226     C                   ENDSR
020500000000      *___________________________________________________________________
020600000000      * Program open
020700000000      *___________________________________________________________________
020800000000     C     *INZSR        BEGSR
020900140225     C     *date         Mult      10000.0001    Today
021000000000     C                   ENDSR
