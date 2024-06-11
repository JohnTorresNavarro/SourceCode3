000100001207     F*-------------------------------------------------------------------------
000200001207     F* FM003      INNOVATIVE OUTSOURCING SOFTWARE 2000
000300001207     F*            WRITTEN BY - S.S.K.
000400001207     F*            DATE - 12/00
000500001207     F*  DESCRIPTION - DISPLAY SMAN RECORDS FROM SALESMAN CODE FILE
000600001207     F*  INDICATOR USAGE:
000700001207     F*    03 = EXIT FROM INITIAL SCREEN
000800001207     F*    25 = SFLDSP
000900001207     F*    26 = SFL DSP CTL
001000001207     F*    27 = SFL CLR
001100001207     F*
001200001207     F*-------------------------------------------------------------------------
001300001207     ** MODIFICATION HISTORY                                              **
001400001207     ** ###  UUU  MMDDCCYY  X---->                                        **
001500001207     ** 000  SSK  12072000  ORIGINAL SOURCE                               **
001600001207     **                                                                   **
001700001207     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001800001207     FSMANL1    IF   E           K DISK
001900001207     FFM003D    CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
002000001207   X***X
002100001207     D                 DS
002200001207     D @KEY                    1     18A
002300001207     D @K5                     1      5A
002400001207    ***
002500001207     D WSDS            DS
002600001207     D  FKEY                 369    369A
002700001207    ***
002800001207     D  F1             C                   CONST(X'31')
002900001207     D  F2             C                   CONST(X'32')
003000001207     D  F3             C                   CONST(X'33')
003100001207     D  F4             C                   CONST(X'34')
003200001207     D  F5             C                   CONST(X'35')
003300001207     D  F6             C                   CONST(X'36')
003400001207     D  F7             C                   CONST(X'37')
003500001207     D  F8             C                   CONST(X'38')
003600001207     D  F9             C                   CONST(X'39')
003700001207     D  F10            C                   CONST(X'3A')
003800001207     D  F11            C                   CONST(X'3B')
003900001207     D  F12            C                   CONST(X'3C')
004000001207     D  F13            C                   CONST(X'B1')
004100001207     D  F14            C                   CONST(X'B2')
004200001207     D  F15            C                   CONST(X'B3')
004300001207     D  F16            C                   CONST(X'B4')
004400001207     D  F17            C                   CONST(X'B5')
004500001207     D  F18            C                   CONST(X'B6')
004600001207     D  F19            C                   CONST(X'B7')
004700001207     D  F20            C                   CONST(X'B8')
004800001207     D  F21            C                   CONST(X'B9')
004900001207     D  F22            C                   CONST(X'BA')
005000001207     D  F23            C                   CONST(X'BB')
005100001207     D  F24            C                   CONST(X'BC')
005200001207   X***X
005300001207     C* MAINLINE
005400001207    ***
005500001207     C                   EXSR      ONCE
005600001207     C*
005700001207     C                   DOU       @EXIT = '1'
005800001207     C*
005900001207     C                   IF        FKEY = F1
006000001207     C                   MOVE      '1'           @EXIT
006100001207     C                   MOVE      '*LR'         @PARM
006200001207     C                   ELSE
006300001207     C                   EXSR      $CHKSEL
006400001207     C                   ENDIF
006500001207     C*
006600001207     C                   IF        @EXIT = '0'
006700001207     C*
006800001207     C                   IF        PRTKEY <> @K5
006900001207     C                   MOVEL(P)  PRTKEY        @K5
007000001207     C                   EXSR      $BUILDSFL
007100001207     C                   ENDIF
007200001207     C*
007300001207     C                   WRITE     JUNK
007400001207     C                   EXFMT     WDWCTL
007500001207     C*
007600001207     C                   ENDIF
007700001207     C*
007800001207     C                   ENDDO
007900001207     C*
008000001207     C                   MOVE      *ON           *INLR
008100001207     C                   RETURN
008200001207   S***S
008300001207     C* ONETIME ROUTINE
008400001207    ***
008500001207     C     ONCE          BEGSR
008600001207    ***
008700001207     C     *ENTRY        PLIST
008800001207     C                   PARM                    @PARM             3
008900001207    ***
009000001207     C                   MOVE      '0'           @EXIT             1
009100001207    ***
009200001207     C                   MOVEL     'A'           @K5
009300001207     C                   MOVEL     'A'           PRTKEY
009400001207     C                   EXSR      $BUILDSFL
009500001207    ***
009600001207     C                   WRITE     JUNK
009700001207     C                   EXFMT     WDWCTL
009800001207    ***
009900001207     C                   ENDSR
010000001207   S***S
010100001207     C     $CHKSEL       BEGSR
010200001207     C*
010300001207     C                   MOVE      *OFF          *IN33
010400001207     C                   DOU       *IN33 = *ON
010500001207     C                   READC     POPUP                                  33
010600001207     C                   IF        *IN33 = *OFF AND SEL <> *BLANKS
010700001207     C                   MOVE      *ON           *IN33
010800001207     C                   MOVEL(P)  SFCODE        @PARM
010900001207     C                   MOVE      '1'           @EXIT
011000001207     C                   ENDIF
011100001207     C                   ENDDO
011200001207     C*
011300001207     C                   ENDSR
011400001207   S***S
011500001207     C     $BUILDSFL     BEGSR
011600001207    ***
011700001207     C                   MOVE      *ZEROS        RRT               4 0
011800001207    ***
011900001207     C                   MOVEA     '011'         *IN(25)
012000001207     C                   WRITE     WDWCTL
012100001207     C                   MOVEA     '010'         *IN(25)
012200001207     C*
012300010322     C                   MOVE      *ZEROS        #CNTREC           3 0
012400001207     C*
012500001207     C     @KEY          SETLL     SMANR
012600001207     C                   DOU       %EOF(SMANL1) OR #CNTREC = 600
012700001207     C                   READ      SMANR
012800001207     C                   IF        NOT %EOF(SMANL1)
012900001207     C                   MOVE      *ON           *IN25
013000001207     C                   ADD       1             RRT
013100001207     C                   IF        RRT = 1
013200001207     C                   Z-ADD     RRT           SFLPOS
013300001207     C                   ENDIF
013400001207     C                   MOVE      *BLANKS       SEL
013500001207     C                   MOVEL(P)  SMANCD        SFCODE
013600001207     C                   MOVEL(P)  SLNAME        SFLNAM
013700001207     C                   MOVEL(P)  SFNAME        SFFNAM
013800001207     C                   MOVEL(P)  SMI           SFMIDI
013900001207     C                   WRITE     POPUP
014000001207     C                   ADD       1             #CNTREC
014100001207     C                   ENDIF
014200001207     C                   ENDDO
014300020221    ***
014400020221     C                   IF        RRT > 6
014500020221     C                   EVAL      *IN91 = *ON
014600020221     C                   ENDIF
014700001207    ***
014800001207     C                   ENDSR
