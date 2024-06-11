0001009809280009  *  FL030 - THE PLAN MASTER FILE CONTAINS THE DESCRIPTION, RENEWAL
0002009809280010  *          DATE AND OTHER DATA NEEDED FOR THE*COBRA SYSTEM.
000300980928      *
0004009809280003  *                   PLAN MASTER FILE                           *
0005009809280004  *                                                              *
0006009809280005  *  FILE LABEL - PLNMST                ORGANIZATION - INDEXED   *
0007009809280006  *  FILE NAME - x.PLNMST               KEY LENGTH - 10          *
000800980928      *  FILE RECORD LENGTH - 200           KEY START POSITION - 1   *
0009009809280008  *                                                              *
001000980928      *       09/22/98 GSP  The following changes are a result of Y2K update.
001100980928      *                     Changed PLAN fields from numberic to alphanumeric.
001200980928      *                     Chaned PLNMST recl from 192 to 200 bytes.
001300980928      *                     Chaned TRSMST recl from 256 to 264 bytes.
001400980928      *                     Replace Halt indicators H1, H2, H3 and displayed
001500980928      *                     a 'Rec not Found' message on output.
0016000204230008  * 04/22/02 SSK CONVERT TO NATIVE                               *
0016010909250008  * 09/25/09 dlk change renwal date to enrollment date           *
0016021201240008  * 01/24/12 dlk change renwal date to renewal month only        *
001700980928      *---------------------------------------------------------------
001800020418     FFL030D    CF   E             WORKSTN INFDS(WSDS) USROPN
0019000204180015 FPLNMST    IF   E           K DISK    USROPN
0020000409090017 FCARMST    IF   E           K DISK    USROPN PREFIX(Z:1)
0021000204180018 FTRSMST    IF   E           K DISK    USROPN
0022000204180019 FSUBMST    IF   E           K DISK    USROPN
0023000711020021 FQSYSPRT   O    F  198        PRINTER USROPN
002400071102     F                                     OFLIND(*INOF)
002500020418   X***X
002600020422    ***
002700020418     D WSDS            DS
002800020418     D  FKEY                 369    369A
002900020418    ***
003000020422     D NF_TRUST        C                   CONST('TRUST RECORD NOT FOUND')
003100020422     D NF_SUB          C                   CONST('SUB DIV RECORD NOT FOUND')
003200020422     D NF_CARRIER      C                   CONST('CARRIER NAME NOT FOUND')
003300020418     D  F1             C                   CONST(X'31')
003400020418     D  F2             C                   CONST(X'32')
003500020418     D  F3             C                   CONST(X'33')
003600020418     D  F4             C                   CONST(X'34')
003700020418     D  F5             C                   CONST(X'35')
003800020418     D  F6             C                   CONST(X'36')
003900020418     D  F7             C                   CONST(X'37')
004000020418     D  F8             C                   CONST(X'38')
004100020418     D  F9             C                   CONST(X'39')
004200020418     D  F10            C                   CONST(X'3A')
004300020418     D  F11            C                   CONST(X'3B')
004400020418     D  F12            C                   CONST(X'3C')
004500020418     D  F13            C                   CONST(X'B1')
004600020418     D  F14            C                   CONST(X'B2')
004700020418     D  F15            C                   CONST(X'B3')
004800020418     D  F16            C                   CONST(X'B4')
004900020418     D  F17            C                   CONST(X'B5')
005000020418     D  F18            C                   CONST(X'B6')
005100020418     D  F19            C                   CONST(X'B7')
005200020418     D  F20            C                   CONST(X'B8')
005300020418     D  F21            C                   CONST(X'B9')
005400020418     D  F22            C                   CONST(X'BA')
005500020418     D  F23            C                   CONST(X'BB')
005600020418     D  F24            C                   CONST(X'BC')
005700020418    ***
005800020418     D                UDS
005900020418     D  CONAME               201    240
006000020422     D  TIME                 242    247  0
006100020418    ***
006200020418     D @PARMS          S             15A
006300020418     D PRM@XCHG        DS
006400020418     D  P@STEP                 1      1A
006500020418     D  P@TRST                 2      4A
006600020422     D  P@TRSTN                2      4S 0
006700020418     D  P@SUB#                 5      7A
006800020422     D  P@SUB#N                5      7S 0
006900020418     D  P@PLAN                 8     11A
007000020418     D  P@PCAT                12     14A
007100020418     D  P@LIST                15     15A
007200020418    ***
007300040909     D DS@CAT        E DS                  EXTNAME(CARMST) PREFIX(Z:1)
007400020422     D  CARNAME                4     31A
007500020418     D DS@TRS        E DS                  EXTNAME(TRSMST)
007600020418     D DS@SUB        E DS                  EXTNAME(SUBMST)
007700020418     D DS@PLN        E DS                  EXTNAME(PLNMST)
007800020418     D  A@F                   58     97P 0 DIM(20)
007900020418     D  A@T                   98    137P 0 DIM(20)
008000020418     D @STEP           S              5A
008100020418     D KEY@TRS         S                   LIKE(PLTRST)
008200020418     D KEY@SUB         S                   LIKE(PLSUB#)
008300020418     D KEY@PLN         S                   LIKE(PLPLAN)
008400020418     D @EMSG           S                   LIKE(EMSG)
008500020418     D @OPN            S              1A
008600020418     D OSELEC          S            130A
008700020422     D @G              S              1A
008800020423     D #_SUB           S              5S 0
008900020423     D #_TRS           S              5S 0
009000020423     D #_ALL           S              5S 0
009100020422     D CNT             S              5S 0
009200020422     D FIRSTIME        S              1A
009300020422     D VALIDPARMS      S              1A
009400020418   X***X
009500020418     C                   MOVEL     @PARMS        PRM@XCHG
009600020418     C                   OPEN      TRSMST
009700020418     C                   OPEN      SUBMST
009800020422     C                   OPEN      PLNMST
009900020418    ***
010000020418     C                   IF        P@STEP = 'S'
010100020418     C                   EVAL      @STEP = 'STEP2'
010200020418     C                   ELSE
010300020418     C                   EVAL      @STEP = 'STEP0'
010400020418     C                   ENDIF
010500020418    ***
010600020418     C                   DOU       @STEP = 'LEAVE'
010700020418    ***
010800020418     C     @STEP         CASEQ     'STEP0'       $STEP0
010900020418     C     @STEP         CASEQ     'STEP1'       $STEP1
011000020418     C     @STEP         CASEQ     'STEP2'       $STEP2
011100020418     C     @STEP         CASEQ     'STEP3'       $STEP3
011200020418     C     @STEP         CASEQ     'STEP4'       $STEP4
011300020418     C                   ENDCS
011400020418    ***
011500020418     C                   ENDDO
011600020418    ***
011700020418     C                   EXSR      $CLOSEF
011800020418    ***
011900020418     C                   EVAL      *INLR = *ON
012000020418     C                   RETURN
012100020418   S***S
012200020418     C     *INZSR        BEGSR
012300020418    ***
012400020418     C     *ENTRY        PLIST
012500020418     C                   PARM                    @PARMS
012600020418    ***
012700020422     C     KEY#SUB       KLIST
012800020418     C                   KFLD                    KEY@TRS
012900020418     C                   KFLD                    KEY@SUB
013000020418    ***
013100020422     C     KEY#RPT       KLIST
013200020422     C                   KFLD                    KEY@TRS
013300020422     C                   KFLD                    KEY@SUB
013400020422     C                   KFLD                    KEY@PLN
013500020422    ***
013600020418     C                   ENDSR
013700020418   S***S
013800020418     C     $STEP0        BEGSR
013900020418    ***
014000020422     C                   OPEN      FL030D
014100020418     C                   EVAL      S_TRST = 'ALL'
014200020422     C                   EVAL      S_SUB# = 'ALL'
014300020422     C                   EVAL      S_PLAN = 'ALL'
014400020422     C                   EVAL      S_PCAT = 'ALL'
014500020422     C                   EVAL      S_LIST = 'S'
014600020422     C                   EVAL      S_JOBQ = 'Y'
014700020418     C                   EVAL      @STEP = 'STEP1'
014800020418    ***
014900020418     C                   ENDSR
015000020418   S***S
015100020418     C     $STEP1        BEGSR
015200020418    ***
015300020418     C                   MOVEL(P)  @EMSG         EMSG
015400020418     C                   EXFMT     SCREEN
015500020418     C                   CLEAR                   EMSG
015600020418     C                   CLEAR                   @EMSG
015700020418    ***
015800020418     C                   IF        FKEY = F7
015900020418     C                   EVAL      @STEP = 'LEAVE'
016000020517     C                   EVAL      P@STEP = 'X'
016100020517     C                   MOVEL     PRM@XCHG      @PARMS
016200020517     C                   LEAVESR
016300020418     C                   ENDIF
016400020418    ***
016500020422     C                   EXSR      $VALID
016600020422    ***
016700020422     C                   IF        VALIDPARMS = 'Y'
016800020422     C*
016900020422     C                   EVAL      P@TRST = S_TRST
017000020422     C                   EVAL      P@SUB# = S_SUB#
017100020422     C                   EVAL      P@PLAN = S_PLAN
017200020422     C                   EVAL      P@LIST = S_LIST
017300020422     C                   EVAL      P@PCAT = S_PCAT
017400020422     C*
017500020422     C                   IF        S_JOBQ = 'N'
017600020422     C                   EVAL      @STEP = 'STEP2'
017700020422     C*
017800020422     C                   ELSE
017900020422     C                   EVAL      @STEP = 'LEAVE'
018000020422     C                   EVAL      P@STEP = 'S'
018100020422     C                   MOVEL     PRM@XCHG      @PARMS
018200020422     C*
018300020422     C                   ENDIF
018400020422     C                   CLOSE     FL030D
018500020422     C*
018600020422     C                   ENDIF
018700020422    ***
018800020422     C                   ENDSR
018900020422   S***S
019000020422     C     $VALID        BEGSR
019100020422    ***
019200020422     C                   EVAL      VALIDPARMS = 'N'
019300020422    ***
019400020422     C                   IF        S_TRST = '000' OR S_TRST = *BLANKS
019500020422     C                   EVAL      @EMSG = 'TRUST MUST BE SELECTED'
019600020422     C                   LEAVESR
019700020422     C                   ENDIF
019800020422    ***
019900020422     C                   IF        S_SUB# = '000' OR S_SUB# = *BLANKS
020000020422     C                   EVAL      @EMSG = 'SUBDIVISION # MUST BE SELECTED'
020100020422     C                   LEAVESR
020200020422     C                   ENDIF
020300020422    ***
020400020422     C                   IF        S_PLAN = '0000' OR S_PLAN = *BLANKS
020500020422     C                   EVAL      @EMSG = 'PLAN # MUST BE SELECTED'
020600020422     C                   LEAVESR
020700020422     C                   ENDIF
020800020422    ***
020900020422     C                   IF        S_PCAT = *BLANKS
021000020422     C                   EVAL      @EMSG = 'PLAN CATEGORY MUST BE SELECTED'
021100020422     C                   LEAVESR
021200020422     C                   ENDIF
021300020422    ***
021400020422     C                   IF        S_LIST <> 'S' AND S_LIST <> 'F'
021500020422     C                   EVAL      @EMSG = 'LISTING IS EITHER S OR F'
021600020422     C                   LEAVESR
021700020422     C                   ENDIF
021800020422    ***
021900020422     C                   IF        S_JOBQ <> 'N' AND S_JOBQ <> 'Y'
022000020422     C                   EVAL      @EMSG = 'JOBQ IS EITHER Y OR N'
022100020422     C                   LEAVESR
022200020422     C                   ENDIF
022300020422    ***
022400020422    1C                   IF        S_TRST <> 'ALL'
022500020422     C                   MOVE      S_TRST        KEY@TRS
022600020422     C     KEY@TRS       CHAIN     TRSMSR
022700020422    2C                   IF        NOT %FOUND(TRSMST)
022800020422     C                   EVAL      @EMSG = 'TRUST IS INVALID RESELECT'
022900020422     C                   LEAVESR
023000020422    2C                   ENDIF
023100020422     C     KEY@TRS       CHAIN     SUBMSR
023200020422    2C                   IF        NOT %FOUND(SUBMST)
023300020422     C                   EVAL      @EMSG = 'NO SUBDIVISIONS FOR SELECTED TRUST'
023400020422     C                   LEAVESR
023500020422    2C                   ENDIF
023600020422     C     KEY@TRS       CHAIN     PLNMSR
023700020422    2C                   IF        NOT %FOUND(PLNMST)
023800020422     C                   EVAL      @EMSG = 'NO PLANS FOR SELECTED TRUST'
023900020422     C                   LEAVESR
024000020422    2C                   ENDIF
024100020422     C                   ENDIF
024200020422    ***
024300020422    1C                   IF        S_TRST <> 'ALL' AND S_SUB# <> 'ALL'
024400020422     C                   MOVE      S_SUB#        KEY@SUB
024500020422     C     KEY#SUB       CHAIN     SUBMSR
024600020422    2C                   IF        NOT %FOUND(SUBMST)
024700020422     C                   EVAL      @EMSG = 'SUBDIVISION IS INVALID RESELECT'
024800020422     C                   LEAVESR
024900020422    2C                   ENDIF
025000020422     C     KEY#SUB       CHAIN     PLNMSR
025100020422    2C                   IF        NOT %FOUND(PLNMST)
025200020422     C                   EVAL      @EMSG = 'NO PLANS FOR SELECTED TRUST/SUB'
025300020422     C                   LEAVESR
025400020422    2C                   ENDIF
025500020422     C                   ENDIF
025600020422    ***
025700020422    1C                   IF        S_TRST <> 'ALL' AND S_SUB# <> 'ALL' AND
025800020422    1C                             S_PLAN <> 'ALL '
025900020422     C                   MOVE      S_PLAN        KEY@PLN
026000020422     C     KEY#RPT       CHAIN     PLNMSR
026100020422    2C                   IF        NOT %FOUND(PLNMST)
026200020422     C                   EVAL      @EMSG = 'PLAN IS INVALID RESELECT'
026300020422     C                   LEAVESR
026400020422    2C                   ENDIF
026500020422     C                   ENDIF
026600020422    ***
026700020422     C                   EVAL      VALIDPARMS = 'Y'
026800020418    ***
026900020418     C                   ENDSR
027000020418   S***S
027100020418     C     $STEP2        BEGSR
027200020418    ***
027300020422     C                   EVAL      FIRSTIME = 'Y'
027400020418     C                   EVAL      @OPN = 'Y'
027500020418     C                   OPEN      QSYSPRT
027600020422     C                   OPEN      CARMST
027700020418     C                   CLEAR                   DS@TRS
027800020418     C                   CLEAR                   DS@SUB
027900020418     C                   CLEAR                   DS@PLN
028000020418     C                   CLEAR                   DS@CAT
028100020418    ***
028200020418     C                   EVAL      OSELEC = 'CRITERIA - TRS:' + P@TRST         +
028300020418     C                             '; SUB:' + P@SUB# + '; PLN:' + P@PLAN       +
028400020418     C                             '; CAT:' + P@PCAT + '; LIST:' + P@LIST
028500020418    ***
028600020418     C                   EXCEPT    HDGF
028700020418    ***
028800020418     C                   IF        P@TRST = 'ALL' OR P@SUB# = 'ALL' OR
028900020418     C                             P@PLAN = 'ALL '
029000020418     C                   EVAL      @STEP = 'STEP3'
029100020418     C                   LEAVESR
029200020418     C                   ENDIF
029300020418    ***
029400020418     C                   EVAL      @STEP = 'STEP4'
029500020418    ***
029600020418     C                   ENDSR
029700020418   S***S
029800020418     C     $STEP3        BEGSR
029900020418    ***
030000020422     C                   EVAL      KEY@TRS = 001
030100020422     C                   EVAL      KEY@SUB = 000
030200020422     C                   EVAL      KEY@PLN = *BLANKS
030300020422    ***
030400020418     C     KEY#RPT       SETLL     PLNMSR
030500020418    1C                   DOU       %EOF(PLNMST)
030600020418     C                   READ      PLNMSR
030700020418    2C                   IF        NOT %EOF(PLNMST)
030800020418    ***
030900020418     C                   EXSR      $FILTER
031000020418    ***
031100020422     C                   IF        @G = 'Y'
031200020418     C                   EXSR      $DETAIL
031300020422     C                   ENDIF
031400020418    ***
031500020418    2C                   ENDIF
031600020418    1C                   ENDDO
031700020418    ***
031800020418     C                   EVAL      @STEP = 'LEAVE'
031900020422    ***
032000020423     C                   EXSR      $TOTALS
032100020423    ***
032200020423     C                   ENDSR
032300020423   S***S
032400020423     C     $TOTALS       BEGSR
032500020423    ***
032600020423     C                   Z-ADD     #_SUB         CNT
032700020423     C                   IF        *INOF = *ON
032800020423     C                   EXCEPT    HDGF
032900020423     C                   ENDIF
033000020423     C                   EVAL      *IN25 = *ON
033100020423     C                   EVAL      *IN26 = *ON
033200020423     C                   EXCEPT    TOTF
033300020423    ***
033400020423     C                   Z-ADD     #_TRS         CNT
033500020423     C                   IF        *INOF = *ON
033600020423     C                   EXCEPT    HDGF
033700020423    2C                   ENDIF
033800020423     C                   EVAL      *IN25 = *ON
033900020423     C                   EVAL      *IN26 = *OFF
034000020423     C                   EXCEPT    TOTF
034100020423    ***
034200020423     C                   Z-ADD     #_ALL         CNT
034300020423     C                   EVAL      *IN25 = *OFF
034400020423     C                   EVAL      *IN26 = *OFF
034500020423    1C                   IF        *INOF = *ON
034600020423     C                   EXCEPT    HDGF
034700020423    1C                   ENDIF
034800020423     C                   EXCEPT    TOTF
034900020418    ***
035000020418     C                   ENDSR
035100020418   S***S
035200020422     C     $FILTER       BEGSR
035300020422    ***
035400020418     C                   EVAL      @G = 'N'
035500020422    ***
035600020418     C                   EVAL      KEY@TRS = PLTRST
035700020418     C                   EVAL      KEY@SUB = PLSUB#
035800020418     C                   EVAL      KEY@PLN = PLPLAN
035900020418    ***
036000020418     C                   IF        P@PCAT <> 'ALL' AND P@PCAT <> PLNCAT
036100020418     C                   LEAVESR
036200020418     C                   ENDIF
036300020418    ***
036400020422     C                   IF        P@TRST <> 'ALL' AND KEY@TRS <> P@TRSTN
036500020418     C                   LEAVESR
036600020418     C                   ENDIF
036700020418    ***
036800020422     C                   IF        P@SUB# <> 'ALL' AND KEY@SUB <> P@SUB#N
036900020422     C                   LEAVESR
037000020422     C                   ENDIF
037100020422    ***
037200020422     C                   IF        P@PLAN <> 'ALL ' AND KEY@PLN <> P@PLAN
037300020422     C                   LEAVESR
037400020422     C                   ENDIF
037500020422    ***
037600020422     C                   EVAL      @G = 'Y'
037700020418    ***
037800020418     C                   ENDSR
037900020418   S***S
038000020418     C     $DETAIL       BEGSR
038100020422    ***
038200020422     C     PCARR         CHAIN     CARMSR
038300020422     C                   IF        NOT %FOUND(CARMST)
038400020422     C                   CLEAR                   DS@CAT
038500040909     C                   MOVEL     NF_CARRIER    ZNAME
038600020422     C                   ENDIF
038700020418    ***
038800020422    1C                   IF        PLTRST <> TRTRST
038900020423    ***
039000020423     C                   EXSR      $TRSBREAK
039100020423    ***
039200020423    1C                   ENDIF
039300020418    ***
039400020422    1C                   IF        PLSUB# <> SBSUB#
039500020423     C                   EXSR      $SUBBREAK
039600020422    1C                   ENDIF
039700020422    ***
039800020423     C                   ADD       1             #_SUB
039900020423     C                   ADD       1             #_TRS
040000020423     C                   ADD       1             #_ALL
040100020423    ***
040200020418     C                   IF        PLNCAT = *BLANKS
040300020418     C                   MOVE      '***'         PLNCAT
040400020418     C                   ENDIF
040500020418    ***
040600120124     C**                 MULT      10000.0001    PRENEW
040700020422    ***
040800020418    1C                   IF        *INOF = *ON
040900020418     C                   EXCEPT    HDGF
041000020418    1C                   ENDIF
041100020418     C                   EXCEPT    DTLF
041200020422    ***
041300020422     C                   IF        P@LIST = 'F'
041400020422    1C                   IF        *INOF = *ON
041500020422     C                   EXCEPT    HDGF
041600020422    1C                   ENDIF
041700020422     C                   EXCEPT    DTLF2
041800020422     C                   IF        PABFL <> 'N'
041900020422    1C                   IF        *INOF = *ON
042000020422     C                   EXCEPT    HDGF
042100020422    1C                   ENDIF
042200020422     C                   EXCEPT    ABGF
042300020422     C                   ENDIF
042400020422     C                   ENDIF
042500020418    ***
042600020418     C                   ENDSR
042700020418   S***S
042800020423     C     $TRSBREAK     BEGSR
042900020423    ***
043000020423     C                   CLEAR                   DS@SUB
043100020423    ***
043200020423     C     PLTRST        CHAIN     TRSMSR
043300020423    1C                   IF        NOT %FOUND(TRSMST)
043400020423     C                   CLEAR                   DS@TRS
043500020423     C                   MOVEL     NF_TRUST      TNAME
043600020423    1C                   ENDIF
043700020423    ***
043800020423    1C                   IF        FIRSTIME = 'Y'
043900020423     C                   EVAL      FIRSTIME = 'N'
044000020423    1C                   ELSE
044100020423     C*
044200020423     C                   Z-ADD     #_SUB         CNT
044300020423     C                   MOVE      *ZEROS        #_SUB
044400020423     C*
044500020423    2C                   IF        CNT > 0
044600020423     C*
044700020423    3C                   IF        *INOF = *ON
044800020423     C                   EXCEPT    HDGF
044900020423    3C                   ENDIF
045000020423     C*
045100020423     C                   EVAL      *IN25 = *ON
045200020423     C                   EVAL      *IN26 = *ON
045300020423     C                   EXCEPT    TOTF
045400020423     C*
045500020423    2C                   ENDIF
045600020423     C*
045700020423     C                   Z-ADD     #_TRS         CNT
045800020423     C                   MOVE      *ZEROS        #_TRS
045900020423     C*
046000020423    2C                   IF        *INOF = *ON
046100020423     C                   EXCEPT    HDGF
046200020423    2C                   ENDIF
046300020423     C*
046400020423     C                   EVAL      *IN25 = *ON
046500020423     C                   EVAL      *IN26 = *OFF
046600020423     C                   EXCEPT    TOTF
046700020423     C*
046800020423     C                   EXCEPT    HDGF
046900020423    1C                   ENDIF
047000020423    ***
047100020423     C                   EXCEPT    SECF
047200020423    ***
047300020423     C                   ENDSR
047400020423   S***S
047500020423     C     $SUBBREAK     BEGSR
047600020423    ***
047700020423     C     KEY#SUB       CHAIN     SUBMST
047800020423    1C                   IF        NOT %FOUND(SUBMST)
047900020423     C                   CLEAR                   DS@TRS
048000020423     C                   MOVEL     NF_SUB        SUBNAM
048100020423    1C                   ENDIF
048200020423    ***
048300020423     C                   Z-ADD     #_SUB         CNT
048400020423     C                   MOVE      *ZEROS        #_SUB
048500020423     C*
048600020423    1C                   IF        CNT > 0
048700020423     C*
048800020423    2C                   IF        *INOF = *ON
048900020423     C                   EXCEPT    HDGF
049000020423    2C                   ENDIF
049100020423     C*
049200020423     C                   EVAL      *IN25 = *ON
049300020423     C                   EVAL      *IN26 = *ON
049400020423     C                   EXCEPT    TOTF
049500020423     C*
049600020423    1C                   ENDIF
049700020423    ***
049800020423    1C                   IF        *INOF = *ON
049900020423     C                   EXCEPT    HDGF
050000020423    1C                   ENDIF
050100020423     C                   EXCEPT    SECF2
050200020423    ***
050300020423     C                   ENDSR
050400020423   S***S
050500020423     C     $STEP4        BEGSR
050600020423    ***
050700020418     C                   MOVE      P@TRST        KEY@TRS
050800020422     C                   MOVE      P@SUB#        KEY@SUB
050900020422     C                   MOVE      P@PLAN        KEY@PLN
051000020418    ***
051100020422     C     KEY#RPT       SETLL     PLNMSR
051200020422    1C                   DOU       %EOF(PLNMST)
051300020422     C     KEY#RPT       READE     PLNMSR
051400020422    2C                   IF        NOT %EOF(PLNMST)
051500020418    ***
051600020422     C                   EXSR      $FILTER
051700020422    ***
051800020422     C                   IF        @G = 'Y'
051900020422     C                   EXSR      $DETAIL
052000020422     C                   ENDIF
052100020418    ***
052200020418    2C                   ENDIF
052300020418    1C                   ENDDO
052400020418    ***
052500020423     C                   EXSR      $TOTALS
052600020422    ***
052700020418     C                   EVAL      @STEP = 'LEAVE'
052800020418    ***
052900020418     C                   ENDSR
053000020418   S***S
053100020418     C     $CLOSEF       BEGSR
053200020418    ***
053300020418     C                   CLOSE     TRSMST
053400020418     C                   CLOSE     SUBMST
053500020423     C                   CLOSE     PLNMST
053600020418    ***
053700020418     C                   IF        @OPN = 'Y'
053800020418     C                   CLOSE     QSYSPRT
053900020418     C                   ENDIF
054000020418    ***
054100020418     C                   ENDSR
054200020422   X***X
0543000711020151 OQSYSPRT   E            HDGF           1  1
0544009809280162 O                                            5 'FL030'
0545009102150153 O                       CONAME             119
0546000711020151 OQSYSPRT   E            HDGF           1
0547009809280156 O                       UDATE         Y      8
0548009102150157 O                                          113 'PLAN MASTER FILE LISTING'
0549009102150158 O                                          186 'PAGE :'
0550009102150159 O                       PAGE          Z    192
0551000711020151 OQSYSPRT   E            HDGF           1
0552000204220164 O                       TIME                 8 '  :  :  '
0553000711020151 OQSYSPRT   E            HDGF           1
055400020422     O                       OSELEC             130
0555000711020151 OQSYSPRT   E            HDGF           1
0556009102150167 O                                           24 '------------------------'
0557009102150168 O                                           48 '------------------------'
0558009102150169 O                                           72 '------------------------'
0559009102150170 O                                           96 '------------------------'
0560009102150171 O                                          120 '------------------------'
0561009102150172 O                                          144 '------------------------'
0562009102150173 O                                          168 '------------------------'
0563009102150174 O                                          192 '------------------------'
0564009102150175 O                                          198 '------'
0565000711020151 OQSYSPRT   E            HDGF           1
0566009102150178 O                                           90 'PLAN TYPE'
0567009102150179 O                                           99 'INVOICE'
0568009102150180 O                                          107 'AGE '
0569009102150181 O                                          118 'PLAN RATE'
0569011201240195 O                                          126 'RENEW'
0570009102150182 O                                          138 'SALARY'
0571000711020183 O                                          147 'ROUND'
0572000711020184 O                                          162 '-- ROUND --'
0573009102150185 O                                          171 'MAXIMUM'
0574009102150186 O                                          189 'REMITTANCE'
0575000711020151 OQSYSPRT   E            HDGF           1
0576009102150189 O                                            4 'PLAN'
0577009102150190 O                                           55 'CARRIER'
0578001201250191 O                                           90 'CATEGORY'
0579009102150192 O                                           99 'HEADING'
0580009102150193 O                                          108 'BANDED'
0581009102150194 O                                          116 ' TYPE '
0582001201240195 O                                          126 'MONTH'
0583009102150196 O                                          137 'MULT.'
0584000711020197 O                                          147 'FACT.'
0585000711020198 O                                          161 'BEN   PREM'
0586009102150199 O                                          171 'BENEFIT'
0587009102150200 O                                          188 '% / FORM '
0588009102150201 O                                          197 'DLT'
0589000711020151 OQSYSPRT   E            HDGF           1
0590009102150204 O                                           24 '------------------------'
0591009102150205 O                                           48 '------------------------'
0592009102150206 O                                           72 '------------------------'
0593009102150207 O                                           96 '------------------------'
0594009102150208 O                                          120 '------------------------'
0595009102150209 O                                          144 '------------------------'
0596009102150210 O                                          168 '------------------------'
0597009102150211 O                                          192 '------------------------'
0598009102150212 O                                          198 '------'
0599009102150154 OQSYSPRT   E            SECF        1  1
0600009102150215 O                                            6 'TRUST#'
0601000204220216 O                       PLTRST              10
0602009102150217 O                                           12 '-'
0603000204220218 O                       TNAME               33
0604009102150154 OQSYSPRT   E            SECF2       1  2
0605009102150221 O                                            5 'SUB# '
0606000204220222 O                       PLSUB#              10
0607009102150223 O                                           12 '-'
0608000204220224 O                       SUBNAM              33
0609000711020154 OQSYSPRT   E            DTLF           2
0610000204220226 O                       PLPLAN               4
0611009102150227 O                                            6 '-'
0612009102150228 O                       PDESCR              46
0613009102150229 O                       PCARR               50
0614009102150230 O                                           52 '-'
0615000711020240 O                       PRNDPRM            159
0616000204220231 O                       CARNAME             80
0617000204220232 O                       PLNCAT              88
0618009102150234 O                       INVCOL              95
0619009102150235 O                       PABFL              106
0620009102150236 O                       PRTYPE             114
0621001201240237 O                       PRENEW        z    126
0622009102150238 O                       MULT          4    139
0623000711020239 O                       ROUND         4    147
0624000711020240 O                       PRNDFL             153
0625009102150241 O                       MAXBEN        2    171
0626009102150242 O                       REMITP        Z    183
0627009102150243 O                                          185 '/'
0628009102150244 O                       REMITF             187
0629000204220245 O                       PLDLTD             196
0630009409280154 OQSYSPRT   E            DTLF2          1
0631009409280247 O                       CARDID               8
0632009102150248 O                                           10 '-'
0633009102150249 O                       IDDESC              26
0634000409090250 O                       ZNAMEC              94
0635009102150154 OQSYSPRT   E            ABGF           1
0636009102150252 O                                           27 '------'
0637009102150253 O                                           51 '---------------- A G E  '
0638009102150254 O                                           75 ' B A N D I N G   R A N G'
0639009102150255 O                                           99 ' E S -------------------'
0640009102150256 O                                          100 '-'
0641009102150154 OQSYSPRT   E            ABGF           1
0642009102150258 O                                           33 'BAND FROM-TO'
0643009102150259 O                                           49 'BAND FROM-TO'
0644009102150260 O                                           66 'BAND FROM-TO'
0645009102150261 O                                           83 'BAND FROM-TO'
0646009102150262 O                                          100 'BAND FROM-TO'
0647009102150154 OQSYSPRT   E            ABGF           1
0648009102150264 O                                           23 '01'
0649000204220265 O                       PABF01        Z     27
0650000204220266 O                       PABT01        Z     33
0651009102150267 O                                           40 '02'
0652000204220268 O                       PABF02        Z     45
0653000204220269 O                       PABT02        Z     49
0654009102150270 O                                           57 '03'
0655000204220271 O                       PABF03        Z     61
0656000204220272 O                       PABT03        Z     66
0657009102150273 O                                           74 '04'
0658000204220274 O                       PABF04        Z     79
0659000204220275 O                       PABT04        Z     83
0660009102150276 O                                           91 '05'
0661000204220277 O                       PABF05        Z     96
0662000204220278 O                       PABT05        Z    100
0663009102150154 OQSYSPRT   E            ABGF           1
0664009102150281 O                                           23 '06'
0665000204220282 O                       PABF06        Z     27
0666000204220283 O                       PABT06        Z     33
0667009102150284 O                                           40 '07'
0668000204220285 O                       PABF07        Z     45
0669000204220286 O                       PABT07        Z     49
0670009102150287 O                                           57 '08'
0671000204220288 O                       PABF08        Z     61
0672000204220289 O                       PABT08        Z     66
0673009102150290 O                                           74 '09'
0674000204220291 O                       PABF09        Z     79
0675000204220292 O                       PABT09        Z     83
0676009102150293 O                                           91 '10'
0677000204220294 O                       PABF10        Z     96
0678000204220295 O                       PABT10        Z    100
0679009102150154 OQSYSPRT   E            ABGF           1
0680009102150298 O                                           23 '11'
0681000204220299 O                       PABF11        Z     27
0682000204220300 O                       PABT11        Z     33
0683009102150301 O                                           40 '12'
0684000204220302 O                       PABF12        Z     45
0685000204220303 O                       PABT12        Z     49
0686009102150304 O                                           57 '13'
0687000204220305 O                       PABF13        Z     61
0688000204220306 O                       PABT13        Z     66
0689009102150307 O                                           74 '14'
0690000204220308 O                       PABF14        Z     79
0691000204220309 O                       PABT14        Z     83
0692009102150310 O                                           91 '15'
0693000204220311 O                       PABF15        Z     96
0694000204220312 O                       PABT15        Z    100
0695009102150154 OQSYSPRT   E            ABGF           1
0696009102150315 O                                           23 '16'
0697000204220316 O                       PABF16        Z     27
0698000204220317 O                       PABT16        Z     33
0699009102150318 O                                           40 '17'
0700000204220319 O                       PABF17        Z     45
0701000204220320 O                       PABT17        Z     49
0702009102150321 O                                           57 '18'
0703000204220322 O                       PABF18        Z     61
0704000204220323 O                       PABT18        Z     66
0705009102150324 O                                           74 '19'
0706000204220325 O                       PABF19        Z     79
0707000204220326 O                       PABT19        Z     83
0708009102150327 O                                           91 '20'
0709000204220328 O                       PABF20        Z     96
0710000204220329 O                       PABT20        Z    100
0711000204230154 OQSYSPRT   E            TOTF        1  2
0712000204230333 O               25 26                       50 'PLAN COUNT FOR SUB..:'
0713000204230333 O               25N26                       50 'PLAN COUNT FOR TRUST:'
0714000204230333 O              N25N26                       50 'PLAN COUNT FOR RPT..:'
0715009102150334 O                       CNT           ZB    56
