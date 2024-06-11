000100111209     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*NEW)
000200111209     H option(*SRCSTMT: *NODEBUGIO)
000300000000      *_________________________________________________________________________
000400060104      *
000500111021      *  Description:  Print Benefit Summary Listing
000600000000      *
000700110208      *  (c)Copyright 2011 by GBS, Inc.
000800000000      *
000900111021      *    Created by:  JALLEN - Oct 21, 2011
001000000000      *_________________________________________________________________________
001100130123     FDEPENDQTMPo  a e           k Disk
001200111209
001300111209      * Prototype defintions
001400111209      /COPY *LIBL/QMODSRC,#PROTO
001500111209
001600050330     D Period          s              2    inz(*HIVAL)
001700031107     D Count           S              5S 0
001800110420     D TRS             S              3S 0
001900110420     D SUB             S              3S 0
002000111021     D ACT             S              4S 0
002100111209     D SSN             S              9S 0
002200111209     D PHN             S             10A
002300111209     D W80DATE         S              8S 0
002400111209     D p#              S              3S 0
002500130122     D d#              S              3S 0
002600130122     D n#              S              3S 0
002700130122
002800130122     D  out#dep        ds             9
002900130122     D  nbrdep                 1      3s 0 inz
003000130122     D  nbrdepactive           4      6s 0 inz
003100130122     D  nbrdeptermed           7      9s 0 inz
003200130122
003300130122     d  DepDemo      e ds          3600    extname(webdpnd)
003400130122     d  dlst                   1    450a   dim(25) inz
003500130122     d  dfst                 451    750a   dim(25) inz
003600130122     d  dmid                 751    775a   dim(25) inz
003700130122     d  dad1                 776   1525a   dim(25) inz
003800130122     d  dad2                1526   2275a   dim(25) inz
003900130122     d  dcty                2276   2650a   dim(25) inz
004000130122     d  dsta                2651   2700a   dim(25) inz
004100130122     d  dzp                 2701   2925s 0 dim(25) inz
004200130122     d  dare                2926   3000s 0 dim(25) inz
004300130122     d  dphn                3001   3175s 0 dim(25) inz
004400130122     d  dsx                 3176   3200a   dim(25) inz
004500130122     d  drel                3201   3275a   dim(25) inz
004600130122     d  dbth                3276   3525d   dim(25) inz datfmt(*usa)
004700130122     d  dsq#                3526   3575s 0 dim(25) inz
004800130122     d  actcov              3576   3600a   dim(25) inz
004900110411
005000110420     C     *Entry        Plist
005100110420     C                   Parm                    WITRS             3
005200110420     C                   Parm                    WISUB             3
005300111021     C                   Parm                    WIACT             4
005400111021     C                   Parm                    WISSN             9
005500110420
005600110420     C                   Move      WITRS         TRS
005700110420     C                   Move      WISUB         SUB
005800111021     C                   Move      WIACT         ACT
005900111021     C                   Move      WISSN         SSN
006000130122
006100130122     C                   Clear                   DepDemo
006200130123     C                   Eval      out#dep = #get#dep(TRS:SUB:ACT:SSN:0)
006300130123     C                   Eval      DepDemo = #sfldep(TRS:SUB:ACT:SSN)
006400130122     C                   If        nbrdep > 0
006500130122     C                   Eval      D# = 0
006600130122     C                   Eval      n# = 1
006700130122     C                   Dow       dlst(n#) <> *blanks
006800130122     C                   If        actcov(n#) <> 'N'
006900130123     C                   Eval      DSSNO  = SSN
007000130123     C                   Eval      DPSEQ# = dsq#(n#)
007100130123     C                   Eval      DLNAME = %trim(dlst(n#))
007200130123     C                   Eval      DFNAME = %trim(dfst(n#))
007300130123     C                   Eval      DMI    = %trim(dmid(n#))
007400130123     C                   Eval      DADDR1 = %trim(dad1(n#))
007500130123     C                   Eval      DADDR2 = %trim(dad1(n#))
007600130123     C                   Eval      DCITY  = %trim(dcty(n#))
007700130123     C                   Eval      DSTATE = %trim(dsta(n#))
007800130123     C                   Eval      DZIP = dzp(n#)
007900130123     C                   Eval      DAREA = dare(n#)
008000130123     C                   Eval      DPHONE = dphn(n#)
008100130123     C                   Eval      DSEX = %trim(dsx(n#))
008200130123     C                   Eval      DRELCD = %trim(drel(n#))
008300130123     C                   Eval      w80date = #get80i(dbth(n#))
008400130123     C                   Eval      DBIRTH = w80date
008500130123     C                   Write     DEPENR
008600130122     C                   End
008700130122     C                   Eval      n# = n# + 1
008800130122     C                   Enddo
008900130122     C                   End
009000110209
009100110420     C                   Eval      *INLR = *ON
009200110420     C                   Return
009300030422      *___________________________________________________________________
009400030422      * Program initialization
009500030422      *___________________________________________________________________
009600030422     C     *INZSR        BEGSR
009700030422    ?C                   Endsr
