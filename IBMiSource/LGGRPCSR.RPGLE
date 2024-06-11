000100230928     FLGGRPRNWP IPE  E           K DISK
000200230928     FLGGRPCSVP O  A F 1500        DISK
000300050823   X***X
000400230928     D @OUTPUT         S           1500A   INZ
000500051108     D @C              C                   CONST('","')
0007012310260025  *
0007022310260250 D                 DS
0007032310260251 D  lrmkfm                 1      5  0
0007042310260251 D   mkfma                 1      5
0007052310260025  *
0007062310260250 D                 DS
0007072310260251 D  lrmkto                 1      5  0
0007082310260251 D   mktoa                 1      5
0008002108050025  *
0009000811140250 D                 DS
0010002309280251 D  accnum                 1     12
0011002309280251 D   trsta                 1      3
0011012309280251 D   dsh1                  4      4    INZ('-')
0011022309280251 D   suba                  5      7
0011032309280251 D   dsh2                  8      8    INZ('-')
0011042309280251 D   accta                 9     12
0012000704030025  *
001300080313      *
001400081114      *
001500230928     C                   movel     lrtrst        trsta
001501230928     C                   movel     lrsub#        suba
001502230928     C                   movel     lracct        accta
001503230928     C                   CLEAR                   @OUTPUT
001600230928     C                   EVAL      @OUTPUT = %TRIM(accnum) + ',' + '"' +
001700230928     C                             %TRIM(lranam) + '"' + ',' +
001800230928     C                             %TRIM(lrcarr) + ',' +
001801230928     C                             %TRIM(lrplan) + ',' + '"' +
001900230928     C                             %TRIM(lrpdsc) + '"' + ',' +
002000230928     C                             %TRIM(lrrnmo) + ',' +
002001230928     C                             %TRIM(lrrnyr) + ',' +
002002230928     C                             %TRIM(lrgrp#) + ',' +
002003230928     C                             %TRIM(lrprvnd) + ',' + '"' +
002004230928     C                             %TRIM(lrrsmnm) + '"' + ',' + '"' +
002006231026     C                             %TRIM(lrbrkr) + '"' + ',' +
002100230928     C                             %TRIM(lrcsvc) + ',' +
002200231127     C                             %TRIM(lractp) + ',' +
002201231127     C                             %TRIM(lrmksz) + ',' +
002202231026     C                             %TRIM(mkfma) + ',' +
002203231026     C                             %TRIM(mktoa) + ',' +
002204230928     C                             %TRIM(lrbrkf) + ',' +
002205230928     C                             %TRIM(lrefdt) + ',' +
002206230928     C                             %TRIM(lrtmdt) + ',' +
002207230928     C                             %TRIM(lrrtend)
002900201006    * *
003000060315     C                   EXCEPT    OUTFA
003100201006   S* *
003200201006     C     *INZSR        BEGSR
003300201006    * *
003400230928     C                   EVAL      @OUTPUT = 'ACCT#,' +
003500230928     C                             'ACCOUNT NAME,' +
003600230928     C                             'CARRIER,' +
003700230928     C                             'PLAN#,' +
003701230928     C                             'PLAN NAME,' +
003800230928     C                             'RENEWAL MONTH,' +
003801230928     C                             'RENEWAL YEAR,' +
003802230928     C                             'CARRIER GRP#,' +
003803230928     C                             'PAYROLL VENDOR,' +
003804230928     C                             'RSM NAME,' +
003805230928     C                             'BROKER/AGENCY,' +
003806231026     C                             'CUSTOMER SVC TEAM,' +
003807231127     C                             'ACCOUNT TYPE,' +
003808231026     C                             'MARKET SIZE,' +
003809231026     C                             'SIZE FROM,' +
003810231026     C                             'SIZE TO,' +
003811231026     C                             'BROKER SVC FEE,' +
003812231026     C                             'EFFECTIVE DATE,' +
003813231026     C                             'CANCEL DATE,' +
003814230928     C                             'RATES END,'
004800201006    * *
004900201006     C                   EXCEPT    OUTFA
005000201006    * *
005100201006     C                   ENDSR
005200201006    * *
005300201006     C
005400060315    ***
005500230928     OLGGRPCSVP EADD         OUTFA
005600230928     O                       @OUTPUT           1500
