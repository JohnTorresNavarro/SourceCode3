000100240319     FHRCVDP    IF   E           K DISK
000200140507     FHRACSVP   O  A F 2000        DISK
000300050823   X***X
000400060315     D @OUTPUT         S           2000A   INZ
000500240326     D @C              C                   CONST('","')
000600240326    ***
0007002403260025  *
0008002403260250 D                 DS
0009002403260251 D  hctrust                1      3  0
0010002403260251 D   trusta                1      3
0011002403260251 D  hcsub                  4      6  0
0012002403260251 D   suba                  4      6
0013002403260251 D  hcacct                 7     10  0
0014002403260251 D   accta                 7     10
0015001405070251 D  hcmid#                11     19  0
0016002403260251 D   mid#a                11     19
0017001405280025  *
0018001405280250 D                 DS
001900140528     D wkdat           S               D
0020001405280037 D wkdat1          S               D   datfmt(*iso)
0021001405280037 D sysdateymd      S               D   datfmt(*iso)
002200140528     D usadt           S               D   DATFMT(*USA/)
0023001405280251 D  feff10         S             10
0024001405280251 D  meff10         S             10
002500140114      *
002600140109      ******************************************************************
002700140109   X* *
002800140114   X* *        Build Header Row
002900140114     C                   CLEAR                   @OUTPUT
003000240319     C                   EVAL      @OUTPUT = 'Last Name' + ',' +
003100240319     C                             'First Name,' +
003101240319     C                             'SSN #' + ',' +
003102240319     C                             'Account Name,' +
003103240319     C                             'Trust,' +
003104240319     C                             'Sub#,' +
003200140507     C                             'Acct,' +
003400140507     C                             'Fund Plan,' +
003500140507     C                             'Cov Lvl,' +
003700140507     C                             'MM Plan,' +
003800240319     C                             'Cov Lvl,'
004100140114    * *
004200140114     C                   EXCEPT    OUTFA
004300140114    * *
004400240319     C     *loval        setll     HRCVDP                             21
004500140109     C                   dou       *in21 = '1'
004600110419      *
004700240319     C                   read      HRCVDP                                 21
004800140109      *
004900140507     C                   if        *in21 = '0'
005000140528      *
005100140528     C                   if        hcfeff = 0
005200140528     C                   eval      feff10 = *blanks
005300140528     C                   else
005400140528     C                   movel     hcfeff        wkdat
005500140528     C                   eval      usadt = wkdat
005600140528     C                   movel     usadt         feff10
005700140528     C                   endif
005800140528      *
005900140528     C                   if        hcmeff = 0
006000140528     C                   eval      meff10 = *blanks
006100140528     C                   else
006200140528     C                   movel     hcmeff        wkdat
006300140528     C                   eval      usadt = wkdat
006400140528     C                   movel     usadt         meff10
006500140528     C                   endif
006600140528      *
006700080313     C                   CLEAR                   @OUTPUT
006800240319     C                   EVAL      @OUTPUT = '"' +%TRIM(hclnme) + '"'+',' +
006900240319     C                             %TRIM(hcfnme) + ',' +
006901240319     C                             %TRIM(mid#a) + ',' + '"' +
006902240319     C                             %TRIM(hcacnm) + '"' + ',' +
006903240319     C                             %TRIM(trusta) + ',' +
006904240319     C                             %TRIM(suba) + ',' +
007000140507     C                             %TRIM(accta) + ',' +
007200140507     C                             %TRIM(hcfpln) + ',' +
007300140507     C                             %TRIM(hcfcvt) + ',' +
007500140507     C                             %TRIM(hcmpln) + ',' +
007600240319     C                             %TRIM(hcmcvt)
007900140109    * *
008000060315     C                   EXCEPT    OUTFA
008100140109    * *
008200140109     C                   endif
008300140110    * *
008400140109     C                   enddo
008500140109    * *
008600140109     C                   eval      *inlr = '1'
008700140109     C                   return
008800070403   S***S
008900070403     C**** *INZSR        BEGSR
009000070403    ***
009100070403     C***                EVAL      @OUTPUT = '"FIELD A","FIELD B","FIELD C",' +
009200070403     C****                         '"FIELD D"'
009300070403    ***
009400070403     C****               EXCEPT    OUTFA
009500070403    ***
009600070403     C**************     ENDSR
009700070403   S***S
009800070403   X***X
009900060315    ***
010000140507     OHRACSVP   EADD         OUTFA
010100060315     O                       @OUTPUT           2000
