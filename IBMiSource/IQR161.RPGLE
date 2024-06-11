000100030109     F*-------------------------------------------------------------------------
000200040708     F* IQR161     GBS/IO SOFTWARE 2003
000300030110     F*            FM47* SUPER AGENCY ENCHANCMENT PROJECT
000400030109     F*            WRITTEN BY - S.S.K.
000500030109     F*            DATE - 01/03
000600030110     F*  DESCRIPTION - DISPLAY AGENCY/SUPER AGENCY RECORDS
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
001700030110     ** 000  SSK  01102003  ORIGINAL SOURCE                               **
001800040708     ** ***  SSK  01022004  COPY FM472 TO IQ                              **
001900030109     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002000030110     FSPRAGXR1  IF   E           K DISK
002100030110     FSUPRAGCY  IF   E           K DISK
002200040708     FIQR161D   CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
002300030109   X***X
002400030109    ***
002500030109     D WSDS            DS
002600030109     D  FKEY                 369    369A
002700030109    ***
002800030109     D  F1             C                   CONST(X'31')
002900030109     D  F2             C                   CONST(X'32')
003000030109     D  F3             C                   CONST(X'33')
003100030109     D  F4             C                   CONST(X'34')
003200030109     D  F5             C                   CONST(X'35')
003300030109     D  F6             C                   CONST(X'36')
003400030109     D  F7             C                   CONST(X'37')
003500030109     D  F8             C                   CONST(X'38')
003600030109     D  F9             C                   CONST(X'39')
003700030109     D  F10            C                   CONST(X'3A')
003800030109     D  F11            C                   CONST(X'3B')
003900030109     D  F12            C                   CONST(X'3C')
004000030109     D  F13            C                   CONST(X'B1')
004100030109     D  F14            C                   CONST(X'B2')
004200030109     D  F15            C                   CONST(X'B3')
004300030109     D  F16            C                   CONST(X'B4')
004400030109     D  F17            C                   CONST(X'B5')
004500030109     D  F18            C                   CONST(X'B6')
004600030109     D  F19            C                   CONST(X'B7')
004700030109     D  F20            C                   CONST(X'B8')
004800030109     D  F21            C                   CONST(X'B9')
004900030109     D  F22            C                   CONST(X'BA')
005000030109     D  F23            C                   CONST(X'BB')
005100030109     D  F24            C                   CONST(X'BC')
005200030109    ***
005300030306     D @ALL32        E DS                  EXTNAME(SPRAGXRF)
005400030109     D @STEP           S              5A
005500030109     D RRT             S              4S 0
005600030109     D #CNTREC         S              4S 0
005700030109   X***X
005800030109     C* MAINLINE
005900030109    ***
006000030109     C                   DOU       @STEP = 'LEAVE'
006100030109     C     @STEP         CASEQ     'PREP1'       $PREP1
006200030109     C     @STEP         CASEQ     'STEP1'       $STEP1
006300030109     C                   ENDCS
006400030109     C                   ENDDO
006500030109     C                   EVAL      *INLR = *ON
006600030109   S***S
006700030109     C     *INZSR        BEGSR
006800030109    ***
006900030109     C     *ENTRY        PLIST
007000030429     C                   PARM                    P@30             30
007100030109    ***
007200030109     C                   EVAL      @STEP = 'PREP1'
007300030109     C                   MOVE      *BLANKS       I_CODE
007400030429     C                   EVAL      O_AGENCY = %SUBST(P@30:4:3)
007500030110    ***
007600030110     C     KEY#SXF       KLIST
007700030110     C                   KFLD                    O_AGENCY
007800030110     C                   KFLD                    I_CODE
007900030109    ***
008000030109     C                   ENDSR
008100030109   S***S
008200030109     C     $PREP1        BEGSR
008300030109    ***
008400030110     C                   MOVE      '         A'  I_CODE
008500030109     C                   EXSR      $BUILDSFL
008600030109     C                   EVAL      @STEP = 'STEP1'
008700030109     C                   MOVE      *BLANKS       I_CODE
008800030109    ***
008900030109     C                   ENDSR
009000030109   S***S
009100030109     C     $BUILDSFL     BEGSR
009200030109    ***
009300030109     C                   MOVE      *ZEROS        RRT
009400030109     C                   MOVE      *ZEROS        #CNTREC
009500030109    ***
009600030109     C                   MOVEA     '011'         *IN(25)
009700030109     C                   WRITE     WDWCTL
009800030109     C                   MOVEA     '010'         *IN(25)
009900030109    ***
010000030110     C     KEY#SXF       SETLL     SXF
010100030110     C                   DOU       %EOF(SPRAGXR1) OR #CNTREC = 9000
010200030110     C     O_AGENCY      READE     SXF
010300030110     C                   IF        NOT %EOF(SPRAGXR1)
010400030110    ***
010500030110     C                   EXSR      $LOADSFL
010600030110    ***
010700030110     C                   ENDIF
010800030110     C                   ENDDO
010900030109    ***
011000030109     C                   IF        RRT > 6
011100030109     C                   EVAL      *IN91 = *ON
011200030109     C                   ENDIF
011300030109    ***
011400030109     C                   ENDSR
011500030109   S***S
011600030109     C     $LOADSFL      BEGSR
011700030109    ***
011800030109     C                   MOVE      *ON           *IN25
011900030109     C                   ADD       1             RRT
012000030109     C                   IF        RRT = 1
012100030109     C                   Z-ADD     RRT           SFLPOS
012200030109     C                   ENDIF
012300030109     C                   MOVE      *BLANKS       SEL
012400030110     C                   MOVEL(P)  SXSUPER       SFCODE
012500030110     C                   CLEAR                   HLDREC
012600030306     C                   EVAL      HLDREC = @ALL32
012700030110    ***
012800030110     C     SXSUPER       CHAIN     SAF
012900030110     C                   IF        %FOUND(SUPRAGCY)
013000030109     C                   MOVEL(P)  SANAME1       SFNAME1
013100030110     C                   ELSE
013200030110     C                   MOVEL(P)  '*UNKNOWN'    SFNAME1
013300030110     C                   ENDIF
013400030110    ***
013500030110     C                   IF        SXEFFDTE > 0
013600030110     C     SXEFFDTE      MULT      10000.0001    SFEFF
013700030109     C                   ELSE
013800030110     C                   Z-ADD     SXEFFDTE      SFEFF
013900030109     C                   ENDIF
014000030110     C                   IF        SXTRMDTE > 0
014100030110     C     SXTRMDTE      MULT      10000.0001    SFTRM
014200030109     C                   ELSE
014300030110     C                   Z-ADD     SXTRMDTE      SFTRM
014400030109     C                   ENDIF
014500030306     C                   EVAL      SFASID = SXASID
014600030109     C                   WRITE     POPUP
014700030109     C                   ADD       1             #CNTREC
014800030109    ***
014900030109     C                   ENDSR
015000030109   S***S
015100030109     C     $STEP1        BEGSR
015200030109    ***
015300030109     C                   WRITE     JUNK
015400030109     C                   EXFMT     WDWCTL
015500030109    ***
015600030109     C                   IF        FKEY = F1
015700030429     C                   MOVEL(P)  '*LR'         P@30
015800030109     C                   EVAL      @STEP = 'LEAVE'
015900030109     C                   LEAVESR
016000030109     C                   ENDIF
016100030109    ***
016200030110     C                   IF        I_CODE <> *BLANKS
016300030109     C                   EXSR      $BUILDSFL
016400030109     C                   MOVE      *BLANKS       I_CODE
016500030109     C                   LEAVESR
016600030110     C                   ENDIF
016700030109    ***
016800030109     C                   EXSR      $CHKSEL
016900030109    ***
017000030109     C                   ENDSR
017100030109   S***S
017200030109     C     $CHKSEL       BEGSR
017300030109    ***
017400030109     C                   MOVE      *OFF          *IN99
017500030109    ***
017600030109     C                   DOU       *IN99 = *ON
017700030109     C                   READC     POPUP                                  99
017800030109     C                   IF        *IN99 = *OFF AND SEL <> *BLANKS
017900030109    ***
018000030109     C                   MOVE      *ON           *IN99
018100030429     C                   EVAL      P@30 = HLDREC
018200030109     C                   EVAL      @STEP = 'LEAVE'
018300030109    ***
018400030109     C                   ENDIF
018500030109     C                   ENDDO
018600030109     C*
018700030109     C                   ENDSR
018800030109   S***S
