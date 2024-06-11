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
003300101206   X***X
003400130315     F*CARXPTP   IF   E           K DISK
003500101012     FCARACCP   IF   E           K DISK
003600160829
003700101012     FCARPLNP   IF   E           K DISK
003800160829
003900160829     FAET004WF  IF   E           K DISK
004000120803     ** MAPPING METHOD
004100160829
004200160829     FAET1050WF O  A F 1231        DISK
004300101206     ** FLAT FILE
004400160829
004500160829     FAET1051WF IF A E           K DISK
004600101028     ** TERM TRACKER
004700160829
004800101012     FMEMAC#1   IF   E           K DISK
004900160829
005000101012     FMCOVMPLN  IF   E           K DISK
005100160829
005200101012     FDEPNDC    IF   E           K DISK
005300160829
005400101012     FDCOVA     IF   E           K DISK
005500160829
005600140313     FPCPL1     IF   E           K DISK
005700160829
005800160829      *=================================================================================
005900160829
006000120803     D KF@CCTL         S             10A   INZ
006100160829     D grouper         S             10A
006200160831     D p_trst          S              3  0
006300160831     D p_sub#          S              3  0
006400160831     D p_acct          S              4  0
006500160829
006600160829     D CARR#CTL        S             10A
006700160829
006800110512     D H@RI            S             25A   INZ('042064683')                     RECEIVER ID
006900160829
007000110512     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
007100101026     D DS@CARACC     E DS                  EXTNAME(CARACCP)
007200130315     D*DS@CARXPT     E DS                  EXTNAME(CARXPTP)
007300101026   X***X
007400110512     ** WORK ARRAY FOR PLANS
007500110512     **
007600110512     ** PC# - PLAN COUNT
007700110512     ** PP# - PLAN POINTER
007800110512     **
007900110512     D CARPLN@       E DS                  EXTNAME(CARPLNP)
008000160902     D                                     OCCURS(900) PREFIX(X:1)
008100110512     D PC#             S              3S 0
008200110512     D PP#             S              3S 0
008300110512     D @PLANIN         S              4A
008400110512     D @CCTRIN         S              3A
008500110513   X***X
008600110513     **
008700110513     ** WRITE TYPE = MEMBER OR DEPEND
008800110513     D WRT@TYPE        S              6A
008900110513     **
009000110512   X***X
009100101214     D #XST            S              6S 0
009200101214     D #IST            S               T
009300101026     D #ISO            S               D   DATFMT(*ISO)
009400101214     D #MINUEND        S               D   DATFMT(*ISO)
009500101214     D #SUBTRAEND      S               D   DATFMT(*ISO)
009600101214     D @DATE           S              8A
009700101214     D @TIME           S              6A
009800101214     D #DIFFRNC        S              5S 0
009900101214     D #2S0            S              2S 0
010000101214     D #CANCEL         S              8S 0
010100101026     D #XSX            S              8S 0
010200101026     D #XSX2           S              8S 0
010300101026     D DATE@OUT        S             10A
010400101026     D ENR@IN          S              3A
010500101026     D ENR@OUT         S              1A
010600110524     D DNTLATE         S              1A
010700130315     D TERM_LIF        S               N
010800101214     D TERM_DEN        S               N
010900101214     D TERM_MED        S               N
011000101026     D YES             S               N   INZ(*ON)
011100101026     D NO              S               N   INZ(*OFF)
011200160829     D firstTime       S              1    INZ('Y')
011300160829
011400110512     D KF@TRS          S                   LIKE(MCTRST)
011500110512     D KF@SUB          S                   LIKE(MCSUB#)
011600110512     D KF@ACC          S                   LIKE(ACC#)
011700101026     D KF@ENR          S              3A   INZ
011800101026     D KF@CARG         S              2A   INZ
011900101026     D KF@CCTR         S                   LIKE(CCFLG)
012000101026     D KF@PLN          S                   LIKE(MCPLAN)
012100101026     D KF@TRM          S                   LIKE(NTTERMDT)
012200101026     D KF#TRM          S              8S 0
012300101026     D KF@SSN          S                   LIKE(MBSSNO)
012400101026     D KF@SEQ          S                   LIKE(DPSEQ#)
012500101026     D KF@TYP          S              1A
012600101026     D KF@CDE          S              2A
012700140313     D KF@SPCD         S              5A
012800140313     D KF@MPLN         S              4A
012900140313     **
013000101026     D M@EARLYP        S              4A
013100101026     D M#EARLYE        S              8S 0 INZ
013200101026     D M#EARLYT        S              8S 0 INZ
013300140313     **
013400101026     D #8D1            S              8S 0 INZ
013500101214     D D1              S              8A
013600101214     D D2              S              8A
013700101214     D T1              S              6A
013800101214     D C1              S             14A
013900101206    ***
014000101029     D B#RECCNT        S             10S 0 INZ
014100101029     D C#RECCNT        S             10S 0 INZ
014200101206    ***
014300101210     D @SS1            S              9A
014400101210     D @SS2            S              9A
014500101210     D @FN             S             15A
014600101210     D @MI             S              1A
014700101210     D @LN             S             20A
014800101210     D @REL            S              2A
014900101210     D @SEX            S              1A
015000101210     D @DOB            S              8A
015100101210     D @SPEC           S              1A
015200101210     D @COB            S              1A
015300101210     D @COBC           S              2A
015400101210     D @COBN           S             20A
015500101210     D @AD1            S             30A
015600101210     D @AD2            S             30A
015700101214     D @CTY            S             20A
015800101210     D @ST             S              2A
015900101210     D @ZP5            S              5A
016000101210     D @PHN            S             10A
016100101210     D @EMPST          S              2A
016200101210     D @HIRE           S              8A
016300101206    ***
016400130315    *** LIFE ARRAYS
016500130315     D L#CNE           S              3S 0 INZ
016600130315     D L#NDX           S              3S 0 INZ
016700130315     D L@PLN           S              4A   DIM(20)
016800130315     D L@ENR           S              3A   DIM(20)
016900130315     D L@FRM           S              8S 0 DIM(20)
017000130315     D L@TRM           S              8S 0 DIM(20)
017100130315     D L@MBREFF        S              8S 0
017200140313    ***
017300101206    *** DENTAL ARRAYS
017400101206     D D#CNE           S              3S 0 INZ
017500101206     D D#NDX           S              3S 0 INZ
017600101206     D D@PLN           S              4A   DIM(20)
017700101206     D D@ENR           S              3A   DIM(20)
017800101206     D D@FRM           S              8S 0 DIM(20)
017900101206     D D@TRM           S              8S 0 DIM(20)
018000110725     D D@MBREFF        S              8S 0
018100140313    ***
018200101206    *** MEDICAL ARRAYS
018300101206     D M#CNE           S              3S 0 INZ
018400101206     D M#NDX           S              3S 0 INZ
018500101206     D M@PLN           S              4A   DIM(20)
018600101206     D M@ENR           S              3A   DIM(20)
018700101206     D M@FRM           S              8S 0 DIM(20)
018800101206     D M@TRM           S              8S 0 DIM(20)
018900110725     D M@MBREFF        S              8S 0
019000101206    ***
019100101206     D H@SI            S             20A
019200101206     D H@CC            S              2A
019300101206     D H@GN            S              7A
019400101206     D H@CN            S             15A
019500101206     D H@C#            S              7A
019600130319     D H@C#3           S              7A
019700140313    ***
019800101213     D X@LAY           S              3A
019900101213     D X@ELR           S              7A
020000140313     D X@EFF           S              8A
020100140313     D X@TRM           S              8A
020200140313     D X@TIER          S              1A
020300140313    ***
020400101213     D M@CC            S              2A
020500101213     D M@CLASS         S              5A
020600101213     D M@PLAN          S              6A
020700101213     D M@PCP           S             40A
020800101213     D M@NPI           S              1A
020900101213     D M@PCPCI         S              1A
021000140313    ***
021100101213     D D@SFX           S              3A
021200101213     D D@ACCT          S              5A
021300101213     D D@PLAN          S              6A
021400101213     D D@CLM           S              3A
021500101213     D D@CBREXP        S              8A
021600101213     D D@CBREVT        S              8A
021700101213     D D@CBRLEN        S              2A
021800101213     D D@OOAI          S              1A
021900140313     D D@PCD           S              7A
022000140313    ***
022100101214     D @STEP           S              5A
022200140313    ***
022300140313     D E@SFX           S              3A
022400140313     D E@ACCT          S              5A
022500140313     D E@PLAN          S              6A
022600140313     D E@CLM           S              3A
022700140313     D E@PCP           S              7A
022800140313     D E@CBREXP        S              8A
022900140313     D E@CBREVT        S              8A
023000140313     D E@CBRLEN        S              2A
023100140313    ***
023200130315     D L@SFX           S              3A
023300130315     D L@ACCT          S              5A
023400130315     D L@PLAN          S              6A
023500130315     D L@CLM           S              3A
023600130315     D L@CBREXP        S              8A
023700130315     D L@CBREVT        S              8A
023800130315     D L@CBRLEN        S              2A
023900130315     D L@SALARY        S             20A
024000140313    ***
024100160809    ***
024200160809     d num_date        s              8s 0 inz
024300160809     D work_date       s               d
024400160829
024500160829      *=================================================================================
024600160829
024700110512     C                   EVAL      @STEP = 'PREP1'
024800101214    ***
024900120803     C                   EVAL      KF@CCTL = CARR#CTL
025000160829     C**** KF@CCTL       CHAIN     CARXPTR
025100160829     C                   EXSR      $HEADR
025200110512    ***
025300160831     C     KL#ACCTL      SETLL     CARACCR
025400160831     C**** KF@CCTL       SETLL     CARACCR
025500110512    ***
025600101026     C                   DOU       @STEP = 'LEAVE'
025700101026     C     @STEP         CASEQ     'PREP1'       $PREP1
025800101026     C     @STEP         CASEQ     'STEP1'       $STEP1
025900101026     C     @STEP         CASEQ     'STEP2'       $STEP2
026000101026     C     @STEP         CASEQ     'STEP3'       $STEP3
026100101026     C     @STEP         CASEQ     'PREP4'       $PREP4
026200101026     C     @STEP         CASEQ     'STEP4'       $STEP4
026300101026     C     @STEP         CASEQ     'PREP5'       $PREP5
026400101026     C     @STEP         CASEQ     'STEP5'       $STEP5
026500101214     C     @STEP         CASEQ     'PREP6'       $PREP6
026600101026     C     @STEP         CASEQ     'STEP6'       $STEP6
026700101214     C     @STEP         CASEQ     'PREP7'       $PREP7
026800101214     C     @STEP         CASEQ     'STEP7'       $STEP7
026900101214     C     @STEP         CASEQ     'STEP8'       $STEP8
027000101214     C     @STEP         CASEQ     'PREP9'       $PREP9
027100101214     C     @STEP         CASEQ     'STEP9'       $STEP9
027200101214     C     @STEP         CASEQ     'PREPA'       $PREPA
027300101214     C     @STEP         CASEQ     'STEPA'       $STEPA
027400101214     C     @STEP         CASEQ     'PREPB'       $PREPB
027500101214     C     @STEP         CASEQ     'STEPB'       $STEPB
027600130315     C     @STEP         CASEQ     'PREPC'       $PREPC
027700130315     C     @STEP         CASEQ     'STEPC'       $STEPC
027800101026     C                   ENDCS
027900101026     C                   ENDDO
028000120711    ***
028100120711    ***  CALL SECOND PROGRAM
028200120711    ***
028300120803    *C*                  MOVE      *ALL'0'       @TADD            10
028400120803    *C*                  MOVE      *ALL'0'       @BADD            10
028500120803    *C*                  CALL      'AET081CL'
028600120803    *C*                  PARM                    @TADD
028700120803    *C*                  PARM                    @BADD
028800120803    *C*                  MOVE      @TADD         #TADD            10 0
028900120803    *C*                  ADD       #TADD         C#RECCNT
029000120803    *C*                  MOVE      @BADD         #BADD            10 0
029100120803    *C*                  ADD       #BADD         B#RECCNT
029200120711    ***
029300101206    ***  TRAILER RECORD
029400120711    ***
029500101026     C                   ADD       2             C#RECCNT
029600101214     C                   MOVE      C#RECCNT      @TREC            10 0
029700101214     C                   MOVE      B#RECCNT      @BREC            10 0
029800101214     C                   EXCEPT    TRLF
029900101026    ***
030000101026     C                   EVAL      *INLR = *ON
030100110512   S***S
030200110802     C     $HEADR        BEGSR
030300101206    ***
030400110802     C                   EVAL      D1 = @DATE
030500110802     C                   EVAL      D2 = @DATE
030600110802     C                   EVAL      T1 = @TIME
030700110802     C                   EVAL      C1 = @DATE + @TIME
030800110802    ***
030900110802     C                   EVAL      KF@TRS = 999
031000110802     C                   EVAL      KF@SUB = 999
031100110802     C                   EVAL      KF@ACC = 9999
031200110802     C     KL#ACCTL      CHAIN     CARACCR
031300110802    ***
031400110802     C                   EVAL      H@SI = %TRIM(CACID1)                         SUBMITTER ID
031500110802     C                   EVAL      H@CC = %SUBST(CACID2:1:2)                    COMPANY CODE
031600110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
031700110802     C                   MOVEL(P)  CACID4        H@CN                           CUSTOMER NAME
031800110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
031900130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
032000110802    ***
032100110802     C                   EXCEPT    HDRF
032200110802    ***
032300110802     C                   ENDSR
032400110802   S***S
032500110802     C     $PREP1        BEGSR
032600110802    ***
032700160831     C     KL#ACCTL      READE     CARACCR
032800160831     C**** KF@CCTL       READE     CARACCR
032900110512    ***
033000110512     C                   IF        %EOF(CARACCP)
033100120803      *
033200120815     C*                  IF        KF@CCTL = CARR#CTL
033300120815     C*                  EVAL      KF@CCTL = CARR#CTL2
033400120815     C*    KF@CCTL       SETLL     CARACCR
033500120815     C*                  ELSE
033600110512     C                   EVAL      @STEP = 'LEAVE'
033700120815     C*                  ENDIF
033800120803      *
033900110512     C                   LEAVESR
034000110512     C                   ENDIF
034100110512    ***
034200110513    *** HAS THE ACCOUNT BEEN SHUTOFF FOR EXPORT?
034300110513    ***
034400110512     C                   IF        CASTATUS <> 'Y'
034500110512     C                   LEAVESR
034600110512     C                   ENDIF
034700110512    ***
034800160829     C                   if        cacida <> grouper
034900160829     C                   leavesr
035000160829     C                   endif
035100160829
035200110802    *** THESE FIELDS RESET FOR EACH SMALL GROUP READ
035300110802    ***
035400110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
035500110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
035600130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
035700110802    ***
035800110512     C                   EVAL      KF@TRS = CATRST
035900110512     C                   EVAL      KF@SUB = CASUB#
036000110512     C                   EVAL      KF@ACC = CAACCT
036100110512    ***
036200110512     C                   EXSR      $PLANLOAD
036300110512    ***
036400101206     C                   EVAL      @STEP = 'STEP1'
036500110512    ***
036600110512     C                   ENDSR
036700110512   S***S
036800101206     C     $STEP1        BEGSR
036900101206    ***
037000101206     C                   EVAL      KF@PLN = *BLANKS
037100101206     C                   EVAL      KF@TRM = 0
037200101206     C                   EVAL      KF@SSN = 0
037300101206     C                   EVAL      KF@SEQ = 0
037400110512    ***
037500101206     C     KL#TSA        SETLL     MEMBR
037600101206    ***
037700101206     C                   EVAL      @STEP = 'STEP2'
037800101206    ***
037900101206     C                   ENDSR
038000101206   S***S
038100101206     C     $STEP2        BEGSR
038200101206    ***
038300101206     C     KL#TSA        READE     MEMBR
038400101206    ***
038500101206     C                   IF        %EOF(MEMAC#1)
038600110512     C                   EVAL      @STEP = 'PREP1'
038700101206     C                   LEAVESR
038800101206     C                   ENDIF
038900101206    ***
039000101206     C                   EVAL      KF@SSN = MBSSNO
039100101214     C                   MOVE      *ZEROS        KF@SEQ
039200120803     C                   EVAL      WRT@TYPE = 'MEMBER'
039300120803    ***
039400101214    ***
039500101206     C     KL#MPLN       SETLL     MCOVR
039600101206    ***
039700101206     C                   EXSR      $CLRSTG
039800101206    ***
039900101206     C                   EVAL      @STEP = 'STEP3'
040000101206    ***
040100101206     C                   ENDSR
040200101210   S***S
040300101206     C     $STEP3        BEGSR
040400101206    ***
040500101206     C     KL#MPLN       READE     MCOVR
040600101206    ***
040700101206     C                   IF        %EOF(MCOVMPLN)
040800101206     C                   EVAL      @STEP = 'PREP4'
040900101206     C                   LEAVESR
041000101206     C                   ENDIF
041100101206    ***
041200130131     C*                  IF        ENRLDT = CANDT
041300130131     C*                  LEAVESR
041400130131     C*                  ENDIF
041500120803    ***
041600120803     C                   EVAL      KF@PLN = MCPLAN
041700160829     C     KL#TSAP       CHAIN     AEF04
041800160829     C                   IF        NOT %FOUND(AET004WF)
041900120803     C                   LEAVESR
042000120803     C                   ENDIF
042100110513    ***
042200110512     C                   EVAL      @PLANIN = MCPLAN
042300111020     C                   EVAL      ENR@IN = MCOVTP
042400110802    ***
042500110802     C                   EXSR      $QUIK
042600110802    ***
042700110512     C                   EXSR      $PLANSRCH
042800110512    ***
042900110512     C                   IF        PLN@CAT = *BLANKS
043000110512     C                   LEAVESR
043100110512     C                   ENDIF
043200101206    ***
043300101206     C                   IF        CANDT = 0
043400101206     C                   EVAL      #CANCEL = 99999999
043500101206     C                   ELSE
043600101206     C                   EVAL      #CANCEL = CANDT
043700101206     C                   ENDIF
043800101206    ***
043900130315    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL;
044000130315    *** LIF IS LIFE;
044100110513    ***
044200130315     C                   SELECT
044300130315      *
044400160224    *C****               WHEN      PLN@CAT = 'LIFE'
044500160224    *C****               IF        L#CNE > 0
044600160224    *C****               IF        L@TRM(L#CNE) = 99999999
044700160224     C****               LEAVESR
044800160224     C****               ENDIF
044900160224     C****               ENDIF
045000160224    *C****               ADD       1             L#CNE
045100160224    *C****               EVAL      L@PLN(L#CNE) = MCPLAN
045200160224    *C****               EVAL      L@ENR(L#CNE) = MCOVTP
045300160224    *C****               EVAL      L@FRM(L#CNE) = ENRLDT
045400160224    *C****               EVAL      L@TRM(L#CNE) = #CANCEL
045500130315      *
045600160224    *C****               WHEN      PLN@CAT = 'DEN'
045700160224    *C****               IF        D#CNE > 0
045800160224    *C****               IF        D@TRM(D#CNE) = 99999999
045900160224     C****               LEAVESR
046000160224     C****               ENDIF
046100160224     C****               ENDIF
046200160224    *C****               ADD       1             D#CNE
046300160224    *C****               EVAL      D@PLN(D#CNE) = MCPLAN
046400160224    *C****               EVAL      D@ENR(D#CNE) = MCOVTP
046500160224    *C****               EVAL      D@FRM(D#CNE) = ENRLDT
046600160224    *C****               EVAL      D@TRM(D#CNE) = #CANCEL
046700160224      ****
046800160224    *C                   WHEN      PLN@CAT = 'VIS '
046900160224    *C                   IF        M#CNE > 0
047000160224    *C                   IF        M@TRM(M#CNE) = 99999999
047100160224     C                   LEAVESR
047200160224     C                   ENDIF
047300160224     C                   ENDIF
047400160224     C                   ADD       1             M#CNE
047500160224     C                   EVAL      M@PLN(M#CNE) = MCPLAN
047600101206     C                   EVAL      M@ENR(M#CNE) = MCOVTP
047700101206     C                   EVAL      M@FRM(M#CNE) = ENRLDT
047800101206     C                   EVAL      M@TRM(M#CNE) = #CANCEL
047900130315      *
048000130315    *C                   ENDSL
048100110512    ***
048200110512     C                   ENDSR
048300110512   S***S
048400110802     C     $QUIK         BEGSR
048500110802    ***
048600110805     C                   EVAL      @CCTRIN = *BLANKS
048700120803    ***
048800160829     C     AE4MAP        CASEQ     '2TIER     '  $METH01
048900160829     C     AE4MAP        CASEQ     'ITOBJECTS '  $METH02
049000160829     C     AE4MAP        CASEQ     'NORULE    '  $METH03
049100160829     C     AE4MAP        CASEQ     'STATETIER '  $METH04
049200160829     C     AE4MAP        CASEQ     'TIERSTS   '  $METH05
049300160829     C     AE4MAP        CASEQ     'MAYOR     '  $METH06
049400160829     C     AE4MAP        CASEQ     'EMPSTS    '  $METH07
049500160829     C     AE4MAP        CASEQ     'JUSTSTATE '  $METH08
049600160829     C     AE4MAP        CASEQ     'JOHNLS    '  $METH09
049700160829     C     AE4MAP        CASEQ     'CREATIVE  '  $METH10
049800160829     C     AE4MAP        CASEQ     'INTEGRA   '  $METH11
049900160829     C     AE4MAP        CASEQ     'STSTATE   '  $METH12
050000160829     C     AE4MAP        CASEQ     'INTEGRA   '  $METH11
050100160829     C     AE4MAP        CASEQ     'STIERSTS  '  $METH13
050200120803     C                   ENDCS
050300120803    ***
050400120803     C                   ENDSR
050500120803   S***S
050600120803    *** 2 TIER = AETNA HAS TWO TIERS, IND AND FAM
050700120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'IND' AND NON-'TIN' CONVERTED TO 'FAM'
050800120803    ***  DEPENDENTS HAVE 'FAM' ONLY
050900120803    ***
051000120803    *** IND, FAM
051100120803    ***
051200120803     C     $METH01       BEGSR
051300120803    ***
051400120803     C                   IF        WRT@TYPE = 'MEMBER'
051500120803    *** *
051600120803     C                   IF        ENR@IN = 'TIN'
051700120803     C                   EVAL      @CCTRIN = 'IND'
051800120803     C                   ELSE
051900120803     C                   EVAL      @CCTRIN = 'FAM'
052000120803     C                   ENDIF
052100120803    *** *
052200120803     C                   ENDIF
052300120803    ***
052400120803     C                   IF        WRT@TYPE = 'DEPEND'
052500120803    *** *
052600120803     C                   EVAL      @CCTRIN = 'FAM'
052700120803    *** *
052800120803     C                   ENDIF
052900120803    ***
053000120803     C                   ENDSR
053100120803   S***S
053200120803    *** ITOBJECTS = IF YOU ARE NOT 'VA' OR 'OH' STATE CODES, YOU ARE 'XX'
053300120803    ***
053400120803    *** VA, OH, XX
053500120803    ***
053600120803     C     $METH02       BEGSR
053700120803    ***
053800120803     C                   IF        STATE <> 'VA' AND STATE <> 'OH'
053900120803     C                   EVAL      @CCTRIN = 'XX '
054000120803     C                   ELSE
054100120803     C                   EVAL      @CCTRIN = STATE
054200120803     C                   ENDIF
054300120803    ***
054400120803     C                   ENDSR
054500120803   S***S
054600120803    *** NORULE = NUFF SAID
054700120803    ***
054800120803     C     $METH03       BEGSR
054900120803    ***
055000120803     C                   EVAL      @CCTRIN = *BLANKS
055100120803    ***
055200120803     C                   ENDSR
055300120803   S***S
055400120803    *** STATETIER
055500120803    ***  START WITH STATE CODE
055600120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
055700120803    ***  DEPENDENTS HAVE 'F' ONLY
055800120803    ***
055900120803    *** MDI, MDF, ETC...
056000120803    ***
056100120803     C     $METH04       BEGSR
056200120803    ***
056300120803     C                   EVAL      @CCTRIN = STATE
056400120803    ***
056500120803     C                   IF        WRT@TYPE = 'MEMBER'
056600120803     C                   IF        ENR@IN = 'TIN'
056700120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
056800120803     C                   ELSE
056900120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
057000120803     C                   ENDIF
057100120803     C                   ENDIF
057200120803    ***
057300120803     C                   IF        WRT@TYPE = 'DEPEND'
057400120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
057500120803     C                   ENDIF
057600120803    ***
057700120803     C                   ENDSR
057800120803   S***S
057900120803    *** TIERSTS
058000120803    ***  START WITH EMPLOYMENT STATUS, ACTIVE IS 'ACT' AND COBRA IS 'COB'
058100120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
058200120803    ***  DEPENDENTS HAVE 'F' ONLY
058300120803    ***
058400120803    *** ACI, ACF, COI, COF
058500120803    ***
058600120803     C     $METH05       BEGSR
058700120803    ***
058800120803     C                   IF        EMPST =  'C'
058900120803     C                   EVAL      @CCTRIN = 'COB'
059000120803     C                   ELSE
059100120803     C                   EVAL      @CCTRIN = 'ACT'
059200120803     C                   ENDIF
059300120803    ***
059400120803     C                   IF        ENR@IN = 'TIN'
059500120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
059600120803     C                   ELSE
059700120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
059800120803     C                   ENDIF
059900120803    ***
060000120803     C                   ENDSR
060100120803   S***S
060200120803    *** MAYOR
060300120803    ***  WELL, FOR THE PLAN 'DAAU' IF THE STATE IS 'WV' THEN PLACE TIER STATUS SUFFIX
060400120803    ***       BY TYPE OF PEEP; FOR OTHER STATES, USE A SIMPLE TIER CHECK.
060500120803    ***
060600120803    ***  WVI, WVF, IND, FAM
060700120803    ***
060800120803    ***  NOW, FOR THE PLAN 'DAAT' IF THE STATE IS 'WV' THEN PLACE EMPLOYMENT STATUS SUFFIX
060900120803    ***       BY TYPE OF PEEP; FOR OTHER STATES, EMPLOYMENT STATUS AND TIER.
061000120803    ***
061100120803    ***  WVI, WVF, CBI, CBF, ACI, ACF
061200120803    ***
061300120803    ***
061400120803     C     $METH06       BEGSR
061500120803    ***
061600120803    1C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'MEMBER'
061700120803      *
061800120803    2C                   IF        STATE = 'WV'
061900120803      **
062000120803    3C                   IF        ENR@IN = 'TIN'
062100120803     C                   EVAL      @CCTRIN = 'WVI'
062200120803    3C                   ELSE
062300120803     C                   EVAL      @CCTRIN = 'WVF'
062400120803    3C                   ENDIF
062500120803      **
062600120803    2C                   ELSE
062700120803      **
062800120803    3C                   IF        ENR@IN = 'TIN'
062900120803     C                   EVAL      @CCTRIN = 'IND'
063000120803    3C                   ELSE
063100120803     C                   EVAL      @CCTRIN = 'FAM'
063200120803    3C                   ENDIF
063300120803      **
063400120803    2C                   ENDIF
063500120803      *
063600120803     C                   LEAVESR
063700120803    1C                   ENDIF
063800120803    ***
063900120803     C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'DEPEND'
064000120803      *
064100120803     C                   IF        STATE = 'WV'
064200120803     C                   EVAL      @CCTRIN = 'WVF'
064300120803     C                   ELSE
064400120803     C                   EVAL      @CCTRIN = 'FAM'
064500120803     C                   ENDIF
064600120803      *
064700120803     C                   LEAVESR
064800120803     C                   ENDIF
064900120803    ***
065000120803    1C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'MEMBER'
065100120803      *
065200120803    2C                   IF        STATE = 'WV'
065300120803      **
065400120803    3C                   IF        ENR@IN = 'TIN'
065500120803     C                   EVAL      @CCTRIN = 'WVI'
065600120803    3C                   ELSE
065700120803     C                   EVAL      @CCTRIN = 'WVF'
065800120803    3C                   ENDIF
065900120803      **
066000120803    2C                   ELSE
066100120803      **
066200120803    3C                   IF        EMPST =  'C'
066300120803     C                   EVAL      @CCTRIN = 'CB '
066400120803    3C                   ELSE
066500120803     C                   EVAL      @CCTRIN = 'AC '
066600120803    3C                   ENDIF
066700120803    3C                   IF        ENR@IN = 'TIN'
066800120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
066900120803    3C                   ELSE
067000120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
067100120803    3C                   ENDIF
067200120803      **
067300120803    2C                   ENDIF
067400120803      *
067500120803     C                   LEAVESR
067600120803    1C                   ENDIF
067700120803    ***
067800120803     C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'DEPEND'
067900120803      *
068000120803     C                   IF        STATE = 'WV'
068100120803     C                   EVAL      @CCTRIN = 'WVF'
068200120803     C                   ELSE
068300120803     C                   IF        EMPST =  'C'
068400120803     C                   EVAL      @CCTRIN = 'CBF'
068500120803     C                   ELSE
068600120803     C                   EVAL      @CCTRIN = 'ACF'
068700120803     C                   ENDIF
068800120803     C                   ENDIF
068900120803      *
069000120803     C                   ENDIF
069100120803    ***
069200120803     C                   ENDSR
069300120803   S***S
069400120803    *** EMPSTS
069500120803    ***   PRETTY STRAIGHT FORWARDED
069600120803    ***
069700120803     C     $METH07       BEGSR
069800120803    ***
069900120803     C                   IF        EMPST =  'C'
070000120803     C                   EVAL      @CCTRIN = 'COB'
070100120803     C                   ELSE
070200120803     C                   EVAL      @CCTRIN = 'ACT'
070300120803     C                   ENDIF
070400120803    ***
070500120803     C                   ENDSR
070600120803   S***S
070700120803    *** JUSTSTATE
070800120803    ***   PRETTY STRAIGHT FORWARDED
070900120803    ***
071000120803     C     $METH08       BEGSR
071100120803    ***
071200120803     C                   EVAL      @CCTRIN = STATE
071300120803    ***
071400120803     C                   ENDSR
071500120803   S***S
071600120803    *** JOHNLS
071700120803    ***   IF STATE IS NOT MARYLAND, DEFAULT TO 'XX', ELSE USE 'MD'; THEN APPLY TIER.
071800120803    ***
071900120803    *** MDI, MDF, XXI, XXF
072000120803    ***
072100120803     C     $METH09       BEGSR
072200120803    ***
072300120803     C                   IF        WRT@TYPE = 'MEMBER'
072400120803     C                   IF        STATE = 'MD'
072500120803     C                   EVAL      @CCTRIN = 'MD'
072600120803     C                   ELSE
072700120803     C                   EVAL      @CCTRIN = 'XX'
072800120803     C                   ENDIF
072900120803     C                   IF        ENR@IN = 'TIN'
073000120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
073100120803     C                   ELSE
073200120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
073300120803     C                   ENDIF
073400120803     C                   ENDIF
073500120803    ***
073600120803     C                   IF        WRT@TYPE = 'DEPEND'
073700120803     C                   IF        STATE = 'MD'
073800120803     C                   EVAL      @CCTRIN = 'MDF'
073900120803     C                   ELSE
074000120803     C                   EVAL      @CCTRIN = 'XXF'
074100120803     C                   ENDIF
074200120803     C                   ENDIF
074300120803    ***
074400120803     C                   ENDSR
074500120803   S***S
074600120803    *** CREATIVE
074700120803    ***   IF STATE IS NOT 'MD' OR 'OK', DEFAULT TO '**'.
074800120803    ***
074900120803    *** MD, OK, **
075000120803    ***
075100120803     C     $METH10       BEGSR
075200120803    ***
075300120803     C                   IF        STATE <> 'MD' AND STATE <> 'OK'
075400120803     C                   EVAL      @CCTRIN = '** '
075500120803     C                   ELSE
075600120803     C                   EVAL      @CCTRIN = STATE
075700120803     C                   ENDIF
075800120803    ***
075900120803     C                   ENDSR
076000120803   S***S
076100120803    *** INTEGRA = USE 'TN' FOR TENNESSEE, OTHER STATES ARE 'XX'
076200120803    ***
076300120803    ***  TN, XX
076400120803    ***
076500120803     C     $METH11       BEGSR
076600120803    ***
076700121113     C                   SELECT
076800121113     C                   WHEN      STATE = 'TN'
076900121113     C                   EVAL      @CCTRIN = STATE                              TENNESSEE ONLY
077000121113     C                   WHEN      STATE = 'FL'
077100121113     C                   EVAL      @CCTRIN = STATE                              FLORIDA ONLY
077200121113     C                   OTHER
077300121113     C                   EVAL      @CCTRIN = 'XX '                              SITUS
077400121113     C                   ENDSL
077500120803    ***
077600120803     C                   ENDSR
077700120803   S***S
077800120803    *** STSTATE = STATE CODE WITH EMPLOYEE STATUS
077900120803    ***
078000120803    ***  MDA, MDC, ETC...
078100120803    ***
078200120803     C     $METH12       BEGSR
078300120803    ***
078400120803     C                   EVAL      @CCTRIN = STATE + EMPST
078500120803    ***
078600120803     C                   ENDSR
078700130123   S***S
078800130123    *** STIERSTS = STATE CODE WITH TIER WITH EMPLOYEE STATUS
078900130123    ***    ACTIVE [#CALC = 0]      COBRA [#CALC = 5]
079000130123    ***    IND [+1 TO #CALC ]      NON-IND COVERAGE [+2 TO CALC]
079100130123    ***
079200130123    ***    EACH STATE PUT AT END, GIVING FAM MARYLAND ACTIVE A VALUE OF 2MD
079300130123    ***                                  IND WEST VIRGINIA COBRA A VALUE OF 6WV
079400130123    ***
079500130123    ***
079600130123     C     $METH13       BEGSR
079700130123    ***
079800130123     C                   SELECT
079900130123     C                   WHEN      EMPST =  'C'
080000130123     C                   Z-ADD     5             #CALC
080100130123     C                   OTHER
080200130123     C                   MOVE      *ZEROS        #CALC             1 0
080300130123     C                   ENDSL
080400130123    ***
080500130123     C                   SELECT
080600130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN = 'TIN'
080700130123     C                   ADD       1             #CALC
080800130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN <> 'TIN'
080900130123     C                   ADD       2             #CALC
081000130123     C                   WHEN      WRT@TYPE = 'DEPEND'
081100130123     C                   ADD       2             #CALC
081200130123     C                   ENDSL
081300130123    ***
081400130123     C                   EVAL      @CCTRIN = %EDITC(#CALC:'X') + STATE
081500130123    ***
081600130123     C                   ENDSR
081700120803   S***S
081800120409     C     $PREP4        BEGSR
081900120409    ***
082000130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
082100101206     C                   EVAL      @STEP = 'STEP2'
082200101206     C                   LEAVESR
082300101206     C                   ENDIF
082400130520    ***
082500130520     C                   EVAL      @STEP = 'STEP4'
082600130315     C                   EVAL      TERM_LIF = NO
082700101210     C                   EVAL      TERM_DEN = NO
082800101210     C                   EVAL      TERM_MED = NO
082900101210    ***
083000130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
083100130520     C                   IF        L@TRM(L#CNE) <> 99999999
083200130520     C                   EXSR      $CHKHEM
083300130520     C                   ENDIF
083400130520     C                   LEAVESR
083500130520     C                   ENDIF
083600130520    ***
083700130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
083800130520     C                   IF        M@TRM(M#CNE) <> 99999999
083900130520     C                   EXSR      $CHKHEM
084000130520     C                   ENDIF
084100130520     C                   LEAVESR
084200130520     C                   ENDIF
084300130520    ***
084400130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
084500130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
084600130520     C                              M@TRM(M#CNE) <> 99999999)
084700130520     C                   EXSR      $CHKHEM
084800130520     C                   ENDIF
084900130520     C                   LEAVESR
085000130520     C                   ENDIF
085100130520    ***
085200130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
085300130520     C                   IF        D@TRM(D#CNE) <> 99999999
085400130520     C                   EXSR      $CHKHEM
085500130520     C                   ENDIF
085600130520     C                   LEAVESR
085700130520     C                   ENDIF
085800130520    ***
085900130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
086000130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
086100130520     C                              D@TRM(D#CNE) <> 99999999)
086200130520     C                   EXSR      $CHKHEM
086300130520     C                   ENDIF
086400130520     C                   LEAVESR
086500130520     C                   ENDIF
086600130520    ***
086700130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
086800130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
086900130520     C                              M@TRM(M#CNE) <> 99999999)
087000130520     C                   EXSR      $CHKHEM
087100130520     C                   ENDIF
087200130520     C                   LEAVESR
087300130520     C                   ENDIF
087400130520    ***
087500130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
087600130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
087700130520     C                              L@TRM(L#CNE) <> 99999999 OR
087800130520     C                              M@TRM(M#CNE) <> 99999999)
087900130520     C                   EXSR      $CHKHEM
088000130520     C                   ENDIF
088100130520     C                   LEAVESR
088200130520     C                   ENDIF
088300101214    ***
088400101214     C                   ENDSR
088500101214   S***S
088600101210    *** GENERATE MEMBER RECORD
088700101210    ***
088800101210     C     $STEP4        BEGSR
088900101210    ***
089000130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
089100101214     C                   EVAL      @STEP = 'STEP2'
089200101214     C                   LEAVESR
089300101214     C                   ENDIF
089400101214    ***
089500110513     C                   EVAL      WRT@TYPE = 'MEMBER'
089600110725    ***
089700130315     C                   EVAL      L@MBREFF = 0
089800110725     C                   EVAL      D@MBREFF = 0
089900110725     C                   EVAL      M@MBREFF = 0
090000110513    ***
090100101210     C                   EVAL      @SS1   = %EDITC(MBSSNO:'X')
090200101210     C                   EVAL      @SS2   = @SS1
090300101210     C                   MOVEL(P)  MLNAME        @LN
090400101210     C                   MOVEL(P)  MFNAME        @FN
090500101210     C                   EVAL      @MI    = MMI
090600101210     C                   EVAL      @REL   = '01'
090700101210     C                   EVAL      @SEX   = SEX
090800101210     C                   EVAL      @DOB   = %EDITC(BIRTH:'X')
090900101210     C                   IF        COB = 'Y'
091000101210     C                   EVAL      @COB   = 'Y'
091100101210     C                   EVAL      @COBC  = 'OT'
091200101210     C                   EVAL      @COBN  = MCOBPN
091300101210     C                   ENDIF
091400101210     C                   EVAL      @AD1   = %TRIM(ADDR1)
091500101210     C                   EVAL      @AD2   = %TRIM(ADDR2)
091600101210     C                   EVAL      @CTY   = %TRIM(CITY)
091700101210     C                   EVAL      @ST    = STATE
091800101210     C                   MOVE      *BLANKS       @9                9
091900101210     C                   EVAL      @9   = %EDITC(ZIP:'X')
092000101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
092100101210     C                   EVAL      @PHN   = %EDITC(AREA:'X') +
092200101210     C                                      %EDITC(PHONE:'X')
092300101210    ***
092400101210     C                   SELECT
092500101210     C                   WHEN      EMPST = 'A'
092600101210     C                   EVAL      @EMPST = 'AC'
092700101210     C                   WHEN      EMPST = 'C'
092800101210     C                   EVAL      @EMPST = 'CO'
092900101210     C                   WHEN      EMPST = 'R'
093000101210     C                   EVAL      @EMPST = 'RT'
093100101210     C                   ENDSL
093200101210    ***
093300101210     C                   EVAL      @HIRE  = %EDITC(EMPDT:'X')
093400101210    ***
093500141211     C                   SETOFF                                       888987
093600141120        IF KF@TRS = 770 AND KF@SUB = 004 AND KF@ACC = 0037 AND
093700141120          STATE = 'VT';
093800141120           *IN89 = *ON;
093900141120        ENDIF;
094000141211    *** IF KF@TRS = 591 AND KF@SUB = 001 AND KF@ACC = 0042 AND
094100141211    ***   STATE = 'TX';
094200141211    ***    *IN87 = *ON;
094300141211    *** ENDIF;
094400141120    ***
094500101210     C                   EXCEPT    MBRF
094600101214     C                   ADD       1             C#RECCNT
094700101213    ***
094800101213     C                   EVAL      @STEP = 'PREP5'
094900101210    ***
095000101210     C                   ENDSR
095100101210   S***S
095200130315    *** * * * * * MEDICAL
095300101214     C     $PREP5        BEGSR
095400101214    ***
095500101214     C                   IF        M#CNE = 0
095600110513     C                   EVAL      @STEP = 'PREP6'
095700101214     C                   LEAVESR
095800101214     C                   ENDIF
095900101214    ***
096000101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
096100130315     C                   EVAL      KF@ENR = M@ENR(M#CNE)
096200101214    ***
096300101214     C                   IF        TERM_MED = YES
096400101214     C                   EXSR      $WRTERM
096500101214     C                   ENDIF
096600101214    ***
096700110512     C                   EVAL      @PLANIN = KF@PLN
096800120803    ***
096900160829     C     KL#TSAP       CHAIN     AEF04
097000160829     C                   IF        NOT %FOUND(AET004WF)
097100120803     C                   LEAVESR
097200120803     C                   ENDIF
097300120803    ***
097400111020     C                   EVAL      ENR@IN = M@ENR(M#CNE)
097500111020    ***
097600110802     C                   EXSR      $QUIK
097700110802    ***
097800110512     C                   EXSR      $PLANSRCH
097900110512    ***
098000110512     C                   IF        PLN@CAT = *BLANKS
098100101214     C                   SETON                                        H1
098200101214     C                   ENDIF
098300110512    ***
098400110513     C                   EVAL      @STEP = 'STEP5'
098500110725     C                   EVAL      #XSX = M@FRM(M#CNE)
098600110725     C                   EVAL      M@MBREFF = #XSX
098700101214    ***
098800101214     C                   ENDSR
098900101214   S***S
099000101214     C     $STEP5        BEGSR
099100101214    ***
099200160224     C                   IF        CPCID1 = 'VIS'
099300110513     C                   EXSR      $MEAWRT
099400110513     C                   ELSE
099500160224     C****               EXSR      $HMOWRT
099600110513     C                   ENDIF
099700110513    ***
099800101214     C                   ADD       1             C#RECCNT
099900101214     C                   ADD       1             B#RECCNT
100000110512    ***
100100110513     C                   EVAL      @STEP = 'PREP6'
100200110513    ***
100300110513     C                   ENDSR
100400110513   S***S
100500130315    *** DENTAL
100600130315    ***
100700101214     C     $PREP6        BEGSR
100800101213    ***
100900110513    *C                   IF        D#CNE = 0
101000130315    *C                   EVAL      @STEP = 'PREPC'
101100130315    *C*****************  EVAL      @STEP = 'PREP7'
101200110513    *C                   LEAVESR
101300110513    *C                   ENDIF
101400110512    ***
101500110513    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
101600130315    *C                   EVAL      KF@ENR = D@ENR(D#CNE)
101700130315    ***
101800160829     C     KL#TSAP       CHAIN     AEF04
101900160829     C                   IF        NOT %FOUND(AET004WF)
102000120803     C                   LEAVESR
102100120803     C                   ENDIF
102200110512    ***
102300110513    *C                   IF        TERM_DEN = YES
102400110513    *C                   EXSR      $WRTERM
102500110513    *C                   ENDIF
102600110513    ***
102700110513     C                   EVAL      @PLANIN = KF@PLN
102800111020     C                   EVAL      ENR@IN = D@ENR(D#CNE)
102900110513    ***
103000111011     C                   EXSR      $QUIK
103100110513    ***
103200110513     C                   EXSR      $PLANSRCH
103300110513    ***
103400110513     C                   IF        PLN@CAT = *BLANKS
103500110513     C                   SETON                                        H2
103600110513     C                   ENDIF
103700110512    ***
103800110513    *C                   EVAL      @STEP = 'STEP6'
103900110725     C                   EVAL      #XSX = D@FRM(D#CNE)
104000110725     C                   EVAL      D@MBREFF = #XSX
104100110512    ***
104200101213     C                   ENDSR
104300110802   S***S
104400110513    *** DENTAL FORMAT
104500110513    ***
104600110513    *C     $STEP6        BEGSR
104700110513    ***
104800110513     C                   EXSR      $DENWRT
104900110513    ***
105000110513    *C                   ADD       1             C#RECCNT
105100110513    *C                   ADD       1             B#RECCNT
105200110513    ***
105300130315    *C****************** EVAL      @STEP = 'PREP7'
105400130315    *C                   EVAL      @STEP = 'PREPC'
105500110513    ***
105600110513    *C                   ENDSR
105700110513   S***S
105800130315    *** LIFE AND AD&D PLANS FOR MEMBER
105900130315    ***
106000130315     C     $PREPC        BEGSR
106100130315    ***
106200130315    *C                   IF        L#CNE = 0
106300130315    *C                   EVAL      @STEP = 'PREP7'
106400130315    *C                   LEAVESR
106500130315    *C                   ENDIF
106600130315    ***
106700130315    *C                   EVAL      KF#TRM = L@TRM(L#CNE)
106800130315    *C                   EVAL      KF@PLN = L@PLN(L#CNE)
106900130315     C                   EVAL      KF@ENR = L@ENR(L#CNE)
107000130315    ***
107100160829     C     KL#TSAP       CHAIN     AEF04
107200160829     C                   IF        NOT %FOUND(AET004WF)
107300130315     C                   LEAVESR
107400130315     C                   ENDIF
107500130315    ***
107600130315    *C                   IF        TERM_LIF = YES
107700130315    *C                   EXSR      $WRTERM
107800130315    *C                   ENDIF
107900130315    ***
108000130315     C                   EVAL      @PLANIN = KF@PLN
108100130315     C                   EVAL      ENR@IN = L@ENR(L#CNE)
108200130315    ***
108300130315     C                   EXSR      $QUIK
108400130315    ***
108500130315     C                   EXSR      $PLANSRCH
108600130315    ***
108700130315     C                   IF        PLN@CAT = *BLANKS
108800130315     C                   SETON                                        H2
108900130315     C                   ENDIF
109000130315    ***
109100130315    *C                   EVAL      @STEP = 'STEPC'
109200130315     C                   EVAL      #XSX = L@FRM(L#CNE)
109300130315     C                   EVAL      L@MBREFF = #XSX
109400130315    ***
109500130315     C                   ENDSR
109600130315   S***S
109700130315    *** LIFE FORMAT
109800130315    ***
109900130315    *C     $STEPC        BEGSR
110000130315    ***
110100130315     C                   EXSR      $LIFWRT
110200130315    ***
110300130315    *C                   ADD       1             C#RECCNT
110400130315    *C                   ADD       1             B#RECCNT
110500130315    ***
110600130315    *C                   EVAL      @STEP = 'PREP7'
110700130315    ***
110800130315    *C                   ENDSR
110900130315   S***S
111000130315     C     $LIFWRT       BEGSR
111100130315    ***
111200130315    *C                   EVAL      X@LAY = CPCID1                               LAYOUT
111300130315    *C                   EVAL      X@ELR = CPCID2                               ELR
111400130315    *C                   EVAL      L@SFX = CPCID3                               SUFFIX
111500130315    *C                   EVAL      L@ACCT = CPCID4                              ACCOUNT
111600130315    *C                   EVAL      L@PLAN = CPCID5                              PLAN
111700130315    *C                   EVAL      L@CLM = CPCID6                               CLAIM OFFICE
111800130315    ***
111900130315    *C                   EVAL      #XSX = L@FRM(L#CNE)
112000130315     C                   MOVE      #XSX          X@EFF
112100130315    ***
112200130315    *C                   EVAL      #XSX = L@TRM(L#CNE)
112300130315    *C                   IF        #XSX = 0 OR #XSX = 99999999
112400130315    *C                   MOVE      *BLANKS       X@TRM
112500130315    *C                   ELSE
112600160809    *C****               MOVE      #XSX          X@TRM
112700160809       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
112800160809       if %subdt(work_date:*d) = 01 ;
112900160809        work_date -= %days(1) ;
113000160809        num_date = %dec(work_date:*iso);
113100160809        X@TRM = %EDITC(num_date:'X');
113200160809       endif;
113300160809
113400130315    *C                   ENDIF
113500140313    ***
113600140313     C                   MOVE      *BLANKS       L@CBREXP
113700140313     C                   MOVE      *BLANKS       L@CBREVT
113800140313     C                   MOVE      *BLANKS       L@CBRLEN
113900130315    ***
114000130923    *C                   IF        EMPST = 'C' AND
114100130923     C                             CEXPDT > 0
114200130315    *C                   MOVE      CEXPDT        L@CBREXP
114300130315    *C                   MOVE      QEDT          L@CBREVT
114400130315    *C                   MOVE      CEXPDT        #MINUEND
114500130315    *C                   MOVE      QEDT          #SUBTRAEND
114600130315    *C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
114700130315    *C                   Z-ADD     #DIFFRNC      #2S0
114800130315    *C                   MOVE      #2S0          L@CBRLEN
114900130315    *C                   ENDIF
115000130315    ***
115100130315     C                   EVAL      L@SALARY = %EDITC(SALARY:'4')
115200130315    ***
115300130315    *C                   EXCEPT    LIFF
115400130315    ***
115500130315    *C                   ENDSR
115600130315   S***S
115700101214     C     $PREP7        BEGSR
115800101214    ***
115900101214     C     KF@SSN        CHAIN     DEPENR
116000101214     C                   IF        NOT %FOUND(DEPNDC)
116100101214     C                   EVAL      @STEP = 'STEP2'
116200101214     C                   LEAVESR
116300101214     C                   ENDIF
116400101214    ***
116500101214     C     KF@SSN        SETLL     DEPENR
116600101214    ***
116700101214     C                   EVAL      @STEP = 'STEP7'
116800101214    ***
116900101214     C                   ENDSR
117000101210   S***S
117100101214     C     $STEP7        BEGSR
117200101214    ***
117300101214     C     KF@SSN        READE     DEPENR
117400101214    ***
117500101214     C                   IF        %EOF(DEPNDC)
117600101214     C                   EVAL      @STEP = 'STEP2'
117700101214     C                   LEAVESR
117800101214     C                   ENDIF
117900101214    ***
118000101214     C                   EVAL      KF@SEQ = DPSEQ#
118100120803     C                   EVAL      WRT@TYPE = 'DEPEND'
118200101214    ***
118300101214     C     KL#DCV        CHAIN     DCOVR
118400101214     C                   IF        NOT %FOUND(DCOVA)
118500101214     C                   LEAVESR
118600101214     C                   ENDIF
118700101214    ***
118800101214     C                   EXSR      $CLRDCV
118900101214     C     KL#DCV        SETLL     DCOVR
119000101214    ***
119100101214     C                   EVAL      @STEP = 'STEP8'
119200101214    ***
119300101214     C                   ENDSR
119400101214   S***S
119500101214     C     $STEP8        BEGSR
119600101214    ***
119700101214     C     KL#DCV        READE     DCOVR
119800101214    ***
119900101214     C                   IF        %EOF(DCOVA)
120000101214     C                   EVAL      @STEP = 'PREP9'
120100101214     C                   LEAVESR
120200101214     C                   ENDIF
120300101214    ***
120400130131    *C*                  IF        DENRDT = CCANDT
120500130131    *C*                  LEAVESR
120600130131    *C*                  ENDIF
120700110513    ***
120800110513     C                   EVAL      @PLANIN = DVPLAN
120900120803     C                   EVAL      KF@PLN = DVPLAN
121000160829     C     KL#TSAP       CHAIN     AEF04
121100160829     C                   IF        NOT %FOUND(AET004WF)
121200120803     C                   LEAVESR
121300120803     C                   ENDIF
121400110802    ***
121500110802     C                   EXSR      $QUIKD
121600110802    ***
121700110513     C                   EXSR      $PLANSRCH
121800110513    ***
121900110513     C                   IF        PLN@CAT = *BLANKS
122000110513     C                   LEAVESR
122100110513     C                   ENDIF
122200101214    ***
122300101214     C                   EVAL      #CANCEL = CCANDT
122400101214     C                   IF        #CANCEL = 0
122500101214     C                   EVAL      #CANCEL = 99999999
122600101214     C                   ENDIF
122700101214    ***
122800130315    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL; LIFE IS MEMBER ONLY
122900110513    ***
123000160224    *C****               IF        PLN@CAT = 'DEN'
123100160224    *C****               IF        D#CNE > 0
123200160224    *C****               IF        D@TRM(D#CNE) = 99999999
123300160224     C****               LEAVESR
123400160224     C****               ENDIF
123500160224     C****               ENDIF
123600160224    *C****               ADD       1             D#CNE
123700160224    *C****               EVAL      D@PLN(D#CNE) = DVPLAN
123800160224    *C****               EVAL      D@ENR(D#CNE) = *BLANKS
123900160224    *C****               EVAL      D@FRM(D#CNE) = DENRDT
124000160224    *C****               EVAL      D@TRM(D#CNE) = #CANCEL
124100160224    *C****               ELSE
124200130131    *C                   IF        M#CNE > 0
124300130131    *C                   IF        M@TRM(M#CNE) = 99999999
124400130131     C                   LEAVESR
124500130131     C                   ENDIF
124600130131     C                   ENDIF
124700101214     C                   ADD       1             M#CNE
124800101214     C                   EVAL      M@PLN(M#CNE) = DVPLAN
124900101214     C                   EVAL      M@ENR(M#CNE) = *BLANKS
125000101214     C                   EVAL      M@FRM(M#CNE) = DENRDT
125100101214     C                   EVAL      M@TRM(M#CNE) = #CANCEL
125200160224    *C****               ENDIF
125300101214    ***
125400101214     C                   ENDSR
125500101214   S***S
125600111011     C     $QUIKD        BEGSR
125700111011    ***
125800120803     C                   EXSR      $QUIK
125900120409    ***
126000120409     C                   ENDSR
126100111011   S***S
126200101214     C     $PREP9        BEGSR
126300101214    ***
126400101214     C                   IF        D#CNE = 0 AND M#CNE = 0
126500101214     C                   EVAL      @STEP = 'STEP7'
126600101214     C                   LEAVESR
126700101214     C                   ENDIF
126800101214    ***
126900130315     C                   EVAL      L#CNE = 0
127000130315     C                   EVAL      TERM_LIF = NO
127100101214     C                   EVAL      TERM_DEN = NO
127200101214     C                   EVAL      TERM_MED = NO
127300130520     C                   EVAL      @STEP = 'STEP9'
127400101214    ***
127500130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
127600130520     C                   IF        L@TRM(L#CNE) <> 99999999
127700130520     C                   EXSR      $CHKHEM
127800130520     C                   ENDIF
127900130520     C                   LEAVESR
128000130520     C                   ENDIF
128100130520    ***
128200130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
128300130520     C                   IF        M@TRM(M#CNE) <> 99999999
128400130520     C                   EXSR      $CHKHEM
128500130520     C                   ENDIF
128600130520     C                   LEAVESR
128700130520     C                   ENDIF
128800130520    ***
128900130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
129000130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
129100130520     C                              M@TRM(M#CNE) <> 99999999)
129200130520     C                   EXSR      $CHKHEM
129300130520     C                   ENDIF
129400130520     C                   LEAVESR
129500130520     C                   ENDIF
129600130520    ***
129700130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
129800130520     C                   IF        D@TRM(D#CNE) <> 99999999
129900130520     C                   EXSR      $CHKHEM
130000130520     C                   ENDIF
130100130520     C                   LEAVESR
130200130520     C                   ENDIF
130300130520    ***
130400130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
130500130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
130600130520     C                              D@TRM(D#CNE) <> 99999999)
130700130520     C                   EXSR      $CHKHEM
130800130520     C                   ENDIF
130900130520     C                   LEAVESR
131000130520     C                   ENDIF
131100130520    ***
131200130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
131300130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
131400130520     C                              M@TRM(M#CNE) <> 99999999)
131500130520     C                   EXSR      $CHKHEM
131600130520     C                   ENDIF
131700130520     C                   LEAVESR
131800130520     C                   ENDIF
131900130520    ***
132000130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
132100130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
132200130520     C                              L@TRM(L#CNE) <> 99999999 OR
132300130520     C                              M@TRM(M#CNE) <> 99999999)
132400130520     C                   EXSR      $CHKHEM
132500130520     C                   ENDIF
132600130520     C                   LEAVESR
132700130520     C                   ENDIF
132800101214    ***
132900101214     C                   ENDSR
133000101214   S***S
133100101210    *** GENERATE DEPENDENT RECORD
133200101210    ***
133300101214     C     $STEP9        BEGSR
133400101210    ***
133500110513     C                   EVAL      WRT@TYPE = 'DEPEND'
133600110513    ***
133700110513     C                   IF        D#CNE = 0 AND M#CNE = 0
133800110513     C                   EVAL      @STEP = 'STEP7'
133900110513     C                   LEAVESR
134000110513     C                   ENDIF
134100110513    ***
134200101214     C                   EVAL      @SS2   = %EDITC(DEPSS#:'X')
134300101210     C                   MOVEL(P)  DLNAME        @LN
134400101210     C                   MOVEL(P)  DFNAME        @FN
134500101210     C                   EVAL      @MI    = DMI
134600101210    ***
134700101210     C                   SELECT
134800101210     C                   WHEN      DRELCD = 'RWI'
134900101210     C                   EVAL      @REL   = '02'
135000101210     C                   WHEN      DRELCD = 'RHU'
135100101210     C                   EVAL      @REL   = '03'
135200101210     C                   WHEN      DRELCD = 'RSO'
135300101210     C                   EVAL      @REL   = '04'
135400101210     C                   WHEN      DRELCD = 'RDA'
135500101210     C                   EVAL      @REL   = '05'
135600130218     C                   WHEN      DRELCD = 'RPA'
135700130218     C                   EVAL      @REL   = '14'
135800130225     C                   OTHER
135900130225     C                   EVAL      @REL   = *BLANKS
136000101210     C                   ENDSL
136100101210    ***
136200101210     C                   SELECT
136300101210     C                   WHEN      DSTUDN = 'Y'
136400101210     C                   EVAL      @SPEC = '1'
136500140812     C                   WHEN      DHNDCP = '3'
136600101210     C                   EVAL      @SPEC = '3'
136700130225     C                   OTHER
136800130225     C                   EVAL      @SPEC = *BLANKS
136900101210     C                   ENDSL
137000101210    ***
137100101210     C                   EVAL      @SEX   = DSEX
137200101210     C                   EVAL      @DOB   = %EDITC(DBIRTH:'X')
137300130225    ***
137400101210     C                   IF        DCOB = 'Y'
137500101210     C                   EVAL      @COB   = 'Y'
137600101210     C                   EVAL      @COBC  = 'OT'
137700101210     C                   EVAL      @COBN  = DCOBPN
137800130225     C                   ELSE
137900130225     C                   EVAL      @COB   = *BLANKS
138000130225     C                   EVAL      @COBC  = *BLANKS
138100130225     C                   EVAL      @COBN = *BLANKS
138200101210     C                   ENDIF
138300101214    ***
138400101214     C                   IF        DADDR1 <> ADDR1
138500101210     C                   EVAL      @AD1   = %TRIM(DADDR1)
138600101210     C                   EVAL      @AD2   = %TRIM(DADDR2)
138700101210     C                   EVAL      @CTY   = %TRIM(DCITY)
138800101210     C                   EVAL      @ST    = DSTATE
138900101210     C                   MOVE      *BLANKS       @9                9
139000101214     C                   IF        DZIP = 0
139100101214     C                   EVAL      @9   = %EDITC(ZIP:'X')
139200101214     C                   ELSE
139300101210     C                   EVAL      @9   = %EDITC(DZIP:'X')
139400101214     C                   ENDIF
139500101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
139600101210     C                   EVAL      @PHN   = %EDITC(DAREA:'X') +
139700101210     C                                      %EDITC(DPHONE:'X')
139800101214     C                   ENDIF
139900141120    ***
140000101210     C                   EXCEPT    MBRF
140100101214     C                   ADD       1             C#RECCNT
140200101214    ***
140300101214     C                   EVAL      @STEP = 'PREPA'
140400101210    ***
140500101210     C                   ENDSR
140600101210   S***S
140700101214     C     $PREPA        BEGSR
140800101214    ***
140900101214     C                   IF        M#CNE = 0
141000101214     C                   EVAL      @STEP = 'PREPB'
141100101214     C                   LEAVESR
141200101214     C                   ENDIF
141300101214    ***
141400101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
141500160829     C     KL#TSAP       CHAIN     AEF04
141600160829     C                   IF        NOT %FOUND(AET004WF)
141700120803     C                   LEAVESR
141800120803     C                   ENDIF
141900101214    ***
142000101214     C                   IF        TERM_MED = YES
142100101214     C                   EXSR      $WRTERM
142200101214     C                   ENDIF
142300101214    ***
142400110513     C                   EVAL      @PLANIN = KF@PLN
142500110802    ***
142600110802     C                   EXSR      $QUIKD
142700110802    ***
142800110513     C                   EXSR      $PLANSRCH
142900110513    ***
143000110513     C                   IF        PLN@CAT = *BLANKS
143100110513     C                   SETON                                        H2
143200110513     C                   ENDIF
143300110513    ***
143400110513     C                   EVAL      @STEP = 'STEPA'
143500110513    ***
143600101214     C                   ENDSR
143700101214   S***S
143800101214     C     $STEPA        BEGSR
143900101214    ***
144000160224     C                   IF        CPCID1 = 'VIS'
144100110513     C                   EXSR      $MEAWRT
144200110513     C                   ELSE
144300160224     C****               EXSR      $HMOWRT
144400110513     C                   ENDIF
144500110513    ***
144600110513     C                   ADD       1             C#RECCNT
144700110513     C                   ADD       1             B#RECCNT
144800110513    ***
144900110513     C                   EVAL      @STEP = 'PREPB'
145000110513    ***
145100110513     C                   ENDSR
145200110513   S***S
145300101214     C     $PREPB        BEGSR
145400101214    ***
145500110513    *C                   IF        D#CNE = 0
145600110513    *C                   EVAL      @STEP = 'STEP7'
145700110513    *C                   LEAVESR
145800110513    *C                   ENDIF
145900101214    ***
146000110513    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
146100160829     C     KL#TSAP       CHAIN     AEF04
146200160829     C                   IF        NOT %FOUND(AET004WF)
146300120803     C                   LEAVESR
146400120803     C                   ENDIF
146500110513    ***
146600110513    *C                   IF        TERM_DEN = YES
146700110513    *C                   EXSR      $WRTERM
146800110513    *C                   ENDIF
146900110513    ***
147000110513     C                   EVAL      @PLANIN = KF@PLN
147100110513    ***
147200110802     C                   EXSR      $QUIKD
147300110513    ***
147400110513     C                   EXSR      $PLANSRCH
147500110513    ***
147600110513     C                   IF        PLN@CAT = *BLANKS
147700110513     C                   SETON                                        H2
147800110513     C                   ENDIF
147900110513    ***
148000101214     C                   EVAL      @STEP = 'STEPB'
148100101214    ***
148200101214     C                   ENDSR
148300101214   S***S
148400110513    *C     $STEPB        BEGSR
148500110513    ***
148600110513     C                   EXSR      $DENWRT
148700110513    ***
148800110513    *C                   ADD       1             C#RECCNT
148900110513    *C                   ADD       1             B#RECCNT
149000110513    ***
149100110513    *C                   EVAL      @STEP = 'STEP7'
149200110513    ***
149300110513    *C                   ENDSR
149400101210   S***S
149500110512     C     *INZSR        BEGSR
149600110512    ***
149700160829     C     *entry        plist
149800160829     C                   parm                    CARR#CTL
149900160829     C                   parm                    grouper
150000160831     C                   parm                    p_trst
150100160831     C                   parm                    p_sub#
150200160831     C                   parm                    p_acct
150300160829
150400110512     C     KL#ACCTL      KLIST
150500120803     C                   KFLD                    KF@CCTL
150600110512     C                   KFLD                    KF@TRS
150700110512     C                   KFLD                    KF@SUB
150800110512     C                   KFLD                    KF@ACC
150900140313    ***
151000140313     C     KL#SQPCD      KLIST
151100140313     C                   KFLD                    KF@SSN
151200140313     C                   KFLD                    KF@SEQ
151300140313     C                   KFLD                    KF@SPCD
151400120803    ***
151500120803     C     KL#TSAP       KLIST
151600120803     C                   KFLD                    KF@TRS
151700120803     C                   KFLD                    KF@SUB
151800120803     C                   KFLD                    KF@ACC
151900120803     C                   KFLD                    KF@PLN
152000110512    ***
152100110512     C     KL#TSA        KLIST
152200110512     C                   KFLD                    KF@TRS
152300110512     C                   KFLD                    KF@SUB
152400110512     C                   KFLD                    KF@ACC
152500110512    ***
152600110512     C     KL#MPLN       KLIST
152700110512     C                   KFLD                    KF@SSN
152800110512     C                   KFLD                    KF@SEQ
152900110512     C                   KFLD                    KF@TRS
153000110512     C                   KFLD                    KF@SUB
153100110512     C                   KFLD                    KF@ACC
153200110512    ***
153300110512     C     KL#CPLN       KLIST
153400120803     C                   KFLD                    KF@CCTL
153500110512     C                   KFLD                    KF@TRS
153600110512     C                   KFLD                    KF@SUB
153700110512     C                   KFLD                    KF@ACC
153800110512     C                   KFLD                    KF@CCTR
153900110512     C                   KFLD                    KF@PLN
154000110512    ***
154100110512     C     KL#DCV        KLIST
154200110512     C                   KFLD                    KF@SSN
154300110512     C                   KFLD                    KF@SEQ
154400110512    ***
154500110512     C     KL#MTR        KLIST
154600110512     C                   KFLD                    KF@SSN
154700110512     C                   KFLD                    KF@SEQ
154800110512     C                   KFLD                    KF#TRM
154900110512     C                   KFLD                    KF@PLN
155000110512     C                   KFLD                    KF@ENR
155100110512     C                   KFLD                    KF@TRS
155200110512     C                   KFLD                    KF@SUB
155300110512     C                   KFLD                    KF@ACC
155400110512    ***
155500110512     C     KL#PCP        KLIST
155600110512     C                   KFLD                    KF@SSN
155700110512     C                   KFLD                    KF@SEQ
155800110512    ***
155900110512     C                   EVAL      #ISO = %DATE
156000110512     C                   MOVE      #ISO          #TODAY            8 0
156100110512     C                   EVAL      #IST = %TIME
156200110512     C                   MOVE      #ISO          #XSX
156300110512     C                   MOVE      #XSX          @DATE
156400110512     C                   MOVE      #IST          #XST
156500110512     C                   MOVE      #XST          @TIME
156600110512    ***
156700160831     c                   eval      kf@trs = p_trst
156800160831     c                   eval      kf@sub = p_sub#
156900160831     c                   eval      kf@acc = p_acct
157000160831
157100110512     C                   ENDSR
157200110512   S***S
157300110513    *** PLANS LOADED BY ACCOUNT
157400110513    ***
157500110513     C     $PLANLOAD     BEGSR
157600110513    ***
157700110513     C                   EVAL      PP# = 0
157800140313     C                   DO        80
157900110513     C                   ADD       1             PP#
158000110513     C     PP#           OCCUR     CARPLN@
158100110513     C                   CLEAR                   CARPLN@
158200110513     C                   ENDDO
158300110513     C                   EVAL      PC# = 0
158400110513     C                   EVAL      PP# = 0
158500110513    ***
158600110513     C     KL#ACCTL      SETLL     CARPLNR
158700110513     C                   DOU       %EOF(CARPLNP)
158800110513     C     KL#ACCTL      READE     CARPLNR
158900110520     C                   IF        NOT %EOF(CARPLNP)
159000110513    ***
159100110513     C                   ADD       1             PC#
159200110513     C     PC#           OCCUR     CARPLN@
159300110513     C                   EVAL      CARPLN@ = DS@CARPLN
159400110513    ***
159500110513     C                   ENDIF
159600110513     C                   ENDDO
159700110513    ***
159800110513     C                   ENDSR
159900110513   S***S
160000110513     C     $CLRSTG       BEGSR
160100110513    ***
160200110513     C                   EVAL      #CANCEL = 0
160300130315    ***
160400130315     C                   EVAL      L#CNE = 0
160500130315     C                   CLEAR                   L@PLN
160600130315     C                   CLEAR                   L@ENR
160700130315     C                   CLEAR                   L@FRM
160800130315     C                   CLEAR                   L@TRM
160900130315    ***
161000110513     C                   EVAL      D#CNE = 0
161100110513     C                   CLEAR                   D@PLN
161200110513     C                   CLEAR                   D@ENR
161300110513     C                   CLEAR                   D@FRM
161400110513     C                   CLEAR                   D@TRM
161500110513     C                   EVAL      M#CNE = 0
161600110513     C                   CLEAR                   M@PLN
161700110513     C                   CLEAR                   M@ENR
161800110513     C                   CLEAR                   M@FRM
161900110513     C                   CLEAR                   M@TRM
162000110513    ***
162100110513     C                   EXSR      $CLRDMG
162200110513    ***
162300110513     C                   ENDSR
162400110513   S***S
162500110513     C     $CLRDMG       BEGSR
162600110513    ***
162700110513     C                   EVAL      @SS1   = *BLANKS
162800110513     C                   EVAL      @SS2   = *BLANKS
162900110513     C                   MOVE      *BLANKS       @LN
163000110513     C                   MOVEL     *BLANKS       @FN
163100110513     C                   EVAL      @MI    = *BLANKS
163200110513     C                   EVAL      @REL   = *BLANKS
163300110513     C                   EVAL      @SEX   = *BLANKS
163400110513     C                   EVAL      @DOB   = *BLANKS
163500110513     C                   EVAL      @SPEC  = *BLANKS
163600110513     C                   EVAL      @COB   = *BLANKS
163700110513     C                   EVAL      @COBC  = *BLANKS
163800110513     C                   EVAL      @COBN  = *BLANKS
163900110513     C                   EVAL      @AD1   = *BLANKS
164000110513     C                   EVAL      @AD2   = *BLANKS
164100110513     C                   EVAL      @CTY   = *BLANKS
164200110513     C                   EVAL      @ST    = *BLANKS
164300110513     C                   EVAL      @ZP5   = *BLANKS
164400110513     C                   EVAL      @PHN   = *BLANKS
164500110513     C                   EVAL      @EMPST = *BLANKS
164600110513     C                   EVAL      @HIRE  = *BLANKS
164700110513    ***
164800110513     C                   ENDSR
164900110513   S***S
165000110513     C     $CHKHEM       BEGSR
165100110513    ***
165200130315    *C                   IF        L#CNE > 0 AND L@TRM(L#CNE) <> 99999999
165300130315    *C                   EXSR      $CHKLIF
165400130315    *C                   ENDIF
165500130315      *
165600110513    *C                   IF        D#CNE > 0 AND D@TRM(D#CNE) <> 99999999
165700110513    *C                   EXSR      $CHKDEN
165800110513    *C                   ENDIF
165900110513      *
166000110513     C                   IF        M#CNE > 0 AND M@TRM(M#CNE) <> 99999999
166100110513     C                   EXSR      $CHKMED
166200110513     C                   ENDIF
166300110513    ***
166400110513     C                   ENDSR
166500110513   S***S
166600130315    *C     $CHKLIF       BEGSR
166700130315    ***
166800130315    *C                   EVAL      TERM_LIF = YES
166900130315    *C                   EVAL      KF#TRM = L@TRM(L#CNE)
167000130315    *C                   EVAL      KF@PLN = L@PLN(L#CNE)
167100130315    *C                   EVAL      KF@ENR = L@ENR(L#CNE)
167200130315    ***
167300160829    *C     KL#MTR        CHAIN     AET1051F
167400160829    *C                   IF        %FOUND(AET1051WF)
167500130315    *C                   EVAL      L#CNE = 0
167600130315    *C                   EVAL      TERM_LIF = NO
167700130315    *C                   ENDIF
167800130315    ***
167900130315    *C                   ENDSR
168000130315   S***S
168100110513    *C     $CHKDEN       BEGSR
168200110513    ***
168300110513    *C                   EVAL      TERM_DEN = YES
168400110513    *C                   EVAL      KF#TRM = D@TRM(D#CNE)
168500110513    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
168600110513    *C                   EVAL      KF@ENR = D@ENR(D#CNE)
168700110513    ***
168800160829    *C     KL#MTR        CHAIN     AET1051F
168900160829    *C                   IF        %FOUND(AET1051WF)
169000110513    *C                   EVAL      D#CNE = 0
169100110513    *C                   EVAL      TERM_DEN = NO
169200110513    *C                   ENDIF
169300110513    ***
169400110513    *C                   ENDSR
169500110513   S***S
169600110513     C     $CHKMED       BEGSR
169700110513    ***
169800110513     C                   EVAL      TERM_MED = YES
169900110513     C                   EVAL      KF#TRM = M@TRM(M#CNE)
170000110513     C                   EVAL      KF@PLN = M@PLN(M#CNE)
170100110513     C                   EVAL      KF@ENR = M@ENR(M#CNE)
170200110513      *
170300160829     C     KL#MTR        CHAIN     AET1051F
170400160829     C                   IF        %FOUND(AET1051WF)
170500110513     C                   EVAL      TERM_MED = NO
170600110513     C                   EVAL      M#CNE = 0
170700110513     C                   ENDIF
170800110513    ***
170900110513     C                   ENDSR
171000110513   S***S
171100110513     C     $PLANSRCH     BEGSR
171200110513    ***
171300130315     C                   MOVE      *BLANKS       PLN@CAT           5
171400110513     C                   EVAL      PP# = 0
171500110513     C                   CLEAR                   DS@CARPLN
171600110513    ***
171700110513     C                   DO        PC#
171800110513    * *
171900110513     C                   ADD       1             PP#
172000110513     C     PP#           OCCUR     CARPLN@
172100110513    * *
172200110513     C                   IF        XPPLAN = @PLANIN AND
172300110513     C                             XPCCTR = @CCTRIN
172400110513     C                   EVAL      DS@CARPLN = CARPLN@
172500110513     C                   LEAVE
172600110513     C                   ENDIF
172700110513    * *
172800110513     C                   ENDDO
172900110513    ***
173000110513     C                   IF        CPPLAN = *BLANKS
173100110513     C                   LEAVESR
173200110513     C                   ENDIF
173300110513    ***
173400110513     C                   SELECT
173500160224     C                   WHEN      CPCID1 = 'VIS'
173600160224     C                   EVAL      PLN@CAT = 'VIS'
173700160224     C****                         CPCID1 = 'HMO'
173800160224     C****               EVAL      PLN@CAT = 'MED'
173900160224     C****               WHEN      CPCID1 = 'LIFE'
174000160224     C****               EVAL      PLN@CAT = 'LIFE'
174100160224     C****               WHEN      CPCID1 = 'DEN'
174200160224     C****               EVAL      PLN@CAT = 'DEN'
174300110513     C                   ENDSL
174400110513    ***
174500110513     C                   ENDSR
174600110513   S***S
174700110513     C     $ENROLL       BEGSR
174800110513    ***
174900110513     C                   EVAL      ENR@OUT = *BLANKS
175000110513     C                   SELECT
175100110513     C                   WHEN      ENR@IN = 'TIN' OR ENR@IN = 'TMI'
175200110513     C                   EVAL      ENR@OUT = 'S'
175300110513     C                   WHEN      ENR@IN = 'THW'
175400110513     C                   EVAL      ENR@OUT = 'C'
175500110513     C                   WHEN      ENR@IN = 'TPC'
175600110513     C                   EVAL      ENR@OUT = 'P'
175700110513     C                   WHEN      ENR@IN = 'TP2'
175800110513     C                   EVAL      ENR@OUT = 'Q'
175900110513     C                   WHEN      ENR@IN = 'TFA'
176000110513     C                   EVAL      ENR@OUT = 'F'
176100110513     C                   ENDSL
176200110513    ***
176300110513     C                   ENDSR
176400110513   S***S
176500110513     C     $WRTERM       BEGSR
176600110513    ***
176700160829     C                   CLEAR                   AET1051F
176800110513     C                   EVAL      NTSSNO         = KF@SSN
176900110513     C                   EVAL      NTDEPNO        = KF@SEQ
177000110513     C                   EVAL      NTTERMDT       = KF#TRM
177100110513     C                   EVAL      NTPLAN         = KF@PLN
177200110513     C                   EVAL      NTCOVTP        = KF@ENR
177300110513     C                   EVAL      NTTRST         = KF@TRS
177400110513     C                   EVAL      NTSUB#         = KF@SUB
177500110513     C                   EVAL      NTACCT         = KF@ACC
177600110513     C                   EVAL      NTTRANSDT      = #TODAY
177700160829     C                   WRITE     AET1051F
177800110513    ***
177900110513     C                   ENDSR
178000110513   S***S
178100110513     C     $HMOWRT       BEGSR
178200110513    ***
178300110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
178400110513     C                   EVAL      X@ELR = CPCID2                               FILE NUMBER
178500110513     C                   EVAL      M@CC = CACID2                                COMPANY CODE
178600110513     C                   EVAL      M@CLASS = CPCID3                             CLASS CODE
178700110513     C                   EVAL      M@PLAN = CPCID4                              PLAN NUMBER
178800110513    ***
178900110513     C                   EVAL      #XSX = M@FRM(M#CNE)
179000110725     C                   IF        WRT@TYPE = 'DEPEND' AND
179100110725     C                             #XSX < M@MBREFF
179200110725     C                   MOVE      M@MBREFF      X@EFF
179300110725     C                   ELSE
179400110725     C                   MOVE      #XSX          X@EFF
179500110725     C                   ENDIF
179600110513    ***
179700110513     C                   EVAL      #XSX = M@TRM(M#CNE)
179800110513     C                   IF        #XSX = 0 OR #XSX = 99999999
179900110513     C                   MOVE      *BLANKS       X@TRM
180000110513     C                   ELSE
180100160809     C****               MOVE      #XSX          X@TRM
180200160809       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
180300160809       if %subdt(work_date:*d) = 01 ;
180400160809        work_date -= %days(1) ;
180500160809        num_date = %dec(work_date:*iso);
180600160809        X@TRM = %EDITC(num_date:'X');
180700160809       endif;
180800160809
180900110513     C                   ENDIF
181000110513    ***
181100110513     C                   IF        WRT@TYPE = 'MEMBER'
181200110513     C                   EVAL      KF@SEQ = 0
181300110513     C                   EVAL      ENR@IN = M@ENR(M#CNE)
181400110513     C                   EXSR      $ENROLL
181500110513     C                   EVAL      X@TIER = ENR@OUT
181600110513     C                   ELSE
181700110513     C                   EVAL      X@TIER = *BLANKS
181800110513     C                   ENDIF
181900110513    ***
182000140313     C                   EVAL      KF@SPCD = 'MED'
182100140313     C                   EVAL      M@PCP = *BLANKS
182200140313     C                   EVAL      M@NPI = *BLANKS
182300140313     C                   EVAL      M@PCPCI = *BLANKS
182400140313    ***
182500140313     C                   EXSR      $PCP
182600140313    ***
182700140313     C                   IF        DOCTOR <> *BLANKS
182800140313     C                   EVAL      M@PCP = DOCTOR
182900140313     C                   EVAL      M@NPI = 'Y'
183000140313     C                   EVAL      M@PCPCI = '0'
183100140313     C                   ENDIF
183200110513    ***
183300110513     C                   EXCEPT    HMOF
183400110513    ***
183500110513     C                   ENDSR
183600110513   S***S
183700110513     C     $MEAWRT       BEGSR
183800110513    ***
183900110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
184000110513     C                   EVAL      X@ELR = CPCID2                               ELR
184100140313     C                   EVAL      E@SFX = CPCID3                               SUFFIX
184200140313     C                   EVAL      E@ACCT = CPCID4                              ACCOUNT
184300140313     C                   EVAL      E@PLAN = CPCID5                              PLAN
184400140313     C                   EVAL      E@CLM = CPCID6                               CLAIM OFFICE
184500110513    ***
184600110513     C                   EVAL      #XSX = M@FRM(M#CNE)
184700110725     C                   IF        WRT@TYPE = 'DEPEND' AND
184800110725     C                             #XSX < M@MBREFF
184900110725     C                   MOVE      M@MBREFF      X@EFF
185000110725     C                   ELSE
185100110725     C                   MOVE      #XSX          X@EFF
185200110725     C                   ENDIF
185300110513    ***
185400110513     C                   EVAL      #XSX = M@TRM(M#CNE)
185500110513     C                   IF        #XSX = 0 OR #XSX = 99999999
185600110513     C                   MOVE      *BLANKS       X@TRM
185700110513     C                   ELSE
185800160809     C****               MOVE      #XSX          X@TRM
185900160809       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
186000160809       if %subdt(work_date:*d) = 01 ;
186100160809        work_date -= %days(1) ;
186200160809        num_date = %dec(work_date:*iso);
186300160809        X@TRM = %EDITC(num_date:'X');
186400160809       endif;
186500160809
186600110513     C                   ENDIF
186700110513    ***
186800140313     C                   MOVE      *BLANKS       E@CBREXP
186900140313     C                   MOVE      *BLANKS       E@CBREVT
187000140313     C                   MOVE      *BLANKS       E@CBRLEN
187100140313     C                   IF        WRT@TYPE = 'MEMBER'
187200140425     C                   IF        EMPST = 'C' AND
187300140425     C                             CEXPDT > 0
187400140313     C                   MOVE      CEXPDT        E@CBREXP
187500140313     C                   MOVE      QEDT          E@CBREVT
187600140313     C                   MOVE      CEXPDT        #MINUEND
187700140313     C                   MOVE      QEDT          #SUBTRAEND
187800140313     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
187900140313     C                   Z-ADD     #DIFFRNC      #2S0
188000140313     C                   MOVE      #2S0          E@CBRLEN
188100140313     C                   ENDIF
188200140313     C                   ENDIF
188300140313    ***
188400140313     C                   EVAL      *IN80 = *OFF
188500140313     C                   EVAL      KF@SPCD = 'MED'
188600140313     C                   EVAL      E@PCP = *BLANKS
188700140313     C                   EXSR      $PCP
188800140313     C                   IF        DOCTOR <> *BLANKS
188900140313     C                   EVAL      E@PCP = DOCTOR
189000140313     C                   EVAL      *IN80 = *ON
189100140313     C                   ENDIF
189200140313    ***
189300140313     C                   EXCEPT    MEAF
189400110513    ***
189500110513     C                   ENDSR
189600110513   S***S
189700140313     C     $PCP          BEGSR
189800140313    ***
189900140313     C                   MOVE      *BLANKS       DOCTOR            7
190000140313     C     KL#SQPCD      CHAIN     PCPR
190100140313     C                   IF        NOT %FOUND(PCPL1)
190200140313     C                   LEAVESR
190300140313     C                   ENDIF
190400140313     C     KL#SQPCD      SETLL     PCPR
190500140313     C                   DOU       %EOF(PCPL1)
190600140313     C     KL#SQPCD      READE     PCPR
190700140313     C                   IF        NOT %EOF(PCPL1) AND PCCAN = 0
190800140313     C                   MOVEL(P)  PCID#         DOCTOR
190900140313     C                   LEAVESR
191000140313     C                   ENDIF
191100140313     C                   ENDDO
191200140313    ***
191300140313     C                   ENDSR
191400140313   S***S
191500110513     C     $CLRDCV       BEGSR
191600110513    ***
191700110513     C                   MOVE      *BLANKS       @LN
191800110513     C                   MOVEL     *BLANKS       @FN
191900110513     C                   EVAL      @SS2   = *BLANKS
192000110513     C                   EVAL      @MI    = *BLANKS
192100110513     C                   EVAL      @REL   = *BLANKS
192200110513     C                   EVAL      @SEX   = *BLANKS
192300110513     C                   EVAL      @DOB   = *BLANKS
192400110513     C                   EVAL      @SPEC  = *BLANKS
192500110513     C                   EVAL      @COB   = *BLANKS
192600110513     C                   EVAL      @COBC  = *BLANKS
192700110513     C                   EVAL      @COBN  = *BLANKS
192800110513    ***
192900110513     C                   EVAL      #CANCEL = 0
193000110513     C                   EVAL      D#CNE = 0
193100110513     C                   CLEAR                   D@PLN
193200110513     C                   CLEAR                   D@ENR
193300110513     C                   CLEAR                   D@FRM
193400110513     C                   CLEAR                   D@TRM
193500110513     C                   EVAL      M#CNE = 0
193600110513     C                   CLEAR                   M@PLN
193700110513     C                   CLEAR                   M@ENR
193800110513     C                   CLEAR                   M@FRM
193900110513     C                   CLEAR                   M@TRM
194000110513    ***
194100110513     C                   ENDSR
194200110513   S***S
194300110513     C     $DENWRT       BEGSR
194400110513    ***
194500110513    *C                   EVAL      X@LAY = CPCID1                               LAYOUT
194600110513    *C                   EVAL      X@ELR = CPCID2                               ELR
194700110513    *C                   EVAL      D@SFX = CPCID3                               SUFFIX
194800110513    *C                   EVAL      D@ACCT = CPCID4                              ACCOUNT
194900110513    *C                   EVAL      D@PLAN = CPCID5                              PLAN
195000110513    *C                   EVAL      D@CLM = CPCID6                               CLAIM OFFICE
195100110524     C                   EVAL      DNTLATE = '0'
195200110513    ***
195300110513    *C                   EVAL      #XSX = D@FRM(D#CNE)
195400110725     C                   IF        WRT@TYPE = 'DEPEND' AND
195500110725     C                             #XSX < D@MBREFF
195600110725     C                   MOVE      D@MBREFF      X@EFF
195700110725     C                   ELSE
195800110725     C                   MOVE      #XSX          X@EFF
195900110725     C                   ENDIF
196000110513    ***
196100110513    *C                   EVAL      #XSX = D@TRM(D#CNE)
196200110513    *C                   IF        #XSX = 0 OR #XSX = 99999999
196300110513    *C                   MOVE      *BLANKS       X@TRM
196400110513    *C                   ELSE
196500160809    *C****               MOVE      #XSX          X@TRM
196600160809       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
196700160809       if %subdt(work_date:*d) = 01 ;
196800160809        work_date -= %days(1) ;
196900160809        num_date = %dec(work_date:*iso);
197000160809        X@TRM = %EDITC(num_date:'X');
197100160809       endif;
197200160809
197300110513    *C                   ENDIF
197400110513    ***
197500130211     C                   MOVE      *BLANKS       D@CBREXP
197600130211     C                   MOVE      *BLANKS       D@CBREVT
197700130211     C                   MOVE      *BLANKS       D@CBRLEN
197800110513     C                   IF        WRT@TYPE = 'MEMBER'
197900111123    *C                   IF        EMPST = 'C' AND CEXPDT <> 0
198000110513    *C                   MOVE      CEXPDT        D@CBREXP
198100110513    *C                   MOVE      QEDT          D@CBREVT
198200110513    *C                   MOVE      CEXPDT        #MINUEND
198300110513    *C                   MOVE      QEDT          #SUBTRAEND
198400110513    *C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
198500110513    *C                   Z-ADD     #DIFFRNC      #2S0
198600110513    *C                   MOVE      #2S0          D@CBRLEN
198700110513    *C                   ENDIF
198800110513    *C                   ENDIF
198900120806    ***
199000110513    *C                   MOVE      '0'           D@OOAI
199100140313    ***
199200140313     C                   EVAL      KF@SPCD = 'DEN'
199300140313     C                   EVAL      D@PCD = *BLANKS
199400140313     C                   EVAL      *IN81 = *OFF
199500140313     C                   MOVE      *BLANKS       DOCTOR
199600140313    ***
199700140313     C                   EXSR      $PCP
199800140313    ***
199900140313     C                   IF        DOCTOR <> *BLANKS
200000140313     C                   EVAL      D@PCD = DOCTOR
200100140313     C                   EVAL      *IN81 = *ON
200200140313     C                   ENDIF
200300110513    ***
200400120123     C     *LIKE         DEFINE    H@C#          BUC#
200500120123     C                   EVAL      BUC# = H@C#
200600120123    ***
200700151106     C                   if        cacid8 > ' ' and cacid8 <> 'N/A'
200800151106     C                   eval      h@c# = cacid8
200900151106     C                   endif
201000151106
201100120327     C                   SELECT
201200151106     C****               WHEN      KF@TRS = 591 AND KF@SUB = 009 AND            WILMOT MODULAR
201300151106     C****                         KF@ACC = 0202                                 STRUCTURES
201400151106     C****               EVAL      H@C# = '0638156'
201500151106
201600151106     C****               WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            REDLAND
201700151106     C****                         KF@ACC = 0475                                 BAPTISTS
201800151106     C****               EVAL      H@C# = '0725572'
201900151106
202000151106     C****               WHEN      KF@TRS = 825 AND KF@SUB = 001 AND            CREATIVE
202100151106     C****                         KF@ACC = 0014                                 LOGISTICS
202200151106     C****               EVAL      H@C# = '0133860'
202300151106
202400151015     C****               WHEN      KF@TRS = 905 AND KF@SUB = 001 AND            CCL USA
202500151015     C****                         KF@ACC = 0092
202600151015     C****               EVAL      H@C# = '0638423'
202700151106
202800151106     C****               WHEN      KF@TRS = 003 AND KF@SUB = 001 AND            FRAME RITE
202900151106     C****                         KF@ACC = 0104
203000151106     C****               EVAL      H@C# = '0306511'
203100151106
203200151106     C****               WHEN      KF@TRS = 900 AND KF@SUB = 003 AND            PERFECT
203300151106     C****                         KF@ACC = 0045                                 SETTINGS
203400151106     C****               EVAL      H@C# = '0474109'
203500151106
203600151106     C****               WHEN      KF@TRS = 591 AND KF@SUB = 011 AND            MCCALLISTER
203700151106     C****                         KF@ACC = 0446                                 ARCHITECT
203800151106     C****               EVAL      H@C# = '0565330'
203900151106
204000151106     C****               WHEN      KF@TRS = 591 AND KF@SUB = 005 AND            JD CLARK PROF
204100151106     C****                         KF@ACC = 0451                                 SERVICES
204200151106     C****               EVAL      H@C# = '0519890'
204300151106
204400151106     C****               WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            DYSON CONSTRUCTION
204500151106     C****                         KF@ACC = 0459                                 COMPANY
204600151106     C****               EVAL      H@C# = '0788122'
204700151106
204800151106     C****               WHEN      KF@TRS = 591 AND KF@SUB = 004 AND            STROUSE CORP
204900151106     C****                         KF@ACC = 0482
205000151106     C****               EVAL      H@C# = '0837451'
205100151106
205200151106     C****               WHEN      KF@TRS = 900 AND KF@SUB = 007 AND            CAPLAN BROTHERS
205300151106     C****                         KF@ACC = 0075
205400151106     C****               EVAL      H@C# = '0837533'
205500151106
205600151106     C****               WHEN      KF@TRS = 900 AND KF@SUB = 101 AND            INTEGRA HEALTH
205700151106     C****                         KF@ACC = 0042 AND
205800151106     C****                         (STATE = 'TN' OR STATE = 'FL' OR
205900151106     C****                          STATE = 'OH' OR STATE = 'MA') AND
206000151106     C****                         (@PLANIN = 'DAAD' OR @PLANIN = 'BAAD')
206100151106     C****               EVAL      H@C# = '0503428'
206200120123    ***
206300151106     C****               WHEN      KF@TRS = 905 AND KF@SUB = 001 AND            CCL USA
206400151106     C****                         KF@ACC = 0092
206500151106     C****               eval      x@eff =  '20150901'
206600151106     C****               EVAL      H@C# = '0536514'
206700151106      ****
206800151106    *C                   ENDSL
206900151015
207000110513    *C                   EXCEPT    DENF
207100120123     C                   EVAL      H@C# = BUC#
207200110513    ***
207300110513    *C                   ENDSR
207400110513   S***S
207500110512   X***X
207600160829     OAET1050WF EADD         HDRF
207700101203     O                                            6 'HEADER'
207800101229     O                                            8 'P'
207900101206     O                       H@SI                28
208000101203     O                                           29 '0'
208100101203     O                       C1                  43
208200101203     O                       D1                  51
208300101203     O                       T1                  57
208400101206     O                                          131 'CONSOLIDATED ELIGIBILITY'
208500110502     O                       H@RI               167
208600101206     O                       H@CC               169
208700101228     O                       H@GN               176
208800101206     O                       H@CN               191
208900101206     O                       H@C#               198
209000101203     O                       D2                 206
209100110825     O                                          216 'MC'
209200101223     O                                          231 '*'
209300160829     OAET1050WF EADD         MBRF
209400101203     O                                            6 'MEMBER'
209500101203     O                       @SS1                16
209600101203     O                       @SS2                25
209700101203     O                       @FN                 75
209800101203     O                       @MI                 76
209900101203     O                       @LN                 96
210000101203     O                       @REL               101
210100101203     O                       @SEX               103
210200101203     O                       @DOB               111
210300101203     O                       @SPEC              112
210400101203     O                                          113 '0'
210500101203     O                       @COB               123
210600101203     O                       @COBC              125
210700101203     O                       @COBN              145
210800101203     O                       @AD1               175
210900101203     O                       @AD2               205
211000101203     O                       @CTY               315
211100101203     O                       @ST                317
211200101203     O                       @ZP5               322
211300101203     O                       @PHN               349
211400141211     O               87                         576 '21207'
211500140626     O               88                         576 '21740'
211600141120     O               89                         576 '20171'
211700101203     O                       @EMPST             665
211800101203     O                       @HIRE              673
211900101223     O                                         1231 '*'
212000160829     OAET1050WF EADD         HMOF
212100101213     O                                            7 'BENEFIT'
212200101213     O                       X@LAY               10
212300101214     O                       X@ELR               24
212400101213     O                       M@CC                26
212500101213     O                       H@GN                38
212600101213     O                       M@CLASS             44
212700101213     O                       M@PLAN              50
212800101213     O                       X@EFF               58
212900110929     O                       X@TRM               66
213000101213     O                       X@TIER              69
213100101213     O                       M@PCP              160
213200101213     O                       M@NPI              161
213300101213     O                       M@PCPCI            186
213400101223     O                                          323 '*'
213500160829     OAET1050WF EADD         MEAF
213600140313     O                                            7 'BENEFIT'
213700160601     O                                           10 'VIS'
213800140313     O                       X@ELR               24
213900140313     O                       H@C#                31
214000140313     O                       E@SFX               34
214100140313     O                       E@ACCT              44
214200140313     O                       E@PLAN              50
214300140313     O                       X@EFF               58
214400140313     O                       X@TRM               66
214500140313     O                       E@CLM               71
214600140313     *** PCP BGN
214700140313     O                       E@PCP              127
214800140313     O               80                         161 'N'
214900140313     O               80                         186 '0'
215000140313     *** PCP END
215100140313     O                                          389 '0'
215200140313     *** COBRA BGN
215300140313     O                       E@CBREXP           466
215400140313     O                       E@CBREVT           516
215500140313     O                       E@CBRLEN           560
215600140313     *** COBRA END
215700140313     O                                          678 '*'
215800140313    ***
215900160829     OAET1050WF EADD         DENF
216000101213     O                                            7 'BENEFIT'
216100101213     O                       X@LAY               10
216200101214     O                       X@ELR               24
216300101214     O                       H@C#                31
216400101213     O                       D@SFX               34
216500101213     O                       D@ACCT              44
216600101213     O                       D@PLAN              50
216700101213     O                       X@EFF               58
216800110929     O                       X@TRM               66
216900101213     O                       D@CLM               71
217000140313     *** PCD BGN
217100140313     O                       D@PCD              200
217200140313     O               81                         236 '0'
217300140313     *** PCD END
217400140313     O                                          389 '0'
217500140313     *** COBRA BGN
217600140313     O                       D@CBREXP           466
217700140313     O                       D@CBREVT           516
217800140313     O                       D@CBRLEN           560
217900140313     *** COBRA END
218000140313     O                       D@OOAI             609
218100140313     O                                          678 '*'
218200140313    ***
218300160829     OAET1050WF EADD         LIFF
218400130315     O                                            7 'BENEFIT'
218500130412     O                                           11 'LIFE'
218600130315     O                       X@ELR               24
218700130319     O                       H@C#3               31
218800130315     O                       L@SFX               34
218900130315     O                       L@ACCT              44
219000130315     O                       L@PLAN              50
219100130315     O                       X@EFF               58
219200130315     O                       X@TRM               66
219300130315     O                       L@CLM               71
219400130315     O                       L@CBREXP           466
219500130315     O                       L@CBREVT           516
219600130315     O                       L@CBRLEN           560
219700130315     O                       L@SALARY           658
219800130315     O                                          659 '1'
219900130315     O                                          678 '*'
220000160829     OAET1050WF EADD         TRLF
220100101203     O                                            7 'TRAILER'
220200101203     O                       @TREC               17
220300101203     O                       D1                  25
220400101203     O                       T1                  31
220500101203     O                       @BREC               41
220600101223     O                                           69 '*'
