000100080717     FDXCUXP    IPE  E           K DISK
000200090403     FDXXSVP    O  A F 2000        DISK
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
001300080717     C                             %TRIM(dxmi) + '|' +
001400080717     C                             %TRIM(dxsex) + '|' +
001500080717     C                             %TRIM(dxdob) + '|' +
001600080717     C                             %TRIM(dxadd1) + '|' +
001700080717     C                             %TRIM(dxadd2) + '|' +
001800080717     C                             %TRIM(dxcity) + '|' +
001900080717     C                             %TRIM(dxst) + '|' +
002000080717     C                             %TRIM(dxzip) + '|' +
002100080717     C                             %TRIM(dxz4) + '|' +
002200080717     C                             %TRIM(dxphn) + '|' +
002300090402     C                             %TRIM(dxwphn) + '|' +
002400090402     C                             %TRIM(dxwex) + '|' +
002500090402     C                             %TRIM(dxcphn) + '|' +
002600080717     C                             %TRIM(dxsssn) + '|' +
002700070220     C                             %TRIM(dxmssn) + '|' +
002800090402     C                             %TRIM(dxemid) + '|' +
002900090402     C                             %TRIM(dxmbid) + '|' +
003000070220     C                             %TRIM(dxclnm) + '|' +
003100070220     C                             %TRIM(dxf3) + '|' +
003200070220     C                             %TRIM(dxgrp#) + '|' +
003300070220     C                             %TRIM(dxftpid) + '|' +
003400070220     C                             %TRIM(dxf5) + '|' +
003500070220     C                             %TRIM(dxf6) + '|' +
003600070220     C                             %TRIM(dxeff) + '|' +
003700070220     C                             %TRIM(dxtrm) + '|' +
003800070220     C                             %TRIM(dxpln) + '|' +
003900070220     C                             %TRIM(dxmar) + '|' +
004000070220     C                             %TRIM(dxrelc) + '|' +
004100070220     C                             %TRIM(dxdoh) + '|' +
004200070220     C                             %TRIM(dxdot) + '|' +
004300070220     C                             %TRIM(dxtyp) + '|' +
004400070220     C                             %TRIM(dxstf) + '|' +
004500090402     C                             %TRIM(dxoth) + '|' +
004600090402     C                             %TRIM(dxrect) + '|'
004700060315    ***
004800060315     C                   EXCEPT    OUTFA
004900060315    ***
005000051110   S***S
005100060317     C**** *INZSR        BEGSR
005200051110    ***
005300060317     C***                EVAL      @OUTPUT = '"FIELD A","FIELD B","FIELD C",' +
005400060317     C****                         '"FIELD D"'
005500051110    ***
005600060317     C****               EXCEPT    OUTFA
005700051110    ***
005800060317     C**************     ENDSR
005900051110   S***S
006000051108   X***X
006100090403     ODXXSVP    EADD         OUTFA
006200060315     O                       @OUTPUT           2000
