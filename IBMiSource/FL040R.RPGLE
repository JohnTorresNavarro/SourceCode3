0001009809290014  *  FL040 - THE GROUP RATE FILE CONTAINS THE NET AND BILLING RATE FOR
0002009809290015  *          EACH VALID COVERAGE TYPE IN EACH GROUP USED IN THE COBRA
0003009809290016  *          SYSTEM.
0004009809290003  *                  GROUP RATE FILE                             *
0005009809290004  *                                                              *
0006009809290005  *  FILE LABEL - GRATE                 ORGANIZATION - INDEXED   *
0007009809290006  *  FILE NAME - C.GRATE                KEY LENGTH - 15          *
0008009809290007  *  FILE RECORD LENGTH - 80            KEY START POSITION - 1   *
0009009809290008  *
0010009809290009  * REVISED: 06/20/90   WALTER J PICCININI
0011009809290010  *          MODIFY GRATE PROCESSING. READ FILE & COMPARE FROM-TO
0012009809290011  *          DATES TO GET CORRECT GRATE RECORD.....
001300980929      *       09/22/98 GSP  The following changes are a result of Y2K update.
001400980929      *                     Changed PLAN fields from numberic to alphanumeric.
001500980929      *                     Chaned PLNMST recl from 192 to 200 bytes.
001600980929      *                     Chaned TRSMST recl from 256 to 264 bytes.
001700980929      *                     Replace Halt indicators H1, H2, H3 and displayed
001800980929      *                     a 'Rec not Found' message on output.
001900990506      *  DMA 05.09.99   Changed Plan# to alpha (nice try, GSP!)
002000020423      * SSK 04/23/2002 GOING NATIVE BABY!
002001090924      *  DLK 09/24/09  change edit on rates to show negative
002100980929      *---------------------------------------------------------------
002200020423     FFL040D    CF   E             WORKSTN INFDS(WSDS) USROPN
0023000204230020 FGRAT24    IF   E           K DISK    USROPN
0024000204230022 FTRSMST    IF   E           K DISK    USROPN
0025000204230025 FSUBMST    IF   E           K DISK    USROPN
0026000204230024 FPLNMST    IF   E           K DISK    USROPN
0027000204230023 FCODES     IF   E           K DISK    USROPN
0028000204230023 FFL040WF   UF A E           K DISK    USROPN
0029000709250027 FQSYSPRT   O    F  132        PRINTER USROPN
003000070925     F                                     OFLIND(*INOF)
003100020422   X***X
003200020423     D WSDS            DS
003300020423     D  FKEY                 369    369A
003400020423    ***
003500020423     D NF_TRUST        C                   CONST('TRUST RECORD NOT FOUND')
003600020423     D NF_SUB          C                   CONST('SUB DIV RECORD NOT FOUND')
003700020423     D NF_PLAN         C                   CONST('PLAN RECORD NOT FOUND')
003800020423     D NF_CODE         C                   CONST('NO CODE DES')
003900020423    ***
004000020423     D  F1             C                   CONST(X'31')
004100020423     D  F2             C                   CONST(X'32')
004200020423     D  F3             C                   CONST(X'33')
004300020423     D  F4             C                   CONST(X'34')
004400020423     D  F5             C                   CONST(X'35')
004500020423     D  F6             C                   CONST(X'36')
004600020423     D  F7             C                   CONST(X'37')
004700020423     D  F8             C                   CONST(X'38')
004800020423     D  F9             C                   CONST(X'39')
004900020423     D  F10            C                   CONST(X'3A')
005000020423     D  F11            C                   CONST(X'3B')
005100020423     D  F12            C                   CONST(X'3C')
005200020423     D  F13            C                   CONST(X'B1')
005300020423     D  F14            C                   CONST(X'B2')
005400020423     D  F15            C                   CONST(X'B3')
005500020423     D  F16            C                   CONST(X'B4')
005600020423     D  F17            C                   CONST(X'B5')
005700020423     D  F18            C                   CONST(X'B6')
005800020423     D  F19            C                   CONST(X'B7')
005900020423     D  F20            C                   CONST(X'B8')
006000020423     D  F21            C                   CONST(X'B9')
006100020423     D  F22            C                   CONST(X'BA')
006200020423     D  F23            C                   CONST(X'BB')
006300020423     D  F24            C                   CONST(X'BC')
006400020423    ***
006500020423     D                UDS
006600020423     D  CONAME               201    240
006700020423     D  TIME                 242    247  0
006800020423    ***
006900020423     D @PARMS          S             19A
007000020423     D PRM@XCHG        DS
007100020423     D  P@STEP                 1      1A
007200020423     D  P@TRST                 2      4A
007300020423     D  P@TRSTN                2      4S 0
007400020423     D  P@SUB#                 5      7A
007500020423     D  P@SUB#N                5      7S 0
007600020423     D  P@PLAN                 8     11A
007700020423     D  P@DATE                12     19A
007800020423     D  P@DATEN               12     19S 0
007900020423    ***
008000020423     D @EMSG           S                   LIKE(EMSG)
008100020423     D @G              S              1A
008200020423     D @OPN            S              1A
008300020423     D @STEP           S              5A
008400020422    ***
008500020423     D CLR@TRS       E DS                  EXTNAME(TRSMST)
008600020423     D CLR@SUB       E DS                  EXTNAME(SUBMST)
008700020423     D CLR@GRT       E DS                  EXTNAME(GRATE)
008800020423     D  I                     11     12S 0
008900020423     D  TTYP                  13     13A
009000020423     D  TCOD                  14     15A
009100020423     D CLR@CDE       E DS                  EXTNAME(CODES)
009200020422     D CLR@PLN       E DS                  EXTNAME(PLNMST)
009300020423     D  ABFR                  58     97P 0 DIM(20)
009400020423     D  ABTO                  98    137P 0 DIM(20)
009500020422    ***
009600020423     D CTL#TRS         S                   LIKE(GRTRST)
009700020423     D CTL#SUB         S                   LIKE(GRSUB#)
009800020423     D CTL#PLN         S                   LIKE(GRPLAN)
009900020423     D CTL#FRDT        S                   LIKE(FRMDAT)
010000020423     D CTL#TODT        S                   LIKE(TODAT)
010100020422    ***
010200020423     D KEY@TRS         S                   LIKE(GRTRST)
010300020423     D KEY@SUB         S                   LIKE(GRSUB#)
010400020423     D KEY@PLN         S                   LIKE(GRPLAN)
010500020422    ***
010600020423     D OSELEC          S            130A
010700020423     D FIRSTIME        S              1A
010800020423     D VALIDPARMS      S              1A
010900020423     D FRDT_O          S              8S 0
011000020423     D TODT_O          S              8S 0
011100020422   X***X
011200020423     C                   MOVEL     @PARMS        PRM@XCHG
011300020423     C                   OPEN      TRSMST
011400020423     C                   OPEN      SUBMST
011500020423     C                   OPEN      PLNMST
011600020423     C                   OPEN      GRAT24
011700020423    ***
011800020423     C                   IF        P@STEP = 'S'
011900020423     C                   EVAL      @STEP = 'STEP2'
012000020423     C                   ELSE
012100020423     C                   EVAL      @STEP = 'STEP0'
012200020423     C                   ENDIF
012300020423    ***
012400020423     C                   DOU       @STEP = 'LEAVE'
012500020423    ***
012600020423     C     @STEP         CASEQ     'STEP0'       $STEP0
012700020423     C     @STEP         CASEQ     'STEP1'       $STEP1
012800020423     C     @STEP         CASEQ     'STEP2'       $STEP2
012900020423     C     @STEP         CASEQ     'STEP3'       $STEP3
013000020423     C     @STEP         CASEQ     'STEP4'       $STEP4
013100020423     C                   ENDCS
013200020423    ***
013300020423     C                   ENDDO
013400020423    ***
013500020423     C                   EXSR      $CLOSEF
013600020423    ***
013700020423     C                   EVAL      *INLR = *ON
013800020423     C                   RETURN
013900020423   S***S
014000020423     C     *INZSR        BEGSR
014100020423    ***
014200020423     C     *ENTRY        PLIST
014300020423     C                   PARM                    @PARMS
014400020423    ***
014500020423     C     KEY#SUB       KLIST
014600020423     C                   KFLD                    KEY@TRS
014700020423     C                   KFLD                    KEY@SUB
014800020423    ***
014900020423     C     KEY#CDE       KLIST
015000020423     C                   KFLD                    TTYP
015100020423     C                   KFLD                    TCOD
015200020423    ***
015300020423     C     KEY#PLN       KLIST
015400020423     C                   KFLD                    KEY@TRS
015500020423     C                   KFLD                    KEY@SUB
015600020423     C                   KFLD                    KEY@PLN
015700020423    ***
015800020423     C                   ENDSR
015900020423   S***S
016000020423     C     $STEP0        BEGSR
016100020423    ***
016200020423     C                   OPEN      FL040D
016300020423     C                   EVAL      S_TRST = 'ALL'
016400020423     C                   EVAL      S_SUB# = 'ALL'
016500020423     C                   EVAL      S_PLAN = 'ALL'
016600020423     C                   EVAL      S_FDTE = 0
016700020423     C                   EVAL      S_JOBQ = 'Y'
016800020423     C                   EVAL      @STEP = 'STEP1'
016900020423    ***
017000020423     C                   ENDSR
017100020423   S***S
017200020423     C     $STEP1        BEGSR
017300020423    ***
017400020423     C                   MOVEL(P)  @EMSG         EMSG
017500020423     C                   EXFMT     SCREEN
017600020423     C                   CLEAR                   EMSG
017700020423     C                   CLEAR                   @EMSG
017800020423    ***
017900020423     C                   IF        FKEY = F7
018000020423     C                   EVAL      @STEP = 'LEAVE'
018100020517     C                   EVAL      P@STEP = 'X'
018200020517     C                   MOVEL     PRM@XCHG      @PARMS
018300020517     C                   LEAVESR
018400020423     C                   ENDIF
018500020423    ***
018600020423     C                   EXSR      $VALID
018700020423    ***
018800020423     C                   IF        VALIDPARMS = 'Y'
018900020423     C*
019000020423     C                   EVAL      P@TRST = S_TRST
019100020423     C                   EVAL      P@SUB# = S_SUB#
019200020423     C                   EVAL      P@PLAN = S_PLAN
019300020423     C                   IF        S_FDTE = 0
019400020423     C                   EVAL      P@DATEN = 0
019500020423     C                   ELSE
019600020423     C     S_FDTE        MULT      10000.0001    FRMDAT
019700020423     C                   EVAL      P@DATEN = FRMDAT
019800020423     C                   ENDIF
019900020423     C*
020000020423     C                   IF        S_JOBQ = 'N'
020100020423     C                   EVAL      @STEP = 'STEP2'
020200020423     C*
020300020423     C                   ELSE
020400020423     C                   EVAL      @STEP = 'LEAVE'
020500020423     C                   EVAL      P@STEP = 'S'
020600020423     C                   MOVEL     PRM@XCHG      @PARMS
020700020423     C*
020800020423     C                   ENDIF
020900020423     C                   CLOSE     FL040D
021000020423     C*
021100020423     C                   ENDIF
021200020423    ***
021300020423     C                   ENDSR
021400020423   S***S
021500020423     C     $VALID        BEGSR
021600020423    ***
021700020423     C                   EVAL      VALIDPARMS = 'N'
021800020423    ***
021900020423    1C                   IF        S_TRST = '000' OR S_TRST = *BLANKS
022000020423     C                   EVAL      @EMSG = 'TRUST MUST BE SELECTED'
022100020423     C                   LEAVESR
022200020423    1C                   ENDIF
022300020423    ***
022400020423    1C                   IF        S_SUB# = '000' OR S_SUB# = *BLANKS
022500020423     C                   EVAL      @EMSG = 'SUBDIVISION # MUST BE SELECTED'
022600020423     C                   LEAVESR
022700020423    1C                   ENDIF
022800020423    ***
022900020423    1C                   IF        S_PLAN = '0000' OR S_PLAN = *BLANKS
023000020423     C                   EVAL      @EMSG = 'PLAN # MUST BE SELECTED'
023100020423     C                   LEAVESR
023200020423    1C                   ENDIF
023300020423    ***
023400020423    1C                   IF        S_FDTE > 0
023500020423     C     *USA          TEST(DE)                S_FDTE
023600020423    2C                   IF        %ERROR
023700020423     C                   EVAL      @EMSG = 'VALID DATE OR ZERO ONLY'
023800020423     C                   LEAVESR
023900020423    2C                   ENDIF
024000020423    1C                   ENDIF
024100020423    ***
024200020423    1C                   IF        S_JOBQ <> 'N' AND S_JOBQ <> 'Y'
024300020423     C                   EVAL      @EMSG = 'JOBQ IS EITHER Y OR N'
024400020423     C                   LEAVESR
024500020423    1C                   ENDIF
024600020423    ***
024700020423    1C                   IF        S_TRST <> 'ALL'
024800020423     C                   MOVE      S_TRST        KEY@TRS
024900020423     C     KEY@TRS       CHAIN     TRSMSR
025000020423    2C                   IF        NOT %FOUND(TRSMST)
025100020423     C                   EVAL      @EMSG = 'TRUST IS INVALID RESELECT'
025200020423     C                   LEAVESR
025300020423    2C                   ENDIF
025400020423     C     KEY@TRS       CHAIN     GRATER
025500020423    2C                   IF        NOT %FOUND(GRAT24)
025600020423     C                   EVAL      @EMSG = 'NO RATES FOR SELECTED TRUST'
025700020423     C                   LEAVESR
025800020423    2C                   ENDIF
025900020423    1C                   ENDIF
026000020423    ***
026100020423    1C                   IF        S_TRST <> 'ALL' AND S_SUB# <> 'ALL'
026200020423     C                   MOVE      S_SUB#        KEY@SUB
026300020423     C     KEY#SUB       CHAIN     SUBMSR
026400020423    2C                   IF        NOT %FOUND(SUBMST)
026500020423     C                   EVAL      @EMSG = 'SUBDIVISION IS INVALID RESELECT'
026600020423     C                   LEAVESR
026700020423    2C                   ENDIF
026800020423     C     KEY#SUB       CHAIN     GRATER
026900020423    2C                   IF        NOT %FOUND(GRAT24)
027000020423     C                   EVAL      @EMSG = 'NO RATES FOR SELECTED TRUST/SUB'
027100020423     C                   LEAVESR
027200020423    2C                   ENDIF
027300020423     C                   ENDIF
027400020423    ***
027500020423    1C                   IF        S_TRST <> 'ALL' AND S_SUB# <> 'ALL' AND
027600020423    1C                             S_PLAN <> 'ALL '
027700020423     C                   MOVE      S_PLAN        KEY@PLN
027800020423     C     KEY#PLN       CHAIN     GRATER
027900020423    2C                   IF        NOT %FOUND(GRAT24)
028000020423     C                   EVAL      @EMSG = 'NO RATE ARE AVAILABLE TO REPORT'
028100020423     C                   LEAVESR
028200020423    2C                   ENDIF
028300020423     C                   ENDIF
028400020423    ***
028500020423     C                   EVAL      VALIDPARMS = 'Y'
028600020423    ***
028700020423     C                   ENDSR
028800020423   S***S
028900020423     C     $STEP2        BEGSR
029000020423    ***
029100020423     C                   EVAL      FIRSTIME = 'Y'
029200020423     C                   EVAL      @OPN = 'Y'
029300020423     C                   OPEN      QSYSPRT
029400020423     C                   OPEN      CODES
029500020423     C                   OPEN      FL040WF
029600020423     C                   CLEAR                   CLR@TRS
029700020423     C                   CLEAR                   CLR@SUB
029800020423     C                   CLEAR                   CLR@PLN
029900020423     C                   CLEAR                   CLR@GRT
030000020423     C                   CLEAR                   CLR@CDE
030100020423    ***
030200020423     C                   EVAL      OSELEC = 'CRITERIA - TRS:' + P@TRST         +
030300020423     C                             '; SUB:' + P@SUB# + '; PLN:' + P@PLAN       +
030400020423     C                             '; DATE:' + %EDITW(P@DATEN:'   0/  /  ')
030500020423    ***
030600020423     C                   IF        P@TRST = 'ALL' OR P@SUB# = 'ALL' OR
030700020423     C                             P@PLAN = 'ALL '
030800020423     C                   EVAL      @STEP = 'STEP3'
030900020423     C                   LEAVESR
031000020423     C                   ENDIF
031100020423    ***
031200020423     C                   EVAL      @STEP = 'STEP4'
031300020423    ***
031400020423     C                   ENDSR
031500020423   S***S
031600020423     C     $STEP3        BEGSR
031700020423    ***
031800020423     C                   EVAL      KEY@TRS = 001
031900020423     C                   EVAL      KEY@SUB = 000
032000020423     C                   EVAL      KEY@PLN = *BLANKS
032100020423     C                   SELECT
032200020423     C                   WHEN      P@TRST <> 'ALL' AND P@SUB# = 'ALL'
032300020423     C                   MOVE      P@TRST        KEY@TRS
032400020423     C                   WHEN      P@TRST <> 'ALL' AND P@SUB# <> 'ALL' AND
032500020423     C                             P@PLAN = 'ALL '
032600020423     C                   MOVE      P@TRST        KEY@TRS
032700020423     C                   MOVE      P@SUB#        KEY@SUB
032800020423     C                   ENDSL
032900020423    ***
033000020423     C     KEY#PLN       SETLL     GRATER
033100020423    1C                   DOU       %EOF(GRAT24)
033200020423     C                   READ      GRATER
033300020423    2C                   IF        NOT %EOF(GRAT24)
033400020423    ***
033500020423     C                   EXSR      $FILTER
033600020423    ***
033700020423     C                   IF        @G = 'Y'
033800020423     C                   WRITE     F40F
033900020423     C                   ENDIF
034000020423    ***
034100020423    2C                   ENDIF
034200020423    1C                   ENDDO
034300020423    ***
034400020423     C                   CLOSE     FL040WF
034500020423     C                   OPEN      FL040WF
034600020423    ***
034700020423    1C                   DOU       %EOF(FL040WF)
034800020423     C                   READ      F40F
034900020423    2C                   IF        NOT %EOF(FL040WF)
035000020423    ***
035100020423     C     FRMDAT        MULT      10000.0001    FRDT_O
035200020423     C     TODAT         MULT      10000.0001    TODT_O
035300020423    ***
035400020423    1C                   IF        FIRSTIME = 'Y'
035500020423     C                   EXCEPT    HDGF
035600020423     C                   ENDIF
035700020423    ***
035800020423     C                   EVAL      KEY@TRS = GRTRST
035900020423     C                   EVAL      KEY@SUB = GRSUB#
036000020423     C                   EVAL      KEY@PLN = GRPLAN
036100020423     C                   EXSR      $DETAIL
036200020423    ***
036300020423    2C                   ENDIF
036400020423    1C                   ENDDO
036500020423    ***
036600020423     C                   CLOSE     FL040WF
036700020423     C                   EVAL      @STEP = 'LEAVE'
036800020423    ***
036900020423     C                   ENDSR
037000020423   S***S
037100020423     C     $FILTER       BEGSR
037200020423    ***
037300020423     C                   EVAL      @G = 'N'
037400020423    ***
037500020423     C                   EVAL      KEY@TRS = GRTRST
037600020423     C                   EVAL      KEY@SUB = GRSUB#
037700020423     C                   EVAL      KEY@PLN = GRPLAN
037800020423    ***
037900020423     C                   IF        P@DATEN > 0 AND P@DATEN <> FRMDAT
038000020423     C                   LEAVESR
038100020423     C                   ENDIF
038200020423    ***
038300020423     C                   IF        P@TRST <> 'ALL' AND KEY@TRS <> P@TRSTN
038400020423     C                   LEAVESR
038500020423     C                   ENDIF
038600020423    ***
038700020423     C                   IF        P@SUB# <> 'ALL' AND KEY@SUB <> P@SUB#N
038800020423     C                   LEAVESR
038900020423     C                   ENDIF
039000020423    ***
039100020423     C                   IF        P@PLAN <> 'ALL ' AND KEY@PLN <> P@PLAN
039200020423     C                   LEAVESR
039300020423     C                   ENDIF
039400020423    ***
039500020423     C                   EVAL      @G = 'Y'
039600020423    ***
039700020423     C                   ENDSR
039800020423   S***S
039900020423     C     $DETAIL       BEGSR
040000020423    ***
040100020423     C                   EVAL      *IN25 = *OFF
040200020423     C                   EVAL      *IN26 = *OFF
040300020423    ***
040400020423    1C                   IF        GRTRST <> TRTRST OR GRSUB# <> SBSUB# OR
040500020423     C                             TODAT <> CTL#TODT OR FRMDAT <> CTL#FRDT
040600020423     C*
040700020423     C                   EXSR      $BREAK
040800020423     C*
040900020423    1C                   ENDIF
041000020423    ***
041100020423     C                   IF        GRPLAN <> PLPLAN
041200020423     C*
041300020423     C                   EVAL      *IN25 = *ON
041400020423     C     KEY#PLN       CHAIN     PLNMSR
041500020423    1C                   IF        NOT %FOUND(PLNMST)
041600020423     C                   CLEAR                   CLR@PLN
041700020423     C                   MOVEL     NF_PLAN       PDESCR
041800020423    1C                   ENDIF
041900020423     C*
042000020423    1C                   ENDIF
042100020423    ***
042200020423     C     KEY#CDE       CHAIN     CODESR
042300020423     C                   IF        NOT %FOUND(CODES)
042400020423     C                   CLEAR                   CLR@CDE
042500020423     C                   MOVEL     NF_CODE       SDESCR
042600020423     C                   ENDIF
042700020423    ***
042800020423     C                   IF        AGEBND > 0
042900020423     C                   EVAL      *IN26 = *ON
043000020423     C                   ENDIF
043100020423    ***
043200020423    1C                   IF        *INOF = *ON
043300020423     C                   EXCEPT    HDGF
043400020423    1C                   ENDIF
043500020423     C                   EXCEPT    DTLF
043600020423    ***
043700020423     C                   ENDSR
043800020423   S***S
043900020423     C     $BREAK        BEGSR
044000020423    ***
044100020423     C                   CLEAR                   CLR@TRS
044200020423     C                   CLEAR                   CLR@SUB
044300020423     C                   CLEAR                   CLR@PLN
044400020423     C                   CLEAR                   CLR@CDE
044500020423     C                   Z-ADD     TODAT         CTL#TODT
044600020423     C                   Z-ADD     FRMDAT        CTL#FRDT
044700020423    ***
044800020423     C     KEY@TRS       CHAIN     TRSMSR
044900020423    1C                   IF        NOT %FOUND(TRSMST)
045000020423     C                   CLEAR                   CLR@TRS
045100020423     C                   MOVEL     NF_TRUST      TNAME
045200020423    1C                   ENDIF
045300020423    ***
045400020423     C     KEY#SUB       CHAIN     SUBMSR
045500020423    1C                   IF        NOT %FOUND(SUBMST)
045600020423     C                   CLEAR                   CLR@SUB
045700020423     C                   MOVEL     NF_SUB        SUBNAM
045800020423    1C                   ENDIF
045900020423    ***
046000020423     C                   EVAL      *IN25 = *ON
046100020423     C     KEY#PLN       CHAIN     PLNMSR
046200020423    1C                   IF        NOT %FOUND(PLNMST)
046300020423     C                   CLEAR                   CLR@PLN
046400020423     C                   MOVEL     NF_PLAN       PDESCR
046500020423    1C                   ENDIF
046600020423    ***
046700020423    1C                   IF        FIRSTIME = 'Y'
046800020423     C                   EVAL      FIRSTIME = 'N'
046900020423    1C                   ELSE
047000020423     C                   EXCEPT    HDGF
047100020423    1C                   ENDIF
047200020423    ***
047300020423     C                   EXCEPT    SECF
047400020423    ***
047500020423     C                   ENDSR
047600020423   S***S
047700020423     C     $STEP4        BEGSR
047800020423    ***
047900020423     C                   MOVE      P@TRST        KEY@TRS
048000020423     C                   MOVE      P@SUB#        KEY@SUB
048100020423     C                   MOVE      P@PLAN        KEY@PLN
048200020423    ***
048300020423     C     KEY#PLN       SETLL     GRATER
048400020423    1C                   DOU       %EOF(GRAT24)
048500020423     C     KEY#PLN       READE     GRATER
048600020423    2C                   IF        NOT %EOF(GRAT24)
048700020423    ***
048800020423     C                   EXSR      $FILTER
048900020423    ***
049000020423     C                   IF        @G = 'Y'
049100020423     C                   WRITE     F40F
049200020423     C                   ENDIF
049300020423    ***
049400020423    2C                   ENDIF
049500020423    1C                   ENDDO
049600020423    ***
049700020423     C                   CLOSE     FL040WF
049800020423     C                   OPEN      FL040WF
049900020423    ***
050000020423    1C                   DOU       %EOF(FL040WF)
050100020423     C                   READ      F40F
050200020423    2C                   IF        NOT %EOF(FL040WF)
050300020423    ***
050400020423     C     FRMDAT        MULT      10000.0001    FRDT_O
050500020423     C     TODAT         MULT      10000.0001    TODT_O
050600020423    ***
050700020423    1C                   IF        FIRSTIME = 'Y'
050800020423     C                   EXCEPT    HDGF
050900020423     C                   ENDIF
051000020423    ***
051100020423     C                   EVAL      KEY@TRS = GRTRST
051200020423     C                   EVAL      KEY@SUB = GRSUB#
051300020423     C                   EVAL      KEY@PLN = GRPLAN
051400020423     C                   EXSR      $DETAIL
051500020423    ***
051600020423    2C                   ENDIF
051700020423    1C                   ENDDO
051800020423    ***
051900020423     C                   CLOSE     FL040WF
052000020423    ***
052100020423     C                   EVAL      @STEP = 'LEAVE'
052200020423    ***
052300020423     C                   ENDSR
052400020423   S***S
052500020423     C     $CLOSEF       BEGSR
052600020423    ***
052700020423     C                   CLOSE     TRSMST
052800020423     C                   CLOSE     SUBMST
052900020423     C                   CLOSE     PLNMST
053000020423     C                   CLOSE     GRAT24
053100020423     C                   CLOSE     CODES
053200020423    ***
053300020423     C                   IF        @OPN = 'Y'
053400020423     C                   CLOSE     QSYSPRT
053500020423     C                   ENDIF
053600020423    ***
053700020423     C                   ENDSR
053800020423   X***X
0539000709250151 OQSYSPRT   E            HDGF           1  1
0540009809290113 O                                            5 'FL040'
0541009102150104 O                       CONAME              84
0542000709250151 OQSYSPRT   E            HDGF           1
0543009809290107 O                       UDATE         Y      8
0544009102150108 O                                           70 'RATE SCHEDULE'
0545009809290109 O                                          124 'PAGE :'
0546009809290110 O                       PAGE          Z    130
0547000709250151 OQSYSPRT   E            HDGF           1
0548009809290115 O                       TIME                 8 '  :  :  '
0549000709250151 OQSYSPRT   E            HDGF           1
0550000204230118 O                                           58 'FOR PERIOD :'
055100020423Y2K  O                       FRDT_O        Y     69
0552000204230120 O                                           71 '-'
055300020423Y2K  O                       TODT_O        Y     82
0554000709250151 OQSYSPRT   E            HDGF           1
055500020423     O                       OSELEC             130
0556000709250151 OQSYSPRT   E            HDGF           1
0557009102150124 O                                           24 '------------------------'
0558009102150125 O                                           48 '------------------------'
0559009102150126 O                                           72 '------------------------'
0560009102150127 O                                           96 '------------------------'
0561009102150128 O                                          120 '------------------------'
0562009102150129 O                                          132 '------------'
0563000709250151 OQSYSPRT   E            HDGF           1
0564009102150132 O                                           30 'P L A N'
0565009102150133 O                                           68 'A G E   B A N D'
0566009102150134 O                                           82 'T Y P E'
0567009102150135 O                                          109 'C H A R G E S'
0568000709250151 OQSYSPRT   E            HDGF           1
0569009102150138 O                                           68 'CODE  FROM - TO'
0570000709250139 O                                          111 'NET        BILLED'
0571009102150140 O                                          128 'GROUP #'
0572000709250151 OQSYSPRT   E            HDGF           1
0573009102150143 O                                           24 '------------------------'
0574009102150144 O                                           48 '------------------------'
0575009102150145 O                                           72 '------------------------'
0576009102150146 O                                           96 '------------------------'
0577009102150147 O                                          120 '------------------------'
0578009102150148 O                                          132 '------------'
0579000204230151 OQSYSPRT   E            SECF           1
0580000204230151 O                                            9 'TRUST #:'
0581000204230152 O                       GRTRST              13
0582000204230153 O                       TNAME               36
0583000204230151 OQSYSPRT   E            SECF           1
0584009102150157 O                                            9 'SUB DIV#:'
0585000204230158 O                       GRSUB#              13
0586000204230159 O                       SUBNAM              36
0587000709250151 OQSYSPRT   E            DTLF           1
0588000204230162 O               25      GRPLAN               8
0589000204230163 O               25      PDESCR              51
0590000204230165 O               26      AGEBND        Z     56
0591000204230166 O               26      ABFR(I)       Z     62
0592000204230167 O               26                          64 '-'
0593000204230168 O               26      ABTO(I)       Z     68
0594000709250169 O                       TCOD                73
0595000709250170 O                       SDESCR              84
0596000909240172 O                       NETRTE        l     98
0597000909240173 O                       BILRTE        l    112
0598009102150174 O                       GROUP#             132
0599009102150151 OQSYSPRT   E            BLKF           1
0600009102150176 O                                            2 ' '
