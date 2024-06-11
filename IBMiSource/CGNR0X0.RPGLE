000100120619   X***X CARRIER CONTROL ID #0000000000 CIGNA SPECIFIC
000200120619   X***X SSK 06.19.2012 TEMPLATE DESIGN
000300120619   X***X
000400120619   X***X MM.DD.YYYY CLONED FROM CGNR0X0
000500120619   X***X MM.DD.YYYY CIGNA APPROVED FOR PRODUCTION
000600120619   X***X
000700120619   X***X
000800120619   X***X ACCOUNTS SET-UP
000900120619   X***X TTT-SSS-AAAA  X
001000120619   X***X
001100120619   X***X
001200120619   X***X
001300120619   X***X
001400120619   X***X
001500120619     FCARXPTP   IF   E           K DISK
001600120619     FCARACCP   IF   E           K DISK
001700120619     FCARPLNP   IF   E           K DISK
001800120619   X***X
001900120622     F*GNW011   O  A F  750        DISK
002000120622     F*GNW014   O  A F  900        DISK
002100120622     F*GNW015   O  A F 1050        DISK
002200120622     F*GNW016   O  A F 1200        DISK
002300120619     ** FLAT FILE
002400120621     FCGNW010   IF A E           K DISK
002500120621     ** WORK FILE
002600120619     FCGNW012   IF A E           K DISK
002700120619     ** TERM TRACKER
002800120619     **
002900120619     FMEMAC#1   IF   E           K DISK
003000120619     FMCOVMPLN  IF   E           K DISK
003100120619     FDEPNDC    IF   E           K DISK
003200120621     FELIGDCOV  IF   E           K DISK
003300120621     F*PCP       IF   E           K DISK
003400120619   X***X
003500120619     D CARR#CTL        S             10A   INZ('0000000000')
003600120619   X***X
003700120619     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
003800120619     D DS@CARACC     E DS                  EXTNAME(CARACCP)
003900120619     D DS@CARXPT     E DS                  EXTNAME(CARXPTP)
004000120619   X***X
004100120619     ** WORK ARRAY FOR PLANS
004200120619     **
004300120619     ** PC# - PLAN COUNT
004400120619     ** PP# - PLAN POINTER
004500120619     **
004600120619     D CARPLN@       E DS                  EXTNAME(CARPLNP)
004700120619     D                                     OCCURS(60) PREFIX(X:1)
004800120619     D PC#             S              3S 0
004900120619     D PP#             S              3S 0
005000120619     D @PLANIN         S              4A
005100120619     D #EFFDTE         S              8S 0
005200120619     D #BENAMT         S                   LIKE(BENAMT)
005300120619     D @CCTRIN         S              3A
005400120619     D @ENRIN          S              3A
005500120619     D @ENROU          S              3A
005600120621     D @3              S              3A
005700120619   X***X
005800120619     D C11@10          S             10A
005900120619     D C11@01          S              1A
006000120619     **
006100120619     ** WRITE TYPE = MEMBER OR DEPEND
006200120619     D WRT@TYPE        S              6A
006300120619     **
006400120619   X***X
006500120619     D #DATE           S              8S 0
006600120619     D #10             S             10S 0
006700120619     D #11             S             11S 0
006800120619     D #7S0            S              7S 0 INZ
006900120619     D #11S0           S             11S 0 INZ
007000120619     D #12             S             12S 0
007100120619     D #XST            S              6S 0
007200120619     D #IST            S               T
007300120619     D #ISO            S               D   DATFMT(*ISO)
007400120619     D #MINUEND        S               D   DATFMT(*ISO)
007500120619     D #SUBTRAEND      S               D   DATFMT(*ISO)
007600120619     D #DIFFRNC        S              5S 0
007700120619     D #2S0            S              2S 0
007800120619     D #CANCEL         S              8S 0
007900120619     D #XSX            S              8S 0
008000120619     D #XSX2           S              8S 0
008100120619     D DATE@OUT        S             10A
008200120619     D DNTLATE         S              1A
008300120619     D TERM_MED        S               N
008400120619     D TERM_DEN        S               N
008500120619     D TERM_RXD        S               N
008600120619     D TERM_VIS        S               N
008700120619     D YES             S               N   INZ(*ON)
008800120619     D NO              S               N   INZ(*OFF)
008900120619     D KF@TRS          S                   LIKE(MCTRST)
009000120619     D KF@SUB          S                   LIKE(MCSUB#)
009100120619     D KF@ACC          S                   LIKE(ACC#)
009200120619     D KF@ENR          S              3A   INZ
009300120619     D KF@CARG         S              2A   INZ
009400120619     D KF@CCTR         S                   LIKE(CCFLG)
009500120619     D KF@PLN          S                   LIKE(MCPLAN)
009600120619     D KF@TRM          S                   LIKE(NTTERMDT)
009700120619     D KF#TRM          S              8S 0
009800120619     D KF@SSN          S                   LIKE(MBSSNO)
009900120619     D KF@SEQ          S                   LIKE(DPSEQ#)
010000120619     D KF@TYP          S              1A
010100120619     D KF@CDE          S              2A
010200120619     D M@EARLYP        S              4A
010300120619     D M#EARLYE        S              8S 0 INZ
010400120619     D M#EARLYT        S              8S 0 INZ
010500120619     D KF@MPLN         S              4A
010600120619     D #8D1            S              8S 0 INZ
010700120619    ***
010800120619     D #RECCNT         S             10S 0 INZ
010900120619    ***
011000120619    *** MEDICAL ARRAYS
011100120619    *** CAT: PMM, PDM, PSM
011200120619     D MED#CNE         S              3S 0 INZ
011300120619     D MED#NDX         S              3S 0 INZ
011400120619     D MED@PLN         S              4A   DIM(20)
011500120619     D MED@ENR         S              3A   DIM(20)
011600120619     D MED@FRM         S              8S 0 DIM(20)
011700120619     D MED@TRM         S              8S 0 DIM(20)
011800120619     D*MED@MEFF        S              8S 0
011900120619    ***
012000120619    *** DENTAL ARRAYS
012100120619    *** CAT: PDN, PDE, PDR
012200120619     D DEN#CNE         S              3S 0 INZ
012300120619     D DEN#NDX         S              3S 0 INZ
012400120619     D DEN@PLN         S              4A   DIM(20)
012500120619     D DEN@ENR         S              3A   DIM(20)
012600120619     D DEN@FRM         S              8S 0 DIM(20)
012700120619     D DEN@TRM         S              8S 0 DIM(20)
012800120619     D*DEN@MEFF        S              8S 0
012900120619    ***
013000120619    *** PRESCRIPTION DRUG ARRAYS
013100120619    *** CAT: PRX
013200120619     D RXD#CNE         S              3S 0 INZ
013300120619     D RXD#NDX         S              3S 0 INZ
013400120619     D RXD@PLN         S              4A   DIM(20)
013500120619     D RXD@ENR         S              3A   DIM(20)
013600120619     D RXD@FRM         S              8S 0 DIM(20)
013700120619     D RXD@TRM         S              8S 0 DIM(20)
013800120619     D*RXD@MEFF        S              8S 0
013900120619    ***
014000120619    *** VISION         ARRAYS
014100120619    *** CAT: PVS, PVR
014200120619     D VIS#CNE         S              3S 0 INZ
014300120619     D VIS#NDX         S              3S 0 INZ
014400120619     D VIS@PLN         S              4A   DIM(20)
014500120619     D VIS@ENR         S              3A   DIM(20)
014600120619     D VIS@FRM         S              8S 0 DIM(20)
014700120619     D VIS@TRM         S              8S 0 DIM(20)
014800120619     D*VIS@MEFF        S              8S 0
014900120619    ***
015000120621    *** SEGMENT BREAKDOWN
015100120619    ***
015200120621     *** MEDICAL
015300120621     **
015400120621     D DS@MEDICAL      DS
015500120621     D  MED@DS                 1    150A
015600120621     D  MEACNU               001    007A
015700120621     D  MEBRCO               008    013A
015800120621     D  MEBEOP               014    018A
015900120621     D  MEEFFD               019    026A
016000120621     D  METRMD               027    034A
016100120621     D  MEMEMBER             035    035A
016200120621     D  MESPOUSE             036    036A
016300120621     D  MECHILD              037    037A
016400120622     D  MECOLLAT             038    038A
016500120622     D  F900                 039    039A
016600120621     D  MECBREF              040    047A
016700120621     D  MECBRTR              048    055A
016800120621     D  F901                 056    069A
016900120621     D  MEHMOCOD             070    072A
017000120621     D  MENETID              073    077A
017100120621     D  MEPCPID              078    087A
017200120621     D  MEPI                 088    088A
017300120621     D  MEPHNED              089    096A
017400120621     D  MEPCLED              097    104A
017500120621     D  F902                 105    150A
017600120621     **
017700120621     *** DENTAL
017800120621     **
017900120621     D DS@DENTAL       DS
018000120621     D  DEN@DS                 1    150A
018100120621     D  DNACNU               001    007A
018200120621     D  DNBRCO               008    013A
018300120621     D  DNBEOP               014    018A
018400120621     D  DNEFFD               019    026A
018500120621     D  DNTRMD               027    034A
018600120621     D  DNMEMBER             035    035A
018700120621     D  DNSPOUSE             036    036A
018800120621     D  DNCHILD              037    037A
018900120622     D  DNCOLLAT             038    038A
019000120622     D  F903                 039    039A
019100120621     D  DNCBREF              040    047A
019200120621     D  DNCBRTR              048    055A
019300120621     D  F904                 056    069A
019400120621     D  DNOFFID              070    075A
019500120621     D  F905                 076    081A
019600120621     D  DNOFNED              082    089A
019700120621     D  DNESTPI              090    090A
019800120621     D  F906                 091    150A
019900120621     **
020000120621     *** VISION
020100120621     **
020200120621     D DS@VISION       DS
020300120621     D  VIS@DS                 1    150A
020400120621     D  VSACNU               001    007A
020500120621     D  VSBRCO               008    013A
020600120621     D  VSBEOP               014    018A
020700120621     D  VSEFFD               019    026A
020800120621     D  VSTRMD               027    034A
020900120621     D  VSMEMBER             035    035A
021000120621     D  VSSPOUSE             036    036A
021100120621     D  VSCHILD              037    037A
021200120622     D  VSCOLLAT             038    038A
021300120622     D  F907                 039    039A
021400120621     D  VSCBREF              040    047A
021500120621     D  VSCBRTR              048    055A
021600120621     D  F908                 056    150A
021700120621     **
021800120621     *** PHARMACY
021900120621     **
022000120621     D DS@DRUG         DS
022100120621     D  RXD@DS                 1    150A
022200120621     D  RXACNU               001    007A
022300120621     D  RXBRCO               008    013A
022400120621     D  RXBEOP               014    018A
022500120621     D  RXEFFD               019    026A
022600120621     D  RXTRMD               027    034A
022700120621     D  RXMEMBER             035    035A
022800120621     D  RXSPOUSE             036    036A
022900120621     D  RXCHILD              037    037A
023000120622     D  RXCOLLAT             038    038A
023100120622     D  F909                 039    039A
023200120621     D  RXCBREF              040    047A
023300120621     D  RXCBRTR              048    055A
023400120621     D  F910                 056    150A
023500120621     **
023600120619    ***
023700120619     D @STEP           S              5A
023800120622    ***
023900120622     D LOAD@         E DS                  EXTNAME(CGNW010)
024000120622     D* @750                   1    750A
024100120622     D* @900                   1    900A
024200120622     D* @1050                  1   1050A
024300120622     D* @1200                  1   1200A
024400120622    ***
024500120622    ***
024600120622    ***
024700120622    ***
024800120619   X***X
024900120619     C                   EVAL      @STEP = 'PREP0'
025000120619    ***
025100120619     C                   DOU       @STEP = 'LEAVE'
025200120619     C     @STEP         CASEQ     'PREP0'       $PREP0
025300120619     C     @STEP         CASEQ     'STEP0'       $STEP0
025400120619     C     @STEP         CASEQ     'PREP1'       $PREP1
025500120619     C     @STEP         CASEQ     'STEP1'       $STEP1
025600120619     C     @STEP         CASEQ     'STEP2'       $STEP2
025700120619     C     @STEP         CASEQ     'STEP3'       $STEP3
025800120619     C     @STEP         CASEQ     'PREP4'       $PREP4
025900120619     C     @STEP         CASEQ     'STEP4'       $STEP4
026000120619     C     @STEP         CASEQ     'PREP5'       $PREP5
026100120619     C     @STEP         CASEQ     'STEP5'       $STEP5
026200120619     C     @STEP         CASEQ     'STEP6'       $STEP6
026300120619     C     @STEP         CASEQ     'PREP7'       $PREP7
026400120619     C     @STEP         CASEQ     'STEP7'       $STEP7
026500120619     C                   ENDCS
026600120619     C                   ENDDO
026700120619    ***
026800120619     C                   EVAL      *INLR = *ON
026900120619   S***S
027000120619     C     $PREP0        BEGSR
027100120619    ***
027200120619     C                   Z-ADD     0             #UKEY
027300120619     C     CARR#CTL      CHAIN     CARXPTR
027400120619    ***
027500120619     C     CARR#CTL      SETLL     CARACCR
027600120619    ***
027700120619     C                   EVAL      #ISO = %DATE
027800120619     C                   MOVE      #ISO          #TODAY            8 0
027900120621     C                   ADDDUR    15:*D         #ISO
028000120621     C                   MOVE      #ISO          #15LIMIT          8 0
028100120619    ***
028200120619     C                   EVAL      @STEP = 'STEP0'
028300120619    ***
028400120619     C                   ENDSR
028500120619   S***S
028600120619     C     $STEP0        BEGSR
028700120619    ***
028800120619     C     CARR#CTL      READE     CARACCR
028900120619    ***
029000120619     C                   IF        %EOF(CARACCP)
029100120619     C                   EVAL      @STEP = 'LEAVE'
029200120619     C                   LEAVESR
029300120619     C                   ENDIF
029400120619    ***
029500120619    *** CAN THE ACCOUNT BE EXPORTED?
029600120619    ***
029700120619     C                   IF        CASTATUS = 'N'
029800120619     C                   LEAVESR
029900120619     C                   ENDIF
030000120619    ***
030100120619     C*                  EXSR      $OPEN
030200120619    ***
030300120619     C                   EVAL      @STEP = 'PREP1'
030400120619    ***
030500120619     C                   ENDSR
030600120619   S***S
030700120619     C     $PREP1        BEGSR
030800120619    ***
030900120619     C                   EVAL      KF@TRS = CATRST
031000120619     C                   EVAL      KF@SUB = CASUB#
031100120619     C                   EVAL      KF@ACC = CAACCT
031200120619    ***
031300120619     C                   EXSR      $PLANLOAD
031400120619    ***
031500120619     C                   EVAL      #RECCNT = 0
031600120619    ***
031700120619     C                   EVAL      @STEP = 'STEP1'
031800120619    ***
031900120619     C                   ENDSR
032000120619   S***S
032100120619     C     $STEP1        BEGSR
032200120619    ***
032300120619     C                   EVAL      KF@PLN = *BLANKS
032400120619     C                   EVAL      KF@TRM = 0
032500120619     C                   EVAL      KF@SSN = 0
032600120619     C                   EVAL      KF@SEQ = 0
032700120619    ***
032800120619     C     KL#TSA        SETLL     MEMBR
032900120619    ***
033000120619     C                   EVAL      @STEP = 'STEP2'
033100120619    ***
033200120619     C                   ENDSR
033300120619   S***S
033400120619     C     $STEP2        BEGSR
033500120619    ***
033600120619     C     KL#TSA        READE     MEMBR
033700120619    ***
033800120619     C                   IF        %EOF(MEMAC#1)
033900120619     C                   EVAL      @STEP = 'STEP0'
034000120619    ***
034100120619    ***  IF MULTIPLE ACCOUNTS, REFER TO GUAR030 FOR SPECIAL CODING FOR THIS SECTION
034200120619    ***
034300120621     C*                  EXSR      $CLOSE
034400120621     C                   LEAVESR
034500120621     C                   ENDIF
034600120619    ***
034700120619     C                   EVAL      KF@SSN = MBSSNO
034800120619     C                   MOVE      *ZEROS        KF@SEQ
034900120619    ***
035000120619     C     KL#MPLN       SETLL     MCOVR
035100120619    ***
035200120619     C                   EXSR      $CLRSTG
035300120619    ***
035400120619     C                   EVAL      @STEP = 'STEP3'
035500120619    ***
035600120619     C                   ENDSR
035700120619   S***S
035800120619     C     $STEP3        BEGSR
035900120619    ***
036000120619     C     KL#MPLN       READE     MCOVR
036100120619    ***
036200120619     C                   IF        %EOF(MCOVMPLN)
036300120619     C                   EVAL      @STEP = 'PREP4'
036400120619     C                   LEAVESR
036500120619     C                   ENDIF
036600120619    ***
036700120621     C*                  IF        ENRLDT = CANDT
036800120621     C*                  LEAVESR
036900120621     C*                  ENDIF
037000120619    ***
037100120619     C                   EVAL      @PLANIN = MCPLAN
037200120619     C                   EVAL      @ENRIN = MCOVTP
037300120619     C                   EVAL      #EFFDTE = ENRLDT
037400120619     **
037500120619     C                   EXSR      $QUIK
037600120619     **
037700120619     C                   EXSR      $PLANSRCH
037800120619    ***
037900120619     C                   IF        PLN@CAT = *BLANKS
038000120619     C                   LEAVESR
038100120619     C                   ENDIF
038200120619    ***
038300120619     C                   IF        CANDT = 0
038400120619     C                   EVAL      #CANCEL = 99999999
038500120619     C                   ELSE
038600120619     C                   EVAL      #CANCEL = CANDT
038700120619     C                   ENDIF
038800120619    ***
038900120619     C                   EXSR      $AD2MARY
039000120619    ***
039100120619     C                   ENDSR
039200120619   S***S
039300120619     C     $AD2MARY      BEGSR
039400120619    ***
039500120619    *C                   IF        PLN@CAT = 'MED'
039600120619     C                   IF        MED#CNE > 0 AND
039700120619     C                             MED@TRM(MED#CNE) = 99999999
039800120619     C                   LEAVESR
039900120619     C                   ENDIF
040000120619    *C                   ADD       1             MED#CNE
040100120619    *C                   EVAL      MED@PLN(MED#CNE) = @PLANIN
040200120619    *C                   EVAL      MED@ENR(MED#CNE) = @ENROU
040300120619    *C                   EVAL      MED@FRM(MED#CNE) = #EFFDTE
040400120619    *C                   EVAL      MED@TRM(MED#CNE) = #CANCEL
040500120619     C                   LEAVESR
040600120619    *C                   ENDIF
040700120619    ***
040800120619    *C                   IF        PLN@CAT = 'DEN'
040900120619     C                   IF        DEN#CNE > 0 AND
041000120619     C                             DEN@TRM(DEN#CNE) = 99999999
041100120619     C                   LEAVESR
041200120619     C                   ENDIF
041300120619    *C                   ADD       1             DEN#CNE
041400120619    *C                   EVAL      DEN@PLN(DEN#CNE) = @PLANIN
041500120619    *C                   EVAL      DEN@ENR(DEN#CNE) = @ENROU
041600120619    *C                   EVAL      DEN@FRM(DEN#CNE) = #EFFDTE
041700120619    *C                   EVAL      DEN@TRM(DEN#CNE) = #CANCEL
041800120619     C                   LEAVESR
041900120619    *C                   ENDIF
042000120619    ***
042100120621    *C                   IF        PLN@CAT = 'RXD'
042200120619     C                   IF        RXD#CNE > 0 AND
042300120619     C                             RXD@TRM(RXD#CNE) = 99999999
042400120619     C                   LEAVESR
042500120619     C                   ENDIF
042600120619    *C                   ADD       1             RXD#CNE
042700120619    *C                   EVAL      RXD@PLN(RXD#CNE) = @PLANIN
042800120619    *C                   EVAL      RXD@ENR(RXD#CNE) = @ENROU
042900120619    *C                   EVAL      RXD@FRM(RXD#CNE) = #EFFDTE
043000120619    *C                   EVAL      RXD@TRM(RXD#CNE) = #CANCEL
043100120619     C                   LEAVESR
043200120619    *C                   ENDIF
043300120619    ***
043400120619    *C                   IF        PLN@CAT = 'VIS'
043500120619     C                   IF        VIS#CNE > 0 AND
043600120619     C                             VIS@TRM(VIS#CNE) = 99999999
043700120619     C                   LEAVESR
043800120619     C                   ENDIF
043900120619    *C                   ADD       1             VIS#CNE
044000120619    *C                   EVAL      VIS@PLN(VIS#CNE) = @PLANIN
044100120619    *C                   EVAL      VIS@ENR(VIS#CNE) = @ENROU
044200120619    *C                   EVAL      VIS@FRM(VIS#CNE) = #EFFDTE
044300120619    *C                   EVAL      VIS@TRM(VIS#CNE) = #CANCEL
044400120619     C                   LEAVESR
044500120619    *C                   ENDIF
044600120619    ***
044700120619     C                   ENDSR
044800120619   S***S
044900120619     C     $QUIK         BEGSR
045000120619    ***
045100120619     C                   EVAL      @CCTRIN = *BLANKS
045200120619    ***
045300120619     C                   SELECT
045400120619     C                   WHEN      @ENRIN = 'TIN'
045500120619     C                   EVAL      @ENROU = 'YNN'
045600120619     C                   WHEN      @ENRIN = 'THW'
045700120619     C                   EVAL      @ENROU = 'YYN'
045800120619     C                   WHEN      @ENRIN = 'TPC' OR @ENRIN = 'TP2'
045900120619     C                   EVAL      @ENROU = 'YNY'
046000120619     C                   WHEN      @ENRIN = 'TFA'
046100120619     C                   EVAL      @ENROU = 'YYY'
046200120619     C                   ENDSL
046300120619    ***
046400120619     C                   ENDSR
046500120619   S***S
046600120619     C     $PREP4        BEGSR
046700120619    ***
046800120619     C                   IF        RXD#CNE  = 0 AND MED#CNE  = 0 AND
046900120619     C                             VIS#CNE  = 0 AND DEN#CNE  = 0
047000120619     C                   EVAL      @STEP = 'STEP2'
047100120619     C                   LEAVESR
047200120619     C                   ENDIF
047300120619    ***
047400120621     C                   EXSR      $CHK15
047500120621    ***
047600120619     C                   EVAL      TERM_MED = NO
047700120619     C                   EVAL      TERM_DEN = NO
047800120619     C                   EVAL      TERM_RXD = NO
047900120619     C                   EVAL      TERM_VIS = NO
048000120619    ***
048100120619     C                   EXSR      $CHKHEM
048200120619    ***
048300120619     C                   EVAL      @STEP = 'STEP4'
048400120621    ***
048500120621     C                   ENDSR
048600120621   S***S
048700120621    *** 15 DAY LIMIT CHECK
048800120621    ***
048900120621     C     $CHK15        BEGSR
049000120621    ***
049100120621     C                   IF        MED#CNE > 0
049200120621     C                   IF        MED@TRM(MED#CNE) <> 99999999
049300120621     C                   EVAL      #CANCEL = MED@TRM(MED#CNE)
049400120621     C                   IF        #CANCEL > #15LIMIT
049500120621     C                   EVAL      #CANCEL = 0
049600120621     C                   EVAL      MED@TRM(MED#CNE) = #CANCEL
049700120621     C                   ENDIF
049800120621     C                   ENDIF
049900120621     C                   ENDIF
050000120621    ***
050100120621     C                   IF        DEN#CNE > 0
050200120621     C                   IF        DEN@TRM(DEN#CNE) <> 99999999
050300120621     C                   EVAL      #CANCEL = DEN@TRM(DEN#CNE)
050400120621     C                   IF        #CANCEL > #15LIMIT
050500120621     C                   EVAL      #CANCEL = 0
050600120621     C                   EVAL      DEN@TRM(DEN#CNE) = #CANCEL
050700120621     C                   ENDIF
050800120621     C                   ENDIF
050900120621     C                   ENDIF
051000120619    ***
051100120621     C                   IF        RXD#CNE > 0
051200120621     C                   IF        RXD@TRM(RXD#CNE) <> 99999999
051300120621     C                   EVAL      #CANCEL = RXD@TRM(RXD#CNE)
051400120621     C                   IF        #CANCEL > #15LIMIT
051500120621     C                   EVAL      #CANCEL = 0
051600120621     C                   EVAL      RXD@TRM(RXD#CNE) = #CANCEL
051700120621     C                   ENDIF
051800120621     C                   ENDIF
051900120621     C                   ENDIF
052000120621    ***
052100120621     C                   IF        VIS#CNE > 0
052200120621     C                   IF        VIS@TRM(VIS#CNE) <> 99999999
052300120621     C                   EVAL      #CANCEL = VIS@TRM(VIS#CNE)
052400120621     C                   IF        #CANCEL > #15LIMIT
052500120621     C                   EVAL      #CANCEL = 0
052600120621     C                   EVAL      VIS@TRM(VIS#CNE) = #CANCEL
052700120621     C                   ENDIF
052800120621     C                   ENDIF
052900120621     C                   ENDIF
053000120621    ***
053100120619     C                   ENDSR
053200120619   S***S
053300120619    *** GENERATE MEMBER RECORD
053400120619    ***
053500120619     C     $STEP4        BEGSR
053600120619    ***
053700120619     C                   IF        RXD#CNE  = 0 AND MED#CNE  = 0 AND
053800120619     C                             VIS#CNE  = 0 AND DEN#CNE  = 0
053900120619     C                   EVAL      @STEP = 'STEP2'
054000120619     C                   LEAVESR
054100120619     C                   ENDIF
054200120619    ***
054300120619     C                   EVAL      WRT@TYPE = 'MEMBER'
054400120619    ***
054500120621     C*                  EVAL      MED@MEFF = 0
054600120621     C*                  EVAL      DEN@MEFF = 0
054700120621     C*                  EVAL      RXD@MEFF = 0
054800120621     C*                  EVAL      VIS@MEFF = 0
054900120619    ***
055000120619     C                   EXSR      $FILLMBR
055100120619    ***
055200120619     C                   EXSR      $FILLCOVG
055300120621    ***
055400120621    *** EACH ACCOUNT WILL ONLY HAVE SELECT PRODUCTS; MAKE SURE TO ONLY USE THE
055500120621    ***   THE SEGMENT YOU REALLY NEED.
055600120621    ***
055700120621     C                   EVAL      C1SEG1 = MED@DS
055800120621     C                   EVAL      C1SEG2 = DEN@DS
055900120621     C                   EVAL      C1SEG3 = VIS@DS
056000120621     C                   EVAL      C1SEG4 = RXD@DS
056100120619    ***
056200120621     C                   WRITE     CGNF010
056300120621     C*                  ADD       1             #RECCNT
056400120619    ***
056500120619     C                   EVAL      @STEP = 'PREP5'
056600120619    ***
056700120619     C                   ENDSR
056800120619   S***S
056900120619     C     $FILLMBR      BEGSR
057000120619    ***
057100120619     C                   CLEAR                   CGNF010
057200120619    ***
057300120619     C                   EVAL      C1REC = '01'
057400120619     C                   EVAL      C1SSN1 = %EDITC(MBSSNO:'X')
057500120619    ***
057600120619     C                   EVAL      C1LNAM = %TRIM(MLNAME)
057700120619     C                   EVAL      C1FNAM = %TRIM(MFNAME)
057800120619     C                   EVAL      C1MI   = MMI
057900120619    ***
058000120619     C                   EVAL      C1DOB  = %EDITC(BIRTH:'X')
058100120619     C                   EVAL      C1GENDER = SEX
058200120619     C                   EVAL      C1SSN2 = C1SSN1
058300120619    ***
058400120619     C                   EVAL      #10 = (AREA * 10000000) + PHONE
058500120619     C                   IF        #10 = 0
058600120621     C                   EVAL      C1PHON = *BLANKS
058700120619     C                   ELSE
058800120621     C                   EVAL      C1PHON = %EDITC(#10:'X')
058900120619     C                   ENDIF
059000120619    ***
059100120619     C                   EVAL      C1ADDR1 = %TRIM(ADDR1)
059200120619     C                   EVAL      C1ADDR2 = %TRIM(ADDR2)
059300120619     C                   EVAL      C1CITY = %TRIM(CITY)
059400120619     C                   EVAL      C1STATE = STATE
059500120619    ***
059600120619     C                   MOVE      *BLANKS       @9                9
059700120619     C                   EVAL      @9 = %EDITC(ZIP:'X')
059800120619     C                   EVAL      C1ZIP = %SUBST(@9:1:5)
059900120619    ***
060000120619     C                   IF        MARDT = 0
060100120621     C                   EVAL      C1MARSTA = 'S'
060200120619     C                   ELSE
060300120621     C                   EVAL      C1MARSTA = 'M'
060400120619     C                   ENDIF
060500120619    ***
060600120619     C                   EVAL      C1RELAT = 'EE'
060700120619    ***
060800120619     C                   Z-ADD     EMPDT         #DATE
060900120619     C                   EVAL      C1HIREDT = %EDITC(#DATE:'X')
061000120619    ***
061100120619     C                   EVAL      XXSEQ = '00'
061200120619     C                   MOVE      *ZEROS        #SEQ              2 0
061300120619     C                   ADD       1             #UKEY             6 0
061400120619     C                   MOVE      #UKEY         XXUKEY
061500120619    ***
061600120619     C                   ENDSR
061700120619   S***S
061800120619     C     $FILLCOVG     BEGSR
061900120619    ***
062000120619     C                   IF        MED#CNE > 0
062100120619      * MEDICAL
062200120619     C                   EVAL      @PLANIN = MED@PLN(MED#CNE)
062300120619     C                   EXSR      $QUIK
062400120619     C                   EXSR      $PLANSRCH
062500120619     C                   IF        PLN@CAT = *BLANKS
062600120619     C     'MED FILL'    DSPLY     '*EXT'
062700120619     C                   SETON                                        H1
062800120619     C                   ENDIF
062900120619      *
063000120621     C                   EVAL      MEACNU = CACID1
063100120621     C                   EVAL      MEBRCO = CPCID2
063200120621     C                   EVAL      MEBEOP = CPCID1
063300120621     C                   EVAL      #XSX   = MED@FRM(MED#CNE)
063400120621     C                   EVAL      MEEFFD = %EDITC(#XSX:'X')
063500120621      *
063600120621     C                   EVAL      #XSX   = MED@TRM(MED#CNE)
063700120621     C                   EVAL      METRMD = %EDITC(#XSX:'X')
063800120621     C                   IF        METRMD = '99999999'
063900120621     C                   EVAL      METRMD = *BLANKS
064000120621     C                   ENDIF
064100120621      *
064200120622     C*                  IF        WRT@TYPE = 'MEMBER'
064300120621     C                   EVAL      @3 = MED@ENR(MED#CNE)
064400120621     C                   EVAL      MEMEMBER = %SUBST(@3:1:1)
064500120621     C                   EVAL      MESPOUSE = %SUBST(@3:2:1)
064600120621     C                   EVAL      MECHILD  = %SUBST(@3:3:1)
064700120622     C                   EVAL      MECOLLAT = 'N'
064800120622     C*                  ENDIF
064900120621      *
065000120621     C                   IF        EMPST = 'C'
065100120621     C                   EVAL      MECBREF = %EDITC(QEDT:'X')
065200120621     C                   EVAL      MECBRTR = %EDITC(CEXPDT:'X')
065300120621     C                   ENDIF
065400120621      *
065500120621     C                   EVAL      MEHMOCOD = *BLANKS
065600120621     C                   EVAL      MENETID  = *BLANKS
065700120621     C                   EVAL      MEPCPID  = *BLANKS
065800120621     C                   EVAL      MEPI     = *BLANKS
065900120621     C                   EVAL      MEPHNED  = *BLANKS
066000120621     C                   EVAL      MEPCLED  = *BLANKS
066100120619      *
066200120619     C                   ENDIF
066300120619    ***
066400120619     C                   IF        DEN#CNE > 0
066500120619      * DENTAL
066600120621     C                   EVAL      @PLANIN = DEN@PLN(DEN#CNE)
066700120621     C                   EXSR      $QUIK
066800120621     C                   EXSR      $PLANSRCH
066900120621     C                   IF        PLN@CAT = *BLANKS
067000120621     C     'DEN FILL'    DSPLY     '*EXT'
067100120621     C                   SETON                                        H1
067200120621     C                   ENDIF
067300120621      *
067400120621     C                   EVAL      DNACNU = CACID1
067500120621     C                   EVAL      DNBRCO = CPCID2
067600120621     C                   EVAL      DNBEOP = CPCID1
067700120621     C                   EVAL      #XSX   = DEN@FRM(DEN#CNE)
067800120621     C                   EVAL      DNEFFD = %EDITC(#XSX:'X')
067900120621      *
068000120621     C                   EVAL      #XSX   = DEN@TRM(DEN#CNE)
068100120621     C                   EVAL      DNTRMD = %EDITC(#XSX:'X')
068200120621     C                   IF        DNTRMD = '99999999'
068300120621     C                   EVAL      DNTRMD = *BLANKS
068400120621     C                   ENDIF
068500120621      *
068600120622     C*                  IF        WRT@TYPE = 'MEMBER'
068700120621     C                   EVAL      @3 = DEN@ENR(DEN#CNE)
068800120621     C                   EVAL      DNMEMBER = %SUBST(@3:1:1)
068900120621     C                   EVAL      DNSPOUSE = %SUBST(@3:2:1)
069000120621     C                   EVAL      DNCHILD  = %SUBST(@3:3:1)
069100120622     C                   EVAL      DNCOLLAT = 'N'
069200120622     C*                  ENDIF
069300120621      *
069400120621     C                   IF        EMPST = 'C'
069500120621     C                   EVAL      DNCBREF = %EDITC(QEDT:'X')
069600120621     C                   EVAL      DNCBRTR = %EDITC(CEXPDT:'X')
069700120621     C                   ENDIF
069800120621      *
069900120621     C                   EVAL      DNOFFID  = *BLANKS
070000120621     C                   EVAL      DNOFNED  = *BLANKS
070100120621     C                   EVAL      DNESTPI  = *BLANKS
070200120619      *
070300120619     C                   ENDIF
070400120619    ***
070500120619     C                   IF        RXD#CNE > 0
070600120619      * RXD
070700120621     C                   EVAL      @PLANIN = RXD@PLN(RXD#CNE)
070800120621     C                   EXSR      $QUIK
070900120621     C                   EXSR      $PLANSRCH
071000120621     C                   IF        PLN@CAT = *BLANKS
071100120621     C     'RXD FILL'    DSPLY     '*EXT'
071200120621     C                   SETON                                        H1
071300120621     C                   ENDIF
071400120621      *
071500120621     C                   EVAL      RXACNU = CACID1
071600120621     C                   EVAL      RXBRCO = CPCID2
071700120621     C                   EVAL      RXBEOP = CPCID1
071800120621     C                   EVAL      #XSX   = RXD@FRM(RXD#CNE)
071900120621     C                   EVAL      RXEFFD = %EDITC(#XSX:'X')
072000120621      *
072100120621     C                   EVAL      #XSX   = RXD@TRM(RXD#CNE)
072200120621     C                   EVAL      RXTRMD = %EDITC(#XSX:'X')
072300120621     C                   IF        RXTRMD = '99999999'
072400120621     C                   EVAL      RXTRMD = *BLANKS
072500120621     C                   ENDIF
072600120622      *
072700120622     C                   EVAL      RXCOLLAT = 'N'
072800120621      *
072900120621     C                   EVAL      @3 = RXD@ENR(RXD#CNE)
073000120621     C                   EVAL      RXMEMBER = %SUBST(@3:1:1)
073100120621     C                   EVAL      RXSPOUSE = %SUBST(@3:2:1)
073200120621     C                   EVAL      RXCHILD  = %SUBST(@3:3:1)
073300120621      *
073400120621     C                   IF        EMPST = 'C'
073500120621     C                   EVAL      RXCBREF = %EDITC(QEDT:'X')
073600120621     C                   EVAL      RXCBRTR = %EDITC(CEXPDT:'X')
073700120621     C                   ENDIF
073800120621      *
073900120619     C                   ENDIF
074000120619    ***
074100120619     C                   IF        VIS#CNE > 0
074200120619      *  VISION
074300120621     C                   EVAL      @PLANIN = VIS@PLN(VIS#CNE)
074400120621     C                   EXSR      $QUIK
074500120621     C                   EXSR      $PLANSRCH
074600120621     C                   IF        PLN@CAT = *BLANKS
074700120621     C     'VIS FILL'    DSPLY     '*EXT'
074800120621     C                   SETON                                        H1
074900120621     C                   ENDIF
075000120621      *
075100120621     C                   EVAL      VSACNU = CACID1
075200120621     C                   EVAL      VSBRCO = CPCID2
075300120621     C                   EVAL      VSBEOP = CPCID1
075400120621     C                   EVAL      #XSX   = VIS@FRM(VIS#CNE)
075500120621     C                   EVAL      VSEFFD = %EDITC(#XSX:'X')
075600120621      *
075700120621     C                   EVAL      #XSX   = VIS@TRM(VIS#CNE)
075800120621     C                   EVAL      VSTRMD = %EDITC(#XSX:'X')
075900120621     C                   IF        VSTRMD = '99999999'
076000120621     C                   EVAL      VSTRMD = *BLANKS
076100120621     C                   ENDIF
076200120621      *
076300120621     C                   EVAL      @3 = VIS@ENR(VIS#CNE)
076400120621     C                   EVAL      VSMEMBER = %SUBST(@3:1:1)
076500120621     C                   EVAL      VSSPOUSE = %SUBST(@3:2:1)
076600120621     C                   EVAL      VSCHILD  = %SUBST(@3:3:1)
076700120622      *
076800120622     C                   EVAL      VSCOLLAT = 'N'
076900120621      *
077000120621     C                   IF        EMPST = 'C'
077100120621     C                   EVAL      VSCBREF = %EDITC(QEDT:'X')
077200120621     C                   EVAL      VSCBRTR = %EDITC(CEXPDT:'X')
077300120621     C                   ENDIF
077400120619      *
077500120619     C                   ENDIF
077600120619    ***
077700120619     C                   ENDSR
077800120619   S***S
077900120619     C     $PREP5        BEGSR
078000120619    ***
078100120619     C     KF@SSN        CHAIN     DEPENR
078200120619     C                   IF        NOT %FOUND(DEPNDC)
078300120619     C                   EVAL      @STEP = 'STEP2'
078400120619     C                   LEAVESR
078500120619     C                   ENDIF
078600120619    ***
078700120619     C     KF@SSN        SETLL     DEPENR
078800120619    ***
078900120619     C                   EVAL      @STEP = 'STEP5'
079000120619    ***
079100120619     C                   ENDSR
079200120619   S***S
079300120619     C     $STEP5        BEGSR
079400120619    ***
079500120619     C     KF@SSN        READE     DEPENR
079600120619    ***
079700120619     C                   IF        %EOF(DEPNDC)
079800120619     C                   EVAL      @STEP = 'STEP2'
079900120619     C                   LEAVESR
080000120619     C                   ENDIF
080100120619    ***
080200120619     C                   EVAL      KF@SEQ = DPSEQ#
080300120619    ***
080400120619     C     KL#DCV        CHAIN     DCOVR
080500120619     C                   IF        NOT %FOUND(ELIGDCOV)
080600120619     C                   LEAVESR
080700120619     C                   ENDIF
080800120619    ***
080900120619     C                   EXSR      $CLRSTG
081000120619    ***
081100120619     C     KL#DCV        SETLL     DCOVR
081200120619    ***
081300120619     C                   EVAL      @STEP = 'STEP6'
081400120619    ***
081500120619     C                   ENDSR
081600120619   S***S
081700120619     C     $STEP6        BEGSR
081800120619    ***
081900120619     C     KL#DCV        READE     DCOVR
082000120619    ***
082100120619     C                   IF        %EOF(ELIGDCOV)
082200120619     C                   EVAL      @STEP = 'PREP7'
082300120619     C                   LEAVESR
082400120619     C                   ENDIF
082500120619    ***
082600120621     C*                  IF        DENRDT = CCANDT
082700120621     C*                  LEAVESR
082800120621     C*                  ENDIF
082900120619    ***
083000120619     C                   EVAL      @PLANIN = DVPLAN
083100120619     C                   EVAL      @ENRIN = DVENRL
083200120619     C                   EVAL      #EFFDTE = DENRDT
083300120621     C*                  EVAL      #BENAMT = 0
083400120619    ***
083500120619     C                   EXSR      $QUIK
083600120619    ***
083700120619     C                   EXSR      $PLANSRCH
083800120619    ***
083900120619     C                   IF        PLN@CAT = *BLANKS
084000120619     C                   LEAVESR
084100120619     C                   ENDIF
084200120619    ***
084300120619     C                   EVAL      #CANCEL = CCANDT
084400120619     C                   IF        #CANCEL = 0
084500120619     C                   EVAL      #CANCEL = 99999999
084600120619     C                   ENDIF
084700120619     C                   EXSR      $AD2MARY
084800120619    ***
084900120619     C                   ENDSR
085000120619   S***S
085100120619     C     $PREP7        BEGSR
085200120619    ***
085300120621     C                   IF        RXD#CNE  = 0 AND MED#CNE  = 0 AND
085400120621     C                             VIS#CNE  = 0 AND DEN#CNE  = 0
085500120619     C                   EVAL      @STEP = 'STEP5'
085600120619     C                   LEAVESR
085700120619     C                   ENDIF
085800120619    ***
085900120619     C                   EVAL      TERM_MED = NO
086000120619     C                   EVAL      TERM_DEN = NO
086100120619     C                   EVAL      TERM_RXD = NO
086200120619     C                   EVAL      TERM_VIS = NO
086300120619    ***
086400120619     C                   EXSR      $CHKHEM
086500120619    ***
086600120619     C                   EVAL      @STEP = 'STEP7'
086700120619    ***
086800120619     C                   ENDSR
086900120619   S***S
087000120619     C     $STEP7        BEGSR
087100120619    ***
087200120621     C                   IF        RXD#CNE  = 0 AND MED#CNE  = 0 AND
087300120621     C                             VIS#CNE  = 0 AND DEN#CNE  = 0
087400120619     C                   EVAL      @STEP = 'STEP5'
087500120619     C                   LEAVESR
087600120619     C                   ENDIF
087700120619    ***
087800120619     C                   EVAL      WRT@TYPE = 'DEPEND'
087900120619    ***
088000120619     C                   EXSR      $FILLDEP
088100120619    ***
088200120619     C                   EXSR      $FILLCOVG
088300120619    ***
088400120621    *** EACH ACCOUNT WILL ONLY HAVE SELECT PRODUCTS; MAKE SURE TO ONLY USE THE
088500120621    ***   THE SEGMENT YOU REALLY NEED.
088600120621    ***
088700120621     C                   EVAL      C1SEG1 = MED@DS
088800120621     C                   EVAL      C1SEG2 = DEN@DS
088900120621     C                   EVAL      C1SEG3 = VIS@DS
089000120621     C                   EVAL      C1SEG4 = RXD@DS
089100120621    ***
089200120621     C                   WRITE     CGNF010
089300120621     C*                  ADD       1             #RECCNT
089400120619    ***
089500120619     C                   EVAL      @STEP = 'STEP5'
089600120619    ***
089700120619     C                   ENDSR
089800120619   S***S
089900120619     C     $FILLDEP      BEGSR
090000120619    ***
090100120621     C                   CLEAR                   CGNF010
090200120619    ***
090300120621     C                   EVAL      C1REC = '02'
090400120621     C                   EVAL      C1SSN1 = %EDITC(MBSSNO:'X')
090500120621    ***
090600120621     C                   EVAL      C1LNAM = %TRIM(DLNAME)
090700120621     C                   EVAL      C1FNAM = %TRIM(DFNAME)
090800120621     C                   EVAL      C1MI   = DMI
090900120621    ***
091000120621     C                   EVAL      C1DOB  = %EDITC(DBIRTH:'X')
091100120621     C                   EVAL      C1GENDER = DSEX
091200120621     C                   IF        DEPSS# > 0
091300120621     C                   EVAL      C1SSN2 = %EDITC(DEPSS#:'X')
091400120621     C                   ELSE
091500120621     C                   EVAL      C1SSN2 = *BLANKS
091600120621     C                   ENDIF
091700120621    ***
091800120621     C                   IF        DADDR1 = ADDR1 OR %TRIM(DADDR1) = 'SAME'
091900120621      * ***
092000120621     C                   EVAL      #10 = (AREA * 10000000) + PHONE
092100120621     C                   IF        #10 = 0
092200120621     C                   EVAL      C1PHON = *BLANKS
092300120621     C                   ELSE
092400120621     C                   EVAL      C1PHON = %EDITC(#10:'X')
092500120621     C                   ENDIF
092600120621     C                   EVAL      C1ADDR1 = %TRIM(ADDR1)
092700120621     C                   EVAL      C1ADDR2 = %TRIM(ADDR2)
092800120621     C                   EVAL      C1CITY = %TRIM(CITY)
092900120621     C                   EVAL      C1STATE = STATE
093000120621     C                   MOVE      *BLANKS       @9                9
093100120621     C                   EVAL      @9 = %EDITC(ZIP:'X')
093200120621     C                   EVAL      C1ZIP = %SUBST(@9:1:5)
093300120621      * ***
093400120621     C                   ELSE
093500120621      * ***
093600120621     C                   EVAL      C1ADDR1 = %TRIM(DADDR1)
093700120621     C                   EVAL      C1ADDR2 = %TRIM(DADDR2)
093800120621     C                   EVAL      C1CITY  = %TRIM(DCITY)
093900120621     C                   EVAL      C1STATE = DSTATE
094000120621     C                   MOVE      *BLANKS       @9
094100120621     C                   EVAL      @9 = %EDITC(DZIP:'X')
094200120621     C                   EVAL      C1ZIP = %SUBST(@9:1:5)
094300120621     C                   EVAL      #10 = (DAREA * 10000000) + DPHONE
094400120621     C                   IF        #10 > 0
094500120621     C                   EVAL      C1PHON = %EDITC(#10:'X')
094600120621     C                   ELSE
094700120621     C                   EVAL      C1PHON = *BLANKS
094800120621     C                   ENDIF
094900120621      * ***
095000120621     C                   ENDIF
095100120621    ***
095200120621     C                   EVAL      C1MARSTA = *BLANKS
095300120621    ***
095400120621     C                   IF        DSTUDN = 'Y'
095500120621     C                   EVAL      C1FTS = 'Y'
095600120621     C                   ELSE
095700120621     C                   EVAL      C1FTS = *BLANKS
095800120621     C                   ENDIF
095900120621    ***
096000120621     C                   SELECT
096100120621     C                   WHEN      DRELCD = 'RWI' OR DRELCD = 'RHU'
096200120621     C                   EVAL      C1RELAT = 'SP'
096300120621     C                   WHEN      DRELCD = 'RSO' OR DRELCD = 'RDA'
096400120621     C                   EVAL      C1RELAT = 'CH'
096500120621     C                   WHEN      DRELCD = 'RPA'
096600120621     C                   EVAL      C1RELAT = 'SP'
096700120621     C                   ENDSL
096800120621    ***
096900120621     C                   ADD       1             #SEQ              2 0
097000120621     C                   MOVE      #SEQ          XXSEQ
097100120621     C                   MOVE      #UKEY         XXUKEY
097200120619    ***
097300120619     C                   ENDSR
097400120619   S***S
097500120619     C     *INZSR        BEGSR
097600120619    ***
097700120619     C     *ENTRY        PLIST
097800120619     C                   PARM                    @F               10
097900120619    ***
098000120619     C                   EVAL      #RECCNT = 0
098100120619    ***
098200120619     C     KL#ACCTL      KLIST
098300120619     C                   KFLD                    CARR#CTL
098400120619     C                   KFLD                    KF@TRS
098500120619     C                   KFLD                    KF@SUB
098600120619     C                   KFLD                    KF@ACC
098700120619    ***
098800120619     C     KL#TSA        KLIST
098900120619     C                   KFLD                    KF@TRS
099000120619     C                   KFLD                    KF@SUB
099100120619     C                   KFLD                    KF@ACC
099200120619    ***
099300120619     C     KL#MPLN       KLIST
099400120619     C                   KFLD                    KF@SSN
099500120619     C                   KFLD                    KF@SEQ
099600120619     C                   KFLD                    KF@TRS
099700120619     C                   KFLD                    KF@SUB
099800120619     C                   KFLD                    KF@ACC
099900120619    ***
100000120619     C     KL#CPLN       KLIST
100100120619     C                   KFLD                    CARR#CTL
100200120619     C                   KFLD                    KF@TRS
100300120619     C                   KFLD                    KF@SUB
100400120619     C                   KFLD                    KF@ACC
100500120619     C                   KFLD                    KF@CCTR
100600120619     C                   KFLD                    KF@PLN
100700120619    ***
100800120619     C     KL#DCV        KLIST
100900120619     C                   KFLD                    KF@SSN
101000120619     C                   KFLD                    KF@SEQ
101100120619    ***
101200120619     C     KL#MTR        KLIST
101300120619     C                   KFLD                    KF@SSN
101400120619     C                   KFLD                    KF@SEQ
101500120619     C                   KFLD                    KF#TRM
101600120619     C                   KFLD                    KF@PLN
101700120619     C                   KFLD                    KF@ENR
101800120619     C                   KFLD                    KF@TRS
101900120619     C                   KFLD                    KF@SUB
102000120619     C                   KFLD                    KF@ACC
102100120619    ***
102200120619     C                   ENDSR
102300120619   S***S
102400120619    *** PLANS LOADED BY ACCOUNT
102500120619    ***
102600120619     C     $PLANLOAD     BEGSR
102700120619    ***
102800120619     C                   EVAL      PP# = 0
102900120619     C                   DO        50
103000120619     C                   ADD       1             PP#
103100120619     C     PP#           OCCUR     CARPLN@
103200120619     C                   CLEAR                   CARPLN@
103300120619     C                   ENDDO
103400120619     C                   EVAL      PC# = 0
103500120619     C                   EVAL      PP# = 0
103600120619    ***
103700120619     C     KL#ACCTL      SETLL     CARPLNR
103800120619     C                   DOU       %EOF(CARPLNP)
103900120619     C     KL#ACCTL      READE     CARPLNR
104000120619     C                   IF        NOT %EOF(CARPLNP)
104100120619    ***
104200120619     C                   ADD       1             PC#
104300120619     C     PC#           OCCUR     CARPLN@
104400120619     C                   EVAL      CARPLN@ = DS@CARPLN
104500120619    ***
104600120619     C                   ENDIF
104700120619     C                   ENDDO
104800120619    ***
104900120619     C                   ENDSR
105000120619   S***S
105100120619     C     $CLRSTG       BEGSR
105200120619    ***
105300120619     C                   EVAL      #CANCEL = 0
105400120621    ***
105500120621     C                   CLEAR                   DS@MEDICAL
105600120621     C                   CLEAR                   DS@DENTAL
105700120621     C                   CLEAR                   DS@DRUG
105800120621     C                   CLEAR                   DS@VISION
105900120619    ***
106000120619     C                   EVAL                    MED#CNE = 0
106100120619     C                   EVAL                    MED#NDX = 0
106200120619     C                   CLEAR                   MED@PLN
106300120619     C                   CLEAR                   MED@ENR
106400120619     C                   CLEAR                   MED@FRM
106500120619     C                   CLEAR                   MED@TRM
106600120619    ***
106700120619     C                   EVAL                    DEN#CNE = 0
106800120619     C                   EVAL                    DEN#NDX = 0
106900120619     C                   CLEAR                   DEN@PLN
107000120619     C                   CLEAR                   DEN@ENR
107100120619     C                   CLEAR                   DEN@FRM
107200120619     C                   CLEAR                   DEN@TRM
107300120619    ***
107400120619     C                   EVAL                    RXD#CNE = 0
107500120619     C                   EVAL                    RXD#NDX = 0
107600120619     C                   CLEAR                   RXD@PLN
107700120619     C                   CLEAR                   RXD@ENR
107800120619     C                   CLEAR                   RXD@FRM
107900120619     C                   CLEAR                   RXD@TRM
108000120619    ***
108100120619     C                   EVAL                    VIS#CNE = 0
108200120619     C                   EVAL                    VIS#NDX = 0
108300120619     C                   CLEAR                   VIS@PLN
108400120619     C                   CLEAR                   VIS@ENR
108500120619     C                   CLEAR                   VIS@FRM
108600120619     C                   CLEAR                   VIS@TRM
108700120619    ***
108800120619     C                   ENDSR
108900120619   S***S
109000120619     C     $CHKHEM       BEGSR
109100120619    ***
109200120619     C                   IF        MED#CNE > 0 AND MED@TRM(MED#CNE) <> 99999999
109300120619     C                   EXSR      $CHKMED
109400120619     C                   ENDIF
109500120619    ***
109600120619     C                   IF        DEN#CNE > 0 AND DEN@TRM(DEN#CNE) <> 99999999
109700120619     C                   EXSR      $CHKDEN
109800120619     C                   ENDIF
109900120619    ***
110000120619     C                   IF        RXD#CNE > 0 AND RXD@TRM(RXD#CNE) <> 99999999
110100120619     C                   EXSR      $CHKRXD
110200120619     C                   ENDIF
110300120619    ***
110400120619     C                   IF        VIS#CNE > 0 AND VIS@TRM(VIS#CNE) <> 99999999
110500120619     C                   EXSR      $CHKVIS
110600120619     C                   ENDIF
110700120619    ***
110800120619     C                   ENDSR
110900120619   S***S
111000120619      * CHECK FOR MEDICAL TERMINATION
111100120619    *C     $CHKMED       BEGSR
111200120619    ***
111300120619    *C                   EVAL      TERM_MED = YES
111400120619    *C                   EVAL      KF#TRM = MED@TRM(MED#CNE)
111500120619    *C                   EVAL      KF@PLN = MED@PLN(MED#CNE)
111600120619    *C                   EVAL      KF@ENR = MED@ENR(MED#CNE)
111700120619    ***
111800120621    *C     KL#MTR        CHAIN     CGNF012
111900120621    *C                   IF        %FOUND(CGNW012)
112000120619    *C                   EVAL      MED#CNE = 0
112100120619    *C                   EVAL      TERM_MED = NO
112200120619     C                   LEAVESR
112300120619    *C                   ENDIF
112400120619    ***
112500120619     C                   EXSR      $WRTERM
112600120619    ***
112700120619    *C                   ENDSR
112800120619   S***S
112900120619    *C     $WRTERM       BEGSR
113000120619    ***
113100120621    *C                   CLEAR                   CGNF012
113200120619     C                   EVAL      NTSSNO         = KF@SSN
113300120619     C                   EVAL      NTDEPNO        = KF@SEQ
113400120619     C                   EVAL      NTTERMDT       = KF#TRM
113500120619     C                   EVAL      NTPLAN         = KF@PLN
113600120619     C                   EVAL      NTCOVTP        = KF@ENR
113700120619     C                   EVAL      NTTRST         = KF@TRS
113800120619     C                   EVAL      NTSUB#         = KF@SUB
113900120619     C                   EVAL      NTACCT         = KF@ACC
114000120619     C                   EVAL      NTTRANSDT      = #TODAY
114100120621     C                   WRITE     CGNF012
114200120619    ***
114300120619    *C                   ENDSR
114400120619   S***S
114500120619      * CHECK FOR DENTAL TERMINATION
114600120619    *C     $CHKDEN       BEGSR
114700120619    ***
114800120619    *C                   EVAL      TERM_DEN = YES
114900120619    *C                   EVAL      KF#TRM = DEN@TRM(DEN#CNE)
115000120619    *C                   EVAL      KF@PLN = DEN@PLN(DEN#CNE)
115100120619    *C                   EVAL      KF@ENR = DEN@ENR(DEN#CNE)
115200120619    ***
115300120621    *C     KL#MTR        CHAIN     CGNF012
115400120621    *C                   IF        %FOUND(CGNW012)
115500120619    *C                   EVAL      DEN#CNE = 0
115600120619    *C                   EVAL      TERM_DEN = NO
115700120619    *C                   ENDIF
115800120619    ***
115900120619     C                   EXSR      $WRTERM
116000120619    ***
116100120619    *C                   ENDSR
116200120619   S***S
116300120619      * CHECK FOR DRUG TERMINATION
116400120619    *C     $CHKRXD       BEGSR
116500120619    ***
116600120619    *C                   EVAL      TERM_RXD = YES
116700120619    *C                   EVAL      KF#TRM = RXD@TRM(RXD#CNE)
116800120619    *C                   EVAL      KF@PLN = RXD@PLN(RXD#CNE)
116900120619    *C                   EVAL      KF@ENR = RXD@ENR(RXD#CNE)
117000120619    ***
117100120621    *C     KL#MTR        CHAIN     CGNF012
117200120621    *C                   IF        %FOUND(CGNW012)
117300120619    *C                   EVAL      RXD#CNE = 0
117400120619    *C                   EVAL      TERM_RXD = NO
117500120619    *C                   ENDIF
117600120619    ***
117700120619     C                   EXSR      $WRTERM
117800120619    ***
117900120619    *C                   ENDSR
118000120619   S***S
118100120619      * CHECK FOR VISION TERMINATION
118200120619    *C     $CHKVIS       BEGSR
118300120619    ***
118400120619    *C                   EVAL      TERM_VIS = YES
118500120619    *C                   EVAL      KF#TRM = VIS@TRM(VIS#CNE)
118600120619    *C                   EVAL      KF@PLN = VIS@PLN(VIS#CNE)
118700120619    *C                   EVAL      KF@ENR = VIS@ENR(VIS#CNE)
118800120619    ***
118900120621    *C     KL#MTR        CHAIN     CGNF012
119000120621    *C                   IF        %FOUND(CGNW012)
119100120619    *C                   EVAL      VIS#CNE = 0
119200120619    *C                   EVAL      TERM_VIS = NO
119300120619    *C                   ENDIF
119400120619    ***
119500120619     C                   EXSR      $WRTERM
119600120619    ***
119700120619    *C                   ENDSR
119800120619   S***S
119900120619     C     $PLANSRCH     BEGSR
120000120619    ***
120100120619     C                   MOVE      *BLANKS       PLN@CAT          10
120200120619     C                   EVAL      PP# = 0
120300120619     C                   CLEAR                   DS@CARPLN
120400120619    ***
120500120619     C                   DO        PC#
120600120619    * *
120700120619     C                   ADD       1             PP#
120800120619     C     PP#           OCCUR     CARPLN@
120900120619    * *
121000120619     C                   IF        XPPLAN = @PLANIN AND
121100120619     C                             XPCCTR = @CCTRIN
121200120619     C                   EVAL      DS@CARPLN = CARPLN@
121300120622     C                   EVAL      PLN@CAT = %TRIM(XPCID3)
121400120619     C                   LEAVE
121500120619     C                   ENDIF
121600120619    * *
121700120619     C                   ENDDO
121800120619    ***
121900120619     C                   ENDSR
122000120619   S***S
122100120619    *C*    $OPEN         BEGSR
122200120619    ***
122300120619    *C*                  OPEN      GUAR011WF
122400120619    *C*                  OPEN      GUAR012WF
122500120619    *C*                  OPEN      GUAR013WF
122600120619    ***
122700120619    *C*                  ENDSR
122800120619   S***S
122900120619    *C*    $CLOSE        BEGSR
123000120619    ***
123100120619    *C*                  CLOSE     GUAR011WF
123200120619    *C*                  CLOSE     GUAR012WF
123300120619    *C*                  CLOSE     GUAR013WF
123400120619    ***
123500120619    *C*                  IF         #RECCNT > 2
123600120619    *C*                  EVAL      C11@10 = %SUBST(CACID3:1:10)
123700120619    *C*                  EVAL      C11@01 = CASTATUS
123800120619    *C*                  CALL      'GUAC011'
123900120619    *C*                  PARM                    C11@10
124000120619    *C*                  PARM                    C11@01
124100120619    *C*                  ENDIF
124200120619    ***
124300120619    *C*                  ENDSR
124400120619   S***S
