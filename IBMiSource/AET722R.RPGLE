000100150327      *=============================================================================================
000200151113      * AET722R - Large Group Accoount Mapping Maintenance
000300150327      *=============================================================================================
000400151113      * Written by:    J. Torres (cloned from AET522R by SSK)
000500151113      * Date Written:  11/13/15
000600150327      * Description:   Small Group Account Mapping
000700150327      *
000800150327      *
000900150327      *  (c)Copyright 2013 by GBS Inc.
001000150327      *  This document contains restricted materials of GBS, Inc.
001100150327
001200150327      *                R E V I S I O N    H I S T O R Y
001300150327      *  Date
001400150327      *  Revised   Initials    Revision
001500150327      *  --------  --------    ---------------------------------------------------------------------
001600150327      *
001700150327      *=============================================================================================
001800151113     FAET722D   CF   E             WORKSTN INFDS(WSDS) SFILE(S01SFL:RR1)
001900150327
002000120813     FCARACCP   UF A E           K DISK
002100150327
002200120813     FCARACCQ   IF   E           K DISK    RENAME(CARACCR:CAL2) PREFIX(ZZ:2)
002300150327
002400120813     FTRMUNIQUE IF   E           K DISK
002500150327
002600120813     FSUMUNIQUE IF   E           K DISK
002700150327
002800150428     FACMUNIQUE IF   E           K DISK    extfile('QS36F/ACMUNIQUE')
002900150327
003000150327      *=============================================================================================
003100120813     D HLD@NAME        S             40A
003200120813     D @EMSG           S                   LIKE(EMSG)
003300120813     D PRV#TRS         S                   LIKE(I_TRST)
003400120813     D PRV#SUB         S                   LIKE(I_SUB#)
003500120813     D PRV#ACC         S                   LIKE(I_ACCT)
003600120813     D ADD_MODE        S               N   INZ(*OFF)
003700120813     D VALID_REC       S               N   INZ(*OFF)
003800120813     D YES             S               N   INZ(*ON)
003900120813     D NO              S               N   INZ(*OFF)
004000150327
004100120813     D WSDS            DS
004200120813     D  FKEY                 369    369A
004300150327
004400120813     D  F1             C                   CONST(X'31')
004500120813     D  F2             C                   CONST(X'32')
004600120813     D  F3             C                   CONST(X'33')
004700120813     D  F4             C                   CONST(X'34')
004800120813     D  F5             C                   CONST(X'35')
004900120813     D  F6             C                   CONST(X'36')
005000120813     D  F7             C                   CONST(X'37')
005100120813     D  F8             C                   CONST(X'38')
005200120813     D  F9             C                   CONST(X'39')
005300120813     D  F10            C                   CONST(X'3A')
005400120813     D  F11            C                   CONST(X'3B')
005500120813     D  F12            C                   CONST(X'3C')
005600120813     D  F13            C                   CONST(X'B1')
005700120813     D  F14            C                   CONST(X'B2')
005800120813     D  F15            C                   CONST(X'B3')
005900120813     D  F16            C                   CONST(X'B4')
006000120813     D  F17            C                   CONST(X'B5')
006100120813     D  F18            C                   CONST(X'B6')
006200120813     D  F19            C                   CONST(X'B7')
006300120813     D  F20            C                   CONST(X'B8')
006400120813     D  F21            C                   CONST(X'B9')
006500120813     D  F22            C                   CONST(X'BA')
006600120813     D  F23            C                   CONST(X'BB')
006700120813     D  F24            C                   CONST(X'BC')
006800150327
006900120813     D                UDS
007000120813     D  XONAME               201    240
007100150327
007200120813     D KF@UNIQ         S                   LIKE(CAUNIQ)
007300151113     D                                     INZ('0000000135')
007400120813     D KF@TRS          S                   LIKE(CATRST)
007500120813     D KF@SUB          S                   LIKE(CASUB#)
007600120813     D KF@ACC          S                   LIKE(CAACCT)
007700150327
007800120813     D @PROC           S             10A
007900150327
008000150327      *=============================================================================================
008100150327      * Mainline
008200150327      *=============================================================================================
008300150327
008400150327      * Main loop...
008500150327     c                   DOU       @PROC = 'EXIT APP  '
008600150327
008700150327     c     @PROC         CASEQ     'PREP SFL  '  $PREPSFL
008800150327     c     @PROC         CASEQ     'BUILD SFL '  $BLDSFL
008900150327     c     @PROC         CASEQ     'SFL CONTRL'  $SFLCTL
009000150327     c     @PROC         CASEQ     'ADD ACCT  '  $ADDACCT
009100150327     c     @PROC         CASEQ     'CHECK SELC'  $CHKSELC
009200150327     c                   ENDCS
009300150327
009400150327     c                   ENDDO
009500150327
009600150327     c                   exsr      exit
009700150327
009800150327      *=============================================================================================
009900150327      * $PREPSFL - Get subfile ready
010000150327      *=============================================================================================
010100150327
010200150327     c     $PREPSFL      BEGSR
010300150327
010400150327     c                   z-add     *ZEROS        RR1               4 0
010500150327     c                   z-add     *ZEROS        #CNTREC           4 0
010600150327
010700150327     c                   EVAL      *IN39 = *OFF
010800150327     c                   EVAL      *IN40 = *OFF
010900150327
011000150327     c                   EVAL      @PROC = 'BUILD SFL '
011100150327
011200150327     c                   ENDSR
011300150327
011400150327      *=============================================================================================
011500150327      * $CLRSFL - Initialize subfile
011600150327      *=============================================================================================
011700150327
011800150327     c     $CLRSFL       BEGSR
011900150327
012000150327     c                   MOVEA     '011'         *IN(25)
012100150327     c                   WRITE     S01CTL
012200150327     c                   MOVEA     '010'         *IN(25)
012300150327     c                   Z-ADD     *ZERO         RR1
012400150327
012500150327     c                   ENDSR
012600150327
012700150327      *=============================================================================================
012800150327      * $BLDSFL - Build subfile
012900150327      *=============================================================================================
013000150327
013100150327     c     $BLDSFL       BEGSR
013200150327
013300150327     c                   MOVE      *ZEROS        #CNTREC
013400150327     c                   MOVE      '0'           @1STLOOP          1
013500150327     c                   MOVE      '0'           @SFLOOP           1
013600150327     c                   MOVE      '0'           *IN20
013700150327
013800150327      * Position subfile?
013900150327     c                   IF        I_TRST = 0
014000150327     c                   EVAL      KF@TRS = 001
014100150327     c                   EVAL      KF@SUB = 001
014200150327     c                   EVAL      KF@ACC = 001
014300150327     c                   ELSE
014400150327     c                   EVAL      KF@TRS = I_TRST
014500150327     c                   EVAL      KF@SUB = I_SUB#
014600150327     c                   EVAL      KF@ACC = I_ACCT
014700150327     c                   ENDIF
014800150327
014900150327     c                   EVAL      I_TRST = 0
015000150327     c                   EVAL      I_SUB# = 0
015100150327     c                   EVAL      I_ACCT = 0
015200150327
015300150327     c                   EXSR      $CLRSFL
015400150327     c                   EVAL      CONAME = HLD@NAME
015500150327
015600150327      * Only load unique records with value = 11 (KF@UNIQ)...
015700150327     c     KL#TSA        SETLL     CAL2
015800150327     c                   DOU       %EOF(CARACCQ) OR @SFLOOP = '1'
015900150327     c                   READ      CAL2
016000150327
016100150327     c                   IF        NOT %EOF(CARACCQ) AND
016200150327     c                             ZZUNIQ = KF@UNIQ
016300150327     c                   EXSR      $LOADSFL
016400150327     c                   ENDIF
016500150327
016600150327     c                   ENDDO
016700150327
016800150327     c                   EVAL      @PROC = 'SFL CONTRL'
016900150327
017000150327     c                   ENDSR
017100150327
017200150327      *=============================================================================================
017300150327      * $LOADSFL - Load subfile
017400150327      *=============================================================================================
017500150327
017600150327     c     $LOADSFL      BEGSR
017700150327
017800150327     c                   MOVE      *ON           *IN25
017900150327     c                   MOVE      *BLANKS       SEL
018000150327
018100150327     c                   EVAL      HUNIQ = ZZUNIQ
018200150327     c                   EVAL      SFTRST = ZZTRST
018300150327     c                   EVAL      SFSUB# = ZZSUB#
018400150327     c                   EVAL      SFACCT = ZZACCT
018500150327
018600150327     c                   EVAL      KF@TRS  = ZZTRST
018700150327     c                   EVAL      KF@SUB  = ZZSUB#
018800150327     c                   EVAL      KF@ACC  = ZZACCT
018900150327
019000150327     c     KL#TSA        CHAIN     ACCMSR
019100150327     c                   IF        NOT %FOUND(ACMUNIQUE)
019200150327     c                   EVAL      SFANAME = '**ERROR**'
019300150327     c                   ELSE
019400150327     c                   MOVE      *BLANKS       @100            100
019500150327     c                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
019600150327     c                             %TRIM(ACNAM2)
019700150327     c                   MOVEL(P)  @100          SFANAME
019800150327     c                   ENDIF
019900150327
020000150327     c                   EVAL      SFSTATUS = ZZSTATUS
020100150327
020200150327     c                   ADD       1             RR1
020300150327
020400150327     c                   IF        @1STLOOP = '0'
020500150327     c                   Z-ADD     RR1           SFLPOS
020600150327     c                   MOVE      '1'           @1STLOOP
020700150327     c                   ENDIF
020800150327
020900150327     c                   WRITE     S01SFL
021000150327
021100150327     c                   ADD       1             #CNTREC
021200150327     c                   IF        #CNTREC = 300
021300150327     c                   MOVE      '1'           @SFLOOP
021400150327     c                   ENDIF
021500150327
021600150327     c                   ENDSR
021700150327
021800150327      *=============================================================================================
021900150327      * $SFLCTL - Subfile control
022000150327      *=============================================================================================
022100150327
022200150327     c     $SFLCTL       BEGSR
022300150327
022400150327     c                   EVAL      EMSG = @EMSG
022500150327
022600150327     c                   WRITE     S01REC
022700150327     c                   EXFMT     S01CTL
022800150327
022900150327     c                   MOVE      *BLANKS       EMSG
023000150327     c                   MOVE      *BLANKS       @EMSG
023100150327
023200150327     c                   IF        FKEY = F3
023300150327     c                   EVAL      @PROC = 'EXIT APP  '
023400150327     c                   LEAVESR
023500150327     c                   ENDIF
023600150327
023700150327     c                   IF        FKEY = F6
023800150327     c                   SETOFF                                       3940
023900150327     c                   CLEAR                   S02R
024000150327     c                   EVAL      CONAME = HLD@NAME
024100150327     c                   EVAL      @PROC = 'ADD ACCT  '
024200150327     c                   LEAVESR
024300150327     c                   ENDIF
024400150327
024500150327     c                   EVAL      @PROC = 'CHECK SELC'
024600150327
024700150327     c                   ENDSR
024800150327
024900150327      *=============================================================================================
025000150327      * $ADDACCT - Add record
025100150327      *=============================================================================================
025200150327
025300150327     c     $ADDACCT      BEGSR
025400150327
025500150327     c                   EXSR      $SCREEN2
025600150327
025700150327     c                   IF        FKEY = F12
025800150327     c                   CLEAR                   S02R
025900150327     c                   EVAL      CONAME = HLD@NAME
026000150327     c                   EVAL      @PROC = 'SFL CONTRL'
026100150327     c                   LEAVESR
026200150327     c                   ENDIF
026300150327
026400150327     c                   EVAL      KF@TRS  = SCTRST
026500150327     c                   EVAL      KF@SUB  = SCSUB#
026600150327     c                   EVAL      KF@ACC  = SCACCT
026700150327
026800150327     c                   EVAL      ADD_MODE = YES
026900150327
027000150327      * Validate command key hit...
027100150327     c                   EXSR      $VALIDKEY
027200150327
027300150327      * Error?
027400150327     c                   IF        VALID_REC = NO
027500150327     c                   LEAVESR
027600150327     c                   ENDIF
027700150327
027800150327      * Validate record...
027900150327     c                   EXSR      $VALIDACC
028000150327
028100150327      * Error?
028200150327     c                   IF        VALID_REC = NO
028300150327     c                   LEAVESR
028400150327     c                   ENDIF
028500150327
028600150327     c                   SETON                                        3940
028700150327
028800150327     c                   DOU       FKEY = F12 OR FKEY = F10
028900150327
029000150327     c                   EXSR      $SCREEN2
029100150327
029200150327      * Cancel...
029300150327     c                   IF        FKEY = F12
029400150327     c                   SETOFF                                       3940
029500150327     c                   LEAVESR
029600150327     c                   ENDIF
029700150327
029800150327      * Add record...
029900150327     c                   IF        FKEY = F10
030000150327     c                   EXSR      $PREPACC
030100150421     c                   EVAL      CACID1 = 'BRICKBODIESFIT'
030200150327     c                   EVAL      CATXT1 = 'SUBMITTER ID'
030300150408     c                   EVAL      CACID2 = '  '
030400150327     c                   EVAL      CATXT2 = 'COMPANY CODE'
030500150327     c                   EVAL      CACID3 = SCCID3
030600150327     c                   EVAL      CATXT3 = 'HMO GROUP NUMBER'
030700150421     c                   EVAL      CACID4 = 'BRICKBODIESFIT'
030800150327     c                   EVAL      CATXT4 = 'CUSTOMER NAME'
030900150327     c                   EVAL      CACID5 = SCCID5
031000150408     c                   EVAL      CATXT5 = 'CUSTOMER NUMBER'
031100150327     c                   EVAL      CACID6 = 'N/A'
031200150327     c                   EVAL      CATXT6 = %TRIM(ACNAM1)
031300150327     c                   EVAL      CACID7 = SCCID7
031400150408     c                   EVAL      CATXT7 = '                 '
031500150408     c                   EVAL      CACID8 = '   '
031600150408     c                   EVAL      CATXT8 = '   '
031700150408     c                   EVAL      CACID9 = '   '
031800150408     c                   EVAL      CATXT9 = '   '
031900150408     c                   EVAL      CACIDA = '   '
032000150408     c                   EVAL      CATXTA = '   '
032100150327     c                   EVAL      CASTATUS = SCSTATUS
032200150327     c                   WRITE     CARACCR
032300150327     c                   LEAVE
032400150327     c                   ENDIF
032500150327
032600150327     c                   ENDDO
032700150327
032800150327     c                   EVAL      @PROC = 'BUILD SFL '
032900150327
033000150327     c                   ENDSR
033100150327
033200150327      *=============================================================================================
033300150327      * $SCREEN2 - Add screen
033400150327      *=============================================================================================
033500150327
033600150327     c     $SCREEN2      BEGSR
033700150327
033800150327     c                   EVAL      EMSG = @EMSG
033900150327     c                   EXFMT     S02R
034000150327     c                   CLEAR                   @EMSG
034100150327     c                   EVAL      EMSG = *BLANKS
034200150327
034300150327     c                   ENDSR
034400150327
034500150327      *=============================================================================================
034600150327      * $VALIDKEY - Validity check
034700150327      *=============================================================================================
034800150327
034900150327     c     $VALIDKEY     BEGSR
035000150327
035100150327     c                   EVAL      VALID_REC = NO
035200150327
035300150327     c                   IF        KF@TRS = 0
035400150327     c                   EVAL      @EMSG = 'MISSING TRUST'
035500150327     c                   LEAVESR
035600150327     c                   ENDIF
035700150327
035800150327     c     KF@TRS        CHAIN     TRSMSR
035900150327     c                   IF        NOT %FOUND(TRMUNIQUE)
036000150327     c                   EVAL      O_TNAM = '**ERROR**'
036100150327     c                   EVAL      @EMSG = 'INVALID TRUST'
036200150327     c                   LEAVESR
036300150327     c                   ENDIF
036400150327
036500150327     c                   MOVEL(P)  TDESCR        O_TNAM
036600150327
036700150327     c                   IF        KF@SUB = 0
036800150327     c                   EVAL      @EMSG = 'MISSING SUBDIVISION'
036900150327     c                   LEAVESR
037000150327     c                   ENDIF
037100150327
037200150327     c     KL#TS         CHAIN     SUBMSR
037300150327     c                   IF        NOT %FOUND(SUMUNIQUE)
037400150327     c                   EVAL      O_SUBN = '**ERROR**'
037500150327     c                   EVAL      @EMSG = 'INVALID TRUST/SUBDIVISION'
037600150327     c                   LEAVESR
037700150327     c                   ENDIF
037800150327
037900150327     c                   MOVEL(P)  SUBDSC        O_SUBN
038000150327
038100150327     c                   IF        KF@ACC = 0
038200150327     c                   EVAL      @EMSG = 'MISSING ACCOUNT'
038300150327     c                   LEAVESR
038400150327     c                   ENDIF
038500150327
038600150327     c     KL#TSA        CHAIN     ACCMSR
038700150327     c                   IF        NOT %FOUND(ACMUNIQUE)
038800150327     c                   EVAL      O_ACCN = '**ERROR**'
038900150327     c                   EVAL      @EMSG = 'INVALID TRUST/SUB/ACCOUNT'
039000150327     c                   LEAVESR
039100150327     c                   ENDIF
039200150327
039300150327     c                   MOVE      *BLANKS       @100
039400150327     c                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
039500150327     c                             %TRIM(ACNAM2)
039600150327     c                   MOVEL(P)  @100          O_ACCN
039700150327
039800150327     c                   IF        ADD_MODE = YES
039900150327     c     KL#UTSA       CHAIN     CARACCR
040000150327     c                   IF        %FOUND(CARACCP)
040100150327     c                   EVAL      @EMSG = 'T/S/A VALUE ALREADY EXISTS'
040200150327     c                   LEAVESR
040300150327     c                   ENDIF
040400150327     c                   ENDIF
040500150327
040600150327     c                   EVAL      VALID_REC = YES
040700150327
040800150327     c                   ENDSR
040900150327
041000150327      *=============================================================================================
041100150327      * $VALIDACCC - Validity check
041200150327      *=============================================================================================
041300150327
041400150327     c     $VALIDACC     BEGSR
041500150327
041600150327     c                   EVAL      VALID_REC = NO
041700150327
041800150327     c                   IF        SCCID3 = *BLANKS AND SCCID5 = *BLANKS
041900150327     c                   EVAL      @EMSG = 'HMO AND PPO CANNOT BOTH BE BLANK'
042000150327     c                   LEAVESR
042100150327     c                   ENDIF
042200150327
042300150327     c                   IF        SCSTATUS <> 'Y' AND SCSTATUS <> 'N'
042400150327     c                   EVAL      @EMSG = 'VALID TRANSMIT FLAG REQUIRED'
042500150327     c                   LEAVESR
042600150327     c                   ENDIF
042700150327
042800150327     c                   EVAL      VALID_REC = YES
042900150327
043000150327     c                   ENDSR
043100150327
043200150327      *=============================================================================================
043300150327      * $PREPACC - Clear file before writing
043400150327      *=============================================================================================
043500150327
043600150327     c     $PREPACC      BEGSR
043700150327
043800150327     c                   CLEAR                   CARACCR
043900150327     c                   EVAL      CAUNIQ = KF@UNIQ
044000150327     c                   EVAL      CATRST = KF@TRS
044100150327     c                   EVAL      CASUB# = KF@SUB
044200150327     c                   EVAL      CAACCT = KF@ACC
044300150327
044400150327     c                   ENDSR
044500150327
044600150327      *=============================================================================================
044700150327      * $CHKSELC - Check subfile record(s) selected
044800150327      *=============================================================================================
044900150327
045000150327     c     $CHKSELC      BEGSR
045100150327
045200150327     c                   IF        I_TRST > 0
045300150327     c                   IF        I_TRST <> PRV#TRS OR
045400150327     c                             I_SUB# <> PRV#SUB OR
045500150327     c                             I_ACCT <> PRV#ACC
045600150327     c                   EVAL      PRV#TRS = I_TRST
045700150327     c                   EVAL      PRV#SUB = I_SUB#
045800150327     c                   EVAL      PRV#ACC = I_ACCT
045900150327     c                   EVAL      @PROC = 'PREP SFL  '
046000150327     c                   LEAVESR
046100150327     c                   ENDIF
046200150327     c                   ENDIF
046300150327
046400151113     c                   DOU       %EOF(AET722D)
046500150327     c                   READC     S01SFL
046600151113     c                   IF        NOT %EOF(AET722D)
046700150327
046800150327     c                   EVAL      KF@TRS  = SFTRST
046900150327     c                   EVAL      KF@SUB  = SFSUB#
047000150327     c                   EVAL      KF@ACC  = SFACCT
047100150327
047200150327     c     KL#UTSA       CHAIN     CARACCR
047300150327
047400150327     c                   SELECT
047500150327
047600150327     c                   WHEN      SEL = 'P'
047700150327     c                   EXSR      $CALLPLNS
047800150327
047900150327     c                   WHEN      SEL = 'I'
048000150327     c                   EXSR      $FMTSCR2
048100150327     c                   EXSR      $INQ2
048200150327
048300150327     c                   WHEN      SEL = 'C'
048400150327     c                   EXSR      $FMTSCR2
048500150327     c                   EXSR      $CHG2
048600150327
048700150327     c                   WHEN      SEL = 'A'
048800150327     c                   EVAL      CASTATUS = 'Y'
048900150327     c                   UPDATE    CARACCR
049000150327
049100150327     c                   WHEN      SEL = 'T'
049200150327     c                   EVAL      CASTATUS = 'N'
049300150327     c                   UPDATE    CARACCR
049400150327
049500151113     c****               WHEN      SEL = 'R'
049600151113     c****               CALL      'AET740WR'
049700151113     c****               parm                    CATRST
049800151113     c****               parm                    CASUB#
049900151113     c****               parm                    CAACCT
050000150415
050100150327     c                   ENDSL
050200150327
050300150327     c                   IF        @EMSG <> *BLANKS
050400150327     c                   LEAVESR
050500150327     c                   ENDIF
050600150327
050700150327     c                   MOVE      *BLANKS       SEL
050800150327     c                   UPDATE    S01SFL
050900150327
051000150327     c                   ENDIF
051100150327     c                   ENDDO
051200150327
051300150327     c****               EVAL      @PROC = 'PREP SFL  '
051400150327     c                   EVAL      @PROC = 'SFL CONTRL'
051500150327
051600150327     c                   ENDSR
051700150327
051800150327      *=============================================================================================
051900150327      * #CALLPLNS - Call plans subfile program
052000150327      *=============================================================================================
052100150327
052200150327     c     $CALLPLNS     BEGSR
052300150327
052400150327     c                   EVAL      PRM@OUT = %EDITC(CATRST:'X') +
052500150327     c                             %EDITC(CASUB#:'X') +
052600150327     c                             %EDITC(CAACCT:'X') + '*'
052700151113     c                   CALL      'AET723CL'
052800150327     c                   PARM                    PRM@OUT          11
052900150327
053000150327     c                   ENDSR
053100150327
053200150327      *=============================================================================================
053300150327      * $FMTSCR2 - Inquity mode screen
053400150327      *=============================================================================================
053500150327
053600150327     c     $FMTSCR2      BEGSR
053700150327
053800150327     c                   SETOFF                                       3940
053900150327     c                   CLEAR                   S02R
054000150327     c                   EVAL      CONAME = HLD@NAME
054100150327
054200150327     c                   EVAL      SCTRST = CATRST
054300150327     c                   EVAL      SCSUB# = CASUB#
054400150327     c                   EVAL      SCACCT = CAACCT
054500150327     c                   EVAL      SCSTATUS = CASTATUS
054600150327
054700150327     c                   EXSR      $CHAINS
054800150327
054900150327     c                   EVAL      SCCID3 = %TRIM(CACID3)
055000150327     c                   EVAL      SCCID5 = %TRIM(CACID5)
055100150327     c                   EVAL      SCCID7 = %TRIM(CACID7)
055200150327
055300150327     c                   ENDSR
055400150327
055500150327      *=============================================================================================
055600150327      * $CHAINS - Get Trust/Sub/Account records
055700150327      *=============================================================================================
055800150327
055900150327     c     $CHAINS       BEGSR
056000150327
056100150327     c     KF@TRS        CHAIN     TRSMSR
056200150327     c                   IF        %FOUND(TRMUNIQUE)
056300150327     c                   MOVEL(P)  TDESCR        O_TNAM
056400150327     c                   ENDIF
056500150327
056600150327     c     KL#TS         CHAIN     SUBMSR
056700150327     c                   IF        %FOUND(SUMUNIQUE)
056800150327     c                   MOVEL(P)  SUBDSC        O_SUBN
056900150327     c                   ENDIF
057000150327
057100150327     c     KL#TSA        CHAIN     ACCMSR
057200150327     c                   IF        %FOUND(ACMUNIQUE)
057300150327     c                   MOVE      *BLANKS       @100
057400150327     c                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
057500150327     c                             %TRIM(ACNAM2)
057600150327     c                   MOVEL(P)  @100          O_ACCN
057700150327     c                   ENDIF
057800150327
057900150327     c                   ENDSR
058000150327
058100150327      *=============================================================================================
058200150327      * $INQ2 - Inquiry screen
058300150327      *=============================================================================================
058400150327
058500150327     c     $INQ2         BEGSR
058600150327
058700150327     c                   EVAL      EMSG = 'INQUIRY ONLY'
058800150327     c                   EVAL      *IN40 = *ON
058900150327     c                   DOU       FKEY = F12
059000150327     c                   EXFMT     S02R
059100150327     c                   ENDDO
059200150327
059300150327     c                   ENDSR
059400150327
059500150327      *=============================================================================================
059600150327      * $CHG2 - Change record
059700150327      *=============================================================================================
059800150327
059900150327     c     $CHG2         BEGSR
060000150327
060100150327     c                   EVAL      @EMSG = 'BE CAREFUL'
060200150327
060300150327     c                   DOU       FKEY = F12
060400150327
060500150327     c                   EXSR      $SCREEN2
060600150327
060700150327     c                   IF        FKEY = F12
060800150327     c                   UNLOCK(E) CARACCP
060900150327     c                   SETOFF                                       3940
061000150327     c                   LEAVESR
061100150327     c                   ENDIF
061200150327
061300150327     c                   EVAL      KF@TRS  = SCTRST
061400150327     c                   EVAL      KF@SUB  = SCSUB#
061500150327     c                   EVAL      KF@ACC  = SCACCT
061600150327     c
061700150327     c                   EVAL      ADD_MODE = NO
061800150327     c                   EXSR      $VALIDKEY
061900150327     c                   IF        VALID_REC = NO
062000150327     c                   ITER
062100150327     c                   ENDIF
062200150327
062300150327     c                   EXSR      $VALIDACC
062400150327     c                   IF        VALID_REC = NO
062500150327     c                   ITER
062600150327     c                   ENDIF
062700150327
062800150327     c                   SETON                                        3940
062900150327     c                   DOU       FKEY = F12 OR FKEY = F10
063000150327     c                   EXSR      $SCREEN2
063100150327
063200150327     c                   IF        FKEY = F12
063300150327     c                   SETOFF                                       3940
063400150327     c                   LEAVESR
063500150327     c                   ENDIF
063600150327
063700150327     c                   IF        FKEY = F10
063800150327     c                   EVAL      CACID3 = SCCID3
063900150327     c                   EVAL      CACID5 = SCCID5
064000150327     c                   EVAL      CACID7 = SCCID7
064100150327     c                   EVAL      CASTATUS = SCSTATUS
064200150327     c                   UPDATE    CARACCR
064300150327     c                   LEAVESR
064400150327     c                   ENDIF
064500150327
064600150327     c                   ENDDO
064700150327
064800150327     c                   ENDDO
064900150327
065000150327     c                   ENDSR
065100150327
065200150327      *=============================================================================================
065300150327      * Exit
065400150327      *=============================================================================================
065500150327
065600150327     c     Exit          begsr
065700150327
065800150327     c                   eval      *inlr = yes
065900150327     c                   return
066000150327
066100150327     c                   endsr
066200150327
066300150327      *=============================================================================================
066400150327      * Initializ subroutine
066500150327      *=============================================================================================
066600150327
066700150327     c     *inzsr        begsr
066800150327
066900150327     c     KL#TS         KLIST
067000150327     c                   KFLD                    KF@TRS
067100150327     c                   KFLD                    KF@SUB
067200150327
067300150327     c     KL#TSA        KLIST
067400150327     c                   KFLD                    KF@TRS
067500150327     c                   KFLD                    KF@SUB
067600150327     c                   KFLD                    KF@ACC
067700150327
067800150327     c     KL#UTSA       KLIST
067900150327     c                   KFLD                    KF@UNIQ
068000150327     c                   KFLD                    KF@TRS
068100150327     c                   KFLD                    KF@SUB
068200150327     c                   KFLD                    KF@ACC
068300150327
068400150327     c                   EVAL      @PROC = 'PREP SFL  '
068500150327     c                   EVAL      HLD@NAME = XONAME
068600150327
068700150327     c                   endsr
068800150327
068900150327      *=============================================================================================
