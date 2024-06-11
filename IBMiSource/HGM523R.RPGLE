000100160927    *** HIGHMARK GROUP PLAN MAPPING
000200010516    ***
000300120808    *** SSK  08/08/2012
000400010516    ***
000500130315    *** 03/15/2013 SSK ADD LIFE PRODUCT TO MAPPING
000600040728    ***
000700160927     FHGM523D   CF   E             WORKSTN INFDS(WSDS) SFILE(S01SFL:RR1)
000800120808     FCARPLNP   UF A E           K DISK
000900120808     FCARPLNX   IF   E           K DISK    RENAME(CARPLNR:CPL2) PREFIX(ZZ:2)
001000130524     FCOMCTUNIQ IF   E           K DISK
001100120808     FTRMUNIQUE IF   E           K DISK
001200120808     FSUMUNIQUE IF   E           K DISK
001300120808     FACMUNIQUE IF   E           K DISK
001400120808     FPLNUNIQUE IF   E           K DISK
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
005800120906     D KF@RET          S                   LIKE(CPUNIQ)
005900160927     D                                     INZ('9000000003')
006000120808     D KF@UNIQ         S                   LIKE(CPUNIQ)
006100160927     D                                     INZ('0000000003')
006200120808     D KF@TRS          S                   LIKE(CPTRST)
006300120808     D KF@SUB          S                   LIKE(CPSUB#)
006400120808     D KF@ACC          S                   LIKE(CPACCT)
006500120808     D KF@PLN          S                   LIKE(CPPLAN)
006600120808     D KF@CCTR         S                   LIKE(CPCCTR)
006700120808    ***
006800120808     D @PROC           S             10A
006900120808    ***
007000120906     D                 DS
007100120906     D @BREAK                 01     11A
007200120906     D  ET                    01     03S 0
007300120906     D  ES                    04     06S 0
007400120906     D  EA                    07     10S 0
007500000102   X***X
007600120906    ***
007700120906     C     *ENTRY        PLIST
007800120906     C                   PARM                    @ENTRY           11
007900120906    ***
008000160927     C                   CLEAR                   S02HMK
008100120906     C                   EVAL      @BREAK = @ENTRY
008200120906     C                   EVAL      KF@TRS = ET
008300120906     C                   EVAL      KF@SUB = ES
008400120906     C                   EVAL      KF@ACC = EA
008500120906    ***
008600120808     C                   DOU       @PROC = 'EXIT APP  '
008700120813     C     @PROC         CASEQ     'PREP SFL  '  $PREPSFL
008800120813     C     @PROC         CASEQ     'BUILD SFL '  $BLDSFL
008900120813     C     @PROC         CASEQ     'SFL CONTRL'  $SFLCTL
009000160927     C     @PROC         CASEQ     'ADD HMK   '  $ADDHMK
009100120813     C     @PROC         CASEQ     'CHECK SELC'  $CHKSELC
009200000102     C                   ENDCS
009300000102     C                   ENDDO
009400000102     C*
009500000102     C                   MOVE      *ON           *INLR
009600000102     C*
009700000102   S***S
009800000102     C     *INZSR        BEGSR
009900000102    ***
010000120808     C                   EVAL      @PROC = 'PREP SFL  '
010100000102    ***
010200120808     C     KL#TS         KLIST
010300120808     C                   KFLD                    KF@TRS
010400120808     C                   KFLD                    KF@SUB
010500120808    ***
010600120808     C     KL#TSA        KLIST
010700120808     C                   KFLD                    KF@TRS
010800120808     C                   KFLD                    KF@SUB
010900120808     C                   KFLD                    KF@ACC
011000000102    ***
011100120808     C     KL#TSAP       KLIST
011200120808     C                   KFLD                    KF@TRS
011300120808     C                   KFLD                    KF@SUB
011400120808     C                   KFLD                    KF@ACC
011500120808     C                   KFLD                    KF@PLN
011600120808    ***
011700120813     C                   EVAL      HLD@NAME = XONAME
011800120813    ***
011900120808     C     KL#TSP        KLIST
012000120808     C                   KFLD                    KF@TRS
012100120808     C                   KFLD                    KF@SUB
012200120808     C                   KFLD                    KF@PLN
012300120906    ***
012400120906     C     KL#RTSACP     KLIST
012500120906     C                   KFLD                    KF@RET
012600120906     C                   KFLD                    KF@TRS
012700120906     C                   KFLD                    KF@SUB
012800120906     C                   KFLD                    KF@ACC
012900120906     C                   KFLD                    KF@CCTR
013000120906     C                   KFLD                    KF@PLN
013100120808    ***
013200120808     C     KL#UTSACP     KLIST
013300120808     C                   KFLD                    KF@UNIQ
013400120808     C                   KFLD                    KF@TRS
013500120808     C                   KFLD                    KF@SUB
013600120808     C                   KFLD                    KF@ACC
013700120808     C                   KFLD                    KF@CCTR
013800120808     C                   KFLD                    KF@PLN
013900120808    ***
014000000102     C                   ENDSR
014100000102   S***S
014200120808     C     $PREPSFL      BEGSR
014300120808    ***
014400120808     C                   MOVE      *ZEROS        RR1               4 0
014500120808     C                   MOVE      *ZEROS        #CNTREC           4 0
014600120808    ***
014700120808     C                   EVAL      *IN39 = *OFF
014800120808     C                   EVAL      *IN40 = *OFF
014900120808    ***
015000120808     C                   EVAL      @PROC = 'BUILD SFL '
015100120808    ***
015200120808     C                   ENDSR
015300120808   S***S
015400120808     C* INITIALIZE THE SUBFILE
015500120808    ***
015600120808     C     $CLRSFL       BEGSR
015700120808    ***
015800120808     C                   MOVEA     '011'         *IN(25)
015900120808     C                   WRITE     S01CTL
016000120808     C                   MOVEA     '010'         *IN(25)
016100120808     C                   Z-ADD     *ZERO         RR1
016200120808    ***
016300120808     C                   ENDSR
016400120808   S***S
016500120808     C     $BLDSFL       BEGSR
016600120808    ***
016700120808     C                   MOVE      *ZEROS        #CNTREC
016800120808     C                   MOVE      '0'           @1STLOOP          1
016900120808     C                   MOVE      '0'           @SFLOOP           1
017000120808     C                   MOVE      '0'           *IN20
017100120808    ***
017200120906     C                   EVAL      I_TRST = ET
017300120906     C                   EVAL      I_SUB# = ES
017400120906     C                   EVAL      I_ACCT = EA
017500120906    ***
017600120808     C                   EVAL      KF@PLN = I_PLAN
017700120906    ***
017800120813     C                   EXSR      $CLRSFL
017900120813     C                   EVAL      CONAME = HLD@NAME
018000120906     C     KL#TSA        CHAIN     ACCMSR
018100120906     C                   IF        NOT %FOUND(ACMUNIQUE)
018200120906     C                   EVAL      D_ACCNAME = '**ERROR**'
018300120906     C                   ELSE
018400120906     C                   EVAL      D_ACCNAME = ACNAM1
018500120906     C                   ENDIF
018600120808    ***
018700120906     C     KL#TSAP       SETLL     CPL2
018800120906    1C                   DOU       %EOF(CARPLNX)
018900120906     C     KL#TSA        READE     CPL2
019000120906    2C                   IF        NOT %EOF(CARPLNX) AND
019100120906     C                             (ZZUNIQ = KF@UNIQ OR
019200120906     C                              ZZUNIQ = KF@RET)
019300120906     C                   EXSR      $LOADSFL
019400120906    2C                   ENDIF
019500120906    1C                   ENDDO
019600120808    ***
019700120808     C                   EVAL      @PROC = 'SFL CONTRL'
019800120906    ***
019900120906     C                   ENDSR
020000120906   S***S
020100120808     C     $LOADSFL      BEGSR
020200120808    ***
020300120808     C                   MOVE      *ON           *IN25
020400120808     C                   MOVE      *BLANKS       SEL
020500120808    ***
020600120813     C                   EVAL      HUNIQ = ZZUNIQ
020700120906     C                   IF        ZZUNIQ = KF@UNIQ
020800120906     C                   EVAL      SFSTATUS = 'ACTIVE'
020900120906     C                   ELSE
021000120906     C                   EVAL      SFSTATUS = '*RETIRE*'
021100120906     C                   ENDIF
021200120906    ***
021300120813     C                   EVAL      SFPLAN = ZZPLAN
021400120813    ***
021500120813     C                   EVAL      KF@CCTR = ZZCCTR
021600120813     C                   EVAL      KF@PLN  = ZZPLAN
021700120808    ***
021800120808     C     KL#TSP        CHAIN     PLNMSR
021900120808     C                   IF        NOT %FOUND(PLNUNIQUE)
022000120808     C                   EVAL      SFPNAME = '**ERROR**'
022100120808     C                   ELSE
022200120906     C                   EVAL      SFPNAME= %TRIM(PDESCR)
022300120808     C                   ENDIF
022400120808    ***
022500120808     C                   ADD       1             RR1
022600120808     C*
022700120808    1C                   IF        @1STLOOP = '0'
022800120808     C                   Z-ADD     RR1           SFLPOS
022900120808     C                   MOVE      '1'           @1STLOOP
023000120808    1C                   ENDIF
023100120808     C*
023200120808     C                   WRITE     S01SFL
023300120808     C*
023400120808     C                   ADD       1             #CNTREC
023500120906    1C                   IF        #CNTREC = 500
023600120808     C                   MOVE      '1'           @SFLOOP
023700120808    1C                   ENDIF
023800120808    ***
023900120808     C                   ENDSR
024000120808   S***S
024100120808     C     $SFLCTL       BEGSR
024200120808    ***
024300120808     C                   EVAL      EMSG = @EMSG
024400120808    ***
024500120808     C                   WRITE     S01REC
024600120808     C                   EXFMT     S01CTL
024700120808    ***
024800120808     C                   MOVE      *BLANKS       EMSG
024900120808     C                   MOVE      *BLANKS       @EMSG
025000120808    ***
025100120808     C                   IF        FKEY = F3
025200120808     C                   EVAL      @PROC = 'EXIT APP  '
025300120808     C                   LEAVESR
025400120808     C                   ENDIF
025500120808    ***
025600120808     C                   IF        FKEY = F6
025700120808     C                   SETOFF                                       3940
025800160927     C*                  CLEAR                   S02HMK
025900120813     C                   EVAL      CONAME = HLD@NAME
026000120906     C                   EVAL      S2TRST = ET
026100120906     C                   EVAL      S2SUB# = ES
026200120906     C                   EVAL      S2ACCT = EA
026300120906     C                   EXSR      $GETTSA
026400160927     C                   EVAL      @PROC = 'ADD HMK   '
026500120808     C                   LEAVESR
026600120808     C                   ENDIF
026700150511    ***
026800120809     C                   EVAL      @PROC = 'CHECK SELC'
026900120808    ***
027000120808     C                   ENDSR
027100120808   S***S
027200160927     C     $ADDHMK       BEGSR
027300120906    ***
027400120808     C                   EXSR      $SCREEN2
027500120808    ***
027600120808     C                   IF        FKEY = F12
027700160927     C                   CLEAR                   S02HMK
027800120906     C                   EVAL      CONAME = HLD@NAME
027900120808     C                   EVAL      @PROC = 'SFL CONTRL'
028000120808     C                   LEAVESR
028100120808     C                   ENDIF
028200120808    ***
028300120906     C                   EVAL      KF@TRS  = ET
028400120906     C                   EVAL      KF@SUB  = ES
028500120906     C                   EVAL      KF@ACC  = EA
028600120808     C                   EVAL      KF@PLN  = S2PLAN
028700120808    ***
028800120809     C                   EVAL      ADD_MODE = YES
028900120808     C                   EXSR      $VALIDKEY
029000120808    ***
029100120808     C                   IF        VALID_REC = NO
029200120808     C                   LEAVESR
029300120808     C                   ENDIF
029400120809    ***
029500160927     C                   EXSR      $VALIDHMK
029600120809    ***
029700120809     C                   IF        VALID_REC = NO
029800120809     C                   LEAVESR
029900120809     C                   ENDIF
030000120808    ***
030100120808     C                   SETON                                        3940
030200120808    ***
030300120808     C                   DOU       FKEY = F12 OR FKEY = F10
030400120808      *
030500120808     C                   EXSR      $SCREEN2
030600120808      *
030700120808     C                   IF        FKEY = F12
030800120808     C                   SETOFF                                       3940
030900120808     C                   LEAVESR
031000120808     C                   ENDIF
031100120808      *
031200120808     C                   IF        FKEY = F10
031300120808     C                   EXSR      $PREPLN
031400120808     C                   EVAL      CPCID1 = 'HMO'
031500120808     C                   EVAL      CPTXT1 = 'LAYOUT CODE'
031600150611     C                   EVAL      CPCID5 = ' '
031700150611     C                   EVAL      CPTXT5 = ' '
031800150611     C                   EVAL      CPCID6 = ' '
031900150611     C                   EVAL      CPTXT6 = ' '
032000120808     C                   WRITE     CARPLNR
032100120808     C                   LEAVE
032200120808     C                   ENDIF
032300120808      *
032400120808     C                   ENDDO
032500120808    ***
032600120808     C                   EVAL      @PROC = 'SFL CONTRL'
032700120808    ***
032800120808     C                   ENDSR
032900120808   S***S
033000120808     C     $SCREEN2      BEGSR
033100120808    ***
033200120808     C                   EVAL      EMSG = @EMSG
033300160927     C                   EXFMT     S02HMK
033400120808     C                   CLEAR                   @EMSG
033500120808     C                   EVAL      EMSG = *BLANKS
033600120808    ***
033700120808     C                   ENDSR
033800130315   S***S
033900120906     C     $GETTSA       BEGSR
034000120906    ***
034100120906     C                   EVAL      KF@TRS  = ET
034200120906     C                   EVAL      KF@SUB  = ES
034300120906     C                   EVAL      KF@ACC  = EA
034400120906    ***
034500120906     C     KF@TRS        CHAIN     TRSMSR
034600120906     C                   IF        NOT %FOUND(TRMUNIQUE)
034700120906     C                   EVAL      O_TNAM = '**ERROR**'
034800120906     C                   ELSE
034900120906     C                   MOVEL(P)  TDESCR        O_TNAM
035000120906     C                   ENDIF
035100120906    ***
035200120906     C     KL#TS         CHAIN     SUBMSR
035300120906     C                   IF        NOT %FOUND(SUMUNIQUE)
035400120906     C                   EVAL      O_SUBN = '**ERROR**'
035500120906     C                   ELSE
035600120906     C                   MOVEL(P)  SUBDSC        O_SUBN
035700120906     C                   ENDIF
035800120906    ***
035900120906     C     KL#TSA        CHAIN     ACCMSR
036000120906     C                   IF        NOT %FOUND(ACMUNIQUE)
036100120906     C                   EVAL      O_ACCN = '**ERROR**'
036200120906     C                   ELSE
036300120906     C                   EVAL      O_ACCN = ACNAM1
036400120906     C                   ENDIF
036500130315    ***
036600130315     C                   MOVE      *BLANKS       D_PLAN
036700120808    ***
036800120808     C                   ENDSR
036900120808   S***S
037000120808     C     $VALIDKEY     BEGSR
037100120808    ***
037200120808     C                   EVAL      VALID_REC = NO
037300120808    ***
037400120808     C     KL#TSP        CHAIN     PLNMSR
037500120808     C                   IF        NOT %FOUND(PLNUNIQUE)
037600120808     C                   EVAL      D_PLAN = '**ERROR**'
037700120808     C                   EVAL      @EMSG = 'INVALID TRUST/SUB/PLAN'
037800120808     C                   LEAVESR
037900120808     C                   ENDIF
038000130524    ***
038100130524     C     KL#TSAP       CHAIN     COMCXR
038200130524     C                   IF        NOT %FOUND(COMCTUNIQ)
038300130524     C                   EVAL      @EMSG = 'COMMISSION CONTROL N/F'
038400130524     C                   LEAVESR
038500130524     C                   ENDIF
038600120808    ***
038700120808     C                   MOVEL(P)  PDESCR        D_PLAN
038800120808    ***
038900120809     C                   IF        ADD_MODE = YES
039000120808     C     KL#UTSACP     CHAIN     CARPLNR
039100120808     C                   IF        %FOUND(CARPLNP)
039200120808     C                   EVAL      @EMSG = 'T/S/A/P/MAP VALUE ALREADY EXISTS'
039300120808     C                   LEAVESR
039400120809     C                   ENDIF
039500120808     C                   ENDIF
039600120808    ***
039700120808     C                   EVAL      VALID_REC = YES
039800120809    ***
039900120809     C                   ENDSR
040000120809   S***S
040100160927     C     $VALIDHMK     BEGSR
040200120809    ***
040300120809     C                   EVAL      VALID_REC = NO
040400120809    ***
040500120809     C                   EVAL      VALID_REC = YES
040600120809    ***
040700120808     C                   ENDSR
040800150617   S***S
040900120808     C     $PREPLN       BEGSR
041000120808    ***
041100120808     C                   CLEAR                   CARPLNR
041200120808     C                   EVAL      CPUNIQ = KF@UNIQ
041300120906     C                   EVAL      CPTRST = ET
041400120906     C                   EVAL      CPSUB# = ES
041500120906     C                   EVAL      CPACCT = EA
041600120808     C                   EVAL      CPCCTR = KF@CCTR
041700120808     C                   EVAL      CPPLAN = KF@PLN
041800120808    ***
041900120808     C                   ENDSR
042000150511
042100150511      *============================================================================
042200150511      * Add HNO
042300150511      *============================================================================
042400130315   S***S
042500120808     C     $CHKSELC      BEGSR
042600120808    ***
042700120906     C                   IF        I_PLAN <> PRV#PLN
042800120808     C                   EVAL      PRV#PLN = I_PLAN
042900120808     C                   EVAL      @PROC = 'PREP SFL  '
043000120808     C                   LEAVESR
043100120808     C                   ENDIF
043200120808    ***
043300160927    1C                   DOU       %EOF(HGM523D)
043400120808     C                   READC     S01SFL
043500160927    2C                   IF        NOT %EOF(HGM523D)
043600120813    ***
043700120906     C                   EVAL      KF@TRS  = ET
043800120906     C                   EVAL      KF@SUB  = ES
043900120906     C                   EVAL      KF@ACC  = EA
044000120813     C                   EVAL      KF@PLN  = SFPLAN
044100120808    ***
044200120906     C                   IF        SEL = 'U'
044300120906     C     KL#RTSACP     CHAIN     CARPLNR
044400120906     C                   ELSE
044500120906     C     KL#UTSACP     CHAIN     CARPLNR
044600120906     C                   ENDIF
044700120809    ***
044800120809     C                   SELECT
044900150617      * *
045000160927     C                   WHEN      SEL = 'R'
045100160927     C                   EVAL      CPUNIQ = KF@RET
045200160927     C                   UPDATE    CARPLNR
045300160927
045400160927     C                   WHEN      SEL = 'U'
045500160927     C                   EVAL      CPUNIQ = KF@UNIQ
045600160927     C                   UPDATE    CARPLNR
045700160927
045800160927     C                   WHEN      SEL = 'I'
045900120809     C                   EXSR      $FMTSCR2
046000120809     C                   EXSR      $INQ2
046100120906      *
046200160927     C                   WHEN      SEL = 'C'
046300120809     C                   EXSR      $FMTSCR2
046400120809     C                   EXSR      $CHG2
046500130315      * *
046600120809     C                   ENDSL
046700120809    ***
046800120813    3C                   IF        @EMSG <> *BLANKS
046900120808     C                   LEAVESR
047000120808    3C                   ENDIF
047100120808     C*
047200120808     C                   MOVE      *BLANKS       SEL
047300120808     C                   UPDATE    S01SFL
047400120808     C*
047500120808    2C                   ENDIF
047600120808    1C                   ENDDO
047700120808    ***
047800120816     C                   EVAL      @PROC = 'PREP SFL  '
047900120808    ***
048000120808     C                   ENDSR
048100120808   S***S
048200120809     C     $FMTSCR2      BEGSR
048300120809    ***
048400160927
048500120809     C                   SETOFF                                       3940
048600160927     C                   CLEAR                   S02HMK
048700120809     C                   EVAL      CONAME = HLD@NAME
048800120809    ***
048900120906     C                   EVAL      S2TRST = ET
049000120906     C                   EVAL      S2SUB# = ES
049100120906     C                   EVAL      S2ACCT = EA
049200120809     C                   EVAL      S2PLAN = CPPLAN
049300120809    ***
049400120809     C                   EXSR      $CHAINS
049500120809    ***
049600120809     C                   ENDSR
049700120808   S***S
049800120809     C     $CHAINS       BEGSR
049900120809    ***
050000120809     C     KF@TRS        CHAIN     TRSMSR
050100120809     C                   IF        %FOUND(TRMUNIQUE)
050200120809     C                   MOVEL(P)  TDESCR        O_TNAM
050300120809     C                   ENDIF
050400120809    ***
050500120809     C     KL#TS         CHAIN     SUBMSR
050600120809     C                   IF        %FOUND(SUMUNIQUE)
050700120809     C                   MOVEL(P)  SUBDSC        O_SUBN
050800120809     C                   ENDIF
050900120809    ***
051000120809     C     KL#TSA        CHAIN     ACCMSR
051100120809     C                   IF        %FOUND(ACMUNIQUE)
051200120906     C                   MOVE      *BLANKS       @100            100
051300120809     C                   EVAL      @100 = %TRIM(ACNAM1) + ' ' +
051400120809     C                             %TRIM(ACNAM2)
051500120809     C                   MOVEL(P)  @100          O_ACCN
051600120809     C                   ENDIF
051700120809    ***
051800120809     C     KL#TSP        CHAIN     PLNMSR
051900120809     C                   IF        %FOUND(PLNUNIQUE)
052000120809     C                   EVAL      D_PLAN = %TRIM(PDESCR)
052100120809     C                   ENDIF
052200120809    ***
052300120809     C                   ENDSR
052400130315   S***S
052500120809     C     $INQ2         BEGSR
052600120809    ***
052700120809     C                   EVAL      EMSG = 'INQUIRY ONLY'
052800120809     C                   EVAL      *IN40 = *ON
052900120809     C                   DOU       FKEY = F12
053000160927     C                   EXFMT     S02HMK
053100120813     C                   ENDDO
053200120809    ***
053300120809     C                   ENDSR
053400120808   S***S
053500120808   S***S
053600120809     C     $INQ4         BEGSR
053700120809    ***
053800120809     C                   EVAL      EMSG = 'INQUIRY ONLY'
053900120809     C                   EVAL      *IN40 = *ON
054000120809    ***
054100120809     C                   ENDSR
054200150617
054300120809     C     $CHG2         BEGSR
054400120809    ***
054500120809     C                   EVAL      @EMSG = 'BE CAREFUL'
054600120809    ***
054700120809     C                   DOU       FKEY = F12
054800120809      *
054900120809     C                   EXSR      $SCREEN2
055000120809      *
055100120809     C                   IF        FKEY = F12
055200120813     C                   UNLOCK(E) CARPLNP
055300120809     C                   SETOFF                                       3940
055400120809     C                   LEAVESR
055500120809     C                   ENDIF
055600120809      *
055700120906     C                   EVAL      KF@TRS  = ET
055800120906     C                   EVAL      KF@SUB  = ES
055900120906     C                   EVAL      KF@ACC  = EA
056000120809     C                   EVAL      KF@PLN  = S2PLAN
056100120809    ***
056200120809     C                   EVAL      ADD_MODE = NO
056300120809     C                   EXSR      $VALIDKEY
056400120809     C                   IF        VALID_REC = NO
056500120809     C                   ITER
056600120809     C                   ENDIF
056700120809    ***
056800160927     C                   EXSR      $VALIDHMK
056900120809     C                   IF        VALID_REC = NO
057000120809     C                   ITER
057100120809     C                   ENDIF
057200120809    ***
057300120809     C                   SETON                                        3940
057400120809     C                   DOU       FKEY = F12 OR FKEY = F10
057500120809     C                   EXSR      $SCREEN2
057600120813    ***
057700120809     C                   IF        FKEY = F12
057800120809     C                   SETOFF                                       3940
057900120809     C                   LEAVESR
058000120809     C                   ENDIF
058100120813    ***
058200120809     C                   IF        FKEY = F10
058300120813     C                   UPDATE    CARPLNR
058400120813     C                   LEAVESR
058500120813     C                   ENDIF
058600120813    ***
058700120813     C                   ENDDO
058800120809    ***
058900120809     C                   ENDDO
059000120809    ***
059100120809     C                   ENDSR
059200120809   S***S
