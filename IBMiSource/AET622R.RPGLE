000100160316      *=============================================================================================
000200160316     H option(*noDebugIo)
000300150327      *=============================================================================================
000400150327      * AET622R - Large Group Accoount Mapping Maintenance
000500150327      *=============================================================================================
000600150327      * Written by:    J. Torres (cloned from AET522R by SSK)
000700150327      * Date Written:  03/27/15
000800150327      * Description:   Small Group Account Mapping
000900150327      *
001000150327      *
001100150327      *  (c)Copyright 2013 by GBS Inc.
001200150327      *  This document contains restricted materials of GBS, Inc.
001300150327
001400150327      *                R E V I S I O N    H I S T O R Y
001500160405      * Date         Programmer    Description
001600160405      * ---------    ----------    ---------------------------------------------
001700160405      * 03/11/2016   J. Torres     Added history and diary files records when
001800160405      *                            transmisson is changed to 'T' or 'A'.
001900160405
002000150327      *
002100150327      *=============================================================================================
002200150327     FAET622D   CF   E             WORKSTN INFDS(WSDS) SFILE(S01SFL:RR1)
002300150327
002400120813     FCARACCP   UF A E           K DISK
002500150327
002600120813     FCARACCQ   IF   E           K DISK    RENAME(CARACCR:CAL2) PREFIX(ZZ:2)
002700150327
002800120813     FTRMUNIQUE IF   E           K DISK
002900150327
003000120813     FSUMUNIQUE IF   E           K DISK
003100150327
003200150428     FACMUNIQUE IF   E           K DISK    extfile('QS36F/ACMUNIQUE')
003300150327
003400160405     FDIARYHD1  O    E           K DISK    EXTFILE('F.DIARYHD1')
003500160405
003600160405     FHISTAK    O    E           K DISK    EXTFILE('F.HISTAK')
003700160405
003800150327      *=============================================================================================
003900120813     D HLD@NAME        S             40A
004000120813     D @EMSG           S                   LIKE(EMSG)
004100120813     D PRV#TRS         S                   LIKE(I_TRST)
004200120813     D PRV#SUB         S                   LIKE(I_SUB#)
004300120813     D PRV#ACC         S                   LIKE(I_ACCT)
004400120813     D ADD_MODE        S               N   INZ(*OFF)
004500120813     D VALID_REC       S               N   INZ(*OFF)
004600120813     D YES             S               N   INZ(*ON)
004700120813     D NO              S               N   INZ(*OFF)
004800150327
004900120813     D WSDS            DS
005000120813     D  FKEY                 369    369A
005100150327
005200120813     D  F1             C                   CONST(X'31')
005300120813     D  F2             C                   CONST(X'32')
005400120813     D  F3             C                   CONST(X'33')
005500120813     D  F4             C                   CONST(X'34')
005600120813     D  F5             C                   CONST(X'35')
005700120813     D  F6             C                   CONST(X'36')
005800120813     D  F7             C                   CONST(X'37')
005900120813     D  F8             C                   CONST(X'38')
006000120813     D  F9             C                   CONST(X'39')
006100120813     D  F10            C                   CONST(X'3A')
006200120813     D  F11            C                   CONST(X'3B')
006300120813     D  F12            C                   CONST(X'3C')
006400120813     D  F13            C                   CONST(X'B1')
006500120813     D  F14            C                   CONST(X'B2')
006600120813     D  F15            C                   CONST(X'B3')
006700120813     D  F16            C                   CONST(X'B4')
006800120813     D  F17            C                   CONST(X'B5')
006900120813     D  F18            C                   CONST(X'B6')
007000120813     D  F19            C                   CONST(X'B7')
007100120813     D  F20            C                   CONST(X'B8')
007200120813     D  F21            C                   CONST(X'B9')
007300120813     D  F22            C                   CONST(X'BA')
007400120813     D  F23            C                   CONST(X'BB')
007500120813     D  F24            C                   CONST(X'BC')
007600150327
007700120813     D                UDS
007800120813     D  XONAME               201    240
007900150327
008000120813     D KF@UNIQ         S                   LIKE(CAUNIQ)
008100150414     D                                     INZ('0000000127')
008200120813     D KF@TRS          S                   LIKE(CATRST)
008300120813     D KF@SUB          S                   LIKE(CASUB#)
008400120813     D KF@ACC          S                   LIKE(CAACCT)
008500160405
008600160405     D statusHold      S              1
008700150327
008800120813     D @PROC           S             10A
008900150327
009000160405     D sds            SDS
009100160405     D  UserID               254    263
009200160405
009300150327      *=============================================================================================
009400150327      * Mainline
009500150327      *=============================================================================================
009600150327
009700150327      * Main loop...
009800150327     c                   DOU       @PROC = 'EXIT APP  '
009900150327
010000150327     c     @PROC         CASEQ     'PREP SFL  '  $PREPSFL
010100150327     c     @PROC         CASEQ     'BUILD SFL '  $BLDSFL
010200150327     c     @PROC         CASEQ     'SFL CONTRL'  $SFLCTL
010300150327     c     @PROC         CASEQ     'ADD ACCT  '  $ADDACCT
010400150327     c     @PROC         CASEQ     'CHECK SELC'  $CHKSELC
010500150327     c                   ENDCS
010600150327
010700150327     c                   ENDDO
010800150327
010900150327     c                   exsr      exit
011000150327
011100150327      *=============================================================================================
011200150327      * $PREPSFL - Get subfile ready
011300150327      *=============================================================================================
011400150327
011500150327     c     $PREPSFL      BEGSR
011600150327
011700150327     c                   z-add     *ZEROS        RR1               4 0
011800150327     c                   z-add     *ZEROS        #CNTREC           4 0
011900150327
012000150327     c                   EVAL      *IN39 = *OFF
012100150327     c                   EVAL      *IN40 = *OFF
012200150327
012300150327     c                   EVAL      @PROC = 'BUILD SFL '
012400150327
012500150327     c                   ENDSR
012600150327
012700150327      *=============================================================================================
012800150327      * $CLRSFL - Initialize subfile
012900150327      *=============================================================================================
013000150327
013100150327     c     $CLRSFL       BEGSR
013200150327
013300150327     c                   MOVEA     '011'         *IN(25)
013400150327     c                   WRITE     S01CTL
013500150327     c                   MOVEA     '010'         *IN(25)
013600150327     c                   Z-ADD     *ZERO         RR1
013700150327
013800150327     c                   ENDSR
013900150327
014000150327      *=============================================================================================
014100150327      * $BLDSFL - Build subfile
014200150327      *=============================================================================================
014300150327
014400150327     c     $BLDSFL       BEGSR
014500150327
014600150327     c                   MOVE      *ZEROS        #CNTREC
014700150327     c                   MOVE      '0'           @1STLOOP          1
014800150327     c                   MOVE      '0'           @SFLOOP           1
014900150327     c                   MOVE      '0'           *IN20
015000150327
015100150327      * Position subfile?
015200150327     c                   IF        I_TRST = 0
015300150327     c                   EVAL      KF@TRS = 001
015400150327     c                   EVAL      KF@SUB = 001
015500150327     c                   EVAL      KF@ACC = 001
015600150327     c                   ELSE
015700150327     c                   EVAL      KF@TRS = I_TRST
015800150327     c                   EVAL      KF@SUB = I_SUB#
015900150327     c                   EVAL      KF@ACC = I_ACCT
016000150327     c                   ENDIF
016100150327
016200150327     c                   EVAL      I_TRST = 0
016300150327     c                   EVAL      I_SUB# = 0
016400150327     c                   EVAL      I_ACCT = 0
016500150327
016600150327     c                   EXSR      $CLRSFL
016700150327     c                   EVAL      CONAME = HLD@NAME
016800150327
016900150327      * Only load unique records with value = 11 (KF@UNIQ)...
017000150327     c     KL#TSA        SETLL     CAL2
017100150327     c                   DOU       %EOF(CARACCQ) OR @SFLOOP = '1'
017200150327     c                   READ      CAL2
017300150327
017400150327     c                   IF        NOT %EOF(CARACCQ) AND
017500150327     c                             ZZUNIQ = KF@UNIQ
017600150327     c                   EXSR      $LOADSFL
017700150327     c                   ENDIF
017800150327
017900150327     c                   ENDDO
018000150327
018100150327     c                   EVAL      @PROC = 'SFL CONTRL'
018200150327
018300150327     c                   ENDSR
018400150327
018500150327      *=============================================================================================
018600150327      * $LOADSFL - Load subfile
018700150327      *=============================================================================================
018800150327
018900150327     c     $LOADSFL      BEGSR
019000150327
019100150327     c                   MOVE      *ON           *IN25
019200150327     c                   MOVE      *BLANKS       SEL
019300150327
019400150327     c                   EVAL      HUNIQ = ZZUNIQ
019500150327     c                   EVAL      SFTRST = ZZTRST
019600150327     c                   EVAL      SFSUB# = ZZSUB#
019700150327     c                   EVAL      SFACCT = ZZACCT
019800150327
019900150327     c                   EVAL      KF@TRS  = ZZTRST
020000150327     c                   EVAL      KF@SUB  = ZZSUB#
020100150327     c                   EVAL      KF@ACC  = ZZACCT
020200150327
020300150327     c     KL#TSA        CHAIN     ACCMSR
020400150327     c                   IF        NOT %FOUND(ACMUNIQUE)
020500150327     c                   EVAL      SFANAME = '**ERROR**'
020600150327     c                   ELSE
020700150327     c                   MOVE      *BLANKS       @100            100
020800150327     c                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
020900150327     c                             %TRIM(ACNAM2)
021000150327     c                   MOVEL(P)  @100          SFANAME
021100150327     c                   ENDIF
021200150327
021300150327     c                   EVAL      SFSTATUS = ZZSTATUS
021400150327
021500150327     c                   ADD       1             RR1
021600150327
021700150327     c                   IF        @1STLOOP = '0'
021800150327     c                   Z-ADD     RR1           SFLPOS
021900150327     c                   MOVE      '1'           @1STLOOP
022000150327     c                   ENDIF
022100150327
022200150327     c                   WRITE     S01SFL
022300150327
022400150327     c                   ADD       1             #CNTREC
022500150327     c                   IF        #CNTREC = 300
022600150327     c                   MOVE      '1'           @SFLOOP
022700150327     c                   ENDIF
022800150327
022900150327     c                   ENDSR
023000150327
023100150327      *=============================================================================================
023200150327      * $SFLCTL - Subfile control
023300150327      *=============================================================================================
023400150327
023500150327     c     $SFLCTL       BEGSR
023600150327
023700150327     c                   EVAL      EMSG = @EMSG
023800150327
023900150327     c                   WRITE     S01REC
024000150327     c                   EXFMT     S01CTL
024100150327
024200150327     c                   MOVE      *BLANKS       EMSG
024300150327     c                   MOVE      *BLANKS       @EMSG
024400150327
024500150327     c                   IF        FKEY = F3
024600150327     c                   EVAL      @PROC = 'EXIT APP  '
024700150327     c                   LEAVESR
024800150327     c                   ENDIF
024900150327
025000150327     c                   IF        FKEY = F6
025100150327     c                   SETOFF                                       3940
025200150327     c                   CLEAR                   S02R
025300150327     c                   EVAL      CONAME = HLD@NAME
025400150327     c                   EVAL      @PROC = 'ADD ACCT  '
025500150327     c                   LEAVESR
025600150327     c                   ENDIF
025700150327
025800150327     c                   EVAL      @PROC = 'CHECK SELC'
025900150327
026000150327     c                   ENDSR
026100150327
026200150327      *=============================================================================================
026300150327      * $ADDACCT - Add record
026400150327      *=============================================================================================
026500150327
026600150327     c     $ADDACCT      BEGSR
026700150327
026800150327     c                   EXSR      $SCREEN2
026900150327
027000150327     c                   IF        FKEY = F12
027100150327     c                   CLEAR                   S02R
027200150327     c                   EVAL      CONAME = HLD@NAME
027300150327     c                   EVAL      @PROC = 'SFL CONTRL'
027400150327     c                   LEAVESR
027500150327     c                   ENDIF
027600150327
027700150327     c                   EVAL      KF@TRS  = SCTRST
027800150327     c                   EVAL      KF@SUB  = SCSUB#
027900150327     c                   EVAL      KF@ACC  = SCACCT
028000150327
028100150327     c                   EVAL      ADD_MODE = YES
028200150327
028300150327      * Validate command key hit...
028400150327     c                   EXSR      $VALIDKEY
028500150327
028600150327      * Error?
028700150327     c                   IF        VALID_REC = NO
028800150327     c                   LEAVESR
028900150327     c                   ENDIF
029000150327
029100150327      * Validate record...
029200150327     c                   EXSR      $VALIDACC
029300150327
029400150327      * Error?
029500150327     c                   IF        VALID_REC = NO
029600150327     c                   LEAVESR
029700150327     c                   ENDIF
029800150327
029900150327     c                   SETON                                        3940
030000150327
030100150327     c                   DOU       FKEY = F12 OR FKEY = F10
030200150327
030300150327     c                   EXSR      $SCREEN2
030400150327
030500150327      * Cancel...
030600150327     c                   IF        FKEY = F12
030700150327     c                   SETOFF                                       3940
030800150327     c                   LEAVESR
030900150327     c                   ENDIF
031000150327
031100150327      * Add record...
031200150327     c                   IF        FKEY = F10
031300150327     c                   EXSR      $PREPACC
031400160405     c                   EVAL      CACID1 = ' '
031500150327     c                   EVAL      CATXT1 = 'SUBMITTER ID'
031600150408     c                   EVAL      CACID2 = '  '
031700150327     c                   EVAL      CATXT2 = 'COMPANY CODE'
031800150327     c                   EVAL      CACID3 = SCCID3
031900150327     c                   EVAL      CATXT3 = 'HMO GROUP NUMBER'
032000160405     c                   EVAL      CACID4 = ' '
032100150327     c                   EVAL      CATXT4 = 'CUSTOMER NAME'
032200150327     c                   EVAL      CACID5 = SCCID5
032300150408     c                   EVAL      CATXT5 = 'CUSTOMER NUMBER'
032400150327     c                   EVAL      CACID6 = 'N/A'
032500150327     c                   EVAL      CATXT6 = %TRIM(ACNAM1)
032600150327     c                   EVAL      CACID7 = SCCID7
032700150408     c                   EVAL      CATXT7 = '                 '
032800150408     c                   EVAL      CACID8 = '   '
032900150408     c                   EVAL      CATXT8 = '   '
033000150408     c                   EVAL      CACID9 = '   '
033100150408     c                   EVAL      CATXT9 = '   '
033200150408     c                   EVAL      CACIDA = '   '
033300150408     c                   EVAL      CATXTA = '   '
033400150327     c                   EVAL      CASTATUS = SCSTATUS
033500160405     c                   eval      statusHold = castatus
033600160405     c                   exsr      diaryNote
033700150327     c                   WRITE     CARACCR
033800150327     c                   LEAVE
033900150327     c                   ENDIF
034000150327
034100150327     c                   ENDDO
034200150327
034300150327     c                   EVAL      @PROC = 'BUILD SFL '
034400150327
034500150327     c                   ENDSR
034600150327
034700150327      *=============================================================================================
034800150327      * $SCREEN2 - Add screen
034900150327      *=============================================================================================
035000150327
035100150327     c     $SCREEN2      BEGSR
035200150327
035300150327     c                   EVAL      EMSG = @EMSG
035400150327     c                   EXFMT     S02R
035500150327     c                   CLEAR                   @EMSG
035600150327     c                   EVAL      EMSG = *BLANKS
035700150327
035800150327     c                   ENDSR
035900150327
036000150327      *=============================================================================================
036100150327      * $VALIDKEY - Validity check
036200150327      *=============================================================================================
036300150327
036400150327     c     $VALIDKEY     BEGSR
036500150327
036600150327     c                   EVAL      VALID_REC = NO
036700150327
036800150327     c                   IF        KF@TRS = 0
036900150327     c                   EVAL      @EMSG = 'MISSING TRUST'
037000150327     c                   LEAVESR
037100150327     c                   ENDIF
037200150327
037300150327     c     KF@TRS        CHAIN     TRSMSR
037400150327     c                   IF        NOT %FOUND(TRMUNIQUE)
037500150327     c                   EVAL      O_TNAM = '**ERROR**'
037600150327     c                   EVAL      @EMSG = 'INVALID TRUST'
037700150327     c                   LEAVESR
037800150327     c                   ENDIF
037900150327
038000150327     c                   MOVEL(P)  TDESCR        O_TNAM
038100150327
038200150327     c                   IF        KF@SUB = 0
038300150327     c                   EVAL      @EMSG = 'MISSING SUBDIVISION'
038400150327     c                   LEAVESR
038500150327     c                   ENDIF
038600150327
038700150327     c     KL#TS         CHAIN     SUBMSR
038800150327     c                   IF        NOT %FOUND(SUMUNIQUE)
038900150327     c                   EVAL      O_SUBN = '**ERROR**'
039000150327     c                   EVAL      @EMSG = 'INVALID TRUST/SUBDIVISION'
039100150327     c                   LEAVESR
039200150327     c                   ENDIF
039300150327
039400150327     c                   MOVEL(P)  SUBDSC        O_SUBN
039500150327
039600150327     c                   IF        KF@ACC = 0
039700150327     c                   EVAL      @EMSG = 'MISSING ACCOUNT'
039800150327     c                   LEAVESR
039900150327     c                   ENDIF
040000150327
040100150327     c     KL#TSA        CHAIN     ACCMSR
040200150327     c                   IF        NOT %FOUND(ACMUNIQUE)
040300150327     c                   EVAL      O_ACCN = '**ERROR**'
040400150327     c                   EVAL      @EMSG = 'INVALID TRUST/SUB/ACCOUNT'
040500150327     c                   LEAVESR
040600150327     c                   ENDIF
040700150327
040800150327     c                   MOVE      *BLANKS       @100
040900150327     c                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
041000150327     c                             %TRIM(ACNAM2)
041100150327     c                   MOVEL(P)  @100          O_ACCN
041200150327
041300150327     c                   IF        ADD_MODE = YES
041400150327     c     KL#UTSA       CHAIN     CARACCR
041500150327     c                   IF        %FOUND(CARACCP)
041600150327     c                   EVAL      @EMSG = 'T/S/A VALUE ALREADY EXISTS'
041700150327     c                   LEAVESR
041800150327     c                   ENDIF
041900150327     c                   ENDIF
042000150327
042100150327     c                   EVAL      VALID_REC = YES
042200150327
042300150327     c                   ENDSR
042400150327
042500150327      *=============================================================================================
042600150327      * $VALIDACCC - Validity check
042700150327      *=============================================================================================
042800150327
042900150327     c     $VALIDACC     BEGSR
043000150327
043100150327     c                   EVAL      VALID_REC = NO
043200150327
043300150327     c                   IF        SCCID3 = *BLANKS AND SCCID5 = *BLANKS
043400150327     c                   EVAL      @EMSG = 'HMO AND PPO CANNOT BOTH BE BLANK'
043500150327     c                   LEAVESR
043600150327     c                   ENDIF
043700150327
043800150327     c                   IF        SCSTATUS <> 'Y' AND SCSTATUS <> 'N'
043900150327     c                   EVAL      @EMSG = 'VALID TRANSMIT FLAG REQUIRED'
044000150327     c                   LEAVESR
044100150327     c                   ENDIF
044200150327
044300150327     c                   EVAL      VALID_REC = YES
044400150327
044500150327     c                   ENDSR
044600150327
044700150327      *=============================================================================================
044800150327      * $PREPACC - Clear file before writing
044900150327      *=============================================================================================
045000150327
045100150327     c     $PREPACC      BEGSR
045200150327
045300150327     c                   CLEAR                   CARACCR
045400150327     c                   EVAL      CAUNIQ = KF@UNIQ
045500150327     c                   EVAL      CATRST = KF@TRS
045600150327     c                   EVAL      CASUB# = KF@SUB
045700150327     c                   EVAL      CAACCT = KF@ACC
045800150327
045900150327     c                   ENDSR
046000150327
046100150327      *=============================================================================================
046200150327      * $CHKSELC - Check subfile record(s) selected
046300150327      *=============================================================================================
046400150327
046500150327     c     $CHKSELC      BEGSR
046600150327
046700150327     c                   IF        I_TRST > 0
046800150327     c                   IF        I_TRST <> PRV#TRS OR
046900150327     c                             I_SUB# <> PRV#SUB OR
047000150327     c                             I_ACCT <> PRV#ACC
047100150327     c                   EVAL      PRV#TRS = I_TRST
047200150327     c                   EVAL      PRV#SUB = I_SUB#
047300150327     c                   EVAL      PRV#ACC = I_ACCT
047400150327     c                   EVAL      @PROC = 'PREP SFL  '
047500150327     c                   LEAVESR
047600150327     c                   ENDIF
047700150327     c                   ENDIF
047800150327
047900150327     c                   DOU       %EOF(AET622D)
048000150327     c                   READC     S01SFL
048100150327     c                   IF        NOT %EOF(AET622D)
048200150327
048300150327     c                   EVAL      KF@TRS  = SFTRST
048400150327     c                   EVAL      KF@SUB  = SFSUB#
048500150327     c                   EVAL      KF@ACC  = SFACCT
048600150327
048700160405     c     KL#UTSA       CHAIN     CARACCR
048800150327
048900150327     c                   SELECT
049000150327
049100150327     c                   WHEN      SEL = 'P'
049200150327     c                   EXSR      $CALLPLNS
049300150327
049400150327     c                   WHEN      SEL = 'I'
049500150327     c                   EXSR      $FMTSCR2
049600150327     c                   EXSR      $INQ2
049700150327
049800150327     c                   WHEN      SEL = 'C'
049900150327     c                   EXSR      $FMTSCR2
050000150327     c                   EXSR      $CHG2
050100150327
050200150327     c                   WHEN      SEL = 'A'
050300150327     c                   EVAL      CASTATUS = 'Y'
050400160405     c                   eval      statusHold = castatus
050500160405     c                   exsr      diaryNote
050600150327     c                   UPDATE    CARACCR
050700150327
050800150327     c                   WHEN      SEL = 'T'
050900150327     c                   EVAL      CASTATUS = 'N'
051000160405     c                   eval      statusHold = castatus
051100160405     c                   exsr      diaryNote
051200150327     c                   UPDATE    CARACCR
051300150327
051400150415     c                   WHEN      SEL = 'R'
051500150415     c                   CALL      'AET640WR'
051600150415     c                   parm                    CATRST
051700150415     c                   parm                    CASUB#
051800150415     c                   parm                    CAACCT
051900150415
052000150327     c                   ENDSL
052100150327
052200150327     c                   IF        @EMSG <> *BLANKS
052300150327     c                   LEAVESR
052400150327     c                   ENDIF
052500150327
052600150327     c                   MOVE      *BLANKS       SEL
052700150327     c                   UPDATE    S01SFL
052800150327
052900150327     c                   ENDIF
053000150327     c                   ENDDO
053100150327
053200150327     c****               EVAL      @PROC = 'PREP SFL  '
053300150327     c                   EVAL      @PROC = 'SFL CONTRL'
053400150327
053500150327     c                   ENDSR
053600150327
053700160405       //=======================================================================
053800160405       // Diary Note
053900160405       //=======================================================================
054000160405
054100160405       begsr diaryNote;
054200160405
054300160405        nhkey = %editc(catrst: 'X') + %editc(casub#: 'X') + %editc(caacct: 'X');
054400160405        nhcode = 'WFT';
054500160405
054600160405        if statusHold = 'Y';
054700160405         nhsubj = 'AETNA-TRANSMISSION TURNED ON';
054800160405        endif;
054900160405
055000160405        if statusHold = 'N';
055100160405         nhsubj = 'AETNA-TRANSMISSION TURNED OFF';
055200160405        endif;
055300160405
055400160405        nhaddt = %dec(%date);
055500160405        nhadti = %dec(%time);
055600160405        nhadus = userID;
055700160405
055800160405        write rdiaryhd;
055900160405
056000160405        clear histr;
056100160405        hkey = %editc(catrst: 'X') + %editc(casub#: 'X') + %editc(caacct: 'X');
056200160405        trcode = 'UHM';
056300160405
056400160405        if statusHold = 'Y';
056500160405         ck#not = 'AETNA-TRANSMISSION TURNED ON';
056600160405        endif;
056700160405
056800160405        if statusHold = 'N';
056900160405         ck#not = 'AETNA-TRANSMISSION TURNED OFF';
057000160405        endif;
057100160405
057200160405        hprgnm = 'AET622R';
057300160405        hstrst = catrst;
057400160405        hssub# = casub#;
057500160405        hsacct = caacct;
057600160405        hsdltd = 'A';
057700160405        trdate = %dec(%date);
057800160405        hstrtime = %time;
057900160405        hoper  = userID;
058000160405
058100160405        write histr;
058200160405
058300160405       endsr;
058400160405
058500150327      *=============================================================================================
058600150327      * #CALLPLNS - Call plans subfile program
058700150327      *=============================================================================================
058800150327
058900150327     c     $CALLPLNS     BEGSR
059000150327
059100150327     c                   EVAL      PRM@OUT = %EDITC(CATRST:'X') +
059200150327     c                             %EDITC(CASUB#:'X') +
059300150327     c                             %EDITC(CAACCT:'X') + '*'
059400150331     c                   CALL      'AET623CL'
059500150327     c                   PARM                    PRM@OUT          11
059600150327
059700150327     c                   ENDSR
059800150327
059900150327      *=============================================================================================
060000150327      * $FMTSCR2 - Inquity mode screen
060100150327      *=============================================================================================
060200150327
060300150327     c     $FMTSCR2      BEGSR
060400150327
060500150327     c                   SETOFF                                       3940
060600150327     c                   CLEAR                   S02R
060700150327     c                   EVAL      CONAME = HLD@NAME
060800150327
060900150327     c                   EVAL      SCTRST = CATRST
061000150327     c                   EVAL      SCSUB# = CASUB#
061100150327     c                   EVAL      SCACCT = CAACCT
061200150327     c                   EVAL      SCSTATUS = CASTATUS
061300150327
061400150327     c                   EXSR      $CHAINS
061500150327
061600150327     c                   EVAL      SCCID3 = %TRIM(CACID3)
061700150327     c                   EVAL      SCCID5 = %TRIM(CACID5)
061800150327     c                   EVAL      SCCID7 = %TRIM(CACID7)
061900150327
062000150327     c                   ENDSR
062100150327
062200150327      *=============================================================================================
062300150327      * $CHAINS - Get Trust/Sub/Account records
062400150327      *=============================================================================================
062500150327
062600150327     c     $CHAINS       BEGSR
062700150327
062800150327     c     KF@TRS        CHAIN     TRSMSR
062900150327     c                   IF        %FOUND(TRMUNIQUE)
063000150327     c                   MOVEL(P)  TDESCR        O_TNAM
063100150327     c                   ENDIF
063200150327
063300150327     c     KL#TS         CHAIN     SUBMSR
063400150327     c                   IF        %FOUND(SUMUNIQUE)
063500150327     c                   MOVEL(P)  SUBDSC        O_SUBN
063600150327     c                   ENDIF
063700150327
063800150327     c     KL#TSA        CHAIN     ACCMSR
063900150327     c                   IF        %FOUND(ACMUNIQUE)
064000150327     c                   MOVE      *BLANKS       @100
064100150327     c                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
064200150327     c                             %TRIM(ACNAM2)
064300150327     c                   MOVEL(P)  @100          O_ACCN
064400150327     c                   ENDIF
064500150327
064600150327     c                   ENDSR
064700150327
064800150327      *=============================================================================================
064900150327      * $INQ2 - Inquiry screen
065000150327      *=============================================================================================
065100150327
065200150327     c     $INQ2         BEGSR
065300150327
065400150327     c                   EVAL      EMSG = 'INQUIRY ONLY'
065500150327     c                   EVAL      *IN40 = *ON
065600150327     c                   DOU       FKEY = F12
065700150327     c                   EXFMT     S02R
065800150327     c                   ENDDO
065900150327
066000150327     c                   ENDSR
066100150327
066200150327      *=============================================================================================
066300150327      * $CHG2 - Change record
066400150327      *=============================================================================================
066500150327
066600150327     c     $CHG2         BEGSR
066700150327
066800150327     c                   EVAL      @EMSG = 'BE CAREFUL'
066900150327
067000150327     c                   DOU       FKEY = F12
067100150327
067200150327     c                   EXSR      $SCREEN2
067300150327
067400150327     c                   IF        FKEY = F12
067500150327     c                   UNLOCK(E) CARACCP
067600150327     c                   SETOFF                                       3940
067700150327     c                   LEAVESR
067800150327     c                   ENDIF
067900150327
068000150327     c                   EVAL      KF@TRS  = SCTRST
068100150327     c                   EVAL      KF@SUB  = SCSUB#
068200150327     c                   EVAL      KF@ACC  = SCACCT
068300150327     c
068400150327     c                   EVAL      ADD_MODE = NO
068500150327     c                   EXSR      $VALIDKEY
068600150327     c                   IF        VALID_REC = NO
068700150327     c                   ITER
068800150327     c                   ENDIF
068900150327
069000150327     c                   EXSR      $VALIDACC
069100150327     c                   IF        VALID_REC = NO
069200150327     c                   ITER
069300150327     c                   ENDIF
069400150327
069500150327     c                   SETON                                        3940
069600150327     c                   DOU       FKEY = F12 OR FKEY = F10
069700150327     c                   EXSR      $SCREEN2
069800150327
069900150327     c                   IF        FKEY = F12
070000150327     c                   SETOFF                                       3940
070100150327     c                   LEAVESR
070200150327     c                   ENDIF
070300150327
070400150327     c                   IF        FKEY = F10
070500160322     c     KL#UTSA       CHAIN     CARACCR
070600150327     c                   EVAL      CACID3 = SCCID3
070700150327     c                   EVAL      CACID5 = SCCID5
070800150327     c                   EVAL      CACID7 = SCCID7
070900150327     c                   EVAL      CASTATUS = SCSTATUS
071000160405     c                   eval      statusHold = castatus
071100160405     c                   exsr      diaryNote
071200150327     c                   UPDATE    CARACCR
071300150327     c                   LEAVESR
071400150327     c                   ENDIF
071500150327
071600150327     c                   ENDDO
071700150327
071800150327     c                   ENDDO
071900150327
072000150327     c                   ENDSR
072100150327
072200150327      *=============================================================================================
072300150327      * Exit
072400150327      *=============================================================================================
072500150327
072600150327     c     Exit          begsr
072700150327
072800150327     c                   eval      *inlr = yes
072900150327     c                   return
073000150327
073100150327     c                   endsr
073200150327
073300150327      *=============================================================================================
073400150327      * Initializ subroutine
073500150327      *=============================================================================================
073600150327
073700150327     c     *inzsr        begsr
073800150327
073900150327     c     KL#TS         KLIST
074000150327     c                   KFLD                    KF@TRS
074100150327     c                   KFLD                    KF@SUB
074200150327
074300150327     c     KL#TSA        KLIST
074400150327     c                   KFLD                    KF@TRS
074500150327     c                   KFLD                    KF@SUB
074600150327     c                   KFLD                    KF@ACC
074700150327
074800150327     c     KL#UTSA       KLIST
074900150327     c                   KFLD                    KF@UNIQ
075000150327     c                   KFLD                    KF@TRS
075100150327     c                   KFLD                    KF@SUB
075200150327     c                   KFLD                    KF@ACC
075300150327
075400150327     c                   EVAL      @PROC = 'PREP SFL  '
075500150327     c                   EVAL      HLD@NAME = XONAME
075600150327
075700150327     c                   endsr
075800150327
075900150327      *=============================================================================================
