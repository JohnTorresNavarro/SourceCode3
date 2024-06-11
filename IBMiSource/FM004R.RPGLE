000100991124     F*-------------------------------------------------------------------------
000200001207     F* FM004      INNOVATIVE OUTSOURCING SOFTWARE 2000
000300991124     F*            WRITTEN BY - S.S.K.
000400001207     F*            DATE - 12/00
000500001207     F*  DESCRIPTION - DISPLAY PLAN RECORDS FROM PLAN MASTER
000600991124     F*  INDICATOR USAGE:
000700991124     F*    03 = EXIT FROM INITIAL SCREEN
000800991124     F*    25 = SFLDSP
000900991124     F*    26 = SFL DSP CTL
001000991124     F*    27 = SFL CLR
001100991124     F*
001200991124     F*-------------------------------------------------------------------------
001300991209     ** MODIFICATION HISTORY                                              **
001400991209     ** ###  UUU  MMDDCCYY  X---->                                        **
001500001207     ** 000  SSK  12072000  ORIGINAL SOURCE                               **
001600991209     **                                                                   **
001700991209     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001800001207     FPLNMST    IF   E           K DISK
001900001207     FFM004D    CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
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
004800001207    ***
004900010918     D @K5             S              4A
005000010918    ***
005100001207     D                 DS
005200001207     D @KEYPRM                 1     10A
005300001207     D #KT                     1      3S 0
005400001207     D #KS                     4      6S 0
005500001207     D @KP                     7     10A
005600991124   X***X
005700991124     C* MAINLINE
005800991124    ***
005900991124     C                   EXSR      ONCE
006000991124     C*
006100991216     C                   DOU       @EXIT = '1'
006200991124     C*
006300000217     C                   IF        FKEY = F1
006400000217     C                   MOVE      '1'           @EXIT
006500000217     C                   MOVE      '*LR'         @PARM
006600000217     C                   ELSE
006700000217     C                   EXSR      $CHKSEL
006800000217     C                   ENDIF
006900991124     C*
007000000217     C                   IF        @EXIT = '0'
007100010918     C*
007200010918     C                   IF        PRTKEY <> @K5
007300010918     C                   MOVEL(P)  PRTKEY        @K5
007400010918     C                   MOVEL(P)  PRTKEY        #KP
007500010918     C                   EXSR      $BUILDSFL
007600010918     C                   ENDIF
007700010918     C*
007800000217     C                   WRITE     JUNK
007900000217     C                   EXFMT     WDWCTL
008000010918     C*
008100991124     C                   ENDIF
008200991124     C*
008300991124     C                   ENDDO
008400991124     C*
008500991124     C                   MOVE      *ON           *INLR
008600991124     C                   RETURN
008700991124   S***S
008800991124     C* ONETIME ROUTINE
008900991124    ***
009000991124     C     ONCE          BEGSR
009100000211    ***
009200000211     C     *ENTRY        PLIST
009300001207     C                   PARM                    @PARM            10
009400001207     C                   MOVEL(P)  @PARM         @KEYPRM
009500001207    ***
009600001207     C     @KEY          KLIST
009700001207     C                   KFLD                    #KT
009800001207     C                   KFLD                    #KS
009900010918     C                   KFLD                    #KP               4
010000010918     C     @KEY2         KLIST
010100010918     C                   KFLD                    #KT
010200010918     C                   KFLD                    #KS
010300010918    ***
010400010918     C                   MOVE      '   A'        @K5
010500010918     C                   MOVEL     '   A'        PRTKEY
010600010918     C                   MOVE      '0'           @EXIT             1
010700010918     C                   EXSR      $BUILDSFL
010800000217    ***
010900010918     C                   WRITE     JUNK
011000010918     C                   EXFMT     WDWCTL
011100010918    ***
011200010918     C                   ENDSR
011300010918   S***S
011400010918     C     $BUILDSFL     BEGSR
011500010918    ***
011600000217     C                   MOVE      *ZEROS        RRT               4 0
011700000211    ***
011800000217     C                   MOVEA     '011'         *IN(25)
011900000217     C                   WRITE     WDWCTL
012000000217     C                   MOVEA     '010'         *IN(25)
012100000217     C*
012200010322     C                   MOVE      *ZEROS        #CNTREC           3 0
012300001214     C                   MOVE      #KT           CTRST
012400001214     C                   MOVE      #KS           CSUB
012500000217     C*
012600001207     C     @KEY          SETLL     PLNMSR
012700001207     C                   DOU       %EOF(PLNMST) OR #CNTREC = 600
012800010918     C     @KEY2         READE     PLNMSR
012900001207     C                   IF        NOT %EOF(PLNMST)
013000000217     C                   MOVE      *ON           *IN25
013100000217     C                   ADD       1             RRT
013200000217     C                   IF        RRT = 1
013300000217     C                   Z-ADD     RRT           SFLPOS
013400000217     C                   ENDIF
013500000217     C                   MOVE      *BLANKS       SEL
013600001207     C                   MOVEL(P)  PLPLAN        SFPLAN
013700001207     C                   MOVEL(P)  PDESCR        SFPDES
013800001207     C                   MOVEL(P)  PLDLTD        SFDLTD
013900000217     C                   WRITE     POPUP
014000000217     C                   ADD       1             #CNTREC
014100000217     C                   ENDIF
014200000217     C                   ENDDO
014300020221    ***
014400020221     C                   IF        RRT > 6
014500020221     C                   MOVE      *ON           *IN91
014600020221     C                   ENDIF
014700991124    ***
014800991124     C                   ENDSR
014900991124   S***S
015000000217     C     $CHKSEL       BEGSR
015100000217     C*
015200000217     C                   MOVE      *OFF          *IN33
015300000217     C                   DOU       *IN33 = *ON
015400000217     C                   READC     POPUP                                  33
015500000217     C                   IF        *IN33 = *OFF AND SEL <> *BLANKS
015600000217     C                   MOVE      *ON           *IN33
015700001207     C                   MOVEL(P)  SFPLAN        @KP
015800001207     C                   MOVEL(P)  @KEYPRM       @PARM
015900000217     C                   MOVE      '1'           @EXIT
016000000217     C                   ENDIF
016100000217     C                   ENDDO
016200000217     C*
016300000217     C                   ENDSR
