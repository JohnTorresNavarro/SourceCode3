000100130307   X***X CARRIER CONTROL ID #0000000076 ASSURANT SPECIFIC
000200121213   X***X SSK 12.13.2012 TEMPLATE DESIGN
000300130103   X***X THIS WAS BASED ON THE GUARDIAN DESIGN AND MODIFIED FROM THERE.
000400130103   X***X
000500121213   X***X
000600130307   X***X 03.07.2013 CLONED FROM AEB0X0R
000700130412   X***X 04.10.2013 ASSURANT APPROVED FOR PRODUCTION
000800121213   X***X
000900121213   X***X
001000121213   X***X ACCOUNTS SET-UP
001100130307   X***X 905-001-0238  LAND TRUST ALLIANCE, INC
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
002800130211     FAEB004WF  UF A E           K DISK
002900121213     ** TERM TRACKER
003000121213     **
003100121213     FMEMAC#1   IF   E           K DISK
003200121213     FMCOVMPLN  IF   E           K DISK
003300121213     FDEPNDC    IF   E           K DISK
003400121213     FELIGDCOV  IF   E           K DISK
003500121213   X***X
003600130307     D CARR#CTL        S             10A   INZ('0000000076')
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
004900130211     **
005000121213     D PC#             S              3S 0
005100121213     D PP#             S              3S 0
005200130211     **
005300121213     D @PLANIN         S              4A
005400121213     D #EFFDTE         S              8S 0
005500121213     D #BENAMT         S                   LIKE(BENAMT)
005600121213     D @CCTRIN         S              3A
005700121213     D @ENRIN          S              3A
005800121213     D @ENROU          S              3A
005900121214   X***X
006000121213     **
006100121213     ** WRITE TYPE = MEMBER OR DEPEND
006200121213     D WRT@TYPE        S              6A
006300121213     **
006400121213   X***X
006500130211     D #CANCEL         S              8S 0
006600121213     D #DATE           S              8S 0
006700130320     D #SIGN           S               D   DATFMT(*ISO)
006800130211     D #ISO            S               D   DATFMT(*ISO)
006900130211     D #RECCNT         S             10S 0 INZ
007000130211     D #TODAY          S              8S 0
007100130211     D #XSX            S              8S 0
007200130211     D #15S0           S             15S 0
007300130211     D #7S0            S              7S 0
007400130211     **
007500130103     D MBR_TERM        S               N
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
009000130102     D TERM_ACC        S               N
009100130102     D TERM_CCR        S               N
009200121213     D YES             S               N   INZ(*ON)
009300121213     D NO              S               N   INZ(*OFF)
009400130211     **
009500130211     D KF@ACC          S                   LIKE(ACC#)
009600130211     D KF@CARG         S              2A   INZ
009700130211     D KF@CCTR         S                   LIKE(CCFLG)
009800130211     D KF@CDE          S              2A
009900130211     D KF@ENR          S              3A   INZ
010000130211     D KF@PLN          S                   LIKE(MCPLAN)
010100130211     D KF@SEQ          S                   LIKE(DPSEQ#)
010200130211     D KF@SSN          S                   LIKE(MBSSNO)
010300121213     D KF@SUB          S                   LIKE(MCSUB#)
010400130211     D KF@TRM          S              8S 0
010500130211     D KF@TRS          S                   LIKE(MCTRST)
010600130211     D KF@TYP          S              1A
010700130211     **
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
027500130102    *** ACCIDENT COVERAGE ARRAYS
027600130102    *** CAT: P.. [WE CURRENTLY DO NOT OFFER THIS]
027700130102     D ACC#CNE         S              3S 0 INZ
027800130102     D ACC#NDX         S              3S 0 INZ
027900130102     D ACC@PLN         S              4A   DIM(20)
028000130102     D ACC@ENR         S              3A   DIM(20)
028100130211     D ACC@VOL         S              7S 0 DIM(20)
028200130102     D ACC@FRM         S              8S 0 DIM(20)
028300130102     D ACC@TRM         S              8S 0 DIM(20)
028400130102     D ACC@MEFF        S              8S 0
028500130102    ***
028600130102    *** CANCER COVERAGE ARRAYS
028700130102    *** CAT: P.. [WE CURRENTLY DO NOT OFFER THIS]
028800130102     D CCR#CNE         S              3S 0 INZ
028900130102     D CCR#NDX         S              3S 0 INZ
029000130102     D CCR@PLN         S              4A   DIM(20)
029100130102     D CCR@ENR         S              3A   DIM(20)
029200130211     D CCR@VOL         S              7S 0 DIM(20)
029300130102     D CCR@FRM         S              8S 0 DIM(20)
029400130102     D CCR@TRM         S              8S 0 DIM(20)
029500130102     D CCR@MEFF        S              8S 0
029600130102    ***
029700130102    ***
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
031400130102    ***
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
034500130103     C                   MOVE      #ISO          #TODAY
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
038300121214   S***S
038400121214    *** PLANS LOADED BY ACCOUNT
038500121214    ***
038600121214     C     $PLANLOAD     BEGSR
038700121214    ***
038800121214     C                   EVAL      PP# = 0
038900121214     C                   DO        50
039000121214     C                   ADD       1             PP#
039100121214     C     PP#           OCCUR     CARPLN@
039200121214     C                   CLEAR                   CARPLN@
039300121214     C                   ENDDO
039400121214     C                   EVAL      PC# = 0
039500121214     C                   EVAL      PP# = 0
039600121214    ***
039700121214     C     KL#ACCTL      SETLL     CARPLNR
039800121214     C                   DOU       %EOF(CARPLNP)
039900121214     C     KL#ACCTL      READE     CARPLNR
040000121214     C                   IF        NOT %EOF(CARPLNP)
040100121214    ***
040200121214     C                   ADD       1             PC#
040300121214     C     PC#           OCCUR     CARPLN@
040400121214     C                   EVAL      CARPLN@ = DS@CARPLN
040500121214    ***
040600121214     C                   ENDIF
040700121214     C                   ENDDO
040800121214    ***
040900121214     C                   ENDSR
041000121213   S***S
041100121213     C     $STEP1        BEGSR
041200121213    ***
041300121213     C                   EVAL      KF@PLN = *BLANKS
041400130211     C                   EVAL      KF@TRM = 0
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
043000130208     C                   LEAVESR
043100130208     C                   ENDIF
043200121213    ***
043300121213     C                   EVAL      KF@SSN = MBSSNO
043400121213     C                   MOVE      *ZEROS        KF@SEQ
043500130103    ***
043600130103     C                   IF        TERMDT > 0
043700130103     C                   EVAL      MBR_TERM = YES
043800130103     C                   ELSE
043900130103     C                   EVAL      MBR_TERM = NO
044000130103     C                   ENDIF
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
046200130227     C                   EVAL      #CANCEL = CANDT
046300121213     **
046400121213     C                   EXSR      $QUIK
046500121213     **
046600121213     C                   EXSR      $PLANSRCH
046700121213    ***
046800121213     C                   IF        PLN@CAT = *BLANKS
046900121213     C                   LEAVESR
047000121213     C                   ENDIF
047100130204    ***
047200130204     C                   EVAL      @ENRIN = MCOVTP
047300130204     C                   EXSR      $TIERLVL
047400130227    ***
047500130227     C                   IF        #CANCEL = 0
047600130227     C                   EVAL      #CANCEL = 99999999
047700130227     C                   ENDIF
047800121213    ***
047900121213     C                   EXSR      $AD2MARY
048000121213    ***
048100121213     C                   ENDSR
048200130103   S***S
048300130103     C     $QUIK         BEGSR
048400130103    ***
048500130103     C                   EVAL      @CCTRIN = *BLANKS
048600130204    ***
048700130204     C                   IF        CACID4 = 'NORULE'
048800130204     C                   LEAVESR
048900130204     C                   ENDIF
049000130103    ***
049100130204     C     CACID4        CASEQ     'EMPSTS'      $ES
049200130313     C*****CACID4        CASEQ     'JOBCLASS'    $JC
049300130204     C                   ENDCS
049400130204    ***
049500130204     C                   ENDSR
049600130204   S***S
049700130204     C     $ES           BEGSR
049800130204    ***
049900130204     C                   IF        EMPST =  'C'
050000130204     C                   EVAL      @CCTRIN = 'COB'
050100130204     C                   ELSE
050200130204     C                   EVAL      @CCTRIN = 'ACT'
050300130204     C                   ENDIF
050400130204    ***
050500130204     C                   ENDSR
050600130204   S***S
050700130313    *C*    $JC           BEGSR
050800130313    ***
050900130313    *C*                  SELECT
051000130313    *C*                  WHEN      EMPST =  'C'
051100130313    *C*                  EVAL      @CCTRIN = 'COB'
051200130313    *C*                  WHEN      X= Y
051300130313    *C*                  EVAL      @CCTRIN = 'HR'
051400130313    *C*                  WHEN      X= Y
051500130313    *C*                  EVAL      @CCTRIN = 'SAL'
051600130313    *C*                  ENDSL
051700130313    ***
051800130313    *C*                  ENDSR
051900130204   S***S
052000130204     C     $TIERLVL      BEGSR
052100130204    ***
052200130204     C                   SELECT
052300130204      *
052400130211     C                   WHEN      CPCID5 = 'E'
052500130204     C                   EVAL      @ENROU = 'EMP'
052600130204      *
052700130211     C                   WHEN      CPCID5 = 'S'
052800130204     C                   EVAL      @ENROU = 'SPO'
052900130204      *
053000130211     C                   WHEN      CPCID5 = 'C'
053100130204     C                   EVAL      @ENROU = 'CHD'
053200130204      *
053300130211     C                   WHEN      CPCID5 = '2'
053400130204     C                   IF        @ENRIN = 'TIN'
053500130103     C                   EVAL      @ENROU = 'EMP'
053600130204     C                   ELSE
053700130204     C                   EVAL      @ENROU = 'FAM'
053800130204     C                   ENDIF
053900130204      *
054000130211     C                   WHEN      CPCID5 = '4'
054100130204     C                   SELECT
054200130204     C                   WHEN      @ENRIN = 'TIN'
054300130204     C                   EVAL      @ENROU = 'EMP'
054400130103     C                   WHEN      @ENRIN = 'THW'
054500130103     C                   EVAL      @ENROU = 'ESP'
054600130103     C                   WHEN      @ENRIN = 'TPC' OR @ENRIN = 'TP2'
054700130103     C                   EVAL      @ENROU = 'ECH'
054800130103     C                   WHEN      @ENRIN = 'TFA'
054900130103     C                   EVAL      @ENROU = 'FAM'
055000130204     C                   ENDSL
055100130204      *
055200130103     C                   ENDSL
055300130103    ***
055400130103     C                   ENDSR
055500121213   S***S
055600121213     C     $AD2MARY      BEGSR
055700121213    ***
055800121213    *C                   IF        PLN@CAT = 'MM'
055900130204     C                   IF        MED#CNE > 0
056000130204     C                   IF        MED@TRM(MED#CNE) = 99999999
056100130204     C                   LEAVESR
056200130204     C                   ENDIF
056300130204     C                   ENDIF
056400121213    *C                   ADD       1             MED#CNE
056500121213    *C                   EVAL      MED@PLN(MED#CNE) = @PLANIN
056600121213    *C                   EVAL      MED@ENR(MED#CNE) = @ENROU
056700121213    *C                   EVAL      MED@FRM(MED#CNE) = #EFFDTE
056800121213    *C                   EVAL      MED@TRM(MED#CNE) = #CANCEL
056900121213     C                   LEAVESR
057000121213    *C                   ENDIF
057100121213    ***
057200121213    *C                   IF        PLN@CAT = 'DEN'
057300130204     C                   IF        DEN#CNE > 0
057400130204     C                   IF        DEN@TRM(DEN#CNE) = 99999999
057500130204     C                   LEAVESR
057600130204     C                   ENDIF
057700130204     C                   ENDIF
057800121213    *C                   ADD       1             DEN#CNE
057900121213    *C                   EVAL      DEN@PLN(DEN#CNE) = @PLANIN
058000121213    *C                   EVAL      DEN@ENR(DEN#CNE) = @ENROU
058100121213    *C                   EVAL      DEN@FRM(DEN#CNE) = #EFFDTE
058200121213    *C                   EVAL      DEN@TRM(DEN#CNE) = #CANCEL
058300121213     C                   LEAVESR
058400121213    *C                   ENDIF
058500121213    ***
058600121213    *C                   IF        PLN@CAT = 'RX'
058700130204     C                   IF        RXD#CNE > 0
058800130204     C                   IF        RXD@TRM(RXD#CNE) = 99999999
058900130204     C                   LEAVESR
059000130204     C                   ENDIF
059100130204     C                   ENDIF
059200121213    *C                   ADD       1             RXD#CNE
059300121213    *C                   EVAL      RXD@PLN(RXD#CNE) = @PLANIN
059400121213    *C                   EVAL      RXD@ENR(RXD#CNE) = @ENROU
059500121213    *C                   EVAL      RXD@FRM(RXD#CNE) = #EFFDTE
059600121213    *C                   EVAL      RXD@TRM(RXD#CNE) = #CANCEL
059700121213     C                   LEAVESR
059800121213    *C                   ENDIF
059900121213    ***
060000121213    *C                   IF        PLN@CAT = 'VIS'
060100130204     C                   IF        VIS#CNE > 0
060200130204     C                   IF        VIS@TRM(VIS#CNE) = 99999999
060300130204     C                   LEAVESR
060400130204     C                   ENDIF
060500130204     C                   ENDIF
060600121213    *C                   ADD       1             VIS#CNE
060700121213    *C                   EVAL      VIS@PLN(VIS#CNE) = @PLANIN
060800121213    *C                   EVAL      VIS@ENR(VIS#CNE) = @ENROU
060900121213    *C                   EVAL      VIS@FRM(VIS#CNE) = #EFFDTE
061000121213    *C                   EVAL      VIS@TRM(VIS#CNE) = #CANCEL
061100121213     C                   LEAVESR
061200121213    *C                   ENDIF
061300121213    ***
061400121213    *C                   IF        PLN@CAT = 'LTD'
061500130204     C                   IF        LTD#CNE > 0
061600130204     C                   IF        LTD@TRM(LTD#CNE) = 99999999
061700130204     C                   LEAVESR
061800130204     C                   ENDIF
061900130204     C                   ENDIF
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
063000130204     C                   IF        STD#CNE > 0
063100130204     C                   IF        STD@TRM(STD#CNE) = 99999999
063200130204     C                   LEAVESR
063300130204     C                   ENDIF
063400130204     C                   ENDIF
063500121213    *C                   ADD       1             STD#CNE
063600121213    *C                   EVAL      STD@PLN(STD#CNE) = @PLANIN
063700121213    *C                   EVAL      STD@ENR(STD#CNE) = @ENROU
063800121213     C                   EVAL      STD@VOL(STD#CNE) = #BENAMT
063900121213    *C                   EVAL      STD@FRM(STD#CNE) = #EFFDTE
064000121213    *C                   EVAL      STD@TRM(STD#CNE) = #CANCEL
064100121213     C                   LEAVESR
064200121213    *C                   ENDIF
064300121213    ***
064400130103    *C                   IF        PLN@CAT = 'AC'
064500130204     C                   IF        LIF#CNE > 0
064600130204     C                   IF        LIF@TRM(LIF#CNE) = 99999999
064700130204     C                   LEAVESR
064800130204     C                   ENDIF
064900130204     C                   ENDIF
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
066000130204     C                   IF        ADD#CNE > 0
066100130204     C                   IF        ADD@TRM(ADD#CNE) = 99999999
066200130204     C                   LEAVESR
066300130204     C                   ENDIF
066400130204     C                   ENDIF
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
067500130204     C                   IF        DLF#CNE > 0
067600130204     C                   IF        DLF@TRM(DLF#CNE) = 99999999
067700130204     C                   LEAVESR
067800130204     C                   ENDIF
067900130204     C                   ENDIF
068000121213    *C                   ADD       1             DLF#CNE
068100121213    *C                   EVAL      DLF@PLN(DLF#CNE) = @PLANIN
068200121213    *C                   EVAL      DLF@ENR(DLF#CNE) = @ENROU
068300121213     C                   EVAL      DLF@VOL(DLF#CNE) = #BENAMT
068400121213    *C                   EVAL      DLF@FRM(DLF#CNE) = #EFFDTE
068500121213    *C                   EVAL      DLF@TRM(DLF#CNE) = #CANCEL
068600121213     C                   LEAVESR
068700121213    *C                   ENDIF
068800121213    ***
068900130103    *C                   IF        PLN@CAT = 'AF'
069000130204     C                   IF        VLF#CNE > 0
069100130204     C                   IF        VLF@TRM(VLF#CNE) = 99999999
069200130204     C                   LEAVESR
069300130204     C                   ENDIF
069400130204     C                   ENDIF
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
070500130204     C                   IF        VAD#CNE > 0
070600130204     C                   IF        VAD@TRM(VAD#CNE) = 99999999
070700130204     C                   LEAVESR
070800130204     C                   ENDIF
070900130204     C                   ENDIF
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
072000130204     C                   IF        VLT#CNE > 0
072100130204     C                   IF        VLT@TRM(VLT#CNE) = 99999999
072200130204     C                   LEAVESR
072300130204     C                   ENDIF
072400130204     C                   ENDIF
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
073500130204     C                   IF        CRI#CNE > 0
073600130204     C                   IF        CRI@TRM(CRI#CNE) = 99999999
073700130204     C                   LEAVESR
073800130204     C                   ENDIF
073900130204     C                   ENDIF
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
075000130204     C                   IF        VCI#CNE > 0
075100130204     C                   IF        VCI@TRM(VCI#CNE) = 99999999
075200130204     C                   LEAVESR
075300130204     C                   ENDIF
075400130204     C                   ENDIF
075500121213    *C                   ADD       1             VCI#CNE
075600121213    *C                   EVAL      VCI@PLN(VCI#CNE) = @PLANIN
075700121213    *C                   EVAL      VCI@ENR(VCI#CNE) = @ENROU
075800121213     C                   EVAL      VCI@VOL(VCI#CNE) = #BENAMT
075900121213    *C                   EVAL      VCI@FRM(VCI#CNE) = #EFFDTE
076000121213    *C                   EVAL      VCI@TRM(VCI#CNE) = #CANCEL
076100121213     C                   LEAVESR
076200121213    *C                   ENDIF
076300121213    ***
076400130103    *C                   IF        PLN@CAT = 'ACC'
076500130204     C                   IF        ACC#CNE > 0
076600130204     C                   IF        ACC@TRM(ACC#CNE) = 99999999
076700130103     C                   LEAVESR
076800130204     C                   ENDIF
076900130103     C                   ENDIF
077000130103    *C                   ADD       1             ACC#CNE
077100130103    *C                   EVAL      ACC@PLN(ACC#CNE) = @PLANIN
077200130103    *C                   EVAL      ACC@ENR(ACC#CNE) = @ENROU
077300130103    *C                   EVAL      ACC@FRM(ACC#CNE) = #EFFDTE
077400130103    *C                   EVAL      ACC@TRM(ACC#CNE) = #CANCEL
077500130103     C                   LEAVESR
077600130103    *C                   ENDIF
077700130103    ***
077800130103    *C                   IF        PLN@CAT = 'CAN'
077900130204     C                   IF        CCR#CNE > 0
078000130204     C                   IF        CCR@TRM(CCR#CNE) = 99999999
078100130103     C                   LEAVESR
078200130204     C                   ENDIF
078300130103     C                   ENDIF
078400130103    *C                   ADD       1             CCR#CNE
078500130103    *C                   EVAL      CCR@PLN(CCR#CNE) = @PLANIN
078600130103    *C                   EVAL      CCR@ENR(CCR#CNE) = @ENROU
078700130103    *C                   EVAL      CCR@FRM(CCR#CNE) = #EFFDTE
078800130103    *C                   EVAL      CCR@TRM(CCR#CNE) = #CANCEL
078900130103     C                   LEAVESR
079000130103    *C                   ENDIF
079100130103    ***
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
080200130103     C                             ACC#CNE  = 0 AND CCR#CNE  = 0 AND
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
082200130103     C                   EVAL      TERM_ACC = NO
082300130103     C                   EVAL      TERM_CCR = NO
082400121213    ***
082500121213     C                   EXSR      $CHKHEM
082600121213    ***
082700121213     C                   EVAL      @STEP = 'STEP4'
082800121214    ***
082900121214     C                   ENDSR
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
084100130103     C                             ACC#CNE  = 0 AND CCR#CNE  = 0 AND
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
086400130103     C                   EVAL      ACC@MEFF = 0
086500130103     C                   EVAL      CCR@MEFF = 0
086600121213    ***
086700121213     C                   EXSR      $FILLMBR
086800121213    ***
086900121213     C                   EXSR      $FILLCOVG
087000121213    ***
087100121214     C                   WRITE     AEBF010
087200121213     C                   ADD       1             #RECCNT
087300121213    ***
087400121213     C                   EVAL      @STEP = 'PREP5'
087500121213    ***
087600121213     C                   ENDSR
087700121213   S***S
087800121213     C     $FILLMBR      BEGSR
087900121213    ***
088000121214     C                   CLEAR                   AEBF010
088100121213    ***
088200130103     C                   EVAL      AEBG = %TRIM(CACID2)
088300130103     C                   EVAL      AESN = %TRIM(CACID1)
088400121214     C                   EVAL      AEEMPCD   = '1'
088500130103    ***
088600121214     C                   EVAL      AELNAM    = %TRIM(MLNAME)
088700121214     C                   EVAL      AEFNAM    = %TRIM(MFNAME)
088800121214     C                   EVAL      AEMNAM    = MMI
088900130103     C                   EVAL      AESSN     = %EDITC(MBSSNO:'X')
089000130103    ***
089100130305     C                   IF        %SUBST(ADDR1:1:1) <> 'X'
089200121214     C                   EVAL      AEADR1    = %TRIM(ADDR1)
089300121214     C                   EVAL      AEADR2    = %TRIM(ADDR2)
089400121214     C                   EVAL      AECITY    = %TRIM(CITY)
089500121214     C                   MOVE      *BLANKS       @9                9
089600121214     C                   EVAL      @9 = %EDITC(ZIP:'X')
089700121214     C                   EVAL      AEZIP     = %SUBST(@9:1:5)
089800121214     C                   EVAL      AESTATE   = STATE
089900130305     C                   EVAL      AECNTRY = 'US'
090000130305     C                   ENDIF
090100130305    ***
090200130305     C                   IF        AREA <> 0
090300121214     C                   EVAL      AEAREA    = %EDITC(AREA:'X')
090400121214     C                   EVAL      AEPHONE   = %EDITC(PHONE:'X')
090500130305     C                   ENDIF
090600130103    ***
090700130103     C                   IF        MBR_TERM = YES
090800130103     C                   EVAL      AERT = 'TRM'
090900130103     C                   EVAL      AETRMRSN  = '01'
091000130103     C                   EVAL      AEEFFDAT  = %CHAR(TERMDT)
091100130103     C                   ELSE
091200130103     C                   EVAL      AERT = 'ENR'
091300130103     C                   EVAL      AETRMRSN  = *BLANKS
091400130103     C                   EVAL      AEEFFDAT  = %CHAR(#TODAY)
091500130103     C                   ENDIF
091600130103    ***
091700130227     C                   EVAL      AESAL = *BLANKS
091800130227     C                   EVAL      AESFLG = *BLANKS
091900130227    ***
092000130227     C                   IF        CACID3 = 'Y'
092100130227     C     SALARY        MULT      100           #SAL             15 0
092200130227     C                   EVAL      AESAL     = %EDITC(#SAL:'X')
092300130227     C                   EVAL      AESFLG = '01'
092400130227     C                   ENDIF
092500121213    ***
092600121214     C                   EVAL      AEGENDER  = SEX
092700121214     C                   EVAL      AEDOB     = %EDITC(BIRTH:'X')
092800121214     C                   EVAL      AEHIREDT  = %EDITC(EMPDT:'X')
092900130211     C                   EVAL      AEENROLL  = %EDITC(MBENRL:'X')
093000130103    ***
093100130103     C                   ENDSR
093200121213   S***S
093300121213     C     $FILLCOVG     BEGSR
093400130320    ***
093500130320     C                   IF        MED#CNE > 0
093600130320      * MEDICAL
093700130320    ***
093800130320     C                   EVAL      @PLANIN = MED@PLN(MED#CNE)
093900130320     C                   EXSR      $QUIK
094000130320     C                   EXSR      $PLANSRCH
094100130320     C                   IF        PLN@CAT = *BLANKS
094200130320     C     'MED FAIL'    DSPLY     '*EXT'
094300130320     C                   SETON                                        H1
094400130320     C                   ENDIF
094500130320      *
094600130320     C                   CLEAR                   AE@@
094700130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
094800130320     C                   EVAL      AE@@COV = MED@ENR(MED#CNE)
094900130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
095000130320     C                   EVAL      AEMG = %TRIM(CPCID1)
095100130320      *
095200130320     C                   EVAL      #XSX = MED@FRM(MED#CNE)
095300130320     C                   MOVE      #XSX          #SIGN
095400130320     C                   SUBDUR    1:*D          #SIGN
095500130320     C                   MOVE      #SIGN         #XSX
095600130320     C                   EVAL      AE@@DTS = '1'
095700130320     C                   MOVE      #XSX          AE@@SDTE
095800130320      *
095900130320     C                   EVAL      #CANCEL = MED@TRM(MED#CNE)
096000130320     C                   IF        #CANCEL = 99999999
096100130320     C                   EVAL      AE@@BAC = 'ENR'
096200130320     C                   EVAL      #XSX = MED@FRM(MED#CNE)
096300130320     C                   ELSE
096400130320     C                   EVAL      AE@@BAC = 'TRM'
096500130320     C                   EVAL      #XSX = MED@TRM(MED#CNE)
096600130320     C                   ENDIF
096700130320     C                   MOVE      #XSX          AE@@AED
096800130320      *
096900130320     C*                  EVAL      AE@@VOL = MDE@VOL(MED#CNE)
097000130320     C                   EVAL      AE@@DT = '0'
097100130320     C                   EVAL      #XSX = MED@FRM(MED#CNE)
097200130320     C                   MOVE      #XSX          AE@@MDTE
097300130320     C                   ADD       1             NDX
097400130320     C                   EVAL      @@AE(NDX) = AE@@
097500130320      *
097600130320     C                   ENDIF
097700130320    ***
097800130320     C                   IF        DEN#CNE > 0
097900130320      * DENTAL
098000130320     C                   EVAL      @PLANIN = DEN@PLN(DEN#CNE)
098100130320     C                   EXSR      $QUIK
098200130320     C                   EXSR      $PLANSRCH
098300130320     C                   IF        PLN@CAT = *BLANKS
098400130320     C     'DEN FILL'    DSPLY     '*EXT'
098500130320     C                   SETON                                        H1
098600130320     C                   ENDIF
098700130320      *
098800130320     C                   CLEAR                   AE@@
098900130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
099000130320     C                   EVAL      AE@@COV = DEN@ENR(DEN#CNE)
099100130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
099200130320     C                   EVAL      AEMG = %TRIM(CPCID1)
099300130320      *
099400130320     C                   EVAL      #XSX = DEN@FRM(DEN#CNE)
099500130320     C                   MOVE      #XSX          #SIGN
099600130320     C                   SUBDUR    1:*D          #SIGN
099700130320     C                   MOVE      #SIGN         #XSX
099800130320     C                   EVAL      AE@@DTS = '1'
099900130320     C                   MOVE      #XSX          AE@@SDTE
100000130320      *
100100130320     C                   EVAL      #CANCEL = DEN@TRM(DEN#CNE)
100200130320     C                   IF        #CANCEL = 99999999
100300130320     C                   EVAL      AE@@BAC = 'ENR'
100400130320     C                   EVAL      #XSX = DEN@FRM(DEN#CNE)
100500130320     C                   ELSE
100600130320     C                   EVAL      AE@@BAC = 'TRM'
100700130320     C                   EVAL      #XSX = DEN@TRM(DEN#CNE)
100800130320     C                   ENDIF
100900130320     C                   MOVE      #XSX          AE@@AED
101000130320      *
101100130320     C*                  EVAL      AE@@VOL = DEN@VOL(DEN#CNE)
101200130320     C                   EVAL      AE@@DT = '0'
101300130320     C                   EVAL      #XSX = DEN@FRM(DEN#CNE)
101400130320     C                   MOVE      #XSX          AE@@MDTE
101500130320     C                   ADD       1             NDX
101600130320     C                   EVAL      @@AE(NDX) = AE@@
101700130320      *
101800130320     C                   ENDIF
101900130320    ***
102000130320     C                   IF        RXD#CNE > 0
102100130320      * RXD
102200130320     C                   EVAL      @PLANIN = RXD@PLN(RXD#CNE)
102300130320     C                   EXSR      $QUIK
102400130320     C                   EXSR      $PLANSRCH
102500130320     C                   IF        PLN@CAT = *BLANKS
102600130320     C     'RXD FILL'    DSPLY     '*EXT'
102700130320     C                   SETON                                        H1
102800130320     C                   ENDIF
102900130320      *
103000130320     C                   CLEAR                   AE@@
103100130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
103200130320     C                   EVAL      AE@@COV = RXD@ENR(RXD#CNE)
103300130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
103400130320     C                   EVAL      AEMG = %TRIM(CPCID1)
103500130320      *
103600130320     C                   EVAL      #XSX = RXD@FRM(RXD#CNE)
103700130320     C                   MOVE      #XSX          #SIGN
103800130320     C                   SUBDUR    1:*D          #SIGN
103900130320     C                   MOVE      #SIGN         #XSX
104000130320     C                   EVAL      AE@@DTS = '1'
104100130320     C                   MOVE      #XSX          AE@@SDTE
104200130320      *
104300130320     C                   EVAL      #CANCEL = RXD@TRM(RXD#CNE)
104400130320     C                   IF        #CANCEL = 99999999
104500130320     C                   EVAL      AE@@BAC = 'ENR'
104600130320     C                   EVAL      #XSX = RXD@FRM(RXD#CNE)
104700130320     C                   ELSE
104800130320     C                   EVAL      AE@@BAC = 'TRM'
104900130320     C                   EVAL      #XSX = RXD@TRM(RXD#CNE)
105000130320     C                   ENDIF
105100130320     C                   MOVE      #XSX          AE@@AED
105200130320      *
105300130320     C*                  EVAL      AE@@VOL = RXD@VOL(RXD#CNE)
105400130320     C                   EVAL      AE@@DT = '0'
105500130320     C                   EVAL      #XSX = RXD@FRM(RXD#CNE)
105600130320     C                   MOVE      #XSX          AE@@MDTE
105700130320     C                   ADD       1             NDX
105800130320     C                   EVAL      @@AE(NDX) = AE@@
105900130320      *
106000130320     C                   ENDIF
106100130320    ***
106200130320     C                   IF        VIS#CNE > 0
106300130320      *  VISION
106400130320     C                   EVAL      @PLANIN = VIS@PLN(VIS#CNE)
106500130320     C                   EVAL      @ENRIN = VIS@ENR(VIS#CNE)
106600130320     C                   EXSR      $QUIK
106700130320     C                   EXSR      $PLANSRCH
106800130320     C                   IF        PLN@CAT = *BLANKS
106900130320     C     'VIS FILL'    DSPLY     '*EXT'
107000130320     C                   SETON                                        H1
107100130320     C                   ENDIF
107200130320      *
107300130320     C                   CLEAR                   AE@@
107400130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
107500130320     C                   EVAL      AE@@COV = VIS@ENR(VIS#CNE)
107600130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
107700130320     C                   EVAL      AEMG = %TRIM(CPCID1)
107800130320      *
107900130320     C                   EVAL      #XSX = VIS@FRM(VIS#CNE)
108000130320     C                   MOVE      #XSX          #SIGN
108100130320     C                   SUBDUR    1:*D          #SIGN
108200130320     C                   MOVE      #SIGN         #XSX
108300130320     C                   EVAL      AE@@DTS = '1'
108400130320     C                   MOVE      #XSX          AE@@SDTE
108500130320      *
108600130320     C                   EVAL      #CANCEL = VIS@TRM(VIS#CNE)
108700130320     C                   IF        #CANCEL = 99999999
108800130320     C                   EVAL      AE@@BAC = 'ENR'
108900130320     C                   EVAL      #XSX = VIS@FRM(VIS#CNE)
109000130320     C                   ELSE
109100130320     C                   EVAL      AE@@BAC = 'TRM'
109200130320     C                   EVAL      #XSX = VIS@TRM(VIS#CNE)
109300130320     C                   ENDIF
109400130320     C                   MOVE      #XSX          AE@@AED
109500130320      *
109600130320     C*                  EVAL      AE@@VOL = VIS@VOL(VIS#CNE)
109700130320     C                   EVAL      AE@@DT = '0'
109800130320     C                   EVAL      #XSX = VIS@FRM(VIS#CNE)
109900130320     C                   MOVE      #XSX          AE@@MDTE
110000130320     C                   ADD       1             NDX
110100130320     C                   EVAL      @@AE(NDX) = AE@@
110200130320      *
110300130320     C                   ENDIF
110400130320    ***
110500130320     C                   IF        LTD#CNE > 0 AND WRT@TYPE = 'MEMBER'
110600130320      * LTD
110700130320     C                   EVAL      @PLANIN = LTD@PLN(LTD#CNE)
110800130320     C                   EVAL      @ENRIN = LTD@ENR(LTD#CNE)
110900130320     C                   EXSR      $QUIK
111000130320     C                   EXSR      $PLANSRCH
111100130320     C                   IF        PLN@CAT = *BLANKS
111200130320     C     'LTD FILL'    DSPLY     '*EXT'
111300130320     C                   SETON                                        H1
111400130320     C                   ENDIF
111500130320      *
111600130320     C                   CLEAR                   AE@@
111700130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
111800130320     C                   EVAL      AE@@COV = LTD@ENR(LTD#CNE)
111900130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
112000130320     C                   EVAL      AEMG = %TRIM(CPCID1)
112100130320      *
112200130320     C                   EVAL      #XSX = LTD@FRM(LTD#CNE)
112300130320     C                   MOVE      #XSX          #SIGN
112400130320     C                   SUBDUR    1:*D          #SIGN
112500130320     C                   MOVE      #SIGN         #XSX
112600130320     C                   EVAL      AE@@DTS = '1'
112700130320     C                   MOVE      #XSX          AE@@SDTE
112800130320      *
112900130320     C                   EVAL      #CANCEL = LTD@TRM(LTD#CNE)
113000130320     C                   IF        #CANCEL = 99999999
113100130320     C                   EVAL      AE@@BAC = 'ENR'
113200130320     C                   EVAL      #XSX = LTD@FRM(LTD#CNE)
113300130320     C                   ELSE
113400130320     C                   EVAL      AE@@BAC = 'TRM'
113500130320     C                   EVAL      #XSX = LTD@TRM(LTD#CNE)
113600130320     C                   ENDIF
113700130320     C                   MOVE      #XSX          AE@@AED
113800130320      *
113900130320     C                   IF        CPCID6 = 'Y'
114000130320     C                   EVAL      #7S0 = LTD@VOL(LTD#CNE)
114100130320     C     #7S0          MULT      100           #15S0
114200130320     C                   MOVE      #15S0         AE@@VOL
114300130320     C                   ELSE
114400130320     C                   EVAL      AE@@VOL = *BLANKS
114500130320     C                   ENDIF
114600130320      *
114700130320     C                   EVAL      AE@@DT = '0'
114800130320     C                   EVAL      #XSX = LTD@FRM(LTD#CNE)
114900130320     C                   MOVE      #XSX          AE@@MDTE
115000130320     C                   ADD       1             NDX
115100130320     C                   EVAL      @@AE(NDX) = AE@@
115200130320      *
115300130320     C                   ENDIF
115400130320    ***
115500130320     C                   IF        STD#CNE > 0 AND WRT@TYPE = 'MEMBER'
115600130320      * STD
115700130320     C                   EVAL      @PLANIN = STD@PLN(STD#CNE)
115800130320     C                   EVAL      @ENRIN = STD@ENR(STD#CNE)
115900130320     C                   EXSR      $QUIK
116000130320     C                   EXSR      $PLANSRCH
116100130320     C                   IF        PLN@CAT = *BLANKS
116200130320     C     'STD FILL'    DSPLY     '*EXT'
116300130320     C                   SETON                                        H1
116400130320     C                   ENDIF
116500130320      *
116600130320     C                   CLEAR                   AE@@
116700130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
116800130320     C                   EVAL      AE@@COV = STD@ENR(STD#CNE)
116900130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
117000130320     C                   EVAL      AEMG = %TRIM(CPCID1)
117100130320      *
117200130320     C                   EVAL      #XSX = STD@FRM(STD#CNE)
117300130320     C                   MOVE      #XSX          #SIGN
117400130320     C                   SUBDUR    1:*D          #SIGN
117500130320     C                   MOVE      #SIGN         #XSX
117600130320     C                   EVAL      AE@@DTS = '1'
117700130320     C                   MOVE      #XSX          AE@@SDTE
117800130320      *
117900130320     C                   EVAL      #CANCEL = STD@TRM(STD#CNE)
118000130320     C                   IF        #CANCEL = 99999999
118100130320     C                   EVAL      AE@@BAC = 'ENR'
118200130320     C                   EVAL      #XSX = STD@FRM(STD#CNE)
118300130320     C                   ELSE
118400130320     C                   EVAL      AE@@BAC = 'TRM'
118500130320     C                   EVAL      #XSX = STD@TRM(STD#CNE)
118600130320     C                   ENDIF
118700130320     C                   MOVE      #XSX          AE@@AED
118800130320      *
118900130320     C                   IF        CPCID6 = 'Y'
119000130320     C                   EVAL      #7S0 = STD@VOL(STD#CNE)
119100130320     C     #7S0          MULT      100           #15S0
119200130320     C                   MOVE      #15S0         AE@@VOL
119300130320     C                   ELSE
119400130320     C                   EVAL      AE@@VOL = *BLANKS
119500130320     C                   ENDIF
119600130320      *
119700130320     C                   EVAL      AE@@DT = '0'
119800130320     C                   EVAL      #XSX = STD@FRM(STD#CNE)
119900130320     C                   MOVE      #XSX          AE@@MDTE
120000130320     C                   ADD       1             NDX
120100130320     C                   EVAL      @@AE(NDX) = AE@@
120200130320      *
120300130320     C                   ENDIF
120400130320    ***
120500130320     C                   IF        LIF#CNE > 0 AND WRT@TYPE = 'MEMBER'
120600130320      * BASIC LIFE
120700130320     C                   EVAL      @PLANIN = LIF@PLN(LIF#CNE)
120800130320     C                   EVAL      @ENRIN = LIF@ENR(LIF#CNE)
120900130320     C                   EXSR      $QUIK
121000130320     C                   EXSR      $PLANSRCH
121100130320     C                   IF        PLN@CAT = *BLANKS
121200130320     C     'LIF FILL'    DSPLY     '*EXT'
121300130320     C                   SETON                                        H1
121400130320     C                   ENDIF
121500130320      *
121600130320     C                   CLEAR                   AE@@
121700130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
121800130320     C                   EVAL      AE@@COV = LIF@ENR(LIF#CNE)
121900130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
122000130320     C                   EVAL      AEMG = %TRIM(CPCID1)
122100130320      *
122200130320     C                   EVAL      #XSX = LIF@FRM(LIF#CNE)
122300130320     C                   MOVE      #XSX          #SIGN
122400130320     C                   SUBDUR    1:*D          #SIGN
122500130320     C                   MOVE      #SIGN         #XSX
122600130320     C                   EVAL      AE@@DTS = '1'
122700130320     C                   MOVE      #XSX          AE@@SDTE
122800130320      *
122900130320     C                   EVAL      #CANCEL = LIF@TRM(LIF#CNE)
123000130320     C                   IF        #CANCEL = 99999999
123100130320     C                   EVAL      AE@@BAC = 'ENR'
123200130320     C                   EVAL      #XSX = LIF@FRM(LIF#CNE)
123300130320     C                   ELSE
123400130320     C                   EVAL      AE@@BAC = 'TRM'
123500130320     C                   EVAL      #XSX = LIF@TRM(LIF#CNE)
123600130320     C                   ENDIF
123700130320     C                   MOVE      #XSX          AE@@AED
123800130320      *
123900130320     C                   IF        CPCID6 = 'Y'
124000130320     C                   EVAL      #7S0 = LIF@VOL(LIF#CNE)
124100130320     C     #7S0          MULT      100           #15S0
124200130320     C                   MOVE      #15S0         AE@@VOL
124300130320     C                   ELSE
124400130320     C                   EVAL      AE@@VOL = *BLANKS
124500130320     C                   ENDIF
124600130320      *
124700130320     C                   EVAL      AE@@DT = '0'
124800130320     C                   EVAL      #XSX = LIF@FRM(LIF#CNE)
124900130320     C                   MOVE      #XSX          AE@@MDTE
125000130320     C                   ADD       1             NDX
125100130320     C                   EVAL      @@AE(NDX) = AE@@
125200130320      *
125300130320     C                   ENDIF
125400130320    ***
125500130320     C                   IF        ADD#CNE > 0 AND WRT@TYPE = 'MEMBER'
125600130320      * BASIC AD&D
125700130320     C                   EVAL      @PLANIN = ADD@PLN(ADD#CNE)
125800130320     C                   EVAL      @ENRIN = ADD@ENR(ADD#CNE)
125900130320     C                   EXSR      $QUIK
126000130320     C                   EXSR      $PLANSRCH
126100130320     C                   IF        PLN@CAT = *BLANKS
126200130320     C     'ADD FILL'    DSPLY     '*EXT'
126300130320     C                   SETON                                        H1
126400130320     C                   ENDIF
126500130320      *
126600130320     C                   CLEAR                   AE@@
126700130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
126800130320     C                   EVAL      AE@@COV = ADD@ENR(ADD#CNE)
126900130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
127000130320     C                   EVAL      AEMG = %TRIM(CPCID1)
127100130320      *
127200130320     C                   EVAL      #XSX = ADD@FRM(ADD#CNE)
127300130320     C                   MOVE      #XSX          #SIGN
127400130320     C                   SUBDUR    1:*D          #SIGN
127500130320     C                   MOVE      #SIGN         #XSX
127600130320     C                   EVAL      AE@@DTS = '1'
127700130320     C                   MOVE      #XSX          AE@@SDTE
127800130320      *
127900130320     C                   EVAL      #CANCEL = ADD@TRM(ADD#CNE)
128000130320     C                   IF        #CANCEL = 99999999
128100130320     C                   EVAL      AE@@BAC = 'ENR'
128200130320     C                   EVAL      #XSX = ADD@FRM(ADD#CNE)
128300130320     C                   ELSE
128400130320     C                   EVAL      AE@@BAC = 'TRM'
128500130320     C                   EVAL      #XSX = ADD@TRM(ADD#CNE)
128600130320     C                   ENDIF
128700130320     C                   MOVE      #XSX          AE@@AED
128800130320      *
128900130320     C                   IF        CPCID6 = 'Y'
129000130320     C                   EVAL      #7S0 = ADD@VOL(ADD#CNE)
129100130320     C     #7S0          MULT      100           #15S0
129200130320     C                   MOVE      #15S0         AE@@VOL
129300130320     C                   ELSE
129400130320     C                   EVAL      AE@@VOL = *BLANKS
129500130320     C                   ENDIF
129600130320      *
129700130320     C                   EVAL      AE@@DT = '0'
129800130320     C                   EVAL      #XSX = ADD@FRM(ADD#CNE)
129900130320     C                   MOVE      #XSX          AE@@MDTE
130000130320     C                   ADD       1             NDX
130100130320     C                   EVAL      @@AE(NDX) = AE@@
130200130320      *
130300130320     C                   ENDIF
130400130320    ***
130500130320     C                   IF        DLF#CNE > 0
130600130320      * DEPENDENT LIFE
130700130320     C                   EVAL      @PLANIN = DLF@PLN(DLF#CNE)
130800130320     C                   EVAL      @ENRIN = DLF@ENR(DLF#CNE)
130900130320     C                   EXSR      $QUIK
131000130320     C                   EXSR      $PLANSRCH
131100130320     C                   IF        PLN@CAT = *BLANKS
131200130320     C     'DLF FILL'    DSPLY     '*EXT'
131300130320     C                   SETON                                        H1
131400130320     C                   ENDIF
131500130320      *
131600130320     C                   CLEAR                   AE@@
131700130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
131800130320     C                   EVAL      AE@@COV = DLF@ENR(DLF#CNE)
131900130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
132000130320     C                   EVAL      AEMG = %TRIM(CPCID1)
132100130320      *
132200130320     C                   EVAL      #XSX = DLF@FRM(DLF#CNE)
132300130320     C                   MOVE      #XSX          #SIGN
132400130320     C                   SUBDUR    1:*D          #SIGN
132500130320     C                   MOVE      #SIGN         #XSX
132600130320     C                   EVAL      AE@@DTS = '1'
132700130320     C                   MOVE      #XSX          AE@@SDTE
132800130320      *
132900130320     C                   EVAL      #CANCEL = DLF@TRM(DLF#CNE)
133000130320     C                   IF        #CANCEL = 99999999
133100130320     C                   EVAL      AE@@BAC = 'ENR'
133200130320     C                   EVAL      #XSX = DLF@FRM(DLF#CNE)
133300130320     C                   ELSE
133400130320     C                   EVAL      AE@@BAC = 'TRM'
133500130320     C                   EVAL      #XSX = DLF@TRM(DLF#CNE)
133600130320     C                   ENDIF
133700130320     C                   MOVE      #XSX          AE@@AED
133800130320      *
133900130320     C                   IF        CPCID6 = 'Y'
134000130320     C                   EVAL      #7S0 = DLF@VOL(DLF#CNE)
134100130320     C     #7S0          MULT      100           #15S0
134200130320     C                   MOVE      #15S0         AE@@VOL
134300130320     C                   ELSE
134400130320     C                   EVAL      AE@@VOL = *BLANKS
134500130320     C                   ENDIF
134600130320      *
134700130320     C                   EVAL      AE@@DT = '0'
134800130320     C                   EVAL      #XSX = DLF@FRM(DLF#CNE)
134900130320     C                   MOVE      #XSX          AE@@MDTE
135000130320     C                   ADD       1             NDX
135100130320     C                   EVAL      @@AE(NDX) = AE@@
135200130320      *
135300130320     C                   ENDIF
135400130320    ***
135500130320     C                   IF        VLF#CNE > 0
135600130320      * VOL LIFE
135700130320     C                   EVAL      @PLANIN = VLF@PLN(VLF#CNE)
135800130320     C                   EVAL      @ENRIN = VLF@ENR(VLF#CNE)
135900130320     C                   EXSR      $QUIK
136000130320     C                   EXSR      $PLANSRCH
136100130320     C                   IF        PLN@CAT = *BLANKS
136200130320     C     'VLF FILL'    DSPLY     '*EXT'
136300130320     C                   SETON                                        H1
136400130320     C                   ENDIF
136500130320      *
136600130320     C                   CLEAR                   AE@@
136700130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
136800130320     C                   EVAL      AE@@COV = VLF@ENR(VLF#CNE)
136900130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
137000130320     C                   EVAL      AEMG = %TRIM(CPCID1)
137100130320      *
137200130320     C                   EVAL      #XSX = VLF@FRM(VLF#CNE)
137300130320     C                   MOVE      #XSX          #SIGN
137400130320     C                   SUBDUR    1:*D          #SIGN
137500130320     C                   MOVE      #SIGN         #XSX
137600130320     C                   EVAL      AE@@DTS = '1'
137700130320     C                   MOVE      #XSX          AE@@SDTE
137800130320      *
137900130320     C                   EVAL      #CANCEL = VLF@TRM(VLF#CNE)
138000130320     C                   IF        #CANCEL = 99999999
138100130320     C                   EVAL      AE@@BAC = 'ENR'
138200130320     C                   EVAL      #XSX = VLF@FRM(VLF#CNE)
138300130320     C                   ELSE
138400130320     C                   EVAL      AE@@BAC = 'TRM'
138500130320     C                   EVAL      #XSX = VLF@TRM(VLF#CNE)
138600130320     C                   ENDIF
138700130320     C                   MOVE      #XSX          AE@@AED
138800130320      *
138900130320     C                   IF        CPCID6 = 'Y'
139000130320     C                   EVAL      #7S0 = VLF@VOL(VLF#CNE)
139100130320     C     #7S0          MULT      100           #15S0
139200130320     C                   MOVE      #15S0         AE@@VOL
139300130320     C                   ELSE
139400130320     C                   EVAL      AE@@VOL = *BLANKS
139500130320     C                   ENDIF
139600130320      *
139700130320     C                   EVAL      AE@@DT = '0'
139800130320     C                   EVAL      #XSX = VLF@FRM(VLF#CNE)
139900130320     C                   MOVE      #XSX          AE@@MDTE
140000130320     C                   ADD       1             NDX
140100130320     C                   EVAL      @@AE(NDX) = AE@@
140200130320      *
140300130320     C                   ENDIF
140400130320    ***
140500130320     C                   IF        VAD#CNE > 0
140600130320      * VOLUNTARY AD&D
140700130320     C                   EVAL      @PLANIN = VAD@PLN(VAD#CNE)
140800130320     C                   EVAL      @ENRIN = VAD@ENR(VAD#CNE)
140900130320     C                   EXSR      $QUIK
141000130320     C                   EXSR      $PLANSRCH
141100130320     C                   IF        PLN@CAT = *BLANKS
141200130320     C     'VAD FILL'    DSPLY     '*EXT'
141300130320     C                   SETON                                        H1
141400130320     C                   ENDIF
141500130320      *
141600130320     C                   CLEAR                   AE@@
141700130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
141800130320     C                   EVAL      AE@@COV = VAD@ENR(VAD#CNE)
141900130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
142000130320     C                   EVAL      AEMG = %TRIM(CPCID1)
142100130320      *
142200130320     C                   EVAL      #XSX = VAD@FRM(VAD#CNE)
142300130320     C                   MOVE      #XSX          #SIGN
142400130320     C                   SUBDUR    1:*D          #SIGN
142500130320     C                   MOVE      #SIGN         #XSX
142600130320     C                   EVAL      AE@@DTS = '1'
142700130320     C                   MOVE      #XSX          AE@@SDTE
142800130320      *
142900130320     C                   EVAL      #CANCEL = VAD@TRM(VAD#CNE)
143000130320     C                   IF        #CANCEL = 99999999
143100130320     C                   EVAL      AE@@BAC = 'ENR'
143200130320     C                   EVAL      #XSX = VAD@FRM(VAD#CNE)
143300130320     C                   ELSE
143400130320     C                   EVAL      AE@@BAC = 'TRM'
143500130320     C                   EVAL      #XSX = VAD@TRM(VAD#CNE)
143600130320     C                   ENDIF
143700130320     C                   MOVE      #XSX          AE@@AED
143800130320      *
143900130320     C                   IF        CPCID6 = 'Y'
144000130320     C                   EVAL      #7S0 = VAD@VOL(VAD#CNE)
144100130320     C     #7S0          MULT      100           #15S0
144200130320     C                   MOVE      #15S0         AE@@VOL
144300130320     C                   ELSE
144400130320     C                   EVAL      AE@@VOL = *BLANKS
144500130320     C                   ENDIF
144600130320      *
144700130320     C                   EVAL      AE@@DT = '0'
144800130320     C                   EVAL      #XSX = VAD@FRM(VAD#CNE)
144900130320     C                   MOVE      #XSX          AE@@MDTE
145000130320     C                   ADD       1             NDX
145100130320     C                   EVAL      @@AE(NDX) = AE@@
145200130320      *
145300130320     C                   ENDIF
145400130320    ***
145500130320     C                   IF        VLT#CNE > 0
145600130320      * VOL LTD
145700130320     C                   EVAL      @PLANIN = VLT@PLN(VLT#CNE)
145800130320     C                   EVAL      @ENRIN = VLT@ENR(VLT#CNE)
145900130320     C                   EXSR      $QUIK
146000130320     C                   EXSR      $PLANSRCH
146100130320     C                   IF        PLN@CAT = *BLANKS
146200130320     C     'VLT FILL'    DSPLY     '*EXT'
146300130320     C                   SETON                                        H1
146400130320     C                   ENDIF
146500130320      *
146600130320     C                   CLEAR                   AE@@
146700130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
146800130320     C                   EVAL      AE@@COV = VLT@ENR(VLT#CNE)
146900130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
147000130320     C                   EVAL      AEMG = %TRIM(CPCID1)
147100130320      *
147200130320     C                   EVAL      #XSX = VLT@FRM(VLT#CNE)
147300130320     C                   MOVE      #XSX          #SIGN
147400130320     C                   SUBDUR    1:*D          #SIGN
147500130320     C                   MOVE      #SIGN         #XSX
147600130320     C                   EVAL      AE@@DTS = '1'
147700130320     C                   MOVE      #XSX          AE@@SDTE
147800130320      *
147900130320     C                   EVAL      #CANCEL = VLT@TRM(VLT#CNE)
148000130320     C                   IF        #CANCEL = 99999999
148100130320     C                   EVAL      AE@@BAC = 'ENR'
148200130320     C                   EVAL      #XSX = VLT@FRM(VLT#CNE)
148300130320     C                   ELSE
148400130320     C                   EVAL      AE@@BAC = 'TRM'
148500130320     C                   EVAL      #XSX = VLT@TRM(VLT#CNE)
148600130320     C                   ENDIF
148700130320     C                   MOVE      #XSX          AE@@AED
148800130320      *
148900130320     C                   IF        CPCID6 = 'Y'
149000130320     C                   EVAL      #7S0 = VLT@VOL(VLT#CNE)
149100130320     C     #7S0          MULT      100           #15S0
149200130320     C                   MOVE      #15S0         AE@@VOL
149300130320     C                   ELSE
149400130320     C                   EVAL      AE@@VOL = *BLANKS
149500130320     C                   ENDIF
149600130320      *
149700130320     C                   EVAL      AE@@DT = '0'
149800130320     C                   EVAL      #XSX = VLT@FRM(VLT#CNE)
149900130320     C                   MOVE      #XSX          AE@@MDTE
150000130320     C                   ADD       1             NDX
150100130320     C                   EVAL      @@AE(NDX) = AE@@
150200130320      *
150300130320     C                   ENDIF
150400130320    ***
150500130320     C                   IF        CRI#CNE > 0
150600130320      * CRITICAL ILLNESS
150700130320     C                   EVAL      @PLANIN = CRI@PLN(CRI#CNE)
150800130320     C                   EVAL      @ENRIN = CRI@ENR(CRI#CNE)
150900130320     C                   EXSR      $QUIK
151000130320     C                   EXSR      $PLANSRCH
151100130320     C                   IF        PLN@CAT = *BLANKS
151200130320     C     'CRI FILL'    DSPLY     '*EXT'
151300130320     C                   SETON                                        H1
151400130320     C                   ENDIF
151500130320      *
151600130320     C                   CLEAR                   AE@@
151700130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
151800130320     C                   EVAL      AE@@COV = CRI@ENR(CRI#CNE)
151900130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
152000130320     C                   EVAL      AEMG = %TRIM(CPCID1)
152100130320      *
152200130320     C                   EVAL      #XSX = CRI@FRM(CRI#CNE)
152300130320     C                   MOVE      #XSX          #SIGN
152400130320     C                   SUBDUR    1:*D          #SIGN
152500130320     C                   MOVE      #SIGN         #XSX
152600130320     C                   EVAL      AE@@DTS = '1'
152700130320     C                   MOVE      #XSX          AE@@SDTE
152800130320      *
152900130320     C                   EVAL      #CANCEL = CRI@TRM(CRI#CNE)
153000130320     C                   IF        #CANCEL = 99999999
153100130320     C                   EVAL      AE@@BAC = 'ENR'
153200130320     C                   EVAL      #XSX = CRI@FRM(CRI#CNE)
153300130320     C                   ELSE
153400130320     C                   EVAL      AE@@BAC = 'TRM'
153500130320     C                   EVAL      #XSX = CRI@TRM(CRI#CNE)
153600130320     C                   ENDIF
153700130320     C                   MOVE      #XSX          AE@@AED
153800130320      *
153900130320     C                   IF        CPCID6 = 'Y'
154000130320     C                   EVAL      #7S0 = CRI@VOL(CRI#CNE)
154100130320     C     #7S0          MULT      100           #15S0
154200130320     C                   MOVE      #15S0         AE@@VOL
154300130320     C                   ELSE
154400130320     C                   EVAL      AE@@VOL = *BLANKS
154500130320     C                   ENDIF
154600130320      *
154700130320     C                   EVAL      AE@@DT = '0'
154800130320     C                   EVAL      #XSX = CRI@FRM(CRI#CNE)
154900130320     C                   MOVE      #XSX          AE@@MDTE
155000130320     C                   ADD       1             NDX
155100130320     C                   EVAL      @@AE(NDX) = AE@@
155200130320      *
155300130320     C                   ENDIF
155400130320    ***
155500130320     C                   IF        VCI#CNE > 0
155600130320      * VOL CRITICAL ILLNESS
155700130320     C                   EVAL      @PLANIN = VCI@PLN(VCI#CNE)
155800130320     C                   EVAL      @ENRIN = VCI@ENR(VCI#CNE)
155900130320     C                   EXSR      $QUIK
156000130320     C                   EXSR      $PLANSRCH
156100130320     C                   IF        PLN@CAT = *BLANKS
156200130320     C     'VCI FILL'    DSPLY     '*EXT'
156300130320     C                   SETON                                        H1
156400130320     C                   ENDIF
156500130320      *
156600130320     C                   CLEAR                   AE@@
156700130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
156800130320     C                   EVAL      AE@@COV = VCI@ENR(VCI#CNE)
156900130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
157000130320     C                   EVAL      AEMG = %TRIM(CPCID1)
157100130320      *
157200130320     C                   EVAL      #XSX = VCI@FRM(VCI#CNE)
157300130320     C                   MOVE      #XSX          #SIGN
157400130320     C                   SUBDUR    1:*D          #SIGN
157500130320     C                   MOVE      #SIGN         #XSX
157600130320     C                   EVAL      AE@@DTS = '1'
157700130320     C                   MOVE      #XSX          AE@@SDTE
157800130320      *
157900130320     C                   EVAL      #CANCEL = VCI@TRM(VCI#CNE)
158000130320     C                   IF        #CANCEL = 99999999
158100130320     C                   EVAL      AE@@BAC = 'ENR'
158200130320     C                   EVAL      #XSX = VCI@FRM(VCI#CNE)
158300130320     C                   ELSE
158400130320     C                   EVAL      AE@@BAC = 'TRM'
158500130320     C                   EVAL      #XSX = VCI@TRM(VCI#CNE)
158600130320     C                   ENDIF
158700130320     C                   MOVE      #XSX          AE@@AED
158800130320      *
158900130320     C                   IF        CPCID6 = 'Y'
159000130320     C                   EVAL      #7S0 = VCI@VOL(VCI#CNE)
159100130320     C     #7S0          MULT      100           #15S0
159200130320     C                   MOVE      #15S0         AE@@VOL
159300130320     C                   ELSE
159400130320     C                   EVAL      AE@@VOL = *BLANKS
159500130320     C                   ENDIF
159600130320      *
159700130320     C                   EVAL      AE@@DT = '0'
159800130320     C                   EVAL      #XSX = VCI@FRM(VCI#CNE)
159900130320     C                   MOVE      #XSX          AE@@MDTE
160000130320     C                   ADD       1             NDX
160100130320     C                   EVAL      @@AE(NDX) = AE@@
160200130320      *
160300130320     C                   ENDIF
160400130320    ***
160500130320     C                   IF        ACC#CNE > 0
160600130320      * ACCIDENT COVERAGE
160700130320     C                   EVAL      @PLANIN = ACC@PLN(ACC#CNE)
160800130320     C                   EVAL      @ENRIN = ACC@ENR(ACC#CNE)
160900130320     C                   EXSR      $QUIK
161000130320     C                   EXSR      $PLANSRCH
161100130320     C                   IF        PLN@CAT = *BLANKS
161200130320     C     'ACC FILL'    DSPLY     '*EXT'
161300130320     C                   SETON                                        H1
161400130320     C                   ENDIF
161500130320      *
161600130320     C                   CLEAR                   AE@@
161700130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
161800130320     C                   EVAL      AE@@COV = ACC@ENR(ACC#CNE)
161900130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
162000130320     C                   EVAL      AEMG = %TRIM(CPCID1)
162100130320      *
162200130320     C                   EVAL      #XSX = ACC@FRM(ACC#CNE)
162300130320     C                   MOVE      #XSX          #SIGN
162400130320     C                   SUBDUR    1:*D          #SIGN
162500130320     C                   MOVE      #SIGN         #XSX
162600130320     C                   EVAL      AE@@DTS = '1'
162700130320     C                   MOVE      #XSX          AE@@SDTE
162800130320      *
162900130320     C                   EVAL      #CANCEL = ACC@TRM(ACC#CNE)
163000130320     C                   IF        #CANCEL = 99999999
163100130320     C                   EVAL      AE@@BAC = 'ENR'
163200130320     C                   EVAL      #XSX = ACC@FRM(ACC#CNE)
163300130320     C                   ELSE
163400130320     C                   EVAL      AE@@BAC = 'TRM'
163500130320     C                   EVAL      #XSX = ACC@TRM(ACC#CNE)
163600130320     C                   ENDIF
163700130320     C                   MOVE      #XSX          AE@@AED
163800130320      *
163900130320     C                   IF        CPCID6 = 'Y'
164000130320     C                   EVAL      #7S0 = ACC@VOL(ACC#CNE)
164100130320     C     #7S0          MULT      100           #15S0
164200130320     C                   MOVE      #15S0         AE@@VOL
164300130320     C                   ELSE
164400130320     C                   EVAL      AE@@VOL = *BLANKS
164500130320     C                   ENDIF
164600130320      *
164700130320     C                   EVAL      AE@@DT = '0'
164800130320     C                   EVAL      #XSX = ACC@FRM(ACC#CNE)
164900130320     C                   MOVE      #XSX          AE@@MDTE
165000130320     C                   ADD       1             NDX
165100130320     C                   EVAL      @@AE(NDX) = AE@@
165200130320      *
165300130320     C                   ENDIF
165400130320    ***
165500130320     C                   IF        CCR#CNE > 0
165600130320      * CANCER COVERAGE
165700130320     C                   EVAL      @PLANIN = CCR@PLN(CCR#CNE)
165800130320     C                   EVAL      @ENRIN = CCR@ENR(CCR#CNE)
165900130320     C                   EXSR      $QUIK
166000130320     C                   EXSR      $PLANSRCH
166100130320     C                   IF        PLN@CAT = *BLANKS
166200130320     C     'CCR FILL'    DSPLY     '*EXT'
166300130320     C                   SETON                                        H1
166400130320     C                   ENDIF
166500130320      *
166600130320     C                   CLEAR                   AE@@
166700130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
166800130320     C                   EVAL      AE@@COV = CCR@ENR(CCR#CNE)
166900130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
167000130320     C                   EVAL      AEMG = %TRIM(CPCID1)
167100130320      *
167200130320     C                   EVAL      #XSX = CCR@FRM(CCR#CNE)
167300130320     C                   MOVE      #XSX          #SIGN
167400130320     C                   SUBDUR    1:*D          #SIGN
167500130320     C                   MOVE      #SIGN         #XSX
167600130320     C                   EVAL      AE@@DTS = '1'
167700130320     C                   MOVE      #XSX          AE@@SDTE
167800130320      *
167900130320     C                   EVAL      #CANCEL = CCR@TRM(CCR#CNE)
168000130320     C                   IF        #CANCEL = 99999999
168100130320     C                   EVAL      AE@@BAC = 'ENR'
168200130320     C                   EVAL      #XSX = CCR@FRM(CCR#CNE)
168300130320     C                   ELSE
168400130320     C                   EVAL      AE@@BAC = 'TRM'
168500130320     C                   EVAL      #XSX = CCR@TRM(CCR#CNE)
168600130320     C                   ENDIF
168700130320     C                   MOVE      #XSX          AE@@AED
168800130320      *
168900130320     C                   IF        CPCID6 = 'Y'
169000130320     C                   EVAL      #7S0 = CCR@VOL(CCR#CNE)
169100130320     C     #7S0          MULT      100           #15S0
169200130320     C                   MOVE      #15S0         AE@@VOL
169300130320     C                   ELSE
169400130320     C                   EVAL      AE@@VOL = *BLANKS
169500130320     C                   ENDIF
169600130320      *
169700130320     C                   EVAL      AE@@DT = '0'
169800130320     C                   EVAL      #XSX = CCR@FRM(CCR#CNE)
169900130320     C                   MOVE      #XSX          AE@@MDTE
170000130320     C                   ADD       1             NDX
170100130320     C                   EVAL      @@AE(NDX) = AE@@
170200130320      *
170300130320     C                   ENDIF
170400130320    ***
170500121213     C                   ENDSR
170600121213   S***S
170700121214     C     $PREP5        BEGSR
170800121214    ***
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
175700130227     C                   EVAL      #CANCEL = CCANDT
175800130211    ***
175900130211     C                   EVAL      #BENAMT = 0
176000130211     *** OR
176100130313     C*******************EVAL      #BENAMT = DVVOL
176200121213    ***
176300121213     C                   EXSR      $QUIK
176400121213    ***
176500121213     C                   EXSR      $PLANSRCH
176600121213    ***
176700121213     C                   IF        PLN@CAT = *BLANKS
176800121213     C                   LEAVESR
176900121213     C                   ENDIF
177000121213    ***
177100130227     C                   EXSR      $TIERLVL
177200130227    ***
177300130227     C                   IF        #CANCEL = 0
177400130227     C                   EVAL      #CANCEL = 99999999
177500130227     C                   ENDIF
177600130227    ***
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
178900130204     C                             ACC#CNE  = 0 AND CCR#CNE  = 0 AND
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
180900130204     C                   EVAL      TERM_ACC = NO
181000130204     C                   EVAL      TERM_CCR = NO
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
182600130204     C                             ACC#CNE  = 0 AND CCR#CNE  = 0 AND
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
183800130211     C                   WRITE     AEBF010
183900121213     C                   ADD       1             #RECCNT
184000121213    ***
184100121213     C                   EVAL      @STEP = 'STEP5'
184200121213    ***
184300121213     C                   ENDSR
184400121213   S***S
184500121213     C     $FILLDEP      BEGSR
184600130204    ***
184700130204     C                   CLEAR                   AEBF010
184800130204    ***
184900130204     C                   EVAL      AEBG = %TRIM(CACID2)
185000130204     C                   EVAL      AESN = %TRIM(CACID1)
185100130204    ***
185200130204     C                   SELECT
185300130204     C                   WHEN      DRELCD = 'RWI' OR DRELCD = 'RHU' OR
185400130204     C                             DRELCD = 'RPA'
185500130204     C                   EVAL      AEEMPCD   = '2'
185600130204     C                   WHEN      DRELCD = 'RSO' OR DRELCD = 'RDA'
185700130204     C                   EVAL      AEEMPCD   = '3'
185800130204     C                   OTHER
185900130204     C     'RELCD ERR'   DSPLY     '*EXT'
186000130204     C                   SETON                                        H1
186100130204     C                   ENDSL
186200130204    ***
186300130204     C                   EVAL      AELNAM    = %TRIM(DLNAME)
186400130204     C                   EVAL      AEFNAM    = %TRIM(DFNAME)
186500130204     C                   EVAL      AEMNAM    = DMI
186600121213    ***
186700130305     C                   IF        DEPSS# <>0
186800130204     C                   EVAL      AESSN     = %EDITC(DEPSS#:'X')
186900130305     C                   ENDIF
187000130204    ***
187100121213     C                   IF        DADDR1 = ADDR1 OR %TRIM(DADDR1) = 'SAME'
187200121213      *
187300130305     C                   IF        %SUBST(ADDR1:1:1) <> 'X'
187400130204     C                   EVAL      AEADR1    = %TRIM(ADDR1)
187500130204     C                   EVAL      AEADR2    = %TRIM(ADDR2)
187600130204     C                   EVAL      AECITY    = %TRIM(CITY)
187700130204     C                   MOVE      *BLANKS       @9                9
187800130204     C                   EVAL      @9 = %EDITC(ZIP:'X')
187900130204     C                   EVAL      AEZIP     = %SUBST(@9:1:5)
188000130204     C                   EVAL      AESTATE   = STATE
188100130305     C                   EVAL      AECNTRY = 'US'
188200130305     C                   ENDIF
188300130305     C                   IF        AREA <> 0
188400130204     C                   EVAL      AEAREA    = %EDITC(AREA:'X')
188500130204     C                   EVAL      AEPHONE   = %EDITC(PHONE:'X')
188600130305     C                   ENDIF
188700130204     C                   ELSE
188800130305     C                   IF        %SUBST(DADDR1:1:1) <> 'X'
188900130204     C                   EVAL      AEADR1    = %TRIM(DADDR1)
189000130204     C                   EVAL      AEADR2    = %TRIM(DADDR2)
189100130204     C                   EVAL      AECITY    = %TRIM(DCITY)
189200130204     C                   MOVE      *BLANKS       @9                9
189300130204     C                   EVAL      @9 = %EDITC(DZIP:'X')
189400130204     C                   EVAL      AEZIP     = %SUBST(@9:1:5)
189500130204     C                   EVAL      AESTATE   = DSTATE
189600130305     C                   EVAL      AECNTRY = 'US'
189700130305     C                   ENDIF
189800130305     C                   IF        DAREA <> 0
189900130204     C                   EVAL      AEAREA    = %EDITC(DAREA:'X')
190000130204     C                   EVAL      AEPHONE   = %EDITC(DPHONE:'X')
190100130305     C                   ENDIF
190200130204     C                   ENDIF
190300130204     **
190400130204     C                   EVAL      AERT = 'ENR'
190500130204     C                   EVAL      AETRMRSN  = *BLANKS
190600130204     C                   EVAL      AEEFFDAT  = %CHAR(#TODAY)
190700130204    ***
190800130204     C                   EVAL      AEGENDER = DSEX
190900130204     C                   EVAL      AEDOB     = %EDITC(DBIRTH:'X')
191000130204    ***
191100130204     C                   EVAL      AEHIREDT  = %EDITC(EMPDT:'X')
191200130211     C                   EVAL      AEENROLL  = %EDITC(MBENRL:'X')
191300121213    ***
191400121213     C                   ENDSR
191500121213   S***S
191600121213     C     *INZSR        BEGSR
191700121213    ***
191800121213     C                   EVAL      #RECCNT = 0
191900121213    ***
192000121213     C     KL#ACCTL      KLIST
192100121213     C                   KFLD                    CARR#CTL
192200121213     C                   KFLD                    KF@TRS
192300121213     C                   KFLD                    KF@SUB
192400121213     C                   KFLD                    KF@ACC
192500121213    ***
192600121213     C     KL#AUX        KLIST
192700121213     C                   KFLD                    KF@TRS
192800121213     C                   KFLD                    KF@SUB
192900121213     C                   KFLD                    KF@ACC
193000121213     C                   KFLD                    KF@SSN
193100121213     C                   KFLD                    KF@SEQ
193200121213    ***
193300121213     C     KL#TSA        KLIST
193400121213     C                   KFLD                    KF@TRS
193500121213     C                   KFLD                    KF@SUB
193600121213     C                   KFLD                    KF@ACC
193700121213    ***
193800121213     C     KL#MPLN       KLIST
193900121213     C                   KFLD                    KF@SSN
194000121213     C                   KFLD                    KF@SEQ
194100121213     C                   KFLD                    KF@TRS
194200121213     C                   KFLD                    KF@SUB
194300121213     C                   KFLD                    KF@ACC
194400121213    ***
194500121213     C     KL#CPLN       KLIST
194600121213     C                   KFLD                    CARR#CTL
194700121213     C                   KFLD                    KF@TRS
194800121213     C                   KFLD                    KF@SUB
194900121213     C                   KFLD                    KF@ACC
195000121213     C                   KFLD                    KF@CCTR
195100121213     C                   KFLD                    KF@PLN
195200121213    ***
195300121213     C     KL#DCV        KLIST
195400121213     C                   KFLD                    KF@SSN
195500121213     C                   KFLD                    KF@SEQ
195600121213    ***
195700121213     C     KL#MTR        KLIST
195800121213     C                   KFLD                    KF@SSN
195900121213     C                   KFLD                    KF@SEQ
196000130211     C                   KFLD                    KF@TRM
196100121213     C                   KFLD                    KF@PLN
196200121213     C                   KFLD                    KF@ENR
196300121213     C                   KFLD                    KF@TRS
196400121213     C                   KFLD                    KF@SUB
196500121213     C                   KFLD                    KF@ACC
196600121213    ***
196700121213     C                   ENDSR
196800121213   S***S
196900121213   S***S
197000121213     C     $CLRSTG       BEGSR
197100130214    ***
197200130214     C                   CLEAR                   DS@AEB
197300130214     C                   EVAL      NDX = 0
197400130214     C                   CLEAR                   AE@@
197500121213    ***
197600121213     C                   EVAL      #CANCEL = 0
197700121213    ***
197800121213     C                   EVAL                    MED#CNE = 0
197900121213     C                   EVAL                    MED#NDX = 0
198000121213     C                   CLEAR                   MED@PLN
198100121213     C                   CLEAR                   MED@ENR
198200121213     C                   CLEAR                   MED@FRM
198300121213     C                   CLEAR                   MED@TRM
198400121213    ***
198500121213     C                   EVAL                    DEN#CNE = 0
198600121213     C                   EVAL                    DEN#NDX = 0
198700121213     C                   CLEAR                   DEN@PLN
198800121213     C                   CLEAR                   DEN@ENR
198900121213     C                   CLEAR                   DEN@FRM
199000121213     C                   CLEAR                   DEN@TRM
199100121213    ***
199200121213     C                   EVAL                    RXD#CNE = 0
199300121213     C                   EVAL                    RXD#NDX = 0
199400121213     C                   CLEAR                   RXD@PLN
199500121213     C                   CLEAR                   RXD@ENR
199600121213     C                   CLEAR                   RXD@FRM
199700121213     C                   CLEAR                   RXD@TRM
199800121213    ***
199900121213     C                   EVAL                    VIS#CNE = 0
200000121213     C                   EVAL                    VIS#NDX = 0
200100121213     C                   CLEAR                   VIS@PLN
200200121213     C                   CLEAR                   VIS@ENR
200300121213     C                   CLEAR                   VIS@FRM
200400121213     C                   CLEAR                   VIS@TRM
200500121213    ***
200600121213     C                   EVAL                    LTD#CNE = 0
200700121213     C                   EVAL                    LTD#NDX = 0
200800121213     C                   CLEAR                   LTD@PLN
200900121213     C                   CLEAR                   LTD@ENR
201000121213     C                   CLEAR                   LTD@VOL
201100121213     C                   CLEAR                   LTD@FRM
201200121213     C                   CLEAR                   LTD@TRM
201300121213    ***
201400121213     C                   EVAL                    STD#CNE = 0
201500121213     C                   EVAL                    STD#NDX = 0
201600121213     C                   CLEAR                   STD@PLN
201700121213     C                   CLEAR                   STD@ENR
201800121213     C                   CLEAR                   STD@VOL
201900121213     C                   CLEAR                   STD@FRM
202000121213     C                   CLEAR                   STD@TRM
202100121213    ***
202200121213     C                   EVAL                    LIF#CNE = 0
202300121213     C                   EVAL                    LIF#NDX = 0
202400121213     C                   CLEAR                   LIF@PLN
202500121213     C                   CLEAR                   LIF@ENR
202600121213     C                   CLEAR                   LIF@VOL
202700121213     C                   CLEAR                   LIF@FRM
202800121213     C                   CLEAR                   LIF@TRM
202900121213    ***
203000121213     C                   EVAL                    ADD#CNE = 0
203100121213     C                   EVAL                    ADD#NDX = 0
203200121213     C                   CLEAR                   ADD@PLN
203300121213     C                   CLEAR                   ADD@ENR
203400121213     C                   CLEAR                   ADD@VOL
203500121213     C                   CLEAR                   ADD@FRM
203600121213     C                   CLEAR                   ADD@TRM
203700121213    ***
203800121213     C                   EVAL                    DLF#CNE = 0
203900121213     C                   EVAL                    DLF#NDX = 0
204000121213     C                   CLEAR                   DLF@PLN
204100121213     C                   CLEAR                   DLF@ENR
204200121213     C                   CLEAR                   DLF@VOL
204300121213     C                   CLEAR                   DLF@FRM
204400121213     C                   CLEAR                   DLF@TRM
204500121213    ***
204600121213     C                   EVAL                    VLF#CNE = 0
204700121213     C                   EVAL                    VLF#NDX = 0
204800121213     C                   CLEAR                   VLF@PLN
204900121213     C                   CLEAR                   VLF@ENR
205000121213     C                   CLEAR                   VLF@VOL
205100121213     C                   CLEAR                   VLF@FRM
205200121213     C                   CLEAR                   VLF@TRM
205300121213    ***
205400121213     C                   EVAL                    VAD#CNE = 0
205500121213     C                   EVAL                    VAD#NDX = 0
205600121213     C                   CLEAR                   VAD@PLN
205700121213     C                   CLEAR                   VAD@ENR
205800121213     C                   CLEAR                   VAD@VOL
205900121213     C                   CLEAR                   VAD@FRM
206000121213     C                   CLEAR                   VAD@TRM
206100121213    ***
206200121213     C                   EVAL                    VLT#CNE = 0
206300121213     C                   EVAL                    VLT#NDX = 0
206400121213     C                   CLEAR                   VLT@PLN
206500121213     C                   CLEAR                   VLT@ENR
206600121213     C                   CLEAR                   VLT@VOL
206700121213     C                   CLEAR                   VLT@FRM
206800121213     C                   CLEAR                   VLT@TRM
206900121213    ***
207000121213     C                   EVAL                    CRI#CNE = 0
207100121213     C                   EVAL                    CRI#NDX = 0
207200121213     C                   CLEAR                   CRI@PLN
207300121213     C                   CLEAR                   CRI@ENR
207400121213     C                   CLEAR                   CRI@VOL
207500121213     C                   CLEAR                   CRI@FRM
207600121213     C                   CLEAR                   CRI@TRM
207700121213    ***
207800121213     C                   EVAL                    VCI#CNE = 0
207900121213     C                   EVAL                    VCI#NDX = 0
208000121213     C                   CLEAR                   VCI@PLN
208100121213     C                   CLEAR                   VCI@ENR
208200121213     C                   CLEAR                   VCI@VOL
208300121213     C                   CLEAR                   VCI@FRM
208400121213     C                   CLEAR                   VCI@TRM
208500121213    ***
208600130205     C                   EVAL                    ACC#CNE = 0
208700130205     C                   EVAL                    ACC#NDX = 0
208800130205     C                   CLEAR                   ACC@PLN
208900130205     C                   CLEAR                   ACC@ENR
209000130205     C                   CLEAR                   ACC@FRM
209100130205     C                   CLEAR                   ACC@TRM
209200130205    ***
209300130205     C                   EVAL                    CCR#CNE = 0
209400130205     C                   EVAL                    CCR#NDX = 0
209500130205     C                   CLEAR                   CCR@PLN
209600130205     C                   CLEAR                   CCR@ENR
209700130205     C                   CLEAR                   CCR@FRM
209800130205     C                   CLEAR                   CCR@TRM
209900130205    ***
210000121213     C                   ENDSR
210100121213   S***S
210200121213     C     $CHKHEM       BEGSR
210300121213    ***
210400121213     C                   IF        MED#CNE > 0 AND MED@TRM(MED#CNE) <> 99999999
210500121213     C                   EXSR      $CHKMED
210600121213     C                   ENDIF
210700121213    ***
210800121213     C                   IF        DEN#CNE > 0 AND DEN@TRM(DEN#CNE) <> 99999999
210900121213     C                   EXSR      $CHKDEN
211000121213     C                   ENDIF
211100121213    ***
211200121213     C                   IF        RXD#CNE > 0 AND RXD@TRM(RXD#CNE) <> 99999999
211300121213     C                   EXSR      $CHKRXD
211400121213     C                   ENDIF
211500121213    ***
211600121213     C                   IF        VIS#CNE > 0 AND VIS@TRM(VIS#CNE) <> 99999999
211700121213     C                   EXSR      $CHKVIS
211800121213     C                   ENDIF
211900121213    ***
212000121213     C                   IF        LTD#CNE > 0 AND LTD@TRM(LTD#CNE) <> 99999999
212100121213     C                   EXSR      $CHKLTD
212200121213     C                   ENDIF
212300121213    ***
212400121213     C                   IF        STD#CNE > 0 AND STD@TRM(STD#CNE) <> 99999999
212500121213     C                   EXSR      $CHKSTD
212600121213     C                   ENDIF
212700121213    ***
212800121213     C                   IF        VCI#CNE > 0 AND VCI@TRM(VCI#CNE) <> 99999999
212900121213     C                   EXSR      $CHKVCI
213000121213     C                   ENDIF
213100121213    ***
213200121213     C                   IF        LIF#CNE > 0 AND LIF@TRM(LIF#CNE) <> 99999999
213300121213     C                   EXSR      $CHKLIF
213400121213     C                   ENDIF
213500121213    ***
213600121213     C                   IF        ADD#CNE > 0 AND ADD@TRM(ADD#CNE) <> 99999999
213700121213     C                   EXSR      $CHKADD
213800121213     C                   ENDIF
213900121213    ***
214000121213     C                   IF        DLF#CNE > 0 AND DLF@TRM(DLF#CNE) <> 99999999
214100121213     C                   EXSR      $CHKDLF
214200121213     C                   ENDIF
214300121213    ***
214400121213     C                   IF        VLF#CNE > 0 AND VLF@TRM(VLF#CNE) <> 99999999
214500121213     C                   EXSR      $CHKVLF
214600121213     C                   ENDIF
214700121213    ***
214800121213     C                   IF        VAD#CNE > 0 AND VAD@TRM(VAD#CNE) <> 99999999
214900121213     C                   EXSR      $CHKVAD
215000121213     C                   ENDIF
215100121213    ***
215200121213     C                   IF        VLT#CNE > 0 AND VLT@TRM(VLT#CNE) <> 99999999
215300121213     C                   EXSR      $CHKVLT
215400121213     C                   ENDIF
215500121213    ***
215600121213     C                   IF        CRI#CNE > 0 AND CRI@TRM(CRI#CNE) <> 99999999
215700121213     C                   EXSR      $CHKCRI
215800121213     C                   ENDIF
215900121213    ***
216000130204     C                   IF        ACC#CNE > 0 AND ACC@TRM(ACC#CNE) <> 99999999
216100130204     C                   EXSR      $CHKACC
216200130204     C                   ENDIF
216300130204    ***
216400130204     C                   IF        CCR#CNE > 0 AND CCR@TRM(CCR#CNE) <> 99999999
216500130204     C                   EXSR      $CHKCCR
216600130204     C                   ENDIF
216700130204    ***
216800121213     C                   ENDSR
216900121213   S***S
217000121213      * CHECK FOR MEDICAL TERMINATION
217100121213    *C     $CHKMED       BEGSR
217200121213    ***
217300121213    *C                   EVAL      TERM_MED = YES
217400130211    *C                   EVAL      KF@TRM = MED@TRM(MED#CNE)
217500121213    *C                   EVAL      KF@PLN = MED@PLN(MED#CNE)
217600121213    *C                   EVAL      KF@ENR = MED@ENR(MED#CNE)
217700121213    ***
217800130204    *C     KL#MTR        CHAIN     AEB004F
217900130204    *C                   IF        %FOUND(AEB004WF)
218000130204     C                   IF        NTCOUNT > 1
218100121213    *C                   EVAL      MED#CNE = 0
218200121213    *C                   EVAL      TERM_MED = NO
218300130204     C                   ELSE
218400130204     C                   ADD       1             NTCOUNT
218500130212     C                   EVAL      NTTRANSD2      = #TODAY
218600130204     C                   UPDATE    AEB004F
218700130204     C                   ENDIF
218800130606     C                   LEAVESR
218900121213    *C                   ENDIF
219000121213    ***
219100121213     C                   EXSR      $WRTERM
219200121213    ***
219300121213    *C                   ENDSR
219400121213   S***S
219500121213    *C     $WRTERM       BEGSR
219600121213    ***
219700130204    *C                   CLEAR                   AEB004F
219800121213     C                   EVAL      NTSSNO         = KF@SSN
219900121213     C                   EVAL      NTDEPNO        = KF@SEQ
220000130211     C                   EVAL      NTTERMDT       = KF@TRM
220100121213     C                   EVAL      NTPLAN         = KF@PLN
220200121213     C                   EVAL      NTCOVTP        = KF@ENR
220300121213     C                   EVAL      NTTRST         = KF@TRS
220400121213     C                   EVAL      NTSUB#         = KF@SUB
220500121213     C                   EVAL      NTACCT         = KF@ACC
220600121213     C                   EVAL      NTTRANSDT      = #TODAY
220700130204     C                   EVAL      NTCOUNT = 1
220800130204     C                   WRITE     AEB004F
220900121213    ***
221000121213    *C                   ENDSR
221100121213   S***S
221200121213      * CHECK FOR DENTAL TERMINATION
221300121213    *C     $CHKDEN       BEGSR
221400121213    ***
221500121213    *C                   EVAL      TERM_DEN = YES
221600130211    *C                   EVAL      KF@TRM = DEN@TRM(DEN#CNE)
221700121213    *C                   EVAL      KF@PLN = DEN@PLN(DEN#CNE)
221800121213    *C                   EVAL      KF@ENR = DEN@ENR(DEN#CNE)
221900121213    ***
222000130204    *C     KL#MTR        CHAIN     AEB004F
222100130204    *C                   IF        %FOUND(AEB004WF)
222200130204     C                   IF        NTCOUNT > 1
222300130204    *C                   EVAL      DEN#CNE = 0
222400130204    *C                   EVAL      TERM_DEN = NO
222500130204     C                   ELSE
222600130204     C                   ADD       1             NTCOUNT
222700130212     C                   EVAL      NTTRANSD2      = #TODAY
222800130204     C                   UPDATE    AEB004F
222900130204     C                   ENDIF
223000130606     C                   LEAVESR
223100121213    *C                   ENDIF
223200121213    ***
223300121213     C                   EXSR      $WRTERM
223400121213    ***
223500121213    *C                   ENDSR
223600121213   S***S
223700121213      * CHECK FOR DRUG TERMINATION
223800121213    *C     $CHKRXD       BEGSR
223900121213    ***
224000121213    *C                   EVAL      TERM_RXD = YES
224100130211    *C                   EVAL      KF@TRM = RXD@TRM(RXD#CNE)
224200121213    *C                   EVAL      KF@PLN = RXD@PLN(RXD#CNE)
224300121213    *C                   EVAL      KF@ENR = RXD@ENR(RXD#CNE)
224400121213    ***
224500130204    *C     KL#MTR        CHAIN     AEB004F
224600130204    *C                   IF        %FOUND(AEB004WF)
224700130204     C                   IF        NTCOUNT > 1
224800130204    *C                   EVAL      RXD#CNE = 0
224900130204    *C                   EVAL      TERM_RXD = NO
225000130204     C                   ELSE
225100130204     C                   ADD       1             NTCOUNT
225200130212     C                   EVAL      NTTRANSD2      = #TODAY
225300130204     C                   UPDATE    AEB004F
225400130204     C                   ENDIF
225500130606     C                   LEAVESR
225600121213    *C                   ENDIF
225700121213    ***
225800121213     C                   EXSR      $WRTERM
225900121213    ***
226000121213    *C                   ENDSR
226100121213   S***S
226200121213      * CHECK FOR VISION TERMINATION
226300121213    *C     $CHKVIS       BEGSR
226400121213    ***
226500121213    *C                   EVAL      TERM_VIS = YES
226600130211    *C                   EVAL      KF@TRM = VIS@TRM(VIS#CNE)
226700121213    *C                   EVAL      KF@PLN = VIS@PLN(VIS#CNE)
226800121213    *C                   EVAL      KF@ENR = VIS@ENR(VIS#CNE)
226900121213    ***
227000130204    *C     KL#MTR        CHAIN     AEB004F
227100130204    *C                   IF        %FOUND(AEB004WF)
227200130204     C                   IF        NTCOUNT > 1
227300130204    *C                   EVAL      VIS#CNE = 0
227400130204    *C                   EVAL      TERM_VIS = NO
227500130204     C                   ELSE
227600130204     C                   ADD       1             NTCOUNT
227700130212     C                   EVAL      NTTRANSD2      = #TODAY
227800130204     C                   UPDATE    AEB004F
227900130204     C                   ENDIF
228000130606     C                   LEAVESR
228100121213    *C                   ENDIF
228200121213    ***
228300121213     C                   EXSR      $WRTERM
228400121213    ***
228500121213    *C                   ENDSR
228600121213   S***S
228700121213      * CHECK FOR LTD TERMINATION
228800121213    *C     $CHKLTD       BEGSR
228900121213    ***
229000121213    *C                   EVAL      TERM_LTD = YES
229100130211    *C                   EVAL      KF@TRM = LTD@TRM(LTD#CNE)
229200121213    *C                   EVAL      KF@PLN = LTD@PLN(LTD#CNE)
229300121213    *C                   EVAL      KF@ENR = LTD@ENR(LTD#CNE)
229400121213    ***
229500130204    *C     KL#MTR        CHAIN     AEB004F
229600130204    *C                   IF        %FOUND(AEB004WF)
229700130204     C                   IF        NTCOUNT > 1
229800130204    *C                   EVAL      LTD#CNE = 0
229900130204    *C                   EVAL      TERM_LTD = NO
230000130204     C                   ELSE
230100130204     C                   ADD       1             NTCOUNT
230200130212     C                   EVAL      NTTRANSD2      = #TODAY
230300130204     C                   UPDATE    AEB004F
230400130204     C                   ENDIF
230500130606     C                   LEAVESR
230600121213    *C                   ENDIF
230700121213    ***
230800121213     C                   EXSR      $WRTERM
230900121213    ***
231000121213    *C                   ENDSR
231100121213   S***S
231200121213      * CHECK FOR STD TERMINATION
231300121213    *C     $CHKSTD       BEGSR
231400121213    ***
231500121213    *C                   EVAL      TERM_STD = YES
231600130211    *C                   EVAL      KF@TRM = STD@TRM(STD#CNE)
231700121213    *C                   EVAL      KF@PLN = STD@PLN(STD#CNE)
231800121213    *C                   EVAL      KF@ENR = STD@ENR(STD#CNE)
231900121213    ***
232000130204    *C     KL#MTR        CHAIN     AEB004F
232100130204    *C                   IF        %FOUND(AEB004WF)
232200130204     C                   IF        NTCOUNT > 1
232300130204    *C                   EVAL      STD#CNE = 0
232400130204    *C                   EVAL      TERM_STD = NO
232500130204     C                   ELSE
232600130204     C                   ADD       1             NTCOUNT
232700130212     C                   EVAL      NTTRANSD2      = #TODAY
232800130204     C                   UPDATE    AEB004F
232900130204     C                   ENDIF
233000130606     C                   LEAVESR
233100121213    *C                   ENDIF
233200121213    ***
233300121213     C                   EXSR      $WRTERM
233400121213    ***
233500121213    *C                   ENDSR
233600121213   S***S
233700121213      * CHECK FOR LIFE TERMINATION
233800121213    *C     $CHKLIF       BEGSR
233900121213    ***
234000121213    *C                   EVAL      TERM_LIF = YES
234100130211    *C                   EVAL      KF@TRM = LIF@TRM(LIF#CNE)
234200121213    *C                   EVAL      KF@PLN = LIF@PLN(LIF#CNE)
234300121213    *C                   EVAL      KF@ENR = LIF@ENR(LIF#CNE)
234400121213    ***
234500130204    *C     KL#MTR        CHAIN     AEB004F
234600130204    *C                   IF        %FOUND(AEB004WF)
234700130204     C                   IF        NTCOUNT > 1
234800130204    *C                   EVAL      LIF#CNE = 0
234900130204    *C                   EVAL      TERM_LIF = NO
235000130204     C                   ELSE
235100130204     C                   ADD       1             NTCOUNT
235200130212     C                   EVAL      NTTRANSD2      = #TODAY
235300130204     C                   UPDATE    AEB004F
235400130204     C                   ENDIF
235500130606     C                   LEAVESR
235600121213    *C                   ENDIF
235700121213    ***
235800121213     C                   EXSR      $WRTERM
235900121213    ***
236000121213    *C                   ENDSR
236100121213   S***S
236200121213      * CHECK FOR AD&D TERMINATION
236300121213    *C     $CHKADD       BEGSR
236400121213    ***
236500121213    *C                   EVAL      TERM_ADD = YES
236600130211    *C                   EVAL      KF@TRM = ADD@TRM(ADD#CNE)
236700121213    *C                   EVAL      KF@PLN = ADD@PLN(ADD#CNE)
236800121213    *C                   EVAL      KF@ENR = ADD@ENR(ADD#CNE)
236900121213    ***
237000130204    *C     KL#MTR        CHAIN     AEB004F
237100130204    *C                   IF        %FOUND(AEB004WF)
237200130204     C                   IF        NTCOUNT > 1
237300130204    *C                   EVAL      ADD#CNE = 0
237400130204    *C                   EVAL      TERM_ADD = NO
237500130204     C                   ELSE
237600130204     C                   ADD       1             NTCOUNT
237700130212     C                   EVAL      NTTRANSD2      = #TODAY
237800130204     C                   UPDATE    AEB004F
237900130204     C                   ENDIF
238000130606     C                   LEAVESR
238100121213    *C                   ENDIF
238200121213    ***
238300121213     C                   EXSR      $WRTERM
238400121213    ***
238500121213    *C                   ENDSR
238600121213   S***S
238700121213      * CHECK FOR DEPENDENT LIFE TERMINATION
238800121213    *C     $CHKDLF       BEGSR
238900121213    ***
239000121213    *C                   EVAL      TERM_DLF = YES
239100130211    *C                   EVAL      KF@TRM = DLF@TRM(DLF#CNE)
239200121213    *C                   EVAL      KF@PLN = DLF@PLN(DLF#CNE)
239300121213    *C                   EVAL      KF@ENR = DLF@ENR(DLF#CNE)
239400121213    ***
239500130204    *C     KL#MTR        CHAIN     AEB004F
239600130204    *C                   IF        %FOUND(AEB004WF)
239700130204     C                   IF        NTCOUNT > 1
239800130204    *C                   EVAL      DLF#CNE = 0
239900130204    *C                   EVAL      TERM_DLF = NO
240000130204     C                   ELSE
240100130204     C                   ADD       1             NTCOUNT
240200130212     C                   EVAL      NTTRANSD2      = #TODAY
240300130204     C                   UPDATE    AEB004F
240400130204     C                   ENDIF
240500130606     C                   LEAVESR
240600121213    *C                   ENDIF
240700121213    ***
240800121213     C                   EXSR      $WRTERM
240900121213    ***
241000121213    *C                   ENDSR
241100121213   S***S
241200121213      * CHECK FOR VOLUNATRY LIFE TERMINATION
241300121213    *C     $CHKVLF       BEGSR
241400121213    ***
241500121213    *C                   EVAL      TERM_VLF = YES
241600130211    *C                   EVAL      KF@TRM = VLF@TRM(VLF#CNE)
241700121213    *C                   EVAL      KF@PLN = VLF@PLN(VLF#CNE)
241800121213    *C                   EVAL      KF@ENR = VLF@ENR(VLF#CNE)
241900121213    ***
242000130204    *C     KL#MTR        CHAIN     AEB004F
242100130204    *C                   IF        %FOUND(AEB004WF)
242200130204     C                   IF        NTCOUNT > 1
242300130204    *C                   EVAL      VLF#CNE = 0
242400130204    *C                   EVAL      TERM_VLF = NO
242500130204     C                   ELSE
242600130204     C                   ADD       1             NTCOUNT
242700130212     C                   EVAL      NTTRANSD2      = #TODAY
242800130204     C                   UPDATE    AEB004F
242900130204     C                   ENDIF
243000130606     C                   LEAVESR
243100121213    *C                   ENDIF
243200121213    ***
243300121213     C                   EXSR      $WRTERM
243400121213    ***
243500121213    *C                   ENDSR
243600121213   S***S
243700121213      * CHECK FOR VOLUNATRY AD&D TERMINATION
243800121213    *C     $CHKVAD       BEGSR
243900121213    ***
244000121213    *C                   EVAL      TERM_VAD = YES
244100130211    *C                   EVAL      KF@TRM = VAD@TRM(VAD#CNE)
244200121213    *C                   EVAL      KF@PLN = VAD@PLN(VAD#CNE)
244300121213    *C                   EVAL      KF@ENR = VAD@ENR(VAD#CNE)
244400121213    ***
244500130204    *C     KL#MTR        CHAIN     AEB004F
244600130204    *C                   IF        %FOUND(AEB004WF)
244700130204     C                   IF        NTCOUNT > 1
244800130204    *C                   EVAL      VAD#CNE = 0
244900130204    *C                   EVAL      TERM_VAD = NO
245000130204     C                   ELSE
245100130204     C                   ADD       1             NTCOUNT
245200130212     C                   EVAL      NTTRANSD2      = #TODAY
245300130204     C                   UPDATE    AEB004F
245400130204     C                   ENDIF
245500130606     C                   LEAVESR
245600121213    *C                   ENDIF
245700121213    ***
245800121213     C                   EXSR      $WRTERM
245900121213    ***
246000121213    *C                   ENDSR
246100121213   S***S
246200121213      * CHECK FOR VOLUNATRY LTD TERMINATION
246300121213    *C     $CHKVLT       BEGSR
246400121213    ***
246500121213    *C                   EVAL      TERM_VLT = YES
246600130211    *C                   EVAL      KF@TRM = VLT@TRM(VLT#CNE)
246700121213    *C                   EVAL      KF@PLN = VLT@PLN(VLT#CNE)
246800121213    *C                   EVAL      KF@ENR = VLT@ENR(VLT#CNE)
246900121213    ***
247000130204    *C     KL#MTR        CHAIN     AEB004F
247100130204    *C                   IF        %FOUND(AEB004WF)
247200130204     C                   IF        NTCOUNT > 1
247300130204    *C                   EVAL      VLT#CNE = 0
247400130204    *C                   EVAL      TERM_VLT = NO
247500130204     C                   ELSE
247600130204     C                   ADD       1             NTCOUNT
247700130212     C                   EVAL      NTTRANSD2      = #TODAY
247800130204     C                   UPDATE    AEB004F
247900130204     C                   ENDIF
248000130606     C                   LEAVESR
248100121213    *C                   ENDIF
248200121213    ***
248300121213     C                   EXSR      $WRTERM
248400121213    ***
248500121213    *C                   ENDSR
248600121213   S***S
248700121213      * CHECK FOR CRITICAL ILLNESS TERMINATION
248800121213    *C     $CHKCRI       BEGSR
248900121213    ***
249000121213    *C                   EVAL      TERM_CRI = YES
249100130211    *C                   EVAL      KF@TRM = CRI@TRM(CRI#CNE)
249200121213    *C                   EVAL      KF@PLN = CRI@PLN(CRI#CNE)
249300121213    *C                   EVAL      KF@ENR = CRI@ENR(CRI#CNE)
249400121213    ***
249500130204    *C     KL#MTR        CHAIN     AEB004F
249600130204    *C                   IF        %FOUND(AEB004WF)
249700130204     C                   IF        NTCOUNT > 1
249800130204    *C                   EVAL      CRI#CNE = 0
249900130204    *C                   EVAL      TERM_CRI = NO
250000130204     C                   ELSE
250100130204     C                   ADD       1             NTCOUNT
250200130212     C                   EVAL      NTTRANSD2      = #TODAY
250300130204     C                   UPDATE    AEB004F
250400130204     C                   ENDIF
250500130606     C                   LEAVESR
250600121213    *C                   ENDIF
250700121213    ***
250800121213     C                   EXSR      $WRTERM
250900121213    ***
251000121213    *C                   ENDSR
251100121213   S***S
251200121213      * CHECK FOR VOLUNATRY CRITICAL ILLNESS TERMINATION
251300121213    *C     $CHKVCI       BEGSR
251400121213    ***
251500121213    *C                   EVAL      TERM_VCI = YES
251600130211    *C                   EVAL      KF@TRM = VCI@TRM(VCI#CNE)
251700121213    *C                   EVAL      KF@PLN = VCI@PLN(VCI#CNE)
251800121213    *C                   EVAL      KF@ENR = VCI@ENR(VCI#CNE)
251900121213    ***
252000130204    *C     KL#MTR        CHAIN     AEB004F
252100130204    *C                   IF        %FOUND(AEB004WF)
252200130204     C                   IF        NTCOUNT > 1
252300130204    *C                   EVAL      VCI#CNE = 0
252400130204    *C                   EVAL      TERM_VCI = NO
252500130204     C                   ELSE
252600130204     C                   ADD       1             NTCOUNT
252700130212     C                   EVAL      NTTRANSD2      = #TODAY
252800130204     C                   UPDATE    AEB004F
252900130204     C                   ENDIF
253000130606     C                   LEAVESR
253100121213    *C                   ENDIF
253200121213    ***
253300121213     C                   EXSR      $WRTERM
253400121213    ***
253500121213    *C                   ENDSR
253600121213   S***S
253700130204      * CHECK FOR ACCIDENT COVERAGE TERMINATION
253800130204    *C     $CHKACC       BEGSR
253900130204    ***
254000130204    *C                   EVAL      TERM_ACC = YES
254100130211    *C                   EVAL      KF@TRM = ACC@TRM(ACC#CNE)
254200130204    *C                   EVAL      KF@PLN = ACC@PLN(ACC#CNE)
254300130204    *C                   EVAL      KF@ENR = ACC@ENR(ACC#CNE)
254400130204    ***
254500130204    *C     KL#MTR        CHAIN     AEB004F
254600130204    *C                   IF        %FOUND(AEB004WF)
254700130204     C                   IF        NTCOUNT > 1
254800130204    *C                   EVAL      ACC#CNE = 0
254900130204    *C                   EVAL      TERM_ACC = NO
255000130204     C                   ELSE
255100130204     C                   ADD       1             NTCOUNT
255200130212     C                   EVAL      NTTRANSD2      = #TODAY
255300130204     C                   UPDATE    AEB004F
255400130204     C                   ENDIF
255500130606     C                   LEAVESR
255600130204    *C                   ENDIF
255700130204    ***
255800130204     C                   EXSR      $WRTERM
255900130204    ***
256000130204    *C                   ENDSR
256100130204   S***S
256200130204      * CHECK FOR CANCER COVERAGE TERMINATION
256300130204    *C     $CHKCCR       BEGSR
256400130204    ***
256500130204    *C                   EVAL      TERM_CCR = YES
256600130211    *C                   EVAL      KF@TRM = CCR@TRM(CCR#CNE)
256700130204    *C                   EVAL      KF@PLN = CCR@PLN(CCR#CNE)
256800130204    *C                   EVAL      KF@ENR = CCR@ENR(CCR#CNE)
256900130204    ***
257000130204    *C     KL#MTR        CHAIN     AEB004F
257100130204    *C                   IF        %FOUND(AEB004WF)
257200130204     C                   IF        NTCOUNT > 1
257300130204    *C                   EVAL      CCR#CNE = 0
257400130204    *C                   EVAL      TERM_CCR = NO
257500130204     C                   ELSE
257600130204     C                   ADD       1             NTCOUNT
257700130212     C                   EVAL      NTTRANSD2      = #TODAY
257800130204     C                   UPDATE    AEB004F
257900130204     C                   ENDIF
258000130606     C                   LEAVESR
258100130204    *C                   ENDIF
258200130204    ***
258300130204     C                   EXSR      $WRTERM
258400130204    ***
258500130204    *C                   ENDSR
258600130204   S***S
258700121213     C     $PLANSRCH     BEGSR
258800121213    ***
258900121213     C                   MOVE      *BLANKS       PLN@CAT          10
259000121213     C                   EVAL      PP# = 0
259100121213     C                   CLEAR                   DS@CARPLN
259200121213    ***
259300121213     C                   DO        PC#
259400121213    * *
259500121213     C                   ADD       1             PP#
259600121213     C     PP#           OCCUR     CARPLN@
259700121213    * *
259800121213     C                   IF        XPPLAN = @PLANIN AND
259900121213     C                             XPCCTR = @CCTRIN
260000121213     C                   EVAL      DS@CARPLN = CARPLN@
260100130211     C                   EVAL      PLN@CAT = %TRIM(XPCID3)
260200121213     C                   LEAVE
260300121213     C                   ENDIF
260400121213    * *
260500121213     C                   ENDDO
260600121213    ***
260700121213     C                   ENDSR
260800130205   S***S
