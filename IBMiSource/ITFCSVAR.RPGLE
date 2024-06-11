000100150728     FITFUDP    IPE  E           K DISK
000200180112     FTRSMST    IF   E           K DISK
000300150728     FITCODP    IF   E           K DISK
000400180112     FITFCSVAP  O  A F 2000        DISK
000500050823   X***X
000600060315     D @OUTPUT         S           2000A   INZ
000700051108     D @C              C                   CONST('","')
000800051108    ***
0009000704030025  *
0010000704030250 D                 DS
0011001507280251 D  iftrst                 1      3  0
0012001507280251 D   cstrst                1      3
0013001507280025  *
0014001507280250 D                 DS
0015001507280251 D  ifsub#                 1      3  0
0016001507280251 D   cssub#                1      3
0017001507280025  *
0018001507280250 D                 DS
0019001507280251 D  ifacct                 1      4  0
0020001507280251 D   csacct                1      4
0021001507280025  *
0022001507280250 D                 DS
0023001507280251 D  ifmssn                 1      9  0
0024001507280251 D   csmssn                1      9
0025001507280025  *
0026001507280250 D                 DS
0027001507280251 D  ifiss#                 1      6  0
0028001507280251 D   csiss#                1      6
0029001507020025  *
0030000704030025  *
0031000704030250 D                 DS
0032001507020251 D  txhveff                1      8  0
0033001507020251 D   axhveff               1      8
0034001507020250 D                 DS
0035001507280037 D wkdate          S               D   datfmt(*iso)
003600150728     D usadt           S               D   DATFMT(*USA/)
003700081114   X* *
003800150728    * *
003900150728     C     codkey        KLIST
004000150728     C                   KFLD                    cktyp             1
004100150728     C                   KFLD                    ckcod             3
004200110419      *
004300180112     C     iftrst        chain     trsmst                             30
004400180112     C                   If        tscode = 'O M'
004500180112      *
004600150728     C                   eval      cktyp = 'T'
004700150728     C                   eval      ckcod = iftypc
004800150728     C     codkey        chain     itcodp                             32
004900150728     C                   if        *in32 = '0'
005000150728     C                   movel(P)  ictext        iftype           25
005100150728     C                   endif
005200150728      *
005300150728     C                   eval      ifref = *blanks
005400150728     C                   if        ifrefr <> '   '
005500150728     C                   eval      cktyp = 'R'
005600150728     C                   eval      ckcod = ifrefr
005700150728     C     codkey        chain     itcodp                             32
005800150728     C                   if        *in32 = '0'
005900150728     C                   movel(P)  ictext        ifref            25
006000150728     C                   endif
006100150728     C                   endif
006200150728      *
006300150728     C                   movel     ifdato        wkdate
006400150728     C                   eval      usadt = wkdate
006500150728     C                   movel     usadt         csdato           10
006600150728      *
006700150730     C                   eval      csfudt = *blanks
006800150730     C                   if        iffudt <> 0
006900150728     C                   movel     iffudt        wkdate
007000150728     C                   eval      usadt = wkdate
007100150728     C                   movel     usadt         csfudt           10
007200150730     C                   endif
007300150728      *
007400150730     C                   eval      csrefd = *blanks
007500150728     C                   if        ifrefd <> 0
007600150728     C                   movel     ifrefd        wkdate
007700150728     C                   eval      usadt = wkdate
007800150728     C                   movel     usadt         csrefd           10
007900150728     C                   endif
008000150728      *
008100150728      *
008200150728     C                   CLEAR                   @OUTPUT
008300150728     C                   EVAL      @OUTPUT = %TRIM(ifinit) + ',' +
008400150728     C                             cstrst + ',' +
008500150728     C                             cssub# + ',' +
008600150728     C                             csacct + ',' +
008700150728     C                             csmssn + ',' +
008800150728     C                             csiss# + ',' +
008900150728     C                             %TRIM(csfudt) + ',' +
009000150728     C                             %TRIM(iftype) + ',' +
009100150728     C                             %TRIM(csdato) + ',' + '"' +
009200150728     C                             %TRIM(ifsbjt) + '"' + ',' +
009300150728     C                             %TRIM(ifref) +  ',' +
009400150728     C                             %TRIM(csrefd)
009500150702    * *
009600060315     C                   EXCEPT    OUTFA
009700150702   S* *
009800150728     C                   endif
009900150728      *
010000150702     C     *INZSR        BEGSR
010100150702    * *
010200150702     C                   CLEAR                   @OUTPUT
010300150728     C                   EVAL      @OUTPUT = 'Initiator' + ',' +
010400150728     C                             'Trust,' +
010500150728     C                             'Sub#' + ',' +
010600150728     C                             'Acct' + ',' +
010700150728     C                             'Mbr SSN,' +
010800150728     C                             'Issue#,' +
010900150728     C                             'Follow Up Dt,' +
011000150728     C                             'Issue Type,' +
011100150728     C                             'Dt Opened,' +
011200150728     C                             'Subject,' +
011300150728     C                             'Referred To,' +
011400150728     C                             'Referral Date'
011500150702    * *
011600150702     C                   EXCEPT    OUTFA
011700150702   X* *
011800150702    * *
011900150702     C                   ENDSR
012000150702    * *
012100180112     OITFCSVAP  EADD         OUTFA
012200060315     O                       @OUTPUT           2000
