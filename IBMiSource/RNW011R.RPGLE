000100060710     FRNW011D   CF   E             WORKSTN INFDS(WSDS)
000200020502   X***X
000300060710     D #ISO            S               D   DATFMT(*ISO)
000400060710    ***
000500060710     D WSDS            DS
000600060710     D  FKEY                 369    369A
000700060710    ***
000800060710     D  F1             C                   CONST(X'31')
000900060710     D  F2             C                   CONST(X'32')
001000060710     D  F3             C                   CONST(X'33')
001100060710     D  F4             C                   CONST(X'34')
001200060710     D  F5             C                   CONST(X'35')
001300060710     D  F6             C                   CONST(X'36')
001400060710     D  F7             C                   CONST(X'37')
001500060710     D  F8             C                   CONST(X'38')
001600060710     D  F9             C                   CONST(X'39')
001700060710     D  F10            C                   CONST(X'3A')
001800060710     D  F11            C                   CONST(X'3B')
001900060710     D  F12            C                   CONST(X'3C')
002000060710     D  F13            C                   CONST(X'B1')
002100060710     D  F14            C                   CONST(X'B2')
002200060710     D  F15            C                   CONST(X'B3')
002300060710     D  F16            C                   CONST(X'B4')
002400060710     D  F17            C                   CONST(X'B5')
002500060710     D  F18            C                   CONST(X'B6')
002600060710     D  F19            C                   CONST(X'B7')
002700060710     D  F20            C                   CONST(X'B8')
002800060710     D  F21            C                   CONST(X'B9')
002900060710     D  F22            C                   CONST(X'BA')
003000060710     D  F23            C                   CONST(X'BB')
003100060710     D  F24            C                   CONST(X'BC')
003200020502   X***X
003300060710     C     *ENTRY        PLIST
003400060710     C                   PARM                    PARM_OUT          8
003500060710     C                   EVAL      RUNMONTH = 01
003600060710     C                   EXSR      $A
003700060710    ***
003800060710     C                   MOVE      *ON           *INLR
003900060710     C                   RETURN
004000060710   X***X
004100060710     C     $A            BEGSR
004200060710    ***
004300060710     C                   EXFMT     SCREEN
004400060710    ***
004500060710     C                   IF        FKEY = F3
004600060710     C                   EVAL      PARM_OUT = '********'
004700060710     C                   LEAVESR
004800060710     C                   ENDIF
004900060710    ***
005000101110     C                   IF        FKEY = F5
005100101110     C                   CALL      'WRKGRWCL'
005200101110     C                   ENDIF
005300101110    ***
005400060710     C                   MOVE      RUNMONTH      PARM_O            2
005500060710     C                   EVAL      EMSG = 'PRESS ENTER TO CONFIRM MONTH'
005600060710     C                   EXSR      $B
005700060710    ***
005800060710     C                   ENDSR
005900060710   S***S
006000060710     C     $B            BEGSR
006100060710    ***
006200060710     C                   DOU       FKEY = F3
006300060710    ***
006400060710     C                   EXFMT     SCREEN
006500060710    * *
006600060710     C                   IF        FKEY = F3
006700060710     C                   EVAL      PARM_OUT = '********'
006800060710     C                   LEAVESR
006900060710     C                   ENDIF
007000060710    * *
007100101110     C                   IF        FKEY = F5
007200101110     C                   CALL      'WRKGRWCL'
007300101110     C                   ITER
007400101110     C                   ENDIF
007500101110    ***
007600060710     C                   MOVE      RUNMONTH      @2                2
007700060710    * *
007800060710     C                   IF        @2 = PARM_O
007900060710     C                   MOVE      *DATE         #ISO
008000060710     C                   EXTRCT    #ISO:*M       R#                2 0
008100060710     C                   EXTRCT    #ISO:*Y       Y#                4 0
008200060710     C                   MOVE      R#            R@                2
008300060710     C                   MOVE      Y#            Y@                4
008400060710     C                   IF        R@ < @2
008500060710     C                   EVAL      PARM_OUT = Y@ + PARM_O + '01'
008600060710     C                   ELSE
008700060710     C                   ADD       1             Y#
008800060710     C                   MOVE      Y#            Y@                4
008900060710     C                   EVAL      PARM_OUT = Y@ + PARM_O + '01'
009000060710     C                   ENDIF
009100060710     C                   LEAVESR
009200060710     C                   ENDIF
009300060710    ***
009400060710     C                   ENDDO
009500040617    ***
009600060710     C                   ENDSR
009700020502   S***S
