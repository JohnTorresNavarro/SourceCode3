000100220317     FDDMELIGP  IPE  E           K DISK
000200220317     FDDMCSVP   O  A F 1000        DISK
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
001600220317     C                   EVAL      @OUTPUT = %TRIM(dmessn) + ',' +
001700220317     C                             %TRIM(dmgacc) + ',' +
001800220317     C                             %TRIM(dmgrp#) + ',' +
001900220317     C                             %TRIM(dmdiv#) + ',' +
002000220317     C                             %TRIM(dmeffdt) + ',' +
002100220317     C                             %TRIM(dmtrmdt) + ',' +
002200220317     C                             %TRIM(dmmfnam) + ',' +
002300220317     C                             %TRIM(dmmlnam) + ',' +
002400220317     C                             %TRIM(dmmdob) + ',' +
002500220317     C                             %TRIM(dmsex) + ',' +
002600220317     C                             %TRIM(dmst) + ',,' +
002700220317     C                             %TRIM(dmcovt) + ',' +
002800220317     C                             %TRIM(dmrelc)
002900201006    * *
003000060315     C                   EXCEPT    OUTFA
003100201006   S* *
003200201006     C     *INZSR        BEGSR
003300201006    * *
003400220316     C                   EVAL      @OUTPUT = 'EE_SSNO,' +
003500220316     C                             'EMPLOYER_NO,' +
003600220316     C                             'DELTA_GROUP_NO,' +
003700220316     C                             'DELTA_DIVISION_NO,' +
003800220316     C                             'EFFECTIVE_DATE,' +
003900220316     C                             'TERM_DATE,' +
004000220316     C                             'FIRST_NAME,' +
004100220316     C                             'LAST_NAME,' +
004200220316     C                             'DOB,' +
004300220316     C                             'GENDER,' +
004400210804     C                             'STATE,' +
004500220316     C                             'COBRA,' +
004600220316     C                             'TIER_CODE,' +
004700220602     C                             'REL_CODE'
004800201006    * *
004900201006     C                   EXCEPT    OUTFA
005000201006    * *
005100201006     C                   ENDSR
005200201006    * *
005300201006     C
005400060315    ***
005500220317     ODDMCSVP   EADD         OUTFA
005600220317     O                       @OUTPUT           1000
