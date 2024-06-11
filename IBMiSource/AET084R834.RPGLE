000100161108      *=============================================================================
000200161108      *  CARRIER CONTROL ID #0000000011 AETNA SPECIFIC
000300161108      *  SSK 05.13.2011 TEMPLATE DESIGN
000400161108      *=============================================================================
000500161108
000600161108      *  08.02.2011 CLONED FROM AET0X0R
000700161108      *  08.18.2011 AETNA APPROVED FOR PRODUCTION
000800161108      *  09.14.2011 ADDED ANOTHER SET OF SMALL GROUPS
000900161108      *  01.25.2012 CHANGE OF PLAN NUMBERS FOR IT OBJECTS
001000161108      *  08.03.2012 CHANGE TO METHOD FILE
001100161108      *  10.24.2012 MCCALLISTER ARCHITECTS, DENTAL ONLY SEPARATE # ADDED
001200161108      *  01.23.2013 ADDED METHOD 13 BASED ON BELFAST REQUIREMENT
001300161108
001400161108      *  CREATIVE LOGISTICS AND INTEGRA ARE SPECIALIZED GROUP # IN THE DENTAL SECTION
001500161108      *   AT THE BOTTOM OF THE PROGRAM.
001600161108      *
001700161108      *  03.15.2013 ADD LIFE PRODUCTS
001800161108      *  05.20.2013 MOVED TO PRODUCTION
001900161108      *
002000161108      *  06.27.2013 DYSON DENTAL
002100161108      *  07.12.2013 CAPLAN BROTHERS DENTAL
002200161108      *  11.26.2013 WILMOT MODULAR STRUCTURES, INC
002300161108
002400161108      *  **INCLUDES SONDA MODIFICATION ON 7/25/2011 FOR DEP EFF DATE
002500161108
002600161108      *  **NOW INCLUDES PCP INFORMATION
002700150522
002800161108      *  11/07/2016  JT  Per Brandon Scarfield... eliminate future Cobra records and send as
002900161108      *                  AC (active) records
003000161108
003100170317      *  03/15/2017  JT  Per Brandon Scarfield... reinstated Cobra records.
003200171018
003300171018      *  10/18/2017  JT  Per Brandon Scarfield... changed COB to be CBB (cobra)
003301200124
003302200124      *  01/24/2020  JT  Cleaned up a little bit of this mess
003400171018
003401200211      *  02/11/2020  JT  Fixed bug when checking term file.
003402200211
003403221118      *  01/01/2022  jt  Do not substract 1 if enroll and terml are the same.
003500150522      *==========================================================================
003600150522
003700101012     FCARACCP   IF   E           K DISK
003800150522
003900101012     FCARPLNP   IF   E           K DISK
004000150522
004100120803     FAET001WF  IF   E           K DISK
004200120803     ** MAPPING METHOD
004300150522
004400110802     FAET080WF  O  A F 1231        DISK
004500101206     ** FLAT FILE
004600150522
004700110802     FAET081WF  IF A E           K DISK
004800101028     ** TERM TRACKER
004900150522
005000101012     FMEMAC#1   IF   E           K DISK
005100150522
005200101012     FMCOVMPLN  IF   E           K DISK
005300150522
005400101012     FDEPNDC    IF   E           K DISK
005500150522
005600101012     FDCOVA     IF   E           K DISK
005700150522
005800140313     FPCPL1     IF   E           K DISK
005900150522
006000150522      *==========================================================================
006100161108
006200120803     D KF@CCTL         S             10A   INZ
006300130521     D CARR#CTL        S             10A   INZ('0000000011')
006400110512     D H@RI            S             25A   INZ('042064683')                     RECEIVER ID
006500150522
006600110512     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
006700101026     D DS@CARACC     E DS                  EXTNAME(CARACCP)
006800150522
006900150522      *==========================================================================
007000150522      * WORK ARRAY FOR PLANS
007100150522      * PC# - PLAN COUNT
007200150522      * PP# - PLAN POINTER
007300150522      *==========================================================================
007400150522
007500110512     D CARPLN@       E DS                  EXTNAME(CARPLNP)
007600160902     D                                     OCCURS(900) PREFIX(X:1)
007700110512     D PC#             S              3S 0
007800110512     D PP#             S              3S 0
007900110512     D @PLANIN         S              4A
008000110512     D @CCTRIN         S              3A
008100161108
008200150522      *==========================================================================
008300161108      * WRITE TYPE = MEMBER OR DEPEND
008400110513     D WRT@TYPE        S              6A
008500161108
008600101214     D #XST            S              6S 0
008700101214     D #IST            S               T
008800101026     D #ISO            S               D   DATFMT(*ISO)
008900101214     D #MINUEND        S               D   DATFMT(*ISO)
009000101214     D #SUBTRAEND      S               D   DATFMT(*ISO)
009100101214     D @DATE           S              8A
009200101214     D @TIME           S              6A
009300101214     D #DIFFRNC        S              5S 0
009400101214     D #2S0            S              2S 0
009500101214     D #CANCEL         S              8S 0
009600101026     D #XSX            S              8S 0
009900101026     D ENR@IN          S              3A
010000101026     D ENR@OUT         S              1A
010100110524     D DNTLATE         S              1A
010200150817     D TERM_VIS        S               N
010300130315     D TERM_LIF        S               N
010400101214     D TERM_DEN        S               N
010500101214     D TERM_MED        S               N
010600101026     D YES             S               N   INZ(*ON)
010700101026     D NO              S               N   INZ(*OFF)
010800161108
010900110512     D KF@TRS          S                   LIKE(MCTRST)
011000110512     D KF@SUB          S                   LIKE(MCSUB#)
011100110512     D KF@ACC          S                   LIKE(ACC#)
011200101026     D KF@ENR          S              3A   INZ
011400101026     D KF@CCTR         S                   LIKE(CCFLG)
011500101026     D KF@PLN          S                   LIKE(MCPLAN)
011600101026     D KF@TRM          S                   LIKE(NTTERMDT)
011700101026     D KF#TRM          S              8S 0
011800101026     D KF@SSN          S                   LIKE(MBSSNO)
011900101026     D KF@SEQ          S                   LIKE(DPSEQ#)
012200140313     D KF@SPCD         S              5A
012400161108
013000101214     D D1              S              8A
013100101214     D D2              S              8A
013200101214     D T1              S              6A
013300101214     D C1              S             14A
013400161108
013500101029     D B#RECCNT        S             10S 0 INZ
013600101029     D C#RECCNT        S             10S 0 INZ
013700161108
013800101210     D @SS1            S              9A
013900101210     D @SS2            S              9A
014000101210     D @FN             S             15A
014100101210     D @MI             S              1A
014200101210     D @LN             S             20A
014300101210     D @REL            S              2A
014400101210     D @SEX            S              1A
014500101210     D @DOB            S              8A
014600101210     D @SPEC           S              1A
014700101210     D @COB            S              1A
014800101210     D @COBC           S              2A
014900101210     D @COBN           S             20A
015000101210     D @AD1            S             30A
015100101210     D @AD2            S             30A
015200101214     D @CTY            S             20A
015300101210     D @ST             S              2A
015400101210     D @ZP5            S              5A
015500101210     D @PHN            S             10A
015600101210     D @EMPST          S              2A
015700101210     D @HIRE           S              8A
015800161108
015900161108      * VIS ARRAYS
016000150817     D V#CNE           S              3S 0 INZ
016100150817     D V#NDX           S              3S 0 INZ
016200150817     D V@PLN           S              4A   DIM(20)
016300150817     D V@ENR           S              3A   DIM(20)
016400150817     D V@FRM           S              8S 0 DIM(20)
016500150817     D V@TRM           S              8S 0 DIM(20)
016600150817     D V@MBREFF        S              8S 0
016700161108
016800161108      * LIFE ARRAYS
016900130315     D L#CNE           S              3S 0 INZ
017000130315     D L#NDX           S              3S 0 INZ
017100130315     D L@PLN           S              4A   DIM(20)
017200130315     D L@ENR           S              3A   DIM(20)
017300130315     D L@FRM           S              8S 0 DIM(20)
017400130315     D L@TRM           S              8S 0 DIM(20)
017500130315     D L@MBREFF        S              8S 0
017600161108
017700161108      * DENTAL ARRAYS
017800101206     D D#CNE           S              3S 0 INZ
017900101206     D D#NDX           S              3S 0 INZ
018000101206     D D@PLN           S              4A   DIM(20)
018100101206     D D@ENR           S              3A   DIM(20)
018200101206     D D@FRM           S              8S 0 DIM(20)
018300101206     D D@TRM           S              8S 0 DIM(20)
018400110725     D D@MBREFF        S              8S 0
018500161108
018600161108      * MEDICAL ARRAYS
018700101206     D M#CNE           S              3S 0 INZ
018800101206     D M#NDX           S              3S 0 INZ
018900101206     D M@PLN           S              4A   DIM(20)
019000101206     D M@ENR           S              3A   DIM(20)
019100101206     D M@FRM           S              8S 0 DIM(20)
019200101206     D M@TRM           S              8S 0 DIM(20)
019300110725     D M@MBREFF        S              8S 0
019400161108
019500101206     D H@SI            S             20A
019600101206     D H@CC            S              2A
019700101206     D H@GN            S              7A
019800101206     D H@CN            S             15A
019900101206     D H@C#            S              7A
020000130319     D H@C#3           S              7A
020100161108
020200101213     D X@LAY           S              3A
020300101213     D X@ELR           S              7A
020400140313     D X@EFF           S              8A
020500140313     D X@TRM           S              8A
020600140313     D X@TIER          S              1A
020700161108
020800101213     D M@CC            S              2A
020900101213     D M@CLASS         S              5A
021000101213     D M@PLAN          S              6A
021100101213     D M@PCP           S             40A
021200101213     D M@NPI           S              1A
021300101213     D M@PCPCI         S              1A
021400161108
021500101213     D D@SFX           S              3A
021600101213     D D@ACCT          S              5A
021700101213     D D@PLAN          S              6A
021800101213     D D@CLM           S              3A
021900101213     D D@CBREXP        S              8A
022000101213     D D@CBREVT        S              8A
022100101213     D D@CBRLEN        S              2A
022200101213     D D@OOAI          S              1A
022300140313     D D@PCD           S              7A
022400161108
022500101214     D @STEP           S              5A
022600161108
022700140313     D E@SFX           S              3A
022800140313     D E@ACCT          S              5A
022900140313     D E@PLAN          S              6A
023000140313     D E@CLM           S              3A
023100140313     D E@PCP           S              7A
023200140313     D E@CBREXP        S              8A
023300140313     D E@CBREVT        S              8A
023400140313     D E@CBRLEN        S              2A
023500161108
023600130315     D L@SFX           S              3A
023700130315     D L@ACCT          S              5A
023800130315     D L@PLAN          S              6A
023900130315     D L@CLM           S              3A
024000130315     D L@CBREXP        S              8A
024100130315     D L@CBREVT        S              8A
024200130315     D L@CBRLEN        S              2A
024300130315     D L@SALARY        S             20A
024400150511
024500150817     D V@SFX           S              3A
024600150817     D V@ACCT          S              5A
024700150817     D V@PLAN          S              6A
024800150817     D V@CLM           S              3A
024900150817     D V@CBREXP        S              8A
025000150817     D V@CBREVT        S              8A
025100150817     D V@CBRLEN        S              2A
025200150817     D V@SALARY        S             20A
025300150817
025400150511     D medType         S              3A
025500161108
025600160809     d num_date        s              8s 0 inz
025700160809     D work_date       s               d
025800221108     d edate           s              8  0
025801221108     d tdate           s              8  0
025802221108
025900161108     D effectiveDate   s              8    INZ('20161201')
026000161108     D effectiveDateD  s              8  0 INZ(20161201)
026100161108
026200161108      *=============================================================================
026300161108
026400110512     C                   EVAL      @STEP = 'PREP1'
026500161108
026600120803     C                   EVAL      KF@CCTL = CARR#CTL
026700110802     C                   EXSR      $HEADR
026800161108
026900120803     C     KF@CCTL       SETLL     CARACCR
027000161108
027100101026     C                   DOU       @STEP = 'LEAVE'
027200101026     C     @STEP         CASEQ     'PREP1'       $PREP1
027300101026     C     @STEP         CASEQ     'STEP1'       $STEP1
027400101026     C     @STEP         CASEQ     'STEP2'       $STEP2
027500101026     C     @STEP         CASEQ     'STEP3'       $STEP3
027600101026     C     @STEP         CASEQ     'PREP4'       $PREP4
027700101026     C     @STEP         CASEQ     'STEP4'       $STEP4
027800101026     C     @STEP         CASEQ     'PREP5'       $PREP5
027900101026     C     @STEP         CASEQ     'STEP5'       $STEP5
028000101214     C     @STEP         CASEQ     'PREP6'       $PREP6
028100101026     C     @STEP         CASEQ     'STEP6'       $STEP6
028200101214     C     @STEP         CASEQ     'PREP7'       $PREP7
028300101214     C     @STEP         CASEQ     'STEP7'       $STEP7
028400101214     C     @STEP         CASEQ     'STEP8'       $STEP8
028500101214     C     @STEP         CASEQ     'PREP9'       $PREP9
028600101214     C     @STEP         CASEQ     'STEP9'       $STEP9
028700101214     C     @STEP         CASEQ     'PREPA'       $PREPA
028800101214     C     @STEP         CASEQ     'STEPA'       $STEPA
028900101214     C     @STEP         CASEQ     'PREPB'       $PREPB
029000101214     C     @STEP         CASEQ     'STEPB'       $STEPB
029100130315     C     @STEP         CASEQ     'PREPC'       $PREPC
029200130315     C     @STEP         CASEQ     'STEPC'       $STEPC
029300150827     C**** @STEP         CASEQ     'PREPD'       $PREPD
029400150827     C**** @STEP         CASEQ     'STEPD'       $STEPD
029500101026     C                   ENDCS
029600101026     C                   ENDDO
029700161108
029800161108      *  TRAILER RECORD
029900101026     C                   ADD       2             C#RECCNT
030000101214     C                   MOVE      C#RECCNT      @TREC            10 0
030100101214     C                   MOVE      B#RECCNT      @BREC            10 0
030200101214     C                   EXCEPT    TRLF
030300161108
030400101026     C                   EVAL      *INLR = *ON
030500161108
030600161108      *=============================================================================
030700161108
030800110802     C     $HEADR        BEGSR
030900161108
031000110802     C                   EVAL      D1 = @DATE
031100110802     C                   EVAL      D2 = @DATE
031200110802     C                   EVAL      T1 = @TIME
031300110802     C                   EVAL      C1 = @DATE + @TIME
031400161108
031500110802     C                   EVAL      KF@TRS = 999
031600110802     C                   EVAL      KF@SUB = 999
031700110802     C                   EVAL      KF@ACC = 9999
031800110802     C     KL#ACCTL      CHAIN     CARACCR
031900161108
032000110802     C                   EVAL      H@SI = %TRIM(CACID1)                         SUBMITTER ID
032100110802     C                   EVAL      H@CC = %SUBST(CACID2:1:2)                    COMPANY CODE
032200110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
032300110802     C                   MOVEL(P)  CACID4        H@CN                           CUSTOMER NAME
032400110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
032500130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
032600161108
032700110802     C                   EXCEPT    HDRF
032800161108
032900110802     C                   ENDSR
033000161108
033100161108      *=============================================================================
033200161108
033300110802     C     $PREP1        BEGSR
033400161108
033500120803     C     KF@CCTL       READE     CARACCR
033600161108
033700110512     C                   IF        %EOF(CARACCP)
033800120803      *
033900110512     C                   EVAL      @STEP = 'LEAVE'
034000161108
034100110512     C                   LEAVESR
034200110512     C                   ENDIF
034300161108
034400161108      * HAS THE ACCOUNT BEEN SHUTOFF FOR EXPORT?
034500110512     C                   IF        CASTATUS <> 'Y'
034600110512     C                   LEAVESR
034700110512     C                   ENDIF
034800161108
034900161108      * THESE FIELDS RESET FOR EACH SMALL GROUP READ
035000110802     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
035100110802     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
035200130319     C                   MOVEL(P)  CACID7        H@C#3                          CUSTOMER #
035300161108
035400110512     C                   EVAL      KF@TRS = CATRST
035500110512     C                   EVAL      KF@SUB = CASUB#
035600110512     C                   EVAL      KF@ACC = CAACCT
035700161108
035800110512     C                   EXSR      $PLANLOAD
035900161108
036000101206     C                   EVAL      @STEP = 'STEP1'
036100161108
036200110512     C                   ENDSR
036300161108
036400161108      *=============================================================================
036500161108
036600101206     C     $STEP1        BEGSR
036700161108
036800101206     C                   EVAL      KF@PLN = *BLANKS
036900101206     C                   EVAL      KF@TRM = 0
037000101206     C                   EVAL      KF@SSN = 0
037100101206     C                   EVAL      KF@SEQ = 0
037200161108
037300101206     C     KL#TSA        SETLL     MEMBR
037400161108
037500101206     C                   EVAL      @STEP = 'STEP2'
037600161108
037700101206     C                   ENDSR
037800161108
037900161108      *=============================================================================
038000161108
038100101206     C     $STEP2        BEGSR
038200161108
038300101206     C     KL#TSA        READE     MEMBR
038400161108
038500101206     C                   IF        %EOF(MEMAC#1)
038600110512     C                   EVAL      @STEP = 'PREP1'
038700101206     C                   LEAVESR
038800101206     C                   ENDIF
038900161108
039000101206     C                   EVAL      KF@SSN = MBSSNO
039100101214     C                   MOVE      *ZEROS        KF@SEQ
039200120803     C                   EVAL      WRT@TYPE = 'MEMBER'
039300161108
039400101206     C     KL#MPLN       SETLL     MCOVR
039500161108
039600101206     C                   EXSR      $CLRSTG
039700161108
039800101206     C                   EVAL      @STEP = 'STEP3'
039900161108
040000101206     C                   ENDSR
040100161108
040200161108      *=============================================================================
040300161108
040400161108     C     $STEP3        BEGSR
040500161108
040600101206     C     KL#MPLN       READE     MCOVR
040700161108
040800101206     C                   IF        %EOF(MCOVMPLN)
040900101206     C                   EVAL      @STEP = 'PREP4'
041000101206     C                   LEAVESR
041100101206     C                   ENDIF
041200161108
041700120803     C                   EVAL      KF@PLN = MCPLAN
041800120803     C     KL#TSAP       CHAIN     AEF01
041900120803     C                   IF        NOT %FOUND(AET001WF)
042000120803     C                   LEAVESR
042100120803     C                   ENDIF
042200161108
042300110512     C                   EVAL      @PLANIN = MCPLAN
042400111020     C                   EVAL      ENR@IN = MCOVTP
042500161108
042600110802     C                   EXSR      $QUIK
042700161108
042800110512     C                   EXSR      $PLANSRCH
042900161108
043000110512     C                   IF        PLN@CAT = *BLANKS
043100110512     C                   LEAVESR
043200110512     C                   ENDIF
043300161108
043400101206     C                   IF        CANDT = 0
043500101206     C                   EVAL      #CANCEL = 99999999
043600101206     C                   ELSE
043700101206     C                   EVAL      #CANCEL = CANDT
043800101206     C                   ENDIF
043900161108
044000161108      * DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL;
044100161108      * LIF IS LIFE;
044200161108
044300130315     C                   SELECT
044400161108
044500161108     C                   WHEN      PLN@CAT = 'LIFE'
044600161108     C                   IF        L#CNE > 0
044700161108     C                   IF        L@TRM(L#CNE) = 99999999
044800130315     C                   LEAVESR
044900130315     C                   ENDIF
045000130315     C                   ENDIF
045100161108     C                   ADD       1             L#CNE
045200161108     C                   EVAL      L@PLN(L#CNE) = MCPLAN
045300161108     C                   EVAL      L@ENR(L#CNE) = MCOVTP
045400161108     C                   EVAL      L@FRM(L#CNE) = ENRLDT
045500161108     C                   EVAL      L@TRM(L#CNE) = #CANCEL
045600161108
045700161108     C                   WHEN      PLN@CAT = 'DEN'
045800161108     C                   IF        D#CNE > 0
045900161108     C                   IF        D@TRM(D#CNE) = 99999999
046000130131     C                   LEAVESR
046100130131     C                   ENDIF
046200130131     C                   ENDIF
046300161108     C                   ADD       1             D#CNE
046400161108     C                   EVAL      D@PLN(D#CNE) = MCPLAN
046500161108     C                   EVAL      D@ENR(D#CNE) = MCOVTP
046600161108     C                   EVAL      D@FRM(D#CNE) = ENRLDT
046700161108     C                   EVAL      D@TRM(D#CNE) = #CANCEL
046800161108
046900130315     C                   OTHER
047000161108     C                   IF        M#CNE > 0
047100161108     C                   IF        M@TRM(M#CNE) = 99999999
047200130131     C                   LEAVESR
047300130131     C                   ENDIF
047400130131     C                   ENDIF
047500101206     C                   ADD       1             M#CNE
047600101206     C                   EVAL      M@PLN(M#CNE) = MCPLAN
047700101206     C                   EVAL      M@ENR(M#CNE) = MCOVTP
047800101206     C                   EVAL      M@FRM(M#CNE) = ENRLDT
047900101206     C                   EVAL      M@TRM(M#CNE) = #CANCEL
048000161108
048100161108     C                   ENDSL
048200161108
048300110512     C                   ENDSR
048400161108
048500161108      *=============================================================================
048600161108
048700110802     C     $QUIK         BEGSR
048800161108
048900110805     C                   EVAL      @CCTRIN = *BLANKS
049000161108
049100120803     C     AE1MAP        CASEQ     '2TIER     '  $METH01
049200120803     C     AE1MAP        CASEQ     'ITOBJECTS '  $METH02
049300120803     C     AE1MAP        CASEQ     'NORULE    '  $METH03
049400120803     C     AE1MAP        CASEQ     'STATETIER '  $METH04
049500120803     C     AE1MAP        CASEQ     'TIERSTS   '  $METH05
049600120803     C     AE1MAP        CASEQ     'MAYOR     '  $METH06
049700120803     C     AE1MAP        CASEQ     'EMPSTS    '  $METH07
049800120803     C     AE1MAP        CASEQ     'JUSTSTATE '  $METH08
049900120803     C     AE1MAP        CASEQ     'JOHNLS    '  $METH09
050000120803     C     AE1MAP        CASEQ     'CREATIVE  '  $METH10
050100120803     C     AE1MAP        CASEQ     'INTEGRA   '  $METH11
050200120803     C     AE1MAP        CASEQ     'STSTATE   '  $METH12
050300130123     C     AE1MAP        CASEQ     'INTEGRA   '  $METH11
050400130123     C     AE1MAP        CASEQ     'STIERSTS  '  $METH13
050500120803     C                   ENDCS
050600161108
050700120803     C                   ENDSR
050800161108
050900161108      *=============================================================================
051000161108      * 2 TIER = AETNA HAS TWO TIERS, IND AND FAM
051100161108      *  MEMBERS HAVE 'TIN' CONVERTED TO 'IND' AND NON-'TIN' CONVERTED TO 'FAM'
051200161108      *  DEPENDENTS HAVE 'FAM' ONLY
051300161108      * IND, FAM
051400161108      *=============================================================================
051500161108
051600120803     C     $METH01       BEGSR
051700161108
051800120803     C                   IF        WRT@TYPE = 'MEMBER'
051900161108
052000120803     C                   IF        ENR@IN = 'TIN'
052100120803     C                   EVAL      @CCTRIN = 'IND'
052200120803     C                   ELSE
052300120803     C                   EVAL      @CCTRIN = 'FAM'
052400120803     C                   ENDIF
052500161108
052600120803     C                   ENDIF
052700161108
052800120803     C                   IF        WRT@TYPE = 'DEPEND'
052900161108
053000120803     C                   EVAL      @CCTRIN = 'FAM'
053100161108
053200120803     C                   ENDIF
053300161108
053400120803     C                   ENDSR
053500161108
053600161108      *=============================================================================
053700161108      * ITOBJECTS = IF YOU ARE NOT 'VA' OR 'OH' STATE CODES, YOU ARE 'XX'
053800161108      * VA, OH, XX
053900161108      *=============================================================================
054000161108
054100120803     C     $METH02       BEGSR
054200161108
054300120803     C                   IF        STATE <> 'VA' AND STATE <> 'OH'
054400120803     C                   EVAL      @CCTRIN = 'XX '
054500120803     C                   ELSE
054600120803     C                   EVAL      @CCTRIN = STATE
054700120803     C                   ENDIF
054800161108
054900161108     C                   ENDSR
055000161108
055100161108      *=============================================================================
055200161108      * NORULE = NUFF SAID
055300161108      *=============================================================================
055400161108
055500120803     C     $METH03       BEGSR
055600161108
055700120803     C                   EVAL      @CCTRIN = *BLANKS
055800161108
055900120803     C                   ENDSR
056000161108
056100161108      *=============================================================================
056200161108      * STATETIER
056300161108      *  START WITH STATE CODE
056400161108      *  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
056500161108      *  DEPENDENTS HAVE 'F' ONLY
056600161108
056700161108      * MDI, MDF, ETC...
056800161108      *=============================================================================
056900161108
057000120803     C     $METH04       BEGSR
057100161108
057200120803     C                   EVAL      @CCTRIN = STATE
057300161108
057400120803     C                   IF        WRT@TYPE = 'MEMBER'
057500120803     C                   IF        ENR@IN = 'TIN'
057600120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
057700120803     C                   ELSE
057800120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
057900120803     C                   ENDIF
058000120803     C                   ENDIF
058100161108
058200120803     C                   IF        WRT@TYPE = 'DEPEND'
058300120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
058400120803     C                   ENDIF
058500161108
058600120803     C                   ENDSR
058700161108
058800161108      *=============================================================================
058900161108      * TIERSTS
059000161108      *  START WITH EMPLOYMENT STATUS, ACTIVE IS 'ACT' AND COBRA IS 'COB'
059100161108      *  MEMBERS HAVE 'TIN' CONVERTED TO 'I' AND NON-'TIN' CONVERTED TO 'F'
059200161108      *  DEPENDENTS HAVE 'F' ONLY
059300161108
059400171018      * ACI, ACF, COI, COF (COI changed to CBI)
059500161108      *=============================================================================
059600161108
059700120803     C     $METH05       BEGSR
059800161108
059900120803     C                   IF        EMPST =  'C'
060000171018     C                   EVAL      @CCTRIN = 'CBB'
060100120803     C                   ELSE
060200120803     C                   EVAL      @CCTRIN = 'ACT'
060300120803     C                   ENDIF
060400161108
060500120803     C                   IF        ENR@IN = 'TIN'
060600120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
060700120803     C                   ELSE
060800120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
060900120803     C                   ENDIF
061000161108
061100120803     C                   ENDSR
061200161108
061300161108      *=============================================================================
061400161108      * MAYOR
061500161108      *  WELL, FOR THE PLAN 'DAAU' IF THE STATE IS 'WV' THEN PLACE TIER STATUS SUFFIX
061600161108      *       BY TYPE OF PEEP; FOR OTHER STATES, USE A SIMPLE TIER CHECK.
061700161108
061800161108      *  WVI, WVF, IND, FAM
061900161108
062000161108      *  NOW, FOR THE PLAN 'DAAT' IF THE STATE IS 'WV' THEN PLACE EMPLOYMENT STATUS SUFFIX
062100161108      *       BY TYPE OF PEEP; FOR OTHER STATES, EMPLOYMENT STATUS AND TIER.
062200161108      *  WVI, WVF, CBI, CBF, ACI, ACF
062300161108      *=============================================================================
062400161108
062500120803     C     $METH06       BEGSR
062600161108
062700161108     C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'MEMBER'
062800161108
062900161108     C                   IF        STATE = 'WV'
063000161108
063100161108     C                   IF        ENR@IN = 'TIN'
063200120803     C                   EVAL      @CCTRIN = 'WVI'
063300161108     C                   ELSE
063400120803     C                   EVAL      @CCTRIN = 'WVF'
063500161108     C                   ENDIF
063600161108
063700161108     C                   ELSE
063800161108
063900161108     C                   IF        ENR@IN = 'TIN'
064000120803     C                   EVAL      @CCTRIN = 'IND'
064100161108     C                   ELSE
064200120803     C                   EVAL      @CCTRIN = 'FAM'
064300161108     C                   ENDIF
064400161108
064500161108     C                   ENDIF
064600161108
064700120803     C                   LEAVESR
064800161108     C                   ENDIF
064900161108
065000120803     C                   IF        @PLANIN = 'DAAU' AND WRT@TYPE = 'DEPEND'
065100161108
065200120803     C                   IF        STATE = 'WV'
065300120803     C                   EVAL      @CCTRIN = 'WVF'
065400120803     C                   ELSE
065500120803     C                   EVAL      @CCTRIN = 'FAM'
065600120803     C                   ENDIF
065700161108
065800120803     C                   LEAVESR
065900120803     C                   ENDIF
066000161108
066100161108     C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'MEMBER'
066200161108
066300161108     C                   IF        STATE = 'WV'
066400161108
066500161108     C                   IF        ENR@IN = 'TIN'
066600120803     C                   EVAL      @CCTRIN = 'WVI'
066700161108     C                   ELSE
066800120803     C                   EVAL      @CCTRIN = 'WVF'
066900161108     C                   ENDIF
067000161108
067100161108     C                   ELSE
067200161108
067300161108     C                   IF        EMPST =  'C'
067400120803     C                   EVAL      @CCTRIN = 'CB '
067500161108     C                   ELSE
067600120803     C                   EVAL      @CCTRIN = 'AC '
067700161108     C                   ENDIF
067800161108     C                   IF        ENR@IN = 'TIN'
067900120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
068000161108     C                   ELSE
068100120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
068200161108     C                   ENDIF
068300161108
068400161108     C                   ENDIF
068500161108
068600120803     C                   LEAVESR
068700161108     C                   ENDIF
068800161108
068900120803     C                   IF        @PLANIN = 'DAAT' AND WRT@TYPE = 'DEPEND'
069000161108
069100120803     C                   IF        STATE = 'WV'
069200120803     C                   EVAL      @CCTRIN = 'WVF'
069300120803     C                   ELSE
069400120803     C                   IF        EMPST =  'C'
069500120803     C                   EVAL      @CCTRIN = 'CBF'
069600120803     C                   ELSE
069700120803     C                   EVAL      @CCTRIN = 'ACF'
069800120803     C                   ENDIF
069900120803     C                   ENDIF
070000161108
070100120803     C                   ENDIF
070200161108
070300120803     C                   ENDSR
070400161108
070500161108      *=============================================================================
070600161108      * EMPSTS
070700161108      *   PRETTY STRAIGHT FORWARDED
070800161108      *=============================================================================
070900161108
071000120803     C     $METH07       BEGSR
071100161108
071200120803     C                   IF        EMPST =  'C'
071300120803     C                   EVAL      @CCTRIN = 'COB'
071400120803     C                   ELSE
071500120803     C                   EVAL      @CCTRIN = 'ACT'
071600120803     C                   ENDIF
071700161108
071800120803     C                   ENDSR
071900161108
072000161108      *=============================================================================
072100161108      * JUSTSTATE
072200161108      *   PRETTY STRAIGHT FORWARDED
072300161108      *=============================================================================
072400161108
072500120803     C     $METH08       BEGSR
072600161108
072700161108     C                   EVAL      @CCTRIN = STATE
072800161108
072900120803     C                   ENDSR
073000161108
073100161108      *=============================================================================
073200161108      * JOHNLS
073300161108      *   IF STATE IS NOT MARYLAND, DEFAULT TO 'XX', ELSE USE 'MD'; THEN APPLY TIER.
073400161108      *
073500161108      * MDI, MDF, XXI, XXF
073600161108      *=============================================================================
073700161108
073800120803     C     $METH09       BEGSR
073900161108
074000120803     C                   IF        WRT@TYPE = 'MEMBER'
074100120803     C                   IF        STATE = 'MD'
074200120803     C                   EVAL      @CCTRIN = 'MD'
074300120803     C                   ELSE
074400120803     C                   EVAL      @CCTRIN = 'XX'
074500120803     C                   ENDIF
074600120803     C                   IF        ENR@IN = 'TIN'
074700120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'I'
074800120803     C                   ELSE
074900120803     C                   EVAL      %SUBST(@CCTRIN:3:1) = 'F'
075000120803     C                   ENDIF
075100120803     C                   ENDIF
075200161108
075300120803     C                   IF        WRT@TYPE = 'DEPEND'
075400120803     C                   IF        STATE = 'MD'
075500120803     C                   EVAL      @CCTRIN = 'MDF'
075600120803     C                   ELSE
075700120803     C                   EVAL      @CCTRIN = 'XXF'
075800120803     C                   ENDIF
075900120803     C                   ENDIF
076000161108
076100120803     C                   ENDSR
076200161108
076300161108      *=============================================================================
076400161108
076500161108      * CREATIVE
076600161108      *   IF STATE IS NOT 'MD' OR 'OK', DEFAULT TO '**'.
076700161108      *
076800161108      * MD, OK, **
076900161108      *=============================================================================
077000161108
077100120803     C     $METH10       BEGSR
077200161108
077300120803     C                   IF        STATE <> 'MD' AND STATE <> 'OK'
077400120803     C                   EVAL      @CCTRIN = '** '
077500120803     C                   ELSE
077600120803     C                   EVAL      @CCTRIN = STATE
077700120803     C                   ENDIF
077800161108
077900120803     C                   ENDSR
078000161108
078100161108      *=============================================================================
078200161108      * INTEGRA = USE 'TN' FOR TENNESSEE, OTHER STATES ARE 'XX'
078300161108      *
078400161108      *  TN, XX
078500161108      *=============================================================================
078600161108
078700120803     C     $METH11       BEGSR
078800161108
078900121113     C                   SELECT
079000121113     C                   WHEN      STATE = 'TN'
079100121113     C                   EVAL      @CCTRIN = STATE                              TENNESSEE ONLY
079200121113     C                   WHEN      STATE = 'FL'
079300121113     C                   EVAL      @CCTRIN = STATE                              FLORIDA ONLY
079400121113     C                   OTHER
079500121113     C                   EVAL      @CCTRIN = 'XX '                              SITUS
079600161108     C                   ENDSL
079700161108
079800120803     C                   ENDSR
079900161108
080000161108      *=============================================================================
080100161108      * STSTATE = STATE CODE WITH EMPLOYEE STATUS
080200161108      *
080300161108      *  MDA, MDC, ETC...
080400161108      *=============================================================================
080500161108
080600120803     C     $METH12       BEGSR
080700161108
080800120803     C                   EVAL      @CCTRIN = STATE + EMPST
080900161108
081000120803     C                   ENDSR
081100161108
081200161108      *=============================================================================
081300161108
081400161108      * STIERSTS = STATE CODE WITH TIER WITH EMPLOYEE STATUS
081500161108      *    ACTIVE [#CALC = 0]      COBRA [#CALC = 5]
081600161108      *    IND [+1 TO #CALC ]      NON-IND COVERAGE [+2 TO CALC]
081700161108      *
081800161108      *    EACH STATE PUT AT END, GIVING FAM MARYLAND ACTIVE A VALUE OF 2MD
081900161108      *                                  IND WEST VIRGINIA COBRA A VALUE OF 6WV
082000161108      *=============================================================================
082100161108
082200130123     C     $METH13       BEGSR
082300161108
082400130123     C                   SELECT
082500130123     C                   WHEN      EMPST =  'C'
082600130123     C                   Z-ADD     5             #CALC
082700130123     C                   OTHER
082800130123     C                   MOVE      *ZEROS        #CALC             1 0
082900130123     C                   ENDSL
083000161108
083100130123     C                   SELECT
083200130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN = 'TIN'
083300130123     C                   ADD       1             #CALC
083400130123     C                   WHEN      WRT@TYPE = 'MEMBER' AND ENR@IN <> 'TIN'
083500130123     C                   ADD       2             #CALC
083600130123     C                   WHEN      WRT@TYPE = 'DEPEND'
083700130123     C                   ADD       2             #CALC
083800130123     C                   ENDSL
083900161108
084000130123     C                   EVAL      @CCTRIN = %EDITC(#CALC:'X') + STATE
084100161108
084200130123     C                   ENDSR
084300161108
084400161108      *=============================================================================
084500161108
084600120409     C     $PREP4        BEGSR
084700161108
084800130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
084900101206     C                   EVAL      @STEP = 'STEP2'
085000101206     C                   LEAVESR
085100101206     C                   ENDIF
085200161108
085300130520     C                   EVAL      @STEP = 'STEP4'
085400130315     C                   EVAL      TERM_LIF = NO
085500101210     C                   EVAL      TERM_DEN = NO
085600101210     C                   EVAL      TERM_MED = NO
085700161108
085800130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
085900130520     C                   IF        L@TRM(L#CNE) <> 99999999
086000130520     C                   EXSR      $CHKHEM
086100130520     C                   ENDIF
086200130520     C                   LEAVESR
086300130520     C                   ENDIF
086400161108
086500130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
086600130520     C                   IF        M@TRM(M#CNE) <> 99999999
086700130520     C                   EXSR      $CHKHEM
086800130520     C                   ENDIF
086900130520     C                   LEAVESR
087000130520     C                   ENDIF
087100161108
087200130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
087300130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
087400130520     C                              M@TRM(M#CNE) <> 99999999)
087500130520     C                   EXSR      $CHKHEM
087600130520     C                   ENDIF
087700130520     C                   LEAVESR
087800130520     C                   ENDIF
087900161108
088000130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
088100130520     C                   IF        D@TRM(D#CNE) <> 99999999
088200130520     C                   EXSR      $CHKHEM
088300130520     C                   ENDIF
088400130520     C                   LEAVESR
088500130520     C                   ENDIF
088600161108
088700130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
088800130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
088900130520     C                              D@TRM(D#CNE) <> 99999999)
089000130520     C                   EXSR      $CHKHEM
089100130520     C                   ENDIF
089200130520     C                   LEAVESR
089300130520     C                   ENDIF
089400161108
089500130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
089600130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
089700130520     C                              M@TRM(M#CNE) <> 99999999)
089800130520     C                   EXSR      $CHKHEM
089900130520     C                   ENDIF
090000130520     C                   LEAVESR
090100130520     C                   ENDIF
090200161108
090300130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
090400130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
090500130520     C                              L@TRM(L#CNE) <> 99999999 OR
090600130520     C                              M@TRM(M#CNE) <> 99999999)
090700130520     C                   EXSR      $CHKHEM
090800130520     C                   ENDIF
090900130520     C                   LEAVESR
091000130520     C                   ENDIF
091100161108
091200150817     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
091300150817     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
091400150817     C                              L@TRM(L#CNE) <> 99999999 OR
091500150817     C                              M@TRM(M#CNE) <> 99999999 or
091600150817     C                              M@TRM(V#CNE) <> 99999999)
091700150817     C                   EXSR      $CHKHEM
091800150817     C                   ENDIF
091900150817     C                   LEAVESR
092000150817     C                   ENDIF
092100161108
092200101214     C                   ENDSR
092300161108
092400161108      *=============================================================================
092500161108      * GENERATE MEMBER RECORD
092600161108      *=============================================================================
092700161108
092800101210     C     $STEP4        BEGSR
092900161108
093000130315     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE = 0
093100150817     C                             AND V#CNE = 0
093200101214     C                   EVAL      @STEP = 'STEP2'
093300101214     C                   LEAVESR
093400101214     C                   ENDIF
093500161108
093600110513     C                   EVAL      WRT@TYPE = 'MEMBER'
093700161108
093800150817     C                   EVAL      V@MBREFF = 0
093900130315     C                   EVAL      L@MBREFF = 0
094000110725     C                   EVAL      D@MBREFF = 0
094100110725     C                   EVAL      M@MBREFF = 0
094200161108
094300101210     C                   EVAL      @SS1   = %EDITC(MBSSNO:'X')
094400101210     C                   EVAL      @SS2   = @SS1
094500101210     C                   MOVEL(P)  MLNAME        @LN
094600101210     C                   MOVEL(P)  MFNAME        @FN
094700101210     C                   EVAL      @MI    = MMI
094800101210     C                   EVAL      @REL   = '01'
094900101210     C                   EVAL      @SEX   = SEX
095000101210     C                   EVAL      @DOB   = %EDITC(BIRTH:'X')
095100101210     C                   IF        COB = 'Y'
095200101210     C                   EVAL      @COB   = 'Y'
095300101210     C                   EVAL      @COBC  = 'OT'
095400101210     C                   EVAL      @COBN  = MCOBPN
095500101210     C                   ENDIF
095600101210     C                   EVAL      @AD1   = %TRIM(ADDR1)
095700101210     C                   EVAL      @AD2   = %TRIM(ADDR2)
095800101210     C                   EVAL      @CTY   = %TRIM(CITY)
095900101210     C                   EVAL      @ST    = STATE
096000101210     C                   MOVE      *BLANKS       @9                9
096100101210     C                   EVAL      @9   = %EDITC(ZIP:'X')
096200101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
096300101210     C                   EVAL      @PHN   = %EDITC(AREA:'X') +
096400101210     C                                      %EDITC(PHONE:'X')
096500161108
096600101210     C                   SELECT
096700101210     C                   WHEN      EMPST = 'A'
096800101210     C                   EVAL      @EMPST = 'AC'
096900101210     C                   WHEN      EMPST = 'C'
097000101210     C                   EVAL      @EMPST = 'CO'
097100101210     C                   WHEN      EMPST = 'R'
097200101210     C                   EVAL      @EMPST = 'RT'
097300101210     C                   ENDSL
097400161108
097500101210     C                   EVAL      @HIRE  = %EDITC(EMPDT:'X')
097600161108
097700141211     C                   SETOFF                                       888987
097800161108
097900141120        IF KF@TRS = 770 AND KF@SUB = 004 AND KF@ACC = 0037 AND
098000141120          STATE = 'VT';
098100141120           *IN89 = *ON;
098200141120        ENDIF;
098300161108
098400170317       // if cobra and effective date > 12/01/2016...
098500170317       //if empst = 'C';
098600170317       // if qedt >= effectiveDateD;
098700170317       //  @empst = 'AC';
098800170317       // endif;
098900170317       //endif;
099000161108
099100101210     C                   EXCEPT    MBRF
099200101214     C                   ADD       1             C#RECCNT
099300161108
099400101213     C                   EVAL      @STEP = 'PREP5'
099500161108
099600101210     C                   ENDSR
099700161108
099800161108      *=============================================================================
099900161108      * MEDICAL
100000161108      *=============================================================================
100100161108
100200101214     C     $PREP5        BEGSR
100300161108
100400101214     C                   IF        M#CNE = 0
100500110513     C                   EVAL      @STEP = 'PREP6'
100600101214     C                   LEAVESR
100700101214     C                   ENDIF
100800161108
100900101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
101000130315     C                   EVAL      KF@ENR = M@ENR(M#CNE)
101100161108
101200101214     C                   IF        TERM_MED = YES
101300101214     C                   EXSR      $WRTERM
101400101214     C                   ENDIF
101500161108
101600110512     C                   EVAL      @PLANIN = KF@PLN
101700161108
101800120803     C     KL#TSAP       CHAIN     AEF01
101900120803     C                   IF        NOT %FOUND(AET001WF)
102000120803     C                   LEAVESR
102100120803     C                   ENDIF
102200161108
102300111020     C                   EVAL      ENR@IN = M@ENR(M#CNE)
102400161108
102500110802     C                   EXSR      $QUIK
102600161108
102700110512     C                   EXSR      $PLANSRCH
102800161108
102900110512     C                   IF        PLN@CAT = *BLANKS
103000101214     C                   SETON                                        H1
103100101214     C                   ENDIF
103200161108
103300110513     C                   EVAL      @STEP = 'STEP5'
103400110725     C                   EVAL      #XSX = M@FRM(M#CNE)
103500110725     C                   EVAL      M@MBREFF = #XSX
103600161108
103700101214     C                   ENDSR
103800161108
103900161108      *=============================================================================
104000161108
104100101214     C     $STEP5        BEGSR
104200161108
104300110513     C                   IF        CPCID1 = 'MEA'
104500150511     C                             or CPCID1 = 'PPO'
104600110513     C                   EXSR      $MEAWRT
104700110513     C                   ELSE
104800110513     C                   EXSR      $HMOWRT
104900110513     C                   ENDIF
105000150814
105100101214     C                   ADD       1             C#RECCNT
105200101214     C                   ADD       1             B#RECCNT
105300161108
105400110513     C                   EVAL      @STEP = 'PREP6'
105500161108
105600110513     C                   ENDSR
105700161108
105800161108      *=============================================================================
105900161108      * DENTAL
106000161108      *=============================================================================
106100161108
106200101214     C     $PREP6        BEGSR
106300161108
106400161108     C                   IF        D#CNE = 0
106500161108     C                   EVAL      @STEP = 'PREPC'
106600161108     C                   LEAVESR
106700161108     C                   ENDIF
106800161108
106900161108     C                   EVAL      KF@PLN = D@PLN(D#CNE)
107000161108     C                   EVAL      KF@ENR = D@ENR(D#CNE)
107100161108
107200120803     C     KL#TSAP       CHAIN     AEF01
107300120803     C                   IF        NOT %FOUND(AET001WF)
107400120803     C                   LEAVESR
107500120803     C                   ENDIF
107600161108
107700161108     C                   IF        TERM_DEN = YES
107800161108     C                   EXSR      $WRTERM
107900161108     C                   ENDIF
108000161108
108100110513     C                   EVAL      @PLANIN = KF@PLN
108200111020     C                   EVAL      ENR@IN = D@ENR(D#CNE)
108300161108
108400111011     C                   EXSR      $QUIK
108500161108
108600110513     C                   EXSR      $PLANSRCH
108700161108
108800110513     C                   IF        PLN@CAT = *BLANKS
108900110513     C                   SETON                                        H2
109000110513     C                   ENDIF
109100161108
109200161108     C                   EVAL      @STEP = 'STEP6'
109300110725     C                   EVAL      #XSX = D@FRM(D#CNE)
109400110725     C                   EVAL      D@MBREFF = #XSX
109500161108
109600101213     C                   ENDSR
109700161108
109800161108      *=============================================================================
109900161108      * DENTAL FORMAT
110000161108      *=============================================================================
110100161108
110200161108     C     $STEP6        BEGSR
110300161108
110400110513     C                   EXSR      $DENWRT
110500161108
110600161108     C                   ADD       1             C#RECCNT
110700161108     C                   ADD       1             B#RECCNT
110800161108
110900161108     C                   EVAL      @STEP = 'PREPC'
111000161108
111100161108     C                   ENDSR
111200161108
111300161108      *=============================================================================
111400161108      * LIFE AND AD&D PLANS FOR MEMBER
111500161108      *=============================================================================
111600161108
111700130315     C     $PREPC        BEGSR
111800161108
111900161108     C                   IF        L#CNE = 0
112000161108     C                   EVAL      @STEP = 'PREP7'
112100161108     C                   LEAVESR
112200161108     C                   ENDIF
112300161108
112400161108     C                   EVAL      KF#TRM = L@TRM(L#CNE)
112500161108     C                   EVAL      KF@PLN = L@PLN(L#CNE)
112600130315     C                   EVAL      KF@ENR = L@ENR(L#CNE)
112700161108
112800130315     C     KL#TSAP       CHAIN     AEF01
112900130315     C                   IF        NOT %FOUND(AET001WF)
113000130315     C                   LEAVESR
113100130315     C                   ENDIF
113200161108
113300161108     C                   IF        TERM_LIF = YES
113400161108     C                   EXSR      $WRTERM
113500161108     C                   ENDIF
113600161108
113700130315     C                   EVAL      @PLANIN = KF@PLN
113800130315     C                   EVAL      ENR@IN = L@ENR(L#CNE)
113900161108
114000130315     C                   EXSR      $QUIK
114100161108
114200130315     C                   EXSR      $PLANSRCH
114300161108
114400130315     C                   IF        PLN@CAT = *BLANKS
114500130315     C                   SETON                                        H2
114600130315     C                   ENDIF
114700161108
114800161108     C                   EVAL      @STEP = 'STEPC'
114900130315     C                   EVAL      #XSX = L@FRM(L#CNE)
115000130315     C                   EVAL      L@MBREFF = #XSX
115100161108
115200130315     C                   ENDSR
115300161108
115400161108      *=============================================================================
115500161108      * LIFE FORMAT
115600161108      *=============================================================================
115700161108
115800161108     C     $STEPC        BEGSR
115900161108
116000130315     C                   EXSR      $LIFWRT
116100161108
116200161108     C                   ADD       1             C#RECCNT
116300161108     C                   ADD       1             B#RECCNT
116400161108
116500161108     C                   EVAL      @STEP = 'PREP7'
116600161108
116700161108     C                   ENDSR
116800161108
116900161108      *=============================================================================
117000161108
117100130315     C     $LIFWRT       BEGSR
117200161108
117300161108     C                   EVAL      X@LAY = CPCID1                               LAYOUT
117400161108     C                   EVAL      X@ELR = CPCID2                               ELR
117500161108     C                   EVAL      L@SFX = CPCID3                               SUFFIX
117600161108     C                   EVAL      L@ACCT = CPCID4                              ACCOUNT
117700161108     C                   EVAL      L@PLAN = CPCID5                              PLAN
117800161108     C                   EVAL      L@CLM = CPCID6                               CLAIM OFFICE
117900161108
117901221108       edate = L@FRM(L#CNE);
118000161108     C                   EVAL      #XSX = L@FRM(L#CNE)
118100130315     C                   MOVE      #XSX          X@EFF
118200161108
118201221108       tdate = L@TRM(L#CNE);
118300161108     C                   EVAL      #XSX = L@TRM(L#CNE)
118400161108     C                   IF        #XSX = 0 OR #XSX = 99999999
118500161108     C                   MOVE      *BLANKS       X@TRM
118600161108     C                   ELSE
118800161108
118900160809       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
119000160809       if %subdt(work_date:*d) = 01 ;
119100160809        work_date -= %days(1) ;
119200160809        num_date = %dec(work_date:*iso);
119300160809        X@TRM = %EDITC(num_date:'X');
119400160809       endif;
119500160809
119501221108       if edate = tdate;
119502221108        X@TRM = %editc(tdate:'X');
119503221108       endif;
119600161108     C                   ENDIF
119700161108
119800140313     C                   MOVE      *BLANKS       L@CBREXP
119900140313     C                   MOVE      *BLANKS       L@CBREVT
120000140313     C                   MOVE      *BLANKS       L@CBRLEN
120100161108
120200161108     C                   IF        EMPST = 'C' AND
120300130923     C                             CEXPDT > 0
120400161108     C                   MOVE      CEXPDT        L@CBREXP
120500161108     C                   MOVE      QEDT          L@CBREVT
120600161108     C                   MOVE      CEXPDT        #MINUEND
120700161108     C                   MOVE      QEDT          #SUBTRAEND
120800161108     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
120900161108     C                   Z-ADD     #DIFFRNC      #2S0
121000161108     C                   MOVE      #2S0          L@CBRLEN
121100161108     C                   ENDIF
121200161108
121300130315     C                   EVAL      L@SALARY = %EDITC(SALARY:'4')
121400161108
121500161108     C                   EXCEPT    LIFF
121600161108
121700161108     C                   ENDSR
121800161108
121900161108      *=============================================================================
122000161108
122100150817     C     $PREPD        BEGSR
122200161108
122300161108     C                   IF        L#CNE = 0
122400161108     C                   EVAL      @STEP = 'PREP7'
122500161108     C                   LEAVESR
122600161108     C                   ENDIF
122700161108
122800161108     C                   EVAL      KF#TRM = L@TRM(L#CNE)
122900161108     C                   EVAL      KF@PLN = L@PLN(L#CNE)
123000150817     C                   EVAL      KF@ENR = L@ENR(L#CNE)
123100161108
123200150817     C     KL#TSAP       CHAIN     AEF01
123300150817     C                   IF        NOT %FOUND(AET001WF)
123400150817     C                   LEAVESR
123500150817     C                   ENDIF
123600161108
123700150817     C                   EVAL      @PLANIN = KF@PLN
123800150817     C                   EVAL      ENR@IN = L@ENR(L#CNE)
123900161108
124000150817     C                   EXSR      $QUIK
124100161108
124200150817     C                   EXSR      $PLANSRCH
124300161108
124400150817     C                   IF        PLN@CAT = *BLANKS
124500150817     C                   SETON                                        H2
124600150817     C                   ENDIF
124700161108
124800161108     C                   EVAL      @STEP = 'STEPC'
124900150817     C                   EVAL      #XSX = L@FRM(L#CNE)
125000150817     C                   EVAL      L@MBREFF = #XSX
125100161108
125200150817     C                   ENDSR
125300161108
125400161108      *=============================================================================
125500161108      * VIS FORMAT
125600161108      *=============================================================================
125700161108
125800161108     C     $STEPD        BEGSR
125900161108
126000150817     C                   EXSR      $VISWRT
126100161108
126200161108     C                   ADD       1             C#RECCNT
126300161108     C                   ADD       1             B#RECCNT
126400161108
126500161108     C                   EVAL      @STEP = 'PREP7'
126600161108
126700161108     C                   ENDSR
126800161108
126900161108      *=============================================================================
127000161108
127100150817     C     $VISWRT       BEGSR
127200161108
127300161108     C                   EVAL      X@LAY = CPCID1                               LAYOUT
127400161108     C                   EVAL      X@ELR = CPCID2                               ELR
127500161108     C                   EVAL      V@SFX = CPCID3                               SUFFIX
127600161108     C                   EVAL      V@ACCT = CPCID4                              ACCOUNT
127700161108     C                   EVAL      V@PLAN = CPCID5                              PLAN
127800161108     C                   EVAL      V@CLM = CPCID6                               CLAIM OFFICE
127900161108
127901221108       edate = V@FRM(V#CNE);
128000161108     C                   EVAL      #XSX = V@FRM(V#CNE)
128100150817     C                   MOVE      #XSX          X@EFF
128200161108
128201221108       tdate = V@TRM(V#CNE);
128300161108     C                   EVAL      #XSX = V@TRM(V#CNE)
128400161108     C                   IF        #XSX = 0 OR #XSX = 99999999
128500161108     C                   MOVE      *BLANKS       X@TRM
128600161108     C                   ELSE
128800161108
128900160809       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
129000160809       if %subdt(work_date:*d) = 01 ;
129100160809        work_date -= %days(1) ;
129200160809        num_date = %dec(work_date:*iso);
129300160809        X@TRM = %EDITC(num_date:'X');
129400160809       endif;
129500160809
129501221108       if edate = tdate;
129502221108        X@TRM = %editc(tdate:'X');
129503221108       endif;
129600161108     C                   ENDIF
129700161108
129800150817     C                   MOVE      *BLANKS       V@CBREXP
129900150817     C                   MOVE      *BLANKS       V@CBREVT
130000150817     C                   MOVE      *BLANKS       V@CBRLEN
130100161108
130200161108     C                   IF        EMPST = 'C' AND
130300150817     C                             CEXPDT > 0
130400161108     C                   MOVE      CEXPDT        V@CBREXP
130500161108     C                   MOVE      QEDT          V@CBREVT
130600161108     C                   MOVE      CEXPDT        #MINUEND
130700161108     C                   MOVE      QEDT          #SUBTRAEND
130800161108     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
130900161108     C                   Z-ADD     #DIFFRNC      #2S0
131000161108     C                   MOVE      #2S0          V@CBRLEN
131100161108     C                   ENDIF
131200161108
131300150817     C                   EVAL      V@SALARY = %EDITC(SALARY:'4')
131400161108
131500161108     C                   EXCEPT    VISF
131600161108
131700161108     C                   ENDSR
131800161108
131900161108      *=============================================================================
132000161108
132100101214     C     $PREP7        BEGSR
132200161108
132300101214     C     KF@SSN        CHAIN     DEPENR
132400101214     C                   IF        NOT %FOUND(DEPNDC)
132500101214     C                   EVAL      @STEP = 'STEP2'
132600101214     C                   LEAVESR
132700101214     C                   ENDIF
132800161108
132900101214     C     KF@SSN        SETLL     DEPENR
133000161108
133100101214     C                   EVAL      @STEP = 'STEP7'
133200161108
133300101214     C                   ENDSR
133400161108
133500161108      *=============================================================================
133600161108
133700101214     C     $STEP7        BEGSR
133800161108
133900101214     C     KF@SSN        READE     DEPENR
134000161108
134100101214     C                   IF        %EOF(DEPNDC)
134200101214     C                   EVAL      @STEP = 'STEP2'
134300101214     C                   LEAVESR
134400101214     C                   ENDIF
134500161108
134600101214     C                   EVAL      KF@SEQ = DPSEQ#
134700120803     C                   EVAL      WRT@TYPE = 'DEPEND'
134800161108
134900101214     C     KL#DCV        CHAIN     DCOVR
135000101214     C                   IF        NOT %FOUND(DCOVA)
135100101214     C                   LEAVESR
135200101214     C                   ENDIF
135300161108
135400101214     C                   EXSR      $CLRDCV
135500101214     C     KL#DCV        SETLL     DCOVR
135600161108
135700101214     C                   EVAL      @STEP = 'STEP8'
135800161108
135900101214     C                   ENDSR
136000161108
136100161108      *=============================================================================
136200161108
136300101214     C     $STEP8        BEGSR
136400161108
136500101214     C     KL#DCV        READE     DCOVR
136600161108
136700101214     C                   IF        %EOF(DCOVA)
136800101214     C                   EVAL      @STEP = 'PREP9'
136900101214     C                   LEAVESR
137000101214     C                   ENDIF
137100161108
137600110513     C                   EVAL      @PLANIN = DVPLAN
137700120803     C                   EVAL      KF@PLN = DVPLAN
137800120803     C     KL#TSAP       CHAIN     AEF01
137900120803     C                   IF        NOT %FOUND(AET001WF)
138000120803     C                   LEAVESR
138100120803     C                   ENDIF
138200161108
138300110802     C                   EXSR      $QUIKD
138400161108
138500110513     C                   EXSR      $PLANSRCH
138600161108
138700110513     C                   IF        PLN@CAT = *BLANKS
138800110513     C                   LEAVESR
138900110513     C                   ENDIF
139000161108
139100101214     C                   EVAL      #CANCEL = CCANDT
139200101214     C                   IF        #CANCEL = 0
139300101214     C                   EVAL      #CANCEL = 99999999
139400101214     C                   ENDIF
139500161108
139600161108      * DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL; LIFE IS MEMBER ONLY
139700161108     C                   IF        PLN@CAT = 'DEN'
139800161108     C                   IF        D#CNE > 0
139900161108     C                   IF        D@TRM(D#CNE) = 99999999
140000130131     C                   LEAVESR
140100130131     C                   ENDIF
140200130131     C                   ENDIF
140300161108     C                   ADD       1             D#CNE
140400161108     C                   EVAL      D@PLN(D#CNE) = DVPLAN
140500161108     C                   EVAL      D@ENR(D#CNE) = *BLANKS
140600161108     C                   EVAL      D@FRM(D#CNE) = DENRDT
140700161108     C                   EVAL      D@TRM(D#CNE) = #CANCEL
140800161108     C                   ELSE
140900161108     C                   IF        M#CNE > 0
141000161108     C                   IF        M@TRM(M#CNE) = 99999999
141100130131     C                   LEAVESR
141200130131     C                   ENDIF
141300130131     C                   ENDIF
141400101214     C                   ADD       1             M#CNE
141500101214     C                   EVAL      M@PLN(M#CNE) = DVPLAN
141600101214     C                   EVAL      M@ENR(M#CNE) = *BLANKS
141700101214     C                   EVAL      M@FRM(M#CNE) = DENRDT
141800101214     C                   EVAL      M@TRM(M#CNE) = #CANCEL
141900161108     C                   ENDIF
142000161108
142100161108     C                   ENDSR
142200161108
142300161108      *=============================================================================
142400161108
142500111011     C     $QUIKD        BEGSR
142600161108
142700120803     C                   EXSR      $QUIK
142800161108
142900120409     C                   ENDSR
143000161108
143100161108      *=============================================================================
143200161108
143300101214     C     $PREP9        BEGSR
143400161108
143500101214     C                   IF        D#CNE = 0 AND M#CNE = 0
143600101214     C                   EVAL      @STEP = 'STEP7'
143700101214     C                   LEAVESR
143800101214     C                   ENDIF
143900161108
144000130315     C                   EVAL      L#CNE = 0
144100130315     C                   EVAL      TERM_LIF = NO
144200101214     C                   EVAL      TERM_DEN = NO
144300101214     C                   EVAL      TERM_MED = NO
144400130520     C                   EVAL      @STEP = 'STEP9'
144500161108
144600130520     C                   IF        D#CNE = 0 AND M#CNE = 0 AND L#CNE > 0
144700130520     C                   IF        L@TRM(L#CNE) <> 99999999
144800130520     C                   EXSR      $CHKHEM
144900130520     C                   ENDIF
145000130520     C                   LEAVESR
145100130520     C                   ENDIF
145200161108
145300130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE = 0
145400130520     C                   IF        M@TRM(M#CNE) <> 99999999
145500130520     C                   EXSR      $CHKHEM
145600130520     C                   ENDIF
145700130520     C                   LEAVESR
145800130520     C                   ENDIF
145900161108
146000130520     C                   IF        D#CNE = 0 AND M#CNE > 0 AND L#CNE > 0
146100130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
146200130520     C                              M@TRM(M#CNE) <> 99999999)
146300130520     C                   EXSR      $CHKHEM
146400130520     C                   ENDIF
146500130520     C                   LEAVESR
146600130520     C                   ENDIF
146700161108
146800130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE = 0
146900130520     C                   IF        D@TRM(D#CNE) <> 99999999
147000130520     C                   EXSR      $CHKHEM
147100130520     C                   ENDIF
147200130520     C                   LEAVESR
147300130520     C                   ENDIF
147400161108
147500130520     C                   IF        D#CNE > 0 AND M#CNE = 0 AND L#CNE > 0
147600130520     C                   IF        (L@TRM(L#CNE) <> 99999999 OR
147700130520     C                              D@TRM(D#CNE) <> 99999999)
147800130520     C                   EXSR      $CHKHEM
147900130520     C                   ENDIF
148000130520     C                   LEAVESR
148100130520     C                   ENDIF
148200161108
148300130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE = 0
148400130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
148500130520     C                              M@TRM(M#CNE) <> 99999999)
148600130520     C                   EXSR      $CHKHEM
148700130520     C                   ENDIF
148800130520     C                   LEAVESR
148900130520     C                   ENDIF
149000161108
149100130520     C                   IF        D#CNE > 0 AND M#CNE > 0 AND L#CNE > 0
149200130520     C                   IF        (D@TRM(D#CNE) <> 99999999 OR
149300130520     C                              L@TRM(L#CNE) <> 99999999 OR
149400130520     C                              M@TRM(M#CNE) <> 99999999)
149500130520     C                   EXSR      $CHKHEM
149600130520     C                   ENDIF
149700130520     C                   LEAVESR
149800130520     C                   ENDIF
149900161108
150000101214     C                   ENDSR
150100161108
150200161108      *=============================================================================
150300161108      * GENERATE DEPENDENT RECORD
150400161108      *=============================================================================
150500101214     C     $STEP9        BEGSR
150600161108
150700110513     C                   EVAL      WRT@TYPE = 'DEPEND'
150800161108
150900110513     C                   IF        D#CNE = 0 AND M#CNE = 0
151000110513     C                   EVAL      @STEP = 'STEP7'
151100110513     C                   LEAVESR
151200110513     C                   ENDIF
151300161108
151400101214     C                   EVAL      @SS2   = %EDITC(DEPSS#:'X')
151500101210     C                   MOVEL(P)  DLNAME        @LN
151600101210     C                   MOVEL(P)  DFNAME        @FN
151700101210     C                   EVAL      @MI    = DMI
151800161108
151900101210     C                   SELECT
152000101210     C                   WHEN      DRELCD = 'RWI'
152100101210     C                   EVAL      @REL   = '02'
152200101210     C                   WHEN      DRELCD = 'RHU'
152300101210     C                   EVAL      @REL   = '03'
152400101210     C                   WHEN      DRELCD = 'RSO'
152500101210     C                   EVAL      @REL   = '04'
152600101210     C                   WHEN      DRELCD = 'RDA'
152700101210     C                   EVAL      @REL   = '05'
152800130218     C                   WHEN      DRELCD = 'RPA'
152900130218     C                   EVAL      @REL   = '14'
153000130225     C                   OTHER
153100130225     C                   EVAL      @REL   = *BLANKS
153200101210     C                   ENDSL
153300161108
153400101210     C                   SELECT
153500101210     C                   WHEN      DSTUDN = 'Y'
153600101210     C                   EVAL      @SPEC = '1'
153700140812     C                   WHEN      DHNDCP = '3'
153800101210     C                   EVAL      @SPEC = '3'
153900130225     C                   OTHER
154000130225     C                   EVAL      @SPEC = *BLANKS
154100101210     C                   ENDSL
154200161108
154300101210     C                   EVAL      @SEX   = DSEX
154400101210     C                   EVAL      @DOB   = %EDITC(DBIRTH:'X')
154500161108
154600101210     C                   IF        DCOB = 'Y'
154700101210     C                   EVAL      @COB   = 'Y'
154800101210     C                   EVAL      @COBC  = 'OT'
154900101210     C                   EVAL      @COBN  = DCOBPN
155000130225     C                   ELSE
155100130225     C                   EVAL      @COB   = *BLANKS
155200130225     C                   EVAL      @COBC  = *BLANKS
155300130225     C                   EVAL      @COBN = *BLANKS
155400101210     C                   ENDIF
155500161108
155600101214     C                   IF        DADDR1 <> ADDR1
155700101210     C                   EVAL      @AD1   = %TRIM(DADDR1)
155800101210     C                   EVAL      @AD2   = %TRIM(DADDR2)
155900101210     C                   EVAL      @CTY   = %TRIM(DCITY)
156000101210     C                   EVAL      @ST    = DSTATE
156100101210     C                   MOVE      *BLANKS       @9                9
156200101214     C                   IF        DZIP = 0
156300101214     C                   EVAL      @9   = %EDITC(ZIP:'X')
156400101214     C                   ELSE
156500101210     C                   EVAL      @9   = %EDITC(DZIP:'X')
156600101214     C                   ENDIF
156700101210     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
156800101210     C                   EVAL      @PHN   = %EDITC(DAREA:'X') +
156900101210     C                                      %EDITC(DPHONE:'X')
157000101214     C                   ENDIF
157100161108
157200170317       // if cobra and effective date > 12/01/2016...
157300170317       //if empst = 'C';
157400170317       // if qedt >= effectiveDateD;
157500170317       //  @empst = 'AC';
157600170317       // endif;
157700170317       //endif;
157800101210     C                   EXCEPT    MBRF
157900101214     C                   ADD       1             C#RECCNT
158000161108
158100101214     C                   EVAL      @STEP = 'PREPA'
158200161108
158300101210     C                   ENDSR
158400161108
158500161108      *=============================================================================
158600161108
158700101214     C     $PREPA        BEGSR
158800161108
158900101214     C                   IF        M#CNE = 0
159000101214     C                   EVAL      @STEP = 'PREPB'
159100101214     C                   LEAVESR
159200101214     C                   ENDIF
159300161108
159400101214     C                   EVAL      KF@PLN = M@PLN(M#CNE)
159500120803     C     KL#TSAP       CHAIN     AEF01
159600120803     C                   IF        NOT %FOUND(AET001WF)
159700120803     C                   LEAVESR
159800120803     C                   ENDIF
159900161108
160000101214     C                   IF        TERM_MED = YES
160100101214     C                   EXSR      $WRTERM
160200101214     C                   ENDIF
160300161108
160400110513     C                   EVAL      @PLANIN = KF@PLN
160500161108
160600110802     C                   EXSR      $QUIKD
160700161108
160800110513     C                   EXSR      $PLANSRCH
160900161108
161000110513     C                   IF        PLN@CAT = *BLANKS
161100110513     C                   SETON                                        H2
161200110513     C                   ENDIF
161300161108
161400110513     C                   EVAL      @STEP = 'STEPA'
161500161108
161600101214     C                   ENDSR
161700161108
161800161108      *=============================================================================
161900161108
162000101214     C     $STEPA        BEGSR
162100161108
162200110513     C                   IF        CPCID1 = 'MEA'
162400150511     C                             or CPCID1 = 'PPO'
162500110513     C                   EXSR      $MEAWRT
162600110513     C                   ELSE
162700110513     C                   EXSR      $HMOWRT
162800110513     C                   ENDIF
162900161108
163000110513     C                   ADD       1             C#RECCNT
163100110513     C                   ADD       1             B#RECCNT
163200161108
163300110513     C                   EVAL      @STEP = 'PREPB'
163400161108
163500110513     C                   ENDSR
163600161108
163700161108      *=============================================================================
163800161108
163900101214     C     $PREPB        BEGSR
164000161108
164100161108     C                   IF        D#CNE = 0
164200161108     C                   EVAL      @STEP = 'STEP7'
164300161108     C                   LEAVESR
164400161108     C                   ENDIF
164500161108
164600161108     C                   EVAL      KF@PLN = D@PLN(D#CNE)
164700120803     C     KL#TSAP       CHAIN     AEF01
164800120803     C                   IF        NOT %FOUND(AET001WF)
164900120803     C                   LEAVESR
165000120803     C                   ENDIF
165100161108
165200161108     C                   IF        TERM_DEN = YES
165300161108     C                   EXSR      $WRTERM
165400161108     C                   ENDIF
165500161108
165600110513     C                   EVAL      @PLANIN = KF@PLN
165700161108
165800110802     C                   EXSR      $QUIKD
165900161108
166000110513     C                   EXSR      $PLANSRCH
166100161108
166200110513     C                   IF        PLN@CAT = *BLANKS
166300110513     C                   SETON                                        H2
166400110513     C                   ENDIF
166500161108
166600101214     C                   EVAL      @STEP = 'STEPB'
166700161108
166800101214     C                   ENDSR
166900161108
167000161108      *=============================================================================
167100161108
167200161108     C     $STEPB        BEGSR
167300161108
167400110513     C                   EXSR      $DENWRT
167500161108
167600161108     C                   ADD       1             C#RECCNT
167700161108     C                   ADD       1             B#RECCNT
167800161108
167900161108     C                   EVAL      @STEP = 'STEP7'
168000161108
168100161108     C                   ENDSR
168200161108
168300161108      *=============================================================================
168400161108
168500110512     C     *INZSR        BEGSR
168600161108
168700110512     C     KL#ACCTL      KLIST
168800120803     C                   KFLD                    KF@CCTL
168900110512     C                   KFLD                    KF@TRS
169000110512     C                   KFLD                    KF@SUB
169100110512     C                   KFLD                    KF@ACC
169200161108
169300140313     C     KL#SQPCD      KLIST
169400140313     C                   KFLD                    KF@SSN
169500140313     C                   KFLD                    KF@SEQ
169600140313     C                   KFLD                    KF@SPCD
169700161108
169800120803     C     KL#TSAP       KLIST
169900120803     C                   KFLD                    KF@TRS
170000120803     C                   KFLD                    KF@SUB
170100120803     C                   KFLD                    KF@ACC
170200120803     C                   KFLD                    KF@PLN
170300161108
170400110512     C     KL#TSA        KLIST
170500110512     C                   KFLD                    KF@TRS
170600110512     C                   KFLD                    KF@SUB
170700110512     C                   KFLD                    KF@ACC
170800161108
170900110512     C     KL#MPLN       KLIST
171000110512     C                   KFLD                    KF@SSN
171100110512     C                   KFLD                    KF@SEQ
171200110512     C                   KFLD                    KF@TRS
171300110512     C                   KFLD                    KF@SUB
171400110512     C                   KFLD                    KF@ACC
171500161108
171600110512     C     KL#CPLN       KLIST
171700120803     C                   KFLD                    KF@CCTL
171800110512     C                   KFLD                    KF@TRS
171900110512     C                   KFLD                    KF@SUB
172000110512     C                   KFLD                    KF@ACC
172100110512     C                   KFLD                    KF@CCTR
172200110512     C                   KFLD                    KF@PLN
172300161108
172400110512     C     KL#DCV        KLIST
172500110512     C                   KFLD                    KF@SSN
172600110512     C                   KFLD                    KF@SEQ
172700161108
172800110512     C     KL#MTR        KLIST
172900110512     C                   KFLD                    KF@SSN
173000110512     C                   KFLD                    KF@SEQ
173100110512     C                   KFLD                    KF#TRM
173200110512     C                   KFLD                    KF@PLN
173300110512     C                   KFLD                    KF@ENR
173400110512     C                   KFLD                    KF@TRS
173500110512     C                   KFLD                    KF@SUB
173600110512     C                   KFLD                    KF@ACC
173700161108
173800110512     C     KL#PCP        KLIST
173900110512     C                   KFLD                    KF@SSN
174000110512     C                   KFLD                    KF@SEQ
174100161108
174200110512     C                   EVAL      #ISO = %DATE
174300110512     C                   MOVE      #ISO          #TODAY            8 0
174400110512     C                   EVAL      #IST = %TIME
174500110512     C                   MOVE      #ISO          #XSX
174600110512     C                   MOVE      #XSX          @DATE
174700110512     C                   MOVE      #IST          #XST
174800110512     C                   MOVE      #XST          @TIME
174900161108
175000110512     C                   ENDSR
175100161108
175200161108      *=============================================================================
175300161108      * PLANS LOADED BY ACCOUNT
175400161108      *=============================================================================
175500161108
175600110513     C     $PLANLOAD     BEGSR
175700161108
175800110513     C                   EVAL      PP# = 0
175900140313     C                   DO        80
176000110513     C                   ADD       1             PP#
176100110513     C     PP#           OCCUR     CARPLN@
176200110513     C                   CLEAR                   CARPLN@
176300110513     C                   ENDDO
176400110513     C                   EVAL      PC# = 0
176500110513     C                   EVAL      PP# = 0
176600161108
176700110513     C     KL#ACCTL      SETLL     CARPLNR
176800110513     C                   DOU       %EOF(CARPLNP)
176900110513     C     KL#ACCTL      READE     CARPLNR
177000110520     C                   IF        NOT %EOF(CARPLNP)
177100161108
177200110513     C                   ADD       1             PC#
177300110513     C     PC#           OCCUR     CARPLN@
177400110513     C                   EVAL      CARPLN@ = DS@CARPLN
177500161108
177600110513     C                   ENDIF
177700161108     C                   ENDDO
177800161108
177900110513     C                   ENDSR
178000161108
178100161108      *=============================================================================
178200161108
178300110513     C     $CLRSTG       BEGSR
178400161108
178500110513     C                   EVAL      #CANCEL = 0
178600161108
178700130315     C                   EVAL      L#CNE = 0
178800130315     C                   CLEAR                   L@PLN
178900130315     C                   CLEAR                   L@ENR
179000130315     C                   CLEAR                   L@FRM
179100130315     C                   CLEAR                   L@TRM
179200161108
179300110513     C                   EVAL      D#CNE = 0
179400110513     C                   CLEAR                   D@PLN
179500110513     C                   CLEAR                   D@ENR
179600110513     C                   CLEAR                   D@FRM
179700110513     C                   CLEAR                   D@TRM
179800110513     C                   EVAL      M#CNE = 0
179900110513     C                   CLEAR                   M@PLN
180000110513     C                   CLEAR                   M@ENR
180100110513     C                   CLEAR                   M@FRM
180200110513     C                   CLEAR                   M@TRM
180300161108
180400110513     C                   EXSR      $CLRDMG
180500161108
180600110513     C                   ENDSR
180700161108
180800161108      *=============================================================================
180900161108
181000110513     C     $CLRDMG       BEGSR
181100161108
181200110513     C                   EVAL      @SS1   = *BLANKS
181300110513     C                   EVAL      @SS2   = *BLANKS
181400110513     C                   MOVE      *BLANKS       @LN
181500110513     C                   MOVEL     *BLANKS       @FN
181600110513     C                   EVAL      @MI    = *BLANKS
181700110513     C                   EVAL      @REL   = *BLANKS
181800110513     C                   EVAL      @SEX   = *BLANKS
181900110513     C                   EVAL      @DOB   = *BLANKS
182000110513     C                   EVAL      @SPEC  = *BLANKS
182100110513     C                   EVAL      @COB   = *BLANKS
182200110513     C                   EVAL      @COBC  = *BLANKS
182300110513     C                   EVAL      @COBN  = *BLANKS
182400110513     C                   EVAL      @AD1   = *BLANKS
182500110513     C                   EVAL      @AD2   = *BLANKS
182600110513     C                   EVAL      @CTY   = *BLANKS
182700110513     C                   EVAL      @ST    = *BLANKS
182800110513     C                   EVAL      @ZP5   = *BLANKS
182900110513     C                   EVAL      @PHN   = *BLANKS
183000110513     C                   EVAL      @EMPST = *BLANKS
183100110513     C                   EVAL      @HIRE  = *BLANKS
183200161108
183300110513     C                   ENDSR
183400161108
183500161108      *=============================================================================
183600161108
183700110513     C     $CHKHEM       BEGSR
183800161108
183900161108     C                   IF        L#CNE > 0 AND L@TRM(L#CNE) <> 99999999
184000161108     C                   EXSR      $CHKLIF
184100161108     C                   ENDIF
184200161108
184300161108     C                   IF        D#CNE > 0 AND D@TRM(D#CNE) <> 99999999
184400161108     C                   EXSR      $CHKDEN
184500161108     C                   ENDIF
184600200211
184700110513     C                   IF        M#CNE > 0 AND M@TRM(M#CNE) <> 99999999
184800110513     C                   EXSR      $CHKMED
184900110513     C                   ENDIF
185000161108
185100110513     C                   ENDSR
185200161108
185300161108      *=============================================================================
185400161108
185500161108     C     $CHKLIF       BEGSR
185600161108
185700161108     C                   EVAL      TERM_LIF = YES
185800161108     C                   EVAL      KF#TRM = L@TRM(L#CNE)
185900161108     C                   EVAL      KF@PLN = L@PLN(L#CNE)
186000161108     C                   EVAL      KF@ENR = L@ENR(L#CNE)
186100161108
186200161108     C     KL#MTR        CHAIN     AET081F
186300161108     C                   IF        %FOUND(AET081WF)
186400161108     C                   EVAL      L#CNE = 0
186500161108     C                   EVAL      TERM_LIF = NO
186600161108     C                   ENDIF
186700161108
186800161108     C                   ENDSR
186900161108
187000161108      *=============================================================================
187100161108
187200161108     C     $CHKVIS       BEGSR
187300161108
187400161108     C                   EVAL      TERM_VIS = YES
187500161108     C                   EVAL      KF#TRM = V@TRM(V#CNE)
187600161108     C                   EVAL      KF@PLN = V@PLN(V#CNE)
187700161108     C                   EVAL      KF@ENR = V@ENR(V#CNE)
187800161108
187900161108     C     KL#MTR        CHAIN     AET081F
188000161108     C                   IF        %FOUND(AET081WF)
188100161108     C                   EVAL      V#CNE = 0
188200161108     C                   EVAL      TERM_VIS = NO
188300161108     C                   ENDIF
188400161108
188500161108     C                   ENDSR
188600161108
188700161108      *=============================================================================
188800161108
188900161108     C     $CHKDEN       BEGSR
189000161108
189100161108     C                   EVAL      TERM_DEN = YES
189200161108     C                   EVAL      KF#TRM = D@TRM(D#CNE)
189300161108     C                   EVAL      KF@PLN = D@PLN(D#CNE)
189400161108     C                   EVAL      KF@ENR = D@ENR(D#CNE)
189500161108
189600161108     C     KL#MTR        CHAIN     AET081F
189700161108     C                   IF        %FOUND(AET081WF)
189800161108     C                   EVAL      D#CNE = 0
189900161108     C                   EVAL      TERM_DEN = NO
190000161108     C                   ENDIF
190100161108
190200161108     C                   ENDSR
190300161108
190400161108      *=============================================================================
190500161108
190600110513     C     $CHKMED       BEGSR
190700161108
190800110513     C                   EVAL      TERM_MED = YES
190900110513     C                   EVAL      KF#TRM = M@TRM(M#CNE)
191000110513     C                   EVAL      KF@PLN = M@PLN(M#CNE)
191100110513     C                   EVAL      KF@ENR = M@ENR(M#CNE)
191101200211
191300110802     C     KL#MTR        CHAIN     AET081F
191400110802     C                   IF        %FOUND(AET081WF)
191500110513     C                   EVAL      TERM_MED = NO
191600110513     C                   EVAL      M#CNE = 0
191700110513     C                   ENDIF
191800161108
191900110513     C                   ENDSR
192000161108
192100161108      *=============================================================================
192200161108
192300110513     C     $PLANSRCH     BEGSR
192400161108
192500130315     C                   MOVE      *BLANKS       PLN@CAT           5
192600110513     C                   EVAL      PP# = 0
192700110513     C                   CLEAR                   DS@CARPLN
192800161108
192900110513     C                   DO        PC#
193000161108
193100110513     C                   ADD       1             PP#
193200161108     C     PP#           OCCUR     CARPLN@
193300161108
193400110513     C                   IF        XPPLAN = @PLANIN AND
193500110513     C                             XPCCTR = @CCTRIN
193600110513     C                   EVAL      DS@CARPLN = CARPLN@
193700110513     C                   LEAVE
193800110513     C                   ENDIF
193900161108
194000110513     C                   ENDDO
194100161108
194200110513     C                   IF        CPPLAN = *BLANKS
194300110513     C                   LEAVESR
194400110513     C                   ENDIF
194500161108
194600110513     C                   SELECT
194700110520     C                   WHEN      CPCID1 = 'MEA' OR
194800150511     C                             CPCID1 = 'HMO' OR
195000150728     C                             CPCID1 = 'PPO'
195100110520     C                   EVAL      PLN@CAT = 'MED'
195200150511
195300130409     C                   WHEN      CPCID1 = 'LIFE'
195400130409     C                   EVAL      PLN@CAT = 'LIFE'
195500150511
195600110520     C                   WHEN      CPCID1 = 'DEN'
195700110520     C                   EVAL      PLN@CAT = 'DEN'
195800150814
195900110513     C                   ENDSL
196000161108
196100110513     C                   ENDSR
196200161108
196300161108      *=============================================================================
196400161108
196500110513     C     $ENROLL       BEGSR
196600161108
196700110513     C                   EVAL      ENR@OUT = *BLANKS
196800110513     C                   SELECT
196900110513     C                   WHEN      ENR@IN = 'TIN' OR ENR@IN = 'TMI'
197000110513     C                   EVAL      ENR@OUT = 'S'
197100110513     C                   WHEN      ENR@IN = 'THW'
197200110513     C                   EVAL      ENR@OUT = 'C'
197300110513     C                   WHEN      ENR@IN = 'TPC'
197400110513     C                   EVAL      ENR@OUT = 'P'
197500110513     C                   WHEN      ENR@IN = 'TP2'
197600110513     C                   EVAL      ENR@OUT = 'Q'
197700110513     C                   WHEN      ENR@IN = 'TFA'
197800110513     C                   EVAL      ENR@OUT = 'F'
197900110513     C                   ENDSL
198000161108
198100110513     C                   ENDSR
198200161108
198300161108      *=============================================================================
198400161108
198500110513     C     $WRTERM       BEGSR
198600161108
198700110802     C                   CLEAR                   AET081F
198800110513     C                   EVAL      NTSSNO         = KF@SSN
198900110513     C                   EVAL      NTDEPNO        = KF@SEQ
199000110513     C                   EVAL      NTTERMDT       = KF#TRM
199100110513     C                   EVAL      NTPLAN         = KF@PLN
199200110513     C                   EVAL      NTCOVTP        = KF@ENR
199300110513     C                   EVAL      NTTRST         = KF@TRS
199400110513     C                   EVAL      NTSUB#         = KF@SUB
199500110513     C                   EVAL      NTACCT         = KF@ACC
199600110513     C                   EVAL      NTTRANSDT      = #TODAY
199700110802     C                   WRITE     AET081F
199800161108
199900110513     C                   ENDSR
200000161108
200100161108      *=============================================================================
200200161108
200300110513     C     $HMOWRT       BEGSR
200400161108
200500110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
200600110513     C                   EVAL      X@ELR = CPCID2                               FILE NUMBER
200700110513     C                   EVAL      M@CC = CACID2                                COMPANY CODE
200800110513     C                   EVAL      M@CLASS = CPCID3                             CLASS CODE
200900110513     C                   EVAL      M@PLAN = CPCID4                              PLAN NUMBER
201000161108
201001221108       edate = M@FRM(M#CNE);
201100110513     C                   EVAL      #XSX = M@FRM(M#CNE)
201200110725     C                   IF        WRT@TYPE = 'DEPEND' AND
201300110725     C                             #XSX < M@MBREFF
201400110725     C                   MOVE      M@MBREFF      X@EFF
201500110725     C                   ELSE
201600110725     C                   MOVE      #XSX          X@EFF
201700110725     C                   ENDIF
201800161108
201801221108       tdate = M@TRM(M#CNE);
201900110513     C                   EVAL      #XSX = M@TRM(M#CNE)
202000110513     C                   IF        #XSX = 0 OR #XSX = 99999999
202100110513     C                   MOVE      *BLANKS       X@TRM
202200110513     C                   ELSE
202400161108
202500160809       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
202600160809       if %subdt(work_date:*d) = 01 ;
202700160809        work_date -= %days(1) ;
202800160809        num_date = %dec(work_date:*iso);
202900160809        X@TRM = %EDITC(num_date:'X');
203000160809       endif;
203001221108
203002221108       if edate = tdate;
203003221108        X@TRM = %editc(tdate:'X');
203004221108       endif;
203100160809
203200110513     C                   ENDIF
203300161108
203400110513     C                   IF        WRT@TYPE = 'MEMBER'
203500110513     C                   EVAL      KF@SEQ = 0
203600110513     C                   EVAL      ENR@IN = M@ENR(M#CNE)
203700110513     C                   EXSR      $ENROLL
203800110513     C                   EVAL      X@TIER = ENR@OUT
203900110513     C                   ELSE
204000110513     C                   EVAL      X@TIER = *BLANKS
204100110513     C                   ENDIF
204200161108
204300140313     C                   EVAL      KF@SPCD = 'MED'
204400140313     C                   EVAL      M@PCP = *BLANKS
204500140313     C                   EVAL      M@NPI = *BLANKS
204600140313     C                   EVAL      M@PCPCI = *BLANKS
204700161108
204800140313     C                   EXSR      $PCP
204900161108
205000140313     C                   IF        DOCTOR <> *BLANKS
205100140313     C                   EVAL      M@PCP = DOCTOR
205200140313     C                   EVAL      M@NPI = 'Y'
205300140313     C                   EVAL      M@PCPCI = '0'
205400140313     C                   ENDIF
205500161108
205600110513     C                   EXCEPT    HMOF
205700161108
205800110513     C                   ENDSR
205900161108
206000161108      *=============================================================================
206100161108
206200110513     C     $MEAWRT       BEGSR
206300161108
206400110513     C                   EVAL      X@LAY = CPCID1                               LAYOUT
206500110513     C                   EVAL      X@ELR = CPCID2                               ELR
206600140313     C                   EVAL      E@SFX = CPCID3                               SUFFIX
206700140313     C                   EVAL      E@ACCT = CPCID4                              ACCOUNT
206800140313     C                   EVAL      E@PLAN = CPCID5                              PLAN
206900140313     C                   EVAL      E@CLM = CPCID6                               CLAIM OFFICE
207000161108
207001221108       edate = M@FRM(M#CNE);
207100110513     C                   EVAL      #XSX = M@FRM(M#CNE)
207200110725     C                   IF        WRT@TYPE = 'DEPEND' AND
207300110725     C                             #XSX < M@MBREFF
207400110725     C                   MOVE      M@MBREFF      X@EFF
207500110725     C                   ELSE
207600110725     C                   MOVE      #XSX          X@EFF
207700110725     C                   ENDIF
207800161108
207801221108       tdate = M@TRM(M#CNE);
207900110513     C                   EVAL      #XSX = M@TRM(M#CNE)
208000110513     C                   IF        #XSX = 0 OR #XSX = 99999999
208100110513     C                   MOVE      *BLANKS       X@TRM
208200110513     C                   ELSE
208400161108
208500160809       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
208600160809       if %subdt(work_date:*d) = 01 ;
208700160809        work_date -= %days(1) ;
208800160809        num_date = %dec(work_date:*iso);
208900160809        X@TRM = %EDITC(num_date:'X');
209000160809       endif;
209001221108
209002221108       if edate = tdate;
209003221108        X@TRM = %editc(tdate:'X');
209004221108       endif;
209100160809
209200110513     C                   ENDIF
209300161108
209400140313     C                   MOVE      *BLANKS       E@CBREXP
209500140313     C                   MOVE      *BLANKS       E@CBREVT
209600140313     C                   MOVE      *BLANKS       E@CBRLEN
209700140313     C                   IF        WRT@TYPE = 'MEMBER'
209800140425     C                   IF        EMPST = 'C' AND
209900140425     C                             CEXPDT > 0
210000140313     C                   MOVE      CEXPDT        E@CBREXP
210100140313     C                   MOVE      QEDT          E@CBREVT
210200140313     C                   MOVE      CEXPDT        #MINUEND
210300140313     C                   MOVE      QEDT          #SUBTRAEND
210400140313     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
210500140313     C                   Z-ADD     #DIFFRNC      #2S0
210600140313     C                   MOVE      #2S0          E@CBRLEN
210700140313     C                   ENDIF
210800140313     C                   ENDIF
210900161108
211000140313     C                   EVAL      *IN80 = *OFF
211100140313     C                   EVAL      KF@SPCD = 'MED'
211200140313     C                   EVAL      E@PCP = *BLANKS
211300140313     C                   EXSR      $PCP
211400140313     C                   IF        DOCTOR <> *BLANKS
211500140313     C                   EVAL      E@PCP = DOCTOR
211600140313     C                   EVAL      *IN80 = *ON
211700140313     C                   ENDIF
211800150511
211900150511     C                   eval      medType = cpcid1
212000150511
212100161108       // if cobra and effective date > 12/01/2016...
212200170317       //if empst = 'C';
212300170317       // if e@cbrevt >= effectiveDate;
212400170317       //  @empst = 'AC';
212500170317       //   e@cbrexp = ' ';
212600170317       //   e@cbrevt = ' ';
212700170317       //  e@cbrlen = ' ';
212800170317       // endif;
212900170317       //endif;
213000161108
213100140313     C                   EXCEPT    MEAF
213200161108
213300110513     C                   ENDSR
213400150814
213500161108      *=============================================================================
213600161108
213700140313     C     $PCP          BEGSR
213800161108
213900140313     C                   MOVE      *BLANKS       DOCTOR            7
214000140313     C     KL#SQPCD      CHAIN     PCPR
214100140313     C                   IF        NOT %FOUND(PCPL1)
214200140313     C                   LEAVESR
214300140313     C                   ENDIF
214400140313     C     KL#SQPCD      SETLL     PCPR
214500140313     C                   DOU       %EOF(PCPL1)
214600140313     C     KL#SQPCD      READE     PCPR
214700140313     C                   IF        NOT %EOF(PCPL1) AND PCCAN = 0
214800140313     C                   MOVEL(P)  PCID#         DOCTOR
214900140313     C                   LEAVESR
215000140313     C                   ENDIF
215100140313     C                   ENDDO
215200161108
215300140313     C                   ENDSR
215400161108
215500161108      *=============================================================================
215600161108
215700110513     C     $CLRDCV       BEGSR
215800161108
215900110513     C                   MOVE      *BLANKS       @LN
216000110513     C                   MOVEL     *BLANKS       @FN
216100110513     C                   EVAL      @SS2   = *BLANKS
216200110513     C                   EVAL      @MI    = *BLANKS
216300110513     C                   EVAL      @REL   = *BLANKS
216400110513     C                   EVAL      @SEX   = *BLANKS
216500110513     C                   EVAL      @DOB   = *BLANKS
216600110513     C                   EVAL      @SPEC  = *BLANKS
216700110513     C                   EVAL      @COB   = *BLANKS
216800110513     C                   EVAL      @COBC  = *BLANKS
216900110513     C                   EVAL      @COBN  = *BLANKS
217000161108
217100110513     C                   EVAL      #CANCEL = 0
217200110513     C                   EVAL      D#CNE = 0
217300110513     C                   CLEAR                   D@PLN
217400110513     C                   CLEAR                   D@ENR
217500110513     C                   CLEAR                   D@FRM
217600110513     C                   CLEAR                   D@TRM
217700110513     C                   EVAL      M#CNE = 0
217800110513     C                   CLEAR                   M@PLN
217900110513     C                   CLEAR                   M@ENR
218000110513     C                   CLEAR                   M@FRM
218100110513     C                   CLEAR                   M@TRM
218200161108
218300110513     C                   ENDSR
218400161108
218500161108      *=============================================================================
218600161108
218700110513     C     $DENWRT       BEGSR
218800161108
218900161108     C                   EVAL      X@LAY = CPCID1                               LAYOUT
219000161108     C                   EVAL      X@ELR = CPCID2                               ELR
219100161108     C                   EVAL      D@SFX = CPCID3                               SUFFIX
219200161108     C                   EVAL      D@ACCT = CPCID4                              ACCOUNT
219300161108     C                   EVAL      D@PLAN = CPCID5                              PLAN
219400161108     C                   EVAL      D@CLM = CPCID6                               CLAIM OFFICE
219500110524     C                   EVAL      DNTLATE = '0'
219600161108
219601221108       edate = D@FRM(D#CNE);
219700161108     C                   EVAL      #XSX = D@FRM(D#CNE)
219800110725     C                   IF        WRT@TYPE = 'DEPEND' AND
219900110725     C                             #XSX < D@MBREFF
220000110725     C                   MOVE      D@MBREFF      X@EFF
220100110725     C                   ELSE
220200110725     C                   MOVE      #XSX          X@EFF
220300110725     C                   ENDIF
220400161108
220401221108       tdate = D@TRM(D#CNE);
220500161108     C                   EVAL      #XSX = D@TRM(D#CNE)
220600161108     C                   IF        #XSX = 0 OR #XSX = 99999999
220700161108     C                   MOVE      *BLANKS       X@TRM
220800161108     C                   ELSE
220900161108     C****               MOVE      #XSX          X@TRM
221000161108
221100160809       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
221200160809       if %subdt(work_date:*d) = 01 ;
221300160809        work_date -= %days(1) ;
221400160809        num_date = %dec(work_date:*iso);
221500160809        X@TRM = %EDITC(num_date:'X');
221600160809       endif;
221700160809
221701221108       if edate = tdate;
221702221108        X@TRM = %editc(tdate:'X');
221703221108       endif;
221800161108     C                   ENDIF
221900161108
222000130211     C                   MOVE      *BLANKS       D@CBREXP
222100130211     C                   MOVE      *BLANKS       D@CBREVT
222200130211     C                   MOVE      *BLANKS       D@CBRLEN
222300110513     C                   IF        WRT@TYPE = 'MEMBER'
222400161108     C                   IF        EMPST = 'C' AND CEXPDT <> 0
222500161108     C                   MOVE      CEXPDT        D@CBREXP
222600161108     C                   MOVE      QEDT          D@CBREVT
222700161108     C                   MOVE      CEXPDT        #MINUEND
222800161108     C                   MOVE      QEDT          #SUBTRAEND
222900161108     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
223000161108     C                   Z-ADD     #DIFFRNC      #2S0
223100161108     C                   MOVE      #2S0          D@CBRLEN
223200161108     C                   ENDIF
223300161108     C                   ENDIF
223400161108
223500161108     C                   MOVE      '0'           D@OOAI
223600161108
223700140313     C                   EVAL      KF@SPCD = 'DEN'
223800140313     C                   EVAL      D@PCD = *BLANKS
223900140313     C                   EVAL      *IN81 = *OFF
224000140313     C                   MOVE      *BLANKS       DOCTOR
224100161108
224200140313     C                   EXSR      $PCP
224300161108
224400140313     C                   IF        DOCTOR <> *BLANKS
224500140313     C                   EVAL      D@PCD = DOCTOR
224600140313     C                   EVAL      *IN81 = *ON
224700140313     C                   ENDIF
224800161108
224900120123     C     *LIKE         DEFINE    H@C#          BUC#
225000120123     C                   EVAL      BUC# = H@C#
225100161108
225200150630     C                   if        cacid8 > ' ' and cacid8 <> 'N/A'
225300150521     C                   eval      h@c# = cacid8
225400150630     C                   endif
225500150630
225600150601
225700161108       // if cobra and effective date > 12/01/2016...
225800170317       //if empst = 'C';
225900170317       // if d@cbrevt >= effectiveDate;
226000170317       //  @empst = 'AC';
226100170317       //   d@cbrexp = ' ';
226200170317       //   d@cbrevt = ' ';
226300170317       //  d@cbrlen = ' ';
226400170317       // endif;
226500170317       //endif;
226600161108
226700161108     C                   EXCEPT    DENF
226800120123     C                   EVAL      H@C# = BUC#
226900161108
227000161108     C                   ENDSR
227100161108
227200161108      *=============================================================================
227300161108
227400110802     OAET080WF  EADD         HDRF
227500101203     O                                            6 'HEADER'
227600101229     O                                            8 'P'
227700101206     O                       H@SI                28
227800101203     O                                           29 '0'
227900101203     O                       C1                  43
228000101203     O                       D1                  51
228100101203     O                       T1                  57
228200101206     O                                          131 'CONSOLIDATED ELIGIBILITY'
228300110502     O                       H@RI               167
228400101206     O                       H@CC               169
228500101228     O                       H@GN               176
228600101206     O                       H@CN               191
228700101206     O                       H@C#               198
228800101203     O                       D2                 206
228900110825     O                                          216 'MC'
229000101223     O                                          231 '*'
229100110802     OAET080WF  EADD         MBRF
229200101203     O                                            6 'MEMBER'
229300101203     O                       @SS1                16
229400101203     O                       @SS2                25
229500101203     O                       @FN                 75
229600101203     O                       @MI                 76
229700101203     O                       @LN                 96
229800101203     O                       @REL               101
229900101203     O                       @SEX               103
230000101203     O                       @DOB               111
230100101203     O                       @SPEC              112
230200101203     O                                          113 '0'
230300101203     O                       @COB               123
230400101203     O                       @COBC              125
230500101203     O                       @COBN              145
230600101203     O                       @AD1               175
230700101203     O                       @AD2               205
230800101203     O                       @CTY               315
230900101203     O                       @ST                317
231000101203     O                       @ZP5               322
231100101203     O                       @PHN               349
231200141211     O               87                         576 '21207'
231300140626     O               88                         576 '21740'
231400141120     O               89                         576 '20171'
231500101203     O                       @EMPST             665
231600101203     O                       @HIRE              673
231700101223     O                                         1231 '*'
231800110802     OAET080WF  EADD         HMOF
231900101213     O                                            7 'BENEFIT'
232000101213     O                       X@LAY               10
232100101214     O                       X@ELR               24
232200101213     O                       M@CC                26
232300101213     O                       H@GN                38
232400101213     O                       M@CLASS             44
232500101213     O                       M@PLAN              50
232600101213     O                       X@EFF               58
232700110929     O                       X@TRM               66
232800101213     O                       X@TIER              69
232900101213     O                       M@PCP              160
233000101213     O                       M@NPI              161
233100101213     O                       M@PCPCI            186
233200101223     O                                          323 '*'
233300140313     OAET080WF  EADD         MEAF
233400140313     O                                            7 'BENEFIT'
233500150511     O                       MEDTYPE             10
233600140313     O                       X@ELR               24
233700140313     O                       H@C#                31
233800140313     O                       E@SFX               34
233900140313     O                       E@ACCT              44
234000140313     O                       E@PLAN              50
234100140313     O                       X@EFF               58
234200140313     O                       X@TRM               66
234300140313     O                       E@CLM               71
234400140313     *** PCP BGN
234500140313     O                       E@PCP              127
234600140313     O               80                         161 'N'
234700140313     O               80                         186 '0'
234800140313     *** PCP END
234900140313     O                                          389 '0'
235000140313     *** COBRA BGN
235100140313     O                       E@CBREXP           466
235200140313     O                       E@CBREVT           516
235300140313     O                       E@CBRLEN           560
235400140313     *** COBRA END
235500140313     O                                          678 '*'
235600140313    ***
235700110802     OAET080WF  EADD         DENF
235800101213     O                                            7 'BENEFIT'
235900101213     O                       X@LAY               10
236000101214     O                       X@ELR               24
236100101214     O                       H@C#                31
236200101213     O                       D@SFX               34
236300101213     O                       D@ACCT              44
236400101213     O                       D@PLAN              50
236500101213     O                       X@EFF               58
236600110929     O                       X@TRM               66
236700101213     O                       D@CLM               71
236800140313     *** PCD BGN
236900140313     O                       D@PCD              200
237000140313     O               81                         236 '0'
237100140313     *** PCD END
237200140313     O                                          389 '0'
237300140313     *** COBRA BGN
237400140313     O                       D@CBREXP           466
237500140313     O                       D@CBREVT           516
237600140313     O                       D@CBRLEN           560
237700140313     *** COBRA END
237800140313     O                       D@OOAI             609
237900140313     O                                          678 '*'
238000140313    ***
238100130315     OAET080WF  EADD         LIFF
238200130315     O                                            7 'BENEFIT'
238300130412     O                                           11 'LIFE'
238400130315     O                       X@ELR               24
238500130319     O                       H@C#3               31
238600130315     O                       L@SFX               34
238700130315     O                       L@ACCT              44
238800130315     O                       L@PLAN              50
238900130315     O                       X@EFF               58
239000130315     O                       X@TRM               66
239100130315     O                       L@CLM               71
239200130315     O                       L@CBREXP           466
239300130315     O                       L@CBREVT           516
239400130315     O                       L@CBRLEN           560
239500130315     O                       L@SALARY           658
239600130315     O                                          659 '1'
239700130315     O                                          678 '*'
239800150817     OAET080WF  EADD         VISF
239900150817     O                                            7 'BENEFIT'
240000150817     O                                           11 'VIS'
240100150817     O                       X@ELR               24
240200150817     O                       H@C#3               31
240300150817     O                       L@SFX               34
240400150817     O                       L@ACCT              44
240500150817     O                       L@PLAN              50
240600150817     O                       X@EFF               58
240700150817     O                       X@TRM               66
240800150817     O                       L@CLM               71
240900150817     O                       L@CBREXP           466
241000150817     O                       L@CBREVT           516
241100150817     O                       L@CBRLEN           560
241200150817     O                       L@SALARY           658
241300150817     O                                          659 '1'
241400150817     O                                          678 '*'
241500110802     OAET080WF  EADD         TRLF
241600101203     O                                            7 'TRAILER'
241700101203     O                       @TREC               17
241800101203     O                       D1                  25
241900101203     O                       T1                  31
242000101203     O                       @BREC               41
242100101223     O                                           69 '*'
