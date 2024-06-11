000100120710     FDELEXCP   IPE  E           K DISK
000200120710     FDBCSVP    O  A F 2000        DISK
000300050823   X***X
000400060315     D @OUTPUT         S           2000A   INZ
000500051108     D @C              C                   CONST('","')
000600051108    ***
0007000704030025  *
000800081114      *
000900080313     C                   CLEAR                   @OUTPUT
001000120710     C                   EVAL      @OUTPUT = %TRIM(dbgrp) + ',' +
001100120710     C                             %TRIM(dbsgrp) + ',' +
001200120710     C                             %TRIM(dbsubn) + ',' +
001300120710     C                             %TRIM(dbsufx) + ',' +
001400120710     C                             %TRIM(dbclas) + ',' +
001500120710     C                             %TRIM(dbclef) + ',' +
001600120710     C                             %TRIM(dbhrdt) + ',' +
001700120710     C                             %TRIM(dbelc1) + ',' +
001800120710     C                             %TRIM(dbeld1) + ',' +
001900120710     C                             %TRIM(dbelt1) + ',' +
002000120710     C                             %TRIM(dbfmi1) + ',' +
002100120710     C                             %TRIM(dbelc2) + ',' +
002200120710     C                             %TRIM(dbeld2) + ',' +
002300120710     C                             %TRIM(dbelt2) + ',' +
002400120710     C                             %TRIM(dbfmi2) + ',' +
002500120710     C                             %TRIM(dbelc3) + ',' +
002600120710     C                             %TRIM(dbeld3) + ',' +
002700120710     C                             %TRIM(dbelt3) + ',' +
002800120710     C                             %TRIM(dbfmi3) + ',' +
002900120710     C                             %TRIM(dbelc4) + ',' +
003000120710     C                             %TRIM(dbeld4) + ',' +
003100120710     C                             %TRIM(dbelt4) + ',' +
003200120710     C                             %TRIM(dbfmi4) + ',' + '"' +
003300120710     C                             %TRIM(dbadd1) + '"' + ',' + '"' +
003400120710     C                             %TRIM(dbadd2) + '"' + ',' + '"' +
003500120710     C                             %TRIM(dbcity) + '"' + ',' +
003600120710     C                             %TRIM(dbstat) + ',' +
003700120710     C                             %TRIM(dbzip) + ',' +
003800120712     C                             %TRIM(dbhphn) + ',' +
003900120712     C                             %TRIM(dbrelc) + ',' + '"' +
004000120710     C                             %TRIM(dblnam) + '"' + ',' + '"' +
004100120710     C                             %TRIM(dbfnam) + '"' + ',' +
004200120710     C                             %TRIM(dbmidi) + ',' +
004300120710     C                             %TRIM(dbeffd) + ',' +
004400120710     C                             %TRIM(dbmssn) + ',' +
004500120710     C                             %TRIM(dbsex) + ',' +
004600120710     C                             %TRIM(dbmdob) + ',' +
004700120710     C                             %TRIM(dbtmdt) + ',' + '"' +
004800120710     C                             %TRIM(dbresn) + '"'
004900060315    ***
005000060315     C                   EXCEPT    OUTFA
005100070403   S***S
005200070403     C**** *INZSR        BEGSR
005300070403    ***
005400070403     C***                EVAL      @OUTPUT = '"FIELD A","FIELD B","FIELD C",' +
005500070403     C****                         '"FIELD D"'
005600070403    ***
005700070403     C****               EXCEPT    OUTFA
005800070403    ***
005900070403     C**************     ENDSR
006000070403   S***S
006100070403   X***X
006200060315    ***
006300120710     ODBCSVP    EADD         OUTFA
006400060315     O                       @OUTPUT           2000
