000100001222     F*-------------------------------------------------------------------------
000200001222     ** MODIFICATION HISTORY                                              **
000300001222     ** ###  UUU  MMDDCCYY  X---->                                        **
000400011022     ** 000  SSK  10222001  ORIGINAL SOURCE                               **
000500001222     **                                                                   **
000600001222     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
000700011022     FNXTPLN0   IF   E           K DISK
000800011022     FFM451D    CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
000900001222   X***X
001000001222     D WSDS            DS
001100001222     D  FKEY                 369    369A
001200001222    ***
001300001222     D  F1             C                   CONST(X'31')
001400001222     D  F2             C                   CONST(X'32')
001500001222     D  F3             C                   CONST(X'33')
001600001222     D  F4             C                   CONST(X'34')
001700001222     D  F5             C                   CONST(X'35')
001800001222     D  F6             C                   CONST(X'36')
001900001222     D  F7             C                   CONST(X'37')
002000001222     D  F8             C                   CONST(X'38')
002100001222     D  F9             C                   CONST(X'39')
002200001222     D  F10            C                   CONST(X'3A')
002300001222     D  F11            C                   CONST(X'3B')
002400001222     D  F12            C                   CONST(X'3C')
002500001222     D  F13            C                   CONST(X'B1')
002600001222     D  F14            C                   CONST(X'B2')
002700001222     D  F15            C                   CONST(X'B3')
002800001222     D  F16            C                   CONST(X'B4')
002900001222     D  F17            C                   CONST(X'B5')
003000001222     D  F18            C                   CONST(X'B6')
003100001222     D  F19            C                   CONST(X'B7')
003200001222     D  F20            C                   CONST(X'B8')
003300001222     D  F21            C                   CONST(X'B9')
003400001222     D  F22            C                   CONST(X'BA')
003500001222     D  F23            C                   CONST(X'BB')
003600001222     D  F24            C                   CONST(X'BC')
003700011022     D DS@PRM        E DS                  EXTNAME(NXTPLN0)
003800001222   X***X
003900001222     C* MAINLINE
004000001222    ***
004100001222     C                   EXSR      ONCE
004200001222     C*
004300001222     C                   DOU       @EXIT = '1'
004400001222     C*
004500001222     C                   IF        FKEY = F1
004600001222     C                   MOVE      '1'           @EXIT
004700011022     C                   MOVEL(P)  '*LR'         @PARM
004800001222     C                   ELSE
004900001222     C                   EXSR      $CHKSEL
005000001222     C                   ENDIF
005100001222     C*
005200001222     C                   IF        @EXIT = '0'
005300001222     C*
005400001222     C                   WRITE     JUNK
005500001222     C                   EXFMT     WDWCTL
005600001222     C*
005700001222     C                   ENDIF
005800001222     C*
005900001222     C                   ENDDO
006000001222     C*
006100001222     C                   MOVE      *ON           *INLR
006200001222     C                   RETURN
006300001222   S***S
006400001222     C* ONETIME ROUTINE
006500001222    ***
006600001222     C     ONCE          BEGSR
006700001222    ***
006800001222     C     *ENTRY        PLIST
006900011022     C                   PARM                    @PARM            18
007000001222    ***
007100001222     C                   MOVE      '0'           @EXIT             1
007200001222    ***
007300001222     C                   EXSR      $BUILDSFL
007400001222    ***
007500001222     C                   WRITE     JUNK
007600001222     C                   EXFMT     WDWCTL
007700001222    ***
007800001222     C                   ENDSR
007900001222   S***S
008000001222     C     $CHKSEL       BEGSR
008100001222     C*
008200001222     C                   MOVE      *OFF          *IN33
008300001222     C                   DOU       *IN33 = *ON
008400001222     C                   READC     POPUP                                  33
008500001222     C                   IF        *IN33 = *OFF AND SEL <> *BLANKS
008600001222     C                   MOVE      *ON           *IN33
008700011022     C                   EVAL      @PARM = DS@PRM
008800001222     C                   MOVE      '1'           @EXIT
008900001222     C                   ENDIF
009000001222     C                   ENDDO
009100001222     C*
009200001222     C                   ENDSR
009300001222   S***S
009400001222     C     $BUILDSFL     BEGSR
009500001222    ***
009600001222     C                   MOVE      *ZEROS        RRT               4 0
009700001222    ***
009800001222     C                   MOVEA     '011'         *IN(25)
009900001222     C                   WRITE     WDWCTL
010000001222     C                   MOVEA     '010'         *IN(25)
010100001222     C*
010200010322     C                   MOVE      *ZEROS        #CNTREC           3 0
010300001222     C*
010400011022     C                   DOU       %EOF(NXTPLN0) OR #CNTREC = 600
010500011022     C                   READ      NPF
010600011022     C                   IF        NOT %EOF(NXTPLN0)
010700001222     C                   MOVE      *ON           *IN25
010800001222     C                   ADD       1             RRT
010900001222     C                   IF        RRT = 1
011000001222     C                   Z-ADD     RRT           SFLPOS
011100001222     C                   ENDIF
011200001222     C                   MOVE      *BLANKS       SEL
011300011022     C                   MOVE      NPTRS         SFTRS
011400011022     C                   MOVE      NPSUB         SFSUB
011500011022     C                   MOVEL(P)  NPPLN         SFPLN
011600011022     C                   MOVE      NPYR          SFYR
011700011022     C                   MOVEL(P)  NPNEW         SFNEW
011800001222     C                   WRITE     POPUP
011900001222     C                   ADD       1             #CNTREC
012000001222     C                   ENDIF
012100001222     C                   ENDDO
012200001222    ***
012300001222     C                   ENDSR
