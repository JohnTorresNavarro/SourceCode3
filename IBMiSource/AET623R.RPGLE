000100160316      *=============================================================================================
000200160316     H option(*noDebugIo)
000300150327      *=============================================================================================
000400150327      * AET623R - Large Group Accoount Mapping Maintenance
000500150327      *=============================================================================================
000600150327      * Written by:    J. Torres (cloned from AET623R by SSK)
000700150327      * Date Written:  03/27/15
000800150327      * Description:   Small Group Account Mapping
000900150327      *
001000150327      *
001100150327      *  (c)Copyright 2013 by GBS Inc.
001200150327      *  This document contains restricted materials of GBS, Inc.
001300150327
001400150327      *                R E V I S I O N    H I S T O R Y
001500150327      *  Date
001600150327      *  Revised   Initials    Revision
001700150327      *  --------  --------    ---------------------------------------------------------------------
001800200117      *  01/12/20  J.Torres    Fixed Vision update
001900150327      *=============================================================================================
002000150327     FAET623D   CF   E             WORKSTN INFDS(WSDS) SFILE(S01SFL:RR1)
002100150327
002200120808     FCARPLNP   UF A E           K DISK
002300150327
002400120808     FCARPLNX   IF   E           K DISK    RENAME(CARPLNR:CPL2) PREFIX(ZZ:2)
002500150327
002600150410     FCOMCTUNIQ IF   E           K DISK
002700150327
002800120808     FTRMUNIQUE IF   E           K DISK
002900150327
003000120808     FSUMUNIQUE IF   E           K DISK
003100150327
003200120808     FACMUNIQUE IF   E           K DISK
003300150327
003400120808     FPLNUNIQUE IF   E           K DISK
003500150327
003600150513     FAET004WF  UF A E           K DISK
003700150327
003800150327      *=============================================================================================
003900120813     D HLD@NAME        S             40A
004000120813     D @EMSG           S                   LIKE(EMSG)
004100120813     D PRV#TRS         S                   LIKE(I_TRST)
004200120813     D PRV#SUB         S                   LIKE(I_SUB#)
004300120813     D PRV#ACC         S                   LIKE(I_ACCT)
004400120813     D PRV#PLN         S                   LIKE(I_PLAN)
004500120809     D ADD_MODE        S               N   INZ(*OFF)
004600120808     D VALID_REC       S               N   INZ(*OFF)
004700120808     D YES             S               N   INZ(*ON)
004800120808     D NO              S               N   INZ(*OFF)
004900150327
005000000102     D WSDS            DS
005100000102     D  FKEY                 369    369A
005200150327
005300000102     D  F1             C                   CONST(X'31')
005400000102     D  F2             C                   CONST(X'32')
005500000102     D  F3             C                   CONST(X'33')
005600000102     D  F4             C                   CONST(X'34')
005700000102     D  F5             C                   CONST(X'35')
005800000102     D  F6             C                   CONST(X'36')
005900000102     D  F7             C                   CONST(X'37')
006000000102     D  F8             C                   CONST(X'38')
006100000102     D  F9             C                   CONST(X'39')
006200000102     D  F10            C                   CONST(X'3A')
006300000102     D  F11            C                   CONST(X'3B')
006400000102     D  F12            C                   CONST(X'3C')
006500000102     D  F13            C                   CONST(X'B1')
006600000102     D  F14            C                   CONST(X'B2')
006700000102     D  F15            C                   CONST(X'B3')
006800000102     D  F16            C                   CONST(X'B4')
006900000102     D  F17            C                   CONST(X'B5')
007000000102     D  F18            C                   CONST(X'B6')
007100000102     D  F19            C                   CONST(X'B7')
007200000102     D  F20            C                   CONST(X'B8')
007300000102     D  F21            C                   CONST(X'B9')
007400000102     D  F22            C                   CONST(X'BA')
007500000102     D  F23            C                   CONST(X'BB')
007600000102     D  F24            C                   CONST(X'BC')
007700150327
007800000102     D                UDS
007900120813     D  XONAME               201    240
008000150327
008100120906     D KF@RET          S                   LIKE(CPUNIQ)
008200150414     D                                     INZ('9000000127')
008300120808     D KF@UNIQ         S                   LIKE(CPUNIQ)
008400150414     D                                     INZ('0000000127')
008500120808     D KF@TRS          S                   LIKE(CPTRST)
008600120808     D KF@SUB          S                   LIKE(CPSUB#)
008700120808     D KF@ACC          S                   LIKE(CPACCT)
008800120808     D KF@PLN          S                   LIKE(CPPLAN)
008900120808     D KF@CCTR         S                   LIKE(CPCCTR)
009000150513     D KF@MAP          S                   LIKE(AE4MAP)
009100150327
009200120808     D @PROC           S             10A
009300150327
009400120906     D                 DS
009500120906     D @BREAK                 01     11A
009600120906     D  ET                    01     03S 0
009700120906     D  ES                    04     06S 0
009800120906     D  EA                    07     10S 0
009900150327
010000150327      *=============================================================================================
010100150327      * Mainline
010200150327      *=============================================================================================
010300150327
010400150327     c     *ENTRY        PLIST
010500150327     c                   PARM                    @ENTRY           11
010600150327
010700150327     c                   CLEAR                   S02HMO
010800150327     c                   CLEAR                   S03MEA
010900150327     c                   CLEAR                   S04DEN
011000150327     c                   CLEAR                   S05LIF
011100150327     c                   EVAL      @BREAK = @ENTRY
011200150327     c                   EVAL      KF@TRS = ET
011300150327     c                   EVAL      KF@SUB = ES
011400150327     c                   EVAL      KF@ACC = EA
011500150327
011600150327      * Main loop...
011700150327     c                   DOU       @PROC = 'EXIT APP  '
011800150327     c     @PROC         CASEQ     'PREP SFL  '  $PREPSFL
011900150327     c     @PROC         CASEQ     'BUILD SFL '  $BLDSFL
012000150327     c     @PROC         CASEQ     'SFL CONTRL'  $SFLCTL
012100150327     c     @PROC         CASEQ     'ADD HMO   '  $ADDHMO
012200150327     c     @PROC         CASEQ     'ADD MEA   '  $ADDMEA
012300150327     c     @PROC         CASEQ     'ADD DEN   '  $ADDDEN
012400150327     c     @PROC         CASEQ     'ADD LIF   '  $ADDLIF
012500150327     c     @PROC         CASEQ     'CHECK SELC'  $CHKSELC
012600150327     c                   ENDCS
012700000102     C                   ENDDO
012800150327
012900150327     c                   exsr      exit
013000150327
013100150327      *=============================================================================================
013200150327      * $PREPSFL - Get subfile ready
013300150327      *=============================================================================================
013400150327
013500150327     c     $PREPSFL      BEGSR
013600150327
013700150327     c                   MOVE      *ZEROS        RR1               4 0
013800150327     c                   MOVE      *ZEROS        #CNTREC           4 0
013900150327
014000150327     c                   EVAL      *IN39 = *OFF
014100150327     c                   EVAL      *IN40 = *OFF
014200150327
014300150327     c                   EVAL      @PROC = 'BUILD SFL '
014400150327
014500150327     c                   ENDSR
014600150327
014700150327      *=============================================================================================
014800150327      * $CLRSFL - Initialize subfile
014900150327      *=============================================================================================
015000150327
015100150327     c     $CLRSFL       BEGSR
015200150327
015300150327     c                   MOVEA     '011'         *IN(25)
015400150327     c                   WRITE     S01CTL
015500150327     c                   MOVEA     '010'         *IN(25)
015600150327     c                   Z-ADD     *ZERO         RR1
015700150327
015800150327     c                   ENDSR
015900150327
016000150327      *=============================================================================================
016100150327      * $BLDSFL - Build subfile
016200150327      *=============================================================================================
016300150327
016400150327     c     $BLDSFL       BEGSR
016500150327
016600150327     c                   MOVE      *ZEROS        #CNTREC
016700150327     c                   MOVE      '0'           @1STLOOP          1
016800150327     c                   MOVE      '0'           @SFLOOP           1
016900150327     c                   MOVE      '0'           *IN20
017000150327
017100150327     c                   EVAL      I_TRST = ET
017200150327     c                   EVAL      I_SUB# = ES
017300150327     c                   EVAL      I_ACCT = EA
017400150327
017500150327     c                   EVAL      KF@PLN = I_PLAN
017600150327
017700150327     c                   EXSR      $CLRSFL
017800150327     c                   EVAL      CONAME = HLD@NAME
017900150327     c     KL#TSA        CHAIN     ACCMSR
018000150327     c                   IF        NOT %FOUND(ACMUNIQUE)
018100150413     c****               EVAL      D_ACCNAME = '**ERROR**'
018200150413     c                   EVAL      D_ACCNAME = ' '
018300150327     c                   ELSE
018400150327     c                   EVAL      D_ACCNAME = ACNAM1
018500150327     c                   ENDIF
018600150327
018700150327     c     KL#TSAP       SETLL     CPL2
018800150327     c                   DOU       %EOF(CARPLNX)
018900200117     c     KL#TSA        READE(n)  CPL2
019000150327     c                   IF        NOT %EOF(CARPLNX) AND
019100150327     c                             (ZZUNIQ = KF@UNIQ OR
019200150327     c                              ZZUNIQ = KF@RET)
019300150327
019400150327     c                   EXSR      $LOADSFL
019500150327     c                   ENDIF
019600150327     c                   ENDDO
019700150327
019800150327     c                   EVAL      @PROC = 'SFL CONTRL'
019900150327
020000150327     c                   ENDSR
020100150327
020200150327      *=============================================================================================
020300150327      * $LOADSFL - Load subfile
020400150327      *=============================================================================================
020500150327
020600150327     c     $LOADSFL      BEGSR
020700150327
020800150327     c                   MOVE      *ON           *IN25
020900150327     c                   MOVE      *BLANKS       SEL
021000150327
021100150327     c                   EVAL      HUNIQ = ZZUNIQ
021200150327     c                   IF        ZZUNIQ = KF@UNIQ
021300150327     c                   EVAL      SFSTATUS = 'ACTIVE'
021400150327     c                   ELSE
021500150327     c                   EVAL      SFSTATUS = '*RETIRE*'
021600150327     c                   ENDIF
021700150327
021800150327     c                   EVAL      SFCCTR = ZZCCTR
021900150327     c                   EVAL      SFPLAN = ZZPLAN
022000150327
022100150327     c                   EVAL      KF@CCTR = ZZCCTR
022200150327     c                   EVAL      KF@PLN  = ZZPLAN
022300150327
022400160316     c     KL#TSAP       CHAIN(n)  AEF04
022500150513     c                   IF        NOT %FOUND(AET004WF)
022600150413     c****               EVAL      SFMAP = '**ERROR**'
022700150413     c                   EVAL      SFMAP = ' '
022800150327     c                   ELSE
022900150513     c                   EVAL      SFMAP = AE4MAP
023000150327     c                   ENDIF
023100150327
023200150327     c     KL#TSP        CHAIN     PLNMSR
023300150327     c                   IF        NOT %FOUND(PLNUNIQUE)
023400150413     c****               EVAL      SFPNAME = '**ERROR**'
023500150413     c                   EVAL      SFPNAME = ' '
023600150327     c                   ELSE
023700150327     c                   EVAL      SFPNAME= %TRIM(PDESCR)
023800150327     c                   ENDIF
023900150327
024000150327     c                   ADD       1             RR1
024100150327
024200150327     c                   IF        @1STLOOP = '0'
024300150327     c                   Z-ADD     RR1           SFLPOS
024400150327     c                   MOVE      '1'           @1STLOOP
024500150327     c                   ENDIF
024600150327
024700150327     c                   WRITE     S01SFL
024800150327
024900150327     c                   ADD       1             #CNTREC
025000150327     c                   IF        #CNTREC = 500
025100150327     c                   MOVE      '1'           @SFLOOP
025200150327     c                   ENDIF
025300150327
025400150327     c                   ENDSR
025500150327
025600150327      *=============================================================================================
025700150327      * $SFLCTL - Subfile control
025800150327      *=============================================================================================
025900150327
026000150327     c     $SFLCTL       BEGSR
026100150327
026200150327     c                   EVAL      EMSG = @EMSG
026300150327
026400150327     c                   WRITE     S01REC
026500150327     c                   EXFMT     S01CTL
026600150327
026700150327     c                   MOVE      *BLANKS       EMSG
026800150327     c                   MOVE      *BLANKS       @EMSG
026900150327
027000150327     c                   IF        FKEY = F3
027100150327     c                   EVAL      @PROC = 'EXIT APP  '
027200150327     c                   LEAVESR
027300150327     c                   ENDIF
027400150327
027500150327     c                   IF        FKEY = F6
027600150327     c                   SETOFF                                       3940
027700150327     c****               CLEAR                   S02HMO
027800150327
027900150327     c                   EVAL      CONAME = HLD@NAME
028000150327     c                   EVAL      S2TRST = ET
028100150327     c                   EVAL      S2SUB# = ES
028200150327     c                   EVAL      S2ACCT = EA
028300150327     c                   EXSR      $GETTSA
028400150327     c                   EVAL      @PROC = 'ADD HMO   '
028500150327     c                   LEAVESR
028600150327     c                   ENDIF
028700150327
028800150327     c                   IF        FKEY = F7
028900150327     c                   SETOFF                                       3940
029000150327     c****               CLEAR                   S03MEA
029100150327     c                   EVAL      S3TRST = ET
029200150327     c                   EVAL      S3SUB# = ES
029300150327     c                   EVAL      S3ACCT = EA
029400150327     c                   EXSR      $GETTSA
029500150327     c                   EVAL      CONAME = HLD@NAME
029600150327     c                   EVAL      @PROC = 'ADD MEA   '
029700150327     c                   LEAVESR
029800150327     c                   ENDIF
029900150327
030000150327     c                   IF        FKEY = F8
030100150327     c                   SETOFF                                       3940
030200150327     c****               CLEAR                   S04DEN
030300150327     c                   EVAL      CONAME = HLD@NAME
030400150327     c                   EVAL      S4TRST = ET
030500150327     c                   EVAL      S4SUB# = ES
030600150327     c                   EVAL      S4ACCT = EA
030700150327     c                   EXSR      $GETTSA
030800150327     c                   EVAL      @PROC = 'ADD DEN   '
030900150327     c                   LEAVESR
031000150327     c                   ENDIF
031100150327
031200150327     c                   IF        FKEY = F9
031300150327     c                   SETOFF                                       3940
031400150327     c****               CLEAR                   S05LIF
031500150327     c                   EVAL      CONAME = HLD@NAME
031600150327     c                   EVAL      S5TRST = ET
031700150327     c                   EVAL      S5SUB# = ES
031800150327     c                   EVAL      S5ACCT = EA
031900150327     c                   EXSR      $GETTSA
032000150327     c                   EVAL      @PROC = 'ADD LIF   '
032100150327     c                   LEAVESR
032200150327     c                   ENDIF
032300150327
032400150327     c                   EVAL      @PROC = 'CHECK SELC'
032500150327
032600150327     c                   ENDSR
032700150327
032800150327      *=============================================================================================
032900150327      * $ADDHMO - Add HMO
033000150327      *=============================================================================================
033100150327
033200150327     c     $ADDHMO       BEGSR
033300150327
033400150327     c                   EXSR      $SCREEN2
033500150327
033600150327     c                   IF        FKEY = F12
033700150327     c                   CLEAR                   S02HMO
033800150327     c                   EVAL      CONAME = HLD@NAME
033900150327     c                   EVAL      @PROC = 'SFL CONTRL'
034000150327     c                   LEAVESR
034100150327     c                   ENDIF
034200150327
034300150327     c                   EVAL      KF@TRS  = ET
034400150327     c                   EVAL      KF@SUB  = ES
034500150327     c                   EVAL      KF@ACC  = EA
034600150327     c                   EVAL      KF@PLN  = S2PLAN
034700150327     c                   EVAL      KF@CCTR = S2CCTR
034800150327     c                   EVAL      KF@MAP  = S2MAP
034900150327
035000150327     c                   EVAL      ADD_MODE = YES
035100150327
035200150327      * Validate record...
035300150327     c                   EXSR      $VALIDKEY
035400150327
035500150327      * Error?
035600150327     c                   IF        VALID_REC = NO
035700150327     c                   LEAVESR
035800150327     c                   ENDIF
035900150327
036000150327      * Validate record...
036100150327     c                   EXSR      $VALIDHMO
036200150327
036300150327      * Error?
036400150327     c                   IF        VALID_REC = NO
036500150327     c                   LEAVESR
036600150327     c                   ENDIF
036700150327
036800150327     c                   SETON                                        3940
036900150327
037000150327     c                   DOU       FKEY = F12 OR FKEY = F10
037100150327
037200150327     c                   EXSR      $SCREEN2
037300150327
037400150327     c                   IF        FKEY = F12
037500150327     c                   SETOFF                                       3940
037600150327     c                   LEAVESR
037700150327     c                   ENDIF
037800150327
037900150327     c                   IF        FKEY = F10
038000150327     c                   EXSR      $PREPLN
038100150327     c                   EVAL      CPCID1 = 'HMO'
038200150327     c                   EVAL      CPTXT1 = 'LAYOUT CODE'
038300150327     c                   EVAL      CPCID2 = S2CID2
038400150327     c                   EVAL      CPTXT2 = 'FILE NUMBER'
038500150327     c                   EVAL      CPCID3 = S2CID3
038600150327     c                   EVAL      CPTXT3 = 'CLASS CODE'
038700150327     c                   EVAL      CPCID4 = S2CID4
038800150327     c                   EVAL      CPTXT4 = 'PLAN'
038900150327     c                   EVAL      CPCID5 = 'N/A'
039000150327     c                   EVAL      CPTXT5 = 'N/A'
039100150327     c                   EVAL      CPCID6 = 'N/A'
039200150327     c                   EVAL      CPTXT6 = 'N/A'
039300150327     c                   WRITE     CARPLNR
039400150327     c                   LEAVE
039500150327     c                   ENDIF
039600150327
039700150327     c                   ENDDO
039800150327
039900150409     c                   EVAL      @PROC = 'BUILD SFL '
040000150327
040100150327     c                   ENDSR
040200150327
040300150327      *=============================================================================================
040400150327      * $SCREEN2 - Error Screen
040500150327      *=============================================================================================
040600150327
040700150327     c     $SCREEN2      BEGSR
040800150327
040900150327     c                   EVAL      EMSG = @EMSG
041000150327     c                   EXFMT     S02HMO
041100150327     c                   CLEAR                   @EMSG
041200150327     c                   EVAL      EMSG = *BLANKS
041300150327
041400150327     c                   ENDSR
041500150327
041600150327      *=============================================================================================
041700150327      * $SCREEN3 - Error screen
041800150327      *=============================================================================================
041900150327
042000150327     c     $SCREEN3      BEGSR
042100150327
042200150327     c                   EVAL      EMSG = @EMSG
042300150327     c                   EXFMT     S03MEA
042400150327     c                   CLEAR                   @EMSG
042500150327     c                   EVAL      EMSG = *BLANKS
042600150327
042700150327     c                   ENDSR
042800150327
042900150327      *=============================================================================================
043000150327      * $SCREEN4 - Error screen
043100150327      *=============================================================================================
043200150327
043300150327     c     $SCREEN4      BEGSR
043400150327
043500150327     c                   EVAL      EMSG = @EMSG
043600150327     c                   EXFMT     S04DEN
043700150327     c                   CLEAR                   @EMSG
043800150327     c                   EVAL      EMSG = *BLANKS
043900150327
044000150327     c                   ENDSR
044100150327
044200150327      *=============================================================================================
044300150327      * $SCREEN5 - Error screen
044400150327      *=============================================================================================
044500150327
044600150327     c     $SCREEN5      BEGSR
044700150327
044800150327     c                   EVAL      EMSG = @EMSG
044900150327     c                   EXFMT     S05LIF
045000150327     c                   CLEAR                   @EMSG
045100150327     c                   EVAL      EMSG = *BLANKS
045200150327
045300150327     c                   ENDSR
045400150327
045401200117      *=============================================================================================
045402200117      * $SCREEN5 - Error screen
045403200117      *=============================================================================================
045404200117
045405200117     c     $SCREEN7      BEGSR
045406200117
045407200117     c                   EVAL      EMSG = @EMSG
045408200117     c                   EXFMT     S07VIS
045409200117     c                   CLEAR                   @EMSG
045410200117     c                   EVAL      EMSG = *BLANKS
045411200117
045412200117     c                   ENDSR
045413200117
045500150327      *=============================================================================================
045600150327      * $GETTSA - Check Trust/Sub/Account
045700150327      *=============================================================================================
045800150327
045900150327     c     $GETTSA       BEGSR
046000150327
046100150327     c                   EVAL      KF@TRS  = ET
046200150327     c                   EVAL      KF@SUB  = ES
046300150327     c                   EVAL      KF@ACC  = EA
046400150327
046500150327     c     KF@TRS        CHAIN     TRSMSR
046600150327     c                   IF        NOT %FOUND(TRMUNIQUE)
046700150413     c****               EVAL      O_TNAM = '**ERROR**'
046800150413     c                   EVAL      O_TNAM = ' '
046900150327     c                   ELSE
047000150327     c                   MOVEL(P)  TDESCR        O_TNAM
047100150327     c                   ENDIF
047200150327
047300150327     c     KL#TS         CHAIN     SUBMSR
047400150327     c                   IF        NOT %FOUND(SUMUNIQUE)
047500150413     c****               EVAL      O_SUBN = '**ERROR**'
047600150413     c                   EVAL      O_SUBN = ' '
047700150327     c                   ELSE
047800150327     c                   MOVEL(P)  SUBDSC        O_SUBN
047900150327     c                   ENDIF
048000150327
048100150327     c     KL#TSA        CHAIN     ACCMSR
048200150327     c                   IF        NOT %FOUND(ACMUNIQUE)
048300150413     c****               EVAL      O_ACCN = '**ERROR**'
048400150413     c                   EVAL      O_ACCN = ' '
048500150327     c                   ELSE
048600150327     c                   EVAL      O_ACCN = ACNAM1
048700150327     c                   ENDIF
048800150327
048900150327     c                   MOVE      *BLANKS       D_PLAN
049000150327
049100150327     c                   ENDSR
049200150327
049300150327      *=============================================================================================
049400150327      * $VALIDKEY - Validity check
049500150327      *=============================================================================================
049600150327
049700150327     c     $VALIDKEY     BEGSR
049800150327
049900150327     c                   EVAL      VALID_REC = NO
050000150327
050100150327     c     KL#TSP        CHAIN     PLNMSR
050200150327     c                   IF        NOT %FOUND(PLNUNIQUE)
050300150413     c****               EVAL      D_PLAN = '**ERROR**'
050400150413     c                   EVAL      D_PLAN = ' '
050500150327     c                   EVAL      @EMSG = 'INVALID TRUST/SUB/PLAN'
050600150327     c                   LEAVESR
050700150327     c                   ENDIF
050800150327
050900150327     c     KL#TSAP       CHAIN     COMCXR
051000150410     c                   IF        NOT %FOUND(COMCTUNIQ)
051100150327     c                   EVAL      @EMSG = 'COMMISSION CONTROL N/F'
051200150327     c                   LEAVESR
051300150327     c                   ENDIF
051400150327
051500150327     c                   MOVEL(P)  PDESCR        D_PLAN
051600150327
051700150327     c                   IF        KF@MAP = *BLANKS
051800150327     c                   EVAL      @EMSG = 'MISSING MAP'
051900150327     c                   LEAVESR
052000150327     c                   ENDIF
052100150327
052200150327     c                   IF        KF@MAP <> '2TIER     ' AND
052300150327     c                             KF@MAP <> 'TIERSTS   ' AND
052400150327     c                             KF@MAP <> 'STATETIER ' AND
052500150327     c                             KF@MAP <> 'EMPSTS    ' AND
052600150327     c                             KF@MAP <> 'ITOBJECTS ' AND
052700150327     c                             KF@MAP <> 'JUSTSTATE ' AND
052800150327     c                             KF@MAP <> 'STSTATE   ' AND
052900150327     c                             KF@MAP <> 'STIERSTS  ' AND
053000150327     c                             KF@MAP <> 'CREATIVE  ' AND
053100150327     c                             KF@MAP <> 'JOHNLS    ' AND
053200150327     c                             KF@MAP <> 'INTEGRA   ' AND
053300150327     c                             KF@MAP <> 'MAYOR     ' AND
053400150327     c                             KF@MAP <> 'NORULE    '
053500150327     c                   EVAL      @EMSG = 'INVALID MAP; REFER TO MAP DOCUMENT'
053600150327     c                   LEAVESR
053700150327     c                   ENDIF
053800150327
053900150327     c                   IF        KF@MAP <> 'NORULE' AND
054000150327     c                             KF@CCTR = *BLANKS
054100150327     c                   EVAL      @EMSG = 'MISSING MAPPING VALUE'
054200150327     c                   LEAVESR
054300150327     c                   ENDIF
054400150327
054500150327     c                   IF        ADD_MODE = YES
054600150327     c     KL#UTSACP     CHAIN     CARPLNR
054700150327     c                   IF        %FOUND(CARPLNP)
054800150327     c                   EVAL      @EMSG = 'T/S/A/P/MAP VALUE ALREADY EXISTS'
054900150327     c                   LEAVESR
055000150327     c                   ENDIF
055100150327     c                   ENDIF
055200150327
055300150327     c                   EVAL      VALID_REC = YES
055400150327
055500150327     c                   ENDSR
055600150327
055700150327      *=============================================================================================
055800150327      * $VALIDHMO - Validity check
055900150327      *=============================================================================================
056000150327
056100150327     c     $VALIDHMO     BEGSR
056200150327
056300150327     c                   EVAL      VALID_REC = NO
056400150327
056500150327     c                   IF        S2CID2 = *BLANKS
056600150327     c                   EVAL      @EMSG = 'FILE NUMBER IS REQUIRED'
056700150327     c                   LEAVESR
056800150327     c                   ENDIF
056900150327
057000150327     c                   IF        S2CID3 = *BLANKS
057100150327     c                   EVAL      @EMSG = 'CLASS CODE IS REQUIRED'
057200150327     c                   LEAVESR
057300150327     c                   ENDIF
057400150327
057500150327     c                   IF        S2CID4 = *BLANKS
057600150327     c                   EVAL      @EMSG = 'PLAN NUMBER IS REQUIRED'
057700150327     c                   LEAVESR
057800150327     c                   ENDIF
057900150327
058000150327     c                   EVAL      VALID_REC = YES
058100150327
058200150327     c                   ENDSR
058300150327
058400150327      *=============================================================================================
058500150327      * $PREPLN - Clear file before writing
058600150327      *=============================================================================================
058700150327
058800150327     c     $PREPLN       BEGSR
058900150327
059000150513     c     KL#TSAP       CHAIN     AET004WF
059100150513     c                   IF        NOT %FOUND(AET004WF)
059200150513     c                   CLEAR                   AEF04
059300150513     c                   EVAL      AE4TRS = ET
059400150513     c                   EVAL      AE4SUB = ES
059500150513     c                   EVAL      AE4ACC = EA
059600150513     c                   EVAL      AE4PLN = KF@PLN
059700150513     c                   EVAL      AE4MAP = KF@MAP
059800150513     c                   WRITE(E)  AEF04
059900150327     c                   ENDIF
060000150327
060100150327     c                   CLEAR                   CARPLNR
060200150327     c                   EVAL      CPUNIQ = KF@UNIQ
060300150327     c                   EVAL      CPTRST = ET
060400150327     c                   EVAL      CPSUB# = ES
060500150327     c                   EVAL      CPACCT = EA
060600150327     c                   EVAL      CPCCTR = KF@CCTR
060700150327     c                   EVAL      CPPLAN = KF@PLN
060800150327
060900150327     c                   ENDSR
061000150327
061100150327      *=============================================================================================
061200150327      * $ADDMEA - Add record
061300150327      *=============================================================================================
061400150327
061500150327     c     $ADDMEA       BEGSR
061600150327
061700150327     c                   EXSR      $SCREEN3
061800150327
061900150327     c                   IF        FKEY = F12
062000150327     c                   CLEAR                   S03MEA
062100150327     c                   EVAL      CONAME = HLD@NAME
062200150327     c                   EVAL      @PROC = 'SFL CONTRL'
062300150327     c                   LEAVESR
062400150327     c                   ENDIF
062500150327
062600150327     c                   EVAL      KF@TRS  = ET
062700150327     c                   EVAL      KF@SUB  = ES
062800150327     c                   EVAL      KF@ACC  = EA
062900150327     c                   EVAL      KF@PLN  = S3PLAN
063000150327     c                   EVAL      KF@CCTR = S3CCTR
063100150327     c                   EVAL      KF@MAP  = S3MAP
063200150327
063300150327     c                   EVAL      ADD_MODE = YES
063400150327     c                   EXSR      $VALIDKEY
063500150327
063600150327     c                   IF        VALID_REC = NO
063700150327     c                   LEAVESR
063800150327     c                   ENDIF
063900150327
064000150327     c                   EXSR      $VALIDMEA
064100150327
064200150327     c                   IF        VALID_REC = NO
064300150327     c                   LEAVESR
064400150327     c                   ENDIF
064500150327
064600150327     c                   SETON                                        3940
064700150327
064800150327     c                   DOU       FKEY = F12 OR FKEY = F10
064900150327
065000150327     c                   EXSR      $SCREEN3
065100150327
065200150327     c                   IF        FKEY = F12
065300150327     c                   SETOFF                                       3940
065400150327     c                   LEAVESR
065500150327     c                   ENDIF
065600150327
065700150327     c                   IF        FKEY = F10
065800150327     c                   EXSR      $PREPLN
065900150327     c                   EVAL      CPCID1 = 'MEA'
066000150327     c                   EVAL      CPTXT1 = 'LAYOUT CODE'
066100150327     c                   EVAL      CPCID2 = S3CID2
066200150327     c                   EVAL      CPTXT2 = 'ELR'
066300150327     c                   EVAL      CPCID3 = S3CID3
066400150327     c                   EVAL      CPTXT3 = 'SUFFIX'
066500150327     c                   EVAL      CPCID4 = S3CID4
066600150327     c                   EVAL      CPTXT4 = 'ACCOUNT'
066700150327     c                   EVAL      CPCID5 = S3CID5
066800150327     c                   EVAL      CPTXT5 = 'PLAN'
066900150327     c                   EVAL      CPCID6 = S3CID6
067000150327     c                   EVAL      CPTXT6 = 'CLAIM OFFICE'
067100150327     c                   WRITE     CARPLNR
067200150327     c                   LEAVE
067300150327     c                   ENDIF
067400150327
067500150327     c                   ENDDO
067600150327
067700150409     c                   EVAL      @PROC = 'BUILD SFL '
067800150327
067900150327     c                   ENDSR
068000150327
068100150327      *=============================================================================================
068200150327      * $VALIDMEA - Validity check
068300150327      *=============================================================================================
068400150327
068500150327     c     $VALIDMEA     BEGSR
068600150327
068700150327     c                   EVAL      VALID_REC = NO
068800150327
068900150327     c                   IF        S3CID2 = *BLANKS
069000150327     c                   EVAL      @EMSG = 'ELR IS REQUIRED'
069100150327     c                   LEAVESR
069200150327     c                   ENDIF
069300150327
069400150327     c                   IF        S3CID3 = *BLANKS
069500150327     c                   EVAL      @EMSG = 'SUFFIX IS REQUIRED'
069600150327     c                   LEAVESR
069700150327     c                   ENDIF
069800150327
069900150327     c                   IF        S3CID4 = *BLANKS
070000150327     c                   EVAL      @EMSG = 'ACCOUNT IS REQUIRED'
070100150327     c                   LEAVESR
070200150327     c                   ENDIF
070300150327
070400150327     c                   IF        S3CID5 = *BLANKS
070500150327     c                   EVAL      @EMSG = 'PLAN IS REQUIRED'
070600150327     c                   LEAVESR
070700150327     c                   ENDIF
070800150327
070900150327     c                   IF        S3CID6 = *BLANKS
071000150327     c                   EVAL      @EMSG = 'CLAIM OFFICE IS REQUIRED'
071100150327     c                   LEAVESR
071200150327     c                   ENDIF
071300150327
071400150327     c                   EVAL      VALID_REC = YES
071500150327
071600150327     c                   ENDSR
071700150327
071800150327      *=============================================================================================
071900150327      * $ADDDEN - Add dental
072000150327      *=============================================================================================
072100150327
072200150327     c     $ADDDEN       BEGSR
072300150327
072400150327     c                   EXSR      $SCREEN4
072500150327
072600150327     c                   IF        FKEY = F12
072700150327     c                   CLEAR                   S04DEN
072800150327     c                   EVAL      CONAME = HLD@NAME
072900150327     c                   EVAL      @PROC = 'SFL CONTRL'
073000150327     c                   LEAVESR
073100150327     c                   ENDIF
073200150327
073300150327     c                   EVAL      KF@TRS  = ET
073400150327     c                   EVAL      KF@SUB  = ES
073500150327     c                   EVAL      KF@ACC  = EA
073600150327     c                   EVAL      KF@PLN  = S4PLAN
073700150327     c                   EVAL      KF@CCTR = S4CCTR
073800150327     c                   EVAL      KF@MAP  = S4MAP
073900150327
074000150327     c                   EVAL      ADD_MODE = YES
074100150327     c                   EXSR      $VALIDKEY
074200150327
074300150327     c                   IF        VALID_REC = NO
074400150327     c                   LEAVESR
074500150327     c                   ENDIF
074600150327
074700150327     c                   EXSR      $VALIDDEN
074800150327
074900150327     c                   IF        VALID_REC = NO
075000150327     c                   LEAVESR
075100150327     c                   ENDIF
075200150327
075300150327     c                   SETON                                        3940
075400150327
075500150327     c                   DOU       FKEY = F12 OR FKEY = F10
075600150327
075700150327     c                   EXSR      $SCREEN4
075800150327
075900150327     c                   IF        FKEY = F12
076000150327     c                   SETOFF                                       3940
076100150327     c                   LEAVESR
076200150327     c                   ENDIF
076300120808      *
076400150327     c                   IF        FKEY = F10
076500150327     c                   EXSR      $PREPLN
076600150327     c                   EVAL      CPCID1 = 'DEN'
076700150327     c                   EVAL      CPTXT1 = 'LAYOUT CODE'
076800150327     c                   EVAL      CPCID2 = S4CID2
076900150327     c                   EVAL      CPTXT2 = 'ELR'
077000150327     c                   EVAL      CPCID3 = S4CID3
077100150327     c                   EVAL      CPTXT3 = 'SUFFIX'
077200150327     c                   EVAL      CPCID4 = S4CID4
077300150327     c                   EVAL      CPTXT4 = 'ACCOUNT'
077400150327     c                   EVAL      CPCID5 = S4CID5
077500150327     c                   EVAL      CPTXT5 = 'PLAN'
077600150327     c                   EVAL      CPCID6 = S4CID6
077700150327     c                   EVAL      CPTXT6 = 'CLAIM OFFICE'
077800150327     c                   WRITE     CARPLNR
077900150327     c                   LEAVE
078000150327     c                   ENDIF
078100150327
078200150327     c                   ENDDO
078300150327
078400150409     c                   EVAL      @PROC = 'BUILD SFL '
078500150327
078600150327     c                   ENDSR
078700150327
078800150327      *=============================================================================================
078900150327      * $VALIDDEN - Validity check
079000150327      *=============================================================================================
079100150327
079200150327     c     $VALIDDEN     BEGSR
079300150327
079400150327     c                   EVAL      VALID_REC = NO
079500150327
079600150327     c                   IF        S4CID2 = *BLANKS
079700150327     c                   EVAL      @EMSG = 'ELR IS REQUIRED'
079800150327     c                   LEAVESR
079900150327     c                   ENDIF
080000150327
080100150327     c                   IF        S4CID3 = *BLANKS
080200150327     c                   EVAL      @EMSG = 'SUFFIX IS REQUIRED'
080300150327     c                   LEAVESR
080400150327     c                   ENDIF
080500150327
080600150327     c                   IF        S4CID4 = *BLANKS
080700150327     c                   EVAL      @EMSG = 'ACCOUNT IS REQUIRED'
080800150327     c                   LEAVESR
080900150327     c                   ENDIF
081000150327
081100150327     c                   IF        S4CID5 = *BLANKS
081200150327     c                   EVAL      @EMSG = 'PLAN IS REQUIRED'
081300150327     c                   LEAVESR
081400150327     c                   ENDIF
081500150327
081600150327     c                   IF        S4CID6 = *BLANKS
081700150327     c                   EVAL      @EMSG = 'CLAIM OFFICE IS REQUIRED'
081800150327     c                   LEAVESR
081900150327     c                   ENDIF
082000150327
082100150327     c                   EVAL      VALID_REC = YES
082200150327
082300150327     c                   ENDSR
082400150327
082401200117      *=============================================================================================
082402200117      * $VALIDDEN - Validity check
082403200117      *=============================================================================================
082404200117
082405200117     c     $VALIDVIS     BEGSR
082406200117
082407200117     c                   EVAL      VALID_REC = NO
082408200117
082409200117     c                   IF        S7CID2 = *BLANKS
082410200117     c                   EVAL      @EMSG = 'ELR IS REQUIRED'
082411200117     c                   LEAVESR
082412200117     c                   ENDIF
082413200117
082414200117     c                   IF        S7CID3 = *BLANKS
082415200117     c                   EVAL      @EMSG = 'SUFFIX IS REQUIRED'
082416200117     c                   LEAVESR
082417200117     c                   ENDIF
082418200117
082419200117     c                   IF        S7CID4 = *BLANKS
082420200117     c                   EVAL      @EMSG = 'ACCOUNT IS REQUIRED'
082421200117     c                   LEAVESR
082422200117     c                   ENDIF
082423200117
082424200117     c                   IF        S7CID5 = *BLANKS
082425200117     c                   EVAL      @EMSG = 'PLAN IS REQUIRED'
082426200117     c                   LEAVESR
082427200117     c                   ENDIF
082428200117
082429200117     c                   IF        S7CID6 = *BLANKS
082430200117     c                   EVAL      @EMSG = 'CLAIM OFFICE IS REQUIRED'
082431200117     c                   LEAVESR
082432200117     c                   ENDIF
082433200117
082434200117     c                   EVAL      VALID_REC = YES
082435200117
082436200117     c                   ENDSR
082437200117
082500150327      *=============================================================================================
082600150327      * $ADDDEN - Add life
082700150327      *=============================================================================================
082800150327
082900150327     c     $ADDLIF       BEGSR
083000150327
083100150327     c                   EXSR      $SCREEN5
083200150327
083300150327     c                   IF        FKEY = F12
083400150327     c                   CLEAR                   S05LIF
083500150327     c                   EVAL      CONAME = HLD@NAME
083600150327     c                   EVAL      @PROC = 'SFL CONTRL'
083700150327     c                   LEAVESR
083800150327     c                   ENDIF
083900150327
084000150327     c                   EVAL      KF@TRS  = ET
084100150327     c                   EVAL      KF@SUB  = ES
084200150327     c                   EVAL      KF@ACC  = EA
084300150327     c                   EVAL      KF@PLN  = S5PLAN
084400150327     c                   EVAL      KF@CCTR = S5CCTR
084500150327     c                   EVAL      KF@MAP  = S5MAP
084600150327
084700150327     c                   EVAL      ADD_MODE = YES
084800150327     c                   EXSR      $VALIDKEY
084900150327
085000150327     c                   IF        VALID_REC = NO
085100150327     c                   LEAVESR
085200150327     c                   ENDIF
085300150327
085400150327     c                   EXSR      $VALIDLIF
085500150327
085600150327     c                   IF        VALID_REC = NO
085700150327     c                   LEAVESR
085800150327     c                   ENDIF
085900150327
086000150327     c                   SETON                                        3940
086100150327
086200150327     c                   DOU       FKEY = F12 OR FKEY = F10
086300150327
086400150327     c                   EXSR      $SCREEN5
086500150327
086600150327     c                   IF        FKEY = F12
086700150327     c                   SETOFF                                       3940
086800150327     c                   LEAVESR
086900150327     c                   ENDIF
087000150327
087100150327     c                   IF        FKEY = F10
087200150327     c                   EXSR      $PREPLN
087300150327     c                   EVAL      CPCID1 = 'LIF'
087400150327     c                   EVAL      CPTXT1 = 'LAYOUT CODE'
087500150327     c                   EVAL      CPCID2 = S5CID2
087600150327     c                   EVAL      CPTXT2 = 'ELR'
087700150327     c                   EVAL      CPCID3 = S5CID3
087800150327     c                   EVAL      CPTXT3 = 'SUFFIX'
087900150327     c                   EVAL      CPCID4 = S5CID4
088000150327     c                   EVAL      CPTXT4 = 'ACCOUNT'
088100150327     c                   EVAL      CPCID5 = S5CID5
088200150327     c                   EVAL      CPTXT5 = 'PLAN'
088300150327     c                   EVAL      CPCID6 = S5CID6
088400150327     c                   EVAL      CPTXT6 = 'CLAIM OFFICE'
088500150327     c                   WRITE     CARPLNR
088600150327     c                   LEAVE
088700150327     c                   ENDIF
088800150327
088900150327     c                   ENDDO
089000150327
089100150409     c                   EVAL      @PROC = 'BUILD SFL '
089200150327
089300150327     c                   ENDSR
089400150327
089500150327      *=============================================================================================
089600150327      * $VALIDDEN - Validity check
089700150327      *=============================================================================================
089800150327
089900150327     c     $VALIDLIF     BEGSR
090000150327
090100150327     c                   EVAL      VALID_REC = NO
090200150327
090300150327     c                   IF        S5CID2 = *BLANKS
090400150327     c                   EVAL      @EMSG = 'ELR IS REQUIRED'
090500150327     c                   LEAVESR
090600150327     c                   ENDIF
090700150327
090800150327     c                   IF        S5CID3 = *BLANKS
090900150327     c                   EVAL      @EMSG = 'SUFFIX IS REQUIRED'
091000150327     c                   LEAVESR
091100150327     c                   ENDIF
091200150327
091300150327     c                   IF        S5CID4 = *BLANKS
091400150327     c                   EVAL      @EMSG = 'ACCOUNT IS REQUIRED'
091500150327     c                   LEAVESR
091600150327     c                   ENDIF
091700150327
091800150327     c                   IF        S5CID5 = *BLANKS
091900150327     c                   EVAL      @EMSG = 'PLAN IS REQUIRED'
092000150327     c                   LEAVESR
092100150327     c                   ENDIF
092200150327
092300150327     c                   IF        S5CID6 = *BLANKS
092400150327     c                   EVAL      @EMSG = 'CLAIM OFFICE IS REQUIRED'
092500150327     c                   LEAVESR
092600150327     c                   ENDIF
092700150327
092800150327     c                   EVAL      VALID_REC = YES
092900150327
093000150327     c                   ENDSR
093100150327
093200150327      *=============================================================================================
093300150327      * $CHKSELC - Check subfile record(s) selected
093400150327      *=============================================================================================
093500150327
093600150327     c     $CHKSELC      BEGSR
093700150327
093800150327     c                   IF        I_PLAN <> PRV#PLN
093900150327     c                   EVAL      PRV#PLN = I_PLAN
094000150327     c                   EVAL      @PROC = 'PREP SFL  '
094100150327     c                   LEAVESR
094200150327     c                   ENDIF
094300150327
094400150327     c                   DOU       %EOF(AET623D)
094500150327     c                   READC     S01SFL
094600150327     c                   IF        NOT %EOF(AET623D)
094700150327
094800150327     c                   EVAL      KF@TRS  = ET
094900150327     c                   EVAL      KF@SUB  = ES
095000150327     c                   EVAL      KF@ACC  = EA
095100150327     c                   EVAL      KF@PLN  = SFPLAN
095200150327     c                   EVAL      KF@CCTR = SFCCTR
095300150327     c                   EVAL      KF@MAP  = SFMAP
095400150327
095500150327     c                   IF        SEL = 'U'
095600150327     c     KL#RTSACP     CHAIN     CARPLNR
095700150327     c                   ELSE
095701200117       if sel = 'C';
095800150327     c     KL#UTSACP     CHAIN     CARPLNR
095801200117     c     KL#TSAP       CHAIN     AET004WF
095900200117       endif;
095901200117
095902200117       if sel = 'I';
095903200117     c     KL#UTSACP     CHAIN(N)  CARPLNR
095904200117     c     KL#TSAP       CHAIN(N)  AET004WF
095905200117       endif;
095906200117     c                   ENDIF
096100150327
096200150327     c                   SELECT
096300150327
096400150327     c                   WHEN      SEL = 'R'
096500150327     c                   EVAL      CPUNIQ = KF@RET
096600150327     c                   UPDATE    CARPLNR
096700150513     c                   UNLOCK(E) AET004WF
096800150327
096900150327     c                   WHEN      SEL = 'U'
097000150327     c                   EVAL      CPUNIQ = KF@UNIQ
097100150327     c                   UPDATE    CARPLNR
097200150513     c                   UNLOCK(E) AET004WF
097300150327
097400150327     c                   WHEN      CPCID1 = 'HMO' AND SEL = 'I'
097500150327     c                   EXSR      $FMTSCR2
097600150327     c                   EXSR      $INQ2
097700150327
097800150327     c                   WHEN      CPCID1 = 'HMO' AND SEL = 'C'
097900150327     c                   EXSR      $FMTSCR2
098000150327     c                   EXSR      $CHG2
098100150327
098200150327     c                   WHEN      CPCID1 = 'MEA' AND SEL = 'I'
098300150327     c                   EXSR      $FMTSCR3
098400150327     c                   EXSR      $INQ3
098500150327
098600150327     c                   WHEN      CPCID1 = 'MEA' AND SEL = 'C'
098700150327     c                   EXSR      $FMTSCR3
098800150327     c                   EXSR      $CHG3
098900150327
099000150327     c                   WHEN      CPCID1 = 'DEN' AND SEL = 'I'
099100150327     c                   EXSR      $FMTSCR4
099200150327     c                   EXSR      $INQ4
099300150327
099400150327     c                   WHEN      CPCID1 = 'DEN' AND SEL = 'C'
099500150327     c                   EXSR      $FMTSCR4
099600150327     c                   EXSR      $CHG4
099700150327
099800150327     c                   WHEN      CPCID1 = 'LIF' AND SEL = 'I'
099900150327     c                   EXSR      $FMTSCR5
100000150327     c                   EXSR      $INQ5
100100150327
100200150327     c                   WHEN      CPCID1 = 'LIF' AND SEL = 'C'
100300150327     c                   EXSR      $FMTSCR5
100400150327     c                   EXSR      $CHG5
100500150327
100501200117     C                   WHEN      CPCID1 = 'VIS' AND SEL = 'I'
100502200117     C                   EXSR      $FMTSCR7
100503200117     C                   EXSR      $INQ7
100504200117      *
100505200117     C                   WHEN      CPCID1 = 'VIS' AND SEL = 'C'
100506200117     C                   EXSR      $FMTSCR7
100507200117     C                   EXSR      $CHG7
100600150327     c                   ENDSL
100700150327
100800150327     c                   IF        @EMSG <> *BLANKS
100900150327     c                   LEAVESR
101000150327     c                   ENDIF
101100150327
101200150327     c                   MOVE      *BLANKS       SEL
101300150327     c                   UPDATE    S01SFL
101400150327
101500150327     c                   ENDIF
101600150327     c                   ENDDO
101700150327
101800150327     c                   EVAL      @PROC = 'PREP SFL  '
101900150327
102000150327     c                   ENDSR
102100150327
102200150327      *=============================================================================================
102300150327      * $FMTSCR2 - Inquity mode screen
102400150327      *=============================================================================================
102500150327
102600150327     c     $FMTSCR2      BEGSR
102700150327
102800150327     c                   SETOFF                                       3940
102900150327     c                   CLEAR                   S02HMO
103000150327     c                   EVAL      CONAME = HLD@NAME
103100150327
103200150327     c                   EVAL      S2TRST = ET
103300150327     c                   EVAL      S2SUB# = ES
103400150327     c                   EVAL      S2ACCT = EA
103500150327     c                   EVAL      S2PLAN = CPPLAN
103600150327     c                   EVAL      S2CCTR = CPCCTR
103700150513     c                   EVAL      S2MAP  = AE4MAP
103800150327
103900150327     c                   EXSR      $CHAINS
104000150327
104100150327     c                   EVAL      S2CID2 = %TRIM(CPCID2)
104200150327     c                   EVAL      S2CID3 = %TRIM(CPCID3)
104300150327     c                   EVAL      S2CID4 = %TRIM(CPCID4)
104400150327
104500150327     c                   ENDSR
104600150327
104700150327      *=============================================================================================
104800150327      * $CHAINS - Get Trust/Sub/Account records
104900150327      *=============================================================================================
105000150327
105100150327     c     $CHAINS       BEGSR
105200150327
105300150327     c     KF@TRS        CHAIN     TRSMSR
105400150327     c                   IF        %FOUND(TRMUNIQUE)
105500150327     c                   MOVEL(P)  TDESCR        O_TNAM
105600150327     c                   ENDIF
105700150327
105800150327     c     KL#TS         CHAIN     SUBMSR
105900150327     c                   IF        %FOUND(SUMUNIQUE)
106000150327     c                   MOVEL(P)  SUBDSC        O_SUBN
106100150327     c                   ENDIF
106200150327
106300150327     c     KL#TSA        CHAIN     ACCMSR
106400150327     c                   IF        %FOUND(ACMUNIQUE)
106500150327     c                   MOVE      *BLANKS       @100            100
106600150327     c                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
106700150327     c                             %TRIM(ACNAM2)
106800150327     c                   MOVEL(P)  @100          O_ACCN
106900150327     c                   ENDIF
107000150327
107100150327     c     KL#TSP        CHAIN     PLNMSR
107200150327     c                   IF        %FOUND(PLNUNIQUE)
107300150327     c                   EVAL      D_PLAN = %TRIM(PDESCR)
107400150327     c                   ENDIF
107500150327
107600150327     c                   ENDSR
107700150327
107800150327      *=============================================================================================
107900150327      * $FMTSCR3 - Screen
108000150327      *=============================================================================================
108100150327
108200150327     c     $FMTSCR3      BEGSR
108300150327
108400150327     c                   SETOFF                                       3940
108500150327     c                   CLEAR                   S03MEA
108600150327     c                   EVAL      CONAME = HLD@NAME
108700150327
108800150327     c                   EVAL      S3TRST = ET
108900150327     c                   EVAL      S3SUB# = ES
109000150327     c                   EVAL      S3ACCT = EA
109100150327     c                   EVAL      S3PLAN = CPPLAN
109200150327     c                   EVAL      S3CCTR = CPCCTR
109300150513     c                   EVAL      S3MAP  = AE4MAP
109400150327
109500150327     c                   EXSR      $CHAINS
109600150327
109700150327     c                   EVAL      S3CID2 = %TRIM(CPCID2)
109800150327     c                   EVAL      S3CID3 = %TRIM(CPCID3)
109900150327     c                   EVAL      S3CID4 = %TRIM(CPCID4)
110000150327     c                   EVAL      S3CID5 = %TRIM(CPCID5)
110100150327     c                   EVAL      S3CID6 = %TRIM(CPCID6)
110200150327
110300150327     c                   ENDSR
110400150327
110500150327      *=============================================================================================
110600150327      * $FMTSCR4 - Screen
110700150327      *=============================================================================================
110800150327
110900150327     c     $FMTSCR4      BEGSR
111000150327
111100150327     c                   SETOFF                                       3940
111200150327     c                   CLEAR                   S04DEN
111300150327     c                   EVAL      CONAME = HLD@NAME
111400150327
111500150327     c                   EVAL      S4TRST = ET
111600150327     c                   EVAL      S4SUB# = ES
111700150327     c                   EVAL      S4ACCT = EA
111800150327     c                   EVAL      S4PLAN = CPPLAN
111900150327     c                   EVAL      S4CCTR = CPCCTR
112000150513     c                   EVAL      S4MAP  = AE4MAP
112100150327
112200150327     c                   EXSR      $CHAINS
112300150327
112400150327     c                   EVAL      S4CID2 = %TRIM(CPCID2)
112500150327     c                   EVAL      S4CID3 = %TRIM(CPCID3)
112600150327     c                   EVAL      S4CID4 = %TRIM(CPCID4)
112700150327     c                   EVAL      S4CID5 = %TRIM(CPCID5)
112800150327     c                   EVAL      S4CID6 = %TRIM(CPCID6)
112900150327
113000150327     c                   ENDSR
113100150327
113200150327      *=============================================================================================
113300150327      * $FMTSCR5 - Screen
113400150327      *=============================================================================================
113500150327
113600150327     c     $FMTSCR5      BEGSR
113700150327
113800150327     c                   SETOFF                                       3940
113900150327     c                   CLEAR                   S05LIF
114000150327     c                   EVAL      CONAME = HLD@NAME
114100150327
114200150327     c                   EVAL      S5TRST = ET
114300150327     c                   EVAL      S5SUB# = ES
114400150327     c                   EVAL      S5ACCT = EA
114500150327     c                   EVAL      S5PLAN = CPPLAN
114600150327     c                   EVAL      S5CCTR = CPCCTR
114700150513     c                   EVAL      S5MAP  = AE4MAP
114800150327
114900150327     c                   EXSR      $CHAINS
115000150327
115100150327     c                   EVAL      S5CID2 = %TRIM(CPCID2)
115200150327     c                   EVAL      S5CID3 = %TRIM(CPCID3)
115300150327     c                   EVAL      S5CID4 = %TRIM(CPCID4)
115400150327     c                   EVAL      S5CID5 = %TRIM(CPCID5)
115500150327     c                   EVAL      S5CID6 = %TRIM(CPCID6)
115600150327
115700150327     c                   ENDSR
115701200117
115800200117      *================================================
115801200117      * $FMTSCR7 - Screen
115802200117      *================================================
115803200117     C     $FMTSCR7      BEGSR
115804200117     **
115805200117     c                   SETOFF                                       3940
115807200117     C                   CLEAR                   S07VIS
115808200117     C                   EVAL      CONAME = HLD@NAME
115809200117     **
115810200117     C                   EVAL      S7TRST = ET
115811200117     C                   EVAL      S7SUB# = ES
115812200117     C                   EVAL      S7ACCT = EA
115813200117     C                   EVAL      S7PLAN = CPPLAN
115814200117     C                   EVAL      S7CCTR = CPCCTR
115815200117     C                   EVAL      S7MAP  = AE4MAP
115816200117     **
115817200117     C                   EXSR      $CHAINS
115818200117     **
115819200117     C                   EVAL      S7CID2 = %TRIM(CPCID2)
115820200117     C                   EVAL      S7CID3 = %TRIM(CPCID3)
115821200117     C                   EVAL      S7CID4 = %TRIM(CPCID4)
115822200117     C                   EVAL      S7CID5 = %TRIM(CPCID5)
115823200117     C                   EVAL      S7CID6 = %TRIM(CPCID6)
115824200117      ***
115825200117     C                   ENDSR
115900150327      *=============================================================================================
116000150327      * $INQ2 - Inquiry screen
116100150327      *=============================================================================================
116200150327
116300150327     c     $INQ2         BEGSR
116400150327
116500150327     c                   EVAL      EMSG = 'INQUIRY ONLY'
116600150327     c                   EVAL      *IN40 = *ON
116700150327     c                   DOU       FKEY = F12
116800150327     c                   EXFMT     S02HMO
116900150327     c                   ENDDO
117000150327
117100150327     c                   ENDSR
117200150327
117300150327      *=============================================================================================
117400150327      * $INQ3 - Inquiry screen
117500150327      *=============================================================================================
117600150327
117700150327     c     $INQ3         BEGSR
117800150327
117900150327     c                   EVAL      EMSG = 'INQUIRY ONLY'
118000150327     c                   EVAL      *IN40 = *ON
118100150327     c                   DOU       FKEY = F12
118200150327     c                   EXFMT     S03MEA
118300150327     c                   ENDDO
118400150327
118500150327     c                   ENDSR
118600150327
118700150327      *=============================================================================================
118800150327      * $INQ4 - Inquiry screen
118900150327      *=============================================================================================
119000150327
119100150327     c     $INQ4         BEGSR
119200150327
119300150327     c                   EVAL      EMSG = 'INQUIRY ONLY'
119400150327     c                   EVAL      *IN40 = *ON
119500150327     c                   DOU       FKEY = F12
119600150327     c                   EXFMT     S04DEN
119700150327     c                   ENDDO
119800150327
119900150327     c                   ENDSR
120000150327
120100150327      *=============================================================================================
120200150327      * $INQ5 - Inquiry screen
120300150327      *=============================================================================================
120400150327
120500150327     c     $INQ5         BEGSR
120600150327
120700150327     c                   EVAL      EMSG = 'INQUIRY ONLY'
120800150327     c                   EVAL      *IN40 = *ON
120900150327     c                   DOU       FKEY = F12
121000150327     c                   EXFMT     S05LIF
121100150327     c                   ENDDO
121200150327
121300150327     c                   ENDSR
121400150327
121401200117      *=============================================================================================
121402200117      * $INQ7 - Inquiry screen
121403200117      *=============================================================================================
121404200117
121405200117     c     $INQ7         BEGSR
121406200117
121407200117     c                   EVAL      EMSG = 'INQUIRY ONLY'
121408200117     c                   EVAL      *IN40 = *ON
121409200117     c                   DOU       FKEY = F12
121410200117     c                   EXFMT     S07VIS
121411200117     c                   ENDDO
121412200117
121413200117     c                   ENDSR
121414200117
121500150327      *=============================================================================================
121600150327      * $CHG2 - Change screen
121700150327      *=============================================================================================
121800150327
121900150327     c     $CHG2         BEGSR
122000150327
122100150327     c                   EVAL      @EMSG = 'BE CAREFUL'
122200150327
122300150327     c                   DOU       FKEY = F12
122400150327
122500150327     c                   EXSR      $SCREEN2
122600150327
122700150327     c                   IF        FKEY = F12
122800150327     c                   UNLOCK(E) CARPLNP
122900150513     c                   UNLOCK(E) AET004WF
123000150327     c                   SETOFF                                       3940
123100150327     c                   LEAVESR
123200150327     c                   ENDIF
123300150327
123400150327     c                   EVAL      KF@TRS  = ET
123500150327     c                   EVAL      KF@SUB  = ES
123600150327     c                   EVAL      KF@ACC  = EA
123700150327     c                   EVAL      KF@PLN  = S2PLAN
123800150327     c                   EVAL      KF@CCTR = S2CCTR
123900150327     c                   EVAL      KF@MAP  = S2MAP
124000150327
124100150327     c                   EVAL      ADD_MODE = NO
124200150327     c                   EXSR      $VALIDKEY
124300150327     c                   IF        VALID_REC = NO
124400150327     c                   ITER
124500150327     c                   ENDIF
124600150327
124700150327     c                   EXSR      $VALIDHMO
124800150327     c                   IF        VALID_REC = NO
124900150327     c                   ITER
125000150327     c                   ENDIF
125100150327
125200150327     c                   SETON                                        3940
125300150327     c                   DOU       FKEY = F12 OR FKEY = F10
125400150327     c                   EXSR      $SCREEN2
125500150327
125600150327     c                   IF        FKEY = F12
125700150327     c                   SETOFF                                       3940
125800150327     c                   LEAVESR
125900150327     c                   ENDIF
126000150327
126100150327     c                   IF        FKEY = F10
126200150327     c                   EVAL      CPCID2 = S2CID2
126300150327     c                   EVAL      CPCID3 = S2CID3
126400150327     c                   EVAL      CPCID4 = S2CID4
126500150327     c                   EVAL      CPCCTR = S2CCTR
126600160328     c                   EVAL      CPPLAN = S2PLAN
126700150327     c                   UPDATE    CARPLNR
126800160316     c     KL#TSAP       CHAIN     AEF04
126900150513     c                   EVAL      AE4MAP = S2MAP
127000150513     c                   UPDATE    AEF04
127100150327     c                   LEAVESR
127200150327     c                   ENDIF
127300150327
127400150327     c                   ENDDO
127500150327
127600150327     c                   ENDDO
127700150327
127800150327     c                   ENDSR
127900150327
128000150327      *=============================================================================================
128100150327      * $CHG3 - Change screen
128200150327      *=============================================================================================
128300150327
128400150327     c     $CHG3         BEGSR
128500150327
128600150327     c                   EVAL      @EMSG = 'BE CAREFUL'
128700150327
128800150327     c                   DOU       FKEY = F12
128900150327
129000150327     c                   EXSR      $SCREEN3
129100150327
129200150327     c                   IF        FKEY = F12
129300150327     c                   UNLOCK(E) CARPLNP
129400150513     c                   UNLOCK(E) AET004WF
129500150327     c                   SETOFF                                       3940
129600150327     c                   LEAVESR
129700150327     c                   ENDIF
129800150327
129900150327     c                   EVAL      KF@TRS  = ET
130000150327     c                   EVAL      KF@SUB  = ES
130100150327     c                   EVAL      KF@ACC  = EA
130200150327     c                   EVAL      KF@PLN  = S3PLAN
130300120813     C                   EVAL      KF@CCTR = S3CCTR
130400150327     c                   EVAL      KF@MAP  = S3MAP
130500150327
130600150327     c                   EVAL      ADD_MODE = NO
130700150327     c                   EXSR      $VALIDKEY
130800150327     c                   IF        VALID_REC = NO
130900150327     c                   ITER
131000150327     c                   ENDIF
131100150327
131200150327     c                   EXSR      $VALIDMEA
131300150327     c                   IF        VALID_REC = NO
131400150327     c                   ITER
131500150327     c                   ENDIF
131600150327
131700150327     c                   SETON                                        3940
131800150327     c                   DOU       FKEY = F12 OR FKEY = F10
131900150327     c                   EXSR      $SCREEN3
132000150327     c                   IF        FKEY = F12
132100150327     c                   SETOFF                                       3940
132200150327     c                   LEAVESR
132300150327     c                   ENDIF
132400150327     c                   IF        FKEY = F10
132500150327     c                   EVAL      CPCID2 = S3CID2
132600150327     c                   EVAL      CPCID3 = S3CID3
132700150327     c                   EVAL      CPCID4 = S3CID4
132800150327     c                   EVAL      CPCID5 = S3CID5
132900150327     c                   EVAL      CPCID6 = S3CID6
133000150327     c                   EVAL      CPCCTR = S3CCTR
133100160328     c                   EVAL      CPPLAN = S3PLAN
133200150327     c                   UPDATE    CARPLNR
133300150513     c                   EVAL      AE4MAP = S3MAP
133400150513     c                   UPDATE    AEF04
133500150327     c                   LEAVESR
133600150327     c                   ENDIF
133700150327
133800150327     c                   ENDDO
133900150327
134000150327     c                   ENDDO
134100150327
134200150327     c                   ENDSR
134300150327
134400150327      *=============================================================================================
134500150327      * $CHG4 - Change screen
134600150327      *=============================================================================================
134700150327
134800150327     c     $CHG4         BEGSR
134900150327
135000150327     c                   EVAL      @EMSG = 'BE CAREFUL'
135100150327
135200150327     c                   DOU       FKEY = F12
135300150327
135400150327     c                   EXSR      $SCREEN4
135500150327
135600150327     c                   IF        FKEY = F12
135700150327     c                   UNLOCK(E) CARPLNP
135800150513     c                   UNLOCK(E) AET004WF
135900150327     c                   SETOFF                                       3940
136000150327     c                   LEAVESR
136100150327     c                   ENDIF
136200150327
136300150327     c                   EVAL      KF@TRS  = ET
136400150327     c                   EVAL      KF@SUB  = ES
136500150327     c                   EVAL      KF@ACC  = EA
136600150327     c                   EVAL      KF@PLN  = S4PLAN
136700150327     c                   EVAL      KF@CCTR = S4CCTR
136800150327     c                   EVAL      KF@MAP  = S4MAP
136900150327
137000150327     c                   EVAL      ADD_MODE = NO
137100150327     c                   EXSR      $VALIDKEY
137200150327     c                   IF        VALID_REC = NO
137300150327     c                   ITER
137400150327     c                   ENDIF
137500150327
137600150327     c                   EXSR      $VALIDDEN
137700150327     c                   IF        VALID_REC = NO
137800150327     c                   ITER
137900150327     c                   ENDIF
138000150327
138100150327     c                   SETON                                        3940
138200150327     c                   DOU       FKEY = F12 OR FKEY = F10
138300150327     c                   EXSR      $SCREEN4
138400150327     c                   IF        FKEY = F12
138500150327     c                   SETOFF                                       3940
138600150327     c                   LEAVESR
138700150327     c                   ENDIF
138800150327     c                   IF        FKEY = F10
138900150327     c                   EVAL      CPCID2 = S4CID2
139000150327     c                   EVAL      CPCID3 = S4CID3
139100150327     c                   EVAL      CPCID4 = S4CID4
139200150327     c                   EVAL      CPCID5 = S4CID5
139300150327     c                   EVAL      CPCID6 = S4CID6
139400150327     c                   EVAL      CPCCTR = S4CCTR
139500160328     c                   EVAL      CPPLAN = S4PLAN
139600150327     c                   UPDATE    CARPLNR
139700150513     c                   EVAL      AE4MAP = S4MAP
139800150513     c                   UPDATE    AEF04
139900150327     c                   LEAVESR
140000150327     c                   ENDIF
140100150327
140200150327     c                   ENDDO
140300150327
140400150327     c                   ENDDO
140500150327
140600150327     c                   ENDSR
140700150327
140800150327      *=============================================================================================
140900150327      * $CHG5 - Change screen
141000150327      *=============================================================================================
141100150327
141200150327     c     $CHG5         BEGSR
141300150327
141400150327     c                   EVAL      @EMSG = 'BE CAREFUL'
141500150327
141600150327     c                   DOU       FKEY = F12
141700150327
141800150327     c                   EXSR      $SCREEN5
141900150327
142000150327     c                   IF        FKEY = F12
142100150327     c                   UNLOCK(E) CARPLNP
142200150513     c                   UNLOCK(E) AET004WF
142300150327     c                   SETOFF                                       3940
142400150327     c                   LEAVESR
142500150327     c                   ENDIF
142600150327
142700150327     c                   EVAL      KF@TRS  = ET
142800150327     c                   EVAL      KF@SUB  = ES
142900150327     c                   EVAL      KF@ACC  = EA
143000150327     c                   EVAL      KF@PLN  = S5PLAN
143100150327     c                   EVAL      KF@CCTR = S5CCTR
143200150327     c                   EVAL      KF@MAP  = S5MAP
143300150327
143400150327     c                   EVAL      ADD_MODE = NO
143500150327     c                   EXSR      $VALIDKEY
143600150327     c                   IF        VALID_REC = NO
143700150327     c                   ITER
143800150327     c                   ENDIF
143900150327
144000150327     c                   EXSR      $VALIDDEN
144100150327     c                   IF        VALID_REC = NO
144200150327     c                   ITER
144300150327     c                   ENDIF
144400150327
144500150327     c                   SETON                                        3940
144600150327     c                   DOU       FKEY = F12 OR FKEY = F10
144700150327     c                   EXSR      $SCREEN5
144800150327     c                   IF        FKEY = F12
144900150327     c                   SETOFF                                       3940
145000150327     c                   LEAVESR
145100150327     c                   ENDIF
145200150327     c                   IF        FKEY = F10
145300150327     c                   EVAL      CPCID2 = S5CID2
145400150327     c                   EVAL      CPCID3 = S5CID3
145500150327     c                   EVAL      CPCID4 = S5CID4
145600150327     c                   EVAL      CPCID5 = S5CID5
145700150327     c                   EVAL      CPCID6 = S5CID6
145800150327     c                   EVAL      CPCCTR = S5CCTR
145900160328     c                   EVAL      CPPLAN = S5PLAN
146000150327     c                   UPDATE    CARPLNR
146100150513     c                   EVAL      AE4MAP = S5MAP
146200150513     c                   UPDATE    AEF04
146300150327     c                   LEAVESR
146400150327     c                   ENDIF
146500150327
146600150327     c                   ENDDO
146700150327
146800150327     c                   ENDDO
146900150327
147000150327     c                   ENDSR
147100150327
147101200117      *=================================================
147102200117      * $CHG7 - Change screen
147103200117      *=================================================
147104200117     C     $CHG7         BEGSR
147105200117    ***
147106200117     C                   EVAL      @EMSG = 'BE CAREFUL'
147107200117    ***
147108200117     C                   DOU       FKEY = F12
147109200117      *
147110200117     C                   EXSR      $SCREEN7
147111200117      *
147112200117     C                   IF        FKEY = F12
147113200117     C                   UNLOCK(E) CARPLNP
147114200117     C                   UNLOCK(E) AET004WF
147116200117     C                   SETOFF                                       3940
147117200117     C                   LEAVESR
147119200117     C                   ENDIF
147120200117      *
147121200117     C                   EVAL      KF@TRS  = ET
147123200117     C                   EVAL      KF@SUB  = ES
147124200117     C                   EVAL      KF@ACC  = EA
147125200117     C                   EVAL      KF@PLN  = S7PLAN
147126200117     C                   EVAL      KF@CCTR = S7CCTR
147127200117     C                   EVAL      KF@MAP  = S7MAP
147128200117    ***
147129200117     C                   EVAL      ADD_MODE = NO
147130200117     C                   EXSR      $VALIDKEY
147131200117     C                   IF        VALID_REC = NO
147132200117     C                   ITER
147133200117     C                   ENDIF
147134200117     **
147135200117     C                   EXSR      $VALIDVIS
147136200117     C                   IF        VALID_REC = NO
147137200117     C                   ITER
147138200117     C                   ENDIF
147139200117     **
147140200117     C                   SETON                                        3940
147141200117     C                   DOU       FKEY = F12 OR FKEY =  F10
147142200117     C                   EXSR      $SCREEN7
147143200117     C                   IF        FKEY = F12
147145200117     C                   SETOFF                                       3940
147146200117     C                   LEAVESR
147147200117     C                   ENDIF
147149200117     C                   IF        FKEY = F10
147150200117     C                   EVAL      CPCID2 = S7CID2
147151200117     C                   EVAL      CPCID3 = S7CID3
147152200117     C                   EVAL      CPCID4 = S7CID4
147153200117     C                   EVAL      CPCID5 = S7CID5
147154200117     C                   EVAL      CPCID6 = S7CID6
147155200117     C                   EVAL      CPCCTR = S7CCTR
147156200117     C                   UPDATE    CARPLNR
147157200117     C                   EVAL      AE4MAP = S7MAP
147158200117     C                   UPDATE    AEF04
147159200117     C                   LEAVESR
147160200117     C                   ENDIF
147161200117     ***
147162200117     C                   ENDDO
147163200117     **
147164200117     C                   ENDDO
147165200117     **
147166200117     C                   ENDSR
147200150327      *=============================================================================================
147300150327      * Exit
147400150327      *=============================================================================================
147500150327
147600150327     c     Exit          begsr
147700150327
147800150327     c                   eval      *inlr = yes
147900150327     c                   return
148000150327
148100150327     c                   endsr
148200150327
148300150327      *=============================================================================================
148400150327      * Initialize subroutine
148500150327      *=============================================================================================
148600150327
148700150327     c     *inzsr        begsr
148800150327
148900150327     c                   EVAL      @PROC = 'PREP SFL  '
149000150327
149100150327     c     KL#TS         KLIST
149200150327     c                   KFLD                    KF@TRS
149300150327     c                   KFLD                    KF@SUB
149400150327
149500150327     c     KL#TSA        KLIST
149600150327     c                   KFLD                    KF@TRS
149700150327     c                   KFLD                    KF@SUB
149800150327     c                   KFLD                    KF@ACC
149900150327
150000150327     c     KL#TSAP       KLIST
150100150327     c                   KFLD                    KF@TRS
150200150327     c                   KFLD                    KF@SUB
150300150327     c                   KFLD                    KF@ACC
150400150327     c                   KFLD                    KF@PLN
150500150327
150600150327     c                   EVAL      HLD@NAME = XONAME
150700150327
150800150327     c     KL#TSP        KLIST
150900150327     c                   KFLD                    KF@TRS
151000150327     c                   KFLD                    KF@SUB
151100150327     c                   KFLD                    KF@PLN
151200150327
151300150327     c     KL#RTSACP     KLIST
151400150327     c                   KFLD                    KF@RET
151500150327     c                   KFLD                    KF@TRS
151600150327     c                   KFLD                    KF@SUB
151700150327     c                   KFLD                    KF@ACC
151800150327     c                   KFLD                    KF@CCTR
151900150327     c                   KFLD                    KF@PLN
152000150327
152100150327     c     KL#UTSACP     KLIST
152200150327     c                   KFLD                    KF@UNIQ
152300150327     c                   KFLD                    KF@TRS
152400150327     c                   KFLD                    KF@SUB
152500150327     c                   KFLD                    KF@ACC
152600150327     c                   KFLD                    KF@CCTR
152700150327     c                   KFLD                    KF@PLN
152800150327
152900150327     c                   endsr
153000150327
153100150327      *=============================================================================================
