000100121206   X***X INITIAL NOTICE CONTROL FILE AUTO-MAINTENANCE
000200121206   X***X SSK  12/06/2012
000300121206   X***X
000400160310      * 03/10/16 dlk - skip trust 888 also (test trust).
000500180626      * 06/26/18 dlk - update account name every time since it is used in
000600180626      *                letter and must show current account name.
000700210728      * 07/28/21 dlk - fix code that shuts down account without
000800210728      *                reactivating it when needed. Also update cob440w2
000900210728      *                in other cases to fix possible missed update.
001000210728      *
001100121206     FACMUNIQUE IF   E           K DISK
001200121206     FCOB440W2  UF A E           K DISK
001300121206   X***X
001400121206     D @PROC           S             10A
001500121206    ***
001600121206     D KF@TRS          S              3S 0
001700121206     D KF@SUB          S              3S 0
001800121206     D KF@ACC          S              4S 0
001900121206    ***
002000121206     D @TIMESTAMP      DS
002100121206     D  #TSCYMD                1      8S 0
002200121206     D  #TSTIME                9     14S 0
002300121206     D  @TSJOB                15     24
002400121206     D  @TSUSER               25     34
002500121206     D  #TSNBR                35     40S 0
002600121206      *
002700121206     D @TS40           S             40A
002800121206    ***
002900121206   X***X
003000121206     C                   MOVEL(P)  'SET PTR   '  @PROC
003100121206    ***
003200121206     C                   DOU       @PROC = 'LEAVE LOOP'
003300121206     C     @PROC         CASEQ     'SET PTR   '  $ACCMSTR
003400121206     C     @PROC         CASEQ     'READ ACCMS'  $REDACM
003500121206     C     @PROC         CASEQ     'PSN COBW2 '  $COB440
003600121206     C     @PROC         CASEQ     'READ COBW2'  $REDCW2
003700121206     C                   ENDCS
003800121206     C                   ENDDO
003900121206    ***
004000121206     C                   EVAL      *INLR = *ON
004100121206    ***
004200121206   S***S
004300121206     C     $ACCMSTR      BEGSR
004400121206    ***
004500121206     C     KL#TSA        KLIST
004600121206     C                   KFLD                    KF@TRS
004700121206     C                   KFLD                    KF@SUB
004800121206     C                   KFLD                    KF@ACC
004900121206    ***
005000121206     C                   EVAL      KF@TRS = 1
005100121206     C                   EVAL      KF@SUB = 1
005200121206     C                   EVAL      KF@ACC = 1
005300121206    ***
005400121206     C     KL#TSA        SETLL     ACCMSR
005500121206    ***
005600121206     C                   MOVEL(P)  'READ ACCMS'  @PROC
005700121206    ***
005800121206     C                   ENDSR
005900121206   S***S
006000210728    *** AUDIT ACCOUNT MASTER VS CONTROL FILE - ADD NEW ACCOUNTS
006100121206    ***
006200121206     C     $REDACM       BEGSR
006300121206    ***
006400121206     C                   READ      ACCMSR
006500121206    ***
006600121206    *** IF END OF FILE; CHECK THE CONTROL FILE AGAINST ACCOUNT MASTER
006700121206    ***
006800121206     C                   IF        %EOF(ACMUNIQUE)
006900121206     C                   MOVEL(P)  'PSN COBW2 '  @PROC
007000121206     C                   LEAVESR
007100121206     C                   ENDIF
007200121206    ***
007300130506    *** IF ACCOUNT IS TEST; SKIP IT
007400121206    ***
007500160310     C                   IF        ACTRST = 999 or actrst = 888
007600121206     C                   LEAVESR
007700121206     C                   ENDIF
007800121206    ***
007900210728    *** IF ACCOUNT IS CANCELLED OR NOT FULL SERVICE COBRA or not fed acct
008000210728    *** then SKIP IT
008100130506    ***
008200210728     C                   IF        ACOBSRV <> 'F' OR fcstfl <> 'F' or
008300130506     C                             ATRMDT > 0
008400130506     C                   LEAVESR
008500130506     C                   ENDIF
008600130506    ***
008700210728    *** DO WE HAVE IT ON FILE?
008800121206    ***
008900121206     C                   EVAL      KF@TRS = ACTRST
009000121206     C                   EVAL      KF@SUB = ACSUB#
009100121206     C                   EVAL      KF@ACC = ACACCT
009200121206    ***
009300121206     C     KL#TSA        CHAIN(N)  C2F
009400121206    ***
009500121206    *** IF NOT ON CONTROL FILE; ADD IT
009600121206    ***
009700121206     C                   IF        NOT %FOUND(COB440W2)
009800121206    ***
009900121206     C                   EXSR      $TIME
010000121206    ***
010100121206     C                   CLEAR                   C2F
010200121206     C                   EVAL      C2TRST = ACTRST
010300121206     C                   EVAL      C2SUB# = ACSUB#
010400121206     C                   EVAL      C2ACCT = ACACCT
010500121206     C                   EVAL      C2REMK = ACNAM1
010600121206     C                   EVAL      C2PROC = 'Y'
010700121206     C                   EVAL      C2EUSER = 'QPGMR'
010800121206     C                   EVAL      C2ETIME = #TSTIME
010900210728     C                   EVAL      C2EDATE = #TSCYMD
011000121206     C                   EVAL      C2START = #TSCYMD
011100210728     C                   EVAL      C2ENDDT = *zeros
011200121206     C                   WRITE     C2F
011300121206    ***
011400121206     C                   ENDIF
011500121206    ***
011600121206     C                   ENDSR
011700210728
011800210728   S*********************************************************************
011900210728   S*** set limits on COB440W2...thats all it does
012000210728   S*********************************************************************
012100210728   S***
012200121206     C     $COB440       BEGSR
012300121206    ***
012400121206     C                   EVAL      KF@TRS = 1
012500121206     C                   EVAL      KF@SUB = 1
012600121206     C                   EVAL      KF@ACC = 1
012700121206    ***
012800121206     C     KL#TSA        SETLL     C2F
012900121206    ***
013000121206     C                   MOVEL(P)  'READ COBW2'  @PROC
013100121206    ***
013200121206     C                   ENDSR
013300121206   S***S
013400210728   S*********************************************************************
013500210728   S*** read COB440W2 and update records that changed since last run
013600210728   S*********************************************************************
013700210728   S***
013800121206     C     $REDCW2       BEGSR
013900121206    ***
014000121206     C                   READ      C2F
014100121206    ***
014200121206     C                   IF        %EOF(COB440W2)
014300121206     C                   MOVEL(P)  'LEAVE LOOP'  @PROC
014400121206     C                   LEAVESR
014500121206     C                   ENDIF
014600121206    ***
014700121206     C                   EVAL      KF@TRS = C2TRST
014800121206     C                   EVAL      KF@SUB = C2SUB#
014900121206     C                   EVAL      KF@ACC = C2ACCT
015000130506    ***
015100130506    *** IF ACCOUNT IS TEST; SKIP IT
015200130506    ***
015300130506     C                   IF        C2TRST = 999
015400130506     C                   LEAVESR
015500130506     C                   ENDIF
015600121206    ***
015700121206    *** IF ACCOUNT MASTER NOT FOUND AND PROCESS STILL YES; SHUT IT DOWN
015800121206    ***
015900121206     C     KL#TSA        CHAIN     ACCMSR
016000121206     C                   IF        NOT %FOUND(ACMUNIQUE)
016100210728     C                   IF        C2PROC <> 'N' or c2enddt = 0
016200121206     C                   EVAL      C2PROC = 'N'
016300121206     C                   EXSR      $TIME
016400121206     C                   EVAL      C2CUSER = 'QPGMR'
016500121206     C                   EVAL      C2CTIME = #TSTIME
016600121206     C                   EVAL      C2CDATE = #TSCYMD
016700121206     C                   EVAL      C2ENDDT = #TSCYMD
016800121206     C                   UPDATE    C2F
016900121206     C                   ENDIF
017000121206     C                   LEAVESR
017100121206     C                   ENDIF
017200121206    ***
017300121206    *** IF ACCOUNT MASTER FOUND PROCESSING BELOW
017400210728    ***
017500210728    *** IF PROCESS IS CURRENTLY SHUTDOWN
017600210728     C                   IF        C2PROC = 'N' or c2enddt <> 0
017700210728    *** REACTIVATE IF ITS STILL GOOD
017800130419     C                   IF        ATRMDT = 0 AND
017900130419     C                             ACOBSRV = 'F' AND FCSTFL = 'F'
018000210728    *** reactivate acct
018100130419     C                   EVAL      C2PROC = 'Y'
018200180626     C                   EVAL      C2REMK = ACNAM1
018300130419     C                   EXSR      $TIME
018400130419     C                   EVAL      C2CUSER = 'QPGMR'
018500130419     C                   EVAL      C2CTIME = #TSTIME
018600130419     C                   EVAL      C2CDATE = #TSCYMD
018700210728     C                   EVAL      C2ENDDT = *zeros
018800130419     C                   UPDATE    C2F
018900130419     C                   ENDIF
019000130419     C                   LEAVESR
019100130419     C                   ENDIF
019200121206    ***
019300210728    *** IF PROCESS IS CURRENTLY ACTIVE
019400121206    ***
019500210728    *** IF ACCOUNT'S COBRA IS FED FULL SERVICE AND ACCOUNT IS ACTIVE
019600210728    *** update it
019700121206    ***
019800130419     C                   IF        ACOBSRV = 'F' AND FCSTFL = 'F' AND
019900121206     C                             ATRMDT = 0
020000210728     C                   EVAL      C2PROC = 'Y'
020100180626     C                   EVAL      C2REMK = ACNAM1
020200210728     C                   EVAL      C2ENDDT = *zeros
020300210728     C                   EXSR      $TIME
020400210728     C                   EVAL      C2CUSER = 'QPGMR'
020500210728     C                   EVAL      C2CTIME = #TSTIME
020600210728     C                   EVAL      C2CDATE = #TSCYMD
020700180626     C                   UPDATE    C2F
020800121206     C                   LEAVESR
020900121206     C                   ENDIF
021000121206    ***
021100130419    *** IF ACCOUNT'S COBRA IS NO LONGER FULL SERVICE OR ACCOUNT IS NOT ACTIVE
021200210728    ***    OR ACCOUNT WENT TO STATE COBRA OR NO COBRA THEN  SHUT IT DOWN
021300180626    *** also update account name
021400121206    ***
021500121206     C                   EXSR      $TIME
021600121206     C                   EVAL      C2CUSER = 'QPGMR'
021700121206     C                   EVAL      C2CTIME = #TSTIME
021800121206     C                   EVAL      C2CDATE = #TSCYMD
021900121206     C                   EVAL      C2PROC = 'N'
022000180626     C                   EVAL      C2REMK = ACNAM1
022100121206    ***
022200210728    *** IF THE ACCOUNT IS ACTIVE, USE TODAYS DATE AS END DATE OF SERVICE
022300121206    *** IF THE ACCOUNT TERMED, USE TERM DATE FOR END DATE OF SERVICE;
022400121206    ***
022500121206     C                   IF        ATRMDT = 0
022600121206     C                   EVAL      C2ENDDT = #TSCYMD
022700121206     C                   ELSE
022800121206     C                   EVAL      C2ENDDT = ATRMDT
022900121206     C                   ENDIF
023000121206    ***
023100121206     C                   UPDATE    C2F
023200121206    ***
023300121206     C                   ENDSR
023400121206   S***S
023500121206     C     $TIME         BEGSR
023600121206    ***
023700121206     c                   clear                   @timestamp
023800121206     C                   MOVE      *BLANKS       @TS40
023900121206     C                   CALL      'TIMESTMP'
024000121206     C                   PARM                    @TS40
024100121206     C                   MOVEL     @TS40         @TIMESTAMP
024200121206    ***
024300121206     C                   ENDSR
024400121206   S***S
