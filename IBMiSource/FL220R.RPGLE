000100050301     FcodesL2   if   e           k disk
000200050301     Ffl220d    CF   E             WORKSTN INFDS(WSDS) SFILE(io02s:RRT)
000300050301   X***X
000400050301     D                 DS
000500050301     D  @240                   1    240A
000600050301     d  @32                    1     32a
000700050301     D  TITLE                201    240A
000800050301    ***
000900050301     D WSDS            DS
001000050301     D  FKEY                 369    369A
001100050301    ***
001200050301     D  F1             C                   CONST(X'31')
001300050301     D  F2             C                   CONST(X'32')
001400050301     D  F3             C                   CONST(X'33')
001500050301     D  F4             C                   CONST(X'34')
001600050301     D  F5             C                   CONST(X'35')
001700050301     D  F6             C                   CONST(X'36')
001800050301     D  F7             C                   CONST(X'37')
001900050301     D  F8             C                   CONST(X'38')
002000050301     D  F9             C                   CONST(X'39')
002100050301     D  F10            C                   CONST(X'3A')
002200050301     D  F11            C                   CONST(X'3B')
002300050301     D  F12            C                   CONST(X'3C')
002400050301     D  F13            C                   CONST(X'B1')
002500050301     D  F14            C                   CONST(X'B2')
002600050301     D  F15            C                   CONST(X'B3')
002700050301     D  F16            C                   CONST(X'B4')
002800050301     D  F17            C                   CONST(X'B5')
002900050301     D  F18            C                   CONST(X'B6')
003000050301     D  F19            C                   CONST(X'B7')
003100050301     D  F20            C                   CONST(X'B8')
003200050301     D  F21            C                   CONST(X'B9')
003300050301     D  F22            C                   CONST(X'BA')
003400050301     D  F23            C                   CONST(X'BB')
003500050301     D  F24            C                   CONST(X'BC')
003600050301    ***
003700050301     D
003800050301     D @STEP           S              5A
003900050301     D RRT             S              4S 0
004000050301     D #CNTREC         S              4S 0
004100050301     D @1STLOOP        S              1A
004200050301   X***X
004300050301    ***
004400050301     C                   DOU       @STEP = 'LEAVE'
004500050301     C     @STEP         CASEQ     'PREP1'       $PREP1
004600050301     C     @STEP         CASEQ     'STEP1'       $STEP1
004700050301     C                   ENDCS
004800050301     C                   ENDDO
004900050301    ***
005000050301     C                   MOVE      *ON           *INLR
005100050301   S***S
005200050301     c     *inzsr        begsr
005300050301    ***
005400050301     C                   eval      @step = 'PREP1'
005500050301     C                   move      '*'           key@              1
005600050301     C     *DTAARA       DEFINE    *LDA          @240
005700050301     C                   IN        @240
005800050301    ***
005900050301     c                   endsr
006000050301   S***S
006100050301     c     $PREP1        begsr
006200050301    ***
006300050301     C                   EXSR      $CLEAR
006400050301    ***
006500050301     C                   EXSR      $BUILD
006600050301    ***
006700050301     C                   eval      @step = 'STEP1'
006800050301    ***
006900050301     c                   endsr
007000050301   S***S
007100050301     C     $CLEAR        BEGSR
007200050301    ***
007300050301     C                   MOVEA     '011'         *IN(28)
007400050301     C                   WRITE     io02c
007500050301     C                   MOVEA     '010'         *IN(28)
007600050301     C                   Z-ADD     *ZERO         RRT
007700050301    ***
007800050301     C                   ENDSR
007900050301   S***S
008000050301     C     $BUILD        BEGSR
008100050301    ***
008200050301     C                   MOVE      *ZEROS        #CNTREC
008300050301     C                   MOVE      '0'           @1STLOOP
008400050301     C                   move      *blanks       @flag             1
008500050301    ***
008600050301     C     key@          SETLL     codesr
008700050301    ***
008800050301     C                   DOU       @FLAG = 'X'
008900050301     C                   EXSR      $LOADSFL
009000050301     C                   ENDDO
009100050301    ***
009200050301     C                   ENDSR
009300050301   S***S
009400050301     C     $LOADSFL      BEGSR
009500050301    ***
009600050301     C     key@          READe     codesr
009700050301      *
009800050301     C                   IF        %EOF(codesl2)
009900050301     C                   move      'X'           @flag
010000050301     C                   LEAVESR
010100050301     C                   ENDIF
010200050301    ***
010300050301     C                   MOVE      *ON           *IN28
010400050301     C                   MOVE      *BLANKS       SEL
010500050301     C                   eval      sfld = %trim(ldescr)
010600050301     C                   movel     code          htype
010700050301     C*
010800050301     C                   ADD       1             #CNTREC
010900050301     C                   ADD       1             RRT
011000050301     C*
011100050301     C                   IF        @1STLOOP = '0'
011200050301     C                   Z-ADD     RRT           sflpos2
011300050301     C                   MOVE      '1'           @1STLOOP
011400050301     C                   ENDIF
011500050301     C*
011600050301     C                   WRITE     io02s
011700050301    ***
011800050301     C                   ENDSR
011900050301   S***S
012000050301     c     $step1        begsr
012100050301    ***
012200050301     C                   WRITE     io02r
012300050301     C                   EXFMT     io02c
012400050301    ***
012500050301     C                   IF        FKEY = F7
012600050301     C                   EVAL      @STEP = 'LEAVE'
012700050301     C                   LEAVESR
012800050301     C                   ENDIF
012900050301    ***
013000050301     C                   IF        FKEY = F12
013100050301    3C                   eval      @32 = *blanks
013200050301     C                   out       @240
013300050301    3C                   call      'FL150'
013400050301      *
013500050301     C                   EVAL      @STEP = 'PREP1'
013600050301     C                   LEAVESR
013700050301      *
013800050301     C                   ENDIF
013900050301    ***
014000050301     C                   IF        #CNTREC > 0
014100050301     C                   EXSR      $CHKSEL
014200050301     C                   ENDIF
014300050301    ***
014400050301     C                   ENDSR
014500050301   S***S
014600050301     C     $CHKSEL       BEGSR
014700050301    ***
014800050301    1C                   DOU       %EOF(fl220d)
014900050301     C                   READC     io02s
015000050301    2C                   IF        NOT %EOF(fl220d) AND SEL <> *BLANKS
015100050301      *
015200050301    3C                   eval      @32 = htype + ' ' + %subst(sfld:1:30)
015300050301     C                   out       @240
015400050301    3C                   call      'FL150'
015500050301      *
015600050301    2C                   ENDIF
015700050301    1C                   ENDDO
015800050301    ***
015900050301     C                   EVAL      @STEP = 'PREP1'
016000050301    ***
016100050301     c                   endsr
016200050301   S***S
