000100090728     FMBIFP     IPE  E           K DISK
000200090728     FMBFCVP    O  A F  250        DISK
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
001400090728     C                   EVAL      @OUTPUT = %TRIM(ifrcid) + ',' +
001500090728     C                             %TRIM(iftpa) + ',' +
001600090728     C                             %TRIM(ifemlr) + ',' +
001700090728     C                             %TRIM(ifemly) + ',' +
001800090728     C                             %TRIM(ifdep) + ',' +
001900090728     C                             %TRIM(ifissu) + ',' +
002000090728     C                             %TRIM(ifadcd)
002100060315    ***
002200060315     C                   EXCEPT    OUTFA
002300070403   S***S
002400070403     C**** *INZSR        BEGSR
002500070403    ***
002600070403     C***                EVAL      @OUTPUT = '"FIELD A","FIELD B","FIELD C",' +
002700070403     C****                         '"FIELD D"'
002800070403    ***
002900070403     C****               EXCEPT    OUTFA
003000070403    ***
003100070403     C**************     ENDSR
003200070403   S***S
003300070403   X***X
003400060315    ***
003500090728     OMBFCVP    EADD         OUTFA
003600090728     O                       @OUTPUT            250
