000100130319     FPRFXBLKP  IPE  E           K DISK
000200130319     FPRFBLCSP  O  A F 2000        DISK
000300050823   X***X
000400060315     D @OUTPUT         S           2000A   INZ
000500051108     D @C              C                   CONST('","')
000600051108    ***
0007000704030025  *
0008000704030250 D                 DS
0009001303190251 D  pbtrst                 1      3  0
0010001303190251 D   patrst                1      3
0011001303190025  *
0012001303190250 D                 DS
0013001303190251 D  pbsub#                 1      3  0
0014001303190251 D   pasub#                1      3
001500081114   X* *
001600081114      *
001700080313     C                   CLEAR                   @OUTPUT
001800130319     C                   EVAL      @OUTPUT = %TRIM(patrst) + ',' +
001900130319     C                             %TRIM(pasub#) + ',' +
002000130319     C                             %TRIM(pbplan) + ',' +
002100130319     C                             %TRIM(pbcovtp) + ',' +
002200130917     C                             %TRIM(pbclass) + ',' +
002300130917     C                             %TRIM(pbgrp#)
002400060315    ***
002500060315     C                   EXCEPT    OUTFA
002600070403   S***S
002700070403     C**** *INZSR        BEGSR
002800070403    ***
002900070403     C***                EVAL      @OUTPUT = '"FIELD A","FIELD B","FIELD C",' +
003000070403     C****                         '"FIELD D"'
003100070403    ***
003200070403     C****               EXCEPT    OUTFA
003300070403    ***
003400070403     C**************     ENDSR
003500070403   S***S
003600070403   X***X
003700060315    ***
003800130319     OPRFBLCSP  EADD         OUTFA
003900060315     O                       @OUTPUT           2000
