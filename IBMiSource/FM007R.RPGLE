000100001222     F*-------------------------------------------------------------------------
000200001222     F* FM007      INNOVATIVE OUTSOURCING SOFTWARE 2000
000300001222     F*            WRITTEN BY - S.S.K.
000400001222     F*            DATE - 12/00
000500001222     F*  DESCRIPTION - DISPLAY SUBDIVISION RECORD FROM THE SUBDIVISION MASTER FILE
000600001222     F*  INDICATOR USAGE:
000700001222     F*    03 = EXIT FROM INITIAL SCREEN
000800001222     F*    25 = SFLDSP
000900001222     F*    26 = SFL DSP CTL
001000001222     F*    27 = SFL CLR
001100001222     F*
001200001222     F*-------------------------------------------------------------------------
001300001222     ** MODIFICATION HISTORY                                              **
001400001222     ** ###  UUU  MMDDCCYY  X---->                                        **
001500001222     ** 000  SSK  12222000  ORIGINAL SOURCE                               **
001600001222     **                                                                   **
001700001222     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001800001222     FSUBMST2   IF   E           K DISK
001900001222     FFM007D    CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
002000001222   X***X
002100001222     D                 DS
002200001222     D @KEY                    1     20A
002300001222     D @K5                     1      5A
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
005200001222    ***
005300001222     D                 DS
005400001222     D @PDS                    1      6A
005500001222     D @TR                     1      3A
005600001222     D #TR                     1      3S 0
005700001222     D @SU                     4      6A
005800001222   X***X
005900001222     C* MAINLINE
006000001222    ***
006100001222     C                   EXSR      ONCE
006200001222     C*
006300001222     C                   DOU       @EXIT = '1'
006400001222     C*
006500001222     C                   IF        FKEY = F1
006600001222     C                   MOVE      '1'           @EXIT
006700001222     C                   MOVEL(P)  '*LR*LR'      @PDS              6
006800001222     C                   ELSE
006900001222     C                   EXSR      $CHKSEL
007000001222     C                   ENDIF
007100001222     C*
007200001222     C                   IF        @EXIT = '0'
007300001222     C*
007400001222     C                   IF        PRTKEY <> @K5
007500001222     C                   MOVEL(P)  PRTKEY        @K5
007600001222     C                   EXSR      $BUILDSFL
007700001222     C                   ENDIF
007800001222     C*
007900001222     C                   WRITE     JUNK
008000001222     C                   EXFMT     WDWCTL
008100001222     C*
008200001222     C                   ENDIF
008300001222     C*
008400001222     C                   ENDDO
008500001222     C*
008600001222     C                   MOVEL(P)  @PDS          @PARM
008700001222     C                   MOVE      *ON           *INLR
008800001222     C                   RETURN
008900001222   S***S
009000001222     C* ONETIME ROUTINE
009100001222    ***
009200001222     C     ONCE          BEGSR
009300001222    ***
009400001222     C     *ENTRY        PLIST
009500001222     C                   PARM                    @PARM             6
009600001222     C                   MOVEL(P)  @PARM         @PDS
009700001222    ***
009800001222     C     SKEY          KLIST
009900001222     C                   KFLD                    #TR
010000001222     C                   KFLD                    @KEY             20
010100001222    ***
010200001222     C                   MOVEL(P)  @TR           CTRST
010300001222     C                   MOVE      '0'           @EXIT             1
010400001222    ***
010500001222     C                   MOVEL     'A'           @K5
010600001222     C                   MOVEL     'A'           PRTKEY
010700001222     C                   EXSR      $BUILDSFL
010800001222    ***
010900001222     C                   WRITE     JUNK
011000001222     C                   EXFMT     WDWCTL
011100001222    ***
011200001222     C                   ENDSR
011300001222   S***S
011400001222     C     $CHKSEL       BEGSR
011500001222     C*
011600001222     C                   MOVE      *OFF          *IN33
011700001222     C                   DOU       *IN33 = *ON
011800001222     C                   READC     POPUP                                  33
011900001222     C                   IF        *IN33 = *OFF AND SEL <> *BLANKS
012000001222     C                   MOVE      *ON           *IN33
012100001222     C                   MOVEL(P)  SFSUB#        @SU
012200001222     C                   MOVE      '1'           @EXIT
012300001222     C                   ENDIF
012400001222     C                   ENDDO
012500001222     C*
012600001222     C                   ENDSR
012700001222   S***S
012800001222     C     $BUILDSFL     BEGSR
012900001222    ***
013000001222     C                   MOVE      *ZEROS        RRT               4 0
013100001222    ***
013200001222     C                   MOVEA     '011'         *IN(25)
013300001222     C                   WRITE     WDWCTL
013400001222     C                   MOVEA     '010'         *IN(25)
013500001222     C*
013600010322     C                   MOVE      *ZEROS        #CNTREC           3 0
013700001222     C*
013800001222     C     SKEY          SETLL     SUBMSR
013900001222     C                   DOU       %EOF(SUBMST2) OR #CNTREC = 600
014000001222     C     #TR           READE     SUBMSR
014100001222     C                   IF        NOT %EOF(SUBMST2)
014200001222     C                   MOVE      *ON           *IN25
014300001222     C                   ADD       1             RRT
014400001222     C                   IF        RRT = 1
014500001222     C                   Z-ADD     RRT           SFLPOS
014600001222     C                   ENDIF
014700001222     C                   MOVE      *BLANKS       SEL
014800001222     C                   MOVE      SBSUB#        SFSUB#
014900001222     C                   MOVEL(P)  SUBNAM        SFSNAM
015000001222     C                   MOVEL(P)  SUBDSC        SFSDES
015100001222     C                   MOVEL(P)  SBDLTD        SFDLTD
015200001222     C                   WRITE     POPUP
015300001222     C                   ADD       1             #CNTREC
015400001222     C                   ENDIF
015500001222     C                   ENDDO
015600020221    ***
015700020221     C                   IF        RRT > 6
015800020221     C                   EVAL      *IN91 = *ON
015900020221     C                   ENDIF
016000001222    ***
016100001222     C                   ENDSR
