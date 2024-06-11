000100160616      *=================================================================================
000200160314     H option(*noDebugIo)
000300160314      *=================================================================================
000400160314
000500160616      *  CARRIER CONTROL ID #0000000127 AETNA SPECIFIC
000600160616      *  SSK 05.13.2011 TEMPLATE DESIGN
000700160616      *
000800160616      *  08.17.2014 CLONED FROM AET084R
000900160616      *
001000161109      *  11/08/2016  JT  Per Brandon Scarfield... eliminate future Cobra records and send as
001100161109      *                  AC (active) records
001200161109
001300160314      *=================================================================================
001400160314
001500151217     FCARXPTP   IF   E           K DISK
001600151217      * Carrier export control master
001700151217
001800101012     FCARACCP   IF   E           K DISK
001900151217      * Carrier export control by account
002000151217
002100101012     FCARPLNP   IF   E           K DISK
002200151217      * Carrier export control by plan
002300151217
002400160615     FAET004WF  IF   E           K DISK
002500120803     ** MAPPING METHOD
002600151217
002700170308     FAET1100WF O  A F 1231        DISK
002800101206     ** FLAT FILE
002900151217
003000170308     FAET1101WF IF A E           K DISK
003100101028     ** TERM TRACKER
003200151217
003300160616     FMEMAC#1   IF   E           K DISK    ExtFile('F.MEMAC#1')
003400151217
003500160616     FMCOVMPLN  IF   E           K DISK
003600151217
003700160616     FDEPNDC    IF   E           K DISK    ExtFile('F.DEPNDC')
003800151217
003900101012     FDCOVA     IF   E           K DISK
004000151217
004100160616     FPCPL1     IF   E           K DISK     ExtFile('F.PCPL1')
004200151217
004300160616      *=================================================================================
004400160616
004500120803     D KF@CCTL         S             10A   INZ
004600160314
004700160314     D CARR#CTL        S             10A
004800160314     D grouper         S             10A
004900160314
005000160809     D H@RI            S             25A   INZ('042064683')                     RECEIVER ID
005100151217
005200110512     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
005300101026     D DS@CARACC     E DS                  EXTNAME(CARACCP)
005400130315     D*DS@CARXPT     E DS                  EXTNAME(CARXPTP)
005500151217
005600110512     ** WORK ARRAY FOR PLANS
005700110512     **
005800110512     ** PC# - PLAN COUNT
005900110512     ** PP# - PLAN POINTER
006000110512     **
006100110512     D CARPLN@       E DS                  EXTNAME(CARPLNP)
006200151217     D                                     OCCURS(90) PREFIX(X:1)
006300110512     D PC#             S              3S 0
006400110512     D PP#             S              3S 0
006500110512     D @PLANIN         S              4A
006600110512     D @CCTRIN         S              3A
006700160616
006800110513     ** WRITE TYPE = MEMBER OR DEPEND
006900110513     D WRT@TYPE        S              6A
007000110513     **
007100101214     D #XST            S              6S 0
007200101214     D #IST            S               T
007300101026     D #ISO            S               D   DATFMT(*ISO)
007400101214     D #MINUEND        S               D   DATFMT(*ISO)
007500101214     D #SUBTRAEND      S               D   DATFMT(*ISO)
007600101214     D @DATE           S              8A
007700101214     D @TIME           S              6A
007800101214     D #DIFFRNC        S              5S 0
007900101214     D #2S0            S              2S 0
008000101214     D #CANCEL         S              8S 0
008100101026     D #XSX            S              8S 0
008200101026     D #XSX2           S              8S 0
008300101026     D DATE@OUT        S             10A
008400101026     D ENR@IN          S              3A
008500101026     D ENR@OUT         S              1A
008600110524     D DNTLATE         S              1A
008700130315     D TERM_LIF        S               N
008800101214     D TERM_DEN        S               N
008900101214     D TERM_MED        S               N
009000101026     D YES             S               N   INZ(*ON)
009100101026     D NO              S               N   INZ(*OFF)
009200160315
009300160315     D firstTime       S              1    INZ('Y')
009400140313     **
009500110512     D KF@TRS          S                   LIKE(MCTRST)
009600110512     D KF@SUB          S                   LIKE(MCSUB#)
009700110512     D KF@ACC          S                   LIKE(ACC#)
009800101026     D KF@ENR          S              3A   INZ
009900101026     D KF@CARG         S              2A   INZ
010000101026     D KF@CCTR         S                   LIKE(CCFLG)
010100101026     D KF@PLN          S                   LIKE(MCPLAN)
010200101026     D KF@TRM          S                   LIKE(NTTERMDT)
010300101026     D KF#TRM          S              8S 0
010400101026     D KF@SSN          S                   LIKE(MBSSNO)
010500101026     D KF@SEQ          S                   LIKE(DPSEQ#)
010600101026     D KF@TYP          S              1A
010700101026     D KF@CDE          S              2A
010800140313     D KF@SPCD         S              5A
010900140313     D KF@MPLN         S              4A
011000140313     **
011100101026     D M@EARLYP        S              4A
011200101026     D M#EARLYE        S              8S 0 INZ
011300101026     D M#EARLYT        S              8S 0 INZ
011400140313     **
011500101026     D #8D1            S              8S 0 INZ
011600101214     D D1              S              8A
011700101214     D D2              S              8A
011800101214     D T1              S              6A
011900101214     D C1              S             14A
012000101206    ***
012100101029     D B#RECCNT        S             10S 0 INZ
012200101029     D C#RECCNT        S             10S 0 INZ
012300101206    ***
012400101210     D @SS1            S              9A
012500101210     D @SS2            S              9A
012600101210     D @FN             S             15A
012700101210     D @MI             S              1A
012800101210     D @LN             S             20A
012900101210     D @REL            S              2A
013000101210     D @SEX            S              1A
013100101210     D @DOB            S              8A
013200101210     D @SPEC           S              1A
013300101210     D @COB            S              1A
013400101210     D @COBC           S              2A
013500101210     D @COBN           S             20A
013600101210     D @AD1            S             30A
013700101210     D @AD2            S             30A
013800101214     D @CTY            S             20A
013900101210     D @ST             S              2A
014000101210     D @ZP5            S              5A
014100101210     D @PHN            S             10A
014200101210     D @EMPST          S              2A
014300101210     D @HIRE           S              8A
014400160616
014500130315    *** LIFE ARRAYS
014600130315     D L#CNE           S              3S 0 INZ
014700130315     D L#NDX           S              3S 0 INZ
014800130315     D L@PLN           S              4A   DIM(20)
014900130315     D L@ENR           S              3A   DIM(20)
015000130315     D L@FRM           S              8S 0 DIM(20)
015100130315     D L@TRM           S              8S 0 DIM(20)
015200130315     D L@MBREFF        S              8S 0
015300160616
015400101206    *** DENTAL ARRAYS
015500101206     D D#CNE           S              3S 0 INZ
015600101206     D D#NDX           S              3S 0 INZ
015700101206     D D@PLN           S              4A   DIM(20)
015800101206     D D@ENR           S              3A   DIM(20)
015900101206     D D@FRM           S              8S 0 DIM(20)
016000101206     D D@TRM           S              8S 0 DIM(20)
016100160616     D D@MBREFF        S              8S 0
016200160616
016300101206    *** MEDICAL ARRAYS
016400101206     D M#CNE           S              3S 0 INZ
016500101206     D M#NDX           S              3S 0 INZ
016600101206     D M@PLN           S              4A   DIM(20)
016700101206     D M@ENR           S              3A   DIM(20)
016800101206     D M@FRM           S              8S 0 DIM(20)
016900101206     D M@TRM           S              8S 0 DIM(20)
017000110725     D M@MBREFF        S              8S 0
017100101206    ***
017200101206     D H@SI            S             20A
017300101206     D H@CC            S              2A
017400101206     D H@GN            S              7A
017500101206     D H@CN            S             15A
017600101206     D H@C#            S              7A
017700130319     D H@C#3           S              7A
017800140313    ***
017900101213     D X@LAY           S              3A
018000101213     D X@ELR           S              7A
018100140313     D X@EFF           S              8A
018200140313     D X@TRM           S              8A
018300140313     D X@TIER          S              1A
018400140313    ***
018500101213     D M@CC            S              2A
018600101213     D M@CLASS         S              5A
018700101213     D M@PLAN          S              6A
018800101213     D M@PCP           S             40A
018900101213     D M@NPI           S              1A
019000101213     D M@PCPCI         S              1A
019100140313    ***
019200101213     D D@SFX           S              3A
019300101213     D D@ACCT          S              5A
019400101213     D D@PLAN          S              6A
019500101213     D D@CLM           S              3A
019600101213     D D@CBREXP        S              8A
019700101213     D D@CBREVT        S              8A
019800101213     D D@CBRLEN        S              2A
019900101213     D D@OOAI          S              1A
020000140313     D D@PCD           S              7A
020100140313    ***
020200101214     D @STEP           S              5A
020300140313    ***
020400140313     D E@SFX           S              3A
020500140313     D E@ACCT          S              5A
020600140313     D E@PLAN          S              6A
020700140313     D E@CLM           S              3A
020800140313     D E@PCP           S              7A
020900140313     D E@CBREXP        S              8A
021000140313     D E@CBREVT        S              8A
021100140313     D E@CBRLEN        S              2A
021200140313    ***
021300130315     D L@SFX           S              3A
021400130315     D L@ACCT          S              5A
021500130315     D L@PLAN          S              6A
021600130315     D L@CLM           S              3A
021700130315     D L@CBREXP        S              8A
021800130315     D L@CBREVT        S              8A
021900130315     D L@CBRLEN        S              2A
022000130315     D L@SALARY        S             20A
022100161109
022200161109     D effectiveDate   s              8    INZ('20161201')
022300161109     D effectiveDateD  s              8  0 INZ(20161201)
022400161109
022500160616      *=================================================================================
022600160616
022700110512     C                   EVAL      @STEP = 'PREP1'
022800160824
022900160824     C     CARR#CTL      CHAIN     CARXPTR
023000160824
023100160824     C     CARR#CTL      SETLL     CARACCR
023200160616
023300101026     C                   DOU       @STEP = 'LEAVE'
023400101026     C     @STEP         CASEQ     'PREP1'       $PREP1
023500101026     C     @STEP         CASEQ     'STEP1'       $STEP1
023600101026     C     @STEP         CASEQ     'STEP2'       $STEP2
023700101026     C     @STEP         CASEQ     'STEP3'       $STEP3
023800101026     C     @STEP         CASEQ     'PREP4'       $PREP4
023900101026     C     @STEP         CASEQ     'STEP4'       $STEP4
024000101026     C     @STEP         CASEQ     'PREP5'       $PREP5
024100101026     C     @STEP         CASEQ     'STEP5'       $STEP5
024200101214     C     @STEP         CASEQ     'PREP6'       $PREP6
024300101026     C     @STEP         CASEQ     'STEP6'       $STEP6
024400101214     C     @STEP         CASEQ     'PREP7'       $PREP7
024500101214     C     @STEP         CASEQ     'STEP7'       $STEP7
024600101214     C     @STEP         CASEQ     'STEP8'       $STEP8
024700101214     C     @STEP         CASEQ     'PREP9'       $PREP9
024800101214     C     @STEP         CASEQ     'STEP9'       $STEP9
024900101214     C     @STEP         CASEQ     'PREPA'       $PREPA
025000101214     C     @STEP         CASEQ     'STEPA'       $STEPA
025100101214     C     @STEP         CASEQ     'PREPB'       $PREPB
025200101214     C     @STEP         CASEQ     'STEPB'       $STEPB
025300130315     C     @STEP         CASEQ     'PREPC'       $PREPC
025400130315     C     @STEP         CASEQ     'STEPC'       $STEPC
025500101026     C                   ENDCS
025600101026     C                   ENDDO
025700160616
025800101206    ***  TRAILER RECORD
025900101026     C                   ADD       2             C#RECCNT
026000101214     C                   MOVE      C#RECCNT      @TREC            10 0
026100101214     C                   MOVE      B#RECCNT      @BREC            10 0
026200101214     C                   EXCEPT    TRLF
026300160616
026400101026     C                   EVAL      *INLR = *ON
026500160616
026600160616      *============================================================================
026700160616
026800110802     C     $HEADR        BEGSR
026900160616
027000110802     C                   EVAL      D1 = @DATE
027100110802     C                   EVAL      D2 = @DATE
027200110802     C                   EVAL      T1 = @TIME
027300110802     C                   EVAL      C1 = @DATE + @TIME
027400160616
027500160315     C**** carr#ctl      CHAIN     CARACCR
027600160616
027700110802     C                   EVAL      H@SI = %TRIM(CACID1)                         SUBMITTER ID
027800110802     C                   EVAL      H@CC = %SUBST(CACID2:1:2)                    COMPANY CODE
027900110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
028000110802     C                   MOVEL(P)  CACID4        H@CN                           CUSTOMER NAME
028100110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
028200130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
028300160616
028400110802     C                   EXCEPT    HDRF
028500160616
028600160315     C                   eval      firstTime = 'N'
028700160315
028800110802     C                   ENDSR
028900160616
029000160616      *============================================================================
029100110802     C     $PREP1        BEGSR
029200160616
029300160919     C     CARR#CTL      READE     CARACCR
029400160616
029500110512     C                   IF        %EOF(CARACCP)
029600120803      *
029700120815     C*                  IF        KF@CCTL = CARR#CTL
029800120815     C*                  EVAL      KF@CCTL = CARR#CTL2
029900120815     C*    KF@CCTL       SETLL     CARACCR
030000120815     C*                  ELSE
030100110512     C                   EVAL      @STEP = 'LEAVE'
030200120815     C*                  ENDIF
030300120803      *
030400110512     C                   LEAVESR
030500110512     C                   ENDIF
030600160616
030700110513    *** HAS THE ACCOUNT BEEN SHUTOFF FOR EXPORT?
030800110512     C                   IF        CASTATUS <> 'Y'
030900110512     C                   LEAVESR
031000110512     C                   ENDIF
031100160314
031200160314     C                   if        cacida <> grouper
031300160314     C                   leavesr
031400160314     C                   endif
031500160315
031600160824     c****               if        firstTime = 'Y'
031700160824     c****               exsr      $headr
031800160824     c****               endif
031900160315
032000110802    *** THESE FIELDS RESET FOR EACH SMALL GROUP READ
032100160919     C                   EVAL      H@SI = %TRIM(CACID1)                         SUBMITTER ID
032200160919     C                   EVAL      H@CC = %SUBST(CACID2:1:2)                    COMPANY CODE
032300110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
032400160919     C                   MOVEL(P)  CACID4        H@CN                           CUSTOMER NAME
032500110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
032600130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
032700160616
032800160919     C                   EVAL      D1 = @DATE
032900160919     C                   EVAL      D2 = @DATE
033000160919     C                   EVAL      T1 = @TIME
033100160919     C                   EVAL      C1 = @DATE + @TIME
033200160919
033300110512     C                   EVAL      KF@TRS = CATRST
033400110512     C                   EVAL      KF@SUB = CASUB#
033500110512     C                   EVAL      KF@ACC = CAACCT
033600160616
033700110512     C                   EXSR      $PLANLOAD
033800160616
033900160824     c                   if        flag = ' '
034000160824     C                   EXCEPT    HDRF
034100160824     c                   movel     'Y'           flag              1
034200160824     c                   endif
034300160824
034400101206     C                   EVAL      @STEP = 'STEP1'
034500160616
034600110512     C                   ENDSR
034700160616
034800160616      *============================================================================
034900160616
035000101206     C     $STEP1        BEGSR
035100160616
035200101206     C                   EVAL      KF@PLN = *BLANKS
035300101206     C                   EVAL      KF@TRM = 0
035400101206     C                   EVAL      KF@SSN = 0
035500101206     C                   EVAL      KF@SEQ = 0
035600160616
035700101206     C     KL#TSA        SETLL     MEMBR
035800160616
035900101206     C                   EVAL      @STEP = 'STEP2'
036000160616
036100101206     C                   ENDSR
036200160616
036300160616      *============================================================================
036400160616
036500101206     C     $STEP2        BEGSR
036600160616
036700101206     C     KL#TSA        READE     MEMBR
036800160616
036900101206     C                   IF        %EOF(MEMAC#1)
037000110512     C                   EVAL      @STEP = 'PREP1'
037100101206     C                   LEAVESR
037200101206     C                   ENDIF
037300160616
037400101206     C                   EVAL      KF@SSN = MBSSNO
037500101214     C                   MOVE      *ZEROS        KF@SEQ
037600120803     C                   EVAL      WRT@TYPE = 'MEMBER'
037700160616
037800101206     C     KL#MPLN       SETLL     MCOVR
037900160616
038000101206     C                   EXSR      $CLRSTG
038100160616
038200101206     C                   EVAL      @STEP = 'STEP3'
038300160616
038400101206     C                   ENDSR
038500160616
038600160616      *============================================================================
038700160616
038800101206     C     $STEP3        BEGSR
038900160616
039000101206     C     KL#MPLN       READE     MCOVR
039100160616
039200101206     C                   IF        %EOF(MCOVMPLN)
039300101206     C                   EVAL      @STEP = 'PREP4'
039400101206     C                   LEAVESR
039500101206     C                   ENDIF
039600160616
039700130131     C*                  IF        ENRLDT = CANDT
039800130131     C*                  LEAVESR
039900130131     C*                  ENDIF
040000160616
040100120803     C                   EVAL      KF@PLN = MCPLAN
040200160615     C     KL#TSAP       CHAIN     AEF04
040300160615     C                   IF        NOT %FOUND(AET004WF)
040400120803     C                   LEAVESR
040500120803     C                   ENDIF
040600160616
040700110512     C                   EVAL      @PLANIN = MCPLAN
040800111020     C                   EVAL      ENR@IN = MCOVTP
040900160616
041000110802     C                   EXSR      $QUIK
041100160616
041200110512     C                   EXSR      $PLANSRCH
041300160616
041400110512     C                   IF        PLN@CAT = *BLANKS
041500110512     C                   LEAVESR
041600110512     C                   ENDIF
041700160616
041800101206     C                   IF        CANDT = 0
041900101206     C                   EVAL      #CANCEL = 99999999
042000101206     C                   ELSE
042100101206     C                   EVAL      #CANCEL = CANDT
042200101206     C                   ENDIF
042300160616
042400130315    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL;
042500130315    *** LIF IS LIFE;
042600130315     C                   SELECT
042700160616
042800160616     C                   WHEN      PLN@CAT = 'LIFE'
042900160616     C                   IF        L#CNE > 0
043000160616     C                   IF        L@TRM(L#CNE) = 99999999
043100130315     C                   LEAVESR
043200130315     C                   ENDIF
043300130315     C                   ENDIF
043400160616     C                   ADD       1             L#CNE
043500160616     C                   EVAL      L@PLN(L#CNE) = MCPLAN
043600160616     C                   EVAL      L@ENR(L#CNE) = MCOVTP
043700160616     C                   EVAL      L@FRM(L#CNE) = ENRLDT
043800160616     C                   EVAL      L@TRM(L#CNE) = #CANCEL
043900160616
044000160616     C                   WHEN      PLN@CAT = 'DEN'
044100160616     C                   IF        D#CNE > 0
044200160616     C                   IF        D@TRM(D#CNE) = 99999999
044300130131     C                   LEAVESR
044400130131     C                   ENDIF
044500130131     C                   ENDIF
044600160616     C                   ADD       1             D#CNE
044700160616     C                   EVAL      D@PLN(D#CNE) = MCPLAN
044800160616     C                   EVAL      D@ENR(D#CNE) = MCOVTP
044900160616     C                   EVAL      D@FRM(D#CNE) = ENRLDT
045000160616     C                   EVAL      D@TRM(D#CNE) = #CANCEL
045100160616
045200130315     C                   OTHER
045300160616     C                   IF        M#CNE > 0
045400160616     C                   IF        M@TRM(M#CNE) = 99999999
045500130131     C                   LEAVESR
045600130131     C                   ENDIF
045700130131     C                   ENDIF
045800101206     C                   ADD       1             M#CNE
045900101206     C                   EVAL      M@PLN(M#CNE) = MCPLAN
046000101206     C                   EVAL      M@ENR(M#CNE) = MCOVTP
046100101206     C                   EVAL      M@FRM(M#CNE) = ENRLDT
046200101206     C                   EVAL      M@TRM(M#CNE) = #CANCEL
046300160616
046400160616     C                   ENDSL
046500160616
046600110512     C                   ENDSR
046700160616
046800160616      *============================================================================
046900160616
047000110802     C     $QUIK         BEGSR
047100160616
047200110805     C                   EVAL      @CCTRIN = *BLANKS
047300160616
047400160615     C     AE4MAP        CASEQ     '2TIER     '  $METH01
047500160615     C     AE4MAP        CASEQ     'ITOBJECTS '  $METH02
047600160615     C     AE4MAP        CASEQ     'NORULE    '  $METH03
047700160615     C     AE4MAP        CASEQ     'STATETIER '  $METH04
047800160615     C     AE4MAP        CASEQ     'TIERSTS   '  $METH05
047900160615     C     AE4MAP        CASEQ     'MAYOR     '  $METH06
048000160615     C     AE4MAP        CASEQ     'EMPSTS    '  $METH07
048100160615     C     AE4MAP        CASEQ     'JUSTSTATE '  $METH08
048200160615     C     AE4MAP        CASEQ     'JOHNLS    '  $METH09
048300160615     C     AE4MAP        CASEQ     'CREATIVE  '  $METH10
048400160615     C     AE4MAP        CASEQ     'INTEGRA   '  $METH11
048500160615     C     AE4MAP        CASEQ     'STSTATE   '  $METH12
048600160615     C     AE4MAP        CASEQ     'INTEGRA   '  $METH11
048700160615     C     AE4MAP        CASEQ     'STIERSTS  '  $METH13
048800120803     C                   ENDCS
048900160616
049000120803     C                   ENDSR
049100160616
049200160616      *============================================================================
049300160616
049400160616      * 2 TIER = AETNA HAS TWO TIERS, IND AND FAM
049500160616      *  MEMBERS HAVE 'TIN' CONVERTED TO 'IND' AND NON-'TIN' CONVERTED TO 'FAM'
049600160616      *  DEPENDENTS HAVE 'FAM' ONLY
049700160616      *
049800160616      * IND, FAM
049900160616
050000160616      *============================================================================
050100160616
050200120803     C     $METH01       BEGSR
050300160616
050400120803     C                   IF        WRT@TYPE = 'MEMBER'
050500160616
050600120803     C                   IF        ENR@IN = 'TIN'
050700120803     C                   EVAL      @CCTRIN = 'IND'
050800120803     C                   ELSE
050900120803     C                   EVAL      @CCTRIN = 'FAM'
051000120803     C                   ENDIF
051100160616
051200120803     C                   ENDIF
051300160616
051400120803     C                   IF        WRT@TYPE = 'DEPEND'
051500160616
051600120803     C                   EVAL      @CCTRIN = 'FAM'
051700160616
051800120803     C                   ENDIF
051900160616
052000120803     C                   ENDSR
052100160616
052200160616      *============================================================================
052300160616
052400160616      * ITOBJECTS = IF YOU ARE NOT 'VA' OR 'OH' STATE CODES, YOU ARE 'XX'
052500160616
052600160616      * VA, OH, XX
052700160616
052800160616      *============================================================================
052900160616
053000120803     C     $METH02       BEGSR
053100160616
053200120803     C                   IF        STATE <> 'VA' AND STATE <> 'OH'
053300120803     C                   EVAL      @CCTRIN = 'XX '
053400120803     C                   ELSE
053500120803     C                   EVAL      @CCTRIN = STATE
053600120803     C                   ENDIF
053700160616
053800120803     C                   ENDSR
053900160616
054000160616      *============================================================================
054100160616      * NORULE = NUFF SAID
054200160616      *============================================================================
054300160616
054400120803     C     $METH03       BEGSR
054500160616
054600120803     C                   EVAL      @CCTRIN = *BLANKS
054700160616
054800120803     C                   ENDSR
054900160616
055000160616      *============================================================================
055100160616      * STATETIER
055200160616      *  START WITH STATE CODE
055300160616      *  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
055400160616      *  DEPENDENTS HAVE 'F' ONLY
055500160616      * MDI, MDF, ETC...
055600160616      *============================================================================
055700160616
055800120803     C     $METH04       BEGSR
055900160616
056000120803     C                   EVAL      @CCTRIN = STATE
056100160616
056200120803     C                   IF        WRT@TYPE = 'MEMBER'
056300120803     C                   IF        ENR@IN = 'TIN'
056400120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
056500120803     C                   ELSE
056600120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
056700120803     C                   ENDIF
056800120803     C                   ENDIF
056900160616
057000120803     C                   IF        WRT@TYPE = 'DEPEND'
057100120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
057200120803     C                   ENDIF
057300160616
057400120803     C                   ENDSR
057500160616
057600160616      *============================================================================
057700160616      * TIERSTS
057800160616      *  START WITH EMPLOYMENT STATUS, ACTIVE IS 'ACT' AND COBRA IS 'COB'
057900160616      *  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
058000160616      *  DEPENDENTS HAVE 'F' ONLY
058100160616      *
058200160616      * ACI, ACF, COI, COF
058300160616      *============================================================================
058400160616
058500120803     C     $METH05       BEGSR
058600160616
058700120803     C                   IF        EMPST =  'C'
058800120803     C                   EVAL      @CCTRIN = 'COB'
058900120803     C                   ELSE
059000120803     C                   EVAL      @CCTRIN = 'ACT'
059100120803     C                   ENDIF
059200160616
059300120803     C                   IF        ENR@IN = 'TIN'
059400120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
059500120803     C                   ELSE
059600120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
059700120803     C                   ENDIF
059800160616
059900120803     C                   ENDSR
060000160616
060100160616      *============================================================================
060200160616      * MAYOR
060300160616      *  WELL, FOR THE PLAN 'DAAU' IF THE STATE IS 'WV' THEN PLACE TIER STATUS SUFFIX
060400160616      *       BY TYPE OF PEEP; FOR OTHER STATES, USE A SIMPLE TIER CHECK.
060500160616      *
060600160616      *  WVI, WVF, IND, FAM
060700160616      *
060800160616      *  NOW, FOR THE PLAN 'DAAT' IF THE STATE IS 'WV' THEN PLACE EMPLOYMENT STATUS SUFFIX
060900160616      *       BY TYPE OF PEEP; FOR OTHER STATES, EMPLOYMENT STATUS AND TIER.
061000160616      *
061100160616      *  WVI, WVF, CBI, CBF, ACI, ACF
061200160616      *============================================================================
061300160616
061400120803     C     $METH06       BEGSR
061500160616
061600160616     C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'MEMBER'
061700160616
061800160616     C                   IF        STATE = 'WV'
061900160616
062000160616     C                   IF        ENR@IN = 'TIN'
062100120803     C                   EVAL      @CCTRIN = 'WVI'
062200160616     C                   ELSE
062300120803     C                   EVAL      @CCTRIN = 'WVF'
062400160616     C                   ENDIF
062500160616
062600160616     C                   ELSE
062700160616
062800160616     C                   IF        ENR@IN = 'TIN'
062900120803     C                   EVAL      @CCTRIN = 'IND'
063000160616     C                   ELSE
063100120803     C                   EVAL      @CCTRIN = 'FAM'
063200160616     C                   ENDIF
063300160616
063400160616     C                   ENDIF
063500160616
063600120803     C                   LEAVESR
063700160616     C                   ENDIF
063800160616
063900120803     C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'DEPEND'
064000160616
064100120803     C                   IF        STATE = 'WV'
064200120803     C                   EVAL      @CCTRIN = 'WVF'
064300120803     C                   ELSE
064400120803     C                   EVAL      @CCTRIN = 'FAM'
064500120803     C                   ENDIF
064600160616
064700120803     C                   LEAVESR
064800120803     C                   ENDIF
064900160616
065000160616     C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'MEMBER'
065100160616
065200160616     C                   IF        STATE = 'WV'
065300160616
065400160616     C                   IF        ENR@IN = 'TIN'
065500120803     C                   EVAL      @CCTRIN = 'WVI'
065600160616     C                   ELSE
065700120803     C                   EVAL      @CCTRIN = 'WVF'
065800160616     C                   ENDIF
065900160616
066000160616     C                   ELSE
066100160616
066200160616     C                   IF        EMPST =  'C'
066300120803     C                   EVAL      @CCTRIN = 'CB '
066400160616     C                   ELSE
066500120803     C                   EVAL      @CCTRIN = 'AC '
066600160616     C                   ENDIF
066700160616     C                   IF        ENR@IN = 'TIN'
066800120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
066900160616     C                   ELSE
067000120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
067100160616     C                   ENDIF
067200160616
067300160616     C                   ENDIF
067400160616
067500120803     C                   LEAVESR
067600160616     C                   ENDIF
067700160616
067800120803     C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'DEPEND'
067900160616
068000120803     C                   IF        STATE = 'WV'
068100120803     C                   EVAL      @CCTRIN = 'WVF'
068200120803     C                   ELSE
068300120803     C                   IF        EMPST =  'C'
068400120803     C                   EVAL      @CCTRIN = 'CBF'
068500120803     C                   ELSE
068600120803     C                   EVAL      @CCTRIN = 'ACF'
068700120803     C                   ENDIF
068800120803     C                   ENDIF
068900160616
069000120803     C                   ENDIF
069100160616
069200120803     C                   ENDSR
069300160616
069400160616      *============================================================================
069500160616      * EMPSTS
069600160616      *   PRETTY STRAIGHT FORWARDED
069700160616      *============================================================================
069800160616
069900120803     C     $METH07       BEGSR
070000160616
070100120803     C                   IF        EMPST =  'C'
070200120803     C                   EVAL      @CCTRIN = 'COB'
070300120803     C                   ELSE
070400120803     C                   EVAL      @CCTRIN = 'ACT'
070500120803     C                   ENDIF
070600160616
070700120803     C                   ENDSR
070800160616
070900160616      *============================================================================
071000160616      * JUSTSTATE
071100160616      *   PRETTY STRAIGHT FORWARDED
071200160616      *============================================================================
071300160616
071400120803     C     $METH08       BEGSR
071500160616
071600120803     C                   EVAL      @CCTRIN = STATE
071700160616
071800120803     C                   ENDSR
071900160616      *============================================================================
072000160616      * JOHNLS
072100160616      *   IF STATE IS NOT MARYLAND, DEFAULT TO 'XX', ELSE USE 'MD'; THEN APPLY TIER.
072200160616      * MDI, MDF, XXI, XXF
072300160616      *============================================================================
072400160616
072500120803     C     $METH09       BEGSR
072600160616
072700120803     C                   IF        WRT@TYPE = 'MEMBER'
072800120803     C                   IF        STATE = 'MD'
072900120803     C                   EVAL      @CCTRIN = 'MD'
073000120803     C                   ELSE
073100120803     C                   EVAL      @CCTRIN = 'XX'
073200120803     C                   ENDIF
073300120803     C                   IF        ENR@IN = 'TIN'
073400120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
073500120803     C                   ELSE
073600120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
073700120803     C                   ENDIF
073800120803     C                   ENDIF
073900160616
074000120803     C                   IF        WRT@TYPE = 'DEPEND'
074100120803     C                   IF        STATE = 'MD'
074200120803     C                   EVAL      @CCTRIN = 'MDF'
074300120803     C                   ELSE
074400120803     C                   EVAL      @CCTRIN = 'XXF'
074500120803     C                   ENDIF
074600120803     C                   ENDIF
074700160616
074800120803     C                   ENDSR
074900160616
075000160616      *============================================================================
075100160616      * CREATIVE
075200160616      *   IF STATE IS NOT 'MD' OR 'OK', DEFAULT TO '**'.
075300160616      * MD, OK, **
075400160616      *============================================================================
075500160616
075600120803     C     $METH10       BEGSR
075700160616
075800120803     C                   IF        STATE <> 'MD' AND STATE <> 'OK'
075900120803     C                   EVAL      @CCTRIN = '** '
076000120803     C                   ELSE
076100120803     C                   EVAL      @CCTRIN = STATE
076200120803     C                   ENDIF
076300160616
076400120803     C                   ENDSR
076500160616
076600160616      *============================================================================
076700160616      * INTEGRA = USE 'TN' FOR TENNESSEE, OTHER STATES ARE 'XX'
076800160616      *  TN, XX
076900160616      *============================================================================
077000160616
077100120803     C     $METH11       BEGSR
077200160616
077300121113     C                   SELECT
077400121113     C                   WHEN      STATE = 'TN'
077500121113     C                   EVAL      @CCTRIN = STATE                              TENNESSEE ONLY
077600121113     C                   WHEN      STATE = 'FL'
077700121113     C                   EVAL      @CCTRIN = STATE                              FLORIDA ONLY
077800121113     C                   OTHER
077900121113     C                   EVAL      @CCTRIN = 'XX '                              SITUS
078000160616     C                   ENDSL
078100160616
078200120803     C                   ENDSR
078300160616
078400160616      *============================================================================
078500160616      * STSTATE = STATE CODE WITH EMPLOYEE STATUS
078600160616      *  MDA, MDC, ETC...
078700160616      *============================================================================
078800160616
078900120803     C     $METH12       BEGSR
079000160616
079100120803     C                   EVAL      @CCTRIN = STATE + EMPST
079200160616
079300120803     C                   ENDSR
079400160616
079500160616      *============================================================================
079600160616      * STIERSTS = STATE CODE WITH TIER WITH EMPLOYEE STATUS
079700160616      *    ACTIVE [#CALC = 0]      COBRA [#CALC = 5]
079800160616      *    IND [+1 TO #CALC ]      NON-IND COVERAGE [+2 TO CALC]
079900160616      *    EACH STATE PUT AT END, GIVING FAM MARYLAND ACTIVE A VALUE OF 2MD
080000160616      *                                  IND WEST VIRGINIA COBRA A VALUE OF 6WV
080100160616      *============================================================================
080200160616
080300130123     C     $METH13       BEGSR
080400160616
080500130123     C                   SELECT
080600130123     C                   WHEN      EMPST =  'C'
080700130123     C                   Z-ADD     5             #CALC
080800130123     C                   OTHER
080900130123     C                   MOVE      *ZEROS        #CALC             1 0
081000130123     C                   ENDSL
081100160616
081200130123     C                   SELECT
081300130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN = 'TIN'
081400130123     C                   ADD       1             #CALC
081500130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN <> 'TIN'
081600130123     C                   ADD       2             #CALC
081700130123     C                   WHEN      WRT@TYPE = 'DEPEND'
081800130123     C                   ADD       2             #CALC
081900130123     C                   ENDSL
082000160616
082100130123     C                   EVAL      @CCTRIN = %EDITC(#CALC:'X') + STATE
082200160616
082300130123     C                   ENDSR
082400160616
082500160616      *============================================================================
082600160616
082700120409     C     $PREP4        BEGSR
082800160616
082900130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
083000101206     C                   EVAL      @STEP = 'STEP2'
083100101206     C                   LEAVESR
083200101206     C                   ENDIF
083300160616
083400130520     C                   EVAL      @STEP = 'STEP4'
083500130315     C                   EVAL      TERM_LIF = NO
083600101210     C                   EVAL      TERM_DEN = NO
083700101210     C                   EVAL      TERM_MED = NO
083800160616
083900130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
084000130520     C                   IF        L@TRM(L#CNE) <> 99999999
084100130520     C                   EXSR      $CHKHEM
084200130520     C                   ENDIF
084300130520     C                   LEAVESR
084400130520     C                   ENDIF
084500160616
084600130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
084700130520     C                   IF        M@TRM(M#CNE) <> 99999999
084800130520     C                   EXSR      $CHKHEM
084900130520     C                   ENDIF
085000130520     C                   LEAVESR
085100130520     C                   ENDIF
085200160616
085300130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
085400130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
085500130520     C                              M@TRM(M#CNE) <> 99999999)
085600130520     C                   EXSR      $CHKHEM
085700130520     C                   ENDIF
085800130520     C                   LEAVESR
085900130520     C                   ENDIF
086000160616
086100130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
086200130520     C                   IF        D@TRM(D#CNE) <> 99999999
086300130520     C                   EXSR      $CHKHEM
086400130520     C                   ENDIF
086500130520     C                   LEAVESR
086600130520     C                   ENDIF
086700160616
086800130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
086900130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
087000130520     C                              D@TRM(D#CNE) <> 99999999)
087100130520     C                   EXSR      $CHKHEM
087200130520     C                   ENDIF
087300130520     C                   LEAVESR
087400130520     C                   ENDIF
087500160616
087600130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
087700130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
087800130520     C                              M@TRM(M#CNE) <> 99999999)
087900130520     C                   EXSR      $CHKHEM
088000130520     C                   ENDIF
088100130520     C                   LEAVESR
088200130520     C                   ENDIF
088300160616
088400130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
088500130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
088600130520     C                              L@TRM(L#CNE) <> 99999999 OR
088700130520     C                              M@TRM(M#CNE) <> 99999999)
088800130520     C                   EXSR      $CHKHEM
088900130520     C                   ENDIF
089000130520     C                   LEAVESR
089100130520     C                   ENDIF
089200160616
089300101214     C                   ENDSR
089400160616
089500160616      *============================================================================
089600160616      * GENERATE MEMBER RECORD
089700160616      *============================================================================
089800160616
089900101210     C     $STEP4        BEGSR
090000160616
090100130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
090200101214     C                   EVAL      @STEP = 'STEP2'
090300101214     C                   LEAVESR
090400101214     C                   ENDIF
090500160616
090600110513     C                   EVAL      WRT@TYPE = 'MEMBER'
090700160616
090800130315     C                   EVAL      L@MBREFF = 0
090900110725     C                   EVAL      D@MBREFF = 0
091000110725     C                   EVAL      M@MBREFF = 0
091100160616
091200101210     C                   EVAL      @SS1   = %EDITC(MBSSNO:'X')
091300101210     C                   EVAL      @SS2   = @SS1
091400101210     C                   MOVEL(P)  MLNAME        @LN
091500101210     C                   MOVEL(P)  MFNAME        @FN
091600101210     C                   EVAL      @MI    = MMI
091700101210     C                   EVAL      @REL   = '01'
091800101210     C                   EVAL      @SEX   = SEX
091900101210     C                   EVAL      @DOB   = %EDITC(BIRTH:'X')
092000101210     C                   IF        COB = 'Y'
092100101210     C                   EVAL      @COB   = 'Y'
092200101210     C                   EVAL      @COBC  = 'OT'
092300101210     C                   EVAL      @COBN  = MCOBPN
092400101210     C                   ENDIF
092500101210     C                   EVAL      @AD1   = %TRIM(ADDR1)
092600101210     C                   EVAL      @AD2   = %TRIM(ADDR2)
092700101210     C                   EVAL      @CTY   = %TRIM(CITY)
092800101210     C                   EVAL      @ST    = STATE
092900101210     C                   MOVE      *BLANKS       @9                9
093000101210     C                   EVAL      @9   = %EDITC(ZIP:'X')
093100101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
093200101210     C                   EVAL      @PHN   = %EDITC(AREA:'X') +
093300101210     C                                      %EDITC(PHONE:'X')
093400160616
093500101210     C                   SELECT
093600101210     C                   WHEN      EMPST = 'A'
093700101210     C                   EVAL      @EMPST = 'AC'
093800101210     C                   WHEN      EMPST = 'C'
093900101210     C                   EVAL      @EMPST = 'CO'
094000101210     C                   WHEN      EMPST = 'R'
094100101210     C                   EVAL      @EMPST = 'RT'
094200101210     C                   ENDSL
094300160616
094400101210     C                   EVAL      @HIRE  = %EDITC(EMPDT:'X')
094500160616
094600141211     C                   SETOFF                                       888987
094700141120        IF KF@TRS = 770 AND KF@SUB = 004 AND KF@ACC = 0037 AND
094800141120          STATE = 'VT';
094900141120           *IN89 = *ON;
095000141120        ENDIF;
095100161109
095200161109       // if cobra and effective date > 12/01/2016...
095300161109       if empst = 'C';
095400161109        if qedt >= effectiveDateD;
095500161109         @empst = 'AC';
095600161109        endif;
095700161109       endif;
095800161109
095900101210     C                   EXCEPT    MBRF
096000101214     C                   ADD       1             C#RECCNT
096100160616
096200101213     C                   EVAL      @STEP = 'PREP5'
096300160616
096400101210     C                   ENDSR
096500160616
096600160616      *============================================================================
096700160616      * MEDICAL
096800160616      *============================================================================
096900160616
097000101214     C     $PREP5        BEGSR
097100160616
097200101214     C                   IF        M#CNE = 0
097300110513     C                   EVAL      @STEP = 'PREP6'
097400101214     C                   LEAVESR
097500101214     C                   ENDIF
097600160616
097700101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
097800130315     C                   EVAL      KF@ENR = M@ENR(M#CNE)
097900160616
098000101214     C                   IF        TERM_MED = YES
098100101214     C                   EXSR      $WRTERM
098200101214     C                   ENDIF
098300160616
098400110512     C                   EVAL      @PLANIN = KF@PLN
098500160616
098600160615     C     KL#TSAP       CHAIN     AEF04
098700160615     C                   IF        NOT %FOUND(AET004WF)
098800120803     C                   LEAVESR
098900120803     C                   ENDIF
099000160616
099100111020     C                   EVAL      ENR@IN = M@ENR(M#CNE)
099200160616
099300110802     C                   EXSR      $QUIK
099400160616
099500110512     C                   EXSR      $PLANSRCH
099600160616
099700110512     C                   IF        PLN@CAT = *BLANKS
099800101214     C                   SETON                                        H1
099900101214     C                   ENDIF
100000160616
100100110513     C                   EVAL      @STEP = 'STEP5'
100200110725     C                   EVAL      #XSX = M@FRM(M#CNE)
100300110725     C                   EVAL      M@MBREFF = #XSX
100400160616
100500101214     C                   ENDSR
100600160616
100700160616      *============================================================================
100800160616
100900101214     C     $STEP5        BEGSR
101000160616
101100110513     C                   IF        CPCID1 = 'MEA'
101200110513     C                   EXSR      $MEAWRT
101300110513     C                   ELSE
101400110513     C                   EXSR      $HMOWRT
101500110513     C                   ENDIF
101600160616
101700101214     C                   ADD       1             C#RECCNT
101800101214     C                   ADD       1             B#RECCNT
101900160616
102000110513     C                   EVAL      @STEP = 'PREP6'
102100160616
102200110513     C                   ENDSR
102300160616
102400160616      *============================================================================
102500160616      * DENTAL
102600160616      *============================================================================
102700160616
102800101214     C     $PREP6        BEGSR
102900160616
103000160616     C                   IF        D#CNE = 0
103100160616     C                   EVAL      @STEP = 'PREPC'
103200160616     C*****************  EVAL      @STEP = 'PREP7'
103300160616     C                   LEAVESR
103400160616     C                   ENDIF
103500160616
103600160616     C                   EVAL      KF@PLN = D@PLN(D#CNE)
103700160616     C                   EVAL      KF@ENR = D@ENR(D#CNE)
103800160616
103900160615     C     KL#TSAP       CHAIN     AEF04
104000160615     C                   IF        NOT %FOUND(AET004WF)
104100120803     C                   LEAVESR
104200120803     C                   ENDIF
104300160616
104400160616     C                   IF        TERM_DEN = YES
104500160616     C                   EXSR      $WRTERM
104600160616     C                   ENDIF
104700160616
104800110513     C                   EVAL      @PLANIN = KF@PLN
104900111020     C                   EVAL      ENR@IN = D@ENR(D#CNE)
105000160616
105100111011     C                   EXSR      $QUIK
105200160616
105300110513     C                   EXSR      $PLANSRCH
105400160616
105500110513     C                   IF        PLN@CAT = *BLANKS
105600110513     C                   SETON                                        H2
105700110513     C                   ENDIF
105800160616
105900160616     C                   EVAL      @STEP = 'STEP6'
106000110725     C                   EVAL      #XSX = D@FRM(D#CNE)
106100110725     C                   EVAL      D@MBREFF = #XSX
106200160616
106300101213     C                   ENDSR
106400160616
106500160616      *============================================================================
106600160616      * DENTAL FORMAT
106700160616      *============================================================================
106800160616
106900160616     C     $STEP6        BEGSR
107000110513     C                   EXSR      $DENWRT
107100160616
107200160616     C                   ADD       1             C#RECCNT
107300160616     C                   ADD       1             B#RECCNT
107400160616
107500160616     C****************** EVAL      @STEP = 'PREP7'
107600160616     C                   EVAL      @STEP = 'PREPC'
107700160616
107800160616     C                   ENDSR
107900160616
108000160616      *============================================================================
108100160616      * LIFE AND AD&D PLANS FOR MEMBER
108200160616      *============================================================================
108300160616
108400130315     C     $PREPC        BEGSR
108500160616
108600160616     C                   IF        L#CNE = 0
108700160616     C                   EVAL      @STEP = 'PREP7'
108800160616     C                   LEAVESR
108900160616     C                   ENDIF
109000160616
109100160616     C                   EVAL      KF#TRM = L@TRM(L#CNE)
109200160616     C                   EVAL      KF@PLN = L@PLN(L#CNE)
109300130315     C                   EVAL      KF@ENR = L@ENR(L#CNE)
109400160616
109500160615     C     KL#TSAP       CHAIN     AEF04
109600160615     C                   IF        NOT %FOUND(AET004WF)
109700130315     C                   LEAVESR
109800130315     C                   ENDIF
109900160616
110000160616     C                   IF        TERM_LIF = YES
110100160616     C                   EXSR      $WRTERM
110200160616     C                   ENDIF
110300160616
110400130315     C                   EVAL      @PLANIN = KF@PLN
110500130315     C                   EVAL      ENR@IN = L@ENR(L#CNE)
110600160616
110700130315     C                   EXSR      $QUIK
110800160616
110900130315     C                   EXSR      $PLANSRCH
111000160616
111100130315     C                   IF        PLN@CAT = *BLANKS
111200130315     C                   SETON                                        H2
111300130315     C                   ENDIF
111400160616
111500160616     C                   EVAL      @STEP = 'STEPC'
111600130315     C                   EVAL      #XSX = L@FRM(L#CNE)
111700130315     C                   EVAL      L@MBREFF = #XSX
111800160616
111900130315     C                   ENDSR
112000160616
112100160616      *============================================================================
112200160616      * LIFE FORMAT
112300160616      *============================================================================
112400160616
112500160616     C     $STEPC        BEGSR
112600160616
112700130315     C                   EXSR      $LIFWRT
112800160616
112900160616     C                   ADD       1             C#RECCNT
113000160616     C                   ADD       1             B#RECCNT
113100160616
113200160616     C                   EVAL      @STEP = 'PREP7'
113300160616
113400160616     C                   ENDSR
113500160616
113600160616      *============================================================================
113700160616
113800130315     C     $LIFWRT       BEGSR
113900160616
114000160616     C                   EVAL      X@LAY = CPCID1                               LAYOUT
114100160616     C                   EVAL      X@ELR = CPCID2                               ELR
114200160616     C                   EVAL      L@SFX = CPCID3                               SUFFIX
114300160616     C                   EVAL      L@ACCT = CPCID4                              ACCOUNT
114400160616     C                   EVAL      L@PLAN = CPCID5                              PLAN
114500160616     C                   EVAL      L@CLM = CPCID6                               CLAIM OFFICE
114600160616
114700160616     C                   EVAL      #XSX = L@FRM(L#CNE)
114800130315     C                   MOVE      #XSX          X@EFF
114900160616
115000160616     C                   EVAL      #XSX = L@TRM(L#CNE)
115100160616     C                   IF        #XSX = 0 OR #XSX = 99999999
115200160616     C                   MOVE      *BLANKS       X@TRM
115300160616     C                   ELSE
115400160616     C                   MOVE      #XSX          X@TRM
115500160616     C                   ENDIF
115600160616
115700140313     C                   MOVE      *BLANKS       L@CBREXP
115800140313     C                   MOVE      *BLANKS       L@CBREVT
115900140313     C                   MOVE      *BLANKS       L@CBRLEN
116000160616
116100160616     C                   IF        EMPST = 'C' AND
116200130923     C                             CEXPDT > 0
116300160616     C                   MOVE      CEXPDT        L@CBREXP
116400160616     C                   MOVE      QEDT          L@CBREVT
116500160616     C                   MOVE      CEXPDT        #MINUEND
116600160616     C                   MOVE      QEDT          #SUBTRAEND
116700160616     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
116800160616     C                   Z-ADD     #DIFFRNC      #2S0
116900160616     C                   MOVE      #2S0          L@CBRLEN
117000160616     C                   ENDIF
117100160616
117200130315     C                   EVAL      L@SALARY = %EDITC(SALARY:'4')
117300160616
117400160616     C                   EXCEPT    LIFF
117500160616
117600160616     C                   ENDSR
117700160616
117800160616      *============================================================================
117900160616
118000101214     C     $PREP7        BEGSR
118100160616
118200101214     C     KF@SSN        CHAIN     DEPENR
118300101214     C                   IF        NOT %FOUND(DEPNDC)
118400101214     C                   EVAL      @STEP = 'STEP2'
118500101214     C                   LEAVESR
118600101214     C                   ENDIF
118700160616
118800101214     C     KF@SSN        SETLL     DEPENR
118900160616
119000101214     C                   EVAL      @STEP = 'STEP7'
119100160616
119200101214     C                   ENDSR
119300160616
119400160616      *============================================================================
119500160616
119600101214     C     $STEP7        BEGSR
119700160616
119800101214     C     KF@SSN        READE     DEPENR
119900160616
120000101214     C                   IF        %EOF(DEPNDC)
120100101214     C                   EVAL      @STEP = 'STEP2'
120200101214     C                   LEAVESR
120300101214     C                   ENDIF
120400160616
120500101214     C                   EVAL      KF@SEQ = DPSEQ#
120600120803     C                   EVAL      WRT@TYPE = 'DEPEND'
120700160616
120800101214     C     KL#DCV        CHAIN     DCOVR
120900101214     C                   IF        NOT %FOUND(DCOVA)
121000101214     C                   LEAVESR
121100101214     C                   ENDIF
121200160616
121300101214     C                   EXSR      $CLRDCV
121400101214     C     KL#DCV        SETLL     DCOVR
121500160616
121600101214     C                   EVAL      @STEP = 'STEP8'
121700160616
121800101214     C                   ENDSR
121900160616
122000160616      *============================================================================
122100160616
122200101214     C     $STEP8        BEGSR
122300160616
122400101214     C     KL#DCV        READE     DCOVR
122500160616
122600101214     C                   IF        %EOF(DCOVA)
122700101214     C                   EVAL      @STEP = 'PREP9'
122800101214     C                   LEAVESR
122900101214     C                   ENDIF
123000160616
123100160616     C*                  IF        DENRDT = CCANDT
123200160616     C*                  LEAVESR
123300160616     C*                  ENDIF
123400160616
123500110513     C                   EVAL      @PLANIN = DVPLAN
123600120803     C                   EVAL      KF@PLN = DVPLAN
123700160615     C     KL#TSAP       CHAIN     AEF04
123800160615     C                   IF        NOT %FOUND(AET004WF)
123900120803     C                   LEAVESR
124000120803     C                   ENDIF
124100160616
124200110802     C                   EXSR      $QUIKD
124300160616
124400110513     C                   EXSR      $PLANSRCH
124500160616
124600110513     C                   IF        PLN@CAT = *BLANKS
124700110513     C                   LEAVESR
124800110513     C                   ENDIF
124900160616
125000101214     C                   EVAL      #CANCEL = CCANDT
125100101214     C                   IF        #CANCEL = 0
125200101214     C                   EVAL      #CANCEL = 99999999
125300101214     C                   ENDIF
125400160616
125500160616      * DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL; LIFE IS MEMBER ONLY
125600160616
125700160616     C                   IF        PLN@CAT = 'DEN'
125800160616     C                   IF        D#CNE > 0
125900160616     C                   IF        D@TRM(D#CNE) = 99999999
126000130131     C                   LEAVESR
126100130131     C                   ENDIF
126200130131     C                   ENDIF
126300160616     C                   ADD       1             D#CNE
126400160616     C                   EVAL      D@PLN(D#CNE) = DVPLAN
126500160616     C                   EVAL      D@ENR(D#CNE) = *BLANKS
126600160616     C                   EVAL      D@FRM(D#CNE) = DENRDT
126700160616     C                   EVAL      D@TRM(D#CNE) = #CANCEL
126800160616     C                   ELSE
126900160616     C                   IF        M#CNE > 0
127000160616     C                   IF        M@TRM(M#CNE) = 99999999
127100130131     C                   LEAVESR
127200130131     C                   ENDIF
127300130131     C                   ENDIF
127400101214     C                   ADD       1             M#CNE
127500101214     C                   EVAL      M@PLN(M#CNE) = DVPLAN
127600101214     C                   EVAL      M@ENR(M#CNE) = *BLANKS
127700101214     C                   EVAL      M@FRM(M#CNE) = DENRDT
127800101214     C                   EVAL      M@TRM(M#CNE) = #CANCEL
127900160616     C                   ENDIF
128000160616
128100101214     C                   ENDSR
128200160616
128300160616      *============================================================================
128400160616
128500111011     C     $QUIKD        BEGSR
128600160616
128700120803     C                   EXSR      $QUIK
128800160616
128900120409     C                   ENDSR
129000160616
129100160616      *============================================================================
129200160616
129300101214     C     $PREP9        BEGSR
129400160616
129500101214     C                   IF        D#CNE = 0 AND M#CNE = 0
129600101214     C                   EVAL      @STEP = 'STEP7'
129700101214     C                   LEAVESR
129800101214     C                   ENDIF
129900160616
130000130315     C                   EVAL      L#CNE = 0
130100130315     C                   EVAL      TERM_LIF = NO
130200101214     C                   EVAL      TERM_DEN = NO
130300101214     C                   EVAL      TERM_MED = NO
130400130520     C                   EVAL      @STEP = 'STEP9'
130500160616
130600130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
130700130520     C                   IF        L@TRM(L#CNE) <> 99999999
130800130520     C                   EXSR      $CHKHEM
130900130520     C                   ENDIF
131000130520     C                   LEAVESR
131100130520     C                   ENDIF
131200160616
131300130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
131400130520     C                   IF        M@TRM(M#CNE) <> 99999999
131500130520     C                   EXSR      $CHKHEM
131600130520     C                   ENDIF
131700130520     C                   LEAVESR
131800130520     C                   ENDIF
131900160616
132000130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
132100130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
132200130520     C                              M@TRM(M#CNE) <> 99999999)
132300130520     C                   EXSR      $CHKHEM
132400130520     C                   ENDIF
132500130520     C                   LEAVESR
132600130520     C                   ENDIF
132700160616
132800130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
132900130520     C                   IF        D@TRM(D#CNE) <> 99999999
133000130520     C                   EXSR      $CHKHEM
133100130520     C                   ENDIF
133200130520     C                   LEAVESR
133300130520     C                   ENDIF
133400160616
133500130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
133600130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
133700130520     C                              D@TRM(D#CNE) <> 99999999)
133800130520     C                   EXSR      $CHKHEM
133900130520     C                   ENDIF
134000130520     C                   LEAVESR
134100130520     C                   ENDIF
134200160616
134300130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
134400130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
134500130520     C                              M@TRM(M#CNE) <> 99999999)
134600130520     C                   EXSR      $CHKHEM
134700130520     C                   ENDIF
134800130520     C                   LEAVESR
134900130520     C                   ENDIF
135000160616
135100130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
135200130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
135300130520     C                              L@TRM(L#CNE) <> 99999999 OR
135400130520     C                              M@TRM(M#CNE) <> 99999999)
135500130520     C                   EXSR      $CHKHEM
135600130520     C                   ENDIF
135700130520     C                   LEAVESR
135800130520     C                   ENDIF
135900160616
136000101214     C                   ENDSR
136100160616
136200160616      *============================================================================
136300160616      * GENERATE DEPENDENT RECORD
136400160616      *============================================================================
136500160616
136600101214     C     $STEP9        BEGSR
136700160616
136800110513     C                   EVAL      WRT@TYPE = 'DEPEND'
136900160616
137000110513     C                   IF        D#CNE = 0 AND M#CNE = 0
137100110513     C                   EVAL      @STEP = 'STEP7'
137200110513     C                   LEAVESR
137300110513     C                   ENDIF
137400160616
137500101214     C                   EVAL      @SS2   = %EDITC(DEPSS#:'X')
137600101210     C                   MOVEL(P)  DLNAME        @LN
137700101210     C                   MOVEL(P)  DFNAME        @FN
137800101210     C                   EVAL      @MI    = DMI
137900160616
138000101210     C                   SELECT
138100101210     C                   WHEN      DRELCD = 'RWI'
138200101210     C                   EVAL      @REL   = '02'
138300101210     C                   WHEN      DRELCD = 'RHU'
138400101210     C                   EVAL      @REL   = '03'
138500101210     C                   WHEN      DRELCD = 'RSO'
138600101210     C                   EVAL      @REL   = '04'
138700101210     C                   WHEN      DRELCD = 'RDA'
138800101210     C                   EVAL      @REL   = '05'
138900130218     C                   WHEN      DRELCD = 'RPA'
139000130218     C                   EVAL      @REL   = '14'
139100130225     C                   OTHER
139200130225     C                   EVAL      @REL   = *BLANKS
139300101210     C                   ENDSL
139400160616
139500101210     C                   SELECT
139600101210     C                   WHEN      DSTUDN = 'Y'
139700101210     C                   EVAL      @SPEC = '1'
139800140812     C                   WHEN      DHNDCP = '3'
139900101210     C                   EVAL      @SPEC = '3'
140000130225     C                   OTHER
140100130225     C                   EVAL      @SPEC = *BLANKS
140200101210     C                   ENDSL
140300160616
140400101210     C                   EVAL      @SEX   = DSEX
140500101210     C                   EVAL      @DOB   = %EDITC(DBIRTH:'X')
140600160616
140700101210     C                   IF        DCOB = 'Y'
140800101210     C                   EVAL      @COB   = 'Y'
140900101210     C                   EVAL      @COBC  = 'OT'
141000101210     C                   EVAL      @COBN  = DCOBPN
141100130225     C                   ELSE
141200130225     C                   EVAL      @COB   = *BLANKS
141300130225     C                   EVAL      @COBC  = *BLANKS
141400130225     C                   EVAL      @COBN = *BLANKS
141500101210     C                   ENDIF
141600160616
141700101214     C                   IF        DADDR1 <> ADDR1
141800101210     C                   EVAL      @AD1   = %TRIM(DADDR1)
141900101210     C                   EVAL      @AD2   = %TRIM(DADDR2)
142000101210     C                   EVAL      @CTY   = %TRIM(DCITY)
142100101210     C                   EVAL      @ST    = DSTATE
142200101210     C                   MOVE      *BLANKS       @9                9
142300101214     C                   IF        DZIP = 0
142400101214     C                   EVAL      @9   = %EDITC(ZIP:'X')
142500101214     C                   ELSE
142600101210     C                   EVAL      @9   = %EDITC(DZIP:'X')
142700101214     C                   ENDIF
142800101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
142900101210     C                   EVAL      @PHN   = %EDITC(DAREA:'X') +
143000101210     C                                      %EDITC(DPHONE:'X')
143100101214     C                   ENDIF
143200160616
143300161109       // if cobra and effective date > 12/01/2016...
143400161109       if empst = 'C';
143500161109        if qedt >= effectiveDateD;
143600161109         @empst = 'AC';
143700161109        endif;
143800161109       endif;
143900161109
144000101210     C                   EXCEPT    MBRF
144100101214     C                   ADD       1             C#RECCNT
144200160616
144300101214     C                   EVAL      @STEP = 'PREPA'
144400160616
144500101210     C                   ENDSR
144600160616
144700160616      *============================================================================
144800160616
144900101214     C     $PREPA        BEGSR
145000160616
145100101214     C                   IF        M#CNE = 0
145200101214     C                   EVAL      @STEP = 'PREPB'
145300101214     C                   LEAVESR
145400101214     C                   ENDIF
145500160616
145600101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
145700160615     C     KL#TSAP       CHAIN     AEF04
145800160615     C                   IF        NOT %FOUND(AET004WF)
145900120803     C                   LEAVESR
146000120803     C                   ENDIF
146100160616
146200101214     C                   IF        TERM_MED = YES
146300101214     C                   EXSR      $WRTERM
146400101214     C                   ENDIF
146500160616
146600110513     C                   EVAL      @PLANIN = KF@PLN
146700160616
146800110802     C                   EXSR      $QUIKD
146900160616
147000110513     C                   EXSR      $PLANSRCH
147100160616
147200110513     C                   IF        PLN@CAT = *BLANKS
147300110513     C                   SETON                                        H2
147400110513     C                   ENDIF
147500160616
147600110513     C                   EVAL      @STEP = 'STEPA'
147700160616
147800101214     C                   ENDSR
147900160616
148000160616      *============================================================================
148100160616
148200101214     C     $STEPA        BEGSR
148300160616
148400110513     C                   IF        CPCID1 = 'MEA'
148500110513     C                   EXSR      $MEAWRT
148600110513     C                   ELSE
148700110513     C                   EXSR      $HMOWRT
148800110513     C                   ENDIF
148900160616
149000110513     C                   ADD       1             C#RECCNT
149100110513     C                   ADD       1             B#RECCNT
149200160616
149300110513     C                   EVAL      @STEP = 'PREPB'
149400160616
149500110513     C                   ENDSR
149600160616
149700160616      *============================================================================
149800160616
149900101214     C     $PREPB        BEGSR
150000160616
150100160616     C                   IF        D#CNE = 0
150200160616     C                   EVAL      @STEP = 'STEP7'
150300160616     C                   LEAVESR
150400160616     C                   ENDIF
150500160616
150600160616     C                   EVAL      KF@PLN = D@PLN(D#CNE)
150700160615     C     KL#TSAP       CHAIN     AEF04
150800160615     C                   IF        NOT %FOUND(AET004WF)
150900120803     C                   LEAVESR
151000120803     C                   ENDIF
151100160616
151200160616     C                   IF        TERM_DEN = YES
151300160616     C                   EXSR      $WRTERM
151400160616     C                   ENDIF
151500160616
151600110513     C                   EVAL      @PLANIN = KF@PLN
151700160616
151800110802     C                   EXSR      $QUIKD
151900160616
152000110513     C                   EXSR      $PLANSRCH
152100160616
152200110513     C                   IF        PLN@CAT = *BLANKS
152300110513     C                   SETON                                        H2
152400110513     C                   ENDIF
152500160616
152600101214     C                   EVAL      @STEP = 'STEPB'
152700160616
152800101214     C                   ENDSR
152900160616
153000160616      *============================================================================
153100160616
153200160616     C     $STEPB        BEGSR
153300160616
153400110513     C                   EXSR      $DENWRT
153500160616
153600160616     C                   ADD       1             C#RECCNT
153700160616     C                   ADD       1             B#RECCNT
153800160616
153900160616     C                   EVAL      @STEP = 'STEP7'
154000160616
154100160616     C                   ENDSR
154200160616
154300160616      *============================================================================
154400160616
154500110512     C     *INZSR        BEGSR
154600160616
154700160314     C     *entry        plist
154800160314     C                   parm                    CARR#CTL
154900160314     C                   parm                    grouper
155000160314
155100110512     C     KL#ACCTL      KLIST
155200160919     C                   KFLD                    CARR#CTL
155300110512     C                   KFLD                    KF@TRS
155400110512     C                   KFLD                    KF@SUB
155500110512     C                   KFLD                    KF@ACC
155600160616
155700140313     C     KL#SQPCD      KLIST
155800140313     C                   KFLD                    KF@SSN
155900140313     C                   KFLD                    KF@SEQ
156000140313     C                   KFLD                    KF@SPCD
156100160616
156200120803     C     KL#TSAP       KLIST
156300120803     C                   KFLD                    KF@TRS
156400120803     C                   KFLD                    KF@SUB
156500120803     C                   KFLD                    KF@ACC
156600120803     C                   KFLD                    KF@PLN
156700160616
156800110512     C     KL#TSA        KLIST
156900110512     C                   KFLD                    KF@TRS
157000110512     C                   KFLD                    KF@SUB
157100110512     C                   KFLD                    KF@ACC
157200160616
157300110512     C     KL#MPLN       KLIST
157400110512     C                   KFLD                    KF@SSN
157500110512     C                   KFLD                    KF@SEQ
157600110512     C                   KFLD                    KF@TRS
157700110512     C                   KFLD                    KF@SUB
157800110512     C                   KFLD                    KF@ACC
157900160616
158000110512     C     KL#CPLN       KLIST
158100160919     C                   KFLD                    CARR#CTL
158200110512     C                   KFLD                    KF@TRS
158300110512     C                   KFLD                    KF@SUB
158400110512     C                   KFLD                    KF@ACC
158500110512     C                   KFLD                    KF@CCTR
158600110512     C                   KFLD                    KF@PLN
158700160616
158800110512     C     KL#DCV        KLIST
158900110512     C                   KFLD                    KF@SSN
159000110512     C                   KFLD                    KF@SEQ
159100160616
159200110512     C     KL#MTR        KLIST
159300110512     C                   KFLD                    KF@SSN
159400110512     C                   KFLD                    KF@SEQ
159500110512     C                   KFLD                    KF#TRM
159600110512     C                   KFLD                    KF@PLN
159700110512     C                   KFLD                    KF@ENR
159800110512     C                   KFLD                    KF@TRS
159900110512     C                   KFLD                    KF@SUB
160000110512     C                   KFLD                    KF@ACC
160100160616
160200110512     C     KL#PCP        KLIST
160300110512     C                   KFLD                    KF@SSN
160400110512     C                   KFLD                    KF@SEQ
160500160616
160600110512     C                   EVAL      #ISO = %DATE
160700110512     C                   MOVE      #ISO          #TODAY            8 0
160800110512     C                   EVAL      #IST = %TIME
160900110512     C                   MOVE      #ISO          #XSX
161000110512     C                   MOVE      #XSX          @DATE
161100110512     C                   MOVE      #IST          #XST
161200110512     C                   MOVE      #XST          @TIME
161300160616
161400110512     C                   ENDSR
161500160616
161600160616      *============================================================================
161700160616      * PLANS LOADED BY ACCOUNT
161800160616      *============================================================================
161900160616
162000110513     C     $PLANLOAD     BEGSR
162100160616
162200110513     C                   EVAL      PP# = 0
162300140313     C                   DO        80
162400110513     C                   ADD       1             PP#
162500110513     C     PP#           OCCUR     CARPLN@
162600110513     C                   CLEAR                   CARPLN@
162700110513     C                   ENDDO
162800110513     C                   EVAL      PC# = 0
162900110513     C                   EVAL      PP# = 0
163000160616
163100110513     C     KL#ACCTL      SETLL     CARPLNR
163200110513     C                   DOU       %EOF(CARPLNP)
163300110513     C     KL#ACCTL      READE     CARPLNR
163400110520     C                   IF        NOT %EOF(CARPLNP)
163500160616
163600110513     C                   ADD       1             PC#
163700110513     C     PC#           OCCUR     CARPLN@
163800110513     C                   EVAL      CARPLN@ = DS@CARPLN
163900160616
164000110513     C                   ENDIF
164100110513     C                   ENDDO
164200160616
164300110513     C                   ENDSR
164400160616
164500160616      *============================================================================
164600160616
164700110513     C     $CLRSTG       BEGSR
164800160616
164900110513     C                   EVAL      #CANCEL = 0
165000160616
165100130315     C                   EVAL      L#CNE = 0
165200130315     C                   CLEAR                   L@PLN
165300130315     C                   CLEAR                   L@ENR
165400130315     C                   CLEAR                   L@FRM
165500130315     C                   CLEAR                   L@TRM
165600160616
165700110513     C                   EVAL      D#CNE = 0
165800110513     C                   CLEAR                   D@PLN
165900110513     C                   CLEAR                   D@ENR
166000110513     C                   CLEAR                   D@FRM
166100110513     C                   CLEAR                   D@TRM
166200110513     C                   EVAL      M#CNE = 0
166300110513     C                   CLEAR                   M@PLN
166400110513     C                   CLEAR                   M@ENR
166500110513     C                   CLEAR                   M@FRM
166600110513     C                   CLEAR                   M@TRM
166700160616
166800110513     C                   EXSR      $CLRDMG
166900160616
167000110513     C                   ENDSR
167100160616
167200160616      *============================================================================
167300160616
167400110513     C     $CLRDMG       BEGSR
167500160616
167600110513     C                   EVAL      @SS1   = *BLANKS
167700110513     C                   EVAL      @SS2   = *BLANKS
167800110513     C                   MOVE      *BLANKS       @LN
167900110513     C                   MOVEL     *BLANKS       @FN
168000110513     C                   EVAL      @MI    = *BLANKS
168100110513     C                   EVAL      @REL   = *BLANKS
168200110513     C                   EVAL      @SEX   = *BLANKS
168300110513     C                   EVAL      @DOB   = *BLANKS
168400110513     C                   EVAL      @SPEC  = *BLANKS
168500110513     C                   EVAL      @COB   = *BLANKS
168600110513     C                   EVAL      @COBC  = *BLANKS
168700110513     C                   EVAL      @COBN  = *BLANKS
168800110513     C                   EVAL      @AD1   = *BLANKS
168900110513     C                   EVAL      @AD2   = *BLANKS
169000110513     C                   EVAL      @CTY   = *BLANKS
169100110513     C                   EVAL      @ST    = *BLANKS
169200110513     C                   EVAL      @ZP5   = *BLANKS
169300110513     C                   EVAL      @PHN   = *BLANKS
169400110513     C                   EVAL      @EMPST = *BLANKS
169500110513     C                   EVAL      @HIRE  = *BLANKS
169600160616
169700110513     C                   ENDSR
169800160616
169900160616      *============================================================================
170000160616
170100110513     C     $CHKHEM       BEGSR
170200160616
170300160616     C                   IF        L#CNE > 0 AND L@TRM(L#CNE) <> 99999999
170400160616     C                   EXSR      $CHKLIF
170500160616     C                   ENDIF
170600160616
170700160616     C                   IF        D#CNE > 0 AND D@TRM(D#CNE) <> 99999999
170800160616     C                   EXSR      $CHKDEN
170900160616     C                   ENDIF
171000160616
171100110513     C                   IF        M#CNE > 0 AND M@TRM(M#CNE) <> 99999999
171200110513     C                   EXSR      $CHKMED
171300110513     C                   ENDIF
171400160616
171500110513     C                   ENDSR
171600160616
171700160616      *============================================================================
171800160616
171900160616     C     $CHKLIF       BEGSR
172000160616
172100160616     C                   EVAL      TERM_LIF = YES
172200160616     C                   EVAL      KF#TRM = L@TRM(L#CNE)
172300160616     C                   EVAL      KF@PLN = L@PLN(L#CNE)
172400160616     C                   EVAL      KF@ENR = L@ENR(L#CNE)
172500160616
172600170308     C     KL#MTR        CHAIN     AET1101F
172700170308     C                   IF        %FOUND(AET1101WF)
172800160616     C                   EVAL      L#CNE = 0
172900160616     C                   EVAL      TERM_LIF = NO
173000160616     C                   ENDIF
173100160616
173200160616     C                   ENDSR
173300160616
173400160616      *============================================================================
173500160616
173600160616     C     $CHKDEN       BEGSR
173700160616
173800160616     C                   EVAL      TERM_DEN = YES
173900160616     C                   EVAL      KF#TRM = D@TRM(D#CNE)
174000160616     C                   EVAL      KF@PLN = D@PLN(D#CNE)
174100160616     C                   EVAL      KF@ENR = D@ENR(D#CNE)
174200160616
174300170308     C     KL#MTR        CHAIN     AET1101F
174400170308     C                   IF        %FOUND(AET1101WF)
174500160616     C                   EVAL      D#CNE = 0
174600160616     C                   EVAL      TERM_DEN = NO
174700160616     C                   ENDIF
174800160616
174900160616     C                   ENDSR
175000160616
175100160616      *============================================================================
175200160616
175300110513     C     $CHKMED       BEGSR
175400160616
175500110513     C                   EVAL      TERM_MED = YES
175600110513     C                   EVAL      KF#TRM = M@TRM(M#CNE)
175700110513     C                   EVAL      KF@PLN = M@PLN(M#CNE)
175800110513     C                   EVAL      KF@ENR = M@ENR(M#CNE)
175900160616
176000170308     C     KL#MTR        CHAIN     AET1101F
176100170308     C                   IF        %FOUND(AET1101WF)
176200110513     C                   EVAL      TERM_MED = NO
176300110513     C                   EVAL      M#CNE = 0
176400110513     C                   ENDIF
176500160616
176600110513     C                   ENDSR
176700160616
176800160616      *============================================================================
176900160616
177000110513     C     $PLANSRCH     BEGSR
177100160616
177200130315     C                   MOVE      *BLANKS       PLN@CAT           5
177300110513     C                   EVAL      PP# = 0
177400110513     C                   CLEAR                   DS@CARPLN
177500160616
177600110513     C                   DO        PC#
177700160616
177800110513     C                   ADD       1             PP#
177900110513     C     PP#           OCCUR     CARPLN@
178000160616
178100110513     C                   IF        XPPLAN = @PLANIN AND
178200110513     C                             XPCCTR = @CCTRIN
178300110513     C                   EVAL      DS@CARPLN = CARPLN@
178400110513     C                   LEAVE
178500110513     C                   ENDIF
178600160616
178700110513     C                   ENDDO
178800160616
178900110513     C                   IF        CPPLAN = *BLANKS
179000110513     C                   LEAVESR
179100110513     C                   ENDIF
179200160616
179300110513     C                   SELECT
179400110520     C                   WHEN      CPCID1 = 'MEA' OR
179500110520     C                             CPCID1 = 'HMO'
179600110520     C                   EVAL      PLN@CAT = 'MED'
179700130409     C                   WHEN      CPCID1 = 'LIFE'
179800130409     C                   EVAL      PLN@CAT = 'LIFE'
179900110520     C                   WHEN      CPCID1 = 'DEN'
180000110520     C                   EVAL      PLN@CAT = 'DEN'
180100110513     C                   ENDSL
180200160616
180300110513     C                   ENDSR
180400160616
180500160616      *============================================================================
180600160616
180700110513     C     $ENROLL       BEGSR
180800160616
180900110513     C                   EVAL      ENR@OUT = *BLANKS
181000110513     C                   SELECT
181100110513     C                   WHEN      ENR@IN = 'TIN' OR ENR@IN = 'TMI'
181200110513     C                   EVAL      ENR@OUT = 'S'
181300110513     C                   WHEN      ENR@IN = 'THW'
181400110513     C                   EVAL      ENR@OUT = 'C'
181500110513     C                   WHEN      ENR@IN = 'TPC'
181600110513     C                   EVAL      ENR@OUT = 'P'
181700110513     C                   WHEN      ENR@IN = 'TP2'
181800110513     C                   EVAL      ENR@OUT = 'Q'
181900110513     C                   WHEN      ENR@IN = 'TFA'
182000110513     C                   EVAL      ENR@OUT = 'F'
182100110513     C                   ENDSL
182200160616
182300110513     C                   ENDSR
182400160616
182500160616      *============================================================================
182600160616
182700110513     C     $WRTERM       BEGSR
182800160616
182900170308     C                   CLEAR                   AET1101F
183000110513     C                   EVAL      NTSSNO         = KF@SSN
183100110513     C                   EVAL      NTDEPNO        = KF@SEQ
183200110513     C                   EVAL      NTTERMDT       = KF#TRM
183300110513     C                   EVAL      NTPLAN         = KF@PLN
183400110513     C                   EVAL      NTCOVTP        = KF@ENR
183500110513     C                   EVAL      NTTRST         = KF@TRS
183600110513     C                   EVAL      NTSUB#         = KF@SUB
183700110513     C                   EVAL      NTACCT         = KF@ACC
183800110513     C                   EVAL      NTTRANSDT      = #TODAY
183900170308     C                   WRITE     AET1101F
184000160616
184100110513     C                   ENDSR
184200160616
184300160616      *============================================================================
184400160616
184500110513     C     $HMOWRT       BEGSR
184600160616
184700110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
184800110513     C                   EVAL      X@ELR = CPCID2                               FILE NUMBER
184900110513     C                   EVAL      M@CC = CACID2                                COMPANY CODE
185000110513     C                   EVAL      M@CLASS = CPCID3                             CLASS CODE
185100110513     C                   EVAL      M@PLAN = CPCID4                              PLAN NUMBER
185200160616
185300110513     C                   EVAL      #XSX = M@FRM(M#CNE)
185400110725     C                   IF        WRT@TYPE = 'DEPEND' AND
185500110725     C                             #XSX < M@MBREFF
185600110725     C                   MOVE      M@MBREFF      X@EFF
185700110725     C                   ELSE
185800110725     C                   MOVE      #XSX          X@EFF
185900110725     C                   ENDIF
186000160616
186100110513     C                   EVAL      #XSX = M@TRM(M#CNE)
186200110513     C                   IF        #XSX = 0 OR #XSX = 99999999
186300110513     C                   MOVE      *BLANKS       X@TRM
186400110513     C                   ELSE
186500110513     C                   MOVE      #XSX          X@TRM
186600110513     C                   ENDIF
186700160616
186800110513     C                   IF        WRT@TYPE = 'MEMBER'
186900110513     C                   EVAL      KF@SEQ = 0
187000110513     C                   EVAL      ENR@IN = M@ENR(M#CNE)
187100110513     C                   EXSR      $ENROLL
187200110513     C                   EVAL      X@TIER = ENR@OUT
187300110513     C                   ELSE
187400110513     C                   EVAL      X@TIER = *BLANKS
187500110513     C                   ENDIF
187600160616
187700140313     C                   EVAL      KF@SPCD = 'MED'
187800140313     C                   EVAL      M@PCP = *BLANKS
187900140313     C                   EVAL      M@NPI = *BLANKS
188000140313     C                   EVAL      M@PCPCI = *BLANKS
188100160616
188200140313     C                   EXSR      $PCP
188300160616
188400140313     C                   IF        DOCTOR <> *BLANKS
188500140313     C                   EVAL      M@PCP = DOCTOR
188600140313     C                   EVAL      M@NPI = 'Y'
188700140313     C                   EVAL      M@PCPCI = '0'
188800140313     C                   ENDIF
188900160616
189000110513     C                   EXCEPT    HMOF
189100160616
189200110513     C                   ENDSR
189300160616
189400160616      *============================================================================
189500160616
189600110513     C     $MEAWRT       BEGSR
189700160616
189800110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
189900110513     C                   EVAL      X@ELR = CPCID2                               ELR
190000140313     C                   EVAL      E@SFX = CPCID3                               SUFFIX
190100140313     C                   EVAL      E@ACCT = CPCID4                              ACCOUNT
190200140313     C                   EVAL      E@PLAN = CPCID5                              PLAN
190300140313     C                   EVAL      E@CLM = CPCID6                               CLAIM OFFICE
190400160616
190500110513     C                   EVAL      #XSX = M@FRM(M#CNE)
190600110725     C                   IF        WRT@TYPE = 'DEPEND' AND
190700110725     C                             #XSX < M@MBREFF
190800110725     C                   MOVE      M@MBREFF      X@EFF
190900110725     C                   ELSE
191000110725     C                   MOVE      #XSX          X@EFF
191100110725     C                   ENDIF
191200160616
191300160616     C                   EVAL      #XSX = M@TRM(M#CNE)
191400110513     C                   IF        #XSX = 0 OR #XSX = 99999999
191500110513     C                   MOVE      *BLANKS       X@TRM
191600110513     C                   ELSE
191700110513     C                   MOVE      #XSX          X@TRM
191800110513     C                   ENDIF
191900160616
192000140313     C                   MOVE      *BLANKS       E@CBREXP
192100140313     C                   MOVE      *BLANKS       E@CBREVT
192200140313     C                   MOVE      *BLANKS       E@CBRLEN
192300140313     C                   IF        WRT@TYPE = 'MEMBER'
192400140425     C                   IF        EMPST = 'C' AND
192500140425     C                             CEXPDT > 0
192600140313     C                   MOVE      CEXPDT        E@CBREXP
192700140313     C                   MOVE      QEDT          E@CBREVT
192800140313     C                   MOVE      CEXPDT        #MINUEND
192900140313     C                   MOVE      QEDT          #SUBTRAEND
193000140313     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
193100140313     C                   Z-ADD     #DIFFRNC      #2S0
193200140313     C                   MOVE      #2S0          E@CBRLEN
193300140313     C                   ENDIF
193400140313     C                   ENDIF
193500160616
193600140313     C                   EVAL      *IN80 = *OFF
193700140313     C                   EVAL      KF@SPCD = 'MED'
193800140313     C                   EVAL      E@PCP = *BLANKS
193900140313     C                   EXSR      $PCP
194000140313     C                   IF        DOCTOR <> *BLANKS
194100140313     C                   EVAL      E@PCP = DOCTOR
194200140313     C                   EVAL      *IN80 = *ON
194300140313     C                   ENDIF
194400160616
194500161109       // if cobra and effective date > 12/01/2016...
194600161109       if empst = 'C';
194700161109        if e@cbrevt >= effectiveDate;
194800161109         e@cbrexp = ' ';
194900161109          e@cbrevt = ' ';
195000161109         e@cbrlen = ' ';
195100161109        endif;
195200161130       endif;
195300161109
195400140313     C                   EXCEPT    MEAF
195500160616
195600110513     C                   ENDSR
195700160616
195800160616      *============================================================================
195900160616
196000140313     C     $PCP          BEGSR
196100160616
196200140313     C                   MOVE      *BLANKS       DOCTOR            7
196300140313     C     KL#SQPCD      CHAIN     PCPR
196400140313     C                   IF        NOT %FOUND(PCPL1)
196500140313     C                   LEAVESR
196600140313     C                   ENDIF
196700140313     C     KL#SQPCD      SETLL     PCPR
196800140313     C                   DOU       %EOF(PCPL1)
196900140313     C     KL#SQPCD      READE     PCPR
197000140313     C                   IF        NOT %EOF(PCPL1) AND PCCAN = 0
197100140313     C                   MOVEL(P)  PCID#         DOCTOR
197200140313     C                   LEAVESR
197300140313     C                   ENDIF
197400140313     C                   ENDDO
197500160616
197600140313     C                   ENDSR
197700160616
197800160616      *============================================================================
197900160616
198000110513     C     $CLRDCV       BEGSR
198100160616
198200110513     C                   MOVE      *BLANKS       @LN
198300110513     C                   MOVEL     *BLANKS       @FN
198400110513     C                   EVAL      @SS2   = *BLANKS
198500110513     C                   EVAL      @MI    = *BLANKS
198600110513     C                   EVAL      @REL   = *BLANKS
198700110513     C                   EVAL      @SEX   = *BLANKS
198800110513     C                   EVAL      @DOB   = *BLANKS
198900110513     C                   EVAL      @SPEC  = *BLANKS
199000110513     C                   EVAL      @COB   = *BLANKS
199100110513     C                   EVAL      @COBC  = *BLANKS
199200110513     C                   EVAL      @COBN  = *BLANKS
199300160616
199400110513     C                   EVAL      #CANCEL = 0
199500110513     C                   EVAL      D#CNE = 0
199600110513     C                   CLEAR                   D@PLN
199700110513     C                   CLEAR                   D@ENR
199800110513     C                   CLEAR                   D@FRM
199900110513     C                   CLEAR                   D@TRM
200000110513     C                   EVAL      M#CNE = 0
200100110513     C                   CLEAR                   M@PLN
200200110513     C                   CLEAR                   M@ENR
200300110513     C                   CLEAR                   M@FRM
200400110513     C                   CLEAR                   M@TRM
200500160616
200600110513     C                   ENDSR
200700160616
200800160616      *============================================================================
200900160616
201000110513     C     $DENWRT       BEGSR
201100160616
201200160616     C                   EVAL      X@LAY = CPCID1                               LAYOUT
201300160616     C                   EVAL      X@ELR = CPCID2                               ELR
201400160616     C                   EVAL      D@SFX = CPCID3                               SUFFIX
201500160616     C                   EVAL      D@ACCT = CPCID4                              ACCOUNT
201600160616     C                   EVAL      D@PLAN = CPCID5                              PLAN
201700160616     C                   EVAL      D@CLM = CPCID6                               CLAIM OFFICE
201800110524     C                   EVAL      DNTLATE = '0'
201900160616
202000160616     C                   EVAL      #XSX = D@FRM(D#CNE)
202100110725     C                   IF        WRT@TYPE = 'DEPEND' AND
202200110725     C                             #XSX < D@MBREFF
202300110725     C                   MOVE      D@MBREFF      X@EFF
202400110725     C                   ELSE
202500110725     C                   MOVE      #XSX          X@EFF
202600110725     C                   ENDIF
202700160616
202800160616     C                   EVAL      #XSX = D@TRM(D#CNE)
202900160616     C                   IF        #XSX = 0 OR #XSX = 99999999
203000160616     C                   MOVE      *BLANKS       X@TRM
203100160616     C                   ELSE
203200160616     C                   MOVE      #XSX          X@TRM
203300160616     C                   ENDIF
203400160616
203500130211     C                   MOVE      *BLANKS       D@CBREXP
203600130211     C                   MOVE      *BLANKS       D@CBREVT
203700130211     C                   MOVE      *BLANKS       D@CBRLEN
203800110513     C                   IF        WRT@TYPE = 'MEMBER'
203900160616     C                   IF        EMPST = 'C' AND CEXPDT <> 0
204000160616     C                   MOVE      CEXPDT        D@CBREXP
204100160616     C                   MOVE      QEDT          D@CBREVT
204200160616     C                   MOVE      CEXPDT        #MINUEND
204300160616     C                   MOVE      QEDT          #SUBTRAEND
204400160616     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
204500160616     C                   Z-ADD     #DIFFRNC      #2S0
204600160616     C                   MOVE      #2S0          D@CBRLEN
204700160616     C                   ENDIF
204800160616     C                   ENDIF
204900160616
205000160616     C                   MOVE      '0'           D@OOAI
205100160616
205200140313     C                   EVAL      KF@SPCD = 'DEN'
205300140313     C                   EVAL      D@PCD = *BLANKS
205400140313     C                   EVAL      *IN81 = *OFF
205500140313     C                   MOVE      *BLANKS       DOCTOR
205600160616
205700140313     C                   EXSR      $PCP
205800160616
205900140313     C                   IF        DOCTOR <> *BLANKS
206000140313     C                   EVAL      D@PCD = DOCTOR
206100140313     C                   EVAL      *IN81 = *ON
206200140313     C                   ENDIF
206300160616
206400120123     C     *LIKE         DEFINE    H@C#          BUC#
206500120123     C                   EVAL      BUC# = H@C#
206600160616
206700120327     C                   SELECT
206800131126     C                   WHEN      KF@TRS = 591 AND KF@SUB = 009 AND            WILMOT MODULAR
206900131126     C                             KF@ACC = 0202                                 STRUCTURES
207000131227     C                   EVAL      H@C# = '0638156'
207100140702     C                   WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            REDLAND
207200140702     C                             KF@ACC = 0475                                 BAPTISTS
207300140702     C                   EVAL      H@C# = '0725572'
207400120327     C                   WHEN      KF@TRS = 825 AND KF@SUB = 001 AND            CREATIVE
207500120123     C                             KF@ACC = 0014                                 LOGISTICS
207600120123     C                   EVAL      H@C# = '0133860'
207700130905     C                   WHEN      KF@TRS = 905 AND KF@SUB = 001 AND            CCL USA
207800130905     C                             KF@ACC = 0092
207900130905     C                   EVAL      H@C# = '0638423'
208000140423     C                   WHEN      KF@TRS = 003 AND KF@SUB = 001 AND            FRAME RITE
208100140423     C                             KF@ACC = 0104
208200140423     C                   EVAL      H@C# = '0306511'
208300130520     C                   WHEN      KF@TRS = 900 AND KF@SUB = 003 AND            PERFECT
208400130520     C                             KF@ACC = 0045                                 SETTINGS
208500130520     C                   EVAL      H@C# = '0474109'
208600121024     C                   WHEN      KF@TRS = 591 AND KF@SUB = 011 AND            MCCALLISTER
208700121024     C                             KF@ACC = 0446                                 ARCHITECT
208800121024     C                   EVAL      H@C# = '0565330'
208900130716     C                   WHEN      KF@TRS = 591 AND KF@SUB = 005 AND            JD CLARK PROF
209000130716     C                             KF@ACC = 0451                                 SERVICES
209100130716     C                   EVAL      H@C# = '0519890'
209200130627     C                   WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            DYSON CONSTRUCTION
209300130627     C                             KF@ACC = 0459                                 COMPANY
209400130627     C                   EVAL      H@C# = '0788122'
209500130903     C                   WHEN      KF@TRS = 591 AND KF@SUB = 004 AND            STROUSE CORP
209600130903     C                             KF@ACC = 0482
209700130903     C                   EVAL      H@C# = '0837451'
209800130712     C                   WHEN      KF@TRS = 900 AND KF@SUB = 007 AND            CAPLAN BROTHERS
209900130712     C                             KF@ACC = 0075
210000130712     C                   EVAL      H@C# = '0837533'
210100120806     C                   WHEN      KF@TRS = 900 AND KF@SUB = 101 AND            INTEGRA HEALTH
210200130110     C                             KF@ACC = 0042 AND
210300130110     C                             (STATE = 'TN' OR STATE = 'FL' OR
210400130718     C                              STATE = 'OH' OR STATE = 'MA') AND
210500120806     C                             (@PLANIN = 'DAAD' OR @PLANIN = 'BAAD')
210600120806     C                   EVAL      H@C# = '0503428'
210700160616     C                   ENDSL
210800160616
210900161109       // if cobra and effective date > 12/01/2016...
211000161109       if empst = 'C';
211100161109        if d@cbrevt >= effectiveDate;
211200161109         d@cbrexp = ' ';
211300161109          d@cbrevt = ' ';
211400161109         d@cbrlen = ' ';
211500161109        endif;
211600161130       endif;
211700161109
211800160616     C                   EXCEPT    DENF
211900151217     c                   EVAL      H@C# = BUC#
212000160616
212100160616     C                   ENDSR
212200160616
212300160616      *============================================================================
212400160616
212500170308     OAET1100WF EADD         HDRF
212600101203     O                                            6 'HEADER'
212700160810     O                                            8 'P'
212800101206     O                       H@SI                28
212900101203     O                                           29 '0'
213000101203     O                       C1                  43
213100101203     O                       D1                  51
213200101203     O                       T1                  57
213300101206     O                                          131 'CONSOLIDATED ELIGIBILITY'
213400110502     O                       H@RI               167
213500101206     O                       H@CC               169
213600101228     O                       H@GN               176
213700101206     O                       H@CN               191
213800101206     O                       H@C#               198
213900101203     O                       D2                 206
214000110825     O                                          216 'MC'
214100101223     O                                          231 '*'
214200160616
214300160616      *============================================================================
214400170308     OAET1100WF EADD         MBRF
214500101203     O                                            6 'MEMBER'
214600101203     O                       @SS1                16
214700101203     O                       @SS2                25
214800101203     O                       @FN                 75
214900101203     O                       @MI                 76
215000101203     O                       @LN                 96
215100101203     O                       @REL               101
215200101203     O                       @SEX               103
215300101203     O                       @DOB               111
215400101203     O                       @SPEC              112
215500101203     O                                          113 '0'
215600101203     O                       @COB               123
215700101203     O                       @COBC              125
215800101203     O                       @COBN              145
215900101203     O                       @AD1               175
216000101203     O                       @AD2               205
216100101203     O                       @CTY               315
216200101203     O                       @ST                317
216300101203     O                       @ZP5               322
216400101203     O                       @PHN               349
216500141211     O               87                         576 '21207'
216600140626     O               88                         576 '21740'
216700141120     O               89                         576 '20171'
216800101203     O                       @EMPST             665
216900101203     O                       @HIRE              673
217000101223     O                                         1231 '*'
217100160616
217200160616      *============================================================================
217300170308     OAET1100WF EADD         HMOF
217400101213     O                                            7 'BENEFIT'
217500101213     O                       X@LAY               10
217600101214     O                       X@ELR               24
217700101213     O                       M@CC                26
217800101213     O                       H@GN                38
217900101213     O                       M@CLASS             44
218000101213     O                       M@PLAN              50
218100101213     O                       X@EFF               58
218200110929     O                       X@TRM               66
218300101213     O                       X@TIER              69
218400101213     O                       M@PCP              160
218500101213     O                       M@NPI              161
218600101213     O                       M@PCPCI            186
218700101223     O                                          323 '*'
218800160616
218900160616      *============================================================================
219000170308     OAET1100WF EADD         MEAF
219100140313     O                                            7 'BENEFIT'
219200140313     O                                           10 'MEA'
219300140313     O                       X@ELR               24
219400140313     O                       H@C#                31
219500140313     O                       E@SFX               34
219600140313     O                       E@ACCT              44
219700140313     O                       E@PLAN              50
219800140313     O                       X@EFF               58
219900140313     O                       X@TRM               66
220000140313     O                       E@CLM               71
220100140313     *** PCP BGN
220200140313     O                       E@PCP              127
220300140313     O               80                         161 'N'
220400140313     O               80                         186 '0'
220500140313     *** PCP END
220600140313     O                                          389 '0'
220700140313     *** COBRA BGN
220800140313     O                       E@CBREXP           466
220900140313     O                       E@CBREVT           516
221000140313     O                       E@CBRLEN           560
221100140313     *** COBRA END
221200140313     O                                          678 '*'
221300160616
221400160616      *============================================================================
221500170308     OAET1100WF EADD         DENF
221600101213     O                                            7 'BENEFIT'
221700101213     O                       X@LAY               10
221800101214     O                       X@ELR               24
221900101214     O                       H@C#                31
222000101213     O                       D@SFX               34
222100101213     O                       D@ACCT              44
222200101213     O                       D@PLAN              50
222300101213     O                       X@EFF               58
222400110929     O                       X@TRM               66
222500101213     O                       D@CLM               71
222600140313     *** PCD BGN
222700140313     O                       D@PCD              200
222800140313     O               81                         236 '0'
222900140313     *** PCD END
223000140313     O                                          389 '0'
223100140313     *** COBRA BGN
223200140313     O                       D@CBREXP           466
223300140313     O                       D@CBREVT           516
223400140313     O                       D@CBRLEN           560
223500140313     *** COBRA END
223600140313     O                       D@OOAI             609
223700140313     O                                          678 '*'
223800160616
223900160616      *============================================================================
224000170308     OAET1100WF EADD         LIFF
224100130315     O                                            7 'BENEFIT'
224200130412     O                                           11 'LIFE'
224300130315     O                       X@ELR               24
224400130319     O                       H@C#3               31
224500130315     O                       L@SFX               34
224600130315     O                       L@ACCT              44
224700130315     O                       L@PLAN              50
224800130315     O                       X@EFF               58
224900130315     O                       X@TRM               66
225000130315     O                       L@CLM               71
225100130315     O                       L@CBREXP           466
225200130315     O                       L@CBREVT           516
225300130315     O                       L@CBRLEN           560
225400130315     O                       L@SALARY           658
225500130315     O                                          659 '1'
225600130315     O                                          678 '*'
225700160616
225800160616      *============================================================================
225900170308     OAET1100WF EADD         TRLF
226000101203     O                                            7 'TRAILER'
226100101203     O                       @TREC               17
226200101203     O                       D1                  25
226300101203     O                       T1                  31
226400101203     O                       @BREC               41
226500101223     O                                           69 '*'
226600160616
226700160616      *============================================================================
