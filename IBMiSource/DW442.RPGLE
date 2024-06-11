000100100422     FMBCHG2P   IPE  E           K DISK
000200240410     F***PARTICIPL6IF   E           K DISK
000300080909     FMBCSVP    O  A F 2000        DISK
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
0015000811140251 D  mxmid#                 1      9  0
0016000811140251 D   mnmid#               10     18
0017001107200251 D   mxssnd               19     19    INZ(' ')
0018000704030025  *
0019000704030250 D                 DS
0020000809090251 D  mxseq#                 1      2  0
0021000809090251 D   mnseq#                1      2
0022000704030025  *
0023000704030250 D                 DS
0024000809090251 D  mxhdssn                1      9  0
0025000809090251 D   mnhdssn               1      9
0026000704030025  *
0027000803040250 D                 DS
0028000809090251 D  mxcdssn                1      9  0
0029000809090251 D   mncdssn               1      9
0030000803040025  *
0031000704030250 D                 DS
0032000809090251 D  mxhzip                 1      9  0
0033000809090251 D   mnhzip                1      9
0034000803040025  *
0035000803040250 D                 DS
0036000809090251 D  mxczip                 1      9  0
0037000809090251 D   mnczip                1      9
0038000704030025  *
0039000704030250 D                 DS
0040000809090251 D  mxharea                1      3  0
0041000809090251 D  mxhphn#                4     10  0
0042000809090251 D   mnhph10               1     10
0043000803040025  *
0044000803040250 D                 DS
0045000809090251 D  mxcarea                1      3  0
0046000809090251 D  mxcphn#                4     10  0
0047000809090251 D   mncph10               1     10
0048000704030025  *
0049000704030250 D                 DS
0050000809090251 D  mxhbrdt                1      8  0
0051000809090251 D   mnhbrdt               9     16
0052000803040025  *
0053000803040250 D                 DS
0054000809090251 D  mxcbrdt                1      8  0
0055000809090251 D   mncbrdt               9     16
0056000704030025  *
0057000704030250 D                 DS
0058000809090251 D  mxhempdt               1      8  0
0059000809090251 D   mnhempdt              9     16
0060000803040025  *
0061000803040250 D                 DS
0062000809090251 D  mxcempdt               1      8  0
0063000809090251 D   mncempdt              9     16
0064000704030025  *
0065000704030250 D                 DS
0066000809090251 D  mxhtrmdt               1      8  0
0067000809090251 D   mnhtrmdt              9     16
0068000704030025  *
0069000803040250 D                 DS
0070000809090251 D  mxctrmdt               1      8  0
0071000809090251 D   mnctrmdt              9     16
0072000803040025  *
0073000707180250 D                 DS
0074000809090251 D  mxhtrmldt              1      8  0
0075000809090251 D   mnhtrmldt             9     16
0076000803040025  *
0077000803040250 D                 DS
0078000809090251 D  mxctrmldt              1      8  0
0079000809090251 D   mnctrmldt             9     16
0080000704030025  *
0081000704030250 D                 DS
0082000809090251 D  mxhefdt                1      8  0
0083000809090251 D   mnhefdt               9     16
0084000803040025  *
0085000803040250 D                 DS
0086000809090251 D  mxcefdt                1      8  0
0087000809090251 D   mncefdt               9     16
0088000704030025  *
0089000704030250 D                 DS
0090000809090251 D  mxhtfdt                1      8  0
0091000809090251 D   mnhtfdt               9     16
0092000803040025  *
0093000803040250 D                 DS
0094000809090251 D  mxctfdt                1      8  0
0095000809090251 D   mnctfdt               9     16
0096000704030025  *
0097000707180250 D                 DS
0098000809090251 D  mxhtfldt               1      8  0
0099000809090251 D   mnhtfldt              9     16
0100000803040025  *
0101000803040250 D                 DS
0102000809090251 D  mxctfldt               1      8  0
0103000809090251 D   mnctfldt              9     16
0104000707180025  *
0105001103140250 D                 DS
0106001103140251 D  mzccdat                1      8  0
0107001103140251 D   mnccdat               9     16
0108001103140025  *
0109001103140250 D                 DS
0110001103140251 D  mzhcdat                1      8  0
0111001103140251 D   mnhcdat               9     16
0112001103140025  *
0113000704030250 D                 DS
0114000809090251 D  mxtrst                 1      3  0
0115000809090251 D   mntrst                1      3
0116000704030025  *
0117000704030250 D                 DS
0118000809090251 D  mxsub                  1      3  0
0119000809090251 D   mnsub                 1      3
0120000704030025  *
0121000704030250 D                 DS
0122000809090251 D  mxacct                 1      4  0
0123000809090251 D   mnacct                1      4
0124000704030025  *
0125000704030250 D                 DS
0126000809090251 D  mxdate                 1      8  0
0127000809090251 D   mndate                9     16
0128000811140025  *
0129000811140250 D                 DS
0130000811140251 D  mzhrate                1     10
0131000811140251 D  mzcrate               11     20
013200081114   X* *
013300080909     C                   movel     mxmid#        mnmid#
013400110720      *       If new mbr, look for existing SSN in LUM
013500110720     C                   eval      mxssnd = ' '
013600110720     C                   if        mxsts = 'N' and mxseq# = 0
013700240410     C***  mnmid#        chain     participl6                         61
013800240410     C**                 if        *in61 = '0'
013900240410     C***                eval      mxssnd = 'Y'
014000240410     C***                endif
014100110720     C                   endif
014200110720      *
014300080909     C                   eval      datymd = mxhbrdt
014400080909     C                   movel     dtymdmd       mnhbrdt
014500080909     C                   move      dtymdyy       mnhbrdt
014600080313      *
014700080909     C                   eval      datymd = mxcbrdt
014800080909     C                   movel     dtymdmd       mncbrdt
014900080909     C                   move      dtymdyy       mncbrdt
015000080313      *
015100080909     C                   eval      datymd = mxhempdt
015200080909     C                   movel     dtymdmd       mnhempdt
015300080909     C                   move      dtymdyy       mnhempdt
015400080313      *
015500080909     C                   eval      datymd = mxcempdt
015600080909     C                   movel     dtymdmd       mncempdt
015700080909     C                   move      dtymdyy       mncempdt
015800080313      *
015900080909     C                   eval      datymd = mxhefdt
016000080909     C                   movel     dtymdmd       mnhefdt
016100080909     C                   move      dtymdyy       mnhefdt
016200080313      *
016300080909     C                   eval      datymd = mxcefdt
016400080909     C                   movel     dtymdmd       mncefdt
016500080909     C                   move      dtymdyy       mncefdt
016600080313      *
016700080909     C                   eval      datymd = mxhtfldt
016800080909     C                   movel     dtymdmd       mnhtfldt
016900080909     C                   move      dtymdyy       mnhtfldt
017000080313      *
017100080909     C                   eval      datymd = mxctfldt
017200080909     C                   movel     dtymdmd       mnctfldt
017300080909     C                   move      dtymdyy       mnctfldt
017400080313      *
017500080909     C                   eval      datymd = mxdate
017600080909     C                   movel     dtymdmd       mndate
017700080909     C                   move      dtymdyy       mndate
017800080313      *
017900081114     C                   eval      mzhrate = *blanks
018000081114     C                   if        mxhrate <> 0
018100081114     C                   eval      mzhrate = %EDITC(mxhrate:'M')
018200081114     C                   endif
018300081114      *
018400081114     C                   eval      mzcrate = *blanks
018500081114     C                   if        mxcrate <> 0
018600081114     C                   eval      mzcrate = %EDITC(mxcrate:'M')
018700081114     C                   endif
018800110314      *
018900110314     C                   eval      mnhcdat = *blanks
019000110314     C                   if        mxhcdat <> *LOVAL
019100110314     C                   movel     mxhcdat       mzhcdat
019200110314     C                   eval      datymd = mzhcdat
019300110314     C                   movel     dtymdmd       mnhcdat
019400110314     C                   move      dtymdyy       mnhcdat
019500110314     C                   endif
019600110314      *
019700110314     C                   eval      mnccdat = *blanks
019800110314     C                   if        mxccdat <> *LOVAL
019900110314     C                   movel     mxccdat       mzccdat
020000110314     C                   eval      datymd = mzccdat
020100110314     C                   movel     dtymdmd       mnccdat
020200110314     C                   move      dtymdyy       mnccdat
020300110314     C                   endif
020400081114      *
020500080313     C                   CLEAR                   @OUTPUT
020600080909     C                   EVAL      @OUTPUT = %TRIM(mxsts) + ',' +
020700080909     C                             %TRIM(mxhgrp#) + ',' +
020800080909     C                             %TRIM(mxcgrp#) + ',' + '"' +
020900080909     C                             %TRIM(mnmid#) + '"' + ',' + '"' +
021000080909     C                             %TRIM(mxhlnme) + '"' + ',' + '"' +
021100080909     C                             %TRIM(mxclnme) + '"' + ',' +
021200080909     C                             %TRIM(mxhfnme) + ',' +
021300080909     C                             %TRIM(mxcfnme) + ',' +
021400080909     C                             %TRIM(mxhmi) + ',' +
021500080909     C                             %TRIM(mxcmi) + ',' +
021600080909     C                             %TRIM(mnseq#) + ',' +
021700080909     C                             %TRIM(mnhdssn) + ',' +
021800080909     C                             %TRIM(mncdssn) + ',' +
021900080909     C                             %TRIM(mxhadr1) + ',' +
022000080909     C                             %TRIM(mxcadr1) + ',' +
022100080909     C                             %TRIM(mxhadr2) + ',' +
022200080909     C                             %TRIM(mxcadr2) + ',' +
022300080909     C                             %TRIM(mxhcity) + ',' +
022400080909     C                             %TRIM(mxccity) + ',' +
022500080909     C                             %TRIM(mxhst) + ',' +
022600080909     C                             %TRIM(mxcst) + ',' +
022700080909     C                             %TRIM(mnhzip) + ',' +
022800080909     C                             %TRIM(mnczip) + ',' +
022900080909     C                             %TRIM(mnhph10) + ',' +
023000080909     C                             %TRIM(mncph10) + ',' +
023100191121     C                             %TRIM(mxhemal) + ',' +
023200191121     C                             %TRIM(mxcemal) + ',' +
023300080909     C                             %TRIM(mnhbrdt) + ',' +
023400080909     C                             %TRIM(mncbrdt) + ',' +
023500080909     C                             %TRIM(mxhgndr) + ',' +
023600080909     C                             %TRIM(mxcgndr) + ',' +
023700080909     C                             %TRIM(mnhempdt) + ',' +
023800080909     C                             %TRIM(mncempdt) + ',' +
023900080909     C                             %TRIM(mxhrelcd) + ',' +
024000080909     C                             %TRIM(mxcrelcd) + ',' +
024100080909     C                             %TRIM(mnhefdt) + ',' +
024200080909     C                             %TRIM(mncefdt) + ',' +
024300080909     C                             %TRIM(mnhtfldt) + ',' +
024400080909     C                             %TRIM(mnctfldt) + ',' +
024500080909     C                             %TRIM(mxhcovt) + ',' +
024600080909     C                             %TRIM(mxccovt) + ',' +
024700081114     C                             %TRIM(mzhrate) + ',' +
024800081114     C                             %TRIM(mzcrate) + ',' +
024900100610     C                             %TRIM(mxhdbtc) + ',' +
025000110314     C                             %TRIM(mxcdbtc) + ',' +
025100110314     C                             %TRIM(mnhcdat) + ',' +
025200110314     C                             %TRIM(mnccdat) + ',' +
025300080909     C                             %TRIM(mntrst) + ',' +
025400080909     C                             %TRIM(mnsub) + ',' +
025500080909     C                             %TRIM(mnacct) + ',' + '"' +
025600080909     C                             %TRIM(mxacnm) + '"' + ',' +
025700110720     C                             %TRIM(mxssnd) + ',' +
025800080909     C                             %TRIM(mndate)
025900201006    * *
026000060315     C                   EXCEPT    OUTFA
026100201006   S* *
026200201006     C     *INZSR        BEGSR
026300201006    * *
026400201006     C                   EVAL      @OUTPUT = 'STS,' +
026500201006     C                             'Old Grp,' +
026600201006     C                             'New Grp,' +
026700201006     C                             'MBR SSN,' +
026800201006     C                             'Old Last Name,' +
026900201006     C                             'New Last Name,' +
027000201006     C                             'Old First Name,' +
027100201006     C                             'New First Name,' +
027200201006     C                             'Old MI,' +
027300201006     C                             'New MI,' +
027400201006     C                             'New MI,' +
027500201006     C                             'Seq#,' +
027600201006     C                             'New Dep SSN,' +
027700201006     C                             'Old Addr1,' +
027800201006     C                             'New Addr1,' +
027900201006     C                             'Old Addr2,' +
028000201006     C                             'New Addr2,' +
028100201006     C                             'Old City,' +
028200201006     C                             'New City,' +
028300201006     C                             'Old ST,' +
028400201006     C                             'New ST,' +
028500201006     C                             'Old Zip,' +
028600201006     C                             'New Zip,' +
028700201006     C                             'Old Phone,' +
028800201006     C                             'New Phone,' +
028900201006     C                             'Old Email,' +
029000201006     C                             'New Email,' +
029100201006     C                             'Old DOB,' +
029200201006     C                             'New DOB,' +
029300201006     C                             'Old Sex,' +
029400201006     C                             'New Sex,' +
029500201006     C                             'Old Emp Dt,' +
029600201006     C                             'New Emp Dt,' +
029700201006     C                             'Old Relc,' +
029800201006     C                             'New Relc,' +
029900201006     C                             'Old Eff,' +
030000201006     C                             'New Eff,' +
030100201006     C                             'Old Trm,' +
030200201006     C                             'New Trm,' +
030300201006     C                             'Old Covt,' +
030400201006     C                             'New Covt,' +
030500201006     C                             'Old Rate,' +
030600201006     C                             'New Rate,' +
030700201006     C                             'Old DBT,' +
030800201006     C                             'New DBT,' +
030900201006     C                             'Old DBT DT,' +
031000201006     C                             'New DBT DT,' +
031100201006     C                             'Trust,' +
031200201006     C                             'Sub#,' +
031300201006     C                             'Acct,' +
031400201006     C                             'Acct Name,' +
031500201006     C                             'Sent,' +
031600201006     C                             'Date Found'
031700201006    * *
031800201006     C                   EXCEPT    OUTFA
031900201006    * *
032000201006     C                   ENDSR
032100201006    * *
032200201006     C
032300070403   S***S
032400070403   X***X
032500060315    ***
032600080909     OMBCSVP    EADD         OUTFA
032700060315     O                       @OUTPUT           2000
