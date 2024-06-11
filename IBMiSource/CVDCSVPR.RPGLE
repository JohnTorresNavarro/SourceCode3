000100090316     FCDCURP    IPE  E           K DISK
000200090316     FCDCSVP    O  A F 2000        DISK
000300050823   X***X
000400060315     D @OUTPUT         S           2000A   INZ
000500051108     D @C              C                   CONST('","')
000600051108    ***
000700050823   X***X
000800060315     C                   CLEAR                   @OUTPUT
000900090316     C                   EVAL      @OUTPUT = %TRIM(cdlnme) + '|' +
001000090316     C                             %TRIM(cdfnme) + '|' +
001100090316     C                             %TRIM(cdf1) + '|' +
001200090316     C                             %TRIM(cdf2) + '|' +
001300090316     C                             %TRIM(cdmi) + '|' +
001400090316     C                             %TRIM(cdsex) + '|' +
001500090316     C                             %TRIM(cddob) + '|' +
001600090316     C                             %TRIM(cdadd1) + '|' +
001700090316     C                             %TRIM(cdadd2) + '|' +
001800090316     C                             %TRIM(cdcity) + '|' +
001900090316     C                             %TRIM(cdst) + '|' +
002000090316     C                             %TRIM(cdzip) + '|' +
002100090316     C                             %TRIM(cdz4) + '|' +
002200090316     C                             %TRIM(cdphn) + '|' +
002300090316     C                             %TRIM(cdwphn) + '|' +
002400090316     C                             %TRIM(cdwex) + '|' +
002500090316     C                             %TRIM(cdcphn) + '|' +
002600090316     C                             %TRIM(cdsssn) + '|' +
002700090316     C                             %TRIM(cdmssn) + '|' +
002800090316     C                             %TRIM(cdemid) + '|' +
002900090316     C                             %TRIM(cdmbid) + '|' +
003000090316     C                             %TRIM(cdclnm) + '|' +
003100090316     C                             %TRIM(cdf3) + '|' +
003200090316     C                             %TRIM(cdgrp#) + '|' +
003300090316     C                             %TRIM(cdftpid) + '|' +
003400090316     C                             %TRIM(cdf5) + '|' +
003500090316     C                             %TRIM(cdf6) + '|' +
003600090316     C                             %TRIM(cdeff) + '|' +
003700090316     C                             %TRIM(cdtrm) + '|' +
003800090316     C                             %TRIM(cdpln) + '|' +
003900090316     C                             %TRIM(cdmar) + '|' +
004000090316     C                             %TRIM(cdrelc) + '|' +
004100090316     C                             %TRIM(cddoh) + '|' +
004200090316     C                             %TRIM(cddot) + '|' +
004300090316     C                             %TRIM(cdtyp) + '|' +
004400090316     C                             %TRIM(cdstf) + '|' +
004500090316     C                             %TRIM(cdoth) + '|' +
004600090316     C                             %TRIM(cdrect) + '|'
004700060315    ***
004800060315     C                   EXCEPT    OUTFA
004900060315    ***
005000051110   S***S
005100060317     C**** *INZSR        BEGSR
005200051110    ***
005300060317     C***                EVAL      @OUTPUT = '"FIELD A","FIELD B","FIELD C",' +
005400060317     C****                         '"FIELD D"'
005500051110    ***
005600060317     C****               EXCEPT    OUTFA
005700051110    ***
005800060317     C**************     ENDSR
005900051110   S***S
006000051108   X***X
006100090316     OCDCSVP    EADD         OUTFA
006200060315     O                       @OUTPUT           2000
