000100130606   X***X CARRIER CONTROL ID #0000000049 ASSURANT ASO SPECIFIC
000200130524   X***X SSK 05.24.2013 TEMPLATE DESIGN
000300130606   X***X THIS WAS BASED ON THE AEB6X0R DESIGN AND MODIFIED FROM THERE.
000400121213   X***X
000500121213   X***X
000600130606   X***X 06.06.2013 CLONED FROM AEB6X0R
000700130606   X***X    CONSIDERING THE LIMITED PRODUCT; HARDCODE EVERYTHING
000800130606   X***X    ACCOUNT WILL BE USED TO SWITCH IT OFF AS NEEDED
000900130606   X***X    DELETE EVERYTHING ELSE
001000130524   X***X MM.DD.YYYY ASSURANT APPROVED FOR PRODUCTION
001100121213   X***X
001200121213   X***X
001300121213   X***X ACCOUNTS SET-UP
001400130606   X***X 905-001-0179  HABITAT AMERICA LLC
001500121213   X***X
001600121213   X***X
001700121213   X***X
001800121213   X***X
001900121213   X***X
002000121213   X***X
002100121213   X***X
002200121213   X***X
002300121213   X***X
002400121213   X***X
002500121213     FCARXPTP   IF   E           K DISK
002600121213     FCARACCP   IF   E           K DISK
002700121213   X***X
002800130606     FAEB601WF  O  A E             DISK
002900121213     ** EXPORT FILE
003000130606     FAEB604WF  UF A E           K DISK
003100121213     ** TERM TRACKER
003200121213     **
003300121213     FMEMAC#1   IF   E           K DISK
003400121213     FMCOVMPLN  IF   E           K DISK
003500121213     FDEPNDC    IF   E           K DISK
003600121213     FELIGDCOV  IF   E           K DISK
003700121213   X***X
003800130606     D CARR#CTL        S             10A   INZ('0000000049')
003900121213   X***X
004000121213     D DS@CARACC     E DS                  EXTNAME(CARACCP)
004100121213     D DS@CARXPT     E DS                  EXTNAME(CARXPTP)
004200121213   X***X
004300130606     D PLN@CAT         S              5A
004400121213     **
004500121213     D @PLANIN         S              4A
004600121213     D #EFFDTE         S              8S 0
004700121213     D @CCTRIN         S              3A
004800121213     D @ENRIN          S              3A
004900121213     D @ENROU          S              3A
005000121213   X***X
005100121213     **
005200121213     ** WRITE TYPE = MEMBER OR DEPEND
005300121213     D WRT@TYPE        S              6A
005400121213     **
005500121213   X***X
005600121213     D #CANCEL         S              8S 0
005700121213     D #DATE           S              8S 0
005800130320     D #SIGN           S               D   DATFMT(*ISO)
005900121213     D #ISO            S               D   DATFMT(*ISO)
006000121213     D #RECCNT         S             10S 0 INZ
006100121213     D #TODAY          S              8S 0
006200121213     D #XSX            S              8S 0
006300121213     D #15S0           S             15S 0
006400121213     D #7S0            S              7S 0
006500121213     **
006600121213     D MBR_TERM        S               N
006700121213     D TERM_DEN        S               N
006800121213     D YES             S               N   INZ(*ON)
006900121213     D NO              S               N   INZ(*OFF)
007000121213     **
007100121213     D KF@ACC          S                   LIKE(ACC#)
007200121213     D KF@CARG         S              2A   INZ
007300121213     D KF@CCTR         S                   LIKE(CCFLG)
007400121213     D KF@CDE          S              2A
007500121213     D KF@ENR          S              3A   INZ
007600121213     D KF@PLN          S                   LIKE(MCPLAN)
007700121213     D KF@SEQ          S                   LIKE(DPSEQ#)
007800121213     D KF@SSN          S                   LIKE(MBSSNO)
007900121213     D KF@SUB          S                   LIKE(MCSUB#)
008000121213     D KF@TRM          S              8S 0
008100121213     D KF@TRS          S                   LIKE(MCTRST)
008200121213     D KF@TYP          S              1A
008300121213     **
008400121213    ***
008500121213    *** DENTAL ARRAYS
008600121213    *** CAT: PDN, PDE, PDR
008700121213     D DEN#CNE         S              3S 0 INZ
008800121213     D DEN#NDX         S              3S 0 INZ
008900121213     D DEN@PLN         S              4A   DIM(20)
009000121213     D DEN@ENR         S              3A   DIM(20)
009100121213     D DEN@FRM         S              8S 0 DIM(20)
009200121213     D DEN@TRM         S              8S 0 DIM(20)
009300121213     D DEN@MEFF        S              8S 0
009400121213     D DEN@MTRM        S              8S 0
009500121213    ***
009600121213    ***
009700121213    ***
009800121213     D @STEP           S              5A
009900121213   X***X
010000121213     C                   EVAL      @STEP = 'PREP0'
010100121213    ***
010200121213     C                   DOU       @STEP = 'LEAVE'
010300121213     C     @STEP         CASEQ     'PREP0'       $PREP0
010400121213     C     @STEP         CASEQ     'STEP0'       $STEP0
010500121213     C     @STEP         CASEQ     'PREP1'       $PREP1
010600121213     C     @STEP         CASEQ     'STEP1'       $STEP1
010700121213     C     @STEP         CASEQ     'STEP2'       $STEP2
010800121213     C     @STEP         CASEQ     'STEP3'       $STEP3
010900121213     C     @STEP         CASEQ     'PREP4'       $PREP4
011000121213     C     @STEP         CASEQ     'STEP4'       $STEP4
011100121213     C     @STEP         CASEQ     'PREP5'       $PREP5
011200121213     C     @STEP         CASEQ     'STEP5'       $STEP5
011300121213     C     @STEP         CASEQ     'STEP6'       $STEP6
011400121213     C     @STEP         CASEQ     'PREP7'       $PREP7
011500121213     C     @STEP         CASEQ     'STEP7'       $STEP7
011600121213     C                   ENDCS
011700121213     C                   ENDDO
011800121213    ***
011900121213     C                   EVAL      *INLR = *ON
012000121213   S***S
012100121213     C     $PREP0        BEGSR
012200121213    ***
012300121213     C     CARR#CTL      CHAIN     CARXPTR
012400121213    ***
012500121213     C     CARR#CTL      SETLL     CARACCR
012600121213    ***
012700121213     C                   EVAL      #ISO = %DATE
012800121213     C                   MOVE      #ISO          #TODAY
012900121213    ***
013000121213     C                   EVAL      @STEP = 'STEP0'
013100121213    ***
013200121213     C                   ENDSR
013300121213   S***S
013400121213     C     $STEP0        BEGSR
013500121213    ***
013600121213     C     CARR#CTL      READE     CARACCR
013700121213    ***
013800121213     C                   IF        %EOF(CARACCP)
013900121213     C                   EVAL      @STEP = 'LEAVE'
014000121213     C                   LEAVESR
014100121213     C                   ENDIF
014200121213    ***
014300121213    *** CAN THE ACCOUNT BE EXPORTED?
014400121213    ***
014500121213     C                   IF        CASTATUS = 'N'
014600121213     C                   LEAVESR
014700121213     C                   ENDIF
014800121213    ***
014900121213     C                   EVAL      @STEP = 'PREP1'
015000121213    ***
015100121213     C                   ENDSR
015200121213   S***S
015300121213     C     $PREP1        BEGSR
015400121213    ***
015500121213     C                   EVAL      KF@TRS = CATRST
015600121213     C                   EVAL      KF@SUB = CASUB#
015700121213     C                   EVAL      KF@ACC = CAACCT
015800121213    ***
015900121213     C                   EVAL      #RECCNT = 0
016000121213    ***
016100121213     C                   EVAL      @STEP = 'STEP1'
016200121213    ***
016300121213     C                   ENDSR
016400121213   S***S
016500121213   S***S
016600121213     C     $STEP1        BEGSR
016700121213    ***
016800121213     C                   EVAL      KF@PLN = *BLANKS
016900121213     C                   EVAL      KF@TRM = 0
017000121213     C                   EVAL      KF@SSN = 0
017100121213     C                   EVAL      KF@SEQ = 0
017200121213    ***
017300121213     C     KL#TSA        SETLL     MEMBR
017400121213    ***
017500121213     C                   EVAL      @STEP = 'STEP2'
017600121213    ***
017700121213     C                   ENDSR
017800121213   S***S
017900121213     C     $STEP2        BEGSR
018000121213    ***
018100121213     C     KL#TSA        READE     MEMBR
018200121213    ***
018300121213     C                   IF        %EOF(MEMAC#1)
018400121213     C                   EVAL      @STEP = 'STEP0'
018500121213     C                   LEAVESR
018600121213     C                   ENDIF
018700121213    ***
018800121213     C                   EVAL      KF@SSN = MBSSNO
018900121213     C                   MOVE      *ZEROS        KF@SEQ
019000121213    ***
019100121213     C                   IF        TERMDT > 0
019200121213     C                   EVAL      MBR_TERM = YES
019300121213     C                   ELSE
019400121213     C                   EVAL      MBR_TERM = NO
019500121213     C                   ENDIF
019600121213    ***
019700121213     C     KL#MPLN       SETLL     MCOVR
019800121213    ***
019900121213     C                   EXSR      $CLRSTG
020000121213    ***
020100121213     C                   EVAL      @STEP = 'STEP3'
020200121213    ***
020300121213     C                   ENDSR
020400121213   S***S
020500121213     C     $STEP3        BEGSR
020600121213    ***
020700121213     C     KL#MPLN       READE     MCOVR
020800121213    ***
020900121213     C                   IF        %EOF(MCOVMPLN)
021000121213     C                   EVAL      @STEP = 'PREP4'
021100121213     C                   LEAVESR
021200121213     C                   ENDIF
021300121213    ***
021400121213     C                   EVAL      @PLANIN = MCPLAN
021500130606     C                   EVAL      @ENRIN = MCOVTP
021600121213     C                   EVAL      #EFFDTE = ENRLDT
021700121213     C                   EVAL      #CANCEL = CANDT
021800121213     **
021900121213     C                   EXSR      $QUIK
022000121213    ***
022100121213     C                   IF        PLN@CAT = *BLANKS
022200121213     C                   LEAVESR
022300121213     C                   ENDIF
022400121213    ***
022500121213     C                   IF        #CANCEL = 0
022600121213     C                   EVAL      #CANCEL = 99999999
022700121213     C                   ENDIF
022800121213    ***
022900121213     C                   EXSR      $AD2MARY
023000121213    ***
023100121213     C                   ENDSR
023200121213   S***S
023300121213     C     $QUIK         BEGSR
023400130606    ***
023500130606     C                   EVAL      @ENROU = *BLANKS
023600121213     C                   EVAL      @CCTRIN = *BLANKS
023700130606     C                   EVAL      PLN@CAT = *BLANKS
023800121213    ***
023900130606     C                   IF        @PLANIN = 'BAEN' OR @PLANIN = 'BAEP'
024000130606     C                   EVAL      PLN@CAT = 'DEN'
024100130606     C                   EVAL      @ENROU = @ENRIN
024200130606     C                   ENDIF
024300121213    ***
024400121213     C                   ENDSR
024500121213   S***S
024600121213     C     $AD2MARY      BEGSR
024700121213    ***
024800121213    ***
024900121213    *C                   IF        PLN@CAT = 'DEN'
025000121213     C                   IF        DEN#CNE > 0
025100121213     C                   IF        DEN@TRM(DEN#CNE) = 99999999
025200121213     C                   LEAVESR
025300121213     C                   ENDIF
025400121213     C                   ENDIF
025500121213    *C                   ADD       1             DEN#CNE
025600121213    *C                   EVAL      DEN@PLN(DEN#CNE) = @PLANIN
025700121213    *C                   EVAL      DEN@ENR(DEN#CNE) = @ENROU
025800121213    *C                   EVAL      DEN@FRM(DEN#CNE) = #EFFDTE
025900121213    *C                   EVAL      DEN@TRM(DEN#CNE) = #CANCEL
026000121213     C                   LEAVESR
026100121213    *C                   ENDIF
026200121213    ***
026300121213    ***
026400121213     C                   ENDSR
026500121213   S***S
026600121213     C     $PREP4        BEGSR
026700121213    ***
026800130606     C                   IF        DEN#CNE  = 0
026900121213     C                   EVAL      @STEP = 'STEP2'
027000121213     C                   LEAVESR
027100121213     C                   ENDIF
027200121213    ***
027300121213     C                   EVAL      TERM_DEN = NO
027400121213    ***
027500121213     C                   EXSR      $CHKHEM
027600121213    ***
027700121213     C                   EVAL      @STEP = 'STEP4'
027800121213    ***
027900121213     C                   ENDSR
028000121213   S***S
028100121213    *** GENERATE MEMBER RECORD
028200121213    ***
028300121213     C     $STEP4        BEGSR
028400121213    ***
028500130606     C                   IF        DEN#CNE  = 0
028600121213     C                   EVAL      @STEP = 'STEP2'
028700121213     C                   LEAVESR
028800121213     C                   ENDIF
028900121213    ***
029000121213     C                   EVAL      WRT@TYPE = 'MEMBER'
029100121213    ***
029200121213     C                   EVAL      DEN@MEFF = 0
029300121213    ***
029400121213     C                   EXSR      $FILLMBR
029500121213    ***
029600121213     C                   EXSR      $FILLCOVG
029700121213    ***
029800130606     C                   WRITE     AEBF600
029900121213     C                   ADD       1             #RECCNT
030000121213    ***
030100121213     C                   EVAL      @STEP = 'PREP5'
030200121213    ***
030300121213     C                   ENDSR
030400121213   S***S
030500121213     C     $FILLMBR      BEGSR
030600121213    ***
030700130606     C                   CLEAR                   AEBF600
030800121213    ***
030900130606     C                   IF        TERMDT <> 0
031000130606     C                   EVAL      A6RTI = 'T'
031100130606     C                   ELSE
031200130606     C                   EVAL      A6RTI = 'A'
031300130606     C                   ENDIF
031400130606    ***
031500130606     C                   EVAL      A6CID = 'PC'
031600130606     C                   EVAL      A6GID = 'K1900921'
031700130606     C                   EVAL      A6MID = %EDITC(MBSSNO:'X')
031800130606     C                   EVAL      A6SSN = A6MID
031900130606     C                   EVAL      A6RID = '0'
032000130606     C                   EVAL      A6EFDT = %EDITC(MBENRL:'X')
032100130606    ***
032200130606     C                   IF        TERMDT = 0
032300130606     C                   EVAL      A6TRDT = *BLANKS
032400130606     C                   ELSE
032500130606     C                   EVAL      A6TRDT = %EDITC(TERMDT:'X')
032600130606     C                   ENDIF
032700130606    ***
032800130606     C                   EVAL      A6HIRE = %EDITC(EMPDT:'X')
032900130606    ***
033000130606     C                   IF        EMPST = 'C'
033100130606     C                   EVAL      A6CBED = %EDITC(QEDT:'X')
033200130606     C                   EVAL      A6CBTD = %EDITC(CEXPDT:'X')
033300130606     C                   ENDIF
033400130606    ***
033500130606     C                   EVAL      A6NAME = %TRIM(MFNAME) + ' ' + MMI + ' ' +
033600130606     C                                      %TRIM(MLNAME)
033700130606    ***
033800130606     C                   EVAL      A6GNDR = SEX
033900130606     C                   EVAL      A6DOB = %EDITC(BIRTH:'X')
034000130606     C                   EVAL      A6REL = *BLANKS
034100130606     C                   EVAL      A6CLAS = '0001'
034200130606     C                   EVAL      A6DEPT = *BLANKS
034300130606     C                   EVAL      A6LOC = *BLANKS
034400130606     C                   EVAL      A6PAYM = *BLANKS
034500130606     C                   EVAL      A6STDI = *BLANKS
034600130606     C                   EVAL      A6DEPID = *BLANKS
034700130606    ***
034800130606     C                   EVAL      A6ADR1 = %TRIM(ADDR1)
034900130606     C                   EVAL      A6ADR2 = %TRIM(ADDR2)
035000130606     C                   EVAL      A6CITY = %TRIM(CITY)
035100130606     C                   EVAL      A6STAT = STATE
035200130606     C                   MOVE      *BLANKS       @9                9
035300130606     C                   EVAL      @9 = %EDITC(ZIP:'X')
035400130606     C                   EVAL      A6ZIP = %SUBST(@9:1:5)
035500130606    ***
035600130606     C                   EVAL      A6TRC = *BLANKS
035700130606     C                   EVAL      A6PLAN = *BLANKS
035800130606     C                   EVAL      A6DWT = *BLANKS
035900130606     C                   EVAL      A6LCI = '0'
036000130606     C                   EVAL      A6MWT = *BLANKS
036100130606     C                   EVAL      A6CRF = *BLANKS
036200130606     C                   EVAL      A6PCED = *BLANKS
036300121213    ***
036400121213     C                   ENDSR
036500121213   S***S
036600121213     C     $FILLCOVG     BEGSR
036700121213    ***
036800121213    ***
036900121213      * DENTAL
037000121213     C                   EVAL      @PLANIN = DEN@PLN(DEN#CNE)
037100130606      *
037200130606     C                   EVAL      #XSX = DEN@FRM(DEN#CNE)
037300130606     C                   EVAL      A6CHDT = %EDITC(#XSX:'X')
037400130606     C                   MOVE      #XSX          #SIGN
037500130606     C                   SUBDUR    1:*D          #SIGN
037600130606     C                   MOVE      #SIGN         #XSX
037700130606     C                   EVAL      A6SIGN = %EDITC(#XSX:'X')
037800130606      *
037900130606     C                   SELECT
038000130606     C                   WHEN      DEN@ENR(DEN#CNE) = 'TIN'
038100130606     C                   EVAL      A6FI = 'C'
038200130606     C                   WHEN      DEN@ENR(DEN#CNE) = 'TFA'
038300130606     C                   EVAL      A6FI = 'A'
038400130606     C                   WHEN      DEN@ENR(DEN#CNE) = 'THW'
038500130606     C                   EVAL      A6FI = 'B'
038600130606     C                   WHEN      DEN@ENR(DEN#CNE) = 'TPC'
038700130606     C                   EVAL      A6FI = 'D'
038800130606     C                   WHEN      DEN@ENR(DEN#CNE) = 'TP2'
038900130606     C                   EVAL      A6FI = 'D'
039000130606     C                   ENDSL
039100121213      *
039200130606     C                   IF        @PLANIN = 'BAEP'
039300130606     C                   EVAL      A6DID = '0001'
039400130606     C                   ENDIF
039500130606      *
039600130606     C                   IF        @PLANIN = 'BAEN'
039700130606     C                   EVAL      A6DID = '0099'
039800130614     C                   EVAL      A6RTI = 'Z'
039900130606     C                   ENDIF
040000130606    ***
040100130606    *** IF CANDT IS FILLED IN AND STILL OTHERWISE ACTIVE MEMBER, OVERRIDE TO TERM AT CARRIER
040200130606    ***
040300130614     C                   IF        A6RTI = 'A' OR A6RTI = 'Z'
040400130606     C                   EVAL      #XSX = DEN@TRM(DEN#CNE)
040500130606     C                   IF        #XSX > 0 AND #XSX < 99999999
040600130606     C                   EVAL      A6RTI = 'T'
040700130606     C                   EVAL      A6TRDT = %EDITC(#XSX:'X')
040800130606     C                   ENDIF
040900130606     C                   ENDIF
041000121213    ***
041100121213     C                   ENDSR
041200121213   S***S
041300121213     C     $PREP5        BEGSR
041400121213    ***
041500121213     C     KF@SSN        CHAIN     DEPENR
041600121213     C                   IF        NOT %FOUND(DEPNDC)
041700121213     C                   EVAL      @STEP = 'STEP2'
041800121213     C                   LEAVESR
041900121213     C                   ENDIF
042000121213    ***
042100121213     C     KF@SSN        SETLL     DEPENR
042200121213    ***
042300121213     C                   EVAL      @STEP = 'STEP5'
042400121213    ***
042500121213     C                   ENDSR
042600121213   S***S
042700121213     C     $STEP5        BEGSR
042800121213    ***
042900121213     C     KF@SSN        READE     DEPENR
043000121213    ***
043100121213     C                   IF        %EOF(DEPNDC)
043200121213     C                   EVAL      @STEP = 'STEP2'
043300121213     C                   LEAVESR
043400121213     C                   ENDIF
043500121213    ***
043600121213     C                   EVAL      KF@SEQ = DPSEQ#
043700121213    ***
043800121213     C     KL#DCV        CHAIN     DCOVR
043900121213     C                   IF        NOT %FOUND(ELIGDCOV)
044000121213     C                   LEAVESR
044100121213     C                   ENDIF
044200121213    ***
044300121213     C                   EXSR      $CLRSTG
044400121213    ***
044500121213     C     KL#DCV        SETLL     DCOVR
044600121213    ***
044700121213     C                   EVAL      @STEP = 'STEP6'
044800121213    ***
044900121213     C                   ENDSR
045000121213   S***S
045100121213     C     $STEP6        BEGSR
045200121213    ***
045300121213     C     KL#DCV        READE     DCOVR
045400121213    ***
045500121213     C                   IF        %EOF(ELIGDCOV)
045600121213     C                   EVAL      @STEP = 'PREP7'
045700121213     C                   LEAVESR
045800121213     C                   ENDIF
045900121213    ***
046000121213     C                   EVAL      @PLANIN = DVPLAN
046100121213     C                   EVAL      @ENRIN = DVENRL
046200121213     C                   EVAL      #EFFDTE = DENRDT
046300121213     C                   EVAL      #CANCEL = CCANDT
046400121213    ***
046500121213     C                   EXSR      $QUIK
046600121213    ***
046700121213     C                   IF        PLN@CAT = *BLANKS
046800121213     C                   LEAVESR
046900121213     C                   ENDIF
047000121213    ***
047100121213     C                   IF        #CANCEL = 0
047200121213     C                   EVAL      #CANCEL = 99999999
047300121213     C                   ENDIF
047400121213    ***
047500121213     C                   EXSR      $AD2MARY
047600121213    ***
047700121213     C                   ENDSR
047800121213   S***S
047900121213     C     $PREP7        BEGSR
048000121213    ***
048100130606     C                   IF        DEN#CNE  = 0
048200121213     C                   EVAL      @STEP = 'STEP5'
048300121213     C                   LEAVESR
048400121213     C                   ENDIF
048500121213    ***
048600121213     C                   EVAL      TERM_DEN = NO
048700121213    ***
048800121213     C                   EXSR      $CHKHEM
048900121213    ***
049000121213     C                   EVAL      @STEP = 'STEP7'
049100121213    ***
049200121213     C                   ENDSR
049300121213   S***S
049400121213     C     $STEP7        BEGSR
049500121213    ***
049600130606     C                   IF        DEN#CNE  = 0
049700121213     C                   EVAL      @STEP = 'STEP5'
049800121213     C                   LEAVESR
049900121213     C                   ENDIF
050000121213    ***
050100121213     C                   EVAL      WRT@TYPE = 'DEPEND'
050200121213    ***
050300121213     C                   EXSR      $FILLDEP
050400121213    ***
050500121213     C                   EXSR      $FILLCOVG
050600121213    ***
050700130606     C                   WRITE     AEBF600
050800121213     C                   ADD       1             #RECCNT
050900121213    ***
051000121213     C                   EVAL      @STEP = 'STEP5'
051100121213    ***
051200121213     C                   ENDSR
051300121213   S***S
051400121213     C     $FILLDEP      BEGSR
051500121213    ***
051600130606     C                   CLEAR                   AEBF600
051700130606    ***
051800130606    *** IF MEMBER TERMS, DEPENDENTS TERM BY DEFAULT, ELSE ASSUME ACTIVE
051900130606    ***
052000130606     C                   IF        TERMDT <> 0
052100130606     C                   EVAL      A6RTI = 'T'
052200130606     C                   ELSE
052300130606     C                   EVAL      A6RTI = 'A'
052400130606     C                   ENDIF
052500130606    ***
052600130606     C                   EVAL      A6CID = 'PC'
052700130606     C                   EVAL      A6GID = 'K1900921'
052800130606     C                   EVAL      A6MID = %EDITC(MBSSNO:'X')
052900130606     C                   EVAL      A6SSN = *BLANKS
053000130606     C                   EVAL      A6RID = '1'
053100130606     C                   EVAL      A6EFDT = %EDITC(MBENRL:'X')
053200130606    ***
053300130606     C                   IF        TERMDT = 0
053400130606     C                   EVAL      A6TRDT = *BLANKS
053500130606     C                   ELSE
053600130606     C                   EVAL      A6TRDT = %EDITC(TERMDT:'X')
053700130606     C                   ENDIF
053800130606    ***
053900130606     C                   EVAL      A6HIRE = *BLANKS
054000130606    ***
054100130606     C                   IF        EMPST = 'C'
054200130606     C                   EVAL      A6CBED = %EDITC(QEDT:'X')
054300130606     C                   EVAL      A6CBTD = %EDITC(CEXPDT:'X')
054400130606     C                   ENDIF
054500130606    ***
054600130606     C                   EVAL      A6NAME = %TRIM(DFNAME) + ' ' + DMI + ' ' +
054700130606     C                                      %TRIM(DLNAME)
054800130606    ***
054900130606     C                   EVAL      A6GNDR = DSEX
055000130606     C                   EVAL      A6DOB = %EDITC(DBIRTH:'X')
055100130606    ***
055200130606     C                   SELECT
055300130606     C                   WHEN      DRELCD = 'RSO'
055400130606     C                   EVAL      A6REL = 'S'
055500130606     C                   WHEN      DRELCD = 'RDA'
055600130606     C                   EVAL      A6REL = 'D'
055700130606     C                   WHEN      DRELCD = 'RWI'
055800130606     C                   EVAL      A6REL = 'W'
055900130606     C                   WHEN      DRELCD = 'RHU'
056000130606     C                   EVAL      A6REL = 'H'
056100130606     C                   WHEN      DRELCD = 'RPA' AND DSEX = 'W'
056200130606     C                   EVAL      A6REL = 'W'
056300130606     C                   WHEN      DRELCD = 'RPA' AND DSEX = 'M'
056400130606     C                   EVAL      A6REL = 'H'
056500130606     C                   ENDSL
056600130606    ***
056700130606     C                   EVAL      A6CLAS = '0001'
056800130606     C                   EVAL      A6DEPT = *BLANKS
056900130606     C                   EVAL      A6LOC = *BLANKS
057000130606     C                   EVAL      A6PAYM = *BLANKS
057100130606    ***
057200130606     C                   SELECT
057300130606     C                   WHEN      DSTUDN = 'Y' AND
057400130606     C                             (A6REL = 'H' OR A6REL = 'W')
057500130606     C                   EVAL      A6STDI = 'A'
057600130606     C                   WHEN      DSTUDN = 'Y' AND
057700130606     C                             (A6REL = 'S' OR A6REL = 'D')
057800130606     C                   EVAL      A6STDI = 'S'
057900130606     C                   OTHER
058000130606     C                   EVAL      A6STDI = *BLANKS
058100130606     C                   ENDSL
058200130606    ***
058300130606     C                   IF        DEPSS# > 0
058400130606     C                   EVAL      A6DEPID = %EDITC(DEPSS#:'X')
058500130606     C                   ELSE
058600130606     C                   EVAL      A6DEPID = *BLANKS
058700130606     C                   ENDIF
058800130606    ***
058900130606     C                   EVAL      A6ADR1 = %TRIM(ADDR1)
059000130606     C                   EVAL      A6ADR2 = %TRIM(ADDR2)
059100130606     C                   EVAL      A6CITY = %TRIM(CITY)
059200130606     C                   EVAL      A6STAT = STATE
059300130606     C                   MOVE      *BLANKS       @9                9
059400130606     C                   EVAL      @9 = %EDITC(ZIP:'X')
059500130606     C                   EVAL      A6ZIP = %SUBST(@9:1:5)
059600130606    ***
059700130606     C                   EVAL      A6TRC = *BLANKS
059800130606     C                   EVAL      A6PLAN = *BLANKS
059900130606     C                   EVAL      A6DWT = 'T'
060000130606     C                   EVAL      A6LCI = *BLANKS
060100130606     C                   EVAL      A6MWT = *BLANKS
060200130606     C                   EVAL      A6CRF = *BLANKS
060300130606     C                   EVAL      A6PCED = *BLANKS
060400121213    ***
060500121213     C                   ENDSR
060600121213   S***S
060700121213     C     *INZSR        BEGSR
060800121213    ***
060900121213     C                   EVAL      #RECCNT = 0
061000121213    ***
061100121213     C     KL#ACCTL      KLIST
061200121213     C                   KFLD                    CARR#CTL
061300121213     C                   KFLD                    KF@TRS
061400121213     C                   KFLD                    KF@SUB
061500121213     C                   KFLD                    KF@ACC
061600121213    ***
061700121213     C     KL#AUX        KLIST
061800121213     C                   KFLD                    KF@TRS
061900121213     C                   KFLD                    KF@SUB
062000121213     C                   KFLD                    KF@ACC
062100121213     C                   KFLD                    KF@SSN
062200121213     C                   KFLD                    KF@SEQ
062300121213    ***
062400121213     C     KL#TSA        KLIST
062500121213     C                   KFLD                    KF@TRS
062600121213     C                   KFLD                    KF@SUB
062700121213     C                   KFLD                    KF@ACC
062800121213    ***
062900121213     C     KL#MPLN       KLIST
063000121213     C                   KFLD                    KF@SSN
063100121213     C                   KFLD                    KF@SEQ
063200121213     C                   KFLD                    KF@TRS
063300121213     C                   KFLD                    KF@SUB
063400121213     C                   KFLD                    KF@ACC
063500121213    ***
063600121213     C     KL#CPLN       KLIST
063700121213     C                   KFLD                    CARR#CTL
063800121213     C                   KFLD                    KF@TRS
063900121213     C                   KFLD                    KF@SUB
064000121213     C                   KFLD                    KF@ACC
064100121213     C                   KFLD                    KF@CCTR
064200121213     C                   KFLD                    KF@PLN
064300121213    ***
064400121213     C     KL#DCV        KLIST
064500121213     C                   KFLD                    KF@SSN
064600121213     C                   KFLD                    KF@SEQ
064700121213    ***
064800121213     C     KL#MTR        KLIST
064900121213     C                   KFLD                    KF@SSN
065000121213     C                   KFLD                    KF@SEQ
065100121213     C                   KFLD                    KF@TRM
065200121213     C                   KFLD                    KF@PLN
065300121213     C                   KFLD                    KF@ENR
065400121213     C                   KFLD                    KF@TRS
065500121213     C                   KFLD                    KF@SUB
065600121213     C                   KFLD                    KF@ACC
065700121213    ***
065800121213     C                   ENDSR
065900121213   S***S
066000121213     C     $CLRSTG       BEGSR
066100121213    ***
066200121213     C                   EVAL      #CANCEL = 0
066300121213    ***
066400121213     C                   EVAL                    DEN#CNE = 0
066500121213     C                   EVAL                    DEN#NDX = 0
066600121213     C                   CLEAR                   DEN@PLN
066700121213     C                   CLEAR                   DEN@ENR
066800121213     C                   CLEAR                   DEN@FRM
066900121213     C                   CLEAR                   DEN@TRM
067000121213    ***
067100121213     C                   ENDSR
067200121213   S***S
067300121213     C     $CHKHEM       BEGSR
067400121213    ***
067500121213     C                   IF        DEN#CNE > 0 AND DEN@TRM(DEN#CNE) <> 99999999
067600121213     C                   EXSR      $CHKDEN
067700121213     C                   ENDIF
067800121213    ***
067900121213     C                   ENDSR
068000121213   S***S
068100121213    *C     $WRTERM       BEGSR
068200121213    ***
068300130606    *C                   CLEAR                   AEB604F
068400121213     C                   EVAL      NTSSNO         = KF@SSN
068500121213     C                   EVAL      NTDEPNO        = KF@SEQ
068600121213     C                   EVAL      NTTERMDT       = KF@TRM
068700121213     C                   EVAL      NTPLAN         = KF@PLN
068800121213     C                   EVAL      NTCOVTP        = KF@ENR
068900121213     C                   EVAL      NTTRST         = KF@TRS
069000121213     C                   EVAL      NTSUB#         = KF@SUB
069100121213     C                   EVAL      NTACCT         = KF@ACC
069200121213     C                   EVAL      NTTRANSDT      = #TODAY
069300121213     C                   EVAL      NTCOUNT = 1
069400130606     C                   WRITE     AEB604F
069500121213    ***
069600121213    *C                   ENDSR
069700121213   S***S
069800121213      * CHECK FOR DENTAL TERMINATION
069900121213    *C     $CHKDEN       BEGSR
070000121213    ***
070100121213    *C                   EVAL      TERM_DEN = YES
070200121213    *C                   EVAL      KF@TRM = DEN@TRM(DEN#CNE)
070300121213    *C                   EVAL      KF@PLN = DEN@PLN(DEN#CNE)
070400121213    *C                   EVAL      KF@ENR = DEN@ENR(DEN#CNE)
070500121213    ***
070600130606    *C     KL#MTR        CHAIN     AEB604F
070700130606    *C                   IF        %FOUND(AEB604WF)
070800130606      *
070900121213     C                   IF        NTCOUNT > 1
071000130606      * *
071100121213    *C                   EVAL      DEN#CNE = 0
071200121213    *C                   EVAL      TERM_DEN = NO
071300130606      * *
071400121213     C                   ELSE
071500130606      * *
071600121213     C                   ADD       1             NTCOUNT
071700121213     C                   EVAL      NTTRANSD2      = #TODAY
071800130606     C                   UPDATE    AEB604F
071900130606      * *
072000121213     C                   ENDIF
072100130606     C                   LEAVESR
072200130606      *
072300121213    *C                   ENDIF
072400121213    ***
072500121213     C                   EXSR      $WRTERM
072600121213    ***
072700121213    *C                   ENDSR
072800121213   S***S
