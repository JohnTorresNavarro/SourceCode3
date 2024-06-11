000100210805     FEBSDTLP   IPE  E           K DISK
000200210804     FEBSCSVP   O  A F 2000        DISK
000300050823   X***X
000400060315     D @OUTPUT         S           2000A   INZ
000500051108     D @C              C                   CONST('","')
000600051108    ***
0007000704030025  *
0008002108050025  *
0009000811140250 D                 DS
0010002108050251 D  ebmid#                 1      9  0
0011002108180251 D   eamid#                1      9
0012000704030025  *
0013000704030250 D                 DS
0014000809090251 D  mxseq#                 1      2  0
0015000809090251 D   mnseq#                1      2
0016000704030025  *
0017000704030250 D                 DS
0018000809090251 D  mxhdssn                1      9  0
0019000809090251 D   mnhdssn               1      9
0020000704030025  *
0021000803040250 D                 DS
0022000809090251 D  mxcdssn                1      9  0
0023000809090251 D   mncdssn               1      9
0024000803040025  *
0025000704030250 D                 DS
0026002108040251 D  ebzip                  1      9  0
0027002108040251 D   eazip                 1      9
0028002108170251 D   eazip5                1      5
0029000803040025  *
0030000803040250 D                 DS
0031002108040251 D  ebarea                 1      3  0
0032002108040251 D  ebphn#                 4     10  0
0033002108040251 D   phon10                1     10
0034000704030025  *
0035000704030250 D                 DS
0036002108040251 D  ebefdt                 1      8  0
0037002108040251 D   eaefdt                9     18
0038002108040025  *
0039002108040250 D                 DS
0040002108040251 D  ebtmdt                 1      8  0
0041002108040251 D   eatmdt                9     18
0042002108040025  *
0043002108040250 D                 DS
0044002108040251 D  ebbrdt                 1      8  0
0045002108040251 D   eabrdt                9     18
0046000803040025  *
0047000803040250 D                 DS
0048000809090251 D  mxcbrdt                1      8  0
0049000809090251 D   mncbrdt               9     16
0050001103140025  *
0051000704030250 D                 DS
0052000809090251 D  mxtrst                 1      3  0
0053000809090251 D   mntrst                1      3
0054000704030025  *
0055000704030250 D                 DS
0056000809090251 D  mxsub                  1      3  0
0057000809090251 D   mnsub                 1      3
0058000704030025  *
0059000704030250 D                 DS
0060000809090251 D  mxacct                 1      4  0
0061000809090251 D   mnacct                1      4
0062000704030025  *
0063000704030250 D                 DS
0064000809090251 D  mxdate                 1      8  0
0065000809090251 D   mndate                9     16
0066000811140025  *
0067000811140250 D                 DS
0068000811140251 D  mzhrate                1     10
0069000811140251 D  mzcrate               11     20
007000210804    * *
007100210804     D                 DS
007200210804     D wkdat           S               D
007300210804     D usadt           S               D   DATFMT(*USA/)
007400210804     D dspdt           S             10
007500210805     D rect            S              1
007600210804      *
007700081114   X* *
007800110720      *
007900210805     C                   movel     *blanks       eaefdt
008000210805     C                   if        ebefdt <> 0
008100210804     C                   movel     ebefdt        wkdat
008200210804     C                   eval      usadt = wkdat
008300210804     C                   movel     usadt         eaefdt
008400210805     C                   endif
008500210804      *
008600210804     C                   movel     *blanks       eatmdt
008700210804     C                   if        ebtmdt <> 0
008800210804     C                   movel     ebtmdt        wkdat
008900210804     C                   eval      usadt = wkdat
009000210804     C                   movel     usadt         eatmdt
009100210804     C                   endif
009200210804      *
009300210804     C                   movel     *blanks       eabrdt
009400210804     C                   if        ebbrdt <> 0
009500210804     C                   movel     ebbrdt        wkdat
009600210804     C                   eval      usadt = wkdat
009700210804     C                   movel     usadt         eabrdt
009800210804     C                   endif
009900210804      *
010000210805     C                   if        ebrelcd = '   '
010100210805     C                   eval      rect = 'A'
010200210805     C                   else
010300210805     C                   if        ebrelcd = 'RHU' or ebrelcd = 'RWI'
010400210805     C                   eval      rect = 'S'
010500210805     C                   else
010600210805     C                   eval      rect = 'D'
010700210805     C                   endif
010800210805     C                   endif
010900080313      *
011000081114      *
011100080313     C                   CLEAR                   @OUTPUT
011200210805     C                   EVAL      @OUTPUT = %TRIM(ebegrp) + ',' +
011300210818     C                             %TRIM(ebrect) + ',' +
011400210805     C                             %TRIM(ebepkg) + ',' + '"' +
011500210805     C                             %TRIM(eamid#) + '"' + ',' + '"' +
011600210805     C                             %TRIM(ebfnme) + '"' + ',' + '"' +
011700210805     C                             %TRIM(ebmi) + '"' + ',' +
011800210805     C                             %TRIM(eblnme) + ',' +
011900210805     C                             %TRIM(ebadr1) + ',' +
012000210805     C                             %TRIM(ebadr2) + ',' +
012100210805     C                             %TRIM(ebcity) + ',' +
012200210805     C                             %TRIM(ebst) + ',' +
012300210817     C                             %TRIM(eazip5) + ',' +
012400210810     C                             %TRIM(phon10) + ',' +
012500210810     C                             %TRIM(ebemail) + ',' +
012600210805     C                             %TRIM(eabrdt) + ',' +
012700210805     C                             %TRIM(eaefdt) + ',' +
012800210805     C                             %TRIM(eatmdt) + ',' +
012900210805     C                             %TRIM('E') + ',' +
013000210805     C                             ',,' +
013100210805     C                             %TRIM(ebssn4) + ',' +
013200210805     C                             %TRIM(ebmpln) + ',' +
013300210805     C                             %TRIM(ebcovt) + ',' +
013400210805     C                             %TRIM(ebdpln) + ',' +
013500210805     C                             %TRIM(ebvpln)
013600201006    * *
013700060315     C                   EXCEPT    OUTFA
013800201006   S* *
013900201006     C     *INZSR        BEGSR
014000201006    * *
014100210804     C                   EVAL      @OUTPUT = 'GROUP NUMBER,' +
014200210804     C                             'RECORD TYPE,' +
014300210804     C                             'PACKAGE NAME,' +
014400210804     C                             'UNIQUE IDENTIFIER,' +
014500210804     C                             'FIRST NAME,' +
014600210804     C                             'MIDDLE INITIAL,' +
014700210804     C                             'LAST NAME,' +
014800210804     C                             'ADDRESS 1,' +
014900210804     C                             'ADDRESS 2,' +
015000210804     C                             'CITY,' +
015100210804     C                             'STATE,' +
015200210804     C                             'ZIP CODE,' +
015300210804     C                             'HOME PHONE NUMBER,' +
015400210804     C                             'EMAIL ADDRESS,' +
015500210804     C                             'BIRTHDATE,' +
015600210804     C                             'EFFECTIVE DATE,' +
015700210804     C                             'TERMINATION DATE,' +
015800210804     C                             'LANGUAGE,' +
015900210804     C                             'FREE FIELD,' +
016000210804     C                             'Do Not Use,' +
016100210804     C                             'Last 4 Digits SS#,' +
016200210804     C                             'MEDICAL PLAN CODE,' +
016300210804     C                             'MEDICAL PLAN TIER,' +
016400210804     C                             'DENTAL PLAN,' +
016500210804     C                             'VISION PLAN'
016600201006    * *
016700201006     C                   EXCEPT    OUTFA
016800201006    * *
016900201006     C                   ENDSR
017000201006    * *
017100201006     C
017200060315    ***
017300210804     OEBSCSVP   EADD         OUTFA
017400060315     O                       @OUTPUT           2000
