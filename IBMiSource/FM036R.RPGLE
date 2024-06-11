000100001222     F*-------------------------------------------------------------------------
000200131126     F* FM036      INNOVATIVE OUTSOURCING SOFTWARE 2002
000300131126     F*            WRITTEN BY - R.L.J.
000400131126     F*            DATE - 11/2013
000500131126     F*  DESCRIPTION - DISPLAY CARRIER ENTITY SELECTION WINDOW
000600001222     F*  INDICATOR USAGE:
000700001222     F*    03 = EXIT FROM INITIAL SCREEN
000800001222     F*    25 = SFLDSP
000900001222     F*    26 = SFL DSP CTL
001000001222     F*    27 = SFL CLR
001100001222     F*
001200001222     F*-------------------------------------------------------------------------
001300001222     ** MODIFICATION HISTORY                                              **
001400001222     ** ###  UUU  MMDDCCYY  X---->                                        **
001500001222     **                                                                   **
001600001222     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001700131126     FFM036D    CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
001800001222   X***X
001900001222     D WSDS            DS
002000001222     D  FKEY                 369    369A
002100001222    ***
002200001222     D  F1             C                   CONST(X'31')
002300001222     D  F2             C                   CONST(X'32')
002400001222     D  F3             C                   CONST(X'33')
002500001222     D  F4             C                   CONST(X'34')
002600001222     D  F5             C                   CONST(X'35')
002700001222     D  F6             C                   CONST(X'36')
002800001222     D  F7             C                   CONST(X'37')
002900001222     D  F8             C                   CONST(X'38')
003000001222     D  F9             C                   CONST(X'39')
003100001222     D  F10            C                   CONST(X'3A')
003200001222     D  F11            C                   CONST(X'3B')
003300001222     D  F12            C                   CONST(X'3C')
003400001222     D  F13            C                   CONST(X'B1')
003500001222     D  F14            C                   CONST(X'B2')
003600001222     D  F15            C                   CONST(X'B3')
003700001222     D  F16            C                   CONST(X'B4')
003800001222     D  F17            C                   CONST(X'B5')
003900001222     D  F18            C                   CONST(X'B6')
004000001222     D  F19            C                   CONST(X'B7')
004100001222     D  F20            C                   CONST(X'B8')
004200001222     D  F21            C                   CONST(X'B9')
004300001222     D  F22            C                   CONST(X'BA')
004400001222     D  F23            C                   CONST(X'BB')
004500001222     D  F24            C                   CONST(X'BC')
004600131126      *
0047001311260053 D                 DS
0048001311260054 D  invpln         C                   'INVALID TRUST/SUB#/PLAN     '
0049001311260054 D  adesc          C                   'BlueChoice,Inc= MD except PG & MO --
0050001311260054 D                                      all BC products        '
0051001311260054 D  bdesc          C                   'CFMI = MD except PG & MO - SPP, BP,-
0052001311260054 D                                      Reg Den & Blue Vis Plus'
0053001311260054 D  cdesc          C                   'GHMSI = DC/VA/PG/MO - SPP, BP, Reg -
0054001311260054 D                                     Dent & Blue Vis Plus    '
005500001222   X***X
005600001222     C* MAINLINE
005700001222    ***
005800001222     C                   EXSR      ONCE
005900001222     C*
006000001222     C                   DOU       @EXIT = '1'
006100001222     C*
006200001222     C                   IF        FKEY = F1
006300001222     C                   MOVE      '1'           @EXIT
006400020321     C                   MOVEL(P)  '*LR'         @PARM
006500001222     C                   ELSE
006600001222     C                   EXSR      $CHKSEL
006700001222     C                   ENDIF
006800001222     C*
006900001222     C                   IF        @EXIT = '0'
007000001222     C*
007100001222     C                   WRITE     JUNK
007200001222     C                   EXFMT     WDWCTL
007300001222     C*
007400001222     C                   ENDIF
007500001222     C*
007600001222     C                   ENDDO
007700001222     C*
007800001222     C                   MOVE      *ON           *INLR
007900001222     C                   RETURN
008000001222   S***S
008100001222     C* ONETIME ROUTINE
008200001222    ***
008300001222     C     ONCE          BEGSR
008400001222    ***
008500001222     C     *ENTRY        PLIST
008600131126     C                   PARM                    @PARM             1
008700001222    ***
008800001222     C                   MOVE      '0'           @EXIT             1
008900001222    ***
009000001222     C                   EXSR      $BUILDSFL
009100001222    ***
009200001222     C                   WRITE     JUNK
009300001222     C                   EXFMT     WDWCTL
009400001222    ***
009500001222     C                   ENDSR
009600001222   S***S
009700001222     C     $CHKSEL       BEGSR
009800001222     C*
009900001222     C                   MOVE      *OFF          *IN33
010000001222     C                   DOU       *IN33 = *ON
010100001222     C                   READC     POPUP                                  33
010200001222     C                   IF        *IN33 = *OFF AND SEL <> *BLANKS
010300001222     C                   MOVE      *ON           *IN33
010400131126     C                   MOVEL(P)  sfcode        @PARM
010500001222     C                   MOVE      '1'           @EXIT
010600001222     C                   ENDIF
010700001222     C                   ENDDO
010800001222     C*
010900001222     C                   ENDSR
011000001222   S***S
011100001222     C     $BUILDSFL     BEGSR
011200001222    ***
011300001222     C                   MOVE      *ZEROS        RRT               4 0
011400020321     C                   EVAL      *IN91 = *OFF
011500001222    ***
011600001222     C                   MOVEA     '011'         *IN(25)
011700001222     C                   WRITE     WDWCTL
011800001222     C                   MOVEA     '010'         *IN(25)
011900131126      *
012000010322     C                   MOVE      *ZEROS        #CNTREC           3 0
012100131126      *
012200131126     C                   MOVE      *ON           *IN25
012300131126     C                   ADD       1             RRT
012400131126     C                   IF        RRT = 1
012500131126     C                   Z-ADD     RRT           SFLPOS
012600131126     C                   ENDIF
012700131126     C                   MOVE      *BLANKS       SEL
012800131126     C                   eval      sfcode = 'A'
012900131126     C                   eval      sfdesc = adesc
013000131126     C                   WRITE     POPUP
013100131126     C                   ADD       1             #CNTREC
013200131126      *
013300131126     C                   ADD       1             RRT
013400131126     C                   MOVE      *BLANKS       SEL
013500131126     C                   eval      sfcode = 'B'
013600131126     C                   eval      sfdesc = bdesc
013700131126     C                   WRITE     POPUP
013800131126     C                   ADD       1             #CNTREC
013900131126      *
014000131126     C                   ADD       1             RRT
014100131126     C                   MOVE      *BLANKS       SEL
014200131126     C                   eval      sfcode = 'C'
014300131126     C                   eval      sfdesc = cdesc
014400131126     C                   WRITE     POPUP
014500131126     C                   ADD       1             #CNTREC
014600131126      *
014700020221     C                   IF        RRT > 6
014800020221     C                   EVAL      *IN91 = *ON
014900020221     C                   ENDIF
015000001222    ***
015100001222     C                   ENDSR
