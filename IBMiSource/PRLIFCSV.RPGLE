000100060504     FPRLIFP    IPE  E           K DISK
000200060504     FPRLICSVP  O  A F 2000        DISK
000300050823   X***X
000400060315     D @OUTPUT         S           2000A   INZ
000500051108     D @C              C                   CONST('","')
000600051108    ***
000700050823   X***X
000800060315     C                   CLEAR                   @OUTPUT
000900060504     C                   EVAL      @OUTPUT = %TRIM(plrect) + ',' +
001000060504     C                             %TRIM(plctrc) + ',' +
001100060504     C                             %TRIM(plunit) + ',' +
001200060504     C                             %TRIM(plssn) + ',' +
001300060504     C                             %TRIM(plf0) + ',' + '"' +
001400060504     C                             %TRIM(pllnme) + '"' + ',' +
001500060504     C                             %TRIM(plfnme) + ',' +
001600060504     C                             %TRIM(plmi) + ',' +
001700060504     C                             %TRIM(pldob) + ',' +
001800060504     C                             %TRIM(plsex) + ',' +
001900060504     C                             %TRIM(pldoh) + ',' +
002000060504     C                             %TRIM(plterm) + ',' +
002100060504     C                             %TRIM(pltrmc) + ',' + '"' +
002200060504     C                             %TRIM(pladr1) + '"' + ',' +
002300060504     C                             %TRIM(pladr2) + ',' +
002400060504     C                             %TRIM(plfil1) + ',' +
002500060504     C                             %TRIM(plcity) + ',' +
002600060504     C                             %TRIM(plst) + ',' +
002700060504     C                             %TRIM(plzip) + ',' +
002800060504     C                             %TRIM(plzip4) + ',' +
002900060504     C                             %TRIM(ploeff) + ',' +
003000060504     C                             %TRIM(plsal) + ',' +
003100060504     C                             %TRIM(plsalm) + ',' +
003200060504     C                             %TRIM(plseff) + ',' +
003300060504     C                             %TRIM(plf2) + ',' +
003400060504     C                             %TRIM(plf3) + ',' +
003500060504     C                             %TRIM(plbena) + ',' +
003600060504     C                             %TRIM(plsmst) + ',' +
003700060504     C                             %TRIM(plf4) + ',' +
003800060504     C                             %TRIM(plbnef) + ',' +
003900060504     C                             %TRIM(plcvtm) + ',' +
004000060504     C                             %TRIM(plf5) + ',' +
004100060504     C                             %TRIM(plf6) + ',' +
004200060504     C                             %TRIM(plf7) + ',' +
004300060504     C                             %TRIM(psbena) + ',' +
004400060504     C                             %TRIM(pssmst) + ',' +
004500060504     C                             %TRIM(psf1) + ',' +
004600060504     C                             %TRIM(psdob) + ',' +
004700060504     C                             %TRIM(psbnef) + ',' +
004800060504     C                             %TRIM(pscvtm) + ',' +
004900060504     C                             %TRIM(psf2) + ',' +
005000060504     C                             %TRIM(psf3) + ',' +
005100060504     C                             %TRIM(psf4) + ',' +
005200060504     C                             %TRIM(pcbena) + ',' +
005300060504     C                             %TRIM(pcf1) + ',' +
005400060504     C                             %TRIM(pcf2) + ',' +
005500060504     C                             %TRIM(pcbnef) + ',' +
005600060504     C                             %TRIM(pccvtm) + ',' +
005700060504     C                             %TRIM(pcf5) + ',' +
005800060504     C                             %TRIM(pcf6) + ',' +
005900060504     C                             %TRIM(pc0)
006000060315    ***
006100060315     C                   EXCEPT    OUTFA
006200060315    ***
006300051110   S***S
006400060317     C**** *INZSR        BEGSR
006500051110    ***
006600060317     C***                EVAL      @OUTPUT = '"FIELD A","FIELD B","FIELD C",' +
006700060317     C****                         '"FIELD D"'
006800051110    ***
006900060317     C****               EXCEPT    OUTFA
007000051110    ***
007100060317     C**************     ENDSR
007200051110   S***S
007300051108   X***X
007400060504     OPRLICSVP  EADD         OUTFA
007500060315     O                       @OUTPUT           2000
