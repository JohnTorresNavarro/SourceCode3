000100080529     FP1CHGP    IPE  E           K DISK
000200080529     FP1CSVP    O  A F 2000        DISK
000300050823   X***X
000400060315     D @OUTPUT         S           2000A   INZ
000500051108     D @C              C                   CONST('","')
000600051108    ***
0007000704030025  *
0008000803130250 D                 DS
0009000803130251 D  datymd                 1      8  0
0010000803130251 D   dtymdyy               1      4
0011000803130251 D   dtymdmd               5      8
0012000803130025  *
0013000704030250 D                 DS
0014000805290251 D  pxmid#                 1      9  0
0015000805290251 D   pnmid#               10     18
0016000704030025  *
0017000704030250 D                 DS
0018000805290251 D  pxseq#                 1      2  0
0019000805290251 D   pnseq#                1      2
0020000704030025  *
0021000704030250 D                 DS
0022000805290251 D  pxhdssn                1      9  0
0023000805290251 D   pnhdssn               1      9
0024000704030025  *
0025000803040250 D                 DS
0026000805290251 D  pxcdssn                1      9  0
0027000805290251 D   pncdssn               1      9
0028000803040025  *
0029000704030250 D                 DS
0030000805290251 D  pxhzip                 1      9  0
0031000805290251 D   pnhzip                1      9
0032000803040025  *
0033000803040250 D                 DS
0034000805290251 D  pxczip                 1      9  0
0035000805290251 D   pnczip                1      9
0036000704030025  *
0037000704030250 D                 DS
0038000805290251 D  pxharea                1      3  0
0039000805290251 D  pxhphn#                4     10  0
0040000805290251 D   pnhph10               1     10
0041000803040025  *
0042000803040250 D                 DS
0043000805290251 D  pxcarea                1      3  0
0044000805290251 D  pxcphn#                4     10  0
0045000805290251 D   pncph10               1     10
0046000704030025  *
0047000704030250 D                 DS
0048000805290251 D  pxhbrdt                1      8  0
0049000805290251 D   pnhbrdt               9     16
0050000803040025  *
0051000803040250 D                 DS
0052000805290251 D  pxcbrdt                1      8  0
0053000805290251 D   pncbrdt               9     16
0054000704030025  *
0055000704030250 D                 DS
0056000805290251 D  pxhempdt               1      8  0
0057000805290251 D   pnhempdt              9     16
0058000803040025  *
0059000803040250 D                 DS
0060000805290251 D  pxcempdt               1      8  0
0061000805290251 D   pncempdt              9     16
0062000704030025  *
0063000704030250 D                 DS
0064000805290251 D  pxhtrmdt               1      8  0
0065000805290251 D   pnhtrmdt              9     16
0066000704030025  *
0067000803040250 D                 DS
0068000805290251 D  pxctrmdt               1      8  0
0069000805290251 D   pnctrmdt              9     16
0070000704030025  *
0071000704030250 D                 DS
0072000805290251 D  pxhefdt                1      8  0
0073000805290251 D   pnhefdt               9     16
0074000803040025  *
0075000803040250 D                 DS
0076000805290251 D  pxcefdt                1      8  0
0077000805290251 D   pncefdt               9     16
0078000704030025  *
0079000704030250 D                 DS
0080000805290251 D  pxhtfdt                1      8  0
0081000805290251 D   pnhtfdt               9     16
0082000803040025  *
0083000803040250 D                 DS
0084000805290251 D  pxctfdt                1      8  0
0085000805290251 D   pnctfdt               9     16
0086000704030025  *
0087000704030250 D                 DS
0088000805290251 D  pxdate                 1      8  0
0089000805290251 D   pndate                9     16
009000050823   X***X
009100080529     C                   movel     pxmid#        pnmid#
009200080313      *
009300080529     C                   eval      datymd = pxhbrdt
009400080529     C                   movel     dtymdmd       pnhbrdt
009500080529     C                   move      dtymdyy       pnhbrdt
009600080313      *
009700080529     C                   eval      datymd = pxcbrdt
009800080529     C                   movel     dtymdmd       pncbrdt
009900080529     C                   move      dtymdyy       pncbrdt
010000080313      *
010100080529     C                   eval      datymd = pxhempdt
010200080529     C                   movel     dtymdmd       pnhempdt
010300080529     C                   move      dtymdyy       pnhempdt
010400080313      *
010500080529     C                   eval      datymd = pxcempdt
010600080529     C                   movel     dtymdmd       pncempdt
010700080529     C                   move      dtymdyy       pncempdt
010800080313      *
010900080529     C                   eval      datymd = pxhefdt
011000080529     C                   movel     dtymdmd       pnhefdt
011100080529     C                   move      dtymdyy       pnhefdt
011200080313      *
011300080529     C                   eval      datymd = pxcefdt
011400080529     C                   movel     dtymdmd       pncefdt
011500080529     C                   move      dtymdyy       pncefdt
011600080313      *
011700080529     C                   eval      datymd = pxdate
011800080529     C                   movel     dtymdmd       pndate
011900080529     C                   move      dtymdyy       pndate
012000080313      *
012100080313     C                   CLEAR                   @OUTPUT
012200080529     C                   EVAL      @OUTPUT = %TRIM(pxsts) + ',' + '"' +
012300080529     C                             %TRIM(pnmid#) + '"' + ',' + '"' +
012400080529     C                             %TRIM(pxhlnme) + '"' + ',' + '"' +
012500080529     C                             %TRIM(pxclnme) + '"' + ',' +
012600080529     C                             %TRIM(pxhfnme) + ',' +
012700080529     C                             %TRIM(pxcfnme) + ',' +
012800080529     C                             %TRIM(pxhmi) + ',' +
012900080529     C                             %TRIM(pxcmi) + ',' +
013000080529     C                             %TRIM(pnseq#) + ',' +
013100080529     C                             %TRIM(pnhdssn) + ',' +
013200080529     C                             %TRIM(pncdssn) + ',' +
013300080529     C                             %TRIM(pxhadr1) + ',' +
013400080529     C                             %TRIM(pxcadr1) + ',' +
013500080529     C                             %TRIM(pxhadr2) + ',' +
013600080529     C                             %TRIM(pxcadr2) + ',' +
013700080529     C                             %TRIM(pxhcity) + ',' +
013800080529     C                             %TRIM(pxccity) + ',' +
013900080529     C                             %TRIM(pxhst) + ',' +
014000080529     C                             %TRIM(pxcst) + ',' +
014100080529     C                             %TRIM(pnhzip) + ',' +
014200080529     C                             %TRIM(pnczip) + ',' +
014300080529     C                             %TRIM(pnhph10) + ',' +
014400080529     C                             %TRIM(pncph10) + ',' +
014500080529     C                             %TRIM(pnhbrdt) + ',' +
014600080529     C                             %TRIM(pncbrdt) + ',' +
014700080529     C                             %TRIM(pxhgndr) + ',' +
014800080529     C                             %TRIM(pxcgndr) + ',' +
014900080529     C                             %TRIM(pnhempdt) + ',' +
015000080529     C                             %TRIM(pncempdt) + ',' +
015100080529     C                             %TRIM(pxhrelcd) + ',' +
015200080529     C                             %TRIM(pxcrelcd) + ',' +
015300080529     C                             %TRIM(pnhefdt) + ',' +
015400080529     C                             %TRIM(pncefdt) + ',' +
015500080529     C                             %TRIM(pxhcovt) + ',' +
015600080529     C                             %TRIM(pxccovt) + ',' +
015700080529     C                             %TRIM(pxhplan) + ',' +
015800080529     C                             %TRIM(pxcplan) + ',' +
015900080529     C                             %TRIM(pndate)
016000060315    ***
016100060315     C                   EXCEPT    OUTFA
016200070403   S***S
016300070403     C**** *INZSR        BEGSR
016400070403    ***
016500070403     C***                EVAL      @OUTPUT = '"FIELD A","FIELD B","FIELD C",' +
016600070403     C****                         '"FIELD D"'
016700070403    ***
016800070403     C****               EXCEPT    OUTFA
016900070403    ***
017000070403     C**************     ENDSR
017100070403   S***S
017200070403   X***X
017300060315    ***
017400080529     OP1CSVP    EADD         OUTFA
017500060315     O                       @OUTPUT           2000
