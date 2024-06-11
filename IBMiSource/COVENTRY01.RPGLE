000100060516     *** COVENTRY AUDIT PROGRAM
000200060516     FCOVENTRY01CF   E             WORKSTN INFDS(WSDS)
000300060516     FCOVENTRY02UF A E           K DISK
000400060516     fPLNMSTN1  IF   e           K disk
000500060516     fMCOVXX    if   e           k disk
000600060511     fmktcara1  if   e           k disk
000700060516     FT2000     O  A F 2000        DISK
000800060515   X***X
000900060516     D WSDS            DS
001000060516     D  FKEY                 369    369A
001100060516     **
001200060516     D  F1             C                   CONST(X'31')
001300060516     D  F2             C                   CONST(X'32')
001400060516     D  F3             C                   CONST(X'33')
001500060516     D  F4             C                   CONST(X'34')
001600060516     D  F5             C                   CONST(X'35')
001700060516     D  F6             C                   CONST(X'36')
001800060516     D  F7             C                   CONST(X'37')
001900060516     D  F8             C                   CONST(X'38')
002000060516     D  F9             C                   CONST(X'39')
002100060516     D  F10            C                   CONST(X'3A')
002200060516     D  F11            C                   CONST(X'3B')
002300060516     D  F12            C                   CONST(X'3C')
002400060516     D  F13            C                   CONST(X'B1')
002500060516     D  F14            C                   CONST(X'B2')
002600060516     D  F15            C                   CONST(X'B3')
002700060516     D  F16            C                   CONST(X'B4')
002800060516     D  F17            C                   CONST(X'B5')
002900060516     D  F18            C                   CONST(X'B6')
003000060516     D  F19            C                   CONST(X'B7')
003100060516     D  F20            C                   CONST(X'B8')
003200060516     D  F21            C                   CONST(X'B9')
003300060516     D  F22            C                   CONST(X'BA')
003400060516     D  F23            C                   CONST(X'BB')
003500060516     D  F24            C                   CONST(X'BC')
003600060516     D  ROLLDOWN       C                   CONST(X'F4')
003700060516     D  ROLLUP         C                   CONST(X'F5')
003800060516     **
003900060515     D MCM@          E DS                  EXTNAME(MCOV)
004000060515     D MKM@          E DS                  EXTNAME(MKTCARA0)
004100060516     D #ISO            S               D   DATFMT(*ISO)
004200060517     D #CISO           S               D   DATFMT(*ISO)
004300060517     D #ISX            S              8S 0
004400060517     D #USX            S              8S 0
004500060517     D #USA            S               D   DATFMT(*USA)
004600060517     D @EMSG           S             70A
004700060511     d @s              s              1a
004800060515     d @X              S           2000A
004900060515   X***X
005000060515     c                   eval      @s = '0'
005100060517     C                   EVAL      @X = *BLANKS
005200060515     **
005300060511     c                   dou       @s = 'X'
005400060515     c     @s            caseq     '0'           $P1
005500060511     c     @s            caseq     '1'           $s1
005600060511     c     @s            caseq     '2'           $s2
005700060511     c     @s            caseq     '3'           $s3
005800060511     c     @s            caseq     '4'           $s4
005900060511     c     @s            caseq     '5'           $s5
006000060515     c     @s            caseq     '6'           $s6
006100060517     c     @s            caseq     '7'           $s7
006200060517     c     @s            caseq     '8'           $s8
006300060511     c                   endcs
006400060511     c                   enddo
006500060516     C                   EVAL      *INLR = *ON
006600060515   S***S
006700060515     c     $P1           begsr
006800060516     **
006900060516     C                   EVAL      @X = *BLANKS
007000060515     c                   eval      @s = '1'
007100060516     C                   CLEAR                   SCREEN1
007200060516     **
007300060516     C                   MOVE      *DATE         #ISO
007400060516     C                   ADDDUR    1:*M          #ISO
007500060516     C                   EXSR      $DTE_RTN
007600060516     C                   EVAL      DATEAUDIT = #USX
007700060516     C                   EVAL      #BINGO = 0
007800060516     **
007900060516     c                   endsr
008000060516   S***S
008100060516     c     $DTE_RTN      begsr
008200060516     **
008300060516     C                   EXTRCT(E) #ISO:*M       #MTH              2 0
008400060516     C                   EXTRCT(E) #ISO:*Y       #YR               4 0
008500060516     C                   EVAL      #USX = (#MTH * 1000000) + 10000 + #YR
008600060516     C                   EVAL      #ISX = (#YR * 10000) + (#MTH * 100) + 1
008700060516     **
008800060515     c                   endsr
008900060515   S***S
009000060515     c     $s1           begsr
009100060516     **
009200060516     C                   EVAL      EMSG = @EMSG
009300060516     **
009400060516     C                   EXFMT     SCREEN1
009500060516     **
009600060516     C                   MOVE      *BLANKS       @EMSG
009700060516     **
009800060516     C                   IF        FKEY = F3
009900060516     C                   EVAL      @S = 'X'
010000060516     C                   LEAVESR
010100060516     C                   ENDIF
010200060515     **
010300060516     C     *USA          TEST(DE)                DATEAUDIT
010400060516     C                   IF        %ERROR
010500060516     C                   EVAL      @EMSG = 'INVALID DATE'
010600060517     C                   EVAL      #BINGO = 0
010700060516     C                   LEAVESR
010800060516     C                   ENDIF
010900060516     C                   MOVE      DATEAUDIT     #USA
011000060516     C                   MOVE      #USA          #ISO
011100060516     **
011200060516     C                   IF        #BINGO = 0
011300060516     C                   MOVE      #ISO          #CISO
011400060516     C                   ADD       1             #BINGO            1 0
011500060516     C                   EVAL      @EMSG = 'PRESS ENTER TO RUN WITH DATE ON S' +
011600060516     C                             'CREEN.'
011700060516     C                   LEAVESR
011800060516     C                   ENDIF
011900060516     **
012000060516     C                   IF        #ISO <> #CISO
012100060516     C                   EVAL      @EMSG = 'PRESS ENTER TO RUN WITH DATE ON S' +
012200060516     C                             'CREEN.'
012300060516     C                   LEAVESR
012400060516     C                   ENDIF
012500060516     **
012600060511     c                   eval      @s = '2'
012700060515     **
012800060511     c                   endsr
012900060515   S***S
013000060511     c     $s2           begsr
013100060515     **
013200060516     C                   EXSR      $DTE_RTN
013300060516     C                   MOVE      #ISX          #RUNDTE           8 0
013400060516     **
013500060516     C                   MOVE      'COV'         CAR#KEY           3
013600060516     C     CAR#KEY       SETLL     PLNMSR
013700060516     **
013800060516     c                   eval      @s = '3'
013900060515     **
014000060511     c                   endsr
014100060515   S***S
014200060511     c     $s3           begsr
014300060515     **
014400060516     c     CAR#KEY       reade     PLNMSR
014500060515     **
014600060516     c                   IF        %eof(PLNMSTN1)
014700060517     c                   eval      @s = '6'
014800060515     c                   leavesr
014900060515     c                   endif
015000060515     **
015100060516     c     kl2           klist
015200060516     c                   kfld                    pltrst
015300060516     c                   kfld                    plsub#
015400060516     c                   kfld                    plplan
015500060516     **
015600060516     c     kl2           setll     mcovr
015700060516     c                   if        not %equal(MCOVXX)
015800060516     c                   leavesr
015900060516     C                   ELSE
016000060516     C                   EVAL      @S = '4'
016100060516     c                   endif
016200060515     **
016300060511     c                   endsr
016400060515   S***S
016500060511     c     $s4           begsr
016600060515     **
016700060516     c     kl2           READE     mcovr
016800060516     **
016900060516     c                   IF        %eof(MCOVXX)
017000060516     c                   eval      @s = '3'
017100060516     c                   leavesr
017200060516     c                   endif
017300060516     **
017400060516     c                   IF        CANDT = ENRLDT OR
017500060516     c                             (CANDT <= #RUNDTE AND CANDT <> 0) OR
017600060516     c                             ENRLDT > #RUNDTE
017700060516     c                   leavesr
017800060516     c                   endif
017900060516     **
018000060516     C                   EVAL      @S = '5'
018100060516     **
018200060516     c                   endsr
018300060516   S***S
018400060516     c     $s5           begsr
018500060516     **
018600060511     c     kl3           klist
018700060511     c                   kfld                    mctrst
018800060511     c                   kfld                    mcsub#
018900060511     c                   kfld                    acc#
019000060516     **
019100060516     c     kl3           chain     COVF
019200060516     C                   IF        %FOUND(COVENTRY02)
019300060516     C                   ADD       1             CVCOUNT
019400060517     C                   UPDATE    COVF
019500060517     C                   ELSE
019600060517     C                   EVAL      CVTRST = MCTRST
019700060517     C                   EVAL      CVSUB# = MCSUB#
019800060517     C                   EVAL      CVACCT = ACC#
019900060517     C                   Z-ADD     1             CVCOUNT
020000060517     C                   WRITE     COVF
020100060517     C                   ENDIF
020200060517     **
020300060517     C                   EVAL      @S = '4'
020400060517     **
020500060517     c                   endsr
020600060517   S***S
020700060517     c     $s6           begsr
020800060517     **
020900060517     C                   EVAL      @X = '"COVENTRY MARKET SIZE AUDIT"'
021000060517     C                   EXCEPT    OUTF
021100060517     C                   EVAL      @X = ','
021200060517     C                   EXCEPT    OUTF
021300060517     C                   EVAL      @X = '"TRUST","SUBDIVISION","ACCOUNT","CUR' +
021400060524     C                             'RENT MARKET SIZE","NO. OF CONTRACTS","COM' +
021500060524     C                             'MISSION CONTROL DATE"'
021600060517     C                   EXCEPT    OUTF
021700060517     **
021800060517     C                   MOVE      *ZEROS        #K3               3 0
021900060517     **
022000060517     C     #K3           SETLL     COVF
022100060517     **
022200060517     C                   EVAL      @S = '7'
022300060517     **
022400060517     c                   endsr
022500060517   S***S
022600060517     c     $s7           begsr
022700060517     **
022800060517     C                   READ      COVF
022900060517     **
023000060517     C                   IF        %EOF(COVENTRY02)
023100060517     C                   EVAL      @S = 'X'
023200060517     C                   LEAVESR
023300060517     C                   ENDIF
023400060517     **
023500060517     c     kl4           klist
023600060517     c                   kfld                    CVtrst
023700060517     c                   kfld                    CVsub#
023800060517     c                   kfld                    CVacct
023900060517     c                   kfld                    CAR#KEY
024000060517     **
024100060517     c                   eval      @s = '8'
024200060517     c     kl4           chain     rmktcara
024300060517     **
024400060517     c                   if        not %found(mktcara1)
024500060517     c                   eval      maszcd = '50 '
024600060517     c                   leavesr
024700060517     C                   ENDIF
024800060517     **
024900060517     c     kl4           setll     rmktcara
025000060517     c                   dou       %eof(mktcara1)
025100060517     c     kl4           reade     rmktcara
025200060517     c                   if        not %eof(mktcara1)
025300060517     c                             and (matodt > #RUNDTE OR MATODT = 0)
025400060517     c                   leavesr
025500060517     c                   endif
025600060517     c                   enddo
025700060517     **
025800060517     c                   eval      maszcd = '50 '
025900060517     **
026000060517     c                   endsr
026100060517   S***S
026200060517     c     $s8           begsr
026300060517     **
026400060517     C                   IF        (MASZCD = '50 ' AND CVCOUNT < 10) OR
026500060517     C                             (MASZCD = '09 ' AND CVCOUNT > 9)
026600060524     C                   EXSR      $CTX
026700060517     C                   EVAL      @X = %CHAR(CVTRST) + ',' + %CHAR(CVSUB#) +
026800060517     C                             ',' + %CHAR(CVACCT) + ',"' + %TRIM(MASZCD) +
026900060524     C                             '",' + %CHAR(CVCOUNT) + ',"' + CTX#DTE +
027000060524     C                             '"'
027100060517     C                   EXCEPT    OUTF
027200060517     C                   ENDIF
027300060517     **
027400060517     C                   EVAL      @S = '7'
027500060524     **
027600060524     c                   endsr
027700060524   S***S
027800060524     c     $CTX          begsr
027900060524     **
028000060524     C                   MOVE      *BLANKS       CTX#DTE          10
028100060524     C                   MOVE      CVTRST        @3                3
028200060524     C                   MOVEL(P)  @3            @OUT             10
028300060524     C                   MOVE      CVSUB#        @3
028400060524     C                   EVAL      %SUBST(@OUT:4:3) = @3
028500060524     C                   MOVE      CVACCT        @4                4
028600060525     C                   EVAL      %SUBST(@OUT:7:4) = @4
028700060524     C                   MOVE      *BLANKS       @IN               8
028800060524     C                   CALL      'COVENTRY03'
028900060524     C                   PARM                    @OUT
029000060524     C                   PARM                    @IN
029100060524     C                   IF        @IN = '00000000'
029200060524     C                   EVAL      CTX#DTE = 'NO DATE FD'
029300060524     C                   ELSE
029400060525     C                   EVAL      CTX#DTE = %SUBST(@IN:5:2) + '/' +
029500060525     C                             %SUBST(@IN:7:2) + '/' + %SUBST(@IN:1:4)
029600060524     C                   ENDIF
029700060517     **
029800060517     c                   endsr
029900060517   S***S
030000060515     OT2000     EADD         OUTF
030100060515     O                       @X                2000
