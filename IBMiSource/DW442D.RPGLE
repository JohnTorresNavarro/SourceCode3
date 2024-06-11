000100140813     FMBCHG2P   IPE  E           K DISK
000200140813     FDEPNDC    IF   E           K DISK
000300140813     FMEMBER    IF   E           K DISK
000400140813     FHRCSVDP   O  A F 2000        DISK
000500050823   X***X
000600060315     D @OUTPUT         S           2000A   INZ
000700051108     D @C              C                   CONST('","')
000800051108    ***
0009000811140025  *
0010000811140250 D                 DS
0011001408130251 D  mxmid#                 1      9  0
0012001408130251 D   mnmid#                1      9
0013000704030025  *
0014000704030250 D                 DS
0015001408130251 D  mxseq#                 1      2  0
0016001408130251 D   mnseq#                1      2
0017000704030025  *
001800140813      *
001900140813     C     depkey        KLIST
002000140813     C                   KFLD                    mxmid#
002100140813     C                   KFLD                    mxseq#
0022000704030025  *
002300140813   X* *      Check for Debit Card request
002400150325     C                   if        mxcdbtc <> ' ' or mxccdat <> *loval
002500140813      *
002600140813     C     mxmid#        chain     member                             61
002700110720      *
002800140813     C                   movel     *blanks       deplnm           18
002900140813     C                   movel     *blanks       depfnm           12
003000140813     C                   if        mxseq# <> 0
003100140813     C     depkey        chain     depndc                             61
003200140813     C                   movel     dlname        deplnm
003300140813     C                   movel     dfname        depfnm
003400140813     C                   endif
003500140813      *
003600110419      *
003700080313     C                   CLEAR                   @OUTPUT
003800140813     C                   EVAL      @OUTPUT = '"' + %TRIM(mxacnm) + '"' + ',' +
003900140813     C                             %TRIM(mnmid#) + ',' +
004000140813     C                             %TRIM(mnseq#) + ',' + '"' +
004100140813     C                             %TRIM(mfname) + '"' + ',' + '"' +
004200140813     C                             %TRIM(mlname) + '"' + ',' + '"' +
004300140813     C                             %TRIM(depfnm) + '"' + ',' + '"' +
004400140813     C                             %TRIM(deplnm) + '"' + ',' +
004500140813     C                             %TRIM('HRA')
004600140813    * *
004700060315     C                   EXCEPT    OUTFA
004800140813    * *
004900140813     C                   endif
005000070403   S***S
005100140813     C     *INZSR        BEGSR
005200140813   X* *        Build Header Row
005300140813     C                   CLEAR                   @OUTPUT
005400140813     C                   EVAL      @OUTPUT = 'ACCOUNT NAME' + ',' +
005500140813     C                             'MBR SSN' + ',' +
005600140813     C                             'SEQ#' + ',' +
005700140813     C                             'MBR FIRST NM,' +
005800140813     C                             'MBR LAST NM,' +
005900140813     C                             'DEP FIRST NM,' +
006000140813     C                             'DEP FIRST NM,' +
006100140813     C                             'HRA/FSA'
006200140813    * *
006300140813     C                   EXCEPT    OUTFA
006400140813    * *
006500140813     C                   ENDSR
006600070403   S***S
006700070403   X***X
006800060315    ***
006900140813     OHRCSVDP   EADD         OUTFA
007000060315     O                       @OUTPUT           2000
