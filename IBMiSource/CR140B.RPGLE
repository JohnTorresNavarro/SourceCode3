000100001016     H DFTNAME(CR140B) FIXNBR(*ZONED)
000200991229      ******************************************************************
000300991229      * CR140B    GROUP BENEFIT SERVICES SOFTWARE           1989      *
000400991229      *                                                                *
000500991229      *            WRITTEN BY - MICHAEL C. DUNPHY                      *
000600991229      *            DATE - 10/23/89                                     *
000700991229      *                                                                *
000800991229      *  DESCRIPTION - THIS PROGRAM WILL PRINT LIFE FORMAT TRANSMITTALS*
000900991229      *                                                                *
001000991229      *  Y2K CONVERT - 1998                                            *
001100991229      *                                                                *
001200991229      * 12/1999  KSJ - Converted to RPG ILE                            *
001300001227      * 12/27/00 DLK - add plan cat "PAC" to col 5 per finance request *
001400010620      * 06/20/01 DLK - add plan cat "PSP" to col 5 per finance request *
001500020822      * 08/23/01 DLK - add plan cat "POA" to col 5 per finance request *
001600020822      * 09/19/01 DLK - add plan cat "PVL" to col 4 per finance request *
001700020912      *  9/04/02 SZZ - Page break at account level per Carol Santucci. *
001800020912      *                Add a level break for GROUP# so that another    *
001900020912      *                line will be printed if there are multiple      *
002000020912      *                groups for the member.                          *
002100021213      * 12/13/02 DLK - more plan cat changes per finance request       *
002200040211      * 02/11/04 DLK - add plan cat "PCC" to col 5 per finance request *
002300020822      *                                                                *
002400021213      *                * Note - when adding new plan cat, make sure    *
002500021213      *                you add to CR140B, CR020B & CR040B              *
002600000103      *                                                                *
002700991229      ******************************************************************
002800991229     FTRANS     IP   F  232        DISK
002900060218     FCARMST    IF   F  278     3AIDISK    KEYLOC(1)
003000991229     FMEMBER    IF   F  648     9AIDISK    KEYLOC(1)
003100991229     FACCMST    IF   F  560    10AIDISK    KEYLOC(1)
003200991229     FTRSMST    IF   F  264     3AIDISK    KEYLOC(1)
003300991229     FPLNMST    IF   F  200    10AIDISK    KEYLOC(1)
003400991229     FREPORT    O    F  198        PRINTER OFLIND(*INOF)
003500920603     F                                     FORMLEN(66)
003600920603     F                                     FORMOFL(55)
003700991229
003800991229     D NF              S              1    DIM(40) CTDATA PERRCD(1)             NOT FOUND MESSAGE
003900991229     D N               S              1    DIM(35)                              NAME WORK ARRAY
004000991229     D L1B             S              9  0 DIM(5)
004100991229     D L1P             S              9  2 DIM(5)
004200991229     D L2B             S              9  0 DIM(5)
004300991229     D L2P             S              9  2 DIM(5)
004400991229     D L3B             S              9  0 DIM(5)
004500991229     D L3P             S              9  2 DIM(5)
004600991229     D L4B             S              9  0 DIM(5)
004700991229     D L4P             S              9  2 DIM(5)
004800991229     D L5B             S              9  0 DIM(5)
004900991229     D L5P             S              9  2 DIM(5)
005000991229     D L7B             S              9  0 DIM(5)
005100991229     D L7P             S              9  2 DIM(5)
005200991229     D L8B             S              9  0 DIM(5)
005300991229     D L8P             S              9  2 DIM(5)
005400991229     D LRB             S              9  0 DIM(5)
005500991229     D LRP             S              9  2 DIM(5)
005600991229
005700991229      *   DATA STRUCTURE PLAN MASTER FILE KEY
005800991229     D                 DS
005900991229     D  PLNKEY                 1     10
006000991229     D  TRUST#                 1      3  0
006100991229     D  SUB#                   4      6  0
006200991229     D  PLAN#                  7     10
006300991229
006400991229      * LDA
006500991229     D                UDS
006600991229     D  LTRUST                 7      9                                         COMPNY
006700980806     D  COD                   53     86
006800991229     D  LFDATE                37     44  0                                      COMPNY
006900991229     D  LTDATE                45     52  0                                      COMPNY
007000991229     D  SELECT                90     90
007100991229     D  CONAME               201    240                                         COMPNY
007200991229     D  STIME                242    253  0                                      COMPNY
007300991229     D  HMS                  242    247  0                                      COMPNY
007400991229
007500991229     ITRANS     NS  01
007600020912     I                                  2   10 0SSNO          L2
007700991229     I                                 18   19  CODECK
007800991229     I                                 17   19  TRCODE
007900991229     I                                 26   55  CK#NOT
008000991229     I                                 56   85  NOTE2
008100991229     I                                 26   29  PLAN#
008200991229     I                                 40   41 0AGEBND
008300991229     I                                 52   53  TYPCOD
008400991229     I                                 79   80  OLDCOD
008500991229     I                             P   94   97 0OBAMT
008600991229     I                             P   98  101 0NBENFT
008700020912     I                                110  112 0TRUST#        L6
008800020912     I                                113  115 0SUB#          L5
008900020912     I                                110  119 0ACC#          L5
009000020912     I                                125  125  SGRREM        L7
009100020912     I                                126  128  CTLFLD        L9
009200991229     I                                129  136 0TRDATE
009300020912     I                                153  160 0COVTDT        L4
009400991229     I                                153  156 0COVYR
009500991229     I                                157  158 0COVMO
009600991229     I                                159  160 0COVDD
009700020912     I                                163  177  GROUP#        L1
009800991229     I                                185  202  LNAME
009900991229     I                                203  215  FNAME
010000991229     I                                217  217  MI                      50
010100991229     I                                222  228 2PREM
010200020912     I                                229  231  CARKEY        L8
010300020912     I                                232  232  ACTION        L3
010400991229
010500991229     IMEMBER    NS
010600991229      *  MEMBER FILE
010700991229     I                                129  129  SEX
010800991229     I                                513  520 0BIRTH
010900991229
011000991229      * TRUST MASTER FILE
011100991229     ITRSMST    NS
011200991229     I                                  4   23  TNAME
011300991229
011400991229      * CARRIER MASTER FILE
011500991229     ICARMST    NS
011600991229     I                                  4   43  CNAME
011700991229
011800991229      * PLAN MASTER FILE
011900991229     IPLNMST    NS
012000991229     I                                163  165  PLNCAT
012100991229
012200991229     IACCMST    NS
012300991229     I                                  1   10 0ACCNO
012400991229     I                                 11   50  ACNAM1
012500991229     I                                 91  120  AADDR1
012600991229     I                                151  165  ACITY
012700991229     I                                166  167  ASTATE
012800991229     I                             P  168  172 0AZIP
012900991229
013000991229      *****************************************************************
013100991229      *   M A I N   L I N E   C A L C U L A T I O N S                 *
013200991229      *****************************************************************
013300920617     C                   IF        FLAG <> 'Y'
013400920617     C                   EXCEPT    CRTRIA
013500920728     C                   Z-ADD     0             CNT               7 0
013600920617     C                   MOVE      'Y'           FLAG              1
013700920617     C                   END
013800991229
013900991229      * GET CARRIER NAME FOR HEADINGS
014000991229
014100020912     C   L8CARKEY        CHAIN     CARMST                             98
014200991229     C   98              MOVEL     NF(1)         CNAME
014300991229
014400991229      * GET TRUST NAME FOR HEADINGS
014500991229
014600020912     C   L6TRUST#        CHAIN     TRSMST                             98
014700991229     C   98              MOVEL     NF(1)         TNAME
014800991229
014900991229      * CHECK ACTION CODE FOR A=ADDITIONS, D=DELETIONS, OR C=CHANGE IN COV.TYPE
015000991229
015100020912     C  NL3              GOTO      #T0010
015200991229     C                   SETOFF                                       212223
015300910215     C                   SETOFF                                       252627
015400910927     C                   SETOFF                                       2428
015500991229     C                   IF        ACTION = 'A'
015600991229     C                   SETON                                            21
015700991229     C                   END
015800991229     C                   IF        ACTION = 'C'
015900991229     C                   SETON                                            22
016000991229     C                   END
016100991229     C                   IF        ACTION = 'D'
016200991229     C                   SETON                                            23
016300991229     C                   END
016400991229     C                   IF        ACTION = 'R'
016500991229     C                   SETON                                            24
016600991229     C                   END
016700991229     C                   IF        ACTION = 'B'
016800991229     C                   SETON                                            25
016900991229     C                   END
017000991229     C                   IF        ACTION = 'E'
017100991229     C                   SETON                                            26
017200991229     C                   END
017300991229     C                   IF        ACTION = 'G'
017400991229     C                   SETON                                            27
017500991229     C                   END
017600991229     C                   IF        ACTION = 'H'
017700991229     C                   SETON                                            28
017800991229     C                   END
017900991229     C     #T0010        TAG
018000991229
018100991229      * IF CHANGE IN ENROLLMENT DATE OR CANCEL DATE, DISPLAY NOTE2
018200991229      * FIELD IN HISTORY WHICH HAS FROM AND TO DATE
018300991229
018400991229     C   26
018500991229     COR 28              MOVE      NOTE2         NOTEH            30
018600991229
018700991229      * START NEW PAGE FOR BREAK OR OVERFLOW
018800991229
018900020912     C   L5
019000020912     COR L6
019100991229     COR OF              ADD       1             CNT
019200020912     C   L5
019300020912     COR L6
019400991229     COR OF              EXCEPT    HEAD
019500991229
019600991229      * USE BEN AMOUNT CHANGE FOR CHANGE
019700991229
019800991229     C                   IF        TRCODE = 'MCB'
019900910215     C                   Z-ADD     NBENFT        BENFTN            8 0
020000910215     C                   Z-ADD     OBAMT         BENFTO            8 0
020100991229     C     BENFTN        SUB       BENFTO        NBAMT             8 0
020200991229     C                   GOTO      #T0015
020300991229     C                   END
020400991229     C                   IF        TRCODE = 'MCC'
020500991229     C                   Z-ADD     0             NBAMT
020600991229     C                   GOTO      #T0015
020700991229     C                   END
020800991229     C                   IF        TRCODE = 'MCA'
020900991229     C                   Z-ADD     0             NBAMT
021000991229     C                   GOTO      #T0015
021100991229     C                   END
021200910215     C                   Z-ADD     OBAMT         NBAMT
021300910215     C     #T0015        TAG
021400991229
021500991229      * GET ACCOUNT NAME FOR HEADINGS
021600991229
021700020912     C   L5ACC#          CHAIN     ACCMST                             98
021800020912     C   L5
021900991229     CAN 98              MOVEL     NF(1)         ACNAM1
022000020912     C   L5              EXCEPT    L2OUT
022100991229
022200020912     C   L4              MOVE      COVTDT        @DATIN
022300020912     C   L4              EXSR      #DATYM
022400020912     C   L4              MOVE      @DATOU        COVRGE            8 0
022500991229
022600020912     C   L4              EXCEPT    TITLE
022700020912     C   L3
022800020912     CANNL4              EXCEPT    TITLE
022900991229
023000991229      * GET MEMBER FOR SEX AND BIRTH
023100991229
023200991229     C     SSNO          CHAIN     MEMBER                             H7
023300991229
023400980806     C                   MOVE      BIRTH         @DATIN
023500980806     C                   EXSR      #DATYM
023600980806     C                   MOVE      @DATOU        BIRTH
023700991229
023800991229      * GET PLAN CATEGORY TO CONTROL PRINT COLUMN
023900991229
024000991229     C     PLNKEY        CHAIN     PLNMST                             H8
024100991229
024200020912     C   L2              SETOFF                                         4041    42
024300020912     C   L2              SETOFF                                         4344    45
024400991229
024500991229      *------------  ACCUMULATE TOTALS -------------------------
024600991229
024700991229      * ADD LIFE AND AD&D TO ARRAY.
024800021213      * column 1
024900021213      *
025000021213     C                   IF        PLNCAT = 'PLF' or plncat = 'PNL' or
025100021213     C                             plncat = 'PAC' or plncat = 'PTL' or
025200021213     C                             plncat = 'PTA'
025300910930     C   41              SETON                                          40
025400910930     C                   SETON                                          41
025500910927     C  N26
025600991229     CANN28              ADD       NBAMT         L1B(1)
025700991229     C                   ADD       PREM          L1P(1)
025800991229     C                   END
025900991229
026000991229      * ADD DEPENDENT LIFE TO ARRAY.
026100021213      * column 2
026200991229
026300021213     C                   IF        PLNCAT = 'PDL' or plncat = 'PDE' or
026400021213     C                             plncat = 'PSD' or plncat = 'PVD' or
026500021213     C                             plncat = 'PTD'
026600910930     C   42              SETON                                          40
026700910930     C                   SETON                                          42
026800991229     C                   ADD       NBAMT         L1B(2)
026900991229     C                   ADD       PREM          L1P(2)
027000991229     C                   END
027100991229
027200991229      * ADD WEEKLY DISABILITY TO ARRAY.
027300021213      * column 3
027400991229
027500021213     C                   IF        PLNCAT = 'PWD' or plncat = 'PWS' or
027600021213     C                             plncat = 'PVW' or plncat = 'PTS'
027700910930     C   43              SETON                                          40
027800910930     C                   SETON                                          43
027900991229     C                   ADD       NBAMT         L1B(3)
028000991229     C                   ADD       PREM          L1P(3)
028100991229     C                   END
028200991229
028300991229      * ADD LONG TERM DISABILITY TO ARRAY.
028400021213      * column 4
028500991229
028600021213     C                   IF        PLNCAT = 'PLT' or plncat = 'PVL' or
028700021213     C                             plncat = 'PST' or plncat = 'PTT'
028800910930     C   44              SETON                                          40
028900910930     C                   SETON                                          44
029000991229     C                   ADD       NBAMT         L1B(4)
029100991229     C                   ADD       PREM          L1P(4)
029200991229     C                   END
029300991229
029400991229      * ADD SUPPLEMENTAL LIFE TO ARRAY.
029500021213      * column 5
029600991229
029700021213     C                   IF        PLNCAT = 'PSL' or plncat = 'PSW' or
029800021213     c                             plncat = 'PSP' or plncat = 'POA' or
029900021213     C                             plncat = 'PSA' or plncat = 'PSS' or
030000021213     c                             plncat = 'PLS' or plncat = 'PVA' or
030100040211     c                             plncat = 'PAA' or plncat = 'PLL' or
030200040211     c                             plncat = 'PCC'
030300910930     C   45              SETON                                          40
030400910930     C                   SETON                                          45
030500991229     C                   ADD       NBAMT         L1B(5)
030600991229     C                   ADD       PREM          L1P(5)
030700991229     C                   END
030800991229
030900991229      * PRINT TRDATE ON REPORT, BUT BE AWARE IT IS PRINTED AT
031000020912      * L1 DETAIL TIME(group) SO IF THERE ARE MORE THAN ONE TRANS.
031100991229      * ON A LINE, THE TRDATE COULD BE DIFFERENT
031200991229
031300980806     C                   MOVE      TRDATE        @DATIN
031400980806     C                   EXSR      #DATYM
031500980806     C                   MOVE      @DATOU        TRDMDY            8 0
031600991229
031700991229      ****************************************************************
031800991229      *  T O T A L    T I M E
031900991229      ****************************************************************
032000020912     CL2 U6              GOTO      #END2
032100020912     CL1                 EXSR      #NAMEL
032200020912
032300020912sz03 CL1                 ADD       1             L2MEM             6 0
032400020912sz03 CL1                 ADD       L1B           L2B
032500020912sz03 CL1                 ADD       L1P           L2P
032600020912sz02 CL1                 XFOOT     L1P           L1PREM            9 2
032700020912
032800020912     C*L2                 ADD       1             L2MEM             6 0
032900020912     C*L2                 ADD       L1B           L2B
033000020912     C*L2                 ADD       L1P           L2P
033100020912     C*L2                 XFOOT     L1P           L1PREM            9 2
033200991229
033300020912     CL3                 ADD       L2MEM         L3MEM             6 0
033400020912     CL3                 ADD       L2B           L3B
033500020912     CL3                 ADD       L2P           L3P
033600020912     CL3                 XFOOT     L2P           L2PREM            9 2
033700991229
033800020912     CL4                 ADD       L3MEM         L4MEM             6 0
033900020912     CL4                 ADD       L3B           L4B
034000020912     CL4                 ADD       L3P           L4P
034100020912     CL4                 XFOOT     L3P           L3PREM            9 2
034200991229
034300020912     CL5                 ADD       L4B           L5B
034400020912     CL5                 ADD       L4P           L5P
034500020912     CL5                 XFOOT     L4P           L4PREM            9 2
034600991229
034700020912     CL6                 ADD       L5B           L7B
034800020912     CL6                 ADD       L5P           L7P
034900020912     CL6                 XFOOT     L5P           L5PREM            9 2
035000020912     CL6                 Z-ADD     0             PAGE
035100991229
035200020912     CL8                 ADD       L7B           L8B
035300020912     CL8                 ADD       L7P           L8P
035400020912     CL8                 XFOOT     L7P           L7PREM            9 2
035500991229
035600020912     CL9                 ADD       L8B           LRB
035700020912     CL9                 ADD       L8P           LRP
035800020912     CL9                 XFOOT     L8P           L8PREM            9 2
035900020912     CL9   #END2         TAG
036000991229
036100991229     CLRNU6              XFOOT     LRP           LRPREM            9 2
036200930520     CLR U6              EXCEPT    CRTRIA
036300930520     CLR U6              EXCEPT    HEAD2
036400930520     CLR U6              EXCEPT    NOREC
036500991229      ****************************************************************
036600991229      *   FIELD= LAST, FIRST MI.
036700991229      *------------------- COMPRESS NAME FIELDS ---------------------*
036800991229
036900991229     C     #NAMEL        BEGSR
037000991229
037100991229      * INITIALIZE ARRAY AND COUNTER
037200991229
037300991229     C                   MOVE      *BLANKS       N
037400991229     C                   Z-ADD     35            N#                2 0
037500991229     C                   MOVEA     LNAME         N(1)
037600991229
037700991229      *  FIND FIRST BLANK SPACE
037800991229
037900991229     C                   DOU       N(N#) <> ' '
038000991229     C                   SUB       1             N#
038100991229     C                   END
038200991229
038300991229      * MOVE IN , AND FNAME
038400991229
038500991229     C                   ADD       1             N#
038600991229     C                   MOVEA     ','           N(N#)
038700991229     C                   ADD       2             N#
038800991229     C                   MOVEA     FNAME         N(N#)
038900991229
039000991229      * FIND END OF FNAME AND MOVE IN MI
039100991229
039200991229     C  N50              IF        N# <= 27
039300991229
039400991229     C                   DOU       N(N#) = ' '
039500991229     C                   ADD       1             N#
039600991229     C                   END
039700991229
039800991229     C                   ADD       1             N#
039900991229     C                   MOVEA     MI            N(N#)
040000991229     C                   ADD       1             N#
040100991229     C                   MOVEA     '.'           N(N#)
040200991229
040300991229     C                   END
040400991229
040500991229     C                   ENDSR
040600991229
040700991229      ***************************************************
040800991229      * CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
040900991229      ***************************************************
041000991229
041100991229      * DATE IN  = @DATIN (8.0) YYYYMMDD
041200991229      * DATE OUT = @DATOU (8.0) MMDDYYYY
041300991229
041400991229     C     #DATYM        BEGSR
041500980806     C                   MOVE      @DATIN        @MD               4 0
041600980806     C                   MOVEL     @DATIN        @Y                4 0
041700980806     C                   MOVEL     @MD           @DATOU            8 0
041800980806     C                   MOVE      @Y            @DATOU
041900980806     C                   MOVE      *ZEROS        @DATIN            8 0
042000991229     C                   ENDSR
042100991229
042200991229     OREPORT    E            CRTRIA         3 03
042300991229     O                       CONAME             110
042400991229     O          E            CRTRIA         3
042500920617     O                                           98 'Life Format Transmittals'
042600991229     O          E            CRTRIA         2
042700920618     O                                           77 '1. Enter The Trust# to '
042800920618     O                                          101 'print...................'
042900920618     O                                          115 '............. '
043000920618     O                       LTRUST             118
043100991229     O          E            CRTRIA         2
043200920618     O                                           78 '2.   If "ALL" enter the '
043300920618     O                                          102 'Trust Category to print.'
043400920618     O                                          115 '............ '
043500941013     O                       COD                149
043600991229     O          E            CRTRIA      1  3
043700920618     O                                           83 'Enter A Date Range To'
043800920618     O                                          103 'Print Transmittals'
043900991229     O          E            CRTRIA         2
044000920617     O                                           75 '3. Enter From Date...'
044100920617     O                                           99 '........................'
044200920617     O                                          115 '............... '
044300980806     O                       LFDATE             123
044400991229     O          E            CRTRIA         2
044500920617     O                                           73 '4. Enter To Date...'
044600920617     O                                           97 '........................'
044700920617     O                                          115 '................. '
044800980806     O                       LTDATE             123
044900991229     O          E            HEAD           2 03
045000991229     O                       CONAME             108
045100991229     O          E            HEAD           2
045200991229     O                                           98 'L I F E  B E N E F I T S'
045300991229     O                                          107 '  L I S T'
045400991229     O          E            HEAD           1
045500991229     O                                           15 'CARRIER NAME:'
045600991229     O                       CNAME               56
045700991229     O          E            HEAD           1
045800991229     O                                            8 'TRUST:'
045900991229     O                       TNAME               32
046000991229     O                                          192 'PAGE:'
046100991229     O                       CNT           Z    198
046200991229     O          E            HEAD           1
046300020904     O                                           17 'ACCOUNT NUMBER:'
046400020904     O                       ACC#                32 '   -   -    '
046500020904     O***JON                                     16 'POLICY NUMBER:'
046600020904     O***JON                 GROUP#              33
046700941013     O                                          194 'TRUST CATEGORY :'
046800941013     O                       CTLFLD             198
046900991229
047000991229     O          E            HEAD           1
047100991229     O                                           22 'PROGRAM NAME: CR140B'
047200941013     O                                          194 'SGR FLAG :'
047300941013     O                       SGRREM             198
047400991229     O          E            HEAD           1
047500991229     O                                           11 'RUN DATE:'
047600991229     O                       UDATE         Y     22
047700991229     O                                          186 '* = MULTIPLE TRANSACTION'
047800991229     O                                          198 'S PER COLUMN'
047900991229     O          E            HEAD           1
048000991229     O                                           24 '""""""""""""""""""""""""'
048100991229     O                                           48 '""""""""""""""""""""""""'
048200991229     O                                           72 '""""""""""""""""""""""""'
048300991229     O                                           96 '""""""""""""""""""""""""'
048400991229     O                                          120 '""""""""""""""""""""""""'
048500991229     O                                          144 '""""""""""""""""""""""""'
048600991229     O                                          168 '""""""""""""""""""""""""'
048700991229     O                                          192 '""""""""""""""""""""""""'
048800991229     O                                          198 '""""""'
048900991229     O          E            HEAD           1
049000991229     O                                            8 'ACCT.NO.'
049100991229     O                                           37 'TRANS'
049200991229     O                                           79 'LIFE AD&D'
049300991229     O                                           91 'LIFE AD&D'
049400991229     O                                          102 'DEP.LIFE'
049500991229     O                                          114 'DEP.LIFE'
049600991229     O                                          123 'WDI'
049700991229     O                                          135 'WDI'
049800991229     O                                          146 'LTD'
049900991229     O                                          158 'LTD'
050000991229     O                                          171 'SUP.LIFE'
050100991229     O                                          183 'SUP.LIFE'
050200991229     O                                          197 'TOTAL'
050300991229     O          E            HEAD           1
050400991229     O                                           15 'EMPLOYEE'
050500991229     O                                           36 'DATE'
050600991229     O                                           51 'SOC.SEC.#'
050700020904szz  O*********************************          57 'SEX'
050800020904szz  O*********************************          68 'D.O.B.'
050900020904szz  O                                           68 'Policy Group#'
051000991229     O                                           78 'BENEFIT'
051100991229     O                                           90 'PREMIUM'
051200991229     O                                          101 'BENEFIT'
051300991229     O                                          113 'PREMIUM'
051400991229     O                                          125 'BENEFIT'
051500991229     O                                          137 'PREMIUM'
051600991229     O                                          148 'BENEFIT'
051700991229     O                                          160 'PREMIUM'
051800991229     O                                          170 'BENEFIT'
051900991229     O                                          182 'PREMIUM'
052000991229     O                                          198 'PREMIUM'
052100991229     O          E            HEAD           2
052200991229     O                                           24 '""""""""""""""""""""""""'
052300991229     O                                           48 '""""""""""""""""""""""""'
052400991229     O                                           72 '""""""""""""""""""""""""'
052500991229     O                                           96 '""""""""""""""""""""""""'
052600991229     O                                          120 '""""""""""""""""""""""""'
052700991229     O                                          144 '""""""""""""""""""""""""'
052800991229     O                                          168 '""""""""""""""""""""""""'
052900991229     O                                          192 '""""""""""""""""""""""""'
053000991229     O                                          198 '""""""'
053100991229     O          E            HEAD           1
053200991229     O                                           24 '------------------------'
053300991229     O                                           48 '------------------------'
053400991229     O                                           72 '------------------------'
053500991229     O                                           96 '------------------------'
053600991229     O                                          120 '------------------------'
053700991229     O                                          144 '------------------------'
053800991229     O                                          168 '------------------------'
053900991229     O                                          192 '------------------------'
054000991229     O                                          198 '------'
054100991229     O          E            L2OUT          1
054200991229     O                       ACCNO               12 '   -   -    '
054300991229     O                       ACNAM1              64
054400991229     O          E            L2OUT          1
054500991229     O                       AADDR1              54
054600991229     O          E            L2OUT          2
054700991229     O                       ACITY               39
054800991229     O                       ASTATE              52
054900991229     O                       AZIP                63 '     -    '
055000991229     O          E            TITLE          2
055100991229     O                                           17 'EFFECTIVE DATE:'
055200991229     O                       COVRGE              31 '  /  /    '
055300991229     O               21                          98 '*** ADDITIONS ***'
055400991229     O               25                         100 '*** BENEFIT AMOUNT CHANG'
055500991229     O               25                         106 'ES ***'
055600991229     O               22                         105 '*** COVERAGE CHANGES ***'
055700991229     O               23                          98 '*** DELETIONS ***'
055800991229     O               24                         105 '*** COVERAGE REINSTATEME'
055900991229     O               24                         112 'NTS ***'
056000920601     O               26                         105 '*** ENROLLMENT DATE CHAN'
056100920601     O               26                         112 'GES ***'
056200920601     O               27                         104 '*** AGEBAND CHANGES ***'
056300920601     O               28                          94 '*** COVERAGE CANCEL DATE'
056400920601     O               28                         106 'CHANGES ***'
056500991229
056600020912     O******    T    L2                     1
056700020912     O          T    L1                     1
056800910930     O               40                           1 '*'
056900991229     O                       N                   37
057000991229     O                                           30 ' '
057100991229     O                       TRDMDY         B    40 '  /  /    '
057200991229     O                       SSNO                53 '   -  -    '
057300020904szz  O********************** SEX                 56
057400020904szz  O********************** BIRTH               68 '  /  /    '
057500020904szz  O                       GROUP#              70
057600991229     O                       L1B(1)        MB    79
057700991229     O                       L1P(1)        LB    91
057800991229     O                       L1B(2)        MB   102
057900991229     O                       L1P(2)        LB   114
058000991229     O                       L1B(3)        MB   125
058100991229     O                       L1P(3)        LB   137
058200991229     O                       L1B(4)        MB   148
058300991229     O                       L1P(4)        LB   160
058400991229     O                       L1B(5)        MB   171
058500991229     O                       L1P(5)        LB   183
058600991229     O                       L1PREM        LB   198
058700020912     O          T    L2 26                  1
058800020912     O         OR    L2 28
058900991229     O                       NOTEH          B    68
059000020912     O          T    L3                     1
059100991229     O                                           57 '...............'
059200991229     O                                           80 '........................'
059300991229     O                                          104 '........................'
059400991229     O                                          128 '........................'
059500991229     O                                          152 '........................'
059600991229     O                                          176 '........................'
059700991229     O                                          198 '......................'
059800020912     O          T    L3                     2
059900991229     O               21                          25 'ADDITION TOTALS-------->'
060000991229     O               22                          25 'CHANGE COVERAGE TOTALS->'
060100991229     O               23                          25 'DELETION TOTALS-------->'
060200991229     O               24                          25 'COVERAGE REIN. TOTALS-->'
060300991229     O               25                          25 'BEN. AMT CHANGES TOTAL->'
060400991229     O               28                          25 'CHANGE CAN. DATE TOTAL->'
060500991229     O                                           41 '(TOTAL MEMBERS:'
060600991229     O                       L2MEM         LB    49
060700991229     O                                           50 ')'
060800991229     O                       L2B(1)        MB    79
060900991229     O                       L2P(1)        LB    91
061000991229     O                       L2B(2)        MB   102
061100991229     O                       L2P(2)        LB   114
061200991229     O                       L2B(3)        MB   125
061300991229     O                       L2P(3)        LB   137
061400991229     O                       L2B(4)        MB   148
061500991229     O                       L2P(4)        LB   160
061600991229     O                       L2B(5)        MB   171
061700991229     O                       L2P(5)        LB   183
061800991229     O                       L2PREM        LB   198
061900020912     O          T    L4                     2
062000991229     O                                           25 'EFFECTIVE DATE TOTALS-->'
062100991229     O                                           41 '(TOTAL MEMBERS:'
062200991229     O                       L3MEM         LB    49
062300991229     O                                           50 ')'
062400991229     O                       L3B(1)        MB    79
062500991229     O                       L3P(1)        LB    91
062600991229     O                       L3B(2)        MB   102
062700991229     O                       L3P(2)        LB   114
062800991229     O                       L3B(3)        MB   125
062900991229     O                       L3P(3)        LB   137
063000991229     O                       L3B(4)        MB   148
063100991229     O                       L3P(4)        LB   160
063200991229     O                       L3B(5)        MB   171
063300991229     O                       L3P(5)        LB   183
063400991229     O                       L3PREM        LB   198
063500020912     O          T    L5                     2
063600991229     O                                           25 'ACCOUNT NUMBER TOTALS-->'
063700991229     O                                           41 '(TOTAL MEMBERS:'
063800991229     O                       L4MEM         LB    49
063900991229     O                                           50 ')'
064000991229     O                       L4B(1)        MB    79
064100991229     O                       L4P(1)        LB    91
064200991229     O                       L4B(2)        MB   102
064300991229     O                       L4P(2)        LB   114
064400991229     O                       L4B(3)        MB   125
064500991229     O                       L4P(3)        LB   137
064600991229     O                       L4B(4)        MB   148
064700991229     O                       L4P(4)        LB   160
064800991229     O                       L4B(5)        MB   171
064900991229     O                       L4P(5)        LB   183
065000991229     O                       L4PREM        LB   198
065100020912     O          T    L5                     1
065200991229     O                                           24 '------------------------'
065300991229     O                                           48 '------------------------'
065400991229     O                                           72 '------------------------'
065500991229     O                                           96 '------------------------'
065600991229     O                                          120 '------------------------'
065700991229     O                                          144 '------------------------'
065800991229     O                                          168 '------------------------'
065900991229     O                                          192 '------------------------'
066000991229     O                                          198 '------'
066100020912     O          T    L6                     2
066200991229     O                                           25 'TRUST TOTALS----------->'
066300991229     O                       L5B(1)        MB    79
066400991229     O                       L5P(1)        LB    91
066500991229     O                       L5B(2)        MB   102
066600991229     O                       L5P(2)        LB   114
066700991229     O                       L5B(3)        MB   125
066800991229     O                       L5P(3)        LB   137
066900991229     O                       L5B(4)        MB   148
067000991229     O                       L5P(4)        LB   160
067100991229     O                       L5B(5)        MB   171
067200991229     O                       L5P(5)        LB   183
067300991229     O                       L5PREM        LB   198
067400020912     O          T    L8                     2
067500991229     O                                           25 'CARRIER TOTALS--------->'
067600991229     O                       L7B(1)        MB    79
067700991229     O                       L7P(1)        LB    91
067800991229     O                       L7B(2)        MB   102
067900991229     O                       L7P(2)        LB   114
068000991229     O                       L7B(3)        MB   125
068100991229     O                       L7P(3)        LB   137
068200991229     O                       L7B(4)        MB   148
068300991229     O                       L7P(4)        LB   160
068400991229     O                       L7B(5)        MB   171
068500991229     O                       L7P(5)        LB   183
068600991229     O                       L7PREM        LB   198
068700020912     O          T    L9                     2
068800991229     O                                           25 'TRUST CATEGORY TOTALS-->'
068900991229     O                       L8B(1)        MB    79
069000991229     O                       L8P(1)        LB    91
069100991229     O                       L8B(2)        MB   102
069200991229     O                       L8P(2)        LB   114
069300991229     O                       L8B(3)        MB   125
069400991229     O                       L8P(3)        LB   137
069500991229     O                       L8B(4)        MB   148
069600991229     O                       L8P(4)        LB   160
069700991229     O                       L8B(5)        MB   171
069800991229     O                       L8P(5)        LB   183
069900991229     O                       L8PREM        LB   198
070000991229     O          T    LR                     2 03
070100991229     O                                           68 '*** LIFE INSURANCE GRAND'
070200991229     O                                           79 'TOTALS ***'
070300991229     O          T    LR                     2
070400991229     O                                           24 '------------------------'
070500991229     O                                           48 '------------------------'
070600991229     O                                           72 '------------------------'
070700991229     O                                           96 '------------------------'
070800991229     O                                          120 '------------------------'
070900991229     O                                          144 '------------------------'
071000991229     O                                          168 '------------------------'
071100991229     O                                          192 '------------------------'
071200991229     O                                          198 '------'
071300991229     O          T    LR                     2
071400991229     O                                           25 'GRAND TOTALS----------->'
071500991229     O                       LRB(1)        MB    79
071600991229     O                       LRP(1)        LB    91
071700991229     O                       LRB(2)        MB   102
071800991229     O                       LRP(2)        LB   114
071900991229     O                       LRB(3)        MB   125
072000991229     O                       LRP(3)        LB   137
072100991229     O                       LRB(4)        MB   148
072200991229     O                       LRP(4)        LB   160
072300991229     O                       LRB(5)        MB   171
072400991229     O                       LRP(5)        LB   183
072500991229     O                       LRPREM        LB   198
072600991229     O          E            HEAD2          2 03
072700991229     O                       CONAME             108
072800991229     O          E            HEAD2          1
072900991229     O                                           98 'L I F E  B E N E F I T S'
073000991229     O                                          107 '  L I S T'
073100991229     O          E            HEAD2          1
073200991229     O                       LFDATE              92 '  /  /    '
073300991229     O                                           94 '-'
073400991229     O                       LTDATE             105 '  /  /    '
073500991229
073600991229     O          E            HEAD2          1
073700991229     O                                           22 'PROGRAM NAME: CR140B'
073800991229     O                                          188 'PAGE:'
073900991229     O                       PAGE          Z    194
074000991229     O          E            HEAD2          1
074100991229     O                                           11 'RUN DATE:'
074200991229     O                       UDATE         Y     22
074300991229     O          E            HEAD2          1
074400991229     O                                           24 '""""""""""""""""""""""""'
074500991229     O                                           48 '""""""""""""""""""""""""'
074600991229     O                                           72 '""""""""""""""""""""""""'
074700991229     O                                           96 '""""""""""""""""""""""""'
074800991229     O                                          120 '""""""""""""""""""""""""'
074900991229     O                                          144 '""""""""""""""""""""""""'
075000991229     O                                          168 '""""""""""""""""""""""""'
075100991229     O                                          192 '""""""""""""""""""""""""'
075200991229     O                                          198 '""""""'
075300991229     O          E            HEAD2          1
075400991229     O                                            8 'ACCT.NO.'
075500991229     O                                           79 'LIFE AD&D'
075600991229     O                                           91 'LIFE AD&D'
075700991229     O                                          102 'DEP.LIFE'
075800991229     O                                          114 'DEP.LIFE'
075900991229     O                                          123 'WDI'
076000991229     O                                          135 'WDI'
076100991229     O                                          146 'LTD'
076200991229     O                                          158 'LTD'
076300991229     O                                          171 'SUP.LIFE'
076400991229     O                                          183 'SUP.LIFE'
076500991229     O                                          197 'TOTAL'
076600991229     O          E            HEAD2          1
076700991229     O                                           15 'EMPLOYEE'
076800991229     O                                           51 'SOC.SEC.#'
076900991229     O                                           59 'SEX'
077000991229     O                                           68 'D.O.B.'
077100991229     O                                           78 'BENEFIT'
077200991229     O                                           90 'PREMIUM'
077300991229     O                                          101 'BENEFIT'
077400991229     O                                          113 'PREMIUM'
077500991229     O                                          125 'BENEFIT'
077600991229     O                                          137 'PREMIUM'
077700991229     O                                          148 'BENEFIT'
077800991229     O                                          160 'PREMIUM'
077900991229     O                                          170 'BENEFIT'
078000991229     O                                          182 'PREMIUM'
078100991229     O                                          198 'PREMIUM'
078200991229     O          E            HEAD2          2
078300991229     O                                           24 '""""""""""""""""""""""""'
078400991229     O                                           48 '""""""""""""""""""""""""'
078500991229     O                                           72 '""""""""""""""""""""""""'
078600991229     O                                           96 '""""""""""""""""""""""""'
078700991229     O                                          120 '""""""""""""""""""""""""'
078800991229     O                                          144 '""""""""""""""""""""""""'
078900991229     O                                          168 '""""""""""""""""""""""""'
079000991229     O                                          192 '""""""""""""""""""""""""'
079100991229     O                                          198 '""""""'
079200991229     O          E            HEAD2          1
079300991229     O                                           24 '------------------------'
079400991229     O                                           48 '------------------------'
079500991229     O                                           72 '------------------------'
079600991229     O                                           96 '------------------------'
079700991229     O                                          120 '------------------------'
079800991229     O                                          144 '------------------------'
079900991229     O                                          168 '------------------------'
080000991229     O                                          192 '------------------------'
080100991229     O                                          198 '------'
080200930520     O          E            NOREC       2  2
080300941220     O                                           24 'NO LIFE PLANS SELECTED  '
080400910215**  NOT FOUND MESSAGE
080500910215--- NOT FOUND --------------------------
