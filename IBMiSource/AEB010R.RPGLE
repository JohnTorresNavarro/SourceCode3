000100130208   X***X CARRIER CONTROL ID #0000000073 ASSURANT SPECIFIC
000200130208   X***X SSK 12.13.2012 TEMPLATE DESIGN
000300130208   X***X THIS WAS BASED ON THE GUARDIAN DESIGN AND MODIFIED FROM THERE.
000400130208   X***X
000500130208   X***X
000600130208   X***X 02.08.2013 CLONED FROM AEB0X0R
000700130208   X***X MM.DD.YYYY AETNA APPROVED FOR PRODUCTION
000800130208   X***X
000900130208   X***X
001000130208   X***X ACCOUNTS SET-UP
001100130208   X***X 905-001-0432  DEAF RESEARCH
001200130208   X***X
001300130208   X***X
001400130208   X***X
001500130208   X***X
001600130208   X***X
001700130208   X***X
001800130208   X***X
001900130208   X***X
002000130208   X***X
002100130208   X***X
002200130208     FCARXPTP   IF   E           K DISK
002300130208     FCARACCP   IF   E           K DISK
002400130208     FCARPLNP   IF   E           K DISK
002500130208   X***X
002600130208     FAEB001WF  O  A E             DISK
002700130208     ** EXPORT FILE
002800130211     FAEB004WF  UF A E           K DISK
002900130208     ** TERM TRACKER
003000130208     **
003100130208     FMEMAC#1   IF   E           K DISK
003200130208     FMCOVMPLN  IF   E           K DISK
003300130208     FDEPNDC    IF   E           K DISK
003400130208     FELIGDCOV  IF   E           K DISK
003500130208   X***X
003600130208     D CARR#CTL        S             10A   INZ('0000000073')
003700130208   X***X
003800130211     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
003900130211     D DS@CARACC     E DS                  EXTNAME(CARACCP)
004000130211     D DS@CARXPT     E DS                  EXTNAME(CARXPTP)
004100130211   X***X
004200130211     ** WORK ARRAY FOR PLANS
004300130211     **
004400130211     ** PC# - PLAN COUNT
004500130211     ** PP# - PLAN POINTER
004600130211     **
004700130211     D CARPLN@       E DS                  EXTNAME(CARPLNP)
004800130211     D                                     OCCURS(50) PREFIX(X:1)
004900130211     **
005000130211     D PC#             S              3S 0
005100130211     D PP#             S              3S 0
005200130211     **
005300130211     D @PLANIN         S              4A
005400130211     D #EFFDTE         S              8S 0
005500130211     D #BENAMT         S                   LIKE(BENAMT)
005600130211     D @CCTRIN         S              3A
005700130211     D @ENRIN          S              3A
005800130211     D @ENROU          S              3A
005900130211   X***X
006000130211     **
006100130211     ** WRITE TYPE = MEMBER OR DEPEND
006200130211     D WRT@TYPE        S              6A
006300130211     **
006400130211   X***X
006500130211     D #CANCEL         S              8S 0
006600130211     D #DATE           S              8S 0
006700130320     D #SIGN           S               D   DATFMT(*ISO)
006800130211     D #ISO            S               D   DATFMT(*ISO)
006900130211     D #RECCNT         S             10S 0 INZ
007000130211     D #TODAY          S              8S 0
007100130211     D #XSX            S              8S 0
007200130211     D #15S0           S             15S 0
007300130211     D #7S0            S              7S 0
007400130211     **
007500130211     D MBR_TERM        S               N
007600130211     D TERM_MED        S               N
007700130211     D TERM_DEN        S               N
007800130211     D TERM_RXD        S               N
007900130211     D TERM_VIS        S               N
008000130211     D TERM_LIF        S               N
008100130211     D TERM_ADD        S               N
008200130211     D TERM_DLF        S               N
008300130211     D TERM_VLF        S               N
008400130211     D TERM_VAD        S               N
008500130211     D TERM_VLT        S               N
008600130211     D TERM_CRI        S               N
008700130211     D TERM_LTD        S               N
008800130211     D TERM_STD        S               N
008900130211     D TERM_VCI        S               N
009000130211     D TERM_ACC        S               N
009100130211     D TERM_CCR        S               N
009200130211     D YES             S               N   INZ(*ON)
009300130211     D NO              S               N   INZ(*OFF)
009400130211     **
009500130211     D KF@ACC          S                   LIKE(ACC#)
009600130211     D KF@CARG         S              2A   INZ
009700130211     D KF@CCTR         S                   LIKE(CCFLG)
009800130211     D KF@CDE          S              2A
009900130211     D KF@ENR          S              3A   INZ
010000130211     D KF@PLN          S                   LIKE(MCPLAN)
010100130211     D KF@SEQ          S                   LIKE(DPSEQ#)
010200130211     D KF@SSN          S                   LIKE(MBSSNO)
010300130211     D KF@SUB          S                   LIKE(MCSUB#)
010400130211     D KF@TRM          S              8S 0
010500130211     D KF@TRS          S                   LIKE(MCTRST)
010600130211     D KF@TYP          S              1A
010700130211     **
010800130211    ***
010900130211    *** MEDICAL ARRAYS
011000130211    *** CAT: PMM, PDM, PSM
011100130211     D MED#CNE         S              3S 0 INZ
011200130211     D MED#NDX         S              3S 0 INZ
011300130211     D MED@PLN         S              4A   DIM(20)
011400130211     D MED@ENR         S              3A   DIM(20)
011500130211     D MED@FRM         S              8S 0 DIM(20)
011600130211     D MED@TRM         S              8S 0 DIM(20)
011700130211     D MED@MEFF        S              8S 0
011800130211     D MED@MTRM        S              8S 0
011900130211    ***
012000130211    *** DENTAL ARRAYS
012100130211    *** CAT: PDN, PDE, PDR
012200130211     D DEN#CNE         S              3S 0 INZ
012300130211     D DEN#NDX         S              3S 0 INZ
012400130211     D DEN@PLN         S              4A   DIM(20)
012500130211     D DEN@ENR         S              3A   DIM(20)
012600130211     D DEN@FRM         S              8S 0 DIM(20)
012700130211     D DEN@TRM         S              8S 0 DIM(20)
012800130211     D DEN@MEFF        S              8S 0
012900130211     D DEN@MTRM        S              8S 0
013000130211    ***
013100130211    *** PRESCRIPTION DRUG ARRAYS
013200130211    *** CAT: PRX
013300130211     D RXD#CNE         S              3S 0 INZ
013400130211     D RXD#NDX         S              3S 0 INZ
013500130211     D RXD@PLN         S              4A   DIM(20)
013600130211     D RXD@ENR         S              3A   DIM(20)
013700130211     D RXD@FRM         S              8S 0 DIM(20)
013800130211     D RXD@TRM         S              8S 0 DIM(20)
013900130211     D RXD@MEFF        S              8S 0
014000130211     D RXD@MTRM        S              8S 0
014100130211    ***
014200130211    *** VISION         ARRAYS
014300130211    *** CAT: PVS, PVR
014400130211     D VIS#CNE         S              3S 0 INZ
014500130211     D VIS#NDX         S              3S 0 INZ
014600130211     D VIS@PLN         S              4A   DIM(20)
014700130211     D VIS@ENR         S              3A   DIM(20)
014800130211     D VIS@FRM         S              8S 0 DIM(20)
014900130211     D VIS@TRM         S              8S 0 DIM(20)
015000130211     D VIS@MEFF        S              8S 0
015100130211     D VIS@MTRM        S              8S 0
015200130211    ***
015300130211    *** LONG TERM DISABILITY ARRAYS - MEMBER ONLY
015400130211    *** CAT: PLT
015500130211     D LTD#CNE         S              3S 0 INZ
015600130211     D LTD#NDX         S              3S 0 INZ
015700130211     D LTD@PLN         S              4A   DIM(20)
015800130211     D LTD@ENR         S              3A   DIM(20)
015900130211     D LTD@VOL         S              7S 0 DIM(20)
016000130211     D LTD@FRM         S              8S 0 DIM(20)
016100130211     D LTD@TRM         S              8S 0 DIM(20)
016200130211     D LTD@MEFF        S              8S 0
016300130211     D LTD@MTRM        S              8S 0
016400130211    ***
016500130211    *** SHORT TERM DISABILITY ARRAYS  MEMBER ONLY
016600130211    *** CAT: PWD
016700130211     D STD#CNE         S              3S 0 INZ
016800130211     D STD#NDX         S              3S 0 INZ
016900130211     D STD@PLN         S              4A   DIM(20)
017000130211     D STD@ENR         S              3A   DIM(20)
017100130211     D STD@VOL         S              7S 0 DIM(20)
017200130211     D STD@FRM         S              8S 0 DIM(20)
017300130211     D STD@TRM         S              8S 0 DIM(20)
017400130211     D STD@MEFF        S              8S 0
017500130211     D STD@MTRM        S              8S 0
017600130211    ***
017700130211    *** BASIC LIFE ARRAYS
017800130211    *** CAT: PLF
017900130211     D LIF#CNE         S              3S 0 INZ
018000130211     D LIF#NDX         S              3S 0 INZ
018100130211     D LIF@PLN         S              4A   DIM(20)
018200130211     D LIF@ENR         S              3A   DIM(20)
018300130211     D LIF@VOL         S              7S 0 DIM(20)
018400130211     D LIF@FRM         S              8S 0 DIM(20)
018500130211     D LIF@TRM         S              8S 0 DIM(20)
018600130211     D LIF@MEFF        S              8S 0
018700130211     D LIF@MTRM        S              8S 0
018800130211    ***
018900130211    *** ACCIDENTAL DEATH AND DISMEMBERMENT ARRAYS MEMBER ONLY
019000130211    *** CAT: PAC, PA1
019100130211     D ADD#CNE         S              3S 0 INZ
019200130211     D ADD#NDX         S              3S 0 INZ
019300130211     D ADD@PLN         S              4A   DIM(20)
019400130211     D ADD@ENR         S              3A   DIM(20)
019500130211     D ADD@VOL         S              7S 0 DIM(20)
019600130211     D ADD@FRM         S              8S 0 DIM(20)
019700130211     D ADD@TRM         S              8S 0 DIM(20)
019800130211     D ADD@MEFF        S              8S 0
019900130211     D ADD@MTRM        S              8S 0
020000130211    ***
020100130211    *** DEPENDENT BASIC LIFE ARRAYS   DEPENDENTS ONLY
020200130211    *** CAT: PDL
020300130211     D DLF#CNE         S              3S 0 INZ
020400130211     D DLF#NDX         S              3S 0 INZ
020500130211     D DLF@PLN         S              4A   DIM(20)
020600130211     D DLF@ENR         S              3A   DIM(20)
020700130211     D DLF@VOL         S              7S 0 DIM(20)
020800130211     D DLF@FRM         S              8S 0 DIM(20)
020900130211     D DLF@TRM         S              8S 0 DIM(20)
021000130211     D DLF@MEFF        S              8S 0
021100130211     D DLF@MTRM        S              8S 0
021200130211    ***
021300130211    *** VOLUNTARY LIFE ARRAYS
021400130211    *** MBR CAT: PLS, PNE, PO4, PO5, PSL, PS4-6
021500130211    *** SPS CAT: PNS, PSP, PSS, PS1-3
021600130211    *** DEP CAT: PD1, PD2, PD3, PSD, PVD
021700130211     D VLF#CNE         S              3S 0 INZ
021800130211     D VLF#NDX         S              3S 0 INZ
021900130211     D VLF@PLN         S              4A   DIM(20)
022000130211     D VLF@ENR         S              3A   DIM(20)
022100130211     D VLF@VOL         S              7S 0 DIM(20)
022200130211     D VLF@FRM         S              8S 0 DIM(20)
022300130211     D VLF@TRM         S              8S 0 DIM(20)
022400130211     D VLF@MEFF        S              8S 0
022500130211     D VLF@MTRM        S              8S 0
022600130211    ***
022700130211    *** VOLUNTARY ACCIDENTAL DEATH AND DISMEMBERMENT ARRAYS
022800130211    *** CAT: PSA, POA, PAA, PS0/7-9
022900130211     D VAD#CNE         S              3S 0 INZ
023000130211     D VAD#NDX         S              3S 0 INZ
023100130211     D VAD@PLN         S              4A   DIM(20)
023200130211     D VAD@ENR         S              3A   DIM(20)
023300130211     D VAD@VOL         S              7S 0 DIM(20)
023400130211     D VAD@FRM         S              8S 0 DIM(20)
023500130211     D VAD@TRM         S              8S 0 DIM(20)
023600130211     D VAD@MEFF        S              8S 0
023700130211     D VAD@MTRM        S              8S 0
023800130211    ***
023900130211    *** VOLUNTARY LONG TERM DISABILITY ARRAYS
024000130211    *** CAT: PVL
024100130211     D VLT#CNE         S              3S 0 INZ
024200130211     D VLT#NDX         S              3S 0 INZ
024300130211     D VLT@PLN         S              4A   DIM(20)
024400130211     D VLT@ENR         S              3A   DIM(20)
024500130211     D VLT@VOL         S              7S 0 DIM(20)
024600130211     D VLT@FRM         S              8S 0 DIM(20)
024700130211     D VLT@TRM         S              8S 0 DIM(20)
024800130211     D VLT@MEFF        S              8S 0
024900130211     D VLT@MTRM        S              8S 0
025000130211    ***
025100130211    *** CRITICAL ILLNESS ARRAYS
025200130211    *** CAT: PCC
025300130211     D CRI#CNE         S              3S 0 INZ
025400130211     D CRI#NDX         S              3S 0 INZ
025500130211     D CRI@PLN         S              4A   DIM(20)
025600130211     D CRI@ENR         S              3A   DIM(20)
025700130211     D CRI@VOL         S              7S 0 DIM(20)
025800130211     D CRI@FRM         S              8S 0 DIM(20)
025900130211     D CRI@TRM         S              8S 0 DIM(20)
026000130211     D CRI@MEFF        S              8S 0
026100130211     D CRI@MTRM        S              8S 0
026200130211    ***
026300130211    *** VOLUNTARY CRITICAL ILLNESS ARRAYS
026400130211    *** CAT: P.. [WE CURRENTLY DO NOT OFFER THIS]
026500130211     D VCI#CNE         S              3S 0 INZ
026600130211     D VCI#NDX         S              3S 0 INZ
026700130211     D VCI@PLN         S              4A   DIM(20)
026800130211     D VCI@ENR         S              3A   DIM(20)
026900130211     D VCI@VOL         S              7S 0 DIM(20)
027000130211     D VCI@FRM         S              8S 0 DIM(20)
027100130211     D VCI@TRM         S              8S 0 DIM(20)
027200130211     D VCI@MEFF        S              8S 0
027300130211     D VCI@MTRM        S              8S 0
027400130211    ***
027500130211    *** ACCIDENT COVERAGE ARRAYS
027600130211    *** CAT: P.. [WE CURRENTLY DO NOT OFFER THIS]
027700130211     D ACC#CNE         S              3S 0 INZ
027800130211     D ACC#NDX         S              3S 0 INZ
027900130211     D ACC@PLN         S              4A   DIM(20)
028000130211     D ACC@ENR         S              3A   DIM(20)
028100130211     D ACC@VOL         S              7S 0 DIM(20)
028200130211     D ACC@FRM         S              8S 0 DIM(20)
028300130211     D ACC@TRM         S              8S 0 DIM(20)
028400130211     D ACC@MEFF        S              8S 0
028500130211    ***
028600130211    *** CANCER COVERAGE ARRAYS
028700130211    *** CAT: P.. [WE CURRENTLY DO NOT OFFER THIS]
028800130211     D CCR#CNE         S              3S 0 INZ
028900130211     D CCR#NDX         S              3S 0 INZ
029000130211     D CCR@PLN         S              4A   DIM(20)
029100130211     D CCR@ENR         S              3A   DIM(20)
029200130211     D CCR@VOL         S              7S 0 DIM(20)
029300130211     D CCR@FRM         S              8S 0 DIM(20)
029400130211     D CCR@TRM         S              8S 0 DIM(20)
029500130211     D CCR@MEFF        S              8S 0
029600130211    ***
029700130211    ***
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
031400130211    ***
031500130211     D @STEP           S              5A
031600130211   X***X
031700130211     C                   EVAL      @STEP = 'PREP0'
031800130211    ***
031900130211     C                   DOU       @STEP = 'LEAVE'
032000130211     C     @STEP         CASEQ     'PREP0'       $PREP0
032100130211     C     @STEP         CASEQ     'STEP0'       $STEP0
032200130211     C     @STEP         CASEQ     'PREP1'       $PREP1
032300130211     C     @STEP         CASEQ     'STEP1'       $STEP1
032400130211     C     @STEP         CASEQ     'STEP2'       $STEP2
032500130211     C     @STEP         CASEQ     'STEP3'       $STEP3
032600130211     C     @STEP         CASEQ     'PREP4'       $PREP4
032700130211     C     @STEP         CASEQ     'STEP4'       $STEP4
032800130211     C     @STEP         CASEQ     'PREP5'       $PREP5
032900130211     C     @STEP         CASEQ     'STEP5'       $STEP5
033000130211     C     @STEP         CASEQ     'STEP6'       $STEP6
033100130211     C     @STEP         CASEQ     'PREP7'       $PREP7
033200130211     C     @STEP         CASEQ     'STEP7'       $STEP7
033300130211     C                   ENDCS
033400130211     C                   ENDDO
033500130211    ***
033600130211     C                   EVAL      *INLR = *ON
033700130211   S***S
033800130211     C     $PREP0        BEGSR
033900130211    ***
034000130211     C     CARR#CTL      CHAIN     CARXPTR
034100130211    ***
034200130211     C     CARR#CTL      SETLL     CARACCR
034300130211    ***
034400130211     C                   EVAL      #ISO = %DATE
034500130211     C                   MOVE      #ISO          #TODAY
034600130211    ***
034700130211     C                   EVAL      @STEP = 'STEP0'
034800130211    ***
034900130211     C                   ENDSR
035000130211   S***S
035100130211     C     $STEP0        BEGSR
035200130211    ***
035300130211     C     CARR#CTL      READE     CARACCR
035400130211    ***
035500130211     C                   IF        %EOF(CARACCP)
035600130211     C                   EVAL      @STEP = 'LEAVE'
035700130211     C                   LEAVESR
035800130211     C                   ENDIF
035900130211    ***
036000130211    *** CAN THE ACCOUNT BE EXPORTED?
036100130211    ***
036200130211     C                   IF        CASTATUS = 'N'
036300130211     C                   LEAVESR
036400130211     C                   ENDIF
036500130211    ***
036600130211     C                   EVAL      @STEP = 'PREP1'
036700130211    ***
036800130211     C                   ENDSR
036900130211   S***S
037000130211     C     $PREP1        BEGSR
037100130211    ***
037200130211     C                   EVAL      KF@TRS = CATRST
037300130211     C                   EVAL      KF@SUB = CASUB#
037400130211     C                   EVAL      KF@ACC = CAACCT
037500130211    ***
037600130211     C                   EXSR      $PLANLOAD
037700130211    ***
037800130211     C                   EVAL      #RECCNT = 0
037900130211    ***
038000130211     C                   EVAL      @STEP = 'STEP1'
038100130211    ***
038200130211     C                   ENDSR
038300130211   S***S
038400130211    *** PLANS LOADED BY ACCOUNT
038500130211    ***
038600130211     C     $PLANLOAD     BEGSR
038700130211    ***
038800130211     C                   EVAL      PP# = 0
038900130211     C                   DO        50
039000130211     C                   ADD       1             PP#
039100130211     C     PP#           OCCUR     CARPLN@
039200130211     C                   CLEAR                   CARPLN@
039300130211     C                   ENDDO
039400130211     C                   EVAL      PC# = 0
039500130211     C                   EVAL      PP# = 0
039600130211    ***
039700130211     C     KL#ACCTL      SETLL     CARPLNR
039800130211     C                   DOU       %EOF(CARPLNP)
039900130211     C     KL#ACCTL      READE     CARPLNR
040000130211     C                   IF        NOT %EOF(CARPLNP)
040100130211    ***
040200130211     C                   ADD       1             PC#
040300130211     C     PC#           OCCUR     CARPLN@
040400130211     C                   EVAL      CARPLN@ = DS@CARPLN
040500130211    ***
040600130211     C                   ENDIF
040700130211     C                   ENDDO
040800130211    ***
040900130211     C                   ENDSR
041000130211   S***S
041100130211     C     $STEP1        BEGSR
041200130211    ***
041300130211     C                   EVAL      KF@PLN = *BLANKS
041400130211     C                   EVAL      KF@TRM = 0
041500130211     C                   EVAL      KF@SSN = 0
041600130211     C                   EVAL      KF@SEQ = 0
041700130211    ***
041800130211     C     KL#TSA        SETLL     MEMBR
041900130211    ***
042000130211     C                   EVAL      @STEP = 'STEP2'
042100130211    ***
042200130211     C                   ENDSR
042300130211   S***S
042400130211     C     $STEP2        BEGSR
042500130211    ***
042600130211     C     KL#TSA        READE     MEMBR
042700130211    ***
042800130211     C                   IF        %EOF(MEMAC#1)
042900130211     C                   EVAL      @STEP = 'STEP0'
043000130211     C                   LEAVESR
043100130211     C                   ENDIF
043200130211    ***
043300130211     C                   EVAL      KF@SSN = MBSSNO
043400130211     C                   MOVE      *ZEROS        KF@SEQ
043500130211    ***
043600130211     C                   IF        TERMDT > 0
043700130211     C                   EVAL      MBR_TERM = YES
043800130211     C                   ELSE
043900130211     C                   EVAL      MBR_TERM = NO
044000130211     C                   ENDIF
044100130211    ***
044200130211     C     KL#MPLN       SETLL     MCOVR
044300130211    ***
044400130211     C                   EXSR      $CLRSTG
044500130211    ***
044600130211     C                   EVAL      @STEP = 'STEP3'
044700130211    ***
044800130211     C                   ENDSR
044900130211   S***S
045000130211     C     $STEP3        BEGSR
045100130211    ***
045200130211     C     KL#MPLN       READE     MCOVR
045300130211    ***
045400130211     C                   IF        %EOF(MCOVMPLN)
045500130211     C                   EVAL      @STEP = 'PREP4'
045600130211     C                   LEAVESR
045700130211     C                   ENDIF
045800130211    ***
045900130211     C                   EVAL      @PLANIN = MCPLAN
046000130211     C                   EVAL      #EFFDTE = ENRLDT
046100130211     C                   EVAL      #BENAMT = BENAMT
046200130215     C                   EVAL      #CANCEL = CANDT
046300130211     **
046400130211     C                   EXSR      $QUIK
046500130211     **
046600130211     C                   EXSR      $PLANSRCH
046700130211    ***
046800130211     C                   IF        PLN@CAT = *BLANKS
046900130211     C                   LEAVESR
047000130211     C                   ENDIF
047100130211    ***
047200130211     C                   EVAL      @ENRIN = MCOVTP
047300130211     C                   EXSR      $TIERLVL
047400130211    ***
047500130215     C                   IF        #CANCEL = 0
047600130215     C                   EVAL      #CANCEL = 99999999
047700130215     C                   ENDIF
047800130211    ***
047900130211     C                   EXSR      $AD2MARY
048000130211    ***
048100130211     C                   ENDSR
048200130211   S***S
048300130211     C     $QUIK         BEGSR
048400130211    ***
048500130211     C                   EVAL      @CCTRIN = *BLANKS
048600130211    ***
048700130211     C                   IF        CACID4 = 'NORULE'
048800130211     C                   LEAVESR
048900130211     C                   ENDIF
049000130211    ***
049100130211     C     CACID4        CASEQ     'EMPSTS'      $ES
049200130211     C                   ENDCS
049300130211    ***
049400130211     C                   ENDSR
049500130211   S***S
049600130211     C     $ES           BEGSR
049700130211    ***
049800130211     C                   IF        EMPST =  'C'
049900130211     C                   EVAL      @CCTRIN = 'COB'
050000130211     C                   ELSE
050100130211     C                   EVAL      @CCTRIN = 'ACT'
050200130211     C                   ENDIF
050300130211    ***
050400130211     C                   ENDSR
050500130211   S***S
050600130211     ***JOBCLS MAPPING WAS HERE
050700130211   S***S
050800130211     C     $TIERLVL      BEGSR
050900130211    ***
051000130211     C                   SELECT
051100130211      *
051200130211     C                   WHEN      CPCID5 = 'E'
051300130211     C                   EVAL      @ENROU = 'EMP'
051400130211      *
051500130211     C                   WHEN      CPCID5 = 'S'
051600130211     C                   EVAL      @ENROU = 'SPO'
051700130211      *
051800130211     C                   WHEN      CPCID5 = 'C'
051900130211     C                   EVAL      @ENROU = 'CHD'
052000130211      *
052100130211     C                   WHEN      CPCID5 = '2'
052200130211     C                   IF        @ENRIN = 'TIN'
052300130211     C                   EVAL      @ENROU = 'EMP'
052400130211     C                   ELSE
052500130211     C                   EVAL      @ENROU = 'FAM'
052600130211     C                   ENDIF
052700130211      *
052800130211     C                   WHEN      CPCID5 = '4'
052900130211     C                   SELECT
053000130211     C                   WHEN      @ENRIN = 'TIN'
053100130211     C                   EVAL      @ENROU = 'EMP'
053200130211     C                   WHEN      @ENRIN = 'THW'
053300130211     C                   EVAL      @ENROU = 'ESP'
053400130211     C                   WHEN      @ENRIN = 'TPC' OR @ENRIN = 'TP2'
053500130211     C                   EVAL      @ENROU = 'ECH'
053600130211     C                   WHEN      @ENRIN = 'TFA'
053700130211     C                   EVAL      @ENROU = 'FAM'
053800130211     C                   ENDSL
053900130211      *
054000130211     C                   ENDSL
054100130211    ***
054200130211     C                   ENDSR
054300130211   S***S
054400130211     C     $AD2MARY      BEGSR
054500130211    ***
054600130211    *C                   IF        PLN@CAT = 'MM'
054700130211     C                   IF        MED#CNE > 0
054800130211     C                   IF        MED@TRM(MED#CNE) = 99999999
054900130211     C                   LEAVESR
055000130211     C                   ENDIF
055100130211     C                   ENDIF
055200130211    *C                   ADD       1             MED#CNE
055300130211    *C                   EVAL      MED@PLN(MED#CNE) = @PLANIN
055400130211    *C                   EVAL      MED@ENR(MED#CNE) = @ENROU
055500130211    *C                   EVAL      MED@FRM(MED#CNE) = #EFFDTE
055600130211    *C                   EVAL      MED@TRM(MED#CNE) = #CANCEL
055700130211     C                   LEAVESR
055800130211    *C                   ENDIF
055900130211    ***
056000130211    *C                   IF        PLN@CAT = 'DEN'
056100130211     C                   IF        DEN#CNE > 0
056200130211     C                   IF        DEN@TRM(DEN#CNE) = 99999999
056300130211     C                   LEAVESR
056400130211     C                   ENDIF
056500130211     C                   ENDIF
056600130211    *C                   ADD       1             DEN#CNE
056700130211    *C                   EVAL      DEN@PLN(DEN#CNE) = @PLANIN
056800130211    *C                   EVAL      DEN@ENR(DEN#CNE) = @ENROU
056900130211    *C                   EVAL      DEN@FRM(DEN#CNE) = #EFFDTE
057000130211    *C                   EVAL      DEN@TRM(DEN#CNE) = #CANCEL
057100130211     C                   LEAVESR
057200130211    *C                   ENDIF
057300130211    ***
057400130211    *C                   IF        PLN@CAT = 'RX'
057500130211     C                   IF        RXD#CNE > 0
057600130211     C                   IF        RXD@TRM(RXD#CNE) = 99999999
057700130211     C                   LEAVESR
057800130211     C                   ENDIF
057900130211     C                   ENDIF
058000130211    *C                   ADD       1             RXD#CNE
058100130211    *C                   EVAL      RXD@PLN(RXD#CNE) = @PLANIN
058200130211    *C                   EVAL      RXD@ENR(RXD#CNE) = @ENROU
058300130211    *C                   EVAL      RXD@FRM(RXD#CNE) = #EFFDTE
058400130211    *C                   EVAL      RXD@TRM(RXD#CNE) = #CANCEL
058500130211     C                   LEAVESR
058600130211    *C                   ENDIF
058700130211    ***
058800130211    *C                   IF        PLN@CAT = 'VIS'
058900130211     C                   IF        VIS#CNE > 0
059000130211     C                   IF        VIS@TRM(VIS#CNE) = 99999999
059100130211     C                   LEAVESR
059200130211     C                   ENDIF
059300130211     C                   ENDIF
059400130211    *C                   ADD       1             VIS#CNE
059500130211    *C                   EVAL      VIS@PLN(VIS#CNE) = @PLANIN
059600130211    *C                   EVAL      VIS@ENR(VIS#CNE) = @ENROU
059700130211    *C                   EVAL      VIS@FRM(VIS#CNE) = #EFFDTE
059800130211    *C                   EVAL      VIS@TRM(VIS#CNE) = #CANCEL
059900130211     C                   LEAVESR
060000130211    *C                   ENDIF
060100130211    ***
060200130211    *C                   IF        PLN@CAT = 'LTD'
060300130211     C                   IF        LTD#CNE > 0
060400130211     C                   IF        LTD@TRM(LTD#CNE) = 99999999
060500130211     C                   LEAVESR
060600130211     C                   ENDIF
060700130211     C                   ENDIF
060800130211    *C                   ADD       1             LTD#CNE
060900130211    *C                   EVAL      LTD@PLN(LTD#CNE) = @PLANIN
061000130211    *C                   EVAL      LTD@ENR(LTD#CNE) = @ENROU
061100130211     C                   EVAL      LTD@VOL(LTD#CNE) = #BENAMT
061200130211    *C                   EVAL      LTD@FRM(LTD#CNE) = #EFFDTE
061300130211    *C                   EVAL      LTD@TRM(LTD#CNE) = #CANCEL
061400130211     C                   LEAVESR
061500130211    *C                   ENDIF
061600130211    ***
061700130211    *C                   IF        PLN@CAT = 'STD'
061800130211     C                   IF        STD#CNE > 0
061900130211     C                   IF        STD@TRM(STD#CNE) = 99999999
062000130211     C                   LEAVESR
062100130211     C                   ENDIF
062200130211     C                   ENDIF
062300130211    *C                   ADD       1             STD#CNE
062400130211    *C                   EVAL      STD@PLN(STD#CNE) = @PLANIN
062500130211    *C                   EVAL      STD@ENR(STD#CNE) = @ENROU
062600130211     C                   EVAL      STD@VOL(STD#CNE) = #BENAMT
062700130211    *C                   EVAL      STD@FRM(STD#CNE) = #EFFDTE
062800130211    *C                   EVAL      STD@TRM(STD#CNE) = #CANCEL
062900130211     C                   LEAVESR
063000130211    *C                   ENDIF
063100130211    ***
063200130211    *C                   IF        PLN@CAT = 'AC'
063300130211     C                   IF        LIF#CNE > 0
063400130211     C                   IF        LIF@TRM(LIF#CNE) = 99999999
063500130211     C                   LEAVESR
063600130211     C                   ENDIF
063700130211     C                   ENDIF
063800130211    *C                   ADD       1             LIF#CNE
063900130211    *C                   EVAL      LIF@PLN(LIF#CNE) = @PLANIN
064000130211    *C                   EVAL      LIF@ENR(LIF#CNE) = @ENROU
064100130211     C                   EVAL      LIF@VOL(LIF#CNE) = #BENAMT
064200130211    *C                   EVAL      LIF@FRM(LIF#CNE) = #EFFDTE
064300130211    *C                   EVAL      LIF@TRM(LIF#CNE) = #CANCEL
064400130211     C                   LEAVESR
064500130211    *C                   ENDIF
064600130211    ***
064700130211    *C                   IF        PLN@CAT = 'ADD'
064800130211     C                   IF        ADD#CNE > 0
064900130211     C                   IF        ADD@TRM(ADD#CNE) = 99999999
065000130211     C                   LEAVESR
065100130211     C                   ENDIF
065200130211     C                   ENDIF
065300130211    *C                   ADD       1             ADD#CNE
065400130211    *C                   EVAL      ADD@PLN(ADD#CNE) = @PLANIN
065500130211    *C                   EVAL      ADD@ENR(ADD#CNE) = @ENROU
065600130211     C                   EVAL      ADD@VOL(ADD#CNE) = #BENAMT
065700130211    *C                   EVAL      ADD@FRM(ADD#CNE) = #EFFDTE
065800130211    *C                   EVAL      ADD@TRM(ADD#CNE) = #CANCEL
065900130211     C                   LEAVESR
066000130211    *C                   ENDIF
066100130211    ***
066200130211    *C                   IF        PLN@CAT = 'DEPLIF'
066300130211     C                   IF        DLF#CNE > 0
066400130211     C                   IF        DLF@TRM(DLF#CNE) = 99999999
066500130211     C                   LEAVESR
066600130211     C                   ENDIF
066700130211     C                   ENDIF
066800130211    *C                   ADD       1             DLF#CNE
066900130211    *C                   EVAL      DLF@PLN(DLF#CNE) = @PLANIN
067000130211    *C                   EVAL      DLF@ENR(DLF#CNE) = @ENROU
067100130211     C                   EVAL      DLF@VOL(DLF#CNE) = #BENAMT
067200130211    *C                   EVAL      DLF@FRM(DLF#CNE) = #EFFDTE
067300130211    *C                   EVAL      DLF@TRM(DLF#CNE) = #CANCEL
067400130211     C                   LEAVESR
067500130211    *C                   ENDIF
067600130211    ***
067700130211    *C                   IF        PLN@CAT = 'AF'
067800130211     C                   IF        VLF#CNE > 0
067900130211     C                   IF        VLF@TRM(VLF#CNE) = 99999999
068000130211     C                   LEAVESR
068100130211     C                   ENDIF
068200130211     C                   ENDIF
068300130211    *C                   ADD       1             VLF#CNE
068400130211    *C                   EVAL      VLF@PLN(VLF#CNE) = @PLANIN
068500130211    *C                   EVAL      VLF@ENR(VLF#CNE) = @ENROU
068600130211     C                   EVAL      VLF@VOL(VLF#CNE) = #BENAMT
068700130211    *C                   EVAL      VLF@FRM(VLF#CNE) = #EFFDTE
068800130211    *C                   EVAL      VLF@TRM(VLF#CNE) = #CANCEL
068900130211     C                   LEAVESR
069000130211    *C                   ENDIF
069100130211    ***
069200130211    *C                   IF        PLN@CAT = 'VOLADD'
069300130211     C                   IF        VAD#CNE > 0
069400130211     C                   IF        VAD@TRM(VAD#CNE) = 99999999
069500130211     C                   LEAVESR
069600130211     C                   ENDIF
069700130211     C                   ENDIF
069800130211    *C                   ADD       1             VAD#CNE
069900130211    *C                   EVAL      VAD@PLN(VAD#CNE) = @PLANIN
070000130211    *C                   EVAL      VAD@ENR(VAD#CNE) = @ENROU
070100130211     C                   EVAL      VAD@VOL(VAD#CNE) = #BENAMT
070200130211    *C                   EVAL      VAD@FRM(VAD#CNE) = #EFFDTE
070300130211    *C                   EVAL      VAD@TRM(VAD#CNE) = #CANCEL
070400130211     C                   LEAVESR
070500130211    *C                   ENDIF
070600130211    ***
070700130211    *C                   IF        PLN@CAT = 'VOLLTD'
070800130211     C                   IF        VLT#CNE > 0
070900130211     C                   IF        VLT@TRM(VLT#CNE) = 99999999
071000130211     C                   LEAVESR
071100130211     C                   ENDIF
071200130211     C                   ENDIF
071300130211    *C                   ADD       1             VLT#CNE
071400130211    *C                   EVAL      VLT@PLN(VLT#CNE) = @PLANIN
071500130211    *C                   EVAL      VLT@ENR(VLT#CNE) = @ENROU
071600130211     C                   EVAL      VLT@VOL(VLT#CNE) = #BENAMT
071700130211    *C                   EVAL      VLT@FRM(VLT#CNE) = #EFFDTE
071800130211    *C                   EVAL      VLT@TRM(VLT#CNE) = #CANCEL
071900130211     C                   LEAVESR
072000130211    *C                   ENDIF
072100130211    ***
072200130211    *C                   IF        PLN@CAT = 'CRITIL'
072300130211     C                   IF        CRI#CNE > 0
072400130211     C                   IF        CRI@TRM(CRI#CNE) = 99999999
072500130211     C                   LEAVESR
072600130211     C                   ENDIF
072700130211     C                   ENDIF
072800130211    *C                   ADD       1             CRI#CNE
072900130211    *C                   EVAL      CRI@PLN(CRI#CNE) = @PLANIN
073000130211    *C                   EVAL      CRI@ENR(CRI#CNE) = @ENROU
073100130211     C                   EVAL      CRI@VOL(CRI#CNE) = #BENAMT
073200130211    *C                   EVAL      CRI@FRM(CRI#CNE) = #EFFDTE
073300130211    *C                   EVAL      CRI@TRM(CRI#CNE) = #CANCEL
073400130211     C                   LEAVESR
073500130211    *C                   ENDIF
073600130211    ***
073700130211    *C                   IF        PLN@CAT = 'VOLCRIT'
073800130211     C                   IF        VCI#CNE > 0
073900130211     C                   IF        VCI@TRM(VCI#CNE) = 99999999
074000130211     C                   LEAVESR
074100130211     C                   ENDIF
074200130211     C                   ENDIF
074300130211    *C                   ADD       1             VCI#CNE
074400130211    *C                   EVAL      VCI@PLN(VCI#CNE) = @PLANIN
074500130211    *C                   EVAL      VCI@ENR(VCI#CNE) = @ENROU
074600130211     C                   EVAL      VCI@VOL(VCI#CNE) = #BENAMT
074700130211    *C                   EVAL      VCI@FRM(VCI#CNE) = #EFFDTE
074800130211    *C                   EVAL      VCI@TRM(VCI#CNE) = #CANCEL
074900130211     C                   LEAVESR
075000130211    *C                   ENDIF
075100130211    ***
075200130211    *C                   IF        PLN@CAT = 'ACC'
075300130211     C                   IF        ACC#CNE > 0
075400130211     C                   IF        ACC@TRM(ACC#CNE) = 99999999
075500130211     C                   LEAVESR
075600130211     C                   ENDIF
075700130211     C                   ENDIF
075800130211    *C                   ADD       1             ACC#CNE
075900130211    *C                   EVAL      ACC@PLN(ACC#CNE) = @PLANIN
076000130211    *C                   EVAL      ACC@ENR(ACC#CNE) = @ENROU
076100130211    *C                   EVAL      ACC@FRM(ACC#CNE) = #EFFDTE
076200130211    *C                   EVAL      ACC@TRM(ACC#CNE) = #CANCEL
076300130211     C                   LEAVESR
076400130211    *C                   ENDIF
076500130211    ***
076600130211    *C                   IF        PLN@CAT = 'CAN'
076700130211     C                   IF        CCR#CNE > 0
076800130211     C                   IF        CCR@TRM(CCR#CNE) = 99999999
076900130211     C                   LEAVESR
077000130211     C                   ENDIF
077100130211     C                   ENDIF
077200130211    *C                   ADD       1             CCR#CNE
077300130211    *C                   EVAL      CCR@PLN(CCR#CNE) = @PLANIN
077400130211    *C                   EVAL      CCR@ENR(CCR#CNE) = @ENROU
077500130211    *C                   EVAL      CCR@FRM(CCR#CNE) = #EFFDTE
077600130211    *C                   EVAL      CCR@TRM(CCR#CNE) = #CANCEL
077700130211     C                   LEAVESR
077800130211    *C                   ENDIF
077900130211    ***
078000130211     C                   ENDSR
078100130211   S***S
078200130211     C     $PREP4        BEGSR
078300130211    ***
078400130211     C                   IF        LIF#CNE  = 0 AND MED#CNE  = 0 AND
078500130211     C                             ADD#CNE  = 0 AND DEN#CNE  = 0 AND
078600130211     C                             DLF#CNE  = 0 AND RXD#CNE  = 0 AND
078700130211     C                             VLF#CNE  = 0 AND VIS#CNE  = 0 AND
078800130211     C                             VAD#CNE  = 0 AND LTD#CNE  = 0 AND
078900130211     C                             VLT#CNE  = 0 AND STD#CNE  = 0 AND
079000130211     C                             ACC#CNE  = 0 AND CCR#CNE  = 0 AND
079100130211     C                             CRI#CNE  = 0 AND VCI#CNE  = 0
079200130211     C                   EVAL      @STEP = 'STEP2'
079300130211     C                   LEAVESR
079400130211     C                   ENDIF
079500130211    ***
079600130211     C                   EVAL      TERM_LIF = NO
079700130211     C                   EVAL      TERM_ADD = NO
079800130211     C                   EVAL      TERM_DLF = NO
079900130211     C                   EVAL      TERM_VLF = NO
080000130211     C                   EVAL      TERM_VAD = NO
080100130211     C                   EVAL      TERM_VLT = NO
080200130211     C                   EVAL      TERM_CRI = NO
080300130211     C                   EVAL      TERM_MED = NO
080400130211     C                   EVAL      TERM_DEN = NO
080500130211     C                   EVAL      TERM_RXD = NO
080600130211     C                   EVAL      TERM_VIS = NO
080700130211     C                   EVAL      TERM_LTD = NO
080800130211     C                   EVAL      TERM_STD = NO
080900130211     C                   EVAL      TERM_VCI = NO
081000130211     C                   EVAL      TERM_ACC = NO
081100130211     C                   EVAL      TERM_CCR = NO
081200130211    ***
081300130211     C                   EXSR      $CHKHEM
081400130211    ***
081500130211     C                   EVAL      @STEP = 'STEP4'
081600130211    ***
081700130211     C                   ENDSR
081800130211   S***S
081900130211    *** GENERATE MEMBER RECORD
082000130211    ***
082100130211     C     $STEP4        BEGSR
082200130211    ***
082300130211     C                   IF        LIF#CNE  = 0 AND MED#CNE  = 0 AND
082400130211     C                             ADD#CNE  = 0 AND DEN#CNE  = 0 AND
082500130211     C                             DLF#CNE  = 0 AND RXD#CNE  = 0 AND
082600130211     C                             VLF#CNE  = 0 AND VIS#CNE  = 0 AND
082700130211     C                             VAD#CNE  = 0 AND LTD#CNE  = 0 AND
082800130211     C                             VLT#CNE  = 0 AND STD#CNE  = 0 AND
082900130211     C                             ACC#CNE  = 0 AND CCR#CNE  = 0 AND
083000130211     C                             CRI#CNE  = 0 AND VCI#CNE  = 0
083100130211     C                   EVAL      @STEP = 'STEP2'
083200130211     C                   LEAVESR
083300130211     C                   ENDIF
083400130211    ***
083500130211     C                   EVAL      WRT@TYPE = 'MEMBER'
083600130211    ***
083700130211     C                   EVAL      MED@MEFF = 0
083800130211     C                   EVAL      DEN@MEFF = 0
083900130211     C                   EVAL      RXD@MEFF = 0
084000130211     C                   EVAL      VIS@MEFF = 0
084100130211     C                   EVAL      LTD@MEFF = 0
084200130211     C                   EVAL      STD@MEFF = 0
084300130211    ***
084400130211     C                   EVAL      LIF@MEFF = 0
084500130211     C                   EVAL      ADD@MEFF = 0
084600130211     C                   EVAL      DLF@MEFF = 0
084700130211     C                   EVAL      VLF@MEFF = 0
084800130211     C                   EVAL      VAD@MEFF = 0
084900130211     C                   EVAL      VLT@MEFF = 0
085000130211     C                   EVAL      CRI@MEFF = 0
085100130211     C                   EVAL      VCI@MEFF = 0
085200130211     C                   EVAL      ACC@MEFF = 0
085300130211     C                   EVAL      CCR@MEFF = 0
085400130211    ***
085500130211     C                   EXSR      $FILLMBR
085600130211    ***
085700130211     C                   EXSR      $FILLCOVG
085800130211    ***
085900130211     C                   WRITE     AEBF010
086000130211     C                   ADD       1             #RECCNT
086100130211    ***
086200130211     C                   EVAL      @STEP = 'PREP5'
086300130211    ***
086400130211     C                   ENDSR
086500130211   S***S
086600130211     C     $FILLMBR      BEGSR
086700130211    ***
086800130211     C                   CLEAR                   AEBF010
086900130211    ***
087000130211     C                   EVAL      AEBG = %TRIM(CACID2)
087100130211     C                   EVAL      AESN = %TRIM(CACID1)
087200130211     C                   EVAL      AEEMPCD   = '1'
087300130211    ***
087400130211     C                   EVAL      AELNAM    = %TRIM(MLNAME)
087500130211     C                   EVAL      AEFNAM    = %TRIM(MFNAME)
087600130211     C                   EVAL      AEMNAM    = MMI
087700130211     C                   EVAL      AESSN     = %EDITC(MBSSNO:'X')
087800130211    ***
087900130305     C                   IF        %SUBST(ADDR1:1:1) <> 'X'
088000130211     C                   EVAL      AEADR1    = %TRIM(ADDR1)
088100130211     C                   EVAL      AEADR2    = %TRIM(ADDR2)
088200130211     C                   EVAL      AECITY    = %TRIM(CITY)
088300130211     C                   MOVE      *BLANKS       @9                9
088400130211     C                   EVAL      @9 = %EDITC(ZIP:'X')
088500130211     C                   EVAL      AEZIP     = %SUBST(@9:1:5)
088600130211     C                   EVAL      AESTATE   = STATE
088700130305     C                   EVAL      AECNTRY = 'US'
088800130305     C                   ENDIF
088900130305    ***
089000130305     C                   IF        AREA <> 0
089100130211     C                   EVAL      AEAREA    = %EDITC(AREA:'X')
089200130211     C                   EVAL      AEPHONE   = %EDITC(PHONE:'X')
089300130305     C                   ENDIF
089400130211    ***
089500130211     C                   IF        MBR_TERM = YES
089600130211     C                   EVAL      AERT = 'TRM'
089700130211     C                   EVAL      AETRMRSN  = '01'
089800130211     C                   EVAL      AEEFFDAT  = %CHAR(TERMDT)
089900130211     C                   ELSE
090000130211     C                   EVAL      AERT = 'ENR'
090100130211     C                   EVAL      AETRMRSN  = *BLANKS
090200130211     C                   EVAL      AEEFFDAT  = %CHAR(#TODAY)
090300130211     C                   ENDIF
090400130211    ***
090500130227     C                   EVAL      AESAL = *BLANKS
090600130227     C                   EVAL      AESFLG = *BLANKS
090700130227    ***
090800130211     C                   IF        CACID3 = 'Y'
090900130211     C     SALARY        MULT      100           #SAL             15 0
091000130211     C                   EVAL      AESAL     = %EDITC(#SAL:'X')
091100130227     C                   EVAL      AESFLG = '01'
091200130228     C                   EVAL      AEHRS = '040'
091300130211     C                   ENDIF
091400130211    ***
091500130211     C                   EVAL      AEGENDER  = SEX
091600130211     C                   EVAL      AEDOB     = %EDITC(BIRTH:'X')
091700130211     C                   EVAL      AEHIREDT  = %EDITC(EMPDT:'X')
091800130211     C                   EVAL      AEENROLL  = %EDITC(MBENRL:'X')
091900130211    ***
092000130211     C                   ENDSR
092100130211   S***S
092200130212     C     $FILLCOVG     BEGSR
092300130212    ***
092400130212     C                   IF        MED#CNE > 0
092500130212      * MEDICAL
092600130212    ***
092700130212     C                   EVAL      @PLANIN = MED@PLN(MED#CNE)
092800130212     C                   EXSR      $QUIK
092900130212     C                   EXSR      $PLANSRCH
093000130212     C                   IF        PLN@CAT = *BLANKS
093100130212     C     'MED FAIL'    DSPLY     '*EXT'
093200130212     C                   SETON                                        H1
093300130212     C                   ENDIF
093400130212      *
093500130212     C                   CLEAR                   AE@@
093600130212     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
093700130212     C                   EVAL      AE@@COV = MED@ENR(MED#CNE)
093800130212     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
093900130228     C                   EVAL      AEMG = %TRIM(CPCID1)
094000130212      *
094100130320     C                   EVAL      #XSX = MED@FRM(MED#CNE)
094200130320     C                   MOVE      #XSX          #SIGN
094300130320     C                   SUBDUR    1:*D          #SIGN
094400130320     C                   MOVE      #SIGN         #XSX
094500130320     C                   EVAL      AE@@DTS = '1'
094600130320     C                   MOVE      #XSX          AE@@SDTE
094700130320      *
094800130212     C                   EVAL      #CANCEL = MED@TRM(MED#CNE)
094900130212     C                   IF        #CANCEL = 99999999
095000130212     C                   EVAL      AE@@BAC = 'ENR'
095100130212     C                   EVAL      #XSX = MED@FRM(MED#CNE)
095200130212     C                   ELSE
095300130212     C                   EVAL      AE@@BAC = 'TRM'
095400130212     C                   EVAL      #XSX = MED@TRM(MED#CNE)
095500130212     C                   ENDIF
095600130212     C                   MOVE      #XSX          AE@@AED
095700130212      *
095800130212     C*                  EVAL      AE@@VOL = MDE@VOL(MED#CNE)
095900130212     C                   EVAL      AE@@DT = '0'
096000130212     C                   EVAL      #XSX = MED@FRM(MED#CNE)
096100130212     C                   MOVE      #XSX          AE@@MDTE
096200130212     C                   ADD       1             NDX
096300130212     C                   EVAL      @@AE(NDX) = AE@@
096400130212      *
096500130212     C                   ENDIF
096600130212    ***
096700130212     C                   IF        DEN#CNE > 0
096800130212      * DENTAL
096900130212     C                   EVAL      @PLANIN = DEN@PLN(DEN#CNE)
097000130212     C                   EXSR      $QUIK
097100130212     C                   EXSR      $PLANSRCH
097200130212     C                   IF        PLN@CAT = *BLANKS
097300130212     C     'DEN FILL'    DSPLY     '*EXT'
097400130212     C                   SETON                                        H1
097500130212     C                   ENDIF
097600130212      *
097700130212     C                   CLEAR                   AE@@
097800130212     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
097900130212     C                   EVAL      AE@@COV = DEN@ENR(DEN#CNE)
098000130212     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
098100130228     C                   EVAL      AEMG = %TRIM(CPCID1)
098200130212      *
098300130320     C                   EVAL      #XSX = DEN@FRM(DEN#CNE)
098400130320     C                   MOVE      #XSX          #SIGN
098500130320     C                   SUBDUR    1:*D          #SIGN
098600130320     C                   MOVE      #SIGN         #XSX
098700130320     C                   EVAL      AE@@DTS = '1'
098800130320     C                   MOVE      #XSX          AE@@SDTE
098900130320      *
099000130212     C                   EVAL      #CANCEL = DEN@TRM(DEN#CNE)
099100130212     C                   IF        #CANCEL = 99999999
099200130212     C                   EVAL      AE@@BAC = 'ENR'
099300130212     C                   EVAL      #XSX = DEN@FRM(DEN#CNE)
099400130212     C                   ELSE
099500130212     C                   EVAL      AE@@BAC = 'TRM'
099600130212     C                   EVAL      #XSX = DEN@TRM(DEN#CNE)
099700130212     C                   ENDIF
099800130212     C                   MOVE      #XSX          AE@@AED
099900130212      *
100000130212     C*                  EVAL      AE@@VOL = DEN@VOL(DEN#CNE)
100100130212     C                   EVAL      AE@@DT = '0'
100200130212     C                   EVAL      #XSX = DEN@FRM(DEN#CNE)
100300130212     C                   MOVE      #XSX          AE@@MDTE
100400130212     C                   ADD       1             NDX
100500130212     C                   EVAL      @@AE(NDX) = AE@@
100600130212      *
100700130212     C                   ENDIF
100800130212    ***
100900130212     C                   IF        RXD#CNE > 0
101000130212      * RXD
101100130212     C                   EVAL      @PLANIN = RXD@PLN(RXD#CNE)
101200130212     C                   EXSR      $QUIK
101300130212     C                   EXSR      $PLANSRCH
101400130212     C                   IF        PLN@CAT = *BLANKS
101500130212     C     'RXD FILL'    DSPLY     '*EXT'
101600130212     C                   SETON                                        H1
101700130212     C                   ENDIF
101800130212      *
101900130212     C                   CLEAR                   AE@@
102000130212     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
102100130212     C                   EVAL      AE@@COV = RXD@ENR(RXD#CNE)
102200130212     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
102300130228     C                   EVAL      AEMG = %TRIM(CPCID1)
102400130212      *
102500130320     C                   EVAL      #XSX = RXD@FRM(RXD#CNE)
102600130320     C                   MOVE      #XSX          #SIGN
102700130320     C                   SUBDUR    1:*D          #SIGN
102800130320     C                   MOVE      #SIGN         #XSX
102900130320     C                   EVAL      AE@@DTS = '1'
103000130320     C                   MOVE      #XSX          AE@@SDTE
103100130320      *
103200130212     C                   EVAL      #CANCEL = RXD@TRM(RXD#CNE)
103300130212     C                   IF        #CANCEL = 99999999
103400130212     C                   EVAL      AE@@BAC = 'ENR'
103500130212     C                   EVAL      #XSX = RXD@FRM(RXD#CNE)
103600130212     C                   ELSE
103700130212     C                   EVAL      AE@@BAC = 'TRM'
103800130212     C                   EVAL      #XSX = RXD@TRM(RXD#CNE)
103900130212     C                   ENDIF
104000130212     C                   MOVE      #XSX          AE@@AED
104100130212      *
104200130212     C*                  EVAL      AE@@VOL = RXD@VOL(RXD#CNE)
104300130212     C                   EVAL      AE@@DT = '0'
104400130212     C                   EVAL      #XSX = RXD@FRM(RXD#CNE)
104500130212     C                   MOVE      #XSX          AE@@MDTE
104600130212     C                   ADD       1             NDX
104700130212     C                   EVAL      @@AE(NDX) = AE@@
104800130212      *
104900130212     C                   ENDIF
105000130212    ***
105100130212     C                   IF        VIS#CNE > 0
105200130212      *  VISION
105300130212     C                   EVAL      @PLANIN = VIS@PLN(VIS#CNE)
105400130212     C                   EVAL      @ENRIN = VIS@ENR(VIS#CNE)
105500130212     C                   EXSR      $QUIK
105600130212     C                   EXSR      $PLANSRCH
105700130212     C                   IF        PLN@CAT = *BLANKS
105800130212     C     'VIS FILL'    DSPLY     '*EXT'
105900130212     C                   SETON                                        H1
106000130212     C                   ENDIF
106100130212      *
106200130212     C                   CLEAR                   AE@@
106300130212     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
106400130212     C                   EVAL      AE@@COV = VIS@ENR(VIS#CNE)
106500130212     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
106600130228     C                   EVAL      AEMG = %TRIM(CPCID1)
106700130212      *
106800130320     C                   EVAL      #XSX = VIS@FRM(VIS#CNE)
106900130320     C                   MOVE      #XSX          #SIGN
107000130320     C                   SUBDUR    1:*D          #SIGN
107100130320     C                   MOVE      #SIGN         #XSX
107200130320     C                   EVAL      AE@@DTS = '1'
107300130320     C                   MOVE      #XSX          AE@@SDTE
107400130320      *
107500130212     C                   EVAL      #CANCEL = VIS@TRM(VIS#CNE)
107600130212     C                   IF        #CANCEL = 99999999
107700130212     C                   EVAL      AE@@BAC = 'ENR'
107800130212     C                   EVAL      #XSX = VIS@FRM(VIS#CNE)
107900130212     C                   ELSE
108000130212     C                   EVAL      AE@@BAC = 'TRM'
108100130212     C                   EVAL      #XSX = VIS@TRM(VIS#CNE)
108200130212     C                   ENDIF
108300130212     C                   MOVE      #XSX          AE@@AED
108400130212      *
108500130212     C*                  EVAL      AE@@VOL = VIS@VOL(VIS#CNE)
108600130212     C                   EVAL      AE@@DT = '0'
108700130212     C                   EVAL      #XSX = VIS@FRM(VIS#CNE)
108800130212     C                   MOVE      #XSX          AE@@MDTE
108900130212     C                   ADD       1             NDX
109000130212     C                   EVAL      @@AE(NDX) = AE@@
109100130212      *
109200130212     C                   ENDIF
109300130212    ***
109400130212     C                   IF        LTD#CNE > 0 AND WRT@TYPE = 'MEMBER'
109500130212      * LTD
109600130212     C                   EVAL      @PLANIN = LTD@PLN(LTD#CNE)
109700130212     C                   EVAL      @ENRIN = LTD@ENR(LTD#CNE)
109800130212     C                   EXSR      $QUIK
109900130212     C                   EXSR      $PLANSRCH
110000130212     C                   IF        PLN@CAT = *BLANKS
110100130212     C     'LTD FILL'    DSPLY     '*EXT'
110200130212     C                   SETON                                        H1
110300130212     C                   ENDIF
110400130212      *
110500130212     C                   CLEAR                   AE@@
110600130212     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
110700130212     C                   EVAL      AE@@COV = LTD@ENR(LTD#CNE)
110800130212     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
110900130228     C                   EVAL      AEMG = %TRIM(CPCID1)
111000130212      *
111100130320     C                   EVAL      #XSX = LTD@FRM(LTD#CNE)
111200130320     C                   MOVE      #XSX          #SIGN
111300130320     C                   SUBDUR    1:*D          #SIGN
111400130320     C                   MOVE      #SIGN         #XSX
111500130320     C                   EVAL      AE@@DTS = '1'
111600130320     C                   MOVE      #XSX          AE@@SDTE
111700130320      *
111800130212     C                   EVAL      #CANCEL = LTD@TRM(LTD#CNE)
111900130212     C                   IF        #CANCEL = 99999999
112000130212     C                   EVAL      AE@@BAC = 'ENR'
112100130212     C                   EVAL      #XSX = LTD@FRM(LTD#CNE)
112200130212     C                   ELSE
112300130212     C                   EVAL      AE@@BAC = 'TRM'
112400130212     C                   EVAL      #XSX = LTD@TRM(LTD#CNE)
112500130212     C                   ENDIF
112600130212     C                   MOVE      #XSX          AE@@AED
112700130212      *
112800130212     C                   IF        CPCID6 = 'Y'
112900130212     C                   EVAL      #7S0 = LTD@VOL(LTD#CNE)
113000130212     C     #7S0          MULT      100           #15S0
113100130212     C                   MOVE      #15S0         AE@@VOL
113200130212     C                   ELSE
113300130212     C                   EVAL      AE@@VOL = *BLANKS
113400130212     C                   ENDIF
113500130212      *
113600130212     C                   EVAL      AE@@DT = '0'
113700130212     C                   EVAL      #XSX = LTD@FRM(LTD#CNE)
113800130212     C                   MOVE      #XSX          AE@@MDTE
113900130212     C                   ADD       1             NDX
114000130212     C                   EVAL      @@AE(NDX) = AE@@
114100130212      *
114200130212     C                   ENDIF
114300130212    ***
114400130212     C                   IF        STD#CNE > 0 AND WRT@TYPE = 'MEMBER'
114500130212      * STD
114600130212     C                   EVAL      @PLANIN = STD@PLN(STD#CNE)
114700130212     C                   EVAL      @ENRIN = STD@ENR(STD#CNE)
114800130212     C                   EXSR      $QUIK
114900130212     C                   EXSR      $PLANSRCH
115000130212     C                   IF        PLN@CAT = *BLANKS
115100130212     C     'STD FILL'    DSPLY     '*EXT'
115200130212     C                   SETON                                        H1
115300130212     C                   ENDIF
115400130212      *
115500130212     C                   CLEAR                   AE@@
115600130212     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
115700130212     C                   EVAL      AE@@COV = STD@ENR(STD#CNE)
115800130212     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
115900130228     C                   EVAL      AEMG = %TRIM(CPCID1)
116000130212      *
116100130320     C                   EVAL      #XSX = STD@FRM(STD#CNE)
116200130320     C                   MOVE      #XSX          #SIGN
116300130320     C                   SUBDUR    1:*D          #SIGN
116400130320     C                   MOVE      #SIGN         #XSX
116500130320     C                   EVAL      AE@@DTS = '1'
116600130320     C                   MOVE      #XSX          AE@@SDTE
116700130320      *
116800130212     C                   EVAL      #CANCEL = STD@TRM(STD#CNE)
116900130212     C                   IF        #CANCEL = 99999999
117000130212     C                   EVAL      AE@@BAC = 'ENR'
117100130212     C                   EVAL      #XSX = STD@FRM(STD#CNE)
117200130212     C                   ELSE
117300130212     C                   EVAL      AE@@BAC = 'TRM'
117400130212     C                   EVAL      #XSX = STD@TRM(STD#CNE)
117500130212     C                   ENDIF
117600130212     C                   MOVE      #XSX          AE@@AED
117700130212      *
117800130212     C                   IF        CPCID6 = 'Y'
117900130212     C                   EVAL      #7S0 = STD@VOL(STD#CNE)
118000130212     C     #7S0          MULT      100           #15S0
118100130212     C                   MOVE      #15S0         AE@@VOL
118200130212     C                   ELSE
118300130212     C                   EVAL      AE@@VOL = *BLANKS
118400130212     C                   ENDIF
118500130212      *
118600130212     C                   EVAL      AE@@DT = '0'
118700130212     C                   EVAL      #XSX = STD@FRM(STD#CNE)
118800130212     C                   MOVE      #XSX          AE@@MDTE
118900130212     C                   ADD       1             NDX
119000130212     C                   EVAL      @@AE(NDX) = AE@@
119100130212      *
119200130212     C                   ENDIF
119300130212    ***
119400130212     C                   IF        LIF#CNE > 0 AND WRT@TYPE = 'MEMBER'
119500130212      * BASIC LIFE
119600130212     C                   EVAL      @PLANIN = LIF@PLN(LIF#CNE)
119700130212     C                   EVAL      @ENRIN = LIF@ENR(LIF#CNE)
119800130212     C                   EXSR      $QUIK
119900130212     C                   EXSR      $PLANSRCH
120000130212     C                   IF        PLN@CAT = *BLANKS
120100130212     C     'LIF FILL'    DSPLY     '*EXT'
120200130212     C                   SETON                                        H1
120300130212     C                   ENDIF
120400130212      *
120500130212     C                   CLEAR                   AE@@
120600130212     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
120700130212     C                   EVAL      AE@@COV = LIF@ENR(LIF#CNE)
120800130212     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
120900130228     C                   EVAL      AEMG = %TRIM(CPCID1)
121000130212      *
121100130320     C                   EVAL      #XSX = LIF@FRM(LIF#CNE)
121200130320     C                   MOVE      #XSX          #SIGN
121300130320     C                   SUBDUR    1:*D          #SIGN
121400130320     C                   MOVE      #SIGN         #XSX
121500130320     C                   EVAL      AE@@DTS = '1'
121600130320     C                   MOVE      #XSX          AE@@SDTE
121700130320      *
121800130212     C                   EVAL      #CANCEL = LIF@TRM(LIF#CNE)
121900130212     C                   IF        #CANCEL = 99999999
122000130212     C                   EVAL      AE@@BAC = 'ENR'
122100130212     C                   EVAL      #XSX = LIF@FRM(LIF#CNE)
122200130212     C                   ELSE
122300130212     C                   EVAL      AE@@BAC = 'TRM'
122400130212     C                   EVAL      #XSX = LIF@TRM(LIF#CNE)
122500130212     C                   ENDIF
122600130212     C                   MOVE      #XSX          AE@@AED
122700130212      *
122800130212     C                   IF        CPCID6 = 'Y'
122900130212     C                   EVAL      #7S0 = LIF@VOL(LIF#CNE)
123000130212     C     #7S0          MULT      100           #15S0
123100130212     C                   MOVE      #15S0         AE@@VOL
123200130212     C                   ELSE
123300130212     C                   EVAL      AE@@VOL = *BLANKS
123400130212     C                   ENDIF
123500130212      *
123600130212     C                   EVAL      AE@@DT = '0'
123700130212     C                   EVAL      #XSX = LIF@FRM(LIF#CNE)
123800130212     C                   MOVE      #XSX          AE@@MDTE
123900130212     C                   ADD       1             NDX
124000130212     C                   EVAL      @@AE(NDX) = AE@@
124100130212      *
124200130212     C                   ENDIF
124300130212    ***
124400130212     C                   IF        ADD#CNE > 0 AND WRT@TYPE = 'MEMBER'
124500130212      * BASIC AD&D
124600130212     C                   EVAL      @PLANIN = ADD@PLN(ADD#CNE)
124700130212     C                   EVAL      @ENRIN = ADD@ENR(ADD#CNE)
124800130212     C                   EXSR      $QUIK
124900130212     C                   EXSR      $PLANSRCH
125000130212     C                   IF        PLN@CAT = *BLANKS
125100130212     C     'ADD FILL'    DSPLY     '*EXT'
125200130212     C                   SETON                                        H1
125300130212     C                   ENDIF
125400130212      *
125500130212     C                   CLEAR                   AE@@
125600130212     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
125700130212     C                   EVAL      AE@@COV = ADD@ENR(ADD#CNE)
125800130212     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
125900130228     C                   EVAL      AEMG = %TRIM(CPCID1)
126000130212      *
126100130320     C                   EVAL      #XSX = ADD@FRM(ADD#CNE)
126200130320     C                   MOVE      #XSX          #SIGN
126300130320     C                   SUBDUR    1:*D          #SIGN
126400130320     C                   MOVE      #SIGN         #XSX
126500130320     C                   EVAL      AE@@DTS = '1'
126600130320     C                   MOVE      #XSX          AE@@SDTE
126700130320      *
126800130212     C                   EVAL      #CANCEL = ADD@TRM(ADD#CNE)
126900130212     C                   IF        #CANCEL = 99999999
127000130212     C                   EVAL      AE@@BAC = 'ENR'
127100130212     C                   EVAL      #XSX = ADD@FRM(ADD#CNE)
127200130212     C                   ELSE
127300130212     C                   EVAL      AE@@BAC = 'TRM'
127400130212     C                   EVAL      #XSX = ADD@TRM(ADD#CNE)
127500130212     C                   ENDIF
127600130212     C                   MOVE      #XSX          AE@@AED
127700130212      *
127800130212     C                   IF        CPCID6 = 'Y'
127900130212     C                   EVAL      #7S0 = ADD@VOL(ADD#CNE)
128000130212     C     #7S0          MULT      100           #15S0
128100130212     C                   MOVE      #15S0         AE@@VOL
128200130212     C                   ELSE
128300130212     C                   EVAL      AE@@VOL = *BLANKS
128400130212     C                   ENDIF
128500130212      *
128600130212     C                   EVAL      AE@@DT = '0'
128700130212     C                   EVAL      #XSX = ADD@FRM(ADD#CNE)
128800130212     C                   MOVE      #XSX          AE@@MDTE
128900130212     C                   ADD       1             NDX
129000130212     C                   EVAL      @@AE(NDX) = AE@@
129100130212      *
129200130212     C                   ENDIF
129300130212    ***
129400130212     C                   IF        DLF#CNE > 0
129500130212      * DEPENDENT LIFE
129600130212     C                   EVAL      @PLANIN = DLF@PLN(DLF#CNE)
129700130212     C                   EVAL      @ENRIN = DLF@ENR(DLF#CNE)
129800130212     C                   EXSR      $QUIK
129900130212     C                   EXSR      $PLANSRCH
130000130212     C                   IF        PLN@CAT = *BLANKS
130100130212     C     'DLF FILL'    DSPLY     '*EXT'
130200130212     C                   SETON                                        H1
130300130212     C                   ENDIF
130400130212      *
130500130212     C                   CLEAR                   AE@@
130600130212     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
130700130212     C                   EVAL      AE@@COV = DLF@ENR(DLF#CNE)
130800130212     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
130900130228     C                   EVAL      AEMG = %TRIM(CPCID1)
131000130212      *
131100130320     C                   EVAL      #XSX = DLF@FRM(DLF#CNE)
131200130320     C                   MOVE      #XSX          #SIGN
131300130320     C                   SUBDUR    1:*D          #SIGN
131400130320     C                   MOVE      #SIGN         #XSX
131500130320     C                   EVAL      AE@@DTS = '1'
131600130320     C                   MOVE      #XSX          AE@@SDTE
131700130320      *
131800130212     C                   EVAL      #CANCEL = DLF@TRM(DLF#CNE)
131900130212     C                   IF        #CANCEL = 99999999
132000130212     C                   EVAL      AE@@BAC = 'ENR'
132100130212     C                   EVAL      #XSX = DLF@FRM(DLF#CNE)
132200130212     C                   ELSE
132300130212     C                   EVAL      AE@@BAC = 'TRM'
132400130212     C                   EVAL      #XSX = DLF@TRM(DLF#CNE)
132500130212     C                   ENDIF
132600130212     C                   MOVE      #XSX          AE@@AED
132700130212      *
132800130212     C                   IF        CPCID6 = 'Y'
132900130212     C                   EVAL      #7S0 = DLF@VOL(DLF#CNE)
133000130212     C     #7S0          MULT      100           #15S0
133100130212     C                   MOVE      #15S0         AE@@VOL
133200130212     C                   ELSE
133300130212     C                   EVAL      AE@@VOL = *BLANKS
133400130212     C                   ENDIF
133500130212      *
133600130212     C                   EVAL      AE@@DT = '0'
133700130212     C                   EVAL      #XSX = DLF@FRM(DLF#CNE)
133800130212     C                   MOVE      #XSX          AE@@MDTE
133900130212     C                   ADD       1             NDX
134000130212     C                   EVAL      @@AE(NDX) = AE@@
134100130212      *
134200130212     C                   ENDIF
134300130212    ***
134400130212     C                   IF        VLF#CNE > 0
134500130212      * VOL LIFE
134600130212     C                   EVAL      @PLANIN = VLF@PLN(VLF#CNE)
134700130212     C                   EVAL      @ENRIN = VLF@ENR(VLF#CNE)
134800130212     C                   EXSR      $QUIK
134900130212     C                   EXSR      $PLANSRCH
135000130212     C                   IF        PLN@CAT = *BLANKS
135100130212     C     'VLF FILL'    DSPLY     '*EXT'
135200130212     C                   SETON                                        H1
135300130212     C                   ENDIF
135400130212      *
135500130212     C                   CLEAR                   AE@@
135600130212     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
135700130212     C                   EVAL      AE@@COV = VLF@ENR(VLF#CNE)
135800130212     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
135900130228     C                   EVAL      AEMG = %TRIM(CPCID1)
136000130212      *
136100130320     C                   EVAL      #XSX = VLF@FRM(VLF#CNE)
136200130320     C                   MOVE      #XSX          #SIGN
136300130320     C                   SUBDUR    1:*D          #SIGN
136400130320     C                   MOVE      #SIGN         #XSX
136500130320     C                   EVAL      AE@@DTS = '1'
136600130320     C                   MOVE      #XSX          AE@@SDTE
136700130320      *
136800130212     C                   EVAL      #CANCEL = VLF@TRM(VLF#CNE)
136900130212     C                   IF        #CANCEL = 99999999
137000130212     C                   EVAL      AE@@BAC = 'ENR'
137100130212     C                   EVAL      #XSX = VLF@FRM(VLF#CNE)
137200130212     C                   ELSE
137300130212     C                   EVAL      AE@@BAC = 'TRM'
137400130212     C                   EVAL      #XSX = VLF@TRM(VLF#CNE)
137500130212     C                   ENDIF
137600130212     C                   MOVE      #XSX          AE@@AED
137700130212      *
137800130212     C                   IF        CPCID6 = 'Y'
137900130212     C                   EVAL      #7S0 = VLF@VOL(VLF#CNE)
138000130212     C     #7S0          MULT      100           #15S0
138100130212     C                   MOVE      #15S0         AE@@VOL
138200130212     C                   ELSE
138300130212     C                   EVAL      AE@@VOL = *BLANKS
138400130212     C                   ENDIF
138500130212      *
138600130212     C                   EVAL      AE@@DT = '0'
138700130212     C                   EVAL      #XSX = VLF@FRM(VLF#CNE)
138800130212     C                   MOVE      #XSX          AE@@MDTE
138900130212     C                   ADD       1             NDX
139000130212     C                   EVAL      @@AE(NDX) = AE@@
139100130212      *
139200130212     C                   ENDIF
139300130212    ***
139400130212     C                   IF        VAD#CNE > 0
139500130212      * VOLUNTARY AD&D
139600130212     C                   EVAL      @PLANIN = VAD@PLN(VAD#CNE)
139700130212     C                   EVAL      @ENRIN = VAD@ENR(VAD#CNE)
139800130212     C                   EXSR      $QUIK
139900130212     C                   EXSR      $PLANSRCH
140000130212     C                   IF        PLN@CAT = *BLANKS
140100130212     C     'VAD FILL'    DSPLY     '*EXT'
140200130212     C                   SETON                                        H1
140300130212     C                   ENDIF
140400130212      *
140500130212     C                   CLEAR                   AE@@
140600130212     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
140700130212     C                   EVAL      AE@@COV = VAD@ENR(VAD#CNE)
140800130212     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
140900130228     C                   EVAL      AEMG = %TRIM(CPCID1)
141000130212      *
141100130320     C                   EVAL      #XSX = VAD@FRM(VAD#CNE)
141200130320     C                   MOVE      #XSX          #SIGN
141300130320     C                   SUBDUR    1:*D          #SIGN
141400130320     C                   MOVE      #SIGN         #XSX
141500130320     C                   EVAL      AE@@DTS = '1'
141600130320     C                   MOVE      #XSX          AE@@SDTE
141700130320      *
141800130212     C                   EVAL      #CANCEL = VAD@TRM(VAD#CNE)
141900130212     C                   IF        #CANCEL = 99999999
142000130212     C                   EVAL      AE@@BAC = 'ENR'
142100130212     C                   EVAL      #XSX = VAD@FRM(VAD#CNE)
142200130212     C                   ELSE
142300130212     C                   EVAL      AE@@BAC = 'TRM'
142400130212     C                   EVAL      #XSX = VAD@TRM(VAD#CNE)
142500130212     C                   ENDIF
142600130212     C                   MOVE      #XSX          AE@@AED
142700130212      *
142800130212     C                   IF        CPCID6 = 'Y'
142900130212     C                   EVAL      #7S0 = VAD@VOL(VAD#CNE)
143000130212     C     #7S0          MULT      100           #15S0
143100130212     C                   MOVE      #15S0         AE@@VOL
143200130212     C                   ELSE
143300130212     C                   EVAL      AE@@VOL = *BLANKS
143400130212     C                   ENDIF
143500130212      *
143600130212     C                   EVAL      AE@@DT = '0'
143700130212     C                   EVAL      #XSX = VAD@FRM(VAD#CNE)
143800130212     C                   MOVE      #XSX          AE@@MDTE
143900130212     C                   ADD       1             NDX
144000130212     C                   EVAL      @@AE(NDX) = AE@@
144100130212      *
144200130212     C                   ENDIF
144300130212    ***
144400130212     C                   IF        VLT#CNE > 0
144500130212      * VOL LTD
144600130212     C                   EVAL      @PLANIN = VLT@PLN(VLT#CNE)
144700130212     C                   EVAL      @ENRIN = VLT@ENR(VLT#CNE)
144800130212     C                   EXSR      $QUIK
144900130212     C                   EXSR      $PLANSRCH
145000130212     C                   IF        PLN@CAT = *BLANKS
145100130212     C     'VLT FILL'    DSPLY     '*EXT'
145200130212     C                   SETON                                        H1
145300130212     C                   ENDIF
145400130212      *
145500130212     C                   CLEAR                   AE@@
145600130212     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
145700130212     C                   EVAL      AE@@COV = VLT@ENR(VLT#CNE)
145800130212     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
145900130228     C                   EVAL      AEMG = %TRIM(CPCID1)
146000130212      *
146100130320     C                   EVAL      #XSX = VLT@FRM(VLT#CNE)
146200130320     C                   MOVE      #XSX          #SIGN
146300130320     C                   SUBDUR    1:*D          #SIGN
146400130320     C                   MOVE      #SIGN         #XSX
146500130320     C                   EVAL      AE@@DTS = '1'
146600130320     C                   MOVE      #XSX          AE@@SDTE
146700130320      *
146800130212     C                   EVAL      #CANCEL = VLT@TRM(VLT#CNE)
146900130212     C                   IF        #CANCEL = 99999999
147000130212     C                   EVAL      AE@@BAC = 'ENR'
147100130212     C                   EVAL      #XSX = VLT@FRM(VLT#CNE)
147200130212     C                   ELSE
147300130212     C                   EVAL      AE@@BAC = 'TRM'
147400130212     C                   EVAL      #XSX = VLT@TRM(VLT#CNE)
147500130212     C                   ENDIF
147600130212     C                   MOVE      #XSX          AE@@AED
147700130212      *
147800130212     C                   IF        CPCID6 = 'Y'
147900130212     C                   EVAL      #7S0 = VLT@VOL(VLT#CNE)
148000130212     C     #7S0          MULT      100           #15S0
148100130212     C                   MOVE      #15S0         AE@@VOL
148200130212     C                   ELSE
148300130212     C                   EVAL      AE@@VOL = *BLANKS
148400130212     C                   ENDIF
148500130212      *
148600130212     C                   EVAL      AE@@DT = '0'
148700130212     C                   EVAL      #XSX = VLT@FRM(VLT#CNE)
148800130212     C                   MOVE      #XSX          AE@@MDTE
148900130212     C                   ADD       1             NDX
149000130212     C                   EVAL      @@AE(NDX) = AE@@
149100130212      *
149200130212     C                   ENDIF
149300130212    ***
149400130212     C                   IF        CRI#CNE > 0
149500130212      * CRITICAL ILLNESS
149600130212     C                   EVAL      @PLANIN = CRI@PLN(CRI#CNE)
149700130212     C                   EVAL      @ENRIN = CRI@ENR(CRI#CNE)
149800130212     C                   EXSR      $QUIK
149900130212     C                   EXSR      $PLANSRCH
150000130212     C                   IF        PLN@CAT = *BLANKS
150100130212     C     'CRI FILL'    DSPLY     '*EXT'
150200130212     C                   SETON                                        H1
150300130212     C                   ENDIF
150400130212      *
150500130212     C                   CLEAR                   AE@@
150600130212     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
150700130212     C                   EVAL      AE@@COV = CRI@ENR(CRI#CNE)
150800130212     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
150900130228     C                   EVAL      AEMG = %TRIM(CPCID1)
151000130212      *
151100130320     C                   EVAL      #XSX = CRI@FRM(CRI#CNE)
151200130320     C                   MOVE      #XSX          #SIGN
151300130320     C                   SUBDUR    1:*D          #SIGN
151400130320     C                   MOVE      #SIGN         #XSX
151500130320     C                   EVAL      AE@@DTS = '1'
151600130320     C                   MOVE      #XSX          AE@@SDTE
151700130320      *
151800130212     C                   EVAL      #CANCEL = CRI@TRM(CRI#CNE)
151900130212     C                   IF        #CANCEL = 99999999
152000130212     C                   EVAL      AE@@BAC = 'ENR'
152100130212     C                   EVAL      #XSX = CRI@FRM(CRI#CNE)
152200130212     C                   ELSE
152300130212     C                   EVAL      AE@@BAC = 'TRM'
152400130212     C                   EVAL      #XSX = CRI@TRM(CRI#CNE)
152500130212     C                   ENDIF
152600130212     C                   MOVE      #XSX          AE@@AED
152700130212      *
152800130212     C                   IF        CPCID6 = 'Y'
152900130212     C                   EVAL      #7S0 = CRI@VOL(CRI#CNE)
153000130212     C     #7S0          MULT      100           #15S0
153100130212     C                   MOVE      #15S0         AE@@VOL
153200130212     C                   ELSE
153300130212     C                   EVAL      AE@@VOL = *BLANKS
153400130212     C                   ENDIF
153500130212      *
153600130212     C                   EVAL      AE@@DT = '0'
153700130212     C                   EVAL      #XSX = CRI@FRM(CRI#CNE)
153800130212     C                   MOVE      #XSX          AE@@MDTE
153900130212     C                   ADD       1             NDX
154000130212     C                   EVAL      @@AE(NDX) = AE@@
154100130212      *
154200130212     C                   ENDIF
154300130212    ***
154400130212     C                   IF        VCI#CNE > 0
154500130212      * VOL CRITICAL ILLNESS
154600130212     C                   EVAL      @PLANIN = VCI@PLN(VCI#CNE)
154700130212     C                   EVAL      @ENRIN = VCI@ENR(VCI#CNE)
154800130212     C                   EXSR      $QUIK
154900130212     C                   EXSR      $PLANSRCH
155000130212     C                   IF        PLN@CAT = *BLANKS
155100130212     C     'VCI FILL'    DSPLY     '*EXT'
155200130212     C                   SETON                                        H1
155300130212     C                   ENDIF
155400130212      *
155500130212     C                   CLEAR                   AE@@
155600130212     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
155700130212     C                   EVAL      AE@@COV = VCI@ENR(VCI#CNE)
155800130212     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
155900130228     C                   EVAL      AEMG = %TRIM(CPCID1)
156000130212      *
156100130320     C                   EVAL      #XSX = VCI@FRM(VCI#CNE)
156200130320     C                   MOVE      #XSX          #SIGN
156300130320     C                   SUBDUR    1:*D          #SIGN
156400130320     C                   MOVE      #SIGN         #XSX
156500130320     C                   EVAL      AE@@DTS = '1'
156600130320     C                   MOVE      #XSX          AE@@SDTE
156700130320      *
156800130212     C                   EVAL      #CANCEL = VCI@TRM(VCI#CNE)
156900130212     C                   IF        #CANCEL = 99999999
157000130212     C                   EVAL      AE@@BAC = 'ENR'
157100130212     C                   EVAL      #XSX = VCI@FRM(VCI#CNE)
157200130212     C                   ELSE
157300130212     C                   EVAL      AE@@BAC = 'TRM'
157400130212     C                   EVAL      #XSX = VCI@TRM(VCI#CNE)
157500130212     C                   ENDIF
157600130212     C                   MOVE      #XSX          AE@@AED
157700130212      *
157800130212     C                   IF        CPCID6 = 'Y'
157900130212     C                   EVAL      #7S0 = VCI@VOL(VCI#CNE)
158000130212     C     #7S0          MULT      100           #15S0
158100130212     C                   MOVE      #15S0         AE@@VOL
158200130212     C                   ELSE
158300130212     C                   EVAL      AE@@VOL = *BLANKS
158400130212     C                   ENDIF
158500130212      *
158600130212     C                   EVAL      AE@@DT = '0'
158700130212     C                   EVAL      #XSX = VCI@FRM(VCI#CNE)
158800130212     C                   MOVE      #XSX          AE@@MDTE
158900130212     C                   ADD       1             NDX
159000130212     C                   EVAL      @@AE(NDX) = AE@@
159100130212      *
159200130212     C                   ENDIF
159300130212    ***
159400130212     C                   IF        ACC#CNE > 0
159500130212      * ACCIDENT COVERAGE
159600130212     C                   EVAL      @PLANIN = ACC@PLN(ACC#CNE)
159700130212     C                   EVAL      @ENRIN = ACC@ENR(ACC#CNE)
159800130212     C                   EXSR      $QUIK
159900130212     C                   EXSR      $PLANSRCH
160000130212     C                   IF        PLN@CAT = *BLANKS
160100130212     C     'ACC FILL'    DSPLY     '*EXT'
160200130212     C                   SETON                                        H1
160300130212     C                   ENDIF
160400130212      *
160500130212     C                   CLEAR                   AE@@
160600130212     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
160700130212     C                   EVAL      AE@@COV = ACC@ENR(ACC#CNE)
160800130212     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
160900130228     C                   EVAL      AEMG = %TRIM(CPCID1)
161000130212      *
161100130320     C                   EVAL      #XSX = ACC@FRM(ACC#CNE)
161200130320     C                   MOVE      #XSX          #SIGN
161300130320     C                   SUBDUR    1:*D          #SIGN
161400130320     C                   MOVE      #SIGN         #XSX
161500130320     C                   EVAL      AE@@DTS = '1'
161600130320     C                   MOVE      #XSX          AE@@SDTE
161700130320      *
161800130212     C                   EVAL      #CANCEL = ACC@TRM(ACC#CNE)
161900130212     C                   IF        #CANCEL = 99999999
162000130212     C                   EVAL      AE@@BAC = 'ENR'
162100130212     C                   EVAL      #XSX = ACC@FRM(ACC#CNE)
162200130212     C                   ELSE
162300130212     C                   EVAL      AE@@BAC = 'TRM'
162400130212     C                   EVAL      #XSX = ACC@TRM(ACC#CNE)
162500130212     C                   ENDIF
162600130212     C                   MOVE      #XSX          AE@@AED
162700130212      *
162800130212     C                   IF        CPCID6 = 'Y'
162900130212     C                   EVAL      #7S0 = ACC@VOL(ACC#CNE)
163000130212     C     #7S0          MULT      100           #15S0
163100130212     C                   MOVE      #15S0         AE@@VOL
163200130212     C                   ELSE
163300130212     C                   EVAL      AE@@VOL = *BLANKS
163400130212     C                   ENDIF
163500130212      *
163600130212     C                   EVAL      AE@@DT = '0'
163700130212     C                   EVAL      #XSX = ACC@FRM(ACC#CNE)
163800130212     C                   MOVE      #XSX          AE@@MDTE
163900130212     C                   ADD       1             NDX
164000130212     C                   EVAL      @@AE(NDX) = AE@@
164100130212      *
164200130212     C                   ENDIF
164300130212    ***
164400130212     C                   IF        CCR#CNE > 0
164500130212      * CANCER COVERAGE
164600130212     C                   EVAL      @PLANIN = CCR@PLN(CCR#CNE)
164700130212     C                   EVAL      @ENRIN = CCR@ENR(CCR#CNE)
164800130212     C                   EXSR      $QUIK
164900130212     C                   EXSR      $PLANSRCH
165000130212     C                   IF        PLN@CAT = *BLANKS
165100130212     C     'CCR FILL'    DSPLY     '*EXT'
165200130212     C                   SETON                                        H1
165300130212     C                   ENDIF
165400130212      *
165500130212     C                   CLEAR                   AE@@
165600130212     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
165700130212     C                   EVAL      AE@@COV = CCR@ENR(CCR#CNE)
165800130212     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
165900130228     C                   EVAL      AEMG = %TRIM(CPCID1)
166000130212      *
166100130320     C                   EVAL      #XSX = CCR@FRM(CCR#CNE)
166200130320     C                   MOVE      #XSX          #SIGN
166300130320     C                   SUBDUR    1:*D          #SIGN
166400130320     C                   MOVE      #SIGN         #XSX
166500130320     C                   EVAL      AE@@DTS = '1'
166600130320     C                   MOVE      #XSX          AE@@SDTE
166700130320      *
166800130212     C                   EVAL      #CANCEL = CCR@TRM(CCR#CNE)
166900130212     C                   IF        #CANCEL = 99999999
167000130212     C                   EVAL      AE@@BAC = 'ENR'
167100130212     C                   EVAL      #XSX = CCR@FRM(CCR#CNE)
167200130212     C                   ELSE
167300130212     C                   EVAL      AE@@BAC = 'TRM'
167400130212     C                   EVAL      #XSX = CCR@TRM(CCR#CNE)
167500130212     C                   ENDIF
167600130212     C                   MOVE      #XSX          AE@@AED
167700130212      *
167800130212     C                   IF        CPCID6 = 'Y'
167900130212     C                   EVAL      #7S0 = CCR@VOL(CCR#CNE)
168000130212     C     #7S0          MULT      100           #15S0
168100130212     C                   MOVE      #15S0         AE@@VOL
168200130212     C                   ELSE
168300130212     C                   EVAL      AE@@VOL = *BLANKS
168400130212     C                   ENDIF
168500130212      *
168600130212     C                   EVAL      AE@@DT = '0'
168700130212     C                   EVAL      #XSX = CCR@FRM(CCR#CNE)
168800130212     C                   MOVE      #XSX          AE@@MDTE
168900130212     C                   ADD       1             NDX
169000130212     C                   EVAL      @@AE(NDX) = AE@@
169100130212      *
169200130212     C                   ENDIF
169300130212    ***
169400130212     C                   ENDSR
169500130212   S***S
169600130212     C     $PREP5        BEGSR
169700130212    ***
169800130212     C     KF@SSN        CHAIN     DEPENR
169900130212     C                   IF        NOT %FOUND(DEPNDC)
170000130212     C                   EVAL      @STEP = 'STEP2'
170100130212     C                   LEAVESR
170200130212     C                   ENDIF
170300130212    ***
170400130212     C     KF@SSN        SETLL     DEPENR
170500130212    ***
170600130212     C                   EVAL      @STEP = 'STEP5'
170700130212    ***
170800130212     C                   ENDSR
170900130212   S***S
171000130212     C     $STEP5        BEGSR
171100130212    ***
171200130212     C     KF@SSN        READE     DEPENR
171300130212    ***
171400130212     C                   IF        %EOF(DEPNDC)
171500130212     C                   EVAL      @STEP = 'STEP2'
171600130212     C                   LEAVESR
171700130212     C                   ENDIF
171800130212    ***
171900130212     C                   EVAL      KF@SEQ = DPSEQ#
172000130212    ***
172100130212     C     KL#DCV        CHAIN     DCOVR
172200130212     C                   IF        NOT %FOUND(ELIGDCOV)
172300130212     C                   LEAVESR
172400130212     C                   ENDIF
172500130212    ***
172600130212     C                   EXSR      $CLRSTG
172700130212    ***
172800130212     C     KL#DCV        SETLL     DCOVR
172900130212    ***
173000130212     C                   EVAL      @STEP = 'STEP6'
173100130212    ***
173200130212     C                   ENDSR
173300130212   S***S
173400130212     C     $STEP6        BEGSR
173500130212    ***
173600130212     C     KL#DCV        READE     DCOVR
173700130212    ***
173800130212     C                   IF        %EOF(ELIGDCOV)
173900130212     C                   EVAL      @STEP = 'PREP7'
174000130212     C                   LEAVESR
174100130212     C                   ENDIF
174200130212    ***
174300130212     C                   EVAL      @PLANIN = DVPLAN
174400130212     C                   EVAL      @ENRIN = DVENRL
174500130212     C                   EVAL      #EFFDTE = DENRDT
174600130215     C                   EVAL      #CANCEL = CCANDT
174700130212    ***
174800130212     C                   EVAL      #BENAMT = 0
174900130212    ***
175000130212     C                   EXSR      $QUIK
175100130212    ***
175200130212     C                   EXSR      $PLANSRCH
175300130212    ***
175400130212     C                   IF        PLN@CAT = *BLANKS
175500130212     C                   LEAVESR
175600130212     C                   ENDIF
175700130212    ***
175800130215     C                   EXSR      $TIERLVL
175900130215    ***
176000130212     C                   IF        #CANCEL = 0
176100130212     C                   EVAL      #CANCEL = 99999999
176200130212     C                   ENDIF
176300130215    ***
176400130212     C                   EXSR      $AD2MARY
176500130212    ***
176600130212     C                   ENDSR
176700130212   S***S
176800130212     C     $PREP7        BEGSR
176900130212    ***
177000130212     C                   IF        LIF#CNE  = 0 AND MED#CNE  = 0 AND
177100130212     C                             ADD#CNE  = 0 AND DEN#CNE  = 0 AND
177200130212     C                             DLF#CNE  = 0 AND RXD#CNE  = 0 AND
177300130212     C                             VLF#CNE  = 0 AND VIS#CNE  = 0 AND
177400130212     C                             VAD#CNE  = 0 AND LTD#CNE  = 0 AND
177500130212     C                             VLT#CNE  = 0 AND STD#CNE  = 0 AND
177600130212     C                             ACC#CNE  = 0 AND CCR#CNE  = 0 AND
177700130212     C                             CRI#CNE  = 0 AND VCI#CNE  = 0
177800130212     C                   EVAL      @STEP = 'STEP5'
177900130212     C                   LEAVESR
178000130212     C                   ENDIF
178100130212    ***
178200130212     C                   EVAL      TERM_LIF = NO
178300130212     C                   EVAL      TERM_ADD = NO
178400130212     C                   EVAL      TERM_DLF = NO
178500130212     C                   EVAL      TERM_VLF = NO
178600130212     C                   EVAL      TERM_VAD = NO
178700130212     C                   EVAL      TERM_VLT = NO
178800130212     C                   EVAL      TERM_CRI = NO
178900130212     C                   EVAL      TERM_MED = NO
179000130212     C                   EVAL      TERM_DEN = NO
179100130212     C                   EVAL      TERM_RXD = NO
179200130212     C                   EVAL      TERM_VIS = NO
179300130212     C                   EVAL      TERM_LTD = NO
179400130212     C                   EVAL      TERM_STD = NO
179500130212     C                   EVAL      TERM_VCI = NO
179600130212     C                   EVAL      TERM_ACC = NO
179700130212     C                   EVAL      TERM_CCR = NO
179800130212    ***
179900130212     C                   EXSR      $CHKHEM
180000130212    ***
180100130212     C                   EVAL      @STEP = 'STEP7'
180200130212    ***
180300130212     C                   ENDSR
180400130212   S***S
180500130212     C     $STEP7        BEGSR
180600130212    ***
180700130212     C                   IF        LIF#CNE  = 0 AND MED#CNE  = 0 AND
180800130212     C                             ADD#CNE  = 0 AND DEN#CNE  = 0 AND
180900130212     C                             DLF#CNE  = 0 AND RXD#CNE  = 0 AND
181000130212     C                             VLF#CNE  = 0 AND VIS#CNE  = 0 AND
181100130212     C                             VAD#CNE  = 0 AND LTD#CNE  = 0 AND
181200130212     C                             VLT#CNE  = 0 AND STD#CNE  = 0 AND
181300130212     C                             ACC#CNE  = 0 AND CCR#CNE  = 0 AND
181400130212     C                             CRI#CNE  = 0 AND VCI#CNE  = 0
181500130212     C                   EVAL      @STEP = 'STEP5'
181600130212     C                   LEAVESR
181700130212     C                   ENDIF
181800130212    ***
181900130212     C                   EVAL      WRT@TYPE = 'DEPEND'
182000130212    ***
182100130212     C                   EXSR      $FILLDEP
182200130212    ***
182300130212     C                   EXSR      $FILLCOVG
182400130212    ***
182500130212     C                   WRITE     AEBF010
182600130212     C                   ADD       1             #RECCNT
182700130212    ***
182800130212     C                   EVAL      @STEP = 'STEP5'
182900130212    ***
183000130212     C                   ENDSR
183100130212   S***S
183200130212     C     $FILLDEP      BEGSR
183300130212    ***
183400130212     C                   CLEAR                   AEBF010
183500130212    ***
183600130212     C                   EVAL      AEBG = %TRIM(CACID2)
183700130212     C                   EVAL      AESN = %TRIM(CACID1)
183800130212    ***
183900130212     C                   SELECT
184000130212     C                   WHEN      DRELCD = 'RWI' OR DRELCD = 'RHU' OR
184100130212     C                             DRELCD = 'RPA'
184200130212     C                   EVAL      AEEMPCD   = '2'
184300130212     C                   WHEN      DRELCD = 'RSO' OR DRELCD = 'RDA'
184400130212     C                   EVAL      AEEMPCD   = '3'
184500130212     C                   OTHER
184600130212     C     'RELCD ERR'   DSPLY     '*EXT'
184700130212     C                   SETON                                        H1
184800130212     C                   ENDSL
184900130212    ***
185000130212     C                   EVAL      AELNAM    = %TRIM(DLNAME)
185100130212     C                   EVAL      AEFNAM    = %TRIM(DFNAME)
185200130212     C                   EVAL      AEMNAM    = DMI
185300130212    ***
185400130305     C                   IF        DEPSS# <>0
185500130212     C                   EVAL      AESSN     = %EDITC(DEPSS#:'X')
185600130305     C                   ENDIF
185700130212    ***
185800130212     C                   IF        DADDR1 = ADDR1 OR %TRIM(DADDR1) = 'SAME'
185900130212      *
186000130305     C                   IF        %SUBST(ADDR1:1:1) <> 'X'
186100130212     C                   EVAL      AEADR1    = %TRIM(ADDR1)
186200130212     C                   EVAL      AEADR2    = %TRIM(ADDR2)
186300130212     C                   EVAL      AECITY    = %TRIM(CITY)
186400130212     C                   MOVE      *BLANKS       @9                9
186500130212     C                   EVAL      @9 = %EDITC(ZIP:'X')
186600130212     C                   EVAL      AEZIP     = %SUBST(@9:1:5)
186700130212     C                   EVAL      AESTATE   = STATE
186800130305     C                   EVAL      AECNTRY = 'US'
186900130305     C                   ENDIF
187000130305     C                   IF        AREA <> 0
187100130212     C                   EVAL      AEAREA    = %EDITC(AREA:'X')
187200130212     C                   EVAL      AEPHONE   = %EDITC(PHONE:'X')
187300130305     C                   ENDIF
187400130212     C                   ELSE
187500130305     C                   IF        %SUBST(DADDR1:1:1) <> 'X'
187600130212     C                   EVAL      AEADR1    = %TRIM(DADDR1)
187700130212     C                   EVAL      AEADR2    = %TRIM(DADDR2)
187800130212     C                   EVAL      AECITY    = %TRIM(DCITY)
187900130212     C                   MOVE      *BLANKS       @9                9
188000130212     C                   EVAL      @9 = %EDITC(DZIP:'X')
188100130212     C                   EVAL      AEZIP     = %SUBST(@9:1:5)
188200130212     C                   EVAL      AESTATE   = DSTATE
188300130305     C                   EVAL      AECNTRY = 'US'
188400130305     C                   ENDIF
188500130305     C                   IF        DAREA <> 0
188600130212     C                   EVAL      AEAREA    = %EDITC(DAREA:'X')
188700130212     C                   EVAL      AEPHONE   = %EDITC(DPHONE:'X')
188800130305     C                   ENDIF
188900130212     C                   ENDIF
189000130212     **
189100130212     C                   EVAL      AERT = 'ENR'
189200130212     C                   EVAL      AETRMRSN  = *BLANKS
189300130212     C                   EVAL      AEEFFDAT  = %CHAR(#TODAY)
189400130212    ***
189500130212     C                   EVAL      AEGENDER = DSEX
189600130212     C                   EVAL      AEDOB     = %EDITC(DBIRTH:'X')
189700130212    ***
189800130212     C                   EVAL      AEHIREDT  = %EDITC(EMPDT:'X')
189900130212     C                   EVAL      AEENROLL  = %EDITC(MBENRL:'X')
190000130212    ***
190100130212     C                   ENDSR
190200130212   S***S
190300130212     C     *INZSR        BEGSR
190400130212    ***
190500130212     C                   EVAL      #RECCNT = 0
190600130212    ***
190700130212     C     KL#ACCTL      KLIST
190800130212     C                   KFLD                    CARR#CTL
190900130212     C                   KFLD                    KF@TRS
191000130212     C                   KFLD                    KF@SUB
191100130212     C                   KFLD                    KF@ACC
191200130212    ***
191300130212     C     KL#AUX        KLIST
191400130212     C                   KFLD                    KF@TRS
191500130212     C                   KFLD                    KF@SUB
191600130212     C                   KFLD                    KF@ACC
191700130212     C                   KFLD                    KF@SSN
191800130212     C                   KFLD                    KF@SEQ
191900130212    ***
192000130212     C     KL#TSA        KLIST
192100130212     C                   KFLD                    KF@TRS
192200130212     C                   KFLD                    KF@SUB
192300130212     C                   KFLD                    KF@ACC
192400130212    ***
192500130212     C     KL#MPLN       KLIST
192600130212     C                   KFLD                    KF@SSN
192700130212     C                   KFLD                    KF@SEQ
192800130212     C                   KFLD                    KF@TRS
192900130212     C                   KFLD                    KF@SUB
193000130212     C                   KFLD                    KF@ACC
193100130212    ***
193200130212     C     KL#CPLN       KLIST
193300130212     C                   KFLD                    CARR#CTL
193400130212     C                   KFLD                    KF@TRS
193500130212     C                   KFLD                    KF@SUB
193600130212     C                   KFLD                    KF@ACC
193700130212     C                   KFLD                    KF@CCTR
193800130212     C                   KFLD                    KF@PLN
193900130212    ***
194000130212     C     KL#DCV        KLIST
194100130212     C                   KFLD                    KF@SSN
194200130212     C                   KFLD                    KF@SEQ
194300130212    ***
194400130212     C     KL#MTR        KLIST
194500130212     C                   KFLD                    KF@SSN
194600130212     C                   KFLD                    KF@SEQ
194700130212     C                   KFLD                    KF@TRM
194800130212     C                   KFLD                    KF@PLN
194900130212     C                   KFLD                    KF@ENR
195000130212     C                   KFLD                    KF@TRS
195100130212     C                   KFLD                    KF@SUB
195200130212     C                   KFLD                    KF@ACC
195300130212    ***
195400130212     C                   ENDSR
195500130212   S***S
195600130212   S***S
195700130212     C     $CLRSTG       BEGSR
195800130214    ***
195900130214     C                   CLEAR                   DS@AEB
196000130214     C                   EVAL      NDX = 0
196100130214     C                   CLEAR                   AE@@
196200130212    ***
196300130212     C                   EVAL      #CANCEL = 0
196400130212    ***
196500130212     C                   EVAL                    MED#CNE = 0
196600130212     C                   EVAL                    MED#NDX = 0
196700130212     C                   CLEAR                   MED@PLN
196800130212     C                   CLEAR                   MED@ENR
196900130212     C                   CLEAR                   MED@FRM
197000130212     C                   CLEAR                   MED@TRM
197100130212    ***
197200130212     C                   EVAL                    DEN#CNE = 0
197300130212     C                   EVAL                    DEN#NDX = 0
197400130212     C                   CLEAR                   DEN@PLN
197500130212     C                   CLEAR                   DEN@ENR
197600130212     C                   CLEAR                   DEN@FRM
197700130212     C                   CLEAR                   DEN@TRM
197800130212    ***
197900130212     C                   EVAL                    RXD#CNE = 0
198000130212     C                   EVAL                    RXD#NDX = 0
198100130212     C                   CLEAR                   RXD@PLN
198200130212     C                   CLEAR                   RXD@ENR
198300130212     C                   CLEAR                   RXD@FRM
198400130212     C                   CLEAR                   RXD@TRM
198500130212    ***
198600130212     C                   EVAL                    VIS#CNE = 0
198700130212     C                   EVAL                    VIS#NDX = 0
198800130212     C                   CLEAR                   VIS@PLN
198900130212     C                   CLEAR                   VIS@ENR
199000130212     C                   CLEAR                   VIS@FRM
199100130212     C                   CLEAR                   VIS@TRM
199200130212    ***
199300130212     C                   EVAL                    LTD#CNE = 0
199400130212     C                   EVAL                    LTD#NDX = 0
199500130212     C                   CLEAR                   LTD@PLN
199600130212     C                   CLEAR                   LTD@ENR
199700130212     C                   CLEAR                   LTD@VOL
199800130212     C                   CLEAR                   LTD@FRM
199900130212     C                   CLEAR                   LTD@TRM
200000130212    ***
200100130212     C                   EVAL                    STD#CNE = 0
200200130212     C                   EVAL                    STD#NDX = 0
200300130212     C                   CLEAR                   STD@PLN
200400130212     C                   CLEAR                   STD@ENR
200500130212     C                   CLEAR                   STD@VOL
200600130212     C                   CLEAR                   STD@FRM
200700130212     C                   CLEAR                   STD@TRM
200800130212    ***
200900130212     C                   EVAL                    LIF#CNE = 0
201000130212     C                   EVAL                    LIF#NDX = 0
201100130212     C                   CLEAR                   LIF@PLN
201200130212     C                   CLEAR                   LIF@ENR
201300130212     C                   CLEAR                   LIF@VOL
201400130212     C                   CLEAR                   LIF@FRM
201500130212     C                   CLEAR                   LIF@TRM
201600130212    ***
201700130212     C                   EVAL                    ADD#CNE = 0
201800130212     C                   EVAL                    ADD#NDX = 0
201900130212     C                   CLEAR                   ADD@PLN
202000130212     C                   CLEAR                   ADD@ENR
202100130212     C                   CLEAR                   ADD@VOL
202200130212     C                   CLEAR                   ADD@FRM
202300130212     C                   CLEAR                   ADD@TRM
202400130212    ***
202500130212     C                   EVAL                    DLF#CNE = 0
202600130212     C                   EVAL                    DLF#NDX = 0
202700130212     C                   CLEAR                   DLF@PLN
202800130212     C                   CLEAR                   DLF@ENR
202900130212     C                   CLEAR                   DLF@VOL
203000130212     C                   CLEAR                   DLF@FRM
203100130212     C                   CLEAR                   DLF@TRM
203200130212    ***
203300130212     C                   EVAL                    VLF#CNE = 0
203400130212     C                   EVAL                    VLF#NDX = 0
203500130212     C                   CLEAR                   VLF@PLN
203600130212     C                   CLEAR                   VLF@ENR
203700130212     C                   CLEAR                   VLF@VOL
203800130212     C                   CLEAR                   VLF@FRM
203900130212     C                   CLEAR                   VLF@TRM
204000130212    ***
204100130212     C                   EVAL                    VAD#CNE = 0
204200130212     C                   EVAL                    VAD#NDX = 0
204300130212     C                   CLEAR                   VAD@PLN
204400130212     C                   CLEAR                   VAD@ENR
204500130212     C                   CLEAR                   VAD@VOL
204600130212     C                   CLEAR                   VAD@FRM
204700130212     C                   CLEAR                   VAD@TRM
204800130212    ***
204900130212     C                   EVAL                    VLT#CNE = 0
205000130212     C                   EVAL                    VLT#NDX = 0
205100130212     C                   CLEAR                   VLT@PLN
205200130212     C                   CLEAR                   VLT@ENR
205300130212     C                   CLEAR                   VLT@VOL
205400130212     C                   CLEAR                   VLT@FRM
205500130212     C                   CLEAR                   VLT@TRM
205600130212    ***
205700130212     C                   EVAL                    CRI#CNE = 0
205800130212     C                   EVAL                    CRI#NDX = 0
205900130212     C                   CLEAR                   CRI@PLN
206000130212     C                   CLEAR                   CRI@ENR
206100130212     C                   CLEAR                   CRI@VOL
206200130212     C                   CLEAR                   CRI@FRM
206300130212     C                   CLEAR                   CRI@TRM
206400130212    ***
206500130212     C                   EVAL                    VCI#CNE = 0
206600130212     C                   EVAL                    VCI#NDX = 0
206700130212     C                   CLEAR                   VCI@PLN
206800130212     C                   CLEAR                   VCI@ENR
206900130212     C                   CLEAR                   VCI@VOL
207000130212     C                   CLEAR                   VCI@FRM
207100130212     C                   CLEAR                   VCI@TRM
207200130212    ***
207300130212     C                   EVAL                    ACC#CNE = 0
207400130212     C                   EVAL                    ACC#NDX = 0
207500130212     C                   CLEAR                   ACC@PLN
207600130212     C                   CLEAR                   ACC@ENR
207700130212     C                   CLEAR                   ACC@FRM
207800130212     C                   CLEAR                   ACC@TRM
207900130212    ***
208000130212     C                   EVAL                    CCR#CNE = 0
208100130212     C                   EVAL                    CCR#NDX = 0
208200130212     C                   CLEAR                   CCR@PLN
208300130212     C                   CLEAR                   CCR@ENR
208400130212     C                   CLEAR                   CCR@FRM
208500130212     C                   CLEAR                   CCR@TRM
208600130212    ***
208700130212     C                   ENDSR
208800130212   S***S
208900130212     C     $CHKHEM       BEGSR
209000130212    ***
209100130212     C                   IF        MED#CNE > 0 AND MED@TRM(MED#CNE) <> 99999999
209200130212     C                   EXSR      $CHKMED
209300130212     C                   ENDIF
209400130212    ***
209500130212     C                   IF        DEN#CNE > 0 AND DEN@TRM(DEN#CNE) <> 99999999
209600130212     C                   EXSR      $CHKDEN
209700130212     C                   ENDIF
209800130212    ***
209900130212     C                   IF        RXD#CNE > 0 AND RXD@TRM(RXD#CNE) <> 99999999
210000130212     C                   EXSR      $CHKRXD
210100130212     C                   ENDIF
210200130212    ***
210300130212     C                   IF        VIS#CNE > 0 AND VIS@TRM(VIS#CNE) <> 99999999
210400130212     C                   EXSR      $CHKVIS
210500130212     C                   ENDIF
210600130212    ***
210700130212     C                   IF        LTD#CNE > 0 AND LTD@TRM(LTD#CNE) <> 99999999
210800130212     C                   EXSR      $CHKLTD
210900130212     C                   ENDIF
211000130212    ***
211100130212     C                   IF        STD#CNE > 0 AND STD@TRM(STD#CNE) <> 99999999
211200130212     C                   EXSR      $CHKSTD
211300130212     C                   ENDIF
211400130212    ***
211500130212     C                   IF        VCI#CNE > 0 AND VCI@TRM(VCI#CNE) <> 99999999
211600130212     C                   EXSR      $CHKVCI
211700130212     C                   ENDIF
211800130212    ***
211900130212     C                   IF        LIF#CNE > 0 AND LIF@TRM(LIF#CNE) <> 99999999
212000130212     C                   EXSR      $CHKLIF
212100130212     C                   ENDIF
212200130212    ***
212300130212     C                   IF        ADD#CNE > 0 AND ADD@TRM(ADD#CNE) <> 99999999
212400130212     C                   EXSR      $CHKADD
212500130212     C                   ENDIF
212600130212    ***
212700130212     C                   IF        DLF#CNE > 0 AND DLF@TRM(DLF#CNE) <> 99999999
212800130212     C                   EXSR      $CHKDLF
212900130212     C                   ENDIF
213000130212    ***
213100130212     C                   IF        VLF#CNE > 0 AND VLF@TRM(VLF#CNE) <> 99999999
213200130212     C                   EXSR      $CHKVLF
213300130212     C                   ENDIF
213400130212    ***
213500130212     C                   IF        VAD#CNE > 0 AND VAD@TRM(VAD#CNE) <> 99999999
213600130212     C                   EXSR      $CHKVAD
213700130212     C                   ENDIF
213800130212    ***
213900130212     C                   IF        VLT#CNE > 0 AND VLT@TRM(VLT#CNE) <> 99999999
214000130212     C                   EXSR      $CHKVLT
214100130212     C                   ENDIF
214200130212    ***
214300130212     C                   IF        CRI#CNE > 0 AND CRI@TRM(CRI#CNE) <> 99999999
214400130212     C                   EXSR      $CHKCRI
214500130212     C                   ENDIF
214600130212    ***
214700130212     C                   IF        ACC#CNE > 0 AND ACC@TRM(ACC#CNE) <> 99999999
214800130212     C                   EXSR      $CHKACC
214900130212     C                   ENDIF
215000130212    ***
215100130212     C                   IF        CCR#CNE > 0 AND CCR@TRM(CCR#CNE) <> 99999999
215200130212     C                   EXSR      $CHKCCR
215300130212     C                   ENDIF
215400130212    ***
215500130212     C                   ENDSR
215600130212   S***S
215700130212      * CHECK FOR MEDICAL TERMINATION
215800130212    *C     $CHKMED       BEGSR
215900130212    ***
216000130212    *C                   EVAL      TERM_MED = YES
216100130212    *C                   EVAL      KF@TRM = MED@TRM(MED#CNE)
216200130212    *C                   EVAL      KF@PLN = MED@PLN(MED#CNE)
216300130212    *C                   EVAL      KF@ENR = MED@ENR(MED#CNE)
216400130212    ***
216500130212    *C     KL#MTR        CHAIN     AEB004F
216600130212    *C                   IF        %FOUND(AEB004WF)
216700130212     C                   IF        NTCOUNT > 1
216800130212    *C                   EVAL      MED#CNE = 0
216900130212    *C                   EVAL      TERM_MED = NO
217000130212     C                   ELSE
217100130212     C                   ADD       1             NTCOUNT
217200130212     C                   EVAL      NTTRANSD2      = #TODAY
217300130212     C                   UPDATE    AEB004F
217400130212     C                   ENDIF
217500130606     C                   LEAVESR
217600130212    *C                   ENDIF
217700130212    ***
217800130212     C                   EXSR      $WRTERM
217900130212    ***
218000130212    *C                   ENDSR
218100130212   S***S
218200130212    *C     $WRTERM       BEGSR
218300130212    ***
218400130212    *C                   CLEAR                   AEB004F
218500130212     C                   EVAL      NTSSNO         = KF@SSN
218600130212     C                   EVAL      NTDEPNO        = KF@SEQ
218700130212     C                   EVAL      NTTERMDT       = KF@TRM
218800130212     C                   EVAL      NTPLAN         = KF@PLN
218900130212     C                   EVAL      NTCOVTP        = KF@ENR
219000130212     C                   EVAL      NTTRST         = KF@TRS
219100130212     C                   EVAL      NTSUB#         = KF@SUB
219200130212     C                   EVAL      NTACCT         = KF@ACC
219300130212     C                   EVAL      NTTRANSDT      = #TODAY
219400130212     C                   EVAL      NTCOUNT = 1
219500130212     C                   WRITE     AEB004F
219600130212    ***
219700130212    *C                   ENDSR
219800130212   S***S
219900130212      * CHECK FOR DENTAL TERMINATION
220000130212    *C     $CHKDEN       BEGSR
220100130212    ***
220200130212    *C                   EVAL      TERM_DEN = YES
220300130212    *C                   EVAL      KF@TRM = DEN@TRM(DEN#CNE)
220400130212    *C                   EVAL      KF@PLN = DEN@PLN(DEN#CNE)
220500130212    *C                   EVAL      KF@ENR = DEN@ENR(DEN#CNE)
220600130212    ***
220700130212    *C     KL#MTR        CHAIN     AEB004F
220800130212    *C                   IF        %FOUND(AEB004WF)
220900130212     C                   IF        NTCOUNT > 1
221000130212    *C                   EVAL      DEN#CNE = 0
221100130212    *C                   EVAL      TERM_DEN = NO
221200130212     C                   ELSE
221300130212     C                   ADD       1             NTCOUNT
221400130212     C                   EVAL      NTTRANSD2      = #TODAY
221500130212     C                   UPDATE    AEB004F
221600130212     C                   ENDIF
221700130606     C                   LEAVESR
221800130212    *C                   ENDIF
221900130212    ***
222000130212     C                   EXSR      $WRTERM
222100130212    ***
222200130212    *C                   ENDSR
222300130212   S***S
222400130212      * CHECK FOR DRUG TERMINATION
222500130212    *C     $CHKRXD       BEGSR
222600130212    ***
222700130212    *C                   EVAL      TERM_RXD = YES
222800130212    *C                   EVAL      KF@TRM = RXD@TRM(RXD#CNE)
222900130212    *C                   EVAL      KF@PLN = RXD@PLN(RXD#CNE)
223000130212    *C                   EVAL      KF@ENR = RXD@ENR(RXD#CNE)
223100130212    ***
223200130212    *C     KL#MTR        CHAIN     AEB004F
223300130212    *C                   IF        %FOUND(AEB004WF)
223400130212     C                   IF        NTCOUNT > 1
223500130212    *C                   EVAL      RXD#CNE = 0
223600130212    *C                   EVAL      TERM_RXD = NO
223700130212     C                   ELSE
223800130212     C                   ADD       1             NTCOUNT
223900130212     C                   EVAL      NTTRANSD2      = #TODAY
224000130212     C                   UPDATE    AEB004F
224100130606     C                   ENDIF
224200130606     C                   LEAVESR
224300130212    *C                   ENDIF
224400130212    ***
224500130212     C                   EXSR      $WRTERM
224600130212    ***
224700130212    *C                   ENDSR
224800130212   S***S
224900130212      * CHECK FOR VISION TERMINATION
225000130212    *C     $CHKVIS       BEGSR
225100130212    ***
225200130212    *C                   EVAL      TERM_VIS = YES
225300130212    *C                   EVAL      KF@TRM = VIS@TRM(VIS#CNE)
225400130212    *C                   EVAL      KF@PLN = VIS@PLN(VIS#CNE)
225500130212    *C                   EVAL      KF@ENR = VIS@ENR(VIS#CNE)
225600130212    ***
225700130212    *C     KL#MTR        CHAIN     AEB004F
225800130212    *C                   IF        %FOUND(AEB004WF)
225900130212     C                   IF        NTCOUNT > 1
226000130212    *C                   EVAL      VIS#CNE = 0
226100130212    *C                   EVAL      TERM_VIS = NO
226200130212     C                   ELSE
226300130212     C                   ADD       1             NTCOUNT
226400130212     C                   EVAL      NTTRANSD2      = #TODAY
226500130212     C                   UPDATE    AEB004F
226600130212     C                   ENDIF
226700130606     C                   LEAVESR
226800130212    *C                   ENDIF
226900130212    ***
227000130212     C                   EXSR      $WRTERM
227100130212    ***
227200130212    *C                   ENDSR
227300130212   S***S
227400130212      * CHECK FOR LTD TERMINATION
227500130212    *C     $CHKLTD       BEGSR
227600130212    ***
227700130212    *C                   EVAL      TERM_LTD = YES
227800130212    *C                   EVAL      KF@TRM = LTD@TRM(LTD#CNE)
227900130212    *C                   EVAL      KF@PLN = LTD@PLN(LTD#CNE)
228000130212    *C                   EVAL      KF@ENR = LTD@ENR(LTD#CNE)
228100130212    ***
228200130212    *C     KL#MTR        CHAIN     AEB004F
228300130212    *C                   IF        %FOUND(AEB004WF)
228400130212     C                   IF        NTCOUNT > 1
228500130212    *C                   EVAL      LTD#CNE = 0
228600130212    *C                   EVAL      TERM_LTD = NO
228700130212     C                   ELSE
228800130212     C                   ADD       1             NTCOUNT
228900130212     C                   EVAL      NTTRANSD2      = #TODAY
229000130212     C                   UPDATE    AEB004F
229100130212     C                   ENDIF
229200130606     C                   LEAVESR
229300130212    *C                   ENDIF
229400130212    ***
229500130212     C                   EXSR      $WRTERM
229600130212    ***
229700130212    *C                   ENDSR
229800130212   S***S
229900130212      * CHECK FOR STD TERMINATION
230000130212    *C     $CHKSTD       BEGSR
230100130212    ***
230200130212    *C                   EVAL      TERM_STD = YES
230300130212    *C                   EVAL      KF@TRM = STD@TRM(STD#CNE)
230400130212    *C                   EVAL      KF@PLN = STD@PLN(STD#CNE)
230500130212    *C                   EVAL      KF@ENR = STD@ENR(STD#CNE)
230600130212    ***
230700130212    *C     KL#MTR        CHAIN     AEB004F
230800130212    *C                   IF        %FOUND(AEB004WF)
230900130212     C                   IF        NTCOUNT > 1
231000130212    *C                   EVAL      STD#CNE = 0
231100130212    *C                   EVAL      TERM_STD = NO
231200130212     C                   ELSE
231300130212     C                   ADD       1             NTCOUNT
231400130212     C                   EVAL      NTTRANSD2      = #TODAY
231500130212     C                   UPDATE    AEB004F
231600130212     C                   ENDIF
231700130606     C                   LEAVESR
231800130212    *C                   ENDIF
231900130212    ***
232000130212     C                   EXSR      $WRTERM
232100130212    ***
232200130212    *C                   ENDSR
232300130212   S***S
232400130212      * CHECK FOR LIFE TERMINATION
232500130212    *C     $CHKLIF       BEGSR
232600130212    ***
232700130212    *C                   EVAL      TERM_LIF = YES
232800130212    *C                   EVAL      KF@TRM = LIF@TRM(LIF#CNE)
232900130212    *C                   EVAL      KF@PLN = LIF@PLN(LIF#CNE)
233000130212    *C                   EVAL      KF@ENR = LIF@ENR(LIF#CNE)
233100130212    ***
233200130212    *C     KL#MTR        CHAIN     AEB004F
233300130212    *C                   IF        %FOUND(AEB004WF)
233400130212     C                   IF        NTCOUNT > 1
233500130212    *C                   EVAL      LIF#CNE = 0
233600130212    *C                   EVAL      TERM_LIF = NO
233700130212     C                   ELSE
233800130212     C                   ADD       1             NTCOUNT
233900130212     C                   EVAL      NTTRANSD2      = #TODAY
234000130212     C                   UPDATE    AEB004F
234100130212     C                   ENDIF
234200130606     C                   LEAVESR
234300130212    *C                   ENDIF
234400130212    ***
234500130212     C                   EXSR      $WRTERM
234600130212    ***
234700130212    *C                   ENDSR
234800130212   S***S
234900130212      * CHECK FOR AD&D TERMINATION
235000130212    *C     $CHKADD       BEGSR
235100130212    ***
235200130212    *C                   EVAL      TERM_ADD = YES
235300130212    *C                   EVAL      KF@TRM = ADD@TRM(ADD#CNE)
235400130212    *C                   EVAL      KF@PLN = ADD@PLN(ADD#CNE)
235500130212    *C                   EVAL      KF@ENR = ADD@ENR(ADD#CNE)
235600130212    ***
235700130212    *C     KL#MTR        CHAIN     AEB004F
235800130212    *C                   IF        %FOUND(AEB004WF)
235900130212     C                   IF        NTCOUNT > 1
236000130212    *C                   EVAL      ADD#CNE = 0
236100130212    *C                   EVAL      TERM_ADD = NO
236200130212     C                   ELSE
236300130212     C                   ADD       1             NTCOUNT
236400130212     C                   EVAL      NTTRANSD2      = #TODAY
236500130212     C                   UPDATE    AEB004F
236600130212     C                   ENDIF
236700130606     C                   LEAVESR
236800130212    *C                   ENDIF
236900130212    ***
237000130212     C                   EXSR      $WRTERM
237100130212    ***
237200130212    *C                   ENDSR
237300130212   S***S
237400130212      * CHECK FOR DEPENDENT LIFE TERMINATION
237500130212    *C     $CHKDLF       BEGSR
237600130212    ***
237700130212    *C                   EVAL      TERM_DLF = YES
237800130212    *C                   EVAL      KF@TRM = DLF@TRM(DLF#CNE)
237900130212    *C                   EVAL      KF@PLN = DLF@PLN(DLF#CNE)
238000130212    *C                   EVAL      KF@ENR = DLF@ENR(DLF#CNE)
238100130212    ***
238200130212    *C     KL#MTR        CHAIN     AEB004F
238300130212    *C                   IF        %FOUND(AEB004WF)
238400130212     C                   IF        NTCOUNT > 1
238500130212    *C                   EVAL      DLF#CNE = 0
238600130212    *C                   EVAL      TERM_DLF = NO
238700130212     C                   ELSE
238800130212     C                   ADD       1             NTCOUNT
238900130212     C                   EVAL      NTTRANSD2      = #TODAY
239000130212     C                   UPDATE    AEB004F
239100130212     C                   ENDIF
239200130606     C                   LEAVESR
239300130212    *C                   ENDIF
239400130212    ***
239500130212     C                   EXSR      $WRTERM
239600130212    ***
239700130212    *C                   ENDSR
239800130212   S***S
239900130212      * CHECK FOR VOLUNATRY LIFE TERMINATION
240000130212    *C     $CHKVLF       BEGSR
240100130212    ***
240200130212    *C                   EVAL      TERM_VLF = YES
240300130212    *C                   EVAL      KF@TRM = VLF@TRM(VLF#CNE)
240400130212    *C                   EVAL      KF@PLN = VLF@PLN(VLF#CNE)
240500130212    *C                   EVAL      KF@ENR = VLF@ENR(VLF#CNE)
240600130212    ***
240700130212    *C     KL#MTR        CHAIN     AEB004F
240800130212    *C                   IF        %FOUND(AEB004WF)
240900130212     C                   IF        NTCOUNT > 1
241000130212    *C                   EVAL      VLF#CNE = 0
241100130212    *C                   EVAL      TERM_VLF = NO
241200130212     C                   ELSE
241300130212     C                   ADD       1             NTCOUNT
241400130212     C                   EVAL      NTTRANSD2      = #TODAY
241500130212     C                   UPDATE    AEB004F
241600130212     C                   ENDIF
241700130606     C                   LEAVESR
241800130212    *C                   ENDIF
241900130212    ***
242000130212     C                   EXSR      $WRTERM
242100130212    ***
242200130212    *C                   ENDSR
242300130212   S***S
242400130212      * CHECK FOR VOLUNATRY AD&D TERMINATION
242500130212    *C     $CHKVAD       BEGSR
242600130212    ***
242700130212    *C                   EVAL      TERM_VAD = YES
242800130212    *C                   EVAL      KF@TRM = VAD@TRM(VAD#CNE)
242900130212    *C                   EVAL      KF@PLN = VAD@PLN(VAD#CNE)
243000130212    *C                   EVAL      KF@ENR = VAD@ENR(VAD#CNE)
243100130212    ***
243200130212    *C     KL#MTR        CHAIN     AEB004F
243300130212    *C                   IF        %FOUND(AEB004WF)
243400130212     C                   IF        NTCOUNT > 1
243500130212    *C                   EVAL      VAD#CNE = 0
243600130212    *C                   EVAL      TERM_VAD = NO
243700130212     C                   ELSE
243800130212     C                   ADD       1             NTCOUNT
243900130212     C                   EVAL      NTTRANSD2      = #TODAY
244000130212     C                   UPDATE    AEB004F
244100130212     C                   ENDIF
244200130606     C                   LEAVESR
244300130212    *C                   ENDIF
244400130212    ***
244500130212     C                   EXSR      $WRTERM
244600130212    ***
244700130212    *C                   ENDSR
244800130212   S***S
244900130212      * CHECK FOR VOLUNATRY LTD TERMINATION
245000130212    *C     $CHKVLT       BEGSR
245100130212    ***
245200130212    *C                   EVAL      TERM_VLT = YES
245300130212    *C                   EVAL      KF@TRM = VLT@TRM(VLT#CNE)
245400130212    *C                   EVAL      KF@PLN = VLT@PLN(VLT#CNE)
245500130212    *C                   EVAL      KF@ENR = VLT@ENR(VLT#CNE)
245600130212    ***
245700130212    *C     KL#MTR        CHAIN     AEB004F
245800130212    *C                   IF        %FOUND(AEB004WF)
245900130212     C                   IF        NTCOUNT > 1
246000130212    *C                   EVAL      VLT#CNE = 0
246100130212    *C                   EVAL      TERM_VLT = NO
246200130212     C                   ELSE
246300130212     C                   ADD       1             NTCOUNT
246400130212     C                   EVAL      NTTRANSD2      = #TODAY
246500130212     C                   UPDATE    AEB004F
246600130212     C                   ENDIF
246700130606     C                   LEAVESR
246800130212    *C                   ENDIF
246900130212    ***
247000130212     C                   EXSR      $WRTERM
247100130212    ***
247200130212    *C                   ENDSR
247300130212   S***S
247400130212      * CHECK FOR CRITICAL ILLNESS TERMINATION
247500130212    *C     $CHKCRI       BEGSR
247600130212    ***
247700130212    *C                   EVAL      TERM_CRI = YES
247800130212    *C                   EVAL      KF@TRM = CRI@TRM(CRI#CNE)
247900130212    *C                   EVAL      KF@PLN = CRI@PLN(CRI#CNE)
248000130212    *C                   EVAL      KF@ENR = CRI@ENR(CRI#CNE)
248100130212    ***
248200130212    *C     KL#MTR        CHAIN     AEB004F
248300130212    *C                   IF        %FOUND(AEB004WF)
248400130212     C                   IF        NTCOUNT > 1
248500130212    *C                   EVAL      CRI#CNE = 0
248600130212    *C                   EVAL      TERM_CRI = NO
248700130212     C                   ELSE
248800130212     C                   ADD       1             NTCOUNT
248900130212     C                   EVAL      NTTRANSD2      = #TODAY
249000130212     C                   UPDATE    AEB004F
249100130212     C                   ENDIF
249200130606     C                   LEAVESR
249300130212    *C                   ENDIF
249400130212    ***
249500130212     C                   EXSR      $WRTERM
249600130212    ***
249700130212    *C                   ENDSR
249800130212   S***S
249900130212      * CHECK FOR VOLUNATRY CRITICAL ILLNESS TERMINATION
250000130212    *C     $CHKVCI       BEGSR
250100130212    ***
250200130212    *C                   EVAL      TERM_VCI = YES
250300130212    *C                   EVAL      KF@TRM = VCI@TRM(VCI#CNE)
250400130212    *C                   EVAL      KF@PLN = VCI@PLN(VCI#CNE)
250500130212    *C                   EVAL      KF@ENR = VCI@ENR(VCI#CNE)
250600130212    ***
250700130212    *C     KL#MTR        CHAIN     AEB004F
250800130212    *C                   IF        %FOUND(AEB004WF)
250900130212     C                   IF        NTCOUNT > 1
251000130212    *C                   EVAL      VCI#CNE = 0
251100130212    *C                   EVAL      TERM_VCI = NO
251200130212     C                   ELSE
251300130212     C                   ADD       1             NTCOUNT
251400130212     C                   EVAL      NTTRANSD2      = #TODAY
251500130212     C                   UPDATE    AEB004F
251600130212     C                   ENDIF
251700130606     C                   LEAVESR
251800130212    *C                   ENDIF
251900130212    ***
252000130212     C                   EXSR      $WRTERM
252100130212    ***
252200130212    *C                   ENDSR
252300130212   S***S
252400130212      * CHECK FOR ACCIDENT COVERAGE TERMINATION
252500130212    *C     $CHKACC       BEGSR
252600130212    ***
252700130212    *C                   EVAL      TERM_ACC = YES
252800130212    *C                   EVAL      KF@TRM = ACC@TRM(ACC#CNE)
252900130212    *C                   EVAL      KF@PLN = ACC@PLN(ACC#CNE)
253000130212    *C                   EVAL      KF@ENR = ACC@ENR(ACC#CNE)
253100130212    ***
253200130212    *C     KL#MTR        CHAIN     AEB004F
253300130212    *C                   IF        %FOUND(AEB004WF)
253400130212     C                   IF        NTCOUNT > 1
253500130212    *C                   EVAL      ACC#CNE = 0
253600130212    *C                   EVAL      TERM_ACC = NO
253700130212     C                   ELSE
253800130212     C                   ADD       1             NTCOUNT
253900130212     C                   EVAL      NTTRANSD2      = #TODAY
254000130212     C                   UPDATE    AEB004F
254100130212     C                   ENDIF
254200130606     C                   LEAVESR
254300130212    *C                   ENDIF
254400130212    ***
254500130212     C                   EXSR      $WRTERM
254600130212    ***
254700130212    *C                   ENDSR
254800130212   S***S
254900130212      * CHECK FOR CANCER COVERAGE TERMINATION
255000130212    *C     $CHKCCR       BEGSR
255100130212    ***
255200130212    *C                   EVAL      TERM_CCR = YES
255300130212    *C                   EVAL      KF@TRM = CCR@TRM(CCR#CNE)
255400130212    *C                   EVAL      KF@PLN = CCR@PLN(CCR#CNE)
255500130212    *C                   EVAL      KF@ENR = CCR@ENR(CCR#CNE)
255600130212    ***
255700130212    *C     KL#MTR        CHAIN     AEB004F
255800130212    *C                   IF        %FOUND(AEB004WF)
255900130212     C                   IF        NTCOUNT > 1
256000130212    *C                   EVAL      CCR#CNE = 0
256100130212    *C                   EVAL      TERM_CCR = NO
256200130212     C                   ELSE
256300130212     C                   ADD       1             NTCOUNT
256400130212     C                   EVAL      NTTRANSD2      = #TODAY
256500130212     C                   UPDATE    AEB004F
256600130212     C                   ENDIF
256700130606     C                   LEAVESR
256800130212    *C                   ENDIF
256900130212    ***
257000130212     C                   EXSR      $WRTERM
257100130212    ***
257200130212    *C                   ENDSR
257300130212   S***S
257400130212     C     $PLANSRCH     BEGSR
257500130212    ***
257600130212     C                   MOVE      *BLANKS       PLN@CAT          10
257700130212     C                   EVAL      PP# = 0
257800130212     C                   CLEAR                   DS@CARPLN
257900130212    ***
258000130212     C                   DO        PC#
258100130212    * *
258200130212     C                   ADD       1             PP#
258300130212     C     PP#           OCCUR     CARPLN@
258400130212    * *
258500130212     C                   IF        XPPLAN = @PLANIN AND
258600130212     C                             XPCCTR = @CCTRIN
258700130212     C                   EVAL      DS@CARPLN = CARPLN@
258800130212     C                   EVAL      PLN@CAT = %TRIM(XPCID3)
258900130212     C                   LEAVE
259000130212     C                   ENDIF
259100130212    * *
259200130212     C                   ENDDO
259300130212    ***
259400130212     C                   ENDSR
259500130212   S***S
