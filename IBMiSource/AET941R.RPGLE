000100160302      *=========================================================================
000200160302     H option(*noDebugIo)
000300160302      *=================================================================================
000400160302
000500160329      *  CARRIER CONTROL ID #0000000127 AETNA SPECIFIC
000600160329      *  SSK 05.13.2011 TEMPLATE DESIGN
000700160329      *
000800160329      *  08.17.2014 CLONED FROM AET084R
000900160329      *
001000160315      *=================================================================================
001100160315
001200151217     FCARXPTP   IF   E           K DISK
001300151217      * Carrier export control master
001400151217
001500101012     FCARACCP   IF   E           K DISK
001600151217      * Carrier export control by account
001700151217
001800101012     FCARPLNP   IF   E           K DISK
001900151217      * Carrier export control by plan
002000151217
002100160329     FAET004WF  IF   E           K DISK
002200160329      * MAPPING METHOD
002300151217
002400160302     FAET940WF  O  A F 1231        DISK
002500160329      * FLAT FILE
002600151217
002700160302     FAET941WF  IF A E           K DISK
002800160329      * TERM TRACKER
002900151217
003000101012     FMEMAC#1   IF   E           K DISK
003100151217
003200101012     FMCOVMPLN  IF   E           K DISK
003300151217
003400101012     FDEPNDC    IF   E           K DISK
003500151217
003600101012     FDCOVA     IF   E           K DISK
003700151217
003800140313     FPCPL1     IF   E           K DISK
003900151217
004000120803     D KF@CCTL         S             10A   INZ
004100160302     D*CARR#CTL        S             10A   INZ('0000000135')
004200160315     D*CARR#CTL2       S             10A   INZ('0000000051')
004300160315
004400160315     D CARR#CTL        S             10A
004500160302     D grouper         S             10A
004600160315
004700160302     D H@RI            S             25A   INZ('042064683')                     RECEIVER ID
004800151217
004900110512     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
005000101026     D DS@CARACC     E DS                  EXTNAME(CARACCP)
005100130315     D*DS@CARXPT     E DS                  EXTNAME(CARXPTP)
005200151217
005300160329      *=================================================================================
005400160329      * WORK ARRAY FOR PLANS
005500160329      *=================================================================================
005600160329
005700160329      * PC# - PLAN COUNT
005800160329      * PP# - PLAN POINTER
005900160329      *
006000110512     D CARPLN@       E DS                  EXTNAME(CARPLNP)
006100160329     D                                     OCCURS(120) PREFIX(X:1)
006200160329     D PC#             S              4S 0
006300160329     D PP#             S              4S 0
006400110512     D @PLANIN         S              4A
006500110512     D @CCTRIN         S              3A
006600160329
006700160329      * WRITE TYPE = MEMBER OR DEPEND
006800110513     D WRT@TYPE        S              6A
006900160329
007000101214     D #XST            S              6S 0
007100101214     D #IST            S               T
007200101026     D #ISO            S               D   DATFMT(*ISO)
007300101214     D #MINUEND        S               D   DATFMT(*ISO)
007400101214     D #SUBTRAEND      S               D   DATFMT(*ISO)
007500101214     D @DATE           S              8A
007600101214     D @TIME           S              6A
007700101214     D #DIFFRNC        S              5S 0
007800101214     D #2S0            S              2S 0
007900101214     D #CANCEL         S              8S 0
008000101026     D #XSX            S              8S 0
008100101026     D #XSX2           S              8S 0
008200101026     D DATE@OUT        S             10A
008300101026     D ENR@IN          S              3A
008400101026     D ENR@OUT         S              1A
008500110524     D DNTLATE         S              1A
008600130315     D TERM_LIF        S               N
008700101214     D TERM_DEN        S               N
008800101214     D TERM_MED        S               N
008900101026     D YES             S               N   INZ(*ON)
009000101026     D NO              S               N   INZ(*OFF)
009100160315
009200160315     D firstTime       S              1    INZ('Y')
009300160329
009400110512     D KF@TRS          S                   LIKE(MCTRST)
009500110512     D KF@SUB          S                   LIKE(MCSUB#)
009600110512     D KF@ACC          S                   LIKE(ACC#)
009700101026     D KF@ENR          S              3A   INZ
009800101026     D KF@CARG         S              2A   INZ
009900101026     D KF@CCTR         S                   LIKE(CCFLG)
010000101026     D KF@PLN          S                   LIKE(MCPLAN)
010100101026     D KF@TRM          S                   LIKE(NTTERMDT)
010200101026     D KF#TRM          S              8S 0
010300101026     D KF@SSN          S                   LIKE(MBSSNO)
010400101026     D KF@SEQ          S                   LIKE(DPSEQ#)
010500101026     D KF@TYP          S              1A
010600101026     D KF@CDE          S              2A
010700140313     D KF@SPCD         S              5A
010800140313     D KF@MPLN         S              4A
010900160329
011000101026     D M@EARLYP        S              4A
011100101026     D M#EARLYE        S              8S 0 INZ
011200101026     D M#EARLYT        S              8S 0 INZ
011300160329
011400101026     D #8D1            S              8S 0 INZ
011500101214     D D1              S              8A
011600101214     D D2              S              8A
011700101214     D T1              S              6A
011800101214     D C1              S             14A
011900160329
012000101029     D B#RECCNT        S             10S 0 INZ
012100101029     D C#RECCNT        S             10S 0 INZ
012200160329
012300101210     D @SS1            S              9A
012400101210     D @SS2            S              9A
012500101210     D @FN             S             15A
012600101210     D @MI             S              1A
012700101210     D @LN             S             20A
012800101210     D @REL            S              2A
012900101210     D @SEX            S              1A
013000101210     D @DOB            S              8A
013100101210     D @SPEC           S              1A
013200101210     D @COB            S              1A
013300101210     D @COBC           S              2A
013400101210     D @COBN           S             20A
013500101210     D @AD1            S             30A
013600101210     D @AD2            S             30A
013700101214     D @CTY            S             20A
013800101210     D @ST             S              2A
013900101210     D @ZP5            S              5A
014000101210     D @PHN            S             10A
014100101210     D @EMPST          S              2A
014200101210     D @HIRE           S              8A
014300160329
014400160329      * LIFE ARRAYS
014500130315     D L#CNE           S              3S 0 INZ
014600130315     D L#NDX           S              3S 0 INZ
014700130315     D L@PLN           S              4A   DIM(20)
014800130315     D L@ENR           S              3A   DIM(20)
014900130315     D L@FRM           S              8S 0 DIM(20)
015000130315     D L@TRM           S              8S 0 DIM(20)
015100130315     D L@MBREFF        S              8S 0
015200160329
015300160329      * DENTAL ARRAYS
015400101206     D D#CNE           S              3S 0 INZ
015500101206     D D#NDX           S              3S 0 INZ
015600101206     D D@PLN           S              4A   DIM(20)
015700101206     D D@ENR           S              3A   DIM(20)
015800101206     D D@FRM           S              8S 0 DIM(20)
015900101206     D D@TRM           S              8S 0 DIM(20)
016000110725     D D@MBREFF        S              8S 0
016100160329
016200160329      * MEDICAL ARRAYS
016300101206     D M#CNE           S              3S 0 INZ
016400101206     D M#NDX           S              3S 0 INZ
016500101206     D M@PLN           S              4A   DIM(20)
016600101206     D M@ENR           S              3A   DIM(20)
016700101206     D M@FRM           S              8S 0 DIM(20)
016800101206     D M@TRM           S              8S 0 DIM(20)
016900110725     D M@MBREFF        S              8S 0
017000160329
017100101206     D H@SI            S             20A
017200101206     D H@CC            S              2A
017300101206     D H@GN            S              7A
017400101206     D H@CN            S             15A
017500101206     D H@C#            S              7A
017600130319     D H@C#3           S              7A
017700160329
017800101213     D X@LAY           S              3A
017900101213     D X@ELR           S              7A
018000140313     D X@EFF           S              8A
018100140313     D X@TRM           S              8A
018200140313     D X@TIER          S              1A
018300160329
018400101213     D M@CC            S              2A
018500101213     D M@CLASS         S              5A
018600101213     D M@PLAN          S              6A
018700101213     D M@PCP           S             40A
018800101213     D M@NPI           S              1A
018900101213     D M@PCPCI         S              1A
019000160329
019100101213     D D@SFX           S              3A
019200101213     D D@ACCT          S              5A
019300101213     D D@PLAN          S              6A
019400101213     D D@CLM           S              3A
019500101213     D D@CBREXP        S              8A
019600101213     D D@CBREVT        S              8A
019700101213     D D@CBRLEN        S              2A
019800101213     D D@OOAI          S              1A
019900140313     D D@PCD           S              7A
020000160329
020100160329     D @STEP           S              8A
020200160329
020300140313     D E@SFX           S              3A
020400140313     D E@ACCT          S              5A
020500140313     D E@PLAN          S              6A
020600140313     D E@CLM           S              3A
020700140313     D E@PCP           S              7A
020800140313     D E@CBREXP        S              8A
020900140313     D E@CBREVT        S              8A
021000140313     D E@CBRLEN        S              2A
021100160329
021200130315     D L@SFX           S              3A
021300130315     D L@ACCT          S              5A
021400130315     D L@PLAN          S              6A
021500130315     D L@CLM           S              3A
021600130315     D L@CBREXP        S              8A
021700130315     D L@CBREVT        S              8A
021800130315     D L@CBRLEN        S              2A
021900130315     D L@SALARY        S             20A
022000160329
022100160329      *========================================================================
022200160329
022300160329     C                   EVAL      @STEP = 'READEACC'
022400160329
022500120803     C                   EVAL      KF@CCTL = CARR#CTL
022600151217     C     KF@CCTL       CHAIN     CARXPTR
022700160315     C****               EXSR      $HEADR
022800160329
022900120803     C     KF@CCTL       SETLL     CARACCR
023000160329
023100101026     C                   DOU       @STEP = 'LEAVE'
023200160329     C     @STEP         CASEQ     'READEACC'    ReadEAcc
023300160329     C     @STEP         CASEQ     'SETLLMEM'    SetllMem
023400160329     C     @STEP         CASEQ     'READEMEM'    ReadEMem
023500160329     C     @STEP         CASEQ     'READEMCO'    ReadEMCo
023600160329     C     @STEP         CASEQ     'PREP4   '    $PREP4
023700160329     C     @STEP         CASEQ     'STEP4   '    $STEP4
023800160329     C     @STEP         CASEQ     'PREP5   '    $PREP5
023900160329     C     @STEP         CASEQ     'STEP5   '    $STEP5
024000160329     C     @STEP         CASEQ     'PREP6   '    $PREP6
024100160329     C     @STEP         CASEQ     'STEP6   '    $STEP6
024200160329     C     @STEP         CASEQ     'PREP7   '    $PREP7
024300160329     C     @STEP         CASEQ     'STEP7   '    $STEP7
024400160329     C     @STEP         CASEQ     'STEP8   '    $STEP8
024500160329     C     @STEP         CASEQ     'PREP9   '    $PREP9
024600160329     C     @STEP         CASEQ     'STEP9   '    $STEP9
024700160329     C     @STEP         CASEQ     'PREPA   '    $PREPA
024800160329     C     @STEP         CASEQ     'STEPA   '    $STEPA
024900160329     C     @STEP         CASEQ     'PREPB   '    $PREPB
025000160329     C     @STEP         CASEQ     'STEPB   '    $STEPB
025100160329     C     @STEP         CASEQ     'PREPC   '    $PREPC
025200160329     C     @STEP         CASEQ     'STEPC   '    $STEPC
025300101026     C                   ENDCS
025400101026     C                   ENDDO
025500160329
025600160329      * TRAILER RECORD
025700101026     C                   ADD       2             C#RECCNT
025800101214     C                   MOVE      C#RECCNT      @TREC            10 0
025900101214     C                   MOVE      B#RECCNT      @BREC            10 0
026000101214     C                   EXCEPT    TRLF
026100160329
026200101026     C                   EVAL      *INLR = *ON
026300160329
026400110802     C     $HEADR        BEGSR
026500160329
026600110802     C                   EVAL      D1 = @DATE
026700110802     C                   EVAL      D2 = @DATE
026800110802     C                   EVAL      T1 = @TIME
026900110802     C                   EVAL      C1 = @DATE + @TIME
027000160329
027100160315     C**** carr#ctl      CHAIN     CARACCR
027200160329
027300110802     C                   EVAL      H@SI = %TRIM(CACID1)                         SUBMITTER ID
027400110802     C                   EVAL      H@CC = %SUBST(CACID2:1:2)                    COMPANY CODE
027500110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
027600110802     C                   MOVEL(P)  CACID4        H@CN                           CUSTOMER NAME
027700110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
027800130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
027900160329
028000110802     C                   EXCEPT    HDRF
028100160315
028200160315     C                   eval      firstTime = 'N'
028300160329
028400110802     C                   ENDSR
028500160329
028600160329      *========================================================================
028700160329      * Reade ACC
028800160329      *========================================================================
028900160329
029000160329     C     ReadEAcc      BEGSR
029100160329
029200120803     C     KF@CCTL       READE     CARACCR
029300160329
029400110512     C                   IF        %EOF(CARACCP)
029500120803      *
029600160329     C****               IF        KF@CCTL = CARR#CTL
029700160329     C****               EVAL      KF@CCTL = CARR#CTL2
029800160329     C**** KF@CCTL       SETLL     CARACCR
029900160329     C***                ELSE
030000110512     C                   EVAL      @STEP = 'LEAVE'
030100160329     C****               ENDIF
030200160329
030300110512     C                   LEAVESR
030400110512     C                   ENDIF
030500160329
030600160329      * HAS THE ACCOUNT BEEN SHUTOFF FOR EXPORT?
030700110512     C                   IF        CASTATUS <> 'Y'
030800110512     C                   LEAVESR
030900110512     C                   ENDIF
031000160329
031100160302     C                   if        cacida <> grouper
031200160302     C                   leavesr
031300160302     C                   endif
031400160315
031500160315     c                   if        firstTime = 'Y'
031600160315     c                   exsr      $headr
031700160315     c                   endif
031800160302
031900160329      * THESE FIELDS RESET FOR EACH SMALL GROUP READ
032000110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
032100110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
032200130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
032300160329
032400110512     C                   EVAL      KF@TRS = CATRST
032500110512     C                   EVAL      KF@SUB = CASUB#
032600110512     C                   EVAL      KF@ACC = CAACCT
032700160329
032800110512     C                   EXSR      $PLANLOAD
032900160329
033000160329     C                   EVAL      @STEP = 'SETLLMEM'
033100160329
033200110512     C                   ENDSR
033300160329
033400160329      *=========================================================================
033500160329      * Setll MEMBER
033600160329      *=========================================================================
033700160329
033800160329     C     setllmem      BEGSR
033900101206     C                   EVAL      KF@PLN = *BLANKS
034000101206     C                   EVAL      KF@TRM = 0
034100101206     C                   EVAL      KF@SSN = 0
034200101206     C                   EVAL      KF@SEQ = 0
034300160329
034400101206     C     KL#TSA        SETLL     MEMBR
034500160329
034600160329     C                   EVAL      @STEP = 'READEMEM'
034700160329
034800101206     C                   ENDSR
034900160329
035000160329      *=========================================================================
035100160329      * Reade MEMBER
035200160329      *=========================================================================
035300160329
035400160329     C     reademem      BEGSR
035500160329
035600101206     C     KL#TSA        READE     MEMBR
035700160329
035800101206     C                   IF        %EOF(MEMAC#1)
035900160329     C                   EVAL      @STEP = 'READEACC'
036000101206     C                   LEAVESR
036100101206     C                   ENDIF
036200160329
036300101206     C                   EVAL      KF@SSN = MBSSNO
036400101214     C                   MOVE      *ZEROS        KF@SEQ
036500120803     C                   EVAL      WRT@TYPE = 'MEMBER'
036600160329
036700101206     C     KL#MPLN       SETLL     MCOVR
036800160329
036900101206     C                   EXSR      $CLRSTG
037000160329
037100160329     C                   EVAL      @STEP = 'READEMCO'
037200160329
037300101206     C                   ENDSR
037400160329
037500160329      *=========================================================================
037600160329      * Reade Member Coverage
037700160329      *=========================================================================
037800160329
037900160329     C     ReadEMCo      BEGSR
038000160329
038100101206     C     KL#MPLN       READE     MCOVR
038200160329
038300101206     C                   IF        %EOF(MCOVMPLN)
038400101206     C                   EVAL      @STEP = 'PREP4'
038500101206     C                   LEAVESR
038600101206     C                   ENDIF
038700160329
038800160329     C****               IF        ENRLDT = CANDT
038900160329     C****               LEAVESR
039000160329     C****               ENDIF
039100160329
039200120803     C                   EVAL      KF@PLN = MCPLAN
039300160329     C     KL#TSAP       CHAIN     AEF04
039400160329     C                   IF        NOT %FOUND(AET004WF)
039500120803     C                   LEAVESR
039600120803     C                   ENDIF
039700160329
039800110512     C                   EVAL      @PLANIN = MCPLAN
039900111020     C                   EVAL      ENR@IN = MCOVTP
040000160329
040100110802     C                   EXSR      $QUIK
040200160329
040300110512     C                   EXSR      $PLANSRCH
040400160329
040500110512     C                   IF        PLN@CAT = *BLANKS
040600110512     C                   LEAVESR
040700110512     C                   ENDIF
040800160329
040900101206     C                   IF        CANDT = 0
041000101206     C                   EVAL      #CANCEL = 99999999
041100101206     C                   ELSE
041200101206     C                   EVAL      #CANCEL = CANDT
041300101206     C                   ENDIF
041400160329
041500160329      * DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL; LIF IS LIFE
041600160329
041700130315     C                   SELECT
041800160329
041900160329     C                   WHEN      PLN@CAT = 'LIFE'
042000160329     C                   IF        L#CNE > 0
042100160329     C                   IF        L@TRM(L#CNE) = 99999999
042200130315     C                   LEAVESR
042300130315     C                   ENDIF
042400130315     C                   ENDIF
042500160329     C                   ADD       1             L#CNE
042600160329     C                   EVAL      L@PLN(L#CNE) = MCPLAN
042700160329     C                   EVAL      L@ENR(L#CNE) = MCOVTP
042800160329     C                   EVAL      L@FRM(L#CNE) = ENRLDT
042900160329     C                   EVAL      L@TRM(L#CNE) = #CANCEL
043000160329
043100160329     C                   WHEN      PLN@CAT = 'DEN'
043200160329     C                   IF        D#CNE > 0
043300160329     C                   IF        D@TRM(D#CNE) = 99999999
043400130131     C                   LEAVESR
043500130131     C                   ENDIF
043600130131     C                   ENDIF
043700160329     C                   ADD       1             D#CNE
043800160329     C                   EVAL      D@PLN(D#CNE) = MCPLAN
043900160329     C                   EVAL      D@ENR(D#CNE) = MCOVTP
044000160329     C                   EVAL      D@FRM(D#CNE) = ENRLDT
044100160329     C                   EVAL      D@TRM(D#CNE) = #CANCEL
044200160329
044300130315     C                   OTHER
044400160329     C                   IF        M#CNE > 0
044500160329     C                   IF        M@TRM(M#CNE) = 99999999
044600130131     C                   LEAVESR
044700130131     C                   ENDIF
044800130131     C                   ENDIF
044900101206     C                   ADD       1             M#CNE
045000101206     C                   EVAL      M@PLN(M#CNE) = MCPLAN
045100101206     C                   EVAL      M@ENR(M#CNE) = MCOVTP
045200101206     C                   EVAL      M@FRM(M#CNE) = ENRLDT
045300101206     C                   EVAL      M@TRM(M#CNE) = #CANCEL
045400160329
045500160329     C                   ENDSL
045600160329
045700110512     C                   ENDSR
045800160329
045900160329      *=======================================================================
046000160329      *
046100160329      *=======================================================================
046200160329
046300110802     C     $QUIK         BEGSR
046400160329
046500110805     C                   EVAL      @CCTRIN = *BLANKS
046600160329
046700160329     C     AE4MAP        CASEQ     '2TIER     '  $METH01
046800160329     C     AE4MAP        CASEQ     'ITOBJECTS '  $METH02
046900160329     C     AE4MAP        CASEQ     'NORULE    '  $METH03
047000160329     C     AE4MAP        CASEQ     'STATETIER '  $METH04
047100160329     C     AE4MAP        CASEQ     'TIERSTS   '  $METH05
047200160329     C     AE4MAP        CASEQ     'MAYOR     '  $METH06
047300160329     C     AE4MAP        CASEQ     'EMPSTS    '  $METH07
047400160329     C     AE4MAP        CASEQ     'JUSTSTATE '  $METH08
047500160329     C     AE4MAP        CASEQ     'JOHNLS    '  $METH09
047600160329     C     AE4MAP        CASEQ     'CREATIVE  '  $METH10
047700160329     C     AE4MAP        CASEQ     'INTEGRA   '  $METH11
047800160329     C     AE4MAP        CASEQ     'STSTATE   '  $METH12
047900160329     C     AE4MAP        CASEQ     'INTEGRA   '  $METH11
048000160329     C     AE4MAP        CASEQ     'STIERSTS  '  $METH13
048100120803     C                   ENDCS
048200160329
048300120803     C                   ENDSR
048400160329      *========================================================================
048500160329
048600160329      * 2 TIER = AETNA HAS TWO TIERS, IND AND FAM
048700160329      *  MEMBERS HAVE 'TIN' CONVERTED TO 'IND' AND NON-'TIN' CONVERTED TO 'FAM'
048800160329      *  DEPENDENTS HAVE 'FAM' ONLY
048900160329      *
049000160329      * IND, FAM
049100160329
049200160329      *========================================================================
049300160329
049400120803     C     $METH01       BEGSR
049500160329
049600120803     C                   IF        WRT@TYPE = 'MEMBER'
049700160329
049800120803     C                   IF        ENR@IN = 'TIN'
049900120803     C                   EVAL      @CCTRIN = 'IND'
050000120803     C                   ELSE
050100120803     C                   EVAL      @CCTRIN = 'FAM'
050200120803     C                   ENDIF
050300160329
050400120803     C                   ENDIF
050500160329
050600120803     C                   IF        WRT@TYPE = 'DEPEND'
050700160329
050800120803     C                   EVAL      @CCTRIN = 'FAM'
050900160329
051000120803     C                   ENDIF
051100160329
051200120803     C                   ENDSR
051300160329
051400120803    *** ITOBJECTS = IF YOU ARE NOT 'VA' OR 'OH' STATE CODES, YOU ARE 'XX'
051500120803    ***
051600120803    *** VA, OH, XX
051700120803    ***
051800120803     C     $METH02       BEGSR
051900120803    ***
052000120803     C                   IF        STATE <> 'VA' AND STATE <> 'OH'
052100120803     C                   EVAL      @CCTRIN = 'XX '
052200120803     C                   ELSE
052300120803     C                   EVAL      @CCTRIN = STATE
052400120803     C                   ENDIF
052500120803    ***
052600120803     C                   ENDSR
052700120803   S***S
052800120803    *** NORULE = NUFF SAID
052900120803    ***
053000120803     C     $METH03       BEGSR
053100120803    ***
053200120803     C                   EVAL      @CCTRIN = *BLANKS
053300120803    ***
053400120803     C                   ENDSR
053500120803   S***S
053600120803    *** STATETIER
053700120803    ***  START WITH STATE CODE
053800120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
053900120803    ***  DEPENDENTS HAVE 'F' ONLY
054000120803    ***
054100120803    *** MDI, MDF, ETC...
054200120803    ***
054300120803     C     $METH04       BEGSR
054400120803    ***
054500120803     C                   EVAL      @CCTRIN = STATE
054600120803    ***
054700120803     C                   IF        WRT@TYPE = 'MEMBER'
054800120803     C                   IF        ENR@IN = 'TIN'
054900120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
055000120803     C                   ELSE
055100120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
055200120803     C                   ENDIF
055300120803     C                   ENDIF
055400120803    ***
055500120803     C                   IF        WRT@TYPE = 'DEPEND'
055600120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
055700120803     C                   ENDIF
055800120803    ***
055900120803     C                   ENDSR
056000120803   S***S
056100120803    *** TIERSTS
056200120803    ***  START WITH EMPLOYMENT STATUS, ACTIVE IS 'ACT' AND COBRA IS 'COB'
056300120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
056400120803    ***  DEPENDENTS HAVE 'F' ONLY
056500120803    ***
056600120803    *** ACI, ACF, COI, COF
056700120803    ***
056800120803     C     $METH05       BEGSR
056900120803    ***
057000120803     C                   IF        EMPST =  'C'
057100120803     C                   EVAL      @CCTRIN = 'COB'
057200120803     C                   ELSE
057300120803     C                   EVAL      @CCTRIN = 'ACT'
057400120803     C                   ENDIF
057500120803    ***
057600120803     C                   IF        ENR@IN = 'TIN'
057700120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
057800120803     C                   ELSE
057900120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
058000120803     C                   ENDIF
058100120803    ***
058200120803     C                   ENDSR
058300120803   S***S
058400120803    *** MAYOR
058500120803    ***  WELL, FOR THE PLAN 'DAAU' IF THE STATE IS 'WV' THEN PLACE TIER STATUS SUFFIX
058600120803    ***       BY TYPE OF PEEP; FOR OTHER STATES, USE A SIMPLE TIER CHECK.
058700120803    ***
058800120803    ***  WVI, WVF, IND, FAM
058900120803    ***
059000120803    ***  NOW, FOR THE PLAN 'DAAT' IF THE STATE IS 'WV' THEN PLACE EMPLOYMENT STATUS SUFFIX
059100120803    ***       BY TYPE OF PEEP; FOR OTHER STATES, EMPLOYMENT STATUS AND TIER.
059200120803    ***
059300120803    ***  WVI, WVF, CBI, CBF, ACI, ACF
059400120803    ***
059500120803    ***
059600120803     C     $METH06       BEGSR
059700120803    ***
059800120803    1C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'MEMBER'
059900120803      *
060000120803    2C                   IF        STATE = 'WV'
060100120803      **
060200120803    3C                   IF        ENR@IN = 'TIN'
060300120803     C                   EVAL      @CCTRIN = 'WVI'
060400120803    3C                   ELSE
060500120803     C                   EVAL      @CCTRIN = 'WVF'
060600120803    3C                   ENDIF
060700120803      **
060800120803    2C                   ELSE
060900120803      **
061000120803    3C                   IF        ENR@IN = 'TIN'
061100120803     C                   EVAL      @CCTRIN = 'IND'
061200120803    3C                   ELSE
061300120803     C                   EVAL      @CCTRIN = 'FAM'
061400120803    3C                   ENDIF
061500120803      **
061600120803    2C                   ENDIF
061700120803      *
061800120803     C                   LEAVESR
061900120803    1C                   ENDIF
062000120803    ***
062100120803     C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'DEPEND'
062200120803      *
062300120803     C                   IF        STATE = 'WV'
062400120803     C                   EVAL      @CCTRIN = 'WVF'
062500120803     C                   ELSE
062600120803     C                   EVAL      @CCTRIN = 'FAM'
062700120803     C                   ENDIF
062800120803      *
062900120803     C                   LEAVESR
063000120803     C                   ENDIF
063100120803    ***
063200120803    1C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'MEMBER'
063300120803      *
063400120803    2C                   IF        STATE = 'WV'
063500120803      **
063600120803    3C                   IF        ENR@IN = 'TIN'
063700120803     C                   EVAL      @CCTRIN = 'WVI'
063800120803    3C                   ELSE
063900120803     C                   EVAL      @CCTRIN = 'WVF'
064000120803    3C                   ENDIF
064100120803      **
064200120803    2C                   ELSE
064300120803      **
064400120803    3C                   IF        EMPST =  'C'
064500120803     C                   EVAL      @CCTRIN = 'CB '
064600120803    3C                   ELSE
064700120803     C                   EVAL      @CCTRIN = 'AC '
064800120803    3C                   ENDIF
064900120803    3C                   IF        ENR@IN = 'TIN'
065000120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
065100120803    3C                   ELSE
065200120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
065300120803    3C                   ENDIF
065400120803      **
065500120803    2C                   ENDIF
065600120803      *
065700120803     C                   LEAVESR
065800120803    1C                   ENDIF
065900120803    ***
066000120803     C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'DEPEND'
066100120803      *
066200120803     C                   IF        STATE = 'WV'
066300120803     C                   EVAL      @CCTRIN = 'WVF'
066400120803     C                   ELSE
066500120803     C                   IF        EMPST =  'C'
066600120803     C                   EVAL      @CCTRIN = 'CBF'
066700120803     C                   ELSE
066800120803     C                   EVAL      @CCTRIN = 'ACF'
066900120803     C                   ENDIF
067000120803     C                   ENDIF
067100120803      *
067200120803     C                   ENDIF
067300120803    ***
067400120803     C                   ENDSR
067500120803   S***S
067600120803    *** EMPSTS
067700120803    ***   PRETTY STRAIGHT FORWARDED
067800120803    ***
067900120803     C     $METH07       BEGSR
068000120803    ***
068100120803     C                   IF        EMPST =  'C'
068200120803     C                   EVAL      @CCTRIN = 'COB'
068300120803     C                   ELSE
068400120803     C                   EVAL      @CCTRIN = 'ACT'
068500120803     C                   ENDIF
068600120803    ***
068700120803     C                   ENDSR
068800120803   S***S
068900120803    *** JUSTSTATE
069000120803    ***   PRETTY STRAIGHT FORWARDED
069100120803    ***
069200120803     C     $METH08       BEGSR
069300120803    ***
069400120803     C                   EVAL      @CCTRIN = STATE
069500120803    ***
069600120803     C                   ENDSR
069700120803   S***S
069800120803    *** JOHNLS
069900120803    ***   IF STATE IS NOT MARYLAND, DEFAULT TO 'XX', ELSE USE 'MD'; THEN APPLY TIER.
070000120803    ***
070100120803    *** MDI, MDF, XXI, XXF
070200120803    ***
070300120803     C     $METH09       BEGSR
070400120803    ***
070500120803     C                   IF        WRT@TYPE = 'MEMBER'
070600120803     C                   IF        STATE = 'MD'
070700120803     C                   EVAL      @CCTRIN = 'MD'
070800120803     C                   ELSE
070900120803     C                   EVAL      @CCTRIN = 'XX'
071000120803     C                   ENDIF
071100120803     C                   IF        ENR@IN = 'TIN'
071200120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
071300120803     C                   ELSE
071400120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
071500120803     C                   ENDIF
071600120803     C                   ENDIF
071700120803    ***
071800120803     C                   IF        WRT@TYPE = 'DEPEND'
071900120803     C                   IF        STATE = 'MD'
072000120803     C                   EVAL      @CCTRIN = 'MDF'
072100120803     C                   ELSE
072200120803     C                   EVAL      @CCTRIN = 'XXF'
072300120803     C                   ENDIF
072400120803     C                   ENDIF
072500120803    ***
072600120803     C                   ENDSR
072700120803   S***S
072800120803    *** CREATIVE
072900120803    ***   IF STATE IS NOT 'MD' OR 'OK', DEFAULT TO '**'.
073000120803    ***
073100120803    *** MD, OK, **
073200120803    ***
073300120803     C     $METH10       BEGSR
073400120803    ***
073500120803     C                   IF        STATE <> 'MD' AND STATE <> 'OK'
073600120803     C                   EVAL      @CCTRIN = '** '
073700120803     C                   ELSE
073800120803     C                   EVAL      @CCTRIN = STATE
073900120803     C                   ENDIF
074000120803    ***
074100120803     C                   ENDSR
074200120803   S***S
074300120803    *** INTEGRA = USE 'TN' FOR TENNESSEE, OTHER STATES ARE 'XX'
074400120803    ***
074500120803    ***  TN, XX
074600120803    ***
074700120803     C     $METH11       BEGSR
074800120803    ***
074900121113     C                   SELECT
075000121113     C                   WHEN      STATE = 'TN'
075100121113     C                   EVAL      @CCTRIN = STATE                              TENNESSEE ONLY
075200121113     C                   WHEN      STATE = 'FL'
075300121113     C                   EVAL      @CCTRIN = STATE                              FLORIDA ONLY
075400121113     C                   OTHER
075500121113     C                   EVAL      @CCTRIN = 'XX '                              SITUS
075600121113     C                   ENDSL
075700120803    ***
075800120803     C                   ENDSR
075900120803   S***S
076000120803    *** STSTATE = STATE CODE WITH EMPLOYEE STATUS
076100120803    ***
076200120803    ***  MDA, MDC, ETC...
076300120803    ***
076400120803     C     $METH12       BEGSR
076500120803    ***
076600120803     C                   EVAL      @CCTRIN = STATE + EMPST
076700120803    ***
076800120803     C                   ENDSR
076900130123   S***S
077000130123    *** STIERSTS = STATE CODE WITH TIER WITH EMPLOYEE STATUS
077100130123    ***    ACTIVE [#CALC = 0]      COBRA [#CALC = 5]
077200130123    ***    IND [+1 TO #CALC ]      NON-IND COVERAGE [+2 TO CALC]
077300130123    ***
077400130123    ***    EACH STATE PUT AT END, GIVING FAM MARYLAND ACTIVE A VALUE OF 2MD
077500130123    ***                                  IND WEST VIRGINIA COBRA A VALUE OF 6WV
077600130123    ***
077700130123    ***
077800130123     C     $METH13       BEGSR
077900130123    ***
078000130123     C                   SELECT
078100130123     C                   WHEN      EMPST =  'C'
078200130123     C                   Z-ADD     5             #CALC
078300130123     C                   OTHER
078400130123     C                   MOVE      *ZEROS        #CALC             1 0
078500130123     C                   ENDSL
078600130123    ***
078700130123     C                   SELECT
078800130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN = 'TIN'
078900130123     C                   ADD       1             #CALC
079000130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN <> 'TIN'
079100130123     C                   ADD       2             #CALC
079200130123     C                   WHEN      WRT@TYPE = 'DEPEND'
079300130123     C                   ADD       2             #CALC
079400130123     C                   ENDSL
079500130123    ***
079600130123     C                   EVAL      @CCTRIN = %EDITC(#CALC:'X') + STATE
079700130123    ***
079800130123     C                   ENDSR
079900120803   S***S
080000120409     C     $PREP4        BEGSR
080100120409    ***
080200130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
080300160329     C                   EVAL      @STEP = 'READEMEM'
080400101206     C                   LEAVESR
080500101206     C                   ENDIF
080600130520    ***
080700130520     C                   EVAL      @STEP = 'STEP4'
080800130315     C                   EVAL      TERM_LIF = NO
080900101210     C                   EVAL      TERM_DEN = NO
081000101210     C                   EVAL      TERM_MED = NO
081100101210    ***
081200130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
081300130520     C                   IF        L@TRM(L#CNE) <> 99999999
081400130520     C                   EXSR      $CHKHEM
081500130520     C                   ENDIF
081600130520     C                   LEAVESR
081700130520     C                   ENDIF
081800130520    ***
081900130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
082000130520     C                   IF        M@TRM(M#CNE) <> 99999999
082100130520     C                   EXSR      $CHKHEM
082200130520     C                   ENDIF
082300130520     C                   LEAVESR
082400130520     C                   ENDIF
082500130520    ***
082600130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
082700130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
082800130520     C                              M@TRM(M#CNE) <> 99999999)
082900130520     C                   EXSR      $CHKHEM
083000130520     C                   ENDIF
083100130520     C                   LEAVESR
083200130520     C                   ENDIF
083300130520    ***
083400130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
083500130520     C                   IF        D@TRM(D#CNE) <> 99999999
083600130520     C                   EXSR      $CHKHEM
083700130520     C                   ENDIF
083800130520     C                   LEAVESR
083900130520     C                   ENDIF
084000130520    ***
084100130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
084200130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
084300130520     C                              D@TRM(D#CNE) <> 99999999)
084400130520     C                   EXSR      $CHKHEM
084500130520     C                   ENDIF
084600130520     C                   LEAVESR
084700130520     C                   ENDIF
084800130520    ***
084900130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
085000130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
085100130520     C                              M@TRM(M#CNE) <> 99999999)
085200130520     C                   EXSR      $CHKHEM
085300130520     C                   ENDIF
085400130520     C                   LEAVESR
085500130520     C                   ENDIF
085600130520    ***
085700130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
085800130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
085900130520     C                              L@TRM(L#CNE) <> 99999999 OR
086000130520     C                              M@TRM(M#CNE) <> 99999999)
086100130520     C                   EXSR      $CHKHEM
086200130520     C                   ENDIF
086300130520     C                   LEAVESR
086400130520     C                   ENDIF
086500101214    ***
086600101214     C                   ENDSR
086700101214   S***S
086800101210    *** GENERATE MEMBER RECORD
086900101210    ***
087000101210     C     $STEP4        BEGSR
087100101210    ***
087200130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
087300160329     C                   EVAL      @STEP = 'READEMEM'
087400101214     C                   LEAVESR
087500101214     C                   ENDIF
087600101214    ***
087700110513     C                   EVAL      WRT@TYPE = 'MEMBER'
087800110725    ***
087900130315     C                   EVAL      L@MBREFF = 0
088000110725     C                   EVAL      D@MBREFF = 0
088100110725     C                   EVAL      M@MBREFF = 0
088200110513    ***
088300101210     C                   EVAL      @SS1   = %EDITC(MBSSNO:'X')
088400101210     C                   EVAL      @SS2   = @SS1
088500101210     C                   MOVEL(P)  MLNAME        @LN
088600101210     C                   MOVEL(P)  MFNAME        @FN
088700101210     C                   EVAL      @MI    = MMI
088800101210     C                   EVAL      @REL   = '01'
088900101210     C                   EVAL      @SEX   = SEX
089000101210     C                   EVAL      @DOB   = %EDITC(BIRTH:'X')
089100101210     C                   IF        COB = 'Y'
089200101210     C                   EVAL      @COB   = 'Y'
089300101210     C                   EVAL      @COBC  = 'OT'
089400101210     C                   EVAL      @COBN  = MCOBPN
089500101210     C                   ENDIF
089600101210     C                   EVAL      @AD1   = %TRIM(ADDR1)
089700101210     C                   EVAL      @AD2   = %TRIM(ADDR2)
089800101210     C                   EVAL      @CTY   = %TRIM(CITY)
089900101210     C                   EVAL      @ST    = STATE
090000101210     C                   MOVE      *BLANKS       @9                9
090100101210     C                   EVAL      @9   = %EDITC(ZIP:'X')
090200101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
090300101210     C                   EVAL      @PHN   = %EDITC(AREA:'X') +
090400101210     C                                      %EDITC(PHONE:'X')
090500101210    ***
090600101210     C                   SELECT
090700101210     C                   WHEN      EMPST = 'A'
090800101210     C                   EVAL      @EMPST = 'AC'
090900101210     C                   WHEN      EMPST = 'C'
091000101210     C                   EVAL      @EMPST = 'CO'
091100101210     C                   WHEN      EMPST = 'R'
091200101210     C                   EVAL      @EMPST = 'RT'
091300101210     C                   ENDSL
091400101210    ***
091500101210     C                   EVAL      @HIRE  = %EDITC(EMPDT:'X')
091600101210    ***
091700141211     C                   SETOFF                                       888987
091800141120        IF KF@TRS = 770 AND KF@SUB = 004 AND KF@ACC = 0037 AND
091900141120          STATE = 'VT';
092000141120           *IN89 = *ON;
092100141120        ENDIF;
092200141211    *** IF KF@TRS = 591 AND KF@SUB = 001 AND KF@ACC = 0042 AND
092300141211    ***   STATE = 'TX';
092400141211    ***    *IN87 = *ON;
092500141211    *** ENDIF;
092600141120    ***
092700101210     C                   EXCEPT    MBRF
092800101214     C                   ADD       1             C#RECCNT
092900101213    ***
093000101213     C                   EVAL      @STEP = 'PREP5'
093100101210    ***
093200101210     C                   ENDSR
093300101210   S***S
093400130315    *** * * * * * MEDICAL
093500101214     C     $PREP5        BEGSR
093600101214    ***
093700101214     C                   IF        M#CNE = 0
093800110513     C                   EVAL      @STEP = 'PREP6'
093900101214     C                   LEAVESR
094000101214     C                   ENDIF
094100101214    ***
094200101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
094300130315     C                   EVAL      KF@ENR = M@ENR(M#CNE)
094400101214    ***
094500101214     C                   IF        TERM_MED = YES
094600101214     C                   EXSR      $WRTERM
094700101214     C                   ENDIF
094800101214    ***
094900110512     C                   EVAL      @PLANIN = KF@PLN
095000120803    ***
095100160329     C     KL#TSAP       CHAIN     AEF04
095200160329     C                   IF        NOT %FOUND(AET004WF)
095300120803     C                   LEAVESR
095400120803     C                   ENDIF
095500120803    ***
095600111020     C                   EVAL      ENR@IN = M@ENR(M#CNE)
095700111020    ***
095800110802     C                   EXSR      $QUIK
095900110802    ***
096000110512     C                   EXSR      $PLANSRCH
096100110512    ***
096200110512     C                   IF        PLN@CAT = *BLANKS
096300101214     C                   SETON                                        H1
096400101214     C                   ENDIF
096500110512    ***
096600110513     C                   EVAL      @STEP = 'STEP5'
096700110725     C                   EVAL      #XSX = M@FRM(M#CNE)
096800110725     C                   EVAL      M@MBREFF = #XSX
096900101214    ***
097000101214     C                   ENDSR
097100101214   S***S
097200101214     C     $STEP5        BEGSR
097300101214    ***
097400110513     C                   IF        CPCID1 = 'MEA'
097500110513     C                   EXSR      $MEAWRT
097600110513     C                   ELSE
097700110513     C                   EXSR      $HMOWRT
097800110513     C                   ENDIF
097900110513    ***
098000101214     C                   ADD       1             C#RECCNT
098100101214     C                   ADD       1             B#RECCNT
098200110512    ***
098300110513     C                   EVAL      @STEP = 'PREP6'
098400110513    ***
098500110513     C                   ENDSR
098600110513   S***S
098700130315    *** DENTAL
098800130315    ***
098900101214     C     $PREP6        BEGSR
099000101213    ***
099100110513    *C                   IF        D#CNE = 0
099200130315    *C                   EVAL      @STEP = 'PREPC'
099300130315    *C*****************  EVAL      @STEP = 'PREP7'
099400110513    *C                   LEAVESR
099500110513    *C                   ENDIF
099600110512    ***
099700110513    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
099800130315    *C                   EVAL      KF@ENR = D@ENR(D#CNE)
099900130315    ***
100000160329     C     KL#TSAP       CHAIN     AEF04
100100160329     C                   IF        NOT %FOUND(AET004WF)
100200120803     C                   LEAVESR
100300120803     C                   ENDIF
100400110512    ***
100500110513    *C                   IF        TERM_DEN = YES
100600110513    *C                   EXSR      $WRTERM
100700110513    *C                   ENDIF
100800110513    ***
100900110513     C                   EVAL      @PLANIN = KF@PLN
101000111020     C                   EVAL      ENR@IN = D@ENR(D#CNE)
101100110513    ***
101200111011     C                   EXSR      $QUIK
101300110513    ***
101400110513     C                   EXSR      $PLANSRCH
101500110513    ***
101600110513     C                   IF        PLN@CAT = *BLANKS
101700110513     C                   SETON                                        H2
101800110513     C                   ENDIF
101900110512    ***
102000110513    *C                   EVAL      @STEP = 'STEP6'
102100110725     C                   EVAL      #XSX = D@FRM(D#CNE)
102200110725     C                   EVAL      D@MBREFF = #XSX
102300110512    ***
102400101213     C                   ENDSR
102500110802   S***S
102600110513    *** DENTAL FORMAT
102700110513    ***
102800110513    *C     $STEP6        BEGSR
102900110513    ***
103000110513     C                   EXSR      $DENWRT
103100110513    ***
103200110513    *C                   ADD       1             C#RECCNT
103300110513    *C                   ADD       1             B#RECCNT
103400110513    ***
103500130315    *C****************** EVAL      @STEP = 'PREP7'
103600130315    *C                   EVAL      @STEP = 'PREPC'
103700110513    ***
103800110513    *C                   ENDSR
103900110513   S***S
104000130315    *** LIFE AND AD&D PLANS FOR MEMBER
104100130315    ***
104200130315     C     $PREPC        BEGSR
104300130315    ***
104400130315    *C                   IF        L#CNE = 0
104500130315    *C                   EVAL      @STEP = 'PREP7'
104600130315    *C                   LEAVESR
104700130315    *C                   ENDIF
104800130315    ***
104900130315    *C                   EVAL      KF#TRM = L@TRM(L#CNE)
105000130315    *C                   EVAL      KF@PLN = L@PLN(L#CNE)
105100130315     C                   EVAL      KF@ENR = L@ENR(L#CNE)
105200130315    ***
105300160329     C     KL#TSAP       CHAIN     AEF04
105400160329     C                   IF        NOT %FOUND(AET004WF)
105500130315     C                   LEAVESR
105600130315     C                   ENDIF
105700130315    ***
105800130315    *C                   IF        TERM_LIF = YES
105900130315    *C                   EXSR      $WRTERM
106000130315    *C                   ENDIF
106100130315    ***
106200130315     C                   EVAL      @PLANIN = KF@PLN
106300130315     C                   EVAL      ENR@IN = L@ENR(L#CNE)
106400130315    ***
106500130315     C                   EXSR      $QUIK
106600130315    ***
106700130315     C                   EXSR      $PLANSRCH
106800130315    ***
106900130315     C                   IF        PLN@CAT = *BLANKS
107000130315     C                   SETON                                        H2
107100130315     C                   ENDIF
107200130315    ***
107300130315    *C                   EVAL      @STEP = 'STEPC'
107400130315     C                   EVAL      #XSX = L@FRM(L#CNE)
107500130315     C                   EVAL      L@MBREFF = #XSX
107600130315    ***
107700130315     C                   ENDSR
107800130315   S***S
107900130315    *** LIFE FORMAT
108000130315    ***
108100130315    *C     $STEPC        BEGSR
108200130315    ***
108300130315     C                   EXSR      $LIFWRT
108400130315    ***
108500130315    *C                   ADD       1             C#RECCNT
108600130315    *C                   ADD       1             B#RECCNT
108700130315    ***
108800130315    *C                   EVAL      @STEP = 'PREP7'
108900130315    ***
109000130315    *C                   ENDSR
109100130315   S***S
109200130315     C     $LIFWRT       BEGSR
109300130315    ***
109400130315    *C                   EVAL      X@LAY = CPCID1                               LAYOUT
109500130315    *C                   EVAL      X@ELR = CPCID2                               ELR
109600130315    *C                   EVAL      L@SFX = CPCID3                               SUFFIX
109700130315    *C                   EVAL      L@ACCT = CPCID4                              ACCOUNT
109800130315    *C                   EVAL      L@PLAN = CPCID5                              PLAN
109900130315    *C                   EVAL      L@CLM = CPCID6                               CLAIM OFFICE
110000130315    ***
110100130315    *C                   EVAL      #XSX = L@FRM(L#CNE)
110200130315     C                   MOVE      #XSX          X@EFF
110300130315    ***
110400130315    *C                   EVAL      #XSX = L@TRM(L#CNE)
110500130315    *C                   IF        #XSX = 0 OR #XSX = 99999999
110600130315    *C                   MOVE      *BLANKS       X@TRM
110700130315    *C                   ELSE
110800130315    *C                   MOVE      #XSX          X@TRM
110900130315    *C                   ENDIF
111000140313    ***
111100140313     C                   MOVE      *BLANKS       L@CBREXP
111200140313     C                   MOVE      *BLANKS       L@CBREVT
111300140313     C                   MOVE      *BLANKS       L@CBRLEN
111400130315    ***
111500130923    *C                   IF        EMPST = 'C' AND
111600130923     C                             CEXPDT > 0
111700130315    *C                   MOVE      CEXPDT        L@CBREXP
111800130315    *C                   MOVE      QEDT          L@CBREVT
111900130315    *C                   MOVE      CEXPDT        #MINUEND
112000130315    *C                   MOVE      QEDT          #SUBTRAEND
112100130315    *C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
112200130315    *C                   Z-ADD     #DIFFRNC      #2S0
112300130315    *C                   MOVE      #2S0          L@CBRLEN
112400130315    *C                   ENDIF
112500130315    ***
112600130315     C                   EVAL      L@SALARY = %EDITC(SALARY:'4')
112700130315    ***
112800130315    *C                   EXCEPT    LIFF
112900130315    ***
113000130315    *C                   ENDSR
113100130315   S***S
113200101214     C     $PREP7        BEGSR
113300101214    ***
113400101214     C     KF@SSN        CHAIN     DEPENR
113500101214     C                   IF        NOT %FOUND(DEPNDC)
113600160329     C                   EVAL      @STEP = 'READEMEM'
113700101214     C                   LEAVESR
113800101214     C                   ENDIF
113900101214    ***
114000101214     C     KF@SSN        SETLL     DEPENR
114100101214    ***
114200101214     C                   EVAL      @STEP = 'STEP7'
114300101214    ***
114400101214     C                   ENDSR
114500101210   S***S
114600101214     C     $STEP7        BEGSR
114700101214    ***
114800101214     C     KF@SSN        READE     DEPENR
114900101214    ***
115000101214     C                   IF        %EOF(DEPNDC)
115100160329     C                   EVAL      @STEP = 'READEMEM'
115200101214     C                   LEAVESR
115300101214     C                   ENDIF
115400101214    ***
115500101214     C                   EVAL      KF@SEQ = DPSEQ#
115600120803     C                   EVAL      WRT@TYPE = 'DEPEND'
115700101214    ***
115800101214     C     KL#DCV        CHAIN     DCOVR
115900101214     C                   IF        NOT %FOUND(DCOVA)
116000101214     C                   LEAVESR
116100101214     C                   ENDIF
116200101214    ***
116300101214     C                   EXSR      $CLRDCV
116400101214     C     KL#DCV        SETLL     DCOVR
116500101214    ***
116600101214     C                   EVAL      @STEP = 'STEP8'
116700101214    ***
116800101214     C                   ENDSR
116900101214   S***S
117000101214     C     $STEP8        BEGSR
117100101214    ***
117200101214     C     KL#DCV        READE     DCOVR
117300101214    ***
117400101214     C                   IF        %EOF(DCOVA)
117500101214     C                   EVAL      @STEP = 'PREP9'
117600101214     C                   LEAVESR
117700101214     C                   ENDIF
117800101214    ***
117900130131    *C*                  IF        DENRDT = CCANDT
118000130131    *C*                  LEAVESR
118100130131    *C*                  ENDIF
118200110513    ***
118300110513     C                   EVAL      @PLANIN = DVPLAN
118400120803     C                   EVAL      KF@PLN = DVPLAN
118500160329     C     KL#TSAP       CHAIN     AEF04
118600160329     C                   IF        NOT %FOUND(AET004WF)
118700120803     C                   LEAVESR
118800120803     C                   ENDIF
118900110802    ***
119000110802     C                   EXSR      $QUIKD
119100110802    ***
119200110513     C                   EXSR      $PLANSRCH
119300110513    ***
119400110513     C                   IF        PLN@CAT = *BLANKS
119500110513     C                   LEAVESR
119600110513     C                   ENDIF
119700101214    ***
119800101214     C                   EVAL      #CANCEL = CCANDT
119900101214     C                   IF        #CANCEL = 0
120000101214     C                   EVAL      #CANCEL = 99999999
120100101214     C                   ENDIF
120200101214    ***
120300130315    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL; LIFE IS MEMBER ONLY
120400110513    ***
120500110513    *C                   IF        PLN@CAT = 'DEN'
120600130131    *C                   IF        D#CNE > 0
120700130131    *C                   IF        D@TRM(D#CNE) = 99999999
120800130131     C                   LEAVESR
120900130131     C                   ENDIF
121000130131     C                   ENDIF
121100110513    *C                   ADD       1             D#CNE
121200110513    *C                   EVAL      D@PLN(D#CNE) = DVPLAN
121300110513    *C                   EVAL      D@ENR(D#CNE) = *BLANKS
121400110513    *C                   EVAL      D@FRM(D#CNE) = DENRDT
121500110513    *C                   EVAL      D@TRM(D#CNE) = #CANCEL
121600110513    *C                   ELSE
121700130131    *C                   IF        M#CNE > 0
121800130131    *C                   IF        M@TRM(M#CNE) = 99999999
121900130131     C                   LEAVESR
122000130131     C                   ENDIF
122100130131     C                   ENDIF
122200101214     C                   ADD       1             M#CNE
122300101214     C                   EVAL      M@PLN(M#CNE) = DVPLAN
122400101214     C                   EVAL      M@ENR(M#CNE) = *BLANKS
122500101214     C                   EVAL      M@FRM(M#CNE) = DENRDT
122600101214     C                   EVAL      M@TRM(M#CNE) = #CANCEL
122700110513    *C                   ENDIF
122800101214    ***
122900101214     C                   ENDSR
123000101214   S***S
123100111011     C     $QUIKD        BEGSR
123200111011    ***
123300120803     C                   EXSR      $QUIK
123400120409    ***
123500120409     C                   ENDSR
123600111011   S***S
123700101214     C     $PREP9        BEGSR
123800101214    ***
123900101214     C                   IF        D#CNE = 0 AND M#CNE = 0
124000101214     C                   EVAL      @STEP = 'STEP7'
124100101214     C                   LEAVESR
124200101214     C                   ENDIF
124300101214    ***
124400130315     C                   EVAL      L#CNE = 0
124500130315     C                   EVAL      TERM_LIF = NO
124600101214     C                   EVAL      TERM_DEN = NO
124700101214     C                   EVAL      TERM_MED = NO
124800130520     C                   EVAL      @STEP = 'STEP9'
124900101214    ***
125000130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
125100130520     C                   IF        L@TRM(L#CNE) <> 99999999
125200130520     C                   EXSR      $CHKHEM
125300130520     C                   ENDIF
125400130520     C                   LEAVESR
125500130520     C                   ENDIF
125600130520    ***
125700130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
125800130520     C                   IF        M@TRM(M#CNE) <> 99999999
125900130520     C                   EXSR      $CHKHEM
126000130520     C                   ENDIF
126100130520     C                   LEAVESR
126200130520     C                   ENDIF
126300130520    ***
126400130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
126500130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
126600130520     C                              M@TRM(M#CNE) <> 99999999)
126700130520     C                   EXSR      $CHKHEM
126800130520     C                   ENDIF
126900130520     C                   LEAVESR
127000130520     C                   ENDIF
127100130520    ***
127200130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
127300130520     C                   IF        D@TRM(D#CNE) <> 99999999
127400130520     C                   EXSR      $CHKHEM
127500130520     C                   ENDIF
127600130520     C                   LEAVESR
127700130520     C                   ENDIF
127800130520    ***
127900130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
128000130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
128100130520     C                              D@TRM(D#CNE) <> 99999999)
128200130520     C                   EXSR      $CHKHEM
128300130520     C                   ENDIF
128400130520     C                   LEAVESR
128500130520     C                   ENDIF
128600130520    ***
128700130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
128800130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
128900130520     C                              M@TRM(M#CNE) <> 99999999)
129000130520     C                   EXSR      $CHKHEM
129100130520     C                   ENDIF
129200130520     C                   LEAVESR
129300130520     C                   ENDIF
129400130520    ***
129500130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
129600130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
129700130520     C                              L@TRM(L#CNE) <> 99999999 OR
129800130520     C                              M@TRM(M#CNE) <> 99999999)
129900130520     C                   EXSR      $CHKHEM
130000130520     C                   ENDIF
130100130520     C                   LEAVESR
130200130520     C                   ENDIF
130300101214    ***
130400101214     C                   ENDSR
130500101214   S***S
130600101210    *** GENERATE DEPENDENT RECORD
130700101210    ***
130800101214     C     $STEP9        BEGSR
130900101210    ***
131000110513     C                   EVAL      WRT@TYPE = 'DEPEND'
131100110513    ***
131200110513     C                   IF        D#CNE = 0 AND M#CNE = 0
131300110513     C                   EVAL      @STEP = 'STEP7'
131400110513     C                   LEAVESR
131500110513     C                   ENDIF
131600110513    ***
131700101214     C                   EVAL      @SS2   = %EDITC(DEPSS#:'X')
131800101210     C                   MOVEL(P)  DLNAME        @LN
131900101210     C                   MOVEL(P)  DFNAME        @FN
132000101210     C                   EVAL      @MI    = DMI
132100101210    ***
132200101210     C                   SELECT
132300101210     C                   WHEN      DRELCD = 'RWI'
132400101210     C                   EVAL      @REL   = '02'
132500101210     C                   WHEN      DRELCD = 'RHU'
132600101210     C                   EVAL      @REL   = '03'
132700101210     C                   WHEN      DRELCD = 'RSO'
132800101210     C                   EVAL      @REL   = '04'
132900101210     C                   WHEN      DRELCD = 'RDA'
133000101210     C                   EVAL      @REL   = '05'
133100130218     C                   WHEN      DRELCD = 'RPA'
133200130218     C                   EVAL      @REL   = '14'
133300130225     C                   OTHER
133400130225     C                   EVAL      @REL   = *BLANKS
133500101210     C                   ENDSL
133600101210    ***
133700101210     C                   SELECT
133800101210     C                   WHEN      DSTUDN = 'Y'
133900101210     C                   EVAL      @SPEC = '1'
134000140812     C                   WHEN      DHNDCP = '3'
134100101210     C                   EVAL      @SPEC = '3'
134200130225     C                   OTHER
134300130225     C                   EVAL      @SPEC = *BLANKS
134400101210     C                   ENDSL
134500101210    ***
134600101210     C                   EVAL      @SEX   = DSEX
134700101210     C                   EVAL      @DOB   = %EDITC(DBIRTH:'X')
134800130225    ***
134900101210     C                   IF        DCOB = 'Y'
135000101210     C                   EVAL      @COB   = 'Y'
135100101210     C                   EVAL      @COBC  = 'OT'
135200101210     C                   EVAL      @COBN  = DCOBPN
135300130225     C                   ELSE
135400130225     C                   EVAL      @COB   = *BLANKS
135500130225     C                   EVAL      @COBC  = *BLANKS
135600130225     C                   EVAL      @COBN = *BLANKS
135700101210     C                   ENDIF
135800101214    ***
135900101214     C                   IF        DADDR1 <> ADDR1
136000101210     C                   EVAL      @AD1   = %TRIM(DADDR1)
136100101210     C                   EVAL      @AD2   = %TRIM(DADDR2)
136200101210     C                   EVAL      @CTY   = %TRIM(DCITY)
136300101210     C                   EVAL      @ST    = DSTATE
136400101210     C                   MOVE      *BLANKS       @9                9
136500101214     C                   IF        DZIP = 0
136600101214     C                   EVAL      @9   = %EDITC(ZIP:'X')
136700101214     C                   ELSE
136800101210     C                   EVAL      @9   = %EDITC(DZIP:'X')
136900101214     C                   ENDIF
137000101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
137100101210     C                   EVAL      @PHN   = %EDITC(DAREA:'X') +
137200101210     C                                      %EDITC(DPHONE:'X')
137300101214     C                   ENDIF
137400141120    ***
137500101210     C                   EXCEPT    MBRF
137600101214     C                   ADD       1             C#RECCNT
137700101214    ***
137800101214     C                   EVAL      @STEP = 'PREPA'
137900101210    ***
138000101210     C                   ENDSR
138100101210   S***S
138200101214     C     $PREPA        BEGSR
138300101214    ***
138400101214     C                   IF        M#CNE = 0
138500101214     C                   EVAL      @STEP = 'PREPB'
138600101214     C                   LEAVESR
138700101214     C                   ENDIF
138800101214    ***
138900101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
139000160329     C     KL#TSAP       CHAIN     AEF04
139100160329     C                   IF        NOT %FOUND(AET004WF)
139200120803     C                   LEAVESR
139300120803     C                   ENDIF
139400101214    ***
139500101214     C                   IF        TERM_MED = YES
139600101214     C                   EXSR      $WRTERM
139700101214     C                   ENDIF
139800101214    ***
139900110513     C                   EVAL      @PLANIN = KF@PLN
140000110802    ***
140100110802     C                   EXSR      $QUIKD
140200110802    ***
140300110513     C                   EXSR      $PLANSRCH
140400110513    ***
140500110513     C                   IF        PLN@CAT = *BLANKS
140600110513     C                   SETON                                        H2
140700110513     C                   ENDIF
140800110513    ***
140900110513     C                   EVAL      @STEP = 'STEPA'
141000110513    ***
141100101214     C                   ENDSR
141200101214   S***S
141300101214     C     $STEPA        BEGSR
141400101214    ***
141500110513     C                   IF        CPCID1 = 'MEA'
141600110513     C                   EXSR      $MEAWRT
141700110513     C                   ELSE
141800110513     C                   EXSR      $HMOWRT
141900110513     C                   ENDIF
142000110513    ***
142100110513     C                   ADD       1             C#RECCNT
142200110513     C                   ADD       1             B#RECCNT
142300110513    ***
142400110513     C                   EVAL      @STEP = 'PREPB'
142500110513    ***
142600110513     C                   ENDSR
142700110513   S***S
142800101214     C     $PREPB        BEGSR
142900101214    ***
143000110513    *C                   IF        D#CNE = 0
143100110513    *C                   EVAL      @STEP = 'STEP7'
143200110513    *C                   LEAVESR
143300110513    *C                   ENDIF
143400101214    ***
143500110513    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
143600160329     C     KL#TSAP       CHAIN     AEF04
143700160329     C                   IF        NOT %FOUND(AET004WF)
143800120803     C                   LEAVESR
143900120803     C                   ENDIF
144000110513    ***
144100110513    *C                   IF        TERM_DEN = YES
144200110513    *C                   EXSR      $WRTERM
144300110513    *C                   ENDIF
144400110513    ***
144500110513     C                   EVAL      @PLANIN = KF@PLN
144600110513    ***
144700110802     C                   EXSR      $QUIKD
144800110513    ***
144900110513     C                   EXSR      $PLANSRCH
145000110513    ***
145100110513     C                   IF        PLN@CAT = *BLANKS
145200110513     C                   SETON                                        H2
145300110513     C                   ENDIF
145400110513    ***
145500101214     C                   EVAL      @STEP = 'STEPB'
145600101214    ***
145700101214     C                   ENDSR
145800101214   S***S
145900110513    *C     $STEPB        BEGSR
146000110513    ***
146100110513     C                   EXSR      $DENWRT
146200110513    ***
146300110513    *C                   ADD       1             C#RECCNT
146400110513    *C                   ADD       1             B#RECCNT
146500110513    ***
146600110513    *C                   EVAL      @STEP = 'STEP7'
146700110513    ***
146800110513    *C                   ENDSR
146900101210   S***S
147000110512     C     *INZSR        BEGSR
147100110512    ***
147200160302     C     *entry        plist
147300160302     C                   parm                    CARR#CTL
147400160302     C                   parm                    grouper
147500160302
147600110512     C     KL#ACCTL      KLIST
147700120803     C                   KFLD                    KF@CCTL
147800110512     C                   KFLD                    KF@TRS
147900110512     C                   KFLD                    KF@SUB
148000110512     C                   KFLD                    KF@ACC
148100140313    ***
148200140313     C     KL#SQPCD      KLIST
148300140313     C                   KFLD                    KF@SSN
148400140313     C                   KFLD                    KF@SEQ
148500140313     C                   KFLD                    KF@SPCD
148600120803    ***
148700120803     C     KL#TSAP       KLIST
148800120803     C                   KFLD                    KF@TRS
148900120803     C                   KFLD                    KF@SUB
149000120803     C                   KFLD                    KF@ACC
149100120803     C                   KFLD                    KF@PLN
149200110512    ***
149300110512     C     KL#TSA        KLIST
149400110512     C                   KFLD                    KF@TRS
149500110512     C                   KFLD                    KF@SUB
149600110512     C                   KFLD                    KF@ACC
149700110512    ***
149800110512     C     KL#MPLN       KLIST
149900110512     C                   KFLD                    KF@SSN
150000110512     C                   KFLD                    KF@SEQ
150100110512     C                   KFLD                    KF@TRS
150200110512     C                   KFLD                    KF@SUB
150300110512     C                   KFLD                    KF@ACC
150400110512    ***
150500110512     C     KL#CPLN       KLIST
150600120803     C                   KFLD                    KF@CCTL
150700110512     C                   KFLD                    KF@TRS
150800110512     C                   KFLD                    KF@SUB
150900110512     C                   KFLD                    KF@ACC
151000110512     C                   KFLD                    KF@CCTR
151100110512     C                   KFLD                    KF@PLN
151200110512    ***
151300110512     C     KL#DCV        KLIST
151400110512     C                   KFLD                    KF@SSN
151500110512     C                   KFLD                    KF@SEQ
151600110512    ***
151700110512     C     KL#MTR        KLIST
151800110512     C                   KFLD                    KF@SSN
151900110512     C                   KFLD                    KF@SEQ
152000110512     C                   KFLD                    KF#TRM
152100110512     C                   KFLD                    KF@PLN
152200110512     C                   KFLD                    KF@ENR
152300110512     C                   KFLD                    KF@TRS
152400110512     C                   KFLD                    KF@SUB
152500110512     C                   KFLD                    KF@ACC
152600110512    ***
152700110512     C     KL#PCP        KLIST
152800110512     C                   KFLD                    KF@SSN
152900110512     C                   KFLD                    KF@SEQ
153000110512    ***
153100110512     C                   EVAL      #ISO = %DATE
153200110512     C                   MOVE      #ISO          #TODAY            8 0
153300110512     C                   EVAL      #IST = %TIME
153400110512     C                   MOVE      #ISO          #XSX
153500110512     C                   MOVE      #XSX          @DATE
153600110512     C                   MOVE      #IST          #XST
153700110512     C                   MOVE      #XST          @TIME
153800110512    ***
153900110512     C                   ENDSR
154000110512   S***S
154100110513    *** PLANS LOADED BY ACCOUNT
154200110513    ***
154300110513     C     $PLANLOAD     BEGSR
154400110513    ***
154500110513     C                   EVAL      PP# = 0
154600140313     C                   DO        80
154700110513     C                   ADD       1             PP#
154800110513     C     PP#           OCCUR     CARPLN@
154900110513     C                   CLEAR                   CARPLN@
155000110513     C                   ENDDO
155100110513     C                   EVAL      PC# = 0
155200110513     C                   EVAL      PP# = 0
155300110513    ***
155400110513     C     KL#ACCTL      SETLL     CARPLNR
155500110513     C                   DOU       %EOF(CARPLNP)
155600110513     C     KL#ACCTL      READE     CARPLNR
155700110520     C                   IF        NOT %EOF(CARPLNP)
155800110513    ***
155900110513     C                   ADD       1             PC#
156000110513     C     PC#           OCCUR     CARPLN@
156100110513     C                   EVAL      CARPLN@ = DS@CARPLN
156200110513    ***
156300110513     C                   ENDIF
156400110513     C                   ENDDO
156500110513    ***
156600110513     C                   ENDSR
156700110513   S***S
156800110513     C     $CLRSTG       BEGSR
156900110513    ***
157000110513     C                   EVAL      #CANCEL = 0
157100130315    ***
157200130315     C                   EVAL      L#CNE = 0
157300130315     C                   CLEAR                   L@PLN
157400130315     C                   CLEAR                   L@ENR
157500130315     C                   CLEAR                   L@FRM
157600130315     C                   CLEAR                   L@TRM
157700130315    ***
157800110513     C                   EVAL      D#CNE = 0
157900110513     C                   CLEAR                   D@PLN
158000110513     C                   CLEAR                   D@ENR
158100110513     C                   CLEAR                   D@FRM
158200110513     C                   CLEAR                   D@TRM
158300110513     C                   EVAL      M#CNE = 0
158400110513     C                   CLEAR                   M@PLN
158500110513     C                   CLEAR                   M@ENR
158600110513     C                   CLEAR                   M@FRM
158700110513     C                   CLEAR                   M@TRM
158800110513    ***
158900110513     C                   EXSR      $CLRDMG
159000110513    ***
159100110513     C                   ENDSR
159200110513   S***S
159300110513     C     $CLRDMG       BEGSR
159400110513    ***
159500110513     C                   EVAL      @SS1   = *BLANKS
159600110513     C                   EVAL      @SS2   = *BLANKS
159700110513     C                   MOVE      *BLANKS       @LN
159800110513     C                   MOVEL     *BLANKS       @FN
159900110513     C                   EVAL      @MI    = *BLANKS
160000110513     C                   EVAL      @REL   = *BLANKS
160100110513     C                   EVAL      @SEX   = *BLANKS
160200110513     C                   EVAL      @DOB   = *BLANKS
160300110513     C                   EVAL      @SPEC  = *BLANKS
160400110513     C                   EVAL      @COB   = *BLANKS
160500110513     C                   EVAL      @COBC  = *BLANKS
160600110513     C                   EVAL      @COBN  = *BLANKS
160700110513     C                   EVAL      @AD1   = *BLANKS
160800110513     C                   EVAL      @AD2   = *BLANKS
160900110513     C                   EVAL      @CTY   = *BLANKS
161000110513     C                   EVAL      @ST    = *BLANKS
161100110513     C                   EVAL      @ZP5   = *BLANKS
161200110513     C                   EVAL      @PHN   = *BLANKS
161300110513     C                   EVAL      @EMPST = *BLANKS
161400110513     C                   EVAL      @HIRE  = *BLANKS
161500110513    ***
161600110513     C                   ENDSR
161700110513   S***S
161800110513     C     $CHKHEM       BEGSR
161900110513    ***
162000130315    *C                   IF        L#CNE > 0 AND L@TRM(L#CNE) <> 99999999
162100130315    *C                   EXSR      $CHKLIF
162200130315    *C                   ENDIF
162300130315      *
162400110513    *C                   IF        D#CNE > 0 AND D@TRM(D#CNE) <> 99999999
162500110513    *C                   EXSR      $CHKDEN
162600110513    *C                   ENDIF
162700110513      *
162800110513     C                   IF        M#CNE > 0 AND M@TRM(M#CNE) <> 99999999
162900110513     C                   EXSR      $CHKMED
163000110513     C                   ENDIF
163100110513    ***
163200110513     C                   ENDSR
163300110513   S***S
163400130315    *C     $CHKLIF       BEGSR
163500130315    ***
163600130315    *C                   EVAL      TERM_LIF = YES
163700130315    *C                   EVAL      KF#TRM = L@TRM(L#CNE)
163800130315    *C                   EVAL      KF@PLN = L@PLN(L#CNE)
163900130315    *C                   EVAL      KF@ENR = L@ENR(L#CNE)
164000130315    ***
164100160302    *C     KL#MTR        CHAIN     AET941F
164200160302    *C                   IF        %FOUND(AET941WF)
164300130315    *C                   EVAL      L#CNE = 0
164400130315    *C                   EVAL      TERM_LIF = NO
164500130315    *C                   ENDIF
164600130315    ***
164700130315    *C                   ENDSR
164800130315   S***S
164900110513    *C     $CHKDEN       BEGSR
165000110513    ***
165100110513    *C                   EVAL      TERM_DEN = YES
165200110513    *C                   EVAL      KF#TRM = D@TRM(D#CNE)
165300110513    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
165400110513    *C                   EVAL      KF@ENR = D@ENR(D#CNE)
165500110513    ***
165600160302    *C     KL#MTR        CHAIN     AET941F
165700160302    *C                   IF        %FOUND(AET941WF)
165800110513    *C                   EVAL      D#CNE = 0
165900110513    *C                   EVAL      TERM_DEN = NO
166000110513    *C                   ENDIF
166100110513    ***
166200110513    *C                   ENDSR
166300110513   S***S
166400110513     C     $CHKMED       BEGSR
166500110513    ***
166600110513     C                   EVAL      TERM_MED = YES
166700110513     C                   EVAL      KF#TRM = M@TRM(M#CNE)
166800110513     C                   EVAL      KF@PLN = M@PLN(M#CNE)
166900110513     C                   EVAL      KF@ENR = M@ENR(M#CNE)
167000110513      *
167100160302     C     KL#MTR        CHAIN     AET941F
167200160302     C                   IF        %FOUND(AET941WF)
167300110513     C                   EVAL      TERM_MED = NO
167400110513     C                   EVAL      M#CNE = 0
167500110513     C                   ENDIF
167600110513    ***
167700110513     C                   ENDSR
167800110513   S***S
167900110513     C     $PLANSRCH     BEGSR
168000110513    ***
168100130315     C                   MOVE      *BLANKS       PLN@CAT           5
168200110513     C                   EVAL      PP# = 0
168300110513     C                   CLEAR                   DS@CARPLN
168400110513    ***
168500110513     C                   DO        PC#
168600110513    * *
168700110513     C                   ADD       1             PP#
168800110513     C     PP#           OCCUR     CARPLN@
168900110513    * *
169000110513     C                   IF        XPPLAN = @PLANIN AND
169100110513     C                             XPCCTR = @CCTRIN
169200110513     C                   EVAL      DS@CARPLN = CARPLN@
169300110513     C                   LEAVE
169400110513     C                   ENDIF
169500110513    * *
169600110513     C                   ENDDO
169700110513    ***
169800110513     C                   IF        CPPLAN = *BLANKS
169900110513     C                   LEAVESR
170000110513     C                   ENDIF
170100110513    ***
170200110513     C                   SELECT
170300110520     C                   WHEN      CPCID1 = 'MEA' OR
170400110520     C                             CPCID1 = 'HMO'
170500110520     C                   EVAL      PLN@CAT = 'MED'
170600130409     C                   WHEN      CPCID1 = 'LIFE'
170700130409     C                   EVAL      PLN@CAT = 'LIFE'
170800110520     C                   WHEN      CPCID1 = 'DEN'
170900110520     C                   EVAL      PLN@CAT = 'DEN'
171000110513     C                   ENDSL
171100110513    ***
171200110513     C                   ENDSR
171300110513   S***S
171400110513     C     $ENROLL       BEGSR
171500110513    ***
171600110513     C                   EVAL      ENR@OUT = *BLANKS
171700110513     C                   SELECT
171800110513     C                   WHEN      ENR@IN = 'TIN' OR ENR@IN = 'TMI'
171900110513     C                   EVAL      ENR@OUT = 'S'
172000110513     C                   WHEN      ENR@IN = 'THW'
172100110513     C                   EVAL      ENR@OUT = 'C'
172200110513     C                   WHEN      ENR@IN = 'TPC'
172300110513     C                   EVAL      ENR@OUT = 'P'
172400110513     C                   WHEN      ENR@IN = 'TP2'
172500110513     C                   EVAL      ENR@OUT = 'Q'
172600110513     C                   WHEN      ENR@IN = 'TFA'
172700110513     C                   EVAL      ENR@OUT = 'F'
172800110513     C                   ENDSL
172900110513    ***
173000110513     C                   ENDSR
173100110513   S***S
173200110513     C     $WRTERM       BEGSR
173300110513    ***
173400160302     C                   CLEAR                   AET941F
173500110513     C                   EVAL      NTSSNO         = KF@SSN
173600110513     C                   EVAL      NTDEPNO        = KF@SEQ
173700110513     C                   EVAL      NTTERMDT       = KF#TRM
173800110513     C                   EVAL      NTPLAN         = KF@PLN
173900110513     C                   EVAL      NTCOVTP        = KF@ENR
174000110513     C                   EVAL      NTTRST         = KF@TRS
174100110513     C                   EVAL      NTSUB#         = KF@SUB
174200110513     C                   EVAL      NTACCT         = KF@ACC
174300110513     C                   EVAL      NTTRANSDT      = #TODAY
174400160302     C                   WRITE     AET941F
174500110513    ***
174600110513     C                   ENDSR
174700110513   S***S
174800110513     C     $HMOWRT       BEGSR
174900110513    ***
175000110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
175100110513     C                   EVAL      X@ELR = CPCID2                               FILE NUMBER
175200110513     C                   EVAL      M@CC = CACID2                                COMPANY CODE
175300110513     C                   EVAL      M@CLASS = CPCID3                             CLASS CODE
175400110513     C                   EVAL      M@PLAN = CPCID4                              PLAN NUMBER
175500110513    ***
175600110513     C                   EVAL      #XSX = M@FRM(M#CNE)
175700110725     C                   IF        WRT@TYPE = 'DEPEND' AND
175800110725     C                             #XSX < M@MBREFF
175900110725     C                   MOVE      M@MBREFF      X@EFF
176000110725     C                   ELSE
176100110725     C                   MOVE      #XSX          X@EFF
176200110725     C                   ENDIF
176300110513    ***
176400110513     C                   EVAL      #XSX = M@TRM(M#CNE)
176500110513     C                   IF        #XSX = 0 OR #XSX = 99999999
176600110513     C                   MOVE      *BLANKS       X@TRM
176700110513     C                   ELSE
176800110513     C                   MOVE      #XSX          X@TRM
176900110513     C                   ENDIF
177000110513    ***
177100110513     C                   IF        WRT@TYPE = 'MEMBER'
177200110513     C                   EVAL      KF@SEQ = 0
177300110513     C                   EVAL      ENR@IN = M@ENR(M#CNE)
177400110513     C                   EXSR      $ENROLL
177500110513     C                   EVAL      X@TIER = ENR@OUT
177600110513     C                   ELSE
177700110513     C                   EVAL      X@TIER = *BLANKS
177800110513     C                   ENDIF
177900110513    ***
178000140313     C                   EVAL      KF@SPCD = 'MED'
178100140313     C                   EVAL      M@PCP = *BLANKS
178200140313     C                   EVAL      M@NPI = *BLANKS
178300140313     C                   EVAL      M@PCPCI = *BLANKS
178400140313    ***
178500140313     C                   EXSR      $PCP
178600140313    ***
178700140313     C                   IF        DOCTOR <> *BLANKS
178800140313     C                   EVAL      M@PCP = DOCTOR
178900140313     C                   EVAL      M@NPI = 'Y'
179000140313     C                   EVAL      M@PCPCI = '0'
179100140313     C                   ENDIF
179200110513    ***
179300110513     C                   EXCEPT    HMOF
179400110513    ***
179500110513     C                   ENDSR
179600110513   S***S
179700110513     C     $MEAWRT       BEGSR
179800110513    ***
179900110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
180000110513     C                   EVAL      X@ELR = CPCID2                               ELR
180100140313     C                   EVAL      E@SFX = CPCID3                               SUFFIX
180200140313     C                   EVAL      E@ACCT = CPCID4                              ACCOUNT
180300140313     C                   EVAL      E@PLAN = CPCID5                              PLAN
180400140313     C                   EVAL      E@CLM = CPCID6                               CLAIM OFFICE
180500110513    ***
180600110513     C                   EVAL      #XSX = M@FRM(M#CNE)
180700110725     C                   IF        WRT@TYPE = 'DEPEND' AND
180800110725     C                             #XSX < M@MBREFF
180900110725     C                   MOVE      M@MBREFF      X@EFF
181000110725     C                   ELSE
181100110725     C                   MOVE      #XSX          X@EFF
181200110725     C                   ENDIF
181300110513    ***
181400110513     C                   EVAL      #XSX = M@TRM(M#CNE)
181500110513     C                   IF        #XSX = 0 OR #XSX = 99999999
181600110513     C                   MOVE      *BLANKS       X@TRM
181700110513     C                   ELSE
181800110513     C                   MOVE      #XSX          X@TRM
181900110513     C                   ENDIF
182000110513    ***
182100140313     C                   MOVE      *BLANKS       E@CBREXP
182200140313     C                   MOVE      *BLANKS       E@CBREVT
182300140313     C                   MOVE      *BLANKS       E@CBRLEN
182400140313     C                   IF        WRT@TYPE = 'MEMBER'
182500140425     C                   IF        EMPST = 'C' AND
182600140425     C                             CEXPDT > 0
182700140313     C                   MOVE      CEXPDT        E@CBREXP
182800140313     C                   MOVE      QEDT          E@CBREVT
182900140313     C                   MOVE      CEXPDT        #MINUEND
183000140313     C                   MOVE      QEDT          #SUBTRAEND
183100140313     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
183200140313     C                   Z-ADD     #DIFFRNC      #2S0
183300140313     C                   MOVE      #2S0          E@CBRLEN
183400140313     C                   ENDIF
183500140313     C                   ENDIF
183600140313    ***
183700140313     C                   EVAL      *IN80 = *OFF
183800140313     C                   EVAL      KF@SPCD = 'MED'
183900140313     C                   EVAL      E@PCP = *BLANKS
184000140313     C                   EXSR      $PCP
184100140313     C                   IF        DOCTOR <> *BLANKS
184200140313     C                   EVAL      E@PCP = DOCTOR
184300140313     C                   EVAL      *IN80 = *ON
184400140313     C                   ENDIF
184500140313    ***
184600140313     C                   EXCEPT    MEAF
184700110513    ***
184800110513     C                   ENDSR
184900110513   S***S
185000140313     C     $PCP          BEGSR
185100140313    ***
185200140313     C                   MOVE      *BLANKS       DOCTOR            7
185300140313     C     KL#SQPCD      CHAIN     PCPR
185400140313     C                   IF        NOT %FOUND(PCPL1)
185500140313     C                   LEAVESR
185600140313     C                   ENDIF
185700140313     C     KL#SQPCD      SETLL     PCPR
185800140313     C                   DOU       %EOF(PCPL1)
185900140313     C     KL#SQPCD      READE     PCPR
186000140313     C                   IF        NOT %EOF(PCPL1) AND PCCAN = 0
186100140313     C                   MOVEL(P)  PCID#         DOCTOR
186200140313     C                   LEAVESR
186300140313     C                   ENDIF
186400140313     C                   ENDDO
186500140313    ***
186600140313     C                   ENDSR
186700140313   S***S
186800110513     C     $CLRDCV       BEGSR
186900110513    ***
187000110513     C                   MOVE      *BLANKS       @LN
187100110513     C                   MOVEL     *BLANKS       @FN
187200110513     C                   EVAL      @SS2   = *BLANKS
187300110513     C                   EVAL      @MI    = *BLANKS
187400110513     C                   EVAL      @REL   = *BLANKS
187500110513     C                   EVAL      @SEX   = *BLANKS
187600110513     C                   EVAL      @DOB   = *BLANKS
187700110513     C                   EVAL      @SPEC  = *BLANKS
187800110513     C                   EVAL      @COB   = *BLANKS
187900110513     C                   EVAL      @COBC  = *BLANKS
188000110513     C                   EVAL      @COBN  = *BLANKS
188100110513    ***
188200110513     C                   EVAL      #CANCEL = 0
188300110513     C                   EVAL      D#CNE = 0
188400110513     C                   CLEAR                   D@PLN
188500110513     C                   CLEAR                   D@ENR
188600110513     C                   CLEAR                   D@FRM
188700110513     C                   CLEAR                   D@TRM
188800110513     C                   EVAL      M#CNE = 0
188900110513     C                   CLEAR                   M@PLN
189000110513     C                   CLEAR                   M@ENR
189100110513     C                   CLEAR                   M@FRM
189200110513     C                   CLEAR                   M@TRM
189300110513    ***
189400110513     C                   ENDSR
189500110513   S***S
189600110513     C     $DENWRT       BEGSR
189700110513    ***
189800110513    *C                   EVAL      X@LAY = CPCID1                               LAYOUT
189900110513    *C                   EVAL      X@ELR = CPCID2                               ELR
190000110513    *C                   EVAL      D@SFX = CPCID3                               SUFFIX
190100110513    *C                   EVAL      D@ACCT = CPCID4                              ACCOUNT
190200110513    *C                   EVAL      D@PLAN = CPCID5                              PLAN
190300110513    *C                   EVAL      D@CLM = CPCID6                               CLAIM OFFICE
190400110524     C                   EVAL      DNTLATE = '0'
190500110513    ***
190600110513    *C                   EVAL      #XSX = D@FRM(D#CNE)
190700110725     C                   IF        WRT@TYPE = 'DEPEND' AND
190800110725     C                             #XSX < D@MBREFF
190900110725     C                   MOVE      D@MBREFF      X@EFF
191000110725     C                   ELSE
191100110725     C                   MOVE      #XSX          X@EFF
191200110725     C                   ENDIF
191300110513    ***
191400110513    *C                   EVAL      #XSX = D@TRM(D#CNE)
191500110513    *C                   IF        #XSX = 0 OR #XSX = 99999999
191600110513    *C                   MOVE      *BLANKS       X@TRM
191700110513    *C                   ELSE
191800110513    *C                   MOVE      #XSX          X@TRM
191900110513    *C                   ENDIF
192000110513    ***
192100130211     C                   MOVE      *BLANKS       D@CBREXP
192200130211     C                   MOVE      *BLANKS       D@CBREVT
192300130211     C                   MOVE      *BLANKS       D@CBRLEN
192400110513     C                   IF        WRT@TYPE = 'MEMBER'
192500111123    *C                   IF        EMPST = 'C' AND CEXPDT <> 0
192600110513    *C                   MOVE      CEXPDT        D@CBREXP
192700110513    *C                   MOVE      QEDT          D@CBREVT
192800110513    *C                   MOVE      CEXPDT        #MINUEND
192900110513    *C                   MOVE      QEDT          #SUBTRAEND
193000110513    *C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
193100110513    *C                   Z-ADD     #DIFFRNC      #2S0
193200110513    *C                   MOVE      #2S0          D@CBRLEN
193300110513    *C                   ENDIF
193400110513    *C                   ENDIF
193500120806    ***
193600110513    *C                   MOVE      '0'           D@OOAI
193700140313    ***
193800140313     C                   EVAL      KF@SPCD = 'DEN'
193900140313     C                   EVAL      D@PCD = *BLANKS
194000140313     C                   EVAL      *IN81 = *OFF
194100140313     C                   MOVE      *BLANKS       DOCTOR
194200140313    ***
194300140313     C                   EXSR      $PCP
194400140313    ***
194500140313     C                   IF        DOCTOR <> *BLANKS
194600140313     C                   EVAL      D@PCD = DOCTOR
194700140313     C                   EVAL      *IN81 = *ON
194800140313     C                   ENDIF
194900110513    ***
195000120123     C     *LIKE         DEFINE    H@C#          BUC#
195100120123     C                   EVAL      BUC# = H@C#
195200120123    ***
195300120327     C                   SELECT
195400131126     C                   WHEN      KF@TRS = 591 AND KF@SUB = 009 AND            WILMOT MODULAR
195500131126     C                             KF@ACC = 0202                                 STRUCTURES
195600131227     C                   EVAL      H@C# = '0638156'
195700140702     C                   WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            REDLAND
195800140702     C                             KF@ACC = 0475                                 BAPTISTS
195900140702     C                   EVAL      H@C# = '0725572'
196000120327     C                   WHEN      KF@TRS = 825 AND KF@SUB = 001 AND            CREATIVE
196100120123     C                             KF@ACC = 0014                                 LOGISTICS
196200120123     C                   EVAL      H@C# = '0133860'
196300130905     C                   WHEN      KF@TRS = 905 AND KF@SUB = 001 AND            CCL USA
196400130905     C                             KF@ACC = 0092
196500130905     C                   EVAL      H@C# = '0638423'
196600140423     C                   WHEN      KF@TRS = 003 AND KF@SUB = 001 AND            FRAME RITE
196700140423     C                             KF@ACC = 0104
196800140423     C                   EVAL      H@C# = '0306511'
196900130520     C                   WHEN      KF@TRS = 900 AND KF@SUB = 003 AND            PERFECT
197000130520     C                             KF@ACC = 0045                                 SETTINGS
197100130520     C                   EVAL      H@C# = '0474109'
197200121024     C                   WHEN      KF@TRS = 591 AND KF@SUB = 011 AND            MCCALLISTER
197300121024     C                             KF@ACC = 0446                                 ARCHITECT
197400121024     C                   EVAL      H@C# = '0565330'
197500130716     C                   WHEN      KF@TRS = 591 AND KF@SUB = 005 AND            JD CLARK PROF
197600130716     C                             KF@ACC = 0451                                 SERVICES
197700130716     C                   EVAL      H@C# = '0519890'
197800130627     C                   WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            DYSON CONSTRUCTION
197900130627     C                             KF@ACC = 0459                                 COMPANY
198000130627     C                   EVAL      H@C# = '0788122'
198100130903     C                   WHEN      KF@TRS = 591 AND KF@SUB = 004 AND            STROUSE CORP
198200130903     C                             KF@ACC = 0482
198300130903     C                   EVAL      H@C# = '0837451'
198400130712     C                   WHEN      KF@TRS = 900 AND KF@SUB = 007 AND            CAPLAN BROTHERS
198500130712     C                             KF@ACC = 0075
198600130712     C                   EVAL      H@C# = '0837533'
198700120806     C                   WHEN      KF@TRS = 900 AND KF@SUB = 101 AND            INTEGRA HEALTH
198800130110     C                             KF@ACC = 0042 AND
198900130110     C                             (STATE = 'TN' OR STATE = 'FL' OR
199000130718     C                              STATE = 'OH' OR STATE = 'MA') AND
199100120806     C                             (@PLANIN = 'DAAD' OR @PLANIN = 'BAAD')
199200120806     C                   EVAL      H@C# = '0503428'
199300120327    *C                   ENDSL
199400120123    ***
199500110513    *C                   EXCEPT    DENF
199600151217     c                   EVAL      H@C# = BUC#
199700110513    ***
199800110513    *C                   ENDSR
199900110513   S***S
200000160329
200100160329      *========================================================================
200200160329
200300160302     OAET940WF  EADD         HDRF
200400101203     O                                            6 'HEADER'
200500160329     O                                            8 'P'
200600101206     O                       H@SI                28
200700101203     O                                           29 '0'
200800101203     O                       C1                  43
200900101203     O                       D1                  51
201000101203     O                       T1                  57
201100101206     O                                          131 'CONSOLIDATED ELIGIBILITY'
201200110502     O                       H@RI               167
201300101206     O                       H@CC               169
201400101228     O                       H@GN               176
201500101206     O                       H@CN               191
201600101206     O                       H@C#               198
201700101203     O                       D2                 206
201800110825     O                                          216 'MC'
201900101223     O                                          231 '*'
202000160329
202100160302     OAET940WF  EADD         MBRF
202200101203     O                                            6 'MEMBER'
202300101203     O                       @SS1                16
202400101203     O                       @SS2                25
202500101203     O                       @FN                 75
202600101203     O                       @MI                 76
202700101203     O                       @LN                 96
202800101203     O                       @REL               101
202900101203     O                       @SEX               103
203000101203     O                       @DOB               111
203100101203     O                       @SPEC              112
203200101203     O                                          113 '0'
203300101203     O                       @COB               123
203400101203     O                       @COBC              125
203500101203     O                       @COBN              145
203600101203     O                       @AD1               175
203700101203     O                       @AD2               205
203800101203     O                       @CTY               315
203900101203     O                       @ST                317
204000101203     O                       @ZP5               322
204100101203     O                       @PHN               349
204200141211     O               87                         576 '21207'
204300140626     O               88                         576 '21740'
204400141120     O               89                         576 '20171'
204500101203     O                       @EMPST             665
204600101203     O                       @HIRE              673
204700101223     O                                         1231 '*'
204800160329
204900160302     OAET940WF  EADD         HMOF
205000101213     O                                            7 'BENEFIT'
205100101213     O                       X@LAY               10
205200101214     O                       X@ELR               24
205300101213     O                       M@CC                26
205400101213     O                       H@GN                38
205500101213     O                       M@CLASS             44
205600101213     O                       M@PLAN              50
205700101213     O                       X@EFF               58
205800110929     O                       X@TRM               66
205900101213     O                       X@TIER              69
206000101213     O                       M@PCP              160
206100101213     O                       M@NPI              161
206200101213     O                       M@PCPCI            186
206300101223     O                                          323 '*'
206400160329
206500160302     OAET940WF  EADD         MEAF
206600140313     O                                            7 'BENEFIT'
206700140313     O                                           10 'MEA'
206800140313     O                       X@ELR               24
206900140313     O                       H@C#                31
207000140313     O                       E@SFX               34
207100140313     O                       E@ACCT              44
207200140313     O                       E@PLAN              50
207300140313     O                       X@EFF               58
207400140313     O                       X@TRM               66
207500140313     O                       E@CLM               71
207600140313     *** PCP BGN
207700140313     O                       E@PCP              127
207800140313     O               80                         161 'N'
207900140313     O               80                         186 '0'
208000140313     *** PCP END
208100140313     O                                          389 '0'
208200140313     *** COBRA BGN
208300140313     O                       E@CBREXP           466
208400140313     O                       E@CBREVT           516
208500140313     O                       E@CBRLEN           560
208600140313     *** COBRA END
208700140313     O                                          678 '*'
208800160329
208900160302     OAET940WF  EADD         DENF
209000101213     O                                            7 'BENEFIT'
209100101213     O                       X@LAY               10
209200101214     O                       X@ELR               24
209300101214     O                       H@C#                31
209400101213     O                       D@SFX               34
209500101213     O                       D@ACCT              44
209600101213     O                       D@PLAN              50
209700101213     O                       X@EFF               58
209800110929     O                       X@TRM               66
209900101213     O                       D@CLM               71
210000140313     *** PCD BGN
210100140313     O                       D@PCD              200
210200140313     O               81                         236 '0'
210300140313     *** PCD END
210400140313     O                                          389 '0'
210500140313     *** COBRA BGN
210600140313     O                       D@CBREXP           466
210700140313     O                       D@CBREVT           516
210800140313     O                       D@CBRLEN           560
210900140313     *** COBRA END
211000140313     O                       D@OOAI             609
211100140313     O                                          678 '*'
211200160329
211300160302     OAET940WF  EADD         LIFF
211400130315     O                                            7 'BENEFIT'
211500130412     O                                           11 'LIFE'
211600130315     O                       X@ELR               24
211700130319     O                       H@C#3               31
211800130315     O                       L@SFX               34
211900130315     O                       L@ACCT              44
212000130315     O                       L@PLAN              50
212100130315     O                       X@EFF               58
212200130315     O                       X@TRM               66
212300130315     O                       L@CLM               71
212400130315     O                       L@CBREXP           466
212500130315     O                       L@CBREVT           516
212600130315     O                       L@CBRLEN           560
212700130315     O                       L@SALARY           658
212800130315     O                                          659 '1'
212900130315     O                                          678 '*'
213000160329
213100160302     OAET940WF  EADD         TRLF
213200101203     O                                            7 'TRAILER'
213300101203     O                       @TREC               17
213400101203     O                       D1                  25
213500101203     O                       T1                  31
213600101203     O                       @BREC               41
213700101223     O                                           69 '*'
213800160329
213900160329      *=======================================================================
214000160329
