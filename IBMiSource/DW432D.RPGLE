000100100805     FFSCHGP    IPE  E           K DISK
000200140813     FDEPNDC    IF   E           K DISK
000300140813     FMEMBER    IF   E           K DISK
000400140813     FFSCSVDP   O  A F 2000        DISK
000500050823   X***X
000600060315     D @OUTPUT         S           2000A   INZ
000700051108     D @C              C                   CONST('","')
000800051108    ***
0009000811140025  *
0010000811140250 D                 DS
0011001008050251 D  fxmid#                 1      9  0
0012001408130251 D   fnmid#                1      9
0013000704030025  *
0014000704030250 D                 DS
0015001008050251 D  fxseq#                 1      2  0
0016001008050251 D   fnseq#                1      2
0017000704030025  *
0018000704030250 D                 DS
0019001008050251 D  fxhdssn                1      9  0
0020001008050251 D   fnhdssn               1      9
0021000704030025  *
0022000803040250 D                 DS
0023001008050251 D  fxcdssn                1      9  0
0024001008050251 D   fncdssn               1      9
0025000704030025  *
0026000704030250 D                 DS
0027001008050251 D  fxsub                  1      3  0
0028001008050251 D   fnsub                 1      3
0029000704030025  *
0030000704030250 D                 DS
0031001008050251 D  fxacct                 1      4  0
0032001008050251 D   fnacct                1      4
003300140813      *
003400140813     C     depkey        KLIST
003500140813     C                   KFLD                    fxmid#
003600140813     C                   KFLD                    fxseq#
0037000704030025  *
003800140813   X* *      Check for Debit Card request
003900150325     C                   if        fxcdbtc <> ' ' or fxccdat <> *loval
004000140813      *
004100140813     C     fxmid#        chain     member                             61
004200110720      *
004300140813     C                   movel     *blanks       deplnm           18
004400140813     C                   movel     *blanks       depfnm           12
004500140813     C                   if        fxseq# <> 0
004600140813     C     depkey        chain     depndc                             61
004700140813     C                   movel     dlname        deplnm
004800140813     C                   movel     dfname        depfnm
004900140813     C                   endif
005000140813      *
005100110419      *
005200080313     C                   CLEAR                   @OUTPUT
005300140813     C                   EVAL      @OUTPUT = '"' + %TRIM(fxacnm) + '"' + ',' +
005400140813     C                             %TRIM(fnmid#) + ',' +
005500140813     C                             %TRIM(fnseq#) + ',' + '"' +
005600140813     C                             %TRIM(mfname) + '"' + ',' + '"' +
005700140813     C                             %TRIM(mlname) + '"' + ',' + '"' +
005800140813     C                             %TRIM(depfnm) + '"' + ',' + '"' +
005900140813     C                             %TRIM(deplnm) + '"' + ',' +
006000140813     C                             %TRIM('FSA')
006100140813    * *
006200060315     C                   EXCEPT    OUTFA
006300140813    * *
006400140813     C                   endif
006500070403   S***S
006600140813     C     *INZSR        BEGSR
006700140813   X* *        Build Header Row
006800140813     C                   CLEAR                   @OUTPUT
006900140813     C                   EVAL      @OUTPUT = 'ACCOUNT NAME' + ',' +
007000140813     C                             'MBR SSN' + ',' +
007100140813     C                             'SEQ#' + ',' +
007200140813     C                             'MBR FIRST NM,' +
007300140813     C                             'MBR LAST NM,' +
007400140813     C                             'DEP FIRST NM,' +
007500140813     C                             'DEP FIRST NM,' +
007600140813     C                             'HRA/FSA'
007700140813    * *
007800140813     C                   EXCEPT    OUTFA
007900140813    * *
008000140813     C                   ENDSR
008100070403   S***S
008200070403   X***X
008300060315    ***
008400140813     OFSCSVDP   EADD         OUTFA
008500060315     O                       @OUTPUT           2000
