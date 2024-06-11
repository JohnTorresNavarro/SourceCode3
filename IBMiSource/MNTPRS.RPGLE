000100000000     FMNTPRSD   CF   E             WORKSTN INFDS(WSDS)
000200000000     FXXEOYCC   UF A E           K DISK
000300000000     FSUPRAGCY  IF   E           K DISK
000400140224     FAGENL4    IF   E           K DISK
000500140225     FSMANUNIQUEIF   E           K DISK
000600000000    ***X
000700000000     D RRT             S              4S 0
000800000000    ***
000900000000     D WSDS            DS
001000000000     D  FKEY                 369    369A
001100000000    ***
001200000000     D  F1             C                   CONST(X'31')
001300000000     D  F2             C                   CONST(X'32')
001400000000     D  F3             C                   CONST(X'33')
001500000000     D  F4             C                   CONST(X'34')
001600000000     D  F5             C                   CONST(X'35')
001700000000     D  F6             C                   CONST(X'36')
001800000000     D  F7             C                   CONST(X'37')
001900000000     D  F8             C                   CONST(X'38')
002000000000     D  F9             C                   CONST(X'39')
002100000000     D  F10            C                   CONST(X'3A')
002200000000     D  F11            C                   CONST(X'3B')
002300000000     D  F12            C                   CONST(X'3C')
002400000000     D  F13            C                   CONST(X'B1')
002500000000     D  F14            C                   CONST(X'B2')
002600000000     D  F15            C                   CONST(X'B3')
002700000000     D  F16            C                   CONST(X'B4')
002800000000     D  F17            C                   CONST(X'B5')
002900000000     D  F18            C                   CONST(X'B6')
003000000000     D  F19            C                   CONST(X'B7')
003100000000     D  F20            C                   CONST(X'B8')
003200000000     D  F21            C                   CONST(X'B9')
003300000000     D  F22            C                   CONST(X'BA')
003400000000     D  F23            C                   CONST(X'BB')
003500000000     D  F24            C                   CONST(X'BC')
003600000000    ***
003700000000     D WADTA         E DS                  EXTNAME(SUPRAGCY)
003800000000     D WBDTA         E DS                  EXTNAME(AGENCY)
003900000000     D WCDTA         E DS                  EXTNAME(SMAN)
004000000000    ***
004100140224     D
004200140224     D
004300000000     D HEF             S              8S 0 INZ(0)
004400000000     D @Q              S             70A
004500000000     D @PROC           S             10A   INZ('INITIALIZE')
004600000000     D #YUSA           S              8S 0 INZ
004700000000     D #YEAR           S              8S 0 INZ
004800000000     D @YEAR           S              8A   INZ
004900000000     D @SA             S              3A   INZ
005000000000     D @AG             S              3A   INZ
005100000000     D @SM             S              3A   INZ
005200000000     D ECARR           S              2A
005300000000     D ENAME           S             20A
005400140224    ***
005500140224     D KF@SUPER        S              3A   INZ
005600140224     D KF@SMAN         S              3A   INZ
005700140224     D KF@AGCY         S              3A   INZ
005800140224    ***
005900140224    ***
006000000000    ***X
006100000000    ***
006200000000     C                   DOU       @PROC = 'EXIT PRGRM'                          X
006300000000     C     @PROC         CASEQ     'INITIALIZE'  $INZ
006400000000     C     @PROC         CASEQ     'QUESTION  '  $QSTN                           1
006500000000     C     @PROC         CASEQ     'CHANGE CC '  $CHANGE                         2
006600000000     C     @PROC         CASEQ     'SELECTION '  $SELECT                         3
006700000000     C     @PROC         CASEQ     'FORMAT CHG'  $FMTCHG                         5
006800000000     C     @PROC         CASEQ     'TRANSFERCC'  $TRANSFER                       6
006900140224     C     @PROC         CASEQ     'PROMPT FLD'  $PROMPT                         7
007000140224     C     @PROC         CASEQ     'TFR AMOUNT'  $TFRCTL                         8
007100140224     C     @PROC         CASEQ     'ADD CNTRCT'  $ADDPREP
007200140224     C     @PROC         CASEQ     'ADD CONTRL'  $ADDCTL
007300000000     C                   ENDCS
007400000000     C                   ENDDO
007500000000    ***
007600000000     C                   EVAL      *INLR = *ON
007700000000    ***
007800000000    ***S
007900000000     C     $INZ          BEGSR
008000000000    ***
008100000000     C     *ENTRY        PLIST
008200000000     C                   PARM                    P17              19
008300000000    ***
008400000000     C                   EVAL      @PROC = 'QUESTION  '
008500000000    ***
008600140224     C     KL#           KLIST
008700140224     C                   KFLD                    HEF
008800140224     C                   KFLD                    KF@SUPER
008900140224     C                   KFLD                    KF@AGCY
009000140224     C                   KFLD                    KF@SMAN
009100140224    ***
009200000000     C                   EVAL      @YEAR = %SUBST(P17:1:8)
009300000000     C                   MOVE      @YEAR         #YEAR
009400000000     C     #YEAR         MULT      10000.0001    #YUSA
009500000000     C                   EVAL      @SA = %SUBST(P17:9:3)
009600000000     C                   EVAL      @AG = %SUBST(P17:12:3)
009700000000     C                   EVAL      @SM = %SUBST(P17:15:3)
009800000000     C                   EVAL      SAS = @SA + '/' + @AG + '/' + @SM
009900000000     C                   MOVE      #YUSA         THEYEAR
010000140224     C                   MOVE      #YUSA         #WORKPRD          8 0
010100000000     C                   EVAL      ECARR = %SUBST(P17:18:2)
010200000000    ***
010300000000     C                   SELECT
010400000000     C                   WHEN      ECARR = 'CF'
010500000000     C                   EVAL      ENAME = 'CAREFIRST'
010600000000     C                   WHEN      ECARR = 'CH'
010700000000     C                   EVAL      ENAME = 'COVENTRY HEALTH'
010800000000     C                   ENDSL
010900000000    ***
011000000000     C                   ENDSR
011100000000    ***S
011200000000    *** S1
011300000000     C     $QSTN         BEGSR
011400000000    ***
011500000000     C                   EVAL      QUMSG = @Q
011600000000     C                   EVAL      THECARR = ECARR
011700000000    ***
011800000000     C                   EXFMT     QUEST
011900000000    ***
012000000000     C                   EVAL      @Q = *BLANKS
012100140224     C                   EVAL      KF@SUPER = *BLANKS
012200140224     C                   EVAL      KF@AGCY = *BLANKS
012300140224     C                   EVAL      KF@SMAN = *BLANKS
012400000000     C                   MOVE      #YEAR         HEF
012500000000     C                   EVAL      *IN50 = *OFF
012600000000     C                   EVAL      *IN51 = *OFF
012700000000    *** EXIT APP
012800000000     C                   IF        FKEY = F3
012900000000     C                   EVAL      @PROC = 'EXIT PRGRM'
013000000000     C                   LEAVESR
013100000000     C                   ENDIF
013200000000    *** VALID REQS?
013300000000     C                   IF        QUESTN <> 'A' AND QUESTN <> 'B' AND
013400000000     C                             QUESTN <> 'C'
013500000000     C                   EVAL      @Q = 'INVALID ACTION CHOICE, TRY AGAIN.'
013600000000     C                   LEAVESR
013700000000     C                   ENDIF
013800000000    ***
013900000000     C                   SELECT
014000000000    *** **
014100000000     C                   WHEN      QUESTN = 'A'
014200000000     C                   CLEAR                   QSTN1
014300000000     C                   MOVE      #YUSA         Q1EFF
014400000000     C                   MOVEL     @SA           Q1SA
014500000000     C                   MOVEL     @AG           Q1AG
014600000000     C                   MOVEL     @SM           Q1SM
014700140224     C                   EVAL      KF@SUPER = Q1SA
014800140224     C                   EVAL      KF@AGCY = Q1AG
014900140224     C                   EVAL      KF@SMAN = Q1SM
015000000000     C                   EVAL      @PROC = 'FORMAT CHG'
015100000000    *** **
015200000000     C                   WHEN      QUESTN = 'B'
015300000000     C                   CLEAR                   QSTN2
015400000000     C                   EXSR      $GETQTY
015500000000     C                   EVAL      @PROC = 'TRANSFERCC'
015600000000    *** **
015700000000     C                   WHEN      QUESTN = 'C'
015800000000     C                   CLEAR                   QSTN3
015900000000     C                   EVAL      @PROC = 'ADD CNTRCT'
016000000000    *** **
016100000000     C                   ENDSL
016200000000    ***
016300000000     C                   ENDSR
016400000000    ***S
016500000000    *** S5 FORMAT DATE FOR CHANGE SCREEN
016600000000    ***
016700000000     C     $FMTCHG       BEGSR
016800000000    ***
016900000000     C     KL#           CHAIN(N)  CFEOYCCR
017000000000     C                   IF        NOT %FOUND(XXEOYCC)
017100000000     C     'ERROR'       DSPLY     '*EXT'
017200000000     C                   EVAL      @PROC = 'EXIT PRGRM'
017300000000     C                   LEAVESR
017400000000     C                   ENDIF
017500000000    ***
017600000000     C     CYEFF         MULT      10000.0001    Q1EFF
017700140224    ***
017800000000     C                   EVAL      Q1SA = CYSA
017900000000     C                   EVAL      Q1AG = CYAG
018000000000     C                   EVAL      Q1SM = CYSM
018100140224    ***
018200000000     C                   EVAL      Q1ADCNT = CYADCNT
018300000000     C                   EVAL      Q1DBCNT = CYDBCNT
018400000000     C                   EVAL      Q1GACNT = CYGACNT
018500000000     C                   EVAL      Q1PHCNT = CYPHCNT
018600000000     C                   EVAL      Q1NACNT = CYNACNT
018700140224    ***
018800000000     C                   EVAL      Q1OADCNT = CYCALADCNT
018900000000     C                   EVAL      Q1ODBCNT = CYCALDBCNT
019000000000     C                   EVAL      Q1OGACNT = CYCALGACNT
019100000000     C                   EVAL      Q1OPHCNT = CYCALPHCNT
019200000000     C                   EVAL      Q1ONACNT = CYCALNACNT
019300140224    ***
019400000000     C                   EVAL      Q1NOTE1 = %SUBST(CYNOTE:1:50)
019500000000     C                   EVAL      Q1NOTE2 = %SUBST(CYNOTE:51:50)
019600140224    ***
019700000000     C                   EVAL      Q1ADDCNT = CYADDCNT
019800000000     C                   EVAL      Q1DBDCNT = CYDBDCNT
019900000000     C                   EVAL      Q1GADCNT = CYGADCNT
020000000000     C                   EVAL      Q1NADCNT = CYNADCNT
020100140224    ***
020200000000     C                   EVAL      Q1OADDCNT = CYCALADDCN
020300000000     C                   EVAL      Q1ODBDCNT = CYCALDBDCN
020400000000     C                   EVAL      Q1OGADCNT = CYCALGADCN
020500000000     C                   EVAL      Q1ONADCNT = CYCALNADCN
020600000000    ***
020700000000     C                   EXSR      $Q1FMTG
020800000000    ***
020900140224     C                   EVAL      @PROC = 'CHANGE CC '
021000000000    ***
021100000000     C                   ENDSR
021200000000    ***S
021300000000     C     $GETQTY       BEGSR
021400000000    ***
021500000000     C                   MOVE      #YUSA         Q2EFF
021600000000     C                   MOVEL     @SA           Q2FSA
021700000000     C                   MOVEL     @AG           Q2FAG
021800000000     C                   MOVEL     @SM           Q2FSM
021900000000     C     Q2EFF         MULT      10000.0001    K#DATE
022000000000     C     KL#F          CHAIN(N)  CFEOYCCR
022100000000     C                   IF        NOT %FOUND(XXEOYCC)
022200000000     C     'ERROR'       DSPLY     '*EXT'
022300000000     C                   ENDIF
022400000000    ***
022500140224     C                   EVAL      KF@SUPER = Q2FSA
022600140224     C                   EVAL      KF@AGCY = Q2FAG
022700140224     C                   EVAL      KF@SMAN = Q2FSM
022800000000     C                   EVAL      HEF = Q2EFF
022900000000    ***
023000000000     C                   EVAL      Q2ADCNT  =    CYADCNT
023100000000     C                   EVAL      Q2DBCNT  =    CYDBCNT
023200000000     C                   EVAL      Q2GACNT  =    CYGACNT
023300000000     C                   EVAL      Q2PHCNT  =    CYPHCNT
023400000000     C                   EVAL      Q2NACNT  =    CYNACNT
023500000000     C                   EVAL      Q2DBDCNT  =    CYDBDCNT
023600000000     C                   EVAL      Q2GADCNT  =    CYGADCNT
023700000000     C                   EVAL      Q2ADDCNT  =    CYADDCNT
023800000000     C                   EVAL      Q2NADCNT  =    CYNADCNT
023900000000    ***
024000000000     C                   EVAL      Q2NOTE1 = %SUBST(CYNOTE:1:50)
024100000000     C                   EVAL      Q2NOTE2 = %SUBST(CYNOTE:51:50)
024200000000    ***
024300000000     C                   ENDSR
024400000000    ***S
024500000000    *** S2
024600140225     C     $CHANGE       BEGSR
024700000000    ***
024800000000     C                   EVAL      Q1MSG = @Q
024900000000     C                   EVAL      THECARR = ECARR
025000000000     C                   EVAL      CARRNAME = ENAME
025100000000     C                   EXFMT     QSTN1
025200000000     C                   EVAL      @Q = *BLANKS
025300000000     C                   EVAL      *IN50 = *OFF
025400000000    ***
025500000000     C                   IF        FKEY = F12
025600000000     C                   EVAL      @PROC = 'QUESTION  '
025700000000     C                   LEAVESR
025800000000     C                   ENDIF
025900000000    ***
026000000000     C                   IF        FKEY = F5
026100000000     C                   EVAL      @PROC = 'SELECTION '
026200000000     C                   LEAVESR
026300000000     C                   ENDIF
026400000000    ***
026500000000     C                   IF        Q1ADCNT <> CYADCNT OR
026600000000     C                             Q1DBCNT <> CYDBCNT OR
026700000000     C                             Q1GACNT <> CYGACNT OR
026800000000     C                             Q1PHCNT <> CYPHCNT OR
026900000000     C                             Q1NACNT <> CYNACNT OR
027000000000     C                             Q1ADDCNT <> CYADDCNT OR
027100000000     C                             Q1DBDCNT <> CYDBDCNT OR
027200000000     C                             Q1NADCNT <> CYNADCNT OR
027300000000     C                             Q1GADCNT <> CYGADCNT OR
027400000000     C                             (Q1NOTE1 + Q1NOTE2) <> CYNOTE
027500000000     C                   IF        Q1SA <> *BLANKS AND
027600000000     C                             Q1SA <> *BLANKS AND
027700000000     C                             Q1SA <> *BLANKS
027800000000     C                   IF        FKEY = F10
027900000000     C                   EXSR      $Q1UPD
028000000000     C                   EVAL      @PROC = 'EXIT PRGRM'
028100000000     C                   LEAVESR
028200000000     C                   ELSE
028300000000     C                   EVAL      *IN50 = *ON
028400000000     C                   LEAVESR
028500000000     C                   ENDIF
028600000000     C                   ENDIF
028700000000     C                   ENDIF
028800000000    ***
028900140224     C                   IF        KF@SUPER <> Q1SA OR
029000140224     C                             KF@AGCY <> Q1AG OR
029100140224     C                             KF@SMAN <> Q1SM
029200140224     C                   EVAL      KF@SUPER = Q1SA
029300140224     C                   EVAL      KF@AGCY = Q1AG
029400140224     C                   EVAL      KF@SMAN = Q1SM
029500000000     C                   EVAL      @PROC = 'CHANGE CC '
029600000000     C                   LEAVESR
029700000000     C                   ENDIF
029800000000    ***
029900000000     C                   ENDSR
030000000000    ***S
030100000000    *** S3
030200000000     C     $SELECT       BEGSR
030300000000    ***
030400000000     C                   MOVE      P17           @17              17
030500000000     C                   CALL      'SLCPRS'
030600000000     C                   PARM                    @17
030700000000     C                   IF        %SUBST(@17:1:1) = 'X'
030800000000     C                   IF        QUESTN = 'A'
030900140224     C                   EVAL      @PROC = 'CHANGE CC '
031000000000     C                   ELSE
031100140224     C                   EVAL      @PROC = 'TRANSFERCC'
031200000000     C                   ENDIF
031300000000     C                   LEAVESR
031400000000     C                   ENDIF
031500000000    ***
031600000000     C                   IF        QUESTN = 'A'
031700140224     C                   EVAL      KF@SUPER = %SUBST(@17:9:3)
031800140224     C                   EVAL      KF@AGCY = %SUBST(@17:12:3)
031900140224     C                   EVAL      KF@SMAN = %SUBST(@17:15:3)
032000000000     C                   MOVEL     @17           HEF
032100140224     C                   EVAL      @PROC = 'FORMAT CHG'
032200000000     C                   LEAVESR
032300000000     C                   ENDIF
032400000000    ***
032500000000    3C                   IF        FKEY = F5
032600000000    3C                   EVAL      Q2FSA = %SUBST(@17:9:3)
032700000000    3C                   EVAL      Q2FAG = %SUBST(@17:12:3)
032800000000    3C                   EVAL      Q2FSM = %SUBST(@17:15:3)
032900000000     C                   MOVEL     @17           @8
033000000000     C                   MOVE      @8            Q2EFF
033100000000     C                   MULT      10000.0001    Q2EFF
033200000000     C                   ELSE
033300000000    3C                   EVAL      Q2TSA =  %SUBST(@17:9:3)
033400000000    3C                   EVAL      Q2TAG =  %SUBST(@17:12:3)
033500000000    3C                   EVAL      Q2TSM =  %SUBST(@17:15:3)
033600000000    3C                   ENDIF
033700000000    ***
033800000000     C                   EXSR      $Q2_FMT
033900140224     C                   EVAL      @PROC = 'TRANSFERCC'
034000000000    ***
034100000000     C                   ENDSR
034200000000    ***S
034300000000     C     $Q1FMTG       BEGSR
034400000000    ***
034500140224     C                   EXSR      $VSUPER
034600140224     C                   IF        VU = 'N'
034700140224     C                   EVAL      @Q = %TRIM(@50)
034800140224     C                   ENDIF
034900140224     C                   EVAL      Q1SAD = %TRIM(@50)
035000140224    ***
035100140224     C                   EXSR      $VAGENCY
035200140224     C                   IF        VA = 'N'
035300140224     C                   EVAL      @Q = %TRIM(@50)
035400140224     C                   ENDIF
035500140224     C                   EVAL      Q1AGD = %TRIM(@50)
035600000000    ***
035700140224     C                   EXSR      $VSMAN
035800140224     C                   IF        VS = 'N'
035900140224     C                   EVAL      @Q = %TRIM(@50)
036000140224     C                   ENDIF
036100140224     C                   EVAL      Q1SMD = %TRIM(@50)
036200140224    ***
036300140224     C                   ENDSR
036400140224    ***S
036500140224     C     $VSUPER       BEGSR
036600140224    ***
036700140224     C                   MOVE      *BLANKS       @50              50
036800140224     C                   MOVE      'N'           VU                1
036900140224    ***
037000140224     C     KF@SUPER      CHAIN     SAF
037100140224     C                   IF        NOT %FOUND(SUPRAGCY)
037200140224     C                   EVAL      @50 = 'INVALID SUPER AGENCY'
037300140224     C                   ELSE
037400140224     C                   EVAL      @50 = %TRIM(SANAME1)
037500140224     C                   MOVE      'Y'           VU
037600140224     C                   ENDIF
037700000000    ***
037800000000     C                   ENDSR
037900000000    ***S
038000140224     C     $VAGENCY      BEGSR
038100140224    ***
038200140224     C                   MOVE      *BLANKS       @50
038300140224     C                   MOVE      'N'           VA                1
038400140224    ***
038500140224     C     KF@AGCY       CHAIN     AGENR
038600140224     C                   IF        NOT %FOUND(AGENL4)
038700140224     C                   EVAL      @50 = 'INVALID AGENCY'
038800140224     C                   ELSE
038900140224     C                   EVAL      @50 = %TRIM(AGNAM1)
039000140224     C                   MOVE      'Y'           VA
039100140224     C                   ENDIF
039200140224    ***
039300140224     C                   ENDSR
039400140224    ***S
039500140224     C     $VSMAN        BEGSR
039600140224    ***
039700140224     C                   MOVE      *BLANKS       @50
039800140224     C                   MOVE      'N'           VS                1
039900140224    ***
040000140224     C     KF@SMAN       CHAIN     SMANR
040100140225     C                   IF        NOT %FOUND(SMANUNIQUE)
040200140224     C                   EVAL      @50 = 'INVALID SMAN CODE'
040300140224     C                   LEAVESR
040400140224     C                   ENDIF
040500140224    ***
040600140225     C                   EXSR      $GETSNAME
040700140224    ***
040800140224     C                   EVAL      @50 = %TRIM(A@40)
040900140224     C                   MOVE      'Y'           VS
041000140225    ***
041100140225     C                   ENDSR
041200140225    ***S
041300140225     C     $GETSNAME     BEGSR
041400140225    ***
041500140225     C                   CLEAR                   A@20             20
041600140225     C                   CLEAR                   A@40             40
041700140225    ***
041800140225     C                   IF        SFNAME <> *BLANKS
041900140225     C                   MOVEL     SFNAME        A@20
042000140225     C                   EXSR      $LDADDR
042100140225     C                   ENDIF
042200140225    ***
042300140225     C                   IF        SMI <> *BLANKS
042400140225     C                   MOVEL     SMI           A@20
042500140225     C                   EXSR      $LDADDR
042600140225     C                   ENDIF
042700140225    ***
042800140225     C                   IF        SLNAME <> *BLANKS
042900140225     C                   MOVEL     SLNAME        A@20
043000140225     C                   EXSR      $LDADDR
043100140225     C                   ENDIF
043200140224    ***
043300140224     C                   ENDSR
043400140224    ***S
043500140224     C     $LDADDR       BEGSR
043600140224    ***
043700140224     C                   EVAL      A@20 = %TRIM(A@20)
043800140224     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
043900140224     C                   CLEAR                   A@20
044000140224    ***
044100140224     C                   ENDSR
044200140224    ***S
044300000000     C     $Q1UPD        BEGSR
044400000000    ***
044500000000     C     KL#           CHAIN     CFEOYCCR
044600000000    ***
044700000000     C                   EVAL      CYADCNT = Q1ADCNT
044800000000     C                   EVAL      CYDBCNT = Q1DBCNT
044900000000     C                   EVAL      CYGACNT = Q1GACNT
045000000000     C                   EVAL      CYPHCNT = Q1PHCNT
045100000000     C                   EVAL      CYNACNT = Q1NACNT
045200000000     C                   EVAL      CYNOTE = Q1NOTE1 + Q1NOTE2
045300000000     C                   EVAL      CYADDCNT = Q1ADDCNT
045400000000     C                   EVAL      CYDBDCNT = Q1DBDCNT
045500000000     C                   EVAL      CYGADCNT = Q1GADCNT
045600000000     C                   EVAL      CYNADCNT = Q1NADCNT
045700000000    ***
045800000000     C                   UPDATE    CFEOYCCR
045900000000    ***
046000000000     C                   CLEAR                   QSTN1
046100000000    ***
046200000000     C                   EVAL      *IN50 = *OFF
046300140224     C                   EVAL      @PROC = 'CHANGE CC '
046400140224     C                   EVAL      KF@SUPER = *BLANKS
046500140224     C                   EVAL      KF@AGCY = *BLANKS
046600140224     C                   EVAL      KF@SMAN = *BLANKS
046700000000    ***
046800000000     C                   ENDSR
046900000000    ***S
047000000000    *** S6
047100000000     C     $TRANSFER     BEGSR
047200000000    ***
047300000000     C                   EVAL      Q2MSG = @Q
047400000000     C                   EVAL      Q2CARR = ECARR
047500000000     C                   EVAL      Q2NAME = ENAME
047600000000     C                   EXFMT     QSTN2
047700000000     C                   EVAL      @Q = *BLANKS
047800000000     C                   EVAL      *IN51 = *OFF
047900000000    ***
048000000000     C                   IF        FKEY = F12
048100140224     C                   EVAL      @PROC = 'QUESTION  '
048200000000     C                   LEAVESR
048300000000     C                   ENDIF
048400000000    ***
048500000000     C                   IF        FKEY = F6
048600000000     C                   EVAL      @PROC = 'SELECTION '
048700000000     C                   LEAVESR
048800000000     C                   ENDIF
048900000000    ***
049000000000     C                   EXSR      $Q2_FMT
049100000000    ***
049200000000     C                   EXSR      $ERR_CHK
049300000000     C                   IF        @Q <> *BLANKS
049400000000     C                   LEAVESR
049500000000     C                   ENDIF
049600000000    ***
049700000000     C                   IF        Q2TAG <> *BLANKS AND
049800000000     C                             Q2TSA <> *BLANKS AND Q2TSM <> *BLANKS
049900000000     C                   EVAL      *IN51 = *ON
050000000000     C                   ENDIF
050100000000    ***
050200000000     C                   IF        FKEY = F10 AND *IN51 = *ON
050300140224     C                   EVAL      @PROC = 'TFR AMOUNT'
050400000000     C                   LEAVESR
050500000000     C                   ENDIF
050600000000    ***
050700000000     C                   ENDSR
050800000000    ***S
050900000000     C     $ERR_CHK      BEGSR
051000000000    ***
051100000000     C                   MOVE      Q2EFF         @8                8
051200000000     C                   IF        %SUBST(@8:1:4) <> '1231' OR Q2EFF = 0
051300000000     C                   EVAL      @Q = 'THE EFFECTIVE DATE IS INVALID.'
051400000000     C                   LEAVESR
051500000000     C                   ENDIF
051600000000    ***
051700000000     C                   IF        Q2FSA = *BLANKS OR Q2FSAD = '**UNKNOWN**'
051800000000     C                   EVAL      @Q = 'THE REPORTED SUPER AGENCY INVALID.'
051900000000     C                   LEAVESR
052000000000     C                   ENDIF
052100000000    ***
052200000000     C                   IF        Q2TSA = *BLANKS OR Q2TSAD = '**UNKNOWN**'
052300000000     C                   EVAL      @Q = 'THE TRANSFER SUPER AGENCY INVALID.'
052400000000     C                   LEAVESR
052500000000     C                   ENDIF
052600000000    ***
052700000000     C                   IF        Q2FAG = *BLANKS OR Q2FAGD = '**UNKNOWN**'
052800000000     C                   EVAL      @Q = 'THE REPORTED AGENCY INVALID.'
052900000000     C                   LEAVESR
053000000000     C                   ENDIF
053100000000    ***
053200000000     C                   IF        Q2TAG = *BLANKS OR Q2TAGD = '**UNKNOWN**'
053300000000     C                   EVAL      @Q = 'THE TRANSFER AGENCY INVALID.'
053400000000     C                   LEAVESR
053500000000     C                   ENDIF
053600000000    ***
053700000000     C                   IF        Q2FSM = *BLANKS OR Q2FSMD = '**UNKNOWN**'
053800000000     C                   EVAL      @Q = 'THE REPORTED SALESMAN CODE INVALID.'
053900000000     C                   LEAVESR
054000000000     C                   ENDIF
054100000000    ***
054200000000     C                   IF        Q2TSM = *BLANKS OR Q2TSMD = '**UNKNOWN**'
054300000000     C                   EVAL      @Q = 'THE TRANSFER SALESMAN CODE INVALID.'
054400000000     C                   LEAVESR
054500000000     C                   ENDIF
054600000000    ***
054700000000     C                   IF        Q2FSA = Q2TSA AND Q2FAG = Q2TAG AND
054800000000     C                             Q2FSM = Q2TSM
054900000000     C                   EVAL      @Q = 'CANNOT TRANSFER TO SELF.'
055000000000     C                   LEAVESR
055100000000     C                   ENDIF
055200000000    ***
055300000000     C                   MOVE      *BLANKS       @P9               9
055400000000     C                   MOVE      *BLANKS       @P1               1
055500000000     C                   EVAL      @P9 = Q2TSA + Q2TAG + Q2TSM
055600000000     C                   EVAL      @P1 = 'N'
055700000000     C                   CALL      'RPR'
055800000000     C                   PARM                    @P9
055900000000     C                   PARM                    @P1
056000000000     C                   IF        @P1 = 'N'
056100000000     C                   EVAL      @Q = 'INVALID RELATIONSHIP, RETYPE SAS TRA' +
056200000000     C                             'NSFER TO.'
056300000000     C                   LEAVESR
056400000000     C                   ENDIF
056500000000    ***
056600000000     C                   IF        Q2ADCNT < 0
056700000000     C                   EVAL      @Q = 'ADMIN MED COUNT CANNOT BE BELOW ZERO.'
056800000000     C                   LEAVESR
056900000000     C                   ENDIF
057000000000    ***
057100000000     C                   IF        Q2DBCNT < 0
057200000000     C                   EVAL      @Q = 'DBE MED COUNT CANNOT BE BELOW ZERO.'
057300000000     C                   LEAVESR
057400000000     C                   ENDIF
057500000000    ***
057600000000     C                   IF        Q2GACNT < 0
057700000000     C                   EVAL      @Q = 'GAS MED COUNT CANNOT BE BELOW ZERO.'
057800000000     C                   LEAVESR
057900000000     C                   ENDIF
058000000000    ***
058100000000     C                   IF        Q2PHCNT < 0
058200000000     C                   EVAL      @Q = 'PHN MED COUNT CANNOT BE BELOW ZERO.'
058300000000     C                   LEAVESR
058400000000     C                   ENDIF
058500000000    ***
058600000000     C                   IF        Q2NACNT < 0
058700000000     C                   EVAL      @Q = 'NASCO MED COUNT CANNOT BE BELOW ZERO.'
058800000000     C                   LEAVESR
058900000000     C                   ENDIF
059000000000    ***
059100000000     C                   IF        Q2ADDCNT < 0
059200000000     C                   EVAL      @Q = 'ADMIN DEN COUNT CANNOT BE BELOW ZERO.'
059300000000     C                   LEAVESR
059400000000     C                   ENDIF
059500000000    ***
059600000000     C                   IF        Q2DBDCNT < 0
059700000000     C                   EVAL      @Q = 'DBE DEN COUNT CANNOT BE BELOW ZERO.'
059800000000     C                   LEAVESR
059900000000     C                   ENDIF
060000000000    ***
060100000000     C                   IF        Q2GADCNT < 0
060200000000     C                   EVAL      @Q = 'GAS DEN COUNT CANNOT BE BELOW ZERO.'
060300000000     C                   LEAVESR
060400000000     C                   ENDIF
060500000000    ***
060600000000     C                   IF        Q2NADCNT < 0
060700000000     C                   EVAL      @Q = 'NASCO DEN COUNT CANNOT BE BELOW ZERO.'
060800000000     C                   LEAVESR
060900000000     C                   ENDIF
061000000000    ***
061100000000     C                   ENDSR
061200000000    ***S
061300140224    *** 7
061400140224     C     $PROMPT       BEGSR
061500000000    ***
061600000000     C                   MOVEL(P)  'LOAD'        WWRQS             8
061700000000    ***
061800000000     C                   SELECT
061900000000    * *
062000000000     C                   WHEN      WSFLD = 'Q2FSA' OR WSFLD = 'Q2FAG' OR
062100000000     C                             WSFLD = 'Q2FSM' OR WSFLD = 'Q2EFF'
062200000000     C                   EVAL      @Q = 'ONLY PROMPT EXISTING MAY BE USED HERE.'
062300140224     C                   EVAL      @PROC = 'TRANSFERCC'
062400000000     C                   LEAVESR
062500000000    * *
062600000000     C                   WHEN      WSFLD = 'Q2TSA'
062700000000     C                   CALL      'SLCSUPER'                                   *ENTRY LIST
062800000000     C                   PARM                    WWRQS                          PROGRAM REQUEST
062900000000     C                   PARM                    WWRTN             8            RETURN CODE
063000000000     C                   PARM                    WUPGM            10            LAST PGM NAME
063100000000     C                   PARM                    WADTA                          RECORD DS
063200000000     C                   IF        WWRTN = *BLANKS
063300000000     C                   EVAL      Q2TSA = SACODE
063400000000     C                   MOVEL(P)  SANAME1       Q2TSAD
063500000000     C                   ENDIF
063600000000      *
063700000000     C                   WHEN      WSFLD = 'Q2TAG'
063800000000     C                   CALL      'SLCAGNY'                                    *ENTRY LIST
063900000000     C                   PARM                    WWRQS                          PROGRAM REQUEST
064000000000     C                   PARM                    WWRTN                          RETURN CODE
064100000000     C                   PARM                    WUPGM                          LAST PGM NAME
064200000000     C                   PARM                    WBDTA                          RECORD DS
064300000000     C                   IF        WWRTN = *BLANKS
064400000000     C                   EVAL      Q2TAG = AGCODE
064500000000     C                   MOVEL(P)  AGNAM1        Q2TAGD
064600000000     C                   ENDIF
064700000000      *
064800000000     C                   WHEN      WSFLD = 'Q2TSM'
064900000000     C                   CALL      'SLCSMAN'                                    *ENTRY LIST
065000000000     C                   PARM                    WWRQS                          PROGRAM REQUEST
065100000000     C                   PARM                    WWRTN                          RETURN CODE
065200000000     C                   PARM                    WUPGM                          LAST PGM NAME
065300000000     C                   PARM                    WCDTA                          RECORD DS
065400000000     C                   IF        WWRTN = *BLANKS
065500000000     C                   EVAL      Q2TSM = SMANCD
065600000000     C                   EXSR      $GETSNAME
065700000000     C                   MOVEL(P)  A@40          Q2TSMD
065800000000     C                   ENDIF
065900000000      *
066000000000     C                   OTHER
066100000000     C                   EVAL      @Q = 'THE CURSOR IS NOT IN A PROMPT AREA.'
066200000000     C                   ENDSL
066300000000    ***
066400140224     C                   EVAL      @PROC = 'TRANSFERCC'
066500000000    ***
066600000000     C                   ENDSR
066700000000    ***S
066800000000     C     $Q2_FMT       BEGSR
066900140224    ***
067000140224     C                   EVAL      KF@SUPER = Q2FSA
067100140224     C                   EXSR      $VSUPER
067200140224     C                   IF        VU = 'N'
067300140224     C                   EVAL      @Q = %TRIM(@50)
067400140224     C                   ENDIF
067500140224     C                   EVAL      Q2FSAD = %TRIM(@50)
067600140224    ***
067700140224     C                   EVAL      KF@SUPER = Q2TSA
067800140224     C                   EXSR      $VSUPER
067900140224     C                   IF        VU = 'N'
068000140224     C                   EVAL      @Q = %TRIM(@50)
068100140224     C                   ENDIF
068200140224     C                   EVAL      Q2TSAD = %TRIM(@50)
068300000000    ***
068400140224     C                   EVAL      KF@AGCY = Q2FAG
068500140224     C                   EXSR      $VAGENCY
068600140224     C                   IF        VA = 'N'
068700140224     C                   EVAL      @Q = %TRIM(@50)
068800140224     C                   ENDIF
068900140224     C                   EVAL      Q2FAGD = %TRIM(@50)
069000140224    ***
069100140224     C                   EVAL      KF@AGCY = Q2TAG
069200140224     C                   EXSR      $VAGENCY
069300140224     C                   IF        VA = 'N'
069400140224     C                   EVAL      @Q = %TRIM(@50)
069500140224     C                   ENDIF
069600140224     C                   EVAL      Q2TAGD = %TRIM(@50)
069700000000    ***
069800140224     C                   EVAL      KF@SMAN = Q2FSM
069900140224     C                   EXSR      $VSMAN
070000140224     C                   IF        VS = 'N'
070100140224     C                   EVAL      @Q = %TRIM(@50)
070200140224     C                   ENDIF
070300140224     C                   EVAL      Q2FSMD = %TRIM(@50)
070400000000    ***
070500140224     C                   EVAL      KF@SMAN = Q2TSM
070600140224     C                   EXSR      $VSMAN
070700140224     C                   IF        VS = 'N'
070800140224     C                   EVAL      @Q = %TRIM(@50)
070900140224     C                   ENDIF
071000140224     C                   EVAL      Q2TSMD = %TRIM(@50)
071100000000    ***
071200000000     C                   ENDSR
071300000000    ***S
071400140224     ** 8
071500140224     C     $TFRCTL       BEGSR
071600000000    ***
071700000000     C     Q2EFF         MULT      10000.0001    K#DATE            8 0
071800000000    ***
071900000000     C     KL#F          KLIST
072000000000     C                   KFLD                    K#DATE
072100000000     C                   KFLD                    Q2FSA
072200000000     C                   KFLD                    Q2FAG
072300000000     C                   KFLD                    Q2FSM
072400000000    ***
072500000000     C     KL#F          CHAIN     CFEOYCCR
072600000000     C                   IF        NOT %FOUND(XXEOYCC)
072700000000     C     'ERROR'       DSPLY     '*EXT'
072800000000     C                   ENDIF
072900000000    ***
073000000000     C                   SUB       Q2ADCNT       CYADCNT
073100000000     C                   SUB       Q2DBCNT       CYDBCNT
073200000000     C                   SUB       Q2GACNT       CYGACNT
073300000000     C                   SUB       Q2NACNT       CYNACNT
073400000000     C                   SUB       Q2PHCNT       CYPHCNT
073500000000     C                   SUB       Q2ADDCNT      CYADDCNT
073600000000     C                   SUB       Q2DBDCNT      CYDBDCNT
073700000000     C                   SUB       Q2GADCNT      CYGADCNT
073800000000     C                   SUB       Q2NADCNT      CYNADCNT
073900000000    ***
074000000000     C                   EVAL      CYNOTE = Q2NOTE1 + Q2NOTE2
074100000000    ***
074200000000     C                   EVAL      CYTOSA = Q2TSA
074300000000     C                   EVAL      CYTOAG = Q2TAG
074400000000     C                   EVAL      CYTOSM = Q2TSM
074500000000    ***
074600000000     C                   UPDATE    CFEOYCCR
074700000000    ***
074800000000     C     KL#T          KLIST
074900000000     C                   KFLD                    K#DATE
075000000000     C                   KFLD                    Q2TSA
075100000000     C                   KFLD                    Q2TAG
075200000000     C                   KFLD                    Q2TSM
075300000000    ***
075400000000     C     KL#T          CHAIN     CFEOYCCR
075500000000     C                   IF        NOT %FOUND(XXEOYCC)
075600000000     C                   CLEAR                   CFEOYCCR
075700000000     C                   MOVE      K#DATE        CYEFF
075800000000     C                   EVAL      CYSA = Q2TSA
075900000000     C                   EVAL      CYAG = Q2TAG
076000000000     C                   EVAL      CYSM = Q2TSM
076100000000     C                   ENDIF
076200000000    ***
076300000000     C                   ADD       Q2ADCNT       CYADCNT
076400000000     C                   ADD       Q2DBCNT       CYDBCNT
076500000000     C                   ADD       Q2GACNT       CYGACNT
076600000000     C                   ADD       Q2NACNT       CYNACNT
076700000000     C                   ADD       Q2PHCNT       CYPHCNT
076800000000     C                   ADD       Q2ADDCNT      CYADDCNT
076900000000     C                   ADD       Q2DBDCNT      CYDBDCNT
077000000000     C                   ADD       Q2GADCNT      CYGADCNT
077100000000     C                   ADD       Q2NADCNT      CYNADCNT
077200140225     C                   EVAL      CYNOTE = Q2NOTE1 + Q2NOTE2
077300000000    ***
077400000000     C                   IF        NOT %FOUND(XXEOYCC)
077500000000     C                   WRITE     CFEOYCCR
077600000000     C                   ELSE
077700000000     C                   UPDATE    CFEOYCCR
077800000000     C                   ENDIF
077900000000    ***
078000000000     C                   CLEAR                   QSTN2
078100000000     C                   EVAL      @Q = *BLANKS
078200140224     C                   EVAL      KF@SUPER = *BLANKS
078300140224     C                   EVAL      KF@AGCY = *BLANKS
078400140224     C                   EVAL      KF@SMAN = *BLANKS
078500000000     C                   MOVEL     @17           HEF
078600000000     C                   EVAL      @PROC = 'EXIT PRGRM'
078700000000    ***
078800000000     C                   ENDSR
078900000000    ***S
079000140224     C     $ADDPREP      BEGSR
079100140224    ***
079200140224     C                   EVAL      @PROC = 'ADD CONTRL'
079300140224    ***
079400140224     C                   CLEAR                   QSTN3
079500140224    ***
079600140224     C                   EVAL      Q3CARR = ECARR
079700140224     C                   EVAL      Q3NAME = ENAME
079800140224     C                   EVAL      Q3EFF = #WORKPRD
079900140224    ***
080000140224    ***
080100140224    ***
080200140224     C                   ENDSR
080300140224    ***S
080400140224     C     $ADDCTL       BEGSR
080500140224    ***
080600140224     C                   EVAL      Q3MSG = @Q
080700140224     C                   EXFMT     QSTN3
080800140224     C                   EVAL      @Q = *BLANKS
080900140224     C                   EVAL      *IN51 = *OFF
081000140224    ***
081100140224     C                   IF        FKEY = F12
081200140224     C                   EVAL      @PROC = 'QUESTION  '
081300140224     C                   LEAVESR
081400140224     C                   ENDIF
081500140224    ***
081600140224     C                   EXSR      $Q3VALID
081700140224    ***
081800140224     C                   IF        @Q3VAL = 'ERR'
081900140224     C                   LEAVESR
082000140224     C                   ENDIF
082100140224    ***
082200140224     C                   IF        FKEY = F10 AND *IN51 = *ON
082300140224     C                   EVAL      @PROC = 'ADD CNTRCT'
082400140224     C                   CLEAR                   CFEOYCCR
082500140224     C                   MOVE      HEF           CYEFF
082600140224     C                   EVAL      CYSA = KF@SUPER
082700140224     C                   EVAL      CYAG = KF@AGCY
082800140224     C                   EVAL      CYSM = KF@SMAN
082900140225     C                   EVAL      CYNOTE = Q3NOTE1 + Q3NOTE2
083000140224     C                   ADD       Q3ADCNT       CYADCNT
083100140224     C                   ADD       Q3DBCNT       CYDBCNT
083200140224     C                   ADD       Q3GACNT       CYGACNT
083300140224     C                   ADD       Q3NACNT       CYNACNT
083400140224     C                   ADD       Q3PHCNT       CYPHCNT
083500140224     C                   ADD       Q3ADDCNT      CYADDCNT
083600140224     C                   ADD       Q3DBDCNT      CYDBDCNT
083700140224     C                   ADD       Q3GADCNT      CYGADCNT
083800140224     C                   ADD       Q3NADCNT      CYNADCNT
083900140224     C                   WRITE     CFEOYCCR
084000140224     C                   LEAVESR
084100140224     C                   ENDIF
084200140224    ***
084300140224     C                   ENDSR
084400140224    ***S
084500140224     C     $Q3VALID      BEGSR
084600140224    ***
084700140224     C                   MOVE      'ERR'         @Q3VAL            3
084800140224    ***
084900140224     C                   EVAL      KF@SUPER = Q3SUPER
085000140224     C                   EXSR      $VSUPER
085100140224     C                   IF        VU = 'N'
085200140224     C                   EVAL      @Q = @50
085300140224     C                   LEAVESR
085400140224     C                   ELSE
085500140224     C                   EVAL      Q3SUPERD = %TRIM(@50)
085600140224     C                   ENDIF
085700140224    ***
085800140224     C                   EVAL      KF@AGCY = Q3AGCY
085900140224     C                   EXSR      $VAGENCY
086000140224     C                   IF        VA = 'N'
086100140224     C                   EVAL      @Q = @50
086200140224     C                   LEAVESR
086300140224     C                   ELSE
086400140224     C                   EVAL      Q3AGCYD = %TRIM(@50)
086500140224     C                   ENDIF
086600140224    ***
086700140224     C                   EVAL      KF@SMAN = Q3SMAN
086800140224     C                   EXSR      $VSMAN
086900140224     C                   IF        VS = 'N'
087000140224     C                   EVAL      @Q = @50
087100140224     C                   LEAVESR
087200140224     C                   ELSE
087300140224     C                   EVAL      Q3SMAND = %TRIM(@50)
087400140224     C                   ENDIF
087500140224    ***
087600140224     C                   IF        Q3ADCNT = 0 AND Q3ADDCNT = 0 AND
087700140224     C                             Q3DBCNT = 0 AND Q3DBDCNT = 0 AND
087800140224     C                             Q3GACNT = 0 AND Q3GADCNT = 0 AND
087900140224     C                             Q3PHCNT = 0 AND
088000140224     C                             Q3NACNT = 0 AND Q3NADCNT = 0
088100140224     C                   EVAL      @Q = 'YOU HAVE TO ENTER UNITS SOMEWHERE'
088200140224     C                   LEAVESR
088300140224     C                   ENDIF
088400140224    ***
088500140224     C                   MOVE      #YEAR         HEF
088600140224    ***
088700140224     C     KL#           CHAIN(N)  CFEOYCCR
088800140224     C                   IF        %FOUND(XXEOYCC)
088900140224     C                   EVAL      @Q = 'RECORD EXISTS, USE CHANGE OPTION'
089000140224     C                   LEAVESR
089100140224     C                   ENDIF
089200140224    ***
089300140224     C                   MOVE      'YES'         @Q3VAL
089400140224     C                   EVAL      *IN51 = *ON
089500140224    ***
089600140224     C                   ENDSR
089700140224    ***S
