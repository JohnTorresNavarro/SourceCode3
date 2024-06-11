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
001300170317      *  03/17/2017  JT  Per Brandon Scarfield... reinstated Cobra records.
001400170317
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
002900160809     FAET1050WF O  A F 1231        DISK
003000101206     ** FLAT FILE
003100151217
003200170526     FAET1051WF2IF A E           K DISK
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
004700120803     D KF@CCTL         S             10A   INZ
004800160314
004900160314     D CARR#CTL        S             10A
005000160314     D grouper         S             10A
005100160314
005200160809     D H@RI            S             25A   INZ('042064683')                     RECEIVER ID
005300151217
005400110512     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
005500101026     D DS@CARACC     E DS                  EXTNAME(CARACCP)
005600130315     D*DS@CARXPT     E DS                  EXTNAME(CARXPTP)
005700151217
005800110512     ** WORK ARRAY FOR PLANS
005900110512     **
006000110512     ** PC# - PLAN COUNT
006100110512     ** PP# - PLAN POINTER
006200110512     **
006300110512     D CARPLN@       E DS                  EXTNAME(CARPLNP)
006400151217     D                                     OCCURS(90) PREFIX(X:1)
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
008400101026     D #XSX2           S              8S 0
008500101026     D DATE@OUT        S             10A
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
010100101026     D KF@CARG         S              2A   INZ
010200101026     D KF@CCTR         S                   LIKE(CCFLG)
010300101026     D KF@PLN          S                   LIKE(MCPLAN)
010400101026     D KF@TRM          S                   LIKE(NTTERMDT)
010500101026     D KF#TRM          S              8S 0
010600101026     D KF@SSN          S                   LIKE(MBSSNO)
010700101026     D KF@SEQ          S                   LIKE(DPSEQ#)
010800101026     D KF@TYP          S              1A
010900101026     D KF@CDE          S              2A
011000140313     D KF@SPCD         S              5A
011100140313     D KF@MPLN         S              4A
011200140313     **
011300101026     D M@EARLYP        S              4A
011400101026     D M#EARLYE        S              8S 0 INZ
011500101026     D M#EARLYT        S              8S 0 INZ
011600140313     **
011700101026     D #8D1            S              8S 0 INZ
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
015000130315     D L@PLN           S              4A   DIM(20)
015100130315     D L@ENR           S              3A   DIM(20)
015200130315     D L@FRM           S              8S 0 DIM(20)
015300130315     D L@TRM           S              8S 0 DIM(20)
015400130315     D L@MBREFF        S              8S 0
015500160616
015600101206    *** DENTAL ARRAYS
015700101206     D D#CNE           S              3S 0 INZ
015800101206     D D#NDX           S              3S 0 INZ
015900101206     D D@PLN           S              4A   DIM(20)
016000101206     D D@ENR           S              3A   DIM(20)
016100101206     D D@FRM           S              8S 0 DIM(20)
016200101206     D D@TRM           S              8S 0 DIM(20)
016300160616     D D@MBREFF        S              8S 0
016400160616
016500101206    *** MEDICAL ARRAYS
016600101206     D M#CNE           S              3S 0 INZ
016700101206     D M#NDX           S              3S 0 INZ
016800101206     D M@PLN           S              4A   DIM(20)
016900101206     D M@ENR           S              3A   DIM(20)
017000101206     D M@FRM           S              8S 0 DIM(20)
017100101206     D M@TRM           S              8S 0 DIM(20)
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
023000160616
023100160831     C                   EVAL      KF@CCTL = CARR#CTL
023200160831     C     KF@CCTL       CHAIN     CARXPTR
023300160315     C****               EXSR      $HEADR
023400160616
023500160831     C     KF@CCTL       SETLL     CARACCR
023600160616
023700101026     C                   DOU       @STEP = 'LEAVE'
023800101026     C     @STEP         CASEQ     'PREP1'       $PREP1
023900101026     C     @STEP         CASEQ     'STEP1'       $STEP1
024000101026     C     @STEP         CASEQ     'STEP2'       $STEP2
024100101026     C     @STEP         CASEQ     'STEP3'       $STEP3
024200101026     C     @STEP         CASEQ     'PREP4'       $PREP4
024300101026     C     @STEP         CASEQ     'STEP4'       $STEP4
024400101026     C     @STEP         CASEQ     'PREP5'       $PREP5
024500101026     C     @STEP         CASEQ     'STEP5'       $STEP5
024600101214     C     @STEP         CASEQ     'PREP6'       $PREP6
024700101026     C     @STEP         CASEQ     'STEP6'       $STEP6
024800101214     C     @STEP         CASEQ     'PREP7'       $PREP7
024900101214     C     @STEP         CASEQ     'STEP7'       $STEP7
025000101214     C     @STEP         CASEQ     'STEP8'       $STEP8
025100101214     C     @STEP         CASEQ     'PREP9'       $PREP9
025200101214     C     @STEP         CASEQ     'STEP9'       $STEP9
025300101214     C     @STEP         CASEQ     'PREPA'       $PREPA
025400101214     C     @STEP         CASEQ     'STEPA'       $STEPA
025500101214     C     @STEP         CASEQ     'PREPB'       $PREPB
025600101214     C     @STEP         CASEQ     'STEPB'       $STEPB
025700130315     C     @STEP         CASEQ     'PREPC'       $PREPC
025800130315     C     @STEP         CASEQ     'STEPC'       $STEPC
025900101026     C                   ENDCS
026000101026     C                   ENDDO
026100160616
026200101206    ***  TRAILER RECORD
026300101026     C                   ADD       2             C#RECCNT
026400101214     C                   MOVE      C#RECCNT      @TREC            10 0
026500101214     C                   MOVE      B#RECCNT      @BREC            10 0
026600170526     C****               EXCEPT    TRLF
026700160831
026800160831      * call vision program...
026900170526     C                   CALL      'AET1051RV2'
027000160831     C                   parm                    KF@CCTL
027100160831     C                   parm                    grouper
027200160831     C                   parm                    KF@TRS
027300160831     C                   parm                    KF@SUB
027400160831     C                   parm                    KF@ACC
027500160616
027600101026     C                   EVAL      *INLR = *ON
027700160616
027800160616      *============================================================================
027900160616
028000110802     C     $HEADR        BEGSR
028100160616
028200110802     C                   EVAL      D1 = @DATE
028300110802     C                   EVAL      D2 = @DATE
028400110802     C                   EVAL      T1 = @TIME
028500110802     C                   EVAL      C1 = @DATE + @TIME
028600160616
028700160315     C**** carr#ctl      CHAIN     CARACCR
028800160616
028900110802     C                   EVAL      H@SI = %TRIM(CACID1)                         SUBMITTER ID
029000110802     C                   EVAL      H@CC = %SUBST(CACID2:1:2)                    COMPANY CODE
029100110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
029200110802     C                   MOVEL(P)  CACID4        H@CN                           CUSTOMER NAME
029300110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
029400130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
029500160616
029600170526     C****               EXCEPT    HDRF
029700160616
029800160315     C                   eval      firstTime = 'N'
029900160315
030000110802     C                   ENDSR
030100160616
030200160616      *============================================================================
030300110802     C     $PREP1        BEGSR
030400160616
030500160831     C     KF@CCTL       READE     CARACCR
030600160616
030700110512     C                   IF        %EOF(CARACCP)
030800120803      *
030900120815     C*                  IF        KF@CCTL = CARR#CTL
031000120815     C*                  EVAL      KF@CCTL = CARR#CTL2
031100120815     C*    KF@CCTL       SETLL     CARACCR
031200120815     C*                  ELSE
031300110512     C                   EVAL      @STEP = 'LEAVE'
031400120815     C*                  ENDIF
031500120803      *
031600110512     C                   LEAVESR
031700110512     C                   ENDIF
031800160616
031900110513    *** HAS THE ACCOUNT BEEN SHUTOFF FOR EXPORT?
032000110512     C                   IF        CASTATUS <> 'Y'
032100110512     C                   LEAVESR
032200110512     C                   ENDIF
032300160314
032400160314     C                   if        cacida <> grouper
032500160314     C                   leavesr
032600160314     C                   endif
032700160315
032800160315     c                   if        firstTime = 'Y'
032900160315     c                   exsr      $headr
033000160315     c                   endif
033100160315
033200110802    *** THESE FIELDS RESET FOR EACH SMALL GROUP READ
033300110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
033400110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
033500130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
033600160616
033700110512     C                   EVAL      KF@TRS = CATRST
033800110512     C                   EVAL      KF@SUB = CASUB#
033900110512     C                   EVAL      KF@ACC = CAACCT
034000160616
034100110512     C                   EXSR      $PLANLOAD
034200160616
034300101206     C                   EVAL      @STEP = 'STEP1'
034400160616
034500110512     C                   ENDSR
034600160616
034700160616      *============================================================================
034800160616
034900101206     C     $STEP1        BEGSR
035000160616
035100101206     C                   EVAL      KF@PLN = *BLANKS
035200101206     C                   EVAL      KF@TRM = 0
035300101206     C                   EVAL      KF@SSN = 0
035400101206     C                   EVAL      KF@SEQ = 0
035500160616
035600101206     C     KL#TSA        SETLL     MEMBR
035700160616
035800101206     C                   EVAL      @STEP = 'STEP2'
035900160616
036000101206     C                   ENDSR
036100160616
036200160616      *============================================================================
036300160616
036400101206     C     $STEP2        BEGSR
036500160616
036600101206     C     KL#TSA        READE     MEMBR
036700160616
036800101206     C                   IF        %EOF(MEMAC#1)
036900110512     C                   EVAL      @STEP = 'PREP1'
037000101206     C                   LEAVESR
037100101206     C                   ENDIF
037200160616
037300101206     C                   EVAL      KF@SSN = MBSSNO
037400101214     C                   MOVE      *ZEROS        KF@SEQ
037500120803     C                   EVAL      WRT@TYPE = 'MEMBER'
037600160616
037700101206     C     KL#MPLN       SETLL     MCOVR
037800160616
037900101206     C                   EXSR      $CLRSTG
038000160616
038100101206     C                   EVAL      @STEP = 'STEP3'
038200160616
038300101206     C                   ENDSR
038400160616
038500160616      *============================================================================
038600160616
038700101206     C     $STEP3        BEGSR
038800160616
038900101206     C     KL#MPLN       READE     MCOVR
039000160616
039100101206     C                   IF        %EOF(MCOVMPLN)
039200101206     C                   EVAL      @STEP = 'PREP4'
039300101206     C                   LEAVESR
039400101206     C                   ENDIF
039500160616
039600130131     C*                  IF        ENRLDT = CANDT
039700130131     C*                  LEAVESR
039800130131     C*                  ENDIF
039900160616
040000120803     C                   EVAL      KF@PLN = MCPLAN
040100160615     C     KL#TSAP       CHAIN     AEF04
040200160615     C                   IF        NOT %FOUND(AET004WF)
040300120803     C                   LEAVESR
040400120803     C                   ENDIF
040500160616
040600110512     C                   EVAL      @PLANIN = MCPLAN
040700111020     C                   EVAL      ENR@IN = MCOVTP
040800160616
040900110802     C                   EXSR      $QUIK
041000160616
041100110512     C                   EXSR      $PLANSRCH
041200160616
041300110512     C                   IF        PLN@CAT = *BLANKS
041400110512     C                   LEAVESR
041500110512     C                   ENDIF
041600160616
041700101206     C                   IF        CANDT = 0
041800101206     C                   EVAL      #CANCEL = 99999999
041900101206     C                   ELSE
042000101206     C                   EVAL      #CANCEL = CANDT
042100101206     C                   ENDIF
042200160616
042300130315    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL;
042400130315    *** LIF IS LIFE;
042500130315     C                   SELECT
042600160616
042700160616     C                   WHEN      PLN@CAT = 'LIFE'
042800160616     C                   IF        L#CNE > 0
042900160616     C                   IF        L@TRM(L#CNE) = 99999999
043000130315     C                   LEAVESR
043100130315     C                   ENDIF
043200130315     C                   ENDIF
043300160616     C                   ADD       1             L#CNE
043400160616     C                   EVAL      L@PLN(L#CNE) = MCPLAN
043500160616     C                   EVAL      L@ENR(L#CNE) = MCOVTP
043600160616     C                   EVAL      L@FRM(L#CNE) = ENRLDT
043700160616     C                   EVAL      L@TRM(L#CNE) = #CANCEL
043800160616
043900160616     C                   WHEN      PLN@CAT = 'DEN'
044000160616     C                   IF        D#CNE > 0
044100160616     C                   IF        D@TRM(D#CNE) = 99999999
044200130131     C                   LEAVESR
044300130131     C                   ENDIF
044400130131     C                   ENDIF
044500160616     C                   ADD       1             D#CNE
044600160616     C                   EVAL      D@PLN(D#CNE) = MCPLAN
044700160616     C                   EVAL      D@ENR(D#CNE) = MCOVTP
044800160616     C                   EVAL      D@FRM(D#CNE) = ENRLDT
044900160616     C                   EVAL      D@TRM(D#CNE) = #CANCEL
045000160616
045100130315     C                   OTHER
045200160616     C                   IF        M#CNE > 0
045300160616     C                   IF        M@TRM(M#CNE) = 99999999
045400130131     C                   LEAVESR
045500130131     C                   ENDIF
045600130131     C                   ENDIF
045700101206     C                   ADD       1             M#CNE
045800101206     C                   EVAL      M@PLN(M#CNE) = MCPLAN
045900101206     C                   EVAL      M@ENR(M#CNE) = MCOVTP
046000101206     C                   EVAL      M@FRM(M#CNE) = ENRLDT
046100101206     C                   EVAL      M@TRM(M#CNE) = #CANCEL
046200160616
046300160616     C                   ENDSL
046400160616
046500110512     C                   ENDSR
046600160616
046700160616      *============================================================================
046800160616
046900110802     C     $QUIK         BEGSR
047000160616
047100110805     C                   EVAL      @CCTRIN = *BLANKS
047200160616
047300160615     C     AE4MAP        CASEQ     '2TIER     '  $METH01
047400160615     C     AE4MAP        CASEQ     'ITOBJECTS '  $METH02
047500160615     C     AE4MAP        CASEQ     'NORULE    '  $METH03
047600160615     C     AE4MAP        CASEQ     'STATETIER '  $METH04
047700160615     C     AE4MAP        CASEQ     'TIERSTS   '  $METH05
047800160615     C     AE4MAP        CASEQ     'MAYOR     '  $METH06
047900160615     C     AE4MAP        CASEQ     'EMPSTS    '  $METH07
048000160615     C     AE4MAP        CASEQ     'JUSTSTATE '  $METH08
048100160615     C     AE4MAP        CASEQ     'JOHNLS    '  $METH09
048200160615     C     AE4MAP        CASEQ     'CREATIVE  '  $METH10
048300160615     C     AE4MAP        CASEQ     'INTEGRA   '  $METH11
048400160615     C     AE4MAP        CASEQ     'STSTATE   '  $METH12
048500160615     C     AE4MAP        CASEQ     'INTEGRA   '  $METH11
048600160615     C     AE4MAP        CASEQ     'STIERSTS  '  $METH13
048700120803     C                   ENDCS
048800160616
048900120803     C                   ENDSR
049000160616
049100160616      *============================================================================
049200160616
049300160616      * 2 TIER = AETNA HAS TWO TIERS, IND AND FAM
049400160616      *  MEMBERS HAVE 'TIN' CONVERTED TO 'IND' AND NON-'TIN' CONVERTED TO 'FAM'
049500160616      *  DEPENDENTS HAVE 'FAM' ONLY
049600160616      *
049700160616      * IND, FAM
049800160616
049900160616      *============================================================================
050000160616
050100120803     C     $METH01       BEGSR
050200160616
050300120803     C                   IF        WRT@TYPE = 'MEMBER'
050400160616
050500120803     C                   IF        ENR@IN = 'TIN'
050600120803     C                   EVAL      @CCTRIN = 'IND'
050700120803     C                   ELSE
050800120803     C                   EVAL      @CCTRIN = 'FAM'
050900120803     C                   ENDIF
051000160616
051100120803     C                   ENDIF
051200160616
051300120803     C                   IF        WRT@TYPE = 'DEPEND'
051400160616
051500120803     C                   EVAL      @CCTRIN = 'FAM'
051600160616
051700120803     C                   ENDIF
051800160616
051900120803     C                   ENDSR
052000160616
052100160616      *============================================================================
052200160616
052300160616      * ITOBJECTS = IF YOU ARE NOT 'VA' OR 'OH' STATE CODES, YOU ARE 'XX'
052400160616
052500160616      * VA, OH, XX
052600160616
052700160616      *============================================================================
052800160616
052900120803     C     $METH02       BEGSR
053000160616
053100120803     C                   IF        STATE <> 'VA' AND STATE <> 'OH'
053200120803     C                   EVAL      @CCTRIN = 'XX '
053300120803     C                   ELSE
053400120803     C                   EVAL      @CCTRIN = STATE
053500120803     C                   ENDIF
053600160616
053700120803     C                   ENDSR
053800160616
053900160616      *============================================================================
054000160616      * NORULE = NUFF SAID
054100160616      *============================================================================
054200160616
054300120803     C     $METH03       BEGSR
054400160616
054500120803     C                   EVAL      @CCTRIN = *BLANKS
054600160616
054700120803     C                   ENDSR
054800160616
054900160616      *============================================================================
055000160616      * STATETIER
055100160616      *  START WITH STATE CODE
055200160616      *  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
055300160616      *  DEPENDENTS HAVE 'F' ONLY
055400160616      * MDI, MDF, ETC...
055500160616      *============================================================================
055600160616
055700120803     C     $METH04       BEGSR
055800160616
055900120803     C                   EVAL      @CCTRIN = STATE
056000160616
056100120803     C                   IF        WRT@TYPE = 'MEMBER'
056200120803     C                   IF        ENR@IN = 'TIN'
056300120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
056400120803     C                   ELSE
056500120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
056600120803     C                   ENDIF
056700120803     C                   ENDIF
056800160616
056900120803     C                   IF        WRT@TYPE = 'DEPEND'
057000120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
057100120803     C                   ENDIF
057200160616
057300120803     C                   ENDSR
057400160616
057500160616      *============================================================================
057600160616      * TIERSTS
057700160616      *  START WITH EMPLOYMENT STATUS, ACTIVE IS 'ACT' AND COBRA IS 'COB'
057800160616      *  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
057900160616      *  DEPENDENTS HAVE 'F' ONLY
058000160616      *
058100160616      * ACI, ACF, COI, COF
058200160616      *============================================================================
058300160616
058400120803     C     $METH05       BEGSR
058500160616
058600120803     C                   IF        EMPST =  'C'
058700120803     C                   EVAL      @CCTRIN = 'COB'
058800120803     C                   ELSE
058900120803     C                   EVAL      @CCTRIN = 'ACT'
059000120803     C                   ENDIF
059100160616
059200120803     C                   IF        ENR@IN = 'TIN'
059300120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
059400120803     C                   ELSE
059500120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
059600120803     C                   ENDIF
059700160616
059800120803     C                   ENDSR
059900160616
060000160616      *============================================================================
060100160616      * MAYOR
060200160616      *  WELL, FOR THE PLAN 'DAAU' IF THE STATE IS 'WV' THEN PLACE TIER STATUS SUFFIX
060300160616      *       BY TYPE OF PEEP; FOR OTHER STATES, USE A SIMPLE TIER CHECK.
060400160616      *
060500160616      *  WVI, WVF, IND, FAM
060600160616      *
060700160616      *  NOW, FOR THE PLAN 'DAAT' IF THE STATE IS 'WV' THEN PLACE EMPLOYMENT STATUS SUFFIX
060800160616      *       BY TYPE OF PEEP; FOR OTHER STATES, EMPLOYMENT STATUS AND TIER.
060900160616      *
061000160616      *  WVI, WVF, CBI, CBF, ACI, ACF
061100160616      *============================================================================
061200160616
061300120803     C     $METH06       BEGSR
061400160616
061500160616     C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'MEMBER'
061600160616
061700160616     C                   IF        STATE = 'WV'
061800160616
061900160616     C                   IF        ENR@IN = 'TIN'
062000120803     C                   EVAL      @CCTRIN = 'WVI'
062100160616     C                   ELSE
062200120803     C                   EVAL      @CCTRIN = 'WVF'
062300160616     C                   ENDIF
062400160616
062500160616     C                   ELSE
062600160616
062700160616     C                   IF        ENR@IN = 'TIN'
062800120803     C                   EVAL      @CCTRIN = 'IND'
062900160616     C                   ELSE
063000120803     C                   EVAL      @CCTRIN = 'FAM'
063100160616     C                   ENDIF
063200160616
063300160616     C                   ENDIF
063400160616
063500120803     C                   LEAVESR
063600160616     C                   ENDIF
063700160616
063800120803     C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'DEPEND'
063900160616
064000120803     C                   IF        STATE = 'WV'
064100120803     C                   EVAL      @CCTRIN = 'WVF'
064200120803     C                   ELSE
064300120803     C                   EVAL      @CCTRIN = 'FAM'
064400120803     C                   ENDIF
064500160616
064600120803     C                   LEAVESR
064700120803     C                   ENDIF
064800160616
064900160616     C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'MEMBER'
065000160616
065100160616     C                   IF        STATE = 'WV'
065200160616
065300160616     C                   IF        ENR@IN = 'TIN'
065400120803     C                   EVAL      @CCTRIN = 'WVI'
065500160616     C                   ELSE
065600120803     C                   EVAL      @CCTRIN = 'WVF'
065700160616     C                   ENDIF
065800160616
065900160616     C                   ELSE
066000160616
066100160616     C                   IF        EMPST =  'C'
066200120803     C                   EVAL      @CCTRIN = 'CB '
066300160616     C                   ELSE
066400120803     C                   EVAL      @CCTRIN = 'AC '
066500160616     C                   ENDIF
066600160616     C                   IF        ENR@IN = 'TIN'
066700120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
066800160616     C                   ELSE
066900120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
067000160616     C                   ENDIF
067100160616
067200160616     C                   ENDIF
067300160616
067400120803     C                   LEAVESR
067500160616     C                   ENDIF
067600160616
067700120803     C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'DEPEND'
067800160616
067900120803     C                   IF        STATE = 'WV'
068000120803     C                   EVAL      @CCTRIN = 'WVF'
068100120803     C                   ELSE
068200120803     C                   IF        EMPST =  'C'
068300120803     C                   EVAL      @CCTRIN = 'CBF'
068400120803     C                   ELSE
068500120803     C                   EVAL      @CCTRIN = 'ACF'
068600120803     C                   ENDIF
068700120803     C                   ENDIF
068800160616
068900120803     C                   ENDIF
069000160616
069100120803     C                   ENDSR
069200160616
069300160616      *============================================================================
069400160616      * EMPSTS
069500160616      *   PRETTY STRAIGHT FORWARDED
069600160616      *============================================================================
069700160616
069800120803     C     $METH07       BEGSR
069900160616
070000120803     C                   IF        EMPST =  'C'
070100120803     C                   EVAL      @CCTRIN = 'COB'
070200120803     C                   ELSE
070300120803     C                   EVAL      @CCTRIN = 'ACT'
070400120803     C                   ENDIF
070500160616
070600120803     C                   ENDSR
070700160616
070800160616      *============================================================================
070900160616      * JUSTSTATE
071000160616      *   PRETTY STRAIGHT FORWARDED
071100160616      *============================================================================
071200160616
071300120803     C     $METH08       BEGSR
071400160616
071500120803     C                   EVAL      @CCTRIN = STATE
071600160616
071700120803     C                   ENDSR
071800160616      *============================================================================
071900160616      * JOHNLS
072000160616      *   IF STATE IS NOT MARYLAND, DEFAULT TO 'XX', ELSE USE 'MD'; THEN APPLY TIER.
072100160616      * MDI, MDF, XXI, XXF
072200160616      *============================================================================
072300160616
072400120803     C     $METH09       BEGSR
072500160616
072600120803     C                   IF        WRT@TYPE = 'MEMBER'
072700120803     C                   IF        STATE = 'MD'
072800120803     C                   EVAL      @CCTRIN = 'MD'
072900120803     C                   ELSE
073000120803     C                   EVAL      @CCTRIN = 'XX'
073100120803     C                   ENDIF
073200120803     C                   IF        ENR@IN = 'TIN'
073300120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
073400120803     C                   ELSE
073500120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
073600120803     C                   ENDIF
073700120803     C                   ENDIF
073800160616
073900120803     C                   IF        WRT@TYPE = 'DEPEND'
074000120803     C                   IF        STATE = 'MD'
074100120803     C                   EVAL      @CCTRIN = 'MDF'
074200120803     C                   ELSE
074300120803     C                   EVAL      @CCTRIN = 'XXF'
074400120803     C                   ENDIF
074500120803     C                   ENDIF
074600160616
074700120803     C                   ENDSR
074800160616
074900160616      *============================================================================
075000160616      * CREATIVE
075100160616      *   IF STATE IS NOT 'MD' OR 'OK', DEFAULT TO '**'.
075200160616      * MD, OK, **
075300160616      *============================================================================
075400160616
075500120803     C     $METH10       BEGSR
075600160616
075700120803     C                   IF        STATE <> 'MD' AND STATE <> 'OK'
075800120803     C                   EVAL      @CCTRIN = '** '
075900120803     C                   ELSE
076000120803     C                   EVAL      @CCTRIN = STATE
076100120803     C                   ENDIF
076200160616
076300120803     C                   ENDSR
076400160616
076500160616      *============================================================================
076600160616      * INTEGRA = USE 'TN' FOR TENNESSEE, OTHER STATES ARE 'XX'
076700160616      *  TN, XX
076800160616      *============================================================================
076900160616
077000120803     C     $METH11       BEGSR
077100160616
077200121113     C                   SELECT
077300121113     C                   WHEN      STATE = 'TN'
077400121113     C                   EVAL      @CCTRIN = STATE                              TENNESSEE ONLY
077500121113     C                   WHEN      STATE = 'FL'
077600121113     C                   EVAL      @CCTRIN = STATE                              FLORIDA ONLY
077700121113     C                   OTHER
077800121113     C                   EVAL      @CCTRIN = 'XX '                              SITUS
077900160616     C                   ENDSL
078000160616
078100120803     C                   ENDSR
078200160616
078300160616      *============================================================================
078400160616      * STSTATE = STATE CODE WITH EMPLOYEE STATUS
078500160616      *  MDA, MDC, ETC...
078600160616      *============================================================================
078700160616
078800120803     C     $METH12       BEGSR
078900160616
079000120803     C                   EVAL      @CCTRIN = STATE + EMPST
079100160616
079200120803     C                   ENDSR
079300160616
079400160616      *============================================================================
079500160616      * STIERSTS = STATE CODE WITH TIER WITH EMPLOYEE STATUS
079600160616      *    ACTIVE [#CALC = 0]      COBRA [#CALC = 5]
079700160616      *    IND [+1 TO #CALC ]      NON-IND COVERAGE [+2 TO CALC]
079800160616      *    EACH STATE PUT AT END, GIVING FAM MARYLAND ACTIVE A VALUE OF 2MD
079900160616      *                                  IND WEST VIRGINIA COBRA A VALUE OF 6WV
080000160616      *============================================================================
080100160616
080200130123     C     $METH13       BEGSR
080300160616
080400130123     C                   SELECT
080500130123     C                   WHEN      EMPST =  'C'
080600130123     C                   Z-ADD     5             #CALC
080700130123     C                   OTHER
080800130123     C                   MOVE      *ZEROS        #CALC             1 0
080900130123     C                   ENDSL
081000160616
081100130123     C                   SELECT
081200130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN = 'TIN'
081300130123     C                   ADD       1             #CALC
081400130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN <> 'TIN'
081500130123     C                   ADD       2             #CALC
081600130123     C                   WHEN      WRT@TYPE = 'DEPEND'
081700130123     C                   ADD       2             #CALC
081800130123     C                   ENDSL
081900160616
082000130123     C                   EVAL      @CCTRIN = %EDITC(#CALC:'X') + STATE
082100160616
082200130123     C                   ENDSR
082300160616
082400160616      *============================================================================
082500160616
082600120409     C     $PREP4        BEGSR
082700160616
082800130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
082900101206     C                   EVAL      @STEP = 'STEP2'
083000101206     C                   LEAVESR
083100101206     C                   ENDIF
083200160616
083300130520     C                   EVAL      @STEP = 'STEP4'
083400130315     C                   EVAL      TERM_LIF = NO
083500101210     C                   EVAL      TERM_DEN = NO
083600101210     C                   EVAL      TERM_MED = NO
083700160616
083800130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
083900130520     C                   IF        L@TRM(L#CNE) <> 99999999
084000130520     C                   EXSR      $CHKHEM
084100130520     C                   ENDIF
084200130520     C                   LEAVESR
084300130520     C                   ENDIF
084400160616
084500130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
084600130520     C                   IF        M@TRM(M#CNE) <> 99999999
084700130520     C                   EXSR      $CHKHEM
084800130520     C                   ENDIF
084900130520     C                   LEAVESR
085000130520     C                   ENDIF
085100160616
085200130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
085300130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
085400130520     C                              M@TRM(M#CNE) <> 99999999)
085500130520     C                   EXSR      $CHKHEM
085600130520     C                   ENDIF
085700130520     C                   LEAVESR
085800130520     C                   ENDIF
085900160616
086000130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
086100130520     C                   IF        D@TRM(D#CNE) <> 99999999
086200130520     C                   EXSR      $CHKHEM
086300130520     C                   ENDIF
086400130520     C                   LEAVESR
086500130520     C                   ENDIF
086600160616
086700130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
086800130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
086900130520     C                              D@TRM(D#CNE) <> 99999999)
087000130520     C                   EXSR      $CHKHEM
087100130520     C                   ENDIF
087200130520     C                   LEAVESR
087300130520     C                   ENDIF
087400160616
087500130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
087600130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
087700130520     C                              M@TRM(M#CNE) <> 99999999)
087800130520     C                   EXSR      $CHKHEM
087900130520     C                   ENDIF
088000130520     C                   LEAVESR
088100130520     C                   ENDIF
088200160616
088300130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
088400130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
088500130520     C                              L@TRM(L#CNE) <> 99999999 OR
088600130520     C                              M@TRM(M#CNE) <> 99999999)
088700130520     C                   EXSR      $CHKHEM
088800130520     C                   ENDIF
088900130520     C                   LEAVESR
089000130520     C                   ENDIF
089100160616
089200101214     C                   ENDSR
089300160616
089400160616      *============================================================================
089500160616      * GENERATE MEMBER RECORD
089600160616      *============================================================================
089700160616
089800101210     C     $STEP4        BEGSR
089900160616
090000130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
090100101214     C                   EVAL      @STEP = 'STEP2'
090200101214     C                   LEAVESR
090300101214     C                   ENDIF
090400160616
090500110513     C                   EVAL      WRT@TYPE = 'MEMBER'
090600160616
090700130315     C                   EVAL      L@MBREFF = 0
090800110725     C                   EVAL      D@MBREFF = 0
090900110725     C                   EVAL      M@MBREFF = 0
091000160616
091100101210     C                   EVAL      @SS1   = %EDITC(MBSSNO:'X')
091200101210     C                   EVAL      @SS2   = @SS1
091300101210     C                   MOVEL(P)  MLNAME        @LN
091400101210     C                   MOVEL(P)  MFNAME        @FN
091500101210     C                   EVAL      @MI    = MMI
091600101210     C                   EVAL      @REL   = '01'
091700101210     C                   EVAL      @SEX   = SEX
091800101210     C                   EVAL      @DOB   = %EDITC(BIRTH:'X')
091900101210     C                   IF        COB = 'Y'
092000101210     C                   EVAL      @COB   = 'Y'
092100101210     C                   EVAL      @COBC  = 'OT'
092200101210     C                   EVAL      @COBN  = MCOBPN
092300101210     C                   ENDIF
092400101210     C                   EVAL      @AD1   = %TRIM(ADDR1)
092500101210     C                   EVAL      @AD2   = %TRIM(ADDR2)
092600101210     C                   EVAL      @CTY   = %TRIM(CITY)
092700101210     C                   EVAL      @ST    = STATE
092800101210     C                   MOVE      *BLANKS       @9                9
092900101210     C                   EVAL      @9   = %EDITC(ZIP:'X')
093000101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
093100101210     C                   EVAL      @PHN   = %EDITC(AREA:'X') +
093200101210     C                                      %EDITC(PHONE:'X')
093300160616
093400101210     C                   SELECT
093500101210     C                   WHEN      EMPST = 'A'
093600101210     C                   EVAL      @EMPST = 'AC'
093700101210     C                   WHEN      EMPST = 'C'
093800101210     C                   EVAL      @EMPST = 'CO'
093900101210     C                   WHEN      EMPST = 'R'
094000101210     C                   EVAL      @EMPST = 'RT'
094100101210     C                   ENDSL
094200160616
094300101210     C                   EVAL      @HIRE  = %EDITC(EMPDT:'X')
094400160616
094500141211     C                   SETOFF                                       888987
094600141120        IF KF@TRS = 770 AND KF@SUB = 004 AND KF@ACC = 0037 AND
094700141120          STATE = 'VT';
094800141120           *IN89 = *ON;
094900141120        ENDIF;
095000161109
095100161109       // if cobra and effective date > 12/01/2016...
095200170317       //if empst = 'C';
095300170317       // if qedt >= effectiveDateD;
095400170317       //  @empst = 'AC';
095500170317       // endif;
095600170317       //endif;
095700161109
095800101210     C                   EXCEPT    MBRF
095900101214     C                   ADD       1             C#RECCNT
096000160616
096100101213     C                   EVAL      @STEP = 'PREP5'
096200160616
096300101210     C                   ENDSR
096400160616
096500160616      *============================================================================
096600160616      * MEDICAL
096700160616      *============================================================================
096800160616
096900101214     C     $PREP5        BEGSR
097000160616
097100101214     C                   IF        M#CNE = 0
097200110513     C                   EVAL      @STEP = 'PREP6'
097300101214     C                   LEAVESR
097400101214     C                   ENDIF
097500160616
097600101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
097700130315     C                   EVAL      KF@ENR = M@ENR(M#CNE)
097800160616
097900101214     C                   IF        TERM_MED = YES
098000101214     C                   EXSR      $WRTERM
098100101214     C                   ENDIF
098200160616
098300110512     C                   EVAL      @PLANIN = KF@PLN
098400160616
098500160615     C     KL#TSAP       CHAIN     AEF04
098600160615     C                   IF        NOT %FOUND(AET004WF)
098700120803     C                   LEAVESR
098800120803     C                   ENDIF
098900160616
099000111020     C                   EVAL      ENR@IN = M@ENR(M#CNE)
099100160616
099200110802     C                   EXSR      $QUIK
099300160616
099400110512     C                   EXSR      $PLANSRCH
099500160616
099600110512     C                   IF        PLN@CAT = *BLANKS
099700101214     C                   SETON                                        H1
099800101214     C                   ENDIF
099900160616
100000110513     C                   EVAL      @STEP = 'STEP5'
100100110725     C                   EVAL      #XSX = M@FRM(M#CNE)
100200110725     C                   EVAL      M@MBREFF = #XSX
100300160616
100400101214     C                   ENDSR
100500160616
100600160616      *============================================================================
100700160616
100800101214     C     $STEP5        BEGSR
100900160616
101000110513     C                   IF        CPCID1 = 'MEA'
101100110513     C                   EXSR      $MEAWRT
101200110513     C                   ELSE
101300110513     C                   EXSR      $HMOWRT
101400110513     C                   ENDIF
101500160616
101600101214     C                   ADD       1             C#RECCNT
101700101214     C                   ADD       1             B#RECCNT
101800160616
101900110513     C                   EVAL      @STEP = 'PREP6'
102000160616
102100110513     C                   ENDSR
102200160616
102300160616      *============================================================================
102400160616      * DENTAL
102500160616      *============================================================================
102600160616
102700101214     C     $PREP6        BEGSR
102800160616
102900160616     C                   IF        D#CNE = 0
103000160616     C                   EVAL      @STEP = 'PREPC'
103100160616     C*****************  EVAL      @STEP = 'PREP7'
103200160616     C                   LEAVESR
103300160616     C                   ENDIF
103400160616
103500160616     C                   EVAL      KF@PLN = D@PLN(D#CNE)
103600160616     C                   EVAL      KF@ENR = D@ENR(D#CNE)
103700160616
103800160615     C     KL#TSAP       CHAIN     AEF04
103900160615     C                   IF        NOT %FOUND(AET004WF)
104000120803     C                   LEAVESR
104100120803     C                   ENDIF
104200160616
104300160616     C                   IF        TERM_DEN = YES
104400160616     C                   EXSR      $WRTERM
104500160616     C                   ENDIF
104600160616
104700110513     C                   EVAL      @PLANIN = KF@PLN
104800111020     C                   EVAL      ENR@IN = D@ENR(D#CNE)
104900160616
105000111011     C                   EXSR      $QUIK
105100160616
105200110513     C                   EXSR      $PLANSRCH
105300160616
105400110513     C                   IF        PLN@CAT = *BLANKS
105500110513     C                   SETON                                        H2
105600110513     C                   ENDIF
105700160616
105800160616     C                   EVAL      @STEP = 'STEP6'
105900110725     C                   EVAL      #XSX = D@FRM(D#CNE)
106000110725     C                   EVAL      D@MBREFF = #XSX
106100160616
106200101213     C                   ENDSR
106300160616
106400160616      *============================================================================
106500160616      * DENTAL FORMAT
106600160616      *============================================================================
106700160616
106800160616     C     $STEP6        BEGSR
106900110513     C                   EXSR      $DENWRT
107000160616
107100160616     C                   ADD       1             C#RECCNT
107200160616     C                   ADD       1             B#RECCNT
107300160616
107400160616     C****************** EVAL      @STEP = 'PREP7'
107500160616     C                   EVAL      @STEP = 'PREPC'
107600160616
107700160616     C                   ENDSR
107800160616
107900160616      *============================================================================
108000160616      * LIFE AND AD&D PLANS FOR MEMBER
108100160616      *============================================================================
108200160616
108300130315     C     $PREPC        BEGSR
108400160616
108500160616     C                   IF        L#CNE = 0
108600160616     C                   EVAL      @STEP = 'PREP7'
108700160616     C                   LEAVESR
108800160616     C                   ENDIF
108900160616
109000160616     C                   EVAL      KF#TRM = L@TRM(L#CNE)
109100160616     C                   EVAL      KF@PLN = L@PLN(L#CNE)
109200130315     C                   EVAL      KF@ENR = L@ENR(L#CNE)
109300160616
109400160615     C     KL#TSAP       CHAIN     AEF04
109500160615     C                   IF        NOT %FOUND(AET004WF)
109600130315     C                   LEAVESR
109700130315     C                   ENDIF
109800160616
109900160616     C                   IF        TERM_LIF = YES
110000160616     C                   EXSR      $WRTERM
110100160616     C                   ENDIF
110200160616
110300130315     C                   EVAL      @PLANIN = KF@PLN
110400130315     C                   EVAL      ENR@IN = L@ENR(L#CNE)
110500160616
110600130315     C                   EXSR      $QUIK
110700160616
110800130315     C                   EXSR      $PLANSRCH
110900160616
111000130315     C                   IF        PLN@CAT = *BLANKS
111100130315     C                   SETON                                        H2
111200130315     C                   ENDIF
111300160616
111400160616     C                   EVAL      @STEP = 'STEPC'
111500130315     C                   EVAL      #XSX = L@FRM(L#CNE)
111600130315     C                   EVAL      L@MBREFF = #XSX
111700160616
111800130315     C                   ENDSR
111900160616
112000160616      *============================================================================
112100160616      * LIFE FORMAT
112200160616      *============================================================================
112300160616
112400160616     C     $STEPC        BEGSR
112500160616
112600130315     C                   EXSR      $LIFWRT
112700160616
112800160616     C                   ADD       1             C#RECCNT
112900160616     C                   ADD       1             B#RECCNT
113000160616
113100160616     C                   EVAL      @STEP = 'PREP7'
113200160616
113300160616     C                   ENDSR
113400160616
113500160616      *============================================================================
113600160616
113700130315     C     $LIFWRT       BEGSR
113800160616
113900160616     C                   EVAL      X@LAY = CPCID1                               LAYOUT
114000160616     C                   EVAL      X@ELR = CPCID2                               ELR
114100160616     C                   EVAL      L@SFX = CPCID3                               SUFFIX
114200160616     C                   EVAL      L@ACCT = CPCID4                              ACCOUNT
114300160616     C                   EVAL      L@PLAN = CPCID5                              PLAN
114400160616     C                   EVAL      L@CLM = CPCID6                               CLAIM OFFICE
114500160616
114600160616     C                   EVAL      #XSX = L@FRM(L#CNE)
114700130315     C                   MOVE      #XSX          X@EFF
114800160616
114900160616     C                   EVAL      #XSX = L@TRM(L#CNE)
115000160616     C                   IF        #XSX = 0 OR #XSX = 99999999
115100160616     C                   MOVE      *BLANKS       X@TRM
115200160616     C                   ELSE
115300160616     C                   MOVE      #XSX          X@TRM
115400160616     C                   ENDIF
115500160616
115600140313     C                   MOVE      *BLANKS       L@CBREXP
115700140313     C                   MOVE      *BLANKS       L@CBREVT
115800140313     C                   MOVE      *BLANKS       L@CBRLEN
115900160616
116000160616     C                   IF        EMPST = 'C' AND
116100130923     C                             CEXPDT > 0
116200160616     C                   MOVE      CEXPDT        L@CBREXP
116300160616     C                   MOVE      QEDT          L@CBREVT
116400160616     C                   MOVE      CEXPDT        #MINUEND
116500160616     C                   MOVE      QEDT          #SUBTRAEND
116600160616     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
116700160616     C                   Z-ADD     #DIFFRNC      #2S0
116800160616     C                   MOVE      #2S0          L@CBRLEN
116900160616     C                   ENDIF
117000160616
117100130315     C                   EVAL      L@SALARY = %EDITC(SALARY:'4')
117200160616
117300160616     C                   EXCEPT    LIFF
117400160616
117500160616     C                   ENDSR
117600160616
117700160616      *============================================================================
117800160616
117900101214     C     $PREP7        BEGSR
118000160616
118100101214     C     KF@SSN        CHAIN     DEPENR
118200101214     C                   IF        NOT %FOUND(DEPNDC)
118300101214     C                   EVAL      @STEP = 'STEP2'
118400101214     C                   LEAVESR
118500101214     C                   ENDIF
118600160616
118700101214     C     KF@SSN        SETLL     DEPENR
118800160616
118900101214     C                   EVAL      @STEP = 'STEP7'
119000160616
119100101214     C                   ENDSR
119200160616
119300160616      *============================================================================
119400160616
119500101214     C     $STEP7        BEGSR
119600160616
119700101214     C     KF@SSN        READE     DEPENR
119800160616
119900101214     C                   IF        %EOF(DEPNDC)
120000101214     C                   EVAL      @STEP = 'STEP2'
120100101214     C                   LEAVESR
120200101214     C                   ENDIF
120300160616
120400101214     C                   EVAL      KF@SEQ = DPSEQ#
120500120803     C                   EVAL      WRT@TYPE = 'DEPEND'
120600160616
120700101214     C     KL#DCV        CHAIN     DCOVR
120800101214     C                   IF        NOT %FOUND(DCOVA)
120900101214     C                   LEAVESR
121000101214     C                   ENDIF
121100160616
121200101214     C                   EXSR      $CLRDCV
121300101214     C     KL#DCV        SETLL     DCOVR
121400160616
121500101214     C                   EVAL      @STEP = 'STEP8'
121600160616
121700101214     C                   ENDSR
121800160616
121900160616      *============================================================================
122000160616
122100101214     C     $STEP8        BEGSR
122200160616
122300101214     C     KL#DCV        READE     DCOVR
122400160616
122500101214     C                   IF        %EOF(DCOVA)
122600101214     C                   EVAL      @STEP = 'PREP9'
122700101214     C                   LEAVESR
122800101214     C                   ENDIF
122900160616
123000160616     C*                  IF        DENRDT = CCANDT
123100160616     C*                  LEAVESR
123200160616     C*                  ENDIF
123300160616
123400110513     C                   EVAL      @PLANIN = DVPLAN
123500120803     C                   EVAL      KF@PLN = DVPLAN
123600160615     C     KL#TSAP       CHAIN     AEF04
123700160615     C                   IF        NOT %FOUND(AET004WF)
123800120803     C                   LEAVESR
123900120803     C                   ENDIF
124000160616
124100110802     C                   EXSR      $QUIKD
124200160616
124300110513     C                   EXSR      $PLANSRCH
124400160616
124500110513     C                   IF        PLN@CAT = *BLANKS
124600110513     C                   LEAVESR
124700110513     C                   ENDIF
124800160616
124900101214     C                   EVAL      #CANCEL = CCANDT
125000101214     C                   IF        #CANCEL = 0
125100101214     C                   EVAL      #CANCEL = 99999999
125200101214     C                   ENDIF
125300160616
125400160616      * DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL; LIFE IS MEMBER ONLY
125500160616
125600160616     C                   IF        PLN@CAT = 'DEN'
125700160616     C                   IF        D#CNE > 0
125800160616     C                   IF        D@TRM(D#CNE) = 99999999
125900130131     C                   LEAVESR
126000130131     C                   ENDIF
126100130131     C                   ENDIF
126200160616     C                   ADD       1             D#CNE
126300160616     C                   EVAL      D@PLN(D#CNE) = DVPLAN
126400160616     C                   EVAL      D@ENR(D#CNE) = *BLANKS
126500160616     C                   EVAL      D@FRM(D#CNE) = DENRDT
126600160616     C                   EVAL      D@TRM(D#CNE) = #CANCEL
126700160616     C                   ELSE
126800160616     C                   IF        M#CNE > 0
126900160616     C                   IF        M@TRM(M#CNE) = 99999999
127000130131     C                   LEAVESR
127100130131     C                   ENDIF
127200130131     C                   ENDIF
127300101214     C                   ADD       1             M#CNE
127400101214     C                   EVAL      M@PLN(M#CNE) = DVPLAN
127500101214     C                   EVAL      M@ENR(M#CNE) = *BLANKS
127600101214     C                   EVAL      M@FRM(M#CNE) = DENRDT
127700101214     C                   EVAL      M@TRM(M#CNE) = #CANCEL
127800160616     C                   ENDIF
127900160616
128000101214     C                   ENDSR
128100160616
128200160616      *============================================================================
128300160616
128400111011     C     $QUIKD        BEGSR
128500160616
128600120803     C                   EXSR      $QUIK
128700160616
128800120409     C                   ENDSR
128900160616
129000160616      *============================================================================
129100160616
129200101214     C     $PREP9        BEGSR
129300160616
129400101214     C                   IF        D#CNE = 0 AND M#CNE = 0
129500101214     C                   EVAL      @STEP = 'STEP7'
129600101214     C                   LEAVESR
129700101214     C                   ENDIF
129800160616
129900130315     C                   EVAL      L#CNE = 0
130000130315     C                   EVAL      TERM_LIF = NO
130100101214     C                   EVAL      TERM_DEN = NO
130200101214     C                   EVAL      TERM_MED = NO
130300130520     C                   EVAL      @STEP = 'STEP9'
130400160616
130500130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
130600130520     C                   IF        L@TRM(L#CNE) <> 99999999
130700130520     C                   EXSR      $CHKHEM
130800130520     C                   ENDIF
130900130520     C                   LEAVESR
131000130520     C                   ENDIF
131100160616
131200130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
131300130520     C                   IF        M@TRM(M#CNE) <> 99999999
131400130520     C                   EXSR      $CHKHEM
131500130520     C                   ENDIF
131600130520     C                   LEAVESR
131700130520     C                   ENDIF
131800160616
131900130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
132000130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
132100130520     C                              M@TRM(M#CNE) <> 99999999)
132200130520     C                   EXSR      $CHKHEM
132300130520     C                   ENDIF
132400130520     C                   LEAVESR
132500130520     C                   ENDIF
132600160616
132700130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
132800130520     C                   IF        D@TRM(D#CNE) <> 99999999
132900130520     C                   EXSR      $CHKHEM
133000130520     C                   ENDIF
133100130520     C                   LEAVESR
133200130520     C                   ENDIF
133300160616
133400130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
133500130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
133600130520     C                              D@TRM(D#CNE) <> 99999999)
133700130520     C                   EXSR      $CHKHEM
133800130520     C                   ENDIF
133900130520     C                   LEAVESR
134000130520     C                   ENDIF
134100160616
134200130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
134300130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
134400130520     C                              M@TRM(M#CNE) <> 99999999)
134500130520     C                   EXSR      $CHKHEM
134600130520     C                   ENDIF
134700130520     C                   LEAVESR
134800130520     C                   ENDIF
134900160616
135000130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
135100130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
135200130520     C                              L@TRM(L#CNE) <> 99999999 OR
135300130520     C                              M@TRM(M#CNE) <> 99999999)
135400130520     C                   EXSR      $CHKHEM
135500130520     C                   ENDIF
135600130520     C                   LEAVESR
135700130520     C                   ENDIF
135800160616
135900101214     C                   ENDSR
136000160616
136100160616      *============================================================================
136200160616      * GENERATE DEPENDENT RECORD
136300160616      *============================================================================
136400160616
136500101214     C     $STEP9        BEGSR
136600160616
136700110513     C                   EVAL      WRT@TYPE = 'DEPEND'
136800160616
136900110513     C                   IF        D#CNE = 0 AND M#CNE = 0
137000110513     C                   EVAL      @STEP = 'STEP7'
137100110513     C                   LEAVESR
137200110513     C                   ENDIF
137300160616
137400101214     C                   EVAL      @SS2   = %EDITC(DEPSS#:'X')
137500101210     C                   MOVEL(P)  DLNAME        @LN
137600101210     C                   MOVEL(P)  DFNAME        @FN
137700101210     C                   EVAL      @MI    = DMI
137800160616
137900101210     C                   SELECT
138000101210     C                   WHEN      DRELCD = 'RWI'
138100101210     C                   EVAL      @REL   = '02'
138200101210     C                   WHEN      DRELCD = 'RHU'
138300101210     C                   EVAL      @REL   = '03'
138400101210     C                   WHEN      DRELCD = 'RSO'
138500101210     C                   EVAL      @REL   = '04'
138600101210     C                   WHEN      DRELCD = 'RDA'
138700101210     C                   EVAL      @REL   = '05'
138800130218     C                   WHEN      DRELCD = 'RPA'
138900130218     C                   EVAL      @REL   = '14'
139000130225     C                   OTHER
139100130225     C                   EVAL      @REL   = *BLANKS
139200101210     C                   ENDSL
139300160616
139400101210     C                   SELECT
139500101210     C                   WHEN      DSTUDN = 'Y'
139600101210     C                   EVAL      @SPEC = '1'
139700140812     C                   WHEN      DHNDCP = '3'
139800101210     C                   EVAL      @SPEC = '3'
139900130225     C                   OTHER
140000130225     C                   EVAL      @SPEC = *BLANKS
140100101210     C                   ENDSL
140200160616
140300101210     C                   EVAL      @SEX   = DSEX
140400101210     C                   EVAL      @DOB   = %EDITC(DBIRTH:'X')
140500160616
140600101210     C                   IF        DCOB = 'Y'
140700101210     C                   EVAL      @COB   = 'Y'
140800101210     C                   EVAL      @COBC  = 'OT'
140900101210     C                   EVAL      @COBN  = DCOBPN
141000130225     C                   ELSE
141100130225     C                   EVAL      @COB   = *BLANKS
141200130225     C                   EVAL      @COBC  = *BLANKS
141300130225     C                   EVAL      @COBN = *BLANKS
141400101210     C                   ENDIF
141500160616
141600101214     C                   IF        DADDR1 <> ADDR1
141700101210     C                   EVAL      @AD1   = %TRIM(DADDR1)
141800101210     C                   EVAL      @AD2   = %TRIM(DADDR2)
141900101210     C                   EVAL      @CTY   = %TRIM(DCITY)
142000101210     C                   EVAL      @ST    = DSTATE
142100101210     C                   MOVE      *BLANKS       @9                9
142200101214     C                   IF        DZIP = 0
142300101214     C                   EVAL      @9   = %EDITC(ZIP:'X')
142400101214     C                   ELSE
142500101210     C                   EVAL      @9   = %EDITC(DZIP:'X')
142600101214     C                   ENDIF
142700101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
142800101210     C                   EVAL      @PHN   = %EDITC(DAREA:'X') +
142900101210     C                                      %EDITC(DPHONE:'X')
143000101214     C                   ENDIF
143100160616
143200161109       // if cobra and effective date > 12/01/2016...
143300170317       //if empst = 'C';
143400170317       // if qedt >= effectiveDateD;
143500170317       //  @empst = 'AC';
143600170317       // endif;
143700170317       //endif;
143800161109
143900101210     C                   EXCEPT    MBRF
144000101214     C                   ADD       1             C#RECCNT
144100160616
144200101214     C                   EVAL      @STEP = 'PREPA'
144300160616
144400101210     C                   ENDSR
144500160616
144600160616      *============================================================================
144700160616
144800101214     C     $PREPA        BEGSR
144900160616
145000101214     C                   IF        M#CNE = 0
145100101214     C                   EVAL      @STEP = 'PREPB'
145200101214     C                   LEAVESR
145300101214     C                   ENDIF
145400160616
145500101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
145600160615     C     KL#TSAP       CHAIN     AEF04
145700160615     C                   IF        NOT %FOUND(AET004WF)
145800120803     C                   LEAVESR
145900120803     C                   ENDIF
146000160616
146100101214     C                   IF        TERM_MED = YES
146200101214     C                   EXSR      $WRTERM
146300101214     C                   ENDIF
146400160616
146500110513     C                   EVAL      @PLANIN = KF@PLN
146600160616
146700110802     C                   EXSR      $QUIKD
146800160616
146900110513     C                   EXSR      $PLANSRCH
147000160616
147100110513     C                   IF        PLN@CAT = *BLANKS
147200110513     C                   SETON                                        H2
147300110513     C                   ENDIF
147400160616
147500110513     C                   EVAL      @STEP = 'STEPA'
147600160616
147700101214     C                   ENDSR
147800160616
147900160616      *============================================================================
148000160616
148100101214     C     $STEPA        BEGSR
148200160616
148300110513     C                   IF        CPCID1 = 'MEA'
148400110513     C                   EXSR      $MEAWRT
148500110513     C                   ELSE
148600110513     C                   EXSR      $HMOWRT
148700110513     C                   ENDIF
148800160616
148900110513     C                   ADD       1             C#RECCNT
149000110513     C                   ADD       1             B#RECCNT
149100160616
149200110513     C                   EVAL      @STEP = 'PREPB'
149300160616
149400110513     C                   ENDSR
149500160616
149600160616      *============================================================================
149700160616
149800101214     C     $PREPB        BEGSR
149900160616
150000160616     C                   IF        D#CNE = 0
150100160616     C                   EVAL      @STEP = 'STEP7'
150200160616     C                   LEAVESR
150300160616     C                   ENDIF
150400160616
150500160616     C                   EVAL      KF@PLN = D@PLN(D#CNE)
150600160615     C     KL#TSAP       CHAIN     AEF04
150700160615     C                   IF        NOT %FOUND(AET004WF)
150800120803     C                   LEAVESR
150900120803     C                   ENDIF
151000160616
151100160616     C                   IF        TERM_DEN = YES
151200160616     C                   EXSR      $WRTERM
151300160616     C                   ENDIF
151400160616
151500110513     C                   EVAL      @PLANIN = KF@PLN
151600160616
151700110802     C                   EXSR      $QUIKD
151800160616
151900110513     C                   EXSR      $PLANSRCH
152000160616
152100110513     C                   IF        PLN@CAT = *BLANKS
152200110513     C                   SETON                                        H2
152300110513     C                   ENDIF
152400160616
152500101214     C                   EVAL      @STEP = 'STEPB'
152600160616
152700101214     C                   ENDSR
152800160616
152900160616      *============================================================================
153000160616
153100160616     C     $STEPB        BEGSR
153200160616
153300110513     C                   EXSR      $DENWRT
153400160616
153500160616     C                   ADD       1             C#RECCNT
153600160616     C                   ADD       1             B#RECCNT
153700160616
153800160616     C                   EVAL      @STEP = 'STEP7'
153900160616
154000160616     C                   ENDSR
154100160616
154200160616      *============================================================================
154300160616
154400110512     C     *INZSR        BEGSR
154500160616
154600160314     C     *entry        plist
154700160314     C                   parm                    CARR#CTL
154800160314     C                   parm                    grouper
154900160314
155000110512     C     KL#ACCTL      KLIST
155100120803     C                   KFLD                    KF@CCTL
155200110512     C                   KFLD                    KF@TRS
155300110512     C                   KFLD                    KF@SUB
155400110512     C                   KFLD                    KF@ACC
155500160616
155600140313     C     KL#SQPCD      KLIST
155700140313     C                   KFLD                    KF@SSN
155800140313     C                   KFLD                    KF@SEQ
155900140313     C                   KFLD                    KF@SPCD
156000160616
156100120803     C     KL#TSAP       KLIST
156200120803     C                   KFLD                    KF@TRS
156300120803     C                   KFLD                    KF@SUB
156400120803     C                   KFLD                    KF@ACC
156500120803     C                   KFLD                    KF@PLN
156600160616
156700110512     C     KL#TSA        KLIST
156800110512     C                   KFLD                    KF@TRS
156900110512     C                   KFLD                    KF@SUB
157000110512     C                   KFLD                    KF@ACC
157100160616
157200110512     C     KL#MPLN       KLIST
157300110512     C                   KFLD                    KF@SSN
157400110512     C                   KFLD                    KF@SEQ
157500110512     C                   KFLD                    KF@TRS
157600110512     C                   KFLD                    KF@SUB
157700110512     C                   KFLD                    KF@ACC
157800160616
157900110512     C     KL#CPLN       KLIST
158000120803     C                   KFLD                    KF@CCTL
158100110512     C                   KFLD                    KF@TRS
158200110512     C                   KFLD                    KF@SUB
158300110512     C                   KFLD                    KF@ACC
158400110512     C                   KFLD                    KF@CCTR
158500110512     C                   KFLD                    KF@PLN
158600160616
158700110512     C     KL#DCV        KLIST
158800110512     C                   KFLD                    KF@SSN
158900110512     C                   KFLD                    KF@SEQ
159000160616
159100110512     C     KL#MTR        KLIST
159200110512     C                   KFLD                    KF@SSN
159300110512     C                   KFLD                    KF@SEQ
159400110512     C                   KFLD                    KF#TRM
159500110512     C                   KFLD                    KF@PLN
159600110512     C                   KFLD                    KF@ENR
159700110512     C                   KFLD                    KF@TRS
159800110512     C                   KFLD                    KF@SUB
159900110512     C                   KFLD                    KF@ACC
160000160616
160100110512     C     KL#PCP        KLIST
160200110512     C                   KFLD                    KF@SSN
160300110512     C                   KFLD                    KF@SEQ
160400160616
160500110512     C                   EVAL      #ISO = %DATE
160600110512     C                   MOVE      #ISO          #TODAY            8 0
160700110512     C                   EVAL      #IST = %TIME
160800110512     C                   MOVE      #ISO          #XSX
160900110512     C                   MOVE      #XSX          @DATE
161000110512     C                   MOVE      #IST          #XST
161100110512     C                   MOVE      #XST          @TIME
161200160831
161300110512     C                   ENDSR
161400160616
161500160616      *============================================================================
161600160616      * PLANS LOADED BY ACCOUNT
161700160616      *============================================================================
161800160616
161900110513     C     $PLANLOAD     BEGSR
162000160616
162100110513     C                   EVAL      PP# = 0
162200140313     C                   DO        80
162300110513     C                   ADD       1             PP#
162400110513     C     PP#           OCCUR     CARPLN@
162500110513     C                   CLEAR                   CARPLN@
162600110513     C                   ENDDO
162700110513     C                   EVAL      PC# = 0
162800110513     C                   EVAL      PP# = 0
162900160616
163000110513     C     KL#ACCTL      SETLL     CARPLNR
163100110513     C                   DOU       %EOF(CARPLNP)
163200110513     C     KL#ACCTL      READE     CARPLNR
163300110520     C                   IF        NOT %EOF(CARPLNP)
163400160616
163500110513     C                   ADD       1             PC#
163600110513     C     PC#           OCCUR     CARPLN@
163700110513     C                   EVAL      CARPLN@ = DS@CARPLN
163800160616
163900110513     C                   ENDIF
164000110513     C                   ENDDO
164100160616
164200110513     C                   ENDSR
164300160616
164400160616      *============================================================================
164500160616
164600110513     C     $CLRSTG       BEGSR
164700160616
164800110513     C                   EVAL      #CANCEL = 0
164900160616
165000130315     C                   EVAL      L#CNE = 0
165100130315     C                   CLEAR                   L@PLN
165200130315     C                   CLEAR                   L@ENR
165300130315     C                   CLEAR                   L@FRM
165400130315     C                   CLEAR                   L@TRM
165500160616
165600110513     C                   EVAL      D#CNE = 0
165700110513     C                   CLEAR                   D@PLN
165800110513     C                   CLEAR                   D@ENR
165900110513     C                   CLEAR                   D@FRM
166000110513     C                   CLEAR                   D@TRM
166100110513     C                   EVAL      M#CNE = 0
166200110513     C                   CLEAR                   M@PLN
166300110513     C                   CLEAR                   M@ENR
166400110513     C                   CLEAR                   M@FRM
166500110513     C                   CLEAR                   M@TRM
166600160616
166700110513     C                   EXSR      $CLRDMG
166800160616
166900110513     C                   ENDSR
167000160616
167100160616      *============================================================================
167200160616
167300110513     C     $CLRDMG       BEGSR
167400160616
167500110513     C                   EVAL      @SS1   = *BLANKS
167600110513     C                   EVAL      @SS2   = *BLANKS
167700110513     C                   MOVE      *BLANKS       @LN
167800110513     C                   MOVEL     *BLANKS       @FN
167900110513     C                   EVAL      @MI    = *BLANKS
168000110513     C                   EVAL      @REL   = *BLANKS
168100110513     C                   EVAL      @SEX   = *BLANKS
168200110513     C                   EVAL      @DOB   = *BLANKS
168300110513     C                   EVAL      @SPEC  = *BLANKS
168400110513     C                   EVAL      @COB   = *BLANKS
168500110513     C                   EVAL      @COBC  = *BLANKS
168600110513     C                   EVAL      @COBN  = *BLANKS
168700110513     C                   EVAL      @AD1   = *BLANKS
168800110513     C                   EVAL      @AD2   = *BLANKS
168900110513     C                   EVAL      @CTY   = *BLANKS
169000110513     C                   EVAL      @ST    = *BLANKS
169100110513     C                   EVAL      @ZP5   = *BLANKS
169200110513     C                   EVAL      @PHN   = *BLANKS
169300110513     C                   EVAL      @EMPST = *BLANKS
169400110513     C                   EVAL      @HIRE  = *BLANKS
169500160616
169600110513     C                   ENDSR
169700160616
169800160616      *============================================================================
169900160616
170000110513     C     $CHKHEM       BEGSR
170100160616
170200160616     C                   IF        L#CNE > 0 AND L@TRM(L#CNE) <> 99999999
170300160616     C                   EXSR      $CHKLIF
170400160616     C                   ENDIF
170500160616
170600160616     C                   IF        D#CNE > 0 AND D@TRM(D#CNE) <> 99999999
170700160616     C                   EXSR      $CHKDEN
170800160616     C                   ENDIF
170900160616
171000110513     C                   IF        M#CNE > 0 AND M@TRM(M#CNE) <> 99999999
171100110513     C                   EXSR      $CHKMED
171200110513     C                   ENDIF
171300160616
171400110513     C                   ENDSR
171500160616
171600160616      *============================================================================
171700160616
171800160616     C     $CHKLIF       BEGSR
171900160616
172000160616     C                   EVAL      TERM_LIF = YES
172100160616     C                   EVAL      KF#TRM = L@TRM(L#CNE)
172200160616     C                   EVAL      KF@PLN = L@PLN(L#CNE)
172300160616     C                   EVAL      KF@ENR = L@ENR(L#CNE)
172400160616
172500160809     C     KL#MTR        CHAIN     AET1051F
172600170526     C                   IF        %FOUND
172700160616     C                   EVAL      L#CNE = 0
172800160616     C                   EVAL      TERM_LIF = NO
172900160616     C                   ENDIF
173000160616
173100160616     C                   ENDSR
173200160616
173300160616      *============================================================================
173400160616
173500160616     C     $CHKDEN       BEGSR
173600160616
173700160616     C                   EVAL      TERM_DEN = YES
173800160616     C                   EVAL      KF#TRM = D@TRM(D#CNE)
173900160616     C                   EVAL      KF@PLN = D@PLN(D#CNE)
174000160616     C                   EVAL      KF@ENR = D@ENR(D#CNE)
174100160616
174200160809     C     KL#MTR        CHAIN     AET1051F
174300170526     C                   IF        %FOUND
174400160616     C                   EVAL      D#CNE = 0
174500160616     C                   EVAL      TERM_DEN = NO
174600160616     C                   ENDIF
174700160616
174800160616     C                   ENDSR
174900160616
175000160616      *============================================================================
175100160616
175200110513     C     $CHKMED       BEGSR
175300160616
175400110513     C                   EVAL      TERM_MED = YES
175500110513     C                   EVAL      KF#TRM = M@TRM(M#CNE)
175600110513     C                   EVAL      KF@PLN = M@PLN(M#CNE)
175700110513     C                   EVAL      KF@ENR = M@ENR(M#CNE)
175800160616
175900160809     C     KL#MTR        CHAIN     AET1051F
176000170526     C                   IF        %FOUND
176100110513     C                   EVAL      TERM_MED = NO
176200110513     C                   EVAL      M#CNE = 0
176300110513     C                   ENDIF
176400160616
176500110513     C                   ENDSR
176600160616
176700160616      *============================================================================
176800160616
176900110513     C     $PLANSRCH     BEGSR
177000160616
177100130315     C                   MOVE      *BLANKS       PLN@CAT           5
177200110513     C                   EVAL      PP# = 0
177300110513     C                   CLEAR                   DS@CARPLN
177400160616
177500110513     C                   DO        PC#
177600160616
177700110513     C                   ADD       1             PP#
177800110513     C     PP#           OCCUR     CARPLN@
177900160616
178000110513     C                   IF        XPPLAN = @PLANIN AND
178100110513     C                             XPCCTR = @CCTRIN
178200110513     C                   EVAL      DS@CARPLN = CARPLN@
178300110513     C                   LEAVE
178400110513     C                   ENDIF
178500160616
178600110513     C                   ENDDO
178700160616
178800110513     C                   IF        CPPLAN = *BLANKS
178900110513     C                   LEAVESR
179000110513     C                   ENDIF
179100160616
179200110513     C                   SELECT
179300110520     C                   WHEN      CPCID1 = 'MEA' OR
179400110520     C                             CPCID1 = 'HMO'
179500110520     C                   EVAL      PLN@CAT = 'MED'
179600130409     C                   WHEN      CPCID1 = 'LIFE'
179700130409     C                   EVAL      PLN@CAT = 'LIFE'
179800110520     C                   WHEN      CPCID1 = 'DEN'
179900110520     C                   EVAL      PLN@CAT = 'DEN'
180000110513     C                   ENDSL
180100160616
180200110513     C                   ENDSR
180300160616
180400160616      *============================================================================
180500160616
180600110513     C     $ENROLL       BEGSR
180700160616
180800110513     C                   EVAL      ENR@OUT = *BLANKS
180900110513     C                   SELECT
181000110513     C                   WHEN      ENR@IN = 'TIN' OR ENR@IN = 'TMI'
181100110513     C                   EVAL      ENR@OUT = 'S'
181200110513     C                   WHEN      ENR@IN = 'THW'
181300110513     C                   EVAL      ENR@OUT = 'C'
181400110513     C                   WHEN      ENR@IN = 'TPC'
181500110513     C                   EVAL      ENR@OUT = 'P'
181600110513     C                   WHEN      ENR@IN = 'TP2'
181700110513     C                   EVAL      ENR@OUT = 'Q'
181800110513     C                   WHEN      ENR@IN = 'TFA'
181900110513     C                   EVAL      ENR@OUT = 'F'
182000110513     C                   ENDSL
182100160616
182200110513     C                   ENDSR
182300160616
182400160616      *============================================================================
182500160616
182600110513     C     $WRTERM       BEGSR
182700160616
182800160809     C                   CLEAR                   AET1051F
182900110513     C                   EVAL      NTSSNO         = KF@SSN
183000110513     C                   EVAL      NTDEPNO        = KF@SEQ
183100110513     C                   EVAL      NTTERMDT       = KF#TRM
183200110513     C                   EVAL      NTPLAN         = KF@PLN
183300110513     C                   EVAL      NTCOVTP        = KF@ENR
183400110513     C                   EVAL      NTTRST         = KF@TRS
183500110513     C                   EVAL      NTSUB#         = KF@SUB
183600110513     C                   EVAL      NTACCT         = KF@ACC
183700110513     C                   EVAL      NTTRANSDT      = #TODAY
183800160809     C                   WRITE     AET1051F
183900160616
184000110513     C                   ENDSR
184100160616
184200160616      *============================================================================
184300160616
184400110513     C     $HMOWRT       BEGSR
184500160616
184600110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
184700110513     C                   EVAL      X@ELR = CPCID2                               FILE NUMBER
184800110513     C                   EVAL      M@CC = CACID2                                COMPANY CODE
184900110513     C                   EVAL      M@CLASS = CPCID3                             CLASS CODE
185000110513     C                   EVAL      M@PLAN = CPCID4                              PLAN NUMBER
185100160616
185200110513     C                   EVAL      #XSX = M@FRM(M#CNE)
185300110725     C                   IF        WRT@TYPE = 'DEPEND' AND
185400110725     C                             #XSX < M@MBREFF
185500110725     C                   MOVE      M@MBREFF      X@EFF
185600110725     C                   ELSE
185700110725     C                   MOVE      #XSX          X@EFF
185800110725     C                   ENDIF
185900160616
186000110513     C                   EVAL      #XSX = M@TRM(M#CNE)
186100110513     C                   IF        #XSX = 0 OR #XSX = 99999999
186200110513     C                   MOVE      *BLANKS       X@TRM
186300110513     C                   ELSE
186400110513     C                   MOVE      #XSX          X@TRM
186500110513     C                   ENDIF
186600160616
186700110513     C                   IF        WRT@TYPE = 'MEMBER'
186800110513     C                   EVAL      KF@SEQ = 0
186900110513     C                   EVAL      ENR@IN = M@ENR(M#CNE)
187000110513     C                   EXSR      $ENROLL
187100110513     C                   EVAL      X@TIER = ENR@OUT
187200110513     C                   ELSE
187300110513     C                   EVAL      X@TIER = *BLANKS
187400110513     C                   ENDIF
187500160616
187600140313     C                   EVAL      KF@SPCD = 'MED'
187700140313     C                   EVAL      M@PCP = *BLANKS
187800140313     C                   EVAL      M@NPI = *BLANKS
187900140313     C                   EVAL      M@PCPCI = *BLANKS
188000160616
188100140313     C                   EXSR      $PCP
188200160616
188300140313     C                   IF        DOCTOR <> *BLANKS
188400140313     C                   EVAL      M@PCP = DOCTOR
188500140313     C                   EVAL      M@NPI = 'Y'
188600140313     C                   EVAL      M@PCPCI = '0'
188700140313     C                   ENDIF
188800160616
188900110513     C                   EXCEPT    HMOF
189000160616
189100110513     C                   ENDSR
189200160616
189300160616      *============================================================================
189400160616
189500110513     C     $MEAWRT       BEGSR
189600160616
189700110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
189800110513     C                   EVAL      X@ELR = CPCID2                               ELR
189900140313     C                   EVAL      E@SFX = CPCID3                               SUFFIX
190000140313     C                   EVAL      E@ACCT = CPCID4                              ACCOUNT
190100140313     C                   EVAL      E@PLAN = CPCID5                              PLAN
190200140313     C                   EVAL      E@CLM = CPCID6                               CLAIM OFFICE
190300160616
190400110513     C                   EVAL      #XSX = M@FRM(M#CNE)
190500110725     C                   IF        WRT@TYPE = 'DEPEND' AND
190600110725     C                             #XSX < M@MBREFF
190700110725     C                   MOVE      M@MBREFF      X@EFF
190800110725     C                   ELSE
190900110725     C                   MOVE      #XSX          X@EFF
191000110725     C                   ENDIF
191100160616
191200160616     C                   EVAL      #XSX = M@TRM(M#CNE)
191300110513     C                   IF        #XSX = 0 OR #XSX = 99999999
191400110513     C                   MOVE      *BLANKS       X@TRM
191500110513     C                   ELSE
191600110513     C                   MOVE      #XSX          X@TRM
191700110513     C                   ENDIF
191800160616
191900140313     C                   MOVE      *BLANKS       E@CBREXP
192000140313     C                   MOVE      *BLANKS       E@CBREVT
192100140313     C                   MOVE      *BLANKS       E@CBRLEN
192200140313     C                   IF        WRT@TYPE = 'MEMBER'
192300140425     C                   IF        EMPST = 'C' AND
192400140425     C                             CEXPDT > 0
192500140313     C                   MOVE      CEXPDT        E@CBREXP
192600140313     C                   MOVE      QEDT          E@CBREVT
192700140313     C                   MOVE      CEXPDT        #MINUEND
192800140313     C                   MOVE      QEDT          #SUBTRAEND
192900140313     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
193000140313     C                   Z-ADD     #DIFFRNC      #2S0
193100140313     C                   MOVE      #2S0          E@CBRLEN
193200140313     C                   ENDIF
193300140313     C                   ENDIF
193400160616
193500140313     C                   EVAL      *IN80 = *OFF
193600140313     C                   EVAL      KF@SPCD = 'MED'
193700140313     C                   EVAL      E@PCP = *BLANKS
193800140313     C                   EXSR      $PCP
193900140313     C                   IF        DOCTOR <> *BLANKS
194000140313     C                   EVAL      E@PCP = DOCTOR
194100140313     C                   EVAL      *IN80 = *ON
194200140313     C                   ENDIF
194300160616
194400161109       // if cobra and effective date > 12/01/2016...
194500170317       //if empst = 'C';
194600170317       // if e@cbrevt >= effectiveDate;
194700170317       //  e@cbrexp = ' ';
194800170317       //   e@cbrevt = ' ';
194900170317       //  e@cbrlen = ' ';
195000170317       // endif;
195100170317       //endif;
195200161109
195300140313     C                   EXCEPT    MEAF
195400160616
195500110513     C                   ENDSR
195600160616
195700160616      *============================================================================
195800160616
195900140313     C     $PCP          BEGSR
196000160616
196100140313     C                   MOVE      *BLANKS       DOCTOR            7
196200140313     C     KL#SQPCD      CHAIN     PCPR
196300140313     C                   IF        NOT %FOUND(PCPL1)
196400140313     C                   LEAVESR
196500140313     C                   ENDIF
196600140313     C     KL#SQPCD      SETLL     PCPR
196700140313     C                   DOU       %EOF(PCPL1)
196800140313     C     KL#SQPCD      READE     PCPR
196900140313     C                   IF        NOT %EOF(PCPL1) AND PCCAN = 0
197000140313     C                   MOVEL(P)  PCID#         DOCTOR
197100140313     C                   LEAVESR
197200140313     C                   ENDIF
197300140313     C                   ENDDO
197400160616
197500140313     C                   ENDSR
197600160616
197700160616      *============================================================================
197800160616
197900110513     C     $CLRDCV       BEGSR
198000160616
198100110513     C                   MOVE      *BLANKS       @LN
198200110513     C                   MOVEL     *BLANKS       @FN
198300110513     C                   EVAL      @SS2   = *BLANKS
198400110513     C                   EVAL      @MI    = *BLANKS
198500110513     C                   EVAL      @REL   = *BLANKS
198600110513     C                   EVAL      @SEX   = *BLANKS
198700110513     C                   EVAL      @DOB   = *BLANKS
198800110513     C                   EVAL      @SPEC  = *BLANKS
198900110513     C                   EVAL      @COB   = *BLANKS
199000110513     C                   EVAL      @COBC  = *BLANKS
199100110513     C                   EVAL      @COBN  = *BLANKS
199200160616
199300110513     C                   EVAL      #CANCEL = 0
199400110513     C                   EVAL      D#CNE = 0
199500110513     C                   CLEAR                   D@PLN
199600110513     C                   CLEAR                   D@ENR
199700110513     C                   CLEAR                   D@FRM
199800110513     C                   CLEAR                   D@TRM
199900110513     C                   EVAL      M#CNE = 0
200000110513     C                   CLEAR                   M@PLN
200100110513     C                   CLEAR                   M@ENR
200200110513     C                   CLEAR                   M@FRM
200300110513     C                   CLEAR                   M@TRM
200400160616
200500110513     C                   ENDSR
200600160616
200700160616      *============================================================================
200800160616
200900110513     C     $DENWRT       BEGSR
201000160616
201100160616     C                   EVAL      X@LAY = CPCID1                               LAYOUT
201200160616     C                   EVAL      X@ELR = CPCID2                               ELR
201300160616     C                   EVAL      D@SFX = CPCID3                               SUFFIX
201400160616     C                   EVAL      D@ACCT = CPCID4                              ACCOUNT
201500160616     C                   EVAL      D@PLAN = CPCID5                              PLAN
201600160616     C                   EVAL      D@CLM = CPCID6                               CLAIM OFFICE
201700110524     C                   EVAL      DNTLATE = '0'
201800160616
201900160616     C                   EVAL      #XSX = D@FRM(D#CNE)
202000110725     C                   IF        WRT@TYPE = 'DEPEND' AND
202100110725     C                             #XSX < D@MBREFF
202200110725     C                   MOVE      D@MBREFF      X@EFF
202300110725     C                   ELSE
202400110725     C                   MOVE      #XSX          X@EFF
202500110725     C                   ENDIF
202600160616
202700160616     C                   EVAL      #XSX = D@TRM(D#CNE)
202800160616     C                   IF        #XSX = 0 OR #XSX = 99999999
202900160616     C                   MOVE      *BLANKS       X@TRM
203000160616     C                   ELSE
203100160616     C                   MOVE      #XSX          X@TRM
203200160616     C                   ENDIF
203300160616
203400130211     C                   MOVE      *BLANKS       D@CBREXP
203500130211     C                   MOVE      *BLANKS       D@CBREVT
203600130211     C                   MOVE      *BLANKS       D@CBRLEN
203700110513     C                   IF        WRT@TYPE = 'MEMBER'
203800160616     C                   IF        EMPST = 'C' AND CEXPDT <> 0
203900160616     C                   MOVE      CEXPDT        D@CBREXP
204000160616     C                   MOVE      QEDT          D@CBREVT
204100160616     C                   MOVE      CEXPDT        #MINUEND
204200160616     C                   MOVE      QEDT          #SUBTRAEND
204300160616     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
204400160616     C                   Z-ADD     #DIFFRNC      #2S0
204500160616     C                   MOVE      #2S0          D@CBRLEN
204600160616     C                   ENDIF
204700160616     C                   ENDIF
204800160616
204900160616     C                   MOVE      '0'           D@OOAI
205000160616
205100140313     C                   EVAL      KF@SPCD = 'DEN'
205200140313     C                   EVAL      D@PCD = *BLANKS
205300140313     C                   EVAL      *IN81 = *OFF
205400140313     C                   MOVE      *BLANKS       DOCTOR
205500160616
205600140313     C                   EXSR      $PCP
205700160616
205800140313     C                   IF        DOCTOR <> *BLANKS
205900140313     C                   EVAL      D@PCD = DOCTOR
206000140313     C                   EVAL      *IN81 = *ON
206100140313     C                   ENDIF
206200160616
206300120123     C     *LIKE         DEFINE    H@C#          BUC#
206400120123     C                   EVAL      BUC# = H@C#
206500160616
206600120327     C                   SELECT
206700131126     C                   WHEN      KF@TRS = 591 AND KF@SUB = 009 AND            WILMOT MODULAR
206800131126     C                             KF@ACC = 0202                                 STRUCTURES
206900131227     C                   EVAL      H@C# = '0638156'
207000140702     C                   WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            REDLAND
207100140702     C                             KF@ACC = 0475                                 BAPTISTS
207200140702     C                   EVAL      H@C# = '0725572'
207300120327     C                   WHEN      KF@TRS = 825 AND KF@SUB = 001 AND            CREATIVE
207400120123     C                             KF@ACC = 0014                                 LOGISTICS
207500120123     C                   EVAL      H@C# = '0133860'
207600130905     C                   WHEN      KF@TRS = 905 AND KF@SUB = 001 AND            CCL USA
207700130905     C                             KF@ACC = 0092
207800130905     C                   EVAL      H@C# = '0638423'
207900140423     C                   WHEN      KF@TRS = 003 AND KF@SUB = 001 AND            FRAME RITE
208000140423     C                             KF@ACC = 0104
208100140423     C                   EVAL      H@C# = '0306511'
208200130520     C                   WHEN      KF@TRS = 900 AND KF@SUB = 003 AND            PERFECT
208300130520     C                             KF@ACC = 0045                                 SETTINGS
208400130520     C                   EVAL      H@C# = '0474109'
208500121024     C                   WHEN      KF@TRS = 591 AND KF@SUB = 011 AND            MCCALLISTER
208600121024     C                             KF@ACC = 0446                                 ARCHITECT
208700121024     C                   EVAL      H@C# = '0565330'
208800130716     C                   WHEN      KF@TRS = 591 AND KF@SUB = 005 AND            JD CLARK PROF
208900130716     C                             KF@ACC = 0451                                 SERVICES
209000130716     C                   EVAL      H@C# = '0519890'
209100130627     C                   WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            DYSON CONSTRUCTION
209200130627     C                             KF@ACC = 0459                                 COMPANY
209300130627     C                   EVAL      H@C# = '0788122'
209400130903     C                   WHEN      KF@TRS = 591 AND KF@SUB = 004 AND            STROUSE CORP
209500130903     C                             KF@ACC = 0482
209600130903     C                   EVAL      H@C# = '0837451'
209700130712     C                   WHEN      KF@TRS = 900 AND KF@SUB = 007 AND            CAPLAN BROTHERS
209800130712     C                             KF@ACC = 0075
209900130712     C                   EVAL      H@C# = '0837533'
210000120806     C                   WHEN      KF@TRS = 900 AND KF@SUB = 101 AND            INTEGRA HEALTH
210100130110     C                             KF@ACC = 0042 AND
210200130110     C                             (STATE = 'TN' OR STATE = 'FL' OR
210300130718     C                              STATE = 'OH' OR STATE = 'MA') AND
210400120806     C                             (@PLANIN = 'DAAD' OR @PLANIN = 'BAAD')
210500120806     C                   EVAL      H@C# = '0503428'
210600160616     C                   ENDSL
210700160616
210800161109       // if cobra and effective date > 12/01/2016...
210900170317       //if empst = 'C';
211000170317       // if d@cbrevt >= effectiveDate;
211100170317       //  d@cbrexp = ' ';
211200170317       //   d@cbrevt = ' ';
211300170317       //  d@cbrlen = ' ';
211400170317       // endif;
211500170317       //endif;
211600161109
211700160616     C                   EXCEPT    DENF
211800151217     c                   EVAL      H@C# = BUC#
211900160616
212000160616     C                   ENDSR
212100160616
212200160616      *============================================================================
212300160616
212400160809     OAET1050WF EADD         HDRF
212500101203     O                                            6 'HEADER'
212600160810     O                                            8 'P'
212700101206     O                       H@SI                28
212800101203     O                                           29 '0'
212900101203     O                       C1                  43
213000101203     O                       D1                  51
213100101203     O                       T1                  57
213200101206     O                                          131 'CONSOLIDATED ELIGIBILITY'
213300110502     O                       H@RI               167
213400101206     O                       H@CC               169
213500101228     O                       H@GN               176
213600101206     O                       H@CN               191
213700101206     O                       H@C#               198
213800101203     O                       D2                 206
213900110825     O                                          216 'MC'
214000101223     O                                          231 '*'
214100160616
214200160616      *============================================================================
214300160809     OAET1050WF EADD         MBRF
214400101203     O                                            6 'MEMBER'
214500101203     O                       @SS1                16
214600101203     O                       @SS2                25
214700101203     O                       @FN                 75
214800101203     O                       @MI                 76
214900101203     O                       @LN                 96
215000101203     O                       @REL               101
215100101203     O                       @SEX               103
215200101203     O                       @DOB               111
215300101203     O                       @SPEC              112
215400101203     O                                          113 '0'
215500101203     O                       @COB               123
215600101203     O                       @COBC              125
215700101203     O                       @COBN              145
215800101203     O                       @AD1               175
215900101203     O                       @AD2               205
216000101203     O                       @CTY               315
216100101203     O                       @ST                317
216200101203     O                       @ZP5               322
216300101203     O                       @PHN               349
216400141211     O               87                         576 '21207'
216500140626     O               88                         576 '21740'
216600141120     O               89                         576 '20171'
216700101203     O                       @EMPST             665
216800101203     O                       @HIRE              673
216900101223     O                                         1231 '*'
217000160616
217100160616      *============================================================================
217200160809     OAET1050WF EADD         HMOF
217300101213     O                                            7 'BENEFIT'
217400101213     O                       X@LAY               10
217500101214     O                       X@ELR               24
217600101213     O                       M@CC                26
217700101213     O                       H@GN                38
217800101213     O                       M@CLASS             44
217900101213     O                       M@PLAN              50
218000101213     O                       X@EFF               58
218100110929     O                       X@TRM               66
218200101213     O                       X@TIER              69
218300101213     O                       M@PCP              160
218400101213     O                       M@NPI              161
218500101213     O                       M@PCPCI            186
218600101223     O                                          323 '*'
218700160616
218800160616      *============================================================================
218900160809     OAET1050WF EADD         MEAF
219000140313     O                                            7 'BENEFIT'
219100140313     O                                           10 'MEA'
219200140313     O                       X@ELR               24
219300140313     O                       H@C#                31
219400140313     O                       E@SFX               34
219500140313     O                       E@ACCT              44
219600140313     O                       E@PLAN              50
219700140313     O                       X@EFF               58
219800140313     O                       X@TRM               66
219900140313     O                       E@CLM               71
220000140313     *** PCP BGN
220100140313     O                       E@PCP              127
220200140313     O               80                         161 'N'
220300140313     O               80                         186 '0'
220400140313     *** PCP END
220500140313     O                                          389 '0'
220600140313     *** COBRA BGN
220700140313     O                       E@CBREXP           466
220800140313     O                       E@CBREVT           516
220900140313     O                       E@CBRLEN           560
221000140313     *** COBRA END
221100140313     O                                          678 '*'
221200160616
221300160616      *============================================================================
221400160809     OAET1050WF EADD         DENF
221500101213     O                                            7 'BENEFIT'
221600101213     O                       X@LAY               10
221700101214     O                       X@ELR               24
221800101214     O                       H@C#                31
221900101213     O                       D@SFX               34
222000101213     O                       D@ACCT              44
222100101213     O                       D@PLAN              50
222200101213     O                       X@EFF               58
222300110929     O                       X@TRM               66
222400101213     O                       D@CLM               71
222500140313     *** PCD BGN
222600140313     O                       D@PCD              200
222700140313     O               81                         236 '0'
222800140313     *** PCD END
222900140313     O                                          389 '0'
223000140313     *** COBRA BGN
223100140313     O                       D@CBREXP           466
223200140313     O                       D@CBREVT           516
223300140313     O                       D@CBRLEN           560
223400140313     *** COBRA END
223500140313     O                       D@OOAI             609
223600140313     O                                          678 '*'
223700160616
223800160616      *============================================================================
223900160809     OAET1050WF EADD         LIFF
224000130315     O                                            7 'BENEFIT'
224100130412     O                                           11 'LIFE'
224200130315     O                       X@ELR               24
224300130319     O                       H@C#3               31
224400130315     O                       L@SFX               34
224500130315     O                       L@ACCT              44
224600130315     O                       L@PLAN              50
224700130315     O                       X@EFF               58
224800130315     O                       X@TRM               66
224900130315     O                       L@CLM               71
225000130315     O                       L@CBREXP           466
225100130315     O                       L@CBREVT           516
225200130315     O                       L@CBRLEN           560
225300130315     O                       L@SALARY           658
225400130315     O                                          659 '1'
225500130315     O                                          678 '*'
225600160616
225700160616      *============================================================================
225800160809     OAET1050WF EADD         TRLF
225900101203     O                                            7 'TRAILER'
226000101203     O                       @TREC               17
226100101203     O                       D1                  25
226200101203     O                       T1                  31
226300101203     O                       @BREC               41
226400101223     O                                           69 '*'
226500160616
226600160616      *============================================================================
