000100120808    *** AETNA SMALL GROUP PLAN MAPPING
000200010516    ***
000300120808    *** SSK  08/08/2012
000400010516    ***
000500010516    ***
000600040728    ***
000700120808     FAET521D   CF   E             WORKSTN INFDS(WSDS) SFILE(S01SFL:RR1)
000800120808     FCARPLNP   UF A E           K DISK
000900120808     FCARPLNX   IF   E           K DISK    RENAME(CARPLNR:CPL2) PREFIX(ZZ:2)
001000120808     FTRMUNIQUE IF   E           K DISK
001100120808     FSUMUNIQUE IF   E           K DISK
001200120808     FACMUNIQUE IF   E           K DISK
001300120808     FPLNUNIQUE IF   E           K DISK
001400120808     FAET001WF  UF A E           K DISK
001500000102   X***X
001600120813     D HLD@NAME        S             40A
001700120813     D @EMSG           S                   LIKE(EMSG)
001800120813     D PRV#TRS         S                   LIKE(I_TRST)
001900120813     D PRV#SUB         S                   LIKE(I_SUB#)
002000120813     D PRV#ACC         S                   LIKE(I_ACCT)
002100120813     D PRV#PLN         S                   LIKE(I_PLAN)
002200120809     D ADD_MODE        S               N   INZ(*OFF)
002300120808     D VALID_REC       S               N   INZ(*OFF)
002400120808     D YES             S               N   INZ(*ON)
002500120808     D NO              S               N   INZ(*OFF)
002600000102    ***
002700000102     D WSDS            DS
002800000102     D  FKEY                 369    369A
002900000102    ***
003000000102     D  F1             C                   CONST(X'31')
003100000102     D  F2             C                   CONST(X'32')
003200000102     D  F3             C                   CONST(X'33')
003300000102     D  F4             C                   CONST(X'34')
003400000102     D  F5             C                   CONST(X'35')
003500000102     D  F6             C                   CONST(X'36')
003600000102     D  F7             C                   CONST(X'37')
003700000102     D  F8             C                   CONST(X'38')
003800000102     D  F9             C                   CONST(X'39')
003900000102     D  F10            C                   CONST(X'3A')
004000000102     D  F11            C                   CONST(X'3B')
004100000102     D  F12            C                   CONST(X'3C')
004200000102     D  F13            C                   CONST(X'B1')
004300000102     D  F14            C                   CONST(X'B2')
004400000102     D  F15            C                   CONST(X'B3')
004500000102     D  F16            C                   CONST(X'B4')
004600000102     D  F17            C                   CONST(X'B5')
004700000102     D  F18            C                   CONST(X'B6')
004800000102     D  F19            C                   CONST(X'B7')
004900000102     D  F20            C                   CONST(X'B8')
005000000102     D  F21            C                   CONST(X'B9')
005100000102     D  F22            C                   CONST(X'BA')
005200000102     D  F23            C                   CONST(X'BB')
005300000102     D  F24            C                   CONST(X'BC')
005400000102    ***
005500000102     D                UDS
005600120813     D  XONAME               201    240
005700000102    ***
005800120808     D KF@UNIQ         S                   LIKE(CPUNIQ)
005900120808     D                                     INZ('0000000011')
006000120808     D KF@TRS          S                   LIKE(CPTRST)
006100120808     D KF@SUB          S                   LIKE(CPSUB#)
006200120808     D KF@ACC          S                   LIKE(CPACCT)
006300120808     D KF@PLN          S                   LIKE(CPPLAN)
006400120808     D KF@CCTR         S                   LIKE(CPCCTR)
006500120808     D KF@MAP          S                   LIKE(AE1MAP)
006600120808    ***
006700120808     D @PROC           S             10A
006800120808    ***
006900000102   X***X
007000120808     C                   DOU       @PROC = 'EXIT APP  '
007100120813     C     @PROC         CASEQ     'PREP SFL  '  $PREPSFL
007200120813     C     @PROC         CASEQ     'BUILD SFL '  $BLDSFL
007300120813     C     @PROC         CASEQ     'SFL CONTRL'  $SFLCTL
007400120813     C     @PROC         CASEQ     'ADD HMO   '  $ADDHMO
007500120813     C     @PROC         CASEQ     'ADD MEA   '  $ADDMEA
007600120813     C     @PROC         CASEQ     'ADD DEN   '  $ADDDEN
007700120813     C     @PROC         CASEQ     'CHECK SELC'  $CHKSELC
007800000102     C                   ENDCS
007900000102     C                   ENDDO
008000000102     C*
008100000102     C                   MOVE      *ON           *INLR
008200000102     C*
008300000102   S***S
008400000102     C     *INZSR        BEGSR
008500000102    ***
008600120808     C                   EVAL      @PROC = 'PREP SFL  '
008700000102    ***
008800120808     C     KL#TS         KLIST
008900120808     C                   KFLD                    KF@TRS
009000120808     C                   KFLD                    KF@SUB
009100120808    ***
009200120808     C     KL#TSA        KLIST
009300120808     C                   KFLD                    KF@TRS
009400120808     C                   KFLD                    KF@SUB
009500120808     C                   KFLD                    KF@ACC
009600000102    ***
009700120808     C     KL#TSAP       KLIST
009800120808     C                   KFLD                    KF@TRS
009900120808     C                   KFLD                    KF@SUB
010000120808     C                   KFLD                    KF@ACC
010100120808     C                   KFLD                    KF@PLN
010200120808    ***
010300120813     C                   EVAL      HLD@NAME = XONAME
010400120813    ***
010500120808     C     KL#TSP        KLIST
010600120808     C                   KFLD                    KF@TRS
010700120808     C                   KFLD                    KF@SUB
010800120808     C                   KFLD                    KF@PLN
010900120808    ***
011000120808     C     KL#UTSACP     KLIST
011100120808     C                   KFLD                    KF@UNIQ
011200120808     C                   KFLD                    KF@TRS
011300120808     C                   KFLD                    KF@SUB
011400120808     C                   KFLD                    KF@ACC
011500120808     C                   KFLD                    KF@CCTR
011600120808     C                   KFLD                    KF@PLN
011700120808    ***
011800000102     C                   ENDSR
011900000102   S***S
012000120808     C     $PREPSFL      BEGSR
012100120808    ***
012200120808     C                   MOVE      *ZEROS        RR1               4 0
012300120808     C                   MOVE      *ZEROS        #CNTREC           4 0
012400120808    ***
012500120808     C                   EVAL      *IN39 = *OFF
012600120808     C                   EVAL      *IN40 = *OFF
012700120808    ***
012800120808     C                   EVAL      @PROC = 'BUILD SFL '
012900120808    ***
013000120808     C                   ENDSR
013100120808   S***S
013200120808     C* INITIALIZE THE SUBFILE
013300120808    ***
013400120808     C     $CLRSFL       BEGSR
013500120808    ***
013600120808     C                   MOVEA     '011'         *IN(25)
013700120808     C                   WRITE     S01CTL
013800120808     C                   MOVEA     '010'         *IN(25)
013900120808     C                   Z-ADD     *ZERO         RR1
014000120808    ***
014100120808     C                   ENDSR
014200120808   S***S
014300120808     C     $BLDSFL       BEGSR
014400120808    ***
014500120808     C                   MOVE      *ZEROS        #CNTREC
014600120808     C                   MOVE      '0'           @1STLOOP          1
014700120808     C                   MOVE      '0'           @SFLOOP           1
014800120808     C                   MOVE      '0'           *IN20
014900120808    ***
015000120808     C                   IF        I_TRST = 0
015100120808     C                   EVAL      KF@TRS = 001
015200120808     C                   EVAL      KF@SUB = 001
015300120808     C                   EVAL      KF@ACC = 001
015400120808     C                   EVAL      KF@PLN = *BLANKS
015500120808     C                   ELSE
015600120808     C                   EVAL      KF@TRS = I_TRST
015700120808     C                   EVAL      KF@SUB = I_SUB#
015800120808     C                   EVAL      KF@ACC = I_ACCT
015900120808     C                   EVAL      KF@PLN = I_PLAN
016000120808     C                   ENDIF
016100120813    ***
016200120813     C                   EXSR      $CLRSFL
016300120813     C                   EVAL      CONAME = HLD@NAME
016400120808    ***
016500120808     C     KL#TSAP       SETLL     CPL2
016600120808    1C                   DOU       %EOF(CARPLNX) OR @SFLOOP = '1'
016700120813     C                   READ      CPL2
016800120813    2C                   IF        NOT %EOF(CARPLNX) AND
016900120813     C                             ZZUNIQ = KF@UNIQ
017000120808     C                   EXSR      $LOADSFL
017100120808    2C                   ENDIF
017200120808    1C                   ENDDO
017300120808    ***
017400120808     C                   EVAL      @PROC = 'SFL CONTRL'
017500120808    ***
017600120808     C                   ENDSR
017700120808   S***S
017800120808     C     $LOADSFL      BEGSR
017900120808    ***
018000120808     C                   MOVE      *ON           *IN25
018100120808     C                   MOVE      *BLANKS       SEL
018200120808    ***
018300120813     C                   EVAL      HUNIQ = ZZUNIQ
018400120813     C                   EVAL      SFTRST = ZZTRST
018500120813     C                   EVAL      SFSUB# = ZZSUB#
018600120813     C                   EVAL      SFACCT = ZZACCT
018700120813     C                   EVAL      SFCCTR = ZZCCTR
018800120813     C                   EVAL      SFPLAN = ZZPLAN
018900120813    ***
019000120813     C                   EVAL      KF@TRS  = ZZTRST
019100120813     C                   EVAL      KF@SUB  = ZZSUB#
019200120813     C                   EVAL      KF@ACC  = ZZACCT
019300120813     C                   EVAL      KF@CCTR = ZZCCTR
019400120813     C                   EVAL      KF@PLN  = ZZPLAN
019500120808    ***
019600120808     C     KL#TSAP       CHAIN     AEF01
019700120808     C                   IF        NOT %FOUND(AET001WF)
019800120808     C                   EVAL      SFMAP = '**ERROR**'
019900120808     C                   ELSE
020000120808     C                   EVAL      SFMAP = AE1MAP
020100120808     C                   ENDIF
020200120808    ***
020300120808     C     KL#TSA        CHAIN     ACCMSR
020400120808     C                   IF        NOT %FOUND(ACMUNIQUE)
020500120808     C                   EVAL      SFANAME = '**ERROR**'
020600120808     C                   ELSE
020700120808     C                   MOVE      *BLANKS       @100            100
020800120808     C                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
020900120808     C                             %TRIM(ACNAM2)
021000120808     C                   MOVEL(P)  @100          SFANAME
021100120808     C                   ENDIF
021200120808    ***
021300120808     C     KL#TSP        CHAIN     PLNMSR
021400120808     C                   IF        NOT %FOUND(PLNUNIQUE)
021500120808     C                   EVAL      SFPNAME = '**ERROR**'
021600120808     C                   ELSE
021700120813     C                   EVALR     SFPNAME= %TRIM(PDESCR)
021800120808     C                   ENDIF
021900120808    ***
022000120808     C                   ADD       1             RR1
022100120808     C*
022200120808    1C                   IF        @1STLOOP = '0'
022300120808     C                   Z-ADD     RR1           SFLPOS
022400120808     C                   MOVE      '1'           @1STLOOP
022500120808    1C                   ENDIF
022600120808     C*
022700120808     C                   WRITE     S01SFL
022800120808     C*
022900120808     C                   ADD       1             #CNTREC
023000120813    1C                   IF        #CNTREC = 400
023100120808     C                   MOVE      '1'           @SFLOOP
023200120808    1C                   ENDIF
023300120808    ***
023400120808     C                   ENDSR
023500120808   S***S
023600120808     C     $SFLCTL       BEGSR
023700120808    ***
023800120808     C                   EVAL      EMSG = @EMSG
023900120808    ***
024000120808     C                   WRITE     S01REC
024100120808     C                   EXFMT     S01CTL
024200120808    ***
024300120808     C                   MOVE      *BLANKS       EMSG
024400120808     C                   MOVE      *BLANKS       @EMSG
024500120808    ***
024600120808     C                   IF        FKEY = F3
024700120808     C                   EVAL      @PROC = 'EXIT APP  '
024800120808     C                   LEAVESR
024900120808     C                   ENDIF
025000120808    ***
025100120808     C                   IF        FKEY = F6
025200120808     C                   SETOFF                                       3940
025300120808     C                   CLEAR                   S02HMO
025400120813     C                   EVAL      CONAME = HLD@NAME
025500120808     C                   EVAL      @PROC = 'ADD HMO   '
025600120808     C                   LEAVESR
025700120808     C                   ENDIF
025800120808    ***
025900120808     C                   IF        FKEY = F7
026000120813     C                   SETOFF                                       3940
026100120813     C                   CLEAR                   S02HMO
026200120813     C                   EVAL      CONAME = HLD@NAME
026300120808     C                   EVAL      @PROC = 'ADD MEA   '
026400120808     C                   LEAVESR
026500120808     C                   ENDIF
026600120808    ***
026700120808     C                   IF        FKEY = F8
026800120813     C                   SETOFF                                       3940
026900120813     C                   CLEAR                   S02HMO
027000120813     C                   EVAL      CONAME = HLD@NAME
027100120808     C                   EVAL      @PROC = 'ADD DEN   '
027200120808     C                   LEAVESR
027300120808     C                   ENDIF
027400120808    ***
027500120809     C                   EVAL      @PROC = 'CHECK SELC'
027600120808    ***
027700120808     C                   ENDSR
027800120808   S***S
027900120808     C     $ADDHMO       BEGSR
028000120808    ***
028100120808     C                   EXSR      $SCREEN2
028200120808    ***
028300120808     C                   IF        FKEY = F12
028400120808     C                   CLEAR                   S02HMO
028500120808     C                   EVAL      CONAME = HLD@NAME
028600120808     C                   EVAL      @PROC = 'SFL CONTRL'
028700120808     C                   LEAVESR
028800120808     C                   ENDIF
028900120808    ***
029000120808     C                   EVAL      KF@TRS  = S2TRST
029100120808     C                   EVAL      KF@SUB  = S2SUB#
029200120808     C                   EVAL      KF@ACC  = S2ACCT
029300120808     C                   EVAL      KF@PLN  = S2PLAN
029400120808     C                   EVAL      KF@CCTR = S2CCTR
029500120808     C                   EVAL      KF@MAP  = S2MAP
029600120808    ***
029700120809     C                   EVAL      ADD_MODE = YES
029800120808     C                   EXSR      $VALIDKEY
029900120808    ***
030000120808     C                   IF        VALID_REC = NO
030100120808     C                   LEAVESR
030200120808     C                   ENDIF
030300120809    ***
030400120809     C                   EXSR      $VALIDHMO
030500120809    ***
030600120809     C                   IF        VALID_REC = NO
030700120809     C                   LEAVESR
030800120809     C                   ENDIF
030900120808    ***
031000120808     C                   SETON                                        3940
031100120808    ***
031200120808     C                   DOU       FKEY = F12 OR FKEY = F10
031300120808      *
031400120808     C                   EXSR      $SCREEN2
031500120808      *
031600120808     C                   IF        FKEY = F12
031700120808     C                   SETOFF                                       3940
031800120808     C                   LEAVESR
031900120808     C                   ENDIF
032000120808      *
032100120808     C                   IF        FKEY = F10
032200120808     C                   EXSR      $PREPLN
032300120808     C                   EVAL      CPCID1 = 'HMO'
032400120808     C                   EVAL      CPTXT1 = 'LAYOUT CODE'
032500120808     C                   EVAL      CPCID2 = S2CID2
032600120808     C                   EVAL      CPTXT2 = 'FILE NUMBER'
032700120808     C                   EVAL      CPCID3 = S2CID3
032800120808     C                   EVAL      CPTXT3 = 'CLASS CODE'
032900120808     C                   EVAL      CPCID4 = S2CID4
033000120808     C                   EVAL      CPTXT4 = 'PLAN'
033100120808     C                   EVAL      CPCID5 = 'N/A'
033200120808     C                   EVAL      CPTXT5 = 'N/A'
033300120808     C                   EVAL      CPCID6 = 'N/A'
033400120808     C                   EVAL      CPTXT6 = 'N/A'
033500120808     C                   WRITE     CARPLNR
033600120808     C                   LEAVE
033700120808     C                   ENDIF
033800120808      *
033900120808     C                   ENDDO
034000120808    ***
034100120808     C                   EVAL      @PROC = 'SFL CONTRL'
034200120808    ***
034300120808     C                   ENDSR
034400120808   S***S
034500120808     C     $SCREEN2      BEGSR
034600120808    ***
034700120808     C                   EVAL      EMSG = @EMSG
034800120808     C                   EXFMT     S02HMO
034900120808     C                   CLEAR                   @EMSG
035000120808     C                   EVAL      EMSG = *BLANKS
035100120808    ***
035200120808     C                   ENDSR
035300120808   S***S
035400120808     C     $SCREEN3      BEGSR
035500120808    ***
035600120808     C                   EVAL      EMSG = @EMSG
035700120808     C                   EXFMT     S03MEA
035800120808     C                   CLEAR                   @EMSG
035900120808     C                   EVAL      EMSG = *BLANKS
036000120808    ***
036100120808     C                   ENDSR
036200120808   S***S
036300120808     C     $SCREEN4      BEGSR
036400120808    ***
036500120808     C                   EVAL      EMSG = @EMSG
036600120808     C                   EXFMT     S04DEN
036700120808     C                   CLEAR                   @EMSG
036800120808     C                   EVAL      EMSG = *BLANKS
036900120808    ***
037000120808     C                   ENDSR
037100120808   S***S
037200120808     C     $VALIDKEY     BEGSR
037300120808    ***
037400120808     C                   EVAL      VALID_REC = NO
037500120808    ***
037600120808     C                   IF        KF@TRS = 0
037700120808     C                   EVAL      @EMSG = 'MISSING TRUST'
037800120808     C                   LEAVESR
037900120808     C                   ENDIF
038000120808    ***
038100120808     C     KF@TRS        CHAIN     TRSMSR
038200120808     C                   IF        NOT %FOUND(TRMUNIQUE)
038300120808     C                   EVAL      O_TNAM = '**ERROR**'
038400120808     C                   EVAL      @EMSG = 'INVALID TRUST'
038500120808     C                   LEAVESR
038600120808     C                   ENDIF
038700120808    ***
038800120808     C                   MOVEL(P)  TDESCR        O_TNAM
038900120808    ***
039000120808     C                   IF        KF@SUB = 0
039100120808     C                   EVAL      @EMSG = 'MISSING SUBDIVISION'
039200120808     C                   LEAVESR
039300120808     C                   ENDIF
039400120808    ***
039500120808     C     KL#TS         CHAIN     SUBMSR
039600120808     C                   IF        NOT %FOUND(SUMUNIQUE)
039700120808     C                   EVAL      O_SUBN = '**ERROR**'
039800120808     C                   EVAL      @EMSG = 'INVALID TRUST/SUBDIVISION'
039900120808     C                   LEAVESR
040000120808     C                   ENDIF
040100120808    ***
040200120808     C                   MOVEL(P)  SUBDSC        O_SUBN
040300120808    ***
040400120808     C                   IF        KF@ACC = 0
040500120808     C                   EVAL      @EMSG = 'MISSING ACCOUNT'
040600120808     C                   LEAVESR
040700120808     C                   ENDIF
040800120808    ***
040900120808     C     KL#TSA        CHAIN     ACCMSR
041000120808     C                   IF        NOT %FOUND(ACMUNIQUE)
041100120808     C                   EVAL      O_ACCN = '**ERROR**'
041200120808     C                   EVAL      @EMSG = 'INVALID TRUST/SUB/ACCOUNT'
041300120808     C                   LEAVESR
041400120808     C                   ENDIF
041500120808    ***
041600120808     C                   MOVE      *BLANKS       @100
041700120808     C                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
041800120808     C                             %TRIM(ACNAM2)
041900120808     C                   MOVEL(P)  @100          O_ACCN
042000120808    ***
042100120808     C                   IF        KF@PLN = *BLANKS
042200120808     C                   EVAL      @EMSG = 'MISSING PLAN'
042300120808     C                   LEAVESR
042400120808     C                   ENDIF
042500120808    ***
042600120808     C     KL#TSP        CHAIN     PLNMSR
042700120808     C                   IF        NOT %FOUND(PLNUNIQUE)
042800120808     C                   EVAL      D_PLAN = '**ERROR**'
042900120808     C                   EVAL      @EMSG = 'INVALID TRUST/SUB/PLAN'
043000120808     C                   LEAVESR
043100120808     C                   ENDIF
043200120808    ***
043300120808     C                   MOVEL(P)  PDESCR        D_PLAN
043400120808    ***
043500120808     C                   IF        KF@MAP = *BLANKS
043600120808     C                   EVAL      @EMSG = 'MISSING MAP'
043700120808     C                   LEAVESR
043800120808     C                   ENDIF
043900120808    ***
044000120808     C                   IF        KF@MAP <> '2TIER     ' AND
044100120808     C                             KF@MAP <> 'TIERSTS   ' AND
044200120808     C                             KF@MAP <> 'STATETIER ' AND
044300120808     C                             KF@MAP <> 'EMPSTS    ' AND
044400120808     C                             KF@MAP <> 'ITOBJECTS ' AND
044500120808     C                             KF@MAP <> 'JUSTSTATE ' AND
044600120808     C                             KF@MAP <> 'STSTATE   ' AND
044700130123     C                             KF@MAP <> 'STIERSTS  ' AND
044800120808     C                             KF@MAP <> 'CREATIVE  ' AND
044900120808     C                             KF@MAP <> 'JOHNLS    ' AND
045000120808     C                             KF@MAP <> 'INTEGRA   ' AND
045100120808     C                             KF@MAP <> 'MAYOR     ' AND
045200120808     C                             KF@MAP <> 'NORULE    '
045300120808     C                   EVAL      @EMSG = 'INVALID MAP; REFER TO MAP DOCUMENT'
045400120808     C                   LEAVESR
045500120808     C                   ENDIF
045600120808    ***
045700120808     C                   IF        KF@MAP <> 'NORULE' AND
045800120808     C                             KF@CCTR = *BLANKS
045900120808     C                   EVAL      @EMSG = 'MISSING MAPPING VALUE'
046000120808     C                   LEAVESR
046100120808     C                   ENDIF
046200120808    ***
046300120809     C                   IF        ADD_MODE = YES
046400120808     C     KL#UTSACP     CHAIN     CARPLNR
046500120808     C                   IF        %FOUND(CARPLNP)
046600120808     C                   EVAL      @EMSG = 'T/S/A/P/MAP VALUE ALREADY EXISTS'
046700120808     C                   LEAVESR
046800120809     C                   ENDIF
046900120808     C                   ENDIF
047000120808    ***
047100120808     C                   EVAL      VALID_REC = YES
047200120809    ***
047300120809     C                   ENDSR
047400120809   S***S
047500120809     C     $VALIDHMO     BEGSR
047600120809    ***
047700120809     C                   EVAL      VALID_REC = NO
047800120809    ***
047900120809     C                   IF        S2CID2 = *BLANKS
048000120809     C                   EVAL      @EMSG = 'FILE NUMBER IS REQUIRED'
048100120809     C                   LEAVESR
048200120809     C                   ENDIF
048300120808    ***
048400120809     C                   IF        S2CID3 = *BLANKS
048500120809     C                   EVAL      @EMSG = 'CLASS CODE IS REQUIRED'
048600120809     C                   LEAVESR
048700120809     C                   ENDIF
048800120809    ***
048900120809     C                   IF        S2CID4 = *BLANKS
049000120809     C                   EVAL      @EMSG = 'PLAN NUMBER IS REQUIRED'
049100120809     C                   LEAVESR
049200120809     C                   ENDIF
049300120809    ***
049400120809     C                   EVAL      VALID_REC = YES
049500120809    ***
049600120808     C                   ENDSR
049700120808   S***S
049800120808     C     $PREPLN       BEGSR
049900120808    ***
050000120808     C     KL#TSAP       CHAIN     AET001WF
050100120808     C                   IF        NOT %FOUND(AET001WF)
050200120808     C                   CLEAR                   AEF01
050300120808     C                   EVAL      AE1TRS = KF@TRS
050400120808     C                   EVAL      AE1SUB = KF@SUB
050500120808     C                   EVAL      AE1ACC = KF@ACC
050600120808     C                   EVAL      AE1PLN = KF@PLN
050700120808     C                   EVAL      AE1MAP = KF@MAP
050800120808     C                   WRITE(E)  AEF01
050900120808     C                   ENDIF
051000120808    ***
051100120808     C                   CLEAR                   CARPLNR
051200120808     C                   EVAL      CPUNIQ = KF@UNIQ
051300120808     C                   EVAL      CPTRST = KF@TRS
051400120808     C                   EVAL      CPSUB# = KF@SUB
051500120808     C                   EVAL      CPACCT = KF@ACC
051600120808     C                   EVAL      CPCCTR = KF@CCTR
051700120808     C                   EVAL      CPPLAN = KF@PLN
051800120808    ***
051900120808     C                   ENDSR
052000120808   S***S
052100120808     C     $ADDMEA       BEGSR
052200120808    ***
052300120808     C                   EXSR      $SCREEN3
052400120808    ***
052500120808     C                   IF        FKEY = F12
052600120808     C                   CLEAR                   S03MEA
052700120808     C                   EVAL      CONAME = HLD@NAME
052800120808     C                   EVAL      @PROC = 'SFL CONTRL'
052900120808     C                   LEAVESR
053000120808     C                   ENDIF
053100120808    ***
053200120808     C                   EVAL      KF@TRS  = S3TRST
053300120808     C                   EVAL      KF@SUB  = S3SUB#
053400120808     C                   EVAL      KF@ACC  = S3ACCT
053500120808     C                   EVAL      KF@PLN  = S3PLAN
053600120808     C                   EVAL      KF@CCTR = S3CCTR
053700120808     C                   EVAL      KF@MAP  = S3MAP
053800120808    ***
053900120809     C                   EVAL      ADD_MODE = YES
054000120808     C                   EXSR      $VALIDKEY
054100120808    ***
054200120808     C                   IF        VALID_REC = NO
054300120808     C                   LEAVESR
054400120808     C                   ENDIF
054500120809    ***
054600120809     C                   EXSR      $VALIDMEA
054700120808    ***
054800120809     C                   IF        VALID_REC = NO
054900120809     C                   LEAVESR
055000120809     C                   ENDIF
055100120809    ***
055200120808     C                   SETON                                        3940
055300120808    ***
055400120808     C                   DOU       FKEY = F12 OR FKEY = F10
055500120808      *
055600120808     C                   EXSR      $SCREEN3
055700120808      *
055800120808     C                   IF        FKEY = F12
055900120808     C                   SETOFF                                       3940
056000120808     C                   LEAVESR
056100120808     C                   ENDIF
056200120808      *
056300120808     C                   IF        FKEY = F10
056400120808     C                   EXSR      $PREPLN
056500120808     C                   EVAL      CPCID1 = 'MEA'
056600120808     C                   EVAL      CPTXT1 = 'LAYOUT CODE'
056700120808     C                   EVAL      CPCID2 = S3CID2
056800120808     C                   EVAL      CPTXT2 = 'ELR'
056900120808     C                   EVAL      CPCID3 = S3CID3
057000120808     C                   EVAL      CPTXT3 = 'SUFFIX'
057100120808     C                   EVAL      CPCID4 = S3CID4
057200120808     C                   EVAL      CPTXT4 = 'ACCOUNT'
057300120808     C                   EVAL      CPCID5 = S3CID5
057400120808     C                   EVAL      CPTXT5 = 'PLAN'
057500120808     C                   EVAL      CPCID6 = S3CID6
057600120808     C                   EVAL      CPTXT6 = 'CLAIM OFFICE'
057700120808     C                   WRITE     CARPLNR
057800120808     C                   LEAVE
057900120808     C                   ENDIF
058000120808      *
058100120808     C                   ENDDO
058200120808    ***
058300120808     C                   EVAL      @PROC = 'SFL CONTRL'
058400120808    ***
058500120808     C                   ENDSR
058600120809   S***S
058700120809     C     $VALIDMEA     BEGSR
058800120809    ***
058900120809     C                   EVAL      VALID_REC = NO
059000120809    ***
059100120809     C                   IF        S3CID2 = *BLANKS
059200120809     C                   EVAL      @EMSG = 'ELR IS REQUIRED'
059300120809     C                   LEAVESR
059400120809     C                   ENDIF
059500120809    ***
059600120809     C                   IF        S3CID3 = *BLANKS
059700120809     C                   EVAL      @EMSG = 'SUFFIX IS REQUIRED'
059800120809     C                   LEAVESR
059900120809     C                   ENDIF
060000120809    ***
060100120809     C                   IF        S3CID4 = *BLANKS
060200120809     C                   EVAL      @EMSG = 'ACCOUNT IS REQUIRED'
060300120809     C                   LEAVESR
060400120809     C                   ENDIF
060500120809    ***
060600120809     C                   IF        S3CID5 = *BLANKS
060700120809     C                   EVAL      @EMSG = 'PLAN IS REQUIRED'
060800120809     C                   LEAVESR
060900120809     C                   ENDIF
061000120809    ***
061100120809     C                   IF        S3CID6 = *BLANKS
061200120809     C                   EVAL      @EMSG = 'CLAIM OFFICE IS REQUIRED'
061300120809     C                   LEAVESR
061400120809     C                   ENDIF
061500120809    ***
061600120809     C                   EVAL      VALID_REC = YES
061700120809    ***
061800120809     C                   ENDSR
061900120809   S***S
062000120808     C     $ADDDEN       BEGSR
062100120808    ***
062200120808     C                   EXSR      $SCREEN4
062300120808    ***
062400120808     C                   IF        FKEY = F12
062500120808     C                   CLEAR                   S04DEN
062600120808     C                   EVAL      CONAME = HLD@NAME
062700120808     C                   EVAL      @PROC = 'SFL CONTRL'
062800120808     C                   LEAVESR
062900120808     C                   ENDIF
063000120808    ***
063100120808     C                   EVAL      KF@TRS  = S4TRST
063200120808     C                   EVAL      KF@SUB  = S4SUB#
063300120808     C                   EVAL      KF@ACC  = S4ACCT
063400120808     C                   EVAL      KF@PLN  = S4PLAN
063500120808     C                   EVAL      KF@CCTR = S4CCTR
063600120808     C                   EVAL      KF@MAP  = S4MAP
063700120808    ***
063800120809     C                   EVAL      ADD_MODE = YES
063900120808     C                   EXSR      $VALIDKEY
064000120808    ***
064100120808     C                   IF        VALID_REC = NO
064200120808     C                   LEAVESR
064300120808     C                   ENDIF
064400120808    ***
064500120809     C                   EXSR      $VALIDDEN
064600120809    ***
064700120809     C                   IF        VALID_REC = NO
064800120809     C                   LEAVESR
064900120809     C                   ENDIF
065000120809    ***
065100120808     C                   SETON                                        3940
065200120808    ***
065300120808     C                   DOU       FKEY = F12 OR FKEY = F10
065400120808      *
065500120808     C                   EXSR      $SCREEN4
065600120808      *
065700120808     C                   IF        FKEY = F12
065800120808     C                   SETOFF                                       3940
065900120808     C                   LEAVESR
066000120808     C                   ENDIF
066100120808      *
066200120808     C                   IF        FKEY = F10
066300120808     C                   EXSR      $PREPLN
066400120808     C                   EVAL      CPCID1 = 'DEN'
066500120808     C                   EVAL      CPTXT1 = 'LAYOUT CODE'
066600120808     C                   EVAL      CPCID2 = S4CID2
066700120808     C                   EVAL      CPTXT2 = 'ELR'
066800120808     C                   EVAL      CPCID3 = S4CID3
066900120808     C                   EVAL      CPTXT3 = 'SUFFIX'
067000120808     C                   EVAL      CPCID4 = S4CID4
067100120808     C                   EVAL      CPTXT4 = 'ACCOUNT'
067200120808     C                   EVAL      CPCID5 = S4CID5
067300120808     C                   EVAL      CPTXT5 = 'PLAN'
067400120808     C                   EVAL      CPCID6 = S4CID6
067500120808     C                   EVAL      CPTXT6 = 'CLAIM OFFICE'
067600120808     C                   WRITE     CARPLNR
067700120808     C                   LEAVE
067800120808     C                   ENDIF
067900120808      *
068000120808     C                   ENDDO
068100120808    ***
068200120808     C                   EVAL      @PROC = 'SFL CONTRL'
068300120808    ***
068400120808     C                   ENDSR
068500120808   S***S
068600120809     C     $VALIDDEN     BEGSR
068700120809    ***
068800120809     C                   EVAL      VALID_REC = NO
068900120809    ***
069000120809     C                   IF        S4CID2 = *BLANKS
069100120809     C                   EVAL      @EMSG = 'ELR IS REQUIRED'
069200120809     C                   LEAVESR
069300120809     C                   ENDIF
069400120809    ***
069500120809     C                   IF        S4CID3 = *BLANKS
069600120809     C                   EVAL      @EMSG = 'SUFFIX IS REQUIRED'
069700120809     C                   LEAVESR
069800120809     C                   ENDIF
069900120809    ***
070000120809     C                   IF        S4CID4 = *BLANKS
070100120809     C                   EVAL      @EMSG = 'ACCOUNT IS REQUIRED'
070200120809     C                   LEAVESR
070300120809     C                   ENDIF
070400120809    ***
070500120809     C                   IF        S4CID5 = *BLANKS
070600120809     C                   EVAL      @EMSG = 'PLAN IS REQUIRED'
070700120809     C                   LEAVESR
070800120809     C                   ENDIF
070900120809    ***
071000120809     C                   IF        S4CID6 = *BLANKS
071100120809     C                   EVAL      @EMSG = 'CLAIM OFFICE IS REQUIRED'
071200120809     C                   LEAVESR
071300120809     C                   ENDIF
071400120809    ***
071500120809     C                   EVAL      VALID_REC = YES
071600120809    ***
071700120809     C                   ENDSR
071800120809   S***S
071900120808     C     $CHKSELC      BEGSR
072000120808    ***
072100120808     C                   IF        I_TRST <> PRV#TRS OR
072200120808     C                             I_SUB# <> PRV#SUB OR
072300120808     C                             I_ACCT <> PRV#ACC OR
072400120808     C                             I_PLAN <> PRV#PLN
072500120808     C                   EVAL      PRV#TRS = I_TRST
072600120808     C                   EVAL      PRV#SUB = I_SUB#
072700120808     C                   EVAL      PRV#ACC = I_ACCT
072800120808     C                   EVAL      PRV#PLN = I_PLAN
072900120808     C                   EVAL      @PROC = 'PREP SFL  '
073000120808     C                   LEAVESR
073100120808     C                   ENDIF
073200120808    ***
073300120808    1C                   DOU       %EOF(AET521D)
073400120808     C                   READC     S01SFL
073500120808    2C                   IF        NOT %EOF(AET521D)
073600120813    ***
073700120813     C                   EVAL      KF@TRS  = SFTRST
073800120813     C                   EVAL      KF@SUB  = SFSUB#
073900120813     C                   EVAL      KF@ACC  = SFACCT
074000120813     C                   EVAL      KF@PLN  = SFPLAN
074100120813     C                   EVAL      KF@CCTR = SFCCTR
074200120813     C                   EVAL      KF@MAP  = SFMAP
074300120808    ***
074400120808     C     KL#UTSACP     CHAIN     CARPLNR
074500120809     C     KL#TSAP       CHAIN     AET001WF
074600120809    ***
074700120809     C                   SELECT
074800120809     C                   WHEN      CPCID1 = 'HMO' AND SEL = 'I'
074900120809     C                   EXSR      $FMTSCR2
075000120809     C                   EXSR      $INQ2
075100120809     C                   WHEN      CPCID1 = 'HMO' AND SEL = 'C'
075200120809     C                   EXSR      $FMTSCR2
075300120809     C                   EXSR      $CHG2
075400120809     C                   WHEN      CPCID1 = 'MEA' AND SEL = 'I'
075500120809     C                   EXSR      $FMTSCR3
075600120809     C                   EXSR      $INQ3
075700120809     C                   WHEN      CPCID1 = 'MEA' AND SEL = 'C'
075800120809     C                   EXSR      $FMTSCR3
075900120809     C                   EXSR      $CHG3
076000120809     C                   WHEN      CPCID1 = 'DEN' AND SEL = 'I'
076100120809     C                   EXSR      $FMTSCR4
076200120809     C                   EXSR      $INQ4
076300120809     C                   WHEN      CPCID1 = 'DEN' AND SEL = 'C'
076400120809     C                   EXSR      $FMTSCR4
076500120809     C                   EXSR      $CHG4
076600120809     C                   ENDSL
076700120809    ***
076800120813    3C                   IF        @EMSG <> *BLANKS
076900120808     C                   LEAVESR
077000120808    3C                   ENDIF
077100120808     C*
077200120808     C                   MOVE      *BLANKS       SEL
077300120808     C                   UPDATE    S01SFL
077400120808     C*
077500120808    2C                   ENDIF
077600120808    1C                   ENDDO
077700120808    ***
077800120816     C                   EVAL      @PROC = 'PREP SFL  '
077900120808    ***
078000120808     C                   ENDSR
078100120808   S***S
078200120809     C     $FMTSCR2      BEGSR
078300120809    ***
078400120809     C                   SETOFF                                       3940
078500120809     C                   CLEAR                   S02HMO
078600120809     C                   EVAL      CONAME = HLD@NAME
078700120809    ***
078800120809     C                   EVAL      S2TRST = CPTRST
078900120809     C                   EVAL      S2SUB# = CPSUB#
079000120809     C                   EVAL      S2ACCT = CPACCT
079100120809     C                   EVAL      S2PLAN = CPPLAN
079200120809     C                   EVAL      S2CCTR = CPCCTR
079300120809     C                   EVAL      S2MAP  = AE1MAP
079400120809    ***
079500120809     C                   EXSR      $CHAINS
079600120809    ***
079700120809     C                   EVAL      S2CID2 = %TRIM(CPCID2)
079800120809     C                   EVAL      S2CID3 = %TRIM(CPCID3)
079900120809     C                   EVAL      S2CID4 = %TRIM(CPCID4)
080000120809    ***
080100120809     C                   ENDSR
080200120808   S***S
080300120809     C     $CHAINS       BEGSR
080400120809    ***
080500120809     C     KF@TRS        CHAIN     TRSMSR
080600120809     C                   IF        %FOUND(TRMUNIQUE)
080700120809     C                   MOVEL(P)  TDESCR        O_TNAM
080800120809     C                   ENDIF
080900120809    ***
081000120809     C     KL#TS         CHAIN     SUBMSR
081100120809     C                   IF        %FOUND(SUMUNIQUE)
081200120809     C                   MOVEL(P)  SUBDSC        O_SUBN
081300120809     C                   ENDIF
081400120809    ***
081500120809     C     KL#TSA        CHAIN     ACCMSR
081600120809     C                   IF        %FOUND(ACMUNIQUE)
081700120809     C                   MOVE      *BLANKS       @100
081800120809     C                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
081900120809     C                             %TRIM(ACNAM2)
082000120809     C                   MOVEL(P)  @100          O_ACCN
082100120809     C                   ENDIF
082200120809    ***
082300120809     C     KL#TSP        CHAIN     PLNMSR
082400120809     C                   IF        %FOUND(PLNUNIQUE)
082500120809     C                   EVAL      D_PLAN = %TRIM(PDESCR)
082600120809     C                   ENDIF
082700120809    ***
082800120809     C                   ENDSR
082900120808   S***S
083000120809     C     $FMTSCR3      BEGSR
083100120809    ***
083200120809     C                   SETOFF                                       3940
083300120809     C                   CLEAR                   S03MEA
083400120809     C                   EVAL      CONAME = HLD@NAME
083500120809    ***
083600120809     C                   EVAL      S3TRST = CPTRST
083700120809     C                   EVAL      S3SUB# = CPSUB#
083800120809     C                   EVAL      S3ACCT = CPACCT
083900120809     C                   EVAL      S3PLAN = CPPLAN
084000120809     C                   EVAL      S3CCTR = CPCCTR
084100120809     C                   EVAL      S3MAP  = AE1MAP
084200120809    ***
084300120809     C                   EXSR      $CHAINS
084400120809    ***
084500120809     C                   EVAL      S3CID2 = %TRIM(CPCID2)
084600120809     C                   EVAL      S3CID3 = %TRIM(CPCID3)
084700120809     C                   EVAL      S3CID4 = %TRIM(CPCID4)
084800120809     C                   EVAL      S3CID5 = %TRIM(CPCID5)
084900120809     C                   EVAL      S3CID6 = %TRIM(CPCID6)
085000120809    ***
085100120809     C                   ENDSR
085200120809   S***S
085300120809     C     $FMTSCR4      BEGSR
085400120809    ***
085500120809     C                   SETOFF                                       3940
085600120809     C                   CLEAR                   S04DEN
085700120809     C                   EVAL      CONAME = HLD@NAME
085800120809    ***
085900120809     C                   EVAL      S4TRST = CPTRST
086000120809     C                   EVAL      S4SUB# = CPSUB#
086100120809     C                   EVAL      S4ACCT = CPACCT
086200120809     C                   EVAL      S4PLAN = CPPLAN
086300120809     C                   EVAL      S4CCTR = CPCCTR
086400120809     C                   EVAL      S4MAP  = AE1MAP
086500120809    ***
086600120809     C                   EXSR      $CHAINS
086700120809    ***
086800120809     C                   EVAL      S4CID2 = %TRIM(CPCID2)
086900120809     C                   EVAL      S4CID3 = %TRIM(CPCID3)
087000120809     C                   EVAL      S4CID4 = %TRIM(CPCID4)
087100120809     C                   EVAL      S4CID5 = %TRIM(CPCID5)
087200120809     C                   EVAL      S4CID6 = %TRIM(CPCID6)
087300120809    ***
087400120809     C                   ENDSR
087500120809   S***S
087600120809     C     $INQ2         BEGSR
087700120809    ***
087800120809     C                   EVAL      EMSG = 'INQUIRY ONLY'
087900120809     C                   EVAL      *IN40 = *ON
088000120809     C                   DOU       FKEY = F12
088100120809     C                   EXFMT     S02HMO
088200120813     C                   ENDDO
088300120809    ***
088400120809     C                   ENDSR
088500120808   S***S
088600120809     C     $INQ3         BEGSR
088700120809    ***
088800120809     C                   EVAL      EMSG = 'INQUIRY ONLY'
088900120809     C                   EVAL      *IN40 = *ON
089000120809     C                   DOU       FKEY = F12
089100120809     C                   EXFMT     S03MEA
089200120813     C                   ENDDO
089300120809    ***
089400120809     C                   ENDSR
089500120808   S***S
089600120809     C     $INQ4         BEGSR
089700120809    ***
089800120809     C                   EVAL      EMSG = 'INQUIRY ONLY'
089900120809     C                   EVAL      *IN40 = *ON
090000120809     C                   DOU       FKEY = F12
090100120809     C                   EXFMT     S04DEN
090200120813     C                   ENDDO
090300120809    ***
090400120809     C                   ENDSR
090500120808   S***S
090600120809     C     $CHG2         BEGSR
090700120809    ***
090800120809     C                   EVAL      @EMSG = 'BE CAREFUL'
090900120809    ***
091000120809     C                   DOU       FKEY = F12
091100120809      *
091200120809     C                   EXSR      $SCREEN2
091300120809      *
091400120809     C                   IF        FKEY = F12
091500120813     C                   UNLOCK(E) CARPLNP
091600120813     C                   UNLOCK(E) AET001WF
091700120809     C                   SETOFF                                       3940
091800120809     C                   LEAVESR
091900120809     C                   ENDIF
092000120809      *
092100120809     C                   EVAL      KF@TRS  = S2TRST
092200120809     C                   EVAL      KF@SUB  = S2SUB#
092300120809     C                   EVAL      KF@ACC  = S2ACCT
092400120809     C                   EVAL      KF@PLN  = S2PLAN
092500120809     C                   EVAL      KF@CCTR = S2CCTR
092600120809     C                   EVAL      KF@MAP  = S2MAP
092700120809    ***
092800120809     C                   EVAL      ADD_MODE = NO
092900120809     C                   EXSR      $VALIDKEY
093000120809     C                   IF        VALID_REC = NO
093100120809     C                   ITER
093200120809     C                   ENDIF
093300120809    ***
093400120809     C                   EXSR      $VALIDHMO
093500120809     C                   IF        VALID_REC = NO
093600120809     C                   ITER
093700120809     C                   ENDIF
093800120809    ***
093900120809     C                   SETON                                        3940
094000120809     C                   DOU       FKEY = F12 OR FKEY = F10
094100120809     C                   EXSR      $SCREEN2
094200120813    ***
094300120809     C                   IF        FKEY = F12
094400120809     C                   SETOFF                                       3940
094500120809     C                   LEAVESR
094600120809     C                   ENDIF
094700120813    ***
094800120809     C                   IF        FKEY = F10
094900120813     C                   EVAL      CPCID2 = S2CID2
095000120813     C                   EVAL      CPCID3 = S2CID3
095100120813     C                   EVAL      CPCID4 = S2CID4
095200120813     C                   EVAL      CPCCTR = S2CCTR
095300120813     C                   UPDATE    CARPLNR
095400120813     C                   EVAL      AE1MAP = S2MAP
095500120813     C                   UPDATE    AEF01
095600120813     C                   LEAVESR
095700120813     C                   ENDIF
095800120813    ***
095900120813     C                   ENDDO
096000120809    ***
096100120809     C                   ENDDO
096200120809    ***
096300120809     C                   ENDSR
096400120809   S***S
096500120813     C     $CHG3         BEGSR
096600120813    ***
096700120813     C                   EVAL      @EMSG = 'BE CAREFUL'
096800120813    ***
096900120813     C                   DOU       FKEY = F12
097000120813      *
097100120813     C                   EXSR      $SCREEN3
097200120813      *
097300120813     C                   IF        FKEY = F12
097400120813     C                   UNLOCK(E) CARPLNP
097500120813     C                   UNLOCK(E) AET001WF
097600120813     C                   SETOFF                                       3940
097700120813     C                   LEAVESR
097800120813     C                   ENDIF
097900120813      *
098000120813     C                   EVAL      KF@TRS  = S3TRST
098100120813     C                   EVAL      KF@SUB  = S3SUB#
098200120813     C                   EVAL      KF@ACC  = S3ACCT
098300120813     C                   EVAL      KF@PLN  = S3PLAN
098400120813     C                   EVAL      KF@CCTR = S3CCTR
098500120813     C                   EVAL      KF@MAP  = S3MAP
098600120813    ***
098700120813     C                   EVAL      ADD_MODE = NO
098800120813     C                   EXSR      $VALIDKEY
098900120813     C                   IF        VALID_REC = NO
099000120813     C                   ITER
099100120813     C                   ENDIF
099200120813    ***
099300120813     C                   EXSR      $VALIDMEA
099400120813     C                   IF        VALID_REC = NO
099500120813     C                   ITER
099600120813     C                   ENDIF
099700120813    ***
099800120813     C                   SETON                                        3940
099900120813     C                   DOU       FKEY = F12 OR FKEY = F10
100000120813     C                   EXSR      $SCREEN3
100100120813     C                   IF        FKEY = F12
100200120813     C                   SETOFF                                       3940
100300120813     C                   LEAVESR
100400120813     C                   ENDIF
100500120813     C                   IF        FKEY = F10
100600120813     C                   EVAL      CPCID2 = S3CID2
100700120813     C                   EVAL      CPCID3 = S3CID3
100800120813     C                   EVAL      CPCID4 = S3CID4
100900120813     C                   EVAL      CPCID5 = S3CID5
101000120813     C                   EVAL      CPCID6 = S3CID6
101100120813     C                   EVAL      CPCCTR = S3CCTR
101200120813     C                   UPDATE    CARPLNR
101300120813     C                   EVAL      AE1MAP = S3MAP
101400120813     C                   UPDATE    AEF01
101500120813     C                   LEAVESR
101600120813     C                   ENDIF
101700120813    ***
101800120813     C                   ENDDO
101900120813    ***
102000120813     C                   ENDDO
102100120813    ***
102200120813     C                   ENDSR
102300120809   S***S
102400120813     C     $CHG4         BEGSR
102500120813    ***
102600120813     C                   EVAL      @EMSG = 'BE CAREFUL'
102700120813    ***
102800120813     C                   DOU       FKEY = F12
102900120813      *
103000120813     C                   EXSR      $SCREEN4
103100120813      *
103200120813     C                   IF        FKEY = F12
103300120813     C                   UNLOCK(E) CARPLNP
103400120813     C                   UNLOCK(E) AET001WF
103500120813     C                   SETOFF                                       3940
103600120813     C                   LEAVESR
103700120813     C                   ENDIF
103800120813      *
103900120813     C                   EVAL      KF@TRS  = S4TRST
104000120813     C                   EVAL      KF@SUB  = S4SUB#
104100120813     C                   EVAL      KF@ACC  = S4ACCT
104200120813     C                   EVAL      KF@PLN  = S4PLAN
104300120813     C                   EVAL      KF@CCTR = S4CCTR
104400120813     C                   EVAL      KF@MAP  = S4MAP
104500120813    ***
104600120813     C                   EVAL      ADD_MODE = NO
104700120813     C                   EXSR      $VALIDKEY
104800120813     C                   IF        VALID_REC = NO
104900120813     C                   ITER
105000120813     C                   ENDIF
105100120813    ***
105200120813     C                   EXSR      $VALIDDEN
105300120813     C                   IF        VALID_REC = NO
105400120813     C                   ITER
105500120813     C                   ENDIF
105600120813    ***
105700120813     C                   SETON                                        3940
105800120813     C                   DOU       FKEY = F12 OR FKEY = F10
105900120813     C                   EXSR      $SCREEN4
106000120813     C                   IF        FKEY = F12
106100120813     C                   SETOFF                                       3940
106200120813     C                   LEAVESR
106300120813     C                   ENDIF
106400120813     C                   IF        FKEY = F10
106500120813     C                   EVAL      CPCID2 = S4CID2
106600120813     C                   EVAL      CPCID3 = S4CID3
106700120813     C                   EVAL      CPCID4 = S4CID4
106800120813     C                   EVAL      CPCID5 = S4CID5
106900120813     C                   EVAL      CPCID6 = S4CID6
107000120813     C                   EVAL      CPCCTR = S4CCTR
107100120813     C                   UPDATE    CARPLNR
107200120813     C                   EVAL      AE1MAP = S4MAP
107300120813     C                   UPDATE    AEF01
107400120813     C                   LEAVESR
107500120813     C                   ENDIF
107600120813    ***
107700120813     C                   ENDDO
107800120813    ***
107900120813     C                   ENDDO
108000120813    ***
108100120813     C                   ENDSR
108200120809   S***S
