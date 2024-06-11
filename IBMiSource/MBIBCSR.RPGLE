000100090728     FMBIBP     IPE  E           K DISK
000200090728     FMBBCVP    O  A F  250        DISK
000300050823   X***X
000400090728     D @OUTPUT         S            250A   INZ
000500051108     D @C              C                   CONST('","')
000600051108    ***
0007000704030025  *
0008000704030250 D                 DS
0009000704030251 D  bgmid#                 1      9  0
0010000704030251 D   bnmid#                1      9
0011000704030025  *
001200050823   X***X
001300060315     C                   CLEAR                   @OUTPUT
001400090728     C                   EVAL      @OUTPUT = %TRIM(ibrcid) + ',' +
001500090728     C                             %TRIM(ibtpa) + ',' +
001600090728     C                             %TRIM(ibemlr) + ',' +
001700090728     C                             %TRIM(ibemly) + ',' +
001800090728     C                             %TRIM(iblnme) + ',' +
001900090728     C                             %TRIM(ibfnme) + ',' +
002000090728     C                             %TRIM(ibmi) + ',' +
002100090728     C                             %TRIM(ibphn#) + ',' +
002200090728     C                             %TRIM(ibadr1) + ',' +
002300090728     C                             %TRIM(ibadr2) + ',' +
002400090728     C                             %TRIM(ibcity) + ',' +
002500090728     C                             %TRIM(ibst) + ',' +
002600090728     C                             %TRIM(ibzip) + ',' +
002700090728     C                             %TRIM(ibcnty) + ',' +
002800090728     C                             %TRIM(ibgndr) + ',' +
002900090728     C                             %TRIM(ibbrdt)
003000060315    ***
003100060315     C                   EXCEPT    OUTFA
003200070403   S***S
003300070403     C**** *INZSR        BEGSR
003400070403    ***
003500070403     C***                EVAL      @OUTPUT = '"FIELD A","FIELD B","FIELD C",' +
003600070403     C****                         '"FIELD D"'
003700070403    ***
003800070403     C****               EXCEPT    OUTFA
003900070403    ***
004000070403     C**************     ENDSR
004100070403   S***S
004200070403   X***X
004300060315    ***
004400090728     OMBBCVP    EADD         OUTFA
004500090728     O                       @OUTPUT            250
