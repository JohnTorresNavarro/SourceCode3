000100240129     FDELBIL8P  IPE  E           K DISK
000200240129     FDBGCSVP   O  A F 1000        DISK
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
0012022403110250 D                 DS
0012032403110251 D  dbeld1                 1     10
0012042403110251 D   gdyy                  1      4
0012052403110251 D   gdmm                  5      6
0012062403110251 D   gddd                  7      8
001207240311      *
0012082403110250 D                 DS
0012092403110251 D  ddate                  1     10
0012102403110251 D   ddmm                  1      2
0012112403110251 D   ddd1                  3      3    INZ('/')
0012122403110251 D   dddd                  4      5
0012132403110251 D   ddd2                  6      6    INZ('/')
0012142403110251 D   ddyy                  7     10
001215240311      *
001300080313      *
001400081114      *
001402240311     C                   eval      ddate = *blanks
001403240311     C                   if        dbeld1 <> *blanks
001404240311     C                   eval      ddyy = gdyy
001405240311     C                   eval      ddd1 = '/'
001406240311     C                   eval      ddmm = gdmm
001407240311     C                   eval      ddd2 = '/'
001408240311     C                   eval      dddd = gddd
001409240311     C                   endif
001410240311      *
001500080313     C                   CLEAR                   @OUTPUT
001600240129     C                   EVAL      @OUTPUT = %TRIM(dbgrp) + ',' +
001700240129     C                             %TRIM(dbclas) + ',' +
001701240208     C                             %TRIM(dbsubn) + ',' + '"' +
001800240208     C                             %TRIM(dblnam) + '"' + ',' + '"' +
001801240208     C                             %TRIM(dbfnam) + '"' + ',' +
001900240129     C                             %TRIM(dbrelc) + ',' +
002000240129     C                             %TRIM(dbmssn) + ',' +
002001240311     C                             %TRIM(ddate) + ',' +
002100240129     C                             %TRIM(dbsex)
002900201006    * *
003000060315     C                   EXCEPT    OUTFA
003100201006   S* *
003200201006     C     *INZSR        BEGSR
003300201006    * *
003400240312     C                   EVAL      @OUTPUT = 'Group#,' +
003500240312     C                             'Class,' +
003600240312     C                             'Subscriber#,' +
003700240312     C                             'Last Name,' +
003701240129     C                             'First Name,' +
003800240129     C                             'Rel Code,' +
003900240129     C                             'SSN,' +
003901240311     C                             'Eff Date,' +
003902240129     C                             'Sex,'
004800201006    * *
004900201006     C                   EXCEPT    OUTFA
005000201006    * *
005100201006     C                   ENDSR
005200201006    * *
005300201006     C
005400060315    ***
005500240129     ODBGCSVP   EADD         OUTFA
005600220317     O                       @OUTPUT           1000
