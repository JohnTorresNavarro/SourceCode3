000100131028   X***X CARRIER CONTROL ID #0000000101 AVESIS GENERIC
000200131025   X***X SSK 10.26.2013 TEMPLATE DESIGN
000300110824   X***X
000400131028   X***X 10.30.2013 CLONED FROM AVER0X0
000500131025   X***X MM.DD.YYYY AVESIS APPROVED FOR PRODUCTION
000600110824   X***X
000700110824   X***X
000800110824   X***X ACCOUNTS SET-UP
000900131028   X***X ***-***-****  LOTS
001000110824   X***X
001100110824   X***X
001200110824   X***X
001300110824   X***X
001400110824     FCARXPTP   IF   E           K DISK
001500110824     FCARACCP   IF   E           K DISK
001600110824     FCARPLNP   IF   E           K DISK
001700110824   X***X
001800131028     FAVEW011   IF A E           K DISK
001900131025    ***   AVESIS DEPENDENT/MEMBER SEQUENCE NUMBER TRACKER
002000131028     FAVEW011L  IF   E           K DISK    RENAME(AVEF011:Z1F) PREFIX(ZZ:2)
002100131025    ***   AVESIS DEPENDENT/MEMBER SEQUENCE NUMBER TRACKER
002200131025   X***X
002300131028     FAVEW010   O  A E             DISK
002400131028    ***   ELIG EXPORT FILE
002500131028     FAVEW012   IF A E           K DISK
002600131028    ***   AVESIS TERM TRACKER
002700131028   X***X
002800110824     **
002900110824     FMEMAC#1   IF   E           K DISK
003000131028     **
003100110824     FMCOVMPLN  IF   E           K DISK
003200131028     **
003300110824     FDEPNDC    IF   E           K DISK
003400131028     **
003500131028     FDCOVC     IF   E           K DISK
003600131028     **
003700110824   X***X
003800131028     D CARR#CTL        S             10A   INZ('0000000101')
003900110824   X***X
004000110824     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
004100110824     D DS@CARACC     E DS                  EXTNAME(CARACCP)
004200110824     D DS@CARXPT     E DS                  EXTNAME(CARXPTP)
004300110824   X***X
004400110824     ** WORK ARRAY FOR PLANS
004500110824     **
004600110824     ** PC# - PLAN COUNT
004700110824     ** PP# - PLAN POINTER
004800110824     **
004900110824     D CARPLN@       E DS                  EXTNAME(CARPLNP)
005000110824     D                                     OCCURS(60) PREFIX(X:1)
005100110824     D PC#             S              3S 0
005200110824     D PP#             S              3S 0
005300110824     D @PLANIN         S              4A
005400111115     D #EFFDTE         S              8S 0
005500110824     D @CCTRIN         S              3A
005600111006     D @ENRIN          S              3A
005700111006     D @ENROU          S              3A
005800110824   X***X
005900111006     D C11@10          S             10A
006000111006     D C11@01          S              1A
006100110824     **
006200110824     ** WRITE TYPE = MEMBER OR DEPEND
006300110824     D WRT@TYPE        S              6A
006400110824     **
006500130118     D #TODAY          S              8S 0
006600111006     D #DATE           S              8S 0
006700110824     D #ISO            S               D   DATFMT(*ISO)
006800110824     D #CANCEL         S              8S 0
006900130118     D PLN@CAT         S             10A
007000131028     D @NXTNO          S              2A
007100131028     D #NXTNO          S              2S 0
007200130118     D @9              S              9A
007300110824     D #XSX            S              8S 0
007400110824     D DATE@OUT        S             10A
007500111006     D DNTLATE         S              1A
007600121128   X***X
007700111006     D TERM_VIS        S               N
007800110824     D YES             S               N   INZ(*ON)
007900110824     D NO              S               N   INZ(*OFF)
008000121128   X***X
008100110824     D KF@TRS          S                   LIKE(MCTRST)
008200110824     D KF@SUB          S                   LIKE(MCSUB#)
008300110824     D KF@ACC          S                   LIKE(ACC#)
008400110824     D KF@ENR          S              3A   INZ
008500110824     D KF@CCTR         S                   LIKE(CCFLG)
008600110824     D KF@PLN          S                   LIKE(MCPLAN)
008700110824     D KF@TRM          S                   LIKE(NTTERMDT)
008800110824     D KF#TRM          S              8S 0
008900110824     D KF@SSN          S                   LIKE(MBSSNO)
009000110824     D KF@SEQ          S                   LIKE(DPSEQ#)
009100131028     D MBRENR          S              3A   INZ
009200110824    ***
009300110824    *** VISION         ARRAYS
009400110824    *** CAT: PVS, PVR
009500110824     D VIS#CNE         S              3S 0 INZ
009600110824     D VIS#NDX         S              3S 0 INZ
009700131028     D VIS@PLN         S              4A   DIM(40)
009800131028     D VIS@ENR         S              3A   DIM(40)
009900131028     D VIS@FRM         S              8S 0 DIM(40)
010000131028     D VIS@TRM         S              8S 0 DIM(40)
010100110824     D VIS@MEFF        S              8S 0
010200110824    ***
010300110824    ***
010400110824    ***
010500110824     D @STEP           S              5A
010600110824   X***X
010700131028     C                   EVAL      @STEP = 'PREP0'
010800110824    ***
010900110824     C                   DOU       @STEP = 'LEAVE'
011000131028     C     @STEP         CASEQ     'SEQBB'       $SEQBB
011100131025     C     @STEP         CASEQ     'SEQAA'       $SEQAA
011200111007     C     @STEP         CASEQ     'PREP0'       $PREP0
011300111007     C     @STEP         CASEQ     'STEP0'       $STEP0
011400111007     C     @STEP         CASEQ     'PREP1'       $PREP1
011500111007     C     @STEP         CASEQ     'STEP1'       $STEP1
011600111007     C     @STEP         CASEQ     'STEP2'       $STEP2
011700111007     C     @STEP         CASEQ     'STEP3'       $STEP3
011800111007     C     @STEP         CASEQ     'PREP4'       $PREP4
011900111007     C     @STEP         CASEQ     'STEP4'       $STEP4
012000111007     C     @STEP         CASEQ     'PREP5'       $PREP5
012100111007     C     @STEP         CASEQ     'STEP5'       $STEP5
012200111007     C     @STEP         CASEQ     'STEP6'       $STEP6
012300111007     C     @STEP         CASEQ     'PREP7'       $PREP7
012400111007     C     @STEP         CASEQ     'STEP7'       $STEP7
012500110824     C                   ENDCS
012600110824     C                   ENDDO
012700111006    ***
012800110824     C                   EVAL      *INLR = *ON
012900110824   S***S
013000110824     C     $PREP0        BEGSR
013100110824    ***
013200110824     C     CARR#CTL      CHAIN     CARXPTR
013300110824    ***
013400110824     C     CARR#CTL      SETLL     CARACCR
013500110824    ***
013600110824     C                   EVAL      #ISO = %DATE
013700130118     C                   MOVE      #ISO          #TODAY
013800110824    ***
013900110824     C                   EVAL      @STEP = 'STEP0'
014000110824    ***
014100110824     C                   ENDSR
014200110824   S***S
014300110824     C     $STEP0        BEGSR
014400110824    ***
014500110824     C     CARR#CTL      READE     CARACCR
014600110824    ***
014700110824     C                   IF        %EOF(CARACCP)
014800110824     C                   EVAL      @STEP = 'LEAVE'
014900110824     C                   LEAVESR
015000110824     C                   ENDIF
015100110824    ***
015200110825    *** CAN THE ACCOUNT BE EXPORTED?
015300110824    ***
015400110825     C                   IF        CASTATUS = 'N'
015500110824     C                   LEAVESR
015600110824     C                   ENDIF
015700111025    ***
015800131028     C                   EVAL      @STEP = 'SEQAA'
015900131028    ***
016000131028     C                   EVAL      KF@TRS = CATRST
016100131028     C                   EVAL      KF@SUB = CASUB#
016200131028     C                   EVAL      KF@ACC = CAACCT
016300131028    ***
016400131028     C     KL#TSA        SETLL     MEMBR
016500131028    ***
016600131028     C                   ENDSR
016700131028   S***S
016800131028     C     $SEQAA        BEGSR
016900131028    ***
017000131028     C     KL#TSA        READE     MEMBR
017100131028    ***
017200131028     C                   IF        %EOF(MEMAC#1)
017300131028     C                   EVAL      @STEP = 'PREP1'
017400131028     C                   LEAVESR
017500131028     C                   ENDIF
017600131028    ***
017700131028     C                   EVAL      KF@SSN = MBSSNO
017800131028     C                   MOVE      *ZEROS        KF@SEQ
017900131028    ***
018000131028     C     KL#TSASQ      CHAIN     AVEF011
018100131028     C                   IF        NOT %FOUND(AVEW011)
018200131028     C                   EVAL      @NXTNO = '00'
018300131028     C                   EXSR      $WRTSEQ
018400131028     C                   ENDIF
018500131028    ***
018600131028     C     KF@SSN        CHAIN     DEPENR
018700131028     C                   IF        %FOUND(DEPNDC)
018800131028     C     KF@SSN        SETLL     DEPENR
018900131028     C                   EVAL      @STEP = 'SEQBB'
019000131028     C                   ENDIF
019100131028    ***
019200131028     C                   ENDSR
019300131028   S***S
019400131028     C     $WRTSEQ       BEGSR
019500131028    ***
019600131028     C                   CLEAR                   AVEF011
019700131028     C                   EVAL      AVTRST = KF@TRS
019800131028     C                   EVAL      AVSUB# = KF@SUB
019900131028     C                   EVAL      AVACCT = KF@ACC
020000131028     C                   EVAL      AVSSNO = KF@SSN
020100131028     C                   EVAL      AVDEPNO = KF@SEQ
020200131028     C                   EVAL      AVSIDSFX = @NXTNO
020300131028     C                   WRITE     AVEF011
020400110824    ***
020500110824     C                   ENDSR
020600110824   S***S
020700131028     C     $SEQBB        BEGSR
020800131028    ***
020900131028     C     KF@SSN        READE     DEPENR
021000131028    ***
021100131028     C                   IF        %EOF(DEPNDC)
021200131028     C                   EVAL      @STEP = 'SEQAA'
021300131028     C                   LEAVESR
021400131028     C                   ENDIF
021500131028    ***
021600131028     C                   MOVE      DPSEQ#        KF@SEQ
021700131028    ***
021800131028     C     KL#TSASQ      CHAIN     AVEF011
021900131028     C                   IF        %FOUND(AVEW011)
022000131028     C                   LEAVESR
022100131028     C                   ENDIF
022200131028    ***
022300131028     C                   IF        DRELCD = 'RPA' OR DRELCD = 'RHU' OR
022400131028     C                             DRELCD = 'RWI'
022500131028     C                   EVAL      @NXTNO = '02'
022600131028     C                   ELSE
022700131028     C                   EXSR      $NXTNUM
022800131028     C                   ADD       1             #NXTNO
022900131028     C                   IF        #NXTNO < 3
023000131028     C                   EVAL      #NXTNO = 3
023100131028     C                   ENDIF
023200131028     C                   MOVE      #NXTNO        @NXTNO
023300131028     C                   ENDIF
023400131028    ***
023500131028     C                   EXSR      $WRTSEQ
023600131028    ***
023700131028     C                   ENDSR
023800131028   S***S
023900131028     C     $NXTNUM       BEGSR
024000131028    ***
024100131028     C     KL#TSAS       SETGT     Z1F
024200131028     C     KL#TSAS       READPE    Z1F
024300131028    ***
024400131028     C                   MOVE      ZZSIDSFX      #NXTNO
024500131028    ***
024600131028     C                   ENDSR
024700131028   S***S
024800110824     C     $PREP1        BEGSR
024900110824    ***
025000110824     C                   EXSR      $PLANLOAD
025100110824    ***
025200110824     C                   EVAL      @STEP = 'STEP1'
025300110824    ***
025400110824     C                   ENDSR
025500110824   S***S
025600110824     C     $STEP1        BEGSR
025700110824    ***
025800110824     C                   EVAL      KF@PLN = *BLANKS
025900110824     C                   EVAL      KF@TRM = 0
026000110824     C                   EVAL      KF@SSN = 0
026100110824     C                   EVAL      KF@SEQ = 0
026200110824    ***
026300110824     C     KL#TSA        SETLL     MEMBR
026400110824    ***
026500110824     C                   EVAL      @STEP = 'STEP2'
026600110824    ***
026700110824     C                   ENDSR
026800110824   S***S
026900110824     C     $STEP2        BEGSR
027000110824    ***
027100110824     C     KL#TSA        READE     MEMBR
027200110824    ***
027300110824     C                   IF        %EOF(MEMAC#1)
027400111006     C                   EVAL      @STEP = 'STEP0'
027500111006     C                   LEAVESR
027600110824     C                   ENDIF
027700110824    ***
027800110824     C                   EVAL      KF@SSN = MBSSNO
027900131028     C                   MOVE      *BLANKS       KF@ENR
028000110824     C                   MOVE      *ZEROS        KF@SEQ
028100131028     C                   EVAL      WRT@TYPE = 'MEMBER'
028200110824    ***
028300110824     C     KL#MPLN       SETLL     MCOVR
028400110824    ***
028500110824     C                   EXSR      $CLRSTG
028600110824    ***
028700110824     C                   EVAL      @STEP = 'STEP3'
028800110824    ***
028900110824     C                   ENDSR
029000110824   S***S
029100110824     C     $STEP3        BEGSR
029200110824    ***
029300110824     C     KL#MPLN       READE     MCOVR
029400110824    ***
029500110824     C                   IF        %EOF(MCOVMPLN)
029600110824     C                   EVAL      @STEP = 'PREP4'
029700110824     C                   LEAVESR
029800110824     C                   ENDIF
029900110824    ***
030000110824     C                   EVAL      @PLANIN = MCPLAN
030100110824     C                   EVAL      @ENRIN = MCOVTP
030200111115     C                   EVAL      #EFFDTE = ENRLDT
030300110824     **
030400110824     C                   EXSR      $QUIK
030500110824     **
030600110824     C                   EXSR      $PLANSRCH
030700110824    ***
030800110824     C                   IF        PLN@CAT = *BLANKS
030900110824     C                   LEAVESR
031000110824     C                   ENDIF
031100110824    ***
031200110824     C                   IF        CANDT = 0
031300110824     C                   EVAL      #CANCEL = 99999999
031400110824     C                   ELSE
031500110824     C                   EVAL      #CANCEL = CANDT
031600110824     C                   ENDIF
031700110824    ***
031800110824     C                   EXSR      $AD2MARY
031900110824    ***
032000110824     C                   ENDSR
032100110824   S***S
032200110824     C     $AD2MARY      BEGSR
032300110824    ***
032400131028     C                   IF        VIS#CNE > 0 AND VIS@TRM(VIS#CNE) = 99999999
032500130118     C                   LEAVESR
032600111108     C                   ENDIF
032700131028    ***
032800110824    *C                   ADD       1             VIS#CNE
032900111115    *C                   EVAL      VIS@PLN(VIS#CNE) = @PLANIN
033000111006    *C                   EVAL      VIS@ENR(VIS#CNE) = @ENROU
033100111115    *C                   EVAL      VIS@FRM(VIS#CNE) = #EFFDTE
033200110824    *C                   EVAL      VIS@TRM(VIS#CNE) = #CANCEL
033300121128    ***
033400110824     C                   ENDSR
033500110824   S***S
033600110824     C     $QUIK         BEGSR
033700110824    ***
033800110824     C                   EVAL      @CCTRIN = *BLANKS
033900131028    ***
034000131028     C                   IF        %TRIM(CACID5) = 'Y'
034100131028     C                   EXSR      $MAPRULEZ
034200131028     C                   ENDIF
034300131028    ***
034400131028     C                   IF        WRT@TYPE = 'DEPEND'
034500131028     C                   EVAL      @ENROU = MBRENR
034600131028     C                   LEAVESR
034700131028     C                   ENDIF
034800111006    ***
034900131028    *** MEMBERS ONLY     ;-)
035000131028    ***
035100131028     C                   IF        %SUBST(CACID1:1:1) = '2'
035200131028     C                   SELECT
035300131028     C                   WHEN      @ENRIN = 'TIN'
035400131028     C                   EVAL      @ENROU = 'EE '
035500131028     C                   OTHER
035600131028     C                   EVAL      @ENROU = 'FAM'
035700131028     C                   ENDSL
035800131028     C                   ENDIF
035900131028    ***
036000131028     C                   IF        %SUBST(CACID1:1:1) = '3'
036100131028     C                   SELECT
036200131028     C                   WHEN      @ENRIN = 'TIN'
036300131028     C                   EVAL      @ENROU = 'EE '
036400131028     C                   WHEN      @ENRIN = 'TFA' OR @ENRIN = 'TP2'
036500131028     C                   EVAL      @ENROU = 'FAM'
036600131028     C                   OTHER
036700131028     C                   EVAL      @ENROU = 'DEP'
036800131028     C                   ENDSL
036900131028     C                   ENDIF
037000131028    ***
037100131028     C                   IF        %SUBST(CACID1:1:1) = '4'
037200131028     C                   SELECT
037300131028     C                   WHEN      @ENRIN = 'TIN'
037400131028     C                   EVAL      @ENROU = 'EE '
037500131028     C                   WHEN      @ENRIN = 'THW'
037600131028     C                   EVAL      @ENROU = 'DEP'
037700131028     C                   WHEN      @ENRIN = 'TPC' OR @ENRIN = 'TP2'
037800131028     C                   EVAL      @ENROU = 'CHD'
037900131028     C                   WHEN      @ENRIN = 'TFA'
038000131028     C                   EVAL      @ENROU = 'FAM'
038100131028     C                   ENDSL
038200131028     C                   ENDIF
038300131028    ***
038400131028     C                   ENDSR
038500131028   S***S
038600131028     C     $MAPRULEZ     BEGSR
038700131028    ***
038800131028     C                   IF        CACID6 = '*NONE'
038900131028     C                   EVAL      @CCTRIN = *BLANKS
039000131028     C                   LEAVESR
039100131028     C                   ENDIF
039200131028    ***
039300131028     C                   IF        CACID6 = 'EMPSTS'
039400131028    *** *
039500131028     C                   IF        EMPST = 'A'
039600131028     C                   EVAL      @CCTRIN = 'ACT'
039700131028     C                   ELSE
039800131028     C                   EVAL      @CCTRIN = 'ACT'
039900131028     C                   ENDIF
040000131028    *** *
040100131028     C                   ENDIF
040200131028    ***
040300110824     C                   ENDSR
040400110824   S***S
040500110824     C     $PREP4        BEGSR
040600110824    ***
040700131025     C                   IF        VIS#CNE  = 0
040800110824     C                   EVAL      @STEP = 'STEP2'
040900110824     C                   LEAVESR
041000110824     C                   ENDIF
041100110824    ***
041200110824     C                   EVAL      TERM_VIS = NO
041300110824    ***
041400110824     C                   EXSR      $CHKHEM
041500110824    ***
041600110824     C                   EVAL      @STEP = 'STEP4'
041700110824    ***
041800110824     C                   ENDSR
041900110824   S***S
042000110824    *** GENERATE MEMBER RECORD
042100110824    ***
042200110824     C     $STEP4        BEGSR
042300110824    ***
042400131025     C                   IF        VIS#CNE  = 0
042500110824     C                   EVAL      @STEP = 'STEP2'
042600110824     C                   LEAVESR
042700110824     C                   ENDIF
042800110824    ***
042900131028     C                   EVAL      MBRENR = VIS@ENR(VIS#CNE)
043000131028     C                   EVAL      VIS@MEFF = VIS@FRM(VIS#CNE)
043100131028    *C                   EVAL      #CANCEL = VIS@TRM(VIS#CNE)
043200120711    ***
043300110824     C                   EXSR      $FILLMBR
043400110824    ***
043500110824     C                   EXSR      $FILLCOVG
043600110824    ***
043700131028     C                   WRITE     AVEF010
043800110824    ***
043900110824     C                   EVAL      @STEP = 'PREP5'
044000110824    ***
044100110824     C                   ENDSR
044200110824   S***S
044300110824     C     $FILLMBR      BEGSR
044400110824    ***
044500131028     C                   CLEAR                   AVEF010
044600111006    ***
044700131028     C                   EVAL      A0RECT = 'CH'
044800131028    ***
044900131028     C                   EVAL      A0CARNBR = %TRIM(CACID2)
045000131028     C                   EVAL      A0GRPNBR = %TRIM(CACID3)
045100131028     C                   EVAL      A0GRPNAM = %TRIM(CATXT4)
045200131028    ***
045300131028     C                   EVAL      A0ALTID = %EDITC(KF@SSN:'X')
045400131028     C                   EVAL      A0IDSFFX = '01'
045500131028     C                   EVAL      A0SSN = A0ALTID
045600131028    ***
045700131028     C                   MOVEL(P)  MFNAME        A0FNAM
045800131028     C                   MOVEL(P)  MMI           A0MI
045900131028     C                   MOVEL(P)  MLNAME        A0LNAM
046000131028    ***
046100131028     C                   EVAL      A0ADD1 = %TRIM(ADDR1)
046200131028     C                   EVAL      A0ADD2 = %TRIM(ADDR2)
046300131028     C                   EVAL      A0CITY = %TRIM(CITY)
046400131028     C                   EVAL      A0STATE = STATE
046500131028     C                   MOVE      *BLANKS       @9
046600131028     C                   EVAL      @9 = %EDITC(ZIP:'X')
046700131028     C                   EVAL      A0ZIP = %SUBST(@9:1:5)
046800131028    ***
046900131028     C                   EVAL      A0GENDR = SEX
047000131028    ***
047100131028     C                   MOVE      BIRTH         #ISO
047200131028     C     *USA          MOVE      #ISO          #XSX
047300131028     C                   MOVE      #XSX          A0DOB
047400131028    ***
047500131028     C                   IF        EMPST = 'C' AND CEXPDT > 0
047600131028     C                   EVAL      A0COBRA = 'Y'
047700131028     C                   EVAL      A0CBREFF = %EDITC(QEDT:'X')
047800131028     C                   IF        #CANCEL <> 99999999
047900131028     C                   MOVE      #CANCEL       #ISO
048000131028     C     *USA          MOVE      #ISO          #XSX
048100131028     C                   EVAL      A0CBRTRM = %EDITC(#XSX:'X')
048200131028     C                   ELSE
048300131028     C                   EVAL      A0CBRTRM = *BLANKS
048400131028     C                   ENDIF
048500131028     C                   ENDIF
048600110824    ***
048700110824     C                   ENDSR
048800110824   S***S
048900111028     C     $FILLCOVG     BEGSR
049000111028    ***
049100111028      *  VISION
049200111028     C                   EVAL      @PLANIN = VIS@PLN(VIS#CNE)
049300131028     C                   EVAL      @ENRIN = VIS@ENR(VIS#CNE)
049400111028     C                   EXSR      $QUIK
049500111028     C                   EXSR      $PLANSRCH
049600111028     C                   IF        PLN@CAT = *BLANKS
049700111028     C     'VIS FILL'    DSPLY     '*EXT'
049800111028     C                   SETON                                        H1
049900111028     C                   ENDIF
050000111028      *
050100131028     C                   IF        CACID5 = 'Y'
050200131028     C                   EVAL      A0SUBGRP = %TRIM(CPCID2)
050300131028     C                   ENDIF
050400131028      *
050500131028     C                   EVAL      A0PLNNBR = %TRIM(CPCID1)
050600131028     C                   EVAL      A0TIER = MBRENR
050700131028      *
050800131028     C                   EVAL      #DATE = 1 * VIS@FRM(VIS#CNE)
050900131028     C                   MOVE      #DATE         #ISO
051000131028     C     *USA          MOVE      #ISO          #XSX
051100131028     C                   MOVE      #XSX          A0EFFDTE
051200131028      *
051300131028     C                   IF        TERM_VIS = NO
051400131028     C                   EVAL      A0TRMDTE = *BLANKS
051500131028     C                   ELSE
051600131028     C                   MOVE      #CANCEL       #ISO
051700131028     C     *USA          MOVE      #ISO          #XSX
051800131028     C                   MOVE      #XSX          A0TRMDTE
051900131028     C                   ENDIF
052000121128    ***
052100111028     C                   ENDSR
052200110824   S***S
052300110824     C     $PREP5        BEGSR
052400110824    ***
052500111007     C     KF@SSN        CHAIN     DEPENR
052600111007     C                   IF        NOT %FOUND(DEPNDC)
052700111007     C                   EVAL      @STEP = 'STEP2'
052800111007     C                   LEAVESR
052900111007     C                   ENDIF
053000111007    ***
053100111007     C     KF@SSN        SETLL     DEPENR
053200111007    ***
053300111007     C                   EVAL      @STEP = 'STEP5'
053400111007    ***
053500111007     C                   ENDSR
053600110824   S***S
053700111007     C     $STEP5        BEGSR
053800111007    ***
053900111007     C     KF@SSN        READE     DEPENR
054000111007    ***
054100111007     C                   IF        %EOF(DEPNDC)
054200111007     C                   EVAL      @STEP = 'STEP2'
054300111007     C                   LEAVESR
054400111007     C                   ENDIF
054500111007    ***
054600131028     C                   EVAL      WRT@TYPE = 'DEPEND'
054700111007     C                   EVAL      KF@SEQ = DPSEQ#
054800111007    ***
054900111007     C     KL#DCV        CHAIN     DCOVR
055000131028     C                   IF        NOT %FOUND(DCOVC)
055100111007     C                   LEAVESR
055200111007     C                   ENDIF
055300111007    ***
055400111007     C                   EXSR      $CLRSTG
055500111007    ***
055600111007     C     KL#DCV        SETLL     DCOVR
055700111007    ***
055800111007     C                   EVAL      @STEP = 'STEP6'
055900111007    ***
056000111007     C                   ENDSR
056100111007   S***S
056200111007     C     $STEP6        BEGSR
056300111007    ***
056400111007     C     KL#DCV        READE     DCOVR
056500111007    ***
056600131028     C                   IF        %EOF(DCOVC)
056700111007     C                   EVAL      @STEP = 'PREP7'
056800111007     C                   LEAVESR
056900111007     C                   ENDIF
057000111007    ***
057100111007     C                   EVAL      @PLANIN = DVPLAN
057200131028     C                   EVAL      @ENRIN = *BLANKS
057300111115     C                   EVAL      #EFFDTE = DENRDT
057400111007    ***
057500111007     C                   EXSR      $QUIK
057600111007    ***
057700111007     C                   EXSR      $PLANSRCH
057800111007    ***
057900111007     C                   IF        PLN@CAT = *BLANKS
058000111007     C                   LEAVESR
058100111007     C                   ENDIF
058200111007    ***
058300111007     C                   EVAL      #CANCEL = CCANDT
058400111007     C                   IF        #CANCEL = 0
058500111007     C                   EVAL      #CANCEL = 99999999
058600111007     C                   ENDIF
058700111115     C                   EXSR      $AD2MARY
058800111007    ***
058900111007     C                   ENDSR
059000111007   S***S
059100111007     C     $PREP7        BEGSR
059200111007    ***
059300131025     C                   IF        VIS#CNE  = 0
059400111007     C                   EVAL      @STEP = 'STEP5'
059500111007     C                   LEAVESR
059600111007     C                   ENDIF
059700111007    ***
059800111007     C                   EVAL      TERM_VIS = NO
059900111007    ***
060000111007     C                   EXSR      $CHKHEM
060100111007    ***
060200111007     C                   EVAL      @STEP = 'STEP7'
060300111007    ***
060400111007     C                   ENDSR
060500111007   S***S
060600111007     C     $STEP7        BEGSR
060700111007    ***
060800131025     C                   IF        VIS#CNE  = 0
060900111007     C                   EVAL      @STEP = 'STEP5'
061000111007     C                   LEAVESR
061100111007     C                   ENDIF
061200111007    ***
061300111007     C                   EXSR      $FILLDEP
061400111007    ***
061500111007     C                   EXSR      $FILLCOVG
061600111007    ***
061700111007     C                   EXSR      $AUDITCVG
061800111007    ***
061900131028     C                   WRITE     AVEF010
062000111007    ***
062100111007     C                   EVAL      @STEP = 'STEP5'
062200111007    ***
062300111007     C                   ENDSR
062400111007   S***S
062500111007     C     $FILLDEP      BEGSR
062600111007    ***
062700131028     C                   CLEAR                   AVEF010
062800131028    ***
062900131028     C                   EVAL      A0RECT = 'DP'
063000131028    ***
063100131028     C                   EVAL      A0CARNBR = %TRIM(CACID2)
063200131028     C                   EVAL      A0GRPNBR = %TRIM(CACID3)
063300131028     C                   EVAL      A0GRPNAM = %TRIM(CATXT4)
063400131028    ***
063500131028     C     KL#TSASQ      CHAIN     AVEF011
063600131028     C                   IF        %FOUND(AVEW011)
063700131028     C                   EVAL      A0IDSFFX = AVSIDSFX
063800131028     C                   ELSE
063900131028     C                   EVAL      A0IDSFFX = 'XX'
064000131028     C                   ENDIF
064100131028    ***
064200131028     C                   EVAL      A0ALTID = %EDITC(KF@SSN:'X')
064300131028     C                   IF        DEPSS# > 0
064400131028     C                   EVAL      A0SSN = %EDITC(DEPSS#:'X')
064500131028     C                   ENDIF
064600131028    ***
064700131028     C                   MOVEL(P)  DFNAME        A0FNAM
064800131028     C                   MOVEL(P)  DMI           A0MI
064900131028     C                   MOVEL(P)  DLNAME        A0LNAM
065000131028    ***
065100131028     C                   EVAL      A0ADD1 = %TRIM(ADDR1)
065200131028     C                   EVAL      A0ADD2 = %TRIM(ADDR2)
065300131028     C                   EVAL      A0CITY = %TRIM(CITY)
065400131028     C                   EVAL      A0STATE = STATE
065500131028     C                   MOVE      *BLANKS       @9
065600131028     C                   EVAL      @9 = %EDITC(ZIP:'X')
065700131028     C                   EVAL      A0ZIP = %SUBST(@9:1:5)
065800131028    ***
065900131028     C                   EVAL      A0GENDR = DSEX
066000131028    ***
066100131028     C                   MOVE      DBIRTH        #ISO
066200131028     C     *USA          MOVE      #ISO          #XSX
066300131028     C                   MOVE      #XSX          A0DOB
066400131028    ***
066500131028     C                   IF        EMPST = 'C' AND CEXPDT > 0
066600131028     C                   EVAL      A0COBRA = 'Y'
066700131028     C                   EVAL      A0CBREFF = %EDITC(QEDT:'X')
066800131028     C                   IF        #CANCEL <> 99999999
066900131028     C                   MOVE      #CANCEL       #ISO
067000131028     C     *USA          MOVE      #ISO          #XSX
067100131028     C                   EVAL      A0CBRTRM = %EDITC(#XSX:'X')
067200131028     C                   ELSE
067300131028     C                   EVAL      A0CBRTRM = *BLANKS
067400131028     C                   ENDIF
067500131028     C                   ENDIF
067600111007    ***
067700111007     C                   ENDSR
067800111007   S***S
067900111007     C     $AUDITCVG     BEGSR
068000111007    ***
068100131028     C                   EVAL      VIS@MEFF = VIS@FRM(VIS#CNE)
068200111007     C                   IF        VIS#CNE > 0 AND
068300120719     C                             VIS@MEFF > VIS@FRM(VIS#CNE) AND
068400111007     C                             VIS@TRM(VIS#CNE) = 99999999
068500111007     C                   EVAL      #DATE = 1 * VIS@MEFF
068600131028     C                   MOVE      #DATE         #ISO
068700131028     C     *USA          MOVE      #ISO          #XSX
068800131028     C                   MOVE      #XSX          A0EFFDTE
068900111007     C                   ENDIF
069000111007    ***
069100111007     C                   ENDSR
069200111007   S***S
069300111007     C     *INZSR        BEGSR
069400111025    ***
069500111007     C     KL#ACCTL      KLIST
069600111007     C                   KFLD                    CARR#CTL
069700111007     C                   KFLD                    KF@TRS
069800111007     C                   KFLD                    KF@SUB
069900111007     C                   KFLD                    KF@ACC
070000120711    ***
070100131028     C     KL#TSASQ      KLIST
070200120711     C                   KFLD                    KF@TRS
070300120711     C                   KFLD                    KF@SUB
070400120711     C                   KFLD                    KF@ACC
070500120711     C                   KFLD                    KF@SSN
070600120711     C                   KFLD                    KF@SEQ
070700111007    ***
070800131028     C     KL#TSAS       KLIST
070900131028     C                   KFLD                    KF@TRS
071000131028     C                   KFLD                    KF@SUB
071100131028     C                   KFLD                    KF@ACC
071200131028     C                   KFLD                    KF@SSN
071300131028    ***
071400111007     C     KL#TSA        KLIST
071500111007     C                   KFLD                    KF@TRS
071600111007     C                   KFLD                    KF@SUB
071700111007     C                   KFLD                    KF@ACC
071800111007    ***
071900111007     C     KL#MPLN       KLIST
072000111007     C                   KFLD                    KF@SSN
072100111007     C                   KFLD                    KF@SEQ
072200111007     C                   KFLD                    KF@TRS
072300111007     C                   KFLD                    KF@SUB
072400111007     C                   KFLD                    KF@ACC
072500111007    ***
072600111007     C     KL#DCV        KLIST
072700111007     C                   KFLD                    KF@SSN
072800111007     C                   KFLD                    KF@SEQ
072900111007    ***
073000111007     C     KL#MTR        KLIST
073100111007     C                   KFLD                    KF@SSN
073200111007     C                   KFLD                    KF@SEQ
073300111007     C                   KFLD                    KF#TRM
073400111007     C                   KFLD                    KF@PLN
073500111007     C                   KFLD                    KF@ENR
073600111007     C                   KFLD                    KF@TRS
073700111007     C                   KFLD                    KF@SUB
073800111007     C                   KFLD                    KF@ACC
073900111007    ***
074000111007     C                   ENDSR
074100111007   S***S
074200111007    *** PLANS LOADED BY ACCOUNT
074300111007    ***
074400111007     C     $PLANLOAD     BEGSR
074500111007    ***
074600111007     C                   EVAL      PP# = 0
074700111007     C                   DO        50
074800111007     C                   ADD       1             PP#
074900111007     C     PP#           OCCUR     CARPLN@
075000111007     C                   CLEAR                   CARPLN@
075100111007     C                   ENDDO
075200131028    ***
075300111007     C                   EVAL      PC# = 0
075400111007     C                   EVAL      PP# = 0
075500111007    ***
075600111007     C     KL#ACCTL      SETLL     CARPLNR
075700111007     C                   DOU       %EOF(CARPLNP)
075800111007     C     KL#ACCTL      READE     CARPLNR
075900111007     C                   IF        NOT %EOF(CARPLNP)
076000111007    ***
076100111007     C                   ADD       1             PC#
076200111007     C     PC#           OCCUR     CARPLN@
076300111007     C                   EVAL      CARPLN@ = DS@CARPLN
076400111007    ***
076500111007     C                   ENDIF
076600111007     C                   ENDDO
076700111007    ***
076800111007     C                   ENDSR
076900111007   S***S
077000111007     C     $CLRSTG       BEGSR
077100111007    ***
077200111007     C                   EVAL      #CANCEL = 0
077300111007    ***
077400111007     C                   EVAL                    VIS#CNE = 0
077500111007     C                   EVAL                    VIS#NDX = 0
077600111007     C                   CLEAR                   VIS@PLN
077700111007     C                   CLEAR                   VIS@ENR
077800111007     C                   CLEAR                   VIS@FRM
077900111007     C                   CLEAR                   VIS@TRM
078000131025    ***
078100111007     C                   ENDSR
078200111007   S***S
078300111007     C     $CHKHEM       BEGSR
078400111007    ***
078500111007     C                   IF        VIS#CNE > 0 AND VIS@TRM(VIS#CNE) <> 99999999
078600111007     C                   EXSR      $CHKVIS
078700111007     C                   ENDIF
078800131025    ***
078900111007     C                   ENDSR
079000111007   S***S
079100111007      * CHECK FOR VISION TERMINATION
079200111007    *C     $CHKVIS       BEGSR
079300111007    ***
079400111007    *C                   EVAL      TERM_VIS = YES
079500111007    *C                   EVAL      KF#TRM = VIS@TRM(VIS#CNE)
079600111007    *C                   EVAL      KF@PLN = VIS@PLN(VIS#CNE)
079700111007    *C                   EVAL      KF@ENR = VIS@ENR(VIS#CNE)
079800111007    ***
079900131028    *C     KL#MTR        CHAIN     AVEF012
080000131028    *C                   IF        %FOUND(AVEW012)
080100111007    *C                   EVAL      VIS#CNE = 0
080200111007    *C                   EVAL      TERM_VIS = NO
080300120914     C                   LEAVESR
080400111007    *C                   ENDIF
080500111007    ***
080600131028     C                   CLEAR                   AVEF012
080700131028    ***
080800131028     C                   EVAL      NTSSNO = KF@SSN
080900131028     C                   EVAL      NTDEPNO = KF@SEQ
081000131028     C                   EVAL      NTTERMDT = KF#TRM
081100131028     C                   EVAL      NTPLAN = KF@PLN
081200131028     C                   EVAL      NTCOVTP = KF@ENR
081300131028     C                   EVAL      NTTRST = KF@TRS
081400131028     C                   EVAL      NTSUB# = KF@SUB
081500131028     C                   EVAL      NTACCT = KF@ACC
081600131028     C                   EVAL      NTTRANSDT = #TODAY
081700131028    ***
081800131028     C                   WRITE     AVEF012
081900111007    ***
082000111007    *C                   ENDSR
082100111007   S***S
082200111007     C     $PLANSRCH     BEGSR
082300111007    ***
082400130118     C                   MOVE      *BLANKS       PLN@CAT
082500111007     C                   EVAL      PP# = 0
082600111007     C                   CLEAR                   DS@CARPLN
082700111007    ***
082800111007     C                   DO        PC#
082900111007    * *
083000111007     C                   ADD       1             PP#
083100111007     C     PP#           OCCUR     CARPLN@
083200111007    * *
083300111007     C                   IF        XPPLAN = @PLANIN AND
083400111007     C                             XPCCTR = @CCTRIN
083500111007     C                   EVAL      DS@CARPLN = CARPLN@
083600111025     C                   EVAL      PLN@CAT = %TRIM(XPCID1)
083700111007     C                   LEAVE
083800111007     C                   ENDIF
083900111007    * *
084000111007     C                   ENDDO
084100111007    ***
084200111007     C                   ENDSR
084300111007   S***S
