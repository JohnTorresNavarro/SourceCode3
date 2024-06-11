000100100805     FFSCHGP    IPE  E           K DISK
000200240410     F****PARTICIPL6IF   E           K DISK
000300100805     FFSCSVP    O  A F 2000        DISK
000400050823   X***X
000500060315     D @OUTPUT         S           2000A   INZ
000600051108     D @C              C                   CONST('","')
000700051108    ***
0008000704030025  *
0009000803130250 D                 DS
0010000811140251 D  datymd                 1      8  0
0011000811140251 D   dtymdyy               1      4
0012000811140251 D   dtymdmd               5      8
0013000811140025  *
0014000811140250 D                 DS
0015001008050251 D  fxmid#                 1      9  0
0016001008050251 D   fnmid#               10     18
0017001107200251 D   fxssnd               19     19    INZ(' ')
0018000704030025  *
0019000704030250 D                 DS
0020001008050251 D  fxseq#                 1      2  0
0021001008050251 D   fnseq#                1      2
0022000704030025  *
0023000704030250 D                 DS
0024001008050251 D  fxhdssn                1      9  0
0025001008050251 D   fnhdssn               1      9
0026000704030025  *
0027000803040250 D                 DS
0028001008050251 D  fxcdssn                1      9  0
0029001008050251 D   fncdssn               1      9
0030000803040025  *
0031000704030250 D                 DS
0032001008050251 D  fxhzip                 1      9  0
0033001008050251 D   fnhzip                1      9
0034000803040025  *
0035000803040250 D                 DS
0036001008050251 D  fxczip                 1      9  0
0037001008050251 D   fnczip                1      9
0038000704030025  *
0039000704030250 D                 DS
0040001008050251 D  fxharea                1      3  0
0041001008050251 D  fxhphn#                4     10  0
0042001008050251 D   fnhph10               1     10
0043000803040025  *
0044000803040250 D                 DS
0045001008050251 D  fxcarea                1      3  0
0046001008050251 D  fxcphn#                4     10  0
0047001008050251 D   fncph10               1     10
0048000704030025  *
0049000704030250 D                 DS
0050001008050251 D  fxhbrdt                1      8  0
0051001008050251 D   fnhbrdt               9     16
0052000803040025  *
0053000803040250 D                 DS
0054001008050251 D  fxcbrdt                1      8  0
0055001008050251 D   fncbrdt               9     16
0056000704030025  *
0057000704030250 D                 DS
0058001008050251 D  fxhempdt               1      8  0
0059001008050251 D   fnhempdt              9     16
0060000803040025  *
0061000803040250 D                 DS
0062001008050251 D  fxcempdt               1      8  0
0063001008050251 D   fncempdt              9     16
0064000704030025  *
0065000704030250 D                 DS
0066001008050251 D  fxhtrmdt               1      8  0
0067001008050251 D   fnhtrmdt              9     16
0068000704030025  *
0069000803040250 D                 DS
0070001008050251 D  fxctrmdt               1      8  0
0071001008050251 D   fnctrmdt              9     16
0072000803040025  *
0073000707180250 D                 DS
0074001008050251 D  fxhtrmldt              1      8  0
0075001008050251 D   fnhtrmldt             9     16
0076000803040025  *
0077000803040250 D                 DS
0078001008050251 D  fxctrmldt              1      8  0
0079001008050251 D   fnctrmldt             9     16
0080000704030025  *
0081000704030250 D                 DS
0082001008050251 D  fxhefdt                1      8  0
0083001008050251 D   fnhefdt               9     16
0084000803040025  *
0085000803040250 D                 DS
0086001008050251 D  fxcefdt                1      8  0
0087001008050251 D   fncefdt               9     16
0088000704030025  *
0089000704030250 D                 DS
0090001008050251 D  fxhtfdt                1      8  0
0091001008050251 D   fnhtfdt               9     16
0092000803040025  *
0093000803040250 D                 DS
0094001008050251 D  fxctfdt                1      8  0
0095001008050251 D   fnctfdt               9     16
0096000704030025  *
0097000707180250 D                 DS
0098001008050251 D  fxhtfldt               1      8  0
0099001008050251 D   fnhtfldt              9     16
0100000803040025  *
0101000803040250 D                 DS
0102001008050251 D  fxctfldt               1      8  0
0103001008050251 D   fnctfldt              9     16
0104000707180025  *
0105001104190250 D                 DS
0106001104190251 D  fzccdat                1      8  0
0107001104190251 D   fnccdat               9     16
0108001104190025  *
0109001104190250 D                 DS
0110001104190251 D  fzhcdat                1      8  0
0111001104190251 D   fnhcdat               9     16
0112001104190025  *
0113000704030250 D                 DS
0114001008050251 D  fxtrst                 1      3  0
0115001008050251 D   fntrst                1      3
0116000704030025  *
0117000704030250 D                 DS
0118001008050251 D  fxsub                  1      3  0
0119001008050251 D   fnsub                 1      3
0120000704030025  *
0121000704030250 D                 DS
0122001008050251 D  fxacct                 1      4  0
0123001008050251 D   fnacct                1      4
0124000704030025  *
0125000704030250 D                 DS
0126001008050251 D  fxdate                 1      8  0
0127001008050251 D   fndate                9     16
0128000811140025  *
0129000811140250 D                 DS
0130001008050251 D  fzhrate                1     10
0131001008050251 D  fzcrate               11     20
013200081114   X* *
013300100805     C                   movel     fxmid#        fnmid#
013400110720      *       If new mbr, look for existing SSN in LUM
013500110720     C                   eval      fxssnd = ' '
013600110720     C                   if        fxsts = 'N' and fxseq# = 0
013700240410     C***  fnmid#        chain     participl6                         61
013800240410     C**                 if        *in61 = '0'
013900240410     C**                 eval      fxssnd = 'Y'
014000240410     C***                endif
014100110720     C                   endif
014200110720      *
014300100805     C                   eval      datymd = fxhbrdt
014400100805     C                   movel     dtymdmd       fnhbrdt
014500100805     C                   move      dtymdyy       fnhbrdt
014600080313      *
014700100805     C                   eval      datymd = fxcbrdt
014800100805     C                   movel     dtymdmd       fncbrdt
014900100805     C                   move      dtymdyy       fncbrdt
015000080313      *
015100100805     C                   eval      datymd = fxhempdt
015200100805     C                   movel     dtymdmd       fnhempdt
015300100805     C                   move      dtymdyy       fnhempdt
015400080313      *
015500100805     C                   eval      datymd = fxcempdt
015600100805     C                   movel     dtymdmd       fncempdt
015700100805     C                   move      dtymdyy       fncempdt
015800080313      *
015900100805     C                   eval      datymd = fxhefdt
016000100805     C                   movel     dtymdmd       fnhefdt
016100100805     C                   move      dtymdyy       fnhefdt
016200080313      *
016300100805     C                   eval      datymd = fxcefdt
016400100805     C                   movel     dtymdmd       fncefdt
016500100805     C                   move      dtymdyy       fncefdt
016600080313      *
016700100805     C                   eval      datymd = fxhtfldt
016800100805     C                   movel     dtymdmd       fnhtfldt
016900100805     C                   move      dtymdyy       fnhtfldt
017000080313      *
017100100805     C                   eval      datymd = fxctfldt
017200100805     C                   movel     dtymdmd       fnctfldt
017300100805     C                   move      dtymdyy       fnctfldt
017400080313      *
017500100805     C                   eval      datymd = fxdate
017600100805     C                   movel     dtymdmd       fndate
017700100805     C                   move      dtymdyy       fndate
017800080313      *
017900100805     C                   eval      fzhrate = *blanks
018000100805     C                   if        fxhrate <> 0
018100100805     C                   eval      fzhrate = %EDITC(fxhrate:'M')
018200081114     C                   endif
018300081114      *
018400100805     C                   eval      fzcrate = *blanks
018500100805     C                   if        fxcrate <> 0
018600100805     C                   eval      fzcrate = %EDITC(fxcrate:'M')
018700081114     C                   endif
018800110419      *
018900110419     C                   eval      fnhcdat = *blanks
019000110419     C                   if        fxhcdat <> *LOVAL
019100110419     C                   movel     fxhcdat       fzhcdat
019200110419     C                   eval      datymd = fzhcdat
019300110419     C                   movel     dtymdmd       fnhcdat
019400110419     C                   move      dtymdyy       fnhcdat
019500110419     C                   endif
019600110419      *
019700110419     C                   eval      fnccdat = *blanks
019800110419     C                   if        fxccdat <> *LOVAL
019900110419     C                   movel     fxccdat       fzccdat
020000110419     C                   eval      datymd = fzccdat
020100110419     C                   movel     dtymdmd       fnccdat
020200110419     C                   move      dtymdyy       fnccdat
020300110419     C                   endif
020400110419      *
020500080313     C                   CLEAR                   @OUTPUT
020600100805     C                   EVAL      @OUTPUT = %TRIM(fxsts) + ',' +
020700100805     C                             %TRIM(fxhgrp#) + ',' +
020800100805     C                             %TRIM(fxcgrp#) + ',' + '"' +
020900100805     C                             %TRIM(fnmid#) + '"' + ',' + '"' +
021000100805     C                             %TRIM(fxhlnme) + '"' + ',' + '"' +
021100100805     C                             %TRIM(fxclnme) + '"' + ',' +
021200100805     C                             %TRIM(fxhfnme) + ',' +
021300100805     C                             %TRIM(fxcfnme) + ',' +
021400100805     C                             %TRIM(fxhmi) + ',' +
021500100805     C                             %TRIM(fxcmi) + ',' +
021600100805     C                             %TRIM(fnseq#) + ',' +
021700100805     C                             %TRIM(fnhdssn) + ',' +
021800100805     C                             %TRIM(fncdssn) + ',' +
021900100805     C                             %TRIM(fxhadr1) + ',' +
022000100805     C                             %TRIM(fxcadr1) + ',' +
022100100805     C                             %TRIM(fxhadr2) + ',' +
022200100805     C                             %TRIM(fxcadr2) + ',' +
022300100805     C                             %TRIM(fxhcity) + ',' +
022400100805     C                             %TRIM(fxccity) + ',' +
022500100805     C                             %TRIM(fxhst) + ',' +
022600100805     C                             %TRIM(fxcst) + ',' +
022700100805     C                             %TRIM(fnhzip) + ',' +
022800100805     C                             %TRIM(fnczip) + ',' +
022900100805     C                             %TRIM(fnhph10) + ',' +
023000100805     C                             %TRIM(fncph10) + ',' +
023100191121     C                             %TRIM(fxhemal) + ',' +
023200191121     C                             %TRIM(fxcemal) + ',' +
023300100805     C                             %TRIM(fnhbrdt) + ',' +
023400100805     C                             %TRIM(fncbrdt) + ',' +
023500100805     C                             %TRIM(fxhgndr) + ',' +
023600100805     C                             %TRIM(fxcgndr) + ',' +
023700100805     C                             %TRIM(fnhempdt) + ',' +
023800100805     C                             %TRIM(fncempdt) + ',' +
023900100805     C                             %TRIM(fxhrelcd) + ',' +
024000100805     C                             %TRIM(fxcrelcd) + ',' +
024100100805     C                             %TRIM(fnhefdt) + ',' +
024200100805     C                             %TRIM(fncefdt) + ',' +
024300100805     C                             %TRIM(fnhtfldt) + ',' +
024400100805     C                             %TRIM(fnctfldt) + ',' +
024500100805     C                             %TRIM(fxhcovt) + ',' +
024600100805     C                             %TRIM(fxccovt) + ',' +
024700100805     C                             %TRIM(fzhrate) + ',' +
024800100805     C                             %TRIM(fzcrate) + ',' +
024900100805     C                             %TRIM(fxhdbtc) + ',' +
025000100805     C                             %TRIM(fxcdbtc) + ',' +
025100110419     C                             %TRIM(fnhcdat) + ',' +
025200110419     C                             %TRIM(fnccdat) + ',' +
025300100805     C                             %TRIM(fntrst) + ',' +
025400100805     C                             %TRIM(fnsub) + ',' +
025500100805     C                             %TRIM(fnacct) + ',' + '"' +
025600100805     C                             %TRIM(fxacnm) + '"' + ',' +
025700110720     C                             %TRIM(fxssnd) + ',' +
025800100805     C                             %TRIM(fndate)
025900060315    ***
026000060315     C                   EXCEPT    OUTFA
026100070403   S***S
026200070403     C**** *INZSR        BEGSR
026300070403    ***
026400070403     C***                EVAL      @OUTPUT = '"FIELD A","FIELD B","FIELD C",' +
026500070403     C****                         '"FIELD D"'
026600070403    ***
026700070403     C****               EXCEPT    OUTFA
026800070403    ***
026900070403     C**************     ENDSR
027000070403   S***S
027100070403   X***X
027200060315    ***
027300100805     OFSCSVP    EADD         OUTFA
027400060315     O                       @OUTPUT           2000
