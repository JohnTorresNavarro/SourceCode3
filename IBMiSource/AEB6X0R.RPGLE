000100121213   X***X CARRIER CONTROL ID #0000000000 ASSURANT SPECIFIC
000200130524   X***X SSK 05.24.2013 TEMPLATE DESIGN
000300130524   X***X THIS WAS BASED ON THE AEB0X0R DESIGN AND MODIFIED FROM THERE.
000400121213   X***X
000500121213   X***X
000600130524   X***X MM.DD.YYYY CLONED FROM AEB6X0R
000700130524   X***X MM.DD.YYYY ASSURANT APPROVED FOR PRODUCTION
000800121213   X***X
000900121213   X***X
001000121213   X***X ACCOUNTS SET-UP
001100121213   X***X TTT-SSS-AAAA  X
001200121213   X***X
001300121213   X***X
001400121213   X***X
001500121213   X***X
001600121213   X***X
001700121213   X***X
001800121213   X***X
001900121213   X***X
002000121213   X***X
002100121213   X***X
002200121213     FCARXPTP   IF   E           K DISK
002300121213     FCARACCP   IF   E           K DISK
002400121213     FCARPLNP   IF   E           K DISK
002500121213   X***X
002600121213     FAEB001WF  O  A E             DISK
002700121213     ** EXPORT FILE
002800121213     FAEB004WF  UF A E           K DISK
002900121213     ** TERM TRACKER
003000121213     **
003100121213     FMEMAC#1   IF   E           K DISK
003200121213     FMCOVMPLN  IF   E           K DISK
003300121213     FDEPNDC    IF   E           K DISK
003400121213     FELIGDCOV  IF   E           K DISK
003500121213   X***X
003600121213     D CARR#CTL        S             10A   INZ('0000000000')
003700121213   X***X
003800121213     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
003900121213     D DS@CARACC     E DS                  EXTNAME(CARACCP)
004000121213     D DS@CARXPT     E DS                  EXTNAME(CARXPTP)
004100121213   X***X
004200121213     ** WORK ARRAY FOR PLANS
004300121213     **
004400121213     ** PC# - PLAN COUNT
004500121213     ** PP# - PLAN POINTER
004600121213     **
004700121213     D CARPLN@       E DS                  EXTNAME(CARPLNP)
004800121213     D                                     OCCURS(50) PREFIX(X:1)
004900121213     **
005000121213     D PC#             S              3S 0
005100121213     D PP#             S              3S 0
005200121213     **
005300121213     D @PLANIN         S              4A
005400121213     D #EFFDTE         S              8S 0
005500121213     D #BENAMT         S                   LIKE(BENAMT)
005600121213     D @CCTRIN         S              3A
005700121213     D @ENRIN          S              3A
005800121213     D @ENROU          S              3A
005900121213   X***X
006000121213     **
006100121213     ** WRITE TYPE = MEMBER OR DEPEND
006200121213     D WRT@TYPE        S              6A
006300121213     **
006400121213   X***X
006500121213     D #CANCEL         S              8S 0
006600121213     D #DATE           S              8S 0
006700130320     D #SIGN           S               D   DATFMT(*ISO)
006800121213     D #ISO            S               D   DATFMT(*ISO)
006900121213     D #RECCNT         S             10S 0 INZ
007000121213     D #TODAY          S              8S 0
007100121213     D #XSX            S              8S 0
007200121213     D #15S0           S             15S 0
007300121213     D #7S0            S              7S 0
007400121213     **
007500121213     D MBR_TERM        S               N
007600121213     D TERM_MED        S               N
007700121213     D TERM_DEN        S               N
007800121213     D TERM_RXD        S               N
007900121213     D TERM_VIS        S               N
008000121213     D TERM_LIF        S               N
008100121213     D TERM_ADD        S               N
008200121213     D TERM_DLF        S               N
008300121213     D TERM_VLF        S               N
008400121213     D TERM_VAD        S               N
008500121213     D TERM_VLT        S               N
008600121213     D TERM_CRI        S               N
008700121213     D TERM_LTD        S               N
008800121213     D TERM_STD        S               N
008900121213     D TERM_VCI        S               N
009000121213     D TERM_ACC        S               N
009100121213     D TERM_CCR        S               N
009200121213     D YES             S               N   INZ(*ON)
009300121213     D NO              S               N   INZ(*OFF)
009400121213     **
009500121213     D KF@ACC          S                   LIKE(ACC#)
009600121213     D KF@CARG         S              2A   INZ
009700121213     D KF@CCTR         S                   LIKE(CCFLG)
009800121213     D KF@CDE          S              2A
009900121213     D KF@ENR          S              3A   INZ
010000121213     D KF@PLN          S                   LIKE(MCPLAN)
010100121213     D KF@SEQ          S                   LIKE(DPSEQ#)
010200121213     D KF@SSN          S                   LIKE(MBSSNO)
010300121213     D KF@SUB          S                   LIKE(MCSUB#)
010400121213     D KF@TRM          S              8S 0
010500121213     D KF@TRS          S                   LIKE(MCTRST)
010600121213     D KF@TYP          S              1A
010700121213     **
010800121213    ***
010900121213    *** MEDICAL ARRAYS
011000121213    *** CAT: PMM, PDM, PSM
011100121213     D MED#CNE         S              3S 0 INZ
011200121213     D MED#NDX         S              3S 0 INZ
011300121213     D MED@PLN         S              4A   DIM(20)
011400121213     D MED@ENR         S              3A   DIM(20)
011500121213     D MED@FRM         S              8S 0 DIM(20)
011600121213     D MED@TRM         S              8S 0 DIM(20)
011700121213     D MED@MEFF        S              8S 0
011800121213     D MED@MTRM        S              8S 0
011900121213    ***
012000121213    *** DENTAL ARRAYS
012100121213    *** CAT: PDN, PDE, PDR
012200121213     D DEN#CNE         S              3S 0 INZ
012300121213     D DEN#NDX         S              3S 0 INZ
012400121213     D DEN@PLN         S              4A   DIM(20)
012500121213     D DEN@ENR         S              3A   DIM(20)
012600121213     D DEN@FRM         S              8S 0 DIM(20)
012700121213     D DEN@TRM         S              8S 0 DIM(20)
012800121213     D DEN@MEFF        S              8S 0
012900121213     D DEN@MTRM        S              8S 0
013000121213    ***
013100121213    *** PRESCRIPTION DRUG ARRAYS
013200121213    *** CAT: PRX
013300121213     D RXD#CNE         S              3S 0 INZ
013400121213     D RXD#NDX         S              3S 0 INZ
013500121213     D RXD@PLN         S              4A   DIM(20)
013600121213     D RXD@ENR         S              3A   DIM(20)
013700121213     D RXD@FRM         S              8S 0 DIM(20)
013800121213     D RXD@TRM         S              8S 0 DIM(20)
013900121213     D RXD@MEFF        S              8S 0
014000121213     D RXD@MTRM        S              8S 0
014100121213    ***
014200121213    *** VISION         ARRAYS
014300121213    *** CAT: PVS, PVR
014400121213     D VIS#CNE         S              3S 0 INZ
014500121213     D VIS#NDX         S              3S 0 INZ
014600121213     D VIS@PLN         S              4A   DIM(20)
014700121213     D VIS@ENR         S              3A   DIM(20)
014800121213     D VIS@FRM         S              8S 0 DIM(20)
014900121213     D VIS@TRM         S              8S 0 DIM(20)
015000121213     D VIS@MEFF        S              8S 0
015100121213     D VIS@MTRM        S              8S 0
015200121213    ***
015300121213    *** LONG TERM DISABILITY ARRAYS - MEMBER ONLY
015400121213    *** CAT: PLT
015500121213     D LTD#CNE         S              3S 0 INZ
015600121213     D LTD#NDX         S              3S 0 INZ
015700121213     D LTD@PLN         S              4A   DIM(20)
015800121213     D LTD@ENR         S              3A   DIM(20)
015900121213     D LTD@VOL         S              7S 0 DIM(20)
016000121213     D LTD@FRM         S              8S 0 DIM(20)
016100121213     D LTD@TRM         S              8S 0 DIM(20)
016200121213     D LTD@MEFF        S              8S 0
016300121213     D LTD@MTRM        S              8S 0
016400121213    ***
016500121213    *** SHORT TERM DISABILITY ARRAYS  MEMBER ONLY
016600121213    *** CAT: PWD
016700121213     D STD#CNE         S              3S 0 INZ
016800121213     D STD#NDX         S              3S 0 INZ
016900121213     D STD@PLN         S              4A   DIM(20)
017000121213     D STD@ENR         S              3A   DIM(20)
017100121213     D STD@VOL         S              7S 0 DIM(20)
017200121213     D STD@FRM         S              8S 0 DIM(20)
017300121213     D STD@TRM         S              8S 0 DIM(20)
017400121213     D STD@MEFF        S              8S 0
017500121213     D STD@MTRM        S              8S 0
017600121213    ***
017700121213    *** BASIC LIFE ARRAYS
017800121213    *** CAT: PLF
017900121213     D LIF#CNE         S              3S 0 INZ
018000121213     D LIF#NDX         S              3S 0 INZ
018100121213     D LIF@PLN         S              4A   DIM(20)
018200121213     D LIF@ENR         S              3A   DIM(20)
018300121213     D LIF@VOL         S              7S 0 DIM(20)
018400121213     D LIF@FRM         S              8S 0 DIM(20)
018500121213     D LIF@TRM         S              8S 0 DIM(20)
018600121213     D LIF@MEFF        S              8S 0
018700121213     D LIF@MTRM        S              8S 0
018800121213    ***
018900121213    *** ACCIDENTAL DEATH AND DISMEMBERMENT ARRAYS MEMBER ONLY
019000121213    *** CAT: PAC, PA1
019100121213     D ADD#CNE         S              3S 0 INZ
019200121213     D ADD#NDX         S              3S 0 INZ
019300121213     D ADD@PLN         S              4A   DIM(20)
019400121213     D ADD@ENR         S              3A   DIM(20)
019500121213     D ADD@VOL         S              7S 0 DIM(20)
019600121213     D ADD@FRM         S              8S 0 DIM(20)
019700121213     D ADD@TRM         S              8S 0 DIM(20)
019800121213     D ADD@MEFF        S              8S 0
019900121213     D ADD@MTRM        S              8S 0
020000121213    ***
020100121213    *** DEPENDENT BASIC LIFE ARRAYS   DEPENDENTS ONLY
020200121213    *** CAT: PDL
020300121213     D DLF#CNE         S              3S 0 INZ
020400121213     D DLF#NDX         S              3S 0 INZ
020500121213     D DLF@PLN         S              4A   DIM(20)
020600121213     D DLF@ENR         S              3A   DIM(20)
020700121213     D DLF@VOL         S              7S 0 DIM(20)
020800121213     D DLF@FRM         S              8S 0 DIM(20)
020900121213     D DLF@TRM         S              8S 0 DIM(20)
021000121213     D DLF@MEFF        S              8S 0
021100121213     D DLF@MTRM        S              8S 0
021200121213    ***
021300121213    *** VOLUNTARY LIFE ARRAYS
021400121213    *** MBR CAT: PLS, PNE, PO4, PO5, PSL, PS4-6
021500121213    *** SPS CAT: PNS, PSP, PSS, PS1-3
021600121213    *** DEP CAT: PD1, PD2, PD3, PSD, PVD
021700121213     D VLF#CNE         S              3S 0 INZ
021800121213     D VLF#NDX         S              3S 0 INZ
021900121213     D VLF@PLN         S              4A   DIM(20)
022000121213     D VLF@ENR         S              3A   DIM(20)
022100121213     D VLF@VOL         S              7S 0 DIM(20)
022200121213     D VLF@FRM         S              8S 0 DIM(20)
022300121213     D VLF@TRM         S              8S 0 DIM(20)
022400121213     D VLF@MEFF        S              8S 0
022500121213     D VLF@MTRM        S              8S 0
022600121213    ***
022700121213    *** VOLUNTARY ACCIDENTAL DEATH AND DISMEMBERMENT ARRAYS
022800121213    *** CAT: PSA, POA, PAA, PS0/7-9
022900121213     D VAD#CNE         S              3S 0 INZ
023000121213     D VAD#NDX         S              3S 0 INZ
023100121213     D VAD@PLN         S              4A   DIM(20)
023200121213     D VAD@ENR         S              3A   DIM(20)
023300121213     D VAD@VOL         S              7S 0 DIM(20)
023400121213     D VAD@FRM         S              8S 0 DIM(20)
023500121213     D VAD@TRM         S              8S 0 DIM(20)
023600121213     D VAD@MEFF        S              8S 0
023700121213     D VAD@MTRM        S              8S 0
023800121213    ***
023900121213    *** VOLUNTARY LONG TERM DISABILITY ARRAYS
024000121213    *** CAT: PVL
024100121213     D VLT#CNE         S              3S 0 INZ
024200121213     D VLT#NDX         S              3S 0 INZ
024300121213     D VLT@PLN         S              4A   DIM(20)
024400121213     D VLT@ENR         S              3A   DIM(20)
024500121213     D VLT@VOL         S              7S 0 DIM(20)
024600121213     D VLT@FRM         S              8S 0 DIM(20)
024700121213     D VLT@TRM         S              8S 0 DIM(20)
024800121213     D VLT@MEFF        S              8S 0
024900121213     D VLT@MTRM        S              8S 0
025000121213    ***
025100121213    *** CRITICAL ILLNESS ARRAYS
025200121213    *** CAT: PCC
025300121213     D CRI#CNE         S              3S 0 INZ
025400121213     D CRI#NDX         S              3S 0 INZ
025500121213     D CRI@PLN         S              4A   DIM(20)
025600121213     D CRI@ENR         S              3A   DIM(20)
025700121213     D CRI@VOL         S              7S 0 DIM(20)
025800121213     D CRI@FRM         S              8S 0 DIM(20)
025900121213     D CRI@TRM         S              8S 0 DIM(20)
026000121213     D CRI@MEFF        S              8S 0
026100121213     D CRI@MTRM        S              8S 0
026200121213    ***
026300121213    *** VOLUNTARY CRITICAL ILLNESS ARRAYS
026400121213    *** CAT: P.. [WE CURRENTLY DO NOT OFFER THIS]
026500121213     D VCI#CNE         S              3S 0 INZ
026600121213     D VCI#NDX         S              3S 0 INZ
026700121213     D VCI@PLN         S              4A   DIM(20)
026800121213     D VCI@ENR         S              3A   DIM(20)
026900121213     D VCI@VOL         S              7S 0 DIM(20)
027000121213     D VCI@FRM         S              8S 0 DIM(20)
027100121213     D VCI@TRM         S              8S 0 DIM(20)
027200121213     D VCI@MEFF        S              8S 0
027300121213     D VCI@MTRM        S              8S 0
027400121213    ***
027500121213    *** ACCIDENT COVERAGE ARRAYS
027600121213    *** CAT: P.. [WE CURRENTLY DO NOT OFFER THIS]
027700121213     D ACC#CNE         S              3S 0 INZ
027800121213     D ACC#NDX         S              3S 0 INZ
027900121213     D ACC@PLN         S              4A   DIM(20)
028000121213     D ACC@ENR         S              3A   DIM(20)
028100121213     D ACC@VOL         S              7S 0 DIM(20)
028200121213     D ACC@FRM         S              8S 0 DIM(20)
028300121213     D ACC@TRM         S              8S 0 DIM(20)
028400121213     D ACC@MEFF        S              8S 0
028500121213    ***
028600121213    *** CANCER COVERAGE ARRAYS
028700121213    *** CAT: P.. [WE CURRENTLY DO NOT OFFER THIS]
028800121213     D CCR#CNE         S              3S 0 INZ
028900121213     D CCR#NDX         S              3S 0 INZ
029000121213     D CCR@PLN         S              4A   DIM(20)
029100121213     D CCR@ENR         S              3A   DIM(20)
029200121213     D CCR@VOL         S              7S 0 DIM(20)
029300121213     D CCR@FRM         S              8S 0 DIM(20)
029400121213     D CCR@TRM         S              8S 0 DIM(20)
029500121213     D CCR@MEFF        S              8S 0
029600121213    ***
029700121213    ***
029800130320     D DS@AEB        E DS                  EXTNAME(AEB001WF)
029900130320     D  @@AE                0489   1508A   DIM(20)
030000130320     D  NDX            S              3S 0
030100130320    ***
030200130320     D                 DS
030300130320     D AE@@                          51A
030400130320     D AE@@PDT                 1      3A
030500130320     D AE@@COV                 4      6A
030600130320     D AE@@TYP                 7      7A
030700130320     D AE@@BAC                08     10A
030800130320     D AE@@AED                11     18A
030900130320     D AE@@VOL                19     33A
031000130320     D AE@@DT                 34     34A
031100130320     D AE@@MDTE               35     42A
031200130320     D AE@@DTS                43     43A
031300130320     D AE@@SDTE               44     51A
031400121213    ***
031500121213     D @STEP           S              5A
031600121213   X***X
031700121213     C                   EVAL      @STEP = 'PREP0'
031800121213    ***
031900121213     C                   DOU       @STEP = 'LEAVE'
032000121213     C     @STEP         CASEQ     'PREP0'       $PREP0
032100121213     C     @STEP         CASEQ     'STEP0'       $STEP0
032200121213     C     @STEP         CASEQ     'PREP1'       $PREP1
032300121213     C     @STEP         CASEQ     'STEP1'       $STEP1
032400121213     C     @STEP         CASEQ     'STEP2'       $STEP2
032500121213     C     @STEP         CASEQ     'STEP3'       $STEP3
032600121213     C     @STEP         CASEQ     'PREP4'       $PREP4
032700121213     C     @STEP         CASEQ     'STEP4'       $STEP4
032800121213     C     @STEP         CASEQ     'PREP5'       $PREP5
032900121213     C     @STEP         CASEQ     'STEP5'       $STEP5
033000121213     C     @STEP         CASEQ     'STEP6'       $STEP6
033100121213     C     @STEP         CASEQ     'PREP7'       $PREP7
033200121213     C     @STEP         CASEQ     'STEP7'       $STEP7
033300121213     C                   ENDCS
033400121213     C                   ENDDO
033500121213    ***
033600121213     C                   EVAL      *INLR = *ON
033700121213   S***S
033800121213     C     $PREP0        BEGSR
033900121213    ***
034000121213     C     CARR#CTL      CHAIN     CARXPTR
034100121213    ***
034200121213     C     CARR#CTL      SETLL     CARACCR
034300121213    ***
034400121213     C                   EVAL      #ISO = %DATE
034500121213     C                   MOVE      #ISO          #TODAY
034600121213    ***
034700121213     C                   EVAL      @STEP = 'STEP0'
034800121213    ***
034900121213     C                   ENDSR
035000121213   S***S
035100121213     C     $STEP0        BEGSR
035200121213    ***
035300121213     C     CARR#CTL      READE     CARACCR
035400121213    ***
035500121213     C                   IF        %EOF(CARACCP)
035600121213     C                   EVAL      @STEP = 'LEAVE'
035700121213     C                   LEAVESR
035800121213     C                   ENDIF
035900121213    ***
036000121213    *** CAN THE ACCOUNT BE EXPORTED?
036100121213    ***
036200121213     C                   IF        CASTATUS = 'N'
036300121213     C                   LEAVESR
036400121213     C                   ENDIF
036500121213    ***
036600121213     C                   EVAL      @STEP = 'PREP1'
036700121213    ***
036800121213     C                   ENDSR
036900121213   S***S
037000121213     C     $PREP1        BEGSR
037100121213    ***
037200121213     C                   EVAL      KF@TRS = CATRST
037300121213     C                   EVAL      KF@SUB = CASUB#
037400121213     C                   EVAL      KF@ACC = CAACCT
037500121213    ***
037600121213     C                   EXSR      $PLANLOAD
037700121213    ***
037800121213     C                   EVAL      #RECCNT = 0
037900121213    ***
038000121213     C                   EVAL      @STEP = 'STEP1'
038100121213    ***
038200121213     C                   ENDSR
038300121213   S***S
038400121213    *** PLANS LOADED BY ACCOUNT
038500121213    ***
038600121213     C     $PLANLOAD     BEGSR
038700121213    ***
038800121213     C                   EVAL      PP# = 0
038900121213     C                   DO        50
039000121213     C                   ADD       1             PP#
039100121213     C     PP#           OCCUR     CARPLN@
039200121213     C                   CLEAR                   CARPLN@
039300121213     C                   ENDDO
039400121213     C                   EVAL      PC# = 0
039500121213     C                   EVAL      PP# = 0
039600121213    ***
039700121213     C     KL#ACCTL      SETLL     CARPLNR
039800121213     C                   DOU       %EOF(CARPLNP)
039900121213     C     KL#ACCTL      READE     CARPLNR
040000121213     C                   IF        NOT %EOF(CARPLNP)
040100121213    ***
040200121213     C                   ADD       1             PC#
040300121213     C     PC#           OCCUR     CARPLN@
040400121213     C                   EVAL      CARPLN@ = DS@CARPLN
040500121213    ***
040600121213     C                   ENDIF
040700121213     C                   ENDDO
040800121213    ***
040900121213     C                   ENDSR
041000121213   S***S
041100121213     C     $STEP1        BEGSR
041200121213    ***
041300121213     C                   EVAL      KF@PLN = *BLANKS
041400121213     C                   EVAL      KF@TRM = 0
041500121213     C                   EVAL      KF@SSN = 0
041600121213     C                   EVAL      KF@SEQ = 0
041700121213    ***
041800121213     C     KL#TSA        SETLL     MEMBR
041900121213    ***
042000121213     C                   EVAL      @STEP = 'STEP2'
042100121213    ***
042200121213     C                   ENDSR
042300121213   S***S
042400121213     C     $STEP2        BEGSR
042500121213    ***
042600121213     C     KL#TSA        READE     MEMBR
042700121213    ***
042800121213     C                   IF        %EOF(MEMAC#1)
042900121213     C                   EVAL      @STEP = 'STEP0'
043000121213     C                   LEAVESR
043100121213     C                   ENDIF
043200121213    ***
043300121213     C                   EVAL      KF@SSN = MBSSNO
043400121213     C                   MOVE      *ZEROS        KF@SEQ
043500121213    ***
043600121213     C                   IF        TERMDT > 0
043700121213     C                   EVAL      MBR_TERM = YES
043800121213     C                   ELSE
043900121213     C                   EVAL      MBR_TERM = NO
044000121213     C                   ENDIF
044100121213    ***
044200121213     C     KL#MPLN       SETLL     MCOVR
044300121213    ***
044400121213     C                   EXSR      $CLRSTG
044500121213    ***
044600121213     C                   EVAL      @STEP = 'STEP3'
044700121213    ***
044800121213     C                   ENDSR
044900121213   S***S
045000121213     C     $STEP3        BEGSR
045100121213    ***
045200121213     C     KL#MPLN       READE     MCOVR
045300121213    ***
045400121213     C                   IF        %EOF(MCOVMPLN)
045500121213     C                   EVAL      @STEP = 'PREP4'
045600121213     C                   LEAVESR
045700121213     C                   ENDIF
045800121213    ***
045900121213     C                   EVAL      @PLANIN = MCPLAN
046000121213     C                   EVAL      #EFFDTE = ENRLDT
046100121213     C                   EVAL      #BENAMT = BENAMT
046200121213     C                   EVAL      #CANCEL = CANDT
046300121213     **
046400121213     C                   EXSR      $QUIK
046500121213     **
046600121213     C                   EXSR      $PLANSRCH
046700121213    ***
046800121213     C                   IF        PLN@CAT = *BLANKS
046900121213     C                   LEAVESR
047000121213     C                   ENDIF
047100121213    ***
047200121213     C                   EVAL      @ENRIN = MCOVTP
047300121213     C                   EXSR      $TIERLVL
047400121213    ***
047500121213     C                   IF        #CANCEL = 0
047600121213     C                   EVAL      #CANCEL = 99999999
047700121213     C                   ENDIF
047800121213    ***
047900121213     C                   EXSR      $AD2MARY
048000121213    ***
048100121213     C                   ENDSR
048200121213   S***S
048300121213     C     $QUIK         BEGSR
048400121213    ***
048500121213     C                   EVAL      @CCTRIN = *BLANKS
048600121213    ***
048700121213     C                   IF        CACID4 = 'NORULE'
048800121213     C                   LEAVESR
048900121213     C                   ENDIF
049000121213    ***
049100121213     C     CACID4        CASEQ     'EMPSTS'      $ES
049200121213     C     CACID4        CASEQ     'JOBCLASS'    $JC
049300121213     C                   ENDCS
049400121213    ***
049500121213     C                   ENDSR
049600121213   S***S
049700121213     C     $ES           BEGSR
049800121213    ***
049900121213     C                   IF        EMPST =  'C'
050000121213     C                   EVAL      @CCTRIN = 'COB'
050100121213     C                   ELSE
050200121213     C                   EVAL      @CCTRIN = 'ACT'
050300121213     C                   ENDIF
050400121213    ***
050500121213     C                   ENDSR
050600121213   S***S
050700121213     C     $JC           BEGSR
050800121213    ***
050900121213     C                   SELECT
051000121213     C                   WHEN      EMPST =  'C'
051100121213     C                   EVAL      @CCTRIN = 'COB'
051200121213     C                   WHEN      X= Y
051300121213     C                   EVAL      @CCTRIN = 'HR'
051400121213     C                   WHEN      X= Y
051500121213     C                   EVAL      @CCTRIN = 'SAL'
051600121213     C                   ENDSL
051700121213    ***
051800121213     C                   ENDSR
051900121213   S***S
052000121213     C     $TIERLVL      BEGSR
052100121213    ***
052200121213     C                   SELECT
052300121213      *
052400121213     C                   WHEN      CPCID5 = 'E'
052500121213     C                   EVAL      @ENROU = 'EMP'
052600121213      *
052700121213     C                   WHEN      CPCID5 = 'S'
052800121213     C                   EVAL      @ENROU = 'SPO'
052900121213      *
053000121213     C                   WHEN      CPCID5 = 'C'
053100121213     C                   EVAL      @ENROU = 'CHD'
053200121213      *
053300121213     C                   WHEN      CPCID5 = '2'
053400121213     C                   IF        @ENRIN = 'TIN'
053500121213     C                   EVAL      @ENROU = 'EMP'
053600121213     C                   ELSE
053700121213     C                   EVAL      @ENROU = 'FAM'
053800121213     C                   ENDIF
053900121213      *
054000121213     C                   WHEN      CPCID5 = '4'
054100121213     C                   SELECT
054200121213     C                   WHEN      @ENRIN = 'TIN'
054300121213     C                   EVAL      @ENROU = 'EMP'
054400121213     C                   WHEN      @ENRIN = 'THW'
054500121213     C                   EVAL      @ENROU = 'ESP'
054600121213     C                   WHEN      @ENRIN = 'TPC' OR @ENRIN = 'TP2'
054700121213     C                   EVAL      @ENROU = 'ECH'
054800121213     C                   WHEN      @ENRIN = 'TFA'
054900121213     C                   EVAL      @ENROU = 'FAM'
055000121213     C                   ENDSL
055100121213      *
055200121213     C                   ENDSL
055300121213    ***
055400121213     C                   ENDSR
055500121213   S***S
055600121213     C     $AD2MARY      BEGSR
055700121213    ***
055800121213    *C                   IF        PLN@CAT = 'MM'
055900121213     C                   IF        MED#CNE > 0
056000121213     C                   IF        MED@TRM(MED#CNE) = 99999999
056100121213     C                   LEAVESR
056200121213     C                   ENDIF
056300121213     C                   ENDIF
056400121213    *C                   ADD       1             MED#CNE
056500121213    *C                   EVAL      MED@PLN(MED#CNE) = @PLANIN
056600121213    *C                   EVAL      MED@ENR(MED#CNE) = @ENROU
056700121213    *C                   EVAL      MED@FRM(MED#CNE) = #EFFDTE
056800121213    *C                   EVAL      MED@TRM(MED#CNE) = #CANCEL
056900121213     C                   LEAVESR
057000121213    *C                   ENDIF
057100121213    ***
057200121213    *C                   IF        PLN@CAT = 'DEN'
057300121213     C                   IF        DEN#CNE > 0
057400121213     C                   IF        DEN@TRM(DEN#CNE) = 99999999
057500121213     C                   LEAVESR
057600121213     C                   ENDIF
057700121213     C                   ENDIF
057800121213    *C                   ADD       1             DEN#CNE
057900121213    *C                   EVAL      DEN@PLN(DEN#CNE) = @PLANIN
058000121213    *C                   EVAL      DEN@ENR(DEN#CNE) = @ENROU
058100121213    *C                   EVAL      DEN@FRM(DEN#CNE) = #EFFDTE
058200121213    *C                   EVAL      DEN@TRM(DEN#CNE) = #CANCEL
058300121213     C                   LEAVESR
058400121213    *C                   ENDIF
058500121213    ***
058600121213    *C                   IF        PLN@CAT = 'RX'
058700121213     C                   IF        RXD#CNE > 0
058800121213     C                   IF        RXD@TRM(RXD#CNE) = 99999999
058900121213     C                   LEAVESR
059000121213     C                   ENDIF
059100121213     C                   ENDIF
059200121213    *C                   ADD       1             RXD#CNE
059300121213    *C                   EVAL      RXD@PLN(RXD#CNE) = @PLANIN
059400121213    *C                   EVAL      RXD@ENR(RXD#CNE) = @ENROU
059500121213    *C                   EVAL      RXD@FRM(RXD#CNE) = #EFFDTE
059600121213    *C                   EVAL      RXD@TRM(RXD#CNE) = #CANCEL
059700121213     C                   LEAVESR
059800121213    *C                   ENDIF
059900121213    ***
060000121213    *C                   IF        PLN@CAT = 'VIS'
060100121213     C                   IF        VIS#CNE > 0
060200121213     C                   IF        VIS@TRM(VIS#CNE) = 99999999
060300121213     C                   LEAVESR
060400121213     C                   ENDIF
060500121213     C                   ENDIF
060600121213    *C                   ADD       1             VIS#CNE
060700121213    *C                   EVAL      VIS@PLN(VIS#CNE) = @PLANIN
060800121213    *C                   EVAL      VIS@ENR(VIS#CNE) = @ENROU
060900121213    *C                   EVAL      VIS@FRM(VIS#CNE) = #EFFDTE
061000121213    *C                   EVAL      VIS@TRM(VIS#CNE) = #CANCEL
061100121213     C                   LEAVESR
061200121213    *C                   ENDIF
061300121213    ***
061400121213    *C                   IF        PLN@CAT = 'LTD'
061500121213     C                   IF        LTD#CNE > 0
061600121213     C                   IF        LTD@TRM(LTD#CNE) = 99999999
061700121213     C                   LEAVESR
061800121213     C                   ENDIF
061900121213     C                   ENDIF
062000121213    *C                   ADD       1             LTD#CNE
062100121213    *C                   EVAL      LTD@PLN(LTD#CNE) = @PLANIN
062200121213    *C                   EVAL      LTD@ENR(LTD#CNE) = @ENROU
062300121213     C                   EVAL      LTD@VOL(LTD#CNE) = #BENAMT
062400121213    *C                   EVAL      LTD@FRM(LTD#CNE) = #EFFDTE
062500121213    *C                   EVAL      LTD@TRM(LTD#CNE) = #CANCEL
062600121213     C                   LEAVESR
062700121213    *C                   ENDIF
062800121213    ***
062900121213    *C                   IF        PLN@CAT = 'STD'
063000121213     C                   IF        STD#CNE > 0
063100121213     C                   IF        STD@TRM(STD#CNE) = 99999999
063200121213     C                   LEAVESR
063300121213     C                   ENDIF
063400121213     C                   ENDIF
063500121213    *C                   ADD       1             STD#CNE
063600121213    *C                   EVAL      STD@PLN(STD#CNE) = @PLANIN
063700121213    *C                   EVAL      STD@ENR(STD#CNE) = @ENROU
063800121213     C                   EVAL      STD@VOL(STD#CNE) = #BENAMT
063900121213    *C                   EVAL      STD@FRM(STD#CNE) = #EFFDTE
064000121213    *C                   EVAL      STD@TRM(STD#CNE) = #CANCEL
064100121213     C                   LEAVESR
064200121213    *C                   ENDIF
064300121213    ***
064400121213    *C                   IF        PLN@CAT = 'AC'
064500121213     C                   IF        LIF#CNE > 0
064600121213     C                   IF        LIF@TRM(LIF#CNE) = 99999999
064700121213     C                   LEAVESR
064800121213     C                   ENDIF
064900121213     C                   ENDIF
065000121213    *C                   ADD       1             LIF#CNE
065100121213    *C                   EVAL      LIF@PLN(LIF#CNE) = @PLANIN
065200121213    *C                   EVAL      LIF@ENR(LIF#CNE) = @ENROU
065300121213     C                   EVAL      LIF@VOL(LIF#CNE) = #BENAMT
065400121213    *C                   EVAL      LIF@FRM(LIF#CNE) = #EFFDTE
065500121213    *C                   EVAL      LIF@TRM(LIF#CNE) = #CANCEL
065600121213     C                   LEAVESR
065700121213    *C                   ENDIF
065800121213    ***
065900121213    *C                   IF        PLN@CAT = 'ADD'
066000121213     C                   IF        ADD#CNE > 0
066100121213     C                   IF        ADD@TRM(ADD#CNE) = 99999999
066200121213     C                   LEAVESR
066300121213     C                   ENDIF
066400121213     C                   ENDIF
066500121213    *C                   ADD       1             ADD#CNE
066600121213    *C                   EVAL      ADD@PLN(ADD#CNE) = @PLANIN
066700121213    *C                   EVAL      ADD@ENR(ADD#CNE) = @ENROU
066800121213     C                   EVAL      ADD@VOL(ADD#CNE) = #BENAMT
066900121213    *C                   EVAL      ADD@FRM(ADD#CNE) = #EFFDTE
067000121213    *C                   EVAL      ADD@TRM(ADD#CNE) = #CANCEL
067100121213     C                   LEAVESR
067200121213    *C                   ENDIF
067300121213    ***
067400121213    *C                   IF        PLN@CAT = 'DEPLIF'
067500121213     C                   IF        DLF#CNE > 0
067600121213     C                   IF        DLF@TRM(DLF#CNE) = 99999999
067700121213     C                   LEAVESR
067800121213     C                   ENDIF
067900121213     C                   ENDIF
068000121213    *C                   ADD       1             DLF#CNE
068100121213    *C                   EVAL      DLF@PLN(DLF#CNE) = @PLANIN
068200121213    *C                   EVAL      DLF@ENR(DLF#CNE) = @ENROU
068300121213     C                   EVAL      DLF@VOL(DLF#CNE) = #BENAMT
068400121213    *C                   EVAL      DLF@FRM(DLF#CNE) = #EFFDTE
068500121213    *C                   EVAL      DLF@TRM(DLF#CNE) = #CANCEL
068600121213     C                   LEAVESR
068700121213    *C                   ENDIF
068800121213    ***
068900121213    *C                   IF        PLN@CAT = 'AF'
069000121213     C                   IF        VLF#CNE > 0
069100121213     C                   IF        VLF@TRM(VLF#CNE) = 99999999
069200121213     C                   LEAVESR
069300121213     C                   ENDIF
069400121213     C                   ENDIF
069500121213    *C                   ADD       1             VLF#CNE
069600121213    *C                   EVAL      VLF@PLN(VLF#CNE) = @PLANIN
069700121213    *C                   EVAL      VLF@ENR(VLF#CNE) = @ENROU
069800121213     C                   EVAL      VLF@VOL(VLF#CNE) = #BENAMT
069900121213    *C                   EVAL      VLF@FRM(VLF#CNE) = #EFFDTE
070000121213    *C                   EVAL      VLF@TRM(VLF#CNE) = #CANCEL
070100121213     C                   LEAVESR
070200121213    *C                   ENDIF
070300121213    ***
070400121213    *C                   IF        PLN@CAT = 'VOLADD'
070500121213     C                   IF        VAD#CNE > 0
070600121213     C                   IF        VAD@TRM(VAD#CNE) = 99999999
070700121213     C                   LEAVESR
070800121213     C                   ENDIF
070900121213     C                   ENDIF
071000121213    *C                   ADD       1             VAD#CNE
071100121213    *C                   EVAL      VAD@PLN(VAD#CNE) = @PLANIN
071200121213    *C                   EVAL      VAD@ENR(VAD#CNE) = @ENROU
071300121213     C                   EVAL      VAD@VOL(VAD#CNE) = #BENAMT
071400121213    *C                   EVAL      VAD@FRM(VAD#CNE) = #EFFDTE
071500121213    *C                   EVAL      VAD@TRM(VAD#CNE) = #CANCEL
071600121213     C                   LEAVESR
071700121213    *C                   ENDIF
071800121213    ***
071900121213    *C                   IF        PLN@CAT = 'VOLLTD'
072000121213     C                   IF        VLT#CNE > 0
072100121213     C                   IF        VLT@TRM(VLT#CNE) = 99999999
072200121213     C                   LEAVESR
072300121213     C                   ENDIF
072400121213     C                   ENDIF
072500121213    *C                   ADD       1             VLT#CNE
072600121213    *C                   EVAL      VLT@PLN(VLT#CNE) = @PLANIN
072700121213    *C                   EVAL      VLT@ENR(VLT#CNE) = @ENROU
072800121213     C                   EVAL      VLT@VOL(VLT#CNE) = #BENAMT
072900121213    *C                   EVAL      VLT@FRM(VLT#CNE) = #EFFDTE
073000121213    *C                   EVAL      VLT@TRM(VLT#CNE) = #CANCEL
073100121213     C                   LEAVESR
073200121213    *C                   ENDIF
073300121213    ***
073400121213    *C                   IF        PLN@CAT = 'CRITIL'
073500121213     C                   IF        CRI#CNE > 0
073600121213     C                   IF        CRI@TRM(CRI#CNE) = 99999999
073700121213     C                   LEAVESR
073800121213     C                   ENDIF
073900121213     C                   ENDIF
074000121213    *C                   ADD       1             CRI#CNE
074100121213    *C                   EVAL      CRI@PLN(CRI#CNE) = @PLANIN
074200121213    *C                   EVAL      CRI@ENR(CRI#CNE) = @ENROU
074300121213     C                   EVAL      CRI@VOL(CRI#CNE) = #BENAMT
074400121213    *C                   EVAL      CRI@FRM(CRI#CNE) = #EFFDTE
074500121213    *C                   EVAL      CRI@TRM(CRI#CNE) = #CANCEL
074600121213     C                   LEAVESR
074700121213    *C                   ENDIF
074800121213    ***
074900121213    *C                   IF        PLN@CAT = 'VOLCRIT'
075000121213     C                   IF        VCI#CNE > 0
075100121213     C                   IF        VCI@TRM(VCI#CNE) = 99999999
075200121213     C                   LEAVESR
075300121213     C                   ENDIF
075400121213     C                   ENDIF
075500121213    *C                   ADD       1             VCI#CNE
075600121213    *C                   EVAL      VCI@PLN(VCI#CNE) = @PLANIN
075700121213    *C                   EVAL      VCI@ENR(VCI#CNE) = @ENROU
075800121213     C                   EVAL      VCI@VOL(VCI#CNE) = #BENAMT
075900121213    *C                   EVAL      VCI@FRM(VCI#CNE) = #EFFDTE
076000121213    *C                   EVAL      VCI@TRM(VCI#CNE) = #CANCEL
076100121213     C                   LEAVESR
076200121213    *C                   ENDIF
076300121213    ***
076400121213    *C                   IF        PLN@CAT = 'ACC'
076500121213     C                   IF        ACC#CNE > 0
076600121213     C                   IF        ACC@TRM(ACC#CNE) = 99999999
076700121213     C                   LEAVESR
076800121213     C                   ENDIF
076900121213     C                   ENDIF
077000121213    *C                   ADD       1             ACC#CNE
077100121213    *C                   EVAL      ACC@PLN(ACC#CNE) = @PLANIN
077200121213    *C                   EVAL      ACC@ENR(ACC#CNE) = @ENROU
077300121213    *C                   EVAL      ACC@FRM(ACC#CNE) = #EFFDTE
077400121213    *C                   EVAL      ACC@TRM(ACC#CNE) = #CANCEL
077500121213     C                   LEAVESR
077600121213    *C                   ENDIF
077700121213    ***
077800121213    *C                   IF        PLN@CAT = 'CAN'
077900121213     C                   IF        CCR#CNE > 0
078000121213     C                   IF        CCR@TRM(CCR#CNE) = 99999999
078100121213     C                   LEAVESR
078200121213     C                   ENDIF
078300121213     C                   ENDIF
078400121213    *C                   ADD       1             CCR#CNE
078500121213    *C                   EVAL      CCR@PLN(CCR#CNE) = @PLANIN
078600121213    *C                   EVAL      CCR@ENR(CCR#CNE) = @ENROU
078700121213    *C                   EVAL      CCR@FRM(CCR#CNE) = #EFFDTE
078800121213    *C                   EVAL      CCR@TRM(CCR#CNE) = #CANCEL
078900121213     C                   LEAVESR
079000121213    *C                   ENDIF
079100121213    ***
079200121213     C                   ENDSR
079300121213   S***S
079400121213     C     $PREP4        BEGSR
079500121213    ***
079600121213     C                   IF        LIF#CNE  = 0 AND MED#CNE  = 0 AND
079700121213     C                             ADD#CNE  = 0 AND DEN#CNE  = 0 AND
079800121213     C                             DLF#CNE  = 0 AND RXD#CNE  = 0 AND
079900121213     C                             VLF#CNE  = 0 AND VIS#CNE  = 0 AND
080000121213     C                             VAD#CNE  = 0 AND LTD#CNE  = 0 AND
080100121213     C                             VLT#CNE  = 0 AND STD#CNE  = 0 AND
080200121213     C                             ACC#CNE  = 0 AND CCR#CNE  = 0 AND
080300121213     C                             CRI#CNE  = 0 AND VCI#CNE  = 0
080400121213     C                   EVAL      @STEP = 'STEP2'
080500121213     C                   LEAVESR
080600121213     C                   ENDIF
080700121213    ***
080800121213     C                   EVAL      TERM_LIF = NO
080900121213     C                   EVAL      TERM_ADD = NO
081000121213     C                   EVAL      TERM_DLF = NO
081100121213     C                   EVAL      TERM_VLF = NO
081200121213     C                   EVAL      TERM_VAD = NO
081300121213     C                   EVAL      TERM_VLT = NO
081400121213     C                   EVAL      TERM_CRI = NO
081500121213     C                   EVAL      TERM_MED = NO
081600121213     C                   EVAL      TERM_DEN = NO
081700121213     C                   EVAL      TERM_RXD = NO
081800121213     C                   EVAL      TERM_VIS = NO
081900121213     C                   EVAL      TERM_LTD = NO
082000121213     C                   EVAL      TERM_STD = NO
082100121213     C                   EVAL      TERM_VCI = NO
082200121213     C                   EVAL      TERM_ACC = NO
082300121213     C                   EVAL      TERM_CCR = NO
082400121213    ***
082500121213     C                   EXSR      $CHKHEM
082600121213    ***
082700121213     C                   EVAL      @STEP = 'STEP4'
082800121213    ***
082900121213     C                   ENDSR
083000121213   S***S
083100121213    *** GENERATE MEMBER RECORD
083200121213    ***
083300121213     C     $STEP4        BEGSR
083400121213    ***
083500121213     C                   IF        LIF#CNE  = 0 AND MED#CNE  = 0 AND
083600121213     C                             ADD#CNE  = 0 AND DEN#CNE  = 0 AND
083700121213     C                             DLF#CNE  = 0 AND RXD#CNE  = 0 AND
083800121213     C                             VLF#CNE  = 0 AND VIS#CNE  = 0 AND
083900121213     C                             VAD#CNE  = 0 AND LTD#CNE  = 0 AND
084000121213     C                             VLT#CNE  = 0 AND STD#CNE  = 0 AND
084100121213     C                             ACC#CNE  = 0 AND CCR#CNE  = 0 AND
084200121213     C                             CRI#CNE  = 0 AND VCI#CNE  = 0
084300121213     C                   EVAL      @STEP = 'STEP2'
084400121213     C                   LEAVESR
084500121213     C                   ENDIF
084600121213    ***
084700121213     C                   EVAL      WRT@TYPE = 'MEMBER'
084800121213    ***
084900121213     C                   EVAL      MED@MEFF = 0
085000121213     C                   EVAL      DEN@MEFF = 0
085100121213     C                   EVAL      RXD@MEFF = 0
085200121213     C                   EVAL      VIS@MEFF = 0
085300121213     C                   EVAL      LTD@MEFF = 0
085400121213     C                   EVAL      STD@MEFF = 0
085500121213    ***
085600121213     C                   EVAL      LIF@MEFF = 0
085700121213     C                   EVAL      ADD@MEFF = 0
085800121213     C                   EVAL      DLF@MEFF = 0
085900121213     C                   EVAL      VLF@MEFF = 0
086000121213     C                   EVAL      VAD@MEFF = 0
086100121213     C                   EVAL      VLT@MEFF = 0
086200121213     C                   EVAL      CRI@MEFF = 0
086300121213     C                   EVAL      VCI@MEFF = 0
086400121213     C                   EVAL      ACC@MEFF = 0
086500121213     C                   EVAL      CCR@MEFF = 0
086600121213    ***
086700121213     C                   EXSR      $FILLMBR
086800121213    ***
086900121213     C                   EXSR      $FILLCOVG
087000121213    ***
087100121213     C                   WRITE     AEBF010
087200121213     C                   ADD       1             #RECCNT
087300121213    ***
087400121213     C                   EVAL      @STEP = 'PREP5'
087500121213    ***
087600121213     C                   ENDSR
087700121213   S***S
087800121213     C     $FILLMBR      BEGSR
087900121213    ***
088000121213     C                   CLEAR                   AEBF010
088100121213    ***
088200121213     C                   EVAL      AEBG = %TRIM(CACID2)
088300121213     C                   EVAL      AESN = %TRIM(CACID1)
088400121213     C                   EVAL      AEEMPCD   = '1'
088500121213    ***
088600121213     C                   EVAL      AELNAM    = %TRIM(MLNAME)
088700121213     C                   EVAL      AEFNAM    = %TRIM(MFNAME)
088800121213     C                   EVAL      AEMNAM    = MMI
088900121213     C                   EVAL      AESSN     = %EDITC(MBSSNO:'X')
089000121213    ***
089100121213     C                   IF        %SUBST(ADDR1:1:1) <> 'X'
089200121213     C                   EVAL      AEADR1    = %TRIM(ADDR1)
089300121213     C                   EVAL      AEADR2    = %TRIM(ADDR2)
089400121213     C                   EVAL      AECITY    = %TRIM(CITY)
089500121213     C                   MOVE      *BLANKS       @9                9
089600121213     C                   EVAL      @9 = %EDITC(ZIP:'X')
089700121213     C                   EVAL      AEZIP     = %SUBST(@9:1:5)
089800121213     C                   EVAL      AESTATE   = STATE
089900121213     C                   EVAL      AECNTRY = 'US'
090000121213     C                   ENDIF
090100121213    ***
090200121213     C                   IF        AREA <> 0
090300121213     C                   EVAL      AEAREA    = %EDITC(AREA:'X')
090400121213     C                   EVAL      AEPHONE   = %EDITC(PHONE:'X')
090500121213     C                   ENDIF
090600121213    ***
090700121213     C                   IF        MBR_TERM = YES
090800121213     C                   EVAL      AERT = 'TRM'
090900121213     C                   EVAL      AETRMRSN  = '01'
091000121213     C                   EVAL      AEEFFDAT  = %CHAR(TERMDT)
091100121213     C                   ELSE
091200121213     C                   EVAL      AERT = 'ENR'
091300121213     C                   EVAL      AETRMRSN  = *BLANKS
091400121213     C                   EVAL      AEEFFDAT  = %CHAR(#TODAY)
091500121213     C                   ENDIF
091600121213    ***
091700121213     C                   EVAL      AESAL = *BLANKS
091800121213     C                   EVAL      AESFLG = *BLANKS
091900121213    ***
092000121213     C                   IF        CACID3 = 'Y'
092100121213     C     SALARY        MULT      100           #SAL             15 0
092200121213     C                   EVAL      AESAL     = %EDITC(#SAL:'X')
092300121213     C                   EVAL      AESFLG = '01'
092400121213     C                   ENDIF
092500121213    ***
092600121213     C                   EVAL      AEGENDER  = SEX
092700121213     C                   EVAL      AEDOB     = %EDITC(BIRTH:'X')
092800121213     C                   EVAL      AEHIREDT  = %EDITC(EMPDT:'X')
092900121213     C                   EVAL      AEENROLL  = %EDITC(MBENRL:'X')
093000121213    ***
093100121213     C                   ENDSR
093200121213   S***S
093300121213     C     $FILLCOVG     BEGSR
093400121213    ***
093500121213     C                   IF        MED#CNE > 0
093600121213      * MEDICAL
093700121213    ***
093800121213     C                   EVAL      @PLANIN = MED@PLN(MED#CNE)
093900121213     C                   EXSR      $QUIK
094000121213     C                   EXSR      $PLANSRCH
094100121213     C                   IF        PLN@CAT = *BLANKS
094200121213     C     'MED FAIL'    DSPLY     '*EXT'
094300121213     C                   SETON                                        H1
094400121213     C                   ENDIF
094500121213      *
094600121213     C                   CLEAR                   AE@@
094700121213     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
094800121213     C                   EVAL      AE@@COV = MED@ENR(MED#CNE)
094900121213     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
095000121213     C                   EVAL      AEMG = %TRIM(CPCID1)
095100130320      *
095200130320     C                   EVAL      #XSX = MED@FRM(MED#CNE)
095300130320     C                   MOVE      #XSX          #SIGN
095400130320     C                   SUBDUR    1:*D          #SIGN
095500130320     C                   MOVE      #SIGN         #XSX
095600130320     C                   EVAL      AE@@DTS = '1'
095700130320     C                   MOVE      #XSX          AE@@SDTE
095800121213      *
095900121213     C                   EVAL      #CANCEL = MED@TRM(MED#CNE)
096000121213     C                   IF        #CANCEL = 99999999
096100121213     C                   EVAL      AE@@BAC = 'ENR'
096200121213     C                   EVAL      #XSX = MED@FRM(MED#CNE)
096300121213     C                   ELSE
096400121213     C                   EVAL      AE@@BAC = 'TRM'
096500121213     C                   EVAL      #XSX = MED@TRM(MED#CNE)
096600121213     C                   ENDIF
096700121213     C                   MOVE      #XSX          AE@@AED
096800121213      *
096900121213     C*                  EVAL      AE@@VOL = MDE@VOL(MED#CNE)
097000121213     C                   EVAL      AE@@DT = '0'
097100121213     C                   EVAL      #XSX = MED@FRM(MED#CNE)
097200121213     C                   MOVE      #XSX          AE@@MDTE
097300121213     C                   ADD       1             NDX
097400121213     C                   EVAL      @@AE(NDX) = AE@@
097500121213      *
097600121213     C                   ENDIF
097700121213    ***
097800121213     C                   IF        DEN#CNE > 0
097900121213      * DENTAL
098000121213     C                   EVAL      @PLANIN = DEN@PLN(DEN#CNE)
098100121213     C                   EXSR      $QUIK
098200121213     C                   EXSR      $PLANSRCH
098300121213     C                   IF        PLN@CAT = *BLANKS
098400121213     C     'DEN FILL'    DSPLY     '*EXT'
098500121213     C                   SETON                                        H1
098600121213     C                   ENDIF
098700121213      *
098800121213     C                   CLEAR                   AE@@
098900121213     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
099000121213     C                   EVAL      AE@@COV = DEN@ENR(DEN#CNE)
099100121213     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
099200121213     C                   EVAL      AEMG = %TRIM(CPCID1)
099300130320      *
099400130320     C                   EVAL      #XSX = DEN@FRM(DEN#CNE)
099500130320     C                   MOVE      #XSX          #SIGN
099600130320     C                   SUBDUR    1:*D          #SIGN
099700130320     C                   MOVE      #SIGN         #XSX
099800130320     C                   EVAL      AE@@DTS = '1'
099900130320     C                   MOVE      #XSX          AE@@SDTE
100000121213      *
100100121213     C                   EVAL      #CANCEL = DEN@TRM(DEN#CNE)
100200121213     C                   IF        #CANCEL = 99999999
100300121213     C                   EVAL      AE@@BAC = 'ENR'
100400121213     C                   EVAL      #XSX = DEN@FRM(DEN#CNE)
100500121213     C                   ELSE
100600121213     C                   EVAL      AE@@BAC = 'TRM'
100700121213     C                   EVAL      #XSX = DEN@TRM(DEN#CNE)
100800121213     C                   ENDIF
100900121213     C                   MOVE      #XSX          AE@@AED
101000121213      *
101100121213     C*                  EVAL      AE@@VOL = DEN@VOL(DEN#CNE)
101200121213     C                   EVAL      AE@@DT = '0'
101300121213     C                   EVAL      #XSX = DEN@FRM(DEN#CNE)
101400121213     C                   MOVE      #XSX          AE@@MDTE
101500121213     C                   ADD       1             NDX
101600121213     C                   EVAL      @@AE(NDX) = AE@@
101700121213      *
101800121213     C                   ENDIF
101900121213    ***
102000121213     C                   IF        RXD#CNE > 0
102100121213      * RXD
102200121213     C                   EVAL      @PLANIN = RXD@PLN(RXD#CNE)
102300121213     C                   EXSR      $QUIK
102400121213     C                   EXSR      $PLANSRCH
102500121213     C                   IF        PLN@CAT = *BLANKS
102600121213     C     'RXD FILL'    DSPLY     '*EXT'
102700121213     C                   SETON                                        H1
102800121213     C                   ENDIF
102900121213      *
103000121213     C                   CLEAR                   AE@@
103100121213     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
103200121213     C                   EVAL      AE@@COV = RXD@ENR(RXD#CNE)
103300121213     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
103400121213     C                   EVAL      AEMG = %TRIM(CPCID1)
103500130320      *
103600130320     C                   EVAL      #XSX = RXD@FRM(RXD#CNE)
103700130320     C                   MOVE      #XSX          #SIGN
103800130320     C                   SUBDUR    1:*D          #SIGN
103900130320     C                   MOVE      #SIGN         #XSX
104000130320     C                   EVAL      AE@@DTS = '1'
104100130320     C                   MOVE      #XSX          AE@@SDTE
104200121213      *
104300121213     C                   EVAL      #CANCEL = RXD@TRM(RXD#CNE)
104400121213     C                   IF        #CANCEL = 99999999
104500121213     C                   EVAL      AE@@BAC = 'ENR'
104600121213     C                   EVAL      #XSX = RXD@FRM(RXD#CNE)
104700121213     C                   ELSE
104800121213     C                   EVAL      AE@@BAC = 'TRM'
104900121213     C                   EVAL      #XSX = RXD@TRM(RXD#CNE)
105000121213     C                   ENDIF
105100121213     C                   MOVE      #XSX          AE@@AED
105200121213      *
105300121213     C*                  EVAL      AE@@VOL = RXD@VOL(RXD#CNE)
105400121213     C                   EVAL      AE@@DT = '0'
105500121213     C                   EVAL      #XSX = RXD@FRM(RXD#CNE)
105600121213     C                   MOVE      #XSX          AE@@MDTE
105700121213     C                   ADD       1             NDX
105800121213     C                   EVAL      @@AE(NDX) = AE@@
105900121213      *
106000121213     C                   ENDIF
106100121213    ***
106200121213     C                   IF        VIS#CNE > 0
106300121213      *  VISION
106400121213     C                   EVAL      @PLANIN = VIS@PLN(VIS#CNE)
106500121213     C                   EVAL      @ENRIN = VIS@ENR(VIS#CNE)
106600121213     C                   EXSR      $QUIK
106700121213     C                   EXSR      $PLANSRCH
106800121213     C                   IF        PLN@CAT = *BLANKS
106900121213     C     'VIS FILL'    DSPLY     '*EXT'
107000121213     C                   SETON                                        H1
107100121213     C                   ENDIF
107200121213      *
107300121213     C                   CLEAR                   AE@@
107400121213     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
107500121213     C                   EVAL      AE@@COV = VIS@ENR(VIS#CNE)
107600121213     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
107700121213     C                   EVAL      AEMG = %TRIM(CPCID1)
107800130320      *
107900130320     C                   EVAL      #XSX = VIS@FRM(VIS#CNE)
108000130320     C                   MOVE      #XSX          #SIGN
108100130320     C                   SUBDUR    1:*D          #SIGN
108200130320     C                   MOVE      #SIGN         #XSX
108300130320     C                   EVAL      AE@@DTS = '1'
108400130320     C                   MOVE      #XSX          AE@@SDTE
108500121213      *
108600121213     C                   EVAL      #CANCEL = VIS@TRM(VIS#CNE)
108700121213     C                   IF        #CANCEL = 99999999
108800121213     C                   EVAL      AE@@BAC = 'ENR'
108900121213     C                   EVAL      #XSX = VIS@FRM(VIS#CNE)
109000121213     C                   ELSE
109100121213     C                   EVAL      AE@@BAC = 'TRM'
109200121213     C                   EVAL      #XSX = VIS@TRM(VIS#CNE)
109300121213     C                   ENDIF
109400121213     C                   MOVE      #XSX          AE@@AED
109500121213      *
109600121213     C*                  EVAL      AE@@VOL = VIS@VOL(VIS#CNE)
109700121213     C                   EVAL      AE@@DT = '0'
109800121213     C                   EVAL      #XSX = VIS@FRM(VIS#CNE)
109900121213     C                   MOVE      #XSX          AE@@MDTE
110000121213     C                   ADD       1             NDX
110100121213     C                   EVAL      @@AE(NDX) = AE@@
110200121213      *
110300121213     C                   ENDIF
110400121213    ***
110500121213     C                   IF        LTD#CNE > 0 AND WRT@TYPE = 'MEMBER'
110600121213      * LTD
110700121213     C                   EVAL      @PLANIN = LTD@PLN(LTD#CNE)
110800121213     C                   EVAL      @ENRIN = LTD@ENR(LTD#CNE)
110900121213     C                   EXSR      $QUIK
111000121213     C                   EXSR      $PLANSRCH
111100121213     C                   IF        PLN@CAT = *BLANKS
111200121213     C     'LTD FILL'    DSPLY     '*EXT'
111300121213     C                   SETON                                        H1
111400121213     C                   ENDIF
111500121213      *
111600121213     C                   CLEAR                   AE@@
111700121213     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
111800121213     C                   EVAL      AE@@COV = LTD@ENR(LTD#CNE)
111900121213     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
112000121213     C                   EVAL      AEMG = %TRIM(CPCID1)
112100130320      *
112200130320     C                   EVAL      #XSX = LTD@FRM(LTD#CNE)
112300130320     C                   MOVE      #XSX          #SIGN
112400130320     C                   SUBDUR    1:*D          #SIGN
112500130320     C                   MOVE      #SIGN         #XSX
112600130320     C                   EVAL      AE@@DTS = '1'
112700130320     C                   MOVE      #XSX          AE@@SDTE
112800121213      *
112900121213     C                   EVAL      #CANCEL = LTD@TRM(LTD#CNE)
113000121213     C                   IF        #CANCEL = 99999999
113100121213     C                   EVAL      AE@@BAC = 'ENR'
113200121213     C                   EVAL      #XSX = LTD@FRM(LTD#CNE)
113300121213     C                   ELSE
113400121213     C                   EVAL      AE@@BAC = 'TRM'
113500121213     C                   EVAL      #XSX = LTD@TRM(LTD#CNE)
113600121213     C                   ENDIF
113700121213     C                   MOVE      #XSX          AE@@AED
113800121213      *
113900121213     C                   IF        CPCID6 = 'Y'
114000121213     C                   EVAL      #7S0 = LTD@VOL(LTD#CNE)
114100121213     C     #7S0          MULT      100           #15S0
114200121213     C                   MOVE      #15S0         AE@@VOL
114300121213     C                   ELSE
114400121213     C                   EVAL      AE@@VOL = *BLANKS
114500121213     C                   ENDIF
114600121213      *
114700121213     C                   EVAL      AE@@DT = '0'
114800121213     C                   EVAL      #XSX = LTD@FRM(LTD#CNE)
114900121213     C                   MOVE      #XSX          AE@@MDTE
115000121213     C                   ADD       1             NDX
115100121213     C                   EVAL      @@AE(NDX) = AE@@
115200121213      *
115300121213     C                   ENDIF
115400121213    ***
115500121213     C                   IF        STD#CNE > 0 AND WRT@TYPE = 'MEMBER'
115600121213      * STD
115700121213     C                   EVAL      @PLANIN = STD@PLN(STD#CNE)
115800121213     C                   EVAL      @ENRIN = STD@ENR(STD#CNE)
115900121213     C                   EXSR      $QUIK
116000121213     C                   EXSR      $PLANSRCH
116100121213     C                   IF        PLN@CAT = *BLANKS
116200121213     C     'STD FILL'    DSPLY     '*EXT'
116300121213     C                   SETON                                        H1
116400121213     C                   ENDIF
116500121213      *
116600121213     C                   CLEAR                   AE@@
116700121213     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
116800121213     C                   EVAL      AE@@COV = STD@ENR(STD#CNE)
116900121213     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
117000121213     C                   EVAL      AEMG = %TRIM(CPCID1)
117100130320      *
117200130320     C                   EVAL      #XSX = STD@FRM(STD#CNE)
117300130320     C                   MOVE      #XSX          #SIGN
117400130320     C                   SUBDUR    1:*D          #SIGN
117500130320     C                   MOVE      #SIGN         #XSX
117600130320     C                   EVAL      AE@@DTS = '1'
117700130320     C                   MOVE      #XSX          AE@@SDTE
117800121213      *
117900121213     C                   EVAL      #CANCEL = STD@TRM(STD#CNE)
118000121213     C                   IF        #CANCEL = 99999999
118100121213     C                   EVAL      AE@@BAC = 'ENR'
118200121213     C                   EVAL      #XSX = STD@FRM(STD#CNE)
118300121213     C                   ELSE
118400121213     C                   EVAL      AE@@BAC = 'TRM'
118500121213     C                   EVAL      #XSX = STD@TRM(STD#CNE)
118600121213     C                   ENDIF
118700121213     C                   MOVE      #XSX          AE@@AED
118800121213      *
118900121213     C                   IF        CPCID6 = 'Y'
119000121213     C                   EVAL      #7S0 = STD@VOL(STD#CNE)
119100121213     C     #7S0          MULT      100           #15S0
119200121213     C                   MOVE      #15S0         AE@@VOL
119300121213     C                   ELSE
119400121213     C                   EVAL      AE@@VOL = *BLANKS
119500121213     C                   ENDIF
119600121213      *
119700121213     C                   EVAL      AE@@DT = '0'
119800121213     C                   EVAL      #XSX = STD@FRM(STD#CNE)
119900121213     C                   MOVE      #XSX          AE@@MDTE
120000121213     C                   ADD       1             NDX
120100121213     C                   EVAL      @@AE(NDX) = AE@@
120200121213      *
120300121213     C                   ENDIF
120400121213    ***
120500121213     C                   IF        LIF#CNE > 0 AND WRT@TYPE = 'MEMBER'
120600121213      * BASIC LIFE
120700121213     C                   EVAL      @PLANIN = LIF@PLN(LIF#CNE)
120800121213     C                   EVAL      @ENRIN = LIF@ENR(LIF#CNE)
120900121213     C                   EXSR      $QUIK
121000121213     C                   EXSR      $PLANSRCH
121100121213     C                   IF        PLN@CAT = *BLANKS
121200121213     C     'LIF FILL'    DSPLY     '*EXT'
121300121213     C                   SETON                                        H1
121400121213     C                   ENDIF
121500121213      *
121600121213     C                   CLEAR                   AE@@
121700121213     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
121800121213     C                   EVAL      AE@@COV = LIF@ENR(LIF#CNE)
121900121213     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
122000121213     C                   EVAL      AEMG = %TRIM(CPCID1)
122100130320      *
122200130320     C                   EVAL      #XSX = LIF@FRM(LIF#CNE)
122300130320     C                   MOVE      #XSX          #SIGN
122400130320     C                   SUBDUR    1:*D          #SIGN
122500130320     C                   MOVE      #SIGN         #XSX
122600130320     C                   EVAL      AE@@DTS = '1'
122700130320     C                   MOVE      #XSX          AE@@SDTE
122800121213      *
122900121213     C                   EVAL      #CANCEL = LIF@TRM(LIF#CNE)
123000121213     C                   IF        #CANCEL = 99999999
123100121213     C                   EVAL      AE@@BAC = 'ENR'
123200121213     C                   EVAL      #XSX = LIF@FRM(LIF#CNE)
123300121213     C                   ELSE
123400121213     C                   EVAL      AE@@BAC = 'TRM'
123500121213     C                   EVAL      #XSX = LIF@TRM(LIF#CNE)
123600121213     C                   ENDIF
123700121213     C                   MOVE      #XSX          AE@@AED
123800121213      *
123900121213     C                   IF        CPCID6 = 'Y'
124000121213     C                   EVAL      #7S0 = LIF@VOL(LIF#CNE)
124100121213     C     #7S0          MULT      100           #15S0
124200121213     C                   MOVE      #15S0         AE@@VOL
124300121213     C                   ELSE
124400121213     C                   EVAL      AE@@VOL = *BLANKS
124500121213     C                   ENDIF
124600121213      *
124700121213     C                   EVAL      AE@@DT = '0'
124800121213     C                   EVAL      #XSX = LIF@FRM(LIF#CNE)
124900121213     C                   MOVE      #XSX          AE@@MDTE
125000121213     C                   ADD       1             NDX
125100121213     C                   EVAL      @@AE(NDX) = AE@@
125200121213      *
125300121213     C                   ENDIF
125400121213    ***
125500121213     C                   IF        ADD#CNE > 0 AND WRT@TYPE = 'MEMBER'
125600121213      * BASIC AD&D
125700121213     C                   EVAL      @PLANIN = ADD@PLN(ADD#CNE)
125800121213     C                   EVAL      @ENRIN = ADD@ENR(ADD#CNE)
125900121213     C                   EXSR      $QUIK
126000121213     C                   EXSR      $PLANSRCH
126100121213     C                   IF        PLN@CAT = *BLANKS
126200121213     C     'ADD FILL'    DSPLY     '*EXT'
126300121213     C                   SETON                                        H1
126400121213     C                   ENDIF
126500121213      *
126600121213     C                   CLEAR                   AE@@
126700121213     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
126800121213     C                   EVAL      AE@@COV = ADD@ENR(ADD#CNE)
126900121213     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
127000121213     C                   EVAL      AEMG = %TRIM(CPCID1)
127100130320      *
127200130320     C                   EVAL      #XSX = ADD@FRM(ADD#CNE)
127300130320     C                   MOVE      #XSX          #SIGN
127400130320     C                   SUBDUR    1:*D          #SIGN
127500130320     C                   MOVE      #SIGN         #XSX
127600130320     C                   EVAL      AE@@DTS = '1'
127700130320     C                   MOVE      #XSX          AE@@SDTE
127800121213      *
127900121213     C                   EVAL      #CANCEL = ADD@TRM(ADD#CNE)
128000121213     C                   IF        #CANCEL = 99999999
128100121213     C                   EVAL      AE@@BAC = 'ENR'
128200121213     C                   EVAL      #XSX = ADD@FRM(ADD#CNE)
128300121213     C                   ELSE
128400121213     C                   EVAL      AE@@BAC = 'TRM'
128500121213     C                   EVAL      #XSX = ADD@TRM(ADD#CNE)
128600121213     C                   ENDIF
128700121213     C                   MOVE      #XSX          AE@@AED
128800121213      *
128900121213     C                   IF        CPCID6 = 'Y'
129000121213     C                   EVAL      #7S0 = ADD@VOL(ADD#CNE)
129100121213     C     #7S0          MULT      100           #15S0
129200121213     C                   MOVE      #15S0         AE@@VOL
129300121213     C                   ELSE
129400121213     C                   EVAL      AE@@VOL = *BLANKS
129500121213     C                   ENDIF
129600121213      *
129700121213     C                   EVAL      AE@@DT = '0'
129800121213     C                   EVAL      #XSX = ADD@FRM(ADD#CNE)
129900121213     C                   MOVE      #XSX          AE@@MDTE
130000121213     C                   ADD       1             NDX
130100121213     C                   EVAL      @@AE(NDX) = AE@@
130200121213      *
130300121213     C                   ENDIF
130400121213    ***
130500121213     C                   IF        DLF#CNE > 0
130600121213      * DEPENDENT LIFE
130700121213     C                   EVAL      @PLANIN = DLF@PLN(DLF#CNE)
130800121213     C                   EVAL      @ENRIN = DLF@ENR(DLF#CNE)
130900121213     C                   EXSR      $QUIK
131000121213     C                   EXSR      $PLANSRCH
131100121213     C                   IF        PLN@CAT = *BLANKS
131200121213     C     'DLF FILL'    DSPLY     '*EXT'
131300121213     C                   SETON                                        H1
131400121213     C                   ENDIF
131500121213      *
131600121213     C                   CLEAR                   AE@@
131700121213     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
131800121213     C                   EVAL      AE@@COV = DLF@ENR(DLF#CNE)
131900121213     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
132000121213     C                   EVAL      AEMG = %TRIM(CPCID1)
132100130320      *
132200130320     C                   EVAL      #XSX = DLF@FRM(DLF#CNE)
132300130320     C                   MOVE      #XSX          #SIGN
132400130320     C                   SUBDUR    1:*D          #SIGN
132500130320     C                   MOVE      #SIGN         #XSX
132600130320     C                   EVAL      AE@@DTS = '1'
132700130320     C                   MOVE      #XSX          AE@@SDTE
132800121213      *
132900121213     C                   EVAL      #CANCEL = DLF@TRM(DLF#CNE)
133000121213     C                   IF        #CANCEL = 99999999
133100121213     C                   EVAL      AE@@BAC = 'ENR'
133200121213     C                   EVAL      #XSX = DLF@FRM(DLF#CNE)
133300121213     C                   ELSE
133400121213     C                   EVAL      AE@@BAC = 'TRM'
133500121213     C                   EVAL      #XSX = DLF@TRM(DLF#CNE)
133600121213     C                   ENDIF
133700121213     C                   MOVE      #XSX          AE@@AED
133800121213      *
133900121213     C                   IF        CPCID6 = 'Y'
134000121213     C                   EVAL      #7S0 = DLF@VOL(DLF#CNE)
134100121213     C     #7S0          MULT      100           #15S0
134200121213     C                   MOVE      #15S0         AE@@VOL
134300121213     C                   ELSE
134400121213     C                   EVAL      AE@@VOL = *BLANKS
134500121213     C                   ENDIF
134600121213      *
134700121213     C                   EVAL      AE@@DT = '0'
134800121213     C                   EVAL      #XSX = DLF@FRM(DLF#CNE)
134900121213     C                   MOVE      #XSX          AE@@MDTE
135000121213     C                   ADD       1             NDX
135100121213     C                   EVAL      @@AE(NDX) = AE@@
135200121213      *
135300121213     C                   ENDIF
135400121213    ***
135500121213     C                   IF        VLF#CNE > 0
135600121213      * VOL LIFE
135700121213     C                   EVAL      @PLANIN = VLF@PLN(VLF#CNE)
135800121213     C                   EVAL      @ENRIN = VLF@ENR(VLF#CNE)
135900121213     C                   EXSR      $QUIK
136000121213     C                   EXSR      $PLANSRCH
136100121213     C                   IF        PLN@CAT = *BLANKS
136200121213     C     'VLF FILL'    DSPLY     '*EXT'
136300121213     C                   SETON                                        H1
136400121213     C                   ENDIF
136500121213      *
136600121213     C                   CLEAR                   AE@@
136700121213     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
136800121213     C                   EVAL      AE@@COV = VLF@ENR(VLF#CNE)
136900121213     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
137000121213     C                   EVAL      AEMG = %TRIM(CPCID1)
137100130320      *
137200130320     C                   EVAL      #XSX = VLF@FRM(VLF#CNE)
137300130320     C                   MOVE      #XSX          #SIGN
137400130320     C                   SUBDUR    1:*D          #SIGN
137500130320     C                   MOVE      #SIGN         #XSX
137600130320     C                   EVAL      AE@@DTS = '1'
137700130320     C                   MOVE      #XSX          AE@@SDTE
137800121213      *
137900121213     C                   EVAL      #CANCEL = VLF@TRM(VLF#CNE)
138000121213     C                   IF        #CANCEL = 99999999
138100121213     C                   EVAL      AE@@BAC = 'ENR'
138200121213     C                   EVAL      #XSX = VLF@FRM(VLF#CNE)
138300121213     C                   ELSE
138400121213     C                   EVAL      AE@@BAC = 'TRM'
138500121213     C                   EVAL      #XSX = VLF@TRM(VLF#CNE)
138600121213     C                   ENDIF
138700121213     C                   MOVE      #XSX          AE@@AED
138800121213      *
138900121213     C                   IF        CPCID6 = 'Y'
139000121213     C                   EVAL      #7S0 = VLF@VOL(VLF#CNE)
139100121213     C     #7S0          MULT      100           #15S0
139200121213     C                   MOVE      #15S0         AE@@VOL
139300121213     C                   ELSE
139400121213     C                   EVAL      AE@@VOL = *BLANKS
139500121213     C                   ENDIF
139600121213      *
139700121213     C                   EVAL      AE@@DT = '0'
139800121213     C                   EVAL      #XSX = VLF@FRM(VLF#CNE)
139900121213     C                   MOVE      #XSX          AE@@MDTE
140000121213     C                   ADD       1             NDX
140100121213     C                   EVAL      @@AE(NDX) = AE@@
140200121213      *
140300121213     C                   ENDIF
140400121213    ***
140500121213     C                   IF        VAD#CNE > 0
140600121213      * VOLUNTARY AD&D
140700121213     C                   EVAL      @PLANIN = VAD@PLN(VAD#CNE)
140800121213     C                   EVAL      @ENRIN = VAD@ENR(VAD#CNE)
140900121213     C                   EXSR      $QUIK
141000121213     C                   EXSR      $PLANSRCH
141100121213     C                   IF        PLN@CAT = *BLANKS
141200121213     C     'VAD FILL'    DSPLY     '*EXT'
141300121213     C                   SETON                                        H1
141400121213     C                   ENDIF
141500121213      *
141600121213     C                   CLEAR                   AE@@
141700121213     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
141800121213     C                   EVAL      AE@@COV = VAD@ENR(VAD#CNE)
141900121213     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
142000121213     C                   EVAL      AEMG = %TRIM(CPCID1)
142100130320      *
142200130320     C                   EVAL      #XSX = VAD@FRM(VAD#CNE)
142300130320     C                   MOVE      #XSX          #SIGN
142400130320     C                   SUBDUR    1:*D          #SIGN
142500130320     C                   MOVE      #SIGN         #XSX
142600130320     C                   EVAL      AE@@DTS = '1'
142700130320     C                   MOVE      #XSX          AE@@SDTE
142800121213      *
142900121213     C                   EVAL      #CANCEL = VAD@TRM(VAD#CNE)
143000121213     C                   IF        #CANCEL = 99999999
143100121213     C                   EVAL      AE@@BAC = 'ENR'
143200121213     C                   EVAL      #XSX = VAD@FRM(VAD#CNE)
143300121213     C                   ELSE
143400121213     C                   EVAL      AE@@BAC = 'TRM'
143500121213     C                   EVAL      #XSX = VAD@TRM(VAD#CNE)
143600121213     C                   ENDIF
143700121213     C                   MOVE      #XSX          AE@@AED
143800121213      *
143900121213     C                   IF        CPCID6 = 'Y'
144000121213     C                   EVAL      #7S0 = VAD@VOL(VAD#CNE)
144100121213     C     #7S0          MULT      100           #15S0
144200121213     C                   MOVE      #15S0         AE@@VOL
144300121213     C                   ELSE
144400121213     C                   EVAL      AE@@VOL = *BLANKS
144500121213     C                   ENDIF
144600121213      *
144700121213     C                   EVAL      AE@@DT = '0'
144800121213     C                   EVAL      #XSX = VAD@FRM(VAD#CNE)
144900121213     C                   MOVE      #XSX          AE@@MDTE
145000121213     C                   ADD       1             NDX
145100121213     C                   EVAL      @@AE(NDX) = AE@@
145200121213      *
145300121213     C                   ENDIF
145400121213    ***
145500121213     C                   IF        VLT#CNE > 0
145600121213      * VOL LTD
145700121213     C                   EVAL      @PLANIN = VLT@PLN(VLT#CNE)
145800121213     C                   EVAL      @ENRIN = VLT@ENR(VLT#CNE)
145900121213     C                   EXSR      $QUIK
146000121213     C                   EXSR      $PLANSRCH
146100121213     C                   IF        PLN@CAT = *BLANKS
146200121213     C     'VLT FILL'    DSPLY     '*EXT'
146300121213     C                   SETON                                        H1
146400121213     C                   ENDIF
146500121213      *
146600121213     C                   CLEAR                   AE@@
146700121213     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
146800121213     C                   EVAL      AE@@COV = VLT@ENR(VLT#CNE)
146900121213     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
147000121213     C                   EVAL      AEMG = %TRIM(CPCID1)
147100130320      *
147200130320     C                   EVAL      #XSX = VLT@FRM(VLT#CNE)
147300130320     C                   MOVE      #XSX          #SIGN
147400130320     C                   SUBDUR    1:*D          #SIGN
147500130320     C                   MOVE      #SIGN         #XSX
147600130320     C                   EVAL      AE@@DTS = '1'
147700130320     C                   MOVE      #XSX          AE@@SDTE
147800121213      *
147900121213     C                   EVAL      #CANCEL = VLT@TRM(VLT#CNE)
148000121213     C                   IF        #CANCEL = 99999999
148100121213     C                   EVAL      AE@@BAC = 'ENR'
148200121213     C                   EVAL      #XSX = VLT@FRM(VLT#CNE)
148300121213     C                   ELSE
148400121213     C                   EVAL      AE@@BAC = 'TRM'
148500121213     C                   EVAL      #XSX = VLT@TRM(VLT#CNE)
148600121213     C                   ENDIF
148700121213     C                   MOVE      #XSX          AE@@AED
148800121213      *
148900121213     C                   IF        CPCID6 = 'Y'
149000121213     C                   EVAL      #7S0 = VLT@VOL(VLT#CNE)
149100121213     C     #7S0          MULT      100           #15S0
149200121213     C                   MOVE      #15S0         AE@@VOL
149300121213     C                   ELSE
149400121213     C                   EVAL      AE@@VOL = *BLANKS
149500121213     C                   ENDIF
149600121213      *
149700121213     C                   EVAL      AE@@DT = '0'
149800121213     C                   EVAL      #XSX = VLT@FRM(VLT#CNE)
149900121213     C                   MOVE      #XSX          AE@@MDTE
150000121213     C                   ADD       1             NDX
150100121213     C                   EVAL      @@AE(NDX) = AE@@
150200121213      *
150300121213     C                   ENDIF
150400121213    ***
150500121213     C                   IF        CRI#CNE > 0
150600121213      * CRITICAL ILLNESS
150700121213     C                   EVAL      @PLANIN = CRI@PLN(CRI#CNE)
150800121213     C                   EVAL      @ENRIN = CRI@ENR(CRI#CNE)
150900121213     C                   EXSR      $QUIK
151000121213     C                   EXSR      $PLANSRCH
151100121213     C                   IF        PLN@CAT = *BLANKS
151200121213     C     'CRI FILL'    DSPLY     '*EXT'
151300121213     C                   SETON                                        H1
151400121213     C                   ENDIF
151500121213      *
151600121213     C                   CLEAR                   AE@@
151700121213     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
151800121213     C                   EVAL      AE@@COV = CRI@ENR(CRI#CNE)
151900121213     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
152000121213     C                   EVAL      AEMG = %TRIM(CPCID1)
152100130320      *
152200130320     C                   EVAL      #XSX = CRI@FRM(CRI#CNE)
152300130320     C                   MOVE      #XSX          #SIGN
152400130320     C                   SUBDUR    1:*D          #SIGN
152500130320     C                   MOVE      #SIGN         #XSX
152600130320     C                   EVAL      AE@@DTS = '1'
152700130320     C                   MOVE      #XSX          AE@@SDTE
152800121213      *
152900121213     C                   EVAL      #CANCEL = CRI@TRM(CRI#CNE)
153000121213     C                   IF        #CANCEL = 99999999
153100121213     C                   EVAL      AE@@BAC = 'ENR'
153200121213     C                   EVAL      #XSX = CRI@FRM(CRI#CNE)
153300121213     C                   ELSE
153400121213     C                   EVAL      AE@@BAC = 'TRM'
153500121213     C                   EVAL      #XSX = CRI@TRM(CRI#CNE)
153600121213     C                   ENDIF
153700121213     C                   MOVE      #XSX          AE@@AED
153800121213      *
153900121213     C                   IF        CPCID6 = 'Y'
154000121213     C                   EVAL      #7S0 = CRI@VOL(CRI#CNE)
154100121213     C     #7S0          MULT      100           #15S0
154200121213     C                   MOVE      #15S0         AE@@VOL
154300121213     C                   ELSE
154400121213     C                   EVAL      AE@@VOL = *BLANKS
154500121213     C                   ENDIF
154600121213      *
154700121213     C                   EVAL      AE@@DT = '0'
154800121213     C                   EVAL      #XSX = CRI@FRM(CRI#CNE)
154900121213     C                   MOVE      #XSX          AE@@MDTE
155000121213     C                   ADD       1             NDX
155100121213     C                   EVAL      @@AE(NDX) = AE@@
155200121213      *
155300121213     C                   ENDIF
155400121213    ***
155500121213     C                   IF        VCI#CNE > 0
155600121213      * VOL CRITICAL ILLNESS
155700121213     C                   EVAL      @PLANIN = VCI@PLN(VCI#CNE)
155800121213     C                   EVAL      @ENRIN = VCI@ENR(VCI#CNE)
155900121213     C                   EXSR      $QUIK
156000121213     C                   EXSR      $PLANSRCH
156100121213     C                   IF        PLN@CAT = *BLANKS
156200121213     C     'VCI FILL'    DSPLY     '*EXT'
156300121213     C                   SETON                                        H1
156400121213     C                   ENDIF
156500121213      *
156600121213     C                   CLEAR                   AE@@
156700121213     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
156800121213     C                   EVAL      AE@@COV = VCI@ENR(VCI#CNE)
156900121213     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
157000121213     C                   EVAL      AEMG = %TRIM(CPCID1)
157100130320      *
157200130320     C                   EVAL      #XSX = VCI@FRM(VCI#CNE)
157300130320     C                   MOVE      #XSX          #SIGN
157400130320     C                   SUBDUR    1:*D          #SIGN
157500130320     C                   MOVE      #SIGN         #XSX
157600130320     C                   EVAL      AE@@DTS = '1'
157700130320     C                   MOVE      #XSX          AE@@SDTE
157800121213      *
157900121213     C                   EVAL      #CANCEL = VCI@TRM(VCI#CNE)
158000121213     C                   IF        #CANCEL = 99999999
158100121213     C                   EVAL      AE@@BAC = 'ENR'
158200121213     C                   EVAL      #XSX = VCI@FRM(VCI#CNE)
158300121213     C                   ELSE
158400121213     C                   EVAL      AE@@BAC = 'TRM'
158500121213     C                   EVAL      #XSX = VCI@TRM(VCI#CNE)
158600121213     C                   ENDIF
158700121213     C                   MOVE      #XSX          AE@@AED
158800121213      *
158900121213     C                   IF        CPCID6 = 'Y'
159000121213     C                   EVAL      #7S0 = VCI@VOL(VCI#CNE)
159100121213     C     #7S0          MULT      100           #15S0
159200121213     C                   MOVE      #15S0         AE@@VOL
159300121213     C                   ELSE
159400121213     C                   EVAL      AE@@VOL = *BLANKS
159500121213     C                   ENDIF
159600121213      *
159700121213     C                   EVAL      AE@@DT = '0'
159800121213     C                   EVAL      #XSX = VCI@FRM(VCI#CNE)
159900121213     C                   MOVE      #XSX          AE@@MDTE
160000121213     C                   ADD       1             NDX
160100121213     C                   EVAL      @@AE(NDX) = AE@@
160200121213      *
160300121213     C                   ENDIF
160400121213    ***
160500121213     C                   IF        ACC#CNE > 0
160600121213      * ACCIDENT COVERAGE
160700121213     C                   EVAL      @PLANIN = ACC@PLN(ACC#CNE)
160800121213     C                   EVAL      @ENRIN = ACC@ENR(ACC#CNE)
160900121213     C                   EXSR      $QUIK
161000121213     C                   EXSR      $PLANSRCH
161100121213     C                   IF        PLN@CAT = *BLANKS
161200121213     C     'ACC FILL'    DSPLY     '*EXT'
161300121213     C                   SETON                                        H1
161400121213     C                   ENDIF
161500121213      *
161600121213     C                   CLEAR                   AE@@
161700121213     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
161800121213     C                   EVAL      AE@@COV = ACC@ENR(ACC#CNE)
161900121213     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
162000121213     C                   EVAL      AEMG = %TRIM(CPCID1)
162100130320      *
162200130320     C                   EVAL      #XSX = ACC@FRM(ACC#CNE)
162300130320     C                   MOVE      #XSX          #SIGN
162400130320     C                   SUBDUR    1:*D          #SIGN
162500130320     C                   MOVE      #SIGN         #XSX
162600130320     C                   EVAL      AE@@DTS = '1'
162700130320     C                   MOVE      #XSX          AE@@SDTE
162800121213      *
162900121213     C                   EVAL      #CANCEL = ACC@TRM(ACC#CNE)
163000121213     C                   IF        #CANCEL = 99999999
163100121213     C                   EVAL      AE@@BAC = 'ENR'
163200121213     C                   EVAL      #XSX = ACC@FRM(ACC#CNE)
163300121213     C                   ELSE
163400121213     C                   EVAL      AE@@BAC = 'TRM'
163500121213     C                   EVAL      #XSX = ACC@TRM(ACC#CNE)
163600121213     C                   ENDIF
163700121213     C                   MOVE      #XSX          AE@@AED
163800121213      *
163900121213     C                   IF        CPCID6 = 'Y'
164000121213     C                   EVAL      #7S0 = ACC@VOL(ACC#CNE)
164100121213     C     #7S0          MULT      100           #15S0
164200121213     C                   MOVE      #15S0         AE@@VOL
164300121213     C                   ELSE
164400121213     C                   EVAL      AE@@VOL = *BLANKS
164500121213     C                   ENDIF
164600121213      *
164700121213     C                   EVAL      AE@@DT = '0'
164800121213     C                   EVAL      #XSX = ACC@FRM(ACC#CNE)
164900121213     C                   MOVE      #XSX          AE@@MDTE
165000121213     C                   ADD       1             NDX
165100121213     C                   EVAL      @@AE(NDX) = AE@@
165200121213      *
165300121213     C                   ENDIF
165400121213    ***
165500121213     C                   IF        CCR#CNE > 0
165600121213      * CANCER COVERAGE
165700121213     C                   EVAL      @PLANIN = CCR@PLN(CCR#CNE)
165800121213     C                   EVAL      @ENRIN = CCR@ENR(CCR#CNE)
165900121213     C                   EXSR      $QUIK
166000121213     C                   EXSR      $PLANSRCH
166100121213     C                   IF        PLN@CAT = *BLANKS
166200121213     C     'CCR FILL'    DSPLY     '*EXT'
166300121213     C                   SETON                                        H1
166400121213     C                   ENDIF
166500121213      *
166600121213     C                   CLEAR                   AE@@
166700121213     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
166800121213     C                   EVAL      AE@@COV = CCR@ENR(CCR#CNE)
166900121213     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
167000121213     C                   EVAL      AEMG = %TRIM(CPCID1)
167100130320      *
167200130320     C                   EVAL      #XSX = CCR@FRM(CCR#CNE)
167300130320     C                   MOVE      #XSX          #SIGN
167400130320     C                   SUBDUR    1:*D          #SIGN
167500130320     C                   MOVE      #SIGN         #XSX
167600130320     C                   EVAL      AE@@DTS = '1'
167700130320     C                   MOVE      #XSX          AE@@SDTE
167800121213      *
167900121213     C                   EVAL      #CANCEL = CCR@TRM(CCR#CNE)
168000121213     C                   IF        #CANCEL = 99999999
168100121213     C                   EVAL      AE@@BAC = 'ENR'
168200121213     C                   EVAL      #XSX = CCR@FRM(CCR#CNE)
168300121213     C                   ELSE
168400121213     C                   EVAL      AE@@BAC = 'TRM'
168500121213     C                   EVAL      #XSX = CCR@TRM(CCR#CNE)
168600121213     C                   ENDIF
168700121213     C                   MOVE      #XSX          AE@@AED
168800121213      *
168900121213     C                   IF        CPCID6 = 'Y'
169000121213     C                   EVAL      #7S0 = CCR@VOL(CCR#CNE)
169100121213     C     #7S0          MULT      100           #15S0
169200121213     C                   MOVE      #15S0         AE@@VOL
169300121213     C                   ELSE
169400121213     C                   EVAL      AE@@VOL = *BLANKS
169500121213     C                   ENDIF
169600121213      *
169700121213     C                   EVAL      AE@@DT = '0'
169800121213     C                   EVAL      #XSX = CCR@FRM(CCR#CNE)
169900121213     C                   MOVE      #XSX          AE@@MDTE
170000121213     C                   ADD       1             NDX
170100121213     C                   EVAL      @@AE(NDX) = AE@@
170200121213      *
170300121213     C                   ENDIF
170400121213    ***
170500121213     C                   ENDSR
170600121213   S***S
170700121213     C     $PREP5        BEGSR
170800121213    ***
170900121213     C     KF@SSN        CHAIN     DEPENR
171000121213     C                   IF        NOT %FOUND(DEPNDC)
171100121213     C                   EVAL      @STEP = 'STEP2'
171200121213     C                   LEAVESR
171300121213     C                   ENDIF
171400121213    ***
171500121213     C     KF@SSN        SETLL     DEPENR
171600121213    ***
171700121213     C                   EVAL      @STEP = 'STEP5'
171800121213    ***
171900121213     C                   ENDSR
172000121213   S***S
172100121213     C     $STEP5        BEGSR
172200121213    ***
172300121213     C     KF@SSN        READE     DEPENR
172400121213    ***
172500121213     C                   IF        %EOF(DEPNDC)
172600121213     C                   EVAL      @STEP = 'STEP2'
172700121213     C                   LEAVESR
172800121213     C                   ENDIF
172900121213    ***
173000121213     C                   EVAL      KF@SEQ = DPSEQ#
173100121213    ***
173200121213     C     KL#DCV        CHAIN     DCOVR
173300121213     C                   IF        NOT %FOUND(ELIGDCOV)
173400121213     C                   LEAVESR
173500121213     C                   ENDIF
173600121213    ***
173700121213     C                   EXSR      $CLRSTG
173800121213    ***
173900121213     C     KL#DCV        SETLL     DCOVR
174000121213    ***
174100121213     C                   EVAL      @STEP = 'STEP6'
174200121213    ***
174300121213     C                   ENDSR
174400121213   S***S
174500121213     C     $STEP6        BEGSR
174600121213    ***
174700121213     C     KL#DCV        READE     DCOVR
174800121213    ***
174900121213     C                   IF        %EOF(ELIGDCOV)
175000121213     C                   EVAL      @STEP = 'PREP7'
175100121213     C                   LEAVESR
175200121213     C                   ENDIF
175300121213    ***
175400121213     C                   EVAL      @PLANIN = DVPLAN
175500121213     C                   EVAL      @ENRIN = DVENRL
175600121213     C                   EVAL      #EFFDTE = DENRDT
175700121213     C                   EVAL      #CANCEL = CCANDT
175800121213    ***
175900121213     C                   EVAL      #BENAMT = 0
176000121213     *** OR
176100121213     C                   EVAL      #BENAMT = DVVOL
176200121213    ***
176300121213     C                   EXSR      $QUIK
176400121213    ***
176500121213     C                   EXSR      $PLANSRCH
176600121213    ***
176700121213     C                   IF        PLN@CAT = *BLANKS
176800121213     C                   LEAVESR
176900121213     C                   ENDIF
177000121213    ***
177100121213     C                   EXSR      $TIERLVL
177200121213    ***
177300121213     C                   IF        #CANCEL = 0
177400121213     C                   EVAL      #CANCEL = 99999999
177500121213     C                   ENDIF
177600121213    ***
177700121213     C                   EXSR      $AD2MARY
177800121213    ***
177900121213     C                   ENDSR
178000121213   S***S
178100121213     C     $PREP7        BEGSR
178200121213    ***
178300121213     C                   IF        LIF#CNE  = 0 AND MED#CNE  = 0 AND
178400121213     C                             ADD#CNE  = 0 AND DEN#CNE  = 0 AND
178500121213     C                             DLF#CNE  = 0 AND RXD#CNE  = 0 AND
178600121213     C                             VLF#CNE  = 0 AND VIS#CNE  = 0 AND
178700121213     C                             VAD#CNE  = 0 AND LTD#CNE  = 0 AND
178800121213     C                             VLT#CNE  = 0 AND STD#CNE  = 0 AND
178900121213     C                             ACC#CNE  = 0 AND CCR#CNE  = 0 AND
179000121213     C                             CRI#CNE  = 0 AND VCI#CNE  = 0
179100121213     C                   EVAL      @STEP = 'STEP5'
179200121213     C                   LEAVESR
179300121213     C                   ENDIF
179400121213    ***
179500121213     C                   EVAL      TERM_LIF = NO
179600121213     C                   EVAL      TERM_ADD = NO
179700121213     C                   EVAL      TERM_DLF = NO
179800121213     C                   EVAL      TERM_VLF = NO
179900121213     C                   EVAL      TERM_VAD = NO
180000121213     C                   EVAL      TERM_VLT = NO
180100121213     C                   EVAL      TERM_CRI = NO
180200121213     C                   EVAL      TERM_MED = NO
180300121213     C                   EVAL      TERM_DEN = NO
180400121213     C                   EVAL      TERM_RXD = NO
180500121213     C                   EVAL      TERM_VIS = NO
180600121213     C                   EVAL      TERM_LTD = NO
180700121213     C                   EVAL      TERM_STD = NO
180800121213     C                   EVAL      TERM_VCI = NO
180900121213     C                   EVAL      TERM_ACC = NO
181000121213     C                   EVAL      TERM_CCR = NO
181100121213    ***
181200121213     C                   EXSR      $CHKHEM
181300121213    ***
181400121213     C                   EVAL      @STEP = 'STEP7'
181500121213    ***
181600121213     C                   ENDSR
181700121213   S***S
181800121213     C     $STEP7        BEGSR
181900121213    ***
182000121213     C                   IF        LIF#CNE  = 0 AND MED#CNE  = 0 AND
182100121213     C                             ADD#CNE  = 0 AND DEN#CNE  = 0 AND
182200121213     C                             DLF#CNE  = 0 AND RXD#CNE  = 0 AND
182300121213     C                             VLF#CNE  = 0 AND VIS#CNE  = 0 AND
182400121213     C                             VAD#CNE  = 0 AND LTD#CNE  = 0 AND
182500121213     C                             VLT#CNE  = 0 AND STD#CNE  = 0 AND
182600121213     C                             ACC#CNE  = 0 AND CCR#CNE  = 0 AND
182700121213     C                             CRI#CNE  = 0 AND VCI#CNE  = 0
182800121213     C                   EVAL      @STEP = 'STEP5'
182900121213     C                   LEAVESR
183000121213     C                   ENDIF
183100121213    ***
183200121213     C                   EVAL      WRT@TYPE = 'DEPEND'
183300121213    ***
183400121213     C                   EXSR      $FILLDEP
183500121213    ***
183600121213     C                   EXSR      $FILLCOVG
183700121213    ***
183800121213    *C*                  EXSR      $AUDITCVG
183900121213    ***
184000121213     C                   WRITE     AEBF010
184100121213     C                   ADD       1             #RECCNT
184200121213    ***
184300121213     C                   EVAL      @STEP = 'STEP5'
184400121213    ***
184500121213     C                   ENDSR
184600121213   S***S
184700121213     C     $FILLDEP      BEGSR
184800121213    ***
184900121213     C                   CLEAR                   AEBF010
185000121213    ***
185100121213     C                   EVAL      AEBG = %TRIM(CACID2)
185200121213     C                   EVAL      AESN = %TRIM(CACID1)
185300121213    ***
185400121213     C                   SELECT
185500121213     C                   WHEN      DRELCD = 'RWI' OR DRELCD = 'RHU' OR
185600121213     C                             DRELCD = 'RPA'
185700121213     C                   EVAL      AEEMPCD   = '2'
185800121213     C                   WHEN      DRELCD = 'RSO' OR DRELCD = 'RDA'
185900121213     C                   EVAL      AEEMPCD   = '3'
186000121213     C                   OTHER
186100121213     C     'RELCD ERR'   DSPLY     '*EXT'
186200121213     C                   SETON                                        H1
186300121213     C                   ENDSL
186400121213    ***
186500121213     C                   EVAL      AELNAM    = %TRIM(DLNAME)
186600121213     C                   EVAL      AEFNAM    = %TRIM(DFNAME)
186700121213     C                   EVAL      AEMNAM    = DMI
186800121213    ***
186900121213     C                   IF        DEPSS# <>0
187000121213     C                   EVAL      AESSN     = %EDITC(DEPSS#:'X')
187100121213     C                   ENDIF
187200121213    ***
187300121213     C                   IF        DADDR1 = ADDR1 OR %TRIM(DADDR1) = 'SAME'
187400121213      *
187500121213     C                   IF        %SUBST(ADDR1:1:1) <> 'X'
187600121213     C                   EVAL      AEADR1    = %TRIM(ADDR1)
187700121213     C                   EVAL      AEADR2    = %TRIM(ADDR2)
187800121213     C                   EVAL      AECITY    = %TRIM(CITY)
187900121213     C                   MOVE      *BLANKS       @9                9
188000121213     C                   EVAL      @9 = %EDITC(ZIP:'X')
188100121213     C                   EVAL      AEZIP     = %SUBST(@9:1:5)
188200121213     C                   EVAL      AESTATE   = STATE
188300121213     C                   EVAL      AECNTRY = 'US'
188400121213     C                   ENDIF
188500121213     C                   IF        AREA <> 0
188600121213     C                   EVAL      AEAREA    = %EDITC(AREA:'X')
188700121213     C                   EVAL      AEPHONE   = %EDITC(PHONE:'X')
188800121213     C                   ENDIF
188900121213     C                   ELSE
189000121213     C                   IF        %SUBST(DADDR1:1:1) <> 'X'
189100121213     C                   EVAL      AEADR1    = %TRIM(DADDR1)
189200121213     C                   EVAL      AEADR2    = %TRIM(DADDR2)
189300121213     C                   EVAL      AECITY    = %TRIM(DCITY)
189400121213     C                   MOVE      *BLANKS       @9                9
189500121213     C                   EVAL      @9 = %EDITC(DZIP:'X')
189600121213     C                   EVAL      AEZIP     = %SUBST(@9:1:5)
189700121213     C                   EVAL      AESTATE   = DSTATE
189800121213     C                   EVAL      AECNTRY = 'US'
189900121213     C                   ENDIF
190000121213     C                   IF        DAREA <> 0
190100121213     C                   EVAL      AEAREA    = %EDITC(DAREA:'X')
190200121213     C                   EVAL      AEPHONE   = %EDITC(DPHONE:'X')
190300121213     C                   ENDIF
190400121213     C                   ENDIF
190500121213     **
190600121213     C                   EVAL      AERT = 'ENR'
190700121213     C                   EVAL      AETRMRSN  = *BLANKS
190800121213     C                   EVAL      AEEFFDAT  = %CHAR(#TODAY)
190900121213    ***
191000121213     C                   EVAL      AEGENDER = DSEX
191100121213     C                   EVAL      AEDOB     = %EDITC(DBIRTH:'X')
191200121213    ***
191300121213     C                   EVAL      AEHIREDT  = %EDITC(EMPDT:'X')
191400121213     C                   EVAL      AEENROLL  = %EDITC(MBENRL:'X')
191500121213    ***
191600121213     C                   ENDSR
191700121213   S***S
191800121213     C     *INZSR        BEGSR
191900121213    ***
192000121213     C                   EVAL      #RECCNT = 0
192100121213    ***
192200121213     C     KL#ACCTL      KLIST
192300121213     C                   KFLD                    CARR#CTL
192400121213     C                   KFLD                    KF@TRS
192500121213     C                   KFLD                    KF@SUB
192600121213     C                   KFLD                    KF@ACC
192700121213    ***
192800121213     C     KL#AUX        KLIST
192900121213     C                   KFLD                    KF@TRS
193000121213     C                   KFLD                    KF@SUB
193100121213     C                   KFLD                    KF@ACC
193200121213     C                   KFLD                    KF@SSN
193300121213     C                   KFLD                    KF@SEQ
193400121213    ***
193500121213     C     KL#TSA        KLIST
193600121213     C                   KFLD                    KF@TRS
193700121213     C                   KFLD                    KF@SUB
193800121213     C                   KFLD                    KF@ACC
193900121213    ***
194000121213     C     KL#MPLN       KLIST
194100121213     C                   KFLD                    KF@SSN
194200121213     C                   KFLD                    KF@SEQ
194300121213     C                   KFLD                    KF@TRS
194400121213     C                   KFLD                    KF@SUB
194500121213     C                   KFLD                    KF@ACC
194600121213    ***
194700121213     C     KL#CPLN       KLIST
194800121213     C                   KFLD                    CARR#CTL
194900121213     C                   KFLD                    KF@TRS
195000121213     C                   KFLD                    KF@SUB
195100121213     C                   KFLD                    KF@ACC
195200121213     C                   KFLD                    KF@CCTR
195300121213     C                   KFLD                    KF@PLN
195400121213    ***
195500121213     C     KL#DCV        KLIST
195600121213     C                   KFLD                    KF@SSN
195700121213     C                   KFLD                    KF@SEQ
195800121213    ***
195900121213     C     KL#MTR        KLIST
196000121213     C                   KFLD                    KF@SSN
196100121213     C                   KFLD                    KF@SEQ
196200121213     C                   KFLD                    KF@TRM
196300121213     C                   KFLD                    KF@PLN
196400121213     C                   KFLD                    KF@ENR
196500121213     C                   KFLD                    KF@TRS
196600121213     C                   KFLD                    KF@SUB
196700121213     C                   KFLD                    KF@ACC
196800121213    ***
196900121213     C                   ENDSR
197000121213   S***S
197100121213     C     $CLRSTG       BEGSR
197200121213    ***
197300121213     C                   CLEAR                   DS@AEB
197400121213     C                   EVAL      NDX = 0
197500121213     C                   CLEAR                   AE@@
197600121213    ***
197700121213     C                   EVAL      #CANCEL = 0
197800121213    ***
197900121213     C                   EVAL                    MED#CNE = 0
198000121213     C                   EVAL                    MED#NDX = 0
198100121213     C                   CLEAR                   MED@PLN
198200121213     C                   CLEAR                   MED@ENR
198300121213     C                   CLEAR                   MED@FRM
198400121213     C                   CLEAR                   MED@TRM
198500121213    ***
198600121213     C                   EVAL                    DEN#CNE = 0
198700121213     C                   EVAL                    DEN#NDX = 0
198800121213     C                   CLEAR                   DEN@PLN
198900121213     C                   CLEAR                   DEN@ENR
199000121213     C                   CLEAR                   DEN@FRM
199100121213     C                   CLEAR                   DEN@TRM
199200121213    ***
199300121213     C                   EVAL                    RXD#CNE = 0
199400121213     C                   EVAL                    RXD#NDX = 0
199500121213     C                   CLEAR                   RXD@PLN
199600121213     C                   CLEAR                   RXD@ENR
199700121213     C                   CLEAR                   RXD@FRM
199800121213     C                   CLEAR                   RXD@TRM
199900121213    ***
200000121213     C                   EVAL                    VIS#CNE = 0
200100121213     C                   EVAL                    VIS#NDX = 0
200200121213     C                   CLEAR                   VIS@PLN
200300121213     C                   CLEAR                   VIS@ENR
200400121213     C                   CLEAR                   VIS@FRM
200500121213     C                   CLEAR                   VIS@TRM
200600121213    ***
200700121213     C                   EVAL                    LTD#CNE = 0
200800121213     C                   EVAL                    LTD#NDX = 0
200900121213     C                   CLEAR                   LTD@PLN
201000121213     C                   CLEAR                   LTD@ENR
201100121213     C                   CLEAR                   LTD@VOL
201200121213     C                   CLEAR                   LTD@FRM
201300121213     C                   CLEAR                   LTD@TRM
201400121213    ***
201500121213     C                   EVAL                    STD#CNE = 0
201600121213     C                   EVAL                    STD#NDX = 0
201700121213     C                   CLEAR                   STD@PLN
201800121213     C                   CLEAR                   STD@ENR
201900121213     C                   CLEAR                   STD@VOL
202000121213     C                   CLEAR                   STD@FRM
202100121213     C                   CLEAR                   STD@TRM
202200121213    ***
202300121213     C                   EVAL                    LIF#CNE = 0
202400121213     C                   EVAL                    LIF#NDX = 0
202500121213     C                   CLEAR                   LIF@PLN
202600121213     C                   CLEAR                   LIF@ENR
202700121213     C                   CLEAR                   LIF@VOL
202800121213     C                   CLEAR                   LIF@FRM
202900121213     C                   CLEAR                   LIF@TRM
203000121213    ***
203100121213     C                   EVAL                    ADD#CNE = 0
203200121213     C                   EVAL                    ADD#NDX = 0
203300121213     C                   CLEAR                   ADD@PLN
203400121213     C                   CLEAR                   ADD@ENR
203500121213     C                   CLEAR                   ADD@VOL
203600121213     C                   CLEAR                   ADD@FRM
203700121213     C                   CLEAR                   ADD@TRM
203800121213    ***
203900121213     C                   EVAL                    DLF#CNE = 0
204000121213     C                   EVAL                    DLF#NDX = 0
204100121213     C                   CLEAR                   DLF@PLN
204200121213     C                   CLEAR                   DLF@ENR
204300121213     C                   CLEAR                   DLF@VOL
204400121213     C                   CLEAR                   DLF@FRM
204500121213     C                   CLEAR                   DLF@TRM
204600121213    ***
204700121213     C                   EVAL                    VLF#CNE = 0
204800121213     C                   EVAL                    VLF#NDX = 0
204900121213     C                   CLEAR                   VLF@PLN
205000121213     C                   CLEAR                   VLF@ENR
205100121213     C                   CLEAR                   VLF@VOL
205200121213     C                   CLEAR                   VLF@FRM
205300121213     C                   CLEAR                   VLF@TRM
205400121213    ***
205500121213     C                   EVAL                    VAD#CNE = 0
205600121213     C                   EVAL                    VAD#NDX = 0
205700121213     C                   CLEAR                   VAD@PLN
205800121213     C                   CLEAR                   VAD@ENR
205900121213     C                   CLEAR                   VAD@VOL
206000121213     C                   CLEAR                   VAD@FRM
206100121213     C                   CLEAR                   VAD@TRM
206200121213    ***
206300121213     C                   EVAL                    VLT#CNE = 0
206400121213     C                   EVAL                    VLT#NDX = 0
206500121213     C                   CLEAR                   VLT@PLN
206600121213     C                   CLEAR                   VLT@ENR
206700121213     C                   CLEAR                   VLT@VOL
206800121213     C                   CLEAR                   VLT@FRM
206900121213     C                   CLEAR                   VLT@TRM
207000121213    ***
207100121213     C                   EVAL                    CRI#CNE = 0
207200121213     C                   EVAL                    CRI#NDX = 0
207300121213     C                   CLEAR                   CRI@PLN
207400121213     C                   CLEAR                   CRI@ENR
207500121213     C                   CLEAR                   CRI@VOL
207600121213     C                   CLEAR                   CRI@FRM
207700121213     C                   CLEAR                   CRI@TRM
207800121213    ***
207900121213     C                   EVAL                    VCI#CNE = 0
208000121213     C                   EVAL                    VCI#NDX = 0
208100121213     C                   CLEAR                   VCI@PLN
208200121213     C                   CLEAR                   VCI@ENR
208300121213     C                   CLEAR                   VCI@VOL
208400121213     C                   CLEAR                   VCI@FRM
208500121213     C                   CLEAR                   VCI@TRM
208600121213    ***
208700121213     C                   EVAL                    ACC#CNE = 0
208800121213     C                   EVAL                    ACC#NDX = 0
208900121213     C                   CLEAR                   ACC@PLN
209000121213     C                   CLEAR                   ACC@ENR
209100121213     C                   CLEAR                   ACC@FRM
209200121213     C                   CLEAR                   ACC@TRM
209300121213    ***
209400121213     C                   EVAL                    CCR#CNE = 0
209500121213     C                   EVAL                    CCR#NDX = 0
209600121213     C                   CLEAR                   CCR@PLN
209700121213     C                   CLEAR                   CCR@ENR
209800121213     C                   CLEAR                   CCR@FRM
209900121213     C                   CLEAR                   CCR@TRM
210000121213    ***
210100121213     C                   ENDSR
210200121213   S***S
210300121213     C     $CHKHEM       BEGSR
210400121213    ***
210500121213     C                   IF        MED#CNE > 0 AND MED@TRM(MED#CNE) <> 99999999
210600121213     C                   EXSR      $CHKMED
210700121213     C                   ENDIF
210800121213    ***
210900121213     C                   IF        DEN#CNE > 0 AND DEN@TRM(DEN#CNE) <> 99999999
211000121213     C                   EXSR      $CHKDEN
211100121213     C                   ENDIF
211200121213    ***
211300121213     C                   IF        RXD#CNE > 0 AND RXD@TRM(RXD#CNE) <> 99999999
211400121213     C                   EXSR      $CHKRXD
211500121213     C                   ENDIF
211600121213    ***
211700121213     C                   IF        VIS#CNE > 0 AND VIS@TRM(VIS#CNE) <> 99999999
211800121213     C                   EXSR      $CHKVIS
211900121213     C                   ENDIF
212000121213    ***
212100121213     C                   IF        LTD#CNE > 0 AND LTD@TRM(LTD#CNE) <> 99999999
212200121213     C                   EXSR      $CHKLTD
212300121213     C                   ENDIF
212400121213    ***
212500121213     C                   IF        STD#CNE > 0 AND STD@TRM(STD#CNE) <> 99999999
212600121213     C                   EXSR      $CHKSTD
212700121213     C                   ENDIF
212800121213    ***
212900121213     C                   IF        VCI#CNE > 0 AND VCI@TRM(VCI#CNE) <> 99999999
213000121213     C                   EXSR      $CHKVCI
213100121213     C                   ENDIF
213200121213    ***
213300121213     C                   IF        LIF#CNE > 0 AND LIF@TRM(LIF#CNE) <> 99999999
213400121213     C                   EXSR      $CHKLIF
213500121213     C                   ENDIF
213600121213    ***
213700121213     C                   IF        ADD#CNE > 0 AND ADD@TRM(ADD#CNE) <> 99999999
213800121213     C                   EXSR      $CHKADD
213900121213     C                   ENDIF
214000121213    ***
214100121213     C                   IF        DLF#CNE > 0 AND DLF@TRM(DLF#CNE) <> 99999999
214200121213     C                   EXSR      $CHKDLF
214300121213     C                   ENDIF
214400121213    ***
214500121213     C                   IF        VLF#CNE > 0 AND VLF@TRM(VLF#CNE) <> 99999999
214600121213     C                   EXSR      $CHKVLF
214700121213     C                   ENDIF
214800121213    ***
214900121213     C                   IF        VAD#CNE > 0 AND VAD@TRM(VAD#CNE) <> 99999999
215000121213     C                   EXSR      $CHKVAD
215100121213     C                   ENDIF
215200121213    ***
215300121213     C                   IF        VLT#CNE > 0 AND VLT@TRM(VLT#CNE) <> 99999999
215400121213     C                   EXSR      $CHKVLT
215500121213     C                   ENDIF
215600121213    ***
215700121213     C                   IF        CRI#CNE > 0 AND CRI@TRM(CRI#CNE) <> 99999999
215800121213     C                   EXSR      $CHKCRI
215900121213     C                   ENDIF
216000121213    ***
216100121213     C                   IF        ACC#CNE > 0 AND ACC@TRM(ACC#CNE) <> 99999999
216200121213     C                   EXSR      $CHKACC
216300121213     C                   ENDIF
216400121213    ***
216500121213     C                   IF        CCR#CNE > 0 AND CCR@TRM(CCR#CNE) <> 99999999
216600121213     C                   EXSR      $CHKCCR
216700121213     C                   ENDIF
216800121213    ***
216900121213     C                   ENDSR
217000121213   S***S
217100121213      * CHECK FOR MEDICAL TERMINATION
217200121213    *C     $CHKMED       BEGSR
217300121213    ***
217400121213    *C                   EVAL      TERM_MED = YES
217500121213    *C                   EVAL      KF@TRM = MED@TRM(MED#CNE)
217600121213    *C                   EVAL      KF@PLN = MED@PLN(MED#CNE)
217700121213    *C                   EVAL      KF@ENR = MED@ENR(MED#CNE)
217800121213    ***
217900121213    *C     KL#MTR        CHAIN     AEB004F
218000121213    *C                   IF        %FOUND(AEB004WF)
218100121213     C                   IF        NTCOUNT > 1
218200121213    *C                   EVAL      MED#CNE = 0
218300121213    *C                   EVAL      TERM_MED = NO
218400121213     C                   ELSE
218500121213     C                   ADD       1             NTCOUNT
218600121213     C                   EVAL      NTTRANSD2      = #TODAY
218700121213     C                   UPDATE    AEB004F
218800121213     C                   LEAVESR
218900121213     C                   ENDIF
219000121213    *C                   ENDIF
219100121213    ***
219200121213     C                   EXSR      $WRTERM
219300121213    ***
219400121213    *C                   ENDSR
219500121213   S***S
219600121213    *C     $WRTERM       BEGSR
219700121213    ***
219800121213    *C                   CLEAR                   AEB004F
219900121213     C                   EVAL      NTSSNO         = KF@SSN
220000121213     C                   EVAL      NTDEPNO        = KF@SEQ
220100121213     C                   EVAL      NTTERMDT       = KF@TRM
220200121213     C                   EVAL      NTPLAN         = KF@PLN
220300121213     C                   EVAL      NTCOVTP        = KF@ENR
220400121213     C                   EVAL      NTTRST         = KF@TRS
220500121213     C                   EVAL      NTSUB#         = KF@SUB
220600121213     C                   EVAL      NTACCT         = KF@ACC
220700121213     C                   EVAL      NTTRANSDT      = #TODAY
220800121213     C                   EVAL      NTCOUNT = 1
220900121213     C                   WRITE     AEB004F
221000121213    ***
221100121213    *C                   ENDSR
221200121213   S***S
221300121213      * CHECK FOR DENTAL TERMINATION
221400121213    *C     $CHKDEN       BEGSR
221500121213    ***
221600121213    *C                   EVAL      TERM_DEN = YES
221700121213    *C                   EVAL      KF@TRM = DEN@TRM(DEN#CNE)
221800121213    *C                   EVAL      KF@PLN = DEN@PLN(DEN#CNE)
221900121213    *C                   EVAL      KF@ENR = DEN@ENR(DEN#CNE)
222000121213    ***
222100121213    *C     KL#MTR        CHAIN     AEB004F
222200121213    *C                   IF        %FOUND(AEB004WF)
222300121213     C                   IF        NTCOUNT > 1
222400121213    *C                   EVAL      DEN#CNE = 0
222500121213    *C                   EVAL      TERM_DEN = NO
222600121213     C                   ELSE
222700121213     C                   ADD       1             NTCOUNT
222800121213     C                   EVAL      NTTRANSD2      = #TODAY
222900121213     C                   UPDATE    AEB004F
223000121213     C                   LEAVESR
223100121213     C                   ENDIF
223200121213    *C                   ENDIF
223300121213    ***
223400121213     C                   EXSR      $WRTERM
223500121213    ***
223600121213    *C                   ENDSR
223700121213   S***S
223800121213      * CHECK FOR DRUG TERMINATION
223900121213    *C     $CHKRXD       BEGSR
224000121213    ***
224100121213    *C                   EVAL      TERM_RXD = YES
224200121213    *C                   EVAL      KF@TRM = RXD@TRM(RXD#CNE)
224300121213    *C                   EVAL      KF@PLN = RXD@PLN(RXD#CNE)
224400121213    *C                   EVAL      KF@ENR = RXD@ENR(RXD#CNE)
224500121213    ***
224600121213    *C     KL#MTR        CHAIN     AEB004F
224700121213    *C                   IF        %FOUND(AEB004WF)
224800121213     C                   IF        NTCOUNT > 1
224900121213    *C                   EVAL      RXD#CNE = 0
225000121213    *C                   EVAL      TERM_RXD = NO
225100121213     C                   ELSE
225200121213     C                   ADD       1             NTCOUNT
225300121213     C                   EVAL      NTTRANSD2      = #TODAY
225400121213     C                   UPDATE    AEB004F
225500121213     C                   LEAVESR
225600121213     C                   ENDIF
225700121213    *C                   ENDIF
225800121213    ***
225900121213     C                   EXSR      $WRTERM
226000121213    ***
226100121213    *C                   ENDSR
226200121213   S***S
226300121213      * CHECK FOR VISION TERMINATION
226400121213    *C     $CHKVIS       BEGSR
226500121213    ***
226600121213    *C                   EVAL      TERM_VIS = YES
226700121213    *C                   EVAL      KF@TRM = VIS@TRM(VIS#CNE)
226800121213    *C                   EVAL      KF@PLN = VIS@PLN(VIS#CNE)
226900121213    *C                   EVAL      KF@ENR = VIS@ENR(VIS#CNE)
227000121213    ***
227100121213    *C     KL#MTR        CHAIN     AEB004F
227200121213    *C                   IF        %FOUND(AEB004WF)
227300121213     C                   IF        NTCOUNT > 1
227400121213    *C                   EVAL      VIS#CNE = 0
227500121213    *C                   EVAL      TERM_VIS = NO
227600121213     C                   ELSE
227700121213     C                   ADD       1             NTCOUNT
227800121213     C                   EVAL      NTTRANSD2      = #TODAY
227900121213     C                   UPDATE    AEB004F
228000121213     C                   LEAVESR
228100121213     C                   ENDIF
228200121213    *C                   ENDIF
228300121213    ***
228400121213     C                   EXSR      $WRTERM
228500121213    ***
228600121213    *C                   ENDSR
228700121213   S***S
228800121213      * CHECK FOR LTD TERMINATION
228900121213    *C     $CHKLTD       BEGSR
229000121213    ***
229100121213    *C                   EVAL      TERM_LTD = YES
229200121213    *C                   EVAL      KF@TRM = LTD@TRM(LTD#CNE)
229300121213    *C                   EVAL      KF@PLN = LTD@PLN(LTD#CNE)
229400121213    *C                   EVAL      KF@ENR = LTD@ENR(LTD#CNE)
229500121213    ***
229600121213    *C     KL#MTR        CHAIN     AEB004F
229700121213    *C                   IF        %FOUND(AEB004WF)
229800121213     C                   IF        NTCOUNT > 1
229900121213    *C                   EVAL      LTD#CNE = 0
230000121213    *C                   EVAL      TERM_LTD = NO
230100121213     C                   ELSE
230200121213     C                   ADD       1             NTCOUNT
230300121213     C                   EVAL      NTTRANSD2      = #TODAY
230400121213     C                   UPDATE    AEB004F
230500121213     C                   LEAVESR
230600121213     C                   ENDIF
230700121213    *C                   ENDIF
230800121213    ***
230900121213     C                   EXSR      $WRTERM
231000121213    ***
231100121213    *C                   ENDSR
231200121213   S***S
231300121213      * CHECK FOR STD TERMINATION
231400121213    *C     $CHKSTD       BEGSR
231500121213    ***
231600121213    *C                   EVAL      TERM_STD = YES
231700121213    *C                   EVAL      KF@TRM = STD@TRM(STD#CNE)
231800121213    *C                   EVAL      KF@PLN = STD@PLN(STD#CNE)
231900121213    *C                   EVAL      KF@ENR = STD@ENR(STD#CNE)
232000121213    ***
232100121213    *C     KL#MTR        CHAIN     AEB004F
232200121213    *C                   IF        %FOUND(AEB004WF)
232300121213     C                   IF        NTCOUNT > 1
232400121213    *C                   EVAL      STD#CNE = 0
232500121213    *C                   EVAL      TERM_STD = NO
232600121213     C                   ELSE
232700121213     C                   ADD       1             NTCOUNT
232800121213     C                   EVAL      NTTRANSD2      = #TODAY
232900121213     C                   UPDATE    AEB004F
233000121213     C                   LEAVESR
233100121213     C                   ENDIF
233200121213    *C                   ENDIF
233300121213    ***
233400121213     C                   EXSR      $WRTERM
233500121213    ***
233600121213    *C                   ENDSR
233700121213   S***S
233800121213      * CHECK FOR LIFE TERMINATION
233900121213    *C     $CHKLIF       BEGSR
234000121213    ***
234100121213    *C                   EVAL      TERM_LIF = YES
234200121213    *C                   EVAL      KF@TRM = LIF@TRM(LIF#CNE)
234300121213    *C                   EVAL      KF@PLN = LIF@PLN(LIF#CNE)
234400121213    *C                   EVAL      KF@ENR = LIF@ENR(LIF#CNE)
234500121213    ***
234600121213    *C     KL#MTR        CHAIN     AEB004F
234700121213    *C                   IF        %FOUND(AEB004WF)
234800121213     C                   IF        NTCOUNT > 1
234900121213    *C                   EVAL      LIF#CNE = 0
235000121213    *C                   EVAL      TERM_LIF = NO
235100121213     C                   ELSE
235200121213     C                   ADD       1             NTCOUNT
235300121213     C                   EVAL      NTTRANSD2      = #TODAY
235400121213     C                   UPDATE    AEB004F
235500121213     C                   LEAVESR
235600121213     C                   ENDIF
235700121213    *C                   ENDIF
235800121213    ***
235900121213     C                   EXSR      $WRTERM
236000121213    ***
236100121213    *C                   ENDSR
236200121213   S***S
236300121213      * CHECK FOR AD&D TERMINATION
236400121213    *C     $CHKADD       BEGSR
236500121213    ***
236600121213    *C                   EVAL      TERM_ADD = YES
236700121213    *C                   EVAL      KF@TRM = ADD@TRM(ADD#CNE)
236800121213    *C                   EVAL      KF@PLN = ADD@PLN(ADD#CNE)
236900121213    *C                   EVAL      KF@ENR = ADD@ENR(ADD#CNE)
237000121213    ***
237100121213    *C     KL#MTR        CHAIN     AEB004F
237200121213    *C                   IF        %FOUND(AEB004WF)
237300121213     C                   IF        NTCOUNT > 1
237400121213    *C                   EVAL      ADD#CNE = 0
237500121213    *C                   EVAL      TERM_ADD = NO
237600121213     C                   ELSE
237700121213     C                   ADD       1             NTCOUNT
237800121213     C                   EVAL      NTTRANSD2      = #TODAY
237900121213     C                   UPDATE    AEB004F
238000121213     C                   LEAVESR
238100121213     C                   ENDIF
238200121213    *C                   ENDIF
238300121213    ***
238400121213     C                   EXSR      $WRTERM
238500121213    ***
238600121213    *C                   ENDSR
238700121213   S***S
238800121213      * CHECK FOR DEPENDENT LIFE TERMINATION
238900121213    *C     $CHKDLF       BEGSR
239000121213    ***
239100121213    *C                   EVAL      TERM_DLF = YES
239200121213    *C                   EVAL      KF@TRM = DLF@TRM(DLF#CNE)
239300121213    *C                   EVAL      KF@PLN = DLF@PLN(DLF#CNE)
239400121213    *C                   EVAL      KF@ENR = DLF@ENR(DLF#CNE)
239500121213    ***
239600121213    *C     KL#MTR        CHAIN     AEB004F
239700121213    *C                   IF        %FOUND(AEB004WF)
239800121213     C                   IF        NTCOUNT > 1
239900121213    *C                   EVAL      DLF#CNE = 0
240000121213    *C                   EVAL      TERM_DLF = NO
240100121213     C                   ELSE
240200121213     C                   ADD       1             NTCOUNT
240300121213     C                   EVAL      NTTRANSD2      = #TODAY
240400121213     C                   UPDATE    AEB004F
240500121213     C                   LEAVESR
240600121213     C                   ENDIF
240700121213    *C                   ENDIF
240800121213    ***
240900121213     C                   EXSR      $WRTERM
241000121213    ***
241100121213    *C                   ENDSR
241200121213   S***S
241300121213      * CHECK FOR VOLUNATRY LIFE TERMINATION
241400121213    *C     $CHKVLF       BEGSR
241500121213    ***
241600121213    *C                   EVAL      TERM_VLF = YES
241700121213    *C                   EVAL      KF@TRM = VLF@TRM(VLF#CNE)
241800121213    *C                   EVAL      KF@PLN = VLF@PLN(VLF#CNE)
241900121213    *C                   EVAL      KF@ENR = VLF@ENR(VLF#CNE)
242000121213    ***
242100121213    *C     KL#MTR        CHAIN     AEB004F
242200121213    *C                   IF        %FOUND(AEB004WF)
242300121213     C                   IF        NTCOUNT > 1
242400121213    *C                   EVAL      VLF#CNE = 0
242500121213    *C                   EVAL      TERM_VLF = NO
242600121213     C                   ELSE
242700121213     C                   ADD       1             NTCOUNT
242800121213     C                   EVAL      NTTRANSD2      = #TODAY
242900121213     C                   UPDATE    AEB004F
243000121213     C                   LEAVESR
243100121213     C                   ENDIF
243200121213    *C                   ENDIF
243300121213    ***
243400121213     C                   EXSR      $WRTERM
243500121213    ***
243600121213    *C                   ENDSR
243700121213   S***S
243800121213      * CHECK FOR VOLUNATRY AD&D TERMINATION
243900121213    *C     $CHKVAD       BEGSR
244000121213    ***
244100121213    *C                   EVAL      TERM_VAD = YES
244200121213    *C                   EVAL      KF@TRM = VAD@TRM(VAD#CNE)
244300121213    *C                   EVAL      KF@PLN = VAD@PLN(VAD#CNE)
244400121213    *C                   EVAL      KF@ENR = VAD@ENR(VAD#CNE)
244500121213    ***
244600121213    *C     KL#MTR        CHAIN     AEB004F
244700121213    *C                   IF        %FOUND(AEB004WF)
244800121213     C                   IF        NTCOUNT > 1
244900121213    *C                   EVAL      VAD#CNE = 0
245000121213    *C                   EVAL      TERM_VAD = NO
245100121213     C                   ELSE
245200121213     C                   ADD       1             NTCOUNT
245300121213     C                   EVAL      NTTRANSD2      = #TODAY
245400121213     C                   UPDATE    AEB004F
245500121213     C                   LEAVESR
245600121213     C                   ENDIF
245700121213    *C                   ENDIF
245800121213    ***
245900121213     C                   EXSR      $WRTERM
246000121213    ***
246100121213    *C                   ENDSR
246200121213   S***S
246300121213      * CHECK FOR VOLUNATRY LTD TERMINATION
246400121213    *C     $CHKVLT       BEGSR
246500121213    ***
246600121213    *C                   EVAL      TERM_VLT = YES
246700121213    *C                   EVAL      KF@TRM = VLT@TRM(VLT#CNE)
246800121213    *C                   EVAL      KF@PLN = VLT@PLN(VLT#CNE)
246900121213    *C                   EVAL      KF@ENR = VLT@ENR(VLT#CNE)
247000121213    ***
247100121213    *C     KL#MTR        CHAIN     AEB004F
247200121213    *C                   IF        %FOUND(AEB004WF)
247300121213     C                   IF        NTCOUNT > 1
247400121213    *C                   EVAL      VLT#CNE = 0
247500121213    *C                   EVAL      TERM_VLT = NO
247600121213     C                   ELSE
247700121213     C                   ADD       1             NTCOUNT
247800121213     C                   EVAL      NTTRANSD2      = #TODAY
247900121213     C                   UPDATE    AEB004F
248000121213     C                   LEAVESR
248100121213     C                   ENDIF
248200121213    *C                   ENDIF
248300121213    ***
248400121213     C                   EXSR      $WRTERM
248500121213    ***
248600121213    *C                   ENDSR
248700121213   S***S
248800121213      * CHECK FOR CRITICAL ILLNESS TERMINATION
248900121213    *C     $CHKCRI       BEGSR
249000121213    ***
249100121213    *C                   EVAL      TERM_CRI = YES
249200121213    *C                   EVAL      KF@TRM = CRI@TRM(CRI#CNE)
249300121213    *C                   EVAL      KF@PLN = CRI@PLN(CRI#CNE)
249400121213    *C                   EVAL      KF@ENR = CRI@ENR(CRI#CNE)
249500121213    ***
249600121213    *C     KL#MTR        CHAIN     AEB004F
249700121213    *C                   IF        %FOUND(AEB004WF)
249800121213     C                   IF        NTCOUNT > 1
249900121213    *C                   EVAL      CRI#CNE = 0
250000121213    *C                   EVAL      TERM_CRI = NO
250100121213     C                   ELSE
250200121213     C                   ADD       1             NTCOUNT
250300121213     C                   EVAL      NTTRANSD2      = #TODAY
250400121213     C                   UPDATE    AEB004F
250500121213     C                   LEAVESR
250600121213     C                   ENDIF
250700121213    *C                   ENDIF
250800121213    ***
250900121213     C                   EXSR      $WRTERM
251000121213    ***
251100121213    *C                   ENDSR
251200121213   S***S
251300121213      * CHECK FOR VOLUNATRY CRITICAL ILLNESS TERMINATION
251400121213    *C     $CHKVCI       BEGSR
251500121213    ***
251600121213    *C                   EVAL      TERM_VCI = YES
251700121213    *C                   EVAL      KF@TRM = VCI@TRM(VCI#CNE)
251800121213    *C                   EVAL      KF@PLN = VCI@PLN(VCI#CNE)
251900121213    *C                   EVAL      KF@ENR = VCI@ENR(VCI#CNE)
252000121213    ***
252100121213    *C     KL#MTR        CHAIN     AEB004F
252200121213    *C                   IF        %FOUND(AEB004WF)
252300121213     C                   IF        NTCOUNT > 1
252400121213    *C                   EVAL      VCI#CNE = 0
252500121213    *C                   EVAL      TERM_VCI = NO
252600121213     C                   ELSE
252700121213     C                   ADD       1             NTCOUNT
252800121213     C                   EVAL      NTTRANSD2      = #TODAY
252900121213     C                   UPDATE    AEB004F
253000121213     C                   LEAVESR
253100121213     C                   ENDIF
253200121213    *C                   ENDIF
253300121213    ***
253400121213     C                   EXSR      $WRTERM
253500121213    ***
253600121213    *C                   ENDSR
253700121213   S***S
253800121213      * CHECK FOR ACCIDENT COVERAGE TERMINATION
253900121213    *C     $CHKACC       BEGSR
254000121213    ***
254100121213    *C                   EVAL      TERM_ACC = YES
254200121213    *C                   EVAL      KF@TRM = ACC@TRM(ACC#CNE)
254300121213    *C                   EVAL      KF@PLN = ACC@PLN(ACC#CNE)
254400121213    *C                   EVAL      KF@ENR = ACC@ENR(ACC#CNE)
254500121213    ***
254600121213    *C     KL#MTR        CHAIN     AEB004F
254700121213    *C                   IF        %FOUND(AEB004WF)
254800121213     C                   IF        NTCOUNT > 1
254900121213    *C                   EVAL      ACC#CNE = 0
255000121213    *C                   EVAL      TERM_ACC = NO
255100121213     C                   ELSE
255200121213     C                   ADD       1             NTCOUNT
255300121213     C                   EVAL      NTTRANSD2      = #TODAY
255400121213     C                   UPDATE    AEB004F
255500121213     C                   LEAVESR
255600121213     C                   ENDIF
255700121213    *C                   ENDIF
255800121213    ***
255900121213     C                   EXSR      $WRTERM
256000121213    ***
256100121213    *C                   ENDSR
256200121213   S***S
256300121213      * CHECK FOR CANCER COVERAGE TERMINATION
256400121213    *C     $CHKCCR       BEGSR
256500121213    ***
256600121213    *C                   EVAL      TERM_CCR = YES
256700121213    *C                   EVAL      KF@TRM = CCR@TRM(CCR#CNE)
256800121213    *C                   EVAL      KF@PLN = CCR@PLN(CCR#CNE)
256900121213    *C                   EVAL      KF@ENR = CCR@ENR(CCR#CNE)
257000121213    ***
257100121213    *C     KL#MTR        CHAIN     AEB004F
257200121213    *C                   IF        %FOUND(AEB004WF)
257300121213     C                   IF        NTCOUNT > 1
257400121213    *C                   EVAL      CCR#CNE = 0
257500121213    *C                   EVAL      TERM_CCR = NO
257600121213     C                   ELSE
257700121213     C                   ADD       1             NTCOUNT
257800121213     C                   EVAL      NTTRANSD2      = #TODAY
257900121213     C                   UPDATE    AEB004F
258000121213     C                   LEAVESR
258100121213     C                   ENDIF
258200121213    *C                   ENDIF
258300121213    ***
258400121213     C                   EXSR      $WRTERM
258500121213    ***
258600121213    *C                   ENDSR
258700121213   S***S
258800121213     C     $PLANSRCH     BEGSR
258900121213    ***
259000121213     C                   MOVE      *BLANKS       PLN@CAT          10
259100121213     C                   EVAL      PP# = 0
259200121213     C                   CLEAR                   DS@CARPLN
259300121213    ***
259400121213     C                   DO        PC#
259500121213    * *
259600121213     C                   ADD       1             PP#
259700121213     C     PP#           OCCUR     CARPLN@
259800121213    * *
259900121213     C                   IF        XPPLAN = @PLANIN AND
260000121213     C                             XPCCTR = @CCTRIN
260100121213     C                   EVAL      DS@CARPLN = CARPLN@
260200121213     C                   EVAL      PLN@CAT = %TRIM(XPCID3)
260300121213     C                   LEAVE
260400121213     C                   ENDIF
260500121213    * *
260600121213     C                   ENDDO
260700121213    ***
260800121213     C                   ENDSR
260900121213   S***S
