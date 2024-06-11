000100001016     H DFTNAME(CR020B) FIXNBR(*ZONED)
000200991229      ********************************************************************
000300991229      * CR020B    GROUP BENEFIT SERVICES SOFTWARE                  1989  *
000400991229      *                                                                  *
000500991229      *            WRITTEN BY - MICHAEL C. DUNPHY                        *
000600991229      *            DATE - 10/23/89                                       *
000700991229      *                                                                  *
000800991229      *  DESCRIPTION - THIS PROGRAM WILL PRINT LIFE FORMAT TRANSMITTALS  *
000900991229      *                                                                  *
001000991208      *  MODIFICATION - 7/29/97 CLEAR CARRIER NAME & PRINT CARRIER       *
001100991208      *               - REMOVE CAR# AFTER 8/4/97 RUN IS CHECKED          *
001200991208      *               - CARNAM IN OUTPUT = 56 ENDING POSITION            *
001300991229      *                                                                  *
001400991229      *  Y2K CONVERT - 1998                                              *
001500991229      *                                                                  *
001600991229      * 11.05.99 KSJ - Converted to RPG ILE                              *
001700001227      * 12/27/00 DLK - add plan cat "PAC" to col 5 per finance request *
001800010620      * 06/20/01 DLK - add plan cat "PSP" to col 5 per finance request *
001900010823      * 08/23/01 DLK - add plan cat "POA" to col 5 per finance request *
002000010919      * 09/19/01 DLK - add plan cat "PVL" to col 4 per finance request *
002100021213      * 12/13/02 DLK - more plan cat changes per finance request       *
002200040211      * 02/11/04 DLK - add plan cat "PCC" to col 5 per finance request *
002300021213
002400020822      *                * Note - when adding new plan cat, make sure    *
002500020822      *                you add to CR140B, CR020B & CR040B              *
002600991229      *                                                                  *
002700000103      *                                                                  *
002800991229      ********************************************************************
002900991229     FTRANS     IP   F  232        DISK
003000060218     FCARMST    IF   F  278     3AIDISK    KEYLOC(1)
003100991229     FMEMBER    IF   F  648     9AIDISK    KEYLOC(1)
003200991229     FACCMST    IF   F  560    10AIDISK    KEYLOC(1)
003300991229     FTRSMST    IF   F  264     3AIDISK    KEYLOC(1)
003400991229     FPLNMST    IF   F  200    10AIDISK    KEYLOC(1)
003500991229     FREPORT    O    F  198        PRINTER OFLIND(*INOF)
003600991208
003700991229     D NF              S              1    DIM(40) CTDATA PERRCD(1)             NOT FOUND MESSAGE
003800991229     D N               S              1    DIM(35)                              NAME WORK ARRAY
003900991229     D L1B             S              9  0 DIM(5)
004000991229     D L1P             S              9  2 DIM(5)
004100991229     D L2B             S              9  0 DIM(5)
004200991229     D L2P             S              9  2 DIM(5)
004300991229     D L3B             S              9  0 DIM(5)
004400991229     D L3P             S              9  2 DIM(5)
004500991229     D L4B             S              9  0 DIM(5)
004600991229     D L4P             S              9  2 DIM(5)
004700991229     D L5B             S              9  0 DIM(5)
004800991229     D L5P             S              9  2 DIM(5)
004900991229     D L6B             S              9  0 DIM(5)
005000991229     D L6P             S              9  2 DIM(5)
005100991229     D LRB             S              9  0 DIM(5)
005200991229     D LRP             S              9  2 DIM(5)
005300991229
005400991229      *   DATA STRUCTURE PLAN MASTER FILE KEY
005500991229     D                 DS
005600991229     D  PLNKEY                 1     10
005700991229     D  TRUST#                 1      3  0
005800991229     D  SUB#                   4      6  0
005900991229     D  PLAN#                  7     10
006000991229     D                 DS
006100991229     D  COVMDY                 1      8  0
006200991229     D  COVMO                  1      2  0
006300991229     D  COVDD                  3      4  0
006400991229     D  COVYR                  5      8  0
006500991229     D                UDS
006600991229     D  LTRUST                 7      9                                         COMPNY
006700980806     D  COD                   53     86
006800991229     D  LFDATE                37     44  0                                      COMPNY
006900991229     D  LTDATE                45     52  0                                      COMPNY
007000991229     D  SELECT                90     90
007100991229     D  CONAME               201    240
007200991229
007300991229     ITRANS     NS  01
007400991229     I                                  2   10 0SSNO          L1
007500991229     I                                 18   19  CODECK
007600991229     I                                 17   19  TRCODE
007700991229     I                                 26   55  CK#NOT
007800991229     I                                 56   85  NOTE2
007900991229     I                                 26   29  PLAN#
008000991229     I                                 40   41 0AGEBND
008100991229     I                                 52   53  TYPCOD
008200991229     I                                 79   80  OLDCOD
008300991229     I                             P   94   97 0OBAMT
008400991229     I                             P   98  101 0NBENFT
008500991229     I                                110  112 0TRUST#        L5
008600991229     I                                113  115 0SUB#          L2
008700991229     I                                110  119 0ACC#          L2
008800991229     I                                163  177  GROUP#
008900991229     I                                129  136 0TRDATE
009000991229     I                                153  160 0COVTDT        L3
009100991229     I                                153  156 0COVYR
009200991229     I                                157  158 0COVMO
009300991229     I                                159  160 0COVDD
009400991229     I                                185  202  LNAME
009500991229     I                                203  215  FNAME
009600991229     I                                217  217  MI                      50
009700991229     I                                222  228 2PREM
009800991229     I                                229  231  CARKEY        L6
009900991229     I                                232  232  ACTION        L4
010000991229
010100991229     IMEMBER    NS
010200991229      *  MEMBER FILE
010300991229     I                                129  129  SEX
010400991229     I                                513  520 0BIRTH
010500991229
010600991229      * TRUST MASTER FILE
010700991229     ITRSMST    NS
010800991229     I                                  4   23  TNAME
010900991229
011000991229      * CARRIER MASTER FILE
011100991229     ICARMST    NS
011200991229     I                                  4   43  CNAME
011300991229
011400991229      * PLAN MASTER FILE
011500991229     IPLNMST    NS
011600991229     I                                163  165  PLNCAT
011700991229
011800991229     IACCMST    NS
011900991229     I                                  1   10 0ACCNO
012000991229     I                                 11   50  ACNAM1
012100991229     I                                 91  120  AADDR1
012200991229     I                                151  165  ACITY
012300991229     I                                166  167  ASTATE
012400991229     I                             P  168  172 0AZIP
012500991229
012600991229      *****************************************************************
012700991229      *   M A I N   L I N E   C A L C U L A T I O N S                 *
012800991229      *****************************************************************
012900920618     C                   IF        FLAG <> 'Y'
013000920618     C                   EXCEPT    CRTRIA
013100930519     C                   Z-ADD     0             CNT               7 0
013200920618     C                   MOVE      'Y'           FLAG              1
013300920618     C                   END
013400991229      *
013500991229      * GET CARRIER NAME FOR HEADINGS
013600991229      *
013700991229     C   L6CARKEY        CHAIN     CARMST                             98
013800991229     C   98              MOVEL     NF(1)         CNAME
013900991229      *7/29/97 ---
014000970728     C  N98              MOVE      *BLANKS       CAR#              3
014100970728     C  N98              MOVE      *BLANKS       CARNAM           40
014200970728     C  N98              MOVEL     CNAME         CARNAM
014300970728     C  N98              MOVEL     CARKEY        CAR#
014400991229      *----------
014500991229      * GET TRUST NAME FOR HEADINGS
014600991229      *
014700991229     C   L5TRUST#        CHAIN     TRSMST                             98
014800991229     C   98              MOVEL     NF(1)         TNAME
014900991229      *
015000991229      * CHECK ACTION CODE FOR A=ADDITIONS, D=DELETIONS, OR C=CHANGE IN COV.TYPE
015100991229      *
015200991229     C  NL4              GOTO      #T0010
015300991229     C                   SETOFF                                       212223
015400910215     C                   SETOFF                                       252627
015500910927     C                   SETOFF                                       2428
015600991229     C                   IF        ACTION = 'A'
015700991229     C                   SETON                                            21
015800991229     C                   END
015900991229     C                   IF        ACTION = 'C'
016000991229     C                   SETON                                            22
016100991229     C                   END
016200991229     C                   IF        ACTION = 'D'
016300991229     C                   SETON                                            23
016400991229     C                   END
016500991229     C                   IF        ACTION = 'R'
016600991229     C                   SETON                                            24
016700991229     C                   END
016800991229     C                   IF        ACTION = 'B'
016900991229     C                   SETON                                            25
017000991229     C                   END
017100991229     C                   IF        ACTION = 'E'
017200991229     C                   SETON                                            26
017300991229     C                   END
017400991229     C                   IF        ACTION = 'G'
017500991229     C                   SETON                                            27
017600991229     C                   END
017700991229     C                   IF        ACTION = 'H'
017800991229     C                   SETON                                            28
017900991229     C                   END
018000991229     C     #T0010        TAG
018100991229      *
018200991229      * IF CHANGE IN ENROLLMENT DATE OR CANCEL DATE, DISPLAY NOTE2
018300991229      * FIELD IN HISTORY WHICH HAS FROM AND TO DATE
018400991229      *
018500991229     C   26
018600991229     COR 28              MOVE      NOTE2         NOTEH            30
018700991229      *
018800991229      * START NEW PAGE FOR BREAK OR OVERFLOW
018900991229      *
019000991229     C   L3
019100991229     COR OF              ADD       1             CNT
019200991229     C   L3
019300991229     COR OF              EXCEPT    HEAD
019400991229      *
019500991229      * USE BEN AMOUNT CHANGE FOR CHANGE
019600991229      *
019700991229     C                   IF        TRCODE = 'MCB'
019800910215     C                   Z-ADD     NBENFT        BENFTN            8 0
019900910215     C                   Z-ADD     OBAMT         BENFTO            8 0
020000991229     C     BENFTN        SUB       BENFTO        NBAMT             8 0
020100991229     C                   GOTO      #T0015
020200991229     C                   END
020300991229     C                   IF        TRCODE = 'MCC'
020400991229     C                   Z-ADD     0             NBAMT
020500991229     C                   GOTO      #T0015
020600991229     C                   END
020700991229     C                   IF        TRCODE = 'MCA'
020800991229     C                   Z-ADD     0             NBAMT
020900991229     C                   GOTO      #T0015
021000991229     C                   END
021100910215     C                   Z-ADD     OBAMT         NBAMT
021200910215     C     #T0015        TAG
021300991229      *
021400991229      * GET ACCOUNT NAME FOR HEADINGS
021500991229      *
021600991229     C   L2ACC#          CHAIN     ACCMST                             98
021700910215     C   L2
021800991229     CAN 98              MOVEL     NF(1)         ACNAM1
021900991229     C   L2              EXCEPT    L2OUT
022000991229      *
022100991229      * GET MEMBER FOR SEX AND BIRTH
022200991229      *
022300991229     C     SSNO          CHAIN     MEMBER                             H7
022400991229
022500980806     C                   MOVE      BIRTH         @DATIN
022600980806     C                   EXSR      #DATYM
022700980806     C                   MOVE      @DATOU        BIRTH
022800991229      *
022900991229      * GET PLAN CATEGORY TO CONTROL PRINT COLUMN
023000991229      *
023100991229     C     PLNKEY        CHAIN     PLNMST                             H8
023200991229
023300910930     C   L1              SETOFF                                         4041    42
023400910930     C   L1              SETOFF                                         4344    45
023500991229
023600991229      *------------  ACCUMULATE TOTALS -------------------------
023700991229      *
023800991229      * ADD LIFE AND AD&D TO ARRAY.
023900021213      * column 1
024000991229      *
024100021213     C                   IF        PLNCAT = 'PLF' or plncat = 'PNL' or
024200021213     C                             plncat = 'PAC' or plncat = 'PTL' or
024300021213     C                             plncat = 'PTA'
024400910930     C   41              SETON                                          40
024500910930     C                   SETON                                          41
024600910927     C  N26
024700991229     CANN28              ADD       NBAMT         L1B(1)
024800991229     C                   ADD       PREM          L1P(1)
024900991229     C                   END
025000991229      *
025100991229      * ADD DEPENDENT LIFE TO ARRAY.
025200021213      * column 2
025300991229      *
025400021213     C                   IF        PLNCAT = 'PDL' or plncat = 'PDE' or
025500021213     C                             plncat = 'PSD' or plncat = 'PVD' or
025600021213     C                             plncat = 'PTD'
025700910930     C   42              SETON                                          40
025800910930     C                   SETON                                          42
025900991229     C                   ADD       NBAMT         L1B(2)
026000991229     C                   ADD       PREM          L1P(2)
026100991229     C                   END
026200991229      *
026300991229      * ADD WEEKLY DISABILITY TO ARRAY.
026400021213      * column 3
026500991229      *
026600021213     C                   IF        PLNCAT = 'PWD' or plncat = 'PWS' or
026700021213     C                             plncat = 'PVW' or plncat = 'PTS'
026800910930     C   43              SETON                                          40
026900910930     C                   SETON                                          43
027000991229     C                   ADD       NBAMT         L1B(3)
027100991229     C                   ADD       PREM          L1P(3)
027200991229     C                   END
027300991229      *
027400991229      * ADD LONG TERM DISABILITY TO ARRAY.
027500021213      * column 4
027600991229      *
027700021213     C                   IF        PLNCAT = 'PLT' or plncat = 'PVL' or
027800021213     C                             plncat = 'PST' or plncat = 'PTT'
027900910930     C   44              SETON                                          40
028000910930     C                   SETON                                          44
028100991229     C                   ADD       NBAMT         L1B(4)
028200991229     C                   ADD       PREM          L1P(4)
028300991229     C                   END
028400991229      *
028500991229      * ADD SUPPLEMENTAL LIFE TO ARRAY.
028600021213      * column 5
028700991229      *
028800021213     C                   IF        PLNCAT = 'PSL' or plncat = 'PSW' or
028900021212     c                             plncat = 'PSP' or plncat = 'POA' or
029000021213     C                             plncat = 'PSA' or plncat = 'PSS' or
029100021213     c                             plncat = 'PLS' or plncat = 'PVA' or
029200040211     c                             plncat = 'PAA' or plncat = 'PLL' or
029300040211     c                             plncat = 'PCC'
029400910930     C   45              SETON                                          40
029500910930     C                   SETON                                          45
029600991229     C                   ADD       NBAMT         L1B(5)
029700991229     C                   ADD       PREM          L1P(5)
029800991229     C                   END
029900930519     C     #END          TAG
030000991229
030100991229      * PRINT TRDATE ON REPORT, BUT BE AWARE IT IS PRINTED AT
030200991229      * L1 DETAIL TIME(SSN) SO IF THERE ARE MORE THAN ONE TRANS.
030300991229      * ON A LINE, THE TRDATE COULD BE DIFFERENT
030400991229
030500980806     C                   MOVE      TRDATE        @DATIN
030600980806     C                   EXSR      #DATYM
030700980806     C                   MOVE      @DATOU        TRDMDY            8 0
030800991229
030900991229      ****************************************************************
031000991229      *  T O T A L    T I M E                                        *
031100991229      ****************************************************************
031200930519     CL1 U6              GOTO      #END2
031300991229     CL1                 EXSR      #NAMEL
031400991229     CL1                 ADD       1             L3MEM             6 0
031500991229     CL1                 ADD       L1B           L2B
031600991229     CL1                 ADD       L1P           L2P
031700991229     CL1                 XFOOT     L1P           L1PREM            9 2
031800991229
031900991229     CL2                 ADD       L2B           L3B
032000991229     CL2                 ADD       L2P           L3P
032100991229     CL2                 XFOOT     L2P           L2PREM            9 2
032200991229
032300991229     CL3                 ADD       L3MEM         L4MEM             6 0
032400991229     CL3                 ADD       L3B           L4B
032500991229     CL3                 ADD       L3P           L4P
032600991229     CL3                 XFOOT     L3P           L3PREM            9 2
032700991229
032800991229     CL4                 ADD       L4B           L5B
032900991229     CL4                 ADD       L4P           L5P
033000991229     CL4                 XFOOT     L4P           L4PREM            9 2
033100991229
033200991229     CL5                 ADD       L5B           L6B
033300991229     CL5                 ADD       L5P           L6P
033400991229     CL5                 XFOOT     L5P           L5PREM            9 2
033500991229     CL5                 Z-ADD     0             PAGE
033600991229
033700991229     CL6                 ADD       L6B           LRB
033800991229     CL6                 ADD       L6P           LRP
033900991229     CL6                 XFOOT     L6P           L6PREM            9 2
034000930519     CL6   #END2         TAG
034100991229
034200991229     CLRNU6              XFOOT     LRP           LRPREM            9 2
034300930519     CLR U6              EXCEPT    CRTRIA
034400930519     CLR U6              EXCEPT    HEAD2
034500930519     CLR U6              EXCEPT    NOREC
034600991229      ****************************************************************
034700991229      *   FIELD= LAST, FIRST MI.
034800991229      *------------------- COMPRESS NAME FIELDS ---------------------*
034900991229      *
035000991229     C     #NAMEL        BEGSR
035100991229      *
035200991229      * INITIALIZE ARRAY AND COUNTER
035300991229      *
035400991229     C                   MOVE      *BLANKS       N
035500991229     C                   Z-ADD     35            N#                2 0
035600991229     C                   MOVEA     LNAME         N(1)
035700991229      *
035800991229      *  FIND FIRST BLANK SPACE
035900991229      *
036000991229     C                   DOU       N(N#) <> ' '
036100991229     C                   SUB       1             N#
036200991229     C                   END
036300991229      *
036400991229      * MOVE IN , AND FNAME
036500991229      *
036600991229     C                   ADD       1             N#
036700991229     C                   MOVEA     ','           N(N#)
036800991229     C                   ADD       2             N#
036900991229     C                   MOVEA     FNAME         N(N#)
037000991229      *
037100991229      * FIND END OF FNAME AND MOVE IN MI
037200991229      *
037300991229     C                   DOU       N(N#) = ' '
037400991229     C                   ADD       1             N#
037500991229     C                   END
037600991229
037700991229     C  N50              IF        N# <= 27
037800991229     C                   ADD       1             N#
037900991229     C                   MOVEA     MI            N(N#)
038000991229     C                   ADD       1             N#
038100991229     C                   MOVEA     '.'           N(N#)
038200991229     C                   END
038300991229
038400991229     C                   ENDSR
038500991229
038600991229      ***************************************************
038700991229      * CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
038800991229      ***************************************************
038900991229      * DATE IN  = @DATIN (8.0) YYYYMMDD
039000991229      * DATE OUT = @DATOU (8.0) MMDDYYYY
039100991229
039200991229     C     #DATYM        BEGSR
039300980806     C                   MOVE      @DATIN        @MD               4 0
039400980806     C                   MOVEL     @DATIN        @Y                4 0
039500980806     C                   MOVEL     @MD           @DATOU            8 0
039600980806     C                   MOVE      @Y            @DATOU
039700980806     C                   MOVE      *ZEROS        @DATIN            8 0
039800991229     C                   ENDSR
039900991229
040000991229     OREPORT    E            CRTRIA         3 03
040100991229     O                       CONAME             110
040200991229     O          E            CRTRIA         3
040300920618     O                                           98 'Life Format Transmittals'
040400991229     O          E            CRTRIA         2
040500920618     O                                           77 '1. Enter The Trust# to '
040600920618     O                                          101 'print...................'
040700920618     O                                          115 '............. '
040800920618     O                       LTRUST             118
040900991229     O          E            CRTRIA         3
041000920618     O                                           78 '2.   If "ALL" enter the '
041100920618     O                                          102 'Trust Category to print.'
041200920618     O                                          115 '............ '
041300941019     O                       COD                149
041400991229     O          E            CRTRIA         2
041500920618     O                                           76 '3. Print all activity '
041600920618     O                                           96 'since last report (Y'
041700920618     O                                          115 'or N)............. '
041800941019     O                       SELECT             116
041900991229     O          E            CRTRIA         2
042000920618     O                                           79 'If NO Enter the trans'
042100920618     O                                           97 'action date range '
042200920618     O                                          119 'to select for printing'
042300991229     O          E            CRTRIA         2
042400920618     O                                           77 '4. From Date.......'
042500980806     O                       LFDATE              86
042600991229     O          E            CRTRIA         2
042700920618     O                                           77 '5. To Date.........'
042800980806     O                       LTDATE              86
042900991229     O          E            HEAD           2 03
043000991229     O                       CONAME             108
043100991229     O          E            HEAD           1
043200991229     O                                           98 'L I F E  B E N E F I T S'
043300991229     O                                          107 '  L I S T'
043400991229     O          E            HEAD           1
043500991229     O                       LFDATE              92 '  /  /    '
043600991229     O                                           94 '-'
043700991229     O                       LTDATE             105 '  /  /    '
043800991229     O          E            HEAD           2
043900991229     O               21                          98 '*** ADDITIONS ***'
044000991229     O               25                         100 '*** BENEFIT AMOUNT CHANG'
044100991229     O               25                         106 'ES ***'
044200991229     O               22                         105 '*** COVERAGE CHANGES ***'
044300991229     O               23                          98 '*** DELETIONS ***'
044400991229     O               24                         105 '*** COVERAGE REINSTATEME'
044500991229     O               24                         112 'NTS ***'
044600910215     O               26                         105 '*** ENROLLMENT DATE CHAN'
044700910215     O               26                         112 'GES ***'
044800910215     O               27                         104 '*** AGEBAND CHANGES ***'
044900910927     O               28                          94 '*** COVERAGE CANCEL DATE'
045000910927     O               28                         106 'CHANGES ***'
045100991229     O          E            HEAD           1
045200991229     O                                           15 'CARRIER NAME:'
045300991229      **7/29/97
045400970728     O                       CAR#                20
045500970728     O                       CARNAM              65
045600991229      **7/29/97                CNAME     56
045700991229     O          E            HEAD           1
045800991229     O                                            8 'TRUST:'
045900991229     O                       TNAME               32
046000991229     O          E            HEAD           1
046100991229     O                                           16 'POLICY NUMBER:'
046200910215     O                       GROUP#              33
046300991229     O          E            HEAD           2
046400991229     O                                           11 'DUE DATE:'
046500991229     O                       COVMDY              23 '  /  /    '
046600991229
046700991229     O          E            HEAD           1
046800991229     O                                           22 'PROGRAM NAME: CR020B'
046900991229     O                                          188 'PAGE:'
047000991229     O                       CNT           Z    194
047100991229     O          E            HEAD           1
047200991229     O                                           11 'RUN DATE:'
047300991229     O                       UDATE         Y     22
047400991229     O                                          186 '* = MULTIPLE TRANSACTION'
047500991229     O                                          198 'S PER COLUMN'
047600991229     O          E            HEAD           1
047700991229     O                                           24 '""""""""""""""""""""""""'
047800991229     O                                           48 '""""""""""""""""""""""""'
047900991229     O                                           72 '""""""""""""""""""""""""'
048000991229     O                                           96 '""""""""""""""""""""""""'
048100991229     O                                          120 '""""""""""""""""""""""""'
048200991229     O                                          144 '""""""""""""""""""""""""'
048300991229     O                                          168 '""""""""""""""""""""""""'
048400991229     O                                          192 '""""""""""""""""""""""""'
048500991229     O                                          198 '""""""'
048600991229     O          E            HEAD           1
048700991229     O                                            8 'ACCT.NO.'
048800991229     O                                           37 'TRANS'
048900991229     O                                           79 'LIFE AD&D'
049000991229     O                                           91 'LIFE AD&D'
049100991229     O                                          102 'DEP.LIFE'
049200991229     O                                          114 'DEP.LIFE'
049300991229     O                                          123 'WDI'
049400991229     O                                          135 'WDI'
049500991229     O                                          146 'LTD'
049600991229     O                                          158 'LTD'
049700991229     O                                          171 'SUP.LIFE'
049800991229     O                                          183 'SUP.LIFE'
049900991229     O                                          197 'TOTAL'
050000991229     O          E            HEAD           1
050100991229     O                                           15 'EMPLOYEE'
050200991229     O                                           36 'DATE'
050300991229     O                                           51 'SOC.SEC.#'
050400991229     O                                           57 'SEX'
050500991229     O                                           68 'D.O.B.'
050600991229     O                                           78 'BENEFIT'
050700991229     O                                           90 'PREMIUM'
050800991229     O                                          101 'BENEFIT'
050900991229     O                                          113 'PREMIUM'
051000991229     O                                          125 'BENEFIT'
051100991229     O                                          137 'PREMIUM'
051200991229     O                                          148 'BENEFIT'
051300991229     O                                          160 'PREMIUM'
051400991229     O                                          170 'BENEFIT'
051500991229     O                                          182 'PREMIUM'
051600991229     O                                          198 'PREMIUM'
051700991229     O          E            HEAD           2
051800991229     O                                           24 '""""""""""""""""""""""""'
051900991229     O                                           48 '""""""""""""""""""""""""'
052000991229     O                                           72 '""""""""""""""""""""""""'
052100991229     O                                           96 '""""""""""""""""""""""""'
052200991229     O                                          120 '""""""""""""""""""""""""'
052300991229     O                                          144 '""""""""""""""""""""""""'
052400991229     O                                          168 '""""""""""""""""""""""""'
052500991229     O                                          192 '""""""""""""""""""""""""'
052600991229     O                                          198 '""""""'
052700991229     O          E            HEAD           1
052800991229     O                                           24 '------------------------'
052900991229     O                                           48 '------------------------'
053000991229     O                                           72 '------------------------'
053100991229     O                                           96 '------------------------'
053200991229     O                                          120 '------------------------'
053300991229     O                                          144 '------------------------'
053400991229     O                                          168 '------------------------'
053500991229     O                                          192 '------------------------'
053600991229     O                                          198 '------'
053700991229     O          E            L2OUT          1
053800991229     O                       ACCNO               12 '   -   -    '
053900991229     O                       ACNAM1              64
054000991229     O          E            L2OUT          1
054100991229     O                       AADDR1              54
054200991229     O          E            L2OUT          2
054300991229     O                       ACITY               39
054400991229     O                       ASTATE              52
054500991229     O                       AZIP                63 '     -    '
054600991229
054700991229     O          T    L1                     1
054800910930     O               40                           1 '*'
054900991229     O                       N                   37
055000991229     O                                           30 ' '
055100991229     O                       TRDMDY         B    40 '  /  /    '
055200991229     O                       SSNO                53 '   -  -    '
055300991229     O                       SEX                 56
055400991229     O                       BIRTH               68 '  /  /    '
055500991229     O                       L1B(1)        MB    79
055600991229     O                       L1P(1)        LB    91
055700991229     O                       L1B(2)        MB   102
055800991229     O                       L1P(2)        LB   114
055900991229     O                       L1B(3)        MB   125
056000991229     O                       L1P(3)        LB   137
056100991229     O                       L1B(4)        MB   148
056200991229     O                       L1P(4)        LB   160
056300991229     O                       L1B(5)        MB   171
056400991229     O                       L1P(5)        LB   183
056500991229     O                       L1PREM        LB   198
056600991229     O          T    L1 26                  1
056700991229     O         OR    L1 28
056800991229     O                       NOTEH          B    68
056900991229     O          T    L2                     1
057000991229     O                                           57 '...............'
057100991229     O                                           80 '........................'
057200991229     O                                          104 '........................'
057300991229     O                                          128 '........................'
057400991229     O                                          152 '........................'
057500991229     O                                          176 '........................'
057600991229     O                                          198 '......................'
057700991229     O          T    L2                     2
057800991229     O                       L2B(1)        MB    79
057900991229     O                       L2P(1)        LB    91
058000991229     O                       L2B(2)        MB   102
058100991229     O                       L2P(2)        LB   114
058200991229     O                       L2B(3)        MB   125
058300991229     O                       L2P(3)        LB   137
058400991229     O                       L2B(4)        MB   148
058500991229     O                       L2P(4)        LB   160
058600991229     O                       L2B(5)        MB   171
058700991229     O                       L2P(5)        LB   183
058800991229     O                       L2PREM        LB   198
058900991229     O          T    L2                     1
059000991229     O                                           24 '------------------------'
059100991229     O                                           48 '------------------------'
059200991229     O                                           72 '------------------------'
059300991229     O                                           96 '------------------------'
059400991229     O                                          120 '------------------------'
059500991229     O                                          144 '------------------------'
059600991229     O                                          168 '------------------------'
059700991229     O                                          192 '------------------------'
059800991229     O                                          198 '------'
059900991229     O          T    L3                     2
060000991229     O                                           25 'EFFECTIVE DATE TOTALS-->'
060100991229     O                                           41 '(TOTAL MEMBERS:'
060200991229     O                       L3MEM         LB    49
060300991229     O                                           50 ')'
060400991229     O                       L3B(1)        MB    79
060500991229     O                       L3P(1)        LB    91
060600991229     O                       L3B(2)        MB   102
060700991229     O                       L3P(2)        LB   114
060800991229     O                       L3B(3)        MB   125
060900991229     O                       L3P(3)        LB   137
061000991229     O                       L3B(4)        MB   148
061100991229     O                       L3P(4)        LB   160
061200991229     O                       L3B(5)        MB   171
061300991229     O                       L3P(5)        LB   183
061400991229     O                       L3PREM        LB   198
061500991229     O          T    L4                     2
061600991229     O               21                          25 'ADDITION TOTALS-------->'
061700991229     O               22                          25 'CHANGE COVERAGE TOTALS->'
061800991229     O               23                          25 'DELETION TOTALS-------->'
061900991229     O               24                          25 'COVERAGE REIN. TOTALS-->'
062000991229     O               25                          25 'BEN. AMT CHANGES TOTAL->'
062100991229     O               28                          25 'CHANGE CAN. DATE TOTAL->'
062200991229     O                                           41 '(TOTAL MEMBERS:'
062300991229     O                       L4MEM         LB    49
062400991229     O                                           50 ')'
062500991229     O                       L4B(1)        MB    79
062600991229     O                       L4P(1)        LB    91
062700991229     O                       L4B(2)        MB   102
062800991229     O                       L4P(2)        LB   114
062900991229     O                       L4B(3)        MB   125
063000991229     O                       L4P(3)        LB   137
063100991229     O                       L4B(4)        MB   148
063200991229     O                       L4P(4)        LB   160
063300991229     O                       L4B(5)        MB   171
063400991229     O                       L4P(5)        LB   183
063500991229     O                       L4PREM        LB   198
063600991229     O          T    L5                     2
063700991229     O                                           25 'TRUST TOTALS----------->'
063800991229     O                       L5B(1)        MB    79
063900991229     O                       L5P(1)        LB    91
064000991229     O                       L5B(2)        MB   102
064100991229     O                       L5P(2)        LB   114
064200991229     O                       L5B(3)        MB   125
064300991229     O                       L5P(3)        LB   137
064400991229     O                       L5B(4)        MB   148
064500991229     O                       L5P(4)        LB   160
064600991229     O                       L5B(5)        MB   171
064700991229     O                       L5P(5)        LB   183
064800991229     O                       L5PREM        LB   198
064900991229     O          T    L6                     2
065000991229     O                                           25 'CARRIER TOTALS--------->'
065100991229     O                       L6B(1)        MB    79
065200991229     O                       L6P(1)        LB    91
065300991229     O                       L6B(2)        MB   102
065400991229     O                       L6P(2)        LB   114
065500991229     O                       L6B(3)        MB   125
065600991229     O                       L6P(3)        LB   137
065700991229     O                       L6B(4)        MB   148
065800991229     O                       L6P(4)        LB   160
065900991229     O                       L6B(5)        MB   171
066000991229     O                       L6P(5)        LB   183
066100991229     O                       L6PREM        LB   198
066200991229     O          T    LR                     2 03
066300991229     O                                           68 '*** LIFE INSURANCE GRAND'
066400991229     O                                           79 'TOTALS ***'
066500991229     O          T    LR                     2
066600991229     O                                           24 '------------------------'
066700991229     O                                           48 '------------------------'
066800991229     O                                           72 '------------------------'
066900991229     O                                           96 '------------------------'
067000991229     O                                          120 '------------------------'
067100991229     O                                          144 '------------------------'
067200991229     O                                          168 '------------------------'
067300991229     O                                          192 '------------------------'
067400991229     O                                          198 '------'
067500991229     O          T    LR                     2
067600991229     O                                           25 'GRAND TOTALS----------->'
067700991229     O                       LRB(1)        MB    79
067800991229     O                       LRP(1)        LB    91
067900991229     O                       LRB(2)        MB   102
068000991229     O                       LRP(2)        LB   114
068100991229     O                       LRB(3)        MB   125
068200991229     O                       LRP(3)        LB   137
068300991229     O                       LRB(4)        MB   148
068400991229     O                       LRP(4)        LB   160
068500991229     O                       LRB(5)        MB   171
068600991229     O                       LRP(5)        LB   183
068700991229     O                       LRPREM        LB   198
068800991229     O          E            HEAD2          2 03
068900991229     O                       CONAME             108
069000991229     O          E            HEAD2          1
069100991229     O                                           98 'L I F E  B E N E F I T S'
069200991229     O                                          107 '  L I S T'
069300991229     O          E            HEAD2          1
069400991229     O                       LFDATE              92 '  /  /    '
069500991229     O                                           94 '-'
069600991229     O                       LTDATE             105 '  /  /    '
069700991229
069800991229     O          E            HEAD2          1
069900991229     O                                           22 'PROGRAM NAME: CR020B'
070000991229     O                                          188 'PAGE:'
070100991229     O                       PAGE          Z    194
070200991229     O          E            HEAD2          1
070300991229     O                                           11 'RUN DATE:'
070400991229     O                       UDATE         Y     22
070500991229     O          E            HEAD2          1
070600991229     O                                           24 '""""""""""""""""""""""""'
070700991229     O                                           48 '""""""""""""""""""""""""'
070800991229     O                                           72 '""""""""""""""""""""""""'
070900991229     O                                           96 '""""""""""""""""""""""""'
071000991229     O                                          120 '""""""""""""""""""""""""'
071100991229     O                                          144 '""""""""""""""""""""""""'
071200991229     O                                          168 '""""""""""""""""""""""""'
071300991229     O                                          192 '""""""""""""""""""""""""'
071400991229     O                                          198 '""""""'
071500991229     O          E            HEAD2          1
071600991229     O                                            8 'ACCT.NO.'
071700991229     O                                           37 'TRANS'
071800991229     O                                           79 'LIFE AD&D'
071900991229     O                                           91 'LIFE AD&D'
072000991229     O                                          102 'DEP.LIFE'
072100991229     O                                          114 'DEP.LIFE'
072200991229     O                                          123 'WDI'
072300991229     O                                          135 'WDI'
072400991229     O                                          146 'LTD'
072500991229     O                                          158 'LTD'
072600991229     O                                          171 'SUP.LIFE'
072700991229     O                                          183 'SUP.LIFE'
072800991229     O                                          197 'TOTAL'
072900991229     O          E            HEAD2          1
073000991229     O                                           15 'EMPLOYEE'
073100991229     O                                           36 'DATE'
073200991229     O                                           51 'SOC.SEC.#'
073300991229     O                                           57 'SEX'
073400991229     O                                           68 'D.O.B.'
073500991229     O                                           78 'BENEFIT'
073600991229     O                                           90 'PREMIUM'
073700991229     O                                          101 'BENEFIT'
073800991229     O                                          113 'PREMIUM'
073900991229     O                                          125 'BENEFIT'
074000991229     O                                          137 'PREMIUM'
074100991229     O                                          148 'BENEFIT'
074200991229     O                                          160 'PREMIUM'
074300991229     O                                          170 'BENEFIT'
074400991229     O                                          182 'PREMIUM'
074500991229     O                                          198 'PREMIUM'
074600991229     O          E            HEAD2          2
074700991229     O                                           24 '""""""""""""""""""""""""'
074800991229     O                                           48 '""""""""""""""""""""""""'
074900991229     O                                           72 '""""""""""""""""""""""""'
075000991229     O                                           96 '""""""""""""""""""""""""'
075100991229     O                                          120 '""""""""""""""""""""""""'
075200991229     O                                          144 '""""""""""""""""""""""""'
075300991229     O                                          168 '""""""""""""""""""""""""'
075400991229     O                                          192 '""""""""""""""""""""""""'
075500991229     O                                          198 '""""""'
075600991229     O          E            HEAD2          1
075700991229     O                                           24 '------------------------'
075800991229     O                                           48 '------------------------'
075900991229     O                                           72 '------------------------'
076000991229     O                                           96 '------------------------'
076100991229     O                                          120 '------------------------'
076200991229     O                                          144 '------------------------'
076300991229     O                                          168 '------------------------'
076400991229     O                                          192 '------------------------'
076500991229     O                                          198 '------'
076600930520     O          E            NOREC       2  2
076700930715     O                                           24 'NO ENTRIES FOR LIFE PLAN'
076800941220     O                                           48 'S                       '
076900910215**  NOT FOUND MESSAGE
077000910215--- NOT FOUND --------------------------
