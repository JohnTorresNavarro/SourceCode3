000100130307   X***X CARRIER CONTROL ID #0000000077 ASSURANT SPECIFIC
000200121213   X***X SSK 12.13.2012 TEMPLATE DESIGN
000300130103   X***X THIS WAS BASED ON THE GUARDIAN DESIGN AND MODIFIED FROM THERE.
000400130103   X***X
000500121213   X***X
000600130307   X***X 03.07.2013 CLONED FROM AEB0X0R
000700121213   X***X MM.DD.YYYY AETNA APPROVED FOR PRODUCTION
000800121213   X***X
000900121213   X***X
001000121213   X***X ACCOUNTS SET-UP
001100130307   X***X 905-001-0447  MARYLAND MATERIALS
001200130307   X***X 905-001-0448  MARDEL TRUCKING
001300121213   X***X
001400121213   X***X
001500130313   X***X CARELGP WILL ONLY BE ACCESSED AT THE MEMBER LEVEL AND NOT INDIVIDUAL
001600130313   X***X   DEPENDENT LEVEL.
001700121213   X***X
001800130313   X***X SPOUSES ARE NOT TO BE SENT WHEN ENROLLED IN VOL SPOUSE PLAN.
001900121213   X***X
002000121213   X***X
002100121213   X***X
002200121213     FCARXPTP   IF   E           K DISK
002300121213     FCARACCP   IF   E           K DISK
002400121213     FCARPLNP   IF   E           K DISK
002500130313     FCARELGP   IF   E           K DISK
002600121213   X***X
002700121213     FAEB001WF  O  A E             DISK
002800121213     ** EXPORT FILE
002900130211     FAEB004WF  UF A E           K DISK
003000121213     ** TERM TRACKER
003100121213     **
003200121213     FMEMAC#1   IF   E           K DISK
003300121213     FMCOVMPLN  IF   E           K DISK
003400121213     FDEPNDC    IF   E           K DISK
003500121213     FELIGDCOV  IF   E           K DISK
003600130313     FT100      O  A F  200        DISK
003700121213   X***X
003800130307     D CARR#CTL        S             10A   INZ('0000000077')
003900121213   X***X
004000121213     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
004100121213     D DS@CARACC     E DS                  EXTNAME(CARACCP)
004200121213     D DS@CARXPT     E DS                  EXTNAME(CARXPTP)
004300130313     D DS@CARELG     E DS                  EXTNAME(CARELGP)
004400121213   X***X
004500121213     ** WORK ARRAY FOR PLANS
004600121213     **
004700121213     ** PC# - PLAN COUNT
004800121213     ** PP# - PLAN POINTER
004900121213     **
005000121213     D CARPLN@       E DS                  EXTNAME(CARPLNP)
005100121213     D                                     OCCURS(50) PREFIX(X:1)
005200130211     **
005300121213     D PC#             S              3S 0
005400121213     D PP#             S              3S 0
005500130211     **
005600121213     D @PLANIN         S              4A
005700121213     D #EFFDTE         S              8S 0
005800121213     D #BENAMT         S                   LIKE(BENAMT)
005900121213     D @CCTRIN         S              3A
006000121213     D @ENRIN          S              3A
006100121213     D @ENROU          S              3A
006200121214   X***X
006300121213     **
006400121213     ** WRITE TYPE = MEMBER OR DEPEND
006500121213     D WRT@TYPE        S              6A
006600121213     **
006700121213   X***X
006800130211     D #CANCEL         S              8S 0
006900121213     D #DATE           S              8S 0
007000130320     D #SIGN           S               D   DATFMT(*ISO)
007100130211     D #ISO            S               D   DATFMT(*ISO)
007200130211     D #RECCNT         S             10S 0 INZ
007300130211     D #TODAY          S              8S 0
007400130211     D #XSX            S              8S 0
007500130211     D #15S0           S             15S 0
007600130211     D #7S0            S              7S 0
007700130211     **
007800130103     D MBR_TERM        S               N
007900121213     D TERM_MED        S               N
008000121213     D TERM_DEN        S               N
008100121213     D TERM_RXD        S               N
008200121213     D TERM_VIS        S               N
008300121213     D TERM_LIF        S               N
008400121213     D TERM_ADD        S               N
008500121213     D TERM_DLF        S               N
008600121213     D TERM_VLF        S               N
008700121213     D TERM_VAD        S               N
008800121213     D TERM_VLT        S               N
008900121213     D TERM_CRI        S               N
009000121213     D TERM_LTD        S               N
009100121213     D TERM_STD        S               N
009200121213     D TERM_VCI        S               N
009300130102     D TERM_ACC        S               N
009400130102     D TERM_CCR        S               N
009500121213     D YES             S               N   INZ(*ON)
009600121213     D NO              S               N   INZ(*OFF)
009700130211     **
009800130211     D KF@ACC          S                   LIKE(ACC#)
009900130211     D KF@CARG         S              2A   INZ
010000130211     D KF@CCTR         S                   LIKE(CCFLG)
010100130211     D KF@CDE          S              2A
010200130211     D KF@ENR          S              3A   INZ
010300130211     D KF@PLN          S                   LIKE(MCPLAN)
010400130211     D KF@SEQ          S                   LIKE(DPSEQ#)
010500130211     D KF@SSN          S                   LIKE(MBSSNO)
010600121213     D KF@SUB          S                   LIKE(MCSUB#)
010700130211     D KF@TRM          S              8S 0
010800130211     D KF@TRS          S                   LIKE(MCTRST)
010900130211     D KF@TYP          S              1A
011000130211     **
011100121213    ***
011200121213    *** MEDICAL ARRAYS
011300121213    *** CAT: PMM, PDM, PSM
011400121213     D MED#CNE         S              3S 0 INZ
011500121213     D MED#NDX         S              3S 0 INZ
011600121213     D MED@PLN         S              4A   DIM(20)
011700121213     D MED@ENR         S              3A   DIM(20)
011800121213     D MED@FRM         S              8S 0 DIM(20)
011900121213     D MED@TRM         S              8S 0 DIM(20)
012000121213     D MED@MEFF        S              8S 0
012100121213     D MED@MTRM        S              8S 0
012200121213    ***
012300121213    *** DENTAL ARRAYS
012400121213    *** CAT: PDN, PDE, PDR
012500121213     D DEN#CNE         S              3S 0 INZ
012600121213     D DEN#NDX         S              3S 0 INZ
012700121213     D DEN@PLN         S              4A   DIM(20)
012800121213     D DEN@ENR         S              3A   DIM(20)
012900121213     D DEN@FRM         S              8S 0 DIM(20)
013000121213     D DEN@TRM         S              8S 0 DIM(20)
013100121213     D DEN@MEFF        S              8S 0
013200121213     D DEN@MTRM        S              8S 0
013300121213    ***
013400121213    *** PRESCRIPTION DRUG ARRAYS
013500121213    *** CAT: PRX
013600121213     D RXD#CNE         S              3S 0 INZ
013700121213     D RXD#NDX         S              3S 0 INZ
013800121213     D RXD@PLN         S              4A   DIM(20)
013900121213     D RXD@ENR         S              3A   DIM(20)
014000121213     D RXD@FRM         S              8S 0 DIM(20)
014100121213     D RXD@TRM         S              8S 0 DIM(20)
014200121213     D RXD@MEFF        S              8S 0
014300121213     D RXD@MTRM        S              8S 0
014400121213    ***
014500121213    *** VISION         ARRAYS
014600121213    *** CAT: PVS, PVR
014700121213     D VIS#CNE         S              3S 0 INZ
014800121213     D VIS#NDX         S              3S 0 INZ
014900121213     D VIS@PLN         S              4A   DIM(20)
015000121213     D VIS@ENR         S              3A   DIM(20)
015100121213     D VIS@FRM         S              8S 0 DIM(20)
015200121213     D VIS@TRM         S              8S 0 DIM(20)
015300121213     D VIS@MEFF        S              8S 0
015400121213     D VIS@MTRM        S              8S 0
015500121213    ***
015600121213    *** LONG TERM DISABILITY ARRAYS - MEMBER ONLY
015700121213    *** CAT: PLT
015800121213     D LTD#CNE         S              3S 0 INZ
015900121213     D LTD#NDX         S              3S 0 INZ
016000121213     D LTD@PLN         S              4A   DIM(20)
016100121213     D LTD@ENR         S              3A   DIM(20)
016200121213     D LTD@VOL         S              7S 0 DIM(20)
016300121213     D LTD@FRM         S              8S 0 DIM(20)
016400121213     D LTD@TRM         S              8S 0 DIM(20)
016500121213     D LTD@MEFF        S              8S 0
016600121213     D LTD@MTRM        S              8S 0
016700121213    ***
016800121213    *** SHORT TERM DISABILITY ARRAYS  MEMBER ONLY
016900121213    *** CAT: PWD
017000121213     D STD#CNE         S              3S 0 INZ
017100121213     D STD#NDX         S              3S 0 INZ
017200121213     D STD@PLN         S              4A   DIM(20)
017300121213     D STD@ENR         S              3A   DIM(20)
017400121213     D STD@VOL         S              7S 0 DIM(20)
017500121213     D STD@FRM         S              8S 0 DIM(20)
017600121213     D STD@TRM         S              8S 0 DIM(20)
017700121213     D STD@MEFF        S              8S 0
017800121213     D STD@MTRM        S              8S 0
017900121213    ***
018000121213    *** BASIC LIFE ARRAYS
018100121213    *** CAT: PLF
018200121213     D LIF#CNE         S              3S 0 INZ
018300121213     D LIF#NDX         S              3S 0 INZ
018400121213     D LIF@PLN         S              4A   DIM(20)
018500121213     D LIF@ENR         S              3A   DIM(20)
018600121213     D LIF@VOL         S              7S 0 DIM(20)
018700121213     D LIF@FRM         S              8S 0 DIM(20)
018800121213     D LIF@TRM         S              8S 0 DIM(20)
018900121213     D LIF@MEFF        S              8S 0
019000121213     D LIF@MTRM        S              8S 0
019100121213    ***
019200121213    *** ACCIDENTAL DEATH AND DISMEMBERMENT ARRAYS MEMBER ONLY
019300121213    *** CAT: PAC, PA1
019400121213     D ADD#CNE         S              3S 0 INZ
019500121213     D ADD#NDX         S              3S 0 INZ
019600121213     D ADD@PLN         S              4A   DIM(20)
019700121213     D ADD@ENR         S              3A   DIM(20)
019800121213     D ADD@VOL         S              7S 0 DIM(20)
019900121213     D ADD@FRM         S              8S 0 DIM(20)
020000121213     D ADD@TRM         S              8S 0 DIM(20)
020100121213     D ADD@MEFF        S              8S 0
020200121213     D ADD@MTRM        S              8S 0
020300121213    ***
020400121213    *** DEPENDENT BASIC LIFE ARRAYS   DEPENDENTS ONLY
020500121213    *** CAT: PDL
020600121213     D DLF#CNE         S              3S 0 INZ
020700121213     D DLF#NDX         S              3S 0 INZ
020800121213     D DLF@PLN         S              4A   DIM(20)
020900121213     D DLF@ENR         S              3A   DIM(20)
021000121213     D DLF@VOL         S              7S 0 DIM(20)
021100121213     D DLF@FRM         S              8S 0 DIM(20)
021200121213     D DLF@TRM         S              8S 0 DIM(20)
021300121213     D DLF@MEFF        S              8S 0
021400121213     D DLF@MTRM        S              8S 0
021500121213    ***
021600121213    *** VOLUNTARY LIFE ARRAYS
021700121213    *** MBR CAT: PLS, PNE, PO4, PO5, PSL, PS4-6
021800121213    *** SPS CAT: PNS, PSP, PSS, PS1-3
021900121213    *** DEP CAT: PD1, PD2, PD3, PSD, PVD
022000121213     D VLF#CNE         S              3S 0 INZ
022100121213     D VLF#NDX         S              3S 0 INZ
022200121213     D VLF@PLN         S              4A   DIM(20)
022300121213     D VLF@ENR         S              3A   DIM(20)
022400121213     D VLF@VOL         S              7S 0 DIM(20)
022500121213     D VLF@FRM         S              8S 0 DIM(20)
022600121213     D VLF@TRM         S              8S 0 DIM(20)
022700121213     D VLF@MEFF        S              8S 0
022800121213     D VLF@MTRM        S              8S 0
022900121213    ***
023000121213    *** VOLUNTARY ACCIDENTAL DEATH AND DISMEMBERMENT ARRAYS
023100121213    *** CAT: PSA, POA, PAA, PS0/7-9
023200121213     D VAD#CNE         S              3S 0 INZ
023300121213     D VAD#NDX         S              3S 0 INZ
023400121213     D VAD@PLN         S              4A   DIM(20)
023500121213     D VAD@ENR         S              3A   DIM(20)
023600121213     D VAD@VOL         S              7S 0 DIM(20)
023700121213     D VAD@FRM         S              8S 0 DIM(20)
023800121213     D VAD@TRM         S              8S 0 DIM(20)
023900121213     D VAD@MEFF        S              8S 0
024000121213     D VAD@MTRM        S              8S 0
024100121213    ***
024200121213    *** VOLUNTARY LONG TERM DISABILITY ARRAYS
024300121213    *** CAT: PVL
024400121213     D VLT#CNE         S              3S 0 INZ
024500121213     D VLT#NDX         S              3S 0 INZ
024600121213     D VLT@PLN         S              4A   DIM(20)
024700121213     D VLT@ENR         S              3A   DIM(20)
024800121213     D VLT@VOL         S              7S 0 DIM(20)
024900121213     D VLT@FRM         S              8S 0 DIM(20)
025000121213     D VLT@TRM         S              8S 0 DIM(20)
025100121213     D VLT@MEFF        S              8S 0
025200121213     D VLT@MTRM        S              8S 0
025300121213    ***
025400121213    *** CRITICAL ILLNESS ARRAYS
025500121213    *** CAT: PCC
025600121213     D CRI#CNE         S              3S 0 INZ
025700121213     D CRI#NDX         S              3S 0 INZ
025800121213     D CRI@PLN         S              4A   DIM(20)
025900121213     D CRI@ENR         S              3A   DIM(20)
026000121213     D CRI@VOL         S              7S 0 DIM(20)
026100121213     D CRI@FRM         S              8S 0 DIM(20)
026200121213     D CRI@TRM         S              8S 0 DIM(20)
026300121213     D CRI@MEFF        S              8S 0
026400121213     D CRI@MTRM        S              8S 0
026500121213    ***
026600121213    *** VOLUNTARY CRITICAL ILLNESS ARRAYS
026700121213    *** CAT: P.. [WE CURRENTLY DO NOT OFFER THIS]
026800121213     D VCI#CNE         S              3S 0 INZ
026900121213     D VCI#NDX         S              3S 0 INZ
027000121213     D VCI@PLN         S              4A   DIM(20)
027100121213     D VCI@ENR         S              3A   DIM(20)
027200121213     D VCI@VOL         S              7S 0 DIM(20)
027300121213     D VCI@FRM         S              8S 0 DIM(20)
027400121213     D VCI@TRM         S              8S 0 DIM(20)
027500121213     D VCI@MEFF        S              8S 0
027600121213     D VCI@MTRM        S              8S 0
027700121213    ***
027800130102    *** ACCIDENT COVERAGE ARRAYS
027900130102    *** CAT: P.. [WE CURRENTLY DO NOT OFFER THIS]
028000130102     D ACC#CNE         S              3S 0 INZ
028100130102     D ACC#NDX         S              3S 0 INZ
028200130102     D ACC@PLN         S              4A   DIM(20)
028300130102     D ACC@ENR         S              3A   DIM(20)
028400130211     D ACC@VOL         S              7S 0 DIM(20)
028500130102     D ACC@FRM         S              8S 0 DIM(20)
028600130102     D ACC@TRM         S              8S 0 DIM(20)
028700130102     D ACC@MEFF        S              8S 0
028800130102    ***
028900130102    *** CANCER COVERAGE ARRAYS
029000130102    *** CAT: P.. [WE CURRENTLY DO NOT OFFER THIS]
029100130102     D CCR#CNE         S              3S 0 INZ
029200130102     D CCR#NDX         S              3S 0 INZ
029300130102     D CCR@PLN         S              4A   DIM(20)
029400130102     D CCR@ENR         S              3A   DIM(20)
029500130211     D CCR@VOL         S              7S 0 DIM(20)
029600130102     D CCR@FRM         S              8S 0 DIM(20)
029700130102     D CCR@TRM         S              8S 0 DIM(20)
029800130102     D CCR@MEFF        S              8S 0
029900130102    ***
030000130102    ***
030100130320     D DS@AEB        E DS                  EXTNAME(AEB001WF)
030200130320     D  @@AE                0489   1508A   DIM(20)
030300130320     D  NDX            S              3S 0
030400130320    ***
030500130320     D                 DS
030600130320     D AE@@                          51A
030700130320     D AE@@PDT                 1      3A
030800130320     D AE@@COV                 4      6A
030900130320     D AE@@TYP                 7      7A
031000130320     D AE@@BAC                08     10A
031100130320     D AE@@AED                11     18A
031200130320     D AE@@VOL                19     33A
031300130320     D AE@@DT                 34     34A
031400130320     D AE@@MDTE               35     42A
031500130320     D AE@@DTS                43     43A
031600130320     D AE@@SDTE               44     51A
031700130102    ***
031800121213     D @STEP           S              5A
031900121213   X***X
032000121213     C                   EVAL      @STEP = 'PREP0'
032100121213    ***
032200121213     C                   DOU       @STEP = 'LEAVE'
032300121213     C     @STEP         CASEQ     'PREP0'       $PREP0
032400121213     C     @STEP         CASEQ     'STEP0'       $STEP0
032500121213     C     @STEP         CASEQ     'PREP1'       $PREP1
032600121213     C     @STEP         CASEQ     'STEP1'       $STEP1
032700121213     C     @STEP         CASEQ     'STEP2'       $STEP2
032800121213     C     @STEP         CASEQ     'STEP3'       $STEP3
032900121213     C     @STEP         CASEQ     'PREP4'       $PREP4
033000121213     C     @STEP         CASEQ     'STEP4'       $STEP4
033100121213     C     @STEP         CASEQ     'PREP5'       $PREP5
033200121213     C     @STEP         CASEQ     'STEP5'       $STEP5
033300121213     C     @STEP         CASEQ     'STEP6'       $STEP6
033400121213     C     @STEP         CASEQ     'PREP7'       $PREP7
033500121213     C     @STEP         CASEQ     'STEP7'       $STEP7
033600121213     C                   ENDCS
033700121213     C                   ENDDO
033800121213    ***
033900121213     C                   EVAL      *INLR = *ON
034000121213   S***S
034100121213     C     $PREP0        BEGSR
034200121213    ***
034300121213     C     CARR#CTL      CHAIN     CARXPTR
034400121213    ***
034500121213     C     CARR#CTL      SETLL     CARACCR
034600121213    ***
034700121213     C                   EVAL      #ISO = %DATE
034800130103     C                   MOVE      #ISO          #TODAY
034900121213    ***
035000121213     C                   EVAL      @STEP = 'STEP0'
035100121213    ***
035200121213     C                   ENDSR
035300121213   S***S
035400121213     C     $STEP0        BEGSR
035500121213    ***
035600121213     C     CARR#CTL      READE     CARACCR
035700121213    ***
035800121213     C                   IF        %EOF(CARACCP)
035900121213     C                   EVAL      @STEP = 'LEAVE'
036000121213     C                   LEAVESR
036100121213     C                   ENDIF
036200121213    ***
036300121213    *** CAN THE ACCOUNT BE EXPORTED?
036400121213    ***
036500121213     C                   IF        CASTATUS = 'N'
036600121213     C                   LEAVESR
036700121213     C                   ENDIF
036800121213    ***
036900121213     C                   EVAL      @STEP = 'PREP1'
037000121213    ***
037100121213     C                   ENDSR
037200121213   S***S
037300121213     C     $PREP1        BEGSR
037400121213    ***
037500121213     C                   EVAL      KF@TRS = CATRST
037600121213     C                   EVAL      KF@SUB = CASUB#
037700121213     C                   EVAL      KF@ACC = CAACCT
037800121213    ***
037900121213     C                   EXSR      $PLANLOAD
038000121213    ***
038100121213     C                   EVAL      #RECCNT = 0
038200121213    ***
038300121213     C                   EVAL      @STEP = 'STEP1'
038400121213    ***
038500121213     C                   ENDSR
038600121214   S***S
038700121214    *** PLANS LOADED BY ACCOUNT
038800121214    ***
038900121214     C     $PLANLOAD     BEGSR
039000121214    ***
039100121214     C                   EVAL      PP# = 0
039200121214     C                   DO        50
039300121214     C                   ADD       1             PP#
039400121214     C     PP#           OCCUR     CARPLN@
039500121214     C                   CLEAR                   CARPLN@
039600121214     C                   ENDDO
039700121214     C                   EVAL      PC# = 0
039800121214     C                   EVAL      PP# = 0
039900121214    ***
040000121214     C     KL#ACCTL      SETLL     CARPLNR
040100121214     C                   DOU       %EOF(CARPLNP)
040200121214     C     KL#ACCTL      READE     CARPLNR
040300121214     C                   IF        NOT %EOF(CARPLNP)
040400121214    ***
040500121214     C                   ADD       1             PC#
040600121214     C     PC#           OCCUR     CARPLN@
040700121214     C                   EVAL      CARPLN@ = DS@CARPLN
040800121214    ***
040900121214     C                   ENDIF
041000121214     C                   ENDDO
041100121214    ***
041200121214     C                   ENDSR
041300121213   S***S
041400121213     C     $STEP1        BEGSR
041500121213    ***
041600121213     C                   EVAL      KF@PLN = *BLANKS
041700130211     C                   EVAL      KF@TRM = 0
041800121213     C                   EVAL      KF@SSN = 0
041900121213     C                   EVAL      KF@SEQ = 0
042000121213    ***
042100121213     C     KL#TSA        SETLL     MEMBR
042200121213    ***
042300121213     C                   EVAL      @STEP = 'STEP2'
042400121213    ***
042500121213     C                   ENDSR
042600121213   S***S
042700121213     C     $STEP2        BEGSR
042800121213    ***
042900121213     C     KL#TSA        READE     MEMBR
043000121213    ***
043100121213     C                   IF        %EOF(MEMAC#1)
043200121213     C                   EVAL      @STEP = 'STEP0'
043300130208     C                   LEAVESR
043400130208     C                   ENDIF
043500121213    ***
043600121213     C                   EVAL      KF@SSN = MBSSNO
043700121213     C                   MOVE      *ZEROS        KF@SEQ
043800130103    ***
043900130313     C                   IF        CAACCT = 0448
044000130313     C                   CLEAR                   DS@CARELG
044100130313     C                   ELSE
044200130313     C     KL#QMBR       CHAIN     CARELGR
044300130313     C                   IF        NOT %FOUND(CARELGP)
044400130313     C                   MOVEL(P)  MLNAME        REPRT           100
044500130313     C                   EVAL      REPRT = %TRIM(REPRT) + ':' +
044600130313     C                              %EDITC(MBSSNO:'X')
044700130313     C                   EXCEPT    OUTF
044800130313     C                   LEAVESR
044900130313     C                   ENDIF
045000130313     C                   ENDIF
045100130313    ***
045200130313     C                   IF        CECID1 = 'SKIP'
045300130313     C                   LEAVESR
045400130313     C                   ENDIF
045500130313    ***
045600130103     C                   IF        TERMDT > 0
045700130103     C                   EVAL      MBR_TERM = YES
045800130103     C                   ELSE
045900130103     C                   EVAL      MBR_TERM = NO
046000130103     C                   ENDIF
046100121213    ***
046200121213     C     KL#MPLN       SETLL     MCOVR
046300121213    ***
046400121213     C                   EXSR      $CLRSTG
046500121213    ***
046600121213     C                   EVAL      @STEP = 'STEP3'
046700121213    ***
046800121213     C                   ENDSR
046900121213   S***S
047000121213     C     $STEP3        BEGSR
047100121213    ***
047200121213     C     KL#MPLN       READE     MCOVR
047300121213    ***
047400121213     C                   IF        %EOF(MCOVMPLN)
047500121213     C                   EVAL      @STEP = 'PREP4'
047600121213     C                   LEAVESR
047700121213     C                   ENDIF
047800121213    ***
047900121213     C                   EVAL      @PLANIN = MCPLAN
048000121213     C                   EVAL      #EFFDTE = ENRLDT
048100121213     C                   EVAL      #BENAMT = BENAMT
048200130227     C                   EVAL      #CANCEL = CANDT
048300121213     **
048400121213     C                   EXSR      $QUIK
048500121213     **
048600121213     C                   EXSR      $PLANSRCH
048700121213    ***
048800121213     C                   IF        PLN@CAT = *BLANKS
048900121213     C                   LEAVESR
049000121213     C                   ENDIF
049100130204    ***
049200130204     C                   EVAL      @ENRIN = MCOVTP
049300130204     C                   EXSR      $TIERLVL
049400130227    ***
049500130227     C                   IF        #CANCEL = 0
049600130227     C                   EVAL      #CANCEL = 99999999
049700130227     C                   ENDIF
049800121213    ***
049900121213     C                   EXSR      $AD2MARY
050000121213    ***
050100121213     C                   ENDSR
050200130103   S***S
050300130103     C     $QUIK         BEGSR
050400130103    ***
050500130103     C                   EVAL      @CCTRIN = *BLANKS
050600130204    ***
050700130204     C                   IF        CACID4 = 'NORULE'
050800130204     C                   LEAVESR
050900130204     C                   ENDIF
051000130103    ***
051100130313     C*****CACID4        CASEQ     'EMPSTS'      $ES
051200130204     C     CACID4        CASEQ     'JOBCLASS'    $JC
051300130204     C                   ENDCS
051400130204    ***
051500130204     C                   ENDSR
051600130204   S***S
051700130204     C     $ES           BEGSR
051800130204    ***
051900130204     C                   IF        EMPST =  'C'
052000130204     C                   EVAL      @CCTRIN = 'COB'
052100130204     C                   ELSE
052200130204     C                   EVAL      @CCTRIN = 'ACT'
052300130204     C                   ENDIF
052400130204    ***
052500130204     C                   ENDSR
052600130204   S***S
052700130204     C     $JC           BEGSR
052800130204    ***
052900130204     C                   SELECT
053000130204     C                   WHEN      EMPST =  'C'
053100130204     C                   EVAL      @CCTRIN = 'COB'
053200130313     C                   WHEN      EMPST = 'A'
053300130313     C                   EVAL      @CCTRIN = CECID1
053400130208     C                   ENDSL
053500130204    ***
053600130204     C                   ENDSR
053700130204   S***S
053800130204     C     $TIERLVL      BEGSR
053900130204    ***
054000130204     C                   SELECT
054100130204      *
054200130211     C                   WHEN      CPCID5 = 'E'
054300130204     C                   EVAL      @ENROU = 'EMP'
054400130204      *
054500130211     C                   WHEN      CPCID5 = 'S'
054600130204     C                   EVAL      @ENROU = 'SPO'
054700130204      *
054800130211     C                   WHEN      CPCID5 = 'C'
054900130204     C                   EVAL      @ENROU = 'CHD'
055000130204      *
055100130211     C                   WHEN      CPCID5 = '2'
055200130204     C                   IF        @ENRIN = 'TIN'
055300130103     C                   EVAL      @ENROU = 'EMP'
055400130204     C                   ELSE
055500130204     C                   EVAL      @ENROU = 'FAM'
055600130204     C                   ENDIF
055700130204      *
055800130211     C                   WHEN      CPCID5 = '4'
055900130204     C                   SELECT
056000130204     C                   WHEN      @ENRIN = 'TIN'
056100130204     C                   EVAL      @ENROU = 'EMP'
056200130103     C                   WHEN      @ENRIN = 'THW'
056300130103     C                   EVAL      @ENROU = 'ESP'
056400130103     C                   WHEN      @ENRIN = 'TPC' OR @ENRIN = 'TP2'
056500130103     C                   EVAL      @ENROU = 'ECH'
056600130103     C                   WHEN      @ENRIN = 'TFA'
056700130103     C                   EVAL      @ENROU = 'FAM'
056800130204     C                   ENDSL
056900130204      *
057000130103     C                   ENDSL
057100130103    ***
057200130103     C                   ENDSR
057300121213   S***S
057400121213     C     $AD2MARY      BEGSR
057500121213    ***
057600121213    *C                   IF        PLN@CAT = 'MM'
057700130204     C                   IF        MED#CNE > 0
057800130204     C                   IF        MED@TRM(MED#CNE) = 99999999
057900130204     C                   LEAVESR
058000130204     C                   ENDIF
058100130204     C                   ENDIF
058200121213    *C                   ADD       1             MED#CNE
058300121213    *C                   EVAL      MED@PLN(MED#CNE) = @PLANIN
058400121213    *C                   EVAL      MED@ENR(MED#CNE) = @ENROU
058500121213    *C                   EVAL      MED@FRM(MED#CNE) = #EFFDTE
058600121213    *C                   EVAL      MED@TRM(MED#CNE) = #CANCEL
058700121213     C                   LEAVESR
058800121213    *C                   ENDIF
058900121213    ***
059000121213    *C                   IF        PLN@CAT = 'DEN'
059100130204     C                   IF        DEN#CNE > 0
059200130204     C                   IF        DEN@TRM(DEN#CNE) = 99999999
059300130204     C                   LEAVESR
059400130204     C                   ENDIF
059500130204     C                   ENDIF
059600121213    *C                   ADD       1             DEN#CNE
059700121213    *C                   EVAL      DEN@PLN(DEN#CNE) = @PLANIN
059800121213    *C                   EVAL      DEN@ENR(DEN#CNE) = @ENROU
059900121213    *C                   EVAL      DEN@FRM(DEN#CNE) = #EFFDTE
060000121213    *C                   EVAL      DEN@TRM(DEN#CNE) = #CANCEL
060100121213     C                   LEAVESR
060200121213    *C                   ENDIF
060300121213    ***
060400121213    *C                   IF        PLN@CAT = 'RX'
060500130204     C                   IF        RXD#CNE > 0
060600130204     C                   IF        RXD@TRM(RXD#CNE) = 99999999
060700130204     C                   LEAVESR
060800130204     C                   ENDIF
060900130204     C                   ENDIF
061000121213    *C                   ADD       1             RXD#CNE
061100121213    *C                   EVAL      RXD@PLN(RXD#CNE) = @PLANIN
061200121213    *C                   EVAL      RXD@ENR(RXD#CNE) = @ENROU
061300121213    *C                   EVAL      RXD@FRM(RXD#CNE) = #EFFDTE
061400121213    *C                   EVAL      RXD@TRM(RXD#CNE) = #CANCEL
061500121213     C                   LEAVESR
061600121213    *C                   ENDIF
061700121213    ***
061800121213    *C                   IF        PLN@CAT = 'VIS'
061900130204     C                   IF        VIS#CNE > 0
062000130204     C                   IF        VIS@TRM(VIS#CNE) = 99999999
062100130204     C                   LEAVESR
062200130204     C                   ENDIF
062300130204     C                   ENDIF
062400121213    *C                   ADD       1             VIS#CNE
062500121213    *C                   EVAL      VIS@PLN(VIS#CNE) = @PLANIN
062600121213    *C                   EVAL      VIS@ENR(VIS#CNE) = @ENROU
062700121213    *C                   EVAL      VIS@FRM(VIS#CNE) = #EFFDTE
062800121213    *C                   EVAL      VIS@TRM(VIS#CNE) = #CANCEL
062900121213     C                   LEAVESR
063000121213    *C                   ENDIF
063100121213    ***
063200121213    *C                   IF        PLN@CAT = 'LTD'
063300130204     C                   IF        LTD#CNE > 0
063400130204     C                   IF        LTD@TRM(LTD#CNE) = 99999999
063500130204     C                   LEAVESR
063600130204     C                   ENDIF
063700130204     C                   ENDIF
063800121213    *C                   ADD       1             LTD#CNE
063900121213    *C                   EVAL      LTD@PLN(LTD#CNE) = @PLANIN
064000121213    *C                   EVAL      LTD@ENR(LTD#CNE) = @ENROU
064100121213     C                   EVAL      LTD@VOL(LTD#CNE) = #BENAMT
064200121213    *C                   EVAL      LTD@FRM(LTD#CNE) = #EFFDTE
064300121213    *C                   EVAL      LTD@TRM(LTD#CNE) = #CANCEL
064400121213     C                   LEAVESR
064500121213    *C                   ENDIF
064600121213    ***
064700121213    *C                   IF        PLN@CAT = 'STD'
064800130204     C                   IF        STD#CNE > 0
064900130204     C                   IF        STD@TRM(STD#CNE) = 99999999
065000130204     C                   LEAVESR
065100130204     C                   ENDIF
065200130204     C                   ENDIF
065300121213    *C                   ADD       1             STD#CNE
065400121213    *C                   EVAL      STD@PLN(STD#CNE) = @PLANIN
065500121213    *C                   EVAL      STD@ENR(STD#CNE) = @ENROU
065600121213     C                   EVAL      STD@VOL(STD#CNE) = #BENAMT
065700121213    *C                   EVAL      STD@FRM(STD#CNE) = #EFFDTE
065800121213    *C                   EVAL      STD@TRM(STD#CNE) = #CANCEL
065900121213     C                   LEAVESR
066000121213    *C                   ENDIF
066100121213    ***
066200130103    *C                   IF        PLN@CAT = 'AC'
066300130204     C                   IF        LIF#CNE > 0
066400130204     C                   IF        LIF@TRM(LIF#CNE) = 99999999
066500130204     C                   LEAVESR
066600130204     C                   ENDIF
066700130204     C                   ENDIF
066800121213    *C                   ADD       1             LIF#CNE
066900121213    *C                   EVAL      LIF@PLN(LIF#CNE) = @PLANIN
067000121213    *C                   EVAL      LIF@ENR(LIF#CNE) = @ENROU
067100121213     C                   EVAL      LIF@VOL(LIF#CNE) = #BENAMT
067200121213    *C                   EVAL      LIF@FRM(LIF#CNE) = #EFFDTE
067300121213    *C                   EVAL      LIF@TRM(LIF#CNE) = #CANCEL
067400121213     C                   LEAVESR
067500121213    *C                   ENDIF
067600121213    ***
067700121213    *C                   IF        PLN@CAT = 'ADD'
067800130204     C                   IF        ADD#CNE > 0
067900130204     C                   IF        ADD@TRM(ADD#CNE) = 99999999
068000130204     C                   LEAVESR
068100130204     C                   ENDIF
068200130204     C                   ENDIF
068300121213    *C                   ADD       1             ADD#CNE
068400121213    *C                   EVAL      ADD@PLN(ADD#CNE) = @PLANIN
068500121213    *C                   EVAL      ADD@ENR(ADD#CNE) = @ENROU
068600121213     C                   EVAL      ADD@VOL(ADD#CNE) = #BENAMT
068700121213    *C                   EVAL      ADD@FRM(ADD#CNE) = #EFFDTE
068800121213    *C                   EVAL      ADD@TRM(ADD#CNE) = #CANCEL
068900121213     C                   LEAVESR
069000121213    *C                   ENDIF
069100121213    ***
069200121213    *C                   IF        PLN@CAT = 'DEPLIF'
069300130204     C                   IF        DLF#CNE > 0
069400130204     C                   IF        DLF@TRM(DLF#CNE) = 99999999
069500130204     C                   LEAVESR
069600130204     C                   ENDIF
069700130204     C                   ENDIF
069800121213    *C                   ADD       1             DLF#CNE
069900121213    *C                   EVAL      DLF@PLN(DLF#CNE) = @PLANIN
070000121213    *C                   EVAL      DLF@ENR(DLF#CNE) = @ENROU
070100121213     C                   EVAL      DLF@VOL(DLF#CNE) = #BENAMT
070200121213    *C                   EVAL      DLF@FRM(DLF#CNE) = #EFFDTE
070300121213    *C                   EVAL      DLF@TRM(DLF#CNE) = #CANCEL
070400121213     C                   LEAVESR
070500121213    *C                   ENDIF
070600121213    ***
070700130103    *C                   IF        PLN@CAT = 'AF'
070800130204     C                   IF        VLF#CNE > 0
070900130204     C                   IF        VLF@TRM(VLF#CNE) = 99999999
071000130204     C                   LEAVESR
071100130204     C                   ENDIF
071200130204     C                   ENDIF
071300121213    *C                   ADD       1             VLF#CNE
071400121213    *C                   EVAL      VLF@PLN(VLF#CNE) = @PLANIN
071500121213    *C                   EVAL      VLF@ENR(VLF#CNE) = @ENROU
071600121213     C                   EVAL      VLF@VOL(VLF#CNE) = #BENAMT
071700121213    *C                   EVAL      VLF@FRM(VLF#CNE) = #EFFDTE
071800121213    *C                   EVAL      VLF@TRM(VLF#CNE) = #CANCEL
071900121213     C                   LEAVESR
072000121213    *C                   ENDIF
072100121213    ***
072200121213    *C                   IF        PLN@CAT = 'VOLADD'
072300130204     C                   IF        VAD#CNE > 0
072400130204     C                   IF        VAD@TRM(VAD#CNE) = 99999999
072500130204     C                   LEAVESR
072600130204     C                   ENDIF
072700130204     C                   ENDIF
072800121213    *C                   ADD       1             VAD#CNE
072900121213    *C                   EVAL      VAD@PLN(VAD#CNE) = @PLANIN
073000121213    *C                   EVAL      VAD@ENR(VAD#CNE) = @ENROU
073100121213     C                   EVAL      VAD@VOL(VAD#CNE) = #BENAMT
073200121213    *C                   EVAL      VAD@FRM(VAD#CNE) = #EFFDTE
073300121213    *C                   EVAL      VAD@TRM(VAD#CNE) = #CANCEL
073400121213     C                   LEAVESR
073500121213    *C                   ENDIF
073600121213    ***
073700121213    *C                   IF        PLN@CAT = 'VOLLTD'
073800130204     C                   IF        VLT#CNE > 0
073900130204     C                   IF        VLT@TRM(VLT#CNE) = 99999999
074000130204     C                   LEAVESR
074100130204     C                   ENDIF
074200130204     C                   ENDIF
074300121213    *C                   ADD       1             VLT#CNE
074400121213    *C                   EVAL      VLT@PLN(VLT#CNE) = @PLANIN
074500121213    *C                   EVAL      VLT@ENR(VLT#CNE) = @ENROU
074600121213     C                   EVAL      VLT@VOL(VLT#CNE) = #BENAMT
074700121213    *C                   EVAL      VLT@FRM(VLT#CNE) = #EFFDTE
074800121213    *C                   EVAL      VLT@TRM(VLT#CNE) = #CANCEL
074900121213     C                   LEAVESR
075000121213    *C                   ENDIF
075100121213    ***
075200121213    *C                   IF        PLN@CAT = 'CRITIL'
075300130204     C                   IF        CRI#CNE > 0
075400130204     C                   IF        CRI@TRM(CRI#CNE) = 99999999
075500130204     C                   LEAVESR
075600130204     C                   ENDIF
075700130204     C                   ENDIF
075800121213    *C                   ADD       1             CRI#CNE
075900121213    *C                   EVAL      CRI@PLN(CRI#CNE) = @PLANIN
076000121213    *C                   EVAL      CRI@ENR(CRI#CNE) = @ENROU
076100121213     C                   EVAL      CRI@VOL(CRI#CNE) = #BENAMT
076200121213    *C                   EVAL      CRI@FRM(CRI#CNE) = #EFFDTE
076300121213    *C                   EVAL      CRI@TRM(CRI#CNE) = #CANCEL
076400121213     C                   LEAVESR
076500121213    *C                   ENDIF
076600121213    ***
076700121213    *C                   IF        PLN@CAT = 'VOLCRIT'
076800130204     C                   IF        VCI#CNE > 0
076900130204     C                   IF        VCI@TRM(VCI#CNE) = 99999999
077000130204     C                   LEAVESR
077100130204     C                   ENDIF
077200130204     C                   ENDIF
077300121213    *C                   ADD       1             VCI#CNE
077400121213    *C                   EVAL      VCI@PLN(VCI#CNE) = @PLANIN
077500121213    *C                   EVAL      VCI@ENR(VCI#CNE) = @ENROU
077600121213     C                   EVAL      VCI@VOL(VCI#CNE) = #BENAMT
077700121213    *C                   EVAL      VCI@FRM(VCI#CNE) = #EFFDTE
077800121213    *C                   EVAL      VCI@TRM(VCI#CNE) = #CANCEL
077900121213     C                   LEAVESR
078000121213    *C                   ENDIF
078100121213    ***
078200130103    *C                   IF        PLN@CAT = 'ACC'
078300130204     C                   IF        ACC#CNE > 0
078400130204     C                   IF        ACC@TRM(ACC#CNE) = 99999999
078500130103     C                   LEAVESR
078600130204     C                   ENDIF
078700130103     C                   ENDIF
078800130103    *C                   ADD       1             ACC#CNE
078900130103    *C                   EVAL      ACC@PLN(ACC#CNE) = @PLANIN
079000130103    *C                   EVAL      ACC@ENR(ACC#CNE) = @ENROU
079100130103    *C                   EVAL      ACC@FRM(ACC#CNE) = #EFFDTE
079200130103    *C                   EVAL      ACC@TRM(ACC#CNE) = #CANCEL
079300130103     C                   LEAVESR
079400130103    *C                   ENDIF
079500130103    ***
079600130103    *C                   IF        PLN@CAT = 'CAN'
079700130204     C                   IF        CCR#CNE > 0
079800130204     C                   IF        CCR@TRM(CCR#CNE) = 99999999
079900130103     C                   LEAVESR
080000130204     C                   ENDIF
080100130103     C                   ENDIF
080200130103    *C                   ADD       1             CCR#CNE
080300130103    *C                   EVAL      CCR@PLN(CCR#CNE) = @PLANIN
080400130103    *C                   EVAL      CCR@ENR(CCR#CNE) = @ENROU
080500130103    *C                   EVAL      CCR@FRM(CCR#CNE) = #EFFDTE
080600130103    *C                   EVAL      CCR@TRM(CCR#CNE) = #CANCEL
080700130103     C                   LEAVESR
080800130103    *C                   ENDIF
080900130103    ***
081000121213     C                   ENDSR
081100121213   S***S
081200121213     C     $PREP4        BEGSR
081300121213    ***
081400121213     C                   IF        LIF#CNE  = 0 AND MED#CNE  = 0 AND
081500121213     C                             ADD#CNE  = 0 AND DEN#CNE  = 0 AND
081600121213     C                             DLF#CNE  = 0 AND RXD#CNE  = 0 AND
081700121213     C                             VLF#CNE  = 0 AND VIS#CNE  = 0 AND
081800121213     C                             VAD#CNE  = 0 AND LTD#CNE  = 0 AND
081900121213     C                             VLT#CNE  = 0 AND STD#CNE  = 0 AND
082000130103     C                             ACC#CNE  = 0 AND CCR#CNE  = 0 AND
082100121213     C                             CRI#CNE  = 0 AND VCI#CNE  = 0
082200121213     C                   EVAL      @STEP = 'STEP2'
082300121213     C                   LEAVESR
082400121213     C                   ENDIF
082500121213    ***
082600121213     C                   EVAL      TERM_LIF = NO
082700121213     C                   EVAL      TERM_ADD = NO
082800121213     C                   EVAL      TERM_DLF = NO
082900121213     C                   EVAL      TERM_VLF = NO
083000121213     C                   EVAL      TERM_VAD = NO
083100121213     C                   EVAL      TERM_VLT = NO
083200121213     C                   EVAL      TERM_CRI = NO
083300121213     C                   EVAL      TERM_MED = NO
083400121213     C                   EVAL      TERM_DEN = NO
083500121213     C                   EVAL      TERM_RXD = NO
083600121213     C                   EVAL      TERM_VIS = NO
083700121213     C                   EVAL      TERM_LTD = NO
083800121213     C                   EVAL      TERM_STD = NO
083900121213     C                   EVAL      TERM_VCI = NO
084000130103     C                   EVAL      TERM_ACC = NO
084100130103     C                   EVAL      TERM_CCR = NO
084200121213    ***
084300121213     C                   EXSR      $CHKHEM
084400121213    ***
084500121213     C                   EVAL      @STEP = 'STEP4'
084600121214    ***
084700121214     C                   ENDSR
084800121213   S***S
084900121213    *** GENERATE MEMBER RECORD
085000121213    ***
085100121213     C     $STEP4        BEGSR
085200121213    ***
085300121213     C                   IF        LIF#CNE  = 0 AND MED#CNE  = 0 AND
085400121213     C                             ADD#CNE  = 0 AND DEN#CNE  = 0 AND
085500121213     C                             DLF#CNE  = 0 AND RXD#CNE  = 0 AND
085600121213     C                             VLF#CNE  = 0 AND VIS#CNE  = 0 AND
085700121213     C                             VAD#CNE  = 0 AND LTD#CNE  = 0 AND
085800121213     C                             VLT#CNE  = 0 AND STD#CNE  = 0 AND
085900130103     C                             ACC#CNE  = 0 AND CCR#CNE  = 0 AND
086000121213     C                             CRI#CNE  = 0 AND VCI#CNE  = 0
086100121213     C                   EVAL      @STEP = 'STEP2'
086200121213     C                   LEAVESR
086300121213     C                   ENDIF
086400121213    ***
086500121213     C                   EVAL      WRT@TYPE = 'MEMBER'
086600121213    ***
086700121213     C                   EVAL      MED@MEFF = 0
086800121213     C                   EVAL      DEN@MEFF = 0
086900121213     C                   EVAL      RXD@MEFF = 0
087000121213     C                   EVAL      VIS@MEFF = 0
087100121213     C                   EVAL      LTD@MEFF = 0
087200121213     C                   EVAL      STD@MEFF = 0
087300121213    ***
087400121213     C                   EVAL      LIF@MEFF = 0
087500121213     C                   EVAL      ADD@MEFF = 0
087600121213     C                   EVAL      DLF@MEFF = 0
087700121213     C                   EVAL      VLF@MEFF = 0
087800121213     C                   EVAL      VAD@MEFF = 0
087900121213     C                   EVAL      VLT@MEFF = 0
088000121213     C                   EVAL      CRI@MEFF = 0
088100121213     C                   EVAL      VCI@MEFF = 0
088200130103     C                   EVAL      ACC@MEFF = 0
088300130103     C                   EVAL      CCR@MEFF = 0
088400121213    ***
088500121213     C                   EXSR      $FILLMBR
088600121213    ***
088700121213     C                   EXSR      $FILLCOVG
088800121213    ***
088900121214     C                   WRITE     AEBF010
089000121213     C                   ADD       1             #RECCNT
089100121213    ***
089200121213     C                   EVAL      @STEP = 'PREP5'
089300121213    ***
089400121213     C                   ENDSR
089500121213   S***S
089600121213     C     $FILLMBR      BEGSR
089700121213    ***
089800121214     C                   CLEAR                   AEBF010
089900121213    ***
090000130103     C                   EVAL      AEBG = %TRIM(CACID2)
090100130103     C                   EVAL      AESN = %TRIM(CACID1)
090200121214     C                   EVAL      AEEMPCD   = '1'
090300130103    ***
090400121214     C                   EVAL      AELNAM    = %TRIM(MLNAME)
090500121214     C                   EVAL      AEFNAM    = %TRIM(MFNAME)
090600121214     C                   EVAL      AEMNAM    = MMI
090700130103     C                   EVAL      AESSN     = %EDITC(MBSSNO:'X')
090800130103    ***
090900130305     C                   IF        %SUBST(ADDR1:1:1) <> 'X'
091000121214     C                   EVAL      AEADR1    = %TRIM(ADDR1)
091100121214     C                   EVAL      AEADR2    = %TRIM(ADDR2)
091200121214     C                   EVAL      AECITY    = %TRIM(CITY)
091300121214     C                   MOVE      *BLANKS       @9                9
091400121214     C                   EVAL      @9 = %EDITC(ZIP:'X')
091500121214     C                   EVAL      AEZIP     = %SUBST(@9:1:5)
091600121214     C                   EVAL      AESTATE   = STATE
091700130305     C                   EVAL      AECNTRY = 'US'
091800130305     C                   ENDIF
091900130305    ***
092000130305     C                   IF        AREA <> 0
092100121214     C                   EVAL      AEAREA    = %EDITC(AREA:'X')
092200121214     C                   EVAL      AEPHONE   = %EDITC(PHONE:'X')
092300130305     C                   ENDIF
092400130103    ***
092500130103     C                   IF        MBR_TERM = YES
092600130103     C                   EVAL      AERT = 'TRM'
092700130103     C                   EVAL      AETRMRSN  = '01'
092800130103     C                   EVAL      AEEFFDAT  = %CHAR(TERMDT)
092900130103     C                   ELSE
093000130103     C                   EVAL      AERT = 'ENR'
093100130103     C                   EVAL      AETRMRSN  = *BLANKS
093200130103     C                   EVAL      AEEFFDAT  = %CHAR(#TODAY)
093300130103     C                   ENDIF
093400130103    ***
093500130227     C                   EVAL      AESAL = *BLANKS
093600130227     C                   EVAL      AESFLG = *BLANKS
093700130227    ***
093800130227     C                   IF        CACID3 = 'Y'
093900130227     C     SALARY        MULT      100           #SAL             15 0
094000130227     C                   EVAL      AESAL     = %EDITC(#SAL:'X')
094100130227     C                   EVAL      AESFLG = '01'
094200130227     C                   ENDIF
094300121213    ***
094400121214     C                   EVAL      AEGENDER  = SEX
094500121214     C                   EVAL      AEDOB     = %EDITC(BIRTH:'X')
094600121214     C                   EVAL      AEHIREDT  = %EDITC(EMPDT:'X')
094700130211     C                   EVAL      AEENROLL  = %EDITC(MBENRL:'X')
094800130103    ***
094900130103     C                   ENDSR
095000121213   S***S
095100121213     C     $FILLCOVG     BEGSR
095200121213    ***
095300130320     C                   IF        MED#CNE > 0
095400130320      * MEDICAL
095500130320    ***
095600130320     C                   EVAL      @PLANIN = MED@PLN(MED#CNE)
095700130320     C                   EXSR      $QUIK
095800130320     C                   EXSR      $PLANSRCH
095900130320     C                   IF        PLN@CAT = *BLANKS
096000130320     C     'MED FAIL'    DSPLY     '*EXT'
096100130320     C                   SETON                                        H1
096200130320     C                   ENDIF
096300130320      *
096400130320     C                   CLEAR                   AE@@
096500130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
096600130320     C                   EVAL      AE@@COV = MED@ENR(MED#CNE)
096700130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
096800130320     C                   EVAL      AEMG = %TRIM(CPCID1)
096900130320      *
097000130320     C                   EVAL      #XSX = MED@FRM(MED#CNE)
097100130320     C                   MOVE      #XSX          #SIGN
097200130320     C                   SUBDUR    1:*D          #SIGN
097300130320     C                   MOVE      #SIGN         #XSX
097400130320     C                   EVAL      AE@@DTS = '1'
097500130320     C                   MOVE      #XSX          AE@@SDTE
097600130320      *
097700130320     C                   EVAL      #CANCEL = MED@TRM(MED#CNE)
097800130320     C                   IF        #CANCEL = 99999999
097900130320     C                   EVAL      AE@@BAC = 'ENR'
098000130320     C                   EVAL      #XSX = MED@FRM(MED#CNE)
098100130320     C                   ELSE
098200130320     C                   EVAL      AE@@BAC = 'TRM'
098300130320     C                   EVAL      #XSX = MED@TRM(MED#CNE)
098400130320     C                   ENDIF
098500130320     C                   MOVE      #XSX          AE@@AED
098600130320      *
098700130320     C*                  EVAL      AE@@VOL = MDE@VOL(MED#CNE)
098800130320     C                   EVAL      AE@@DT = '0'
098900130320     C                   EVAL      #XSX = MED@FRM(MED#CNE)
099000130320     C                   MOVE      #XSX          AE@@MDTE
099100130320     C                   ADD       1             NDX
099200130320     C                   EVAL      @@AE(NDX) = AE@@
099300130320      *
099400130320     C                   ENDIF
099500130320    ***
099600130320     C                   IF        DEN#CNE > 0
099700130320      * DENTAL
099800130320     C                   EVAL      @PLANIN = DEN@PLN(DEN#CNE)
099900130320     C                   EXSR      $QUIK
100000130320     C                   EXSR      $PLANSRCH
100100130320     C                   IF        PLN@CAT = *BLANKS
100200130320     C     'DEN FILL'    DSPLY     '*EXT'
100300130320     C                   SETON                                        H1
100400130320     C                   ENDIF
100500130320      *
100600130320     C                   CLEAR                   AE@@
100700130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
100800130320     C                   EVAL      AE@@COV = DEN@ENR(DEN#CNE)
100900130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
101000130320     C                   EVAL      AEMG = %TRIM(CPCID1)
101100130320      *
101200130320     C                   EVAL      #XSX = DEN@FRM(DEN#CNE)
101300130320     C                   MOVE      #XSX          #SIGN
101400130320     C                   SUBDUR    1:*D          #SIGN
101500130320     C                   MOVE      #SIGN         #XSX
101600130320     C                   EVAL      AE@@DTS = '1'
101700130320     C                   MOVE      #XSX          AE@@SDTE
101800130320      *
101900130320     C                   EVAL      #CANCEL = DEN@TRM(DEN#CNE)
102000130320     C                   IF        #CANCEL = 99999999
102100130320     C                   EVAL      AE@@BAC = 'ENR'
102200130320     C                   EVAL      #XSX = DEN@FRM(DEN#CNE)
102300130320     C                   ELSE
102400130320     C                   EVAL      AE@@BAC = 'TRM'
102500130320     C                   EVAL      #XSX = DEN@TRM(DEN#CNE)
102600130320     C                   ENDIF
102700130320     C                   MOVE      #XSX          AE@@AED
102800130320      *
102900130320     C*                  EVAL      AE@@VOL = DEN@VOL(DEN#CNE)
103000130320     C                   EVAL      AE@@DT = '0'
103100130320     C                   EVAL      #XSX = DEN@FRM(DEN#CNE)
103200130320     C                   MOVE      #XSX          AE@@MDTE
103300130320     C                   ADD       1             NDX
103400130320     C                   EVAL      @@AE(NDX) = AE@@
103500130320      *
103600130320     C                   ENDIF
103700130320    ***
103800130320     C                   IF        RXD#CNE > 0
103900130320      * RXD
104000130320     C                   EVAL      @PLANIN = RXD@PLN(RXD#CNE)
104100130320     C                   EXSR      $QUIK
104200130320     C                   EXSR      $PLANSRCH
104300130320     C                   IF        PLN@CAT = *BLANKS
104400130320     C     'RXD FILL'    DSPLY     '*EXT'
104500130320     C                   SETON                                        H1
104600130320     C                   ENDIF
104700130320      *
104800130320     C                   CLEAR                   AE@@
104900130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
105000130320     C                   EVAL      AE@@COV = RXD@ENR(RXD#CNE)
105100130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
105200130320     C                   EVAL      AEMG = %TRIM(CPCID1)
105300130320      *
105400130320     C                   EVAL      #XSX = RXD@FRM(RXD#CNE)
105500130320     C                   MOVE      #XSX          #SIGN
105600130320     C                   SUBDUR    1:*D          #SIGN
105700130320     C                   MOVE      #SIGN         #XSX
105800130320     C                   EVAL      AE@@DTS = '1'
105900130320     C                   MOVE      #XSX          AE@@SDTE
106000130320      *
106100130320     C                   EVAL      #CANCEL = RXD@TRM(RXD#CNE)
106200130320     C                   IF        #CANCEL = 99999999
106300130320     C                   EVAL      AE@@BAC = 'ENR'
106400130320     C                   EVAL      #XSX = RXD@FRM(RXD#CNE)
106500130320     C                   ELSE
106600130320     C                   EVAL      AE@@BAC = 'TRM'
106700130320     C                   EVAL      #XSX = RXD@TRM(RXD#CNE)
106800130320     C                   ENDIF
106900130320     C                   MOVE      #XSX          AE@@AED
107000130320      *
107100130320     C*                  EVAL      AE@@VOL = RXD@VOL(RXD#CNE)
107200130320     C                   EVAL      AE@@DT = '0'
107300130320     C                   EVAL      #XSX = RXD@FRM(RXD#CNE)
107400130320     C                   MOVE      #XSX          AE@@MDTE
107500130320     C                   ADD       1             NDX
107600130320     C                   EVAL      @@AE(NDX) = AE@@
107700130320      *
107800130320     C                   ENDIF
107900130320    ***
108000130320     C                   IF        VIS#CNE > 0
108100130320      *  VISION
108200130320     C                   EVAL      @PLANIN = VIS@PLN(VIS#CNE)
108300130320     C                   EVAL      @ENRIN = VIS@ENR(VIS#CNE)
108400130320     C                   EXSR      $QUIK
108500130320     C                   EXSR      $PLANSRCH
108600130320     C                   IF        PLN@CAT = *BLANKS
108700130320     C     'VIS FILL'    DSPLY     '*EXT'
108800130320     C                   SETON                                        H1
108900130320     C                   ENDIF
109000130320      *
109100130320     C                   CLEAR                   AE@@
109200130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
109300130320     C                   EVAL      AE@@COV = VIS@ENR(VIS#CNE)
109400130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
109500130320     C                   EVAL      AEMG = %TRIM(CPCID1)
109600130320      *
109700130320     C                   EVAL      #XSX = VIS@FRM(VIS#CNE)
109800130320     C                   MOVE      #XSX          #SIGN
109900130320     C                   SUBDUR    1:*D          #SIGN
110000130320     C                   MOVE      #SIGN         #XSX
110100130320     C                   EVAL      AE@@DTS = '1'
110200130320     C                   MOVE      #XSX          AE@@SDTE
110300130320      *
110400130320     C                   EVAL      #CANCEL = VIS@TRM(VIS#CNE)
110500130320     C                   IF        #CANCEL = 99999999
110600130320     C                   EVAL      AE@@BAC = 'ENR'
110700130320     C                   EVAL      #XSX = VIS@FRM(VIS#CNE)
110800130320     C                   ELSE
110900130320     C                   EVAL      AE@@BAC = 'TRM'
111000130320     C                   EVAL      #XSX = VIS@TRM(VIS#CNE)
111100130320     C                   ENDIF
111200130320     C                   MOVE      #XSX          AE@@AED
111300130320      *
111400130320     C*                  EVAL      AE@@VOL = VIS@VOL(VIS#CNE)
111500130320     C                   EVAL      AE@@DT = '0'
111600130320     C                   EVAL      #XSX = VIS@FRM(VIS#CNE)
111700130320     C                   MOVE      #XSX          AE@@MDTE
111800130320     C                   ADD       1             NDX
111900130320     C                   EVAL      @@AE(NDX) = AE@@
112000130320      *
112100130320     C                   ENDIF
112200130320    ***
112300130320     C                   IF        LTD#CNE > 0 AND WRT@TYPE = 'MEMBER'
112400130320      * LTD
112500130320     C                   EVAL      @PLANIN = LTD@PLN(LTD#CNE)
112600130320     C                   EVAL      @ENRIN = LTD@ENR(LTD#CNE)
112700130320     C                   EXSR      $QUIK
112800130320     C                   EXSR      $PLANSRCH
112900130320     C                   IF        PLN@CAT = *BLANKS
113000130320     C     'LTD FILL'    DSPLY     '*EXT'
113100130320     C                   SETON                                        H1
113200130320     C                   ENDIF
113300130320      *
113400130320     C                   CLEAR                   AE@@
113500130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
113600130320     C                   EVAL      AE@@COV = LTD@ENR(LTD#CNE)
113700130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
113800130320     C                   EVAL      AEMG = %TRIM(CPCID1)
113900130320      *
114000130320     C                   EVAL      #XSX = LTD@FRM(LTD#CNE)
114100130320     C                   MOVE      #XSX          #SIGN
114200130320     C                   SUBDUR    1:*D          #SIGN
114300130320     C                   MOVE      #SIGN         #XSX
114400130320     C                   EVAL      AE@@DTS = '1'
114500130320     C                   MOVE      #XSX          AE@@SDTE
114600130320      *
114700130320     C                   EVAL      #CANCEL = LTD@TRM(LTD#CNE)
114800130320     C                   IF        #CANCEL = 99999999
114900130320     C                   EVAL      AE@@BAC = 'ENR'
115000130320     C                   EVAL      #XSX = LTD@FRM(LTD#CNE)
115100130320     C                   ELSE
115200130320     C                   EVAL      AE@@BAC = 'TRM'
115300130320     C                   EVAL      #XSX = LTD@TRM(LTD#CNE)
115400130320     C                   ENDIF
115500130320     C                   MOVE      #XSX          AE@@AED
115600130320      *
115700130320     C                   IF        CPCID6 = 'Y'
115800130320     C                   EVAL      #7S0 = LTD@VOL(LTD#CNE)
115900130320     C     #7S0          MULT      100           #15S0
116000130320     C                   MOVE      #15S0         AE@@VOL
116100130320     C                   ELSE
116200130320     C                   EVAL      AE@@VOL = *BLANKS
116300130320     C                   ENDIF
116400130320      *
116500130320     C                   EVAL      AE@@DT = '0'
116600130320     C                   EVAL      #XSX = LTD@FRM(LTD#CNE)
116700130320     C                   MOVE      #XSX          AE@@MDTE
116800130320     C                   ADD       1             NDX
116900130320     C                   EVAL      @@AE(NDX) = AE@@
117000130320      *
117100130320     C                   ENDIF
117200130320    ***
117300130320     C                   IF        STD#CNE > 0 AND WRT@TYPE = 'MEMBER'
117400130320      * STD
117500130320     C                   EVAL      @PLANIN = STD@PLN(STD#CNE)
117600130320     C                   EVAL      @ENRIN = STD@ENR(STD#CNE)
117700130320     C                   EXSR      $QUIK
117800130320     C                   EXSR      $PLANSRCH
117900130320     C                   IF        PLN@CAT = *BLANKS
118000130320     C     'STD FILL'    DSPLY     '*EXT'
118100130320     C                   SETON                                        H1
118200130320     C                   ENDIF
118300130320      *
118400130320     C                   CLEAR                   AE@@
118500130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
118600130320     C                   EVAL      AE@@COV = STD@ENR(STD#CNE)
118700130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
118800130320     C                   EVAL      AEMG = %TRIM(CPCID1)
118900130320      *
119000130320     C                   EVAL      #XSX = STD@FRM(STD#CNE)
119100130320     C                   MOVE      #XSX          #SIGN
119200130320     C                   SUBDUR    1:*D          #SIGN
119300130320     C                   MOVE      #SIGN         #XSX
119400130320     C                   EVAL      AE@@DTS = '1'
119500130320     C                   MOVE      #XSX          AE@@SDTE
119600130320      *
119700130320     C                   EVAL      #CANCEL = STD@TRM(STD#CNE)
119800130320     C                   IF        #CANCEL = 99999999
119900130320     C                   EVAL      AE@@BAC = 'ENR'
120000130320     C                   EVAL      #XSX = STD@FRM(STD#CNE)
120100130320     C                   ELSE
120200130320     C                   EVAL      AE@@BAC = 'TRM'
120300130320     C                   EVAL      #XSX = STD@TRM(STD#CNE)
120400130320     C                   ENDIF
120500130320     C                   MOVE      #XSX          AE@@AED
120600130320      *
120700130320     C                   IF        CPCID6 = 'Y'
120800130320     C                   EVAL      #7S0 = STD@VOL(STD#CNE)
120900130320     C     #7S0          MULT      100           #15S0
121000130320     C                   MOVE      #15S0         AE@@VOL
121100130320     C                   ELSE
121200130320     C                   EVAL      AE@@VOL = *BLANKS
121300130320     C                   ENDIF
121400130320      *
121500130320     C                   EVAL      AE@@DT = '0'
121600130320     C                   EVAL      #XSX = STD@FRM(STD#CNE)
121700130320     C                   MOVE      #XSX          AE@@MDTE
121800130320     C                   ADD       1             NDX
121900130320     C                   EVAL      @@AE(NDX) = AE@@
122000130320      *
122100130320     C                   ENDIF
122200130320    ***
122300130320     C                   IF        LIF#CNE > 0 AND WRT@TYPE = 'MEMBER'
122400130320      * BASIC LIFE
122500130320     C                   EVAL      @PLANIN = LIF@PLN(LIF#CNE)
122600130320     C                   EVAL      @ENRIN = LIF@ENR(LIF#CNE)
122700130320     C                   EXSR      $QUIK
122800130320     C                   EXSR      $PLANSRCH
122900130320     C                   IF        PLN@CAT = *BLANKS
123000130320     C     'LIF FILL'    DSPLY     '*EXT'
123100130320     C                   SETON                                        H1
123200130320     C                   ENDIF
123300130320      *
123400130320     C                   CLEAR                   AE@@
123500130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
123600130320     C                   EVAL      AE@@COV = LIF@ENR(LIF#CNE)
123700130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
123800130320     C                   EVAL      AEMG = %TRIM(CPCID1)
123900130320      *
124000130320     C                   EVAL      #XSX = LIF@FRM(LIF#CNE)
124100130320     C                   MOVE      #XSX          #SIGN
124200130320     C                   SUBDUR    1:*D          #SIGN
124300130320     C                   MOVE      #SIGN         #XSX
124400130320     C                   EVAL      AE@@DTS = '1'
124500130320     C                   MOVE      #XSX          AE@@SDTE
124600130320      *
124700130320     C                   EVAL      #CANCEL = LIF@TRM(LIF#CNE)
124800130320     C                   IF        #CANCEL = 99999999
124900130320     C                   EVAL      AE@@BAC = 'ENR'
125000130320     C                   EVAL      #XSX = LIF@FRM(LIF#CNE)
125100130320     C                   ELSE
125200130320     C                   EVAL      AE@@BAC = 'TRM'
125300130320     C                   EVAL      #XSX = LIF@TRM(LIF#CNE)
125400130320     C                   ENDIF
125500130320     C                   MOVE      #XSX          AE@@AED
125600130320      *
125700130320     C                   IF        CPCID6 = 'Y'
125800130320     C                   EVAL      #7S0 = LIF@VOL(LIF#CNE)
125900130320     C     #7S0          MULT      100           #15S0
126000130320     C                   MOVE      #15S0         AE@@VOL
126100130320     C                   ELSE
126200130320     C                   EVAL      AE@@VOL = *BLANKS
126300130320     C                   ENDIF
126400130320      *
126500130320     C                   EVAL      AE@@DT = '0'
126600130320     C                   EVAL      #XSX = LIF@FRM(LIF#CNE)
126700130320     C                   MOVE      #XSX          AE@@MDTE
126800130320     C                   ADD       1             NDX
126900130320     C                   EVAL      @@AE(NDX) = AE@@
127000130320      *
127100130320     C                   ENDIF
127200130320    ***
127300130320     C                   IF        ADD#CNE > 0 AND WRT@TYPE = 'MEMBER'
127400130320      * BASIC AD&D
127500130320     C                   EVAL      @PLANIN = ADD@PLN(ADD#CNE)
127600130320     C                   EVAL      @ENRIN = ADD@ENR(ADD#CNE)
127700130320     C                   EXSR      $QUIK
127800130320     C                   EXSR      $PLANSRCH
127900130320     C                   IF        PLN@CAT = *BLANKS
128000130320     C     'ADD FILL'    DSPLY     '*EXT'
128100130320     C                   SETON                                        H1
128200130320     C                   ENDIF
128300130320      *
128400130320     C                   CLEAR                   AE@@
128500130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
128600130320     C                   EVAL      AE@@COV = ADD@ENR(ADD#CNE)
128700130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
128800130320     C                   EVAL      AEMG = %TRIM(CPCID1)
128900130320      *
129000130320     C                   EVAL      #XSX = ADD@FRM(ADD#CNE)
129100130320     C                   MOVE      #XSX          #SIGN
129200130320     C                   SUBDUR    1:*D          #SIGN
129300130320     C                   MOVE      #SIGN         #XSX
129400130320     C                   EVAL      AE@@DTS = '1'
129500130320     C                   MOVE      #XSX          AE@@SDTE
129600130320      *
129700130320     C                   EVAL      #CANCEL = ADD@TRM(ADD#CNE)
129800130320     C                   IF        #CANCEL = 99999999
129900130320     C                   EVAL      AE@@BAC = 'ENR'
130000130320     C                   EVAL      #XSX = ADD@FRM(ADD#CNE)
130100130320     C                   ELSE
130200130320     C                   EVAL      AE@@BAC = 'TRM'
130300130320     C                   EVAL      #XSX = ADD@TRM(ADD#CNE)
130400130320     C                   ENDIF
130500130320     C                   MOVE      #XSX          AE@@AED
130600130320      *
130700130320     C                   IF        CPCID6 = 'Y'
130800130320     C                   EVAL      #7S0 = ADD@VOL(ADD#CNE)
130900130320     C     #7S0          MULT      100           #15S0
131000130320     C                   MOVE      #15S0         AE@@VOL
131100130320     C                   ELSE
131200130320     C                   EVAL      AE@@VOL = *BLANKS
131300130320     C                   ENDIF
131400130320      *
131500130320     C                   EVAL      AE@@DT = '0'
131600130320     C                   EVAL      #XSX = ADD@FRM(ADD#CNE)
131700130320     C                   MOVE      #XSX          AE@@MDTE
131800130320     C                   ADD       1             NDX
131900130320     C                   EVAL      @@AE(NDX) = AE@@
132000130320      *
132100130320     C                   ENDIF
132200130320    ***
132300130320     C                   IF        DLF#CNE > 0
132400130320      * DEPENDENT LIFE
132500130320     C                   EVAL      @PLANIN = DLF@PLN(DLF#CNE)
132600130320     C                   EVAL      @ENRIN = DLF@ENR(DLF#CNE)
132700130320     C                   EXSR      $QUIK
132800130320     C                   EXSR      $PLANSRCH
132900130320     C                   IF        PLN@CAT = *BLANKS
133000130320     C     'DLF FILL'    DSPLY     '*EXT'
133100130320     C                   SETON                                        H1
133200130320     C                   ENDIF
133300130320      *
133400130320     C                   CLEAR                   AE@@
133500130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
133600130320     C                   EVAL      AE@@COV = DLF@ENR(DLF#CNE)
133700130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
133800130320     C                   EVAL      AEMG = %TRIM(CPCID1)
133900130320      *
134000130320     C                   EVAL      #XSX = DLF@FRM(DLF#CNE)
134100130320     C                   MOVE      #XSX          #SIGN
134200130320     C                   SUBDUR    1:*D          #SIGN
134300130320     C                   MOVE      #SIGN         #XSX
134400130320     C                   EVAL      AE@@DTS = '1'
134500130320     C                   MOVE      #XSX          AE@@SDTE
134600130320      *
134700130320     C                   EVAL      #CANCEL = DLF@TRM(DLF#CNE)
134800130320     C                   IF        #CANCEL = 99999999
134900130320     C                   EVAL      AE@@BAC = 'ENR'
135000130320     C                   EVAL      #XSX = DLF@FRM(DLF#CNE)
135100130320     C                   ELSE
135200130320     C                   EVAL      AE@@BAC = 'TRM'
135300130320     C                   EVAL      #XSX = DLF@TRM(DLF#CNE)
135400130320     C                   ENDIF
135500130320     C                   MOVE      #XSX          AE@@AED
135600130320      *
135700130320     C                   IF        CPCID6 = 'Y'
135800130320     C                   EVAL      #7S0 = DLF@VOL(DLF#CNE)
135900130320     C     #7S0          MULT      100           #15S0
136000130320     C                   MOVE      #15S0         AE@@VOL
136100130320     C                   ELSE
136200130320     C                   EVAL      AE@@VOL = *BLANKS
136300130320     C                   ENDIF
136400130320      *
136500130320     C                   EVAL      AE@@DT = '0'
136600130320     C                   EVAL      #XSX = DLF@FRM(DLF#CNE)
136700130320     C                   MOVE      #XSX          AE@@MDTE
136800130320     C                   ADD       1             NDX
136900130320     C                   EVAL      @@AE(NDX) = AE@@
137000130320      *
137100130320     C                   ENDIF
137200130320    ***
137300130320     C                   IF        VLF#CNE > 0
137400130320      * VOL LIFE
137500130320     C                   EVAL      @PLANIN = VLF@PLN(VLF#CNE)
137600130320     C                   EVAL      @ENRIN = VLF@ENR(VLF#CNE)
137700130320     C                   EXSR      $QUIK
137800130320     C                   EXSR      $PLANSRCH
137900130320     C                   IF        PLN@CAT = *BLANKS
138000130320     C     'VLF FILL'    DSPLY     '*EXT'
138100130320     C                   SETON                                        H1
138200130320     C                   ENDIF
138300130320      *
138400130320     C                   CLEAR                   AE@@
138500130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
138600130320     C                   EVAL      AE@@COV = VLF@ENR(VLF#CNE)
138700130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
138800130320     C                   EVAL      AEMG = %TRIM(CPCID1)
138900130320      *
139000130320     C                   EVAL      #XSX = VLF@FRM(VLF#CNE)
139100130320     C                   MOVE      #XSX          #SIGN
139200130320     C                   SUBDUR    1:*D          #SIGN
139300130320     C                   MOVE      #SIGN         #XSX
139400130320     C                   EVAL      AE@@DTS = '1'
139500130320     C                   MOVE      #XSX          AE@@SDTE
139600130320      *
139700130320     C                   EVAL      #CANCEL = VLF@TRM(VLF#CNE)
139800130320     C                   IF        #CANCEL = 99999999
139900130320     C                   EVAL      AE@@BAC = 'ENR'
140000130320     C                   EVAL      #XSX = VLF@FRM(VLF#CNE)
140100130320     C                   ELSE
140200130320     C                   EVAL      AE@@BAC = 'TRM'
140300130320     C                   EVAL      #XSX = VLF@TRM(VLF#CNE)
140400130320     C                   ENDIF
140500130320     C                   MOVE      #XSX          AE@@AED
140600130320      *
140700130320     C                   IF        CPCID6 = 'Y'
140800130320     C                   EVAL      #7S0 = VLF@VOL(VLF#CNE)
140900130320     C     #7S0          MULT      100           #15S0
141000130320     C                   MOVE      #15S0         AE@@VOL
141100130320     C                   ELSE
141200130320     C                   EVAL      AE@@VOL = *BLANKS
141300130320     C                   ENDIF
141400130320      *
141500130320     C                   EVAL      AE@@DT = '0'
141600130320     C                   EVAL      #XSX = VLF@FRM(VLF#CNE)
141700130320     C                   MOVE      #XSX          AE@@MDTE
141800130320     C                   ADD       1             NDX
141900130320     C                   EVAL      @@AE(NDX) = AE@@
142000130320      *
142100130320     C                   ENDIF
142200130320    ***
142300130320     C                   IF        VAD#CNE > 0
142400130320      * VOLUNTARY AD&D
142500130320     C                   EVAL      @PLANIN = VAD@PLN(VAD#CNE)
142600130320     C                   EVAL      @ENRIN = VAD@ENR(VAD#CNE)
142700130320     C                   EXSR      $QUIK
142800130320     C                   EXSR      $PLANSRCH
142900130320     C                   IF        PLN@CAT = *BLANKS
143000130320     C     'VAD FILL'    DSPLY     '*EXT'
143100130320     C                   SETON                                        H1
143200130320     C                   ENDIF
143300130320      *
143400130320     C                   CLEAR                   AE@@
143500130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
143600130320     C                   EVAL      AE@@COV = VAD@ENR(VAD#CNE)
143700130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
143800130320     C                   EVAL      AEMG = %TRIM(CPCID1)
143900130320      *
144000130320     C                   EVAL      #XSX = VAD@FRM(VAD#CNE)
144100130320     C                   MOVE      #XSX          #SIGN
144200130320     C                   SUBDUR    1:*D          #SIGN
144300130320     C                   MOVE      #SIGN         #XSX
144400130320     C                   EVAL      AE@@DTS = '1'
144500130320     C                   MOVE      #XSX          AE@@SDTE
144600130320      *
144700130320     C                   EVAL      #CANCEL = VAD@TRM(VAD#CNE)
144800130320     C                   IF        #CANCEL = 99999999
144900130320     C                   EVAL      AE@@BAC = 'ENR'
145000130320     C                   EVAL      #XSX = VAD@FRM(VAD#CNE)
145100130320     C                   ELSE
145200130320     C                   EVAL      AE@@BAC = 'TRM'
145300130320     C                   EVAL      #XSX = VAD@TRM(VAD#CNE)
145400130320     C                   ENDIF
145500130320     C                   MOVE      #XSX          AE@@AED
145600130320      *
145700130320     C                   IF        CPCID6 = 'Y'
145800130320     C                   EVAL      #7S0 = VAD@VOL(VAD#CNE)
145900130320     C     #7S0          MULT      100           #15S0
146000130320     C                   MOVE      #15S0         AE@@VOL
146100130320     C                   ELSE
146200130320     C                   EVAL      AE@@VOL = *BLANKS
146300130320     C                   ENDIF
146400130320      *
146500130320     C                   EVAL      AE@@DT = '0'
146600130320     C                   EVAL      #XSX = VAD@FRM(VAD#CNE)
146700130320     C                   MOVE      #XSX          AE@@MDTE
146800130320     C                   ADD       1             NDX
146900130320     C                   EVAL      @@AE(NDX) = AE@@
147000130320      *
147100130320     C                   ENDIF
147200130320    ***
147300130320     C                   IF        VLT#CNE > 0
147400130320      * VOL LTD
147500130320     C                   EVAL      @PLANIN = VLT@PLN(VLT#CNE)
147600130320     C                   EVAL      @ENRIN = VLT@ENR(VLT#CNE)
147700130320     C                   EXSR      $QUIK
147800130320     C                   EXSR      $PLANSRCH
147900130320     C                   IF        PLN@CAT = *BLANKS
148000130320     C     'VLT FILL'    DSPLY     '*EXT'
148100130320     C                   SETON                                        H1
148200130320     C                   ENDIF
148300130320      *
148400130320     C                   CLEAR                   AE@@
148500130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
148600130320     C                   EVAL      AE@@COV = VLT@ENR(VLT#CNE)
148700130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
148800130320     C                   EVAL      AEMG = %TRIM(CPCID1)
148900130320      *
149000130320     C                   EVAL      #XSX = VLT@FRM(VLT#CNE)
149100130320     C                   MOVE      #XSX          #SIGN
149200130320     C                   SUBDUR    1:*D          #SIGN
149300130320     C                   MOVE      #SIGN         #XSX
149400130320     C                   EVAL      AE@@DTS = '1'
149500130320     C                   MOVE      #XSX          AE@@SDTE
149600130320      *
149700130320     C                   EVAL      #CANCEL = VLT@TRM(VLT#CNE)
149800130320     C                   IF        #CANCEL = 99999999
149900130320     C                   EVAL      AE@@BAC = 'ENR'
150000130320     C                   EVAL      #XSX = VLT@FRM(VLT#CNE)
150100130320     C                   ELSE
150200130320     C                   EVAL      AE@@BAC = 'TRM'
150300130320     C                   EVAL      #XSX = VLT@TRM(VLT#CNE)
150400130320     C                   ENDIF
150500130320     C                   MOVE      #XSX          AE@@AED
150600130320      *
150700130320     C                   IF        CPCID6 = 'Y'
150800130320     C                   EVAL      #7S0 = VLT@VOL(VLT#CNE)
150900130320     C     #7S0          MULT      100           #15S0
151000130320     C                   MOVE      #15S0         AE@@VOL
151100130320     C                   ELSE
151200130320     C                   EVAL      AE@@VOL = *BLANKS
151300130320     C                   ENDIF
151400130320      *
151500130320     C                   EVAL      AE@@DT = '0'
151600130320     C                   EVAL      #XSX = VLT@FRM(VLT#CNE)
151700130320     C                   MOVE      #XSX          AE@@MDTE
151800130320     C                   ADD       1             NDX
151900130320     C                   EVAL      @@AE(NDX) = AE@@
152000130320      *
152100130320     C                   ENDIF
152200130320    ***
152300130320     C                   IF        CRI#CNE > 0
152400130320      * CRITICAL ILLNESS
152500130320     C                   EVAL      @PLANIN = CRI@PLN(CRI#CNE)
152600130320     C                   EVAL      @ENRIN = CRI@ENR(CRI#CNE)
152700130320     C                   EXSR      $QUIK
152800130320     C                   EXSR      $PLANSRCH
152900130320     C                   IF        PLN@CAT = *BLANKS
153000130320     C     'CRI FILL'    DSPLY     '*EXT'
153100130320     C                   SETON                                        H1
153200130320     C                   ENDIF
153300130320      *
153400130320     C                   CLEAR                   AE@@
153500130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
153600130320     C                   EVAL      AE@@COV = CRI@ENR(CRI#CNE)
153700130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
153800130320     C                   EVAL      AEMG = %TRIM(CPCID1)
153900130320      *
154000130320     C                   EVAL      #XSX = CRI@FRM(CRI#CNE)
154100130320     C                   MOVE      #XSX          #SIGN
154200130320     C                   SUBDUR    1:*D          #SIGN
154300130320     C                   MOVE      #SIGN         #XSX
154400130320     C                   EVAL      AE@@DTS = '1'
154500130320     C                   MOVE      #XSX          AE@@SDTE
154600130320      *
154700130320     C                   EVAL      #CANCEL = CRI@TRM(CRI#CNE)
154800130320     C                   IF        #CANCEL = 99999999
154900130320     C                   EVAL      AE@@BAC = 'ENR'
155000130320     C                   EVAL      #XSX = CRI@FRM(CRI#CNE)
155100130320     C                   ELSE
155200130320     C                   EVAL      AE@@BAC = 'TRM'
155300130320     C                   EVAL      #XSX = CRI@TRM(CRI#CNE)
155400130320     C                   ENDIF
155500130320     C                   MOVE      #XSX          AE@@AED
155600130320      *
155700130320     C                   IF        CPCID6 = 'Y'
155800130320     C                   EVAL      #7S0 = CRI@VOL(CRI#CNE)
155900130320     C     #7S0          MULT      100           #15S0
156000130320     C                   MOVE      #15S0         AE@@VOL
156100130320     C                   ELSE
156200130320     C                   EVAL      AE@@VOL = *BLANKS
156300130320     C                   ENDIF
156400130320      *
156500130320     C                   EVAL      AE@@DT = '0'
156600130320     C                   EVAL      #XSX = CRI@FRM(CRI#CNE)
156700130320     C                   MOVE      #XSX          AE@@MDTE
156800130320     C                   ADD       1             NDX
156900130320     C                   EVAL      @@AE(NDX) = AE@@
157000130320      *
157100130320     C                   ENDIF
157200130320    ***
157300130320     C                   IF        VCI#CNE > 0
157400130320      * VOL CRITICAL ILLNESS
157500130320     C                   EVAL      @PLANIN = VCI@PLN(VCI#CNE)
157600130320     C                   EVAL      @ENRIN = VCI@ENR(VCI#CNE)
157700130320     C                   EXSR      $QUIK
157800130320     C                   EXSR      $PLANSRCH
157900130320     C                   IF        PLN@CAT = *BLANKS
158000130320     C     'VCI FILL'    DSPLY     '*EXT'
158100130320     C                   SETON                                        H1
158200130320     C                   ENDIF
158300130320      *
158400130320     C                   CLEAR                   AE@@
158500130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
158600130320     C                   EVAL      AE@@COV = VCI@ENR(VCI#CNE)
158700130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
158800130320     C                   EVAL      AEMG = %TRIM(CPCID1)
158900130320      *
159000130320     C                   EVAL      #XSX = VCI@FRM(VCI#CNE)
159100130320     C                   MOVE      #XSX          #SIGN
159200130320     C                   SUBDUR    1:*D          #SIGN
159300130320     C                   MOVE      #SIGN         #XSX
159400130320     C                   EVAL      AE@@DTS = '1'
159500130320     C                   MOVE      #XSX          AE@@SDTE
159600130320      *
159700130320     C                   EVAL      #CANCEL = VCI@TRM(VCI#CNE)
159800130320     C                   IF        #CANCEL = 99999999
159900130320     C                   EVAL      AE@@BAC = 'ENR'
160000130320     C                   EVAL      #XSX = VCI@FRM(VCI#CNE)
160100130320     C                   ELSE
160200130320     C                   EVAL      AE@@BAC = 'TRM'
160300130320     C                   EVAL      #XSX = VCI@TRM(VCI#CNE)
160400130320     C                   ENDIF
160500130320     C                   MOVE      #XSX          AE@@AED
160600130320      *
160700130320     C                   IF        CPCID6 = 'Y'
160800130320     C                   EVAL      #7S0 = VCI@VOL(VCI#CNE)
160900130320     C     #7S0          MULT      100           #15S0
161000130320     C                   MOVE      #15S0         AE@@VOL
161100130320     C                   ELSE
161200130320     C                   EVAL      AE@@VOL = *BLANKS
161300130320     C                   ENDIF
161400130320      *
161500130320     C                   EVAL      AE@@DT = '0'
161600130320     C                   EVAL      #XSX = VCI@FRM(VCI#CNE)
161700130320     C                   MOVE      #XSX          AE@@MDTE
161800130320     C                   ADD       1             NDX
161900130320     C                   EVAL      @@AE(NDX) = AE@@
162000130320      *
162100130320     C                   ENDIF
162200130320    ***
162300130320     C                   IF        ACC#CNE > 0
162400130320      * ACCIDENT COVERAGE
162500130320     C                   EVAL      @PLANIN = ACC@PLN(ACC#CNE)
162600130320     C                   EVAL      @ENRIN = ACC@ENR(ACC#CNE)
162700130320     C                   EXSR      $QUIK
162800130320     C                   EXSR      $PLANSRCH
162900130320     C                   IF        PLN@CAT = *BLANKS
163000130320     C     'ACC FILL'    DSPLY     '*EXT'
163100130320     C                   SETON                                        H1
163200130320     C                   ENDIF
163300130320      *
163400130320     C                   CLEAR                   AE@@
163500130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
163600130320     C                   EVAL      AE@@COV = ACC@ENR(ACC#CNE)
163700130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
163800130320     C                   EVAL      AEMG = %TRIM(CPCID1)
163900130320      *
164000130320     C                   EVAL      #XSX = ACC@FRM(ACC#CNE)
164100130320     C                   MOVE      #XSX          #SIGN
164200130320     C                   SUBDUR    1:*D          #SIGN
164300130320     C                   MOVE      #SIGN         #XSX
164400130320     C                   EVAL      AE@@DTS = '1'
164500130320     C                   MOVE      #XSX          AE@@SDTE
164600130320      *
164700130320     C                   EVAL      #CANCEL = ACC@TRM(ACC#CNE)
164800130320     C                   IF        #CANCEL = 99999999
164900130320     C                   EVAL      AE@@BAC = 'ENR'
165000130320     C                   EVAL      #XSX = ACC@FRM(ACC#CNE)
165100130320     C                   ELSE
165200130320     C                   EVAL      AE@@BAC = 'TRM'
165300130320     C                   EVAL      #XSX = ACC@TRM(ACC#CNE)
165400130320     C                   ENDIF
165500130320     C                   MOVE      #XSX          AE@@AED
165600130320      *
165700130320     C                   IF        CPCID6 = 'Y'
165800130320     C                   EVAL      #7S0 = ACC@VOL(ACC#CNE)
165900130320     C     #7S0          MULT      100           #15S0
166000130320     C                   MOVE      #15S0         AE@@VOL
166100130320     C                   ELSE
166200130320     C                   EVAL      AE@@VOL = *BLANKS
166300130320     C                   ENDIF
166400130320      *
166500130320     C                   EVAL      AE@@DT = '0'
166600130320     C                   EVAL      #XSX = ACC@FRM(ACC#CNE)
166700130320     C                   MOVE      #XSX          AE@@MDTE
166800130320     C                   ADD       1             NDX
166900130320     C                   EVAL      @@AE(NDX) = AE@@
167000130320      *
167100130320     C                   ENDIF
167200130320    ***
167300130320     C                   IF        CCR#CNE > 0
167400130320      * CANCER COVERAGE
167500130320     C                   EVAL      @PLANIN = CCR@PLN(CCR#CNE)
167600130320     C                   EVAL      @ENRIN = CCR@ENR(CCR#CNE)
167700130320     C                   EXSR      $QUIK
167800130320     C                   EXSR      $PLANSRCH
167900130320     C                   IF        PLN@CAT = *BLANKS
168000130320     C     'CCR FILL'    DSPLY     '*EXT'
168100130320     C                   SETON                                        H1
168200130320     C                   ENDIF
168300130320      *
168400130320     C                   CLEAR                   AE@@
168500130320     C                   EVAL      AE@@PDT = %TRIM(CPCID3)
168600130320     C                   EVAL      AE@@COV = CCR@ENR(CCR#CNE)
168700130320     C                   EVAL      AE@@TYP = %SUBST(CPCID4:1:1)
168800130320     C                   EVAL      AEMG = %TRIM(CPCID1)
168900130320      *
169000130320     C                   EVAL      #XSX = CCR@FRM(CCR#CNE)
169100130320     C                   MOVE      #XSX          #SIGN
169200130320     C                   SUBDUR    1:*D          #SIGN
169300130320     C                   MOVE      #SIGN         #XSX
169400130320     C                   EVAL      AE@@DTS = '1'
169500130320     C                   MOVE      #XSX          AE@@SDTE
169600130320      *
169700130320     C                   EVAL      #CANCEL = CCR@TRM(CCR#CNE)
169800130320     C                   IF        #CANCEL = 99999999
169900130320     C                   EVAL      AE@@BAC = 'ENR'
170000130320     C                   EVAL      #XSX = CCR@FRM(CCR#CNE)
170100130320     C                   ELSE
170200130320     C                   EVAL      AE@@BAC = 'TRM'
170300130320     C                   EVAL      #XSX = CCR@TRM(CCR#CNE)
170400130320     C                   ENDIF
170500130320     C                   MOVE      #XSX          AE@@AED
170600130320      *
170700130320     C                   IF        CPCID6 = 'Y'
170800130320     C                   EVAL      #7S0 = CCR@VOL(CCR#CNE)
170900130320     C     #7S0          MULT      100           #15S0
171000130320     C                   MOVE      #15S0         AE@@VOL
171100130320     C                   ELSE
171200130320     C                   EVAL      AE@@VOL = *BLANKS
171300130320     C                   ENDIF
171400130320      *
171500130320     C                   EVAL      AE@@DT = '0'
171600130320     C                   EVAL      #XSX = CCR@FRM(CCR#CNE)
171700130320     C                   MOVE      #XSX          AE@@MDTE
171800130320     C                   ADD       1             NDX
171900130320     C                   EVAL      @@AE(NDX) = AE@@
172000130320      *
172100130320     C                   ENDIF
172200130103    ***
172300121213     C                   ENDSR
172400121213   S***S
172500121214     C     $PREP5        BEGSR
172600121214    ***
172700121213     C     KF@SSN        CHAIN     DEPENR
172800121213     C                   IF        NOT %FOUND(DEPNDC)
172900121213     C                   EVAL      @STEP = 'STEP2'
173000121213     C                   LEAVESR
173100121213     C                   ENDIF
173200121213    ***
173300121213     C     KF@SSN        SETLL     DEPENR
173400121213    ***
173500121213     C                   EVAL      @STEP = 'STEP5'
173600121213    ***
173700121213     C                   ENDSR
173800121213   S***S
173900121213     C     $STEP5        BEGSR
174000121213    ***
174100121213     C     KF@SSN        READE     DEPENR
174200121213    ***
174300121213     C                   IF        %EOF(DEPNDC)
174400121213     C                   EVAL      @STEP = 'STEP2'
174500121213     C                   LEAVESR
174600121213     C                   ENDIF
174700121213    ***
174800121213     C                   EVAL      KF@SEQ = DPSEQ#
174900121213    ***
175000121213     C     KL#DCV        CHAIN     DCOVR
175100121213     C                   IF        NOT %FOUND(ELIGDCOV)
175200121213     C                   LEAVESR
175300121213     C                   ENDIF
175400121213    ***
175500121213     C                   EXSR      $CLRSTG
175600121213    ***
175700121213     C     KL#DCV        SETLL     DCOVR
175800121213    ***
175900121213     C                   EVAL      @STEP = 'STEP6'
176000121213    ***
176100121213     C                   ENDSR
176200121213   S***S
176300121213     C     $STEP6        BEGSR
176400121213    ***
176500121213     C     KL#DCV        READE     DCOVR
176600121213    ***
176700121213     C                   IF        %EOF(ELIGDCOV)
176800121213     C                   EVAL      @STEP = 'PREP7'
176900121213     C                   LEAVESR
177000121213     C                   ENDIF
177100121213    ***
177200121213     C                   EVAL      @PLANIN = DVPLAN
177300121213     C                   EVAL      @ENRIN = DVENRL
177400121213     C                   EVAL      #EFFDTE = DENRDT
177500130227     C                   EVAL      #CANCEL = CCANDT
177600130211    ***
177700130211     C                   EVAL      #BENAMT = 0
177800130211     *** OR
177900130313     C*******************EVAL      #BENAMT = DVVOL
178000121213    ***
178100121213     C                   EXSR      $QUIK
178200121213    ***
178300121213     C                   EXSR      $PLANSRCH
178400121213    ***
178500121213     C                   IF        PLN@CAT = *BLANKS
178600121213     C                   LEAVESR
178700121213     C                   ENDIF
178800121213    ***
178900130227     C                   EXSR      $TIERLVL
179000130227    ***
179100130227     C                   IF        #CANCEL = 0
179200130227     C                   EVAL      #CANCEL = 99999999
179300130227     C                   ENDIF
179400130227    ***
179500121213     C                   EXSR      $AD2MARY
179600121213    ***
179700121213     C                   ENDSR
179800121213   S***S
179900121213     C     $PREP7        BEGSR
180000121213    ***
180100121213     C                   IF        LIF#CNE  = 0 AND MED#CNE  = 0 AND
180200121213     C                             ADD#CNE  = 0 AND DEN#CNE  = 0 AND
180300121213     C                             DLF#CNE  = 0 AND RXD#CNE  = 0 AND
180400121213     C                             VLF#CNE  = 0 AND VIS#CNE  = 0 AND
180500121213     C                             VAD#CNE  = 0 AND LTD#CNE  = 0 AND
180600121213     C                             VLT#CNE  = 0 AND STD#CNE  = 0 AND
180700130204     C                             ACC#CNE  = 0 AND CCR#CNE  = 0 AND
180800121213     C                             CRI#CNE  = 0 AND VCI#CNE  = 0
180900121213     C                   EVAL      @STEP = 'STEP5'
181000121213     C                   LEAVESR
181100121213     C                   ENDIF
181200121213    ***
181300121213     C                   EVAL      TERM_LIF = NO
181400121213     C                   EVAL      TERM_ADD = NO
181500121213     C                   EVAL      TERM_DLF = NO
181600121213     C                   EVAL      TERM_VLF = NO
181700121213     C                   EVAL      TERM_VAD = NO
181800121213     C                   EVAL      TERM_VLT = NO
181900121213     C                   EVAL      TERM_CRI = NO
182000121213     C                   EVAL      TERM_MED = NO
182100121213     C                   EVAL      TERM_DEN = NO
182200121213     C                   EVAL      TERM_RXD = NO
182300121213     C                   EVAL      TERM_VIS = NO
182400121213     C                   EVAL      TERM_LTD = NO
182500121213     C                   EVAL      TERM_STD = NO
182600121213     C                   EVAL      TERM_VCI = NO
182700130204     C                   EVAL      TERM_ACC = NO
182800130204     C                   EVAL      TERM_CCR = NO
182900121213    ***
183000121213     C                   EXSR      $CHKHEM
183100121213    ***
183200121213     C                   EVAL      @STEP = 'STEP7'
183300121213    ***
183400121213     C                   ENDSR
183500121213   S***S
183600121213     C     $STEP7        BEGSR
183700121213    ***
183800121213     C                   IF        LIF#CNE  = 0 AND MED#CNE  = 0 AND
183900121213     C                             ADD#CNE  = 0 AND DEN#CNE  = 0 AND
184000121213     C                             DLF#CNE  = 0 AND RXD#CNE  = 0 AND
184100121213     C                             VLF#CNE  = 0 AND VIS#CNE  = 0 AND
184200121213     C                             VAD#CNE  = 0 AND LTD#CNE  = 0 AND
184300121213     C                             VLT#CNE  = 0 AND STD#CNE  = 0 AND
184400130204     C                             ACC#CNE  = 0 AND CCR#CNE  = 0 AND
184500121213     C                             CRI#CNE  = 0 AND VCI#CNE  = 0
184600121213     C                   EVAL      @STEP = 'STEP5'
184700121213     C                   LEAVESR
184800121213     C                   ENDIF
184900121213    ***
185000121213     C                   EVAL      WRT@TYPE = 'DEPEND'
185100121213    ***
185200121213     C                   EXSR      $FILLDEP
185300121213    ***
185400121213     C                   EXSR      $FILLCOVG
185500121213    ***
185600130211     C                   WRITE     AEBF010
185700121213     C                   ADD       1             #RECCNT
185800121213    ***
185900121213     C                   EVAL      @STEP = 'STEP5'
186000121213    ***
186100121213     C                   ENDSR
186200121213   S***S
186300121213     C     $FILLDEP      BEGSR
186400130204    ***
186500130204     C                   CLEAR                   AEBF010
186600130204    ***
186700130204     C                   EVAL      AEBG = %TRIM(CACID2)
186800130204     C                   EVAL      AESN = %TRIM(CACID1)
186900130204    ***
187000130204     C                   SELECT
187100130204     C                   WHEN      DRELCD = 'RWI' OR DRELCD = 'RHU' OR
187200130204     C                             DRELCD = 'RPA'
187300130204     C                   EVAL      AEEMPCD   = '2'
187400130204     C                   WHEN      DRELCD = 'RSO' OR DRELCD = 'RDA'
187500130204     C                   EVAL      AEEMPCD   = '3'
187600130204     C                   OTHER
187700130204     C     'RELCD ERR'   DSPLY     '*EXT'
187800130204     C                   SETON                                        H1
187900130204     C                   ENDSL
188000130204    ***
188100130204     C                   EVAL      AELNAM    = %TRIM(DLNAME)
188200130204     C                   EVAL      AEFNAM    = %TRIM(DFNAME)
188300130204     C                   EVAL      AEMNAM    = DMI
188400121213    ***
188500130305     C                   IF        DEPSS# <>0
188600130204     C                   EVAL      AESSN     = %EDITC(DEPSS#:'X')
188700130305     C                   ENDIF
188800130204    ***
188900121213     C                   IF        DADDR1 = ADDR1 OR %TRIM(DADDR1) = 'SAME'
189000121213      *
189100130305     C                   IF        %SUBST(ADDR1:1:1) <> 'X'
189200130204     C                   EVAL      AEADR1    = %TRIM(ADDR1)
189300130204     C                   EVAL      AEADR2    = %TRIM(ADDR2)
189400130204     C                   EVAL      AECITY    = %TRIM(CITY)
189500130204     C                   MOVE      *BLANKS       @9                9
189600130204     C                   EVAL      @9 = %EDITC(ZIP:'X')
189700130204     C                   EVAL      AEZIP     = %SUBST(@9:1:5)
189800130204     C                   EVAL      AESTATE   = STATE
189900130305     C                   EVAL      AECNTRY = 'US'
190000130305     C                   ENDIF
190100130305     C                   IF        AREA <> 0
190200130204     C                   EVAL      AEAREA    = %EDITC(AREA:'X')
190300130204     C                   EVAL      AEPHONE   = %EDITC(PHONE:'X')
190400130305     C                   ENDIF
190500130204     C                   ELSE
190600130305     C                   IF        %SUBST(DADDR1:1:1) <> 'X'
190700130204     C                   EVAL      AEADR1    = %TRIM(DADDR1)
190800130204     C                   EVAL      AEADR2    = %TRIM(DADDR2)
190900130204     C                   EVAL      AECITY    = %TRIM(DCITY)
191000130204     C                   MOVE      *BLANKS       @9                9
191100130204     C                   EVAL      @9 = %EDITC(DZIP:'X')
191200130204     C                   EVAL      AEZIP     = %SUBST(@9:1:5)
191300130204     C                   EVAL      AESTATE   = DSTATE
191400130305     C                   EVAL      AECNTRY = 'US'
191500130305     C                   ENDIF
191600130305     C                   IF        DAREA <> 0
191700130204     C                   EVAL      AEAREA    = %EDITC(DAREA:'X')
191800130204     C                   EVAL      AEPHONE   = %EDITC(DPHONE:'X')
191900130305     C                   ENDIF
192000130204     C                   ENDIF
192100130204     **
192200130204     C                   EVAL      AERT = 'ENR'
192300130204     C                   EVAL      AETRMRSN  = *BLANKS
192400130204     C                   EVAL      AEEFFDAT  = %CHAR(#TODAY)
192500130204    ***
192600130204     C                   EVAL      AEGENDER = DSEX
192700130204     C                   EVAL      AEDOB     = %EDITC(DBIRTH:'X')
192800130204    ***
192900130204     C                   EVAL      AEHIREDT  = %EDITC(EMPDT:'X')
193000130211     C                   EVAL      AEENROLL  = %EDITC(MBENRL:'X')
193100121213    ***
193200121213     C                   ENDSR
193300121213   S***S
193400121213     C     *INZSR        BEGSR
193500121213    ***
193600121213     C                   EVAL      #RECCNT = 0
193700121213    ***
193800121213     C     KL#ACCTL      KLIST
193900121213     C                   KFLD                    CARR#CTL
194000121213     C                   KFLD                    KF@TRS
194100121213     C                   KFLD                    KF@SUB
194200121213     C                   KFLD                    KF@ACC
194300121213    ***
194400130313     C     KL#QMBR       KLIST
194500130313     C                   KFLD                    CARR#CTL
194600130313     C                   KFLD                    KF@TRS
194700130313     C                   KFLD                    KF@SUB
194800130313     C                   KFLD                    KF@ACC
194900130313     C                   KFLD                    KF@SSN
195000130313     C                   KFLD                    KF@SEQ
195100130313    ***
195200121213     C     KL#AUX        KLIST
195300121213     C                   KFLD                    KF@TRS
195400121213     C                   KFLD                    KF@SUB
195500121213     C                   KFLD                    KF@ACC
195600121213     C                   KFLD                    KF@SSN
195700121213     C                   KFLD                    KF@SEQ
195800121213    ***
195900121213     C     KL#TSA        KLIST
196000121213     C                   KFLD                    KF@TRS
196100121213     C                   KFLD                    KF@SUB
196200121213     C                   KFLD                    KF@ACC
196300121213    ***
196400121213     C     KL#MPLN       KLIST
196500121213     C                   KFLD                    KF@SSN
196600121213     C                   KFLD                    KF@SEQ
196700121213     C                   KFLD                    KF@TRS
196800121213     C                   KFLD                    KF@SUB
196900121213     C                   KFLD                    KF@ACC
197000121213    ***
197100121213     C     KL#CPLN       KLIST
197200121213     C                   KFLD                    CARR#CTL
197300121213     C                   KFLD                    KF@TRS
197400121213     C                   KFLD                    KF@SUB
197500121213     C                   KFLD                    KF@ACC
197600121213     C                   KFLD                    KF@CCTR
197700121213     C                   KFLD                    KF@PLN
197800121213    ***
197900121213     C     KL#DCV        KLIST
198000121213     C                   KFLD                    KF@SSN
198100121213     C                   KFLD                    KF@SEQ
198200121213    ***
198300121213     C     KL#MTR        KLIST
198400121213     C                   KFLD                    KF@SSN
198500121213     C                   KFLD                    KF@SEQ
198600130211     C                   KFLD                    KF@TRM
198700121213     C                   KFLD                    KF@PLN
198800121213     C                   KFLD                    KF@ENR
198900121213     C                   KFLD                    KF@TRS
199000121213     C                   KFLD                    KF@SUB
199100121213     C                   KFLD                    KF@ACC
199200121213    ***
199300121213     C                   ENDSR
199400121213   S***S
199500121213   S***S
199600121213     C     $CLRSTG       BEGSR
199700130214    ***
199800130214     C                   CLEAR                   DS@AEB
199900130214     C                   EVAL      NDX = 0
200000130214     C                   CLEAR                   AE@@
200100121213    ***
200200121213     C                   EVAL      #CANCEL = 0
200300121213    ***
200400121213     C                   EVAL                    MED#CNE = 0
200500121213     C                   EVAL                    MED#NDX = 0
200600121213     C                   CLEAR                   MED@PLN
200700121213     C                   CLEAR                   MED@ENR
200800121213     C                   CLEAR                   MED@FRM
200900121213     C                   CLEAR                   MED@TRM
201000121213    ***
201100121213     C                   EVAL                    DEN#CNE = 0
201200121213     C                   EVAL                    DEN#NDX = 0
201300121213     C                   CLEAR                   DEN@PLN
201400121213     C                   CLEAR                   DEN@ENR
201500121213     C                   CLEAR                   DEN@FRM
201600121213     C                   CLEAR                   DEN@TRM
201700121213    ***
201800121213     C                   EVAL                    RXD#CNE = 0
201900121213     C                   EVAL                    RXD#NDX = 0
202000121213     C                   CLEAR                   RXD@PLN
202100121213     C                   CLEAR                   RXD@ENR
202200121213     C                   CLEAR                   RXD@FRM
202300121213     C                   CLEAR                   RXD@TRM
202400121213    ***
202500121213     C                   EVAL                    VIS#CNE = 0
202600121213     C                   EVAL                    VIS#NDX = 0
202700121213     C                   CLEAR                   VIS@PLN
202800121213     C                   CLEAR                   VIS@ENR
202900121213     C                   CLEAR                   VIS@FRM
203000121213     C                   CLEAR                   VIS@TRM
203100121213    ***
203200121213     C                   EVAL                    LTD#CNE = 0
203300121213     C                   EVAL                    LTD#NDX = 0
203400121213     C                   CLEAR                   LTD@PLN
203500121213     C                   CLEAR                   LTD@ENR
203600121213     C                   CLEAR                   LTD@VOL
203700121213     C                   CLEAR                   LTD@FRM
203800121213     C                   CLEAR                   LTD@TRM
203900121213    ***
204000121213     C                   EVAL                    STD#CNE = 0
204100121213     C                   EVAL                    STD#NDX = 0
204200121213     C                   CLEAR                   STD@PLN
204300121213     C                   CLEAR                   STD@ENR
204400121213     C                   CLEAR                   STD@VOL
204500121213     C                   CLEAR                   STD@FRM
204600121213     C                   CLEAR                   STD@TRM
204700121213    ***
204800121213     C                   EVAL                    LIF#CNE = 0
204900121213     C                   EVAL                    LIF#NDX = 0
205000121213     C                   CLEAR                   LIF@PLN
205100121213     C                   CLEAR                   LIF@ENR
205200121213     C                   CLEAR                   LIF@VOL
205300121213     C                   CLEAR                   LIF@FRM
205400121213     C                   CLEAR                   LIF@TRM
205500121213    ***
205600121213     C                   EVAL                    ADD#CNE = 0
205700121213     C                   EVAL                    ADD#NDX = 0
205800121213     C                   CLEAR                   ADD@PLN
205900121213     C                   CLEAR                   ADD@ENR
206000121213     C                   CLEAR                   ADD@VOL
206100121213     C                   CLEAR                   ADD@FRM
206200121213     C                   CLEAR                   ADD@TRM
206300121213    ***
206400121213     C                   EVAL                    DLF#CNE = 0
206500121213     C                   EVAL                    DLF#NDX = 0
206600121213     C                   CLEAR                   DLF@PLN
206700121213     C                   CLEAR                   DLF@ENR
206800121213     C                   CLEAR                   DLF@VOL
206900121213     C                   CLEAR                   DLF@FRM
207000121213     C                   CLEAR                   DLF@TRM
207100121213    ***
207200121213     C                   EVAL                    VLF#CNE = 0
207300121213     C                   EVAL                    VLF#NDX = 0
207400121213     C                   CLEAR                   VLF@PLN
207500121213     C                   CLEAR                   VLF@ENR
207600121213     C                   CLEAR                   VLF@VOL
207700121213     C                   CLEAR                   VLF@FRM
207800121213     C                   CLEAR                   VLF@TRM
207900121213    ***
208000121213     C                   EVAL                    VAD#CNE = 0
208100121213     C                   EVAL                    VAD#NDX = 0
208200121213     C                   CLEAR                   VAD@PLN
208300121213     C                   CLEAR                   VAD@ENR
208400121213     C                   CLEAR                   VAD@VOL
208500121213     C                   CLEAR                   VAD@FRM
208600121213     C                   CLEAR                   VAD@TRM
208700121213    ***
208800121213     C                   EVAL                    VLT#CNE = 0
208900121213     C                   EVAL                    VLT#NDX = 0
209000121213     C                   CLEAR                   VLT@PLN
209100121213     C                   CLEAR                   VLT@ENR
209200121213     C                   CLEAR                   VLT@VOL
209300121213     C                   CLEAR                   VLT@FRM
209400121213     C                   CLEAR                   VLT@TRM
209500121213    ***
209600121213     C                   EVAL                    CRI#CNE = 0
209700121213     C                   EVAL                    CRI#NDX = 0
209800121213     C                   CLEAR                   CRI@PLN
209900121213     C                   CLEAR                   CRI@ENR
210000121213     C                   CLEAR                   CRI@VOL
210100121213     C                   CLEAR                   CRI@FRM
210200121213     C                   CLEAR                   CRI@TRM
210300121213    ***
210400121213     C                   EVAL                    VCI#CNE = 0
210500121213     C                   EVAL                    VCI#NDX = 0
210600121213     C                   CLEAR                   VCI@PLN
210700121213     C                   CLEAR                   VCI@ENR
210800121213     C                   CLEAR                   VCI@VOL
210900121213     C                   CLEAR                   VCI@FRM
211000121213     C                   CLEAR                   VCI@TRM
211100121213    ***
211200130205     C                   EVAL                    ACC#CNE = 0
211300130205     C                   EVAL                    ACC#NDX = 0
211400130205     C                   CLEAR                   ACC@PLN
211500130205     C                   CLEAR                   ACC@ENR
211600130205     C                   CLEAR                   ACC@FRM
211700130205     C                   CLEAR                   ACC@TRM
211800130205    ***
211900130205     C                   EVAL                    CCR#CNE = 0
212000130205     C                   EVAL                    CCR#NDX = 0
212100130205     C                   CLEAR                   CCR@PLN
212200130205     C                   CLEAR                   CCR@ENR
212300130205     C                   CLEAR                   CCR@FRM
212400130205     C                   CLEAR                   CCR@TRM
212500130205    ***
212600121213     C                   ENDSR
212700121213   S***S
212800121213     C     $CHKHEM       BEGSR
212900121213    ***
213000121213     C                   IF        MED#CNE > 0 AND MED@TRM(MED#CNE) <> 99999999
213100121213     C                   EXSR      $CHKMED
213200121213     C                   ENDIF
213300121213    ***
213400121213     C                   IF        DEN#CNE > 0 AND DEN@TRM(DEN#CNE) <> 99999999
213500121213     C                   EXSR      $CHKDEN
213600121213     C                   ENDIF
213700121213    ***
213800121213     C                   IF        RXD#CNE > 0 AND RXD@TRM(RXD#CNE) <> 99999999
213900121213     C                   EXSR      $CHKRXD
214000121213     C                   ENDIF
214100121213    ***
214200121213     C                   IF        VIS#CNE > 0 AND VIS@TRM(VIS#CNE) <> 99999999
214300121213     C                   EXSR      $CHKVIS
214400121213     C                   ENDIF
214500121213    ***
214600121213     C                   IF        LTD#CNE > 0 AND LTD@TRM(LTD#CNE) <> 99999999
214700121213     C                   EXSR      $CHKLTD
214800121213     C                   ENDIF
214900121213    ***
215000121213     C                   IF        STD#CNE > 0 AND STD@TRM(STD#CNE) <> 99999999
215100121213     C                   EXSR      $CHKSTD
215200121213     C                   ENDIF
215300121213    ***
215400121213     C                   IF        VCI#CNE > 0 AND VCI@TRM(VCI#CNE) <> 99999999
215500121213     C                   EXSR      $CHKVCI
215600121213     C                   ENDIF
215700121213    ***
215800121213     C                   IF        LIF#CNE > 0 AND LIF@TRM(LIF#CNE) <> 99999999
215900121213     C                   EXSR      $CHKLIF
216000121213     C                   ENDIF
216100121213    ***
216200121213     C                   IF        ADD#CNE > 0 AND ADD@TRM(ADD#CNE) <> 99999999
216300121213     C                   EXSR      $CHKADD
216400121213     C                   ENDIF
216500121213    ***
216600121213     C                   IF        DLF#CNE > 0 AND DLF@TRM(DLF#CNE) <> 99999999
216700121213     C                   EXSR      $CHKDLF
216800121213     C                   ENDIF
216900121213    ***
217000121213     C                   IF        VLF#CNE > 0 AND VLF@TRM(VLF#CNE) <> 99999999
217100121213     C                   EXSR      $CHKVLF
217200121213     C                   ENDIF
217300121213    ***
217400121213     C                   IF        VAD#CNE > 0 AND VAD@TRM(VAD#CNE) <> 99999999
217500121213     C                   EXSR      $CHKVAD
217600121213     C                   ENDIF
217700121213    ***
217800121213     C                   IF        VLT#CNE > 0 AND VLT@TRM(VLT#CNE) <> 99999999
217900121213     C                   EXSR      $CHKVLT
218000121213     C                   ENDIF
218100121213    ***
218200121213     C                   IF        CRI#CNE > 0 AND CRI@TRM(CRI#CNE) <> 99999999
218300121213     C                   EXSR      $CHKCRI
218400121213     C                   ENDIF
218500121213    ***
218600130204     C                   IF        ACC#CNE > 0 AND ACC@TRM(ACC#CNE) <> 99999999
218700130204     C                   EXSR      $CHKACC
218800130204     C                   ENDIF
218900130204    ***
219000130204     C                   IF        CCR#CNE > 0 AND CCR@TRM(CCR#CNE) <> 99999999
219100130204     C                   EXSR      $CHKCCR
219200130204     C                   ENDIF
219300130204    ***
219400121213     C                   ENDSR
219500121213   S***S
219600121213      * CHECK FOR MEDICAL TERMINATION
219700121213    *C     $CHKMED       BEGSR
219800121213    ***
219900121213    *C                   EVAL      TERM_MED = YES
220000130211    *C                   EVAL      KF@TRM = MED@TRM(MED#CNE)
220100121213    *C                   EVAL      KF@PLN = MED@PLN(MED#CNE)
220200121213    *C                   EVAL      KF@ENR = MED@ENR(MED#CNE)
220300121213    ***
220400130204    *C     KL#MTR        CHAIN     AEB004F
220500130204    *C                   IF        %FOUND(AEB004WF)
220600130204     C                   IF        NTCOUNT > 1
220700121213    *C                   EVAL      MED#CNE = 0
220800121213    *C                   EVAL      TERM_MED = NO
220900130204     C                   ELSE
221000130204     C                   ADD       1             NTCOUNT
221100130212     C                   EVAL      NTTRANSD2      = #TODAY
221200130204     C                   UPDATE    AEB004F
221300130204     C                   ENDIF
221400130606     C                   LEAVESR
221500121213    *C                   ENDIF
221600121213    ***
221700121213     C                   EXSR      $WRTERM
221800121213    ***
221900121213    *C                   ENDSR
222000121213   S***S
222100121213    *C     $WRTERM       BEGSR
222200121213    ***
222300130204    *C                   CLEAR                   AEB004F
222400121213     C                   EVAL      NTSSNO         = KF@SSN
222500121213     C                   EVAL      NTDEPNO        = KF@SEQ
222600130211     C                   EVAL      NTTERMDT       = KF@TRM
222700121213     C                   EVAL      NTPLAN         = KF@PLN
222800121213     C                   EVAL      NTCOVTP        = KF@ENR
222900121213     C                   EVAL      NTTRST         = KF@TRS
223000121213     C                   EVAL      NTSUB#         = KF@SUB
223100121213     C                   EVAL      NTACCT         = KF@ACC
223200121213     C                   EVAL      NTTRANSDT      = #TODAY
223300130204     C                   EVAL      NTCOUNT = 1
223400130204     C                   WRITE     AEB004F
223500121213    ***
223600121213    *C                   ENDSR
223700121213   S***S
223800121213      * CHECK FOR DENTAL TERMINATION
223900121213    *C     $CHKDEN       BEGSR
224000121213    ***
224100121213    *C                   EVAL      TERM_DEN = YES
224200130211    *C                   EVAL      KF@TRM = DEN@TRM(DEN#CNE)
224300121213    *C                   EVAL      KF@PLN = DEN@PLN(DEN#CNE)
224400121213    *C                   EVAL      KF@ENR = DEN@ENR(DEN#CNE)
224500121213    ***
224600130204    *C     KL#MTR        CHAIN     AEB004F
224700130204    *C                   IF        %FOUND(AEB004WF)
224800130204     C                   IF        NTCOUNT > 1
224900130204    *C                   EVAL      DEN#CNE = 0
225000130204    *C                   EVAL      TERM_DEN = NO
225100130204     C                   ELSE
225200130204     C                   ADD       1             NTCOUNT
225300130212     C                   EVAL      NTTRANSD2      = #TODAY
225400130204     C                   UPDATE    AEB004F
225500130204     C                   ENDIF
225600130606     C                   LEAVESR
225700121213    *C                   ENDIF
225800121213    ***
225900121213     C                   EXSR      $WRTERM
226000121213    ***
226100121213    *C                   ENDSR
226200121213   S***S
226300121213      * CHECK FOR DRUG TERMINATION
226400121213    *C     $CHKRXD       BEGSR
226500121213    ***
226600121213    *C                   EVAL      TERM_RXD = YES
226700130211    *C                   EVAL      KF@TRM = RXD@TRM(RXD#CNE)
226800121213    *C                   EVAL      KF@PLN = RXD@PLN(RXD#CNE)
226900121213    *C                   EVAL      KF@ENR = RXD@ENR(RXD#CNE)
227000121213    ***
227100130204    *C     KL#MTR        CHAIN     AEB004F
227200130204    *C                   IF        %FOUND(AEB004WF)
227300130204     C                   IF        NTCOUNT > 1
227400130204    *C                   EVAL      RXD#CNE = 0
227500130204    *C                   EVAL      TERM_RXD = NO
227600130204     C                   ELSE
227700130204     C                   ADD       1             NTCOUNT
227800130212     C                   EVAL      NTTRANSD2      = #TODAY
227900130204     C                   UPDATE    AEB004F
228000130204     C                   ENDIF
228100130606     C                   LEAVESR
228200121213    *C                   ENDIF
228300121213    ***
228400121213     C                   EXSR      $WRTERM
228500121213    ***
228600121213    *C                   ENDSR
228700121213   S***S
228800121213      * CHECK FOR VISION TERMINATION
228900121213    *C     $CHKVIS       BEGSR
229000121213    ***
229100121213    *C                   EVAL      TERM_VIS = YES
229200130211    *C                   EVAL      KF@TRM = VIS@TRM(VIS#CNE)
229300121213    *C                   EVAL      KF@PLN = VIS@PLN(VIS#CNE)
229400121213    *C                   EVAL      KF@ENR = VIS@ENR(VIS#CNE)
229500121213    ***
229600130204    *C     KL#MTR        CHAIN     AEB004F
229700130204    *C                   IF        %FOUND(AEB004WF)
229800130204     C                   IF        NTCOUNT > 1
229900130204    *C                   EVAL      VIS#CNE = 0
230000130204    *C                   EVAL      TERM_VIS = NO
230100130204     C                   ELSE
230200130204     C                   ADD       1             NTCOUNT
230300130212     C                   EVAL      NTTRANSD2      = #TODAY
230400130204     C                   UPDATE    AEB004F
230500130204     C                   ENDIF
230600130606     C                   LEAVESR
230700121213    *C                   ENDIF
230800121213    ***
230900121213     C                   EXSR      $WRTERM
231000121213    ***
231100121213    *C                   ENDSR
231200121213   S***S
231300121213      * CHECK FOR LTD TERMINATION
231400121213    *C     $CHKLTD       BEGSR
231500121213    ***
231600121213    *C                   EVAL      TERM_LTD = YES
231700130211    *C                   EVAL      KF@TRM = LTD@TRM(LTD#CNE)
231800121213    *C                   EVAL      KF@PLN = LTD@PLN(LTD#CNE)
231900121213    *C                   EVAL      KF@ENR = LTD@ENR(LTD#CNE)
232000121213    ***
232100130204    *C     KL#MTR        CHAIN     AEB004F
232200130204    *C                   IF        %FOUND(AEB004WF)
232300130204     C                   IF        NTCOUNT > 1
232400130204    *C                   EVAL      LTD#CNE = 0
232500130204    *C                   EVAL      TERM_LTD = NO
232600130204     C                   ELSE
232700130204     C                   ADD       1             NTCOUNT
232800130212     C                   EVAL      NTTRANSD2      = #TODAY
232900130204     C                   UPDATE    AEB004F
233000130204     C                   ENDIF
233100130606     C                   LEAVESR
233200121213    *C                   ENDIF
233300121213    ***
233400121213     C                   EXSR      $WRTERM
233500121213    ***
233600121213    *C                   ENDSR
233700121213   S***S
233800121213      * CHECK FOR STD TERMINATION
233900121213    *C     $CHKSTD       BEGSR
234000121213    ***
234100121213    *C                   EVAL      TERM_STD = YES
234200130211    *C                   EVAL      KF@TRM = STD@TRM(STD#CNE)
234300121213    *C                   EVAL      KF@PLN = STD@PLN(STD#CNE)
234400121213    *C                   EVAL      KF@ENR = STD@ENR(STD#CNE)
234500121213    ***
234600130204    *C     KL#MTR        CHAIN     AEB004F
234700130204    *C                   IF        %FOUND(AEB004WF)
234800130204     C                   IF        NTCOUNT > 1
234900130204    *C                   EVAL      STD#CNE = 0
235000130204    *C                   EVAL      TERM_STD = NO
235100130204     C                   ELSE
235200130204     C                   ADD       1             NTCOUNT
235300130212     C                   EVAL      NTTRANSD2      = #TODAY
235400130204     C                   UPDATE    AEB004F
235500130204     C                   ENDIF
235600130606     C                   LEAVESR
235700121213    *C                   ENDIF
235800121213    ***
235900121213     C                   EXSR      $WRTERM
236000121213    ***
236100121213    *C                   ENDSR
236200121213   S***S
236300121213      * CHECK FOR LIFE TERMINATION
236400121213    *C     $CHKLIF       BEGSR
236500121213    ***
236600121213    *C                   EVAL      TERM_LIF = YES
236700130211    *C                   EVAL      KF@TRM = LIF@TRM(LIF#CNE)
236800121213    *C                   EVAL      KF@PLN = LIF@PLN(LIF#CNE)
236900121213    *C                   EVAL      KF@ENR = LIF@ENR(LIF#CNE)
237000121213    ***
237100130204    *C     KL#MTR        CHAIN     AEB004F
237200130204    *C                   IF        %FOUND(AEB004WF)
237300130204     C                   IF        NTCOUNT > 1
237400130204    *C                   EVAL      LIF#CNE = 0
237500130204    *C                   EVAL      TERM_LIF = NO
237600130204     C                   ELSE
237700130204     C                   ADD       1             NTCOUNT
237800130212     C                   EVAL      NTTRANSD2      = #TODAY
237900130204     C                   UPDATE    AEB004F
238000130204     C                   ENDIF
238100130606     C                   LEAVESR
238200121213    *C                   ENDIF
238300121213    ***
238400121213     C                   EXSR      $WRTERM
238500121213    ***
238600121213    *C                   ENDSR
238700121213   S***S
238800121213      * CHECK FOR AD&D TERMINATION
238900121213    *C     $CHKADD       BEGSR
239000121213    ***
239100121213    *C                   EVAL      TERM_ADD = YES
239200130211    *C                   EVAL      KF@TRM = ADD@TRM(ADD#CNE)
239300121213    *C                   EVAL      KF@PLN = ADD@PLN(ADD#CNE)
239400121213    *C                   EVAL      KF@ENR = ADD@ENR(ADD#CNE)
239500121213    ***
239600130204    *C     KL#MTR        CHAIN     AEB004F
239700130204    *C                   IF        %FOUND(AEB004WF)
239800130204     C                   IF        NTCOUNT > 1
239900130204    *C                   EVAL      ADD#CNE = 0
240000130204    *C                   EVAL      TERM_ADD = NO
240100130204     C                   ELSE
240200130204     C                   ADD       1             NTCOUNT
240300130212     C                   EVAL      NTTRANSD2      = #TODAY
240400130204     C                   UPDATE    AEB004F
240500130204     C                   ENDIF
240600130606     C                   LEAVESR
240700121213    *C                   ENDIF
240800121213    ***
240900121213     C                   EXSR      $WRTERM
241000121213    ***
241100121213    *C                   ENDSR
241200121213   S***S
241300121213      * CHECK FOR DEPENDENT LIFE TERMINATION
241400121213    *C     $CHKDLF       BEGSR
241500121213    ***
241600121213    *C                   EVAL      TERM_DLF = YES
241700130211    *C                   EVAL      KF@TRM = DLF@TRM(DLF#CNE)
241800121213    *C                   EVAL      KF@PLN = DLF@PLN(DLF#CNE)
241900121213    *C                   EVAL      KF@ENR = DLF@ENR(DLF#CNE)
242000121213    ***
242100130204    *C     KL#MTR        CHAIN     AEB004F
242200130204    *C                   IF        %FOUND(AEB004WF)
242300130204     C                   IF        NTCOUNT > 1
242400130204    *C                   EVAL      DLF#CNE = 0
242500130204    *C                   EVAL      TERM_DLF = NO
242600130204     C                   ELSE
242700130204     C                   ADD       1             NTCOUNT
242800130212     C                   EVAL      NTTRANSD2      = #TODAY
242900130204     C                   UPDATE    AEB004F
243000130204     C                   ENDIF
243100130606     C                   LEAVESR
243200121213    *C                   ENDIF
243300121213    ***
243400121213     C                   EXSR      $WRTERM
243500121213    ***
243600121213    *C                   ENDSR
243700121213   S***S
243800121213      * CHECK FOR VOLUNATRY LIFE TERMINATION
243900121213    *C     $CHKVLF       BEGSR
244000121213    ***
244100121213    *C                   EVAL      TERM_VLF = YES
244200130211    *C                   EVAL      KF@TRM = VLF@TRM(VLF#CNE)
244300121213    *C                   EVAL      KF@PLN = VLF@PLN(VLF#CNE)
244400121213    *C                   EVAL      KF@ENR = VLF@ENR(VLF#CNE)
244500121213    ***
244600130204    *C     KL#MTR        CHAIN     AEB004F
244700130204    *C                   IF        %FOUND(AEB004WF)
244800130204     C                   IF        NTCOUNT > 1
244900130204    *C                   EVAL      VLF#CNE = 0
245000130204    *C                   EVAL      TERM_VLF = NO
245100130204     C                   ELSE
245200130204     C                   ADD       1             NTCOUNT
245300130212     C                   EVAL      NTTRANSD2      = #TODAY
245400130204     C                   UPDATE    AEB004F
245500130204     C                   ENDIF
245600130606     C                   LEAVESR
245700121213    *C                   ENDIF
245800121213    ***
245900121213     C                   EXSR      $WRTERM
246000121213    ***
246100121213    *C                   ENDSR
246200121213   S***S
246300121213      * CHECK FOR VOLUNATRY AD&D TERMINATION
246400121213    *C     $CHKVAD       BEGSR
246500121213    ***
246600121213    *C                   EVAL      TERM_VAD = YES
246700130211    *C                   EVAL      KF@TRM = VAD@TRM(VAD#CNE)
246800121213    *C                   EVAL      KF@PLN = VAD@PLN(VAD#CNE)
246900121213    *C                   EVAL      KF@ENR = VAD@ENR(VAD#CNE)
247000121213    ***
247100130204    *C     KL#MTR        CHAIN     AEB004F
247200130204    *C                   IF        %FOUND(AEB004WF)
247300130204     C                   IF        NTCOUNT > 1
247400130204    *C                   EVAL      VAD#CNE = 0
247500130204    *C                   EVAL      TERM_VAD = NO
247600130204     C                   ELSE
247700130204     C                   ADD       1             NTCOUNT
247800130212     C                   EVAL      NTTRANSD2      = #TODAY
247900130204     C                   UPDATE    AEB004F
248000130204     C                   ENDIF
248100130606     C                   LEAVESR
248200121213    *C                   ENDIF
248300121213    ***
248400121213     C                   EXSR      $WRTERM
248500121213    ***
248600121213    *C                   ENDSR
248700121213   S***S
248800121213      * CHECK FOR VOLUNATRY LTD TERMINATION
248900121213    *C     $CHKVLT       BEGSR
249000121213    ***
249100121213    *C                   EVAL      TERM_VLT = YES
249200130211    *C                   EVAL      KF@TRM = VLT@TRM(VLT#CNE)
249300121213    *C                   EVAL      KF@PLN = VLT@PLN(VLT#CNE)
249400121213    *C                   EVAL      KF@ENR = VLT@ENR(VLT#CNE)
249500121213    ***
249600130204    *C     KL#MTR        CHAIN     AEB004F
249700130204    *C                   IF        %FOUND(AEB004WF)
249800130204     C                   IF        NTCOUNT > 1
249900130204    *C                   EVAL      VLT#CNE = 0
250000130204    *C                   EVAL      TERM_VLT = NO
250100130204     C                   ELSE
250200130204     C                   ADD       1             NTCOUNT
250300130212     C                   EVAL      NTTRANSD2      = #TODAY
250400130204     C                   UPDATE    AEB004F
250500130204     C                   ENDIF
250600130606     C                   LEAVESR
250700121213    *C                   ENDIF
250800121213    ***
250900121213     C                   EXSR      $WRTERM
251000121213    ***
251100121213    *C                   ENDSR
251200121213   S***S
251300121213      * CHECK FOR CRITICAL ILLNESS TERMINATION
251400121213    *C     $CHKCRI       BEGSR
251500121213    ***
251600121213    *C                   EVAL      TERM_CRI = YES
251700130211    *C                   EVAL      KF@TRM = CRI@TRM(CRI#CNE)
251800121213    *C                   EVAL      KF@PLN = CRI@PLN(CRI#CNE)
251900121213    *C                   EVAL      KF@ENR = CRI@ENR(CRI#CNE)
252000121213    ***
252100130204    *C     KL#MTR        CHAIN     AEB004F
252200130204    *C                   IF        %FOUND(AEB004WF)
252300130204     C                   IF        NTCOUNT > 1
252400130204    *C                   EVAL      CRI#CNE = 0
252500130204    *C                   EVAL      TERM_CRI = NO
252600130204     C                   ELSE
252700130204     C                   ADD       1             NTCOUNT
252800130212     C                   EVAL      NTTRANSD2      = #TODAY
252900130204     C                   UPDATE    AEB004F
253000130204     C                   ENDIF
253100130606     C                   LEAVESR
253200121213    *C                   ENDIF
253300121213    ***
253400121213     C                   EXSR      $WRTERM
253500121213    ***
253600121213    *C                   ENDSR
253700121213   S***S
253800121213      * CHECK FOR VOLUNATRY CRITICAL ILLNESS TERMINATION
253900121213    *C     $CHKVCI       BEGSR
254000121213    ***
254100121213    *C                   EVAL      TERM_VCI = YES
254200130211    *C                   EVAL      KF@TRM = VCI@TRM(VCI#CNE)
254300121213    *C                   EVAL      KF@PLN = VCI@PLN(VCI#CNE)
254400121213    *C                   EVAL      KF@ENR = VCI@ENR(VCI#CNE)
254500121213    ***
254600130204    *C     KL#MTR        CHAIN     AEB004F
254700130204    *C                   IF        %FOUND(AEB004WF)
254800130204     C                   IF        NTCOUNT > 1
254900130204    *C                   EVAL      VCI#CNE = 0
255000130204    *C                   EVAL      TERM_VCI = NO
255100130204     C                   ELSE
255200130204     C                   ADD       1             NTCOUNT
255300130212     C                   EVAL      NTTRANSD2      = #TODAY
255400130204     C                   UPDATE    AEB004F
255500130204     C                   ENDIF
255600130606     C                   LEAVESR
255700121213    *C                   ENDIF
255800121213    ***
255900121213     C                   EXSR      $WRTERM
256000121213    ***
256100121213    *C                   ENDSR
256200121213   S***S
256300130204      * CHECK FOR ACCIDENT COVERAGE TERMINATION
256400130204    *C     $CHKACC       BEGSR
256500130204    ***
256600130204    *C                   EVAL      TERM_ACC = YES
256700130211    *C                   EVAL      KF@TRM = ACC@TRM(ACC#CNE)
256800130204    *C                   EVAL      KF@PLN = ACC@PLN(ACC#CNE)
256900130204    *C                   EVAL      KF@ENR = ACC@ENR(ACC#CNE)
257000130204    ***
257100130204    *C     KL#MTR        CHAIN     AEB004F
257200130204    *C                   IF        %FOUND(AEB004WF)
257300130204     C                   IF        NTCOUNT > 1
257400130204    *C                   EVAL      ACC#CNE = 0
257500130204    *C                   EVAL      TERM_ACC = NO
257600130204     C                   ELSE
257700130204     C                   ADD       1             NTCOUNT
257800130212     C                   EVAL      NTTRANSD2      = #TODAY
257900130204     C                   UPDATE    AEB004F
258000130204     C                   ENDIF
258100130606     C                   LEAVESR
258200130204    *C                   ENDIF
258300130204    ***
258400130204     C                   EXSR      $WRTERM
258500130204    ***
258600130204    *C                   ENDSR
258700130204   S***S
258800130204      * CHECK FOR CANCER COVERAGE TERMINATION
258900130204    *C     $CHKCCR       BEGSR
259000130204    ***
259100130204    *C                   EVAL      TERM_CCR = YES
259200130211    *C                   EVAL      KF@TRM = CCR@TRM(CCR#CNE)
259300130204    *C                   EVAL      KF@PLN = CCR@PLN(CCR#CNE)
259400130204    *C                   EVAL      KF@ENR = CCR@ENR(CCR#CNE)
259500130204    ***
259600130204    *C     KL#MTR        CHAIN     AEB004F
259700130204    *C                   IF        %FOUND(AEB004WF)
259800130204     C                   IF        NTCOUNT > 1
259900130204    *C                   EVAL      CCR#CNE = 0
260000130204    *C                   EVAL      TERM_CCR = NO
260100130204     C                   ELSE
260200130204     C                   ADD       1             NTCOUNT
260300130212     C                   EVAL      NTTRANSD2      = #TODAY
260400130204     C                   UPDATE    AEB004F
260500130204     C                   ENDIF
260600130606     C                   LEAVESR
260700130204    *C                   ENDIF
260800130204    ***
260900130204     C                   EXSR      $WRTERM
261000130204    ***
261100130204    *C                   ENDSR
261200130204   S***S
261300121213     C     $PLANSRCH     BEGSR
261400121213    ***
261500121213     C                   MOVE      *BLANKS       PLN@CAT          10
261600121213     C                   EVAL      PP# = 0
261700121213     C                   CLEAR                   DS@CARPLN
261800121213    ***
261900121213     C                   DO        PC#
262000121213    * *
262100121213     C                   ADD       1             PP#
262200121213     C     PP#           OCCUR     CARPLN@
262300121213    * *
262400121213     C                   IF        XPPLAN = @PLANIN AND
262500121213     C                             XPCCTR = @CCTRIN
262600121213     C                   EVAL      DS@CARPLN = CARPLN@
262700130211     C                   EVAL      PLN@CAT = %TRIM(XPCID3)
262800121213     C                   LEAVE
262900121213     C                   ENDIF
263000121213    * *
263100121213     C                   ENDDO
263200121213    ***
263300121213     C                   ENDSR
263400130205   S***S
263500130313     OT100      EADD         OUTF
263600130313     O                       REPRT          B   100
