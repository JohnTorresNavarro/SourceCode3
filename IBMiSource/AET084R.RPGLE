000100110802   X***X CARRIER CONTROL ID #0000000011 AETNA SPECIFIC
000200120803   X***X CARRIER CONTROL ID #0000000051 AETNA SPECIFIC
000300110513   X***X SSK 05.13.2011 TEMPLATE DESIGN
000400110513   X***X
000500110802   X***X 08.02.2011 CLONED FROM AET0X0R
000600110818   X***X 08.18.2011 AETNA APPROVED FOR PRODUCTION
000700110914   X***X 09.14.2011 ADDED ANOTHER SET OF SMALL GROUPS
000800120125   X***X 01.25.2012 CHANGE OF PLAN NUMBERS FOR IT OBJECTS
000900120803   X***X 08.03.2012 CHANGE TO METHOD FILE
001000121024   X***X 10.24.2012 MCCALLISTER ARCHITECTS, DENTAL ONLY SEPARATE # ADDED
001100130123   X***X 01.23.2013 ADDED METHOD 13 BASED ON BELFAST REQUIREMENT
001200120806   X***X
001300120806   X***X
001400120806   X***X CREATIVE LOGISTICS AND INTEGRA ARE SPECIALIZED GROUP # IN THE DENTAL SECTION
001500120806   X***X  AT THE BOTTOM OF THE PROGRAM.
001600101206   X***X
001700130315   X***X 03.15.2013 ADD LIFE PRODUCTS
001800130520   X***X 05.20.2013 MOVED TO PRODUCTION
001900120806   X***X
002000130627   X***X 06.27.2013 DYSON DENTAL
002100130712   X***X 07.12.2013 CAPLAN BROTHERS DENTAL
002200131126   X***X 11.26.2013 WILMOT MODULAR STRUCTURES, INC
002300101206   X***X
002400110725   X***X **INCLUDES SONDA MODIFICATION ON 7/25/2011 FOR DEP EFF DATE
002500101206   X***X
002600140313   X***X **NOW INCLUDES PCP INFORMATION
002700101206   X***X
002800101206   X***X
002900130315     F*CARXPTP   IF   E           K DISK
003000101012     FCARACCP   IF   E           K DISK
003100101012     FCARPLNP   IF   E           K DISK
003200101012   X***X
003300120803     FAET001WF  IF   E           K DISK
003400120803     ** MAPPING METHOD
003500110802     FAET080WF  O  A F 1231        DISK
003600101206     ** FLAT FILE
003700110802     FAET081WF  IF A E           K DISK
003800101028     ** TERM TRACKER
003900101028     **
004000101012     FMEMAC#1   IF   E           K DISK
004100101012     FMCOVMPLN  IF   E           K DISK
004200101012     FDEPNDC    IF   E           K DISK
004300101012     FDCOVA     IF   E           K DISK
004400140313     FPCPL1     IF   E           K DISK
004500101012   X***X
004600120803     D KF@CCTL         S             10A   INZ
004700130521     D CARR#CTL        S             10A   INZ('0000000011')
004800120815     D*CARR#CTL2       S             10A   INZ('0000000051')
004900110512     D H@RI            S             25A   INZ('042064683')                     RECEIVER ID
005000110512   X***X
005100110512     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
005200101026     D DS@CARACC     E DS                  EXTNAME(CARACCP)
005300130315     D*DS@CARXPT     E DS                  EXTNAME(CARXPTP)
005400101026   X***X
005500110512     ** WORK ARRAY FOR PLANS
005600110512     **
005700110512     ** PC# - PLAN COUNT
005800110512     ** PP# - PLAN POINTER
005900110512     **
006000110512     D CARPLN@       E DS                  EXTNAME(CARPLNP)
006100140313     D                                     OCCURS(80) PREFIX(X:1)
006200110512     D PC#             S              3S 0
006300110512     D PP#             S              3S 0
006400110512     D @PLANIN         S              4A
006500110512     D @CCTRIN         S              3A
006600110513   X***X
006700110513     **
006800110513     ** WRITE TYPE = MEMBER OR DEPEND
006900110513     D WRT@TYPE        S              6A
007000110513     **
007100110512   X***X
007200101214     D #XST            S              6S 0
007300101214     D #IST            S               T
007400101026     D #ISO            S               D   DATFMT(*ISO)
007500101214     D #MINUEND        S               D   DATFMT(*ISO)
007600101214     D #SUBTRAEND      S               D   DATFMT(*ISO)
007700101214     D @DATE           S              8A
007800101214     D @TIME           S              6A
007900101214     D #DIFFRNC        S              5S 0
008000101214     D #2S0            S              2S 0
008100101214     D #CANCEL         S              8S 0
008200101026     D #XSX            S              8S 0
008300101026     D #XSX2           S              8S 0
008400101026     D DATE@OUT        S             10A
008500101026     D ENR@IN          S              3A
008600101026     D ENR@OUT         S              1A
008700110524     D DNTLATE         S              1A
008800130315     D TERM_LIF        S               N
008900101214     D TERM_DEN        S               N
009000101214     D TERM_MED        S               N
009100101026     D YES             S               N   INZ(*ON)
009200101026     D NO              S               N   INZ(*OFF)
009300140313     **
009400110512     D KF@TRS          S                   LIKE(MCTRST)
009500110512     D KF@SUB          S                   LIKE(MCSUB#)
009600110512     D KF@ACC          S                   LIKE(ACC#)
009700101026     D KF@ENR          S              3A   INZ
009800101026     D KF@CARG         S              2A   INZ
009900101026     D KF@CCTR         S                   LIKE(CCFLG)
010000101026     D KF@PLN          S                   LIKE(MCPLAN)
010100101026     D KF@TRM          S                   LIKE(NTTERMDT)
010200101026     D KF#TRM          S              8S 0
010300101026     D KF@SSN          S                   LIKE(MBSSNO)
010400101026     D KF@SEQ          S                   LIKE(DPSEQ#)
010500101026     D KF@TYP          S              1A
010600101026     D KF@CDE          S              2A
010700140313     D KF@SPCD         S              5A
010800140313     D KF@MPLN         S              4A
010900140313     **
011000101026     D M@EARLYP        S              4A
011100101026     D M#EARLYE        S              8S 0 INZ
011200101026     D M#EARLYT        S              8S 0 INZ
011300140313     **
011400101026     D #8D1            S              8S 0 INZ
011500101214     D D1              S              8A
011600101214     D D2              S              8A
011700101214     D T1              S              6A
011800101214     D C1              S             14A
011900101206    ***
012000101029     D B#RECCNT        S             10S 0 INZ
012100101029     D C#RECCNT        S             10S 0 INZ
012200101206    ***
012300101210     D @SS1            S              9A
012400101210     D @SS2            S              9A
012500101210     D @FN             S             15A
012600101210     D @MI             S              1A
012700101210     D @LN             S             20A
012800101210     D @REL            S              2A
012900101210     D @SEX            S              1A
013000101210     D @DOB            S              8A
013100101210     D @SPEC           S              1A
013200101210     D @COB            S              1A
013300101210     D @COBC           S              2A
013400101210     D @COBN           S             20A
013500101210     D @AD1            S             30A
013600101210     D @AD2            S             30A
013700101214     D @CTY            S             20A
013800101210     D @ST             S              2A
013900101210     D @ZP5            S              5A
014000101210     D @PHN            S             10A
014100101210     D @EMPST          S              2A
014200101210     D @HIRE           S              8A
014300101206    ***
014400130315    *** LIFE ARRAYS
014500130315     D L#CNE           S              3S 0 INZ
014600130315     D L#NDX           S              3S 0 INZ
014700130315     D L@PLN           S              4A   DIM(20)
014800130315     D L@ENR           S              3A   DIM(20)
014900130315     D L@FRM           S              8S 0 DIM(20)
015000130315     D L@TRM           S              8S 0 DIM(20)
015100130315     D L@MBREFF        S              8S 0
015200140313    ***
015300101206    *** DENTAL ARRAYS
015400101206     D D#CNE           S              3S 0 INZ
015500101206     D D#NDX           S              3S 0 INZ
015600101206     D D@PLN           S              4A   DIM(20)
015700101206     D D@ENR           S              3A   DIM(20)
015800101206     D D@FRM           S              8S 0 DIM(20)
015900101206     D D@TRM           S              8S 0 DIM(20)
016000110725     D D@MBREFF        S              8S 0
016100140313    ***
016200101206    *** MEDICAL ARRAYS
016300101206     D M#CNE           S              3S 0 INZ
016400101206     D M#NDX           S              3S 0 INZ
016500101206     D M@PLN           S              4A   DIM(20)
016600101206     D M@ENR           S              3A   DIM(20)
016700101206     D M@FRM           S              8S 0 DIM(20)
016800101206     D M@TRM           S              8S 0 DIM(20)
016900110725     D M@MBREFF        S              8S 0
017000101206    ***
017100101206     D H@SI            S             20A
017200101206     D H@CC            S              2A
017300101206     D H@GN            S              7A
017400101206     D H@CN            S             15A
017500101206     D H@C#            S              7A
017600130319     D H@C#3           S              7A
017700140313    ***
017800101213     D X@LAY           S              3A
017900101213     D X@ELR           S              7A
018000140313     D X@EFF           S              8A
018100140313     D X@TRM           S              8A
018200140313     D X@TIER          S              1A
018300140313    ***
018400101213     D M@CC            S              2A
018500101213     D M@CLASS         S              5A
018600101213     D M@PLAN          S              6A
018700101213     D M@PCP           S             40A
018800101213     D M@NPI           S              1A
018900101213     D M@PCPCI         S              1A
019000140313    ***
019100101213     D D@SFX           S              3A
019200101213     D D@ACCT          S              5A
019300101213     D D@PLAN          S              6A
019400101213     D D@CLM           S              3A
019500101213     D D@CBREXP        S              8A
019600101213     D D@CBREVT        S              8A
019700101213     D D@CBRLEN        S              2A
019800101213     D D@OOAI          S              1A
019900140313     D D@PCD           S              7A
020000140313    ***
020100101214     D @STEP           S              5A
020200140313    ***
020300140313     D E@SFX           S              3A
020400140313     D E@ACCT          S              5A
020500140313     D E@PLAN          S              6A
020600140313     D E@CLM           S              3A
020700140313     D E@PCP           S              7A
020800140313     D E@CBREXP        S              8A
020900140313     D E@CBREVT        S              8A
021000140313     D E@CBRLEN        S              2A
021100140313    ***
021200130315     D L@SFX           S              3A
021300130315     D L@ACCT          S              5A
021400130315     D L@PLAN          S              6A
021500130315     D L@CLM           S              3A
021600130315     D L@CBREXP        S              8A
021700130315     D L@CBREVT        S              8A
021800130315     D L@CBRLEN        S              2A
021900130315     D L@SALARY        S             20A
022000140313    ***
022100101026   X***X
022200110512     C                   EVAL      @STEP = 'PREP1'
022300101214    ***
022400120803     C                   EVAL      KF@CCTL = CARR#CTL
022500130315     C*    KF@CCTL       CHAIN     CARXPTR
022600110802     C                   EXSR      $HEADR
022700110512    ***
022800120803     C     KF@CCTL       SETLL     CARACCR
022900110512    ***
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
025400120711    ***
025500120711    ***  CALL SECOND PROGRAM
025600120711    ***
025700120803    *C*                  MOVE      *ALL'0'       @TADD            10
025800120803    *C*                  MOVE      *ALL'0'       @BADD            10
025900120803    *C*                  CALL      'AET081CL'
026000120803    *C*                  PARM                    @TADD
026100120803    *C*                  PARM                    @BADD
026200120803    *C*                  MOVE      @TADD         #TADD            10 0
026300120803    *C*                  ADD       #TADD         C#RECCNT
026400120803    *C*                  MOVE      @BADD         #BADD            10 0
026500120803    *C*                  ADD       #BADD         B#RECCNT
026600120711    ***
026700101206    ***  TRAILER RECORD
026800120711    ***
026900101026     C                   ADD       2             C#RECCNT
027000101214     C                   MOVE      C#RECCNT      @TREC            10 0
027100101214     C                   MOVE      B#RECCNT      @BREC            10 0
027200101214     C                   EXCEPT    TRLF
027300101026    ***
027400101026     C                   EVAL      *INLR = *ON
027500110512   S***S
027600110802     C     $HEADR        BEGSR
027700101206    ***
027800110802     C                   EVAL      D1 = @DATE
027900110802     C                   EVAL      D2 = @DATE
028000110802     C                   EVAL      T1 = @TIME
028100110802     C                   EVAL      C1 = @DATE + @TIME
028200110802    ***
028300110802     C                   EVAL      KF@TRS = 999
028400110802     C                   EVAL      KF@SUB = 999
028500110802     C                   EVAL      KF@ACC = 9999
028600110802     C     KL#ACCTL      CHAIN     CARACCR
028700110802    ***
028800110802     C                   EVAL      H@SI = %TRIM(CACID1)                         SUBMITTER ID
028900110802     C                   EVAL      H@CC = %SUBST(CACID2:1:2)                    COMPANY CODE
029000110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
029100110802     C                   MOVEL(P)  CACID4        H@CN                           CUSTOMER NAME
029200110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
029300130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
029400110802    ***
029500110802     C                   EXCEPT    HDRF
029600110802    ***
029700110802     C                   ENDSR
029800110802   S***S
029900110802     C     $PREP1        BEGSR
030000110802    ***
030100120803     C     KF@CCTL       READE     CARACCR
030200110512    ***
030300110512     C                   IF        %EOF(CARACCP)
030400120803      *
030500120815     C*                  IF        KF@CCTL = CARR#CTL
030600120815     C*                  EVAL      KF@CCTL = CARR#CTL2
030700120815     C*    KF@CCTL       SETLL     CARACCR
030800120815     C*                  ELSE
030900110512     C                   EVAL      @STEP = 'LEAVE'
031000120815     C*                  ENDIF
031100120803      *
031200110512     C                   LEAVESR
031300110512     C                   ENDIF
031400110512    ***
031500110513    *** HAS THE ACCOUNT BEEN SHUTOFF FOR EXPORT?
031600110513    ***
031700110512     C                   IF        CASTATUS <> 'Y'
031800110512     C                   LEAVESR
031900110512     C                   ENDIF
032000110512    ***
032100110802    *** THESE FIELDS RESET FOR EACH SMALL GROUP READ
032200110802    ***
032300110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
032400110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
032500130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
032600110802    ***
032700110512     C                   EVAL      KF@TRS = CATRST
032800110512     C                   EVAL      KF@SUB = CASUB#
032900110512     C                   EVAL      KF@ACC = CAACCT
033000110512    ***
033100110512     C                   EXSR      $PLANLOAD
033200110512    ***
033300101206     C                   EVAL      @STEP = 'STEP1'
033400110512    ***
033500110512     C                   ENDSR
033600110512   S***S
033700101206     C     $STEP1        BEGSR
033800101206    ***
033900101206     C                   EVAL      KF@PLN = *BLANKS
034000101206     C                   EVAL      KF@TRM = 0
034100101206     C                   EVAL      KF@SSN = 0
034200101206     C                   EVAL      KF@SEQ = 0
034300110512    ***
034400101206     C     KL#TSA        SETLL     MEMBR
034500101206    ***
034600101206     C                   EVAL      @STEP = 'STEP2'
034700101206    ***
034800101206     C                   ENDSR
034900101206   S***S
035000101206     C     $STEP2        BEGSR
035100101206    ***
035200101206     C     KL#TSA        READE     MEMBR
035300101206    ***
035400101206     C                   IF        %EOF(MEMAC#1)
035500110512     C                   EVAL      @STEP = 'PREP1'
035600101206     C                   LEAVESR
035700101206     C                   ENDIF
035800101206    ***
035900101206     C                   EVAL      KF@SSN = MBSSNO
036000101214     C                   MOVE      *ZEROS        KF@SEQ
036100120803     C                   EVAL      WRT@TYPE = 'MEMBER'
036200120803    ***
036300101214    ***
036400101206     C     KL#MPLN       SETLL     MCOVR
036500101206    ***
036600101206     C                   EXSR      $CLRSTG
036700101206    ***
036800101206     C                   EVAL      @STEP = 'STEP3'
036900101206    ***
037000101206     C                   ENDSR
037100101210   S***S
037200101206     C     $STEP3        BEGSR
037300101206    ***
037400101206     C     KL#MPLN       READE     MCOVR
037500101206    ***
037600101206     C                   IF        %EOF(MCOVMPLN)
037700101206     C                   EVAL      @STEP = 'PREP4'
037800101206     C                   LEAVESR
037900101206     C                   ENDIF
038000101206    ***
038100130131     C*                  IF        ENRLDT = CANDT
038200130131     C*                  LEAVESR
038300130131     C*                  ENDIF
038400120803    ***
038500120803     C                   EVAL      KF@PLN = MCPLAN
038600120803     C     KL#TSAP       CHAIN     AEF01
038700120803     C                   IF        NOT %FOUND(AET001WF)
038800120803     C                   LEAVESR
038900120803     C                   ENDIF
039000110513    ***
039100110512     C                   EVAL      @PLANIN = MCPLAN
039200111020     C                   EVAL      ENR@IN = MCOVTP
039300110802    ***
039400110802     C                   EXSR      $QUIK
039500110802    ***
039600110512     C                   EXSR      $PLANSRCH
039700110512    ***
039800110512     C                   IF        PLN@CAT = *BLANKS
039900110512     C                   LEAVESR
040000110512     C                   ENDIF
040100101206    ***
040200101206     C                   IF        CANDT = 0
040300101206     C                   EVAL      #CANCEL = 99999999
040400101206     C                   ELSE
040500101206     C                   EVAL      #CANCEL = CANDT
040600101206     C                   ENDIF
040700101206    ***
040800130315    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL;
040900130315    *** LIF IS LIFE;
041000110513    ***
041100130315     C                   SELECT
041200130315      *
041300130409    *C                   WHEN      PLN@CAT = 'LIFE'
041400130315    *C                   IF        L#CNE > 0
041500130315    *C                   IF        L@TRM(L#CNE) = 99999999
041600130315     C                   LEAVESR
041700130315     C                   ENDIF
041800130315     C                   ENDIF
041900130315    *C                   ADD       1             L#CNE
042000130315    *C                   EVAL      L@PLN(L#CNE) = MCPLAN
042100130315    *C                   EVAL      L@ENR(L#CNE) = MCOVTP
042200130315    *C                   EVAL      L@FRM(L#CNE) = ENRLDT
042300130315    *C                   EVAL      L@TRM(L#CNE) = #CANCEL
042400130315      *
042500130315    *C                   WHEN      PLN@CAT = 'DEN'
042600130131    *C                   IF        D#CNE > 0
042700130131    *C                   IF        D@TRM(D#CNE) = 99999999
042800130131     C                   LEAVESR
042900130131     C                   ENDIF
043000130131     C                   ENDIF
043100110513    *C                   ADD       1             D#CNE
043200110513    *C                   EVAL      D@PLN(D#CNE) = MCPLAN
043300110513    *C                   EVAL      D@ENR(D#CNE) = MCOVTP
043400110513    *C                   EVAL      D@FRM(D#CNE) = ENRLDT
043500110513    *C                   EVAL      D@TRM(D#CNE) = #CANCEL
043600130315      *
043700130315     C                   OTHER
043800130131    *C                   IF        M#CNE > 0
043900130131    *C                   IF        M@TRM(M#CNE) = 99999999
044000130131     C                   LEAVESR
044100130131     C                   ENDIF
044200130131     C                   ENDIF
044300101206     C                   ADD       1             M#CNE
044400101206     C                   EVAL      M@PLN(M#CNE) = MCPLAN
044500101206     C                   EVAL      M@ENR(M#CNE) = MCOVTP
044600101206     C                   EVAL      M@FRM(M#CNE) = ENRLDT
044700101206     C                   EVAL      M@TRM(M#CNE) = #CANCEL
044800130315      *
044900130315    *C                   ENDSL
045000110512    ***
045100110512     C                   ENDSR
045200110512   S***S
045300110802     C     $QUIK         BEGSR
045400110802    ***
045500110805     C                   EVAL      @CCTRIN = *BLANKS
045600120803    ***
045700120803     C     AE1MAP        CASEQ     '2TIER     '  $METH01
045800120803     C     AE1MAP        CASEQ     'ITOBJECTS '  $METH02
045900120803     C     AE1MAP        CASEQ     'NORULE    '  $METH03
046000120803     C     AE1MAP        CASEQ     'STATETIER '  $METH04
046100120803     C     AE1MAP        CASEQ     'TIERSTS   '  $METH05
046200120803     C     AE1MAP        CASEQ     'MAYOR     '  $METH06
046300120803     C     AE1MAP        CASEQ     'EMPSTS    '  $METH07
046400120803     C     AE1MAP        CASEQ     'JUSTSTATE '  $METH08
046500120803     C     AE1MAP        CASEQ     'JOHNLS    '  $METH09
046600120803     C     AE1MAP        CASEQ     'CREATIVE  '  $METH10
046700120803     C     AE1MAP        CASEQ     'INTEGRA   '  $METH11
046800120803     C     AE1MAP        CASEQ     'STSTATE   '  $METH12
046900130123     C     AE1MAP        CASEQ     'INTEGRA   '  $METH11
047000130123     C     AE1MAP        CASEQ     'STIERSTS  '  $METH13
047100120803     C                   ENDCS
047200120803    ***
047300120803     C                   ENDSR
047400120803   S***S
047500120803    *** 2 TIER = AETNA HAS TWO TIERS, IND AND FAM
047600120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'IND' AND NON-'TIN' CONVERTED TO 'FAM'
047700120803    ***  DEPENDENTS HAVE 'FAM' ONLY
047800120803    ***
047900120803    *** IND, FAM
048000120803    ***
048100120803     C     $METH01       BEGSR
048200120803    ***
048300120803     C                   IF        WRT@TYPE = 'MEMBER'
048400120803    *** *
048500120803     C                   IF        ENR@IN = 'TIN'
048600120803     C                   EVAL      @CCTRIN = 'IND'
048700120803     C                   ELSE
048800120803     C                   EVAL      @CCTRIN = 'FAM'
048900120803     C                   ENDIF
049000120803    *** *
049100120803     C                   ENDIF
049200120803    ***
049300120803     C                   IF        WRT@TYPE = 'DEPEND'
049400120803    *** *
049500120803     C                   EVAL      @CCTRIN = 'FAM'
049600120803    *** *
049700120803     C                   ENDIF
049800120803    ***
049900120803     C                   ENDSR
050000120803   S***S
050100120803    *** ITOBJECTS = IF YOU ARE NOT 'VA' OR 'OH' STATE CODES, YOU ARE 'XX'
050200120803    ***
050300120803    *** VA, OH, XX
050400120803    ***
050500120803     C     $METH02       BEGSR
050600120803    ***
050700120803     C                   IF        STATE <> 'VA' AND STATE <> 'OH'
050800120803     C                   EVAL      @CCTRIN = 'XX '
050900120803     C                   ELSE
051000120803     C                   EVAL      @CCTRIN = STATE
051100120803     C                   ENDIF
051200120803    ***
051300120803     C                   ENDSR
051400120803   S***S
051500120803    *** NORULE = NUFF SAID
051600120803    ***
051700120803     C     $METH03       BEGSR
051800120803    ***
051900120803     C                   EVAL      @CCTRIN = *BLANKS
052000120803    ***
052100120803     C                   ENDSR
052200120803   S***S
052300120803    *** STATETIER
052400120803    ***  START WITH STATE CODE
052500120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
052600120803    ***  DEPENDENTS HAVE 'F' ONLY
052700120803    ***
052800120803    *** MDI, MDF, ETC...
052900120803    ***
053000120803     C     $METH04       BEGSR
053100120803    ***
053200120803     C                   EVAL      @CCTRIN = STATE
053300120803    ***
053400120803     C                   IF        WRT@TYPE = 'MEMBER'
053500120803     C                   IF        ENR@IN = 'TIN'
053600120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
053700120803     C                   ELSE
053800120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
053900120803     C                   ENDIF
054000120803     C                   ENDIF
054100120803    ***
054200120803     C                   IF        WRT@TYPE = 'DEPEND'
054300120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
054400120803     C                   ENDIF
054500120803    ***
054600120803     C                   ENDSR
054700120803   S***S
054800120803    *** TIERSTS
054900120803    ***  START WITH EMPLOYMENT STATUS, ACTIVE IS 'ACT' AND COBRA IS 'COB'
055000120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
055100120803    ***  DEPENDENTS HAVE 'F' ONLY
055200120803    ***
055300120803    *** ACI, ACF, COI, COF
055400120803    ***
055500120803     C     $METH05       BEGSR
055600120803    ***
055700120803     C                   IF        EMPST =  'C'
055800120803     C                   EVAL      @CCTRIN = 'COB'
055900120803     C                   ELSE
056000120803     C                   EVAL      @CCTRIN = 'ACT'
056100120803     C                   ENDIF
056200120803    ***
056300120803     C                   IF        ENR@IN = 'TIN'
056400120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
056500120803     C                   ELSE
056600120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
056700120803     C                   ENDIF
056800120803    ***
056900120803     C                   ENDSR
057000120803   S***S
057100120803    *** MAYOR
057200120803    ***  WELL, FOR THE PLAN 'DAAU' IF THE STATE IS 'WV' THEN PLACE TIER STATUS SUFFIX
057300120803    ***       BY TYPE OF PEEP; FOR OTHER STATES, USE A SIMPLE TIER CHECK.
057400120803    ***
057500120803    ***  WVI, WVF, IND, FAM
057600120803    ***
057700120803    ***  NOW, FOR THE PLAN 'DAAT' IF THE STATE IS 'WV' THEN PLACE EMPLOYMENT STATUS SUFFIX
057800120803    ***       BY TYPE OF PEEP; FOR OTHER STATES, EMPLOYMENT STATUS AND TIER.
057900120803    ***
058000120803    ***  WVI, WVF, CBI, CBF, ACI, ACF
058100120803    ***
058200120803    ***
058300120803     C     $METH06       BEGSR
058400120803    ***
058500120803    1C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'MEMBER'
058600120803      *
058700120803    2C                   IF        STATE = 'WV'
058800120803      **
058900120803    3C                   IF        ENR@IN = 'TIN'
059000120803     C                   EVAL      @CCTRIN = 'WVI'
059100120803    3C                   ELSE
059200120803     C                   EVAL      @CCTRIN = 'WVF'
059300120803    3C                   ENDIF
059400120803      **
059500120803    2C                   ELSE
059600120803      **
059700120803    3C                   IF        ENR@IN = 'TIN'
059800120803     C                   EVAL      @CCTRIN = 'IND'
059900120803    3C                   ELSE
060000120803     C                   EVAL      @CCTRIN = 'FAM'
060100120803    3C                   ENDIF
060200120803      **
060300120803    2C                   ENDIF
060400120803      *
060500120803     C                   LEAVESR
060600120803    1C                   ENDIF
060700120803    ***
060800120803     C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'DEPEND'
060900120803      *
061000120803     C                   IF        STATE = 'WV'
061100120803     C                   EVAL      @CCTRIN = 'WVF'
061200120803     C                   ELSE
061300120803     C                   EVAL      @CCTRIN = 'FAM'
061400120803     C                   ENDIF
061500120803      *
061600120803     C                   LEAVESR
061700120803     C                   ENDIF
061800120803    ***
061900120803    1C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'MEMBER'
062000120803      *
062100120803    2C                   IF        STATE = 'WV'
062200120803      **
062300120803    3C                   IF        ENR@IN = 'TIN'
062400120803     C                   EVAL      @CCTRIN = 'WVI'
062500120803    3C                   ELSE
062600120803     C                   EVAL      @CCTRIN = 'WVF'
062700120803    3C                   ENDIF
062800120803      **
062900120803    2C                   ELSE
063000120803      **
063100120803    3C                   IF        EMPST =  'C'
063200120803     C                   EVAL      @CCTRIN = 'CB '
063300120803    3C                   ELSE
063400120803     C                   EVAL      @CCTRIN = 'AC '
063500120803    3C                   ENDIF
063600120803    3C                   IF        ENR@IN = 'TIN'
063700120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
063800120803    3C                   ELSE
063900120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
064000120803    3C                   ENDIF
064100120803      **
064200120803    2C                   ENDIF
064300120803      *
064400120803     C                   LEAVESR
064500120803    1C                   ENDIF
064600120803    ***
064700120803     C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'DEPEND'
064800120803      *
064900120803     C                   IF        STATE = 'WV'
065000120803     C                   EVAL      @CCTRIN = 'WVF'
065100120803     C                   ELSE
065200120803     C                   IF        EMPST =  'C'
065300120803     C                   EVAL      @CCTRIN = 'CBF'
065400120803     C                   ELSE
065500120803     C                   EVAL      @CCTRIN = 'ACF'
065600120803     C                   ENDIF
065700120803     C                   ENDIF
065800120803      *
065900120803     C                   ENDIF
066000120803    ***
066100120803     C                   ENDSR
066200120803   S***S
066300120803    *** EMPSTS
066400120803    ***   PRETTY STRAIGHT FORWARDED
066500120803    ***
066600120803     C     $METH07       BEGSR
066700120803    ***
066800120803     C                   IF        EMPST =  'C'
066900120803     C                   EVAL      @CCTRIN = 'COB'
067000120803     C                   ELSE
067100120803     C                   EVAL      @CCTRIN = 'ACT'
067200120803     C                   ENDIF
067300120803    ***
067400120803     C                   ENDSR
067500120803   S***S
067600120803    *** JUSTSTATE
067700120803    ***   PRETTY STRAIGHT FORWARDED
067800120803    ***
067900120803     C     $METH08       BEGSR
068000120803    ***
068100120803     C                   EVAL      @CCTRIN = STATE
068200120803    ***
068300120803     C                   ENDSR
068400120803   S***S
068500120803    *** JOHNLS
068600120803    ***   IF STATE IS NOT MARYLAND, DEFAULT TO 'XX', ELSE USE 'MD'; THEN APPLY TIER.
068700120803    ***
068800120803    *** MDI, MDF, XXI, XXF
068900120803    ***
069000120803     C     $METH09       BEGSR
069100120803    ***
069200120803     C                   IF        WRT@TYPE = 'MEMBER'
069300120803     C                   IF        STATE = 'MD'
069400120803     C                   EVAL      @CCTRIN = 'MD'
069500120803     C                   ELSE
069600120803     C                   EVAL      @CCTRIN = 'XX'
069700120803     C                   ENDIF
069800120803     C                   IF        ENR@IN = 'TIN'
069900120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
070000120803     C                   ELSE
070100120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
070200120803     C                   ENDIF
070300120803     C                   ENDIF
070400120803    ***
070500120803     C                   IF        WRT@TYPE = 'DEPEND'
070600120803     C                   IF        STATE = 'MD'
070700120803     C                   EVAL      @CCTRIN = 'MDF'
070800120803     C                   ELSE
070900120803     C                   EVAL      @CCTRIN = 'XXF'
071000120803     C                   ENDIF
071100120803     C                   ENDIF
071200120803    ***
071300120803     C                   ENDSR
071400120803   S***S
071500120803    *** CREATIVE
071600120803    ***   IF STATE IS NOT 'MD' OR 'OK', DEFAULT TO '**'.
071700120803    ***
071800120803    *** MD, OK, **
071900120803    ***
072000120803     C     $METH10       BEGSR
072100120803    ***
072200120803     C                   IF        STATE <> 'MD' AND STATE <> 'OK'
072300120803     C                   EVAL      @CCTRIN = '** '
072400120803     C                   ELSE
072500120803     C                   EVAL      @CCTRIN = STATE
072600120803     C                   ENDIF
072700120803    ***
072800120803     C                   ENDSR
072900120803   S***S
073000120803    *** INTEGRA = USE 'TN' FOR TENNESSEE, OTHER STATES ARE 'XX'
073100120803    ***
073200120803    ***  TN, XX
073300120803    ***
073400120803     C     $METH11       BEGSR
073500120803    ***
073600121113     C                   SELECT
073700121113     C                   WHEN      STATE = 'TN'
073800121113     C                   EVAL      @CCTRIN = STATE                              TENNESSEE ONLY
073900121113     C                   WHEN      STATE = 'FL'
074000121113     C                   EVAL      @CCTRIN = STATE                              FLORIDA ONLY
074100121113     C                   OTHER
074200121113     C                   EVAL      @CCTRIN = 'XX '                              SITUS
074300121113     C                   ENDSL
074400120803    ***
074500120803     C                   ENDSR
074600120803   S***S
074700120803    *** STSTATE = STATE CODE WITH EMPLOYEE STATUS
074800120803    ***
074900120803    ***  MDA, MDC, ETC...
075000120803    ***
075100120803     C     $METH12       BEGSR
075200120803    ***
075300120803     C                   EVAL      @CCTRIN = STATE + EMPST
075400120803    ***
075500120803     C                   ENDSR
075600130123   S***S
075700130123    *** STIERSTS = STATE CODE WITH TIER WITH EMPLOYEE STATUS
075800130123    ***    ACTIVE [#CALC = 0]      COBRA [#CALC = 5]
075900130123    ***    IND [+1 TO #CALC ]      NON-IND COVERAGE [+2 TO CALC]
076000130123    ***
076100130123    ***    EACH STATE PUT AT END, GIVING FAM MARYLAND ACTIVE A VALUE OF 2MD
076200130123    ***                                  IND WEST VIRGINIA COBRA A VALUE OF 6WV
076300130123    ***
076400130123    ***
076500130123     C     $METH13       BEGSR
076600130123    ***
076700130123     C                   SELECT
076800130123     C                   WHEN      EMPST =  'C'
076900130123     C                   Z-ADD     5             #CALC
077000130123     C                   OTHER
077100130123     C                   MOVE      *ZEROS        #CALC             1 0
077200130123     C                   ENDSL
077300130123    ***
077400130123     C                   SELECT
077500130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN = 'TIN'
077600130123     C                   ADD       1             #CALC
077700130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN <> 'TIN'
077800130123     C                   ADD       2             #CALC
077900130123     C                   WHEN      WRT@TYPE = 'DEPEND'
078000130123     C                   ADD       2             #CALC
078100130123     C                   ENDSL
078200130123    ***
078300130123     C                   EVAL      @CCTRIN = %EDITC(#CALC:'X') + STATE
078400130123    ***
078500130123     C                   ENDSR
078600120803   S***S
078700120409     C     $PREP4        BEGSR
078800120409    ***
078900130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
079000101206     C                   EVAL      @STEP = 'STEP2'
079100101206     C                   LEAVESR
079200101206     C                   ENDIF
079300130520    ***
079400130520     C                   EVAL      @STEP = 'STEP4'
079500130315     C                   EVAL      TERM_LIF = NO
079600101210     C                   EVAL      TERM_DEN = NO
079700101210     C                   EVAL      TERM_MED = NO
079800101210    ***
079900130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
080000130520     C                   IF        L@TRM(L#CNE) <> 99999999
080100130520     C                   EXSR      $CHKHEM
080200130520     C                   ENDIF
080300130520     C                   LEAVESR
080400130520     C                   ENDIF
080500130520    ***
080600130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
080700130520     C                   IF        M@TRM(M#CNE) <> 99999999
080800130520     C                   EXSR      $CHKHEM
080900130520     C                   ENDIF
081000130520     C                   LEAVESR
081100130520     C                   ENDIF
081200130520    ***
081300130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
081400130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
081500130520     C                              M@TRM(M#CNE) <> 99999999)
081600130520     C                   EXSR      $CHKHEM
081700130520     C                   ENDIF
081800130520     C                   LEAVESR
081900130520     C                   ENDIF
082000130520    ***
082100130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
082200130520     C                   IF        D@TRM(D#CNE) <> 99999999
082300130520     C                   EXSR      $CHKHEM
082400130520     C                   ENDIF
082500130520     C                   LEAVESR
082600130520     C                   ENDIF
082700130520    ***
082800130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
082900130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
083000130520     C                              D@TRM(D#CNE) <> 99999999)
083100130520     C                   EXSR      $CHKHEM
083200130520     C                   ENDIF
083300130520     C                   LEAVESR
083400130520     C                   ENDIF
083500130520    ***
083600130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
083700130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
083800130520     C                              M@TRM(M#CNE) <> 99999999)
083900130520     C                   EXSR      $CHKHEM
084000130520     C                   ENDIF
084100130520     C                   LEAVESR
084200130520     C                   ENDIF
084300130520    ***
084400130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
084500130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
084600130520     C                              L@TRM(L#CNE) <> 99999999 OR
084700130520     C                              M@TRM(M#CNE) <> 99999999)
084800130520     C                   EXSR      $CHKHEM
084900130520     C                   ENDIF
085000130520     C                   LEAVESR
085100130520     C                   ENDIF
085200101214    ***
085300101214     C                   ENDSR
085400101214   S***S
085500101210    *** GENERATE MEMBER RECORD
085600101210    ***
085700101210     C     $STEP4        BEGSR
085800101210    ***
085900130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
086000101214     C                   EVAL      @STEP = 'STEP2'
086100101214     C                   LEAVESR
086200101214     C                   ENDIF
086300101214    ***
086400110513     C                   EVAL      WRT@TYPE = 'MEMBER'
086500110725    ***
086600130315     C                   EVAL      L@MBREFF = 0
086700110725     C                   EVAL      D@MBREFF = 0
086800110725     C                   EVAL      M@MBREFF = 0
086900110513    ***
087000101210     C                   EVAL      @SS1   = %EDITC(MBSSNO:'X')
087100101210     C                   EVAL      @SS2   = @SS1
087200101210     C                   MOVEL(P)  MLNAME        @LN
087300101210     C                   MOVEL(P)  MFNAME        @FN
087400101210     C                   EVAL      @MI    = MMI
087500101210     C                   EVAL      @REL   = '01'
087600101210     C                   EVAL      @SEX   = SEX
087700101210     C                   EVAL      @DOB   = %EDITC(BIRTH:'X')
087800101210     C                   IF        COB = 'Y'
087900101210     C                   EVAL      @COB   = 'Y'
088000101210     C                   EVAL      @COBC  = 'OT'
088100101210     C                   EVAL      @COBN  = MCOBPN
088200101210     C                   ENDIF
088300101210     C                   EVAL      @AD1   = %TRIM(ADDR1)
088400101210     C                   EVAL      @AD2   = %TRIM(ADDR2)
088500101210     C                   EVAL      @CTY   = %TRIM(CITY)
088600101210     C                   EVAL      @ST    = STATE
088700101210     C                   MOVE      *BLANKS       @9                9
088800101210     C                   EVAL      @9   = %EDITC(ZIP:'X')
088900101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
089000101210     C                   EVAL      @PHN   = %EDITC(AREA:'X') +
089100101210     C                                      %EDITC(PHONE:'X')
089200101210    ***
089300101210     C                   SELECT
089400101210     C                   WHEN      EMPST = 'A'
089500101210     C                   EVAL      @EMPST = 'AC'
089600101210     C                   WHEN      EMPST = 'C'
089700101210     C                   EVAL      @EMPST = 'CO'
089800101210     C                   WHEN      EMPST = 'R'
089900101210     C                   EVAL      @EMPST = 'RT'
090000101210     C                   ENDSL
090100101210    ***
090200101210     C                   EVAL      @HIRE  = %EDITC(EMPDT:'X')
090300101210    ***
090400141211     C                   SETOFF                                       888987
090500141120        IF KF@TRS = 770 AND KF@SUB = 004 AND KF@ACC = 0037 AND
090600141120          STATE = 'VT';
090700141120           *IN89 = *ON;
090800141120        ENDIF;
090900141211    *** IF KF@TRS = 591 AND KF@SUB = 001 AND KF@ACC = 0042 AND
091000141211    ***   STATE = 'TX';
091100141211    ***    *IN87 = *ON;
091200141211    *** ENDIF;
091300141120    ***
091400101210     C                   EXCEPT    MBRF
091500101214     C                   ADD       1             C#RECCNT
091600101213    ***
091700101213     C                   EVAL      @STEP = 'PREP5'
091800101210    ***
091900101210     C                   ENDSR
092000101210   S***S
092100130315    *** * * * * * MEDICAL
092200101214     C     $PREP5        BEGSR
092300101214    ***
092400101214     C                   IF        M#CNE = 0
092500110513     C                   EVAL      @STEP = 'PREP6'
092600101214     C                   LEAVESR
092700101214     C                   ENDIF
092800101214    ***
092900101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
093000130315     C                   EVAL      KF@ENR = M@ENR(M#CNE)
093100101214    ***
093200101214     C                   IF        TERM_MED = YES
093300101214     C                   EXSR      $WRTERM
093400101214     C                   ENDIF
093500101214    ***
093600110512     C                   EVAL      @PLANIN = KF@PLN
093700120803    ***
093800120803     C     KL#TSAP       CHAIN     AEF01
093900120803     C                   IF        NOT %FOUND(AET001WF)
094000120803     C                   LEAVESR
094100120803     C                   ENDIF
094200120803    ***
094300111020     C                   EVAL      ENR@IN = M@ENR(M#CNE)
094400111020    ***
094500110802     C                   EXSR      $QUIK
094600110802    ***
094700110512     C                   EXSR      $PLANSRCH
094800110512    ***
094900110512     C                   IF        PLN@CAT = *BLANKS
095000101214     C                   SETON                                        H1
095100101214     C                   ENDIF
095200110512    ***
095300110513     C                   EVAL      @STEP = 'STEP5'
095400110725     C                   EVAL      #XSX = M@FRM(M#CNE)
095500110725     C                   EVAL      M@MBREFF = #XSX
095600101214    ***
095700101214     C                   ENDSR
095800101214   S***S
095900101214     C     $STEP5        BEGSR
096000101214    ***
096100110513     C                   IF        CPCID1 = 'MEA'
096200110513     C                   EXSR      $MEAWRT
096300110513     C                   ELSE
096400110513     C                   EXSR      $HMOWRT
096500110513     C                   ENDIF
096600110513    ***
096700101214     C                   ADD       1             C#RECCNT
096800101214     C                   ADD       1             B#RECCNT
096900110512    ***
097000110513     C                   EVAL      @STEP = 'PREP6'
097100110513    ***
097200110513     C                   ENDSR
097300110513   S***S
097400130315    *** DENTAL
097500130315    ***
097600101214     C     $PREP6        BEGSR
097700101213    ***
097800110513    *C                   IF        D#CNE = 0
097900130315    *C                   EVAL      @STEP = 'PREPC'
098000130315    *C*****************  EVAL      @STEP = 'PREP7'
098100110513    *C                   LEAVESR
098200110513    *C                   ENDIF
098300110512    ***
098400110513    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
098500130315    *C                   EVAL      KF@ENR = D@ENR(D#CNE)
098600130315    ***
098700120803     C     KL#TSAP       CHAIN     AEF01
098800120803     C                   IF        NOT %FOUND(AET001WF)
098900120803     C                   LEAVESR
099000120803     C                   ENDIF
099100110512    ***
099200110513    *C                   IF        TERM_DEN = YES
099300110513    *C                   EXSR      $WRTERM
099400110513    *C                   ENDIF
099500110513    ***
099600110513     C                   EVAL      @PLANIN = KF@PLN
099700111020     C                   EVAL      ENR@IN = D@ENR(D#CNE)
099800110513    ***
099900111011     C                   EXSR      $QUIK
100000110513    ***
100100110513     C                   EXSR      $PLANSRCH
100200110513    ***
100300110513     C                   IF        PLN@CAT = *BLANKS
100400110513     C                   SETON                                        H2
100500110513     C                   ENDIF
100600110512    ***
100700110513    *C                   EVAL      @STEP = 'STEP6'
100800110725     C                   EVAL      #XSX = D@FRM(D#CNE)
100900110725     C                   EVAL      D@MBREFF = #XSX
101000110512    ***
101100101213     C                   ENDSR
101200110802   S***S
101300110513    *** DENTAL FORMAT
101400110513    ***
101500110513    *C     $STEP6        BEGSR
101600110513    ***
101700110513     C                   EXSR      $DENWRT
101800110513    ***
101900110513    *C                   ADD       1             C#RECCNT
102000110513    *C                   ADD       1             B#RECCNT
102100110513    ***
102200130315    *C****************** EVAL      @STEP = 'PREP7'
102300130315    *C                   EVAL      @STEP = 'PREPC'
102400110513    ***
102500110513    *C                   ENDSR
102600110513   S***S
102700130315    *** LIFE AND AD&D PLANS FOR MEMBER
102800130315    ***
102900130315     C     $PREPC        BEGSR
103000130315    ***
103100130315    *C                   IF        L#CNE = 0
103200130315    *C                   EVAL      @STEP = 'PREP7'
103300130315    *C                   LEAVESR
103400130315    *C                   ENDIF
103500130315    ***
103600130315    *C                   EVAL      KF#TRM = L@TRM(L#CNE)
103700130315    *C                   EVAL      KF@PLN = L@PLN(L#CNE)
103800130315     C                   EVAL      KF@ENR = L@ENR(L#CNE)
103900130315    ***
104000130315     C     KL#TSAP       CHAIN     AEF01
104100130315     C                   IF        NOT %FOUND(AET001WF)
104200130315     C                   LEAVESR
104300130315     C                   ENDIF
104400130315    ***
104500130315    *C                   IF        TERM_LIF = YES
104600130315    *C                   EXSR      $WRTERM
104700130315    *C                   ENDIF
104800130315    ***
104900130315     C                   EVAL      @PLANIN = KF@PLN
105000130315     C                   EVAL      ENR@IN = L@ENR(L#CNE)
105100130315    ***
105200130315     C                   EXSR      $QUIK
105300130315    ***
105400130315     C                   EXSR      $PLANSRCH
105500130315    ***
105600130315     C                   IF        PLN@CAT = *BLANKS
105700130315     C                   SETON                                        H2
105800130315     C                   ENDIF
105900130315    ***
106000130315    *C                   EVAL      @STEP = 'STEPC'
106100130315     C                   EVAL      #XSX = L@FRM(L#CNE)
106200130315     C                   EVAL      L@MBREFF = #XSX
106300130315    ***
106400130315     C                   ENDSR
106500130315   S***S
106600130315    *** LIFE FORMAT
106700130315    ***
106800130315    *C     $STEPC        BEGSR
106900130315    ***
107000130315     C                   EXSR      $LIFWRT
107100130315    ***
107200130315    *C                   ADD       1             C#RECCNT
107300130315    *C                   ADD       1             B#RECCNT
107400130315    ***
107500130315    *C                   EVAL      @STEP = 'PREP7'
107600130315    ***
107700130315    *C                   ENDSR
107800130315   S***S
107900130315     C     $LIFWRT       BEGSR
108000130315    ***
108100130315    *C                   EVAL      X@LAY = CPCID1                               LAYOUT
108200130315    *C                   EVAL      X@ELR = CPCID2                               ELR
108300130315    *C                   EVAL      L@SFX = CPCID3                               SUFFIX
108400130315    *C                   EVAL      L@ACCT = CPCID4                              ACCOUNT
108500130315    *C                   EVAL      L@PLAN = CPCID5                              PLAN
108600130315    *C                   EVAL      L@CLM = CPCID6                               CLAIM OFFICE
108700130315    ***
108800130315    *C                   EVAL      #XSX = L@FRM(L#CNE)
108900130315     C                   MOVE      #XSX          X@EFF
109000130315    ***
109100130315    *C                   EVAL      #XSX = L@TRM(L#CNE)
109200130315    *C                   IF        #XSX = 0 OR #XSX = 99999999
109300130315    *C                   MOVE      *BLANKS       X@TRM
109400130315    *C                   ELSE
109500130315    *C                   MOVE      #XSX          X@TRM
109600130315    *C                   ENDIF
109700140313    ***
109800140313     C                   MOVE      *BLANKS       L@CBREXP
109900140313     C                   MOVE      *BLANKS       L@CBREVT
110000140313     C                   MOVE      *BLANKS       L@CBRLEN
110100130315    ***
110200130923    *C                   IF        EMPST = 'C' AND
110300130923     C                             CEXPDT > 0
110400130315    *C                   MOVE      CEXPDT        L@CBREXP
110500130315    *C                   MOVE      QEDT          L@CBREVT
110600130315    *C                   MOVE      CEXPDT        #MINUEND
110700130315    *C                   MOVE      QEDT          #SUBTRAEND
110800130315    *C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
110900130315    *C                   Z-ADD     #DIFFRNC      #2S0
111000130315    *C                   MOVE      #2S0          L@CBRLEN
111100130315    *C                   ENDIF
111200130315    ***
111300130315     C                   EVAL      L@SALARY = %EDITC(SALARY:'4')
111400130315    ***
111500130315    *C                   EXCEPT    LIFF
111600130315    ***
111700130315    *C                   ENDSR
111800130315   S***S
111900101214     C     $PREP7        BEGSR
112000101214    ***
112100101214     C     KF@SSN        CHAIN     DEPENR
112200101214     C                   IF        NOT %FOUND(DEPNDC)
112300101214     C                   EVAL      @STEP = 'STEP2'
112400101214     C                   LEAVESR
112500101214     C                   ENDIF
112600101214    ***
112700101214     C     KF@SSN        SETLL     DEPENR
112800101214    ***
112900101214     C                   EVAL      @STEP = 'STEP7'
113000101214    ***
113100101214     C                   ENDSR
113200101210   S***S
113300101214     C     $STEP7        BEGSR
113400101214    ***
113500101214     C     KF@SSN        READE     DEPENR
113600101214    ***
113700101214     C                   IF        %EOF(DEPNDC)
113800101214     C                   EVAL      @STEP = 'STEP2'
113900101214     C                   LEAVESR
114000101214     C                   ENDIF
114100101214    ***
114200101214     C                   EVAL      KF@SEQ = DPSEQ#
114300120803     C                   EVAL      WRT@TYPE = 'DEPEND'
114400101214    ***
114500101214     C     KL#DCV        CHAIN     DCOVR
114600101214     C                   IF        NOT %FOUND(DCOVA)
114700101214     C                   LEAVESR
114800101214     C                   ENDIF
114900101214    ***
115000101214     C                   EXSR      $CLRDCV
115100101214     C     KL#DCV        SETLL     DCOVR
115200101214    ***
115300101214     C                   EVAL      @STEP = 'STEP8'
115400101214    ***
115500101214     C                   ENDSR
115600101214   S***S
115700101214     C     $STEP8        BEGSR
115800101214    ***
115900101214     C     KL#DCV        READE     DCOVR
116000101214    ***
116100101214     C                   IF        %EOF(DCOVA)
116200101214     C                   EVAL      @STEP = 'PREP9'
116300101214     C                   LEAVESR
116400101214     C                   ENDIF
116500101214    ***
116600130131    *C*                  IF        DENRDT = CCANDT
116700130131    *C*                  LEAVESR
116800130131    *C*                  ENDIF
116900110513    ***
117000110513     C                   EVAL      @PLANIN = DVPLAN
117100120803     C                   EVAL      KF@PLN = DVPLAN
117200120803     C     KL#TSAP       CHAIN     AEF01
117300120803     C                   IF        NOT %FOUND(AET001WF)
117400120803     C                   LEAVESR
117500120803     C                   ENDIF
117600110802    ***
117700110802     C                   EXSR      $QUIKD
117800110802    ***
117900110513     C                   EXSR      $PLANSRCH
118000110513    ***
118100110513     C                   IF        PLN@CAT = *BLANKS
118200110513     C                   LEAVESR
118300110513     C                   ENDIF
118400101214    ***
118500101214     C                   EVAL      #CANCEL = CCANDT
118600101214     C                   IF        #CANCEL = 0
118700101214     C                   EVAL      #CANCEL = 99999999
118800101214     C                   ENDIF
118900101214    ***
119000130315    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL; LIFE IS MEMBER ONLY
119100110513    ***
119200110513    *C                   IF        PLN@CAT = 'DEN'
119300130131    *C                   IF        D#CNE > 0
119400130131    *C                   IF        D@TRM(D#CNE) = 99999999
119500130131     C                   LEAVESR
119600130131     C                   ENDIF
119700130131     C                   ENDIF
119800110513    *C                   ADD       1             D#CNE
119900110513    *C                   EVAL      D@PLN(D#CNE) = DVPLAN
120000110513    *C                   EVAL      D@ENR(D#CNE) = *BLANKS
120100110513    *C                   EVAL      D@FRM(D#CNE) = DENRDT
120200110513    *C                   EVAL      D@TRM(D#CNE) = #CANCEL
120300110513    *C                   ELSE
120400130131    *C                   IF        M#CNE > 0
120500130131    *C                   IF        M@TRM(M#CNE) = 99999999
120600130131     C                   LEAVESR
120700130131     C                   ENDIF
120800130131     C                   ENDIF
120900101214     C                   ADD       1             M#CNE
121000101214     C                   EVAL      M@PLN(M#CNE) = DVPLAN
121100101214     C                   EVAL      M@ENR(M#CNE) = *BLANKS
121200101214     C                   EVAL      M@FRM(M#CNE) = DENRDT
121300101214     C                   EVAL      M@TRM(M#CNE) = #CANCEL
121400110513    *C                   ENDIF
121500101214    ***
121600101214     C                   ENDSR
121700101214   S***S
121800111011     C     $QUIKD        BEGSR
121900111011    ***
122000120803     C                   EXSR      $QUIK
122100120409    ***
122200120409     C                   ENDSR
122300111011   S***S
122400101214     C     $PREP9        BEGSR
122500101214    ***
122600101214     C                   IF        D#CNE = 0 AND M#CNE = 0
122700101214     C                   EVAL      @STEP = 'STEP7'
122800101214     C                   LEAVESR
122900101214     C                   ENDIF
123000101214    ***
123100130315     C                   EVAL      L#CNE = 0
123200130315     C                   EVAL      TERM_LIF = NO
123300101214     C                   EVAL      TERM_DEN = NO
123400101214     C                   EVAL      TERM_MED = NO
123500130520     C                   EVAL      @STEP = 'STEP9'
123600101214    ***
123700130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
123800130520     C                   IF        L@TRM(L#CNE) <> 99999999
123900130520     C                   EXSR      $CHKHEM
124000130520     C                   ENDIF
124100130520     C                   LEAVESR
124200130520     C                   ENDIF
124300130520    ***
124400130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
124500130520     C                   IF        M@TRM(M#CNE) <> 99999999
124600130520     C                   EXSR      $CHKHEM
124700130520     C                   ENDIF
124800130520     C                   LEAVESR
124900130520     C                   ENDIF
125000130520    ***
125100130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
125200130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
125300130520     C                              M@TRM(M#CNE) <> 99999999)
125400130520     C                   EXSR      $CHKHEM
125500130520     C                   ENDIF
125600130520     C                   LEAVESR
125700130520     C                   ENDIF
125800130520    ***
125900130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
126000130520     C                   IF        D@TRM(D#CNE) <> 99999999
126100130520     C                   EXSR      $CHKHEM
126200130520     C                   ENDIF
126300130520     C                   LEAVESR
126400130520     C                   ENDIF
126500130520    ***
126600130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
126700130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
126800130520     C                              D@TRM(D#CNE) <> 99999999)
126900130520     C                   EXSR      $CHKHEM
127000130520     C                   ENDIF
127100130520     C                   LEAVESR
127200130520     C                   ENDIF
127300130520    ***
127400130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
127500130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
127600130520     C                              M@TRM(M#CNE) <> 99999999)
127700130520     C                   EXSR      $CHKHEM
127800130520     C                   ENDIF
127900130520     C                   LEAVESR
128000130520     C                   ENDIF
128100130520    ***
128200130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
128300130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
128400130520     C                              L@TRM(L#CNE) <> 99999999 OR
128500130520     C                              M@TRM(M#CNE) <> 99999999)
128600130520     C                   EXSR      $CHKHEM
128700130520     C                   ENDIF
128800130520     C                   LEAVESR
128900130520     C                   ENDIF
129000101214    ***
129100101214     C                   ENDSR
129200101214   S***S
129300101210    *** GENERATE DEPENDENT RECORD
129400101210    ***
129500101214     C     $STEP9        BEGSR
129600101210    ***
129700110513     C                   EVAL      WRT@TYPE = 'DEPEND'
129800110513    ***
129900110513     C                   IF        D#CNE = 0 AND M#CNE = 0
130000110513     C                   EVAL      @STEP = 'STEP7'
130100110513     C                   LEAVESR
130200110513     C                   ENDIF
130300110513    ***
130400101214     C                   EVAL      @SS2   = %EDITC(DEPSS#:'X')
130500101210     C                   MOVEL(P)  DLNAME        @LN
130600101210     C                   MOVEL(P)  DFNAME        @FN
130700101210     C                   EVAL      @MI    = DMI
130800101210    ***
130900101210     C                   SELECT
131000101210     C                   WHEN      DRELCD = 'RWI'
131100101210     C                   EVAL      @REL   = '02'
131200101210     C                   WHEN      DRELCD = 'RHU'
131300101210     C                   EVAL      @REL   = '03'
131400101210     C                   WHEN      DRELCD = 'RSO'
131500101210     C                   EVAL      @REL   = '04'
131600101210     C                   WHEN      DRELCD = 'RDA'
131700101210     C                   EVAL      @REL   = '05'
131800130218     C                   WHEN      DRELCD = 'RPA'
131900130218     C                   EVAL      @REL   = '14'
132000130225     C                   OTHER
132100130225     C                   EVAL      @REL   = *BLANKS
132200101210     C                   ENDSL
132300101210    ***
132400101210     C                   SELECT
132500101210     C                   WHEN      DSTUDN = 'Y'
132600101210     C                   EVAL      @SPEC = '1'
132700140812     C                   WHEN      DHNDCP = '3'
132800101210     C                   EVAL      @SPEC = '3'
132900130225     C                   OTHER
133000130225     C                   EVAL      @SPEC = *BLANKS
133100101210     C                   ENDSL
133200101210    ***
133300101210     C                   EVAL      @SEX   = DSEX
133400101210     C                   EVAL      @DOB   = %EDITC(DBIRTH:'X')
133500130225    ***
133600101210     C                   IF        DCOB = 'Y'
133700101210     C                   EVAL      @COB   = 'Y'
133800101210     C                   EVAL      @COBC  = 'OT'
133900101210     C                   EVAL      @COBN  = DCOBPN
134000130225     C                   ELSE
134100130225     C                   EVAL      @COB   = *BLANKS
134200130225     C                   EVAL      @COBC  = *BLANKS
134300130225     C                   EVAL      @COBN = *BLANKS
134400101210     C                   ENDIF
134500101214    ***
134600101214     C                   IF        DADDR1 <> ADDR1
134700101210     C                   EVAL      @AD1   = %TRIM(DADDR1)
134800101210     C                   EVAL      @AD2   = %TRIM(DADDR2)
134900101210     C                   EVAL      @CTY   = %TRIM(DCITY)
135000101210     C                   EVAL      @ST    = DSTATE
135100101210     C                   MOVE      *BLANKS       @9                9
135200101214     C                   IF        DZIP = 0
135300101214     C                   EVAL      @9   = %EDITC(ZIP:'X')
135400101214     C                   ELSE
135500101210     C                   EVAL      @9   = %EDITC(DZIP:'X')
135600101214     C                   ENDIF
135700101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
135800101210     C                   EVAL      @PHN   = %EDITC(DAREA:'X') +
135900101210     C                                      %EDITC(DPHONE:'X')
136000101214     C                   ENDIF
136100141120    ***
136200101210     C                   EXCEPT    MBRF
136300101214     C                   ADD       1             C#RECCNT
136400101214    ***
136500101214     C                   EVAL      @STEP = 'PREPA'
136600101210    ***
136700101210     C                   ENDSR
136800101210   S***S
136900101214     C     $PREPA        BEGSR
137000101214    ***
137100101214     C                   IF        M#CNE = 0
137200101214     C                   EVAL      @STEP = 'PREPB'
137300101214     C                   LEAVESR
137400101214     C                   ENDIF
137500101214    ***
137600101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
137700120803     C     KL#TSAP       CHAIN     AEF01
137800120803     C                   IF        NOT %FOUND(AET001WF)
137900120803     C                   LEAVESR
138000120803     C                   ENDIF
138100101214    ***
138200101214     C                   IF        TERM_MED = YES
138300101214     C                   EXSR      $WRTERM
138400101214     C                   ENDIF
138500101214    ***
138600110513     C                   EVAL      @PLANIN = KF@PLN
138700110802    ***
138800110802     C                   EXSR      $QUIKD
138900110802    ***
139000110513     C                   EXSR      $PLANSRCH
139100110513    ***
139200110513     C                   IF        PLN@CAT = *BLANKS
139300110513     C                   SETON                                        H2
139400110513     C                   ENDIF
139500110513    ***
139600110513     C                   EVAL      @STEP = 'STEPA'
139700110513    ***
139800101214     C                   ENDSR
139900101214   S***S
140000101214     C     $STEPA        BEGSR
140100101214    ***
140200110513     C                   IF        CPCID1 = 'MEA'
140300110513     C                   EXSR      $MEAWRT
140400110513     C                   ELSE
140500110513     C                   EXSR      $HMOWRT
140600110513     C                   ENDIF
140700110513    ***
140800110513     C                   ADD       1             C#RECCNT
140900110513     C                   ADD       1             B#RECCNT
141000110513    ***
141100110513     C                   EVAL      @STEP = 'PREPB'
141200110513    ***
141300110513     C                   ENDSR
141400110513   S***S
141500101214     C     $PREPB        BEGSR
141600101214    ***
141700110513    *C                   IF        D#CNE = 0
141800110513    *C                   EVAL      @STEP = 'STEP7'
141900110513    *C                   LEAVESR
142000110513    *C                   ENDIF
142100101214    ***
142200110513    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
142300120803     C     KL#TSAP       CHAIN     AEF01
142400120803     C                   IF        NOT %FOUND(AET001WF)
142500120803     C                   LEAVESR
142600120803     C                   ENDIF
142700110513    ***
142800110513    *C                   IF        TERM_DEN = YES
142900110513    *C                   EXSR      $WRTERM
143000110513    *C                   ENDIF
143100110513    ***
143200110513     C                   EVAL      @PLANIN = KF@PLN
143300110513    ***
143400110802     C                   EXSR      $QUIKD
143500110513    ***
143600110513     C                   EXSR      $PLANSRCH
143700110513    ***
143800110513     C                   IF        PLN@CAT = *BLANKS
143900110513     C                   SETON                                        H2
144000110513     C                   ENDIF
144100110513    ***
144200101214     C                   EVAL      @STEP = 'STEPB'
144300101214    ***
144400101214     C                   ENDSR
144500101214   S***S
144600110513    *C     $STEPB        BEGSR
144700110513    ***
144800110513     C                   EXSR      $DENWRT
144900110513    ***
145000110513    *C                   ADD       1             C#RECCNT
145100110513    *C                   ADD       1             B#RECCNT
145200110513    ***
145300110513    *C                   EVAL      @STEP = 'STEP7'
145400110513    ***
145500110513    *C                   ENDSR
145600101210   S***S
145700110512     C     *INZSR        BEGSR
145800110512    ***
145900110512     C     KL#ACCTL      KLIST
146000120803     C                   KFLD                    KF@CCTL
146100110512     C                   KFLD                    KF@TRS
146200110512     C                   KFLD                    KF@SUB
146300110512     C                   KFLD                    KF@ACC
146400140313    ***
146500140313     C     KL#SQPCD      KLIST
146600140313     C                   KFLD                    KF@SSN
146700140313     C                   KFLD                    KF@SEQ
146800140313     C                   KFLD                    KF@SPCD
146900120803    ***
147000120803     C     KL#TSAP       KLIST
147100120803     C                   KFLD                    KF@TRS
147200120803     C                   KFLD                    KF@SUB
147300120803     C                   KFLD                    KF@ACC
147400120803     C                   KFLD                    KF@PLN
147500110512    ***
147600110512     C     KL#TSA        KLIST
147700110512     C                   KFLD                    KF@TRS
147800110512     C                   KFLD                    KF@SUB
147900110512     C                   KFLD                    KF@ACC
148000110512    ***
148100110512     C     KL#MPLN       KLIST
148200110512     C                   KFLD                    KF@SSN
148300110512     C                   KFLD                    KF@SEQ
148400110512     C                   KFLD                    KF@TRS
148500110512     C                   KFLD                    KF@SUB
148600110512     C                   KFLD                    KF@ACC
148700110512    ***
148800110512     C     KL#CPLN       KLIST
148900120803     C                   KFLD                    KF@CCTL
149000110512     C                   KFLD                    KF@TRS
149100110512     C                   KFLD                    KF@SUB
149200110512     C                   KFLD                    KF@ACC
149300110512     C                   KFLD                    KF@CCTR
149400110512     C                   KFLD                    KF@PLN
149500110512    ***
149600110512     C     KL#DCV        KLIST
149700110512     C                   KFLD                    KF@SSN
149800110512     C                   KFLD                    KF@SEQ
149900110512    ***
150000110512     C     KL#MTR        KLIST
150100110512     C                   KFLD                    KF@SSN
150200110512     C                   KFLD                    KF@SEQ
150300110512     C                   KFLD                    KF#TRM
150400110512     C                   KFLD                    KF@PLN
150500110512     C                   KFLD                    KF@ENR
150600110512     C                   KFLD                    KF@TRS
150700110512     C                   KFLD                    KF@SUB
150800110512     C                   KFLD                    KF@ACC
150900110512    ***
151000110512     C     KL#PCP        KLIST
151100110512     C                   KFLD                    KF@SSN
151200110512     C                   KFLD                    KF@SEQ
151300110512    ***
151400110512     C                   EVAL      #ISO = %DATE
151500110512     C                   MOVE      #ISO          #TODAY            8 0
151600110512     C                   EVAL      #IST = %TIME
151700110512     C                   MOVE      #ISO          #XSX
151800110512     C                   MOVE      #XSX          @DATE
151900110512     C                   MOVE      #IST          #XST
152000110512     C                   MOVE      #XST          @TIME
152100110512    ***
152200110512     C                   ENDSR
152300110512   S***S
152400110513    *** PLANS LOADED BY ACCOUNT
152500110513    ***
152600110513     C     $PLANLOAD     BEGSR
152700110513    ***
152800110513     C                   EVAL      PP# = 0
152900140313     C                   DO        80
153000110513     C                   ADD       1             PP#
153100110513     C     PP#           OCCUR     CARPLN@
153200110513     C                   CLEAR                   CARPLN@
153300110513     C                   ENDDO
153400110513     C                   EVAL      PC# = 0
153500110513     C                   EVAL      PP# = 0
153600110513    ***
153700110513     C     KL#ACCTL      SETLL     CARPLNR
153800110513     C                   DOU       %EOF(CARPLNP)
153900110513     C     KL#ACCTL      READE     CARPLNR
154000110520     C                   IF        NOT %EOF(CARPLNP)
154100110513    ***
154200110513     C                   ADD       1             PC#
154300110513     C     PC#           OCCUR     CARPLN@
154400110513     C                   EVAL      CARPLN@ = DS@CARPLN
154500110513    ***
154600110513     C                   ENDIF
154700110513     C                   ENDDO
154800110513    ***
154900110513     C                   ENDSR
155000110513   S***S
155100110513     C     $CLRSTG       BEGSR
155200110513    ***
155300110513     C                   EVAL      #CANCEL = 0
155400130315    ***
155500130315     C                   EVAL      L#CNE = 0
155600130315     C                   CLEAR                   L@PLN
155700130315     C                   CLEAR                   L@ENR
155800130315     C                   CLEAR                   L@FRM
155900130315     C                   CLEAR                   L@TRM
156000130315    ***
156100110513     C                   EVAL      D#CNE = 0
156200110513     C                   CLEAR                   D@PLN
156300110513     C                   CLEAR                   D@ENR
156400110513     C                   CLEAR                   D@FRM
156500110513     C                   CLEAR                   D@TRM
156600110513     C                   EVAL      M#CNE = 0
156700110513     C                   CLEAR                   M@PLN
156800110513     C                   CLEAR                   M@ENR
156900110513     C                   CLEAR                   M@FRM
157000110513     C                   CLEAR                   M@TRM
157100110513    ***
157200110513     C                   EXSR      $CLRDMG
157300110513    ***
157400110513     C                   ENDSR
157500110513   S***S
157600110513     C     $CLRDMG       BEGSR
157700110513    ***
157800110513     C                   EVAL      @SS1   = *BLANKS
157900110513     C                   EVAL      @SS2   = *BLANKS
158000110513     C                   MOVE      *BLANKS       @LN
158100110513     C                   MOVEL     *BLANKS       @FN
158200110513     C                   EVAL      @MI    = *BLANKS
158300110513     C                   EVAL      @REL   = *BLANKS
158400110513     C                   EVAL      @SEX   = *BLANKS
158500110513     C                   EVAL      @DOB   = *BLANKS
158600110513     C                   EVAL      @SPEC  = *BLANKS
158700110513     C                   EVAL      @COB   = *BLANKS
158800110513     C                   EVAL      @COBC  = *BLANKS
158900110513     C                   EVAL      @COBN  = *BLANKS
159000110513     C                   EVAL      @AD1   = *BLANKS
159100110513     C                   EVAL      @AD2   = *BLANKS
159200110513     C                   EVAL      @CTY   = *BLANKS
159300110513     C                   EVAL      @ST    = *BLANKS
159400110513     C                   EVAL      @ZP5   = *BLANKS
159500110513     C                   EVAL      @PHN   = *BLANKS
159600110513     C                   EVAL      @EMPST = *BLANKS
159700110513     C                   EVAL      @HIRE  = *BLANKS
159800110513    ***
159900110513     C                   ENDSR
160000110513   S***S
160100110513     C     $CHKHEM       BEGSR
160200110513    ***
160300130315    *C                   IF        L#CNE > 0 AND L@TRM(L#CNE) <> 99999999
160400130315    *C                   EXSR      $CHKLIF
160500130315    *C                   ENDIF
160600130315      *
160700110513    *C                   IF        D#CNE > 0 AND D@TRM(D#CNE) <> 99999999
160800110513    *C                   EXSR      $CHKDEN
160900110513    *C                   ENDIF
161000110513      *
161100110513     C                   IF        M#CNE > 0 AND M@TRM(M#CNE) <> 99999999
161200110513     C                   EXSR      $CHKMED
161300110513     C                   ENDIF
161400110513    ***
161500110513     C                   ENDSR
161600110513   S***S
161700130315    *C     $CHKLIF       BEGSR
161800130315    ***
161900130315    *C                   EVAL      TERM_LIF = YES
162000130315    *C                   EVAL      KF#TRM = L@TRM(L#CNE)
162100130315    *C                   EVAL      KF@PLN = L@PLN(L#CNE)
162200130315    *C                   EVAL      KF@ENR = L@ENR(L#CNE)
162300130315    ***
162400130315    *C     KL#MTR        CHAIN     AET081F
162500130315    *C                   IF        %FOUND(AET081WF)
162600130315    *C                   EVAL      L#CNE = 0
162700130315    *C                   EVAL      TERM_LIF = NO
162800130315    *C                   ENDIF
162900130315    ***
163000130315    *C                   ENDSR
163100130315   S***S
163200110513    *C     $CHKDEN       BEGSR
163300110513    ***
163400110513    *C                   EVAL      TERM_DEN = YES
163500110513    *C                   EVAL      KF#TRM = D@TRM(D#CNE)
163600110513    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
163700110513    *C                   EVAL      KF@ENR = D@ENR(D#CNE)
163800110513    ***
163900110802    *C     KL#MTR        CHAIN     AET081F
164000110802    *C                   IF        %FOUND(AET081WF)
164100110513    *C                   EVAL      D#CNE = 0
164200110513    *C                   EVAL      TERM_DEN = NO
164300110513    *C                   ENDIF
164400110513    ***
164500110513    *C                   ENDSR
164600110513   S***S
164700110513     C     $CHKMED       BEGSR
164800110513    ***
164900110513     C                   EVAL      TERM_MED = YES
165000110513     C                   EVAL      KF#TRM = M@TRM(M#CNE)
165100110513     C                   EVAL      KF@PLN = M@PLN(M#CNE)
165200110513     C                   EVAL      KF@ENR = M@ENR(M#CNE)
165300110513      *
165400110802     C     KL#MTR        CHAIN     AET081F
165500110802     C                   IF        %FOUND(AET081WF)
165600110513     C                   EVAL      TERM_MED = NO
165700110513     C                   EVAL      M#CNE = 0
165800110513     C                   ENDIF
165900110513    ***
166000110513     C                   ENDSR
166100110513   S***S
166200110513     C     $PLANSRCH     BEGSR
166300110513    ***
166400130315     C                   MOVE      *BLANKS       PLN@CAT           5
166500110513     C                   EVAL      PP# = 0
166600110513     C                   CLEAR                   DS@CARPLN
166700110513    ***
166800110513     C                   DO        PC#
166900110513    * *
167000110513     C                   ADD       1             PP#
167100110513     C     PP#           OCCUR     CARPLN@
167200110513    * *
167300110513     C                   IF        XPPLAN = @PLANIN AND
167400110513     C                             XPCCTR = @CCTRIN
167500110513     C                   EVAL      DS@CARPLN = CARPLN@
167600110513     C                   LEAVE
167700110513     C                   ENDIF
167800110513    * *
167900110513     C                   ENDDO
168000110513    ***
168100110513     C                   IF        CPPLAN = *BLANKS
168200110513     C                   LEAVESR
168300110513     C                   ENDIF
168400110513    ***
168500110513     C                   SELECT
168600110520     C                   WHEN      CPCID1 = 'MEA' OR
168700110520     C                             CPCID1 = 'HMO'
168800110520     C                   EVAL      PLN@CAT = 'MED'
168900130409     C                   WHEN      CPCID1 = 'LIFE'
169000130409     C                   EVAL      PLN@CAT = 'LIFE'
169100110520     C                   WHEN      CPCID1 = 'DEN'
169200110520     C                   EVAL      PLN@CAT = 'DEN'
169300110513     C                   ENDSL
169400110513    ***
169500110513     C                   ENDSR
169600110513   S***S
169700110513     C     $ENROLL       BEGSR
169800110513    ***
169900110513     C                   EVAL      ENR@OUT = *BLANKS
170000110513     C                   SELECT
170100110513     C                   WHEN      ENR@IN = 'TIN' OR ENR@IN = 'TMI'
170200110513     C                   EVAL      ENR@OUT = 'S'
170300110513     C                   WHEN      ENR@IN = 'THW'
170400110513     C                   EVAL      ENR@OUT = 'C'
170500110513     C                   WHEN      ENR@IN = 'TPC'
170600110513     C                   EVAL      ENR@OUT = 'P'
170700110513     C                   WHEN      ENR@IN = 'TP2'
170800110513     C                   EVAL      ENR@OUT = 'Q'
170900110513     C                   WHEN      ENR@IN = 'TFA'
171000110513     C                   EVAL      ENR@OUT = 'F'
171100110513     C                   ENDSL
171200110513    ***
171300110513     C                   ENDSR
171400110513   S***S
171500110513     C     $WRTERM       BEGSR
171600110513    ***
171700110802     C                   CLEAR                   AET081F
171800110513     C                   EVAL      NTSSNO         = KF@SSN
171900110513     C                   EVAL      NTDEPNO        = KF@SEQ
172000110513     C                   EVAL      NTTERMDT       = KF#TRM
172100110513     C                   EVAL      NTPLAN         = KF@PLN
172200110513     C                   EVAL      NTCOVTP        = KF@ENR
172300110513     C                   EVAL      NTTRST         = KF@TRS
172400110513     C                   EVAL      NTSUB#         = KF@SUB
172500110513     C                   EVAL      NTACCT         = KF@ACC
172600110513     C                   EVAL      NTTRANSDT      = #TODAY
172700110802     C                   WRITE     AET081F
172800110513    ***
172900110513     C                   ENDSR
173000110513   S***S
173100110513     C     $HMOWRT       BEGSR
173200110513    ***
173300110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
173400110513     C                   EVAL      X@ELR = CPCID2                               FILE NUMBER
173500110513     C                   EVAL      M@CC = CACID2                                COMPANY CODE
173600110513     C                   EVAL      M@CLASS = CPCID3                             CLASS CODE
173700110513     C                   EVAL      M@PLAN = CPCID4                              PLAN NUMBER
173800110513    ***
173900110513     C                   EVAL      #XSX = M@FRM(M#CNE)
174000110725     C                   IF        WRT@TYPE = 'DEPEND' AND
174100110725     C                             #XSX < M@MBREFF
174200110725     C                   MOVE      M@MBREFF      X@EFF
174300110725     C                   ELSE
174400110725     C                   MOVE      #XSX          X@EFF
174500110725     C                   ENDIF
174600110513    ***
174700110513     C                   EVAL      #XSX = M@TRM(M#CNE)
174800110513     C                   IF        #XSX = 0 OR #XSX = 99999999
174900110513     C                   MOVE      *BLANKS       X@TRM
175000110513     C                   ELSE
175100110513     C                   MOVE      #XSX          X@TRM
175200110513     C                   ENDIF
175300110513    ***
175400110513     C                   IF        WRT@TYPE = 'MEMBER'
175500110513     C                   EVAL      KF@SEQ = 0
175600110513     C                   EVAL      ENR@IN = M@ENR(M#CNE)
175700110513     C                   EXSR      $ENROLL
175800110513     C                   EVAL      X@TIER = ENR@OUT
175900110513     C                   ELSE
176000110513     C                   EVAL      X@TIER = *BLANKS
176100110513     C                   ENDIF
176200110513    ***
176300140313     C                   EVAL      KF@SPCD = 'MED'
176400140313     C                   EVAL      M@PCP = *BLANKS
176500140313     C                   EVAL      M@NPI = *BLANKS
176600140313     C                   EVAL      M@PCPCI = *BLANKS
176700140313    ***
176800140313     C                   EXSR      $PCP
176900140313    ***
177000140313     C                   IF        DOCTOR <> *BLANKS
177100140313     C                   EVAL      M@PCP = DOCTOR
177200140313     C                   EVAL      M@NPI = 'Y'
177300140313     C                   EVAL      M@PCPCI = '0'
177400140313     C                   ENDIF
177500110513    ***
177600110513     C                   EXCEPT    HMOF
177700110513    ***
177800110513     C                   ENDSR
177900110513   S***S
178000110513     C     $MEAWRT       BEGSR
178100110513    ***
178200110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
178300110513     C                   EVAL      X@ELR = CPCID2                               ELR
178400140313     C                   EVAL      E@SFX = CPCID3                               SUFFIX
178500140313     C                   EVAL      E@ACCT = CPCID4                              ACCOUNT
178600140313     C                   EVAL      E@PLAN = CPCID5                              PLAN
178700140313     C                   EVAL      E@CLM = CPCID6                               CLAIM OFFICE
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
180100110513     C                   MOVE      #XSX          X@TRM
180200110513     C                   ENDIF
180300110513    ***
180400140313     C                   MOVE      *BLANKS       E@CBREXP
180500140313     C                   MOVE      *BLANKS       E@CBREVT
180600140313     C                   MOVE      *BLANKS       E@CBRLEN
180700140313     C                   IF        WRT@TYPE = 'MEMBER'
180800140425     C                   IF        EMPST = 'C' AND
180900140425     C                             CEXPDT > 0
181000140313     C                   MOVE      CEXPDT        E@CBREXP
181100140313     C                   MOVE      QEDT          E@CBREVT
181200140313     C                   MOVE      CEXPDT        #MINUEND
181300140313     C                   MOVE      QEDT          #SUBTRAEND
181400140313     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
181500140313     C                   Z-ADD     #DIFFRNC      #2S0
181600140313     C                   MOVE      #2S0          E@CBRLEN
181700140313     C                   ENDIF
181800140313     C                   ENDIF
181900140313    ***
182000140313     C                   EVAL      *IN80 = *OFF
182100140313     C                   EVAL      KF@SPCD = 'MED'
182200140313     C                   EVAL      E@PCP = *BLANKS
182300140313     C                   EXSR      $PCP
182400140313     C                   IF        DOCTOR <> *BLANKS
182500140313     C                   EVAL      E@PCP = DOCTOR
182600140313     C                   EVAL      *IN80 = *ON
182700140313     C                   ENDIF
182800140313    ***
182900140313     C                   EXCEPT    MEAF
183000110513    ***
183100110513     C                   ENDSR
183200110513   S***S
183300140313     C     $PCP          BEGSR
183400140313    ***
183500140313     C                   MOVE      *BLANKS       DOCTOR            7
183600140313     C     KL#SQPCD      CHAIN     PCPR
183700140313     C                   IF        NOT %FOUND(PCPL1)
183800140313     C                   LEAVESR
183900140313     C                   ENDIF
184000140313     C     KL#SQPCD      SETLL     PCPR
184100140313     C                   DOU       %EOF(PCPL1)
184200140313     C     KL#SQPCD      READE     PCPR
184300140313     C                   IF        NOT %EOF(PCPL1) AND PCCAN = 0
184400140313     C                   MOVEL(P)  PCID#         DOCTOR
184500140313     C                   LEAVESR
184600140313     C                   ENDIF
184700140313     C                   ENDDO
184800140313    ***
184900140313     C                   ENDSR
185000140313   S***S
185100110513     C     $CLRDCV       BEGSR
185200110513    ***
185300110513     C                   MOVE      *BLANKS       @LN
185400110513     C                   MOVEL     *BLANKS       @FN
185500110513     C                   EVAL      @SS2   = *BLANKS
185600110513     C                   EVAL      @MI    = *BLANKS
185700110513     C                   EVAL      @REL   = *BLANKS
185800110513     C                   EVAL      @SEX   = *BLANKS
185900110513     C                   EVAL      @DOB   = *BLANKS
186000110513     C                   EVAL      @SPEC  = *BLANKS
186100110513     C                   EVAL      @COB   = *BLANKS
186200110513     C                   EVAL      @COBC  = *BLANKS
186300110513     C                   EVAL      @COBN  = *BLANKS
186400110513    ***
186500110513     C                   EVAL      #CANCEL = 0
186600110513     C                   EVAL      D#CNE = 0
186700110513     C                   CLEAR                   D@PLN
186800110513     C                   CLEAR                   D@ENR
186900110513     C                   CLEAR                   D@FRM
187000110513     C                   CLEAR                   D@TRM
187100110513     C                   EVAL      M#CNE = 0
187200110513     C                   CLEAR                   M@PLN
187300110513     C                   CLEAR                   M@ENR
187400110513     C                   CLEAR                   M@FRM
187500110513     C                   CLEAR                   M@TRM
187600110513    ***
187700110513     C                   ENDSR
187800110513   S***S
187900110513     C     $DENWRT       BEGSR
188000110513    ***
188100110513    *C                   EVAL      X@LAY = CPCID1                               LAYOUT
188200110513    *C                   EVAL      X@ELR = CPCID2                               ELR
188300110513    *C                   EVAL      D@SFX = CPCID3                               SUFFIX
188400110513    *C                   EVAL      D@ACCT = CPCID4                              ACCOUNT
188500110513    *C                   EVAL      D@PLAN = CPCID5                              PLAN
188600110513    *C                   EVAL      D@CLM = CPCID6                               CLAIM OFFICE
188700110524     C                   EVAL      DNTLATE = '0'
188800110513    ***
188900110513    *C                   EVAL      #XSX = D@FRM(D#CNE)
189000110725     C                   IF        WRT@TYPE = 'DEPEND' AND
189100110725     C                             #XSX < D@MBREFF
189200110725     C                   MOVE      D@MBREFF      X@EFF
189300110725     C                   ELSE
189400110725     C                   MOVE      #XSX          X@EFF
189500110725     C                   ENDIF
189600110513    ***
189700110513    *C                   EVAL      #XSX = D@TRM(D#CNE)
189800110513    *C                   IF        #XSX = 0 OR #XSX = 99999999
189900110513    *C                   MOVE      *BLANKS       X@TRM
190000110513    *C                   ELSE
190100110513    *C                   MOVE      #XSX          X@TRM
190200110513    *C                   ENDIF
190300110513    ***
190400130211     C                   MOVE      *BLANKS       D@CBREXP
190500130211     C                   MOVE      *BLANKS       D@CBREVT
190600130211     C                   MOVE      *BLANKS       D@CBRLEN
190700110513     C                   IF        WRT@TYPE = 'MEMBER'
190800111123    *C                   IF        EMPST = 'C' AND CEXPDT <> 0
190900110513    *C                   MOVE      CEXPDT        D@CBREXP
191000110513    *C                   MOVE      QEDT          D@CBREVT
191100110513    *C                   MOVE      CEXPDT        #MINUEND
191200110513    *C                   MOVE      QEDT          #SUBTRAEND
191300110513    *C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
191400110513    *C                   Z-ADD     #DIFFRNC      #2S0
191500110513    *C                   MOVE      #2S0          D@CBRLEN
191600110513    *C                   ENDIF
191700110513    *C                   ENDIF
191800120806    ***
191900110513    *C                   MOVE      '0'           D@OOAI
192000140313    ***
192100140313     C                   EVAL      KF@SPCD = 'DEN'
192200140313     C                   EVAL      D@PCD = *BLANKS
192300140313     C                   EVAL      *IN81 = *OFF
192400140313     C                   MOVE      *BLANKS       DOCTOR
192500140313    ***
192600140313     C                   EXSR      $PCP
192700140313    ***
192800140313     C                   IF        DOCTOR <> *BLANKS
192900140313     C                   EVAL      D@PCD = DOCTOR
193000140313     C                   EVAL      *IN81 = *ON
193100140313     C                   ENDIF
193200110513    ***
193300120123     C     *LIKE         DEFINE    H@C#          BUC#
193400120123     C                   EVAL      BUC# = H@C#
193500120123    ***
193600120327     C                   SELECT
193700131126     C                   WHEN      KF@TRS = 591 AND KF@SUB = 009 AND            WILMOT MODULAR
193800131126     C                             KF@ACC = 0202                                 STRUCTURES
193900131227     C                   EVAL      H@C# = '0638156'
194000140702     C                   WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            REDLAND
194100140702     C                             KF@ACC = 0475                                 BAPTISTS
194200140702     C                   EVAL      H@C# = '0725572'
194300120327     C                   WHEN      KF@TRS = 825 AND KF@SUB = 001 AND            CREATIVE
194400120123     C                             KF@ACC = 0014                                 LOGISTICS
194500120123     C                   EVAL      H@C# = '0133860'
194600130905     C                   WHEN      KF@TRS = 905 AND KF@SUB = 001 AND            CCL USA
194700130905     C                             KF@ACC = 0092
194800130905     C                   EVAL      H@C# = '0638423'
194900140423     C                   WHEN      KF@TRS = 003 AND KF@SUB = 001 AND            FRAME RITE
195000140423     C                             KF@ACC = 0104
195100140423     C                   EVAL      H@C# = '0306511'
195200130520     C                   WHEN      KF@TRS = 900 AND KF@SUB = 003 AND            PERFECT
195300130520     C                             KF@ACC = 0045                                 SETTINGS
195400130520     C                   EVAL      H@C# = '0474109'
195500121024     C                   WHEN      KF@TRS = 591 AND KF@SUB = 011 AND            MCCALLISTER
195600121024     C                             KF@ACC = 0446                                 ARCHITECT
195700121024     C                   EVAL      H@C# = '0565330'
195800130716     C                   WHEN      KF@TRS = 591 AND KF@SUB = 005 AND            JD CLARK PROF
195900130716     C                             KF@ACC = 0451                                 SERVICES
196000130716     C                   EVAL      H@C# = '0519890'
196100130627     C                   WHEN      KF@TRS = 591 AND KF@SUB = 008 AND            DYSON CONSTRUCTION
196200130627     C                             KF@ACC = 0459                                 COMPANY
196300130627     C                   EVAL      H@C# = '0788122'
196400130903     C                   WHEN      KF@TRS = 591 AND KF@SUB = 004 AND            STROUSE CORP
196500130903     C                             KF@ACC = 0482
196600130903     C                   EVAL      H@C# = '0837451'
196700130712     C                   WHEN      KF@TRS = 900 AND KF@SUB = 007 AND            CAPLAN BROTHERS
196800130712     C                             KF@ACC = 0075
196900130712     C                   EVAL      H@C# = '0837533'
197000120806     C                   WHEN      KF@TRS = 900 AND KF@SUB = 101 AND            INTEGRA HEALTH
197100130110     C                             KF@ACC = 0042 AND
197200130110     C                             (STATE = 'TN' OR STATE = 'FL' OR
197300130718     C                              STATE = 'OH' OR STATE = 'MA') AND
197400120806     C                             (@PLANIN = 'DAAD' OR @PLANIN = 'BAAD')
197500120806     C                   EVAL      H@C# = '0503428'
197600120327    *C                   ENDSL
197700120123    ***
197800110513    *C                   EXCEPT    DENF
197900120123     C                   EVAL      H@C# = BUC#
198000110513    ***
198100110513    *C                   ENDSR
198200110513   S***S
198300110512   X***X
198400110802     OAET080WF  EADD         HDRF
198500101203     O                                            6 'HEADER'
198600101229     O                                            8 'P'
198700101206     O                       H@SI                28
198800101203     O                                           29 '0'
198900101203     O                       C1                  43
199000101203     O                       D1                  51
199100101203     O                       T1                  57
199200101206     O                                          131 'CONSOLIDATED ELIGIBILITY'
199300110502     O                       H@RI               167
199400101206     O                       H@CC               169
199500101228     O                       H@GN               176
199600101206     O                       H@CN               191
199700101206     O                       H@C#               198
199800101203     O                       D2                 206
199900110825     O                                          216 'MC'
200000101223     O                                          231 '*'
200100110802     OAET080WF  EADD         MBRF
200200101203     O                                            6 'MEMBER'
200300101203     O                       @SS1                16
200400101203     O                       @SS2                25
200500101203     O                       @FN                 75
200600101203     O                       @MI                 76
200700101203     O                       @LN                 96
200800101203     O                       @REL               101
200900101203     O                       @SEX               103
201000101203     O                       @DOB               111
201100101203     O                       @SPEC              112
201200101203     O                                          113 '0'
201300101203     O                       @COB               123
201400101203     O                       @COBC              125
201500101203     O                       @COBN              145
201600101203     O                       @AD1               175
201700101203     O                       @AD2               205
201800101203     O                       @CTY               315
201900101203     O                       @ST                317
202000101203     O                       @ZP5               322
202100101203     O                       @PHN               349
202200141211     O               87                         576 '21207'
202300140626     O               88                         576 '21740'
202400141120     O               89                         576 '20171'
202500101203     O                       @EMPST             665
202600101203     O                       @HIRE              673
202700101223     O                                         1231 '*'
202800110802     OAET080WF  EADD         HMOF
202900101213     O                                            7 'BENEFIT'
203000101213     O                       X@LAY               10
203100101214     O                       X@ELR               24
203200101213     O                       M@CC                26
203300101213     O                       H@GN                38
203400101213     O                       M@CLASS             44
203500101213     O                       M@PLAN              50
203600101213     O                       X@EFF               58
203700110929     O                       X@TRM               66
203800101213     O                       X@TIER              69
203900101213     O                       M@PCP              160
204000101213     O                       M@NPI              161
204100101213     O                       M@PCPCI            186
204200101223     O                                          323 '*'
204300140313     OAET080WF  EADD         MEAF
204400140313     O                                            7 'BENEFIT'
204500140313     O                                           10 'MEA'
204600140313     O                       X@ELR               24
204700140313     O                       H@C#                31
204800140313     O                       E@SFX               34
204900140313     O                       E@ACCT              44
205000140313     O                       E@PLAN              50
205100140313     O                       X@EFF               58
205200140313     O                       X@TRM               66
205300140313     O                       E@CLM               71
205400140313     *** PCP BGN
205500140313     O                       E@PCP              127
205600140313     O               80                         161 'N'
205700140313     O               80                         186 '0'
205800140313     *** PCP END
205900140313     O                                          389 '0'
206000140313     *** COBRA BGN
206100140313     O                       E@CBREXP           466
206200140313     O                       E@CBREVT           516
206300140313     O                       E@CBRLEN           560
206400140313     *** COBRA END
206500140313     O                                          678 '*'
206600140313    ***
206700110802     OAET080WF  EADD         DENF
206800101213     O                                            7 'BENEFIT'
206900101213     O                       X@LAY               10
207000101214     O                       X@ELR               24
207100101214     O                       H@C#                31
207200101213     O                       D@SFX               34
207300101213     O                       D@ACCT              44
207400101213     O                       D@PLAN              50
207500101213     O                       X@EFF               58
207600110929     O                       X@TRM               66
207700101213     O                       D@CLM               71
207800140313     *** PCD BGN
207900140313     O                       D@PCD              200
208000140313     O               81                         236 '0'
208100140313     *** PCD END
208200140313     O                                          389 '0'
208300140313     *** COBRA BGN
208400140313     O                       D@CBREXP           466
208500140313     O                       D@CBREVT           516
208600140313     O                       D@CBRLEN           560
208700140313     *** COBRA END
208800140313     O                       D@OOAI             609
208900140313     O                                          678 '*'
209000140313    ***
209100130315     OAET080WF  EADD         LIFF
209200130315     O                                            7 'BENEFIT'
209300130412     O                                           11 'LIFE'
209400130315     O                       X@ELR               24
209500130319     O                       H@C#3               31
209600130315     O                       L@SFX               34
209700130315     O                       L@ACCT              44
209800130315     O                       L@PLAN              50
209900130315     O                       X@EFF               58
210000130315     O                       X@TRM               66
210100130315     O                       L@CLM               71
210200130315     O                       L@CBREXP           466
210300130315     O                       L@CBREVT           516
210400130315     O                       L@CBRLEN           560
210500130315     O                       L@SALARY           658
210600130315     O                                          659 '1'
210700130315     O                                          678 '*'
210800110802     OAET080WF  EADD         TRLF
210900101203     O                                            7 'TRAILER'
211000101203     O                       @TREC               17
211100101203     O                       D1                  25
211200101203     O                       T1                  31
211300101203     O                       @BREC               41
211400101223     O                                           69 '*'
