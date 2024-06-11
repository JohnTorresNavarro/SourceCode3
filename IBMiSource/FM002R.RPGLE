000100991124     F*-------------------------------------------------------------------------
000200000218     F* FM002      INNOVATIVE OUTSOURCING SOFTWARE 2000
000300991124     F*            WRITTEN BY - S.S.K.
000400000211     F*            DATE - 02/00
000500000217     F*  DESCRIPTION - DISPLAY CODE RECORDS FROM CARRIER CODES FILE
000600991124     F*  INDICATOR USAGE:
000700991124     F*    03 = EXIT FROM INITIAL SCREEN
000800991124     F*    25 = SFLDSP
000900991124     F*    26 = SFL DSP CTL
001000991124     F*    27 = SFL CLR
001100991124     F*
001200991124     F*-------------------------------------------------------------------------
001300991209     ** MODIFICATION HISTORY                                              **
001400991209     ** ###  UUU  MMDDCCYY  X---->                                        **
001500000217     ** 000  SSK  02172000  ORIGINAL SOURCE                               **
001600991209     **                                                                   **
001700991209     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001800000217     FCARMST    IF   E           K DISK
001900000428     FFM002D    CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
002000991124   X***X
002100991216     D WSDS            DS
002200991216     D  FKEY                 369    369A
002300991216    ***
002400991216     D  F1             C                   CONST(X'31')
002500991216     D  F2             C                   CONST(X'32')
002600991216     D  F3             C                   CONST(X'33')
002700991216     D  F4             C                   CONST(X'34')
002800991216     D  F5             C                   CONST(X'35')
002900991216     D  F6             C                   CONST(X'36')
003000991216     D  F7             C                   CONST(X'37')
003100991216     D  F8             C                   CONST(X'38')
003200991216     D  F9             C                   CONST(X'39')
003300991216     D  F10            C                   CONST(X'3A')
003400991216     D  F11            C                   CONST(X'3B')
003500991216     D  F12            C                   CONST(X'3C')
003600991216     D  F13            C                   CONST(X'B1')
003700991216     D  F14            C                   CONST(X'B2')
003800991216     D  F15            C                   CONST(X'B3')
003900991216     D  F16            C                   CONST(X'B4')
004000991216     D  F17            C                   CONST(X'B5')
004100991216     D  F18            C                   CONST(X'B6')
004200991216     D  F19            C                   CONST(X'B7')
004300991216     D  F20            C                   CONST(X'B8')
004400991216     D  F21            C                   CONST(X'B9')
004500991216     D  F22            C                   CONST(X'BA')
004600991216     D  F23            C                   CONST(X'BB')
004700991216     D  F24            C                   CONST(X'BC')
004800991124   X***X
004900991124     C* MAINLINE
005000991124    ***
005100991124     C                   EXSR      ONCE
005200991124     C*
005300991216     C                   DOU       @EXIT = '1'
005400991124     C*
005500000217     C                   IF        FKEY = F1
005600000217     C                   MOVE      '1'           @EXIT
005700000217     C                   MOVE      '*LR'         @PARM
005800000217     C                   ELSE
005900000217     C                   EXSR      $CHKSEL
006000000217     C                   ENDIF
006100991124     C*
006200000217     C                   IF        @EXIT = '0'
006300000217     C                   WRITE     JUNK
006400000217     C                   EXFMT     WDWCTL
006500991124     C                   ENDIF
006600991124     C*
006700991124     C                   ENDDO
006800991124     C*
006900991124     C                   MOVE      *ON           *INLR
007000991124     C                   RETURN
007100991124   S***S
007200991124     C* ONETIME ROUTINE
007300991124    ***
007400991124     C     ONCE          BEGSR
007500000211    ***
007600000211     C     *ENTRY        PLIST
007700000217     C                   PARM                    @PARM             3
007800000217     C                   MOVEL(P)  @PARM         @KEYPRM           1
007900000217    ***
008000000217     C                   MOVE      '0'           @EXIT             1
008100000217     C                   MOVE      *ZEROS        RRT               4 0
008200000211    ***
008300000217     C                   MOVEA     '011'         *IN(25)
008400000217     C                   WRITE     WDWCTL
008500000217     C                   MOVEA     '010'         *IN(25)
008600000217     C*
008700010322     C                   MOVE      *ZEROS        #CNTREC           3 0
008800010103     C                   MOVE      '  A'         @3KEY             3
008900000217     C*
009000000217     C
009100010103     C     @3KEY         SETLL     CARMSR
009200150623     C                   DOU       %EOF(CARMST) OR #CNTREC = 9999
009300000217     C                   READ      CARMSR
009400010123     C                   IF        NOT %EOF(CARMST) AND CADLTD = 'A'
009500000217     C                   MOVE      *ON           *IN25
009600000217     C                   ADD       1             RRT
009700000217     C                   IF        RRT = 1
009800000217     C                   Z-ADD     RRT           SFLPOS
009900000217     C                   ENDIF
010000000217     C                   MOVE      *BLANKS       SEL
010100000217     C                   WRITE     POPUP
010200000217     C                   ADD       1             #CNTREC
010300000217     C                   ENDIF
010400000217     C                   ENDDO
010500000217     C*
010600020221     C                   IF        RRT > 6
010700020221     C                   MOVE      *ON           *IN91
010800020221     C                   ENDIF
010900020221     C*
011000000217     C                   WRITE     JUNK
011100000217     C                   EXFMT     WDWCTL
011200991124    ***
011300991124     C                   ENDSR
011400991124   S***S
011500000217     C     $CHKSEL       BEGSR
011600000217     C*
011700000217     C                   MOVE      *OFF          *IN33
011800000217     C                   DOU       *IN33 = *ON
011900000217     C                   READC     POPUP                                  33
012000000217     C                   IF        *IN33 = *OFF AND SEL <> *BLANKS
012100000217     C                   MOVE      *ON           *IN33
012200000217     C                   MOVEL(P)  CARRCD        @PARM
012300000217     C                   MOVE      '1'           @EXIT
012400000217     C                   ENDIF
012500000217     C                   ENDDO
012600000217     C*
012700000217     C                   ENDSR
012800000217     C**************************************************************************
