000100040304     H FIXNBR(*ZONED : *INPUTPACKED)
000200991108      ******************************************************************
000300040304      * CR010FID  GROUP BENEFIT SERVICES SOFTWARE                      *
000400991108      *                                                                *
000500991108      *  DESCRIPTION - THIS PROGRAM WILL PRINT MEDICAL FORMAT          *
000600040304      *                TRANSMITTALS for carrier "Fidelity" only        *
000700040304      *                                                                *
000800040304      * 03/04/04 dlk - copy of CR010 to subtract 1 day from all cancel *
000900040304      *                dates because the carrier interprets the        *
001000040304      *                coverage different.                             *
001001051214      * 12/14/05 dlk - change heading due to Kaiser now using this     *
001100051214      *                program.                                        *
001101130913      * 09/13/13 dlk - deal with blank name                            *
001102051214      *                                                                *
001200991108      ******************************************************************
001300991122     FTRANS     IP   F  232        DISK
001400060218     FCARMST    IF   F  278     3AIDISK    KEYLOC(1)
001500991108     FREPORT    O    F  132        PRINTER OFLIND(*INOF)
001600991108      *              NAME ARRAY
001700991108     D N               S              1    DIM(34)                              NAME WORK ARRAY
001800991108      *              HEADING TEXT ARRAYS
001900991108     D TL              S             80    DIM(7) CTDATA PERRCD(1)              TITLE LINE
002000991108     D H1              S             80    DIM(5) CTDATA PERRCD(1)              TITLE LINE
002100991108     D H2              S             80    DIM(3) CTDATA PERRCD(1)              TITLE LINE
002200991108      *                                      44  83 CNAMEC
002300991104     DFRMDY            S              8  0
002400991104     DTOMDY            S              8  0
002500040304     D workdt          S               d   datfmt(*iso)                         last day of month
002600040304     D newcandate      S              8  0
002700040304     D indate          S              8  0
002800040304
002900991108      *   DATA STRUCTURE PLAN MASTER FILE KEY
003000991108     D                 DS
003100991108     D  PLNKEY                 1     10
003200991108     D  TRUST#                 1      3  0
003300991108     D  SUB#                   4      6  0
003400991108     D  PLAN#                  7     10
003500991108      *   LOCAL DATA STRUCTURE RUN DATE FOR TRANSMITTALS
003600991108     D                UDS
003700991108     D  LFDATE                21     28  0                                      COMPNY
003800991108     D  LTDATE                29     36  0                                      COMPNY
003900991229
004000991122     ITRANS     NS  01
004100991108     I                                  2   10 0SSN
004200991108     I                                 18   19  CODECK
004300991108     I                                 17   19  TRCODE
004400991108     I                                 26   55  CK#NOT
004500991108     I                                 56   85  NOTE2
004600991108     I                                 26   29  PLAN#
004700991108     I                                 40   41 0AGEBND
004800991108     I                                 52   53  TYPCOD
004900991108     I                                 68   69  OLDCOD
005000991228     I***                              62   69  OLDED
005100991108     I                                 78   85  ED
005200991108     I                                110  112 0TRUST#
005300991108     I                                113  115 0SUB#
005400991108     I                                110  119 0ACC#
005500991108     I                                163  177  GROUP#        L2
005600991108     I                                185  202  LNAME
005700991108     I                                203  215  FNAME
005800991108     I                                217  217  MI                      50
005900991108     I                                222  228 2PREM
006000991108     I                                229  231  CARKEY
006100991108     I                                232  232  ACTION        L3
006200991108     I                                129  136 0TRDATE
006300040305     I                                153  160 0COVTDT
006400991108      * CARRIER MASTER FILE
006500991108     ICARMST    NS
006600991228     I                                  4   33  CNAME
006700991108      *****************************************************************
006800991108      *   M A I N   L I N E   C A L C U L A T I O N S                 *
006900991108      *****************************************************************
007000991229
007100040305     c                   if        *inl3
007200040305
007300040305     C                   SETOFF                                       212223
007400040305     C                   SETOFF                                       24
007500040305     C                   MOVE      *BLANKS       TITLE
007600040305     C                   MOVEL     ' *ERROR*'    TITLE
007700991108      *
007800991108      * CHECK ACTION CODE FOR A=ADDITIONS, D=DELETIONS, OR C=CHANGE IN COV.TYPE
007900991108      *
008000040305     C                   IF        ACTION = 'A'
008100991108     C                   MOVE      TL(1)         TITLE            80
008200991108     C                   MOVE      H1(1)         VH1              80
008300991108     C                   MOVE      H2(1)         VH2              80
008400991108     C                   SETON                                        21
008500991108     C                   END
008600040305     C                   IF        ACTION = 'D'
008700991108     C                   MOVE      TL(2)         TITLE
008800991108     C                   MOVE      H1(1)         VH1
008900991108     C                   MOVE      H2(1)         VH2
009000991108     C                   SETON                                        21
009100991108     C                   END
009200040305     C                   IF        ACTION = 'C'
009300991108     C                   MOVE      TL(3)         TITLE
009400991108     C                   MOVE      H1(2)         VH1
009500991108     C                   MOVE      H2(2)         VH2
009600991108     C                   SETON                                        22
009700991108     C                   END
009800040305      * enroll date chg
009900040305     C                   IF        ACTION = 'E'
010000991108     C                   MOVE      TL(4)         TITLE
010100991108     C                   MOVE      H1(3)         VH1
010200991108     C                   MOVE      H2(3)         VH2
010300991108     C                   SETON                                        23
010400991108     C                   END
010500040305     C                   IF        ACTION = 'R'
010600991108     C                   MOVE      TL(5)         TITLE            80
010700991108     C                   MOVE      H1(1)         VH1              80
010800991108     C                   MOVE      H2(1)         VH2              80
010900991108     C                   SETON                                        21
011000991108     C                   END
011100040305     C                   IF        ACTION = 'H'
011200991108     C                   MOVE      TL(6)         TITLE
011300991108     C                   MOVE      H1(4)         VH1
011400991108     C                   MOVE      H2(3)         VH2
011500991108     C                   SETON                                        23
011600991108     C                   END
011700040305     C                   IF        ACTION = 'G'
011800991108     C                   MOVE      TL(7)         TITLE
011900991108     C                   MOVE      H1(5)         VH1
012000991108     C                   MOVE      H2(2)         VH2
012100991108     C                   SETON                                        24
012200991108     C                   END
012300040305     C                   IF        ACTION = 'F'
012400991108     C                   MOVE      TL(7)         TITLE
012500991108     C                   MOVE      H1(5)         VH1
012600991108     C                   MOVE      H2(3)         VH2
012700991108     C                   SETON                                        24
012800991108     C                   END
012900040305
013000040305     C                   end
013100991108      *
013200991108      *        GET CARRIER NAME FOR HEADINGS
013300991108      *
013400040305     C   L2CARKEY        CHAIN     CARMST                             30
013500991108      *
013600991108      *        EXIT SUBROUTINE BUILD OUTPUT NAME FIELD
013700991108      *
013800991108     C                   EXSR      #NAMEL
013900991229
014000991108     C                   ADD       PREM          TOTPRM            9 2
014100991108     C                   ADD       1             COUNT             2 0
014200991229
014300980804     C                   MOVE      TRDATE        @DATIN
014400980804     C                   EXSR      #DATYM
014500980804     C                   MOVE      @DATOU        TRDMDY            8 0
014600991229
014700040305      * sub 1 day from effdt when delete coverage or
014800040305      * cov chg (downgrade only)
014900040305     c                   if        action = 'D' or
015000040305     c                             (action = 'C' and prem < 0)
015100040305     c                   move      covtdt        indate
015200040305     c                   exsr      #candtsr
015300040305     c                   move      newcandate    @datin
015400040305     C                   EXSR      #DATYM
015500040305     C                   MOVE      @DATOU        covout            8 0
015600040305      * all others show actual effdt
015700040305     c                   else
015800040305     C                   MOVE      COVTDT        @DATIN
015900040305     C                   EXSR      #DATYM
016000040305     C                   MOVE      @DATOU        COVOUT
016100040305     c                   end
016200040305
016300040305      * show old & new as date - 1 day when change cancel date
016400040305
016500040305     c                   if        *in23
016600040305     c                   clear                   covout
016700040305     c                   if        action = 'H'
016800040305     c                   move      covtdt        indate
016900040305     c                   exsr      #candtsr
017000040305     c                   move      newcandate    @datin
017100040305     C                   EXSR      #DATYM
017200040305     C                   MOVE      @DATOU        OLDMDY            8
017300040305     c                   move      ed            indate
017400040305     c                   exsr      #candtsr
017500040305     c                   move      newcandate    @datin
017600040305     C                   EXSR      #DATYM
017700040305     C                   MOVE      @DATOU        EDMDY             8
017800040305
017900040305      * chg enr date does not sub 1 day
018000040305     c                   else
018100040305     C                   MOVE      COVTDT        @DATIN
018200040305     C                   EXSR      #DATYM
018300040305     C                   MOVE      @DATOU        OLDMDY
018400040305     c                   move      ed            @datin
018500040305     C                   EXSR      #DATYM
018600040305     C                   MOVE      @DATOU        EDMDY
018700040305     c                   end
018800040305     c                   end
018900991229
019000991108     C                   IF        COUNT = 00
019100991108     C                   Z-ADD     1             COUNT
019200991108     C                   END
019300991108      ****************************************************************
019400991229      *  T O T A L    T I M E                                        *
019500991229      ****************************************************************
019600040305     Cl2                 Z-ADD     0             PAGE
019700040305     Cl2                 Z-ADD     0             COUNT
019800991108      ****************************************************************
019900991229      *   FIELD= LAST, FIRST MI.                                     *
020000991108      *------------------- COMPRESS NAME FIELDS ---------------------*
020100991229
020200991108     C     #NAMEL        BEGSR
020300991108      *
020400991108      * INITIALIZE ARRAY AND COUNTER
020500991108      *
020600991108     C                   MOVE      *BLANKS       N
020700991108     C                   Z-ADD     30            N#                2 0
020800991108     C                   MOVEA     LNAME         N(1)
020900991108      *
021000991108      *  FIND FIRST BLANK SPACE
021100991108      *
021201130913     C                   DOU       (N(N#) <> ' ') or (n# < 1)
021300991108     C                   SUB       1             N#
021400991108     C                   END
021500991108      *
021600991108      * MOVE IN , AND FNAME
021700991108      *
021800991108     C                   ADD       1             N#
021900991108     C                   MOVEA     ','           N(N#)
022000991108     C                   ADD       2             N#
022100991108     C                   MOVEA     FNAME         N(N#)
022200991108      *
022300991108      * FIND END OF FNAME AND MOVE IN MI
022400991108      *
022500991108     C                   DOU       N(N#) = ' '
022600991108     C                   ADD       1             N#
022700991108     C                   END
022800991229
022900991108     C  N50              IF        N# <= 27
023000991108     C                   ADD       1             N#
023100991108     C                   MOVEA     MI            N(N#)
023200991108     C                   ADD       1             N#
023300991108     C                   MOVEA     '.'           N(N#)
023400991108     C                   END
023500991229
023600991108     C                   ENDSR
023700991229
023800991108      ***************************************************
023900991108      * CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
024000991108      ***************************************************
024100991229
024200991108      * DATE IN  = @DATIN (8.0) YYYYMMDD
024300991108      * DATE OUT = @DATOU (8.0) MMDDYYYY
024400991229
024500991108     C     #DATYM        BEGSR
024600980804     C                   MOVE      @DATIN        @MD               4 0
024700980804     C                   MOVEL     @DATIN        @Y                4 0
024800980804     C                   MOVEL     @MD           @DATOU            8 0
024900980804     C                   MOVE      @Y            @DATOU
025000980804     C                   MOVE      *ZEROS        @DATIN            8 0
025100991108     C                   ENDSR
025200991108      * THIS INITIALIZATION SUBROUTINE IS EXECUTED ONLY ONCE -DLW
025300991104     C     *INZSR        BEGSR
025400991104     C                   MOVE      LFDATE        @DATIN
025500991104     C                   EXSR      #DATYM
025600991104     C                   MOVE      @DATOU        FRMDY
025700991104     C                   MOVE      LTDATE        @DATIN
025800991104     C                   EXSR      #DATYM
025900991104     C                   MOVE      @DATOU        TOMDY
026000991104     C                   ENDSR
026100040304
026200040304     C     #candtsr      BEGSR
026300040304     c                   move      indate        workdt
026400040304     c                   subdur    1:*d          workdt
026500040304     c                   move      workdt        newcandate
026600040304
026700040304     C                   ENDSR
026800040304
026900991108      *************************************************************
027000040305     OREPORT    H    l2                     2 01
027100991108     O         OR    OF
027200040304     O                                            8 'CR010FID'
027300051214     O                                           47 '** SPECIAL HANDLING OF CA'
027301051214     O                                           +0 'NCELLATIONS **'
027400040305     O                       UDATE         Y    102
027500040305     O          H    l2                     1
027600991108     O         OR    OF
027700991108     O                       TITLE               80
027800040305     O          H    l2                     1
027900991108     O         OR    OF
028000991108     O                       FRMDY               38 '  /  /    '
028100991108     O                                           40 '-'
028200991108     O                       TOMDY               51 '  /  /    '
028300040305     O          H    l2                     2
028400991108     O         OR    OF
028500991108     O                                           49 'C/O GROUP BENEFIT SERVIC'
028600991108     O                                           51 'ES'
028700040305     O          H    l2                     1
028800991108     O         OR    OF
028900991108     O                                           24 '|"""""""""""""""""""""""'
029000991108     O                                           48 '""""""""""""""""""""""""'
029100991108     O                                           72 '""""""""""""""""""""""""'
029200040305     O                                           96 '""""""""""""""""""""""""'
029300040305     O                                          102 '"""""|'
029400040305     O          H    l2                     1
029500991108     O         OR    OF
029600991108     O                                            1 '|'
029700991108     O                                           12 'Group Name:'
029800991108     O                                           32 '|'
029900991108     O                                           46 'Group Number:'
030000991108     O                                           50 '|'
030100991108     O                                           75 'DO NOT USE THIS SPACE'
030200040305     O                                          102 '|'
030300040305     O          H    l2                     1
030400991108     O         OR    OF
030500991108     O                                            1 '|'
030600991108     O                                           32 '|'
030700991108     O                                           50 '|'
030800040305     O                                          102 '|'
030900040305     O          H    l2                     1
031000991108     O         OR    OF
031100991108     O                                            1 '|'
031200991108     O              N30      CNAME               31
031300991108     O               30                          19 'Group Name Unknown'
031400991108     O                                           32 '|'
031500991108     O                       GROUP#              49
031600991108     O                                           50 '|'
031700991108     O                                           75 'Coverage Code___________'
031800991108     O                                           91 '________________'
031900040305     O                                          102 '|'
032000040305     O          H    l2                     1
032100991108     O         OR    OF
032200991108     O                                           24 '|"""""""""""""""""""""""'
032300991108     O                                           48 '""""""""""""""""""""""""'
032400991108     O                                           50 '"|'
032500040305     O                                          102 '|'
032600040305     O          H    l2                     1
032700991108     O         OR    OF
032800991108     O                                            1 '|'
032900991108     O                                           16 'Street Address:'
033000991108     O                                           32 '|'
033100040305     O**                                         48 'Effective Date:'
033200991108     O                                           50 '|'
033300991108     O                                           75 'Date Trans. Completed___'
033400991108     O                                           91 '________________'
033500040305     O                                          102 '|'
033600040305     O          H    l2                     1
033700991108     O         OR    OF
033800991108     O                                            1 '|'
033900991108     O                                           32 '|'
034000991108     O                                           50 '|'
034100040305     O                                          102 '|'
034200040305     O          H    l2                     1
034300991108     O         OR    OF
034400991108     O                                            1 '|'
034500991108     O                                           25 '  6 NORTH PARK DR, #310 '
034600991108     O                                           32 '|'
034700040305     O**                     COVOUT              47 '  /  /    '
034800991108     O                                           50 '|'
034900991108     O                                           75 'Date Coding Returned____'
035000991108     O                                           91 '________________'
035100040305     O                                          102 '|'
035200040305     O          H    l2                     1
035300991108     O         OR    OF
035400991108     O                                           24 '|"""""""""""""""""""""""'
035500991108     O                                           48 '""""""""""""""""""""""""'
035600991108     O                                           50 '"|'
035700040305     O                                          102 '|'
035800040305     O          H    l2                     1
035900991108     O         OR    OF
036000991108     O                                            1 '|'
036100991108     O                                           16 'City/State/Zip:'
036200991108     O                                           32 '|'
036300991108     O                                           38 'Page:'
036400991108     O                                           50 '|'
036500040305     O                                          102 '|'
036600040305     O          H    l2                     1
036700991108     O         OR    OF
036800991108     O                                            1 '|'
036900991108     O                                           32 '|'
037000991108     O                                           50 '|'
037100040305     O                                          102 '|'
037200040305     O          H    l2                     1
037300991108     O         OR    OF
037400991108     O                                            1 '|'
037500991108     O                                           27 'HUNT VALLEY, MARYLAND 21'
037600991108     O                                           30 '030'
037700991108     O                                           32 '|'
037800991108     O                                           50 '|'
037900991108     O                       PAGE          Z     41
038000991108     O                                           50 '|'
038100991108     O                                           75 'By______________________'
038200991108     O                                           91 '________________'
038300040305     O                                          102 '|'
038400040305     O          H    l2                     1
038500991108     O         OR    OF
038600991108     O                                           24 '|"""""""""""""""""""""""'
038700991108     O                                           48 '""""""""""""""""""""""""'
038800991108     O                                           72 '""""""""""""""""""""""""'
038900040305     O                                           96 '""""""""""""""""""""""""'
039000040305     O                                          102 '"""""|'
039100040305     O          H    l2                     1
039200991108     O         OR    OF
039300991108     O                                            1 '|'
039400040305     O                                          102 '|'
039500040305     O          H    l2                     1
039600991108     O         OR    OF
039700991108     O                                            1 '|'
039800991108     O                                           36 '* IMPORTANT: An Applicat'
039900991108     O                                           60 'ion Card Must Be Submitt'
040000991108     O                                           68 'ed For *'
040100040305     O                                          102 '|'
040200040305     O          H    l2                     1
040300991108     O         OR    OF
040400991108     O                                            1 '|'
040500991108     O                                           49 'Each Member Listed Below'
040600040305     O                                          102 '|'
040700040305     O          H    l2                     1
040800991108     O         OR    OF
040900991108     O                                            1 '|'
041000040305     O                                          102 '|'
041100040305     O          H    l2                     1
041200991108     O         OR    OF
041300991108     O                                           24 '|"""""""""""""""""""""""'
041400991108     O                                           48 '""""""""""""""""""""""""'
041500991108     O                                           72 '""""""""""""""""""""""""'
041600040305     O                                           96 '""""""""""""""""""""""""'
041700040305     O                                          102 '"""""|'
041800040305     O          H    l2                     1
041900991108     O         OR    OF
042000991108     O                       VH1                 80
042100931019     O                                           91 '  Trans.  |'
042200040305     O                                          102 ' Effective|'
042300040305     O          H    l2                     1
042400991108     O         OR    OF
042500991108     O                       VH2                 80
042600931019     O                                           91 '  Date    |'
042700040305     O                                          102 '  Date    |'
042800040305     O          H    l2                     1
042900991108     O         OR    OF
043000991108     O                                           24 '|"""""""""""""""""""""""'
043100991108     O                                           48 '""""""""""""""""""""""""'
043200991108     O                                           72 '""""""""""""""""""""""""'
043300040305     O                                           96 '""""""""""""""""""""""""'
043400040305     O                                          102 '"""""|'
043500991229
043600991108     O          D    01NLR                  1
043700991108     O                                            1 '|'
043800991108     O                       COUNT         Z      3
043900991108     O                                            4 '.'
044000991108     O                       SSN                 16 '   -  -    '
044100991108     O                                           17 '|'
044200991108     O                       ACC#                27
044300991108     O                                           28 '|'
044400991108     O                       N                   63
044500991108     O                                           63 '    '
044600991108     O               21                          60 '|'
044700991108     O               21      TYPCOD              64
044800991108     O               21                          67 '|'
044900991108     O               21      PREM          MB    78
045000991229
045100991108     O               22                          53 '|'
045200991108     O               22      TYPCOD              57
045300991108     O               22                          60 '|'
045400991108     O               22      OLDCOD              64
045500991108     O               22                          67 '|'
045600991108     O               22      PREM          MB    78
045700010112
045800991108     O               23                          49 ' '
045900991108     O               23      EDMDY               57
046000991108     O               23                          58 '-'
046100991108     O               23      OLDMDY              66
046200991108     O               23      PREM          MB    78
046300010112
046400991108     O               24                          53 '|'
046500991108     O               24      AGEBND              57
046600991108     O               24                          60 '|'
046700991108     O               24      OLDCOD              64
046800991108     O               24                          67 '|'
046900991108     O               24      PREM          MB    78
047000991108     O                                           80 '|'
047100980805     O                       TRDMDY         B    90 '  /  /    '
047200931019     O                                           91 '|'
047300040305     O                       covout         B   101 '  /  /    '
047400040305     O                                          102 '|'
047500991229
047600991108     O          D    01NLR                  1
047700991108     O                                           24 '|-----------------------'
047800991108     O                                           48 '------------------------'
047900991108     O                                           72 '------------------------'
048000040305     O                                           96 '------------------------'
048100040305     O                                          102 '-----|'
048200991229
048300040305     O          T    l2                  1
048400991108     O                                           62 'TOTAL NET PREMIUM------>'
048500991108     O                       TOTPRM        KB    79 '$'
048600910215** TITLE LINES                         X
048700910215               M E M B E R   C O V E R A G E   A D D I T I O N S
048800910215               M E M B E R   C O V E R A G E   D E L E T I O N S
048900910215            M E M B E R   C O V E R A G E   T Y P E   C H A N G E S
049000910215          M E M B E R   E N R O L L M E N T   D A T E   C H A N G E S
049100910529          M E M B E R   C O V E R A G E   R E I N S T A T E M E N T S
049200910927     M E M B E R   C O V E R A G E   C A N C E L   D A T E   C H A N G E S
049300920921     M E M B E R   C O V E R A G E   A G E   B A N D   C H A N G E S
049400910215** VARIBLE HEADING LINE 1
049500910215|Social Security| * G.B.S. |                               | Cov. |    Premium |
049600910215|Social Security| * G.B.S. |                        |   Coverage  |    Premium |
049700910215|Social Security| * G.B.S. |                        | Enroll Date |    Premium |
049800910927|Social Security| * G.B.S. |                        | Cancel Date |    Premium |
049900920921|Social Security| * G.B.S. |                        |   Age Band  |    Premium |
050000910215** VARIBLE HEADING LINE 2
050100931019|     Number    | Account #|    Employee Name              | Type |     Amount |
050200910215|     Number    | Account #|    Employee Name       | Pres.|  Old |     Differ.|
050300910215|     Number    | Account #|    Employee Name       | Pres.|  Old |     Amount |
