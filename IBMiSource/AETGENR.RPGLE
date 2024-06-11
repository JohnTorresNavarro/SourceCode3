000100160616      *=================================================================================
000200160314     H option(*noDebugIo)
000300160314      *=================================================================================
000400160314
000500160616      *  CARRIER CONTROL ID #0000000127 AETNA SPECIFIC
000600160616      *  SSK 05.13.2011 TEMPLATE DESIGN
000700160616      *
000800160616      *  08.17.2014 CLONED FROM AET084R
001000161109      *  11/08/2016  JT  Per Brandon Scarfield... eliminate future Cobra records and send as
001100161109      *                  AC (active) records
001300170317      *  03/17/2017  JT  Per Brandon Scarfield... reinstated Cobra records.
001302200124      *  01/24/2020  JT  Cleaned up a little bit of this mess
001401210312      *  03/12/2021  JT  Increased array size.
001403240130      *  01/30/2023  JT  The term date was not being passed to the term file for
001404240130      *                  verification
001500160314      *=================================================================================
001600160314
001700151217     FCARXPTP   IF   E           K DISK
001800151217      * Carrier export control master
001900151217
002000101012     FCARACCP   IF   E           K DISK
002100151217      * Carrier export control by account
002200151217
002300101012     FCARPLNP   IF   E           K DISK
002400151217      * Carrier export control by plan
002500151217
002600160615     FAET004WF  IF   E           K DISK
002700120803     ** MAPPING METHOD
002800151217
002900170404     FAETGEN    O  A F 1231        DISK
003000101206     ** FLAT FILE
003100151217
003200170404     FAETGENTRM IF A E           K DISK
003300101028     ** TERM TRACKER
003400151217
003500160616     FMEMAC#1   IF   E           K DISK    ExtFile('F.MEMAC#1')
003600151217
003700160616     FMCOVMPLN  IF   E           K DISK
003800151217
003900160616     FDEPNDC    IF   E           K DISK    ExtFile('F.DEPNDC')
004000151217
004100101012     FDCOVA     IF   E           K DISK
004200151217
004300160616     FPCPL1     IF   E           K DISK     ExtFile('F.PCPL1')
004400151217
004500160616      *=================================================================================
004600160616
004800160314
004900160314     D CARR#CTL        S             10A
005000160314     D grouper         S             10A
005100160314
005200160809     D H@RI            S             25A   INZ('042064683')                     RECEIVER ID
005300151217
005400110512     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
005500101026     D DS@CARACC     E DS                  EXTNAME(CARACCP)
005700151217
005800110512     ** WORK ARRAY FOR PLANS
005900110512     **
006000110512     ** PC# - PLAN COUNT
006100110512     ** PP# - PLAN POINTER
006200110512     **
006300110512     D CARPLN@       E DS                  EXTNAME(CARPLNP)
006400210312     D                                     OCCURS(480) PREFIX(X:1)
006500110512     D PC#             S              3S 0
006600110512     D PP#             S              3S 0
006700110512     D @PLANIN         S              4A
006800110512     D @CCTRIN         S              3A
006900160616
007000110513     ** WRITE TYPE = MEMBER OR DEPEND
007100110513     D WRT@TYPE        S              6A
007200110513     **
007300101214     D #XST            S              6S 0
007400101214     D #IST            S               T
007500101026     D #ISO            S               D   DATFMT(*ISO)
007600101214     D #MINUEND        S               D   DATFMT(*ISO)
007700101214     D #SUBTRAEND      S               D   DATFMT(*ISO)
007800101214     D @DATE           S              8A
007900101214     D @TIME           S              6A
008000101214     D #DIFFRNC        S              5S 0
008100101214     D #2S0            S              2S 0
008200101214     D #CANCEL         S              8S 0
008300101026     D #XSX            S              8S 0
008600101026     D ENR@IN          S              3A
008700101026     D ENR@OUT         S              1A
008800110524     D DNTLATE         S              1A
008900130315     D TERM_LIF        S               N
009000101214     D TERM_DEN        S               N
009100101214     D TERM_MED        S               N
009200101026     D YES             S               N   INZ(*ON)
009300101026     D NO              S               N   INZ(*OFF)
009400160315
009500160315     D firstTime       S              1    INZ('Y')
009600140313     **
009700110512     D KF@TRS          S                   LIKE(MCTRST)
009800110512     D KF@SUB          S                   LIKE(MCSUB#)
009900110512     D KF@ACC          S                   LIKE(ACC#)
010000101026     D KF@ENR          S              3A   INZ
010200101026     D KF@CCTR         S                   LIKE(CCFLG)
010300101026     D KF@PLN          S                   LIKE(MCPLAN)
010400101026     D KF@TRM          S                   LIKE(NTTERMDT)
010500101026     D KF#TRM          S              8S 0
010600101026     D KF@SSN          S                   LIKE(MBSSNO)
010700101026     D KF@SEQ          S                   LIKE(DPSEQ#)
011000140313     D KF@SPCD         S              5A
011200140313     **
011600140313     **
011800101214     D D1              S              8A
011900101214     D D2              S              8A
012000101214     D T1              S              6A
012100101214     D C1              S             14A
012200101206    ***
012300101029     D B#RECCNT        S             10S 0 INZ
012400101029     D C#RECCNT        S             10S 0 INZ
012500101206    ***
012600101210     D @SS1            S              9A
012700101210     D @SS2            S              9A
012800101210     D @FN             S             15A
012900101210     D @MI             S              1A
013000101210     D @LN             S             20A
013100101210     D @REL            S              2A
013200101210     D @SEX            S              1A
013300101210     D @DOB            S              8A
013400101210     D @SPEC           S              1A
013500101210     D @COB            S              1A
013600101210     D @COBC           S              2A
013700101210     D @COBN           S             20A
013800101210     D @AD1            S             30A
013900101210     D @AD2            S             30A
014000101214     D @CTY            S             20A
014100101210     D @ST             S              2A
014200101210     D @ZP5            S              5A
014300101210     D @PHN            S             10A
014400101210     D @EMPST          S              2A
014500101210     D @HIRE           S              8A
014600160616
014700130315    *** LIFE ARRAYS
014800130315     D L#CNE           S              3S 0 INZ
014900130315     D L#NDX           S              3S 0 INZ
015000170804     D L@PLN           S              4A   DIM(40)
015100170804     D L@ENR           S              3A   DIM(40)
015200170804     D L@FRM           S              8S 0 DIM(40)
015300170804     D L@TRM           S              8S 0 DIM(40)
015400130315     D L@MBREFF        S              8S 0
015500160616
015600101206    *** DENTAL ARRAYS
015700101206     D D#CNE           S              3S 0 INZ
015800101206     D D#NDX           S              3S 0 INZ
015900170804     D D@PLN           S              4A   DIM(40)
016000170804     D D@ENR           S              3A   DIM(40)
016100170804     D D@FRM           S              8S 0 DIM(40)
016200170804     D D@TRM           S              8S 0 DIM(40)
016300160616     D D@MBREFF        S              8S 0
016400160616
016500101206    *** MEDICAL ARRAYS
016600101206     D M#CNE           S              3S 0 INZ
016700101206     D M#NDX           S              3S 0 INZ
016800170804     D M@PLN           S              4A   DIM(40)
016900170804     D M@ENR           S              3A   DIM(40)
017000170804     D M@FRM           S              8S 0 DIM(40)
017100170804     D M@TRM           S              8S 0 DIM(40)
017200110725     D M@MBREFF        S              8S 0
017300101206    ***
017400101206     D H@SI            S             20A
017500101206     D H@CC            S              2A
017600101206     D H@GN            S              7A
017700101206     D H@CN            S             15A
017800101206     D H@C#            S              7A
017900130319     D H@C#3           S              7A
018000140313    ***
018100101213     D X@LAY           S              3A
018200101213     D X@ELR           S              7A
018300140313     D X@EFF           S              8A
018400140313     D X@TRM           S              8A
018500140313     D X@TIER          S              1A
018600140313    ***
018700101213     D M@CC            S              2A
018800101213     D M@CLASS         S              5A
018900101213     D M@PLAN          S              6A
019000101213     D M@PCP           S             40A
019100101213     D M@NPI           S              1A
019200101213     D M@PCPCI         S              1A
019300140313    ***
019400101213     D D@SFX           S              3A
019500101213     D D@ACCT          S              5A
019600101213     D D@PLAN          S              6A
019700101213     D D@CLM           S              3A
019800101213     D D@CBREXP        S              8A
019900101213     D D@CBREVT        S              8A
020000101213     D D@CBRLEN        S              2A
020100101213     D D@OOAI          S              1A
020200140313     D D@PCD           S              7A
020300140313    ***
020400101214     D @STEP           S              5A
020500140313    ***
020600140313     D E@SFX           S              3A
020700140313     D E@ACCT          S              5A
020800140313     D E@PLAN          S              6A
020900140313     D E@CLM           S              3A
021000140313     D E@PCP           S              7A
021100140313     D E@CBREXP        S              8A
021200140313     D E@CBREVT        S              8A
021300140313     D E@CBRLEN        S              2A
021400140313    ***
021500130315     D L@SFX           S              3A
021600130315     D L@ACCT          S              5A
021700130315     D L@PLAN          S              6A
021800130315     D L@CLM           S              3A
021900130315     D L@CBREXP        S              8A
022000130315     D L@CBREVT        S              8A
022100130315     D L@CBRLEN        S              2A
022200130315     D L@SALARY        S             20A
022300161109
022400161109     D effectiveDate   s              8    INZ('20161201')
022500161109     D effectiveDateD  s              8  0 INZ(20161201)
022600161109
022700160616      *=================================================================================
022800160616
022900110512     C                   EVAL      @STEP = 'PREP1'
023000160824
023100160824     C     CARR#CTL      CHAIN     CARXPTR
023200160824
023300160824     C     CARR#CTL      SETLL     CARACCR
023400160616
023500101026     C                   DOU       @STEP = 'LEAVE'
023600101026     C     @STEP         CASEQ     'PREP1'       $PREP1
023700101026     C     @STEP         CASEQ     'STEP1'       $STEP1
023800101026     C     @STEP         CASEQ     'STEP2'       $STEP2
023900101026     C     @STEP         CASEQ     'STEP3'       $STEP3
024000101026     C     @STEP         CASEQ     'PREP4'       $PREP4
024100101026     C     @STEP         CASEQ     'STEP4'       $STEP4
024200101026     C     @STEP         CASEQ     'PREP5'       $PREP5
024300101026     C     @STEP         CASEQ     'STEP5'       $STEP5
024400101214     C     @STEP         CASEQ     'PREP6'       $PREP6
024500101026     C     @STEP         CASEQ     'STEP6'       $STEP6
024600101214     C     @STEP         CASEQ     'PREP7'       $PREP7
024700101214     C     @STEP         CASEQ     'STEP7'       $STEP7
024800101214     C     @STEP         CASEQ     'STEP8'       $STEP8
024900101214     C     @STEP         CASEQ     'PREP9'       $PREP9
025000101214     C     @STEP         CASEQ     'STEP9'       $STEP9
025100101214     C     @STEP         CASEQ     'PREPA'       $PREPA
025200101214     C     @STEP         CASEQ     'STEPA'       $STEPA
025300101214     C     @STEP         CASEQ     'PREPB'       $PREPB
025400101214     C     @STEP         CASEQ     'STEPB'       $STEPB
025500130315     C     @STEP         CASEQ     'PREPC'       $PREPC
025600130315     C     @STEP         CASEQ     'STEPC'       $STEPC
025700101026     C                   ENDCS
025800101026     C                   ENDDO
025900160616
026000101206    ***  TRAILER RECORD
026600101026     C                   EVAL      *INLR = *ON
026700160616
026800160616      *============================================================================
026900160616
027000170525     C     $HEADR        BEGSR
027100160616
027200170525     C                   EVAL      D1 = @DATE
027300170525     C                   EVAL      D2 = @DATE
027400170525     C                   EVAL      T1 = @TIME
027500170525     C                   EVAL      C1 = @DATE + @TIME
027600160616
027700160315     C**** carr#ctl      CHAIN     CARACCR
027800160616
027900170525     C                   EVAL      H@SI = %TRIM(CACID1)                         SUBMITTER ID
028000110802     C                   EVAL      H@CC = %SUBST(CACID2:1:2)                    COMPANY CODE
028100110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
028200110802     C                   MOVEL(P)  CACID4        H@CN                           CUSTOMER NAME
028300110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
028400130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
028500160616
028800160315     C                   eval      firstTime = 'N'
028900160315
029000110802     C                   ENDSR
029100160616
029200160616      *============================================================================
029300110802     C     $PREP1        BEGSR
029400160616
029500160919     C     CARR#CTL      READE     CARACCR
029600160616
029700110512     C                   IF        %EOF(CARACCP)
029800110512     C                   EVAL      @STEP = 'LEAVE'
029900110512     C                   LEAVESR
030000110512     C                   ENDIF
030100160616
030200110513    *** HAS THE ACCOUNT BEEN SHUTOFF FOR EXPORT?
030300110512     C                   IF        CASTATUS <> 'Y'
030400110512     C                   LEAVESR
030500110512     C                   ENDIF
030600160314
030700160314     C                   if        cacida <> grouper
030800160314     C                   leavesr
030900160314     C                   endif
031000160315
031100110802    *** THESE FIELDS RESET FOR EACH SMALL GROUP READ
031200160919     C                   EVAL      H@SI = %TRIM(CACID1)                         SUBMITTER ID
031300160919     C                   EVAL      H@CC = %SUBST(CACID2:1:2)                    COMPANY CODE
031400110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
031500160919     C                   MOVEL(P)  CACID4        H@CN                           CUSTOMER NAME
031600110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
031700130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
031800160616
031900160919     C                   EVAL      D1 = @DATE
032000160919     C                   EVAL      D2 = @DATE
032100160919     C                   EVAL      T1 = @TIME
032200160919     C                   EVAL      C1 = @DATE + @TIME
032300160919
032400110512     C                   EVAL      KF@TRS = CATRST
032500110512     C                   EVAL      KF@SUB = CASUB#
032600110512     C                   EVAL      KF@ACC = CAACCT
032700160616
032800110512     C                   EXSR      $PLANLOAD
032900160616
033000160824     c                   if        flag = ' '
033100170525     C****               EXCEPT    HDRF
033200160824     c                   movel     'Y'           flag              1
033300160824     c                   endif
033400160824
033500101206     C                   EVAL      @STEP = 'STEP1'
033600160616
033700110512     C                   ENDSR
033800160616
033900160616      *============================================================================
034000160616
034100101206     C     $STEP1        BEGSR
034200160616
034300101206     C                   EVAL      KF@PLN = *BLANKS
034400101206     C                   EVAL      KF@TRM = 0
034500101206     C                   EVAL      KF@SSN = 0
034600101206     C                   EVAL      KF@SEQ = 0
034700160616
034800101206     C     KL#TSA        SETLL     MEMBR
034900160616
035000101206     C                   EVAL      @STEP = 'STEP2'
035100160616
035200101206     C                   ENDSR
035300160616
035400160616      *============================================================================
035500160616
035600101206     C     $STEP2        BEGSR
035700160616
035800101206     C     KL#TSA        READE     MEMBR
035900160616
036000101206     C                   IF        %EOF(MEMAC#1)
036100110512     C                   EVAL      @STEP = 'PREP1'
036200101206     C                   LEAVESR
036300101206     C                   ENDIF
036400160616
036500101206     C                   EVAL      KF@SSN = MBSSNO
036600101214     C                   MOVE      *ZEROS        KF@SEQ
036700120803     C                   EVAL      WRT@TYPE = 'MEMBER'
036800160616
036900101206     C     KL#MPLN       SETLL     MCOVR
037000160616
037100101206     C                   EXSR      $CLRSTG
037200160616
037300101206     C                   EVAL      @STEP = 'STEP3'
037400160616
037500101206     C                   ENDSR
037600160616
037700160616      *============================================================================
037800160616
037900101206     C     $STEP3        BEGSR
038000160616
038100101206     C     KL#MPLN       READE     MCOVR
038200160616
038300101206     C                   IF        %EOF(MCOVMPLN)
038400101206     C                   EVAL      @STEP = 'PREP4'
038500101206     C                   LEAVESR
038600101206     C                   ENDIF
038700160616
038800120803     C                   EVAL      KF@PLN = MCPLAN
038900160615     C     KL#TSAP       CHAIN     AEF04
039000160615     C                   IF        NOT %FOUND(AET004WF)
039100120803     C                   LEAVESR
039200120803     C                   ENDIF
039300160616
039400110512     C                   EVAL      @PLANIN = MCPLAN
039500111020     C                   EVAL      ENR@IN = MCOVTP
039600160616
039700110802     C                   EXSR      $QUIK
039800160616
039900110512     C                   EXSR      $PLANSRCH
040000160616
040100110512     C                   IF        PLN@CAT = *BLANKS
040200110512     C                   LEAVESR
040300110512     C                   ENDIF
040400160616
040500101206     C                   IF        CANDT = 0
040600101206     C                   EVAL      #CANCEL = 99999999
040700101206     C                   ELSE
040800101206     C                   EVAL      #CANCEL = CANDT
040900101206     C                   ENDIF
041000160616
041100130315    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL;
041200130315    *** LIF IS LIFE;
041300130315     C                   SELECT
041400160616
041500160616     C                   WHEN      PLN@CAT = 'LIFE'
041600160616     C                   IF        L#CNE > 0
041700160616     C                   IF        L@TRM(L#CNE) = 99999999
041800130315     C                   LEAVESR
041900130315     C                   ENDIF
042000130315     C                   ENDIF
042100160616     C                   ADD       1             L#CNE
042200160616     C                   EVAL      L@PLN(L#CNE) = MCPLAN
042300160616     C                   EVAL      L@ENR(L#CNE) = MCOVTP
042400160616     C                   EVAL      L@FRM(L#CNE) = ENRLDT
042500160616     C                   EVAL      L@TRM(L#CNE) = #CANCEL
042600160616
042700160616     C                   WHEN      PLN@CAT = 'DEN'
042800160616     C                   IF        D#CNE > 0
042900160616     C                   IF        D@TRM(D#CNE) = 99999999
043000130131     C                   LEAVESR
043100130131     C                   ENDIF
043200130131     C                   ENDIF
043300160616     C                   ADD       1             D#CNE
043400160616     C                   EVAL      D@PLN(D#CNE) = MCPLAN
043500160616     C                   EVAL      D@ENR(D#CNE) = MCOVTP
043600160616     C                   EVAL      D@FRM(D#CNE) = ENRLDT
043700160616     C                   EVAL      D@TRM(D#CNE) = #CANCEL
043800160616
043900130315     C                   OTHER
044000160616     C                   IF        M#CNE > 0
044100160616     C                   IF        M@TRM(M#CNE) = 99999999
044200130131     C                   LEAVESR
044300130131     C                   ENDIF
044400130131     C                   ENDIF
044500101206     C                   ADD       1             M#CNE
044600101206     C                   EVAL      M@PLN(M#CNE) = MCPLAN
044700101206     C                   EVAL      M@ENR(M#CNE) = MCOVTP
044800101206     C                   EVAL      M@FRM(M#CNE) = ENRLDT
044900101206     C                   EVAL      M@TRM(M#CNE) = #CANCEL
045000160616
045100160616     C                   ENDSL
045200160616
045300110512     C                   ENDSR
045400160616
045500160616      *============================================================================
045600160616
045700110802     C     $QUIK         BEGSR
045800160616
045900110805     C                   EVAL      @CCTRIN = *BLANKS
046000160616
046100160615     C     AE4MAP        CASEQ     '2TIER     '  $METH01
046200160615     C     AE4MAP        CASEQ     'ITOBJECTS '  $METH02
046300160615     C     AE4MAP        CASEQ     'NORULE    '  $METH03
046400160615     C     AE4MAP        CASEQ     'STATETIER '  $METH04
046500160615     C     AE4MAP        CASEQ     'TIERSTS   '  $METH05
046600160615     C     AE4MAP        CASEQ     'MAYOR     '  $METH06
046700160615     C     AE4MAP        CASEQ     'EMPSTS    '  $METH07
046800160615     C     AE4MAP        CASEQ     'JUSTSTATE '  $METH08
046900160615     C     AE4MAP        CASEQ     'JOHNLS    '  $METH09
047000160615     C     AE4MAP        CASEQ     'CREATIVE  '  $METH10
047100160615     C     AE4MAP        CASEQ     'INTEGRA   '  $METH11
047200160615     C     AE4MAP        CASEQ     'STSTATE   '  $METH12
047300160615     C     AE4MAP        CASEQ     'INTEGRA   '  $METH11
047400160615     C     AE4MAP        CASEQ     'STIERSTS  '  $METH13
047500120803     C                   ENDCS
047600160616
047700120803     C                   ENDSR
047800160616
047900160616      *============================================================================
048000160616
048100160616      * 2 TIER = AETNA HAS TWO TIERS, IND AND FAM
048200160616      *  MEMBERS HAVE 'TIN' CONVERTED TO 'IND' AND NON-'TIN' CONVERTED TO 'FAM'
048300160616      *  DEPENDENTS HAVE 'FAM' ONLY
048400160616      *
048500160616      * IND, FAM
048600160616
048700160616      *============================================================================
048800160616
048900120803     C     $METH01       BEGSR
049000160616
049100120803     C                   IF        WRT@TYPE = 'MEMBER'
049200160616
049300120803     C                   IF        ENR@IN = 'TIN'
049400120803     C                   EVAL      @CCTRIN = 'IND'
049500120803     C                   ELSE
049600120803     C                   EVAL      @CCTRIN = 'FAM'
049700120803     C                   ENDIF
049800160616
049900120803     C                   ENDIF
050000160616
050100120803     C                   IF        WRT@TYPE = 'DEPEND'
050200160616
050300120803     C                   EVAL      @CCTRIN = 'FAM'
050400160616
050500120803     C                   ENDIF
050600160616
050700120803     C                   ENDSR
050800160616
050900160616      *============================================================================
051000160616
051100160616      * ITOBJECTS = IF YOU ARE NOT 'VA' OR 'OH' STATE CODES, YOU ARE 'XX'
051200160616
051300160616      * VA, OH, XX
051400160616
051500160616      *============================================================================
051600160616
051700120803     C     $METH02       BEGSR
051800160616
051900120803     C                   IF        STATE <> 'VA' AND STATE <> 'OH'
052000120803     C                   EVAL      @CCTRIN = 'XX '
052100120803     C                   ELSE
052200120803     C                   EVAL      @CCTRIN = STATE
052300120803     C                   ENDIF
052400160616
052500120803     C                   ENDSR
052600160616
052700160616      *============================================================================
052800160616      * NORULE = NUFF SAID
052900160616      *============================================================================
053000160616
053100120803     C     $METH03       BEGSR
053200160616
053300120803     C                   EVAL      @CCTRIN = *BLANKS
053400160616
053500120803     C                   ENDSR
053600160616
053700160616      *============================================================================
053800160616      * STATETIER
053900160616      *  START WITH STATE CODE
054000160616      *  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
054100160616      *  DEPENDENTS HAVE 'F' ONLY
054200160616      * MDI, MDF, ETC...
054300160616      *============================================================================
054400160616
054500120803     C     $METH04       BEGSR
054600160616
054700120803     C                   EVAL      @CCTRIN = STATE
054800160616
054900120803     C                   IF        WRT@TYPE = 'MEMBER'
055000120803     C                   IF        ENR@IN = 'TIN'
055100120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
055200120803     C                   ELSE
055300120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
055400120803     C                   ENDIF
055500120803     C                   ENDIF
055600160616
055700120803     C                   IF        WRT@TYPE = 'DEPEND'
055800120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
055900120803     C                   ENDIF
056000160616
056100120803     C                   ENDSR
056200160616
056300160616      *============================================================================
056400160616      * TIERSTS
056500160616      *  START WITH EMPLOYMENT STATUS, ACTIVE IS 'ACT' AND COBRA IS 'COB'
056600160616      *  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
056700160616      *  DEPENDENTS HAVE 'F' ONLY
056800160616      *
056900160616      * ACI, ACF, COI, COF
057000160616      *============================================================================
057100160616
057200120803     C     $METH05       BEGSR
057300160616
057400120803     C                   IF        EMPST =  'C'
057500120803     C                   EVAL      @CCTRIN = 'COB'
057600120803     C                   ELSE
057700170120     C                   EVAL      @CCTRIN = 'ACT'
057800120803     C                   ENDIF
057900160616
058000120803     C                   IF        ENR@IN = 'TIN'
058100120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
058200120803     C                   ELSE
058300120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
058400120803     C                   ENDIF
058500160616
058600120803     C                   ENDSR
058700160616
058800160616      *============================================================================
058900160616      * MAYOR
059000160616      *  WELL, FOR THE PLAN 'DAAU' IF THE STATE IS 'WV' THEN PLACE TIER STATUS SUFFIX
059100160616      *       BY TYPE OF PEEP; FOR OTHER STATES, USE A SIMPLE TIER CHECK.
059200160616      *
059300160616      *  WVI, WVF, IND, FAM
059400160616      *
059500160616      *  NOW, FOR THE PLAN 'DAAT' IF THE STATE IS 'WV' THEN PLACE EMPLOYMENT STATUS SUFFIX
059600160616      *       BY TYPE OF PEEP; FOR OTHER STATES, EMPLOYMENT STATUS AND TIER.
059700160616      *
059800160616      *  WVI, WVF, CBI, CBF, ACI, ACF
059900160616      *============================================================================
060000160616
060100120803     C     $METH06       BEGSR
060200160616
060300160616     C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'MEMBER'
060400160616
060500160616     C                   IF        STATE = 'WV'
060600160616
060700160616     C                   IF        ENR@IN = 'TIN'
060800120803     C                   EVAL      @CCTRIN = 'WVI'
060900160616     C                   ELSE
061000120803     C                   EVAL      @CCTRIN = 'WVF'
061100160616     C                   ENDIF
061200160616
061300160616     C                   ELSE
061400160616
061500160616     C                   IF        ENR@IN = 'TIN'
061600120803     C                   EVAL      @CCTRIN = 'IND'
061700160616     C                   ELSE
061800120803     C                   EVAL      @CCTRIN = 'FAM'
061900160616     C                   ENDIF
062000160616
062100160616     C                   ENDIF
062200160616
062300120803     C                   LEAVESR
062400160616     C                   ENDIF
062500160616
062600120803     C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'DEPEND'
062700160616
062800120803     C                   IF        STATE = 'WV'
062900120803     C                   EVAL      @CCTRIN = 'WVF'
063000120803     C                   ELSE
063100120803     C                   EVAL      @CCTRIN = 'FAM'
063200120803     C                   ENDIF
063300160616
063400120803     C                   LEAVESR
063500120803     C                   ENDIF
063600160616
063700160616     C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'MEMBER'
063800160616
063900160616     C                   IF        STATE = 'WV'
064000160616
064100160616     C                   IF        ENR@IN = 'TIN'
064200120803     C                   EVAL      @CCTRIN = 'WVI'
064300160616     C                   ELSE
064400120803     C                   EVAL      @CCTRIN = 'WVF'
064500160616     C                   ENDIF
064600160616
064700160616     C                   ELSE
064800160616
064900160616     C                   IF        EMPST =  'C'
065000120803     C                   EVAL      @CCTRIN = 'CB '
065100160616     C                   ELSE
065200120803     C                   EVAL      @CCTRIN = 'AC '
065300160616     C                   ENDIF
065400160616     C                   IF        ENR@IN = 'TIN'
065500120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
065600160616     C                   ELSE
065700120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
065800160616     C                   ENDIF
065900160616
066000160616     C                   ENDIF
066100160616
066200120803     C                   LEAVESR
066300160616     C                   ENDIF
066400160616
066500120803     C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'DEPEND'
066600160616
066700120803     C                   IF        STATE = 'WV'
066800120803     C                   EVAL      @CCTRIN = 'WVF'
066900120803     C                   ELSE
067000120803     C                   IF        EMPST =  'C'
067100120803     C                   EVAL      @CCTRIN = 'CBF'
067200120803     C                   ELSE
067300120803     C                   EVAL      @CCTRIN = 'ACF'
067400120803     C                   ENDIF
067500120803     C                   ENDIF
067600160616
067700120803     C                   ENDIF
067800160616
067900120803     C                   ENDSR
068000160616
068100160616      *============================================================================
068200160616      * EMPSTS
068300160616      *   PRETTY STRAIGHT FORWARDED
068400160616      *============================================================================
068500160616
068600120803     C     $METH07       BEGSR
068700160616
068800120803     C                   IF        EMPST =  'C'
068900120803     C                   EVAL      @CCTRIN = 'COB'
069000120803     C                   ELSE
069100120803     C                   EVAL      @CCTRIN = 'ACT'
069200120803     C                   ENDIF
069300160616
069400120803     C                   ENDSR
069500160616
069600160616      *============================================================================
069700160616      * JUSTSTATE
069800160616      *   PRETTY STRAIGHT FORWARDED
069900160616      *============================================================================
070000160616
070100120803     C     $METH08       BEGSR
070200160616
070300120803     C                   EVAL      @CCTRIN = STATE
070400160616
070500120803     C                   ENDSR
070600160616      *============================================================================
070700160616      * JOHNLS
070800160616      *   IF STATE IS NOT MARYLAND, DEFAULT TO 'XX', ELSE USE 'MD'; THEN APPLY TIER.
070900160616      * MDI, MDF, XXI, XXF
071000160616      *============================================================================
071100160616
071200120803     C     $METH09       BEGSR
071300160616
071400120803     C                   IF        WRT@TYPE = 'MEMBER'
071500120803     C                   IF        STATE = 'MD'
071600120803     C                   EVAL      @CCTRIN = 'MD'
071700120803     C                   ELSE
071800120803     C                   EVAL      @CCTRIN = 'XX'
071900120803     C                   ENDIF
072000120803     C                   IF        ENR@IN = 'TIN'
072100120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
072200120803     C                   ELSE
072300120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
072400120803     C                   ENDIF
072500120803     C                   ENDIF
072600160616
072700120803     C                   IF        WRT@TYPE = 'DEPEND'
072800120803     C                   IF        STATE = 'MD'
072900120803     C                   EVAL      @CCTRIN = 'MDF'
073000120803     C                   ELSE
073100120803     C                   EVAL      @CCTRIN = 'XXF'
073200120803     C                   ENDIF
073300120803     C                   ENDIF
073400160616
073500120803     C                   ENDSR
073600160616
073700160616      *============================================================================
073800160616      * CREATIVE
073900160616      *   IF STATE IS NOT 'MD' OR 'OK', DEFAULT TO '**'.
074000160616      * MD, OK, **
074100160616      *============================================================================
074200160616
074300120803     C     $METH10       BEGSR
074400160616
074500120803     C                   IF        STATE <> 'MD' AND STATE <> 'OK'
074600120803     C                   EVAL      @CCTRIN = '** '
074700120803     C                   ELSE
074800120803     C                   EVAL      @CCTRIN = STATE
074900120803     C                   ENDIF
075000160616
075100120803     C                   ENDSR
075200160616
075300160616      *============================================================================
075400160616      * INTEGRA = USE 'TN' FOR TENNESSEE, OTHER STATES ARE 'XX'
075500160616      *  TN, XX
075600160616      *============================================================================
075700160616
075800120803     C     $METH11       BEGSR
075900160616
076000121113     C                   SELECT
076100121113     C                   WHEN      STATE = 'TN'
076200121113     C                   EVAL      @CCTRIN = STATE                              TENNESSEE ONLY
076300121113     C                   WHEN      STATE = 'FL'
076400121113     C                   EVAL      @CCTRIN = STATE                              FLORIDA ONLY
076500121113     C                   OTHER
076600121113     C                   EVAL      @CCTRIN = 'XX '                              SITUS
076700160616     C                   ENDSL
076800160616
076900120803     C                   ENDSR
077000160616
077100160616      *============================================================================
077200160616      * STSTATE = STATE CODE WITH EMPLOYEE STATUS
077300160616      *  MDA, MDC, ETC...
077400160616      *============================================================================
077500160616
077600120803     C     $METH12       BEGSR
077700160616
077800120803     C                   EVAL      @CCTRIN = STATE + EMPST
077900160616
078000120803     C                   ENDSR
078100160616
078200160616      *============================================================================
078300160616      * STIERSTS = STATE CODE WITH TIER WITH EMPLOYEE STATUS
078400160616      *    ACTIVE [#CALC = 0]      COBRA [#CALC = 5]
078500160616      *    IND [+1 TO #CALC ]      NON-IND COVERAGE [+2 TO CALC]
078600160616      *    EACH STATE PUT AT END, GIVING FAM MARYLAND ACTIVE A VALUE OF 2MD
078700160616      *                                  IND WEST VIRGINIA COBRA A VALUE OF 6WV
078800160616      *============================================================================
078900160616
079000130123     C     $METH13       BEGSR
079100160616
079200130123     C                   SELECT
079300130123     C                   WHEN      EMPST =  'C'
079400130123     C                   Z-ADD     5             #CALC
079500130123     C                   OTHER
079600130123     C                   MOVE      *ZEROS        #CALC             1 0
079700130123     C                   ENDSL
079800160616
079900130123     C                   SELECT
080000130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN = 'TIN'
080100130123     C                   ADD       1             #CALC
080200130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN <> 'TIN'
080300130123     C                   ADD       2             #CALC
080400130123     C                   WHEN      WRT@TYPE = 'DEPEND'
080500130123     C                   ADD       2             #CALC
080600130123     C                   ENDSL
080700160616
080800130123     C                   EVAL      @CCTRIN = %EDITC(#CALC:'X') + STATE
080900160616
081000130123     C                   ENDSR
081100170405
081200170405      *============================================================================
081300160616
081400120409     C     $PREP4        BEGSR
081500160616
081600130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
081700101206     C                   EVAL      @STEP = 'STEP2'
081800101206     C                   LEAVESR
081900101206     C                   ENDIF
082000160616
082100130520     C                   EVAL      @STEP = 'STEP4'
082200130315     C                   EVAL      TERM_LIF = NO
082300101210     C                   EVAL      TERM_DEN = NO
082400101210     C                   EVAL      TERM_MED = NO
082500160616
082600130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
082700130520     C                   IF        L@TRM(L#CNE) <> 99999999
082800130520     C                   EXSR      $CHKHEM
082900130520     C                   ENDIF
083000130520     C                   LEAVESR
083100130520     C                   ENDIF
083200160616
083300130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
083400130520     C                   IF        M@TRM(M#CNE) <> 99999999
083500130520     C                   EXSR      $CHKHEM
083600130520     C                   ENDIF
083700130520     C                   LEAVESR
083800130520     C                   ENDIF
083900160616
084000130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
084100130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
084200130520     C                              M@TRM(M#CNE) <> 99999999)
084300130520     C                   EXSR      $CHKHEM
084400130520     C                   ENDIF
084500130520     C                   LEAVESR
084600130520     C                   ENDIF
084700160616
084800130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
084900130520     C                   IF        D@TRM(D#CNE) <> 99999999
085000130520     C                   EXSR      $CHKHEM
085100130520     C                   ENDIF
085200130520     C                   LEAVESR
085300130520     C                   ENDIF
085400160616
085500130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
085600130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
085700130520     C                              D@TRM(D#CNE) <> 99999999)
085800130520     C                   EXSR      $CHKHEM
085900130520     C                   ENDIF
086000130520     C                   LEAVESR
086100130520     C                   ENDIF
086200160616
086300130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
086400130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
086500130520     C                              M@TRM(M#CNE) <> 99999999)
086600130520     C                   EXSR      $CHKHEM
086700130520     C                   ENDIF
086800130520     C                   LEAVESR
086900130520     C                   ENDIF
087000160616
087100130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
087200130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
087300130520     C                              L@TRM(L#CNE) <> 99999999 OR
087400130520     C                              M@TRM(M#CNE) <> 99999999)
087500130520     C                   EXSR      $CHKHEM
087600130520     C                   ENDIF
087700130520     C                   LEAVESR
087800130520     C                   ENDIF
087900160616
088000101214     C                   ENDSR
088100160616
088200160616      *============================================================================
088300160616      * GENERATE MEMBER RECORD
088400160616      *============================================================================
088500160616
088600101210     C     $STEP4        BEGSR
088700160616
088800130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
088900101214     C                   EVAL      @STEP = 'STEP2'
089000101214     C                   LEAVESR
089100101214     C                   ENDIF
089200160616
089300110513     C                   EVAL      WRT@TYPE = 'MEMBER'
089400160616
089500130315     C                   EVAL      L@MBREFF = 0
089600110725     C                   EVAL      D@MBREFF = 0
089700110725     C                   EVAL      M@MBREFF = 0
089800160616
089900101210     C                   EVAL      @SS1   = %EDITC(MBSSNO:'X')
090000101210     C                   EVAL      @SS2   = @SS1
090100101210     C                   MOVEL(P)  MLNAME        @LN
090200101210     C                   MOVEL(P)  MFNAME        @FN
090300101210     C                   EVAL      @MI    = MMI
090400101210     C                   EVAL      @REL   = '01'
090500101210     C                   EVAL      @SEX   = SEX
090600101210     C                   EVAL      @DOB   = %EDITC(BIRTH:'X')
090700101210     C                   IF        COB = 'Y'
090800101210     C                   EVAL      @COB   = 'Y'
090900101210     C                   EVAL      @COBC  = 'OT'
091000101210     C                   EVAL      @COBN  = MCOBPN
091100101210     C                   ENDIF
091200101210     C                   EVAL      @AD1   = %TRIM(ADDR1)
091300101210     C                   EVAL      @AD2   = %TRIM(ADDR2)
091400101210     C                   EVAL      @CTY   = %TRIM(CITY)
091500101210     C                   EVAL      @ST    = STATE
091600101210     C                   MOVE      *BLANKS       @9                9
091700101210     C                   EVAL      @9   = %EDITC(ZIP:'X')
091800101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
091900101210     C                   EVAL      @PHN   = %EDITC(AREA:'X') +
092000101210     C                                      %EDITC(PHONE:'X')
092100160616
092200101210     C                   SELECT
092300101210     C                   WHEN      EMPST = 'A'
092400101210     C                   EVAL      @EMPST = 'AC'
092500101210     C                   WHEN      EMPST = 'C'
092600101210     C                   EVAL      @EMPST = 'CO'
092700101210     C                   WHEN      EMPST = 'R'
092800101210     C                   EVAL      @EMPST = 'RT'
092900101210     C                   ENDSL
093000160616
093100101210     C                   EVAL      @HIRE  = %EDITC(EMPDT:'X')
093200160616
093300141211     C                   SETOFF                                       888987
093400141120        IF KF@TRS = 770 AND KF@SUB = 004 AND KF@ACC = 0037 AND
093500141120          STATE = 'VT';
093600141120           *IN89 = *ON;
093700141120        ENDIF;
093800161109
093900161109       // if cobra and effective date > 12/01/2016...
094000170317       //if empst = 'C';
094100170317       // if qedt >= effectiveDateD;
094200170317       //  @empst = 'AC';
094300170317       // endif;
094400170317       //endif;
094500161109
094600101210     C                   EXCEPT    MBRF
094700101214     C                   ADD       1             C#RECCNT
094800160616
094900101213     C                   EVAL      @STEP = 'PREP5'
095000160616
095100101210     C                   ENDSR
095200160616
095300160616      *============================================================================
095400160616      * MEDICAL
095500160616      *============================================================================
095600160616
095700101214     C     $PREP5        BEGSR
095800160616
095900101214     C                   IF        M#CNE = 0
096000110513     C                   EVAL      @STEP = 'PREP6'
096100101214     C                   LEAVESR
096200101214     C                   ENDIF
096300160616
096400101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
096500130315     C                   EVAL      KF@ENR = M@ENR(M#CNE)
096600160616
096700101214     C                   IF        TERM_MED = YES
096701240130       KF#TRM = M@TRM(M#CNE);
096800101214     C                   EXSR      $WRTERM
096900101214     C                   ENDIF
097000160616
097100110512     C                   EVAL      @PLANIN = KF@PLN
097200160616
097300160615     C     KL#TSAP       CHAIN     AEF04
097400160615     C                   IF        NOT %FOUND(AET004WF)
097500120803     C                   LEAVESR
097600120803     C                   ENDIF
097700160616
097800111020     C                   EVAL      ENR@IN = M@ENR(M#CNE)
097900160616
098000110802     C                   EXSR      $QUIK
098100160616
098200110512     C                   EXSR      $PLANSRCH
098300160616
098400110512     C                   IF        PLN@CAT = *BLANKS
098500101214     C                   SETON                                        H1
098600101214     C                   ENDIF
098700160616
098800110513     C                   EVAL      @STEP = 'STEP5'
098900110725     C                   EVAL      #XSX = M@FRM(M#CNE)
099000110725     C                   EVAL      M@MBREFF = #XSX
099100160616
099200101214     C                   ENDSR
099300160616
099400160616      *============================================================================
099500160616
099600101214     C     $STEP5        BEGSR
099700160616
099800110513     C                   IF        CPCID1 = 'MEA'
099900110513     C                   EXSR      $MEAWRT
100000110513     C                   ELSE
100100110513     C                   EXSR      $HMOWRT
100200110513     C                   ENDIF
100300160616
100400101214     C                   ADD       1             C#RECCNT
100500101214     C                   ADD       1             B#RECCNT
100600160616
100700110513     C                   EVAL      @STEP = 'PREP6'
100800160616
100900110513     C                   ENDSR
101000160616
101100160616      *============================================================================
101200160616      * DENTAL
101300160616      *============================================================================
101400160616
101500101214     C     $PREP6        BEGSR
101600160616
101700160616     C                   IF        D#CNE = 0
101800160616     C                   EVAL      @STEP = 'PREPC'
101900160616     C                   LEAVESR
102000160616     C                   ENDIF
102100160616
102200160616     C                   EVAL      KF@PLN = D@PLN(D#CNE)
102300160616     C                   EVAL      KF@ENR = D@ENR(D#CNE)
102400160616
102500160615     C     KL#TSAP       CHAIN     AEF04
102600160615     C                   IF        NOT %FOUND(AET004WF)
102700120803     C                   LEAVESR
102800120803     C                   ENDIF
102900160616
103000160616     C                   IF        TERM_DEN = YES
103001240130       KF#TRM = D@TRM(D#CNE);
103100160616     C                   EXSR      $WRTERM
103200160616     C                   ENDIF
103300160616
103400110513     C                   EVAL      @PLANIN = KF@PLN
103500111020     C                   EVAL      ENR@IN = D@ENR(D#CNE)
103600160616
103700111011     C                   EXSR      $QUIK
103800160616
103900110513     C                   EXSR      $PLANSRCH
104000160616
104100110513     C                   IF        PLN@CAT = *BLANKS
104200110513     C                   SETON                                        H2
104300110513     C                   ENDIF
104400160616
104500160616     C                   EVAL      @STEP = 'STEP6'
104600110725     C                   EVAL      #XSX = D@FRM(D#CNE)
104700110725     C                   EVAL      D@MBREFF = #XSX
104800160616
104900101213     C                   ENDSR
105000160616
105100160616      *============================================================================
105200160616      * DENTAL FORMAT
105300160616      *============================================================================
105400160616
105500160616     C     $STEP6        BEGSR
105600110513     C                   EXSR      $DENWRT
105700160616
105800160616     C                   ADD       1             C#RECCNT
105900160616     C                   ADD       1             B#RECCNT
106000160616
106100160616     C                   EVAL      @STEP = 'PREPC'
106200160616
106300160616     C                   ENDSR
106400160616
106500160616      *============================================================================
106600160616      * LIFE AND AD&D PLANS FOR MEMBER
106700160616      *============================================================================
106800160616
106900130315     C     $PREPC        BEGSR
107000160616
107100160616     C                   IF        L#CNE = 0
107200160616     C                   EVAL      @STEP = 'PREP7'
107300160616     C                   LEAVESR
107400160616     C                   ENDIF
107500160616
107600160616     C                   EVAL      KF#TRM = L@TRM(L#CNE)
107700160616     C                   EVAL      KF@PLN = L@PLN(L#CNE)
107800130315     C                   EVAL      KF@ENR = L@ENR(L#CNE)
107900160616
108000160615     C     KL#TSAP       CHAIN     AEF04
108100160615     C                   IF        NOT %FOUND(AET004WF)
108200130315     C                   LEAVESR
108300130315     C                   ENDIF
108400160616
108500160616     C                   IF        TERM_LIF = YES
108501240130       KF#TRM = L@TRM(L#CNE);
108600160616     C                   EXSR      $WRTERM
108700160616     C                   ENDIF
108800160616
108900130315     C                   EVAL      @PLANIN = KF@PLN
109000130315     C                   EVAL      ENR@IN = L@ENR(L#CNE)
109100160616
109200130315     C                   EXSR      $QUIK
109300160616
109400130315     C                   EXSR      $PLANSRCH
109500160616
109600130315     C                   IF        PLN@CAT = *BLANKS
109700130315     C                   SETON                                        H2
109800130315     C                   ENDIF
109900160616
110000160616     C                   EVAL      @STEP = 'STEPC'
110100130315     C                   EVAL      #XSX = L@FRM(L#CNE)
110200130315     C                   EVAL      L@MBREFF = #XSX
110300160616
110400130315     C                   ENDSR
110500160616
110600160616      *============================================================================
110700160616      * LIFE FORMAT
110800160616      *============================================================================
110900160616
111000160616     C     $STEPC        BEGSR
111100160616
111200130315     C                   EXSR      $LIFWRT
111300160616
111400160616     C                   ADD       1             C#RECCNT
111500160616     C                   ADD       1             B#RECCNT
111600160616
111700160616     C                   EVAL      @STEP = 'PREP7'
111800160616
111900160616     C                   ENDSR
112000160616
112100160616      *============================================================================
112200160616
112300130315     C     $LIFWRT       BEGSR
112400160616
112500160616     C                   EVAL      X@LAY = CPCID1                               LAYOUT
112600160616     C                   EVAL      X@ELR = CPCID2                               ELR
112700160616     C                   EVAL      L@SFX = CPCID3                               SUFFIX
112800160616     C                   EVAL      L@ACCT = CPCID4                              ACCOUNT
112900160616     C                   EVAL      L@PLAN = CPCID5                              PLAN
113000160616     C                   EVAL      L@CLM = CPCID6                               CLAIM OFFICE
113100160616
113200160616     C                   EVAL      #XSX = L@FRM(L#CNE)
113300130315     C                   MOVE      #XSX          X@EFF
113400160616
113500160616     C                   EVAL      #XSX = L@TRM(L#CNE)
113600160616     C                   IF        #XSX = 0 OR #XSX = 99999999
113700160616     C                   MOVE      *BLANKS       X@TRM
113800160616     C                   ELSE
113900160616     C                   MOVE      #XSX          X@TRM
114000160616     C                   ENDIF
114100160616
114200140313     C                   MOVE      *BLANKS       L@CBREXP
114300140313     C                   MOVE      *BLANKS       L@CBREVT
114400140313     C                   MOVE      *BLANKS       L@CBRLEN
114500160616
114600160616     C                   IF        EMPST = 'C' AND
114700130923     C                             CEXPDT > 0
114800160616     C                   MOVE      CEXPDT        L@CBREXP
114900160616     C                   MOVE      QEDT          L@CBREVT
115000160616     C                   MOVE      CEXPDT        #MINUEND
115100160616     C                   MOVE      QEDT          #SUBTRAEND
115200160616     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
115300160616     C                   Z-ADD     #DIFFRNC      #2S0
115400160616     C                   MOVE      #2S0          L@CBRLEN
115500160616     C                   ENDIF
115600160616
115700130315     C                   EVAL      L@SALARY = %EDITC(SALARY:'4')
115800160616
115900160616     C                   EXCEPT    LIFF
116000160616
116100160616     C                   ENDSR
116200160616
116300160616      *============================================================================
116400160616
116500101214     C     $PREP7        BEGSR
116600160616
116700101214     C     KF@SSN        CHAIN     DEPENR
116800101214     C                   IF        NOT %FOUND(DEPNDC)
116900101214     C                   EVAL      @STEP = 'STEP2'
117000101214     C                   LEAVESR
117100101214     C                   ENDIF
117200160616
117300101214     C     KF@SSN        SETLL     DEPENR
117400160616
117500101214     C                   EVAL      @STEP = 'STEP7'
117600160616
117700101214     C                   ENDSR
117800160616
117900160616      *============================================================================
118000160616
118100101214     C     $STEP7        BEGSR
118200160616
118300101214     C     KF@SSN        READE     DEPENR
118400160616
118500101214     C                   IF        %EOF(DEPNDC)
118600101214     C                   EVAL      @STEP = 'STEP2'
118700101214     C                   LEAVESR
118800101214     C                   ENDIF
118900160616
119000101214     C                   EVAL      KF@SEQ = DPSEQ#
119100120803     C                   EVAL      WRT@TYPE = 'DEPEND'
119200160616
119300101214     C     KL#DCV        CHAIN     DCOVR
119400101214     C                   IF        NOT %FOUND(DCOVA)
119500101214     C                   LEAVESR
119600101214     C                   ENDIF
119700160616
119800101214     C                   EXSR      $CLRDCV
119900101214     C     KL#DCV        SETLL     DCOVR
120000160616
120100101214     C                   EVAL      @STEP = 'STEP8'
120200160616
120300101214     C                   ENDSR
120400160616
120500160616      *============================================================================
120600160616
120700101214     C     $STEP8        BEGSR
120800160616
120900101214     C     KL#DCV        READE     DCOVR
121000160616
121100101214     C                   IF        %EOF(DCOVA)
121200101214     C                   EVAL      @STEP = 'PREP9'
121300101214     C                   LEAVESR
121400101214     C                   ENDIF
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
141400161109       // if cobra and effective date > 12/01/2016...
141500170317       //if empst = 'C';
141600170317       // if qedt >= effectiveDateD;
141700170317       //  @empst = 'AC';
141800170317       // endif;
141900170317       //endif;
142000161109
142100101210     C                   EXCEPT    MBRF
142200101214     C                   ADD       1             C#RECCNT
142300160616
142400101214     C                   EVAL      @STEP = 'PREPA'
142500160616
142600101210     C                   ENDSR
142700160616
142800160616      *============================================================================
142900160616
143000101214     C     $PREPA        BEGSR
143100160616
143200101214     C                   IF        M#CNE = 0
143300101214     C                   EVAL      @STEP = 'PREPB'
143400101214     C                   LEAVESR
143500101214     C                   ENDIF
143600160616
143700101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
143800160615     C     KL#TSAP       CHAIN     AEF04
143900160615     C                   IF        NOT %FOUND(AET004WF)
144000120803     C                   LEAVESR
144100120803     C                   ENDIF
144200160616
144300101214     C                   IF        TERM_MED = YES
144301240130       KF#TRM = M@TRM(M#CNE);
144400101214     C                   EXSR      $WRTERM
144500101214     C                   ENDIF
144600160616
144700110513     C                   EVAL      @PLANIN = KF@PLN
144800160616
144900110802     C                   EXSR      $QUIKD
145000160616
145100110513     C                   EXSR      $PLANSRCH
145200160616
145300110513     C                   IF        PLN@CAT = *BLANKS
145400110513     C                   SETON                                        H2
145500110513     C                   ENDIF
145600160616
145700110513     C                   EVAL      @STEP = 'STEPA'
145800160616
145900101214     C                   ENDSR
146000160616
146100160616      *============================================================================
146200160616
146300101214     C     $STEPA        BEGSR
146400160616
146500110513     C                   IF        CPCID1 = 'MEA'
146600110513     C                   EXSR      $MEAWRT
146700110513     C                   ELSE
146800110513     C                   EXSR      $HMOWRT
146900110513     C                   ENDIF
147000160616
147100110513     C                   ADD       1             C#RECCNT
147200110513     C                   ADD       1             B#RECCNT
147300160616
147400110513     C                   EVAL      @STEP = 'PREPB'
147500160616
147600110513     C                   ENDSR
147700160616
147800160616      *============================================================================
147900160616
148000101214     C     $PREPB        BEGSR
148100160616
148200160616     C                   IF        D#CNE = 0
148300160616     C                   EVAL      @STEP = 'STEP7'
148400160616     C                   LEAVESR
148500160616     C                   ENDIF
148600160616
148700160616     C                   EVAL      KF@PLN = D@PLN(D#CNE)
148800160615     C     KL#TSAP       CHAIN     AEF04
148900160615     C                   IF        NOT %FOUND(AET004WF)
149000120803     C                   LEAVESR
149100120803     C                   ENDIF
149200160616
149300160616     C                   IF        TERM_DEN = YES
149301240130       KF#TRM = D@TRM(D#CNE);
149400160616     C                   EXSR      $WRTERM
149500160616     C                   ENDIF
149600160616
149700110513     C                   EVAL      @PLANIN = KF@PLN
149800160616
149900110802     C                   EXSR      $QUIKD
150000160616
150100110513     C                   EXSR      $PLANSRCH
150200160616
150300110513     C                   IF        PLN@CAT = *BLANKS
150400110513     C                   SETON                                        H2
150500110513     C                   ENDIF
150600160616
150700101214     C                   EVAL      @STEP = 'STEPB'
150800160616
150900101214     C                   ENDSR
151000160616
151100160616      *============================================================================
151200160616
151300160616     C     $STEPB        BEGSR
151400160616
151500110513     C                   EXSR      $DENWRT
151600160616
151700160616     C                   ADD       1             C#RECCNT
151800160616     C                   ADD       1             B#RECCNT
151900160616
152000160616     C                   EVAL      @STEP = 'STEP7'
152100160616
152200160616     C                   ENDSR
152300160616
152400160616      *============================================================================
152500160616
152600110512     C     *INZSR        BEGSR
152700160616
152800160314     C     *entry        plist
152900160314     C                   parm                    CARR#CTL
153000160314     C                   parm                    grouper
153100160314
153200110512     C     KL#ACCTL      KLIST
153300160919     C                   KFLD                    CARR#CTL
153400110512     C                   KFLD                    KF@TRS
153500110512     C                   KFLD                    KF@SUB
153600110512     C                   KFLD                    KF@ACC
153700160616
153800140313     C     KL#SQPCD      KLIST
153900140313     C                   KFLD                    KF@SSN
154000140313     C                   KFLD                    KF@SEQ
154100140313     C                   KFLD                    KF@SPCD
154200160616
154300120803     C     KL#TSAP       KLIST
154400120803     C                   KFLD                    KF@TRS
154500120803     C                   KFLD                    KF@SUB
154600120803     C                   KFLD                    KF@ACC
154700120803     C                   KFLD                    KF@PLN
154800160616
154900110512     C     KL#TSA        KLIST
155000110512     C                   KFLD                    KF@TRS
155100110512     C                   KFLD                    KF@SUB
155200110512     C                   KFLD                    KF@ACC
155300160616
155400110512     C     KL#MPLN       KLIST
155500110512     C                   KFLD                    KF@SSN
155600110512     C                   KFLD                    KF@SEQ
155700110512     C                   KFLD                    KF@TRS
155800110512     C                   KFLD                    KF@SUB
155900110512     C                   KFLD                    KF@ACC
156000160616
156100110512     C     KL#CPLN       KLIST
156200160919     C                   KFLD                    CARR#CTL
156300110512     C                   KFLD                    KF@TRS
156400110512     C                   KFLD                    KF@SUB
156500110512     C                   KFLD                    KF@ACC
156600110512     C                   KFLD                    KF@CCTR
156700110512     C                   KFLD                    KF@PLN
156800160616
156900110512     C     KL#DCV        KLIST
157000110512     C                   KFLD                    KF@SSN
157100110512     C                   KFLD                    KF@SEQ
157200160616
157300110512     C     KL#MTR        KLIST
157400110512     C                   KFLD                    KF@SSN
157500110512     C                   KFLD                    KF@SEQ
157600110512     C                   KFLD                    KF#TRM
157700110512     C                   KFLD                    KF@PLN
157800110512     C                   KFLD                    KF@ENR
157900110512     C                   KFLD                    KF@TRS
158000110512     C                   KFLD                    KF@SUB
158100110512     C                   KFLD                    KF@ACC
158200160616
158300110512     C     KL#PCP        KLIST
158400110512     C                   KFLD                    KF@SSN
158500110512     C                   KFLD                    KF@SEQ
158600160616
158700110512     C                   EVAL      #ISO = %DATE
158800110512     C                   MOVE      #ISO          #TODAY            8 0
158900110512     C                   EVAL      #IST = %TIME
159000110512     C                   MOVE      #ISO          #XSX
159100110512     C                   MOVE      #XSX          @DATE
159200110512     C                   MOVE      #IST          #XST
159300110512     C                   MOVE      #XST          @TIME
159400160616
159500110512     C                   ENDSR
159600160616
159700160616      *============================================================================
159800160616      * PLANS LOADED BY ACCOUNT
159900160616      *============================================================================
160000160616
160100110513     C     $PLANLOAD     BEGSR
160200160616
160300110513     C                   EVAL      PP# = 0
160400140313     C                   DO        80
160500110513     C                   ADD       1             PP#
160600110513     C     PP#           OCCUR     CARPLN@
160700110513     C                   CLEAR                   CARPLN@
160800110513     C                   ENDDO
160900110513     C                   EVAL      PC# = 0
161000110513     C                   EVAL      PP# = 0
161100160616
161200110513     C     KL#ACCTL      SETLL     CARPLNR
161300110513     C                   DOU       %EOF(CARPLNP)
161400110513     C     KL#ACCTL      READE     CARPLNR
161500110520     C                   IF        NOT %EOF(CARPLNP)
161600160616
161700110513     C                   ADD       1             PC#
161800110513     C     PC#           OCCUR     CARPLN@
161900110513     C                   EVAL      CARPLN@ = DS@CARPLN
162000160616
162100110513     C                   ENDIF
162200110513     C                   ENDDO
162300160616
162400110513     C                   ENDSR
162500160616
162600160616      *============================================================================
162700160616
162800110513     C     $CLRSTG       BEGSR
162900160616
163000110513     C                   EVAL      #CANCEL = 0
163100160616
163200130315     C                   EVAL      L#CNE = 0
163300130315     C                   CLEAR                   L@PLN
163400130315     C                   CLEAR                   L@ENR
163500130315     C                   CLEAR                   L@FRM
163600130315     C                   CLEAR                   L@TRM
163700160616
163800110513     C                   EVAL      D#CNE = 0
163900110513     C                   CLEAR                   D@PLN
164000110513     C                   CLEAR                   D@ENR
164100110513     C                   CLEAR                   D@FRM
164200110513     C                   CLEAR                   D@TRM
164300110513     C                   EVAL      M#CNE = 0
164400110513     C                   CLEAR                   M@PLN
164500110513     C                   CLEAR                   M@ENR
164600110513     C                   CLEAR                   M@FRM
164700110513     C                   CLEAR                   M@TRM
164800160616
164900110513     C                   EXSR      $CLRDMG
165000160616
165100110513     C                   ENDSR
165200160616
165300160616      *============================================================================
165400160616
165500110513     C     $CLRDMG       BEGSR
165600160616
165700110513     C                   EVAL      @SS1   = *BLANKS
165800110513     C                   EVAL      @SS2   = *BLANKS
165900110513     C                   MOVE      *BLANKS       @LN
166000110513     C                   MOVEL     *BLANKS       @FN
166100110513     C                   EVAL      @MI    = *BLANKS
166200110513     C                   EVAL      @REL   = *BLANKS
166300110513     C                   EVAL      @SEX   = *BLANKS
166400110513     C                   EVAL      @DOB   = *BLANKS
166500110513     C                   EVAL      @SPEC  = *BLANKS
166600110513     C                   EVAL      @COB   = *BLANKS
166700110513     C                   EVAL      @COBC  = *BLANKS
166800110513     C                   EVAL      @COBN  = *BLANKS
166900110513     C                   EVAL      @AD1   = *BLANKS
167000110513     C                   EVAL      @AD2   = *BLANKS
167100110513     C                   EVAL      @CTY   = *BLANKS
167200110513     C                   EVAL      @ST    = *BLANKS
167300110513     C                   EVAL      @ZP5   = *BLANKS
167400110513     C                   EVAL      @PHN   = *BLANKS
167500110513     C                   EVAL      @EMPST = *BLANKS
167600110513     C                   EVAL      @HIRE  = *BLANKS
167700160616
167800110513     C                   ENDSR
167900160616
168000160616      *============================================================================
168100160616
168200110513     C     $CHKHEM       BEGSR
168300160616
168400160616     C                   IF        L#CNE > 0 AND L@TRM(L#CNE) <> 99999999
168500160616     C                   EXSR      $CHKLIF
168600160616     C                   ENDIF
168700160616
168800160616     C                   IF        D#CNE > 0 AND D@TRM(D#CNE) <> 99999999
168900160616     C                   EXSR      $CHKDEN
169000160616     C                   ENDIF
169100160616
169200110513     C                   IF        M#CNE > 0 AND M@TRM(M#CNE) <> 99999999
169300110513     C                   EXSR      $CHKMED
169400110513     C                   ENDIF
169500160616
169600110513     C                   ENDSR
169700160616
169800160616      *============================================================================
169900160616
170000160616     C     $CHKLIF       BEGSR
170100160616
170200160616     C                   EVAL      TERM_LIF = YES
170300160616     C                   EVAL      KF#TRM = L@TRM(L#CNE)
170400160616     C                   EVAL      KF@PLN = L@PLN(L#CNE)
170500160616     C                   EVAL      KF@ENR = L@ENR(L#CNE)
170600160616
170700170404     C     KL#MTR        CHAIN     AETGENTR
170800170404     C                   IF        %FOUND(AETGENTRM)
170900160616     C                   EVAL      L#CNE = 0
171000160616     C                   EVAL      TERM_LIF = NO
171100160616     C                   ENDIF
171200160616
171300160616     C                   ENDSR
171400160616
171500160616      *============================================================================
171600160616
171700160616     C     $CHKDEN       BEGSR
171800160616
171900160616     C                   EVAL      TERM_DEN = YES
172000160616     C                   EVAL      KF#TRM = D@TRM(D#CNE)
172100160616     C                   EVAL      KF@PLN = D@PLN(D#CNE)
172200160616     C                   EVAL      KF@ENR = D@ENR(D#CNE)
172300160616
172400170404     C     KL#MTR        CHAIN     AETGENTR
172500170404     C                   IF        %FOUND(AETGENTRM)
172600160616     C                   EVAL      D#CNE = 0
172700160616     C                   EVAL      TERM_DEN = NO
172800160616     C                   ENDIF
172900160616
173000160616     C                   ENDSR
173100160616
173200160616      *============================================================================
173300160616
173400110513     C     $CHKMED       BEGSR
173500160616
173600110513     C                   EVAL      TERM_MED = YES
173700110513     C                   EVAL      KF#TRM = M@TRM(M#CNE)
173800110513     C                   EVAL      KF@PLN = M@PLN(M#CNE)
173900110513     C                   EVAL      KF@ENR = M@ENR(M#CNE)
174000160616
174100170404     C     KL#MTR        CHAIN     AETGENTR
174200170404     C                   IF        %FOUND(AETGENTRM)
174300110513     C                   EVAL      TERM_MED = NO
174400110513     C                   EVAL      M#CNE = 0
174500110513     C                   ENDIF
174600160616
174700110513     C                   ENDSR
174800160616
174900160616      *============================================================================
175000160616
175100110513     C     $PLANSRCH     BEGSR
175200160616
175300130315     C                   MOVE      *BLANKS       PLN@CAT           5
175400110513     C                   EVAL      PP# = 0
175500110513     C                   CLEAR                   DS@CARPLN
175600160616
175700110513     C                   DO        PC#
175800160616
175900110513     C                   ADD       1             PP#
176000110513     C     PP#           OCCUR     CARPLN@
176100160616
176200110513     C                   IF        XPPLAN = @PLANIN AND
176300110513     C                             XPCCTR = @CCTRIN
176400110513     C                   EVAL      DS@CARPLN = CARPLN@
176500110513     C                   LEAVE
176600110513     C                   ENDIF
176700160616
176800110513     C                   ENDDO
176900160616
177000110513     C                   IF        CPPLAN = *BLANKS
177100110513     C                   LEAVESR
177200110513     C                   ENDIF
177300160616
177400110513     C                   SELECT
177500110520     C                   WHEN      CPCID1 = 'MEA' OR
177600110520     C                             CPCID1 = 'HMO'
177700110520     C                   EVAL      PLN@CAT = 'MED'
177800130409     C                   WHEN      CPCID1 = 'LIFE'
177900130409     C                   EVAL      PLN@CAT = 'LIFE'
178000110520     C                   WHEN      CPCID1 = 'DEN'
178100110520     C                   EVAL      PLN@CAT = 'DEN'
178200110513     C                   ENDSL
178300160616
178400110513     C                   ENDSR
178500160616
178600160616      *============================================================================
178700160616
178800110513     C     $ENROLL       BEGSR
178900160616
179000110513     C                   EVAL      ENR@OUT = *BLANKS
179100110513     C                   SELECT
179200110513     C                   WHEN      ENR@IN = 'TIN' OR ENR@IN = 'TMI'
179300110513     C                   EVAL      ENR@OUT = 'S'
179400110513     C                   WHEN      ENR@IN = 'THW'
179500110513     C                   EVAL      ENR@OUT = 'C'
179600110513     C                   WHEN      ENR@IN = 'TPC'
179700110513     C                   EVAL      ENR@OUT = 'P'
179800110513     C                   WHEN      ENR@IN = 'TP2'
179900110513     C                   EVAL      ENR@OUT = 'Q'
180000110513     C                   WHEN      ENR@IN = 'TFA'
180100110513     C                   EVAL      ENR@OUT = 'F'
180200110513     C                   ENDSL
180300160616
180400110513     C                   ENDSR
180500160616
180600160616      *============================================================================
180700160616
180800110513     C     $WRTERM       BEGSR
180900160616
181000170404     C                   CLEAR                   AETGENTR
181100110513     C                   EVAL      NTSSNO         = KF@SSN
181200110513     C                   EVAL      NTDEPNO        = KF@SEQ
181300110513     C                   EVAL      NTTERMDT       = KF#TRM
181400110513     C                   EVAL      NTPLAN         = KF@PLN
181500110513     C                   EVAL      NTCOVTP        = KF@ENR
181600110513     C                   EVAL      NTTRST         = KF@TRS
181700110513     C                   EVAL      NTSUB#         = KF@SUB
181800110513     C                   EVAL      NTACCT         = KF@ACC
181900110513     C                   EVAL      NTTRANSDT      = #TODAY
182000170404     C                   WRITE     AETGENTR
182100160616
182200110513     C                   ENDSR
182300160616
182400160616      *============================================================================
182500160616
182600110513     C     $HMOWRT       BEGSR
182700160616
182800110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
182900110513     C                   EVAL      X@ELR = CPCID2                               FILE NUMBER
183000110513     C                   EVAL      M@CC = CACID2                                COMPANY CODE
183100110513     C                   EVAL      M@CLASS = CPCID3                             CLASS CODE
183200110513     C                   EVAL      M@PLAN = CPCID4                              PLAN NUMBER
183300160616
183400110513     C                   EVAL      #XSX = M@FRM(M#CNE)
183500110725     C                   IF        WRT@TYPE = 'DEPEND' AND
183600110725     C                             #XSX < M@MBREFF
183700110725     C                   MOVE      M@MBREFF      X@EFF
183800110725     C                   ELSE
183900110725     C                   MOVE      #XSX          X@EFF
184000110725     C                   ENDIF
184100160616
184200240130     C                   EVAL      #XSX = M@TRM(M#CNE)
184300110513     C                   IF        #XSX = 0 OR #XSX = 99999999
184400110513     C                   MOVE      *BLANKS       X@TRM
184500110513     C                   ELSE
184600110513     C                   MOVE      #XSX          X@TRM
184700110513     C                   ENDIF
184807240130
184900110513     C                   IF        WRT@TYPE = 'MEMBER'
185000110513     C                   EVAL      KF@SEQ = 0
185100110513     C                   EVAL      ENR@IN = M@ENR(M#CNE)
185200110513     C                   EXSR      $ENROLL
185300110513     C                   EVAL      X@TIER = ENR@OUT
185400110513     C                   ELSE
185500110513     C                   EVAL      X@TIER = *BLANKS
185600110513     C                   ENDIF
185700160616
185800140313     C                   EVAL      KF@SPCD = 'MED'
185900140313     C                   EVAL      M@PCP = *BLANKS
186000140313     C                   EVAL      M@NPI = *BLANKS
186100140313     C                   EVAL      M@PCPCI = *BLANKS
186200160616
186300140313     C                   EXSR      $PCP
186400160616
186500140313     C                   IF        DOCTOR <> *BLANKS
186600140313     C                   EVAL      M@PCP = DOCTOR
186700140313     C                   EVAL      M@NPI = 'Y'
186800140313     C                   EVAL      M@PCPCI = '0'
186900140313     C                   ENDIF
187000160616
187100110513     C                   EXCEPT    HMOF
187200160616
187300110513     C                   ENDSR
187400160616
187500160616      *============================================================================
187600160616
187700110513     C     $MEAWRT       BEGSR
187800160616
187900110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
188000110513     C                   EVAL      X@ELR = CPCID2                               ELR
188100140313     C                   EVAL      E@SFX = CPCID3                               SUFFIX
188200140313     C                   EVAL      E@ACCT = CPCID4                              ACCOUNT
188300140313     C                   EVAL      E@PLAN = CPCID5                              PLAN
188400140313     C                   EVAL      E@CLM = CPCID6                               CLAIM OFFICE
188500160616
188600110513     C                   EVAL      #XSX = M@FRM(M#CNE)
188700110725     C                   IF        WRT@TYPE = 'DEPEND' AND
188800110725     C                             #XSX < M@MBREFF
188900110725     C                   MOVE      M@MBREFF      X@EFF
189000110725     C                   ELSE
189100110725     C                   MOVE      #XSX          X@EFF
189200110725     C                   ENDIF
189300170303
189400240130     C                   EVAL      #XSX = M@TRM(M#CNE)
189500110513     C                   IF        #XSX = 0 OR #XSX = 99999999
189600110513     C                   MOVE      *BLANKS       X@TRM
189700110513     C                   ELSE
189800110513     C                   MOVE      #XSX          X@TRM
189900110513     C                   ENDIF
190006240130
190100140313     C                   MOVE      *BLANKS       E@CBREXP
190200140313     C                   MOVE      *BLANKS       E@CBREVT
190300140313     C                   MOVE      *BLANKS       E@CBRLEN
190400140313     C                   IF        WRT@TYPE = 'MEMBER'
190500140425     C                   IF        EMPST = 'C' AND
190600140425     C                             CEXPDT > 0
190700140313     C                   MOVE      CEXPDT        E@CBREXP
190800140313     C                   MOVE      QEDT          E@CBREVT
190900140313     C                   MOVE      CEXPDT        #MINUEND
191000140313     C                   MOVE      QEDT          #SUBTRAEND
191100140313     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
191200140313     C                   Z-ADD     #DIFFRNC      #2S0
191300140313     C                   MOVE      #2S0          E@CBRLEN
191400140313     C                   ENDIF
191500140313     C                   ENDIF
191600160616
191700140313     C                   EVAL      *IN80 = *OFF
191800140313     C                   EVAL      KF@SPCD = 'MED'
191900140313     C                   EVAL      E@PCP = *BLANKS
192000140313     C                   EXSR      $PCP
192100140313     C                   IF        DOCTOR <> *BLANKS
192200140313     C                   EVAL      E@PCP = DOCTOR
192300140313     C                   EVAL      *IN80 = *ON
192400140313     C                   ENDIF
192500160616
192600161109       // if cobra and effective date > 12/01/2016...
192700170317       //if empst = 'C';
192800170317       // if e@cbrevt >= effectiveDate;
192900170317       //  e@cbrexp = ' ';
193000170317       //   e@cbrevt = ' ';
193100170317       //  e@cbrlen = ' ';
193200170317       // endif;
193300170317       //endif;
193400161109
193500140313     C                   EXCEPT    MEAF
193600160616
193700110513     C                   ENDSR
193800160616
193900160616      *============================================================================
194000160616
194100140313     C     $PCP          BEGSR
194200160616
194300140313     C                   MOVE      *BLANKS       DOCTOR            7
194400140313     C     KL#SQPCD      CHAIN     PCPR
194500140313     C                   IF        NOT %FOUND(PCPL1)
194600140313     C                   LEAVESR
194700140313     C                   ENDIF
194800140313     C     KL#SQPCD      SETLL     PCPR
194900140313     C                   DOU       %EOF(PCPL1)
195000140313     C     KL#SQPCD      READE     PCPR
195100140313     C                   IF        NOT %EOF(PCPL1) AND PCCAN = 0
195200140313     C                   MOVEL(P)  PCID#         DOCTOR
195300140313     C                   LEAVESR
195400140313     C                   ENDIF
195500140313     C                   ENDDO
195600160616
195700140313     C                   ENDSR
195800160616
195900160616      *============================================================================
196000160616
196100110513     C     $CLRDCV       BEGSR
196200160616
196300110513     C                   MOVE      *BLANKS       @LN
196400110513     C                   MOVEL     *BLANKS       @FN
196500110513     C                   EVAL      @SS2   = *BLANKS
196600110513     C                   EVAL      @MI    = *BLANKS
196700110513     C                   EVAL      @REL   = *BLANKS
196800110513     C                   EVAL      @SEX   = *BLANKS
196900110513     C                   EVAL      @DOB   = *BLANKS
197000110513     C                   EVAL      @SPEC  = *BLANKS
197100110513     C                   EVAL      @COB   = *BLANKS
197200110513     C                   EVAL      @COBC  = *BLANKS
197300110513     C                   EVAL      @COBN  = *BLANKS
197400160616
197500110513     C                   EVAL      #CANCEL = 0
197600110513     C                   EVAL      D#CNE = 0
197700110513     C                   CLEAR                   D@PLN
197800110513     C                   CLEAR                   D@ENR
197900110513     C                   CLEAR                   D@FRM
198000110513     C                   CLEAR                   D@TRM
198100110513     C                   EVAL      M#CNE = 0
198200110513     C                   CLEAR                   M@PLN
198300110513     C                   CLEAR                   M@ENR
198400110513     C                   CLEAR                   M@FRM
198500110513     C                   CLEAR                   M@TRM
198600160616
198700110513     C                   ENDSR
198800160616
198900160616      *============================================================================
199000160616
199100110513     C     $DENWRT       BEGSR
199200160616
199300160616     C                   EVAL      X@LAY = CPCID1                               LAYOUT
199400160616     C                   EVAL      X@ELR = CPCID2                               ELR
199500160616     C                   EVAL      D@SFX = CPCID3                               SUFFIX
199600160616     C                   EVAL      D@ACCT = CPCID4                              ACCOUNT
199700160616     C                   EVAL      D@PLAN = CPCID5                              PLAN
199800160616     C                   EVAL      D@CLM = CPCID6                               CLAIM OFFICE
199900110524     C                   EVAL      DNTLATE = '0'
200000160616
200100160616     C                   EVAL      #XSX = D@FRM(D#CNE)
200200110725     C                   IF        WRT@TYPE = 'DEPEND' AND
200300110725     C                             #XSX < D@MBREFF
200400110725     C                   MOVE      D@MBREFF      X@EFF
200500110725     C                   ELSE
200600110725     C                   MOVE      #XSX          X@EFF
200700110725     C                   ENDIF
200800160616
200900240130     C                   EVAL      #XSX = D@TRM(D#CNE)
201000160616     C                   IF        #XSX = 0 OR #XSX = 99999999
201100160616     C                   MOVE      *BLANKS       X@TRM
201200160616     C                   ELSE
201300160616     C                   MOVE      #XSX          X@TRM
201400160616     C                   ENDIF
201401240130
201600130211     C                   MOVE      *BLANKS       D@CBREXP
201700130211     C                   MOVE      *BLANKS       D@CBREVT
201800130211     C                   MOVE      *BLANKS       D@CBRLEN
201900110513     C                   IF        WRT@TYPE = 'MEMBER'
202000160616     C                   IF        EMPST = 'C' AND CEXPDT <> 0
202100160616     C                   MOVE      CEXPDT        D@CBREXP
202200160616     C                   MOVE      QEDT          D@CBREVT
202300160616     C                   MOVE      CEXPDT        #MINUEND
202400160616     C                   MOVE      QEDT          #SUBTRAEND
202500160616     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
202600160616     C                   Z-ADD     #DIFFRNC      #2S0
202700160616     C                   MOVE      #2S0          D@CBRLEN
202800160616     C                   ENDIF
202900160616     C                   ENDIF
203000160616
203100160616     C                   MOVE      '0'           D@OOAI
203200160616
203300140313     C                   EVAL      KF@SPCD = 'DEN'
203400140313     C                   EVAL      D@PCD = *BLANKS
203500140313     C                   EVAL      *IN81 = *OFF
203600140313     C                   MOVE      *BLANKS       DOCTOR
203700160616
203800140313     C                   EXSR      $PCP
203900160616
204000140313     C                   IF        DOCTOR <> *BLANKS
204100140313     C                   EVAL      D@PCD = DOCTOR
204200140313     C                   EVAL      *IN81 = *ON
204300140313     C                   ENDIF
204400160616
204500120123     C     *LIKE         DEFINE    H@C#          BUC#
204600120123     C                   EVAL      BUC# = H@C#
204700160616
204800120327     C                   SELECT
204900131126     C                   WHEN      KF@TRS = 591 AND KF@SUB = 009 AND            WILMOT MODULAR
205000131126     C                             KF@ACC = 0202                                 STRUCTURES
205100131227     C                   EVAL      H@C# = '0638156'
205200140702     C                   WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            REDLAND
205300140702     C                             KF@ACC = 0475                                 BAPTISTS
205400140702     C                   EVAL      H@C# = '0725572'
205500120327     C                   WHEN      KF@TRS = 825 AND KF@SUB = 001 AND            CREATIVE
205600120123     C                             KF@ACC = 0014                                 LOGISTICS
205700120123     C                   EVAL      H@C# = '0133860'
205800130905     C                   WHEN      KF@TRS = 905 AND KF@SUB = 001 AND            CCL USA
205900130905     C                             KF@ACC = 0092
206000130905     C                   EVAL      H@C# = '0638423'
206100140423     C                   WHEN      KF@TRS = 003 AND KF@SUB = 001 AND            FRAME RITE
206200140423     C                             KF@ACC = 0104
206300140423     C                   EVAL      H@C# = '0306511'
206400130520     C                   WHEN      KF@TRS = 900 AND KF@SUB = 003 AND            PERFECT
206500130520     C                             KF@ACC = 0045                                 SETTINGS
206600130520     C                   EVAL      H@C# = '0474109'
206700121024     C                   WHEN      KF@TRS = 591 AND KF@SUB = 011 AND            MCCALLISTER
206800121024     C                             KF@ACC = 0446                                 ARCHITECT
206900121024     C                   EVAL      H@C# = '0565330'
207000130716     C                   WHEN      KF@TRS = 591 AND KF@SUB = 005 AND            JD CLARK PROF
207100130716     C                             KF@ACC = 0451                                 SERVICES
207200130716     C                   EVAL      H@C# = '0519890'
207300130627     C                   WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            DYSON CONSTRUCTION
207400130627     C                             KF@ACC = 0459                                 COMPANY
207500130627     C                   EVAL      H@C# = '0788122'
207600130903     C                   WHEN      KF@TRS = 591 AND KF@SUB = 004 AND            STROUSE CORP
207700130903     C                             KF@ACC = 0482
207800130903     C                   EVAL      H@C# = '0837451'
207900130712     C                   WHEN      KF@TRS = 900 AND KF@SUB = 007 AND            CAPLAN BROTHERS
208000130712     C                             KF@ACC = 0075
208100130712     C                   EVAL      H@C# = '0837533'
208200120806     C                   WHEN      KF@TRS = 900 AND KF@SUB = 101 AND            INTEGRA HEALTH
208300130110     C                             KF@ACC = 0042 AND
208400130110     C                             (STATE = 'TN' OR STATE = 'FL' OR
208500130718     C                              STATE = 'OH' OR STATE = 'MA') AND
208600120806     C                             (@PLANIN = 'DAAD' OR @PLANIN = 'BAAD')
208700120806     C                   EVAL      H@C# = '0503428'
208800160616     C                   ENDSL
208900160616
209000161109       // if cobra and effective date > 12/01/2016...
209100170317       //if empst = 'C';
209200170317       // if d@cbrevt >= effectiveDate;
209300170317       //  d@cbrexp = ' ';
209400170317       //   d@cbrevt = ' ';
209500170317       //  d@cbrlen = ' ';
209600170317       // endif;
209700170317       //endif;
209800161109
209900160616     C                   EXCEPT    DENF
210000151217     c                   EVAL      H@C# = BUC#
210100160616
210200160616     C                   ENDSR
210300160616
210400160616      *============================================================================
210500160616
210600170404     OAETGEN    EADD         HDRF
210700101203     O                                            6 'HEADER'
210800160810     O                                            8 'P'
210900101206     O                       H@SI                28
211000101203     O                                           29 '0'
211100101203     O                       C1                  43
211200101203     O                       D1                  51
211300101203     O                       T1                  57
211400101206     O                                          131 'CONSOLIDATED ELIGIBILITY'
211500110502     O                       H@RI               167
211600101206     O                       H@CC               169
211700101228     O                       H@GN               176
211800101206     O                       H@CN               191
211900101206     O                       H@C#               198
212000101203     O                       D2                 206
212100110825     O                                          216 'MC'
212200101223     O                                          231 '*'
212300160616
212400160616      *============================================================================
212500170404     OAETGEN    EADD         MBRF
212600101203     O                                            6 'MEMBER'
212700101203     O                       @SS1                16
212800101203     O                       @SS2                25
212900101203     O                       @FN                 75
213000101203     O                       @MI                 76
213100101203     O                       @LN                 96
213200101203     O                       @REL               101
213300101203     O                       @SEX               103
213400101203     O                       @DOB               111
213500101203     O                       @SPEC              112
213600101203     O                                          113 '0'
213700101203     O                       @COB               123
213800101203     O                       @COBC              125
213900101203     O                       @COBN              145
214000101203     O                       @AD1               175
214100101203     O                       @AD2               205
214200101203     O                       @CTY               315
214300101203     O                       @ST                317
214400101203     O                       @ZP5               322
214500101203     O                       @PHN               349
214600141211     O               87                         576 '21207'
214700140626     O               88                         576 '21740'
214800141120     O               89                         576 '20171'
214900101203     O                       @EMPST             665
215000101203     O                       @HIRE              673
215100101223     O                                         1231 '*'
215200160616
215300160616      *============================================================================
215400170404     OAETGEN    EADD         HMOF
215500101213     O                                            7 'BENEFIT'
215600101213     O                       X@LAY               10
215700101214     O                       X@ELR               24
215800101213     O                       M@CC                26
215900101213     O                       H@GN                38
216000101213     O                       M@CLASS             44
216100101213     O                       M@PLAN              50
216200101213     O                       X@EFF               58
216300110929     O                       X@TRM               66
216400101213     O                       X@TIER              69
216500101213     O                       M@PCP              160
216600101213     O                       M@NPI              161
216700101213     O                       M@PCPCI            186
216800101223     O                                          323 '*'
216900160616
217000160616      *============================================================================
217100170404     OAETGEN    EADD         MEAF
217200140313     O                                            7 'BENEFIT'
217300140313     O                                           10 'MEA'
217400140313     O                       X@ELR               24
217500140313     O                       H@C#                31
217600140313     O                       E@SFX               34
217700140313     O                       E@ACCT              44
217800140313     O                       E@PLAN              50
217900140313     O                       X@EFF               58
218000140313     O                       X@TRM               66
218100140313     O                       E@CLM               71
218200140313     *** PCP BGN
218300140313     O                       E@PCP              127
218400140313     O               80                         161 'N'
218500140313     O               80                         186 '0'
218600140313     *** PCP END
218700140313     O                                          389 '0'
218800140313     *** COBRA BGN
218900140313     O                       E@CBREXP           466
219000140313     O                       E@CBREVT           516
219100140313     O                       E@CBRLEN           560
219200140313     *** COBRA END
219300140313     O                                          678 '*'
219400160616
219500160616      *============================================================================
219600170404     OAETGEN    EADD         DENF
219700101213     O                                            7 'BENEFIT'
219800101213     O                       X@LAY               10
219900101214     O                       X@ELR               24
220000101214     O                       H@C#                31
220100101213     O                       D@SFX               34
220200101213     O                       D@ACCT              44
220300101213     O                       D@PLAN              50
220400101213     O                       X@EFF               58
220500110929     O                       X@TRM               66
220600101213     O                       D@CLM               71
220700140313     *** PCD BGN
220800140313     O                       D@PCD              200
220900140313     O               81                         236 '0'
221000140313     *** PCD END
221100140313     O                                          389 '0'
221200140313     *** COBRA BGN
221300140313     O                       D@CBREXP           466
221400140313     O                       D@CBREVT           516
221500140313     O                       D@CBRLEN           560
221600140313     *** COBRA END
221700140313     O                       D@OOAI             609
221800140313     O                                          678 '*'
221900160616
222000160616      *============================================================================
222100170404     OAETGEN    EADD         LIFF
222200130315     O                                            7 'BENEFIT'
222300130412     O                                           11 'LIFE'
222400130315     O                       X@ELR               24
222500130319     O                       H@C#3               31
222600130315     O                       L@SFX               34
222700130315     O                       L@ACCT              44
222800130315     O                       L@PLAN              50
222900130315     O                       X@EFF               58
223000130315     O                       X@TRM               66
223100130315     O                       L@CLM               71
223200130315     O                       L@CBREXP           466
223300130315     O                       L@CBREVT           516
223400130315     O                       L@CBRLEN           560
223500130315     O                       L@SALARY           658
223600130315     O                                          659 '1'
223700130315     O                                          678 '*'
223800160616
223900160616      *============================================================================
224000170525     O*AETGEN    EADD         TRLF
224100170525     O*                                            7 'TRAILER'
224200170525     O*                       @TREC               17
224300170525     O*                       D1                  25
224400170525     O*                       T1                  31
224500170525     O*                       @BREC               41
224600170525     O*                                           69 '*'
224700160616
224800160616      *============================================================================
