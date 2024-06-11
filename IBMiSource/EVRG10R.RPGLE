000100160405      *========================================================================
000200160405     H option(*noDebugIo)
000300160405      *========================================================================
000400140918    *** EVERGREEN ACCOUNT MAPPING
000500140918    *** CARRIER EXPORT # 114
000600140918    *** SSK  09/18/2014
000700140918    ***
000800140918    ***
000900160405      *========================================================================
001000140918     FEVRG10D   CF   E             WORKSTN INFDS(WSDS) SFILE(S01SFL:RR1)
001100140918     FCARACCP   UF A E           K DISK
001200140918     FCARACCQ   IF   E           K DISK    RENAME(CARACCR:CAL2) PREFIX(ZZ:2)
001300140918     FTRMUNIQUE IF   E           K DISK
001400140918     FSUMUNIQUE IF   E           K DISK
001500140918     FACMUNIQUE IF   E           K DISK
001600160405     FDIARYHD1  O    E           K DISK    EXTFILE('F.DIARYHD1')
001700160405     FHISTAK    O    E           K DISK    EXTFILE('F.HISTAK')
001800160405      *========================================================================
001900160405
002000140918     D HLD@NAME        S             40A
002100140918     D @EMSG           S                   LIKE(EMSG)
002200140918     D PRV#TRS         S                   LIKE(I_TRST)
002300140918     D PRV#SUB         S                   LIKE(I_SUB#)
002400140918     D PRV#ACC         S                   LIKE(I_ACCT)
002500140918     D ADD_MODE        S               N   INZ(*OFF)
002600140918     D VALID_REC       S               N   INZ(*OFF)
002700140918     D YES             S               N   INZ(*ON)
002800140918     D NO              S               N   INZ(*OFF)
002900140918    ***
003000140918     D WSDS            DS
003100140918     D  FKEY                 369    369A
003200140918    ***
003300140918     D  F1             C                   CONST(X'31')
003400140918     D  F2             C                   CONST(X'32')
003500140918     D  F3             C                   CONST(X'33')
003600140918     D  F4             C                   CONST(X'34')
003700140918     D  F5             C                   CONST(X'35')
003800140918     D  F6             C                   CONST(X'36')
003900140918     D  F7             C                   CONST(X'37')
004000140918     D  F8             C                   CONST(X'38')
004100140918     D  F9             C                   CONST(X'39')
004200140918     D  F10            C                   CONST(X'3A')
004300140918     D  F11            C                   CONST(X'3B')
004400140918     D  F12            C                   CONST(X'3C')
004500140918     D  F13            C                   CONST(X'B1')
004600140918     D  F14            C                   CONST(X'B2')
004700140918     D  F15            C                   CONST(X'B3')
004800140918     D  F16            C                   CONST(X'B4')
004900140918     D  F17            C                   CONST(X'B5')
005000140918     D  F18            C                   CONST(X'B6')
005100140918     D  F19            C                   CONST(X'B7')
005200140918     D  F20            C                   CONST(X'B8')
005300140918     D  F21            C                   CONST(X'B9')
005400140918     D  F22            C                   CONST(X'BA')
005500140918     D  F23            C                   CONST(X'BB')
005600140918     D  F24            C                   CONST(X'BC')
005700140918    ***
005800140918     D                UDS
005900140918     D  XONAME               201    240
006000140918    ***
006100140918     D KF@UNIQ         S                   LIKE(CAUNIQ)
006200140918     D                                     INZ('0000000114')
006300140918     D KF@TRS          S                   LIKE(CATRST)
006400140918     D KF@SUB          S                   LIKE(CASUB#)
006500140918     D KF@ACC          S                   LIKE(CAACCT)
006600140918     D @PROC           S             10A
006700160405
006800160405     D statusHold      S              1
006900160405
007000160405     D sds            SDS
007100160405     D  UserID               254    263
007200160405
007300160405      *=====================================================================
007400140918     C                   DOU       @PROC = 'EXIT APP  '
007500140918     C     @PROC         CASEQ     'PREP SFL  '  $PREPSFL
007600140918     C     @PROC         CASEQ     'BUILD SFL '  $BLDSFL
007700140918     C     @PROC         CASEQ     'SFL CONTRL'  $SFLCTL
007800140918     C     @PROC         CASEQ     'ADD ACCT  '  $ADDACCT
007900140918     C     @PROC         CASEQ     'CHECK SELC'  $CHKSELC
008000140918     C                   ENDCS
008100140918     C                   ENDDO
008200140918     C*
008300140918     C                   MOVE      *ON           *INLR
008400140918     C*
008500140918   S***S
008600140918     C     *INZSR        BEGSR
008700140918    ***
008800140918     C                   EVAL      @PROC = 'PREP SFL  '
008900140918    ***
009000140918     C     KL#TS         KLIST
009100140918     C                   KFLD                    KF@TRS
009200140918     C                   KFLD                    KF@SUB
009300140918    ***
009400140918     C     KL#TSA        KLIST
009500140918     C                   KFLD                    KF@TRS
009600140918     C                   KFLD                    KF@SUB
009700140918     C                   KFLD                    KF@ACC
009800140918    ***
009900140918     C                   EVAL      HLD@NAME = XONAME
010000140918    ***
010100140918     C     KL#UTSA       KLIST
010200140918     C                   KFLD                    KF@UNIQ
010300140918     C                   KFLD                    KF@TRS
010400140918     C                   KFLD                    KF@SUB
010500140918     C                   KFLD                    KF@ACC
010600140918    ***
010700140918     C                   ENDSR
010800140918   S***S
010900140918     C     $PREPSFL      BEGSR
011000140918    ***
011100140918     C                   MOVE      *ZEROS        RR1               4 0
011200140918     C                   MOVE      *ZEROS        #CNTREC           4 0
011300140918    ***
011400140918     C                   EVAL      *IN39 = *OFF
011500140918     C                   EVAL      *IN40 = *OFF
011600140918    ***
011700140918     C                   EVAL      @PROC = 'BUILD SFL '
011800140918    ***
011900140918     C                   ENDSR
012000140918   S***S
012100140918     C* INITIALIZE THE SUBFILE
012200140918    ***
012300140918     C     $CLRSFL       BEGSR
012400140918    ***
012500140918     C                   MOVEA     '011'         *IN(25)
012600140918     C                   WRITE     S01CTL
012700140918     C                   MOVEA     '010'         *IN(25)
012800140918     C                   Z-ADD     *ZERO         RR1
012900140918    ***
013000140918     C                   ENDSR
013100140918   S***S
013200140918     C     $BLDSFL       BEGSR
013300140918    ***
013400140918     C                   MOVE      *ZEROS        #CNTREC
013500140918     C                   MOVE      '0'           @1STLOOP          1
013600140918     C                   MOVE      '0'           @SFLOOP           1
013700140918     C                   MOVE      '0'           *IN20
013800140918    ***
013900140918     C                   IF        I_TRST = 0
014000140918     C                   EVAL      KF@TRS = 001
014100140918     C                   EVAL      KF@SUB = 001
014200140918     C                   EVAL      KF@ACC = 001
014300140918     C                   ELSE
014400140918     C                   EVAL      KF@TRS = I_TRST
014500140918     C                   EVAL      KF@SUB = I_SUB#
014600140918     C                   EVAL      KF@ACC = I_ACCT
014700140918     C                   ENDIF
014800140918     C                   EVAL      I_TRST = 0
014900140918     C                   EVAL      I_SUB# = 0
015000140918     C                   EVAL      I_ACCT = 0
015100140918    ***
015200140918     C                   EXSR      $CLRSFL
015300140918     C                   EVAL      CONAME = HLD@NAME
015400140918    ***
015500140918     C     KL#TSA        SETLL     CAL2
015600140918    1C                   DOU       %EOF(CARACCQ) OR @SFLOOP = '1'
015700140918     C                   READ      CAL2
015800140918    2C                   IF        NOT %EOF(CARACCQ) AND
015900140918     C                             ZZUNIQ = KF@UNIQ
016000140918     C                   EXSR      $LOADSFL
016100140918    2C                   ENDIF
016200140918    1C                   ENDDO
016300140918    ***
016400140918     C                   EVAL      @PROC = 'SFL CONTRL'
016500140918    ***
016600140918     C                   ENDSR
016700140918   S***S
016800140918     C     $LOADSFL      BEGSR
016900140918    ***
017000140918     C                   MOVE      *ON           *IN25
017100140918     C                   MOVE      *BLANKS       SEL
017200140918    ***
017300140918     C                   EVAL      HUNIQ = ZZUNIQ
017400140918     C                   EVAL      SFTRST = ZZTRST
017500140918     C                   EVAL      SFSUB# = ZZSUB#
017600140918     C                   EVAL      SFACCT = ZZACCT
017700140918    ***
017800140918     C                   EVAL      KF@TRS  = ZZTRST
017900140918     C                   EVAL      KF@SUB  = ZZSUB#
018000140918     C                   EVAL      KF@ACC  = ZZACCT
018100140918    ***
018200140918     C     KL#TSA        CHAIN     ACCMSR
018300140918     C                   IF        NOT %FOUND(ACMUNIQUE)
018400140918     C                   EVAL      SFANAME = '**ERROR**'
018500140918     C                   ELSE
018600140918     C                   MOVE      *BLANKS       @100            100
018700140918     C                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
018800140918     C                             %TRIM(ACNAM2)
018900140918     C                   MOVEL(P)  @100          SFANAME
019000140918     C                   ENDIF
019100140918    ***
019200140918     C                   EVAL      SFSTATUS = ZZSTATUS
019300140918    ***
019400140918     C                   ADD       1             RR1
019500140918     C*
019600140918    1C                   IF        @1STLOOP = '0'
019700140918     C                   Z-ADD     RR1           SFLPOS
019800140918     C                   MOVE      '1'           @1STLOOP
019900140918    1C                   ENDIF
020000140918     C*
020100140918     C                   WRITE     S01SFL
020200140918     C*
020300140918     C                   ADD       1             #CNTREC
020400140918    1C                   IF        #CNTREC = 300
020500140918     C                   MOVE      '1'           @SFLOOP
020600140918    1C                   ENDIF
020700140918    ***
020800140918     C                   ENDSR
020900140918   S***S
021000140918     C     $SFLCTL       BEGSR
021100140918    ***
021200140918     C                   EVAL      EMSG = @EMSG
021300140918    ***
021400140918     C                   WRITE     S01REC
021500140918     C                   EXFMT     S01CTL
021600140918    ***
021700140918     C                   MOVE      *BLANKS       EMSG
021800140918     C                   MOVE      *BLANKS       @EMSG
021900140918    ***
022000140918     C                   IF        FKEY = F3
022100140918     C                   EVAL      @PROC = 'EXIT APP  '
022200140918     C                   LEAVESR
022300140918     C                   ENDIF
022400140918    ***
022500140918     C                   IF        FKEY = F6
022600140918     C                   SETOFF                                       394041
022700140918     C                   CLEAR                   S02R
022800140918     C                   EVAL      CONAME = HLD@NAME
022900140918     C                   EVAL      @PROC = 'ADD ACCT  '
023000140918     C                   LEAVESR
023100140918     C                   ENDIF
023200140918    ***
023300140918     C                   EVAL      @PROC = 'CHECK SELC'
023400140918    ***
023500140918     C                   ENDSR
023600140918   S***S
023700140918     C     $ADDACCT      BEGSR
023800140918    ***
023900140918     C                   EXSR      $SCREEN2
024000140918    ***
024100140918     C                   IF        FKEY = F12
024200140918     C                   CLEAR                   S02R
024300140918     C                   EVAL      CONAME = HLD@NAME
024400140918     C                   EVAL      @PROC = 'SFL CONTRL'
024500140918     C                   LEAVESR
024600140918     C                   ENDIF
024700140918    ***
024800140918     C                   EVAL      KF@TRS  = SCTRST
024900140918     C                   EVAL      KF@SUB  = SCSUB#
025000140918     C                   EVAL      KF@ACC  = SCACCT
025100140918    ***
025200140918     C                   EVAL      ADD_MODE = YES
025300140918     C                   EXSR      $VALIDKEY
025400140918    ***
025500140918     C                   IF        VALID_REC = NO
025600140918     C                   LEAVESR
025700140918     C                   ENDIF
025800140918    ***
025900140918     C                   EXSR      $VALIDACC
026000140918    ***
026100140918     C                   IF        VALID_REC = NO
026200140918     C                   LEAVESR
026300140918     C                   ENDIF
026400140918    ***
026500140918     C                   SETON                                        3940
026600140918    ***
026700140918     C                   DOU       FKEY = F12 OR FKEY = F10
026800140918      *
026900140918     C                   EXSR      $SCREEN2
027000140918      *
027100140918     C                   IF        FKEY = F12
027200140918     C                   SETOFF                                       394041
027300140918     C                   LEAVESR
027400140918     C                   ENDIF
027500140918      *
027600140918     C                   IF        FKEY = F10
027700140918     C                   EXSR      $PREPACC
027800140918     C                   EVAL      CACID1 = 'N/A'
027900140918     C                   EVAL      CATXT1 = 'N/A'
028000140918     C                   EVAL      CACID2 = 'N/A'
028100140918     C                   EVAL      CATXT2 = 'N/A'
028200140918     C                   EVAL      CACID3 = 'N/A'
028300140918     C                   EVAL      CATXT3 = 'N/A'
028400140918     C                   EVAL      CACID4 = 'N/A'
028500140918     C                   EVAL      CATXT4 = 'N/A'
028600140918     C                   EVAL      CACID5 = 'N/A'
028700140918     C                   EVAL      CATXT5 = 'N/A'
028800140918     C                   EVAL      CACID6 = 'N/A'
028900140918     C                   EVAL      CATXT6 = 'N/A'
029000140918     C                   EVAL      CACID7 = 'N/A'
029100140918     C                   EVAL      CATXT7 = 'N/A'
029200140918     C                   EVAL      CACID8 = 'N/A'
029300140918     C                   EVAL      CATXT8 = 'N/A'
029400140918     C                   EVAL      CACID9 = 'N/A'
029500140918     C                   EVAL      CATXT9 = 'N/A'
029600140918     C                   EVAL      CACIDA = 'N/A'
029700140918     C                   EVAL      CATXTA = 'N/A'
029800140918     C                   EVAL      CASTATUS = SCSTATUS
029900160405     c                   eval      statusHold = castatus
030000160405     c                   exsr      diaryNote
030100140918     C                   WRITE     CARACCR
030200140918     C                   LEAVE
030300140918     C                   ENDIF
030400140918      *
030500140918     C                   ENDDO
030600140918    ***
030700140918     C                   EVAL      @PROC = 'BUILD SFL '
030800140918    ***
030900140918     C                   ENDSR
031000140918   S***S
031100140918     C     $SCREEN2      BEGSR
031200140918    ***
031300140918     C                   EVAL      EMSG = @EMSG
031400140918     C                   EXFMT     S02R
031500140918     C                   CLEAR                   @EMSG
031600140918     C                   EVAL      EMSG = *BLANKS
031700140918    ***
031800140918     C                   ENDSR
031900140918   S***S
032000140918     C     $VALIDKEY     BEGSR
032100140918    ***
032200140918     C                   EVAL      VALID_REC = NO
032300140918    ***
032400140918     C                   IF        KF@TRS = 0
032500140918     C                   EVAL      @EMSG = 'MISSING TRUST'
032600140918     C                   LEAVESR
032700140918     C                   ENDIF
032800140918    ***
032900140918     C     KF@TRS        CHAIN     TRSMSR
033000140918     C                   IF        NOT %FOUND(TRMUNIQUE)
033100140918     C                   EVAL      O_TNAM = '**ERROR**'
033200140918     C                   EVAL      @EMSG = 'INVALID TRUST'
033300140918     C                   LEAVESR
033400140918     C                   ENDIF
033500140918    ***
033600140918     C                   MOVEL(P)  TDESCR        O_TNAM
033700140918    ***
033800140918     C                   IF        KF@SUB = 0
033900140918     C                   EVAL      @EMSG = 'MISSING SUBDIVISION'
034000140918     C                   LEAVESR
034100140918     C                   ENDIF
034200140918    ***
034300140918     C     KL#TS         CHAIN     SUBMSR
034400140918     C                   IF        NOT %FOUND(SUMUNIQUE)
034500140918     C                   EVAL      O_SUBN = '**ERROR**'
034600140918     C                   EVAL      @EMSG = 'INVALID TRUST/SUBDIVISION'
034700140918     C                   LEAVESR
034800140918     C                   ENDIF
034900140918    ***
035000140918     C                   MOVEL(P)  SUBDSC        O_SUBN
035100140918    ***
035200140918     C                   IF        KF@ACC = 0
035300140918     C                   EVAL      @EMSG = 'MISSING ACCOUNT'
035400140918     C                   LEAVESR
035500140918     C                   ENDIF
035600140918    ***
035700140918     C     KL#TSA        CHAIN     ACCMSR
035800140918     C                   IF        NOT %FOUND(ACMUNIQUE)
035900140918     C                   EVAL      O_ACCN = '**ERROR**'
036000140918     C                   EVAL      @EMSG = 'INVALID TRUST/SUB/ACCOUNT'
036100140918     C                   LEAVESR
036200140918     C                   ENDIF
036300140918    ***
036400140918     C                   MOVE      *BLANKS       @100
036500140918     C                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
036600140918     C                             %TRIM(ACNAM2)
036700140918     C                   MOVEL(P)  @100          O_ACCN
036800140918    ***
036900140918     C                   IF        ADD_MODE = YES
037000140918     C     KL#UTSA       CHAIN     CARACCR
037100140918     C                   IF        %FOUND(CARACCP)
037200140918     C                   EVAL      @EMSG = 'T/S/A VALUE ALREADY EXISTS'
037300140918     C                   LEAVESR
037400140918     C                   ENDIF
037500140918     C                   ENDIF
037600140918    ***
037700140918     C                   EVAL      VALID_REC = YES
037800140918    ***
037900140918     C                   ENDSR
038000140918   S***S
038100140918     C     $VALIDACC     BEGSR
038200140918    ***
038300140918     C                   EVAL      VALID_REC = NO
038400140918    ***
038500140918     C                   IF        SCSTATUS <> 'Y' AND SCSTATUS <> 'N'
038600140918     C                   EVAL      @EMSG = 'VALID TRANSMIT FLAG REQUIRED'
038700140918     C                   LEAVESR
038800140918     C                   ENDIF
038900140918    ***
039000140918     C                   EVAL      VALID_REC = YES
039100140918    ***
039200140918     C                   ENDSR
039300140918   S***S
039400140918     C     $PREPACC      BEGSR
039500140918    ***
039600140918     C                   CLEAR                   CARACCR
039700140918     C                   EVAL      CAUNIQ = KF@UNIQ
039800140918     C                   EVAL      CATRST = KF@TRS
039900140918     C                   EVAL      CASUB# = KF@SUB
040000140918     C                   EVAL      CAACCT = KF@ACC
040100140918    ***
040200140918     C                   ENDSR
040300140918   S***S
040400140918     C     $CHKSELC      BEGSR
040500140918    ***
040600140918     C                   IF        I_TRST > 0
040700140918     C                   IF        I_TRST <> PRV#TRS OR
040800140918     C                             I_SUB# <> PRV#SUB OR
040900140918     C                             I_ACCT <> PRV#ACC
041000140918     C                   EVAL      PRV#TRS = I_TRST
041100140918     C                   EVAL      PRV#SUB = I_SUB#
041200140918     C                   EVAL      PRV#ACC = I_ACCT
041300140918     C                   EVAL      @PROC = 'PREP SFL  '
041400140918     C                   LEAVESR
041500140918     C                   ENDIF
041600140918     C                   ENDIF
041700140918    ***
041800140918    1C                   DOU       %EOF(EVRG10D)
041900140918     C                   READC     S01SFL
042000140918    2C                   IF        NOT %EOF(EVRG10D)
042100140918    ***
042200140918     C                   EVAL      KF@TRS  = SFTRST
042300140918     C                   EVAL      KF@SUB  = SFSUB#
042400140918     C                   EVAL      KF@ACC  = SFACCT
042500140918    ***
042600140918     C     KL#UTSA       CHAIN     CARACCR
042700140918    ***
042800140918     C                   SELECT
042900140918      *
043000140918     C                   WHEN      SEL = 'P'
043100140918     C                   EXSR      $CALLPLNS
043200140918      *
043300140918     C                   WHEN      SEL = 'I'
043400140918     C                   EXSR      $FMTSCR2
043500140918     C                   EXSR      $INQ2
043600140918      *
043700140918     C                   WHEN      SEL = 'C'
043800140918     C                   EXSR      $FMTSCR2
043900140918     C                   EXSR      $CHG2
044000140918      *
044100140918     C                   WHEN      SEL = 'A'
044200140918     C                   EVAL      CASTATUS = 'Y'
044300160405     c                   eval      statusHold = castatus
044400160405     c                   exsr      diaryNote
044500140918     C                   UPDATE    CARACCR
044600140918      *
044700140918     C                   WHEN      SEL = 'T'
044800140918     C                   EVAL      CASTATUS = 'N'
044900160405     c                   eval      statusHold = castatus
045000160405     c                   exsr      diaryNote
045100140918     C                   UPDATE    CARACCR
045200140918      *
045300140918     C                   ENDSL
045400140918    ***
045500140918    3C                   IF        @EMSG <> *BLANKS
045600140918     C                   LEAVESR
045700140918    3C                   ENDIF
045800140918     C*
045900140918     C                   MOVE      *BLANKS       SEL
046000140918     C                   UPDATE    S01SFL
046100140918     C*
046200140918    2C                   ENDIF
046300140918    1C                   ENDDO
046400140918    ***
046500140918     C****               EVAL      @PROC = 'PREP SFL  '
046600140918     C                   EVAL      @PROC = 'SFL CONTRL'
046700140918    ***
046800140918     C                   ENDSR
046900160405       //=======================================================================
047000160405       // Diary Note
047100160405       //=======================================================================
047200160405
047300160405       begsr diaryNote;
047400160405
047500160405        nhkey = %editc(catrst: 'X') + %editc(casub#: 'X') + %editc(caacct: 'X');
047600160405        nhcode = 'WFT';
047700160405
047800160405        if statusHold = 'Y';
047900160405         nhsubj = 'EVRGR-TRANSMISSION TURNED ON';
048000160405        endif;
048100160405
048200160405        if statusHold = 'N';
048300160405         nhsubj = 'EVRGR-TRANSMISSION TURNED OFF';
048400160405        endif;
048500160405
048600160405        nhaddt = %dec(%date);
048700160405        nhadti = %dec(%time);
048800160405        nhadus = userID;
048900160405
049000160405        write rdiaryhd;
049100160405
049200160405        clear histr;
049300160405        hkey = %editc(catrst: 'X') + %editc(casub#: 'X') + %editc(caacct: 'X');
049400160405        trcode = 'UHM';
049500160405
049600160405        if statusHold = 'Y';
049700160405         ck#not = 'EVRGR-TRANSMISSION TURNED ON';
049800160405        endif;
049900160405
050000160405        if statusHold = 'N';
050100160405         ck#not = 'EVRGR-TRANSMISSION TURNED OFF';
050200160405        endif;
050300160405
050400160405        hprgnm = 'EVRG10R';
050500160405        hstrst = catrst;
050600160405        hssub# = casub#;
050700160405        hsacct = caacct;
050800160405        hsdltd = 'A';
050900160405        trdate = %dec(%date);
051000160405        hstrtime = %time;
051100160405        hoper  = userID;
051200160405
051300160405        write histr;
051400160405
051500160405       endsr;
051600160405
051700160405       //=======================================================================
051800160405
051900140918     C     $CALLPLNS     BEGSR
052000140918    ***
052100140918     C                   EVAL      PRM@OUT = %EDITC(CATRST:'X') +
052200140918     C                             %EDITC(CASUB#:'X') +
052300140918     C                             %EDITC(CAACCT:'X') + '*'
052400140918     C                   CALL      'EVRG11CL'
052500140918     C                   PARM                    PRM@OUT          11
052600140918    ***
052700140918     C                   ENDSR
052800140918   S***S
052900140918     C     $FMTSCR2      BEGSR
053000140918    ***
053100140918     C                   SETOFF                                       394041
053200140918     C                   CLEAR                   S02R
053300140918     C                   EVAL      CONAME = HLD@NAME
053400140918    ***
053500140918     C                   EVAL      SCTRST = CATRST
053600140918     C                   EVAL      SCSUB# = CASUB#
053700140918     C                   EVAL      SCACCT = CAACCT
053800140918     C                   EVAL      SCSTATUS = CASTATUS
053900140918    ***
054000140918     C                   EXSR      $CHAINS
054100140918    ***
054200140918     C                   ENDSR
054300140918   S***S
054400140918     C     $CHAINS       BEGSR
054500140918    ***
054600140918     C     KF@TRS        CHAIN     TRSMSR
054700140918     C                   IF        %FOUND(TRMUNIQUE)
054800140918     C                   MOVEL(P)  TDESCR        O_TNAM
054900140918     C                   ENDIF
055000140918    ***
055100140918     C     KL#TS         CHAIN     SUBMSR
055200140918     C                   IF        %FOUND(SUMUNIQUE)
055300140918     C                   MOVEL(P)  SUBDSC        O_SUBN
055400140918     C                   ENDIF
055500140918    ***
055600140918     C     KL#TSA        CHAIN     ACCMSR
055700140918     C                   IF        %FOUND(ACMUNIQUE)
055800140918     C                   MOVE      *BLANKS       @100
055900140918     C                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
056000140918     C                             %TRIM(ACNAM2)
056100140918     C                   MOVEL(P)  @100          O_ACCN
056200140918     C                   ENDIF
056300140918    ***
056400140918     C                   ENDSR
056500140918   S***S
056600140918   S***S
056700140918     C     $INQ2         BEGSR
056800140918    ***
056900140918     C                   EVAL      EMSG = 'INQUIRY ONLY'
057000140918     C                   EVAL      *IN40 = *ON
057100140918     C                   DOU       FKEY = F12
057200140918     C                   EXFMT     S02R
057300140918     C                   ENDDO
057400140918    ***
057500140918     C                   ENDSR
057600140918   S***S
057700140918     C     $CHG2         BEGSR
057800140918    ***
057900140918     C                   EVAL      @EMSG = 'BE CAREFUL'
058000140918       *IN41 = *ON;
058100140918    ***
058200140918     C                   DOU       FKEY = F12
058300140918      *
058400140918     C                   EXSR      $SCREEN2
058500140918      *
058600140918     C                   IF        FKEY = F12
058700140918     C                   UNLOCK(E) CARACCP
058800140918     C                   SETOFF                                       394041
058900140918     C                   LEAVESR
059000140918     C                   ENDIF
059100140918      *
059200140918     C                   EVAL      KF@TRS  = SCTRST
059300140918     C                   EVAL      KF@SUB  = SCSUB#
059400140918     C                   EVAL      KF@ACC  = SCACCT
059500140918    ***
059600140918     C                   EVAL      ADD_MODE = NO
059700140918     C                   EXSR      $VALIDKEY
059800140918     C                   IF        VALID_REC = NO
059900140918     C                   ITER
060000140918     C                   ENDIF
060100140918    ***
060200140918     C                   EXSR      $VALIDACC
060300140918     C                   IF        VALID_REC = NO
060400140918     C                   ITER
060500140918     C                   ENDIF
060600140918    ***
060700140918     C                   SETON                                        3940
060800140918     C                   DOU       FKEY = F12 OR FKEY = F10
060900140918     C                   EXSR      $SCREEN2
061000140918    ***
061100140918     C                   IF        FKEY = F12
061200140918     C                   SETOFF                                       394041
061300140918     C                   LEAVESR
061400140918     C                   ENDIF
061500140918    ***
061600140918     C                   IF        FKEY = F10
061700140918     C                   EVAL      CASTATUS = SCSTATUS
061800160405     c                   eval      statusHold = castatus
061900160405     c                   exsr      diaryNote
062000140918     C                   UPDATE    CARACCR
062100140918     C                   LEAVESR
062200140918     C                   ENDIF
062300140918    ***
062400140918     C                   ENDDO
062500140918    ***
062600140918     C                   ENDDO
062700140918    ***
062800140918     C                   ENDSR
062900140918   S***S
