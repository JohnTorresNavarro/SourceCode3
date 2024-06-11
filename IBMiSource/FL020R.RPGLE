000100990316      ****************************************************************
000200980928      *                  SUBDIVISION MASTER FILE                     *
000300980928      *                                                              *
000400980928      *  FILE LABEL - SUBMST                ORGANIZATION - INDEXED   *
000500980928      *  FILE NAME -  .SUBMST               KEY LENGTH - 6           *
000600980928      *  FILE RECORD LENGTH - 370           KEY START POSITION - 1   *
000700980928      *                                                              *
000800980928      *  DESCRIPTION - THE SUBDIVISION FILE CONTAINS NAME,           *
000900980928      *       DESCRIPTION AND OTHER DATA FOR EACH AREA BREAKDOWN.    *
001000980928      *       SUBDIVISION IS THE SECOND LEVEL OF THE HEIRARCHY AND   *
001100980928      *       IS USED BREAK DOWN A RATE TRUST BY GEOGRAPHICAL,       *
001200980928      *       BUSINESS OR OTHER LOGICAL DIFFERENCES.                 *
001300980928      *       09/28/98 GSP  The following changes are a result of Y2K update.
001400980928      *                     Chaned TRSMST recl from 256 to 264 bytes.
001500020418      * SSK 04/18/02 CONVERT TO NATIVE
001600980928      ****************************************************************
001700020418     FFL020D    CF   E             WORKSTN INFDS(WSDS) USROPN
001800020418     FSUBMST    IF   E           K DISK    USROPN
001900020418     FTRSMST    IF   E           K DISK    USROPN
002000020418     FQSYSPRT   O    F  132        PRINTER USROPN
002100020418     F                                     OFLIND(*INOF)
002200020418   X***X
002300020418     D WSDS            DS
002400020418     D  FKEY                 369    369A
002500020418    ***
002600020418     D  F1             C                   CONST(X'31')
002700020418     D  F2             C                   CONST(X'32')
002800020418     D  F3             C                   CONST(X'33')
002900020418     D  F4             C                   CONST(X'34')
003000020418     D  F5             C                   CONST(X'35')
003100020418     D  F6             C                   CONST(X'36')
003200020418     D  F7             C                   CONST(X'37')
003300020418     D  F8             C                   CONST(X'38')
003400020418     D  F9             C                   CONST(X'39')
003500020418     D  F10            C                   CONST(X'3A')
003600020418     D  F11            C                   CONST(X'3B')
003700020418     D  F12            C                   CONST(X'3C')
003800020418     D  F13            C                   CONST(X'B1')
003900020418     D  F14            C                   CONST(X'B2')
004000020418     D  F15            C                   CONST(X'B3')
004100020418     D  F16            C                   CONST(X'B4')
004200020418     D  F17            C                   CONST(X'B5')
004300020418     D  F18            C                   CONST(X'B6')
004400020418     D  F19            C                   CONST(X'B7')
004500020418     D  F20            C                   CONST(X'B8')
004600020418     D  F21            C                   CONST(X'B9')
004700020418     D  F22            C                   CONST(X'BA')
004800020418     D  F23            C                   CONST(X'BB')
004900020418     D  F24            C                   CONST(X'BC')
005000020418    ***
005100910215     D                UDS
005200910215     D  CONAME               201    240
005300910215     D  TIME                 242    247  0
005400020418    ***
005500020418     D @PARMS          S              4A
005600020418     D PRM@XCHG        DS
005700020418     D  P@STEP                 1      1A
005800020418     D  P@TRST                 2      4A
005900020418    ***
006000020418     D DS@TRS        E DS                  EXTNAME(TRSMST)
006100020418     D @STEP           S              5A
006200020418     D KEY@TRS         S                   LIKE(SBTRST)
006300020418     D @EMSG           S                   LIKE(EMSG)
006400020418     D @OPN            S              1A
006500020418     D OSELEC          S            130A
006600020418   X***X
006700020418     C                   MOVEL     @PARMS        PRM@XCHG
006800020418     C                   OPEN      TRSMST
006900020418     C                   OPEN      SUBMST
007000020418    ***
007100020418     C                   IF        P@STEP = 'S'
007200020418     C                   EVAL      @STEP = 'STEP2'
007300020418     C                   ELSE
007400020418     C                   EVAL      @STEP = 'STEP0'
007500020418     C                   ENDIF
007600020418    ***
007700020418     C                   DOU       @STEP = 'LEAVE'
007800020418    ***
007900020418     C     @STEP         CASEQ     'STEP0'       $STEP0
008000020418     C     @STEP         CASEQ     'STEP1'       $STEP1
008100020418     C     @STEP         CASEQ     'STEP2'       $STEP2
008200020418     C     @STEP         CASEQ     'STEP3'       $STEP3
008300020418     C     @STEP         CASEQ     'STEP4'       $STEP4
008400020418     C                   ENDCS
008500020418    ***
008600020418     C                   ENDDO
008700020418    ***
008800020418     C                   EXSR      $CLOSEF
008900020418    ***
009000020418     C                   EVAL      *INLR = *ON
009100020418     C                   RETURN
009200020418   S***S
009300020418     C     *INZSR        BEGSR
009400020418    ***
009500020418     C     *ENTRY        PLIST
009600020418     C                   PARM                    @PARMS
009700020418    ***
009800020418     C     KEY#RPT       KLIST
009900020418     C                   KFLD                    KEY@TRS
010000020418    ***
010100020418     C                   ENDSR
010200020418   S***S
010300020418     C     $STEP0        BEGSR
010400020418    ***
010500020418     C                   OPEN      FL020D
010600020418     C                   EVAL      S_TRST = 'ALL'
010700020418     C                   EVAL      S_JOBQ = 'Y'
010800020418     C                   EVAL      @STEP = 'STEP1'
010900020418    ***
011000020418     C                   ENDSR
011100020418   S***S
011200020418     C     $STEP1        BEGSR
011300020418    ***
011400020418     C                   MOVEL(P)  @EMSG         EMSG
011500020418     C                   EXFMT     SCREEN
011600020418     C                   CLEAR                   EMSG
011700020418     C                   CLEAR                   @EMSG
011800020418    ***
011900020418     C                   IF        FKEY = F7
012000020517     C                   EVAL      P@STEP = 'X'
012100020517     C                   MOVEL     PRM@XCHG      @PARMS
012200020418     C                   EVAL      @STEP = 'LEAVE'
012300020517     C                   LEAVESR
012400020418     C                   ENDIF
012500020418    ***
012600020418     C                   IF        S_TRST = '000' OR S_TRST = *BLANKS
012700020418     C                   EVAL      @EMSG = 'TRUST MUST BE SELECTED'
012800020418     C                   LEAVESR
012900020418     C                   ENDIF
013000020418    ***
013100020418    1C                   IF        S_TRST <> 'ALL'
013200020418     C                   MOVE      S_TRST        KEY@TRS
013300020418     C     KEY@TRS       CHAIN     TRSMSR
013400020418    2C                   IF        NOT %FOUND(TRSMST)
013500020418     C                   EVAL      @EMSG = 'TRUST IS INVALID RESELECT'
013600020418     C                   LEAVESR
013700020418    2C                   ENDIF
013800020418     C     KEY@TRS       CHAIN     SUBMSR
013900020418    2C                   IF        NOT %FOUND(SUBMST)
014000020418     C                   EVAL      @EMSG = 'NO SUBDVSNS FOR SELECTED TRUST'
014100020418     C                   LEAVESR
014200020418    2C                   ENDIF
014300020418    1C                   ENDIF
014400020418    ***
014500020418     C                   IF        S_JOBQ <> 'N' AND S_JOBQ <> 'Y'
014600020418     C                   EVAL      @EMSG = 'JOBQ IS EITHER Y OR N'
014700020418     C                   LEAVESR
014800020418     C                   ENDIF
014900020418    ***
015000020418     C                   EVAL      P@TRST = S_TRST
015100020418     C                   CLOSE     FL020D
015200020418    ***
015300020418     C                   IF        S_JOBQ = 'N'
015400020418     C                   EVAL      @STEP = 'STEP2'
015500020418     C                   ELSE
015600020418     C                   EVAL      @STEP = 'LEAVE'
015700020418     C                   EVAL      P@STEP = 'S'
015800020418     C                   MOVEL     PRM@XCHG      @PARMS
015900020418     C                   ENDIF
016000020418    ***
016100020418     C                   ENDSR
016200020418   S***S
016300020418     C     $STEP2        BEGSR
016400020418    ***
016500020418     C                   EVAL      @OPN = 'Y'
016600020418     C                   OPEN      QSYSPRT
016700020418     C                   CLEAR                   DS@TRS
016800020418    ***
016900020418     C                   EVAL      OSELEC = 'TRUST SELECTED:' + P@TRST
017000020418    ***
017100020418     C                   EXCEPT    HDGF
017200020418    ***
017300020418     C                   IF        P@TRST = 'ALL'
017400020418     C                   EVAL      @STEP = 'STEP3'
017500020418     C                   LEAVESR
017600020418     C                   ENDIF
017700020418    ***
017800020418     C                   EVAL      @STEP = 'STEP4'
017900020418    ***
018000020418     C                   ENDSR
018100020418   S***S
018200020418     C     $STEP3        BEGSR
018300020418    ***
018400020418     C                   EVAL      KEY@TRS = 000
018500020418    ***
018600020418     C     KEY#RPT       SETLL     SUBMSR
018700020418    1C                   DOU       %EOF(SUBMST)
018800020418     C                   READ      SUBMSR
018900020418    2C                   IF        NOT %EOF(SUBMST)
019000020418    ***
019100020418     C                   EXSR      $DETAIL
019200020418    ***
019300020418    2C                   ENDIF
019400020418    1C                   ENDDO
019500020418    ***
019600020418     C                   EVAL      @STEP = 'LEAVE'
019700020418    ***
019800020418     C                   ENDSR
019900020418   S***S
020000020418     C     $DETAIL       BEGSR
020100020418    ***
020200020418    1C                   IF        SBTRST <> TRTRST
020300020418     C     SBTRST        CHAIN     TRSMSR
020400020418     C                   IF        NOT %FOUND(TRSMST)
020500020418     C                   CLEAR                   DS@TRS
020600020418     C                   ENDIF
020700020418    2C                   IF        *INOF = *ON
020800020418     C                   EXCEPT    HDGF
020900020418    2C                   ENDIF
021000020418     C                   EXCEPT    SECF
021100020418    1C                   ENDIF
021200020418    ***
021300020418    1C                   IF        SBDLTD = 'A' OR SBDLTD = 'D'
021400020418     C                   EVAL      *IN25 = *ON
021500020418    1C                   ELSE
021600020418     C                   EVAL      *IN25 = *OFF
021700020418    1C                   ENDIF
021800020418    ***
021900020418    1C                   IF        *INOF = *ON
022000020418     C                   EXCEPT    HDGF
022100020418    1C                   ENDIF
022200020418     C                   EXCEPT    DTLF
022300020418    ***
022400020418    1C                   IF        IDVARY <> *BLANKS
022500020418    2C                   IF        *INOF = *ON
022600020418     C                   EXCEPT    HDGF
022700020418    2C                   ENDIF
022800020418     C                   EXCEPT    VLNF
022900020418    1C                   ENDIF
023000020418    ***
023100020418     C                   ENDSR
023200020418   S***S
023300020418     C     $STEP4        BEGSR
023400020418    ***
023500020418     C                   MOVE      P@TRST        KEY@TRS
023600020418    ***
023700020418     C     KEY#RPT       SETLL     SUBMSR
023800020418    1C                   DOU       %EOF(SUBMST)
023900020418     C     KEY#RPT       READE     SUBMSR
024000020418    2C                   IF        NOT %EOF(SUBMST)
024100020418    ***
024200020418     C                   EXSR      $DETAIL
024300020418    ***
024400020418    2C                   ENDIF
024500020418    1C                   ENDDO
024600020418    ***
024700020418     C                   EVAL      @STEP = 'LEAVE'
024800020418    ***
024900020418     C                   ENDSR
025000020418   S***S
025100020418     C     $CLOSEF       BEGSR
025200020418    ***
025300020418     C                   CLOSE     TRSMST
025400020418     C                   CLOSE     SUBMST
025500020418    ***
025600020418     C                   IF        @OPN = 'Y'
025700020418     C                   CLOSE     QSYSPRT
025800020418     C                   ENDIF
025900020418    ***
026000020418     C                   ENDSR
026100020418   S***S
026200020418   X***X
026300980928     OQSYSPRT   E            HDGF           1  1
026400980928     O                                            5 'FL020'
026500020418     O                                           46 '**'
026600020418     O                       CONAME              86
026700020418     O                                           88 '**'
026800020418     O                       UDATE         Y    116
026900020418     O                                          126 'PAGE :'
027000020418     O                       PAGE          Z    132
027100980928     OQSYSPRT   E            HDGF           1
027200020418     O                                           77 'SUBDIVISION MASTER FILE LI'
027300020418     O                                           82 'STING'
027400020418     O                       TIME               116 '  :  :  '
027500980928     OQSYSPRT   E            HDGF           1
027600020418     O                       OSELEC             130                             000130
027700980928     OQSYSPRT   E            HDGF           1
027800020418     O                                           24 '------------------------'
027900020418     O                                           48 '------------------------'
028000020418     O                                           72 '------------------------'
028100020418     O                                           96 '------------------------'
028200020418     O                                          120 '------------------------'
028300020418     O                                          132 '------------'
028400980928     OQSYSPRT   E            HDGF           1
028500020418     O                                           18 'NUMBER'
028600020418     O                                           27 'NAME'
028700020418     O                                           65 'DESCRIPTION'
028800020418     O                                           93 'DUE'
028900020418     O                                          103 'ADMIN.'
029000020418     O                                          114 'INV. PRINT'
029100020418     O                                          120 'STATS'
029200020418     O                                          128 'COM FEE'
029300020418     O                                          132 'GRC'
029400980928     OQSYSPRT   E            HDGF           1
029500020418     O                                           93 'DAY'
029600020418     O                                          101 'FEE'
029700020418     O                                          111 'COL.'
029800020418     O                                          132 'PRD'
029900980928     OQSYSPRT   E            HDGF           1
030000020418     O                                           24 '------------------------'
030100020418     O                                           48 '------------------------'
030200020418     O                                           72 '------------------------'
030300020418     O                                           96 '------------------------'
030400020418     O                                          120 '------------------------'
030500020418     O                                          132 '------------'
030600910215     OQSYSPRT   E            SECF        3  1
030700910215     O                                            6 'TRUST#'
030800020418     O                       TRTRST              10
030900910215     O                                           12 '-'
031000910215     O                       TNAME               33
031100020418     OQSYSPRT   E            DTLF           1
031200020418     O                       SBSUB#        X     16
031300020418     O                       SUBNAM              38
031400910215     O                       SUBDSC              90
031500920409     O                       DUEDAY              93
031600020418     O                       SADMFE        1    103
031700910215     O                       AFICOL             109
031800020418     O              N25                         118 'INVALID'
031900020418     O               25      SBDLTD             118
032000910215     O                       COMFEE        1    128
032100910215     O                       GRCPRD        1    132
032200020418     OQSYSPRT   E            DTLF        1  1
032300910215     O                                           68 '------  I N V O I C E   '
032400910215     O                                           92 'H E A D I N G S  -------'
032500020418     OQSYSPRT   E            DTLF           1
032600940520     O                       IH1T                42
032700940520     O                       IH2T                52
032800940520     O                       IH3T                62
032900940520     O                       IH4T                72
033000940520     O                       IH5T                82
033100940520     O                       IH6T                92
033200940520     O                       IH7T               102
033300940520     O                       IH8T               112
033400940520     O                       IH9T               122
033500020418     OQSYSPRT   E            DTLF           2
033600940520     O                       IH1B                42
033700940520     O                       IH2B                52
033800940520     O                       IH3B                62
033900940520     O                       IH4B                72
034000940520     O                       IH5B                82
034100940520     O                       IH6B                92
034200940520     O                       IH7B               102
034300940520     O                       IH8B               112
034400940520     O                       IH9B               122
034500020418     OQSYSPRT   E            VLNF           1
034600020418     O                                           64 'ID CARD VARIABLE LINE :'
034700911206     O                       IDVARY         B   110
