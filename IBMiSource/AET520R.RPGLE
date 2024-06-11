000100120813    *** AETNA SMALL GROUP ACCOUNT MAPPING
000200120813    ***
000300120813    *** SSK  08/13/2012
000400120813    ***
000500120813    ***
000600120813    ***
000700120813     FAET520D   CF   E             WORKSTN INFDS(WSDS) SFILE(S01SFL:RR1)
000800120813     FCARACCP   UF A E           K DISK
000900120813     FCARACCQ   IF   E           K DISK    RENAME(CARACCR:CAL2) PREFIX(ZZ:2)
001000120813     FTRMUNIQUE IF   E           K DISK
001100120813     FSUMUNIQUE IF   E           K DISK
001200120813     FACMUNIQUE IF   E           K DISK
001300120813   X***X
001400120813     D HLD@NAME        S             40A
001500120813     D @EMSG           S                   LIKE(EMSG)
001600120813     D PRV#TRS         S                   LIKE(I_TRST)
001700120813     D PRV#SUB         S                   LIKE(I_SUB#)
001800120813     D PRV#ACC         S                   LIKE(I_ACCT)
001900120813     D ADD_MODE        S               N   INZ(*OFF)
002000120813     D VALID_REC       S               N   INZ(*OFF)
002100120813     D YES             S               N   INZ(*ON)
002200120813     D NO              S               N   INZ(*OFF)
002300120813    ***
002400120813     D WSDS            DS
002500120813     D  FKEY                 369    369A
002600120813    ***
002700120813     D  F1             C                   CONST(X'31')
002800120813     D  F2             C                   CONST(X'32')
002900120813     D  F3             C                   CONST(X'33')
003000120813     D  F4             C                   CONST(X'34')
003100120813     D  F5             C                   CONST(X'35')
003200120813     D  F6             C                   CONST(X'36')
003300120813     D  F7             C                   CONST(X'37')
003400120813     D  F8             C                   CONST(X'38')
003500120813     D  F9             C                   CONST(X'39')
003600120813     D  F10            C                   CONST(X'3A')
003700120813     D  F11            C                   CONST(X'3B')
003800120813     D  F12            C                   CONST(X'3C')
003900120813     D  F13            C                   CONST(X'B1')
004000120813     D  F14            C                   CONST(X'B2')
004100120813     D  F15            C                   CONST(X'B3')
004200120813     D  F16            C                   CONST(X'B4')
004300120813     D  F17            C                   CONST(X'B5')
004400120813     D  F18            C                   CONST(X'B6')
004500120813     D  F19            C                   CONST(X'B7')
004600120813     D  F20            C                   CONST(X'B8')
004700120813     D  F21            C                   CONST(X'B9')
004800120813     D  F22            C                   CONST(X'BA')
004900120813     D  F23            C                   CONST(X'BB')
005000120813     D  F24            C                   CONST(X'BC')
005100120813    ***
005200120813     D                UDS
005300120813     D  XONAME               201    240
005400120813    ***
005500120813     D KF@UNIQ         S                   LIKE(CAUNIQ)
005600120813     D                                     INZ('0000000011')
005700120813     D KF@TRS          S                   LIKE(CATRST)
005800120813     D KF@SUB          S                   LIKE(CASUB#)
005900120813     D KF@ACC          S                   LIKE(CAACCT)
006000120813    ***
006100120813     D @PROC           S             10A
006200120813    ***
006300140903   X***X
006400140903     C     *ENTRY        PLIST
006500140903     C                   PARM                    @WHO             10
006600140903     C                   MOVE      'N'           @MAINT            1
006700140903     C                   SELECT
006800140903     C                   WHEN      @WHO = 'BRANDONS  '
006900140903     C                   MOVE      'Y'           @MAINT
007000140903     C                   WHEN      @WHO = 'RONM      '
007100140903     C                   MOVE      'Y'           @MAINT
007200140903     C                   WHEN      @WHO = 'STEPHENK  '
007300140903     C                   MOVE      'Y'           @MAINT
007400140903     C                   ENDSL
007500120813   X***X
007600120813     C                   DOU       @PROC = 'EXIT APP  '
007700120813     C     @PROC         CASEQ     'PREP SFL  '  $PREPSFL
007800120813     C     @PROC         CASEQ     'BUILD SFL '  $BLDSFL
007900120813     C     @PROC         CASEQ     'SFL CONTRL'  $SFLCTL
008000120813     C     @PROC         CASEQ     'ADD ACCT  '  $ADDACCT
008100120813     C     @PROC         CASEQ     'CHECK SELC'  $CHKSELC
008200120813     C                   ENDCS
008300120813     C                   ENDDO
008400120813     C*
008500120813     C                   MOVE      *ON           *INLR
008600120813     C*
008700120813   S***S
008800120813     C     *INZSR        BEGSR
008900120813    ***
009000120813     C                   EVAL      @PROC = 'PREP SFL  '
009100120813    ***
009200120813     C     KL#TS         KLIST
009300120813     C                   KFLD                    KF@TRS
009400120813     C                   KFLD                    KF@SUB
009500120813    ***
009600120813     C     KL#TSA        KLIST
009700120813     C                   KFLD                    KF@TRS
009800120813     C                   KFLD                    KF@SUB
009900120813     C                   KFLD                    KF@ACC
010000120813    ***
010100120813     C                   EVAL      HLD@NAME = XONAME
010200120813    ***
010300120813     C     KL#UTSA       KLIST
010400120813     C                   KFLD                    KF@UNIQ
010500120813     C                   KFLD                    KF@TRS
010600120813     C                   KFLD                    KF@SUB
010700120813     C                   KFLD                    KF@ACC
010800120813    ***
010900120813     C                   ENDSR
011000120813   S***S
011100120813     C     $PREPSFL      BEGSR
011200120813    ***
011300120813     C                   MOVE      *ZEROS        RR1               4 0
011400120813     C                   MOVE      *ZEROS        #CNTREC           4 0
011500120813    ***
011600120813     C                   EVAL      *IN39 = *OFF
011700120813     C                   EVAL      *IN40 = *OFF
011800120813    ***
011900120813     C                   EVAL      @PROC = 'BUILD SFL '
012000120813    ***
012100120813     C                   ENDSR
012200120813   S***S
012300120813     C* INITIALIZE THE SUBFILE
012400120813    ***
012500120813     C     $CLRSFL       BEGSR
012600120813    ***
012700120813     C                   MOVEA     '011'         *IN(25)
012800120813     C                   WRITE     S01CTL
012900120813     C                   MOVEA     '010'         *IN(25)
013000120813     C                   Z-ADD     *ZERO         RR1
013100120813    ***
013200120813     C                   ENDSR
013300120813   S***S
013400120813     C     $BLDSFL       BEGSR
013500120813    ***
013600120813     C                   MOVE      *ZEROS        #CNTREC
013700120813     C                   MOVE      '0'           @1STLOOP          1
013800120813     C                   MOVE      '0'           @SFLOOP           1
013900120813     C                   MOVE      '0'           *IN20
014000120813    ***
014100120813     C                   IF        I_TRST = 0
014200120813     C                   EVAL      KF@TRS = 001
014300120813     C                   EVAL      KF@SUB = 001
014400120813     C                   EVAL      KF@ACC = 001
014500120813     C                   ELSE
014600120813     C                   EVAL      KF@TRS = I_TRST
014700120813     C                   EVAL      KF@SUB = I_SUB#
014800120813     C                   EVAL      KF@ACC = I_ACCT
014900120813     C                   ENDIF
015000120813     C                   EVAL      I_TRST = 0
015100120813     C                   EVAL      I_SUB# = 0
015200120813     C                   EVAL      I_ACCT = 0
015300120813    ***
015400120813     C                   EXSR      $CLRSFL
015500120813     C                   EVAL      CONAME = HLD@NAME
015600120813    ***
015700120813     C     KL#TSA        SETLL     CAL2
015800120813    1C                   DOU       %EOF(CARACCQ) OR @SFLOOP = '1'
015900120813     C                   READ      CAL2
016000120813    2C                   IF        NOT %EOF(CARACCQ) AND
016100120813     C                             ZZUNIQ = KF@UNIQ
016200120813     C                   EXSR      $LOADSFL
016300120813    2C                   ENDIF
016400120813    1C                   ENDDO
016500120813    ***
016600120813     C                   EVAL      @PROC = 'SFL CONTRL'
016700120813    ***
016800120813     C                   ENDSR
016900120813   S***S
017000120813     C     $LOADSFL      BEGSR
017100120813    ***
017200120813     C                   MOVE      *ON           *IN25
017300120813     C                   MOVE      *BLANKS       SEL
017400120813    ***
017500120813     C                   EVAL      HUNIQ = ZZUNIQ
017600120813     C                   EVAL      SFTRST = ZZTRST
017700120813     C                   EVAL      SFSUB# = ZZSUB#
017800120813     C                   EVAL      SFACCT = ZZACCT
017900120813    ***
018000120813     C                   EVAL      KF@TRS  = ZZTRST
018100120813     C                   EVAL      KF@SUB  = ZZSUB#
018200120813     C                   EVAL      KF@ACC  = ZZACCT
018300120813    ***
018400120813     C     KL#TSA        CHAIN     ACCMSR
018500120813     C                   IF        NOT %FOUND(ACMUNIQUE)
018600120813     C                   EVAL      SFANAME = '**ERROR**'
018700120813     C                   ELSE
018800120813     C                   MOVE      *BLANKS       @100            100
018900120813     C                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
019000120813     C                             %TRIM(ACNAM2)
019100120813     C                   MOVEL(P)  @100          SFANAME
019200120813     C                   ENDIF
019300120813    ***
019400120813     C                   EVAL      SFSTATUS = ZZSTATUS
019500120813    ***
019600120813     C                   ADD       1             RR1
019700120813     C*
019800120813    1C                   IF        @1STLOOP = '0'
019900120813     C                   Z-ADD     RR1           SFLPOS
020000120813     C                   MOVE      '1'           @1STLOOP
020100120813    1C                   ENDIF
020200120813     C*
020300120813     C                   WRITE     S01SFL
020400120813     C*
020500120813     C                   ADD       1             #CNTREC
020600120813    1C                   IF        #CNTREC = 100
020700120813     C                   MOVE      '1'           @SFLOOP
020800120813    1C                   ENDIF
020900120813    ***
021000120813     C                   ENDSR
021100120813   S***S
021200120813     C     $SFLCTL       BEGSR
021300120813    ***
021400120813     C                   EVAL      EMSG = @EMSG
021500120813    ***
021600120813     C                   WRITE     S01REC
021700120813     C                   EXFMT     S01CTL
021800120813    ***
021900120813     C                   MOVE      *BLANKS       EMSG
022000120813     C                   MOVE      *BLANKS       @EMSG
022100120813    ***
022200120813     C                   IF        FKEY = F3
022300120813     C                   EVAL      @PROC = 'EXIT APP  '
022400120813     C                   LEAVESR
022500120813     C                   ENDIF
022600120813    ***
022700140903     C                   IF        FKEY = F6 AND @MAINT = 'Y'
022800120813     C                   SETOFF                                       3940
022900120813     C                   CLEAR                   S02R
023000120813     C                   EVAL      CONAME = HLD@NAME
023100120813     C                   EVAL      @PROC = 'ADD ACCT  '
023200120813     C                   LEAVESR
023300120813     C                   ENDIF
023400120813    ***
023500120813     C                   EVAL      @PROC = 'CHECK SELC'
023600120813    ***
023700120813     C                   ENDSR
023800120813   S***S
023900120813     C     $ADDACCT      BEGSR
024000120813    ***
024100120813     C                   EXSR      $SCREEN2
024200120813    ***
024300120813     C                   IF        FKEY = F12
024400120813     C                   CLEAR                   S02R
024500120813     C                   EVAL      CONAME = HLD@NAME
024600120813     C                   EVAL      @PROC = 'SFL CONTRL'
024700120813     C                   LEAVESR
024800120813     C                   ENDIF
024900120813    ***
025000120813     C                   EVAL      KF@TRS  = SCTRST
025100120813     C                   EVAL      KF@SUB  = SCSUB#
025200120813     C                   EVAL      KF@ACC  = SCACCT
025300120813    ***
025400120813     C                   EVAL      ADD_MODE = YES
025500120813     C                   EXSR      $VALIDKEY
025600120813    ***
025700120813     C                   IF        VALID_REC = NO
025800120813     C                   LEAVESR
025900120813     C                   ENDIF
026000120813    ***
026100120813     C                   EXSR      $VALIDACC
026200120813    ***
026300120813     C                   IF        VALID_REC = NO
026400120813     C                   LEAVESR
026500120813     C                   ENDIF
026600120813    ***
026700120813     C                   SETON                                        3940
026800120813    ***
026900120813     C                   DOU       FKEY = F12 OR FKEY = F10
027000120813      *
027100120813     C                   EXSR      $SCREEN2
027200120813      *
027300120813     C                   IF        FKEY = F12
027400120813     C                   SETOFF                                       3940
027500120813     C                   LEAVESR
027600120813     C                   ENDIF
027700120813      *
027800120813     C                   IF        FKEY = F10
027900120813     C                   EXSR      $PREPACC
028000120813     C                   EVAL      CACID1 = 'GBSSMALLGROUP'
028100120813     C                   EVAL      CATXT1 = 'SUBMITTER ID'
028200120813     C                   EVAL      CACID2 = 'US'
028300120813     C                   EVAL      CATXT2 = 'COMPANY CODE'
028400120813     C                   EVAL      CACID3 = SCCID3
028500120813     C                   EVAL      CATXT3 = 'HMO GROUP NUMBER'
028600120813     C                   EVAL      CACID4 = 'GBSSMALLGROUP'
028700120813     C                   EVAL      CATXT4 = 'CUSTOMER NAME'
028800120813     C                   EVAL      CACID5 = SCCID5
028900120813     C                   EVAL      CATXT5 = 'CUSTOMER NUMBER'
029000130123     C                   EVAL      CATXT6 = %TRIM(ACNAM1)
029100130123     C                   EVAL      CACID6 = 'N/A'
029200120813     C                   EVAL      CASTATUS = SCSTATUS
029300120813     C                   WRITE     CARACCR
029400120813     C                   LEAVE
029500120813     C                   ENDIF
029600120813      *
029700120813     C                   ENDDO
029800120813    ***
029900120815     C                   EVAL      @PROC = 'BUILD SFL '
030000120813    ***
030100120813     C                   ENDSR
030200120813   S***S
030300120813     C     $SCREEN2      BEGSR
030400120813    ***
030500120813     C                   EVAL      EMSG = @EMSG
030600120813     C                   EXFMT     S02R
030700120813     C                   CLEAR                   @EMSG
030800120813     C                   EVAL      EMSG = *BLANKS
030900120813    ***
031000120813     C                   ENDSR
031100120813   S***S
031200120813     C     $VALIDKEY     BEGSR
031300120813    ***
031400120813     C                   EVAL      VALID_REC = NO
031500120813    ***
031600120813     C                   IF        KF@TRS = 0
031700120813     C                   EVAL      @EMSG = 'MISSING TRUST'
031800120813     C                   LEAVESR
031900120813     C                   ENDIF
032000120813    ***
032100120813     C     KF@TRS        CHAIN     TRSMSR
032200120813     C                   IF        NOT %FOUND(TRMUNIQUE)
032300120813     C                   EVAL      O_TNAM = '**ERROR**'
032400120813     C                   EVAL      @EMSG = 'INVALID TRUST'
032500120813     C                   LEAVESR
032600120813     C                   ENDIF
032700120813    ***
032800120813     C                   MOVEL(P)  TDESCR        O_TNAM
032900120813    ***
033000120813     C                   IF        KF@SUB = 0
033100120813     C                   EVAL      @EMSG = 'MISSING SUBDIVISION'
033200120813     C                   LEAVESR
033300120813     C                   ENDIF
033400120813    ***
033500120813     C     KL#TS         CHAIN     SUBMSR
033600120813     C                   IF        NOT %FOUND(SUMUNIQUE)
033700120813     C                   EVAL      O_SUBN = '**ERROR**'
033800120813     C                   EVAL      @EMSG = 'INVALID TRUST/SUBDIVISION'
033900120813     C                   LEAVESR
034000120813     C                   ENDIF
034100120813    ***
034200120813     C                   MOVEL(P)  SUBDSC        O_SUBN
034300120813    ***
034400120813     C                   IF        KF@ACC = 0
034500120813     C                   EVAL      @EMSG = 'MISSING ACCOUNT'
034600120813     C                   LEAVESR
034700120813     C                   ENDIF
034800120813    ***
034900120813     C     KL#TSA        CHAIN     ACCMSR
035000120813     C                   IF        NOT %FOUND(ACMUNIQUE)
035100120813     C                   EVAL      O_ACCN = '**ERROR**'
035200120813     C                   EVAL      @EMSG = 'INVALID TRUST/SUB/ACCOUNT'
035300120813     C                   LEAVESR
035400120813     C                   ENDIF
035500120813    ***
035600120813     C                   MOVE      *BLANKS       @100
035700120813     C                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
035800120813     C                             %TRIM(ACNAM2)
035900120813     C                   MOVEL(P)  @100          O_ACCN
036000120813    ***
036100120813     C                   IF        ADD_MODE = YES
036200120813     C     KL#UTSA       CHAIN     CARACCR
036300120813     C                   IF        %FOUND(CARACCP)
036400120813     C                   EVAL      @EMSG = 'T/S/A VALUE ALREADY EXISTS'
036500120813     C                   LEAVESR
036600120813     C                   ENDIF
036700120813     C                   ENDIF
036800120813    ***
036900120813     C                   EVAL      VALID_REC = YES
037000120813    ***
037100120813     C                   ENDSR
037200120813   S***S
037300120813     C     $VALIDACC     BEGSR
037400120813    ***
037500120813     C                   EVAL      VALID_REC = NO
037600120813    ***
037700120813     C                   IF        SCCID3 = *BLANKS AND SCCID5 = *BLANKS
037800120813     C                   EVAL      @EMSG = 'HMO AND PPO CANNOT BOTH BE BLANK'
037900120813     C                   LEAVESR
038000120813     C                   ENDIF
038100120813    ***
038200120813     C                   IF        SCSTATUS <> 'Y' AND SCSTATUS <> 'N'
038300120813     C                   EVAL      @EMSG = 'VALID TRANSMIT FLAG REQUIRED'
038400120813     C                   LEAVESR
038500120813     C                   ENDIF
038600120813    ***
038700120813     C                   EVAL      VALID_REC = YES
038800120813    ***
038900120813     C                   ENDSR
039000120813   S***S
039100120813     C     $PREPACC      BEGSR
039200120813    ***
039300120813     C                   CLEAR                   CARACCR
039400120813     C                   EVAL      CAUNIQ = KF@UNIQ
039500120813     C                   EVAL      CATRST = KF@TRS
039600120813     C                   EVAL      CASUB# = KF@SUB
039700120813     C                   EVAL      CAACCT = KF@ACC
039800120813    ***
039900120813     C                   ENDSR
040000120813   S***S
040100120813     C     $CHKSELC      BEGSR
040200120813    ***
040300120816     C                   IF        I_TRST > 0
040400120813     C                   IF        I_TRST <> PRV#TRS OR
040500120813     C                             I_SUB# <> PRV#SUB OR
040600120813     C                             I_ACCT <> PRV#ACC
040700120813     C                   EVAL      PRV#TRS = I_TRST
040800120813     C                   EVAL      PRV#SUB = I_SUB#
040900120813     C                   EVAL      PRV#ACC = I_ACCT
041000120813     C                   EVAL      @PROC = 'PREP SFL  '
041100120813     C                   LEAVESR
041200120813     C                   ENDIF
041300120816     C                   ENDIF
041400120813    ***
041500140903     C                   IF        @MAINT = 'N'
041600140903     C                   EVAL      @PROC = 'PREP SFL  '
041700140903     C                   LEAVESR
041800140903     C                   ENDIF
041900140903    ***
042000120813    1C                   DOU       %EOF(AET520D)
042100120813     C                   READC     S01SFL
042200120813    2C                   IF        NOT %EOF(AET520D)
042300120813    ***
042400120813     C                   EVAL      KF@TRS  = SFTRST
042500120813     C                   EVAL      KF@SUB  = SFSUB#
042600120813     C                   EVAL      KF@ACC  = SFACCT
042700120813    ***
042800120813     C     KL#UTSA       CHAIN     CARACCR
042900120813    ***
043000120813     C                   SELECT
043100120813     C                   WHEN      SEL = 'I'
043200120813     C                   EXSR      $FMTSCR2
043300120813     C                   EXSR      $INQ2
043400120813     C                   WHEN      SEL = 'C'
043500120813     C                   EXSR      $FMTSCR2
043600120813     C                   EXSR      $CHG2
043700120813     C                   WHEN      SEL = 'A'
043800120813     C                   EVAL      CASTATUS = 'Y'
043900120813     C                   UPDATE    CARACCR
044000120813     C                   WHEN      SEL = 'T'
044100120813     C                   EVAL      CASTATUS = 'N'
044200120813     C                   UPDATE    CARACCR
044300120813     C                   ENDSL
044400120813    ***
044500120813    3C                   IF        @EMSG <> *BLANKS
044600120813     C                   LEAVESR
044700120813    3C                   ENDIF
044800120813     C*
044900120813     C                   MOVE      *BLANKS       SEL
045000120813     C                   UPDATE    S01SFL
045100120813     C*
045200120813    2C                   ENDIF
045300120813    1C                   ENDDO
045400120813    ***
045500120816     C                   EVAL      @PROC = 'PREP SFL  '
045600120813    ***
045700120813     C                   ENDSR
045800120813   S***S
045900120813     C     $FMTSCR2      BEGSR
046000120813    ***
046100120813     C                   SETOFF                                       3940
046200120813     C                   CLEAR                   S02R
046300120813     C                   EVAL      CONAME = HLD@NAME
046400120813    ***
046500120813     C                   EVAL      SCTRST = CATRST
046600120813     C                   EVAL      SCSUB# = CASUB#
046700120813     C                   EVAL      SCACCT = CAACCT
046800120813     C                   EVAL      SCSTATUS = CASTATUS
046900120813    ***
047000120813     C                   EXSR      $CHAINS
047100120813    ***
047200120813     C                   EVAL      SCCID3 = %TRIM(CACID3)
047300120813     C                   EVAL      SCCID5 = %TRIM(CACID5)
047400120813    ***
047500120813     C                   ENDSR
047600120813   S***S
047700120813     C     $CHAINS       BEGSR
047800120813    ***
047900120813     C     KF@TRS        CHAIN     TRSMSR
048000120813     C                   IF        %FOUND(TRMUNIQUE)
048100120813     C                   MOVEL(P)  TDESCR        O_TNAM
048200120813     C                   ENDIF
048300120813    ***
048400120813     C     KL#TS         CHAIN     SUBMSR
048500120813     C                   IF        %FOUND(SUMUNIQUE)
048600120813     C                   MOVEL(P)  SUBDSC        O_SUBN
048700120813     C                   ENDIF
048800120813    ***
048900120813     C     KL#TSA        CHAIN     ACCMSR
049000120813     C                   IF        %FOUND(ACMUNIQUE)
049100120813     C                   MOVE      *BLANKS       @100
049200120813     C                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
049300120813     C                             %TRIM(ACNAM2)
049400120813     C                   MOVEL(P)  @100          O_ACCN
049500120813     C                   ENDIF
049600120813    ***
049700120813     C                   ENDSR
049800120813   S***S
049900120813   S***S
050000120813     C     $INQ2         BEGSR
050100120813    ***
050200120813     C                   EVAL      EMSG = 'INQUIRY ONLY'
050300120813     C                   EVAL      *IN40 = *ON
050400120813     C                   DOU       FKEY = F12
050500120813     C                   EXFMT     S02R
050600120813     C                   ENDDO
050700120813    ***
050800120813     C                   ENDSR
050900120813   S***S
051000120813     C     $CHG2         BEGSR
051100120813    ***
051200120813     C                   EVAL      @EMSG = 'BE CAREFUL'
051300120813    ***
051400120813     C                   DOU       FKEY = F12
051500120813      *
051600120813     C                   EXSR      $SCREEN2
051700120813      *
051800120813     C                   IF        FKEY = F12
051900120813     C                   UNLOCK(E) CARACCP
052000120813     C                   SETOFF                                       3940
052100120813     C                   LEAVESR
052200120813     C                   ENDIF
052300120813      *
052400120813     C                   EVAL      KF@TRS  = SCTRST
052500120813     C                   EVAL      KF@SUB  = SCSUB#
052600120813     C                   EVAL      KF@ACC  = SCACCT
052700120813    ***
052800120813     C                   EVAL      ADD_MODE = NO
052900120813     C                   EXSR      $VALIDKEY
053000120813     C                   IF        VALID_REC = NO
053100120813     C                   ITER
053200120813     C                   ENDIF
053300120813    ***
053400120813     C                   EXSR      $VALIDACC
053500120813     C                   IF        VALID_REC = NO
053600120813     C                   ITER
053700120813     C                   ENDIF
053800120813    ***
053900120813     C                   SETON                                        3940
054000120813     C                   DOU       FKEY = F12 OR FKEY = F10
054100120813     C                   EXSR      $SCREEN2
054200120813    ***
054300120813     C                   IF        FKEY = F12
054400120813     C                   SETOFF                                       3940
054500120813     C                   LEAVESR
054600120813     C                   ENDIF
054700120813    ***
054800120813     C                   IF        FKEY = F10
054900120813     C                   EVAL      CACID3 = SCCID3
055000120813     C                   EVAL      CACID5 = SCCID5
055100120813     C                   EVAL      CASTATUS = SCSTATUS
055200120813     C                   UPDATE    CARACCR
055300120813     C                   LEAVESR
055400120813     C                   ENDIF
055500120813    ***
055600120813     C                   ENDDO
055700120813    ***
055800120813     C                   ENDDO
055900120813    ***
056000120813     C                   ENDSR
056100120813   S***S
