000100001222     F*-------------------------------------------------------------------------
000200010914     F* FM009      INNOVATIVE OUTSOURCING SOFTWARE 2000
000300001222     F*            WRITTEN BY - S.S.K.
000400010914     F*            DATE - 09/01
000500010914     F*  DESCRIPTION - DISPLAY ID CARD FORM TYPES TO SELECT FROM
000600001222     F*  INDICATOR USAGE:
000700001222     F*    03 = EXIT FROM INITIAL SCREEN
000800001222     F*    25 = SFLDSP
000900001222     F*    26 = SFL DSP CTL
001000001222     F*    27 = SFL CLR
001100001222     F*
001200001222     F*-------------------------------------------------------------------------
001300001222     ** MODIFICATION HISTORY                                              **
001400001222     ** ###  UUU  MMDDCCYY  X---->                                        **
001500010914     ** 000  SSK  09142001  ORIGINAL SOURCE                               **
001600001222     **                                                                   **
001700001222     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001800010914     FNIDCTRL   IF   E           K DISK
001900010914     FFM009D    CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
002000001222   X***X
002100001222     D                 DS
002200010914     D @KEY                    1      3A
002300010914     D @K5                     1      3A
002400001222    ***
002500001222     D WSDS            DS
002600001222     D  FKEY                 369    369A
002700001222    ***
002800001222     D  F1             C                   CONST(X'31')
002900001222     D  F2             C                   CONST(X'32')
003000001222     D  F3             C                   CONST(X'33')
003100001222     D  F4             C                   CONST(X'34')
003200001222     D  F5             C                   CONST(X'35')
003300001222     D  F6             C                   CONST(X'36')
003400001222     D  F7             C                   CONST(X'37')
003500001222     D  F8             C                   CONST(X'38')
003600001222     D  F9             C                   CONST(X'39')
003700001222     D  F10            C                   CONST(X'3A')
003800001222     D  F11            C                   CONST(X'3B')
003900001222     D  F12            C                   CONST(X'3C')
004000001222     D  F13            C                   CONST(X'B1')
004100001222     D  F14            C                   CONST(X'B2')
004200001222     D  F15            C                   CONST(X'B3')
004300001222     D  F16            C                   CONST(X'B4')
004400001222     D  F17            C                   CONST(X'B5')
004500001222     D  F18            C                   CONST(X'B6')
004600001222     D  F19            C                   CONST(X'B7')
004700001222     D  F20            C                   CONST(X'B8')
004800001222     D  F21            C                   CONST(X'B9')
004900001222     D  F22            C                   CONST(X'BA')
005000001222     D  F23            C                   CONST(X'BB')
005100001222     D  F24            C                   CONST(X'BC')
005200001222   X***X
005300001222     C* MAINLINE
005400001222    ***
005500001222     C                   EXSR      ONCE
005600001222     C*
005700001222     C                   DOU       @EXIT = '1'
005800001222     C*
005900001222     C                   IF        FKEY = F1
006000001222     C                   MOVE      '1'           @EXIT
006100001222     C                   MOVE      '*LR'         @PARM
006200001222     C                   ELSE
006300001222     C                   EXSR      $CHKSEL
006400001222     C                   ENDIF
006500001222     C*
006600001222     C                   IF        @EXIT = '0'
006700001222     C*
006800001222     C                   IF        PRTKEY <> @K5
006900001222     C                   MOVEL(P)  PRTKEY        @K5
007000001222     C                   EXSR      $BUILDSFL
007100001222     C                   ENDIF
007200001222     C*
007300001222     C                   WRITE     JUNK
007400001222     C                   EXFMT     WDWCTL
007500001222     C*
007600001222     C                   ENDIF
007700001222     C*
007800001222     C                   ENDDO
007900001222     C*
008000001222     C                   MOVE      *ON           *INLR
008100001222     C                   RETURN
008200001222   S***S
008300001222     C* ONETIME ROUTINE
008400001222    ***
008500001222     C     ONCE          BEGSR
008600001222    ***
008700001222     C     *ENTRY        PLIST
008800001222     C                   PARM                    @PARM             3
008900001222    ***
009000001222     C                   MOVE      '0'           @EXIT             1
009100001222    ***
009200010914     C                   MOVE      '  A'         @K5
009300010914     C                   MOVEL     '  A'         PRTKEY
009400001222     C                   EXSR      $BUILDSFL
009500001222    ***
009600001222     C                   WRITE     JUNK
009700001222     C                   EXFMT     WDWCTL
009800001222    ***
009900001222     C                   ENDSR
010000001222   S***S
010100001222     C     $CHKSEL       BEGSR
010200001222     C*
010300001222     C                   MOVE      *OFF          *IN33
010400001222     C                   DOU       *IN33 = *ON
010500001222     C                   READC     POPUP                                  33
010600001222     C                   IF        *IN33 = *OFF AND SEL <> *BLANKS
010700001222     C                   MOVE      *ON           *IN33
010800010914     C                   MOVEL(P)  SFCODE        @PARM
010900001222     C                   MOVE      '1'           @EXIT
011000001222     C                   ENDIF
011100001222     C                   ENDDO
011200001222     C*
011300001222     C                   ENDSR
011400001222   S***S
011500001222     C     $BUILDSFL     BEGSR
011600001222    ***
011700001222     C                   MOVE      *ZEROS        RRT               4 0
011800001222    ***
011900001222     C                   MOVEA     '011'         *IN(25)
012000001222     C                   WRITE     WDWCTL
012100001222     C                   MOVEA     '010'         *IN(25)
012200001222     C*
012300010322     C                   MOVE      *ZEROS        #CNTREC           3 0
012400001222     C*
012500010914     C     @KEY          SETLL     IDCTRR
012600010914     C                   DOU       %EOF(NIDCTRL) OR #CNTREC = 600
012700010914     C                   READ      IDCTRR
012800010914     C                   IF        NOT %EOF(NIDCTRL)
012900001222     C                   MOVE      *ON           *IN25
013000001222     C                   ADD       1             RRT
013100001222     C                   IF        RRT = 1
013200001222     C                   Z-ADD     RRT           SFLPOS
013300001222     C                   ENDIF
013400001222     C                   MOVE      *BLANKS       SEL
013500010914     C                   MOVEL(P)  ICODE         SFCODE
013600010914     C                   MOVEL(P)  IDESC         SFDESC
013700001222     C                   WRITE     POPUP
013800001222     C                   ADD       1             #CNTREC
013900001222     C                   ENDIF
014000001222     C                   ENDDO
014100001222    ***
014200001222     C                   ENDSR
