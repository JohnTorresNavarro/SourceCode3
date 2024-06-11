000100020517      *****************************************************************
000200020517      * FL060 - THE ACCOUNT MASTER FILE CONTAINS NAME, ADDRESS TOTAL  *
000300020517      *         EMPLOYEES AND OTHER DATA FOR EACH ACCOUNT. THE ACCOUNT*
000400020517      *         IS THE THIRD LEVEL OF THE HEIRARCHY AND IS BREAKDOWN  *
000500020517      *         TO THE CLIENT COMPANY LEVEL                           *
000600020517      *                                                               *
000700020517      *                  ACCOUNT MASTER FILE                          *
000800020517      *  FILE LABEL - ACCMST                ORGANIZATION - INDEXED    *
000900020517      *  FILE NAME - C.ACCMST               KEY LENGTH - 10           *
001000020517      *  FILE RECORD LENGTH - 560           KEY START POSITION - 1    *
001100020517      *                                                               *
001200020517      * MODIFICATION HISTORY                                          *
001300020517      * 09/22/98 GSP  The following changes are a result of Y2K       *
001400020517      *               update Chaned ACCMST recl from 512 to 560 bytes.*
001500020517      *                                                               *
001600020517      * 05/17/2002 SSK CHANGE TO NATIVE CODE                          *
001700020517      *                ADD EDITS TO REPLACE BLIND SUBMISSION          *
001800020517      *                                                               *
001900020517      *****************************************************************
002000020517     FFL060D    CF   E             WORKSTN INFDS(WSDS) USROPN
0021000205170018 FTRSMST    IF   E           K DISK    USROPN
0022000205170019 FSUBMST    IF   E           K DISK    USROPN
002300020517     FACCMST    IF   E           K DISK    USROPN RENAME(ACCMSR:ACCSEQF)
002400020517     FACCNAM    IF   E           K DISK    USROPN RENAME(ACCMSR:NAMSEQF)
002500020517     FQSYSPRT   O    F  132        PRINTER OFLIND(*INOF) USROPN
002600020517   X***X
002700020517     D @CODESC         S              8A
002800020517     D @CSZ            S             40A
002900020517     D @4              S              4A
003000020517     D @5              S              5A
003100020517     D @9              S              9A
003200020517     D @GR             S              1A
003300020517     D @STEP           S              5A
003400020517    ***
003500020517     D COBDES          S              7A
003600020517     D ACCCNT          S              4S 0
003700020517     D EMPCNT          S              8S 0
003800020517     D VALIDPARMS      S              1A
003900020517    ***
004000910215     D                UDS                                                       COMPNY
004100910215     D  CONAME               201    240                                         COMPNY
004200020517     D* TIME                 242    247  0                                      COMPNY
004300020517    ***
004400020517     D WSDS            DS
004500020517     D  FKEY                 369    369A
004600020517    ***
004700020517     D  F1             C                   CONST(X'31')
004800020517     D  F2             C                   CONST(X'32')
004900020517     D  F3             C                   CONST(X'33')
005000020517     D  F4             C                   CONST(X'34')
005100020517     D  F5             C                   CONST(X'35')
005200020517     D  F6             C                   CONST(X'36')
005300020517     D  F7             C                   CONST(X'37')
005400020517     D  F8             C                   CONST(X'38')
005500020517     D  F9             C                   CONST(X'39')
005600020517     D  F10            C                   CONST(X'3A')
005700020517     D  F11            C                   CONST(X'3B')
005800020517     D  F12            C                   CONST(X'3C')
005900020517     D  F13            C                   CONST(X'B1')
006000020517     D  F14            C                   CONST(X'B2')
006100020517     D  F15            C                   CONST(X'B3')
006200020517     D  F16            C                   CONST(X'B4')
006300020517     D  F17            C                   CONST(X'B5')
006400020517     D  F18            C                   CONST(X'B6')
006500020517     D  F19            C                   CONST(X'B7')
006600020517     D  F20            C                   CONST(X'B8')
006700020517     D  F21            C                   CONST(X'B9')
006800020517     D  F22            C                   CONST(X'BA')
006900020517     D  F23            C                   CONST(X'BB')
007000020517     D  F24            C                   CONST(X'BC')
007100020517    ***
007200020517     D @PARMS          S              9A
007300020517     D PRM@XCHG        DS
007400020517     D  P@STEP                 1      1A
007500020517     D  P@TRST                 2      4A
007600020517     D  P@TRSTN                2      4S 0
007700020517     D  P@SUB#                 5      7A
007800020517     D  P@SUB#N                5      7S 0
007900020517     D  P@STATUS               8      8A
008000020517     D  P@SORTBY               9      9A
008100020517    ***
008200020517     D KEY@TRS         S                   LIKE(ACTRST)
008300020517     D KEY@SUB         S                   LIKE(ACSUB#)
008400020517     D @EMSG           S                   LIKE(EMSG)
008500020517     D OSELEC          S            130A
008600020517   X***X
008700020517     C                   MOVEL     @PARMS        PRM@XCHG
008800020517    ***
008900020517     C                   IF        P@STEP = 'S'
009000020517     C                   EVAL      @STEP = 'STEP2'
009100020517     C                   ELSE
009200020517     C                   EVAL      @STEP = 'STEP0'
009300020517     C                   ENDIF
009400020517    ***
009500020517     C                   DOU       @STEP = 'LEAVE'
009600020517    ***
009700020517     C     @STEP         CASEQ     'STEP0'       $STEP0
009800020517     C     @STEP         CASEQ     'STEP1'       $STEP1
009900020517     C     @STEP         CASEQ     'STEP2'       $STEP2
010000020517     C     @STEP         CASEQ     'STEP3'       $STEP3
010100020517     C     @STEP         CASEQ     'STEP4'       $STEP4
010200020517     C     @STEP         CASEQ     'STEP5'       $STEP5
010300020517     C                   ENDCS
010400020517    ***
010500020517     C                   ENDDO
010600020517    ***
010700020517     C                   EVAL      *INLR = *ON
010800020517     C                   RETURN
010900020517     C                   MOVE      *ON           *INLR
011000020517   S***S
011100020517     C     *INZSR        BEGSR
011200020517    ***
011300020517     C                   EVAL      ACCCNT = 0
011400020517     C                   EVAL      EMPCNT = 0
011500020517    ***
011600020517     C     *ENTRY        PLIST
011700020517     C                   PARM                    @PARMS
011800020517    ***
011900020517     C     KEY#SUB       KLIST
012000020517     C                   KFLD                    KEY@TRS
012100020517     C                   KFLD                    KEY@SUB
012200020517    ***
012300020517     C                   ENDSR
012400020517   S***S
012500020517     C     $STEP0        BEGSR
012600020517    ***
012700020517     C                   OPEN      FL060D
012800020517     C                   OPEN      TRSMST
012900020517     C                   OPEN      SUBMST
013000020517     C                   OPEN      ACCMST
013100020517     C                   EVAL      S_TRST = 'ALL'
013200020517     C                   EVAL      S_SUB# = 'ALL'
013300020517     C                   EVAL      S_STATUS = 'Y'
013400020517     C                   EVAL      S_SORTBY = 'Y'
013500020517     C                   EVAL      S_JOBQ = 'Y'
013600020517     C                   EVAL      @STEP = 'STEP1'
013700020517    ***
013800020517     C                   ENDSR
013900020517   S***S
014000020517     C     $STEP1        BEGSR
014100020517    ***
014200020517     C                   MOVEL(P)  @EMSG         EMSG
014300020517     C                   EXFMT     SCREEN
014400020517     C                   CLEAR                   EMSG
014500020517     C                   CLEAR                   @EMSG
014600020517    ***
014700020517     C                   IF        FKEY = F7
014800020517     C                   EVAL      @STEP = 'LEAVE'
014900020517     C                   EVAL      P@STEP = 'X'
015000020517     C                   MOVEL     PRM@XCHG      @PARMS
015100020517     C                   LEAVESR
015200020517     C                   ENDIF
015300020517    ***
015400020517     C                   EXSR      $VALID
015500020517    ***
015600020517     C                   IF        VALIDPARMS = 'Y'
015700020517     C*
015800020517     C                   EVAL      P@TRST = S_TRST
015900020517     C                   EVAL      P@SUB# = S_SUB#
016000020517     C                   EVAL      P@STATUS = S_STATUS
016100020517     C                   EVAL      P@SORTBY = S_SORTBY
016200020517     C*
016300020517     C                   IF        S_JOBQ = 'N'
016400020517     C                   EVAL      @STEP = 'STEP2'
016500020517     C*
016600020517     C                   ELSE
016700020517     C                   EVAL      @STEP = 'LEAVE'
016800020517     C                   EVAL      P@STEP = 'S'
016900020517     C                   MOVEL     PRM@XCHG      @PARMS
017000020517     C*
017100020517     C                   ENDIF
017200020517     C*
017300020517     C                   CLOSE     TRSMST
017400020517     C                   CLOSE     SUBMST
017500020517     C                   CLOSE     ACCMST
017600020517     C                   CLOSE     FL060D
017700020517     C*
017800020517     C                   ENDIF
017900020517    ***
018000020517     C                   ENDSR
018100020517   S***S
018200020517     C     $VALID        BEGSR
018300020517    ***
018400020517     C                   EVAL      VALIDPARMS = 'N'
018500020517    ***
018600020517     C                   IF        S_TRST = '000' OR S_TRST = *BLANKS
018700020517     C                   EVAL      @EMSG = 'TRUST MUST BE SELECTED'
018800020517     C                   LEAVESR
018900020517     C                   ENDIF
019000020517    ***
019100020517     C                   IF        S_SUB# = '000' OR S_SUB# = *BLANKS
019200020517     C                   EVAL      @EMSG = 'SUBDIVISION # MUST BE SELECTED'
019300020517     C                   LEAVESR
019400020517     C                   ENDIF
019500020517    ***
019600020517     C                   IF        S_STATUS = *BLANKS OR (S_STATUS <> 'Y' AND
019700020517     C                             S_STATUS <> 'A' AND S_STATUS <> 'C')
019800020517     C                   EVAL      @EMSG = 'ACCOUNT STATUS IS INVALID'
019900020517     C                   LEAVESR
020000020517     C                   ENDIF
020100020517    ***
020200020517     C                   IF        S_SORTBY = *BLANKS OR (S_SORTBY <> 'Y' AND
020300020517     C                             S_SORTBY <> 'N')
020400020517     C                   EVAL      @EMSG = 'SORT SEQUENCE IS INVALID'
020500020517     C                   LEAVESR
020600020517     C                   ENDIF
020700020517    ***
020800020517     C                   IF        S_JOBQ <> 'N' AND S_JOBQ <> 'Y'
020900020517     C                   EVAL      @EMSG = 'JOBQ MUST EITHER BE Y OR N'
021000020517     C                   LEAVESR
021100020517     C                   ENDIF
021200020517    ***
021300020517    1C                   IF        S_TRST <> 'ALL'
021400020517     C                   MOVE      S_TRST        KEY@TRS
021500020517     C     KEY@TRS       CHAIN     TRSMSR
021600020517    2C                   IF        NOT %FOUND(TRSMST)
021700020517     C                   EVAL      @EMSG = 'TRUST IS INVALID RESELECT'
021800020517     C                   LEAVESR
021900020517    2C                   ENDIF
022000020517     C     KEY@TRS       CHAIN     SUBMSR
022100020517    2C                   IF        NOT %FOUND(SUBMST)
022200020517     C                   EVAL      @EMSG = 'NO SUBDIVISIONS FOR SELECTED TRUST'
022300020517     C                   LEAVESR
022400020517    2C                   ENDIF
022500020517     C     KEY@TRS       CHAIN     ACCSEQF
022600020517    2C                   IF        NOT %FOUND(ACCMST)
022700020517     C                   EVAL      @EMSG = 'NO ACCOUNTS FOR SELECTED TRUST'
022800020517     C                   LEAVESR
022900020517    2C                   ENDIF
023000020517     C                   ENDIF
023100020517    ***
023200020517    1C                   IF        S_TRST <> 'ALL' AND S_SUB# <> 'ALL'
023300020517     C                   MOVE      S_SUB#        KEY@SUB
023400020517     C     KEY#SUB       CHAIN     SUBMSR
023500020517    2C                   IF        NOT %FOUND(SUBMST)
023600020517     C                   EVAL      @EMSG = 'SUBDIVISION IS INVALID RESELECT'
023700020517     C                   LEAVESR
023800020517    2C                   ENDIF
023900020517     C     KEY#SUB       CHAIN     ACCSEQF
024000020517    2C                   IF        NOT %FOUND(ACCMST)
024100020517     C                   EVAL      @EMSG = 'NO ACCOUNTS FOR SELECTED TRUST/SUB'
024200020517     C                   LEAVESR
024300020517    2C                   ENDIF
024400020517     C                   ENDIF
024500020517    ***
024600020517     C                   EVAL      VALIDPARMS = 'Y'
024700020517    ***
024800020517     C                   ENDSR
024900020517   S***S
025000020517     C     $STEP2        BEGSR
025100020517    ***
025200020517     C                   OPEN      QSYSPRT
025300020517    ***
025400020517     C                   IF        P@SORTBY = 'Y'
025500020517     C                   OPEN      ACCMST
025600020517     C                   EVAL      @STEP = 'STEP3'
025700020517     C                   ELSE
025800020517     C                   OPEN      ACCNAM
025900020517     C                   EVAL      @STEP = 'STEP4'
026000020517     C                   ENDIF
026100020517    ***
026200020517     C                   EVAL      OSELEC = 'CRITERIA - TRS:' + P@TRST         +
026300020517     C                             '; SUB:' + P@SUB# + '; STATUS:' + P@STATUS  +
026400020517     C                             '; SEQ:' + P@SORTBY
026500020517     C                   EXCEPT    HDGF
026600020517    ***
026700020517     C                   ENDSR
026800020517   S***S
026900020517     C     $STEP3        BEGSR
027000020517    ***
027100020517     C                   READ      ACCSEQF
027200020517    ***
027300020517     C                   IF        %EOF(ACCMST)
027400020517     C                   EVAL      @STEP = 'STEP5'
027500020517     C                   LEAVESR
027600020517     C                   ENDIF
027700020517    ***
027800020517     C                   EXSR      $FILTER
027900020517     C*
028000020517     C                   IF        @GR = 'N'
028100020517     C                   LEAVESR
028200020517     C                   ENDIF
028300020517    ***
028400020517     C                   EXSR      $PRINTRTN
028500020517    ***
028600020517     C                   ENDSR
028700020517   S***S
028800020517     C     $FILTER       BEGSR
028900020517    ***
029000020517     C                   EVAL      @GR = 'N'
029100020517    ***
029200020517     C                   IF        P@TRST <> 'ALL' AND ACTRST <> P@TRSTN
029300020517     C                   LEAVESR
029400020517     C                   ENDIF
029500020517    ***
029600020517     C                   IF        P@SUB# <> 'ALL' AND ACSUB# <> P@SUB#N
029700020517     C                   LEAVESR
029800020517     C                   ENDIF
029900020517    ***
030000020517     C                   IF        P@STATUS <> 'Y'
030100020517     C                   IF        P@STATUS = 'A' AND ACDLTD <> 'A'
030200020517     C                   LEAVESR
030300020517     C                   ENDIF
030400020517     C                   IF        P@STATUS = 'C' AND ACDLTD <> 'C'
030500020517     C                   LEAVESR
030600020517     C                   ENDIF
030700020517     C                   ENDIF
030800020517    ***
030900020517     C                   EVAL      @GR = 'Y'
031000020517    ***
031100020517     C                   ENDSR
031200020517   S***S
031300020517     C     $PRINTRTN     BEGSR
031400020517    ***
031500020517     C                   ADD       1             ACCCNT
031600020517     C                   ADD       NOEMPL        EMPCNT
031700020517     C                   EVAL      *IN13 = *OFF
031800020517    ***
031900020517     C                   SELECT
032000020517     C                   WHEN      ACDLTD = 'A'
032100020517     C                   EVAL      @CODESC = '- ACTIVE'
032200020517     C                   WHEN      ACDLTD = 'C'
032300020517     C                   EVAL      @CODESC = '- CANCEL'
032400020517     C                   OTHER
032500020517     C                   EVAL      @CODESC = '-UNKNOWN'
032600020517     C                   ENDSL
032700020517    ***
032800020517     C     RNEWPD        COMP      *ZEROS                                 52
032900020517    ***
033000020517     C                   SELECT
033100020517     C                   WHEN      FCSTFL = 'S'
033200020517     C                   EVAL      COBDES = 'STATE'
033300020517     C                   WHEN      FCSTFL = 'F'
033400020517     C                   EVAL      COBDES = 'FEDERAL'
033500020517     C                   WHEN      FCSTFL = 'N'
033600020517     C                   EVAL      COBDES = 'NONE'
033700020517     C                   OTHER
033800020517     C                   EVAL      COBDES = '*******'
033900020517     C                   ENDSL
034000020517    ***
034100020517     C                   EVAL      @CSZ = %TRIM(ACITY) + ', ' + ASTATE + '.'
034200020517     C                   EVAL      @9 = %EDITC(AZIP:'X')
034300020517     C                   MOVEL     @9            @5
034400020517     C                   CAT       @5:1          @CSZ
034500020517     C                   IF        %SUBST(@9:6:4) <> '0000'
034600020517     C                   MOVE      @9            @4
034700020517     C                   CAT       '-':0         @CSZ
034800020517     C                   CAT       @4:0          @CSZ
034900020517     C                   ENDIF
035000020517    ***
035100020517     C                   IF        ENROLL > 0
035200020517     C                   MULT      10000.0001    ENROLL
035300020517     C                   ENDIF
035400020517     C                   IF        ATRMDT > 0
035500020517     C                   MULT      10000.0001    ATRMDT
035600020517     C                   EVAL      *IN13 = *ON
035700020517     C                   ENDIF
035800020517    ***
035900020517     C                   IF        *INOF = *ON
036000020517     C                   EXCEPT    HDGF
036100020517     C                   ENDIF
036200020517     C                   EXCEPT    DTLF
036300020517    ***
036400020517     C                   IF        ACNAM2 <> *BLANKS
036500020517     C                   IF        *INOF = *ON
036600020517     C                   EXCEPT    HDGF
036700020517     C                   ENDIF
036800020517     C                   EXCEPT    DTLF2
036900020517     C                   ENDIF
037000020517    ***
037100020517     C                   IF        *INOF = *ON
037200020517     C                   EXCEPT    HDGF
037300020517     C                   ENDIF
037400020517     C                   EXCEPT    DTLF3
037500020517    ***
037600020517     C                   IF        AADDR2 <> *BLANKS
037700020517     C                   IF        *INOF = *ON
037800020517     C                   EXCEPT    HDGF
037900020517     C                   ENDIF
038000020517     C                   EXCEPT    DTLF4
038100020517     C                   ENDIF
038200020517    ***
038300020517     C                   IF        *INOF = *ON
038400020517     C                   EXCEPT    HDGF
038500020517     C                   ENDIF
038600020517     C                   EXCEPT    DTLF5
038700020517    ***
038800020517     C                   ENDSR
038900020517   S***S
039000020517     C     $STEP4        BEGSR
039100020517    ***
039200020517     C                   READ      NAMSEQF
039300020517    ***
039400020517     C                   IF        %EOF(ACCNAM)
039500020517     C                   EVAL      @STEP = 'STEP5'
039600020517     C                   LEAVESR
039700020517     C                   ENDIF
039800020517    ***
039900020517     C                   EXSR      $FILTER
040000020517     C*
040100020517     C                   IF        @GR = 'N'
040200020517     C                   LEAVESR
040300020517     C                   ENDIF
040400020517    ***
040500020517     C                   EXSR      $PRINTRTN
040600020517    ***
040700020517     C                   ENDSR
040800020517   S***S
040900020517     C     $STEP5        BEGSR
041000020517    ***
041100020517     C                   IF        *INOF = *ON
041200020517     C                   EXCEPT    HDGF
041300020517     C                   ENDIF
041400020517     C                   EXCEPT    LRF
041500020517    ***
041600020517    ***
041700020517     C                   IF        P@SORTBY = 'Y'
041800020517     C                   CLOSE     ACCMST
041900020517     C                   ELSE
042000020517     C                   CLOSE     ACCNAM
042100020517     C                   ENDIF
042200020517    ***
042300020517     C                   CLOSE     QSYSPRT
042400020517     C                   EVAL      @STEP = 'LEAVE'
042500020517    ***
042600020517     C                   ENDSR
042700020517   X***X
042800980930     OQSYSPRT   E            HDGF           1  1
042900980930     O                                            5 'FL060'
043000020517     O                                           46 '*****'
043100020517     O                       CONAME              86
043200020517     O                                           91 '*****'
043300980930     OQSYSPRT   E            HDGF           1
043400980930     O                       UDATE         Y      8
043500910215     O                                          120 'PAGE :'
043600910215     O                       PAGE          Z    126
043700020517     OQSYSPRT   E            HDGF           1
043800020517     O*                      TIME                 8 '  :  :  '
043900020517     O                                           79 'ACCOUNT MASTER FILE LISTIN'
044000020517     O                                           80 'G'
044100020517     OQSYSPRT   E            HDGF           1
044200020517     O                       OSELEC             130                             000130
044300980930     OQSYSPRT   E            HDGF        1
044400020517     O                                           24 '------------------------'
044500020517     O                                           48 '------------------------'
044600020517     O                                           72 '------------------------'
044700020517     O                                           96 '------------------------'
044800020517     O                                          120 '------------------------'
044900020517     O                                          132 '------------'
045000980930     OQSYSPRT   E            HDGF        1
045100020517     O                                            8 'TRUST'
045200020517     O                                           17 'SUBDIV.'
045300020517     O                                           25 'NUMBER'
045400020517     O                                           55 'D E M O G R A P H I C S'
045500020517     O                                          100 'O T H E R   D A T A'
045600020517     O                                          129 'STATUS'
045700980930     OQSYSPRT   E            HDGF        1  1
045800020517     O                                           24 '------------------------'
045900020517     O                                           48 '------------------------'
046000020517     O                                           72 '------------------------'
046100020517     O                                           96 '------------------------'
046200020517     O                                          120 '------------------------'
046300020517     O                                          132 '------------'
046400020517     OQSYSPRT   E            DTLF        1
046500020517     O                       ACTRST               8
046600020517     O                       ACSUB#              15
046700020517     O                       ACACCT              24
046800910215     O                       ACNAM1              70
046900910215     O                                           90 'TOT. # EMPLOYEES :'
047000910215     O                       TOTEMP        Z     97
047100910215     O                                          112 'ACTIVE EMP.:'
047200910215     O                       NOEMPL        Z    120
047300020517     O                       ACDLTD             123
047400020517     O                       @CODESC            132
047500910215     OQSYSPRT   E            DTLF2       1
047600910215     O                       ACNAM2              70
047700910215     OQSYSPRT   E            DTLF3       1
047800910215     O                       AADDR1              60
047900910215     O                                           90 'COBRA STATUS :'
048000910215     O                       COBDES              98
048100910215     O               13                         118 'TERM. DATE IS'
048200020517     O               13      ATRMDT        Y    129
048300910215     OQSYSPRT   E            DTLF4       1
048400910215     O                       AADDR2              60
048500020517     OQSYSPRT   E            DTLF5       1
048600020517     O                       @CSZ                70
048700910215     O                                           90 'BY USER :'
048800910215     O                       OPERID              99
048900020517     OQSYSPRT   E            DTLF5       1
049000910215     O                                           40 'CONTACT IS'
049100910215     O                       CONTAC              71
049200020517     O                                           90 'ENROLMENT :'
049300020517     O                       ENROLL        Y    101
049400020517     OQSYSPRT   E            DTLF5       1
049500910215     O                                           31 '('
049600910215     O                       AAREA               34
049700910215     O                                           35 ')'
049800910215     O                       APHONE              44 '   -    '
049900910215     O                                           90 'RENEWAL PERIOD :'
050000910215     O              N52      RNEWPD              93
050100910215     O               52                         111 '*** UNDEFINED ***'
050200020517     OQSYSPRT   E            DTLF5       1
050300910215     O                                           90 'PRE EX DAYS :'
050400910215     O                       PREEX         Z     94
050500020517     OQSYSPRT   E            DTLF5       1
050600910215     O                                           90 'WAITING PERIOD(S) '
050700020517     O                                           93 'A:'
050800910215     O                       WAIT1         Z     96
050900910215     O                                          100 'B:'
051000020517     O                       WAIT2         Z    103
051100020517     O                                          107 'C:'
051200020517     O                       WAIT3         Z    110
051300020517     OQSYSPRT   E            DTLF5       1
051400910215     O                                           90 'AVERAGE AGE :'
051500910215     O                       AVGAGE        Z     94
051600020517     OQSYSPRT   E            DTLF5       1
051700910215     O                                           90 'SALESMAN TERRITORY :'
051800910215     O                       SMANCD              94
051900910215     OQSYSPRT   E            LRF         3
052000910215     O                                           24 '------------------------'
052100910215     O                                           48 '------------------------'
052200910215     O                                           72 '------------------------'
052300910215     O                                           96 '------------------------'
052400910215     O                                          120 '------------------------'
052500910215     O                                          132 '------------'
052600910215     OQSYSPRT   E            LRF         2
052700910215     O                                           40 'TOTAL ACCOUNTS LISTED'
052800910215     O                       ACCCNT        Z     45
052900910215     OQSYSPRT   E            LRF         2
053000910215     O                                           33 'TOTAL MEMBERS'
053100910215     O                       EMPCNT        2     45
