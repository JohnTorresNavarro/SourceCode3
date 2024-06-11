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
001200160616      *
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
002700170120     FAET1080WF O  A F 1231        DISK
002800101206     ** FLAT FILE
002900151217
003000170120     FAET1081WF IF A E           K DISK
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
059000170120     C                   EVAL      @CCTRIN = 'ACT'
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
114900170303
115000170303     c                   if        x@eff < '20170101'
115100170303     c                   eval      x@eff = '20170101'
115200170303     c                   endif
115300160616
115400160616     C                   EVAL      #XSX = L@TRM(L#CNE)
115500160616     C                   IF        #XSX = 0 OR #XSX = 99999999
115600160616     C                   MOVE      *BLANKS       X@TRM
115700160616     C                   ELSE
115800160616     C                   MOVE      #XSX          X@TRM
115900160616     C                   ENDIF
116000160616
116100140313     C                   MOVE      *BLANKS       L@CBREXP
116200140313     C                   MOVE      *BLANKS       L@CBREVT
116300140313     C                   MOVE      *BLANKS       L@CBRLEN
116400160616
116500160616     C                   IF        EMPST = 'C' AND
116600130923     C                             CEXPDT > 0
116700160616     C                   MOVE      CEXPDT        L@CBREXP
116800160616     C                   MOVE      QEDT          L@CBREVT
116900160616     C                   MOVE      CEXPDT        #MINUEND
117000160616     C                   MOVE      QEDT          #SUBTRAEND
117100160616     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
117200160616     C                   Z-ADD     #DIFFRNC      #2S0
117300160616     C                   MOVE      #2S0          L@CBRLEN
117400160616     C                   ENDIF
117500160616
117600130315     C                   EVAL      L@SALARY = %EDITC(SALARY:'4')
117700160616
117800160616     C                   EXCEPT    LIFF
117900160616
118000160616     C                   ENDSR
118100160616
118200160616      *============================================================================
118300160616
118400101214     C     $PREP7        BEGSR
118500160616
118600101214     C     KF@SSN        CHAIN     DEPENR
118700101214     C                   IF        NOT %FOUND(DEPNDC)
118800101214     C                   EVAL      @STEP = 'STEP2'
118900101214     C                   LEAVESR
119000101214     C                   ENDIF
119100160616
119200101214     C     KF@SSN        SETLL     DEPENR
119300160616
119400101214     C                   EVAL      @STEP = 'STEP7'
119500160616
119600101214     C                   ENDSR
119700160616
119800160616      *============================================================================
119900160616
120000101214     C     $STEP7        BEGSR
120100160616
120200101214     C     KF@SSN        READE     DEPENR
120300160616
120400101214     C                   IF        %EOF(DEPNDC)
120500101214     C                   EVAL      @STEP = 'STEP2'
120600101214     C                   LEAVESR
120700101214     C                   ENDIF
120800160616
120900101214     C                   EVAL      KF@SEQ = DPSEQ#
121000120803     C                   EVAL      WRT@TYPE = 'DEPEND'
121100160616
121200101214     C     KL#DCV        CHAIN     DCOVR
121300101214     C                   IF        NOT %FOUND(DCOVA)
121400101214     C                   LEAVESR
121500101214     C                   ENDIF
121600160616
121700101214     C                   EXSR      $CLRDCV
121800101214     C     KL#DCV        SETLL     DCOVR
121900160616
122000101214     C                   EVAL      @STEP = 'STEP8'
122100160616
122200101214     C                   ENDSR
122300160616
122400160616      *============================================================================
122500160616
122600101214     C     $STEP8        BEGSR
122700160616
122800101214     C     KL#DCV        READE     DCOVR
122900160616
123000101214     C                   IF        %EOF(DCOVA)
123100101214     C                   EVAL      @STEP = 'PREP9'
123200101214     C                   LEAVESR
123300101214     C                   ENDIF
123400160616
123500160616     C*                  IF        DENRDT = CCANDT
123600160616     C*                  LEAVESR
123700160616     C*                  ENDIF
123800160616
123900110513     C                   EVAL      @PLANIN = DVPLAN
124000120803     C                   EVAL      KF@PLN = DVPLAN
124100160615     C     KL#TSAP       CHAIN     AEF04
124200160615     C                   IF        NOT %FOUND(AET004WF)
124300120803     C                   LEAVESR
124400120803     C                   ENDIF
124500160616
124600110802     C                   EXSR      $QUIKD
124700160616
124800110513     C                   EXSR      $PLANSRCH
124900160616
125000110513     C                   IF        PLN@CAT = *BLANKS
125100110513     C                   LEAVESR
125200110513     C                   ENDIF
125300160616
125400101214     C                   EVAL      #CANCEL = CCANDT
125500101214     C                   IF        #CANCEL = 0
125600101214     C                   EVAL      #CANCEL = 99999999
125700101214     C                   ENDIF
125800160616
125900160616      * DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL; LIFE IS MEMBER ONLY
126000160616
126100160616     C                   IF        PLN@CAT = 'DEN'
126200160616     C                   IF        D#CNE > 0
126300160616     C                   IF        D@TRM(D#CNE) = 99999999
126400130131     C                   LEAVESR
126500130131     C                   ENDIF
126600130131     C                   ENDIF
126700160616     C                   ADD       1             D#CNE
126800160616     C                   EVAL      D@PLN(D#CNE) = DVPLAN
126900160616     C                   EVAL      D@ENR(D#CNE) = *BLANKS
127000160616     C                   EVAL      D@FRM(D#CNE) = DENRDT
127100160616     C                   EVAL      D@TRM(D#CNE) = #CANCEL
127200160616     C                   ELSE
127300160616     C                   IF        M#CNE > 0
127400160616     C                   IF        M@TRM(M#CNE) = 99999999
127500130131     C                   LEAVESR
127600130131     C                   ENDIF
127700130131     C                   ENDIF
127800101214     C                   ADD       1             M#CNE
127900101214     C                   EVAL      M@PLN(M#CNE) = DVPLAN
128000101214     C                   EVAL      M@ENR(M#CNE) = *BLANKS
128100101214     C                   EVAL      M@FRM(M#CNE) = DENRDT
128200101214     C                   EVAL      M@TRM(M#CNE) = #CANCEL
128300160616     C                   ENDIF
128400160616
128500101214     C                   ENDSR
128600160616
128700160616      *============================================================================
128800160616
128900111011     C     $QUIKD        BEGSR
129000160616
129100120803     C                   EXSR      $QUIK
129200160616
129300120409     C                   ENDSR
129400160616
129500160616      *============================================================================
129600160616
129700101214     C     $PREP9        BEGSR
129800160616
129900101214     C                   IF        D#CNE = 0 AND M#CNE = 0
130000101214     C                   EVAL      @STEP = 'STEP7'
130100101214     C                   LEAVESR
130200101214     C                   ENDIF
130300160616
130400130315     C                   EVAL      L#CNE = 0
130500130315     C                   EVAL      TERM_LIF = NO
130600101214     C                   EVAL      TERM_DEN = NO
130700101214     C                   EVAL      TERM_MED = NO
130800130520     C                   EVAL      @STEP = 'STEP9'
130900160616
131000130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
131100130520     C                   IF        L@TRM(L#CNE) <> 99999999
131200130520     C                   EXSR      $CHKHEM
131300130520     C                   ENDIF
131400130520     C                   LEAVESR
131500130520     C                   ENDIF
131600160616
131700130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
131800130520     C                   IF        M@TRM(M#CNE) <> 99999999
131900130520     C                   EXSR      $CHKHEM
132000130520     C                   ENDIF
132100130520     C                   LEAVESR
132200130520     C                   ENDIF
132300160616
132400130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
132500130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
132600130520     C                              M@TRM(M#CNE) <> 99999999)
132700130520     C                   EXSR      $CHKHEM
132800130520     C                   ENDIF
132900130520     C                   LEAVESR
133000130520     C                   ENDIF
133100160616
133200130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
133300130520     C                   IF        D@TRM(D#CNE) <> 99999999
133400130520     C                   EXSR      $CHKHEM
133500130520     C                   ENDIF
133600130520     C                   LEAVESR
133700130520     C                   ENDIF
133800160616
133900130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
134000130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
134100130520     C                              D@TRM(D#CNE) <> 99999999)
134200130520     C                   EXSR      $CHKHEM
134300130520     C                   ENDIF
134400130520     C                   LEAVESR
134500130520     C                   ENDIF
134600160616
134700130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
134800130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
134900130520     C                              M@TRM(M#CNE) <> 99999999)
135000130520     C                   EXSR      $CHKHEM
135100130520     C                   ENDIF
135200130520     C                   LEAVESR
135300130520     C                   ENDIF
135400160616
135500130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
135600130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
135700130520     C                              L@TRM(L#CNE) <> 99999999 OR
135800130520     C                              M@TRM(M#CNE) <> 99999999)
135900130520     C                   EXSR      $CHKHEM
136000130520     C                   ENDIF
136100130520     C                   LEAVESR
136200130520     C                   ENDIF
136300160616
136400101214     C                   ENDSR
136500160616
136600160616      *============================================================================
136700160616      * GENERATE DEPENDENT RECORD
136800160616      *============================================================================
136900160616
137000101214     C     $STEP9        BEGSR
137100160616
137200110513     C                   EVAL      WRT@TYPE = 'DEPEND'
137300160616
137400110513     C                   IF        D#CNE = 0 AND M#CNE = 0
137500110513     C                   EVAL      @STEP = 'STEP7'
137600110513     C                   LEAVESR
137700110513     C                   ENDIF
137800160616
137900101214     C                   EVAL      @SS2   = %EDITC(DEPSS#:'X')
138000101210     C                   MOVEL(P)  DLNAME        @LN
138100101210     C                   MOVEL(P)  DFNAME        @FN
138200101210     C                   EVAL      @MI    = DMI
138300160616
138400101210     C                   SELECT
138500101210     C                   WHEN      DRELCD = 'RWI'
138600101210     C                   EVAL      @REL   = '02'
138700101210     C                   WHEN      DRELCD = 'RHU'
138800101210     C                   EVAL      @REL   = '03'
138900101210     C                   WHEN      DRELCD = 'RSO'
139000101210     C                   EVAL      @REL   = '04'
139100101210     C                   WHEN      DRELCD = 'RDA'
139200101210     C                   EVAL      @REL   = '05'
139300130218     C                   WHEN      DRELCD = 'RPA'
139400130218     C                   EVAL      @REL   = '14'
139500130225     C                   OTHER
139600130225     C                   EVAL      @REL   = *BLANKS
139700101210     C                   ENDSL
139800160616
139900101210     C                   SELECT
140000101210     C                   WHEN      DSTUDN = 'Y'
140100101210     C                   EVAL      @SPEC = '1'
140200140812     C                   WHEN      DHNDCP = '3'
140300101210     C                   EVAL      @SPEC = '3'
140400130225     C                   OTHER
140500130225     C                   EVAL      @SPEC = *BLANKS
140600101210     C                   ENDSL
140700160616
140800101210     C                   EVAL      @SEX   = DSEX
140900101210     C                   EVAL      @DOB   = %EDITC(DBIRTH:'X')
141000160616
141100101210     C                   IF        DCOB = 'Y'
141200101210     C                   EVAL      @COB   = 'Y'
141300101210     C                   EVAL      @COBC  = 'OT'
141400101210     C                   EVAL      @COBN  = DCOBPN
141500130225     C                   ELSE
141600130225     C                   EVAL      @COB   = *BLANKS
141700130225     C                   EVAL      @COBC  = *BLANKS
141800130225     C                   EVAL      @COBN = *BLANKS
141900101210     C                   ENDIF
142000160616
142100101214     C                   IF        DADDR1 <> ADDR1
142200101210     C                   EVAL      @AD1   = %TRIM(DADDR1)
142300101210     C                   EVAL      @AD2   = %TRIM(DADDR2)
142400101210     C                   EVAL      @CTY   = %TRIM(DCITY)
142500101210     C                   EVAL      @ST    = DSTATE
142600101210     C                   MOVE      *BLANKS       @9                9
142700101214     C                   IF        DZIP = 0
142800101214     C                   EVAL      @9   = %EDITC(ZIP:'X')
142900101214     C                   ELSE
143000101210     C                   EVAL      @9   = %EDITC(DZIP:'X')
143100101214     C                   ENDIF
143200101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
143300101210     C                   EVAL      @PHN   = %EDITC(DAREA:'X') +
143400101210     C                                      %EDITC(DPHONE:'X')
143500101214     C                   ENDIF
143600160616
143700161109       // if cobra and effective date > 12/01/2016...
143800161109       if empst = 'C';
143900161109        if qedt >= effectiveDateD;
144000161109         @empst = 'AC';
144100161109        endif;
144200161109       endif;
144300161109
144400101210     C                   EXCEPT    MBRF
144500101214     C                   ADD       1             C#RECCNT
144600160616
144700101214     C                   EVAL      @STEP = 'PREPA'
144800160616
144900101210     C                   ENDSR
145000160616
145100160616      *============================================================================
145200160616
145300101214     C     $PREPA        BEGSR
145400160616
145500101214     C                   IF        M#CNE = 0
145600101214     C                   EVAL      @STEP = 'PREPB'
145700101214     C                   LEAVESR
145800101214     C                   ENDIF
145900160616
146000101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
146100160615     C     KL#TSAP       CHAIN     AEF04
146200160615     C                   IF        NOT %FOUND(AET004WF)
146300120803     C                   LEAVESR
146400120803     C                   ENDIF
146500160616
146600101214     C                   IF        TERM_MED = YES
146700101214     C                   EXSR      $WRTERM
146800101214     C                   ENDIF
146900160616
147000110513     C                   EVAL      @PLANIN = KF@PLN
147100160616
147200110802     C                   EXSR      $QUIKD
147300160616
147400110513     C                   EXSR      $PLANSRCH
147500160616
147600110513     C                   IF        PLN@CAT = *BLANKS
147700110513     C                   SETON                                        H2
147800110513     C                   ENDIF
147900160616
148000110513     C                   EVAL      @STEP = 'STEPA'
148100160616
148200101214     C                   ENDSR
148300160616
148400160616      *============================================================================
148500160616
148600101214     C     $STEPA        BEGSR
148700160616
148800110513     C                   IF        CPCID1 = 'MEA'
148900110513     C                   EXSR      $MEAWRT
149000110513     C                   ELSE
149100110513     C                   EXSR      $HMOWRT
149200110513     C                   ENDIF
149300160616
149400110513     C                   ADD       1             C#RECCNT
149500110513     C                   ADD       1             B#RECCNT
149600160616
149700110513     C                   EVAL      @STEP = 'PREPB'
149800160616
149900110513     C                   ENDSR
150000160616
150100160616      *============================================================================
150200160616
150300101214     C     $PREPB        BEGSR
150400160616
150500160616     C                   IF        D#CNE = 0
150600160616     C                   EVAL      @STEP = 'STEP7'
150700160616     C                   LEAVESR
150800160616     C                   ENDIF
150900160616
151000160616     C                   EVAL      KF@PLN = D@PLN(D#CNE)
151100160615     C     KL#TSAP       CHAIN     AEF04
151200160615     C                   IF        NOT %FOUND(AET004WF)
151300120803     C                   LEAVESR
151400120803     C                   ENDIF
151500160616
151600160616     C                   IF        TERM_DEN = YES
151700160616     C                   EXSR      $WRTERM
151800160616     C                   ENDIF
151900160616
152000110513     C                   EVAL      @PLANIN = KF@PLN
152100160616
152200110802     C                   EXSR      $QUIKD
152300160616
152400110513     C                   EXSR      $PLANSRCH
152500160616
152600110513     C                   IF        PLN@CAT = *BLANKS
152700110513     C                   SETON                                        H2
152800110513     C                   ENDIF
152900160616
153000101214     C                   EVAL      @STEP = 'STEPB'
153100160616
153200101214     C                   ENDSR
153300160616
153400160616      *============================================================================
153500160616
153600160616     C     $STEPB        BEGSR
153700160616
153800110513     C                   EXSR      $DENWRT
153900160616
154000160616     C                   ADD       1             C#RECCNT
154100160616     C                   ADD       1             B#RECCNT
154200160616
154300160616     C                   EVAL      @STEP = 'STEP7'
154400160616
154500160616     C                   ENDSR
154600160616
154700160616      *============================================================================
154800160616
154900110512     C     *INZSR        BEGSR
155000160616
155100160314     C     *entry        plist
155200160314     C                   parm                    CARR#CTL
155300160314     C                   parm                    grouper
155400160314
155500110512     C     KL#ACCTL      KLIST
155600160919     C                   KFLD                    CARR#CTL
155700110512     C                   KFLD                    KF@TRS
155800110512     C                   KFLD                    KF@SUB
155900110512     C                   KFLD                    KF@ACC
156000160616
156100140313     C     KL#SQPCD      KLIST
156200140313     C                   KFLD                    KF@SSN
156300140313     C                   KFLD                    KF@SEQ
156400140313     C                   KFLD                    KF@SPCD
156500160616
156600120803     C     KL#TSAP       KLIST
156700120803     C                   KFLD                    KF@TRS
156800120803     C                   KFLD                    KF@SUB
156900120803     C                   KFLD                    KF@ACC
157000120803     C                   KFLD                    KF@PLN
157100160616
157200110512     C     KL#TSA        KLIST
157300110512     C                   KFLD                    KF@TRS
157400110512     C                   KFLD                    KF@SUB
157500110512     C                   KFLD                    KF@ACC
157600160616
157700110512     C     KL#MPLN       KLIST
157800110512     C                   KFLD                    KF@SSN
157900110512     C                   KFLD                    KF@SEQ
158000110512     C                   KFLD                    KF@TRS
158100110512     C                   KFLD                    KF@SUB
158200110512     C                   KFLD                    KF@ACC
158300160616
158400110512     C     KL#CPLN       KLIST
158500160919     C                   KFLD                    CARR#CTL
158600110512     C                   KFLD                    KF@TRS
158700110512     C                   KFLD                    KF@SUB
158800110512     C                   KFLD                    KF@ACC
158900110512     C                   KFLD                    KF@CCTR
159000110512     C                   KFLD                    KF@PLN
159100160616
159200110512     C     KL#DCV        KLIST
159300110512     C                   KFLD                    KF@SSN
159400110512     C                   KFLD                    KF@SEQ
159500160616
159600110512     C     KL#MTR        KLIST
159700110512     C                   KFLD                    KF@SSN
159800110512     C                   KFLD                    KF@SEQ
159900110512     C                   KFLD                    KF#TRM
160000110512     C                   KFLD                    KF@PLN
160100110512     C                   KFLD                    KF@ENR
160200110512     C                   KFLD                    KF@TRS
160300110512     C                   KFLD                    KF@SUB
160400110512     C                   KFLD                    KF@ACC
160500160616
160600110512     C     KL#PCP        KLIST
160700110512     C                   KFLD                    KF@SSN
160800110512     C                   KFLD                    KF@SEQ
160900160616
161000110512     C                   EVAL      #ISO = %DATE
161100110512     C                   MOVE      #ISO          #TODAY            8 0
161200110512     C                   EVAL      #IST = %TIME
161300110512     C                   MOVE      #ISO          #XSX
161400110512     C                   MOVE      #XSX          @DATE
161500110512     C                   MOVE      #IST          #XST
161600110512     C                   MOVE      #XST          @TIME
161700160616
161800110512     C                   ENDSR
161900160616
162000160616      *============================================================================
162100160616      * PLANS LOADED BY ACCOUNT
162200160616      *============================================================================
162300160616
162400110513     C     $PLANLOAD     BEGSR
162500160616
162600110513     C                   EVAL      PP# = 0
162700140313     C                   DO        80
162800110513     C                   ADD       1             PP#
162900110513     C     PP#           OCCUR     CARPLN@
163000110513     C                   CLEAR                   CARPLN@
163100110513     C                   ENDDO
163200110513     C                   EVAL      PC# = 0
163300110513     C                   EVAL      PP# = 0
163400160616
163500110513     C     KL#ACCTL      SETLL     CARPLNR
163600110513     C                   DOU       %EOF(CARPLNP)
163700110513     C     KL#ACCTL      READE     CARPLNR
163800110520     C                   IF        NOT %EOF(CARPLNP)
163900160616
164000110513     C                   ADD       1             PC#
164100110513     C     PC#           OCCUR     CARPLN@
164200110513     C                   EVAL      CARPLN@ = DS@CARPLN
164300160616
164400110513     C                   ENDIF
164500110513     C                   ENDDO
164600160616
164700110513     C                   ENDSR
164800160616
164900160616      *============================================================================
165000160616
165100110513     C     $CLRSTG       BEGSR
165200160616
165300110513     C                   EVAL      #CANCEL = 0
165400160616
165500130315     C                   EVAL      L#CNE = 0
165600130315     C                   CLEAR                   L@PLN
165700130315     C                   CLEAR                   L@ENR
165800130315     C                   CLEAR                   L@FRM
165900130315     C                   CLEAR                   L@TRM
166000160616
166100110513     C                   EVAL      D#CNE = 0
166200110513     C                   CLEAR                   D@PLN
166300110513     C                   CLEAR                   D@ENR
166400110513     C                   CLEAR                   D@FRM
166500110513     C                   CLEAR                   D@TRM
166600110513     C                   EVAL      M#CNE = 0
166700110513     C                   CLEAR                   M@PLN
166800110513     C                   CLEAR                   M@ENR
166900110513     C                   CLEAR                   M@FRM
167000110513     C                   CLEAR                   M@TRM
167100160616
167200110513     C                   EXSR      $CLRDMG
167300160616
167400110513     C                   ENDSR
167500160616
167600160616      *============================================================================
167700160616
167800110513     C     $CLRDMG       BEGSR
167900160616
168000110513     C                   EVAL      @SS1   = *BLANKS
168100110513     C                   EVAL      @SS2   = *BLANKS
168200110513     C                   MOVE      *BLANKS       @LN
168300110513     C                   MOVEL     *BLANKS       @FN
168400110513     C                   EVAL      @MI    = *BLANKS
168500110513     C                   EVAL      @REL   = *BLANKS
168600110513     C                   EVAL      @SEX   = *BLANKS
168700110513     C                   EVAL      @DOB   = *BLANKS
168800110513     C                   EVAL      @SPEC  = *BLANKS
168900110513     C                   EVAL      @COB   = *BLANKS
169000110513     C                   EVAL      @COBC  = *BLANKS
169100110513     C                   EVAL      @COBN  = *BLANKS
169200110513     C                   EVAL      @AD1   = *BLANKS
169300110513     C                   EVAL      @AD2   = *BLANKS
169400110513     C                   EVAL      @CTY   = *BLANKS
169500110513     C                   EVAL      @ST    = *BLANKS
169600110513     C                   EVAL      @ZP5   = *BLANKS
169700110513     C                   EVAL      @PHN   = *BLANKS
169800110513     C                   EVAL      @EMPST = *BLANKS
169900110513     C                   EVAL      @HIRE  = *BLANKS
170000160616
170100110513     C                   ENDSR
170200160616
170300160616      *============================================================================
170400160616
170500110513     C     $CHKHEM       BEGSR
170600160616
170700160616     C                   IF        L#CNE > 0 AND L@TRM(L#CNE) <> 99999999
170800160616     C                   EXSR      $CHKLIF
170900160616     C                   ENDIF
171000160616
171100160616     C                   IF        D#CNE > 0 AND D@TRM(D#CNE) <> 99999999
171200160616     C                   EXSR      $CHKDEN
171300160616     C                   ENDIF
171400160616
171500110513     C                   IF        M#CNE > 0 AND M@TRM(M#CNE) <> 99999999
171600110513     C                   EXSR      $CHKMED
171700110513     C                   ENDIF
171800160616
171900110513     C                   ENDSR
172000160616
172100160616      *============================================================================
172200160616
172300160616     C     $CHKLIF       BEGSR
172400160616
172500160616     C                   EVAL      TERM_LIF = YES
172600160616     C                   EVAL      KF#TRM = L@TRM(L#CNE)
172700160616     C                   EVAL      KF@PLN = L@PLN(L#CNE)
172800160616     C                   EVAL      KF@ENR = L@ENR(L#CNE)
172900160616
173000170120     C     KL#MTR        CHAIN     AET1081F
173100170120     C                   IF        %FOUND(AET1081WF)
173200160616     C                   EVAL      L#CNE = 0
173300160616     C                   EVAL      TERM_LIF = NO
173400160616     C                   ENDIF
173500160616
173600160616     C                   ENDSR
173700160616
173800160616      *============================================================================
173900160616
174000160616     C     $CHKDEN       BEGSR
174100160616
174200160616     C                   EVAL      TERM_DEN = YES
174300160616     C                   EVAL      KF#TRM = D@TRM(D#CNE)
174400160616     C                   EVAL      KF@PLN = D@PLN(D#CNE)
174500160616     C                   EVAL      KF@ENR = D@ENR(D#CNE)
174600160616
174700170120     C     KL#MTR        CHAIN     AET1081F
174800170120     C                   IF        %FOUND(AET1081WF)
174900160616     C                   EVAL      D#CNE = 0
175000160616     C                   EVAL      TERM_DEN = NO
175100160616     C                   ENDIF
175200160616
175300160616     C                   ENDSR
175400160616
175500160616      *============================================================================
175600160616
175700110513     C     $CHKMED       BEGSR
175800160616
175900110513     C                   EVAL      TERM_MED = YES
176000110513     C                   EVAL      KF#TRM = M@TRM(M#CNE)
176100110513     C                   EVAL      KF@PLN = M@PLN(M#CNE)
176200110513     C                   EVAL      KF@ENR = M@ENR(M#CNE)
176300160616
176400170120     C     KL#MTR        CHAIN     AET1081F
176500170120     C                   IF        %FOUND(AET1081WF)
176600110513     C                   EVAL      TERM_MED = NO
176700110513     C                   EVAL      M#CNE = 0
176800110513     C                   ENDIF
176900160616
177000110513     C                   ENDSR
177100160616
177200160616      *============================================================================
177300160616
177400110513     C     $PLANSRCH     BEGSR
177500160616
177600130315     C                   MOVE      *BLANKS       PLN@CAT           5
177700110513     C                   EVAL      PP# = 0
177800110513     C                   CLEAR                   DS@CARPLN
177900160616
178000110513     C                   DO        PC#
178100160616
178200110513     C                   ADD       1             PP#
178300110513     C     PP#           OCCUR     CARPLN@
178400160616
178500110513     C                   IF        XPPLAN = @PLANIN AND
178600110513     C                             XPCCTR = @CCTRIN
178700110513     C                   EVAL      DS@CARPLN = CARPLN@
178800110513     C                   LEAVE
178900110513     C                   ENDIF
179000160616
179100110513     C                   ENDDO
179200160616
179300110513     C                   IF        CPPLAN = *BLANKS
179400110513     C                   LEAVESR
179500110513     C                   ENDIF
179600160616
179700110513     C                   SELECT
179800110520     C                   WHEN      CPCID1 = 'MEA' OR
179900110520     C                             CPCID1 = 'HMO'
180000110520     C                   EVAL      PLN@CAT = 'MED'
180100130409     C                   WHEN      CPCID1 = 'LIFE'
180200130409     C                   EVAL      PLN@CAT = 'LIFE'
180300110520     C                   WHEN      CPCID1 = 'DEN'
180400110520     C                   EVAL      PLN@CAT = 'DEN'
180500110513     C                   ENDSL
180600160616
180700110513     C                   ENDSR
180800160616
180900160616      *============================================================================
181000160616
181100110513     C     $ENROLL       BEGSR
181200160616
181300110513     C                   EVAL      ENR@OUT = *BLANKS
181400110513     C                   SELECT
181500110513     C                   WHEN      ENR@IN = 'TIN' OR ENR@IN = 'TMI'
181600110513     C                   EVAL      ENR@OUT = 'S'
181700110513     C                   WHEN      ENR@IN = 'THW'
181800110513     C                   EVAL      ENR@OUT = 'C'
181900110513     C                   WHEN      ENR@IN = 'TPC'
182000110513     C                   EVAL      ENR@OUT = 'P'
182100110513     C                   WHEN      ENR@IN = 'TP2'
182200110513     C                   EVAL      ENR@OUT = 'Q'
182300110513     C                   WHEN      ENR@IN = 'TFA'
182400110513     C                   EVAL      ENR@OUT = 'F'
182500110513     C                   ENDSL
182600160616
182700110513     C                   ENDSR
182800160616
182900160616      *============================================================================
183000160616
183100110513     C     $WRTERM       BEGSR
183200160616
183300170120     C                   CLEAR                   AET1081F
183400110513     C                   EVAL      NTSSNO         = KF@SSN
183500110513     C                   EVAL      NTDEPNO        = KF@SEQ
183600110513     C                   EVAL      NTTERMDT       = KF#TRM
183700110513     C                   EVAL      NTPLAN         = KF@PLN
183800110513     C                   EVAL      NTCOVTP        = KF@ENR
183900110513     C                   EVAL      NTTRST         = KF@TRS
184000110513     C                   EVAL      NTSUB#         = KF@SUB
184100110513     C                   EVAL      NTACCT         = KF@ACC
184200110513     C                   EVAL      NTTRANSDT      = #TODAY
184300170120     C                   WRITE     AET1081F
184400160616
184500110513     C                   ENDSR
184600160616
184700160616      *============================================================================
184800160616
184900110513     C     $HMOWRT       BEGSR
185000160616
185100110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
185200110513     C                   EVAL      X@ELR = CPCID2                               FILE NUMBER
185300110513     C                   EVAL      M@CC = CACID2                                COMPANY CODE
185400110513     C                   EVAL      M@CLASS = CPCID3                             CLASS CODE
185500110513     C                   EVAL      M@PLAN = CPCID4                              PLAN NUMBER
185600160616
185700110513     C                   EVAL      #XSX = M@FRM(M#CNE)
185800110725     C                   IF        WRT@TYPE = 'DEPEND' AND
185900110725     C                             #XSX < M@MBREFF
186000110725     C                   MOVE      M@MBREFF      X@EFF
186100110725     C                   ELSE
186200110725     C                   MOVE      #XSX          X@EFF
186300110725     C                   ENDIF
186400160616
186500170303     c                   if        x@eff < '20170101'
186600170303     c                   eval      x@eff = '20170101'
186700170303     c                   endif
186800170303
186900110513     C                   EVAL      #XSX = M@TRM(M#CNE)
187000110513     C                   IF        #XSX = 0 OR #XSX = 99999999
187100110513     C                   MOVE      *BLANKS       X@TRM
187200110513     C                   ELSE
187300110513     C                   MOVE      #XSX          X@TRM
187400110513     C                   ENDIF
187500160616
187600110513     C                   IF        WRT@TYPE = 'MEMBER'
187700110513     C                   EVAL      KF@SEQ = 0
187800110513     C                   EVAL      ENR@IN = M@ENR(M#CNE)
187900110513     C                   EXSR      $ENROLL
188000110513     C                   EVAL      X@TIER = ENR@OUT
188100110513     C                   ELSE
188200110513     C                   EVAL      X@TIER = *BLANKS
188300110513     C                   ENDIF
188400160616
188500140313     C                   EVAL      KF@SPCD = 'MED'
188600140313     C                   EVAL      M@PCP = *BLANKS
188700140313     C                   EVAL      M@NPI = *BLANKS
188800140313     C                   EVAL      M@PCPCI = *BLANKS
188900160616
189000140313     C                   EXSR      $PCP
189100160616
189200140313     C                   IF        DOCTOR <> *BLANKS
189300140313     C                   EVAL      M@PCP = DOCTOR
189400140313     C                   EVAL      M@NPI = 'Y'
189500140313     C                   EVAL      M@PCPCI = '0'
189600140313     C                   ENDIF
189700160616
189800110513     C                   EXCEPT    HMOF
189900160616
190000110513     C                   ENDSR
190100160616
190200160616      *============================================================================
190300160616
190400110513     C     $MEAWRT       BEGSR
190500160616
190600110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
190700110513     C                   EVAL      X@ELR = CPCID2                               ELR
190800140313     C                   EVAL      E@SFX = CPCID3                               SUFFIX
190900140313     C                   EVAL      E@ACCT = CPCID4                              ACCOUNT
191000140313     C                   EVAL      E@PLAN = CPCID5                              PLAN
191100140313     C                   EVAL      E@CLM = CPCID6                               CLAIM OFFICE
191200160616
191300110513     C                   EVAL      #XSX = M@FRM(M#CNE)
191400110725     C                   IF        WRT@TYPE = 'DEPEND' AND
191500110725     C                             #XSX < M@MBREFF
191600110725     C                   MOVE      M@MBREFF      X@EFF
191700110725     C                   ELSE
191800110725     C                   MOVE      #XSX          X@EFF
191900110725     C                   ENDIF
192000170303
192100170303     c                   if        x@eff < '20170101'
192200170303     c                   eval      x@eff = '20170101'
192300170303     c                   endif
192400160616
192500160616     C                   EVAL      #XSX = M@TRM(M#CNE)
192600110513     C                   IF        #XSX = 0 OR #XSX = 99999999
192700110513     C                   MOVE      *BLANKS       X@TRM
192800110513     C                   ELSE
192900110513     C                   MOVE      #XSX          X@TRM
193000110513     C                   ENDIF
193100160616
193200140313     C                   MOVE      *BLANKS       E@CBREXP
193300140313     C                   MOVE      *BLANKS       E@CBREVT
193400140313     C                   MOVE      *BLANKS       E@CBRLEN
193500140313     C                   IF        WRT@TYPE = 'MEMBER'
193600140425     C                   IF        EMPST = 'C' AND
193700140425     C                             CEXPDT > 0
193800140313     C                   MOVE      CEXPDT        E@CBREXP
193900140313     C                   MOVE      QEDT          E@CBREVT
194000140313     C                   MOVE      CEXPDT        #MINUEND
194100140313     C                   MOVE      QEDT          #SUBTRAEND
194200140313     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
194300140313     C                   Z-ADD     #DIFFRNC      #2S0
194400140313     C                   MOVE      #2S0          E@CBRLEN
194500140313     C                   ENDIF
194600140313     C                   ENDIF
194700160616
194800140313     C                   EVAL      *IN80 = *OFF
194900140313     C                   EVAL      KF@SPCD = 'MED'
195000140313     C                   EVAL      E@PCP = *BLANKS
195100140313     C                   EXSR      $PCP
195200140313     C                   IF        DOCTOR <> *BLANKS
195300140313     C                   EVAL      E@PCP = DOCTOR
195400140313     C                   EVAL      *IN80 = *ON
195500140313     C                   ENDIF
195600160616
195700161109       // if cobra and effective date > 12/01/2016...
195800161109       if empst = 'C';
195900161109        if e@cbrevt >= effectiveDate;
196000161109         e@cbrexp = ' ';
196100161109          e@cbrevt = ' ';
196200161109         e@cbrlen = ' ';
196300161109        endif;
196400161109       endif;
196500161109
196600140313     C                   EXCEPT    MEAF
196700160616
196800110513     C                   ENDSR
196900160616
197000160616      *============================================================================
197100160616
197200140313     C     $PCP          BEGSR
197300160616
197400140313     C                   MOVE      *BLANKS       DOCTOR            7
197500140313     C     KL#SQPCD      CHAIN     PCPR
197600140313     C                   IF        NOT %FOUND(PCPL1)
197700140313     C                   LEAVESR
197800140313     C                   ENDIF
197900140313     C     KL#SQPCD      SETLL     PCPR
198000140313     C                   DOU       %EOF(PCPL1)
198100140313     C     KL#SQPCD      READE     PCPR
198200140313     C                   IF        NOT %EOF(PCPL1) AND PCCAN = 0
198300140313     C                   MOVEL(P)  PCID#         DOCTOR
198400140313     C                   LEAVESR
198500140313     C                   ENDIF
198600140313     C                   ENDDO
198700160616
198800140313     C                   ENDSR
198900160616
199000160616      *============================================================================
199100160616
199200110513     C     $CLRDCV       BEGSR
199300160616
199400110513     C                   MOVE      *BLANKS       @LN
199500110513     C                   MOVEL     *BLANKS       @FN
199600110513     C                   EVAL      @SS2   = *BLANKS
199700110513     C                   EVAL      @MI    = *BLANKS
199800110513     C                   EVAL      @REL   = *BLANKS
199900110513     C                   EVAL      @SEX   = *BLANKS
200000110513     C                   EVAL      @DOB   = *BLANKS
200100110513     C                   EVAL      @SPEC  = *BLANKS
200200110513     C                   EVAL      @COB   = *BLANKS
200300110513     C                   EVAL      @COBC  = *BLANKS
200400110513     C                   EVAL      @COBN  = *BLANKS
200500160616
200600110513     C                   EVAL      #CANCEL = 0
200700110513     C                   EVAL      D#CNE = 0
200800110513     C                   CLEAR                   D@PLN
200900110513     C                   CLEAR                   D@ENR
201000110513     C                   CLEAR                   D@FRM
201100110513     C                   CLEAR                   D@TRM
201200110513     C                   EVAL      M#CNE = 0
201300110513     C                   CLEAR                   M@PLN
201400110513     C                   CLEAR                   M@ENR
201500110513     C                   CLEAR                   M@FRM
201600110513     C                   CLEAR                   M@TRM
201700160616
201800110513     C                   ENDSR
201900160616
202000160616      *============================================================================
202100160616
202200110513     C     $DENWRT       BEGSR
202300160616
202400160616     C                   EVAL      X@LAY = CPCID1                               LAYOUT
202500160616     C                   EVAL      X@ELR = CPCID2                               ELR
202600160616     C                   EVAL      D@SFX = CPCID3                               SUFFIX
202700160616     C                   EVAL      D@ACCT = CPCID4                              ACCOUNT
202800160616     C                   EVAL      D@PLAN = CPCID5                              PLAN
202900160616     C                   EVAL      D@CLM = CPCID6                               CLAIM OFFICE
203000110524     C                   EVAL      DNTLATE = '0'
203100160616
203200160616     C                   EVAL      #XSX = D@FRM(D#CNE)
203300110725     C                   IF        WRT@TYPE = 'DEPEND' AND
203400110725     C                             #XSX < D@MBREFF
203500110725     C                   MOVE      D@MBREFF      X@EFF
203600110725     C                   ELSE
203700110725     C                   MOVE      #XSX          X@EFF
203800110725     C                   ENDIF
203900160616
204000170303     c                   if        x@eff < '20170101'
204100170303     c                   eval      x@eff = '20170101'
204200170303     c                   endif
204300170303
204400160616     C                   EVAL      #XSX = D@TRM(D#CNE)
204500160616     C                   IF        #XSX = 0 OR #XSX = 99999999
204600160616     C                   MOVE      *BLANKS       X@TRM
204700160616     C                   ELSE
204800160616     C                   MOVE      #XSX          X@TRM
204900160616     C                   ENDIF
205000160616
205100130211     C                   MOVE      *BLANKS       D@CBREXP
205200130211     C                   MOVE      *BLANKS       D@CBREVT
205300130211     C                   MOVE      *BLANKS       D@CBRLEN
205400110513     C                   IF        WRT@TYPE = 'MEMBER'
205500160616     C                   IF        EMPST = 'C' AND CEXPDT <> 0
205600160616     C                   MOVE      CEXPDT        D@CBREXP
205700160616     C                   MOVE      QEDT          D@CBREVT
205800160616     C                   MOVE      CEXPDT        #MINUEND
205900160616     C                   MOVE      QEDT          #SUBTRAEND
206000160616     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
206100160616     C                   Z-ADD     #DIFFRNC      #2S0
206200160616     C                   MOVE      #2S0          D@CBRLEN
206300160616     C                   ENDIF
206400160616     C                   ENDIF
206500160616
206600160616     C                   MOVE      '0'           D@OOAI
206700160616
206800140313     C                   EVAL      KF@SPCD = 'DEN'
206900140313     C                   EVAL      D@PCD = *BLANKS
207000140313     C                   EVAL      *IN81 = *OFF
207100140313     C                   MOVE      *BLANKS       DOCTOR
207200160616
207300140313     C                   EXSR      $PCP
207400160616
207500140313     C                   IF        DOCTOR <> *BLANKS
207600140313     C                   EVAL      D@PCD = DOCTOR
207700140313     C                   EVAL      *IN81 = *ON
207800140313     C                   ENDIF
207900160616
208000120123     C     *LIKE         DEFINE    H@C#          BUC#
208100120123     C                   EVAL      BUC# = H@C#
208200160616
208300120327     C                   SELECT
208400131126     C                   WHEN      KF@TRS = 591 AND KF@SUB = 009 AND            WILMOT MODULAR
208500131126     C                             KF@ACC = 0202                                 STRUCTURES
208600131227     C                   EVAL      H@C# = '0638156'
208700140702     C                   WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            REDLAND
208800140702     C                             KF@ACC = 0475                                 BAPTISTS
208900140702     C                   EVAL      H@C# = '0725572'
209000120327     C                   WHEN      KF@TRS = 825 AND KF@SUB = 001 AND            CREATIVE
209100120123     C                             KF@ACC = 0014                                 LOGISTICS
209200120123     C                   EVAL      H@C# = '0133860'
209300130905     C                   WHEN      KF@TRS = 905 AND KF@SUB = 001 AND            CCL USA
209400130905     C                             KF@ACC = 0092
209500130905     C                   EVAL      H@C# = '0638423'
209600140423     C                   WHEN      KF@TRS = 003 AND KF@SUB = 001 AND            FRAME RITE
209700140423     C                             KF@ACC = 0104
209800140423     C                   EVAL      H@C# = '0306511'
209900130520     C                   WHEN      KF@TRS = 900 AND KF@SUB = 003 AND            PERFECT
210000130520     C                             KF@ACC = 0045                                 SETTINGS
210100130520     C                   EVAL      H@C# = '0474109'
210200121024     C                   WHEN      KF@TRS = 591 AND KF@SUB = 011 AND            MCCALLISTER
210300121024     C                             KF@ACC = 0446                                 ARCHITECT
210400121024     C                   EVAL      H@C# = '0565330'
210500130716     C                   WHEN      KF@TRS = 591 AND KF@SUB = 005 AND            JD CLARK PROF
210600130716     C                             KF@ACC = 0451                                 SERVICES
210700130716     C                   EVAL      H@C# = '0519890'
210800130627     C                   WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            DYSON CONSTRUCTION
210900130627     C                             KF@ACC = 0459                                 COMPANY
211000130627     C                   EVAL      H@C# = '0788122'
211100130903     C                   WHEN      KF@TRS = 591 AND KF@SUB = 004 AND            STROUSE CORP
211200130903     C                             KF@ACC = 0482
211300130903     C                   EVAL      H@C# = '0837451'
211400130712     C                   WHEN      KF@TRS = 900 AND KF@SUB = 007 AND            CAPLAN BROTHERS
211500130712     C                             KF@ACC = 0075
211600130712     C                   EVAL      H@C# = '0837533'
211700120806     C                   WHEN      KF@TRS = 900 AND KF@SUB = 101 AND            INTEGRA HEALTH
211800130110     C                             KF@ACC = 0042 AND
211900130110     C                             (STATE = 'TN' OR STATE = 'FL' OR
212000130718     C                              STATE = 'OH' OR STATE = 'MA') AND
212100120806     C                             (@PLANIN = 'DAAD' OR @PLANIN = 'BAAD')
212200120806     C                   EVAL      H@C# = '0503428'
212300160616     C                   ENDSL
212400160616
212500161109       // if cobra and effective date > 12/01/2016...
212600161109       if empst = 'C';
212700161109        if d@cbrevt >= effectiveDate;
212800161109         d@cbrexp = ' ';
212900161109          d@cbrevt = ' ';
213000161109         d@cbrlen = ' ';
213100161109        endif;
213200161109       endif;
213300161109
213400160616     C                   EXCEPT    DENF
213500151217     c                   EVAL      H@C# = BUC#
213600160616
213700160616     C                   ENDSR
213800160616
213900160616      *============================================================================
214000160616
214100170120     OAET1080WF EADD         HDRF
214200101203     O                                            6 'HEADER'
214300160810     O                                            8 'P'
214400101206     O                       H@SI                28
214500101203     O                                           29 '0'
214600101203     O                       C1                  43
214700101203     O                       D1                  51
214800101203     O                       T1                  57
214900101206     O                                          131 'CONSOLIDATED ELIGIBILITY'
215000110502     O                       H@RI               167
215100101206     O                       H@CC               169
215200101228     O                       H@GN               176
215300101206     O                       H@CN               191
215400101206     O                       H@C#               198
215500101203     O                       D2                 206
215600110825     O                                          216 'MC'
215700101223     O                                          231 '*'
215800160616
215900160616      *============================================================================
216000170120     OAET1080WF EADD         MBRF
216100101203     O                                            6 'MEMBER'
216200101203     O                       @SS1                16
216300101203     O                       @SS2                25
216400101203     O                       @FN                 75
216500101203     O                       @MI                 76
216600101203     O                       @LN                 96
216700101203     O                       @REL               101
216800101203     O                       @SEX               103
216900101203     O                       @DOB               111
217000101203     O                       @SPEC              112
217100101203     O                                          113 '0'
217200101203     O                       @COB               123
217300101203     O                       @COBC              125
217400101203     O                       @COBN              145
217500101203     O                       @AD1               175
217600101203     O                       @AD2               205
217700101203     O                       @CTY               315
217800101203     O                       @ST                317
217900101203     O                       @ZP5               322
218000101203     O                       @PHN               349
218100141211     O               87                         576 '21207'
218200140626     O               88                         576 '21740'
218300141120     O               89                         576 '20171'
218400101203     O                       @EMPST             665
218500101203     O                       @HIRE              673
218600101223     O                                         1231 '*'
218700160616
218800160616      *============================================================================
218900170120     OAET1080WF EADD         HMOF
219000101213     O                                            7 'BENEFIT'
219100101213     O                       X@LAY               10
219200101214     O                       X@ELR               24
219300101213     O                       M@CC                26
219400101213     O                       H@GN                38
219500101213     O                       M@CLASS             44
219600101213     O                       M@PLAN              50
219700101213     O                       X@EFF               58
219800110929     O                       X@TRM               66
219900101213     O                       X@TIER              69
220000101213     O                       M@PCP              160
220100101213     O                       M@NPI              161
220200101213     O                       M@PCPCI            186
220300101223     O                                          323 '*'
220400160616
220500160616      *============================================================================
220600170120     OAET1080WF EADD         MEAF
220700140313     O                                            7 'BENEFIT'
220800140313     O                                           10 'MEA'
220900140313     O                       X@ELR               24
221000140313     O                       H@C#                31
221100140313     O                       E@SFX               34
221200140313     O                       E@ACCT              44
221300140313     O                       E@PLAN              50
221400140313     O                       X@EFF               58
221500140313     O                       X@TRM               66
221600140313     O                       E@CLM               71
221700140313     *** PCP BGN
221800140313     O                       E@PCP              127
221900140313     O               80                         161 'N'
222000140313     O               80                         186 '0'
222100140313     *** PCP END
222200140313     O                                          389 '0'
222300140313     *** COBRA BGN
222400140313     O                       E@CBREXP           466
222500140313     O                       E@CBREVT           516
222600140313     O                       E@CBRLEN           560
222700140313     *** COBRA END
222800140313     O                                          678 '*'
222900160616
223000160616      *============================================================================
223100170120     OAET1080WF EADD         DENF
223200101213     O                                            7 'BENEFIT'
223300101213     O                       X@LAY               10
223400101214     O                       X@ELR               24
223500101214     O                       H@C#                31
223600101213     O                       D@SFX               34
223700101213     O                       D@ACCT              44
223800101213     O                       D@PLAN              50
223900101213     O                       X@EFF               58
224000110929     O                       X@TRM               66
224100101213     O                       D@CLM               71
224200140313     *** PCD BGN
224300140313     O                       D@PCD              200
224400140313     O               81                         236 '0'
224500140313     *** PCD END
224600140313     O                                          389 '0'
224700140313     *** COBRA BGN
224800140313     O                       D@CBREXP           466
224900140313     O                       D@CBREVT           516
225000140313     O                       D@CBRLEN           560
225100140313     *** COBRA END
225200140313     O                       D@OOAI             609
225300140313     O                                          678 '*'
225400160616
225500160616      *============================================================================
225600170120     OAET1080WF EADD         LIFF
225700130315     O                                            7 'BENEFIT'
225800130412     O                                           11 'LIFE'
225900130315     O                       X@ELR               24
226000130319     O                       H@C#3               31
226100130315     O                       L@SFX               34
226200130315     O                       L@ACCT              44
226300130315     O                       L@PLAN              50
226400130315     O                       X@EFF               58
226500130315     O                       X@TRM               66
226600130315     O                       L@CLM               71
226700130315     O                       L@CBREXP           466
226800130315     O                       L@CBREVT           516
226900130315     O                       L@CBRLEN           560
227000130315     O                       L@SALARY           658
227100130315     O                                          659 '1'
227200130315     O                                          678 '*'
227300160616
227400160616      *============================================================================
227500170120     OAET1080WF EADD         TRLF
227600101203     O                                            7 'TRAILER'
227700101203     O                       @TREC               17
227800101203     O                       D1                  25
227900101203     O                       T1                  31
228000101203     O                       @BREC               41
228100101223     O                                           69 '*'
228200160616
228300160616      *============================================================================
