000100160316      *=============================================================================================
000200160316     H option(*noDebugIo)
000300160316      *=============================================================================================
000400120808    *** AETNA SMALL GROUP PLAN MAPPING
000500010516    ***
000600120808    *** SSK  08/08/2012
000700010516    ***
000800130315    *** 03/15/2013 SSK ADD LIFE PRODUCT TO MAPPING
000900040728    ***
001000120906     FAET523D   CF   E             WORKSTN INFDS(WSDS) SFILE(S01SFL:RR1)
001100120808     FCARPLNP   UF A E           K DISK
001200120808     FCARPLNX   IF   E           K DISK    RENAME(CARPLNR:CPL2) PREFIX(ZZ:2)
001300130524     FCOMCTUNIQ IF   E           K DISK
001400120808     FTRMUNIQUE IF   E           K DISK
001500120808     FSUMUNIQUE IF   E           K DISK
001600120808     FACMUNIQUE IF   E           K DISK
001700120808     FPLNUNIQUE IF   E           K DISK
001800120808     FAET001WF  UF A E           K DISK
001900000102   X***X
002000120813     D HLD@NAME        S             40A
002100120813     D @EMSG           S                   LIKE(EMSG)
002200120813     D PRV#TRS         S                   LIKE(I_TRST)
002300120813     D PRV#SUB         S                   LIKE(I_SUB#)
002400120813     D PRV#ACC         S                   LIKE(I_ACCT)
002500120813     D PRV#PLN         S                   LIKE(I_PLAN)
002600120809     D ADD_MODE        S               N   INZ(*OFF)
002700120808     D VALID_REC       S               N   INZ(*OFF)
002800120808     D YES             S               N   INZ(*ON)
002900120808     D NO              S               N   INZ(*OFF)
003000000102    ***
003100000102     D WSDS            DS
003200000102     D  FKEY                 369    369A
003300000102    ***
003400000102     D  F1             C                   CONST(X'31')
003500000102     D  F2             C                   CONST(X'32')
003600000102     D  F3             C                   CONST(X'33')
003700000102     D  F4             C                   CONST(X'34')
003800000102     D  F5             C                   CONST(X'35')
003900000102     D  F6             C                   CONST(X'36')
004000000102     D  F7             C                   CONST(X'37')
004100000102     D  F8             C                   CONST(X'38')
004200000102     D  F9             C                   CONST(X'39')
004300000102     D  F10            C                   CONST(X'3A')
004400000102     D  F11            C                   CONST(X'3B')
004500000102     D  F12            C                   CONST(X'3C')
004600000102     D  F13            C                   CONST(X'B1')
004700000102     D  F14            C                   CONST(X'B2')
004800000102     D  F15            C                   CONST(X'B3')
004900000102     D  F16            C                   CONST(X'B4')
005000000102     D  F17            C                   CONST(X'B5')
005100000102     D  F18            C                   CONST(X'B6')
005200000102     D  F19            C                   CONST(X'B7')
005300000102     D  F20            C                   CONST(X'B8')
005400000102     D  F21            C                   CONST(X'B9')
005500000102     D  F22            C                   CONST(X'BA')
005600000102     D  F23            C                   CONST(X'BB')
005700000102     D  F24            C                   CONST(X'BC')
005800000102    ***
005900000102     D                UDS
006000120813     D  XONAME               201    240
006100000102    ***
006200120906     D KF@RET          S                   LIKE(CPUNIQ)
006300120906     D                                     INZ('9000000011')
006400120808     D KF@UNIQ         S                   LIKE(CPUNIQ)
006500120808     D                                     INZ('0000000011')
006600120808     D KF@TRS          S                   LIKE(CPTRST)
006700120808     D KF@SUB          S                   LIKE(CPSUB#)
006800120808     D KF@ACC          S                   LIKE(CPACCT)
006900120808     D KF@PLN          S                   LIKE(CPPLAN)
007000120808     D KF@CCTR         S                   LIKE(CPCCTR)
007100120808     D KF@MAP          S                   LIKE(AE1MAP)
007200120808    ***
007300120808     D @PROC           S             10A
007400120808    ***
007500120906     D                 DS
007600120906     D @BREAK                 01     11A
007700120906     D  ET                    01     03S 0
007800120906     D  ES                    04     06S 0
007900120906     D  EA                    07     10S 0
008000000102   X***X
008100120906    ***
008200120906     C     *ENTRY        PLIST
008300120906     C                   PARM                    @ENTRY           11
008400120906    ***
008500130315     C                   CLEAR                   S02HMO
008600130315     C                   CLEAR                   S03MEA
008700130315     C                   CLEAR                   S04DEN
008800130315     C                   CLEAR                   S05LIF
008900120906     C                   EVAL      @BREAK = @ENTRY
009000120906     C                   EVAL      KF@TRS = ET
009100120906     C                   EVAL      KF@SUB = ES
009200120906     C                   EVAL      KF@ACC = EA
009300120906    ***
009400120808     C                   DOU       @PROC = 'EXIT APP  '
009500120813     C     @PROC         CASEQ     'PREP SFL  '  $PREPSFL
009600120813     C     @PROC         CASEQ     'BUILD SFL '  $BLDSFL
009700120813     C     @PROC         CASEQ     'SFL CONTRL'  $SFLCTL
009800120813     C     @PROC         CASEQ     'ADD HMO   '  $ADDHMO
009900120813     C     @PROC         CASEQ     'ADD MEA   '  $ADDMEA
010000120813     C     @PROC         CASEQ     'ADD DEN   '  $ADDDEN
010100130315     C     @PROC         CASEQ     'ADD LIF   '  $ADDLIF
010200120813     C     @PROC         CASEQ     'CHECK SELC'  $CHKSELC
010300000102     C                   ENDCS
010400000102     C                   ENDDO
010500000102     C*
010600000102     C                   MOVE      *ON           *INLR
010700000102     C*
010800000102   S***S
010900000102     C     *INZSR        BEGSR
011000000102    ***
011100120808     C                   EVAL      @PROC = 'PREP SFL  '
011200000102    ***
011300120808     C     KL#TS         KLIST
011400120808     C                   KFLD                    KF@TRS
011500120808     C                   KFLD                    KF@SUB
011600120808    ***
011700120808     C     KL#TSA        KLIST
011800120808     C                   KFLD                    KF@TRS
011900120808     C                   KFLD                    KF@SUB
012000120808     C                   KFLD                    KF@ACC
012100000102    ***
012200120808     C     KL#TSAP       KLIST
012300120808     C                   KFLD                    KF@TRS
012400120808     C                   KFLD                    KF@SUB
012500120808     C                   KFLD                    KF@ACC
012600120808     C                   KFLD                    KF@PLN
012700120808    ***
012800120813     C                   EVAL      HLD@NAME = XONAME
012900120813    ***
013000120808     C     KL#TSP        KLIST
013100120808     C                   KFLD                    KF@TRS
013200120808     C                   KFLD                    KF@SUB
013300120808     C                   KFLD                    KF@PLN
013400120906    ***
013500120906     C     KL#RTSACP     KLIST
013600120906     C                   KFLD                    KF@RET
013700120906     C                   KFLD                    KF@TRS
013800120906     C                   KFLD                    KF@SUB
013900120906     C                   KFLD                    KF@ACC
014000120906     C                   KFLD                    KF@CCTR
014100120906     C                   KFLD                    KF@PLN
014200120808    ***
014300120808     C     KL#UTSACP     KLIST
014400120808     C                   KFLD                    KF@UNIQ
014500120808     C                   KFLD                    KF@TRS
014600120808     C                   KFLD                    KF@SUB
014700120808     C                   KFLD                    KF@ACC
014800120808     C                   KFLD                    KF@CCTR
014900120808     C                   KFLD                    KF@PLN
015000120808    ***
015100000102     C                   ENDSR
015200000102   S***S
015300120808     C     $PREPSFL      BEGSR
015400120808    ***
015500120808     C                   MOVE      *ZEROS        RR1               4 0
015600120808     C                   MOVE      *ZEROS        #CNTREC           4 0
015700120808    ***
015800120808     C                   EVAL      *IN39 = *OFF
015900120808     C                   EVAL      *IN40 = *OFF
016000120808    ***
016100120808     C                   EVAL      @PROC = 'BUILD SFL '
016200120808    ***
016300120808     C                   ENDSR
016400120808   S***S
016500120808     C* INITIALIZE THE SUBFILE
016600120808    ***
016700120808     C     $CLRSFL       BEGSR
016800120808    ***
016900120808     C                   MOVEA     '011'         *IN(25)
017000120808     C                   WRITE     S01CTL
017100120808     C                   MOVEA     '010'         *IN(25)
017200120808     C                   Z-ADD     *ZERO         RR1
017300120808    ***
017400120808     C                   ENDSR
017500120808   S***S
017600120808     C     $BLDSFL       BEGSR
017700120808    ***
017800120808     C                   MOVE      *ZEROS        #CNTREC
017900120808     C                   MOVE      '0'           @1STLOOP          1
018000120808     C                   MOVE      '0'           @SFLOOP           1
018100120808     C                   MOVE      '0'           *IN20
018200120808    ***
018300120906     C                   EVAL      I_TRST = ET
018400120906     C                   EVAL      I_SUB# = ES
018500120906     C                   EVAL      I_ACCT = EA
018600120906    ***
018700120808     C                   EVAL      KF@PLN = I_PLAN
018800120906    ***
018900120813     C                   EXSR      $CLRSFL
019000120813     C                   EVAL      CONAME = HLD@NAME
019100120906     C     KL#TSA        CHAIN     ACCMSR
019200120906     C                   IF        NOT %FOUND(ACMUNIQUE)
019300120906     C                   EVAL      D_ACCNAME = '**ERROR**'
019400120906     C                   ELSE
019500120906     C                   EVAL      D_ACCNAME = ACNAM1
019600120906     C                   ENDIF
019700120808    ***
019800120906     C     KL#TSAP       SETLL     CPL2
019900120906    1C                   DOU       %EOF(CARPLNX)
020000160316     C     KL#TSA        READE(N)  CPL2
020100120906    2C                   IF        NOT %EOF(CARPLNX) AND
020200120906     C                             (ZZUNIQ = KF@UNIQ OR
020300120906     C                              ZZUNIQ = KF@RET)
020400120906     C                   EXSR      $LOADSFL
020500120906    2C                   ENDIF
020600120906    1C                   ENDDO
020700120808    ***
020800120808     C                   EVAL      @PROC = 'SFL CONTRL'
020900120906    ***
021000120906     C                   ENDSR
021100120906   S***S
021200120808     C     $LOADSFL      BEGSR
021300120808    ***
021400120808     C                   MOVE      *ON           *IN25
021500120808     C                   MOVE      *BLANKS       SEL
021600120808    ***
021700120813     C                   EVAL      HUNIQ = ZZUNIQ
021800120906     C                   IF        ZZUNIQ = KF@UNIQ
021900120906     C                   EVAL      SFSTATUS = 'ACTIVE'
022000120906     C                   ELSE
022100120906     C                   EVAL      SFSTATUS = '*RETIRE*'
022200120906     C                   ENDIF
022300120906    ***
022400120813     C                   EVAL      SFCCTR = ZZCCTR
022500120813     C                   EVAL      SFPLAN = ZZPLAN
022600120813    ***
022700120813     C                   EVAL      KF@CCTR = ZZCCTR
022800120813     C                   EVAL      KF@PLN  = ZZPLAN
022900120808    ***
023000160316     C     KL#TSAP       CHAIN(n)  AEF01
023100120808     C                   IF        NOT %FOUND(AET001WF)
023200120808     C                   EVAL      SFMAP = '**ERROR**'
023300120808     C                   ELSE
023400120808     C                   EVAL      SFMAP = AE1MAP
023500120808     C                   ENDIF
023600120808    ***
023700120808     C     KL#TSP        CHAIN     PLNMSR
023800120808     C                   IF        NOT %FOUND(PLNUNIQUE)
023900120808     C                   EVAL      SFPNAME = '**ERROR**'
024000120808     C                   ELSE
024100120906     C                   EVAL      SFPNAME= %TRIM(PDESCR)
024200120808     C                   ENDIF
024300120808    ***
024400120808     C                   ADD       1             RR1
024500120808     C*
024600120808    1C                   IF        @1STLOOP = '0'
024700120808     C                   Z-ADD     RR1           SFLPOS
024800120808     C                   MOVE      '1'           @1STLOOP
024900120808    1C                   ENDIF
025000120808     C*
025100120808     C                   WRITE     S01SFL
025200120808     C*
025300120808     C                   ADD       1             #CNTREC
025400120906    1C                   IF        #CNTREC = 500
025500120808     C                   MOVE      '1'           @SFLOOP
025600120808    1C                   ENDIF
025700120808    ***
025800120808     C                   ENDSR
025900120808   S***S
026000120808     C     $SFLCTL       BEGSR
026100120808    ***
026200120808     C                   EVAL      EMSG = @EMSG
026300120808    ***
026400120808     C                   WRITE     S01REC
026500120808     C                   EXFMT     S01CTL
026600120808    ***
026700120808     C                   MOVE      *BLANKS       EMSG
026800120808     C                   MOVE      *BLANKS       @EMSG
026900120808    ***
027000120808     C                   IF        FKEY = F3
027100120808     C                   EVAL      @PROC = 'EXIT APP  '
027200120808     C                   LEAVESR
027300120808     C                   ENDIF
027400120808    ***
027500120808     C                   IF        FKEY = F6
027600120808     C                   SETOFF                                       3940
027700130315     C*                  CLEAR                   S02HMO
027800120813     C                   EVAL      CONAME = HLD@NAME
027900120906     C                   EVAL      S2TRST = ET
028000120906     C                   EVAL      S2SUB# = ES
028100120906     C                   EVAL      S2ACCT = EA
028200120906     C                   EXSR      $GETTSA
028300120808     C                   EVAL      @PROC = 'ADD HMO   '
028400120808     C                   LEAVESR
028500120808     C                   ENDIF
028600120808    ***
028700120808     C                   IF        FKEY = F7
028800120813     C                   SETOFF                                       3940
028900130315     C*                  CLEAR                   S03MEA
029000120906     C                   EVAL      S3TRST = ET
029100120906     C                   EVAL      S3SUB# = ES
029200120906     C                   EVAL      S3ACCT = EA
029300120906     C                   EXSR      $GETTSA
029400120813     C                   EVAL      CONAME = HLD@NAME
029500120808     C                   EVAL      @PROC = 'ADD MEA   '
029600120808     C                   LEAVESR
029700120808     C                   ENDIF
029800120808    ***
029900120808     C                   IF        FKEY = F8
030000120813     C                   SETOFF                                       3940
030100130315     C*                  CLEAR                   S04DEN
030200120813     C                   EVAL      CONAME = HLD@NAME
030300120906     C                   EVAL      S4TRST = ET
030400120906     C                   EVAL      S4SUB# = ES
030500120906     C                   EVAL      S4ACCT = EA
030600120906     C                   EXSR      $GETTSA
030700120808     C                   EVAL      @PROC = 'ADD DEN   '
030800120808     C                   LEAVESR
030900120808     C                   ENDIF
031000120808    ***
031100130315     C                   IF        FKEY = F9
031200130315     C                   SETOFF                                       3940
031300130315     C*                  CLEAR                   S05LIF
031400130315     C                   EVAL      CONAME = HLD@NAME
031500130315     C                   EVAL      S5TRST = ET
031600130315     C                   EVAL      S5SUB# = ES
031700130315     C                   EVAL      S5ACCT = EA
031800130315     C                   EXSR      $GETTSA
031900130315     C                   EVAL      @PROC = 'ADD LIF   '
032000130315     C                   LEAVESR
032100130315     C                   ENDIF
032200130315    ***
032300120809     C                   EVAL      @PROC = 'CHECK SELC'
032400120808    ***
032500120808     C                   ENDSR
032600120808   S***S
032700120906     C     $ADDHMO       BEGSR
032800120906    ***
032900120808     C                   EXSR      $SCREEN2
033000120808    ***
033100120808     C                   IF        FKEY = F12
033200120906     C                   CLEAR                   S02HMO
033300120906     C                   EVAL      CONAME = HLD@NAME
033400120808     C                   EVAL      @PROC = 'SFL CONTRL'
033500120808     C                   LEAVESR
033600120808     C                   ENDIF
033700120808    ***
033800120906     C                   EVAL      KF@TRS  = ET
033900120906     C                   EVAL      KF@SUB  = ES
034000120906     C                   EVAL      KF@ACC  = EA
034100120808     C                   EVAL      KF@PLN  = S2PLAN
034200120808     C                   EVAL      KF@CCTR = S2CCTR
034300120808     C                   EVAL      KF@MAP  = S2MAP
034400120808    ***
034500120809     C                   EVAL      ADD_MODE = YES
034600120808     C                   EXSR      $VALIDKEY
034700120808    ***
034800120808     C                   IF        VALID_REC = NO
034900120808     C                   LEAVESR
035000120808     C                   ENDIF
035100120809    ***
035200120809     C                   EXSR      $VALIDHMO
035300120809    ***
035400120809     C                   IF        VALID_REC = NO
035500120809     C                   LEAVESR
035600120809     C                   ENDIF
035700120808    ***
035800120808     C                   SETON                                        3940
035900120808    ***
036000120808     C                   DOU       FKEY = F12 OR FKEY = F10
036100120808      *
036200120808     C                   EXSR      $SCREEN2
036300120808      *
036400120808     C                   IF        FKEY = F12
036500120808     C                   SETOFF                                       3940
036600120808     C                   LEAVESR
036700120808     C                   ENDIF
036800120808      *
036900120808     C                   IF        FKEY = F10
037000120808     C                   EXSR      $PREPLN
037100120808     C                   EVAL      CPCID1 = 'HMO'
037200120808     C                   EVAL      CPTXT1 = 'LAYOUT CODE'
037300120808     C                   EVAL      CPCID2 = S2CID2
037400120808     C                   EVAL      CPTXT2 = 'FILE NUMBER'
037500120808     C                   EVAL      CPCID3 = S2CID3
037600120808     C                   EVAL      CPTXT3 = 'CLASS CODE'
037700120808     C                   EVAL      CPCID4 = S2CID4
037800120808     C                   EVAL      CPTXT4 = 'PLAN'
037900120808     C                   EVAL      CPCID5 = 'N/A'
038000120808     C                   EVAL      CPTXT5 = 'N/A'
038100120808     C                   EVAL      CPCID6 = 'N/A'
038200120808     C                   EVAL      CPTXT6 = 'N/A'
038300120808     C                   WRITE     CARPLNR
038400120808     C                   LEAVE
038500120808     C                   ENDIF
038600120808      *
038700120808     C                   ENDDO
038800120808    ***
038900120808     C                   EVAL      @PROC = 'SFL CONTRL'
039000120808    ***
039100120808     C                   ENDSR
039200120808   S***S
039300120808     C     $SCREEN2      BEGSR
039400120808    ***
039500120808     C                   EVAL      EMSG = @EMSG
039600120808     C                   EXFMT     S02HMO
039700120808     C                   CLEAR                   @EMSG
039800120808     C                   EVAL      EMSG = *BLANKS
039900120808    ***
040000120808     C                   ENDSR
040100120808   S***S
040200120808     C     $SCREEN3      BEGSR
040300120808    ***
040400120808     C                   EVAL      EMSG = @EMSG
040500120808     C                   EXFMT     S03MEA
040600120808     C                   CLEAR                   @EMSG
040700120808     C                   EVAL      EMSG = *BLANKS
040800120808    ***
040900120808     C                   ENDSR
041000120808   S***S
041100120808     C     $SCREEN4      BEGSR
041200120808    ***
041300120808     C                   EVAL      EMSG = @EMSG
041400120808     C                   EXFMT     S04DEN
041500120808     C                   CLEAR                   @EMSG
041600120808     C                   EVAL      EMSG = *BLANKS
041700120906    ***
041800120906     C                   ENDSR
041900120906   S***S
042000130315     C     $SCREEN5      BEGSR
042100130315    ***
042200130315     C                   EVAL      EMSG = @EMSG
042300130315     C                   EXFMT     S05LIF
042400130315     C                   CLEAR                   @EMSG
042500130315     C                   EVAL      EMSG = *BLANKS
042600130315    ***
042700130315     C                   ENDSR
042800130315   S***S
042900120906     C     $GETTSA       BEGSR
043000120906    ***
043100120906     C                   EVAL      KF@TRS  = ET
043200120906     C                   EVAL      KF@SUB  = ES
043300120906     C                   EVAL      KF@ACC  = EA
043400120906    ***
043500120906     C     KF@TRS        CHAIN     TRSMSR
043600120906     C                   IF        NOT %FOUND(TRMUNIQUE)
043700120906     C                   EVAL      O_TNAM = '**ERROR**'
043800120906     C                   ELSE
043900120906     C                   MOVEL(P)  TDESCR        O_TNAM
044000120906     C                   ENDIF
044100120906    ***
044200120906     C     KL#TS         CHAIN     SUBMSR
044300120906     C                   IF        NOT %FOUND(SUMUNIQUE)
044400120906     C                   EVAL      O_SUBN = '**ERROR**'
044500120906     C                   ELSE
044600120906     C                   MOVEL(P)  SUBDSC        O_SUBN
044700120906     C                   ENDIF
044800120906    ***
044900120906     C     KL#TSA        CHAIN     ACCMSR
045000120906     C                   IF        NOT %FOUND(ACMUNIQUE)
045100120906     C                   EVAL      O_ACCN = '**ERROR**'
045200120906     C                   ELSE
045300120906     C                   EVAL      O_ACCN = ACNAM1
045400120906     C                   ENDIF
045500130315    ***
045600130315     C                   MOVE      *BLANKS       D_PLAN
045700120808    ***
045800120808     C                   ENDSR
045900120808   S***S
046000120808     C     $VALIDKEY     BEGSR
046100120808    ***
046200120808     C                   EVAL      VALID_REC = NO
046300120808    ***
046400120808     C     KL#TSP        CHAIN     PLNMSR
046500120808     C                   IF        NOT %FOUND(PLNUNIQUE)
046600120808     C                   EVAL      D_PLAN = '**ERROR**'
046700120808     C                   EVAL      @EMSG = 'INVALID TRUST/SUB/PLAN'
046800120808     C                   LEAVESR
046900120808     C                   ENDIF
047000130524    ***
047100130524     C     KL#TSAP       CHAIN     COMCXR
047200130524     C                   IF        NOT %FOUND(COMCTUNIQ)
047300130524     C                   EVAL      @EMSG = 'COMMISSION CONTROL N/F'
047400130524     C                   LEAVESR
047500130524     C                   ENDIF
047600120808    ***
047700120808     C                   MOVEL(P)  PDESCR        D_PLAN
047800120808    ***
047900120808     C                   IF        KF@MAP = *BLANKS
048000120808     C                   EVAL      @EMSG = 'MISSING MAP'
048100120808     C                   LEAVESR
048200120808     C                   ENDIF
048300120808    ***
048400120808     C                   IF        KF@MAP <> '2TIER     ' AND
048500120808     C                             KF@MAP <> 'TIERSTS   ' AND
048600120808     C                             KF@MAP <> 'STATETIER ' AND
048700120808     C                             KF@MAP <> 'EMPSTS    ' AND
048800120808     C                             KF@MAP <> 'ITOBJECTS ' AND
048900120808     C                             KF@MAP <> 'JUSTSTATE ' AND
049000120808     C                             KF@MAP <> 'STSTATE   ' AND
049100130123     C                             KF@MAP <> 'STIERSTS  ' AND
049200120808     C                             KF@MAP <> 'CREATIVE  ' AND
049300120808     C                             KF@MAP <> 'JOHNLS    ' AND
049400120808     C                             KF@MAP <> 'INTEGRA   ' AND
049500120808     C                             KF@MAP <> 'MAYOR     ' AND
049600120808     C                             KF@MAP <> 'NORULE    '
049700120808     C                   EVAL      @EMSG = 'INVALID MAP; REFER TO MAP DOCUMENT'
049800120808     C                   LEAVESR
049900120808     C                   ENDIF
050000120808    ***
050100120808     C                   IF        KF@MAP <> 'NORULE' AND
050200120808     C                             KF@CCTR = *BLANKS
050300120808     C                   EVAL      @EMSG = 'MISSING MAPPING VALUE'
050400120808     C                   LEAVESR
050500120808     C                   ENDIF
050600120808    ***
050700120809     C                   IF        ADD_MODE = YES
050800120808     C     KL#UTSACP     CHAIN     CARPLNR
050900120808     C                   IF        %FOUND(CARPLNP)
051000120808     C                   EVAL      @EMSG = 'T/S/A/P/MAP VALUE ALREADY EXISTS'
051100120808     C                   LEAVESR
051200120809     C                   ENDIF
051300120808     C                   ENDIF
051400120808    ***
051500120808     C                   EVAL      VALID_REC = YES
051600120809    ***
051700120809     C                   ENDSR
051800120809   S***S
051900120809     C     $VALIDHMO     BEGSR
052000120809    ***
052100120809     C                   EVAL      VALID_REC = NO
052200120809    ***
052300120809     C                   IF        S2CID2 = *BLANKS
052400120809     C                   EVAL      @EMSG = 'FILE NUMBER IS REQUIRED'
052500120809     C                   LEAVESR
052600120809     C                   ENDIF
052700120808    ***
052800120809     C                   IF        S2CID3 = *BLANKS
052900120809     C                   EVAL      @EMSG = 'CLASS CODE IS REQUIRED'
053000120809     C                   LEAVESR
053100120809     C                   ENDIF
053200120809    ***
053300120809     C                   IF        S2CID4 = *BLANKS
053400120809     C                   EVAL      @EMSG = 'PLAN NUMBER IS REQUIRED'
053500120809     C                   LEAVESR
053600120809     C                   ENDIF
053700120809    ***
053800120809     C                   EVAL      VALID_REC = YES
053900120809    ***
054000120808     C                   ENDSR
054100120808   S***S
054200120808     C     $PREPLN       BEGSR
054300120808    ***
054400120808     C     KL#TSAP       CHAIN     AET001WF
054500120808     C                   IF        NOT %FOUND(AET001WF)
054600120808     C                   CLEAR                   AEF01
054700120906     C                   EVAL      AE1TRS = ET
054800120906     C                   EVAL      AE1SUB = ES
054900120906     C                   EVAL      AE1ACC = EA
055000120808     C                   EVAL      AE1PLN = KF@PLN
055100120808     C                   EVAL      AE1MAP = KF@MAP
055200120808     C                   WRITE(E)  AEF01
055300120808     C                   ENDIF
055400120808    ***
055500120808     C                   CLEAR                   CARPLNR
055600120808     C                   EVAL      CPUNIQ = KF@UNIQ
055700120906     C                   EVAL      CPTRST = ET
055800120906     C                   EVAL      CPSUB# = ES
055900120906     C                   EVAL      CPACCT = EA
056000120808     C                   EVAL      CPCCTR = KF@CCTR
056100120808     C                   EVAL      CPPLAN = KF@PLN
056200120808    ***
056300120808     C                   ENDSR
056400120808   S***S
056500120808     C     $ADDMEA       BEGSR
056600120808    ***
056700120808     C                   EXSR      $SCREEN3
056800120808    ***
056900120808     C                   IF        FKEY = F12
057000120808     C                   CLEAR                   S03MEA
057100120808     C                   EVAL      CONAME = HLD@NAME
057200120808     C                   EVAL      @PROC = 'SFL CONTRL'
057300120808     C                   LEAVESR
057400120808     C                   ENDIF
057500120808    ***
057600120906     C                   EVAL      KF@TRS  = ET
057700120906     C                   EVAL      KF@SUB  = ES
057800120906     C                   EVAL      KF@ACC  = EA
057900120808     C                   EVAL      KF@PLN  = S3PLAN
058000120808     C                   EVAL      KF@CCTR = S3CCTR
058100120808     C                   EVAL      KF@MAP  = S3MAP
058200120808    ***
058300120809     C                   EVAL      ADD_MODE = YES
058400120808     C                   EXSR      $VALIDKEY
058500120808    ***
058600120808     C                   IF        VALID_REC = NO
058700120808     C                   LEAVESR
058800120808     C                   ENDIF
058900120809    ***
059000120809     C                   EXSR      $VALIDMEA
059100120808    ***
059200120809     C                   IF        VALID_REC = NO
059300120809     C                   LEAVESR
059400120809     C                   ENDIF
059500120809    ***
059600120808     C                   SETON                                        3940
059700120808    ***
059800120808     C                   DOU       FKEY = F12 OR FKEY = F10
059900120808      *
060000120808     C                   EXSR      $SCREEN3
060100120808      *
060200120808     C                   IF        FKEY = F12
060300120808     C                   SETOFF                                       3940
060400120808     C                   LEAVESR
060500120808     C                   ENDIF
060600120808      *
060700120808     C                   IF        FKEY = F10
060800120808     C                   EXSR      $PREPLN
060900120808     C                   EVAL      CPCID1 = 'MEA'
061000120808     C                   EVAL      CPTXT1 = 'LAYOUT CODE'
061100120808     C                   EVAL      CPCID2 = S3CID2
061200120808     C                   EVAL      CPTXT2 = 'ELR'
061300120808     C                   EVAL      CPCID3 = S3CID3
061400120808     C                   EVAL      CPTXT3 = 'SUFFIX'
061500120808     C                   EVAL      CPCID4 = S3CID4
061600120808     C                   EVAL      CPTXT4 = 'ACCOUNT'
061700120808     C                   EVAL      CPCID5 = S3CID5
061800120808     C                   EVAL      CPTXT5 = 'PLAN'
061900120808     C                   EVAL      CPCID6 = S3CID6
062000120808     C                   EVAL      CPTXT6 = 'CLAIM OFFICE'
062100120808     C                   WRITE     CARPLNR
062200120808     C                   LEAVE
062300120808     C                   ENDIF
062400120808      *
062500120808     C                   ENDDO
062600120808    ***
062700120808     C                   EVAL      @PROC = 'SFL CONTRL'
062800120808    ***
062900120808     C                   ENDSR
063000120809   S***S
063100120809     C     $VALIDMEA     BEGSR
063200120809    ***
063300120809     C                   EVAL      VALID_REC = NO
063400120809    ***
063500120809     C                   IF        S3CID2 = *BLANKS
063600120809     C                   EVAL      @EMSG = 'ELR IS REQUIRED'
063700120809     C                   LEAVESR
063800120809     C                   ENDIF
063900120809    ***
064000120809     C                   IF        S3CID3 = *BLANKS
064100120809     C                   EVAL      @EMSG = 'SUFFIX IS REQUIRED'
064200120809     C                   LEAVESR
064300120809     C                   ENDIF
064400120809    ***
064500120809     C                   IF        S3CID4 = *BLANKS
064600120809     C                   EVAL      @EMSG = 'ACCOUNT IS REQUIRED'
064700120809     C                   LEAVESR
064800120809     C                   ENDIF
064900120809    ***
065000120809     C                   IF        S3CID5 = *BLANKS
065100120809     C                   EVAL      @EMSG = 'PLAN IS REQUIRED'
065200120809     C                   LEAVESR
065300120809     C                   ENDIF
065400120809    ***
065500120809     C                   IF        S3CID6 = *BLANKS
065600120809     C                   EVAL      @EMSG = 'CLAIM OFFICE IS REQUIRED'
065700120809     C                   LEAVESR
065800120809     C                   ENDIF
065900120809    ***
066000120809     C                   EVAL      VALID_REC = YES
066100120809    ***
066200120809     C                   ENDSR
066300120809   S***S
066400120808     C     $ADDDEN       BEGSR
066500120808    ***
066600120808     C                   EXSR      $SCREEN4
066700120808    ***
066800120808     C                   IF        FKEY = F12
066900120808     C                   CLEAR                   S04DEN
067000120808     C                   EVAL      CONAME = HLD@NAME
067100120808     C                   EVAL      @PROC = 'SFL CONTRL'
067200120808     C                   LEAVESR
067300120808     C                   ENDIF
067400120808    ***
067500120906     C                   EVAL      KF@TRS  = ET
067600120906     C                   EVAL      KF@SUB  = ES
067700120906     C                   EVAL      KF@ACC  = EA
067800120808     C                   EVAL      KF@PLN  = S4PLAN
067900120808     C                   EVAL      KF@CCTR = S4CCTR
068000120808     C                   EVAL      KF@MAP  = S4MAP
068100120808    ***
068200120809     C                   EVAL      ADD_MODE = YES
068300120808     C                   EXSR      $VALIDKEY
068400120808    ***
068500120808     C                   IF        VALID_REC = NO
068600120808     C                   LEAVESR
068700120808     C                   ENDIF
068800120808    ***
068900120809     C                   EXSR      $VALIDDEN
069000120809    ***
069100120809     C                   IF        VALID_REC = NO
069200120809     C                   LEAVESR
069300120809     C                   ENDIF
069400120809    ***
069500120808     C                   SETON                                        3940
069600120808    ***
069700120808     C                   DOU       FKEY = F12 OR FKEY = F10
069800120808      *
069900120808     C                   EXSR      $SCREEN4
070000120808      *
070100120808     C                   IF        FKEY = F12
070200120808     C                   SETOFF                                       3940
070300120808     C                   LEAVESR
070400120808     C                   ENDIF
070500120808      *
070600120808     C                   IF        FKEY = F10
070700120808     C                   EXSR      $PREPLN
070800120808     C                   EVAL      CPCID1 = 'DEN'
070900120808     C                   EVAL      CPTXT1 = 'LAYOUT CODE'
071000120808     C                   EVAL      CPCID2 = S4CID2
071100120808     C                   EVAL      CPTXT2 = 'ELR'
071200120808     C                   EVAL      CPCID3 = S4CID3
071300120808     C                   EVAL      CPTXT3 = 'SUFFIX'
071400120808     C                   EVAL      CPCID4 = S4CID4
071500120808     C                   EVAL      CPTXT4 = 'ACCOUNT'
071600120808     C                   EVAL      CPCID5 = S4CID5
071700120808     C                   EVAL      CPTXT5 = 'PLAN'
071800120808     C                   EVAL      CPCID6 = S4CID6
071900120808     C                   EVAL      CPTXT6 = 'CLAIM OFFICE'
072000120808     C                   WRITE     CARPLNR
072100120808     C                   LEAVE
072200120808     C                   ENDIF
072300120808      *
072400120808     C                   ENDDO
072500120808    ***
072600120808     C                   EVAL      @PROC = 'SFL CONTRL'
072700120808    ***
072800120808     C                   ENDSR
072900120808   S***S
073000120809     C     $VALIDDEN     BEGSR
073100120809    ***
073200120809     C                   EVAL      VALID_REC = NO
073300120809    ***
073400120809     C                   IF        S4CID2 = *BLANKS
073500120809     C                   EVAL      @EMSG = 'ELR IS REQUIRED'
073600120809     C                   LEAVESR
073700120809     C                   ENDIF
073800120809    ***
073900120809     C                   IF        S4CID3 = *BLANKS
074000120809     C                   EVAL      @EMSG = 'SUFFIX IS REQUIRED'
074100120809     C                   LEAVESR
074200120809     C                   ENDIF
074300120809    ***
074400120809     C                   IF        S4CID4 = *BLANKS
074500120809     C                   EVAL      @EMSG = 'ACCOUNT IS REQUIRED'
074600120809     C                   LEAVESR
074700120809     C                   ENDIF
074800120809    ***
074900120809     C                   IF        S4CID5 = *BLANKS
075000120809     C                   EVAL      @EMSG = 'PLAN IS REQUIRED'
075100120809     C                   LEAVESR
075200120809     C                   ENDIF
075300120809    ***
075400120809     C                   IF        S4CID6 = *BLANKS
075500120809     C                   EVAL      @EMSG = 'CLAIM OFFICE IS REQUIRED'
075600120809     C                   LEAVESR
075700120809     C                   ENDIF
075800120809    ***
075900120809     C                   EVAL      VALID_REC = YES
076000120809    ***
076100120809     C                   ENDSR
076200120809   S***S
076300130315     C     $ADDLIF       BEGSR
076400130315    ***
076500130315     C                   EXSR      $SCREEN5
076600130315    ***
076700130315     C                   IF        FKEY = F12
076800130315     C                   CLEAR                   S05LIF
076900130315     C                   EVAL      CONAME = HLD@NAME
077000130315     C                   EVAL      @PROC = 'SFL CONTRL'
077100130315     C                   LEAVESR
077200130315     C                   ENDIF
077300130315    ***
077400130315     C                   EVAL      KF@TRS  = ET
077500130315     C                   EVAL      KF@SUB  = ES
077600130315     C                   EVAL      KF@ACC  = EA
077700130315     C                   EVAL      KF@PLN  = S5PLAN
077800130315     C                   EVAL      KF@CCTR = S5CCTR
077900130315     C                   EVAL      KF@MAP  = S5MAP
078000130315    ***
078100130315     C                   EVAL      ADD_MODE = YES
078200130315     C                   EXSR      $VALIDKEY
078300130315    ***
078400130315     C                   IF        VALID_REC = NO
078500130315     C                   LEAVESR
078600130315     C                   ENDIF
078700130315    ***
078800130315     C                   EXSR      $VALIDLIF
078900130315    ***
079000130315     C                   IF        VALID_REC = NO
079100130315     C                   LEAVESR
079200130315     C                   ENDIF
079300130315    ***
079400130315     C                   SETON                                        3940
079500130315    ***
079600130315     C                   DOU       FKEY = F12 OR FKEY = F10
079700130315      *
079800130315     C                   EXSR      $SCREEN5
079900130315      *
080000130315     C                   IF        FKEY = F12
080100130315     C                   SETOFF                                       3940
080200130315     C                   LEAVESR
080300130315     C                   ENDIF
080400130315      *
080500130315     C                   IF        FKEY = F10
080600130315     C                   EXSR      $PREPLN
080700130315     C                   EVAL      CPCID1 = 'LIF'
080800130315     C                   EVAL      CPTXT1 = 'LAYOUT CODE'
080900130315     C                   EVAL      CPCID2 = S5CID2
081000130315     C                   EVAL      CPTXT2 = 'ELR'
081100130315     C                   EVAL      CPCID3 = S5CID3
081200130315     C                   EVAL      CPTXT3 = 'SUFFIX'
081300130315     C                   EVAL      CPCID4 = S5CID4
081400130315     C                   EVAL      CPTXT4 = 'ACCOUNT'
081500130315     C                   EVAL      CPCID5 = S5CID5
081600130315     C                   EVAL      CPTXT5 = 'PLAN'
081700130315     C                   EVAL      CPCID6 = S5CID6
081800130315     C                   EVAL      CPTXT6 = 'CLAIM OFFICE'
081900130315     C                   WRITE     CARPLNR
082000130315     C                   LEAVE
082100130315     C                   ENDIF
082200130315      *
082300130315     C                   ENDDO
082400130315    ***
082500130315     C                   EVAL      @PROC = 'SFL CONTRL'
082600130315    ***
082700130315     C                   ENDSR
082800130315   S***S
082900130315     C     $VALIDLIF     BEGSR
083000130315    ***
083100130315     C                   EVAL      VALID_REC = NO
083200130315    ***
083300130315     C                   IF        S5CID2 = *BLANKS
083400130315     C                   EVAL      @EMSG = 'ELR IS REQUIRED'
083500130315     C                   LEAVESR
083600130315     C                   ENDIF
083700130315    ***
083800130315     C                   IF        S5CID3 = *BLANKS
083900130315     C                   EVAL      @EMSG = 'SUFFIX IS REQUIRED'
084000130315     C                   LEAVESR
084100130315     C                   ENDIF
084200130315    ***
084300130315     C                   IF        S5CID4 = *BLANKS
084400130315     C                   EVAL      @EMSG = 'ACCOUNT IS REQUIRED'
084500130315     C                   LEAVESR
084600130315     C                   ENDIF
084700130315    ***
084800130315     C                   IF        S5CID5 = *BLANKS
084900130315     C                   EVAL      @EMSG = 'PLAN IS REQUIRED'
085000130315     C                   LEAVESR
085100130315     C                   ENDIF
085200130315    ***
085300130315     C                   IF        S5CID6 = *BLANKS
085400130315     C                   EVAL      @EMSG = 'CLAIM OFFICE IS REQUIRED'
085500130315     C                   LEAVESR
085600130315     C                   ENDIF
085700130315    ***
085800130315     C                   EVAL      VALID_REC = YES
085900130315    ***
086000130315     C                   ENDSR
086100130315   S***S
086200120808     C     $CHKSELC      BEGSR
086300120808    ***
086400120906     C                   IF        I_PLAN <> PRV#PLN
086500120808     C                   EVAL      PRV#PLN = I_PLAN
086600120808     C                   EVAL      @PROC = 'PREP SFL  '
086700120808     C                   LEAVESR
086800120808     C                   ENDIF
086900120808    ***
087000120906    1C                   DOU       %EOF(AET523D)
087100120808     C                   READC     S01SFL
087200120906    2C                   IF        NOT %EOF(AET523D)
087300120813    ***
087400120906     C                   EVAL      KF@TRS  = ET
087500120906     C                   EVAL      KF@SUB  = ES
087600120906     C                   EVAL      KF@ACC  = EA
087700120813     C                   EVAL      KF@PLN  = SFPLAN
087800120813     C                   EVAL      KF@CCTR = SFCCTR
087900120813     C                   EVAL      KF@MAP  = SFMAP
088000120808    ***
088100120906     C                   IF        SEL = 'U'
088200120906     C     KL#RTSACP     CHAIN     CARPLNR
088300120906     C                   ELSE
088400120906     C     KL#UTSACP     CHAIN     CARPLNR
088500120906     C                   ENDIF
088600120809     C     KL#TSAP       CHAIN     AET001WF
088700120809    ***
088800120809     C                   SELECT
088900120906      * *
089000120906     C                   WHEN      SEL = 'R'
089100120906     C                   EVAL      CPUNIQ = KF@RET
089200120906     C                   UPDATE    CARPLNR
089300120906     C                   UNLOCK(E) AET001WF
089400120906      * *
089500120906     C                   WHEN      SEL = 'U'
089600120906     C                   EVAL      CPUNIQ = KF@UNIQ
089700120906     C                   UPDATE    CARPLNR
089800120906     C                   UNLOCK(E) AET001WF
089900120906      * *
090000120809     C                   WHEN      CPCID1 = 'HMO' AND SEL = 'I'
090100120809     C                   EXSR      $FMTSCR2
090200120809     C                   EXSR      $INQ2
090300120906      *
090400120809     C                   WHEN      CPCID1 = 'HMO' AND SEL = 'C'
090500120809     C                   EXSR      $FMTSCR2
090600120809     C                   EXSR      $CHG2
090700120906      * *
090800120809     C                   WHEN      CPCID1 = 'MEA' AND SEL = 'I'
090900120809     C                   EXSR      $FMTSCR3
091000120809     C                   EXSR      $INQ3
091100120906      *
091200120809     C                   WHEN      CPCID1 = 'MEA' AND SEL = 'C'
091300120809     C                   EXSR      $FMTSCR3
091400120809     C                   EXSR      $CHG3
091500120906      * *
091600120809     C                   WHEN      CPCID1 = 'DEN' AND SEL = 'I'
091700120809     C                   EXSR      $FMTSCR4
091800120809     C                   EXSR      $INQ4
091900120906      *
092000120809     C                   WHEN      CPCID1 = 'DEN' AND SEL = 'C'
092100120809     C                   EXSR      $FMTSCR4
092200120809     C                   EXSR      $CHG4
092300120906      * *
092400130315     C                   WHEN      CPCID1 = 'LIF' AND SEL = 'I'
092500130315     C                   EXSR      $FMTSCR5
092600130315     C                   EXSR      $INQ5
092700130315      *
092800130315     C                   WHEN      CPCID1 = 'LIF' AND SEL = 'C'
092900130315     C                   EXSR      $FMTSCR5
093000130315     C                   EXSR      $CHG5
093100130315      * *
093200151013     C                   WHEN      CPCID1 = 'LIFE' AND SEL = 'I'
093300151013     C                   EXSR      $FMTSCR5
093400151013     C                   EXSR      $INQ5
093500151013      *
093600151013     C                   WHEN      CPCID1 = 'LIFE' AND SEL = 'C'
093700151013     C                   EXSR      $FMTSCR5
093800151013     C                   EXSR      $CHG5
093900151013      * *
094000120809     C                   ENDSL
094100120809    ***
094200120813    3C                   IF        @EMSG <> *BLANKS
094300120808     C                   LEAVESR
094400120808    3C                   ENDIF
094500120808     C*
094600120808     C                   MOVE      *BLANKS       SEL
094700120808     C                   UPDATE    S01SFL
094800120808     C*
094900120808    2C                   ENDIF
095000120808    1C                   ENDDO
095100120808    ***
095200120816     C                   EVAL      @PROC = 'PREP SFL  '
095300120808    ***
095400120808     C                   ENDSR
095500120808   S***S
095600120809     C     $FMTSCR2      BEGSR
095700120809    ***
095800120809     C                   SETOFF                                       3940
095900120809     C                   CLEAR                   S02HMO
096000120809     C                   EVAL      CONAME = HLD@NAME
096100120809    ***
096200120906     C                   EVAL      S2TRST = ET
096300120906     C                   EVAL      S2SUB# = ES
096400120906     C                   EVAL      S2ACCT = EA
096500120809     C                   EVAL      S2PLAN = CPPLAN
096600120809     C                   EVAL      S2CCTR = CPCCTR
096700120809     C                   EVAL      S2MAP  = AE1MAP
096800120809    ***
096900120809     C                   EXSR      $CHAINS
097000120809    ***
097100120809     C                   EVAL      S2CID2 = %TRIM(CPCID2)
097200120809     C                   EVAL      S2CID3 = %TRIM(CPCID3)
097300120809     C                   EVAL      S2CID4 = %TRIM(CPCID4)
097400120809    ***
097500120809     C                   ENDSR
097600120808   S***S
097700120809     C     $CHAINS       BEGSR
097800120809    ***
097900120809     C     KF@TRS        CHAIN     TRSMSR
098000120809     C                   IF        %FOUND(TRMUNIQUE)
098100120809     C                   MOVEL(P)  TDESCR        O_TNAM
098200120809     C                   ENDIF
098300120809    ***
098400120809     C     KL#TS         CHAIN     SUBMSR
098500120809     C                   IF        %FOUND(SUMUNIQUE)
098600120809     C                   MOVEL(P)  SUBDSC        O_SUBN
098700120809     C                   ENDIF
098800120809    ***
098900120809     C     KL#TSA        CHAIN     ACCMSR
099000120809     C                   IF        %FOUND(ACMUNIQUE)
099100120906     C                   MOVE      *BLANKS       @100            100
099200120809     C                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
099300120809     C                             %TRIM(ACNAM2)
099400120809     C                   MOVEL(P)  @100          O_ACCN
099500120809     C                   ENDIF
099600120809    ***
099700120809     C     KL#TSP        CHAIN     PLNMSR
099800120809     C                   IF        %FOUND(PLNUNIQUE)
099900120809     C                   EVAL      D_PLAN = %TRIM(PDESCR)
100000120809     C                   ENDIF
100100120809    ***
100200120809     C                   ENDSR
100300120808   S***S
100400120809     C     $FMTSCR3      BEGSR
100500120809    ***
100600120809     C                   SETOFF                                       3940
100700120809     C                   CLEAR                   S03MEA
100800120809     C                   EVAL      CONAME = HLD@NAME
100900120809    ***
101000120906     C                   EVAL      S3TRST = ET
101100120906     C                   EVAL      S3SUB# = ES
101200120906     C                   EVAL      S3ACCT = EA
101300120809     C                   EVAL      S3PLAN = CPPLAN
101400120809     C                   EVAL      S3CCTR = CPCCTR
101500120809     C                   EVAL      S3MAP  = AE1MAP
101600120809    ***
101700120809     C                   EXSR      $CHAINS
101800120809    ***
101900120809     C                   EVAL      S3CID2 = %TRIM(CPCID2)
102000120809     C                   EVAL      S3CID3 = %TRIM(CPCID3)
102100120809     C                   EVAL      S3CID4 = %TRIM(CPCID4)
102200120809     C                   EVAL      S3CID5 = %TRIM(CPCID5)
102300120809     C                   EVAL      S3CID6 = %TRIM(CPCID6)
102400120809    ***
102500120809     C                   ENDSR
102600120809   S***S
102700120809     C     $FMTSCR4      BEGSR
102800120809    ***
102900120809     C                   SETOFF                                       3940
103000120809     C                   CLEAR                   S04DEN
103100120809     C                   EVAL      CONAME = HLD@NAME
103200120809    ***
103300120906     C                   EVAL      S4TRST = ET
103400120906     C                   EVAL      S4SUB# = ES
103500120906     C                   EVAL      S4ACCT = EA
103600120809     C                   EVAL      S4PLAN = CPPLAN
103700120809     C                   EVAL      S4CCTR = CPCCTR
103800120809     C                   EVAL      S4MAP  = AE1MAP
103900120809    ***
104000120809     C                   EXSR      $CHAINS
104100120809    ***
104200120809     C                   EVAL      S4CID2 = %TRIM(CPCID2)
104300120809     C                   EVAL      S4CID3 = %TRIM(CPCID3)
104400120809     C                   EVAL      S4CID4 = %TRIM(CPCID4)
104500120809     C                   EVAL      S4CID5 = %TRIM(CPCID5)
104600120809     C                   EVAL      S4CID6 = %TRIM(CPCID6)
104700120809    ***
104800120809     C                   ENDSR
104900120809   S***S
105000130315     C     $FMTSCR5      BEGSR
105100130315    ***
105200130315     C                   SETOFF                                       3940
105300130315     C                   CLEAR                   S05LIF
105400130315     C                   EVAL      CONAME = HLD@NAME
105500130315    ***
105600130315     C                   EVAL      S5TRST = ET
105700130315     C                   EVAL      S5SUB# = ES
105800130315     C                   EVAL      S5ACCT = EA
105900130315     C                   EVAL      S5PLAN = CPPLAN
106000130315     C                   EVAL      S5CCTR = CPCCTR
106100130315     C                   EVAL      S5MAP  = AE1MAP
106200130315    ***
106300130315     C                   EXSR      $CHAINS
106400130315    ***
106500130315     C                   EVAL      S5CID2 = %TRIM(CPCID2)
106600130315     C                   EVAL      S5CID3 = %TRIM(CPCID3)
106700130315     C                   EVAL      S5CID4 = %TRIM(CPCID4)
106800130315     C                   EVAL      S5CID5 = %TRIM(CPCID5)
106900130315     C                   EVAL      S5CID6 = %TRIM(CPCID6)
107000130315    ***
107100130315     C                   ENDSR
107200130315   S***S
107300120809     C     $INQ2         BEGSR
107400120809    ***
107500120809     C                   EVAL      EMSG = 'INQUIRY ONLY'
107600120809     C                   EVAL      *IN40 = *ON
107700120809     C                   DOU       FKEY = F12
107800120809     C                   EXFMT     S02HMO
107900120813     C                   ENDDO
108000120809    ***
108100120809     C                   ENDSR
108200120808   S***S
108300120809     C     $INQ3         BEGSR
108400120809    ***
108500120809     C                   EVAL      EMSG = 'INQUIRY ONLY'
108600120809     C                   EVAL      *IN40 = *ON
108700120809     C                   DOU       FKEY = F12
108800120809     C                   EXFMT     S03MEA
108900120813     C                   ENDDO
109000120809    ***
109100120809     C                   ENDSR
109200120808   S***S
109300120809     C     $INQ4         BEGSR
109400120809    ***
109500120809     C                   EVAL      EMSG = 'INQUIRY ONLY'
109600120809     C                   EVAL      *IN40 = *ON
109700120809     C                   DOU       FKEY = F12
109800120809     C                   EXFMT     S04DEN
109900120813     C                   ENDDO
110000120809    ***
110100120809     C                   ENDSR
110200120808   S***S
110300130315     C     $INQ5         BEGSR
110400130315    ***
110500130315     C                   EVAL      EMSG = 'INQUIRY ONLY'
110600130315     C                   EVAL      *IN40 = *ON
110700130315     C                   DOU       FKEY = F12
110800130315     C                   EXFMT     S05LIF
110900130315     C                   ENDDO
111000130315    ***
111100130315     C                   ENDSR
111200130315   S***S
111300120809     C     $CHG2         BEGSR
111400120809    ***
111500120809     C                   EVAL      @EMSG = 'BE CAREFUL'
111600120809    ***
111700120809     C                   DOU       FKEY = F12
111800120809      *
111900120809     C                   EXSR      $SCREEN2
112000120809      *
112100120809     C                   IF        FKEY = F12
112200120813     C                   UNLOCK(E) CARPLNP
112300120813     C                   UNLOCK(E) AET001WF
112400120809     C                   SETOFF                                       3940
112500120809     C                   LEAVESR
112600120809     C                   ENDIF
112700120809      *
112800120906     C                   EVAL      KF@TRS  = ET
112900120906     C                   EVAL      KF@SUB  = ES
113000120906     C                   EVAL      KF@ACC  = EA
113100120809     C                   EVAL      KF@PLN  = S2PLAN
113200120809     C                   EVAL      KF@CCTR = S2CCTR
113300120809     C                   EVAL      KF@MAP  = S2MAP
113400120809    ***
113500120809     C                   EVAL      ADD_MODE = NO
113600120809     C                   EXSR      $VALIDKEY
113700120809     C                   IF        VALID_REC = NO
113800120809     C                   ITER
113900120809     C                   ENDIF
114000120809    ***
114100120809     C                   EXSR      $VALIDHMO
114200120809     C                   IF        VALID_REC = NO
114300120809     C                   ITER
114400120809     C                   ENDIF
114500120809    ***
114600120809     C                   SETON                                        3940
114700120809     C                   DOU       FKEY = F12 OR FKEY = F10
114800120809     C                   EXSR      $SCREEN2
114900120813    ***
115000120809     C                   IF        FKEY = F12
115100120809     C                   SETOFF                                       3940
115200120809     C                   LEAVESR
115300120809     C                   ENDIF
115400120813    ***
115500120809     C                   IF        FKEY = F10
115600120813     C                   EVAL      CPCID2 = S2CID2
115700120813     C                   EVAL      CPCID3 = S2CID3
115800120813     C                   EVAL      CPCID4 = S2CID4
115900120813     C                   EVAL      CPCCTR = S2CCTR
116000120813     C                   UPDATE    CARPLNR
116100120813     C                   EVAL      AE1MAP = S2MAP
116200120813     C                   UPDATE    AEF01
116300120813     C                   LEAVESR
116400120813     C                   ENDIF
116500120813    ***
116600120813     C                   ENDDO
116700120809    ***
116800120809     C                   ENDDO
116900120809    ***
117000120809     C                   ENDSR
117100120809   S***S
117200120813     C     $CHG3         BEGSR
117300120813    ***
117400120813     C                   EVAL      @EMSG = 'BE CAREFUL'
117500120813    ***
117600120813     C                   DOU       FKEY = F12
117700120813      *
117800120813     C                   EXSR      $SCREEN3
117900120813      *
118000120813     C                   IF        FKEY = F12
118100120813     C                   UNLOCK(E) CARPLNP
118200120813     C                   UNLOCK(E) AET001WF
118300120813     C                   SETOFF                                       3940
118400120813     C                   LEAVESR
118500120813     C                   ENDIF
118600120813      *
118700120906     C                   EVAL      KF@TRS  = ET
118800120906     C                   EVAL      KF@SUB  = ES
118900120906     C                   EVAL      KF@ACC  = EA
119000120813     C                   EVAL      KF@PLN  = S3PLAN
119100120813     C                   EVAL      KF@CCTR = S3CCTR
119200120813     C                   EVAL      KF@MAP  = S3MAP
119300120813    ***
119400120813     C                   EVAL      ADD_MODE = NO
119500120813     C                   EXSR      $VALIDKEY
119600120813     C                   IF        VALID_REC = NO
119700120813     C                   ITER
119800120813     C                   ENDIF
119900120813    ***
120000120813     C                   EXSR      $VALIDMEA
120100120813     C                   IF        VALID_REC = NO
120200120813     C                   ITER
120300120813     C                   ENDIF
120400120813    ***
120500120813     C                   SETON                                        3940
120600120813     C                   DOU       FKEY = F12 OR FKEY = F10
120700120813     C                   EXSR      $SCREEN3
120800120813     C                   IF        FKEY = F12
120900120813     C                   SETOFF                                       3940
121000120813     C                   LEAVESR
121100120813     C                   ENDIF
121200120813     C                   IF        FKEY = F10
121300120813     C                   EVAL      CPCID2 = S3CID2
121400120813     C                   EVAL      CPCID3 = S3CID3
121500120813     C                   EVAL      CPCID4 = S3CID4
121600120813     C                   EVAL      CPCID5 = S3CID5
121700120813     C                   EVAL      CPCID6 = S3CID6
121800120813     C                   EVAL      CPCCTR = S3CCTR
121900120813     C                   UPDATE    CARPLNR
122000120813     C                   EVAL      AE1MAP = S3MAP
122100120813     C                   UPDATE    AEF01
122200120813     C                   LEAVESR
122300120813     C                   ENDIF
122400120813    ***
122500120813     C                   ENDDO
122600120813    ***
122700120813     C                   ENDDO
122800120813    ***
122900120813     C                   ENDSR
123000120809   S***S
123100120813     C     $CHG4         BEGSR
123200120813    ***
123300120813     C                   EVAL      @EMSG = 'BE CAREFUL'
123400120813    ***
123500120813     C                   DOU       FKEY = F12
123600120813      *
123700120813     C                   EXSR      $SCREEN4
123800120813      *
123900120813     C                   IF        FKEY = F12
124000120813     C                   UNLOCK(E) CARPLNP
124100120813     C                   UNLOCK(E) AET001WF
124200120813     C                   SETOFF                                       3940
124300120813     C                   LEAVESR
124400120813     C                   ENDIF
124500120813      *
124600120906     C                   EVAL      KF@TRS  = ET
124700120906     C                   EVAL      KF@SUB  = ES
124800120906     C                   EVAL      KF@ACC  = EA
124900120813     C                   EVAL      KF@PLN  = S4PLAN
125000120813     C                   EVAL      KF@CCTR = S4CCTR
125100120813     C                   EVAL      KF@MAP  = S4MAP
125200120813    ***
125300120813     C                   EVAL      ADD_MODE = NO
125400120813     C                   EXSR      $VALIDKEY
125500120813     C                   IF        VALID_REC = NO
125600120813     C                   ITER
125700120813     C                   ENDIF
125800120813    ***
125900120813     C                   EXSR      $VALIDDEN
126000120813     C                   IF        VALID_REC = NO
126100120813     C                   ITER
126200120813     C                   ENDIF
126300120813    ***
126400120813     C                   SETON                                        3940
126500120813     C                   DOU       FKEY = F12 OR FKEY = F10
126600120813     C                   EXSR      $SCREEN4
126700120813     C                   IF        FKEY = F12
126800120813     C                   SETOFF                                       3940
126900120813     C                   LEAVESR
127000120813     C                   ENDIF
127100120813     C                   IF        FKEY = F10
127200120813     C                   EVAL      CPCID2 = S4CID2
127300120813     C                   EVAL      CPCID3 = S4CID3
127400120813     C                   EVAL      CPCID4 = S4CID4
127500120813     C                   EVAL      CPCID5 = S4CID5
127600120813     C                   EVAL      CPCID6 = S4CID6
127700120813     C                   EVAL      CPCCTR = S4CCTR
127800120813     C                   UPDATE    CARPLNR
127900160316     c     KL#TSAP       CHAIN     AEF01
128000120813     C                   EVAL      AE1MAP = S4MAP
128100120813     C                   UPDATE    AEF01
128200120813     C                   LEAVESR
128300120813     C                   ENDIF
128400120813    ***
128500120813     C                   ENDDO
128600120813    ***
128700120813     C                   ENDDO
128800120813    ***
128900120813     C                   ENDSR
129000120809   S***S
129100130315     C     $CHG5         BEGSR
129200130315    ***
129300130315     C                   EVAL      @EMSG = 'BE CAREFUL'
129400130315    ***
129500130315     C                   DOU       FKEY = F12
129600130315      *
129700130315     C                   EXSR      $SCREEN5
129800130315      *
129900130315     C                   IF        FKEY = F12
130000130315     C                   UNLOCK(E) CARPLNP
130100130315     C                   UNLOCK(E) AET001WF
130200130315     C                   SETOFF                                       3940
130300130315     C                   LEAVESR
130400130315     C                   ENDIF
130500130315      *
130600130315     C                   EVAL      KF@TRS  = ET
130700130315     C                   EVAL      KF@SUB  = ES
130800130315     C                   EVAL      KF@ACC  = EA
130900130315     C                   EVAL      KF@PLN  = S5PLAN
131000130315     C                   EVAL      KF@CCTR = S5CCTR
131100130315     C                   EVAL      KF@MAP  = S5MAP
131200130315    ***
131300130315     C                   EVAL      ADD_MODE = NO
131400130315     C                   EXSR      $VALIDKEY
131500130315     C                   IF        VALID_REC = NO
131600130315     C                   ITER
131700130315     C                   ENDIF
131800130315    ***
131900130315     C                   EXSR      $VALIDDEN
132000130315     C                   IF        VALID_REC = NO
132100130315     C                   ITER
132200130315     C                   ENDIF
132300130315    ***
132400130315     C                   SETON                                        3940
132500130315     C                   DOU       FKEY = F12 OR FKEY = F10
132600130315     C                   EXSR      $SCREEN5
132700130315     C                   IF        FKEY = F12
132800130315     C                   SETOFF                                       3940
132900130315     C                   LEAVESR
133000130315     C                   ENDIF
133100130315     C                   IF        FKEY = F10
133200130315     C                   EVAL      CPCID2 = S5CID2
133300130315     C                   EVAL      CPCID3 = S5CID3
133400130315     C                   EVAL      CPCID4 = S5CID4
133500130315     C                   EVAL      CPCID5 = S5CID5
133600130315     C                   EVAL      CPCID6 = S5CID6
133700130315     C                   EVAL      CPCCTR = S5CCTR
133800130315     C                   UPDATE    CARPLNR
133900130315     C                   EVAL      AE1MAP = S5MAP
134000130315     C                   UPDATE    AEF01
134100130315     C                   LEAVESR
134200130315     C                   ENDIF
134300130315    ***
134400130315     C                   ENDDO
134500130315    ***
134600130315     C                   ENDDO
134700130315    ***
134800130315     C                   ENDSR
134900130315   S***S
