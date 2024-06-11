000100910215     H DFTNAME(FL050)
000200990316      ****************************************************************
000300980930      *  FL050 -  DECLINING LIFE BENEFIT RATE FILE LISTING
000400980930      *           THE DECLINING LIFE BENEFIT RATE FILE CONTAINS
000500980930      *           FROM AGE-TO AGE, DECLINING RATE .
000600980930      *                                                              *
000700980930      *  FILE LABEL - DECLIF                ORGANIZATION - INDEXED   *
000800910215     F*  FILE NAME - ?L'241,1'?.DECLIF      KEY LENGTH - 10          *
000900910215     F*  FILE RECORD LENGTH - 256           KEY START POSITION - 1   *
001000910215     F*                                                              *
001100980930      *       09/22/98 GSP  The following changes are a result of Y2K update.
001200980930      *                     Changed PLAN fields from numberic to alphanumeric.
001300980930      *                     Chaned PLNMST recl from 192 to 200 bytes.
001400980930      *                     Chaned TRSMST recl from 256 to 264 bytes.
001500020423      * 04/23/02 SSK CHANGE TO NATIVE
001600980930      ****************************************************************
001700020423     FFL050D    CF   E             WORKSTN INFDS(WSDS) USROPN
001800020424     FDECLIF    IF   E           K DISK    USROPN
001900020424     FPLNMST    IF   E           K DISK    USROPN
002000020424     FTRSMST    IF   E           K DISK    USROPN
002100020424     FSUBMST    IF   E           K DISK    USROPN
002200020424     FQSYSPRT   O    F  132        PRINTER USROPN
002300020424     F                                     OFLIND(*INOF)
002400020424   X***X
002500020424     D NF_TRUST        C                   CONST('TRUST RECORD NOT FOUND')
002600020424     D NF_SUB          C                   CONST('SUB DIV RECORD NOT FOUND')
002700020424     D NF_PLAN         C                   CONST('PLAN RECORD NOT FOUND')
002800020424    ***
002900020424     D WSDS            DS
003000020424     D  FKEY                 369    369A
003100020424    ***
003200020424     D  F1             C                   CONST(X'31')
003300020424     D  F2             C                   CONST(X'32')
003400020424     D  F3             C                   CONST(X'33')
003500020424     D  F4             C                   CONST(X'34')
003600020424     D  F5             C                   CONST(X'35')
003700020424     D  F6             C                   CONST(X'36')
003800020424     D  F7             C                   CONST(X'37')
003900020424     D  F8             C                   CONST(X'38')
004000020424     D  F9             C                   CONST(X'39')
004100020424     D  F10            C                   CONST(X'3A')
004200020424     D  F11            C                   CONST(X'3B')
004300020424     D  F12            C                   CONST(X'3C')
004400020424     D  F13            C                   CONST(X'B1')
004500020424     D  F14            C                   CONST(X'B2')
004600020424     D  F15            C                   CONST(X'B3')
004700020424     D  F16            C                   CONST(X'B4')
004800020424     D  F17            C                   CONST(X'B5')
004900020424     D  F18            C                   CONST(X'B6')
005000020424     D  F19            C                   CONST(X'B7')
005100020424     D  F20            C                   CONST(X'B8')
005200020424     D  F21            C                   CONST(X'B9')
005300020424     D  F22            C                   CONST(X'BA')
005400020424     D  F23            C                   CONST(X'BB')
005500020424     D  F24            C                   CONST(X'BC')
005600020424    ***
005700020424     D                UDS
005800020424     D  CONAME               201    240
005900020424     D  TIME                 242    247  0
006000020424    ***
006100020424     D @PARMS          S             11A
006200020424     D PRM@XCHG        DS
006300020424     D  P@STEP                 1      1A
006400020424     D  P@TRST                 2      4A
006500020424     D  P@TRSTN                2      4S 0
006600020424     D  P@SUB#                 5      7A
006700020424     D  P@SUB#N                5      7S 0
006800020424     D  P@PLAN                 8     11A
006900020424    ***
007000020424     D @EMSG           S                   LIKE(EMSG)
007100020424     D @G              S              1A
007200020424     D @OPN            S              1A
007300020424     D @STEP           S              5A
007400020424    ***
007500020424     D CLR@TRS       E DS                  EXTNAME(TRSMST)
007600020424     D CLR@SUB       E DS                  EXTNAME(SUBMST)
007700020424     D CLR@PLN       E DS                  EXTNAME(PLNMST)
007800020424     D CLR@DEC       E DS                  EXTNAME(DECLIF)
007900020424     D  ABF                   11     50P 0 DIM(20)
008000020424     D  ABT                   71    110P 0 DIM(20)
008100020424     D  DPR                  131    190P 3 DIM(20)
008200020424    ***
008300020424     D KEY@TRS         S                   LIKE(DCTRST)
008400020424     D KEY@SUB         S                   LIKE(DCSUB#)
008500020424     D KEY@PLN         S                   LIKE(DCPLAN)
008600020424    ***
008700020424     D OSELEC          S            130A
008800020424     D VALIDPARMS      S              1A
008900020423     D I               S              2S 0
009000020424     D @6              S              6A
009100020424     D @59             S             59A
009200020424     D @72             S             72A
009300020424     D @20C1           S             20A
009400020424     D @20C2           S             20A
009500020424     D @20C3           S             20A
009600020424     D #5V3            S              5S 3
009700020423   X***X
009800020424     C                   MOVEL     @PARMS        PRM@XCHG
009900020424     C                   OPEN      TRSMST
010000020424     C                   OPEN      SUBMST
010100020424     C                   OPEN      PLNMST
010200020424     C                   OPEN      DECLIF
010300020424    ***
010400020424     C                   IF        P@STEP = 'S'
010500020424     C                   EVAL      @STEP = 'STEP2'
010600020424     C                   ELSE
010700020424     C                   EVAL      @STEP = 'STEP0'
010800020424     C                   ENDIF
010900020424    ***
011000020424     C                   DOU       @STEP = 'LEAVE'
011100020424    ***
011200020424     C     @STEP         CASEQ     'STEP0'       $STEP0
011300020424     C     @STEP         CASEQ     'STEP1'       $STEP1
011400020424     C     @STEP         CASEQ     'STEP2'       $STEP2
011500020424     C     @STEP         CASEQ     'STEP3'       $STEP3
011600020424     C     @STEP         CASEQ     'STEP4'       $STEP4
011700020424     C                   ENDCS
011800020424    ***
011900020424     C                   ENDDO
012000020424    ***
012100020424     C                   EXSR      $CLOSEF
012200020424    ***
012300020424     C                   EVAL      *INLR = *ON
012400020424     C                   RETURN
012500020424   S***S
012600020424     C     *INZSR        BEGSR
012700020424    ***
012800020424     C     *ENTRY        PLIST
012900020424     C                   PARM                    @PARMS
013000020424    ***
013100020424     C     KEY#SUB       KLIST
013200020424     C                   KFLD                    KEY@TRS
013300020424     C                   KFLD                    KEY@SUB
013400020424    ***
013500020424     C     KEY#PLN       KLIST
013600020424     C                   KFLD                    KEY@TRS
013700020424     C                   KFLD                    KEY@SUB
013800020424     C                   KFLD                    KEY@PLN
013900020424    ***
014000020424     C                   ENDSR
014100020424   S***S
014200020424     C     $STEP0        BEGSR
014300020424    ***
014400020424     C                   OPEN      FL050D
014500020424     C                   EVAL      S_TRST = 'ALL'
014600020424     C                   EVAL      S_SUB# = 'ALL'
014700020424     C                   EVAL      S_PLAN = 'ALL'
014800020424     C                   EVAL      S_JOBQ = 'Y'
014900020424     C                   EVAL      @STEP = 'STEP1'
015000020424    ***
015100020424     C                   ENDSR
015200020424   S***S
015300020424     C     $STEP1        BEGSR
015400020424    ***
015500020424     C                   MOVEL(P)  @EMSG         EMSG
015600020424     C                   EXFMT     SCREEN
015700020424     C                   CLEAR                   EMSG
015800020424     C                   CLEAR                   @EMSG
015900020424    ***
016000020424     C                   IF        FKEY = F7
016100020424     C                   EVAL      @STEP = 'LEAVE'
016200020517     C                   EVAL      P@STEP = 'X'
016300020517     C                   MOVEL     PRM@XCHG      @PARMS
016400020517     C                   LEAVESR
016500020424     C                   ENDIF
016600020424    ***
016700020424     C                   EXSR      $VALID
016800020424    ***
016900020424     C                   IF        VALIDPARMS = 'Y'
017000020424     C*
017100020424     C                   EVAL      P@TRST = S_TRST
017200020424     C                   EVAL      P@SUB# = S_SUB#
017300020424     C                   EVAL      P@PLAN = S_PLAN
017400020424     C*
017500020424     C                   IF        S_JOBQ = 'N'
017600020424     C                   EVAL      @STEP = 'STEP2'
017700020424     C*
017800020424     C                   ELSE
017900020424     C                   EVAL      @STEP = 'LEAVE'
018000020424     C                   EVAL      P@STEP = 'S'
018100020424     C                   MOVEL     PRM@XCHG      @PARMS
018200020424     C*
018300020424     C                   ENDIF
018400020424     C                   CLOSE     FL050D
018500020424     C*
018600020424     C                   ENDIF
018700020424    ***
018800020424     C                   ENDSR
018900020424   S***S
019000020424     C     $VALID        BEGSR
019100020424    ***
019200020424     C                   EVAL      VALIDPARMS = 'N'
019300020424    ***
019400020424    1C                   IF        S_TRST = '000' OR S_TRST = *BLANKS
019500020424     C                   EVAL      @EMSG = 'TRUST MUST BE SELECTED'
019600020424     C                   LEAVESR
019700020424    1C                   ENDIF
019800020424    ***
019900020424    1C                   IF        S_SUB# = '000' OR S_SUB# = *BLANKS
020000020424     C                   EVAL      @EMSG = 'SUBDIVISION # MUST BE SELECTED'
020100020424     C                   LEAVESR
020200020424    1C                   ENDIF
020300020424    ***
020400020424    1C                   IF        S_PLAN = '0000' OR S_PLAN = *BLANKS
020500020424     C                   EVAL      @EMSG = 'PLAN # MUST BE SELECTED'
020600020424     C                   LEAVESR
020700020424    1C                   ENDIF
020800020424    ***
020900020424    1C                   IF        S_JOBQ <> 'N' AND S_JOBQ <> 'Y'
021000020424     C                   EVAL      @EMSG = 'JOBQ IS EITHER Y OR N'
021100020424     C                   LEAVESR
021200020424    1C                   ENDIF
021300020424    ***
021400020424    1C                   IF        S_TRST <> 'ALL'
021500020424     C                   MOVE      S_TRST        KEY@TRS
021600020424     C     KEY@TRS       CHAIN     TRSMSR
021700020424    2C                   IF        NOT %FOUND(TRSMST)
021800020424     C                   EVAL      @EMSG = 'TRUST IS INVALID RESELECT'
021900020424     C                   LEAVESR
022000020424    2C                   ENDIF
022100020424     C     KEY@TRS       CHAIN     DECLIR
022200020424    2C                   IF        NOT %FOUND(DECLIF)
022300020424     C                   EVAL      @EMSG = 'NO RATES FOR SELECTED TRUST'
022400020424     C                   LEAVESR
022500020424    2C                   ENDIF
022600020424    1C                   ENDIF
022700020424    ***
022800020424    1C                   IF        S_TRST <> 'ALL' AND S_SUB# <> 'ALL'
022900020424     C                   MOVE      S_SUB#        KEY@SUB
023000020424     C     KEY#SUB       CHAIN     SUBMSR
023100020424    2C                   IF        NOT %FOUND(SUBMST)
023200020424     C                   EVAL      @EMSG = 'SUBDIVISION IS INVALID RESELECT'
023300020424     C                   LEAVESR
023400020424    2C                   ENDIF
023500020424     C     KEY#SUB       CHAIN     DECLIR
023600020424    2C                   IF        NOT %FOUND(DECLIF)
023700020424     C                   EVAL      @EMSG = 'NO RATES FOR SELECTED TRUST/SUB'
023800020424     C                   LEAVESR
023900020424    2C                   ENDIF
024000020424     C                   ENDIF
024100020424    ***
024200020424    1C                   IF        S_TRST <> 'ALL' AND S_SUB# <> 'ALL' AND
024300020424    1C                             S_PLAN <> 'ALL '
024400020424     C                   MOVE      S_PLAN        KEY@PLN
024500020424     C     KEY#PLN       CHAIN     DECLIR
024600020424    2C                   IF        NOT %FOUND(DECLIF)
024700020424     C                   EVAL      @EMSG = 'NO RATES ARE AVAILABLE TO REPORT'
024800020424     C                   LEAVESR
024900020424    2C                   ENDIF
025000020424     C                   ENDIF
025100020424    ***
025200020424     C                   EVAL      VALIDPARMS = 'Y'
025300020424    ***
025400020424     C                   ENDSR
025500020424   S***S
025600020424     C     $STEP2        BEGSR
025700020424    ***
025800020424     C                   EVAL      @OPN = 'Y'
025900020424     C                   OPEN      QSYSPRT
026000020424     C                   CLEAR                   CLR@TRS
026100020424     C                   CLEAR                   CLR@SUB
026200020424     C                   CLEAR                   CLR@PLN
026300020424     C                   CLEAR                   CLR@DEC
026400020424    ***
026500020424     C                   EVAL      OSELEC = 'CRITERIA - TRS:' + P@TRST         +
026600020424     C                             '; SUB:' + P@SUB# + '; PLN:' + P@PLAN
026700020424    ***
026800020424     C                   EXCEPT    HDGF
026900020424    ***
027000020424     C                   IF        P@TRST = 'ALL' OR P@SUB# = 'ALL' OR
027100020424     C                             P@PLAN = 'ALL '
027200020424     C                   EVAL      @STEP = 'STEP3'
027300020424     C                   LEAVESR
027400020424     C                   ENDIF
027500020424    ***
027600020424     C                   EVAL      @STEP = 'STEP4'
027700020424    ***
027800020424     C                   ENDSR
027900020424   S***S
028000020424     C     $STEP3        BEGSR
028100020424    ***
028200020424     C                   EVAL      KEY@TRS = 001
028300020424     C                   EVAL      KEY@SUB = 000
028400020424     C                   EVAL      KEY@PLN = *BLANKS
028500020424     C                   SELECT
028600020424     C                   WHEN      P@TRST <> 'ALL' AND P@SUB# = 'ALL'
028700020424     C                   MOVE      P@TRST        KEY@TRS
028800020424     C                   WHEN      P@TRST <> 'ALL' AND P@SUB# <> 'ALL' AND
028900020424     C                             P@PLAN = 'ALL '
029000020424     C                   MOVE      P@TRST        KEY@TRS
029100020424     C                   MOVE      P@SUB#        KEY@SUB
029200020424     C                   ENDSL
029300020424    ***
029400020424     C     KEY#PLN       SETLL     DECLIR
029500020424    1C                   DOU       %EOF(DECLIF)
029600020424     C                   READ      DECLIR
029700020424    2C                   IF        NOT %EOF(DECLIF)
029800020424    ***
029900020424     C                   EXSR      $FILTER
030000020424    ***
030100020424     C                   IF        @G = 'Y'
030200020424     C                   EXSR      $DETAIL
030300020424    2C                   ENDIF
030400020424    ***
030500020424    2C                   ENDIF
030600020424    1C                   ENDDO
030700020424    ***
030800020424     C                   EVAL      @STEP = 'LEAVE'
030900020424    ***
031000020424     C                   ENDSR
031100020424   S***S
031200020424     C     $FILTER       BEGSR
031300020424    ***
031400020424     C                   EVAL      @G = 'N'
031500020424    ***
031600020424     C                   EVAL      KEY@TRS = DCTRST
031700020424     C                   EVAL      KEY@SUB = DCSUB#
031800020424     C                   EVAL      KEY@PLN = DCPLAN
031900020424    ***
032000020424     C                   IF        P@TRST <> 'ALL' AND KEY@TRS <> P@TRSTN
032100020424     C                   LEAVESR
032200020424     C                   ENDIF
032300020424    ***
032400020424     C                   IF        P@SUB# <> 'ALL' AND KEY@SUB <> P@SUB#N
032500020424     C                   LEAVESR
032600020424     C                   ENDIF
032700020424    ***
032800020424     C                   IF        P@PLAN <> 'ALL ' AND KEY@PLN <> P@PLAN
032900020424     C                   LEAVESR
033000020424     C                   ENDIF
033100020424    ***
033200020424     C                   EVAL      @G = 'Y'
033300020424    ***
033400020424     C                   ENDSR
033500020424   S***S
033600020424     C     $DETAIL       BEGSR
033700020424    ***
033800020424    1C                   IF        *INOF = *ON
033900020424     C                   EXCEPT    HDGF
034000020424    1C                   ENDIF
034100020424     C                   EXCEPT    SBHF
034200020424    ***
034300020424    1C                   IF        DCTRST <> TRTRST OR DCSUB# <> SBSUB# OR
034400020424     C                             DCPLAN <> PLPLAN
034500020424     C                   EXSR      $BREAK
034600020424    1C                   ENDIF
034700020424    ***
034800020424     C                   EVAL      I = 0
034900020424    ***
035000020424     C                   EVAL      @59 = 'TRUST #: ' + %EDITC(DCTRST:'X') +
035100020424     C                             '  ' + %TRIM(TNAME)
035200020424     C                   EXSR      $EXTRATXT
035300020424     C                   EXSR      $WRITE
035400020424    ***
035500020424     C                   EVAL      @59 = 'SUBDV #: ' + %EDITC(DCSUB#:'X') +
035600020424     C                             '  ' + %TRIM(SUBNAM)
035700020424     C                   EXSR      $EXTRATXT
035800020424     C                   EXSR      $WRITE
035900020424    ***
036000020424     C                   EVAL      @59 = 'PLAN  #: ' + DCPLAN + ' ' +
036100020424     C                             %TRIM(PDESCR)
036200020424     C                   EXSR      $EXTRATXT
036300020424     C                   EXSR      $WRITE
036400020424    ***
036500020424     C                   EVAL      @59 = 'ROUND  : ' + RNDFLG
036600020424     C                   EXSR      $EXTRATXT
036700020424     C                   EXSR      $WRITE
036800020424    ***
036900020424     C                   EVAL      @59 = 'RND AMT: ' + %EDITC(RNDAMT:'Z')
037000020424     C                   EXSR      $EXTRATXT
037100020424     C                   EXSR      $WRITE
037200020424    ***
037300020424     C                   EVAL      @59 = 'STATUS : ' + DCDLTD
037400020424     C                   EXSR      $EXTRATXT
037500020424     C                   EXSR      $WRITE
037600020424    ***
037700020424     C                   EVAL      @59 = *BLANKS
037800020424     C                   EXSR      $EXTRATXT
037900020424     C                   EXSR      $WRITE
038000020424    ***
038100020424    1C                   IF        *INOF = *ON
038200020424     C                   EXCEPT    HDGF
038300020424    1C                   ENDIF
038400020424     C                   EXCEPT    TRHF
038500020424    ***
038600020424     C                   ENDSR
038700020424   S***S
038800020424     C     $WRITE        BEGSR
038900020424    ***
039000020424    1C                   IF        *INOF = *ON
039100020424     C                   EXCEPT    HDGF
039200020424    1C                   ENDIF
039300020424     C                   EXCEPT    DTLF
039400020424    ***
039500020424     C                   ENDSR
039600020424   S***S
039700020424     C     $EXTRATXT     BEGSR
039800020424    ***
039900020424     C                   EVAL      @72 = *BLANKS
040000020424     C                   EVAL      @20C1 = *BLANKS
040100020424     C                   EVAL      @20C2 = *BLANKS
040200020424     C                   EVAL      @20C3 = *BLANKS
040300020424    ***
040400020424     C                   ADD       1             I
040500020424     C                   IF        ABF(I) > 0
040600020424     C                   Z-ADD     DPR(I)        #5V3
040700020424     C                   EVAL      @6 = %EDITC(#5V3:'3')
040800020424     C                   EVAL      @20C1 = %EDITC(I:'X') + '  ' +
040900020424     C                             %EDITC(ABF(I):'Z') + ' ' +
041000020424     C                             %EDITC(ABT(I):'Z') + '   ' + @6
041100020424     C                   ENDIF
041200020424    ***
041300020424     C                   ADD       1             I
041400020424     C                   IF        ABF(I) > 0
041500020424     C                   Z-ADD     DPR(I)        #5V3
041600020424     C                   EVAL      @6 = %EDITC(#5V3:'3')
041700020424     C                   EVAL      @20C2 = %EDITC(I:'X') + '  ' +
041800020424     C                             %EDITC(ABF(I):'Z') + ' ' +
041900020424     C                             %EDITC(ABT(I):'Z') + '   ' + @6
042000020424     C                   ENDIF
042100020424    ***
042200020424     C                   ADD       1             I
042300020424     C                   IF        I < 21
042400020424     C                   IF        ABF(I) > 0
042500020424     C                   Z-ADD     DPR(I)        #5V3
042600020424     C                   EVAL      @6 = %EDITC(#5V3:'3')
042700020424     C                   EVAL      @20C3 = %EDITC(I:'X') + '  ' +
042800020424     C                             %EDITC(ABF(I):'Z') + ' ' +
042900020424     C                             %EDITC(ABT(I):'Z') + '   ' + @6
043000020424     C                   ENDIF
043100020424     C                   ENDIF
043200020424    ***
043300020424     C                   IF        @20C1 = *BLANKS AND @20C2 = *BLANKS AND
043400020424     C                             @20C3 = *BLANKS
043500020424     C                   LEAVESR
043600020424     C                   ENDIF
043700020424    ***
043800020424     C                   EVAL      @72 = @20C1 + '      ' + @20C2 + '      ' +
043900020424     C                                   @20C3
044000020424    ***
044100020424     C                   ENDSR
044200020424   S***S
044300020424     C     $BREAK        BEGSR
044400020424    ***
044500020424     C                   CLEAR                   CLR@TRS
044600020424     C                   CLEAR                   CLR@SUB
044700020424     C                   CLEAR                   CLR@PLN
044800020424    ***
044900020424     C     KEY@TRS       CHAIN     TRSMSR
045000020424    1C                   IF        NOT %FOUND(TRSMST)
045100020424     C                   CLEAR                   CLR@TRS
045200020424     C                   MOVEL     NF_TRUST      TNAME
045300020424    1C                   ENDIF
045400020424    ***
045500020424     C     KEY#SUB       CHAIN     SUBMSR
045600020424    1C                   IF        NOT %FOUND(SUBMST)
045700020424     C                   CLEAR                   CLR@SUB
045800020424     C                   MOVEL     NF_SUB        SUBNAM
045900020424    1C                   ENDIF
046000020424    ***
046100020424     C     KEY#PLN       CHAIN     PLNMSR
046200020424    1C                   IF        NOT %FOUND(PLNMST)
046300020424     C                   CLEAR                   CLR@PLN
046400020424     C                   MOVEL     NF_PLAN       PDESCR
046500020424    1C                   ENDIF
046600020424    ***
046700020424     C                   ENDSR
046800020424   S***S
046900020424     C     $STEP4        BEGSR
047000020424    ***
047100020424     C                   MOVE      P@TRST        KEY@TRS
047200020424     C                   MOVE      P@SUB#        KEY@SUB
047300020424     C                   MOVE      P@PLAN        KEY@PLN
047400020424    ***
047500020424     C     KEY#PLN       SETLL     DECLIR
047600020424    1C                   DOU       %EOF(DECLIF)
047700020424     C     KEY#PLN       READE     DECLIR
047800020424    2C                   IF        NOT %EOF(DECLIF)
047900020424    ***
048000020424     C                   EXSR      $FILTER
048100020424    ***
048200020424     C                   IF        @G = 'Y'
048300020424     C                   EVAL      KEY@TRS = DCTRST
048400020424     C                   EVAL      KEY@SUB = DCSUB#
048500020424     C                   EVAL      KEY@PLN = DCPLAN
048600020424     C                   EXSR      $DETAIL
048700020424    2C                   ENDIF
048800020424    ***
048900020424    2C                   ENDIF
049000020424    1C                   ENDDO
049100020424    ***
049200020424     C                   EVAL      @STEP = 'LEAVE'
049300020424    ***
049400020424     C                   ENDSR
049500020424   S***S
049600020424     C     $CLOSEF       BEGSR
049700020424    ***
049800020424     C                   CLOSE     TRSMST
049900020424     C                   CLOSE     SUBMST
050000020424     C                   CLOSE     PLNMST
050100020424     C                   CLOSE     DECLIF
050200020424    ***
050300020424     C                   IF        @OPN = 'Y'
050400020424     C                   CLOSE     QSYSPRT
050500020424     C                   ENDIF
050600020424    ***
050700020424     C                   ENDSR
050800020423   X***X
050900980930     OQSYSPRT   E            HDGF           1  1
051000980930     O                                            5 'FL050'
0511000204230104 O                       CONAME              84
0512000204230109 O                                          124 'PAGE :'
0513000204230110 O                       PAGE          Z    130
051400980930     OQSYSPRT   E            HDGF           1
051500020423     O                       UDATE         Y      8
051600020423     O                                           70 'DECLINING LIFE BENEFIT '
051700020423     O                                           82 'RATE LISTING'
051800980930     OQSYSPRT   E            HDGF           1
0519000204230115 O                       TIME                 8 '  :  :  '
052000980930     OQSYSPRT   E            HDGF           2
052100020423     O                       OSELEC             130
052200980930     OQSYSPRT   E            HDGF           1
052300910215     O                                           20 '--------------------'
052400910215     O                                           40 '--------------------'
052500910215     O                                           60 '--------------------'
052600910215     O                                           80 '--------------------'
052700910215     O                                          100 '--------------------'
052800910215     O                                          120 '--------------------'
052900910215     O                                          132 '------------'
053000910215     OQSYSPRT   E            SBHF           1
053100910215     O                                           79 '%  OF'
053200910215     O                                          105 '%  OF'
053300910215     O                                          130 '%  OF'
053400910215     OQSYSPRT   E            SBHF           1
053500910215     O                                           81 'BAND FROM-TO   BENEFIT'
053600910215     O                                          107 'BAND FROM-TO   BENEFIT'
053700910215     O                                          132 'BAND FROM-TO  BENEFIT'
053800020424     OQSYSPRT   E            DTLF           1
053900020424     O                       @59                 59
054000020424     O                       @72                132
054100910215     OQSYSPRT   E            TRHF           2
054200910215     O                                           20 '--------------------'
054300910215     O                                           40 '--------------------'
054400910215     O                                           60 '--------------------'
054500910215     O                                           80 '--------------------'
054600910215     O                                          100 '--------------------'
054700910215     O                                          120 '--------------------'
054800910215     O                                          132 '------------'
