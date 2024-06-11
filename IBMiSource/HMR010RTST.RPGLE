000100101012   X***X CARRIER CONTROL ID #0000000003
000200191015
007801191015      * John Torres - 10/14/19
007802191015      * Cloned from production program and added parm to test just group(s)
007803191015      * by changing castatus to a number to be passed as a parm.
007804191015
007900150923      *====================================================================================
008000150923      *  ALL TRUST/SUB/ACCTS FOR THE ASSOCIATION CLIENTS WILL BE SET IN
008100150923      *   CARACCP AND THEN THAT WILL BE USED FEED THIS PROGRAM
008200150923      *====================================================================================
008300150923
008400150923
008500101012     FCARXPTP   IF   E           K DISK
008600101012     FCARACCP   IF   E           K DISK
008700101012     FCARPLNP   IF   E           K DISK
008800191015
008900101012     FHMR019WF  IF A E           K DISK
009000101026     FHMR011WF  O  A E             DISK
009100101026     FHMR012WF  O  A E             DISK
009200101026     FHMR014WF  O  A E             DISK
009300101026     FHMR015WF  O  A E             DISK
009400101026     FHMR016WF  O  A E             DISK
009500101026     FHMR017WF  O  A E             DISK
009600101026     FHMR018WF  O  A E             DISK
009700110601     FHMR01AWF  O  A E             DISK
009800191015     FHMR01BWF  O  A E             DISK
009900191015
010000101012     FMEMAC#1   IF   E           K DISK
010100101012     FMCOVMPLN  IF   E           K DISK
010200101012     FDEPNDC    IF   E           K DISK
010300101012     FDCOVA     IF   E           K DISK
010400191015     FSMOKE     IF   E           K DISK
010500191015
010600101026     D CARR#CTL        S             10A   INZ('0000000003')
010700101026     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
010800101026     D DS@CARACC     E DS                  EXTNAME(CARACCP)
010900101026     D DS@CARXPT     E DS                  EXTNAME(CARXPTP)
011000191015
011100110128     D @STEP           S              5A
011200110128     D @COVRG          S              3A
011300110125     D @@ILC           S              3A
011400110125     D @@PLNARA        S             17A
011500110125     D @@AGRID         S             10A
011600110125     D @@CNTRID        S             30A
011700110606     D PDT@CNTR        S             30A
011800191015
011900110128     D CALC#BDAY       S               D   DATFMT(*ISO)
012000110128     D CALC#TDAY       S               D   DATFMT(*ISO)
012100110128     D #AGE            S              3S 0
012200101026     D #ISO            S               D   DATFMT(*ISO)
012300101215     D @ADDR           S             30A
012400110128     D #TODAY          S              8S 0
012500110128     D #CANCEL         S              8S 0
012600110128     D #ENROLL         S              8S 0
012700101026     D #XSX            S              8S 0
012800101026     D #XSX2           S              8S 0
012900101026     D DATE@OUT        S             10A
013000101026     D ENR@IN          S              3A
013100101026     D ENR@OUT         S              1A
013200110128     D SKIP_DEN        S               N   INZ(*OFF)
013300110128     D SKIP_MED        S               N   INZ(*OFF)
013400110128     D SKIP_RXD        S               N   INZ(*OFF)
013500110128     D SKIP_VIS        S               N   INZ(*OFF)
013600101026     D YES             S               N   INZ(*ON)
013700101026     D NO              S               N   INZ(*OFF)
013800101026     D KF@ENR          S              3A   INZ
013900101026     D KF@CARG         S              2A   INZ
014000101026     D KF@CCTR         S                   LIKE(CCFLG)
014100101026     D KF@TRS          S                   LIKE(MCTRST)
014200101026     D KF@SUB          S                   LIKE(MCSUB#)
014300101026     D KF@PLN          S                   LIKE(MCPLAN)
014400101026     D KF@TRM          S                   LIKE(NTTERMDT)
014500101026     D KF@ACC          S                   LIKE(ACC#)
014600101026     D KF#TRM          S              8S 0
014700101026     D KF@SSN          S                   LIKE(MBSSNO)
014800101026     D KF@SEQ          S                   LIKE(DPSEQ#)
014900101026     D KF@TYP          S              1A
015000101026     D KF@CDE          S              2A
015100191015
015200110301     D M@CNTRID        S             30A   DIM(20)
015300110128     D M@CAT           S              5A   DIM(20)
015400101026     D M#CNE           S              3S 0 INZ
015500101026     D M#NDX           S              3S 0 INZ
015600101026     D M@PLN           S              4A   DIM(20)
015700101026     D M@ENR           S              3A   DIM(20)
015800101026     D M@FRM           S              8S 0 DIM(20)
015900101026     D M@TRM           S              8S 0 DIM(20)
016000110128     D M@FRMBR         S              8S 0
016100110128     D M@TRMBR         S              8S 0
016200110216     D M@ENMBR         S              3A
016300191015
016400110301     D D@CNTRID        S             30A   DIM(20)
016500110128     D D@CAT           S              5A   DIM(20)
016600101215     D D#CNE           S              3S 0 INZ
016700101215     D D#NDX           S              3S 0 INZ
016800101215     D D@PLN           S              4A   DIM(20)
016900101215     D D@ENR           S              3A   DIM(20)
017000101215     D D@FRM           S              8S 0 DIM(20)
017100101215     D D@TRM           S              8S 0 DIM(20)
017200110128     D D@FRMBR         S              8S 0
017300110128     D D@TRMBR         S              8S 0
017400110216     D D@ENMBR         S              3A
017500191015
017600110301     D V@CNTRID        S             30A   DIM(20)
017700110128     D V@CAT           S              5A   DIM(20)
017800101215     D V#CNE           S              3S 0 INZ
017900101215     D V#NDX           S              3S 0 INZ
018000101215     D V@PLN           S              4A   DIM(20)
018100101215     D V@ENR           S              3A   DIM(20)
018200101215     D V@FRM           S              8S 0 DIM(20)
018300101215     D V@TRM           S              8S 0 DIM(20)
018400110128     D V@FRMBR         S              8S 0
018500110128     D V@TRMBR         S              8S 0
018600110216     D V@ENMBR         S              3A
018700191015
018800110301     D R@CNTRID        S             30A   DIM(20)
018900110128     D R@CAT           S              5A   DIM(20)
019000101215     D R#CNE           S              3S 0 INZ
019100101215     D R#NDX           S              3S 0 INZ
019200101215     D R@PLN           S              4A   DIM(20)
019300101215     D R@ENR           S              3A   DIM(20)
019400101215     D R@FRM           S              8S 0 DIM(20)
019500101215     D R@TRM           S              8S 0 DIM(20)
019600110128     D R@FRMBR         S              8S 0
019700110128     D R@TRMBR         S              8S 0
019800110216     D R@ENMBR         S              3A
019900191015
020000110301     D M@CNTRIDX       S             30A   DIM(20)
020100110216     D M@CATX          S              5A   DIM(20)
020200110216     D M#CNEX          S              3S 0 INZ
020300110216     D M#NDXX          S              3S 0 INZ
020400110216     D M@PLNX          S              4A   DIM(20)
020500110216     D M@ENRX          S              3A   DIM(20)
020600110216     D M@FRMX          S              8S 0 DIM(20)
020700110216     D M@TRMX          S              8S 0 DIM(20)
020800191015
020900110301     D D@CNTRIDX       S             30A   DIM(20)
021000110216     D D@CATX          S              5A   DIM(20)
021100110216     D D#CNEX          S              3S 0 INZ
021200110216     D D#NDXX          S              3S 0 INZ
021300110216     D D@PLNX          S              4A   DIM(20)
021400110216     D D@ENRX          S              3A   DIM(20)
021500110216     D D@FRMX          S              8S 0 DIM(20)
021600110216     D D@TRMX          S              8S 0 DIM(20)
021700191015
021800110301     D V@CNTRIDX       S             30A   DIM(20)
021900110216     D V@CATX          S              5A   DIM(20)
022000110216     D V#CNEX          S              3S 0 INZ
022100110216     D V#NDXX          S              3S 0 INZ
022200110216     D V@PLNX          S              4A   DIM(20)
022300110216     D V@ENRX          S              3A   DIM(20)
022400110216     D V@FRMX          S              8S 0 DIM(20)
022500110216     D V@TRMX          S              8S 0 DIM(20)
022600191015
022700110301     D R@CNTRIDX       S             30A   DIM(20)
022800110216     D R@CATX          S              5A   DIM(20)
022900110216     D R#CNEX          S              3S 0 INZ
023000110216     D R#NDXX          S              3S 0 INZ
023100110216     D R@PLNX          S              4A   DIM(20)
023200110216     D R@ENRX          S              3A   DIM(20)
023300110216     D R@FRMX          S              8S 0 DIM(20)
023400110216     D R@TRMX          S              8S 0 DIM(20)
023500191015
023600101026     D C#RECCNT        S              9S 0 INZ
023601191014     D
023602191014     d hmr010rtst      pi
023603191014     d  number                        1
023604191014
023605191015      *====================================================================================
023800191015
023900101026     C                   EVAL      @STEP = 'PREP1'
024000101026    ***
024100101026     C                   DOU       @STEP = 'LEAVE'
024200101026     C     @STEP         CASEQ     'PREP1'       $PREP1
024300101026     C     @STEP         CASEQ     'STEP1'       $STEP1
024400101026     C     @STEP         CASEQ     'PREP2'       $PREP2
024500101026     C     @STEP         CASEQ     'STEP2'       $STEP2
024600101026     C     @STEP         CASEQ     'STEP3'       $STEP3
024700101026     C     @STEP         CASEQ     'PREP4'       $PREP4
024800101026     C     @STEP         CASEQ     'STEP4'       $STEP4
024900101026     C     @STEP         CASEQ     'PREP5'       $PREP5
025000101026     C     @STEP         CASEQ     'STEP5'       $STEP5
025100101216     C     @STEP         CASEQ     'PREP6'       $PREP6
025200101026     C     @STEP         CASEQ     'STEP6'       $STEP6
025300101216     C     @STEP         CASEQ     'PREP7'       $PREP7
025400101026     C     @STEP         CASEQ     'STEP7'       $STEP7
025500101216     C     @STEP         CASEQ     'PREP8'       $PREP8
025600101216     C     @STEP         CASEQ     'STEP8'       $STEP8
025700101216     C     @STEP         CASEQ     'PREP9'       $PREP9
025800101216     C     @STEP         CASEQ     'STEP9'       $STEP9
025900101026     C                   ENDCS
026000101026     C                   ENDDO
026100101026    ***
026200101026     C                   ADD       2             C#RECCNT
026300101026     C                   MOVE      C#RECCNT      H2RCNT
026400101026     C                   WRITE     HMR012F
026500101026    ***
026600101026     C                   EVAL      *INLR = *ON
026700101026   S***S
026800101026     C     $PREP1        BEGSR
026900101026    ***
027000101026     C                   MOVE      #ISO          #XSX2
027100101026     C                   EXSR      $DATES
027200101026     C                   EVAL      H1DATE = DATE@OUT
027300101026     C                   EVAL      H1DATE2 = DATE@OUT
027400110128     C                   WRITE     HMR011F
027500101026    ***
027600101026     C     CARR#CTL      CHAIN     CARXPTR
027700101026     C     CARR#CTL      SETLL     CARACCR
027800101026    ***
027900101026     C                   EVAL      @STEP = 'STEP1'
028000101026    ***
028100101026     C                   ENDSR
028200101026   S***S
028300101026     C     $STEP1        BEGSR
028400101026    ***
028500101026     C     CARR#CTL      READE     CARACCR
028600101026    ***
028700101026     C                   IF        %EOF(CARACCP)
028800101026     C                   EVAL      @STEP = 'LEAVE'
028900101026     C                   LEAVESR
029000101026     C                   ENDIF
029100101026    ***
029200191014     C                   IF        CASTATUS <> number
029300101215     C                   LEAVESR
029400101215     C                   ENDIF
029500101215    ***
029600101026     C                   EVAL      KF@TRS = CATRST
029700101026     C                   EVAL      KF@SUB = CASUB#
029800101026     C                   EVAL      KF@ACC = CAACCT
029900110307     C                   EVAL      @@PLNARA = %TRIM(CACID1)
030000101026     C                   EVAL      @STEP = 'PREP2'
030100101026    ***
030200101026     C                   ENDSR
030300101026   S***S
030400101026     C     $PREP2        BEGSR
030500101026    ***
030600101026     C                   EVAL      KF@PLN = *BLANKS
030700101026     C                   EVAL      KF@TRM = 0
030800101026     C                   EVAL      KF@SSN = 0
030900101026     C                   EVAL      KF@SEQ = 0
031000101026    ***
031100101026     C     KL#TSA        SETLL     MEMBR
031200101026    ***
031300101026     C                   EVAL      @STEP = 'STEP2'
031400101026    ***
031500101026     C                   ENDSR
031600101026   S***S
031700101124     C     $STEP2        BEGSR
031800101124    ***
031900101124     C     KL#TSA        READE     MEMBR
032000101124    ***
032100101124     C                   IF        %EOF(MEMAC#1)
032200101124     C                   EVAL      @STEP = 'STEP1'
032300101124     C                   LEAVESR
032400101124     C                   ENDIF
032500101124    ***
032600110125     C                   EVAL      @@AGRID = %EDITC(MBSSNO:'X') + '0'
032700101124     C                   EVAL      KF@SSN = MBSSNO
032800110128     C                   EVAL      KF@SEQ = 0
032900101215    ***
033000101124     C                   EXSR      $CLRSTG
033100101124    ***
033200101215     C     KL#MPLN       SETLL     MCOVR
033300110128    ***
033400110216     C                   EXSR      $SAVECLR
033500110216    ***
033600101124     C                   EVAL      @STEP = 'STEP3'
033700101215    ***
033800101215     C                   ENDSR
033900101215   S***S
034000101215     C     $CLRSTG       BEGSR
034100101215    ***
034200101215     C                   EVAL      M#CNE = 0
034300101215     C                   EVAL      M#NDX = 0
034400101215     C                   EVAL      D#CNE = 0
034500101215     C                   EVAL      D#NDX = 0
034600101215     C                   EVAL      V#CNE = 0
034700101215     C                   EVAL      V#NDX = 0
034800101215     C                   EVAL      R#CNE = 0
034900101215     C                   EVAL      R#NDX = 0
035000110128    ***
035100101215     C                   CLEAR                   M@PLN
035200101215     C                   CLEAR                   M@ENR
035300101215     C                   CLEAR                   M@FRM
035400101215     C                   CLEAR                   M@TRM
035500110128     C                   CLEAR                   M@CAT
035600110301     C                   CLEAR                   M@CNTRID
035700110128    ***
035800101215     C                   CLEAR                   D@PLN
035900101215     C                   CLEAR                   D@ENR
036000101215     C                   CLEAR                   D@FRM
036100101215     C                   CLEAR                   D@TRM
036200110128     C                   CLEAR                   D@CAT
036300110301     C                   CLEAR                   D@CNTRID
036400110128    ***
036500101215     C                   CLEAR                   V@PLN
036600101215     C                   CLEAR                   V@ENR
036700101215     C                   CLEAR                   V@FRM
036800101215     C                   CLEAR                   V@TRM
036900110128     C                   CLEAR                   V@CAT
037000110301     C                   CLEAR                   V@CNTRID
037100110128    ***
037200101215     C                   CLEAR                   R@PLN
037300101215     C                   CLEAR                   R@ENR
037400101215     C                   CLEAR                   R@FRM
037500101215     C                   CLEAR                   R@TRM
037600110128     C                   CLEAR                   R@CAT
037700110301     C                   CLEAR                   R@CNTRID
037800101124    ***
037900101124     C                   ENDSR
038000101124   S***S
038100101124     C     $STEP3        BEGSR
038200101124    ***
038300101124     C     KL#MPLN       READE     MCOVR
038400101124    ***
038500101124     C                   IF        %EOF(MCOVMPLN)
038600101124     C                   EVAL      @STEP = 'PREP4'
038700101124     C                   LEAVESR
038800101124     C                   ENDIF
038900101124    ***
039000140318     C                   IF        ENRLDT = CANDT
039100140318     C                   LEAVESR
039200140318     C                   ENDIF
039300140318     C*                  IF        ENRLDT = CANDT AND
039400140318     C*                            CANDT <> TERMDT
039500140318     C*                  LEAVESR
039600140318     C*                  ENDIF
039700110617    ***
039800110617     ****ADAMS COUNTY OFFICE FOR THE AGING - REQUESTED EXCLUSION OF MEDICARE PLANS
039900110617    ***
040000110617     C                   IF        KF@TRS = 598 AND
040100110617     C                             KF@SUB = 1 AND
040200110617     C                             KF@ACC = 3 AND
040300110617     C                             (MCPLAN = 'FAAS' OR MCPLAN = 'FAAT')
040400110617     C                   LEAVESR
040500110617     C                   ENDIF
040600101124    ***
040700101124     C                   EVAL      KF@PLN = MCPLAN
040800110125     C                   EVAL      KF@CCTR = *BLANKS
040900101124    ***
041000111005     C                   EXSR      $SUBSET
041100101215    ***
041200111005     ****BROOKS-HUFF TIRE COMPANY OF SHREWSBURY, INC REQUESTED DRUG PLAN FAKE OUT
041300111005    ***
041400111005     C                   IF        KF@TRS = 597  AND
041500111005     C                             KF@SUB = 001  AND
041600111005     C                             KF@ACC = 0036 AND
041700140318     C                             (MCPLAN = 'DAAK' OR MCPLAN = 'KAAD')
041800111005     C                   EVAL      KF@PLN = 'FAKE'
041900111005     C                   EVAL      KF@CCTR = *BLANKS
042000111005     C                   EXSR      $SUBSET
042100111005     C                   ENDIF
042200111005    ***
042300111005    ***
042400111005     C                   ENDSR
042500111005   S***S
042600111005     C     $SUBSET       BEGSR
042700111005    ***
042800111005     C     KL#TSAPC      CHAIN     CARPLNR
042900111005     C                   IF        NOT %FOUND(CARPLNP)
043000111005     C                   LEAVESR
043100111005     C                   ENDIF
043200111005    ***
043300111005     C                   EVAL      #ENROLL = ENRLDT
043400111005     C                   EVAL      @COVRG = MCOVTP
043500111005    ***
043600111005     C                   IF        CANDT = 0
043700111005     C                   EVAL      #CANCEL = 99999999
043800111005     C                   ELSE
043900111005     C                   EVAL      #CANCEL = CANDT
044000111005     C                   ENDIF
044100111005    ***
044200111005     C                   EXSR      $TABLES
044300111005    ***
044400101215     C                   ENDSR
044500101215   S***S
044600101215     C     $TABLES       BEGSR
044700101215    ***
044800101215     C                   SELECT
044900101215    *C*
045000110125     C                   WHEN      CPCID2 = 'MED'
045100101215     C                   ADD       1             M#CNE
045200101215     C                   EVAL      M@PLN(M#CNE) = KF@PLN
045300101215     C                   EVAL      M@FRM(M#CNE) = #ENROLL
045400101215     C                   EVAL      M@TRM(M#CNE) = #CANCEL
045500101215     C                   EVAL      M@ENR(M#CNE) = @COVRG
045600110301     C                   EVAL      M@CAT(M#CNE) = CPCID2
045700110301     C                   EVAL      M@CNTRID(M#CNE) = %TRIM(CPCID3)
045800101215    *C*
045900110125     C                   WHEN      CPCID2 = 'DEN'
046000101215     C                   ADD       1             D#CNE
046100110128     C                   EVAL      D@PLN(D#CNE) = KF@PLN
046200110128     C                   EVAL      D@FRM(D#CNE) = #ENROLL
046300110128     C                   EVAL      D@TRM(D#CNE) = #CANCEL
046400110128     C                   EVAL      D@ENR(D#CNE) = @COVRG
046500110128     C                   EVAL      D@CAT(D#CNE) = CPCID2
046600110301     C                   EVAL      D@CNTRID(D#CNE) = %TRIM(CPCID3)
046700101215    *C*
046800110125     C                   WHEN      CPCID2 = 'VIS'
046900101215     C                   ADD       1             V#CNE
047000110128     C                   EVAL      V@PLN(V#CNE) = KF@PLN
047100110128     C                   EVAL      V@FRM(V#CNE) = #ENROLL
047200110128     C                   EVAL      V@TRM(V#CNE) = #CANCEL
047300110128     C                   EVAL      V@ENR(V#CNE) = @COVRG
047400110128     C                   EVAL      V@CAT(V#CNE) = CPCID2
047500110301     C                   EVAL      V@CNTRID(V#CNE) = %TRIM(CPCID3)
047600101215    *C*
047700110125     C                   WHEN      CPCID2 = 'RXD'
047800101215     C                   ADD       1             R#CNE
047900110128     C                   EVAL      R@PLN(R#CNE) = KF@PLN
048000110128     C                   EVAL      R@FRM(R#CNE) = #ENROLL
048100110128     C                   EVAL      R@TRM(R#CNE) = #CANCEL
048200110128     C                   EVAL      R@ENR(R#CNE) = @COVRG
048300110128     C                   EVAL      R@CAT(R#CNE) = CPCID2
048400110301     C                   EVAL      R@CNTRID(R#CNE) = %TRIM(CPCID3)
048500101215    *C*
048600101215     C                   ENDSL
048700101124    ***
048800101124     C                   ENDSR
048900101124   S***S
049000101026     C     $DATES        BEGSR
049100101026    ***
049200101026     C                   MOVE      *BLANKS       DATE@OUT
049300101026     C                   MOVE      #XSX2         #ISO
049400101026     C     *USA          MOVE      #ISO          #XSX2
049500101026     C                   EVAL      DATE@OUT = %EDITW(#XSX2:'  /  /    ')
049600110204     C     ' ':'0'       XLATE     DATE@OUT      DATE@OUT
049700101026    ***
049800101026     C                   ENDSR
049900101019   S***S
050000101019     C     $PREP4        BEGSR
050100110128    ***
050200110301     C                   EVAL      @@CNTRID = *BLANKS
050300110216     C                   EXSR      $SAVECLR
050400110216    ***
050500110128     C                   IF        M#CNE > 0
050600110128     C                   EVAL      M@FRMBR = M@FRM(M#CNE)
050700110128     C                   EVAL      M@TRMBR = M@TRM(M#CNE)
050800110216     C                   EVAL      M@ENMBR = M@ENR(M#CNE)
050900110301     C                   IF        @@CNTRID = *BLANKS
051000110301     C                   EVAL      @@CNTRID = M@CNTRID(M#CNE)
051100110301     C                   ENDIF
051200110216     C                   EXSR      $SAVEMED
051300110128     C                   ENDIF
051400110128     C                   IF        D#CNE > 0
051500110128     C                   EVAL      D@FRMBR = D@FRM(D#CNE)
051600110128     C                   EVAL      D@TRMBR = D@TRM(D#CNE)
051700110216     C                   EVAL      D@ENMBR = D@ENR(D#CNE)
051800110301     C                   IF        @@CNTRID = *BLANKS
051900110301     C                   EVAL      @@CNTRID = D@CNTRID(D#CNE)
052000110301     C                   ENDIF
052100110216     C                   EXSR      $SAVEDEN
052200110128     C                   ENDIF
052300110128     C                   IF        V#CNE > 0
052400110128     C                   EVAL      V@FRMBR = V@FRM(V#CNE)
052500110128     C                   EVAL      V@TRMBR = V@TRM(V#CNE)
052600110216     C                   EVAL      V@ENMBR = V@ENR(V#CNE)
052700110301     C                   IF        @@CNTRID = *BLANKS
052800110301     C                   EVAL      @@CNTRID = V@CNTRID(V#CNE)
052900110301     C                   ENDIF
053000110216     C                   EXSR      $SAVEVIS
053100110128     C                   ENDIF
053200110128     C                   IF        R#CNE > 0
053300110128     C                   EVAL      R@FRMBR = R@FRM(R#CNE)
053400110128     C                   EVAL      R@TRMBR = R@TRM(R#CNE)
053500110216     C                   EVAL      R@ENMBR = R@ENR(R#CNE)
053600110301     C                   IF        @@CNTRID = *BLANKS
053700110301     C                   EVAL      @@CNTRID = R@CNTRID(R#CNE)
053800110301     C                   ENDIF
053900110216     C                   EXSR      $SAVERXD
054000110128     C                   ENDIF
054100101019    ***
054200101215     C                   EXSR      $CHK4TERM
054300101215    ***
054400101215     C                   IF        SKIP_MED = YES AND
054500101215     C                             SKIP_DEN = YES AND
054600101215     C                             SKIP_VIS = YES AND
054700101215     C                             SKIP_RXD = YES
054800101215     C                   EVAL      @STEP = 'STEP2'
054900101215     C                   LEAVESR
055000101215     C                   ENDIF
055100110301    ***
055200110301     C                   IF        @@CNTRID = *BLANKS
055300110301     C                   SETON                                        H1
055400110301     C                   ENDIF
055500101019    ***
055600110601     C                   EVAL      HAAGRID = @@AGRID
055700110601     C                   EVAL      HACNTRID = @@CNTRID
055800110601     C                   EVAL      HAKRSQ = '00'
055900140516     C                   EVAL      HBAGRID = @@AGRID
056000140516     C                   EVAL      HBCNTRID = @@CNTRID
056100140516     C                   EVAL      HBKRSQ = '00'
056200101216     C                   EVAL      H4AGRID = @@AGRID
056300101216     C                   EVAL      H4CNTRID = @@CNTRID
056400101216     C                   EVAL      H4KRSQ = '00'
056500101216     C                   EVAL      H5AGRID = @@AGRID
056600101216     C                   EVAL      H5CNTRID = @@CNTRID
056700101216     C                   EVAL      H5KRSQ = '00'
056800101216     C                   EVAL      H7AGRID = @@AGRID
056900101216     C                   EVAL      H7CNTRID = @@CNTRID
057000101216     C                   EVAL      H7KRSQ = '00'
057100101216    ***
057200101216     C                   MOVE      *BLANKS       @9                9
057300101216    ***
057400101216     C                   EVAL      H4SSN      = *BLANKS
057500101216     C                   EVAL      H4DOB      = *BLANKS
057600101216     C                   EVAL      H4FNAM     = *BLANKS
057700101216     C                   EVAL      H4MNAM     = *BLANKS
057800101216     C                   EVAL      H4LNAM     = *BLANKS
057900101216     C                   EVAL      H4GNDR     = *BLANKS
058000101216     C                   EVAL      H4RELC     = *BLANKS
058100101216     C                   EVAL      H4SUBIND   = *BLANKS
058200101216     C                   EVAL      H4HIREDT   = *BLANKS
058300110601    ***
058400110601     C                   EVAL      HARQCD     = *BLANKS
058500110601     C                   EVAL      HARQID     = *BLANKS
058600110601     C                   EVAL      HAEFFDTE   = *BLANKS
058700110601     C                   EVAL      HACANCEL   = *BLANKS
058800101216    ***
058900101216     C                   EVAL      H5AD1      = *BLANKS
059000101216     C                   EVAL      H5AD2      = *BLANKS
059100101216     C                   EVAL      H5CITY     = *BLANKS
059200101216     C                   EVAL      H5STATE    = *BLANKS
059300101216     C                   EVAL      H5ZIP      = *BLANKS
059400101216     C                   EVAL      H5ADRED    = *BLANKS
059500101216    ***
059600101216     C                   EVAL      H7AREA     = *BLANKS
059700101216     C                   EVAL      H7PHONE    = *BLANKS
059800101216     C                   EVAL      H7EFFDTE   = *BLANKS
059900101216    ***
060000101216     C                   EVAL      @STEP = 'STEP4'
060100101019    ***
060200101019     C                   ENDSR
060300101215   S***S
060400110216     C     $SAVEMED      BEGSR
060500110216    ***
060600110216     C                   EVAL      M#CNEX = M#CNE
060700110216     C                   Z-ADD     0             W                 3 0
060800110216     C                   DO        M#CNE
060900110216     C                   ADD       1             W
061000110606     C                   EVAL      M@CNTRIDX(W) = M@CNTRID(W)
061100110216     C                   EVAL      M@CATX(W) = M@CAT(W)
061200110216     C                   EVAL      M@PLNX(W) = M@PLN(W)
061300110216     C                   EVAL      M@ENRX(W) = M@ENR(W)
061400110216     C                   EVAL      M@FRMX(W) = M@FRM(W)
061500110216     C                   EVAL      M@TRMX(W) = M@TRM(W)
061600110216     C                   ENDDO
061700110216    ***
061800110216     C                   ENDSR
061900110216   S***S
062000110216     C     $SAVEDEN      BEGSR
062100110216    ***
062200110216     C                   EVAL      D#CNEX = D#CNE
062300110216     C                   Z-ADD     0             W
062400110216     C                   DO        D#CNE
062500110216     C                   ADD       1             W
062600110606     C                   EVAL      D@CNTRIDX(W) = D@CNTRID(W)
062700110216     C                   EVAL      D@CATX(W) = D@CAT(W)
062800110216     C                   EVAL      D@PLNX(W) = D@PLN(W)
062900110216     C                   EVAL      D@ENRX(W) = D@ENR(W)
063000110216     C                   EVAL      D@FRMX(W) = D@FRM(W)
063100110216     C                   EVAL      D@TRMX(W) = D@TRM(W)
063200110216     C                   ENDDO
063300110216    ***
063400110216     C                   ENDSR
063500110216   S***S
063600110216     C     $SAVEVIS      BEGSR
063700110216    ***
063800110216     C                   EVAL      V#CNEX = V#CNE
063900110216     C                   Z-ADD     0             W
064000110216     C                   DO        V#CNE
064100110216     C                   ADD       1             W
064200110606     C                   EVAL      V@CNTRIDX(W) = V@CNTRID(W)
064300110216     C                   EVAL      V@CATX(W) = V@CAT(W)
064400110216     C                   EVAL      V@PLNX(W) = V@PLN(W)
064500110216     C                   EVAL      V@ENRX(W) = V@ENR(W)
064600110216     C                   EVAL      V@FRMX(W) = V@FRM(W)
064700110216     C                   EVAL      V@TRMX(W) = V@TRM(W)
064800110216     C                   ENDDO
064900110216    ***
065000110216     C                   ENDSR
065100110216   S***S
065200110216     C     $SAVERXD      BEGSR
065300110216    ***
065400110216     C                   EVAL      R#CNEX = R#CNE
065500110216     C                   Z-ADD     0             W                 3 0
065600110216     C                   DO        R#CNE
065700110216     C                   ADD       1             W
065800110606     C                   EVAL      R@CNTRIDX(W) = R@CNTRID(W)
065900110216     C                   EVAL      R@CATX(W) = R@CAT(W)
066000110216     C                   EVAL      R@PLNX(W) = R@PLN(W)
066100110216     C                   EVAL      R@ENRX(W) = R@ENR(W)
066200110216     C                   EVAL      R@FRMX(W) = R@FRM(W)
066300110216     C                   EVAL      R@TRMX(W) = R@TRM(W)
066400110216     C                   ENDDO
066500110216    ***
066600110216     C                   ENDSR
066700110216   S***S
066800110216     C     $SAVECLR      BEGSR
066900110216    ***
067000110301     C                   CLEAR                   M@CNTRIDX
067100110216     C                   CLEAR                   M@CATX
067200110216     C                   CLEAR                   M#CNEX
067300110216     C                   CLEAR                   M#NDXX
067400110216     C                   CLEAR                   M@PLNX
067500110216     C                   CLEAR                   M@ENRX
067600110216     C                   CLEAR                   M@FRMX
067700110216     C                   CLEAR                   M@TRMX
067800110216    ***
067900110301     C                   CLEAR                   D@CNTRIDX
068000110216     C                   CLEAR                   D@CATX
068100110216     C                   CLEAR                   D#CNEX
068200110216     C                   CLEAR                   D#NDXX
068300110216     C                   CLEAR                   D@PLNX
068400110216     C                   CLEAR                   D@ENRX
068500110216     C                   CLEAR                   D@FRMX
068600110216     C                   CLEAR                   D@TRMX
068700110216    ***
068800110301     C                   CLEAR                   R@CNTRIDX
068900110216     C                   CLEAR                   R@CATX
069000110216     C                   CLEAR                   R#CNEX
069100110216     C                   CLEAR                   R#NDXX
069200110216     C                   CLEAR                   R@PLNX
069300110216     C                   CLEAR                   R@ENRX
069400110216     C                   CLEAR                   R@FRMX
069500110216     C                   CLEAR                   R@TRMX
069600110216    ***
069700110301     C                   CLEAR                   V@CNTRIDX
069800110216     C                   CLEAR                   V@CATX
069900110216     C                   CLEAR                   V#CNEX
070000110216     C                   CLEAR                   V#NDXX
070100110216     C                   CLEAR                   V@PLNX
070200110216     C                   CLEAR                   V@ENRX
070300110216     C                   CLEAR                   V@FRMX
070400110216     C                   CLEAR                   V@TRMX
070500110216    ***
070600110216     C                   EVAL      M@FRMBR = 0
070700110216     C                   EVAL      M@TRMBR = 0
070800110216     C                   EVAL      D@FRMBR = 0
070900110216     C                   EVAL      D@TRMBR = 0
071000110216     C                   EVAL      V@FRMBR = 0
071100110216     C                   EVAL      V@TRMBR = 0
071200110216     C                   EVAL      R@FRMBR = 0
071300110216     C                   EVAL      R@TRMBR = 0
071400110216     C                   EVAL      M@ENMBR = *BLANKS
071500110216     C                   EVAL      D@ENMBR = *BLANKS
071600110216     C                   EVAL      V@ENMBR = *BLANKS
071700110216     C                   EVAL      R@ENMBR = *BLANKS
071800110216    ***
071900110216     C                   ENDSR
072000110216   S***S
072100101215    *** CHECK ALL 4 TERM TYPES
072200101215    ***
072300101215     C     $CHK4TERM     BEGSR
072400101215    * *
072500101215     C                   EVAL      SKIP_MED = NO
072600101215     C                   EVAL      SKIP_DEN = NO
072700101215     C                   EVAL      SKIP_VIS = NO
072800101215     C                   EVAL      SKIP_RXD = NO
072900101215    ***
073000101215     C                   IF        M#CNE = 0
073100101215     C                   EVAL      SKIP_MED = YES
073200101215     C                   ELSE
073300101215     C                   IF        M@TRM(M#CNE) > 0 AND
073400101215     C                             M@TRM(M#CNE) < 99999999
073500101215     C                   EVAL      KF#TRM = M@TRM(M#CNE)
073600101215     C                   EVAL      KF@PLN = M@PLN(M#CNE)
073700101215     C                   EVAL      KF@ENR = M@ENR(M#CNE)
073800101215     C     KL#MTR        CHAIN     HMR019F
073900101215     C                   IF        %FOUND(HMR019WF)
074000101215     C                   EVAL      SKIP_MED = YES
074100101215     C                   ELSE
074200101215     C                   EXSR      $GENTRM
074300101215     C                   ENDIF
074400101215     C                   ENDIF
074500101215     C                   ENDIF
074600101215    ***
074700101215     C                   IF        D#CNE = 0
074800101215     C                   EVAL      SKIP_DEN = YES
074900101215     C                   ELSE
075000101215     C                   IF        D@TRM(D#CNE) > 0 AND
075100101215     C                             D@TRM(D#CNE) < 99999999
075200101215     C                   EVAL      KF#TRM = D@TRM(D#CNE)
075300101215     C                   EVAL      KF@PLN = D@PLN(D#CNE)
075400101215     C                   EVAL      KF@ENR = D@ENR(D#CNE)
075500101215     C     KL#MTR        CHAIN     HMR019F
075600101215     C                   IF        %FOUND(HMR019WF)
075700101215     C                   EVAL      SKIP_DEN = YES
075800101215     C                   ELSE
075900101215     C                   EXSR      $GENTRM
076000101215     C                   ENDIF
076100101215     C                   ENDIF
076200101215     C                   ENDIF
076300101215    ***
076400101215     C                   IF        V#CNE = 0
076500101215     C                   EVAL      SKIP_VIS = YES
076600101215     C                   ELSE
076700101215     C                   IF        V@TRM(V#CNE) > 0 AND
076800101215     C                             V@TRM(V#CNE) < 99999999
076900101215     C                   EVAL      KF#TRM = V@TRM(V#CNE)
077000101215     C                   EVAL      KF@PLN = V@PLN(V#CNE)
077100101215     C                   EVAL      KF@ENR = V@ENR(V#CNE)
077200101215     C     KL#MTR        CHAIN     HMR019F
077300101215     C                   IF        %FOUND(HMR019WF)
077400101215     C                   EVAL      SKIP_VIS = YES
077500101215     C                   ELSE
077600101215     C                   EXSR      $GENTRM
077700101215     C                   ENDIF
077800101215     C                   ENDIF
077900101215     C                   ENDIF
078000101215    ***
078100101215     C                   IF        R#CNE = 0
078200101215     C                   EVAL      SKIP_RXD = YES
078300101215     C                   ELSE
078400101215     C                   IF        R@TRM(R#CNE) > 0 AND
078500101215     C                             R@TRM(R#CNE) < 99999999
078600101215     C                   EVAL      KF#TRM = R@TRM(R#CNE)
078700101215     C                   EVAL      KF@PLN = R@PLN(R#CNE)
078800101215     C                   EVAL      KF@ENR = R@ENR(R#CNE)
078900101215     C     KL#MTR        CHAIN     HMR019F
079000101215     C                   IF        %FOUND(HMR019WF)
079100101215     C                   EVAL      SKIP_RXD = YES
079200101215     C                   ELSE
079300101215     C                   EXSR      $GENTRM
079400101215     C                   ENDIF
079500101215     C                   ENDIF
079600101215     C                   ENDIF
079700101215    ***
079800101215     C                   ENDSR
079900101215   S***S
080000101215     C     $GENTRM       BEGSR
080100101215    ***
080200101215     C                   CLEAR                   HMR019F
080300101215    ***
080400101215     C                   EVAL      NTSSNO    = KF@SSN
080500101215     C                   EVAL      NTDEPNO   = KF@SEQ
080600101215     C                   EVAL      NTTERMDT  = KF#TRM
080700101215     C                   EVAL      NTPLAN    = KF@PLN
080800101215     C                   EVAL      NTCOVTP   = KF@ENR
080900101215     C                   EVAL      NTTRST    = KF@TRS
081000101215     C                   EVAL      NTSUB#    = KF@SUB
081100101215     C                   EVAL      NTACCT    = KF@ACC
081200101215     C                   EVAL      NTTRANSDT = #TODAY
081300101215    ***
081400101215     C                   WRITE     HMR019F
081500101215    ***
081600101215     C                   ENDSR
081700101019   S***S
081800101215    ***
081900101215    *** DEMOGRAPHICS SET FOR MEMBER
082000101215    ***
082100101215   S***S
082200101019     C     $STEP4        BEGSR
082300101019    ***
082400101019     C                   EVAL      H4SSN = %EDITC(MBSSNO:'X')
082500101215    *C*
082600101019     C                   MOVE      BIRTH         #XSX2
082700101019     C                   EXSR      $DATES
082800101019     C                   EVAL      H4DOB = DATE@OUT
082900101215    *C*
083000101019     C                   EVAL      H4FNAM = %TRIM(MFNAME)
083100101019     C                   EVAL      H4MNAM = MMI
083200101019     C                   EVAL      H4LNAM = %TRIM(MLNAME)
083300101019     C                   EVAL      H4GNDR = SEX
083400101019     C                   EVAL      H4RELC = '20'
083500101019     C                   EVAL      H4SUBIND = 'Y'
083600101215    *C*
083700101215     C                   MOVE      EMPDT         #XSX2
083800101019     C                   EXSR      $DATES
083900101019     C                   EVAL      H4HIREDT = DATE@OUT
084000101215    *C*
084100101019     C                   WRITE     HMR014F
084200101215     C                   ADD       1             C#RECCNT
084300110601    ***
084400110601     C                   IF        CATXT2 = 'PAY LOCATION'
084500110601     C                   EVAL      HARQCD = 'LU'
084600110601     C                   EVAL      HARQID = CACID2
084700140723     ****
084800140723     **** BE SURE TO BLAME BRANDON FOR THIS.
084900140723     **** THIS IS A SPECIAL HARDCODE FOR WILMAC SINCE ACCOUNT 15 WAS TERMINATED
085000140723     ****  TO SEND COBRA PAY LOCATION 99 IN PLACE OF THE ACCOUNTS PAY LOCATION.
085100140723     ****
085200150923      * Commented out Cobra Pay Location. No longer in use...
085300150923     C******             IF        EMPST = 'C'
085400150923     C******             EVAL      HARQID = '99'
085500150923     C******             ENDIF
085600140723     ****
085700140723     ****
085800180522     C                   IF        ENRLDT < 20110601
085900180522     C****               IF        EMPDT < 20110601
086000110614     C                   EVAL      #XSX2 = 20110601
086100110614     C                   ELSE
086200180522     C                   MOVE      ENRLDT        #XSX2
086300180522     C****               MOVE      EMPDT         #XSX2
086400110614     C                   ENDIF
086500140924     ****
086600110601     C                   EXSR      $DATES
086700110601     C                   EVAL      HAEFFDTE = DATE@OUT
086800140924     ****
086900120606     C                   SELECT
087000120606     C                   WHEN      MBSSNO = 191500008
087100120605     C                   EVAL      HAEFFDTE = '03/01/2012'
087200120606     C                   WHEN      MBSSNO = 177707778
087300120606     C                   EVAL      HAEFFDTE = '06/01/2012'
087400140408     C                   WHEN      MBSSNO = 132663536 AND
087500140408     C                             HAEFFDTE = '12/31/2012'
087600140408     C                   EVAL      HAEFFDTE = '01/01/2013'
087700140408     C                   ENDSL
087800110601     C                   WRITE     HMR01AF
087900110601     C                   ADD       1             C#RECCNT
088000110601    ***
088100110601     C                   ENDIF
088200101026    ***
088300101215     C                   EVAL      @ADDR = %TRIM(ADDR1)
088400101215     C                   EXSR      $ADDRCHK
088500101215     C                   EVAL      H5AD1 = @ADDR
088600101215    *C*
088700101215     C                   EVAL      @ADDR = %TRIM(ADDR2)
088800101215     C                   EXSR      $ADDRCHK
088900101215     C                   EVAL      H5AD2 = @ADDR
089000101215    *C*
089100101215     C                   EVAL      @ADDR = %TRIM(CITY)
089200101215     C                   EXSR      $ADDRCHK
089300101215     C                   EVAL      H5CITY = @ADDR
089400101215    *C*
089500101215     C                   EVAL      H5STATE = STATE
089600101215     C                   EVAL      @9 = %EDITC(ZIP:'X')
089700101215     C                   EVAL      H5ZIP = %SUBST(@9:1:5)
089800101215    *C*
089900180529     C****               MOVE      EMPDT         #XSX2
090000180529     C****               EXSR      $DATES
090100180529     C****               EVAL      H5ADRED = DATE@OUT
090200101215    *C*
090300101026     C                   WRITE     HMR015F
090400101215     C                   ADD       1             C#RECCNT
090500101026    ***
090600101026     C                   IF        AREA <> 0
090700101215    *C*
090800101026     C                   EVAL      H7AREA = %EDITC(AREA:'X')
090900101026     C                   EVAL      H7PHONE = %EDITC(PHONE:'X')
091000101215    *C*
091100180522     C                   MOVE      ENRLDT        #XSX2
091200180522     C****               MOVE      EMPDT         #XSX2
091300101026     C                   EXSR      $DATES
091400101026     C                   EVAL      H7EFFDTE = DATE@OUT
091500101215    *C*
091600101026     C                   WRITE     HMR017F
091700101215     C                   ADD       1             C#RECCNT
091800101215    *C*
091900101026     C                   ENDIF
092000101026    ***
092100140516    *** 301 TOBACCO USE
092200140516    ***
092300140520     C                   IF        CACID4 = 'YES'
092400140516     C                   EXSR      $SMOKE
092500140516    *C*
092600140516     C                   IF        @TOKER = 'Y'
092700140516     C                   EVAL      HBTOKE = 'T'
092800140516     C                   ELSE
092900140516     C                   EVAL      HBTOKE = 'N'
093000140516     C                   ENDIF
093100140516    *C*
093200140516     C                   WRITE     HMR01BF
093300140516     C                   ADD       1             C#RECCNT
093400140520     C                   ENDIF
093500140516    ***
093600101019     C                   EVAL      @STEP = 'PREP5'
093700140516    ***
093800140516     C                   ENDSR
093900140516   S***S
094000140516     C     $SMOKE        BEGSR
094100140516    ***
094200140516     C                   MOVE      'N'           @TOKER            1
094300101215    ***
094400140516     C     KL#DCV        CHAIN     SMOKER
094500140516     C                   IF        NOT %FOUND(SMOKE)
094600140516     C                   LEAVESR
094700140516     C                   ENDIF
094800140516    ***
094900140516     C     KL#DCV        SETLL     SMOKER
095000140516     C                   DOU       %EOF(SMOKE)
095100140516     C     KL#DCV        READE     SMOKER
095200140516     C                   IF        NOT %EOF(SMOKE)
095300140516    ***
095400140516     C                   IF        SKRATETO = 0
095500140516     C                   EVAL      SKRATETO = 99999999
095600140516     C                   ENDIF
095700140516    ***
095800140516     C                   IF        #TODAY >= SKRATEFR AND #TODAY <= SKRATETO
095900140516     C                   MOVE      'Y'           @TOKER
096000140516     C                   ENDIF
096100140516    ***
096200140516     C                   ENDIF
096300140516     C                   ENDDO
096400140516    ***
096500101215     C                   ENDSR
096600101215   S***S
096700101215     C     $ADDRCHK      BEGSR
096800101215    ***
096900101215     C     ',':' '       XLATE     @ADDR         @ADDR
097000101215    ***
097100101215     C     '.':' '       XLATE     @ADDR         @ADDR
097200101019    ***
097300101019     C                   ENDSR
097400101215   S***S
097500101215    ***
097600101215    *** COVERAGE SET FOR MEMBER
097700101215    ***
097800101215     C     $PREP5        BEGSR
097900101215    ***
098000101215     C                   EVAL      H8AGRID = @@AGRID
098100101215     C                   EVAL      H8CNTRID = @@CNTRID
098200101215     C                   EVAL      H8KRSQ = '00'
098300110125     C                   EVAL      H8PLNAREA  = @@PLNARA
098400101215    ***
098500110203     C                   EVAL      @STEP = 'STEP5'
098600101215    ***
098700101215     C                   ENDSR
098800101019   S***S
098900101215     C     $STEP5        BEGSR
099000101215    ***
099100101215     C                   IF        SKIP_MED = NO
099200101215     C                   EVAL      KF@PLN = M@PLN(M#CNE)
099300101215     C                   EVAL      @COVRG = M@ENR(M#CNE)
099400101215     C                   EVAL      #ENROLL = M@FRM(M#CNE)
099500101215     C                   EVAL      #CANCEL = M@TRM(M#CNE)
099600110606     C                   EVAL      PDT@CNTR = M@CNTRID(M#CNE)
099700101215     C                   EXSR      $GEN135
099800101215     C                   ENDIF
099900101215    ***
100000101215     C                   IF        SKIP_DEN = NO
100100101215     C                   EVAL      KF@PLN = D@PLN(D#CNE)
100200101215     C                   EVAL      @COVRG = D@ENR(D#CNE)
100300101215     C                   EVAL      #ENROLL = D@FRM(D#CNE)
100400101215     C                   EVAL      #CANCEL = D@TRM(D#CNE)
100500110606     C                   EVAL      PDT@CNTR = D@CNTRID(D#CNE)
100600101215     C                   EXSR      $GEN135
100700101215     C                   ENDIF
100800101215    ***
100900101215     C                   IF        SKIP_VIS = NO
101000101215     C                   EVAL      KF@PLN = V@PLN(V#CNE)
101100101215     C                   EVAL      @COVRG = V@ENR(V#CNE)
101200101215     C                   EVAL      #ENROLL = V@FRM(V#CNE)
101300101215     C                   EVAL      #CANCEL = V@TRM(V#CNE)
101400110606     C                   EVAL      PDT@CNTR = V@CNTRID(V#CNE)
101500101215     C                   EXSR      $GEN135
101600101215     C                   ENDIF
101700101215    ***
101800101215     C                   IF        SKIP_RXD = NO
101900101215     C                   EVAL      KF@PLN = R@PLN(R#CNE)
102000101215     C                   EVAL      @COVRG = R@ENR(R#CNE)
102100101215     C                   EVAL      #ENROLL = R@FRM(R#CNE)
102200101215     C                   EVAL      #CANCEL = R@TRM(R#CNE)
102300110606     C                   EVAL      PDT@CNTR = R@CNTRID(R#CNE)
102400101215     C                   EXSR      $GEN135
102500101215     C                   ENDIF
102600101215    ***
102700101215     C                   EVAL      @STEP = 'PREP6'
102800101215    ***
102900101215     C                   ENDSR
103000101215   S***S
103100101215     C     $GEN135       BEGSR
103200101215    ***
103300101215     C                   EVAL      H8ILC      = *BLANKS
103400101215     C                   EVAL      H8EFFDTE   = *BLANKS
103500101215     C                   EVAL      H8ENR      = *BLANKS
103600101215     C                   EVAL      H8CANCEL   = *BLANKS
103700101215     C                   EVAL      H8CNCODE   = *BLANKS
103800101215    ***
103900110125     C     KL#TSAPC      CHAIN     CARPLNR
104000110125     C                   IF        NOT %FOUND(CARPLNP)
104100110125     C                   EVAL      @@ILC = 'XXX'
104200110125     C                   ELSE
104300110125     C                   EVAL      @@ILC = CPCID1
104400110125     C                   ENDIF
104500101215    ***
104600110125     C                   EVAL      H8ILC = @@ILC
104700101215    ***
104800110204     C****               IF        #CANCEL = 99999999 OR #CANCEL = 0
104900110204    *C* ASSUMED ACTIVE
105000101215     C                   SELECT
105100101215     C                   WHEN      @COVRG = 'TFA'
105200101215     C                   EVAL      H8ENR = 'FAM'
105300101215     C                   WHEN      @COVRG = 'THW'
105400101215     C                   EVAL      H8ENR = 'ESP'
105500101215     C                   WHEN      @COVRG = 'TP2'
105600101215     C                   EVAL      H8ENR = 'ECH'
105700101215     C                   WHEN      @COVRG = 'TPC'
105800101215     C                   EVAL      H8ENR = 'EID'
105900101215     C                   WHEN      @COVRG = 'TIN' OR @COVRG = 'TMI'
106000101215     C                   EVAL      H8ENR = 'IND'
106100101215     C                   ENDSL
106200101215    *C*
106300101215     C                   MOVE      #ENROLL       #XSX2
106400101215     C                   EXSR      $DATES
106500101215     C                   EVAL      H8EFFDTE = DATE@OUT
106600101215    *C*
106700110204     C****               ELSE
106800110204     C                   IF        #CANCEL < 99999999 AND #CANCEL > 0
106900101215    *C* TERMED
107000101215     C                   MOVE      #CANCEL       #XSX2
107100101215     C                   EXSR      $DATES
107200101215     C                   EVAL      H8CANCEL = DATE@OUT
107300110413     C                   EVAL      H8CNCODE = '01'
107400101215    *C*
107500101215     C                   ENDIF
107600140924    ***
107700140924    *** 1/1/15 GROUP NUMBER/EFFECTIVE DATE OVERRIDE
107800140924    ***
107900140924       IF (CATRST = 597 AND CASUB# = 001 AND CAACCT = 0094) OR
108000140924          (CATRST = 597 AND CASUB# = 001 AND CAACCT = 0038) OR
108100140924          (CATRST = 597 AND CASUB# = 001 AND CAACCT = 0042) OR
108200140924          (CATRST = 597 AND CASUB# = 001 AND CAACCT = 0002);
108300140924          IF #ENROLL < 20150101;
108400140924             H8EFFDTE = '01/01/2015';
108500140924          ENDIF;
108600140924          IF #CANCEL < 99999999 AND #CANCEL > 0 AND #CANCEL < 20150101;
108700140924             H8CANCEL = '01/01/2015';
108800140924          ENDIF;
108900140924       ENDIF;
109000140924    ***
109100140924    ***
109200101215    ***
109300110606     C                   EVAL      H8CNTRID = PDT@CNTR
109400101215     C                   WRITE     HMR018F
109500101215     C                   ADD       1             C#RECCNT
109600110614    ***
109700110614     C                   IF        CACID3 = 'YES' AND CPCID1 = 'PPO'
109800110616     C                             AND CPCID3 <> '02860707'
109900110614     C                   EVAL      H8ILC = 'PDG'
110000110614     C                   WRITE     HMR018F
110100110614     C                   ADD       1             C#RECCNT
110200110614     C                   ENDIF
110300101215    ***
110400101215     C                   ENDSR
110500101215   S***S
110600101215     *********************************************************************
110700101215     *********   DEPENDENT LEVEL CODING BELOW          *******************
110800101215     *********************************************************************
110900101215     C     $PREP6        BEGSR
111000101215    ***
111100101215     C     KF@SSN        CHAIN     DEPENR
111200101215     C                   IF        NOT %FOUND(DEPNDC)
111300101215     C                   EVAL      @STEP = 'STEP2'
111400101215     C                   LEAVESR
111500101215     C                   ENDIF
111600101215    ***
111700101215     C     KF@SSN        SETLL     DEPENR
111800101215    ***
111900110128     C                   EVAL      @STEP = 'STEP6'
112000110128    ***
112100101215     C                   ENDSR
112200101019   S***S
112300101215     C     $STEP6        BEGSR
112400101215    ***
112500101215     C     KF@SSN        READE     DEPENR
112600101215    ***
112700101215     C                   IF        %EOF(DEPNDC)
112800101215     C                   EVAL      @STEP = 'STEP2'
112900101215     C                   LEAVESR
113000101215     C                   ENDIF
113100101215    ***
113200101215     C                   EVAL      KF@SEQ = DPSEQ#
113300101215    ***
113400101215     C     KL#DCV        CHAIN     DCOVR
113500101215     C                   IF        NOT %FOUND(DCOVA)
113600101215     C                   LEAVESR
113700101215     C                   ENDIF
113800101215    ***
113900101215     C                   EVAL      @STEP = 'PREP7'
114000101215    ***
114100101215     C                   ENDSR
114200101215   S***S
114300101215     C     $PREP7        BEGSR
114400101019    ***
114500101215     C                   EXSR      $CLRSTG
114600101215    ***
114700101019     C     KL#DCV        SETLL     DCOVR
114800101019    ***
114900101215     C                   EVAL      @STEP = 'STEP7'
115000101019    ***
115100101019     C                   ENDSR
115200101019   S***S
115300101215     C     $STEP7        BEGSR
115400101019    ***
115500101019     C     KL#DCV        READE     DCOVR
115600101019    ***
115700101019     C                   IF        %EOF(DCOVA)
115800101215     C                   EVAL      @STEP = 'PREP8'
115900101019     C                   LEAVESR
116000101019     C                   ENDIF
116100101019    ***
116200110301     C                   IF        DENRDT = CCANDT AND
116300110301     C                             CCANDT <> TERMDT
116400101019     C                   LEAVESR
116500101019     C                   ENDIF
116600101019    ***
116700110617     ****ADAMS COUNTY OFFICE FOR THE AGING - REQUESTED EXCLUSION OF MEDICARE PLANS
116800110617    ***
116900110617     C                   IF        KF@TRS = 598 AND
117000110617     C                             KF@SUB = 1 AND
117100110617     C                             KF@ACC = 3 AND
117200110617     C                             (DVPLAN = 'FAAS' OR DVPLAN = 'FAAT')
117300110617     C                   LEAVESR
117400110617     C                   ENDIF
117500110617    ***
117600101019     C                   EVAL      KF@PLN = DVPLAN
117700110204     C                   EVAL      KF@CCTR = *BLANKS
117800101019    ***
117900111005     C                   EXSR      $SUBSET8
118000111005    ***
118100111005    ***
118200111005     ****BROOKS-HUFF TIRE COMPANY OF SHREWSBURY, INC REQUESTED DRUG PLAN FAKE OUT
118300111005    ***
118400111005     C                   IF        KF@TRS = 597  AND
118500111005     C                             KF@SUB = 001  AND
118600111005     C                             KF@ACC = 0036 AND
118700140318     C                             (DVPLAN = 'DAAK' OR DVPLAN = 'KAAD')
118800111005     C                   EVAL      KF@PLN = 'FAKE'
118900111005     C                   EVAL      KF@CCTR = *BLANKS
119000111005     C                   EXSR      $SUBSET8
119100111005     C                   ENDIF
119200111005    ***
119300111005    ***
119400111005     C                   ENDSR
119500111005   S***S
119600111005     C     $SUBSET8      BEGSR
119700111005    ***
119800101215     C     KL#TSAPC      CHAIN     CARPLNR
119900101215     C                   IF        NOT %FOUND(CARPLNP)
120000101215     C                   LEAVESR
120100101215     C                   ENDIF
120200101215    ***
120300110204     C                   EVAL      #ENROLL = DENRDT
120400101215     C                   EVAL      @COVRG = *BLANKS
120500101215    ***
120600110204     C                   IF        CCANDT = 0
120700101215     C                   EVAL      #CANCEL = 99999999
120800101215     C                   ELSE
120900110204     C                   EVAL      #CANCEL = CCANDT
121000101215     C                   ENDIF
121100101215    ***
121200101215     C                   EXSR      $TABLES
121300101215    ***
121400101019     C                   ENDSR
121500101019   S***S
121600101215     C     $PREP8        BEGSR
121700101215    ***
121800101215     C                   EXSR      $CHK4TERM
121900101215    ***
122000101215     C                   IF        SKIP_MED = YES AND
122100101215     C                             SKIP_DEN = YES AND
122200101215     C                             SKIP_VIS = YES AND
122300101215     C                             SKIP_RXD = YES
122400101215     C                   EVAL      @STEP = 'STEP6'
122500101215     C                   LEAVESR
122600101215     C                   ENDIF
122700101215    ***
122800101215     C                   MOVE      KF@SEQ        @SEQ              2
122900101215     C                   EVAL      H4KRSQ = @SEQ
123000101215     C                   EVAL      H5KRSQ = @SEQ
123100101215     C                   EVAL      H7KRSQ = @SEQ
123200140516     C                   EVAL      HBKRSQ = @SEQ
123300101215    ***
123400101215    ***
123500101215     C                   MOVE      *BLANKS       @9
123600101215    ***
123700101215     C                   EVAL      H4SSN      = *BLANKS
123800101215     C                   EVAL      H4DOB      = *BLANKS
123900101215     C                   EVAL      H4FNAM     = *BLANKS
124000101215     C                   EVAL      H4MNAM     = *BLANKS
124100101215     C                   EVAL      H4LNAM     = *BLANKS
124200101215     C                   EVAL      H4GNDR     = *BLANKS
124300101215     C                   EVAL      H4RELC     = *BLANKS
124400101215     C                   EVAL      H4SUBIND   = 'N'
124500101215     C                   EVAL      H4HIREDT   = *BLANKS
124600101215    ***
124700101215     C                   EVAL      H5AD1      = *BLANKS
124800101215     C                   EVAL      H5AD2      = *BLANKS
124900101215     C                   EVAL      H5CITY     = *BLANKS
125000101215     C                   EVAL      H5STATE    = *BLANKS
125100101215     C                   EVAL      H5ZIP      = *BLANKS
125200101215     C                   EVAL      H5ADRED    = *BLANKS
125300101215    ***
125400101215     C                   EVAL      H7AREA     = *BLANKS
125500101215     C                   EVAL      H7PHONE    = *BLANKS
125600101215     C                   EVAL      H7EFFDTE   = *BLANKS
125700101215    ***
125800101215     C                   EVAL      @STEP = 'STEP8'
125900101215    ***
126000101215     C                   ENDSR
126100101215   S***S
126200101215     C     $STEP8        BEGSR
126300101215    ***
126400130425     C                   IF        DEPSS# = 0
126500130425     C                   EVAL      H4SSN = *BLANKS
126600130425     C                   ELSE
126700101215     C                   EVAL      H4SSN = %EDITC(DEPSS#:'X')
126800130425     C                   ENDIF
126900101215    *C*
127000101215     C                   MOVE      DBIRTH        #XSX2
127100101215     C                   EXSR      $DATES
127200101215     C                   EVAL      H4DOB = DATE@OUT
127300101215    *C*
127400101215     C                   EVAL      H4FNAM = %TRIM(DFNAME)
127500101215     C                   EVAL      H4MNAM = DMI
127600101215     C                   EVAL      H4LNAM = %TRIM(DLNAME)
127700101215     C                   EVAL      H4GNDR = DSEX
127800101215     C                   EVAL      H4SUBIND = 'N'
127900101215    *C*
128000101215     C                   IF        DRELCD = 'RSO' OR DRELCD = 'RDA'
128100101215     C                   EVAL      H4RELC = '02'
128200101215     C                   ELSE
128300101215     C                   EVAL      H4RELC = '01'
128400101215     C                   ENDIF
128500101215    *C*
128600101215     C                   WRITE     HMR014F
128700101215     C                   ADD       1             C#RECCNT
128800140516    ***
128900140516    *** 301 TOBACCO USE
129000140516    ***
129100140520     C                   IF        CACID4 = 'YES'
129200140516     C                   EXSR      $SMOKE
129300140516    *C*
129400140516     C                   IF        @TOKER = 'Y'
129500140516     C                   EVAL      HBTOKE = 'T'
129600140516     C                   ELSE
129700140523     C                   EVAL      HBTOKE = 'U'
129800140516     C                   ENDIF
129900140516    *C*
130000140516     C                   WRITE     HMR01BF
130100140516     C                   ADD       1             C#RECCNT
130200140520     C                   ENDIF
130300101215    ***
130400110310    *** INSTRUCTED BY CARRIER TO NOT SEND DEPENDENT ADDRESS
130500101215    ***
130600110309    *** CHECK FOR ELIGIBILITY QUALIFIER RECORD WRITE
130700110309    ***
130800110309     C                   EXSR      $115
130900110309    ***
131000101215    ***
131100110310    *** INSTRUCTED BY CARRIER TO NOT SEND FOR DEPENDENT PHONE
131200101215    ***
131300101215     C                   EVAL      @STEP = 'PREP9'
131400110309    ***
131500110309     C                   ENDSR
131600110309   S***S
131700110309     C     $115          BEGSR
131800110309    ***
131900110309     C                   IF        (DRELCD = 'RSO' OR DRELCD = 'RDA') AND
132000140812     C                             (DSTUDN = 'Y' OR DHNDCP = '3')
132100110309    *C*
132200110309     C                   EVAL      H6AGRID = @@AGRID
132300110309     C                   EVAL      H6CNTRID = @@CNTRID
132400110309     C                   EVAL      H6KRSQ = @SEQ
132500110309    *C*
132600110309     C                   EVAL      CALC#TDAY = %DATE
132700110309     C                   MOVE      DBIRTH        CALC#BDAY
132800110309     C     CALC#TDAY     SUBDUR    CALC#BDAY     #AGE:*Y
132900110309    *C*
133000110309    *C* OBAMACARE CRAP CLAUSE - IF 26 OR LESS, YOU ARE COVERED UNDER MEMBER PLAN
133100110309    *C*
133200110309     C                   IF        #AGE <= 26
133300110309     C                   LEAVESR
133400110309     C                   ENDIF
133500110309    *C*
133600110309     C                   IF        #AGE > 26 AND DSTUDN = 'Y'
133700110309     C                   EVAL      H6EQC = 'F'
133800110309     C                   ENDIF
133900110309    *C*
134000140812     C                   IF        DHNDCP = '3'
134100110309     C                   EVAL      H6EQC = '3'
134200110309     C                   ENDIF
134300110309    *C*
134400110309     C                   SELECT
134500110309     C                   WHEN      M#CNE > 0
134600110309     C                   EVAL      #XSX2 = M@FRM(M#CNE)
134700110309     C                   WHEN      D#CNE > 0
134800110309     C                   EVAL      #XSX2 = D@FRM(D#CNE)
134900110309     C                   WHEN      V#CNE > 0
135000110309     C                   EVAL      #XSX2 = V@FRM(V#CNE)
135100110309     C                   WHEN      R#CNE > 0
135200110309     C                   EVAL      #XSX2 = R@FRM(R#CNE)
135300110309     C                   ENDSL
135400110309     C                   EXSR      $DATES
135500110309     C                   EVAL      H6EFFDTE = DATE@OUT
135600110309    *C*
135700110309     C                   WRITE     HMR016F
135800110309     C                   ADD       1             C#RECCNT
135900110309    *C*
136000110309     C                   ENDIF
136100101215    ***
136200101215     C                   ENDSR
136300101215   S***S
136400101215    ***
136500101215    *** COVERAGE SET FOR DEPENDENT
136600101215    ***
136700101215     C     $PREP9        BEGSR
136800101215    ***
136900101215     C                   EVAL      H8AGRID = @@AGRID
137000101215     C                   EVAL      H8CNTRID = @@CNTRID
137100101215     C                   EVAL      H8KRSQ = @SEQ
137200110209     C                   EVAL      H8PLNAREA  = @@PLNARA
137300101215    ***
137400110203     C                   EVAL      @STEP = 'STEP9'
137500101215    ***
137600101215     C                   ENDSR
137700101215   S***S
137800101215     C     $STEP9        BEGSR
137900101215    ***
138000101215     C                   IF        SKIP_MED = NO
138100101215     C                   EVAL      KF@PLN = M@PLN(M#CNE)
138200110216     C                   EVAL      @COVRG = M@ENMBR
138300101215     C                   EVAL      #ENROLL = M@FRM(M#CNE)
138400101215     C                   EVAL      #CANCEL = M@TRM(M#CNE)
138500110204     C                   IF        #ENROLL < M@FRMBR AND
138600110204     C                             (#CANCEL = 0 OR #CANCEL = 99999999)
138700110204     C                   EVAL      #ENROLL = M@FRMBR
138800110204     C                   ENDIF
138900110216     C                   IF        #CANCEL <> 0 AND #CANCEL <> 99999999
139000110216     C                   EXSR      $SRCHMED
139100110216     C                   ENDIF
139200110606     C                   EVAL      PDT@CNTR = M@CNTRID(M#CNE)
139300101215     C                   EXSR      $GEN135
139400101215     C                   ENDIF
139500101215    ***
139600101215     C                   IF        SKIP_DEN = NO
139700101215     C                   EVAL      KF@PLN = D@PLN(D#CNE)
139800110216     C                   EVAL      @COVRG = D@ENMBR
139900101215     C                   EVAL      #ENROLL = D@FRM(D#CNE)
140000101215     C                   EVAL      #CANCEL = D@TRM(D#CNE)
140100110204     C                   IF        #ENROLL < D@FRMBR AND
140200110204     C                             (#CANCEL = 0 OR #CANCEL = 99999999)
140300110204     C                   EVAL      #ENROLL = D@FRMBR
140400110204     C                   ENDIF
140500110606     C                   EVAL      PDT@CNTR = D@CNTRID(D#CNE)
140600101215     C                   EXSR      $GEN135
140700101215     C                   ENDIF
140800101215    ***
140900101215     C                   IF        SKIP_VIS = NO
141000101215     C                   EVAL      KF@PLN = V@PLN(V#CNE)
141100110216     C                   EVAL      @COVRG = V@ENMBR
141200101215     C                   EVAL      #ENROLL = V@FRM(V#CNE)
141300101215     C                   EVAL      #CANCEL = V@TRM(V#CNE)
141400110204     C                   IF        #ENROLL < V@FRMBR AND
141500110204     C                             (#CANCEL = 0 OR #CANCEL = 99999999)
141600110204     C                   EVAL      #ENROLL = V@FRMBR
141700110204     C                   ENDIF
141800110606     C                   EVAL      PDT@CNTR = V@CNTRID(V#CNE)
141900101215     C                   EXSR      $GEN135
142000101215     C                   ENDIF
142100101215    ***
142200101215     C                   IF        SKIP_RXD = NO
142300101215     C                   EVAL      KF@PLN = R@PLN(R#CNE)
142400110216     C                   EVAL      @COVRG = R@ENMBR
142500101215     C                   EVAL      #ENROLL = R@FRM(R#CNE)
142600101215     C                   EVAL      #CANCEL = R@TRM(R#CNE)
142700110204     C                   IF        #ENROLL < R@FRMBR AND
142800110204     C                             (#CANCEL = 0 OR #CANCEL = 99999999)
142900110204     C                   EVAL      #ENROLL = R@FRMBR
143000110204     C                   ENDIF
143100110606     C                   EVAL      PDT@CNTR = R@CNTRID(R#CNE)
143200101215     C                   EXSR      $GEN135
143300101215     C                   ENDIF
143400101215    ***
143500101215     C                   EVAL      @STEP = 'STEP6'
143600110216    ***
143700110216     C                   ENDSR
143800110216   S***S
143900110216     C     $SRCHMED      BEGSR
144000110216    ***
144100110216     C                   EVAL      W = 0
144200110216     C                   DO        M#CNEX
144300110216     C                   ADD       1             W
144400110216     C                   IF        #CANCEL >  M@FRMX(W) AND
144500110216     C                             #CANCEL <= M@TRMX(W)
144600110216     C                   EVAL      @COVRG = M@ENRX(W)
144700110216     C                   LEAVESR
144800110216     C                   ENDIF
144900110216     C                   ENDDO
145000101215    ***
145100101215     C                   ENDSR
145200101215   S***S
145300110216     C     $SRCHDEN      BEGSR
145400110216    ***
145500110216     C                   EVAL      W = 0
145600110216     C                   DO        D#CNEX
145700110216     C                   ADD       1             W
145800110216     C                   IF        #CANCEL >  D@FRMX(W) AND
145900110216     C                             #CANCEL <= D@TRMX(W)
146000110216     C                   EVAL      @COVRG = D@ENRX(W)
146100110216     C                   LEAVESR
146200110216     C                   ENDIF
146300110216     C                   ENDDO
146400110216    ***
146500110216     C                   ENDSR
146600110216   S***S
146700110216     C     $SRCHVIS      BEGSR
146800110216    ***
146900110216     C                   EVAL      W = 0
147000110216     C                   DO        V#CNEX
147100110216     C                   ADD       1             W
147200110216     C                   IF        #CANCEL >  V@FRMX(W) AND
147300110216     C                             #CANCEL <= V@TRMX(W)
147400110216     C                   EVAL      @COVRG = V@ENRX(W)
147500110216     C                   LEAVESR
147600110216     C                   ENDIF
147700110216     C                   ENDDO
147800110216    ***
147900110216     C                   ENDSR
148000110216   S***S
148100110216     C     $SRCHRXD      BEGSR
148200110216    ***
148300110216     C                   EVAL      W = 0
148400110216     C                   DO        R#CNEX
148500110216     C                   ADD       1             W
148600110216     C                   IF        #CANCEL >  R@FRMX(W) AND
148700110216     C                             #CANCEL <= R@TRMX(W)
148800110216     C                   EVAL      @COVRG = R@ENRX(W)
148900110216     C                   LEAVESR
149000110216     C                   ENDIF
149100110216     C                   ENDDO
149200110216    ***
149300110216     C                   ENDSR
149400110216   S***S
149500101019     C     *INZSR        BEGSR
149600110128    ***
149700110128     C                   EVAL      #ISO = %DATE
149800110128     C                   MOVE      #ISO          #TODAY
149900101019    ***
150000101019     C     KL#TSAPC      KLIST
150100101019     C                   KFLD                    CARR#CTL
150200101019     C                   KFLD                    KF@TRS
150300101019     C                   KFLD                    KF@SUB
150400101019     C                   KFLD                    KF@ACC
150500101019     C                   KFLD                    KF@CCTR
150600101019     C                   KFLD                    KF@PLN
150700101019    ***
150800101019     C     KL#MTR        KLIST
150900101019     C                   KFLD                    KF@SSN
151000101019     C                   KFLD                    KF@SEQ
151100101019     C                   KFLD                    KF#TRM
151200101019     C                   KFLD                    KF@PLN
151300101019     C                   KFLD                    KF@ENR
151400101019     C                   KFLD                    KF@TRS
151500101019     C                   KFLD                    KF@SUB
151600101019     C                   KFLD                    KF@ACC
151700101019    ***
151800101019     C     KL#TSA        KLIST
151900101019     C                   KFLD                    KF@TRS
152000101019     C                   KFLD                    KF@SUB
152100101019     C                   KFLD                    KF@ACC
152200101019    ***
152300101019     C     KL#DCV        KLIST
152400101019     C                   KFLD                    KF@SSN
152500101019     C                   KFLD                    KF@SEQ
152600101019    ***
152700101019     C     KL#CDM        KLIST
152800101019     C                   KFLD                    KF@TYP
152900101019     C                   KFLD                    KF@CDE
153000101019    ***
153100101019     C     KL#MPLN       KLIST
153200101019     C                   KFLD                    KF@SSN
153300101019     C                   KFLD                    KF@SEQ
153400101019     C                   KFLD                    KF@TRS
153500101019     C                   KFLD                    KF@SUB
153600101019     C                   KFLD                    KF@ACC
153700101019    ***
153800101019     C     KL#PLN        KLIST
153900101019     C                   KFLD                    KF@TRS
154000101019     C                   KFLD                    KF@SUB
154100101019     C                   KFLD                    KF@PLN
154200101019    ***
154300101019     C                   ENDSR
154400101019   S***S
