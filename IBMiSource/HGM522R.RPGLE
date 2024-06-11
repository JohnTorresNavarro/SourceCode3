000100160311      *========================================================================
000200160311     H option(*noDebugIo)
000300160311      *========================================================================
000400160311      *
000500160927      *  Description: Highmark account mapping.
000600160311      *  Programmer.:
000700160311      *  Date.......:
000800160311      *
000900160311      *-------------------------------------------------------------------------
001000160311      * Modifications
001100160311      *
001200160311      * Date         Programmer    Description
001300160311      * ---------    ----------    ---------------------------------------------
001400160311      * 03/11/2016   J. Torres     Added history and diary files records when
001500160311      *                            transmisson is changed to 'T' or 'A'.
001600160311
001700180724      * 07/24/2018   J. Torres     Added call to new send/not send program that
001800180724      *                            maintains new file.
001900180724
002000160311      *=========================================================================
002100160927    *** HIGHMARK GROUP ACCOUNT MAPPING
002200120813    ***
002300120813    *** SSK  08/13/2012
002400120813    ***
002500130315    *** 03/15/2013 SSK ADD LIFE PRODUCT
002600120813    ***
002700160927     FHGM522D   CF   E             WORKSTN INFDS(WSDS) SFILE(S01SFL:RR1)
002800120813     FCARACCP   UF A E           K DISK
002900120813     FCARACCQ   IF   E           K DISK    RENAME(CARACCR:CAL2) PREFIX(ZZ:2)
003000120813     FTRMUNIQUE IF   E           K DISK
003100120813     FSUMUNIQUE IF   E           K DISK
003200120813     FACMUNIQUE IF   E           K DISK
003300160311     FDIARYHD1  O    E           K DISK    EXTFILE('F.DIARYHD1')
003400160311     FHISTAK    O    E           K DISK    EXTFILE('F.HISTAK')
003500120813   X***X
003600120813     D HLD@NAME        S             40A
003700120813     D @EMSG           S                   LIKE(EMSG)
003800120813     D PRV#TRS         S                   LIKE(I_TRST)
003900120813     D PRV#SUB         S                   LIKE(I_SUB#)
004000120813     D PRV#ACC         S                   LIKE(I_ACCT)
004100120813     D ADD_MODE        S               N   INZ(*OFF)
004200120813     D VALID_REC       S               N   INZ(*OFF)
004300120813     D YES             S               N   INZ(*ON)
004400120813     D NO              S               N   INZ(*OFF)
004500120813    ***
004600120813     D WSDS            DS
004700120813     D  FKEY                 369    369A
004800120813    ***
004900120813     D  F1             C                   CONST(X'31')
005000120813     D  F2             C                   CONST(X'32')
005100120813     D  F3             C                   CONST(X'33')
005200120813     D  F4             C                   CONST(X'34')
005300120813     D  F5             C                   CONST(X'35')
005400120813     D  F6             C                   CONST(X'36')
005500120813     D  F7             C                   CONST(X'37')
005600120813     D  F8             C                   CONST(X'38')
005700120813     D  F9             C                   CONST(X'39')
005800120813     D  F10            C                   CONST(X'3A')
005900120813     D  F11            C                   CONST(X'3B')
006000120813     D  F12            C                   CONST(X'3C')
006100120813     D  F13            C                   CONST(X'B1')
006200120813     D  F14            C                   CONST(X'B2')
006300120813     D  F15            C                   CONST(X'B3')
006400120813     D  F16            C                   CONST(X'B4')
006500120813     D  F17            C                   CONST(X'B5')
006600120813     D  F18            C                   CONST(X'B6')
006700120813     D  F19            C                   CONST(X'B7')
006800120813     D  F20            C                   CONST(X'B8')
006900120813     D  F21            C                   CONST(X'B9')
007000120813     D  F22            C                   CONST(X'BA')
007100120813     D  F23            C                   CONST(X'BB')
007200120813     D  F24            C                   CONST(X'BC')
007300120813    ***
007400120813     D                UDS
007500120813     D  XONAME               201    240
007600120813    ***
007700120813     D KF@UNIQ         S                   LIKE(CAUNIQ)
007800160927     D                                     INZ('0000000003')
007900120813     D KF@TRS          S                   LIKE(CATRST)
008000120813     D KF@SUB          S                   LIKE(CASUB#)
008100120813     D KF@ACC          S                   LIKE(CAACCT)
008200160405
008300160405     D statusHold      S              1
008400180724     d incarrier       s              2  0
008500180724     d option          s              1
008600160405
008700120813     D @PROC           S             10A
008800160311
008900160311     D sds            SDS
009000160311     D  UserID               254    263
009100160311
009200180724     d dltadd          pr                  ExtPgm('TROFF3')
009300180724     d  catrst                        3  0
009400180724     d  casub#                        3  0
009500180724     d  caacct                        4  0
009600180724     d  incarrier                     2  0
009700180724     d  option                        1
009800180724
009900160311      *=====================================================================
010000160311
010100120813     C                   DOU       @PROC = 'EXIT APP  '
010200120813     C     @PROC         CASEQ     'PREP SFL  '  $PREPSFL
010300120813     C     @PROC         CASEQ     'BUILD SFL '  $BLDSFL
010400120813     C     @PROC         CASEQ     'SFL CONTRL'  $SFLCTL
010500120813     C     @PROC         CASEQ     'ADD ACCT  '  $ADDACCT
010600120813     C     @PROC         CASEQ     'CHECK SELC'  $CHKSELC
010700120813     C                   ENDCS
010800120813     C                   ENDDO
010900120813     C*
011000120813     C                   MOVE      *ON           *INLR
011100120813     C*
011200120813   S***S
011300120813     C     *INZSR        BEGSR
011400120813    ***
011500120813     C                   EVAL      @PROC = 'PREP SFL  '
011600120813    ***
011700120813     C     KL#TS         KLIST
011800120813     C                   KFLD                    KF@TRS
011900120813     C                   KFLD                    KF@SUB
012000120813    ***
012100120813     C     KL#TSA        KLIST
012200120813     C                   KFLD                    KF@TRS
012300120813     C                   KFLD                    KF@SUB
012400120813     C                   KFLD                    KF@ACC
012500120813    ***
012600120813     C                   EVAL      HLD@NAME = XONAME
012700120813    ***
012800120813     C     KL#UTSA       KLIST
012900120813     C                   KFLD                    KF@UNIQ
013000120813     C                   KFLD                    KF@TRS
013100120813     C                   KFLD                    KF@SUB
013200120813     C                   KFLD                    KF@ACC
013300120813    ***
013400120813     C                   ENDSR
013500120813   S***S
013600120813     C     $PREPSFL      BEGSR
013700120813    ***
013800120813     C                   MOVE      *ZEROS        RR1               4 0
013900120813     C                   MOVE      *ZEROS        #CNTREC           4 0
014000120813    ***
014100120813     C                   EVAL      *IN39 = *OFF
014200120813     C                   EVAL      *IN40 = *OFF
014300120813    ***
014400120813     C                   EVAL      @PROC = 'BUILD SFL '
014500120813    ***
014600120813     C                   ENDSR
014700120813   S***S
014800120813     C* INITIALIZE THE SUBFILE
014900120813    ***
015000120813     C     $CLRSFL       BEGSR
015100120813    ***
015200120813     C                   MOVEA     '011'         *IN(25)
015300120813     C                   WRITE     S01CTL
015400120813     C                   MOVEA     '010'         *IN(25)
015500120813     C                   Z-ADD     *ZERO         RR1
015600120813    ***
015700120813     C                   ENDSR
015800120813   S***S
015900120813     C     $BLDSFL       BEGSR
016000120813    ***
016100120813     C                   MOVE      *ZEROS        #CNTREC
016200120813     C                   MOVE      '0'           @1STLOOP          1
016300120813     C                   MOVE      '0'           @SFLOOP           1
016400120813     C                   MOVE      '0'           *IN20
016500120813    ***
016600120813     C                   IF        I_TRST = 0
016700120813     C                   EVAL      KF@TRS = 001
016800120813     C                   EVAL      KF@SUB = 001
016900120813     C                   EVAL      KF@ACC = 001
017000120813     C                   ELSE
017100120813     C                   EVAL      KF@TRS = I_TRST
017200120813     C                   EVAL      KF@SUB = I_SUB#
017300120813     C                   EVAL      KF@ACC = I_ACCT
017400120813     C                   ENDIF
017500120813     C                   EVAL      I_TRST = 0
017600120813     C                   EVAL      I_SUB# = 0
017700120813     C                   EVAL      I_ACCT = 0
017800120813    ***
017900120813     C                   EXSR      $CLRSFL
018000120813     C                   EVAL      CONAME = HLD@NAME
018100120813    ***
018200120813     C     KL#TSA        SETLL     CAL2
018300120813    1C                   DOU       %EOF(CARACCQ) OR @SFLOOP = '1'
018400120813     C                   READ      CAL2
018500120813    2C                   IF        NOT %EOF(CARACCQ) AND
018600120813     C                             ZZUNIQ = KF@UNIQ
018700120813     C                   EXSR      $LOADSFL
018800120813    2C                   ENDIF
018900120813    1C                   ENDDO
019000120813    ***
019100120813     C                   EVAL      @PROC = 'SFL CONTRL'
019200120813    ***
019300120813     C                   ENDSR
019400120813   S***S
019500120813     C     $LOADSFL      BEGSR
019600120813    ***
019700120813     C                   MOVE      *ON           *IN25
019800120813     C                   MOVE      *BLANKS       SEL
019900120813    ***
020000120813     C                   EVAL      HUNIQ = ZZUNIQ
020100120813     C                   EVAL      SFTRST = ZZTRST
020200120813     C                   EVAL      SFSUB# = ZZSUB#
020300120813     C                   EVAL      SFACCT = ZZACCT
020400120813    ***
020500120813     C                   EVAL      KF@TRS  = ZZTRST
020600120813     C                   EVAL      KF@SUB  = ZZSUB#
020700120813     C                   EVAL      KF@ACC  = ZZACCT
020800120813    ***
020900120813     C     KL#TSA        CHAIN     ACCMSR
021000120813     C                   IF        NOT %FOUND(ACMUNIQUE)
021100120813     C                   EVAL      SFANAME = '**ERROR**'
021200120813     C                   ELSE
021300120813     C                   MOVE      *BLANKS       @100            100
021400120813     C                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
021500120813     C                             %TRIM(ACNAM2)
021600120813     C                   MOVEL(P)  @100          SFANAME
021700120813     C                   ENDIF
021800120813    ***
021900120813     C                   EVAL      SFSTATUS = ZZSTATUS
022000120813    ***
022100120813     C                   ADD       1             RR1
022200120813     C*
022300120813    1C                   IF        @1STLOOP = '0'
022400120813     C                   Z-ADD     RR1           SFLPOS
022500120813     C                   MOVE      '1'           @1STLOOP
022600120813    1C                   ENDIF
022700120813     C*
022800120813     C                   WRITE     S01SFL
022900120813     C*
023000120813     C                   ADD       1             #CNTREC
023100120925    1C                   IF        #CNTREC = 300
023200120813     C                   MOVE      '1'           @SFLOOP
023300120813    1C                   ENDIF
023400120813    ***
023500120813     C                   ENDSR
023600120813   S***S
023700120813     C     $SFLCTL       BEGSR
023800120813    ***
023900120813     C                   EVAL      EMSG = @EMSG
024000120813    ***
024100120813     C                   WRITE     S01REC
024200120813     C                   EXFMT     S01CTL
024300120813    ***
024400120813     C                   MOVE      *BLANKS       EMSG
024500120813     C                   MOVE      *BLANKS       @EMSG
024600120813    ***
024700120813     C                   IF        FKEY = F3
024800120813     C                   EVAL      @PROC = 'EXIT APP  '
024900120813     C                   LEAVESR
025000120813     C                   ENDIF
025100120813    ***
025200120813     C                   IF        FKEY = F6
025300120813     C                   SETOFF                                       3940
025400120813     C                   CLEAR                   S02R
025500120813     C                   EVAL      CONAME = HLD@NAME
025600120813     C                   EVAL      @PROC = 'ADD ACCT  '
025700120813     C                   LEAVESR
025800120813     C                   ENDIF
025900120813    ***
026000160927     C****               IF        FKEY = F8
026100160927     C****               call      'AETHOLDREL'
026200160927     C****               endif
026300160427
026400120813     C                   EVAL      @PROC = 'CHECK SELC'
026500120813    ***
026600120813     C                   ENDSR
026700120813   S***S
026800120813     C     $ADDACCT      BEGSR
026900120813    ***
027000120813     C                   EXSR      $SCREEN2
027100120813    ***
027200120813     C                   IF        FKEY = F12
027300120813     C                   CLEAR                   S02R
027400120813     C                   EVAL      CONAME = HLD@NAME
027500120813     C                   EVAL      @PROC = 'SFL CONTRL'
027600120813     C                   LEAVESR
027700120813     C                   ENDIF
027800120813    ***
027900120813     C                   EVAL      KF@TRS  = SCTRST
028000120813     C                   EVAL      KF@SUB  = SCSUB#
028100120813     C                   EVAL      KF@ACC  = SCACCT
028200120813    ***
028300120813     C                   EVAL      ADD_MODE = YES
028400120813     C                   EXSR      $VALIDKEY
028500120813    ***
028600120813     C                   IF        VALID_REC = NO
028700120813     C                   LEAVESR
028800120813     C                   ENDIF
028900120813    ***
029000120813     C                   EXSR      $VALIDACC
029100120813    ***
029200120813     C                   IF        VALID_REC = NO
029300120813     C                   LEAVESR
029400120813     C                   ENDIF
029500120813    ***
029600120813     C                   SETON                                        3940
029700120813    ***
029800120813     C                   DOU       FKEY = F12 OR FKEY = F10
029900120813      *
030000120813     C                   EXSR      $SCREEN2
030100120813      *
030200120813     C                   IF        FKEY = F12
030300120813     C                   SETOFF                                       3940
030400120813     C                   LEAVESR
030500120813     C                   ENDIF
030600120813      *
030700120813     C                   IF        FKEY = F10
030800120813     C                   EXSR      $PREPACC
030900130315     C                   EVAL      CATXT6 = %TRIM(ACNAM1)
031000120813     C                   EVAL      CASTATUS = SCSTATUS
031100160405     c                   eval      statusHold = castatus
031200160405     c                   exsr      diaryNote
031300120813     C                   WRITE     CARACCR
031400120813     C                   LEAVE
031500120813     C                   ENDIF
031600120813      *
031700120813     C                   ENDDO
031800120813    ***
031900120815     C                   EVAL      @PROC = 'BUILD SFL '
032000120813    ***
032100120813     C                   ENDSR
032200120813   S***S
032300120813     C     $SCREEN2      BEGSR
032400120813    ***
032500120813     C                   EVAL      EMSG = @EMSG
032600120813     C                   EXFMT     S02R
032700120813     C                   CLEAR                   @EMSG
032800120813     C                   EVAL      EMSG = *BLANKS
032900120813    ***
033000120813     C                   ENDSR
033100120813   S***S
033200120813     C     $VALIDKEY     BEGSR
033300120813    ***
033400120813     C                   EVAL      VALID_REC = NO
033500120813    ***
033600120813     C                   IF        KF@TRS = 0
033700120813     C                   EVAL      @EMSG = 'MISSING TRUST'
033800120813     C                   LEAVESR
033900120813     C                   ENDIF
034000120813    ***
034100120813     C     KF@TRS        CHAIN     TRSMSR
034200120813     C                   IF        NOT %FOUND(TRMUNIQUE)
034300120813     C                   EVAL      O_TNAM = '**ERROR**'
034400120813     C                   EVAL      @EMSG = 'INVALID TRUST'
034500120813     C                   LEAVESR
034600120813     C                   ENDIF
034700120813    ***
034800120813     C                   MOVEL(P)  TDESCR        O_TNAM
034900120813    ***
035000120813     C                   IF        KF@SUB = 0
035100120813     C                   EVAL      @EMSG = 'MISSING SUBDIVISION'
035200120813     C                   LEAVESR
035300120813     C                   ENDIF
035400120813    ***
035500120813     C     KL#TS         CHAIN     SUBMSR
035600120813     C                   IF        NOT %FOUND(SUMUNIQUE)
035700120813     C                   EVAL      O_SUBN = '**ERROR**'
035800120813     C                   EVAL      @EMSG = 'INVALID TRUST/SUBDIVISION'
035900120813     C                   LEAVESR
036000120813     C                   ENDIF
036100120813    ***
036200120813     C                   MOVEL(P)  SUBDSC        O_SUBN
036300120813    ***
036400120813     C                   IF        KF@ACC = 0
036500120813     C                   EVAL      @EMSG = 'MISSING ACCOUNT'
036600120813     C                   LEAVESR
036700120813     C                   ENDIF
036800120813    ***
036900120813     C     KL#TSA        CHAIN     ACCMSR
037000120813     C                   IF        NOT %FOUND(ACMUNIQUE)
037100120813     C                   EVAL      O_ACCN = '**ERROR**'
037200120813     C                   EVAL      @EMSG = 'INVALID TRUST/SUB/ACCOUNT'
037300120813     C                   LEAVESR
037400120813     C                   ENDIF
037500120813    ***
037600120813     C                   MOVE      *BLANKS       @100
037700120813     C                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
037800120813     C                             %TRIM(ACNAM2)
037900120813     C                   MOVEL(P)  @100          O_ACCN
038000120813    ***
038100120813     C                   IF        ADD_MODE = YES
038200120813     C     KL#UTSA       CHAIN     CARACCR
038300120813     C                   IF        %FOUND(CARACCP)
038400120813     C                   EVAL      @EMSG = 'T/S/A VALUE ALREADY EXISTS'
038500120813     C                   LEAVESR
038600120813     C                   ENDIF
038700120813     C                   ENDIF
038800120813    ***
038900120813     C                   EVAL      VALID_REC = YES
039000120813    ***
039100120813     C                   ENDSR
039200120813   S***S
039300120813     C     $VALIDACC     BEGSR
039400120813    ***
039500120813     C                   EVAL      VALID_REC = NO
039600120813    ***
039700120813     C                   IF        SCSTATUS <> 'Y' AND SCSTATUS <> 'N'
039800120813     C                   EVAL      @EMSG = 'VALID TRANSMIT FLAG REQUIRED'
039900120813     C                   LEAVESR
040000120813     C                   ENDIF
040100120813    ***
040200120813     C                   EVAL      VALID_REC = YES
040300120813    ***
040400120813     C                   ENDSR
040500120813   S***S
040600120813     C     $PREPACC      BEGSR
040700120813    ***
040800120813     C                   CLEAR                   CARACCR
040900120813     C                   EVAL      CAUNIQ = KF@UNIQ
041000120813     C                   EVAL      CATRST = KF@TRS
041100120813     C                   EVAL      CASUB# = KF@SUB
041200120813     C                   EVAL      CAACCT = KF@ACC
041300120813    ***
041400120813     C                   ENDSR
041500120813   S***S
041600120813     C     $CHKSELC      BEGSR
041700120813    ***
041800120816     C                   IF        I_TRST > 0
041900120813     C                   IF        I_TRST <> PRV#TRS OR
042000120813     C                             I_SUB# <> PRV#SUB OR
042100120813     C                             I_ACCT <> PRV#ACC
042200120813     C                   EVAL      PRV#TRS = I_TRST
042300120813     C                   EVAL      PRV#SUB = I_SUB#
042400120813     C                   EVAL      PRV#ACC = I_ACCT
042500120813     C                   EVAL      @PROC = 'PREP SFL  '
042600120813     C                   LEAVESR
042700120813     C                   ENDIF
042800120816     C                   ENDIF
042900120813    ***
043000160927    1C                   DOU       %EOF(hgm522D)
043100120813     C                   READC     S01SFL
043200160927    2C                   IF        NOT %EOF(hgm522D)
043300120813    ***
043400120813     C                   EVAL      KF@TRS  = SFTRST
043500120813     C                   EVAL      KF@SUB  = SFSUB#
043600120813     C                   EVAL      KF@ACC  = SFACCT
043700120813    ***
043800160322     C     KL#UTSA       CHAIN     CARACCR
043900120813    ***
044000120813     C                   SELECT
044100120906      *
044200120906     C                   WHEN      SEL = 'P'
044300120906     C                   EXSR      $CALLPLNS
044400120906      *
044500120813     C                   WHEN      SEL = 'I'
044600120813     C                   EXSR      $FMTSCR2
044700120813     C                   EXSR      $INQ2
044800120906      *
044900120813     C                   WHEN      SEL = 'C'
045000120813     C                   EXSR      $FMTSCR2
045100120813     C                   EXSR      $CHG2
045200120906      *
045300120813     C                   WHEN      SEL = 'A'
045400120813     C                   EVAL      CASTATUS = 'Y'
045500160405     c                   eval      statusHold = castatus
045600160311     c                   exsr      diaryNote
045700120813     C                   UPDATE    CARACCR
045800120906      *
045900120813     C                   WHEN      SEL = 'T'
046000120813     C                   EVAL      CASTATUS = 'N'
046100160405     c                   eval      statusHold = castatus
046200160311     c                   exsr      diaryNote
046300120813     C                   UPDATE    CARACCR
046400120906      *
046500120813     C                   ENDSL
046600120813    ***
046700120813    3C                   IF        @EMSG <> *BLANKS
046800120813     C                   LEAVESR
046900120813    3C                   ENDIF
047000120813     C*
047100120813     C                   MOVE      *BLANKS       SEL
047200120813     C                   UPDATE    S01SFL
047300120813     C*
047400120813    2C                   ENDIF
047500120813    1C                   ENDDO
047600120813    ***
047700130315     C****               EVAL      @PROC = 'PREP SFL  '
047800130315     C                   EVAL      @PROC = 'SFL CONTRL'
047900120906    ***
048000120906     C                   ENDSR
048100120906   S***S
048200160311       //=======================================================================
048300160311       // Diary Note
048400160311       //=======================================================================
048500160311
048600160311       begsr diaryNote;
048700160311
048800160311        nhkey = %editc(catrst: 'X') + %editc(casub#: 'X') + %editc(caacct: 'X');
048900160311        nhcode = 'WFT';
049000160311
049100160405        if statusHold = 'Y';
049200180724         option = 'D';
049300180724          incarrier = 12;
049400180724          dltadd(catrst : casub# : caacct : incarrier : option);
049500160927         nhsubj = 'HGMRK-TRANSMISSION TURNED ON';
049600160311        endif;
049700160311
049800160405        if statusHold = 'N';
049900180724         option = 'A';
050000180724          incarrier = 12;
050100180724          dltadd(catrst : casub# : caacct : incarrier : option);
050200160927         nhsubj = 'HGMRK-TRANSMISSION TURNED OFF';
050300160311        endif;
050400160311
050500160311        nhaddt = %dec(%date);
050600160311        nhadti = %dec(%time);
050700160311        nhadus = userID;
050800160311
050900160311        write rdiaryhd;
051000160311
051100160311        clear histr;
051200160311        hkey = %editc(catrst: 'X') + %editc(casub#: 'X') + %editc(caacct: 'X');
051300160311        trcode = 'UHM';
051400160311
051500160405        if statusHold = 'Y';
051600160927         ck#not = 'HGMRK-TRANSMISSION TURNED ON';
051700160311        endif;
051800160311
051900160405        if statusHold = 'N';
052000160927         ck#not = 'HGMRK-TRANSMISSION TURNED OFF';
052100160311        endif;
052200160311
052300160927        hprgnm = 'HGM522R';
052400160311        hstrst = catrst;
052500160311        hssub# = casub#;
052600160311        hsacct = caacct;
052700160311        hsdltd = 'A';
052800160311        trdate = %dec(%date);
052900160311        hstrtime = %time;
053000160311        hoper  = userID;
053100160311
053200160311        write histr;
053300160311
053400160311       endsr;
053500160311
053600160311       //=======================================================================
053700120906     C     $CALLPLNS     BEGSR
053800120906    ***
053900120906     C                   EVAL      PRM@OUT = %EDITC(CATRST:'X') +
054000120906     C                             %EDITC(CASUB#:'X') +
054100120906     C                             %EDITC(CAACCT:'X') + '*'
054200160927     C                   CALL      'HGM523CL'
054300120906     C                   PARM                    PRM@OUT          11
054400120813    ***
054500120813     C                   ENDSR
054600120813   S***S
054700120813     C     $FMTSCR2      BEGSR
054800120813    ***
054900120813     C                   SETOFF                                       3940
055000120813     C                   CLEAR                   S02R
055100120813     C                   EVAL      CONAME = HLD@NAME
055200120813    ***
055300120813     C                   EVAL      SCTRST = CATRST
055400120813     C                   EVAL      SCSUB# = CASUB#
055500120813     C                   EVAL      SCACCT = CAACCT
055600120813     C                   EVAL      SCSTATUS = CASTATUS
055700120813    ***
055800120813     C                   EXSR      $CHAINS
055900120813    ***
056000120813    ***
056100120813     C                   ENDSR
056200120813   S***S
056300120813     C     $CHAINS       BEGSR
056400120813    ***
056500120813     C     KF@TRS        CHAIN     TRSMSR
056600120813     C                   IF        %FOUND(TRMUNIQUE)
056700120813     C                   MOVEL(P)  TDESCR        O_TNAM
056800120813     C                   ENDIF
056900120813    ***
057000120813     C     KL#TS         CHAIN     SUBMSR
057100120813     C                   IF        %FOUND(SUMUNIQUE)
057200120813     C                   MOVEL(P)  SUBDSC        O_SUBN
057300120813     C                   ENDIF
057400120813    ***
057500120813     C     KL#TSA        CHAIN     ACCMSR
057600120813     C                   IF        %FOUND(ACMUNIQUE)
057700120813     C                   MOVE      *BLANKS       @100
057800120813     C                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
057900120813     C                             %TRIM(ACNAM2)
058000120813     C                   MOVEL(P)  @100          O_ACCN
058100120813     C                   ENDIF
058200120813    ***
058300120813     C                   ENDSR
058400120813   S***S
058500120813   S***S
058600120813     C     $INQ2         BEGSR
058700120813    ***
058800120813     C                   EVAL      EMSG = 'INQUIRY ONLY'
058900120813     C                   EVAL      *IN40 = *ON
059000120813     C                   DOU       FKEY = F12
059100120813     C                   EXFMT     S02R
059200120813     C                   ENDDO
059300120813    ***
059400120813     C                   ENDSR
059500120813   S***S
059600120813     C     $CHG2         BEGSR
059700120813    ***
059800120813     C                   EVAL      @EMSG = 'BE CAREFUL'
059900120813    ***
060000120813     C                   DOU       FKEY = F12
060100120813      *
060200120813     C                   EXSR      $SCREEN2
060300120813      *
060400120813     C                   IF        FKEY = F12
060500120813     C                   UNLOCK(E) CARACCP
060600120813     C                   SETOFF                                       3940
060700120813     C                   LEAVESR
060800120813     C                   ENDIF
060900120813      *
061000120813     C                   EVAL      KF@TRS  = SCTRST
061100120813     C                   EVAL      KF@SUB  = SCSUB#
061200120813     C                   EVAL      KF@ACC  = SCACCT
061300120813    ***
061400120813     C                   EVAL      ADD_MODE = NO
061500120813     C                   EXSR      $VALIDKEY
061600120813     C                   IF        VALID_REC = NO
061700120813     C                   ITER
061800120813     C                   ENDIF
061900120813    ***
062000120813     C                   EXSR      $VALIDACC
062100120813     C                   IF        VALID_REC = NO
062200120813     C                   ITER
062300120813     C                   ENDIF
062400120813    ***
062500120813     C                   SETON                                        3940
062600120813     C                   DOU       FKEY = F12 OR FKEY = F10
062700120813     C                   EXSR      $SCREEN2
062800120813    ***
062900120813     C                   IF        FKEY = F12
063000120813     C                   SETOFF                                       3940
063100120813     C                   LEAVESR
063200120813     C                   ENDIF
063300120813    ***
063400120813     C                   IF        FKEY = F10
063500160322     C     KL#UTSA       CHAIN     CARACCR
063600120813     C                   EVAL      CASTATUS = SCSTATUS
063700160405     c                   eval      statusHold = castatus
063800160405     c                   exsr      diaryNote
063900120813     C                   UPDATE    CARACCR
064000120813     C                   LEAVESR
064100120813     C                   ENDIF
064200120813    ***
064300120813     C                   ENDDO
064400120813    ***
064500120813     C                   ENDDO
064600120813    ***
064700120813     C                   ENDSR
064800120813   S***S
