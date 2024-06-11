000100091014     FMBPRNP    IPE  E           K DISK
000200091014     FMBPCSVP   O  A F 2000        DISK
000300050823   X***X
000400060315     D @OUTPUT         S           2000A   INZ
000500051108     D @C              C                   CONST('","')
000600051108    ***
0007000704030025  *
0008000803130250 D                 DS
0009000811140251 D  datymd                 1      8  0
0010000811140251 D   dtymdyy               1      4
0011000811140251 D   dtymdmd               5      8
0012000704030025  *
0013000704030250 D                 DS
0014000910140251 D  mrhpefd                1      8  0
0015000910140251 D   mnhpefd               9     16
0016000910140025  *
0017000910140250 D                 DS
0018000910140251 D  mrcpefd                1      8  0
0019000910140251 D   mncpefd               9     16
0020000910140025  *
0021000910140250 D                 DS
0022000910140251 D  mrhptrd                1      8  0
0023000910140251 D   mnhptrd               9     16
0024000910140025  *
0025000910140250 D                 DS
0026000910140251 D  mrcptrd                1      8  0
0027000910140251 D   mncptrd               9     16
0028000803040025  *
0029000707180025  *
0030000704030250 D                 DS
0031000910140251 D  mrtrst                 1      3  0
0032000809090251 D   mntrst                1      3
0033000704030025  *
0034000704030250 D                 DS
0035000910140251 D  mrsub                  1      3  0
0036000809090251 D   mnsub                 1      3
0037000704030025  *
0038000704030250 D                 DS
0039000910140251 D  mracct                 1      4  0
0040000809090251 D   mnacct                1      4
0041000704030025  *
0042000704030250 D                 DS
0043000910140251 D  mrdate                 1      8  0
0044000809090251 D   mndate                9     16
0045000811140025  *
004600080313      *
004700091014     C                   eval      datymd = mrhpefd
004800091014     C                   movel     dtymdmd       mnhpefd
004900091014     C                   move      dtymdyy       mnhpefd
005000080313      *
005100091014     C                   eval      datymd = mrcpefd
005200091014     C                   movel     dtymdmd       mncpefd
005300091014     C                   move      dtymdyy       mncpefd
005400091014      *
005500091014     C                   eval      datymd = mrhptrd
005600091014     C                   movel     dtymdmd       mnhptrd
005700091014     C                   move      dtymdyy       mnhptrd
005800091014      *
005900091014     C                   eval      datymd = mrcptrd
006000091014     C                   movel     dtymdmd       mncptrd
006100091014     C                   move      dtymdyy       mncptrd
006200091014      *
006300091014     C                   eval      datymd = mrdate
006400091014     C                   movel     dtymdmd       mndate
006500091014     C                   move      dtymdyy       mndate
006600091014      *
006700081114      *
006800080313     C                   CLEAR                   @OUTPUT
006900091014     C                   EVAL      @OUTPUT = %TRIM(mrsts) + ',' +
007000091014     C                             %TRIM(mrgrp#) + ',' +
007100091014     C                             %TRIM(mntrst) + ',' +
007200091014     C                             %TRIM(mnsub) + ',' +
007300091014     C                             %TRIM(mnacct) + ',' + '"' +
007400091014     C                             %TRIM(mracnm) + '"' + ',' +
007500091014     C                             %TRIM(mrplan) + ',' +
007600091014     C                             %TRIM(mnhpefd) + ',' +
007700091014     C                             %TRIM(mncpefd) + ',' +
007800091014     C                             %TRIM(mnhptrd) + ',' +
007900091014     C                             %TRIM(mncptrd) + ',' +
008000080909     C                             %TRIM(mndate)
008100060315    ***
008200060315     C                   EXCEPT    OUTFA
008300070403   S***S
008400070403     C**** *INZSR        BEGSR
008500070403    ***
008600070403     C***                EVAL      @OUTPUT = '"FIELD A","FIELD B","FIELD C",' +
008700070403     C****                         '"FIELD D"'
008800070403    ***
008900070403     C****               EXCEPT    OUTFA
009000070403    ***
009100070403     C**************     ENDSR
009200070403   S***S
009300070403   X***X
009400060315    ***
009500091014     OMBPCSVP   EADD         OUTFA
009600060315     O                       @OUTPUT           2000
