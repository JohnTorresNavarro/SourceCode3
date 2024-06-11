000100160224      *=============================================================================================
000200160224     H option(*noDebugIo)
000300160224      *=============================================================================================
000400200116      *  CARRIER CONTROL ID #0000000127 AETNA SPECIFIC
000500200116      *  SSK 05.13.2011 TEMPLATE DESIGN
000600200116      *  Cloned from AET084RV (SSK)
000602200124      *  01/24/2020  JT  Cleaned up a little bit of this mess
000604200227      *  02/27/2020  JT  Records were not being written to term file.
000605240130      *  01/30/2023  JT  The term date was not being passed to the term file for
000606240130      *                  verification
000700200116      *=============================================================================================
000800200116
000900101012     FCARACCP   IF   E           K DISK
001000101012     FCARPLNP   IF   E           K DISK
001100200116
001200200116     FAET004WF  IF   E           K DISK
001300120803     ** MAPPING METHOD
001400200116     FAETGEN    O  A F 1231        DISK
001500101206     ** FLAT FILE
001600200116     FAETGENTRM IF A E           K DISK
001700101028     ** TERM TRACKER
001800101028     **
001900200116     FMEMAC#1   IF   E           K DISK    extfile('F.MEMAC#1')
002000200116
002100101012     FMCOVMPLN  IF   E           K DISK
002200200116     FDEPNDC    IF   E           K DISK    extfile('F.DEPNDC')
002300101012     FDCOVA     IF   E           K DISK
002400200116     FPCPL1     IF   E           K DISK    extfile('F.PCPL1')
002500200116
002600200116      *=============================================================================================
002700200116
002800120803     D KF@CCTL         S             10A   INZ
002900200116     D CARR#CTL        S             10
003000110512     D H@RI            S             25A   INZ('042064683')                     RECEIVER ID
003100200116
003200110512     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
003300101026     D DS@CARACC     E DS                  EXTNAME(CARACCP)
003400200116
003500110512     ** WORK ARRAY FOR PLANS
003600110512     **
003700110512     ** PC# - PLAN COUNT
003800110512     ** PP# - PLAN POINTER
003900110512     **
004000110512     D CARPLN@       E DS                  EXTNAME(CARPLNP)
004100160902     D                                     OCCURS(900) PREFIX(X:1)
004200110512     D PC#             S              3S 0
004300110512     D PP#             S              3S 0
004400110512     D @PLANIN         S              4A
004500110512     D @CCTRIN         S              3A
004600200116
004700110513     **
004800110513     ** WRITE TYPE = MEMBER OR DEPEND
004900110513     D WRT@TYPE        S              6A
005000110513     **
005100200116
005200101214     D #XST            S              6S 0
005300101214     D #IST            S               T
005400101026     D #ISO            S               D   DATFMT(*ISO)
005500101214     D #MINUEND        S               D   DATFMT(*ISO)
005600101214     D #SUBTRAEND      S               D   DATFMT(*ISO)
005700101214     D @DATE           S              8A
005800101214     D @TIME           S              6A
005900101214     D #DIFFRNC        S              5S 0
006000101214     D #2S0            S              2S 0
006100101214     D #CANCEL         S              8S 0
006200101026     D #XSX            S              8S 0
006300101026     D #XSX2           S              8S 0
006400101026     D DATE@OUT        S             10A
006500101026     D ENR@IN          S              3A
006600101026     D ENR@OUT         S              1A
006700110524     D DNTLATE         S              1A
006800130315     D TERM_LIF        S               N
006900101214     D TERM_DEN        S               N
007000101214     D TERM_MED        S               N
007100101026     D YES             S               N   INZ(*ON)
007200101026     D NO              S               N   INZ(*OFF)
007300200116
007400110512     D KF@TRS          S                   LIKE(MCTRST)
007500110512     D KF@SUB          S                   LIKE(MCSUB#)
007600110512     D KF@ACC          S                   LIKE(ACC#)
007700101026     D KF@ENR          S              3A   INZ
007800101026     D KF@CARG         S              2A   INZ
007900101026     D KF@CCTR         S                   LIKE(CCFLG)
008000101026     D KF@PLN          S                   LIKE(MCPLAN)
008100101026     D KF@TRM          S                   LIKE(NTTERMDT)
008200101026     D KF#TRM          S              8S 0
008300101026     D KF@SSN          S                   LIKE(MBSSNO)
008400101026     D KF@SEQ          S                   LIKE(DPSEQ#)
008500101026     D KF@TYP          S              1A
008600101026     D KF@CDE          S              2A
008700140313     D KF@SPCD         S              5A
008800140313     D KF@MPLN         S              4A
008900140313     **
009000101026     D M@EARLYP        S              4A
009100101026     D M#EARLYE        S              8S 0 INZ
009200101026     D M#EARLYT        S              8S 0 INZ
009300140313     **
009400101026     D #8D1            S              8S 0 INZ
009500101214     D D1              S              8A
009600101214     D D2              S              8A
009700101214     D T1              S              6A
009800101214     D C1              S             14A
009900101206    ***
010000101029     D B#RECCNT        S             10S 0 INZ
010100101029     D C#RECCNT        S             10S 0 INZ
010200101206    ***
010300101210     D @SS1            S              9A
010400101210     D @SS2            S              9A
010500101210     D @FN             S             15A
010600101210     D @MI             S              1A
010700101210     D @LN             S             20A
010800101210     D @REL            S              2A
010900101210     D @SEX            S              1A
011000101210     D @DOB            S              8A
011100101210     D @SPEC           S              1A
011200101210     D @COB            S              1A
011300101210     D @COBC           S              2A
011400101210     D @COBN           S             20A
011500101210     D @AD1            S             30A
011600101210     D @AD2            S             30A
011700101214     D @CTY            S             20A
011800101210     D @ST             S              2A
011900101210     D @ZP5            S              5A
012000101210     D @PHN            S             10A
012100101210     D @EMPST          S              2A
012200101210     D @HIRE           S              8A
012300101206    ***
012400130315    *** LIFE ARRAYS
012500130315     D L#CNE           S              3S 0 INZ
012600130315     D L#NDX           S              3S 0 INZ
012700130315     D L@PLN           S              4A   DIM(20)
012800130315     D L@ENR           S              3A   DIM(20)
012900130315     D L@FRM           S              8S 0 DIM(20)
013000130315     D L@TRM           S              8S 0 DIM(20)
013100130315     D L@MBREFF        S              8S 0
013200140313    ***
013300101206    *** DENTAL ARRAYS
013400101206     D D#CNE           S              3S 0 INZ
013500101206     D D#NDX           S              3S 0 INZ
013600101206     D D@PLN           S              4A   DIM(20)
013700101206     D D@ENR           S              3A   DIM(20)
013800101206     D D@FRM           S              8S 0 DIM(20)
013900101206     D D@TRM           S              8S 0 DIM(20)
014000110725     D D@MBREFF        S              8S 0
014100140313    ***
014200101206    *** MEDICAL ARRAYS
014300101206     D M#CNE           S              3S 0 INZ
014400101206     D M#NDX           S              3S 0 INZ
014500101206     D M@PLN           S              4A   DIM(20)
014600101206     D M@ENR           S              3A   DIM(20)
014700101206     D M@FRM           S              8S 0 DIM(20)
014800101206     D M@TRM           S              8S 0 DIM(20)
014900110725     D M@MBREFF        S              8S 0
015000101206    ***
015100101206     D H@SI            S             20A
015200101206     D H@CC            S              2A
015300101206     D H@GN            S              7A
015400101206     D H@CN            S             15A
015500101206     D H@C#            S              7A
015600130319     D H@C#3           S              7A
015700140313    ***
015800101213     D X@LAY           S              3A
015900101213     D X@ELR           S              7A
016000140313     D X@EFF           S              8A
016100140313     D X@TRM           S              8A
016200140313     D X@TIER          S              1A
016300140313    ***
016400101213     D M@CC            S              2A
016500101213     D M@CLASS         S              5A
016600101213     D M@PLAN          S              6A
016700101213     D M@PCP           S             40A
016800101213     D M@NPI           S              1A
016900101213     D M@PCPCI         S              1A
017000140313    ***
017100101213     D D@SFX           S              3A
017200101213     D D@ACCT          S              5A
017300101213     D D@PLAN          S              6A
017400101213     D D@CLM           S              3A
017500101213     D D@CBREXP        S              8A
017600101213     D D@CBREVT        S              8A
017700101213     D D@CBRLEN        S              2A
017800101213     D D@OOAI          S              1A
017900140313     D D@PCD           S              7A
018000140313    ***
018100101214     D @STEP           S              5A
018200140313    ***
018300140313     D E@SFX           S              3A
018400140313     D E@ACCT          S              5A
018500140313     D E@PLAN          S              6A
018600140313     D E@CLM           S              3A
018700140313     D E@PCP           S              7A
018800140313     D E@CBREXP        S              8A
018900140313     D E@CBREVT        S              8A
019000140313     D E@CBRLEN        S              2A
019100140313    ***
019200130315     D L@SFX           S              3A
019300130315     D L@ACCT          S              5A
019400130315     D L@PLAN          S              6A
019500130315     D L@CLM           S              3A
019600130315     D L@CBREXP        S              8A
019700130315     D L@CBREVT        S              8A
019800130315     D L@CBRLEN        S              2A
019900130315     D L@SALARY        S             20A
020000200116
020100160809     d num_date        s              8s 0 inz
020200160809     D work_date       s               d
020300200116     d grouper         s             30
020400200116     d p_trust         s              3  0
020500200116     d p_sub#          s              3  0
020600200116     d p_acct          s              4  0
020700200116
020800200116      *=============================================================================================
020900200116
021000110512     C                   EVAL      @STEP = 'PREP1'
021100101214    ***
021200120803     C                   EVAL      KF@CCTL = CARR#CTL
021300110802     C                   EXSR      $HEADR
021400110512    ***
021500200116       setll carr#ctl caraccr;
021600110512    ***
021700101026     C                   DOU       @STEP = 'LEAVE'
021800101026     C     @STEP         CASEQ     'PREP1'       $PREP1
021900101026     C     @STEP         CASEQ     'STEP1'       $STEP1
022000101026     C     @STEP         CASEQ     'STEP2'       $STEP2
022100101026     C     @STEP         CASEQ     'STEP3'       $STEP3
022200101026     C     @STEP         CASEQ     'PREP4'       $PREP4
022300101026     C     @STEP         CASEQ     'STEP4'       $STEP4
022400101026     C     @STEP         CASEQ     'PREP5'       $PREP5
022500101026     C     @STEP         CASEQ     'STEP5'       $STEP5
022600101214     C     @STEP         CASEQ     'PREP6'       $PREP6
022700101026     C     @STEP         CASEQ     'STEP6'       $STEP6
022800101214     C     @STEP         CASEQ     'PREP7'       $PREP7
022900101214     C     @STEP         CASEQ     'STEP7'       $STEP7
023000101214     C     @STEP         CASEQ     'STEP8'       $STEP8
023100101214     C     @STEP         CASEQ     'PREP9'       $PREP9
023200101214     C     @STEP         CASEQ     'STEP9'       $STEP9
023300101214     C     @STEP         CASEQ     'PREPA'       $PREPA
023400101214     C     @STEP         CASEQ     'STEPA'       $STEPA
023500101214     C     @STEP         CASEQ     'PREPB'       $PREPB
023600101214     C     @STEP         CASEQ     'STEPB'       $STEPB
023700130315     C     @STEP         CASEQ     'PREPC'       $PREPC
023800130315     C     @STEP         CASEQ     'STEPC'       $STEPC
023900101026     C                   ENDCS
024000101026     C                   ENDDO
024100120711    ***
024200101206    ***  TRAILER RECORD
024300120711    ***
024400101026     C                   ADD       2             C#RECCNT
024500101214     C                   MOVE      C#RECCNT      @TREC            10 0
024600101214     C                   MOVE      B#RECCNT      @BREC            10 0
024700101214     C                   EXCEPT    TRLF
024800101026    ***
024900101026     C                   EVAL      *INLR = *ON
025000110512   S***S
025100110802     C     $HEADR        BEGSR
025200101206    ***
025300110802     C                   EVAL      D1 = @DATE
025400110802     C                   EVAL      D2 = @DATE
025500110802     C                   EVAL      T1 = @TIME
025600110802     C                   EVAL      C1 = @DATE + @TIME
025700110802    ***
025800200116       //kf@trs = p_trust;
025900200116       //kf@sub = p_sub#;
026000200116       //kf@acc = p_acct;
026100200116
026200200116     C                   EVAL      KF@TRS = 999
026300200116     C                   EVAL      KF@SUB = 999
026400200116     C                   EVAL      KF@ACC = 9999
026500200116       chain (carr#ctl: kf@trs : kf@sub : kf@acc) caraccr;
026600200116
026700110802     C                   EVAL      H@SI = %TRIM(CACID1)                         SUBMITTER ID
026800110802     C                   EVAL      H@CC = %SUBST(CACID2:1:2)                    COMPANY CODE
026900200121     C                   MOVEL(P)  CACID8        H@GN                           HMO GROUP #
027000110802     C                   MOVEL(P)  CACID4        H@CN                           CUSTOMER NAME
027100200124     C                   MOVEL(P)  CACID4        H@C#                           CUSTOMER #
027200130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
027300110802    ***
027400110802     C                   EXCEPT    HDRF
027500110802    ***
027600110802     C                   ENDSR
027700110802   S***S
027800110802     C     $PREP1        BEGSR
027900110802    ***
028000200116       reade (carr#ctl) caraccr;
028100200116     C**** KF@CCTL       READE     CARACCR
028200110512     C                   IF        %EOF(CARACCP)
028300110512     C                   EVAL      @STEP = 'LEAVE'
028400110512     C                   LEAVESR
028500110512     C                   ENDIF
028600110512    ***
028700110513    *** HAS THE ACCOUNT BEEN SHUTOFF FOR EXPORT?
028800110513    ***
028900110512     C                   IF        CASTATUS <> 'Y'
029000110512     C                   LEAVESR
029100110512     C                   ENDIF
029200200116
029300200116     C                   if        cacida <> grouper
029400200116     C                   leavesr
029500200116     C                   endif
029600200116
029700110512    ***
029800110802    *** THESE FIELDS RESET FOR EACH SMALL GROUP READ
029900110802    ***
030000200121     C                   MOVEL(P)  CACID8        H@GN                           HMO GROUP #
030100200124     C                   MOVEL(P)  CACID4        H@C#                           CUSTOMER #
030200130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
030300110802    ***
030400110512     C                   EVAL      KF@TRS = CATRST
030500110512     C                   EVAL      KF@SUB = CASUB#
030600110512     C                   EVAL      KF@ACC = CAACCT
030700110512    ***
030800110512     C                   EXSR      $PLANLOAD
030900110512    ***
031000101206     C                   EVAL      @STEP = 'STEP1'
031100110512    ***
031200110512     C                   ENDSR
031300110512   S***S
031400101206     C     $STEP1        BEGSR
031500101206    ***
031600101206     C                   EVAL      KF@PLN = *BLANKS
031700101206     C                   EVAL      KF@TRM = 0
031800101206     C                   EVAL      KF@SSN = 0
031900101206     C                   EVAL      KF@SEQ = 0
032000110512    ***
032100101206     C     KL#TSA        SETLL     MEMBR
032200101206    ***
032300101206     C                   EVAL      @STEP = 'STEP2'
032400101206    ***
032500101206     C                   ENDSR
032600101206   S***S
032700101206     C     $STEP2        BEGSR
032800101206    ***
032900101206     C     KL#TSA        READE     MEMBR
033000101206    ***
033100101206     C                   IF        %EOF(MEMAC#1)
033200110512     C                   EVAL      @STEP = 'PREP1'
033300101206     C                   LEAVESR
033400101206     C                   ENDIF
033500101206    ***
033600101206     C                   EVAL      KF@SSN = MBSSNO
033700101214     C                   MOVE      *ZEROS        KF@SEQ
033800120803     C                   EVAL      WRT@TYPE = 'MEMBER'
033900120803    ***
034000101214    ***
034100101206     C     KL#MPLN       SETLL     MCOVR
034200101206    ***
034300101206     C                   EXSR      $CLRSTG
034400101206    ***
034500101206     C                   EVAL      @STEP = 'STEP3'
034600101206    ***
034700101206     C                   ENDSR
034800101210   S***S
034900101206     C     $STEP3        BEGSR
035000101206    ***
035100101206     C     KL#MPLN       READE     MCOVR
035200101206    ***
035300101206     C                   IF        %EOF(MCOVMPLN)
035400101206     C                   EVAL      @STEP = 'PREP4'
035500101206     C                   LEAVESR
035600101206     C                   ENDIF
035700101206    ***
035800130131     C*                  IF        ENRLDT = CANDT
035900130131     C*                  LEAVESR
036000130131     C*                  ENDIF
036100120803    ***
036200120803     C                   EVAL      KF@PLN = MCPLAN
036300200116     C     KL#TSAP       CHAIN     AEF04
036400200116     C                   IF        NOT %FOUND(AET004WF)
036500120803     C                   LEAVESR
036600120803     C                   ENDIF
036700110513    ***
036800110512     C                   EVAL      @PLANIN = MCPLAN
036900111020     C                   EVAL      ENR@IN = MCOVTP
037000110802    ***
037100110802     C                   EXSR      $QUIK
037200110802    ***
037300110512     C                   EXSR      $PLANSRCH
037400110512    ***
037500110512     C                   IF        PLN@CAT = *BLANKS
037600110512     C                   LEAVESR
037700110512     C                   ENDIF
037800101206    ***
037900101206     C                   IF        CANDT = 0
038000101206     C                   EVAL      #CANCEL = 99999999
038100101206     C                   ELSE
038200101206     C                   EVAL      #CANCEL = CANDT
038300101206     C                   ENDIF
038400101206    ***
038500130315    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL;
038600130315    *** LIF IS LIFE;
038700110513    ***
038800130315     C                   SELECT
038900130315      *
039000160224    *C****               WHEN      PLN@CAT = 'LIFE'
039100160224    *C****               IF        L#CNE > 0
039200160224    *C****               IF        L@TRM(L#CNE) = 99999999
039300160224     C****               LEAVESR
039400160224     C****               ENDIF
039500160224     C****               ENDIF
039600160224    *C****               ADD       1             L#CNE
039700160224    *C****               EVAL      L@PLN(L#CNE) = MCPLAN
039800160224    *C****               EVAL      L@ENR(L#CNE) = MCOVTP
039900160224    *C****               EVAL      L@FRM(L#CNE) = ENRLDT
040000160224    *C****               EVAL      L@TRM(L#CNE) = #CANCEL
040100130315      *
040200160224    *C****               WHEN      PLN@CAT = 'DEN'
040300160224    *C****               IF        D#CNE > 0
040400160224    *C****               IF        D@TRM(D#CNE) = 99999999
040500160224     C****               LEAVESR
040600160224     C****               ENDIF
040700160224     C****               ENDIF
040800160224    *C****               ADD       1             D#CNE
040900160224    *C****               EVAL      D@PLN(D#CNE) = MCPLAN
041000160224    *C****               EVAL      D@ENR(D#CNE) = MCOVTP
041100160224    *C****               EVAL      D@FRM(D#CNE) = ENRLDT
041200160224    *C****               EVAL      D@TRM(D#CNE) = #CANCEL
041300160224      ****
041400160224    *C                   WHEN      PLN@CAT = 'VIS '
041500160224    *C                   IF        M#CNE > 0
041600160224    *C                   IF        M@TRM(M#CNE) = 99999999
041700160224     C                   LEAVESR
041800160224     C                   ENDIF
041900160224     C                   ENDIF
042000160224     C                   ADD       1             M#CNE
042100160224     C                   EVAL      M@PLN(M#CNE) = MCPLAN
042200101206     C                   EVAL      M@ENR(M#CNE) = MCOVTP
042300101206     C                   EVAL      M@FRM(M#CNE) = ENRLDT
042400101206     C                   EVAL      M@TRM(M#CNE) = #CANCEL
042500130315      *
042600130315    *C                   ENDSL
042700110512    ***
042800110512     C                   ENDSR
042900110512   S***S
043000110802     C     $QUIK         BEGSR
043100110802    ***
043200110805     C                   EVAL      @CCTRIN = *BLANKS
043300120803    ***
043400200116     C     AE4MAP        CASEQ     '2TIER     '  $METH01
043500200116     C     AE4MAP        CASEQ     'ITOBJECTS '  $METH02
043600200116     C     AE4MAP        CASEQ     'NORULE    '  $METH03
043700200116     C     AE4MAP        CASEQ     'STATETIER '  $METH04
043800200116     C     AE4MAP        CASEQ     'TIERSTS   '  $METH05
043900200116     C     AE4MAP        CASEQ     'MAYOR     '  $METH06
044000200116     C     AE4MAP        CASEQ     'EMPSTS    '  $METH07
044100200116     C     AE4MAP        CASEQ     'JUSTSTATE '  $METH08
044200200116     C     AE4MAP        CASEQ     'JOHNLS    '  $METH09
044300200116     C     AE4MAP        CASEQ     'CREATIVE  '  $METH10
044400200116     C     AE4MAP        CASEQ     'INTEGRA   '  $METH11
044500200116     C     AE4MAP        CASEQ     'STSTATE   '  $METH12
044600200116     C     AE4MAP        CASEQ     'INTEGRA   '  $METH11
044700200116     C     AE4MAP        CASEQ     'STIERSTS  '  $METH13
044800120803     C                   ENDCS
044900120803    ***
045000120803     C                   ENDSR
045100120803   S***S
045200120803    *** 2 TIER = AETNA HAS TWO TIERS, IND AND FAM
045300120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'IND' AND NON-'TIN' CONVERTED TO 'FAM'
045400120803    ***  DEPENDENTS HAVE 'FAM' ONLY
045500120803    ***
045600120803    *** IND, FAM
045700120803    ***
045800120803     C     $METH01       BEGSR
045900120803    ***
046000120803     C                   IF        WRT@TYPE = 'MEMBER'
046100120803    *** *
046200120803     C                   IF        ENR@IN = 'TIN'
046300120803     C                   EVAL      @CCTRIN = 'IND'
046400120803     C                   ELSE
046500120803     C                   EVAL      @CCTRIN = 'FAM'
046600120803     C                   ENDIF
046700120803    *** *
046800120803     C                   ENDIF
046900120803    ***
047000120803     C                   IF        WRT@TYPE = 'DEPEND'
047100120803    *** *
047200120803     C                   EVAL      @CCTRIN = 'FAM'
047300120803    *** *
047400120803     C                   ENDIF
047500120803    ***
047600120803     C                   ENDSR
047700120803   S***S
047800120803    *** ITOBJECTS = IF YOU ARE NOT 'VA' OR 'OH' STATE CODES, YOU ARE 'XX'
047900120803    ***
048000120803    *** VA, OH, XX
048100120803    ***
048200120803     C     $METH02       BEGSR
048300120803    ***
048400120803     C                   IF        STATE <> 'VA' AND STATE <> 'OH'
048500120803     C                   EVAL      @CCTRIN = 'XX '
048600120803     C                   ELSE
048700120803     C                   EVAL      @CCTRIN = STATE
048800120803     C                   ENDIF
048900120803    ***
049000120803     C                   ENDSR
049100120803   S***S
049200120803    *** NORULE = NUFF SAID
049300120803    ***
049400120803     C     $METH03       BEGSR
049500120803    ***
049600120803     C                   EVAL      @CCTRIN = *BLANKS
049700120803    ***
049800120803     C                   ENDSR
049900120803   S***S
050000120803    *** STATETIER
050100120803    ***  START WITH STATE CODE
050200120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
050300120803    ***  DEPENDENTS HAVE 'F' ONLY
050400120803    ***
050500120803    *** MDI, MDF, ETC...
050600120803    ***
050700120803     C     $METH04       BEGSR
050800120803    ***
050900120803     C                   EVAL      @CCTRIN = STATE
051000120803    ***
051100120803     C                   IF        WRT@TYPE = 'MEMBER'
051200120803     C                   IF        ENR@IN = 'TIN'
051300120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
051400120803     C                   ELSE
051500120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
051600120803     C                   ENDIF
051700120803     C                   ENDIF
051800120803    ***
051900120803     C                   IF        WRT@TYPE = 'DEPEND'
052000120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
052100120803     C                   ENDIF
052200120803    ***
052300120803     C                   ENDSR
052400120803   S***S
052500120803    *** TIERSTS
052600120803    ***  START WITH EMPLOYMENT STATUS, ACTIVE IS 'ACT' AND COBRA IS 'COB'
052700120803    ***  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
052800120803    ***  DEPENDENTS HAVE 'F' ONLY
052900120803    ***
053000120803    *** ACI, ACF, COI, COF
053100120803    ***
053200120803     C     $METH05       BEGSR
053300120803    ***
053400120803     C                   IF        EMPST =  'C'
053500120803     C                   EVAL      @CCTRIN = 'COB'
053600120803     C                   ELSE
053700120803     C                   EVAL      @CCTRIN = 'ACT'
053800120803     C                   ENDIF
053900120803    ***
054000120803     C                   IF        ENR@IN = 'TIN'
054100120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
054200120803     C                   ELSE
054300120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
054400120803     C                   ENDIF
054500120803    ***
054600120803     C                   ENDSR
054700120803   S***S
054800120803    *** MAYOR
054900120803    ***  WELL, FOR THE PLAN 'DAAU' IF THE STATE IS 'WV' THEN PLACE TIER STATUS SUFFIX
055000120803    ***       BY TYPE OF PEEP; FOR OTHER STATES, USE A SIMPLE TIER CHECK.
055100120803    ***
055200120803    ***  WVI, WVF, IND, FAM
055300120803    ***
055400120803    ***  NOW, FOR THE PLAN 'DAAT' IF THE STATE IS 'WV' THEN PLACE EMPLOYMENT STATUS SUFFIX
055500120803    ***       BY TYPE OF PEEP; FOR OTHER STATES, EMPLOYMENT STATUS AND TIER.
055600120803    ***
055700120803    ***  WVI, WVF, CBI, CBF, ACI, ACF
055800120803    ***
055900120803    ***
056000120803     C     $METH06       BEGSR
056100120803    ***
056200120803    1C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'MEMBER'
056300120803      *
056400120803    2C                   IF        STATE = 'WV'
056500120803      **
056600120803    3C                   IF        ENR@IN = 'TIN'
056700120803     C                   EVAL      @CCTRIN = 'WVI'
056800120803    3C                   ELSE
056900120803     C                   EVAL      @CCTRIN = 'WVF'
057000120803    3C                   ENDIF
057100120803      **
057200120803    2C                   ELSE
057300120803      **
057400120803    3C                   IF        ENR@IN = 'TIN'
057500120803     C                   EVAL      @CCTRIN = 'IND'
057600120803    3C                   ELSE
057700120803     C                   EVAL      @CCTRIN = 'FAM'
057800120803    3C                   ENDIF
057900120803      **
058000120803    2C                   ENDIF
058100120803      *
058200120803     C                   LEAVESR
058300120803    1C                   ENDIF
058400120803    ***
058500120803     C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'DEPEND'
058600120803      *
058700120803     C                   IF        STATE = 'WV'
058800120803     C                   EVAL      @CCTRIN = 'WVF'
058900120803     C                   ELSE
059000120803     C                   EVAL      @CCTRIN = 'FAM'
059100120803     C                   ENDIF
059200120803      *
059300120803     C                   LEAVESR
059400120803     C                   ENDIF
059500120803    ***
059600120803    1C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'MEMBER'
059700120803      *
059800120803    2C                   IF        STATE = 'WV'
059900120803      **
060000120803    3C                   IF        ENR@IN = 'TIN'
060100120803     C                   EVAL      @CCTRIN = 'WVI'
060200120803    3C                   ELSE
060300120803     C                   EVAL      @CCTRIN = 'WVF'
060400120803    3C                   ENDIF
060500120803      **
060600120803    2C                   ELSE
060700120803      **
060800120803    3C                   IF        EMPST =  'C'
060900120803     C                   EVAL      @CCTRIN = 'CB '
061000120803    3C                   ELSE
061100120803     C                   EVAL      @CCTRIN = 'AC '
061200120803    3C                   ENDIF
061300120803    3C                   IF        ENR@IN = 'TIN'
061400120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
061500120803    3C                   ELSE
061600120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
061700120803    3C                   ENDIF
061800120803      **
061900120803    2C                   ENDIF
062000120803      *
062100120803     C                   LEAVESR
062200120803    1C                   ENDIF
062300120803    ***
062400120803     C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'DEPEND'
062500120803      *
062600120803     C                   IF        STATE = 'WV'
062700120803     C                   EVAL      @CCTRIN = 'WVF'
062800120803     C                   ELSE
062900120803     C                   IF        EMPST =  'C'
063000120803     C                   EVAL      @CCTRIN = 'CBF'
063100120803     C                   ELSE
063200120803     C                   EVAL      @CCTRIN = 'ACF'
063300120803     C                   ENDIF
063400120803     C                   ENDIF
063500120803      *
063600120803     C                   ENDIF
063700120803    ***
063800120803     C                   ENDSR
063900120803   S***S
064000120803    *** EMPSTS
064100120803    ***   PRETTY STRAIGHT FORWARDED
064200120803    ***
064300120803     C     $METH07       BEGSR
064400120803    ***
064500120803     C                   IF        EMPST =  'C'
064600120803     C                   EVAL      @CCTRIN = 'COB'
064700120803     C                   ELSE
064800120803     C                   EVAL      @CCTRIN = 'ACT'
064900120803     C                   ENDIF
065000120803    ***
065100120803     C                   ENDSR
065200120803   S***S
065300120803    *** JUSTSTATE
065400120803    ***   PRETTY STRAIGHT FORWARDED
065500120803    ***
065600120803     C     $METH08       BEGSR
065700120803    ***
065800120803     C                   EVAL      @CCTRIN = STATE
065900120803    ***
066000120803     C                   ENDSR
066100120803   S***S
066200120803    *** JOHNLS
066300120803    ***   IF STATE IS NOT MARYLAND, DEFAULT TO 'XX', ELSE USE 'MD'; THEN APPLY TIER.
066400120803    ***
066500120803    *** MDI, MDF, XXI, XXF
066600120803    ***
066700120803     C     $METH09       BEGSR
066800120803    ***
066900120803     C                   IF        WRT@TYPE = 'MEMBER'
067000120803     C                   IF        STATE = 'MD'
067100120803     C                   EVAL      @CCTRIN = 'MD'
067200120803     C                   ELSE
067300120803     C                   EVAL      @CCTRIN = 'XX'
067400120803     C                   ENDIF
067500120803     C                   IF        ENR@IN = 'TIN'
067600120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
067700120803     C                   ELSE
067800120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
067900120803     C                   ENDIF
068000120803     C                   ENDIF
068100120803    ***
068200120803     C                   IF        WRT@TYPE = 'DEPEND'
068300120803     C                   IF        STATE = 'MD'
068400120803     C                   EVAL      @CCTRIN = 'MDF'
068500120803     C                   ELSE
068600120803     C                   EVAL      @CCTRIN = 'XXF'
068700120803     C                   ENDIF
068800120803     C                   ENDIF
068900120803    ***
069000120803     C                   ENDSR
069100120803   S***S
069200120803    *** CREATIVE
069300120803    ***   IF STATE IS NOT 'MD' OR 'OK', DEFAULT TO '**'.
069400120803    ***
069500120803    *** MD, OK, **
069600120803    ***
069700120803     C     $METH10       BEGSR
069800120803    ***
069900120803     C                   IF        STATE <> 'MD' AND STATE <> 'OK'
070000120803     C                   EVAL      @CCTRIN = '** '
070100120803     C                   ELSE
070200120803     C                   EVAL      @CCTRIN = STATE
070300120803     C                   ENDIF
070400120803    ***
070500120803     C                   ENDSR
070600120803   S***S
070700120803    *** INTEGRA = USE 'TN' FOR TENNESSEE, OTHER STATES ARE 'XX'
070800120803    ***
070900120803    ***  TN, XX
071000120803    ***
071100120803     C     $METH11       BEGSR
071200120803    ***
071300121113     C                   SELECT
071400121113     C                   WHEN      STATE = 'TN'
071500121113     C                   EVAL      @CCTRIN = STATE                              TENNESSEE ONLY
071600121113     C                   WHEN      STATE = 'FL'
071700121113     C                   EVAL      @CCTRIN = STATE                              FLORIDA ONLY
071800121113     C                   OTHER
071900121113     C                   EVAL      @CCTRIN = 'XX '                              SITUS
072000121113     C                   ENDSL
072100120803    ***
072200120803     C                   ENDSR
072300120803   S***S
072400120803    *** STSTATE = STATE CODE WITH EMPLOYEE STATUS
072500120803    ***
072600120803    ***  MDA, MDC, ETC...
072700120803    ***
072800120803     C     $METH12       BEGSR
072900120803    ***
073000120803     C                   EVAL      @CCTRIN = STATE + EMPST
073100120803    ***
073200120803     C                   ENDSR
073300130123   S***S
073400130123    *** STIERSTS = STATE CODE WITH TIER WITH EMPLOYEE STATUS
073500130123    ***    ACTIVE [#CALC = 0]      COBRA [#CALC = 5]
073600130123    ***    IND [+1 TO #CALC ]      NON-IND COVERAGE [+2 TO CALC]
073700130123    ***
073800130123    ***    EACH STATE PUT AT END, GIVING FAM MARYLAND ACTIVE A VALUE OF 2MD
073900130123    ***                                  IND WEST VIRGINIA COBRA A VALUE OF 6WV
074000130123    ***
074100130123    ***
074200130123     C     $METH13       BEGSR
074300130123    ***
074400130123     C                   SELECT
074500130123     C                   WHEN      EMPST =  'C'
074600130123     C                   Z-ADD     5             #CALC
074700130123     C                   OTHER
074800130123     C                   MOVE      *ZEROS        #CALC             1 0
074900130123     C                   ENDSL
075000130123    ***
075100130123     C                   SELECT
075200130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN = 'TIN'
075300130123     C                   ADD       1             #CALC
075400130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN <> 'TIN'
075500130123     C                   ADD       2             #CALC
075600130123     C                   WHEN      WRT@TYPE = 'DEPEND'
075700130123     C                   ADD       2             #CALC
075800130123     C                   ENDSL
075900130123    ***
076000130123     C                   EVAL      @CCTRIN = %EDITC(#CALC:'X') + STATE
076100130123    ***
076200130123     C                   ENDSR
076300120803   S***S
076400120409     C     $PREP4        BEGSR
076500120409    ***
076600130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
076700101206     C                   EVAL      @STEP = 'STEP2'
076800101206     C                   LEAVESR
076900101206     C                   ENDIF
077000130520    ***
077100130520     C                   EVAL      @STEP = 'STEP4'
077200130315     C                   EVAL      TERM_LIF = NO
077300101210     C                   EVAL      TERM_DEN = NO
077400101210     C                   EVAL      TERM_MED = NO
077500101210    ***
077600130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
077700130520     C                   IF        L@TRM(L#CNE) <> 99999999
077800130520     C                   EXSR      $CHKHEM
077900130520     C                   ENDIF
078000130520     C                   LEAVESR
078100130520     C                   ENDIF
078200130520    ***
078300130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
078400130520     C                   IF        M@TRM(M#CNE) <> 99999999
078500130520     C                   EXSR      $CHKHEM
078600130520     C                   ENDIF
078700130520     C                   LEAVESR
078800130520     C                   ENDIF
078900130520    ***
079000130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
079100130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
079200130520     C                              M@TRM(M#CNE) <> 99999999)
079300130520     C                   EXSR      $CHKHEM
079400130520     C                   ENDIF
079500130520     C                   LEAVESR
079600130520     C                   ENDIF
079700130520    ***
079800130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
079900130520     C                   IF        D@TRM(D#CNE) <> 99999999
080000130520     C                   EXSR      $CHKHEM
080100130520     C                   ENDIF
080200130520     C                   LEAVESR
080300130520     C                   ENDIF
080400130520    ***
080500130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
080600130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
080700130520     C                              D@TRM(D#CNE) <> 99999999)
080800130520     C                   EXSR      $CHKHEM
080900130520     C                   ENDIF
081000130520     C                   LEAVESR
081100130520     C                   ENDIF
081200130520    ***
081300130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
081400130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
081500130520     C                              M@TRM(M#CNE) <> 99999999)
081600130520     C                   EXSR      $CHKHEM
081700130520     C                   ENDIF
081800130520     C                   LEAVESR
081900130520     C                   ENDIF
082000130520    ***
082100130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
082200130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
082300130520     C                              L@TRM(L#CNE) <> 99999999 OR
082400130520     C                              M@TRM(M#CNE) <> 99999999)
082500130520     C                   EXSR      $CHKHEM
082600130520     C                   ENDIF
082700130520     C                   LEAVESR
082800130520     C                   ENDIF
082900101214    ***
083000101214     C                   ENDSR
083100101214   S***S
083200101210    *** GENERATE MEMBER RECORD
083300101210    ***
083400101210     C     $STEP4        BEGSR
083500101210    ***
083600130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
083700101214     C                   EVAL      @STEP = 'STEP2'
083800101214     C                   LEAVESR
083900101214     C                   ENDIF
084000101214    ***
084100110513     C                   EVAL      WRT@TYPE = 'MEMBER'
084200110725    ***
084300130315     C                   EVAL      L@MBREFF = 0
084400110725     C                   EVAL      D@MBREFF = 0
084500110725     C                   EVAL      M@MBREFF = 0
084600110513    ***
084700101210     C                   EVAL      @SS1   = %EDITC(MBSSNO:'X')
084800101210     C                   EVAL      @SS2   = @SS1
084900101210     C                   MOVEL(P)  MLNAME        @LN
085000101210     C                   MOVEL(P)  MFNAME        @FN
085100101210     C                   EVAL      @MI    = MMI
085200101210     C                   EVAL      @REL   = '01'
085300101210     C                   EVAL      @SEX   = SEX
085400101210     C                   EVAL      @DOB   = %EDITC(BIRTH:'X')
085500101210     C                   IF        COB = 'Y'
085600101210     C                   EVAL      @COB   = 'Y'
085700101210     C                   EVAL      @COBC  = 'OT'
085800101210     C                   EVAL      @COBN  = MCOBPN
085900101210     C                   ENDIF
086000101210     C                   EVAL      @AD1   = %TRIM(ADDR1)
086100101210     C                   EVAL      @AD2   = %TRIM(ADDR2)
086200101210     C                   EVAL      @CTY   = %TRIM(CITY)
086300101210     C                   EVAL      @ST    = STATE
086400101210     C                   MOVE      *BLANKS       @9                9
086500101210     C                   EVAL      @9   = %EDITC(ZIP:'X')
086600101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
086700101210     C                   EVAL      @PHN   = %EDITC(AREA:'X') +
086800101210     C                                      %EDITC(PHONE:'X')
086900101210    ***
087000101210     C                   SELECT
087100101210     C                   WHEN      EMPST = 'A'
087200101210     C                   EVAL      @EMPST = 'AC'
087300101210     C                   WHEN      EMPST = 'C'
087400101210     C                   EVAL      @EMPST = 'CO'
087500101210     C                   WHEN      EMPST = 'R'
087600101210     C                   EVAL      @EMPST = 'RT'
087700101210     C                   ENDSL
087800101210    ***
087900101210     C                   EVAL      @HIRE  = %EDITC(EMPDT:'X')
088000101210    ***
088100141211     C                   SETOFF                                       888987
088200141120        IF KF@TRS = 770 AND KF@SUB = 004 AND KF@ACC = 0037 AND
088300141120          STATE = 'VT';
088400141120           *IN89 = *ON;
088500141120        ENDIF;
088600141211    *** IF KF@TRS = 591 AND KF@SUB = 001 AND KF@ACC = 0042 AND
088700141211    ***   STATE = 'TX';
088800141211    ***    *IN87 = *ON;
088900141211    *** ENDIF;
089000141120    ***
089100101210     C                   EXCEPT    MBRF
089200101214     C                   ADD       1             C#RECCNT
089300101213    ***
089400101213     C                   EVAL      @STEP = 'PREP5'
089500101210    ***
089600101210     C                   ENDSR
089700101210   S***S
089800130315    *** * * * * * MEDICAL
089900101214     C     $PREP5        BEGSR
090000101214    ***
090100101214     C                   IF        M#CNE = 0
090200110513     C                   EVAL      @STEP = 'PREP6'
090300101214     C                   LEAVESR
090400101214     C                   ENDIF
090500101214    ***
090600101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
090700130315     C                   EVAL      KF@ENR = M@ENR(M#CNE)
090800101214    ***
090900101214     C                   IF        TERM_MED = YES
090901240130       KF#TRM = M@TRM(M#CNE);
091000101214     C                   EXSR      $WRTERM
091100101214     C                   ENDIF
091200101214    ***
091300110512     C                   EVAL      @PLANIN = KF@PLN
091400120803    ***
091500200116     C     KL#TSAP       CHAIN     AEF04
091600200116     C                   IF        NOT %FOUND(AET004WF)
091700120803     C                   LEAVESR
091800120803     C                   ENDIF
091900120803    ***
092000111020     C                   EVAL      ENR@IN = M@ENR(M#CNE)
092100111020    ***
092200110802     C                   EXSR      $QUIK
092300110802    ***
092400110512     C                   EXSR      $PLANSRCH
092500110512    ***
092600110512     C                   IF        PLN@CAT = *BLANKS
092700101214     C                   SETON                                        H1
092800101214     C                   ENDIF
092900110512    ***
093000110513     C                   EVAL      @STEP = 'STEP5'
093100110725     C                   EVAL      #XSX = M@FRM(M#CNE)
093200110725     C                   EVAL      M@MBREFF = #XSX
093300101214    ***
093400101214     C                   ENDSR
093500101214   S***S
093600101214     C     $STEP5        BEGSR
093700101214    ***
093800160224     C                   IF        CPCID1 = 'VIS'
093900110513     C                   EXSR      $MEAWRT
094000110513     C                   ELSE
094100160224     C****               EXSR      $HMOWRT
094200110513     C                   ENDIF
094300110513    ***
094400101214     C                   ADD       1             C#RECCNT
094500101214     C                   ADD       1             B#RECCNT
094600110512    ***
094700110513     C                   EVAL      @STEP = 'PREP6'
094800110513    ***
094900110513     C                   ENDSR
095000110513   S***S
095100130315    *** DENTAL
095200130315    ***
095300101214     C     $PREP6        BEGSR
095400101213    ***
095500110513    *C                   IF        D#CNE = 0
095600130315    *C                   EVAL      @STEP = 'PREPC'
095700130315    *C*****************  EVAL      @STEP = 'PREP7'
095800110513    *C                   LEAVESR
095900110513    *C                   ENDIF
096000110512    ***
096100110513    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
096200130315    *C                   EVAL      KF@ENR = D@ENR(D#CNE)
096300130315    ***
096400200116     C     KL#TSAP       CHAIN     AEF04
096500200116     C                   IF        NOT %FOUND(AET004WF)
096600120803     C                   LEAVESR
096700120803     C                   ENDIF
096800110512    ***
096900110513    *C                   IF        TERM_DEN = YES
096901240130       KF#TRM = D@TRM(D#CNE);
097000110513    *C                   EXSR      $WRTERM
097100110513    *C                   ENDIF
097200110513    ***
097300110513     C                   EVAL      @PLANIN = KF@PLN
097400111020     C                   EVAL      ENR@IN = D@ENR(D#CNE)
097500110513    ***
097600111011     C                   EXSR      $QUIK
097700110513    ***
097800110513     C                   EXSR      $PLANSRCH
097900110513    ***
098000110513     C                   IF        PLN@CAT = *BLANKS
098100110513     C                   SETON                                        H2
098200110513     C                   ENDIF
098300110512    ***
098400110513    *C                   EVAL      @STEP = 'STEP6'
098500110725     C                   EVAL      #XSX = D@FRM(D#CNE)
098600110725     C                   EVAL      D@MBREFF = #XSX
098700110512    ***
098800101213     C                   ENDSR
098900110802   S***S
099000110513    *** DENTAL FORMAT
099100110513    ***
099200110513    *C     $STEP6        BEGSR
099300110513    ***
099400110513     C                   EXSR      $DENWRT
099500110513    ***
099600110513    *C                   ADD       1             C#RECCNT
099700110513    *C                   ADD       1             B#RECCNT
099800110513    ***
099900130315    *C****************** EVAL      @STEP = 'PREP7'
100000130315    *C                   EVAL      @STEP = 'PREPC'
100100110513    ***
100200110513    *C                   ENDSR
100300110513   S***S
100400130315    *** LIFE AND AD&D PLANS FOR MEMBER
100500130315    ***
100600130315     C     $PREPC        BEGSR
100700130315    ***
100800130315    *C                   IF        L#CNE = 0
100900130315    *C                   EVAL      @STEP = 'PREP7'
101000130315    *C                   LEAVESR
101100130315    *C                   ENDIF
101200130315    ***
101300130315    *C                   EVAL      KF#TRM = L@TRM(L#CNE)
101400130315    *C                   EVAL      KF@PLN = L@PLN(L#CNE)
101500130315     C                   EVAL      KF@ENR = L@ENR(L#CNE)
101600130315    ***
101700200116     C     KL#TSAP       CHAIN     AEF04
101800200116     C                   IF        NOT %FOUND(AET004WF)
101900130315     C                   LEAVESR
102000130315     C                   ENDIF
102100130315    ***
102200130315    *C                   IF        TERM_LIF = YES
102201240130       KF#TRM = L@TRM(L#CNE);
102300130315    *C                   EXSR      $WRTERM
102400130315    *C                   ENDIF
102500130315    ***
102600130315     C                   EVAL      @PLANIN = KF@PLN
102700130315     C                   EVAL      ENR@IN = L@ENR(L#CNE)
102800130315    ***
102900130315     C                   EXSR      $QUIK
103000130315    ***
103100130315     C                   EXSR      $PLANSRCH
103200130315    ***
103300130315     C                   IF        PLN@CAT = *BLANKS
103400130315     C                   SETON                                        H2
103500130315     C                   ENDIF
103600130315    ***
103700130315    *C                   EVAL      @STEP = 'STEPC'
103800130315     C                   EVAL      #XSX = L@FRM(L#CNE)
103900130315     C                   EVAL      L@MBREFF = #XSX
104000130315    ***
104100130315     C                   ENDSR
104200130315   S***S
104300130315    *** LIFE FORMAT
104400130315    ***
104500130315    *C     $STEPC        BEGSR
104600130315    ***
104700130315     C                   EXSR      $LIFWRT
104800130315    ***
104900130315    *C                   ADD       1             C#RECCNT
105000130315    *C                   ADD       1             B#RECCNT
105100130315    ***
105200130315    *C                   EVAL      @STEP = 'PREP7'
105300130315    ***
105400130315    *C                   ENDSR
105500130315   S***S
105600130315     C     $LIFWRT       BEGSR
105700130315    ***
105800130315    *C                   EVAL      X@LAY = CPCID1                               LAYOUT
105900130315    *C                   EVAL      X@ELR = CPCID2                               ELR
106000130315    *C                   EVAL      L@SFX = CPCID3                               SUFFIX
106100130315    *C                   EVAL      L@ACCT = CPCID4                              ACCOUNT
106200130315    *C                   EVAL      L@PLAN = CPCID5                              PLAN
106300130315    *C                   EVAL      L@CLM = CPCID6                               CLAIM OFFICE
106400130315    ***
106500130315    *C                   EVAL      #XSX = L@FRM(L#CNE)
106600130315     C                   MOVE      #XSX          X@EFF
106700130315    ***
106800130315    *C                   EVAL      #XSX = L@TRM(L#CNE)
106900130315    *C                   IF        #XSX = 0 OR #XSX = 99999999
107000130315    *C                   MOVE      *BLANKS       X@TRM
107100130315    *C                   ELSE
107200160809    *C****               MOVE      #XSX          X@TRM
107300160809       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
107400160809       if %subdt(work_date:*d) = 01 ;
107500160809        work_date -= %days(1) ;
107600160809        num_date = %dec(work_date:*iso);
107700160809        X@TRM = %EDITC(num_date:'X');
107800160809       endif;
107900160809
108000130315    *C                   ENDIF
108100140313    ***
108200140313     C                   MOVE      *BLANKS       L@CBREXP
108300140313     C                   MOVE      *BLANKS       L@CBREVT
108400140313     C                   MOVE      *BLANKS       L@CBRLEN
108500130315    ***
108600130923    *C                   IF        EMPST = 'C' AND
108700130923     C                             CEXPDT > 0
108800130315    *C                   MOVE      CEXPDT        L@CBREXP
108900130315    *C                   MOVE      QEDT          L@CBREVT
109000130315    *C                   MOVE      CEXPDT        #MINUEND
109100130315    *C                   MOVE      QEDT          #SUBTRAEND
109200130315    *C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
109300130315    *C                   Z-ADD     #DIFFRNC      #2S0
109400130315    *C                   MOVE      #2S0          L@CBRLEN
109500130315    *C                   ENDIF
109600130315    ***
109700130315     C                   EVAL      L@SALARY = %EDITC(SALARY:'4')
109800130315    ***
109900130315    *C                   EXCEPT    LIFF
110000130315    ***
110100130315    *C                   ENDSR
110200130315   S***S
110300101214     C     $PREP7        BEGSR
110400101214    ***
110500101214     C     KF@SSN        CHAIN     DEPENR
110600101214     C                   IF        NOT %FOUND(DEPNDC)
110700101214     C                   EVAL      @STEP = 'STEP2'
110800101214     C                   LEAVESR
110900101214     C                   ENDIF
111000101214    ***
111100101214     C     KF@SSN        SETLL     DEPENR
111200101214    ***
111300101214     C                   EVAL      @STEP = 'STEP7'
111400101214    ***
111500101214     C                   ENDSR
111600101210   S***S
111700101214     C     $STEP7        BEGSR
111800101214    ***
111900101214     C     KF@SSN        READE     DEPENR
112000101214    ***
112100101214     C                   IF        %EOF(DEPNDC)
112200101214     C                   EVAL      @STEP = 'STEP2'
112300101214     C                   LEAVESR
112400101214     C                   ENDIF
112500101214    ***
112600101214     C                   EVAL      KF@SEQ = DPSEQ#
112700120803     C                   EVAL      WRT@TYPE = 'DEPEND'
112800101214    ***
112900101214     C     KL#DCV        CHAIN     DCOVR
113000101214     C                   IF        NOT %FOUND(DCOVA)
113100101214     C                   LEAVESR
113200101214     C                   ENDIF
113300101214    ***
113400101214     C                   EXSR      $CLRDCV
113500101214     C     KL#DCV        SETLL     DCOVR
113600101214    ***
113700101214     C                   EVAL      @STEP = 'STEP8'
113800101214    ***
113900101214     C                   ENDSR
114000101214   S***S
114100101214     C     $STEP8        BEGSR
114200101214    ***
114300101214     C     KL#DCV        READE     DCOVR
114400101214    ***
114500101214     C                   IF        %EOF(DCOVA)
114600101214     C                   EVAL      @STEP = 'PREP9'
114700101214     C                   LEAVESR
114800101214     C                   ENDIF
114900101214    ***
115000130131    *C*                  IF        DENRDT = CCANDT
115100130131    *C*                  LEAVESR
115200130131    *C*                  ENDIF
115300110513    ***
115400110513     C                   EVAL      @PLANIN = DVPLAN
115500120803     C                   EVAL      KF@PLN = DVPLAN
115600200116     C     KL#TSAP       CHAIN     AEF04
115700200116     C                   IF        NOT %FOUND(AET004WF)
115800120803     C                   LEAVESR
115900120803     C                   ENDIF
116000110802    ***
116100110802     C                   EXSR      $QUIKD
116200110802    ***
116300110513     C                   EXSR      $PLANSRCH
116400110513    ***
116500110513     C                   IF        PLN@CAT = *BLANKS
116600110513     C                   LEAVESR
116700110513     C                   ENDIF
116800101214    ***
116900101214     C                   EVAL      #CANCEL = CCANDT
117000101214     C                   IF        #CANCEL = 0
117100101214     C                   EVAL      #CANCEL = 99999999
117200101214     C                   ENDIF
117300101214    ***
117400130315    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL; LIFE IS MEMBER ONLY
117500110513    ***
117600160224    *C****               IF        PLN@CAT = 'DEN'
117700160224    *C****               IF        D#CNE > 0
117800160224    *C****               IF        D@TRM(D#CNE) = 99999999
117900160224     C****               LEAVESR
118000160224     C****               ENDIF
118100160224     C****               ENDIF
118200160224    *C****               ADD       1             D#CNE
118300160224    *C****               EVAL      D@PLN(D#CNE) = DVPLAN
118400160224    *C****               EVAL      D@ENR(D#CNE) = *BLANKS
118500160224    *C****               EVAL      D@FRM(D#CNE) = DENRDT
118600160224    *C****               EVAL      D@TRM(D#CNE) = #CANCEL
118700160224    *C****               ELSE
118800130131    *C                   IF        M#CNE > 0
118900130131    *C                   IF        M@TRM(M#CNE) = 99999999
119000130131     C                   LEAVESR
119100130131     C                   ENDIF
119200130131     C                   ENDIF
119300101214     C                   ADD       1             M#CNE
119400101214     C                   EVAL      M@PLN(M#CNE) = DVPLAN
119500101214     C                   EVAL      M@ENR(M#CNE) = *BLANKS
119600101214     C                   EVAL      M@FRM(M#CNE) = DENRDT
119700101214     C                   EVAL      M@TRM(M#CNE) = #CANCEL
119800160224    *C****               ENDIF
119900101214    ***
120000101214     C                   ENDSR
120100101214   S***S
120200111011     C     $QUIKD        BEGSR
120300111011    ***
120400120803     C                   EXSR      $QUIK
120500120409    ***
120600120409     C                   ENDSR
120700111011   S***S
120800101214     C     $PREP9        BEGSR
120900101214    ***
121000101214     C                   IF        D#CNE = 0 AND M#CNE = 0
121100101214     C                   EVAL      @STEP = 'STEP7'
121200101214     C                   LEAVESR
121300101214     C                   ENDIF
121400101214    ***
121500130315     C                   EVAL      L#CNE = 0
121600130315     C                   EVAL      TERM_LIF = NO
121700101214     C                   EVAL      TERM_DEN = NO
121800101214     C                   EVAL      TERM_MED = NO
121900130520     C                   EVAL      @STEP = 'STEP9'
122000101214    ***
122100130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
122200130520     C                   IF        L@TRM(L#CNE) <> 99999999
122300130520     C                   EXSR      $CHKHEM
122400130520     C                   ENDIF
122500130520     C                   LEAVESR
122600130520     C                   ENDIF
122700130520    ***
122800130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
122900130520     C                   IF        M@TRM(M#CNE) <> 99999999
123000130520     C                   EXSR      $CHKHEM
123100130520     C                   ENDIF
123200130520     C                   LEAVESR
123300130520     C                   ENDIF
123400130520    ***
123500130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
123600130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
123700130520     C                              M@TRM(M#CNE) <> 99999999)
123800130520     C                   EXSR      $CHKHEM
123900130520     C                   ENDIF
124000130520     C                   LEAVESR
124100130520     C                   ENDIF
124200130520    ***
124300130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
124400130520     C                   IF        D@TRM(D#CNE) <> 99999999
124500130520     C                   EXSR      $CHKHEM
124600130520     C                   ENDIF
124700130520     C                   LEAVESR
124800130520     C                   ENDIF
124900130520    ***
125000130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
125100130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
125200130520     C                              D@TRM(D#CNE) <> 99999999)
125300130520     C                   EXSR      $CHKHEM
125400130520     C                   ENDIF
125500130520     C                   LEAVESR
125600130520     C                   ENDIF
125700130520    ***
125800130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
125900130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
126000130520     C                              M@TRM(M#CNE) <> 99999999)
126100130520     C                   EXSR      $CHKHEM
126200130520     C                   ENDIF
126300130520     C                   LEAVESR
126400130520     C                   ENDIF
126500130520    ***
126600130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
126700130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
126800130520     C                              L@TRM(L#CNE) <> 99999999 OR
126900130520     C                              M@TRM(M#CNE) <> 99999999)
127000130520     C                   EXSR      $CHKHEM
127100130520     C                   ENDIF
127200130520     C                   LEAVESR
127300130520     C                   ENDIF
127400101214    ***
127500101214     C                   ENDSR
127600101214   S***S
127700101210    *** GENERATE DEPENDENT RECORD
127800101210    ***
127900101214     C     $STEP9        BEGSR
128000101210    ***
128100110513     C                   EVAL      WRT@TYPE = 'DEPEND'
128200110513    ***
128300110513     C                   IF        D#CNE = 0 AND M#CNE = 0
128400110513     C                   EVAL      @STEP = 'STEP7'
128500110513     C                   LEAVESR
128600110513     C                   ENDIF
128700110513    ***
128800101214     C                   EVAL      @SS2   = %EDITC(DEPSS#:'X')
128900101210     C                   MOVEL(P)  DLNAME        @LN
129000101210     C                   MOVEL(P)  DFNAME        @FN
129100101210     C                   EVAL      @MI    = DMI
129200101210    ***
129300101210     C                   SELECT
129400101210     C                   WHEN      DRELCD = 'RWI'
129500101210     C                   EVAL      @REL   = '02'
129600101210     C                   WHEN      DRELCD = 'RHU'
129700101210     C                   EVAL      @REL   = '03'
129800101210     C                   WHEN      DRELCD = 'RSO'
129900101210     C                   EVAL      @REL   = '04'
130000101210     C                   WHEN      DRELCD = 'RDA'
130100101210     C                   EVAL      @REL   = '05'
130200130218     C                   WHEN      DRELCD = 'RPA'
130300130218     C                   EVAL      @REL   = '14'
130400130225     C                   OTHER
130500130225     C                   EVAL      @REL   = *BLANKS
130600101210     C                   ENDSL
130700101210    ***
130800101210     C                   SELECT
130900101210     C                   WHEN      DSTUDN = 'Y'
131000101210     C                   EVAL      @SPEC = '1'
131100140812     C                   WHEN      DHNDCP = '3'
131200101210     C                   EVAL      @SPEC = '3'
131300130225     C                   OTHER
131400130225     C                   EVAL      @SPEC = *BLANKS
131500101210     C                   ENDSL
131600101210    ***
131700101210     C                   EVAL      @SEX   = DSEX
131800101210     C                   EVAL      @DOB   = %EDITC(DBIRTH:'X')
131900130225    ***
132000101210     C                   IF        DCOB = 'Y'
132100101210     C                   EVAL      @COB   = 'Y'
132200101210     C                   EVAL      @COBC  = 'OT'
132300101210     C                   EVAL      @COBN  = DCOBPN
132400130225     C                   ELSE
132500130225     C                   EVAL      @COB   = *BLANKS
132600130225     C                   EVAL      @COBC  = *BLANKS
132700130225     C                   EVAL      @COBN = *BLANKS
132800101210     C                   ENDIF
132900101214    ***
133000101214     C                   IF        DADDR1 <> ADDR1
133100101210     C                   EVAL      @AD1   = %TRIM(DADDR1)
133200101210     C                   EVAL      @AD2   = %TRIM(DADDR2)
133300101210     C                   EVAL      @CTY   = %TRIM(DCITY)
133400101210     C                   EVAL      @ST    = DSTATE
133500101210     C                   MOVE      *BLANKS       @9                9
133600101214     C                   IF        DZIP = 0
133700101214     C                   EVAL      @9   = %EDITC(ZIP:'X')
133800101214     C                   ELSE
133900101210     C                   EVAL      @9   = %EDITC(DZIP:'X')
134000101214     C                   ENDIF
134100101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
134200101210     C                   EVAL      @PHN   = %EDITC(DAREA:'X') +
134300101210     C                                      %EDITC(DPHONE:'X')
134400101214     C                   ENDIF
134500141120    ***
134600101210     C                   EXCEPT    MBRF
134700101214     C                   ADD       1             C#RECCNT
134800101214    ***
134900101214     C                   EVAL      @STEP = 'PREPA'
135000101210    ***
135100101210     C                   ENDSR
135200101210   S***S
135300101214     C     $PREPA        BEGSR
135400101214    ***
135500101214     C                   IF        M#CNE = 0
135600101214     C                   EVAL      @STEP = 'PREPB'
135700101214     C                   LEAVESR
135800101214     C                   ENDIF
135900101214    ***
136000101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
136100200116     C     KL#TSAP       CHAIN     AEF04
136200200116     C                   IF        NOT %FOUND(AET004WF)
136300120803     C                   LEAVESR
136400120803     C                   ENDIF
136500101214    ***
136600101214     C                   IF        TERM_MED = YES
136601240130       KF#TRM = M@TRM(M#CNE);
136700101214     C                   EXSR      $WRTERM
136800101214     C                   ENDIF
136900101214    ***
137000110513     C                   EVAL      @PLANIN = KF@PLN
137100110802    ***
137200110802     C                   EXSR      $QUIKD
137300110802    ***
137400110513     C                   EXSR      $PLANSRCH
137500110513    ***
137600110513     C                   IF        PLN@CAT = *BLANKS
137700110513     C                   SETON                                        H2
137800110513     C                   ENDIF
137900110513    ***
138000110513     C                   EVAL      @STEP = 'STEPA'
138100110513    ***
138200101214     C                   ENDSR
138300101214   S***S
138400101214     C     $STEPA        BEGSR
138500101214    ***
138600160224     C                   IF        CPCID1 = 'VIS'
138700110513     C                   EXSR      $MEAWRT
138800110513     C                   ELSE
138900160224     C****               EXSR      $HMOWRT
139000110513     C                   ENDIF
139100110513    ***
139200110513     C                   ADD       1             C#RECCNT
139300110513     C                   ADD       1             B#RECCNT
139400110513    ***
139500110513     C                   EVAL      @STEP = 'PREPB'
139600110513    ***
139700110513     C                   ENDSR
139800110513   S***S
139900101214     C     $PREPB        BEGSR
140000101214    ***
140100110513    *C                   IF        D#CNE = 0
140200110513    *C                   EVAL      @STEP = 'STEP7'
140300110513    *C                   LEAVESR
140400110513    *C                   ENDIF
140500101214    ***
140600110513    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
140700200116     C     KL#TSAP       CHAIN     AEF04
140800200116     C                   IF        NOT %FOUND(AET004WF)
140900120803     C                   LEAVESR
141000120803     C                   ENDIF
141100110513    ***
141200110513    *C                   IF        TERM_DEN = YES
141201240130       KF#TRM = D@TRM(D#CNE);
141300110513    *C                   EXSR      $WRTERM
141400110513    *C                   ENDIF
141500110513    ***
141600110513     C                   EVAL      @PLANIN = KF@PLN
141700110513    ***
141800110802     C                   EXSR      $QUIKD
141900110513    ***
142000110513     C                   EXSR      $PLANSRCH
142100110513    ***
142200110513     C                   IF        PLN@CAT = *BLANKS
142300110513     C                   SETON                                        H2
142400110513     C                   ENDIF
142500110513    ***
142600101214     C                   EVAL      @STEP = 'STEPB'
142700101214    ***
142800101214     C                   ENDSR
142900101214   S***S
143000110513    *C     $STEPB        BEGSR
143100110513    ***
143200110513     C                   EXSR      $DENWRT
143300110513    ***
143400110513    *C                   ADD       1             C#RECCNT
143500110513    *C                   ADD       1             B#RECCNT
143600110513    ***
143700110513    *C                   EVAL      @STEP = 'STEP7'
143800110513    ***
143900110513    *C                   ENDSR
144000101210   S***S
144100110512     C     *INZSR        BEGSR
144200200116
144300200116     C     *entry        plist
144400200116     C                   parm                    CARR#CTL
144500200116     C                   parm                    grouper
144600200116     C****               parm                    p_trust
144700200116     C****               parm                    p_sub#
144800200116     C****               parm                    p_acct
144900200116     C
145000110512     C     KL#ACCTL      KLIST
145100120803     C                   KFLD                    KF@CCTL
145200110512     C                   KFLD                    KF@TRS
145300110512     C                   KFLD                    KF@SUB
145400110512     C                   KFLD                    KF@ACC
145500140313    ***
145600140313     C     KL#SQPCD      KLIST
145700140313     C                   KFLD                    KF@SSN
145800140313     C                   KFLD                    KF@SEQ
145900140313     C                   KFLD                    KF@SPCD
146000120803    ***
146100120803     C     KL#TSAP       KLIST
146200120803     C                   KFLD                    KF@TRS
146300120803     C                   KFLD                    KF@SUB
146400120803     C                   KFLD                    KF@ACC
146500120803     C                   KFLD                    KF@PLN
146600110512    ***
146700110512     C     KL#TSA        KLIST
146800110512     C                   KFLD                    KF@TRS
146900110512     C                   KFLD                    KF@SUB
147000110512     C                   KFLD                    KF@ACC
147100110512    ***
147200110512     C     KL#MPLN       KLIST
147300110512     C                   KFLD                    KF@SSN
147400110512     C                   KFLD                    KF@SEQ
147500110512     C                   KFLD                    KF@TRS
147600110512     C                   KFLD                    KF@SUB
147700110512     C                   KFLD                    KF@ACC
147800110512    ***
147900110512     C     KL#CPLN       KLIST
148000120803     C                   KFLD                    KF@CCTL
148100110512     C                   KFLD                    KF@TRS
148200110512     C                   KFLD                    KF@SUB
148300110512     C                   KFLD                    KF@ACC
148400110512     C                   KFLD                    KF@CCTR
148500110512     C                   KFLD                    KF@PLN
148600110512    ***
148700110512     C     KL#DCV        KLIST
148800110512     C                   KFLD                    KF@SSN
148900110512     C                   KFLD                    KF@SEQ
149000110512    ***
149100110512     C     KL#MTR        KLIST
149200110512     C                   KFLD                    KF@SSN
149300110512     C                   KFLD                    KF@SEQ
149400110512     C                   KFLD                    KF#TRM
149500110512     C                   KFLD                    KF@PLN
149600110512     C                   KFLD                    KF@ENR
149700110512     C                   KFLD                    KF@TRS
149800110512     C                   KFLD                    KF@SUB
149900110512     C                   KFLD                    KF@ACC
150000110512    ***
150100110512     C     KL#PCP        KLIST
150200110512     C                   KFLD                    KF@SSN
150300110512     C                   KFLD                    KF@SEQ
150400110512    ***
150500110512     C                   EVAL      #ISO = %DATE
150600110512     C                   MOVE      #ISO          #TODAY            8 0
150700110512     C                   EVAL      #IST = %TIME
150800110512     C                   MOVE      #ISO          #XSX
150900110512     C                   MOVE      #XSX          @DATE
151000110512     C                   MOVE      #IST          #XST
151100110512     C                   MOVE      #XST          @TIME
151200110512    ***
151300110512     C                   ENDSR
151400110512   S***S
151500110513    *** PLANS LOADED BY ACCOUNT
151600110513    ***
151700110513     C     $PLANLOAD     BEGSR
151800110513    ***
151900110513     C                   EVAL      PP# = 0
152000140313     C                   DO        80
152100110513     C                   ADD       1             PP#
152200110513     C     PP#           OCCUR     CARPLN@
152300110513     C                   CLEAR                   CARPLN@
152400110513     C                   ENDDO
152500110513     C                   EVAL      PC# = 0
152600110513     C                   EVAL      PP# = 0
152700110513    ***
152800110513     C     KL#ACCTL      SETLL     CARPLNR
152900110513     C                   DOU       %EOF(CARPLNP)
153000110513     C     KL#ACCTL      READE     CARPLNR
153100110520     C                   IF        NOT %EOF(CARPLNP)
153200200116       if cpcid1 = 'VIS';
153300110513     C                   ADD       1             PC#
153400110513     C     PC#           OCCUR     CARPLN@
153500110513     C                   EVAL      CARPLN@ = DS@CARPLN
153600200116       endif;
153700200116
153800110513    ***
153900110513     C                   ENDIF
154000110513     C                   ENDDO
154100110513    ***
154200110513     C                   ENDSR
154300110513   S***S
154400110513     C     $CLRSTG       BEGSR
154500110513    ***
154600110513     C                   EVAL      #CANCEL = 0
154700130315    ***
154800130315     C                   EVAL      L#CNE = 0
154900130315     C                   CLEAR                   L@PLN
155000130315     C                   CLEAR                   L@ENR
155100130315     C                   CLEAR                   L@FRM
155200130315     C                   CLEAR                   L@TRM
155300130315    ***
155400110513     C                   EVAL      D#CNE = 0
155500110513     C                   CLEAR                   D@PLN
155600110513     C                   CLEAR                   D@ENR
155700110513     C                   CLEAR                   D@FRM
155800110513     C                   CLEAR                   D@TRM
155900110513     C                   EVAL      M#CNE = 0
156000110513     C                   CLEAR                   M@PLN
156100110513     C                   CLEAR                   M@ENR
156200110513     C                   CLEAR                   M@FRM
156300110513     C                   CLEAR                   M@TRM
156400110513    ***
156500110513     C                   EXSR      $CLRDMG
156600110513    ***
156700110513     C                   ENDSR
156800110513   S***S
156900110513     C     $CLRDMG       BEGSR
157000110513    ***
157100110513     C                   EVAL      @SS1   = *BLANKS
157200110513     C                   EVAL      @SS2   = *BLANKS
157300110513     C                   MOVE      *BLANKS       @LN
157400110513     C                   MOVEL     *BLANKS       @FN
157500110513     C                   EVAL      @MI    = *BLANKS
157600110513     C                   EVAL      @REL   = *BLANKS
157700110513     C                   EVAL      @SEX   = *BLANKS
157800110513     C                   EVAL      @DOB   = *BLANKS
157900110513     C                   EVAL      @SPEC  = *BLANKS
158000110513     C                   EVAL      @COB   = *BLANKS
158100110513     C                   EVAL      @COBC  = *BLANKS
158200110513     C                   EVAL      @COBN  = *BLANKS
158300110513     C                   EVAL      @AD1   = *BLANKS
158400110513     C                   EVAL      @AD2   = *BLANKS
158500110513     C                   EVAL      @CTY   = *BLANKS
158600110513     C                   EVAL      @ST    = *BLANKS
158700110513     C                   EVAL      @ZP5   = *BLANKS
158800110513     C                   EVAL      @PHN   = *BLANKS
158900110513     C                   EVAL      @EMPST = *BLANKS
159000110513     C                   EVAL      @HIRE  = *BLANKS
159100110513    ***
159200110513     C                   ENDSR
159300110513   S***S
159400110513     C     $CHKHEM       BEGSR
159500110513    ***
159600130315    *C                   IF        L#CNE > 0 AND L@TRM(L#CNE) <> 99999999
159700130315    *C                   EXSR      $CHKLIF
159800130315    *C                   ENDIF
159900130315      *
160000110513    *C                   IF        D#CNE > 0 AND D@TRM(D#CNE) <> 99999999
160100110513    *C                   EXSR      $CHKDEN
160200110513    *C                   ENDIF
160300110513      *
160400110513     C                   IF        M#CNE > 0 AND M@TRM(M#CNE) <> 99999999
160500110513     C                   EXSR      $CHKMED
160600110513     C                   ENDIF
160700110513    ***
160800110513     C                   ENDSR
160900110513   S***S
161000130315    *C     $CHKLIF       BEGSR
161100130315    ***
161200130315    *C                   EVAL      TERM_LIF = YES
161300130315    *C                   EVAL      KF#TRM = L@TRM(L#CNE)
161400130315    *C                   EVAL      KF@PLN = L@PLN(L#CNE)
161500130315    *C                   EVAL      KF@ENR = L@ENR(L#CNE)
161600130315    ***
161700200116    *C     KL#MTR        CHAIN     AETGENTR
161800200116    *C                   IF        %FOUND(AETGENTRM)
161900130315    *C                   EVAL      L#CNE = 0
162000130315    *C                   EVAL      TERM_LIF = NO
162100130315    *C                   ENDIF
162200130315    ***
162300130315    *C                   ENDSR
162400130315   S***S
162500110513    *C     $CHKDEN       BEGSR
162600110513    ***
162700110513    *C                   EVAL      TERM_DEN = YES
162800110513    *C                   EVAL      KF#TRM = D@TRM(D#CNE)
162900110513    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
163000110513    *C                   EVAL      KF@ENR = D@ENR(D#CNE)
163100110513    ***
163200200116    *C     KL#MTR        CHAIN     AETGENTR
163300200116    *C                   IF        %FOUND(AETGENTRM)
163400110513    *C                   EVAL      D#CNE = 0
163500110513    *C                   EVAL      TERM_DEN = NO
163600110513    *C                   ENDIF
163700110513    ***
163800110513    *C                   ENDSR
163900110513   S***S
164000110513     C     $CHKMED       BEGSR
164100110513    ***
164200110513     C                   EVAL      TERM_MED = YES
164300110513     C                   EVAL      KF#TRM = M@TRM(M#CNE)
164400110513     C                   EVAL      KF@PLN = M@PLN(M#CNE)
164500110513     C                   EVAL      KF@ENR = M@ENR(M#CNE)
164600110513      *
164700200116     C     KL#MTR        CHAIN     AETGENTR
164800200116     C                   IF        %FOUND(AETGENTRM)
164900110513     C                   EVAL      TERM_MED = NO
165000110513     C                   EVAL      M#CNE = 0
165100110513     C                   ENDIF
165200110513    ***
165300110513     C                   ENDSR
165400110513   S***S
165500110513     C     $PLANSRCH     BEGSR
165600110513    ***
165700130315     C                   MOVE      *BLANKS       PLN@CAT           5
165800110513     C                   EVAL      PP# = 0
165900110513     C                   CLEAR                   DS@CARPLN
166000110513    ***
166100110513     C                   DO        PC#
166200110513    * *
166300110513     C                   ADD       1             PP#
166400110513     C     PP#           OCCUR     CARPLN@
166500110513    * *
166600110513     C                   IF        XPPLAN = @PLANIN AND
166700110513     C                             XPCCTR = @CCTRIN
166800110513     C                   EVAL      DS@CARPLN = CARPLN@
166900110513     C                   LEAVE
167000110513     C                   ENDIF
167100110513    * *
167200110513     C                   ENDDO
167300110513    ***
167400110513     C                   IF        CPPLAN = *BLANKS
167500110513     C                   LEAVESR
167600110513     C                   ENDIF
167700110513    ***
167800110513     C                   SELECT
167900160224     C                   WHEN      CPCID1 = 'VIS'
168000160224     C                   EVAL      PLN@CAT = 'VIS'
168100160224     C****                         CPCID1 = 'HMO'
168200160224     C****               EVAL      PLN@CAT = 'MED'
168300160224     C****               WHEN      CPCID1 = 'LIFE'
168400160224     C****               EVAL      PLN@CAT = 'LIFE'
168500160224     C****               WHEN      CPCID1 = 'DEN'
168600160224     C****               EVAL      PLN@CAT = 'DEN'
168700110513     C                   ENDSL
168800110513    ***
168900110513     C                   ENDSR
169000110513   S***S
169100110513     C     $ENROLL       BEGSR
169200110513    ***
169300110513     C                   EVAL      ENR@OUT = *BLANKS
169400110513     C                   SELECT
169500110513     C                   WHEN      ENR@IN = 'TIN' OR ENR@IN = 'TMI'
169600110513     C                   EVAL      ENR@OUT = 'S'
169700110513     C                   WHEN      ENR@IN = 'THW'
169800110513     C                   EVAL      ENR@OUT = 'C'
169900110513     C                   WHEN      ENR@IN = 'TPC'
170000110513     C                   EVAL      ENR@OUT = 'P'
170100110513     C                   WHEN      ENR@IN = 'TP2'
170200110513     C                   EVAL      ENR@OUT = 'Q'
170300110513     C                   WHEN      ENR@IN = 'TFA'
170400110513     C                   EVAL      ENR@OUT = 'F'
170500110513     C                   ENDSL
170600110513    ***
170700110513     C                   ENDSR
170800110513   S***S
170900110513     C     $WRTERM       BEGSR
171000110513    ***
171100200116     C                   CLEAR                   AETGENTR
171200110513     C                   EVAL      NTSSNO         = KF@SSN
171300110513     C                   EVAL      NTDEPNO        = KF@SEQ
171400110513     C                   EVAL      NTTERMDT       = KF#TRM
171500110513     C                   EVAL      NTPLAN         = KF@PLN
171600110513     C                   EVAL      NTCOVTP        = KF@ENR
171700110513     C                   EVAL      NTTRST         = KF@TRS
171800110513     C                   EVAL      NTSUB#         = KF@SUB
171900110513     C                   EVAL      NTACCT         = KF@ACC
172000110513     C                   EVAL      NTTRANSDT      = #TODAY
172100200227     C                   WRITE     AETGENTR
172200110513    ***
172300110513     C                   ENDSR
172400110513   S***S
172500110513     C     $HMOWRT       BEGSR
172600110513    ***
172700110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
172800110513     C                   EVAL      X@ELR = CPCID2                               FILE NUMBER
172900110513     C                   EVAL      M@CC = CACID2                                COMPANY CODE
173000110513     C                   EVAL      M@CLASS = CPCID3                             CLASS CODE
173100110513     C                   EVAL      M@PLAN = CPCID4                              PLAN NUMBER
173200110513    ***
173300110513     C                   EVAL      #XSX = M@FRM(M#CNE)
173400110725     C                   IF        WRT@TYPE = 'DEPEND' AND
173500110725     C                             #XSX < M@MBREFF
173600110725     C                   MOVE      M@MBREFF      X@EFF
173700110725     C                   ELSE
173800110725     C                   MOVE      #XSX          X@EFF
173900110725     C                   ENDIF
174000110513    ***
174100110513     C                   EVAL      #XSX = M@TRM(M#CNE)
174200110513     C                   IF        #XSX = 0 OR #XSX = 99999999
174300110513     C                   MOVE      *BLANKS       X@TRM
174400110513     C                   ELSE
174500240130     C                   MOVE      #XSX          X@TRM
174507240130
174600160809       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
174700160809       if %subdt(work_date:*d) = 01 ;
174800160809        work_date -= %days(1) ;
174900160809        num_date = %dec(work_date:*iso);
175000160809        X@TRM = %EDITC(num_date:'X');
175100160809       endif;
175200160809
175300110513     C                   ENDIF
175400110513    ***
175500110513     C                   IF        WRT@TYPE = 'MEMBER'
175600110513     C                   EVAL      KF@SEQ = 0
175700110513     C                   EVAL      ENR@IN = M@ENR(M#CNE)
175800110513     C                   EXSR      $ENROLL
175900110513     C                   EVAL      X@TIER = ENR@OUT
176000110513     C                   ELSE
176100110513     C                   EVAL      X@TIER = *BLANKS
176200110513     C                   ENDIF
176300110513    ***
176400140313     C                   EVAL      KF@SPCD = 'MED'
176500140313     C                   EVAL      M@PCP = *BLANKS
176600140313     C                   EVAL      M@NPI = *BLANKS
176700140313     C                   EVAL      M@PCPCI = *BLANKS
176800140313    ***
176900140313     C                   EXSR      $PCP
177000140313    ***
177100140313     C                   IF        DOCTOR <> *BLANKS
177200140313     C                   EVAL      M@PCP = DOCTOR
177300140313     C                   EVAL      M@NPI = 'Y'
177400140313     C                   EVAL      M@PCPCI = '0'
177500140313     C                   ENDIF
177600110513    ***
177700110513     C                   EXCEPT    HMOF
177800110513    ***
177900110513     C                   ENDSR
178000110513   S***S
178100110513     C     $MEAWRT       BEGSR
178200110513    ***
178300110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
178400110513     C                   EVAL      X@ELR = CPCID2                               ELR
178500140313     C                   EVAL      E@SFX = CPCID3                               SUFFIX
178600140313     C                   EVAL      E@ACCT = CPCID4                              ACCOUNT
178700140313     C                   EVAL      E@PLAN = CPCID5                              PLAN
178800140313     C                   EVAL      E@CLM = CPCID6                               CLAIM OFFICE
178900110513    ***
179000110513     C                   EVAL      #XSX = M@FRM(M#CNE)
179100110725     C                   IF        WRT@TYPE = 'DEPEND' AND
179200110725     C                             #XSX < M@MBREFF
179300110725     C                   MOVE      M@MBREFF      X@EFF
179400110725     C                   ELSE
179500110725     C                   MOVE      #XSX          X@EFF
179600110725     C                   ENDIF
179700110513    ***
179800110513     C                   EVAL      #XSX = M@TRM(M#CNE)
179900110513     C                   IF        #XSX = 0 OR #XSX = 99999999
180000110513     C                   MOVE      *BLANKS       X@TRM
180100110513     C                   ELSE
180200240130     C                   MOVE      #XSX          X@TRM
180207240130
180300160809       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
180400160809       if %subdt(work_date:*d) = 01 ;
180500160809        work_date -= %days(1) ;
180600160809        num_date = %dec(work_date:*iso);
180700160809        X@TRM = %EDITC(num_date:'X');
180800160809       endif;
180900160809
181000110513     C                   ENDIF
181100110513    ***
181200140313     C                   MOVE      *BLANKS       E@CBREXP
181300140313     C                   MOVE      *BLANKS       E@CBREVT
181400140313     C                   MOVE      *BLANKS       E@CBRLEN
181500140313     C                   IF        WRT@TYPE = 'MEMBER'
181600140425     C                   IF        EMPST = 'C' AND
181700140425     C                             CEXPDT > 0
181800140313     C                   MOVE      CEXPDT        E@CBREXP
181900140313     C                   MOVE      QEDT          E@CBREVT
182000140313     C                   MOVE      CEXPDT        #MINUEND
182100140313     C                   MOVE      QEDT          #SUBTRAEND
182200140313     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
182300140313     C                   Z-ADD     #DIFFRNC      #2S0
182400140313     C                   MOVE      #2S0          E@CBRLEN
182500140313     C                   ENDIF
182600140313     C                   ENDIF
182700140313    ***
182800140313     C                   EVAL      *IN80 = *OFF
182900140313     C                   EVAL      KF@SPCD = 'MED'
183000140313     C                   EVAL      E@PCP = *BLANKS
183100140313     C                   EXSR      $PCP
183200140313     C                   IF        DOCTOR <> *BLANKS
183300140313     C                   EVAL      E@PCP = DOCTOR
183400140313     C                   EVAL      *IN80 = *ON
183500140313     C                   ENDIF
183600140313    ***
183700140313     C                   EXCEPT    MEAF
183800110513    ***
183900110513     C                   ENDSR
184000110513   S***S
184100140313     C     $PCP          BEGSR
184200140313    ***
184300140313     C                   MOVE      *BLANKS       DOCTOR            7
184400140313     C     KL#SQPCD      CHAIN     PCPR
184500140313     C                   IF        NOT %FOUND(PCPL1)
184600140313     C                   LEAVESR
184700140313     C                   ENDIF
184800140313     C     KL#SQPCD      SETLL     PCPR
184900140313     C                   DOU       %EOF(PCPL1)
185000140313     C     KL#SQPCD      READE     PCPR
185100140313     C                   IF        NOT %EOF(PCPL1) AND PCCAN = 0
185200140313     C                   MOVEL(P)  PCID#         DOCTOR
185300140313     C                   LEAVESR
185400140313     C                   ENDIF
185500140313     C                   ENDDO
185600140313    ***
185700140313     C                   ENDSR
185800140313   S***S
185900110513     C     $CLRDCV       BEGSR
186000110513    ***
186100110513     C                   MOVE      *BLANKS       @LN
186200110513     C                   MOVEL     *BLANKS       @FN
186300110513     C                   EVAL      @SS2   = *BLANKS
186400110513     C                   EVAL      @MI    = *BLANKS
186500110513     C                   EVAL      @REL   = *BLANKS
186600110513     C                   EVAL      @SEX   = *BLANKS
186700110513     C                   EVAL      @DOB   = *BLANKS
186800110513     C                   EVAL      @SPEC  = *BLANKS
186900110513     C                   EVAL      @COB   = *BLANKS
187000110513     C                   EVAL      @COBC  = *BLANKS
187100110513     C                   EVAL      @COBN  = *BLANKS
187200110513    ***
187300110513     C                   EVAL      #CANCEL = 0
187400110513     C                   EVAL      D#CNE = 0
187500110513     C                   CLEAR                   D@PLN
187600110513     C                   CLEAR                   D@ENR
187700110513     C                   CLEAR                   D@FRM
187800110513     C                   CLEAR                   D@TRM
187900110513     C                   EVAL      M#CNE = 0
188000110513     C                   CLEAR                   M@PLN
188100110513     C                   CLEAR                   M@ENR
188200110513     C                   CLEAR                   M@FRM
188300110513     C                   CLEAR                   M@TRM
188400110513    ***
188500110513     C                   ENDSR
188600110513   S***S
188700110513     C     $DENWRT       BEGSR
188800110513    ***
188900110513    *C                   EVAL      X@LAY = CPCID1                               LAYOUT
189000110513    *C                   EVAL      X@ELR = CPCID2                               ELR
189100110513    *C                   EVAL      D@SFX = CPCID3                               SUFFIX
189200110513    *C                   EVAL      D@ACCT = CPCID4                              ACCOUNT
189300110513    *C                   EVAL      D@PLAN = CPCID5                              PLAN
189400110513    *C                   EVAL      D@CLM = CPCID6                               CLAIM OFFICE
189500110524     C                   EVAL      DNTLATE = '0'
189600110513    ***
189700110513    *C                   EVAL      #XSX = D@FRM(D#CNE)
189800110725     C                   IF        WRT@TYPE = 'DEPEND' AND
189900110725     C                             #XSX < D@MBREFF
190000110725     C                   MOVE      D@MBREFF      X@EFF
190100110725     C                   ELSE
190200110725     C                   MOVE      #XSX          X@EFF
190300110725     C                   ENDIF
190400110513    ***
190500110513    *C                   EVAL      #XSX = D@TRM(D#CNE)
190600110513    *C                   IF        #XSX = 0 OR #XSX = 99999999
190700110513    *C                   MOVE      *BLANKS       X@TRM
190800110513    *C                   ELSE
190900240130    *C                   MOVE      #XSX          X@TRM
190901240130     C
190908240130
191000160809       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
191100160809       if %subdt(work_date:*d) = 01 ;
191200160809        work_date -= %days(1) ;
191300160809        num_date = %dec(work_date:*iso);
191400160809        X@TRM = %EDITC(num_date:'X');
191500160809       endif;
191600160809
191700110513    *C                   ENDIF
191800110513    ***
191900130211     C                   MOVE      *BLANKS       D@CBREXP
192000130211     C                   MOVE      *BLANKS       D@CBREVT
192100130211     C                   MOVE      *BLANKS       D@CBRLEN
192200110513     C                   IF        WRT@TYPE = 'MEMBER'
192300111123    *C                   IF        EMPST = 'C' AND CEXPDT <> 0
192400110513    *C                   MOVE      CEXPDT        D@CBREXP
192500110513    *C                   MOVE      QEDT          D@CBREVT
192600110513    *C                   MOVE      CEXPDT        #MINUEND
192700110513    *C                   MOVE      QEDT          #SUBTRAEND
192800110513    *C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
192900110513    *C                   Z-ADD     #DIFFRNC      #2S0
193000110513    *C                   MOVE      #2S0          D@CBRLEN
193100110513    *C                   ENDIF
193200110513    *C                   ENDIF
193300120806    ***
193400110513    *C                   MOVE      '0'           D@OOAI
193500140313    ***
193600140313     C                   EVAL      KF@SPCD = 'DEN'
193700140313     C                   EVAL      D@PCD = *BLANKS
193800140313     C                   EVAL      *IN81 = *OFF
193900140313     C                   MOVE      *BLANKS       DOCTOR
194000140313    ***
194100140313     C                   EXSR      $PCP
194200140313    ***
194300140313     C                   IF        DOCTOR <> *BLANKS
194400140313     C                   EVAL      D@PCD = DOCTOR
194500140313     C                   EVAL      *IN81 = *ON
194600140313     C                   ENDIF
194700110513    ***
194800120123     C     *LIKE         DEFINE    H@C#          BUC#
194900120123     C                   EVAL      BUC# = H@C#
195000120123    ***
195100200124     C****               if        cacid8 > ' ' and cacid8 <> 'N/A'
195200200124     C****               eval      h@c# = cacid8
195300200124     C****               endif
195400151106
195500120327     C                   SELECT
195600151106    *C                   ENDSL
195700151015
195800110513    *C                   EXCEPT    DENF
195900120123     C                   EVAL      H@C# = BUC#
196000110513    ***
196100110513    *C                   ENDSR
196200110513   S***S
196300110512   X***X
196400200116     OAETGEN    EADD         HDRF
196500101203     O                                            6 'HEADER'
196600101229     O                                            8 'P'
196700101206     O                       H@SI                28
196800101203     O                                           29 '0'
196900101203     O                       C1                  43
197000101203     O                       D1                  51
197100101203     O                       T1                  57
197200101206     O                                          131 'CONSOLIDATED ELIGIBILITY'
197300110502     O                       H@RI               167
197400101206     O                       H@CC               169
197500101228     O                       H@GN               176
197600101206     O                       H@CN               191
197700101206     O                       H@C#               198
197800101203     O                       D2                 206
197900110825     O                                          216 'MC'
198000101223     O                                          231 '*'
198100200116     OAETGEN    EADD         MBRF
198200101203     O                                            6 'MEMBER'
198300101203     O                       @SS1                16
198400101203     O                       @SS2                25
198500101203     O                       @FN                 75
198600101203     O                       @MI                 76
198700101203     O                       @LN                 96
198800101203     O                       @REL               101
198900101203     O                       @SEX               103
199000101203     O                       @DOB               111
199100101203     O                       @SPEC              112
199200101203     O                                          113 '0'
199300101203     O                       @COB               123
199400101203     O                       @COBC              125
199500101203     O                       @COBN              145
199600101203     O                       @AD1               175
199700101203     O                       @AD2               205
199800101203     O                       @CTY               315
199900101203     O                       @ST                317
200000101203     O                       @ZP5               322
200100101203     O                       @PHN               349
200200141211     O               87                         576 '21207'
200300140626     O               88                         576 '21740'
200400141120     O               89                         576 '20171'
200500101203     O                       @EMPST             665
200600101203     O                       @HIRE              673
200700101223     O                                         1231 '*'
200800200116     OAETGEN    EADD         HMOF
200900101213     O                                            7 'BENEFIT'
201000101213     O                       X@LAY               10
201100101214     O                       X@ELR               24
201200101213     O                       M@CC                26
201300101213     O                       H@GN                38
201400101213     O                       M@CLASS             44
201500101213     O                       M@PLAN              50
201600101213     O                       X@EFF               58
201700110929     O                       X@TRM               66
201800101213     O                       X@TIER              69
201900101213     O                       M@PCP              160
202000101213     O                       M@NPI              161
202100101213     O                       M@PCPCI            186
202200101223     O                                          323 '*'
202300200116     OAETGEN    EADD         MEAF
202400140313     O                                            7 'BENEFIT'
202500160601     O                                           10 'VIS'
202600140313     O                       X@ELR               24
202700140313     O                       H@C#                31
202800140313     O                       E@SFX               34
202900140313     O                       E@ACCT              44
203000140313     O                       E@PLAN              50
203100140313     O                       X@EFF               58
203200140313     O                       X@TRM               66
203300140313     O                       E@CLM               71
203400140313     *** PCP BGN
203500140313     O                       E@PCP              127
203600140313     O               80                         161 'N'
203700140313     O               80                         186 '0'
203800140313     *** PCP END
203900140313     O                                          389 '0'
204000140313     *** COBRA BGN
204100140313     O                       E@CBREXP           466
204200140313     O                       E@CBREVT           516
204300140313     O                       E@CBRLEN           560
204400140313     *** COBRA END
204500140313     O                                          678 '*'
204600140313    ***
204700200116     OAETGEN    EADD         DENF
204800101213     O                                            7 'BENEFIT'
204900101213     O                       X@LAY               10
205000101214     O                       X@ELR               24
205100101214     O                       H@C#                31
205200101213     O                       D@SFX               34
205300101213     O                       D@ACCT              44
205400101213     O                       D@PLAN              50
205500101213     O                       X@EFF               58
205600110929     O                       X@TRM               66
205700101213     O                       D@CLM               71
205800140313     *** PCD BGN
205900140313     O                       D@PCD              200
206000140313     O               81                         236 '0'
206100140313     *** PCD END
206200140313     O                                          389 '0'
206300140313     *** COBRA BGN
206400140313     O                       D@CBREXP           466
206500140313     O                       D@CBREVT           516
206600140313     O                       D@CBRLEN           560
206700140313     *** COBRA END
206800140313     O                       D@OOAI             609
206900140313     O                                          678 '*'
207000140313    ***
207100200116     OAETGEN    EADD         LIFF
207200130315     O                                            7 'BENEFIT'
207300130412     O                                           11 'LIFE'
207400130315     O                       X@ELR               24
207500130319     O                       H@C#3               31
207600130315     O                       L@SFX               34
207700130315     O                       L@ACCT              44
207800130315     O                       L@PLAN              50
207900130315     O                       X@EFF               58
208000130315     O                       X@TRM               66
208100130315     O                       L@CLM               71
208200130315     O                       L@CBREXP           466
208300130315     O                       L@CBREVT           516
208400130315     O                       L@CBRLEN           560
208500130315     O                       L@SALARY           658
208600130315     O                                          659 '1'
208700130315     O                                          678 '*'
208800200116     OAETGEN    EADD         TRLF
208900101203     O                                            7 'TRAILER'
209000101203     O                       @TREC               17
209100101203     O                       D1                  25
209200101203     O                       T1                  31
209300101203     O                       @BREC               41
209400101223     O                                           69 '*'
