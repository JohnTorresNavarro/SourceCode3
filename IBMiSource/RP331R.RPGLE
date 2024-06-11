000100030317     FRP330D    CF   E             WORKSTN INFDS(WSDS)
000200030317     FTRSMST    IF   E           K DISK
000300030317   X***X
000400030317     D @EMSG           S                   LIKE(EMSG)
000500030317     D #XSX            S              8S 0
000600030317     **
000700030317     D WSDS            DS
000800030317     D  FKEY                 369    369A
000900030317     **
001000030317     D  F1             C                   CONST(X'31')
001100030317     D  F2             C                   CONST(X'32')
001200030317     D  F3             C                   CONST(X'33')
001300030317     D  F4             C                   CONST(X'34')
001400030317     D  F5             C                   CONST(X'35')
001500030317     D  F6             C                   CONST(X'36')
001600030317     D  F7             C                   CONST(X'37')
001700030317     D  F8             C                   CONST(X'38')
001800030317     D  F9             C                   CONST(X'39')
001900030317     D  F10            C                   CONST(X'3A')
002000030317     D  F11            C                   CONST(X'3B')
002100030317     D  F12            C                   CONST(X'3C')
002200030317     D  F13            C                   CONST(X'B1')
002300030317     D  F14            C                   CONST(X'B2')
002400030317     D  F15            C                   CONST(X'B3')
002500030317     D  F16            C                   CONST(X'B4')
002600030317     D  F17            C                   CONST(X'B5')
002700030317     D  F18            C                   CONST(X'B6')
002800030317     D  F19            C                   CONST(X'B7')
002900030317     D  F20            C                   CONST(X'B8')
003000030317     D  F21            C                   CONST(X'B9')
003100030317     D  F22            C                   CONST(X'BA')
003200030317     D  F23            C                   CONST(X'BB')
003300030317     D  F24            C                   CONST(X'BC')
003400030317     **
003500030317     D                UDS
003600030317     D TRUST                   1      3A
003700030317     D RENMY                   4      9A
003800030317     D JOBQ                   10     10A
003900030317     D CONAME                201    240A
004000030317     **
004100030317   X***X
004200031216     C                   MOVEL(P)  CONAME        GBSREALM
004300030317     C                   DOU       FKEY = F3
004400030317     C*
004500030317     C                   EVAL      EMSG = %TRIM(@EMSG)
004600030317     C                   EXFMT     SCREEN
004700030317     C                   EVAL      EMSG = *BLANKS
004800030317     C                   EVAL      @EMSG = *BLANKS
004900030317     C*
005000030317     C                   IF        FKEY = F7
005100030317     C                   EVAL      TRUST = *BLANKS
005200030317     C                   EVAL      RENMY = *BLANKS
005300030317     C                   EVAL      JOBQ = 'X'
005400030317     C                   LEAVE
005500030317     C                   ENDIF
005600030317     C*
005700030317     C                   EXSR      $VALID
005800030317     C*
005900030317     C                   IF        @VF = 'Y'
006000030317     C                   LEAVE
006100030317     C                   ENDIF
006200030317     C*
006300030317     C                   ENDDO
006400030317     **
006500030317     C                   EVAL      *INLR = *ON
006600030317   S***S
006700030317     C     *INZSR        BEGSR
006800030317     **
006900030317     C     *LIKE         DEFINE    TRTRST        KEY@TRS
007000030317     **
007100030317     C                   EVAL      TRUST = 'ALL'
007200030317     C                   EVAL      RENMY = 'ALL'
007300030317     C                   EVAL      JOBQ = 'Y'
007400030317     **
007500030317     C                   ENDSR
007600030317   S***S
007700030317     C     $VALID        BEGSR
007800030317     **
007900030317     C                   MOVE      'N'           @VF               1
008000030317     **
008100030317     C                   IF        TRUST <> 'ALL'
008200030317     C*
008300030317     C                   TESTN                   TRUST                99
008400030317     C                   IF        *IN99 = *OFF
008500030317     C                   EVAL      @EMSG = 'INVALID TRUST'
008600030317     C                   LEAVESR
008700030317     C                   ENDIF
008800030317     C*
008900030317     C                   MOVE      TRUST         KEY@TRS
009000030317     C     KEY@TRS       CHAIN     TRSMSR
009100030317     C                   IF        NOT %FOUND(TRSMST)
009200030317     C                   EVAL      @EMSG = 'INVALID TRUST'
009300030317     C                   LEAVESR
009400030317     C                   ENDIF
009500030317     C*
009600030317     C                   ENDIF
009700030317     **
009800030317     C                   IF        RENMY <> 'ALL'
009900030317     C*
010000030317     C                   TESTN                   RENMY                99
010100030317     C                   IF        *IN99 = *OFF
010200030317     C                   EVAL      @EMSG = 'INVALID MONTH/YEAR SELECTION'
010300030317     C                   LEAVESR
010400030317     C                   ENDIF
010500030317     C*
010600030317     C                   MOVE      *BLANKS       @8                8
010700030317     C                   EVAL      @8 = %SUBST(RENMY:3:4) +
010800030317     C                             %SUBST(RENMY:1:2) + '01'
010900030317     C                   MOVE      @8            #XSX
011000030317     C     *ISO          TEST(DE)                #XSX
011100030317     C                   IF        %ERROR
011200030317     C                   EVAL      @EMSG = 'INVALID MONTH/YEAR SELECTION'
011300030317     C                   LEAVESR
011400030317     C                   ENDIF
011500030317     C*
011600030317     C                   ENDIF
011700030317     **
011800030317     C                   IF        JOBQ <> 'Y' AND JOBQ <> 'N'
011900030317     C                   EVAL      @EMSG = 'INVALID JOBQ VALUE'
012000030317     C                   LEAVESR
012100030317     C                   ENDIF
012200030317     **
012300030317     C                   MOVE      'Y'           @VF
012400030317     **
012500030317     C                   ENDSR
012600030317   S***S
