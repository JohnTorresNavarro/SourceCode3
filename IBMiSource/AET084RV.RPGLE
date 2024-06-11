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
003101200124   X* *             when dental.
003102200124      *
003103200124      *  01/24/2020  JT  Cleaned up a little bit of this mess
003104200124
003105221118      *  01/01/2022  jt  Do not substract 1 if enroll and terml are the same.
003106200124      *=============================================================================================
003107200124
003300101206   X***X
003400130315     F*CARXPTP   IF   E           K DISK
003500101012     FCARACCP   IF   E           K DISK
003600101012     FCARPLNP   IF   E           K DISK
003700101012   X***X
003800120803     FAET001WF  IF   E           K DISK
003900120803     ** MAPPING METHOD
004000110802     FAET080WF  O  A F 1231        DISK
004100101206     ** FLAT FILE
004200110802     FAET081WF  IF A E           K DISK
004300101028     ** TERM TRACKER
004400101028     **
004500101012     FMEMAC#1   IF   E           K DISK
004600101012     FMCOVMPLN  IF   E           K DISK
004700101012     FDEPNDC    IF   E           K DISK
004800101012     FDCOVA     IF   E           K DISK
004900140313     FPCPL1     IF   E           K DISK
005000101012   X***X
005100120803     D KF@CCTL         S             10A   INZ
005200130521     D CARR#CTL        S             10A   INZ('0000000011')
005300120815     D*CARR#CTL2       S             10A   INZ('0000000051')
005400110512     D H@RI            S             25A   INZ('042064683')                     RECEIVER ID
005500110512   X***X
005600110512     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
005700101026     D DS@CARACC     E DS                  EXTNAME(CARACCP)
005800130315     D*DS@CARXPT     E DS                  EXTNAME(CARXPTP)
005900101026   X***X
006000110512     ** WORK ARRAY FOR PLANS
006100110512     **
006200110512     ** PC# - PLAN COUNT
006300110512     ** PP# - PLAN POINTER
006400110512     **
006500110512     D CARPLN@       E DS                  EXTNAME(CARPLNP)
006600160902     D                                     OCCURS(900) PREFIX(X:1)
006700110512     D PC#             S              3S 0
006800110512     D PP#             S              3S 0
006900110512     D @PLANIN         S              4A
007000110512     D @CCTRIN         S              3A
007100110513   X***X
007200110513     **
007300110513     ** WRITE TYPE = MEMBER OR DEPEND
007400110513     D WRT@TYPE        S              6A
007500110513     **
007600110512   X***X
007700101214     D #XST            S              6S 0
007800101214     D #IST            S               T
007900101026     D #ISO            S               D   DATFMT(*ISO)
008000101214     D #MINUEND        S               D   DATFMT(*ISO)
008100101214     D #SUBTRAEND      S               D   DATFMT(*ISO)
008200101214     D @DATE           S              8A
008300101214     D @TIME           S              6A
008400101214     D #DIFFRNC        S              5S 0
008500101214     D #2S0            S              2S 0
008600101214     D #CANCEL         S              8S 0
008700101026     D #XSX            S              8S 0
008800101026     D #XSX2           S              8S 0
008900101026     D DATE@OUT        S             10A
009000101026     D ENR@IN          S              3A
009100101026     D ENR@OUT         S              1A
009200110524     D DNTLATE         S              1A
009300130315     D TERM_LIF        S               N
009400101214     D TERM_DEN        S               N
009500101214     D TERM_MED        S               N
009600101026     D YES             S               N   INZ(*ON)
009700101026     D NO              S               N   INZ(*OFF)
009800140313     **
009900110512     D KF@TRS          S                   LIKE(MCTRST)
010000110512     D KF@SUB          S                   LIKE(MCSUB#)
010100110512     D KF@ACC          S                   LIKE(ACC#)
010200101026     D KF@ENR          S              3A   INZ
010300101026     D KF@CARG         S              2A   INZ
010400101026     D KF@CCTR         S                   LIKE(CCFLG)
010500101026     D KF@PLN          S                   LIKE(MCPLAN)
010600101026     D KF@TRM          S                   LIKE(NTTERMDT)
010700101026     D KF#TRM          S              8S 0
010800101026     D KF@SSN          S                   LIKE(MBSSNO)
010900101026     D KF@SEQ          S                   LIKE(DPSEQ#)
011000101026     D KF@TYP          S              1A
011100101026     D KF@CDE          S              2A
011200140313     D KF@SPCD         S              5A
011300140313     D KF@MPLN         S              4A
011400140313     **
011500101026     D M@EARLYP        S              4A
011600101026     D M#EARLYE        S              8S 0 INZ
011700101026     D M#EARLYT        S              8S 0 INZ
011800140313     **
011900101026     D #8D1            S              8S 0 INZ
012000101214     D D1              S              8A
012100101214     D D2              S              8A
012200101214     D T1              S              6A
012300101214     D C1              S             14A
012400101206    ***
012500101029     D B#RECCNT        S             10S 0 INZ
012600101029     D C#RECCNT        S             10S 0 INZ
012700101206    ***
012800101210     D @SS1            S              9A
012900101210     D @SS2            S              9A
013000101210     D @FN             S             15A
013100101210     D @MI             S              1A
013200101210     D @LN             S             20A
013300101210     D @REL            S              2A
013400101210     D @SEX            S              1A
013500101210     D @DOB            S              8A
013600101210     D @SPEC           S              1A
013700101210     D @COB            S              1A
013800101210     D @COBC           S              2A
013900101210     D @COBN           S             20A
014000101210     D @AD1            S             30A
014100101210     D @AD2            S             30A
014200101214     D @CTY            S             20A
014300101210     D @ST             S              2A
014400101210     D @ZP5            S              5A
014500101210     D @PHN            S             10A
014600101210     D @EMPST          S              2A
014700101210     D @HIRE           S              8A
014800101206    ***
014900130315    *** LIFE ARRAYS
015000130315     D L#CNE           S              3S 0 INZ
015100130315     D L#NDX           S              3S 0 INZ
015200130315     D L@PLN           S              4A   DIM(20)
015300130315     D L@ENR           S              3A   DIM(20)
015400130315     D L@FRM           S              8S 0 DIM(20)
015500130315     D L@TRM           S              8S 0 DIM(20)
015600130315     D L@MBREFF        S              8S 0
015700140313    ***
015800101206    *** DENTAL ARRAYS
015900101206     D D#CNE           S              3S 0 INZ
016000101206     D D#NDX           S              3S 0 INZ
016100101206     D D@PLN           S              4A   DIM(20)
016200101206     D D@ENR           S              3A   DIM(20)
016300101206     D D@FRM           S              8S 0 DIM(20)
016400101206     D D@TRM           S              8S 0 DIM(20)
016500110725     D D@MBREFF        S              8S 0
016600140313    ***
016700101206    *** MEDICAL ARRAYS
016800101206     D M#CNE           S              3S 0 INZ
016900101206     D M#NDX           S              3S 0 INZ
017000101206     D M@PLN           S              4A   DIM(20)
017100101206     D M@ENR           S              3A   DIM(20)
017200101206     D M@FRM           S              8S 0 DIM(20)
017300101206     D M@TRM           S              8S 0 DIM(20)
017400110725     D M@MBREFF        S              8S 0
017500101206    ***
017600101206     D H@SI            S             20A
017700101206     D H@CC            S              2A
017800101206     D H@GN            S              7A
017900101206     D H@CN            S             15A
018000101206     D H@C#            S              7A
018100130319     D H@C#3           S              7A
018200140313    ***
018300101213     D X@LAY           S              3A
018400101213     D X@ELR           S              7A
018500140313     D X@EFF           S              8A
018600140313     D X@TRM           S              8A
018700140313     D X@TIER          S              1A
018800140313    ***
018900101213     D M@CC            S              2A
019000101213     D M@CLASS         S              5A
019100101213     D M@PLAN          S              6A
019200101213     D M@PCP           S             40A
019300101213     D M@NPI           S              1A
019400101213     D M@PCPCI         S              1A
019500140313    ***
019600101213     D D@SFX           S              3A
019700101213     D D@ACCT          S              5A
019800101213     D D@PLAN          S              6A
019900101213     D D@CLM           S              3A
020000101213     D D@CBREXP        S              8A
020100101213     D D@CBREVT        S              8A
020200101213     D D@CBRLEN        S              2A
020300101213     D D@OOAI          S              1A
020400140313     D D@PCD           S              7A
020500140313    ***
020600101214     D @STEP           S              5A
020700140313    ***
020800140313     D E@SFX           S              3A
020900140313     D E@ACCT          S              5A
021000140313     D E@PLAN          S              6A
021100140313     D E@CLM           S              3A
021200140313     D E@PCP           S              7A
021300140313     D E@CBREXP        S              8A
021400140313     D E@CBREVT        S              8A
021500140313     D E@CBRLEN        S              2A
021600140313    ***
021700130315     D L@SFX           S              3A
021800130315     D L@ACCT          S              5A
021900130315     D L@PLAN          S              6A
022000130315     D L@CLM           S              3A
022100130315     D L@CBREXP        S              8A
022200130315     D L@CBREVT        S              8A
022300130315     D L@CBRLEN        S              2A
022400130315     D L@SALARY        S             20A
022500140313    ***
022600160809    ***
022700160809     d num_date        s              8s 0 inz
022800160809     D work_date       s               d
022801221108     d edate           s              8  0
022802221108     d tdate           s              8  0
022803221108
022900101026   X***X
023000110512     C                   EVAL      @STEP = 'PREP1'
023100101214    ***
023200120803     C                   EVAL      KF@CCTL = CARR#CTL
023300130315     C*    KF@CCTL       CHAIN     CARXPTR
023400110802     C                   EXSR      $HEADR
023500110512    ***
023600120803     C     KF@CCTL       SETLL     CARACCR
023700110512    ***
023800101026     C                   DOU       @STEP = 'LEAVE'
023900101026     C     @STEP         CASEQ     'PREP1'       $PREP1
024000101026     C     @STEP         CASEQ     'STEP1'       $STEP1
024100101026     C     @STEP         CASEQ     'STEP2'       $STEP2
024200101026     C     @STEP         CASEQ     'STEP3'       $STEP3
024300101026     C     @STEP         CASEQ     'PREP4'       $PREP4
024400101026     C     @STEP         CASEQ     'STEP4'       $STEP4
024500101026     C     @STEP         CASEQ     'PREP5'       $PREP5
024600101026     C     @STEP         CASEQ     'STEP5'       $STEP5
024700101214     C     @STEP         CASEQ     'PREP6'       $PREP6
024800101026     C     @STEP         CASEQ     'STEP6'       $STEP6
024900101214     C     @STEP         CASEQ     'PREP7'       $PREP7
025000101214     C     @STEP         CASEQ     'STEP7'       $STEP7
025100101214     C     @STEP         CASEQ     'STEP8'       $STEP8
025200101214     C     @STEP         CASEQ     'PREP9'       $PREP9
025300101214     C     @STEP         CASEQ     'STEP9'       $STEP9
025400101214     C     @STEP         CASEQ     'PREPA'       $PREPA
025500101214     C     @STEP         CASEQ     'STEPA'       $STEPA
025600101214     C     @STEP         CASEQ     'PREPB'       $PREPB
025700101214     C     @STEP         CASEQ     'STEPB'       $STEPB
025800130315     C     @STEP         CASEQ     'PREPC'       $PREPC
025900130315     C     @STEP         CASEQ     'STEPC'       $STEPC
026000101026     C                   ENDCS
026100101026     C                   ENDDO
026200120711    ***
026300120711    ***  CALL SECOND PROGRAM
026400120711    ***
026500120803    *C*                  MOVE      *ALL'0'       @TADD            10
026600120803    *C*                  MOVE      *ALL'0'       @BADD            10
026700120803    *C*                  CALL      'AET081CL'
026800120803    *C*                  PARM                    @TADD
026900120803    *C*                  PARM                    @BADD
027000120803    *C*                  MOVE      @TADD         #TADD            10 0
027100120803    *C*                  ADD       #TADD         C#RECCNT
027200120803    *C*                  MOVE      @BADD         #BADD            10 0
027300120803    *C*                  ADD       #BADD         B#RECCNT
027400120711    ***
027500101206    ***  TRAILER RECORD
027600120711    ***
027700101026     C                   ADD       2             C#RECCNT
027800101214     C                   MOVE      C#RECCNT      @TREC            10 0
027900101214     C                   MOVE      B#RECCNT      @BREC            10 0
028000101214     C                   EXCEPT    TRLF
028100101026    ***
028200101026     C                   EVAL      *INLR = *ON
028300110512   S***S
028400110802     C     $HEADR        BEGSR
028500101206    ***
028600110802     C                   EVAL      D1 = @DATE
028700110802     C                   EVAL      D2 = @DATE
028800110802     C                   EVAL      T1 = @TIME
028900110802     C                   EVAL      C1 = @DATE + @TIME
029000110802    ***
029100110802     C                   EVAL      KF@TRS = 999
029200110802     C                   EVAL      KF@SUB = 999
029300110802     C                   EVAL      KF@ACC = 9999
029400110802     C     KL#ACCTL      CHAIN     CARACCR
029500110802    ***
029600110802     C                   EVAL      H@SI = %TRIM(CACID1)                         SUBMITTER ID
029700110802     C                   EVAL      H@CC = %SUBST(CACID2:1:2)                    COMPANY CODE
029800110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
029900110802     C                   MOVEL(P)  CACID4        H@CN                           CUSTOMER NAME
030000200124     C                   MOVEL(P)  CACID4        H@C#                           CUSTOMER #
030100130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
030200110802    ***
030300110802     C                   EXCEPT    HDRF
030400110802    ***
030500110802     C                   ENDSR
030600110802   S***S
030700110802     C     $PREP1        BEGSR
030800110802    ***
030900120803     C     KF@CCTL       READE     CARACCR
031000110512    ***
031100110512     C                   IF        %EOF(CARACCP)
031200120803      *
031300120815     C*                  IF        KF@CCTL = CARR#CTL
031400120815     C*                  EVAL      KF@CCTL = CARR#CTL2
031500120815     C*    KF@CCTL       SETLL     CARACCR
031600120815     C*                  ELSE
031700110512     C                   EVAL      @STEP = 'LEAVE'
031800120815     C*                  ENDIF
031900120803      *
032000110512     C                   LEAVESR
032100110512     C                   ENDIF
032200110512    ***
032300110513    *** HAS THE ACCOUNT BEEN SHUTOFF FOR EXPORT?
032400110513    ***
032500110512     C                   IF        CASTATUS <> 'Y'
032600110512     C                   LEAVESR
032700110512     C                   ENDIF
032800110512    ***
032900110802    *** THESE FIELDS RESET FOR EACH SMALL GROUP READ
033000110802    ***
033100110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
033200200124     C                   MOVEL(P)  CACID4        H@C#                           CUSTOMER #
033300130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
033400110802    ***
033500110512     C                   EVAL      KF@TRS = CATRST
033600110512     C                   EVAL      KF@SUB = CASUB#
033700110512     C                   EVAL      KF@ACC = CAACCT
033800110512    ***
033900110512     C                   EXSR      $PLANLOAD
034000110512    ***
034100101206     C                   EVAL      @STEP = 'STEP1'
034200110512    ***
034300110512     C                   ENDSR
034400110512   S***S
034500101206     C     $STEP1        BEGSR
034600101206    ***
034700101206     C                   EVAL      KF@PLN = *BLANKS
034800101206     C                   EVAL      KF@TRM = 0
034900101206     C                   EVAL      KF@SSN = 0
035000101206     C                   EVAL      KF@SEQ = 0
035100110512    ***
035200101206     C     KL#TSA        SETLL     MEMBR
035300101206    ***
035400101206     C                   EVAL      @STEP = 'STEP2'
035500101206    ***
035600101206     C                   ENDSR
035700101206   S***S
035800101206     C     $STEP2        BEGSR
035900101206    ***
036000101206     C     KL#TSA        READE     MEMBR
036100101206    ***
036200101206     C                   IF        %EOF(MEMAC#1)
036300110512     C                   EVAL      @STEP = 'PREP1'
036400101206     C                   LEAVESR
036500101206     C                   ENDIF
036600101206    ***
036700101206     C                   EVAL      KF@SSN = MBSSNO
036800101214     C                   MOVE      *ZEROS        KF@SEQ
036900120803     C                   EVAL      WRT@TYPE = 'MEMBER'
037000120803    ***
037100101214    ***
037200101206     C     KL#MPLN       SETLL     MCOVR
037300101206    ***
037400101206     C                   EXSR      $CLRSTG
037500101206    ***
037600101206     C                   EVAL      @STEP = 'STEP3'
037700101206    ***
037800101206     C                   ENDSR
037900101210   S***S
038000101206     C     $STEP3        BEGSR
038100101206    ***
038200101206     C     KL#MPLN       READE     MCOVR
038300101206    ***
038400101206     C                   IF        %EOF(MCOVMPLN)
038500101206     C                   EVAL      @STEP = 'PREP4'
038600101206     C                   LEAVESR
038700101206     C                   ENDIF
038800101206    ***
038900130131     C*                  IF        ENRLDT = CANDT
039000130131     C*                  LEAVESR
039100130131     C*                  ENDIF
039200120803    ***
039300120803     C                   EVAL      KF@PLN = MCPLAN
039400120803     C     KL#TSAP       CHAIN     AEF01
039500120803     C                   IF        NOT %FOUND(AET001WF)
039600120803     C                   LEAVESR
039700120803     C                   ENDIF
039800110513    ***
039900110512     C                   EVAL      @PLANIN = MCPLAN
040000111020     C                   EVAL      ENR@IN = MCOVTP
040100110802    ***
040200110802     C                   EXSR      $QUIK
040300110802    ***
040400110512     C                   EXSR      $PLANSRCH
040500110512    ***
040600110512     C                   IF        PLN@CAT = *BLANKS
040700110512     C                   LEAVESR
040800110512     C                   ENDIF
040900101206    ***
041000101206     C                   IF        CANDT = 0
041100101206     C                   EVAL      #CANCEL = 99999999
041200101206     C                   ELSE
041300101206     C                   EVAL      #CANCEL = CANDT
041400101206     C                   ENDIF
041500101206    ***
041600130315    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL;
041700130315    *** LIF IS LIFE;
041800110513    ***
041900130315     C                   SELECT
042000130315      *
042100160224    *C****               WHEN      PLN@CAT = 'LIFE'
042200160224    *C****               IF        L#CNE > 0
042300160224    *C****               IF        L@TRM(L#CNE) = 99999999
042400160224     C****               LEAVESR
042500160224     C****               ENDIF
042600160224     C****               ENDIF
042700160224    *C****               ADD       1             L#CNE
042800160224    *C****               EVAL      L@PLN(L#CNE) = MCPLAN
042900160224    *C****               EVAL      L@ENR(L#CNE) = MCOVTP
043000160224    *C****               EVAL      L@FRM(L#CNE) = ENRLDT
043100160224    *C****               EVAL      L@TRM(L#CNE) = #CANCEL
043200130315      *
043300160224    *C****               WHEN      PLN@CAT = 'DEN'
043400160224    *C****               IF        D#CNE > 0
043500160224    *C****               IF        D@TRM(D#CNE) = 99999999
043600160224     C****               LEAVESR
043700160224     C****               ENDIF
043800160224     C****               ENDIF
043900160224    *C****               ADD       1             D#CNE
044000160224    *C****               EVAL      D@PLN(D#CNE) = MCPLAN
044100160224    *C****               EVAL      D@ENR(D#CNE) = MCOVTP
044200160224    *C****               EVAL      D@FRM(D#CNE) = ENRLDT
044300160224    *C****               EVAL      D@TRM(D#CNE) = #CANCEL
044400160224      ****
044500160224    *C                   WHEN      PLN@CAT = 'VIS '
044600160224    *C                   IF        M#CNE > 0
044700160224    *C                   IF        M@TRM(M#CNE) = 99999999
044800160224     C                   LEAVESR
044900160224     C                   ENDIF
045000160224     C                   ENDIF
045100160224     C                   ADD       1             M#CNE
045200160224     C                   EVAL      M@PLN(M#CNE) = MCPLAN
045300101206     C                   EVAL      M@ENR(M#CNE) = MCOVTP
045400101206     C                   EVAL      M@FRM(M#CNE) = ENRLDT
045500101206     C                   EVAL      M@TRM(M#CNE) = #CANCEL
045600130315      *
045700130315    *C                   ENDSL
045800110512    ***
045900110512     C                   ENDSR
046000110512   S***S
046100110802     C     $QUIK         BEGSR
046200110802    ***
046300110805     C                   EVAL      @CCTRIN = *BLANKS
046400120803    ***
046500120803     C     AE1MAP        CASEQ     '2TIER     '  $METH01
046600120803     C     AE1MAP        CASEQ     'ITOBJECTS '  $METH02
046700120803     C     AE1MAP        CASEQ     'NORULE    '  $METH03
046800120803     C     AE1MAP        CASEQ     'STATETIER '  $METH04
046900120803     C     AE1MAP        CASEQ     'TIERSTS   '  $METH05
047000120803     C     AE1MAP        CASEQ     'MAYOR     '  $METH06
047100120803     C     AE1MAP        CASEQ     'EMPSTS    '  $METH07
047200120803     C     AE1MAP        CASEQ     'JUSTSTATE '  $METH08
047300120803     C     AE1MAP        CASEQ     'JOHNLS    '  $METH09
047400120803     C     AE1MAP        CASEQ     'CREATIVE  '  $METH10
047500120803     C     AE1MAP        CASEQ     'INTEGRA   '  $METH11
047600120803     C     AE1MAP        CASEQ     'STSTATE   '  $METH12
047700130123     C     AE1MAP        CASEQ     'INTEGRA   '  $METH11
047800130123     C     AE1MAP        CASEQ     'STIERSTS  '  $METH13
047900120803     C                   ENDCS
048000120803    ***
048100120803     C                   ENDSR
048200120803   S***S
048300120803    *** 2 TIER = AETNA HAS TWO TIERS, IND AND FAM
048400120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'IND' AND NON-'TIN' CONVERTED TO 'FAM'
048500120803    ***  DEPENDENTS HAVE 'FAM' ONLY
048600120803    ***
048700120803    *** IND, FAM
048800120803    ***
048900120803     C     $METH01       BEGSR
049000120803    ***
049100120803     C                   IF        WRT@TYPE = 'MEMBER'
049200120803    *** *
049300120803     C                   IF        ENR@IN = 'TIN'
049400120803     C                   EVAL      @CCTRIN = 'IND'
049500120803     C                   ELSE
049600120803     C                   EVAL      @CCTRIN = 'FAM'
049700120803     C                   ENDIF
049800120803    *** *
049900120803     C                   ENDIF
050000120803    ***
050100120803     C                   IF        WRT@TYPE = 'DEPEND'
050200120803    *** *
050300120803     C                   EVAL      @CCTRIN = 'FAM'
050400120803    *** *
050500120803     C                   ENDIF
050600120803    ***
050700120803     C                   ENDSR
050800120803   S***S
050900120803    *** ITOBJECTS = IF YOU ARE NOT 'VA' OR 'OH' STATE CODES, YOU ARE 'XX'
051000120803    ***
051100120803    *** VA, OH, XX
051200120803    ***
051300120803     C     $METH02       BEGSR
051400120803    ***
051500120803     C                   IF        STATE <> 'VA' AND STATE <> 'OH'
051600120803     C                   EVAL      @CCTRIN = 'XX '
051700120803     C                   ELSE
051800120803     C                   EVAL      @CCTRIN = STATE
051900120803     C                   ENDIF
052000120803    ***
052100120803     C                   ENDSR
052200120803   S***S
052300120803    *** NORULE = NUFF SAID
052400120803    ***
052500120803     C     $METH03       BEGSR
052600120803    ***
052700120803     C                   EVAL      @CCTRIN = *BLANKS
052800120803    ***
052900120803     C                   ENDSR
053000120803   S***S
053100120803    *** STATETIER
053200120803    ***  START WITH STATE CODE
053300120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
053400120803    ***  DEPENDENTS HAVE 'F' ONLY
053500120803    ***
053600120803    *** MDI, MDF, ETC...
053700120803    ***
053800120803     C     $METH04       BEGSR
053900120803    ***
054000120803     C                   EVAL      @CCTRIN = STATE
054100120803    ***
054200120803     C                   IF        WRT@TYPE = 'MEMBER'
054300120803     C                   IF        ENR@IN = 'TIN'
054400120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
054500120803     C                   ELSE
054600120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
054700120803     C                   ENDIF
054800120803     C                   ENDIF
054900120803    ***
055000120803     C                   IF        WRT@TYPE = 'DEPEND'
055100120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
055200120803     C                   ENDIF
055300120803    ***
055400120803     C                   ENDSR
055500120803   S***S
055600120803    *** TIERSTS
055700120803    ***  START WITH EMPLOYMENT STATUS, ACTIVE IS 'ACT' AND COBRA IS 'COB'
055800120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
055900120803    ***  DEPENDENTS HAVE 'F' ONLY
056000120803    ***
056100120803    *** ACI, ACF, COI, COF
056200120803    ***
056300120803     C     $METH05       BEGSR
056400120803    ***
056500120803     C                   IF        EMPST =  'C'
056600120803     C                   EVAL      @CCTRIN = 'COB'
056700120803     C                   ELSE
056800120803     C                   EVAL      @CCTRIN = 'ACT'
056900120803     C                   ENDIF
057000120803    ***
057100120803     C                   IF        ENR@IN = 'TIN'
057200120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
057300120803     C                   ELSE
057400120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
057500120803     C                   ENDIF
057600120803    ***
057700120803     C                   ENDSR
057800120803   S***S
057900120803    *** MAYOR
058000120803    ***  WELL, FOR THE PLAN 'DAAU' IF THE STATE IS 'WV' THEN PLACE TIER STATUS SUFFIX
058100120803    ***       BY TYPE OF PEEP; FOR OTHER STATES, USE A SIMPLE TIER CHECK.
058200120803    ***
058300120803    ***  WVI, WVF, IND, FAM
058400120803    ***
058500120803    ***  NOW, FOR THE PLAN 'DAAT' IF THE STATE IS 'WV' THEN PLACE EMPLOYMENT STATUS SUFFIX
058600120803    ***       BY TYPE OF PEEP; FOR OTHER STATES, EMPLOYMENT STATUS AND TIER.
058700120803    ***
058800120803    ***  WVI, WVF, CBI, CBF, ACI, ACF
058900120803    ***
059000120803    ***
059100120803     C     $METH06       BEGSR
059200120803    ***
059300120803    1C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'MEMBER'
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
060500120803    3C                   IF        ENR@IN = 'TIN'
060600120803     C                   EVAL      @CCTRIN = 'IND'
060700120803    3C                   ELSE
060800120803     C                   EVAL      @CCTRIN = 'FAM'
060900120803    3C                   ENDIF
061000120803      **
061100120803    2C                   ENDIF
061200120803      *
061300120803     C                   LEAVESR
061400120803    1C                   ENDIF
061500120803    ***
061600120803     C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'DEPEND'
061700120803      *
061800120803     C                   IF        STATE = 'WV'
061900120803     C                   EVAL      @CCTRIN = 'WVF'
062000120803     C                   ELSE
062100120803     C                   EVAL      @CCTRIN = 'FAM'
062200120803     C                   ENDIF
062300120803      *
062400120803     C                   LEAVESR
062500120803     C                   ENDIF
062600120803    ***
062700120803    1C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'MEMBER'
062800120803      *
062900120803    2C                   IF        STATE = 'WV'
063000120803      **
063100120803    3C                   IF        ENR@IN = 'TIN'
063200120803     C                   EVAL      @CCTRIN = 'WVI'
063300120803    3C                   ELSE
063400120803     C                   EVAL      @CCTRIN = 'WVF'
063500120803    3C                   ENDIF
063600120803      **
063700120803    2C                   ELSE
063800120803      **
063900120803    3C                   IF        EMPST =  'C'
064000120803     C                   EVAL      @CCTRIN = 'CB '
064100120803    3C                   ELSE
064200120803     C                   EVAL      @CCTRIN = 'AC '
064300120803    3C                   ENDIF
064400120803    3C                   IF        ENR@IN = 'TIN'
064500120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
064600120803    3C                   ELSE
064700120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
064800120803    3C                   ENDIF
064900120803      **
065000120803    2C                   ENDIF
065100120803      *
065200120803     C                   LEAVESR
065300120803    1C                   ENDIF
065400120803    ***
065500120803     C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'DEPEND'
065600120803      *
065700120803     C                   IF        STATE = 'WV'
065800120803     C                   EVAL      @CCTRIN = 'WVF'
065900120803     C                   ELSE
066000120803     C                   IF        EMPST =  'C'
066100120803     C                   EVAL      @CCTRIN = 'CBF'
066200120803     C                   ELSE
066300120803     C                   EVAL      @CCTRIN = 'ACF'
066400120803     C                   ENDIF
066500120803     C                   ENDIF
066600120803      *
066700120803     C                   ENDIF
066800120803    ***
066900120803     C                   ENDSR
067000120803   S***S
067100120803    *** EMPSTS
067200120803    ***   PRETTY STRAIGHT FORWARDED
067300120803    ***
067400120803     C     $METH07       BEGSR
067500120803    ***
067600120803     C                   IF        EMPST =  'C'
067700120803     C                   EVAL      @CCTRIN = 'COB'
067800120803     C                   ELSE
067900120803     C                   EVAL      @CCTRIN = 'ACT'
068000120803     C                   ENDIF
068100120803    ***
068200120803     C                   ENDSR
068300120803   S***S
068400120803    *** JUSTSTATE
068500120803    ***   PRETTY STRAIGHT FORWARDED
068600120803    ***
068700120803     C     $METH08       BEGSR
068800120803    ***
068900120803     C                   EVAL      @CCTRIN = STATE
069000120803    ***
069100120803     C                   ENDSR
069200120803   S***S
069300120803    *** JOHNLS
069400120803    ***   IF STATE IS NOT MARYLAND, DEFAULT TO 'XX', ELSE USE 'MD'; THEN APPLY TIER.
069500120803    ***
069600120803    *** MDI, MDF, XXI, XXF
069700120803    ***
069800120803     C     $METH09       BEGSR
069900120803    ***
070000120803     C                   IF        WRT@TYPE = 'MEMBER'
070100120803     C                   IF        STATE = 'MD'
070200120803     C                   EVAL      @CCTRIN = 'MD'
070300120803     C                   ELSE
070400120803     C                   EVAL      @CCTRIN = 'XX'
070500120803     C                   ENDIF
070600120803     C                   IF        ENR@IN = 'TIN'
070700120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
070800120803     C                   ELSE
070900120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
071000120803     C                   ENDIF
071100120803     C                   ENDIF
071200120803    ***
071300120803     C                   IF        WRT@TYPE = 'DEPEND'
071400120803     C                   IF        STATE = 'MD'
071500120803     C                   EVAL      @CCTRIN = 'MDF'
071600120803     C                   ELSE
071700120803     C                   EVAL      @CCTRIN = 'XXF'
071800120803     C                   ENDIF
071900120803     C                   ENDIF
072000120803    ***
072100120803     C                   ENDSR
072200120803   S***S
072300120803    *** CREATIVE
072400120803    ***   IF STATE IS NOT 'MD' OR 'OK', DEFAULT TO '**'.
072500120803    ***
072600120803    *** MD, OK, **
072700120803    ***
072800120803     C     $METH10       BEGSR
072900120803    ***
073000120803     C                   IF        STATE <> 'MD' AND STATE <> 'OK'
073100120803     C                   EVAL      @CCTRIN = '** '
073200120803     C                   ELSE
073300120803     C                   EVAL      @CCTRIN = STATE
073400120803     C                   ENDIF
073500120803    ***
073600120803     C                   ENDSR
073700120803   S***S
073800120803    *** INTEGRA = USE 'TN' FOR TENNESSEE, OTHER STATES ARE 'XX'
073900120803    ***
074000120803    ***  TN, XX
074100120803    ***
074200120803     C     $METH11       BEGSR
074300120803    ***
074400121113     C                   SELECT
074500121113     C                   WHEN      STATE = 'TN'
074600121113     C                   EVAL      @CCTRIN = STATE                              TENNESSEE ONLY
074700121113     C                   WHEN      STATE = 'FL'
074800121113     C                   EVAL      @CCTRIN = STATE                              FLORIDA ONLY
074900121113     C                   OTHER
075000121113     C                   EVAL      @CCTRIN = 'XX '                              SITUS
075100121113     C                   ENDSL
075200120803    ***
075300120803     C                   ENDSR
075400120803   S***S
075500120803    *** STSTATE = STATE CODE WITH EMPLOYEE STATUS
075600120803    ***
075700120803    ***  MDA, MDC, ETC...
075800120803    ***
075900120803     C     $METH12       BEGSR
076000120803    ***
076100120803     C                   EVAL      @CCTRIN = STATE + EMPST
076200120803    ***
076300120803     C                   ENDSR
076400130123   S***S
076500130123    *** STIERSTS = STATE CODE WITH TIER WITH EMPLOYEE STATUS
076600130123    ***    ACTIVE [#CALC = 0]      COBRA [#CALC = 5]
076700130123    ***    IND [+1 TO #CALC ]      NON-IND COVERAGE [+2 TO CALC]
076800130123    ***
076900130123    ***    EACH STATE PUT AT END, GIVING FAM MARYLAND ACTIVE A VALUE OF 2MD
077000130123    ***                                  IND WEST VIRGINIA COBRA A VALUE OF 6WV
077100130123    ***
077200130123    ***
077300130123     C     $METH13       BEGSR
077400130123    ***
077500130123     C                   SELECT
077600130123     C                   WHEN      EMPST =  'C'
077700130123     C                   Z-ADD     5             #CALC
077800130123     C                   OTHER
077900130123     C                   MOVE      *ZEROS        #CALC             1 0
078000130123     C                   ENDSL
078100130123    ***
078200130123     C                   SELECT
078300130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN = 'TIN'
078400130123     C                   ADD       1             #CALC
078500130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN <> 'TIN'
078600130123     C                   ADD       2             #CALC
078700130123     C                   WHEN      WRT@TYPE = 'DEPEND'
078800130123     C                   ADD       2             #CALC
078900130123     C                   ENDSL
079000130123    ***
079100130123     C                   EVAL      @CCTRIN = %EDITC(#CALC:'X') + STATE
079200130123    ***
079300130123     C                   ENDSR
079400120803   S***S
079500120409     C     $PREP4        BEGSR
079600120409    ***
079700130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
079800101206     C                   EVAL      @STEP = 'STEP2'
079900101206     C                   LEAVESR
080000101206     C                   ENDIF
080100130520    ***
080200130520     C                   EVAL      @STEP = 'STEP4'
080300130315     C                   EVAL      TERM_LIF = NO
080400101210     C                   EVAL      TERM_DEN = NO
080500101210     C                   EVAL      TERM_MED = NO
080600101210    ***
080700130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
080800130520     C                   IF        L@TRM(L#CNE) <> 99999999
080900130520     C                   EXSR      $CHKHEM
081000130520     C                   ENDIF
081100130520     C                   LEAVESR
081200130520     C                   ENDIF
081300130520    ***
081400130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
081500130520     C                   IF        M@TRM(M#CNE) <> 99999999
081600130520     C                   EXSR      $CHKHEM
081700130520     C                   ENDIF
081800130520     C                   LEAVESR
081900130520     C                   ENDIF
082000130520    ***
082100130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
082200130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
082300130520     C                              M@TRM(M#CNE) <> 99999999)
082400130520     C                   EXSR      $CHKHEM
082500130520     C                   ENDIF
082600130520     C                   LEAVESR
082700130520     C                   ENDIF
082800130520    ***
082900130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
083000130520     C                   IF        D@TRM(D#CNE) <> 99999999
083100130520     C                   EXSR      $CHKHEM
083200130520     C                   ENDIF
083300130520     C                   LEAVESR
083400130520     C                   ENDIF
083500130520    ***
083600130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
083700130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
083800130520     C                              D@TRM(D#CNE) <> 99999999)
083900130520     C                   EXSR      $CHKHEM
084000130520     C                   ENDIF
084100130520     C                   LEAVESR
084200130520     C                   ENDIF
084300130520    ***
084400130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
084500130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
084600130520     C                              M@TRM(M#CNE) <> 99999999)
084700130520     C                   EXSR      $CHKHEM
084800130520     C                   ENDIF
084900130520     C                   LEAVESR
085000130520     C                   ENDIF
085100130520    ***
085200130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
085300130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
085400130520     C                              L@TRM(L#CNE) <> 99999999 OR
085500130520     C                              M@TRM(M#CNE) <> 99999999)
085600130520     C                   EXSR      $CHKHEM
085700130520     C                   ENDIF
085800130520     C                   LEAVESR
085900130520     C                   ENDIF
086000101214    ***
086100101214     C                   ENDSR
086200101214   S***S
086300101210    *** GENERATE MEMBER RECORD
086400101210    ***
086500101210     C     $STEP4        BEGSR
086600101210    ***
086700130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
086800101214     C                   EVAL      @STEP = 'STEP2'
086900101214     C                   LEAVESR
087000101214     C                   ENDIF
087100101214    ***
087200110513     C                   EVAL      WRT@TYPE = 'MEMBER'
087300110725    ***
087400130315     C                   EVAL      L@MBREFF = 0
087500110725     C                   EVAL      D@MBREFF = 0
087600110725     C                   EVAL      M@MBREFF = 0
087700110513    ***
087800101210     C                   EVAL      @SS1   = %EDITC(MBSSNO:'X')
087900101210     C                   EVAL      @SS2   = @SS1
088000101210     C                   MOVEL(P)  MLNAME        @LN
088100101210     C                   MOVEL(P)  MFNAME        @FN
088200101210     C                   EVAL      @MI    = MMI
088300101210     C                   EVAL      @REL   = '01'
088400101210     C                   EVAL      @SEX   = SEX
088500101210     C                   EVAL      @DOB   = %EDITC(BIRTH:'X')
088600101210     C                   IF        COB = 'Y'
088700101210     C                   EVAL      @COB   = 'Y'
088800101210     C                   EVAL      @COBC  = 'OT'
088900101210     C                   EVAL      @COBN  = MCOBPN
089000101210     C                   ENDIF
089100101210     C                   EVAL      @AD1   = %TRIM(ADDR1)
089200101210     C                   EVAL      @AD2   = %TRIM(ADDR2)
089300101210     C                   EVAL      @CTY   = %TRIM(CITY)
089400101210     C                   EVAL      @ST    = STATE
089500101210     C                   MOVE      *BLANKS       @9                9
089600101210     C                   EVAL      @9   = %EDITC(ZIP:'X')
089700101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
089800101210     C                   EVAL      @PHN   = %EDITC(AREA:'X') +
089900101210     C                                      %EDITC(PHONE:'X')
090000101210    ***
090100101210     C                   SELECT
090200101210     C                   WHEN      EMPST = 'A'
090300101210     C                   EVAL      @EMPST = 'AC'
090400101210     C                   WHEN      EMPST = 'C'
090500101210     C                   EVAL      @EMPST = 'CO'
090600101210     C                   WHEN      EMPST = 'R'
090700101210     C                   EVAL      @EMPST = 'RT'
090800101210     C                   ENDSL
090900101210    ***
091000101210     C                   EVAL      @HIRE  = %EDITC(EMPDT:'X')
091100101210    ***
091200141211     C                   SETOFF                                       888987
091300141120        IF KF@TRS = 770 AND KF@SUB = 004 AND KF@ACC = 0037 AND
091400141120          STATE = 'VT';
091500141120           *IN89 = *ON;
091600141120        ENDIF;
091700141211    *** IF KF@TRS = 591 AND KF@SUB = 001 AND KF@ACC = 0042 AND
091800141211    ***   STATE = 'TX';
091900141211    ***    *IN87 = *ON;
092000141211    *** ENDIF;
092100141120    ***
092200101210     C                   EXCEPT    MBRF
092300101214     C                   ADD       1             C#RECCNT
092400101213    ***
092500101213     C                   EVAL      @STEP = 'PREP5'
092600101210    ***
092700101210     C                   ENDSR
092800101210   S***S
092900130315    *** * * * * * MEDICAL
093000101214     C     $PREP5        BEGSR
093100101214    ***
093200101214     C                   IF        M#CNE = 0
093300110513     C                   EVAL      @STEP = 'PREP6'
093400101214     C                   LEAVESR
093500101214     C                   ENDIF
093600101214    ***
093700101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
093800130315     C                   EVAL      KF@ENR = M@ENR(M#CNE)
093900101214    ***
094000101214     C                   IF        TERM_MED = YES
094100101214     C                   EXSR      $WRTERM
094200101214     C                   ENDIF
094300101214    ***
094400110512     C                   EVAL      @PLANIN = KF@PLN
094500120803    ***
094600120803     C     KL#TSAP       CHAIN     AEF01
094700120803     C                   IF        NOT %FOUND(AET001WF)
094800120803     C                   LEAVESR
094900120803     C                   ENDIF
095000120803    ***
095100111020     C                   EVAL      ENR@IN = M@ENR(M#CNE)
095200111020    ***
095300110802     C                   EXSR      $QUIK
095400110802    ***
095500110512     C                   EXSR      $PLANSRCH
095600110512    ***
095700110512     C                   IF        PLN@CAT = *BLANKS
095800101214     C                   SETON                                        H1
095900101214     C                   ENDIF
096000110512    ***
096100110513     C                   EVAL      @STEP = 'STEP5'
096200110725     C                   EVAL      #XSX = M@FRM(M#CNE)
096300110725     C                   EVAL      M@MBREFF = #XSX
096400101214    ***
096500101214     C                   ENDSR
096600101214   S***S
096700101214     C     $STEP5        BEGSR
096800101214    ***
096900160224     C                   IF        CPCID1 = 'VIS'
097000110513     C                   EXSR      $MEAWRT
097300110513     C                   ENDIF
097400110513    ***
097500101214     C                   ADD       1             C#RECCNT
097600101214     C                   ADD       1             B#RECCNT
097700110512    ***
097800110513     C                   EVAL      @STEP = 'PREP6'
097900110513    ***
098000110513     C                   ENDSR
098100110513   S***S
098200130315    *** DENTAL
098300130315    ***
098400101214     C     $PREP6        BEGSR
098500101213    ***
098600110513    *C                   IF        D#CNE = 0
098700130315    *C                   EVAL      @STEP = 'PREPC'
098800130315    *C*****************  EVAL      @STEP = 'PREP7'
098900110513    *C                   LEAVESR
099000110513    *C                   ENDIF
099100110512    ***
099200110513    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
099300130315    *C                   EVAL      KF@ENR = D@ENR(D#CNE)
099400130315    ***
099500120803     C     KL#TSAP       CHAIN     AEF01
099600120803     C                   IF        NOT %FOUND(AET001WF)
099700120803     C                   LEAVESR
099800120803     C                   ENDIF
099900110512    ***
100000110513    *C                   IF        TERM_DEN = YES
100100110513    *C                   EXSR      $WRTERM
100200110513    *C                   ENDIF
100300110513    ***
100400110513     C                   EVAL      @PLANIN = KF@PLN
100500111020     C                   EVAL      ENR@IN = D@ENR(D#CNE)
100600110513    ***
100700111011     C                   EXSR      $QUIK
100800110513    ***
100900110513     C                   EXSR      $PLANSRCH
101000110513    ***
101100110513     C                   IF        PLN@CAT = *BLANKS
101200110513     C                   SETON                                        H2
101300110513     C                   ENDIF
101400110512    ***
101500110513    *C                   EVAL      @STEP = 'STEP6'
101600110725     C                   EVAL      #XSX = D@FRM(D#CNE)
101700110725     C                   EVAL      D@MBREFF = #XSX
101800110512    ***
101900101213     C                   ENDSR
102000110802   S***S
102100110513    *** DENTAL FORMAT
102200110513    ***
102300110513    *C     $STEP6        BEGSR
102400110513    ***
102500110513     C                   EXSR      $DENWRT
102600110513    ***
102700110513    *C                   ADD       1             C#RECCNT
102800110513    *C                   ADD       1             B#RECCNT
102900110513    ***
103000130315    *C****************** EVAL      @STEP = 'PREP7'
103100130315    *C                   EVAL      @STEP = 'PREPC'
103200110513    ***
103300110513    *C                   ENDSR
103400110513   S***S
103500130315    *** LIFE AND AD&D PLANS FOR MEMBER
103600130315    ***
103700130315     C     $PREPC        BEGSR
103800130315    ***
103900130315    *C                   IF        L#CNE = 0
104000130315    *C                   EVAL      @STEP = 'PREP7'
104100130315    *C                   LEAVESR
104200130315    *C                   ENDIF
104300130315    ***
104400130315    *C                   EVAL      KF#TRM = L@TRM(L#CNE)
104500130315    *C                   EVAL      KF@PLN = L@PLN(L#CNE)
104600130315     C                   EVAL      KF@ENR = L@ENR(L#CNE)
104700130315    ***
104800130315     C     KL#TSAP       CHAIN     AEF01
104900130315     C                   IF        NOT %FOUND(AET001WF)
105000130315     C                   LEAVESR
105100130315     C                   ENDIF
105200130315    ***
105300130315    *C                   IF        TERM_LIF = YES
105400130315    *C                   EXSR      $WRTERM
105500130315    *C                   ENDIF
105600130315    ***
105700130315     C                   EVAL      @PLANIN = KF@PLN
105800130315     C                   EVAL      ENR@IN = L@ENR(L#CNE)
105900130315    ***
106000130315     C                   EXSR      $QUIK
106100130315    ***
106200130315     C                   EXSR      $PLANSRCH
106300130315    ***
106400130315     C                   IF        PLN@CAT = *BLANKS
106500130315     C                   SETON                                        H2
106600130315     C                   ENDIF
106700130315    ***
106800130315    *C                   EVAL      @STEP = 'STEPC'
106900130315     C                   EVAL      #XSX = L@FRM(L#CNE)
107000130315     C                   EVAL      L@MBREFF = #XSX
107100130315    ***
107200130315     C                   ENDSR
107300130315   S***S
107400130315    *** LIFE FORMAT
107500130315    ***
107600130315    *C     $STEPC        BEGSR
107700130315    ***
107800130315     C                   EXSR      $LIFWRT
107900130315    ***
108000130315    *C                   ADD       1             C#RECCNT
108100130315    *C                   ADD       1             B#RECCNT
108200130315    ***
108300130315    *C                   EVAL      @STEP = 'PREP7'
108400130315    ***
108500130315    *C                   ENDSR
108600130315   S***S
108700130315     C     $LIFWRT       BEGSR
108800130315    ***
108900130315    *C                   EVAL      X@LAY = CPCID1                               LAYOUT
109000130315    *C                   EVAL      X@ELR = CPCID2                               ELR
109100130315    *C                   EVAL      L@SFX = CPCID3                               SUFFIX
109200130315    *C                   EVAL      L@ACCT = CPCID4                              ACCOUNT
109300130315    *C                   EVAL      L@PLAN = CPCID5                              PLAN
109400130315    *C                   EVAL      L@CLM = CPCID6                               CLAIM OFFICE
109500130315    ***
109501221108       edate = L@FRM(L#CNE);
109600130315    *C                   EVAL      #XSX = L@FRM(L#CNE)
109700130315     C                   MOVE      #XSX          X@EFF
109800130315    ***
109801221108       tdate = L@TRM(L#CNE);
109900130315    *C                   EVAL      #XSX = L@TRM(L#CNE)
110000130315    *C                   IF        #XSX = 0 OR #XSX = 99999999
110100130315    *C                   MOVE      *BLANKS       X@TRM
110200130315    *C                   ELSE
110300160809    *C****               MOVE      #XSX          X@TRM
110400160809       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
110500160809       if %subdt(work_date:*d) = 01 ;
110600160809        work_date -= %days(1) ;
110700160809        num_date = %dec(work_date:*iso);
110800160809        X@TRM = %EDITC(num_date:'X');
110900160809       endif;
110901221108
110902221108       if edate = tdate;
110903221108        X@TRM = %editc(tdate:'X');
110904221108       endif;
111000160809
111100130315    *C                   ENDIF
111200140313    ***
111300140313     C                   MOVE      *BLANKS       L@CBREXP
111400140313     C                   MOVE      *BLANKS       L@CBREVT
111500140313     C                   MOVE      *BLANKS       L@CBRLEN
111600130315    ***
111700130923    *C                   IF        EMPST = 'C' AND
111800130923     C                             CEXPDT > 0
111900130315    *C                   MOVE      CEXPDT        L@CBREXP
112000130315    *C                   MOVE      QEDT          L@CBREVT
112100130315    *C                   MOVE      CEXPDT        #MINUEND
112200130315    *C                   MOVE      QEDT          #SUBTRAEND
112300130315    *C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
112400130315    *C                   Z-ADD     #DIFFRNC      #2S0
112500130315    *C                   MOVE      #2S0          L@CBRLEN
112600130315    *C                   ENDIF
112700130315    ***
112800130315     C                   EVAL      L@SALARY = %EDITC(SALARY:'4')
112900130315    ***
113000130315    *C                   EXCEPT    LIFF
113100130315    ***
113200130315    *C                   ENDSR
113300130315   S***S
113400101214     C     $PREP7        BEGSR
113500101214    ***
113600101214     C     KF@SSN        CHAIN     DEPENR
113700101214     C                   IF        NOT %FOUND(DEPNDC)
113800101214     C                   EVAL      @STEP = 'STEP2'
113900101214     C                   LEAVESR
114000101214     C                   ENDIF
114100101214    ***
114200101214     C     KF@SSN        SETLL     DEPENR
114300101214    ***
114400101214     C                   EVAL      @STEP = 'STEP7'
114500101214    ***
114600101214     C                   ENDSR
114700101210   S***S
114800101214     C     $STEP7        BEGSR
114900101214    ***
115000101214     C     KF@SSN        READE     DEPENR
115100101214    ***
115200101214     C                   IF        %EOF(DEPNDC)
115300101214     C                   EVAL      @STEP = 'STEP2'
115400101214     C                   LEAVESR
115500101214     C                   ENDIF
115600101214    ***
115700101214     C                   EVAL      KF@SEQ = DPSEQ#
115800120803     C                   EVAL      WRT@TYPE = 'DEPEND'
115900101214    ***
116000101214     C     KL#DCV        CHAIN     DCOVR
116100101214     C                   IF        NOT %FOUND(DCOVA)
116200101214     C                   LEAVESR
116300101214     C                   ENDIF
116400101214    ***
116500101214     C                   EXSR      $CLRDCV
116600101214     C     KL#DCV        SETLL     DCOVR
116700101214    ***
116800101214     C                   EVAL      @STEP = 'STEP8'
116900101214    ***
117000101214     C                   ENDSR
117100101214   S***S
117200101214     C     $STEP8        BEGSR
117300101214    ***
117400101214     C     KL#DCV        READE     DCOVR
117500101214    ***
117600101214     C                   IF        %EOF(DCOVA)
117700101214     C                   EVAL      @STEP = 'PREP9'
117800101214     C                   LEAVESR
117900101214     C                   ENDIF
118000101214    ***
118100130131    *C*                  IF        DENRDT = CCANDT
118200130131    *C*                  LEAVESR
118300130131    *C*                  ENDIF
118400110513    ***
118500110513     C                   EVAL      @PLANIN = DVPLAN
118600120803     C                   EVAL      KF@PLN = DVPLAN
118700120803     C     KL#TSAP       CHAIN     AEF01
118800120803     C                   IF        NOT %FOUND(AET001WF)
118900120803     C                   LEAVESR
119000120803     C                   ENDIF
119100110802    ***
119200110802     C                   EXSR      $QUIKD
119300110802    ***
119400110513     C                   EXSR      $PLANSRCH
119500110513    ***
119600110513     C                   IF        PLN@CAT = *BLANKS
119700110513     C                   LEAVESR
119800110513     C                   ENDIF
119900101214    ***
120000101214     C                   EVAL      #CANCEL = CCANDT
120100101214     C                   IF        #CANCEL = 0
120200101214     C                   EVAL      #CANCEL = 99999999
120300101214     C                   ENDIF
120400101214    ***
120500130315    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL; LIFE IS MEMBER ONLY
120600110513    ***
120700160224    *C****               IF        PLN@CAT = 'DEN'
120800160224    *C****               IF        D#CNE > 0
120900160224    *C****               IF        D@TRM(D#CNE) = 99999999
121000160224     C****               LEAVESR
121100160224     C****               ENDIF
121200160224     C****               ENDIF
121300160224    *C****               ADD       1             D#CNE
121400160224    *C****               EVAL      D@PLN(D#CNE) = DVPLAN
121500160224    *C****               EVAL      D@ENR(D#CNE) = *BLANKS
121600160224    *C****               EVAL      D@FRM(D#CNE) = DENRDT
121700160224    *C****               EVAL      D@TRM(D#CNE) = #CANCEL
121800160224    *C****               ELSE
121900130131    *C                   IF        M#CNE > 0
122000130131    *C                   IF        M@TRM(M#CNE) = 99999999
122100130131     C                   LEAVESR
122200130131     C                   ENDIF
122300130131     C                   ENDIF
122400101214     C                   ADD       1             M#CNE
122500101214     C                   EVAL      M@PLN(M#CNE) = DVPLAN
122600101214     C                   EVAL      M@ENR(M#CNE) = *BLANKS
122700101214     C                   EVAL      M@FRM(M#CNE) = DENRDT
122800101214     C                   EVAL      M@TRM(M#CNE) = #CANCEL
122900160224    *C****               ENDIF
123000101214    ***
123100101214     C                   ENDSR
123200101214   S***S
123300111011     C     $QUIKD        BEGSR
123400111011    ***
123500120803     C                   EXSR      $QUIK
123600120409    ***
123700120409     C                   ENDSR
123800111011   S***S
123900101214     C     $PREP9        BEGSR
124000101214    ***
124100101214     C                   IF        D#CNE = 0 AND M#CNE = 0
124200101214     C                   EVAL      @STEP = 'STEP7'
124300101214     C                   LEAVESR
124400101214     C                   ENDIF
124500101214    ***
124600130315     C                   EVAL      L#CNE = 0
124700130315     C                   EVAL      TERM_LIF = NO
124800101214     C                   EVAL      TERM_DEN = NO
124900101214     C                   EVAL      TERM_MED = NO
125000130520     C                   EVAL      @STEP = 'STEP9'
125100101214    ***
125200130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
125300130520     C                   IF        L@TRM(L#CNE) <> 99999999
125400130520     C                   EXSR      $CHKHEM
125500130520     C                   ENDIF
125600130520     C                   LEAVESR
125700130520     C                   ENDIF
125800130520    ***
125900130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
126000130520     C                   IF        M@TRM(M#CNE) <> 99999999
126100130520     C                   EXSR      $CHKHEM
126200130520     C                   ENDIF
126300130520     C                   LEAVESR
126400130520     C                   ENDIF
126500130520    ***
126600130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
126700130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
126800130520     C                              M@TRM(M#CNE) <> 99999999)
126900130520     C                   EXSR      $CHKHEM
127000130520     C                   ENDIF
127100130520     C                   LEAVESR
127200130520     C                   ENDIF
127300130520    ***
127400130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
127500130520     C                   IF        D@TRM(D#CNE) <> 99999999
127600130520     C                   EXSR      $CHKHEM
127700130520     C                   ENDIF
127800130520     C                   LEAVESR
127900130520     C                   ENDIF
128000130520    ***
128100130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
128200130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
128300130520     C                              D@TRM(D#CNE) <> 99999999)
128400130520     C                   EXSR      $CHKHEM
128500130520     C                   ENDIF
128600130520     C                   LEAVESR
128700130520     C                   ENDIF
128800130520    ***
128900130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
129000130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
129100130520     C                              M@TRM(M#CNE) <> 99999999)
129200130520     C                   EXSR      $CHKHEM
129300130520     C                   ENDIF
129400130520     C                   LEAVESR
129500130520     C                   ENDIF
129600130520    ***
129700130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
129800130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
129900130520     C                              L@TRM(L#CNE) <> 99999999 OR
130000130520     C                              M@TRM(M#CNE) <> 99999999)
130100130520     C                   EXSR      $CHKHEM
130200130520     C                   ENDIF
130300130520     C                   LEAVESR
130400130520     C                   ENDIF
130500101214    ***
130600101214     C                   ENDSR
130700101214   S***S
130800101210    *** GENERATE DEPENDENT RECORD
130900101210    ***
131000101214     C     $STEP9        BEGSR
131100101210    ***
131200110513     C                   EVAL      WRT@TYPE = 'DEPEND'
131300110513    ***
131400110513     C                   IF        D#CNE = 0 AND M#CNE = 0
131500110513     C                   EVAL      @STEP = 'STEP7'
131600110513     C                   LEAVESR
131700110513     C                   ENDIF
131800110513    ***
131900101214     C                   EVAL      @SS2   = %EDITC(DEPSS#:'X')
132000101210     C                   MOVEL(P)  DLNAME        @LN
132100101210     C                   MOVEL(P)  DFNAME        @FN
132200101210     C                   EVAL      @MI    = DMI
132300101210    ***
132400101210     C                   SELECT
132500101210     C                   WHEN      DRELCD = 'RWI'
132600101210     C                   EVAL      @REL   = '02'
132700101210     C                   WHEN      DRELCD = 'RHU'
132800101210     C                   EVAL      @REL   = '03'
132900101210     C                   WHEN      DRELCD = 'RSO'
133000101210     C                   EVAL      @REL   = '04'
133100101210     C                   WHEN      DRELCD = 'RDA'
133200101210     C                   EVAL      @REL   = '05'
133300130218     C                   WHEN      DRELCD = 'RPA'
133400130218     C                   EVAL      @REL   = '14'
133500130225     C                   OTHER
133600130225     C                   EVAL      @REL   = *BLANKS
133700101210     C                   ENDSL
133800101210    ***
133900101210     C                   SELECT
134000101210     C                   WHEN      DSTUDN = 'Y'
134100101210     C                   EVAL      @SPEC = '1'
134200140812     C                   WHEN      DHNDCP = '3'
134300101210     C                   EVAL      @SPEC = '3'
134400130225     C                   OTHER
134500130225     C                   EVAL      @SPEC = *BLANKS
134600101210     C                   ENDSL
134700101210    ***
134800101210     C                   EVAL      @SEX   = DSEX
134900101210     C                   EVAL      @DOB   = %EDITC(DBIRTH:'X')
135000130225    ***
135100101210     C                   IF        DCOB = 'Y'
135200101210     C                   EVAL      @COB   = 'Y'
135300101210     C                   EVAL      @COBC  = 'OT'
135400101210     C                   EVAL      @COBN  = DCOBPN
135500130225     C                   ELSE
135600130225     C                   EVAL      @COB   = *BLANKS
135700130225     C                   EVAL      @COBC  = *BLANKS
135800130225     C                   EVAL      @COBN = *BLANKS
135900101210     C                   ENDIF
136000101214    ***
136100101214     C                   IF        DADDR1 <> ADDR1
136200101210     C                   EVAL      @AD1   = %TRIM(DADDR1)
136300101210     C                   EVAL      @AD2   = %TRIM(DADDR2)
136400101210     C                   EVAL      @CTY   = %TRIM(DCITY)
136500101210     C                   EVAL      @ST    = DSTATE
136600101210     C                   MOVE      *BLANKS       @9                9
136700101214     C                   IF        DZIP = 0
136800101214     C                   EVAL      @9   = %EDITC(ZIP:'X')
136900101214     C                   ELSE
137000101210     C                   EVAL      @9   = %EDITC(DZIP:'X')
137100101214     C                   ENDIF
137200101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
137300101210     C                   EVAL      @PHN   = %EDITC(DAREA:'X') +
137400101210     C                                      %EDITC(DPHONE:'X')
137500101214     C                   ENDIF
137600141120    ***
137700101210     C                   EXCEPT    MBRF
137800101214     C                   ADD       1             C#RECCNT
137900101214    ***
138000101214     C                   EVAL      @STEP = 'PREPA'
138100101210    ***
138200101210     C                   ENDSR
138300101210   S***S
138400101214     C     $PREPA        BEGSR
138500101214    ***
138600101214     C                   IF        M#CNE = 0
138700101214     C                   EVAL      @STEP = 'PREPB'
138800101214     C                   LEAVESR
138900101214     C                   ENDIF
139000101214    ***
139100101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
139200120803     C     KL#TSAP       CHAIN     AEF01
139300120803     C                   IF        NOT %FOUND(AET001WF)
139400120803     C                   LEAVESR
139500120803     C                   ENDIF
139600101214    ***
139700101214     C                   IF        TERM_MED = YES
139800101214     C                   EXSR      $WRTERM
139900101214     C                   ENDIF
140000101214    ***
140100110513     C                   EVAL      @PLANIN = KF@PLN
140200110802    ***
140300110802     C                   EXSR      $QUIKD
140400110802    ***
140500110513     C                   EXSR      $PLANSRCH
140600110513    ***
140700110513     C                   IF        PLN@CAT = *BLANKS
140800110513     C                   SETON                                        H2
140900110513     C                   ENDIF
141000110513    ***
141100110513     C                   EVAL      @STEP = 'STEPA'
141200110513    ***
141300101214     C                   ENDSR
141400101214   S***S
141500101214     C     $STEPA        BEGSR
141600101214    ***
141700160224     C                   IF        CPCID1 = 'VIS'
141800110513     C                   EXSR      $MEAWRT
142100110513     C                   ENDIF
142200110513    ***
142300110513     C                   ADD       1             C#RECCNT
142400110513     C                   ADD       1             B#RECCNT
142500110513    ***
142600110513     C                   EVAL      @STEP = 'PREPB'
142700110513    ***
142800110513     C                   ENDSR
142900110513   S***S
143000101214     C     $PREPB        BEGSR
143100101214    ***
143200110513    *C                   IF        D#CNE = 0
143300110513    *C                   EVAL      @STEP = 'STEP7'
143400110513    *C                   LEAVESR
143500110513    *C                   ENDIF
143600101214    ***
143700110513    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
143800120803     C     KL#TSAP       CHAIN     AEF01
143900120803     C                   IF        NOT %FOUND(AET001WF)
144000120803     C                   LEAVESR
144100120803     C                   ENDIF
144200110513    ***
144300110513    *C                   IF        TERM_DEN = YES
144400110513    *C                   EXSR      $WRTERM
144500110513    *C                   ENDIF
144600110513    ***
144700110513     C                   EVAL      @PLANIN = KF@PLN
144800110513    ***
144900110802     C                   EXSR      $QUIKD
145000110513    ***
145100110513     C                   EXSR      $PLANSRCH
145200110513    ***
145300110513     C                   IF        PLN@CAT = *BLANKS
145400110513     C                   SETON                                        H2
145500110513     C                   ENDIF
145600110513    ***
145700101214     C                   EVAL      @STEP = 'STEPB'
145800101214    ***
145900101214     C                   ENDSR
146000101214   S***S
146100110513    *C     $STEPB        BEGSR
146200110513    ***
146300110513     C                   EXSR      $DENWRT
146400110513    ***
146500110513    *C                   ADD       1             C#RECCNT
146600110513    *C                   ADD       1             B#RECCNT
146700110513    ***
146800110513    *C                   EVAL      @STEP = 'STEP7'
146900110513    ***
147000110513    *C                   ENDSR
147100101210   S***S
147200110512     C     *INZSR        BEGSR
147300110512    ***
147400110512     C     KL#ACCTL      KLIST
147500120803     C                   KFLD                    KF@CCTL
147600110512     C                   KFLD                    KF@TRS
147700110512     C                   KFLD                    KF@SUB
147800110512     C                   KFLD                    KF@ACC
147900140313    ***
148000140313     C     KL#SQPCD      KLIST
148100140313     C                   KFLD                    KF@SSN
148200140313     C                   KFLD                    KF@SEQ
148300140313     C                   KFLD                    KF@SPCD
148400120803    ***
148500120803     C     KL#TSAP       KLIST
148600120803     C                   KFLD                    KF@TRS
148700120803     C                   KFLD                    KF@SUB
148800120803     C                   KFLD                    KF@ACC
148900120803     C                   KFLD                    KF@PLN
149000110512    ***
149100110512     C     KL#TSA        KLIST
149200110512     C                   KFLD                    KF@TRS
149300110512     C                   KFLD                    KF@SUB
149400110512     C                   KFLD                    KF@ACC
149500110512    ***
149600110512     C     KL#MPLN       KLIST
149700110512     C                   KFLD                    KF@SSN
149800110512     C                   KFLD                    KF@SEQ
149900110512     C                   KFLD                    KF@TRS
150000110512     C                   KFLD                    KF@SUB
150100110512     C                   KFLD                    KF@ACC
150200110512    ***
150300110512     C     KL#CPLN       KLIST
150400120803     C                   KFLD                    KF@CCTL
150500110512     C                   KFLD                    KF@TRS
150600110512     C                   KFLD                    KF@SUB
150700110512     C                   KFLD                    KF@ACC
150800110512     C                   KFLD                    KF@CCTR
150900110512     C                   KFLD                    KF@PLN
151000110512    ***
151100110512     C     KL#DCV        KLIST
151200110512     C                   KFLD                    KF@SSN
151300110512     C                   KFLD                    KF@SEQ
151400110512    ***
151500110512     C     KL#MTR        KLIST
151600110512     C                   KFLD                    KF@SSN
151700110512     C                   KFLD                    KF@SEQ
151800110512     C                   KFLD                    KF#TRM
151900110512     C                   KFLD                    KF@PLN
152000110512     C                   KFLD                    KF@ENR
152100110512     C                   KFLD                    KF@TRS
152200110512     C                   KFLD                    KF@SUB
152300110512     C                   KFLD                    KF@ACC
152400110512    ***
152500110512     C     KL#PCP        KLIST
152600110512     C                   KFLD                    KF@SSN
152700110512     C                   KFLD                    KF@SEQ
152800110512    ***
152900110512     C                   EVAL      #ISO = %DATE
153000110512     C                   MOVE      #ISO          #TODAY            8 0
153100110512     C                   EVAL      #IST = %TIME
153200110512     C                   MOVE      #ISO          #XSX
153300110512     C                   MOVE      #XSX          @DATE
153400110512     C                   MOVE      #IST          #XST
153500110512     C                   MOVE      #XST          @TIME
153600110512    ***
153700110512     C                   ENDSR
153800110512   S***S
153900110513    *** PLANS LOADED BY ACCOUNT
154000110513    ***
154100110513     C     $PLANLOAD     BEGSR
154200110513    ***
154300110513     C                   EVAL      PP# = 0
154400140313     C                   DO        80
154500110513     C                   ADD       1             PP#
154600110513     C     PP#           OCCUR     CARPLN@
154700110513     C                   CLEAR                   CARPLN@
154800110513     C                   ENDDO
154900110513     C                   EVAL      PC# = 0
155000110513     C                   EVAL      PP# = 0
155100110513    ***
155200110513     C     KL#ACCTL      SETLL     CARPLNR
155300110513     C                   DOU       %EOF(CARPLNP)
155400110513     C     KL#ACCTL      READE     CARPLNR
155500110520     C                   IF        NOT %EOF(CARPLNP)
155600110513    ***
155700110513     C                   ADD       1             PC#
155800110513     C     PC#           OCCUR     CARPLN@
155900110513     C                   EVAL      CARPLN@ = DS@CARPLN
156000110513    ***
156100110513     C                   ENDIF
156200110513     C                   ENDDO
156300110513    ***
156400110513     C                   ENDSR
156500110513   S***S
156600110513     C     $CLRSTG       BEGSR
156700110513    ***
156800110513     C                   EVAL      #CANCEL = 0
156900130315    ***
157000130315     C                   EVAL      L#CNE = 0
157100130315     C                   CLEAR                   L@PLN
157200130315     C                   CLEAR                   L@ENR
157300130315     C                   CLEAR                   L@FRM
157400130315     C                   CLEAR                   L@TRM
157500130315    ***
157600110513     C                   EVAL      D#CNE = 0
157700110513     C                   CLEAR                   D@PLN
157800110513     C                   CLEAR                   D@ENR
157900110513     C                   CLEAR                   D@FRM
158000110513     C                   CLEAR                   D@TRM
158100110513     C                   EVAL      M#CNE = 0
158200110513     C                   CLEAR                   M@PLN
158300110513     C                   CLEAR                   M@ENR
158400110513     C                   CLEAR                   M@FRM
158500110513     C                   CLEAR                   M@TRM
158600110513    ***
158700110513     C                   EXSR      $CLRDMG
158800110513    ***
158900110513     C                   ENDSR
159000110513   S***S
159100110513     C     $CLRDMG       BEGSR
159200110513    ***
159300110513     C                   EVAL      @SS1   = *BLANKS
159400110513     C                   EVAL      @SS2   = *BLANKS
159500110513     C                   MOVE      *BLANKS       @LN
159600110513     C                   MOVEL     *BLANKS       @FN
159700110513     C                   EVAL      @MI    = *BLANKS
159800110513     C                   EVAL      @REL   = *BLANKS
159900110513     C                   EVAL      @SEX   = *BLANKS
160000110513     C                   EVAL      @DOB   = *BLANKS
160100110513     C                   EVAL      @SPEC  = *BLANKS
160200110513     C                   EVAL      @COB   = *BLANKS
160300110513     C                   EVAL      @COBC  = *BLANKS
160400110513     C                   EVAL      @COBN  = *BLANKS
160500110513     C                   EVAL      @AD1   = *BLANKS
160600110513     C                   EVAL      @AD2   = *BLANKS
160700110513     C                   EVAL      @CTY   = *BLANKS
160800110513     C                   EVAL      @ST    = *BLANKS
160900110513     C                   EVAL      @ZP5   = *BLANKS
161000110513     C                   EVAL      @PHN   = *BLANKS
161100110513     C                   EVAL      @EMPST = *BLANKS
161200110513     C                   EVAL      @HIRE  = *BLANKS
161300110513    ***
161400110513     C                   ENDSR
161500110513   S***S
161600110513     C     $CHKHEM       BEGSR
161700110513    ***
161800130315    *C                   IF        L#CNE > 0 AND L@TRM(L#CNE) <> 99999999
161900130315    *C                   EXSR      $CHKLIF
162000130315    *C                   ENDIF
162100130315      *
162200110513    *C                   IF        D#CNE > 0 AND D@TRM(D#CNE) <> 99999999
162300110513    *C                   EXSR      $CHKDEN
162400110513    *C                   ENDIF
162500110513      *
162600110513     C                   IF        M#CNE > 0 AND M@TRM(M#CNE) <> 99999999
162700110513     C                   EXSR      $CHKMED
162800110513     C                   ENDIF
162900110513    ***
163000110513     C                   ENDSR
163100110513   S***S
163200130315    *C     $CHKLIF       BEGSR
163300130315    ***
163400130315    *C                   EVAL      TERM_LIF = YES
163500130315    *C                   EVAL      KF#TRM = L@TRM(L#CNE)
163600130315    *C                   EVAL      KF@PLN = L@PLN(L#CNE)
163700130315    *C                   EVAL      KF@ENR = L@ENR(L#CNE)
163800130315    ***
163900130315    *C     KL#MTR        CHAIN     AET081F
164000130315    *C                   IF        %FOUND(AET081WF)
164100130315    *C                   EVAL      L#CNE = 0
164200130315    *C                   EVAL      TERM_LIF = NO
164300130315    *C                   ENDIF
164400130315    ***
164500130315    *C                   ENDSR
164600130315   S***S
164700110513    *C     $CHKDEN       BEGSR
164800110513    ***
164900110513    *C                   EVAL      TERM_DEN = YES
165000110513    *C                   EVAL      KF#TRM = D@TRM(D#CNE)
165100110513    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
165200110513    *C                   EVAL      KF@ENR = D@ENR(D#CNE)
165300110513    ***
165400110802    *C     KL#MTR        CHAIN     AET081F
165500110802    *C                   IF        %FOUND(AET081WF)
165600110513    *C                   EVAL      D#CNE = 0
165700110513    *C                   EVAL      TERM_DEN = NO
165800110513    *C                   ENDIF
165900110513    ***
166000110513    *C                   ENDSR
166100110513   S***S
166200110513     C     $CHKMED       BEGSR
166300110513    ***
166400110513     C                   EVAL      TERM_MED = YES
166500110513     C                   EVAL      KF#TRM = M@TRM(M#CNE)
166600110513     C                   EVAL      KF@PLN = M@PLN(M#CNE)
166700110513     C                   EVAL      KF@ENR = M@ENR(M#CNE)
166800110513      *
166900110802     C     KL#MTR        CHAIN     AET081F
167000110802     C                   IF        %FOUND(AET081WF)
167100110513     C                   EVAL      TERM_MED = NO
167200110513     C                   EVAL      M#CNE = 0
167300110513     C                   ENDIF
167400110513    ***
167500110513     C                   ENDSR
167600110513   S***S
167700110513     C     $PLANSRCH     BEGSR
167800110513    ***
167900130315     C                   MOVE      *BLANKS       PLN@CAT           5
168000110513     C                   EVAL      PP# = 0
168100110513     C                   CLEAR                   DS@CARPLN
168200110513    ***
168300110513     C                   DO        PC#
168400110513    * *
168500110513     C                   ADD       1             PP#
168600110513     C     PP#           OCCUR     CARPLN@
168700110513    * *
168800110513     C                   IF        XPPLAN = @PLANIN AND
168900110513     C                             XPCCTR = @CCTRIN
169000110513     C                   EVAL      DS@CARPLN = CARPLN@
169100110513     C                   LEAVE
169200110513     C                   ENDIF
169300110513    * *
169400110513     C                   ENDDO
169500110513    ***
169600110513     C                   IF        CPPLAN = *BLANKS
169700110513     C                   LEAVESR
169800110513     C                   ENDIF
169900110513    ***
170000110513     C                   SELECT
170100160224     C                   WHEN      CPCID1 = 'VIS'
170200160224     C                   EVAL      PLN@CAT = 'VIS'
170900110513     C                   ENDSL
171000110513    ***
171100110513     C                   ENDSR
171200110513   S***S
171300110513     C     $ENROLL       BEGSR
171400110513    ***
171500110513     C                   EVAL      ENR@OUT = *BLANKS
171600110513     C                   SELECT
171700110513     C                   WHEN      ENR@IN = 'TIN' OR ENR@IN = 'TMI'
171800110513     C                   EVAL      ENR@OUT = 'S'
171900110513     C                   WHEN      ENR@IN = 'THW'
172000110513     C                   EVAL      ENR@OUT = 'C'
172100110513     C                   WHEN      ENR@IN = 'TPC'
172200110513     C                   EVAL      ENR@OUT = 'P'
172300110513     C                   WHEN      ENR@IN = 'TP2'
172400110513     C                   EVAL      ENR@OUT = 'Q'
172500110513     C                   WHEN      ENR@IN = 'TFA'
172600110513     C                   EVAL      ENR@OUT = 'F'
172700110513     C                   ENDSL
172800110513    ***
172900110513     C                   ENDSR
173000110513   S***S
173100110513     C     $WRTERM       BEGSR
173200110513    ***
173300110802     C                   CLEAR                   AET081F
173400110513     C                   EVAL      NTSSNO         = KF@SSN
173500110513     C                   EVAL      NTDEPNO        = KF@SEQ
173600110513     C                   EVAL      NTTERMDT       = KF#TRM
173700110513     C                   EVAL      NTPLAN         = KF@PLN
173800110513     C                   EVAL      NTCOVTP        = KF@ENR
173900110513     C                   EVAL      NTTRST         = KF@TRS
174000110513     C                   EVAL      NTSUB#         = KF@SUB
174100110513     C                   EVAL      NTACCT         = KF@ACC
174200110513     C                   EVAL      NTTRANSDT      = #TODAY
174300110802     C                   WRITE     AET081F
174400110513    ***
174500110513     C                   ENDSR
174600110513   S***S
174700110513     C     $HMOWRT       BEGSR
174800110513    ***
174900110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
175000110513     C                   EVAL      X@ELR = CPCID2                               FILE NUMBER
175100110513     C                   EVAL      M@CC = CACID2                                COMPANY CODE
175200110513     C                   EVAL      M@CLASS = CPCID3                             CLASS CODE
175300110513     C                   EVAL      M@PLAN = CPCID4                              PLAN NUMBER
175400110513    ***
175401221108       edate = M@FRM(M#CNE);
175500110513     C                   EVAL      #XSX = M@FRM(M#CNE)
175600110725     C                   IF        WRT@TYPE = 'DEPEND' AND
175700110725     C                             #XSX < M@MBREFF
175800110725     C                   MOVE      M@MBREFF      X@EFF
175900110725     C                   ELSE
176000110725     C                   MOVE      #XSX          X@EFF
176100110725     C                   ENDIF
176200110513    ***
176201221108       tdate = M@TRM(M#CNE);
176300110513     C                   EVAL      #XSX = M@TRM(M#CNE)
176400110513     C                   IF        #XSX = 0 OR #XSX = 99999999
176500110513     C                   MOVE      *BLANKS       X@TRM
176600110513     C                   ELSE
176700160809     C****               MOVE      #XSX          X@TRM
176800160809       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
176900160809       if %subdt(work_date:*d) = 01 ;
177000160809        work_date -= %days(1) ;
177100160809        num_date = %dec(work_date:*iso);
177200160809        X@TRM = %EDITC(num_date:'X');
177300160809       endif;
177301221108
177302221108       if edate = tdate;
177303221108        X@TRM = %editc(tdate:'X');
177304221108       endif;
177400160809
177500110513     C                   ENDIF
177600110513    ***
177700110513     C                   IF        WRT@TYPE = 'MEMBER'
177800110513     C                   EVAL      KF@SEQ = 0
177900110513     C                   EVAL      ENR@IN = M@ENR(M#CNE)
178000110513     C                   EXSR      $ENROLL
178100110513     C                   EVAL      X@TIER = ENR@OUT
178200110513     C                   ELSE
178300110513     C                   EVAL      X@TIER = *BLANKS
178400110513     C                   ENDIF
178500110513    ***
178600140313     C                   EVAL      KF@SPCD = 'MED'
178700140313     C                   EVAL      M@PCP = *BLANKS
178800140313     C                   EVAL      M@NPI = *BLANKS
178900140313     C                   EVAL      M@PCPCI = *BLANKS
179000140313    ***
179100140313     C                   EXSR      $PCP
179200140313    ***
179300140313     C                   IF        DOCTOR <> *BLANKS
179400140313     C                   EVAL      M@PCP = DOCTOR
179500140313     C                   EVAL      M@NPI = 'Y'
179600140313     C                   EVAL      M@PCPCI = '0'
179700140313     C                   ENDIF
179800110513    ***
179900110513     C                   EXCEPT    HMOF
180000110513    ***
180100110513     C                   ENDSR
180200110513   S***S
180300110513     C     $MEAWRT       BEGSR
180400110513    ***
180500110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
180600110513     C                   EVAL      X@ELR = CPCID2                               ELR
180700140313     C                   EVAL      E@SFX = CPCID3                               SUFFIX
180800140313     C                   EVAL      E@ACCT = CPCID4                              ACCOUNT
180900140313     C                   EVAL      E@PLAN = CPCID5                              PLAN
181000140313     C                   EVAL      E@CLM = CPCID6                               CLAIM OFFICE
181100110513    ***
181101221108       edate = M@FRM(M#CNE);
181200110513     C                   EVAL      #XSX = M@FRM(M#CNE)
181300110725     C                   IF        WRT@TYPE = 'DEPEND' AND
181400110725     C                             #XSX < M@MBREFF
181500110725     C                   MOVE      M@MBREFF      X@EFF
181600110725     C                   ELSE
181700110725     C                   MOVE      #XSX          X@EFF
181800110725     C                   ENDIF
181900110513    ***
181901221108       tdate = M@TRM(M#CNE);
182000110513     C                   EVAL      #XSX = M@TRM(M#CNE)
182100110513     C                   IF        #XSX = 0 OR #XSX = 99999999
182200110513     C                   MOVE      *BLANKS       X@TRM
182300110513     C                   ELSE
182400160809     C****               MOVE      #XSX          X@TRM
182500160809       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
182600160809       if %subdt(work_date:*d) = 01 ;
182700160809        work_date -= %days(1) ;
182800160809        num_date = %dec(work_date:*iso);
182900160809        X@TRM = %EDITC(num_date:'X');
183000160809       endif;
183001221108
183002221108       if edate = tdate;
183003221108        X@TRM = %editc(tdate:'X');
183004221108       endif;
183100160809
183200110513     C                   ENDIF
183300110513    ***
183400140313     C                   MOVE      *BLANKS       E@CBREXP
183500140313     C                   MOVE      *BLANKS       E@CBREVT
183600140313     C                   MOVE      *BLANKS       E@CBRLEN
183700140313     C                   IF        WRT@TYPE = 'MEMBER'
183800140425     C                   IF        EMPST = 'C' AND
183900140425     C                             CEXPDT > 0
184000140313     C                   MOVE      CEXPDT        E@CBREXP
184100140313     C                   MOVE      QEDT          E@CBREVT
184200140313     C                   MOVE      CEXPDT        #MINUEND
184300140313     C                   MOVE      QEDT          #SUBTRAEND
184400140313     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
184500140313     C                   Z-ADD     #DIFFRNC      #2S0
184600140313     C                   MOVE      #2S0          E@CBRLEN
184700140313     C                   ENDIF
184800140313     C                   ENDIF
184900140313    ***
185000140313     C                   EVAL      *IN80 = *OFF
185100140313     C                   EVAL      KF@SPCD = 'MED'
185200140313     C                   EVAL      E@PCP = *BLANKS
185300140313     C                   EXSR      $PCP
185400140313     C                   IF        DOCTOR <> *BLANKS
185500140313     C                   EVAL      E@PCP = DOCTOR
185600140313     C                   EVAL      *IN80 = *ON
185700140313     C                   ENDIF
185800140313    ***
185900140313     C                   EXCEPT    MEAF
186000110513    ***
186100110513     C                   ENDSR
186200110513   S***S
186300140313     C     $PCP          BEGSR
186400140313    ***
186500140313     C                   MOVE      *BLANKS       DOCTOR            7
186600140313     C     KL#SQPCD      CHAIN     PCPR
186700140313     C                   IF        NOT %FOUND(PCPL1)
186800140313     C                   LEAVESR
186900140313     C                   ENDIF
187000140313     C     KL#SQPCD      SETLL     PCPR
187100140313     C                   DOU       %EOF(PCPL1)
187200140313     C     KL#SQPCD      READE     PCPR
187300140313     C                   IF        NOT %EOF(PCPL1) AND PCCAN = 0
187400140313     C                   MOVEL(P)  PCID#         DOCTOR
187500140313     C                   LEAVESR
187600140313     C                   ENDIF
187700140313     C                   ENDDO
187800140313    ***
187900140313     C                   ENDSR
188000140313   S***S
188100110513     C     $CLRDCV       BEGSR
188200110513    ***
188300110513     C                   MOVE      *BLANKS       @LN
188400110513     C                   MOVEL     *BLANKS       @FN
188500110513     C                   EVAL      @SS2   = *BLANKS
188600110513     C                   EVAL      @MI    = *BLANKS
188700110513     C                   EVAL      @REL   = *BLANKS
188800110513     C                   EVAL      @SEX   = *BLANKS
188900110513     C                   EVAL      @DOB   = *BLANKS
189000110513     C                   EVAL      @SPEC  = *BLANKS
189100110513     C                   EVAL      @COB   = *BLANKS
189200110513     C                   EVAL      @COBC  = *BLANKS
189300110513     C                   EVAL      @COBN  = *BLANKS
189400110513    ***
189500110513     C                   EVAL      #CANCEL = 0
189600110513     C                   EVAL      D#CNE = 0
189700110513     C                   CLEAR                   D@PLN
189800110513     C                   CLEAR                   D@ENR
189900110513     C                   CLEAR                   D@FRM
190000110513     C                   CLEAR                   D@TRM
190100110513     C                   EVAL      M#CNE = 0
190200110513     C                   CLEAR                   M@PLN
190300110513     C                   CLEAR                   M@ENR
190400110513     C                   CLEAR                   M@FRM
190500110513     C                   CLEAR                   M@TRM
190600110513    ***
190700110513     C                   ENDSR
190800110513   S***S
190900110513     C     $DENWRT       BEGSR
191000110513    ***
191100110513    *C                   EVAL      X@LAY = CPCID1                               LAYOUT
191200110513    *C                   EVAL      X@ELR = CPCID2                               ELR
191300110513    *C                   EVAL      D@SFX = CPCID3                               SUFFIX
191400110513    *C                   EVAL      D@ACCT = CPCID4                              ACCOUNT
191500110513    *C                   EVAL      D@PLAN = CPCID5                              PLAN
191600110513    *C                   EVAL      D@CLM = CPCID6                               CLAIM OFFICE
191700110524     C                   EVAL      DNTLATE = '0'
191800110513    ***
191801221108       edate = D@FRM(D#CNE);
191900110513    *C                   EVAL      #XSX = D@FRM(D#CNE)
192000110725     C                   IF        WRT@TYPE = 'DEPEND' AND
192100110725     C                             #XSX < D@MBREFF
192200110725     C                   MOVE      D@MBREFF      X@EFF
192300110725     C                   ELSE
192400110725     C                   MOVE      #XSX          X@EFF
192500110725     C                   ENDIF
192600110513    ***
192601221108       tdate = D@TRM(D#CNE);
192700110513    *C                   EVAL      #XSX = D@TRM(D#CNE)
192800110513    *C                   IF        #XSX = 0 OR #XSX = 99999999
192900110513    *C                   MOVE      *BLANKS       X@TRM
193000110513    *C                   ELSE
193100160809    *C****               MOVE      #XSX          X@TRM
193200160809       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
193300160809       if %subdt(work_date:*d) = 01 ;
193400160809        work_date -= %days(1) ;
193500160809        num_date = %dec(work_date:*iso);
193600160809        X@TRM = %EDITC(num_date:'X');
193700160809       endif;
193701221108
193702221108       if edate = tdate;
193703221108        X@TRM = %editc(tdate:'X');
193704221108       endif;
193800160809
193900110513    *C                   ENDIF
194000110513    ***
194100130211     C                   MOVE      *BLANKS       D@CBREXP
194200130211     C                   MOVE      *BLANKS       D@CBREVT
194300130211     C                   MOVE      *BLANKS       D@CBRLEN
194400110513     C                   IF        WRT@TYPE = 'MEMBER'
194500111123    *C                   IF        EMPST = 'C' AND CEXPDT <> 0
194600110513    *C                   MOVE      CEXPDT        D@CBREXP
194700110513    *C                   MOVE      QEDT          D@CBREVT
194800110513    *C                   MOVE      CEXPDT        #MINUEND
194900110513    *C                   MOVE      QEDT          #SUBTRAEND
195000110513    *C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
195100110513    *C                   Z-ADD     #DIFFRNC      #2S0
195200110513    *C                   MOVE      #2S0          D@CBRLEN
195300110513    *C                   ENDIF
195400110513    *C                   ENDIF
195500120806    ***
195600110513    *C                   MOVE      '0'           D@OOAI
195700140313    ***
195800140313     C                   EVAL      KF@SPCD = 'DEN'
195900140313     C                   EVAL      D@PCD = *BLANKS
196000140313     C                   EVAL      *IN81 = *OFF
196100140313     C                   MOVE      *BLANKS       DOCTOR
196200140313    ***
196300140313     C                   EXSR      $PCP
196400140313    ***
196500140313     C                   IF        DOCTOR <> *BLANKS
196600140313     C                   EVAL      D@PCD = DOCTOR
196700140313     C                   EVAL      *IN81 = *ON
196800140313     C                   ENDIF
196900110513    ***
197000120123     C     *LIKE         DEFINE    H@C#          BUC#
197100120123     C                   EVAL      BUC# = H@C#
197200120123    ***
197300200124     C****               if        cacid8 > ' ' and cacid8 <> 'N/A'
197400200124     C****               eval      h@c# = cacid8
197500200124     C****               endif
197600151106
197700120327     C                   SELECT
197800151106     C****               WHEN      KF@TRS = 591 AND KF@SUB = 009 AND            WILMOT MODULAR
197900151106     C****                         KF@ACC = 0202                                 STRUCTURES
198000151106     C****               EVAL      H@C# = '0638156'
198100151106
198200151106     C****               WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            REDLAND
198300151106     C****                         KF@ACC = 0475                                 BAPTISTS
198400151106     C****               EVAL      H@C# = '0725572'
198500151106
198600151106     C****               WHEN      KF@TRS = 825 AND KF@SUB = 001 AND            CREATIVE
198700151106     C****                         KF@ACC = 0014                                 LOGISTICS
198800151106     C****               EVAL      H@C# = '0133860'
198900151106
199000151015     C****               WHEN      KF@TRS = 905 AND KF@SUB = 001 AND            CCL USA
199100151015     C****                         KF@ACC = 0092
199200151015     C****               EVAL      H@C# = '0638423'
199300151106
199400151106     C****               WHEN      KF@TRS = 003 AND KF@SUB = 001 AND            FRAME RITE
199500151106     C****                         KF@ACC = 0104
199600151106     C****               EVAL      H@C# = '0306511'
199700151106
199800151106     C****               WHEN      KF@TRS = 900 AND KF@SUB = 003 AND            PERFECT
199900151106     C****                         KF@ACC = 0045                                 SETTINGS
200000151106     C****               EVAL      H@C# = '0474109'
200100151106
200200151106     C****               WHEN      KF@TRS = 591 AND KF@SUB = 011 AND            MCCALLISTER
200300151106     C****                         KF@ACC = 0446                                 ARCHITECT
200400151106     C****               EVAL      H@C# = '0565330'
200500151106
200600151106     C****               WHEN      KF@TRS = 591 AND KF@SUB = 005 AND            JD CLARK PROF
200700151106     C****                         KF@ACC = 0451                                 SERVICES
200800151106     C****               EVAL      H@C# = '0519890'
200900151106
201000151106     C****               WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            DYSON CONSTRUCTION
201100151106     C****                         KF@ACC = 0459                                 COMPANY
201200151106     C****               EVAL      H@C# = '0788122'
201300151106
201400151106     C****               WHEN      KF@TRS = 591 AND KF@SUB = 004 AND            STROUSE CORP
201500151106     C****                         KF@ACC = 0482
201600151106     C****               EVAL      H@C# = '0837451'
201700151106
201800151106     C****               WHEN      KF@TRS = 900 AND KF@SUB = 007 AND            CAPLAN BROTHERS
201900151106     C****                         KF@ACC = 0075
202000151106     C****               EVAL      H@C# = '0837533'
202100151106
202200151106     C****               WHEN      KF@TRS = 900 AND KF@SUB = 101 AND            INTEGRA HEALTH
202300151106     C****                         KF@ACC = 0042 AND
202400151106     C****                         (STATE = 'TN' OR STATE = 'FL' OR
202500151106     C****                          STATE = 'OH' OR STATE = 'MA') AND
202600151106     C****                         (@PLANIN = 'DAAD' OR @PLANIN = 'BAAD')
202700151106     C****               EVAL      H@C# = '0503428'
202800120123    ***
202900151106     C****               WHEN      KF@TRS = 905 AND KF@SUB = 001 AND            CCL USA
203000151106     C****                         KF@ACC = 0092
203100151106     C****               eval      x@eff =  '20150901'
203200151106     C****               EVAL      H@C# = '0536514'
203300151106      ****
203400151106    *C                   ENDSL
203500151015
203600110513    *C                   EXCEPT    DENF
203700120123     C                   EVAL      H@C# = BUC#
203800110513    ***
203900110513    *C                   ENDSR
204000110513   S***S
204100110512   X***X
204200110802     OAET080WF  EADD         HDRF
204300101203     O                                            6 'HEADER'
204400101229     O                                            8 'P'
204500101206     O                       H@SI                28
204600101203     O                                           29 '0'
204700101203     O                       C1                  43
204800101203     O                       D1                  51
204900101203     O                       T1                  57
205000101206     O                                          131 'CONSOLIDATED ELIGIBILITY'
205100110502     O                       H@RI               167
205200101206     O                       H@CC               169
205300101228     O                       H@GN               176
205400101206     O                       H@CN               191
205500101206     O                       H@C#               198
205600101203     O                       D2                 206
205700110825     O                                          216 'MC'
205800101223     O                                          231 '*'
205900110802     OAET080WF  EADD         MBRF
206000101203     O                                            6 'MEMBER'
206100101203     O                       @SS1                16
206200101203     O                       @SS2                25
206300101203     O                       @FN                 75
206400101203     O                       @MI                 76
206500101203     O                       @LN                 96
206600101203     O                       @REL               101
206700101203     O                       @SEX               103
206800101203     O                       @DOB               111
206900101203     O                       @SPEC              112
207000101203     O                                          113 '0'
207100101203     O                       @COB               123
207200101203     O                       @COBC              125
207300101203     O                       @COBN              145
207400101203     O                       @AD1               175
207500101203     O                       @AD2               205
207600101203     O                       @CTY               315
207700101203     O                       @ST                317
207800101203     O                       @ZP5               322
207900101203     O                       @PHN               349
208000141211     O               87                         576 '21207'
208100140626     O               88                         576 '21740'
208200141120     O               89                         576 '20171'
208300101203     O                       @EMPST             665
208400101203     O                       @HIRE              673
208500101223     O                                         1231 '*'
208600110802     OAET080WF  EADD         HMOF
208700101213     O                                            7 'BENEFIT'
208800101213     O                       X@LAY               10
208900101214     O                       X@ELR               24
209000101213     O                       M@CC                26
209100101213     O                       H@GN                38
209200101213     O                       M@CLASS             44
209300101213     O                       M@PLAN              50
209400101213     O                       X@EFF               58
209500110929     O                       X@TRM               66
209600101213     O                       X@TIER              69
209700101213     O                       M@PCP              160
209800101213     O                       M@NPI              161
209900101213     O                       M@PCPCI            186
210000101223     O                                          323 '*'
210100140313     OAET080WF  EADD         MEAF
210200140313     O                                            7 'BENEFIT'
210300160601     O                                           10 'VIS'
210400140313     O                       X@ELR               24
210500140313     O                       H@C#                31
210600140313     O                       E@SFX               34
210700140313     O                       E@ACCT              44
210800140313     O                       E@PLAN              50
210900140313     O                       X@EFF               58
211000140313     O                       X@TRM               66
211100140313     O                       E@CLM               71
211200140313     *** PCP BGN
211300140313     O                       E@PCP              127
211400140313     O               80                         161 'N'
211500140313     O               80                         186 '0'
211600140313     *** PCP END
211700140313     O                                          389 '0'
211800140313     *** COBRA BGN
211900140313     O                       E@CBREXP           466
212000140313     O                       E@CBREVT           516
212100140313     O                       E@CBRLEN           560
212200140313     *** COBRA END
212300140313     O                                          678 '*'
212400140313    ***
212500110802     OAET080WF  EADD         DENF
212600101213     O                                            7 'BENEFIT'
212700101213     O                       X@LAY               10
212800101214     O                       X@ELR               24
212900101214     O                       H@C#                31
213000101213     O                       D@SFX               34
213100101213     O                       D@ACCT              44
213200101213     O                       D@PLAN              50
213300101213     O                       X@EFF               58
213400110929     O                       X@TRM               66
213500101213     O                       D@CLM               71
213600140313     *** PCD BGN
213700140313     O                       D@PCD              200
213800140313     O               81                         236 '0'
213900140313     *** PCD END
214000140313     O                                          389 '0'
214100140313     *** COBRA BGN
214200140313     O                       D@CBREXP           466
214300140313     O                       D@CBREVT           516
214400140313     O                       D@CBRLEN           560
214500140313     *** COBRA END
214600140313     O                       D@OOAI             609
214700140313     O                                          678 '*'
214800140313    ***
214900130315     OAET080WF  EADD         LIFF
215000130315     O                                            7 'BENEFIT'
215100130412     O                                           11 'LIFE'
215200130315     O                       X@ELR               24
215300130319     O                       H@C#3               31
215400130315     O                       L@SFX               34
215500130315     O                       L@ACCT              44
215600130315     O                       L@PLAN              50
215700130315     O                       X@EFF               58
215800130315     O                       X@TRM               66
215900130315     O                       L@CLM               71
216000130315     O                       L@CBREXP           466
216100130315     O                       L@CBREVT           516
216200130315     O                       L@CBRLEN           560
216300130315     O                       L@SALARY           658
216400130315     O                                          659 '1'
216500130315     O                                          678 '*'
216600110802     OAET080WF  EADD         TRLF
216700101203     O                                            7 'TRAILER'
216800101203     O                       @TREC               17
216900101203     O                       D1                  25
217000101203     O                       T1                  31
217100101203     O                       @BREC               41
217200101223     O                                           69 '*'
