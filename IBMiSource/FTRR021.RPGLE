000100100713     F*-------------------------------------------------------------------------
000200100713     ** MODIFICATION HISTORY                                              **
000300100713     ** ###  UUU  MMDDCCYY  X---->                                        **
000400100713     ** 000  SSK  07122010  ORIGINAL SOURCE                               **
000500100713     **                                                                   **
000600100713     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
000700100713     FFTRW020   IF   E           K DISK
000800100713     FFTRD021   CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
000900100713   X***X
001000100713     D @KEY            S              3A
001100100713    ***
001200100713     D WSDS            DS
001300100713     D  FKEY                 369    369A
001400100713    ***
001500100713     D  F1             C                   CONST(X'31')
001600100713     D  F2             C                   CONST(X'32')
001700100713     D  F3             C                   CONST(X'33')
001800100713     D  F4             C                   CONST(X'34')
001900100713     D  F5             C                   CONST(X'35')
002000100713     D  F6             C                   CONST(X'36')
002100100713     D  F7             C                   CONST(X'37')
002200100713     D  F8             C                   CONST(X'38')
002300100713     D  F9             C                   CONST(X'39')
002400100713     D  F10            C                   CONST(X'3A')
002500100713     D  F11            C                   CONST(X'3B')
002600100713     D  F12            C                   CONST(X'3C')
002700100713     D  F13            C                   CONST(X'B1')
002800100713     D  F14            C                   CONST(X'B2')
002900100713     D  F15            C                   CONST(X'B3')
003000100713     D  F16            C                   CONST(X'B4')
003100100713     D  F17            C                   CONST(X'B5')
003200100713     D  F18            C                   CONST(X'B6')
003300100713     D  F19            C                   CONST(X'B7')
003400100713     D  F20            C                   CONST(X'B8')
003500100713     D  F21            C                   CONST(X'B9')
003600100713     D  F22            C                   CONST(X'BA')
003700100713     D  F23            C                   CONST(X'BB')
003800100713     D  F24            C                   CONST(X'BC')
003900100713   X***X
004000100713     C* MAINLINE
004100100713    ***
004200100713     C                   EXSR      ONCE
004300100713     C*
004400100713     C                   DOU       @EXIT = '1'
004500100713     C*
004600100713     C                   IF        FKEY = F1
004700100713     C                   MOVE      '1'           @EXIT
004800100713     C                   MOVE      '*LR'         @PARM
004900100713     C                   ELSE
005000100713     C                   EXSR      $CHKSEL
005100100713     C                   ENDIF
005200100713     C*
005300100713     C                   IF        @EXIT = '0'
005400100713     C*
005500100713     C                   WRITE     JUNK
005600100713     C                   EXFMT     WDWCTL
005700100713     C*
005800100713     C                   ENDIF
005900100713     C*
006000100713     C                   ENDDO
006100100713     C*
006200100713     C                   MOVE      *ON           *INLR
006300100713     C                   RETURN
006400100713   S***S
006500100713     C* ONETIME ROUTINE
006600100713    ***
006700100713     C     ONCE          BEGSR
006800100713    ***
006900100713     C     *ENTRY        PLIST
007000100713     C                   PARM                    @PARM             3
007100100713    ***
007200100713     C                   MOVE      '0'           @EXIT             1
007300100713    ***
007400100713     C                   EXSR      $BUILDSFL
007500100713    ***
007600100713     C                   WRITE     JUNK
007700100713     C                   EXFMT     WDWCTL
007800100713    ***
007900100713     C                   ENDSR
008000100713   S***S
008100100713     C     $CHKSEL       BEGSR
008200100713     C*
008300100713     C                   MOVE      *OFF          *IN33
008400100713     C                   DOU       *IN33 = *ON
008500100713     C                   READC     POPUP                                  33
008600100713     C                   IF        *IN33 = *OFF AND SEL <> *BLANKS
008700100713     C                   MOVE      *ON           *IN33
008800100713     C                   MOVEL(P)  CDE           @PARM
008900100713     C                   MOVE      '1'           @EXIT
009000100713     C                   ENDIF
009100100713     C                   ENDDO
009200100713     C*
009300100713     C                   ENDSR
009400100713   S***S
009500100713     C     $BUILDSFL     BEGSR
009600100713    ***
009700100713     C                   MOVE      *ZEROS        RRT               4 0
009800100713    ***
009900100713     C                   MOVEA     '011'         *IN(25)
010000100713     C                   WRITE     WDWCTL
010100100713     C                   MOVEA     '010'         *IN(25)
010200100713     C*
010300100713     C                   MOVE      '*'           @KEY
010400100713     C                   MOVE      *ZEROS        #CNTREC           3 0
010500100713     C*
010600100713     C     @KEY          SETLL     FTRW020R
010700100713     C                   DOU       %EOF(FTRW020) OR #CNTREC = 700
010800100713     C                   READ      FTRW020R
010900100713     C                   IF        NOT %EOF(FTRW020)
011000100713     C                   MOVE      *ON           *IN25
011100100713     C                   ADD       1             RRT
011200100713     C                   IF        RRT = 1
011300100713     C                   Z-ADD     RRT           SFLPOS
011400100713     C                   ENDIF
011500100713     C                   MOVE      *BLANKS       SEL
011600100713     C                   EVAL      CDE = F2CODE
011700100713     C                   MOVEL(P)  F2DESC        DES
011800100713     C                   WRITE     POPUP
011900100713     C                   ADD       1             #CNTREC
012000100713     C                   ENDIF
012100100713     C                   ENDDO
012200100713    ***
012300100713     C                   IF        RRT > 7
012400100713     C                   EVAL      *IN91 = *ON
012500100713     C                   ENDIF
012600100713    ***
012700100713     C                   ENDSR
