000100991124     F*-------------------------------------------------------------------------
000200001218     F* FM005      INNOVATIVE OUTSOURCING SOFTWARE 2000
000300991124     F*            WRITTEN BY - S.S.K.
000400001218     F*            DATE - 12/00
000500001218     F*  DESCRIPTION - DISPLAY PLAN RECORDS FROM CARRIER MARKET SIZES SELECTOR
000600991124     F*  INDICATOR USAGE:
000700991124     F*    03 = EXIT FROM INITIAL SCREEN
000800991124     F*    25 = SFLDSP
000900991124     F*    26 = SFL DSP CTL
001000991124     F*    27 = SFL CLR
001100991124     F*
001200991124     F*-------------------------------------------------------------------------
001300991209     ** MODIFICATION HISTORY                                              **
001400991209     ** ###  UUU  MMDDCCYY  X---->                                        **
001500001218     ** 000  SSK  12182000  ORIGINAL SOURCE                               **
001600991209     **                                                                   **
001700991209     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001800001218     FCARMST    IF   E           K DISK
001900010120     FCARMKSZ4  IF   E           K DISK
002000001218     FFM005D    CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
002100991124   X***X
002200991216     D WSDS            DS
002300991216     D  FKEY                 369    369A
002400991216    ***
002500991216     D  F1             C                   CONST(X'31')
002600991216     D  F2             C                   CONST(X'32')
002700991216     D  F3             C                   CONST(X'33')
002800991216     D  F4             C                   CONST(X'34')
002900991216     D  F5             C                   CONST(X'35')
003000991216     D  F6             C                   CONST(X'36')
003100991216     D  F7             C                   CONST(X'37')
003200991216     D  F8             C                   CONST(X'38')
003300991216     D  F9             C                   CONST(X'39')
003400991216     D  F10            C                   CONST(X'3A')
003500991216     D  F11            C                   CONST(X'3B')
003600991216     D  F12            C                   CONST(X'3C')
003700991216     D  F13            C                   CONST(X'B1')
003800991216     D  F14            C                   CONST(X'B2')
003900991216     D  F15            C                   CONST(X'B3')
004000991216     D  F16            C                   CONST(X'B4')
004100991216     D  F17            C                   CONST(X'B5')
004200991216     D  F18            C                   CONST(X'B6')
004300991216     D  F19            C                   CONST(X'B7')
004400991216     D  F20            C                   CONST(X'B8')
004500991216     D  F21            C                   CONST(X'B9')
004600991216     D  F22            C                   CONST(X'BA')
004700991216     D  F23            C                   CONST(X'BB')
004800991216     D  F24            C                   CONST(X'BC')
004900001207    ***
005000001218     D                 DS
005100001218     D @KEYPRM                 1      8A
005200001218     D @CARR                   1      3A
005300001218     D @SZCD                   4      8A
005400010123     D #ISO            S               D   DATFMT(*ISO)
005500010123     D #USA            S               D   DATFMT(*USA)
005600010123     D #ISA            S              8S 0
005700991124   X***X
005800991124     C* MAINLINE
005900991124    ***
006000991124     C                   EXSR      ONCE
006100991124     C*
006200991216     C                   DOU       @EXIT = '1'
006300991124     C*
006400000217     C                   IF        FKEY = F1
006500000217     C                   MOVE      '1'           @EXIT
006600001218     C                   MOVEL(P)  '*LR'         @SZCD
006700001218     C                   MOVEL(P)  @KEYPRM       @PARM
006800000217     C                   ELSE
006900000217     C                   EXSR      $CHKSEL
007000000217     C                   ENDIF
007100991124     C*
007200000217     C                   IF        @EXIT = '0'
007300000217     C                   WRITE     JUNK
007400000217     C                   EXFMT     WDWCTL
007500991124     C                   ENDIF
007600991124     C*
007700991124     C                   ENDDO
007800991124     C*
007900991124     C                   MOVE      *ON           *INLR
008000991124     C                   RETURN
008100991124   S***S
008200991124     C* ONETIME ROUTINE
008300991124    ***
008400991124     C     ONCE          BEGSR
008500000211    ***
008600000211     C     *ENTRY        PLIST
008700001218     C                   PARM                    @PARM             8
008800001207     C                   MOVEL(P)  @PARM         @KEYPRM
008900000217    ***
009000000217     C                   MOVE      '0'           @EXIT             1
009100000217     C                   MOVE      *ZEROS        RRT               4 0
009200000211    ***
009300000217     C                   MOVEA     '011'         *IN(25)
009400000217     C                   WRITE     WDWCTL
009500000217     C                   MOVEA     '010'         *IN(25)
009600000217     C*
009700010322     C                   MOVE      *ZEROS        #CNTREC           3 0
009800001218     C                   MOVEL     @CARR         CCARR
009900001218     C     @CARR         CHAIN(N)  CARMSR
010000001218     C                   IF        %FOUND(CARMST)
010100001218     C                   MOVEL(P)  CNAME         CCNAM
010200001218     C                   ENDIF
010300000217     C*
010400001218     C     @CARR         SETLL     RCARMKSZ
010500010120     C                   DOU       %EOF(CARMKSZ4) OR #CNTREC = 600
010600001218     C     @CARR         READE     RCARMKSZ
010700010120     C                   IF        NOT %EOF(CARMKSZ4)
010800000217     C                   MOVE      *ON           *IN25
010900000217     C                   ADD       1             RRT
011000000217     C                   IF        RRT = 1
011100000217     C                   Z-ADD     RRT           SFLPOS
011200000217     C                   ENDIF
011300000217     C                   MOVE      *BLANKS       SEL
011400001218     C                   MOVEL(P)  CZSZCD        SFSZCD
011500001218     C                   Z-ADD     CZFRSZ        SFFRSZ
011600001218     C                   Z-ADD     CZTOSZ        SFTOSZ
011700010123     C                   Z-ADD     CZFRDT        #ISA
011800010123     C                   EXSR      $ISOUSA
011900010123     C                   Z-ADD     #ISA          SFFRDT
012000010123     C                   Z-ADD     CZTODT        #ISA
012100010123     C                   EXSR      $ISOUSA
012200010123     C                   Z-ADD     #ISA          SFTODT
012300000217     C                   WRITE     POPUP
012400000217     C                   ADD       1             #CNTREC
012500000217     C                   ENDIF
012600000217     C                   ENDDO
012700020221     C*
012800020221     C                   IF        RRT > 6
012900020221     C                   MOVE      *ON           *IN91
013000020221     C                   ENDIF
013100000217     C*
013200000217     C                   WRITE     JUNK
013300000217     C                   EXFMT     WDWCTL
013400991124    ***
013500991124     C                   ENDSR
013600991124   S***S
013700010123     C     $ISOUSA       BEGSR
013800010123    ***
013900010123    1C                   IF        #ISA <> 0
014000010123     C     *ISO          TEST (DE)               #ISA
014100010123    2C                   IF        NOT %ERROR
014200010123     C                   MOVE      #ISA          #ISO
014300010123     C                   MOVE      #ISO          #USA
014400010123     C                   MOVE      #USA          #ISA
014500010123    2C                   ELSE
014600010123     C                   MOVE      *ZEROS        #ISA
014700010123    2C                   ENDIF
014800010123    1C                   ENDIF
014900010123    ***
015000010123     C                   ENDSR
015100010123   S***S
015200000217     C     $CHKSEL       BEGSR
015300000217     C*
015400000217     C                   MOVE      *OFF          *IN33
015500000217     C                   DOU       *IN33 = *ON
015600000217     C                   READC     POPUP                                  33
015700000217     C                   IF        *IN33 = *OFF AND SEL <> *BLANKS
015800000217     C                   MOVE      *ON           *IN33
015900001218     C                   MOVEL(P)  SFSZCD        @SZCD
016000001207     C                   MOVEL(P)  @KEYPRM       @PARM
016100000217     C                   MOVE      '1'           @EXIT
016200000217     C                   ENDIF
016300000217     C                   ENDDO
016400000217     C*
016500000217     C                   ENDSR
