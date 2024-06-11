000100110803   X***X CARRIER CONTROL ID #0000000000 AETNA SPECIFIC
000200110803   X***X SSK 05.13.2011 TEMPLATE DESIGN
000300110803   X***X
000400110803   X***X 05.12.2011 CLONED FROM AET0X0R
000500110803   X***X MM.DD.YYYY AETNA APPROVED FOR PRODUCTION
000600110803   X***X
000700110803   X***X
000800110803   X***X ACCOUNTS SET-UP
000900110803   X***X TTT-SSS-AAAA  X
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
002000110803   X***X
002100110803   X***X
002200110803   X***X
002300110803     FCARXPTP   IF   E           K DISK
002400110803     FCARACCP   IF   E           K DISK
002500110803     FCARPLNP   IF   E           K DISK
002600110803   X***X
002700110803     FAET000WF  O  A F 1231        DISK
002800110803     ** FLAT FILE
002900110803     FAET001WF  IF A E           K DISK
003000110803     ** TERM TRACKER
003100110803     **
003200110803     FMEMAC#1   IF   E           K DISK
003300110803     FMCOVMPLN  IF   E           K DISK
003400110803     FDEPNDC    IF   E           K DISK
003500110803     FDCOVA     IF   E           K DISK
003600110803     FPCP       IF   E           K DISK
003700110803   X***X
003800110803     D CARR#CTL        S             10A   INZ('0000000000')
003900110803     D H@RI            S             25A   INZ('042064683')                     RECEIVER ID
004000110803   X***X
004100110803     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
004200110803     D DS@CARACC     E DS                  EXTNAME(CARACCP)
004300110803     D DS@CARXPT     E DS                  EXTNAME(CARXPTP)
004400110803   X***X
004500110803     ** WORK ARRAY FOR PLANS
004600110803     **
004700110803     ** PC# - PLAN COUNT
004800110803     ** PP# - PLAN POINTER
004900110803     **
005000110803     D CARPLN@       E DS                  EXTNAME(CARPLNP)
005100110803     D                                     OCCURS(50) PREFIX(X:1)
005200110803     D PC#             S              3S 0
005300110803     D PP#             S              3S 0
005400110803     D @PLANIN         S              4A
005500110803     D @CCTRIN         S              3A
005600110803   X***X
005700110803     **
005800110803     ** WRITE TYPE = MEMBER OR DEPEND
005900110803     D WRT@TYPE        S              6A
006000110803     **
006100110803   X***X
006200110803     D #XST            S              6S 0
006300110803     D #IST            S               T
006400110803     D #ISO            S               D   DATFMT(*ISO)
006500110803     D #MINUEND        S               D   DATFMT(*ISO)
006600110803     D #SUBTRAEND      S               D   DATFMT(*ISO)
006700110803     D @DATE           S              8A
006800110803     D @TIME           S              6A
006900110803     D #DIFFRNC        S              5S 0
007000110803     D #2S0            S              2S 0
007100110803     D #CANCEL         S              8S 0
007200110803     D #XSX            S              8S 0
007300110803     D #XSX2           S              8S 0
007400110803     D DATE@OUT        S             10A
007500110803     D ENR@IN          S              3A
007600110803     D ENR@OUT         S              1A
007700110803     D DNTLATE         S              1A
007800110803     D TERM_DEN        S               N
007900110803     D TERM_MED        S               N
008000110803     D YES             S               N   INZ(*ON)
008100110803     D NO              S               N   INZ(*OFF)
008200110803     D KF@TRS          S                   LIKE(MCTRST)
008300110803     D KF@SUB          S                   LIKE(MCSUB#)
008400110803     D KF@ACC          S                   LIKE(ACC#)
008500110803     D KF@ENR          S              3A   INZ
008600110803     D KF@CARG         S              2A   INZ
008700110803     D KF@CCTR         S                   LIKE(CCFLG)
008800110803     D KF@PLN          S                   LIKE(MCPLAN)
008900110803     D KF@TRM          S                   LIKE(NTTERMDT)
009000110803     D KF#TRM          S              8S 0
009100110803     D KF@SSN          S                   LIKE(MBSSNO)
009200110803     D KF@SEQ          S                   LIKE(DPSEQ#)
009300110803     D KF@TYP          S              1A
009400110803     D KF@CDE          S              2A
009500110803     D M@EARLYP        S              4A
009600110803     D M#EARLYE        S              8S 0 INZ
009700110803     D M#EARLYT        S              8S 0 INZ
009800110803     D KF@MPLN         S              4A
009900110803     D #8D1            S              8S 0 INZ
010000110803     D D1              S              8A
010100110803     D D2              S              8A
010200110803     D T1              S              6A
010300110803     D C1              S             14A
010400110803    ***
010500110803     D B#RECCNT        S             10S 0 INZ
010600110803     D C#RECCNT        S             10S 0 INZ
010700110803    ***
010800110803     D @SS1            S              9A
010900110803     D @SS2            S              9A
011000110803     D @FN             S             15A
011100110803     D @MI             S              1A
011200110803     D @LN             S             20A
011300110803     D @REL            S              2A
011400110803     D @SEX            S              1A
011500110803     D @DOB            S              8A
011600110803     D @SPEC           S              1A
011700110803     D @COB            S              1A
011800110803     D @COBC           S              2A
011900110803     D @COBN           S             20A
012000110803     D @AD1            S             30A
012100110803     D @AD2            S             30A
012200110803     D @CTY            S             20A
012300110803     D @ST             S              2A
012400110803     D @ZP5            S              5A
012500110803     D @PHN            S             10A
012600110803     D @EMPST          S              2A
012700110803     D @HIRE           S              8A
012800110803    ***
012900110803    *** DENTAL ARRAYS
013000110803     D D#CNE           S              3S 0 INZ
013100110803     D D#NDX           S              3S 0 INZ
013200110803     D D@PLN           S              4A   DIM(20)
013300110803     D D@ENR           S              3A   DIM(20)
013400110803     D D@FRM           S              8S 0 DIM(20)
013500110803     D D@TRM           S              8S 0 DIM(20)
013600110803     D D@MBREFF        S              8S 0
013700110803    *** MEDICAL ARRAYS
013800110803     D M#CNE           S              3S 0 INZ
013900110803     D M#NDX           S              3S 0 INZ
014000110803     D M@PLN           S              4A   DIM(20)
014100110803     D M@ENR           S              3A   DIM(20)
014200110803     D M@FRM           S              8S 0 DIM(20)
014300110803     D M@TRM           S              8S 0 DIM(20)
014400110803     D M@MBREFF        S              8S 0
014500110803    ***
014600110803     D H@SI            S             20A
014700110803     D H@CC            S              2A
014800110803     D H@GN            S              7A
014900110803     D H@CN            S             15A
015000110803     D H@C#            S              7A
015100110803     D X@LAY           S              3A
015200110803     D X@ELR           S              7A
015300110803     D M@CC            S              2A
015400110803     D M@CLASS         S              5A
015500110803     D M@PLAN          S              6A
015600110803     D X@EFF           S              8A
015700110803     D X@TRM           S              8A
015800110803     D X@TIER          S              1A
015900110803     D M@PCP           S             40A
016000110803     D M@NPI           S              1A
016100110803     D M@PCPCI         S              1A
016200110803     D D@SFX           S              3A
016300110803     D D@ACCT          S              5A
016400110803     D D@PLAN          S              6A
016500110803     D D@CLM           S              3A
016600110803     D D@CBREXP        S              8A
016700110803     D D@CBREVT        S              8A
016800110803     D D@CBRLEN        S              2A
016900110803     D D@OOAI          S              1A
017000110803     D @STEP           S              5A
017100110803   X***X
017200110803     C                   EVAL      @STEP = 'PREP1'
017300110803    ***
017400110803     C     CARR#CTL      CHAIN     CARXPTR
017500110803    ***
017600110803     C     CARR#CTL      SETLL     CARACCR
017700110803    ***
017800110803     C                   DOU       @STEP = 'LEAVE'
017900110803     C     @STEP         CASEQ     'PREP1'       $PREP1
018000110803     C     @STEP         CASEQ     'STEP1'       $STEP1
018100110803     C     @STEP         CASEQ     'STEP2'       $STEP2
018200110803     C     @STEP         CASEQ     'STEP3'       $STEP3
018300110803     C     @STEP         CASEQ     'PREP4'       $PREP4
018400110803     C     @STEP         CASEQ     'STEP4'       $STEP4
018500110803     C     @STEP         CASEQ     'PREP5'       $PREP5
018600110803     C     @STEP         CASEQ     'STEP5'       $STEP5
018700110803     C     @STEP         CASEQ     'PREP6'       $PREP6
018800110803     C     @STEP         CASEQ     'STEP6'       $STEP6
018900110803     C     @STEP         CASEQ     'PREP7'       $PREP7
019000110803     C     @STEP         CASEQ     'STEP7'       $STEP7
019100110803     C     @STEP         CASEQ     'STEP8'       $STEP8
019200110803     C     @STEP         CASEQ     'PREP9'       $PREP9
019300110803     C     @STEP         CASEQ     'STEP9'       $STEP9
019400110803     C     @STEP         CASEQ     'PREPA'       $PREPA
019500110803     C     @STEP         CASEQ     'STEPA'       $STEPA
019600110803     C     @STEP         CASEQ     'PREPB'       $PREPB
019700110803     C     @STEP         CASEQ     'STEPB'       $STEPB
019800110803     C                   ENDCS
019900110803     C                   ENDDO
020000110803    ***  TRAILER RECORD
020100110803     C                   ADD       2             C#RECCNT
020200110803     C                   MOVE      C#RECCNT      @TREC            10 0
020300110803     C                   MOVE      B#RECCNT      @BREC            10 0
020400110803     C                   EXCEPT    TRLF
020500110803    ***
020600110803     C                   EVAL      *INLR = *ON
020700110803   S***S
020800110803     C     $PREP1        BEGSR
020900110803    ***
021000110803     C     CARR#CTL      READE     CARACCR
021100110803    ***
021200110803     C                   IF        %EOF(CARACCP)
021300110803     C                   EVAL      @STEP = 'LEAVE'
021400110803     C                   LEAVESR
021500110803     C                   ENDIF
021600110803    ***
021700110803    *** HAS THE ACCOUNT BEEN SHUTOFF FOR EXPORT?
021800110803    ***
021900110803     C                   IF        CASTATUS <> 'Y'
022000110803     C                   LEAVESR
022100110803     C                   ENDIF
022200110803    ***
022300110803     C                   EVAL      KF@TRS = CATRST
022400110803     C                   EVAL      KF@SUB = CASUB#
022500110803     C                   EVAL      KF@ACC = CAACCT
022600110803    ***
022700110803     C                   EXSR      $PLANLOAD
022800110803    ***
022900110803     C                   EVAL      D1 = @DATE
023000110803     C                   EVAL      D2 = @DATE
023100110803     C                   EVAL      T1 = @TIME
023200110803     C                   EVAL      C1 = @DATE + @TIME
023300110803    ***
023400110803     C                   EVAL      H@SI = %TRIM(CACID1)                         SUBMITTER ID
023500110803     C                   EVAL      H@CC = %SUBST(CACID2:1:2)                    COMPANY CODE
023600110803     C                   MOVEL(P)  CACID3        H@GN                           HMO GROUP #
023700110803     C                   MOVEL(P)  CACID4        H@CN                           CUSTOMER NAME
023800110803     C                   MOVEL(P)  CACID5        H@C#                           CUSTOMER #
023900110803    ***
024000110803     C                   EXCEPT    HDRF
024100110803    ***
024200110803     C                   EVAL      @STEP = 'STEP1'
024300110803    ***
024400110803     C                   ENDSR
024500110803   S***S
024600110803     C     $STEP1        BEGSR
024700110803    ***
024800110803     C                   EVAL      KF@PLN = *BLANKS
024900110803     C                   EVAL      KF@TRM = 0
025000110803     C                   EVAL      KF@SSN = 0
025100110803     C                   EVAL      KF@SEQ = 0
025200110803    ***
025300110803     C     KL#TSA        SETLL     MEMBR
025400110803    ***
025500110803     C                   EVAL      @STEP = 'STEP2'
025600110803    ***
025700110803     C                   ENDSR
025800110803   S***S
025900110803     C     $STEP2        BEGSR
026000110803    ***
026100110803     C     KL#TSA        READE     MEMBR
026200110803    ***
026300110803     C                   IF        %EOF(MEMAC#1)
026400110803     C                   EVAL      @STEP = 'PREP1'
026500110803     C                   LEAVESR
026600110803     C                   ENDIF
026700110803    ***
026800110803     C                   EVAL      KF@SSN = MBSSNO
026900110803     C                   MOVE      *ZEROS        KF@SEQ
027000110803    ***
027100110803    *** SET COST CENTER IF USED FROM THE MEMBER VALUE
027200110803    ***
027300110803     C                   EVAL      KF@CCTR = CCFLG
027400110803    ***
027500110803     C     KL#MPLN       SETLL     MCOVR
027600110803    ***
027700110803     C                   EXSR      $CLRSTG
027800110803    ***
027900110803     C                   EVAL      @STEP = 'STEP3'
028000110803    ***
028100110803     C                   ENDSR
028200110803   S***S
028300110803     C     $STEP3        BEGSR
028400110803    ***
028500110803     C     KL#MPLN       READE     MCOVR
028600110803    ***
028700110803     C                   IF        %EOF(MCOVMPLN)
028800110803     C                   EVAL      @STEP = 'PREP4'
028900110803     C                   LEAVESR
029000110803     C                   ENDIF
029100110803    ***
029200110803     C                   EVAL      @PLANIN = MCPLAN
029300120921     C                   EVAL      ENR@IN = MCOVTP
029400120123    ***
029500120123     C                   EXSR      $QUIK
029600120123    ***
029700110803     C                   EXSR      $PLANSRCH
029800110803    ***
029900110803     C                   IF        PLN@CAT = *BLANKS
030000110803     C                   LEAVESR
030100110803     C                   ENDIF
030200110803    ***
030300110803     C                   IF        CANDT = 0
030400110803     C                   EVAL      #CANCEL = 99999999
030500110803     C                   ELSE
030600110803     C                   EVAL      #CANCEL = CANDT
030700110803     C                   ENDIF
030800110803    ***
030900110803    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL
031000110803    ***
031100110803    *C                   IF        PLN@CAT = 'DEN'
031200130130    *C                   IF        D#CNE > 0
031300130130    *C                   IF        D@TRM(D#CNE) = 99999999
031400130130     C                   LEAVESR
031500130130     C                   ENDIF
031600130130     C                   ENDIF
031700110803    *C                   ADD       1             D#CNE
031800110803    *C                   EVAL      D@PLN(D#CNE) = MCPLAN
031900110803    *C                   EVAL      D@ENR(D#CNE) = MCOVTP
032000110803    *C                   EVAL      D@FRM(D#CNE) = ENRLDT
032100110803    *C                   EVAL      D@TRM(D#CNE) = #CANCEL
032200110803    *C                   ELSE
032300130130    *C                   IF        M#CNE > 0
032400130130    *C                   IF        M@TRM(M#CNE) = 99999999
032500130130     C                   LEAVESR
032600130130     C                   ENDIF
032700130130     C                   ENDIF
032800110803     C                   ADD       1             M#CNE
032900110803     C                   EVAL      M@PLN(M#CNE) = MCPLAN
033000110803     C                   EVAL      M@ENR(M#CNE) = MCOVTP
033100110803     C                   EVAL      M@FRM(M#CNE) = ENRLDT
033200110803     C                   EVAL      M@TRM(M#CNE) = #CANCEL
033300110803    *C                   ENDIF
033400110803    ***
033500110803     C                   ENDSR
033600110803   S***S
033700120123     C     $QUIK         BEGSR
033800120123    ***
033900120123     C*  ***PLANS***
034000120123     C                   IF        @PLANIN = '....'
034100120123     C                   EVAL      @CCTRIN = STATE
034200120123     C                   ELSE
034300120123     C                   EVAL      @CCTRIN = *BLANKS
034400120123     C                   ENDIF
034500120123     C*  ***PLANS***
034600120123    ***
034700120123     C                   ENDSR
034800120123   S***S
034900110803     C     $PREP4        BEGSR
035000110803    ***
035100110803     C                   IF        D#CNE = 0 AND M#CNE = 0
035200110803     C                   EVAL      @STEP = 'STEP2'
035300110803     C                   LEAVESR
035400110803     C                   ENDIF
035500110803    ***
035600110803     C                   EVAL      TERM_DEN = NO
035700110803     C                   EVAL      TERM_MED = NO
035800110803    ***
035900110803     C                   IF        M#CNE > 0 AND D#CNE > 0
036000110803    *C*
036100110803     C                   IF        (D@TRM(D#CNE) = 99999999 AND
036200110803     C                              M@TRM(M#CNE) = 99999999)
036300110803     C                   EVAL      @STEP = 'STEP4'
036400110803     C                   LEAVESR
036500110803     C                   ELSE
036600110803     C                   EXSR      $CHKHEM
036700110803     C                   ENDIF
036800110803    *C*
036900110803     C                   ENDIF
037000110803    ***
037100110803     C                   IF        M#CNE > 0 AND D#CNE = 0
037200110803    *C*
037300110803     C                   IF        M@TRM(M#CNE) = 99999999
037400110803     C                   EVAL      @STEP = 'STEP4'
037500110803     C                   LEAVESR
037600110803     C                   ELSE
037700110803     C                   EXSR      $CHKHEM
037800110803     C                   ENDIF
037900110803    *C*
038000110803     C                   ENDIF
038100110803    ***
038200110803     C                   IF        M#CNE = 0 AND D#CNE > 0
038300110803    *C*
038400110803     C                   IF        D@TRM(D#CNE) = 99999999
038500110803     C                   EVAL      @STEP = 'STEP4'
038600110803     C                   LEAVESR
038700110803     C                   ELSE
038800110803     C                   EXSR      $CHKHEM
038900110803     C                   ENDIF
039000110803    *C*
039100110803     C                   ENDIF
039200110803    ***
039300110803     C                   EVAL      @STEP = 'STEP4'
039400110803    ***
039500110803     C                   ENDSR
039600110803   S***S
039700110803    *** GENERATE MEMBER RECORD
039800110803    ***
039900110803     C     $STEP4        BEGSR
040000110803    ***
040100110803     C                   IF        D#CNE = 0 AND M#CNE = 0
040200110803     C                   EVAL      @STEP = 'STEP2'
040300110803     C                   LEAVESR
040400110803     C                   ENDIF
040500110803    ***
040600110803     C                   EVAL      WRT@TYPE = 'MEMBER'
040700110803    ***
040800110803     C                   EVAL      D@MBREFF = 0
040900110803     C                   EVAL      M@MBREFF = 0
041000110803    ***
041100110803     C                   EVAL      @SS1   = %EDITC(MBSSNO:'X')
041200110803     C                   EVAL      @SS2   = @SS1
041300110803     C                   MOVEL(P)  MLNAME        @LN
041400110803     C                   MOVEL(P)  MFNAME        @FN
041500110803     C                   EVAL      @MI    = MMI
041600110803     C                   EVAL      @REL   = '01'
041700110803     C                   EVAL      @SEX   = SEX
041800110803     C                   EVAL      @DOB   = %EDITC(BIRTH:'X')
041900110803     C                   IF        COB = 'Y'
042000110803     C                   EVAL      @COB   = 'Y'
042100110803     C                   EVAL      @COBC  = 'OT'
042200110803     C                   EVAL      @COBN  = MCOBPN
042300110803     C                   ENDIF
042400110803     C                   EVAL      @AD1   = %TRIM(ADDR1)
042500110803     C                   EVAL      @AD2   = %TRIM(ADDR2)
042600110803     C                   EVAL      @CTY   = %TRIM(CITY)
042700110803     C                   EVAL      @ST    = STATE
042800110803     C                   MOVE      *BLANKS       @9                9
042900110803     C                   EVAL      @9   = %EDITC(ZIP:'X')
043000110803     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
043100110803     C                   EVAL      @PHN   = %EDITC(AREA:'X') +
043200110803     C                                      %EDITC(PHONE:'X')
043300110803    ***
043400110803     C                   SELECT
043500110803     C                   WHEN      EMPST = 'A'
043600110803     C                   EVAL      @EMPST = 'AC'
043700110803     C                   WHEN      EMPST = 'C'
043800110803     C                   EVAL      @EMPST = 'CO'
043900110803     C                   WHEN      EMPST = 'R'
044000110803     C                   EVAL      @EMPST = 'RT'
044100110803     C                   ENDSL
044200110803    ***
044300110803     C                   EVAL      @HIRE  = %EDITC(EMPDT:'X')
044400110803    ***
044500110803     C                   EXCEPT    MBRF
044600110803     C                   ADD       1             C#RECCNT
044700110803    ***
044800110803     C                   EVAL      @STEP = 'PREP5'
044900110803    ***
045000110803     C                   ENDSR
045100110803   S***S
045200110803     C     $PREP5        BEGSR
045300110803    ***
045400110803     C                   IF        M#CNE = 0
045500110803     C                   EVAL      @STEP = 'PREP6'
045600110803     C                   LEAVESR
045700110803     C                   ENDIF
045800110803    ***
045900110803     C                   EVAL      KF@PLN = M@PLN(M#CNE)
046000130624     C                   EVAL      KF@ENR = M@ENR(M#CNE)
046100110803    ***
046200110803     C                   IF        TERM_MED = YES
046300110803     C                   EXSR      $WRTERM
046400110803     C                   ENDIF
046500110803    ***
046600110803    ***
046700110803    *** IF COST CENTER IS USED, CODE HERE, OR JUST SET IT TO BLANKS
046800110803    ***
046900130624     C                   EVAL      @PLANIN = M@PLN(M#CNE)
047000130624     C                   EVAL      ENR@IN  = M@ENR(M#CNE)
047100120123    ***
047200120123     C                   EXSR      $QUIK
047300120123    ***
047400110803     C                   EXSR      $PLANSRCH
047500110803    ***
047600110803     C                   IF        PLN@CAT = *BLANKS
047700110803     C                   SETON                                        H1
047800110803     C                   ENDIF
047900110803    ***
048000110803     C                   EVAL      @STEP = 'STEP5'
048100110803     C                   EVAL      #XSX = M@FRM(M#CNE)
048200110803     C                   EVAL      M@MBREFF = #XSX
048300110803    ***
048400110803     C                   ENDSR
048500110803   S***S
048600110803     C     $STEP5        BEGSR
048700110803    ***
048800110803     C                   IF        CPCID1 = 'MEA'
048900110803     C                   EXSR      $MEAWRT
049000110803     C                   ELSE
049100110803     C                   EXSR      $HMOWRT
049200110803     C                   ENDIF
049300110803    ***
049400110803     C                   ADD       1             C#RECCNT
049500110803     C                   ADD       1             B#RECCNT
049600110803    ***
049700110803     C                   EVAL      @STEP = 'PREP6'
049800110803    ***
049900110803     C                   ENDSR
050000110803   S***S
050100110803     C     $PREP6        BEGSR
050200110803    ***
050300110803    *C                   IF        D#CNE = 0
050400110803    *C                   EVAL      @STEP = 'PREP7'
050500110803    *C                   LEAVESR
050600110803    *C                   ENDIF
050700110803    ***
050800110803    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
050900130624     C                   EVAL      KF@ENR = D@ENR(D#CNE)
051000110803    ***
051100110803    *C                   IF        TERM_DEN = YES
051200110803    *C                   EXSR      $WRTERM
051300110803    *C                   ENDIF
051400110803    ***
051500130624     C                   EVAL      @PLANIN = D@PLN(D#CNE)
051600130624     C                   EVAL      ENR@IN  = D@ENR(D#CNE)
051700120123    ***
051800120123     C                   EXSR      $QUIK
051900110803    ***
052000110803     C                   EXSR      $PLANSRCH
052100110803    ***
052200110803     C                   IF        PLN@CAT = *BLANKS
052300110803     C                   SETON                                        H2
052400110803     C                   ENDIF
052500110803    ***
052600110803    *C                   EVAL      @STEP = 'STEP6'
052700110803     C                   EVAL      #XSX = D@FRM(D#CNE)
052800110803     C                   EVAL      D@MBREFF = #XSX
052900110803    ***
053000110803     C                   ENDSR
053100110803   S***S
053200110803    *** DENTAL FORMAT
053300110803    ***
053400110803    *C     $STEP6        BEGSR
053500110803    ***
053600110803     C                   EXSR      $DENWRT
053700110803    ***
053800110803    *C                   ADD       1             C#RECCNT
053900110803    *C                   ADD       1             B#RECCNT
054000110803    ***
054100110803    *C                   EVAL      @STEP = 'PREP7'
054200110803    ***
054300110803    *C                   ENDSR
054400110803   S***S
054500110803     C     $PREP7        BEGSR
054600110803    ***
054700110803     C     KF@SSN        CHAIN     DEPENR
054800110803     C                   IF        NOT %FOUND(DEPNDC)
054900110803     C                   EVAL      @STEP = 'STEP2'
055000110803     C                   LEAVESR
055100110803     C                   ENDIF
055200110803    ***
055300110803     C     KF@SSN        SETLL     DEPENR
055400110803    ***
055500110803     C                   EVAL      @STEP = 'STEP7'
055600110803    ***
055700110803     C                   ENDSR
055800110803   S***S
055900110803     C     $STEP7        BEGSR
056000110803    ***
056100110803     C     KF@SSN        READE     DEPENR
056200110803    ***
056300110803     C                   IF        %EOF(DEPNDC)
056400110803     C                   EVAL      @STEP = 'STEP2'
056500110803     C                   LEAVESR
056600110803     C                   ENDIF
056700110803    ***
056800110803     C                   EVAL      KF@SEQ = DPSEQ#
056900110803    ***
057000110803     C     KL#DCV        CHAIN     DCOVR
057100110803     C                   IF        NOT %FOUND(DCOVA)
057200110803     C                   LEAVESR
057300110803     C                   ENDIF
057400110803    ***
057500110803     C                   EXSR      $CLRDCV
057600110803     C     KL#DCV        SETLL     DCOVR
057700110803    ***
057800110803     C                   EVAL      @STEP = 'STEP8'
057900110803    ***
058000110803     C                   ENDSR
058100110803   S***S
058200110803     C     $STEP8        BEGSR
058300110803    ***
058400110803     C     KL#DCV        READE     DCOVR
058500110803    ***
058600110803     C                   IF        %EOF(DCOVA)
058700110803     C                   EVAL      @STEP = 'PREP9'
058800110803     C                   LEAVESR
058900110803     C                   ENDIF
059000110803    ***
059100110803     C                   EVAL      @PLANIN = DVPLAN
059200120123    ***
059300120123     C                   EXSR      $QUIK
059400120123    ***
059500110803     C                   EXSR      $PLANSRCH
059600110803    ***
059700110803     C                   IF        PLN@CAT = *BLANKS
059800110803     C                   LEAVESR
059900110803     C                   ENDIF
060000110803    ***
060100110803     C                   EVAL      #CANCEL = CCANDT
060200110803     C                   IF        #CANCEL = 0
060300110803     C                   EVAL      #CANCEL = 99999999
060400110803     C                   ENDIF
060500110803    ***
060600110803    *** DEN IS DENTAL; MEA & HMO IS CONSIDERED MEDICAL
060700110803    ***
060800110803    *C                   IF        PLN@CAT = 'DEN'
060900130130    *C                   IF        D#CNE > 0
061000130130    *C                   IF        D@TRM(D#CNE) = 99999999
061100130130     C                   LEAVESR
061200130130     C                   ENDIF
061300130130     C                   ENDIF
061400110803    *C                   ADD       1             D#CNE
061500110803    *C                   EVAL      D@PLN(D#CNE) = DVPLAN
061600110803    *C                   EVAL      D@ENR(D#CNE) = *BLANKS
061700110803    *C                   EVAL      D@FRM(D#CNE) = DENRDT
061800110803    *C                   EVAL      D@TRM(D#CNE) = #CANCEL
061900110803    *C                   ELSE
062000130130    *C                   IF        M#CNE > 0
062100130130    *C                   IF        M@TRM(M#CNE) = 99999999
062200130130     C                   LEAVESR
062300130130     C                   ENDIF
062400130130     C                   ENDIF
062500110803     C                   ADD       1             M#CNE
062600110803     C                   EVAL      M@PLN(M#CNE) = DVPLAN
062700110803     C                   EVAL      M@ENR(M#CNE) = *BLANKS
062800110803     C                   EVAL      M@FRM(M#CNE) = DENRDT
062900110803     C                   EVAL      M@TRM(M#CNE) = #CANCEL
063000110803    *C                   ENDIF
063100110803    ***
063200110803     C                   ENDSR
063300110803   S***S
063400110803     C     $PREP9        BEGSR
063500110803    ***
063600110803     C                   IF        D#CNE = 0 AND M#CNE = 0
063700110803     C                   EVAL      @STEP = 'STEP7'
063800110803     C                   LEAVESR
063900110803     C                   ENDIF
064000110803    ***
064100110803     C                   EVAL      TERM_DEN = NO
064200110803     C                   EVAL      TERM_MED = NO
064300110803    ***
064400110803     C                   IF        M#CNE > 0 AND D#CNE > 0
064500110803    *C*
064600110803     C                   IF        (D@TRM(D#CNE) = 99999999 AND
064700110803     C                              M@TRM(M#CNE) = 99999999)
064800110803     C                   EVAL      @STEP = 'STEP9'
064900110803     C                   LEAVESR
065000110803     C                   ELSE
065100110803     C                   EXSR      $CHKHEM
065200110803     C                   ENDIF
065300110803    *C*
065400110803     C                   ENDIF
065500110803    ***
065600110803     C                   IF        M#CNE > 0 AND D#CNE = 0
065700110803    *C*
065800110803     C                   IF        M@TRM(M#CNE) = 99999999
065900110803     C                   EVAL      @STEP = 'STEP9'
066000110803     C                   LEAVESR
066100110803     C                   ELSE
066200110803     C                   EXSR      $CHKHEM
066300110803     C                   ENDIF
066400110803    *C*
066500110803     C                   ENDIF
066600110803    ***
066700110803     C                   IF        M#CNE = 0 AND D#CNE > 0
066800110803    *C*
066900110803     C                   IF        D@TRM(D#CNE) = 99999999
067000110803     C                   EVAL      @STEP = 'STEP9'
067100110803     C                   LEAVESR
067200110803     C                   ELSE
067300110803     C                   EXSR      $CHKHEM
067400110803     C                   ENDIF
067500110803    *C*
067600110803     C                   ENDIF
067700110803    ***
067800110803     C                   IF        D#CNE = 0 AND M#CNE = 0
067900110803     C                   EVAL      @STEP = 'STEP7'
068000110803     C                   LEAVESR
068100110803     C                   ENDIF
068200110803    ***
068300110803     C                   EVAL      @STEP = 'STEP9'
068400110803    ***
068500110803     C                   ENDSR
068600110803   S***S
068700110803    *** GENERATE DEPENDENT RECORD
068800110803    ***
068900110803     C     $STEP9        BEGSR
069000110803    ***
069100110803     C                   EVAL      WRT@TYPE = 'DEPEND'
069200110803    ***
069300110803     C                   IF        D#CNE = 0 AND M#CNE = 0
069400110803     C                   EVAL      @STEP = 'STEP7'
069500110803     C                   LEAVESR
069600110803     C                   ENDIF
069700110803    ***
069800110803     C                   EVAL      @SS2   = %EDITC(DEPSS#:'X')
069900110803     C                   MOVEL(P)  DLNAME        @LN
070000110803     C                   MOVEL(P)  DFNAME        @FN
070100110803     C                   EVAL      @MI    = DMI
070200110803    ***
070300110803     C                   SELECT
070400110803     C                   WHEN      DRELCD = 'RWI'
070500110803     C                   EVAL      @REL   = '02'
070600110803     C                   WHEN      DRELCD = 'RHU'
070700110803     C                   EVAL      @REL   = '03'
070800110803     C                   WHEN      DRELCD = 'RSO'
070900110803     C                   EVAL      @REL   = '04'
071000110803     C                   WHEN      DRELCD = 'RDA'
071100110803     C                   EVAL      @REL   = '05'
071200110803     C                   ENDSL
071300110803    ***
071400110803     C                   SELECT
071500110803     C                   WHEN      DSTUDN = 'Y'
071600110803     C                   EVAL      @SPEC = '1'
071700140812     C                   WHEN      DHNDCP = '3'
071800110803     C                   EVAL      @SPEC = '3'
071900110803     C                   ENDSL
072000110803    ***
072100110803     C                   EVAL      @SEX   = DSEX
072200110803     C                   EVAL      @DOB   = %EDITC(DBIRTH:'X')
072300110803     C                   IF        DCOB = 'Y'
072400110803     C                   EVAL      @COB   = 'Y'
072500110803     C                   EVAL      @COBC  = 'OT'
072600110803     C                   EVAL      @COBN  = DCOBPN
072700110803     C                   ENDIF
072800110803    ***
072900110803     C                   IF        DADDR1 <> ADDR1
073000110803     C                   EVAL      @AD1   = %TRIM(DADDR1)
073100110803     C                   EVAL      @AD2   = %TRIM(DADDR2)
073200110803     C                   EVAL      @CTY   = %TRIM(DCITY)
073300110803     C                   EVAL      @ST    = DSTATE
073400110803     C                   MOVE      *BLANKS       @9                9
073500110803     C                   IF        DZIP = 0
073600110803     C                   EVAL      @9   = %EDITC(ZIP:'X')
073700110803     C                   ELSE
073800110803     C                   EVAL      @9   = %EDITC(DZIP:'X')
073900110803     C                   ENDIF
074000110803     C                   EVAL      @ZP5 = %SUBST(@9:1:5)
074100110803     C                   EVAL      @PHN   = %EDITC(DAREA:'X') +
074200110803     C                                      %EDITC(DPHONE:'X')
074300110803     C                   ENDIF
074400110803    ***
074500110803     C                   EXCEPT    MBRF
074600110803     C                   ADD       1             C#RECCNT
074700110803    ***
074800110803     C                   EVAL      @STEP = 'PREPA'
074900110803    ***
075000110803     C                   ENDSR
075100110803   S***S
075200110803     C     $PREPA        BEGSR
075300110803    ***
075400110803     C                   IF        M#CNE = 0
075500110803     C                   EVAL      @STEP = 'PREPB'
075600110803     C                   LEAVESR
075700110803     C                   ENDIF
075800110803    ***
075900110803     C                   EVAL      KF@PLN = M@PLN(M#CNE)
076000130624     C                   EVAL      KF@ENR = *BLANKS
076100110803    ***
076200110803     C                   IF        TERM_MED = YES
076300110803     C                   EXSR      $WRTERM
076400110803     C                   ENDIF
076500110803    ***
076600110803    ***
076700110803    *** IF COST CENTER IS USED, CODE HERE, OR JUST SET IT TO BLANKS
076800110803    ***
076900130624     C                   EVAL      @PLANIN = M@PLN(M#CNE)
077000130624     C                   EVAL      ENR@IN  = 'TFA'
077100120123    ***
077200120123     C                   EXSR      $QUIK
077300120123    ***
077400110803     C                   EXSR      $PLANSRCH
077500110803    ***
077600110803     C                   IF        PLN@CAT = *BLANKS
077700110803     C                   SETON                                        H2
077800110803     C                   ENDIF
077900110803    ***
078000110803     C                   EVAL      @STEP = 'STEPA'
078100110803    ***
078200110803     C                   ENDSR
078300110803   S***S
078400110803     C     $STEPA        BEGSR
078500110803    ***
078600110803     C                   IF        CPCID1 = 'MEA'
078700110803     C                   EXSR      $MEAWRT
078800110803     C                   ELSE
078900110803     C                   EXSR      $HMOWRT
079000110803     C                   ENDIF
079100110803    ***
079200110803     C                   ADD       1             C#RECCNT
079300110803     C                   ADD       1             B#RECCNT
079400110803    ***
079500110803     C                   EVAL      @STEP = 'PREPB'
079600110803    ***
079700110803     C                   ENDSR
079800110803   S***S
079900110803     C     $PREPB        BEGSR
080000110803    ***
080100110803    *C                   IF        D#CNE = 0
080200110803    *C                   EVAL      @STEP = 'STEP7'
080300110803    *C                   LEAVESR
080400110803    *C                   ENDIF
080500110803    ***
080600110803    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
080700130624     C                   EVAL      KF@ENR = *BLANKS
080800110803    ***
080900110803    *C                   IF        TERM_DEN = YES
081000110803    *C                   EXSR      $WRTERM
081100110803    *C                   ENDIF
081200110803    ***
081300130624     C                   EVAL      @PLANIN = D@PLN(D#CNE)
081400130624     C                   EVAL      ENR@IN  = 'TFA'
081500120123    ***
081600120123     C                   EXSR      $QUIK
081700120123    ***
081800110803     C                   EXSR      $PLANSRCH
081900110803    ***
082000110803     C                   IF        PLN@CAT = *BLANKS
082100110803     C                   SETON                                        H2
082200110803     C                   ENDIF
082300110803    ***
082400110803     C                   EVAL      @STEP = 'STEPB'
082500110803    ***
082600110803     C                   ENDSR
082700110803   S***S
082800110803    *C     $STEPB        BEGSR
082900110803    ***
083000110803     C                   EXSR      $DENWRT
083100110803    ***
083200110803    *C                   ADD       1             C#RECCNT
083300110803    *C                   ADD       1             B#RECCNT
083400110803    ***
083500110803    *C                   EVAL      @STEP = 'STEP7'
083600110803    ***
083700110803    *C                   ENDSR
083800110803   S***S
083900110803     C     *INZSR        BEGSR
084000110803    ***
084100110803     C     KL#ACCTL      KLIST
084200110803     C                   KFLD                    CARR#CTL
084300110803     C                   KFLD                    KF@TRS
084400110803     C                   KFLD                    KF@SUB
084500110803     C                   KFLD                    KF@ACC
084600110803    ***
084700110803     C     KL#TSA        KLIST
084800110803     C                   KFLD                    KF@TRS
084900110803     C                   KFLD                    KF@SUB
085000110803     C                   KFLD                    KF@ACC
085100110803    ***
085200110803     C     KL#MPLN       KLIST
085300110803     C                   KFLD                    KF@SSN
085400110803     C                   KFLD                    KF@SEQ
085500110803     C                   KFLD                    KF@TRS
085600110803     C                   KFLD                    KF@SUB
085700110803     C                   KFLD                    KF@ACC
085800110803    ***
085900110803     C     KL#CPLN       KLIST
086000110803     C                   KFLD                    CARR#CTL
086100110803     C                   KFLD                    KF@TRS
086200110803     C                   KFLD                    KF@SUB
086300110803     C                   KFLD                    KF@ACC
086400110803     C                   KFLD                    KF@CCTR
086500110803     C                   KFLD                    KF@PLN
086600110803    ***
086700110803     C     KL#DCV        KLIST
086800110803     C                   KFLD                    KF@SSN
086900110803     C                   KFLD                    KF@SEQ
087000110803    ***
087100110803     C     KL#MTR        KLIST
087200110803     C                   KFLD                    KF@SSN
087300110803     C                   KFLD                    KF@SEQ
087400110803     C                   KFLD                    KF#TRM
087500110803     C                   KFLD                    KF@PLN
087600110803     C                   KFLD                    KF@ENR
087700110803     C                   KFLD                    KF@TRS
087800110803     C                   KFLD                    KF@SUB
087900110803     C                   KFLD                    KF@ACC
088000110803    ***
088100110803     C     KL#PCP        KLIST
088200110803     C                   KFLD                    KF@SSN
088300110803     C                   KFLD                    KF@SEQ
088400110803    ***
088500110803     C                   EVAL      #ISO = %DATE
088600110803     C                   MOVE      #ISO          #TODAY            8 0
088700110803     C                   EVAL      #IST = %TIME
088800110803     C                   MOVE      #ISO          #XSX
088900110803     C                   MOVE      #XSX          @DATE
089000110803     C                   MOVE      #IST          #XST
089100110803     C                   MOVE      #XST          @TIME
089200110803    ***
089300110803     C                   ENDSR
089400110803   S***S
089500110803    *** PLANS LOADED BY ACCOUNT
089600110803    ***
089700110803     C     $PLANLOAD     BEGSR
089800110803    ***
089900110803     C                   EVAL      PP# = 0
090000110803     C                   DO        50
090100110803     C                   ADD       1             PP#
090200110803     C     PP#           OCCUR     CARPLN@
090300110803     C                   CLEAR                   CARPLN@
090400110803     C                   ENDDO
090500110803     C                   EVAL      PC# = 0
090600110803     C                   EVAL      PP# = 0
090700110803    ***
090800110803     C     KL#ACCTL      SETLL     CARPLNR
090900110803     C                   DOU       %EOF(CARPLNP)
091000110803     C     KL#ACCTL      READE     CARPLNR
091100110803     C                   IF        NOT %EOF(CARPLNP)
091200110803    ***
091300110803     C                   ADD       1             PC#
091400110803     C     PC#           OCCUR     CARPLN@
091500110803     C                   EVAL      CARPLN@ = DS@CARPLN
091600110803    ***
091700110803     C                   ENDIF
091800110803     C                   ENDDO
091900110803    ***
092000110803     C                   ENDSR
092100110803   S***S
092200110803     C     $CLRSTG       BEGSR
092300110803    ***
092400110803     C                   EVAL      #CANCEL = 0
092500110803     C                   EVAL      D#CNE = 0
092600110803     C                   CLEAR                   D@PLN
092700110803     C                   CLEAR                   D@ENR
092800110803     C                   CLEAR                   D@FRM
092900110803     C                   CLEAR                   D@TRM
093000110803     C                   EVAL      M#CNE = 0
093100110803     C                   CLEAR                   M@PLN
093200110803     C                   CLEAR                   M@ENR
093300110803     C                   CLEAR                   M@FRM
093400110803     C                   CLEAR                   M@TRM
093500110803    ***
093600110803     C                   EXSR      $CLRDMG
093700110803    ***
093800110803     C                   ENDSR
093900110803   S***S
094000110803     C     $CLRDMG       BEGSR
094100110803    ***
094200110803     C                   EVAL      @SS1   = *BLANKS
094300110803     C                   EVAL      @SS2   = *BLANKS
094400110803     C                   MOVE      *BLANKS       @LN
094500110803     C                   MOVEL     *BLANKS       @FN
094600110803     C                   EVAL      @MI    = *BLANKS
094700110803     C                   EVAL      @REL   = *BLANKS
094800110803     C                   EVAL      @SEX   = *BLANKS
094900110803     C                   EVAL      @DOB   = *BLANKS
095000110803     C                   EVAL      @SPEC  = *BLANKS
095100110803     C                   EVAL      @COB   = *BLANKS
095200110803     C                   EVAL      @COBC  = *BLANKS
095300110803     C                   EVAL      @COBN  = *BLANKS
095400110803     C                   EVAL      @AD1   = *BLANKS
095500110803     C                   EVAL      @AD2   = *BLANKS
095600110803     C                   EVAL      @CTY   = *BLANKS
095700110803     C                   EVAL      @ST    = *BLANKS
095800110803     C                   EVAL      @ZP5   = *BLANKS
095900110803     C                   EVAL      @PHN   = *BLANKS
096000110803     C                   EVAL      @EMPST = *BLANKS
096100110803     C                   EVAL      @HIRE  = *BLANKS
096200110803    ***
096300110803     C                   ENDSR
096400110803   S***S
096500110803     C     $CHKHEM       BEGSR
096600110803    ***
096700110803    *C                   IF        D#CNE > 0 AND D@TRM(D#CNE) <> 99999999
096800110803    *C                   EXSR      $CHKDEN
096900110803    *C                   ENDIF
097000110803      *
097100110803     C                   IF        M#CNE > 0 AND M@TRM(M#CNE) <> 99999999
097200110803     C                   EXSR      $CHKMED
097300110803     C                   ENDIF
097400110803    ***
097500110803     C                   ENDSR
097600110803   S***S
097700110803    *C     $CHKDEN       BEGSR
097800110803    ***
097900110803    *C                   EVAL      TERM_DEN = YES
098000110803    *C                   EVAL      KF#TRM = D@TRM(D#CNE)
098100110803    *C                   EVAL      KF@PLN = D@PLN(D#CNE)
098200110803    *C                   EVAL      KF@ENR = D@ENR(D#CNE)
098300110803    ***
098400110803    *C     KL#MTR        CHAIN     AET001F
098500110803    *C                   IF        %FOUND(AET001WF)
098600110803    *C                   EVAL      D#CNE = 0
098700110803    *C                   EVAL      TERM_DEN = NO
098800110803    *C                   ENDIF
098900110803    ***
099000110803    *C                   ENDSR
099100110803   S***S
099200110803     C     $CHKMED       BEGSR
099300110803    ***
099400110803     C                   EVAL      TERM_MED = YES
099500110803     C                   EVAL      KF#TRM = M@TRM(M#CNE)
099600110803     C                   EVAL      KF@PLN = M@PLN(M#CNE)
099700110803     C                   EVAL      KF@ENR = M@ENR(M#CNE)
099800110803      *
099900110803     C     KL#MTR        CHAIN     AET001F
100000110803     C                   IF        %FOUND(AET001WF)
100100110803     C                   EVAL      TERM_MED = NO
100200110803     C                   EVAL      M#CNE = 0
100300110803     C                   ENDIF
100400110803    ***
100500110803     C                   ENDSR
100600110803   S***S
100700110803     C     $PLANSRCH     BEGSR
100800110803    ***
100900110803     C                   MOVE      *BLANKS       PLN@CAT           3
101000110803     C                   EVAL      PP# = 0
101100110803     C                   CLEAR                   DS@CARPLN
101200110803    ***
101300110803     C                   DO        PC#
101400110803    * *
101500110803     C                   ADD       1             PP#
101600110803     C     PP#           OCCUR     CARPLN@
101700110803    * *
101800110803     C                   IF        XPPLAN = @PLANIN AND
101900110803     C                             XPCCTR = @CCTRIN
102000110803     C                   EVAL      DS@CARPLN = CARPLN@
102100110803     C                   LEAVE
102200110803     C                   ENDIF
102300110803    * *
102400110803     C                   ENDDO
102500110803    ***
102600110803     C                   IF        CPPLAN = *BLANKS
102700110803     C                   LEAVESR
102800110803     C                   ENDIF
102900110803    ***
103000110803     C                   SELECT
103100110803     C                   WHEN      CPCID1 = 'MEA' OR
103200110803     C                             CPCID1 = 'HMO'
103300110803     C                   EVAL      PLN@CAT = 'MED'
103400110803     C                   WHEN      CPCID1 = 'DEN'
103500110803     C                   EVAL      PLN@CAT = 'DEN'
103600110803     C                   ENDSL
103700110803    ***
103800110803     C                   ENDSR
103900110803   S***S
104000110803     C     $ENROLL       BEGSR
104100110803    ***
104200110803     C                   EVAL      ENR@OUT = *BLANKS
104300110803     C                   SELECT
104400110803     C                   WHEN      ENR@IN = 'TIN' OR ENR@IN = 'TMI'
104500110803     C                   EVAL      ENR@OUT = 'S'
104600110803     C                   WHEN      ENR@IN = 'THW'
104700110803     C                   EVAL      ENR@OUT = 'C'
104800110803     C                   WHEN      ENR@IN = 'TPC'
104900110803     C                   EVAL      ENR@OUT = 'P'
105000110803     C                   WHEN      ENR@IN = 'TP2'
105100110803     C                   EVAL      ENR@OUT = 'Q'
105200110803     C                   WHEN      ENR@IN = 'TFA'
105300110803     C                   EVAL      ENR@OUT = 'F'
105400110803     C                   ENDSL
105500110803    ***
105600110803     C                   ENDSR
105700110803   S***S
105800110803     C     $WRTERM       BEGSR
105900110803    ***
106000110803     C                   CLEAR                   AET001F
106100110803     C                   EVAL      NTSSNO         = KF@SSN
106200110803     C                   EVAL      NTDEPNO        = KF@SEQ
106300110803     C                   EVAL      NTTERMDT       = KF#TRM
106400110803     C                   EVAL      NTPLAN         = KF@PLN
106500110803     C                   EVAL      NTCOVTP        = KF@ENR
106600110803     C                   EVAL      NTTRST         = KF@TRS
106700110803     C                   EVAL      NTSUB#         = KF@SUB
106800110803     C                   EVAL      NTACCT         = KF@ACC
106900110803     C                   EVAL      NTTRANSDT      = #TODAY
107000110803     C                   WRITE     AET001F
107100110803    ***
107200110803     C                   ENDSR
107300110803   S***S
107400110803     C     $HMOWRT       BEGSR
107500110803    ***
107600110803     C                   EVAL      X@LAY = CPCID1                               LAYOUT
107700110803     C                   EVAL      X@ELR = CPCID2                               FILE NUMBER
107800110803     C                   EVAL      M@CC = CACID2                                COMPANY CODE
107900110803     C                   EVAL      M@CLASS = CPCID3                             CLASS CODE
108000110803     C                   EVAL      M@PLAN = CPCID4                              PLAN NUMBER
108100110803    ***
108200110803     C                   EVAL      #XSX = M@FRM(M#CNE)
108300110803     C                   IF        WRT@TYPE = 'DEPEND' AND
108400110803     C                             #XSX < M@MBREFF
108500110803     C                   MOVE      M@MBREFF      X@EFF
108600110803     C                   ELSE
108700110803     C                   MOVE      #XSX          X@EFF
108800110803     C                   ENDIF
108900110803    ***
109000110803     C                   EVAL      #XSX = M@TRM(M#CNE)
109100110803     C                   IF        #XSX = 0 OR #XSX = 99999999
109200110803     C                   MOVE      *BLANKS       X@TRM
109300110803     C                   ELSE
109400110803     C                   MOVE      #XSX          X@TRM
109500110803     C                   ENDIF
109600110803    ***
109700110803     C                   IF        WRT@TYPE = 'MEMBER'
109800110803     C                   EVAL      KF@SEQ = 0
109900110803     C                   EVAL      ENR@IN = M@ENR(M#CNE)
110000110803     C                   EXSR      $ENROLL
110100110803     C                   EVAL      X@TIER = ENR@OUT
110200110803     C                   ELSE
110300110803     C                   EVAL      X@TIER = *BLANKS
110400110803     C                   ENDIF
110500110803    ***
110600110803     C     KL#PCP        CHAIN     PCPR
110700110803     C                   IF        %FOUND(PCP)
110800110803     C                   MOVEL(P)  PCID#         M@PCP
110900110803     C                   EVAL      M@NPI = 'Y'
111000110803     C                   EVAL      M@PCPCI = '0'
111100110803     C                   ENDIF
111200110803    ***
111300110803     C                   EXCEPT    HMOF
111400110803    ***
111500110803     C                   ENDSR
111600110803   S***S
111700110803     C     $MEAWRT       BEGSR
111800110803    ***
111900110803     C                   EVAL      X@LAY = CPCID1                               LAYOUT
112000110803     C                   EVAL      X@ELR = CPCID2                               ELR
112100110803     C                   EVAL      D@SFX = CPCID3                               SUFFIX
112200110803     C                   EVAL      D@ACCT = CPCID4                              ACCOUNT
112300110803     C                   EVAL      D@PLAN = CPCID5                              PLAN
112400110803     C                   EVAL      D@CLM = CPCID6                               CLAIM OFFICE
112500110803     C                   EVAL      DNTLATE = *BLANKS
112600110803    ***
112700110803     C                   EVAL      #XSX = M@FRM(M#CNE)
112800110803     C                   IF        WRT@TYPE = 'DEPEND' AND
112900110803     C                             #XSX < M@MBREFF
113000110803     C                   MOVE      M@MBREFF      X@EFF
113100110803     C                   ELSE
113200110803     C                   MOVE      #XSX          X@EFF
113300110803     C                   ENDIF
113400110803    ***
113500110803     C                   EVAL      #XSX = M@TRM(M#CNE)
113600110803     C                   IF        #XSX = 0 OR #XSX = 99999999
113700110803     C                   MOVE      *BLANKS       X@TRM
113800110803     C                   ELSE
113900110803     C                   MOVE      #XSX          X@TRM
114000110803     C                   ENDIF
114100110803    ***
114200130423     C                   MOVE      *BLANKS       D@CBREXP
114300130423     C                   MOVE      *BLANKS       D@CBREVT
114400130423     C                   MOVE      *BLANKS       D@CBRLEN
114500110803     C                   IF        WRT@TYPE = 'MEMBER'
114600110803     C                   IF        EMPST = 'C'
114700110803     C                   MOVE      CEXPDT        D@CBREXP
114800110803     C                   MOVE      QEDT          D@CBREVT
114900110803     C                   MOVE      CEXPDT        #MINUEND
115000110803     C                   MOVE      QEDT          #SUBTRAEND
115100110803     C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
115200110803     C                   Z-ADD     #DIFFRNC      #2S0
115300110803     C                   MOVE      #2S0          D@CBRLEN
115400110803     C                   ENDIF
115500110803     C                   ENDIF
115600110803    ***
115700110803     C                   MOVE      *BLANKS       D@OOAI
115800110803    ***
115900110803     C                   EXCEPT    DENF
116000110803    ***
116100110803     C                   ENDSR
116200110803   S***S
116300110803     C     $CLRDCV       BEGSR
116400110803    ***
116500110803     C                   MOVE      *BLANKS       @LN
116600110803     C                   MOVEL     *BLANKS       @FN
116700110803     C                   EVAL      @SS2   = *BLANKS
116800110803     C                   EVAL      @MI    = *BLANKS
116900110803     C                   EVAL      @REL   = *BLANKS
117000110803     C                   EVAL      @SEX   = *BLANKS
117100110803     C                   EVAL      @DOB   = *BLANKS
117200110803     C                   EVAL      @SPEC  = *BLANKS
117300110803     C                   EVAL      @COB   = *BLANKS
117400110803     C                   EVAL      @COBC  = *BLANKS
117500110803     C                   EVAL      @COBN  = *BLANKS
117600110803    ***
117700110803     C                   EVAL      #CANCEL = 0
117800110803     C                   EVAL      D#CNE = 0
117900110803     C                   CLEAR                   D@PLN
118000110803     C                   CLEAR                   D@ENR
118100110803     C                   CLEAR                   D@FRM
118200110803     C                   CLEAR                   D@TRM
118300110803     C                   EVAL      M#CNE = 0
118400110803     C                   CLEAR                   M@PLN
118500110803     C                   CLEAR                   M@ENR
118600110803     C                   CLEAR                   M@FRM
118700110803     C                   CLEAR                   M@TRM
118800110803    ***
118900110803     C                   ENDSR
119000110803   S***S
119100110803     C     $DENWRT       BEGSR
119200110803    ***
119300110803    *C                   EVAL      X@LAY = CPCID1                               LAYOUT
119400110803    *C                   EVAL      X@ELR = CPCID2                               ELR
119500110803    *C                   EVAL      D@SFX = CPCID3                               SUFFIX
119600110803    *C                   EVAL      D@ACCT = CPCID4                              ACCOUNT
119700110803    *C                   EVAL      D@PLAN = CPCID5                              PLAN
119800110803    *C                   EVAL      D@CLM = CPCID6                               CLAIM OFFICE
119900110803     C                   EVAL      DNTLATE = '0'
120000110803    ***
120100110803    *C                   EVAL      #XSX = D@FRM(D#CNE)
120200110803     C                   IF        WRT@TYPE = 'DEPEND' AND
120300110803     C                             #XSX < D@MBREFF
120400110803     C                   MOVE      D@MBREFF      X@EFF
120500110803     C                   ELSE
120600110803     C                   MOVE      #XSX          X@EFF
120700110803     C                   ENDIF
120800110803    ***
120900110803    *C                   EVAL      #XSX = D@TRM(D#CNE)
121000110803    *C                   IF        #XSX = 0 OR #XSX = 99999999
121100110803    *C                   MOVE      *BLANKS       X@TRM
121200110803    *C                   ELSE
121300110803    *C                   MOVE      #XSX          X@TRM
121400110803    *C                   ENDIF
121500110803    ***
121600130423     C                   MOVE      *BLANKS       D@CBREXP
121700130423     C                   MOVE      *BLANKS       D@CBREVT
121800130423     C                   MOVE      *BLANKS       D@CBRLEN
121900110803     C                   IF        WRT@TYPE = 'MEMBER'
122000110803    *C                   IF        EMPST = 'C'
122100110803    *C                   MOVE      CEXPDT        D@CBREXP
122200110803    *C                   MOVE      QEDT          D@CBREVT
122300110803    *C                   MOVE      CEXPDT        #MINUEND
122400110803    *C                   MOVE      QEDT          #SUBTRAEND
122500110803    *C     #MINUEND      SUBDUR    #SUBTRAEND    #DIFFRNC:*M
122600110803    *C                   Z-ADD     #DIFFRNC      #2S0
122700110803    *C                   MOVE      #2S0          D@CBRLEN
122800110803    *C                   ENDIF
122900110803    *C                   ENDIF
123000110803    ***
123100110803     C*  ***PLANS***  IF THIS APPLIES TO THE ACCOUNT; IF NOT, JUST SEND BLANKS
123200110803    *C                   IF        KF@PLN = 'DDDD'
123300110803     C*  ***PLANS***
123400110803    *C                   MOVE      '0'           D@OOAI
123500110803     C                   ELSE
123600110803    *C                   MOVE      *BLANKS       D@OOAI
123700110803    *C                   ENDIF
123800110803    ***
123900110803    *C                   EXCEPT    DENF
124000110803    ***
124100110803    *C                   ENDSR
124200110803   S***S
124300110803   X***X
124400110803     OAET000WF  EADD         HDRF
124500110803     O                                            6 'HEADER'
124600110803     O                                            8 'P'
124700110803     O                       H@SI                28
124800110803     O                                           29 '0'
124900110803     O                       C1                  43
125000110803     O                       D1                  51
125100110803     O                       T1                  57
125200110803     O                                          131 'CONSOLIDATED ELIGIBILITY'
125300110803     O                       H@RI               167
125400110803     O                       H@CC               169
125500110803     O                       H@GN               176
125600110803     O                       H@CN               191
125700110803     O                       H@C#               198
125800110803     O                       D2                 206
125900110803     O                                          216 '02'
126000110803     O                                          231 '*'
126100110803     OAET000WF  EADD         MBRF
126200110803     O                                            6 'MEMBER'
126300110803     O                       @SS1                16
126400110803     O                       @SS2                25
126500110803     O                       @FN                 75
126600110803     O                       @MI                 76
126700110803     O                       @LN                 96
126800110803     O                       @REL               101
126900110803     O                       @SEX               103
127000110803     O                       @DOB               111
127100110803     O                       @SPEC              112
127200110803     O                                          113 '0'
127300110803     O                       @COB               123
127400110803     O                       @COBC              125
127500110803     O                       @COBN              145
127600110803     O                       @AD1               175
127700110803     O                       @AD2               205
127800110803     O                       @CTY               315
127900110803     O                       @ST                317
128000110803     O                       @ZP5               322
128100110803     O                       @PHN               349
128200110803     O                       @EMPST             665
128300110803     O                       @HIRE              673
128400110803     O                                         1231 '*'
128500110803     OAET000WF  EADD         HMOF
128600110803     O                                            7 'BENEFIT'
128700110803     O                       X@LAY               10
128800110803     O                       X@ELR               24
128900110803     O                       M@CC                26
129000110803     O                       H@GN                38
129100110803     O                       M@CLASS             44
129200110803     O                       M@PLAN              50
129300110803     O                       X@EFF               58
129400111201     O                       X@TRM               66
129500110803     O                       X@TIER              69
129600110803     O                       M@PCP              160
129700110803     O                       M@NPI              161
129800110803     O                       M@PCPCI            186
129900110803     O                                          323 '*'
130000110803     OAET000WF  EADD         DENF
130100110803     O                                            7 'BENEFIT'
130200110803     O                       X@LAY               10
130300110803     O                       X@ELR               24
130400110803     O                       H@C#                31
130500110803     O                       D@SFX               34
130600110803     O                       D@ACCT              44
130700110803     O                       D@PLAN              50
130800110803     O                       X@EFF               58
130900111201     O                       X@TRM               66
131000110803     O                       D@CLM               71
131100110803     O                       DNTLATE            389
131200110803     O                       D@CBREXP           466
131300110803     O                       D@CBREVT           516
131400110803     O                       D@CBRLEN           560
131500110803     O                       D@OOAI             609
131600110803     O                                          678 '*'
131700110803     OAET000WF  EADD         TRLF
131800110803     O                                            7 'TRAILER'
131900110803     O                       @TREC               17
132000110803     O                       D1                  25
132100110803     O                       T1                  31
132200110803     O                       @BREC               41
132300110803     O                                           69 '*'
