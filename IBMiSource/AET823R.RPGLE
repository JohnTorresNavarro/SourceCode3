000100150327      *=============================================================================================
000200150327      * AET623R - Large Group Accoount Mapping Maintenance
000300150327      *=============================================================================================
000400151113      * Written by:    J. Torres (cloned from AET523R by SSK)
000500160122      * Date Written:  01/22/16
000600160122      * Description:   Large Group Account Mapping
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
001800160122     FAET823D   CF   E             WORKSTN INFDS(WSDS) SFILE(S01SFL:RR1)
001900150327
002000120808     FCARPLNP   UF A E           K DISK
002100150327
002200120808     FCARPLNX   IF   E           K DISK    RENAME(CARPLNR:CPL2) PREFIX(ZZ:2)
002300150327
002400150410     FCOMCTUNIQ IF   E           K DISK
002500150327
002600120808     FTRMUNIQUE IF   E           K DISK
002700150327
002800120808     FSUMUNIQUE IF   E           K DISK
002900150327
003000120808     FACMUNIQUE IF   E           K DISK
003100150327
003200120808     FPLNUNIQUE IF   E           K DISK
003300150327
003400160122     FAET006WF  UF A E           K DISK
003500150327
003600150327      *=============================================================================================
003700120813     D HLD@NAME        S             40A
003800120813     D @EMSG           S                   LIKE(EMSG)
003900120813     D PRV#TRS         S                   LIKE(I_TRST)
004000120813     D PRV#SUB         S                   LIKE(I_SUB#)
004100120813     D PRV#ACC         S                   LIKE(I_ACCT)
004200120813     D PRV#PLN         S                   LIKE(I_PLAN)
004300120809     D ADD_MODE        S               N   INZ(*OFF)
004400120808     D VALID_REC       S               N   INZ(*OFF)
004500120808     D YES             S               N   INZ(*ON)
004600120808     D NO              S               N   INZ(*OFF)
004700150327
004800000102     D WSDS            DS
004900000102     D  FKEY                 369    369A
005000150327
005100000102     D  F1             C                   CONST(X'31')
005200000102     D  F2             C                   CONST(X'32')
005300000102     D  F3             C                   CONST(X'33')
005400000102     D  F4             C                   CONST(X'34')
005500000102     D  F5             C                   CONST(X'35')
005600000102     D  F6             C                   CONST(X'36')
005700000102     D  F7             C                   CONST(X'37')
005800000102     D  F8             C                   CONST(X'38')
005900000102     D  F9             C                   CONST(X'39')
006000000102     D  F10            C                   CONST(X'3A')
006100000102     D  F11            C                   CONST(X'3B')
006200000102     D  F12            C                   CONST(X'3C')
006300000102     D  F13            C                   CONST(X'B1')
006400000102     D  F14            C                   CONST(X'B2')
006500000102     D  F15            C                   CONST(X'B3')
006600000102     D  F16            C                   CONST(X'B4')
006700000102     D  F17            C                   CONST(X'B5')
006800000102     D  F18            C                   CONST(X'B6')
006900000102     D  F19            C                   CONST(X'B7')
007000000102     D  F20            C                   CONST(X'B8')
007100000102     D  F21            C                   CONST(X'B9')
007200000102     D  F22            C                   CONST(X'BA')
007300000102     D  F23            C                   CONST(X'BB')
007400000102     D  F24            C                   CONST(X'BC')
007500150327
007600000102     D                UDS
007700120813     D  XONAME               201    240
007800150327
007900120906     D KF@RET          S                   LIKE(CPUNIQ)
008000160226     D                                     INZ('9000000150')
008100120808     D KF@UNIQ         S                   LIKE(CPUNIQ)
008200160226     D                                     INZ('0000000150')
008300120808     D KF@TRS          S                   LIKE(CPTRST)
008400120808     D KF@SUB          S                   LIKE(CPSUB#)
008500120808     D KF@ACC          S                   LIKE(CPACCT)
008600120808     D KF@PLN          S                   LIKE(CPPLAN)
008700120808     D KF@CCTR         S                   LIKE(CPCCTR)
008800160122     D KF@MAP          S                   LIKE(AE6MAP)
008900150327
009000120808     D @PROC           S             10A
009100150327
009200120906     D                 DS
009300120906     D @BREAK                 01     11A
009400120906     D  ET                    01     03S 0
009500120906     D  ES                    04     06S 0
009600120906     D  EA                    07     10S 0
009700150327
009800150327      *=============================================================================================
009900150327      * Mainline
010000150327      *=============================================================================================
010100150327
010200150327     c     *ENTRY        PLIST
010300150327     c                   PARM                    @ENTRY           11
010400150327
010500150327     c                   CLEAR                   S02HMO
010600150327     c                   CLEAR                   S03MEA
010700150327     c                   CLEAR                   S04DEN
010800150327     c                   CLEAR                   S05LIF
010900150327     c                   EVAL      @BREAK = @ENTRY
011000150327     c                   EVAL      KF@TRS = ET
011100150327     c                   EVAL      KF@SUB = ES
011200150327     c                   EVAL      KF@ACC = EA
011300150327
011400150327      * Main loop...
011500150327     c                   DOU       @PROC = 'EXIT APP  '
011600150327     c     @PROC         CASEQ     'PREP SFL  '  $PREPSFL
011700150327     c     @PROC         CASEQ     'BUILD SFL '  $BLDSFL
011800150327     c     @PROC         CASEQ     'SFL CONTRL'  $SFLCTL
011900150327     c     @PROC         CASEQ     'ADD HMO   '  $ADDHMO
012000150327     c     @PROC         CASEQ     'ADD MEA   '  $ADDMEA
012100150327     c     @PROC         CASEQ     'ADD DEN   '  $ADDDEN
012200150327     c     @PROC         CASEQ     'ADD LIF   '  $ADDLIF
012300150327     c     @PROC         CASEQ     'CHECK SELC'  $CHKSELC
012400150327     c                   ENDCS
012500000102     C                   ENDDO
012600150327
012700150327     c                   exsr      exit
012800150327
012900150327      *=============================================================================================
013000150327      * $PREPSFL - Get subfile ready
013100150327      *=============================================================================================
013200150327
013300150327     c     $PREPSFL      BEGSR
013400150327
013500150327     c                   MOVE      *ZEROS        RR1               4 0
013600150327     c                   MOVE      *ZEROS        #CNTREC           4 0
013700150327
013800150327     c                   EVAL      *IN39 = *OFF
013900150327     c                   EVAL      *IN40 = *OFF
014000150327
014100150327     c                   EVAL      @PROC = 'BUILD SFL '
014200150327
014300150327     c                   ENDSR
014400150327
014500150327      *=============================================================================================
014600150327      * $CLRSFL - Initialize subfile
014700150327      *=============================================================================================
014800150327
014900150327     c     $CLRSFL       BEGSR
015000150327
015100150327     c                   MOVEA     '011'         *IN(25)
015200150327     c                   WRITE     S01CTL
015300150327     c                   MOVEA     '010'         *IN(25)
015400150327     c                   Z-ADD     *ZERO         RR1
015500150327
015600150327     c                   ENDSR
015700150327
015800150327      *=============================================================================================
015900150327      * $BLDSFL - Build subfile
016000150327      *=============================================================================================
016100150327
016200150327     c     $BLDSFL       BEGSR
016300150327
016400150327     c                   MOVE      *ZEROS        #CNTREC
016500150327     c                   MOVE      '0'           @1STLOOP          1
016600150327     c                   MOVE      '0'           @SFLOOP           1
016700150327     c                   MOVE      '0'           *IN20
016800150327
016900150327     c                   EVAL      I_TRST = ET
017000150327     c                   EVAL      I_SUB# = ES
017100150327     c                   EVAL      I_ACCT = EA
017200150327
017300150327     c                   EVAL      KF@PLN = I_PLAN
017400150327
017500150327     c                   EXSR      $CLRSFL
017600150327     c                   EVAL      CONAME = HLD@NAME
017700150327     c     KL#TSA        CHAIN     ACCMSR
017800150327     c                   IF        NOT %FOUND(ACMUNIQUE)
017900150413     c****               EVAL      D_ACCNAME = '**ERROR**'
018000150413     c                   EVAL      D_ACCNAME = ' '
018100150327     c                   ELSE
018200150327     c                   EVAL      D_ACCNAME = ACNAM1
018300150327     c                   ENDIF
018400150327
018500150327     c     KL#TSAP       SETLL     CPL2
018600150327     c                   DOU       %EOF(CARPLNX)
018700150327     c     KL#TSA        READE     CPL2
018800150327     c                   IF        NOT %EOF(CARPLNX) AND
018900150327     c                             (ZZUNIQ = KF@UNIQ OR
019000150327     c                              ZZUNIQ = KF@RET)
019100150327
019200150327     c                   EXSR      $LOADSFL
019300150327     c                   ENDIF
019400150327     c                   ENDDO
019500150327
019600150327     c                   EVAL      @PROC = 'SFL CONTRL'
019700150327
019800150327     c                   ENDSR
019900150327
020000150327      *=============================================================================================
020100150327      * $LOADSFL - Load subfile
020200150327      *=============================================================================================
020300150327
020400150327     c     $LOADSFL      BEGSR
020500150327
020600150327     c                   MOVE      *ON           *IN25
020700150327     c                   MOVE      *BLANKS       SEL
020800150327
020900150327     c                   EVAL      HUNIQ = ZZUNIQ
021000150327     c                   IF        ZZUNIQ = KF@UNIQ
021100150327     c                   EVAL      SFSTATUS = 'ACTIVE'
021200150327     c                   ELSE
021300150327     c                   EVAL      SFSTATUS = '*RETIRE*'
021400150327     c                   ENDIF
021500150327
021600150327     c                   EVAL      SFCCTR = ZZCCTR
021700150327     c                   EVAL      SFPLAN = ZZPLAN
021800150327
021900150327     c                   EVAL      KF@CCTR = ZZCCTR
022000150327     c                   EVAL      KF@PLN  = ZZPLAN
022100150327
022200160122     c     KL#TSAP       CHAIN     AEF06
022300160122     c                   IF        NOT %FOUND(AET006WF)
022400150413     c****               EVAL      SFMAP = '**ERROR**'
022500150413     c                   EVAL      SFMAP = ' '
022600150327     c                   ELSE
022700160122     c                   EVAL      SFMAP = AE6MAP
022800150327     c                   ENDIF
022900150327
023000150327     c     KL#TSP        CHAIN     PLNMSR
023100150327     c                   IF        NOT %FOUND(PLNUNIQUE)
023200150413     c****               EVAL      SFPNAME = '**ERROR**'
023300150413     c                   EVAL      SFPNAME = ' '
023400150327     c                   ELSE
023500150327     c                   EVAL      SFPNAME= %TRIM(PDESCR)
023600150327     c                   ENDIF
023700150327
023800150327     c                   ADD       1             RR1
023900150327
024000150327     c                   IF        @1STLOOP = '0'
024100150327     c                   Z-ADD     RR1           SFLPOS
024200150327     c                   MOVE      '1'           @1STLOOP
024300150327     c                   ENDIF
024400150327
024500150327     c                   WRITE     S01SFL
024600150327
024700150327     c                   ADD       1             #CNTREC
024800150327     c                   IF        #CNTREC = 500
024900150327     c                   MOVE      '1'           @SFLOOP
025000150327     c                   ENDIF
025100150327
025200150327     c                   ENDSR
025300150327
025400150327      *=============================================================================================
025500150327      * $SFLCTL - Subfile control
025600150327      *=============================================================================================
025700150327
025800150327     c     $SFLCTL       BEGSR
025900150327
026000150327     c                   EVAL      EMSG = @EMSG
026100150327
026200150327     c                   WRITE     S01REC
026300150327     c                   EXFMT     S01CTL
026400150327
026500150327     c                   MOVE      *BLANKS       EMSG
026600150327     c                   MOVE      *BLANKS       @EMSG
026700150327
026800150327     c                   IF        FKEY = F3
026900150327     c                   EVAL      @PROC = 'EXIT APP  '
027000150327     c                   LEAVESR
027100150327     c                   ENDIF
027200150327
027300150327     c                   IF        FKEY = F6
027400150327     c                   SETOFF                                       3940
027500150327     c****               CLEAR                   S02HMO
027600150327
027700150327     c                   EVAL      CONAME = HLD@NAME
027800150327     c                   EVAL      S2TRST = ET
027900150327     c                   EVAL      S2SUB# = ES
028000150327     c                   EVAL      S2ACCT = EA
028100150327     c                   EXSR      $GETTSA
028200150327     c                   EVAL      @PROC = 'ADD HMO   '
028300150327     c                   LEAVESR
028400150327     c                   ENDIF
028500150327
028600150327     c                   IF        FKEY = F7
028700150327     c                   SETOFF                                       3940
028800150327     c****               CLEAR                   S03MEA
028900150327     c                   EVAL      S3TRST = ET
029000150327     c                   EVAL      S3SUB# = ES
029100150327     c                   EVAL      S3ACCT = EA
029200150327     c                   EXSR      $GETTSA
029300150327     c                   EVAL      CONAME = HLD@NAME
029400150327     c                   EVAL      @PROC = 'ADD MEA   '
029500150327     c                   LEAVESR
029600150327     c                   ENDIF
029700150327
029800150327     c                   IF        FKEY = F8
029900150327     c                   SETOFF                                       3940
030000150327     c****               CLEAR                   S04DEN
030100150327     c                   EVAL      CONAME = HLD@NAME
030200150327     c                   EVAL      S4TRST = ET
030300150327     c                   EVAL      S4SUB# = ES
030400150327     c                   EVAL      S4ACCT = EA
030500150327     c                   EXSR      $GETTSA
030600150327     c                   EVAL      @PROC = 'ADD DEN   '
030700150327     c                   LEAVESR
030800150327     c                   ENDIF
030900150327
031000150327     c                   IF        FKEY = F9
031100150327     c                   SETOFF                                       3940
031200150327     c****               CLEAR                   S05LIF
031300150327     c                   EVAL      CONAME = HLD@NAME
031400150327     c                   EVAL      S5TRST = ET
031500150327     c                   EVAL      S5SUB# = ES
031600150327     c                   EVAL      S5ACCT = EA
031700150327     c                   EXSR      $GETTSA
031800150327     c                   EVAL      @PROC = 'ADD LIF   '
031900150327     c                   LEAVESR
032000150327     c                   ENDIF
032100150327
032200150327     c                   EVAL      @PROC = 'CHECK SELC'
032300150327
032400150327     c                   ENDSR
032500150327
032600150327      *=============================================================================================
032700150327      * $ADDHMO - Add HMO
032800150327      *=============================================================================================
032900150327
033000150327     c     $ADDHMO       BEGSR
033100150327
033200150327     c                   EXSR      $SCREEN2
033300150327
033400150327     c                   IF        FKEY = F12
033500150327     c                   CLEAR                   S02HMO
033600150327     c                   EVAL      CONAME = HLD@NAME
033700150327     c                   EVAL      @PROC = 'SFL CONTRL'
033800150327     c                   LEAVESR
033900150327     c                   ENDIF
034000150327
034100150327     c                   EVAL      KF@TRS  = ET
034200150327     c                   EVAL      KF@SUB  = ES
034300150327     c                   EVAL      KF@ACC  = EA
034400150327     c                   EVAL      KF@PLN  = S2PLAN
034500150327     c                   EVAL      KF@CCTR = S2CCTR
034600150327     c                   EVAL      KF@MAP  = S2MAP
034700150327
034800150327     c                   EVAL      ADD_MODE = YES
034900150327
035000150327      * Validate record...
035100150327     c                   EXSR      $VALIDKEY
035200150327
035300150327      * Error?
035400150327     c                   IF        VALID_REC = NO
035500150327     c                   LEAVESR
035600150327     c                   ENDIF
035700150327
035800150327      * Validate record...
035900150327     c                   EXSR      $VALIDHMO
036000150327
036100150327      * Error?
036200150327     c                   IF        VALID_REC = NO
036300150327     c                   LEAVESR
036400150327     c                   ENDIF
036500150327
036600150327     c                   SETON                                        3940
036700150327
036800150327     c                   DOU       FKEY = F12 OR FKEY = F10
036900150327
037000150327     c                   EXSR      $SCREEN2
037100150327
037200150327     c                   IF        FKEY = F12
037300150327     c                   SETOFF                                       3940
037400150327     c                   LEAVESR
037500150327     c                   ENDIF
037600150327
037700150327     c                   IF        FKEY = F10
037800150327     c                   EXSR      $PREPLN
037900150327     c                   EVAL      CPCID1 = 'HMO'
038000150327     c                   EVAL      CPTXT1 = 'LAYOUT CODE'
038100150327     c                   EVAL      CPCID2 = S2CID2
038200150327     c                   EVAL      CPTXT2 = 'FILE NUMBER'
038300150327     c                   EVAL      CPCID3 = S2CID3
038400150327     c                   EVAL      CPTXT3 = 'CLASS CODE'
038500150327     c                   EVAL      CPCID4 = S2CID4
038600150327     c                   EVAL      CPTXT4 = 'PLAN'
038700150327     c                   EVAL      CPCID5 = 'N/A'
038800150327     c                   EVAL      CPTXT5 = 'N/A'
038900150327     c                   EVAL      CPCID6 = 'N/A'
039000150327     c                   EVAL      CPTXT6 = 'N/A'
039100150327     c                   WRITE     CARPLNR
039200150327     c                   LEAVE
039300150327     c                   ENDIF
039400150327
039500150327     c                   ENDDO
039600150327
039700150409     c                   EVAL      @PROC = 'BUILD SFL '
039800150327
039900150327     c                   ENDSR
040000150327
040100150327      *=============================================================================================
040200150327      * $SCREEN2 - Error Screen
040300150327      *=============================================================================================
040400150327
040500150327     c     $SCREEN2      BEGSR
040600150327
040700150327     c                   EVAL      EMSG = @EMSG
040800150327     c                   EXFMT     S02HMO
040900150327     c                   CLEAR                   @EMSG
041000150327     c                   EVAL      EMSG = *BLANKS
041100150327
041200150327     c                   ENDSR
041300150327
041400150327      *=============================================================================================
041500150327      * $SCREEN3 - Error screen
041600150327      *=============================================================================================
041700150327
041800150327     c     $SCREEN3      BEGSR
041900150327
042000150327     c                   EVAL      EMSG = @EMSG
042100150327     c                   EXFMT     S03MEA
042200150327     c                   CLEAR                   @EMSG
042300150327     c                   EVAL      EMSG = *BLANKS
042400150327
042500150327     c                   ENDSR
042600150327
042700150327      *=============================================================================================
042800150327      * $SCREEN4 - Error screen
042900150327      *=============================================================================================
043000150327
043100150327     c     $SCREEN4      BEGSR
043200150327
043300150327     c                   EVAL      EMSG = @EMSG
043400150327     c                   EXFMT     S04DEN
043500150327     c                   CLEAR                   @EMSG
043600150327     c                   EVAL      EMSG = *BLANKS
043700150327
043800150327     c                   ENDSR
043900150327
044000150327      *=============================================================================================
044100150327      * $SCREEN5 - Error screen
044200150327      *=============================================================================================
044300150327
044400150327     c     $SCREEN5      BEGSR
044500150327
044600150327     c                   EVAL      EMSG = @EMSG
044700150327     c                   EXFMT     S05LIF
044800150327     c                   CLEAR                   @EMSG
044900150327     c                   EVAL      EMSG = *BLANKS
045000150327
045100150327     c                   ENDSR
045200150327
045300150327      *=============================================================================================
045400150327      * $GETTSA - Check Trust/Sub/Account
045500150327      *=============================================================================================
045600150327
045700150327     c     $GETTSA       BEGSR
045800150327
045900150327     c                   EVAL      KF@TRS  = ET
046000150327     c                   EVAL      KF@SUB  = ES
046100150327     c                   EVAL      KF@ACC  = EA
046200150327
046300150327     c     KF@TRS        CHAIN     TRSMSR
046400150327     c                   IF        NOT %FOUND(TRMUNIQUE)
046500150413     c****               EVAL      O_TNAM = '**ERROR**'
046600150413     c                   EVAL      O_TNAM = ' '
046700150327     c                   ELSE
046800150327     c                   MOVEL(P)  TDESCR        O_TNAM
046900150327     c                   ENDIF
047000150327
047100150327     c     KL#TS         CHAIN     SUBMSR
047200150327     c                   IF        NOT %FOUND(SUMUNIQUE)
047300150413     c****               EVAL      O_SUBN = '**ERROR**'
047400150413     c                   EVAL      O_SUBN = ' '
047500150327     c                   ELSE
047600150327     c                   MOVEL(P)  SUBDSC        O_SUBN
047700150327     c                   ENDIF
047800150327
047900150327     c     KL#TSA        CHAIN     ACCMSR
048000150327     c                   IF        NOT %FOUND(ACMUNIQUE)
048100150413     c****               EVAL      O_ACCN = '**ERROR**'
048200150413     c                   EVAL      O_ACCN = ' '
048300150327     c                   ELSE
048400150327     c                   EVAL      O_ACCN = ACNAM1
048500150327     c                   ENDIF
048600150327
048700150327     c                   MOVE      *BLANKS       D_PLAN
048800150327
048900150327     c                   ENDSR
049000150327
049100150327      *=============================================================================================
049200150327      * $VALIDKEY - Validity check
049300150327      *=============================================================================================
049400150327
049500150327     c     $VALIDKEY     BEGSR
049600150327
049700150327     c                   EVAL      VALID_REC = NO
049800150327
049900150327     c     KL#TSP        CHAIN     PLNMSR
050000150327     c                   IF        NOT %FOUND(PLNUNIQUE)
050100150413     c****               EVAL      D_PLAN = '**ERROR**'
050200150413     c                   EVAL      D_PLAN = ' '
050300150327     c                   EVAL      @EMSG = 'INVALID TRUST/SUB/PLAN'
050400150327     c                   LEAVESR
050500150327     c                   ENDIF
050600150327
050700150327     c     KL#TSAP       CHAIN     COMCXR
050800150410     c                   IF        NOT %FOUND(COMCTUNIQ)
050900150327     c                   EVAL      @EMSG = 'COMMISSION CONTROL N/F'
051000150327     c                   LEAVESR
051100150327     c                   ENDIF
051200150327
051300150327     c                   MOVEL(P)  PDESCR        D_PLAN
051400150327
051500150327     c                   IF        KF@MAP = *BLANKS
051600150327     c                   EVAL      @EMSG = 'MISSING MAP'
051700150327     c                   LEAVESR
051800150327     c                   ENDIF
051900150327
052000150327     c                   IF        KF@MAP <> '2TIER     ' AND
052100150327     c                             KF@MAP <> 'TIERSTS   ' AND
052200150327     c                             KF@MAP <> 'STATETIER ' AND
052300150327     c                             KF@MAP <> 'EMPSTS    ' AND
052400150327     c                             KF@MAP <> 'ITOBJECTS ' AND
052500150327     c                             KF@MAP <> 'JUSTSTATE ' AND
052600150327     c                             KF@MAP <> 'STSTATE   ' AND
052700150327     c                             KF@MAP <> 'STIERSTS  ' AND
052800150327     c                             KF@MAP <> 'CREATIVE  ' AND
052900150327     c                             KF@MAP <> 'JOHNLS    ' AND
053000150327     c                             KF@MAP <> 'INTEGRA   ' AND
053100150327     c                             KF@MAP <> 'MAYOR     ' AND
053200150327     c                             KF@MAP <> 'NORULE    '
053300150327     c                   EVAL      @EMSG = 'INVALID MAP; REFER TO MAP DOCUMENT'
053400150327     c                   LEAVESR
053500150327     c                   ENDIF
053600150327
053700150327     c                   IF        KF@MAP <> 'NORULE' AND
053800150327     c                             KF@CCTR = *BLANKS
053900150327     c                   EVAL      @EMSG = 'MISSING MAPPING VALUE'
054000150327     c                   LEAVESR
054100150327     c                   ENDIF
054200150327
054300150327     c                   IF        ADD_MODE = YES
054400150327     c     KL#UTSACP     CHAIN     CARPLNR
054500150327     c                   IF        %FOUND(CARPLNP)
054600150327     c                   EVAL      @EMSG = 'T/S/A/P/MAP VALUE ALREADY EXISTS'
054700150327     c                   LEAVESR
054800150327     c                   ENDIF
054900150327     c                   ENDIF
055000150327
055100150327     c                   EVAL      VALID_REC = YES
055200150327
055300150327     c                   ENDSR
055400150327
055500150327      *=============================================================================================
055600150327      * $VALIDHMO - Validity check
055700150327      *=============================================================================================
055800150327
055900150327     c     $VALIDHMO     BEGSR
056000150327
056100150327     c                   EVAL      VALID_REC = NO
056200150327
056300150327     c                   IF        S2CID2 = *BLANKS
056400150327     c                   EVAL      @EMSG = 'FILE NUMBER IS REQUIRED'
056500150327     c                   LEAVESR
056600150327     c                   ENDIF
056700150327
056800150327     c                   IF        S2CID3 = *BLANKS
056900150327     c                   EVAL      @EMSG = 'CLASS CODE IS REQUIRED'
057000150327     c                   LEAVESR
057100150327     c                   ENDIF
057200150327
057300150327     c                   IF        S2CID4 = *BLANKS
057400150327     c                   EVAL      @EMSG = 'PLAN NUMBER IS REQUIRED'
057500150327     c                   LEAVESR
057600150327     c                   ENDIF
057700150327
057800150327     c                   EVAL      VALID_REC = YES
057900150327
058000150327     c                   ENDSR
058100150327
058200150327      *=============================================================================================
058300150327      * $PREPLN - Clear file before writing
058400150327      *=============================================================================================
058500150327
058600150327     c     $PREPLN       BEGSR
058700150327
058800160122     c     KL#TSAP       CHAIN     AET006WF
058900160122     c                   IF        NOT %FOUND(AET006WF)
059000160122     c                   CLEAR                   AEF06
059100160122     c                   EVAL      AE6TRS = ET
059200160122     c                   EVAL      AE6SUB = ES
059300160122     c                   EVAL      AE6ACC = EA
059400160122     c                   EVAL      AE6PLN = KF@PLN
059500160122     c                   EVAL      AE6MAP = KF@MAP
059600160122     c                   WRITE(E)  AEF06
059700150327     c                   ENDIF
059800150327
059900150327     c                   CLEAR                   CARPLNR
060000150327     c                   EVAL      CPUNIQ = KF@UNIQ
060100150327     c                   EVAL      CPTRST = ET
060200150327     c                   EVAL      CPSUB# = ES
060300150327     c                   EVAL      CPACCT = EA
060400150327     c                   EVAL      CPCCTR = KF@CCTR
060500150327     c                   EVAL      CPPLAN = KF@PLN
060600150327
060700150327     c                   ENDSR
060800150327
060900150327      *=============================================================================================
061000150327      * $ADDMEA - Add record
061100150327      *=============================================================================================
061200150327
061300150327     c     $ADDMEA       BEGSR
061400150327
061500150327     c                   EXSR      $SCREEN3
061600150327
061700150327     c                   IF        FKEY = F12
061800150327     c                   CLEAR                   S03MEA
061900150327     c                   EVAL      CONAME = HLD@NAME
062000150327     c                   EVAL      @PROC = 'SFL CONTRL'
062100150327     c                   LEAVESR
062200150327     c                   ENDIF
062300150327
062400150327     c                   EVAL      KF@TRS  = ET
062500150327     c                   EVAL      KF@SUB  = ES
062600150327     c                   EVAL      KF@ACC  = EA
062700150327     c                   EVAL      KF@PLN  = S3PLAN
062800150327     c                   EVAL      KF@CCTR = S3CCTR
062900150327     c                   EVAL      KF@MAP  = S3MAP
063000150327
063100150327     c                   EVAL      ADD_MODE = YES
063200150327     c                   EXSR      $VALIDKEY
063300150327
063400150327     c                   IF        VALID_REC = NO
063500150327     c                   LEAVESR
063600150327     c                   ENDIF
063700150327
063800150327     c                   EXSR      $VALIDMEA
063900150327
064000150327     c                   IF        VALID_REC = NO
064100150327     c                   LEAVESR
064200150327     c                   ENDIF
064300150327
064400150327     c                   SETON                                        3940
064500150327
064600150327     c                   DOU       FKEY = F12 OR FKEY = F10
064700150327
064800150327     c                   EXSR      $SCREEN3
064900150327
065000150327     c                   IF        FKEY = F12
065100150327     c                   SETOFF                                       3940
065200150327     c                   LEAVESR
065300150327     c                   ENDIF
065400150327
065500150327     c                   IF        FKEY = F10
065600150327     c                   EXSR      $PREPLN
065700150327     c                   EVAL      CPCID1 = 'MEA'
065800150327     c                   EVAL      CPTXT1 = 'LAYOUT CODE'
065900150327     c                   EVAL      CPCID2 = S3CID2
066000150327     c                   EVAL      CPTXT2 = 'ELR'
066100150327     c                   EVAL      CPCID3 = S3CID3
066200150327     c                   EVAL      CPTXT3 = 'SUFFIX'
066300150327     c                   EVAL      CPCID4 = S3CID4
066400150327     c                   EVAL      CPTXT4 = 'ACCOUNT'
066500150327     c                   EVAL      CPCID5 = S3CID5
066600150327     c                   EVAL      CPTXT5 = 'PLAN'
066700150327     c                   EVAL      CPCID6 = S3CID6
066800150327     c                   EVAL      CPTXT6 = 'CLAIM OFFICE'
066900150327     c                   WRITE     CARPLNR
067000150327     c                   LEAVE
067100150327     c                   ENDIF
067200150327
067300150327     c                   ENDDO
067400150327
067500150409     c                   EVAL      @PROC = 'BUILD SFL '
067600150327
067700150327     c                   ENDSR
067800150327
067900150327      *=============================================================================================
068000150327      * $VALIDMEA - Validity check
068100150327      *=============================================================================================
068200150327
068300150327     c     $VALIDMEA     BEGSR
068400150327
068500150327     c                   EVAL      VALID_REC = NO
068600150327
068700150327     c                   IF        S3CID2 = *BLANKS
068800150327     c                   EVAL      @EMSG = 'ELR IS REQUIRED'
068900150327     c                   LEAVESR
069000150327     c                   ENDIF
069100150327
069200150327     c                   IF        S3CID3 = *BLANKS
069300150327     c                   EVAL      @EMSG = 'SUFFIX IS REQUIRED'
069400150327     c                   LEAVESR
069500150327     c                   ENDIF
069600150327
069700150327     c                   IF        S3CID4 = *BLANKS
069800150327     c                   EVAL      @EMSG = 'ACCOUNT IS REQUIRED'
069900150327     c                   LEAVESR
070000150327     c                   ENDIF
070100150327
070200150327     c                   IF        S3CID5 = *BLANKS
070300150327     c                   EVAL      @EMSG = 'PLAN IS REQUIRED'
070400150327     c                   LEAVESR
070500150327     c                   ENDIF
070600150327
070700150327     c                   IF        S3CID6 = *BLANKS
070800150327     c                   EVAL      @EMSG = 'CLAIM OFFICE IS REQUIRED'
070900150327     c                   LEAVESR
071000150327     c                   ENDIF
071100150327
071200150327     c                   EVAL      VALID_REC = YES
071300150327
071400150327     c                   ENDSR
071500150327
071600150327      *=============================================================================================
071700150327      * $ADDDEN - Add dental
071800150327      *=============================================================================================
071900150327
072000150327     c     $ADDDEN       BEGSR
072100150327
072200150327     c                   EXSR      $SCREEN4
072300150327
072400150327     c                   IF        FKEY = F12
072500150327     c                   CLEAR                   S04DEN
072600150327     c                   EVAL      CONAME = HLD@NAME
072700150327     c                   EVAL      @PROC = 'SFL CONTRL'
072800150327     c                   LEAVESR
072900150327     c                   ENDIF
073000150327
073100150327     c                   EVAL      KF@TRS  = ET
073200150327     c                   EVAL      KF@SUB  = ES
073300150327     c                   EVAL      KF@ACC  = EA
073400150327     c                   EVAL      KF@PLN  = S4PLAN
073500150327     c                   EVAL      KF@CCTR = S4CCTR
073600150327     c                   EVAL      KF@MAP  = S4MAP
073700150327
073800150327     c                   EVAL      ADD_MODE = YES
073900150327     c                   EXSR      $VALIDKEY
074000150327
074100150327     c                   IF        VALID_REC = NO
074200150327     c                   LEAVESR
074300150327     c                   ENDIF
074400150327
074500150327     c                   EXSR      $VALIDDEN
074600150327
074700150327     c                   IF        VALID_REC = NO
074800150327     c                   LEAVESR
074900150327     c                   ENDIF
075000150327
075100150327     c                   SETON                                        3940
075200150327
075300150327     c                   DOU       FKEY = F12 OR FKEY = F10
075400150327
075500150327     c                   EXSR      $SCREEN4
075600150327
075700150327     c                   IF        FKEY = F12
075800150327     c                   SETOFF                                       3940
075900150327     c                   LEAVESR
076000150327     c                   ENDIF
076100120808      *
076200150327     c                   IF        FKEY = F10
076300150327     c                   EXSR      $PREPLN
076400150327     c                   EVAL      CPCID1 = 'DEN'
076500150327     c                   EVAL      CPTXT1 = 'LAYOUT CODE'
076600150327     c                   EVAL      CPCID2 = S4CID2
076700150327     c                   EVAL      CPTXT2 = 'ELR'
076800150327     c                   EVAL      CPCID3 = S4CID3
076900150327     c                   EVAL      CPTXT3 = 'SUFFIX'
077000150327     c                   EVAL      CPCID4 = S4CID4
077100150327     c                   EVAL      CPTXT4 = 'ACCOUNT'
077200150327     c                   EVAL      CPCID5 = S4CID5
077300150327     c                   EVAL      CPTXT5 = 'PLAN'
077400150327     c                   EVAL      CPCID6 = S4CID6
077500150327     c                   EVAL      CPTXT6 = 'CLAIM OFFICE'
077600150327     c                   WRITE     CARPLNR
077700150327     c                   LEAVE
077800150327     c                   ENDIF
077900150327
078000150327     c                   ENDDO
078100150327
078200150409     c                   EVAL      @PROC = 'BUILD SFL '
078300150327
078400150327     c                   ENDSR
078500150327
078600150327      *=============================================================================================
078700150327      * $VALIDDEN - Validity check
078800150327      *=============================================================================================
078900150327
079000150327     c     $VALIDDEN     BEGSR
079100150327
079200150327     c                   EVAL      VALID_REC = NO
079300150327
079400150327     c                   IF        S4CID2 = *BLANKS
079500150327     c                   EVAL      @EMSG = 'ELR IS REQUIRED'
079600150327     c                   LEAVESR
079700150327     c                   ENDIF
079800150327
079900150327     c                   IF        S4CID3 = *BLANKS
080000150327     c                   EVAL      @EMSG = 'SUFFIX IS REQUIRED'
080100150327     c                   LEAVESR
080200150327     c                   ENDIF
080300150327
080400150327     c                   IF        S4CID4 = *BLANKS
080500150327     c                   EVAL      @EMSG = 'ACCOUNT IS REQUIRED'
080600150327     c                   LEAVESR
080700150327     c                   ENDIF
080800150327
080900150327     c                   IF        S4CID5 = *BLANKS
081000150327     c                   EVAL      @EMSG = 'PLAN IS REQUIRED'
081100150327     c                   LEAVESR
081200150327     c                   ENDIF
081300150327
081400150327     c                   IF        S4CID6 = *BLANKS
081500150327     c                   EVAL      @EMSG = 'CLAIM OFFICE IS REQUIRED'
081600150327     c                   LEAVESR
081700150327     c                   ENDIF
081800150327
081900150327     c                   EVAL      VALID_REC = YES
082000150327
082100150327     c                   ENDSR
082200150327
082300150327      *=============================================================================================
082400150327      * $ADDDEN - Add life
082500150327      *=============================================================================================
082600150327
082700150327     c     $ADDLIF       BEGSR
082800150327
082900150327     c                   EXSR      $SCREEN5
083000150327
083100150327     c                   IF        FKEY = F12
083200150327     c                   CLEAR                   S05LIF
083300150327     c                   EVAL      CONAME = HLD@NAME
083400150327     c                   EVAL      @PROC = 'SFL CONTRL'
083500150327     c                   LEAVESR
083600150327     c                   ENDIF
083700150327
083800150327     c                   EVAL      KF@TRS  = ET
083900150327     c                   EVAL      KF@SUB  = ES
084000150327     c                   EVAL      KF@ACC  = EA
084100150327     c                   EVAL      KF@PLN  = S5PLAN
084200150327     c                   EVAL      KF@CCTR = S5CCTR
084300150327     c                   EVAL      KF@MAP  = S5MAP
084400150327
084500150327     c                   EVAL      ADD_MODE = YES
084600150327     c                   EXSR      $VALIDKEY
084700150327
084800150327     c                   IF        VALID_REC = NO
084900150327     c                   LEAVESR
085000150327     c                   ENDIF
085100150327
085200150327     c                   EXSR      $VALIDLIF
085300150327
085400150327     c                   IF        VALID_REC = NO
085500150327     c                   LEAVESR
085600150327     c                   ENDIF
085700150327
085800150327     c                   SETON                                        3940
085900150327
086000150327     c                   DOU       FKEY = F12 OR FKEY = F10
086100150327
086200150327     c                   EXSR      $SCREEN5
086300150327
086400150327     c                   IF        FKEY = F12
086500150327     c                   SETOFF                                       3940
086600150327     c                   LEAVESR
086700150327     c                   ENDIF
086800150327
086900150327     c                   IF        FKEY = F10
087000150327     c                   EXSR      $PREPLN
087100150327     c                   EVAL      CPCID1 = 'LIF'
087200150327     c                   EVAL      CPTXT1 = 'LAYOUT CODE'
087300150327     c                   EVAL      CPCID2 = S5CID2
087400150327     c                   EVAL      CPTXT2 = 'ELR'
087500150327     c                   EVAL      CPCID3 = S5CID3
087600150327     c                   EVAL      CPTXT3 = 'SUFFIX'
087700150327     c                   EVAL      CPCID4 = S5CID4
087800150327     c                   EVAL      CPTXT4 = 'ACCOUNT'
087900150327     c                   EVAL      CPCID5 = S5CID5
088000150327     c                   EVAL      CPTXT5 = 'PLAN'
088100150327     c                   EVAL      CPCID6 = S5CID6
088200150327     c                   EVAL      CPTXT6 = 'CLAIM OFFICE'
088300150327     c                   WRITE     CARPLNR
088400150327     c                   LEAVE
088500150327     c                   ENDIF
088600150327
088700150327     c                   ENDDO
088800150327
088900150409     c                   EVAL      @PROC = 'BUILD SFL '
089000150327
089100150327     c                   ENDSR
089200150327
089300150327      *=============================================================================================
089400150327      * $VALIDDEN - Validity check
089500150327      *=============================================================================================
089600150327
089700150327     c     $VALIDLIF     BEGSR
089800150327
089900150327     c                   EVAL      VALID_REC = NO
090000150327
090100150327     c                   IF        S5CID2 = *BLANKS
090200150327     c                   EVAL      @EMSG = 'ELR IS REQUIRED'
090300150327     c                   LEAVESR
090400150327     c                   ENDIF
090500150327
090600150327     c                   IF        S5CID3 = *BLANKS
090700150327     c                   EVAL      @EMSG = 'SUFFIX IS REQUIRED'
090800150327     c                   LEAVESR
090900150327     c                   ENDIF
091000150327
091100150327     c                   IF        S5CID4 = *BLANKS
091200150327     c                   EVAL      @EMSG = 'ACCOUNT IS REQUIRED'
091300150327     c                   LEAVESR
091400150327     c                   ENDIF
091500150327
091600150327     c                   IF        S5CID5 = *BLANKS
091700150327     c                   EVAL      @EMSG = 'PLAN IS REQUIRED'
091800150327     c                   LEAVESR
091900150327     c                   ENDIF
092000150327
092100150327     c                   IF        S5CID6 = *BLANKS
092200150327     c                   EVAL      @EMSG = 'CLAIM OFFICE IS REQUIRED'
092300150327     c                   LEAVESR
092400150327     c                   ENDIF
092500150327
092600150327     c                   EVAL      VALID_REC = YES
092700150327
092800150327     c                   ENDSR
092900150327
093000150327      *=============================================================================================
093100150327      * $CHKSELC - Check subfile record(s) selected
093200150327      *=============================================================================================
093300150327
093400150327     c     $CHKSELC      BEGSR
093500150327
093600150327     c                   IF        I_PLAN <> PRV#PLN
093700150327     c                   EVAL      PRV#PLN = I_PLAN
093800150327     c                   EVAL      @PROC = 'PREP SFL  '
093900150327     c                   LEAVESR
094000150327     c                   ENDIF
094100150327
094200160122     c                   DOU       %EOF(AET823D)
094300150327     c                   READC     S01SFL
094400160122     c                   IF        NOT %EOF(AET823D)
094500150327
094600150327     c                   EVAL      KF@TRS  = ET
094700150327     c                   EVAL      KF@SUB  = ES
094800150327     c                   EVAL      KF@ACC  = EA
094900150327     c                   EVAL      KF@PLN  = SFPLAN
095000150327     c                   EVAL      KF@CCTR = SFCCTR
095100150327     c                   EVAL      KF@MAP  = SFMAP
095200150327
095300150327     c                   IF        SEL = 'U'
095400150327     c     KL#RTSACP     CHAIN     CARPLNR
095500150327     c                   ELSE
095600150327     c     KL#UTSACP     CHAIN     CARPLNR
095700150327     c                   ENDIF
095800160122     c     KL#TSAP       CHAIN     AET006WF
095900150327
096000150327     c                   SELECT
096100150327
096200150327     c                   WHEN      SEL = 'R'
096300150327     c                   EVAL      CPUNIQ = KF@RET
096400150327     c                   UPDATE    CARPLNR
096500160122     c                   UNLOCK(E) AET006WF
096600150327
096700150327     c                   WHEN      SEL = 'U'
096800150327     c                   EVAL      CPUNIQ = KF@UNIQ
096900150327     c                   UPDATE    CARPLNR
097000160122     c                   UNLOCK(E) AET006WF
097100150327
097200150327     c                   WHEN      CPCID1 = 'HMO' AND SEL = 'I'
097300150327     c                   EXSR      $FMTSCR2
097400150327     c                   EXSR      $INQ2
097500150327
097600150327     c                   WHEN      CPCID1 = 'HMO' AND SEL = 'C'
097700150327     c                   EXSR      $FMTSCR2
097800150327     c                   EXSR      $CHG2
097900150327
098000150327     c                   WHEN      CPCID1 = 'MEA' AND SEL = 'I'
098100150327     c                   EXSR      $FMTSCR3
098200150327     c                   EXSR      $INQ3
098300150327
098400150327     c                   WHEN      CPCID1 = 'MEA' AND SEL = 'C'
098500150327     c                   EXSR      $FMTSCR3
098600150327     c                   EXSR      $CHG3
098700150327
098800150327     c                   WHEN      CPCID1 = 'DEN' AND SEL = 'I'
098900150327     c                   EXSR      $FMTSCR4
099000150327     c                   EXSR      $INQ4
099100150327
099200150327     c                   WHEN      CPCID1 = 'DEN' AND SEL = 'C'
099300150327     c                   EXSR      $FMTSCR4
099400150327     c                   EXSR      $CHG4
099500150327
099600150327     c                   WHEN      CPCID1 = 'LIF' AND SEL = 'I'
099700150327     c                   EXSR      $FMTSCR5
099800150327     c                   EXSR      $INQ5
099900150327
100000150327     c                   WHEN      CPCID1 = 'LIF' AND SEL = 'C'
100100150327     c                   EXSR      $FMTSCR5
100200150327     c                   EXSR      $CHG5
100300150327
100400150327     c                   ENDSL
100500150327
100600150327     c                   IF        @EMSG <> *BLANKS
100700150327     c                   LEAVESR
100800150327     c                   ENDIF
100900150327
101000150327     c                   MOVE      *BLANKS       SEL
101100150327     c                   UPDATE    S01SFL
101200150327
101300150327     c                   ENDIF
101400150327     c                   ENDDO
101500150327
101600150327     c                   EVAL      @PROC = 'PREP SFL  '
101700150327
101800150327     c                   ENDSR
101900150327
102000150327      *=============================================================================================
102100150327      * $FMTSCR2 - Inquity mode screen
102200150327      *=============================================================================================
102300150327
102400150327     c     $FMTSCR2      BEGSR
102500150327
102600150327     c                   SETOFF                                       3940
102700150327     c                   CLEAR                   S02HMO
102800150327     c                   EVAL      CONAME = HLD@NAME
102900150327
103000150327     c                   EVAL      S2TRST = ET
103100150327     c                   EVAL      S2SUB# = ES
103200150327     c                   EVAL      S2ACCT = EA
103300150327     c                   EVAL      S2PLAN = CPPLAN
103400150327     c                   EVAL      S2CCTR = CPCCTR
103500160122     c                   EVAL      S2MAP  = AE6MAP
103600150327
103700150327     c                   EXSR      $CHAINS
103800150327
103900150327     c                   EVAL      S2CID2 = %TRIM(CPCID2)
104000150327     c                   EVAL      S2CID3 = %TRIM(CPCID3)
104100150327     c                   EVAL      S2CID4 = %TRIM(CPCID4)
104200150327
104300150327     c                   ENDSR
104400150327
104500150327      *=============================================================================================
104600150327      * $CHAINS - Get Trust/Sub/Account records
104700150327      *=============================================================================================
104800150327
104900150327     c     $CHAINS       BEGSR
105000150327
105100150327     c     KF@TRS        CHAIN     TRSMSR
105200150327     c                   IF        %FOUND(TRMUNIQUE)
105300150327     c                   MOVEL(P)  TDESCR        O_TNAM
105400150327     c                   ENDIF
105500150327
105600150327     c     KL#TS         CHAIN     SUBMSR
105700150327     c                   IF        %FOUND(SUMUNIQUE)
105800150327     c                   MOVEL(P)  SUBDSC        O_SUBN
105900150327     c                   ENDIF
106000150327
106100150327     c     KL#TSA        CHAIN     ACCMSR
106200150327     c                   IF        %FOUND(ACMUNIQUE)
106300150327     c                   MOVE      *BLANKS       @100            100
106400150327     c                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
106500150327     c                             %TRIM(ACNAM2)
106600150327     c                   MOVEL(P)  @100          O_ACCN
106700150327     c                   ENDIF
106800150327
106900150327     c     KL#TSP        CHAIN     PLNMSR
107000150327     c                   IF        %FOUND(PLNUNIQUE)
107100150327     c                   EVAL      D_PLAN = %TRIM(PDESCR)
107200150327     c                   ENDIF
107300150327
107400150327     c                   ENDSR
107500150327
107600150327      *=============================================================================================
107700150327      * $FMTSCR3 - Screen
107800150327      *=============================================================================================
107900150327
108000150327     c     $FMTSCR3      BEGSR
108100150327
108200150327     c                   SETOFF                                       3940
108300150327     c                   CLEAR                   S03MEA
108400150327     c                   EVAL      CONAME = HLD@NAME
108500150327
108600150327     c                   EVAL      S3TRST = ET
108700150327     c                   EVAL      S3SUB# = ES
108800150327     c                   EVAL      S3ACCT = EA
108900150327     c                   EVAL      S3PLAN = CPPLAN
109000150327     c                   EVAL      S3CCTR = CPCCTR
109100160122     c                   EVAL      S3MAP  = AE6MAP
109200150327
109300150327     c                   EXSR      $CHAINS
109400150327
109500150327     c                   EVAL      S3CID2 = %TRIM(CPCID2)
109600150327     c                   EVAL      S3CID3 = %TRIM(CPCID3)
109700150327     c                   EVAL      S3CID4 = %TRIM(CPCID4)
109800150327     c                   EVAL      S3CID5 = %TRIM(CPCID5)
109900150327     c                   EVAL      S3CID6 = %TRIM(CPCID6)
110000150327
110100150327     c                   ENDSR
110200150327
110300150327      *=============================================================================================
110400150327      * $FMTSCR4 - Screen
110500150327      *=============================================================================================
110600150327
110700150327     c     $FMTSCR4      BEGSR
110800150327
110900150327     c                   SETOFF                                       3940
111000150327     c                   CLEAR                   S04DEN
111100150327     c                   EVAL      CONAME = HLD@NAME
111200150327
111300150327     c                   EVAL      S4TRST = ET
111400150327     c                   EVAL      S4SUB# = ES
111500150327     c                   EVAL      S4ACCT = EA
111600150327     c                   EVAL      S4PLAN = CPPLAN
111700150327     c                   EVAL      S4CCTR = CPCCTR
111800160122     c                   EVAL      S4MAP  = AE6MAP
111900150327
112000150327     c                   EXSR      $CHAINS
112100150327
112200150327     c                   EVAL      S4CID2 = %TRIM(CPCID2)
112300150327     c                   EVAL      S4CID3 = %TRIM(CPCID3)
112400150327     c                   EVAL      S4CID4 = %TRIM(CPCID4)
112500150327     c                   EVAL      S4CID5 = %TRIM(CPCID5)
112600150327     c                   EVAL      S4CID6 = %TRIM(CPCID6)
112700150327
112800150327     c                   ENDSR
112900150327
113000150327      *=============================================================================================
113100150327      * $FMTSCR5 - Screen
113200150327      *=============================================================================================
113300150327
113400150327     c     $FMTSCR5      BEGSR
113500150327
113600150327     c                   SETOFF                                       3940
113700150327     c                   CLEAR                   S05LIF
113800150327     c                   EVAL      CONAME = HLD@NAME
113900150327
114000150327     c                   EVAL      S5TRST = ET
114100150327     c                   EVAL      S5SUB# = ES
114200150327     c                   EVAL      S5ACCT = EA
114300150327     c                   EVAL      S5PLAN = CPPLAN
114400150327     c                   EVAL      S5CCTR = CPCCTR
114500160122     c                   EVAL      S5MAP  = AE6MAP
114600150327
114700150327     c                   EXSR      $CHAINS
114800150327
114900150327     c                   EVAL      S5CID2 = %TRIM(CPCID2)
115000150327     c                   EVAL      S5CID3 = %TRIM(CPCID3)
115100150327     c                   EVAL      S5CID4 = %TRIM(CPCID4)
115200150327     c                   EVAL      S5CID5 = %TRIM(CPCID5)
115300150327     c                   EVAL      S5CID6 = %TRIM(CPCID6)
115400150327
115500150327     c                   ENDSR
115600150327
115700150327      *=============================================================================================
115800150327      * $INQ2 - Inquiry screen
115900150327      *=============================================================================================
116000150327
116100150327     c     $INQ2         BEGSR
116200150327
116300150327     c                   EVAL      EMSG = 'INQUIRY ONLY'
116400150327     c                   EVAL      *IN40 = *ON
116500150327     c                   DOU       FKEY = F12
116600150327     c                   EXFMT     S02HMO
116700150327     c                   ENDDO
116800150327
116900150327     c                   ENDSR
117000150327
117100150327      *=============================================================================================
117200150327      * $INQ3 - Inquiry screen
117300150327      *=============================================================================================
117400150327
117500150327     c     $INQ3         BEGSR
117600150327
117700150327     c                   EVAL      EMSG = 'INQUIRY ONLY'
117800150327     c                   EVAL      *IN40 = *ON
117900150327     c                   DOU       FKEY = F12
118000150327     c                   EXFMT     S03MEA
118100150327     c                   ENDDO
118200150327
118300150327     c                   ENDSR
118400150327
118500150327      *=============================================================================================
118600150327      * $INQ4 - Inquiry screen
118700150327      *=============================================================================================
118800150327
118900150327     c     $INQ4         BEGSR
119000150327
119100150327     c                   EVAL      EMSG = 'INQUIRY ONLY'
119200150327     c                   EVAL      *IN40 = *ON
119300150327     c                   DOU       FKEY = F12
119400150327     c                   EXFMT     S04DEN
119500150327     c                   ENDDO
119600150327
119700150327     c                   ENDSR
119800150327
119900150327      *=============================================================================================
120000150327      * $INQ5 - Inquiry screen
120100150327      *=============================================================================================
120200150327
120300150327     c     $INQ5         BEGSR
120400150327
120500150327     c                   EVAL      EMSG = 'INQUIRY ONLY'
120600150327     c                   EVAL      *IN40 = *ON
120700150327     c                   DOU       FKEY = F12
120800150327     c                   EXFMT     S05LIF
120900150327     c                   ENDDO
121000150327
121100150327     c                   ENDSR
121200150327
121300150327      *=============================================================================================
121400150327      * $CHG2 - Change screen
121500150327      *=============================================================================================
121600150327
121700150327     c     $CHG2         BEGSR
121800150327
121900150327     c                   EVAL      @EMSG = 'BE CAREFUL'
122000150327
122100150327     c                   DOU       FKEY = F12
122200150327
122300150327     c                   EXSR      $SCREEN2
122400150327
122500150327     c                   IF        FKEY = F12
122600150327     c                   UNLOCK(E) CARPLNP
122700160122     c                   UNLOCK(E) AET006WF
122800150327     c                   SETOFF                                       3940
122900150327     c                   LEAVESR
123000150327     c                   ENDIF
123100150327
123200150327     c                   EVAL      KF@TRS  = ET
123300150327     c                   EVAL      KF@SUB  = ES
123400150327     c                   EVAL      KF@ACC  = EA
123500150327     c                   EVAL      KF@PLN  = S2PLAN
123600150327     c                   EVAL      KF@CCTR = S2CCTR
123700150327     c                   EVAL      KF@MAP  = S2MAP
123800150327
123900150327     c                   EVAL      ADD_MODE = NO
124000150327     c                   EXSR      $VALIDKEY
124100150327     c                   IF        VALID_REC = NO
124200150327     c                   ITER
124300150327     c                   ENDIF
124400150327
124500150327     c                   EXSR      $VALIDHMO
124600150327     c                   IF        VALID_REC = NO
124700150327     c                   ITER
124800150327     c                   ENDIF
124900150327
125000150327     c                   SETON                                        3940
125100150327     c                   DOU       FKEY = F12 OR FKEY = F10
125200150327     c                   EXSR      $SCREEN2
125300150327
125400150327     c                   IF        FKEY = F12
125500150327     c                   SETOFF                                       3940
125600150327     c                   LEAVESR
125700150327     c                   ENDIF
125800150327
125900150327     c                   IF        FKEY = F10
126000150327     c                   EVAL      CPCID2 = S2CID2
126100150327     c                   EVAL      CPCID3 = S2CID3
126200150327     c                   EVAL      CPCID4 = S2CID4
126300150327     c                   EVAL      CPCCTR = S2CCTR
126400150327     c                   UPDATE    CARPLNR
126500160122     c                   EVAL      AE6MAP = S2MAP
126600160122     c                   UPDATE    AEF06
126700150327     c                   LEAVESR
126800150327     c                   ENDIF
126900150327
127000150327     c                   ENDDO
127100150327
127200150327     c                   ENDDO
127300150327
127400150327     c                   ENDSR
127500150327
127600150327      *=============================================================================================
127700150327      * $CHG3 - Change screen
127800150327      *=============================================================================================
127900150327
128000150327     c     $CHG3         BEGSR
128100150327
128200150327     c                   EVAL      @EMSG = 'BE CAREFUL'
128300150327
128400150327     c                   DOU       FKEY = F12
128500150327
128600150327     c                   EXSR      $SCREEN3
128700150327
128800150327     c                   IF        FKEY = F12
128900150327     c                   UNLOCK(E) CARPLNP
129000160122     c                   UNLOCK(E) AET006WF
129100150327     c                   SETOFF                                       3940
129200150327     c                   LEAVESR
129300150327     c                   ENDIF
129400150327
129500150327     c                   EVAL      KF@TRS  = ET
129600150327     c                   EVAL      KF@SUB  = ES
129700150327     c                   EVAL      KF@ACC  = EA
129800150327     c                   EVAL      KF@PLN  = S3PLAN
129900120813     C                   EVAL      KF@CCTR = S3CCTR
130000150327     c                   EVAL      KF@MAP  = S3MAP
130100150327
130200150327     c                   EVAL      ADD_MODE = NO
130300150327     c                   EXSR      $VALIDKEY
130400150327     c                   IF        VALID_REC = NO
130500150327     c                   ITER
130600150327     c                   ENDIF
130700150327
130800150327     c                   EXSR      $VALIDMEA
130900150327     c                   IF        VALID_REC = NO
131000150327     c                   ITER
131100150327     c                   ENDIF
131200150327
131300150327     c                   SETON                                        3940
131400150327     c                   DOU       FKEY = F12 OR FKEY = F10
131500150327     c                   EXSR      $SCREEN3
131600150327     c                   IF        FKEY = F12
131700150327     c                   SETOFF                                       3940
131800150327     c                   LEAVESR
131900150327     c                   ENDIF
132000150327     c                   IF        FKEY = F10
132100150327     c                   EVAL      CPCID2 = S3CID2
132200150327     c                   EVAL      CPCID3 = S3CID3
132300150327     c                   EVAL      CPCID4 = S3CID4
132400150327     c                   EVAL      CPCID5 = S3CID5
132500150327     c                   EVAL      CPCID6 = S3CID6
132600150327     c                   EVAL      CPCCTR = S3CCTR
132700150327     c                   UPDATE    CARPLNR
132800160122     c                   EVAL      AE6MAP = S3MAP
132900160122     c                   UPDATE    AEF06
133000150327     c                   LEAVESR
133100150327     c                   ENDIF
133200150327
133300150327     c                   ENDDO
133400150327
133500150327     c                   ENDDO
133600150327
133700150327     c                   ENDSR
133800150327
133900150327      *=============================================================================================
134000150327      * $CHG4 - Change screen
134100150327      *=============================================================================================
134200150327
134300150327     c     $CHG4         BEGSR
134400150327
134500150327     c                   EVAL      @EMSG = 'BE CAREFUL'
134600150327
134700150327     c                   DOU       FKEY = F12
134800150327
134900150327     c                   EXSR      $SCREEN4
135000150327
135100150327     c                   IF        FKEY = F12
135200150327     c                   UNLOCK(E) CARPLNP
135300160122     c                   UNLOCK(E) AET006WF
135400150327     c                   SETOFF                                       3940
135500150327     c                   LEAVESR
135600150327     c                   ENDIF
135700150327
135800150327     c                   EVAL      KF@TRS  = ET
135900150327     c                   EVAL      KF@SUB  = ES
136000150327     c                   EVAL      KF@ACC  = EA
136100150327     c                   EVAL      KF@PLN  = S4PLAN
136200150327     c                   EVAL      KF@CCTR = S4CCTR
136300150327     c                   EVAL      KF@MAP  = S4MAP
136400150327
136500150327     c                   EVAL      ADD_MODE = NO
136600150327     c                   EXSR      $VALIDKEY
136700150327     c                   IF        VALID_REC = NO
136800150327     c                   ITER
136900150327     c                   ENDIF
137000150327
137100150327     c                   EXSR      $VALIDDEN
137200150327     c                   IF        VALID_REC = NO
137300150327     c                   ITER
137400150327     c                   ENDIF
137500150327
137600150327     c                   SETON                                        3940
137700150327     c                   DOU       FKEY = F12 OR FKEY = F10
137800150327     c                   EXSR      $SCREEN4
137900150327     c                   IF        FKEY = F12
138000150327     c                   SETOFF                                       3940
138100150327     c                   LEAVESR
138200150327     c                   ENDIF
138300150327     c                   IF        FKEY = F10
138400150327     c                   EVAL      CPCID2 = S4CID2
138500150327     c                   EVAL      CPCID3 = S4CID3
138600150327     c                   EVAL      CPCID4 = S4CID4
138700150327     c                   EVAL      CPCID5 = S4CID5
138800150327     c                   EVAL      CPCID6 = S4CID6
138900150327     c                   EVAL      CPCCTR = S4CCTR
139000150327     c                   UPDATE    CARPLNR
139100160122     c                   EVAL      AE6MAP = S4MAP
139200160122     c                   UPDATE    AEF06
139300150327     c                   LEAVESR
139400150327     c                   ENDIF
139500150327
139600150327     c                   ENDDO
139700150327
139800150327     c                   ENDDO
139900150327
140000150327     c                   ENDSR
140100150327
140200150327      *=============================================================================================
140300150327      * $CHG5 - Change screen
140400150327      *=============================================================================================
140500150327
140600150327     c     $CHG5         BEGSR
140700150327
140800150327     c                   EVAL      @EMSG = 'BE CAREFUL'
140900150327
141000150327     c                   DOU       FKEY = F12
141100150327
141200150327     c                   EXSR      $SCREEN5
141300150327
141400150327     c                   IF        FKEY = F12
141500150327     c                   UNLOCK(E) CARPLNP
141600160122     c                   UNLOCK(E) AET006WF
141700150327     c                   SETOFF                                       3940
141800150327     c                   LEAVESR
141900150327     c                   ENDIF
142000150327
142100150327     c                   EVAL      KF@TRS  = ET
142200150327     c                   EVAL      KF@SUB  = ES
142300150327     c                   EVAL      KF@ACC  = EA
142400150327     c                   EVAL      KF@PLN  = S5PLAN
142500150327     c                   EVAL      KF@CCTR = S5CCTR
142600150327     c                   EVAL      KF@MAP  = S5MAP
142700150327
142800150327     c                   EVAL      ADD_MODE = NO
142900150327     c                   EXSR      $VALIDKEY
143000150327     c                   IF        VALID_REC = NO
143100150327     c                   ITER
143200150327     c                   ENDIF
143300150327
143400150327     c                   EXSR      $VALIDDEN
143500150327     c                   IF        VALID_REC = NO
143600150327     c                   ITER
143700150327     c                   ENDIF
143800150327
143900150327     c                   SETON                                        3940
144000150327     c                   DOU       FKEY = F12 OR FKEY = F10
144100150327     c                   EXSR      $SCREEN5
144200150327     c                   IF        FKEY = F12
144300150327     c                   SETOFF                                       3940
144400150327     c                   LEAVESR
144500150327     c                   ENDIF
144600150327     c                   IF        FKEY = F10
144700150327     c                   EVAL      CPCID2 = S5CID2
144800150327     c                   EVAL      CPCID3 = S5CID3
144900150327     c                   EVAL      CPCID4 = S5CID4
145000150327     c                   EVAL      CPCID5 = S5CID5
145100150327     c                   EVAL      CPCID6 = S5CID6
145200150327     c                   EVAL      CPCCTR = S5CCTR
145300150327     c                   UPDATE    CARPLNR
145400160122     c                   EVAL      AE6MAP = S5MAP
145500160122     c                   UPDATE    AEF06
145600150327     c                   LEAVESR
145700150327     c                   ENDIF
145800150327
145900150327     c                   ENDDO
146000150327
146100150327     c                   ENDDO
146200150327
146300150327     c                   ENDSR
146400150327
146500150327      *=============================================================================================
146600150327      * Exit
146700150327      *=============================================================================================
146800150327
146900150327     c     Exit          begsr
147000150327
147100150327     c                   eval      *inlr = yes
147200150327     c                   return
147300150327
147400150327     c                   endsr
147500150327
147600150327      *=============================================================================================
147700150327      * Initialize subroutine
147800150327      *=============================================================================================
147900150327
148000150327     c     *inzsr        begsr
148100150327
148200150327     c                   EVAL      @PROC = 'PREP SFL  '
148300150327
148400150327     c     KL#TS         KLIST
148500150327     c                   KFLD                    KF@TRS
148600150327     c                   KFLD                    KF@SUB
148700150327
148800150327     c     KL#TSA        KLIST
148900150327     c                   KFLD                    KF@TRS
149000150327     c                   KFLD                    KF@SUB
149100150327     c                   KFLD                    KF@ACC
149200150327
149300150327     c     KL#TSAP       KLIST
149400150327     c                   KFLD                    KF@TRS
149500150327     c                   KFLD                    KF@SUB
149600150327     c                   KFLD                    KF@ACC
149700150327     c                   KFLD                    KF@PLN
149800150327
149900150327     c                   EVAL      HLD@NAME = XONAME
150000150327
150100150327     c     KL#TSP        KLIST
150200150327     c                   KFLD                    KF@TRS
150300150327     c                   KFLD                    KF@SUB
150400150327     c                   KFLD                    KF@PLN
150500150327
150600150327     c     KL#RTSACP     KLIST
150700150327     c                   KFLD                    KF@RET
150800150327     c                   KFLD                    KF@TRS
150900150327     c                   KFLD                    KF@SUB
151000150327     c                   KFLD                    KF@ACC
151100150327     c                   KFLD                    KF@CCTR
151200150327     c                   KFLD                    KF@PLN
151300150327
151400150327     c     KL#UTSACP     KLIST
151500150327     c                   KFLD                    KF@UNIQ
151600150327     c                   KFLD                    KF@TRS
151700150327     c                   KFLD                    KF@SUB
151800150327     c                   KFLD                    KF@ACC
151900150327     c                   KFLD                    KF@CCTR
152000150327     c                   KFLD                    KF@PLN
152100150327
152200150327     c                   endsr
152300150327
152400150327      *=============================================================================================
