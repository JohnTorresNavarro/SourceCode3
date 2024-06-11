000100111104   X***X SSK 11/05/2011 LARGE GROUP REPORT
000200111104   X***X
000300111104   X***X ACTIVE WITH RENEWAL DATE & TERMED OVER A CERTAIN PERIOD REPORT
000400111104   X***X
000500111104   X***X
000600111104     FACCMSTP   IPE  E           K DISK
000700111104     FSMANUNIQUEIF   E           K DISK
000800111104     FACCPRDP   IF   E           K DISK
000900111104     FCARMSTP   IF   E           K DISK
001000111104     FPRDCOML3  IF   E           K DISK
001100111104     FCDEMSTP   IF   E           K DISK
001200111104     FSMANRMGP  IF   E           K DISK
001300111104     FRMGRMST0  IF   E           K DISK
001400111104    ***
001500111104     FRPP030WF  O  A F  300        DISK                                         TERMED REPORT
001600111104    ***
001700111104     FRPP031WF  O  A F  300        DISK                                         ACTIVE REPORT
001800111104   X***X
001900111104    ***
002000111104    ***
002100111104    ***
002200111104     D ACTR            S              1A
002300111104     D @@ACTN          S             10A
002400111104     D @@GRPCD         S              2A
002500111104     D @XH             S            300A
002600111104     D @X              S            300A
002700111107     D #ISO            S               D   DATFMT(*ISO)
002800111104     D DT@             S              8S 0 DIM(200)
002900111104     D CC@             S             12A   DIM(200)
003000111104     D NDX             S              3S 0
003100111107     D CNE             S              3S 0
003200111107     D #RENEW          S              8S 0
003300111104     D @3              S             12A
003400111104     D X               S              1A
003500111104     D ISO#FR          S               D   DATFMT(*ISO)
003600111104     D ISO#TO          S               D   DATFMT(*ISO)
003700111107     D DS@HYC        E DS                  EXTNAME(CARMSTP)
003800111107     D DS@PCT        E DS                  EXTNAME(CDEMSTP)
003900111104    ***
004000111104     C                   MOVE      'F'           X
004100111104     C                   EVAL      ACTR = *BLANKS
004200111104    ***
004300111104     C                   IF        ADBENR >= 50
004400111104     C                   EXSR      $PROC
004500111104     C                   ENDIF
004600111104    ***
004700111104   S***S
004800111104     C     $PROC         BEGSR
004900111104    ***
005000111104     C                   SELECT
005100111104     C                   WHEN      ADTRDT = D'9999-12-31'
005200111104     C                   EVAL      ACTR = 'A'                                   ACTIVE
005300111107     C                   WHEN      ADTRDT >= ISO#FR AND ADTRDT <= ISO#TO
005400111104     C                   EVAL      ACTR = 'T'                                   TERMED IN RANGE
005500111104     C                   OTHER
005600111104     C                   LEAVESR                                                ELSE SKIP IT
005700111104     C                   ENDSL
005800111104    ***
005900111104     C                   EXSR      $SMAN
006000111107    ***
006100111104     C                   CLEAR                   CC@
006200111104     C                   CLEAR                   DT@
006300111104     C                   EVAL      NDX = 0
006400111104     C                   EVAL      CNE = 0
006500111107    ***
006600111104     C                   EXSR      $PDTS
006700111104     C                   EXSR      $WRITE
006800111104    ***
006900111104     C                   ENDSR
007000111104   S***S
007100111104     C     $SMAN         BEGSR
007200111104     C     ADADMIN       CHAIN     SMANR
007300111104     C                   EXSR      $GETSNAME
007400111104     C     ADADMIN       CHAIN     SMANRMGR
007500111104     C     SMRMGR        CHAIN     RMGRMSTR
007600111104     **
007700111104     C                   ENDSR
007800111104   S***S
007900111104     C     $PDTS         BEGSR
008000111104     **
008100111104     C     ADACCT        CHAIN     ACCPRDR
008200111104     C                   IF        NOT %FOUND(ACCPRDP)
008300111104     C                   LEAVESR
008400111104     C                   ENDIF
008500111104     **
008600111104     C     ADACCT        SETLL     ACCPRDR
008700111104     C                   DOU       %EOF(ACCPRDP)
008800111104     C     ADACCT        READE     ACCPRDR
008900111104     C                   IF        NOT %EOF(ACCPRDP)
009000111104     **
009100111107     C                   EVAL      #RENEW = 0
009200111107     **
009300111104     C                   IF        ACTR = 'A'                                   ACTIVE
009400111104     C                   IF        APTRDT <> D'9999-12-31'
009500111104     C                   ITER
009600111104     C                   ENDIF
009700111107     C                   EXSR      $RENEWMTH
009800111104     C                   ELSE
009900111104     C                   IF        APTRDT = D'9999-12-31'                       TERMED
010000111104     C                   EVAL      APTRDT = ADTRDT
010100111104     C                   ENDIF
010200111104     C                   IF        APTRDT < ISO#FR AND APTRDT > ISO#TO
010300111104     C                   ITER
010400111104     C                   ENDIF
010500111104     C                   ENDIF
010600111104     **
010700111104     C     KL#PDC        SETGT     PRDCOMR
010800111104     C     KL#PDC        READPE    PRDCOMR
010900111104     C                   EVAL      @3 = PCPCA + APCAID
011000111107     **
011100111104     C                   IF        CNE = 0
011200111104     C                   ADD       1             CNE
011300111104     C                   EVAL      CC@(CNE) = @3
011400111104     C                   IF        ACTR = 'A'                                   ACTIVE
011500111104     C                   EVAL      DT@(CNE) = #RENEW
011600111104     C                   ENDIF
011700111104     C                   ELSE
011800111104     C                   EXSR      $SEARCH
011900111104     C                   ENDIF
012000111104     **
012100111104     C                   ENDIF
012200111104     C                   ENDDO
012300111107     **
012400111107     C                   ENDSR
012500111107   S***S
012600111107     C     $RENEWMTH     BEGSR
012700111107     **
012800111107     C                   IF        APRMON <= #MTH
012900111107     C                   EVAL      #RENEW = (#NXTYR * 10000) + (APRMON * 100)
013000111107     C                             + 01
013100111107     C                   ELSE
013200111107     C                   EVAL      #RENEW = (#YR * 10000) + (APRMON * 100) + 01
013300111107     C                   ENDIF
013400111104     **
013500111104     C                   ENDSR
013600111104   S***S
013700111104     C     $SEARCH       BEGSR
013800111104     **
013900111104     C                   EVAL      NDX = 0
014000111104     C                   DO        CNE
014100111104     C                   ADD       1             NDX
014200111104     C                   IF        CC@(NDX) = @3
014300111104     C                   LEAVESR
014400111104     C                   ENDIF
014500111104     C                   ENDDO
014600111104     **
014700111104     C                   ADD       1             CNE
014800111104     C                   EVAL      CC@(CNE) = @3
014900111104     C                   IF        ACTR = 'A'                                   ACTIVE
015000111104     C                   EVAL      DT@(CNE) = #RENEW
015100111104     C                   ENDIF
015200111104     **
015300111104     C                   ENDSR
015400111104   S***S
015500111104     C     $WRITE        BEGSR
015600111104     **
015700111104     C     *USA          MOVE      ADGEFD        #OEF              8 0
015800111104     C     *USA          MOVE      ADTRDT        #TER              8 0
015900111104     **
016000111104     C                   EVAL      @X = '"' + %TRIM(A@40) + '","' +
016100111104     C                             %TRIM(RMNAME) + '","' +
016200111104     C                             %TRIM(ADNAME) + '","' +
016300111104     C                             %TRIM(%CHAR(ADBENR)) + '","' +
016400111107     C                             %EDITC(#OEF:'Y') + '"'
016500111107     **
016600111104     C                   IF        CNE = 0
016700111107     C                   IF        ACTR = 'A'                                   ACTIVE
016800111107     C                   EXCEPT    ACTF
016900111107     C                   ELSE
017000111107     C                   EXCEPT    TRMF
017100111107     C                   ENDIF
017200111104     C                   LEAVESR
017300111104     C                   ENDIF
017400111104     **
017500111104     C                   EVAL      @XH = @X
017600111104     C                   EVAL      NDX = 0
017700111104     C                   DO        CNE
017800111104     C                   ADD       1             NDX
017900111104     **
018000111107     C                   EVAL      #RENEW = DT@(CNE)
018100111104     C                   EVAL      @3 = PCPCA + APCAID
018200111104     C                   EVAL      @3 = CC@(NDX)
018300111104     C                   EVAL      @@GRPCD = %SUBST(@3:1:2)
018400111104     C                   EVAL      @@ACTN  = %SUBST(@3:3:10)
018500111104     **
018600111104     C                   EVAL      @CODES = @@GRPCD
018700111104     C                   EVAL      @PCA = 'PCA'
018800111107      *
018900111104     C     KL#CD         CHAIN     CDEMSTR
019000111104     C                   IF        NOT %FOUND(CDEMSTP)
019100111107     C                   CLEAR                   DS@PCT
019200111104     C                   ENDIF
019300111104     **
019400111104     C     @@ACTN        CHAIN     CARMSTR
019500111104     C                   IF        NOT %FOUND(CARMSTP)
019600111107     C                   CLEAR                   DS@HYC
019700111104     C                   ENDIF
019800111104     **
019900111107     C                   IF        ACTR = 'A'                                   ACTIVE
020000111107     C                   MOVE      #RENEW        #ISO
020100111107     C     *USA          MOVE      #ISO          #RENEW
020200111107     C                   EVAL      @X = %TRIM(@XH) + ',"' +
020300111107     C                             %EDITC(#RENEW:'Y') + '","' +
020400111107     C                             %TRIM(CMNAME) + '","' +
020500111104     C                             %TRIM(CDDESC) + '"'
020600111107     C                   EXCEPT    ACTF
020700111107     C                   ELSE
020800111107     C                   EVAL      @X = %TRIM(@XH) + ',"' +
020900111107     C                             %EDITC(#TER:'Y') + '","' +
021000111107     C                             %TRIM(CMNAME) + '","' +
021100111107     C                             %TRIM(CDDESC) + '"'
021200111107     C                   EXCEPT    TRMF
021300111107     C                   ENDIF
021400111104     **
021500111104     C                   ENDDO
021600111104     **
021700111104     C                   ENDSR
021800111104   S***S
021900111104     C     $GETSNAME     BEGSR
022000111104    ***
022100111104     C                   CLEAR                   A@20             20
022200111104     C                   CLEAR                   A@40             40
022300111104    ***
022400111104     C                   IF        SFNAME <> *BLANKS
022500111104     C                   MOVEL     SFNAME        A@20
022600111104     C                   EXSR      $LDADDR
022700111104     C                   ENDIF
022800111104    ***
022900111104     C                   IF        SMI <> *BLANKS
023000111104     C                   MOVEL     SMI           A@20
023100111104     C                   EXSR      $LDADDR
023200111104     C                   ENDIF
023300111104    ***
023400111104     C                   IF        SLNAME <> *BLANKS
023500111104     C                   MOVEL     SLNAME        A@20
023600111104     C                   EXSR      $LDADDR
023700111104     C                   ENDIF
023800111104    ***
023900111104     C                   ENDSR
024000111104   S***S
024100111104     C     $LDADDR       BEGSR
024200111104    ***
024300111104     C                   EVAL      A@20 = %TRIM(A@20)
024400111104     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
024500111104     C                   CLEAR                   A@20
024600111104    ***
024700111104     C                   ENDSR
024800111104   S***S
024900111104     C     *INZSR        BEGSR
025000111104    ***
025100111104     C     *ENTRY        PLIST
025200111104     C                   PARM                    @FR               8
025300111104     C                   PARM                    @TO               8
025400111104    ***
025500111104     C                   EVAL      #ISO = %DATE
025600111104     C                   EXTRCT    #ISO:*M       #MTH              2 0
025700111104     C                   EXTRCT    #ISO:*Y       #YR               4 0
025800111104     C                   ADDDUR    1:*Y          #ISO
025900111104     C                   EXTRCT    #ISO:*Y       #NXTYR            4 0
026000111104    ***
026100111104     C                   MOVE      @FR           #FR               8 0
026200111104     C                   MOVE      @TO           #TO               8 0
026300111104     C                   MOVE      #FR           ISO#FR
026400111104     C                   MOVE      #TO           ISO#TO
026500111104    ***
026600111104     C     KL#PDC        KLIST
026700111104     C                   KFLD                    APCAID
026800111104     C                   KFLD                    APPRID
026900111104     C                   KFLD                    APMKSZ
027000111104    ***
027100111107     C     KL#CD         KLIST
027200111107     C                   KFLD                    @PCA              3
027300111107     C                   KFLD                    @CODES           10
027400111104    ***
027500111107     C                   EVAL      @X = '"ACCOUNT LISTING BY BROKER THAT ARE ' +
027600111107     C                             'TERMED"'
027700111107     C                   EXCEPT    TRMF
027800111107     C                   EVAL      @X = '"NON-ADMINISTERED BUSINESS"'
027900111107     C                   EXCEPT    TRMF
028000111107     C                   EVAL      @X = ','
028100111107     C                   EXCEPT    TRMF
028200111104    ***
028300111104     C                   EVAL      @X = '"BROKER NAME","ASSIGNED REP","ACCOUN' +
028400111104     C                             'T NAME","EMPLOYEES","GA EFF DATE","' +
028500111104     C                             'GA TERM DATE","CARRIER","PRODUCT TYPE"'
028600111104     C                   EXCEPT    TRMF
028700111107     **
028800111107     C                   EVAL      @X = '"ACCOUNT LISTING BY BROKER THAT ARE ' +
028900111107     C                             'ACTIVE"'
029000111107     C                   EXCEPT    ACTF
029100111107     C                   EVAL      @X = '"NON-ADMINISTERED BUSINESS"'
029200111107     C                   EXCEPT    ACTF
029300111107     C                   EVAL      @X = ','
029400111107     C                   EXCEPT    ACTF
029500111104     **
029600111104     C                   EVAL      @X = '"BROKER NAME","ASSIGNED REP","ACCOUN' +
029700111104     C                             'T NAME","EMPLOYEES","GA EFF DATE","' +
029800111104     C                             'GA RENEWAL DATE","CARRIER","PRODUCT TYPE"'
029900111107     C                   EXCEPT    ACTF
030000111104     **
030100111104     C                   ENDSR
030200111104   S***S
030300111104     ORPP030WF  EADD         TRMF
030400111104     O                       @X             B   300
030500111104     ORPP031WF  EADD         ACTF
030600111104     O                       @X             B   300
