000100200501     FPAYDFCFP  IPE  E           K DISK
000200200611     FPAYDFCSXP O  A F 1000        DISK
000300050823   X***X
000400200409     D @OUTPUT         S           1000A   INZ
000500161221     D @C              C                   CONST('","')
000600051108    ***
0007000704030025  *
0008000704030250 D                 DS
0009002006090251 Datmran           S              8
0010002006090251 Dadtran           S             10
0011002006090251 Dafrmdt           S             10
0012002004090251 Datodt            S             10
0013002006050251 Dapdth            S             10
0014002004150251 Dainfrm           S             10
0015002008130251 Datrmdt           S             10
0016002004090251 Dadamt            S             20
0017002004150251 Damamt            S             20
0018002006050251 Dabamt            S             20
0019002006050251 Dapamt            S             20
0020002006050251 Daramt            S             20
0021002004150251 Dainst#           S             20
0022001612300025  *
0023000704030025  *
0024001507020250 D                 DS
0025001507280037 D wkdate          S               D   datfmt(*iso)
002600150728     D usadt           S               D   DATFMT(*USA/)
0027002006090250 D                 DS
0028002006090037 D wktime          S               T   timfmt(*iso)
002900200609     D usatm           S               T   timfmt(*HMS:)
003000081114   X* *
003100200501     C                   movel     pcfrmdt       wkdate
003200200409     C                   move      wkdate        usadt
003300200409     C                   move      usadt         afrmdt
003400200409   X* *
003500200501     C                   movel     pctodt        wkdate
003600200409     C                   move      wkdate        usadt
003700200409     C                   move      usadt         atodt
003800200415   X* *
003900200609     C                   movel     pcdtran       wkdate
004000200415     C                   move      wkdate        usadt
004100200609     C                   move      usadt         adtran
004200200609   X* *
004300200609     C                   movel     pctmran       wktime
004400200609     C                   move      wktime        usatm
004500200609     C                   move      usatm         atmran
004600200609   X* *
004700200609     C                   movel     pcinfrm       wkdate
004800200609     C                   move      wkdate        usadt
004900200609     C                   move      usadt         ainfrm
005000200605   X* *
005100200605     C                   move      *blanks       apdth
005200200605     C                   if        pcpdth <> 0
005300200605     C                   movel     pcpdth        wkdate
005400200605     C                   move      wkdate        usadt
005500200605     C                   move      usadt         apdth
005600200605     C                   endif
005700200813   X* *
005800200813     C                   move      *blanks       atrmdt
005900200813     C                   if        pcatrmd <> 0
006000200813     C                   movel     pcatrmd       wkdate
006100200813     C                   move      wkdate        usadt
006200200813     C                   move      usadt         atrmdt
006300200813     C                   endif
006400150728      *
006500200501     C                   eval      adamt = %EDITC(pcdamt:'A')
006600200501     C                   eval      amamt = %EDITC(pcmamt:'A')
006700200501     C                   eval      ainst# = %EDITC(pcinst#:'A')
006800200605     C                   eval      abamt = %EDITC(pcbamt:'A')
006900200605     C                   eval      apamt = %EDITC(pcpamt:'A')
007000200605     C                   eval      aramt = %EDITC(pcramt:'A')
007100200409      *
007200150728     C                   CLEAR                   @OUTPUT
007300200501     C                   EVAL      @OUTPUT = '"' + %TRIM(pcacnm) + '"' + ',' +
007400200501     C                             '"' + %TRIM(pcgrp#) + '"' + ',' +
007500200501     C                             %TRIM(pcst) + ',' +
007600200409     C                             %TRIM(afrmdt) + ',' +
007700200409     C                             %TRIM(atodt) + ',' +
007800200409     C                             '"' + %TRIM(adamt) + '"' + ',' +
007900200409     C                             '"' + %TRIM(amamt) + '"' + ',' +
008000200501     C                             %TRIM(pccntc) + ',' +
008100200501     C                             %TRIM(pccnph) + ',' +
008200200501     C                             '"' + %TRIM(pccnem) + '"' + ',' +
008300200501     C                             '"' + %TRIM(pccnad) + '"' + ',' +
008400200501     C                             %TRIM(pccnct) + ',' +
008500200501     C                             %TRIM(pccnzp) + ',' +
008600200501     C                             %TRIM(pcgtsa) + ',' +
008700200501     C                             %TRIM(pcaa) + ',' +
008800200501     C                             '"' + %TRIM(pcbrkr) + '"' + ',' +
008900200415     C                             %TRIM(ainst#) + ',' +
009000200605     C                             %TRIM(ainfrm) + ',' +
009100200605     C                             '"' + %TRIM(abamt) + '"' + ',' +
009200200605     C                             '"' + %TRIM(apamt) + '"' + ',' +
009300200605     C                             '"' + %TRIM(aramt) + '"' + ',' +
009400200609     C                             %TRIM(apdth) + ',' +
009500200609     C                             %TRIM(adtran) + ',' +
009600200813     C                             %TRIM(atmran) + ',' +
009700200813     C                             %TRIM(atrmdt)
009800150702    * *
009900060315     C                   EXCEPT    OUTFA
010000150702   S* *
010100150929   S* *
010200150702     C     *INZSR        BEGSR
010300150702    * *
010400150911    * *        Build Column Headings Row
010500150702     C                   CLEAR                   @OUTPUT
010600200409     C                   EVAL      @OUTPUT = 'Group Name,' +
010700200409     C                             'Group ID,' +
010800200409     C                             'Jurisdiction,' +
010900200409     C                             'Deferral Start Month,' +
011000200409     C                             'Deferral End Month,' +
011100200409     C                             'Total Deferred Amount,' +
011200200409     C                             'Monthly Pmt Plan Instlmt,' +
011300200409     C                             'Contact Name,' +
011400200409     C                             'Contact Number,' +
011500200409     C                             'Contact Email,' +
011600200409     C                             'Contact Address,' +
011700200409     C                             'Contact City,' +
011800200409     C                             'Contact Zip,' +
011900200409     C                             'GBS Account#,' +
012000200409     C                             'AA,' +
012100200415     C                             'Broker,' +
012200200415     C                             'Number of Monthly Installments,' +
012300200605     C                             'First Repayment Month,' +
012400200605     C                             'Total Billed Toward Deferred Amt,' +
012500200605     C                             'Total Pmts Received Toward Deferred Amt,' +
012600200605     C                             'Deferred Premium Balance Remaining,' +
012700200609     C                             'Group Paid Thru Date,' +
012800200609     C                             'Report Date,' +
012900200813     C                             'Report Time,' +
013000200813     C                             'Acct Term DT'
013100150702    * *
013200150702     C                   EXCEPT    OUTFA
013300150702   X* *
013400150702    * *
013500150702     C                   ENDSR
013600150702    * *
013700200611     OPAYDFCSXP EADD         OUTFA
013800200409     O                       @OUTPUT           1000
