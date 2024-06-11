000100220408     Feligpuxp  IPE  E           K DISK
000200220408     FELIGPCSVP O  A F 5000        DISK
000300050823   X***X
000400220408     D @OUTPUT         S           5000A   INZ
000500051108     D @C              C                   CONST('","')
000600051108    ***
0007000704030025  *
0008002108050025  *
0009000811140250 D                 DS
0010002204080251 D  epmssn                 1      9  0
0011002204080251 D   eamssn                1      9
001200210804      *
0013002204080250 D                 DS
0014002204080251 D  epissn                 1      9  0
0015002204080251 D   eaissn                1      9
001600220408      *
001700081114   X* *
001800110720      *
001900081114      *
002000080313     C                   CLEAR                   @OUTPUT
002100220408     C                   EVAL      @OUTPUT = %TRIM (eamssn) + ',' + '"' +
002200220408     C                             %TRIM(epname) + '"' + ',' +
002300220408     C                             %TRIM (eaissn) + ',' +
002400220408     C                             %TRIM(eprel) + ',' +
002500220408     C                             %TRIM(epsex) + ',' +
002600220408     C                             %TRIM(epdob) + ',' +
002700220408     C                             %TRIM(epsmk) + ',' + '"' +
002800220408     C                             %TRIM(epadd1) + '"' + ',' + '"' +
002900220408     C                             %TRIM(epadd2) + '"' + ',' +
003000220408     C                             %TRIM(epcty) + ',' +
003100220408     C                             %TRIM(epst) + ',' +
003200220408     C                             %TRIM(epzip) + ',' +
003300220408     C                             %TRIM(epac) + ',' +
003400220408     C                             %TRIM(epphn) + ',' +
003500220408     C                             %TRIM(epdoh) + ',' +
003600220408     C                             %TRIM(epsts) + ',' +
003700220408     C                             %TRIM(epsal) + ',' +
003800220408     C                             %TRIM(epaseq) + ',' +
003900220408     C                             %TRIM(epdpln) + ',' +
004000220408     C                             %TRIM(epdter) + ',' +
004100220408     C                             %TRIM(epddsc) + ',' +
004200220408     C                             %TRIM(epdeff) + ',' +
004300220408     C                             %TRIM(epdgrp) + ',' +
004400220408     C                             %TRIM(epvpln) + ',' +
004500220408     C                             %TRIM(epvter) + ',' +
004600220408     C                             %TRIM(epvdsc) + ',' +
004700220408     C                             %TRIM(epveff) + ',' +
004800220408     C                             %TRIM(epvgrp)
004900201006    * *
005000060315     C                   EXCEPT    OUTFA
005100201006   S* *
005200201006     C     *INZSR        BEGSR
005300201006    * *
005400220408     C                   EVAL      @OUTPUT = 'MEMBER ID,' +
005500220408     C                             'NAME,' +
005600220408     C                             'SSN,' +
005700220408     C                             'RELATIONSHIP,' +
005800220408     C                             'GENDER,' +
005900220408     C                             'DATE OF BIRTH,' +
006000220408     C                             'SMOKER,' +
006100210804     C                             'ADDRESS 1,' +
006200210804     C                             'ADDRESS 2,' +
006300210804     C                             'CITY,' +
006400210804     C                             'STATE,' +
006500220408     C                             'ZIP,' +
006600220408     C                             'AREA CODE,' +
006700220408     C                             'PHONE NUMBER,' +
006800220408     C                             'HIRE DATE,' +
006900220408     C                             'STATUS,' +
007000220408     C                             'SALARY,' +
007100220408     C                             'SEQ,' +
007200220408     C                             'DEN PLAN,' +
007300220408     C                             'DEN TIER,' +
007400220408     C                             'DEN DESC,' +
007500220408     C                             'DEN EFF DATE,' +
007600220408     C                             'GROUP#,' +
007700220408     C                             'VIS PLAN,' +
007800220408     C                             'VIS TIER,' +
007900220408     C                             'VIS DESC,' +
008000220408     C                             'VIS EFF DATE,' +
008100220408     C                             'GROUP#'
008200201006    * *
008300201006     C                   EXCEPT    OUTFA
008400201006    * *
008500201006     C                   ENDSR
008600201006    * *
008700201006     C
008800060315    ***
008900220408     Oeligpcsvp EADD         OUTFA
009000220408     O                       @OUTPUT           5000
