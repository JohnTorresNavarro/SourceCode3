000100060516     *** COVENTRY AUDIT PROGRAM
000200060516     FCOVENTRY02UF A E           K DISK
000300060516     fPLNMSTN1  IF   e           K disk
000400060516     fMCOVXX    if   e           k disk
000500060511     fmktcara1  if   e           k disk
000600060516     FT2000     O  A F 2000        DISK
000700060525   X***X
000800060515     D MCM@          E DS                  EXTNAME(MCOV)
000900060515     D MKM@          E DS                  EXTNAME(MKTCARA0)
001000060516     D #ISO            S               D   DATFMT(*ISO)
001100060517     D #CISO           S               D   DATFMT(*ISO)
001200060517     D #ISX            S              8S 0
001300060517     D #USX            S              8S 0
001400060517     D #USA            S               D   DATFMT(*USA)
001500060517     D @EMSG           S             70A
001600060511     d @s              s              1a
001700060515     d @X              S           2000A
001800060515   X***X
001900060515     c                   eval      @s = '0'
002000060517     C                   EVAL      @X = *BLANKS
002100060515     **
002200060511     c                   dou       @s = 'X'
002300060515     c     @s            caseq     '0'           $P1
002400060511     c     @s            caseq     '2'           $s2
002500060511     c     @s            caseq     '3'           $s3
002600060511     c     @s            caseq     '4'           $s4
002700060511     c     @s            caseq     '5'           $s5
002800060515     c     @s            caseq     '6'           $s6
002900060517     c     @s            caseq     '7'           $s7
003000060517     c     @s            caseq     '8'           $s8
003100060511     c                   endcs
003200060511     c                   enddo
003300060516     C                   EVAL      *INLR = *ON
003400060515   S***S
003500060515     c     $P1           begsr
003600060516     **
003700060516     C                   EVAL      @X = *BLANKS
003800060525     c                   eval      @s = '2'
003900060516     **
004000060516     C                   MOVE      *DATE         #ISO
004100060516     C                   ADDDUR    1:*M          #ISO
004200060525     C                   EXTRCT(E) #ISO:*M       #MTH              2 0
004300060525     C                   EXTRCT(E) #ISO:*Y       #YR               4 0
004400060525     C                   EVAL      #USX = (#MTH * 1000000) + 10000 + #YR
004500060525     C                   EVAL      #ISX = (#YR * 10000) + (#MTH * 100) + 1
004600060516     **
004700060516     c                   endsr
004800060515   S***S
004900060511     c     $s2           begsr
005000060515     **
005100060516     C                   MOVE      #ISX          #RUNDTE           8 0
005200060516     **
005300060516     C                   MOVE      'COV'         CAR#KEY           3
005400060516     C     CAR#KEY       SETLL     PLNMSR
005500060516     **
005600060516     c                   eval      @s = '3'
005700060515     **
005800060511     c                   endsr
005900060515   S***S
006000060511     c     $s3           begsr
006100060515     **
006200060516     c     CAR#KEY       reade     PLNMSR
006300060515     **
006400060516     c                   IF        %eof(PLNMSTN1)
006500060517     c                   eval      @s = '6'
006600060515     c                   leavesr
006700060515     c                   endif
006800060515     **
006900060516     c     kl2           klist
007000060516     c                   kfld                    pltrst
007100060516     c                   kfld                    plsub#
007200060516     c                   kfld                    plplan
007300060516     **
007400060516     c     kl2           setll     mcovr
007500060516     c                   if        not %equal(MCOVXX)
007600060516     c                   leavesr
007700060516     C                   ELSE
007800060516     C                   EVAL      @S = '4'
007900060516     c                   endif
008000060515     **
008100060511     c                   endsr
008200060515   S***S
008300060511     c     $s4           begsr
008400060515     **
008500060516     c     kl2           READE     mcovr
008600060516     **
008700060516     c                   IF        %eof(MCOVXX)
008800060516     c                   eval      @s = '3'
008900060516     c                   leavesr
009000060516     c                   endif
009100060516     **
009200060516     c                   IF        CANDT = ENRLDT OR
009300060516     c                             (CANDT <= #RUNDTE AND CANDT <> 0) OR
009400060516     c                             ENRLDT > #RUNDTE
009500060516     c                   leavesr
009600060516     c                   endif
009700060516     **
009800060516     C                   EVAL      @S = '5'
009900060516     **
010000060516     c                   endsr
010100060516   S***S
010200060516     c     $s5           begsr
010300060516     **
010400060511     c     kl3           klist
010500060511     c                   kfld                    mctrst
010600060511     c                   kfld                    mcsub#
010700060511     c                   kfld                    acc#
010800060516     **
010900060516     c     kl3           chain     COVF
011000060516     C                   IF        %FOUND(COVENTRY02)
011100060516     C                   ADD       1             CVCOUNT
011200060517     C                   UPDATE    COVF
011300060517     C                   ELSE
011400060517     C                   EVAL      CVTRST = MCTRST
011500060517     C                   EVAL      CVSUB# = MCSUB#
011600060517     C                   EVAL      CVACCT = ACC#
011700060517     C                   Z-ADD     1             CVCOUNT
011800060517     C                   WRITE     COVF
011900060517     C                   ENDIF
012000060517     **
012100060517     C                   EVAL      @S = '4'
012200060517     **
012300060517     c                   endsr
012400060517   S***S
012500060517     c     $s6           begsr
012600060517     **
012700060517     C                   EVAL      @X = '"COVENTRY MARKET SIZE AUDIT"'
012800060517     C                   EXCEPT    OUTF
012900060517     C                   EVAL      @X = ','
013000060517     C                   EXCEPT    OUTF
013100060517     C                   EVAL      @X = '"TRUST","SUBDIVISION","ACCOUNT","CUR' +
013200060524     C                             'RENT MARKET SIZE","NO. OF CONTRACTS","COM' +
013300060524     C                             'MISSION CONTROL DATE"'
013400060517     C                   EXCEPT    OUTF
013500060517     **
013600060517     C                   MOVE      *ZEROS        #K3               3 0
013700060517     **
013800060517     C     #K3           SETLL     COVF
013900060517     **
014000060517     C                   EVAL      @S = '7'
014100060517     **
014200060517     c                   endsr
014300060517   S***S
014400060517     c     $s7           begsr
014500060517     **
014600060517     C                   READ      COVF
014700060517     **
014800060517     C                   IF        %EOF(COVENTRY02)
014900060517     C                   EVAL      @S = 'X'
015000060517     C                   LEAVESR
015100060517     C                   ENDIF
015200060517     **
015300060517     c     kl4           klist
015400060517     c                   kfld                    CVtrst
015500060517     c                   kfld                    CVsub#
015600060517     c                   kfld                    CVacct
015700060517     c                   kfld                    CAR#KEY
015800060517     **
015900060517     c                   eval      @s = '8'
016000060517     c     kl4           chain     rmktcara
016100060517     **
016200060517     c                   if        not %found(mktcara1)
016300060517     c                   eval      maszcd = '50 '
016400060517     c                   leavesr
016500060517     C                   ENDIF
016600060517     **
016700060517     c     kl4           setll     rmktcara
016800060517     c                   dou       %eof(mktcara1)
016900060517     c     kl4           reade     rmktcara
017000060517     c                   if        not %eof(mktcara1)
017100060517     c                             and (matodt > #RUNDTE OR MATODT = 0)
017200060517     c                   leavesr
017300060517     c                   endif
017400060517     c                   enddo
017500060517     **
017600060517     c                   eval      maszcd = '50 '
017700060517     **
017800060517     c                   endsr
017900060517   S***S
018000060517     c     $s8           begsr
018100060517     **
018200060517     C                   IF        (MASZCD = '50 ' AND CVCOUNT < 10) OR
018300060517     C                             (MASZCD = '09 ' AND CVCOUNT > 9)
018400060524     C                   EXSR      $CTX
018500060517     C                   EVAL      @X = %CHAR(CVTRST) + ',' + %CHAR(CVSUB#) +
018600060517     C                             ',' + %CHAR(CVACCT) + ',"' + %TRIM(MASZCD) +
018700060524     C                             '",' + %CHAR(CVCOUNT) + ',"' + CTX#DTE +
018800060524     C                             '"'
018900060517     C                   EXCEPT    OUTF
019000060517     C                   ENDIF
019100060517     **
019200060517     C                   EVAL      @S = '7'
019300060524     **
019400060524     c                   endsr
019500060524   S***S
019600060524     c     $CTX          begsr
019700060524     **
019800060524     C                   MOVE      *BLANKS       CTX#DTE          10
019900060524     C                   MOVE      CVTRST        @3                3
020000060524     C                   MOVEL(P)  @3            @OUT             10
020100060524     C                   MOVE      CVSUB#        @3
020200060524     C                   EVAL      %SUBST(@OUT:4:3) = @3
020300060524     C                   MOVE      CVACCT        @4                4
020400060525     C                   EVAL      %SUBST(@OUT:7:4) = @4
020500060524     C                   MOVE      *BLANKS       @IN               8
020600060524     C                   CALL      'COVENTRY03'
020700060524     C                   PARM                    @OUT
020800060524     C                   PARM                    @IN
020900060524     C                   IF        @IN = '00000000'
021000060524     C                   EVAL      CTX#DTE = 'NO DATE FD'
021100060524     C                   ELSE
021200060525     C                   EVAL      CTX#DTE = %SUBST(@IN:5:2) + '/' +
021300060525     C                             %SUBST(@IN:7:2) + '/' + %SUBST(@IN:1:4)
021400060524     C                   ENDIF
021500060517     **
021600060517     c                   endsr
021700060517   S***S
021800060515     OT2000     EADD         OUTF
021900060515     O                       @X                2000
