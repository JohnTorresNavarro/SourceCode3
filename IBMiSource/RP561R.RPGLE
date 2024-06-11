000100090819     **** RP56* ACCOUNT MEDICAL REPORTING
000200090819     ****
000300090819     **** STEPHEN KING
000400090819     ****
000500090819     **** INITIAL PARAMETERS SCREEN
000600090819     ****
000700090819     FRP560D    CF   E             WORKSTN INFDS(WSDS)
000800090819     FACCMST    IF   E           K DISK
000900090819     FRP560WF   O  A E             DISK
001000090819    ***
001100090819     D WSDS            DS
001200090819     D  FKEY                 369    369A
001300090819    ***       FUNCTION KEYS
001400090819     D  F1             C                   CONST(X'31')
001500090819     D  F2             C                   CONST(X'32')
001600090819     D  F3             C                   CONST(X'33')
001700090819     D  F4             C                   CONST(X'34')
001800090819     D  F5             C                   CONST(X'35')
001900090819     D  F6             C                   CONST(X'36')
002000090819     D  F7             C                   CONST(X'37')
002100090819     D  F8             C                   CONST(X'38')
002200090819     D  F9             C                   CONST(X'39')
002300090819     D  F10            C                   CONST(X'3A')
002400090819     D  F11            C                   CONST(X'3B')
002500090819     D  F12            C                   CONST(X'3C')
002600090819     D  F13            C                   CONST(X'B1')
002700090819     D  F14            C                   CONST(X'B2')
002800090819     D  F15            C                   CONST(X'B3')
002900090819     D  F16            C                   CONST(X'B4')
003000090819     D  F17            C                   CONST(X'B5')
003100090819     D  F18            C                   CONST(X'B6')
003200090819     D  F19            C                   CONST(X'B7')
003300090819     D  F20            C                   CONST(X'B8')
003400090819     D  F21            C                   CONST(X'B9')
003500090819     D  F22            C                   CONST(X'BA')
003600090819     D  F23            C                   CONST(X'BB')
003700090819     D  F24            C                   CONST(X'BC')
003800090819    ***
003900090819     D #T              S              3S 0
004000090819     D #S              S              3S 0
004100090819     D #A              S              4S 0
004200090819     D #C              S              1S 0
004300090819     D @N1             S             40A
004400090819     D @N2             S             40A
004500090819     D @PREFIX         S             10A
004600090819     D @STEP           S              5A
004700090819     D @EMSG           S                   LIKE(EMSG)
004800090819    ***
004900090819     C                   EVAL      @STEP = 'STEP0'
005000090819    ***
005100090819     C                   DOU       @STEP = 'LEAVE'
005200090819     C     @STEP         CASEQ     'STEP0'       $STEP0
005300090819     C     @STEP         CASEQ     'STEP1'       $STEP1
005400090819     C     @STEP         CASEQ     'STEP2'       $STEP2
005500090819     C                   ENDCS
005600090819     C                   ENDDO
005700090819    ***
005800090819     C                   EVAL      *INLR = *ON
005900090819     C                   RETURN
006000090819   S***S
006100090819     C     *INZSR        BEGSR
006200090819    ***
006300090819     C     KL1           KLIST
006400090819     C                   KFLD                    #T
006500090819     C                   KFLD                    #S
006600090819     C                   KFLD                    #A
006700090819    ***
006800090819     C                   ENDSR
006900090819   S***S
007000090819     C     $STEP0        BEGSR
007100090819    ***
007200090819     C                   EVAL      @EMSG = 'TYPE ACCOUNTS, PRESS ENTER FOR TE' +
007300090819     C                             'XT, SELECT 1 OR 2, THEN PRESS ENTER.'
007400090819    ***
007500090819     C                   CLEAR                   ENTFMT
007600090819     C                   EVAL      *IN25 = *OFF
007700090819     C                   EVAL      *IN26 = *OFF
007800090819     C                   MOVE      'STEP1'       @STEP
007900090819    ***
008000090819     C                   ENDSR
008100090819   S***S
008200090819     C     $STEP1        BEGSR
008300090819    ***
008400090819     C                   EVAL      EMSG = %TRIM(@EMSG)
008500090819     C                   EXFMT     ENTFMT
008600090819     C                   EVAL      @EMSG = *BLANKS
008700090819    ***
008800090819     C                   IF        FKEY = F3
008900090819     C                   EVAL      @STEP = 'LEAVE'
009000090819     C                   LEAVESR
009100090819     C                   ENDIF
009200090819    ***
009300090819     C                   IF        FKEY = F12
009400090819     C                   EVAL      *IN25 = *OFF
009500090819     C                   EVAL      *IN26 = *OFF
009600090819     C                   LEAVESR
009700090819     C                   ENDIF
009800090819    ***
009900090819     C                   IF        FKEY = F10
010000090819     C                   EXSR      $VALIDATE
010100090819     C                   IF        @EMSG <> *BLANKS
010200090819     C                   LEAVESR
010300090819     C                   ENDIF
010400090819     C                   EVAL      @STEP = 'STEP2'
010500090819     C                   LEAVESR
010600090819     C                   ENDIF
010700090819    ***
010800090819     C                   EXSR      $VALIDATE
010900090819     C                   IF        @EMSG <> *BLANKS
011000090819     C                   LEAVESR
011100090819     C                   ENDIF
011200090819    ***
011300090819     C                   IF        *IN26 = *OFF
011400090819     C                   EVAL      *IN25 = *ON
011500090819     C                   EVAL      *IN26 = *ON
011600090819     C                   ENDIF
011700090819    ***
011800090819     C                   ENDSR
011900090819   S***S
012000090819     C     $VALIDATE     BEGSR
012100090819    ***
012200090819     C                   EVAL      #T = R1TRS
012300090819     C                   EVAL      #S = R1SUB
012400090819     C                   EVAL      #A = R1ACC
012500090819     C                   EVAL      #C = R1CHC
012600090819     C                   MOVEL(P)  'ROW 1:'      @PREFIX
012700090819     C                   EXSR      $CHK
012800090819     C                   EVAL      R1AN1 = @N1
012900090819     C                   EVAL      R1AN2 = @N2
013000090819     C                   IF        @EMSG <> *BLANKS
013100090819     C                   LEAVESR
013200090819     C                   ENDIF
013300090819    ***
013400090819     C                   EVAL      #T = R2TRS
013500090819     C                   EVAL      #S = R2SUB
013600090819     C                   EVAL      #A = R2ACC
013700090819     C                   EVAL      #C = R2CHC
013800090819     C                   MOVEL(P)  'ROW 2:'      @PREFIX
013900090819     C                   EXSR      $CHK
014000090819     C                   EVAL      R2AN1 = @N1
014100090819     C                   EVAL      R2AN2 = @N2
014200090819     C                   IF        @EMSG <> *BLANKS
014300090819     C                   LEAVESR
014400090819     C                   ENDIF
014500090819    ***
014600090819     C                   EVAL      #T = R3TRS
014700090819     C                   EVAL      #S = R3SUB
014800090819     C                   EVAL      #A = R3ACC
014900090819     C                   EVAL      #C = R3CHC
015000090819     C                   MOVEL(P)  'ROW 3:'      @PREFIX
015100090819     C                   EXSR      $CHK
015200090819     C                   EVAL      R3AN1 = @N1
015300090819     C                   EVAL      R3AN2 = @N2
015400090819     C                   IF        @EMSG <> *BLANKS
015500090819     C                   LEAVESR
015600090819     C                   ENDIF
015700090819    ***
015800090819     C                   EVAL      #T = R4TRS
015900090819     C                   EVAL      #S = R4SUB
016000090819     C                   EVAL      #A = R4ACC
016100090819     C                   EVAL      #C = R4CHC
016200090819     C                   MOVEL(P)  'ROW 4:'      @PREFIX
016300090819     C                   EXSR      $CHK
016400090819     C                   EVAL      R4AN1 = @N1
016500090819     C                   EVAL      R4AN2 = @N2
016600090819     C                   IF        @EMSG <> *BLANKS
016700090819     C                   LEAVESR
016800090819     C                   ENDIF
016900090819    ***
017000090819     C                   EVAL      #T = R5TRS
017100090819     C                   EVAL      #S = R5SUB
017200090819     C                   EVAL      #A = R5ACC
017300090819     C                   EVAL      #C = R5CHC
017400090819     C                   MOVEL(P)  'ROW 5:'      @PREFIX
017500090819     C                   EXSR      $CHK
017600090819     C                   EVAL      R5AN1 = @N1
017700090819     C                   EVAL      R5AN2 = @N2
017800090819     C                   IF        @EMSG <> *BLANKS
017900090819     C                   LEAVESR
018000090819     C                   ENDIF
018100090819    ***
018200090819     C                   EVAL      #T = R6TRS
018300090819     C                   EVAL      #S = R6SUB
018400090819     C                   EVAL      #A = R6ACC
018500090819     C                   EVAL      #C = R6CHC
018600090819     C                   MOVEL(P)  'ROW 6:'      @PREFIX
018700090819     C                   EXSR      $CHK
018800090819     C                   EVAL      R6AN1 = @N1
018900090819     C                   EVAL      R6AN2 = @N2
019000090819     C                   IF        @EMSG <> *BLANKS
019100090819     C                   LEAVESR
019200090819     C                   ENDIF
019300090819    ***
019400090819     C                   EVAL      #T = R7TRS
019500090819     C                   EVAL      #S = R7SUB
019600090819     C                   EVAL      #A = R7ACC
019700090819     C                   EVAL      #C = R7CHC
019800090819     C                   MOVEL(P)  'ROW 7:'      @PREFIX
019900090819     C                   EXSR      $CHK
020000090819     C                   EVAL      R7AN1 = @N1
020100090819     C                   EVAL      R7AN2 = @N2
020200090819     C                   IF        @EMSG <> *BLANKS
020300090819     C                   LEAVESR
020400090819     C                   ENDIF
020500090819    ***
020600090819     C                   EVAL      #T = R8TRS
020700090819     C                   EVAL      #S = R8SUB
020800090819     C                   EVAL      #A = R8ACC
020900090819     C                   EVAL      #C = R8CHC
021000090819     C                   MOVEL(P)  'ROW 8:'      @PREFIX
021100090819     C                   EXSR      $CHK
021200090819     C                   EVAL      R8AN1 = @N1
021300090819     C                   EVAL      R8AN2 = @N2
021400090819     C                   IF        @EMSG <> *BLANKS
021500090819     C                   LEAVESR
021600090819     C                   ENDIF
021700090819    ***
021800090819     C                   EVAL      #T = R9TRS
021900090819     C                   EVAL      #S = R9SUB
022000090819     C                   EVAL      #A = R9ACC
022100090819     C                   EVAL      #C = R9CHC
022200090819     C                   MOVEL(P)  'ROW 9:'      @PREFIX
022300090819     C                   EXSR      $CHK
022400090819     C                   EVAL      R9AN1 = @N1
022500090819     C                   EVAL      R9AN2 = @N2
022600090819     C                   IF        @EMSG <> *BLANKS
022700090819     C                   LEAVESR
022800090819     C                   ENDIF
022900090819    ***
023000090819     C                   EVAL      #T = RATRS
023100090819     C                   EVAL      #S = RASUB
023200090819     C                   EVAL      #A = RAACC
023300090819     C                   EVAL      #C = RACHC
023400090819     C                   MOVEL(P)  'ROW 10:'     @PREFIX
023500090819     C                   EXSR      $CHK
023600090819     C                   EVAL      RAAN1 = @N1
023700090819     C                   EVAL      RAAN2 = @N2
023800090819     C                   IF        @EMSG <> *BLANKS
023900090819     C                   LEAVESR
024000090819     C                   ENDIF
024100090819    ***
024200090819     C                   IF        R1TRS = 0 AND R2TRS = 0 AND R3TRS = 0 AND
024300090819     C                             R4TRS = 0 AND R5TRS = 0 AND R6TRS = 0 AND
024400090819     C                             R7TRS = 0 AND R8TRS = 0 AND R9TRS = 0 AND
024500090819     C                             RATRS = 0
024600090819     C                   EVAL      @EMSG = 'SELECT AT LEAST ONE ACCOUNT'
024700090819     C                   LEAVESR
024800090819     C                   ENDIF
024900090819    ***
025000090819     C                   ENDSR
025100090819   S***S
025200090819     C     $CHK          BEGSR
025300090819    ***
025400090819     C                   EVAL      @N1 = *BLANKS
025500090819     C                   EVAL      @N2 = *BLANKS
025600090819    ***
025700090819     C                   IF        (#T =  0 AND #S =  0 AND #A <> 0) OR
025800090819     C                             (#T =  0 AND #S <> 0 AND #A =  0) OR
025900090819     C                             (#T =  0 AND #S <> 0 AND #A <> 0) OR
026000090819     C                             (#T <> 0 AND #S =  0 AND #A =  0) OR
026100090819     C                             (#T <> 0 AND #S =  0 AND #A <> 0) OR
026200090819     C                             (#T <> 0 AND #S <> 0 AND #A =  0)
026300090819     C                   EVAL      @EMSG = %TRIM(@PREFIX) + ' ' +
026400090819     C                             'INVALID ACCOUNT; MISSING PART.'
026500090819     C                   LEAVESR
026600090819     C                   ENDIF
026700090819    ***
026800090819     C                   IF        #T <> 0 AND #S <> 0 AND #A <> 0
026900090819     C     KL1           CHAIN     ACCMSR
027000090819     C                   IF        NOT %FOUND(ACCMST)
027100090819     C                   EVAL      @EMSG = %TRIM(@PREFIX) + ' ' +
027200090819     C                             'ACCOUNT NOT FOUND; RE-ENTER.'
027300090819     C                   LEAVESR
027400090819     C                   ENDIF
027500090819     C                   EVAL      @N1 = %TRIM(ACNAM1)
027600090819     C                   EVAL      @N2 = %TRIM(ACNAM2)
027700090819     C                   ENDIF
027800090819    ***
027900090819     C                   IF        #T <> 0 AND #S <> 0 AND #A <> 0 AND
028000090819     C                             #C <> 1 AND #C <> 2
028100090819     C                   EVAL      @EMSG = %TRIM(@PREFIX) + ' ' +
028200090819     C                             'INVALID ACCT NAME SELECTION.'
028300090819     C                   LEAVESR
028400090819     C                   ENDIF
028500090819    ***
028600090819     C                   ENDSR
028700090819   S***S
028800090819     C     $STEP2        BEGSR
028900090819    ***
029000090819     C                   IF        R1TRS <> 0
029100090819     C                   EVAL      RDTRST = R1TRS
029200090819     C                   EVAL      RDSUB# = R1SUB
029300090819     C                   EVAL      RDACCT = R1ACC
029400090819     C                   IF        R1CHC = 1
029500090819     C                   EVAL      RDNAME = R1AN1
029600090819     C                   ELSE
029700090819     C                   EVAL      RDNAME = R1AN2
029800090819     C                   ENDIF
029900090819     C                   WRITE     RPDF
030000090819     C                   ENDIF
030100090819    ***
030200090819     C                   IF        R2TRS <> 0
030300090819     C                   EVAL      RDTRST = R2TRS
030400090819     C                   EVAL      RDSUB# = R2SUB
030500090819     C                   EVAL      RDACCT = R2ACC
030600090819     C                   IF        R2CHC = 1
030700090819     C                   EVAL      RDNAME = R2AN1
030800090819     C                   ELSE
030900090819     C                   EVAL      RDNAME = R2AN2
031000090819     C                   ENDIF
031100090819     C                   WRITE     RPDF
031200090819     C                   ENDIF
031300090819    ***
031400090819     C                   IF        R3TRS <> 0
031500090819     C                   EVAL      RDTRST = R3TRS
031600090819     C                   EVAL      RDSUB# = R3SUB
031700090819     C                   EVAL      RDACCT = R3ACC
031800090819     C                   IF        R3CHC = 1
031900090819     C                   EVAL      RDNAME = R3AN1
032000090819     C                   ELSE
032100090819     C                   EVAL      RDNAME = R3AN2
032200090819     C                   ENDIF
032300090819     C                   WRITE     RPDF
032400090819     C                   ENDIF
032500090819    ***
032600090819     C                   IF        R4TRS <> 0
032700090819     C                   EVAL      RDTRST = R4TRS
032800090819     C                   EVAL      RDSUB# = R4SUB
032900090819     C                   EVAL      RDACCT = R4ACC
033000090819     C                   IF        R4CHC = 1
033100090819     C                   EVAL      RDNAME = R4AN1
033200090819     C                   ELSE
033300090819     C                   EVAL      RDNAME = R4AN2
033400090819     C                   ENDIF
033500090819     C                   WRITE     RPDF
033600090819     C                   ENDIF
033700090819    ***
033800090819     C                   IF        R5TRS <> 0
033900090819     C                   EVAL      RDTRST = R5TRS
034000090819     C                   EVAL      RDSUB# = R5SUB
034100090819     C                   EVAL      RDACCT = R5ACC
034200090819     C                   IF        R5CHC = 1
034300090819     C                   EVAL      RDNAME = R5AN1
034400090819     C                   ELSE
034500090819     C                   EVAL      RDNAME = R5AN2
034600090819     C                   ENDIF
034700090819     C                   WRITE     RPDF
034800090819     C                   ENDIF
034900090819    ***
035000090819     C                   IF        R6TRS <> 0
035100090819     C                   EVAL      RDTRST = R6TRS
035200090819     C                   EVAL      RDSUB# = R6SUB
035300090819     C                   EVAL      RDACCT = R6ACC
035400090819     C                   IF        R6CHC = 1
035500090819     C                   EVAL      RDNAME = R6AN1
035600090819     C                   ELSE
035700090819     C                   EVAL      RDNAME = R6AN2
035800090819     C                   ENDIF
035900090819     C                   WRITE     RPDF
036000090819     C                   ENDIF
036100090819    ***
036200090819     C                   IF        R7TRS <> 0
036300090819     C                   EVAL      RDTRST = R7TRS
036400090819     C                   EVAL      RDSUB# = R7SUB
036500090819     C                   EVAL      RDACCT = R7ACC
036600090819     C                   IF        R7CHC = 1
036700090819     C                   EVAL      RDNAME = R7AN1
036800090819     C                   ELSE
036900090819     C                   EVAL      RDNAME = R7AN2
037000090819     C                   ENDIF
037100090819     C                   WRITE     RPDF
037200090819     C                   ENDIF
037300090819    ***
037400090819     C                   IF        R8TRS <> 0
037500090819     C                   EVAL      RDTRST = R8TRS
037600090819     C                   EVAL      RDSUB# = R8SUB
037700090819     C                   EVAL      RDACCT = R8ACC
037800090819     C                   IF        R8CHC = 1
037900090819     C                   EVAL      RDNAME = R8AN1
038000090819     C                   ELSE
038100090819     C                   EVAL      RDNAME = R8AN2
038200090819     C                   ENDIF
038300090819     C                   WRITE     RPDF
038400090819     C                   ENDIF
038500090819    ***
038600090819     C                   IF        R9TRS <> 0
038700090819     C                   EVAL      RDTRST = R9TRS
038800090819     C                   EVAL      RDSUB# = R9SUB
038900090819     C                   EVAL      RDACCT = R9ACC
039000090819     C                   IF        R9CHC = 1
039100090819     C                   EVAL      RDNAME = R9AN1
039200090819     C                   ELSE
039300090819     C                   EVAL      RDNAME = R9AN2
039400090819     C                   ENDIF
039500090819     C                   WRITE     RPDF
039600090819     C                   ENDIF
039700090819    ***
039800090819     C                   IF        RATRS <> 0
039900090819     C                   EVAL      RDTRST = RATRS
040000090819     C                   EVAL      RDSUB# = RASUB
040100090819     C                   EVAL      RDACCT = RAACC
040200090819     C                   IF        RACHC = 1
040300090819     C                   EVAL      RDNAME = RAAN1
040400090819     C                   ELSE
040500090819     C                   EVAL      RDNAME = RAAN2
040600090819     C                   ENDIF
040700090819     C                   WRITE     RPDF
040800090819     C                   ENDIF
040900090819    ***
041000090819     C                   EVAL      @STEP = 'LEAVE'
041100090819    ***
041200090819     C                   ENDSR
041300090819   S***S
