000100150728     FITFUDP    IPE  E           K DISK
000200180112     FTRSMST    IF   E           K DISK
000300180112     FITCODP    IF   E           K DISK
000400150728     FITFCSVP   O  A F 2000        DISK
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
004400200117     C                   If        tscode <> 'O N' and tscode <> 'O M' and
004500200117     C                             tscode <> 'O D'
004600180112      *
004700150728     C                   eval      cktyp = 'T'
004800150728     C                   eval      ckcod = iftypc
004900150728     C     codkey        chain     itcodp                             32
005000150728     C                   if        *in32 = '0'
005100150728     C                   movel(P)  ictext        iftype           25
005200150728     C                   endif
005300150728      *
005400150728     C                   eval      ifref = *blanks
005500150728     C                   if        ifrefr <> '   '
005600150728     C                   eval      cktyp = 'R'
005700150728     C                   eval      ckcod = ifrefr
005800150728     C     codkey        chain     itcodp                             32
005900150728     C                   if        *in32 = '0'
006000150728     C                   movel(P)  ictext        ifref            25
006100150728     C                   endif
006200150728     C                   endif
006300150728      *
006400150728     C                   movel     ifdato        wkdate
006500150728     C                   eval      usadt = wkdate
006600150728     C                   movel     usadt         csdato           10
006700150728      *
006800150730     C                   eval      csfudt = *blanks
006900150730     C                   if        iffudt <> 0
007000150728     C                   movel     iffudt        wkdate
007100150728     C                   eval      usadt = wkdate
007200150728     C                   movel     usadt         csfudt           10
007300150730     C                   endif
007400150728      *
007500150730     C                   eval      csrefd = *blanks
007600150728     C                   if        ifrefd <> 0
007700150728     C                   movel     ifrefd        wkdate
007800150728     C                   eval      usadt = wkdate
007900150728     C                   movel     usadt         csrefd           10
008000150728     C                   endif
008100150728      *
008200150728      *
008300150728     C                   CLEAR                   @OUTPUT
008400150728     C                   EVAL      @OUTPUT = %TRIM(ifinit) + ',' +
008500150728     C                             cstrst + ',' +
008600150728     C                             cssub# + ',' +
008700150728     C                             csacct + ',' +
008800150728     C                             csmssn + ',' +
008900150728     C                             csiss# + ',' +
009000150728     C                             %TRIM(csfudt) + ',' +
009100150728     C                             %TRIM(iftype) + ',' +
009200150728     C                             %TRIM(csdato) + ',' + '"' +
009300150728     C                             %TRIM(ifsbjt) + '"' + ',' +
009400150728     C                             %TRIM(ifref) +  ',' +
009500150728     C                             %TRIM(csrefd)
009600150702    * *
009700060315     C                   EXCEPT    OUTFA
009800150702   S* *
009900150728     C                   endif
010000150728   S* *
010100150702     C     *INZSR        BEGSR
010200150702    * *
010300150702     C                   CLEAR                   @OUTPUT
010400150728     C                   EVAL      @OUTPUT = 'Initiator' + ',' +
010500150728     C                             'Trust,' +
010600150728     C                             'Sub#' + ',' +
010700150728     C                             'Acct' + ',' +
010800150728     C                             'Mbr SSN,' +
010900150728     C                             'Issue#,' +
011000150728     C                             'Follow Up Dt,' +
011100150728     C                             'Issue Type,' +
011200150728     C                             'Dt Opened,' +
011300150728     C                             'Subject,' +
011400150728     C                             'Referred To,' +
011500150728     C                             'Referral Date'
011600150702    * *
011700150702     C                   EXCEPT    OUTFA
011800150702   X* *
011900150702    * *
012000150702     C                   ENDSR
012100150702    * *
012200150728     OITFCSVP   EADD         OUTFA
012300060315     O                       @OUTPUT           2000
