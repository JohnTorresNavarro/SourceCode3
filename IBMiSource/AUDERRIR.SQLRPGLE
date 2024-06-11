000100000000      *_________________________________________________________________________
000200060104      *
000300140220      *  Description:  Print Audit Error Interactive Report
000400000000      *
000500140220      *  (c)Copyright 2014 by GBS, Inc.
000600000000      *
000700140220      *    Created by:  JALLEN - Feb 20, 2014
000800000000      *_________________________________________________________________________
000900140224     FMEMBER    IF   E           K DISK    EXTFILE('F.MEMBER')
001000140220     FPRTAUDERRPO    E             PRINTER oflind(*in91)
001100031107      *
001200140227     D wusa            S               d   datfmt(*usa)
001300031107     D Count           S              5S 0
001400140220     D JOB#            S              6S 0
001500140224     D wflg            S              1a   inz(' ')
001600140224     D ov              S              1a   inz(' ')
001700140220
001800140220     D acaratelog    e ds                  inz
001900110411
002000140220      * Program status data structure
002100140220     D PGMD          ESDS                  EXTNAME(IOPGMD)
002200140220
002300110420     C     *Entry        Plist
002400140220     C                   Parm                    WIJOBN           10
002500140220     C                   Parm                    WIJOB#            6
002600110420
002700140220     C                   Move      WIJOB#        JOB#
002800110420
002900140220      /free
003000140220
003100140220       //?select errors by job/nbr and not yet reported flg...
003200140220       exec sql declare l1 cursor for select * from ACARATELOG
003300140224        where rljobname = :wijobn and rljobnbr = :job#
003400140225         and rlmbraudfl = :wflg and rlerror <> :wflg
003500140225        for update of RLMBRAUDFL with nc ;
003600140220
003700140220       exec sql open l1 ;
003800140220
003900140220       //?read all of selected errors...
004000140220         dou       sqlcod <> *zeros ;
004100140220
004200140221       exec sql fetch next from l1 into :ACARATELOG ;
004300140220
004400140220         If        sqlcod = 0 ;
004500140220
004600140220         exsr      prt_detail ;
004700140220
004800140225          exec sql update ACARATELOG set RLMBRAUDFL = 'Y'
004900140225            where current of l1 ;
005000140221
005100140220         endif ;
005200140220
005300140220         enddo ;
005400140220
005500140220       exec sql close l1 ;
005600140220
005700140220      /end-free
005800140220
005900140220     C                   Eval      *INLR = *ON
006000140220     C                   Return
006100111021
006200140220    ? *___________________________________________________________________
006300140220    ? * Print Detail
006400140220    ? *___________________________________________________________________
006500140220    ?C     prt_detail    Begsr
006600140220
006700140220     C                   eval      wpssn = RLSSN
006800140220     C                   eval      wpseq = RLDEPSEQ
006900140220     C                   eval      wpplan = RLPLAN
007000140220     C                   eval      wperror = %trim(RLERROR)
007100140227     C                   move      rlreqdate     wusa
007200140227     C                   move      wusa          wpreqd
007300140220
007400140220     C                   eval      wpjob = %trim(RLJOBNAME) + '/' +
007500140220     C                                     %trim(RLUSER) + '/' +
007600140220     C                                     %editc(RLJOBNBR:'X')
007700140220
007800140220     C                   eval      wptsa = %editc(RLTRUST:'X') + '-' +
007900140220     C                                     %editc(RLSUB:'X') + '-' +
008000140220     C                                     %editc(RLACCT:'X')
008100140220
008200140220     C     RLSSN         Chain     MEMBER
008300111021     C                   If        %trim(MMI) = *blanks
008400111021     C                   Eval      WPNAME = %trim(MFNAME) + ' ' +
008500111021     C                                      %trim(MLNAME)
008600111021     C                   Else
008700111021     C                   Eval      WPNAME = %trim(MFNAME) + ' ' +
008800111021     C                                      %trim(MMI) + ' ' +
008900111021     C                                      %trim(MLNAME)
009000111021     C                   End
009100140220
009200140220     C                   Exsr      ChkOvf
009300140220     C                   write     PRTDTL
009400140220
009500140220    ?C                   Endsr
009600030422    ? *___________________________________________________________________
009700030422    ? * Check Overflow
009800030422    ? *___________________________________________________________________
009900030422    ?C     ChkOvf        Begsr
010000140224
010100140224     C                   If        ov = 'Y'
010200140224     C                   LeaveSR
010300140224     C                   End
010400140224
010500030422B001?C     *in91         Ifeq      *On
010600030422 001?C                   Time                    WPTIM
010700111021 001?C                   Write     PRTHDR
010800030422 001?C                   Move      *Off          *In91
010900140224     C                   eval      ov = 'Y'
011000030422E001?C                   Endif
011100030422    ?C                   Endsr
011200030422      *___________________________________________________________________
011300030422      * Program initialization
011400030422      *___________________________________________________________________
011500030422     C     *INZSR        BEGSR
011600030422      *
011700030422    ?C                   Move      *on           *in91
011800030422    ?C                   Endsr
