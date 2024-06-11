000100160122   X***X CARRIER CONTROL ID #0000000150 AETNA SPECIFIC
000200110513   X***X SSK 05.13.2011 TEMPLATE DESIGN
000300110513   X***X
000400151217   X***X 08.17.2014 CLONED FROM AET084R
000500101206   X***X
000600101206   X***X
000700151217     FCARXPTP   IF   E           K DISK
000800151217      * Carrier export control master
000900151217
001000101012     FCARACCP   IF   E           K DISK
001100151217      * Carrier export control by account
001200151217
001300101012     FCARPLNP   IF   E           K DISK
001400151217      * Carrier export control by plan
001500151217
001600160122     FAET006WF  IF   E           K DISK
001700120803     ** MAPPING METHOD
001800151217
001900160122     FAET840WF  O  A F 1231        DISK
002000101206     ** FLAT FILE
002100151217
002200160122     FAET841WF  IF A E           K DISK
002300101028     ** TERM TRACKER
002400151217
002500101012     FMEMAC#1   IF   E           K DISK
002600151217
002700101012     FMCOVMPLN  IF   E           K DISK
002800151217
002900101012     FDEPNDC    IF   E           K DISK
003000151217
003100101012     FDCOVA     IF   E           K DISK
003200151217
003300140313     FPCPL1     IF   E           K DISK
003400151217
003500120803     D KF@CCTL         S             10A   INZ
003600160122     D CARR#CTL        S             10A   INZ('0000000150')
003700120815     D*CARR#CTL2       S             10A   INZ('0000000051')
003800160126     D H@RI            S             25A   INZ('042064683')                     RECEIVER ID
003900151217
004000110512     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
004100101026     D DS@CARACC     E DS                  EXTNAME(CARACCP)
004200130315     D*DS@CARXPT     E DS                  EXTNAME(CARXPTP)
004300151217
004400110512     ** WORK ARRAY FOR PLANS
004500110512     **
004600110512     ** PC# - PLAN COUNT
004700110512     ** PP# - PLAN POINTER
004800110512     **
004900110512     D CARPLN@       E DS                  EXTNAME(CARPLNP)
005000151217     D                                     OCCURS(90) PREFIX(X:1)
005100110512     D PC#             S              3S 0
005200110512     D PP#             S              3S 0
005300110512     D @PLANIN         S              4A
005400110512     D @CCTRIN         S              3A
005500110513   X***X
005600110513     **
005700110513     ** WRITE TYPE = MEMBER OR DEPEND
005800110513     D WRT@TYPE        S              6A
005900110513     **
006000110512   X***X
006100101214     D #XST            S              6S 0
006200101214     D #IST            S               T
006300101026     D #ISO            S               D   DATFMT(*ISO)
006400101214     D #MINUEND        S               D   DATFMT(*ISO)
006500101214     D #SUBTRAEND      S               D   DATFMT(*ISO)
006600101214     D @DATE           S              8A
006700101214     D @TIME           S              6A
006800101214     D #DIFFRNC        S              5S 0
006900101214     D #2S0            S              2S 0
007000101214     D #CANCEL         S              8S 0
007100101026     D #XSX            S              8S 0
007200101026     D #XSX2           S              8S 0
007300101026     D DATE@OUT        S             10A
007400101026     D ENR@IN          S              3A
007500101026     D ENR@OUT         S              1A
007600110524     D DNTLATE         S              1A
007700130315     D TERM_LIF        S               N
007800101214     D TERM_DEN        S               N
007900101214     D TERM_MED        S               N
008000101026     D YES             S               N   INZ(*ON)
008100101026     D NO              S               N   INZ(*OFF)
008200140313     **
008300110512     D KF@TRS          S                   LIKE(MCTRST)
008400110512     D KF@SUB          S                   LIKE(MCSUB#)
008500110512     D KF@ACC          S                   LIKE(ACC#)
008600101026     D KF@ENR          S              3A   INZ
008700101026     D KF@CARG         S              2A   INZ
008800101026     D KF@CCTR         S                   LIKE(CCFLG)
008900101026     D KF@PLN          S                   LIKE(MCPLAN)
009000101026     D KF@TRM          S                   LIKE(NTTERMDT)
009100101026     D KF#TRM          S              8S 0
009200101026     D KF@SSN          S                   LIKE(MBSSNO)
009300101026     D KF@SEQ          S                   LIKE(DPSEQ#)
009400101026     D KF@TYP          S              1A
009500101026     D KF@CDE          S              2A
009600140313     D KF@SPCD         S              5A
009700140313     D KF@MPLN         S              4A
009800140313     **
009900101026     D M@EARLYP        S              4A
010000101026     D M#EARLYE        S              8S 0 INZ
010100101026     D M#EARLYT        S              8S 0 INZ
010200140313     **
010300101026     D #8D1            S              8S 0 INZ
010400101214     D D1              S              8A
010500101214     D D2              S              8A
010600101214     D T1              S              6A
010700101214     D C1              S             14A
010800101206    ***
010900101029     D B#RECCNT        S             10S 0 INZ
011000101029     D C#RECCNT        S             10S 0 INZ
011100101206    ***
011200101210     D @SS1            S              9A
011300101210     D @SS2            S              9A
011400101210     D @FN             S             15A
011500101210     D @MI             S              1A
011600101210     D @LN             S             20A
011700101210     D @REL            S              2A
011800101210     D @SEX            S              1A
011900101210     D @DOB            S              8A
012000101210     D @SPEC           S              1A
012100101210     D @COB            S              1A
012200101210     D @COBC           S              2A
012300101210     D @COBN           S             20A
012400101210     D @AD1            S             30A
012500101210     D @AD2            S             30A
012600101214     D @CTY            S             20A
012700101210     D @ST             S              2A
012800101210     D @ZP5            S              5A
012900101210     D @PHN            S             10A
013000101210     D @EMPST          S              2A
013100101210     D @HIRE           S              8A
013200101206    ***
013300130315    *** LIFE ARRAYS
013400130315     D L#CNE           S              3S 0 INZ
013500130315     D L#NDX           S              3S 0 INZ
013600130315     D L@PLN           S              4A   DIM(20)
013700130315     D L@ENR           S              3A   DIM(20)
013800130315     D L@FRM           S              8S 0 DIM(20)
013900130315     D L@TRM           S              8S 0 DIM(20)
014000130315     D L@MBREFF        S              8S 0
014100140313    ***
014200101206    *** DENTAL ARRAYS
014300101206     D D#CNE           S              3S 0 INZ
014400101206     D D#NDX           S              3S 0 INZ
014500101206     D D@PLN           S              4A   DIM(20)
014600101206     D D@ENR           S              3A   DIM(20)
014700101206     D D@FRM           S              8S 0 DIM(20)
014800101206     D D@TRM           S              8S 0 DIM(20)
014900110725     D D@MBREFF        S              8S 0
015000140313    ***
015100101206    *** MEDICAL ARRAYS
015200101206     D M#CNE           S              3S 0 INZ
015300101206     D M#NDX           S              3S 0 INZ
015400101206     D M@PLN           S              4A   DIM(20)
015500101206     D M@ENR           S              3A   DIM(20)
015600101206     D M@FRM           S              8S 0 DIM(20)
015700101206     D M@TRM           S              8S 0 DIM(20)
015800110725     D M@MBREFF        S              8S 0
015900101206    ***
016000101206     D H@SI            S             20A
016100101206     D H@CC            S              2A
016200101206     D H@GN            S              7A
016300101206     D H@CN            S             15A
016400101206     D H@C#            S              7A
016500130319     D H@C#3           S              7A
016600140313    ***
016700101213     D X@LAY           S              3A
016800101213     D X@ELR           S              7A
016900140313     D X@EFF           S              8A
017000140313     D X@TRM           S              8A
017100140313     D X@TIER          S              1A
017200140313    ***
017300101213     D M@CC            S              2A
017400101213     D M@CLASS         S              5A
017500101213     D M@PLAN          S              6A
017600101213     D M@PCP           S             40A
017700101213     D M@NPI           S              1A
017800101213     D M@PCPCI         S              1A
017900140313    ***
018000101213     D D@SFX           S              3A
018100101213     D D@ACCT          S              5A
018200101213     D D@PLAN          S              6A
018300101213     D D@CLM           S              3A
018400101213     D D@CBREXP        S              8A
018500101213     D D@CBREVT        S              8A
018600101213     D D@CBRLEN        S              2A
018700101213     D D@OOAI          S              1A
018800140313     D D@PCD           S              7A
018900140313    ***
019000101214     D @STEP           S              5A
019100140313    ***
019200140313     D E@SFX           S              3A
019300140313     D E@ACCT          S              5A
019400140313     D E@PLAN          S              6A
019500140313     D E@CLM           S              3A
019600140313     D E@PCP           S              7A
019700140313     D E@CBREXP        S              8A
019800140313     D E@CBREVT        S              8A
019900140313     D E@CBRLEN        S              2A
020000140313    ***
020100130315     D L@SFX           S              3A
020200130315     D L@ACCT          S              5A
020300130315     D L@PLAN          S              6A
020400130315     D L@CLM           S              3A
020500130315     D L@CBREXP        S              8A
020600130315     D L@CBREVT        S              8A
020700130315     D L@CBRLEN        S              2A
020800130315     D L@SALARY        S             20A
020900140313    ***
021000101026   X***X
021100110512     C                   EVAL      @STEP = 'PREP1'
021200101214    ***
021300120803     C                   EVAL      KF@CCTL = CARR#CTL
021400151217     C     KF@CCTL       CHAIN     CARXPTR
021500151217     C                   EXSR      $HEADR
021600110512    ***
021700120803     C     KF@CCTL       SETLL     CARACCR
021800110512    ***
021900101026     C                   DOU       @STEP = 'LEAVE'
022000101026     C     @STEP         CASEQ     'PREP1'       $PREP1
022100101026     C     @STEP         CASEQ     'STEP1'       $STEP1
022200101026     C     @STEP         CASEQ     'STEP2'       $STEP2
022300101026     C     @STEP         CASEQ     'STEP3'       $STEP3
022400101026     C     @STEP         CASEQ     'PREP4'       $PREP4
022500101026     C     @STEP         CASEQ     'STEP4'       $STEP4
022600101026     C     @STEP         CASEQ     'PREP5'       $PREP5
022700101026     C     @STEP         CASEQ     'STEP5'       $STEP5
022800101214     C     @STEP         CASEQ     'PREP6'       $PREP6
022900101026     C     @STEP         CASEQ     'STEP6'       $STEP6
023000101214     C     @STEP         CASEQ     'PREP7'       $PREP7
023100101214     C     @STEP         CASEQ     'STEP7'       $STEP7
023200101214     C     @STEP         CASEQ     'STEP8'       $STEP8
023300101214     C     @STEP         CASEQ     'PREP9'       $PREP9
023400101214     C     @STEP         CASEQ     'STEP9'       $STEP9
023500101214     C     @STEP         CASEQ     'PREPA'       $PREPA
023600101214     C     @STEP         CASEQ     'STEPA'       $STEPA
023700101214     C     @STEP         CASEQ     'PREPB'       $PREPB
023800101214     C     @STEP         CASEQ     'STEPB'       $STEPB
023900130315     C     @STEP         CASEQ     'PREPC'       $PREPC
024000130315     C     @STEP         CASEQ     'STEPC'       $STEPC
024100101026     C                   ENDCS
024200101026     C                   ENDDO
024300120711    ***
024400101206    ***  TRAILER RECORD
024500120711    ***
024600101026     C                   ADD       2             C#RECCNT
024700101214     C                   MOVE      C#RECCNT      @TREC            10 0
024800101214     C                   MOVE      B#RECCNT      @BREC            10 0
024900101214     C                   EXCEPT    TRLF
025000101026    ***
025100101026     C                   EVAL      *INLR = *ON
025200110512   S***S
025300110802     C     $HEADR        BEGSR
025400101206    ***
025500110802     C                   EVAL      D1 = @DATE
025600110802     C                   EVAL      D2 = @DATE
025700110802     C                   EVAL      T1 = @TIME
025800110802     C                   EVAL      C1 = @DATE + @TIME
025900110802    ***
026000151217     C     carr#ctl      CHAIN     CARACCR
026100110802    ***
026200110802     C                   EVAL      H@SI = %TRIM(CACID1)                         SUBMITTER ID
026300110802     C                   EVAL      H@CC = %SUBST(CACID2:1:2)                    COMPANY CODE
026400110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
026500110802     C                   MOVEL(P)  CACID4        H@CN                           CUSTOMER NAME
026600110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
026700130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
026800110802    ***
026900110802     C                   EXCEPT    HDRF
027000110802    ***
027100110802     C                   ENDSR
027200110802   S***S
027300110802     C     $PREP1        BEGSR
027400110802    ***
027500120803     C     KF@CCTL       READE     CARACCR
027600110512    ***
027700110512     C                   IF        %EOF(CARACCP)
027800120803      *
027900120815     C*                  IF        KF@CCTL = CARR#CTL
028000120815     C*                  EVAL      KF@CCTL = CARR#CTL2
028100120815     C*    KF@CCTL       SETLL     CARACCR
028200120815     C*                  ELSE
028300110512     C                   EVAL      @STEP = 'LEAVE'
028400120815     C*                  ENDIF
028500120803      *
028600110512     C                   LEAVESR
028700110512     C                   ENDIF
028800110512    ***
028900110513    *** HAS THE ACCOUNT BEEN SHUTOFF FOR EXPORT?
029000110513    ***
029100110512     C                   IF        CASTATUS <> 'Y'
029200110512     C                   LEAVESR
029300110512     C                   ENDIF
029400110512    ***
029500110802    *** THESE FIELDS RESET FOR EACH SMALL GROUP READ
029600110802    ***
029700110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
029800110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
029900130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
030000110802    ***
030100110512     C                   EVAL      KF@TRS = CATRST
030200110512     C                   EVAL      KF@SUB = CASUB#
030300110512     C                   EVAL      KF@ACC = CAACCT
030400110512    ***
030500110512     C                   EXSR      $PLANLOAD
030600110512    ***
030700101206     C                   EVAL      @STEP = 'STEP1'
030800110512    ***
030900110512     C                   ENDSR
031000110512   S***S
031100101206     C     $STEP1        BEGSR
031200101206    ***
031300101206     C                   EVAL      KF@PLN = *BLANKS
031400101206     C                   EVAL      KF@TRM = 0
031500101206     C                   EVAL      KF@SSN = 0
031600101206     C                   EVAL      KF@SEQ = 0
031700110512    ***
031800101206     C     KL#TSA        SETLL     MEMBR
031900101206    ***
032000101206     C                   EVAL      @STEP = 'STEP2'
032100101206    ***
032200101206     C                   ENDSR
032300101206   S***S
032400101206     C     $STEP2        BEGSR
032500101206    ***
032600101206     C     KL#TSA        READE     MEMBR
032700101206    ***
032800101206     C                   IF        %EOF(MEMAC#1)
032900110512     C                   EVAL      @STEP = 'PREP1'
033000101206     C                   LEAVESR
033100101206     C                   ENDIF
033200101206    ***
033300101206     C                   EVAL      KF@SSN = MBSSNO
033400101214     C                   MOVE      *ZEROS        KF@SEQ
033500120803     C                   EVAL      WRT@TYPE = 'MEMBER'
033600120803    ***
033700101214    ***
033800101206     C     KL#MPLN       SETLL     MCOVR
033900101206    ***
034000101206     C                   EXSR      $CLRSTG
034100101206    ***
034200101206     C                   EVAL      @STEP = 'STEP3'
034300101206    ***
034400101206     C                   ENDSR
034500101210   S***S
034600101206     C     $STEP3        BEGSR
034700101206    ***
034800101206     C     KL#MPLN       READE     MCOVR
034900101206    ***
035000101206     C                   IF        %EOF(MCOVMPLN)
035100101206     C                   EVAL      @STEP = 'PREP4'
035200101206     C                   LEAVESR
035300101206     C                   ENDIF
035400101206    ***
035500130131     C*                  IF        ENRLDT = CANDT
035600130131     C*                  LEAVESR
035700130131     C*                  ENDIF
035800120803    ***
035900120803     C                   EVAL      KF@PLN = MCPLAN
036000160122     C     KL#TSAP       CHAIN     AEF06
036100160122     C                   IF        NOT %FOUND(AET006WF)
036200120803     C                   LEAVESR
036300120803     C                   ENDIF
036400110513    ***
036500110512     C                   EVAL      @PLANIN = MCPLAN
036600111020     C                   EVAL      ENR@IN = MCOVTP
036700110802    ***
036800110802     C                   EXSR      $QUIK
036900110802    ***
037000110512     C                   EXSR      $PLANSRCH
037100110512    ***
037200110512     C                   IF        PLN@CAT = *BLANKS
037300110512     C                   LEAVESR
037400110512     C                   ENDIF
037500101206    ***
037600101206     C                   IF        CANDT = 0
037700101206     C                   EVAL      #CANCEL = 99999999
037800101206     C                   ELSE
037900101206     C                   EVAL      #CANCEL = CANDT
038000101206     C                   ENDIF
038100101206    ***
038200130315    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL;
038300130315    *** LIF IS LIFE;
038400110513    ***
038500130315     C                   SELECT
038600130315      *
038700130409    *C                   WHEN      PLN@CAT = 'LIFE'
038800130315    *C                   IF        L#CNE > 0
038900130315    *C                   IF        L@TRM(L#CNE) = 99999999
039000130315     C                   LEAVESR
039100130315     C                   ENDIF
039200130315     C                   ENDIF
039300130315    *C                   ADD       1             L#CNE
039400130315    *C                   EVAL      L@PLN(L#CNE) = MCPLAN
039500130315    *C                   EVAL      L@ENR(L#CNE) = MCOVTP
039600130315    *C                   EVAL      L@FRM(L#CNE) = ENRLDT
039700130315    *C                   EVAL      L@TRM(L#CNE) = #CANCEL
039800130315      *
039900130315    *C                   WHEN      PLN@CAT = 'DEN'
040000130131    *C                   IF        D#CNE > 0
040100130131    *C                   IF        D@TRM(D#CNE) = 99999999
040200130131     C                   LEAVESR
040300130131     C                   ENDIF
040400130131     C                   ENDIF
040500110513    *C                   ADD       1             D#CNE
040600110513    *C                   EVAL      D@PLN(D#CNE) = MCPLAN
040700110513    *C                   EVAL      D@ENR(D#CNE) = MCOVTP
040800110513    *C                   EVAL      D@FRM(D#CNE) = ENRLDT
040900110513    *C                   EVAL      D@TRM(D#CNE) = #CANCEL
041000130315      *
041100130315     C                   OTHER
041200130131    *C                   IF        M#CNE > 0
041300130131    *C                   IF        M@TRM(M#CNE) = 99999999
041400130131     C                   LEAVESR
041500130131     C                   ENDIF
041600130131     C                   ENDIF
041700101206     C                   ADD       1             M#CNE
041800101206     C                   EVAL      M@PLN(M#CNE) = MCPLAN
041900101206     C                   EVAL      M@ENR(M#CNE) = MCOVTP
042000101206     C                   EVAL      M@FRM(M#CNE) = ENRLDT
042100101206     C                   EVAL      M@TRM(M#CNE) = #CANCEL
042200130315      *
042300130315    *C                   ENDSL
042400110512    ***
042500110512     C                   ENDSR
042600110512   S***S
042700110802     C     $QUIK         BEGSR
042800110802    ***
042900110805     C                   EVAL      @CCTRIN = *BLANKS
043000120803    ***
043100160122     C     AE6MAP        CASEQ     '2TIER     '  $METH01
043200160122     C     AE6MAP        CASEQ     'ITOBJECTS '  $METH02
043300160122     C     AE6MAP        CASEQ     'NORULE    '  $METH03
043400160122     C     AE6MAP        CASEQ     'STATETIER '  $METH04
043500160122     C     AE6MAP        CASEQ     'TIERSTS   '  $METH05
043600160122     C     AE6MAP        CASEQ     'MAYOR     '  $METH06
043700160122     C     AE6MAP        CASEQ     'EMPSTS    '  $METH07
043800160122     C     AE6MAP        CASEQ     'JUSTSTATE '  $METH08
043900160122     C     AE6MAP        CASEQ     'JOHNLS    '  $METH09
044000160122     C     AE6MAP        CASEQ     'CREATIVE  '  $METH10
044100160122     C     AE6MAP        CASEQ     'INTEGRA   '  $METH11
044200160122     C     AE6MAP        CASEQ     'STSTATE   '  $METH12
044300160122     C     AE6MAP        CASEQ     'INTEGRA   '  $METH11
044400160122     C     AE6MAP        CASEQ     'STIERSTS  '  $METH13
044500120803     C                   ENDCS
044600120803    ***
044700120803     C                   ENDSR
044800120803   S***S
044900120803    *** 2 TIER = AETNA HAS TWO TIERS, IND AND FAM
045000120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'IND' AND NON-'TIN' CONVERTED TO 'FAM'
045100120803    ***  DEPENDENTS HAVE 'FAM' ONLY
045200120803    ***
045300120803    *** IND, FAM
045400120803    ***
045500120803     C     $METH01       BEGSR
045600120803    ***
045700120803     C                   IF        WRT@TYPE = 'MEMBER'
045800120803    *** *
045900120803     C                   IF        ENR@IN = 'TIN'
046000120803     C                   EVAL      @CCTRIN = 'IND'
046100120803     C                   ELSE
046200120803     C                   EVAL      @CCTRIN = 'FAM'
046300120803     C                   ENDIF
046400120803    *** *
046500120803     C                   ENDIF
046600120803    ***
046700120803     C                   IF        WRT@TYPE = 'DEPEND'
046800120803    *** *
046900120803     C                   EVAL      @CCTRIN = 'FAM'
047000120803    *** *
047100120803     C                   ENDIF
047200120803    ***
047300120803     C                   ENDSR
047400120803   S***S
047500120803    *** ITOBJECTS = IF YOU ARE NOT 'VA' OR 'OH' STATE CODES, YOU ARE 'XX'
047600120803    ***
047700120803    *** VA, OH, XX
047800120803    ***
047900120803     C     $METH02       BEGSR
048000120803    ***
048100120803     C                   IF        STATE <> 'VA' AND STATE <> 'OH'
048200120803     C                   EVAL      @CCTRIN = 'XX '
048300120803     C                   ELSE
048400120803     C                   EVAL      @CCTRIN = STATE
048500120803     C                   ENDIF
048600120803    ***
048700120803     C                   ENDSR
048800120803   S***S
048900120803    *** NORULE = NUFF SAID
049000120803    ***
049100120803     C     $METH03       BEGSR
049200120803    ***
049300120803     C                   EVAL      @CCTRIN = *BLANKS
049400120803    ***
049500120803     C                   ENDSR
049600120803   S***S
049700120803    *** STATETIER
049800120803    ***  START WITH STATE CODE
049900120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
050000120803    ***  DEPENDENTS HAVE 'F' ONLY
050100120803    ***
050200120803    *** MDI, MDF, ETC...
050300120803    ***
050400120803     C     $METH04       BEGSR
050500120803    ***
050600120803     C                   EVAL      @CCTRIN = STATE
050700120803    ***
050800120803     C                   IF        WRT@TYPE = 'MEMBER'
050900120803     C                   IF        ENR@IN = 'TIN'
051000120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
051100120803     C                   ELSE
051200120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
051300120803     C                   ENDIF
051400120803     C                   ENDIF
051500120803    ***
051600120803     C                   IF        WRT@TYPE = 'DEPEND'
051700120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
051800120803     C                   ENDIF
051900120803    ***
052000120803     C                   ENDSR
052100120803   S***S
052200120803    *** TIERSTS
052300120803    ***  START WITH EMPLOYMENT STATUS, ACTIVE IS 'ACT' AND COBRA IS 'COB'
052400120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
052500120803    ***  DEPENDENTS HAVE 'F' ONLY
052600120803    ***
052700120803    *** ACI, ACF, COI, COF
052800120803    ***
052900120803     C     $METH05       BEGSR
053000120803    ***
053100120803     C                   IF        EMPST =  'C'
053200120803     C                   EVAL      @CCTRIN = 'COB'
053300120803     C                   ELSE
053400120803     C                   EVAL      @CCTRIN = 'ACT'
053500120803     C                   ENDIF
053600120803    ***
053700120803     C                   IF        ENR@IN = 'TIN'
053800120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
053900120803     C                   ELSE
054000120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
054100120803     C                   ENDIF
054200120803    ***
054300120803     C                   ENDSR
054400120803   S***S
054500120803    *** MAYOR
054600120803    ***  WELL, FOR THE PLAN 'DAAU' IF THE STATE IS 'WV' THEN PLACE TIER STATUS SUFFIX
054700120803    ***       BY TYPE OF PEEP; FOR OTHER STATES, USE A SIMPLE TIER CHECK.
054800120803    ***
054900120803    ***  WVI, WVF, IND, FAM
055000120803    ***
055100120803    ***  NOW, FOR THE PLAN 'DAAT' IF THE STATE IS 'WV' THEN PLACE EMPLOYMENT STATUS SUFFIX
055200120803    ***       BY TYPE OF PEEP; FOR OTHER STATES, EMPLOYMENT STATUS AND TIER.
055300120803    ***
055400120803    ***  WVI, WVF, CBI, CBF, ACI, ACF
055500120803    ***
055600120803    ***
055700120803     C     $METH06       BEGSR
055800120803    ***
055900120803    1C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'MEMBER'
056000120803      *
056100120803    2C                   IF        STATE = 'WV'
056200120803      **
056300120803    3C                   IF        ENR@IN = 'TIN'
056400120803     C                   EVAL      @CCTRIN = 'WVI'
056500120803    3C                   ELSE
056600120803     C                   EVAL      @CCTRIN = 'WVF'
056700120803    3C                   ENDIF
056800120803      **
056900120803    2C                   ELSE
057000120803      **
057100120803    3C                   IF        ENR@IN = 'TIN'
057200120803     C                   EVAL      @CCTRIN = 'IND'
057300120803    3C                   ELSE
057400120803     C                   EVAL      @CCTRIN = 'FAM'
057500120803    3C                   ENDIF
057600120803      **
057700120803    2C                   ENDIF
057800120803      *
057900120803     C                   LEAVESR
058000120803    1C                   ENDIF
058100120803    ***
058200120803     C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'DEPEND'
058300120803      *
058400120803     C                   IF        STATE = 'WV'
058500120803     C                   EVAL      @CCTRIN = 'WVF'
058600120803     C                   ELSE
058700120803     C                   EVAL      @CCTRIN = 'FAM'
058800120803     C                   ENDIF
058900120803      *
059000120803     C                   LEAVESR
059100120803     C                   ENDIF
059200120803    ***
059300120803    1C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'MEMBER'
059400120803      *
059500120803    2C                   IF        STATE = 'WV'
059600120803      **
059700120803    3C                   IF        ENR@IN = 'TIN'
059800120803     C                   EVAL      @CCTRIN = 'WVI'
059900120803    3C                   ELSE
060000120803     C                   EVAL      @CCTRIN = 'WVF'
060100120803    3C                   ENDIF
060200120803      **
060300120803    2C                   ELSE
060400120803      **
060500120803    3C                   IF        EMPST =  'C'
060600120803     C                   EVAL      @CCTRIN = 'CB '
060700120803    3C                   ELSE
060800120803     C                   EVAL      @CCTRIN = 'AC '
060900120803    3C                   ENDIF
061000120803    3C                   IF        ENR@IN = 'TIN'
061100120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
061200120803    3C                   ELSE
061300120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
061400120803    3C                   ENDIF
061500120803      **
061600120803    2C                   ENDIF
061700120803      *
061800120803     C                   LEAVESR
061900120803    1C                   ENDIF
062000120803    ***
062100120803     C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'DEPEND'
062200120803      *
062300120803     C                   IF        STATE = 'WV'
062400120803     C                   EVAL      @CCTRIN = 'WVF'
062500120803     C                   ELSE
062600120803     C                   IF        EMPST =  'C'
062700120803     C                   EVAL      @CCTRIN = 'CBF'
062800120803     C                   ELSE
062900120803     C                   EVAL      @CCTRIN = 'ACF'
063000120803     C                   ENDIF
063100120803     C                   ENDIF
063200120803      *
063300120803     C                   ENDIF
063400120803    ***
063500120803     C                   ENDSR
063600120803   S***S
063700120803    *** EMPSTS
063800120803    ***   PRETTY STRAIGHT FORWARDED
063900120803    ***
064000120803     C     $METH07       BEGSR
064100120803    ***
064200120803     C                   IF        EMPST =  'C'
064300120803     C                   EVAL      @CCTRIN = 'COB'
064400120803     C                   ELSE
064500120803     C                   EVAL      @CCTRIN = 'ACT'
064600120803     C                   ENDIF
064700120803    ***
064800120803     C                   ENDSR
064900120803   S***S
065000120803    *** JUSTSTATE
065100120803    ***   PRETTY STRAIGHT FORWARDED
065200120803    ***
065300120803     C     $METH08       BEGSR
065400120803    ***
065500120803     C                   EVAL      @CCTRIN = STATE
065600120803    ***
065700120803     C                   ENDSR
065800120803   S***S
065900120803    *** JOHNLS
066000120803    ***   IF STATE IS NOT MARYLAND, DEFAULT TO 'XX', ELSE USE 'MD'; THEN APPLY TIER.
066100120803    ***
066200120803    *** MDI, MDF, XXI, XXF
066300120803    ***
066400120803     C     $METH09       BEGSR
066500120803    ***
066600120803     C                   IF        WRT@TYPE = 'MEMBER'
066700120803     C                   IF        STATE = 'MD'
066800120803     C                   EVAL      @CCTRIN = 'MD'
066900120803     C                   ELSE
067000120803     C                   EVAL      @CCTRIN = 'XX'
067100120803     C                   ENDIF
067200120803     C                   IF        ENR@IN = 'TIN'
067300120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
067400120803     C                   ELSE
067500120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
067600120803     C                   ENDIF
067700120803     C                   ENDIF
067800120803    ***
067900120803     C                   IF        WRT@TYPE = 'DEPEND'
068000120803     C                   IF        STATE = 'MD'
068100120803     C                   EVAL      @CCTRIN = 'MDF'
068200120803     C                   ELSE
068300120803     C                   EVAL      @CCTRIN = 'XXF'
068400120803     C                   ENDIF
068500120803     C                   ENDIF
068600120803    ***
068700120803     C                   ENDSR
068800120803   S***S
068900120803    *** CREATIVE
069000120803    ***   IF STATE IS NOT 'MD' OR 'OK', DEFAULT TO '**'.
069100120803    ***
069200120803    *** MD, OK, **
069300120803    ***
069400120803     C     $METH10       BEGSR
069500120803    ***
069600120803     C                   IF        STATE <> 'MD' AND STATE <> 'OK'
069700120803     C                   EVAL      @CCTRIN = '** '
069800120803     C                   ELSE
069900120803     C                   EVAL      @CCTRIN = STATE
070000120803     C                   ENDIF
070100120803    ***
070200120803     C                   ENDSR
070300120803   S***S
070400120803    *** INTEGRA = USE 'TN' FOR TENNESSEE, OTHER STATES ARE 'XX'
070500120803    ***
070600120803    ***  TN, XX
070700120803    ***
070800120803     C     $METH11       BEGSR
070900120803    ***
071000121113     C                   SELECT
071100121113     C                   WHEN      STATE = 'TN'
071200121113     C                   EVAL      @CCTRIN = STATE                              TENNESSEE ONLY
071300121113     C                   WHEN      STATE = 'FL'
071400121113     C                   EVAL      @CCTRIN = STATE                              FLORIDA ONLY
071500121113     C                   OTHER
071600121113     C                   EVAL      @CCTRIN = 'XX '                              SITUS
071700121113     C                   ENDSL
071800120803    ***
071900120803     C                   ENDSR
072000120803   S***S
072100120803    *** STSTATE = STATE CODE WITH EMPLOYEE STATUS
072200120803    ***
072300120803    ***  MDA, MDC, ETC...
072400120803    ***
072500120803     C     $METH12       BEGSR
072600120803    ***
072700120803     C                   EVAL      @CCTRIN = STATE + EMPST
072800120803    ***
072900120803     C                   ENDSR
073000130123   S***S
073100130123    *** STIERSTS = STATE CODE WITH TIER WITH EMPLOYEE STATUS
073200130123    ***    ACTIVE [#CALC = 0]      COBRA [#CALC = 5]
073300130123    ***    IND [+1 TO #CALC ]      NON-IND COVERAGE [+2 TO CALC]
073400130123    ***
073500130123    ***    EACH STATE PUT AT END, GIVING FAM MARYLAND ACTIVE A VALUE OF 2MD
073600130123    ***                                  IND WEST VIRGINIA COBRA A VALUE OF 6WV
073700130123    ***
073800130123    ***
073900130123     C     $METH13       BEGSR
074000130123    ***
074100130123     C                   SELECT
074200130123     C                   WHEN      EMPST =  'C'
074300130123     C                   Z-ADD     5             #CALC
074400130123     C                   OTHER
074500130123     C                   MOVE      *ZEROS        #CALC             1 0
074600130123     C                   ENDSL
074700130123    ***
074800130123     C                   SELECT
074900130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN = 'TIN'
075000130123     C                   ADD       1             #CALC
075100130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN <> 'TIN'
075200130123     C                   ADD       2             #CALC
075300130123     C                   WHEN      WRT@TYPE = 'DEPEND'
075400130123     C                   ADD       2             #CALC
075500130123     C                   ENDSL
075600130123    ***
075700130123     C                   EVAL      @CCTRIN = %EDITC(#CALC:'X') + STATE
075800130123    ***
075900130123     C                   ENDSR
076000120803   S***S
076100120409     C     $PREP4        BEGSR
076200120409    ***
076300130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
076400101206     C                   EVAL      @STEP = 'STEP2'
076500101206     C                   LEAVESR
076600101206     C                   ENDIF
076700130520    ***
076800130520     C                   EVAL      @STEP = 'STEP4'
076900130315     C                   EVAL      TERM_LIF = NO
077000101210     C                   EVAL      TERM_DEN = NO
077100101210     C                   EVAL      TERM_MED = NO
077200101210    ***
077300130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
077400130520     C                   IF        L@TRM(L#CNE) <> 99999999
077500130520     C                   EXSR      $CHKHEM
077600130520     C                   ENDIF
077700130520     C                   LEAVESR
077800130520     C                   ENDIF
077900130520    ***
078000130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
078100130520     C                   IF        M@TRM(M#CNE) <> 99999999
078200130520     C                   EXSR      $CHKHEM
078300130520     C                   ENDIF
078400130520     C                   LEAVESR
078500130520     C                   ENDIF
078600130520    ***
078700130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
078800130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
078900130520     C                              M@TRM(M#CNE) <> 99999999)
079000130520     C                   EXSR      $CHKHEM
079100130520     C                   ENDIF
079200130520     C                   LEAVESR
079300130520     C                   ENDIF
079400130520    ***
079500130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
079600130520     C                   IF        D@TRM(D#CNE) <> 99999999
079700130520     C                   EXSR      $CHKHEM
079800130520     C                   ENDIF
079900130520     C                   LEAVESR
080000130520     C                   ENDIF
080100130520    ***
080200130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
080300130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
080400130520     C                              D@TRM(D#CNE) <> 99999999)
080500130520     C                   EXSR      $CHKHEM
080600130520     C                   ENDIF
080700130520     C                   LEAVESR
080800130520     C                   ENDIF
080900130520    ***
081000130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
081100130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
081200130520     C                              M@TRM(M#CNE) <> 99999999)
081300130520     C                   EXSR      $CHKHEM
081400130520     C                   ENDIF
081500130520     C                   LEAVESR
081600130520     C                   ENDIF
081700130520    ***
081800130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
081900130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
082000130520     C                              L@TRM(L#CNE) <> 99999999 OR
082100130520     C                              M@TRM(M#CNE) <> 99999999)
082200130520     C                   EXSR      $CHKHEM
082300130520     C                   ENDIF
082400130520     C                   LEAVESR
082500130520     C                   ENDIF
082600101214    ***
082700101214     C                   ENDSR
082800101214   S***S
082900101210    *** GENERATE MEMBER RECORD
083000101210    ***
083100101210     C     $STEP4        BEGSR
083200101210    ***
083300130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
083400101214     C                   EVAL      @STEP = 'STEP2'
083500101214     C                   LEAVESR
083600101214     C                   ENDIF
083700101214    ***
083800110513     C                   EVAL      WRT@TYPE = 'MEMBER'
083900110725    ***
084000130315     C                   EVAL      L@MBREFF = 0
084100110725     C                   EVAL      D@MBREFF = 0
084200110725     C                   EVAL      M@MBREFF = 0
084300110513    ***
084400101210     C                   EVAL      @SS1   = %EDITC(MBSSNO:'X')
084500101210     C                   EVAL      @SS2   = @SS1
084600101210     C                   MOVEL(P)  MLNAME        @LN
084700101210     C                   MOVEL(P)  MFNAME        @FN
084800101210     C                   EVAL      @MI    = MMI
084900101210     C                   EVAL      @REL   = '01'
085000101210     C                   EVAL      @SEX   = SEX
085100101210     C                   EVAL      @DOB   = %EDITC(BIRTH:'X')
085200101210     C                   IF        COB = 'Y'
085300101210     C                   EVAL      @COB   = 'Y'
085400101210     C                   EVAL      @COBC  = 'OT'
085500101210     C                   EVAL      @COBN  = MCOBPN
085600101210     C                   ENDIF
085700101210     C                   EVAL      @AD1   = %TRIM(ADDR1)
085800101210     C                   EVAL      @AD2   = %TRIM(ADDR2)
085900101210     C                   EVAL      @CTY   = %TRIM(CITY)
086000101210     C                   EVAL      @ST    = STATE
086100101210     C                   MOVE      *BLANKS       @9                9
086200101210     C                   EVAL      @9   = %EDITC(ZIP:'X')
086300101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
086400101210     C                   EVAL      @PHN   = %EDITC(AREA:'X') +
086500101210     C                                      %EDITC(PHONE:'X')
086600101210    ***
086700101210     C                   SELECT
086800101210     C                   WHEN      EMPST = 'A'
086900101210     C                   EVAL      @EMPST = 'AC'
087000101210     C                   WHEN      EMPST = 'C'
087100101210     C                   EVAL      @EMPST = 'CO'
087200101210     C                   WHEN      EMPST = 'R'
087300101210     C                   EVAL      @EMPST = 'RT'
087400101210     C                   ENDSL
087500101210    ***
087600101210     C                   EVAL      @HIRE  = %EDITC(EMPDT:'X')
087700101210    ***
087800141211     C                   SETOFF                                       888987
087900141120        IF KF@TRS = 770 AND KF@SUB = 004 AND KF@ACC = 0037 AND
088000141120          STATE = 'VT';
088100141120           *IN89 = *ON;
088200141120        ENDIF;
088300141211    *** IF KF@TRS = 591 AND KF@SUB = 001 AND KF@ACC = 0042 AND
088400141211    ***   STATE = 'TX';
088500141211    ***    *IN87 = *ON;
088600141211    *** ENDIF;
088700141120    ***
088800101210     C                   EXCEPT    MBRF
088900101214     C                   ADD       1             C#RECCNT
089000101213    ***
089100101213     C                   EVAL      @STEP = 'PREP5'
089200101210    ***
089300101210     C                   ENDSR
089400101210   S***S
089500130315    *** * * * * * MEDICAL
089600101214     C     $PREP5        BEGSR
089700101214    ***
089800101214     C                   IF        M#CNE = 0
089900110513     C                   EVAL      @STEP = 'PREP6'
090000101214     C                   LEAVESR
090100101214     C                   ENDIF
090200101214    ***
090300101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
090400130315     C                   EVAL      KF@ENR = M@ENR(M#CNE)
090500101214    ***
090600101214     C                   IF        TERM_MED = YES
090700101214     C                   EXSR      $WRTERM
090800101214     C                   ENDIF
090900101214    ***
091000110512     C                   EVAL      @PLANIN = KF@PLN
091100120803    ***
091200160122     C     KL#TSAP       CHAIN     AEF06
091300160122     C                   IF        NOT %FOUND(AET006WF)
091400120803     C                   LEAVESR
091500120803     C                   ENDIF
091600120803    ***
091700111020     C                   EVAL      ENR@IN = M@ENR(M#CNE)
091800111020    ***
091900110802     C                   EXSR      $QUIK
092000110802    ***
092100110512     C                   EXSR      $PLANSRCH
092200110512    ***
092300110512     C                   IF        PLN@CAT = *BLANKS
092400101214     C                   SETON                                        H1
092500101214     C                   ENDIF
092600110512    ***
092700110513     C                   EVAL      @STEP = 'STEP5'
092800110725     C                   EVAL      #XSX = M@FRM(M#CNE)
092900110725     C                   EVAL      M@MBREFF = #XSX
093000101214    ***
093100101214     C                   ENDSR
093200101214   S***S
093300101214     C     $STEP5        BEGSR
093400101214    ***
093500110513     C                   IF        CPCID1 = 'MEA'
093600110513     C                   EXSR      $MEAWRT
093700110513     C                   ELSE
093800110513     C                   EXSR      $HMOWRT
093900110513     C                   ENDIF
094000110513    ***
094100101214     C                   ADD       1             C#RECCNT
094200101214     C                   ADD       1             B#RECCNT
094300110512    ***
094400110513     C                   EVAL      @STEP = 'PREP6'
094500110513    ***
094600110513     C                   ENDSR
094700110513   S***S
094800130315    *** DENTAL
094900130315    ***
095000101214     C     $PREP6        BEGSR
095100101213    ***
095200110513    *C                   IF        D#CNE = 0
095300130315    *C                   EVAL      @STEP = 'PREPC'
095400130315    *C*****************  EVAL      @STEP = 'PREP7'
095500110513    *C                   LEAVESR
095600110513    *C                   ENDIF
095700110512    ***
095800110513    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
095900130315    *C                   EVAL      KF@ENR = D@ENR(D#CNE)
096000130315    ***
096100160122     C     KL#TSAP       CHAIN     AEF06
096200160122     C                   IF        NOT %FOUND(AET006WF)
096300120803     C                   LEAVESR
096400120803     C                   ENDIF
096500110512    ***
096600110513    *C                   IF        TERM_DEN = YES
096700110513    *C                   EXSR      $WRTERM
096800110513    *C                   ENDIF
096900110513    ***
097000110513     C                   EVAL      @PLANIN = KF@PLN
097100111020     C                   EVAL      ENR@IN = D@ENR(D#CNE)
097200110513    ***
097300111011     C                   EXSR      $QUIK
097400110513    ***
097500110513     C                   EXSR      $PLANSRCH
097600110513    ***
097700110513     C                   IF        PLN@CAT = *BLANKS
097800110513     C                   SETON                                        H2
097900110513     C                   ENDIF
098000110512    ***
098100110513    *C                   EVAL      @STEP = 'STEP6'
098200110725     C                   EVAL      #XSX = D@FRM(D#CNE)
098300110725     C                   EVAL      D@MBREFF = #XSX
098400110512    ***
098500101213     C                   ENDSR
098600110802   S***S
098700110513    *** DENTAL FORMAT
098800110513    ***
098900110513    *C     $STEP6        BEGSR
099000110513    ***
099100110513     C                   EXSR      $DENWRT
099200110513    ***
099300110513    *C                   ADD       1             C#RECCNT
099400110513    *C                   ADD       1             B#RECCNT
099500110513    ***
099600130315    *C****************** EVAL      @STEP = 'PREP7'
099700130315    *C                   EVAL      @STEP = 'PREPC'
099800110513    ***
099900110513    *C                   ENDSR
100000110513   S***S
100100130315    *** LIFE AND AD&D PLANS FOR MEMBER
100200130315    ***
100300130315     C     $PREPC        BEGSR
100400130315    ***
100500130315    *C                   IF        L#CNE = 0
100600130315    *C                   EVAL      @STEP = 'PREP7'
100700130315    *C                   LEAVESR
100800130315    *C                   ENDIF
100900130315    ***
101000130315    *C                   EVAL      KF#TRM = L@TRM(L#CNE)
101100130315    *C                   EVAL      KF@PLN = L@PLN(L#CNE)
101200130315     C                   EVAL      KF@ENR = L@ENR(L#CNE)
101300130315    ***
101400160122     C     KL#TSAP       CHAIN     AEF06
101500160122     C                   IF        NOT %FOUND(AET006WF)
101600130315     C                   LEAVESR
101700130315     C                   ENDIF
101800130315    ***
101900130315    *C                   IF        TERM_LIF = YES
102000130315    *C                   EXSR      $WRTERM
102100130315    *C                   ENDIF
102200130315    ***
102300130315     C                   EVAL      @PLANIN = KF@PLN
102400130315     C                   EVAL      ENR@IN = L@ENR(L#CNE)
102500130315    ***
102600130315     C                   EXSR      $QUIK
102700130315    ***
102800130315     C                   EXSR      $PLANSRCH
102900130315    ***
103000130315     C                   IF        PLN@CAT = *BLANKS
103100130315     C                   SETON                                        H2
103200130315     C                   ENDIF
103300130315    ***
103400130315    *C                   EVAL      @STEP = 'STEPC'
103500130315     C                   EVAL      #XSX = L@FRM(L#CNE)
103600130315     C                   EVAL      L@MBREFF = #XSX
103700130315    ***
103800130315     C                   ENDSR
103900130315   S***S
104000130315    *** LIFE FORMAT
104100130315    ***
104200130315    *C     $STEPC        BEGSR
104300130315    ***
104400130315     C                   EXSR      $LIFWRT
104500130315    ***
104600130315    *C                   ADD       1             C#RECCNT
104700130315    *C                   ADD       1             B#RECCNT
104800130315    ***
104900130315    *C                   EVAL      @STEP = 'PREP7'
105000130315    ***
105100130315    *C                   ENDSR
105200130315   S***S
105300130315     C     $LIFWRT       BEGSR
105400130315    ***
105500130315    *C                   EVAL      X@LAY = CPCID1                               LAYOUT
105600130315    *C                   EVAL      X@ELR = CPCID2                               ELR
105700130315    *C                   EVAL      L@SFX = CPCID3                               SUFFIX
105800130315    *C                   EVAL      L@ACCT = CPCID4                              ACCOUNT
105900130315    *C                   EVAL      L@PLAN = CPCID5                              PLAN
106000130315    *C                   EVAL      L@CLM = CPCID6                               CLAIM OFFICE
106100130315    ***
106200130315    *C                   EVAL      #XSX = L@FRM(L#CNE)
106300130315     C                   MOVE      #XSX          X@EFF
106400130315    ***
106500130315    *C                   EVAL      #XSX = L@TRM(L#CNE)
106600130315    *C                   IF        #XSX = 0 OR #XSX = 99999999
106700130315    *C                   MOVE      *BLANKS       X@TRM
106800130315    *C                   ELSE
106900130315    *C                   MOVE      #XSX          X@TRM
107000130315    *C                   ENDIF
107100140313    ***
107200140313     C                   MOVE      *BLANKS       L@CBREXP
107300140313     C                   MOVE      *BLANKS       L@CBREVT
107400140313     C                   MOVE      *BLANKS       L@CBRLEN
107500130315    ***
107600130923    *C                   IF        EMPST = 'C' AND
107700130923     C                             CEXPDT > 0
107800130315    *C                   MOVE      CEXPDT        L@CBREXP
107900130315    *C                   MOVE      QEDT          L@CBREVT
108000130315    *C                   MOVE      CEXPDT        #MINUEND
108100130315    *C                   MOVE      QEDT          #SUBTRAEND
108200130315    *C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
108300130315    *C                   Z-ADD     #DIFFRNC      #2S0
108400130315    *C                   MOVE      #2S0          L@CBRLEN
108500130315    *C                   ENDIF
108600130315    ***
108700130315     C                   EVAL      L@SALARY = %EDITC(SALARY:'4')
108800130315    ***
108900130315    *C                   EXCEPT    LIFF
109000130315    ***
109100130315    *C                   ENDSR
109200130315   S***S
109300101214     C     $PREP7        BEGSR
109400101214    ***
109500101214     C     KF@SSN        CHAIN     DEPENR
109600101214     C                   IF        NOT %FOUND(DEPNDC)
109700101214     C                   EVAL      @STEP = 'STEP2'
109800101214     C                   LEAVESR
109900101214     C                   ENDIF
110000101214    ***
110100101214     C     KF@SSN        SETLL     DEPENR
110200101214    ***
110300101214     C                   EVAL      @STEP = 'STEP7'
110400101214    ***
110500101214     C                   ENDSR
110600101210   S***S
110700101214     C     $STEP7        BEGSR
110800101214    ***
110900101214     C     KF@SSN        READE     DEPENR
111000101214    ***
111100101214     C                   IF        %EOF(DEPNDC)
111200101214     C                   EVAL      @STEP = 'STEP2'
111300101214     C                   LEAVESR
111400101214     C                   ENDIF
111500101214    ***
111600101214     C                   EVAL      KF@SEQ = DPSEQ#
111700120803     C                   EVAL      WRT@TYPE = 'DEPEND'
111800101214    ***
111900101214     C     KL#DCV        CHAIN     DCOVR
112000101214     C                   IF        NOT %FOUND(DCOVA)
112100101214     C                   LEAVESR
112200101214     C                   ENDIF
112300101214    ***
112400101214     C                   EXSR      $CLRDCV
112500101214     C     KL#DCV        SETLL     DCOVR
112600101214    ***
112700101214     C                   EVAL      @STEP = 'STEP8'
112800101214    ***
112900101214     C                   ENDSR
113000101214   S***S
113100101214     C     $STEP8        BEGSR
113200101214    ***
113300101214     C     KL#DCV        READE     DCOVR
113400101214    ***
113500101214     C                   IF        %EOF(DCOVA)
113600101214     C                   EVAL      @STEP = 'PREP9'
113700101214     C                   LEAVESR
113800101214     C                   ENDIF
113900101214    ***
114000130131    *C*                  IF        DENRDT = CCANDT
114100130131    *C*                  LEAVESR
114200130131    *C*                  ENDIF
114300110513    ***
114400110513     C                   EVAL      @PLANIN = DVPLAN
114500120803     C                   EVAL      KF@PLN = DVPLAN
114600160122     C     KL#TSAP       CHAIN     AEF06
114700160122     C                   IF        NOT %FOUND(AET006WF)
114800120803     C                   LEAVESR
114900120803     C                   ENDIF
115000110802    ***
115100110802     C                   EXSR      $QUIKD
115200110802    ***
115300110513     C                   EXSR      $PLANSRCH
115400110513    ***
115500110513     C                   IF        PLN@CAT = *BLANKS
115600110513     C                   LEAVESR
115700110513     C                   ENDIF
115800101214    ***
115900101214     C                   EVAL      #CANCEL = CCANDT
116000101214     C                   IF        #CANCEL = 0
116100101214     C                   EVAL      #CANCEL = 99999999
116200101214     C                   ENDIF
116300101214    ***
116400130315    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL; LIFE IS MEMBER ONLY
116500110513    ***
116600110513    *C                   IF        PLN@CAT = 'DEN'
116700130131    *C                   IF        D#CNE > 0
116800130131    *C                   IF        D@TRM(D#CNE) = 99999999
116900130131     C                   LEAVESR
117000130131     C                   ENDIF
117100130131     C                   ENDIF
117200110513    *C                   ADD       1             D#CNE
117300110513    *C                   EVAL      D@PLN(D#CNE) = DVPLAN
117400110513    *C                   EVAL      D@ENR(D#CNE) = *BLANKS
117500110513    *C                   EVAL      D@FRM(D#CNE) = DENRDT
117600110513    *C                   EVAL      D@TRM(D#CNE) = #CANCEL
117700110513    *C                   ELSE
117800130131    *C                   IF        M#CNE > 0
117900130131    *C                   IF        M@TRM(M#CNE) = 99999999
118000130131     C                   LEAVESR
118100130131     C                   ENDIF
118200130131     C                   ENDIF
118300101214     C                   ADD       1             M#CNE
118400101214     C                   EVAL      M@PLN(M#CNE) = DVPLAN
118500101214     C                   EVAL      M@ENR(M#CNE) = *BLANKS
118600101214     C                   EVAL      M@FRM(M#CNE) = DENRDT
118700101214     C                   EVAL      M@TRM(M#CNE) = #CANCEL
118800110513    *C                   ENDIF
118900101214    ***
119000101214     C                   ENDSR
119100101214   S***S
119200111011     C     $QUIKD        BEGSR
119300111011    ***
119400120803     C                   EXSR      $QUIK
119500120409    ***
119600120409     C                   ENDSR
119700111011   S***S
119800101214     C     $PREP9        BEGSR
119900101214    ***
120000101214     C                   IF        D#CNE = 0 AND M#CNE = 0
120100101214     C                   EVAL      @STEP = 'STEP7'
120200101214     C                   LEAVESR
120300101214     C                   ENDIF
120400101214    ***
120500130315     C                   EVAL      L#CNE = 0
120600130315     C                   EVAL      TERM_LIF = NO
120700101214     C                   EVAL      TERM_DEN = NO
120800101214     C                   EVAL      TERM_MED = NO
120900130520     C                   EVAL      @STEP = 'STEP9'
121000101214    ***
121100130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
121200130520     C                   IF        L@TRM(L#CNE) <> 99999999
121300130520     C                   EXSR      $CHKHEM
121400130520     C                   ENDIF
121500130520     C                   LEAVESR
121600130520     C                   ENDIF
121700130520    ***
121800130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
121900130520     C                   IF        M@TRM(M#CNE) <> 99999999
122000130520     C                   EXSR      $CHKHEM
122100130520     C                   ENDIF
122200130520     C                   LEAVESR
122300130520     C                   ENDIF
122400130520    ***
122500130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
122600130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
122700130520     C                              M@TRM(M#CNE) <> 99999999)
122800130520     C                   EXSR      $CHKHEM
122900130520     C                   ENDIF
123000130520     C                   LEAVESR
123100130520     C                   ENDIF
123200130520    ***
123300130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
123400130520     C                   IF        D@TRM(D#CNE) <> 99999999
123500130520     C                   EXSR      $CHKHEM
123600130520     C                   ENDIF
123700130520     C                   LEAVESR
123800130520     C                   ENDIF
123900130520    ***
124000130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
124100130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
124200130520     C                              D@TRM(D#CNE) <> 99999999)
124300130520     C                   EXSR      $CHKHEM
124400130520     C                   ENDIF
124500130520     C                   LEAVESR
124600130520     C                   ENDIF
124700130520    ***
124800130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
124900130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
125000130520     C                              M@TRM(M#CNE) <> 99999999)
125100130520     C                   EXSR      $CHKHEM
125200130520     C                   ENDIF
125300130520     C                   LEAVESR
125400130520     C                   ENDIF
125500130520    ***
125600130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
125700130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
125800130520     C                              L@TRM(L#CNE) <> 99999999 OR
125900130520     C                              M@TRM(M#CNE) <> 99999999)
126000130520     C                   EXSR      $CHKHEM
126100130520     C                   ENDIF
126200130520     C                   LEAVESR
126300130520     C                   ENDIF
126400101214    ***
126500101214     C                   ENDSR
126600101214   S***S
126700101210    *** GENERATE DEPENDENT RECORD
126800101210    ***
126900101214     C     $STEP9        BEGSR
127000101210    ***
127100110513     C                   EVAL      WRT@TYPE = 'DEPEND'
127200110513    ***
127300110513     C                   IF        D#CNE = 0 AND M#CNE = 0
127400110513     C                   EVAL      @STEP = 'STEP7'
127500110513     C                   LEAVESR
127600110513     C                   ENDIF
127700110513    ***
127800101214     C                   EVAL      @SS2   = %EDITC(DEPSS#:'X')
127900101210     C                   MOVEL(P)  DLNAME        @LN
128000101210     C                   MOVEL(P)  DFNAME        @FN
128100101210     C                   EVAL      @MI    = DMI
128200101210    ***
128300101210     C                   SELECT
128400101210     C                   WHEN      DRELCD = 'RWI'
128500101210     C                   EVAL      @REL   = '02'
128600101210     C                   WHEN      DRELCD = 'RHU'
128700101210     C                   EVAL      @REL   = '03'
128800101210     C                   WHEN      DRELCD = 'RSO'
128900101210     C                   EVAL      @REL   = '04'
129000101210     C                   WHEN      DRELCD = 'RDA'
129100101210     C                   EVAL      @REL   = '05'
129200130218     C                   WHEN      DRELCD = 'RPA'
129300130218     C                   EVAL      @REL   = '14'
129400130225     C                   OTHER
129500130225     C                   EVAL      @REL   = *BLANKS
129600101210     C                   ENDSL
129700101210    ***
129800101210     C                   SELECT
129900101210     C                   WHEN      DSTUDN = 'Y'
130000101210     C                   EVAL      @SPEC = '1'
130100140812     C                   WHEN      DHNDCP = '3'
130200101210     C                   EVAL      @SPEC = '3'
130300130225     C                   OTHER
130400130225     C                   EVAL      @SPEC = *BLANKS
130500101210     C                   ENDSL
130600101210    ***
130700101210     C                   EVAL      @SEX   = DSEX
130800101210     C                   EVAL      @DOB   = %EDITC(DBIRTH:'X')
130900130225    ***
131000101210     C                   IF        DCOB = 'Y'
131100101210     C                   EVAL      @COB   = 'Y'
131200101210     C                   EVAL      @COBC  = 'OT'
131300101210     C                   EVAL      @COBN  = DCOBPN
131400130225     C                   ELSE
131500130225     C                   EVAL      @COB   = *BLANKS
131600130225     C                   EVAL      @COBC  = *BLANKS
131700130225     C                   EVAL      @COBN = *BLANKS
131800101210     C                   ENDIF
131900101214    ***
132000101214     C                   IF        DADDR1 <> ADDR1
132100101210     C                   EVAL      @AD1   = %TRIM(DADDR1)
132200101210     C                   EVAL      @AD2   = %TRIM(DADDR2)
132300101210     C                   EVAL      @CTY   = %TRIM(DCITY)
132400101210     C                   EVAL      @ST    = DSTATE
132500101210     C                   MOVE      *BLANKS       @9                9
132600101214     C                   IF        DZIP = 0
132700101214     C                   EVAL      @9   = %EDITC(ZIP:'X')
132800101214     C                   ELSE
132900101210     C                   EVAL      @9   = %EDITC(DZIP:'X')
133000101214     C                   ENDIF
133100101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
133200101210     C                   EVAL      @PHN   = %EDITC(DAREA:'X') +
133300101210     C                                      %EDITC(DPHONE:'X')
133400101214     C                   ENDIF
133500141120    ***
133600101210     C                   EXCEPT    MBRF
133700101214     C                   ADD       1             C#RECCNT
133800101214    ***
133900101214     C                   EVAL      @STEP = 'PREPA'
134000101210    ***
134100101210     C                   ENDSR
134200101210   S***S
134300101214     C     $PREPA        BEGSR
134400101214    ***
134500101214     C                   IF        M#CNE = 0
134600101214     C                   EVAL      @STEP = 'PREPB'
134700101214     C                   LEAVESR
134800101214     C                   ENDIF
134900101214    ***
135000101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
135100160122     C     KL#TSAP       CHAIN     AEF06
135200160122     C                   IF        NOT %FOUND(AET006WF)
135300120803     C                   LEAVESR
135400120803     C                   ENDIF
135500101214    ***
135600101214     C                   IF        TERM_MED = YES
135700101214     C                   EXSR      $WRTERM
135800101214     C                   ENDIF
135900101214    ***
136000110513     C                   EVAL      @PLANIN = KF@PLN
136100110802    ***
136200110802     C                   EXSR      $QUIKD
136300110802    ***
136400110513     C                   EXSR      $PLANSRCH
136500110513    ***
136600110513     C                   IF        PLN@CAT = *BLANKS
136700110513     C                   SETON                                        H2
136800110513     C                   ENDIF
136900110513    ***
137000110513     C                   EVAL      @STEP = 'STEPA'
137100110513    ***
137200101214     C                   ENDSR
137300101214   S***S
137400101214     C     $STEPA        BEGSR
137500101214    ***
137600110513     C                   IF        CPCID1 = 'MEA'
137700110513     C                   EXSR      $MEAWRT
137800110513     C                   ELSE
137900110513     C                   EXSR      $HMOWRT
138000110513     C                   ENDIF
138100110513    ***
138200110513     C                   ADD       1             C#RECCNT
138300110513     C                   ADD       1             B#RECCNT
138400110513    ***
138500110513     C                   EVAL      @STEP = 'PREPB'
138600110513    ***
138700110513     C                   ENDSR
138800110513   S***S
138900101214     C     $PREPB        BEGSR
139000101214    ***
139100110513    *C                   IF        D#CNE = 0
139200110513    *C                   EVAL      @STEP = 'STEP7'
139300110513    *C                   LEAVESR
139400110513    *C                   ENDIF
139500101214    ***
139600110513    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
139700160122     C     KL#TSAP       CHAIN     AEF06
139800160122     C                   IF        NOT %FOUND(AET006WF)
139900120803     C                   LEAVESR
140000120803     C                   ENDIF
140100110513    ***
140200110513    *C                   IF        TERM_DEN = YES
140300110513    *C                   EXSR      $WRTERM
140400110513    *C                   ENDIF
140500110513    ***
140600110513     C                   EVAL      @PLANIN = KF@PLN
140700110513    ***
140800110802     C                   EXSR      $QUIKD
140900110513    ***
141000110513     C                   EXSR      $PLANSRCH
141100110513    ***
141200110513     C                   IF        PLN@CAT = *BLANKS
141300110513     C                   SETON                                        H2
141400110513     C                   ENDIF
141500110513    ***
141600101214     C                   EVAL      @STEP = 'STEPB'
141700101214    ***
141800101214     C                   ENDSR
141900101214   S***S
142000110513    *C     $STEPB        BEGSR
142100110513    ***
142200110513     C                   EXSR      $DENWRT
142300110513    ***
142400110513    *C                   ADD       1             C#RECCNT
142500110513    *C                   ADD       1             B#RECCNT
142600110513    ***
142700110513    *C                   EVAL      @STEP = 'STEP7'
142800110513    ***
142900110513    *C                   ENDSR
143000101210   S***S
143100110512     C     *INZSR        BEGSR
143200110512    ***
143300110512     C     KL#ACCTL      KLIST
143400120803     C                   KFLD                    KF@CCTL
143500110512     C                   KFLD                    KF@TRS
143600110512     C                   KFLD                    KF@SUB
143700110512     C                   KFLD                    KF@ACC
143800140313    ***
143900140313     C     KL#SQPCD      KLIST
144000140313     C                   KFLD                    KF@SSN
144100140313     C                   KFLD                    KF@SEQ
144200140313     C                   KFLD                    KF@SPCD
144300120803    ***
144400120803     C     KL#TSAP       KLIST
144500120803     C                   KFLD                    KF@TRS
144600120803     C                   KFLD                    KF@SUB
144700120803     C                   KFLD                    KF@ACC
144800120803     C                   KFLD                    KF@PLN
144900110512    ***
145000110512     C     KL#TSA        KLIST
145100110512     C                   KFLD                    KF@TRS
145200110512     C                   KFLD                    KF@SUB
145300110512     C                   KFLD                    KF@ACC
145400110512    ***
145500110512     C     KL#MPLN       KLIST
145600110512     C                   KFLD                    KF@SSN
145700110512     C                   KFLD                    KF@SEQ
145800110512     C                   KFLD                    KF@TRS
145900110512     C                   KFLD                    KF@SUB
146000110512     C                   KFLD                    KF@ACC
146100110512    ***
146200110512     C     KL#CPLN       KLIST
146300120803     C                   KFLD                    KF@CCTL
146400110512     C                   KFLD                    KF@TRS
146500110512     C                   KFLD                    KF@SUB
146600110512     C                   KFLD                    KF@ACC
146700110512     C                   KFLD                    KF@CCTR
146800110512     C                   KFLD                    KF@PLN
146900110512    ***
147000110512     C     KL#DCV        KLIST
147100110512     C                   KFLD                    KF@SSN
147200110512     C                   KFLD                    KF@SEQ
147300110512    ***
147400110512     C     KL#MTR        KLIST
147500110512     C                   KFLD                    KF@SSN
147600110512     C                   KFLD                    KF@SEQ
147700110512     C                   KFLD                    KF#TRM
147800110512     C                   KFLD                    KF@PLN
147900110512     C                   KFLD                    KF@ENR
148000110512     C                   KFLD                    KF@TRS
148100110512     C                   KFLD                    KF@SUB
148200110512     C                   KFLD                    KF@ACC
148300110512    ***
148400110512     C     KL#PCP        KLIST
148500110512     C                   KFLD                    KF@SSN
148600110512     C                   KFLD                    KF@SEQ
148700110512    ***
148800110512     C                   EVAL      #ISO = %DATE
148900110512     C                   MOVE      #ISO          #TODAY            8 0
149000110512     C                   EVAL      #IST = %TIME
149100110512     C                   MOVE      #ISO          #XSX
149200110512     C                   MOVE      #XSX          @DATE
149300110512     C                   MOVE      #IST          #XST
149400110512     C                   MOVE      #XST          @TIME
149500110512    ***
149600110512     C                   ENDSR
149700110512   S***S
149800110513    *** PLANS LOADED BY ACCOUNT
149900110513    ***
150000110513     C     $PLANLOAD     BEGSR
150100110513    ***
150200110513     C                   EVAL      PP# = 0
150300140313     C                   DO        80
150400110513     C                   ADD       1             PP#
150500110513     C     PP#           OCCUR     CARPLN@
150600110513     C                   CLEAR                   CARPLN@
150700110513     C                   ENDDO
150800110513     C                   EVAL      PC# = 0
150900110513     C                   EVAL      PP# = 0
151000110513    ***
151100110513     C     KL#ACCTL      SETLL     CARPLNR
151200110513     C                   DOU       %EOF(CARPLNP)
151300110513     C     KL#ACCTL      READE     CARPLNR
151400110520     C                   IF        NOT %EOF(CARPLNP)
151500110513    ***
151600110513     C                   ADD       1             PC#
151700110513     C     PC#           OCCUR     CARPLN@
151800110513     C                   EVAL      CARPLN@ = DS@CARPLN
151900110513    ***
152000110513     C                   ENDIF
152100110513     C                   ENDDO
152200110513    ***
152300110513     C                   ENDSR
152400110513   S***S
152500110513     C     $CLRSTG       BEGSR
152600110513    ***
152700110513     C                   EVAL      #CANCEL = 0
152800130315    ***
152900130315     C                   EVAL      L#CNE = 0
153000130315     C                   CLEAR                   L@PLN
153100130315     C                   CLEAR                   L@ENR
153200130315     C                   CLEAR                   L@FRM
153300130315     C                   CLEAR                   L@TRM
153400130315    ***
153500110513     C                   EVAL      D#CNE = 0
153600110513     C                   CLEAR                   D@PLN
153700110513     C                   CLEAR                   D@ENR
153800110513     C                   CLEAR                   D@FRM
153900110513     C                   CLEAR                   D@TRM
154000110513     C                   EVAL      M#CNE = 0
154100110513     C                   CLEAR                   M@PLN
154200110513     C                   CLEAR                   M@ENR
154300110513     C                   CLEAR                   M@FRM
154400110513     C                   CLEAR                   M@TRM
154500110513    ***
154600110513     C                   EXSR      $CLRDMG
154700110513    ***
154800110513     C                   ENDSR
154900110513   S***S
155000110513     C     $CLRDMG       BEGSR
155100110513    ***
155200110513     C                   EVAL      @SS1   = *BLANKS
155300110513     C                   EVAL      @SS2   = *BLANKS
155400110513     C                   MOVE      *BLANKS       @LN
155500110513     C                   MOVEL     *BLANKS       @FN
155600110513     C                   EVAL      @MI    = *BLANKS
155700110513     C                   EVAL      @REL   = *BLANKS
155800110513     C                   EVAL      @SEX   = *BLANKS
155900110513     C                   EVAL      @DOB   = *BLANKS
156000110513     C                   EVAL      @SPEC  = *BLANKS
156100110513     C                   EVAL      @COB   = *BLANKS
156200110513     C                   EVAL      @COBC  = *BLANKS
156300110513     C                   EVAL      @COBN  = *BLANKS
156400110513     C                   EVAL      @AD1   = *BLANKS
156500110513     C                   EVAL      @AD2   = *BLANKS
156600110513     C                   EVAL      @CTY   = *BLANKS
156700110513     C                   EVAL      @ST    = *BLANKS
156800110513     C                   EVAL      @ZP5   = *BLANKS
156900110513     C                   EVAL      @PHN   = *BLANKS
157000110513     C                   EVAL      @EMPST = *BLANKS
157100110513     C                   EVAL      @HIRE  = *BLANKS
157200110513    ***
157300110513     C                   ENDSR
157400110513   S***S
157500110513     C     $CHKHEM       BEGSR
157600110513    ***
157700130315    *C                   IF        L#CNE > 0 AND L@TRM(L#CNE) <> 99999999
157800130315    *C                   EXSR      $CHKLIF
157900130315    *C                   ENDIF
158000130315      *
158100110513    *C                   IF        D#CNE > 0 AND D@TRM(D#CNE) <> 99999999
158200110513    *C                   EXSR      $CHKDEN
158300110513    *C                   ENDIF
158400110513      *
158500110513     C                   IF        M#CNE > 0 AND M@TRM(M#CNE) <> 99999999
158600110513     C                   EXSR      $CHKMED
158700110513     C                   ENDIF
158800110513    ***
158900110513     C                   ENDSR
159000110513   S***S
159100130315    *C     $CHKLIF       BEGSR
159200130315    ***
159300130315    *C                   EVAL      TERM_LIF = YES
159400130315    *C                   EVAL      KF#TRM = L@TRM(L#CNE)
159500130315    *C                   EVAL      KF@PLN = L@PLN(L#CNE)
159600130315    *C                   EVAL      KF@ENR = L@ENR(L#CNE)
159700130315    ***
159800160122    *C     KL#MTR        CHAIN     AET841F
159900160122    *C                   IF        %FOUND(AET841WF)
160000130315    *C                   EVAL      L#CNE = 0
160100130315    *C                   EVAL      TERM_LIF = NO
160200130315    *C                   ENDIF
160300130315    ***
160400130315    *C                   ENDSR
160500130315   S***S
160600110513    *C     $CHKDEN       BEGSR
160700110513    ***
160800110513    *C                   EVAL      TERM_DEN = YES
160900110513    *C                   EVAL      KF#TRM = D@TRM(D#CNE)
161000110513    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
161100110513    *C                   EVAL      KF@ENR = D@ENR(D#CNE)
161200110513    ***
161300160122    *C     KL#MTR        CHAIN     AET841F
161400160122    *C                   IF        %FOUND(AET841WF)
161500110513    *C                   EVAL      D#CNE = 0
161600110513    *C                   EVAL      TERM_DEN = NO
161700110513    *C                   ENDIF
161800110513    ***
161900110513    *C                   ENDSR
162000110513   S***S
162100110513     C     $CHKMED       BEGSR
162200110513    ***
162300110513     C                   EVAL      TERM_MED = YES
162400110513     C                   EVAL      KF#TRM = M@TRM(M#CNE)
162500110513     C                   EVAL      KF@PLN = M@PLN(M#CNE)
162600110513     C                   EVAL      KF@ENR = M@ENR(M#CNE)
162700110513      *
162800160122     C     KL#MTR        CHAIN     AET841F
162900160122     C                   IF        %FOUND(AET841WF)
163000110513     C                   EVAL      TERM_MED = NO
163100110513     C                   EVAL      M#CNE = 0
163200110513     C                   ENDIF
163300110513    ***
163400110513     C                   ENDSR
163500110513   S***S
163600110513     C     $PLANSRCH     BEGSR
163700110513    ***
163800130315     C                   MOVE      *BLANKS       PLN@CAT           5
163900110513     C                   EVAL      PP# = 0
164000110513     C                   CLEAR                   DS@CARPLN
164100110513    ***
164200110513     C                   DO        PC#
164300110513    * *
164400110513     C                   ADD       1             PP#
164500110513     C     PP#           OCCUR     CARPLN@
164600110513    * *
164700110513     C                   IF        XPPLAN = @PLANIN AND
164800110513     C                             XPCCTR = @CCTRIN
164900110513     C                   EVAL      DS@CARPLN = CARPLN@
165000110513     C                   LEAVE
165100110513     C                   ENDIF
165200110513    * *
165300110513     C                   ENDDO
165400110513    ***
165500110513     C                   IF        CPPLAN = *BLANKS
165600110513     C                   LEAVESR
165700110513     C                   ENDIF
165800110513    ***
165900110513     C                   SELECT
166000110520     C                   WHEN      CPCID1 = 'MEA' OR
166100110520     C                             CPCID1 = 'HMO'
166200110520     C                   EVAL      PLN@CAT = 'MED'
166300130409     C                   WHEN      CPCID1 = 'LIFE'
166400130409     C                   EVAL      PLN@CAT = 'LIFE'
166500110520     C                   WHEN      CPCID1 = 'DEN'
166600110520     C                   EVAL      PLN@CAT = 'DEN'
166700110513     C                   ENDSL
166800110513    ***
166900110513     C                   ENDSR
167000110513   S***S
167100110513     C     $ENROLL       BEGSR
167200110513    ***
167300110513     C                   EVAL      ENR@OUT = *BLANKS
167400110513     C                   SELECT
167500110513     C                   WHEN      ENR@IN = 'TIN' OR ENR@IN = 'TMI'
167600110513     C                   EVAL      ENR@OUT = 'S'
167700110513     C                   WHEN      ENR@IN = 'THW'
167800110513     C                   EVAL      ENR@OUT = 'C'
167900110513     C                   WHEN      ENR@IN = 'TPC'
168000110513     C                   EVAL      ENR@OUT = 'P'
168100110513     C                   WHEN      ENR@IN = 'TP2'
168200110513     C                   EVAL      ENR@OUT = 'Q'
168300110513     C                   WHEN      ENR@IN = 'TFA'
168400110513     C                   EVAL      ENR@OUT = 'F'
168500110513     C                   ENDSL
168600110513    ***
168700110513     C                   ENDSR
168800110513   S***S
168900110513     C     $WRTERM       BEGSR
169000110513    ***
169100160122     C                   CLEAR                   AET841F
169200110513     C                   EVAL      NTSSNO         = KF@SSN
169300110513     C                   EVAL      NTDEPNO        = KF@SEQ
169400110513     C                   EVAL      NTTERMDT       = KF#TRM
169500110513     C                   EVAL      NTPLAN         = KF@PLN
169600110513     C                   EVAL      NTCOVTP        = KF@ENR
169700110513     C                   EVAL      NTTRST         = KF@TRS
169800110513     C                   EVAL      NTSUB#         = KF@SUB
169900110513     C                   EVAL      NTACCT         = KF@ACC
170000110513     C                   EVAL      NTTRANSDT      = #TODAY
170100160122     C                   WRITE     AET841F
170200110513    ***
170300110513     C                   ENDSR
170400110513   S***S
170500110513     C     $HMOWRT       BEGSR
170600110513    ***
170700110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
170800110513     C                   EVAL      X@ELR = CPCID2                               FILE NUMBER
170900110513     C                   EVAL      M@CC = CACID2                                COMPANY CODE
171000110513     C                   EVAL      M@CLASS = CPCID3                             CLASS CODE
171100110513     C                   EVAL      M@PLAN = CPCID4                              PLAN NUMBER
171200110513    ***
171300110513     C                   EVAL      #XSX = M@FRM(M#CNE)
171400110725     C                   IF        WRT@TYPE = 'DEPEND' AND
171500110725     C                             #XSX < M@MBREFF
171600110725     C                   MOVE      M@MBREFF      X@EFF
171700110725     C                   ELSE
171800110725     C                   MOVE      #XSX          X@EFF
171900110725     C                   ENDIF
172000110513    ***
172100110513     C                   EVAL      #XSX = M@TRM(M#CNE)
172200110513     C                   IF        #XSX = 0 OR #XSX = 99999999
172300110513     C                   MOVE      *BLANKS       X@TRM
172400110513     C                   ELSE
172500110513     C                   MOVE      #XSX          X@TRM
172600110513     C                   ENDIF
172700110513    ***
172800110513     C                   IF        WRT@TYPE = 'MEMBER'
172900110513     C                   EVAL      KF@SEQ = 0
173000110513     C                   EVAL      ENR@IN = M@ENR(M#CNE)
173100110513     C                   EXSR      $ENROLL
173200110513     C                   EVAL      X@TIER = ENR@OUT
173300110513     C                   ELSE
173400110513     C                   EVAL      X@TIER = *BLANKS
173500110513     C                   ENDIF
173600110513    ***
173700140313     C                   EVAL      KF@SPCD = 'MED'
173800140313     C                   EVAL      M@PCP = *BLANKS
173900140313     C                   EVAL      M@NPI = *BLANKS
174000140313     C                   EVAL      M@PCPCI = *BLANKS
174100140313    ***
174200140313     C                   EXSR      $PCP
174300140313    ***
174400140313     C                   IF        DOCTOR <> *BLANKS
174500140313     C                   EVAL      M@PCP = DOCTOR
174600140313     C                   EVAL      M@NPI = 'Y'
174700140313     C                   EVAL      M@PCPCI = '0'
174800140313     C                   ENDIF
174900110513    ***
175000110513     C                   EXCEPT    HMOF
175100110513    ***
175200110513     C                   ENDSR
175300110513   S***S
175400110513     C     $MEAWRT       BEGSR
175500110513    ***
175600110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
175700110513     C                   EVAL      X@ELR = CPCID2                               ELR
175800140313     C                   EVAL      E@SFX = CPCID3                               SUFFIX
175900140313     C                   EVAL      E@ACCT = CPCID4                              ACCOUNT
176000140313     C                   EVAL      E@PLAN = CPCID5                              PLAN
176100140313     C                   EVAL      E@CLM = CPCID6                               CLAIM OFFICE
176200110513    ***
176300110513     C                   EVAL      #XSX = M@FRM(M#CNE)
176400110725     C                   IF        WRT@TYPE = 'DEPEND' AND
176500110725     C                             #XSX < M@MBREFF
176600110725     C                   MOVE      M@MBREFF      X@EFF
176700110725     C                   ELSE
176800110725     C                   MOVE      #XSX          X@EFF
176900110725     C                   ENDIF
177000110513    ***
177100110513     C                   EVAL      #XSX = M@TRM(M#CNE)
177200110513     C                   IF        #XSX = 0 OR #XSX = 99999999
177300110513     C                   MOVE      *BLANKS       X@TRM
177400110513     C                   ELSE
177500110513     C                   MOVE      #XSX          X@TRM
177600110513     C                   ENDIF
177700110513    ***
177800140313     C                   MOVE      *BLANKS       E@CBREXP
177900140313     C                   MOVE      *BLANKS       E@CBREVT
178000140313     C                   MOVE      *BLANKS       E@CBRLEN
178100140313     C                   IF        WRT@TYPE = 'MEMBER'
178200140425     C                   IF        EMPST = 'C' AND
178300140425     C                             CEXPDT > 0
178400140313     C                   MOVE      CEXPDT        E@CBREXP
178500140313     C                   MOVE      QEDT          E@CBREVT
178600140313     C                   MOVE      CEXPDT        #MINUEND
178700140313     C                   MOVE      QEDT          #SUBTRAEND
178800140313     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
178900140313     C                   Z-ADD     #DIFFRNC      #2S0
179000140313     C                   MOVE      #2S0          E@CBRLEN
179100140313     C                   ENDIF
179200140313     C                   ENDIF
179300140313    ***
179400140313     C                   EVAL      *IN80 = *OFF
179500140313     C                   EVAL      KF@SPCD = 'MED'
179600140313     C                   EVAL      E@PCP = *BLANKS
179700140313     C                   EXSR      $PCP
179800140313     C                   IF        DOCTOR <> *BLANKS
179900140313     C                   EVAL      E@PCP = DOCTOR
180000140313     C                   EVAL      *IN80 = *ON
180100140313     C                   ENDIF
180200140313    ***
180300140313     C                   EXCEPT    MEAF
180400110513    ***
180500110513     C                   ENDSR
180600110513   S***S
180700140313     C     $PCP          BEGSR
180800140313    ***
180900140313     C                   MOVE      *BLANKS       DOCTOR            7
181000140313     C     KL#SQPCD      CHAIN     PCPR
181100140313     C                   IF        NOT %FOUND(PCPL1)
181200140313     C                   LEAVESR
181300140313     C                   ENDIF
181400140313     C     KL#SQPCD      SETLL     PCPR
181500140313     C                   DOU       %EOF(PCPL1)
181600140313     C     KL#SQPCD      READE     PCPR
181700140313     C                   IF        NOT %EOF(PCPL1) AND PCCAN = 0
181800140313     C                   MOVEL(P)  PCID#         DOCTOR
181900140313     C                   LEAVESR
182000140313     C                   ENDIF
182100140313     C                   ENDDO
182200140313    ***
182300140313     C                   ENDSR
182400140313   S***S
182500110513     C     $CLRDCV       BEGSR
182600110513    ***
182700110513     C                   MOVE      *BLANKS       @LN
182800110513     C                   MOVEL     *BLANKS       @FN
182900110513     C                   EVAL      @SS2   = *BLANKS
183000110513     C                   EVAL      @MI    = *BLANKS
183100110513     C                   EVAL      @REL   = *BLANKS
183200110513     C                   EVAL      @SEX   = *BLANKS
183300110513     C                   EVAL      @DOB   = *BLANKS
183400110513     C                   EVAL      @SPEC  = *BLANKS
183500110513     C                   EVAL      @COB   = *BLANKS
183600110513     C                   EVAL      @COBC  = *BLANKS
183700110513     C                   EVAL      @COBN  = *BLANKS
183800110513    ***
183900110513     C                   EVAL      #CANCEL = 0
184000110513     C                   EVAL      D#CNE = 0
184100110513     C                   CLEAR                   D@PLN
184200110513     C                   CLEAR                   D@ENR
184300110513     C                   CLEAR                   D@FRM
184400110513     C                   CLEAR                   D@TRM
184500110513     C                   EVAL      M#CNE = 0
184600110513     C                   CLEAR                   M@PLN
184700110513     C                   CLEAR                   M@ENR
184800110513     C                   CLEAR                   M@FRM
184900110513     C                   CLEAR                   M@TRM
185000110513    ***
185100110513     C                   ENDSR
185200110513   S***S
185300110513     C     $DENWRT       BEGSR
185400110513    ***
185500110513    *C                   EVAL      X@LAY = CPCID1                               LAYOUT
185600110513    *C                   EVAL      X@ELR = CPCID2                               ELR
185700110513    *C                   EVAL      D@SFX = CPCID3                               SUFFIX
185800110513    *C                   EVAL      D@ACCT = CPCID4                              ACCOUNT
185900110513    *C                   EVAL      D@PLAN = CPCID5                              PLAN
186000110513    *C                   EVAL      D@CLM = CPCID6                               CLAIM OFFICE
186100110524     C                   EVAL      DNTLATE = '0'
186200110513    ***
186300110513    *C                   EVAL      #XSX = D@FRM(D#CNE)
186400110725     C                   IF        WRT@TYPE = 'DEPEND' AND
186500110725     C                             #XSX < D@MBREFF
186600110725     C                   MOVE      D@MBREFF      X@EFF
186700110725     C                   ELSE
186800110725     C                   MOVE      #XSX          X@EFF
186900110725     C                   ENDIF
187000110513    ***
187100110513    *C                   EVAL      #XSX = D@TRM(D#CNE)
187200110513    *C                   IF        #XSX = 0 OR #XSX = 99999999
187300110513    *C                   MOVE      *BLANKS       X@TRM
187400110513    *C                   ELSE
187500110513    *C                   MOVE      #XSX          X@TRM
187600110513    *C                   ENDIF
187700110513    ***
187800130211     C                   MOVE      *BLANKS       D@CBREXP
187900130211     C                   MOVE      *BLANKS       D@CBREVT
188000130211     C                   MOVE      *BLANKS       D@CBRLEN
188100110513     C                   IF        WRT@TYPE = 'MEMBER'
188200111123    *C                   IF        EMPST = 'C' AND CEXPDT <> 0
188300110513    *C                   MOVE      CEXPDT        D@CBREXP
188400110513    *C                   MOVE      QEDT          D@CBREVT
188500110513    *C                   MOVE      CEXPDT        #MINUEND
188600110513    *C                   MOVE      QEDT          #SUBTRAEND
188700110513    *C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
188800110513    *C                   Z-ADD     #DIFFRNC      #2S0
188900110513    *C                   MOVE      #2S0          D@CBRLEN
189000110513    *C                   ENDIF
189100110513    *C                   ENDIF
189200120806    ***
189300110513    *C                   MOVE      '0'           D@OOAI
189400140313    ***
189500140313     C                   EVAL      KF@SPCD = 'DEN'
189600140313     C                   EVAL      D@PCD = *BLANKS
189700140313     C                   EVAL      *IN81 = *OFF
189800140313     C                   MOVE      *BLANKS       DOCTOR
189900140313    ***
190000140313     C                   EXSR      $PCP
190100140313    ***
190200140313     C                   IF        DOCTOR <> *BLANKS
190300140313     C                   EVAL      D@PCD = DOCTOR
190400140313     C                   EVAL      *IN81 = *ON
190500140313     C                   ENDIF
190600110513    ***
190700120123     C     *LIKE         DEFINE    H@C#          BUC#
190800120123     C                   EVAL      BUC# = H@C#
190900120123    ***
191000120327     C                   SELECT
191100131126     C                   WHEN      KF@TRS = 591 AND KF@SUB = 009 AND            WILMOT MODULAR
191200131126     C                             KF@ACC = 0202                                 STRUCTURES
191300131227     C                   EVAL      H@C# = '0638156'
191400140702     C                   WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            REDLAND
191500140702     C                             KF@ACC = 0475                                 BAPTISTS
191600140702     C                   EVAL      H@C# = '0725572'
191700120327     C                   WHEN      KF@TRS = 825 AND KF@SUB = 001 AND            CREATIVE
191800120123     C                             KF@ACC = 0014                                 LOGISTICS
191900120123     C                   EVAL      H@C# = '0133860'
192000130905     C                   WHEN      KF@TRS = 905 AND KF@SUB = 001 AND            CCL USA
192100130905     C                             KF@ACC = 0092
192200130905     C                   EVAL      H@C# = '0638423'
192300140423     C                   WHEN      KF@TRS = 003 AND KF@SUB = 001 AND            FRAME RITE
192400140423     C                             KF@ACC = 0104
192500140423     C                   EVAL      H@C# = '0306511'
192600130520     C                   WHEN      KF@TRS = 900 AND KF@SUB = 003 AND            PERFECT
192700130520     C                             KF@ACC = 0045                                 SETTINGS
192800130520     C                   EVAL      H@C# = '0474109'
192900121024     C                   WHEN      KF@TRS = 591 AND KF@SUB = 011 AND            MCCALLISTER
193000121024     C                             KF@ACC = 0446                                 ARCHITECT
193100121024     C                   EVAL      H@C# = '0565330'
193200130716     C                   WHEN      KF@TRS = 591 AND KF@SUB = 005 AND            JD CLARK PROF
193300130716     C                             KF@ACC = 0451                                 SERVICES
193400130716     C                   EVAL      H@C# = '0519890'
193500130627     C                   WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            DYSON CONSTRUCTION
193600130627     C                             KF@ACC = 0459                                 COMPANY
193700130627     C                   EVAL      H@C# = '0788122'
193800130903     C                   WHEN      KF@TRS = 591 AND KF@SUB = 004 AND            STROUSE CORP
193900130903     C                             KF@ACC = 0482
194000130903     C                   EVAL      H@C# = '0837451'
194100130712     C                   WHEN      KF@TRS = 900 AND KF@SUB = 007 AND            CAPLAN BROTHERS
194200130712     C                             KF@ACC = 0075
194300130712     C                   EVAL      H@C# = '0837533'
194400120806     C                   WHEN      KF@TRS = 900 AND KF@SUB = 101 AND            INTEGRA HEALTH
194500130110     C                             KF@ACC = 0042 AND
194600130110     C                             (STATE = 'TN' OR STATE = 'FL' OR
194700130718     C                              STATE = 'OH' OR STATE = 'MA') AND
194800120806     C                             (@PLANIN = 'DAAD' OR @PLANIN = 'BAAD')
194900120806     C                   EVAL      H@C# = '0503428'
195000120327    *C                   ENDSL
195100120123    ***
195200110513    *C                   EXCEPT    DENF
195300151217     c                   EVAL      H@C# = BUC#
195400110513    ***
195500110513    *C                   ENDSR
195600110513   S***S
195700110512   X***X
195800160122     OAET840WF  EADD         HDRF
195900101203     O                                            6 'HEADER'
196000101229     O                                            8 'P'
196100101206     O                       H@SI                28
196200101203     O                                           29 '0'
196300101203     O                       C1                  43
196400101203     O                       D1                  51
196500101203     O                       T1                  57
196600101206     O                                          131 'CONSOLIDATED ELIGIBILITY'
196700110502     O                       H@RI               167
196800101206     O                       H@CC               169
196900101228     O                       H@GN               176
197000101206     O                       H@CN               191
197100101206     O                       H@C#               198
197200101203     O                       D2                 206
197300110825     O                                          216 'MC'
197400101223     O                                          231 '*'
197500160122     OAET840WF  EADD         MBRF
197600101203     O                                            6 'MEMBER'
197700101203     O                       @SS1                16
197800101203     O                       @SS2                25
197900101203     O                       @FN                 75
198000101203     O                       @MI                 76
198100101203     O                       @LN                 96
198200101203     O                       @REL               101
198300101203     O                       @SEX               103
198400101203     O                       @DOB               111
198500101203     O                       @SPEC              112
198600101203     O                                          113 '0'
198700101203     O                       @COB               123
198800101203     O                       @COBC              125
198900101203     O                       @COBN              145
199000101203     O                       @AD1               175
199100101203     O                       @AD2               205
199200101203     O                       @CTY               315
199300101203     O                       @ST                317
199400101203     O                       @ZP5               322
199500101203     O                       @PHN               349
199600141211     O               87                         576 '21207'
199700140626     O               88                         576 '21740'
199800141120     O               89                         576 '20171'
199900101203     O                       @EMPST             665
200000101203     O                       @HIRE              673
200100101223     O                                         1231 '*'
200200160122     OAET840WF  EADD         HMOF
200300101213     O                                            7 'BENEFIT'
200400101213     O                       X@LAY               10
200500101214     O                       X@ELR               24
200600101213     O                       M@CC                26
200700101213     O                       H@GN                38
200800101213     O                       M@CLASS             44
200900101213     O                       M@PLAN              50
201000101213     O                       X@EFF               58
201100110929     O                       X@TRM               66
201200101213     O                       X@TIER              69
201300101213     O                       M@PCP              160
201400101213     O                       M@NPI              161
201500101213     O                       M@PCPCI            186
201600101223     O                                          323 '*'
201700160122     OAET840WF  EADD         MEAF
201800140313     O                                            7 'BENEFIT'
201900140313     O                                           10 'MEA'
202000140313     O                       X@ELR               24
202100140313     O                       H@C#                31
202200140313     O                       E@SFX               34
202300140313     O                       E@ACCT              44
202400140313     O                       E@PLAN              50
202500140313     O                       X@EFF               58
202600140313     O                       X@TRM               66
202700140313     O                       E@CLM               71
202800140313     *** PCP BGN
202900140313     O                       E@PCP              127
203000140313     O               80                         161 'N'
203100140313     O               80                         186 '0'
203200140313     *** PCP END
203300140313     O                                          389 '0'
203400140313     *** COBRA BGN
203500140313     O                       E@CBREXP           466
203600140313     O                       E@CBREVT           516
203700140313     O                       E@CBRLEN           560
203800140313     *** COBRA END
203900140313     O                                          678 '*'
204000140313    ***
204100160122     OAET840WF  EADD         DENF
204200101213     O                                            7 'BENEFIT'
204300101213     O                       X@LAY               10
204400101214     O                       X@ELR               24
204500101214     O                       H@C#                31
204600101213     O                       D@SFX               34
204700101213     O                       D@ACCT              44
204800101213     O                       D@PLAN              50
204900101213     O                       X@EFF               58
205000110929     O                       X@TRM               66
205100101213     O                       D@CLM               71
205200140313     *** PCD BGN
205300140313     O                       D@PCD              200
205400140313     O               81                         236 '0'
205500140313     *** PCD END
205600140313     O                                          389 '0'
205700140313     *** COBRA BGN
205800140313     O                       D@CBREXP           466
205900140313     O                       D@CBREVT           516
206000140313     O                       D@CBRLEN           560
206100140313     *** COBRA END
206200140313     O                       D@OOAI             609
206300140313     O                                          678 '*'
206400140313    ***
206500160122     OAET840WF  EADD         LIFF
206600130315     O                                            7 'BENEFIT'
206700130412     O                                           11 'LIFE'
206800130315     O                       X@ELR               24
206900130319     O                       H@C#3               31
207000130315     O                       L@SFX               34
207100130315     O                       L@ACCT              44
207200130315     O                       L@PLAN              50
207300130315     O                       X@EFF               58
207400130315     O                       X@TRM               66
207500130315     O                       L@CLM               71
207600130315     O                       L@CBREXP           466
207700130315     O                       L@CBREVT           516
207800130315     O                       L@CBRLEN           560
207900130315     O                       L@SALARY           658
208000130315     O                                          659 '1'
208100130315     O                                          678 '*'
208200160122     OAET840WF  EADD         TRLF
208300101203     O                                            7 'TRAILER'
208400101203     O                       @TREC               17
208500101203     O                       D1                  25
208600101203     O                       T1                  31
208700101203     O                       @BREC               41
208800101223     O                                           69 '*'
