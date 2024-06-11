000100111012     FRPP010D   CF   E             WORKSTN INFDS(WSDS)
000200111011     FACMUNIQUE IF   E           K DISK
000300111011     FTRMUNIQUE IF   E           K DISK
000400111011     FSUMUNIQUE IF   E           K DISK
000500111011   X***X
000600111011     D/COPY GALIB/QRPGLESRC,FKEYSTD
000700111011   X***X
000800111011     D #ISO            S               D   DATFMT(*ISO)
000900111011     D @EMSG           S                   LIKE(EMSG)
001000111011     D @V              S              1A
001100111011     D @STEP           S              5A
001200111011    ***
001300111011   X***X
001400111011     C                   DOU       @STEP = 'LEAVE'
001500111011     C     @STEP         CASEQ     'STEP1'       $STEP1
001600111011     C                   ENDCS
001700111011     C                   ENDDO
001800111011    ***
001900111011     C                   MOVE      *ON           *INLR
002000111011     C                   RETURN
002100111011   S***S
002200111011     C* ONETIME ROUTINE
002300111011    ***
002400111011     C     *INZSR        BEGSR
002500111011    ***
002600111011     C     *ENTRY        PLIST
002700111011     C                   PARM                    @P16             27
002800111011    ***
002900111011     C                   EVAL      @STEP = 'STEP1'
003000111011     C                   EVAL      @EMSG = 'PLEASE CHOOSE YOUR OPTIONS CAR'
003100111011     C                             + 'FULLY.'
003200111011     C                   EVAL      IFRM = 01012011
003300111011     C                   EVAL      ITO = 12312011
003400111011     C                   EVAL      ITRS = 0
003500111011     C                   EVAL      ISUB = 0
003600111011     C                   EVAL      IACC = 0
003700111011    ***
003800111011     C                   ENDSR
003900111011   S***S
004000111011     C     $STEP1        BEGSR
004100111011    ***
004200111011     C                   EVAL      EMSG = @EMSG
004300111011     C                   EXFMT     SCREEN
004400111011     C                   EVAL      EMSG = *BLANKS
004500111011     C                   EVAL      @EMSG = *BLANKS
004600111011    ***
004700111011     C                   IF        FKEY = F3
004800111011     C                   MOVE      *ALL'SKIP'    @P16
004900111011     C                   EVAL      @STEP = 'LEAVE'
005000111011     C                   LEAVESR
005100111011     C                   ENDIF
005200111011    ***
005300111011     C                   IF        FKEY = F12
005400111011     C                   EVAL      *IN25  = *OFF
005500111011     C                   LEAVESR
005600111011     C                   ENDIF
005700111011    ***
005800111011     C                   IF        FKEY = F5
005900111011     C                   EXSR      $VALID
006000111011     C                   IF        @V = 'Y'
006100111011     C                   MOVE      ITRS          @3T               3
006200111011     C                   MOVE      ISUB          @3S               3
006300111011     C                   MOVE      IACC          @4A               4
006400111011     C                   EVAL      @P16 = @3T + @3S + @4A +
006500111011     C                             %CHAR(ISO#FR) + %CHAR(ISO#TO) +
006600111011     C                             '*'
006700111011     C                   EVAL      @STEP = 'LEAVE'
006800111011     C                   ENDIF
006900111011     C                   LEAVESR
007000111011     C                   ENDIF
007100111011    ***
007200111011     C                   EXSR      $VALID
007300111011     C                   IF        @V = 'Y'
007400111011     C                   EVAL      *IN25  = *ON
007500111011     C                   ENDIF
007600111011    ***
007700111011     C                   ENDSR
007800111011   S***S
007900111011     C     $VALID        BEGSR
008000111011    ***
008100111011     C                   EVAL      @V = 'N'
008200111011    ***
008300111011     C     ITRS          CHAIN     TRSMSR
008400111011     C                   IF        NOT %FOUND(TRMUNIQUE)
008500111011     C                   EVAL      @EMSG = 'INVALID TRUST.'
008600111011     C                   LEAVESR
008700111011     C                   ENDIF
008800111011     C                   MOVEL(P)  TDESCR        D_TRS
008900111011    ***
009000111011     C     KL#TS         KLIST
009100111011     C                   KFLD                    ITRS
009200111011     C                   KFLD                    ISUB
009300111011     C     KL#TS         CHAIN     SUBMSR
009400111011     C                   IF        NOT %FOUND(SUMUNIQUE)
009500111011     C                   EVAL      @EMSG = 'INVALID SUB.'
009600111011     C                   LEAVESR
009700111011     C                   ENDIF
009800111011     C                   MOVEL(P)  SUBNAM        D_SUB
009900111011    ***
010000111011     C     KL#TSA        KLIST
010100111011     C                   KFLD                    ITRS
010200111011     C                   KFLD                    ISUB
010300111011     C                   KFLD                    IACC
010400111011     C     KL#TSA        CHAIN     ACCMSR
010500111011     C                   IF        NOT %FOUND(ACMUNIQUE)
010600111011     C                   EVAL      @EMSG = 'INVALID ACCOUNT.'
010700111011     C                   LEAVESR
010800111011     C                   ENDIF
010900111011     C                   MOVEL(P)  ACNAM1        D_ACC
011000111011    ***
011100111011     C                   IF        IFRM    = 0
011200111011     C                   EVAL      @EMSG = 'INVALID FROM DATE.'
011300111011     C                   LEAVESR
011400111011     C                   ENDIF
011500111011    ***
011600111011     C                   IF        ITO     = 0
011700111011     C                   EVAL      @EMSG = 'INVALID TO DATE.'
011800111011     C                   LEAVESR
011900111011     C                   ENDIF
012000111011    ***
012100111011     C     *USA          TEST(DE)                IFRM
012200111011     C                   IF        %ERROR
012300111011     C                   EVAL      @EMSG = 'FROM DATE IS INVALID'
012400111011     C                   LEAVESR
012500111011     C                   ENDIF
012600111011     C     IFRM          MULT      10000.0001    ISO#FR            8 0
012700111011    ***
012800111011     C     *USA          TEST(DE)                ITO
012900111011     C                   IF        %ERROR
013000111011     C                   EVAL      @EMSG = 'TO DATE IS INVALID'
013100111011     C                   LEAVESR
013200111011     C                   ENDIF
013300111011     C     ITO           MULT      10000.0001    ISO#TO            8 0
013400111011    ***
013500111011     C                   EVAL      @V = 'Y'
013600111011    ***
013700111011     C                   ENDSR
