000100001222     F*-------------------------------------------------------------------------
000200020321     F* FM034      INNOVATIVE OUTSOURCING SOFTWARE 2002
000300001222     F*            WRITTEN BY - S.S.K.
000400020321     F*            DATE - 03/02
000500020321     F*  DESCRIPTION - DISPLAY CLASS RECORDS FROM CLASS MASTER FILE
000600001222     F*  INDICATOR USAGE:
000700001222     F*    03 = EXIT FROM INITIAL SCREEN
000800001222     F*    25 = SFLDSP
000900001222     F*    26 = SFL DSP CTL
001000001222     F*    27 = SFL CLR
001100001222     F*
001200001222     F*-------------------------------------------------------------------------
001300001222     ** MODIFICATION HISTORY                                              **
001400001222     ** ###  UUU  MMDDCCYY  X---->                                        **
001500020321     ** 000  SSK  03212002  ORIGINAL SOURCE                               **
001501240105     **      jt   01052024  Recompiled to be able to view debug
001600240105     **                     and added extfile keyword                     **
001700001222     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001800240105     FCLASSMST  IF   E           K DISK    extfile('F.CLASSMST')
001900020321     FFM034D    CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
002000001222   X***X
002100001222     D WSDS            DS
002200001222     D  FKEY                 369    369A
002300001222    ***
002400001222     D  F1             C                   CONST(X'31')
002500001222     D  F2             C                   CONST(X'32')
002600001222     D  F3             C                   CONST(X'33')
002700001222     D  F4             C                   CONST(X'34')
002800001222     D  F5             C                   CONST(X'35')
002900001222     D  F6             C                   CONST(X'36')
003000001222     D  F7             C                   CONST(X'37')
003100001222     D  F8             C                   CONST(X'38')
003200001222     D  F9             C                   CONST(X'39')
003300001222     D  F10            C                   CONST(X'3A')
003400001222     D  F11            C                   CONST(X'3B')
003500001222     D  F12            C                   CONST(X'3C')
003600001222     D  F13            C                   CONST(X'B1')
003700001222     D  F14            C                   CONST(X'B2')
003800001222     D  F15            C                   CONST(X'B3')
003900001222     D  F16            C                   CONST(X'B4')
004000001222     D  F17            C                   CONST(X'B5')
004100001222     D  F18            C                   CONST(X'B6')
004200001222     D  F19            C                   CONST(X'B7')
004300001222     D  F20            C                   CONST(X'B8')
004400001222     D  F21            C                   CONST(X'B9')
004500001222     D  F22            C                   CONST(X'BA')
004600001222     D  F23            C                   CONST(X'BB')
004700001222     D  F24            C                   CONST(X'BC')
004800001222   X***X
004900001222     C* MAINLINE
005000001222    ***
005100001222     C                   EXSR      ONCE
005200001222     C*
005300001222     C                   DOU       @EXIT = '1'
005400001222     C*
005500001222     C                   IF        FKEY = F1
005600001222     C                   MOVE      '1'           @EXIT
005700020321     C                   MOVEL(P)  '*LR'         @PARM
005800001222     C                   ELSE
005900001222     C                   EXSR      $CHKSEL
006000001222     C                   ENDIF
006100001222     C*
006200001222     C                   IF        @EXIT = '0'
006300001222     C*
006400001222     C                   WRITE     JUNK
006500001222     C                   EXFMT     WDWCTL
006600001222     C*
006700001222     C                   ENDIF
006800001222     C*
006900001222     C                   ENDDO
007000001222     C*
007100001222     C                   MOVE      *ON           *INLR
007200001222     C                   RETURN
007300001222   S***S
007400001222     C* ONETIME ROUTINE
007500001222    ***
007600001222     C     ONCE          BEGSR
007700001222    ***
007800001222     C     *ENTRY        PLIST
007900020321     C                   PARM                    @PARM             4
008000001222    ***
008100001222     C                   MOVE      '0'           @EXIT             1
008200001222    ***
008300020321     C     *LIKE         DEFINE    CMCLASS       @KEY
008400020321     C                   MOVE      '0000'        @KEY
008500001222     C                   EXSR      $BUILDSFL
008600001222    ***
008700001222     C                   WRITE     JUNK
008800001222     C                   EXFMT     WDWCTL
008900001222    ***
009000001222     C                   ENDSR
009100001222   S***S
009200001222     C     $CHKSEL       BEGSR
009300001222     C*
009400001222     C                   MOVE      *OFF          *IN33
009500001222     C                   DOU       *IN33 = *ON
009600001222     C                   READC     POPUP                                  33
009700001222     C                   IF        *IN33 = *OFF AND SEL <> *BLANKS
009800001222     C                   MOVE      *ON           *IN33
009900020321     C                   MOVEL(P)  SFCLASS       @PARM
010000001222     C                   MOVE      '1'           @EXIT
010100001222     C                   ENDIF
010200001222     C                   ENDDO
010300001222     C*
010400001222     C                   ENDSR
010500001222   S***S
010600001222     C     $BUILDSFL     BEGSR
010700001222    ***
010800001222     C                   MOVE      *ZEROS        RRT               4 0
010900020321     C                   EVAL      *IN91 = *OFF
011000001222    ***
011100001222     C                   MOVEA     '011'         *IN(25)
011200001222     C                   WRITE     WDWCTL
011300001222     C                   MOVEA     '010'         *IN(25)
011400001222     C*
011500010322     C                   MOVE      *ZEROS        #CNTREC           3 0
011600001222     C*
011700020321     C     @KEY          SETLL     CMSTR
011800020321     C                   DOU       %EOF(CLASSMST) OR #CNTREC = 600
011900020321     C                   READ      CMSTR
012000020321     C                   IF        NOT %EOF(CLASSMST)
012100001222     C                   MOVE      *ON           *IN25
012200001222     C                   ADD       1             RRT
012300001222     C                   IF        RRT = 1
012400001222     C                   Z-ADD     RRT           SFLPOS
012500001222     C                   ENDIF
012600001222     C                   MOVE      *BLANKS       SEL
012700020321     C                   MOVE      CMCLASS       SFCLASS
012800001222     C                   WRITE     POPUP
012900001222     C                   ADD       1             #CNTREC
013000001222     C                   ENDIF
013100001222     C                   ENDDO
013200020221    ***
013300020221     C                   IF        RRT > 6
013400020221     C                   EVAL      *IN91 = *ON
013500020221     C                   ENDIF
013600001222    ***
013700001222     C                   ENDSR
