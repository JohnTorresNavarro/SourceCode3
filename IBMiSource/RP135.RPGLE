000100050920     H DFTNAME(RP135) FIXNBR(*ZONED)
000200000000      ****************************************************************
000300000000      *                                                              *
000400000414      *  RP135     GROUP BENEFIT SERVICES SOFTWARE           1988    *
000500000000      *                                                              *
000600000000      *            WRITTEN BY - MICHAEL C. DUNPHY                    *
000700000000      *            DATE - 01/20/89                                   *
000800000000      *                                                              *
000900000000      *  DESCRIPTION - THIS PROGRAM WILL PRINT A SELECTED HISTORY    *
001000000000      *                LIST BY TRANSACTION CODE                      *
001100000000      *                                                              *
001200040901      * 09/01/04 DLK - FIX RETROACTIVE OPTION                        *
001300050920      * 09/20/05 dlk- add mask ssn option and convert to RPGLE       *
001400131010      * 10/10/13 sbt - hist file expansion project                    *
001500131016      * 10/16/13 sbt - hist file expansion project; move user in lda *
001600140103      * 01/03/14 rlj - Add an ACA - Y/N column to the report         *
001700040901      *                                                              *
001800000000      ****************************************************************
001900131010JGE01FHIST      IP   F  216        DISK
002000050920     FCODES     IF   F   64     3AIDISK    KEYLOC(1)
002100050920JGE01FMEMBER    IF   F  648     9AIDISK    KEYLOC(1)
002200140103JGE01FPLNAUXP   IF   E           K DISK
002300050922     Frp135p    O    F  132        PRINTER OFLIND(*INOF)
0024000509200037 D ssnoout         S             12
0025000509200037 D ck#notout       S                   like(ck#not)
0026000509210037 D note2out        S                   like(note2)
0027000509210037 D lssnoout        S              9
0028001401030037 D acaflg          S              1
002900050920
003000000000     D                 DS
003100000000     D  SSNDS                  1      9
003200000000     D  SSN1                   1      3
003300000000     D  SSN2                   4      5
003400000000     D  SSN3                   6      9
003500000000     D* LDA
003600000000     D                UDS
003700000000JGE01D  LFDATE                 1      8  0
003800000000     D  LTRUST                13     15
003900000000     D  LSUB                  16     18
004000000000     D  LACCT                 19     22
004100050920     D  lssno                 24     32
004200000000     D  SORT                  33     33
004300000000     D  TRCOD                 34     34
004400000000     D  TRNSAC                35     35
004500000000     D  COD                   44     73
004600000000     D                                     DIM(10)
004700000000     D  SORL                  74     74
004800000000JGE01D  LTDATE                75     82  0
004900050920     D  LMASK                 83     83
005000131016     D  OPER                  85     94
005100000000     D  RETRO                108    108
005200040901     D  RTDTE                109    116  0
005300040901     D  RTDMD                109    112  0
005400040901     D  RTDY                 113    116  0
005500000000     D  USER                 100    107
005600000000     D  CONAME               201    240
005700000000     D  STIME                242    253  0
005800000000     D  HMS                  242    247  0
005900000000     IHIST      NS  01
006000000000     I*  TRANSACTION HISTORY FILE
006100000000     I                                  1    1  HTYPE
006200000000     I                                  1   10 0ACC#
006300000000     I                                  2   10 0SS#
006400000000     I                                 18   19  TRCOD2
006500000000     I                                 17   19  TRCODE        L4
006600000000     I                             P   20   24 2TRAMT
006700000000     I                                 25   25  CM$FLG
006800000000     I                                 26   55  CK#NOT
006900140103     I                                 26   29  CK#PLN
007000000000     I                                 27   29  SSN1
007100050920     I                                 30   30  dash1
007200000000     I                                 31   32  SSN2
007300050920     I                                 33   33  dash2
007400000000     I                                 34   37  SSN3
007500000000     I                                 56   85  NOTE2                   22
007600000000     I                                110  112 0TRUST#
007700000000     I                                113  115 0SUB#
007800000000     I                                116  119 0ACCNO
007900000000     I                                128  128  DLTCD
008000000000JGE01I                                129  136 0TRDATE
008100000000JGE01I                                145  152 0RECVDT                  23
008200000000JGE01I                                153  160 0COVTDT                  24
008300131010     I                                207  216  hoper
008400000000     I***
008500000000     ICODES     NS  01
008600000000     I*  CODES
008700000000     I                                 14   43  LDESCR
008800000000     I                                 64   64  DLTCD
008900000000     I***
009000000000     IMEMBER    NS
009100000000      *  MEMBER MASTER FILE
009200000000     I                                 10   18  LNAM9
009300000000     I                                 28   28  FI
009400140103      * Plan Aux key
009500140103     C     plxkey        KLIST
009600140103     C                   kfld                    trust#
009700140103     C                   kfld                    sub#
009800140103     C                   kfld                    ck#pln
009900140103      *
0100000509200261 C                   movel     ck#not        ck#notout
0101000509210261 C                   movel     note2         note2out
010200050920     c                   eval      ssnoout = (%editw(ss#:'0   -  -    '))
0103001401030111  * Check for ACA
010400140103     C                   eval      acaflg = ' '
0105001401030261 C                   if        ck#pln <> '    '
0106001401030261 C     plxkey        chain     plnauxp                            55
0107001401030261 C                   if        *in55 = '0' and pxacar = 'Y'
010800140103     C                   eval      acaflg = 'Y'
010900140103     C                   endif
011000140103     C                   endif
0111001401030111  *
011200050921
0113000509210111  *********************
0114000509210111 C* mask SSN
0115000509200261 C                   if        lmask = 'Y'
0116000509200261 C                   movel     ' XXX-XX'     ssnoout
011700050921
011800050921      * std SSN for adjustments
011900050920     c                   if        dash1 = '-' and dash2 = '-' and
012000050920     c                             (ssn3 >= '0000' and ssn3 <= '9999')
0121000509200261 C                   movel     ' XXX-XX'     ck#notout
0122000509200261 C                   end
012300050921
012400050921      * chg dep ss# transaction
012500050921     c                   if        trcode = 'M54'
0126000509210261 C                   movel     'XXXXX'       ck#notout
0127000509210261 C                   movel     'XXXXX'       note2out
0128000509210261 C                   end
012900050921
013000050921      * Diary notes can have SSN in any format, do not show note fields
013100050921     c                   if        trcode = 'UHM'
0132000509210261 C                   clear                   ck#notout
0133000509210261 C                   clear                   note2out
0134000509210261 C                   end
013500050921
0136000509200261 C                   end
0137000509210111  *********************
013800050921
013900050921
014000000000     C*  GET NEW CODE DESCRIPTION ON CODE CHANGE
014100000000     C***
014200050922     c                   if        *inl4
014300050922     C     TRCODE        CHAIN     CODES                              H1
014400050922     C                   MOVE      *BLANKS       T                 1
014500050922     C                   Z-ADD     0             Y                 3 0
014600050922     c                   end
014700000000     C***
014800050922      *
014900050922     c                   if        *inu3 and
015000050922     c                             ((covtdt = 0) or (covtdt >= rtdymd))
015100050922     C                   SETOFF                                       01
015200050922     C                   GOTO      #END
015300050922     C                   end
015400000000     C***
015500000000     C*  IF WANT TO CHOOSE TRANSACTION CODES
015600000000     C***
015700000000     C     TRCOD         IFEQ      'Y'
015800000000     C                   Z-ADD     1             X                 2 0
015900000000     C     X             DOUGT     10
016000000000     C     TRCODE        IFEQ      COD(X)
016100000000     C                   GOTO      #SKIP
016200000000     C                   ELSE
016300000000     C                   ADD       1             X
016400000000     C                   END
016500000000     C                   END
016600000000     C                   SETOFF                                       01
016700000000     C                   GOTO      #END
016800000000     C                   END
016900000000     C***
017000000000     C     #SKIP         TAG
017100000000     C***
017200000000     C                   ADD       1             Y
017300000000     C     T             IFNE      'Y'
017400000000     C                   MOVE      *BLANKS       TRFLAG            1
017500000000     C                   MOVE      'Y'           T
017600000000     C                   END
017700000000     C***
017800000000     C*  WHEN NEW ACCOUNT PRINT ACCOUNT NUMBER
017900000000     C***
018000000000     C     TRFLAG        IFNE      'Y'
018100000000     C                   EXCEPT    TRHEAD
018200000000     C                   MOVE      'Y'           TRFLAG
018300000000     C                   END
018400000000     C***
018500000000     C*  CHECK FOR ACCOUNT / MEMBER TRANSACTION
018600000000     C***
018700000000     C     HTYPE         COMP      ' '                                2121
018800000000     C***
018900000000     C* IF LAST NAME IS SELECTED FOR REPORT (U4), GET MEMBER REC
019000000000     C* FROM SS# IN NOTE FIELD. (FOR ACCT TRANSACTIONS ONLY)
019100000000     C***
019200000000     C   U4              SETOFF                                       30
019300000000     C   21
019400000000     CAN U4SSNDS         CHAIN     MEMBER                             30
019500000000     C***
019600000000     C* ACCUMULATE TRAMT
019700000000     C***
019800000000     C                   ADD       TRAMT         TAMT              9 2
019900000000     C                   ADD       TRAMT         LRAMT             9 2
020000000000     C                   ADD       1             CNTTR             5 0
020100000000     C                   ADD       1             CNTFIN            6 0
020200981123     C***
020300981123     C*  CREATE DATES TO PRINT
020400981123     C***
020500981123     C                   EXSR      DATE01
020600000000     C***
020700000000     C     #END          TAG
020800000000     C***
020900050920     c                   if        *inof
021000050920     C                   ADD       1             CNT
021100050920     C                   EXCEPT    HEAD
021200050920     c                   end
021300000000     C***
021400000000     CL4   Y             IFGE      1
021500000000     CL4                 EXCEPT    TOTTRC
021600000000     CL4                 Z-ADD     0             Y
021700000000     CL4                 END
021800000000     C***
021900000000     C*******************************************************
022000000000     C*             S U B R O U T I N E S                   *
022100000000     C*******************************************************
022200000000     C***
022300000000     C*******************************************************
022400000000     C*  SUBROUTINE TO REVERSE RECVDT AND COVTDT DATES
022500000000     C*  FROM YYYYMMDD TO MMDDYYYY FOR PRINT LINE
022600000000     C*******************************************************
022700000000     C***
022800000000JGE01C     DATE01        BEGSR
022900000000JGE01C                   Z-ADD     TRDATE        @DATIN
023000000000JGE01C                   EXSR      #DATYM
023100000000JGE01C                   Z-ADD     @DATOU        PTRDAT            8 0
023200000000JGE01C***
023300000000JGE01C                   Z-ADD     RECVDT        @DATIN
023400000000JGE01C                   EXSR      #DATYM
023500000000JGE01C                   Z-ADD     @DATOU        PRCVDT            8 0
023600000000JGE01C***
023700000000JGE01C                   Z-ADD     COVTDT        @DATIN
023800000000JGE01C                   EXSR      #DATYM
023900000000JGE01C                   Z-ADD     @DATOU        PCOVDT            8 0
024000000000JGE01C                   ENDSR
024100000000     C***
024200000000     C*****************************************************
024300000000     C*   CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
024400000000     C*****************************************************
024500000000     C***
024600000000     C* DATE IN  = @DATIN (8.0) YYYYMMDD
024700000000     C* DATE OUT = @DATOU (8.0) MMDDYYYY
024800000000     C***
024900000000     C     #DATYM        BEGSR
025000000000     C                   MOVE      @DATIN        @MD               4 0
025100000000     C                   MOVEL     @DATIN        @Y                4 0
025200000000     C                   MOVEL     @MD           @DATOU            8 0
025300000000     C                   MOVE      @Y            @DATOU
025400000000     C                   MOVE      *ZEROS        @DATIN            8 0
025500000000     C                   ENDSR
025600050920
025700050920     C***********************
025800050920     C* first cycle
025900050920     C***********************
026000050920     C     *inzsr        begsr
026100050921     c                   movel     lssno         lssnoout
026200050921     c                   if        lmask = 'Y' and lssnoout <> *blanks
026300050921     c                   movel     'XXXXX'       lssnoout
026400050921     c                   end
026500050921
026600050920     C                   EXCEPT    CRTRIA
026700050920     C                   Z-ADD     1             CNT               7 0
026800050920     C                   EXCEPT    HEAD
026900050920     C                   MOVEL     RTDY          RTDYMD            8 0
027000050920     C                   MOVE      RTDMD         RTDYMD
027100050920     C     SORL          IFEQ      'L'
027200050920     C                   SETON                                        U4
027300050920     C                   END
027400050920     C                   ENDSR
027500050920     C***
027600000000     C/EJECT
027700000000      ******************************************************
027800000000      *  OUTPUT SPECIFICATIONS                             *
027900000000      ******************************************************
028000000000     O***
028100050922     Orp135p    E            CRTRIA         2 03
028200000000     O                       CONAME             110
028300000000     O***
028400000000     O          E            CRTRIA         2
028500000000     O                                           98 'Transaction Listing'
028600000000     O***
028700000000     O          E            CRTRIA         1
028800000000     O                                           76 '1. Select From Date to'
028900000000     O                                          101 'include (MMDDYYYY)......'
029000000000     O                                          116 '.............. '
029100000000     O                       LFDATE             124
029200000000     O***
029300000000     O          E            CRTRIA         1
029400000000     O                                           74 '2. Select To Date to'
029500000000     O                                           99 'include (MMDDYYYY)......'
029600990520     O                                          116 '................ '
029700000000     O                       LTDATE             124
029800000000     O***
029900000000     O          E            CRTRIA         2
030000990520     O                                           83 '(Use 00000000 - 99999999'
030100000000     O                                          105 ' to include all dates)'
030200000000     O***
030300000000     O          E            CRTRIA         1
030400000000     O                                           78 '3. Select Trust # or ALL'
030500000000     O                                          100 '?.....................'
030600990520     O                                          116 '................ '
030700000000     O                       LTRUST             119
030800000000     O***
030900000000     O          E            CRTRIA         1
031000000000     O                                           77 'Select Subdivision #'
031100000000     O                                          100 'or ALL?...............'
031200000000     O                                          116 '............... '
031300000000     O                       LSUB               119
031400000000     O***
031500000000     O          E            CRTRIA         1
031600000000     O                                           77 'Select Account # or '
031700000000     O                                           99 'ALL?..................'
031800000000     O                                          116 '................ '
031900000000     O                       LACCT              120
032000000000     O***
032100000000     O          E            CRTRIA         1
032200000000     O                                           91 '---------- OR ----------'
032300000000     O***
032400000000     O          E            CRTRIA         1
032500000000     O                                           79 'Social Security number'
032600000000     O                                          105 '........................'
032700000000     O                                          116 '........... '
032800050921     O                       lssnoout           125
032900000000     O***
033000000000     O          E            CRTRIA         2
033100000000     O***
033200000000     O          E            CRTRIA         2
033300000000     O                                           78 '4. Sort in Arrival,Trans'
033400000000     O                                          102 'action Code,or Audit Ord'
033500000000     O                                          116 'er? (A,T,D).. '
033600000000     O                       SORT               117
033700000000     O***
033800000000     O          E            CRTRIA         2
033900000000     O                                           72 '5. Include All,Fin'
034000000000     O                                           95 'ancial,Member,Cobra Tra'
034100000000     O                                          116 'nsactions (A,F,M,C). '
034200000000     O                       TRNSAC             117
034300000000     O***
034400000000     O          E            CRTRIA         2
034500000000     O                                           79 '      Select a Transacti'
034600000000     O                                          102 'on Code (Y/N)...........'
034700000000     O                                          116 '........................'
034800000000     O                       TRCOD              117
034900000000     O***
035000000000     O          E            CRTRIA         2
035100000000     O                                           72 '6. Retroactive rep'
035200000000     O                                           95 'ort (Y/N)..............'
035300000000     O                                          116 '.................... '
035400000000     O                       RETRO              117
035500000000     O***
035600000000     O          E            CRTRIA         2
035700000000     O                                           79 '      If YES Enter a Com'
035800000000     O                                          102 'parison Date............'
035900000000     O                                          116 '........................'
036000000000JGE01O                       RTDTE              117 '0 /  /    '
036100000000     O***
036200000000     O          E            CRTRIA         1
036300000000     O                                           72 '7. User Id or All '
036400000000     O                                           96 '........................'
036500000000     O                                          116 '.................... '
036600131016     O                       OPER               126
036700000000     O***
036800000000     O          E            CRTRIA         1
036900000000     O                                           72 '8. Print (S)sn or '
037000000000     O                                           96 '(L)ast name on report...'
037100000000     O                                          116 '.................... '
037200000000     O                       SORL               117
037300050920     O          E            CRTRIA         1
037400050920     O                                           72 '9. Mask SSN (XXX-X'
037500050920     O                                           96 'X-1234) (Y/N)...........'
037600050920     O                                          116 '.................... '
037700050920     O                       LMASK              117
037800000000     O***
037900000000     O          E            CRTRIA         2
038000000000     O                                           71 'CODES: '
038100000000     O                       COD(1)              74
038200000000     O                       COD(2)              78
038300000000     O                       COD(3)              82
038400000000     O                       COD(4)              86
038500000000     O                       COD(5)              90
038600000000     O                       COD(6)              94
038700000000     O                       COD(7)              98
038800000000     O                       COD(8)             102
038900000000     O                       COD(9)             106
039000000000     O                       COD(10)            110
039100000000     O***
039200000000     O          E            HEAD           2 03
039300000000     O                       CONAME              87
039400000000     O***
039500000000     O          E            HEAD           1
039600000000     O                       UDATE         Y     14
039700000000     O                                           76 'TRANSACTION HISTORY'
039800000000     O                                          120 'PAGE :'
039900000000     O                       CNT           Z    126
040000000000     O***
040100000000     O          E            HEAD           1
040200000000     O                                           17 'PROG: RP135'
040300000000     O                  U3                      108 'RETROACTIVE REPORT'
040400000000     O                                          120 'TIME :'
040500000000     O                       HMS                130 '  :  :  '
040600000000     O***
040700000000     O          E            HEAD           1
040800000000     O                                           50 'FROM -'
040900000000JGE01O***                      LFDATEY   60
041000000000JGE01O                       LFDATE              62 '0 /  /    '
041100000000     O                                           72 'TO -'
041200000000JGE01O***                      LTDATEY   80
041300000000JGE01O                       LTDATE              84 '0 /  /    '
041400000000     O***
041500000000     O          E            HEAD           1
041600000000     O                                           30 'TRUST -'
041700000000     O                       LTRUST              34
041800000000     O                                           54 'SUBDIVISION -'
041900000000     O                       LSUB                58
042000000000     O                                           80 'ACCOUNT -'
042100000000     O                       LACCT               85
042200000000     O***
042300000000     O          E            HEAD           1
042400000000     O                                           24 '------------------------'
042500000000     O                                           48 '------------------------'
042600000000     O                                           72 '------------------------'
042700000000     O                                           96 '------------------------'
042800000000     O                                          120 '------------------------'
042900000000     O                                          132 '------------'
043000000000     O***
043100000000     O          E            HEAD           1
043200000000     O                                           10 'SS#/ACC#'
043300000000     O                                           24 'TR DATE'
043400000000     O                                           40 'AMOUNT'
043500000000     O                                           49 'TYPE PMT'
043600000000     O                                           65 'NOTE/INV.NOTE'
043700000000     O                                           87 'RECEIVED'
043800000000     O                                          108 'ACCOUNT #'
043900140103     O                                          121 'USER '
044000140103     O                                          131 'ACA'
044100000000     O***
044200000000     O          E            HEAD           1
044300000000     O                                           24 '------------------------'
044400000000     O                                           48 '------------------------'
044500000000     O                                           72 '------------------------'
044600000000     O                                           96 '------------------------'
044700000000     O                                          120 '------------------------'
044800000000     O                                          132 '------------'
044900000000     O***
045000000000     O          E            TRHEAD      2  1
045100000000     O                       TRCOD2               2
045200000000     O                       LDESCR              35
045300000000     O***
045400000000     O          E            TRHEAD         1
045500000000     O                                           24 '------------------------'
045600000000     O                                           35 '-----------'
045700000000     O***
045800000000     O          D    01                     1
045900050920     O              N21      SSNOout             13
046000000000     O               21      ACC#                13 '0   -   -    '
046100000000JGE01O                       PTRDAT              25 '0 /  /    '
046200000000     O                       TRAMT         C     40
046300000000     O                       CM$FLG              45
046400050920     O                       CK#NOTout           77
046500000000     O***
046600000000     O* PRINT THE NAME IN PLACE OF THE SSN IS THE NOTE FIELD
046700000000     O* U4=SELECTED FROM SCREEN, 21=ACCT TYPE HIST, N30=HIT ON MEMBER
046800000000     O***
046900000000     O               21 U4N30FI             B    49
047000000000     O               21 U4N30                    50 '.'
047100000000     O               21 U4N30LNAM9          B    59
047200000000JGE01O              N23      PRCVDT              87 '0 /  /    '
047300981123JGE01O              N24      PCOVDT              98 '0 /  /    '
047400000000     O                       TRUST#             103
047500000000     O                       SUB#               107
047600000000     O                       ACCNO              112
047700131010     O                       hoper              125
047800140103     O                       acaflg             130
047900000000     O***
048000000000     O          D    01N22                  1
048100050921     O                       NOTE2out            77
048200000000     O***
048300000000     O          E            TOTTRC      1  1
048400000000     O                                           19 '*** TRANSACTIONS'
048500000000     O                                           29 ' MADE:   '
048600000000     O                       CNTTR         ZB    40
048700000000     O                                           52 'AMOUNT:'
048800000000     O                       TAMT          CB    65
048900000000     O***
049000000000     O          T    LR                  2
049100000000     O                                           19 '*** FINAL NUMBER'
049200000000     O                                           29 ' TRANS.: '
049300000000     O                       CNTFIN        ZB    40
049400000000     O***
049500000000     O          T    LR                  1
049600000000     O                                           19 '*** FINAL AMOUNT'
049700000000     O                                           29 ' TOTAL:  '
049800000000     O                       LRAMT         CB    42
