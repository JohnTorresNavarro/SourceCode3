000100160224      *=============================================================================================
000200160224     H option(*noDebugIo)
000300160224      *=============================================================================================
000400110802   X***X CARRIER CONTROL ID #0000000011 AETNA SPECIFIC
000500120803   X***X CARRIER CONTROL ID #0000000051 AETNA SPECIFIC
000600110513   X***X SSK 05.13.2011 TEMPLATE DESIGN
000700110513   X***X
000800110802   X***X 08.02.2011 CLONED FROM AET0X0R
000900110818   X***X 08.18.2011 AETNA APPROVED FOR PRODUCTION
001000110914   X***X 09.14.2011 ADDED ANOTHER SET OF SMALL GROUPS
001100120125   X***X 01.25.2012 CHANGE OF PLAN NUMBERS FOR IT OBJECTS
001200120803   X***X 08.03.2012 CHANGE TO METHOD FILE
001300121024   X***X 10.24.2012 MCCALLISTER ARCHITECTS, DENTAL ONLY SEPARATE # ADDED
001400130123   X***X 01.23.2013 ADDED METHOD 13 BASED ON BELFAST REQUIREMENT
001500120806   X***X
001600120806   X***X
001700120806   X***X CREATIVE LOGISTICS AND INTEGRA ARE SPECIALIZED GROUP # IN THE DENTAL SECTION
001800120806   X***X  AT THE BOTTOM OF THE PROGRAM.
001900101206   X***X
002000130315   X***X 03.15.2013 ADD LIFE PRODUCTS
002100130520   X***X 05.20.2013 MOVED TO PRODUCTION
002200120806   X***X
002300130627   X***X 06.27.2013 DYSON DENTAL
002400130712   X***X 07.12.2013 CAPLAN BROTHERS DENTAL
002500131126   X***X 11.26.2013 WILMOT MODULAR STRUCTURES, INC
002600101206   X***X
002700110725   X***X **INCLUDES SONDA MODIFICATION ON 7/25/2011 FOR DEP EFF DATE
002800101206   X***X
002900140313   X***X **NOW INCLUDES PCP INFORMATION
003000101206   X***X
003100151015   X* *  10.15.2015 Per Brandon Scarfield-905,001,0092 harcode effective and control #
003200151015   X* *             when dental.
003300170317
003400170317      *  11/08/2016  JT  Per Brandon Scarfield... eliminate future Cobra records and send as
003500170317      *                  AC (active) records
003600170317
003700170317      *  03/17/2017  JT  Per Brandon Scarfield... reinstated Cobra records.
003800170317
003900170317      *=================================================================================
004000170317
004100130315     F*CARXPTP   IF   E           K DISK
004200101012     FCARACCP   IF   E           K DISK
004300160829
004400101012     FCARPLNP   IF   E           K DISK
004500160829
004600160829     FAET004WF  IF   E           K DISK
004700120803     ** MAPPING METHOD
004800160829
004900160914     FAET1050WFVO  A F 1231        DISK
005000101206     ** FLAT FILE
005100160829
005200170526     FAET1051WF2IF A E           K DISK
005300101028     ** TERM TRACKER
005400160829
005500160914     FMEMAC#1   IF   E           K DISK    ExtFile('QS36F/F.MEMAC#1')
005600160829
005700101012     FMCOVMPLN  IF   E           K DISK
005800160829
005900160914     FDEPNDC    IF   E           K DISK    ExtFile('QS36F/F.DEPNDC')
006000160829
006100160914     FDCOVA     IF   E           K DISK    ExtFile('QS36F/DCOVA')
006200160829
006300160914     FPCPL1     IF   E           K DISK    ExtFile('QS36F/F.PCPL1')
006400160829
006500160829      *=================================================================================
006600160829
006700120803     D KF@CCTL         S             10A   INZ
006800160829     D grouper         S             10A
006900160831     D p_trst          S              3  0
007000160831     D p_sub#          S              3  0
007100160831     D p_acct          S              4  0
007200160829
007300160829     D CARR#CTL        S             10A
007400160829
007500110512     D H@RI            S             25A   INZ('042064683')                     RECEIVER ID
007600160829
007700110512     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
007800101026     D DS@CARACC     E DS                  EXTNAME(CARACCP)
007900130315     D*DS@CARXPT     E DS                  EXTNAME(CARXPTP)
008000101026   X***X
008100110512     ** WORK ARRAY FOR PLANS
008200110512     **
008300110512     ** PC# - PLAN COUNT
008400110512     ** PP# - PLAN POINTER
008500110512     **
008600110512     D CARPLN@       E DS                  EXTNAME(CARPLNP)
008700160902     D                                     OCCURS(900) PREFIX(X:1)
008800110512     D PC#             S              3S 0
008900110512     D PP#             S              3S 0
009000110512     D @PLANIN         S              4A
009100110512     D @CCTRIN         S              3A
009200110513   X***X
009300110513     **
009400110513     ** WRITE TYPE = MEMBER OR DEPEND
009500110513     D WRT@TYPE        S              6A
009600110513     **
009700110512   X***X
009800101214     D #XST            S              6S 0
009900101214     D #IST            S               T
010000101026     D #ISO            S               D   DATFMT(*ISO)
010100101214     D #MINUEND        S               D   DATFMT(*ISO)
010200101214     D #SUBTRAEND      S               D   DATFMT(*ISO)
010300101214     D @DATE           S              8A
010400101214     D @TIME           S              6A
010500101214     D #DIFFRNC        S              5S 0
010600101214     D #2S0            S              2S 0
010700101214     D #CANCEL         S              8S 0
010800101026     D #XSX            S              8S 0
010900101026     D #XSX2           S              8S 0
011000101026     D DATE@OUT        S             10A
011100101026     D ENR@IN          S              3A
011200101026     D ENR@OUT         S              1A
011300110524     D DNTLATE         S              1A
011400130315     D TERM_LIF        S               N
011500101214     D TERM_DEN        S               N
011600101214     D TERM_MED        S               N
011700101026     D YES             S               N   INZ(*ON)
011800101026     D NO              S               N   INZ(*OFF)
011900160829     D firstTime       S              1    INZ('Y')
012000160829
012100110512     D KF@TRS          S                   LIKE(MCTRST)
012200110512     D KF@SUB          S                   LIKE(MCSUB#)
012300110512     D KF@ACC          S                   LIKE(ACC#)
012400101026     D KF@ENR          S              3A   INZ
012500101026     D KF@CARG         S              2A   INZ
012600101026     D KF@CCTR         S                   LIKE(CCFLG)
012700101026     D KF@PLN          S                   LIKE(MCPLAN)
012800101026     D KF@TRM          S                   LIKE(NTTERMDT)
012900101026     D KF#TRM          S              8S 0
013000101026     D KF@SSN          S                   LIKE(MBSSNO)
013100101026     D KF@SEQ          S                   LIKE(DPSEQ#)
013200101026     D KF@TYP          S              1A
013300101026     D KF@CDE          S              2A
013400140313     D KF@SPCD         S              5A
013500140313     D KF@MPLN         S              4A
013600140313     **
013700101026     D M@EARLYP        S              4A
013800101026     D M#EARLYE        S              8S 0 INZ
013900101026     D M#EARLYT        S              8S 0 INZ
014000140313     **
014100101026     D #8D1            S              8S 0 INZ
014200101214     D D1              S              8A
014300101214     D D2              S              8A
014400101214     D T1              S              6A
014500101214     D C1              S             14A
014600101206    ***
014700101029     D B#RECCNT        S             10S 0 INZ
014800101029     D C#RECCNT        S             10S 0 INZ
014900101206    ***
015000101210     D @SS1            S              9A
015100101210     D @SS2            S              9A
015200101210     D @FN             S             15A
015300101210     D @MI             S              1A
015400101210     D @LN             S             20A
015500101210     D @REL            S              2A
015600101210     D @SEX            S              1A
015700101210     D @DOB            S              8A
015800101210     D @SPEC           S              1A
015900101210     D @COB            S              1A
016000101210     D @COBC           S              2A
016100101210     D @COBN           S             20A
016200101210     D @AD1            S             30A
016300101210     D @AD2            S             30A
016400101214     D @CTY            S             20A
016500101210     D @ST             S              2A
016600101210     D @ZP5            S              5A
016700101210     D @PHN            S             10A
016800101210     D @EMPST          S              2A
016900101210     D @HIRE           S              8A
017000101206    ***
017100130315    *** LIFE ARRAYS
017200130315     D L#CNE           S              3S 0 INZ
017300130315     D L#NDX           S              3S 0 INZ
017400130315     D L@PLN           S              4A   DIM(20)
017500130315     D L@ENR           S              3A   DIM(20)
017600130315     D L@FRM           S              8S 0 DIM(20)
017700130315     D L@TRM           S              8S 0 DIM(20)
017800130315     D L@MBREFF        S              8S 0
017900140313    ***
018000101206    *** DENTAL ARRAYS
018100101206     D D#CNE           S              3S 0 INZ
018200101206     D D#NDX           S              3S 0 INZ
018300101206     D D@PLN           S              4A   DIM(20)
018400101206     D D@ENR           S              3A   DIM(20)
018500101206     D D@FRM           S              8S 0 DIM(20)
018600101206     D D@TRM           S              8S 0 DIM(20)
018700110725     D D@MBREFF        S              8S 0
018800140313    ***
018900101206    *** MEDICAL ARRAYS
019000101206     D M#CNE           S              3S 0 INZ
019100101206     D M#NDX           S              3S 0 INZ
019200101206     D M@PLN           S              4A   DIM(20)
019300101206     D M@ENR           S              3A   DIM(20)
019400101206     D M@FRM           S              8S 0 DIM(20)
019500101206     D M@TRM           S              8S 0 DIM(20)
019600110725     D M@MBREFF        S              8S 0
019700101206    ***
019800101206     D H@SI            S             20A
019900101206     D H@CC            S              2A
020000101206     D H@GN            S              7A
020100101206     D H@CN            S             15A
020200101206     D H@C#            S              7A
020300130319     D H@C#3           S              7A
020400140313    ***
020500101213     D X@LAY           S              3A
020600101213     D X@ELR           S              7A
020700140313     D X@EFF           S              8A
020800140313     D X@TRM           S              8A
020900140313     D X@TIER          S              1A
021000140313    ***
021100101213     D M@CC            S              2A
021200101213     D M@CLASS         S              5A
021300101213     D M@PLAN          S              6A
021400101213     D M@PCP           S             40A
021500101213     D M@NPI           S              1A
021600101213     D M@PCPCI         S              1A
021700140313    ***
021800101213     D D@SFX           S              3A
021900101213     D D@ACCT          S              5A
022000101213     D D@PLAN          S              6A
022100101213     D D@CLM           S              3A
022200101213     D D@CBREXP        S              8A
022300101213     D D@CBREVT        S              8A
022400101213     D D@CBRLEN        S              2A
022500101213     D D@OOAI          S              1A
022600140313     D D@PCD           S              7A
022700140313    ***
022800101214     D @STEP           S              5A
022900140313    ***
023000140313     D E@SFX           S              3A
023100140313     D E@ACCT          S              5A
023200140313     D E@PLAN          S              6A
023300140313     D E@CLM           S              3A
023400140313     D E@PCP           S              7A
023500140313     D E@CBREXP        S              8A
023600140313     D E@CBREVT        S              8A
023700140313     D E@CBRLEN        S              2A
023800140313    ***
023900130315     D L@SFX           S              3A
024000130315     D L@ACCT          S              5A
024100130315     D L@PLAN          S              6A
024200130315     D L@CLM           S              3A
024300130315     D L@CBREXP        S              8A
024400130315     D L@CBREVT        S              8A
024500130315     D L@CBRLEN        S              2A
024600130315     D L@SALARY        S             20A
024700140313    ***
024800160809    ***
024900160809     d num_date        s              8s 0 inz
025000160809     D work_date       s               d
025100160829
025200161130     D effectiveDate   s              8    INZ('20161201')
025300161130     D effectiveDateD  s              8  0 INZ(20161201)
025400161130
025500160829      *=================================================================================
025600160829
025700110512     C                   EVAL      @STEP = 'PREP1'
025800101214    ***
025900120803     C                   EVAL      KF@CCTL = CARR#CTL
026000160829     C**** KF@CCTL       CHAIN     CARXPTR
026100160914     C****               EXSR      $HEADR
026200110512    ***
026300160831     C     KL#ACCTL      SETLL     CARACCR
026400160831     C**** KF@CCTL       SETLL     CARACCR
026500110512    ***
026600101026     C                   DOU       @STEP = 'LEAVE'
026700101026     C     @STEP         CASEQ     'PREP1'       $PREP1
026800101026     C     @STEP         CASEQ     'STEP1'       $STEP1
026900101026     C     @STEP         CASEQ     'STEP2'       $STEP2
027000101026     C     @STEP         CASEQ     'STEP3'       $STEP3
027100101026     C     @STEP         CASEQ     'PREP4'       $PREP4
027200101026     C     @STEP         CASEQ     'STEP4'       $STEP4
027300101026     C     @STEP         CASEQ     'PREP5'       $PREP5
027400101026     C     @STEP         CASEQ     'STEP5'       $STEP5
027500101214     C     @STEP         CASEQ     'PREP6'       $PREP6
027600101026     C     @STEP         CASEQ     'STEP6'       $STEP6
027700101214     C     @STEP         CASEQ     'PREP7'       $PREP7
027800101214     C     @STEP         CASEQ     'STEP7'       $STEP7
027900101214     C     @STEP         CASEQ     'STEP8'       $STEP8
028000101214     C     @STEP         CASEQ     'PREP9'       $PREP9
028100101214     C     @STEP         CASEQ     'STEP9'       $STEP9
028200101214     C     @STEP         CASEQ     'PREPA'       $PREPA
028300101214     C     @STEP         CASEQ     'STEPA'       $STEPA
028400101214     C     @STEP         CASEQ     'PREPB'       $PREPB
028500101214     C     @STEP         CASEQ     'STEPB'       $STEPB
028600130315     C     @STEP         CASEQ     'PREPC'       $PREPC
028700130315     C     @STEP         CASEQ     'STEPC'       $STEPC
028800101026     C                   ENDCS
028900101026     C                   ENDDO
029000120711    ***
029100120711    ***  CALL SECOND PROGRAM
029200120711    ***
029300120803    *C*                  MOVE      *ALL'0'       @TADD            10
029400120803    *C*                  MOVE      *ALL'0'       @BADD            10
029500120803    *C*                  CALL      'AET081CL'
029600120803    *C*                  PARM                    @TADD
029700120803    *C*                  PARM                    @BADD
029800120803    *C*                  MOVE      @TADD         #TADD            10 0
029900120803    *C*                  ADD       #TADD         C#RECCNT
030000120803    *C*                  MOVE      @BADD         #BADD            10 0
030100120803    *C*                  ADD       #BADD         B#RECCNT
030200120711    ***
030300101206    ***  TRAILER RECORD
030400120711    ***
030500160914     C****               ADD       2             C#RECCNT
030600160914     C****               MOVE      C#RECCNT      @TREC            10 0
030700160914     C****               MOVE      B#RECCNT      @BREC            10 0
030800160914     C****               EXCEPT    TRLF
030900101026    ***
031000101026     C                   EVAL      *INLR = *ON
031100110512   S***S
031200110802     C     $HEADR        BEGSR
031300101206    ***
031400110802     C                   EVAL      D1 = @DATE
031500110802     C                   EVAL      D2 = @DATE
031600110802     C                   EVAL      T1 = @TIME
031700110802     C                   EVAL      C1 = @DATE + @TIME
031800110802    ***
031900160914     C****               EVAL      KF@TRS = 999
032000160914     C****               EVAL      KF@SUB = 999
032100160914     C****               EVAL      KF@ACC = 9999
032200110802     C     KL#ACCTL      CHAIN     CARACCR
032300110802    ***
032400110802     C                   EVAL      H@SI = %TRIM(CACID1)                         SUBMITTER ID
032500110802     C                   EVAL      H@CC = %SUBST(CACID2:1:2)                    COMPANY CODE
032600110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
032700110802     C                   MOVEL(P)  CACID4        H@CN                           CUSTOMER NAME
032800110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
032900130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
033000110802    ***
033100170526     C****               EXCEPT    HDRF
033200110802    ***
033300110802     C                   ENDSR
033400110802   S***S
033500110802     C     $PREP1        BEGSR
033600110802    ***
033700160831     C     KL#ACCTL      READE     CARACCR
033800160831     C**** KF@CCTL       READE     CARACCR
033900110512    ***
034000110512     C                   IF        %EOF(CARACCP)
034100120803      *
034200120815     C*                  IF        KF@CCTL = CARR#CTL
034300120815     C*                  EVAL      KF@CCTL = CARR#CTL2
034400120815     C*    KF@CCTL       SETLL     CARACCR
034500120815     C*                  ELSE
034600110512     C                   EVAL      @STEP = 'LEAVE'
034700120815     C*                  ENDIF
034800120803      *
034900110512     C                   LEAVESR
035000110512     C                   ENDIF
035100110512    ***
035200110513    *** HAS THE ACCOUNT BEEN SHUTOFF FOR EXPORT?
035300110513    ***
035400110512     C                   IF        CASTATUS <> 'Y'
035500110512     C                   LEAVESR
035600110512     C                   ENDIF
035700110512    ***
035800160829     C                   if        cacida <> grouper
035900160829     C                   leavesr
036000160829     C                   endif
036100160829
036200110802    *** THESE FIELDS RESET FOR EACH SMALL GROUP READ
036300110802    ***
036400110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
036500110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
036600130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
036700110802    ***
036800110512     C                   EVAL      KF@TRS = CATRST
036900110512     C                   EVAL      KF@SUB = CASUB#
037000110512     C                   EVAL      KF@ACC = CAACCT
037100110512    ***
037200110512     C                   EXSR      $PLANLOAD
037300110512    ***
037400101206     C                   EVAL      @STEP = 'STEP1'
037500110512    ***
037600110512     C                   ENDSR
037700110512   S***S
037800101206     C     $STEP1        BEGSR
037900101206    ***
038000101206     C                   EVAL      KF@PLN = *BLANKS
038100101206     C                   EVAL      KF@TRM = 0
038200101206     C                   EVAL      KF@SSN = 0
038300101206     C                   EVAL      KF@SEQ = 0
038400110512    ***
038500101206     C     KL#TSA        SETLL     MEMBR
038600101206    ***
038700101206     C                   EVAL      @STEP = 'STEP2'
038800101206    ***
038900101206     C                   ENDSR
039000101206   S***S
039100101206     C     $STEP2        BEGSR
039200101206    ***
039300101206     C     KL#TSA        READE     MEMBR
039400101206    ***
039500101206     C                   IF        %EOF(MEMAC#1)
039600110512     C                   EVAL      @STEP = 'PREP1'
039700101206     C                   LEAVESR
039800101206     C                   ENDIF
039900101206    ***
040000101206     C                   EVAL      KF@SSN = MBSSNO
040100101214     C                   MOVE      *ZEROS        KF@SEQ
040200120803     C                   EVAL      WRT@TYPE = 'MEMBER'
040300120803    ***
040400101214    ***
040500101206     C     KL#MPLN       SETLL     MCOVR
040600101206    ***
040700101206     C                   EXSR      $CLRSTG
040800101206    ***
040900101206     C                   EVAL      @STEP = 'STEP3'
041000101206    ***
041100101206     C                   ENDSR
041200101210   S***S
041300101206     C     $STEP3        BEGSR
041400101206    ***
041500101206     C     KL#MPLN       READE     MCOVR
041600101206    ***
041700101206     C                   IF        %EOF(MCOVMPLN)
041800101206     C                   EVAL      @STEP = 'PREP4'
041900101206     C                   LEAVESR
042000101206     C                   ENDIF
042100101206    ***
042200130131     C*                  IF        ENRLDT = CANDT
042300130131     C*                  LEAVESR
042400130131     C*                  ENDIF
042500120803    ***
042600120803     C                   EVAL      KF@PLN = MCPLAN
042700160829     C     KL#TSAP       CHAIN     AEF04
042800160829     C                   IF        NOT %FOUND(AET004WF)
042900120803     C                   LEAVESR
043000120803     C                   ENDIF
043100110513    ***
043200110512     C                   EVAL      @PLANIN = MCPLAN
043300111020     C                   EVAL      ENR@IN = MCOVTP
043400110802    ***
043500110802     C                   EXSR      $QUIK
043600110802    ***
043700110512     C                   EXSR      $PLANSRCH
043800110512    ***
043900110512     C                   IF        PLN@CAT = *BLANKS
044000110512     C                   LEAVESR
044100110512     C                   ENDIF
044200101206    ***
044300101206     C                   IF        CANDT = 0
044400101206     C                   EVAL      #CANCEL = 99999999
044500101206     C                   ELSE
044600101206     C                   EVAL      #CANCEL = CANDT
044700101206     C                   ENDIF
044800101206    ***
044900130315    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL;
045000130315    *** LIF IS LIFE;
045100110513    ***
045200130315     C                   SELECT
045300130315      *
045400160224    *C****               WHEN      PLN@CAT = 'LIFE'
045500160224    *C****               IF        L#CNE > 0
045600160224    *C****               IF        L@TRM(L#CNE) = 99999999
045700160224     C****               LEAVESR
045800160224     C****               ENDIF
045900160224     C****               ENDIF
046000160224    *C****               ADD       1             L#CNE
046100160224    *C****               EVAL      L@PLN(L#CNE) = MCPLAN
046200160224    *C****               EVAL      L@ENR(L#CNE) = MCOVTP
046300160224    *C****               EVAL      L@FRM(L#CNE) = ENRLDT
046400160224    *C****               EVAL      L@TRM(L#CNE) = #CANCEL
046500130315      *
046600160224    *C****               WHEN      PLN@CAT = 'DEN'
046700160224    *C****               IF        D#CNE > 0
046800160224    *C****               IF        D@TRM(D#CNE) = 99999999
046900160224     C****               LEAVESR
047000160224     C****               ENDIF
047100160224     C****               ENDIF
047200160224    *C****               ADD       1             D#CNE
047300160224    *C****               EVAL      D@PLN(D#CNE) = MCPLAN
047400160224    *C****               EVAL      D@ENR(D#CNE) = MCOVTP
047500160224    *C****               EVAL      D@FRM(D#CNE) = ENRLDT
047600160224    *C****               EVAL      D@TRM(D#CNE) = #CANCEL
047700160224      ****
047800160224    *C                   WHEN      PLN@CAT = 'VIS '
047900160224    *C                   IF        M#CNE > 0
048000160224    *C                   IF        M@TRM(M#CNE) = 99999999
048100160224     C                   LEAVESR
048200160224     C                   ENDIF
048300160224     C                   ENDIF
048400160224     C                   ADD       1             M#CNE
048500160224     C                   EVAL      M@PLN(M#CNE) = MCPLAN
048600101206     C                   EVAL      M@ENR(M#CNE) = MCOVTP
048700101206     C                   EVAL      M@FRM(M#CNE) = ENRLDT
048800101206     C                   EVAL      M@TRM(M#CNE) = #CANCEL
048900130315      *
049000130315    *C                   ENDSL
049100110512    ***
049200110512     C                   ENDSR
049300110512   S***S
049400110802     C     $QUIK         BEGSR
049500110802    ***
049600110805     C                   EVAL      @CCTRIN = *BLANKS
049700120803    ***
049800160829     C     AE4MAP        CASEQ     '2TIER     '  $METH01
049900160829     C     AE4MAP        CASEQ     'ITOBJECTS '  $METH02
050000160829     C     AE4MAP        CASEQ     'NORULE    '  $METH03
050100160829     C     AE4MAP        CASEQ     'STATETIER '  $METH04
050200160829     C     AE4MAP        CASEQ     'TIERSTS   '  $METH05
050300160829     C     AE4MAP        CASEQ     'MAYOR     '  $METH06
050400160829     C     AE4MAP        CASEQ     'EMPSTS    '  $METH07
050500160829     C     AE4MAP        CASEQ     'JUSTSTATE '  $METH08
050600160829     C     AE4MAP        CASEQ     'JOHNLS    '  $METH09
050700160829     C     AE4MAP        CASEQ     'CREATIVE  '  $METH10
050800160829     C     AE4MAP        CASEQ     'INTEGRA   '  $METH11
050900160829     C     AE4MAP        CASEQ     'STSTATE   '  $METH12
051000160829     C     AE4MAP        CASEQ     'INTEGRA   '  $METH11
051100160829     C     AE4MAP        CASEQ     'STIERSTS  '  $METH13
051200120803     C                   ENDCS
051300120803    ***
051400120803     C                   ENDSR
051500120803   S***S
051600120803    *** 2 TIER = AETNA HAS TWO TIERS, IND AND FAM
051700120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'IND' AND NON-'TIN' CONVERTED TO 'FAM'
051800120803    ***  DEPENDENTS HAVE 'FAM' ONLY
051900120803    ***
052000120803    *** IND, FAM
052100120803    ***
052200120803     C     $METH01       BEGSR
052300120803    ***
052400120803     C                   IF        WRT@TYPE = 'MEMBER'
052500120803    *** *
052600120803     C                   IF        ENR@IN = 'TIN'
052700120803     C                   EVAL      @CCTRIN = 'IND'
052800120803     C                   ELSE
052900120803     C                   EVAL      @CCTRIN = 'FAM'
053000120803     C                   ENDIF
053100120803    *** *
053200120803     C                   ENDIF
053300120803    ***
053400120803     C                   IF        WRT@TYPE = 'DEPEND'
053500120803    *** *
053600120803     C                   EVAL      @CCTRIN = 'FAM'
053700120803    *** *
053800120803     C                   ENDIF
053900120803    ***
054000120803     C                   ENDSR
054100120803   S***S
054200120803    *** ITOBJECTS = IF YOU ARE NOT 'VA' OR 'OH' STATE CODES, YOU ARE 'XX'
054300120803    ***
054400120803    *** VA, OH, XX
054500120803    ***
054600120803     C     $METH02       BEGSR
054700120803    ***
054800120803     C                   IF        STATE <> 'VA' AND STATE <> 'OH'
054900120803     C                   EVAL      @CCTRIN = 'XX '
055000120803     C                   ELSE
055100120803     C                   EVAL      @CCTRIN = STATE
055200120803     C                   ENDIF
055300120803    ***
055400120803     C                   ENDSR
055500120803   S***S
055600120803    *** NORULE = NUFF SAID
055700120803    ***
055800120803     C     $METH03       BEGSR
055900120803    ***
056000120803     C                   EVAL      @CCTRIN = *BLANKS
056100120803    ***
056200120803     C                   ENDSR
056300120803   S***S
056400120803    *** STATETIER
056500120803    ***  START WITH STATE CODE
056600120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
056700120803    ***  DEPENDENTS HAVE 'F' ONLY
056800120803    ***
056900120803    *** MDI, MDF, ETC...
057000120803    ***
057100120803     C     $METH04       BEGSR
057200120803    ***
057300120803     C                   EVAL      @CCTRIN = STATE
057400120803    ***
057500120803     C                   IF        WRT@TYPE = 'MEMBER'
057600120803     C                   IF        ENR@IN = 'TIN'
057700120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
057800120803     C                   ELSE
057900120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
058000120803     C                   ENDIF
058100120803     C                   ENDIF
058200120803    ***
058300120803     C                   IF        WRT@TYPE = 'DEPEND'
058400120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
058500120803     C                   ENDIF
058600120803    ***
058700120803     C                   ENDSR
058800120803   S***S
058900120803    *** TIERSTS
059000120803    ***  START WITH EMPLOYMENT STATUS, ACTIVE IS 'ACT' AND COBRA IS 'COB'
059100120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
059200120803    ***  DEPENDENTS HAVE 'F' ONLY
059300120803    ***
059400120803    *** ACI, ACF, COI, COF
059500120803    ***
059600120803     C     $METH05       BEGSR
059700120803    ***
059800120803     C                   IF        EMPST =  'C'
059900120803     C                   EVAL      @CCTRIN = 'COB'
060000120803     C                   ELSE
060100120803     C                   EVAL      @CCTRIN = 'ACT'
060200120803     C                   ENDIF
060300120803    ***
060400120803     C                   IF        ENR@IN = 'TIN'
060500120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
060600120803     C                   ELSE
060700120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
060800120803     C                   ENDIF
060900120803    ***
061000120803     C                   ENDSR
061100120803   S***S
061200120803    *** MAYOR
061300120803    ***  WELL, FOR THE PLAN 'DAAU' IF THE STATE IS 'WV' THEN PLACE TIER STATUS SUFFIX
061400120803    ***       BY TYPE OF PEEP; FOR OTHER STATES, USE A SIMPLE TIER CHECK.
061500120803    ***
061600120803    ***  WVI, WVF, IND, FAM
061700120803    ***
061800120803    ***  NOW, FOR THE PLAN 'DAAT' IF THE STATE IS 'WV' THEN PLACE EMPLOYMENT STATUS SUFFIX
061900120803    ***       BY TYPE OF PEEP; FOR OTHER STATES, EMPLOYMENT STATUS AND TIER.
062000120803    ***
062100120803    ***  WVI, WVF, CBI, CBF, ACI, ACF
062200120803    ***
062300120803    ***
062400120803     C     $METH06       BEGSR
062500120803    ***
062600120803    1C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'MEMBER'
062700120803      *
062800120803    2C                   IF        STATE = 'WV'
062900120803      **
063000120803    3C                   IF        ENR@IN = 'TIN'
063100120803     C                   EVAL      @CCTRIN = 'WVI'
063200120803    3C                   ELSE
063300120803     C                   EVAL      @CCTRIN = 'WVF'
063400120803    3C                   ENDIF
063500120803      **
063600120803    2C                   ELSE
063700120803      **
063800120803    3C                   IF        ENR@IN = 'TIN'
063900120803     C                   EVAL      @CCTRIN = 'IND'
064000120803    3C                   ELSE
064100120803     C                   EVAL      @CCTRIN = 'FAM'
064200120803    3C                   ENDIF
064300120803      **
064400120803    2C                   ENDIF
064500120803      *
064600120803     C                   LEAVESR
064700120803    1C                   ENDIF
064800120803    ***
064900120803     C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'DEPEND'
065000120803      *
065100120803     C                   IF        STATE = 'WV'
065200120803     C                   EVAL      @CCTRIN = 'WVF'
065300120803     C                   ELSE
065400120803     C                   EVAL      @CCTRIN = 'FAM'
065500120803     C                   ENDIF
065600120803      *
065700120803     C                   LEAVESR
065800120803     C                   ENDIF
065900120803    ***
066000120803    1C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'MEMBER'
066100120803      *
066200120803    2C                   IF        STATE = 'WV'
066300120803      **
066400120803    3C                   IF        ENR@IN = 'TIN'
066500120803     C                   EVAL      @CCTRIN = 'WVI'
066600120803    3C                   ELSE
066700120803     C                   EVAL      @CCTRIN = 'WVF'
066800120803    3C                   ENDIF
066900120803      **
067000120803    2C                   ELSE
067100120803      **
067200120803    3C                   IF        EMPST =  'C'
067300120803     C                   EVAL      @CCTRIN = 'CB '
067400120803    3C                   ELSE
067500120803     C                   EVAL      @CCTRIN = 'AC '
067600120803    3C                   ENDIF
067700120803    3C                   IF        ENR@IN = 'TIN'
067800120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
067900120803    3C                   ELSE
068000120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
068100120803    3C                   ENDIF
068200120803      **
068300120803    2C                   ENDIF
068400120803      *
068500120803     C                   LEAVESR
068600120803    1C                   ENDIF
068700120803    ***
068800120803     C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'DEPEND'
068900120803      *
069000120803     C                   IF        STATE = 'WV'
069100120803     C                   EVAL      @CCTRIN = 'WVF'
069200120803     C                   ELSE
069300120803     C                   IF        EMPST =  'C'
069400120803     C                   EVAL      @CCTRIN = 'CBF'
069500120803     C                   ELSE
069600120803     C                   EVAL      @CCTRIN = 'ACF'
069700120803     C                   ENDIF
069800120803     C                   ENDIF
069900120803      *
070000120803     C                   ENDIF
070100120803    ***
070200120803     C                   ENDSR
070300120803   S***S
070400120803    *** EMPSTS
070500120803    ***   PRETTY STRAIGHT FORWARDED
070600120803    ***
070700120803     C     $METH07       BEGSR
070800120803    ***
070900120803     C                   IF        EMPST =  'C'
071000120803     C                   EVAL      @CCTRIN = 'COB'
071100120803     C                   ELSE
071200120803     C                   EVAL      @CCTRIN = 'ACT'
071300120803     C                   ENDIF
071400120803    ***
071500120803     C                   ENDSR
071600120803   S***S
071700120803    *** JUSTSTATE
071800120803    ***   PRETTY STRAIGHT FORWARDED
071900120803    ***
072000120803     C     $METH08       BEGSR
072100120803    ***
072200120803     C                   EVAL      @CCTRIN = STATE
072300120803    ***
072400120803     C                   ENDSR
072500120803   S***S
072600120803    *** JOHNLS
072700120803    ***   IF STATE IS NOT MARYLAND, DEFAULT TO 'XX', ELSE USE 'MD'; THEN APPLY TIER.
072800120803    ***
072900120803    *** MDI, MDF, XXI, XXF
073000120803    ***
073100120803     C     $METH09       BEGSR
073200120803    ***
073300120803     C                   IF        WRT@TYPE = 'MEMBER'
073400120803     C                   IF        STATE = 'MD'
073500120803     C                   EVAL      @CCTRIN = 'MD'
073600120803     C                   ELSE
073700120803     C                   EVAL      @CCTRIN = 'XX'
073800120803     C                   ENDIF
073900120803     C                   IF        ENR@IN = 'TIN'
074000120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
074100120803     C                   ELSE
074200120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
074300120803     C                   ENDIF
074400120803     C                   ENDIF
074500120803    ***
074600120803     C                   IF        WRT@TYPE = 'DEPEND'
074700120803     C                   IF        STATE = 'MD'
074800120803     C                   EVAL      @CCTRIN = 'MDF'
074900120803     C                   ELSE
075000120803     C                   EVAL      @CCTRIN = 'XXF'
075100120803     C                   ENDIF
075200120803     C                   ENDIF
075300120803    ***
075400120803     C                   ENDSR
075500120803   S***S
075600120803    *** CREATIVE
075700120803    ***   IF STATE IS NOT 'MD' OR 'OK', DEFAULT TO '**'.
075800120803    ***
075900120803    *** MD, OK, **
076000120803    ***
076100120803     C     $METH10       BEGSR
076200120803    ***
076300120803     C                   IF        STATE <> 'MD' AND STATE <> 'OK'
076400120803     C                   EVAL      @CCTRIN = '** '
076500120803     C                   ELSE
076600120803     C                   EVAL      @CCTRIN = STATE
076700120803     C                   ENDIF
076800120803    ***
076900120803     C                   ENDSR
077000120803   S***S
077100120803    *** INTEGRA = USE 'TN' FOR TENNESSEE, OTHER STATES ARE 'XX'
077200120803    ***
077300120803    ***  TN, XX
077400120803    ***
077500120803     C     $METH11       BEGSR
077600120803    ***
077700121113     C                   SELECT
077800121113     C                   WHEN      STATE = 'TN'
077900121113     C                   EVAL      @CCTRIN = STATE                              TENNESSEE ONLY
078000121113     C                   WHEN      STATE = 'FL'
078100121113     C                   EVAL      @CCTRIN = STATE                              FLORIDA ONLY
078200121113     C                   OTHER
078300121113     C                   EVAL      @CCTRIN = 'XX '                              SITUS
078400121113     C                   ENDSL
078500120803    ***
078600120803     C                   ENDSR
078700120803   S***S
078800120803    *** STSTATE = STATE CODE WITH EMPLOYEE STATUS
078900120803    ***
079000120803    ***  MDA, MDC, ETC...
079100120803    ***
079200120803     C     $METH12       BEGSR
079300120803    ***
079400120803     C                   EVAL      @CCTRIN = STATE + EMPST
079500120803    ***
079600120803     C                   ENDSR
079700130123   S***S
079800130123    *** STIERSTS = STATE CODE WITH TIER WITH EMPLOYEE STATUS
079900130123    ***    ACTIVE [#CALC = 0]      COBRA [#CALC = 5]
080000130123    ***    IND [+1 TO #CALC ]      NON-IND COVERAGE [+2 TO CALC]
080100130123    ***
080200130123    ***    EACH STATE PUT AT END, GIVING FAM MARYLAND ACTIVE A VALUE OF 2MD
080300130123    ***                                  IND WEST VIRGINIA COBRA A VALUE OF 6WV
080400130123    ***
080500130123    ***
080600130123     C     $METH13       BEGSR
080700130123    ***
080800130123     C                   SELECT
080900130123     C                   WHEN      EMPST =  'C'
081000130123     C                   Z-ADD     5             #CALC
081100130123     C                   OTHER
081200130123     C                   MOVE      *ZEROS        #CALC             1 0
081300130123     C                   ENDSL
081400130123    ***
081500130123     C                   SELECT
081600130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN = 'TIN'
081700130123     C                   ADD       1             #CALC
081800130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN <> 'TIN'
081900130123     C                   ADD       2             #CALC
082000130123     C                   WHEN      WRT@TYPE = 'DEPEND'
082100130123     C                   ADD       2             #CALC
082200130123     C                   ENDSL
082300130123    ***
082400130123     C                   EVAL      @CCTRIN = %EDITC(#CALC:'X') + STATE
082500130123    ***
082600130123     C                   ENDSR
082700120803   S***S
082800120409     C     $PREP4        BEGSR
082900120409    ***
083000130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
083100101206     C                   EVAL      @STEP = 'STEP2'
083200101206     C                   LEAVESR
083300101206     C                   ENDIF
083400130520    ***
083500130520     C                   EVAL      @STEP = 'STEP4'
083600130315     C                   EVAL      TERM_LIF = NO
083700101210     C                   EVAL      TERM_DEN = NO
083800101210     C                   EVAL      TERM_MED = NO
083900101210    ***
084000130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
084100130520     C                   IF        L@TRM(L#CNE) <> 99999999
084200130520     C                   EXSR      $CHKHEM
084300130520     C                   ENDIF
084400130520     C                   LEAVESR
084500130520     C                   ENDIF
084600130520    ***
084700130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
084800130520     C                   IF        M@TRM(M#CNE) <> 99999999
084900130520     C                   EXSR      $CHKHEM
085000130520     C                   ENDIF
085100130520     C                   LEAVESR
085200130520     C                   ENDIF
085300130520    ***
085400130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
085500130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
085600130520     C                              M@TRM(M#CNE) <> 99999999)
085700130520     C                   EXSR      $CHKHEM
085800130520     C                   ENDIF
085900130520     C                   LEAVESR
086000130520     C                   ENDIF
086100130520    ***
086200130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
086300130520     C                   IF        D@TRM(D#CNE) <> 99999999
086400130520     C                   EXSR      $CHKHEM
086500130520     C                   ENDIF
086600130520     C                   LEAVESR
086700130520     C                   ENDIF
086800130520    ***
086900130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
087000130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
087100130520     C                              D@TRM(D#CNE) <> 99999999)
087200130520     C                   EXSR      $CHKHEM
087300130520     C                   ENDIF
087400130520     C                   LEAVESR
087500130520     C                   ENDIF
087600130520    ***
087700130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
087800130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
087900130520     C                              M@TRM(M#CNE) <> 99999999)
088000130520     C                   EXSR      $CHKHEM
088100130520     C                   ENDIF
088200130520     C                   LEAVESR
088300130520     C                   ENDIF
088400130520    ***
088500130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
088600130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
088700130520     C                              L@TRM(L#CNE) <> 99999999 OR
088800130520     C                              M@TRM(M#CNE) <> 99999999)
088900130520     C                   EXSR      $CHKHEM
089000130520     C                   ENDIF
089100130520     C                   LEAVESR
089200130520     C                   ENDIF
089300101214    ***
089400101214     C                   ENDSR
089500101214   S***S
089600101210    *** GENERATE MEMBER RECORD
089700101210    ***
089800101210     C     $STEP4        BEGSR
089900101210    ***
090000130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
090100101214     C                   EVAL      @STEP = 'STEP2'
090200101214     C                   LEAVESR
090300101214     C                   ENDIF
090400101214    ***
090500110513     C                   EVAL      WRT@TYPE = 'MEMBER'
090600110725    ***
090700130315     C                   EVAL      L@MBREFF = 0
090800110725     C                   EVAL      D@MBREFF = 0
090900110725     C                   EVAL      M@MBREFF = 0
091000110513    ***
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
093300101210    ***
093400101210     C                   SELECT
093500101210     C                   WHEN      EMPST = 'A'
093600101210     C                   EVAL      @EMPST = 'AC'
093700101210     C                   WHEN      EMPST = 'C'
093800101210     C                   EVAL      @EMPST = 'CO'
093900101210     C                   WHEN      EMPST = 'R'
094000101210     C                   EVAL      @EMPST = 'RT'
094100101210     C                   ENDSL
094200101210    ***
094300101210     C                   EVAL      @HIRE  = %EDITC(EMPDT:'X')
094400101210    ***
094500141211     C                   SETOFF                                       888987
094600141120        IF KF@TRS = 770 AND KF@SUB = 004 AND KF@ACC = 0037 AND
094700141120          STATE = 'VT';
094800141120           *IN89 = *ON;
094900141120        ENDIF;
095000141211    *** IF KF@TRS = 591 AND KF@SUB = 001 AND KF@ACC = 0042 AND
095100141211    ***   STATE = 'TX';
095200141211    ***    *IN87 = *ON;
095300141211    *** ENDIF;
095400141120    ***
095500161130
095600161130       // if cobra and effective date > 12/01/2016...
095700170317       //if empst = 'C';
095800170317       // if qedt >= effectiveDateD;
095900170317       //  @empst = 'AC';
096000170317       // endif;
096100170317       //endif;
096200161130
096300101210     C                   EXCEPT    MBRF
096400101214     C                   ADD       1             C#RECCNT
096500101213    ***
096600101213     C                   EVAL      @STEP = 'PREP5'
096700101210    ***
096800101210     C                   ENDSR
096900101210   S***S
097000130315    *** * * * * * MEDICAL
097100101214     C     $PREP5        BEGSR
097200101214    ***
097300101214     C                   IF        M#CNE = 0
097400110513     C                   EVAL      @STEP = 'PREP6'
097500101214     C                   LEAVESR
097600101214     C                   ENDIF
097700101214    ***
097800101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
097900130315     C                   EVAL      KF@ENR = M@ENR(M#CNE)
098000101214    ***
098100101214     C                   IF        TERM_MED = YES
098200101214     C                   EXSR      $WRTERM
098300101214     C                   ENDIF
098400101214    ***
098500110512     C                   EVAL      @PLANIN = KF@PLN
098600120803    ***
098700160829     C     KL#TSAP       CHAIN     AEF04
098800160829     C                   IF        NOT %FOUND(AET004WF)
098900120803     C                   LEAVESR
099000120803     C                   ENDIF
099100120803    ***
099200111020     C                   EVAL      ENR@IN = M@ENR(M#CNE)
099300111020    ***
099400110802     C                   EXSR      $QUIK
099500110802    ***
099600110512     C                   EXSR      $PLANSRCH
099700110512    ***
099800110512     C                   IF        PLN@CAT = *BLANKS
099900101214     C                   SETON                                        H1
100000101214     C                   ENDIF
100100110512    ***
100200110513     C                   EVAL      @STEP = 'STEP5'
100300110725     C                   EVAL      #XSX = M@FRM(M#CNE)
100400110725     C                   EVAL      M@MBREFF = #XSX
100500101214    ***
100600101214     C                   ENDSR
100700101214   S***S
100800101214     C     $STEP5        BEGSR
100900101214    ***
101000160224     C                   IF        CPCID1 = 'VIS'
101100110513     C                   EXSR      $MEAWRT
101200110513     C                   ELSE
101300160224     C****               EXSR      $HMOWRT
101400110513     C                   ENDIF
101500110513    ***
101600101214     C                   ADD       1             C#RECCNT
101700101214     C                   ADD       1             B#RECCNT
101800110512    ***
101900110513     C                   EVAL      @STEP = 'PREP6'
102000110513    ***
102100110513     C                   ENDSR
102200110513   S***S
102300130315    *** DENTAL
102400130315    ***
102500101214     C     $PREP6        BEGSR
102600101213    ***
102700110513    *C                   IF        D#CNE = 0
102800130315    *C                   EVAL      @STEP = 'PREPC'
102900130315    *C*****************  EVAL      @STEP = 'PREP7'
103000110513    *C                   LEAVESR
103100110513    *C                   ENDIF
103200110512    ***
103300110513    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
103400130315    *C                   EVAL      KF@ENR = D@ENR(D#CNE)
103500130315    ***
103600160829     C     KL#TSAP       CHAIN     AEF04
103700160829     C                   IF        NOT %FOUND(AET004WF)
103800120803     C                   LEAVESR
103900120803     C                   ENDIF
104000110512    ***
104100110513    *C                   IF        TERM_DEN = YES
104200110513    *C                   EXSR      $WRTERM
104300110513    *C                   ENDIF
104400110513    ***
104500110513     C                   EVAL      @PLANIN = KF@PLN
104600111020     C                   EVAL      ENR@IN = D@ENR(D#CNE)
104700110513    ***
104800111011     C                   EXSR      $QUIK
104900110513    ***
105000110513     C                   EXSR      $PLANSRCH
105100110513    ***
105200110513     C                   IF        PLN@CAT = *BLANKS
105300110513     C                   SETON                                        H2
105400110513     C                   ENDIF
105500110512    ***
105600110513    *C                   EVAL      @STEP = 'STEP6'
105700110725     C                   EVAL      #XSX = D@FRM(D#CNE)
105800110725     C                   EVAL      D@MBREFF = #XSX
105900110512    ***
106000101213     C                   ENDSR
106100110802   S***S
106200110513    *** DENTAL FORMAT
106300110513    ***
106400110513    *C     $STEP6        BEGSR
106500110513    ***
106600110513     C                   EXSR      $DENWRT
106700110513    ***
106800110513    *C                   ADD       1             C#RECCNT
106900110513    *C                   ADD       1             B#RECCNT
107000110513    ***
107100130315    *C****************** EVAL      @STEP = 'PREP7'
107200130315    *C                   EVAL      @STEP = 'PREPC'
107300110513    ***
107400110513    *C                   ENDSR
107500110513   S***S
107600130315    *** LIFE AND AD&D PLANS FOR MEMBER
107700130315    ***
107800130315     C     $PREPC        BEGSR
107900130315    ***
108000130315    *C                   IF        L#CNE = 0
108100130315    *C                   EVAL      @STEP = 'PREP7'
108200130315    *C                   LEAVESR
108300130315    *C                   ENDIF
108400130315    ***
108500130315    *C                   EVAL      KF#TRM = L@TRM(L#CNE)
108600130315    *C                   EVAL      KF@PLN = L@PLN(L#CNE)
108700130315     C                   EVAL      KF@ENR = L@ENR(L#CNE)
108800130315    ***
108900160829     C     KL#TSAP       CHAIN     AEF04
109000160829     C                   IF        NOT %FOUND(AET004WF)
109100130315     C                   LEAVESR
109200130315     C                   ENDIF
109300130315    ***
109400130315    *C                   IF        TERM_LIF = YES
109500130315    *C                   EXSR      $WRTERM
109600130315    *C                   ENDIF
109700130315    ***
109800130315     C                   EVAL      @PLANIN = KF@PLN
109900130315     C                   EVAL      ENR@IN = L@ENR(L#CNE)
110000130315    ***
110100130315     C                   EXSR      $QUIK
110200130315    ***
110300130315     C                   EXSR      $PLANSRCH
110400130315    ***
110500130315     C                   IF        PLN@CAT = *BLANKS
110600130315     C                   SETON                                        H2
110700130315     C                   ENDIF
110800130315    ***
110900130315    *C                   EVAL      @STEP = 'STEPC'
111000130315     C                   EVAL      #XSX = L@FRM(L#CNE)
111100130315     C                   EVAL      L@MBREFF = #XSX
111200130315    ***
111300130315     C                   ENDSR
111400130315   S***S
111500130315    *** LIFE FORMAT
111600130315    ***
111700130315    *C     $STEPC        BEGSR
111800130315    ***
111900130315     C                   EXSR      $LIFWRT
112000130315    ***
112100130315    *C                   ADD       1             C#RECCNT
112200130315    *C                   ADD       1             B#RECCNT
112300130315    ***
112400130315    *C                   EVAL      @STEP = 'PREP7'
112500130315    ***
112600130315    *C                   ENDSR
112700130315   S***S
112800130315     C     $LIFWRT       BEGSR
112900130315    ***
113000130315    *C                   EVAL      X@LAY = CPCID1                               LAYOUT
113100130315    *C                   EVAL      X@ELR = CPCID2                               ELR
113200130315    *C                   EVAL      L@SFX = CPCID3                               SUFFIX
113300130315    *C                   EVAL      L@ACCT = CPCID4                              ACCOUNT
113400130315    *C                   EVAL      L@PLAN = CPCID5                              PLAN
113500130315    *C                   EVAL      L@CLM = CPCID6                               CLAIM OFFICE
113600130315    ***
113700130315    *C                   EVAL      #XSX = L@FRM(L#CNE)
113800130315     C                   MOVE      #XSX          X@EFF
113900130315    ***
114000130315    *C                   EVAL      #XSX = L@TRM(L#CNE)
114100130315    *C                   IF        #XSX = 0 OR #XSX = 99999999
114200130315    *C                   MOVE      *BLANKS       X@TRM
114300130315    *C                   ELSE
114400160809    *C****               MOVE      #XSX          X@TRM
114500160809       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
114600160809       if %subdt(work_date:*d) = 01 ;
114700160809        work_date -= %days(1) ;
114800160809        num_date = %dec(work_date:*iso);
114900160809        X@TRM = %EDITC(num_date:'X');
115000160809       endif;
115100160809
115200130315    *C                   ENDIF
115300140313    ***
115400140313     C                   MOVE      *BLANKS       L@CBREXP
115500140313     C                   MOVE      *BLANKS       L@CBREVT
115600140313     C                   MOVE      *BLANKS       L@CBRLEN
115700130315    ***
115800130923    *C                   IF        EMPST = 'C' AND
115900130923     C                             CEXPDT > 0
116000130315    *C                   MOVE      CEXPDT        L@CBREXP
116100130315    *C                   MOVE      QEDT          L@CBREVT
116200130315    *C                   MOVE      CEXPDT        #MINUEND
116300130315    *C                   MOVE      QEDT          #SUBTRAEND
116400130315    *C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
116500130315    *C                   Z-ADD     #DIFFRNC      #2S0
116600130315    *C                   MOVE      #2S0          L@CBRLEN
116700130315    *C                   ENDIF
116800130315    ***
116900130315     C                   EVAL      L@SALARY = %EDITC(SALARY:'4')
117000130315    ***
117100130315    *C                   EXCEPT    LIFF
117200130315    ***
117300130315    *C                   ENDSR
117400130315   S***S
117500101214     C     $PREP7        BEGSR
117600101214    ***
117700101214     C     KF@SSN        CHAIN     DEPENR
117800101214     C                   IF        NOT %FOUND(DEPNDC)
117900101214     C                   EVAL      @STEP = 'STEP2'
118000101214     C                   LEAVESR
118100101214     C                   ENDIF
118200101214    ***
118300101214     C     KF@SSN        SETLL     DEPENR
118400101214    ***
118500101214     C                   EVAL      @STEP = 'STEP7'
118600101214    ***
118700101214     C                   ENDSR
118800101210   S***S
118900101214     C     $STEP7        BEGSR
119000101214    ***
119100101214     C     KF@SSN        READE     DEPENR
119200101214    ***
119300101214     C                   IF        %EOF(DEPNDC)
119400101214     C                   EVAL      @STEP = 'STEP2'
119500101214     C                   LEAVESR
119600101214     C                   ENDIF
119700101214    ***
119800101214     C                   EVAL      KF@SEQ = DPSEQ#
119900120803     C                   EVAL      WRT@TYPE = 'DEPEND'
120000101214    ***
120100101214     C     KL#DCV        CHAIN     DCOVR
120200101214     C                   IF        NOT %FOUND(DCOVA)
120300101214     C                   LEAVESR
120400101214     C                   ENDIF
120500101214    ***
120600101214     C                   EXSR      $CLRDCV
120700101214     C     KL#DCV        SETLL     DCOVR
120800101214    ***
120900101214     C                   EVAL      @STEP = 'STEP8'
121000101214    ***
121100101214     C                   ENDSR
121200101214   S***S
121300101214     C     $STEP8        BEGSR
121400101214    ***
121500101214     C     KL#DCV        READE     DCOVR
121600101214    ***
121700101214     C                   IF        %EOF(DCOVA)
121800101214     C                   EVAL      @STEP = 'PREP9'
121900101214     C                   LEAVESR
122000101214     C                   ENDIF
122100101214    ***
122200130131    *C*                  IF        DENRDT = CCANDT
122300130131    *C*                  LEAVESR
122400130131    *C*                  ENDIF
122500110513    ***
122600110513     C                   EVAL      @PLANIN = DVPLAN
122700120803     C                   EVAL      KF@PLN = DVPLAN
122800160829     C     KL#TSAP       CHAIN     AEF04
122900160829     C                   IF        NOT %FOUND(AET004WF)
123000120803     C                   LEAVESR
123100120803     C                   ENDIF
123200110802    ***
123300110802     C                   EXSR      $QUIKD
123400110802    ***
123500110513     C                   EXSR      $PLANSRCH
123600110513    ***
123700110513     C                   IF        PLN@CAT = *BLANKS
123800110513     C                   LEAVESR
123900110513     C                   ENDIF
124000101214    ***
124100101214     C                   EVAL      #CANCEL = CCANDT
124200101214     C                   IF        #CANCEL = 0
124300101214     C                   EVAL      #CANCEL = 99999999
124400101214     C                   ENDIF
124500101214    ***
124600130315    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL; LIFE IS MEMBER ONLY
124700110513    ***
124800160224    *C****               IF        PLN@CAT = 'DEN'
124900160224    *C****               IF        D#CNE > 0
125000160224    *C****               IF        D@TRM(D#CNE) = 99999999
125100160224     C****               LEAVESR
125200160224     C****               ENDIF
125300160224     C****               ENDIF
125400160224    *C****               ADD       1             D#CNE
125500160224    *C****               EVAL      D@PLN(D#CNE) = DVPLAN
125600160224    *C****               EVAL      D@ENR(D#CNE) = *BLANKS
125700160224    *C****               EVAL      D@FRM(D#CNE) = DENRDT
125800160224    *C****               EVAL      D@TRM(D#CNE) = #CANCEL
125900160224    *C****               ELSE
126000130131    *C                   IF        M#CNE > 0
126100130131    *C                   IF        M@TRM(M#CNE) = 99999999
126200130131     C                   LEAVESR
126300130131     C                   ENDIF
126400130131     C                   ENDIF
126500101214     C                   ADD       1             M#CNE
126600101214     C                   EVAL      M@PLN(M#CNE) = DVPLAN
126700101214     C                   EVAL      M@ENR(M#CNE) = *BLANKS
126800101214     C                   EVAL      M@FRM(M#CNE) = DENRDT
126900101214     C                   EVAL      M@TRM(M#CNE) = #CANCEL
127000160224    *C****               ENDIF
127100101214    ***
127200101214     C                   ENDSR
127300101214   S***S
127400111011     C     $QUIKD        BEGSR
127500111011    ***
127600120803     C                   EXSR      $QUIK
127700120409    ***
127800120409     C                   ENDSR
127900111011   S***S
128000101214     C     $PREP9        BEGSR
128100101214    ***
128200101214     C                   IF        D#CNE = 0 AND M#CNE = 0
128300101214     C                   EVAL      @STEP = 'STEP7'
128400101214     C                   LEAVESR
128500101214     C                   ENDIF
128600101214    ***
128700130315     C                   EVAL      L#CNE = 0
128800130315     C                   EVAL      TERM_LIF = NO
128900101214     C                   EVAL      TERM_DEN = NO
129000101214     C                   EVAL      TERM_MED = NO
129100130520     C                   EVAL      @STEP = 'STEP9'
129200101214    ***
129300130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
129400130520     C                   IF        L@TRM(L#CNE) <> 99999999
129500130520     C                   EXSR      $CHKHEM
129600130520     C                   ENDIF
129700130520     C                   LEAVESR
129800130520     C                   ENDIF
129900130520    ***
130000130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
130100130520     C                   IF        M@TRM(M#CNE) <> 99999999
130200130520     C                   EXSR      $CHKHEM
130300130520     C                   ENDIF
130400130520     C                   LEAVESR
130500130520     C                   ENDIF
130600130520    ***
130700130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
130800130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
130900130520     C                              M@TRM(M#CNE) <> 99999999)
131000130520     C                   EXSR      $CHKHEM
131100130520     C                   ENDIF
131200130520     C                   LEAVESR
131300130520     C                   ENDIF
131400130520    ***
131500130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
131600130520     C                   IF        D@TRM(D#CNE) <> 99999999
131700130520     C                   EXSR      $CHKHEM
131800130520     C                   ENDIF
131900130520     C                   LEAVESR
132000130520     C                   ENDIF
132100130520    ***
132200130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
132300130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
132400130520     C                              D@TRM(D#CNE) <> 99999999)
132500130520     C                   EXSR      $CHKHEM
132600130520     C                   ENDIF
132700130520     C                   LEAVESR
132800130520     C                   ENDIF
132900130520    ***
133000130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
133100130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
133200130520     C                              M@TRM(M#CNE) <> 99999999)
133300130520     C                   EXSR      $CHKHEM
133400130520     C                   ENDIF
133500130520     C                   LEAVESR
133600130520     C                   ENDIF
133700130520    ***
133800130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
133900130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
134000130520     C                              L@TRM(L#CNE) <> 99999999 OR
134100130520     C                              M@TRM(M#CNE) <> 99999999)
134200130520     C                   EXSR      $CHKHEM
134300130520     C                   ENDIF
134400130520     C                   LEAVESR
134500130520     C                   ENDIF
134600101214    ***
134700101214     C                   ENDSR
134800101214   S***S
134900101210    *** GENERATE DEPENDENT RECORD
135000101210    ***
135100101214     C     $STEP9        BEGSR
135200101210    ***
135300110513     C                   EVAL      WRT@TYPE = 'DEPEND'
135400110513    ***
135500110513     C                   IF        D#CNE = 0 AND M#CNE = 0
135600110513     C                   EVAL      @STEP = 'STEP7'
135700110513     C                   LEAVESR
135800110513     C                   ENDIF
135900110513    ***
136000101214     C                   EVAL      @SS2   = %EDITC(DEPSS#:'X')
136100101210     C                   MOVEL(P)  DLNAME        @LN
136200101210     C                   MOVEL(P)  DFNAME        @FN
136300101210     C                   EVAL      @MI    = DMI
136400101210    ***
136500101210     C                   SELECT
136600101210     C                   WHEN      DRELCD = 'RWI'
136700101210     C                   EVAL      @REL   = '02'
136800101210     C                   WHEN      DRELCD = 'RHU'
136900101210     C                   EVAL      @REL   = '03'
137000101210     C                   WHEN      DRELCD = 'RSO'
137100101210     C                   EVAL      @REL   = '04'
137200101210     C                   WHEN      DRELCD = 'RDA'
137300101210     C                   EVAL      @REL   = '05'
137400130218     C                   WHEN      DRELCD = 'RPA'
137500130218     C                   EVAL      @REL   = '14'
137600130225     C                   OTHER
137700130225     C                   EVAL      @REL   = *BLANKS
137800101210     C                   ENDSL
137900101210    ***
138000101210     C                   SELECT
138100101210     C                   WHEN      DSTUDN = 'Y'
138200101210     C                   EVAL      @SPEC = '1'
138300140812     C                   WHEN      DHNDCP = '3'
138400101210     C                   EVAL      @SPEC = '3'
138500130225     C                   OTHER
138600130225     C                   EVAL      @SPEC = *BLANKS
138700101210     C                   ENDSL
138800101210    ***
138900101210     C                   EVAL      @SEX   = DSEX
139000101210     C                   EVAL      @DOB   = %EDITC(DBIRTH:'X')
139100130225    ***
139200101210     C                   IF        DCOB = 'Y'
139300101210     C                   EVAL      @COB   = 'Y'
139400101210     C                   EVAL      @COBC  = 'OT'
139500101210     C                   EVAL      @COBN  = DCOBPN
139600130225     C                   ELSE
139700130225     C                   EVAL      @COB   = *BLANKS
139800130225     C                   EVAL      @COBC  = *BLANKS
139900130225     C                   EVAL      @COBN = *BLANKS
140000101210     C                   ENDIF
140100101214    ***
140200101214     C                   IF        DADDR1 <> ADDR1
140300101210     C                   EVAL      @AD1   = %TRIM(DADDR1)
140400101210     C                   EVAL      @AD2   = %TRIM(DADDR2)
140500101210     C                   EVAL      @CTY   = %TRIM(DCITY)
140600101210     C                   EVAL      @ST    = DSTATE
140700101210     C                   MOVE      *BLANKS       @9                9
140800101214     C                   IF        DZIP = 0
140900101214     C                   EVAL      @9   = %EDITC(ZIP:'X')
141000101214     C                   ELSE
141100101210     C                   EVAL      @9   = %EDITC(DZIP:'X')
141200101214     C                   ENDIF
141300101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
141400101210     C                   EVAL      @PHN   = %EDITC(DAREA:'X') +
141500101210     C                                      %EDITC(DPHONE:'X')
141600101214     C                   ENDIF
141700141120    ***
141800161130       // if cobra and effective date > 12/01/2016...
141900170317       //if empst = 'C';
142000170317       // if qedt >= effectiveDateD;
142100170317       //  @empst = 'AC';
142200170317       // endif;
142300170317       //endif;
142400161130
142500101210     C                   EXCEPT    MBRF
142600101214     C                   ADD       1             C#RECCNT
142700101214    ***
142800101214     C                   EVAL      @STEP = 'PREPA'
142900101210    ***
143000101210     C                   ENDSR
143100101210   S***S
143200101214     C     $PREPA        BEGSR
143300101214    ***
143400101214     C                   IF        M#CNE = 0
143500101214     C                   EVAL      @STEP = 'PREPB'
143600101214     C                   LEAVESR
143700101214     C                   ENDIF
143800101214    ***
143900101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
144000160829     C     KL#TSAP       CHAIN     AEF04
144100160829     C                   IF        NOT %FOUND(AET004WF)
144200120803     C                   LEAVESR
144300120803     C                   ENDIF
144400101214    ***
144500101214     C                   IF        TERM_MED = YES
144600101214     C                   EXSR      $WRTERM
144700101214     C                   ENDIF
144800101214    ***
144900110513     C                   EVAL      @PLANIN = KF@PLN
145000110802    ***
145100110802     C                   EXSR      $QUIKD
145200110802    ***
145300110513     C                   EXSR      $PLANSRCH
145400110513    ***
145500110513     C                   IF        PLN@CAT = *BLANKS
145600110513     C                   SETON                                        H2
145700110513     C                   ENDIF
145800110513    ***
145900110513     C                   EVAL      @STEP = 'STEPA'
146000110513    ***
146100101214     C                   ENDSR
146200101214   S***S
146300101214     C     $STEPA        BEGSR
146400101214    ***
146500160224     C                   IF        CPCID1 = 'VIS'
146600110513     C                   EXSR      $MEAWRT
146700110513     C                   ELSE
146800160224     C****               EXSR      $HMOWRT
146900110513     C                   ENDIF
147000110513    ***
147100110513     C                   ADD       1             C#RECCNT
147200110513     C                   ADD       1             B#RECCNT
147300110513    ***
147400110513     C                   EVAL      @STEP = 'PREPB'
147500110513    ***
147600110513     C                   ENDSR
147700110513   S***S
147800101214     C     $PREPB        BEGSR
147900101214    ***
148000110513    *C                   IF        D#CNE = 0
148100110513    *C                   EVAL      @STEP = 'STEP7'
148200110513    *C                   LEAVESR
148300110513    *C                   ENDIF
148400101214    ***
148500110513    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
148600160829     C     KL#TSAP       CHAIN     AEF04
148700160829     C                   IF        NOT %FOUND(AET004WF)
148800120803     C                   LEAVESR
148900120803     C                   ENDIF
149000110513    ***
149100110513    *C                   IF        TERM_DEN = YES
149200110513    *C                   EXSR      $WRTERM
149300110513    *C                   ENDIF
149400110513    ***
149500110513     C                   EVAL      @PLANIN = KF@PLN
149600110513    ***
149700110802     C                   EXSR      $QUIKD
149800110513    ***
149900110513     C                   EXSR      $PLANSRCH
150000110513    ***
150100110513     C                   IF        PLN@CAT = *BLANKS
150200110513     C                   SETON                                        H2
150300110513     C                   ENDIF
150400110513    ***
150500101214     C                   EVAL      @STEP = 'STEPB'
150600101214    ***
150700101214     C                   ENDSR
150800101214   S***S
150900110513    *C     $STEPB        BEGSR
151000110513    ***
151100110513     C                   EXSR      $DENWRT
151200110513    ***
151300110513    *C                   ADD       1             C#RECCNT
151400110513    *C                   ADD       1             B#RECCNT
151500110513    ***
151600110513    *C                   EVAL      @STEP = 'STEP7'
151700110513    ***
151800110513    *C                   ENDSR
151900101210   S***S
152000110512     C     *INZSR        BEGSR
152100110512    ***
152200160829     C     *entry        plist
152300160829     C                   parm                    CARR#CTL
152400160829     C                   parm                    grouper
152500160831     C                   parm                    p_trst
152600160831     C                   parm                    p_sub#
152700160831     C                   parm                    p_acct
152800160829
152900110512     C     KL#ACCTL      KLIST
153000120803     C                   KFLD                    KF@CCTL
153100110512     C                   KFLD                    KF@TRS
153200110512     C                   KFLD                    KF@SUB
153300110512     C                   KFLD                    KF@ACC
153400140313    ***
153500140313     C     KL#SQPCD      KLIST
153600140313     C                   KFLD                    KF@SSN
153700140313     C                   KFLD                    KF@SEQ
153800140313     C                   KFLD                    KF@SPCD
153900120803    ***
154000120803     C     KL#TSAP       KLIST
154100120803     C                   KFLD                    KF@TRS
154200120803     C                   KFLD                    KF@SUB
154300120803     C                   KFLD                    KF@ACC
154400120803     C                   KFLD                    KF@PLN
154500110512    ***
154600110512     C     KL#TSA        KLIST
154700110512     C                   KFLD                    KF@TRS
154800110512     C                   KFLD                    KF@SUB
154900110512     C                   KFLD                    KF@ACC
155000110512    ***
155100110512     C     KL#MPLN       KLIST
155200110512     C                   KFLD                    KF@SSN
155300110512     C                   KFLD                    KF@SEQ
155400110512     C                   KFLD                    KF@TRS
155500110512     C                   KFLD                    KF@SUB
155600110512     C                   KFLD                    KF@ACC
155700110512    ***
155800110512     C     KL#CPLN       KLIST
155900120803     C                   KFLD                    KF@CCTL
156000110512     C                   KFLD                    KF@TRS
156100110512     C                   KFLD                    KF@SUB
156200110512     C                   KFLD                    KF@ACC
156300110512     C                   KFLD                    KF@CCTR
156400110512     C                   KFLD                    KF@PLN
156500110512    ***
156600110512     C     KL#DCV        KLIST
156700110512     C                   KFLD                    KF@SSN
156800110512     C                   KFLD                    KF@SEQ
156900110512    ***
157000110512     C     KL#MTR        KLIST
157100110512     C                   KFLD                    KF@SSN
157200110512     C                   KFLD                    KF@SEQ
157300110512     C                   KFLD                    KF#TRM
157400110512     C                   KFLD                    KF@PLN
157500110512     C                   KFLD                    KF@ENR
157600110512     C                   KFLD                    KF@TRS
157700110512     C                   KFLD                    KF@SUB
157800110512     C                   KFLD                    KF@ACC
157900110512    ***
158000110512     C     KL#PCP        KLIST
158100110512     C                   KFLD                    KF@SSN
158200110512     C                   KFLD                    KF@SEQ
158300110512    ***
158400110512     C                   EVAL      #ISO = %DATE
158500110512     C                   MOVE      #ISO          #TODAY            8 0
158600110512     C                   EVAL      #IST = %TIME
158700110512     C                   MOVE      #ISO          #XSX
158800110512     C                   MOVE      #XSX          @DATE
158900110512     C                   MOVE      #IST          #XST
159000110512     C                   MOVE      #XST          @TIME
159100110512    ***
159200160831     c                   eval      kf@trs = p_trst
159300160831     c                   eval      kf@sub = p_sub#
159400160831     c                   eval      kf@acc = p_acct
159500160831
159600110512     C                   ENDSR
159700110512   S***S
159800110513    *** PLANS LOADED BY ACCOUNT
159900110513    ***
160000110513     C     $PLANLOAD     BEGSR
160100110513    ***
160200110513     C                   EVAL      PP# = 0
160300140313     C                   DO        80
160400110513     C                   ADD       1             PP#
160500110513     C     PP#           OCCUR     CARPLN@
160600110513     C                   CLEAR                   CARPLN@
160700110513     C                   ENDDO
160800110513     C                   EVAL      PC# = 0
160900110513     C                   EVAL      PP# = 0
161000110513    ***
161100110513     C     KL#ACCTL      SETLL     CARPLNR
161200110513     C                   DOU       %EOF(CARPLNP)
161300110513     C     KL#ACCTL      READE     CARPLNR
161400110520     C                   IF        NOT %EOF(CARPLNP)
161500110513    ***
161600110513     C                   ADD       1             PC#
161700110513     C     PC#           OCCUR     CARPLN@
161800110513     C                   EVAL      CARPLN@ = DS@CARPLN
161900110513    ***
162000110513     C                   ENDIF
162100110513     C                   ENDDO
162200110513    ***
162300110513     C                   ENDSR
162400110513   S***S
162500110513     C     $CLRSTG       BEGSR
162600110513    ***
162700110513     C                   EVAL      #CANCEL = 0
162800130315    ***
162900130315     C                   EVAL      L#CNE = 0
163000130315     C                   CLEAR                   L@PLN
163100130315     C                   CLEAR                   L@ENR
163200130315     C                   CLEAR                   L@FRM
163300130315     C                   CLEAR                   L@TRM
163400130315    ***
163500110513     C                   EVAL      D#CNE = 0
163600110513     C                   CLEAR                   D@PLN
163700110513     C                   CLEAR                   D@ENR
163800110513     C                   CLEAR                   D@FRM
163900110513     C                   CLEAR                   D@TRM
164000110513     C                   EVAL      M#CNE = 0
164100110513     C                   CLEAR                   M@PLN
164200110513     C                   CLEAR                   M@ENR
164300110513     C                   CLEAR                   M@FRM
164400110513     C                   CLEAR                   M@TRM
164500110513    ***
164600110513     C                   EXSR      $CLRDMG
164700110513    ***
164800110513     C                   ENDSR
164900110513   S***S
165000110513     C     $CLRDMG       BEGSR
165100110513    ***
165200110513     C                   EVAL      @SS1   = *BLANKS
165300110513     C                   EVAL      @SS2   = *BLANKS
165400110513     C                   MOVE      *BLANKS       @LN
165500110513     C                   MOVEL     *BLANKS       @FN
165600110513     C                   EVAL      @MI    = *BLANKS
165700110513     C                   EVAL      @REL   = *BLANKS
165800110513     C                   EVAL      @SEX   = *BLANKS
165900110513     C                   EVAL      @DOB   = *BLANKS
166000110513     C                   EVAL      @SPEC  = *BLANKS
166100110513     C                   EVAL      @COB   = *BLANKS
166200110513     C                   EVAL      @COBC  = *BLANKS
166300110513     C                   EVAL      @COBN  = *BLANKS
166400110513     C                   EVAL      @AD1   = *BLANKS
166500110513     C                   EVAL      @AD2   = *BLANKS
166600110513     C                   EVAL      @CTY   = *BLANKS
166700110513     C                   EVAL      @ST    = *BLANKS
166800110513     C                   EVAL      @ZP5   = *BLANKS
166900110513     C                   EVAL      @PHN   = *BLANKS
167000110513     C                   EVAL      @EMPST = *BLANKS
167100110513     C                   EVAL      @HIRE  = *BLANKS
167200110513    ***
167300110513     C                   ENDSR
167400110513   S***S
167500110513     C     $CHKHEM       BEGSR
167600110513    ***
167700130315    *C                   IF        L#CNE > 0 AND L@TRM(L#CNE) <> 99999999
167800130315    *C                   EXSR      $CHKLIF
167900130315    *C                   ENDIF
168000130315      *
168100110513    *C                   IF        D#CNE > 0 AND D@TRM(D#CNE) <> 99999999
168200110513    *C                   EXSR      $CHKDEN
168300110513    *C                   ENDIF
168400110513      *
168500110513     C                   IF        M#CNE > 0 AND M@TRM(M#CNE) <> 99999999
168600110513     C                   EXSR      $CHKMED
168700110513     C                   ENDIF
168800110513    ***
168900110513     C                   ENDSR
169000110513   S***S
169100130315    *C     $CHKLIF       BEGSR
169200130315    ***
169300130315    *C                   EVAL      TERM_LIF = YES
169400130315    *C                   EVAL      KF#TRM = L@TRM(L#CNE)
169500130315    *C                   EVAL      KF@PLN = L@PLN(L#CNE)
169600130315    *C                   EVAL      KF@ENR = L@ENR(L#CNE)
169700130315    ***
169800160829    *C     KL#MTR        CHAIN     AET1051F
169900170526    *C                   IF        %FOUND
170000130315    *C                   EVAL      L#CNE = 0
170100130315    *C                   EVAL      TERM_LIF = NO
170200130315    *C                   ENDIF
170300130315    ***
170400130315    *C                   ENDSR
170500130315   S***S
170600110513    *C     $CHKDEN       BEGSR
170700110513    ***
170800110513    *C                   EVAL      TERM_DEN = YES
170900110513    *C                   EVAL      KF#TRM = D@TRM(D#CNE)
171000110513    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
171100110513    *C                   EVAL      KF@ENR = D@ENR(D#CNE)
171200110513    ***
171300160829    *C     KL#MTR        CHAIN     AET1051F
171400170526    *C                   IF        %FOUND
171500110513    *C                   EVAL      D#CNE = 0
171600110513    *C                   EVAL      TERM_DEN = NO
171700110513    *C                   ENDIF
171800110513    ***
171900110513    *C                   ENDSR
172000110513   S***S
172100110513     C     $CHKMED       BEGSR
172200110513    ***
172300110513     C                   EVAL      TERM_MED = YES
172400110513     C                   EVAL      KF#TRM = M@TRM(M#CNE)
172500110513     C                   EVAL      KF@PLN = M@PLN(M#CNE)
172600110513     C                   EVAL      KF@ENR = M@ENR(M#CNE)
172700110513      *
172800160829     C     KL#MTR        CHAIN     AET1051F
172900170526     C                   IF        %FOUND
173000110513     C                   EVAL      TERM_MED = NO
173100110513     C                   EVAL      M#CNE = 0
173200110513     C                   ENDIF
173300110513    ***
173400110513     C                   ENDSR
173500110513   S***S
173600110513     C     $PLANSRCH     BEGSR
173700110513    ***
173800130315     C                   MOVE      *BLANKS       PLN@CAT           5
173900110513     C                   EVAL      PP# = 0
174000110513     C                   CLEAR                   DS@CARPLN
174100110513    ***
174200110513     C                   DO        PC#
174300110513    * *
174400110513     C                   ADD       1             PP#
174500110513     C     PP#           OCCUR     CARPLN@
174600110513    * *
174700110513     C                   IF        XPPLAN = @PLANIN AND
174800110513     C                             XPCCTR = @CCTRIN
174900110513     C                   EVAL      DS@CARPLN = CARPLN@
175000110513     C                   LEAVE
175100110513     C                   ENDIF
175200110513    * *
175300110513     C                   ENDDO
175400110513    ***
175500110513     C                   IF        CPPLAN = *BLANKS
175600110513     C                   LEAVESR
175700110513     C                   ENDIF
175800110513    ***
175900110513     C                   SELECT
176000160224     C                   WHEN      CPCID1 = 'VIS'
176100160224     C                   EVAL      PLN@CAT = 'VIS'
176200160224     C****                         CPCID1 = 'HMO'
176300160224     C****               EVAL      PLN@CAT = 'MED'
176400160224     C****               WHEN      CPCID1 = 'LIFE'
176500160224     C****               EVAL      PLN@CAT = 'LIFE'
176600160224     C****               WHEN      CPCID1 = 'DEN'
176700160224     C****               EVAL      PLN@CAT = 'DEN'
176800110513     C                   ENDSL
176900110513    ***
177000110513     C                   ENDSR
177100110513   S***S
177200110513     C     $ENROLL       BEGSR
177300110513    ***
177400110513     C                   EVAL      ENR@OUT = *BLANKS
177500110513     C                   SELECT
177600110513     C                   WHEN      ENR@IN = 'TIN' OR ENR@IN = 'TMI'
177700110513     C                   EVAL      ENR@OUT = 'S'
177800110513     C                   WHEN      ENR@IN = 'THW'
177900110513     C                   EVAL      ENR@OUT = 'C'
178000110513     C                   WHEN      ENR@IN = 'TPC'
178100110513     C                   EVAL      ENR@OUT = 'P'
178200110513     C                   WHEN      ENR@IN = 'TP2'
178300110513     C                   EVAL      ENR@OUT = 'Q'
178400110513     C                   WHEN      ENR@IN = 'TFA'
178500110513     C                   EVAL      ENR@OUT = 'F'
178600110513     C                   ENDSL
178700110513    ***
178800110513     C                   ENDSR
178900110513   S***S
179000110513     C     $WRTERM       BEGSR
179100110513    ***
179200160829     C                   CLEAR                   AET1051F
179300110513     C                   EVAL      NTSSNO         = KF@SSN
179400110513     C                   EVAL      NTDEPNO        = KF@SEQ
179500110513     C                   EVAL      NTTERMDT       = KF#TRM
179600110513     C                   EVAL      NTPLAN         = KF@PLN
179700110513     C                   EVAL      NTCOVTP        = KF@ENR
179800110513     C                   EVAL      NTTRST         = KF@TRS
179900110513     C                   EVAL      NTSUB#         = KF@SUB
180000110513     C                   EVAL      NTACCT         = KF@ACC
180100110513     C                   EVAL      NTTRANSDT      = #TODAY
180200160829     C                   WRITE     AET1051F
180300110513    ***
180400110513     C                   ENDSR
180500110513   S***S
180600110513     C     $HMOWRT       BEGSR
180700110513    ***
180800110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
180900110513     C                   EVAL      X@ELR = CPCID2                               FILE NUMBER
181000110513     C                   EVAL      M@CC = CACID2                                COMPANY CODE
181100110513     C                   EVAL      M@CLASS = CPCID3                             CLASS CODE
181200110513     C                   EVAL      M@PLAN = CPCID4                              PLAN NUMBER
181300110513    ***
181400110513     C                   EVAL      #XSX = M@FRM(M#CNE)
181500110725     C                   IF        WRT@TYPE = 'DEPEND' AND
181600110725     C                             #XSX < M@MBREFF
181700110725     C                   MOVE      M@MBREFF      X@EFF
181800110725     C                   ELSE
181900110725     C                   MOVE      #XSX          X@EFF
182000110725     C                   ENDIF
182100110513    ***
182200110513     C                   EVAL      #XSX = M@TRM(M#CNE)
182300110513     C                   IF        #XSX = 0 OR #XSX = 99999999
182400110513     C                   MOVE      *BLANKS       X@TRM
182500110513     C                   ELSE
182600160809     C****               MOVE      #XSX          X@TRM
182700160809       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
182800160809       if %subdt(work_date:*d) = 01 ;
182900160809        work_date -= %days(1) ;
183000160809        num_date = %dec(work_date:*iso);
183100160809        X@TRM = %EDITC(num_date:'X');
183200160809       endif;
183300160809
183400110513     C                   ENDIF
183500110513    ***
183600110513     C                   IF        WRT@TYPE = 'MEMBER'
183700110513     C                   EVAL      KF@SEQ = 0
183800110513     C                   EVAL      ENR@IN = M@ENR(M#CNE)
183900110513     C                   EXSR      $ENROLL
184000110513     C                   EVAL      X@TIER = ENR@OUT
184100110513     C                   ELSE
184200110513     C                   EVAL      X@TIER = *BLANKS
184300110513     C                   ENDIF
184400110513    ***
184500140313     C                   EVAL      KF@SPCD = 'MED'
184600140313     C                   EVAL      M@PCP = *BLANKS
184700140313     C                   EVAL      M@NPI = *BLANKS
184800140313     C                   EVAL      M@PCPCI = *BLANKS
184900140313    ***
185000140313     C                   EXSR      $PCP
185100140313    ***
185200140313     C                   IF        DOCTOR <> *BLANKS
185300140313     C                   EVAL      M@PCP = DOCTOR
185400140313     C                   EVAL      M@NPI = 'Y'
185500140313     C                   EVAL      M@PCPCI = '0'
185600140313     C                   ENDIF
185700110513    ***
185800110513     C                   EXCEPT    HMOF
185900110513    ***
186000110513     C                   ENDSR
186100110513   S***S
186200110513     C     $MEAWRT       BEGSR
186300110513    ***
186400110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
186500110513     C                   EVAL      X@ELR = CPCID2                               ELR
186600140313     C                   EVAL      E@SFX = CPCID3                               SUFFIX
186700140313     C                   EVAL      E@ACCT = CPCID4                              ACCOUNT
186800140313     C                   EVAL      E@PLAN = CPCID5                              PLAN
186900140313     C                   EVAL      E@CLM = CPCID6                               CLAIM OFFICE
187000110513    ***
187100110513     C                   EVAL      #XSX = M@FRM(M#CNE)
187200110725     C                   IF        WRT@TYPE = 'DEPEND' AND
187300110725     C                             #XSX < M@MBREFF
187400110725     C                   MOVE      M@MBREFF      X@EFF
187500110725     C                   ELSE
187600110725     C                   MOVE      #XSX          X@EFF
187700110725     C                   ENDIF
187800110513    ***
187900110513     C                   EVAL      #XSX = M@TRM(M#CNE)
188000110513     C                   IF        #XSX = 0 OR #XSX = 99999999
188100110513     C                   MOVE      *BLANKS       X@TRM
188200110513     C                   ELSE
188300160809     C****               MOVE      #XSX          X@TRM
188400160809       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
188500160809       if %subdt(work_date:*d) = 01 ;
188600160809        work_date -= %days(1) ;
188700160809        num_date = %dec(work_date:*iso);
188800160809        X@TRM = %EDITC(num_date:'X');
188900160809       endif;
189000160809
189100110513     C                   ENDIF
189200110513    ***
189300140313     C                   MOVE      *BLANKS       E@CBREXP
189400140313     C                   MOVE      *BLANKS       E@CBREVT
189500140313     C                   MOVE      *BLANKS       E@CBRLEN
189600140313     C                   IF        WRT@TYPE = 'MEMBER'
189700140425     C                   IF        EMPST = 'C' AND
189800140425     C                             CEXPDT > 0
189900140313     C                   MOVE      CEXPDT        E@CBREXP
190000140313     C                   MOVE      QEDT          E@CBREVT
190100140313     C                   MOVE      CEXPDT        #MINUEND
190200140313     C                   MOVE      QEDT          #SUBTRAEND
190300140313     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
190400140313     C                   Z-ADD     #DIFFRNC      #2S0
190500140313     C                   MOVE      #2S0          E@CBRLEN
190600140313     C                   ENDIF
190700140313     C                   ENDIF
190800140313    ***
190900140313     C                   EVAL      *IN80 = *OFF
191000140313     C                   EVAL      KF@SPCD = 'MED'
191100140313     C                   EVAL      E@PCP = *BLANKS
191200140313     C                   EXSR      $PCP
191300140313     C                   IF        DOCTOR <> *BLANKS
191400140313     C                   EVAL      E@PCP = DOCTOR
191500140313     C                   EVAL      *IN80 = *ON
191600140313     C                   ENDIF
191700140313    ***
191800161130       // if cobra and effective date > 12/01/2016...
191900170317       //if empst = 'C';
192000170317       // if e@cbrevt >= effectiveDate;
192100170317       //  e@cbrexp = ' ';
192200170317       //   e@cbrevt = ' ';
192300170317       //  e@cbrlen = ' ';
192400170317       // endif;
192500170317       //endif;
192600161130
192700140313     C                   EXCEPT    MEAF
192800110513    ***
192900110513     C                   ENDSR
193000110513   S***S
193100140313     C     $PCP          BEGSR
193200140313    ***
193300140313     C                   MOVE      *BLANKS       DOCTOR            7
193400140313     C     KL#SQPCD      CHAIN     PCPR
193500140313     C                   IF        NOT %FOUND(PCPL1)
193600140313     C                   LEAVESR
193700140313     C                   ENDIF
193800140313     C     KL#SQPCD      SETLL     PCPR
193900140313     C                   DOU       %EOF(PCPL1)
194000140313     C     KL#SQPCD      READE     PCPR
194100140313     C                   IF        NOT %EOF(PCPL1) AND PCCAN = 0
194200140313     C                   MOVEL(P)  PCID#         DOCTOR
194300140313     C                   LEAVESR
194400140313     C                   ENDIF
194500140313     C                   ENDDO
194600140313    ***
194700140313     C                   ENDSR
194800140313   S***S
194900110513     C     $CLRDCV       BEGSR
195000110513    ***
195100110513     C                   MOVE      *BLANKS       @LN
195200110513     C                   MOVEL     *BLANKS       @FN
195300110513     C                   EVAL      @SS2   = *BLANKS
195400110513     C                   EVAL      @MI    = *BLANKS
195500110513     C                   EVAL      @REL   = *BLANKS
195600110513     C                   EVAL      @SEX   = *BLANKS
195700110513     C                   EVAL      @DOB   = *BLANKS
195800110513     C                   EVAL      @SPEC  = *BLANKS
195900110513     C                   EVAL      @COB   = *BLANKS
196000110513     C                   EVAL      @COBC  = *BLANKS
196100110513     C                   EVAL      @COBN  = *BLANKS
196200110513    ***
196300110513     C                   EVAL      #CANCEL = 0
196400110513     C                   EVAL      D#CNE = 0
196500110513     C                   CLEAR                   D@PLN
196600110513     C                   CLEAR                   D@ENR
196700110513     C                   CLEAR                   D@FRM
196800110513     C                   CLEAR                   D@TRM
196900110513     C                   EVAL      M#CNE = 0
197000110513     C                   CLEAR                   M@PLN
197100110513     C                   CLEAR                   M@ENR
197200110513     C                   CLEAR                   M@FRM
197300110513     C                   CLEAR                   M@TRM
197400110513    ***
197500110513     C                   ENDSR
197600110513   S***S
197700110513     C     $DENWRT       BEGSR
197800110513    ***
197900110513    *C                   EVAL      X@LAY = CPCID1                               LAYOUT
198000110513    *C                   EVAL      X@ELR = CPCID2                               ELR
198100110513    *C                   EVAL      D@SFX = CPCID3                               SUFFIX
198200110513    *C                   EVAL      D@ACCT = CPCID4                              ACCOUNT
198300110513    *C                   EVAL      D@PLAN = CPCID5                              PLAN
198400110513    *C                   EVAL      D@CLM = CPCID6                               CLAIM OFFICE
198500110524     C                   EVAL      DNTLATE = '0'
198600110513    ***
198700110513    *C                   EVAL      #XSX = D@FRM(D#CNE)
198800110725     C                   IF        WRT@TYPE = 'DEPEND' AND
198900110725     C                             #XSX < D@MBREFF
199000110725     C                   MOVE      D@MBREFF      X@EFF
199100110725     C                   ELSE
199200110725     C                   MOVE      #XSX          X@EFF
199300110725     C                   ENDIF
199400110513    ***
199500110513    *C                   EVAL      #XSX = D@TRM(D#CNE)
199600110513    *C                   IF        #XSX = 0 OR #XSX = 99999999
199700110513    *C                   MOVE      *BLANKS       X@TRM
199800110513    *C                   ELSE
199900160809    *C****               MOVE      #XSX          X@TRM
200000160809       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
200100160809       if %subdt(work_date:*d) = 01 ;
200200160809        work_date -= %days(1) ;
200300160809        num_date = %dec(work_date:*iso);
200400160809        X@TRM = %EDITC(num_date:'X');
200500160809       endif;
200600160809
200700110513    *C                   ENDIF
200800110513    ***
200900130211     C                   MOVE      *BLANKS       D@CBREXP
201000130211     C                   MOVE      *BLANKS       D@CBREVT
201100130211     C                   MOVE      *BLANKS       D@CBRLEN
201200110513     C                   IF        WRT@TYPE = 'MEMBER'
201300111123    *C                   IF        EMPST = 'C' AND CEXPDT <> 0
201400110513    *C                   MOVE      CEXPDT        D@CBREXP
201500110513    *C                   MOVE      QEDT          D@CBREVT
201600110513    *C                   MOVE      CEXPDT        #MINUEND
201700110513    *C                   MOVE      QEDT          #SUBTRAEND
201800110513    *C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
201900110513    *C                   Z-ADD     #DIFFRNC      #2S0
202000110513    *C                   MOVE      #2S0          D@CBRLEN
202100110513    *C                   ENDIF
202200110513    *C                   ENDIF
202300120806    ***
202400110513    *C                   MOVE      '0'           D@OOAI
202500140313    ***
202600140313     C                   EVAL      KF@SPCD = 'DEN'
202700140313     C                   EVAL      D@PCD = *BLANKS
202800140313     C                   EVAL      *IN81 = *OFF
202900140313     C                   MOVE      *BLANKS       DOCTOR
203000140313    ***
203100140313     C                   EXSR      $PCP
203200140313    ***
203300140313     C                   IF        DOCTOR <> *BLANKS
203400140313     C                   EVAL      D@PCD = DOCTOR
203500140313     C                   EVAL      *IN81 = *ON
203600140313     C                   ENDIF
203700110513    ***
203800120123     C     *LIKE         DEFINE    H@C#          BUC#
203900120123     C                   EVAL      BUC# = H@C#
204000120123    ***
204100151106     C                   if        cacid8 > ' ' and cacid8 <> 'N/A'
204200151106     C                   eval      h@c# = cacid8
204300151106     C                   endif
204400151106
204500120327     C                   SELECT
204600151106     C****               WHEN      KF@TRS = 591 AND KF@SUB = 009 AND            WILMOT MODULAR
204700151106     C****                         KF@ACC = 0202                                 STRUCTURES
204800151106     C****               EVAL      H@C# = '0638156'
204900151106
205000151106     C****               WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            REDLAND
205100151106     C****                         KF@ACC = 0475                                 BAPTISTS
205200151106     C****               EVAL      H@C# = '0725572'
205300151106
205400151106     C****               WHEN      KF@TRS = 825 AND KF@SUB = 001 AND            CREATIVE
205500151106     C****                         KF@ACC = 0014                                 LOGISTICS
205600151106     C****               EVAL      H@C# = '0133860'
205700151106
205800151015     C****               WHEN      KF@TRS = 905 AND KF@SUB = 001 AND            CCL USA
205900151015     C****                         KF@ACC = 0092
206000151015     C****               EVAL      H@C# = '0638423'
206100151106
206200151106     C****               WHEN      KF@TRS = 003 AND KF@SUB = 001 AND            FRAME RITE
206300151106     C****                         KF@ACC = 0104
206400151106     C****               EVAL      H@C# = '0306511'
206500151106
206600151106     C****               WHEN      KF@TRS = 900 AND KF@SUB = 003 AND            PERFECT
206700151106     C****                         KF@ACC = 0045                                 SETTINGS
206800151106     C****               EVAL      H@C# = '0474109'
206900151106
207000151106     C****               WHEN      KF@TRS = 591 AND KF@SUB = 011 AND            MCCALLISTER
207100151106     C****                         KF@ACC = 0446                                 ARCHITECT
207200151106     C****               EVAL      H@C# = '0565330'
207300151106
207400151106     C****               WHEN      KF@TRS = 591 AND KF@SUB = 005 AND            JD CLARK PROF
207500151106     C****                         KF@ACC = 0451                                 SERVICES
207600151106     C****               EVAL      H@C# = '0519890'
207700151106
207800151106     C****               WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            DYSON CONSTRUCTION
207900151106     C****                         KF@ACC = 0459                                 COMPANY
208000151106     C****               EVAL      H@C# = '0788122'
208100151106
208200151106     C****               WHEN      KF@TRS = 591 AND KF@SUB = 004 AND            STROUSE CORP
208300151106     C****                         KF@ACC = 0482
208400151106     C****               EVAL      H@C# = '0837451'
208500151106
208600151106     C****               WHEN      KF@TRS = 900 AND KF@SUB = 007 AND            CAPLAN BROTHERS
208700151106     C****                         KF@ACC = 0075
208800151106     C****               EVAL      H@C# = '0837533'
208900151106
209000151106     C****               WHEN      KF@TRS = 900 AND KF@SUB = 101 AND            INTEGRA HEALTH
209100151106     C****                         KF@ACC = 0042 AND
209200151106     C****                         (STATE = 'TN' OR STATE = 'FL' OR
209300151106     C****                          STATE = 'OH' OR STATE = 'MA') AND
209400151106     C****                         (@PLANIN = 'DAAD' OR @PLANIN = 'BAAD')
209500151106     C****               EVAL      H@C# = '0503428'
209600120123    ***
209700151106     C****               WHEN      KF@TRS = 905 AND KF@SUB = 001 AND            CCL USA
209800151106     C****                         KF@ACC = 0092
209900151106     C****               eval      x@eff =  '20150901'
210000151106     C****               EVAL      H@C# = '0536514'
210100151106      ****
210200151106    *C                   ENDSL
210300151015
210400161130       // if cobra and effective date > 12/01/2016...
210500170317       //if empst = 'C';
210600170317       // if d@cbrevt >= effectiveDate;
210700170317       //  d@cbrexp = ' ';
210800170317       //   d@cbrevt = ' ';
210900170317       //  d@cbrlen = ' ';
211000170317       // endif;
211100170317       //endif;
211200161130
211300110513    *C                   EXCEPT    DENF
211400120123     C                   EVAL      H@C# = BUC#
211500110513    ***
211600110513    *C                   ENDSR
211700110513   S***S
211800110512   X***X
211900160914     OAET1050WFVEADD         HDRF
212000101203     O                                            6 'HEADER'
212100101229     O                                            8 'P'
212200101206     O                       H@SI                28
212300101203     O                                           29 '0'
212400101203     O                       C1                  43
212500101203     O                       D1                  51
212600101203     O                       T1                  57
212700101206     O                                          131 'CONSOLIDATED ELIGIBILITY'
212800110502     O                       H@RI               167
212900101206     O                       H@CC               169
213000101228     O                       H@GN               176
213100101206     O                       H@CN               191
213200101206     O                       H@C#               198
213300101203     O                       D2                 206
213400110825     O                                          216 'MC'
213500101223     O                                          231 '*'
213600160914     OAET1050WFVEADD         MBRF
213700101203     O                                            6 'MEMBER'
213800101203     O                       @SS1                16
213900101203     O                       @SS2                25
214000101203     O                       @FN                 75
214100101203     O                       @MI                 76
214200101203     O                       @LN                 96
214300101203     O                       @REL               101
214400101203     O                       @SEX               103
214500101203     O                       @DOB               111
214600101203     O                       @SPEC              112
214700101203     O                                          113 '0'
214800101203     O                       @COB               123
214900101203     O                       @COBC              125
215000101203     O                       @COBN              145
215100101203     O                       @AD1               175
215200101203     O                       @AD2               205
215300101203     O                       @CTY               315
215400101203     O                       @ST                317
215500101203     O                       @ZP5               322
215600101203     O                       @PHN               349
215700141211     O               87                         576 '21207'
215800140626     O               88                         576 '21740'
215900141120     O               89                         576 '20171'
216000101203     O                       @EMPST             665
216100101203     O                       @HIRE              673
216200101223     O                                         1231 '*'
216300160914     OAET1050WFVEADD         HMOF
216400101213     O                                            7 'BENEFIT'
216500101213     O                       X@LAY               10
216600101214     O                       X@ELR               24
216700101213     O                       M@CC                26
216800101213     O                       H@GN                38
216900101213     O                       M@CLASS             44
217000101213     O                       M@PLAN              50
217100101213     O                       X@EFF               58
217200110929     O                       X@TRM               66
217300101213     O                       X@TIER              69
217400101213     O                       M@PCP              160
217500101213     O                       M@NPI              161
217600101213     O                       M@PCPCI            186
217700101223     O                                          323 '*'
217800160914     OAET1050WFVEADD         MEAF
217900140313     O                                            7 'BENEFIT'
218000160601     O                                           10 'VIS'
218100140313     O                       X@ELR               24
218200140313     O                       H@C#                31
218300140313     O                       E@SFX               34
218400140313     O                       E@ACCT              44
218500140313     O                       E@PLAN              50
218600140313     O                       X@EFF               58
218700140313     O                       X@TRM               66
218800140313     O                       E@CLM               71
218900140313     *** PCP BGN
219000140313     O                       E@PCP              127
219100140313     O               80                         161 'N'
219200140313     O               80                         186 '0'
219300140313     *** PCP END
219400140313     O                                          389 '0'
219500140313     *** COBRA BGN
219600140313     O                       E@CBREXP           466
219700140313     O                       E@CBREVT           516
219800140313     O                       E@CBRLEN           560
219900140313     *** COBRA END
220000140313     O                                          678 '*'
220100140313    ***
220200160914     OAET1050WFVEADD         DENF
220300101213     O                                            7 'BENEFIT'
220400101213     O                       X@LAY               10
220500101214     O                       X@ELR               24
220600101214     O                       H@C#                31
220700101213     O                       D@SFX               34
220800101213     O                       D@ACCT              44
220900101213     O                       D@PLAN              50
221000101213     O                       X@EFF               58
221100110929     O                       X@TRM               66
221200101213     O                       D@CLM               71
221300140313     *** PCD BGN
221400140313     O                       D@PCD              200
221500140313     O               81                         236 '0'
221600140313     *** PCD END
221700140313     O                                          389 '0'
221800140313     *** COBRA BGN
221900140313     O                       D@CBREXP           466
222000140313     O                       D@CBREVT           516
222100140313     O                       D@CBRLEN           560
222200140313     *** COBRA END
222300140313     O                       D@OOAI             609
222400140313     O                                          678 '*'
222500140313    ***
222600160914     OAET1050WFVEADD         LIFF
222700130315     O                                            7 'BENEFIT'
222800130412     O                                           11 'LIFE'
222900130315     O                       X@ELR               24
223000130319     O                       H@C#3               31
223100130315     O                       L@SFX               34
223200130315     O                       L@ACCT              44
223300130315     O                       L@PLAN              50
223400130315     O                       X@EFF               58
223500130315     O                       X@TRM               66
223600130315     O                       L@CLM               71
223700130315     O                       L@CBREXP           466
223800130315     O                       L@CBREVT           516
223900130315     O                       L@CBRLEN           560
224000130315     O                       L@SALARY           658
224100130315     O                                          659 '1'
224200130315     O                                          678 '*'
224300160914     OAET1050WFVEADD         TRLF
224400101203     O                                            7 'TRAILER'
224500160914     O****                   @TREC               17
224600101203     O                       D1                  25
224700101203     O                       T1                  31
224800160914     O****                   @BREC               41
224900160914     O****                                       69 '*'
