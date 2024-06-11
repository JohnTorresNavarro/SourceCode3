000100030109     F*-------------------------------------------------------------------------
000200040708     F* IQR163     GBS/IO SOFTWARE 2003
000300030110     F*            FM47* SUPER AGENCY ENCHANCMENT PROJECT
000400030109     F*            WRITTEN BY - S.S.K.
000500030109     F*            DATE - 01/03
000600030306     F*  DESCRIPTION - DISPLAY ALL AGENCY/SUPER AGENCY RECORDS
000700030109     F*  INDICATOR USAGE:
000800030109     F*    01 = EXIT FROM INITIAL SCREEN
000900030109     F*    25 = SFLDSP
001000030109     F*    26 = SFL DSP CTL
001100030109     F*    27 = SFL CLR
001200030109     F*
001300030109     F*
001400030109     F*-------------------------------------------------------------------------
001500030109     ** MODIFICATION HISTORY                                              **
001600030109     ** ###  UUU  MMDDCCYY  X---->                                        **
001700030306     ** 000  SSK  03062003  ORIGINAL SOURCE                               **
001800040708     ** ***  SSK  01022004  COPY FM473R TO IQ.                            **
001900030109     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002000030110     FSPRAGXR1  IF   E           K DISK
002100030110     FSUPRAGCY  IF   E           K DISK
002200030307     FAGENCY    IF   E           K DISK
002300040708     FIQR163D   CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
002400030109   X***X
002500030109    ***
002600030109     D WSDS            DS
002700030109     D  FKEY                 369    369A
002800030109    ***
002900030109     D  F1             C                   CONST(X'31')
003000030109     D  F2             C                   CONST(X'32')
003100030109     D  F3             C                   CONST(X'33')
003200030109     D  F4             C                   CONST(X'34')
003300030109     D  F5             C                   CONST(X'35')
003400030109     D  F6             C                   CONST(X'36')
003500030109     D  F7             C                   CONST(X'37')
003600030109     D  F8             C                   CONST(X'38')
003700030109     D  F9             C                   CONST(X'39')
003800030109     D  F10            C                   CONST(X'3A')
003900030109     D  F11            C                   CONST(X'3B')
004000030109     D  F12            C                   CONST(X'3C')
004100030109     D  F13            C                   CONST(X'B1')
004200030109     D  F14            C                   CONST(X'B2')
004300030109     D  F15            C                   CONST(X'B3')
004400030109     D  F16            C                   CONST(X'B4')
004500030109     D  F17            C                   CONST(X'B5')
004600030109     D  F18            C                   CONST(X'B6')
004700030109     D  F19            C                   CONST(X'B7')
004800030109     D  F20            C                   CONST(X'B8')
004900030109     D  F21            C                   CONST(X'B9')
005000030109     D  F22            C                   CONST(X'BA')
005100030109     D  F23            C                   CONST(X'BB')
005200030109     D  F24            C                   CONST(X'BC')
005300030109    ***
005400030429     D @ALL30        E DS                  EXTNAME(SPRAGXRF)
005500030109     D @STEP           S              5A
005600030109     D RRT             S              4S 0
005700030109     D #CNTREC         S              4S 0
005800030109   X***X
005900030109     C* MAINLINE
006000030109    ***
006100030109     C                   DOU       @STEP = 'LEAVE'
006200030109     C     @STEP         CASEQ     'PREP1'       $PREP1
006300030109     C     @STEP         CASEQ     'STEP1'       $STEP1
006400030109     C                   ENDCS
006500030109     C                   ENDDO
006600030109     C                   EVAL      *INLR = *ON
006700030109   S***S
006800030109     C     *INZSR        BEGSR
006900030109    ***
007000030109     C     *ENTRY        PLIST
007100030429     C                   PARM                    P@30             30
007200030109    ***
007300030109     C                   EVAL      @STEP = 'PREP1'
007400030306     C                   MOVE      *BLANKS       I_AGCY
007500030306     C                   MOVE      *BLANKS       I_SUPER
007600030110    ***
007700030110     C     KEY#SXF       KLIST
007800030306     C                   KFLD                    I_AGCY
007900030306     C                   KFLD                    I_SUPER
008000030109    ***
008100030109     C                   ENDSR
008200030109   S***S
008300030109     C     $PREP1        BEGSR
008400030109    ***
008500030306     C                   MOVE      '  A'         I_AGCY
008600030429     C                   MOVE      '  A'         I_SUPER
008700030109     C                   EXSR      $BUILDSFL
008800030109     C                   EVAL      @STEP = 'STEP1'
008900030109    ***
009000030109     C                   ENDSR
009100030109   S***S
009200030109     C     $BUILDSFL     BEGSR
009300030109    ***
009400030109     C                   MOVE      *ZEROS        RRT
009500030109     C                   MOVE      *ZEROS        #CNTREC
009600030109    ***
009700030109     C                   MOVEA     '011'         *IN(25)
009800030109     C                   WRITE     WDWCTL
009900030109     C                   MOVEA     '010'         *IN(25)
010000030109    ***
010100030110     C     KEY#SXF       SETLL     SXF
010200030110     C                   DOU       %EOF(SPRAGXR1) OR #CNTREC = 9000
010300030306     C                   READ      SXF
010400030110     C                   IF        NOT %EOF(SPRAGXR1)
010500030110    ***
010600030110     C                   EXSR      $LOADSFL
010700030110    ***
010800030110     C                   ENDIF
010900030110     C                   ENDDO
011000030109    ***
011100030306     C                   IF        RRT > 9
011200030109     C                   EVAL      *IN91 = *ON
011300030109     C                   ENDIF
011400030109    ***
011500030307     C                   MOVE      *BLANKS       I_AGCY
011600030307     C                   MOVE      *BLANKS       I_SUPER
011700030307    ***
011800030109     C                   ENDSR
011900030109   S***S
012000030109     C     $LOADSFL      BEGSR
012100030109    ***
012200030109     C                   MOVE      *ON           *IN25
012300030109     C                   ADD       1             RRT
012400030109     C                   IF        RRT = 1
012500030109     C                   Z-ADD     RRT           SFLPOS
012600030109     C                   ENDIF
012700030109     C                   MOVE      *BLANKS       SEL
012800030306     C                   EVAL      O_AGCY = SXAGCY
012900030306     C                   EVAL      O_SUPER = SXSUPER
013000030306     C                   EVAL      O_ASID = SXASID
013100030110     C                   CLEAR                   HLDREC
013200030429     C                   EVAL      HLDREC = @ALL30
013300030110    ***
013400030110     C     SXSUPER       CHAIN     SAF
013500030110     C                   IF        %FOUND(SUPRAGCY)
013600030306     C                   MOVEL(P)  SANAME1       D_SUPER
013700030110     C                   ELSE
013800030306     C                   MOVEL(P)  '*UNKNOWN'    D_SUPER
013900030110     C                   ENDIF
014000030110    ***
014100030306     C     SXAGCY        CHAIN     AGENR
014200030306     C                   IF        %FOUND(AGENCY)
014300030306     C                   MOVEL(P)  AGNAM1        D_AGCY
014400030306     C                   ELSE
014500030306     C                   MOVEL(P)  '*UNKNOWN'    D_AGCY
014600030306     C                   ENDIF
014700030306    ***
014800030110     C                   IF        SXEFFDTE > 0
014900030110     C     SXEFFDTE      MULT      10000.0001    SFEFF
015000030109     C                   ELSE
015100030110     C                   Z-ADD     SXEFFDTE      SFEFF
015200030109     C                   ENDIF
015300030110     C                   IF        SXTRMDTE > 0
015400030110     C     SXTRMDTE      MULT      10000.0001    SFTRM
015500030109     C                   ELSE
015600030110     C                   Z-ADD     SXTRMDTE      SFTRM
015700030109     C                   ENDIF
015800030306    ***
015900030109     C                   WRITE     POPUP
016000030109     C                   ADD       1             #CNTREC
016100030109    ***
016200030109     C                   ENDSR
016300030109   S***S
016400030109     C     $STEP1        BEGSR
016500030109    ***
016600030109     C                   WRITE     JUNK
016700030109     C                   EXFMT     WDWCTL
016800030109    ***
016900030109     C                   IF        FKEY = F1
017000030429     C                   MOVEL(P)  '*LR'         P@30
017100030109     C                   EVAL      @STEP = 'LEAVE'
017200030109     C                   LEAVESR
017300030109     C                   ENDIF
017400030109    ***
017500030307     C                   IF        I_AGCY <> *BLANKS
017600030109     C                   EXSR      $BUILDSFL
017700030109     C                   LEAVESR
017800030110     C                   ENDIF
017900030109    ***
018000030109     C                   EXSR      $CHKSEL
018100030109    ***
018200030109     C                   ENDSR
018300030109   S***S
018400030109     C     $CHKSEL       BEGSR
018500030109    ***
018600030109     C                   MOVE      *OFF          *IN99
018700030109    ***
018800030109     C                   DOU       *IN99 = *ON
018900030109     C                   READC     POPUP                                  99
019000030109     C                   IF        *IN99 = *OFF AND SEL <> *BLANKS
019100030109    ***
019200030109     C                   MOVE      *ON           *IN99
019300030429     C                   EVAL      P@30 = HLDREC
019400030109     C                   EVAL      @STEP = 'LEAVE'
019500030109    ***
019600030109     C                   ENDIF
019700030109     C                   ENDDO
019800030109     C*
019900030109     C                   ENDSR
020000030109   S***S
