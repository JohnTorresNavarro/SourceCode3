000100120913   X***X CARRIER CONTROL ID #0000000064 CIGNA SPECIFIC
000200120619   X***X SSK 06.19.2012 TEMPLATE DESIGN
000300120619   X***X
000400120913   X***X 09.13.2012 CLONED FROM CGNR0X0 MODIFIED FOR FACETS PLATFORM
000500120619   X***X MM.DD.YYYY CIGNA APPROVED FOR PRODUCTION
000600120619   X***X
000700120619   X***X
000800120619   X***X ACCOUNTS SET-UP
000900120913   X***X 590-207-0002  TRI-GAS & OIL COMPANY
001000120619   X***X
001100120619   X***X
001200120619   X***X
001300120619   X***X
001400120619   X***X
001500120619     FCARXPTP   IF   E           K DISK
001600120619     FCARACCP   IF   E           K DISK
001700120917     FCARPLNP   IF   E           K DISK
001800120619   X***X
001900120913     FCGNW020   IF A E           K DISK
002000120913     FCGNW021   IF A E           K DISK
002100120913     FCGNW022   IF A E           K DISK
002200120913     ** WORK FILE2
002300120913     FCGNW024   IF A E           K DISK
002400120619     ** TERM TRACKER
002500120619     **
002600120619     FMEMAC#1   IF   E           K DISK
002700120619     FMCOVMPLN  IF   E           K DISK
002800120619     FDEPNDC    IF   E           K DISK
002900120621     FELIGDCOV  IF   E           K DISK
003000120913     **
003100120917   X***X
003200120917     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
003300120917     D DS@CARACC     E DS                  EXTNAME(CARACCP)
003400120917     D DS@CARXPT     E DS                  EXTNAME(CARXPTP)
003500120917   X***X
003600120917     D CARR#CTL        S             10A   INZ('0000000064')
003700120917     D CARPLN@       E DS                  EXTNAME(CARPLNP)
003800120917     D                                     OCCURS(60) PREFIX(X:1)
003900120917     ** PC# - PLAN COUNT
004000120917     ** PP# - PLAN POINTER
004100120917     **
004200120917     D PC#             S              3S 0
004300120917     D PP#             S              3S 0
004400120619   X***X
004500120917     D #CANCEL         S              8S 0
004600120917     D #DATE           S              8S 0
004700120917     D #EFFDTE         S              8S 0
004800120917     D #ISO            S               D   DATFMT(*ISO)
004900120917     D #TODAY          S              8S 0
005000120917     D #UKEY           S              6S 0 INZ(0)
005100120917     D #XSX            S              8S 0
005200120917     D #10             S             10S 0
005300120917     D #15LIMIT        S              8S 0
005400120917     D #8D0            S              8S 0
005500120917     D #8D1            S              8S 0
005600120917   X***X
005700120917     D KF@ACC          S                   LIKE(ACC#)
005800120917     D KF@ENR          S              3A   INZ
005900120917     D KF@PLN          S                   LIKE(MCPLAN)
006000120917     D KF@SEQ          S                   LIKE(DPSEQ#)
006100120917     D KF@SSN          S                   LIKE(MBSSNO)
006200120917     D KF@SUB          S                   LIKE(MCSUB#)
006300120917     D KF@TRM          S                   LIKE(NTTERMDT)
006400120917     D KF@TRS          S                   LIKE(MCTRST)
006500120917   X***X
006600120917     D @PLANIN         S              4A
006700120917     D @STEP           S              5A
006800120917     D @14KEY          S             14A
006900120917   X***X
007000120917     D TERM_MED        S               N
007100120917     D TERM_DEN        S               N
007200120917     D TERM_RXD        S               N
007300120917     D TERM_VIS        S               N
007400120917     D YES             S               N   INZ(*ON)
007500120917     D NO              S               N   INZ(*OFF)
007600120917   X***X
007700120917     D WRT@TYPE        S              6A
007800120917     D Y               S              3S 0
007900120917   X***X
008000120913   X***X
008100120913     ** WORK ARRAY FOR PLANS
008200120913     **
008300120913    ***
008400120913    *** MEDICAL ARRAYS
008500120913    *** CAT: PMM, PDM, PSM
008600120917     D MED#CNE         S              3S 0 INZ
008700120917     D MED#NDX         S              3S 0 INZ
008800120917     D MED@PLN         S              4A   DIM(20)
008900120917     D MED@FRM         S              8S 0 DIM(20)
009000120917     D MED@TRM         S              8S 0 DIM(20)
009100120917     D MED@MEFF        S              8S 0
009200120913    ***
009300120913    *** DENTAL ARRAYS
009400120913    *** CAT: PDN, PDE, PDR
009500120917     D DEN#CNE         S              3S 0 INZ
009600120917     D DEN#NDX         S              3S 0 INZ
009700120917     D DEN@PLN         S              4A   DIM(20)
009800120917     D DEN@FRM         S              8S 0 DIM(20)
009900120917     D DEN@TRM         S              8S 0 DIM(20)
010000120917     D DEN@MEFF        S              8S 0
010100120913    ***
010200120913    *** PRESCRIPTION DRUG ARRAYS
010300120913    *** CAT: PRX
010400120917     D RXD#CNE         S              3S 0 INZ
010500120917     D RXD#NDX         S              3S 0 INZ
010600120917     D RXD@PLN         S              4A   DIM(20)
010700120917     D RXD@FRM         S              8S 0 DIM(20)
010800120917     D RXD@TRM         S              8S 0 DIM(20)
010900120917     D RXD@MEFF        S              8S 0
011000120913    ***
011100120913    *** VISION         ARRAYS
011200120913    *** CAT: PVS, PVR
011300120917     D VIS#CNE         S              3S 0 INZ
011400120917     D VIS#NDX         S              3S 0 INZ
011500120917     D VIS@PLN         S              4A   DIM(20)
011600120917     D VIS@FRM         S              8S 0 DIM(20)
011700120917     D VIS@TRM         S              8S 0 DIM(20)
011800120917     D VIS@MEFF        S              8S 0
011900120913    ***
012000120913    ***
012100120622    ***
012200120619   X***X
012300120619     C                   EVAL      @STEP = 'PREP0'
012400120619    ***
012500120619     C                   DOU       @STEP = 'LEAVE'
012600120619     C     @STEP         CASEQ     'PREP0'       $PREP0
012700120619     C     @STEP         CASEQ     'STEP0'       $STEP0
012800120619     C     @STEP         CASEQ     'PREP1'       $PREP1
012900120619     C     @STEP         CASEQ     'STEP1'       $STEP1
013000120619     C     @STEP         CASEQ     'STEP2'       $STEP2
013100120619     C     @STEP         CASEQ     'STEP3'       $STEP3
013200120619     C     @STEP         CASEQ     'PREP4'       $PREP4
013300120619     C     @STEP         CASEQ     'STEP4'       $STEP4
013400120619     C     @STEP         CASEQ     'PREP5'       $PREP5
013500120619     C     @STEP         CASEQ     'STEP5'       $STEP5
013600120619     C     @STEP         CASEQ     'STEP6'       $STEP6
013700120619     C     @STEP         CASEQ     'PREP7'       $PREP7
013800120619     C     @STEP         CASEQ     'STEP7'       $STEP7
013900120619     C                   ENDCS
014000120619     C                   ENDDO
014100120619    ***
014200120619     C                   EVAL      *INLR = *ON
014300120619   S***S
014400120619     C     $PREP0        BEGSR
014500120619    ***
014600120619     C     CARR#CTL      CHAIN     CARXPTR
014700120619    ***
014800120619     C     CARR#CTL      SETLL     CARACCR
014900120619    ***
015000120619     C                   EVAL      #ISO = %DATE
015100120917     C                   MOVE      #ISO          #TODAY
015200120913    ***
015300120913     C                   EVAL      @14KEY = %EDITC(#TODAY:'X') + 'TRIGAS'
015400120913    ***
015500120621     C                   ADDDUR    15:*D         #ISO
015600120917     C                   MOVE      #ISO          #15LIMIT
015700120619    ***
015800120619     C                   EVAL      @STEP = 'STEP0'
015900120619    ***
016000120619     C                   ENDSR
016100120619   S***S
016200120619     C     $STEP0        BEGSR
016300120619    ***
016400120619     C     CARR#CTL      READE     CARACCR
016500120619    ***
016600120619     C                   IF        %EOF(CARACCP)
016700120619     C                   EVAL      @STEP = 'LEAVE'
016800120619     C                   LEAVESR
016900120619     C                   ENDIF
017000120619    ***
017100120619    *** CAN THE ACCOUNT BE EXPORTED?
017200120619    ***
017300120619     C                   IF        CASTATUS = 'N'
017400120619     C                   LEAVESR
017500120619     C                   ENDIF
017600120619    ***
017700120619     C                   EVAL      @STEP = 'PREP1'
017800120619    ***
017900120619     C                   ENDSR
018000120619   S***S
018100120619     C     $PREP1        BEGSR
018200120619    ***
018300120619     C                   EVAL      KF@TRS = CATRST
018400120619     C                   EVAL      KF@SUB = CASUB#
018500120619     C                   EVAL      KF@ACC = CAACCT
018600120619    ***
018700120619     C                   EXSR      $PLANLOAD
018800120619    ***
018900120619     C                   EVAL      @STEP = 'STEP1'
019000120619    ***
019100120619     C                   ENDSR
019200120619   S***S
019300120619     C     $STEP1        BEGSR
019400120619    ***
019500120619     C                   EVAL      KF@PLN = *BLANKS
019600120619     C                   EVAL      KF@TRM = 0
019700120619     C                   EVAL      KF@SSN = 0
019800120619     C                   EVAL      KF@SEQ = 0
019900120619    ***
020000120619     C     KL#TSA        SETLL     MEMBR
020100120619    ***
020200120619     C                   EVAL      @STEP = 'STEP2'
020300120619    ***
020400120619     C                   ENDSR
020500120619   S***S
020600120619     C     $STEP2        BEGSR
020700120619    ***
020800120619     C     KL#TSA        READE     MEMBR
020900120619    ***
021000120619     C                   IF        %EOF(MEMAC#1)
021100120619     C                   EVAL      @STEP = 'STEP0'
021200120621     C                   LEAVESR
021300120621     C                   ENDIF
021400120619    ***
021500120619     C                   EVAL      KF@SSN = MBSSNO
021600120619     C                   MOVE      *ZEROS        KF@SEQ
021700120619    ***
021800120619     C     KL#MPLN       SETLL     MCOVR
021900120619    ***
022000120619     C                   EXSR      $CLRSTG
022100120619    ***
022200120619     C                   EVAL      @STEP = 'STEP3'
022300120619    ***
022400120619     C                   ENDSR
022500120619   S***S
022600120619     C     $STEP3        BEGSR
022700120619    ***
022800120619     C     KL#MPLN       READE     MCOVR
022900120619    ***
023000120619     C                   IF        %EOF(MCOVMPLN)
023100120619     C                   EVAL      @STEP = 'PREP4'
023200120619     C                   LEAVESR
023300120619     C                   ENDIF
023400120619    ***
023500120913     C                   IF        ENRLDT = CANDT
023600120913     C                   LEAVESR
023700120913     C                   ENDIF
023800120913    ***
023900120619     C                   EVAL      @PLANIN = MCPLAN
024000120619     C                   EVAL      #EFFDTE = ENRLDT
024100120619     **
024200120619     C                   EXSR      $QUIK
024300120619     **
024400120619     C                   EXSR      $PLANSRCH
024500120619    ***
024600120619     C                   IF        PLN@CAT = *BLANKS
024700120619     C                   LEAVESR
024800120619     C                   ENDIF
024900120619    ***
025000120619     C                   IF        CANDT = 0
025100120619     C                   EVAL      #CANCEL = 99999999
025200120619     C                   ELSE
025300120619     C                   EVAL      #CANCEL = CANDT
025400120619     C                   ENDIF
025500120619    ***
025600120913     C                   EXSR      $MBRADCHK
025700120913    ***
025800120913     C                   ENDSR
025900120913   S***S
026000120913     C     $MBRADCHK     BEGSR
026100120913    ***
026200120913    *C                   IF        PLN@CAT = 'MED'
026300120913    * * *
026400120913     C                   IF        MED#CNE = 0
026500120913     C                   EXSR      $AD2MARY
026600120913     C                   LEAVESR
026700120913     C                   ENDIF
026800120913    * * *
026900120913     C                   EVAL      Y = 0
027000120913     C     1             DO        MED#CNE       Y
027100120913      *
027200120913     C                   IF        MED@PLN(Y) = @PLANIN
027300120913      *
027400120913     C                   IF        MED@TRM(Y) = 99999999
027500120913     C                   LEAVESR
027600120913     C                   ENDIF
027700120913      *
027800120913     C                   MOVE      MED@TRM(Y)    #8D0
027900120913     C                   MOVE      MED@TRM(Y)    #ISO
028000120913     C                   ADDDUR    1:*D          #ISO
028100120913     C                   MOVE      #ISO          #8D1
028200120913      *
028300120913     C                   IF        #EFFDTE = #8D0 OR #EFFDTE = #8D1
028400120913     C                   Z-ADD     #CANCEL       MED@TRM(Y)
028500120913     C                   LEAVESR
028600120913     C                   ENDIF
028700120913      *
028800120913     C                   ENDIF
028900120913      *
029000120913     C                   ENDDO
029100120913    * * *
029200120913     C                   EXSR      $AD2MARY
029300120913    * * *
029400120913    *C                   ENDIF
029500120619    ***
029600120913    *C                   IF        PLN@CAT = 'DEN'
029700120913    * * *
029800120913     C                   IF        DEN#CNE = 0
029900120913     C                   EXSR      $AD2MARY
030000120913     C                   LEAVESR
030100120913     C                   ENDIF
030200120913    * * *
030300120913     C                   EVAL      Y = 0
030400120913     C     1             DO        DEN#CNE       Y
030500120913      *
030600120913     C                   IF        DEN@PLN(Y) = @PLANIN
030700120913      *
030800120913     C                   IF        DEN@TRM(Y) = 99999999
030900120913     C                   LEAVESR
031000120913     C                   ENDIF
031100120913      *
031200120913     C                   MOVE      DEN@TRM(Y)    #8D0
031300120913     C                   MOVE      DEN@TRM(Y)    #ISO
031400120913     C                   ADDDUR    1:*D          #ISO
031500120913     C                   MOVE      #ISO          #8D1
031600120913      *
031700120913     C                   IF        #EFFDTE = #8D0 OR #EFFDTE = #8D1
031800120913     C                   Z-ADD     #CANCEL       DEN@TRM(Y)
031900120913     C                   LEAVESR
032000120913     C                   ENDIF
032100120913      *
032200120913     C                   ENDIF
032300120913      *
032400120913     C                   ENDDO
032500120913    * * *
032600120913     C                   EXSR      $AD2MARY
032700120913    * * *
032800120913    *C                   ENDIF
032900120913    ***
033000120913    *C                   IF        PLN@CAT = 'RXD'
033100120913    * * *
033200120913     C                   IF        RXD#CNE = 0
033300120913     C                   EXSR      $AD2MARY
033400120913     C                   LEAVESR
033500120913     C                   ENDIF
033600120913    * * *
033700120913     C                   EVAL      Y = 0
033800120913     C     1             DO        RXD#CNE       Y
033900120913      *
034000120913     C                   IF        RXD@PLN(Y) = @PLANIN
034100120913      *
034200120913     C                   IF        RXD@TRM(Y) = 99999999
034300120913     C                   LEAVESR
034400120913     C                   ENDIF
034500120913      *
034600120913     C                   MOVE      RXD@TRM(Y)    #8D0
034700120913     C                   MOVE      RXD@TRM(Y)    #ISO
034800120913     C                   ADDDUR    1:*D          #ISO
034900120913     C                   MOVE      #ISO          #8D1
035000120913      *
035100120913     C                   IF        #EFFDTE = #8D0 OR #EFFDTE = #8D1
035200120913     C                   Z-ADD     #CANCEL       RXD@TRM(Y)
035300120913     C                   LEAVESR
035400120913     C                   ENDIF
035500120913      *
035600120913     C                   ENDIF
035700120913      *
035800120913     C                   ENDDO
035900120913    * * *
036000120913     C                   EXSR      $AD2MARY
036100120913    * * *
036200120913    *C                   ENDIF
036300120913    ***
036400120913    *C                   IF        PLN@CAT = 'VIS'
036500120913    * * *
036600120913     C                   IF        VIS#CNE = 0
036700120913     C                   EXSR      $AD2MARY
036800120913     C                   LEAVESR
036900120913     C                   ENDIF
037000120913    * * *
037100120913     C                   EVAL      Y = 0
037200120913     C     1             DO        VIS#CNE       Y
037300120913      *
037400120913     C                   IF        VIS@PLN(Y) = @PLANIN
037500120913      *
037600120913     C                   IF        VIS@TRM(Y) = 99999999
037700120913     C                   LEAVESR
037800120913     C                   ENDIF
037900120913      *
038000120913     C                   MOVE      VIS@TRM(Y)    #8D0
038100120913     C                   MOVE      VIS@TRM(Y)    #ISO
038200120913     C                   ADDDUR    1:*D          #ISO
038300120913     C                   MOVE      #ISO          #8D1
038400120913      *
038500120913     C                   IF        #EFFDTE = #8D0 OR #EFFDTE = #8D1
038600120913     C                   Z-ADD     #CANCEL       VIS@TRM(Y)
038700120913     C                   LEAVESR
038800120913     C                   ENDIF
038900120913      *
039000120913     C                   ENDIF
039100120913      *
039200120913     C                   ENDDO
039300120913    * * *
039400120913     C                   EXSR      $AD2MARY
039500120913    * * *
039600120913    *C                   ENDIF
039700120913    ***
039800120619     C                   ENDSR
039900120619   S***S
040000120619     C     $AD2MARY      BEGSR
040100120619    ***
040200120619    *C                   IF        PLN@CAT = 'MED'
040300120619     C                   IF        MED#CNE > 0 AND
040400120619     C                             MED@TRM(MED#CNE) = 99999999
040500120619     C                   LEAVESR
040600120619     C                   ENDIF
040700120619    *C                   ADD       1             MED#CNE
040800120619    *C                   EVAL      MED@PLN(MED#CNE) = @PLANIN
040900120619    *C                   EVAL      MED@FRM(MED#CNE) = #EFFDTE
041000120619    *C                   EVAL      MED@TRM(MED#CNE) = #CANCEL
041100120619     C                   LEAVESR
041200120619    *C                   ENDIF
041300120619    ***
041400120619    *C                   IF        PLN@CAT = 'DEN'
041500120619     C                   IF        DEN#CNE > 0 AND
041600120619     C                             DEN@TRM(DEN#CNE) = 99999999
041700120619     C                   LEAVESR
041800120619     C                   ENDIF
041900120619    *C                   ADD       1             DEN#CNE
042000120619    *C                   EVAL      DEN@PLN(DEN#CNE) = @PLANIN
042100120619    *C                   EVAL      DEN@FRM(DEN#CNE) = #EFFDTE
042200120619    *C                   EVAL      DEN@TRM(DEN#CNE) = #CANCEL
042300120619     C                   LEAVESR
042400120619    *C                   ENDIF
042500120619    ***
042600120621    *C                   IF        PLN@CAT = 'RXD'
042700120619     C                   IF        RXD#CNE > 0 AND
042800120619     C                             RXD@TRM(RXD#CNE) = 99999999
042900120619     C                   LEAVESR
043000120619     C                   ENDIF
043100120619    *C                   ADD       1             RXD#CNE
043200120619    *C                   EVAL      RXD@PLN(RXD#CNE) = @PLANIN
043300120619    *C                   EVAL      RXD@FRM(RXD#CNE) = #EFFDTE
043400120619    *C                   EVAL      RXD@TRM(RXD#CNE) = #CANCEL
043500120619     C                   LEAVESR
043600120619    *C                   ENDIF
043700120619    ***
043800120619    *C                   IF        PLN@CAT = 'VIS'
043900120619     C                   IF        VIS#CNE > 0 AND
044000120619     C                             VIS@TRM(VIS#CNE) = 99999999
044100120619     C                   LEAVESR
044200120619     C                   ENDIF
044300120619    *C                   ADD       1             VIS#CNE
044400120619    *C                   EVAL      VIS@PLN(VIS#CNE) = @PLANIN
044500120619    *C                   EVAL      VIS@FRM(VIS#CNE) = #EFFDTE
044600120619    *C                   EVAL      VIS@TRM(VIS#CNE) = #CANCEL
044700120619     C                   LEAVESR
044800120619    *C                   ENDIF
044900120619    ***
045000120619     C                   ENDSR
045100120619   S***S
045200120619     C     $QUIK         BEGSR
045300120619    ***
045400120619    ***
045500120619     C                   ENDSR
045600120619   S***S
045700120619     C     $PREP4        BEGSR
045800120619    ***
045900120619     C                   IF        RXD#CNE  = 0 AND MED#CNE  = 0 AND
046000120619     C                             VIS#CNE  = 0 AND DEN#CNE  = 0
046100120619     C                   EVAL      @STEP = 'STEP2'
046200120619     C                   LEAVESR
046300120619     C                   ENDIF
046400120619    ***
046500120621     C                   EXSR      $CHK15
046600120621    ***
046700120619     C                   EVAL      TERM_MED = NO
046800120619     C                   EVAL      TERM_DEN = NO
046900120619     C                   EVAL      TERM_RXD = NO
047000120619     C                   EVAL      TERM_VIS = NO
047100120619    ***
047200120619     C                   EXSR      $CHKHEM
047300120619    ***
047400120619     C                   EVAL      @STEP = 'STEP4'
047500120621    ***
047600120621     C                   ENDSR
047700120621   S***S
047800120621    *** 15 DAY LIMIT CHECK
047900120621    ***
048000120621     C     $CHK15        BEGSR
048100120621    ***
048200120621     C                   IF        MED#CNE > 0
048300120621     C                   IF        MED@TRM(MED#CNE) <> 99999999
048400120621     C                   EVAL      #CANCEL = MED@TRM(MED#CNE)
048500120621     C                   IF        #CANCEL > #15LIMIT
048600120917     C                   EVAL      #CANCEL = 99999999
048700120621     C                   EVAL      MED@TRM(MED#CNE) = #CANCEL
048800120621     C                   ENDIF
048900120621     C                   ENDIF
049000120621     C                   ENDIF
049100120621    ***
049200120621     C                   IF        DEN#CNE > 0
049300120621     C                   IF        DEN@TRM(DEN#CNE) <> 99999999
049400120621     C                   EVAL      #CANCEL = DEN@TRM(DEN#CNE)
049500120621     C                   IF        #CANCEL > #15LIMIT
049600120917     C                   EVAL      #CANCEL = 99999999
049700120621     C                   EVAL      DEN@TRM(DEN#CNE) = #CANCEL
049800120621     C                   ENDIF
049900120621     C                   ENDIF
050000120621     C                   ENDIF
050100120619    ***
050200120621     C                   IF        RXD#CNE > 0
050300120621     C                   IF        RXD@TRM(RXD#CNE) <> 99999999
050400120621     C                   EVAL      #CANCEL = RXD@TRM(RXD#CNE)
050500120621     C                   IF        #CANCEL > #15LIMIT
050600120917     C                   EVAL      #CANCEL = 99999999
050700120621     C                   EVAL      RXD@TRM(RXD#CNE) = #CANCEL
050800120621     C                   ENDIF
050900120621     C                   ENDIF
051000120621     C                   ENDIF
051100120621    ***
051200120621     C                   IF        VIS#CNE > 0
051300120621     C                   IF        VIS@TRM(VIS#CNE) <> 99999999
051400120621     C                   EVAL      #CANCEL = VIS@TRM(VIS#CNE)
051500120621     C                   IF        #CANCEL > #15LIMIT
051600120917     C                   EVAL      #CANCEL = 99999999
051700120621     C                   EVAL      VIS@TRM(VIS#CNE) = #CANCEL
051800120621     C                   ENDIF
051900120621     C                   ENDIF
052000120621     C                   ENDIF
052100120621    ***
052200120619     C                   ENDSR
052300120619   S***S
052400120619    *** GENERATE MEMBER RECORD
052500120619    ***
052600120619     C     $STEP4        BEGSR
052700120619    ***
052800120619     C                   IF        RXD#CNE  = 0 AND MED#CNE  = 0 AND
052900120619     C                             VIS#CNE  = 0 AND DEN#CNE  = 0
053000120619     C                   EVAL      @STEP = 'STEP2'
053100120619     C                   LEAVESR
053200120619     C                   ENDIF
053300120619    ***
053400120619     C                   EVAL      WRT@TYPE = 'MEMBER'
053500120619    ***
053600120913     C                   IF        MED#CNE > 0
053700120913     C                   EVAL      MED@MEFF = MED@FRM(MED#CNE)
053800120913     C                   ENDIF
053900120917    ***
054000120913     C                   IF        DEN#CNE > 0
054100120913     C                   EVAL      DEN@MEFF = DEN@FRM(DEN#CNE)
054200120913     C                   ENDIF
054300120917    ***
054400120913     C                   IF        RXD#CNE > 0
054500120913     C                   EVAL      RXD@MEFF = RXD@FRM(RXD#CNE)
054600120913     C                   ENDIF
054700120917    ***
054800120913     C                   IF        VIS#CNE > 0
054900120913     C                   EVAL      VIS@MEFF = VIS@FRM(VIS#CNE)
055000120913     C                   ENDIF
055100120619    ***
055200120619     C                   EXSR      $FILLMBR
055300120619     C                   EXSR      $FILLCOVG
055400121221     C                   WRITE     CGNF020
055500120621    ***
055600120619     C                   EVAL      @STEP = 'PREP5'
055700120619    ***
055800120619     C                   ENDSR
055900120619   S***S
056000120619     C     $FILLMBR      BEGSR
056100120619    ***
056200120913     C                   CLEAR                   CGNF020
056300120917     C                   MOVE      *ZEROS        KF@SEQ
056400120619    ***
056500120913     C                   EVAL      F0GRPID = CACID1
056600120917     C                   ADD       1             #UKEY
056700120913     C                   EVAL      F0FAMLK = @14KEY + %EDITC(#UKEY:'X')
056800120917     C                   EVAL      F0FAMSQ = %EDITC(KF@SEQ:'X')
056900120913    ***
057000120913     C                   EVAL      F0LNAM = %TRIM(MLNAME)
057100120913     C                   EVAL      F0FNAM = %TRIM(MFNAME)
057200120913     C                   EVAL      F0MI   = MMI
057300120619    ***
057400120913     C                   EVAL      F0DOB  = %EDITC(BIRTH:'X')
057500120913     C                   EVAL      F0GENDER = SEX
057600120619    ***
057700120913     C                   EVAL      F0ADDR1 = %TRIM(ADDR1)
057800120913     C                   EVAL      F0ADDR2 = %TRIM(ADDR2)
057900120913     C                   EVAL      F0CITY = %TRIM(CITY)
058000120913     C                   EVAL      F0STATE = STATE
058100120619    ***
058200120619     C                   MOVE      *BLANKS       @9                9
058300120619     C                   EVAL      @9 = %EDITC(ZIP:'X')
058400120913     C                   EVAL      F0ZIP = %SUBST(@9:1:5)
058500120619    ***
058600120913     C                   EVAL      F0SSN = %EDITC(MBSSNO:'X')
058700120913    ***
058800120913     C                   EVAL      #10 = (AREA * 10000000) + PHONE
058900120913     C                   IF        #10 = 0
059000120913     C                   EVAL      F0PHON = *BLANKS
059100120913     C                   ELSE
059200120913     C                   EVAL      F0PHON = %EDITC(#10:'X')
059300120913     C                   ENDIF
059400120913    ***
059500120917     C                   IF        EMPST = 'C'
059600120913     C                   EVAL      F0COBRA = 'C'
059700120619     C                   ELSE
059800120913     C                   EVAL      F0COBRA = *BLANKS
059900120619     C                   ENDIF
060000120619    ***
060100120619     C                   Z-ADD     EMPDT         #DATE
060200120913     C                   EVAL      F0HIRE = %EDITC(#DATE:'X')
060300120619    ***
060400120917     C                   Z-ADD     EMPDT         #DATE
060500120917     C                   IF        MED#CNE > 0
060600120917     C                   IF        #DATE < MED@FRM(1)
060700120917     C                   EVAL      #DATE = MED@FRM(1)
060800120917     C                   ENDIF
060900120917     C                   ENDIF
061000120917     C                   IF        DEN#CNE > 0
061100120917     C                   IF        #DATE < DEN@FRM(1)
061200120917     C                   EVAL      #DATE = DEN@FRM(1)
061300120917     C                   ENDIF
061400120917     C                   ENDIF
061500120917     C                   IF        RXD#CNE > 0
061600120917     C                   IF        #DATE < RXD@FRM(1)
061700120917     C                   EVAL      #DATE = RXD@FRM(1)
061800120917     C                   ENDIF
061900120917     C                   ENDIF
062000120917     C                   IF        VIS#CNE > 0
062100120917     C                   IF        #DATE < VIS@FRM(1)
062200120917     C                   EVAL      #DATE = VIS@FRM(1)
062300120917     C                   ENDIF
062400120917     C                   ENDIF
062500120917     C                   EVAL      F0EFFDT = %EDITC(#DATE:'X')
062600120917    ***
062700120917     C                   IF        TERMDT > 0
062800120917     C                   EVAL      F0TRMDT = %EDITC(TERMDT:'X')
062900120917     C                   ENDIF
063000120917    ***
063100120619     C                   ENDSR
063200120619   S***S
063300120619     C     $FILLCOVG     BEGSR
063400120619    ***
063500120619     C                   IF        MED#CNE > 0
063600120619      * MEDICAL
063700120619     C                   EVAL      @PLANIN = MED@PLN(MED#CNE)
063800120619     C                   EXSR      $QUIK
063900120619     C                   EXSR      $PLANSRCH
064000120619     C                   IF        PLN@CAT = *BLANKS
064100120619     C     'MED FILL'    DSPLY     '*EXT'
064200120619     C                   SETON                                        H1
064300120619     C                   ENDIF
064400120619      *
064500120917     C                   EXSR      $FMT22
064600120917      *
064700120917     C                   EVAL      #XSX    = MED@FRM(MED#CNE)
064800120917     C                   EVAL      F2PLNEF = %EDITC(#XSX:'X')
064900121221     C                   EVAL      F0SUBGRP = CPCID1
065000121221     C                   EVAL      F0CLSID = CPCID2
065100121221     C                   IF        #XSX < 20120801
065200121221     C                   EVAL      F0SGEFF = '20120801'
065300121221     C                   EVAL      F0CLSEFF = '20120801'
065400121221     C                   ELSE
065500121221     C                   EVAL      F0SGEFF = %EDITC(#XSX:'X')
065600121221     C                   EVAL      F0CLSEFF = %EDITC(#XSX:'X')
065700121221     C                   ENDIF
065800120917      *
065900120917     C                   EVAL      #XSX    = MED@TRM(MED#CNE)
066000120917     C                   IF        #XSX = 99999999
066100120917     C                   EVAL      F2PLNTR = *BLANKS
066200120917     C                   ELSE
066300120917     C                   EVAL      F2PLNTR = %EDITC(#XSX:'X')
066400120917     C                   ENDIF
066500120917      *
066600120917     C                   WRITE     CGNF022
066700120917      *
066800120917     C                   ENDIF
066900120619    ***
067000120619     C                   IF        DEN#CNE > 0
067100120619      * DENTAL
067200120621     C                   EVAL      @PLANIN = DEN@PLN(DEN#CNE)
067300120621     C                   EXSR      $QUIK
067400120621     C                   EXSR      $PLANSRCH
067500120621     C                   IF        PLN@CAT = *BLANKS
067600120621     C     'DEN FILL'    DSPLY     '*EXT'
067700120621     C                   SETON                                        H1
067800120621     C                   ENDIF
067900120621      *
068000120917     C                   EXSR      $FMT22
068100120917      *
068200120621     C                   EVAL      #XSX   = DEN@FRM(DEN#CNE)
068300120917     C                   EVAL      F2PLNEF = %EDITC(#XSX:'X')
068400120621      *
068500120621     C                   EVAL      #XSX   = DEN@TRM(DEN#CNE)
068600120917     C                   IF        #XSX = 99999999
068700120917     C                   EVAL      F2PLNTR = *BLANKS
068800120917     C                   ELSE
068900120917     C                   EVAL      F2PLNTR = %EDITC(#XSX:'X')
069000120917     C                   ENDIF
069100120621      *
069200120917     C                   WRITE     CGNF022
069300120619      *
069400120619     C                   ENDIF
069500120619    ***
069600120619     C                   IF        RXD#CNE > 0
069700120619      * RXD
069800120621     C                   EVAL      @PLANIN = RXD@PLN(RXD#CNE)
069900120621     C                   EXSR      $QUIK
070000120621     C                   EXSR      $PLANSRCH
070100120621     C                   IF        PLN@CAT = *BLANKS
070200120621     C     'RXD FILL'    DSPLY     '*EXT'
070300120621     C                   SETON                                        H1
070400120621     C                   ENDIF
070500120621      *
070600120917     C                   EXSR      $FMT22
070700120917      *
070800120621     C                   EVAL      #XSX   = RXD@FRM(RXD#CNE)
070900120917     C                   EVAL      F2PLNEF = %EDITC(#XSX:'X')
071000120621      *
071100120917     C                   EVAL      #XSX   = RXD@TRM(RXD#CNE)
071200120917     C                   IF        #XSX = 99999999
071300120917     C                   EVAL      F2PLNTR = *BLANKS
071400120917     C                   ELSE
071500120917     C                   EVAL      F2PLNTR = %EDITC(#XSX:'X')
071600120917     C                   ENDIF
071700120917      *
071800120917     C                   WRITE     CGNF022
071900120621      *
072000120619     C                   ENDIF
072100120619    ***
072200120619     C                   IF        VIS#CNE > 0
072300120619      *  VISION
072400120621     C                   EVAL      @PLANIN = VIS@PLN(VIS#CNE)
072500120621     C                   EXSR      $QUIK
072600120621     C                   EXSR      $PLANSRCH
072700120621     C                   IF        PLN@CAT = *BLANKS
072800120621     C     'VIS FILL'    DSPLY     '*EXT'
072900120621     C                   SETON                                        H1
073000120621     C                   ENDIF
073100120621      *
073200120917     C                   EXSR      $FMT22
073300120917      *
073400120621     C                   EVAL      #XSX   = VIS@FRM(VIS#CNE)
073500120917     C                   EVAL      F2PLNEF = %EDITC(#XSX:'X')
073600120917      *
073700120917     C                   EVAL      #XSX   = VIS@TRM(VIS#CNE)
073800120917     C                   IF        #XSX = 99999999
073900120917     C                   EVAL      F2PLNTR = *BLANKS
074000120917     C                   ELSE
074100120917     C                   EVAL      F2PLNTR = %EDITC(#XSX:'X')
074200120917     C                   ENDIF
074300120917      *
074400120917     C                   WRITE     CGNF022
074500120619      *
074600120619     C                   ENDIF
074700120917    ***
074800120917     C                   ENDSR
074900120917   S***S
075000120917     C     $FMT22        BEGSR
075100120917    ***
075200120917     C                   CLEAR                   CGNF022
075300120917     C                   EVAL      F2GRPID = F0GRPID
075400120917     C                   EVAL      F2FAMLK = F0FAMLK
075500120917     C                   EVAL      F2FAMSQ = %EDITC(KF@SEQ:'X')
075600120917     C                   EVAL      F2PLNID = CPCID3
075700120619    ***
075800120619     C                   ENDSR
075900120619   S***S
076000120619     C     $PREP5        BEGSR
076100120619    ***
076200120619     C     KF@SSN        CHAIN     DEPENR
076300120619     C                   IF        NOT %FOUND(DEPNDC)
076400120619     C                   EVAL      @STEP = 'STEP2'
076500120619     C                   LEAVESR
076600120619     C                   ENDIF
076700120619    ***
076800120619     C     KF@SSN        SETLL     DEPENR
076900120619    ***
077000120619     C                   EVAL      @STEP = 'STEP5'
077100120619    ***
077200120619     C                   ENDSR
077300120619   S***S
077400120619     C     $STEP5        BEGSR
077500120619    ***
077600120619     C     KF@SSN        READE     DEPENR
077700120619    ***
077800120619     C                   IF        %EOF(DEPNDC)
077900120619     C                   EVAL      @STEP = 'STEP2'
078000120619     C                   LEAVESR
078100120619     C                   ENDIF
078200120619    ***
078300120619     C                   EVAL      KF@SEQ = DPSEQ#
078400120619    ***
078500120619     C     KL#DCV        CHAIN     DCOVR
078600120619     C                   IF        NOT %FOUND(ELIGDCOV)
078700120619     C                   LEAVESR
078800120619     C                   ENDIF
078900120619    ***
079000120619     C                   EXSR      $CLRSTG
079100120619    ***
079200120619     C     KL#DCV        SETLL     DCOVR
079300120619    ***
079400120619     C                   EVAL      @STEP = 'STEP6'
079500120619    ***
079600120619     C                   ENDSR
079700120619   S***S
079800120619     C     $STEP6        BEGSR
079900120619    ***
080000120619     C     KL#DCV        READE     DCOVR
080100120619    ***
080200120619     C                   IF        %EOF(ELIGDCOV)
080300120619     C                   EVAL      @STEP = 'PREP7'
080400120619     C                   LEAVESR
080500120619     C                   ENDIF
080600120619    ***
080700120917     C                   IF        DENRDT = CCANDT
080800120917     C                   LEAVESR
080900120917     C                   ENDIF
081000120619    ***
081100120619     C                   EVAL      @PLANIN = DVPLAN
081200120619     C                   EVAL      #EFFDTE = DENRDT
081300120621     C*                  EVAL      #BENAMT = 0
081400120619    ***
081500120619     C                   EXSR      $QUIK
081600120619    ***
081700120619     C                   EXSR      $PLANSRCH
081800120619    ***
081900120619     C                   IF        PLN@CAT = *BLANKS
082000120619     C                   LEAVESR
082100120619     C                   ENDIF
082200120619    ***
082300120619     C                   EVAL      #CANCEL = CCANDT
082400120619     C                   IF        #CANCEL = 0
082500120619     C                   EVAL      #CANCEL = 99999999
082600120619     C                   ENDIF
082700120917    ***
082800120917     C                   EXSR      $MBRADCHK
082900120619    ***
083000120619     C                   ENDSR
083100120619   S***S
083200120619     C     $PREP7        BEGSR
083300120619    ***
083400120621     C                   IF        RXD#CNE  = 0 AND MED#CNE  = 0 AND
083500120621     C                             VIS#CNE  = 0 AND DEN#CNE  = 0
083600120619     C                   EVAL      @STEP = 'STEP5'
083700120619     C                   LEAVESR
083800120619     C                   ENDIF
083900120619    ***
084000120917     C                   EXSR      $CHK15
084100120917    ***
084200120619     C                   EVAL      TERM_MED = NO
084300120619     C                   EVAL      TERM_DEN = NO
084400120619     C                   EVAL      TERM_RXD = NO
084500120619     C                   EVAL      TERM_VIS = NO
084600120619    ***
084700120619     C                   EXSR      $CHKHEM
084800120619    ***
084900120619     C                   EVAL      @STEP = 'STEP7'
085000120619    ***
085100120619     C                   ENDSR
085200120619   S***S
085300120619     C     $STEP7        BEGSR
085400120619    ***
085500120621     C                   IF        RXD#CNE  = 0 AND MED#CNE  = 0 AND
085600120621     C                             VIS#CNE  = 0 AND DEN#CNE  = 0
085700120619     C                   EVAL      @STEP = 'STEP5'
085800120619     C                   LEAVESR
085900120619     C                   ENDIF
086000120619    ***
086100120619     C                   EVAL      WRT@TYPE = 'DEPEND'
086200120619    ***
086300120619     C                   EXSR      $FILLDEP
086400120619     C                   EXSR      $FILLCOVG
086500121221     C                   WRITE     CGNF021
086600120619    ***
086700120619     C                   EVAL      @STEP = 'STEP5'
086800120619    ***
086900120619     C                   ENDSR
087000120619   S***S
087100120619     C     $FILLDEP      BEGSR
087200120619    ***
087300120917     C                   CLEAR                   CGNF021
087400120917     C                   MOVE      DPSEQ#        KF@SEQ
087500120619    ***
087600120917     C                   EVAL      F1GRPID = F0GRPID
087700120917     C                   EVAL      F1FAMLK = F0FAMLK
087800120917     C                   EVAL      F1FAMSQ = %EDITC(KF@SEQ:'X')
087900120621    ***
088000120917     C                   EVAL      F1LNAM = %TRIM(DLNAME)
088100120917     C                   EVAL      F1FNAM = %TRIM(DFNAME)
088200120917     C                   EVAL      F1MI   = DMI
088300120621    ***
088400120917     C                   EVAL      F1DOB  = %EDITC(DBIRTH:'X')
088500120917     C                   EVAL      F1GENDER = DSEX
088600120621     C                   IF        DEPSS# > 0
088700120917     C                   EVAL      F1SSN = %EDITC(DEPSS#:'X')
088800120621     C                   ELSE
088900120917     C                   EVAL      F1SSN = *BLANKS
089000120621     C                   ENDIF
089100120621    ***
089200120621     C                   IF        DADDR1 = ADDR1 OR %TRIM(DADDR1) = 'SAME'
089300120621      * ***
089400120917     C                   EVAL      F1ADDR1 = F0ADDR1
089500120917     C                   EVAL      F1ADDR2 = F0ADDR2
089600120917     C                   EVAL      F1CITY  = F0CITY
089700120917     C                   EVAL      F1STATE = F0STATE
089800120917     C                   EVAL      F1ZIP   = F0ZIP
089900120917     C                   EVAL      F1PHON  = F0PHON
090000120621      * ***
090100120621     C                   ELSE
090200120621      * ***
090300120917     C                   EVAL      F1ADDR1 = %TRIM(DADDR1)
090400120917     C                   EVAL      F1ADDR2 = %TRIM(DADDR2)
090500120917     C                   EVAL      F1CITY  = %TRIM(DCITY)
090600120917     C                   EVAL      F1STATE = DSTATE
090700120621     C                   MOVE      *BLANKS       @9
090800120621     C                   EVAL      @9 = %EDITC(DZIP:'X')
090900120917     C                   EVAL      F1ZIP = %SUBST(@9:1:5)
091000120621     C                   EVAL      #10 = (DAREA * 10000000) + DPHONE
091100120621     C                   IF        #10 > 0
091200120917     C                   EVAL      F1PHON = %EDITC(#10:'X')
091300120621     C                   ELSE
091400120917     C                   EVAL      F1PHON = *BLANKS
091500120621     C                   ENDIF
091600120621      * ***
091700120621     C                   ENDIF
091800120621    ***
091900120621     C                   IF        DSTUDN = 'Y'
092000130115     C                   EVAL      F1STUD = 'F'
092100120621     C                   ELSE
092200120917     C                   EVAL      F1STUD = *BLANKS
092300120621     C                   ENDIF
092400120917    ***
092500120917     C                   EVAL      F1COBRA = F0COBRA
092600120621    ***
092700120621     C                   SELECT
092800120621     C                   WHEN      DRELCD = 'RWI' OR DRELCD = 'RHU'
092900120917     C                   EVAL      F1RELCD = 'SP'
093000120621     C                   WHEN      DRELCD = 'RSO' OR DRELCD = 'RDA'
093100120917     C                   EVAL      F1RELCD = 'CH'
093200120621     C                   WHEN      DRELCD = 'RPA'
093300120917     C                   EVAL      F1RELCD = 'DP'
093400120621     C                   ENDSL
093500120619    ***
093600120917     C                   Z-ADD     99999999      #DATE
093700120917     C                   IF        MED#CNE > 0
093800120917     C                   IF        #DATE > MED@FRM(1)
093900120917     C                   EVAL      #DATE = MED@FRM(1)
094000120917     C                   ENDIF
094100120917     C                   ENDIF
094200120917     C                   IF        DEN#CNE > 0
094300120917     C                   IF        #DATE > DEN@FRM(1)
094400120917     C                   EVAL      #DATE = DEN@FRM(1)
094500120917     C                   ENDIF
094600120917     C                   ENDIF
094700120917     C                   IF        RXD#CNE > 0
094800120917     C                   IF        #DATE > RXD@FRM(1)
094900120917     C                   EVAL      #DATE = RXD@FRM(1)
095000120917     C                   ENDIF
095100120917     C                   ENDIF
095200120917     C                   IF        VIS#CNE > 0
095300120917     C                   IF        #DATE > VIS@FRM(1)
095400120917     C                   EVAL      #DATE = VIS@FRM(1)
095500120917     C                   ENDIF
095600120917     C                   ENDIF
095700120917     C                   EVAL      F1EFFDT = %EDITC(#DATE:'X')
095800120917    ***
095900120917     C                   Z-ADD     0             #DATE
096000120917     C                   IF        MED#CNE > 0
096100120917     C                   IF        #DATE < MED@TRM(MED#CNE)
096200120917     C                   EVAL      #DATE = MED@TRM(MED#CNE)
096300120917     C                   ENDIF
096400120917     C                   ENDIF
096500120917     C                   IF        DEN#CNE > 0
096600120917     C                   IF        #DATE < DEN@TRM(DEN#CNE)
096700120917     C                   EVAL      #DATE = DEN@TRM(DEN#CNE)
096800120917     C                   ENDIF
096900120917     C                   ENDIF
097000120917     C                   IF        RXD#CNE > 0
097100120917     C                   IF        #DATE < RXD@TRM(RXD#CNE)
097200120917     C                   EVAL      #DATE = RXD@TRM(RXD#CNE)
097300120917     C                   ENDIF
097400120917     C                   ENDIF
097500120917     C                   IF        VIS#CNE > 0
097600120917     C                   IF        #DATE < VIS@TRM(VIS#CNE)
097700120917     C                   EVAL      #DATE = VIS@TRM(VIS#CNE)
097800120917     C                   ENDIF
097900120917     C                   ENDIF
098000120917     C                   IF        #DATE <> 0 AND #DATE <> 99999999
098100120917     C                   EVAL      F1TRMDT = %EDITC(#DATE:'X')
098200120917     C                   ENDIF
098300120917    ***
098400120619     C                   ENDSR
098500120619   S***S
098600120619     C     *INZSR        BEGSR
098700120619    ***
098800120619     C     *ENTRY        PLIST
098900120619     C                   PARM                    @F               10
099000120619    ***
099100120619     C     KL#ACCTL      KLIST
099200120619     C                   KFLD                    CARR#CTL
099300120619     C                   KFLD                    KF@TRS
099400120619     C                   KFLD                    KF@SUB
099500120619     C                   KFLD                    KF@ACC
099600120619    ***
099700120619     C     KL#TSA        KLIST
099800120619     C                   KFLD                    KF@TRS
099900120619     C                   KFLD                    KF@SUB
100000120619     C                   KFLD                    KF@ACC
100100120619    ***
100200120619     C     KL#MPLN       KLIST
100300120619     C                   KFLD                    KF@SSN
100400120619     C                   KFLD                    KF@SEQ
100500120619     C                   KFLD                    KF@TRS
100600120619     C                   KFLD                    KF@SUB
100700120619     C                   KFLD                    KF@ACC
100800120619    ***
100900120619     C     KL#CPLN       KLIST
101000120619     C                   KFLD                    CARR#CTL
101100120619     C                   KFLD                    KF@TRS
101200120619     C                   KFLD                    KF@SUB
101300120619     C                   KFLD                    KF@PLN
101400120917     C                   KFLD                    KF@ACC
101500120619    ***
101600120619     C     KL#DCV        KLIST
101700120619     C                   KFLD                    KF@SSN
101800120619     C                   KFLD                    KF@SEQ
101900120619    ***
102000120619     C     KL#MTR        KLIST
102100120619     C                   KFLD                    KF@SSN
102200120619     C                   KFLD                    KF@SEQ
102300120917     C                   KFLD                    KF@TRM
102400120619     C                   KFLD                    KF@PLN
102500120619     C                   KFLD                    KF@ENR
102600120619     C                   KFLD                    KF@TRS
102700120619     C                   KFLD                    KF@SUB
102800120619     C                   KFLD                    KF@ACC
102900120619    ***
103000120619     C                   ENDSR
103100120619   S***S
103200120619    *** PLANS LOADED BY ACCOUNT
103300120619    ***
103400120619     C     $PLANLOAD     BEGSR
103500120619    ***
103600120619     C                   EVAL      PP# = 0
103700120619     C                   DO        50
103800120619     C                   ADD       1             PP#
103900120619     C     PP#           OCCUR     CARPLN@
104000120619     C                   CLEAR                   CARPLN@
104100120619     C                   ENDDO
104200120619     C                   EVAL      PC# = 0
104300120619     C                   EVAL      PP# = 0
104400120619    ***
104500120619     C     KL#ACCTL      SETLL     CARPLNR
104600120917     C                   DOU       %EOF(CARPLNP)
104700120619     C     KL#ACCTL      READE     CARPLNR
104800120917     C                   IF        NOT %EOF(CARPLNP)
104900120619    ***
105000120619     C                   ADD       1             PC#
105100120619     C     PC#           OCCUR     CARPLN@
105200120619     C                   EVAL      CARPLN@ = DS@CARPLN
105300120619    ***
105400120619     C                   ENDIF
105500120619     C                   ENDDO
105600120619    ***
105700120619     C                   ENDSR
105800120619   S***S
105900120619     C     $CLRSTG       BEGSR
106000120619    ***
106100120619     C                   EVAL      #CANCEL = 0
106200120621    ***
106300120619     C                   EVAL                    MED#CNE = 0
106400120619     C                   EVAL                    MED#NDX = 0
106500120619     C                   CLEAR                   MED@PLN
106600120619     C                   CLEAR                   MED@FRM
106700120619     C                   CLEAR                   MED@TRM
106800120619    ***
106900120619     C                   EVAL                    DEN#CNE = 0
107000120619     C                   EVAL                    DEN#NDX = 0
107100120619     C                   CLEAR                   DEN@PLN
107200120619     C                   CLEAR                   DEN@FRM
107300120619     C                   CLEAR                   DEN@TRM
107400120619    ***
107500120619     C                   EVAL                    RXD#CNE = 0
107600120619     C                   EVAL                    RXD#NDX = 0
107700120619     C                   CLEAR                   RXD@PLN
107800120619     C                   CLEAR                   RXD@FRM
107900120619     C                   CLEAR                   RXD@TRM
108000120619    ***
108100120619     C                   EVAL                    VIS#CNE = 0
108200120619     C                   EVAL                    VIS#NDX = 0
108300120619     C                   CLEAR                   VIS@PLN
108400120619     C                   CLEAR                   VIS@FRM
108500120619     C                   CLEAR                   VIS@TRM
108600120619    ***
108700120619     C                   ENDSR
108800120619   S***S
108900120619     C     $CHKHEM       BEGSR
109000120619    ***
109100120619     C                   IF        MED#CNE > 0 AND MED@TRM(MED#CNE) <> 99999999
109200120619     C                   EXSR      $CHKMED
109300120619     C                   ENDIF
109400120619    ***
109500120619     C                   IF        DEN#CNE > 0 AND DEN@TRM(DEN#CNE) <> 99999999
109600120619     C                   EXSR      $CHKDEN
109700120619     C                   ENDIF
109800120619    ***
109900120619     C                   IF        RXD#CNE > 0 AND RXD@TRM(RXD#CNE) <> 99999999
110000120619     C                   EXSR      $CHKRXD
110100120619     C                   ENDIF
110200120619    ***
110300120619     C                   IF        VIS#CNE > 0 AND VIS@TRM(VIS#CNE) <> 99999999
110400120619     C                   EXSR      $CHKVIS
110500120619     C                   ENDIF
110600120619    ***
110700120619     C                   ENDSR
110800120619   S***S
110900120619      * CHECK FOR MEDICAL TERMINATION
111000120619    *C     $CHKMED       BEGSR
111100120619    ***
111200120619    *C                   EVAL      TERM_MED = YES
111300120917    *C                   EVAL      KF@TRM = MED@TRM(MED#CNE)
111400120619    *C                   EVAL      KF@PLN = MED@PLN(MED#CNE)
111500120917    *C                   EVAL      KF@ENR = 'XXX'
111600120619    ***
111700120917    *C     KL#MTR        CHAIN     CGNF024
111800120917    *C                   IF        %FOUND(CGNW024)
111900120619    *C                   EVAL      MED#CNE = 0
112000120619    *C                   EVAL      TERM_MED = NO
112100120619     C                   LEAVESR
112200120619    *C                   ENDIF
112300120619    ***
112400120619     C                   EXSR      $WRTERM
112500120619    ***
112600120619    *C                   ENDSR
112700120619   S***S
112800120619    *C     $WRTERM       BEGSR
112900120619    ***
113000120917    *C                   CLEAR                   CGNF024
113100120619     C                   EVAL      NTSSNO         = KF@SSN
113200120619     C                   EVAL      NTDEPNO        = KF@SEQ
113300120917     C                   EVAL      NTTERMDT       = KF@TRM
113400120619     C                   EVAL      NTPLAN         = KF@PLN
113500120619     C                   EVAL      NTCOVTP        = KF@ENR
113600120619     C                   EVAL      NTTRST         = KF@TRS
113700120619     C                   EVAL      NTSUB#         = KF@SUB
113800120619     C                   EVAL      NTACCT         = KF@ACC
113900120619     C                   EVAL      NTTRANSDT      = #TODAY
114000120917     C                   WRITE     CGNF024
114100120619    ***
114200120619    *C                   ENDSR
114300120619   S***S
114400120619      * CHECK FOR DENTAL TERMINATION
114500120619    *C     $CHKDEN       BEGSR
114600120619    ***
114700120619    *C                   EVAL      TERM_DEN = YES
114800120917    *C                   EVAL      KF@TRM = DEN@TRM(DEN#CNE)
114900120619    *C                   EVAL      KF@PLN = DEN@PLN(DEN#CNE)
115000120917    *C                   EVAL      KF@ENR = 'XXX'
115100120619    ***
115200120917    *C     KL#MTR        CHAIN     CGNF024
115300120917    *C                   IF        %FOUND(CGNW024)
115400120619    *C                   EVAL      DEN#CNE = 0
115500120619    *C                   EVAL      TERM_DEN = NO
115600120619    *C                   ENDIF
115700120619    ***
115800120619     C                   EXSR      $WRTERM
115900120619    ***
116000120619    *C                   ENDSR
116100120619   S***S
116200120619      * CHECK FOR DRUG TERMINATION
116300120619    *C     $CHKRXD       BEGSR
116400120619    ***
116500120619    *C                   EVAL      TERM_RXD = YES
116600120917    *C                   EVAL      KF@TRM = RXD@TRM(RXD#CNE)
116700120619    *C                   EVAL      KF@PLN = RXD@PLN(RXD#CNE)
116800120917    *C                   EVAL      KF@ENR = 'XXX'
116900120619    ***
117000120917    *C     KL#MTR        CHAIN     CGNF024
117100120917    *C                   IF        %FOUND(CGNW024)
117200120619    *C                   EVAL      RXD#CNE = 0
117300120619    *C                   EVAL      TERM_RXD = NO
117400120619    *C                   ENDIF
117500120619    ***
117600120619     C                   EXSR      $WRTERM
117700120619    ***
117800120619    *C                   ENDSR
117900120619   S***S
118000120619      * CHECK FOR VISION TERMINATION
118100120619    *C     $CHKVIS       BEGSR
118200120619    ***
118300120619    *C                   EVAL      TERM_VIS = YES
118400120917    *C                   EVAL      KF@TRM = VIS@TRM(VIS#CNE)
118500120619    *C                   EVAL      KF@PLN = VIS@PLN(VIS#CNE)
118600120917    *C                   EVAL      KF@ENR = 'XXX'
118700120619    ***
118800120917    *C     KL#MTR        CHAIN     CGNF024
118900120917    *C                   IF        %FOUND(CGNW024)
119000120619    *C                   EVAL      VIS#CNE = 0
119100120619    *C                   EVAL      TERM_VIS = NO
119200120619    *C                   ENDIF
119300120619    ***
119400120619     C                   EXSR      $WRTERM
119500120619    ***
119600120619    *C                   ENDSR
119700120619   S***S
119800120619     C     $PLANSRCH     BEGSR
119900120619    ***
120000120619     C                   MOVE      *BLANKS       PLN@CAT          10
120100120619     C                   EVAL      PP# = 0
120200120619     C                   CLEAR                   DS@CARPLN
120300120619    ***
120400120619     C                   DO        PC#
120500120619    * *
120600120619     C                   ADD       1             PP#
120700120619     C     PP#           OCCUR     CARPLN@
120800120619    * *
120900120917     C                   IF        XPPLAN = @PLANIN
121000120619     C                   EVAL      DS@CARPLN = CARPLN@
121100120917     C                   EVAL      PLN@CAT = XPCID4
121200120619     C                   LEAVE
121300120619     C                   ENDIF
121400120619    * *
121500120619     C                   ENDDO
121600120619    ***
121700120619     C                   ENDSR
121800120619   S***S
