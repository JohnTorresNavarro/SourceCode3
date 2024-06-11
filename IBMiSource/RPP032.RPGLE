000100111107     FRPP032D   CF   E             WORKSTN INFDS(WSDS)
000200111011   X***X
000300111011     D/COPY GALIB/QRPGLESRC,FKEYSTD
000400111011   X***X
000500111011     D #ISO            S               D   DATFMT(*ISO)
000600111011     D @EMSG           S                   LIKE(EMSG)
000700111011     D @V              S              1A
000800111011     D @STEP           S              5A
000900111011    ***
001000111011   X***X
001100111011     C                   DOU       @STEP = 'LEAVE'
001200111011     C     @STEP         CASEQ     'STEP1'       $STEP1
001300111011     C                   ENDCS
001400111011     C                   ENDDO
001500111011    ***
001600111011     C                   MOVE      *ON           *INLR
001700111011     C                   RETURN
001800111011   S***S
001900111011     C* ONETIME ROUTINE
002000111011    ***
002100111011     C     *INZSR        BEGSR
002200111011    ***
002300111011     C     *ENTRY        PLIST
002400111107     C                   PARM                    @FR               8
002500111107     C                   PARM                    @TO               8
002600111011    ***
002700111011     C                   EVAL      @STEP = 'STEP1'
002800111011     C                   EVAL      @EMSG = 'PLEASE CHOOSE YOUR OPTIONS CAR'
002900111011     C                             + 'FULLY.'
003000111107     C                   EVAL      #ISO = %DATE
003100111107     C     *USA          MOVE      #ISO          ITO
003200111107     C                   SUBDUR    5:*Y          #ISO
003300111107     C     *USA          MOVE      #ISO          IFRM
003400111011    ***
003500111011     C                   ENDSR
003600111011   S***S
003700111011     C     $STEP1        BEGSR
003800111011    ***
003900111011     C                   EVAL      EMSG = @EMSG
004000111011     C                   EXFMT     SCREEN
004100111011     C                   EVAL      EMSG = *BLANKS
004200111011     C                   EVAL      @EMSG = *BLANKS
004300111011    ***
004400111011     C                   IF        FKEY = F3
004500111107     C                   MOVE      *ALL'0'       @FR
004600111107     C                   MOVE      *ALL'0'       @TO
004700111011     C                   EVAL      @STEP = 'LEAVE'
004800111011     C                   LEAVESR
004900111011     C                   ENDIF
005000111011    ***
005100111011     C                   IF        FKEY = F12
005200111011     C                   EVAL      *IN25  = *OFF
005300111011     C                   LEAVESR
005400111011     C                   ENDIF
005500111011    ***
005600111011     C                   IF        FKEY = F5
005700111011     C                   EXSR      $VALID
005800111011     C                   IF        @V = 'Y'
005900111011     C                   EVAL      @STEP = 'LEAVE'
006000111011     C                   ENDIF
006100111011     C                   LEAVESR
006200111011     C                   ENDIF
006300111011    ***
006400111011     C                   EXSR      $VALID
006500111011     C                   IF        @V = 'Y'
006600111011     C                   EVAL      *IN25  = *ON
006700111011     C                   ENDIF
006800111011    ***
006900111011     C                   ENDSR
007000111011   S***S
007100111011     C     $VALID        BEGSR
007200111011    ***
007300111011     C                   EVAL      @V = 'N'
007400111011    ***
007500111011     C                   IF        IFRM    = 0
007600111011     C                   EVAL      @EMSG = 'INVALID FROM DATE.'
007700111011     C                   LEAVESR
007800111011     C                   ENDIF
007900111011    ***
008000111011     C                   IF        ITO     = 0
008100111011     C                   EVAL      @EMSG = 'INVALID TO DATE.'
008200111011     C                   LEAVESR
008300111011     C                   ENDIF
008400111107    ***
008500111107     C                   IF        ITO <= IFRM
008600111107     C                   EVAL      @EMSG = 'INVALID FROM/TO DATE.'
008700111107     C                   LEAVESR
008800111107     C                   ENDIF
008900111011    ***
009000111011     C     *USA          TEST(DE)                IFRM
009100111011     C                   IF        %ERROR
009200111011     C                   EVAL      @EMSG = 'FROM DATE IS INVALID'
009300111011     C                   LEAVESR
009400111011     C                   ENDIF
009500111011     C     IFRM          MULT      10000.0001    ISO#FR            8 0
009600111107     C                   MOVE      ISO#FR        @FR
009700111011    ***
009800111011     C     *USA          TEST(DE)                ITO
009900111011     C                   IF        %ERROR
010000111011     C                   EVAL      @EMSG = 'TO DATE IS INVALID'
010100111011     C                   LEAVESR
010200111011     C                   ENDIF
010300111011     C     ITO           MULT      10000.0001    ISO#TO            8 0
010400111107     C                   MOVE      ISO#TO        @TO
010500111011    ***
010600111011     C                   EVAL      @V = 'Y'
010700111011    ***
010800111011     C                   ENDSR
