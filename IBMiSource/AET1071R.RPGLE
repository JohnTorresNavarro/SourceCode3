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
002500160919     FAET1070WF O  A F 1231        DISK
002600101206     ** FLAT FILE
002700151217
002800160919     FAET1071WF IF A E           K DISK
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
022300160824
022400160824     C     CARR#CTL      CHAIN     CARXPTR
022500160824
022600160824     C     CARR#CTL      SETLL     CARACCR
022700160616
022800101026     C                   DOU       @STEP = 'LEAVE'
022900101026     C     @STEP         CASEQ     'PREP1'       $PREP1
023000101026     C     @STEP         CASEQ     'STEP1'       $STEP1
023100101026     C     @STEP         CASEQ     'STEP2'       $STEP2
023200101026     C     @STEP         CASEQ     'STEP3'       $STEP3
023300101026     C     @STEP         CASEQ     'PREP4'       $PREP4
023400101026     C     @STEP         CASEQ     'STEP4'       $STEP4
023500101026     C     @STEP         CASEQ     'PREP5'       $PREP5
023600101026     C     @STEP         CASEQ     'STEP5'       $STEP5
023700101214     C     @STEP         CASEQ     'PREP6'       $PREP6
023800101026     C     @STEP         CASEQ     'STEP6'       $STEP6
023900101214     C     @STEP         CASEQ     'PREP7'       $PREP7
024000101214     C     @STEP         CASEQ     'STEP7'       $STEP7
024100101214     C     @STEP         CASEQ     'STEP8'       $STEP8
024200101214     C     @STEP         CASEQ     'PREP9'       $PREP9
024300101214     C     @STEP         CASEQ     'STEP9'       $STEP9
024400101214     C     @STEP         CASEQ     'PREPA'       $PREPA
024500101214     C     @STEP         CASEQ     'STEPA'       $STEPA
024600101214     C     @STEP         CASEQ     'PREPB'       $PREPB
024700101214     C     @STEP         CASEQ     'STEPB'       $STEPB
024800130315     C     @STEP         CASEQ     'PREPC'       $PREPC
024900130315     C     @STEP         CASEQ     'STEPC'       $STEPC
025000101026     C                   ENDCS
025100101026     C                   ENDDO
025200160616
025300101206    ***  TRAILER RECORD
025400101026     C                   ADD       2             C#RECCNT
025500101214     C                   MOVE      C#RECCNT      @TREC            10 0
025600101214     C                   MOVE      B#RECCNT      @BREC            10 0
025700101214     C                   EXCEPT    TRLF
025800160616
025900101026     C                   EVAL      *INLR = *ON
026000160616
026100160616      *============================================================================
026200160616
026300110802     C     $HEADR        BEGSR
026400160616
026500110802     C                   EVAL      D1 = @DATE
026600110802     C                   EVAL      D2 = @DATE
026700110802     C                   EVAL      T1 = @TIME
026800110802     C                   EVAL      C1 = @DATE + @TIME
026900160616
027000160315     C**** carr#ctl      CHAIN     CARACCR
027100160616
027200110802     C                   EVAL      H@SI = %TRIM(CACID1)                         SUBMITTER ID
027300110802     C                   EVAL      H@CC = %SUBST(CACID2:1:2)                    COMPANY CODE
027400110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
027500110802     C                   MOVEL(P)  CACID4        H@CN                           CUSTOMER NAME
027600110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
027700130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
027800160616
027900110802     C                   EXCEPT    HDRF
028000160616
028100160315     C                   eval      firstTime = 'N'
028200160315
028300110802     C                   ENDSR
028400160616
028500160616      *============================================================================
028600110802     C     $PREP1        BEGSR
028700160616
028800160919     C     CARR#CTL      READE     CARACCR
028900160616
029000110512     C                   IF        %EOF(CARACCP)
029100120803      *
029200120815     C*                  IF        KF@CCTL = CARR#CTL
029300120815     C*                  EVAL      KF@CCTL = CARR#CTL2
029400120815     C*    KF@CCTL       SETLL     CARACCR
029500120815     C*                  ELSE
029600110512     C                   EVAL      @STEP = 'LEAVE'
029700120815     C*                  ENDIF
029800120803      *
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
031100160824     c****               if        firstTime = 'Y'
031200160824     c****               exsr      $headr
031300160824     c****               endif
031400160315
031500110802    *** THESE FIELDS RESET FOR EACH SMALL GROUP READ
031600160919     C                   EVAL      H@SI = %TRIM(CACID1)                         SUBMITTER ID
031700160919     C                   EVAL      H@CC = %SUBST(CACID2:1:2)                    COMPANY CODE
031800110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
031900160919     C                   MOVEL(P)  CACID4        H@CN                           CUSTOMER NAME
032000110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
032100130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
032200160616
032300160919     C                   EVAL      D1 = @DATE
032400160919     C                   EVAL      D2 = @DATE
032500160919     C                   EVAL      T1 = @TIME
032600160919     C                   EVAL      C1 = @DATE + @TIME
032700160919
032800110512     C                   EVAL      KF@TRS = CATRST
032900110512     C                   EVAL      KF@SUB = CASUB#
033000110512     C                   EVAL      KF@ACC = CAACCT
033100160616
033200110512     C                   EXSR      $PLANLOAD
033300160616
033400160824     c                   if        flag = ' '
033500160824     C                   EXCEPT    HDRF
033600160824     c                   movel     'Y'           flag              1
033700160824     c                   endif
033800160824
033900101206     C                   EVAL      @STEP = 'STEP1'
034000160616
034100110512     C                   ENDSR
034200160616
034300160616      *============================================================================
034400160616
034500101206     C     $STEP1        BEGSR
034600160616
034700101206     C                   EVAL      KF@PLN = *BLANKS
034800101206     C                   EVAL      KF@TRM = 0
034900101206     C                   EVAL      KF@SSN = 0
035000101206     C                   EVAL      KF@SEQ = 0
035100160616
035200101206     C     KL#TSA        SETLL     MEMBR
035300160616
035400101206     C                   EVAL      @STEP = 'STEP2'
035500160616
035600101206     C                   ENDSR
035700160616
035800160616      *============================================================================
035900160616
036000101206     C     $STEP2        BEGSR
036100160616
036200101206     C     KL#TSA        READE     MEMBR
036300160616
036400101206     C                   IF        %EOF(MEMAC#1)
036500110512     C                   EVAL      @STEP = 'PREP1'
036600101206     C                   LEAVESR
036700101206     C                   ENDIF
036800160616
036900101206     C                   EVAL      KF@SSN = MBSSNO
037000101214     C                   MOVE      *ZEROS        KF@SEQ
037100120803     C                   EVAL      WRT@TYPE = 'MEMBER'
037200160616
037300101206     C     KL#MPLN       SETLL     MCOVR
037400160616
037500101206     C                   EXSR      $CLRSTG
037600160616
037700101206     C                   EVAL      @STEP = 'STEP3'
037800160616
037900101206     C                   ENDSR
038000160616
038100160616      *============================================================================
038200160616
038300101206     C     $STEP3        BEGSR
038400160616
038500101206     C     KL#MPLN       READE     MCOVR
038600160616
038700101206     C                   IF        %EOF(MCOVMPLN)
038800101206     C                   EVAL      @STEP = 'PREP4'
038900101206     C                   LEAVESR
039000101206     C                   ENDIF
039100160616
039200130131     C*                  IF        ENRLDT = CANDT
039300130131     C*                  LEAVESR
039400130131     C*                  ENDIF
039500160616
039600120803     C                   EVAL      KF@PLN = MCPLAN
039700160615     C     KL#TSAP       CHAIN     AEF04
039800160615     C                   IF        NOT %FOUND(AET004WF)
039900120803     C                   LEAVESR
040000120803     C                   ENDIF
040100160616
040200110512     C                   EVAL      @PLANIN = MCPLAN
040300111020     C                   EVAL      ENR@IN = MCOVTP
040400160616
040500110802     C                   EXSR      $QUIK
040600160616
040700110512     C                   EXSR      $PLANSRCH
040800160616
040900110512     C                   IF        PLN@CAT = *BLANKS
041000110512     C                   LEAVESR
041100110512     C                   ENDIF
041200160616
041300101206     C                   IF        CANDT = 0
041400101206     C                   EVAL      #CANCEL = 99999999
041500101206     C                   ELSE
041600101206     C                   EVAL      #CANCEL = CANDT
041700101206     C                   ENDIF
041800160616
041900130315    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL;
042000130315    *** LIF IS LIFE;
042100130315     C                   SELECT
042200160616
042300160616     C                   WHEN      PLN@CAT = 'LIFE'
042400160616     C                   IF        L#CNE > 0
042500160616     C                   IF        L@TRM(L#CNE) = 99999999
042600130315     C                   LEAVESR
042700130315     C                   ENDIF
042800130315     C                   ENDIF
042900160616     C                   ADD       1             L#CNE
043000160616     C                   EVAL      L@PLN(L#CNE) = MCPLAN
043100160616     C                   EVAL      L@ENR(L#CNE) = MCOVTP
043200160616     C                   EVAL      L@FRM(L#CNE) = ENRLDT
043300160616     C                   EVAL      L@TRM(L#CNE) = #CANCEL
043400160616
043500160616     C                   WHEN      PLN@CAT = 'DEN'
043600160616     C                   IF        D#CNE > 0
043700160616     C                   IF        D@TRM(D#CNE) = 99999999
043800130131     C                   LEAVESR
043900130131     C                   ENDIF
044000130131     C                   ENDIF
044100160616     C                   ADD       1             D#CNE
044200160616     C                   EVAL      D@PLN(D#CNE) = MCPLAN
044300160616     C                   EVAL      D@ENR(D#CNE) = MCOVTP
044400160616     C                   EVAL      D@FRM(D#CNE) = ENRLDT
044500160616     C                   EVAL      D@TRM(D#CNE) = #CANCEL
044600160616
044700130315     C                   OTHER
044800160616     C                   IF        M#CNE > 0
044900160616     C                   IF        M@TRM(M#CNE) = 99999999
045000130131     C                   LEAVESR
045100130131     C                   ENDIF
045200130131     C                   ENDIF
045300101206     C                   ADD       1             M#CNE
045400101206     C                   EVAL      M@PLN(M#CNE) = MCPLAN
045500101206     C                   EVAL      M@ENR(M#CNE) = MCOVTP
045600101206     C                   EVAL      M@FRM(M#CNE) = ENRLDT
045700101206     C                   EVAL      M@TRM(M#CNE) = #CANCEL
045800160616
045900160616     C                   ENDSL
046000160616
046100110512     C                   ENDSR
046200160616
046300160616      *============================================================================
046400160616
046500110802     C     $QUIK         BEGSR
046600160616
046700110805     C                   EVAL      @CCTRIN = *BLANKS
046800160616
046900160615     C     AE4MAP        CASEQ     '2TIER     '  $METH01
047000160615     C     AE4MAP        CASEQ     'ITOBJECTS '  $METH02
047100160615     C     AE4MAP        CASEQ     'NORULE    '  $METH03
047200160615     C     AE4MAP        CASEQ     'STATETIER '  $METH04
047300160615     C     AE4MAP        CASEQ     'TIERSTS   '  $METH05
047400160615     C     AE4MAP        CASEQ     'MAYOR     '  $METH06
047500160615     C     AE4MAP        CASEQ     'EMPSTS    '  $METH07
047600160615     C     AE4MAP        CASEQ     'JUSTSTATE '  $METH08
047700160615     C     AE4MAP        CASEQ     'JOHNLS    '  $METH09
047800160615     C     AE4MAP        CASEQ     'CREATIVE  '  $METH10
047900160615     C     AE4MAP        CASEQ     'INTEGRA   '  $METH11
048000160615     C     AE4MAP        CASEQ     'STSTATE   '  $METH12
048100160615     C     AE4MAP        CASEQ     'INTEGRA   '  $METH11
048200160615     C     AE4MAP        CASEQ     'STIERSTS  '  $METH13
048300120803     C                   ENDCS
048400160616
048500120803     C                   ENDSR
048600160616
048700160616      *============================================================================
048800160616
048900160616      * 2 TIER = AETNA HAS TWO TIERS, IND AND FAM
049000160616      *  MEMBERS HAVE 'TIN' CONVERTED TO 'IND' AND NON-'TIN' CONVERTED TO 'FAM'
049100160616      *  DEPENDENTS HAVE 'FAM' ONLY
049200160616      *
049300160616      * IND, FAM
049400160616
049500160616      *============================================================================
049600160616
049700120803     C     $METH01       BEGSR
049800160616
049900120803     C                   IF        WRT@TYPE = 'MEMBER'
050000160616
050100120803     C                   IF        ENR@IN = 'TIN'
050200120803     C                   EVAL      @CCTRIN = 'IND'
050300120803     C                   ELSE
050400120803     C                   EVAL      @CCTRIN = 'FAM'
050500120803     C                   ENDIF
050600160616
050700120803     C                   ENDIF
050800160616
050900120803     C                   IF        WRT@TYPE = 'DEPEND'
051000160616
051100120803     C                   EVAL      @CCTRIN = 'FAM'
051200160616
051300120803     C                   ENDIF
051400160616
051500120803     C                   ENDSR
051600160616
051700160616      *============================================================================
051800160616
051900160616      * ITOBJECTS = IF YOU ARE NOT 'VA' OR 'OH' STATE CODES, YOU ARE 'XX'
052000160616
052100160616      * VA, OH, XX
052200160616
052300160616      *============================================================================
052400160616
052500120803     C     $METH02       BEGSR
052600160616
052700120803     C                   IF        STATE <> 'VA' AND STATE <> 'OH'
052800120803     C                   EVAL      @CCTRIN = 'XX '
052900120803     C                   ELSE
053000120803     C                   EVAL      @CCTRIN = STATE
053100120803     C                   ENDIF
053200160616
053300120803     C                   ENDSR
053400160616
053500160616      *============================================================================
053600160616      * NORULE = NUFF SAID
053700160616      *============================================================================
053800160616
053900120803     C     $METH03       BEGSR
054000160616
054100120803     C                   EVAL      @CCTRIN = *BLANKS
054200160616
054300120803     C                   ENDSR
054400160616
054500160616      *============================================================================
054600160616      * STATETIER
054700160616      *  START WITH STATE CODE
054800160616      *  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
054900160616      *  DEPENDENTS HAVE 'F' ONLY
055000160616      * MDI, MDF, ETC...
055100160616      *============================================================================
055200160616
055300120803     C     $METH04       BEGSR
055400160616
055500120803     C                   EVAL      @CCTRIN = STATE
055600160616
055700120803     C                   IF        WRT@TYPE = 'MEMBER'
055800120803     C                   IF        ENR@IN = 'TIN'
055900120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
056000120803     C                   ELSE
056100120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
056200120803     C                   ENDIF
056300120803     C                   ENDIF
056400160616
056500120803     C                   IF        WRT@TYPE = 'DEPEND'
056600120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
056700120803     C                   ENDIF
056800160616
056900120803     C                   ENDSR
057000160616
057100160616      *============================================================================
057200160616      * TIERSTS
057300160616      *  START WITH EMPLOYMENT STATUS, ACTIVE IS 'ACT' AND COBRA IS 'COB'
057400160616      *  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
057500160616      *  DEPENDENTS HAVE 'F' ONLY
057600160616      *
057700160616      * ACI, ACF, COI, COF
057800160616      *============================================================================
057900160616
058000120803     C     $METH05       BEGSR
058100160616
058200120803     C                   IF        EMPST =  'C'
058300120803     C                   EVAL      @CCTRIN = 'COB'
058400120803     C                   ELSE
058500120803     C                   EVAL      @CCTRIN = 'ACT'
058600120803     C                   ENDIF
058700160616
058800120803     C                   IF        ENR@IN = 'TIN'
058900120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
059000120803     C                   ELSE
059100120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
059200120803     C                   ENDIF
059300160616
059400120803     C                   ENDSR
059500160616
059600160616      *============================================================================
059700160616      * MAYOR
059800160616      *  WELL, FOR THE PLAN 'DAAU' IF THE STATE IS 'WV' THEN PLACE TIER STATUS SUFFIX
059900160616      *       BY TYPE OF PEEP; FOR OTHER STATES, USE A SIMPLE TIER CHECK.
060000160616      *
060100160616      *  WVI, WVF, IND, FAM
060200160616      *
060300160616      *  NOW, FOR THE PLAN 'DAAT' IF THE STATE IS 'WV' THEN PLACE EMPLOYMENT STATUS SUFFIX
060400160616      *       BY TYPE OF PEEP; FOR OTHER STATES, EMPLOYMENT STATUS AND TIER.
060500160616      *
060600160616      *  WVI, WVF, CBI, CBF, ACI, ACF
060700160616      *============================================================================
060800160616
060900120803     C     $METH06       BEGSR
061000160616
061100160616     C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'MEMBER'
061200160616
061300160616     C                   IF        STATE = 'WV'
061400160616
061500160616     C                   IF        ENR@IN = 'TIN'
061600120803     C                   EVAL      @CCTRIN = 'WVI'
061700160616     C                   ELSE
061800120803     C                   EVAL      @CCTRIN = 'WVF'
061900160616     C                   ENDIF
062000160616
062100160616     C                   ELSE
062200160616
062300160616     C                   IF        ENR@IN = 'TIN'
062400120803     C                   EVAL      @CCTRIN = 'IND'
062500160616     C                   ELSE
062600120803     C                   EVAL      @CCTRIN = 'FAM'
062700160616     C                   ENDIF
062800160616
062900160616     C                   ENDIF
063000160616
063100120803     C                   LEAVESR
063200160616     C                   ENDIF
063300160616
063400120803     C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'DEPEND'
063500160616
063600120803     C                   IF        STATE = 'WV'
063700120803     C                   EVAL      @CCTRIN = 'WVF'
063800120803     C                   ELSE
063900120803     C                   EVAL      @CCTRIN = 'FAM'
064000120803     C                   ENDIF
064100160616
064200120803     C                   LEAVESR
064300120803     C                   ENDIF
064400160616
064500160616     C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'MEMBER'
064600160616
064700160616     C                   IF        STATE = 'WV'
064800160616
064900160616     C                   IF        ENR@IN = 'TIN'
065000120803     C                   EVAL      @CCTRIN = 'WVI'
065100160616     C                   ELSE
065200120803     C                   EVAL      @CCTRIN = 'WVF'
065300160616     C                   ENDIF
065400160616
065500160616     C                   ELSE
065600160616
065700160616     C                   IF        EMPST =  'C'
065800120803     C                   EVAL      @CCTRIN = 'CB '
065900160616     C                   ELSE
066000120803     C                   EVAL      @CCTRIN = 'AC '
066100160616     C                   ENDIF
066200160616     C                   IF        ENR@IN = 'TIN'
066300120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
066400160616     C                   ELSE
066500120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
066600160616     C                   ENDIF
066700160616
066800160616     C                   ENDIF
066900160616
067000120803     C                   LEAVESR
067100160616     C                   ENDIF
067200160616
067300120803     C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'DEPEND'
067400160616
067500120803     C                   IF        STATE = 'WV'
067600120803     C                   EVAL      @CCTRIN = 'WVF'
067700120803     C                   ELSE
067800120803     C                   IF        EMPST =  'C'
067900120803     C                   EVAL      @CCTRIN = 'CBF'
068000120803     C                   ELSE
068100120803     C                   EVAL      @CCTRIN = 'ACF'
068200120803     C                   ENDIF
068300120803     C                   ENDIF
068400160616
068500120803     C                   ENDIF
068600160616
068700120803     C                   ENDSR
068800160616
068900160616      *============================================================================
069000160616      * EMPSTS
069100160616      *   PRETTY STRAIGHT FORWARDED
069200160616      *============================================================================
069300160616
069400120803     C     $METH07       BEGSR
069500160616
069600120803     C                   IF        EMPST =  'C'
069700120803     C                   EVAL      @CCTRIN = 'COB'
069800120803     C                   ELSE
069900120803     C                   EVAL      @CCTRIN = 'ACT'
070000120803     C                   ENDIF
070100160616
070200120803     C                   ENDSR
070300160616
070400160616      *============================================================================
070500160616      * JUSTSTATE
070600160616      *   PRETTY STRAIGHT FORWARDED
070700160616      *============================================================================
070800160616
070900120803     C     $METH08       BEGSR
071000160616
071100120803     C                   EVAL      @CCTRIN = STATE
071200160616
071300120803     C                   ENDSR
071400160616      *============================================================================
071500160616      * JOHNLS
071600160616      *   IF STATE IS NOT MARYLAND, DEFAULT TO 'XX', ELSE USE 'MD'; THEN APPLY TIER.
071700160616      * MDI, MDF, XXI, XXF
071800160616      *============================================================================
071900160616
072000120803     C     $METH09       BEGSR
072100160616
072200120803     C                   IF        WRT@TYPE = 'MEMBER'
072300120803     C                   IF        STATE = 'MD'
072400120803     C                   EVAL      @CCTRIN = 'MD'
072500120803     C                   ELSE
072600120803     C                   EVAL      @CCTRIN = 'XX'
072700120803     C                   ENDIF
072800120803     C                   IF        ENR@IN = 'TIN'
072900120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
073000120803     C                   ELSE
073100120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
073200120803     C                   ENDIF
073300120803     C                   ENDIF
073400160616
073500120803     C                   IF        WRT@TYPE = 'DEPEND'
073600120803     C                   IF        STATE = 'MD'
073700120803     C                   EVAL      @CCTRIN = 'MDF'
073800120803     C                   ELSE
073900120803     C                   EVAL      @CCTRIN = 'XXF'
074000120803     C                   ENDIF
074100120803     C                   ENDIF
074200160616
074300120803     C                   ENDSR
074400160616
074500160616      *============================================================================
074600160616      * CREATIVE
074700160616      *   IF STATE IS NOT 'MD' OR 'OK', DEFAULT TO '**'.
074800160616      * MD, OK, **
074900160616      *============================================================================
075000160616
075100120803     C     $METH10       BEGSR
075200160616
075300120803     C                   IF        STATE <> 'MD' AND STATE <> 'OK'
075400120803     C                   EVAL      @CCTRIN = '** '
075500120803     C                   ELSE
075600120803     C                   EVAL      @CCTRIN = STATE
075700120803     C                   ENDIF
075800160616
075900120803     C                   ENDSR
076000160616
076100160616      *============================================================================
076200160616      * INTEGRA = USE 'TN' FOR TENNESSEE, OTHER STATES ARE 'XX'
076300160616      *  TN, XX
076400160616      *============================================================================
076500160616
076600120803     C     $METH11       BEGSR
076700160616
076800121113     C                   SELECT
076900121113     C                   WHEN      STATE = 'TN'
077000121113     C                   EVAL      @CCTRIN = STATE                              TENNESSEE ONLY
077100121113     C                   WHEN      STATE = 'FL'
077200121113     C                   EVAL      @CCTRIN = STATE                              FLORIDA ONLY
077300121113     C                   OTHER
077400121113     C                   EVAL      @CCTRIN = 'XX '                              SITUS
077500160616     C                   ENDSL
077600160616
077700120803     C                   ENDSR
077800160616
077900160616      *============================================================================
078000160616      * STSTATE = STATE CODE WITH EMPLOYEE STATUS
078100160616      *  MDA, MDC, ETC...
078200160616      *============================================================================
078300160616
078400120803     C     $METH12       BEGSR
078500160616
078600120803     C                   EVAL      @CCTRIN = STATE + EMPST
078700160616
078800120803     C                   ENDSR
078900160616
079000160616      *============================================================================
079100160616      * STIERSTS = STATE CODE WITH TIER WITH EMPLOYEE STATUS
079200160616      *    ACTIVE [#CALC = 0]      COBRA [#CALC = 5]
079300160616      *    IND [+1 TO #CALC ]      NON-IND COVERAGE [+2 TO CALC]
079400160616      *    EACH STATE PUT AT END, GIVING FAM MARYLAND ACTIVE A VALUE OF 2MD
079500160616      *                                  IND WEST VIRGINIA COBRA A VALUE OF 6WV
079600160616      *============================================================================
079700160616
079800130123     C     $METH13       BEGSR
079900160616
080000130123     C                   SELECT
080100130123     C                   WHEN      EMPST =  'C'
080200130123     C                   Z-ADD     5             #CALC
080300130123     C                   OTHER
080400130123     C                   MOVE      *ZEROS        #CALC             1 0
080500130123     C                   ENDSL
080600160616
080700130123     C                   SELECT
080800130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN = 'TIN'
080900130123     C                   ADD       1             #CALC
081000130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN <> 'TIN'
081100130123     C                   ADD       2             #CALC
081200130123     C                   WHEN      WRT@TYPE = 'DEPEND'
081300130123     C                   ADD       2             #CALC
081400130123     C                   ENDSL
081500160616
081600130123     C                   EVAL      @CCTRIN = %EDITC(#CALC:'X') + STATE
081700160616
081800130123     C                   ENDSR
081900160616
082000160616      *============================================================================
082100160616
082200120409     C     $PREP4        BEGSR
082300160616
082400130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
082500101206     C                   EVAL      @STEP = 'STEP2'
082600101206     C                   LEAVESR
082700101206     C                   ENDIF
082800160616
082900130520     C                   EVAL      @STEP = 'STEP4'
083000130315     C                   EVAL      TERM_LIF = NO
083100101210     C                   EVAL      TERM_DEN = NO
083200101210     C                   EVAL      TERM_MED = NO
083300160616
083400130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
083500130520     C                   IF        L@TRM(L#CNE) <> 99999999
083600130520     C                   EXSR      $CHKHEM
083700130520     C                   ENDIF
083800130520     C                   LEAVESR
083900130520     C                   ENDIF
084000160616
084100130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
084200130520     C                   IF        M@TRM(M#CNE) <> 99999999
084300130520     C                   EXSR      $CHKHEM
084400130520     C                   ENDIF
084500130520     C                   LEAVESR
084600130520     C                   ENDIF
084700160616
084800130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
084900130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
085000130520     C                              M@TRM(M#CNE) <> 99999999)
085100130520     C                   EXSR      $CHKHEM
085200130520     C                   ENDIF
085300130520     C                   LEAVESR
085400130520     C                   ENDIF
085500160616
085600130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
085700130520     C                   IF        D@TRM(D#CNE) <> 99999999
085800130520     C                   EXSR      $CHKHEM
085900130520     C                   ENDIF
086000130520     C                   LEAVESR
086100130520     C                   ENDIF
086200160616
086300130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
086400130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
086500130520     C                              D@TRM(D#CNE) <> 99999999)
086600130520     C                   EXSR      $CHKHEM
086700130520     C                   ENDIF
086800130520     C                   LEAVESR
086900130520     C                   ENDIF
087000160616
087100130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
087200130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
087300130520     C                              M@TRM(M#CNE) <> 99999999)
087400130520     C                   EXSR      $CHKHEM
087500130520     C                   ENDIF
087600130520     C                   LEAVESR
087700130520     C                   ENDIF
087800160616
087900130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
088000130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
088100130520     C                              L@TRM(L#CNE) <> 99999999 OR
088200130520     C                              M@TRM(M#CNE) <> 99999999)
088300130520     C                   EXSR      $CHKHEM
088400130520     C                   ENDIF
088500130520     C                   LEAVESR
088600130520     C                   ENDIF
088700160616
088800101214     C                   ENDSR
088900160616
089000160616      *============================================================================
089100160616      * GENERATE MEMBER RECORD
089200160616      *============================================================================
089300160616
089400101210     C     $STEP4        BEGSR
089500160616
089600130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
089700101214     C                   EVAL      @STEP = 'STEP2'
089800101214     C                   LEAVESR
089900101214     C                   ENDIF
090000160616
090100110513     C                   EVAL      WRT@TYPE = 'MEMBER'
090200160616
090300130315     C                   EVAL      L@MBREFF = 0
090400110725     C                   EVAL      D@MBREFF = 0
090500110725     C                   EVAL      M@MBREFF = 0
090600160616
090700101210     C                   EVAL      @SS1   = %EDITC(MBSSNO:'X')
090800101210     C                   EVAL      @SS2   = @SS1
090900101210     C                   MOVEL(P)  MLNAME        @LN
091000101210     C                   MOVEL(P)  MFNAME        @FN
091100101210     C                   EVAL      @MI    = MMI
091200101210     C                   EVAL      @REL   = '01'
091300101210     C                   EVAL      @SEX   = SEX
091400101210     C                   EVAL      @DOB   = %EDITC(BIRTH:'X')
091500101210     C                   IF        COB = 'Y'
091600101210     C                   EVAL      @COB   = 'Y'
091700101210     C                   EVAL      @COBC  = 'OT'
091800101210     C                   EVAL      @COBN  = MCOBPN
091900101210     C                   ENDIF
092000101210     C                   EVAL      @AD1   = %TRIM(ADDR1)
092100101210     C                   EVAL      @AD2   = %TRIM(ADDR2)
092200101210     C                   EVAL      @CTY   = %TRIM(CITY)
092300101210     C                   EVAL      @ST    = STATE
092400101210     C                   MOVE      *BLANKS       @9                9
092500101210     C                   EVAL      @9   = %EDITC(ZIP:'X')
092600101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
092700101210     C                   EVAL      @PHN   = %EDITC(AREA:'X') +
092800101210     C                                      %EDITC(PHONE:'X')
092900160616
093000101210     C                   SELECT
093100101210     C                   WHEN      EMPST = 'A'
093200101210     C                   EVAL      @EMPST = 'AC'
093300101210     C                   WHEN      EMPST = 'C'
093400101210     C                   EVAL      @EMPST = 'CO'
093500101210     C                   WHEN      EMPST = 'R'
093600101210     C                   EVAL      @EMPST = 'RT'
093700101210     C                   ENDSL
093800160616
093900101210     C                   EVAL      @HIRE  = %EDITC(EMPDT:'X')
094000160616
094100141211     C                   SETOFF                                       888987
094200141120        IF KF@TRS = 770 AND KF@SUB = 004 AND KF@ACC = 0037 AND
094300141120          STATE = 'VT';
094400141120           *IN89 = *ON;
094500141120        ENDIF;
094600160616      * IF KF@TRS = 591 AND KF@SUB = 001 AND KF@ACC = 0042 AND
094700160616      *   STATE = 'TX';
094800160616      *    *IN87 = *ON;
094900160616      * ENDIF;
095000160616      *
095100101210     C                   EXCEPT    MBRF
095200101214     C                   ADD       1             C#RECCNT
095300160616
095400101213     C                   EVAL      @STEP = 'PREP5'
095500160616
095600101210     C                   ENDSR
095700160616
095800160616      *============================================================================
095900160616      * MEDICAL
096000160616      *============================================================================
096100160616
096200101214     C     $PREP5        BEGSR
096300160616
096400101214     C                   IF        M#CNE = 0
096500110513     C                   EVAL      @STEP = 'PREP6'
096600101214     C                   LEAVESR
096700101214     C                   ENDIF
096800160616
096900101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
097000130315     C                   EVAL      KF@ENR = M@ENR(M#CNE)
097100160616
097200101214     C                   IF        TERM_MED = YES
097300101214     C                   EXSR      $WRTERM
097400101214     C                   ENDIF
097500160616
097600110512     C                   EVAL      @PLANIN = KF@PLN
097700160616
097800160615     C     KL#TSAP       CHAIN     AEF04
097900160615     C                   IF        NOT %FOUND(AET004WF)
098000120803     C                   LEAVESR
098100120803     C                   ENDIF
098200160616
098300111020     C                   EVAL      ENR@IN = M@ENR(M#CNE)
098400160616
098500110802     C                   EXSR      $QUIK
098600160616
098700110512     C                   EXSR      $PLANSRCH
098800160616
098900110512     C                   IF        PLN@CAT = *BLANKS
099000101214     C                   SETON                                        H1
099100101214     C                   ENDIF
099200160616
099300110513     C                   EVAL      @STEP = 'STEP5'
099400110725     C                   EVAL      #XSX = M@FRM(M#CNE)
099500110725     C                   EVAL      M@MBREFF = #XSX
099600160616
099700101214     C                   ENDSR
099800160616
099900160616      *============================================================================
100000160616
100100101214     C     $STEP5        BEGSR
100200160616
100300110513     C                   IF        CPCID1 = 'MEA'
100400110513     C                   EXSR      $MEAWRT
100500110513     C                   ELSE
100600110513     C                   EXSR      $HMOWRT
100700110513     C                   ENDIF
100800160616
100900101214     C                   ADD       1             C#RECCNT
101000101214     C                   ADD       1             B#RECCNT
101100160616
101200110513     C                   EVAL      @STEP = 'PREP6'
101300160616
101400110513     C                   ENDSR
101500160616
101600160616      *============================================================================
101700160616      * DENTAL
101800160616      *============================================================================
101900160616
102000101214     C     $PREP6        BEGSR
102100160616
102200160616     C                   IF        D#CNE = 0
102300160616     C                   EVAL      @STEP = 'PREPC'
102400160616     C*****************  EVAL      @STEP = 'PREP7'
102500160616     C                   LEAVESR
102600160616     C                   ENDIF
102700160616
102800160616     C                   EVAL      KF@PLN = D@PLN(D#CNE)
102900160616     C                   EVAL      KF@ENR = D@ENR(D#CNE)
103000160616
103100160615     C     KL#TSAP       CHAIN     AEF04
103200160615     C                   IF        NOT %FOUND(AET004WF)
103300120803     C                   LEAVESR
103400120803     C                   ENDIF
103500160616
103600160616     C                   IF        TERM_DEN = YES
103700160616     C                   EXSR      $WRTERM
103800160616     C                   ENDIF
103900160616
104000110513     C                   EVAL      @PLANIN = KF@PLN
104100111020     C                   EVAL      ENR@IN = D@ENR(D#CNE)
104200160616
104300111011     C                   EXSR      $QUIK
104400160616
104500110513     C                   EXSR      $PLANSRCH
104600160616
104700110513     C                   IF        PLN@CAT = *BLANKS
104800110513     C                   SETON                                        H2
104900110513     C                   ENDIF
105000160616
105100160616     C                   EVAL      @STEP = 'STEP6'
105200110725     C                   EVAL      #XSX = D@FRM(D#CNE)
105300110725     C                   EVAL      D@MBREFF = #XSX
105400160616
105500101213     C                   ENDSR
105600160616
105700160616      *============================================================================
105800160616      * DENTAL FORMAT
105900160616      *============================================================================
106000160616
106100160616     C     $STEP6        BEGSR
106200110513     C                   EXSR      $DENWRT
106300160616
106400160616     C                   ADD       1             C#RECCNT
106500160616     C                   ADD       1             B#RECCNT
106600160616
106700160616     C****************** EVAL      @STEP = 'PREP7'
106800160616     C                   EVAL      @STEP = 'PREPC'
106900160616
107000160616     C                   ENDSR
107100160616
107200160616      *============================================================================
107300160616      * LIFE AND AD&D PLANS FOR MEMBER
107400160616      *============================================================================
107500160616
107600130315     C     $PREPC        BEGSR
107700160616
107800160616     C                   IF        L#CNE = 0
107900160616     C                   EVAL      @STEP = 'PREP7'
108000160616     C                   LEAVESR
108100160616     C                   ENDIF
108200160616
108300160616     C                   EVAL      KF#TRM = L@TRM(L#CNE)
108400160616     C                   EVAL      KF@PLN = L@PLN(L#CNE)
108500130315     C                   EVAL      KF@ENR = L@ENR(L#CNE)
108600160616
108700160615     C     KL#TSAP       CHAIN     AEF04
108800160615     C                   IF        NOT %FOUND(AET004WF)
108900130315     C                   LEAVESR
109000130315     C                   ENDIF
109100160616
109200160616     C                   IF        TERM_LIF = YES
109300160616     C                   EXSR      $WRTERM
109400160616     C                   ENDIF
109500160616
109600130315     C                   EVAL      @PLANIN = KF@PLN
109700130315     C                   EVAL      ENR@IN = L@ENR(L#CNE)
109800160616
109900130315     C                   EXSR      $QUIK
110000160616
110100130315     C                   EXSR      $PLANSRCH
110200160616
110300130315     C                   IF        PLN@CAT = *BLANKS
110400130315     C                   SETON                                        H2
110500130315     C                   ENDIF
110600160616
110700160616     C                   EVAL      @STEP = 'STEPC'
110800130315     C                   EVAL      #XSX = L@FRM(L#CNE)
110900130315     C                   EVAL      L@MBREFF = #XSX
111000160616
111100130315     C                   ENDSR
111200160616
111300160616      *============================================================================
111400160616      * LIFE FORMAT
111500160616      *============================================================================
111600160616
111700160616     C     $STEPC        BEGSR
111800160616
111900130315     C                   EXSR      $LIFWRT
112000160616
112100160616     C                   ADD       1             C#RECCNT
112200160616     C                   ADD       1             B#RECCNT
112300160616
112400160616     C                   EVAL      @STEP = 'PREP7'
112500160616
112600160616     C                   ENDSR
112700160616
112800160616      *============================================================================
112900160616
113000130315     C     $LIFWRT       BEGSR
113100160616
113200160616     C                   EVAL      X@LAY = CPCID1                               LAYOUT
113300160616     C                   EVAL      X@ELR = CPCID2                               ELR
113400160616     C                   EVAL      L@SFX = CPCID3                               SUFFIX
113500160616     C                   EVAL      L@ACCT = CPCID4                              ACCOUNT
113600160616     C                   EVAL      L@PLAN = CPCID5                              PLAN
113700160616     C                   EVAL      L@CLM = CPCID6                               CLAIM OFFICE
113800160616
113900160616     C                   EVAL      #XSX = L@FRM(L#CNE)
114000130315     C                   MOVE      #XSX          X@EFF
114100160616
114200160616     C                   EVAL      #XSX = L@TRM(L#CNE)
114300160616     C                   IF        #XSX = 0 OR #XSX = 99999999
114400160616     C                   MOVE      *BLANKS       X@TRM
114500160616     C                   ELSE
114600160616     C                   MOVE      #XSX          X@TRM
114700160616     C                   ENDIF
114800160616
114900140313     C                   MOVE      *BLANKS       L@CBREXP
115000140313     C                   MOVE      *BLANKS       L@CBREVT
115100140313     C                   MOVE      *BLANKS       L@CBRLEN
115200160616
115300160616     C                   IF        EMPST = 'C' AND
115400130923     C                             CEXPDT > 0
115500160616     C                   MOVE      CEXPDT        L@CBREXP
115600160616     C                   MOVE      QEDT          L@CBREVT
115700160616     C                   MOVE      CEXPDT        #MINUEND
115800160616     C                   MOVE      QEDT          #SUBTRAEND
115900160616     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
116000160616     C                   Z-ADD     #DIFFRNC      #2S0
116100160616     C                   MOVE      #2S0          L@CBRLEN
116200160616     C                   ENDIF
116300160616
116400130315     C                   EVAL      L@SALARY = %EDITC(SALARY:'4')
116500160616
116600160616     C                   EXCEPT    LIFF
116700160616
116800160616     C                   ENDSR
116900160616
117000160616      *============================================================================
117100160616
117200101214     C     $PREP7        BEGSR
117300160616
117400101214     C     KF@SSN        CHAIN     DEPENR
117500101214     C                   IF        NOT %FOUND(DEPNDC)
117600101214     C                   EVAL      @STEP = 'STEP2'
117700101214     C                   LEAVESR
117800101214     C                   ENDIF
117900160616
118000101214     C     KF@SSN        SETLL     DEPENR
118100160616
118200101214     C                   EVAL      @STEP = 'STEP7'
118300160616
118400101214     C                   ENDSR
118500160616
118600160616      *============================================================================
118700160616
118800101214     C     $STEP7        BEGSR
118900160616
119000101214     C     KF@SSN        READE     DEPENR
119100160616
119200101214     C                   IF        %EOF(DEPNDC)
119300101214     C                   EVAL      @STEP = 'STEP2'
119400101214     C                   LEAVESR
119500101214     C                   ENDIF
119600160616
119700101214     C                   EVAL      KF@SEQ = DPSEQ#
119800120803     C                   EVAL      WRT@TYPE = 'DEPEND'
119900160616
120000101214     C     KL#DCV        CHAIN     DCOVR
120100101214     C                   IF        NOT %FOUND(DCOVA)
120200101214     C                   LEAVESR
120300101214     C                   ENDIF
120400160616
120500101214     C                   EXSR      $CLRDCV
120600101214     C     KL#DCV        SETLL     DCOVR
120700160616
120800101214     C                   EVAL      @STEP = 'STEP8'
120900160616
121000101214     C                   ENDSR
121100160616
121200160616      *============================================================================
121300160616
121400101214     C     $STEP8        BEGSR
121500160616
121600101214     C     KL#DCV        READE     DCOVR
121700160616
121800101214     C                   IF        %EOF(DCOVA)
121900101214     C                   EVAL      @STEP = 'PREP9'
122000101214     C                   LEAVESR
122100101214     C                   ENDIF
122200160616
122300160616     C*                  IF        DENRDT = CCANDT
122400160616     C*                  LEAVESR
122500160616     C*                  ENDIF
122600160616
122700110513     C                   EVAL      @PLANIN = DVPLAN
122800120803     C                   EVAL      KF@PLN = DVPLAN
122900160615     C     KL#TSAP       CHAIN     AEF04
123000160615     C                   IF        NOT %FOUND(AET004WF)
123100120803     C                   LEAVESR
123200120803     C                   ENDIF
123300160616
123400110802     C                   EXSR      $QUIKD
123500160616
123600110513     C                   EXSR      $PLANSRCH
123700160616
123800110513     C                   IF        PLN@CAT = *BLANKS
123900110513     C                   LEAVESR
124000110513     C                   ENDIF
124100160616
124200101214     C                   EVAL      #CANCEL = CCANDT
124300101214     C                   IF        #CANCEL = 0
124400101214     C                   EVAL      #CANCEL = 99999999
124500101214     C                   ENDIF
124600160616
124700160616      * DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL; LIFE IS MEMBER ONLY
124800160616
124900160616     C                   IF        PLN@CAT = 'DEN'
125000160616     C                   IF        D#CNE > 0
125100160616     C                   IF        D@TRM(D#CNE) = 99999999
125200130131     C                   LEAVESR
125300130131     C                   ENDIF
125400130131     C                   ENDIF
125500160616     C                   ADD       1             D#CNE
125600160616     C                   EVAL      D@PLN(D#CNE) = DVPLAN
125700160616     C                   EVAL      D@ENR(D#CNE) = *BLANKS
125800160616     C                   EVAL      D@FRM(D#CNE) = DENRDT
125900160616     C                   EVAL      D@TRM(D#CNE) = #CANCEL
126000160616     C                   ELSE
126100160616     C                   IF        M#CNE > 0
126200160616     C                   IF        M@TRM(M#CNE) = 99999999
126300130131     C                   LEAVESR
126400130131     C                   ENDIF
126500130131     C                   ENDIF
126600101214     C                   ADD       1             M#CNE
126700101214     C                   EVAL      M@PLN(M#CNE) = DVPLAN
126800101214     C                   EVAL      M@ENR(M#CNE) = *BLANKS
126900101214     C                   EVAL      M@FRM(M#CNE) = DENRDT
127000101214     C                   EVAL      M@TRM(M#CNE) = #CANCEL
127100160616     C                   ENDIF
127200160616
127300101214     C                   ENDSR
127400160616
127500160616      *============================================================================
127600160616
127700111011     C     $QUIKD        BEGSR
127800160616
127900120803     C                   EXSR      $QUIK
128000160616
128100120409     C                   ENDSR
128200160616
128300160616      *============================================================================
128400160616
128500101214     C     $PREP9        BEGSR
128600160616
128700101214     C                   IF        D#CNE = 0 AND M#CNE = 0
128800101214     C                   EVAL      @STEP = 'STEP7'
128900101214     C                   LEAVESR
129000101214     C                   ENDIF
129100160616
129200130315     C                   EVAL      L#CNE = 0
129300130315     C                   EVAL      TERM_LIF = NO
129400101214     C                   EVAL      TERM_DEN = NO
129500101214     C                   EVAL      TERM_MED = NO
129600130520     C                   EVAL      @STEP = 'STEP9'
129700160616
129800130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
129900130520     C                   IF        L@TRM(L#CNE) <> 99999999
130000130520     C                   EXSR      $CHKHEM
130100130520     C                   ENDIF
130200130520     C                   LEAVESR
130300130520     C                   ENDIF
130400160616
130500130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
130600130520     C                   IF        M@TRM(M#CNE) <> 99999999
130700130520     C                   EXSR      $CHKHEM
130800130520     C                   ENDIF
130900130520     C                   LEAVESR
131000130520     C                   ENDIF
131100160616
131200130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
131300130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
131400130520     C                              M@TRM(M#CNE) <> 99999999)
131500130520     C                   EXSR      $CHKHEM
131600130520     C                   ENDIF
131700130520     C                   LEAVESR
131800130520     C                   ENDIF
131900160616
132000130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
132100130520     C                   IF        D@TRM(D#CNE) <> 99999999
132200130520     C                   EXSR      $CHKHEM
132300130520     C                   ENDIF
132400130520     C                   LEAVESR
132500130520     C                   ENDIF
132600160616
132700130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
132800130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
132900130520     C                              D@TRM(D#CNE) <> 99999999)
133000130520     C                   EXSR      $CHKHEM
133100130520     C                   ENDIF
133200130520     C                   LEAVESR
133300130520     C                   ENDIF
133400160616
133500130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
133600130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
133700130520     C                              M@TRM(M#CNE) <> 99999999)
133800130520     C                   EXSR      $CHKHEM
133900130520     C                   ENDIF
134000130520     C                   LEAVESR
134100130520     C                   ENDIF
134200160616
134300130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
134400130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
134500130520     C                              L@TRM(L#CNE) <> 99999999 OR
134600130520     C                              M@TRM(M#CNE) <> 99999999)
134700130520     C                   EXSR      $CHKHEM
134800130520     C                   ENDIF
134900130520     C                   LEAVESR
135000130520     C                   ENDIF
135100160616
135200101214     C                   ENDSR
135300160616
135400160616      *============================================================================
135500160616      * GENERATE DEPENDENT RECORD
135600160616      *============================================================================
135700160616
135800101214     C     $STEP9        BEGSR
135900160616
136000110513     C                   EVAL      WRT@TYPE = 'DEPEND'
136100160616
136200110513     C                   IF        D#CNE = 0 AND M#CNE = 0
136300110513     C                   EVAL      @STEP = 'STEP7'
136400110513     C                   LEAVESR
136500110513     C                   ENDIF
136600160616
136700101214     C                   EVAL      @SS2   = %EDITC(DEPSS#:'X')
136800101210     C                   MOVEL(P)  DLNAME        @LN
136900101210     C                   MOVEL(P)  DFNAME        @FN
137000101210     C                   EVAL      @MI    = DMI
137100160616
137200101210     C                   SELECT
137300101210     C                   WHEN      DRELCD = 'RWI'
137400101210     C                   EVAL      @REL   = '02'
137500101210     C                   WHEN      DRELCD = 'RHU'
137600101210     C                   EVAL      @REL   = '03'
137700101210     C                   WHEN      DRELCD = 'RSO'
137800101210     C                   EVAL      @REL   = '04'
137900101210     C                   WHEN      DRELCD = 'RDA'
138000101210     C                   EVAL      @REL   = '05'
138100130218     C                   WHEN      DRELCD = 'RPA'
138200130218     C                   EVAL      @REL   = '14'
138300130225     C                   OTHER
138400130225     C                   EVAL      @REL   = *BLANKS
138500101210     C                   ENDSL
138600160616
138700101210     C                   SELECT
138800101210     C                   WHEN      DSTUDN = 'Y'
138900101210     C                   EVAL      @SPEC = '1'
139000140812     C                   WHEN      DHNDCP = '3'
139100101210     C                   EVAL      @SPEC = '3'
139200130225     C                   OTHER
139300130225     C                   EVAL      @SPEC = *BLANKS
139400101210     C                   ENDSL
139500160616
139600101210     C                   EVAL      @SEX   = DSEX
139700101210     C                   EVAL      @DOB   = %EDITC(DBIRTH:'X')
139800160616
139900101210     C                   IF        DCOB = 'Y'
140000101210     C                   EVAL      @COB   = 'Y'
140100101210     C                   EVAL      @COBC  = 'OT'
140200101210     C                   EVAL      @COBN  = DCOBPN
140300130225     C                   ELSE
140400130225     C                   EVAL      @COB   = *BLANKS
140500130225     C                   EVAL      @COBC  = *BLANKS
140600130225     C                   EVAL      @COBN = *BLANKS
140700101210     C                   ENDIF
140800160616
140900101214     C                   IF        DADDR1 <> ADDR1
141000101210     C                   EVAL      @AD1   = %TRIM(DADDR1)
141100101210     C                   EVAL      @AD2   = %TRIM(DADDR2)
141200101210     C                   EVAL      @CTY   = %TRIM(DCITY)
141300101210     C                   EVAL      @ST    = DSTATE
141400101210     C                   MOVE      *BLANKS       @9                9
141500101214     C                   IF        DZIP = 0
141600101214     C                   EVAL      @9   = %EDITC(ZIP:'X')
141700101214     C                   ELSE
141800101210     C                   EVAL      @9   = %EDITC(DZIP:'X')
141900101214     C                   ENDIF
142000101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
142100101210     C                   EVAL      @PHN   = %EDITC(DAREA:'X') +
142200101210     C                                      %EDITC(DPHONE:'X')
142300101214     C                   ENDIF
142400160616
142500101210     C                   EXCEPT    MBRF
142600101214     C                   ADD       1             C#RECCNT
142700160616
142800101214     C                   EVAL      @STEP = 'PREPA'
142900160616
143000101210     C                   ENDSR
143100160616
143200160616      *============================================================================
143300160616
143400101214     C     $PREPA        BEGSR
143500160616
143600101214     C                   IF        M#CNE = 0
143700101214     C                   EVAL      @STEP = 'PREPB'
143800101214     C                   LEAVESR
143900101214     C                   ENDIF
144000160616
144100101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
144200160615     C     KL#TSAP       CHAIN     AEF04
144300160615     C                   IF        NOT %FOUND(AET004WF)
144400120803     C                   LEAVESR
144500120803     C                   ENDIF
144600160616
144700101214     C                   IF        TERM_MED = YES
144800101214     C                   EXSR      $WRTERM
144900101214     C                   ENDIF
145000160616
145100110513     C                   EVAL      @PLANIN = KF@PLN
145200160616
145300110802     C                   EXSR      $QUIKD
145400160616
145500110513     C                   EXSR      $PLANSRCH
145600160616
145700110513     C                   IF        PLN@CAT = *BLANKS
145800110513     C                   SETON                                        H2
145900110513     C                   ENDIF
146000160616
146100110513     C                   EVAL      @STEP = 'STEPA'
146200160616
146300101214     C                   ENDSR
146400160616
146500160616      *============================================================================
146600160616
146700101214     C     $STEPA        BEGSR
146800160616
146900110513     C                   IF        CPCID1 = 'MEA'
147000110513     C                   EXSR      $MEAWRT
147100110513     C                   ELSE
147200110513     C                   EXSR      $HMOWRT
147300110513     C                   ENDIF
147400160616
147500110513     C                   ADD       1             C#RECCNT
147600110513     C                   ADD       1             B#RECCNT
147700160616
147800110513     C                   EVAL      @STEP = 'PREPB'
147900160616
148000110513     C                   ENDSR
148100160616
148200160616      *============================================================================
148300160616
148400101214     C     $PREPB        BEGSR
148500160616
148600160616     C                   IF        D#CNE = 0
148700160616     C                   EVAL      @STEP = 'STEP7'
148800160616     C                   LEAVESR
148900160616     C                   ENDIF
149000160616
149100160616     C                   EVAL      KF@PLN = D@PLN(D#CNE)
149200160615     C     KL#TSAP       CHAIN     AEF04
149300160615     C                   IF        NOT %FOUND(AET004WF)
149400120803     C                   LEAVESR
149500120803     C                   ENDIF
149600160616
149700160616     C                   IF        TERM_DEN = YES
149800160616     C                   EXSR      $WRTERM
149900160616     C                   ENDIF
150000160616
150100110513     C                   EVAL      @PLANIN = KF@PLN
150200160616
150300110802     C                   EXSR      $QUIKD
150400160616
150500110513     C                   EXSR      $PLANSRCH
150600160616
150700110513     C                   IF        PLN@CAT = *BLANKS
150800110513     C                   SETON                                        H2
150900110513     C                   ENDIF
151000160616
151100101214     C                   EVAL      @STEP = 'STEPB'
151200160616
151300101214     C                   ENDSR
151400160616
151500160616      *============================================================================
151600160616
151700160616     C     $STEPB        BEGSR
151800160616
151900110513     C                   EXSR      $DENWRT
152000160616
152100160616     C                   ADD       1             C#RECCNT
152200160616     C                   ADD       1             B#RECCNT
152300160616
152400160616     C                   EVAL      @STEP = 'STEP7'
152500160616
152600160616     C                   ENDSR
152700160616
152800160616      *============================================================================
152900160616
153000110512     C     *INZSR        BEGSR
153100160616
153200160314     C     *entry        plist
153300160314     C                   parm                    CARR#CTL
153400160314     C                   parm                    grouper
153500160314
153600110512     C     KL#ACCTL      KLIST
153700160919     C                   KFLD                    CARR#CTL
153800110512     C                   KFLD                    KF@TRS
153900110512     C                   KFLD                    KF@SUB
154000110512     C                   KFLD                    KF@ACC
154100160616
154200140313     C     KL#SQPCD      KLIST
154300140313     C                   KFLD                    KF@SSN
154400140313     C                   KFLD                    KF@SEQ
154500140313     C                   KFLD                    KF@SPCD
154600160616
154700120803     C     KL#TSAP       KLIST
154800120803     C                   KFLD                    KF@TRS
154900120803     C                   KFLD                    KF@SUB
155000120803     C                   KFLD                    KF@ACC
155100120803     C                   KFLD                    KF@PLN
155200160616
155300110512     C     KL#TSA        KLIST
155400110512     C                   KFLD                    KF@TRS
155500110512     C                   KFLD                    KF@SUB
155600110512     C                   KFLD                    KF@ACC
155700160616
155800110512     C     KL#MPLN       KLIST
155900110512     C                   KFLD                    KF@SSN
156000110512     C                   KFLD                    KF@SEQ
156100110512     C                   KFLD                    KF@TRS
156200110512     C                   KFLD                    KF@SUB
156300110512     C                   KFLD                    KF@ACC
156400160616
156500110512     C     KL#CPLN       KLIST
156600160919     C                   KFLD                    CARR#CTL
156700110512     C                   KFLD                    KF@TRS
156800110512     C                   KFLD                    KF@SUB
156900110512     C                   KFLD                    KF@ACC
157000110512     C                   KFLD                    KF@CCTR
157100110512     C                   KFLD                    KF@PLN
157200160616
157300110512     C     KL#DCV        KLIST
157400110512     C                   KFLD                    KF@SSN
157500110512     C                   KFLD                    KF@SEQ
157600160616
157700110512     C     KL#MTR        KLIST
157800110512     C                   KFLD                    KF@SSN
157900110512     C                   KFLD                    KF@SEQ
158000110512     C                   KFLD                    KF#TRM
158100110512     C                   KFLD                    KF@PLN
158200110512     C                   KFLD                    KF@ENR
158300110512     C                   KFLD                    KF@TRS
158400110512     C                   KFLD                    KF@SUB
158500110512     C                   KFLD                    KF@ACC
158600160616
158700110512     C     KL#PCP        KLIST
158800110512     C                   KFLD                    KF@SSN
158900110512     C                   KFLD                    KF@SEQ
159000160616
159100110512     C                   EVAL      #ISO = %DATE
159200110512     C                   MOVE      #ISO          #TODAY            8 0
159300110512     C                   EVAL      #IST = %TIME
159400110512     C                   MOVE      #ISO          #XSX
159500110512     C                   MOVE      #XSX          @DATE
159600110512     C                   MOVE      #IST          #XST
159700110512     C                   MOVE      #XST          @TIME
159800160616
159900110512     C                   ENDSR
160000160616
160100160616      *============================================================================
160200160616      * PLANS LOADED BY ACCOUNT
160300160616      *============================================================================
160400160616
160500110513     C     $PLANLOAD     BEGSR
160600160616
160700110513     C                   EVAL      PP# = 0
160800140313     C                   DO        80
160900110513     C                   ADD       1             PP#
161000110513     C     PP#           OCCUR     CARPLN@
161100110513     C                   CLEAR                   CARPLN@
161200110513     C                   ENDDO
161300110513     C                   EVAL      PC# = 0
161400110513     C                   EVAL      PP# = 0
161500160616
161600110513     C     KL#ACCTL      SETLL     CARPLNR
161700110513     C                   DOU       %EOF(CARPLNP)
161800110513     C     KL#ACCTL      READE     CARPLNR
161900110520     C                   IF        NOT %EOF(CARPLNP)
162000160616
162100110513     C                   ADD       1             PC#
162200110513     C     PC#           OCCUR     CARPLN@
162300110513     C                   EVAL      CARPLN@ = DS@CARPLN
162400160616
162500110513     C                   ENDIF
162600110513     C                   ENDDO
162700160616
162800110513     C                   ENDSR
162900160616
163000160616      *============================================================================
163100160616
163200110513     C     $CLRSTG       BEGSR
163300160616
163400110513     C                   EVAL      #CANCEL = 0
163500160616
163600130315     C                   EVAL      L#CNE = 0
163700130315     C                   CLEAR                   L@PLN
163800130315     C                   CLEAR                   L@ENR
163900130315     C                   CLEAR                   L@FRM
164000130315     C                   CLEAR                   L@TRM
164100160616
164200110513     C                   EVAL      D#CNE = 0
164300110513     C                   CLEAR                   D@PLN
164400110513     C                   CLEAR                   D@ENR
164500110513     C                   CLEAR                   D@FRM
164600110513     C                   CLEAR                   D@TRM
164700110513     C                   EVAL      M#CNE = 0
164800110513     C                   CLEAR                   M@PLN
164900110513     C                   CLEAR                   M@ENR
165000110513     C                   CLEAR                   M@FRM
165100110513     C                   CLEAR                   M@TRM
165200160616
165300110513     C                   EXSR      $CLRDMG
165400160616
165500110513     C                   ENDSR
165600160616
165700160616      *============================================================================
165800160616
165900110513     C     $CLRDMG       BEGSR
166000160616
166100110513     C                   EVAL      @SS1   = *BLANKS
166200110513     C                   EVAL      @SS2   = *BLANKS
166300110513     C                   MOVE      *BLANKS       @LN
166400110513     C                   MOVEL     *BLANKS       @FN
166500110513     C                   EVAL      @MI    = *BLANKS
166600110513     C                   EVAL      @REL   = *BLANKS
166700110513     C                   EVAL      @SEX   = *BLANKS
166800110513     C                   EVAL      @DOB   = *BLANKS
166900110513     C                   EVAL      @SPEC  = *BLANKS
167000110513     C                   EVAL      @COB   = *BLANKS
167100110513     C                   EVAL      @COBC  = *BLANKS
167200110513     C                   EVAL      @COBN  = *BLANKS
167300110513     C                   EVAL      @AD1   = *BLANKS
167400110513     C                   EVAL      @AD2   = *BLANKS
167500110513     C                   EVAL      @CTY   = *BLANKS
167600110513     C                   EVAL      @ST    = *BLANKS
167700110513     C                   EVAL      @ZP5   = *BLANKS
167800110513     C                   EVAL      @PHN   = *BLANKS
167900110513     C                   EVAL      @EMPST = *BLANKS
168000110513     C                   EVAL      @HIRE  = *BLANKS
168100160616
168200110513     C                   ENDSR
168300160616
168400160616      *============================================================================
168500160616
168600110513     C     $CHKHEM       BEGSR
168700160616
168800160616     C                   IF        L#CNE > 0 AND L@TRM(L#CNE) <> 99999999
168900160616     C                   EXSR      $CHKLIF
169000160616     C                   ENDIF
169100160616
169200160616     C                   IF        D#CNE > 0 AND D@TRM(D#CNE) <> 99999999
169300160616     C                   EXSR      $CHKDEN
169400160616     C                   ENDIF
169500160616
169600110513     C                   IF        M#CNE > 0 AND M@TRM(M#CNE) <> 99999999
169700110513     C                   EXSR      $CHKMED
169800110513     C                   ENDIF
169900160616
170000110513     C                   ENDSR
170100160616
170200160616      *============================================================================
170300160616
170400160616     C     $CHKLIF       BEGSR
170500160616
170600160616     C                   EVAL      TERM_LIF = YES
170700160616     C                   EVAL      KF#TRM = L@TRM(L#CNE)
170800160616     C                   EVAL      KF@PLN = L@PLN(L#CNE)
170900160616     C                   EVAL      KF@ENR = L@ENR(L#CNE)
171000160616
171100160919     C     KL#MTR        CHAIN     AET1071F
171200160919     C                   IF        %FOUND(AET1071WF)
171300160616     C                   EVAL      L#CNE = 0
171400160616     C                   EVAL      TERM_LIF = NO
171500160616     C                   ENDIF
171600160616
171700160616     C                   ENDSR
171800160616
171900160616      *============================================================================
172000160616
172100160616     C     $CHKDEN       BEGSR
172200160616
172300160616     C                   EVAL      TERM_DEN = YES
172400160616     C                   EVAL      KF#TRM = D@TRM(D#CNE)
172500160616     C                   EVAL      KF@PLN = D@PLN(D#CNE)
172600160616     C                   EVAL      KF@ENR = D@ENR(D#CNE)
172700160616
172800160919     C     KL#MTR        CHAIN     AET1071F
172900160919     C                   IF        %FOUND(AET1071WF)
173000160616     C                   EVAL      D#CNE = 0
173100160616     C                   EVAL      TERM_DEN = NO
173200160616     C                   ENDIF
173300160616
173400160616     C                   ENDSR
173500160616
173600160616      *============================================================================
173700160616
173800110513     C     $CHKMED       BEGSR
173900160616
174000110513     C                   EVAL      TERM_MED = YES
174100110513     C                   EVAL      KF#TRM = M@TRM(M#CNE)
174200110513     C                   EVAL      KF@PLN = M@PLN(M#CNE)
174300110513     C                   EVAL      KF@ENR = M@ENR(M#CNE)
174400160616
174500160919     C     KL#MTR        CHAIN     AET1071F
174600160919     C                   IF        %FOUND(AET1071WF)
174700110513     C                   EVAL      TERM_MED = NO
174800110513     C                   EVAL      M#CNE = 0
174900110513     C                   ENDIF
175000160616
175100110513     C                   ENDSR
175200160616
175300160616      *============================================================================
175400160616
175500110513     C     $PLANSRCH     BEGSR
175600160616
175700130315     C                   MOVE      *BLANKS       PLN@CAT           5
175800110513     C                   EVAL      PP# = 0
175900110513     C                   CLEAR                   DS@CARPLN
176000160616
176100110513     C                   DO        PC#
176200160616
176300110513     C                   ADD       1             PP#
176400110513     C     PP#           OCCUR     CARPLN@
176500160616
176600110513     C                   IF        XPPLAN = @PLANIN AND
176700110513     C                             XPCCTR = @CCTRIN
176800110513     C                   EVAL      DS@CARPLN = CARPLN@
176900110513     C                   LEAVE
177000110513     C                   ENDIF
177100160616
177200110513     C                   ENDDO
177300160616
177400110513     C                   IF        CPPLAN = *BLANKS
177500110513     C                   LEAVESR
177600110513     C                   ENDIF
177700160616
177800110513     C                   SELECT
177900110520     C                   WHEN      CPCID1 = 'MEA' OR
178000110520     C                             CPCID1 = 'HMO'
178100110520     C                   EVAL      PLN@CAT = 'MED'
178200130409     C                   WHEN      CPCID1 = 'LIFE'
178300130409     C                   EVAL      PLN@CAT = 'LIFE'
178400110520     C                   WHEN      CPCID1 = 'DEN'
178500110520     C                   EVAL      PLN@CAT = 'DEN'
178600110513     C                   ENDSL
178700160616
178800110513     C                   ENDSR
178900160616
179000160616      *============================================================================
179100160616
179200110513     C     $ENROLL       BEGSR
179300160616
179400110513     C                   EVAL      ENR@OUT = *BLANKS
179500110513     C                   SELECT
179600110513     C                   WHEN      ENR@IN = 'TIN' OR ENR@IN = 'TMI'
179700110513     C                   EVAL      ENR@OUT = 'S'
179800110513     C                   WHEN      ENR@IN = 'THW'
179900110513     C                   EVAL      ENR@OUT = 'C'
180000110513     C                   WHEN      ENR@IN = 'TPC'
180100110513     C                   EVAL      ENR@OUT = 'P'
180200110513     C                   WHEN      ENR@IN = 'TP2'
180300110513     C                   EVAL      ENR@OUT = 'Q'
180400110513     C                   WHEN      ENR@IN = 'TFA'
180500110513     C                   EVAL      ENR@OUT = 'F'
180600110513     C                   ENDSL
180700160616
180800110513     C                   ENDSR
180900160616
181000160616      *============================================================================
181100160616
181200110513     C     $WRTERM       BEGSR
181300160616
181400160919     C                   CLEAR                   AET1071F
181500110513     C                   EVAL      NTSSNO         = KF@SSN
181600110513     C                   EVAL      NTDEPNO        = KF@SEQ
181700110513     C                   EVAL      NTTERMDT       = KF#TRM
181800110513     C                   EVAL      NTPLAN         = KF@PLN
181900110513     C                   EVAL      NTCOVTP        = KF@ENR
182000110513     C                   EVAL      NTTRST         = KF@TRS
182100110513     C                   EVAL      NTSUB#         = KF@SUB
182200110513     C                   EVAL      NTACCT         = KF@ACC
182300110513     C                   EVAL      NTTRANSDT      = #TODAY
182400160919     C                   WRITE     AET1071F
182500160616
182600110513     C                   ENDSR
182700160616
182800160616      *============================================================================
182900160616
183000110513     C     $HMOWRT       BEGSR
183100160616
183200110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
183300110513     C                   EVAL      X@ELR = CPCID2                               FILE NUMBER
183400110513     C                   EVAL      M@CC = CACID2                                COMPANY CODE
183500110513     C                   EVAL      M@CLASS = CPCID3                             CLASS CODE
183600110513     C                   EVAL      M@PLAN = CPCID4                              PLAN NUMBER
183700160616
183800110513     C                   EVAL      #XSX = M@FRM(M#CNE)
183900110725     C                   IF        WRT@TYPE = 'DEPEND' AND
184000110725     C                             #XSX < M@MBREFF
184100110725     C                   MOVE      M@MBREFF      X@EFF
184200110725     C                   ELSE
184300110725     C                   MOVE      #XSX          X@EFF
184400110725     C                   ENDIF
184500160616
184600110513     C                   EVAL      #XSX = M@TRM(M#CNE)
184700110513     C                   IF        #XSX = 0 OR #XSX = 99999999
184800110513     C                   MOVE      *BLANKS       X@TRM
184900110513     C                   ELSE
185000110513     C                   MOVE      #XSX          X@TRM
185100110513     C                   ENDIF
185200160616
185300110513     C                   IF        WRT@TYPE = 'MEMBER'
185400110513     C                   EVAL      KF@SEQ = 0
185500110513     C                   EVAL      ENR@IN = M@ENR(M#CNE)
185600110513     C                   EXSR      $ENROLL
185700110513     C                   EVAL      X@TIER = ENR@OUT
185800110513     C                   ELSE
185900110513     C                   EVAL      X@TIER = *BLANKS
186000110513     C                   ENDIF
186100160616
186200140313     C                   EVAL      KF@SPCD = 'MED'
186300140313     C                   EVAL      M@PCP = *BLANKS
186400140313     C                   EVAL      M@NPI = *BLANKS
186500140313     C                   EVAL      M@PCPCI = *BLANKS
186600160616
186700140313     C                   EXSR      $PCP
186800160616
186900140313     C                   IF        DOCTOR <> *BLANKS
187000140313     C                   EVAL      M@PCP = DOCTOR
187100140313     C                   EVAL      M@NPI = 'Y'
187200140313     C                   EVAL      M@PCPCI = '0'
187300140313     C                   ENDIF
187400160616
187500110513     C                   EXCEPT    HMOF
187600160616
187700110513     C                   ENDSR
187800160616
187900160616      *============================================================================
188000160616
188100110513     C     $MEAWRT       BEGSR
188200160616
188300110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
188400110513     C                   EVAL      X@ELR = CPCID2                               ELR
188500140313     C                   EVAL      E@SFX = CPCID3                               SUFFIX
188600140313     C                   EVAL      E@ACCT = CPCID4                              ACCOUNT
188700140313     C                   EVAL      E@PLAN = CPCID5                              PLAN
188800140313     C                   EVAL      E@CLM = CPCID6                               CLAIM OFFICE
188900160616
189000110513     C                   EVAL      #XSX = M@FRM(M#CNE)
189100110725     C                   IF        WRT@TYPE = 'DEPEND' AND
189200110725     C                             #XSX < M@MBREFF
189300110725     C                   MOVE      M@MBREFF      X@EFF
189400110725     C                   ELSE
189500110725     C                   MOVE      #XSX          X@EFF
189600110725     C                   ENDIF
189700160616
189800160616     C                   EVAL      #XSX = M@TRM(M#CNE)
189900110513     C                   IF        #XSX = 0 OR #XSX = 99999999
190000110513     C                   MOVE      *BLANKS       X@TRM
190100110513     C                   ELSE
190200110513     C                   MOVE      #XSX          X@TRM
190300110513     C                   ENDIF
190400160616
190500140313     C                   MOVE      *BLANKS       E@CBREXP
190600140313     C                   MOVE      *BLANKS       E@CBREVT
190700140313     C                   MOVE      *BLANKS       E@CBRLEN
190800140313     C                   IF        WRT@TYPE = 'MEMBER'
190900140425     C                   IF        EMPST = 'C' AND
191000140425     C                             CEXPDT > 0
191100140313     C                   MOVE      CEXPDT        E@CBREXP
191200140313     C                   MOVE      QEDT          E@CBREVT
191300140313     C                   MOVE      CEXPDT        #MINUEND
191400140313     C                   MOVE      QEDT          #SUBTRAEND
191500140313     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
191600140313     C                   Z-ADD     #DIFFRNC      #2S0
191700140313     C                   MOVE      #2S0          E@CBRLEN
191800140313     C                   ENDIF
191900140313     C                   ENDIF
192000160616
192100140313     C                   EVAL      *IN80 = *OFF
192200140313     C                   EVAL      KF@SPCD = 'MED'
192300140313     C                   EVAL      E@PCP = *BLANKS
192400140313     C                   EXSR      $PCP
192500140313     C                   IF        DOCTOR <> *BLANKS
192600140313     C                   EVAL      E@PCP = DOCTOR
192700140313     C                   EVAL      *IN80 = *ON
192800140313     C                   ENDIF
192900160616
193000140313     C                   EXCEPT    MEAF
193100160616
193200110513     C                   ENDSR
193300160616
193400160616      *============================================================================
193500160616
193600140313     C     $PCP          BEGSR
193700160616
193800140313     C                   MOVE      *BLANKS       DOCTOR            7
193900140313     C     KL#SQPCD      CHAIN     PCPR
194000140313     C                   IF        NOT %FOUND(PCPL1)
194100140313     C                   LEAVESR
194200140313     C                   ENDIF
194300140313     C     KL#SQPCD      SETLL     PCPR
194400140313     C                   DOU       %EOF(PCPL1)
194500140313     C     KL#SQPCD      READE     PCPR
194600140313     C                   IF        NOT %EOF(PCPL1) AND PCCAN = 0
194700140313     C                   MOVEL(P)  PCID#         DOCTOR
194800140313     C                   LEAVESR
194900140313     C                   ENDIF
195000140313     C                   ENDDO
195100160616
195200140313     C                   ENDSR
195300160616
195400160616      *============================================================================
195500160616
195600110513     C     $CLRDCV       BEGSR
195700160616
195800110513     C                   MOVE      *BLANKS       @LN
195900110513     C                   MOVEL     *BLANKS       @FN
196000110513     C                   EVAL      @SS2   = *BLANKS
196100110513     C                   EVAL      @MI    = *BLANKS
196200110513     C                   EVAL      @REL   = *BLANKS
196300110513     C                   EVAL      @SEX   = *BLANKS
196400110513     C                   EVAL      @DOB   = *BLANKS
196500110513     C                   EVAL      @SPEC  = *BLANKS
196600110513     C                   EVAL      @COB   = *BLANKS
196700110513     C                   EVAL      @COBC  = *BLANKS
196800110513     C                   EVAL      @COBN  = *BLANKS
196900160616
197000110513     C                   EVAL      #CANCEL = 0
197100110513     C                   EVAL      D#CNE = 0
197200110513     C                   CLEAR                   D@PLN
197300110513     C                   CLEAR                   D@ENR
197400110513     C                   CLEAR                   D@FRM
197500110513     C                   CLEAR                   D@TRM
197600110513     C                   EVAL      M#CNE = 0
197700110513     C                   CLEAR                   M@PLN
197800110513     C                   CLEAR                   M@ENR
197900110513     C                   CLEAR                   M@FRM
198000110513     C                   CLEAR                   M@TRM
198100160616
198200110513     C                   ENDSR
198300160616
198400160616      *============================================================================
198500160616
198600110513     C     $DENWRT       BEGSR
198700160616
198800160616     C                   EVAL      X@LAY = CPCID1                               LAYOUT
198900160616     C                   EVAL      X@ELR = CPCID2                               ELR
199000160616     C                   EVAL      D@SFX = CPCID3                               SUFFIX
199100160616     C                   EVAL      D@ACCT = CPCID4                              ACCOUNT
199200160616     C                   EVAL      D@PLAN = CPCID5                              PLAN
199300160616     C                   EVAL      D@CLM = CPCID6                               CLAIM OFFICE
199400110524     C                   EVAL      DNTLATE = '0'
199500160616
199600160616     C                   EVAL      #XSX = D@FRM(D#CNE)
199700110725     C                   IF        WRT@TYPE = 'DEPEND' AND
199800110725     C                             #XSX < D@MBREFF
199900110725     C                   MOVE      D@MBREFF      X@EFF
200000110725     C                   ELSE
200100110725     C                   MOVE      #XSX          X@EFF
200200110725     C                   ENDIF
200300160616
200400160616     C                   EVAL      #XSX = D@TRM(D#CNE)
200500160616     C                   IF        #XSX = 0 OR #XSX = 99999999
200600160616     C                   MOVE      *BLANKS       X@TRM
200700160616     C                   ELSE
200800160616     C                   MOVE      #XSX          X@TRM
200900160616     C                   ENDIF
201000160616
201100130211     C                   MOVE      *BLANKS       D@CBREXP
201200130211     C                   MOVE      *BLANKS       D@CBREVT
201300130211     C                   MOVE      *BLANKS       D@CBRLEN
201400110513     C                   IF        WRT@TYPE = 'MEMBER'
201500160616     C                   IF        EMPST = 'C' AND CEXPDT <> 0
201600160616     C                   MOVE      CEXPDT        D@CBREXP
201700160616     C                   MOVE      QEDT          D@CBREVT
201800160616     C                   MOVE      CEXPDT        #MINUEND
201900160616     C                   MOVE      QEDT          #SUBTRAEND
202000160616     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
202100160616     C                   Z-ADD     #DIFFRNC      #2S0
202200160616     C                   MOVE      #2S0          D@CBRLEN
202300160616     C                   ENDIF
202400160616     C                   ENDIF
202500160616
202600160616     C                   MOVE      '0'           D@OOAI
202700160616
202800140313     C                   EVAL      KF@SPCD = 'DEN'
202900140313     C                   EVAL      D@PCD = *BLANKS
203000140313     C                   EVAL      *IN81 = *OFF
203100140313     C                   MOVE      *BLANKS       DOCTOR
203200160616
203300140313     C                   EXSR      $PCP
203400160616
203500140313     C                   IF        DOCTOR <> *BLANKS
203600140313     C                   EVAL      D@PCD = DOCTOR
203700140313     C                   EVAL      *IN81 = *ON
203800140313     C                   ENDIF
203900160616
204000120123     C     *LIKE         DEFINE    H@C#          BUC#
204100120123     C                   EVAL      BUC# = H@C#
204200160616
204300120327     C                   SELECT
204400131126     C                   WHEN      KF@TRS = 591 AND KF@SUB = 009 AND            WILMOT MODULAR
204500131126     C                             KF@ACC = 0202                                 STRUCTURES
204600131227     C                   EVAL      H@C# = '0638156'
204700140702     C                   WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            REDLAND
204800140702     C                             KF@ACC = 0475                                 BAPTISTS
204900140702     C                   EVAL      H@C# = '0725572'
205000120327     C                   WHEN      KF@TRS = 825 AND KF@SUB = 001 AND            CREATIVE
205100120123     C                             KF@ACC = 0014                                 LOGISTICS
205200120123     C                   EVAL      H@C# = '0133860'
205300130905     C                   WHEN      KF@TRS = 905 AND KF@SUB = 001 AND            CCL USA
205400130905     C                             KF@ACC = 0092
205500130905     C                   EVAL      H@C# = '0638423'
205600140423     C                   WHEN      KF@TRS = 003 AND KF@SUB = 001 AND            FRAME RITE
205700140423     C                             KF@ACC = 0104
205800140423     C                   EVAL      H@C# = '0306511'
205900130520     C                   WHEN      KF@TRS = 900 AND KF@SUB = 003 AND            PERFECT
206000130520     C                             KF@ACC = 0045                                 SETTINGS
206100130520     C                   EVAL      H@C# = '0474109'
206200121024     C                   WHEN      KF@TRS = 591 AND KF@SUB = 011 AND            MCCALLISTER
206300121024     C                             KF@ACC = 0446                                 ARCHITECT
206400121024     C                   EVAL      H@C# = '0565330'
206500130716     C                   WHEN      KF@TRS = 591 AND KF@SUB = 005 AND            JD CLARK PROF
206600130716     C                             KF@ACC = 0451                                 SERVICES
206700130716     C                   EVAL      H@C# = '0519890'
206800130627     C                   WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            DYSON CONSTRUCTION
206900130627     C                             KF@ACC = 0459                                 COMPANY
207000130627     C                   EVAL      H@C# = '0788122'
207100130903     C                   WHEN      KF@TRS = 591 AND KF@SUB = 004 AND            STROUSE CORP
207200130903     C                             KF@ACC = 0482
207300130903     C                   EVAL      H@C# = '0837451'
207400130712     C                   WHEN      KF@TRS = 900 AND KF@SUB = 007 AND            CAPLAN BROTHERS
207500130712     C                             KF@ACC = 0075
207600130712     C                   EVAL      H@C# = '0837533'
207700120806     C                   WHEN      KF@TRS = 900 AND KF@SUB = 101 AND            INTEGRA HEALTH
207800130110     C                             KF@ACC = 0042 AND
207900130110     C                             (STATE = 'TN' OR STATE = 'FL' OR
208000130718     C                              STATE = 'OH' OR STATE = 'MA') AND
208100120806     C                             (@PLANIN = 'DAAD' OR @PLANIN = 'BAAD')
208200120806     C                   EVAL      H@C# = '0503428'
208300160616     C                   ENDSL
208400160616
208500160616     C                   EXCEPT    DENF
208600151217     c                   EVAL      H@C# = BUC#
208700160616
208800160616     C                   ENDSR
208900160616
209000160616      *============================================================================
209100160616
209200160919     OAET1070WF EADD         HDRF
209300101203     O                                            6 'HEADER'
209400160810     O                                            8 'P'
209500101206     O                       H@SI                28
209600101203     O                                           29 '0'
209700101203     O                       C1                  43
209800101203     O                       D1                  51
209900101203     O                       T1                  57
210000101206     O                                          131 'CONSOLIDATED ELIGIBILITY'
210100110502     O                       H@RI               167
210200101206     O                       H@CC               169
210300101228     O                       H@GN               176
210400101206     O                       H@CN               191
210500101206     O                       H@C#               198
210600101203     O                       D2                 206
210700110825     O                                          216 'MC'
210800101223     O                                          231 '*'
210900160616
211000160616      *============================================================================
211100160919     OAET1070WF EADD         MBRF
211200101203     O                                            6 'MEMBER'
211300101203     O                       @SS1                16
211400101203     O                       @SS2                25
211500101203     O                       @FN                 75
211600101203     O                       @MI                 76
211700101203     O                       @LN                 96
211800101203     O                       @REL               101
211900101203     O                       @SEX               103
212000101203     O                       @DOB               111
212100101203     O                       @SPEC              112
212200101203     O                                          113 '0'
212300101203     O                       @COB               123
212400101203     O                       @COBC              125
212500101203     O                       @COBN              145
212600101203     O                       @AD1               175
212700101203     O                       @AD2               205
212800101203     O                       @CTY               315
212900101203     O                       @ST                317
213000101203     O                       @ZP5               322
213100101203     O                       @PHN               349
213200141211     O               87                         576 '21207'
213300140626     O               88                         576 '21740'
213400141120     O               89                         576 '20171'
213500101203     O                       @EMPST             665
213600101203     O                       @HIRE              673
213700101223     O                                         1231 '*'
213800160616
213900160616      *============================================================================
214000160919     OAET1070WF EADD         HMOF
214100101213     O                                            7 'BENEFIT'
214200101213     O                       X@LAY               10
214300101214     O                       X@ELR               24
214400101213     O                       M@CC                26
214500101213     O                       H@GN                38
214600101213     O                       M@CLASS             44
214700101213     O                       M@PLAN              50
214800101213     O                       X@EFF               58
214900110929     O                       X@TRM               66
215000101213     O                       X@TIER              69
215100101213     O                       M@PCP              160
215200101213     O                       M@NPI              161
215300101213     O                       M@PCPCI            186
215400101223     O                                          323 '*'
215500160616
215600160616      *============================================================================
215700160919     OAET1070WF EADD         MEAF
215800140313     O                                            7 'BENEFIT'
215900140313     O                                           10 'MEA'
216000140313     O                       X@ELR               24
216100140313     O                       H@C#                31
216200140313     O                       E@SFX               34
216300140313     O                       E@ACCT              44
216400140313     O                       E@PLAN              50
216500140313     O                       X@EFF               58
216600140313     O                       X@TRM               66
216700140313     O                       E@CLM               71
216800140313     *** PCP BGN
216900140313     O                       E@PCP              127
217000140313     O               80                         161 'N'
217100140313     O               80                         186 '0'
217200140313     *** PCP END
217300140313     O                                          389 '0'
217400140313     *** COBRA BGN
217500140313     O                       E@CBREXP           466
217600140313     O                       E@CBREVT           516
217700140313     O                       E@CBRLEN           560
217800140313     *** COBRA END
217900140313     O                                          678 '*'
218000160616
218100160616      *============================================================================
218200160919     OAET1070WF EADD         DENF
218300101213     O                                            7 'BENEFIT'
218400101213     O                       X@LAY               10
218500101214     O                       X@ELR               24
218600101214     O                       H@C#                31
218700101213     O                       D@SFX               34
218800101213     O                       D@ACCT              44
218900101213     O                       D@PLAN              50
219000101213     O                       X@EFF               58
219100110929     O                       X@TRM               66
219200101213     O                       D@CLM               71
219300140313     *** PCD BGN
219400140313     O                       D@PCD              200
219500140313     O               81                         236 '0'
219600140313     *** PCD END
219700140313     O                                          389 '0'
219800140313     *** COBRA BGN
219900140313     O                       D@CBREXP           466
220000140313     O                       D@CBREVT           516
220100140313     O                       D@CBRLEN           560
220200140313     *** COBRA END
220300140313     O                       D@OOAI             609
220400140313     O                                          678 '*'
220500160616
220600160616      *============================================================================
220700160919     OAET1070WF EADD         LIFF
220800130315     O                                            7 'BENEFIT'
220900130412     O                                           11 'LIFE'
221000130315     O                       X@ELR               24
221100130319     O                       H@C#3               31
221200130315     O                       L@SFX               34
221300130315     O                       L@ACCT              44
221400130315     O                       L@PLAN              50
221500130315     O                       X@EFF               58
221600130315     O                       X@TRM               66
221700130315     O                       L@CLM               71
221800130315     O                       L@CBREXP           466
221900130315     O                       L@CBREVT           516
222000130315     O                       L@CBRLEN           560
222100130315     O                       L@SALARY           658
222200130315     O                                          659 '1'
222300130315     O                                          678 '*'
222400160616
222500160616      *============================================================================
222600160919     OAET1070WF EADD         TRLF
222700101203     O                                            7 'TRAILER'
222800101203     O                       @TREC               17
222900101203     O                       D1                  25
223000101203     O                       T1                  31
223100101203     O                       @BREC               41
223200101223     O                                           69 '*'
223300160616
223400160616      *============================================================================
