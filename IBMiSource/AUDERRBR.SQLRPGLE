000100140424     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000200140424     H option(*SRCSTMT: *NODEBUGIO)
000300000000      *_________________________________________________________________________
000400060104      *
000500140224      *  Description:  Print Audit Error Batch Report
000600000000      *
000700140220      *  (c)Copyright 2014 by GBS, Inc.
000800000000      *
000900140220      *    Created by:  JALLEN - Feb 20, 2014
001000000000      *_________________________________________________________________________
001100140425     FMEMBER    IF   E           K DISK    EXTFILE('F.MEMBER')
001200140425     FMCOVC     IF   E           K DISK    EXTFILE('F.MCOVC')
001300140425     FDCOVC     IF   E           K DISK    EXTFILE('F.DCOVC')
001400140425     FINVBILL   IF   E           K DISK
001500140224     FPRTAUDERRBO    E             PRINTER oflind(*in91)
001600140424
001700140424      /COPY *LIBL/QMODSRC,#GET80IPR
001800140424
001900031107      *
002000140227     D wusa            S               d   datfmt(*usa)
002100031107     D Count           S              5S 0
002200140220     D JOB#            S              6S 0
002300140220     D wflg            S              1a   inz(' ')
002400140224     D ov              S              1a   inz(' ')
002500140424     D w80date         s              8s 0 inz
002600140425     D report          S              1a   inz(' ')
002700140220
002800140220     D acaratelog    e ds                  inz
002900110411
003000140220      * Program status data structure
003100140220     D PGMD          ESDS                  EXTNAME(IOPGMD)
003200140220
003300110420     C     *Entry        Plist
003400140220     C                   Parm                    WIJOBN           10
003500140220     C                   Parm                    WIJOB#            6
003600110420
003700140220     C                   Move      WIJOB#        JOB#
003800110420
003900140220      /free
004000140220
004100140220       //?select errors by job/nbr and not yet reported flg...
004200140220       exec sql declare l1 cursor for select * from ACARATELOG
004300140225         where  rljobname = :wijobn and rljobnbr = :job#
004400140225          and rlmbraudfl = :wflg and rlerror <> :wflg
004500140225        for update of RLMBRAUDFL with nc ;
004600140220
004700140220       exec sql open l1 ;
004800140220
004900140220       //?read all of selected errors...
005000140220         dou       sqlcod <> *zeros ;
005100140220
005200140221       exec sql fetch next from l1 into :ACARATELOG ;
005300140220
005400140220         If        sqlcod = 0 ;
005500140220
005600140220         exsr      prt_detail ;
005700140224
005800140225          exec sql update ACARATELOG set RLMBRAUDFL = 'Y'
005900140225                   where current of l1;
006000140221
006100140220         endif ;
006200140220
006300140220         enddo ;
006400140220
006500140220       exec sql close l1 ;
006600140425
006700140425         if %open(INVBILL) ;
006800140425          close INVBILL ;
006900140425         endif ;
007000140425
007100140425      /end-free
007200140425
007300140425     C                   If        count > 0
007400140224     C                   write     PRTLR
007500140425     C                   End
007600140220     C                   Eval      *INLR = *ON
007700140220     C                   Return
007800111021
007900140220    ? *___________________________________________________________________
008000140220    ? * Print Detail
008100140220    ? *___________________________________________________________________
008200140220    ?C     prt_detail    Begsr
008300140220
008400140220     C                   eval      wpssn = RLSSN
008500140220     C                   eval      wpseq = RLDEPSEQ
008600140220     C                   eval      wpplan = RLPLAN
008700140220     C                   eval      wperror = %trim(RLERROR)
008800140227     C                   move      rlreqdate     wusa
008900140227     C                   move      wusa          wpreqd
009000140220
009100140220     C                   eval      wpjob = %trim(RLJOBNAME) + '/' +
009200140220     C                                     %trim(RLUSER) + '/' +
009300140220     C                                     %editc(RLJOBNBR:'X')
009400140220
009500140220     C                   eval      wptsa = %editc(RLTRUST:'X') + '-' +
009600140220     C                                     %editc(RLSUB:'X') + '-' +
009700140220     C                                     %editc(RLACCT:'X')
009800140220
009900140220     C     RLSSN         Chain     MEMBER
010000111021     C                   If        %trim(MMI) = *blanks
010100111021     C                   Eval      WPNAME = %trim(MFNAME) + ' ' +
010200111021     C                                      %trim(MLNAME)
010300111021     C                   Else
010400111021     C                   Eval      WPNAME = %trim(MFNAME) + ' ' +
010500111021     C                                      %trim(MMI) + ' ' +
010600111021     C                                      %trim(MLNAME)
010700111021     C                   End
010800140424
010900140424      * skip termed
011000140424     C                   eval      w80date = #get80i(rlreqdate)
011100140424     C                   If        termdt >  0   and
011200140424     C                             termdt <= w80date
011300140424     C                   LeaveSR
011400140424     C                   end
011500140425
011600140425      * skip same day terms
011700140425     C                   eval      report = 'Y'
011800140425     C                   if        rldepseq = 0
011900140425     C                   exsr      chk_mcov
012000140425     C                   else
012100140425     C                   exsr      chk_dcov
012200140425     C                   end
012300140220
012400140425     C                   If        report = 'Y'
012500140220     C                   Exsr      ChkOvf
012600140220     C                   write     PRTDTL
012700140425     C                   eval      count = count + 1
012800140425     C                   end
012900140220
013000140220    ?C                   Endsr
013100140425    ? *___________________________________________________________________
013200140425    ? * Check MCOV
013300140425    ? *___________________________________________________________________
013400140425    ?C     chk_mcov      Begsr
013500140425
013600140425      /free
013700140425
013800140425         if not %open(INVBILL) ;
013900140425          open INVBILL ;
014000140425         endif ;
014100140425
014200140425         //?Find INVBILL record for selected date
014300140425         chain (w80date:rlssn:rldepseq:rltrust:rlsub:rlacct:rlplan) INVBILL ;
014400140425         if not %found ;
014500140425
014600140425         Setgt (rlssn:0:rltrust:rlsub:rlplan) MCOVC ;
014700140425          readpe (rlssn:0:rltrust:rlsub:rlplan) MCOVC ;
014800140425           dow not %eof ;
014900140425
015000140425         //?Skip reporting same day terms without INVBILL
015100140425         if  enrldt = candt ;
015200140425         report = 'N' ;
015300140425         endif ;
015400140425
015500140425         leaveSR ;
015600140425
015700140425          readpe (rlssn:0:rltrust:rlsub:rlplan) MCOVC ;
015800140425           enddo ;
015900140425
016000140425         endif ;
016100140425
016200140425      /end-free
016300140425
016400140425    ?C                   Endsr
016500140425    ? *___________________________________________________________________
016600140425    ? * Check DCOV
016700140425    ? *___________________________________________________________________
016800140425    ?C     chk_dcov      Begsr
016900140425
017000140425      /free
017100140425
017200140425         if not %open(INVBILL) ;
017300140425          open INVBILL ;
017400140425         endif ;
017500140425
017600140425         //?Find INVBILL record for selected date
017700140425         chain (w80date:rlssn:rldepseq:rltrust:rlsub:rlacct:rlplan) INVBILL ;
017800140425         if not %found ;
017900140425
018000140425          Setgt (rlssn:rldepseq:rltrust:rlsub:rlplan) DCOVC ;
018100140425          readpe (rlssn:rldepseq:rltrust:rlsub:rlplan) DCOVC ;
018200140425           dow not %eof ;
018300140425
018400140425         //?Skip reporting same day terms without INVBILL
018500140425         if  denrdt = ccandt ;
018600140425         report = 'N' ;
018700140425         endif ;
018800140425
018900140425         leaveSR ;
019000140425
019100140425          readpe (rlssn:rldepseq:rltrust:rlsub:rlplan) DCOVC ;
019200140425           enddo ;
019300140425
019400140425         endif ;
019500140425
019600140425      /end-free
019700140425
019800140425    ?C                   Endsr
019900030422    ? *___________________________________________________________________
020000030422    ? * Check Overflow
020100030422    ? *___________________________________________________________________
020200030422    ?C     ChkOvf        Begsr
020300140224
020400140224     C                   If        ov = 'Y'
020500140224     C                   LeaveSR
020600140224     C                   End
020700140224
020800030422B001?C     *in91         Ifeq      *On
020900030422 001?C                   Time                    WPTIM
021000111021 001?C                   Write     PRTHDR
021100030422 001?C                   Move      *Off          *In91
021200140224     C                   eval      ov = 'Y'
021300030422E001?C                   Endif
021400030422    ?C                   Endsr
021500030422      *___________________________________________________________________
021600030422      * Program initialization
021700030422      *___________________________________________________________________
021800030422     C     *INZSR        BEGSR
021900030422      *
022000030422    ?C                   Move      *on           *in91
022100030422    ?C                   Endsr
