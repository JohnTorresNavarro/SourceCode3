000100230502     FMBRDUPP   IPE  E           K DISK
000200230502     FMBRDCSVP  O  A F 1200        DISK
000300050823   X***X
000400230502     D @OUTPUT         S           1200A   INZ
000500051108     D @C              C                   CONST('","')
000600051108    ***
0007000704030025  *
0008002108050025  *
0009000811140250 D                 DS
0010002305020251 D  mdssn                  1      9  0
0011002305020251 D   assn                  1      9
0012000704030025  *
0012012305020250 D                 DS
0012022305020251 D  mdzip                  1      9  0
0012032305020251 D   azip                  1      9
0012042305020025  *
001300080313      *
001400081114      *
001500080313     C                   CLEAR                   @OUTPUT
001600230502     C                   EVAL      @OUTPUT = %TRIM(assn) + ',' +
001601230502     C                             %TRIM(mdlnam) + ',' +
001602230502     C                             %TRIM(mdfnam) + ',' +
001700230502     C                             %TRIM(mdmi) + ',' +
001800230502     C                             %TRIM(mdacct) + ',' +
001801230502     C                             %TRIM(mddob) + ',' +
001802230502     C                             %TRIM(mdsex) + ',' +
001803230502     C                             %TRIM(azip) + ',' +
001804230502     C                             %TRIM(mdenrl) + ',' +
001805230502     C                             %TRIM(mdterm)
002900201006    * *
003000060315     C                   EXCEPT    OUTFA
003100201006   S* *
003200201006     C     *INZSR        BEGSR
003300201006    * *
003400230502     C                   EVAL      @OUTPUT = 'SSN,' +
003500230502     C                             'FIRST NAME,' +
003501230502     C                             'LAST NAME,' +
003600230502     C                             'MI,' +
003700230502     C                             'ACCOUNT#,' +
003800230502     C                             'DATE OF BIRTH,' +
003900230502     C                             'GENDER,' +
004000230502     C                             'ZIP,' +
004100230502     C                             'ENROLL DT,' +
004700230502     C                             'TERM DT'
004800201006    * *
004900201006     C                   EXCEPT    OUTFA
005000201006    * *
005100201006     C                   ENDSR
005200201006    * *
005300201006     C
005400060315    ***
005500230502     OMBRDCSVP  EADD         OUTFA
005600230502     O                       @OUTPUT           1200
