000100050624     FACCPRDP   IPE  E             DISK
000200050624     FACCMSTP   IF   E           K DISK
000300050624     FMEMALT    UF A E           K DISK
000400050624   X***X
000500050624     D @9              S              9A
000600050624     D K@T             S                   LIKE(MAALTTP)
000700050624     D K@M             S                   LIKE(MAMEMID)
000800050624     D K@A             S                   LIKE(MAALTID)
000900050624     D #ISO            S               D   DATFMT(*ISO)
001000050624     D POS             S              5U 0
001100050624     D #L              S              5U 0
001200050624     D #P              S              5U 0
001300050624     D @40             S             40A
001400050624     D @F              S             40A
001500050624     D @L              S             40A
001600050624   X***X
001700050624     C                   IF        %SUBST(APACCT:1:1) = 'I' AND
001800050624     C                             %SUBST(APCGRP:1:1) = '9'
001900050624     C                   EXSR      $PROCESS
002000050624     C                   ENDIF
002100050624   S***S
002200050624     C     *INZSR        BEGSR
002300050624    ***
002400050624     C     K#MA3         KLIST
002500050624     C                   KFLD                    K@M
002600050624     C                   KFLD                    K@T
002700050624     C                   KFLD                    K@A
002800050624    ***
002900050624     C     K#MA2         KLIST
003000050624     C                   KFLD                    K@M
003100050624     C                   KFLD                    K@T
003200050624    ***
003300050624     C                   MOVE      *DATE         #ISO
003400050624    ***
003500050624     C                   ENDSR
003600050624   S***S
003700050624     C     $PROCESS      BEGSR
003800050624    ***
003900050624     C                   MOVE      APACCT        @9
004000050624     C                   MOVE      @9            K@M
004100050624     C                   MOVEL(P)  'IMD'         K@T
004200050624     C                   MOVEL(P)  APCGRP        K@A
004300050624    ***
004400050624     C     K#MA3         CHAIN     MEMALTR
004500050624    ***
004600050624     C                   IF        %FOUND(MEMALT)
004700050624     C                   LEAVESR
004800050624     C                   ENDIF
004900050624    ***
005000050624     C     K#MA2         CHAIN     MEMALTR
005100050624    ***
005200050624     C                   IF        %FOUND(MEMALT) AND MAALTID = *BLANKS
005300050624     C                   EVAL      MAALTID = K@A
005400050624     C                   UPDATE    MEMALTR
005500050624     C                   LEAVESR
005600050624     C                   ENDIF
005700050624    ***
005800050624     C                   IF        %FOUND(MEMALT) AND MAALTID <> K@A
005900050624     C                   EVAL      MAALTID = K@A
006000050624     C                   UPDATE    MEMALTR
006100050624     C                   LEAVESR
006200050624     C                   ENDIF
006300050624    ***
006400050624     C                   EXSR      $CREATE
006500050624    ***
006600050624     C                   ENDSR
006700050624   S***S
006800050624     C     $CREATE       BEGSR
006900050624    ***
007000050624     C                   CLEAR                   MEMALTR
007100050624    ***
007200050624     C                   EVAL      MAMEMID = K@M
007300050624     C                   EVAL      MAALTID = K@A
007400050624     C                   EVAL      MAALTTP = 'IMD'
007500050624     C                   MOVE      #ISO          MACRTDT
007600050624    ***
007700050624     C                   EXSR      $GETNAME
007800050624     C                   MOVEL(P)  @F            MAFNAME
007900050624     C                   MOVEL(P)  @L            MALNAME
008000050624    ***
008100050624     C                   WRITE     MEMALTR
008200050624    ***
008300050624     C                   ENDSR
008400050624   S***S
008500050624     C     $GETNAME      BEGSR
008600050624    ***
008700050624     C                   MOVE      *BLANKS       @F
008800050624     C                   MOVE      *BLANKS       @L
008900050624     C     APACCT        CHAIN     ACCMSTR
009000050624    ***
009100050624     C                   MOVE      *ZEROS        POS
009200050624     C                   EVAL      POS = %SCAN(',':ADNAME)
009300050624    ***
009400050624     C                   IF        POS < 2 OR POS > 39
009500050624     C                   EVAL      @40 = %TRIM(ADNAME)
009600050624     C                   EVAL      @L = %SUBST(@40:1:35)
009700050624     C                   LEAVESR
009800050624     C                   ENDIF
009900050624    ***
010000050624     C                   EVAL      #L = POS - 1
010100050624     C                   EVAL      @40 = %SUBST(ADNAME:1:POS - 1)
010200050624     C                   EVAL      @40 = %TRIM(@40)
010300050624     C                   EVAL      @L = %SUBST(@40:1:35)
010400050624    ***
010500050624     C                   EVAL      #L = 40 - POS
010600050624     C                   EVAL      #P = POS + 1
010700050624     C                   EVAL      @40 = %SUBST(ADNAME:#P:#L)
010800050624     C                   EVAL      @40 = %TRIM(@40)
010900050624     C                   EVAL      @F = %SUBST(@40:1:20)
011000050624    ***
011100050624     C                   ENDSR
011200050624   S***S
011300050624   X***X
