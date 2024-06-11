000100001016     H DFTNAME(CR162) FIXNBR(*ZONED)
000200000103      ******************************************************************
000300000414      * CR162      GROUP BENEFIT SERVICES SOFTWARE           1989      *
000400000103      *                                                                *
000500000103      *            WRITTEN BY - MICHAEL C. DUNPHY                      *
000600000103      *            DATE - 10/23/89                                     *
000700000103      *                                                                *
000800000103      *  DESCRIPTION - THIS PROGRAM WILL PRODUCE A WORKFILE TO BE USED *
000900000103      *                FOR PRINTING MEDICAL FORMAT TRANSMITTALS        *
001000000103      *                                                                *
001100000103      *                                                                *
001200000103      *  Y2K CONVERT - 1998                                            *
0013000211070020 F* 11/07/02 DLK - add "D" for DBE                                 *
001400071009      * 09/28/07 dlk - change bilrte & netrte to 6 decimal. Also       *
001500071009      *                convert rate calc to use external pgm           *
001600120822      * 08/22/12 dlk - add new proration rule 03 - full month rule     *
001700131007      * 10/07/13 sbt - hist file expansion project                     *
001800000103      *                                                                *
001900000103      *                                                                *
002000000103      ******************************************************************
002100131007     FHIST      IP   F  216        DISK
002200000103     FCODES     IF   F   64     3AIDISK    KEYLOC(1)
002300000103     FMEMBER    IF   F  648     9AIDISK    KEYLOC(1)
002400000103     FPLNMST    IF   F  200    10AIDISK    KEYLOC(1)
002500000103     FTRSMST    IF   F  264     3AIDISK    KEYLOC(1)
002600000103     FCARMST    IF   E           K DISK
002700000103     FTRANSREC  O    F  232        DISK
002800000103     FREPORT    O    F  132        PRINTER OFLIND(*INOF)
002900000103
003000000103     D MSG             S             40    DIM(11) CTDATA PERRCD(1)
003100991116     D workdt          S               d   datfmt(*iso)
003200991116     D prorateb        S              7  2
003300991116     D dayrateb        S             12  7
003400991116     D daystoadj       S              2  0
003500991116     D daysinmo        S              2  0
003600991116     D holddd          S              2  0
0037001208220037 D prwhat          S              3
003800071009     D ter2            S              8  0
0039000710090037 D grgroup         S                   like(parmgroup)
004000000103      *   CATEGORY ARRAY
004100000103
004200000103     D                 DS
004300071009      *  DATA STRUCTURE
004400000103     D  MCKEY                  1     21
004500071009      * rate key
004600071009     D  tspabct               12     26
004700000103      *                          PLAN MASTER FILE KEY
004800000103     D  PLNKEY                12     21
004900000103     D  SSNO                   1      9  0
005000000103     D  DSEQ#                 10     11  0
005100000103     D  TRUST#                12     14  0
005200000103     D  SUB#                  15     17  0
005300000103     D  PLAN#                 18     21
005400000103     D  AGEBND#               22     23  0
005500000103     D  T                     24     24
005600000103     D  TCODE                 25     26
005700991116
005800991116     D                 DS
005900991116     D  FRSTDT                 1      8  0
006000991116     D  FRSTYM                 1      6  0
006100991116     D  FRSTDY                 7      8  0
006200991116
006300000217     D                 DS
006400071009     D  effymd                 1      8  0
006500000217     D  EFFYM                  1      6  0
006600000217     D  EFFDY                  7      8  0
006700000217
006800000106     D                 DS
006900000106     D  COV2                   1      8  0
007000000106     D  COV2Y                  1      4  0
007100000106     D  COV2M                  5      6  0
007200000106
007300000103     D                UDS
007400000103     D  LTRUST                 7      9
007500000103     D  LCAT                  53     86
007600941014     D                                     DIM(34)
007700000103     D  LBC                   90     90
007800000103
007900000103      * HISTORY RECORD
008000000103     IHIST      NS  01
008100000103     I                                  2   10 0SSNO
008200000103     I                                 17   17  CODE#1
008300000103     I                                 18   19  CODECK
008400000103     I                                 17   19  TRCODE
008500000103     I                                 26   55  CK#NOT
008600000103     I                                 56   85  NOTE2
008700000103     I                                 26   29  PLAN#
008800000103     I                                 40   41  AGEBND
008900000103     I                                 52   53  TYPCOD
009000000103      * USED FOR DATE CHANGE TRANSACTIONS
009100000103     I                                 78   85 0ED
009200000103     I                                 68   69  OAGEBN
009300000103     I                                 68   69  OLDCOD
009400000103     I                                 63   69 0OBAMT
009500000103     I                                 79   85 0NBAMT
009600000217     I                                 78   85 0NEWDAT
009700000217     I                                 82   83 0NEWMO
009800000103     I                                110  112 0TRUST#        L1
009900000103     I                                110  112  TRUSTC
010000000103     I                                113  115 0SUB#
010100000103     I                                116  119 0ACCNO
010200000103     I                                129  136 0TRDATE
010300000103     I                                153  160 0COVYMD
010400000217     I                                157  158 0COVMO
010500000103     I                                159  160 0COVDAY
010600131007     I                                  1  160  RECORD
010700000103
010800000103      *  CODES MASTER FILE
010900000103     ICODES     NS
011000000103     I                                 44   44  ACTION
011100000103     I                                 45   45  ACTN2
011200000103     I                                 64   64  CSTATS
011300000103
011400000103      *  MEMBER FILE
011500000103     IMEMBER    NS
011600000103     I                                 10   27  LNAME
011700000103     I                                 28   39  FNAME
011800000103     I                                 40   40  MI
011900000103
012000000103      * PLAN MASTER FILE
012100000103     IPLNMST    NS
012200000103     I                                 53   55  PCARR
012300000103     I                                155  155  PRTYPE
012400000103     I                             P  138  139 2REMITP
012500000103     I                                162  162  SGRREM
012600000103     I                                182  182  REMITF
012700000103
012800000103     ITRSMST    NS
012900000103      *  TRUST MASTER FILE
013000000103     I                                255  255  TSCODE
013100000103     I                                228  228  TRNBIL
013200071009
013300000103     C   L1TRUST#        CHAIN     TRSMST                             97
013400970325     C   97
013500000103     CAN L1              Z-ADD     9             X
013600970325     C   97
013700000103     CAN L1              MOVE      'N'           SELTRS
013800970325     C   97
013900000103     CAN L1              MOVE      TRUST#        ERRTXT
014000970325     C   97
014100000103     CAN L1              ADD       1             CNT
014200970325     C   97
014300000103     CAN L1              EXCEPT    PRTERR
014400970325     C   97
014500000103     CAN L1              GOTO      #END
014600000103
014700000103      * ON SS# CHANGE SET TRUST SELECT FLAG
014800000103
014900000103     C   L1              IF        LTRUST <> 'ALL'
015000000103     C   L1              IF        LTRUST <> TRUSTC
015100000103     C                   MOVE      'N'           SELTRS            1
015200960620     C                   GOTO      #END
015300960620     C                   END
015400941014     C                   MOVE      LTRUST        CTLFLD            3
015500000103
015600000103     C                   ELSE
015700000103
015800000103     C                   DO        34            D                 2 0
015900000103     C                   IF        LCAT(D) = TSCODE
016000000103     C                   MOVE      'Y'           SELTRS
016100941014     C                   MOVE      LCAT(D)       CTLFLD
016200941014     C                   MOVEL     '  '          CTLFLD
016300000103     C                   GOTO      #T0007
016400000103     C                   END
016500000103     C                   END
016600000103
016700000103     C                   MOVE      'N'           SELTRS
016800000103
016900000103     C                   END
017000000103
017100000103      * SKIP RECORD IF SELECT TRUST FLAG = N
017200000103
017300941014     C     #T0007        TAG
017400000103     C                   IF        SELTRS = 'N'
017500000103     C                   SETOFF                                       01
017600000103     C                   GOTO      #END
017700000103     C                   END
017800000103
017900000103      * ON SS# CHANGE GET NEW MEMBER
018000000103
018100000103     C     SSNO          CHAIN     MEMBER                             92
018200000103     C   92              Z-ADD     11            X
018300000103     C   92              MOVE      SSNO          ERRTXT
018400980819     C   92              IF        FIRSTE <> 'N'
018500000103     C   92              EXCEPT    HEADER
018600980819     C   92              MOVE      'N'           FIRSTE
018700980819     C                   END
018800980819     C   OF
018900000103     CAN 92              EXCEPT    HEADER
019000000103     C   92              EXCEPT    PRTERR
019100000103     C   92              GOTO      #END
019200000103      ****************************************************************
019300000103      *         PROCESS AND FLAG HISTORY RECORD                      *
019400000103      ****************************************************************
019500000103
019600000103      * CHAIN TO CODES FILE FOR ACTION CODES
019700000103
019800000103     C     TRCODE        CHAIN     CODES                              98
019900000103     C  N98              GOTO      #T0010
020000000103     C                   Z-ADD     3             X                 2 0
020100000103     C                   MOVE      TRCODE        ERRTXT           30
020200000103     C                   ADD       1             CNT               2 0
020300931025     C                   IF        FIRSTE <> 'N'
020400000103     C                   EXCEPT    HEADER
020500931025     C                   MOVE      'N'           FIRSTE            1
020600931025     C                   END
020700000103     C   OF              EXCEPT    HEADER
020800000103     C                   EXCEPT    PRTERR
020900000103     C                   GOTO      #END
021000000103     C     #T0010        TAG
021100000103
021200000103      * --- EXIT AND FLAG RECORD IF NOT NEEDED ACTION CODE AND U1 IS ON
021300000103
021400000103      * 3/26/97 MMX TRCODE WAS ACTION H-S BUT THIS CHANGE MEMBER CANCEL
021500000103      *         DATE RECORD DOES NOT HAVE PLAN # IN IT SO IT ALWAYS
021600000103      *         CAME OUT AS ERROR...SO THE ACTION CODE WAS CHANGED
021700000103      *         TO BLANKS SO IT DOES NOT SHOW UP, ONLY THE COVERAGE
021800000103      *         CANCEL DATE CHANGES WILL SHOW(AS THEY DO NOW)
021900000103
022000000103     C                   IF        ACTION <> 'A'
022100000103     C                   IF        ACTION <> 'C'
022200000103     C                   IF        ACTION <> 'D'
022300000103     C                   IF        ACTION <> 'E'
022400000103     C                   IF        ACTION <> 'G'
022500000103     C                   IF        ACTION <> 'R'
022600000103     C                   IF        ACTION <> 'H'
022700000103     C                   GOTO      #END
022800000103     C                   END
022900000103     C                   END
023000000103     C                   END
023100000103     C                   END
023200000103     C                   END
023300000103     C                   END
023400000103     C                   END
023500000103     C                   IF        ACTN2 <> 'S'
023600000103     C                   GOTO      #END
023700000103     C                   END
023800000103
023900000103      * CHAIN TO PLAN FILE FOR FORMAT TYPE
024000000103
024100000103     C                   MOVE      AGEBND        AGEBND#           2 0
024200000103     C     PLNKEY        CHAIN     PLNMST                             98
024300000103     C   98              Z-ADD     4             X
024400000103     C   98              MOVE      PLNKEY        ERRTXT
024500960614     C   98              IF        FIRSTE <> 'N'
024600000103     C   98              EXCEPT    HEADER
024700960614     C   98              MOVE      'N'           FIRSTE            1
024800960614     C                   END
024900960614     C   OF
025000000103     CAN 98              EXCEPT    HEADER
025100000103     C   98              EXCEPT    PRTERR
025200000103     C   98              GOTO      #END
025300000103
025400000103      * SELECT BLUE CROSS OR NOT OR ALL
025500000103
025600021107      *  CARBC: BLUE CROSS = 1-9, OTHER = O, DB = D, PHN = P
025700000103
025800961001     C                   MOVE      'N'           BLUE              1
025900021107     C                   MOVE      'N'           db                1
026000000103     C     PCARR         CHAIN     CARMST                             H6
026100021107     C                   IF        carbc >= '1' and carbc <= '5'
026200961001     C                   MOVE      'Y'           BLUE
026300960614     C                   END
026400021107     C                   IF        carbc = 'D'
026500021107     C                   MOVE      'Y'           db
026600021107     C                   END
026700000103      * ALL
026800961001     C                   IF        LBC = 'A'
026900961001     C                   GOTO      #OK
027000961001     C                   END
027100000103      * BC ONLY
027200961001     C                   IF        LBC = 'B'
027300961001     C                   IF        BLUE = 'N'
027400961001     C                   GOTO      #END
027500961001     C                   END
027600961001     C                   END
027700021107      * DB ONLY
027800021107     C                   IF        LBC = 'D' and DB = 'N'
027900021107     C                   GOTO      #END
028000021107     C                   END
028100021107      * NO BC or DB
028200961001     C                   IF        LBC = 'N'
028300021107     C                   IF        BLUE = 'Y' or DB = 'Y'
028400961001     C                   GOTO      #END
028500961001     C                   END
028600961001     C                   END
028700000103
028800000103     C     #OK           TAG
028900000103
029000071009      * fill grate key
029100000103
029200000103     C                   MOVE      TYPCOD        TCODE
029300071009     C                   MOVE      COVYMD        effymd
029400000103
029500000103      * --- EXIT AND FLAG RECORD IF NOT MEDICAL TYPE PLAN
029600000103
029700000103     C                   IF        REMITF <> 'M'
029800000103     C                   IF        REMITF <> 'A'
029900000103     C                   GOTO      #END
030000000103     C                   END
030100000103     C                   END
030200000103      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
030300000103      * PROCESS ADD OR DELETE COVERAGE
030400000103      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
030500071009     C                   IF        ACTION = 'A' or
030600071009     C                             ACTION = 'D' or
030700071009     C                             ACTION = 'R'
030800000103     C                   GOTO      #T0035
030900000103     C                   END
031000000103
031100000103     C                   GOTO      #T0040
031200000103
031300000103     C     #T0035        TAG
031400000103
031500000103      *  EXECUTE PREMIUM CALCULATION ROUTINE
031600000103
031700071009     C                   MOVE      COVYMD        effymd
031800071009     C                   EXSR      #GRATE
031900071009
032000071009     C                   IF        parmfound <> 'Y'
032100071009     C                   Z-ADD     5             X
032200071009     C                   MOVE      tspabct       ERRTXT
032300071009     C                   ADD       1             CNT
032400071009     C                   EXCEPT    PRTERR
032500071009     C                   GOTO      #END
032600071009     C                   END
032700071009
032800000103     C                   EXSR      #PREM
032900000103
033000000103      * WRITE OUT PLAN ADD OR DELETE RECORD
033100000103      * IF DELETE TRANS., CREDIT PREMIUM.
033200000103
033300000103     C                   IF        ACTION = 'D'
033400000103     C                   Z-SUB     PREM          PREM
033500000103     C                   END
033600000103
033700000103     C                   EXCEPT    RECHST
033800000103     C                   SETOFF                                       U4
033900000103     C     #T0040        TAG
034000000103      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
034100000103      * PROCESS COVERAGE TYPE CHANGE
034200000103      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
034300000103     C                   IF        ACTION = 'C'
034400000103
034500071009      *  get PREMIUM
034600071009     C                   MOVE      COVYMD        effymd
034700071009     C                   EXSR      #GRATE
034800071009
034900071009     C                   IF        parmfound <> 'Y'
035000071009     C                   Z-ADD     6             X
035100071009     C                   MOVE      tspabct       ERRTXT
035200071009     C                   ADD       1             CNT
035300071009     C                   EXCEPT    PRTERR
035400071009     C                   GOTO      #END
035500071009     C                   END
035600071009
035700000103     C                   EXSR      #PREM
035800010920     C                   Z-ADD     PREM          PREMH             7 2
035900000103
036000000103      * CALULATE PREMIUM DIFFERENCE FOR COVERAGE CHANGE   *
036100000103
036200000103     C                   MOVE      OLDCOD        TCODE
036300000103
036400000106     C                   EXSR      #GRATE
036500000106
036600071009     C                   IF        parmfound <> 'Y'
036700000103     C                   Z-ADD     7             X
036800000103     C                   MOVE      AGEBND        AGEBND#           2 0
036900071009     C                   MOVE      tspabct       ERRTXT
037000000103     C                   ADD       1             CNT
037100931025     C                   IF        FIRSTE <> 'N'
037200000103     C                   EXCEPT    HEADER
037300931025     C                   MOVE      'N'           FIRSTE            1
037400931025     C                   END
037500000103     C   OF              EXCEPT    HEADER
037600000103     C                   EXCEPT    PRTERR
037700000103     C                   GOTO      #END
037800000103     C                   END
037900000103
038000000103      *  EXECUTE PREMIUM CALCULATION ROUTINE
038100000103
038200000103     C                   EXSR      #PREM
038300000103     C     PREMH         SUB       PREM          PREM
038400000103
038500000103      * WRITE OUT PLAN CHANGE RECORD
038600000103
038700000103     C                   EXCEPT    RECHST
038800000103     C                   SETOFF                                       U4
038900000103
039000000103     C                   END
039100000103      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
039200000103      * PROCESS ENROLLMENT DATE CHANGE
039300000103      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
039400000103     C                   IF        ACTION = 'E'
039500000217     C                   IF        NEWMO = COVMO
039600000217      *
039700000217      *  EXECUTE PREMIUM CALCULATION ROUTINE
039800000217      *
039900071009     C                   MOVE      COVYMD        effymd
040000071009     C                   EXSR      #GRATE
040100071009
040200071009     C                   IF        parmfound <> 'Y'
040300071009     C                   Z-ADD     6             X
040400071009     C                   MOVE      tspabct       ERRTXT
040500071009     C                   ADD       1             CNT
040600071009     C                   EXCEPT    PRTERR
040700071009     C                   GOTO      #END
040800071009     C                   END
040900000217
041000000217     C                   EXSR      #PREM
041100000217     C                   Z-ADD     PREM          PREMH             7 2
041200000217      *
041300000217      * CALULATE PREMIUM DIFFERENCE FOR COVERAGE CHANGE   *
041400000217      *
041500071009     C                   MOVE      NEWDAT        effymd
041600071009     C                   EXSR      #GRATE
041700071009
041800071009     C                   IF        parmfound <> 'Y'
041900071009     C                   Z-ADD     7             X
042000071009     C                   MOVE      tspabct       ERRTXT
042100071009     C                   ADD       1             CNT
042200071009     C                   EXCEPT    PRTERR
042300071009     C                   GOTO      #END
042400071009     C                   END
042500071009
042600000217
042700000217     C                   EXSR      #PREM
042800010921     C     PREM          SUB       PREMH         PREM
042900071009
043000000217     C                   ELSE
043100071009
043200000217     C                   MOVE      *ZEROS        PREM
043300071009     C                   clear                   grgroup
043400000217     C                   END
043500000103
043600000103     C                   EXCEPT    RECHST
043700000103     C                   SETOFF                                       U4
043800000103
043900000103     C                   END
044000000103      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
044100000103      * PROCESS CANCEL DATE CHANGE
044200071009      * MMX does not have enough info to get the rate record so show it
044300071009      * without the group # and prem
044400071009      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
044500000103     C                   IF        ACTION = 'H'
044600000217     C                   IF        NEWMO = COVMO
044700000217      *  EXECUTE PREMIUM CALCULATION ROUTINE
044800071009     C                   MOVE      COVYMD        effymd
044900071009     C                   EXSR      #GRATE
045000071009
045100071009     C                   IF        parmfound <> 'Y'
045200071009     C                   Z-ADD     6             X
045300071009     C                   MOVE      tspabct       ERRTXT
045400071009     C                   ADD       1             CNT
045500071009     C                   EXCEPT    PRTERR
045600071009     C                   GOTO      #END
045700071009     C                   END
045800000217
045900000217     C                   EXSR      #PREM
046000000217     C                   Z-ADD     PREM          PREMH             7 2
046100000217      *
046200071009      * CALULATE PREMIUM DIFFERENCE FOR CHANGE
046300000217      *
046400071009     C                   MOVE      NEWDAT        effymd
046500071009     C                   EXSR      #GRATE
046600071009
046700071009     C                   IF        parmfound <> 'Y'
046800071009     C                   Z-ADD     7             X
046900071009     C                   MOVE      tspabct       ERRTXT
047000071009     C                   ADD       1             CNT
047100071009     C                   EXCEPT    PRTERR
047200071009     C                   GOTO      #END
047300071009     C                   END
047400000217
047500000217      *  EXECUTE PREMIUM CALCULATION ROUTINE
047600000217
047700000217     C                   EXSR      #PREM
047800000217     C     PREMH         SUB       PREM          PREM
047900071009
048000000217     C                   ELSE
048100000217     C                   MOVE      *ZEROS        PREM
048200071009     C                   clear                   grgroup
048300000217     C                   END
048400000103
048500000103     C                   EXCEPT    RECHST
048600000103     C                   SETOFF                                       U4
048700000103
048800000103     C                   END
048900000103      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
049000000103      * PROCESS MEMBER AGE BAND CHANGE
049100000103      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
049200000103     C                   IF        ACTION = 'G'
049300000103
049400000103      *  EXECUTE PREMIUM CALCULATION ROUTINE
049500000103
049600071009     C                   MOVE      COVYMD        effymd
049700071009     C                   EXSR      #GRATE
049800071009
049900071009     C                   IF        parmfound <> 'Y'
050000071009     C                   Z-ADD     6             X
050100071009     C                   MOVE      tspabct       ERRTXT
050200071009     C                   ADD       1             CNT
050300071009     C                   EXCEPT    PRTERR
050400071009     C                   GOTO      #END
050500071009     C                   END
050600071009
050700000103     C                   EXSR      #PREM
050800000103     C                   Z-ADD     PREM          PREMH             7 2
050900000103
051000000103      * CALULATE PREMIUM DIFFERENCE FOR COVERAGE CHANGE   *
051100000103
051200000103     C                   MOVE      OAGEBN        OAGEBN#           2 0
051300000103     C                   MOVE      AGEBND        AGEBND#           2 0
051400000103     C                   MOVE      OAGEBN#       AGEBND#
051500000103
051600000106     C                   EXSR      #GRATE
051700000103
051800071009     C                   IF        parmfound <> 'Y'
051900000103     C                   Z-ADD     10            X
052000000103     C                   MOVE      AGEBND        AGEBND#           2 0
052100071009     C                   MOVE      tspabct       ERRTXT
052200000103     C                   ADD       1             CNT
052300931025     C                   IF        FIRSTE <> 'N'
052400000103     C                   EXCEPT    HEADER
052500931025     C                   MOVE      'N'           FIRSTE            1
052600931025     C                   END
052700000103     C   OF              EXCEPT    HEADER
052800000103     C                   EXCEPT    PRTERR
052900000103     C                   GOTO      #END
053000000103     C                   END
053100000103
053200000103     C                   EXSR      #PREM
053300010921     C     PREM          SUB       PREMH         PREM
053400000103
053500000103      * WRITE OUT PLAN CHANGE RECORD
053600000103
053700000103     C                   EXCEPT    RECHST
053800000103     C                   SETOFF                                       U4
053900000103
054000000103     C                   END
054100000103
054200000103     C     #END          TAG
054300000103      ****************************************************************
054400000103
054500071009      *------------------- CALCULATE PREMIUM ------------------------*
054600071009
054700071009      ****************************************************************
054800071009      * adjust premium by remittance percent and prorate
054900071009      ****************************************************************
055000000103     C     #PREM         BEGSR
055100071009
055200071009     C                   clear                   prem              7 2
055300071009
055400071009     C                   IF        REMITP = 0
055500071009     C                   z-add     netprem       prem
055600071009     C                   ELSE
055700071009     C     REMITP        MULT      bilprem       prem
055800071009     C                   END
055900000103
056000000103      * check for prorate - if needed the field "prem"
056100000103      * will be returned prorated
056200000103
056300000217     c                   if        EFFDY > 01
056400991207     c     pcarr         chain     carmst                             51
056500991207     c                   if        *in51 = *off and cprrul <> '  '
056600000217     c                   eval      holddd = EFFDY
056700071009     c                   eval      FRSTDT = effymd
056800991207     C                   MOVE      01            FRSTDY
056900120822   8 C* set what date to prorate as ENROLLMENT DATE
057000120822     c                   eval      prwhat = 'ENR'
057100991207     c                   exsr      #prorate
057200991207     c                   end
057300991207     c                   end
057400000103
057500000103     C                   ENDSR
057600000103      ***************************************************************
057700000103      * prorate adjustment                                          *
057800000103      ***************************************************************
057900991123     C     #prorate      BEGSR
058000000103
058100991123      *  fields used in pro rate calculation
058200991123      *  -----------------------------------
058300991123      *  holddd    = effective day of term (2.0)
058400991123      *  cprrul    = pro rate rule from carmst (2)
058500991123      *  prem      = billed amount (7.2) (full month)
058600991123      *  dayrateb  = daily rate billed (12.7)
058700991123      *  daysinmo  = # of days in month of prorated amount (2.0)
058800991123      *  daystoadj = # of days to adjust prorated amount   (2.0)
058900991123      *  prorateb  = prorated amount billed (7.2 rounded)
059000991123      *  workdt    = date field for finding last day in month (*ISO)
059100120822   4  *  prwhat    = prorate what date (3) - BOT, ENR, CAN
059200000103
059300000103      * skip if no pro-ration necessary
059400000103
059500000103     C                   if        holddd = 01 or cprrul = '  '
059600991207     c                   goto      #endpr
059700991207     c                   endif
059800991207     c
059900000103
060000991123      * get total # of days in month of prorated amount
060100000103
060200991123     c                   move      frstdt        workdt
060300991123     c                   adddur    1:*m          workdt
060400991123     c                   subdur    1:*d          workdt
060500991123     c                   extrct    workdt:*d     daysinmo
060600991123
060700000103      * if a bad effymd causes the daysinmo to be zero, the divide will
060800000103      * not work so skip
060900000103
061000991123     c                   if        daysinmo = 0
061100991123     c                   goto      #endpr
061200991123     c                   end
061300000103
061400000103      * daily rule (01)- prorate to the day
061500000103
061600991123     c                   if        cprrul = '01'
061700991123     c                   eval      daystoadj = (daysinmo - holddd) + 1
061800991123     c                   eval      dayrateb  = prem / daysinmo
061900991123     c                   eval(h)   prorateb  = dayrateb * daystoadj
062000991123     c                   eval      prem      = prorateb
062100991123     c                   endif
062200000103
062300000103      * mid month rule (02)- cancelled up to the 15th = no premium billed
062400000103
062500000217     c                   if        cprrul = '02' and holddd > 15
062600991123     c                   eval      prem   = *zeros
062700991123     c                   endif
062800120822     C*
062900120822   5 C* Full month rule (03) - only charge for full FIRST month when day=01
063000120822   5 C*                        always charge for full LAST month unless
063100120822   4 C*                        day = 01 (no coverage)
063200120822   4 C*
063300120822     c                   if        cprrul = '03' and
063400120822     c                             ((prwhat = 'BOT') or
063500120822     c                             (prwhat = 'ENR' and holddd <> 01) or
063600120822     c                             (prwhat = 'CAN' and holddd = 01))
063700120822     c                   eval      prem   = *zeros
063800120822     c                   endif
063900120822     C*
064000000103
064100991123     C     #endpr        ENDSR
064200000106
064300000106      ***************************************************************
0644000710090325 C* GET group# and calc prem
064500000106      ***************************************************************
064600000106     C     #GRATE        BEGSR
064700071009
0648000710090385 C* clear fields first
0649000710090387 C                   clear                   bilprem
0650000710090387 C                   clear                   netprem
0651000710090387 C                   clear                   grgroup
065200071009
065300071009     c     grplist       plist
065400071009     c                   parm                    parmkey          15
065500140106     C                   PARM                    PARMSSN           9
065600140106     C                   PARM                    PARMSEQ           2
065700071009     c                   parm                    parmeffymd        8
065800071009     c                   parm                    parmbenamt        7
065900071009     c                   parm                    parmgroup        15
066000071009     c                   parm                    parmbilrte       11
066100071009     c                   parm                    parmnetrte       11
066200071009     c                   parm                    parmbilprem       7
066300071009     c                   parm                    parmnetprem       7
066400071009     c                   parm                    parmfound         1
066500140106    *
066600140106     C                   EVAL      PARMSSN = *BLANKS
066700140106     C                   EVAL      PARMSEQ = *BLANKS
066800071009
066900071009     c                   move      tspabct       parmkey
067000071009     c                   move      effymd        parmeffymd
067100071009     c                   move      *zeros        parmbenamt
067200071009     c                   clear                   parmgroup
067300071009     c                   clear                   parmbilrte
067400071009     c                   clear                   parmnetrte
067500071009     c                   clear                   parmbilprem
067600071009     c                   clear                   parmnetprem
067700071009     c                   clear                   parmfound
067800071009
067900071009     c                   call      'GETRATE'     grplist
068000071009
068100071009      * premium returned
0682000710090361 C                   if        parmfound = 'Y'
068300071009     c                   move      parmbilprem   bilprem           7 2
068400071009     c                   move      parmnetprem   netprem           7 2
068500071009     c                   move      parmgroup     grgroup
068600071009
068700071009     c                   else
068800071009      * no rate found - do second rate search for 1 month less
0689000710090361 C                   if        effymd = 0
069000071009     C                   leavesr
069100071009     c                   end
069200071009
069300071009     C                   move      effymd        workdt
069400071009     C                   subdur    1:*m          workdt
069500071009     C                   move      workdt        ter2
069600071009     c                   move      tspabct       parmkey
069700071009     c                   move      ter2          parmeffymd
069800071009     c                   move      *zeros        parmbenamt
069900071009     c                   clear                   parmgroup
070000071009     c                   clear                   parmbilrte
070100071009     c                   clear                   parmnetrte
070200071009     c                   clear                   parmbilprem
070300071009     c                   clear                   parmnetprem
070400071009     c                   clear                   parmfound
070500071009
070600071009     c                   call      'GETRATE'     grplist
070700071009
070800071009      * premium returned
0709000710090361 C                   if        parmfound = 'Y'
071000071009     c                   move      parmbilprem   bilprem
071100071009     c                   move      parmnetprem   netprem
071200071009     c                   move      parmgroup     grgroup
0713000710090363 C                   end
071400071009
0715000710090363 C                   end
0716000710090324 C*******************************************
071700000106
071800000106     C                   ENDSR
071900000106
072000000307      * THIS INITIALIZATION SUBROUTINE IS EXECUTED ONLY ONCE
072100000307     C     *INZSR        BEGSR
072200000307     C                   SETON                                        U4
072300071009     C                   MOVE      'T'           T                 1
072400071009     C                   TIME                    TIME              6 0
072500071009     C                   MOVE      *ZEROS        DSEQ#
072600000307     C                   ENDSR
072700000307
072800000103      *****************************************************************
072900000103      *                                                               *
073000000103      *   O U T  P U T   S E C T I O N                                *
073100000103      *                                                               *
073200000103      *****************************************************************
073300000103     OREPORT    E            HEADER         2 03
073400000103     O                       TIME                15 '  :  :  '
073500000103     O                                           40 '************************'
073600000103     O                                           66 'E R R O R  L I S T I N G'
073700000103     O                                           93 '************************'
073800000103     O                       UDATE         Y    110
073900000103     O          E            HEADER         1
074000000103     O                                           15 'CR162'
074100000103     O                                           65 'MEDICAL FORMAT TRANSMITT'
074200000103     O                                           68 'ALS'
074300000103     O          E            HEADER         1
074400000103     O                                           30 'THE FOLLOWING MEMBERS QU'
074500000103     O                                           54 'ALIFIED FOR THE TRANSMIT'
074600000103     O                                           78 'TAL BUT HAD INVALID DATA'
074700000103     O                                           88 'REASONS:'
074800000103     O          E            HEADER         1
074900000103     O                                           25 '------------------------'
075000000103     O                                           49 '------------------------'
075100000103     O                                           73 '------------------------'
075200000103     O                                           93 '------------------------'
075300000103     O                                          115 '------------------------'
075400000103     O          E            PRTERR      1  1
075500000103     O                       CNT           Z      4
075600000103     O                                            5 ')'
075700000103     O                       SSNO                17 '   -  -    '
075800000103     O                       TRDATE              29 '    /  /  '
075900000103     O                       TRCODE              33
076000000103     O                       TRUST#              39
076100000103     O                                           40 '-'
076200000103     O                       SUB#                43
076300000103     O                                           44 '-'
076400000103     O                       ACCNO               48
076500000103     O                       CK#NOT             100
076600000103     O                       NOTE2              132
076700000103
076800000103     O          E            PRTERR         1
076900000103     O                       MSG(X)              50
077000000103     O                       ERRTXT         B    80
077100071009     O                       effymd             100 '    /  /  '
077200000103     O                                           90 'EFF DT-'
077300000103
077400000103      *  OUTPUT TRANSMITTAL SORT RECORD / HISTORY RECORD
077500000103
077600000103     OTRANSREC  E            RECHST
077700000103     O                       RECORD             160
077800941014     O                       SGRREM             125
077900941014     O                       CTLFLD             128
078000071009     O                       grgroup            177
078100000103     O                       LNAME              202
078200000103     O                       FNAME              215
078300000103     O                       MI                 217
078400000103     O                       PREM           B   228
078500000103     O                       PCARR              231
078600000103     O                       ACTION             232
078700980819**  OUTPUT MESSAGES
078800910215INVALID PLAN KEY FOR TERMINATED EMPLOYEE
078900910215INVALID RATE KEY FOR TERMINATED EMPLOYEE
079000910215INVALID TRANSACTION CODE  ------------->
079100910215INVALID PLAN KEY FOR ADD OR DELETE----->
079200910215INVALID RATE KEY FOR ADD OR DELETE----->
079300910215INVALID RATE KEY FOR CHANGE FROM------->
079400910215INVALID RATE KEY FOR CHANGE TO--------->
079500910215INVALID MCOV KEY FOR ADD OR DELETE----->
079600910215INVALID TRUST KEY --------------------->
079700910215INVALID AGEBAND CHANGE TO-------------->
079800980819INVALID SSN IN HISTORY   -------------->
