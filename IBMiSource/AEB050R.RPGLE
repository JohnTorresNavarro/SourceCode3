000100130307   X***X CARRIER CONTROL ID #0000000078 ASSURANT SPECIFIC
000200121213   X***X SSK 12.13.2012 TEMPLATE DESIGN
000300130103   X***X THIS WAS BASED ON THE GUARDIAN DESIGN AND MODIFIED FROM THERE.
000400130103   X***X
000500121213   X***X
000600130307   X***X 03.07.2013 CLONED FROM AEB0X0R
000700130530   X***X 05.29.2013 ASSUARANT APPROVED FOR PRODUCTION
000800121213   X***X
000900121213   X***X
001000121213   X***X ACCOUNTS SET-UP
001100130307   X***X 591-004-0252  NATIONAL CRIME PREVENTION
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
003600130307     D CARR#CTL        S             10A   INZ('0000000078')
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
100000140108      *
100100140114     C*                  IF        MBSSNO = 212294756
100200140114     C*                  EVAL      AE@@SDTE = '20130401'
100300140114     C*                  ENDIF
100400130320      *
100500130320     C                   EVAL      #CANCEL = DEN@TRM(DEN#CNE)
100600130320     C                   IF        #CANCEL = 99999999
100700130320     C                   EVAL      AE@@BAC = 'ENR'
100800130320     C                   EVAL      #XSX = DEN@FRM(DEN#CNE)
100900130320     C                   ELSE
101000130320     C                   EVAL      AE@@BAC = 'TRM'
101100130320     C                   EVAL      #XSX = DEN@TRM(DEN#CNE)
101200130320     C                   ENDIF
101300130320     C                   MOVE      #XSX          AE@@AED
101400130320      *
101500130320     C*                  EVAL      AE@@VOL = DEN@VOL(DEN#CNE)
101600130320     C                   EVAL      AE@@DT = '0'
101700130320     C                   EVAL      #XSX = DEN@FRM(DEN#CNE)
101800130320     C                   MOVE      #XSX          AE@@MDTE
101900130320     C                   ADD       1             NDX
102000130320     C                   EVAL      @@AE(NDX) = AE@@
102100130320      *
102200130320     C                   ENDIF
102300130320    ***
102400130320     C                   IF        RXD#CNE > 0
102500130320      * RXD
102600130320     C                   EVAL      @PLANIN = RXD@PLN(RXD#CNE)
102700130320     C                   EXSR      $QUIK
102800130320     C                   EXSR      $PLANSRCH
102900130320     C                   IF        PLN@CAT = *BLANKS
103000130320     C     'RXD FILL'    DSPLY     '*EXT'
103100130320     C                   SETON                                        H1
103200130320     C                   ENDIF
103300130320      *
103400130320     C                   CLEAR                   AE@@
103500130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
103600130320     C                   EVAL      AE@@COV = RXD@ENR(RXD#CNE)
103700130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
103800130320     C                   EVAL      AEMG = %TRIM(CPCID1)
103900130320      *
104000130320     C                   EVAL      #XSX = RXD@FRM(RXD#CNE)
104100130320     C                   MOVE      #XSX          #SIGN
104200130320     C                   SUBDUR    1:*D          #SIGN
104300130320     C                   MOVE      #SIGN         #XSX
104400130320     C                   EVAL      AE@@DTS = '1'
104500130320     C                   MOVE      #XSX          AE@@SDTE
104600130320      *
104700130320     C                   EVAL      #CANCEL = RXD@TRM(RXD#CNE)
104800130320     C                   IF        #CANCEL = 99999999
104900130320     C                   EVAL      AE@@BAC = 'ENR'
105000130320     C                   EVAL      #XSX = RXD@FRM(RXD#CNE)
105100130320     C                   ELSE
105200130320     C                   EVAL      AE@@BAC = 'TRM'
105300130320     C                   EVAL      #XSX = RXD@TRM(RXD#CNE)
105400130320     C                   ENDIF
105500130320     C                   MOVE      #XSX          AE@@AED
105600130320      *
105700130320     C*                  EVAL      AE@@VOL = RXD@VOL(RXD#CNE)
105800130320     C                   EVAL      AE@@DT = '0'
105900130320     C                   EVAL      #XSX = RXD@FRM(RXD#CNE)
106000130320     C                   MOVE      #XSX          AE@@MDTE
106100130320     C                   ADD       1             NDX
106200130320     C                   EVAL      @@AE(NDX) = AE@@
106300130320      *
106400130320     C                   ENDIF
106500130320    ***
106600130320     C                   IF        VIS#CNE > 0
106700130320      *  VISION
106800130320     C                   EVAL      @PLANIN = VIS@PLN(VIS#CNE)
106900130320     C                   EVAL      @ENRIN = VIS@ENR(VIS#CNE)
107000130320     C                   EXSR      $QUIK
107100130320     C                   EXSR      $PLANSRCH
107200130320     C                   IF        PLN@CAT = *BLANKS
107300130320     C     'VIS FILL'    DSPLY     '*EXT'
107400130320     C                   SETON                                        H1
107500130320     C                   ENDIF
107600130320      *
107700130320     C                   CLEAR                   AE@@
107800130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
107900130320     C                   EVAL      AE@@COV = VIS@ENR(VIS#CNE)
108000130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
108100130320     C                   EVAL      AEMG = %TRIM(CPCID1)
108200130320      *
108300130320     C                   EVAL      #XSX = VIS@FRM(VIS#CNE)
108400130320     C                   MOVE      #XSX          #SIGN
108500130320     C                   SUBDUR    1:*D          #SIGN
108600130320     C                   MOVE      #SIGN         #XSX
108700130320     C                   EVAL      AE@@DTS = '1'
108800130320     C                   MOVE      #XSX          AE@@SDTE
108900130320      *
109000130320     C                   EVAL      #CANCEL = VIS@TRM(VIS#CNE)
109100130320     C                   IF        #CANCEL = 99999999
109200130320     C                   EVAL      AE@@BAC = 'ENR'
109300130320     C                   EVAL      #XSX = VIS@FRM(VIS#CNE)
109400130320     C                   ELSE
109500130320     C                   EVAL      AE@@BAC = 'TRM'
109600130320     C                   EVAL      #XSX = VIS@TRM(VIS#CNE)
109700130320     C                   ENDIF
109800130320     C                   MOVE      #XSX          AE@@AED
109900130320      *
110000130320     C*                  EVAL      AE@@VOL = VIS@VOL(VIS#CNE)
110100130320     C                   EVAL      AE@@DT = '0'
110200130320     C                   EVAL      #XSX = VIS@FRM(VIS#CNE)
110300130320     C                   MOVE      #XSX          AE@@MDTE
110400130320     C                   ADD       1             NDX
110500130320     C                   EVAL      @@AE(NDX) = AE@@
110600130320      *
110700130320     C                   ENDIF
110800130320    ***
110900130320     C                   IF        LTD#CNE > 0 AND WRT@TYPE = 'MEMBER'
111000130320      * LTD
111100130320     C                   EVAL      @PLANIN = LTD@PLN(LTD#CNE)
111200130320     C                   EVAL      @ENRIN = LTD@ENR(LTD#CNE)
111300130320     C                   EXSR      $QUIK
111400130320     C                   EXSR      $PLANSRCH
111500130320     C                   IF        PLN@CAT = *BLANKS
111600130320     C     'LTD FILL'    DSPLY     '*EXT'
111700130320     C                   SETON                                        H1
111800130320     C                   ENDIF
111900130320      *
112000130320     C                   CLEAR                   AE@@
112100130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
112200130320     C                   EVAL      AE@@COV = LTD@ENR(LTD#CNE)
112300130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
112400130320     C                   EVAL      AEMG = %TRIM(CPCID1)
112500130320      *
112600130320     C                   EVAL      #XSX = LTD@FRM(LTD#CNE)
112700130320     C                   MOVE      #XSX          #SIGN
112800130320     C                   SUBDUR    1:*D          #SIGN
112900130320     C                   MOVE      #SIGN         #XSX
113000130320     C                   EVAL      AE@@DTS = '1'
113100130320     C                   MOVE      #XSX          AE@@SDTE
113200130320      *
113300130320     C                   EVAL      #CANCEL = LTD@TRM(LTD#CNE)
113400130320     C                   IF        #CANCEL = 99999999
113500130320     C                   EVAL      AE@@BAC = 'ENR'
113600130320     C                   EVAL      #XSX = LTD@FRM(LTD#CNE)
113700130320     C                   ELSE
113800130320     C                   EVAL      AE@@BAC = 'TRM'
113900130320     C                   EVAL      #XSX = LTD@TRM(LTD#CNE)
114000130320     C                   ENDIF
114100130320     C                   MOVE      #XSX          AE@@AED
114200130320      *
114300130320     C                   IF        CPCID6 = 'Y'
114400130320     C                   EVAL      #7S0 = LTD@VOL(LTD#CNE)
114500130320     C     #7S0          MULT      100           #15S0
114600130320     C                   MOVE      #15S0         AE@@VOL
114700130320     C                   ELSE
114800130320     C                   EVAL      AE@@VOL = *BLANKS
114900130320     C                   ENDIF
115000130320      *
115100130320     C                   EVAL      AE@@DT = '0'
115200130320     C                   EVAL      #XSX = LTD@FRM(LTD#CNE)
115300130320     C                   MOVE      #XSX          AE@@MDTE
115400130320     C                   ADD       1             NDX
115500130320     C                   EVAL      @@AE(NDX) = AE@@
115600130320      *
115700130320     C                   ENDIF
115800130320    ***
115900130320     C                   IF        STD#CNE > 0 AND WRT@TYPE = 'MEMBER'
116000130320      * STD
116100130320     C                   EVAL      @PLANIN = STD@PLN(STD#CNE)
116200130320     C                   EVAL      @ENRIN = STD@ENR(STD#CNE)
116300130320     C                   EXSR      $QUIK
116400130320     C                   EXSR      $PLANSRCH
116500130320     C                   IF        PLN@CAT = *BLANKS
116600130320     C     'STD FILL'    DSPLY     '*EXT'
116700130320     C                   SETON                                        H1
116800130320     C                   ENDIF
116900130320      *
117000130320     C                   CLEAR                   AE@@
117100130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
117200130320     C                   EVAL      AE@@COV = STD@ENR(STD#CNE)
117300130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
117400130320     C                   EVAL      AEMG = %TRIM(CPCID1)
117500130320      *
117600130320     C                   EVAL      #XSX = STD@FRM(STD#CNE)
117700130320     C                   MOVE      #XSX          #SIGN
117800130320     C                   SUBDUR    1:*D          #SIGN
117900130320     C                   MOVE      #SIGN         #XSX
118000130320     C                   EVAL      AE@@DTS = '1'
118100130320     C                   MOVE      #XSX          AE@@SDTE
118200130320      *
118300130320     C                   EVAL      #CANCEL = STD@TRM(STD#CNE)
118400130320     C                   IF        #CANCEL = 99999999
118500130320     C                   EVAL      AE@@BAC = 'ENR'
118600130320     C                   EVAL      #XSX = STD@FRM(STD#CNE)
118700130320     C                   ELSE
118800130320     C                   EVAL      AE@@BAC = 'TRM'
118900130320     C                   EVAL      #XSX = STD@TRM(STD#CNE)
119000130320     C                   ENDIF
119100130320     C                   MOVE      #XSX          AE@@AED
119200130320      *
119300130320     C                   IF        CPCID6 = 'Y'
119400130320     C                   EVAL      #7S0 = STD@VOL(STD#CNE)
119500130320     C     #7S0          MULT      100           #15S0
119600130320     C                   MOVE      #15S0         AE@@VOL
119700130320     C                   ELSE
119800130320     C                   EVAL      AE@@VOL = *BLANKS
119900130320     C                   ENDIF
120000130320      *
120100130320     C                   EVAL      AE@@DT = '0'
120200130320     C                   EVAL      #XSX = STD@FRM(STD#CNE)
120300130320     C                   MOVE      #XSX          AE@@MDTE
120400130320     C                   ADD       1             NDX
120500130320     C                   EVAL      @@AE(NDX) = AE@@
120600130320      *
120700130320     C                   ENDIF
120800130320    ***
120900130320     C                   IF        LIF#CNE > 0 AND WRT@TYPE = 'MEMBER'
121000130320      * BASIC LIFE
121100130320     C                   EVAL      @PLANIN = LIF@PLN(LIF#CNE)
121200130320     C                   EVAL      @ENRIN = LIF@ENR(LIF#CNE)
121300130320     C                   EXSR      $QUIK
121400130320     C                   EXSR      $PLANSRCH
121500130320     C                   IF        PLN@CAT = *BLANKS
121600130320     C     'LIF FILL'    DSPLY     '*EXT'
121700130320     C                   SETON                                        H1
121800130320     C                   ENDIF
121900130320      *
122000130320     C                   CLEAR                   AE@@
122100130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
122200130320     C                   EVAL      AE@@COV = LIF@ENR(LIF#CNE)
122300130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
122400130320     C                   EVAL      AEMG = %TRIM(CPCID1)
122500130320      *
122600130320     C                   EVAL      #XSX = LIF@FRM(LIF#CNE)
122700130320     C                   MOVE      #XSX          #SIGN
122800130320     C                   SUBDUR    1:*D          #SIGN
122900130320     C                   MOVE      #SIGN         #XSX
123000130320     C                   EVAL      AE@@DTS = '1'
123100130320     C                   MOVE      #XSX          AE@@SDTE
123200130320      *
123300130320     C                   EVAL      #CANCEL = LIF@TRM(LIF#CNE)
123400130320     C                   IF        #CANCEL = 99999999
123500130320     C                   EVAL      AE@@BAC = 'ENR'
123600130320     C                   EVAL      #XSX = LIF@FRM(LIF#CNE)
123700130320     C                   ELSE
123800130320     C                   EVAL      AE@@BAC = 'TRM'
123900130320     C                   EVAL      #XSX = LIF@TRM(LIF#CNE)
124000130320     C                   ENDIF
124100130320     C                   MOVE      #XSX          AE@@AED
124200130320      *
124300130320     C                   IF        CPCID6 = 'Y'
124400130320     C                   EVAL      #7S0 = LIF@VOL(LIF#CNE)
124500130320     C     #7S0          MULT      100           #15S0
124600130320     C                   MOVE      #15S0         AE@@VOL
124700130320     C                   ELSE
124800130320     C                   EVAL      AE@@VOL = *BLANKS
124900130320     C                   ENDIF
125000130320      *
125100130320     C                   EVAL      AE@@DT = '0'
125200130320     C                   EVAL      #XSX = LIF@FRM(LIF#CNE)
125300130320     C                   MOVE      #XSX          AE@@MDTE
125400130320     C                   ADD       1             NDX
125500130320     C                   EVAL      @@AE(NDX) = AE@@
125600130320      *
125700130320     C                   ENDIF
125800130320    ***
125900130320     C                   IF        ADD#CNE > 0 AND WRT@TYPE = 'MEMBER'
126000130320      * BASIC AD&D
126100130320     C                   EVAL      @PLANIN = ADD@PLN(ADD#CNE)
126200130320     C                   EVAL      @ENRIN = ADD@ENR(ADD#CNE)
126300130320     C                   EXSR      $QUIK
126400130320     C                   EXSR      $PLANSRCH
126500130320     C                   IF        PLN@CAT = *BLANKS
126600130320     C     'ADD FILL'    DSPLY     '*EXT'
126700130320     C                   SETON                                        H1
126800130320     C                   ENDIF
126900130320      *
127000130320     C                   CLEAR                   AE@@
127100130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
127200130320     C                   EVAL      AE@@COV = ADD@ENR(ADD#CNE)
127300130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
127400130320     C                   EVAL      AEMG = %TRIM(CPCID1)
127500130320      *
127600130320     C                   EVAL      #XSX = ADD@FRM(ADD#CNE)
127700130320     C                   MOVE      #XSX          #SIGN
127800130320     C                   SUBDUR    1:*D          #SIGN
127900130320     C                   MOVE      #SIGN         #XSX
128000130320     C                   EVAL      AE@@DTS = '1'
128100130320     C                   MOVE      #XSX          AE@@SDTE
128200130320      *
128300130320     C                   EVAL      #CANCEL = ADD@TRM(ADD#CNE)
128400130320     C                   IF        #CANCEL = 99999999
128500130320     C                   EVAL      AE@@BAC = 'ENR'
128600130320     C                   EVAL      #XSX = ADD@FRM(ADD#CNE)
128700130320     C                   ELSE
128800130320     C                   EVAL      AE@@BAC = 'TRM'
128900130320     C                   EVAL      #XSX = ADD@TRM(ADD#CNE)
129000130320     C                   ENDIF
129100130320     C                   MOVE      #XSX          AE@@AED
129200130320      *
129300130320     C                   IF        CPCID6 = 'Y'
129400130320     C                   EVAL      #7S0 = ADD@VOL(ADD#CNE)
129500130320     C     #7S0          MULT      100           #15S0
129600130320     C                   MOVE      #15S0         AE@@VOL
129700130320     C                   ELSE
129800130320     C                   EVAL      AE@@VOL = *BLANKS
129900130320     C                   ENDIF
130000130320      *
130100130320     C                   EVAL      AE@@DT = '0'
130200130320     C                   EVAL      #XSX = ADD@FRM(ADD#CNE)
130300130320     C                   MOVE      #XSX          AE@@MDTE
130400130320     C                   ADD       1             NDX
130500130320     C                   EVAL      @@AE(NDX) = AE@@
130600130320      *
130700130320     C                   ENDIF
130800130320    ***
130900130320     C                   IF        DLF#CNE > 0
131000130320      * DEPENDENT LIFE
131100130320     C                   EVAL      @PLANIN = DLF@PLN(DLF#CNE)
131200130320     C                   EVAL      @ENRIN = DLF@ENR(DLF#CNE)
131300130320     C                   EXSR      $QUIK
131400130320     C                   EXSR      $PLANSRCH
131500130320     C                   IF        PLN@CAT = *BLANKS
131600130320     C     'DLF FILL'    DSPLY     '*EXT'
131700130320     C                   SETON                                        H1
131800130320     C                   ENDIF
131900130320      *
132000130320     C                   CLEAR                   AE@@
132100130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
132200130320     C                   EVAL      AE@@COV = DLF@ENR(DLF#CNE)
132300130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
132400130320     C                   EVAL      AEMG = %TRIM(CPCID1)
132500130320      *
132600130320     C                   EVAL      #XSX = DLF@FRM(DLF#CNE)
132700130320     C                   MOVE      #XSX          #SIGN
132800130320     C                   SUBDUR    1:*D          #SIGN
132900130320     C                   MOVE      #SIGN         #XSX
133000130320     C                   EVAL      AE@@DTS = '1'
133100130320     C                   MOVE      #XSX          AE@@SDTE
133200130320      *
133300130320     C                   EVAL      #CANCEL = DLF@TRM(DLF#CNE)
133400130320     C                   IF        #CANCEL = 99999999
133500130320     C                   EVAL      AE@@BAC = 'ENR'
133600130320     C                   EVAL      #XSX = DLF@FRM(DLF#CNE)
133700130320     C                   ELSE
133800130320     C                   EVAL      AE@@BAC = 'TRM'
133900130320     C                   EVAL      #XSX = DLF@TRM(DLF#CNE)
134000130320     C                   ENDIF
134100130320     C                   MOVE      #XSX          AE@@AED
134200130320      *
134300130320     C                   IF        CPCID6 = 'Y'
134400130320     C                   EVAL      #7S0 = DLF@VOL(DLF#CNE)
134500130320     C     #7S0          MULT      100           #15S0
134600130320     C                   MOVE      #15S0         AE@@VOL
134700130320     C                   ELSE
134800130320     C                   EVAL      AE@@VOL = *BLANKS
134900130320     C                   ENDIF
135000130320      *
135100130320     C                   EVAL      AE@@DT = '0'
135200130320     C                   EVAL      #XSX = DLF@FRM(DLF#CNE)
135300130320     C                   MOVE      #XSX          AE@@MDTE
135400130320     C                   ADD       1             NDX
135500130320     C                   EVAL      @@AE(NDX) = AE@@
135600130320      *
135700130320     C                   ENDIF
135800130320    ***
135900130320     C                   IF        VLF#CNE > 0
136000130320      * VOL LIFE
136100130320     C                   EVAL      @PLANIN = VLF@PLN(VLF#CNE)
136200130320     C                   EVAL      @ENRIN = VLF@ENR(VLF#CNE)
136300130320     C                   EXSR      $QUIK
136400130320     C                   EXSR      $PLANSRCH
136500130320     C                   IF        PLN@CAT = *BLANKS
136600130320     C     'VLF FILL'    DSPLY     '*EXT'
136700130320     C                   SETON                                        H1
136800130320     C                   ENDIF
136900130320      *
137000130320     C                   CLEAR                   AE@@
137100130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
137200130320     C                   EVAL      AE@@COV = VLF@ENR(VLF#CNE)
137300130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
137400130320     C                   EVAL      AEMG = %TRIM(CPCID1)
137500130320      *
137600130320     C                   EVAL      #XSX = VLF@FRM(VLF#CNE)
137700130320     C                   MOVE      #XSX          #SIGN
137800130320     C                   SUBDUR    1:*D          #SIGN
137900130320     C                   MOVE      #SIGN         #XSX
138000130320     C                   EVAL      AE@@DTS = '1'
138100130320     C                   MOVE      #XSX          AE@@SDTE
138200130320      *
138300130320     C                   EVAL      #CANCEL = VLF@TRM(VLF#CNE)
138400130320     C                   IF        #CANCEL = 99999999
138500130320     C                   EVAL      AE@@BAC = 'ENR'
138600130320     C                   EVAL      #XSX = VLF@FRM(VLF#CNE)
138700130320     C                   ELSE
138800130320     C                   EVAL      AE@@BAC = 'TRM'
138900130320     C                   EVAL      #XSX = VLF@TRM(VLF#CNE)
139000130320     C                   ENDIF
139100130320     C                   MOVE      #XSX          AE@@AED
139200130320      *
139300130320     C                   IF        CPCID6 = 'Y'
139400130320     C                   EVAL      #7S0 = VLF@VOL(VLF#CNE)
139500130320     C     #7S0          MULT      100           #15S0
139600130320     C                   MOVE      #15S0         AE@@VOL
139700130320     C                   ELSE
139800130320     C                   EVAL      AE@@VOL = *BLANKS
139900130320     C                   ENDIF
140000130320      *
140100130320     C                   EVAL      AE@@DT = '0'
140200130320     C                   EVAL      #XSX = VLF@FRM(VLF#CNE)
140300130320     C                   MOVE      #XSX          AE@@MDTE
140400130320     C                   ADD       1             NDX
140500130320     C                   EVAL      @@AE(NDX) = AE@@
140600130320      *
140700130320     C                   ENDIF
140800130320    ***
140900130320     C                   IF        VAD#CNE > 0
141000130320      * VOLUNTARY AD&D
141100130320     C                   EVAL      @PLANIN = VAD@PLN(VAD#CNE)
141200130320     C                   EVAL      @ENRIN = VAD@ENR(VAD#CNE)
141300130320     C                   EXSR      $QUIK
141400130320     C                   EXSR      $PLANSRCH
141500130320     C                   IF        PLN@CAT = *BLANKS
141600130320     C     'VAD FILL'    DSPLY     '*EXT'
141700130320     C                   SETON                                        H1
141800130320     C                   ENDIF
141900130320      *
142000130320     C                   CLEAR                   AE@@
142100130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
142200130320     C                   EVAL      AE@@COV = VAD@ENR(VAD#CNE)
142300130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
142400130320     C                   EVAL      AEMG = %TRIM(CPCID1)
142500130320      *
142600130320     C                   EVAL      #XSX = VAD@FRM(VAD#CNE)
142700130320     C                   MOVE      #XSX          #SIGN
142800130320     C                   SUBDUR    1:*D          #SIGN
142900130320     C                   MOVE      #SIGN         #XSX
143000130320     C                   EVAL      AE@@DTS = '1'
143100130320     C                   MOVE      #XSX          AE@@SDTE
143200130320      *
143300130320     C                   EVAL      #CANCEL = VAD@TRM(VAD#CNE)
143400130320     C                   IF        #CANCEL = 99999999
143500130320     C                   EVAL      AE@@BAC = 'ENR'
143600130320     C                   EVAL      #XSX = VAD@FRM(VAD#CNE)
143700130320     C                   ELSE
143800130320     C                   EVAL      AE@@BAC = 'TRM'
143900130320     C                   EVAL      #XSX = VAD@TRM(VAD#CNE)
144000130320     C                   ENDIF
144100130320     C                   MOVE      #XSX          AE@@AED
144200130320      *
144300130320     C                   IF        CPCID6 = 'Y'
144400130320     C                   EVAL      #7S0 = VAD@VOL(VAD#CNE)
144500130320     C     #7S0          MULT      100           #15S0
144600130320     C                   MOVE      #15S0         AE@@VOL
144700130320     C                   ELSE
144800130320     C                   EVAL      AE@@VOL = *BLANKS
144900130320     C                   ENDIF
145000130320      *
145100130320     C                   EVAL      AE@@DT = '0'
145200130320     C                   EVAL      #XSX = VAD@FRM(VAD#CNE)
145300130320     C                   MOVE      #XSX          AE@@MDTE
145400130320     C                   ADD       1             NDX
145500130320     C                   EVAL      @@AE(NDX) = AE@@
145600130320      *
145700130320     C                   ENDIF
145800130320    ***
145900130320     C                   IF        VLT#CNE > 0
146000130320      * VOL LTD
146100130320     C                   EVAL      @PLANIN = VLT@PLN(VLT#CNE)
146200130320     C                   EVAL      @ENRIN = VLT@ENR(VLT#CNE)
146300130320     C                   EXSR      $QUIK
146400130320     C                   EXSR      $PLANSRCH
146500130320     C                   IF        PLN@CAT = *BLANKS
146600130320     C     'VLT FILL'    DSPLY     '*EXT'
146700130320     C                   SETON                                        H1
146800130320     C                   ENDIF
146900130320      *
147000130320     C                   CLEAR                   AE@@
147100130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
147200130320     C                   EVAL      AE@@COV = VLT@ENR(VLT#CNE)
147300130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
147400130320     C                   EVAL      AEMG = %TRIM(CPCID1)
147500130320      *
147600130320     C                   EVAL      #XSX = VLT@FRM(VLT#CNE)
147700130320     C                   MOVE      #XSX          #SIGN
147800130320     C                   SUBDUR    1:*D          #SIGN
147900130320     C                   MOVE      #SIGN         #XSX
148000130320     C                   EVAL      AE@@DTS = '1'
148100130320     C                   MOVE      #XSX          AE@@SDTE
148200130320      *
148300130320     C                   EVAL      #CANCEL = VLT@TRM(VLT#CNE)
148400130320     C                   IF        #CANCEL = 99999999
148500130320     C                   EVAL      AE@@BAC = 'ENR'
148600130320     C                   EVAL      #XSX = VLT@FRM(VLT#CNE)
148700130320     C                   ELSE
148800130320     C                   EVAL      AE@@BAC = 'TRM'
148900130320     C                   EVAL      #XSX = VLT@TRM(VLT#CNE)
149000130320     C                   ENDIF
149100130320     C                   MOVE      #XSX          AE@@AED
149200130320      *
149300130320     C                   IF        CPCID6 = 'Y'
149400130320     C                   EVAL      #7S0 = VLT@VOL(VLT#CNE)
149500130320     C     #7S0          MULT      100           #15S0
149600130320     C                   MOVE      #15S0         AE@@VOL
149700130320     C                   ELSE
149800130320     C                   EVAL      AE@@VOL = *BLANKS
149900130320     C                   ENDIF
150000130320      *
150100130320     C                   EVAL      AE@@DT = '0'
150200130320     C                   EVAL      #XSX = VLT@FRM(VLT#CNE)
150300130320     C                   MOVE      #XSX          AE@@MDTE
150400130320     C                   ADD       1             NDX
150500130320     C                   EVAL      @@AE(NDX) = AE@@
150600130320      *
150700130320     C                   ENDIF
150800130320    ***
150900130320     C                   IF        CRI#CNE > 0
151000130320      * CRITICAL ILLNESS
151100130320     C                   EVAL      @PLANIN = CRI@PLN(CRI#CNE)
151200130320     C                   EVAL      @ENRIN = CRI@ENR(CRI#CNE)
151300130320     C                   EXSR      $QUIK
151400130320     C                   EXSR      $PLANSRCH
151500130320     C                   IF        PLN@CAT = *BLANKS
151600130320     C     'CRI FILL'    DSPLY     '*EXT'
151700130320     C                   SETON                                        H1
151800130320     C                   ENDIF
151900130320      *
152000130320     C                   CLEAR                   AE@@
152100130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
152200130320     C                   EVAL      AE@@COV = CRI@ENR(CRI#CNE)
152300130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
152400130320     C                   EVAL      AEMG = %TRIM(CPCID1)
152500130320      *
152600130320     C                   EVAL      #XSX = CRI@FRM(CRI#CNE)
152700130320     C                   MOVE      #XSX          #SIGN
152800130320     C                   SUBDUR    1:*D          #SIGN
152900130320     C                   MOVE      #SIGN         #XSX
153000130320     C                   EVAL      AE@@DTS = '1'
153100130320     C                   MOVE      #XSX          AE@@SDTE
153200130320      *
153300130320     C                   EVAL      #CANCEL = CRI@TRM(CRI#CNE)
153400130320     C                   IF        #CANCEL = 99999999
153500130320     C                   EVAL      AE@@BAC = 'ENR'
153600130320     C                   EVAL      #XSX = CRI@FRM(CRI#CNE)
153700130320     C                   ELSE
153800130320     C                   EVAL      AE@@BAC = 'TRM'
153900130320     C                   EVAL      #XSX = CRI@TRM(CRI#CNE)
154000130320     C                   ENDIF
154100130320     C                   MOVE      #XSX          AE@@AED
154200130320      *
154300130320     C                   IF        CPCID6 = 'Y'
154400130320     C                   EVAL      #7S0 = CRI@VOL(CRI#CNE)
154500130320     C     #7S0          MULT      100           #15S0
154600130320     C                   MOVE      #15S0         AE@@VOL
154700130320     C                   ELSE
154800130320     C                   EVAL      AE@@VOL = *BLANKS
154900130320     C                   ENDIF
155000130320      *
155100130320     C                   EVAL      AE@@DT = '0'
155200130320     C                   EVAL      #XSX = CRI@FRM(CRI#CNE)
155300130320     C                   MOVE      #XSX          AE@@MDTE
155400130320     C                   ADD       1             NDX
155500130320     C                   EVAL      @@AE(NDX) = AE@@
155600130320      *
155700130320     C                   ENDIF
155800130320    ***
155900130320     C                   IF        VCI#CNE > 0
156000130320      * VOL CRITICAL ILLNESS
156100130320     C                   EVAL      @PLANIN = VCI@PLN(VCI#CNE)
156200130320     C                   EVAL      @ENRIN = VCI@ENR(VCI#CNE)
156300130320     C                   EXSR      $QUIK
156400130320     C                   EXSR      $PLANSRCH
156500130320     C                   IF        PLN@CAT = *BLANKS
156600130320     C     'VCI FILL'    DSPLY     '*EXT'
156700130320     C                   SETON                                        H1
156800130320     C                   ENDIF
156900130320      *
157000130320     C                   CLEAR                   AE@@
157100130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
157200130320     C                   EVAL      AE@@COV = VCI@ENR(VCI#CNE)
157300130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
157400130320     C                   EVAL      AEMG = %TRIM(CPCID1)
157500130320      *
157600130320     C                   EVAL      #XSX = VCI@FRM(VCI#CNE)
157700130320     C                   MOVE      #XSX          #SIGN
157800130320     C                   SUBDUR    1:*D          #SIGN
157900130320     C                   MOVE      #SIGN         #XSX
158000130320     C                   EVAL      AE@@DTS = '1'
158100130320     C                   MOVE      #XSX          AE@@SDTE
158200130320      *
158300130320     C                   EVAL      #CANCEL = VCI@TRM(VCI#CNE)
158400130320     C                   IF        #CANCEL = 99999999
158500130320     C                   EVAL      AE@@BAC = 'ENR'
158600130320     C                   EVAL      #XSX = VCI@FRM(VCI#CNE)
158700130320     C                   ELSE
158800130320     C                   EVAL      AE@@BAC = 'TRM'
158900130320     C                   EVAL      #XSX = VCI@TRM(VCI#CNE)
159000130320     C                   ENDIF
159100130320     C                   MOVE      #XSX          AE@@AED
159200130320      *
159300130320     C                   IF        CPCID6 = 'Y'
159400130320     C                   EVAL      #7S0 = VCI@VOL(VCI#CNE)
159500130320     C     #7S0          MULT      100           #15S0
159600130320     C                   MOVE      #15S0         AE@@VOL
159700130320     C                   ELSE
159800130320     C                   EVAL      AE@@VOL = *BLANKS
159900130320     C                   ENDIF
160000130320      *
160100130320     C                   EVAL      AE@@DT = '0'
160200130320     C                   EVAL      #XSX = VCI@FRM(VCI#CNE)
160300130320     C                   MOVE      #XSX          AE@@MDTE
160400130320     C                   ADD       1             NDX
160500130320     C                   EVAL      @@AE(NDX) = AE@@
160600130320      *
160700130320     C                   ENDIF
160800130320    ***
160900130320     C                   IF        ACC#CNE > 0
161000130320      * ACCIDENT COVERAGE
161100130320     C                   EVAL      @PLANIN = ACC@PLN(ACC#CNE)
161200130320     C                   EVAL      @ENRIN = ACC@ENR(ACC#CNE)
161300130320     C                   EXSR      $QUIK
161400130320     C                   EXSR      $PLANSRCH
161500130320     C                   IF        PLN@CAT = *BLANKS
161600130320     C     'ACC FILL'    DSPLY     '*EXT'
161700130320     C                   SETON                                        H1
161800130320     C                   ENDIF
161900130320      *
162000130320     C                   CLEAR                   AE@@
162100130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
162200130320     C                   EVAL      AE@@COV = ACC@ENR(ACC#CNE)
162300130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
162400130320     C                   EVAL      AEMG = %TRIM(CPCID1)
162500130320      *
162600130320     C                   EVAL      #XSX = ACC@FRM(ACC#CNE)
162700130320     C                   MOVE      #XSX          #SIGN
162800130320     C                   SUBDUR    1:*D          #SIGN
162900130320     C                   MOVE      #SIGN         #XSX
163000130320     C                   EVAL      AE@@DTS = '1'
163100130320     C                   MOVE      #XSX          AE@@SDTE
163200130320      *
163300130320     C                   EVAL      #CANCEL = ACC@TRM(ACC#CNE)
163400130320     C                   IF        #CANCEL = 99999999
163500130320     C                   EVAL      AE@@BAC = 'ENR'
163600130320     C                   EVAL      #XSX = ACC@FRM(ACC#CNE)
163700130320     C                   ELSE
163800130320     C                   EVAL      AE@@BAC = 'TRM'
163900130320     C                   EVAL      #XSX = ACC@TRM(ACC#CNE)
164000130320     C                   ENDIF
164100130320     C                   MOVE      #XSX          AE@@AED
164200130320      *
164300130320     C                   IF        CPCID6 = 'Y'
164400130320     C                   EVAL      #7S0 = ACC@VOL(ACC#CNE)
164500130320     C     #7S0          MULT      100           #15S0
164600130320     C                   MOVE      #15S0         AE@@VOL
164700130320     C                   ELSE
164800130320     C                   EVAL      AE@@VOL = *BLANKS
164900130320     C                   ENDIF
165000130320      *
165100130320     C                   EVAL      AE@@DT = '0'
165200130320     C                   EVAL      #XSX = ACC@FRM(ACC#CNE)
165300130320     C                   MOVE      #XSX          AE@@MDTE
165400130320     C                   ADD       1             NDX
165500130320     C                   EVAL      @@AE(NDX) = AE@@
165600130320      *
165700130320     C                   ENDIF
165800130320    ***
165900130320     C                   IF        CCR#CNE > 0
166000130320      * CANCER COVERAGE
166100130320     C                   EVAL      @PLANIN = CCR@PLN(CCR#CNE)
166200130320     C                   EVAL      @ENRIN = CCR@ENR(CCR#CNE)
166300130320     C                   EXSR      $QUIK
166400130320     C                   EXSR      $PLANSRCH
166500130320     C                   IF        PLN@CAT = *BLANKS
166600130320     C     'CCR FILL'    DSPLY     '*EXT'
166700130320     C                   SETON                                        H1
166800130320     C                   ENDIF
166900130320      *
167000130320     C                   CLEAR                   AE@@
167100130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
167200130320     C                   EVAL      AE@@COV = CCR@ENR(CCR#CNE)
167300130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
167400130320     C                   EVAL      AEMG = %TRIM(CPCID1)
167500130320      *
167600130320     C                   EVAL      #XSX = CCR@FRM(CCR#CNE)
167700130320     C                   MOVE      #XSX          #SIGN
167800130320     C                   SUBDUR    1:*D          #SIGN
167900130320     C                   MOVE      #SIGN         #XSX
168000130320     C                   EVAL      AE@@DTS = '1'
168100130320     C                   MOVE      #XSX          AE@@SDTE
168200130320      *
168300130320     C                   EVAL      #CANCEL = CCR@TRM(CCR#CNE)
168400130320     C                   IF        #CANCEL = 99999999
168500130320     C                   EVAL      AE@@BAC = 'ENR'
168600130320     C                   EVAL      #XSX = CCR@FRM(CCR#CNE)
168700130320     C                   ELSE
168800130320     C                   EVAL      AE@@BAC = 'TRM'
168900130320     C                   EVAL      #XSX = CCR@TRM(CCR#CNE)
169000130320     C                   ENDIF
169100130320     C                   MOVE      #XSX          AE@@AED
169200130320      *
169300130320     C                   IF        CPCID6 = 'Y'
169400130320     C                   EVAL      #7S0 = CCR@VOL(CCR#CNE)
169500130320     C     #7S0          MULT      100           #15S0
169600130320     C                   MOVE      #15S0         AE@@VOL
169700130320     C                   ELSE
169800130320     C                   EVAL      AE@@VOL = *BLANKS
169900130320     C                   ENDIF
170000130320      *
170100130320     C                   EVAL      AE@@DT = '0'
170200130320     C                   EVAL      #XSX = CCR@FRM(CCR#CNE)
170300130320     C                   MOVE      #XSX          AE@@MDTE
170400130320     C                   ADD       1             NDX
170500130320     C                   EVAL      @@AE(NDX) = AE@@
170600130320      *
170700130320     C                   ENDIF
170800130320    ***
170900121213     C                   ENDSR
171000121213   S***S
171100121214     C     $PREP5        BEGSR
171200121214    ***
171300121213     C     KF@SSN        CHAIN     DEPENR
171400121213     C                   IF        NOT %FOUND(DEPNDC)
171500121213     C                   EVAL      @STEP = 'STEP2'
171600121213     C                   LEAVESR
171700121213     C                   ENDIF
171800121213    ***
171900121213     C     KF@SSN        SETLL     DEPENR
172000121213    ***
172100121213     C                   EVAL      @STEP = 'STEP5'
172200121213    ***
172300121213     C                   ENDSR
172400121213   S***S
172500121213     C     $STEP5        BEGSR
172600121213    ***
172700121213     C     KF@SSN        READE     DEPENR
172800121213    ***
172900121213     C                   IF        %EOF(DEPNDC)
173000121213     C                   EVAL      @STEP = 'STEP2'
173100121213     C                   LEAVESR
173200121213     C                   ENDIF
173300121213    ***
173400121213     C                   EVAL      KF@SEQ = DPSEQ#
173500121213    ***
173600121213     C     KL#DCV        CHAIN     DCOVR
173700121213     C                   IF        NOT %FOUND(ELIGDCOV)
173800121213     C                   LEAVESR
173900121213     C                   ENDIF
174000121213    ***
174100121213     C                   EXSR      $CLRSTG
174200121213    ***
174300121213     C     KL#DCV        SETLL     DCOVR
174400121213    ***
174500121213     C                   EVAL      @STEP = 'STEP6'
174600121213    ***
174700121213     C                   ENDSR
174800121213   S***S
174900121213     C     $STEP6        BEGSR
175000121213    ***
175100121213     C     KL#DCV        READE     DCOVR
175200121213    ***
175300121213     C                   IF        %EOF(ELIGDCOV)
175400121213     C                   EVAL      @STEP = 'PREP7'
175500121213     C                   LEAVESR
175600121213     C                   ENDIF
175700121213    ***
175800121213     C                   EVAL      @PLANIN = DVPLAN
175900121213     C                   EVAL      @ENRIN = DVENRL
176000121213     C                   EVAL      #EFFDTE = DENRDT
176100130227     C                   EVAL      #CANCEL = CCANDT
176200130211    ***
176300130211     C                   EVAL      #BENAMT = 0
176400130211     *** OR
176500130313     C*******************EVAL      #BENAMT = DVVOL
176600121213    ***
176700121213     C                   EXSR      $QUIK
176800121213    ***
176900121213     C                   EXSR      $PLANSRCH
177000121213    ***
177100121213     C                   IF        PLN@CAT = *BLANKS
177200121213     C                   LEAVESR
177300121213     C                   ENDIF
177400121213    ***
177500130227     C                   EXSR      $TIERLVL
177600130227    ***
177700130227     C                   IF        #CANCEL = 0
177800130227     C                   EVAL      #CANCEL = 99999999
177900130227     C                   ENDIF
178000130227    ***
178100121213     C                   EXSR      $AD2MARY
178200121213    ***
178300121213     C                   ENDSR
178400121213   S***S
178500121213     C     $PREP7        BEGSR
178600121213    ***
178700121213     C                   IF        LIF#CNE  = 0 AND MED#CNE  = 0 AND
178800121213     C                             ADD#CNE  = 0 AND DEN#CNE  = 0 AND
178900121213     C                             DLF#CNE  = 0 AND RXD#CNE  = 0 AND
179000121213     C                             VLF#CNE  = 0 AND VIS#CNE  = 0 AND
179100121213     C                             VAD#CNE  = 0 AND LTD#CNE  = 0 AND
179200121213     C                             VLT#CNE  = 0 AND STD#CNE  = 0 AND
179300130204     C                             ACC#CNE  = 0 AND CCR#CNE  = 0 AND
179400121213     C                             CRI#CNE  = 0 AND VCI#CNE  = 0
179500121213     C                   EVAL      @STEP = 'STEP5'
179600121213     C                   LEAVESR
179700121213     C                   ENDIF
179800121213    ***
179900121213     C                   EVAL      TERM_LIF = NO
180000121213     C                   EVAL      TERM_ADD = NO
180100121213     C                   EVAL      TERM_DLF = NO
180200121213     C                   EVAL      TERM_VLF = NO
180300121213     C                   EVAL      TERM_VAD = NO
180400121213     C                   EVAL      TERM_VLT = NO
180500121213     C                   EVAL      TERM_CRI = NO
180600121213     C                   EVAL      TERM_MED = NO
180700121213     C                   EVAL      TERM_DEN = NO
180800121213     C                   EVAL      TERM_RXD = NO
180900121213     C                   EVAL      TERM_VIS = NO
181000121213     C                   EVAL      TERM_LTD = NO
181100121213     C                   EVAL      TERM_STD = NO
181200121213     C                   EVAL      TERM_VCI = NO
181300130204     C                   EVAL      TERM_ACC = NO
181400130204     C                   EVAL      TERM_CCR = NO
181500121213    ***
181600121213     C                   EXSR      $CHKHEM
181700121213    ***
181800121213     C                   EVAL      @STEP = 'STEP7'
181900121213    ***
182000121213     C                   ENDSR
182100121213   S***S
182200121213     C     $STEP7        BEGSR
182300121213    ***
182400121213     C                   IF        LIF#CNE  = 0 AND MED#CNE  = 0 AND
182500121213     C                             ADD#CNE  = 0 AND DEN#CNE  = 0 AND
182600121213     C                             DLF#CNE  = 0 AND RXD#CNE  = 0 AND
182700121213     C                             VLF#CNE  = 0 AND VIS#CNE  = 0 AND
182800121213     C                             VAD#CNE  = 0 AND LTD#CNE  = 0 AND
182900121213     C                             VLT#CNE  = 0 AND STD#CNE  = 0 AND
183000130204     C                             ACC#CNE  = 0 AND CCR#CNE  = 0 AND
183100121213     C                             CRI#CNE  = 0 AND VCI#CNE  = 0
183200121213     C                   EVAL      @STEP = 'STEP5'
183300121213     C                   LEAVESR
183400121213     C                   ENDIF
183500121213    ***
183600121213     C                   EVAL      WRT@TYPE = 'DEPEND'
183700121213    ***
183800121213     C                   EXSR      $FILLDEP
183900121213    ***
184000121213     C                   EXSR      $FILLCOVG
184100121213    ***
184200130211     C                   WRITE     AEBF010
184300121213     C                   ADD       1             #RECCNT
184400121213    ***
184500121213     C                   EVAL      @STEP = 'STEP5'
184600121213    ***
184700121213     C                   ENDSR
184800121213   S***S
184900121213     C     $FILLDEP      BEGSR
185000130204    ***
185100130204     C                   CLEAR                   AEBF010
185200130204    ***
185300130204     C                   EVAL      AEBG = %TRIM(CACID2)
185400130204     C                   EVAL      AESN = %TRIM(CACID1)
185500130204    ***
185600130204     C                   SELECT
185700130204     C                   WHEN      DRELCD = 'RWI' OR DRELCD = 'RHU' OR
185800130204     C                             DRELCD = 'RPA'
185900130204     C                   EVAL      AEEMPCD   = '2'
186000130204     C                   WHEN      DRELCD = 'RSO' OR DRELCD = 'RDA'
186100130204     C                   EVAL      AEEMPCD   = '3'
186200130204     C                   OTHER
186300130204     C     'RELCD ERR'   DSPLY     '*EXT'
186400130204     C                   SETON                                        H1
186500130204     C                   ENDSL
186600130204    ***
186700130204     C                   EVAL      AELNAM    = %TRIM(DLNAME)
186800130204     C                   EVAL      AEFNAM    = %TRIM(DFNAME)
186900130204     C                   EVAL      AEMNAM    = DMI
187000121213    ***
187100130305     C                   IF        DEPSS# <>0
187200130204     C                   EVAL      AESSN     = %EDITC(DEPSS#:'X')
187300130305     C                   ENDIF
187400130204    ***
187500121213     C                   IF        DADDR1 = ADDR1 OR %TRIM(DADDR1) = 'SAME'
187600121213      *
187700130305     C                   IF        %SUBST(ADDR1:1:1) <> 'X'
187800130204     C                   EVAL      AEADR1    = %TRIM(ADDR1)
187900130204     C                   EVAL      AEADR2    = %TRIM(ADDR2)
188000130204     C                   EVAL      AECITY    = %TRIM(CITY)
188100130204     C                   MOVE      *BLANKS       @9                9
188200130204     C                   EVAL      @9 = %EDITC(ZIP:'X')
188300130204     C                   EVAL      AEZIP     = %SUBST(@9:1:5)
188400130204     C                   EVAL      AESTATE   = STATE
188500130305     C                   EVAL      AECNTRY = 'US'
188600130305     C                   ENDIF
188700130305     C                   IF        AREA <> 0
188800130204     C                   EVAL      AEAREA    = %EDITC(AREA:'X')
188900130204     C                   EVAL      AEPHONE   = %EDITC(PHONE:'X')
189000130305     C                   ENDIF
189100130204     C                   ELSE
189200130305     C                   IF        %SUBST(DADDR1:1:1) <> 'X'
189300130204     C                   EVAL      AEADR1    = %TRIM(DADDR1)
189400130204     C                   EVAL      AEADR2    = %TRIM(DADDR2)
189500130204     C                   EVAL      AECITY    = %TRIM(DCITY)
189600130204     C                   MOVE      *BLANKS       @9                9
189700130204     C                   EVAL      @9 = %EDITC(DZIP:'X')
189800130204     C                   EVAL      AEZIP     = %SUBST(@9:1:5)
189900130204     C                   EVAL      AESTATE   = DSTATE
190000130305     C                   EVAL      AECNTRY = 'US'
190100130305     C                   ENDIF
190200130305     C                   IF        DAREA <> 0
190300130204     C                   EVAL      AEAREA    = %EDITC(DAREA:'X')
190400130204     C                   EVAL      AEPHONE   = %EDITC(DPHONE:'X')
190500130305     C                   ENDIF
190600130204     C                   ENDIF
190700130204     **
190800130204     C                   EVAL      AERT = 'ENR'
190900130204     C                   EVAL      AETRMRSN  = *BLANKS
191000130204     C                   EVAL      AEEFFDAT  = %CHAR(#TODAY)
191100130204    ***
191200130204     C                   EVAL      AEGENDER = DSEX
191300130204     C                   EVAL      AEDOB     = %EDITC(DBIRTH:'X')
191400130204    ***
191500130204     C                   EVAL      AEHIREDT  = %EDITC(EMPDT:'X')
191600130211     C                   EVAL      AEENROLL  = %EDITC(MBENRL:'X')
191700121213    ***
191800121213     C                   ENDSR
191900121213   S***S
192000121213     C     *INZSR        BEGSR
192100121213    ***
192200121213     C                   EVAL      #RECCNT = 0
192300121213    ***
192400121213     C     KL#ACCTL      KLIST
192500121213     C                   KFLD                    CARR#CTL
192600121213     C                   KFLD                    KF@TRS
192700121213     C                   KFLD                    KF@SUB
192800121213     C                   KFLD                    KF@ACC
192900121213    ***
193000121213     C     KL#AUX        KLIST
193100121213     C                   KFLD                    KF@TRS
193200121213     C                   KFLD                    KF@SUB
193300121213     C                   KFLD                    KF@ACC
193400121213     C                   KFLD                    KF@SSN
193500121213     C                   KFLD                    KF@SEQ
193600121213    ***
193700121213     C     KL#TSA        KLIST
193800121213     C                   KFLD                    KF@TRS
193900121213     C                   KFLD                    KF@SUB
194000121213     C                   KFLD                    KF@ACC
194100121213    ***
194200121213     C     KL#MPLN       KLIST
194300121213     C                   KFLD                    KF@SSN
194400121213     C                   KFLD                    KF@SEQ
194500121213     C                   KFLD                    KF@TRS
194600121213     C                   KFLD                    KF@SUB
194700121213     C                   KFLD                    KF@ACC
194800121213    ***
194900121213     C     KL#CPLN       KLIST
195000121213     C                   KFLD                    CARR#CTL
195100121213     C                   KFLD                    KF@TRS
195200121213     C                   KFLD                    KF@SUB
195300121213     C                   KFLD                    KF@ACC
195400121213     C                   KFLD                    KF@CCTR
195500121213     C                   KFLD                    KF@PLN
195600121213    ***
195700121213     C     KL#DCV        KLIST
195800121213     C                   KFLD                    KF@SSN
195900121213     C                   KFLD                    KF@SEQ
196000121213    ***
196100121213     C     KL#MTR        KLIST
196200121213     C                   KFLD                    KF@SSN
196300121213     C                   KFLD                    KF@SEQ
196400130211     C                   KFLD                    KF@TRM
196500121213     C                   KFLD                    KF@PLN
196600121213     C                   KFLD                    KF@ENR
196700121213     C                   KFLD                    KF@TRS
196800121213     C                   KFLD                    KF@SUB
196900121213     C                   KFLD                    KF@ACC
197000121213    ***
197100121213     C                   ENDSR
197200121213   S***S
197300121213   S***S
197400121213     C     $CLRSTG       BEGSR
197500130214    ***
197600130214     C                   CLEAR                   DS@AEB
197700130214     C                   EVAL      NDX = 0
197800130214     C                   CLEAR                   AE@@
197900121213    ***
198000121213     C                   EVAL      #CANCEL = 0
198100121213    ***
198200121213     C                   EVAL                    MED#CNE = 0
198300121213     C                   EVAL                    MED#NDX = 0
198400121213     C                   CLEAR                   MED@PLN
198500121213     C                   CLEAR                   MED@ENR
198600121213     C                   CLEAR                   MED@FRM
198700121213     C                   CLEAR                   MED@TRM
198800121213    ***
198900121213     C                   EVAL                    DEN#CNE = 0
199000121213     C                   EVAL                    DEN#NDX = 0
199100121213     C                   CLEAR                   DEN@PLN
199200121213     C                   CLEAR                   DEN@ENR
199300121213     C                   CLEAR                   DEN@FRM
199400121213     C                   CLEAR                   DEN@TRM
199500121213    ***
199600121213     C                   EVAL                    RXD#CNE = 0
199700121213     C                   EVAL                    RXD#NDX = 0
199800121213     C                   CLEAR                   RXD@PLN
199900121213     C                   CLEAR                   RXD@ENR
200000121213     C                   CLEAR                   RXD@FRM
200100121213     C                   CLEAR                   RXD@TRM
200200121213    ***
200300121213     C                   EVAL                    VIS#CNE = 0
200400121213     C                   EVAL                    VIS#NDX = 0
200500121213     C                   CLEAR                   VIS@PLN
200600121213     C                   CLEAR                   VIS@ENR
200700121213     C                   CLEAR                   VIS@FRM
200800121213     C                   CLEAR                   VIS@TRM
200900121213    ***
201000121213     C                   EVAL                    LTD#CNE = 0
201100121213     C                   EVAL                    LTD#NDX = 0
201200121213     C                   CLEAR                   LTD@PLN
201300121213     C                   CLEAR                   LTD@ENR
201400121213     C                   CLEAR                   LTD@VOL
201500121213     C                   CLEAR                   LTD@FRM
201600121213     C                   CLEAR                   LTD@TRM
201700121213    ***
201800121213     C                   EVAL                    STD#CNE = 0
201900121213     C                   EVAL                    STD#NDX = 0
202000121213     C                   CLEAR                   STD@PLN
202100121213     C                   CLEAR                   STD@ENR
202200121213     C                   CLEAR                   STD@VOL
202300121213     C                   CLEAR                   STD@FRM
202400121213     C                   CLEAR                   STD@TRM
202500121213    ***
202600121213     C                   EVAL                    LIF#CNE = 0
202700121213     C                   EVAL                    LIF#NDX = 0
202800121213     C                   CLEAR                   LIF@PLN
202900121213     C                   CLEAR                   LIF@ENR
203000121213     C                   CLEAR                   LIF@VOL
203100121213     C                   CLEAR                   LIF@FRM
203200121213     C                   CLEAR                   LIF@TRM
203300121213    ***
203400121213     C                   EVAL                    ADD#CNE = 0
203500121213     C                   EVAL                    ADD#NDX = 0
203600121213     C                   CLEAR                   ADD@PLN
203700121213     C                   CLEAR                   ADD@ENR
203800121213     C                   CLEAR                   ADD@VOL
203900121213     C                   CLEAR                   ADD@FRM
204000121213     C                   CLEAR                   ADD@TRM
204100121213    ***
204200121213     C                   EVAL                    DLF#CNE = 0
204300121213     C                   EVAL                    DLF#NDX = 0
204400121213     C                   CLEAR                   DLF@PLN
204500121213     C                   CLEAR                   DLF@ENR
204600121213     C                   CLEAR                   DLF@VOL
204700121213     C                   CLEAR                   DLF@FRM
204800121213     C                   CLEAR                   DLF@TRM
204900121213    ***
205000121213     C                   EVAL                    VLF#CNE = 0
205100121213     C                   EVAL                    VLF#NDX = 0
205200121213     C                   CLEAR                   VLF@PLN
205300121213     C                   CLEAR                   VLF@ENR
205400121213     C                   CLEAR                   VLF@VOL
205500121213     C                   CLEAR                   VLF@FRM
205600121213     C                   CLEAR                   VLF@TRM
205700121213    ***
205800121213     C                   EVAL                    VAD#CNE = 0
205900121213     C                   EVAL                    VAD#NDX = 0
206000121213     C                   CLEAR                   VAD@PLN
206100121213     C                   CLEAR                   VAD@ENR
206200121213     C                   CLEAR                   VAD@VOL
206300121213     C                   CLEAR                   VAD@FRM
206400121213     C                   CLEAR                   VAD@TRM
206500121213    ***
206600121213     C                   EVAL                    VLT#CNE = 0
206700121213     C                   EVAL                    VLT#NDX = 0
206800121213     C                   CLEAR                   VLT@PLN
206900121213     C                   CLEAR                   VLT@ENR
207000121213     C                   CLEAR                   VLT@VOL
207100121213     C                   CLEAR                   VLT@FRM
207200121213     C                   CLEAR                   VLT@TRM
207300121213    ***
207400121213     C                   EVAL                    CRI#CNE = 0
207500121213     C                   EVAL                    CRI#NDX = 0
207600121213     C                   CLEAR                   CRI@PLN
207700121213     C                   CLEAR                   CRI@ENR
207800121213     C                   CLEAR                   CRI@VOL
207900121213     C                   CLEAR                   CRI@FRM
208000121213     C                   CLEAR                   CRI@TRM
208100121213    ***
208200121213     C                   EVAL                    VCI#CNE = 0
208300121213     C                   EVAL                    VCI#NDX = 0
208400121213     C                   CLEAR                   VCI@PLN
208500121213     C                   CLEAR                   VCI@ENR
208600121213     C                   CLEAR                   VCI@VOL
208700121213     C                   CLEAR                   VCI@FRM
208800121213     C                   CLEAR                   VCI@TRM
208900121213    ***
209000130205     C                   EVAL                    ACC#CNE = 0
209100130205     C                   EVAL                    ACC#NDX = 0
209200130205     C                   CLEAR                   ACC@PLN
209300130205     C                   CLEAR                   ACC@ENR
209400130205     C                   CLEAR                   ACC@FRM
209500130205     C                   CLEAR                   ACC@TRM
209600130205    ***
209700130205     C                   EVAL                    CCR#CNE = 0
209800130205     C                   EVAL                    CCR#NDX = 0
209900130205     C                   CLEAR                   CCR@PLN
210000130205     C                   CLEAR                   CCR@ENR
210100130205     C                   CLEAR                   CCR@FRM
210200130205     C                   CLEAR                   CCR@TRM
210300130205    ***
210400121213     C                   ENDSR
210500121213   S***S
210600121213     C     $CHKHEM       BEGSR
210700121213    ***
210800121213     C                   IF        MED#CNE > 0 AND MED@TRM(MED#CNE) <> 99999999
210900121213     C                   EXSR      $CHKMED
211000121213     C                   ENDIF
211100121213    ***
211200121213     C                   IF        DEN#CNE > 0 AND DEN@TRM(DEN#CNE) <> 99999999
211300121213     C                   EXSR      $CHKDEN
211400121213     C                   ENDIF
211500121213    ***
211600121213     C                   IF        RXD#CNE > 0 AND RXD@TRM(RXD#CNE) <> 99999999
211700121213     C                   EXSR      $CHKRXD
211800121213     C                   ENDIF
211900121213    ***
212000121213     C                   IF        VIS#CNE > 0 AND VIS@TRM(VIS#CNE) <> 99999999
212100121213     C                   EXSR      $CHKVIS
212200121213     C                   ENDIF
212300121213    ***
212400121213     C                   IF        LTD#CNE > 0 AND LTD@TRM(LTD#CNE) <> 99999999
212500121213     C                   EXSR      $CHKLTD
212600121213     C                   ENDIF
212700121213    ***
212800121213     C                   IF        STD#CNE > 0 AND STD@TRM(STD#CNE) <> 99999999
212900121213     C                   EXSR      $CHKSTD
213000121213     C                   ENDIF
213100121213    ***
213200121213     C                   IF        VCI#CNE > 0 AND VCI@TRM(VCI#CNE) <> 99999999
213300121213     C                   EXSR      $CHKVCI
213400121213     C                   ENDIF
213500121213    ***
213600121213     C                   IF        LIF#CNE > 0 AND LIF@TRM(LIF#CNE) <> 99999999
213700121213     C                   EXSR      $CHKLIF
213800121213     C                   ENDIF
213900121213    ***
214000121213     C                   IF        ADD#CNE > 0 AND ADD@TRM(ADD#CNE) <> 99999999
214100121213     C                   EXSR      $CHKADD
214200121213     C                   ENDIF
214300121213    ***
214400121213     C                   IF        DLF#CNE > 0 AND DLF@TRM(DLF#CNE) <> 99999999
214500121213     C                   EXSR      $CHKDLF
214600121213     C                   ENDIF
214700121213    ***
214800121213     C                   IF        VLF#CNE > 0 AND VLF@TRM(VLF#CNE) <> 99999999
214900121213     C                   EXSR      $CHKVLF
215000121213     C                   ENDIF
215100121213    ***
215200121213     C                   IF        VAD#CNE > 0 AND VAD@TRM(VAD#CNE) <> 99999999
215300121213     C                   EXSR      $CHKVAD
215400121213     C                   ENDIF
215500121213    ***
215600121213     C                   IF        VLT#CNE > 0 AND VLT@TRM(VLT#CNE) <> 99999999
215700121213     C                   EXSR      $CHKVLT
215800121213     C                   ENDIF
215900121213    ***
216000121213     C                   IF        CRI#CNE > 0 AND CRI@TRM(CRI#CNE) <> 99999999
216100121213     C                   EXSR      $CHKCRI
216200121213     C                   ENDIF
216300121213    ***
216400130204     C                   IF        ACC#CNE > 0 AND ACC@TRM(ACC#CNE) <> 99999999
216500130204     C                   EXSR      $CHKACC
216600130204     C                   ENDIF
216700130204    ***
216800130204     C                   IF        CCR#CNE > 0 AND CCR@TRM(CCR#CNE) <> 99999999
216900130204     C                   EXSR      $CHKCCR
217000130204     C                   ENDIF
217100130204    ***
217200121213     C                   ENDSR
217300121213   S***S
217400121213      * CHECK FOR MEDICAL TERMINATION
217500121213    *C     $CHKMED       BEGSR
217600121213    ***
217700121213    *C                   EVAL      TERM_MED = YES
217800130211    *C                   EVAL      KF@TRM = MED@TRM(MED#CNE)
217900121213    *C                   EVAL      KF@PLN = MED@PLN(MED#CNE)
218000121213    *C                   EVAL      KF@ENR = MED@ENR(MED#CNE)
218100121213    ***
218200130204    *C     KL#MTR        CHAIN     AEB004F
218300130204    *C                   IF        %FOUND(AEB004WF)
218400130204     C                   IF        NTCOUNT > 1
218500121213    *C                   EVAL      MED#CNE = 0
218600121213    *C                   EVAL      TERM_MED = NO
218700130204     C                   ELSE
218800130204     C                   ADD       1             NTCOUNT
218900130212     C                   EVAL      NTTRANSD2      = #TODAY
219000130204     C                   UPDATE    AEB004F
219100130204     C                   ENDIF
219200130606     C                   LEAVESR
219300121213    *C                   ENDIF
219400121213    ***
219500121213     C                   EXSR      $WRTERM
219600121213    ***
219700121213    *C                   ENDSR
219800121213   S***S
219900121213    *C     $WRTERM       BEGSR
220000121213    ***
220100130204    *C                   CLEAR                   AEB004F
220200121213     C                   EVAL      NTSSNO         = KF@SSN
220300121213     C                   EVAL      NTDEPNO        = KF@SEQ
220400130211     C                   EVAL      NTTERMDT       = KF@TRM
220500121213     C                   EVAL      NTPLAN         = KF@PLN
220600121213     C                   EVAL      NTCOVTP        = KF@ENR
220700121213     C                   EVAL      NTTRST         = KF@TRS
220800121213     C                   EVAL      NTSUB#         = KF@SUB
220900121213     C                   EVAL      NTACCT         = KF@ACC
221000121213     C                   EVAL      NTTRANSDT      = #TODAY
221100130204     C                   EVAL      NTCOUNT = 1
221200130204     C                   WRITE     AEB004F
221300121213    ***
221400121213    *C                   ENDSR
221500121213   S***S
221600121213      * CHECK FOR DENTAL TERMINATION
221700121213    *C     $CHKDEN       BEGSR
221800121213    ***
221900121213    *C                   EVAL      TERM_DEN = YES
222000130211    *C                   EVAL      KF@TRM = DEN@TRM(DEN#CNE)
222100121213    *C                   EVAL      KF@PLN = DEN@PLN(DEN#CNE)
222200121213    *C                   EVAL      KF@ENR = DEN@ENR(DEN#CNE)
222300121213    ***
222400130204    *C     KL#MTR        CHAIN     AEB004F
222500130204    *C                   IF        %FOUND(AEB004WF)
222600130204     C                   IF        NTCOUNT > 1
222700130204    *C                   EVAL      DEN#CNE = 0
222800130204    *C                   EVAL      TERM_DEN = NO
222900130204     C                   ELSE
223000130204     C                   ADD       1             NTCOUNT
223100130212     C                   EVAL      NTTRANSD2      = #TODAY
223200130204     C                   UPDATE    AEB004F
223300130204     C                   ENDIF
223400130606     C                   LEAVESR
223500121213    *C                   ENDIF
223600121213    ***
223700121213     C                   EXSR      $WRTERM
223800121213    ***
223900121213    *C                   ENDSR
224000121213   S***S
224100121213      * CHECK FOR DRUG TERMINATION
224200121213    *C     $CHKRXD       BEGSR
224300121213    ***
224400121213    *C                   EVAL      TERM_RXD = YES
224500130211    *C                   EVAL      KF@TRM = RXD@TRM(RXD#CNE)
224600121213    *C                   EVAL      KF@PLN = RXD@PLN(RXD#CNE)
224700121213    *C                   EVAL      KF@ENR = RXD@ENR(RXD#CNE)
224800121213    ***
224900130204    *C     KL#MTR        CHAIN     AEB004F
225000130204    *C                   IF        %FOUND(AEB004WF)
225100130204     C                   IF        NTCOUNT > 1
225200130204    *C                   EVAL      RXD#CNE = 0
225300130204    *C                   EVAL      TERM_RXD = NO
225400130204     C                   ELSE
225500130204     C                   ADD       1             NTCOUNT
225600130212     C                   EVAL      NTTRANSD2      = #TODAY
225700130204     C                   UPDATE    AEB004F
225800130204     C                   ENDIF
225900130606     C                   LEAVESR
226000121213    *C                   ENDIF
226100121213    ***
226200121213     C                   EXSR      $WRTERM
226300121213    ***
226400121213    *C                   ENDSR
226500121213   S***S
226600121213      * CHECK FOR VISION TERMINATION
226700121213    *C     $CHKVIS       BEGSR
226800121213    ***
226900121213    *C                   EVAL      TERM_VIS = YES
227000130211    *C                   EVAL      KF@TRM = VIS@TRM(VIS#CNE)
227100121213    *C                   EVAL      KF@PLN = VIS@PLN(VIS#CNE)
227200121213    *C                   EVAL      KF@ENR = VIS@ENR(VIS#CNE)
227300121213    ***
227400130204    *C     KL#MTR        CHAIN     AEB004F
227500130204    *C                   IF        %FOUND(AEB004WF)
227600130204     C                   IF        NTCOUNT > 1
227700130204    *C                   EVAL      VIS#CNE = 0
227800130204    *C                   EVAL      TERM_VIS = NO
227900130204     C                   ELSE
228000130204     C                   ADD       1             NTCOUNT
228100130212     C                   EVAL      NTTRANSD2      = #TODAY
228200130204     C                   UPDATE    AEB004F
228300130204     C                   ENDIF
228400130606     C                   LEAVESR
228500121213    *C                   ENDIF
228600121213    ***
228700121213     C                   EXSR      $WRTERM
228800121213    ***
228900121213    *C                   ENDSR
229000121213   S***S
229100121213      * CHECK FOR LTD TERMINATION
229200121213    *C     $CHKLTD       BEGSR
229300121213    ***
229400121213    *C                   EVAL      TERM_LTD = YES
229500130211    *C                   EVAL      KF@TRM = LTD@TRM(LTD#CNE)
229600121213    *C                   EVAL      KF@PLN = LTD@PLN(LTD#CNE)
229700121213    *C                   EVAL      KF@ENR = LTD@ENR(LTD#CNE)
229800121213    ***
229900130204    *C     KL#MTR        CHAIN     AEB004F
230000130204    *C                   IF        %FOUND(AEB004WF)
230100130204     C                   IF        NTCOUNT > 1
230200130204    *C                   EVAL      LTD#CNE = 0
230300130204    *C                   EVAL      TERM_LTD = NO
230400130204     C                   ELSE
230500130204     C                   ADD       1             NTCOUNT
230600130212     C                   EVAL      NTTRANSD2      = #TODAY
230700130204     C                   UPDATE    AEB004F
230800130204     C                   ENDIF
230900130606     C                   LEAVESR
231000121213    *C                   ENDIF
231100121213    ***
231200121213     C                   EXSR      $WRTERM
231300121213    ***
231400121213    *C                   ENDSR
231500121213   S***S
231600121213      * CHECK FOR STD TERMINATION
231700121213    *C     $CHKSTD       BEGSR
231800121213    ***
231900121213    *C                   EVAL      TERM_STD = YES
232000130211    *C                   EVAL      KF@TRM = STD@TRM(STD#CNE)
232100121213    *C                   EVAL      KF@PLN = STD@PLN(STD#CNE)
232200121213    *C                   EVAL      KF@ENR = STD@ENR(STD#CNE)
232300121213    ***
232400130204    *C     KL#MTR        CHAIN     AEB004F
232500130204    *C                   IF        %FOUND(AEB004WF)
232600130204     C                   IF        NTCOUNT > 1
232700130204    *C                   EVAL      STD#CNE = 0
232800130204    *C                   EVAL      TERM_STD = NO
232900130204     C                   ELSE
233000130204     C                   ADD       1             NTCOUNT
233100130212     C                   EVAL      NTTRANSD2      = #TODAY
233200130204     C                   UPDATE    AEB004F
233300130204     C                   ENDIF
233400130606     C                   LEAVESR
233500121213    *C                   ENDIF
233600121213    ***
233700121213     C                   EXSR      $WRTERM
233800121213    ***
233900121213    *C                   ENDSR
234000121213   S***S
234100121213      * CHECK FOR LIFE TERMINATION
234200121213    *C     $CHKLIF       BEGSR
234300121213    ***
234400121213    *C                   EVAL      TERM_LIF = YES
234500130211    *C                   EVAL      KF@TRM = LIF@TRM(LIF#CNE)
234600121213    *C                   EVAL      KF@PLN = LIF@PLN(LIF#CNE)
234700121213    *C                   EVAL      KF@ENR = LIF@ENR(LIF#CNE)
234800121213    ***
234900130204    *C     KL#MTR        CHAIN     AEB004F
235000130204    *C                   IF        %FOUND(AEB004WF)
235100130204     C                   IF        NTCOUNT > 1
235200130204    *C                   EVAL      LIF#CNE = 0
235300130204    *C                   EVAL      TERM_LIF = NO
235400130204     C                   ELSE
235500130204     C                   ADD       1             NTCOUNT
235600130212     C                   EVAL      NTTRANSD2      = #TODAY
235700130204     C                   UPDATE    AEB004F
235800130204     C                   ENDIF
235900130606     C                   LEAVESR
236000121213    *C                   ENDIF
236100121213    ***
236200121213     C                   EXSR      $WRTERM
236300121213    ***
236400121213    *C                   ENDSR
236500121213   S***S
236600121213      * CHECK FOR AD&D TERMINATION
236700121213    *C     $CHKADD       BEGSR
236800121213    ***
236900121213    *C                   EVAL      TERM_ADD = YES
237000130211    *C                   EVAL      KF@TRM = ADD@TRM(ADD#CNE)
237100121213    *C                   EVAL      KF@PLN = ADD@PLN(ADD#CNE)
237200121213    *C                   EVAL      KF@ENR = ADD@ENR(ADD#CNE)
237300121213    ***
237400130204    *C     KL#MTR        CHAIN     AEB004F
237500130204    *C                   IF        %FOUND(AEB004WF)
237600130204     C                   IF        NTCOUNT > 1
237700130204    *C                   EVAL      ADD#CNE = 0
237800130204    *C                   EVAL      TERM_ADD = NO
237900130204     C                   ELSE
238000130204     C                   ADD       1             NTCOUNT
238100130212     C                   EVAL      NTTRANSD2      = #TODAY
238200130204     C                   UPDATE    AEB004F
238300130204     C                   ENDIF
238400130606     C                   LEAVESR
238500121213    *C                   ENDIF
238600121213    ***
238700121213     C                   EXSR      $WRTERM
238800121213    ***
238900121213    *C                   ENDSR
239000121213   S***S
239100121213      * CHECK FOR DEPENDENT LIFE TERMINATION
239200121213    *C     $CHKDLF       BEGSR
239300121213    ***
239400121213    *C                   EVAL      TERM_DLF = YES
239500130211    *C                   EVAL      KF@TRM = DLF@TRM(DLF#CNE)
239600121213    *C                   EVAL      KF@PLN = DLF@PLN(DLF#CNE)
239700121213    *C                   EVAL      KF@ENR = DLF@ENR(DLF#CNE)
239800121213    ***
239900130204    *C     KL#MTR        CHAIN     AEB004F
240000130204    *C                   IF        %FOUND(AEB004WF)
240100130204     C                   IF        NTCOUNT > 1
240200130204    *C                   EVAL      DLF#CNE = 0
240300130204    *C                   EVAL      TERM_DLF = NO
240400130204     C                   ELSE
240500130204     C                   ADD       1             NTCOUNT
240600130212     C                   EVAL      NTTRANSD2      = #TODAY
240700130204     C                   UPDATE    AEB004F
240800130204     C                   ENDIF
240900130606     C                   LEAVESR
241000121213    *C                   ENDIF
241100121213    ***
241200121213     C                   EXSR      $WRTERM
241300121213    ***
241400121213    *C                   ENDSR
241500121213   S***S
241600121213      * CHECK FOR VOLUNATRY LIFE TERMINATION
241700121213    *C     $CHKVLF       BEGSR
241800121213    ***
241900121213    *C                   EVAL      TERM_VLF = YES
242000130211    *C                   EVAL      KF@TRM = VLF@TRM(VLF#CNE)
242100121213    *C                   EVAL      KF@PLN = VLF@PLN(VLF#CNE)
242200121213    *C                   EVAL      KF@ENR = VLF@ENR(VLF#CNE)
242300121213    ***
242400130204    *C     KL#MTR        CHAIN     AEB004F
242500130204    *C                   IF        %FOUND(AEB004WF)
242600130204     C                   IF        NTCOUNT > 1
242700130204    *C                   EVAL      VLF#CNE = 0
242800130204    *C                   EVAL      TERM_VLF = NO
242900130204     C                   ELSE
243000130204     C                   ADD       1             NTCOUNT
243100130212     C                   EVAL      NTTRANSD2      = #TODAY
243200130204     C                   UPDATE    AEB004F
243300130204     C                   ENDIF
243400130606     C                   LEAVESR
243500121213    *C                   ENDIF
243600121213    ***
243700121213     C                   EXSR      $WRTERM
243800121213    ***
243900121213    *C                   ENDSR
244000121213   S***S
244100121213      * CHECK FOR VOLUNATRY AD&D TERMINATION
244200121213    *C     $CHKVAD       BEGSR
244300121213    ***
244400121213    *C                   EVAL      TERM_VAD = YES
244500130211    *C                   EVAL      KF@TRM = VAD@TRM(VAD#CNE)
244600121213    *C                   EVAL      KF@PLN = VAD@PLN(VAD#CNE)
244700121213    *C                   EVAL      KF@ENR = VAD@ENR(VAD#CNE)
244800121213    ***
244900130204    *C     KL#MTR        CHAIN     AEB004F
245000130204    *C                   IF        %FOUND(AEB004WF)
245100130204     C                   IF        NTCOUNT > 1
245200130204    *C                   EVAL      VAD#CNE = 0
245300130204    *C                   EVAL      TERM_VAD = NO
245400130204     C                   ELSE
245500130204     C                   ADD       1             NTCOUNT
245600130212     C                   EVAL      NTTRANSD2      = #TODAY
245700130204     C                   UPDATE    AEB004F
245800130204     C                   ENDIF
245900130606     C                   LEAVESR
246000121213    *C                   ENDIF
246100121213    ***
246200121213     C                   EXSR      $WRTERM
246300121213    ***
246400121213    *C                   ENDSR
246500121213   S***S
246600121213      * CHECK FOR VOLUNATRY LTD TERMINATION
246700121213    *C     $CHKVLT       BEGSR
246800121213    ***
246900121213    *C                   EVAL      TERM_VLT = YES
247000130211    *C                   EVAL      KF@TRM = VLT@TRM(VLT#CNE)
247100121213    *C                   EVAL      KF@PLN = VLT@PLN(VLT#CNE)
247200121213    *C                   EVAL      KF@ENR = VLT@ENR(VLT#CNE)
247300121213    ***
247400130204    *C     KL#MTR        CHAIN     AEB004F
247500130204    *C                   IF        %FOUND(AEB004WF)
247600130204     C                   IF        NTCOUNT > 1
247700130204    *C                   EVAL      VLT#CNE = 0
247800130204    *C                   EVAL      TERM_VLT = NO
247900130204     C                   ELSE
248000130204     C                   ADD       1             NTCOUNT
248100130212     C                   EVAL      NTTRANSD2      = #TODAY
248200130204     C                   UPDATE    AEB004F
248300130204     C                   ENDIF
248400130606     C                   LEAVESR
248500121213    *C                   ENDIF
248600121213    ***
248700121213     C                   EXSR      $WRTERM
248800121213    ***
248900121213    *C                   ENDSR
249000121213   S***S
249100121213      * CHECK FOR CRITICAL ILLNESS TERMINATION
249200121213    *C     $CHKCRI       BEGSR
249300121213    ***
249400121213    *C                   EVAL      TERM_CRI = YES
249500130211    *C                   EVAL      KF@TRM = CRI@TRM(CRI#CNE)
249600121213    *C                   EVAL      KF@PLN = CRI@PLN(CRI#CNE)
249700121213    *C                   EVAL      KF@ENR = CRI@ENR(CRI#CNE)
249800121213    ***
249900130204    *C     KL#MTR        CHAIN     AEB004F
250000130204    *C                   IF        %FOUND(AEB004WF)
250100130204     C                   IF        NTCOUNT > 1
250200130204    *C                   EVAL      CRI#CNE = 0
250300130204    *C                   EVAL      TERM_CRI = NO
250400130204     C                   ELSE
250500130204     C                   ADD       1             NTCOUNT
250600130212     C                   EVAL      NTTRANSD2      = #TODAY
250700130204     C                   UPDATE    AEB004F
250800130204     C                   ENDIF
250900130606     C                   LEAVESR
251000121213    *C                   ENDIF
251100121213    ***
251200121213     C                   EXSR      $WRTERM
251300121213    ***
251400121213    *C                   ENDSR
251500121213   S***S
251600121213      * CHECK FOR VOLUNATRY CRITICAL ILLNESS TERMINATION
251700121213    *C     $CHKVCI       BEGSR
251800121213    ***
251900121213    *C                   EVAL      TERM_VCI = YES
252000130211    *C                   EVAL      KF@TRM = VCI@TRM(VCI#CNE)
252100121213    *C                   EVAL      KF@PLN = VCI@PLN(VCI#CNE)
252200121213    *C                   EVAL      KF@ENR = VCI@ENR(VCI#CNE)
252300121213    ***
252400130204    *C     KL#MTR        CHAIN     AEB004F
252500130204    *C                   IF        %FOUND(AEB004WF)
252600130204     C                   IF        NTCOUNT > 1
252700130204    *C                   EVAL      VCI#CNE = 0
252800130204    *C                   EVAL      TERM_VCI = NO
252900130204     C                   ELSE
253000130204     C                   ADD       1             NTCOUNT
253100130212     C                   EVAL      NTTRANSD2      = #TODAY
253200130204     C                   UPDATE    AEB004F
253300130204     C                   ENDIF
253400130606     C                   LEAVESR
253500121213    *C                   ENDIF
253600121213    ***
253700121213     C                   EXSR      $WRTERM
253800121213    ***
253900121213    *C                   ENDSR
254000121213   S***S
254100130204      * CHECK FOR ACCIDENT COVERAGE TERMINATION
254200130204    *C     $CHKACC       BEGSR
254300130204    ***
254400130204    *C                   EVAL      TERM_ACC = YES
254500130211    *C                   EVAL      KF@TRM = ACC@TRM(ACC#CNE)
254600130204    *C                   EVAL      KF@PLN = ACC@PLN(ACC#CNE)
254700130204    *C                   EVAL      KF@ENR = ACC@ENR(ACC#CNE)
254800130204    ***
254900130204    *C     KL#MTR        CHAIN     AEB004F
255000130204    *C                   IF        %FOUND(AEB004WF)
255100130204     C                   IF        NTCOUNT > 1
255200130204    *C                   EVAL      ACC#CNE = 0
255300130204    *C                   EVAL      TERM_ACC = NO
255400130204     C                   ELSE
255500130204     C                   ADD       1             NTCOUNT
255600130212     C                   EVAL      NTTRANSD2      = #TODAY
255700130204     C                   UPDATE    AEB004F
255800130204     C                   ENDIF
255900130606     C                   LEAVESR
256000130204    *C                   ENDIF
256100130204    ***
256200130204     C                   EXSR      $WRTERM
256300130204    ***
256400130204    *C                   ENDSR
256500130204   S***S
256600130204      * CHECK FOR CANCER COVERAGE TERMINATION
256700130204    *C     $CHKCCR       BEGSR
256800130204    ***
256900130204    *C                   EVAL      TERM_CCR = YES
257000130211    *C                   EVAL      KF@TRM = CCR@TRM(CCR#CNE)
257100130204    *C                   EVAL      KF@PLN = CCR@PLN(CCR#CNE)
257200130204    *C                   EVAL      KF@ENR = CCR@ENR(CCR#CNE)
257300130204    ***
257400130204    *C     KL#MTR        CHAIN     AEB004F
257500130204    *C                   IF        %FOUND(AEB004WF)
257600130204     C                   IF        NTCOUNT > 1
257700130204    *C                   EVAL      CCR#CNE = 0
257800130204    *C                   EVAL      TERM_CCR = NO
257900130204     C                   ELSE
258000130204     C                   ADD       1             NTCOUNT
258100130212     C                   EVAL      NTTRANSD2      = #TODAY
258200130204     C                   UPDATE    AEB004F
258300130204     C                   ENDIF
258400130606     C                   LEAVESR
258500130204    *C                   ENDIF
258600130204    ***
258700130204     C                   EXSR      $WRTERM
258800130204    ***
258900130204    *C                   ENDSR
259000130204   S***S
259100121213     C     $PLANSRCH     BEGSR
259200121213    ***
259300121213     C                   MOVE      *BLANKS       PLN@CAT          10
259400121213     C                   EVAL      PP# = 0
259500121213     C                   CLEAR                   DS@CARPLN
259600121213    ***
259700121213     C                   DO        PC#
259800121213    * *
259900121213     C                   ADD       1             PP#
260000121213     C     PP#           OCCUR     CARPLN@
260100121213    * *
260200121213     C                   IF        XPPLAN = @PLANIN AND
260300121213     C                             XPCCTR = @CCTRIN
260400121213     C                   EVAL      DS@CARPLN = CARPLN@
260500130211     C                   EVAL      PLN@CAT = %TRIM(XPCID3)
260600121213     C                   LEAVE
260700121213     C                   ENDIF
260800121213    * *
260900121213     C                   ENDDO
261000130517    ***
261100130517     C                   IF        PLN@CAT <> 'DEN'
261200130517     C                   EVAL      PLN@CAT = *BLANKS
261300130517     C                   ENDIF
261400121213    ***
261500121213     C                   ENDSR
261600130205   S***S
