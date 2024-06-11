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
001100111209     FBENSUM20F IF   E             DISK
001200111209     FACCMST    IF   E           K DISK
001300111021     FMEMBER    IF   E           K DISK
001400111209     FPRTBSM20P O    E             PRINTER oflind(*in91)
001500111209
001600111209      * Prototype defintions
001700111209      /COPY *LIBL/QMODSRC,#PROTO
001800111209
001900050330     D Period          s              2    inz(*HIVAL)
002000031107     D Count           S              5S 0
002100110420     D TRS             S              3S 0
002200110420     D SUB             S              3S 0
002300111021     D ACT             S              4S 0
002400111209     D SSN             S              9S 0
002500111209     D PHN             S             10A
002600111209     D W80DATE         S              8S 0
002700111209     D p#              S              3S 0
002800130122     D d#              S              3S 0
002900130122     D n#              S              3S 0
003000130122
003100130122     D  out#dep        ds             9
003200130122     D  nbrdep                 1      3s 0 inz
003300130122     D  nbrdepactive           4      6s 0 inz
003400130122     D  nbrdeptermed           7      9s 0 inz
003500130122
003600130122     d  DepDemo      e ds          3600    extname(webdpnd)
003700130122     d  dlst                   1    450a   dim(25) inz
003800130122     d  dfst                 451    750a   dim(25) inz
003900130122     d  dmid                 751    775a   dim(25) inz
004000130122     d  dad1                 776   1525a   dim(25) inz
004100130122     d  dad2                1526   2275a   dim(25) inz
004200130122     d  dcty                2276   2650a   dim(25) inz
004300130122     d  dsta                2651   2700a   dim(25) inz
004400130122     d  dzp                 2701   2925s 0 dim(25) inz
004500130122     d  dare                2926   3000s 0 dim(25) inz
004600130122     d  dphn                3001   3175s 0 dim(25) inz
004700130122     d  dsx                 3176   3200a   dim(25) inz
004800130122     d  drel                3201   3275a   dim(25) inz
004900130122     d  dbth                3276   3525d   dim(25) inz datfmt(*usa)
005000130122     d  dsq#                3526   3575s 0 dim(25) inz
005100130122     d  actcov              3576   3600a   dim(25) inz
005200111209
005300111209     d  DepCovg      e ds          1475    extname(webdcov)
005400111209     d  dpln                   1    100a   dim(25) inz
005500111209     d  dcat                 101    175a   dim(25) inz
005600111209     d  ddsc                 176   1175a   dim(25) inz
005700111209     d  deff                1176   1425d   dim(25) inz datfmt(*usa)
005800111209     d  dcsq                1426   1475s 0 dim(25) inz
005900111209
006000110411
006100110420     C     *Entry        Plist
006200110420     C                   Parm                    WITRS             3
006300110420     C                   Parm                    WISUB             3
006400111021     C                   Parm                    WIACT             4
006500111021     C                   Parm                    WISSN             9
006600111021     C                   Parm                    WIHEAD           10
006700110420
006800110420     C                   Move      WITRS         TRS
006900110420     C                   Move      WISUB         SUB
007000111021     C                   Move      WIACT         ACT
007100111021     C                   Move      WISSN         SSN
007200110420
007300110420     C     TRSKEY        Klist
007400110420     C                   Kfld                    TRS
007500110420     C                   Kfld                    SUB
007600110420     C                   Kfld                    ACT
007700110420
007800111021     C     TRSKEY        Chain     ACCMST
007900111021     C                   Eval      WPACCN = %trim(ACNAM1)
008000111021
008100111021     C     SSN           Chain     MEMBER
008200111021     C                   If        %trim(MMI) = *blanks
008300111021     C                   Eval      WPNAME = %trim(MFNAME) + ' ' +
008400111021     C                                      %trim(MLNAME)
008500111021     C                   Else
008600111021     C                   Eval      WPNAME = %trim(MFNAME) + ' ' +
008700111021     C                                      %trim(MMI) + ' ' +
008800111021     C                                      %trim(MLNAME)
008900111021     C                   End
009000111021     C                   Eval      WPSSN = MBSSNO
009100111209     C                   Eval      WPADR1 = %trim(ADDR1)
009200111209     C                   Eval      WPADR2 = %trim(ADDR2)
009300111209     C                   Eval      WPADR3 = %trim(CITY) + ' ' +
009400111209     C                             %trim(STATE) + ' ' +
009500111209     C                             %editw(ZIP:'0     -    ')
009600111209     C                   If        %trim(WPADR2) = *blanks
009700111209     C                   Eval      WPADR2 = %trim(WPADR3)
009800111209     C                   Eval      WPADR3 = *blanks
009900111209     C                   End
010000111209     C                   Move      AREA          AAA               3
010100111209     C                   Move      PHONE         PPP               7
010200111209     C                   Eval      PHN = AAA + PPP
010300111209     C                   Move      PHN           WPPHONE
010400111209     C                   Eval      WPEMAIL = %trim(FILL66)
010500111209
010600111209     C                   Select
010700111209     C                   When      %trim(SEX) = 'F'
010800111209     C                   Eval      WPGEN = 'FEMALE'
010900111209     C                   When      %trim(SEX) = 'M'
011000111209     C                   Eval      WPGEN = 'MALE  '
011100111209     C                   Other
011200111209     C                   Eval      WPGEN = '      '
011300111209     C                   Endsl
011400111209     C     BIRTH         Mult      10000.0001    WPDOB
011500111209     C                   Select
011600111209     C                   When      TERMDT = 0
011700111209     C                   Eval      WPSTAT = 'ACTIVE'
011800111209     C                   Other
011900111209     C                   Eval      WPSTAT = 'TERMED'
012000111209     C                   Endsl
012100111209     C                   Eval      PHN = WITRS + WISUB + WIACT
012200111209     C                   Move      PHN           WPACN#
012300111021
012400111209     C     1             Setll     BENSUM20F
012500111209     C                   Read      BENSUM20F
012600111209     C                   Dow       not %eof(BENSUM20F)
012700030422    ?C                   Exsr      ChkOvf
012800111021     C                   Movel     BQFLAT        WPFLAT
012900111021    ?C                   Write     PRTSUM
013000111021    ?C                   Move      *on           *inu1
013100111209     C                   Read      BENSUM20F
013200110420     C                   Enddo
013300130122
013400130122     C                   Clear                   DepDemo
013500130122     C                   Eval      out#dep = #get#dep(MBTRST:MBSUB#:MBACCT:
013600130122     C                                       MBSSNO:0)
013700130122     C                   Eval      DepDemo = #sfldep(MBTRST:MBSUB#:MBACCT:
013800130122     C                                              MBSSNO)
013900130122     C                   If        nbrdep > 0
014000130122     C                   Eval      D# = 0
014100130122     C                   Eval      n# = 1
014200130122     C                   Dow       dlst(n#) <> *blanks
014300130122     C                   If        actcov(n#) <> 'N'
014400111209     C                   Exsr      LOAD_DEP
014500111209     C                   If        D# = 0
014600111209    ?C                   Write     PRTDEP1
014700111209     C                   Eval      D# = 1
014800111209E001?C                   End                                                    END DO
014900111209    ?C                   Write     PRTDEP2
015000130122     C                   End
015100130122     C                   Eval      n# = n# + 1
015200130122     C                   Enddo
015300130122     C                   End
015400110209
015500110420     C                   Eval      *INLR = *ON
015600110420     C                   Return
015700111209    ? *___________________________________________________________________
015800111209    ? * Load Dep SFL
015900111209    ? *___________________________________________________________________
016000111209    ?C     LOAD_DEP      Begsr                                                  PROCESS ROLLDOWN
016100111209     C                   Clear                   WSNAM
016200111209     C                   Clear                   WSREL
016300111209     C                   Clear                   WSDOB
016400111209     C                   Clear                   WSEFF
016500111209     C                   Clear                   WSCOV
016600130122     C                   If        %trim(DMID(n#)) <> *blanks
016700130122     C                   Eval      WSNAM = %trim(DFST(n#)) + ' ' +
016800130122     C                                     %trim(DMID(n#)) + ' ' +
016900130122     C                                     %trim(DLST(n#))
017000111209     C                   Else
017100130122     C                   Eval      WSNAM = %trim(DFST(n#)) + ' ' +
017200130122     C                                     %trim(DLST(n#))
017300111209     C                   End
017400111209     C                   Select
017500130122     C                   When      %trim(DREL(n#)) = 'RDA'
017600111209     C                   Eval      WSREL = 'DAUGHTER'
017700130122     C                   When      %trim(DREL(n#)) = 'RWI'
017800111209     C                   Eval      WSREL = 'WIFE    '
017900130122     C                   When      %trim(DREL(n#)) = 'RSO'
018000111209     C                   Eval      WSREL = 'SON     '
018100130122     C                   When      %trim(DREL(n#)) = 'RHU'
018200111209     C                   Eval      WSREL = 'HUSBAND '
018300111209     C                   Other
018400111209     C                   Eval      WSREL = 'OTHER   '
018500111209     C                   Endsl
018600130122     C**** DBTH(n#)      Mult      10000.0001    WSDOB
018700111209
018800111209     C                   Clear                   DepCovg
018900111209     C                   Clear                   w80date
019000111209     C                   Clear                   WWMED            10
019100111209     C                   Clear                   WWDEN            10
019200111209     C                   Clear                   WWVIS            10
019300130122     C                   Eval      DepCovg = #sfldcov(MBSSNO:DSQ#(n#):MBTRST:
019400111209     C                                       MBSUB#:MBACCT:'N':'N')
019500111209     C                   Eval      p# = 1
019600111209     C                   If        dpln(p#) <> *blanks
019700111209     C                   Dow       dpln(p#) <> *blanks
019800111209     C                   If        dpln(p#) <> 'XXXX'
019900111209
020000111209     C                   Select
020100111209     C                   When      dcat(p#) = 'PMM'
020200111209     C                   Eval      WWMED = 'MEDICAL'
020300111209     C                   Eval      w80date = #get80i(deff(p#))
020400111209     C                   When      dcat(p#) = 'PDR'
020500111209     C                   Eval      WWDEN = 'DENTAL '
020600111209     C                   When      dcat(p#) = 'PDN'
020700111209     C                   Eval      WWDEN = 'DENTAL '
020800111209     C                   When      dcat(p#) = 'PVR'
020900111209     C                   Eval      WWVIS = 'VISION '
021000111209     C                   When      dcat(p#) = 'PVS'
021100111209     C                   Eval      WWVIS = 'VISION '
021200111209     C                   Endsl
021300111209
021400111209     C                   If        w80date = 0
021500111209     C                   Eval      w80date = #get80i(deff(p#))
021600111209     C                   End
021700111209
021800111209     C                   End
021900111209     C                   Eval      p# = p# + 1
022000111209     C                   Enddo
022100111209     C                   End
022200111209
022300111209     C                   Select
022400111209     C                   When      %trim(WWMED) <> *blanks  and
022500111209     C                             %trim(WWDEN) <> *blanks  and
022600111209     C                             %trim(WWVIS) <> *blanks
022700111209     C                   Eval      WSCOV = %trim(WWMED) + '\' +
022800111209     C                                     %trim(WWDEN) + '\' +
022900111209     C                                     %trim(WWVIS)
023000111209     C                   When      %trim(WWMED) <> *blanks  and
023100111209     C                             %trim(WWDEN) <> *blanks  and
023200111209     C                             %trim(WWVIS) =  *blanks
023300111209     C                   Eval      WSCOV = %trim(WWMED) + '\' +
023400111209     C                                     %trim(WWDEN)
023500111209     C                   When      %trim(WWMED) <> *blanks  and
023600111209     C                             %trim(WWDEN) =  *blanks  and
023700111209     C                             %trim(WWVIS) <> *blanks
023800111209     C                   Eval      WSCOV = %trim(WWMED) + '\' +
023900111209     C                                     %trim(WWVIS)
024000111209     C                   When      %trim(WWMED) <> *blanks  and
024100111209     C                             %trim(WWDEN) =  *blanks  and
024200111209     C                             %trim(WWVIS) =  *blanks
024300111209     C                   Eval      WSCOV = %trim(WWMED)
024400111209     C                   When      %trim(WWMED) =  *blanks  and
024500111209     C                             %trim(WWDEN) <> *blanks  and
024600111209     C                             %trim(WWVIS) <> *blanks
024700111209     C                   Eval      WSCOV = %trim(WWDEN) + '\' +
024800111209     C                                     %trim(WWVIS)
024900111209     C                   When      %trim(WWMED) =  *blanks  and
025000111209     C                             %trim(WWDEN) <> *blanks  and
025100111209     C                             %trim(WWVIS) =  *blanks
025200111209     C                   Eval      WSCOV = %trim(WWDEN)
025300111209     C                   When      %trim(WWMED) =  *blanks  and
025400111209     C                             %trim(WWDEN) =  *blanks  and
025500111209     C                             %trim(WWVIS) <> *blanks
025600111209     C                   Eval      WSCOV = %trim(WWVIS)
025700111209     C                   Endsl
025800111209
025900111209      *???
026000111209     C     W80date       Mult      10000.0001    WSEFF
026100111209     C**********         eval      WSEFF = w80date
026200111209      *???
026300111209
026400111209     C                   Endsr                                                  END PRCRUP
026500030422    ? *___________________________________________________________________
026600030422    ? * Check Overflow
026700030422    ? *___________________________________________________________________
026800030422    ?C     ChkOvf        Begsr
026900030422B001?C     *in91         Ifeq      *On
027000030422 001?C                   Time                    WPTIM
027100111021 001?C                   Write     PRTHDR
027200111021 001?C                   Write     PRTBSM
027300030422 001?C                   Move      *Off          *In91
027400030422E001?C                   Endif
027500030422    ?C                   Endsr
027600030422      *___________________________________________________________________
027700030422      * Program initialization
027800030422      *___________________________________________________________________
027900030422     C     *INZSR        BEGSR
028000030422      *
028100030422    ?C                   Move      *on           *in91
028200111209     C                   Eval      WQPGMN =      'PRTBSM20'
028300030422    ?C                   Endsr
