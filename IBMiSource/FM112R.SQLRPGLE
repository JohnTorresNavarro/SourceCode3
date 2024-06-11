000100040827   X***X
000200040827     D @STEP           S              5A
000300050705     D P@sgrp          S              5A
000400040827     D RRT             S              4S 0
000500040827     D #CNT            S              4S 0
000600050706     d countme         s              5i 0
000700040827   X***X
000800050706     C/EXEC SQL
000900050706     c+ Set Option Datfmt = *Iso
001000050706     C/END-EXEC
001100050706    ***
001200050706     C                   exsr      $proc
001300040827     C                   EVAL      *INLR = *ON
001400040827   S***S
001500050706     C     $proc         BEGSR
001600050623    ***
001700050706     C/EXEC SQL
001800050706     c+ SELECT COUNT(*) INTO :countme
001900050706     c+    FROM "F.SMAN2L" WHERE sgrpcd not in
002000050706     c+ (select sgrp from "F.SMANL3")
002100050706     C/END-EXEC
002200050706    ***
002300050706    1c                   if        countme = 0
002400050706     c                   leavesr
002500050706     c                   endif
002600050706    ***
002700040830     C/EXEC SQL
002800050706     C+ DECLARE GRPCSR SCROLL CURSOR FOR
002900050706     c+ SELECT sgrpcd FROM "F.SMAN2L" WHERE sgrpcd not in
003000050706     c+ (select sgrp from "F.SMANL3")
003100040827     C/END-EXEC
003200040827    ***
003300040827     C/EXEC SQL
003400040827     C+ OPEN GRPCSR
003500040827     C/END-EXEC
003600040827    ***
003700050706     C                   DOU       sqlcod <> 0
003800050706    ***
003900050706     c/EXEC SQL
004000050706     c+ FETCH NEXT FROM GRPCSR
004100050706     c+   INTO :@5
004200050706     C/END-EXEC
004300050706    ***
004400050706     C                   if        sqlcod = 0
004500050706    ***
004600050707     c     @5            dsply     '*EXT'
004700050706     C                   call      'FM111CL'
004800050706     c                   parm                    @5                5
004900050707     c     @5            dsply     '*EXT'
005000050706    ***
005100050706     C                   ENDIF
005200050706     C                   ENDDO
005300050706    ***
005400050706     c/exec sql
005500050706     c+ close grpcsr
005600050706     c/end-exec
005700050706    ***
005800050706     c                   endsr
005900040827   S***S
