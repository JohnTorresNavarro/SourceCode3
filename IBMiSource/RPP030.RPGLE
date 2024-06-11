000100111104   X***X RPP030 PAMELA SPENCER REPORTS - FULLY INSURED VERSION
000200111104   X***X
000300111104   X***X ACTIVE LARGE GROUP ACCOUNTS AT THE HYPERCARRIER/PRODUCT GROUPER LEVEL
000400111104   X***X
000500111104   X***X TERMED LARGE GROUP ACCOUNTS AT THE HYPERCARRIER/PRODUCT GROUPER LEVEL
000600111104   X***X
000700111104   X***X ALSO, PAR GROUPS ARE INCLUDED SINCE THEY ARE RATED AS LARGE GROUP.
000800111104   X***X
000900111104   X***X SSK 11/5/2011
001000111104   X***X
001100111101     FACMUNIQUE IPE  E           K DISK
001200111103     FSMANUNIQUEIF   E           K DISK
001300111103     FCOMCTUNIQ IF   E           K DISK
001400111103     FCARUNIQUE IF   E           K DISK
001500111101     FAC2MST    IF   E           K DISK
001600111101     FSMANRMGP  IF   E           K DISK
001700111101     FRMGRMST0  IF   E           K DISK
001800111103     FPLNUNIQUE IF   E           K DISK
001900111103     FHYPERCARR IF   E           K DISK
002000111103     FCODESL1   IF   E           K DISK
002100111104     FTRKRNWLF  IF   E           K DISK
002200111103     FPCTMST    IF   E           K DISK
002300111104    ***
002400111104     FRPP030WF  O  A F  300        DISK                                         TERMED REPORT
002500111104    ***
002600111104     FRPP031WF  O  A F  300        DISK                                         ACTIVE REPORT
002700111104   X***X
002800111101    ***
002900111104     D ACTR            S              1A
003000111103     D @@ACTN          S              1A
003100111103     D @@GRPCD         S              2A
003200111104     D @XH             S            300A
003300111104     D @X              S            300A
003400111104     D DT@             S              8S 0 DIM(200)
003500111103     D CC@             S              3A   DIM(200)
003600111103     D NDX             S              3S 0
003700111103     D CNE             S              3S 0
003800111103     D @3              S              3A
003900111103     D X               S              1A
004000111104     D DS@TRK        E DS                  EXTNAME(TRKRNWLP)
004100111103     D DS@HYC        E DS                  EXTNAME(HYPERCARR)
004200111103     D DS@PCT        E DS                  EXTNAME(PCTMST)
004300111103     D DS@CTX        E DS                  EXTNAME(COMCTX)
004400111101    ***
004500111103     C                   MOVE      'F'           X
004600111104     C                   EVAL      ACTR = *BLANKS
004700111104     C                   MOVE      *BLANKS       @PAR
004800111104    ***
004900111104     C                   IF        NOEMPL > 50
005000111101     C                   EXSR      $PROC
005100111101     C                   ELSE
005200111101    ***
005300111101     C     KL#AC2        CHAIN     ACCMSR2
005400120124     C                   IF        A2PAR = 'Y'
005500111104     C                   MOVE      'PAR'         @PAR              3
005600111101     C                   EXSR      $PROC
005700111101     C                   ENDIF
005800111101    ***
005900111101     C                   ENDIF
006000111101    ***
006100111103   S***S
006200111104     C     $PROC         BEGSR
006300111104    ***
006400111104     C                   SELECT
006500111104     C                   WHEN      ATRMDT = 0
006600111104     C                   EVAL      ACTR = 'A'                                   ACTIVE
006700111104     C                   WHEN      ATRMDT >= #FR AND ATRMDT <= #TO
006800111104     C                   EVAL      ACTR = 'T'                                   TERMED IN RANGE
006900111104     C                   OTHER
007000111104     C                   LEAVESR                                                ELSE SKIP IT
007100111104     C                   ENDSL
007200111104    ***
007300111101     C                   EXSR      $SMAN
007400111103     C                   CLEAR                   CC@
007500111104     C                   CLEAR                   DT@
007600111103     C                   EVAL      NDX = 0
007700111103     C                   EVAL      CNE = 0
007800111101     C                   EXSR      $PDTS
007900111103     C                   EXSR      $WRITE
008000111104    ***
008100111101     C                   ENDSR
008200111103   S***S
008300111101     C     $SMAN         BEGSR
008400111103     C     SMANCD        CHAIN     SMANR
008500111101     C                   EXSR      $GETSNAME
008600111103     C     SMANCD        CHAIN     SMANRMGR
008700111101     C     SMRMGR        CHAIN     RMGRMSTR
008800111103     **
008900111101     C                   ENDSR
009000111103   S***S
009100111101     C     $PDTS         BEGSR
009200111103     **
009300111103     C     KL#CU         CHAIN     COMCXR
009400111103     C                   IF        NOT %FOUND(COMCTUNIQ)
009500111103     C                   LEAVESR
009600111103     C                   ENDIF
009700111103     **
009800111103     C     KL#CU         SETLL     COMCXR
009900111103     C                   DOU       %EOF(COMCTUNIQ)
010000111103     C     KL#CU         READE     COMCXR
010100111103     C                   IF        NOT %EOF(COMCTUNIQ)
010200111103     **
010300111104     C                   IF        ACTR = 'A'                                   ACTIVE
010400111104     C                   IF        CMCAN > 0
010500111104     C                   ITER
010600111104     C                   ENDIF
010700111104     C                   ELSE
010800111104     C                   IF        CMCAN = 0                                    TERMED
010900111103     C                   EVAL      CMCAN = ATRMDT
011000111103     C                   ENDIF
011100111104     C                   IF        CMCAN < #FR
011200111103     C                   ITER
011300111103     C                   ENDIF
011400111104     C                   ENDIF
011500111103     **
011600111103     C     KL#PLN        CHAIN     PLNMSR
011700111103     C                   IF        NOT %FOUND(PLNUNIQUE)
011800111103     C                   SETON                                        H2
011900111103     C                   ITER
012000111103     C                   ENDIF
012100111104     **
012200111104     C                   IF        ACTR = 'A'                                   ACTIVE
012300111104     C                   EVAL      @2CAT = %SUBST(PLNCAT:2:2)
012400111104     C     KL#TRK        CHAIN     TRKRNWLR
012500111104     C                   IF        NOT %FOUND(TRKRNWLF)
012600111104     C                   CLEAR                   DS@TRK
012700111104     C                   ENDIF
012800111104     C                   ENDIF
012900111103     **
013000111103     C     PCARR         CHAIN     CARMSR
013100111103     C                   IF        NOT %FOUND(CARUNIQUE)
013200111103     C                   SETON                                        H1
013300111103     C                   ITER
013400111103     C                   ENDIF
013500111103     **
013600111103     C     PLNCAT        CHAIN     CODESR
013700111103     C                   IF        NOT %FOUND(CODESL1)
013800111103     C                   SETON                                        H3
013900111103     C                   ITER
014000111103     C                   ENDIF
014100111103     **
014200111103     C                   EVAL      @3 = CGRPCD + ACTION
014300111103     C                   IF        CNE = 0
014400111103     C                   ADD       1             CNE
014500111104     C                   IF        ACTR = 'A'                                   ACTIVE
014600111104     C                   EVAL      DT@(CNE) = TRNRNDT
014700111104     C                   ENDIF
014800111103     C                   EVAL      CC@(CNE) = @3
014900111103     C                   ELSE
015000111103     C                   EXSR      $SEARCH
015100111103     C                   ENDIF
015200111103     **
015300111103     C                   ENDIF
015400111103     C                   ENDDO
015500111103     **
015600111103     C                   ENDSR
015700111103   S***S
015800111103     C     $SEARCH       BEGSR
015900111103     **
016000111103     C                   EVAL      NDX = 0
016100111103     C                   DO        CNE
016200111103     C                   ADD       1             NDX
016300111103     C                   IF        CC@(NDX) = @3
016400111103     C                   LEAVESR
016500111103     C                   ENDIF
016600111103     C                   ENDDO
016700111103     **
016800111103     C                   ADD       1             CNE
016900111103     C                   EVAL      CC@(CNE) = @3
017000111104     C                   IF        ACTR = 'A'                                   ACTIVE
017100111104     C                   EVAL      DT@(CNE) = TRNRNDT
017200111104     C                   ENDIF
017300111103     **
017400111103     C                   ENDSR
017500111103   S***S
017600111103     C     $WRITE        BEGSR
017700111103     **
017800111103     C                   MOVE      GBSBDT        #OEF              8 0
017900111103     C                   MULT      10000.0001    #OEF
018000111103     **
018100111103     C                   EVAL      @X = '"' + %TRIM(A@40) + '","' +
018200111103     C                             %TRIM(RMNAME) + '","' +
018300111103     C                             %TRIM(ACNAM1) + '","' +
018400111104     C                             %TRIM(@PAR) + '","' +
018500111103     C                             %TRIM(%CHAR(MEDEMP)) + '","' +
018600111104     C                             %TRIM(%CHAR(NOEMPL)) + '","' +
018700111104     C                             %EDITC(#OEF:'Y') + '"'
018800111103     C                   IF        CNE = 0
018900111104     C                   IF        ACTR = 'T'                                   TERMED
019000111107     C                   MOVE      ATRMDT        #TER              8 0
019100111104     C                   MULT      10000.0001    #TER
019200120124     C                   EVAL      @X = %TRIM(@X) + ',"' + %EDITC(#TER:'Y') +
019300120124     C                             '","NON-RENEW","NON-RENEW"'
019400111104     C                   EXCEPT    TRMF
019500111104     C                   ELSE
019600120124     C                   EVAL      @X = %TRIM(@X) + ',"NON-RENEW' +
019700120124     C                             '","NON-RENEW","NON-RENEW"'
019800111104     C                   EXCEPT    ACTF                                         ACTIVE
019900111104     C                   ENDIF
020000111103     C                   LEAVESR
020100111103     C                   ENDIF
020200111103     **
020300111103     C                   EVAL      @XH = @X
020400111103     C                   EVAL      NDX = 0
020500111103     C                   DO        CNE
020600111103     C                   ADD       1             NDX
020700111103     **
020800111103     C                   EVAL      @3 = CC@(NDX)
020900111103     C                   EVAL      @@GRPCD = %SUBST(@3:1:2)
021000111103     C                   EVAL      @@ACTN  = %SUBST(@3:3:1)
021100111103     **
021200111103     C     @@GRPCD       CHAIN     RHC
021300111103     C                   IF        NOT %FOUND(HYPERCARR)
021400111103     C                   CLEAR                   DS@HYC
021500111103     C                   ENDIF
021600111103     **
021700111103     C     @@ACTN        CHAIN     PCTR
021800111103     C                   IF        NOT %FOUND(PCTMST)
021900111103     C                   CLEAR                   DS@PCT
022000111103     C                   ENDIF
022100111103     **
022200111104     C                   IF        ACTR = 'T'                                   TERMED
022300120124     C                   MOVE      ATRMDT        #TER              8 0
022400120124     C                   MULT      10000.0001    #TER
022500120124     C                   EVAL      @X = %TRIM(@XH) + ',"' +
022600120124     C                             %TRIM(%EDITC(#TER:'Y')) + '"' +
022700120124     C                             ',"' + %TRIM(HCNAME) +
022800120124     C                             '","' + %TRIM(PCDES) + '"'
022900111104     C                   EXCEPT    TRMF
023000120124     C                   ELSE                                                   ACTIVE
023100111104     C                   EVAL      #TRK = DT@(NDX)
023200111104     C                   MULT      10000.0001    #TRK              8 0
023300120124     C                   EVAL      @X = %TRIM(@XH) + ',"' +
023400120124     C                             %TRIM(%EDITC(#TRK:'Y')) + '"' +
023500120124     C                             ',"' + %TRIM(HCNAME) +
023600120124     C                             '","' + %TRIM(PCDES) + '"'
023700111104     C                   EXCEPT    ACTF
023800111104     C                   ENDIF
023900111103     **
024000111103     C                   ENDDO
024100111103     **
024200111103     C                   ENDSR
024300111101   S***S
024400111101     C     $GETSNAME     BEGSR
024500111101    ***
024600111101     C                   CLEAR                   A@20             20
024700111101     C                   CLEAR                   A@40             40
024800111101    ***
024900111101     C                   IF        SFNAME <> *BLANKS
025000111101     C                   MOVEL     SFNAME        A@20
025100111101     C                   EXSR      $LDADDR
025200111101     C                   ENDIF
025300111101    ***
025400111101     C                   IF        SMI <> *BLANKS
025500111101     C                   MOVEL     SMI           A@20
025600111101     C                   EXSR      $LDADDR
025700111101     C                   ENDIF
025800111101    ***
025900111101     C                   IF        SLNAME <> *BLANKS
026000111101     C                   MOVEL     SLNAME        A@20
026100111101     C                   EXSR      $LDADDR
026200111101     C                   ENDIF
026300111101    ***
026400111101     C                   ENDSR
026500111101   S***S
026600111101     C     $LDADDR       BEGSR
026700111101    ***
026800111101     C                   EVAL      A@20 = %TRIM(A@20)
026900111101     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
027000111101     C                   CLEAR                   A@20
027100111101    ***
027200111101     C                   ENDSR
027300111103   S***S
027400111103     C     *INZSR        BEGSR
027500111103    ***
027600111103     C     *ENTRY        PLIST
027700111103     C                   PARM                    @FR               8
027800111103     C                   PARM                    @TO               8
027900111103    ***
028000111103     C                   MOVE      @FR           #FR               8 0
028100111103     C                   MOVE      @TO           #TO               8 0
028200111103    ***
028300111103     C     KL#AC2        KLIST
028400111103     C                   KFLD                    X
028500111103     C                   KFLD                    ACTRST
028600111103     C                   KFLD                    ACSUB#
028700111103     C                   KFLD                    ACACCT
028800111103    ***
028900111103     C     KL#CU         KLIST
029000111103     C                   KFLD                    ACTRST
029100111103     C                   KFLD                    ACSUB#
029200111103     C                   KFLD                    ACACCT
029300111103    ***
029400111103     C     KL#PLN        KLIST
029500111103     C                   KFLD                    CMTRST
029600111103     C                   KFLD                    CSUBDV
029700111103     C                   KFLD                    CMPLAN
029800111103    ***
029900111104     C     KL#TRK        KLIST
030000111104     C                   KFLD                    ACTRST
030100111104     C                   KFLD                    ACSUB#
030200111104     C                   KFLD                    ACACCT
030300111104     C                   KFLD                    @2CAT             2
030400111107    ***
030500111107     C                   EVAL      @X = '"ACCOUNT LISTING BY BROKER THAT ARE ' +
030600111107     C                             'TERMED"'
030700111107     C                   EXCEPT    TRMF
030800111107     C                   EVAL      @X = '"FULLY INSURED BUSINESS"'
030900111107     C                   EXCEPT    TRMF
031000111107     C                   EVAL      @X = ','
031100111107     C                   EXCEPT    TRMF
031200111104    ***
031300111103     C                   EVAL      @X = '"BROKER NAME","ASSIGNED REP","ACCOUN' +
031400111104     C                             'T NAME","PAR","MEDICAL EMPLOYEES","NO. OF' +
031500111104     C                             ' EMPLOYEES","ORIG ADMIN DATE","TERM DATE"' +
031600111104     C                             ',"CARRIER","PRODUCT"'
031700111104     C                   EXCEPT    TRMF
031800111104     **
031900111107     C                   EVAL      @X = '"ACCOUNT LISTING BY BROKER THAT ARE ' +
032000111107     C                             'ACTIVE"'
032100111107     C                   EXCEPT    ACTF
032200111107     C                   EVAL      @X = '"FULLY INSURED BUSINESS"'
032300111107     C                   EXCEPT    ACTF
032400111107     C                   EVAL      @X = ','
032500111107     C                   EXCEPT    ACTF
032600111107    ***
032700111104     C                   EVAL      @X = '"BROKER NAME","ASSIGNED REP","ACCOUN' +
032800111104     C                             'T NAME","PAR","MEDICAL EMPLOYEES","NO. OF' +
032900111104     C                             ' EMPLOYEES","ORIG ADMIN DATE","RENENWAL D' +
033000111104     C                             'ATE","CARRIER","PRODUCT"'
033100111104     C                   EXCEPT    ACTF
033200111103     **
033300111103     C                   ENDSR
033400111101   S***S
033500111104     ORPP030WF  EADD         TRMF
033600111104     O                       @X             B   300
033700111104     ORPP031WF  EADD         ACTF
033800111104     O                       @X             B   300
