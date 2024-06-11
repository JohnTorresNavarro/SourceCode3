000100220331     Flumxrefi5 IPE  E           K DISK
000200220331     Flumcsvp   O  A F 1000        DISK
000300050823   X***X
000400220317     D @OUTPUT         S           1000A   INZ
000500051108     D @C              C                   CONST('","')
000600051108    ***
0007000704030025  *
0008002108050025  *
0009000811140250 D                 DS
0010002108050251 D  ebmid#                 1      9  0
0011002108180251 D   eamid#                1      9
0012000704030025  *
001300080313      *
001400081114      *
001500080313     C                   CLEAR                   @OUTPUT
001600220331     C                   EVAL      @OUTPUT = %TRIM(lmddsf) + ',' +
001700220331     C                             %TRIM(lmlumf) + ',' +
001800220331     C                             %TRIM(lmpgmn) + ',' +
001900220331     C                             %TRIM(lmdesc) + ',' +
002000220331     C                             %TRIM(lmlocn) + ',' +
002100220331     C                             %TRIM(lmdwn)
002200201006    * *
002300060315     C                   EXCEPT    OUTFA
002400201006   S* *
002500201006     C     *INZSR        BEGSR
002600201006    * *
002700220331     C                   EVAL      @OUTPUT = 'DDS File Name,' +
002800220331     C                             'LUM File Name,' +
002900220331     C                             'Scrubber Prog,' +
003000220331     C                             'File Description,' +
003100220331     C                             'File Locatiom,' +
003200220331     C                             'Run Schedule'
003300201006    * *
003400201006     C                   EXCEPT    OUTFA
003500201006    * *
003600201006     C                   ENDSR
003700201006    * *
003800201006     C
003900060315    ***
004000220331     OLUMCSVP   EADD         OUTFA
004100220317     O                       @OUTPUT           1000
