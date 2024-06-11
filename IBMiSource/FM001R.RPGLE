000100991124     F*-------------------------------------------------------------------------
000200000218     F* FM001      INNOVATIVE OUTSOURCING SOFTWARE 2000
000300991124     F*            WRITTEN BY - S.S.K.
000400000211     F*            DATE - 02/00
000500000217     F*  DESCRIPTION - DISPLAY CODE RECORDS FOR A TYPE FROM CODES FILE
000600991124     F*  INDICATOR USAGE:
000700991124     F*    03 = EXIT FROM INITIAL SCREEN
000800991124     F*    25 = SFLDSP
000900991124     F*    26 = SFL DSP CTL
001000991124     F*    27 = SFL CLR
001100991124     F*
001200991124     F*-------------------------------------------------------------------------
001300991209     ** MODIFICATION HISTORY                                              **
001400991209     ** ###  UUU  MMDDCCYY  X---->                                        **
001500000217     ** 000  SSK  02172000  ORIGINAL SOURCE                               **
001600020729     ** 001  SSK  07292002  CODE 'X' EMAILS                               **
001700090217     ** 02/13/09 dlk - add debit card prefix                              **
001701090217     **                                                                   **
001800991209     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001900000217     FCODES     IF   E           K DISK
002000000428     FFM001D    CF   E             WORKSTN SFILE(POPUP:RRT) INFDS(WSDS)
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
004900000217    ***
005000090213     D CC              S             30    DIM(19) CTDATA PERRCD(1)
005100991124   X***X
005200991124     C* MAINLINE
005300991124    ***
005400991124     C                   EXSR      ONCE
005500991124     C*
005600991216     C                   DOU       @EXIT = '1'
005700991124     C*
005800000217     C                   IF        FKEY = F1
005900000217     C                   MOVE      '1'           @EXIT
006000000217     C                   MOVE      '*LR'         @PARM
006100000217     C                   ELSE
006200000217     C                   EXSR      $CHKSEL
006300000217     C                   ENDIF
006400991124     C*
006500000217     C                   IF        @EXIT = '0'
006600000217     C                   WRITE     JUNK
006700000217     C                   EXFMT     WDWCTL
006800991124     C                   ENDIF
006900991124     C*
007000991124     C                   ENDDO
007100991124     C*
007200991124     C                   MOVE      *ON           *INLR
007300991124     C                   RETURN
007400991124   S***S
007500991124     C* ONETIME ROUTINE
007600991124    ***
007700991124     C     ONCE          BEGSR
007800000211    ***
007900000211     C     *ENTRY        PLIST
008000000217     C                   PARM                    @PARM             3
008100000217     C                   MOVEL(P)  @PARM         @KEYPRM           1
008200000217    ***
008300000901     C                   MOVE      '0'           @EXIT             1
008400000217     C                   MOVE      *ZEROS        RRT               4 0
008500000211    ***
008600000217     C                   SELECT
008700000217     C                   WHEN      @PARM = 'O'
008800000217     C                   MOVEL(P)  CC(2)         CODECATEG
008900000217     C                   WHEN      @PARM = 'T'
009000000217     C                   MOVEL(P)  CC(3)         CODECATEG
009100000217     C                   WHEN      @PARM = 'P'
009200000217     C                   MOVEL(P)  CC(4)         CODECATEG
009300010103     C                   WHEN      @PARM = 'R'
009400010103     C                   MOVEL(P)  CC(5)         CODECATEG
009500010103     C                   WHEN      @PARM = 'A'
009600010103     C                   MOVEL(P)  CC(6)         CODECATEG
009700010103     C                   WHEN      @PARM = 'E'
009800010103     C                   MOVEL(P)  CC(7)         CODECATEG
009900010103     C                   WHEN      @PARM = 'D'
010000010103     C                   MOVEL(P)  CC(8)         CODECATEG
010100010103     C                   WHEN      @PARM = 'B'
010200010103     C                   MOVEL(P)  CC(9)         CODECATEG
010300010103     C                   WHEN      @PARM = 'M'
010400010103     C                   MOVEL(P)  CC(10)        CODECATEG
010500010103     C                   WHEN      @PARM = 'S'
010600010103     C                   MOVEL(P)  CC(11)        CODECATEG
010700010103     C                   WHEN      @PARM = 'U'
010800010103     C                   MOVEL(P)  CC(12)        CODECATEG
010900010103     C                   WHEN      @PARM = 'G'
011000010103     C                   MOVEL(P)  CC(13)        CODECATEG
011100010103     C                   WHEN      @PARM = 'Y'
011200010103     C                   MOVEL(P)  CC(14)        CODECATEG
011300010103     C                   WHEN      @PARM = 'N'
011400010103     C                   MOVEL(P)  CC(15)        CODECATEG
011500020612     C                   WHEN      @PARM = 'W'
011600020612     C                   MOVEL(P)  CC(16)        CODECATEG
011700020612     C                   WHEN      @PARM = 'F'
011800020612     C                   MOVEL(P)  CC(17)        CODECATEG
011900020729     C                   WHEN      @PARM = 'X'
012000020729     C                   MOVEL(P)  CC(18)        CODECATEG
012001090213     C                   WHEN      @PARM = 'a'
012002090213     C                   MOVEL(P)  CC(19)        CODECATEG
012100000217     C                   OTHER
012200000217     C                   MOVEL(P)  CC(1)         CODECATEG
012300000217     C                   ENDSL
012400000217     C*
012500000217     C                   MOVEA     '011'         *IN(25)
012600000217     C                   WRITE     WDWCTL
012700000217     C                   MOVEA     '010'         *IN(25)
012800000217     C*
012900010322     C                   MOVE      *ZEROS        #CNTREC           3 0
013000000217     C*
013100000217     C     @KEYPRM       SETLL     CODESR
013200000217     C                   DOU       %EOF(CODES) OR #CNTREC = 600
013300000217     C     @KEYPRM       READE     CODESR
013400000217     C                   IF        NOT %EOF(CODES)
013500000217     C                   MOVE      *ON           *IN25
013600000217     C                   ADD       1             RRT
013700000217     C                   IF        RRT = 1
013800000217     C                   Z-ADD     RRT           SFLPOS
013900000217     C                   ENDIF
014000000217     C                   MOVE      *BLANKS       SEL
014100000217     C                   WRITE     POPUP
014200000217     C                   ADD       1             #CNTREC
014300000217     C                   ENDIF
014400000217     C                   ENDDO
014500000217     C*
014600020220     C                   IF        RRT > 6
014700020220     C                   MOVE      *ON           *IN91
014800020220     C                   ENDIF
014900020220     C*
015000000217     C                   WRITE     JUNK
015100000217     C                   EXFMT     WDWCTL
015200991124    ***
015300991124     C                   ENDSR
015400991124   S***S
015500000217     C     $CHKSEL       BEGSR
015600000217     C*
015700000217     C                   MOVE      *OFF          *IN33
015800000217     C                   DOU       *IN33 = *ON
015900000217     C                   READC     POPUP                                  33
016000000217     C                   IF        *IN33 = *OFF AND SEL <> *BLANKS
016100000217     C                   MOVE      *ON           *IN33
016200000217     C                   MOVE      CODE          @PARM
016300000217     C                   MOVE      '1'           @EXIT
016400000217     C                   ENDIF
016500000217     C                   ENDDO
016600000217     C*
016700000217     C                   ENDSR
016800000217     C**************************************************************************
016900000217     **  111111111122222222223
01700000021712345**89012345678901234567890
017100000217** CTDATA CC
017200000217THIS TYPE IS NOT DEFINED
017300010103TRUST CATEGORY CODES
017400010103COVERAGE TYPE CODES
017500010103PLAN CATEGORY CODES
017600010103DEPENDENT RELATIONSHIP CODES
017700010103ADJUSTMENT CODES
017800010103REINSTATEMENT CODES
017900010103TERMINATION REASON TYPE CODES
018000010103BILLING PAYMENT CODES
018100010103MAINTENANCE CODES
018200010103MEMBER STATUS CODES
018300010103UTILITY TRANS. CODES
018400010103SYSTEM GENERATED ADJUSTMENTS
018500010103COST CENTER: 2ND & 3RD DIGITS
018600010103CARRIER PRODUCT TYPE CODES
018700020108DIARY SYSTEM CATEGORY CODES
018800020612SALESMAN TYPE CODES
018900020729E-MAIL ADDRESSES CODES
019000090213DEBIT CARD DELIVERY CODES
