000100230124     FACTRPTP   IPE  E           K DISK
000200230124     FACTRCSVP  O  A F 2000        DISK
000300050823   X***X
000400060315     D @OUTPUT         S           2000A   INZ
000500051108     D @C              C                   CONST('","')
000600230217    ***
0007002302170025  *
0008002302170025  *
0009002302170250 D                 DS
0010002302170251 D  eoocod                 1      2  0
0011002302170251 D   ocoda                 1      2
0012002302170025  *
0013002302170250 D                 DS
0014002302170251 D  eoremo                 1      2  0
0015002302170251 D   remoa                 1      2
0016000704030025  *
0017000704030250 D                 DS
0018002301240251 D  eotrst                 1      3  0
0019002211020251 D   trsta                 1      3
0020000704030025  *
0021000704030250 D                 DS
0022002301240251 D  eosub#                 1      3  0
0023002211020251 D   sub#a                 1      3
0024000704030025  *
0025000704030250 D                 DS
0026002301240251 D  eoacct                 1      4  0
0027002211020251 D   accta                 1      4
0028000704030025  *
002900210804    * *
003000210804     D                 DS
003100210804     D wkdat           S               D
003200210804     D usadt           S               D   DATFMT(*USA/)
003300230210     D datacc          S             10
003400230210     D datpln          S             10
003401230214     D plstdt          S             10
003500230124     D ecnta           S              9
003600210804      *
003700081114   X* *
003701230214     C                   if        eoplst <> 99999999
003800110720      *
003900230127     C                   eval      ecnta = %editc(eoecnt:'3')
004000081114      *
004001230210     C                   movel     eoaddt        wkdat
004002230210     C                   eval      usadt = wkdat
004003230210     C                   movel     usadt         datacc
004004230214      *
004005230214     C                   eval      plstdt = *blanks
004007230214     C                   movel     eoplst        wkdat
004008230214     C                   eval      usadt = wkdat
004009230214     C                   movel     usadt         plstdt
004011230210      *
004012230210     C**                 movel     eoplst        wkdat
004013230210     C**                 eval      usadt = wkdat
004014230210     C**                 movel     usadt         datpln
004015230210      *
004100080313     C                   CLEAR                   @OUTPUT
004200221102     C                   EVAL      @OUTPUT = %TRIM(trsta) + ',' +
004300221102     C                             %TRIM(sub#a) + ',' +
004400221102     C                             %TRIM(accta) + ',' + '"' +
004500230124     C                             %TRIM(eoacnm) + '"' + ',' +
004501230210     C                             %TRIM(eoaacod) + ',' +
004502230210     C                             %TRIM(eoaafnm) + ',' +
004503230210     C                             %TRIM(eoaalnm) + ',' +
004600230124     C                             %TRIM(ecnta) + ',' +
004601230210     C                             %TRIM(datacc) + ',' +
004700230124     C                             %TRIM(ocoda) + ',' +
004800230124     C                             %TRIM(eoodsc) + ',' +
004900230124     C                             %TRIM(eopvnd) + ',' +
004901230202     C                             %TRIM(eofltp) + ',' +
005000230203     C                             %TRIM(eobrkr) + ',' + '"' +
005001230203     C                             %TRIM(eobnam) + '"' + ',' +
005100230124     C                             %TRIM(eoplan) + ',' + '"' +
005200230124     C                             %TRIM(eopdsc) + '"' + ',' +
005201230214     C                             %TRIM(plstdt) + ',' +
005300230124     C                             %TRIM(remoa)
005400201006    * *
005500060315     C                   EXCEPT    OUTFA
005501230214    * *
005502230214     C                   endif
005600201006   S* *
005601230214   S* *
005700201006     C     *INZSR        BEGSR
005800201006    * *
005900221102     C                   EVAL      @OUTPUT = 'TRUST,' +
006000221102     C                             'SUB#,' +
006100221102     C                             'ACCT,' +
006200221102     C                             'ACCOUNT NAME,' +
006201230210     C                             'AA,' +
006202230210     C                             'AA FIRST NAME,' +
006203230210     C                             'AA LAST NAME,' +
006300230124     C                             'MBR CNT,' +
006400230210     C                             'BEG ADMIN,' +
006401230210     C                             'OLE CODE,' +
006500230124     C                             'CODE DESC,' +
006600230124     C                             'PAYROLL VENDOR,' +
006601230202     C                             'FILE FORMAT,' +
006700230124     C                             'BROKER,' +
006701230203     C                             'BROKER NAME,' +
006800230124     C                             'PLAN,' +
006900230124     C                             'PLAN DESC,' +
006901230214     C                             'PLAN START,' +
007001230214     C                             'RENEW MON,'
007100201006    * *
007200201006     C                   EXCEPT    OUTFA
007300201006    * *
007400201006     C                   ENDSR
007500201006    * *
007600201006     C
007700060315    ***
007800230124     OACTRCSVP  EADD         OUTFA
007900060315     O                       @OUTPUT           2000
