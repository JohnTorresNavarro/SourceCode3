000100140918    *** EVERGREEN PLAN MAPPING
000200140918    *** CARRIER EXPORT # 114
000300140918    *** SSK  09/18/2014
000400140918    ***
000500140918    ***
000600140918    ***
000700140918     FEVRG11D   CF   E             WORKSTN INFDS(WSDS) SFILE(S01SFL:RR1)
000800140918     FCARPLNP   UF A E           K DISK
000900140918     FCARPLNX   IF   E           K DISK    RENAME(CARPLNR:CPL2) PREFIX(ZZ:2)
001000140918     FCOMCTUNIQ IF   E           K DISK
001100140918     FTRMUNIQUE IF   E           K DISK
001200140918     FSUMUNIQUE IF   E           K DISK
001300140918     FACMUNIQUE IF   E           K DISK
001400140918     FPLNUNIQUE IF   E           K DISK
001500140918     FEVRG12WF  UF A E           K DISK
001600140918   X***X
001700140918     D HLD@NAME        S             40A
001800140918     D @EMSG           S                   LIKE(EMSG)
001900140918     D PRV#TRS         S                   LIKE(I_TRST)
002000140918     D PRV#SUB         S                   LIKE(I_SUB#)
002100140918     D PRV#ACC         S                   LIKE(I_ACCT)
002200140918     D PRV#PLN         S                   LIKE(I_PLAN)
002300140918     D ADD_MODE        S               N   INZ(*OFF)
002400140918     D VALID_REC       S               N   INZ(*OFF)
002500140918     D YES             S               N   INZ(*ON)
002600140918     D NO              S               N   INZ(*OFF)
002700140918    ***
002800140918     D WSDS            DS
002900140918     D  FKEY                 369    369A
003000140918    ***
003100140918     D  F1             C                   CONST(X'31')
003200140918     D  F2             C                   CONST(X'32')
003300140918     D  F3             C                   CONST(X'33')
003400140918     D  F4             C                   CONST(X'34')
003500140918     D  F5             C                   CONST(X'35')
003600140918     D  F6             C                   CONST(X'36')
003700140918     D  F7             C                   CONST(X'37')
003800140918     D  F8             C                   CONST(X'38')
003900140918     D  F9             C                   CONST(X'39')
004000140918     D  F10            C                   CONST(X'3A')
004100140918     D  F11            C                   CONST(X'3B')
004200140918     D  F12            C                   CONST(X'3C')
004300140918     D  F13            C                   CONST(X'B1')
004400140918     D  F14            C                   CONST(X'B2')
004500140918     D  F15            C                   CONST(X'B3')
004600140918     D  F16            C                   CONST(X'B4')
004700140918     D  F17            C                   CONST(X'B5')
004800140918     D  F18            C                   CONST(X'B6')
004900140918     D  F19            C                   CONST(X'B7')
005000140918     D  F20            C                   CONST(X'B8')
005100140918     D  F21            C                   CONST(X'B9')
005200140918     D  F22            C                   CONST(X'BA')
005300140918     D  F23            C                   CONST(X'BB')
005400140918     D  F24            C                   CONST(X'BC')
005500140918    ***
005600140918     D                UDS
005700140918     D  XONAME               201    240
005800140918    ***
005900140918     D KF@RET          S                   LIKE(CPUNIQ)
006000140918     D                                     INZ('9000000114')
006100140918     D KF@UNIQ         S                   LIKE(CPUNIQ)
006200140918     D                                     INZ('0000000114')
006300140918     D KF@TRS          S                   LIKE(CPTRST)
006400140918     D KF@SUB          S                   LIKE(CPSUB#)
006500140918     D KF@ACC          S                   LIKE(CPACCT)
006600140918     D KF@PLN          S                   LIKE(CPPLAN)
006700140918     D KF@CCTR         S                   LIKE(CPCCTR)
006800140918     D KF@MAP          S                   LIKE(AE1MAP)
006900140918    ***
007000140918     D @PROC           S             10A
007100140918    ***
007200140918     D                 DS
007300140918     D @BREAK                 01     11A
007400140918     D  ET                    01     03S 0
007500140918     D  ES                    04     06S 0
007600140918     D  EA                    07     10S 0
007700140918   X***X
007800140918    ***
007900140918     C     *ENTRY        PLIST
008000140918     C                   PARM                    @ENTRY           11
008100140918    ***
008200140918     C                   CLEAR                   S02PLAN
008300140918     C                   EVAL      @BREAK = @ENTRY
008400140918     C                   EVAL      KF@TRS = ET
008500140918     C                   EVAL      KF@SUB = ES
008600140918     C                   EVAL      KF@ACC = EA
008700140918    ***
008800140918     C                   DOU       @PROC = 'EXIT APP  '
008900140918     C     @PROC         CASEQ     'PREP SFL  '  $PREPSFL
009000140918     C     @PROC         CASEQ     'BUILD SFL '  $BLDSFL
009100140918     C     @PROC         CASEQ     'SFL CONTRL'  $SFLCTL
009200140918     C     @PROC         CASEQ     'ADD PLAN  '  $ADDPLAN
009300140918     C     @PROC         CASEQ     'CHECK SELC'  $CHKSELC
009400140918     C                   ENDCS
009500140918     C                   ENDDO
009600140918     C*
009700140918     C                   MOVE      *ON           *INLR
009800140918     C*
009900140918   S***S
010000140918     C     *INZSR        BEGSR
010100140918    ***
010200140918     C                   EVAL      @PROC = 'PREP SFL  '
010300140918    ***
010400140918     C     KL#TS         KLIST
010500140918     C                   KFLD                    KF@TRS
010600140918     C                   KFLD                    KF@SUB
010700140918    ***
010800140918     C     KL#TSA        KLIST
010900140918     C                   KFLD                    KF@TRS
011000140918     C                   KFLD                    KF@SUB
011100140918     C                   KFLD                    KF@ACC
011200140918    ***
011300140918     C     KL#TSAP       KLIST
011400140918     C                   KFLD                    KF@TRS
011500140918     C                   KFLD                    KF@SUB
011600140918     C                   KFLD                    KF@ACC
011700140918     C                   KFLD                    KF@PLN
011800140918    ***
011900140918     C                   EVAL      HLD@NAME = XONAME
012000140918    ***
012100140918     C     KL#TSP        KLIST
012200140918     C                   KFLD                    KF@TRS
012300140918     C                   KFLD                    KF@SUB
012400140918     C                   KFLD                    KF@PLN
012500140918    ***
012600140918     C     KL#RTSACP     KLIST
012700140918     C                   KFLD                    KF@RET
012800140918     C                   KFLD                    KF@TRS
012900140918     C                   KFLD                    KF@SUB
013000140918     C                   KFLD                    KF@ACC
013100140918     C                   KFLD                    KF@CCTR
013200140918     C                   KFLD                    KF@PLN
013300140918    ***
013400140918     C     KL#UTSACP     KLIST
013500140918     C                   KFLD                    KF@UNIQ
013600140918     C                   KFLD                    KF@TRS
013700140918     C                   KFLD                    KF@SUB
013800140918     C                   KFLD                    KF@ACC
013900140918     C                   KFLD                    KF@CCTR
014000140918     C                   KFLD                    KF@PLN
014100140918    ***
014200140918     C                   ENDSR
014300140918   S***S
014400140918     C     $PREPSFL      BEGSR
014500140918    ***
014600140918     C                   MOVE      *ZEROS        RR1               4 0
014700140918     C                   MOVE      *ZEROS        #CNTREC           4 0
014800140918    ***
014900140918     C                   EVAL      *IN39 = *OFF
015000140918     C                   EVAL      *IN40 = *OFF
015100140918    ***
015200140918     C                   EVAL      @PROC = 'BUILD SFL '
015300140918    ***
015400140918     C                   ENDSR
015500140918   S***S
015600140918     C* INITIALIZE THE SUBFILE
015700140918    ***
015800140918     C     $CLRSFL       BEGSR
015900140918    ***
016000140918     C                   MOVEA     '011'         *IN(25)
016100140918     C                   WRITE     S01CTL
016200140918     C                   MOVEA     '010'         *IN(25)
016300140918     C                   Z-ADD     *ZERO         RR1
016400140918    ***
016500140918     C                   ENDSR
016600140918   S***S
016700140918     C     $BLDSFL       BEGSR
016800140918    ***
016900140918     C                   MOVE      *ZEROS        #CNTREC
017000140918     C                   MOVE      '0'           @1STLOOP          1
017100140918     C                   MOVE      '0'           @SFLOOP           1
017200140918     C                   MOVE      '0'           *IN20
017300140918    ***
017400140918     C                   EVAL      I_TRST = ET
017500140918     C                   EVAL      I_SUB# = ES
017600140918     C                   EVAL      I_ACCT = EA
017700140918    ***
017800140918     C                   EVAL      KF@PLN = I_PLAN
017900140918    ***
018000140918     C                   EXSR      $CLRSFL
018100140918     C                   EVAL      CONAME = HLD@NAME
018200140918     C     KL#TSA        CHAIN     ACCMSR
018300140918     C                   IF        NOT %FOUND(ACMUNIQUE)
018400140918     C                   EVAL      D_ACCNAME = '**ERROR**'
018500140918     C                   ELSE
018600140918     C                   EVAL      D_ACCNAME = ACNAM1
018700140918     C                   ENDIF
018800140918    ***
018900140918     C     KL#TSAP       SETLL     CPL2
019000140918    1C                   DOU       %EOF(CARPLNX)
019100140918     C     KL#TSA        READE     CPL2
019200140918    2C                   IF        NOT %EOF(CARPLNX) AND
019300140918     C                             (ZZUNIQ = KF@UNIQ OR
019400140918     C                              ZZUNIQ = KF@RET)
019500140918     C                   EXSR      $LOADSFL
019600140918    2C                   ENDIF
019700140918    1C                   ENDDO
019800140918    ***
019900140918     C                   EVAL      @PROC = 'SFL CONTRL'
020000140918    ***
020100140918     C                   ENDSR
020200140918   S***S
020300140918     C     $LOADSFL      BEGSR
020400140918    ***
020500140918     C                   MOVE      *ON           *IN25
020600140918     C                   MOVE      *BLANKS       SEL
020700140918    ***
020800140918     C                   EVAL      HUNIQ = ZZUNIQ
020900140918     C                   IF        ZZUNIQ = KF@UNIQ
021000140918     C                   EVAL      SFSTATUS = 'ACTIVE'
021100140918     C                   ELSE
021200140918     C                   EVAL      SFSTATUS = '*RETIRE*'
021300140918     C                   ENDIF
021400140918    ***
021500140918     C                   EVAL      SFCCTR = ZZCCTR
021600140918     C                   EVAL      SFPLAN = ZZPLAN
021700140918    ***
021800140918     C                   EVAL      KF@CCTR = ZZCCTR
021900140918     C                   EVAL      KF@PLN  = ZZPLAN
022000140918    ***
022100140918     C     KL#TSAP       CHAIN     AEF01
022200140918     C                   IF        NOT %FOUND(EVRG12WF)
022300140918     C                   EVAL      SFMAP = '**ERROR**'
022400140918     C                   ELSE
022500140918     C                   EVAL      SFMAP = AE1MAP
022600140918     C                   ENDIF
022700140918    ***
022800140918     C     KL#TSP        CHAIN     PLNMSR
022900140918     C                   IF        NOT %FOUND(PLNUNIQUE)
023000140918     C                   EVAL      SFPNAME = '**ERROR**'
023100140918     C                   ELSE
023200140918     C                   EVAL      SFPNAME= %TRIM(PDESCR)
023300140918     C                   ENDIF
023400140918    ***
023500140918     C                   ADD       1             RR1
023600140918     C*
023700140918    1C                   IF        @1STLOOP = '0'
023800140918     C                   Z-ADD     RR1           SFLPOS
023900140918     C                   MOVE      '1'           @1STLOOP
024000140918    1C                   ENDIF
024100140918     C*
024200140918     C                   WRITE     S01SFL
024300140918     C*
024400140918     C                   ADD       1             #CNTREC
024500140918    1C                   IF        #CNTREC = 500
024600140918     C                   MOVE      '1'           @SFLOOP
024700140918    1C                   ENDIF
024800140918    ***
024900140918     C                   ENDSR
025000140918   S***S
025100140918     C     $SFLCTL       BEGSR
025200140918    ***
025300140918     C                   EVAL      EMSG = @EMSG
025400140918    ***
025500140918     C                   WRITE     S01REC
025600140918     C                   EXFMT     S01CTL
025700140918    ***
025800140918     C                   MOVE      *BLANKS       EMSG
025900140918     C                   MOVE      *BLANKS       @EMSG
026000140918    ***
026100140918     C                   IF        FKEY = F3
026200140918     C                   EVAL      @PROC = 'EXIT APP  '
026300140918     C                   LEAVESR
026400140918     C                   ENDIF
026500140918    ***
026600140918     C                   IF        FKEY = F6
026700140918     C                   SETOFF                                       3940
026800140918     C*                  CLEAR                   S02PLAN
026900140918     C                   EVAL      CONAME = HLD@NAME
027000140918     C                   EVAL      S2TRST = ET
027100140918     C                   EVAL      S2SUB# = ES
027200140918     C                   EVAL      S2ACCT = EA
027300140918     C                   EXSR      $GETTSA
027400140918     C                   EVAL      @PROC = 'ADD PLAN  '
027500140918     C                   LEAVESR
027600140918     C                   ENDIF
027700140918    ***
027800140918     C                   EVAL      @PROC = 'CHECK SELC'
027900140918    ***
028000140918     C                   ENDSR
028100140918   S***S
028200140918     C     $ADDPLAN      BEGSR
028300140918    ***
028400140918     C                   EXSR      $SCREEN2
028500140918    ***
028600140918     C                   IF        FKEY = F12
028700140918     C                   CLEAR                   S02PLAN
028800140918     C                   EVAL      CONAME = HLD@NAME
028900140918     C                   EVAL      @PROC = 'SFL CONTRL'
029000140918     C                   LEAVESR
029100140918     C                   ENDIF
029200140918    ***
029300140918     C                   EVAL      KF@TRS  = ET
029400140918     C                   EVAL      KF@SUB  = ES
029500140918     C                   EVAL      KF@ACC  = EA
029600140918     C                   EVAL      KF@PLN  = S2PLAN
029700140918     C                   EVAL      KF@CCTR = S2CCTR
029800140918     C                   EVAL      KF@MAP  = S2MAP
029900140918    ***
030000140918     C                   EVAL      ADD_MODE = YES
030100140918     C                   EXSR      $VALIDKEY
030200140918    ***
030300140918     C                   IF        VALID_REC = NO
030400140918     C                   LEAVESR
030500140918     C                   ENDIF
030600140918    ***
030700140918     C                   EXSR      $VALIDPLAN
030800140918    ***
030900140918     C                   IF        VALID_REC = NO
031000140918     C                   LEAVESR
031100140918     C                   ENDIF
031200140918    ***
031300140918     C                   SETON                                        3940
031400140918    ***
031500140918     C                   DOU       FKEY = F12 OR FKEY = F10
031600140918      *
031700140918     C                   EXSR      $SCREEN2
031800140918      *
031900140918     C                   IF        FKEY = F12
032000140918     C                   SETOFF                                       3940
032100140918     C                   LEAVESR
032200140918     C                   ENDIF
032300140918      *
032400140918     C                   IF        FKEY = F10
032500140918     C                   EXSR      $PREPLN
032600140918     C                   EVAL      CPCID1 = S2CID1
032700140918     C                   EVAL      CPTXT1 = 'DIVISION'
032800140918     C                   EVAL      CPCID2 = S2CID2
032900140918     C                   EVAL      CPTXT2 = 'PLAN'
033000140918     C                   EVAL      CPCID3 = 'N/A'
033100140918     C                   EVAL      CPTXT3 = 'N/A'
033200140918     C                   EVAL      CPCID4 = 'N/A'
033300140918     C                   EVAL      CPTXT4 = 'N/A'
033400140918     C                   EVAL      CPCID5 = 'N/A'
033500140918     C                   EVAL      CPTXT5 = 'N/A'
033600140918     C                   EVAL      CPCID6 = 'N/A'
033700140918     C                   EVAL      CPTXT6 = 'N/A'
033800140918     C                   EVAL      CPCID7 = 'N/A'
033900140918     C                   EVAL      CPTXT7 = 'N/A'
034000140918     C                   EVAL      CPCID8 = 'N/A'
034100140918     C                   EVAL      CPTXT8 = 'N/A'
034200140918     C                   EVAL      CPCID9 = 'N/A'
034300140918     C                   EVAL      CPTXT9 = 'N/A'
034400140918     C                   EVAL      CPCIDA = 'N/A'
034500140918     C                   EVAL      CPTXTA = 'N/A'
034600140918     C                   WRITE     CARPLNR
034700140918     C                   LEAVE
034800140918     C                   ENDIF
034900140918      *
035000140918     C                   ENDDO
035100140918    ***
035200140918     C                   EVAL      @PROC = 'SFL CONTRL'
035300140918    ***
035400140918     C                   ENDSR
035500140918   S***S
035600140918     C     $SCREEN2      BEGSR
035700140918    ***
035800140918     C                   EVAL      EMSG = @EMSG
035900140918     C                   EXFMT     S02PLAN
036000140918     C                   CLEAR                   @EMSG
036100140918     C                   EVAL      EMSG = *BLANKS
036200140918    ***
036300140918     C                   ENDSR
036400140918   S***S
036500140918     C     $GETTSA       BEGSR
036600140918    ***
036700140918     C                   EVAL      KF@TRS  = ET
036800140918     C                   EVAL      KF@SUB  = ES
036900140918     C                   EVAL      KF@ACC  = EA
037000140918    ***
037100140918     C     KF@TRS        CHAIN     TRSMSR
037200140918     C                   IF        NOT %FOUND(TRMUNIQUE)
037300140918     C                   EVAL      O_TNAM = '**ERROR**'
037400140918     C                   ELSE
037500140918     C                   MOVEL(P)  TDESCR        O_TNAM
037600140918     C                   ENDIF
037700140918    ***
037800140918     C     KL#TS         CHAIN     SUBMSR
037900140918     C                   IF        NOT %FOUND(SUMUNIQUE)
038000140918     C                   EVAL      O_SUBN = '**ERROR**'
038100140918     C                   ELSE
038200140918     C                   MOVEL(P)  SUBDSC        O_SUBN
038300140918     C                   ENDIF
038400140918    ***
038500140918     C     KL#TSA        CHAIN     ACCMSR
038600140918     C                   IF        NOT %FOUND(ACMUNIQUE)
038700140918     C                   EVAL      O_ACCN = '**ERROR**'
038800140918     C                   ELSE
038900140918     C                   EVAL      O_ACCN = ACNAM1
039000140918     C                   ENDIF
039100140918    ***
039200140918     C                   MOVE      *BLANKS       D_PLAN
039300140918    ***
039400140918     C                   ENDSR
039500140918   S***S
039600140918     C     $VALIDKEY     BEGSR
039700140918    ***
039800140918     C                   EVAL      VALID_REC = NO
039900140918    ***
040000140918     C     KL#TSP        CHAIN     PLNMSR
040100140918     C                   IF        NOT %FOUND(PLNUNIQUE)
040200140918     C                   EVAL      D_PLAN = '**ERROR**'
040300140918     C                   EVAL      @EMSG = 'INVALID TRUST/SUB/PLAN'
040400140918     C                   LEAVESR
040500140918     C                   ENDIF
040600140918    ***
040700140918     C     KL#TSAP       CHAIN     COMCXR
040800140918     C                   IF        NOT %FOUND(COMCTUNIQ)
040900140918     C                   EVAL      @EMSG = 'COMMISSION CONTROL N/F'
041000140918     C                   LEAVESR
041100140918     C                   ENDIF
041200140918    ***
041300140918     C                   MOVEL(P)  PDESCR        D_PLAN
041400140918    ***
041500140918     C                   IF        KF@MAP = *BLANKS
041600140918     C                   EVAL      @EMSG = 'MISSING MAP'
041700140918     C                   LEAVESR
041800140918     C                   ENDIF
041900140918    ***
042000140918     C                   IF        KF@MAP <> '2TIER     ' AND
042100140918    *C                             KF@MAP <> 'NORULE    '
042200140918     C                   EVAL      @EMSG = 'INVALID MAP; REFER TO MAP DOCUMENT'
042300140918     C                   LEAVESR
042400140918     C                   ENDIF
042500140918    ***
042600140918     C                   IF        KF@MAP <> 'NORULE' AND
042700140918     C                             KF@CCTR = *BLANKS
042800140918     C                   EVAL      @EMSG = 'MISSING MAPPING VALUE'
042900140918     C                   LEAVESR
043000140918     C                   ENDIF
043100140918    ***
043200140918     C                   IF        ADD_MODE = YES
043300140918     C     KL#UTSACP     CHAIN     CARPLNR
043400140918     C                   IF        %FOUND(CARPLNP)
043500140918     C                   EVAL      @EMSG = 'T/S/A/P/MAP VALUE ALREADY EXISTS'
043600140918     C                   LEAVESR
043700140918     C                   ENDIF
043800140918     C                   ENDIF
043900140918    ***
044000140918     C                   EVAL      VALID_REC = YES
044100140918    ***
044200140918     C                   ENDSR
044300140918   S***S
044400140918     C     $VALIDPLAN    BEGSR
044500140918    ***
044600140918     C                   EVAL      VALID_REC = NO
044700140918    ***
044800140918     C                   IF        S2CID1 = *BLANKS
044900140918     C                   EVAL      @EMSG = 'DIVISION IS REQUIRED'
045000140918     C                   LEAVESR
045100140918     C                   ENDIF
045200140918    ***
045300140918     C                   IF        S2CID2 = *BLANKS
045400140918     C                   EVAL      @EMSG = 'PLAN IS REQUIRED'
045500140918     C                   LEAVESR
045600140918     C                   ENDIF
045700140918    ***
045800140918     C                   EVAL      VALID_REC = YES
045900140918    ***
046000140918     C                   ENDSR
046100140918   S***S
046200140918     C     $PREPLN       BEGSR
046300140918    ***
046400140918     C     KL#TSAP       CHAIN     EVRG12WF
046500140918     C                   IF        NOT %FOUND(EVRG12WF)
046600140918     C                   CLEAR                   AEF01
046700140918     C                   EVAL      AE1TRS = ET
046800140918     C                   EVAL      AE1SUB = ES
046900140918     C                   EVAL      AE1ACC = EA
047000140918     C                   EVAL      AE1PLN = KF@PLN
047100140918     C                   EVAL      AE1MAP = KF@MAP
047200140918     C                   WRITE(E)  AEF01
047300140918     C                   ENDIF
047400140918    ***
047500140918     C                   CLEAR                   CARPLNR
047600140918     C                   EVAL      CPUNIQ = KF@UNIQ
047700140918     C                   EVAL      CPTRST = ET
047800140918     C                   EVAL      CPSUB# = ES
047900140918     C                   EVAL      CPACCT = EA
048000140918     C                   EVAL      CPCCTR = KF@CCTR
048100140918     C                   EVAL      CPPLAN = KF@PLN
048200140918    ***
048300140918     C                   ENDSR
048400140918   S***S
048500140918     C     $CHKSELC      BEGSR
048600140918    ***
048700140918     C                   IF        I_PLAN <> PRV#PLN
048800140918     C                   EVAL      PRV#PLN = I_PLAN
048900140918     C                   EVAL      @PROC = 'PREP SFL  '
049000140918     C                   LEAVESR
049100140918     C                   ENDIF
049200140918    ***
049300140918    1C                   DOU       %EOF(EVRG11D)
049400140918     C                   READC     S01SFL
049500140918    2C                   IF        NOT %EOF(EVRG11D)
049600140918    ***
049700140918     C                   EVAL      KF@TRS  = ET
049800140918     C                   EVAL      KF@SUB  = ES
049900140918     C                   EVAL      KF@ACC  = EA
050000140918     C                   EVAL      KF@PLN  = SFPLAN
050100140918     C                   EVAL      KF@CCTR = SFCCTR
050200140918     C                   EVAL      KF@MAP  = SFMAP
050300140918    ***
050400140918     C                   IF        SEL = 'U'
050500140918     C     KL#RTSACP     CHAIN     CARPLNR
050600140918     C                   ELSE
050700140918     C     KL#UTSACP     CHAIN     CARPLNR
050800140918     C                   ENDIF
050900140918     C     KL#TSAP       CHAIN     EVRG12WF
051000140918    ***
051100140918     C                   SELECT
051200140918      * *
051300140918     C                   WHEN      SEL = 'R'
051400140918     C                   EVAL      CPUNIQ = KF@RET
051500140918     C                   UPDATE    CARPLNR
051600140918     C                   UNLOCK(E) EVRG12WF
051700140918      * *
051800140918     C                   WHEN      SEL = 'U'
051900140918     C                   EVAL      CPUNIQ = KF@UNIQ
052000140918     C                   UPDATE    CARPLNR
052100140918     C                   UNLOCK(E) EVRG12WF
052200140918      * *
052300140918     C                   WHEN      SEL = 'I'
052400140918     C                   EXSR      $FMTSCR2
052500140918     C                   EXSR      $INQ2
052600140918      *
052700140918     C                   WHEN      SEL = 'C'
052800140918     C                   EXSR      $FMTSCR2
052900140918     C                   EXSR      $CHG2
053000140918      * *
053100140918     C                   ENDSL
053200140918    ***
053300140918    3C                   IF        @EMSG <> *BLANKS
053400140918     C                   LEAVESR
053500140918    3C                   ENDIF
053600140918     C*
053700140918     C                   MOVE      *BLANKS       SEL
053800140918     C                   UPDATE    S01SFL
053900140918     C*
054000140918    2C                   ENDIF
054100140918    1C                   ENDDO
054200140918    ***
054300140918     C                   EVAL      @PROC = 'PREP SFL  '
054400140918    ***
054500140918     C                   ENDSR
054600140918   S***S
054700140918     C     $FMTSCR2      BEGSR
054800140918    ***
054900140918     C                   SETOFF                                       3940
055000140918     C                   CLEAR                   S02PLAN
055100140918     C                   EVAL      CONAME = HLD@NAME
055200140918    ***
055300140918     C                   EVAL      S2TRST = ET
055400140918     C                   EVAL      S2SUB# = ES
055500140918     C                   EVAL      S2ACCT = EA
055600140918     C                   EVAL      S2PLAN = CPPLAN
055700140918     C                   EVAL      S2CCTR = CPCCTR
055800140918     C                   EVAL      S2MAP  = AE1MAP
055900140918    ***
056000140918     C                   EXSR      $CHAINS
056100140918    ***
056200140918     C                   EVAL      S2CID1 = %TRIM(CPCID1)
056300140918     C                   EVAL      S2CID2 = %TRIM(CPCID2)
056400140918    ***
056500140918     C                   ENDSR
056600140918   S***S
056700140918     C     $CHAINS       BEGSR
056800140918    ***
056900140918     C     KF@TRS        CHAIN     TRSMSR
057000140918     C                   IF        %FOUND(TRMUNIQUE)
057100140918     C                   MOVEL(P)  TDESCR        O_TNAM
057200140918     C                   ENDIF
057300140918    ***
057400140918     C     KL#TS         CHAIN     SUBMSR
057500140918     C                   IF        %FOUND(SUMUNIQUE)
057600140918     C                   MOVEL(P)  SUBDSC        O_SUBN
057700140918     C                   ENDIF
057800140918    ***
057900140918     C     KL#TSA        CHAIN     ACCMSR
058000140918     C                   IF        %FOUND(ACMUNIQUE)
058100140918     C                   MOVE      *BLANKS       @100            100
058200140918     C                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
058300140918     C                             %TRIM(ACNAM2)
058400140918     C                   MOVEL(P)  @100          O_ACCN
058500140918     C                   ENDIF
058600140918    ***
058700140918     C     KL#TSP        CHAIN     PLNMSR
058800140918     C                   IF        %FOUND(PLNUNIQUE)
058900140918     C                   EVAL      D_PLAN = %TRIM(PDESCR)
059000140918     C                   ENDIF
059100140918    ***
059200140918     C                   ENDSR
059300140918   S***S
059400140918     C     $INQ2         BEGSR
059500140918    ***
059600140918     C                   EVAL      EMSG = 'INQUIRY ONLY'
059700140918     C                   EVAL      *IN40 = *ON
059800140918     C                   DOU       FKEY = F12
059900140918     C                   EXFMT     S02PLAN
060000140918     C                   ENDDO
060100140918    ***
060200140918     C                   ENDSR
060300140918   S***S
060400140918     C     $CHG2         BEGSR
060500140918    ***
060600140918     C                   EVAL      @EMSG = 'BE CAREFUL'
060700140918    ***
060800140918     C                   DOU       FKEY = F12
060900140918      *
061000140918     C                   EXSR      $SCREEN2
061100140918      *
061200140918     C                   IF        FKEY = F12
061300140918     C                   UNLOCK(E) CARPLNP
061400140918     C                   UNLOCK(E) EVRG12WF
061500140918     C                   SETOFF                                       3940
061600140918     C                   LEAVESR
061700140918     C                   ENDIF
061800140918      *
061900140918     C                   EVAL      KF@TRS  = ET
062000140918     C                   EVAL      KF@SUB  = ES
062100140918     C                   EVAL      KF@ACC  = EA
062200140918     C                   EVAL      KF@PLN  = S2PLAN
062300140918     C                   EVAL      KF@CCTR = S2CCTR
062400140918     C                   EVAL      KF@MAP  = S2MAP
062500140918    ***
062600140918     C                   EVAL      ADD_MODE = NO
062700140918     C                   EXSR      $VALIDKEY
062800140918     C                   IF        VALID_REC = NO
062900140918     C                   ITER
063000140918     C                   ENDIF
063100140918    ***
063200140918     C                   EXSR      $VALIDPLAN
063300140918     C                   IF        VALID_REC = NO
063400140918     C                   ITER
063500140918     C                   ENDIF
063600140918    ***
063700140918     C                   SETON                                        3940
063800140918     C                   DOU       FKEY = F12 OR FKEY = F10
063900140918     C                   EXSR      $SCREEN2
064000140918    ***
064100140918     C                   IF        FKEY = F12
064200140918     C                   SETOFF                                       3940
064300140918     C                   LEAVESR
064400140918     C                   ENDIF
064500140918    ***
064600140918     C                   IF        FKEY = F10
064700140918     C                   EVAL      CPCID1 = S2CID1
064800140918     C                   EVAL      CPCID2 = S2CID2
064900140918     C                   EVAL      CPCCTR = S2CCTR
065000140918     C                   UPDATE    CARPLNR
065100140918     C                   EVAL      AE1MAP = S2MAP
065200140918     C                   UPDATE    AEF01
065300140918     C                   LEAVESR
065400140918     C                   ENDIF
065500140918    ***
065600140918     C                   ENDDO
065700140918    ***
065800140918     C                   ENDDO
065900140918    ***
066000140918     C                   ENDSR
066100140918   S***S
