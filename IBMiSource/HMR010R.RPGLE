000100101012   X***X CARRIER CONTROL ID #0000000003
000200101214   X***X
000300101215   X***X OCTOBER 2010 SSK HIGHMARK HEALTHCARE PENNSYLVANIA ASSOCIATION
000400111025   X***X  597-001-0028 REAM PRINTING CO. INC. - TERMED
000500110601   X***X  597-001-0031 DIGESTIVE DISEASE CENTER -TERMED
000600110601   X***X  598-001-0001 PENNEX ALUMINUM COMPANY
000700111014   X***X  598-001-0002 KRB MACHINERY COMPANY - TERMED
000800111014   X***X  598-001-0003 ADAMS COUNTY OFFICE FOR AGING, INC - TERMED
000900111005   X***X  597-001-0036 BROOKS-HUFF TIRE COMPANY OF SHREWSBURY, INC.
001000110617   X***X
001100110601   X***X     ACCOUNTS BELOW USE THE 130 FOR PAY LOCATION
001200110601   X***X  598-001-0004 WILMAC CORPORATION
001300110601   X***X  598-001-0005 COLONIAL MANOR NURSING
001400110601   X***X  598-001-0006 LANCASHIRE HALL NURSING
001500110601   X***X  598-001-0007 HANOVER HALL NURSING
001600110601   X***X  598-001-0008 ATTLEBORO NURSING
001700110601   X***X  598-001-0009 BRUNSWICK AT ATTLEBORO
001800110601   X***X  598-001-0010 BRUNSWICK AT LONGSTOWN
001900110601   X***X  598-001-0011 LANCASTER TERRACE
002000110601   X***X  598-001-0012 ATTLEBORO RETIREMENT
002100110601   X***X  598-001-0013 BROCKIE HEALTHCARE
002200110601   X***X  598-001-0014 POTOMAC PHARMATEC
002300110601   X***X  598-001-0015 WILMAC COBRA
002400110601   X***X
002500110616   X***X 06.16.2011.SSK.HARDCODED EXCLUSION BY CONTRACT NUMBER FOR WILMAC
002600110616   X***X                   BY REQUEST OF SUE BEZILLA AT HIGHMARK
002700101215   X***X
002800110617   X***X 06.17.2011.SSK.HARDCODED EXCLUSION FOR ADAMS COUNTY
002900110617   X***X                   BY REQUEST OF SUE BEZILLA AT HIGHMARK
003000110616   X***X
003100111005   X***X 10.05.2011.SSK.HARDCODED DUAL PLANS FOR BROOKS-HUFF
003200111005   X***X                   BY REQUEST OF E & B
003300110616   X***X
003400120605   X***X 06.05.2012.SSK.HARDCODED MEMBER FOR 1/1/2012 ON THE 130 FORMAT.
003500120606   X***X 06.06.2012.SSK.HARDCODED MEMBER FOR 1/1/2012 ON THE 130 FORMAT.
003600110616   X***X
003700120913   X***X 09.12.2012.SSK.ADDED NEW ACCOUNTS
003800120913   X***X  597-001-0029 EXACT MACHINE SERVICE INC
003900120913   X***X  597-001-0078 KAUFFMAN KITCHENS
004000120913   X***X  598-001-0017 STRAIT STEEL INC
004100120913   X***X
004200130102   X***X 01.02.2013.SSK.ADDED NEW ACCOUNT
004300130102   X***X  597-001-0020 MANUFACTURERS ASSOCIATION OF SOUTH CENTRAL PA
004400120913   X***X
004500130423   X***X 04.23.2013.SSK.ADDED NEW ACCOUNTS
004600130423   X***X  597-001-0009 APX YORK SHEET METAL, INC
004700130423   X***X  597-001-0072 APX ENCLOSURES, INC
004800130423   X***X  597-001-0073 APX INDUSTRIAL COATINGS
004900130423   X***X  597-001-0074 MITCHELL MACHINES
005000120913   X***X
005100130506   X***X 05.06.2013.SSK.ADDED NEW ACCOUNT
005200130506   X***X  597-001-0090 HARDY NORTH AMERICA
005300120913   X***X
005400130906   X***X 09.06.2013.SSK.ADDED NEW ACCOUNT
005500130906   X***X  597-001-0077 CONESTOGA
005600130906   X***X    08232162 IS DOCTORS      08232163 IS NON-DOCTORS
005700120913   X***X
005800140516   X***X 05.01.2014.SSK.ADDED NEW ACCOUNT
005900140516   X***X  597-001-0038 TUCKER INDUSTRIAL LIQUID COATINGS, INC.
006000140516   X***X  597-001-0094 VALLEY PRODUCTS CO
006100140516   X***X  597-001-0042 MOREHOUSE INSTRUMENTS
006200140516   X***X  597-001-0002 CENTRAL PENNSYLVANIA UROLOGY PC
006300140516   X***X
006400140516   X***X 05.16.2014.SSK.ADDED SMOKE RECORD FORMAT
006500140520   X***X 05.20.2014.SSK.MODIFICATION TO THE SMOKE RECORD FORMAT
006600140723   X***X 07.23.2014.SSK.MOD OF PAY LOCATION FOR WILMAC THIS IS A HARD CODED PATCH
006700140924   X***X 09.24.2014.SSK.TEMPORARY OVERRIDE OF DATE LOGIC FOR THESE GROUPS TO USE 1/1/15:
006800140924   X***X  597-001-0038 TUCKER INDUSTRIAL LIQUID COATINGS, INC.
006900140924   X***X  597-001-0094 VALLEY PRODUCTS CO
007000140924   X***X  597-001-0042 MOREHOUSE INSTRUMENTS
007100140924   X***X  597-001-0002 CENTRAL PENNSYLVANIA UROLOGY PC
007200140516   X***X
007300140516   X***X
007400101215   X***X ALL TRUST/SUB/ACCTS FOR THE ASSOCIATION CLIENTS WILL BE SET IN
007500101215   X***X  CARACCP AND THEN THAT WILL BE USED FEED THIS PROGRAM
007600101215   X***X
007700101214   X***X
007800101012     FCARXPTP   IF   E           K DISK
007900101012     FCARACCP   IF   E           K DISK
008000101012     FCARPLNP   IF   E           K DISK
008100101012   X***X
008200101012     FHMR019WF  IF A E           K DISK
008300101026     FHMR011WF  O  A E             DISK
008400101026     FHMR012WF  O  A E             DISK
008500101026     FHMR014WF  O  A E             DISK
008600101026     FHMR015WF  O  A E             DISK
008700101026     FHMR016WF  O  A E             DISK
008800101026     FHMR017WF  O  A E             DISK
008900101026     FHMR018WF  O  A E             DISK
009000110601     FHMR01AWF  O  A E             DISK
009100140516     FHMR01BWF  O  A E             DISK
009200101215    ***
009300101012     FMEMAC#1   IF   E           K DISK
009400101012     FMCOVMPLN  IF   E           K DISK
009500101012     FDEPNDC    IF   E           K DISK
009600101012     FDCOVA     IF   E           K DISK
009700140516     FSMOKE     IF   E           K DISK
009800101012   X***X
009900101026     D CARR#CTL        S             10A   INZ('0000000003')
010000101026     D DS@CARPLN     E DS                  EXTNAME(CARPLNP)
010100101026     D DS@CARACC     E DS                  EXTNAME(CARACCP)
010200101026     D DS@CARXPT     E DS                  EXTNAME(CARXPTP)
010300110125   X***X
010400110128     D @STEP           S              5A
010500110128     D @COVRG          S              3A
010600110125     D @@ILC           S              3A
010700110125     D @@PLNARA        S             17A
010800110125     D @@AGRID         S             10A
010900110125     D @@CNTRID        S             30A
011000110606     D PDT@CNTR        S             30A
011100101026   X***X
011200110128     D CALC#BDAY       S               D   DATFMT(*ISO)
011300110128     D CALC#TDAY       S               D   DATFMT(*ISO)
011400110128     D #AGE            S              3S 0
011500101026     D #ISO            S               D   DATFMT(*ISO)
011600101215     D @ADDR           S             30A
011700110128     D #TODAY          S              8S 0
011800110128     D #CANCEL         S              8S 0
011900110128     D #ENROLL         S              8S 0
012000101026     D #XSX            S              8S 0
012100101026     D #XSX2           S              8S 0
012200101026     D DATE@OUT        S             10A
012300101026     D ENR@IN          S              3A
012400101026     D ENR@OUT         S              1A
012500110128     D SKIP_DEN        S               N   INZ(*OFF)
012600110128     D SKIP_MED        S               N   INZ(*OFF)
012700110128     D SKIP_RXD        S               N   INZ(*OFF)
012800110128     D SKIP_VIS        S               N   INZ(*OFF)
012900101026     D YES             S               N   INZ(*ON)
013000101026     D NO              S               N   INZ(*OFF)
013100101026     D KF@ENR          S              3A   INZ
013200101026     D KF@CARG         S              2A   INZ
013300101026     D KF@CCTR         S                   LIKE(CCFLG)
013400101026     D KF@TRS          S                   LIKE(MCTRST)
013500101026     D KF@SUB          S                   LIKE(MCSUB#)
013600101026     D KF@PLN          S                   LIKE(MCPLAN)
013700101026     D KF@TRM          S                   LIKE(NTTERMDT)
013800101026     D KF@ACC          S                   LIKE(ACC#)
013900101026     D KF#TRM          S              8S 0
014000101026     D KF@SSN          S                   LIKE(MBSSNO)
014100101026     D KF@SEQ          S                   LIKE(DPSEQ#)
014200101026     D KF@TYP          S              1A
014300101026     D KF@CDE          S              2A
014400101215    ***
014500110301     D M@CNTRID        S             30A   DIM(20)
014600110128     D M@CAT           S              5A   DIM(20)
014700101026     D M#CNE           S              3S 0 INZ
014800101026     D M#NDX           S              3S 0 INZ
014900101026     D M@PLN           S              4A   DIM(20)
015000101026     D M@ENR           S              3A   DIM(20)
015100101026     D M@FRM           S              8S 0 DIM(20)
015200101026     D M@TRM           S              8S 0 DIM(20)
015300110128     D M@FRMBR         S              8S 0
015400110128     D M@TRMBR         S              8S 0
015500110216     D M@ENMBR         S              3A
015600101215    ***
015700110301     D D@CNTRID        S             30A   DIM(20)
015800110128     D D@CAT           S              5A   DIM(20)
015900101215     D D#CNE           S              3S 0 INZ
016000101215     D D#NDX           S              3S 0 INZ
016100101215     D D@PLN           S              4A   DIM(20)
016200101215     D D@ENR           S              3A   DIM(20)
016300101215     D D@FRM           S              8S 0 DIM(20)
016400101215     D D@TRM           S              8S 0 DIM(20)
016500110128     D D@FRMBR         S              8S 0
016600110128     D D@TRMBR         S              8S 0
016700110216     D D@ENMBR         S              3A
016800101215    ***
016900110301     D V@CNTRID        S             30A   DIM(20)
017000110128     D V@CAT           S              5A   DIM(20)
017100101215     D V#CNE           S              3S 0 INZ
017200101215     D V#NDX           S              3S 0 INZ
017300101215     D V@PLN           S              4A   DIM(20)
017400101215     D V@ENR           S              3A   DIM(20)
017500101215     D V@FRM           S              8S 0 DIM(20)
017600101215     D V@TRM           S              8S 0 DIM(20)
017700110128     D V@FRMBR         S              8S 0
017800110128     D V@TRMBR         S              8S 0
017900110216     D V@ENMBR         S              3A
018000101215    ***
018100110301     D R@CNTRID        S             30A   DIM(20)
018200110128     D R@CAT           S              5A   DIM(20)
018300101215     D R#CNE           S              3S 0 INZ
018400101215     D R#NDX           S              3S 0 INZ
018500101215     D R@PLN           S              4A   DIM(20)
018600101215     D R@ENR           S              3A   DIM(20)
018700101215     D R@FRM           S              8S 0 DIM(20)
018800101215     D R@TRM           S              8S 0 DIM(20)
018900110128     D R@FRMBR         S              8S 0
019000110128     D R@TRMBR         S              8S 0
019100110216     D R@ENMBR         S              3A
019200101215    ***
019300110301     D M@CNTRIDX       S             30A   DIM(20)
019400110216     D M@CATX          S              5A   DIM(20)
019500110216     D M#CNEX          S              3S 0 INZ
019600110216     D M#NDXX          S              3S 0 INZ
019700110216     D M@PLNX          S              4A   DIM(20)
019800110216     D M@ENRX          S              3A   DIM(20)
019900110216     D M@FRMX          S              8S 0 DIM(20)
020000110216     D M@TRMX          S              8S 0 DIM(20)
020100110216    ***
020200110301     D D@CNTRIDX       S             30A   DIM(20)
020300110216     D D@CATX          S              5A   DIM(20)
020400110216     D D#CNEX          S              3S 0 INZ
020500110216     D D#NDXX          S              3S 0 INZ
020600110216     D D@PLNX          S              4A   DIM(20)
020700110216     D D@ENRX          S              3A   DIM(20)
020800110216     D D@FRMX          S              8S 0 DIM(20)
020900110216     D D@TRMX          S              8S 0 DIM(20)
021000110216    ***
021100110301     D V@CNTRIDX       S             30A   DIM(20)
021200110216     D V@CATX          S              5A   DIM(20)
021300110216     D V#CNEX          S              3S 0 INZ
021400110216     D V#NDXX          S              3S 0 INZ
021500110216     D V@PLNX          S              4A   DIM(20)
021600110216     D V@ENRX          S              3A   DIM(20)
021700110216     D V@FRMX          S              8S 0 DIM(20)
021800110216     D V@TRMX          S              8S 0 DIM(20)
021900110216    ***
022000110301     D R@CNTRIDX       S             30A   DIM(20)
022100110216     D R@CATX          S              5A   DIM(20)
022200110216     D R#CNEX          S              3S 0 INZ
022300110216     D R#NDXX          S              3S 0 INZ
022400110216     D R@PLNX          S              4A   DIM(20)
022500110216     D R@ENRX          S              3A   DIM(20)
022600110216     D R@FRMX          S              8S 0 DIM(20)
022700110216     D R@TRMX          S              8S 0 DIM(20)
022800110216    ***
022900101026     D C#RECCNT        S              9S 0 INZ
023000101026   X***X
023100101012    ***
023200101026     C                   EVAL      @STEP = 'PREP1'
023300101026    ***
023400101026     C                   DOU       @STEP = 'LEAVE'
023500101026     C     @STEP         CASEQ     'PREP1'       $PREP1
023600101026     C     @STEP         CASEQ     'STEP1'       $STEP1
023700101026     C     @STEP         CASEQ     'PREP2'       $PREP2
023800101026     C     @STEP         CASEQ     'STEP2'       $STEP2
023900101026     C     @STEP         CASEQ     'STEP3'       $STEP3
024000101026     C     @STEP         CASEQ     'PREP4'       $PREP4
024100101026     C     @STEP         CASEQ     'STEP4'       $STEP4
024200101026     C     @STEP         CASEQ     'PREP5'       $PREP5
024300101026     C     @STEP         CASEQ     'STEP5'       $STEP5
024400101216     C     @STEP         CASEQ     'PREP6'       $PREP6
024500101026     C     @STEP         CASEQ     'STEP6'       $STEP6
024600101216     C     @STEP         CASEQ     'PREP7'       $PREP7
024700101026     C     @STEP         CASEQ     'STEP7'       $STEP7
024800101216     C     @STEP         CASEQ     'PREP8'       $PREP8
024900101216     C     @STEP         CASEQ     'STEP8'       $STEP8
025000101216     C     @STEP         CASEQ     'PREP9'       $PREP9
025100101216     C     @STEP         CASEQ     'STEP9'       $STEP9
025200101026     C                   ENDCS
025300101026     C                   ENDDO
025400101026    ***
025500101026     C                   ADD       2             C#RECCNT
025600101026     C                   MOVE      C#RECCNT      H2RCNT
025700101026     C                   WRITE     HMR012F
025800101026    ***
025900101026     C                   EVAL      *INLR = *ON
026000101026   S***S
026100101026     C     $PREP1        BEGSR
026200101026    ***
026300101026     C                   MOVE      #ISO          #XSX2
026400101026     C                   EXSR      $DATES
026500101026     C                   EVAL      H1DATE = DATE@OUT
026600101026     C                   EVAL      H1DATE2 = DATE@OUT
026700110128     C                   WRITE     HMR011F
026800101026    ***
026900101026     C     CARR#CTL      CHAIN     CARXPTR
027000101026     C     CARR#CTL      SETLL     CARACCR
027100101026    ***
027200101026     C                   EVAL      @STEP = 'STEP1'
027300101026    ***
027400101026     C                   ENDSR
027500101026   S***S
027600101026     C     $STEP1        BEGSR
027700101026    ***
027800101026     C     CARR#CTL      READE     CARACCR
027900101026    ***
028000101026     C                   IF        %EOF(CARACCP)
028100101026     C                   EVAL      @STEP = 'LEAVE'
028200101026     C                   LEAVESR
028300101026     C                   ENDIF
028400101026    ***
028500101215     C                   IF        CASTATUS = 'N'
028600101215     C                   LEAVESR
028700101215     C                   ENDIF
028800101215    ***
028900101026     C                   EVAL      KF@TRS = CATRST
029000101026     C                   EVAL      KF@SUB = CASUB#
029100101026     C                   EVAL      KF@ACC = CAACCT
029200110307     C                   EVAL      @@PLNARA = %TRIM(CACID1)
029300101026     C                   EVAL      @STEP = 'PREP2'
029400101026    ***
029500101026     C                   ENDSR
029600101026   S***S
029700101026     C     $PREP2        BEGSR
029800101026    ***
029900101026     C                   EVAL      KF@PLN = *BLANKS
030000101026     C                   EVAL      KF@TRM = 0
030100101026     C                   EVAL      KF@SSN = 0
030200101026     C                   EVAL      KF@SEQ = 0
030300101026    ***
030400101026     C     KL#TSA        SETLL     MEMBR
030500101026    ***
030600101026     C                   EVAL      @STEP = 'STEP2'
030700101026    ***
030800101026     C                   ENDSR
030900101026   S***S
031000101124     C     $STEP2        BEGSR
031100101124    ***
031200101124     C     KL#TSA        READE     MEMBR
031300101124    ***
031400101124     C                   IF        %EOF(MEMAC#1)
031500101124     C                   EVAL      @STEP = 'STEP1'
031600101124     C                   LEAVESR
031700101124     C                   ENDIF
031800101124    ***
031900110125     C                   EVAL      @@AGRID = %EDITC(MBSSNO:'X') + '0'
032000101124     C                   EVAL      KF@SSN = MBSSNO
032100110128     C                   EVAL      KF@SEQ = 0
032200101215    ***
032300101124     C                   EXSR      $CLRSTG
032400101124    ***
032500101215     C     KL#MPLN       SETLL     MCOVR
032600110128    ***
032700110216     C                   EXSR      $SAVECLR
032800110216    ***
032900101124     C                   EVAL      @STEP = 'STEP3'
033000101215    ***
033100101215     C                   ENDSR
033200101215   S***S
033300101215     C     $CLRSTG       BEGSR
033400101215    ***
033500101215     C                   EVAL      M#CNE = 0
033600101215     C                   EVAL      M#NDX = 0
033700101215     C                   EVAL      D#CNE = 0
033800101215     C                   EVAL      D#NDX = 0
033900101215     C                   EVAL      V#CNE = 0
034000101215     C                   EVAL      V#NDX = 0
034100101215     C                   EVAL      R#CNE = 0
034200101215     C                   EVAL      R#NDX = 0
034300110128    ***
034400101215     C                   CLEAR                   M@PLN
034500101215     C                   CLEAR                   M@ENR
034600101215     C                   CLEAR                   M@FRM
034700101215     C                   CLEAR                   M@TRM
034800110128     C                   CLEAR                   M@CAT
034900110301     C                   CLEAR                   M@CNTRID
035000110128    ***
035100101215     C                   CLEAR                   D@PLN
035200101215     C                   CLEAR                   D@ENR
035300101215     C                   CLEAR                   D@FRM
035400101215     C                   CLEAR                   D@TRM
035500110128     C                   CLEAR                   D@CAT
035600110301     C                   CLEAR                   D@CNTRID
035700110128    ***
035800101215     C                   CLEAR                   V@PLN
035900101215     C                   CLEAR                   V@ENR
036000101215     C                   CLEAR                   V@FRM
036100101215     C                   CLEAR                   V@TRM
036200110128     C                   CLEAR                   V@CAT
036300110301     C                   CLEAR                   V@CNTRID
036400110128    ***
036500101215     C                   CLEAR                   R@PLN
036600101215     C                   CLEAR                   R@ENR
036700101215     C                   CLEAR                   R@FRM
036800101215     C                   CLEAR                   R@TRM
036900110128     C                   CLEAR                   R@CAT
037000110301     C                   CLEAR                   R@CNTRID
037100101124    ***
037200101124     C                   ENDSR
037300101124   S***S
037400101124     C     $STEP3        BEGSR
037500101124    ***
037600101124     C     KL#MPLN       READE     MCOVR
037700101124    ***
037800101124     C                   IF        %EOF(MCOVMPLN)
037900101124     C                   EVAL      @STEP = 'PREP4'
038000101124     C                   LEAVESR
038100101124     C                   ENDIF
038200101124    ***
038300140318     C                   IF        ENRLDT = CANDT
038400140318     C                   LEAVESR
038500140318     C                   ENDIF
038600140318     C*                  IF        ENRLDT = CANDT AND
038700140318     C*                            CANDT <> TERMDT
038800140318     C*                  LEAVESR
038900140318     C*                  ENDIF
039000110617    ***
039100110617     ****ADAMS COUNTY OFFICE FOR THE AGING - REQUESTED EXCLUSION OF MEDICARE PLANS
039200110617    ***
039300110617     C                   IF        KF@TRS = 598 AND
039400110617     C                             KF@SUB = 1 AND
039500110617     C                             KF@ACC = 3 AND
039600110617     C                             (MCPLAN = 'FAAS' OR MCPLAN = 'FAAT')
039700110617     C                   LEAVESR
039800110617     C                   ENDIF
039900101124    ***
040000101124     C                   EVAL      KF@PLN = MCPLAN
040100110125     C                   EVAL      KF@CCTR = *BLANKS
040200101124    ***
040300111005     C                   EXSR      $SUBSET
040400101215    ***
040500111005     ****BROOKS-HUFF TIRE COMPANY OF SHREWSBURY, INC REQUESTED DRUG PLAN FAKE OUT
040600111005    ***
040700111005     C                   IF        KF@TRS = 597  AND
040800111005     C                             KF@SUB = 001  AND
040900111005     C                             KF@ACC = 0036 AND
041000140318     C                             (MCPLAN = 'DAAK' OR MCPLAN = 'KAAD')
041100111005     C                   EVAL      KF@PLN = 'FAKE'
041200111005     C                   EVAL      KF@CCTR = *BLANKS
041300111005     C                   EXSR      $SUBSET
041400111005     C                   ENDIF
041500111005    ***
041600111005    ***
041700111005     C                   ENDSR
041800111005   S***S
041900111005     C     $SUBSET       BEGSR
042000111005    ***
042100111005     C     KL#TSAPC      CHAIN     CARPLNR
042200111005     C                   IF        NOT %FOUND(CARPLNP)
042300111005     C                   LEAVESR
042400111005     C                   ENDIF
042500111005    ***
042600111005     C                   EVAL      #ENROLL = ENRLDT
042700111005     C                   EVAL      @COVRG = MCOVTP
042800111005    ***
042900111005     C                   IF        CANDT = 0
043000111005     C                   EVAL      #CANCEL = 99999999
043100111005     C                   ELSE
043200111005     C                   EVAL      #CANCEL = CANDT
043300111005     C                   ENDIF
043400111005    ***
043500111005     C                   EXSR      $TABLES
043600111005    ***
043700101215     C                   ENDSR
043800101215   S***S
043900101215     C     $TABLES       BEGSR
044000101215    ***
044100101215     C                   SELECT
044200101215    *C*
044300110125     C                   WHEN      CPCID2 = 'MED'
044400101215     C                   ADD       1             M#CNE
044500101215     C                   EVAL      M@PLN(M#CNE) = KF@PLN
044600101215     C                   EVAL      M@FRM(M#CNE) = #ENROLL
044700101215     C                   EVAL      M@TRM(M#CNE) = #CANCEL
044800101215     C                   EVAL      M@ENR(M#CNE) = @COVRG
044900110301     C                   EVAL      M@CAT(M#CNE) = CPCID2
045000110301     C                   EVAL      M@CNTRID(M#CNE) = %TRIM(CPCID3)
045100101215    *C*
045200110125     C                   WHEN      CPCID2 = 'DEN'
045300101215     C                   ADD       1             D#CNE
045400110128     C                   EVAL      D@PLN(D#CNE) = KF@PLN
045500110128     C                   EVAL      D@FRM(D#CNE) = #ENROLL
045600110128     C                   EVAL      D@TRM(D#CNE) = #CANCEL
045700110128     C                   EVAL      D@ENR(D#CNE) = @COVRG
045800110128     C                   EVAL      D@CAT(D#CNE) = CPCID2
045900110301     C                   EVAL      D@CNTRID(D#CNE) = %TRIM(CPCID3)
046000101215    *C*
046100110125     C                   WHEN      CPCID2 = 'VIS'
046200101215     C                   ADD       1             V#CNE
046300110128     C                   EVAL      V@PLN(V#CNE) = KF@PLN
046400110128     C                   EVAL      V@FRM(V#CNE) = #ENROLL
046500110128     C                   EVAL      V@TRM(V#CNE) = #CANCEL
046600110128     C                   EVAL      V@ENR(V#CNE) = @COVRG
046700110128     C                   EVAL      V@CAT(V#CNE) = CPCID2
046800110301     C                   EVAL      V@CNTRID(V#CNE) = %TRIM(CPCID3)
046900101215    *C*
047000110125     C                   WHEN      CPCID2 = 'RXD'
047100101215     C                   ADD       1             R#CNE
047200110128     C                   EVAL      R@PLN(R#CNE) = KF@PLN
047300110128     C                   EVAL      R@FRM(R#CNE) = #ENROLL
047400110128     C                   EVAL      R@TRM(R#CNE) = #CANCEL
047500110128     C                   EVAL      R@ENR(R#CNE) = @COVRG
047600110128     C                   EVAL      R@CAT(R#CNE) = CPCID2
047700110301     C                   EVAL      R@CNTRID(R#CNE) = %TRIM(CPCID3)
047800101215    *C*
047900101215     C                   ENDSL
048000101124    ***
048100101124     C                   ENDSR
048200101124   S***S
048300101026     C     $DATES        BEGSR
048400101026    ***
048500101026     C                   MOVE      *BLANKS       DATE@OUT
048600101026     C                   MOVE      #XSX2         #ISO
048700101026     C     *USA          MOVE      #ISO          #XSX2
048800101026     C                   EVAL      DATE@OUT = %EDITW(#XSX2:'  /  /    ')
048900110204     C     ' ':'0'       XLATE     DATE@OUT      DATE@OUT
049000101026    ***
049100101026     C                   ENDSR
049200101019   S***S
049300101019     C     $PREP4        BEGSR
049400110128    ***
049500110301     C                   EVAL      @@CNTRID = *BLANKS
049600110216     C                   EXSR      $SAVECLR
049700110216    ***
049800110128     C                   IF        M#CNE > 0
049900110128     C                   EVAL      M@FRMBR = M@FRM(M#CNE)
050000110128     C                   EVAL      M@TRMBR = M@TRM(M#CNE)
050100110216     C                   EVAL      M@ENMBR = M@ENR(M#CNE)
050200110301     C                   IF        @@CNTRID = *BLANKS
050300110301     C                   EVAL      @@CNTRID = M@CNTRID(M#CNE)
050400110301     C                   ENDIF
050500110216     C                   EXSR      $SAVEMED
050600110128     C                   ENDIF
050700110128     C                   IF        D#CNE > 0
050800110128     C                   EVAL      D@FRMBR = D@FRM(D#CNE)
050900110128     C                   EVAL      D@TRMBR = D@TRM(D#CNE)
051000110216     C                   EVAL      D@ENMBR = D@ENR(D#CNE)
051100110301     C                   IF        @@CNTRID = *BLANKS
051200110301     C                   EVAL      @@CNTRID = D@CNTRID(D#CNE)
051300110301     C                   ENDIF
051400110216     C                   EXSR      $SAVEDEN
051500110128     C                   ENDIF
051600110128     C                   IF        V#CNE > 0
051700110128     C                   EVAL      V@FRMBR = V@FRM(V#CNE)
051800110128     C                   EVAL      V@TRMBR = V@TRM(V#CNE)
051900110216     C                   EVAL      V@ENMBR = V@ENR(V#CNE)
052000110301     C                   IF        @@CNTRID = *BLANKS
052100110301     C                   EVAL      @@CNTRID = V@CNTRID(V#CNE)
052200110301     C                   ENDIF
052300110216     C                   EXSR      $SAVEVIS
052400110128     C                   ENDIF
052500110128     C                   IF        R#CNE > 0
052600110128     C                   EVAL      R@FRMBR = R@FRM(R#CNE)
052700110128     C                   EVAL      R@TRMBR = R@TRM(R#CNE)
052800110216     C                   EVAL      R@ENMBR = R@ENR(R#CNE)
052900110301     C                   IF        @@CNTRID = *BLANKS
053000110301     C                   EVAL      @@CNTRID = R@CNTRID(R#CNE)
053100110301     C                   ENDIF
053200110216     C                   EXSR      $SAVERXD
053300110128     C                   ENDIF
053400101019    ***
053500101215     C                   EXSR      $CHK4TERM
053600101215    ***
053700101215     C                   IF        SKIP_MED = YES AND
053800101215     C                             SKIP_DEN = YES AND
053900101215     C                             SKIP_VIS = YES AND
054000101215     C                             SKIP_RXD = YES
054100101215     C                   EVAL      @STEP = 'STEP2'
054200101215     C                   LEAVESR
054300101215     C                   ENDIF
054400110301    ***
054500110301     C                   IF        @@CNTRID = *BLANKS
054600110301     C                   SETON                                        H1
054700110301     C                   ENDIF
054800101019    ***
054900110601     C                   EVAL      HAAGRID = @@AGRID
055000110601     C                   EVAL      HACNTRID = @@CNTRID
055100110601     C                   EVAL      HAKRSQ = '00'
055200140516     C                   EVAL      HBAGRID = @@AGRID
055300140516     C                   EVAL      HBCNTRID = @@CNTRID
055400140516     C                   EVAL      HBKRSQ = '00'
055500101216     C                   EVAL      H4AGRID = @@AGRID
055600101216     C                   EVAL      H4CNTRID = @@CNTRID
055700101216     C                   EVAL      H4KRSQ = '00'
055800101216     C                   EVAL      H5AGRID = @@AGRID
055900101216     C                   EVAL      H5CNTRID = @@CNTRID
056000101216     C                   EVAL      H5KRSQ = '00'
056100101216     C                   EVAL      H7AGRID = @@AGRID
056200101216     C                   EVAL      H7CNTRID = @@CNTRID
056300101216     C                   EVAL      H7KRSQ = '00'
056400101216    ***
056500101216     C                   MOVE      *BLANKS       @9                9
056600101216    ***
056700101216     C                   EVAL      H4SSN      = *BLANKS
056800101216     C                   EVAL      H4DOB      = *BLANKS
056900101216     C                   EVAL      H4FNAM     = *BLANKS
057000101216     C                   EVAL      H4MNAM     = *BLANKS
057100101216     C                   EVAL      H4LNAM     = *BLANKS
057200101216     C                   EVAL      H4GNDR     = *BLANKS
057300101216     C                   EVAL      H4RELC     = *BLANKS
057400101216     C                   EVAL      H4SUBIND   = *BLANKS
057500101216     C                   EVAL      H4HIREDT   = *BLANKS
057600110601    ***
057700110601     C                   EVAL      HARQCD     = *BLANKS
057800110601     C                   EVAL      HARQID     = *BLANKS
057900110601     C                   EVAL      HAEFFDTE   = *BLANKS
058000110601     C                   EVAL      HACANCEL   = *BLANKS
058100101216    ***
058200101216     C                   EVAL      H5AD1      = *BLANKS
058300101216     C                   EVAL      H5AD2      = *BLANKS
058400101216     C                   EVAL      H5CITY     = *BLANKS
058500101216     C                   EVAL      H5STATE    = *BLANKS
058600101216     C                   EVAL      H5ZIP      = *BLANKS
058700101216     C                   EVAL      H5ADRED    = *BLANKS
058800101216    ***
058900101216     C                   EVAL      H7AREA     = *BLANKS
059000101216     C                   EVAL      H7PHONE    = *BLANKS
059100101216     C                   EVAL      H7EFFDTE   = *BLANKS
059200101216    ***
059300101216     C                   EVAL      @STEP = 'STEP4'
059400101019    ***
059500101019     C                   ENDSR
059600101215   S***S
059700110216     C     $SAVEMED      BEGSR
059800110216    ***
059900110216     C                   EVAL      M#CNEX = M#CNE
060000110216     C                   Z-ADD     0             W                 3 0
060100110216     C                   DO        M#CNE
060200110216     C                   ADD       1             W
060300110606     C                   EVAL      M@CNTRIDX(W) = M@CNTRID(W)
060400110216     C                   EVAL      M@CATX(W) = M@CAT(W)
060500110216     C                   EVAL      M@PLNX(W) = M@PLN(W)
060600110216     C                   EVAL      M@ENRX(W) = M@ENR(W)
060700110216     C                   EVAL      M@FRMX(W) = M@FRM(W)
060800110216     C                   EVAL      M@TRMX(W) = M@TRM(W)
060900110216     C                   ENDDO
061000110216    ***
061100110216     C                   ENDSR
061200110216   S***S
061300110216     C     $SAVEDEN      BEGSR
061400110216    ***
061500110216     C                   EVAL      D#CNEX = D#CNE
061600110216     C                   Z-ADD     0             W
061700110216     C                   DO        D#CNE
061800110216     C                   ADD       1             W
061900110606     C                   EVAL      D@CNTRIDX(W) = D@CNTRID(W)
062000110216     C                   EVAL      D@CATX(W) = D@CAT(W)
062100110216     C                   EVAL      D@PLNX(W) = D@PLN(W)
062200110216     C                   EVAL      D@ENRX(W) = D@ENR(W)
062300110216     C                   EVAL      D@FRMX(W) = D@FRM(W)
062400110216     C                   EVAL      D@TRMX(W) = D@TRM(W)
062500110216     C                   ENDDO
062600110216    ***
062700110216     C                   ENDSR
062800110216   S***S
062900110216     C     $SAVEVIS      BEGSR
063000110216    ***
063100110216     C                   EVAL      V#CNEX = V#CNE
063200110216     C                   Z-ADD     0             W
063300110216     C                   DO        V#CNE
063400110216     C                   ADD       1             W
063500110606     C                   EVAL      V@CNTRIDX(W) = V@CNTRID(W)
063600110216     C                   EVAL      V@CATX(W) = V@CAT(W)
063700110216     C                   EVAL      V@PLNX(W) = V@PLN(W)
063800110216     C                   EVAL      V@ENRX(W) = V@ENR(W)
063900110216     C                   EVAL      V@FRMX(W) = V@FRM(W)
064000110216     C                   EVAL      V@TRMX(W) = V@TRM(W)
064100110216     C                   ENDDO
064200110216    ***
064300110216     C                   ENDSR
064400110216   S***S
064500110216     C     $SAVERXD      BEGSR
064600110216    ***
064700110216     C                   EVAL      R#CNEX = R#CNE
064800110216     C                   Z-ADD     0             W                 3 0
064900110216     C                   DO        R#CNE
065000110216     C                   ADD       1             W
065100110606     C                   EVAL      R@CNTRIDX(W) = R@CNTRID(W)
065200110216     C                   EVAL      R@CATX(W) = R@CAT(W)
065300110216     C                   EVAL      R@PLNX(W) = R@PLN(W)
065400110216     C                   EVAL      R@ENRX(W) = R@ENR(W)
065500110216     C                   EVAL      R@FRMX(W) = R@FRM(W)
065600110216     C                   EVAL      R@TRMX(W) = R@TRM(W)
065700110216     C                   ENDDO
065800110216    ***
065900110216     C                   ENDSR
066000110216   S***S
066100110216     C     $SAVECLR      BEGSR
066200110216    ***
066300110301     C                   CLEAR                   M@CNTRIDX
066400110216     C                   CLEAR                   M@CATX
066500110216     C                   CLEAR                   M#CNEX
066600110216     C                   CLEAR                   M#NDXX
066700110216     C                   CLEAR                   M@PLNX
066800110216     C                   CLEAR                   M@ENRX
066900110216     C                   CLEAR                   M@FRMX
067000110216     C                   CLEAR                   M@TRMX
067100110216    ***
067200110301     C                   CLEAR                   D@CNTRIDX
067300110216     C                   CLEAR                   D@CATX
067400110216     C                   CLEAR                   D#CNEX
067500110216     C                   CLEAR                   D#NDXX
067600110216     C                   CLEAR                   D@PLNX
067700110216     C                   CLEAR                   D@ENRX
067800110216     C                   CLEAR                   D@FRMX
067900110216     C                   CLEAR                   D@TRMX
068000110216    ***
068100110301     C                   CLEAR                   R@CNTRIDX
068200110216     C                   CLEAR                   R@CATX
068300110216     C                   CLEAR                   R#CNEX
068400110216     C                   CLEAR                   R#NDXX
068500110216     C                   CLEAR                   R@PLNX
068600110216     C                   CLEAR                   R@ENRX
068700110216     C                   CLEAR                   R@FRMX
068800110216     C                   CLEAR                   R@TRMX
068900110216    ***
069000110301     C                   CLEAR                   V@CNTRIDX
069100110216     C                   CLEAR                   V@CATX
069200110216     C                   CLEAR                   V#CNEX
069300110216     C                   CLEAR                   V#NDXX
069400110216     C                   CLEAR                   V@PLNX
069500110216     C                   CLEAR                   V@ENRX
069600110216     C                   CLEAR                   V@FRMX
069700110216     C                   CLEAR                   V@TRMX
069800110216    ***
069900110216     C                   EVAL      M@FRMBR = 0
070000110216     C                   EVAL      M@TRMBR = 0
070100110216     C                   EVAL      D@FRMBR = 0
070200110216     C                   EVAL      D@TRMBR = 0
070300110216     C                   EVAL      V@FRMBR = 0
070400110216     C                   EVAL      V@TRMBR = 0
070500110216     C                   EVAL      R@FRMBR = 0
070600110216     C                   EVAL      R@TRMBR = 0
070700110216     C                   EVAL      M@ENMBR = *BLANKS
070800110216     C                   EVAL      D@ENMBR = *BLANKS
070900110216     C                   EVAL      V@ENMBR = *BLANKS
071000110216     C                   EVAL      R@ENMBR = *BLANKS
071100110216    ***
071200110216     C                   ENDSR
071300110216   S***S
071400101215    *** CHECK ALL 4 TERM TYPES
071500101215    ***
071600101215     C     $CHK4TERM     BEGSR
071700101215    * *
071800101215     C                   EVAL      SKIP_MED = NO
071900101215     C                   EVAL      SKIP_DEN = NO
072000101215     C                   EVAL      SKIP_VIS = NO
072100101215     C                   EVAL      SKIP_RXD = NO
072200101215    ***
072300101215     C                   IF        M#CNE = 0
072400101215     C                   EVAL      SKIP_MED = YES
072500101215     C                   ELSE
072600101215     C                   IF        M@TRM(M#CNE) > 0 AND
072700101215     C                             M@TRM(M#CNE) < 99999999
072800101215     C                   EVAL      KF#TRM = M@TRM(M#CNE)
072900101215     C                   EVAL      KF@PLN = M@PLN(M#CNE)
073000101215     C                   EVAL      KF@ENR = M@ENR(M#CNE)
073100101215     C     KL#MTR        CHAIN     HMR019F
073200101215     C                   IF        %FOUND(HMR019WF)
073300101215     C                   EVAL      SKIP_MED = YES
073400101215     C                   ELSE
073500101215     C                   EXSR      $GENTRM
073600101215     C                   ENDIF
073700101215     C                   ENDIF
073800101215     C                   ENDIF
073900101215    ***
074000101215     C                   IF        D#CNE = 0
074100101215     C                   EVAL      SKIP_DEN = YES
074200101215     C                   ELSE
074300101215     C                   IF        D@TRM(D#CNE) > 0 AND
074400101215     C                             D@TRM(D#CNE) < 99999999
074500101215     C                   EVAL      KF#TRM = D@TRM(D#CNE)
074600101215     C                   EVAL      KF@PLN = D@PLN(D#CNE)
074700101215     C                   EVAL      KF@ENR = D@ENR(D#CNE)
074800101215     C     KL#MTR        CHAIN     HMR019F
074900101215     C                   IF        %FOUND(HMR019WF)
075000101215     C                   EVAL      SKIP_DEN = YES
075100101215     C                   ELSE
075200101215     C                   EXSR      $GENTRM
075300101215     C                   ENDIF
075400101215     C                   ENDIF
075500101215     C                   ENDIF
075600101215    ***
075700101215     C                   IF        V#CNE = 0
075800101215     C                   EVAL      SKIP_VIS = YES
075900101215     C                   ELSE
076000101215     C                   IF        V@TRM(V#CNE) > 0 AND
076100101215     C                             V@TRM(V#CNE) < 99999999
076200101215     C                   EVAL      KF#TRM = V@TRM(V#CNE)
076300101215     C                   EVAL      KF@PLN = V@PLN(V#CNE)
076400101215     C                   EVAL      KF@ENR = V@ENR(V#CNE)
076500101215     C     KL#MTR        CHAIN     HMR019F
076600101215     C                   IF        %FOUND(HMR019WF)
076700101215     C                   EVAL      SKIP_VIS = YES
076800101215     C                   ELSE
076900101215     C                   EXSR      $GENTRM
077000101215     C                   ENDIF
077100101215     C                   ENDIF
077200101215     C                   ENDIF
077300101215    ***
077400101215     C                   IF        R#CNE = 0
077500101215     C                   EVAL      SKIP_RXD = YES
077600101215     C                   ELSE
077700101215     C                   IF        R@TRM(R#CNE) > 0 AND
077800101215     C                             R@TRM(R#CNE) < 99999999
077900101215     C                   EVAL      KF#TRM = R@TRM(R#CNE)
078000101215     C                   EVAL      KF@PLN = R@PLN(R#CNE)
078100101215     C                   EVAL      KF@ENR = R@ENR(R#CNE)
078200101215     C     KL#MTR        CHAIN     HMR019F
078300101215     C                   IF        %FOUND(HMR019WF)
078400101215     C                   EVAL      SKIP_RXD = YES
078500101215     C                   ELSE
078600101215     C                   EXSR      $GENTRM
078700101215     C                   ENDIF
078800101215     C                   ENDIF
078900101215     C                   ENDIF
079000101215    ***
079100101215     C                   ENDSR
079200101215   S***S
079300101215     C     $GENTRM       BEGSR
079400101215    ***
079500101215     C                   CLEAR                   HMR019F
079600101215    ***
079700101215     C                   EVAL      NTSSNO    = KF@SSN
079800101215     C                   EVAL      NTDEPNO   = KF@SEQ
079900101215     C                   EVAL      NTTERMDT  = KF#TRM
080000101215     C                   EVAL      NTPLAN    = KF@PLN
080100101215     C                   EVAL      NTCOVTP   = KF@ENR
080200101215     C                   EVAL      NTTRST    = KF@TRS
080300101215     C                   EVAL      NTSUB#    = KF@SUB
080400101215     C                   EVAL      NTACCT    = KF@ACC
080500101215     C                   EVAL      NTTRANSDT = #TODAY
080600101215    ***
080700101215     C                   WRITE     HMR019F
080800101215    ***
080900101215     C                   ENDSR
081000101019   S***S
081100101215    ***
081200101215    *** DEMOGRAPHICS SET FOR MEMBER
081300101215    ***
081400101215   S***S
081500101019     C     $STEP4        BEGSR
081600101019    ***
081700101019     C                   EVAL      H4SSN = %EDITC(MBSSNO:'X')
081800101215    *C*
081900101019     C                   MOVE      BIRTH         #XSX2
082000101019     C                   EXSR      $DATES
082100101019     C                   EVAL      H4DOB = DATE@OUT
082200101215    *C*
082300101019     C                   EVAL      H4FNAM = %TRIM(MFNAME)
082400101019     C                   EVAL      H4MNAM = MMI
082500101019     C                   EVAL      H4LNAM = %TRIM(MLNAME)
082600101019     C                   EVAL      H4GNDR = SEX
082700101019     C                   EVAL      H4RELC = '20'
082800101019     C                   EVAL      H4SUBIND = 'Y'
082900101215    *C*
083000101215     C                   MOVE      EMPDT         #XSX2
083100101019     C                   EXSR      $DATES
083200101019     C                   EVAL      H4HIREDT = DATE@OUT
083300101215    *C*
083400101019     C                   WRITE     HMR014F
083500101215     C                   ADD       1             C#RECCNT
083600110601    ***
083700110601     C                   IF        CATXT2 = 'PAY LOCATION'
083800110601     C                   EVAL      HARQCD = 'LU'
083900110601     C                   EVAL      HARQID = CACID2
084000140723     ****
084100140723     **** BE SURE TO BLAME BRANDON FOR THIS.
084200140723     **** THIS IS A SPECIAL HARDCODE FOR WILMAC SINCE ACCOUNT 15 WAS TERMINATED
084300140723     ****  TO SEND COBRA PAY LOCATION 99 IN PLACE OF THE ACCOUNTS PAY LOCATION.
084400140723     ****
084500140723     C                   IF        EMPST = 'C'
084600140723     C                   EVAL      HARQID = '99'
084700140723     C                   ENDIF
084800140723     ****
084900140723     ****
085000110614     C                   IF        EMPDT < 20110601
085100110614     C                   EVAL      #XSX2 = 20110601
085200110614     C                   ELSE
085300110601     C                   MOVE      EMPDT         #XSX2
085400110614     C                   ENDIF
085500140924     ****
085600110601     C                   EXSR      $DATES
085700110601     C                   EVAL      HAEFFDTE = DATE@OUT
085800140924     ****
085900120606     C                   SELECT
086000120606     C                   WHEN      MBSSNO = 191500008
086100120605     C                   EVAL      HAEFFDTE = '03/01/2012'
086200120606     C                   WHEN      MBSSNO = 177707778
086300120606     C                   EVAL      HAEFFDTE = '06/01/2012'
086400140408     C                   WHEN      MBSSNO = 132663536 AND
086500140408     C                             HAEFFDTE = '12/31/2012'
086600140408     C                   EVAL      HAEFFDTE = '01/01/2013'
086700140408     C                   ENDSL
086800110601     C                   WRITE     HMR01AF
086900110601     C                   ADD       1             C#RECCNT
087000110601    ***
087100110601     C                   ENDIF
087200101026    ***
087300101215     C                   EVAL      @ADDR = %TRIM(ADDR1)
087400101215     C                   EXSR      $ADDRCHK
087500101215     C                   EVAL      H5AD1 = @ADDR
087600101215    *C*
087700101215     C                   EVAL      @ADDR = %TRIM(ADDR2)
087800101215     C                   EXSR      $ADDRCHK
087900101215     C                   EVAL      H5AD2 = @ADDR
088000101215    *C*
088100101215     C                   EVAL      @ADDR = %TRIM(CITY)
088200101215     C                   EXSR      $ADDRCHK
088300101215     C                   EVAL      H5CITY = @ADDR
088400101215    *C*
088500101215     C                   EVAL      H5STATE = STATE
088600101215     C                   EVAL      @9 = %EDITC(ZIP:'X')
088700101215     C                   EVAL      H5ZIP = %SUBST(@9:1:5)
088800101215    *C*
088900101026     C                   MOVE      EMPDT         #XSX2
089000101026     C                   EXSR      $DATES
089100101026     C                   EVAL      H5ADRED = DATE@OUT
089200101215    *C*
089300101026     C                   WRITE     HMR015F
089400101215     C                   ADD       1             C#RECCNT
089500101026    ***
089600101026     C                   IF        AREA <> 0
089700101215    *C*
089800101026     C                   EVAL      H7AREA = %EDITC(AREA:'X')
089900101026     C                   EVAL      H7PHONE = %EDITC(PHONE:'X')
090000101215    *C*
090100101026     C                   MOVE      EMPDT         #XSX2
090200101026     C                   EXSR      $DATES
090300101026     C                   EVAL      H7EFFDTE = DATE@OUT
090400101215    *C*
090500101026     C                   WRITE     HMR017F
090600101215     C                   ADD       1             C#RECCNT
090700101215    *C*
090800101026     C                   ENDIF
090900101026    ***
091000140516    *** 301 TOBACCO USE
091100140516    ***
091200140520     C                   IF        CACID4 = 'YES'
091300140516     C                   EXSR      $SMOKE
091400140516    *C*
091500140516     C                   IF        @TOKER = 'Y'
091600140516     C                   EVAL      HBTOKE = 'T'
091700140516     C                   ELSE
091800140516     C                   EVAL      HBTOKE = 'N'
091900140516     C                   ENDIF
092000140516    *C*
092100140516     C                   WRITE     HMR01BF
092200140516     C                   ADD       1             C#RECCNT
092300140520     C                   ENDIF
092400140516    ***
092500101019     C                   EVAL      @STEP = 'PREP5'
092600140516    ***
092700140516     C                   ENDSR
092800140516   S***S
092900140516     C     $SMOKE        BEGSR
093000140516    ***
093100140516     C                   MOVE      'N'           @TOKER            1
093200101215    ***
093300140516     C     KL#DCV        CHAIN     SMOKER
093400140516     C                   IF        NOT %FOUND(SMOKE)
093500140516     C                   LEAVESR
093600140516     C                   ENDIF
093700140516    ***
093800140516     C     KL#DCV        SETLL     SMOKER
093900140516     C                   DOU       %EOF(SMOKE)
094000140516     C     KL#DCV        READE     SMOKER
094100140516     C                   IF        NOT %EOF(SMOKE)
094200140516    ***
094300140516     C                   IF        SKRATETO = 0
094400140516     C                   EVAL      SKRATETO = 99999999
094500140516     C                   ENDIF
094600140516    ***
094700140516     C                   IF        #TODAY >= SKRATEFR AND #TODAY <= SKRATETO
094800140516     C                   MOVE      'Y'           @TOKER
094900140516     C                   ENDIF
095000140516    ***
095100140516     C                   ENDIF
095200140516     C                   ENDDO
095300140516    ***
095400101215     C                   ENDSR
095500101215   S***S
095600101215     C     $ADDRCHK      BEGSR
095700101215    ***
095800101215     C     ',':' '       XLATE     @ADDR         @ADDR
095900101215    ***
096000101215     C     '.':' '       XLATE     @ADDR         @ADDR
096100101019    ***
096200101019     C                   ENDSR
096300101215   S***S
096400101215    ***
096500101215    *** COVERAGE SET FOR MEMBER
096600101215    ***
096700101215     C     $PREP5        BEGSR
096800101215    ***
096900101215     C                   EVAL      H8AGRID = @@AGRID
097000101215     C                   EVAL      H8CNTRID = @@CNTRID
097100101215     C                   EVAL      H8KRSQ = '00'
097200110125     C                   EVAL      H8PLNAREA  = @@PLNARA
097300101215    ***
097400110203     C                   EVAL      @STEP = 'STEP5'
097500101215    ***
097600101215     C                   ENDSR
097700101019   S***S
097800101215     C     $STEP5        BEGSR
097900101215    ***
098000101215     C                   IF        SKIP_MED = NO
098100101215     C                   EVAL      KF@PLN = M@PLN(M#CNE)
098200101215     C                   EVAL      @COVRG = M@ENR(M#CNE)
098300101215     C                   EVAL      #ENROLL = M@FRM(M#CNE)
098400101215     C                   EVAL      #CANCEL = M@TRM(M#CNE)
098500110606     C                   EVAL      PDT@CNTR = M@CNTRID(M#CNE)
098600101215     C                   EXSR      $GEN135
098700101215     C                   ENDIF
098800101215    ***
098900101215     C                   IF        SKIP_DEN = NO
099000101215     C                   EVAL      KF@PLN = D@PLN(D#CNE)
099100101215     C                   EVAL      @COVRG = D@ENR(D#CNE)
099200101215     C                   EVAL      #ENROLL = D@FRM(D#CNE)
099300101215     C                   EVAL      #CANCEL = D@TRM(D#CNE)
099400110606     C                   EVAL      PDT@CNTR = D@CNTRID(D#CNE)
099500101215     C                   EXSR      $GEN135
099600101215     C                   ENDIF
099700101215    ***
099800101215     C                   IF        SKIP_VIS = NO
099900101215     C                   EVAL      KF@PLN = V@PLN(V#CNE)
100000101215     C                   EVAL      @COVRG = V@ENR(V#CNE)
100100101215     C                   EVAL      #ENROLL = V@FRM(V#CNE)
100200101215     C                   EVAL      #CANCEL = V@TRM(V#CNE)
100300110606     C                   EVAL      PDT@CNTR = V@CNTRID(V#CNE)
100400101215     C                   EXSR      $GEN135
100500101215     C                   ENDIF
100600101215    ***
100700101215     C                   IF        SKIP_RXD = NO
100800101215     C                   EVAL      KF@PLN = R@PLN(R#CNE)
100900101215     C                   EVAL      @COVRG = R@ENR(R#CNE)
101000101215     C                   EVAL      #ENROLL = R@FRM(R#CNE)
101100101215     C                   EVAL      #CANCEL = R@TRM(R#CNE)
101200110606     C                   EVAL      PDT@CNTR = R@CNTRID(R#CNE)
101300101215     C                   EXSR      $GEN135
101400101215     C                   ENDIF
101500101215    ***
101600101215     C                   EVAL      @STEP = 'PREP6'
101700101215    ***
101800101215     C                   ENDSR
101900101215   S***S
102000101215     C     $GEN135       BEGSR
102100101215    ***
102200101215     C                   EVAL      H8ILC      = *BLANKS
102300101215     C                   EVAL      H8EFFDTE   = *BLANKS
102400101215     C                   EVAL      H8ENR      = *BLANKS
102500101215     C                   EVAL      H8CANCEL   = *BLANKS
102600101215     C                   EVAL      H8CNCODE   = *BLANKS
102700101215    ***
102800110125     C     KL#TSAPC      CHAIN     CARPLNR
102900110125     C                   IF        NOT %FOUND(CARPLNP)
103000110125     C                   EVAL      @@ILC = 'XXX'
103100110125     C                   ELSE
103200110125     C                   EVAL      @@ILC = CPCID1
103300110125     C                   ENDIF
103400101215    ***
103500110125     C                   EVAL      H8ILC = @@ILC
103600101215    ***
103700110204     C****               IF        #CANCEL = 99999999 OR #CANCEL = 0
103800110204    *C* ASSUMED ACTIVE
103900101215     C                   SELECT
104000101215     C                   WHEN      @COVRG = 'TFA'
104100101215     C                   EVAL      H8ENR = 'FAM'
104200101215     C                   WHEN      @COVRG = 'THW'
104300101215     C                   EVAL      H8ENR = 'ESP'
104400101215     C                   WHEN      @COVRG = 'TP2'
104500101215     C                   EVAL      H8ENR = 'ECH'
104600101215     C                   WHEN      @COVRG = 'TPC'
104700101215     C                   EVAL      H8ENR = 'EID'
104800101215     C                   WHEN      @COVRG = 'TIN' OR @COVRG = 'TMI'
104900101215     C                   EVAL      H8ENR = 'IND'
105000101215     C                   ENDSL
105100101215    *C*
105200101215     C                   MOVE      #ENROLL       #XSX2
105300101215     C                   EXSR      $DATES
105400101215     C                   EVAL      H8EFFDTE = DATE@OUT
105500101215    *C*
105600110204     C****               ELSE
105700110204     C                   IF        #CANCEL < 99999999 AND #CANCEL > 0
105800101215    *C* TERMED
105900101215     C                   MOVE      #CANCEL       #XSX2
106000101215     C                   EXSR      $DATES
106100101215     C                   EVAL      H8CANCEL = DATE@OUT
106200110413     C                   EVAL      H8CNCODE = '01'
106300101215    *C*
106400101215     C                   ENDIF
106500140924    ***
106600140924    *** 1/1/15 GROUP NUMBER/EFFECTIVE DATE OVERRIDE
106700140924    ***
106800140924       IF (CATRST = 597 AND CASUB# = 001 AND CAACCT = 0094) OR
106900140924          (CATRST = 597 AND CASUB# = 001 AND CAACCT = 0038) OR
107000140924          (CATRST = 597 AND CASUB# = 001 AND CAACCT = 0042) OR
107100140924          (CATRST = 597 AND CASUB# = 001 AND CAACCT = 0002);
107200140924          IF #ENROLL < 20150101;
107300140924             H8EFFDTE = '01/01/2015';
107400140924          ENDIF;
107500140924          IF #CANCEL < 99999999 AND #CANCEL > 0 AND #CANCEL < 20150101;
107600140924             H8CANCEL = '01/01/2015';
107700140924          ENDIF;
107800140924       ENDIF;
107900140924    ***
108000140924    ***
108100101215    ***
108200110606     C                   EVAL      H8CNTRID = PDT@CNTR
108300101215     C                   WRITE     HMR018F
108400101215     C                   ADD       1             C#RECCNT
108500110614    ***
108600110614     C                   IF        CACID3 = 'YES' AND CPCID1 = 'PPO'
108700110616     C                             AND CPCID3 <> '02860707'
108800110614     C                   EVAL      H8ILC = 'PDG'
108900110614     C                   WRITE     HMR018F
109000110614     C                   ADD       1             C#RECCNT
109100110614     C                   ENDIF
109200101215    ***
109300101215     C                   ENDSR
109400101215   S***S
109500101215     *********************************************************************
109600101215     *********   DEPENDENT LEVEL CODING BELOW          *******************
109700101215     *********************************************************************
109800101215     C     $PREP6        BEGSR
109900101215    ***
110000101215     C     KF@SSN        CHAIN     DEPENR
110100101215     C                   IF        NOT %FOUND(DEPNDC)
110200101215     C                   EVAL      @STEP = 'STEP2'
110300101215     C                   LEAVESR
110400101215     C                   ENDIF
110500101215    ***
110600101215     C     KF@SSN        SETLL     DEPENR
110700101215    ***
110800110128     C                   EVAL      @STEP = 'STEP6'
110900110128    ***
111000101215     C                   ENDSR
111100101019   S***S
111200101215     C     $STEP6        BEGSR
111300101215    ***
111400101215     C     KF@SSN        READE     DEPENR
111500101215    ***
111600101215     C                   IF        %EOF(DEPNDC)
111700101215     C                   EVAL      @STEP = 'STEP2'
111800101215     C                   LEAVESR
111900101215     C                   ENDIF
112000101215    ***
112100101215     C                   EVAL      KF@SEQ = DPSEQ#
112200101215    ***
112300101215     C     KL#DCV        CHAIN     DCOVR
112400101215     C                   IF        NOT %FOUND(DCOVA)
112500101215     C                   LEAVESR
112600101215     C                   ENDIF
112700101215    ***
112800101215     C                   EVAL      @STEP = 'PREP7'
112900101215    ***
113000101215     C                   ENDSR
113100101215   S***S
113200101215     C     $PREP7        BEGSR
113300101019    ***
113400101215     C                   EXSR      $CLRSTG
113500101215    ***
113600101019     C     KL#DCV        SETLL     DCOVR
113700101019    ***
113800101215     C                   EVAL      @STEP = 'STEP7'
113900101019    ***
114000101019     C                   ENDSR
114100101019   S***S
114200101215     C     $STEP7        BEGSR
114300101019    ***
114400101019     C     KL#DCV        READE     DCOVR
114500101019    ***
114600101019     C                   IF        %EOF(DCOVA)
114700101215     C                   EVAL      @STEP = 'PREP8'
114800101019     C                   LEAVESR
114900101019     C                   ENDIF
115000101019    ***
115100110301     C                   IF        DENRDT = CCANDT AND
115200110301     C                             CCANDT <> TERMDT
115300101019     C                   LEAVESR
115400101019     C                   ENDIF
115500101019    ***
115600110617     ****ADAMS COUNTY OFFICE FOR THE AGING - REQUESTED EXCLUSION OF MEDICARE PLANS
115700110617    ***
115800110617     C                   IF        KF@TRS = 598 AND
115900110617     C                             KF@SUB = 1 AND
116000110617     C                             KF@ACC = 3 AND
116100110617     C                             (DVPLAN = 'FAAS' OR DVPLAN = 'FAAT')
116200110617     C                   LEAVESR
116300110617     C                   ENDIF
116400110617    ***
116500101019     C                   EVAL      KF@PLN = DVPLAN
116600110204     C                   EVAL      KF@CCTR = *BLANKS
116700101019    ***
116800111005     C                   EXSR      $SUBSET8
116900111005    ***
117000111005    ***
117100111005     ****BROOKS-HUFF TIRE COMPANY OF SHREWSBURY, INC REQUESTED DRUG PLAN FAKE OUT
117200111005    ***
117300111005     C                   IF        KF@TRS = 597  AND
117400111005     C                             KF@SUB = 001  AND
117500111005     C                             KF@ACC = 0036 AND
117600140318     C                             (DVPLAN = 'DAAK' OR DVPLAN = 'KAAD')
117700111005     C                   EVAL      KF@PLN = 'FAKE'
117800111005     C                   EVAL      KF@CCTR = *BLANKS
117900111005     C                   EXSR      $SUBSET8
118000111005     C                   ENDIF
118100111005    ***
118200111005    ***
118300111005     C                   ENDSR
118400111005   S***S
118500111005     C     $SUBSET8      BEGSR
118600111005    ***
118700101215     C     KL#TSAPC      CHAIN     CARPLNR
118800101215     C                   IF        NOT %FOUND(CARPLNP)
118900101215     C                   LEAVESR
119000101215     C                   ENDIF
119100101215    ***
119200110204     C                   EVAL      #ENROLL = DENRDT
119300101215     C                   EVAL      @COVRG = *BLANKS
119400101215    ***
119500110204     C                   IF        CCANDT = 0
119600101215     C                   EVAL      #CANCEL = 99999999
119700101215     C                   ELSE
119800110204     C                   EVAL      #CANCEL = CCANDT
119900101215     C                   ENDIF
120000101215    ***
120100101215     C                   EXSR      $TABLES
120200101215    ***
120300101019     C                   ENDSR
120400101019   S***S
120500101215     C     $PREP8        BEGSR
120600101215    ***
120700101215     C                   EXSR      $CHK4TERM
120800101215    ***
120900101215     C                   IF        SKIP_MED = YES AND
121000101215     C                             SKIP_DEN = YES AND
121100101215     C                             SKIP_VIS = YES AND
121200101215     C                             SKIP_RXD = YES
121300101215     C                   EVAL      @STEP = 'STEP6'
121400101215     C                   LEAVESR
121500101215     C                   ENDIF
121600101215    ***
121700101215     C                   MOVE      KF@SEQ        @SEQ              2
121800101215     C                   EVAL      H4KRSQ = @SEQ
121900101215     C                   EVAL      H5KRSQ = @SEQ
122000101215     C                   EVAL      H7KRSQ = @SEQ
122100140516     C                   EVAL      HBKRSQ = @SEQ
122200101215    ***
122300101215    ***
122400101215     C                   MOVE      *BLANKS       @9
122500101215    ***
122600101215     C                   EVAL      H4SSN      = *BLANKS
122700101215     C                   EVAL      H4DOB      = *BLANKS
122800101215     C                   EVAL      H4FNAM     = *BLANKS
122900101215     C                   EVAL      H4MNAM     = *BLANKS
123000101215     C                   EVAL      H4LNAM     = *BLANKS
123100101215     C                   EVAL      H4GNDR     = *BLANKS
123200101215     C                   EVAL      H4RELC     = *BLANKS
123300101215     C                   EVAL      H4SUBIND   = 'N'
123400101215     C                   EVAL      H4HIREDT   = *BLANKS
123500101215    ***
123600101215     C                   EVAL      H5AD1      = *BLANKS
123700101215     C                   EVAL      H5AD2      = *BLANKS
123800101215     C                   EVAL      H5CITY     = *BLANKS
123900101215     C                   EVAL      H5STATE    = *BLANKS
124000101215     C                   EVAL      H5ZIP      = *BLANKS
124100101215     C                   EVAL      H5ADRED    = *BLANKS
124200101215    ***
124300101215     C                   EVAL      H7AREA     = *BLANKS
124400101215     C                   EVAL      H7PHONE    = *BLANKS
124500101215     C                   EVAL      H7EFFDTE   = *BLANKS
124600101215    ***
124700101215     C                   EVAL      @STEP = 'STEP8'
124800101215    ***
124900101215     C                   ENDSR
125000101215   S***S
125100101215     C     $STEP8        BEGSR
125200101215    ***
125300130425     C                   IF        DEPSS# = 0
125400130425     C                   EVAL      H4SSN = *BLANKS
125500130425     C                   ELSE
125600101215     C                   EVAL      H4SSN = %EDITC(DEPSS#:'X')
125700130425     C                   ENDIF
125800101215    *C*
125900101215     C                   MOVE      DBIRTH        #XSX2
126000101215     C                   EXSR      $DATES
126100101215     C                   EVAL      H4DOB = DATE@OUT
126200101215    *C*
126300101215     C                   EVAL      H4FNAM = %TRIM(DFNAME)
126400101215     C                   EVAL      H4MNAM = DMI
126500101215     C                   EVAL      H4LNAM = %TRIM(DLNAME)
126600101215     C                   EVAL      H4GNDR = DSEX
126700101215     C                   EVAL      H4SUBIND = 'N'
126800101215    *C*
126900101215     C                   IF        DRELCD = 'RSO' OR DRELCD = 'RDA'
127000101215     C                   EVAL      H4RELC = '02'
127100101215     C                   ELSE
127200101215     C                   EVAL      H4RELC = '01'
127300101215     C                   ENDIF
127400101215    *C*
127500101215     C                   WRITE     HMR014F
127600101215     C                   ADD       1             C#RECCNT
127700140516    ***
127800140516    *** 301 TOBACCO USE
127900140516    ***
128000140520     C                   IF        CACID4 = 'YES'
128100140516     C                   EXSR      $SMOKE
128200140516    *C*
128300140516     C                   IF        @TOKER = 'Y'
128400140516     C                   EVAL      HBTOKE = 'T'
128500140516     C                   ELSE
128600140523     C                   EVAL      HBTOKE = 'U'
128700140516     C                   ENDIF
128800140516    *C*
128900140516     C                   WRITE     HMR01BF
129000140516     C                   ADD       1             C#RECCNT
129100140520     C                   ENDIF
129200101215    ***
129300110310    *** INSTRUCTED BY CARRIER TO NOT SEND DEPENDENT ADDRESS
129400101215    ***
129500110309    *** CHECK FOR ELIGIBILITY QUALIFIER RECORD WRITE
129600110309    ***
129700110309     C                   EXSR      $115
129800110309    ***
129900101215    ***
130000110310    *** INSTRUCTED BY CARRIER TO NOT SEND FOR DEPENDENT PHONE
130100101215    ***
130200101215     C                   EVAL      @STEP = 'PREP9'
130300110309    ***
130400110309     C                   ENDSR
130500110309   S***S
130600110309     C     $115          BEGSR
130700110309    ***
130800110309     C                   IF        (DRELCD = 'RSO' OR DRELCD = 'RDA') AND
130900140812     C                             (DSTUDN = 'Y' OR DHNDCP = '3')
131000110309    *C*
131100110309     C                   EVAL      H6AGRID = @@AGRID
131200110309     C                   EVAL      H6CNTRID = @@CNTRID
131300110309     C                   EVAL      H6KRSQ = @SEQ
131400110309    *C*
131500110309     C                   EVAL      CALC#TDAY = %DATE
131600110309     C                   MOVE      DBIRTH        CALC#BDAY
131700110309     C     CALC#TDAY     SUBDUR    CALC#BDAY     #AGE:*Y
131800110309    *C*
131900110309    *C* OBAMACARE CRAP CLAUSE - IF 26 OR LESS, YOU ARE COVERED UNDER MEMBER PLAN
132000110309    *C*
132100110309     C                   IF        #AGE <= 26
132200110309     C                   LEAVESR
132300110309     C                   ENDIF
132400110309    *C*
132500110309     C                   IF        #AGE > 26 AND DSTUDN = 'Y'
132600110309     C                   EVAL      H6EQC = 'F'
132700110309     C                   ENDIF
132800110309    *C*
132900140812     C                   IF        DHNDCP = '3'
133000110309     C                   EVAL      H6EQC = '3'
133100110309     C                   ENDIF
133200110309    *C*
133300110309     C                   SELECT
133400110309     C                   WHEN      M#CNE > 0
133500110309     C                   EVAL      #XSX2 = M@FRM(M#CNE)
133600110309     C                   WHEN      D#CNE > 0
133700110309     C                   EVAL      #XSX2 = D@FRM(D#CNE)
133800110309     C                   WHEN      V#CNE > 0
133900110309     C                   EVAL      #XSX2 = V@FRM(V#CNE)
134000110309     C                   WHEN      R#CNE > 0
134100110309     C                   EVAL      #XSX2 = R@FRM(R#CNE)
134200110309     C                   ENDSL
134300110309     C                   EXSR      $DATES
134400110309     C                   EVAL      H6EFFDTE = DATE@OUT
134500110309    *C*
134600110309     C                   WRITE     HMR016F
134700110309     C                   ADD       1             C#RECCNT
134800110309    *C*
134900110309     C                   ENDIF
135000101215    ***
135100101215     C                   ENDSR
135200101215   S***S
135300101215    ***
135400101215    *** COVERAGE SET FOR DEPENDENT
135500101215    ***
135600101215     C     $PREP9        BEGSR
135700101215    ***
135800101215     C                   EVAL      H8AGRID = @@AGRID
135900101215     C                   EVAL      H8CNTRID = @@CNTRID
136000101215     C                   EVAL      H8KRSQ = @SEQ
136100110209     C                   EVAL      H8PLNAREA  = @@PLNARA
136200101215    ***
136300110203     C                   EVAL      @STEP = 'STEP9'
136400101215    ***
136500101215     C                   ENDSR
136600101215   S***S
136700101215     C     $STEP9        BEGSR
136800101215    ***
136900101215     C                   IF        SKIP_MED = NO
137000101215     C                   EVAL      KF@PLN = M@PLN(M#CNE)
137100110216     C                   EVAL      @COVRG = M@ENMBR
137200101215     C                   EVAL      #ENROLL = M@FRM(M#CNE)
137300101215     C                   EVAL      #CANCEL = M@TRM(M#CNE)
137400110204     C                   IF        #ENROLL < M@FRMBR AND
137500110204     C                             (#CANCEL = 0 OR #CANCEL = 99999999)
137600110204     C                   EVAL      #ENROLL = M@FRMBR
137700110204     C                   ENDIF
137800110216     C                   IF        #CANCEL <> 0 AND #CANCEL <> 99999999
137900110216     C                   EXSR      $SRCHMED
138000110216     C                   ENDIF
138100110606     C                   EVAL      PDT@CNTR = M@CNTRID(M#CNE)
138200101215     C                   EXSR      $GEN135
138300101215     C                   ENDIF
138400101215    ***
138500101215     C                   IF        SKIP_DEN = NO
138600101215     C                   EVAL      KF@PLN = D@PLN(D#CNE)
138700110216     C                   EVAL      @COVRG = D@ENMBR
138800101215     C                   EVAL      #ENROLL = D@FRM(D#CNE)
138900101215     C                   EVAL      #CANCEL = D@TRM(D#CNE)
139000110204     C                   IF        #ENROLL < D@FRMBR AND
139100110204     C                             (#CANCEL = 0 OR #CANCEL = 99999999)
139200110204     C                   EVAL      #ENROLL = D@FRMBR
139300110204     C                   ENDIF
139400110606     C                   EVAL      PDT@CNTR = D@CNTRID(D#CNE)
139500101215     C                   EXSR      $GEN135
139600101215     C                   ENDIF
139700101215    ***
139800101215     C                   IF        SKIP_VIS = NO
139900101215     C                   EVAL      KF@PLN = V@PLN(V#CNE)
140000110216     C                   EVAL      @COVRG = V@ENMBR
140100101215     C                   EVAL      #ENROLL = V@FRM(V#CNE)
140200101215     C                   EVAL      #CANCEL = V@TRM(V#CNE)
140300110204     C                   IF        #ENROLL < V@FRMBR AND
140400110204     C                             (#CANCEL = 0 OR #CANCEL = 99999999)
140500110204     C                   EVAL      #ENROLL = V@FRMBR
140600110204     C                   ENDIF
140700110606     C                   EVAL      PDT@CNTR = V@CNTRID(V#CNE)
140800101215     C                   EXSR      $GEN135
140900101215     C                   ENDIF
141000101215    ***
141100101215     C                   IF        SKIP_RXD = NO
141200101215     C                   EVAL      KF@PLN = R@PLN(R#CNE)
141300110216     C                   EVAL      @COVRG = R@ENMBR
141400101215     C                   EVAL      #ENROLL = R@FRM(R#CNE)
141500101215     C                   EVAL      #CANCEL = R@TRM(R#CNE)
141600110204     C                   IF        #ENROLL < R@FRMBR AND
141700110204     C                             (#CANCEL = 0 OR #CANCEL = 99999999)
141800110204     C                   EVAL      #ENROLL = R@FRMBR
141900110204     C                   ENDIF
142000110606     C                   EVAL      PDT@CNTR = R@CNTRID(R#CNE)
142100101215     C                   EXSR      $GEN135
142200101215     C                   ENDIF
142300101215    ***
142400101215     C                   EVAL      @STEP = 'STEP6'
142500110216    ***
142600110216     C                   ENDSR
142700110216   S***S
142800110216     C     $SRCHMED      BEGSR
142900110216    ***
143000110216     C                   EVAL      W = 0
143100110216     C                   DO        M#CNEX
143200110216     C                   ADD       1             W
143300110216     C                   IF        #CANCEL >  M@FRMX(W) AND
143400110216     C                             #CANCEL <= M@TRMX(W)
143500110216     C                   EVAL      @COVRG = M@ENRX(W)
143600110216     C                   LEAVESR
143700110216     C                   ENDIF
143800110216     C                   ENDDO
143900101215    ***
144000101215     C                   ENDSR
144100101215   S***S
144200110216     C     $SRCHDEN      BEGSR
144300110216    ***
144400110216     C                   EVAL      W = 0
144500110216     C                   DO        D#CNEX
144600110216     C                   ADD       1             W
144700110216     C                   IF        #CANCEL >  D@FRMX(W) AND
144800110216     C                             #CANCEL <= D@TRMX(W)
144900110216     C                   EVAL      @COVRG = D@ENRX(W)
145000110216     C                   LEAVESR
145100110216     C                   ENDIF
145200110216     C                   ENDDO
145300110216    ***
145400110216     C                   ENDSR
145500110216   S***S
145600110216     C     $SRCHVIS      BEGSR
145700110216    ***
145800110216     C                   EVAL      W = 0
145900110216     C                   DO        V#CNEX
146000110216     C                   ADD       1             W
146100110216     C                   IF        #CANCEL >  V@FRMX(W) AND
146200110216     C                             #CANCEL <= V@TRMX(W)
146300110216     C                   EVAL      @COVRG = V@ENRX(W)
146400110216     C                   LEAVESR
146500110216     C                   ENDIF
146600110216     C                   ENDDO
146700110216    ***
146800110216     C                   ENDSR
146900110216   S***S
147000110216     C     $SRCHRXD      BEGSR
147100110216    ***
147200110216     C                   EVAL      W = 0
147300110216     C                   DO        R#CNEX
147400110216     C                   ADD       1             W
147500110216     C                   IF        #CANCEL >  R@FRMX(W) AND
147600110216     C                             #CANCEL <= R@TRMX(W)
147700110216     C                   EVAL      @COVRG = R@ENRX(W)
147800110216     C                   LEAVESR
147900110216     C                   ENDIF
148000110216     C                   ENDDO
148100110216    ***
148200110216     C                   ENDSR
148300110216   S***S
148400101019     C     *INZSR        BEGSR
148500110128    ***
148600110128     C                   EVAL      #ISO = %DATE
148700110128     C                   MOVE      #ISO          #TODAY
148800101019    ***
148900101019     C     KL#TSAPC      KLIST
149000101019     C                   KFLD                    CARR#CTL
149100101019     C                   KFLD                    KF@TRS
149200101019     C                   KFLD                    KF@SUB
149300101019     C                   KFLD                    KF@ACC
149400101019     C                   KFLD                    KF@CCTR
149500101019     C                   KFLD                    KF@PLN
149600101019    ***
149700101019     C     KL#MTR        KLIST
149800101019     C                   KFLD                    KF@SSN
149900101019     C                   KFLD                    KF@SEQ
150000101019     C                   KFLD                    KF#TRM
150100101019     C                   KFLD                    KF@PLN
150200101019     C                   KFLD                    KF@ENR
150300101019     C                   KFLD                    KF@TRS
150400101019     C                   KFLD                    KF@SUB
150500101019     C                   KFLD                    KF@ACC
150600101019    ***
150700101019     C     KL#TSA        KLIST
150800101019     C                   KFLD                    KF@TRS
150900101019     C                   KFLD                    KF@SUB
151000101019     C                   KFLD                    KF@ACC
151100101019    ***
151200101019     C     KL#DCV        KLIST
151300101019     C                   KFLD                    KF@SSN
151400101019     C                   KFLD                    KF@SEQ
151500101019    ***
151600101019     C     KL#CDM        KLIST
151700101019     C                   KFLD                    KF@TYP
151800101019     C                   KFLD                    KF@CDE
151900101019    ***
152000101019     C     KL#MPLN       KLIST
152100101019     C                   KFLD                    KF@SSN
152200101019     C                   KFLD                    KF@SEQ
152300101019     C                   KFLD                    KF@TRS
152400101019     C                   KFLD                    KF@SUB
152500101019     C                   KFLD                    KF@ACC
152600101019    ***
152700101019     C     KL#PLN        KLIST
152800101019     C                   KFLD                    KF@TRS
152900101019     C                   KFLD                    KF@SUB
153000101019     C                   KFLD                    KF@PLN
153100101019    ***
153200101019     C                   ENDSR
153300101019   S***S
