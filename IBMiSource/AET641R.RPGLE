000100150408      *=================================================================================
000200150408      *  CARRIER CONTROL ID #0000000127 AETNA SPECIFIC
000300150408      *  JT (Cloned from SSK 05.13.2011 TEMPLATE DESIGN)
000400150408      *
000500150408      *  08.13.2013 CLONED FROM AET0X0R
000600150408      *  08.29.2013 AETNA APPROVED FOR PRODUCTION
000700150408      *
000800150408      *
000900150408      *  ACCOUNTS SET-UP
001000150408      *  003-001-0536  Brick Bodies Fitness Service Inc
001100150511      *  003-001-0569  Planet Fitness
001200150408      *
001300150408      *  COULD NOT MAKE THIS GENERIC
001400150408      *
001500150408      *  PLAN SET UP IS REFERRED TO "SELECT" STATEMENTS.
001600150408      *    SCAN FOR "***PLANS***" TO FIND.
001700150408      *      MMMM = MEDICAL AND DDDD = DENTAL
001800150408      *
001900150408      *
002000150408      *  **INCLUDES SONDA MODIFICATION ON 7/25/2011 FOR DEP EFF DATE
002100150408      *
002200150408      *  03.13.2014 SSK ADD PCP
002300150408      *  08.11.2014 SSK RENEWAL PROCESSING.
002400150408      *  11.03.2014 SSK WEST VIRGINIA WORK LIVE RULE
002500150408      *=================================================================================
002600110803     FCARXPTP   IF   E           K DISK
002700150408      * Carrier export control master
002800150408
002900110803     FCARACCP   IF   E           K DISK
003000150408      * Carrier export control by account
003100150408
003200110803     FCARPLNP   IF   E           K DISK
003300150408      * Carrier export control by plan
003400150408
003500150330     FAET640WF  O  A F 1231        DISK
003600150408      * Flat file
003700150408
003800150408     FAET641WF  IF A E           K DISK
003900150408      * Term tracker
004000150408
004100150408     FMEMAC#1   IF   E           K DISK
004200150408      * Member by Trust, Sub#, Acct, SSN
004300150408
004400150410     FMCOVMPLN  IF   E           K DISK
004500150408      * Member coverage by SSN, Dep. Seq#, Trust, Sub#, Acct, En. Date, Can. Date, Plan
004600150408
004700150408     FDEPNDC    IF   E           K DISK
004800150408      * Dependensts by SSN, Dependent Sequence#
004900150408
005000150408     FDCOVA     IF   E           K DISK
005100150408      * Dependent Coverage by SSN, Dep. #, Trust, Sub#, En. Date, Can. Date, Plan
005200150408
005300150408     FPCPL1     IF   E           K DISK
005400150408      * Primary care physician by SSN, Dep Seq, Specialty Code
005500150408
005600150408      *=================================================================================
005700150408      * Standalone fields and data sructures
005800150408      *=================================================================================
005900150408
006000160302     D CARR#CTL        S             10A   INZ('0000000127')
006100110803     D H@RI            S             25A   INZ('042064683')                     RECEIVER ID
006200150408
006300110803     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
006400110803     D DS@CARACC     E DS                  EXTNAME(CARACCP)
006500110803     D DS@CARXPT     E DS                  EXTNAME(CARXPTP)
006600150408
006700110803     ** WORK ARRAY FOR PLANS
006800150408
006900150408      * PC# - PLAN COUNT
007000150408      * PP# - PLAN POINTER
007100150408      *
007200110803     D CARPLN@       E DS                  EXTNAME(CARPLNP)
007300140812     D                                     OCCURS(90) PREFIX(X:1)
007400110803     D PC#             S              3S 0
007500110803     D PP#             S              3S 0
007600110803     D @PLANIN         S              4A
007700110803     D @CCTRIN         S              3A
007800150408
007900110803     ** WRITE TYPE = MEMBER OR DEPEND
008000110803     D WRT@TYPE        S              6A
008100150408
008200110803     D #XST            S              6S 0
008300110803     D #IST            S               T
008400110803     D #ISO            S               D   DATFMT(*ISO)
008500110803     D #MINUEND        S               D   DATFMT(*ISO)
008600110803     D #SUBTRAEND      S               D   DATFMT(*ISO)
008700110803     D @DATE           S              8A
008800110803     D @TIME           S              6A
008900110803     D #DIFFRNC        S              5S 0
009000110803     D #2S0            S              2S 0
009100110803     D #CANCEL         S              8S 0
009200110803     D #XSX            S              8S 0
009300110803     D #XSX2           S              8S 0
009400110803     D DATE@OUT        S             10A
009500110803     D ENR@IN          S              3A
009600110803     D ENR@OUT         S              1A
009700110803     D DNTLATE         S              1A
009800150408
009900110803     D TERM_DEN        S               N
010000110803     D TERM_MED        S               N
010100110803     D YES             S               N   INZ(*ON)
010200110803     D NO              S               N   INZ(*OFF)
010300150408
010400110803     D KF@TRS          S                   LIKE(MCTRST)
010500110803     D KF@SUB          S                   LIKE(MCSUB#)
010600110803     D KF@ACC          S                   LIKE(ACC#)
010700110803     D KF@ENR          S              3A   INZ
010800110803     D KF@CARG         S              2A   INZ
010900110803     D KF@CCTR         S                   LIKE(CCFLG)
011000110803     D KF@PLN          S                   LIKE(MCPLAN)
011100110803     D KF@TRM          S                   LIKE(NTTERMDT)
011200110803     D KF#TRM          S              8S 0
011300110803     D KF@SSN          S                   LIKE(MBSSNO)
011400110803     D KF@SEQ          S                   LIKE(DPSEQ#)
011500110803     D KF@TYP          S              1A
011600110803     D KF@CDE          S              2A
011700140313     D KF@SPCD         S              5A
011800140313     D KF@MPLN         S              4A
011900150408
012000110803     D M@EARLYP        S              4A
012100110803     D M#EARLYE        S              8S 0 INZ
012200110803     D M#EARLYT        S              8S 0 INZ
012300110803     D #8D1            S              8S 0 INZ
012400110803     D D1              S              8A
012500110803     D D2              S              8A
012600110803     D T1              S              6A
012700110803     D C1              S             14A
012800150408
012900110803     D B#RECCNT        S             10S 0 INZ
013000110803     D C#RECCNT        S             10S 0 INZ
013100150408
013200110803     D @SS1            S              9A
013300110803     D @SS2            S              9A
013400110803     D @FN             S             15A
013500110803     D @MI             S              1A
013600110803     D @LN             S             20A
013700110803     D @REL            S              2A
013800110803     D @SEX            S              1A
013900110803     D @DOB            S              8A
014000110803     D @SPEC           S              1A
014100110803     D @COB            S              1A
014200110803     D @COBC           S              2A
014300110803     D @COBN           S             20A
014400110803     D @AD1            S             30A
014500110803     D @AD2            S             30A
014600110803     D @CTY            S             20A
014700110803     D @ST             S              2A
014800110803     D @ZP5            S              5A
014900110803     D @PHN            S             10A
015000110803     D @EMPST          S              2A
015100110803     D @HIRE           S              8A
015200150408
015300150408      * DENTAL ARRAYS
015400110803     D D#CNE           S              3S 0 INZ
015500110803     D D#NDX           S              3S 0 INZ
015600110803     D D@PLN           S              4A   DIM(20)
015700110803     D D@ENR           S              3A   DIM(20)
015800110803     D D@FRM           S              8S 0 DIM(20)
015900110803     D D@TRM           S              8S 0 DIM(20)
016000110803     D D@MBREFF        S              8S 0
016100150408
016200150408      * MEDICAL ARRAYS
016300150410     D M#CNE           S             10S 0 INZ
016400150410     D M#NDX           S             10S 0 INZ
016500110803     D M@PLN           S              4A   DIM(20)
016600110803     D M@ENR           S              3A   DIM(20)
016700110803     D M@FRM           S              8S 0 DIM(20)
016800110803     D M@TRM           S              8S 0 DIM(20)
016900110803     D M@MBREFF        S              8S 0
017000150408
017100110803     D H@SI            S             20A
017200110803     D H@CC            S              2A
017300110803     D H@GN            S              7A
017400110803     D H@CN            S             15A
017500110803     D H@C#            S              7A
017600150408
017700110803     D X@LAY           S              3A
017800110803     D X@ELR           S              7A
017900140313     D X@EFF           S              8A
018000140313     D X@TRM           S              8A
018100140313     D X@TIER          S              1A
018200150408
018300110803     D M@CC            S              2A
018400110803     D M@CLASS         S              5A
018500110803     D M@PLAN          S              6A
018600110803     D M@PCP           S             40A
018700110803     D M@NPI           S              1A
018800110803     D M@PCPCI         S              1A
018900150408
019000110803     D D@SFX           S              3A
019100110803     D D@ACCT          S              5A
019200110803     D D@PLAN          S              6A
019300110803     D D@CLM           S              3A
019400110803     D D@CBREXP        S              8A
019500110803     D D@CBREVT        S              8A
019600110803     D D@CBRLEN        S              2A
019700110803     D D@OOAI          S              1A
019800140313     D D@PCD           S              7A
019900150408
020000140313     D @STEP           S              5A
020100150408
020200140313     D E@SFX           S              3A
020300140313     D E@ACCT          S              5A
020400140313     D E@PLAN          S              6A
020500140313     D E@CLM           S              3A
020600140313     D E@PCP           S              7A
020700140313     D E@CBREXP        S              8A
020800140313     D E@CBREVT        S              8A
020900140313     D E@CBRLEN        S              2A
021000150408
021100150408      *=======================================================================================
021200150408      * Main process
021300150408      *=======================================================================================
021400150408
021500110803     C                   EVAL      @STEP = 'PREP1'
021600150408
021700110803     C     CARR#CTL      CHAIN     CARXPTR
021800150408
021900110803     C     CARR#CTL      SETLL     CARACCR
022000150408
022100110803     C                   DOU       @STEP = 'LEAVE'
022200110803     C     @STEP         CASEQ     'PREP1'       $PREP1
022300110803     C     @STEP         CASEQ     'STEP1'       $STEP1
022400110803     C     @STEP         CASEQ     'STEP2'       $STEP2
022500110803     C     @STEP         CASEQ     'STEP3'       $STEP3
022600110803     C     @STEP         CASEQ     'PREP4'       $PREP4
022700110803     C     @STEP         CASEQ     'STEP4'       $STEP4
022800110803     C     @STEP         CASEQ     'PREP5'       $PREP5
022900110803     C     @STEP         CASEQ     'STEP5'       $STEP5
023000110803     C     @STEP         CASEQ     'PREP6'       $PREP6
023100110803     C     @STEP         CASEQ     'STEP6'       $STEP6
023200110803     C     @STEP         CASEQ     'PREP7'       $PREP7
023300110803     C     @STEP         CASEQ     'STEP7'       $STEP7
023400110803     C     @STEP         CASEQ     'STEP8'       $STEP8
023500110803     C     @STEP         CASEQ     'PREP9'       $PREP9
023600110803     C     @STEP         CASEQ     'STEP9'       $STEP9
023700110803     C     @STEP         CASEQ     'PREPA'       $PREPA
023800110803     C     @STEP         CASEQ     'STEPA'       $STEPA
023900110803     C     @STEP         CASEQ     'PREPB'       $PREPB
024000110803     C     @STEP         CASEQ     'STEPB'       $STEPB
024100110803     C                   ENDCS
024200110803     C                   ENDDO
024300150408
024400150408      *  TRAILER RECORD
024500110803     C                   ADD       2             C#RECCNT
024600110803     C                   MOVE      C#RECCNT      @TREC            10 0
024700110803     C                   MOVE      B#RECCNT      @BREC            10 0
024800110803     C                   EXCEPT    TRLF
024900150408
025000110803     C                   EVAL      *INLR = *ON
025100150408
025200110803     C     $PREP1        BEGSR
025300110803    ***
025400110803     C     CARR#CTL      READE     CARACCR
025500110803    ***
025600110803     C                   IF        %EOF(CARACCP)
025700110803     C                   EVAL      @STEP = 'LEAVE'
025800110803     C                   LEAVESR
025900110803     C                   ENDIF
026000110803    ***
026100110803    *** HAS THE ACCOUNT BEEN SHUTOFF FOR EXPORT?
026200110803    ***
026300110803     C                   IF        CASTATUS <> 'Y'
026400110803     C                   LEAVESR
026500110803     C                   ENDIF
026600110803    ***
026700110803     C                   EVAL      KF@TRS = CATRST
026800110803     C                   EVAL      KF@SUB = CASUB#
026900110803     C                   EVAL      KF@ACC = CAACCT
027000110803    ***
027100110803     C                   EXSR      $PLANLOAD
027200110803    ***
027300110803     C                   EVAL      D1 = @DATE
027400110803     C                   EVAL      D2 = @DATE
027500110803     C                   EVAL      T1 = @TIME
027600110803     C                   EVAL      C1 = @DATE + @TIME
027700110803    ***
027800110803     C                   EVAL      H@SI = %TRIM(CACID1)                         SUBMITTER ID
027900110803     C                   EVAL      H@CC = %SUBST(CACID2:1:2)                    COMPANY CODE
028000110803     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
028100110803     C                   MOVEL(P)  CACID4        H@CN                           CUSTOMER NAME
028200110803     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
028300110803    ***
028400150507     c                   if        flag = ' '
028500110803     C                   EXCEPT    HDRF
028600150507     c                   movel     'Y'           flag              1
028700150507     c                   endif
028800110803    ***
028900110803     C                   EVAL      @STEP = 'STEP1'
029000110803    ***
029100110803     C                   ENDSR
029200110803   S***S
029300110803     C     $STEP1        BEGSR
029400110803    ***
029500110803     C                   EVAL      KF@PLN = *BLANKS
029600110803     C                   EVAL      KF@TRM = 0
029700110803     C                   EVAL      KF@SSN = 0
029800110803     C                   EVAL      KF@SEQ = 0
029900110803    ***
030000110803     C     KL#TSA        SETLL     MEMBR
030100110803    ***
030200110803     C                   EVAL      @STEP = 'STEP2'
030300110803    ***
030400110803     C                   ENDSR
030500110803   S***S
030600110803     C     $STEP2        BEGSR
030700110803    ***
030800110803     C     KL#TSA        READE     MEMBR
030900110803    ***
031000110803     C                   IF        %EOF(MEMAC#1)
031100110803     C                   EVAL      @STEP = 'PREP1'
031200110803     C                   LEAVESR
031300110803     C                   ENDIF
031400110803    ***
031500110803     C                   EVAL      KF@SSN = MBSSNO
031600110803     C                   MOVE      *ZEROS        KF@SEQ
031700110803    ***
031800110803    *** SET COST CENTER IF USED FROM THE MEMBER VALUE
031900110803    ***
032000110803     C                   EVAL      KF@CCTR = CCFLG
032100110803    ***
032200150410     C     KL#MPLN       SETLL     MCOVR
032300110803    ***
032400110803     C                   EXSR      $CLRSTG
032500110803    ***
032600110803     C                   EVAL      @STEP = 'STEP3'
032700110803    ***
032800110803     C                   ENDSR
032900110803   S***S
033000110803     C     $STEP3        BEGSR
033100110803    ***
033200150410     C     KL#MPLN       READE     MCOVR
033300110803    ***
033400150410     C                   IF        %EOF(MCOVMPLN)
033500110803     C                   EVAL      @STEP = 'PREP4'
033600110803     C                   LEAVESR
033700110803     C                   ENDIF
033800130813    ***
033900140811     C*******************IF        %SUBST(MCPLAN:1:3) <> 'DAA'
034000150413j    C****               IF        %SUBST(MCPLAN:1:3) <> 'LAA'
034100150413j    C****               LEAVESR
034200150413j    C****               ENDIF
034300110803    ***
034400110803     C                   EVAL      @PLANIN = MCPLAN
034500120921     C                   EVAL      ENR@IN = MCOVTP
034600140811     C                   EVAL      WRT@TYPE = 'MEMBER'
034700120123    ***
034800120123     C                   EXSR      $QUIK
034900120123    ***
035000110803     C                   EXSR      $PLANSRCH
035100110803    ***
035200110803     C                   IF        PLN@CAT = *BLANKS
035300110803     C                   LEAVESR
035400110803     C                   ENDIF
035500110803    ***
035600110803     C                   IF        CANDT = 0
035700110803     C                   EVAL      #CANCEL = 99999999
035800110803     C                   ELSE
035900110803     C                   EVAL      #CANCEL = CANDT
036000110803     C                   ENDIF
036100110803    ***
036200110803    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL
036300110803    ***
036400110803    *C                   IF        PLN@CAT = 'DEN'
036500130130    *C                   IF        D#CNE > 0
036600130130    *C                   IF        D@TRM(D#CNE) = 99999999
036700130130     C                   LEAVESR
036800130130     C                   ENDIF
036900130130     C                   ENDIF
037000110803    *C                   ADD       1             D#CNE
037100110803    *C                   EVAL      D@PLN(D#CNE) = MCPLAN
037200110803    *C                   EVAL      D@ENR(D#CNE) = MCOVTP
037300110803    *C                   EVAL      D@FRM(D#CNE) = ENRLDT
037400110803    *C                   EVAL      D@TRM(D#CNE) = #CANCEL
037500110803    *C                   ELSE
037600130130    *C                   IF        M#CNE > 0
037700130130    *C                   IF        M@TRM(M#CNE) = 99999999
037800130130     C                   LEAVESR
037900130130     C                   ENDIF
038000130130     C                   ENDIF
038100110803     C                   ADD       1             M#CNE
038200110803     C                   EVAL      M@PLN(M#CNE) = MCPLAN
038300110803     C                   EVAL      M@ENR(M#CNE) = MCOVTP
038400110803     C                   EVAL      M@FRM(M#CNE) = ENRLDT
038500110803     C                   EVAL      M@TRM(M#CNE) = #CANCEL
038600110803    *C                   ENDIF
038700110803    ***
038800110803     C                   ENDSR
038900110803   S***S
039000120123     C     $QUIK         BEGSR
039100120123    ***
039200140811       IF @PLANIN = 'LAAL' OR @PLANIN = 'LAAM' OR @PLANIN = 'LAAK' OR
039300140811         @PLANIN = 'LAAJ';
039400140811          @CCTRIN = STATE;
039500140811          LEAVESR;
039600140811       ENDIF;
039700140811    ***
039800140811       IF @PLANIN = 'LAAN' OR @PLANIN = 'LAAP';
039900140811          SELECT;
040000140811             WHEN WRT@TYPE = 'MEMBER' AND ENR@IN = 'TIN';
040100140811                @CCTRIN = STATE + 'I';
040200140811             WHEN WRT@TYPE = 'MEMBER' AND ENR@IN <> 'TIN';
040300140811                @CCTRIN = STATE + 'F';
040400140811             WHEN WRT@TYPE = 'DEPEND';
040500140811                @CCTRIN = STATE + 'F';
040600140811          ENDSL;
040700140811          LEAVESR;
040800140811       ENDIF;
040900120123    ***
041000120123     C                   ENDSR
041100120123   S***S
041200110803     C     $PREP4        BEGSR
041300110803    ***
041400110803     C                   IF        D#CNE = 0 AND M#CNE = 0
041500150414JJ   C                   EVAL      @STEP = 'STEP2'
041600150414JJ   C                   LEAVESR
041700110803     C                   ENDIF
041800110803    ***
041900110803     C                   EVAL      TERM_DEN = NO
042000110803     C                   EVAL      TERM_MED = NO
042100110803    ***
042200110803     C                   IF        M#CNE > 0 AND D#CNE > 0
042300110803    *C*
042400110803     C                   IF        (D@TRM(D#CNE) = 99999999 AND
042500110803     C                              M@TRM(M#CNE) = 99999999)
042600110803     C                   EVAL      @STEP = 'STEP4'
042700110803     C                   LEAVESR
042800110803     C                   ELSE
042900110803     C                   EXSR      $CHKHEM
043000110803     C                   ENDIF
043100110803    *C*
043200110803     C                   ENDIF
043300110803    ***
043400110803     C                   IF        M#CNE > 0 AND D#CNE = 0
043500110803    *C*
043600110803     C                   IF        M@TRM(M#CNE) = 99999999
043700110803     C                   EVAL      @STEP = 'STEP4'
043800110803     C                   LEAVESR
043900110803     C                   ELSE
044000110803     C                   EXSR      $CHKHEM
044100110803     C                   ENDIF
044200110803    *C*
044300110803     C                   ENDIF
044400110803    ***
044500110803     C                   IF        M#CNE = 0 AND D#CNE > 0
044600110803    *C*
044700110803     C                   IF        D@TRM(D#CNE) = 99999999
044800110803     C                   EVAL      @STEP = 'STEP4'
044900110803     C                   LEAVESR
045000110803     C                   ELSE
045100110803     C                   EXSR      $CHKHEM
045200110803     C                   ENDIF
045300110803    *C*
045400110803     C                   ENDIF
045500110803    ***
045600110803     C                   EVAL      @STEP = 'STEP4'
045700110803    ***
045800110803     C                   ENDSR
045900110803   S***S
046000110803    *** GENERATE MEMBER RECORD
046100110803    ***
046200110803     C     $STEP4        BEGSR
046300110803    ***
046400110803     C                   IF        D#CNE = 0 AND M#CNE = 0
046500150414JJ   C                   EVAL      @STEP = 'STEP2'
046600150414JJ   C                   LEAVESR
046700110803     C                   ENDIF
046800110803    ***
046900110803     C                   EVAL      WRT@TYPE = 'MEMBER'
047000110803    ***
047100110803     C                   EVAL      D@MBREFF = 0
047200110803     C                   EVAL      M@MBREFF = 0
047300110803    ***
047400110803     C                   EVAL      @SS1   = %EDITC(MBSSNO:'X')
047500110803     C                   EVAL      @SS2   = @SS1
047600110803     C                   MOVEL(P)  MLNAME        @LN
047700110803     C                   MOVEL(P)  MFNAME        @FN
047800110803     C                   EVAL      @MI    = MMI
047900110803     C                   EVAL      @REL   = '01'
048000110803     C                   EVAL      @SEX   = SEX
048100110803     C                   EVAL      @DOB   = %EDITC(BIRTH:'X')
048200110803     C                   IF        COB = 'Y'
048300110803     C                   EVAL      @COB   = 'Y'
048400110803     C                   EVAL      @COBC  = 'OT'
048500110803     C                   EVAL      @COBN  = MCOBPN
048600110803     C                   ENDIF
048700110803     C                   EVAL      @AD1   = %TRIM(ADDR1)
048800110803     C                   EVAL      @AD2   = %TRIM(ADDR2)
048900110803     C                   EVAL      @CTY   = %TRIM(CITY)
049000110803     C                   EVAL      @ST    = STATE
049100110803     C                   MOVE      *BLANKS       @9                9
049200110803     C                   EVAL      @9   = %EDITC(ZIP:'X')
049300110803     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
049400110803     C                   EVAL      @PHN   = %EDITC(AREA:'X') +
049500110803     C                                      %EDITC(PHONE:'X')
049600110803    ***
049700110803     C                   SELECT
049800110803     C                   WHEN      EMPST = 'A'
049900110803     C                   EVAL      @EMPST = 'AC'
050000110803     C                   WHEN      EMPST = 'C'
050100110803     C                   EVAL      @EMPST = 'CO'
050200110803     C                   WHEN      EMPST = 'R'
050300110803     C                   EVAL      @EMPST = 'RT'
050400110803     C                   ENDSL
050500110803    ***
050600110803     C                   EVAL      @HIRE  = %EDITC(EMPDT:'X')
050700141103    ***
050800150414jj       //if M#cne = 0;
050900150414jj       // m#cne = 1;
051000150414jj       //endif;
051100150410
051200150414j        //IF (M@PLN(M#CNE) = 'LAAN' OR M@PLN(M#CNE) = 'LAAJ' OR
051300150414j        //    M@PLN(M#CNE) = 'LAAP' OR M@PLN(M#CNE) = 'LAAK') AND STATE = 'WV';
051400150414j        //   *IN88 = *ON;
051500150414j        //ELSE;
051600150414j        //   *IN88 = *OFF;
051700150414j        //ENDIF;
051800110803    ***
051900110803     C                   EXCEPT    MBRF
052000110803     C                   ADD       1             C#RECCNT
052100110803    ***
052200110803     C                   EVAL      @STEP = 'PREP5'
052300110803    ***
052400110803     C                   ENDSR
052500110803   S***S
052600110803     C     $PREP5        BEGSR
052700110803    ***
052800110803     C                   IF        M#CNE = 0
052900150414JJ   C****               eval      m#cne = 1
053000150414JJ   C                   EVAL      @STEP = 'PREP6'
053100150414JJ   C                   LEAVESR
053200110803     C                   ENDIF
053300110803    ***
053400150410     C                   EVAL      KF@PLN = M@PLN(M#CNE)
053500150410     C                   EVAL      KF@ENR = M@ENR(M#CNE)
053600110803    ***
053700110803     C                   IF        TERM_MED = YES
053800110803     C                   EXSR      $WRTERM
053900110803     C                   ENDIF
054000110803    ***
054100110803    ***
054200110803    *** IF COST CENTER IS USED, CODE HERE, OR JUST SET IT TO BLANKS
054300110803    ***
054400150410     C                   EVAL      @PLANIN = M@PLN(M#CNE)
054500150410     C                   EVAL      ENR@IN  = M@ENR(M#CNE)
054600120123    ***
054700120123     C                   EXSR      $QUIK
054800120123    ***
054900110803     C                   EXSR      $PLANSRCH
055000110803    ***
055100110803     C                   IF        PLN@CAT = *BLANKS
055200110803     C                   SETON                                        H1
055300110803     C                   ENDIF
055400110803    ***
055500110803     C                   EVAL      @STEP = 'STEP5'
055600150410     C                   EVAL      #XSX = M@FRM(M#CNE)
055700110803     C                   EVAL      M@MBREFF = #XSX
055800110803    ***
055900110803     C                   ENDSR
056000110803   S***S
056100110803     C     $STEP5        BEGSR
056200110803    ***
056300110803     C                   IF        CPCID1 = 'MEA'
056400110803     C                   EXSR      $MEAWRT
056500110803     C                   ELSE
056600110803     C                   EXSR      $HMOWRT
056700110803     C                   ENDIF
056800110803    ***
056900110803     C                   ADD       1             C#RECCNT
057000110803     C                   ADD       1             B#RECCNT
057100110803    ***
057200110803     C                   EVAL      @STEP = 'PREP6'
057300110803    ***
057400110803     C                   ENDSR
057500110803   S***S
057600110803     C     $PREP6        BEGSR
057700110803    ***
057800110803    *C                   IF        D#CNE = 0
057900110803    *C                   EVAL      @STEP = 'PREP7'
058000110803    *C                   LEAVESR
058100110803    *C                   ENDIF
058200110803    ***
058300110803    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
058400130624     C                   EVAL      KF@ENR = D@ENR(D#CNE)
058500110803    ***
058600110803    *C                   IF        TERM_DEN = YES
058700110803    *C                   EXSR      $WRTERM
058800110803    *C                   ENDIF
058900110803    ***
059000130624     C                   EVAL      @PLANIN = D@PLN(D#CNE)
059100130624     C                   EVAL      ENR@IN  = D@ENR(D#CNE)
059200120123    ***
059300120123     C                   EXSR      $QUIK
059400110803    ***
059500110803     C                   EXSR      $PLANSRCH
059600110803    ***
059700110803     C                   IF        PLN@CAT = *BLANKS
059800110803     C                   SETON                                        H2
059900110803     C                   ENDIF
060000110803    ***
060100110803    *C                   EVAL      @STEP = 'STEP6'
060200110803     C                   EVAL      #XSX = D@FRM(D#CNE)
060300110803     C                   EVAL      D@MBREFF = #XSX
060400110803    ***
060500110803     C                   ENDSR
060600110803   S***S
060700110803    *** DENTAL FORMAT
060800110803    ***
060900110803    *C     $STEP6        BEGSR
061000110803    ***
061100110803     C                   EXSR      $DENWRT
061200110803    ***
061300110803    *C                   ADD       1             C#RECCNT
061400110803    *C                   ADD       1             B#RECCNT
061500110803    ***
061600110803    *C                   EVAL      @STEP = 'PREP7'
061700110803    ***
061800110803    *C                   ENDSR
061900110803   S***S
062000110803     C     $PREP7        BEGSR
062100110803    ***
062200110803     C     KF@SSN        CHAIN     DEPENR
062300110803     C                   IF        NOT %FOUND(DEPNDC)
062400110803     C                   EVAL      @STEP = 'STEP2'
062500110803     C                   LEAVESR
062600110803     C                   ENDIF
062700110803    ***
062800110803     C     KF@SSN        SETLL     DEPENR
062900110803    ***
063000110803     C                   EVAL      @STEP = 'STEP7'
063100110803    ***
063200110803     C                   ENDSR
063300110803   S***S
063400110803     C     $STEP7        BEGSR
063500110803    ***
063600110803     C     KF@SSN        READE     DEPENR
063700110803    ***
063800110803     C                   IF        %EOF(DEPNDC)
063900110803     C                   EVAL      @STEP = 'STEP2'
064000110803     C                   LEAVESR
064100110803     C                   ENDIF
064200110803    ***
064300110803     C                   EVAL      KF@SEQ = DPSEQ#
064400110803    ***
064500110803     C     KL#DCV        CHAIN     DCOVR
064600110803     C                   IF        NOT %FOUND(DCOVA)
064700110803     C                   LEAVESR
064800110803     C                   ENDIF
064900110803    ***
065000110803     C                   EXSR      $CLRDCV
065100110803     C     KL#DCV        SETLL     DCOVR
065200110803    ***
065300110803     C                   EVAL      @STEP = 'STEP8'
065400110803    ***
065500110803     C                   ENDSR
065600110803   S***S
065700110803     C     $STEP8        BEGSR
065800110803    ***
065900110803     C     KL#DCV        READE     DCOVR
066000110803    ***
066100110803     C                   IF        %EOF(DCOVA)
066200110803     C                   EVAL      @STEP = 'PREP9'
066300110803     C                   LEAVESR
066400110803     C                   ENDIF
066500110803    ***
066600140811     C                   IF        %SUBST(DVPLAN:1:3) <> 'LAA'
066700150413j    C****               LEAVESR
066800140811     C                   ENDIF
066900140811    ***
067000110803     C                   EVAL      @PLANIN = DVPLAN
067100140811     C                   EVAL      WRT@TYPE = 'DEPEND'
067200120123    ***
067300120123     C                   EXSR      $QUIK
067400120123    ***
067500110803     C                   EXSR      $PLANSRCH
067600110803    ***
067700110803     C                   IF        PLN@CAT = *BLANKS
067800110803     C                   LEAVESR
067900110803     C                   ENDIF
068000110803    ***
068100110803     C                   EVAL      #CANCEL = CCANDT
068200110803     C                   IF        #CANCEL = 0
068300110803     C                   EVAL      #CANCEL = 99999999
068400110803     C                   ENDIF
068500110803    ***
068600110803    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL
068700110803    ***
068800110803    *C                   IF        PLN@CAT = 'DEN'
068900130130    *C                   IF        D#CNE > 0
069000130130    *C                   IF        D@TRM(D#CNE) = 99999999
069100130130     C                   LEAVESR
069200130130     C                   ENDIF
069300130130     C                   ENDIF
069400110803    *C                   ADD       1             D#CNE
069500110803    *C                   EVAL      D@PLN(D#CNE) = DVPLAN
069600110803    *C                   EVAL      D@ENR(D#CNE) = *BLANKS
069700110803    *C                   EVAL      D@FRM(D#CNE) = DENRDT
069800110803    *C                   EVAL      D@TRM(D#CNE) = #CANCEL
069900110803    *C                   ELSE
070000130130    *C                   IF        M#CNE > 0
070100130130    *C                   IF        M@TRM(M#CNE) = 99999999
070200130130     C                   LEAVESR
070300130130     C                   ENDIF
070400130130     C                   ENDIF
070500110803     C                   ADD       1             M#CNE
070600110803     C                   EVAL      M@PLN(M#CNE) = DVPLAN
070700110803     C                   EVAL      M@ENR(M#CNE) = *BLANKS
070800110803     C                   EVAL      M@FRM(M#CNE) = DENRDT
070900110803     C                   EVAL      M@TRM(M#CNE) = #CANCEL
071000110803    *C                   ENDIF
071100110803    ***
071200110803     C                   ENDSR
071300110803   S***S
071400110803     C     $PREP9        BEGSR
071500110803    ***
071600110803     C                   IF        D#CNE = 0 AND M#CNE = 0
071700110803     C                   EVAL      @STEP = 'STEP7'
071800110803     C                   LEAVESR
071900110803     C                   ENDIF
072000110803    ***
072100110803     C                   EVAL      TERM_DEN = NO
072200110803     C                   EVAL      TERM_MED = NO
072300110803    ***
072400110803     C                   IF        M#CNE > 0 AND D#CNE > 0
072500110803    *C*
072600110803     C                   IF        (D@TRM(D#CNE) = 99999999 AND
072700110803     C                              M@TRM(M#CNE) = 99999999)
072800110803     C                   EVAL      @STEP = 'STEP9'
072900110803     C                   LEAVESR
073000110803     C                   ELSE
073100110803     C                   EXSR      $CHKHEM
073200110803     C                   ENDIF
073300110803    *C*
073400110803     C                   ENDIF
073500110803    ***
073600110803     C                   IF        M#CNE > 0 AND D#CNE = 0
073700110803    *C*
073800110803     C                   IF        M@TRM(M#CNE) = 99999999
073900110803     C                   EVAL      @STEP = 'STEP9'
074000110803     C                   LEAVESR
074100110803     C                   ELSE
074200110803     C                   EXSR      $CHKHEM
074300110803     C                   ENDIF
074400110803    *C*
074500110803     C                   ENDIF
074600110803    ***
074700110803     C                   IF        M#CNE = 0 AND D#CNE > 0
074800110803    *C*
074900110803     C                   IF        D@TRM(D#CNE) = 99999999
075000110803     C                   EVAL      @STEP = 'STEP9'
075100110803     C                   LEAVESR
075200110803     C                   ELSE
075300110803     C                   EXSR      $CHKHEM
075400110803     C                   ENDIF
075500110803    *C*
075600110803     C                   ENDIF
075700110803    ***
075800110803     C                   IF        D#CNE = 0 AND M#CNE = 0
075900110803     C                   EVAL      @STEP = 'STEP7'
076000110803     C                   LEAVESR
076100110803     C                   ENDIF
076200110803    ***
076300110803     C                   EVAL      @STEP = 'STEP9'
076400110803    ***
076500110803     C                   ENDSR
076600110803   S***S
076700110803    *** GENERATE DEPENDENT RECORD
076800110803    ***
076900110803     C     $STEP9        BEGSR
077000110803    ***
077100110803     C                   EVAL      WRT@TYPE = 'DEPEND'
077200110803    ***
077300110803     C                   IF        D#CNE = 0 AND M#CNE = 0
077400110803     C                   EVAL      @STEP = 'STEP7'
077500110803     C                   LEAVESR
077600110803     C                   ENDIF
077700110803    ***
077800110803     C                   EVAL      @SS2   = %EDITC(DEPSS#:'X')
077900110803     C                   MOVEL(P)  DLNAME        @LN
078000110803     C                   MOVEL(P)  DFNAME        @FN
078100110803     C                   EVAL      @MI    = DMI
078200110803    ***
078300110803     C                   SELECT
078400110803     C                   WHEN      DRELCD = 'RWI'
078500110803     C                   EVAL      @REL   = '02'
078600110803     C                   WHEN      DRELCD = 'RHU'
078700110803     C                   EVAL      @REL   = '03'
078800110803     C                   WHEN      DRELCD = 'RSO'
078900110803     C                   EVAL      @REL   = '04'
079000110803     C                   WHEN      DRELCD = 'RDA'
079100110803     C                   EVAL      @REL   = '05'
079200110803     C                   ENDSL
079300110803    ***
079400110803     C                   SELECT
079500110803     C                   WHEN      DSTUDN = 'Y'
079600110803     C                   EVAL      @SPEC = '1'
079700140812     C                   WHEN      DHNDCP = '3'
079800110803     C                   EVAL      @SPEC = '3'
079900110803     C                   ENDSL
080000110803    ***
080100110803     C                   EVAL      @SEX   = DSEX
080200110803     C                   EVAL      @DOB   = %EDITC(DBIRTH:'X')
080300110803     C                   IF        DCOB = 'Y'
080400110803     C                   EVAL      @COB   = 'Y'
080500110803     C                   EVAL      @COBC  = 'OT'
080600110803     C                   EVAL      @COBN  = DCOBPN
080700110803     C                   ENDIF
080800110803    ***
080900110803     C                   IF        DADDR1 <> ADDR1
081000110803     C                   EVAL      @AD1   = %TRIM(DADDR1)
081100110803     C                   EVAL      @AD2   = %TRIM(DADDR2)
081200110803     C                   EVAL      @CTY   = %TRIM(DCITY)
081300110803     C                   EVAL      @ST    = DSTATE
081400110803     C                   MOVE      *BLANKS       @9                9
081500110803     C                   IF        DZIP = 0
081600110803     C                   EVAL      @9   = %EDITC(ZIP:'X')
081700110803     C                   ELSE
081800110803     C                   EVAL      @9   = %EDITC(DZIP:'X')
081900110803     C                   ENDIF
082000110803     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
082100110803     C                   EVAL      @PHN   = %EDITC(DAREA:'X') +
082200110803     C                                      %EDITC(DPHONE:'X')
082300110803     C                   ENDIF
082400110803    ***
082500150413       //IF (M@PLN(M#CNE) = 'LAAN' OR M@PLN(M#CNE) = 'LAAJ' OR
082600150413        //   M@PLN(M#CNE) = 'LAAP' OR M@PLN(M#CNE) = 'LAAK') AND STATE = 'WV';
082700150413        //  *IN88 = *ON;
082800150413       //ELSE;
082900150414       // *IN88 = *OFF;
083000150413       //ENDIF;
083100141103    ***
083200110803     C                   EXCEPT    MBRF
083300110803     C                   ADD       1             C#RECCNT
083400110803    ***
083500110803     C                   EVAL      @STEP = 'PREPA'
083600110803    ***
083700110803     C                   ENDSR
083800110803   S***S
083900110803     C     $PREPA        BEGSR
084000110803    ***
084100110803     C                   IF        M#CNE = 0
084200110803     C                   EVAL      @STEP = 'PREPB'
084300110803     C                   LEAVESR
084400110803     C                   ENDIF
084500110803    ***
084600150410     C                   EVAL      KF@PLN = M@PLN(M#CNE)
084700150410     C                   EVAL      KF@ENR = *BLANKS
084800110803    ***
084900110803     C                   IF        TERM_MED = YES
085000110803     C                   EXSR      $WRTERM
085100110803     C                   ENDIF
085200110803    ***
085300110803    ***
085400110803    *** IF COST CENTER IS USED, CODE HERE, OR JUST SET IT TO BLANKS
085500110803    ***
085600150410     C                   EVAL      @PLANIN = M@PLN(M#CNE)
085700130624     C                   EVAL      ENR@IN  = 'TFA'
085800120123    ***
085900120123     C                   EXSR      $QUIK
086000120123    ***
086100110803     C                   EXSR      $PLANSRCH
086200110803    ***
086300110803     C                   IF        PLN@CAT = *BLANKS
086400110803     C                   SETON                                        H2
086500110803     C                   ENDIF
086600110803    ***
086700110803     C                   EVAL      @STEP = 'STEPA'
086800110803    ***
086900110803     C                   ENDSR
087000110803   S***S
087100110803     C     $STEPA        BEGSR
087200110803    ***
087300150410     c                   eval      cpcid1 = 'MEA'
087400110803     C                   IF        CPCID1 = 'MEA'
087500110803     C                   EXSR      $MEAWRT
087600110803     C                   ELSE
087700110803     C                   EXSR      $HMOWRT
087800110803     C                   ENDIF
087900110803    ***
088000110803     C                   ADD       1             C#RECCNT
088100110803     C                   ADD       1             B#RECCNT
088200110803    ***
088300110803     C                   EVAL      @STEP = 'PREPB'
088400110803    ***
088500110803     C                   ENDSR
088600110803   S***S
088700110803     C     $PREPB        BEGSR
088800110803    ***
088900110803    *C                   IF        D#CNE = 0
089000110803    *C                   EVAL      @STEP = 'STEP7'
089100110803    *C                   LEAVESR
089200110803    *C                   ENDIF
089300110803    ***
089400110803    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
089500130624     C                   EVAL      KF@ENR = *BLANKS
089600110803    ***
089700110803    *C                   IF        TERM_DEN = YES
089800110803    *C                   EXSR      $WRTERM
089900110803    *C                   ENDIF
090000110803    ***
090100130624     C                   EVAL      @PLANIN = D@PLN(D#CNE)
090200130624     C                   EVAL      ENR@IN  = 'TFA'
090300120123    ***
090400120123     C                   EXSR      $QUIK
090500120123    ***
090600110803     C                   EXSR      $PLANSRCH
090700110803    ***
090800110803     C                   IF        PLN@CAT = *BLANKS
090900110803     C                   SETON                                        H2
091000110803     C                   ENDIF
091100110803    ***
091200110803     C                   EVAL      @STEP = 'STEPB'
091300110803    ***
091400110803     C                   ENDSR
091500110803   S***S
091600110803    *C     $STEPB        BEGSR
091700110803    ***
091800110803     C                   EXSR      $DENWRT
091900110803    ***
092000110803    *C                   ADD       1             C#RECCNT
092100110803    *C                   ADD       1             B#RECCNT
092200110803    ***
092300110803    *C                   EVAL      @STEP = 'STEP7'
092400110803    ***
092500110803    *C                   ENDSR
092600110803   S***S
092700110803     C     *INZSR        BEGSR
092800110803    ***
092900110803     C     KL#ACCTL      KLIST
093000110803     C                   KFLD                    CARR#CTL
093100110803     C                   KFLD                    KF@TRS
093200110803     C                   KFLD                    KF@SUB
093300110803     C                   KFLD                    KF@ACC
093400110803    ***
093500110803     C     KL#TSA        KLIST
093600110803     C                   KFLD                    KF@TRS
093700110803     C                   KFLD                    KF@SUB
093800110803     C                   KFLD                    KF@ACC
093900110803    ***
094000110803     C     KL#MPLN       KLIST
094100110803     C                   KFLD                    KF@SSN
094200110803     C                   KFLD                    KF@SEQ
094300110803     C                   KFLD                    KF@TRS
094400110803     C                   KFLD                    KF@SUB
094500110803     C                   KFLD                    KF@ACC
094600110803    ***
094700110803     C     KL#CPLN       KLIST
094800110803     C                   KFLD                    CARR#CTL
094900110803     C                   KFLD                    KF@TRS
095000110803     C                   KFLD                    KF@SUB
095100110803     C                   KFLD                    KF@ACC
095200110803     C                   KFLD                    KF@CCTR
095300110803     C                   KFLD                    KF@PLN
095400110803    ***
095500110803     C     KL#DCV        KLIST
095600110803     C                   KFLD                    KF@SSN
095700110803     C                   KFLD                    KF@SEQ
095800110803    ***
095900110803     C     KL#MTR        KLIST
096000110803     C                   KFLD                    KF@SSN
096100110803     C                   KFLD                    KF@SEQ
096200110803     C                   KFLD                    KF#TRM
096300110803     C                   KFLD                    KF@PLN
096400110803     C                   KFLD                    KF@ENR
096500110803     C                   KFLD                    KF@TRS
096600110803     C                   KFLD                    KF@SUB
096700110803     C                   KFLD                    KF@ACC
096800110803    ***
096900140313     C     KL#SQPCD      KLIST
097000140313     C                   KFLD                    KF@SSN
097100140313     C                   KFLD                    KF@SEQ
097200140313     C                   KFLD                    KF@SPCD
097300140313    ***
097400110803     C     KL#PCP        KLIST
097500110803     C                   KFLD                    KF@SSN
097600110803     C                   KFLD                    KF@SEQ
097700110803    ***
097800110803     C                   EVAL      #ISO = %DATE
097900110803     C                   MOVE      #ISO          #TODAY            8 0
098000110803     C                   EVAL      #IST = %TIME
098100110803     C                   MOVE      #ISO          #XSX
098200110803     C                   MOVE      #XSX          @DATE
098300110803     C                   MOVE      #IST          #XST
098400110803     C                   MOVE      #XST          @TIME
098500110803    ***
098600110803     C                   ENDSR
098700110803   S***S
098800110803    *** PLANS LOADED BY ACCOUNT
098900110803    ***
099000110803     C     $PLANLOAD     BEGSR
099100110803    ***
099200110803     C                   EVAL      PP# = 0
099300140812     C                   DO        90
099400110803     C                   ADD       1             PP#
099500110803     C     PP#           OCCUR     CARPLN@
099600110803     C                   CLEAR                   CARPLN@
099700110803     C                   ENDDO
099800110803     C                   EVAL      PC# = 0
099900110803     C                   EVAL      PP# = 0
100000110803    ***
100100110803     C     KL#ACCTL      SETLL     CARPLNR
100200110803     C                   DOU       %EOF(CARPLNP)
100300110803     C     KL#ACCTL      READE     CARPLNR
100400110803     C                   IF        NOT %EOF(CARPLNP)
100500110803    ***
100600110803     C                   ADD       1             PC#
100700110803     C     PC#           OCCUR     CARPLN@
100800110803     C                   EVAL      CARPLN@ = DS@CARPLN
100900110803    ***
101000110803     C                   ENDIF
101100110803     C                   ENDDO
101200110803    ***
101300110803     C                   ENDSR
101400110803   S***S
101500110803     C     $CLRSTG       BEGSR
101600110803    ***
101700110803     C                   EVAL      #CANCEL = 0
101800110803     C                   EVAL      D#CNE = 0
101900110803     C                   CLEAR                   D@PLN
102000110803     C                   CLEAR                   D@ENR
102100110803     C                   CLEAR                   D@FRM
102200110803     C                   CLEAR                   D@TRM
102300110803     C                   EVAL      M#CNE = 0
102400110803     C                   CLEAR                   M@PLN
102500110803     C                   CLEAR                   M@ENR
102600110803     C                   CLEAR                   M@FRM
102700110803     C                   CLEAR                   M@TRM
102800110803    ***
102900110803     C                   EXSR      $CLRDMG
103000110803    ***
103100110803     C                   ENDSR
103200110803   S***S
103300110803     C     $CLRDMG       BEGSR
103400110803    ***
103500110803     C                   EVAL      @SS1   = *BLANKS
103600110803     C                   EVAL      @SS2   = *BLANKS
103700110803     C                   MOVE      *BLANKS       @LN
103800110803     C                   MOVEL     *BLANKS       @FN
103900110803     C                   EVAL      @MI    = *BLANKS
104000110803     C                   EVAL      @REL   = *BLANKS
104100110803     C                   EVAL      @SEX   = *BLANKS
104200110803     C                   EVAL      @DOB   = *BLANKS
104300110803     C                   EVAL      @SPEC  = *BLANKS
104400110803     C                   EVAL      @COB   = *BLANKS
104500110803     C                   EVAL      @COBC  = *BLANKS
104600110803     C                   EVAL      @COBN  = *BLANKS
104700110803     C                   EVAL      @AD1   = *BLANKS
104800110803     C                   EVAL      @AD2   = *BLANKS
104900110803     C                   EVAL      @CTY   = *BLANKS
105000110803     C                   EVAL      @ST    = *BLANKS
105100110803     C                   EVAL      @ZP5   = *BLANKS
105200110803     C                   EVAL      @PHN   = *BLANKS
105300110803     C                   EVAL      @EMPST = *BLANKS
105400110803     C                   EVAL      @HIRE  = *BLANKS
105500110803    ***
105600110803     C                   ENDSR
105700110803   S***S
105800110803     C     $CHKHEM       BEGSR
105900110803    ***
106000110803    *C                   IF        D#CNE > 0 AND D@TRM(D#CNE) <> 99999999
106100110803    *C                   EXSR      $CHKDEN
106200110803    *C                   ENDIF
106300110803      *
106400110803     C                   IF        M#CNE > 0 AND M@TRM(M#CNE) <> 99999999
106500110803     C                   EXSR      $CHKMED
106600110803     C                   ENDIF
106700110803    ***
106800110803     C                   ENDSR
106900110803   S***S
107000110803    *C     $CHKDEN       BEGSR
107100110803    ***
107200110803    *C                   EVAL      TERM_DEN = YES
107300110803    *C                   EVAL      KF#TRM = D@TRM(D#CNE)
107400110803    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
107500110803    *C                   EVAL      KF@ENR = D@ENR(D#CNE)
107600110803    ***
107700150407    *C     KL#MTR        CHAIN     AET641F
107800150407    *C                   IF        %FOUND(AET641WF)
107900110803    *C                   EVAL      D#CNE = 0
108000110803    *C                   EVAL      TERM_DEN = NO
108100110803    *C                   ENDIF
108200110803    ***
108300110803    *C                   ENDSR
108400110803   S***S
108500110803     C     $CHKMED       BEGSR
108600110803    ***
108700110803     C                   EVAL      TERM_MED = YES
108800150410     C                   EVAL      KF#TRM = M@TRM(M#CNE)
108900150410     C                   EVAL      KF@PLN = M@PLN(M#CNE)
109000150410     C                   EVAL      KF@ENR = M@ENR(M#CNE)
109100110803      *
109200150407     C     KL#MTR        CHAIN     AET641F
109300150407     C                   IF        %FOUND(AET641WF)
109400110803     C                   EVAL      TERM_MED = NO
109500110803     C                   EVAL      M#CNE = 0
109600110803     C                   ENDIF
109700110803    ***
109800110803     C                   ENDSR
109900110803   S***S
110000110803     C     $PLANSRCH     BEGSR
110100110803    ***
110200110803     C                   MOVE      *BLANKS       PLN@CAT           3
110300110803     C                   EVAL      PP# = 0
110400110803     C                   CLEAR                   DS@CARPLN
110500110803    ***
110600110803     C                   DO        PC#
110700110803    * *
110800110803     C                   ADD       1             PP#
110900110803     C     PP#           OCCUR     CARPLN@
111000110803    * *
111100150414jj   C                   IF        XPPLAN = @PLANIN
111200150414jj   C****                         and XPCCTR = @CCTRIN
111300110803     C                   EVAL      DS@CARPLN = CARPLN@
111400150414jj   C                   LEAVE
111500150414jj   C                   ENDIF
111600110803    * *
111700110803     C                   ENDDO
111800110803    ***
111900110803     C                   IF        CPPLAN = *BLANKS
112000150414JJ   C                   LEAVESR
112100110803     C                   ENDIF
112200110803    ***
112300110803     C                   SELECT
112400110803     C                   WHEN      CPCID1 = 'MEA' OR
112500110803     C                             CPCID1 = 'HMO'
112600110803     C                   EVAL      PLN@CAT = 'MED'
112700110803     C                   WHEN      CPCID1 = 'DEN'
112800110803     C                   EVAL      PLN@CAT = 'DEN'
112900110803     C                   ENDSL
113000110803    ***
113100110803     C                   ENDSR
113200110803   S***S
113300110803     C     $ENROLL       BEGSR
113400110803    ***
113500110803     C                   EVAL      ENR@OUT = *BLANKS
113600110803     C                   SELECT
113700110803     C                   WHEN      ENR@IN = 'TIN' OR ENR@IN = 'TMI'
113800110803     C                   EVAL      ENR@OUT = 'S'
113900110803     C                   WHEN      ENR@IN = 'THW'
114000110803     C                   EVAL      ENR@OUT = 'C'
114100110803     C                   WHEN      ENR@IN = 'TPC'
114200110803     C                   EVAL      ENR@OUT = 'P'
114300110803     C                   WHEN      ENR@IN = 'TP2'
114400110803     C                   EVAL      ENR@OUT = 'Q'
114500110803     C                   WHEN      ENR@IN = 'TFA'
114600110803     C                   EVAL      ENR@OUT = 'F'
114700110803     C                   ENDSL
114800110803    ***
114900110803     C                   ENDSR
115000110803   S***S
115100110803     C     $WRTERM       BEGSR
115200110803    ***
115300150407     C                   CLEAR                   AET641F
115400110803     C                   EVAL      NTSSNO         = KF@SSN
115500110803     C                   EVAL      NTDEPNO        = KF@SEQ
115600110803     C                   EVAL      NTTERMDT       = KF#TRM
115700110803     C                   EVAL      NTPLAN         = KF@PLN
115800110803     C                   EVAL      NTCOVTP        = KF@ENR
115900110803     C                   EVAL      NTTRST         = KF@TRS
116000110803     C                   EVAL      NTSUB#         = KF@SUB
116100110803     C                   EVAL      NTACCT         = KF@ACC
116200110803     C                   EVAL      NTTRANSDT      = #TODAY
116300150407     C                   WRITE     AET641F
116400110803    ***
116500110803     C                   ENDSR
116600110803   S***S
116700110803     C     $HMOWRT       BEGSR
116800110803    ***
116900110803     C                   EVAL      X@LAY = CPCID1                               LAYOUT
117000110803     C                   EVAL      X@ELR = CPCID2                               FILE NUMBER
117100110803     C                   EVAL      M@CC = CACID2                                COMPANY CODE
117200110803     C                   EVAL      M@CLASS = CPCID3                             CLASS CODE
117300110803     C                   EVAL      M@PLAN = CPCID4                              PLAN NUMBER
117400110803    ***
117500110803     C                   EVAL      #XSX = M@FRM(M#CNE)
117600110803     C                   IF        WRT@TYPE = 'DEPEND' AND
117700110803     C                             #XSX < M@MBREFF
117800110803     C                   MOVE      M@MBREFF      X@EFF
117900110803     C                   ELSE
118000110803     C                   MOVE      #XSX          X@EFF
118100110803     C                   ENDIF
118200110803    ***
118300110803     C                   EVAL      #XSX = M@TRM(M#CNE)
118400110803     C                   IF        #XSX = 0 OR #XSX = 99999999
118500110803     C                   MOVE      *BLANKS       X@TRM
118600110803     C                   ELSE
118700110803     C                   MOVE      #XSX          X@TRM
118800110803     C                   ENDIF
118900110803    ***
119000110803     C                   IF        WRT@TYPE = 'MEMBER'
119100110803     C                   EVAL      KF@SEQ = 0
119200110803     C                   EVAL      ENR@IN = M@ENR(M#CNE)
119300110803     C                   EXSR      $ENROLL
119400110803     C                   EVAL      X@TIER = ENR@OUT
119500110803     C                   ELSE
119600110803     C                   EVAL      X@TIER = *BLANKS
119700110803     C                   ENDIF
119800110803    ***
119900140313     C                   EVAL      KF@SPCD = 'MED'
120000140313     C                   EVAL      M@PCP = *BLANKS
120100140313     C                   EVAL      M@NPI = *BLANKS
120200140313     C                   EVAL      M@PCPCI = *BLANKS
120300140313    ***
120400140313     C                   EXSR      $PCP
120500140313    ***
120600140313     C                   IF        DOCTOR <> *BLANKS
120700140313     C                   EVAL      M@PCP = DOCTOR
120800140313     C                   EVAL      M@NPI = 'Y'
120900140313     C                   EVAL      M@PCPCI = '0'
121000140313     C                   ENDIF
121100110803    ***
121200110803     C                   EXCEPT    HMOF
121300110803    ***
121400110803     C                   ENDSR
121500110803   S***S
121600110803     C     $MEAWRT       BEGSR
121700110803    ***
121800110803     C                   EVAL      X@LAY = CPCID1                               LAYOUT
121900110803     C                   EVAL      X@ELR = CPCID2                               ELR
122000140313     C                   EVAL      E@SFX = CPCID3                               SUFFIX
122100140313     C                   EVAL      E@ACCT = CPCID4                              ACCOUNT
122200140313     C                   EVAL      E@PLAN = CPCID5                              PLAN
122300140313     C                   EVAL      E@CLM = CPCID6                               CLAIM OFFICE
122400110803    ***
122500110803     C                   EVAL      #XSX = M@FRM(M#CNE)
122600110803     C                   IF        WRT@TYPE = 'DEPEND' AND
122700110803     C                             #XSX < M@MBREFF
122800110803     C                   MOVE      M@MBREFF      X@EFF
122900110803     C                   ELSE
123000110803     C                   MOVE      #XSX          X@EFF
123100110803     C                   ENDIF
123200110803    ***
123300110803     C                   EVAL      #XSX = M@TRM(M#CNE)
123400110803     C                   IF        #XSX = 0 OR #XSX = 99999999
123500110803     C                   MOVE      *BLANKS       X@TRM
123600110803     C                   ELSE
123700110803     C                   MOVE      #XSX          X@TRM
123800110803     C                   ENDIF
123900110803    ***
124000140313     C                   MOVE      *BLANKS       E@CBREXP
124100140313     C                   MOVE      *BLANKS       E@CBREVT
124200140313     C                   MOVE      *BLANKS       E@CBRLEN
124300140313     C                   IF        WRT@TYPE = 'MEMBER'
124400140313     C                   IF        EMPST = 'C'
124500140313     C                   MOVE      CEXPDT        E@CBREXP
124600140313     C                   MOVE      QEDT          E@CBREVT
124700140313     C                   MOVE      CEXPDT        #MINUEND
124800140313     C                   MOVE      QEDT          #SUBTRAEND
124900140313     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
125000140313     C                   Z-ADD     #DIFFRNC      #2S0
125100140313     C                   MOVE      #2S0          E@CBRLEN
125200140313     C                   ENDIF
125300140313     C                   ENDIF
125400140313    ***
125500140313     C                   EVAL      *IN80 = *OFF
125600140313     C                   EVAL      KF@SPCD = 'MED'
125700140313     C                   EVAL      E@PCP = *BLANKS
125800140313     C                   EXSR      $PCP
125900140313     C                   IF        DOCTOR <> *BLANKS
126000140313     C                   EVAL      E@PCP = DOCTOR
126100140313     C                   EVAL      *IN80 = *ON
126200140313     C                   ENDIF
126300140313    ***
126400140313     C                   EXCEPT    MEAF
126500110803    ***
126600110803     C                   ENDSR
126700110803   S***S
126800140313     C     $PCP          BEGSR
126900140313    ***
127000140313     C                   MOVE      *BLANKS       DOCTOR            7
127100140313     C     KL#SQPCD      CHAIN     PCPR
127200140313     C                   IF        NOT %FOUND(PCPL1)
127300140313     C                   LEAVESR
127400140313     C                   ENDIF
127500140313     C     KL#SQPCD      SETLL     PCPR
127600140313     C                   DOU       %EOF(PCPL1)
127700140313     C     KL#SQPCD      READE     PCPR
127800140313     C                   IF        NOT %EOF(PCPL1) AND PCCAN = 0
127900140313     C                   MOVEL(P)  PCID#         DOCTOR
128000140313     C                   LEAVESR
128100140313     C                   ENDIF
128200140313     C                   ENDDO
128300140313    ***
128400140313     C                   ENDSR
128500140313   S***S
128600110803     C     $CLRDCV       BEGSR
128700110803    ***
128800110803     C                   MOVE      *BLANKS       @LN
128900110803     C                   MOVEL     *BLANKS       @FN
129000110803     C                   EVAL      @SS2   = *BLANKS
129100110803     C                   EVAL      @MI    = *BLANKS
129200110803     C                   EVAL      @REL   = *BLANKS
129300110803     C                   EVAL      @SEX   = *BLANKS
129400110803     C                   EVAL      @DOB   = *BLANKS
129500110803     C                   EVAL      @SPEC  = *BLANKS
129600110803     C                   EVAL      @COB   = *BLANKS
129700110803     C                   EVAL      @COBC  = *BLANKS
129800110803     C                   EVAL      @COBN  = *BLANKS
129900110803    ***
130000110803     C                   EVAL      #CANCEL = 0
130100110803     C                   EVAL      D#CNE = 0
130200110803     C                   CLEAR                   D@PLN
130300110803     C                   CLEAR                   D@ENR
130400110803     C                   CLEAR                   D@FRM
130500110803     C                   CLEAR                   D@TRM
130600110803     C                   EVAL      M#CNE = 0
130700110803     C                   CLEAR                   M@PLN
130800110803     C                   CLEAR                   M@ENR
130900110803     C                   CLEAR                   M@FRM
131000110803     C                   CLEAR                   M@TRM
131100110803    ***
131200110803     C                   ENDSR
131300110803   S***S
131400110803     C     $DENWRT       BEGSR
131500110803    ***
131600110803    *C                   EVAL      X@LAY = CPCID1                               LAYOUT
131700110803    *C                   EVAL      X@ELR = CPCID2                               ELR
131800110803    *C                   EVAL      D@SFX = CPCID3                               SUFFIX
131900110803    *C                   EVAL      D@ACCT = CPCID4                              ACCOUNT
132000110803    *C                   EVAL      D@PLAN = CPCID5                              PLAN
132100110803    *C                   EVAL      D@CLM = CPCID6                               CLAIM OFFICE
132200110803     C                   EVAL      DNTLATE = '0'
132300110803    ***
132400110803    *C                   EVAL      #XSX = D@FRM(D#CNE)
132500110803     C                   IF        WRT@TYPE = 'DEPEND' AND
132600110803     C                             #XSX < D@MBREFF
132700110803     C                   MOVE      D@MBREFF      X@EFF
132800110803     C                   ELSE
132900110803     C                   MOVE      #XSX          X@EFF
133000110803     C                   ENDIF
133100110803    ***
133200110803    *C                   EVAL      #XSX = D@TRM(D#CNE)
133300110803    *C                   IF        #XSX = 0 OR #XSX = 99999999
133400110803    *C                   MOVE      *BLANKS       X@TRM
133500110803    *C                   ELSE
133600110803    *C                   MOVE      #XSX          X@TRM
133700110803    *C                   ENDIF
133800110803    ***
133900130423     C                   MOVE      *BLANKS       D@CBREXP
134000130423     C                   MOVE      *BLANKS       D@CBREVT
134100130423     C                   MOVE      *BLANKS       D@CBRLEN
134200110803     C                   IF        WRT@TYPE = 'MEMBER'
134300110803    *C                   IF        EMPST = 'C'
134400110803    *C                   MOVE      CEXPDT        D@CBREXP
134500110803    *C                   MOVE      QEDT          D@CBREVT
134600110803    *C                   MOVE      CEXPDT        #MINUEND
134700110803    *C                   MOVE      QEDT          #SUBTRAEND
134800110803    *C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
134900110803    *C                   Z-ADD     #DIFFRNC      #2S0
135000110803    *C                   MOVE      #2S0          D@CBRLEN
135100110803    *C                   ENDIF
135200110803    *C                   ENDIF
135300110803    ***
135400140313     C*  ***PLANS***  IF THIS APPLIES TO THE ACCOUNT; IF NOT, JUST SEND BLANKS
135500140313    *C                   IF        KF@PLN = 'DDDD'
135600140313     C*  ***PLANS***
135700140313    *C                   MOVE      '0'           D@OOAI
135800140313     C                   ELSE
135900140313    *C                   MOVE      *BLANKS       D@OOAI
136000140313    *C                   ENDIF
136100140313    ***
136200140313     C                   EVAL      KF@SPCD = 'DEN'
136300140313     C                   EVAL      D@PCD = *BLANKS
136400140313     C                   EVAL      *IN81 = *OFF
136500140313     C                   MOVE      *BLANKS       DOCTOR
136600140313    ***
136700140313     C                   EXSR      $PCP
136800140313    ***
136900140313     C                   IF        DOCTOR <> *BLANKS
137000140313     C                   EVAL      D@PCD = DOCTOR
137100140313     C                   EVAL      *IN81 = *ON
137200140313     C                   ENDIF
137300140313    ***
137400140313    *C                   EXCEPT    DENF
137500110803    ***
137600110803    *C                   ENDSR
137700110803   S***S
137800110803   X***X
137900150407     OAET640WF  EADD         HDRF
138000110803     O                                            6 'HEADER'
138100130827     O                                            8 'P'
138200110803     O                       H@SI                28
138300110803     O                                           29 '0'
138400110803     O                       C1                  43
138500110803     O                       D1                  51
138600110803     O                       T1                  57
138700110803     O                                          131 'CONSOLIDATED ELIGIBILITY'
138800110803     O                       H@RI               167
138900110803     O                       H@CC               169
139000110803     O                       H@GN               176
139100110803     O                       H@CN               191
139200110803     O                       H@C#               198
139300110803     O                       D2                 206
139400110803     O                                          216 '02'
139500110803     O                                          231 '*'
139600150407     OAET640WF  EADD         MBRF
139700110803     O                                            6 'MEMBER'
139800110803     O                       @SS1                16
139900110803     O                       @SS2                25
140000110803     O                       @FN                 75
140100110803     O                       @MI                 76
140200110803     O                       @LN                 96
140300110803     O                       @REL               101
140400110803     O                       @SEX               103
140500110803     O                       @DOB               111
140600110803     O                       @SPEC              112
140700110803     O                                          113 '0'
140800110803     O                       @COB               123
140900110803     O                       @COBC              125
141000110803     O                       @COBN              145
141100110803     O                       @AD1               175
141200110803     O                       @AD2               205
141300110803     O                       @CTY               315
141400110803     O                       @ST                317
141500110803     O                       @ZP5               322
141600110803     O                       @PHN               349
141700150414     O****           88                         576 '21702'
141800110803     O                       @EMPST             665
141900110803     O                       @HIRE              673
142000110803     O                                         1231 '*'
142100150407     OAET640WF  EADD         HMOF
142200110803     O                                            7 'BENEFIT'
142300110803     O                       X@LAY               10
142400110803     O                       X@ELR               24
142500110803     O                       M@CC                26
142600110803     O                       H@GN                38
142700110803     O                       M@CLASS             44
142800110803     O                       M@PLAN              50
142900110803     O                       X@EFF               58
143000111201     O                       X@TRM               66
143100110803     O                       X@TIER              69
143200110803     O                       M@PCP              160
143300110803     O                       M@NPI              161
143400110803     O                       M@PCPCI            186
143500110803     O                                          323 '*'
143600140313    ***
143700150407     OAET640WF  EADD         MEAF
143800140313     O                                            7 'BENEFIT'
143900140313     O                                           10 'MEA'
144000140313     O                       X@ELR               24
144100140313     O                       H@C#                31
144200140313     O                       E@SFX               34
144300140313     O                       E@ACCT              44
144400140313     O                       E@PLAN              50
144500140313     O                       X@EFF               58
144600140313     O                       X@TRM               66
144700140313     O                       E@CLM               71
144800140313     *** PCP BGN
144900140313     O                       E@PCP              127
145000140313     O               80                         161 'N'
145100140313     O               80                         186 '0'
145200140313     *** PCP END
145300140313     O                                          389 '0'
145400140313     *** COBRA BGN
145500140313     O                       E@CBREXP           466
145600140313     O                       E@CBREVT           516
145700140313     O                       E@CBRLEN           560
145800140313     *** COBRA END
145900140313     O                                          678 '*'
146000140313    ***
146100150407     OAET640WF  EADD         DENF
146200110803     O                                            7 'BENEFIT'
146300110803     O                       X@LAY               10
146400110803     O                       X@ELR               24
146500110803     O                       H@C#                31
146600110803     O                       D@SFX               34
146700110803     O                       D@ACCT              44
146800110803     O                       D@PLAN              50
146900110803     O                       X@EFF               58
147000111201     O                       X@TRM               66
147100110803     O                       D@CLM               71
147200140313     *** PCD BGN
147300140313     O                       D@PCD              200
147400140313     O               81                         236 '0'
147500140313     *** PCD END
147600140313     O                                          389 '0'
147700140313     *** COBRA BGN
147800140313     O                       D@CBREXP           466
147900140313     O                       D@CBREVT           516
148000140313     O                       D@CBRLEN           560
148100140313     *** COBRA END
148200140313     O                       D@OOAI             609
148300140313     O                                          678 '*'
148400140313    ***
148500150407     OAET640WF  EADD         TRLF
148600110803     O                                            7 'TRAILER'
148700110803     O                       @TREC               17
148800110803     O                       D1                  25
148900110803     O                       T1                  31
149000110803     O                       @BREC               41
149100110803     O                                           69 '*'
