000100150902     FITFUDL2   IF   E           K DISK
000200150728     FITCODP    IF   E           K DISK
000300150902     FITINICSP  O  A F 2000        DISK
000400050823   X***X
000500060315     D @OUTPUT         S           2000A   INZ
000600051108     D @C              C                   CONST('","')
000700051108    ***
0008000704030025  *
0009000704030250 D                 DS
0010001507280251 D  iftrst                 1      3  0
0011001507280251 D   cstrst                1      3
0012001507280025  *
0013001507280250 D                 DS
0014001507280251 D  ifsub#                 1      3  0
0015001507280251 D   cssub#                1      3
0016001507280025  *
0017001507280250 D                 DS
0018001507280251 D  ifacct                 1      4  0
0019001507280251 D   csacct                1      4
0020001507280025  *
0021001507280250 D                 DS
0022001507280251 D  ifmssn                 1      9  0
0023001507280251 D   csmssn                1      9
0024001507280025  *
0025001507280250 D                 DS
0026001507280251 D  ifiss#                 1      6  0
0027001507280251 D   csiss#                1      6
0028001507020025  *
0029000704030025  *
0030000704030250 D                 DS
0031001507020251 D  txhveff                1      8  0
0032001507020251 D   axhveff               1      8
0033001509020025  *
0034001507020250 D                 DS
003500150902     D @KEYINI         S             30A
0036001507280037 D wkdate          S               D   datfmt(*iso)
003700150728     D usadt           S               D   DATFMT(*USA/)
003800081114   X* *
003900150728    * *
004000150728     C     codkey        KLIST
004100150728     C                   KFLD                    cktyp             1
004200150728     C                   KFLD                    ckcod             3
004300150902    * *
004400150902    * *
004500150902     C     *ENTRY        PLIST
004600150902     C                   PARM                    @PARM            30
004700150902     C                   MOVEL(P)  @PARM         @KEYINI
004800110419      *
004900150902     C     @keyini       setll     itfudl2                            34
005000150902     C     *IN34         DOUEQ     *ON
005100150902      *
005200150902     C     @keyini       reade     itfudl2                                34
005300150902     C                   IF        *In34 <> *ON
005400150728      *
005500150728     C                   eval      cktyp = 'T'
005600150728     C                   eval      ckcod = iftypc
005700150728     C     codkey        chain     itcodp                             32
005800150728     C                   if        *in32 = '0'
005900150728     C                   movel(P)  ictext        iftype           25
006000150728     C                   endif
006100150728      *
006200150728     C                   eval      ifref = *blanks
006300150728     C                   if        ifrefr <> '   '
006400150728     C                   eval      cktyp = 'R'
006500150728     C                   eval      ckcod = ifrefr
006600150728     C     codkey        chain     itcodp                             32
006700150728     C                   if        *in32 = '0'
006800150728     C                   movel(P)  ictext        ifref            25
006900150728     C                   endif
007000150728     C                   endif
007100150728      *
007200150728     C                   movel     ifdato        wkdate
007300150728     C                   eval      usadt = wkdate
007400150728     C                   movel     usadt         csdato           10
007500150728      *
007600150730     C                   eval      csfudt = *blanks
007700150730     C                   if        iffudt <> 0
007800150728     C                   movel     iffudt        wkdate
007900150728     C                   eval      usadt = wkdate
008000150728     C                   movel     usadt         csfudt           10
008100150730     C                   endif
008200150728      *
008300150730     C                   eval      csrefd = *blanks
008400150728     C                   if        ifrefd <> 0
008500150728     C                   movel     ifrefd        wkdate
008600150728     C                   eval      usadt = wkdate
008700150728     C                   movel     usadt         csrefd           10
008800150728     C                   endif
008900150728      *
009000150728      *
009100150728     C                   CLEAR                   @OUTPUT
009200150728     C                   EVAL      @OUTPUT = %TRIM(ifinit) + ',' +
009300150728     C                             cstrst + ',' +
009400150728     C                             cssub# + ',' +
009500150728     C                             csacct + ',' +
009600150728     C                             csmssn + ',' +
009700150728     C                             csiss# + ',' +
009800150728     C                             %TRIM(csfudt) + ',' +
009900150728     C                             %TRIM(iftype) + ',' +
010000150728     C                             %TRIM(csdato) + ',' + '"' +
010100150728     C                             %TRIM(ifsbjt) + '"' + ',' +
010200150728     C                             %TRIM(ifref) +  ',' +
010300150728     C                             %TRIM(csrefd)
010400150702    * *
010500060315     C                   EXCEPT    OUTFA
010600150702   S* *
010700150728     C                   endif
010800150728      *
010900150902     C                   enddo
011000150902      *
011100150902      *
011200150902     C                   eval      *inlr = '1'
011300150902     C                   return
011400150902      *
011500150702     C     *INZSR        BEGSR
011600150702    * *
011700150702     C                   CLEAR                   @OUTPUT
011800150728     C                   EVAL      @OUTPUT = 'Initiator' + ',' +
011900150728     C                             'Trust,' +
012000150728     C                             'Sub#' + ',' +
012100150728     C                             'Acct' + ',' +
012200150728     C                             'Mbr SSN,' +
012300150728     C                             'Issue#,' +
012400150728     C                             'Follow Up Dt,' +
012500150728     C                             'Issue Type,' +
012600150728     C                             'Dt Opened,' +
012700150728     C                             'Subject,' +
012800150728     C                             'Referred To,' +
012900150728     C                             'Referral Date'
013000150702    * *
013100150702     C                   EXCEPT    OUTFA
013200150702   X* *
013300150702    * *
013400150702     C                   ENDSR
013500150702    * *
013600150902     OITINICSP  EADD         OUTFA
013700060315     O                       @OUTPUT           2000
