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
006300120813   X***X
006400120813     C                   DOU       @PROC = 'EXIT APP  '
006500120813     C     @PROC         CASEQ     'PREP SFL  '  $PREPSFL
006600120813     C     @PROC         CASEQ     'BUILD SFL '  $BLDSFL
006700120813     C     @PROC         CASEQ     'SFL CONTRL'  $SFLCTL
006800120813     C     @PROC         CASEQ     'ADD ACCT  '  $ADDACCT
006900120813     C     @PROC         CASEQ     'CHECK SELC'  $CHKSELC
007000120813     C                   ENDCS
007100120813     C                   ENDDO
007200120813     C*
007300120813     C                   MOVE      *ON           *INLR
007400120813     C*
007500120813   S***S
007600120813     C     *INZSR        BEGSR
007700120813    ***
007800120813     C                   EVAL      @PROC = 'PREP SFL  '
007900120813    ***
008000120813     C     KL#TS         KLIST
008100120813     C                   KFLD                    KF@TRS
008200120813     C                   KFLD                    KF@SUB
008300120813    ***
008400120813     C     KL#TSA        KLIST
008500120813     C                   KFLD                    KF@TRS
008600120813     C                   KFLD                    KF@SUB
008700120813     C                   KFLD                    KF@ACC
008800120813    ***
008900120813     C                   EVAL      HLD@NAME = XONAME
009000120813    ***
009100120813     C     KL#UTSA       KLIST
009200120813     C                   KFLD                    KF@UNIQ
009300120813     C                   KFLD                    KF@TRS
009400120813     C                   KFLD                    KF@SUB
009500120813     C                   KFLD                    KF@ACC
009600120813    ***
009700120813     C                   ENDSR
009800120813   S***S
009900120813     C     $PREPSFL      BEGSR
010000120813    ***
010100120813     C                   MOVE      *ZEROS        RR1               4 0
010200120813     C                   MOVE      *ZEROS        #CNTREC           4 0
010300120813    ***
010400120813     C                   EVAL      *IN39 = *OFF
010500120813     C                   EVAL      *IN40 = *OFF
010600120813    ***
010700120813     C                   EVAL      @PROC = 'BUILD SFL '
010800120813    ***
010900120813     C                   ENDSR
011000120813   S***S
011100120813     C* INITIALIZE THE SUBFILE
011200120813    ***
011300120813     C     $CLRSFL       BEGSR
011400120813    ***
011500120813     C                   MOVEA     '011'         *IN(25)
011600120813     C                   WRITE     S01CTL
011700120813     C                   MOVEA     '010'         *IN(25)
011800120813     C                   Z-ADD     *ZERO         RR1
011900120813    ***
012000120813     C                   ENDSR
012100120813   S***S
012200120813     C     $BLDSFL       BEGSR
012300120813    ***
012400120813     C                   MOVE      *ZEROS        #CNTREC
012500120813     C                   MOVE      '0'           @1STLOOP          1
012600120813     C                   MOVE      '0'           @SFLOOP           1
012700120813     C                   MOVE      '0'           *IN20
012800120813    ***
012900120813     C                   IF        I_TRST = 0
013000120813     C                   EVAL      KF@TRS = 001
013100120813     C                   EVAL      KF@SUB = 001
013200120813     C                   EVAL      KF@ACC = 001
013300120813     C                   ELSE
013400120813     C                   EVAL      KF@TRS = I_TRST
013500120813     C                   EVAL      KF@SUB = I_SUB#
013600120813     C                   EVAL      KF@ACC = I_ACCT
013700120813     C                   ENDIF
013800120813     C                   EVAL      I_TRST = 0
013900120813     C                   EVAL      I_SUB# = 0
014000120813     C                   EVAL      I_ACCT = 0
014100120813    ***
014200120813     C                   EXSR      $CLRSFL
014300120813     C                   EVAL      CONAME = HLD@NAME
014400120813    ***
014500120813     C     KL#TSA        SETLL     CAL2
014600120813    1C                   DOU       %EOF(CARACCQ) OR @SFLOOP = '1'
014700120813     C                   READ      CAL2
014800120813    2C                   IF        NOT %EOF(CARACCQ) AND
014900120813     C                             ZZUNIQ = KF@UNIQ
015000120813     C                   EXSR      $LOADSFL
015100120813    2C                   ENDIF
015200120813    1C                   ENDDO
015300120813    ***
015400120813     C                   EVAL      @PROC = 'SFL CONTRL'
015500120813    ***
015600120813     C                   ENDSR
015700120813   S***S
015800120813     C     $LOADSFL      BEGSR
015900120813    ***
016000120813     C                   MOVE      *ON           *IN25
016100120813     C                   MOVE      *BLANKS       SEL
016200120813    ***
016300120813     C                   EVAL      HUNIQ = ZZUNIQ
016400120813     C                   EVAL      SFTRST = ZZTRST
016500120813     C                   EVAL      SFSUB# = ZZSUB#
016600120813     C                   EVAL      SFACCT = ZZACCT
016700120813    ***
016800120813     C                   EVAL      KF@TRS  = ZZTRST
016900120813     C                   EVAL      KF@SUB  = ZZSUB#
017000120813     C                   EVAL      KF@ACC  = ZZACCT
017100120813    ***
017200120813     C     KL#TSA        CHAIN     ACCMSR
017300120813     C                   IF        NOT %FOUND(ACMUNIQUE)
017400120813     C                   EVAL      SFANAME = '**ERROR**'
017500120813     C                   ELSE
017600120813     C                   MOVE      *BLANKS       @100            100
017700120813     C                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
017800120813     C                             %TRIM(ACNAM2)
017900120813     C                   MOVEL(P)  @100          SFANAME
018000120813     C                   ENDIF
018100120813    ***
018200120813     C                   EVAL      SFSTATUS = ZZSTATUS
018300120813    ***
018400120813     C                   ADD       1             RR1
018500120813     C*
018600120813    1C                   IF        @1STLOOP = '0'
018700120813     C                   Z-ADD     RR1           SFLPOS
018800120813     C                   MOVE      '1'           @1STLOOP
018900120813    1C                   ENDIF
019000120813     C*
019100120813     C                   WRITE     S01SFL
019200120813     C*
019300120813     C                   ADD       1             #CNTREC
019400120813    1C                   IF        #CNTREC = 100
019500120813     C                   MOVE      '1'           @SFLOOP
019600120813    1C                   ENDIF
019700120813    ***
019800120813     C                   ENDSR
019900120813   S***S
020000120813     C     $SFLCTL       BEGSR
020100120813    ***
020200120813     C                   EVAL      EMSG = @EMSG
020300120813    ***
020400120813     C                   WRITE     S01REC
020500120813     C                   EXFMT     S01CTL
020600120813    ***
020700120813     C                   MOVE      *BLANKS       EMSG
020800120813     C                   MOVE      *BLANKS       @EMSG
020900120813    ***
021000120813     C                   IF        FKEY = F3
021100120813     C                   EVAL      @PROC = 'EXIT APP  '
021200120813     C                   LEAVESR
021300120813     C                   ENDIF
021400120813    ***
021500120813     C                   IF        FKEY = F6
021600120813     C                   SETOFF                                       3940
021700120813     C                   CLEAR                   S02R
021800120813     C                   EVAL      CONAME = HLD@NAME
021900120813     C                   EVAL      @PROC = 'ADD ACCT  '
022000120813     C                   LEAVESR
022100120813     C                   ENDIF
022200120813    ***
022300120813     C                   EVAL      @PROC = 'CHECK SELC'
022400120813    ***
022500120813     C                   ENDSR
022600120813   S***S
022700120813     C     $ADDACCT      BEGSR
022800120813    ***
022900120813     C                   EXSR      $SCREEN2
023000120813    ***
023100120813     C                   IF        FKEY = F12
023200120813     C                   CLEAR                   S02R
023300120813     C                   EVAL      CONAME = HLD@NAME
023400120813     C                   EVAL      @PROC = 'SFL CONTRL'
023500120813     C                   LEAVESR
023600120813     C                   ENDIF
023700120813    ***
023800120813     C                   EVAL      KF@TRS  = SCTRST
023900120813     C                   EVAL      KF@SUB  = SCSUB#
024000120813     C                   EVAL      KF@ACC  = SCACCT
024100120813    ***
024200120813     C                   EVAL      ADD_MODE = YES
024300120813     C                   EXSR      $VALIDKEY
024400120813    ***
024500120813     C                   IF        VALID_REC = NO
024600120813     C                   LEAVESR
024700120813     C                   ENDIF
024800120813    ***
024900120813     C                   EXSR      $VALIDACC
025000120813    ***
025100120813     C                   IF        VALID_REC = NO
025200120813     C                   LEAVESR
025300120813     C                   ENDIF
025400120813    ***
025500120813     C                   SETON                                        3940
025600120813    ***
025700120813     C                   DOU       FKEY = F12 OR FKEY = F10
025800120813      *
025900120813     C                   EXSR      $SCREEN2
026000120813      *
026100120813     C                   IF        FKEY = F12
026200120813     C                   SETOFF                                       3940
026300120813     C                   LEAVESR
026400120813     C                   ENDIF
026500120813      *
026600120813     C                   IF        FKEY = F10
026700120813     C                   EXSR      $PREPACC
026800120813     C                   EVAL      CACID1 = 'GBSSMALLGROUP'
026900120813     C                   EVAL      CATXT1 = 'SUBMITTER ID'
027000120813     C                   EVAL      CACID2 = 'US'
027100120813     C                   EVAL      CATXT2 = 'COMPANY CODE'
027200120813     C                   EVAL      CACID3 = SCCID3
027300120813     C                   EVAL      CATXT3 = 'HMO GROUP NUMBER'
027400120813     C                   EVAL      CACID4 = 'GBSSMALLGROUP'
027500120813     C                   EVAL      CATXT4 = 'CUSTOMER NAME'
027600120813     C                   EVAL      CACID5 = SCCID5
027700120813     C                   EVAL      CATXT5 = 'CUSTOMER NUMBER'
027800130123     C                   EVAL      CATXT6 = %TRIM(ACNAM1)
027900130123     C                   EVAL      CACID6 = 'N/A'
028000120813     C                   EVAL      CASTATUS = SCSTATUS
028100120813     C                   WRITE     CARACCR
028200120813     C                   LEAVE
028300120813     C                   ENDIF
028400120813      *
028500120813     C                   ENDDO
028600120813    ***
028700120815     C                   EVAL      @PROC = 'BUILD SFL '
028800120813    ***
028900120813     C                   ENDSR
029000120813   S***S
029100120813     C     $SCREEN2      BEGSR
029200120813    ***
029300120813     C                   EVAL      EMSG = @EMSG
029400120813     C                   EXFMT     S02R
029500120813     C                   CLEAR                   @EMSG
029600120813     C                   EVAL      EMSG = *BLANKS
029700120813    ***
029800120813     C                   ENDSR
029900120813   S***S
030000120813     C     $VALIDKEY     BEGSR
030100120813    ***
030200120813     C                   EVAL      VALID_REC = NO
030300120813    ***
030400120813     C                   IF        KF@TRS = 0
030500120813     C                   EVAL      @EMSG = 'MISSING TRUST'
030600120813     C                   LEAVESR
030700120813     C                   ENDIF
030800120813    ***
030900120813     C     KF@TRS        CHAIN     TRSMSR
031000120813     C                   IF        NOT %FOUND(TRMUNIQUE)
031100120813     C                   EVAL      O_TNAM = '**ERROR**'
031200120813     C                   EVAL      @EMSG = 'INVALID TRUST'
031300120813     C                   LEAVESR
031400120813     C                   ENDIF
031500120813    ***
031600120813     C                   MOVEL(P)  TDESCR        O_TNAM
031700120813    ***
031800120813     C                   IF        KF@SUB = 0
031900120813     C                   EVAL      @EMSG = 'MISSING SUBDIVISION'
032000120813     C                   LEAVESR
032100120813     C                   ENDIF
032200120813    ***
032300120813     C     KL#TS         CHAIN     SUBMSR
032400120813     C                   IF        NOT %FOUND(SUMUNIQUE)
032500120813     C                   EVAL      O_SUBN = '**ERROR**'
032600120813     C                   EVAL      @EMSG = 'INVALID TRUST/SUBDIVISION'
032700120813     C                   LEAVESR
032800120813     C                   ENDIF
032900120813    ***
033000120813     C                   MOVEL(P)  SUBDSC        O_SUBN
033100120813    ***
033200120813     C                   IF        KF@ACC = 0
033300120813     C                   EVAL      @EMSG = 'MISSING ACCOUNT'
033400120813     C                   LEAVESR
033500120813     C                   ENDIF
033600120813    ***
033700120813     C     KL#TSA        CHAIN     ACCMSR
033800120813     C                   IF        NOT %FOUND(ACMUNIQUE)
033900120813     C                   EVAL      O_ACCN = '**ERROR**'
034000120813     C                   EVAL      @EMSG = 'INVALID TRUST/SUB/ACCOUNT'
034100120813     C                   LEAVESR
034200120813     C                   ENDIF
034300120813    ***
034400120813     C                   MOVE      *BLANKS       @100
034500120813     C                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
034600120813     C                             %TRIM(ACNAM2)
034700120813     C                   MOVEL(P)  @100          O_ACCN
034800120813    ***
034900120813     C                   IF        ADD_MODE = YES
035000120813     C     KL#UTSA       CHAIN     CARACCR
035100120813     C                   IF        %FOUND(CARACCP)
035200120813     C                   EVAL      @EMSG = 'T/S/A VALUE ALREADY EXISTS'
035300120813     C                   LEAVESR
035400120813     C                   ENDIF
035500120813     C                   ENDIF
035600120813    ***
035700120813     C                   EVAL      VALID_REC = YES
035800120813    ***
035900120813     C                   ENDSR
036000120813   S***S
036100120813     C     $VALIDACC     BEGSR
036200120813    ***
036300120813     C                   EVAL      VALID_REC = NO
036400120813    ***
036500120813     C                   IF        SCCID3 = *BLANKS AND SCCID5 = *BLANKS
036600120813     C                   EVAL      @EMSG = 'HMO AND PPO CANNOT BOTH BE BLANK'
036700120813     C                   LEAVESR
036800120813     C                   ENDIF
036900120813    ***
037000120813     C                   IF        SCSTATUS <> 'Y' AND SCSTATUS <> 'N'
037100120813     C                   EVAL      @EMSG = 'VALID TRANSMIT FLAG REQUIRED'
037200120813     C                   LEAVESR
037300120813     C                   ENDIF
037400120813    ***
037500120813     C                   EVAL      VALID_REC = YES
037600120813    ***
037700120813     C                   ENDSR
037800120813   S***S
037900120813     C     $PREPACC      BEGSR
038000120813    ***
038100120813     C                   CLEAR                   CARACCR
038200120813     C                   EVAL      CAUNIQ = KF@UNIQ
038300120813     C                   EVAL      CATRST = KF@TRS
038400120813     C                   EVAL      CASUB# = KF@SUB
038500120813     C                   EVAL      CAACCT = KF@ACC
038600120813    ***
038700120813     C                   ENDSR
038800120813   S***S
038900120813     C     $CHKSELC      BEGSR
039000120813    ***
039100120816     C                   IF        I_TRST > 0
039200120813     C                   IF        I_TRST <> PRV#TRS OR
039300120813     C                             I_SUB# <> PRV#SUB OR
039400120813     C                             I_ACCT <> PRV#ACC
039500120813     C                   EVAL      PRV#TRS = I_TRST
039600120813     C                   EVAL      PRV#SUB = I_SUB#
039700120813     C                   EVAL      PRV#ACC = I_ACCT
039800120813     C                   EVAL      @PROC = 'PREP SFL  '
039900120813     C                   LEAVESR
040000120813     C                   ENDIF
040100120816     C                   ENDIF
040200120813    ***
040300120813    1C                   DOU       %EOF(AET520D)
040400120813     C                   READC     S01SFL
040500120813    2C                   IF        NOT %EOF(AET520D)
040600120813    ***
040700120813     C                   EVAL      KF@TRS  = SFTRST
040800120813     C                   EVAL      KF@SUB  = SFSUB#
040900120813     C                   EVAL      KF@ACC  = SFACCT
041000120813    ***
041100120813     C     KL#UTSA       CHAIN     CARACCR
041200120813    ***
041300120813     C                   SELECT
041400120813     C                   WHEN      SEL = 'I'
041500120813     C                   EXSR      $FMTSCR2
041600120813     C                   EXSR      $INQ2
041700120813     C                   WHEN      SEL = 'C'
041800120813     C                   EXSR      $FMTSCR2
041900120813     C                   EXSR      $CHG2
042000120813     C                   WHEN      SEL = 'A'
042100120813     C                   EVAL      CASTATUS = 'Y'
042200120813     C                   UPDATE    CARACCR
042300120813     C                   WHEN      SEL = 'T'
042400120813     C                   EVAL      CASTATUS = 'N'
042500120813     C                   UPDATE    CARACCR
042600120813     C                   ENDSL
042700120813    ***
042800120813    3C                   IF        @EMSG <> *BLANKS
042900120813     C                   LEAVESR
043000120813    3C                   ENDIF
043100120813     C*
043200120813     C                   MOVE      *BLANKS       SEL
043300120813     C                   UPDATE    S01SFL
043400120813     C*
043500120813    2C                   ENDIF
043600120813    1C                   ENDDO
043700120813    ***
043800120816     C                   EVAL      @PROC = 'PREP SFL  '
043900120813    ***
044000120813     C                   ENDSR
044100120813   S***S
044200120813     C     $FMTSCR2      BEGSR
044300120813    ***
044400120813     C                   SETOFF                                       3940
044500120813     C                   CLEAR                   S02R
044600120813     C                   EVAL      CONAME = HLD@NAME
044700120813    ***
044800120813     C                   EVAL      SCTRST = CATRST
044900120813     C                   EVAL      SCSUB# = CASUB#
045000120813     C                   EVAL      SCACCT = CAACCT
045100120813     C                   EVAL      SCSTATUS = CASTATUS
045200120813    ***
045300120813     C                   EXSR      $CHAINS
045400120813    ***
045500120813     C                   EVAL      SCCID3 = %TRIM(CACID3)
045600120813     C                   EVAL      SCCID5 = %TRIM(CACID5)
045700120813    ***
045800120813     C                   ENDSR
045900120813   S***S
046000120813     C     $CHAINS       BEGSR
046100120813    ***
046200120813     C     KF@TRS        CHAIN     TRSMSR
046300120813     C                   IF        %FOUND(TRMUNIQUE)
046400120813     C                   MOVEL(P)  TDESCR        O_TNAM
046500120813     C                   ENDIF
046600120813    ***
046700120813     C     KL#TS         CHAIN     SUBMSR
046800120813     C                   IF        %FOUND(SUMUNIQUE)
046900120813     C                   MOVEL(P)  SUBDSC        O_SUBN
047000120813     C                   ENDIF
047100120813    ***
047200120813     C     KL#TSA        CHAIN     ACCMSR
047300120813     C                   IF        %FOUND(ACMUNIQUE)
047400120813     C                   MOVE      *BLANKS       @100
047500120813     C                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
047600120813     C                             %TRIM(ACNAM2)
047700120813     C                   MOVEL(P)  @100          O_ACCN
047800120813     C                   ENDIF
047900120813    ***
048000120813     C                   ENDSR
048100120813   S***S
048200120813   S***S
048300120813     C     $INQ2         BEGSR
048400120813    ***
048500120813     C                   EVAL      EMSG = 'INQUIRY ONLY'
048600120813     C                   EVAL      *IN40 = *ON
048700120813     C                   DOU       FKEY = F12
048800120813     C                   EXFMT     S02R
048900120813     C                   ENDDO
049000120813    ***
049100120813     C                   ENDSR
049200120813   S***S
049300120813     C     $CHG2         BEGSR
049400120813    ***
049500120813     C                   EVAL      @EMSG = 'BE CAREFUL'
049600120813    ***
049700120813     C                   DOU       FKEY = F12
049800120813      *
049900120813     C                   EXSR      $SCREEN2
050000120813      *
050100120813     C                   IF        FKEY = F12
050200120813     C                   UNLOCK(E) CARACCP
050300120813     C                   SETOFF                                       3940
050400120813     C                   LEAVESR
050500120813     C                   ENDIF
050600120813      *
050700120813     C                   EVAL      KF@TRS  = SCTRST
050800120813     C                   EVAL      KF@SUB  = SCSUB#
050900120813     C                   EVAL      KF@ACC  = SCACCT
051000120813    ***
051100120813     C                   EVAL      ADD_MODE = NO
051200120813     C                   EXSR      $VALIDKEY
051300120813     C                   IF        VALID_REC = NO
051400120813     C                   ITER
051500120813     C                   ENDIF
051600120813    ***
051700120813     C                   EXSR      $VALIDACC
051800120813     C                   IF        VALID_REC = NO
051900120813     C                   ITER
052000120813     C                   ENDIF
052100120813    ***
052200120813     C                   SETON                                        3940
052300120813     C                   DOU       FKEY = F12 OR FKEY = F10
052400120813     C                   EXSR      $SCREEN2
052500120813    ***
052600120813     C                   IF        FKEY = F12
052700120813     C                   SETOFF                                       3940
052800120813     C                   LEAVESR
052900120813     C                   ENDIF
053000120813    ***
053100120813     C                   IF        FKEY = F10
053200120813     C                   EVAL      CACID3 = SCCID3
053300120813     C                   EVAL      CACID5 = SCCID5
053400120813     C                   EVAL      CASTATUS = SCSTATUS
053500120813     C                   UPDATE    CARACCR
053600120813     C                   LEAVESR
053700120813     C                   ENDIF
053800120813    ***
053900120813     C                   ENDDO
054000120813    ***
054100120813     C                   ENDDO
054200120813    ***
054300120813     C                   ENDSR
054400120813   S***S
