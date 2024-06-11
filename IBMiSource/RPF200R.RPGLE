000100981124     F*                                                                *
000200981124     F*  Y2K CONVERT - 1998                                            *
000300981124     F*                                                                *
000400970714     F*SALES MASTER LABELS            -------------------------
000500910215     F*                               | ACCOUNT NAME          |
000600970714     F*   SALES MASTER LABELS         | ADDRESS               |
000700970714     F*   COPIED FROM RPF020 - 7/97   | CITY, ST. ZIP         |
000800910215     F*                               -------------------------
000900030313     FSMAN      IP   E           K DISK
001000030313     FREPORT    O    F  132        PRINTER
001100910215     F                                     FORMLEN(6)
001200030313     F                                     FORMOFL(2)
001300030313   X***X
001400030313     D N               S             34A
001500030313     D AL              S             30A
001600030313     D A@20            S             20A
001700030313     D A@40            S             40A
001800030313     D #AREA           S              3A
001900030313    ***
002000910215     D                UDS
002100970714     D  ALL1                 100    102
002200970714     D  AICODE               150    150
002300970714     D  USERID                 1     10
002400030313    ***
002500030313     D                 DS
002600030313     D SMANCD                  1      3
002700030313     D  FCODE                  1      1
002800030313   X***X
002900030313     C                   SELECT
003000030313     C*
003100030313     C                   WHEN      CODE2 = *BLANKS
003200030313     C                   EXSR      $SELONE
003300030313     C*
003400030313     C                   WHEN      SMANCD = ALL1 AND AICODE = 'I' AND
003500030313     C                             SENDDT <> 0
003600030313     C                   EXSR      $COMNRTN
003700030313     C*
003800030313     C                   WHEN      SMANCD = ALL1 AND AICODE = 'A' AND
003900030313     C                             SENDDT = 0
004000030313     C                   EXSR      $COMNRTN
004100030313     C*
004200030313     C                   WHEN      ALL1 = 'ALL'
004300030313     C                   EXSR      $ALLSR
004400030313     C*
004500030313     C                   ENDSL
004600030313    ***
004700030313     C                   IF        CODE2 <> *BLANKS
004800030313     C                   EXSR      $SELONE
004900030313     C                   ENDIF
005000030313    ***
005100030313   S***S
005200030313     C     *INZSR        BEGSR
005300030313    ***
005400030313     C                   MOVEL     ALL1          CODE1             1
005500030313     C                   MOVE      ALL1          CODEX             2
005600030313     C                   MOVEL     CODEX         CODE2             1
005700030313     C                   EXCEPT    HEADER
005800030313    ***
005900030313     C                   ENDSR
006000030313   S***S
006100030313     C     $SELONE       BEGSR
006200030313    ***
006300030313     C*-- SELECT = 1ST CHARACTER OR CODE. (INACTIVE) -------------
006400030313     C                   IF        FCODE = CODE1 AND AICODE = 'I' AND
006500030313     C                             SENDDT <> 0
006600030313     C                   EXSR      $COMNRTN
006700030313     C                   LEAVESR
006800030313     C                   ENDIF
006900030313    ***
007000030313     C*-- SELECT = 1ST CHARACTER OR CODE. (ACTIVE)   -------------
007100030313     C                   IF        FCODE = CODE1 AND AICODE = 'A' AND
007200030313     C                             SENDDT = 0
007300030313     C                   EXSR      $COMNRTN
007400030313     C                   ENDIF
007500030313    ***
007600030313     C                   ENDSR
007700030313   S***S
007800030313     C     $COMNRTN      BEGSR
007900030313    ***
008000030313     C                   EXSR      $NAMEL
008100030313     C                   MOVEL(P)  A@40          N
008200030313     C                   EXSR      $ADDR
008300030313     C                   MOVEL(P)  A@40          AL
008400030313     C                   EXCEPT    LABEL
008500030313    ***
008600030313     C                   ENDSR
008700030313   S***S
008800030313     C     $NAMEL        BEGSR
008900030313    ***
009000030313     C                   CLEAR                   A@20
009100030313     C                   CLEAR                   A@40
009200030313    ***
009300030313     C                   IF        SLNAME <> *BLANKS
009400030313     C                   EVAL      A@20 = %TRIM(SLNAME) + ','
009500030313     C                   EXSR      $LDADDR
009600030313     C                   ENDIF
009700030313    ***
009800030313     C                   IF        SFNAME <> *BLANKS
009900030313     C                   MOVEL     SFNAME        A@20
010000030313     C                   EXSR      $LDADDR
010100030313     C                   ENDIF
010200030313    ***
010300030313     C                   IF        SMI <> *BLANKS
010400030313     C                   EVAL      A@20 = %TRIM(SMI) + '.'
010500030313     C                   EXSR      $LDADDR
010600030313     C                   ENDIF
010700030313    ***
010800030313     C                   ENDSR
010900030313   S***S
011000030313     C     $LDADDR       BEGSR
011100030313    ***
011200030313     C                   EVAL      A@20 = %TRIM(A@20)
011300030313     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
011400030313     C                   CLEAR                   A@20
011500030313    ***
011600030313     C                   ENDSR
011700030313   S***S
011800030313     C     $ADDR         BEGSR
011900030313    ***
012000030313     C                   CLEAR                   A@20
012100030313     C                   CLEAR                   A@40
012200030313    ***
012300030313     C                   IF        SCITY <> *BLANKS
012400030313     C                   EVAL      A@20 = %TRIM(SCITY) + ','
012500030313     C                   EXSR      $LDADDR
012600030313     C                   ENDIF
012700030313    ***
012800030313     C                   IF        SSTATE <> *BLANKS
012900030313     C                   MOVEL     SSTATE        A@20
013000030313     C                   EXSR      $LDADDR
013100030313     C                   ENDIF
013200030313    ***
013300030313     C                   IF        SZIPCD <> 0
013400030313     C                   MOVE      SZIPCD        @9A               9
013500030313     C                   IF        %SUBST(@9A:6:4) <> '0000'
013600030313     C                   EVAL      A@20 = %EDITW(SZIPCD:'     -    ')
013700030313     C                   ELSE
013800030313     C                   EVAL      A@20 = %SUBST(@9A:1:5)
013900030313     C                   ENDIF
014000030313     C                   EXSR      $LDADDR
014100030313     C                   ENDIF
014200030313    ***
014300030313     C                   ENDSR
014400030313   S***S
014500030313     C     $ALLSR        BEGSR
014600030313    ***
014700030313     C                   IF        AICODE = 'I' AND SENDDT <> 0
014800030313     C                   EXSR      $COMNRTN
014900030313     C                   ENDIF
015000030313    ***
015100030313     C                   IF        AICODE = 'A' AND SENDDT = 0
015200030313     C                   EXSR      $COMNRTN
015300030313     C                   ENDIF
015400030313    ***
015500970715     C                   ENDSR
015600030313   S***S
015700030313   X***X
015800910215     OREPORT    E            HEADER         1 01
015900910215     O                                           26 '*'
016000910215     O                                           25 '************************'
016100910215     O                                           29 '****'
016200910215     O          E            HEADER         1
016300910215     O                                            3 '**'
016400970714     O                                           27 ' SALES  MASTER   LABELS '
016500910215     O                                           29 '**'
016600910215     O          E            HEADER         1
016700910215     O                                            2 '*'
016800970714     O                       USERID              11
016900970714     O                                           13 '('
017000970714     O                       ALL1                16
017100970714     O                                           17 '-'
017200970714     O                       AICODE              18
017300970714     O                                           19 ')'
017400970714     O                                           27 'RPF200'
017500910215     O                                           29 '*'
017600910215     O          E            HEADER         1
017700910215     O                                           25 '************************'
017800910215     O                                           29 '****'
017900910215     OREPORT    E            LABEL          1 01
018000970714     O                       N                   34
018100910215     O          E            LABEL          1
018200970714     O                       SADDR               30
018300910215     O          E            LABEL          1
018400910215     O                       AL                  30
