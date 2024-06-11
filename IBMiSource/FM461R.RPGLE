000100030109     F*-------------------------------------------------------------------------
000200030109     F* FM462      GBS/IO SOFTWARE 2003
000300030109     F*            FM46* SUPER AGENCY ENCHANCMENT PROJECT
000400030109     F*            WRITTEN BY - S.S.K.
000500030109     F*            DATE - 01/03
000600030109     F*  DESCRIPTION - DISPLAY SUPRAGCY RECORDS
000700030109     F*  INDICATOR USAGE:
000800030109     F*    01 = EXIT FROM INITIAL SCREEN
000900030109     F*    25 = SFLDSP
001000030109     F*    26 = SFL DSP CTL
001100030109     F*    27 = SFL CLR
001200030109     F*
001300030109     F* INDS FOR SFL CTL DATA
001400030109     F* N30 LOAD IN NAME SEQ AND SHOW TEXT FOR CODE SEQ NEXT
001500030109     F*  30 LOAD IN CODE SEQ AND SHOW TEXT FOR NAME SEQ NEXT
001600030109     F*
001700030109     F*-------------------------------------------------------------------------
001800030109     ** MODIFICATION HISTORY                                              **
001900030109     ** ###  UUU  MMDDCCYY  X---->                                        **
002000030109     ** 000  SSK  01092003  ORIGINAL SOURCE                               **
002001070727      * 07/27/07 dlk - fix initial subfile display (would not show name    *
002002070727      *                beginning with *)                                   *
002100030109     **                                                                   **
002200030109     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002300030109     FSUPRAGCY  IF   E           K DISK    RENAME(SAF:BYNBR)
002400030109     FSUPRAGC1  IF   E           K DISK    RENAME(SAF:BYNAM)
002500030109     FFM461D    CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
002600030109   X***X
002700030109    ***
002800030109     D WSDS            DS
002900030109     D  FKEY                 369    369A
003000030109    ***
003100030109     D  F1             C                   CONST(X'31')
003200030109     D  F2             C                   CONST(X'32')
003300030109     D  F3             C                   CONST(X'33')
003400030109     D  F4             C                   CONST(X'34')
003500030109     D  F5             C                   CONST(X'35')
003600030109     D  F6             C                   CONST(X'36')
003700030109     D  F7             C                   CONST(X'37')
003800030109     D  F8             C                   CONST(X'38')
003900030109     D  F9             C                   CONST(X'39')
004000030109     D  F10            C                   CONST(X'3A')
004100030109     D  F11            C                   CONST(X'3B')
004200030109     D  F12            C                   CONST(X'3C')
004300030109     D  F13            C                   CONST(X'B1')
004400030109     D  F14            C                   CONST(X'B2')
004500030109     D  F15            C                   CONST(X'B3')
004600030109     D  F16            C                   CONST(X'B4')
004700030109     D  F17            C                   CONST(X'B5')
004800030109     D  F18            C                   CONST(X'B6')
004900030109     D  F19            C                   CONST(X'B7')
005000030109     D  F20            C                   CONST(X'B8')
005100030109     D  F21            C                   CONST(X'B9')
005200030109     D  F22            C                   CONST(X'BA')
005300030109     D  F23            C                   CONST(X'BB')
005400030109     D  F24            C                   CONST(X'BC')
005500030109    ***
005600030109     D @STEP           S              5A
005700030429     D p@3             S              3A
005800030109     D RRT             S              4S 0
005900030109     D #CNTREC         S              4S 0
006000030109   X***X
006100030109     C* MAINLINE
006200030109    ***
006300030109     C                   DOU       @STEP = 'LEAVE'
006400030109     C     @STEP         CASEQ     'PREP1'       $PREP1
006500030109     C     @STEP         CASEQ     'STEP1'       $STEP1
006600030109     C                   ENDCS
006700030109     C                   ENDDO
006800030109     C                   EVAL      *INLR = *ON
006900030109   S***S
007000030109     C     *INZSR        BEGSR
007100030109    ***
007200030109     C     *ENTRY        PLIST
007300030429     C                   PARM                    p@3
007400030109    ***
007500030109     C                   EVAL      @STEP = 'PREP1'
007600030109     C                   MOVE      *BLANKS       I_CODE
007700070727     C****               MOVEL(P)  'A'           I_NAME
007701070727     C                   clear                   I_NAME
007800030109    ***
007900030109     C                   EVAL      *IN30 = *OFF
008000030109    ***
008100030109     C                   ENDSR
008200030109   S***S
008300030109     C     $PREP1        BEGSR
008400030109    ***
008500030109     C                   EXSR      $BUILDSFL
008600030109     C                   EVAL      @STEP = 'STEP1'
008700030109     C                   MOVE      *BLANKS       I_CODE
008800030109     C                   MOVE      *BLANKS       I_NAME
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
010100030109    1C                   SELECT
010200030109    1C                   WHEN      *IN30 = *ON
010300030109     C                   EXSR      $LOADCODE
010400030109    1C                   WHEN      *IN30 = *OFF
010500030109     C                   EXSR      $LOADNAME
010600030109    1C                   ENDSL
010700030109    ***
010800030109     C                   IF        RRT > 6
010900030109     C                   EVAL      *IN91 = *ON
011000030109     C                   ENDIF
011100030109    ***
011200030109     C                   ENDSR
011300030109   S***S
011400030109     C     $LOADNAME     BEGSR
011500030109    ***
011600030213     C     *LIKE         DEFINE    SANAME1       KEY@NAMEX
011700030213     C                   MOVEL(P)  I_NAME        KEY@NAMEX
011800030213     C     KEY@NAMEX     SETLL     BYNAM
011900030109     C                   DOU       %EOF(SUPRAGC1) OR #CNTREC = 9000
012000030109     C                   READ      BYNAM
012100030109     C                   IF        NOT %EOF(SUPRAGC1)
012200030109    ***
012300030109     C                   EXSR      $LOADSFL
012400030109    ***
012500030109     C                   ENDIF
012600030109     C                   ENDDO
012700030109    ***
012800030109     C                   ENDSR
012900030109   S***S
013000030109     C     $LOADCODE     BEGSR
013100030109    ***
013200030109     C     I_CODE        SETLL     BYNBR
013300030109     C                   DOU       %EOF(SUPRAGCY) OR #CNTREC = 9000
013400030109     C                   READ      BYNBR
013500030109     C                   IF        NOT %EOF(SUPRAGCY)
013600030109    ***
013700030109     C                   EXSR      $LOADSFL
013800030109    ***
013900030109     C                   ENDIF
014000030109     C                   ENDDO
014100030109    ***
014200030109     C                   ENDSR
014300030109   S***S
014400030109     C     $LOADSFL      BEGSR
014500030109    ***
014600030109     C                   MOVE      *ON           *IN25
014700030109     C                   ADD       1             RRT
014800030109     C                   IF        RRT = 1
014900030109     C                   Z-ADD     RRT           SFLPOS
015000030109     C                   ENDIF
015100030109     C                   MOVE      *BLANKS       SEL
015200030109     C                   MOVEL(P)  SACODE        SFCODE
015300030109     C                   MOVEL(P)  SANAME1       SFNAME1
015400030109     C                   IF        SAEFFDTE > 0
015500030109     C     SAEFFDTE      MULT      10000.0001    SFEFF
015600030109     C                   ELSE
015700030109     C                   Z-ADD     SAEFFDTE      SFEFF
015800030109     C                   ENDIF
015900030109     C                   IF        SATRMDTE > 0
016000030109     C     SATRMDTE      MULT      10000.0001    SFTRM
016100030109     C                   ELSE
016200030109     C                   Z-ADD     SATRMDTE      SFTRM
016300030109     C                   ENDIF
016400030109     C                   WRITE     POPUP
016500030109     C                   ADD       1             #CNTREC
016600030109    ***
016700030109     C                   ENDSR
016800030109   S***S
016900030109     C     $STEP1        BEGSR
017000030109    ***
017100030109     C                   WRITE     JUNK
017200030109     C                   EXFMT     WDWCTL
017300030109    ***
017400030109     C                   IF        FKEY = F1
017500030429     C                   MOVEL(P)  '*LR'         p@3
017600030109     C                   EVAL      @STEP = 'LEAVE'
017700030109     C                   LEAVESR
017800030109     C                   ENDIF
017900030109    ***
018000030109     C                   IF        FKEY = F2
018100030109     C*
018200030109     C                   IF        *IN30 = *ON
018300030109     C                   EVAL      *IN30 = *OFF
018400030109     C                   ELSE
018500030109     C                   EVAL      *IN30 = *ON
018600030109     C                   ENDIF
018700030109     C*
018800030109     C                   EVAL      I_NAME = *BLANKS
018900030109     C                   EVAL      I_CODE = *BLANKS
019000030109     C*
019100030109     C                   EVAL      @STEP = 'PREP1'
019200030109     C                   LEAVESR
019300030109     C*
019400030109     C                   ENDIF
019500030109    ***
019600030109     C                   SELECT
019700030109     C*
019800030109     C                   WHEN      *IN30 = *OFF AND I_NAME <> *BLANKS
019900030109     C                   EXSR      $BUILDSFL
020000030109     C                   MOVE      *BLANKS       I_NAME
020100030109     C                   LEAVESR
020200030109     C*
020300030109     C                   WHEN      *IN30 = *ON  AND I_CODE <> *BLANKS
020400030109     C                   EXSR      $BUILDSFL
020500030109     C                   MOVE      *BLANKS       I_CODE
020600030109     C                   LEAVESR
020700030109     C*
020800030109     C                   ENDSL
020900030109    ***
021000030109     C                   EXSR      $CHKSEL
021100030109    ***
021200030109     C                   ENDSR
021300030109   S***S
021400030109     C     $CHKSEL       BEGSR
021500030109    ***
021600030109     C                   MOVE      *OFF          *IN99
021700030109    ***
021800030109     C                   DOU       *IN99 = *ON
021900030109     C                   READC     POPUP                                  99
022000030109     C                   IF        *IN99 = *OFF AND SEL <> *BLANKS
022100030109    ***
022200030109     C                   MOVE      *ON           *IN99
022300030429     C                   MOVEL(P)  SFCODE        p@3
022400030109     C                   EVAL      @STEP = 'LEAVE'
022500030109    ***
022600030109     C                   ENDIF
022700030109     C                   ENDDO
022800030109     C*
022900030109     C                   ENDSR
023000030109   S***S
