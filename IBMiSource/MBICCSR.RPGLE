000100090728     FMBICP     IPE  E           K DISK
000200090728     FMBCCVP    O  A F  250        DISK
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
001400090728     C                   EVAL      @OUTPUT = %TRIM(icrcid) + ',' +
001500090728     C                             %TRIM(ictpa) + ',' +
001600090728     C                             %TRIM(icemlr) + ',' +
001700090728     C                             %TRIM(icplan) + ',' +
001800090728     C                             %TRIM(icemly) + ',' +
001900090728     C                             %TRIM(icactp) + ',' +
002000090728     C                             %TRIM(icpeff) + ',' +
002100090728     C                             %TRIM(icptrm) + ',' +
002200090728     C                             %TRIM(icsts) + ',' +
002300090728     C                             %TRIM(iceypp) + ',' +
002400090728     C                             %TRIM(icerpp) + ',' +
002500090728     C                             %TRIM(iceeff) + ',' +
002600090728     C                             %TRIM(icetrm)
002700060315    ***
002800060315     C                   EXCEPT    OUTFA
002900070403   S***S
003000070403     C**** *INZSR        BEGSR
003100070403    ***
003200070403     C***                EVAL      @OUTPUT = '"FIELD A","FIELD B","FIELD C",' +
003300070403     C****                         '"FIELD D"'
003400070403    ***
003500070403     C****               EXCEPT    OUTFA
003600070403    ***
003700070403     C**************     ENDSR
003800070403   S***S
003900070403   X***X
004000060315    ***
004100090728     OMBCCVP    EADD         OUTFA
004200090728     O                       @OUTPUT            250
