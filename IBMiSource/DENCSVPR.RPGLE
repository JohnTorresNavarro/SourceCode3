000100070220     FDXCURP    IPE  E           K DISK
000200070220     FDXCSVP    O  A F 2000        DISK
000300050823   X***X
000400060315     D @OUTPUT         S           2000A   INZ
000500051108     D @C              C                   CONST('","')
000600051108    ***
000700050823   X***X
000800060315     C                   CLEAR                   @OUTPUT
000900070220     C                   EVAL      @OUTPUT = %TRIM(dxlnme) + '|' +
001000070220     C                             %TRIM(dxfnme) + '|' +
001100070220     C                             %TRIM(dxf1) + '|' +
001200070220     C                             %TRIM(dxf2) + '|' +
001300070220     C                             %TRIM(dxmi) + '|' +
001400070220     C                             %TRIM(dxsex) + '|' +
001500070220     C                             %TRIM(dxdob) + '|' +
001600070220     C                             %TRIM(dxadd1) + '|' +
001700070220     C                             %TRIM(dxadd2) + '|' +
001800070220     C                             %TRIM(dxcity) + '|' +
001900070220     C                             %TRIM(dxst) + '|' +
002000070220     C                             %TRIM(dxzip) + '|' +
002100070220     C                             %TRIM(dxz4) + '|' +
002200070220     C                             %TRIM(dxphn) + '|' +
002300070220     C                             %TRIM(dxsssn) + '|' +
002400070220     C                             %TRIM(dxmssn) + '|' +
002500070220     C                             %TRIM(dxclnm) + '|' +
002600070220     C                             %TRIM(dxf3) + '|' +
002700070220     C                             %TRIM(dxf4) + '|' +
002800070220     C                             %TRIM(dxgrp#) + '|' +
002900070220     C                             %TRIM(dxftpid) + '|' +
003000070220     C                             %TRIM(dxf5) + '|' +
003100070220     C                             %TRIM(dxf6) + '|' +
003200070220     C                             %TRIM(dxeff) + '|' +
003300070220     C                             %TRIM(dxtrm) + '|' +
003400070220     C                             %TRIM(dxpln) + '|' +
003500070220     C                             %TRIM(dxmar) + '|' +
003600070220     C                             %TRIM(dxrelc) + '|' +
003700070220     C                             %TRIM(dxdoh) + '|' +
003800070220     C                             %TRIM(dxdot) + '|' +
003900070220     C                             %TRIM(dxtyp) + '|' +
004000070220     C                             %TRIM(dxstf) + '|' +
004100070220     C                             %TRIM(dxf7) + '|' +
004200070220     C                             %TRIM(dxf8) + '|' +
004300070220     C                             %TRIM(dxf9) + '|' +
004400070220     C                             %TRIM(dxf10) + '|' +
004500070220     C                             %TRIM(dxf11) + '|'
004600060315    ***
004700060315     C                   EXCEPT    OUTFA
004800060315    ***
004900051110   S***S
005000060317     C**** *INZSR        BEGSR
005100051110    ***
005200060317     C***                EVAL      @OUTPUT = '"FIELD A","FIELD B","FIELD C",' +
005300060317     C****                         '"FIELD D"'
005400051110    ***
005500060317     C****               EXCEPT    OUTFA
005600051110    ***
005700060317     C**************     ENDSR
005800051110   S***S
005900051108   X***X
006000070220     ODXCSVP    EADD         OUTFA
006100060315     O                       @OUTPUT           2000
