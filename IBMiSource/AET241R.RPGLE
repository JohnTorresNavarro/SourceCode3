000100130813   X***X CARRIER CONTROL ID #0000000091 AETNA SPECIFIC
000200110803   X***X SSK 05.13.2011 TEMPLATE DESIGN
000300110803   X***X
000400130813   X***X 08.13.2013 CLONED FROM AET0X0R
000500130829   X***X 08.29.2013 AETNA APPROVED FOR PRODUCTION
000600110803   X***X
000700110803   X***X
000800110803   X***X ACCOUNTS SET-UP
000900130813   X***X 590-008-0002  DRB ENTERPRISES LLC
001000110803   X***X
001100110803   X***X COULD NOT MAKE THIS GENERIC
001200110803   X***X
001300110803   X***X PLAN SET UP IS REFERRED TO "SELECT" STATEMENTS.
001400110803   X***X   SCAN FOR "***PLANS***" TO FIND.
001500110803   X***X     MMMM = MEDICAL AND DDDD = DENTAL
001600110803   X***X
001700110803   X***X
001800110803   X***X **INCLUDES SONDA MODIFICATION ON 7/25/2011 FOR DEP EFF DATE
001900110803   X***X
002000140313   X***X 03.13.2014 SSK ADD PCP
002100140811   X***X 08.11.2014 SSK RENEWAL PROCESSING.
002200141103   X***X 11.03.2014 SSK WEST VIRGINIA WORK LIVE RULE
002300110803   X***X
002400110803     FCARXPTP   IF   E           K DISK
002500110803     FCARACCP   IF   E           K DISK
002600110803     FCARPLNP   IF   E           K DISK
002700110803   X***X
002800130813     FAET240WF  O  A F 1231        DISK
002900110803     ** FLAT FILE
003000130813     FAET241WF  IF A E           K DISK
003100110803     ** TERM TRACKER
003200110803     **
003300110803     FMEMAC#1   IF   E           K DISK
003400110803     FMCOVMPLN  IF   E           K DISK
003500110803     FDEPNDC    IF   E           K DISK
003600110803     FDCOVA     IF   E           K DISK
003700140313     FPCPL1     IF   E           K DISK
003800110803   X***X
003900130813     D CARR#CTL        S             10A   INZ('0000000091')
004000110803     D H@RI            S             25A   INZ('042064683')                     RECEIVER ID
004100110803   X***X
004200110803     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
004300110803     D DS@CARACC     E DS                  EXTNAME(CARACCP)
004400110803     D DS@CARXPT     E DS                  EXTNAME(CARXPTP)
004500110803   X***X
004600110803     ** WORK ARRAY FOR PLANS
004700110803     **
004800110803     ** PC# - PLAN COUNT
004900110803     ** PP# - PLAN POINTER
005000110803     **
005100110803     D CARPLN@       E DS                  EXTNAME(CARPLNP)
005200140812     D                                     OCCURS(90) PREFIX(X:1)
005300110803     D PC#             S              3S 0
005400110803     D PP#             S              3S 0
005500110803     D @PLANIN         S              4A
005600110803     D @CCTRIN         S              3A
005700110803   X***X
005800110803     **
005900110803     ** WRITE TYPE = MEMBER OR DEPEND
006000110803     D WRT@TYPE        S              6A
006100110803     **
006200110803   X***X
006300110803     D #XST            S              6S 0
006400110803     D #IST            S               T
006500110803     D #ISO            S               D   DATFMT(*ISO)
006600110803     D #MINUEND        S               D   DATFMT(*ISO)
006700110803     D #SUBTRAEND      S               D   DATFMT(*ISO)
006800110803     D @DATE           S              8A
006900110803     D @TIME           S              6A
007000110803     D #DIFFRNC        S              5S 0
007100110803     D #2S0            S              2S 0
007200110803     D #CANCEL         S              8S 0
007300110803     D #XSX            S              8S 0
007400110803     D #XSX2           S              8S 0
007500110803     D DATE@OUT        S             10A
007600110803     D ENR@IN          S              3A
007700110803     D ENR@OUT         S              1A
007800110803     D DNTLATE         S              1A
007900140313     **
008000110803     D TERM_DEN        S               N
008100110803     D TERM_MED        S               N
008200110803     D YES             S               N   INZ(*ON)
008300110803     D NO              S               N   INZ(*OFF)
008400140313     **
008500110803     D KF@TRS          S                   LIKE(MCTRST)
008600110803     D KF@SUB          S                   LIKE(MCSUB#)
008700110803     D KF@ACC          S                   LIKE(ACC#)
008800110803     D KF@ENR          S              3A   INZ
008900110803     D KF@CARG         S              2A   INZ
009000110803     D KF@CCTR         S                   LIKE(CCFLG)
009100110803     D KF@PLN          S                   LIKE(MCPLAN)
009200110803     D KF@TRM          S                   LIKE(NTTERMDT)
009300110803     D KF#TRM          S              8S 0
009400110803     D KF@SSN          S                   LIKE(MBSSNO)
009500110803     D KF@SEQ          S                   LIKE(DPSEQ#)
009600110803     D KF@TYP          S              1A
009700110803     D KF@CDE          S              2A
009800140313     D KF@SPCD         S              5A
009900140313     D KF@MPLN         S              4A
010000140313     **
010100110803     D M@EARLYP        S              4A
010200110803     D M#EARLYE        S              8S 0 INZ
010300110803     D M#EARLYT        S              8S 0 INZ
010400110803     D #8D1            S              8S 0 INZ
010500110803     D D1              S              8A
010600110803     D D2              S              8A
010700110803     D T1              S              6A
010800110803     D C1              S             14A
010900110803    ***
011000110803     D B#RECCNT        S             10S 0 INZ
011100110803     D C#RECCNT        S             10S 0 INZ
011200110803    ***
011300110803     D @SS1            S              9A
011400110803     D @SS2            S              9A
011500110803     D @FN             S             15A
011600110803     D @MI             S              1A
011700110803     D @LN             S             20A
011800110803     D @REL            S              2A
011900110803     D @SEX            S              1A
012000110803     D @DOB            S              8A
012100110803     D @SPEC           S              1A
012200110803     D @COB            S              1A
012300110803     D @COBC           S              2A
012400110803     D @COBN           S             20A
012500110803     D @AD1            S             30A
012600110803     D @AD2            S             30A
012700110803     D @CTY            S             20A
012800110803     D @ST             S              2A
012900110803     D @ZP5            S              5A
013000110803     D @PHN            S             10A
013100110803     D @EMPST          S              2A
013200110803     D @HIRE           S              8A
013300110803    ***
013400110803    *** DENTAL ARRAYS
013500110803     D D#CNE           S              3S 0 INZ
013600110803     D D#NDX           S              3S 0 INZ
013700110803     D D@PLN           S              4A   DIM(20)
013800110803     D D@ENR           S              3A   DIM(20)
013900110803     D D@FRM           S              8S 0 DIM(20)
014000110803     D D@TRM           S              8S 0 DIM(20)
014100110803     D D@MBREFF        S              8S 0
014200110803    *** MEDICAL ARRAYS
014300110803     D M#CNE           S              3S 0 INZ
014400110803     D M#NDX           S              3S 0 INZ
014500110803     D M@PLN           S              4A   DIM(20)
014600110803     D M@ENR           S              3A   DIM(20)
014700110803     D M@FRM           S              8S 0 DIM(20)
014800110803     D M@TRM           S              8S 0 DIM(20)
014900110803     D M@MBREFF        S              8S 0
015000110803    ***
015100110803     D H@SI            S             20A
015200110803     D H@CC            S              2A
015300110803     D H@GN            S              7A
015400110803     D H@CN            S             15A
015500110803     D H@C#            S              7A
015600140313    ***
015700110803     D X@LAY           S              3A
015800110803     D X@ELR           S              7A
015900140313     D X@EFF           S              8A
016000140313     D X@TRM           S              8A
016100140313     D X@TIER          S              1A
016200140313    ***
016300110803     D M@CC            S              2A
016400110803     D M@CLASS         S              5A
016500110803     D M@PLAN          S              6A
016600110803     D M@PCP           S             40A
016700110803     D M@NPI           S              1A
016800110803     D M@PCPCI         S              1A
016900140313     **
017000110803     D D@SFX           S              3A
017100110803     D D@ACCT          S              5A
017200110803     D D@PLAN          S              6A
017300110803     D D@CLM           S              3A
017400110803     D D@CBREXP        S              8A
017500110803     D D@CBREVT        S              8A
017600110803     D D@CBRLEN        S              2A
017700110803     D D@OOAI          S              1A
017800140313     D D@PCD           S              7A
017900140313     **
018000140313     D @STEP           S              5A
018100140313    ***
018200140313     D E@SFX           S              3A
018300140313     D E@ACCT          S              5A
018400140313     D E@PLAN          S              6A
018500140313     D E@CLM           S              3A
018600140313     D E@PCP           S              7A
018700140313     D E@CBREXP        S              8A
018800140313     D E@CBREVT        S              8A
018900140313     D E@CBRLEN        S              2A
019000140313    ***
019100110803   X***X
019200110803     C                   EVAL      @STEP = 'PREP1'
019300110803    ***
019400110803     C     CARR#CTL      CHAIN     CARXPTR
019500110803    ***
019600110803     C     CARR#CTL      SETLL     CARACCR
019700110803    ***
019800110803     C                   DOU       @STEP = 'LEAVE'
019900110803     C     @STEP         CASEQ     'PREP1'       $PREP1
020000110803     C     @STEP         CASEQ     'STEP1'       $STEP1
020100110803     C     @STEP         CASEQ     'STEP2'       $STEP2
020200110803     C     @STEP         CASEQ     'STEP3'       $STEP3
020300110803     C     @STEP         CASEQ     'PREP4'       $PREP4
020400110803     C     @STEP         CASEQ     'STEP4'       $STEP4
020500110803     C     @STEP         CASEQ     'PREP5'       $PREP5
020600110803     C     @STEP         CASEQ     'STEP5'       $STEP5
020700110803     C     @STEP         CASEQ     'PREP6'       $PREP6
020800110803     C     @STEP         CASEQ     'STEP6'       $STEP6
020900110803     C     @STEP         CASEQ     'PREP7'       $PREP7
021000110803     C     @STEP         CASEQ     'STEP7'       $STEP7
021100110803     C     @STEP         CASEQ     'STEP8'       $STEP8
021200110803     C     @STEP         CASEQ     'PREP9'       $PREP9
021300110803     C     @STEP         CASEQ     'STEP9'       $STEP9
021400110803     C     @STEP         CASEQ     'PREPA'       $PREPA
021500110803     C     @STEP         CASEQ     'STEPA'       $STEPA
021600110803     C     @STEP         CASEQ     'PREPB'       $PREPB
021700110803     C     @STEP         CASEQ     'STEPB'       $STEPB
021800110803     C                   ENDCS
021900110803     C                   ENDDO
022000110803    ***  TRAILER RECORD
022100110803     C                   ADD       2             C#RECCNT
022200110803     C                   MOVE      C#RECCNT      @TREC            10 0
022300110803     C                   MOVE      B#RECCNT      @BREC            10 0
022400110803     C                   EXCEPT    TRLF
022500110803    ***
022600110803     C                   EVAL      *INLR = *ON
022700110803   S***S
022800110803     C     $PREP1        BEGSR
022900110803    ***
023000110803     C     CARR#CTL      READE     CARACCR
023100110803    ***
023200110803     C                   IF        %EOF(CARACCP)
023300110803     C                   EVAL      @STEP = 'LEAVE'
023400110803     C                   LEAVESR
023500110803     C                   ENDIF
023600110803    ***
023700110803    *** HAS THE ACCOUNT BEEN SHUTOFF FOR EXPORT?
023800110803    ***
023900110803     C                   IF        CASTATUS <> 'Y'
024000110803     C                   LEAVESR
024100110803     C                   ENDIF
024200110803    ***
024300110803     C                   EVAL      KF@TRS = CATRST
024400110803     C                   EVAL      KF@SUB = CASUB#
024500110803     C                   EVAL      KF@ACC = CAACCT
024600110803    ***
024700110803     C                   EXSR      $PLANLOAD
024800110803    ***
024900110803     C                   EVAL      D1 = @DATE
025000110803     C                   EVAL      D2 = @DATE
025100110803     C                   EVAL      T1 = @TIME
025200110803     C                   EVAL      C1 = @DATE + @TIME
025300110803    ***
025400110803     C                   EVAL      H@SI = %TRIM(CACID1)                         SUBMITTER ID
025500110803     C                   EVAL      H@CC = %SUBST(CACID2:1:2)                    COMPANY CODE
025600110803     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
025700110803     C                   MOVEL(P)  CACID4        H@CN                           CUSTOMER NAME
025800110803     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
025900110803    ***
026000110803     C                   EXCEPT    HDRF
026100110803    ***
026200110803     C                   EVAL      @STEP = 'STEP1'
026300110803    ***
026400110803     C                   ENDSR
026500110803   S***S
026600110803     C     $STEP1        BEGSR
026700110803    ***
026800110803     C                   EVAL      KF@PLN = *BLANKS
026900110803     C                   EVAL      KF@TRM = 0
027000110803     C                   EVAL      KF@SSN = 0
027100110803     C                   EVAL      KF@SEQ = 0
027200110803    ***
027300110803     C     KL#TSA        SETLL     MEMBR
027400110803    ***
027500110803     C                   EVAL      @STEP = 'STEP2'
027600110803    ***
027700110803     C                   ENDSR
027800110803   S***S
027900110803     C     $STEP2        BEGSR
028000110803    ***
028100110803     C     KL#TSA        READE     MEMBR
028200110803    ***
028300110803     C                   IF        %EOF(MEMAC#1)
028400110803     C                   EVAL      @STEP = 'PREP1'
028500110803     C                   LEAVESR
028600110803     C                   ENDIF
028700110803    ***
028800110803     C                   EVAL      KF@SSN = MBSSNO
028900110803     C                   MOVE      *ZEROS        KF@SEQ
029000110803    ***
029100110803    *** SET COST CENTER IF USED FROM THE MEMBER VALUE
029200110803    ***
029300110803     C                   EVAL      KF@CCTR = CCFLG
029400110803    ***
029500110803     C     KL#MPLN       SETLL     MCOVR
029600110803    ***
029700110803     C                   EXSR      $CLRSTG
029800110803    ***
029900110803     C                   EVAL      @STEP = 'STEP3'
030000110803    ***
030100110803     C                   ENDSR
030200110803   S***S
030300110803     C     $STEP3        BEGSR
030400110803    ***
030500110803     C     KL#MPLN       READE     MCOVR
030600110803    ***
030700110803     C                   IF        %EOF(MCOVMPLN)
030800110803     C                   EVAL      @STEP = 'PREP4'
030900110803     C                   LEAVESR
031000110803     C                   ENDIF
031100130813    ***
031200140811     C*******************IF        %SUBST(MCPLAN:1:3) <> 'DAA'
031300140811     C                   IF        %SUBST(MCPLAN:1:3) <> 'LAA'
031400130813     C                   LEAVESR
031500130813     C                   ENDIF
031600110803    ***
031700110803     C                   EVAL      @PLANIN = MCPLAN
031800120921     C                   EVAL      ENR@IN = MCOVTP
031900140811     C                   EVAL      WRT@TYPE = 'MEMBER'
032000120123    ***
032100120123     C                   EXSR      $QUIK
032200120123    ***
032300110803     C                   EXSR      $PLANSRCH
032400110803    ***
032500110803     C                   IF        PLN@CAT = *BLANKS
032600110803     C                   LEAVESR
032700110803     C                   ENDIF
032800110803    ***
032900110803     C                   IF        CANDT = 0
033000110803     C                   EVAL      #CANCEL = 99999999
033100110803     C                   ELSE
033200110803     C                   EVAL      #CANCEL = CANDT
033300110803     C                   ENDIF
033400110803    ***
033500110803    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL
033600110803    ***
033700110803    *C                   IF        PLN@CAT = 'DEN'
033800130130    *C                   IF        D#CNE > 0
033900130130    *C                   IF        D@TRM(D#CNE) = 99999999
034000130130     C                   LEAVESR
034100130130     C                   ENDIF
034200130130     C                   ENDIF
034300110803    *C                   ADD       1             D#CNE
034400110803    *C                   EVAL      D@PLN(D#CNE) = MCPLAN
034500110803    *C                   EVAL      D@ENR(D#CNE) = MCOVTP
034600110803    *C                   EVAL      D@FRM(D#CNE) = ENRLDT
034700110803    *C                   EVAL      D@TRM(D#CNE) = #CANCEL
034800110803    *C                   ELSE
034900130130    *C                   IF        M#CNE > 0
035000130130    *C                   IF        M@TRM(M#CNE) = 99999999
035100130130     C                   LEAVESR
035200130130     C                   ENDIF
035300130130     C                   ENDIF
035400110803     C                   ADD       1             M#CNE
035500110803     C                   EVAL      M@PLN(M#CNE) = MCPLAN
035600110803     C                   EVAL      M@ENR(M#CNE) = MCOVTP
035700110803     C                   EVAL      M@FRM(M#CNE) = ENRLDT
035800110803     C                   EVAL      M@TRM(M#CNE) = #CANCEL
035900110803    *C                   ENDIF
036000110803    ***
036100110803     C                   ENDSR
036200110803   S***S
036300120123     C     $QUIK         BEGSR
036400120123    ***
036500140811       IF @PLANIN = 'LAAL' OR @PLANIN = 'LAAM' OR @PLANIN = 'LAAK' OR
036600140811         @PLANIN = 'LAAJ';
036700140811          @CCTRIN = STATE;
036800140811          LEAVESR;
036900140811       ENDIF;
037000140811    ***
037100140811       IF @PLANIN = 'LAAN' OR @PLANIN = 'LAAP';
037200140811          SELECT;
037300140811             WHEN WRT@TYPE = 'MEMBER' AND ENR@IN = 'TIN';
037400140811                @CCTRIN = STATE + 'I';
037500140811             WHEN WRT@TYPE = 'MEMBER' AND ENR@IN <> 'TIN';
037600140811                @CCTRIN = STATE + 'F';
037700140811             WHEN WRT@TYPE = 'DEPEND';
037800140811                @CCTRIN = STATE + 'F';
037900140811          ENDSL;
038000140811          LEAVESR;
038100140811       ENDIF;
038200120123    ***
038300120123     C                   ENDSR
038400120123   S***S
038500110803     C     $PREP4        BEGSR
038600110803    ***
038700110803     C                   IF        D#CNE = 0 AND M#CNE = 0
038800110803     C                   EVAL      @STEP = 'STEP2'
038900110803     C                   LEAVESR
039000110803     C                   ENDIF
039100110803    ***
039200110803     C                   EVAL      TERM_DEN = NO
039300110803     C                   EVAL      TERM_MED = NO
039400110803    ***
039500110803     C                   IF        M#CNE > 0 AND D#CNE > 0
039600110803    *C*
039700110803     C                   IF        (D@TRM(D#CNE) = 99999999 AND
039800110803     C                              M@TRM(M#CNE) = 99999999)
039900110803     C                   EVAL      @STEP = 'STEP4'
040000110803     C                   LEAVESR
040100110803     C                   ELSE
040200110803     C                   EXSR      $CHKHEM
040300110803     C                   ENDIF
040400110803    *C*
040500110803     C                   ENDIF
040600110803    ***
040700110803     C                   IF        M#CNE > 0 AND D#CNE = 0
040800110803    *C*
040900110803     C                   IF        M@TRM(M#CNE) = 99999999
041000110803     C                   EVAL      @STEP = 'STEP4'
041100110803     C                   LEAVESR
041200110803     C                   ELSE
041300110803     C                   EXSR      $CHKHEM
041400110803     C                   ENDIF
041500110803    *C*
041600110803     C                   ENDIF
041700110803    ***
041800110803     C                   IF        M#CNE = 0 AND D#CNE > 0
041900110803    *C*
042000110803     C                   IF        D@TRM(D#CNE) = 99999999
042100110803     C                   EVAL      @STEP = 'STEP4'
042200110803     C                   LEAVESR
042300110803     C                   ELSE
042400110803     C                   EXSR      $CHKHEM
042500110803     C                   ENDIF
042600110803    *C*
042700110803     C                   ENDIF
042800110803    ***
042900110803     C                   EVAL      @STEP = 'STEP4'
043000110803    ***
043100110803     C                   ENDSR
043200110803   S***S
043300110803    *** GENERATE MEMBER RECORD
043400110803    ***
043500110803     C     $STEP4        BEGSR
043600110803    ***
043700110803     C                   IF        D#CNE = 0 AND M#CNE = 0
043800110803     C                   EVAL      @STEP = 'STEP2'
043900110803     C                   LEAVESR
044000110803     C                   ENDIF
044100110803    ***
044200110803     C                   EVAL      WRT@TYPE = 'MEMBER'
044300110803    ***
044400110803     C                   EVAL      D@MBREFF = 0
044500110803     C                   EVAL      M@MBREFF = 0
044600110803    ***
044700110803     C                   EVAL      @SS1   = %EDITC(MBSSNO:'X')
044800110803     C                   EVAL      @SS2   = @SS1
044900110803     C                   MOVEL(P)  MLNAME        @LN
045000110803     C                   MOVEL(P)  MFNAME        @FN
045100110803     C                   EVAL      @MI    = MMI
045200110803     C                   EVAL      @REL   = '01'
045300110803     C                   EVAL      @SEX   = SEX
045400110803     C                   EVAL      @DOB   = %EDITC(BIRTH:'X')
045500110803     C                   IF        COB = 'Y'
045600110803     C                   EVAL      @COB   = 'Y'
045700110803     C                   EVAL      @COBC  = 'OT'
045800110803     C                   EVAL      @COBN  = MCOBPN
045900110803     C                   ENDIF
046000110803     C                   EVAL      @AD1   = %TRIM(ADDR1)
046100110803     C                   EVAL      @AD2   = %TRIM(ADDR2)
046200110803     C                   EVAL      @CTY   = %TRIM(CITY)
046300110803     C                   EVAL      @ST    = STATE
046400110803     C                   MOVE      *BLANKS       @9                9
046500110803     C                   EVAL      @9   = %EDITC(ZIP:'X')
046600110803     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
046700110803     C                   EVAL      @PHN   = %EDITC(AREA:'X') +
046800110803     C                                      %EDITC(PHONE:'X')
046900110803    ***
047000110803     C                   SELECT
047100110803     C                   WHEN      EMPST = 'A'
047200110803     C                   EVAL      @EMPST = 'AC'
047300110803     C                   WHEN      EMPST = 'C'
047400110803     C                   EVAL      @EMPST = 'CO'
047500110803     C                   WHEN      EMPST = 'R'
047600110803     C                   EVAL      @EMPST = 'RT'
047700110803     C                   ENDSL
047800110803    ***
047900110803     C                   EVAL      @HIRE  = %EDITC(EMPDT:'X')
048000141103    ***
048100141103       IF (M@PLN(M#CNE) = 'LAAN' OR M@PLN(M#CNE) = 'LAAJ' OR
048200141103           M@PLN(M#CNE) = 'LAAP' OR M@PLN(M#CNE) = 'LAAK') AND STATE = 'WV';
048300141103          *IN88 = *ON;
048400141103       ELSE;
048500141103          *IN88 = *OFF;
048600141103       ENDIF;
048700110803    ***
048800110803     C                   EXCEPT    MBRF
048900110803     C                   ADD       1             C#RECCNT
049000110803    ***
049100110803     C                   EVAL      @STEP = 'PREP5'
049200110803    ***
049300110803     C                   ENDSR
049400110803   S***S
049500110803     C     $PREP5        BEGSR
049600110803    ***
049700110803     C                   IF        M#CNE = 0
049800110803     C                   EVAL      @STEP = 'PREP6'
049900110803     C                   LEAVESR
050000110803     C                   ENDIF
050100110803    ***
050200110803     C                   EVAL      KF@PLN = M@PLN(M#CNE)
050300130624     C                   EVAL      KF@ENR = M@ENR(M#CNE)
050400110803    ***
050500110803     C                   IF        TERM_MED = YES
050600110803     C                   EXSR      $WRTERM
050700110803     C                   ENDIF
050800110803    ***
050900110803    ***
051000110803    *** IF COST CENTER IS USED, CODE HERE, OR JUST SET IT TO BLANKS
051100110803    ***
051200130624     C                   EVAL      @PLANIN = M@PLN(M#CNE)
051300130624     C                   EVAL      ENR@IN  = M@ENR(M#CNE)
051400120123    ***
051500120123     C                   EXSR      $QUIK
051600120123    ***
051700110803     C                   EXSR      $PLANSRCH
051800110803    ***
051900110803     C                   IF        PLN@CAT = *BLANKS
052000110803     C                   SETON                                        H1
052100110803     C                   ENDIF
052200110803    ***
052300110803     C                   EVAL      @STEP = 'STEP5'
052400110803     C                   EVAL      #XSX = M@FRM(M#CNE)
052500110803     C                   EVAL      M@MBREFF = #XSX
052600110803    ***
052700110803     C                   ENDSR
052800110803   S***S
052900110803     C     $STEP5        BEGSR
053000110803    ***
053100110803     C                   IF        CPCID1 = 'MEA'
053200110803     C                   EXSR      $MEAWRT
053300110803     C                   ELSE
053400110803     C                   EXSR      $HMOWRT
053500110803     C                   ENDIF
053600110803    ***
053700110803     C                   ADD       1             C#RECCNT
053800110803     C                   ADD       1             B#RECCNT
053900110803    ***
054000110803     C                   EVAL      @STEP = 'PREP6'
054100110803    ***
054200110803     C                   ENDSR
054300110803   S***S
054400110803     C     $PREP6        BEGSR
054500110803    ***
054600110803    *C                   IF        D#CNE = 0
054700110803    *C                   EVAL      @STEP = 'PREP7'
054800110803    *C                   LEAVESR
054900110803    *C                   ENDIF
055000110803    ***
055100110803    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
055200130624     C                   EVAL      KF@ENR = D@ENR(D#CNE)
055300110803    ***
055400110803    *C                   IF        TERM_DEN = YES
055500110803    *C                   EXSR      $WRTERM
055600110803    *C                   ENDIF
055700110803    ***
055800130624     C                   EVAL      @PLANIN = D@PLN(D#CNE)
055900130624     C                   EVAL      ENR@IN  = D@ENR(D#CNE)
056000120123    ***
056100120123     C                   EXSR      $QUIK
056200110803    ***
056300110803     C                   EXSR      $PLANSRCH
056400110803    ***
056500110803     C                   IF        PLN@CAT = *BLANKS
056600110803     C                   SETON                                        H2
056700110803     C                   ENDIF
056800110803    ***
056900110803    *C                   EVAL      @STEP = 'STEP6'
057000110803     C                   EVAL      #XSX = D@FRM(D#CNE)
057100110803     C                   EVAL      D@MBREFF = #XSX
057200110803    ***
057300110803     C                   ENDSR
057400110803   S***S
057500110803    *** DENTAL FORMAT
057600110803    ***
057700110803    *C     $STEP6        BEGSR
057800110803    ***
057900110803     C                   EXSR      $DENWRT
058000110803    ***
058100110803    *C                   ADD       1             C#RECCNT
058200110803    *C                   ADD       1             B#RECCNT
058300110803    ***
058400110803    *C                   EVAL      @STEP = 'PREP7'
058500110803    ***
058600110803    *C                   ENDSR
058700110803   S***S
058800110803     C     $PREP7        BEGSR
058900110803    ***
059000110803     C     KF@SSN        CHAIN     DEPENR
059100110803     C                   IF        NOT %FOUND(DEPNDC)
059200110803     C                   EVAL      @STEP = 'STEP2'
059300110803     C                   LEAVESR
059400110803     C                   ENDIF
059500110803    ***
059600110803     C     KF@SSN        SETLL     DEPENR
059700110803    ***
059800110803     C                   EVAL      @STEP = 'STEP7'
059900110803    ***
060000110803     C                   ENDSR
060100110803   S***S
060200110803     C     $STEP7        BEGSR
060300110803    ***
060400110803     C     KF@SSN        READE     DEPENR
060500110803    ***
060600110803     C                   IF        %EOF(DEPNDC)
060700110803     C                   EVAL      @STEP = 'STEP2'
060800110803     C                   LEAVESR
060900110803     C                   ENDIF
061000110803    ***
061100110803     C                   EVAL      KF@SEQ = DPSEQ#
061200110803    ***
061300110803     C     KL#DCV        CHAIN     DCOVR
061400110803     C                   IF        NOT %FOUND(DCOVA)
061500110803     C                   LEAVESR
061600110803     C                   ENDIF
061700110803    ***
061800110803     C                   EXSR      $CLRDCV
061900110803     C     KL#DCV        SETLL     DCOVR
062000110803    ***
062100110803     C                   EVAL      @STEP = 'STEP8'
062200110803    ***
062300110803     C                   ENDSR
062400110803   S***S
062500110803     C     $STEP8        BEGSR
062600110803    ***
062700110803     C     KL#DCV        READE     DCOVR
062800110803    ***
062900110803     C                   IF        %EOF(DCOVA)
063000110803     C                   EVAL      @STEP = 'PREP9'
063100110803     C                   LEAVESR
063200110803     C                   ENDIF
063300110803    ***
063400140811     C                   IF        %SUBST(DVPLAN:1:3) <> 'LAA'
063500140811     C                   LEAVESR
063600140811     C                   ENDIF
063700140811    ***
063800110803     C                   EVAL      @PLANIN = DVPLAN
063900140811     C                   EVAL      WRT@TYPE = 'DEPEND'
064000120123    ***
064100120123     C                   EXSR      $QUIK
064200120123    ***
064300110803     C                   EXSR      $PLANSRCH
064400110803    ***
064500110803     C                   IF        PLN@CAT = *BLANKS
064600110803     C                   LEAVESR
064700110803     C                   ENDIF
064800110803    ***
064900110803     C                   EVAL      #CANCEL = CCANDT
065000110803     C                   IF        #CANCEL = 0
065100110803     C                   EVAL      #CANCEL = 99999999
065200110803     C                   ENDIF
065300110803    ***
065400110803    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL
065500110803    ***
065600110803    *C                   IF        PLN@CAT = 'DEN'
065700130130    *C                   IF        D#CNE > 0
065800130130    *C                   IF        D@TRM(D#CNE) = 99999999
065900130130     C                   LEAVESR
066000130130     C                   ENDIF
066100130130     C                   ENDIF
066200110803    *C                   ADD       1             D#CNE
066300110803    *C                   EVAL      D@PLN(D#CNE) = DVPLAN
066400110803    *C                   EVAL      D@ENR(D#CNE) = *BLANKS
066500110803    *C                   EVAL      D@FRM(D#CNE) = DENRDT
066600110803    *C                   EVAL      D@TRM(D#CNE) = #CANCEL
066700110803    *C                   ELSE
066800130130    *C                   IF        M#CNE > 0
066900130130    *C                   IF        M@TRM(M#CNE) = 99999999
067000130130     C                   LEAVESR
067100130130     C                   ENDIF
067200130130     C                   ENDIF
067300110803     C                   ADD       1             M#CNE
067400110803     C                   EVAL      M@PLN(M#CNE) = DVPLAN
067500110803     C                   EVAL      M@ENR(M#CNE) = *BLANKS
067600110803     C                   EVAL      M@FRM(M#CNE) = DENRDT
067700110803     C                   EVAL      M@TRM(M#CNE) = #CANCEL
067800110803    *C                   ENDIF
067900110803    ***
068000110803     C                   ENDSR
068100110803   S***S
068200110803     C     $PREP9        BEGSR
068300110803    ***
068400110803     C                   IF        D#CNE = 0 AND M#CNE = 0
068500110803     C                   EVAL      @STEP = 'STEP7'
068600110803     C                   LEAVESR
068700110803     C                   ENDIF
068800110803    ***
068900110803     C                   EVAL      TERM_DEN = NO
069000110803     C                   EVAL      TERM_MED = NO
069100110803    ***
069200110803     C                   IF        M#CNE > 0 AND D#CNE > 0
069300110803    *C*
069400110803     C                   IF        (D@TRM(D#CNE) = 99999999 AND
069500110803     C                              M@TRM(M#CNE) = 99999999)
069600110803     C                   EVAL      @STEP = 'STEP9'
069700110803     C                   LEAVESR
069800110803     C                   ELSE
069900110803     C                   EXSR      $CHKHEM
070000110803     C                   ENDIF
070100110803    *C*
070200110803     C                   ENDIF
070300110803    ***
070400110803     C                   IF        M#CNE > 0 AND D#CNE = 0
070500110803    *C*
070600110803     C                   IF        M@TRM(M#CNE) = 99999999
070700110803     C                   EVAL      @STEP = 'STEP9'
070800110803     C                   LEAVESR
070900110803     C                   ELSE
071000110803     C                   EXSR      $CHKHEM
071100110803     C                   ENDIF
071200110803    *C*
071300110803     C                   ENDIF
071400110803    ***
071500110803     C                   IF        M#CNE = 0 AND D#CNE > 0
071600110803    *C*
071700110803     C                   IF        D@TRM(D#CNE) = 99999999
071800110803     C                   EVAL      @STEP = 'STEP9'
071900110803     C                   LEAVESR
072000110803     C                   ELSE
072100110803     C                   EXSR      $CHKHEM
072200110803     C                   ENDIF
072300110803    *C*
072400110803     C                   ENDIF
072500110803    ***
072600110803     C                   IF        D#CNE = 0 AND M#CNE = 0
072700110803     C                   EVAL      @STEP = 'STEP7'
072800110803     C                   LEAVESR
072900110803     C                   ENDIF
073000110803    ***
073100110803     C                   EVAL      @STEP = 'STEP9'
073200110803    ***
073300110803     C                   ENDSR
073400110803   S***S
073500110803    *** GENERATE DEPENDENT RECORD
073600110803    ***
073700110803     C     $STEP9        BEGSR
073800110803    ***
073900110803     C                   EVAL      WRT@TYPE = 'DEPEND'
074000110803    ***
074100110803     C                   IF        D#CNE = 0 AND M#CNE = 0
074200110803     C                   EVAL      @STEP = 'STEP7'
074300110803     C                   LEAVESR
074400110803     C                   ENDIF
074500110803    ***
074600110803     C                   EVAL      @SS2   = %EDITC(DEPSS#:'X')
074700110803     C                   MOVEL(P)  DLNAME        @LN
074800110803     C                   MOVEL(P)  DFNAME        @FN
074900110803     C                   EVAL      @MI    = DMI
075000110803    ***
075100110803     C                   SELECT
075200110803     C                   WHEN      DRELCD = 'RWI'
075300110803     C                   EVAL      @REL   = '02'
075400110803     C                   WHEN      DRELCD = 'RHU'
075500110803     C                   EVAL      @REL   = '03'
075600110803     C                   WHEN      DRELCD = 'RSO'
075700110803     C                   EVAL      @REL   = '04'
075800110803     C                   WHEN      DRELCD = 'RDA'
075900110803     C                   EVAL      @REL   = '05'
076000110803     C                   ENDSL
076100110803    ***
076200110803     C                   SELECT
076300110803     C                   WHEN      DSTUDN = 'Y'
076400110803     C                   EVAL      @SPEC = '1'
076500140812     C                   WHEN      DHNDCP = '3'
076600110803     C                   EVAL      @SPEC = '3'
076700110803     C                   ENDSL
076800110803    ***
076900110803     C                   EVAL      @SEX   = DSEX
077000110803     C                   EVAL      @DOB   = %EDITC(DBIRTH:'X')
077100110803     C                   IF        DCOB = 'Y'
077200110803     C                   EVAL      @COB   = 'Y'
077300110803     C                   EVAL      @COBC  = 'OT'
077400110803     C                   EVAL      @COBN  = DCOBPN
077500110803     C                   ENDIF
077600110803    ***
077700110803     C                   IF        DADDR1 <> ADDR1
077800110803     C                   EVAL      @AD1   = %TRIM(DADDR1)
077900110803     C                   EVAL      @AD2   = %TRIM(DADDR2)
078000110803     C                   EVAL      @CTY   = %TRIM(DCITY)
078100110803     C                   EVAL      @ST    = DSTATE
078200110803     C                   MOVE      *BLANKS       @9                9
078300110803     C                   IF        DZIP = 0
078400110803     C                   EVAL      @9   = %EDITC(ZIP:'X')
078500110803     C                   ELSE
078600110803     C                   EVAL      @9   = %EDITC(DZIP:'X')
078700110803     C                   ENDIF
078800110803     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
078900110803     C                   EVAL      @PHN   = %EDITC(DAREA:'X') +
079000110803     C                                      %EDITC(DPHONE:'X')
079100110803     C                   ENDIF
079200110803    ***
079300141103       IF (M@PLN(M#CNE) = 'LAAN' OR M@PLN(M#CNE) = 'LAAJ' OR
079400141103           M@PLN(M#CNE) = 'LAAP' OR M@PLN(M#CNE) = 'LAAK') AND STATE = 'WV';
079500141103          *IN88 = *ON;
079600141103       ELSE;
079700141103          *IN88 = *OFF;
079800141103       ENDIF;
079900141103    ***
080000110803     C                   EXCEPT    MBRF
080100110803     C                   ADD       1             C#RECCNT
080200110803    ***
080300110803     C                   EVAL      @STEP = 'PREPA'
080400110803    ***
080500110803     C                   ENDSR
080600110803   S***S
080700110803     C     $PREPA        BEGSR
080800110803    ***
080900110803     C                   IF        M#CNE = 0
081000110803     C                   EVAL      @STEP = 'PREPB'
081100110803     C                   LEAVESR
081200110803     C                   ENDIF
081300110803    ***
081400110803     C                   EVAL      KF@PLN = M@PLN(M#CNE)
081500130624     C                   EVAL      KF@ENR = *BLANKS
081600110803    ***
081700110803     C                   IF        TERM_MED = YES
081800110803     C                   EXSR      $WRTERM
081900110803     C                   ENDIF
082000110803    ***
082100110803    ***
082200110803    *** IF COST CENTER IS USED, CODE HERE, OR JUST SET IT TO BLANKS
082300110803    ***
082400130624     C                   EVAL      @PLANIN = M@PLN(M#CNE)
082500130624     C                   EVAL      ENR@IN  = 'TFA'
082600120123    ***
082700120123     C                   EXSR      $QUIK
082800120123    ***
082900110803     C                   EXSR      $PLANSRCH
083000110803    ***
083100110803     C                   IF        PLN@CAT = *BLANKS
083200110803     C                   SETON                                        H2
083300110803     C                   ENDIF
083400110803    ***
083500110803     C                   EVAL      @STEP = 'STEPA'
083600110803    ***
083700110803     C                   ENDSR
083800110803   S***S
083900110803     C     $STEPA        BEGSR
084000110803    ***
084100110803     C                   IF        CPCID1 = 'MEA'
084200110803     C                   EXSR      $MEAWRT
084300110803     C                   ELSE
084400110803     C                   EXSR      $HMOWRT
084500110803     C                   ENDIF
084600110803    ***
084700110803     C                   ADD       1             C#RECCNT
084800110803     C                   ADD       1             B#RECCNT
084900110803    ***
085000110803     C                   EVAL      @STEP = 'PREPB'
085100110803    ***
085200110803     C                   ENDSR
085300110803   S***S
085400110803     C     $PREPB        BEGSR
085500110803    ***
085600110803    *C                   IF        D#CNE = 0
085700110803    *C                   EVAL      @STEP = 'STEP7'
085800110803    *C                   LEAVESR
085900110803    *C                   ENDIF
086000110803    ***
086100110803    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
086200130624     C                   EVAL      KF@ENR = *BLANKS
086300110803    ***
086400110803    *C                   IF        TERM_DEN = YES
086500110803    *C                   EXSR      $WRTERM
086600110803    *C                   ENDIF
086700110803    ***
086800130624     C                   EVAL      @PLANIN = D@PLN(D#CNE)
086900130624     C                   EVAL      ENR@IN  = 'TFA'
087000120123    ***
087100120123     C                   EXSR      $QUIK
087200120123    ***
087300110803     C                   EXSR      $PLANSRCH
087400110803    ***
087500110803     C                   IF        PLN@CAT = *BLANKS
087600110803     C                   SETON                                        H2
087700110803     C                   ENDIF
087800110803    ***
087900110803     C                   EVAL      @STEP = 'STEPB'
088000110803    ***
088100110803     C                   ENDSR
088200110803   S***S
088300110803    *C     $STEPB        BEGSR
088400110803    ***
088500110803     C                   EXSR      $DENWRT
088600110803    ***
088700110803    *C                   ADD       1             C#RECCNT
088800110803    *C                   ADD       1             B#RECCNT
088900110803    ***
089000110803    *C                   EVAL      @STEP = 'STEP7'
089100110803    ***
089200110803    *C                   ENDSR
089300110803   S***S
089400110803     C     *INZSR        BEGSR
089500110803    ***
089600110803     C     KL#ACCTL      KLIST
089700110803     C                   KFLD                    CARR#CTL
089800110803     C                   KFLD                    KF@TRS
089900110803     C                   KFLD                    KF@SUB
090000110803     C                   KFLD                    KF@ACC
090100110803    ***
090200110803     C     KL#TSA        KLIST
090300110803     C                   KFLD                    KF@TRS
090400110803     C                   KFLD                    KF@SUB
090500110803     C                   KFLD                    KF@ACC
090600110803    ***
090700110803     C     KL#MPLN       KLIST
090800110803     C                   KFLD                    KF@SSN
090900110803     C                   KFLD                    KF@SEQ
091000110803     C                   KFLD                    KF@TRS
091100110803     C                   KFLD                    KF@SUB
091200110803     C                   KFLD                    KF@ACC
091300110803    ***
091400110803     C     KL#CPLN       KLIST
091500110803     C                   KFLD                    CARR#CTL
091600110803     C                   KFLD                    KF@TRS
091700110803     C                   KFLD                    KF@SUB
091800110803     C                   KFLD                    KF@ACC
091900110803     C                   KFLD                    KF@CCTR
092000110803     C                   KFLD                    KF@PLN
092100110803    ***
092200110803     C     KL#DCV        KLIST
092300110803     C                   KFLD                    KF@SSN
092400110803     C                   KFLD                    KF@SEQ
092500110803    ***
092600110803     C     KL#MTR        KLIST
092700110803     C                   KFLD                    KF@SSN
092800110803     C                   KFLD                    KF@SEQ
092900110803     C                   KFLD                    KF#TRM
093000110803     C                   KFLD                    KF@PLN
093100110803     C                   KFLD                    KF@ENR
093200110803     C                   KFLD                    KF@TRS
093300110803     C                   KFLD                    KF@SUB
093400110803     C                   KFLD                    KF@ACC
093500110803    ***
093600140313     C     KL#SQPCD      KLIST
093700140313     C                   KFLD                    KF@SSN
093800140313     C                   KFLD                    KF@SEQ
093900140313     C                   KFLD                    KF@SPCD
094000140313    ***
094100110803     C     KL#PCP        KLIST
094200110803     C                   KFLD                    KF@SSN
094300110803     C                   KFLD                    KF@SEQ
094400110803    ***
094500110803     C                   EVAL      #ISO = %DATE
094600110803     C                   MOVE      #ISO          #TODAY            8 0
094700110803     C                   EVAL      #IST = %TIME
094800110803     C                   MOVE      #ISO          #XSX
094900110803     C                   MOVE      #XSX          @DATE
095000110803     C                   MOVE      #IST          #XST
095100110803     C                   MOVE      #XST          @TIME
095200110803    ***
095300110803     C                   ENDSR
095400110803   S***S
095500110803    *** PLANS LOADED BY ACCOUNT
095600110803    ***
095700110803     C     $PLANLOAD     BEGSR
095800110803    ***
095900110803     C                   EVAL      PP# = 0
096000140812     C                   DO        90
096100110803     C                   ADD       1             PP#
096200110803     C     PP#           OCCUR     CARPLN@
096300110803     C                   CLEAR                   CARPLN@
096400110803     C                   ENDDO
096500110803     C                   EVAL      PC# = 0
096600110803     C                   EVAL      PP# = 0
096700110803    ***
096800110803     C     KL#ACCTL      SETLL     CARPLNR
096900110803     C                   DOU       %EOF(CARPLNP)
097000110803     C     KL#ACCTL      READE     CARPLNR
097100110803     C                   IF        NOT %EOF(CARPLNP)
097200110803    ***
097300110803     C                   ADD       1             PC#
097400110803     C     PC#           OCCUR     CARPLN@
097500110803     C                   EVAL      CARPLN@ = DS@CARPLN
097600110803    ***
097700110803     C                   ENDIF
097800110803     C                   ENDDO
097900110803    ***
098000110803     C                   ENDSR
098100110803   S***S
098200110803     C     $CLRSTG       BEGSR
098300110803    ***
098400110803     C                   EVAL      #CANCEL = 0
098500110803     C                   EVAL      D#CNE = 0
098600110803     C                   CLEAR                   D@PLN
098700110803     C                   CLEAR                   D@ENR
098800110803     C                   CLEAR                   D@FRM
098900110803     C                   CLEAR                   D@TRM
099000110803     C                   EVAL      M#CNE = 0
099100110803     C                   CLEAR                   M@PLN
099200110803     C                   CLEAR                   M@ENR
099300110803     C                   CLEAR                   M@FRM
099400110803     C                   CLEAR                   M@TRM
099500110803    ***
099600110803     C                   EXSR      $CLRDMG
099700110803    ***
099800110803     C                   ENDSR
099900110803   S***S
100000110803     C     $CLRDMG       BEGSR
100100110803    ***
100200110803     C                   EVAL      @SS1   = *BLANKS
100300110803     C                   EVAL      @SS2   = *BLANKS
100400110803     C                   MOVE      *BLANKS       @LN
100500110803     C                   MOVEL     *BLANKS       @FN
100600110803     C                   EVAL      @MI    = *BLANKS
100700110803     C                   EVAL      @REL   = *BLANKS
100800110803     C                   EVAL      @SEX   = *BLANKS
100900110803     C                   EVAL      @DOB   = *BLANKS
101000110803     C                   EVAL      @SPEC  = *BLANKS
101100110803     C                   EVAL      @COB   = *BLANKS
101200110803     C                   EVAL      @COBC  = *BLANKS
101300110803     C                   EVAL      @COBN  = *BLANKS
101400110803     C                   EVAL      @AD1   = *BLANKS
101500110803     C                   EVAL      @AD2   = *BLANKS
101600110803     C                   EVAL      @CTY   = *BLANKS
101700110803     C                   EVAL      @ST    = *BLANKS
101800110803     C                   EVAL      @ZP5   = *BLANKS
101900110803     C                   EVAL      @PHN   = *BLANKS
102000110803     C                   EVAL      @EMPST = *BLANKS
102100110803     C                   EVAL      @HIRE  = *BLANKS
102200110803    ***
102300110803     C                   ENDSR
102400110803   S***S
102500110803     C     $CHKHEM       BEGSR
102600110803    ***
102700110803    *C                   IF        D#CNE > 0 AND D@TRM(D#CNE) <> 99999999
102800110803    *C                   EXSR      $CHKDEN
102900110803    *C                   ENDIF
103000110803      *
103100110803     C                   IF        M#CNE > 0 AND M@TRM(M#CNE) <> 99999999
103200110803     C                   EXSR      $CHKMED
103300110803     C                   ENDIF
103400110803    ***
103500110803     C                   ENDSR
103600110803   S***S
103700110803    *C     $CHKDEN       BEGSR
103800110803    ***
103900110803    *C                   EVAL      TERM_DEN = YES
104000110803    *C                   EVAL      KF#TRM = D@TRM(D#CNE)
104100110803    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
104200110803    *C                   EVAL      KF@ENR = D@ENR(D#CNE)
104300110803    ***
104400130813    *C     KL#MTR        CHAIN     AET241F
104500130813    *C                   IF        %FOUND(AET241WF)
104600110803    *C                   EVAL      D#CNE = 0
104700110803    *C                   EVAL      TERM_DEN = NO
104800110803    *C                   ENDIF
104900110803    ***
105000110803    *C                   ENDSR
105100110803   S***S
105200110803     C     $CHKMED       BEGSR
105300110803    ***
105400110803     C                   EVAL      TERM_MED = YES
105500110803     C                   EVAL      KF#TRM = M@TRM(M#CNE)
105600110803     C                   EVAL      KF@PLN = M@PLN(M#CNE)
105700110803     C                   EVAL      KF@ENR = M@ENR(M#CNE)
105800110803      *
105900130813     C     KL#MTR        CHAIN     AET241F
106000130813     C                   IF        %FOUND(AET241WF)
106100110803     C                   EVAL      TERM_MED = NO
106200110803     C                   EVAL      M#CNE = 0
106300110803     C                   ENDIF
106400110803    ***
106500110803     C                   ENDSR
106600110803   S***S
106700110803     C     $PLANSRCH     BEGSR
106800110803    ***
106900110803     C                   MOVE      *BLANKS       PLN@CAT           3
107000110803     C                   EVAL      PP# = 0
107100110803     C                   CLEAR                   DS@CARPLN
107200110803    ***
107300110803     C                   DO        PC#
107400110803    * *
107500110803     C                   ADD       1             PP#
107600110803     C     PP#           OCCUR     CARPLN@
107700110803    * *
107800110803     C                   IF        XPPLAN = @PLANIN AND
107900110803     C                             XPCCTR = @CCTRIN
108000110803     C                   EVAL      DS@CARPLN = CARPLN@
108100110803     C                   LEAVE
108200110803     C                   ENDIF
108300110803    * *
108400110803     C                   ENDDO
108500110803    ***
108600110803     C                   IF        CPPLAN = *BLANKS
108700110803     C                   LEAVESR
108800110803     C                   ENDIF
108900110803    ***
109000110803     C                   SELECT
109100110803     C                   WHEN      CPCID1 = 'MEA' OR
109200110803     C                             CPCID1 = 'HMO'
109300110803     C                   EVAL      PLN@CAT = 'MED'
109400110803     C                   WHEN      CPCID1 = 'DEN'
109500110803     C                   EVAL      PLN@CAT = 'DEN'
109600110803     C                   ENDSL
109700110803    ***
109800110803     C                   ENDSR
109900110803   S***S
110000110803     C     $ENROLL       BEGSR
110100110803    ***
110200110803     C                   EVAL      ENR@OUT = *BLANKS
110300110803     C                   SELECT
110400110803     C                   WHEN      ENR@IN = 'TIN' OR ENR@IN = 'TMI'
110500110803     C                   EVAL      ENR@OUT = 'S'
110600110803     C                   WHEN      ENR@IN = 'THW'
110700110803     C                   EVAL      ENR@OUT = 'C'
110800110803     C                   WHEN      ENR@IN = 'TPC'
110900110803     C                   EVAL      ENR@OUT = 'P'
111000110803     C                   WHEN      ENR@IN = 'TP2'
111100110803     C                   EVAL      ENR@OUT = 'Q'
111200110803     C                   WHEN      ENR@IN = 'TFA'
111300110803     C                   EVAL      ENR@OUT = 'F'
111400110803     C                   ENDSL
111500110803    ***
111600110803     C                   ENDSR
111700110803   S***S
111800110803     C     $WRTERM       BEGSR
111900110803    ***
112000130813     C                   CLEAR                   AET241F
112100110803     C                   EVAL      NTSSNO         = KF@SSN
112200110803     C                   EVAL      NTDEPNO        = KF@SEQ
112300110803     C                   EVAL      NTTERMDT       = KF#TRM
112400110803     C                   EVAL      NTPLAN         = KF@PLN
112500110803     C                   EVAL      NTCOVTP        = KF@ENR
112600110803     C                   EVAL      NTTRST         = KF@TRS
112700110803     C                   EVAL      NTSUB#         = KF@SUB
112800110803     C                   EVAL      NTACCT         = KF@ACC
112900110803     C                   EVAL      NTTRANSDT      = #TODAY
113000130813     C                   WRITE     AET241F
113100110803    ***
113200110803     C                   ENDSR
113300110803   S***S
113400110803     C     $HMOWRT       BEGSR
113500110803    ***
113600110803     C                   EVAL      X@LAY = CPCID1                               LAYOUT
113700110803     C                   EVAL      X@ELR = CPCID2                               FILE NUMBER
113800110803     C                   EVAL      M@CC = CACID2                                COMPANY CODE
113900110803     C                   EVAL      M@CLASS = CPCID3                             CLASS CODE
114000110803     C                   EVAL      M@PLAN = CPCID4                              PLAN NUMBER
114100110803    ***
114200110803     C                   EVAL      #XSX = M@FRM(M#CNE)
114300110803     C                   IF        WRT@TYPE = 'DEPEND' AND
114400110803     C                             #XSX < M@MBREFF
114500110803     C                   MOVE      M@MBREFF      X@EFF
114600110803     C                   ELSE
114700110803     C                   MOVE      #XSX          X@EFF
114800110803     C                   ENDIF
114900110803    ***
115000110803     C                   EVAL      #XSX = M@TRM(M#CNE)
115100110803     C                   IF        #XSX = 0 OR #XSX = 99999999
115200110803     C                   MOVE      *BLANKS       X@TRM
115300110803     C                   ELSE
115400110803     C                   MOVE      #XSX          X@TRM
115500110803     C                   ENDIF
115600110803    ***
115700110803     C                   IF        WRT@TYPE = 'MEMBER'
115800110803     C                   EVAL      KF@SEQ = 0
115900110803     C                   EVAL      ENR@IN = M@ENR(M#CNE)
116000110803     C                   EXSR      $ENROLL
116100110803     C                   EVAL      X@TIER = ENR@OUT
116200110803     C                   ELSE
116300110803     C                   EVAL      X@TIER = *BLANKS
116400110803     C                   ENDIF
116500110803    ***
116600140313     C                   EVAL      KF@SPCD = 'MED'
116700140313     C                   EVAL      M@PCP = *BLANKS
116800140313     C                   EVAL      M@NPI = *BLANKS
116900140313     C                   EVAL      M@PCPCI = *BLANKS
117000140313    ***
117100140313     C                   EXSR      $PCP
117200140313    ***
117300140313     C                   IF        DOCTOR <> *BLANKS
117400140313     C                   EVAL      M@PCP = DOCTOR
117500140313     C                   EVAL      M@NPI = 'Y'
117600140313     C                   EVAL      M@PCPCI = '0'
117700140313     C                   ENDIF
117800110803    ***
117900110803     C                   EXCEPT    HMOF
118000110803    ***
118100110803     C                   ENDSR
118200110803   S***S
118300110803     C     $MEAWRT       BEGSR
118400110803    ***
118500110803     C                   EVAL      X@LAY = CPCID1                               LAYOUT
118600110803     C                   EVAL      X@ELR = CPCID2                               ELR
118700140313     C                   EVAL      E@SFX = CPCID3                               SUFFIX
118800140313     C                   EVAL      E@ACCT = CPCID4                              ACCOUNT
118900140313     C                   EVAL      E@PLAN = CPCID5                              PLAN
119000140313     C                   EVAL      E@CLM = CPCID6                               CLAIM OFFICE
119100110803    ***
119200110803     C                   EVAL      #XSX = M@FRM(M#CNE)
119300110803     C                   IF        WRT@TYPE = 'DEPEND' AND
119400110803     C                             #XSX < M@MBREFF
119500110803     C                   MOVE      M@MBREFF      X@EFF
119600110803     C                   ELSE
119700110803     C                   MOVE      #XSX          X@EFF
119800110803     C                   ENDIF
119900110803    ***
120000110803     C                   EVAL      #XSX = M@TRM(M#CNE)
120100110803     C                   IF        #XSX = 0 OR #XSX = 99999999
120200110803     C                   MOVE      *BLANKS       X@TRM
120300110803     C                   ELSE
120400110803     C                   MOVE      #XSX          X@TRM
120500110803     C                   ENDIF
120600110803    ***
120700140313     C                   MOVE      *BLANKS       E@CBREXP
120800140313     C                   MOVE      *BLANKS       E@CBREVT
120900140313     C                   MOVE      *BLANKS       E@CBRLEN
121000140313     C                   IF        WRT@TYPE = 'MEMBER'
121100140313     C                   IF        EMPST = 'C'
121200140313     C                   MOVE      CEXPDT        E@CBREXP
121300140313     C                   MOVE      QEDT          E@CBREVT
121400140313     C                   MOVE      CEXPDT        #MINUEND
121500140313     C                   MOVE      QEDT          #SUBTRAEND
121600140313     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
121700140313     C                   Z-ADD     #DIFFRNC      #2S0
121800140313     C                   MOVE      #2S0          E@CBRLEN
121900140313     C                   ENDIF
122000140313     C                   ENDIF
122100140313    ***
122200140313     C                   EVAL      *IN80 = *OFF
122300140313     C                   EVAL      KF@SPCD = 'MED'
122400140313     C                   EVAL      E@PCP = *BLANKS
122500140313     C                   EXSR      $PCP
122600140313     C                   IF        DOCTOR <> *BLANKS
122700140313     C                   EVAL      E@PCP = DOCTOR
122800140313     C                   EVAL      *IN80 = *ON
122900140313     C                   ENDIF
123000140313    ***
123100140313     C                   EXCEPT    MEAF
123200110803    ***
123300110803     C                   ENDSR
123400110803   S***S
123500140313     C     $PCP          BEGSR
123600140313    ***
123700140313     C                   MOVE      *BLANKS       DOCTOR            7
123800140313     C     KL#SQPCD      CHAIN     PCPR
123900140313     C                   IF        NOT %FOUND(PCPL1)
124000140313     C                   LEAVESR
124100140313     C                   ENDIF
124200140313     C     KL#SQPCD      SETLL     PCPR
124300140313     C                   DOU       %EOF(PCPL1)
124400140313     C     KL#SQPCD      READE     PCPR
124500140313     C                   IF        NOT %EOF(PCPL1) AND PCCAN = 0
124600140313     C                   MOVEL(P)  PCID#         DOCTOR
124700140313     C                   LEAVESR
124800140313     C                   ENDIF
124900140313     C                   ENDDO
125000140313    ***
125100140313     C                   ENDSR
125200140313   S***S
125300110803     C     $CLRDCV       BEGSR
125400110803    ***
125500110803     C                   MOVE      *BLANKS       @LN
125600110803     C                   MOVEL     *BLANKS       @FN
125700110803     C                   EVAL      @SS2   = *BLANKS
125800110803     C                   EVAL      @MI    = *BLANKS
125900110803     C                   EVAL      @REL   = *BLANKS
126000110803     C                   EVAL      @SEX   = *BLANKS
126100110803     C                   EVAL      @DOB   = *BLANKS
126200110803     C                   EVAL      @SPEC  = *BLANKS
126300110803     C                   EVAL      @COB   = *BLANKS
126400110803     C                   EVAL      @COBC  = *BLANKS
126500110803     C                   EVAL      @COBN  = *BLANKS
126600110803    ***
126700110803     C                   EVAL      #CANCEL = 0
126800110803     C                   EVAL      D#CNE = 0
126900110803     C                   CLEAR                   D@PLN
127000110803     C                   CLEAR                   D@ENR
127100110803     C                   CLEAR                   D@FRM
127200110803     C                   CLEAR                   D@TRM
127300110803     C                   EVAL      M#CNE = 0
127400110803     C                   CLEAR                   M@PLN
127500110803     C                   CLEAR                   M@ENR
127600110803     C                   CLEAR                   M@FRM
127700110803     C                   CLEAR                   M@TRM
127800110803    ***
127900110803     C                   ENDSR
128000110803   S***S
128100110803     C     $DENWRT       BEGSR
128200110803    ***
128300110803    *C                   EVAL      X@LAY = CPCID1                               LAYOUT
128400110803    *C                   EVAL      X@ELR = CPCID2                               ELR
128500110803    *C                   EVAL      D@SFX = CPCID3                               SUFFIX
128600110803    *C                   EVAL      D@ACCT = CPCID4                              ACCOUNT
128700110803    *C                   EVAL      D@PLAN = CPCID5                              PLAN
128800110803    *C                   EVAL      D@CLM = CPCID6                               CLAIM OFFICE
128900110803     C                   EVAL      DNTLATE = '0'
129000110803    ***
129100110803    *C                   EVAL      #XSX = D@FRM(D#CNE)
129200110803     C                   IF        WRT@TYPE = 'DEPEND' AND
129300110803     C                             #XSX < D@MBREFF
129400110803     C                   MOVE      D@MBREFF      X@EFF
129500110803     C                   ELSE
129600110803     C                   MOVE      #XSX          X@EFF
129700110803     C                   ENDIF
129800110803    ***
129900110803    *C                   EVAL      #XSX = D@TRM(D#CNE)
130000110803    *C                   IF        #XSX = 0 OR #XSX = 99999999
130100110803    *C                   MOVE      *BLANKS       X@TRM
130200110803    *C                   ELSE
130300110803    *C                   MOVE      #XSX          X@TRM
130400110803    *C                   ENDIF
130500110803    ***
130600130423     C                   MOVE      *BLANKS       D@CBREXP
130700130423     C                   MOVE      *BLANKS       D@CBREVT
130800130423     C                   MOVE      *BLANKS       D@CBRLEN
130900110803     C                   IF        WRT@TYPE = 'MEMBER'
131000110803    *C                   IF        EMPST = 'C'
131100110803    *C                   MOVE      CEXPDT        D@CBREXP
131200110803    *C                   MOVE      QEDT          D@CBREVT
131300110803    *C                   MOVE      CEXPDT        #MINUEND
131400110803    *C                   MOVE      QEDT          #SUBTRAEND
131500110803    *C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
131600110803    *C                   Z-ADD     #DIFFRNC      #2S0
131700110803    *C                   MOVE      #2S0          D@CBRLEN
131800110803    *C                   ENDIF
131900110803    *C                   ENDIF
132000110803    ***
132100140313     C*  ***PLANS***  IF THIS APPLIES TO THE ACCOUNT; IF NOT, JUST SEND BLANKS
132200140313    *C                   IF        KF@PLN = 'DDDD'
132300140313     C*  ***PLANS***
132400140313    *C                   MOVE      '0'           D@OOAI
132500140313     C                   ELSE
132600140313    *C                   MOVE      *BLANKS       D@OOAI
132700140313    *C                   ENDIF
132800140313    ***
132900140313     C                   EVAL      KF@SPCD = 'DEN'
133000140313     C                   EVAL      D@PCD = *BLANKS
133100140313     C                   EVAL      *IN81 = *OFF
133200140313     C                   MOVE      *BLANKS       DOCTOR
133300140313    ***
133400140313     C                   EXSR      $PCP
133500140313    ***
133600140313     C                   IF        DOCTOR <> *BLANKS
133700140313     C                   EVAL      D@PCD = DOCTOR
133800140313     C                   EVAL      *IN81 = *ON
133900140313     C                   ENDIF
134000140313    ***
134100140313    *C                   EXCEPT    DENF
134200110803    ***
134300110803    *C                   ENDSR
134400110803   S***S
134500110803   X***X
134600130813     OAET240WF  EADD         HDRF
134700110803     O                                            6 'HEADER'
134800130827     O                                            8 'P'
134900110803     O                       H@SI                28
135000110803     O                                           29 '0'
135100110803     O                       C1                  43
135200110803     O                       D1                  51
135300110803     O                       T1                  57
135400110803     O                                          131 'CONSOLIDATED ELIGIBILITY'
135500110803     O                       H@RI               167
135600110803     O                       H@CC               169
135700110803     O                       H@GN               176
135800110803     O                       H@CN               191
135900110803     O                       H@C#               198
136000110803     O                       D2                 206
136100110803     O                                          216 '02'
136200110803     O                                          231 '*'
136300130813     OAET240WF  EADD         MBRF
136400110803     O                                            6 'MEMBER'
136500110803     O                       @SS1                16
136600110803     O                       @SS2                25
136700110803     O                       @FN                 75
136800110803     O                       @MI                 76
136900110803     O                       @LN                 96
137000110803     O                       @REL               101
137100110803     O                       @SEX               103
137200110803     O                       @DOB               111
137300110803     O                       @SPEC              112
137400110803     O                                          113 '0'
137500110803     O                       @COB               123
137600110803     O                       @COBC              125
137700110803     O                       @COBN              145
137800110803     O                       @AD1               175
137900110803     O                       @AD2               205
138000110803     O                       @CTY               315
138100110803     O                       @ST                317
138200110803     O                       @ZP5               322
138300110803     O                       @PHN               349
138400141103     O               88                         576 '21702'
138500110803     O                       @EMPST             665
138600110803     O                       @HIRE              673
138700110803     O                                         1231 '*'
138800130813     OAET240WF  EADD         HMOF
138900110803     O                                            7 'BENEFIT'
139000110803     O                       X@LAY               10
139100110803     O                       X@ELR               24
139200110803     O                       M@CC                26
139300110803     O                       H@GN                38
139400110803     O                       M@CLASS             44
139500110803     O                       M@PLAN              50
139600110803     O                       X@EFF               58
139700111201     O                       X@TRM               66
139800110803     O                       X@TIER              69
139900110803     O                       M@PCP              160
140000110803     O                       M@NPI              161
140100110803     O                       M@PCPCI            186
140200110803     O                                          323 '*'
140300140313    ***
140400140313     OAET240WF  EADD         MEAF
140500140313     O                                            7 'BENEFIT'
140600140313     O                                           10 'MEA'
140700140313     O                       X@ELR               24
140800140313     O                       H@C#                31
140900140313     O                       E@SFX               34
141000140313     O                       E@ACCT              44
141100140313     O                       E@PLAN              50
141200140313     O                       X@EFF               58
141300140313     O                       X@TRM               66
141400140313     O                       E@CLM               71
141500140313     *** PCP BGN
141600140313     O                       E@PCP              127
141700140313     O               80                         161 'N'
141800140313     O               80                         186 '0'
141900140313     *** PCP END
142000140313     O                                          389 '0'
142100140313     *** COBRA BGN
142200140313     O                       E@CBREXP           466
142300140313     O                       E@CBREVT           516
142400140313     O                       E@CBRLEN           560
142500140313     *** COBRA END
142600140313     O                                          678 '*'
142700140313    ***
142800130813     OAET240WF  EADD         DENF
142900110803     O                                            7 'BENEFIT'
143000110803     O                       X@LAY               10
143100110803     O                       X@ELR               24
143200110803     O                       H@C#                31
143300110803     O                       D@SFX               34
143400110803     O                       D@ACCT              44
143500110803     O                       D@PLAN              50
143600110803     O                       X@EFF               58
143700111201     O                       X@TRM               66
143800110803     O                       D@CLM               71
143900140313     *** PCD BGN
144000140313     O                       D@PCD              200
144100140313     O               81                         236 '0'
144200140313     *** PCD END
144300140313     O                                          389 '0'
144400140313     *** COBRA BGN
144500140313     O                       D@CBREXP           466
144600140313     O                       D@CBREVT           516
144700140313     O                       D@CBRLEN           560
144800140313     *** COBRA END
144900140313     O                       D@OOAI             609
145000140313     O                                          678 '*'
145100140313    ***
145200130813     OAET240WF  EADD         TRLF
145300110803     O                                            7 'TRAILER'
145400110803     O                       @TREC               17
145500110803     O                       D1                  25
145600110803     O                       T1                  31
145700110803     O                       @BREC               41
145800110803     O                                           69 '*'
