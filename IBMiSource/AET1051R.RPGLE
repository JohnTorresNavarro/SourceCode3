000100160616      *=================================================================================
000200160314     H option(*noDebugIo)
000300160314      *=================================================================================
000400160314
000500160616      *  CARRIER CONTROL ID #0000000127 AETNA SPECIFIC
000600160616      *  SSK 05.13.2011 TEMPLATE DESIGN
000700160616      *
000800160616      *  08.17.2014 CLONED FROM AET084R
000900160616      *
001000160616      *
001100160314      *=================================================================================
001200160314
001300151217     FCARXPTP   IF   E           K DISK
001400151217      * Carrier export control master
001500151217
001600101012     FCARACCP   IF   E           K DISK
001700151217      * Carrier export control by account
001800151217
001900101012     FCARPLNP   IF   E           K DISK
002000151217      * Carrier export control by plan
002100151217
002200160615     FAET004WF  IF   E           K DISK
002300120803     ** MAPPING METHOD
002400151217
002500160809     FAET1050WF O  A F 1231        DISK
002600101206     ** FLAT FILE
002700151217
002800160809     FAET1051WF IF A E           K DISK
002900101028     ** TERM TRACKER
003000151217
003100160616     FMEMAC#1   IF   E           K DISK    ExtFile('F.MEMAC#1')
003200151217
003300160616     FMCOVMPLN  IF   E           K DISK
003400151217
003500160616     FDEPNDC    IF   E           K DISK    ExtFile('F.DEPNDC')
003600151217
003700101012     FDCOVA     IF   E           K DISK
003800151217
003900160616     FPCPL1     IF   E           K DISK     ExtFile('F.PCPL1')
004000151217
004100160616      *=================================================================================
004200160616
004300120803     D KF@CCTL         S             10A   INZ
004400160314
004500160314     D CARR#CTL        S             10A
004600160314     D grouper         S             10A
004700160314
004800160809     D H@RI            S             25A   INZ('042064683')                     RECEIVER ID
004900151217
005000110512     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
005100101026     D DS@CARACC     E DS                  EXTNAME(CARACCP)
005200130315     D*DS@CARXPT     E DS                  EXTNAME(CARXPTP)
005300151217
005400110512     ** WORK ARRAY FOR PLANS
005500110512     **
005600110512     ** PC# - PLAN COUNT
005700110512     ** PP# - PLAN POINTER
005800110512     **
005900110512     D CARPLN@       E DS                  EXTNAME(CARPLNP)
006000151217     D                                     OCCURS(90) PREFIX(X:1)
006100110512     D PC#             S              3S 0
006200110512     D PP#             S              3S 0
006300110512     D @PLANIN         S              4A
006400110512     D @CCTRIN         S              3A
006500160616
006600110513     ** WRITE TYPE = MEMBER OR DEPEND
006700110513     D WRT@TYPE        S              6A
006800110513     **
006900101214     D #XST            S              6S 0
007000101214     D #IST            S               T
007100101026     D #ISO            S               D   DATFMT(*ISO)
007200101214     D #MINUEND        S               D   DATFMT(*ISO)
007300101214     D #SUBTRAEND      S               D   DATFMT(*ISO)
007400101214     D @DATE           S              8A
007500101214     D @TIME           S              6A
007600101214     D #DIFFRNC        S              5S 0
007700101214     D #2S0            S              2S 0
007800101214     D #CANCEL         S              8S 0
007900101026     D #XSX            S              8S 0
008000101026     D #XSX2           S              8S 0
008100101026     D DATE@OUT        S             10A
008200101026     D ENR@IN          S              3A
008300101026     D ENR@OUT         S              1A
008400110524     D DNTLATE         S              1A
008500130315     D TERM_LIF        S               N
008600101214     D TERM_DEN        S               N
008700101214     D TERM_MED        S               N
008800101026     D YES             S               N   INZ(*ON)
008900101026     D NO              S               N   INZ(*OFF)
009000160315
009100160315     D firstTime       S              1    INZ('Y')
009200140313     **
009300110512     D KF@TRS          S                   LIKE(MCTRST)
009400110512     D KF@SUB          S                   LIKE(MCSUB#)
009500110512     D KF@ACC          S                   LIKE(ACC#)
009600101026     D KF@ENR          S              3A   INZ
009700101026     D KF@CARG         S              2A   INZ
009800101026     D KF@CCTR         S                   LIKE(CCFLG)
009900101026     D KF@PLN          S                   LIKE(MCPLAN)
010000101026     D KF@TRM          S                   LIKE(NTTERMDT)
010100101026     D KF#TRM          S              8S 0
010200101026     D KF@SSN          S                   LIKE(MBSSNO)
010300101026     D KF@SEQ          S                   LIKE(DPSEQ#)
010400101026     D KF@TYP          S              1A
010500101026     D KF@CDE          S              2A
010600140313     D KF@SPCD         S              5A
010700140313     D KF@MPLN         S              4A
010800140313     **
010900101026     D M@EARLYP        S              4A
011000101026     D M#EARLYE        S              8S 0 INZ
011100101026     D M#EARLYT        S              8S 0 INZ
011200140313     **
011300101026     D #8D1            S              8S 0 INZ
011400101214     D D1              S              8A
011500101214     D D2              S              8A
011600101214     D T1              S              6A
011700101214     D C1              S             14A
011800101206    ***
011900101029     D B#RECCNT        S             10S 0 INZ
012000101029     D C#RECCNT        S             10S 0 INZ
012100101206    ***
012200101210     D @SS1            S              9A
012300101210     D @SS2            S              9A
012400101210     D @FN             S             15A
012500101210     D @MI             S              1A
012600101210     D @LN             S             20A
012700101210     D @REL            S              2A
012800101210     D @SEX            S              1A
012900101210     D @DOB            S              8A
013000101210     D @SPEC           S              1A
013100101210     D @COB            S              1A
013200101210     D @COBC           S              2A
013300101210     D @COBN           S             20A
013400101210     D @AD1            S             30A
013500101210     D @AD2            S             30A
013600101214     D @CTY            S             20A
013700101210     D @ST             S              2A
013800101210     D @ZP5            S              5A
013900101210     D @PHN            S             10A
014000101210     D @EMPST          S              2A
014100101210     D @HIRE           S              8A
014200160616
014300130315    *** LIFE ARRAYS
014400130315     D L#CNE           S              3S 0 INZ
014500130315     D L#NDX           S              3S 0 INZ
014600130315     D L@PLN           S              4A   DIM(20)
014700130315     D L@ENR           S              3A   DIM(20)
014800130315     D L@FRM           S              8S 0 DIM(20)
014900130315     D L@TRM           S              8S 0 DIM(20)
015000130315     D L@MBREFF        S              8S 0
015100160616
015200101206    *** DENTAL ARRAYS
015300101206     D D#CNE           S              3S 0 INZ
015400101206     D D#NDX           S              3S 0 INZ
015500101206     D D@PLN           S              4A   DIM(20)
015600101206     D D@ENR           S              3A   DIM(20)
015700101206     D D@FRM           S              8S 0 DIM(20)
015800101206     D D@TRM           S              8S 0 DIM(20)
015900160616     D D@MBREFF        S              8S 0
016000160616
016100101206    *** MEDICAL ARRAYS
016200101206     D M#CNE           S              3S 0 INZ
016300101206     D M#NDX           S              3S 0 INZ
016400101206     D M@PLN           S              4A   DIM(20)
016500101206     D M@ENR           S              3A   DIM(20)
016600101206     D M@FRM           S              8S 0 DIM(20)
016700101206     D M@TRM           S              8S 0 DIM(20)
016800110725     D M@MBREFF        S              8S 0
016900101206    ***
017000101206     D H@SI            S             20A
017100101206     D H@CC            S              2A
017200101206     D H@GN            S              7A
017300101206     D H@CN            S             15A
017400101206     D H@C#            S              7A
017500130319     D H@C#3           S              7A
017600140313    ***
017700101213     D X@LAY           S              3A
017800101213     D X@ELR           S              7A
017900140313     D X@EFF           S              8A
018000140313     D X@TRM           S              8A
018100140313     D X@TIER          S              1A
018200140313    ***
018300101213     D M@CC            S              2A
018400101213     D M@CLASS         S              5A
018500101213     D M@PLAN          S              6A
018600101213     D M@PCP           S             40A
018700101213     D M@NPI           S              1A
018800101213     D M@PCPCI         S              1A
018900140313    ***
019000101213     D D@SFX           S              3A
019100101213     D D@ACCT          S              5A
019200101213     D D@PLAN          S              6A
019300101213     D D@CLM           S              3A
019400101213     D D@CBREXP        S              8A
019500101213     D D@CBREVT        S              8A
019600101213     D D@CBRLEN        S              2A
019700101213     D D@OOAI          S              1A
019800140313     D D@PCD           S              7A
019900140313    ***
020000101214     D @STEP           S              5A
020100140313    ***
020200140313     D E@SFX           S              3A
020300140313     D E@ACCT          S              5A
020400140313     D E@PLAN          S              6A
020500140313     D E@CLM           S              3A
020600140313     D E@PCP           S              7A
020700140313     D E@CBREXP        S              8A
020800140313     D E@CBREVT        S              8A
020900140313     D E@CBRLEN        S              2A
021000140313    ***
021100130315     D L@SFX           S              3A
021200130315     D L@ACCT          S              5A
021300130315     D L@PLAN          S              6A
021400130315     D L@CLM           S              3A
021500130315     D L@CBREXP        S              8A
021600130315     D L@CBREVT        S              8A
021700130315     D L@CBRLEN        S              2A
021800130315     D L@SALARY        S             20A
021900140313    ***
022000160616      *=================================================================================
022100160616
022200110512     C                   EVAL      @STEP = 'PREP1'
022300160616
022400160831     C                   EVAL      KF@CCTL = CARR#CTL
022500160831     C     KF@CCTL       CHAIN     CARXPTR
022600160315     C****               EXSR      $HEADR
022700160616
022800160831     C     KF@CCTL       SETLL     CARACCR
022900160616
023000101026     C                   DOU       @STEP = 'LEAVE'
023100101026     C     @STEP         CASEQ     'PREP1'       $PREP1
023200101026     C     @STEP         CASEQ     'STEP1'       $STEP1
023300101026     C     @STEP         CASEQ     'STEP2'       $STEP2
023400101026     C     @STEP         CASEQ     'STEP3'       $STEP3
023500101026     C     @STEP         CASEQ     'PREP4'       $PREP4
023600101026     C     @STEP         CASEQ     'STEP4'       $STEP4
023700101026     C     @STEP         CASEQ     'PREP5'       $PREP5
023800101026     C     @STEP         CASEQ     'STEP5'       $STEP5
023900101214     C     @STEP         CASEQ     'PREP6'       $PREP6
024000101026     C     @STEP         CASEQ     'STEP6'       $STEP6
024100101214     C     @STEP         CASEQ     'PREP7'       $PREP7
024200101214     C     @STEP         CASEQ     'STEP7'       $STEP7
024300101214     C     @STEP         CASEQ     'STEP8'       $STEP8
024400101214     C     @STEP         CASEQ     'PREP9'       $PREP9
024500101214     C     @STEP         CASEQ     'STEP9'       $STEP9
024600101214     C     @STEP         CASEQ     'PREPA'       $PREPA
024700101214     C     @STEP         CASEQ     'STEPA'       $STEPA
024800101214     C     @STEP         CASEQ     'PREPB'       $PREPB
024900101214     C     @STEP         CASEQ     'STEPB'       $STEPB
025000130315     C     @STEP         CASEQ     'PREPC'       $PREPC
025100130315     C     @STEP         CASEQ     'STEPC'       $STEPC
025200101026     C                   ENDCS
025300101026     C                   ENDDO
025400160616
025500101206    ***  TRAILER RECORD
025600101026     C                   ADD       2             C#RECCNT
025700101214     C                   MOVE      C#RECCNT      @TREC            10 0
025800101214     C                   MOVE      B#RECCNT      @BREC            10 0
025900101214     C                   EXCEPT    TRLF
026000160616
026100101026     C                   EVAL      *INLR = *ON
026200160616
026300160616      *============================================================================
026400160616
026500110802     C     $HEADR        BEGSR
026600160616
026700110802     C                   EVAL      D1 = @DATE
026800110802     C                   EVAL      D2 = @DATE
026900110802     C                   EVAL      T1 = @TIME
027000110802     C                   EVAL      C1 = @DATE + @TIME
027100160616
027200160315     C**** carr#ctl      CHAIN     CARACCR
027300160616
027400110802     C                   EVAL      H@SI = %TRIM(CACID1)                         SUBMITTER ID
027500110802     C                   EVAL      H@CC = %SUBST(CACID2:1:2)                    COMPANY CODE
027600110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
027700110802     C                   MOVEL(P)  CACID4        H@CN                           CUSTOMER NAME
027800110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
027900130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
028000160616
028100110802     C                   EXCEPT    HDRF
028200160616
028300160315     C                   eval      firstTime = 'N'
028400160315
028500110802     C                   ENDSR
028600160616
028700160616      *============================================================================
028800110802     C     $PREP1        BEGSR
028900160616
029000160831     C     KF@CCTL       READE     CARACCR
029100160616
029200110512     C                   IF        %EOF(CARACCP)
029300120803      *
029400120815     C*                  IF        KF@CCTL = CARR#CTL
029500120815     C*                  EVAL      KF@CCTL = CARR#CTL2
029600120815     C*    KF@CCTL       SETLL     CARACCR
029700120815     C*                  ELSE
029800110512     C                   EVAL      @STEP = 'LEAVE'
029900120815     C*                  ENDIF
030000120803      *
030100110512     C                   LEAVESR
030200110512     C                   ENDIF
030300160616
030400110513    *** HAS THE ACCOUNT BEEN SHUTOFF FOR EXPORT?
030500110512     C                   IF        CASTATUS <> 'Y'
030600110512     C                   LEAVESR
030700110512     C                   ENDIF
030800160314
030900160314     C                   if        cacida <> grouper
031000160314     C                   leavesr
031100160314     C                   endif
031200160315
031300160315     c                   if        firstTime = 'Y'
031400160315     c                   exsr      $headr
031500160315     c                   endif
031600160315
031700110802    *** THESE FIELDS RESET FOR EACH SMALL GROUP READ
031800110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
031900110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
032000130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
032100160616
032200110512     C                   EVAL      KF@TRS = CATRST
032300110512     C                   EVAL      KF@SUB = CASUB#
032400110512     C                   EVAL      KF@ACC = CAACCT
032500160616
032600110512     C                   EXSR      $PLANLOAD
032700160616
032800101206     C                   EVAL      @STEP = 'STEP1'
032900160616
033000110512     C                   ENDSR
033100160616
033200160616      *============================================================================
033300160616
033400101206     C     $STEP1        BEGSR
033500160616
033600101206     C                   EVAL      KF@PLN = *BLANKS
033700101206     C                   EVAL      KF@TRM = 0
033800101206     C                   EVAL      KF@SSN = 0
033900101206     C                   EVAL      KF@SEQ = 0
034000160616
034100101206     C     KL#TSA        SETLL     MEMBR
034200160616
034300101206     C                   EVAL      @STEP = 'STEP2'
034400160616
034500101206     C                   ENDSR
034600160616
034700160616      *============================================================================
034800160616
034900101206     C     $STEP2        BEGSR
035000160616
035100101206     C     KL#TSA        READE     MEMBR
035200160616
035300101206     C                   IF        %EOF(MEMAC#1)
035400110512     C                   EVAL      @STEP = 'PREP1'
035500101206     C                   LEAVESR
035600101206     C                   ENDIF
035700160616
035800101206     C                   EVAL      KF@SSN = MBSSNO
035900101214     C                   MOVE      *ZEROS        KF@SEQ
036000120803     C                   EVAL      WRT@TYPE = 'MEMBER'
036100160616
036200101206     C     KL#MPLN       SETLL     MCOVR
036300160616
036400101206     C                   EXSR      $CLRSTG
036500160616
036600101206     C                   EVAL      @STEP = 'STEP3'
036700160616
036800101206     C                   ENDSR
036900160616
037000160616      *============================================================================
037100160616
037200101206     C     $STEP3        BEGSR
037300160616
037400101206     C     KL#MPLN       READE     MCOVR
037500160616
037600101206     C                   IF        %EOF(MCOVMPLN)
037700101206     C                   EVAL      @STEP = 'PREP4'
037800101206     C                   LEAVESR
037900101206     C                   ENDIF
038000160616
038100130131     C*                  IF        ENRLDT = CANDT
038200130131     C*                  LEAVESR
038300130131     C*                  ENDIF
038400160616
038500120803     C                   EVAL      KF@PLN = MCPLAN
038600160615     C     KL#TSAP       CHAIN     AEF04
038700160615     C                   IF        NOT %FOUND(AET004WF)
038800120803     C                   LEAVESR
038900120803     C                   ENDIF
039000160616
039100110512     C                   EVAL      @PLANIN = MCPLAN
039200111020     C                   EVAL      ENR@IN = MCOVTP
039300160616
039400110802     C                   EXSR      $QUIK
039500160616
039600110512     C                   EXSR      $PLANSRCH
039700160616
039800110512     C                   IF        PLN@CAT = *BLANKS
039900110512     C                   LEAVESR
040000110512     C                   ENDIF
040100160616
040200101206     C                   IF        CANDT = 0
040300101206     C                   EVAL      #CANCEL = 99999999
040400101206     C                   ELSE
040500101206     C                   EVAL      #CANCEL = CANDT
040600101206     C                   ENDIF
040700160616
040800130315    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL;
040900130315    *** LIF IS LIFE;
041000130315     C                   SELECT
041100160616
041200160616     C                   WHEN      PLN@CAT = 'LIFE'
041300160616     C                   IF        L#CNE > 0
041400160616     C                   IF        L@TRM(L#CNE) = 99999999
041500130315     C                   LEAVESR
041600130315     C                   ENDIF
041700130315     C                   ENDIF
041800160616     C                   ADD       1             L#CNE
041900160616     C                   EVAL      L@PLN(L#CNE) = MCPLAN
042000160616     C                   EVAL      L@ENR(L#CNE) = MCOVTP
042100160616     C                   EVAL      L@FRM(L#CNE) = ENRLDT
042200160616     C                   EVAL      L@TRM(L#CNE) = #CANCEL
042300160616
042400160616     C                   WHEN      PLN@CAT = 'DEN'
042500160616     C                   IF        D#CNE > 0
042600160616     C                   IF        D@TRM(D#CNE) = 99999999
042700130131     C                   LEAVESR
042800130131     C                   ENDIF
042900130131     C                   ENDIF
043000160616     C                   ADD       1             D#CNE
043100160616     C                   EVAL      D@PLN(D#CNE) = MCPLAN
043200160616     C                   EVAL      D@ENR(D#CNE) = MCOVTP
043300160616     C                   EVAL      D@FRM(D#CNE) = ENRLDT
043400160616     C                   EVAL      D@TRM(D#CNE) = #CANCEL
043500160616
043600130315     C                   OTHER
043700160616     C                   IF        M#CNE > 0
043800160616     C                   IF        M@TRM(M#CNE) = 99999999
043900130131     C                   LEAVESR
044000130131     C                   ENDIF
044100130131     C                   ENDIF
044200101206     C                   ADD       1             M#CNE
044300101206     C                   EVAL      M@PLN(M#CNE) = MCPLAN
044400101206     C                   EVAL      M@ENR(M#CNE) = MCOVTP
044500101206     C                   EVAL      M@FRM(M#CNE) = ENRLDT
044600101206     C                   EVAL      M@TRM(M#CNE) = #CANCEL
044700160616
044800160616     C                   ENDSL
044900160616
045000110512     C                   ENDSR
045100160616
045200160616      *============================================================================
045300160616
045400110802     C     $QUIK         BEGSR
045500160616
045600110805     C                   EVAL      @CCTRIN = *BLANKS
045700160616
045800160615     C     AE4MAP        CASEQ     '2TIER     '  $METH01
045900160615     C     AE4MAP        CASEQ     'ITOBJECTS '  $METH02
046000160615     C     AE4MAP        CASEQ     'NORULE    '  $METH03
046100160615     C     AE4MAP        CASEQ     'STATETIER '  $METH04
046200160615     C     AE4MAP        CASEQ     'TIERSTS   '  $METH05
046300160615     C     AE4MAP        CASEQ     'MAYOR     '  $METH06
046400160615     C     AE4MAP        CASEQ     'EMPSTS    '  $METH07
046500160615     C     AE4MAP        CASEQ     'JUSTSTATE '  $METH08
046600160615     C     AE4MAP        CASEQ     'JOHNLS    '  $METH09
046700160615     C     AE4MAP        CASEQ     'CREATIVE  '  $METH10
046800160615     C     AE4MAP        CASEQ     'INTEGRA   '  $METH11
046900160615     C     AE4MAP        CASEQ     'STSTATE   '  $METH12
047000160615     C     AE4MAP        CASEQ     'INTEGRA   '  $METH11
047100160615     C     AE4MAP        CASEQ     'STIERSTS  '  $METH13
047200120803     C                   ENDCS
047300160616
047400120803     C                   ENDSR
047500160616
047600160616      *============================================================================
047700160616
047800160616      * 2 TIER = AETNA HAS TWO TIERS, IND AND FAM
047900160616      *  MEMBERS HAVE 'TIN' CONVERTED TO 'IND' AND NON-'TIN' CONVERTED TO 'FAM'
048000160616      *  DEPENDENTS HAVE 'FAM' ONLY
048100160616      *
048200160616      * IND, FAM
048300160616
048400160616      *============================================================================
048500160616
048600120803     C     $METH01       BEGSR
048700160616
048800120803     C                   IF        WRT@TYPE = 'MEMBER'
048900160616
049000120803     C                   IF        ENR@IN = 'TIN'
049100120803     C                   EVAL      @CCTRIN = 'IND'
049200120803     C                   ELSE
049300120803     C                   EVAL      @CCTRIN = 'FAM'
049400120803     C                   ENDIF
049500160616
049600120803     C                   ENDIF
049700160616
049800120803     C                   IF        WRT@TYPE = 'DEPEND'
049900160616
050000120803     C                   EVAL      @CCTRIN = 'FAM'
050100160616
050200120803     C                   ENDIF
050300160616
050400120803     C                   ENDSR
050500160616
050600160616      *============================================================================
050700160616
050800160616      * ITOBJECTS = IF YOU ARE NOT 'VA' OR 'OH' STATE CODES, YOU ARE 'XX'
050900160616
051000160616      * VA, OH, XX
051100160616
051200160616      *============================================================================
051300160616
051400120803     C     $METH02       BEGSR
051500160616
051600120803     C                   IF        STATE <> 'VA' AND STATE <> 'OH'
051700120803     C                   EVAL      @CCTRIN = 'XX '
051800120803     C                   ELSE
051900120803     C                   EVAL      @CCTRIN = STATE
052000120803     C                   ENDIF
052100160616
052200120803     C                   ENDSR
052300160616
052400160616      *============================================================================
052500160616      * NORULE = NUFF SAID
052600160616      *============================================================================
052700160616
052800120803     C     $METH03       BEGSR
052900160616
053000120803     C                   EVAL      @CCTRIN = *BLANKS
053100160616
053200120803     C                   ENDSR
053300160616
053400160616      *============================================================================
053500160616      * STATETIER
053600160616      *  START WITH STATE CODE
053700160616      *  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
053800160616      *  DEPENDENTS HAVE 'F' ONLY
053900160616      * MDI, MDF, ETC...
054000160616      *============================================================================
054100160616
054200120803     C     $METH04       BEGSR
054300160616
054400120803     C                   EVAL      @CCTRIN = STATE
054500160616
054600120803     C                   IF        WRT@TYPE = 'MEMBER'
054700120803     C                   IF        ENR@IN = 'TIN'
054800120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
054900120803     C                   ELSE
055000120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
055100120803     C                   ENDIF
055200120803     C                   ENDIF
055300160616
055400120803     C                   IF        WRT@TYPE = 'DEPEND'
055500120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
055600120803     C                   ENDIF
055700160616
055800120803     C                   ENDSR
055900160616
056000160616      *============================================================================
056100160616      * TIERSTS
056200160616      *  START WITH EMPLOYMENT STATUS, ACTIVE IS 'ACT' AND COBRA IS 'COB'
056300160616      *  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
056400160616      *  DEPENDENTS HAVE 'F' ONLY
056500160616      *
056600160616      * ACI, ACF, COI, COF
056700160616      *============================================================================
056800160616
056900120803     C     $METH05       BEGSR
057000160616
057100120803     C                   IF        EMPST =  'C'
057200120803     C                   EVAL      @CCTRIN = 'COB'
057300120803     C                   ELSE
057400120803     C                   EVAL      @CCTRIN = 'ACT'
057500120803     C                   ENDIF
057600160616
057700120803     C                   IF        ENR@IN = 'TIN'
057800120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
057900120803     C                   ELSE
058000120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
058100120803     C                   ENDIF
058200160616
058300120803     C                   ENDSR
058400160616
058500160616      *============================================================================
058600160616      * MAYOR
058700160616      *  WELL, FOR THE PLAN 'DAAU' IF THE STATE IS 'WV' THEN PLACE TIER STATUS SUFFIX
058800160616      *       BY TYPE OF PEEP; FOR OTHER STATES, USE A SIMPLE TIER CHECK.
058900160616      *
059000160616      *  WVI, WVF, IND, FAM
059100160616      *
059200160616      *  NOW, FOR THE PLAN 'DAAT' IF THE STATE IS 'WV' THEN PLACE EMPLOYMENT STATUS SUFFIX
059300160616      *       BY TYPE OF PEEP; FOR OTHER STATES, EMPLOYMENT STATUS AND TIER.
059400160616      *
059500160616      *  WVI, WVF, CBI, CBF, ACI, ACF
059600160616      *============================================================================
059700160616
059800120803     C     $METH06       BEGSR
059900160616
060000160616     C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'MEMBER'
060100160616
060200160616     C                   IF        STATE = 'WV'
060300160616
060400160616     C                   IF        ENR@IN = 'TIN'
060500120803     C                   EVAL      @CCTRIN = 'WVI'
060600160616     C                   ELSE
060700120803     C                   EVAL      @CCTRIN = 'WVF'
060800160616     C                   ENDIF
060900160616
061000160616     C                   ELSE
061100160616
061200160616     C                   IF        ENR@IN = 'TIN'
061300120803     C                   EVAL      @CCTRIN = 'IND'
061400160616     C                   ELSE
061500120803     C                   EVAL      @CCTRIN = 'FAM'
061600160616     C                   ENDIF
061700160616
061800160616     C                   ENDIF
061900160616
062000120803     C                   LEAVESR
062100160616     C                   ENDIF
062200160616
062300120803     C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'DEPEND'
062400160616
062500120803     C                   IF        STATE = 'WV'
062600120803     C                   EVAL      @CCTRIN = 'WVF'
062700120803     C                   ELSE
062800120803     C                   EVAL      @CCTRIN = 'FAM'
062900120803     C                   ENDIF
063000160616
063100120803     C                   LEAVESR
063200120803     C                   ENDIF
063300160616
063400160616     C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'MEMBER'
063500160616
063600160616     C                   IF        STATE = 'WV'
063700160616
063800160616     C                   IF        ENR@IN = 'TIN'
063900120803     C                   EVAL      @CCTRIN = 'WVI'
064000160616     C                   ELSE
064100120803     C                   EVAL      @CCTRIN = 'WVF'
064200160616     C                   ENDIF
064300160616
064400160616     C                   ELSE
064500160616
064600160616     C                   IF        EMPST =  'C'
064700120803     C                   EVAL      @CCTRIN = 'CB '
064800160616     C                   ELSE
064900120803     C                   EVAL      @CCTRIN = 'AC '
065000160616     C                   ENDIF
065100160616     C                   IF        ENR@IN = 'TIN'
065200120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
065300160616     C                   ELSE
065400120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
065500160616     C                   ENDIF
065600160616
065700160616     C                   ENDIF
065800160616
065900120803     C                   LEAVESR
066000160616     C                   ENDIF
066100160616
066200120803     C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'DEPEND'
066300160616
066400120803     C                   IF        STATE = 'WV'
066500120803     C                   EVAL      @CCTRIN = 'WVF'
066600120803     C                   ELSE
066700120803     C                   IF        EMPST =  'C'
066800120803     C                   EVAL      @CCTRIN = 'CBF'
066900120803     C                   ELSE
067000120803     C                   EVAL      @CCTRIN = 'ACF'
067100120803     C                   ENDIF
067200120803     C                   ENDIF
067300160616
067400120803     C                   ENDIF
067500160616
067600120803     C                   ENDSR
067700160616
067800160616      *============================================================================
067900160616      * EMPSTS
068000160616      *   PRETTY STRAIGHT FORWARDED
068100160616      *============================================================================
068200160616
068300120803     C     $METH07       BEGSR
068400160616
068500120803     C                   IF        EMPST =  'C'
068600120803     C                   EVAL      @CCTRIN = 'COB'
068700120803     C                   ELSE
068800120803     C                   EVAL      @CCTRIN = 'ACT'
068900120803     C                   ENDIF
069000160616
069100120803     C                   ENDSR
069200160616
069300160616      *============================================================================
069400160616      * JUSTSTATE
069500160616      *   PRETTY STRAIGHT FORWARDED
069600160616      *============================================================================
069700160616
069800120803     C     $METH08       BEGSR
069900160616
070000120803     C                   EVAL      @CCTRIN = STATE
070100160616
070200120803     C                   ENDSR
070300160616      *============================================================================
070400160616      * JOHNLS
070500160616      *   IF STATE IS NOT MARYLAND, DEFAULT TO 'XX', ELSE USE 'MD'; THEN APPLY TIER.
070600160616      * MDI, MDF, XXI, XXF
070700160616      *============================================================================
070800160616
070900120803     C     $METH09       BEGSR
071000160616
071100120803     C                   IF        WRT@TYPE = 'MEMBER'
071200120803     C                   IF        STATE = 'MD'
071300120803     C                   EVAL      @CCTRIN = 'MD'
071400120803     C                   ELSE
071500120803     C                   EVAL      @CCTRIN = 'XX'
071600120803     C                   ENDIF
071700120803     C                   IF        ENR@IN = 'TIN'
071800120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
071900120803     C                   ELSE
072000120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
072100120803     C                   ENDIF
072200120803     C                   ENDIF
072300160616
072400120803     C                   IF        WRT@TYPE = 'DEPEND'
072500120803     C                   IF        STATE = 'MD'
072600120803     C                   EVAL      @CCTRIN = 'MDF'
072700120803     C                   ELSE
072800120803     C                   EVAL      @CCTRIN = 'XXF'
072900120803     C                   ENDIF
073000120803     C                   ENDIF
073100160616
073200120803     C                   ENDSR
073300160616
073400160616      *============================================================================
073500160616      * CREATIVE
073600160616      *   IF STATE IS NOT 'MD' OR 'OK', DEFAULT TO '**'.
073700160616      * MD, OK, **
073800160616      *============================================================================
073900160616
074000120803     C     $METH10       BEGSR
074100160616
074200120803     C                   IF        STATE <> 'MD' AND STATE <> 'OK'
074300120803     C                   EVAL      @CCTRIN = '** '
074400120803     C                   ELSE
074500120803     C                   EVAL      @CCTRIN = STATE
074600120803     C                   ENDIF
074700160616
074800120803     C                   ENDSR
074900160616
075000160616      *============================================================================
075100160616      * INTEGRA = USE 'TN' FOR TENNESSEE, OTHER STATES ARE 'XX'
075200160616      *  TN, XX
075300160616      *============================================================================
075400160616
075500120803     C     $METH11       BEGSR
075600160616
075700121113     C                   SELECT
075800121113     C                   WHEN      STATE = 'TN'
075900121113     C                   EVAL      @CCTRIN = STATE                              TENNESSEE ONLY
076000121113     C                   WHEN      STATE = 'FL'
076100121113     C                   EVAL      @CCTRIN = STATE                              FLORIDA ONLY
076200121113     C                   OTHER
076300121113     C                   EVAL      @CCTRIN = 'XX '                              SITUS
076400160616     C                   ENDSL
076500160616
076600120803     C                   ENDSR
076700160616
076800160616      *============================================================================
076900160616      * STSTATE = STATE CODE WITH EMPLOYEE STATUS
077000160616      *  MDA, MDC, ETC...
077100160616      *============================================================================
077200160616
077300120803     C     $METH12       BEGSR
077400160616
077500120803     C                   EVAL      @CCTRIN = STATE + EMPST
077600160616
077700120803     C                   ENDSR
077800160616
077900160616      *============================================================================
078000160616      * STIERSTS = STATE CODE WITH TIER WITH EMPLOYEE STATUS
078100160616      *    ACTIVE [#CALC = 0]      COBRA [#CALC = 5]
078200160616      *    IND [+1 TO #CALC ]      NON-IND COVERAGE [+2 TO CALC]
078300160616      *    EACH STATE PUT AT END, GIVING FAM MARYLAND ACTIVE A VALUE OF 2MD
078400160616      *                                  IND WEST VIRGINIA COBRA A VALUE OF 6WV
078500160616      *============================================================================
078600160616
078700130123     C     $METH13       BEGSR
078800160616
078900130123     C                   SELECT
079000130123     C                   WHEN      EMPST =  'C'
079100130123     C                   Z-ADD     5             #CALC
079200130123     C                   OTHER
079300130123     C                   MOVE      *ZEROS        #CALC             1 0
079400130123     C                   ENDSL
079500160616
079600130123     C                   SELECT
079700130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN = 'TIN'
079800130123     C                   ADD       1             #CALC
079900130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN <> 'TIN'
080000130123     C                   ADD       2             #CALC
080100130123     C                   WHEN      WRT@TYPE = 'DEPEND'
080200130123     C                   ADD       2             #CALC
080300130123     C                   ENDSL
080400160616
080500130123     C                   EVAL      @CCTRIN = %EDITC(#CALC:'X') + STATE
080600160616
080700130123     C                   ENDSR
080800160616
080900160616      *============================================================================
081000160616
081100120409     C     $PREP4        BEGSR
081200160616
081300130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
081400101206     C                   EVAL      @STEP = 'STEP2'
081500101206     C                   LEAVESR
081600101206     C                   ENDIF
081700160616
081800130520     C                   EVAL      @STEP = 'STEP4'
081900130315     C                   EVAL      TERM_LIF = NO
082000101210     C                   EVAL      TERM_DEN = NO
082100101210     C                   EVAL      TERM_MED = NO
082200160616
082300130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
082400130520     C                   IF        L@TRM(L#CNE) <> 99999999
082500130520     C                   EXSR      $CHKHEM
082600130520     C                   ENDIF
082700130520     C                   LEAVESR
082800130520     C                   ENDIF
082900160616
083000130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
083100130520     C                   IF        M@TRM(M#CNE) <> 99999999
083200130520     C                   EXSR      $CHKHEM
083300130520     C                   ENDIF
083400130520     C                   LEAVESR
083500130520     C                   ENDIF
083600160616
083700130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
083800130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
083900130520     C                              M@TRM(M#CNE) <> 99999999)
084000130520     C                   EXSR      $CHKHEM
084100130520     C                   ENDIF
084200130520     C                   LEAVESR
084300130520     C                   ENDIF
084400160616
084500130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
084600130520     C                   IF        D@TRM(D#CNE) <> 99999999
084700130520     C                   EXSR      $CHKHEM
084800130520     C                   ENDIF
084900130520     C                   LEAVESR
085000130520     C                   ENDIF
085100160616
085200130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
085300130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
085400130520     C                              D@TRM(D#CNE) <> 99999999)
085500130520     C                   EXSR      $CHKHEM
085600130520     C                   ENDIF
085700130520     C                   LEAVESR
085800130520     C                   ENDIF
085900160616
086000130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
086100130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
086200130520     C                              M@TRM(M#CNE) <> 99999999)
086300130520     C                   EXSR      $CHKHEM
086400130520     C                   ENDIF
086500130520     C                   LEAVESR
086600130520     C                   ENDIF
086700160616
086800130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
086900130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
087000130520     C                              L@TRM(L#CNE) <> 99999999 OR
087100130520     C                              M@TRM(M#CNE) <> 99999999)
087200130520     C                   EXSR      $CHKHEM
087300130520     C                   ENDIF
087400130520     C                   LEAVESR
087500130520     C                   ENDIF
087600160616
087700101214     C                   ENDSR
087800160616
087900160616      *============================================================================
088000160616      * GENERATE MEMBER RECORD
088100160616      *============================================================================
088200160616
088300101210     C     $STEP4        BEGSR
088400160616
088500130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
088600101214     C                   EVAL      @STEP = 'STEP2'
088700101214     C                   LEAVESR
088800101214     C                   ENDIF
088900160616
089000110513     C                   EVAL      WRT@TYPE = 'MEMBER'
089100160616
089200130315     C                   EVAL      L@MBREFF = 0
089300110725     C                   EVAL      D@MBREFF = 0
089400110725     C                   EVAL      M@MBREFF = 0
089500160616
089600101210     C                   EVAL      @SS1   = %EDITC(MBSSNO:'X')
089700101210     C                   EVAL      @SS2   = @SS1
089800101210     C                   MOVEL(P)  MLNAME        @LN
089900101210     C                   MOVEL(P)  MFNAME        @FN
090000101210     C                   EVAL      @MI    = MMI
090100101210     C                   EVAL      @REL   = '01'
090200101210     C                   EVAL      @SEX   = SEX
090300101210     C                   EVAL      @DOB   = %EDITC(BIRTH:'X')
090400101210     C                   IF        COB = 'Y'
090500101210     C                   EVAL      @COB   = 'Y'
090600101210     C                   EVAL      @COBC  = 'OT'
090700101210     C                   EVAL      @COBN  = MCOBPN
090800101210     C                   ENDIF
090900101210     C                   EVAL      @AD1   = %TRIM(ADDR1)
091000101210     C                   EVAL      @AD2   = %TRIM(ADDR2)
091100101210     C                   EVAL      @CTY   = %TRIM(CITY)
091200101210     C                   EVAL      @ST    = STATE
091300101210     C                   MOVE      *BLANKS       @9                9
091400101210     C                   EVAL      @9   = %EDITC(ZIP:'X')
091500101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
091600101210     C                   EVAL      @PHN   = %EDITC(AREA:'X') +
091700101210     C                                      %EDITC(PHONE:'X')
091800160616
091900101210     C                   SELECT
092000101210     C                   WHEN      EMPST = 'A'
092100101210     C                   EVAL      @EMPST = 'AC'
092200101210     C                   WHEN      EMPST = 'C'
092300101210     C                   EVAL      @EMPST = 'CO'
092400101210     C                   WHEN      EMPST = 'R'
092500101210     C                   EVAL      @EMPST = 'RT'
092600101210     C                   ENDSL
092700160616
092800101210     C                   EVAL      @HIRE  = %EDITC(EMPDT:'X')
092900160616
093000141211     C                   SETOFF                                       888987
093100141120        IF KF@TRS = 770 AND KF@SUB = 004 AND KF@ACC = 0037 AND
093200141120          STATE = 'VT';
093300141120           *IN89 = *ON;
093400141120        ENDIF;
093500160616      * IF KF@TRS = 591 AND KF@SUB = 001 AND KF@ACC = 0042 AND
093600160616      *   STATE = 'TX';
093700160616      *    *IN87 = *ON;
093800160616      * ENDIF;
093900160616      *
094000101210     C                   EXCEPT    MBRF
094100101214     C                   ADD       1             C#RECCNT
094200160616
094300101213     C                   EVAL      @STEP = 'PREP5'
094400160616
094500101210     C                   ENDSR
094600160616
094700160616      *============================================================================
094800160616      * MEDICAL
094900160616      *============================================================================
095000160616
095100101214     C     $PREP5        BEGSR
095200160616
095300101214     C                   IF        M#CNE = 0
095400110513     C                   EVAL      @STEP = 'PREP6'
095500101214     C                   LEAVESR
095600101214     C                   ENDIF
095700160616
095800101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
095900130315     C                   EVAL      KF@ENR = M@ENR(M#CNE)
096000160616
096100101214     C                   IF        TERM_MED = YES
096200101214     C                   EXSR      $WRTERM
096300101214     C                   ENDIF
096400160616
096500110512     C                   EVAL      @PLANIN = KF@PLN
096600160616
096700160615     C     KL#TSAP       CHAIN     AEF04
096800160615     C                   IF        NOT %FOUND(AET004WF)
096900120803     C                   LEAVESR
097000120803     C                   ENDIF
097100160616
097200111020     C                   EVAL      ENR@IN = M@ENR(M#CNE)
097300160616
097400110802     C                   EXSR      $QUIK
097500160616
097600110512     C                   EXSR      $PLANSRCH
097700160616
097800110512     C                   IF        PLN@CAT = *BLANKS
097900101214     C                   SETON                                        H1
098000101214     C                   ENDIF
098100160616
098200110513     C                   EVAL      @STEP = 'STEP5'
098300110725     C                   EVAL      #XSX = M@FRM(M#CNE)
098400110725     C                   EVAL      M@MBREFF = #XSX
098500160616
098600101214     C                   ENDSR
098700160616
098800160616      *============================================================================
098900160616
099000101214     C     $STEP5        BEGSR
099100160616
099200110513     C                   IF        CPCID1 = 'MEA'
099300110513     C                   EXSR      $MEAWRT
099400110513     C                   ELSE
099500110513     C                   EXSR      $HMOWRT
099600110513     C                   ENDIF
099700160616
099800101214     C                   ADD       1             C#RECCNT
099900101214     C                   ADD       1             B#RECCNT
100000160616
100100110513     C                   EVAL      @STEP = 'PREP6'
100200160616
100300110513     C                   ENDSR
100400160616
100500160616      *============================================================================
100600160616      * DENTAL
100700160616      *============================================================================
100800160616
100900101214     C     $PREP6        BEGSR
101000160616
101100160616     C                   IF        D#CNE = 0
101200160616     C                   EVAL      @STEP = 'PREPC'
101300160616     C*****************  EVAL      @STEP = 'PREP7'
101400160616     C                   LEAVESR
101500160616     C                   ENDIF
101600160616
101700160616     C                   EVAL      KF@PLN = D@PLN(D#CNE)
101800160616     C                   EVAL      KF@ENR = D@ENR(D#CNE)
101900160616
102000160615     C     KL#TSAP       CHAIN     AEF04
102100160615     C                   IF        NOT %FOUND(AET004WF)
102200120803     C                   LEAVESR
102300120803     C                   ENDIF
102400160616
102500160616     C                   IF        TERM_DEN = YES
102600160616     C                   EXSR      $WRTERM
102700160616     C                   ENDIF
102800160616
102900110513     C                   EVAL      @PLANIN = KF@PLN
103000111020     C                   EVAL      ENR@IN = D@ENR(D#CNE)
103100160616
103200111011     C                   EXSR      $QUIK
103300160616
103400110513     C                   EXSR      $PLANSRCH
103500160616
103600110513     C                   IF        PLN@CAT = *BLANKS
103700110513     C                   SETON                                        H2
103800110513     C                   ENDIF
103900160616
104000160616     C                   EVAL      @STEP = 'STEP6'
104100110725     C                   EVAL      #XSX = D@FRM(D#CNE)
104200110725     C                   EVAL      D@MBREFF = #XSX
104300160616
104400101213     C                   ENDSR
104500160616
104600160616      *============================================================================
104700160616      * DENTAL FORMAT
104800160616      *============================================================================
104900160616
105000160616     C     $STEP6        BEGSR
105100110513     C                   EXSR      $DENWRT
105200160616
105300160616     C                   ADD       1             C#RECCNT
105400160616     C                   ADD       1             B#RECCNT
105500160616
105600160616     C****************** EVAL      @STEP = 'PREP7'
105700160616     C                   EVAL      @STEP = 'PREPC'
105800160616
105900160616     C                   ENDSR
106000160616
106100160616      *============================================================================
106200160616      * LIFE AND AD&D PLANS FOR MEMBER
106300160616      *============================================================================
106400160616
106500130315     C     $PREPC        BEGSR
106600160616
106700160616     C                   IF        L#CNE = 0
106800160616     C                   EVAL      @STEP = 'PREP7'
106900160616     C                   LEAVESR
107000160616     C                   ENDIF
107100160616
107200160616     C                   EVAL      KF#TRM = L@TRM(L#CNE)
107300160616     C                   EVAL      KF@PLN = L@PLN(L#CNE)
107400130315     C                   EVAL      KF@ENR = L@ENR(L#CNE)
107500160616
107600160615     C     KL#TSAP       CHAIN     AEF04
107700160615     C                   IF        NOT %FOUND(AET004WF)
107800130315     C                   LEAVESR
107900130315     C                   ENDIF
108000160616
108100160616     C                   IF        TERM_LIF = YES
108200160616     C                   EXSR      $WRTERM
108300160616     C                   ENDIF
108400160616
108500130315     C                   EVAL      @PLANIN = KF@PLN
108600130315     C                   EVAL      ENR@IN = L@ENR(L#CNE)
108700160616
108800130315     C                   EXSR      $QUIK
108900160616
109000130315     C                   EXSR      $PLANSRCH
109100160616
109200130315     C                   IF        PLN@CAT = *BLANKS
109300130315     C                   SETON                                        H2
109400130315     C                   ENDIF
109500160616
109600160616     C                   EVAL      @STEP = 'STEPC'
109700130315     C                   EVAL      #XSX = L@FRM(L#CNE)
109800130315     C                   EVAL      L@MBREFF = #XSX
109900160616
110000130315     C                   ENDSR
110100160616
110200160616      *============================================================================
110300160616      * LIFE FORMAT
110400160616      *============================================================================
110500160616
110600160616     C     $STEPC        BEGSR
110700160616
110800130315     C                   EXSR      $LIFWRT
110900160616
111000160616     C                   ADD       1             C#RECCNT
111100160616     C                   ADD       1             B#RECCNT
111200160616
111300160616     C                   EVAL      @STEP = 'PREP7'
111400160616
111500160616     C                   ENDSR
111600160616
111700160616      *============================================================================
111800160616
111900130315     C     $LIFWRT       BEGSR
112000160616
112100160616     C                   EVAL      X@LAY = CPCID1                               LAYOUT
112200160616     C                   EVAL      X@ELR = CPCID2                               ELR
112300160616     C                   EVAL      L@SFX = CPCID3                               SUFFIX
112400160616     C                   EVAL      L@ACCT = CPCID4                              ACCOUNT
112500160616     C                   EVAL      L@PLAN = CPCID5                              PLAN
112600160616     C                   EVAL      L@CLM = CPCID6                               CLAIM OFFICE
112700160616
112800160616     C                   EVAL      #XSX = L@FRM(L#CNE)
112900130315     C                   MOVE      #XSX          X@EFF
113000160616
113100160616     C                   EVAL      #XSX = L@TRM(L#CNE)
113200160616     C                   IF        #XSX = 0 OR #XSX = 99999999
113300160616     C                   MOVE      *BLANKS       X@TRM
113400160616     C                   ELSE
113500160616     C                   MOVE      #XSX          X@TRM
113600160616     C                   ENDIF
113700160616
113800140313     C                   MOVE      *BLANKS       L@CBREXP
113900140313     C                   MOVE      *BLANKS       L@CBREVT
114000140313     C                   MOVE      *BLANKS       L@CBRLEN
114100160616
114200160616     C                   IF        EMPST = 'C' AND
114300130923     C                             CEXPDT > 0
114400160616     C                   MOVE      CEXPDT        L@CBREXP
114500160616     C                   MOVE      QEDT          L@CBREVT
114600160616     C                   MOVE      CEXPDT        #MINUEND
114700160616     C                   MOVE      QEDT          #SUBTRAEND
114800160616     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
114900160616     C                   Z-ADD     #DIFFRNC      #2S0
115000160616     C                   MOVE      #2S0          L@CBRLEN
115100160616     C                   ENDIF
115200160616
115300130315     C                   EVAL      L@SALARY = %EDITC(SALARY:'4')
115400160616
115500160616     C                   EXCEPT    LIFF
115600160616
115700160616     C                   ENDSR
115800160616
115900160616      *============================================================================
116000160616
116100101214     C     $PREP7        BEGSR
116200160616
116300101214     C     KF@SSN        CHAIN     DEPENR
116400101214     C                   IF        NOT %FOUND(DEPNDC)
116500101214     C                   EVAL      @STEP = 'STEP2'
116600101214     C                   LEAVESR
116700101214     C                   ENDIF
116800160616
116900101214     C     KF@SSN        SETLL     DEPENR
117000160616
117100101214     C                   EVAL      @STEP = 'STEP7'
117200160616
117300101214     C                   ENDSR
117400160616
117500160616      *============================================================================
117600160616
117700101214     C     $STEP7        BEGSR
117800160616
117900101214     C     KF@SSN        READE     DEPENR
118000160616
118100101214     C                   IF        %EOF(DEPNDC)
118200101214     C                   EVAL      @STEP = 'STEP2'
118300101214     C                   LEAVESR
118400101214     C                   ENDIF
118500160616
118600101214     C                   EVAL      KF@SEQ = DPSEQ#
118700120803     C                   EVAL      WRT@TYPE = 'DEPEND'
118800160616
118900101214     C     KL#DCV        CHAIN     DCOVR
119000101214     C                   IF        NOT %FOUND(DCOVA)
119100101214     C                   LEAVESR
119200101214     C                   ENDIF
119300160616
119400101214     C                   EXSR      $CLRDCV
119500101214     C     KL#DCV        SETLL     DCOVR
119600160616
119700101214     C                   EVAL      @STEP = 'STEP8'
119800160616
119900101214     C                   ENDSR
120000160616
120100160616      *============================================================================
120200160616
120300101214     C     $STEP8        BEGSR
120400160616
120500101214     C     KL#DCV        READE     DCOVR
120600160616
120700101214     C                   IF        %EOF(DCOVA)
120800101214     C                   EVAL      @STEP = 'PREP9'
120900101214     C                   LEAVESR
121000101214     C                   ENDIF
121100160616
121200160616     C*                  IF        DENRDT = CCANDT
121300160616     C*                  LEAVESR
121400160616     C*                  ENDIF
121500160616
121600110513     C                   EVAL      @PLANIN = DVPLAN
121700120803     C                   EVAL      KF@PLN = DVPLAN
121800160615     C     KL#TSAP       CHAIN     AEF04
121900160615     C                   IF        NOT %FOUND(AET004WF)
122000120803     C                   LEAVESR
122100120803     C                   ENDIF
122200160616
122300110802     C                   EXSR      $QUIKD
122400160616
122500110513     C                   EXSR      $PLANSRCH
122600160616
122700110513     C                   IF        PLN@CAT = *BLANKS
122800110513     C                   LEAVESR
122900110513     C                   ENDIF
123000160616
123100101214     C                   EVAL      #CANCEL = CCANDT
123200101214     C                   IF        #CANCEL = 0
123300101214     C                   EVAL      #CANCEL = 99999999
123400101214     C                   ENDIF
123500160616
123600160616      * DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL; LIFE IS MEMBER ONLY
123700160616
123800160616     C                   IF        PLN@CAT = 'DEN'
123900160616     C                   IF        D#CNE > 0
124000160616     C                   IF        D@TRM(D#CNE) = 99999999
124100130131     C                   LEAVESR
124200130131     C                   ENDIF
124300130131     C                   ENDIF
124400160616     C                   ADD       1             D#CNE
124500160616     C                   EVAL      D@PLN(D#CNE) = DVPLAN
124600160616     C                   EVAL      D@ENR(D#CNE) = *BLANKS
124700160616     C                   EVAL      D@FRM(D#CNE) = DENRDT
124800160616     C                   EVAL      D@TRM(D#CNE) = #CANCEL
124900160616     C                   ELSE
125000160616     C                   IF        M#CNE > 0
125100160616     C                   IF        M@TRM(M#CNE) = 99999999
125200130131     C                   LEAVESR
125300130131     C                   ENDIF
125400130131     C                   ENDIF
125500101214     C                   ADD       1             M#CNE
125600101214     C                   EVAL      M@PLN(M#CNE) = DVPLAN
125700101214     C                   EVAL      M@ENR(M#CNE) = *BLANKS
125800101214     C                   EVAL      M@FRM(M#CNE) = DENRDT
125900101214     C                   EVAL      M@TRM(M#CNE) = #CANCEL
126000160616     C                   ENDIF
126100160616
126200101214     C                   ENDSR
126300160616
126400160616      *============================================================================
126500160616
126600111011     C     $QUIKD        BEGSR
126700160616
126800120803     C                   EXSR      $QUIK
126900160616
127000120409     C                   ENDSR
127100160616
127200160616      *============================================================================
127300160616
127400101214     C     $PREP9        BEGSR
127500160616
127600101214     C                   IF        D#CNE = 0 AND M#CNE = 0
127700101214     C                   EVAL      @STEP = 'STEP7'
127800101214     C                   LEAVESR
127900101214     C                   ENDIF
128000160616
128100130315     C                   EVAL      L#CNE = 0
128200130315     C                   EVAL      TERM_LIF = NO
128300101214     C                   EVAL      TERM_DEN = NO
128400101214     C                   EVAL      TERM_MED = NO
128500130520     C                   EVAL      @STEP = 'STEP9'
128600160616
128700130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
128800130520     C                   IF        L@TRM(L#CNE) <> 99999999
128900130520     C                   EXSR      $CHKHEM
129000130520     C                   ENDIF
129100130520     C                   LEAVESR
129200130520     C                   ENDIF
129300160616
129400130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
129500130520     C                   IF        M@TRM(M#CNE) <> 99999999
129600130520     C                   EXSR      $CHKHEM
129700130520     C                   ENDIF
129800130520     C                   LEAVESR
129900130520     C                   ENDIF
130000160616
130100130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
130200130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
130300130520     C                              M@TRM(M#CNE) <> 99999999)
130400130520     C                   EXSR      $CHKHEM
130500130520     C                   ENDIF
130600130520     C                   LEAVESR
130700130520     C                   ENDIF
130800160616
130900130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
131000130520     C                   IF        D@TRM(D#CNE) <> 99999999
131100130520     C                   EXSR      $CHKHEM
131200130520     C                   ENDIF
131300130520     C                   LEAVESR
131400130520     C                   ENDIF
131500160616
131600130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
131700130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
131800130520     C                              D@TRM(D#CNE) <> 99999999)
131900130520     C                   EXSR      $CHKHEM
132000130520     C                   ENDIF
132100130520     C                   LEAVESR
132200130520     C                   ENDIF
132300160616
132400130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
132500130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
132600130520     C                              M@TRM(M#CNE) <> 99999999)
132700130520     C                   EXSR      $CHKHEM
132800130520     C                   ENDIF
132900130520     C                   LEAVESR
133000130520     C                   ENDIF
133100160616
133200130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
133300130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
133400130520     C                              L@TRM(L#CNE) <> 99999999 OR
133500130520     C                              M@TRM(M#CNE) <> 99999999)
133600130520     C                   EXSR      $CHKHEM
133700130520     C                   ENDIF
133800130520     C                   LEAVESR
133900130520     C                   ENDIF
134000160616
134100101214     C                   ENDSR
134200160616
134300160616      *============================================================================
134400160616      * GENERATE DEPENDENT RECORD
134500160616      *============================================================================
134600160616
134700101214     C     $STEP9        BEGSR
134800160616
134900110513     C                   EVAL      WRT@TYPE = 'DEPEND'
135000160616
135100110513     C                   IF        D#CNE = 0 AND M#CNE = 0
135200110513     C                   EVAL      @STEP = 'STEP7'
135300110513     C                   LEAVESR
135400110513     C                   ENDIF
135500160616
135600101214     C                   EVAL      @SS2   = %EDITC(DEPSS#:'X')
135700101210     C                   MOVEL(P)  DLNAME        @LN
135800101210     C                   MOVEL(P)  DFNAME        @FN
135900101210     C                   EVAL      @MI    = DMI
136000160616
136100101210     C                   SELECT
136200101210     C                   WHEN      DRELCD = 'RWI'
136300101210     C                   EVAL      @REL   = '02'
136400101210     C                   WHEN      DRELCD = 'RHU'
136500101210     C                   EVAL      @REL   = '03'
136600101210     C                   WHEN      DRELCD = 'RSO'
136700101210     C                   EVAL      @REL   = '04'
136800101210     C                   WHEN      DRELCD = 'RDA'
136900101210     C                   EVAL      @REL   = '05'
137000130218     C                   WHEN      DRELCD = 'RPA'
137100130218     C                   EVAL      @REL   = '14'
137200130225     C                   OTHER
137300130225     C                   EVAL      @REL   = *BLANKS
137400101210     C                   ENDSL
137500160616
137600101210     C                   SELECT
137700101210     C                   WHEN      DSTUDN = 'Y'
137800101210     C                   EVAL      @SPEC = '1'
137900140812     C                   WHEN      DHNDCP = '3'
138000101210     C                   EVAL      @SPEC = '3'
138100130225     C                   OTHER
138200130225     C                   EVAL      @SPEC = *BLANKS
138300101210     C                   ENDSL
138400160616
138500101210     C                   EVAL      @SEX   = DSEX
138600101210     C                   EVAL      @DOB   = %EDITC(DBIRTH:'X')
138700160616
138800101210     C                   IF        DCOB = 'Y'
138900101210     C                   EVAL      @COB   = 'Y'
139000101210     C                   EVAL      @COBC  = 'OT'
139100101210     C                   EVAL      @COBN  = DCOBPN
139200130225     C                   ELSE
139300130225     C                   EVAL      @COB   = *BLANKS
139400130225     C                   EVAL      @COBC  = *BLANKS
139500130225     C                   EVAL      @COBN = *BLANKS
139600101210     C                   ENDIF
139700160616
139800101214     C                   IF        DADDR1 <> ADDR1
139900101210     C                   EVAL      @AD1   = %TRIM(DADDR1)
140000101210     C                   EVAL      @AD2   = %TRIM(DADDR2)
140100101210     C                   EVAL      @CTY   = %TRIM(DCITY)
140200101210     C                   EVAL      @ST    = DSTATE
140300101210     C                   MOVE      *BLANKS       @9                9
140400101214     C                   IF        DZIP = 0
140500101214     C                   EVAL      @9   = %EDITC(ZIP:'X')
140600101214     C                   ELSE
140700101210     C                   EVAL      @9   = %EDITC(DZIP:'X')
140800101214     C                   ENDIF
140900101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
141000101210     C                   EVAL      @PHN   = %EDITC(DAREA:'X') +
141100101210     C                                      %EDITC(DPHONE:'X')
141200101214     C                   ENDIF
141300160616
141400101210     C                   EXCEPT    MBRF
141500101214     C                   ADD       1             C#RECCNT
141600160616
141700101214     C                   EVAL      @STEP = 'PREPA'
141800160616
141900101210     C                   ENDSR
142000160616
142100160616      *============================================================================
142200160616
142300101214     C     $PREPA        BEGSR
142400160616
142500101214     C                   IF        M#CNE = 0
142600101214     C                   EVAL      @STEP = 'PREPB'
142700101214     C                   LEAVESR
142800101214     C                   ENDIF
142900160616
143000101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
143100160615     C     KL#TSAP       CHAIN     AEF04
143200160615     C                   IF        NOT %FOUND(AET004WF)
143300120803     C                   LEAVESR
143400120803     C                   ENDIF
143500160616
143600101214     C                   IF        TERM_MED = YES
143700101214     C                   EXSR      $WRTERM
143800101214     C                   ENDIF
143900160616
144000110513     C                   EVAL      @PLANIN = KF@PLN
144100160616
144200110802     C                   EXSR      $QUIKD
144300160616
144400110513     C                   EXSR      $PLANSRCH
144500160616
144600110513     C                   IF        PLN@CAT = *BLANKS
144700110513     C                   SETON                                        H2
144800110513     C                   ENDIF
144900160616
145000110513     C                   EVAL      @STEP = 'STEPA'
145100160616
145200101214     C                   ENDSR
145300160616
145400160616      *============================================================================
145500160616
145600101214     C     $STEPA        BEGSR
145700160616
145800110513     C                   IF        CPCID1 = 'MEA'
145900110513     C                   EXSR      $MEAWRT
146000110513     C                   ELSE
146100110513     C                   EXSR      $HMOWRT
146200110513     C                   ENDIF
146300160616
146400110513     C                   ADD       1             C#RECCNT
146500110513     C                   ADD       1             B#RECCNT
146600160616
146700110513     C                   EVAL      @STEP = 'PREPB'
146800160616
146900110513     C                   ENDSR
147000160616
147100160616      *============================================================================
147200160616
147300101214     C     $PREPB        BEGSR
147400160616
147500160616     C                   IF        D#CNE = 0
147600160616     C                   EVAL      @STEP = 'STEP7'
147700160616     C                   LEAVESR
147800160616     C                   ENDIF
147900160616
148000160616     C                   EVAL      KF@PLN = D@PLN(D#CNE)
148100160615     C     KL#TSAP       CHAIN     AEF04
148200160615     C                   IF        NOT %FOUND(AET004WF)
148300120803     C                   LEAVESR
148400120803     C                   ENDIF
148500160616
148600160616     C                   IF        TERM_DEN = YES
148700160616     C                   EXSR      $WRTERM
148800160616     C                   ENDIF
148900160616
149000110513     C                   EVAL      @PLANIN = KF@PLN
149100160616
149200110802     C                   EXSR      $QUIKD
149300160616
149400110513     C                   EXSR      $PLANSRCH
149500160616
149600110513     C                   IF        PLN@CAT = *BLANKS
149700110513     C                   SETON                                        H2
149800110513     C                   ENDIF
149900160616
150000101214     C                   EVAL      @STEP = 'STEPB'
150100160616
150200101214     C                   ENDSR
150300160616
150400160616      *============================================================================
150500160616
150600160616     C     $STEPB        BEGSR
150700160616
150800110513     C                   EXSR      $DENWRT
150900160616
151000160616     C                   ADD       1             C#RECCNT
151100160616     C                   ADD       1             B#RECCNT
151200160616
151300160616     C                   EVAL      @STEP = 'STEP7'
151400160616
151500160616     C                   ENDSR
151600160616
151700160616      *============================================================================
151800160616
151900110512     C     *INZSR        BEGSR
152000160616
152100160314     C     *entry        plist
152200160314     C                   parm                    CARR#CTL
152300160314     C                   parm                    grouper
152400160314
152500110512     C     KL#ACCTL      KLIST
152600120803     C                   KFLD                    KF@CCTL
152700110512     C                   KFLD                    KF@TRS
152800110512     C                   KFLD                    KF@SUB
152900110512     C                   KFLD                    KF@ACC
153000160616
153100140313     C     KL#SQPCD      KLIST
153200140313     C                   KFLD                    KF@SSN
153300140313     C                   KFLD                    KF@SEQ
153400140313     C                   KFLD                    KF@SPCD
153500160616
153600120803     C     KL#TSAP       KLIST
153700120803     C                   KFLD                    KF@TRS
153800120803     C                   KFLD                    KF@SUB
153900120803     C                   KFLD                    KF@ACC
154000120803     C                   KFLD                    KF@PLN
154100160616
154200110512     C     KL#TSA        KLIST
154300110512     C                   KFLD                    KF@TRS
154400110512     C                   KFLD                    KF@SUB
154500110512     C                   KFLD                    KF@ACC
154600160616
154700110512     C     KL#MPLN       KLIST
154800110512     C                   KFLD                    KF@SSN
154900110512     C                   KFLD                    KF@SEQ
155000110512     C                   KFLD                    KF@TRS
155100110512     C                   KFLD                    KF@SUB
155200110512     C                   KFLD                    KF@ACC
155300160616
155400110512     C     KL#CPLN       KLIST
155500120803     C                   KFLD                    KF@CCTL
155600110512     C                   KFLD                    KF@TRS
155700110512     C                   KFLD                    KF@SUB
155800110512     C                   KFLD                    KF@ACC
155900110512     C                   KFLD                    KF@CCTR
156000110512     C                   KFLD                    KF@PLN
156100160616
156200110512     C     KL#DCV        KLIST
156300110512     C                   KFLD                    KF@SSN
156400110512     C                   KFLD                    KF@SEQ
156500160616
156600110512     C     KL#MTR        KLIST
156700110512     C                   KFLD                    KF@SSN
156800110512     C                   KFLD                    KF@SEQ
156900110512     C                   KFLD                    KF#TRM
157000110512     C                   KFLD                    KF@PLN
157100110512     C                   KFLD                    KF@ENR
157200110512     C                   KFLD                    KF@TRS
157300110512     C                   KFLD                    KF@SUB
157400110512     C                   KFLD                    KF@ACC
157500160616
157600110512     C     KL#PCP        KLIST
157700110512     C                   KFLD                    KF@SSN
157800110512     C                   KFLD                    KF@SEQ
157900160616
158000110512     C                   EVAL      #ISO = %DATE
158100110512     C                   MOVE      #ISO          #TODAY            8 0
158200110512     C                   EVAL      #IST = %TIME
158300110512     C                   MOVE      #ISO          #XSX
158400110512     C                   MOVE      #XSX          @DATE
158500110512     C                   MOVE      #IST          #XST
158600110512     C                   MOVE      #XST          @TIME
158700160831
158800110512     C                   ENDSR
158900160616
159000160616      *============================================================================
159100160616      * PLANS LOADED BY ACCOUNT
159200160616      *============================================================================
159300160616
159400110513     C     $PLANLOAD     BEGSR
159500160616
159600110513     C                   EVAL      PP# = 0
159700140313     C                   DO        80
159800110513     C                   ADD       1             PP#
159900110513     C     PP#           OCCUR     CARPLN@
160000110513     C                   CLEAR                   CARPLN@
160100110513     C                   ENDDO
160200110513     C                   EVAL      PC# = 0
160300110513     C                   EVAL      PP# = 0
160400160616
160500110513     C     KL#ACCTL      SETLL     CARPLNR
160600110513     C                   DOU       %EOF(CARPLNP)
160700110513     C     KL#ACCTL      READE     CARPLNR
160800110520     C                   IF        NOT %EOF(CARPLNP)
160900160616
161000110513     C                   ADD       1             PC#
161100110513     C     PC#           OCCUR     CARPLN@
161200110513     C                   EVAL      CARPLN@ = DS@CARPLN
161300160616
161400110513     C                   ENDIF
161500110513     C                   ENDDO
161600160616
161700110513     C                   ENDSR
161800160616
161900160616      *============================================================================
162000160616
162100110513     C     $CLRSTG       BEGSR
162200160616
162300110513     C                   EVAL      #CANCEL = 0
162400160616
162500130315     C                   EVAL      L#CNE = 0
162600130315     C                   CLEAR                   L@PLN
162700130315     C                   CLEAR                   L@ENR
162800130315     C                   CLEAR                   L@FRM
162900130315     C                   CLEAR                   L@TRM
163000160616
163100110513     C                   EVAL      D#CNE = 0
163200110513     C                   CLEAR                   D@PLN
163300110513     C                   CLEAR                   D@ENR
163400110513     C                   CLEAR                   D@FRM
163500110513     C                   CLEAR                   D@TRM
163600110513     C                   EVAL      M#CNE = 0
163700110513     C                   CLEAR                   M@PLN
163800110513     C                   CLEAR                   M@ENR
163900110513     C                   CLEAR                   M@FRM
164000110513     C                   CLEAR                   M@TRM
164100160616
164200110513     C                   EXSR      $CLRDMG
164300160616
164400110513     C                   ENDSR
164500160616
164600160616      *============================================================================
164700160616
164800110513     C     $CLRDMG       BEGSR
164900160616
165000110513     C                   EVAL      @SS1   = *BLANKS
165100110513     C                   EVAL      @SS2   = *BLANKS
165200110513     C                   MOVE      *BLANKS       @LN
165300110513     C                   MOVEL     *BLANKS       @FN
165400110513     C                   EVAL      @MI    = *BLANKS
165500110513     C                   EVAL      @REL   = *BLANKS
165600110513     C                   EVAL      @SEX   = *BLANKS
165700110513     C                   EVAL      @DOB   = *BLANKS
165800110513     C                   EVAL      @SPEC  = *BLANKS
165900110513     C                   EVAL      @COB   = *BLANKS
166000110513     C                   EVAL      @COBC  = *BLANKS
166100110513     C                   EVAL      @COBN  = *BLANKS
166200110513     C                   EVAL      @AD1   = *BLANKS
166300110513     C                   EVAL      @AD2   = *BLANKS
166400110513     C                   EVAL      @CTY   = *BLANKS
166500110513     C                   EVAL      @ST    = *BLANKS
166600110513     C                   EVAL      @ZP5   = *BLANKS
166700110513     C                   EVAL      @PHN   = *BLANKS
166800110513     C                   EVAL      @EMPST = *BLANKS
166900110513     C                   EVAL      @HIRE  = *BLANKS
167000160616
167100110513     C                   ENDSR
167200160616
167300160616      *============================================================================
167400160616
167500110513     C     $CHKHEM       BEGSR
167600160616
167700160616     C                   IF        L#CNE > 0 AND L@TRM(L#CNE) <> 99999999
167800160616     C                   EXSR      $CHKLIF
167900160616     C                   ENDIF
168000160616
168100160616     C                   IF        D#CNE > 0 AND D@TRM(D#CNE) <> 99999999
168200160616     C                   EXSR      $CHKDEN
168300160616     C                   ENDIF
168400160616
168500110513     C                   IF        M#CNE > 0 AND M@TRM(M#CNE) <> 99999999
168600110513     C                   EXSR      $CHKMED
168700110513     C                   ENDIF
168800160616
168900110513     C                   ENDSR
169000160616
169100160616      *============================================================================
169200160616
169300160616     C     $CHKLIF       BEGSR
169400160616
169500160616     C                   EVAL      TERM_LIF = YES
169600160616     C                   EVAL      KF#TRM = L@TRM(L#CNE)
169700160616     C                   EVAL      KF@PLN = L@PLN(L#CNE)
169800160616     C                   EVAL      KF@ENR = L@ENR(L#CNE)
169900160616
170000160809     C     KL#MTR        CHAIN     AET1051F
170100160809     C                   IF        %FOUND(AET1051WF)
170200160616     C                   EVAL      L#CNE = 0
170300160616     C                   EVAL      TERM_LIF = NO
170400160616     C                   ENDIF
170500160616
170600160616     C                   ENDSR
170700160616
170800160616      *============================================================================
170900160616
171000160616     C     $CHKDEN       BEGSR
171100160616
171200160616     C                   EVAL      TERM_DEN = YES
171300160616     C                   EVAL      KF#TRM = D@TRM(D#CNE)
171400160616     C                   EVAL      KF@PLN = D@PLN(D#CNE)
171500160616     C                   EVAL      KF@ENR = D@ENR(D#CNE)
171600160616
171700160809     C     KL#MTR        CHAIN     AET1051F
171800160809     C                   IF        %FOUND(AET1051WF)
171900160616     C                   EVAL      D#CNE = 0
172000160616     C                   EVAL      TERM_DEN = NO
172100160616     C                   ENDIF
172200160616
172300160616     C                   ENDSR
172400160616
172500160616      *============================================================================
172600160616
172700110513     C     $CHKMED       BEGSR
172800160616
172900110513     C                   EVAL      TERM_MED = YES
173000110513     C                   EVAL      KF#TRM = M@TRM(M#CNE)
173100110513     C                   EVAL      KF@PLN = M@PLN(M#CNE)
173200110513     C                   EVAL      KF@ENR = M@ENR(M#CNE)
173300160616
173400160809     C     KL#MTR        CHAIN     AET1051F
173500160809     C                   IF        %FOUND(AET1051WF)
173600110513     C                   EVAL      TERM_MED = NO
173700110513     C                   EVAL      M#CNE = 0
173800110513     C                   ENDIF
173900160616
174000110513     C                   ENDSR
174100160616
174200160616      *============================================================================
174300160616
174400110513     C     $PLANSRCH     BEGSR
174500160616
174600130315     C                   MOVE      *BLANKS       PLN@CAT           5
174700110513     C                   EVAL      PP# = 0
174800110513     C                   CLEAR                   DS@CARPLN
174900160616
175000110513     C                   DO        PC#
175100160616
175200110513     C                   ADD       1             PP#
175300110513     C     PP#           OCCUR     CARPLN@
175400160616
175500110513     C                   IF        XPPLAN = @PLANIN AND
175600110513     C                             XPCCTR = @CCTRIN
175700110513     C                   EVAL      DS@CARPLN = CARPLN@
175800110513     C                   LEAVE
175900110513     C                   ENDIF
176000160616
176100110513     C                   ENDDO
176200160616
176300110513     C                   IF        CPPLAN = *BLANKS
176400110513     C                   LEAVESR
176500110513     C                   ENDIF
176600160616
176700110513     C                   SELECT
176800110520     C                   WHEN      CPCID1 = 'MEA' OR
176900110520     C                             CPCID1 = 'HMO'
177000110520     C                   EVAL      PLN@CAT = 'MED'
177100130409     C                   WHEN      CPCID1 = 'LIFE'
177200130409     C                   EVAL      PLN@CAT = 'LIFE'
177300110520     C                   WHEN      CPCID1 = 'DEN'
177400110520     C                   EVAL      PLN@CAT = 'DEN'
177500110513     C                   ENDSL
177600160616
177700110513     C                   ENDSR
177800160616
177900160616      *============================================================================
178000160616
178100110513     C     $ENROLL       BEGSR
178200160616
178300110513     C                   EVAL      ENR@OUT = *BLANKS
178400110513     C                   SELECT
178500110513     C                   WHEN      ENR@IN = 'TIN' OR ENR@IN = 'TMI'
178600110513     C                   EVAL      ENR@OUT = 'S'
178700110513     C                   WHEN      ENR@IN = 'THW'
178800110513     C                   EVAL      ENR@OUT = 'C'
178900110513     C                   WHEN      ENR@IN = 'TPC'
179000110513     C                   EVAL      ENR@OUT = 'P'
179100110513     C                   WHEN      ENR@IN = 'TP2'
179200110513     C                   EVAL      ENR@OUT = 'Q'
179300110513     C                   WHEN      ENR@IN = 'TFA'
179400110513     C                   EVAL      ENR@OUT = 'F'
179500110513     C                   ENDSL
179600160616
179700110513     C                   ENDSR
179800160616
179900160616      *============================================================================
180000160616
180100110513     C     $WRTERM       BEGSR
180200160616
180300160809     C                   CLEAR                   AET1051F
180400110513     C                   EVAL      NTSSNO         = KF@SSN
180500110513     C                   EVAL      NTDEPNO        = KF@SEQ
180600110513     C                   EVAL      NTTERMDT       = KF#TRM
180700110513     C                   EVAL      NTPLAN         = KF@PLN
180800110513     C                   EVAL      NTCOVTP        = KF@ENR
180900110513     C                   EVAL      NTTRST         = KF@TRS
181000110513     C                   EVAL      NTSUB#         = KF@SUB
181100110513     C                   EVAL      NTACCT         = KF@ACC
181200110513     C                   EVAL      NTTRANSDT      = #TODAY
181300160809     C                   WRITE     AET1051F
181400160616
181500110513     C                   ENDSR
181600160616
181700160616      *============================================================================
181800160616
181900110513     C     $HMOWRT       BEGSR
182000160616
182100110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
182200110513     C                   EVAL      X@ELR = CPCID2                               FILE NUMBER
182300110513     C                   EVAL      M@CC = CACID2                                COMPANY CODE
182400110513     C                   EVAL      M@CLASS = CPCID3                             CLASS CODE
182500110513     C                   EVAL      M@PLAN = CPCID4                              PLAN NUMBER
182600160616
182700110513     C                   EVAL      #XSX = M@FRM(M#CNE)
182800110725     C                   IF        WRT@TYPE = 'DEPEND' AND
182900110725     C                             #XSX < M@MBREFF
183000110725     C                   MOVE      M@MBREFF      X@EFF
183100110725     C                   ELSE
183200110725     C                   MOVE      #XSX          X@EFF
183300110725     C                   ENDIF
183400160616
183500110513     C                   EVAL      #XSX = M@TRM(M#CNE)
183600110513     C                   IF        #XSX = 0 OR #XSX = 99999999
183700110513     C                   MOVE      *BLANKS       X@TRM
183800110513     C                   ELSE
183900110513     C                   MOVE      #XSX          X@TRM
184000110513     C                   ENDIF
184100160616
184200110513     C                   IF        WRT@TYPE = 'MEMBER'
184300110513     C                   EVAL      KF@SEQ = 0
184400110513     C                   EVAL      ENR@IN = M@ENR(M#CNE)
184500110513     C                   EXSR      $ENROLL
184600110513     C                   EVAL      X@TIER = ENR@OUT
184700110513     C                   ELSE
184800110513     C                   EVAL      X@TIER = *BLANKS
184900110513     C                   ENDIF
185000160616
185100140313     C                   EVAL      KF@SPCD = 'MED'
185200140313     C                   EVAL      M@PCP = *BLANKS
185300140313     C                   EVAL      M@NPI = *BLANKS
185400140313     C                   EVAL      M@PCPCI = *BLANKS
185500160616
185600140313     C                   EXSR      $PCP
185700160616
185800140313     C                   IF        DOCTOR <> *BLANKS
185900140313     C                   EVAL      M@PCP = DOCTOR
186000140313     C                   EVAL      M@NPI = 'Y'
186100140313     C                   EVAL      M@PCPCI = '0'
186200140313     C                   ENDIF
186300160616
186400110513     C                   EXCEPT    HMOF
186500160616
186600110513     C                   ENDSR
186700160616
186800160616      *============================================================================
186900160616
187000110513     C     $MEAWRT       BEGSR
187100160616
187200110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
187300110513     C                   EVAL      X@ELR = CPCID2                               ELR
187400140313     C                   EVAL      E@SFX = CPCID3                               SUFFIX
187500140313     C                   EVAL      E@ACCT = CPCID4                              ACCOUNT
187600140313     C                   EVAL      E@PLAN = CPCID5                              PLAN
187700140313     C                   EVAL      E@CLM = CPCID6                               CLAIM OFFICE
187800160616
187900110513     C                   EVAL      #XSX = M@FRM(M#CNE)
188000110725     C                   IF        WRT@TYPE = 'DEPEND' AND
188100110725     C                             #XSX < M@MBREFF
188200110725     C                   MOVE      M@MBREFF      X@EFF
188300110725     C                   ELSE
188400110725     C                   MOVE      #XSX          X@EFF
188500110725     C                   ENDIF
188600160616
188700160616     C                   EVAL      #XSX = M@TRM(M#CNE)
188800110513     C                   IF        #XSX = 0 OR #XSX = 99999999
188900110513     C                   MOVE      *BLANKS       X@TRM
189000110513     C                   ELSE
189100110513     C                   MOVE      #XSX          X@TRM
189200110513     C                   ENDIF
189300160616
189400140313     C                   MOVE      *BLANKS       E@CBREXP
189500140313     C                   MOVE      *BLANKS       E@CBREVT
189600140313     C                   MOVE      *BLANKS       E@CBRLEN
189700140313     C                   IF        WRT@TYPE = 'MEMBER'
189800140425     C                   IF        EMPST = 'C' AND
189900140425     C                             CEXPDT > 0
190000140313     C                   MOVE      CEXPDT        E@CBREXP
190100140313     C                   MOVE      QEDT          E@CBREVT
190200140313     C                   MOVE      CEXPDT        #MINUEND
190300140313     C                   MOVE      QEDT          #SUBTRAEND
190400140313     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
190500140313     C                   Z-ADD     #DIFFRNC      #2S0
190600140313     C                   MOVE      #2S0          E@CBRLEN
190700140313     C                   ENDIF
190800140313     C                   ENDIF
190900160616
191000140313     C                   EVAL      *IN80 = *OFF
191100140313     C                   EVAL      KF@SPCD = 'MED'
191200140313     C                   EVAL      E@PCP = *BLANKS
191300140313     C                   EXSR      $PCP
191400140313     C                   IF        DOCTOR <> *BLANKS
191500140313     C                   EVAL      E@PCP = DOCTOR
191600140313     C                   EVAL      *IN80 = *ON
191700140313     C                   ENDIF
191800160616
191900140313     C                   EXCEPT    MEAF
192000160616
192100110513     C                   ENDSR
192200160616
192300160616      *============================================================================
192400160616
192500140313     C     $PCP          BEGSR
192600160616
192700140313     C                   MOVE      *BLANKS       DOCTOR            7
192800140313     C     KL#SQPCD      CHAIN     PCPR
192900140313     C                   IF        NOT %FOUND(PCPL1)
193000140313     C                   LEAVESR
193100140313     C                   ENDIF
193200140313     C     KL#SQPCD      SETLL     PCPR
193300140313     C                   DOU       %EOF(PCPL1)
193400140313     C     KL#SQPCD      READE     PCPR
193500140313     C                   IF        NOT %EOF(PCPL1) AND PCCAN = 0
193600140313     C                   MOVEL(P)  PCID#         DOCTOR
193700140313     C                   LEAVESR
193800140313     C                   ENDIF
193900140313     C                   ENDDO
194000160616
194100140313     C                   ENDSR
194200160616
194300160616      *============================================================================
194400160616
194500110513     C     $CLRDCV       BEGSR
194600160616
194700110513     C                   MOVE      *BLANKS       @LN
194800110513     C                   MOVEL     *BLANKS       @FN
194900110513     C                   EVAL      @SS2   = *BLANKS
195000110513     C                   EVAL      @MI    = *BLANKS
195100110513     C                   EVAL      @REL   = *BLANKS
195200110513     C                   EVAL      @SEX   = *BLANKS
195300110513     C                   EVAL      @DOB   = *BLANKS
195400110513     C                   EVAL      @SPEC  = *BLANKS
195500110513     C                   EVAL      @COB   = *BLANKS
195600110513     C                   EVAL      @COBC  = *BLANKS
195700110513     C                   EVAL      @COBN  = *BLANKS
195800160616
195900110513     C                   EVAL      #CANCEL = 0
196000110513     C                   EVAL      D#CNE = 0
196100110513     C                   CLEAR                   D@PLN
196200110513     C                   CLEAR                   D@ENR
196300110513     C                   CLEAR                   D@FRM
196400110513     C                   CLEAR                   D@TRM
196500110513     C                   EVAL      M#CNE = 0
196600110513     C                   CLEAR                   M@PLN
196700110513     C                   CLEAR                   M@ENR
196800110513     C                   CLEAR                   M@FRM
196900110513     C                   CLEAR                   M@TRM
197000160616
197100110513     C                   ENDSR
197200160616
197300160616      *============================================================================
197400160616
197500110513     C     $DENWRT       BEGSR
197600160616
197700160616     C                   EVAL      X@LAY = CPCID1                               LAYOUT
197800160616     C                   EVAL      X@ELR = CPCID2                               ELR
197900160616     C                   EVAL      D@SFX = CPCID3                               SUFFIX
198000160616     C                   EVAL      D@ACCT = CPCID4                              ACCOUNT
198100160616     C                   EVAL      D@PLAN = CPCID5                              PLAN
198200160616     C                   EVAL      D@CLM = CPCID6                               CLAIM OFFICE
198300110524     C                   EVAL      DNTLATE = '0'
198400160616
198500160616     C                   EVAL      #XSX = D@FRM(D#CNE)
198600110725     C                   IF        WRT@TYPE = 'DEPEND' AND
198700110725     C                             #XSX < D@MBREFF
198800110725     C                   MOVE      D@MBREFF      X@EFF
198900110725     C                   ELSE
199000110725     C                   MOVE      #XSX          X@EFF
199100110725     C                   ENDIF
199200160616
199300160616     C                   EVAL      #XSX = D@TRM(D#CNE)
199400160616     C                   IF        #XSX = 0 OR #XSX = 99999999
199500160616     C                   MOVE      *BLANKS       X@TRM
199600160616     C                   ELSE
199700160616     C                   MOVE      #XSX          X@TRM
199800160616     C                   ENDIF
199900160616
200000130211     C                   MOVE      *BLANKS       D@CBREXP
200100130211     C                   MOVE      *BLANKS       D@CBREVT
200200130211     C                   MOVE      *BLANKS       D@CBRLEN
200300110513     C                   IF        WRT@TYPE = 'MEMBER'
200400160616     C                   IF        EMPST = 'C' AND CEXPDT <> 0
200500160616     C                   MOVE      CEXPDT        D@CBREXP
200600160616     C                   MOVE      QEDT          D@CBREVT
200700160616     C                   MOVE      CEXPDT        #MINUEND
200800160616     C                   MOVE      QEDT          #SUBTRAEND
200900160616     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
201000160616     C                   Z-ADD     #DIFFRNC      #2S0
201100160616     C                   MOVE      #2S0          D@CBRLEN
201200160616     C                   ENDIF
201300160616     C                   ENDIF
201400160616
201500160616     C                   MOVE      '0'           D@OOAI
201600160616
201700140313     C                   EVAL      KF@SPCD = 'DEN'
201800140313     C                   EVAL      D@PCD = *BLANKS
201900140313     C                   EVAL      *IN81 = *OFF
202000140313     C                   MOVE      *BLANKS       DOCTOR
202100160616
202200140313     C                   EXSR      $PCP
202300160616
202400140313     C                   IF        DOCTOR <> *BLANKS
202500140313     C                   EVAL      D@PCD = DOCTOR
202600140313     C                   EVAL      *IN81 = *ON
202700140313     C                   ENDIF
202800160616
202900120123     C     *LIKE         DEFINE    H@C#          BUC#
203000120123     C                   EVAL      BUC# = H@C#
203100160616
203200120327     C                   SELECT
203300131126     C                   WHEN      KF@TRS = 591 AND KF@SUB = 009 AND            WILMOT MODULAR
203400131126     C                             KF@ACC = 0202                                 STRUCTURES
203500131227     C                   EVAL      H@C# = '0638156'
203600140702     C                   WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            REDLAND
203700140702     C                             KF@ACC = 0475                                 BAPTISTS
203800140702     C                   EVAL      H@C# = '0725572'
203900120327     C                   WHEN      KF@TRS = 825 AND KF@SUB = 001 AND            CREATIVE
204000120123     C                             KF@ACC = 0014                                 LOGISTICS
204100120123     C                   EVAL      H@C# = '0133860'
204200130905     C                   WHEN      KF@TRS = 905 AND KF@SUB = 001 AND            CCL USA
204300130905     C                             KF@ACC = 0092
204400130905     C                   EVAL      H@C# = '0638423'
204500140423     C                   WHEN      KF@TRS = 003 AND KF@SUB = 001 AND            FRAME RITE
204600140423     C                             KF@ACC = 0104
204700140423     C                   EVAL      H@C# = '0306511'
204800130520     C                   WHEN      KF@TRS = 900 AND KF@SUB = 003 AND            PERFECT
204900130520     C                             KF@ACC = 0045                                 SETTINGS
205000130520     C                   EVAL      H@C# = '0474109'
205100121024     C                   WHEN      KF@TRS = 591 AND KF@SUB = 011 AND            MCCALLISTER
205200121024     C                             KF@ACC = 0446                                 ARCHITECT
205300121024     C                   EVAL      H@C# = '0565330'
205400130716     C                   WHEN      KF@TRS = 591 AND KF@SUB = 005 AND            JD CLARK PROF
205500130716     C                             KF@ACC = 0451                                 SERVICES
205600130716     C                   EVAL      H@C# = '0519890'
205700130627     C                   WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            DYSON CONSTRUCTION
205800130627     C                             KF@ACC = 0459                                 COMPANY
205900130627     C                   EVAL      H@C# = '0788122'
206000130903     C                   WHEN      KF@TRS = 591 AND KF@SUB = 004 AND            STROUSE CORP
206100130903     C                             KF@ACC = 0482
206200130903     C                   EVAL      H@C# = '0837451'
206300130712     C                   WHEN      KF@TRS = 900 AND KF@SUB = 007 AND            CAPLAN BROTHERS
206400130712     C                             KF@ACC = 0075
206500130712     C                   EVAL      H@C# = '0837533'
206600120806     C                   WHEN      KF@TRS = 900 AND KF@SUB = 101 AND            INTEGRA HEALTH
206700130110     C                             KF@ACC = 0042 AND
206800130110     C                             (STATE = 'TN' OR STATE = 'FL' OR
206900130718     C                              STATE = 'OH' OR STATE = 'MA') AND
207000120806     C                             (@PLANIN = 'DAAD' OR @PLANIN = 'BAAD')
207100120806     C                   EVAL      H@C# = '0503428'
207200160616     C                   ENDSL
207300160616
207400160616     C                   EXCEPT    DENF
207500151217     c                   EVAL      H@C# = BUC#
207600160616
207700160616     C                   ENDSR
207800160616
207900160616      *============================================================================
208000160616
208100160809     OAET1050WF EADD         HDRF
208200101203     O                                            6 'HEADER'
208300160810     O                                            8 'P'
208400101206     O                       H@SI                28
208500101203     O                                           29 '0'
208600101203     O                       C1                  43
208700101203     O                       D1                  51
208800101203     O                       T1                  57
208900101206     O                                          131 'CONSOLIDATED ELIGIBILITY'
209000110502     O                       H@RI               167
209100101206     O                       H@CC               169
209200101228     O                       H@GN               176
209300101206     O                       H@CN               191
209400101206     O                       H@C#               198
209500101203     O                       D2                 206
209600110825     O                                          216 'MC'
209700101223     O                                          231 '*'
209800160616
209900160616      *============================================================================
210000160809     OAET1050WF EADD         MBRF
210100101203     O                                            6 'MEMBER'
210200101203     O                       @SS1                16
210300101203     O                       @SS2                25
210400101203     O                       @FN                 75
210500101203     O                       @MI                 76
210600101203     O                       @LN                 96
210700101203     O                       @REL               101
210800101203     O                       @SEX               103
210900101203     O                       @DOB               111
211000101203     O                       @SPEC              112
211100101203     O                                          113 '0'
211200101203     O                       @COB               123
211300101203     O                       @COBC              125
211400101203     O                       @COBN              145
211500101203     O                       @AD1               175
211600101203     O                       @AD2               205
211700101203     O                       @CTY               315
211800101203     O                       @ST                317
211900101203     O                       @ZP5               322
212000101203     O                       @PHN               349
212100141211     O               87                         576 '21207'
212200140626     O               88                         576 '21740'
212300141120     O               89                         576 '20171'
212400101203     O                       @EMPST             665
212500101203     O                       @HIRE              673
212600101223     O                                         1231 '*'
212700160616
212800160616      *============================================================================
212900160809     OAET1050WF EADD         HMOF
213000101213     O                                            7 'BENEFIT'
213100101213     O                       X@LAY               10
213200101214     O                       X@ELR               24
213300101213     O                       M@CC                26
213400101213     O                       H@GN                38
213500101213     O                       M@CLASS             44
213600101213     O                       M@PLAN              50
213700101213     O                       X@EFF               58
213800110929     O                       X@TRM               66
213900101213     O                       X@TIER              69
214000101213     O                       M@PCP              160
214100101213     O                       M@NPI              161
214200101213     O                       M@PCPCI            186
214300101223     O                                          323 '*'
214400160616
214500160616      *============================================================================
214600160809     OAET1050WF EADD         MEAF
214700140313     O                                            7 'BENEFIT'
214800140313     O                                           10 'MEA'
214900140313     O                       X@ELR               24
215000140313     O                       H@C#                31
215100140313     O                       E@SFX               34
215200140313     O                       E@ACCT              44
215300140313     O                       E@PLAN              50
215400140313     O                       X@EFF               58
215500140313     O                       X@TRM               66
215600140313     O                       E@CLM               71
215700140313     *** PCP BGN
215800140313     O                       E@PCP              127
215900140313     O               80                         161 'N'
216000140313     O               80                         186 '0'
216100140313     *** PCP END
216200140313     O                                          389 '0'
216300140313     *** COBRA BGN
216400140313     O                       E@CBREXP           466
216500140313     O                       E@CBREVT           516
216600140313     O                       E@CBRLEN           560
216700140313     *** COBRA END
216800140313     O                                          678 '*'
216900160616
217000160616      *============================================================================
217100160809     OAET1050WF EADD         DENF
217200101213     O                                            7 'BENEFIT'
217300101213     O                       X@LAY               10
217400101214     O                       X@ELR               24
217500101214     O                       H@C#                31
217600101213     O                       D@SFX               34
217700101213     O                       D@ACCT              44
217800101213     O                       D@PLAN              50
217900101213     O                       X@EFF               58
218000110929     O                       X@TRM               66
218100101213     O                       D@CLM               71
218200140313     *** PCD BGN
218300140313     O                       D@PCD              200
218400140313     O               81                         236 '0'
218500140313     *** PCD END
218600140313     O                                          389 '0'
218700140313     *** COBRA BGN
218800140313     O                       D@CBREXP           466
218900140313     O                       D@CBREVT           516
219000140313     O                       D@CBRLEN           560
219100140313     *** COBRA END
219200140313     O                       D@OOAI             609
219300140313     O                                          678 '*'
219400160616
219500160616      *============================================================================
219600160809     OAET1050WF EADD         LIFF
219700130315     O                                            7 'BENEFIT'
219800130412     O                                           11 'LIFE'
219900130315     O                       X@ELR               24
220000130319     O                       H@C#3               31
220100130315     O                       L@SFX               34
220200130315     O                       L@ACCT              44
220300130315     O                       L@PLAN              50
220400130315     O                       X@EFF               58
220500130315     O                       X@TRM               66
220600130315     O                       L@CLM               71
220700130315     O                       L@CBREXP           466
220800130315     O                       L@CBREVT           516
220900130315     O                       L@CBRLEN           560
221000130315     O                       L@SALARY           658
221100130315     O                                          659 '1'
221200130315     O                                          678 '*'
221300160616
221400160616      *============================================================================
221500160809     OAET1050WF EADD         TRLF
221600101203     O                                            7 'TRAILER'
221700101203     O                       @TREC               17
221800101203     O                       D1                  25
221900101203     O                       T1                  31
222000101203     O                       @BREC               41
222100101223     O                                           69 '*'
222200160616
222300160616      *============================================================================
