000100200501     FPAYDFCFP  IPE  E           K DISK
000200200507     FPAYDFCSCP O  A F 1000        DISK
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
0015002004090251 Dadamt            S             20
0016002004150251 Damamt            S             20
0017002006050251 Dabamt            S             20
0018002006050251 Dapamt            S             20
0019002006050251 Daramt            S             20
0020002004150251 Dainst#           S             20
0021001612300025  *
0022000704030025  *
0023001507020250 D                 DS
0024001507280037 D wkdate          S               D   datfmt(*iso)
002500150728     D usadt           S               D   DATFMT(*USA/)
0026002006090250 D                 DS
0027002006090037 D wktime          S               T   timfmt(*iso)
002800200609     D usatm           S               T   timfmt(*HMS:)
002900081114   X* *
003000200501     C                   movel     pcfrmdt       wkdate
003100200409     C                   move      wkdate        usadt
003200200409     C                   move      usadt         afrmdt
003300200409   X* *
003400200501     C                   movel     pctodt        wkdate
003500200409     C                   move      wkdate        usadt
003600200409     C                   move      usadt         atodt
003700200415   X* *
003800200609     C                   movel     pcdtran       wkdate
003900200415     C                   move      wkdate        usadt
004000200609     C                   move      usadt         adtran
004100200609   X* *
004200200609     C                   movel     pctmran       wktime
004300200609     C                   move      wktime        usatm
004400200609     C                   move      usatm         atmran
004500200609   X* *
004600200609     C                   movel     pcinfrm       wkdate
004700200609     C                   move      wkdate        usadt
004800200609     C                   move      usadt         ainfrm
004900200605   X* *
005000200605     C                   move      *blanks       apdth
005100200605     C                   if        pcpdth <> 0
005200200605     C                   movel     pcpdth        wkdate
005300200605     C                   move      wkdate        usadt
005400200605     C                   move      usadt         apdth
005500200605     C                   endif
005600150728      *
005700200501     C                   eval      adamt = %EDITC(pcdamt:'A')
005800200501     C                   eval      amamt = %EDITC(pcmamt:'A')
005900200501     C                   eval      ainst# = %EDITC(pcinst#:'A')
006000200605     C                   eval      abamt = %EDITC(pcbamt:'A')
006100200605     C                   eval      apamt = %EDITC(pcpamt:'A')
006200200605     C                   eval      aramt = %EDITC(pcramt:'A')
006300200409      *
006400150728     C                   CLEAR                   @OUTPUT
006500200501     C                   EVAL      @OUTPUT = '"' + %TRIM(pcacnm) + '"' + ',' +
006600200501     C                             '"' + %TRIM(pcgrp#) + '"' + ',' +
006700200501     C                             %TRIM(pcst) + ',' +
006800200409     C                             %TRIM(afrmdt) + ',' +
006900200409     C                             %TRIM(atodt) + ',' +
007000200409     C                             '"' + %TRIM(adamt) + '"' + ',' +
007100200409     C                             '"' + %TRIM(amamt) + '"' + ',' +
007200200501     C                             %TRIM(pccntc) + ',' +
007300200501     C                             %TRIM(pccnph) + ',' +
007400200501     C                             '"' + %TRIM(pccnem) + '"' + ',' +
007500200501     C                             '"' + %TRIM(pccnad) + '"' + ',' +
007600200501     C                             %TRIM(pccnct) + ',' +
007700200501     C                             %TRIM(pccnzp) + ',' +
007800200501     C                             %TRIM(pcgtsa) + ',' +
007900200501     C                             %TRIM(pcaa) + ',' +
008000200501     C                             '"' + %TRIM(pcbrkr) + '"' + ',' +
008100200415     C                             %TRIM(ainst#) + ',' +
008200200611     C                             %TRIM(ainfrm)
008300200611    * *       Billing fields
008400200611     C****                         '"' + %TRIM(abamt) + '"' + ',' +
008500200611     C****                         '"' + %TRIM(apamt) + '"' + ',' +
008600200611     C****                         '"' + %TRIM(aramt) + '"' + ',' +
008700200611     C****                         %TRIM(apdth) + ',' +
008800200611     C****                         %TRIM(adtran) + ',' +
008900200611     C****                         %TRIM(atmran)
009000150702    * *
009100060315     C                   EXCEPT    OUTFA
009200150702   S* *
009300150929   S* *
009400150702     C     *INZSR        BEGSR
009500150702    * *
009600150911    * *        Build Column Headings Row
009700150702     C                   CLEAR                   @OUTPUT
009800200409     C                   EVAL      @OUTPUT = 'Group Name,' +
009900200409     C                             'Group ID,' +
010000200409     C                             'Jurisdiction,' +
010100200409     C                             'Deferral Start Month,' +
010200200409     C                             'Deferral End Month,' +
010300200409     C                             'Total Deferred Amount,' +
010400200409     C                             'Monthly Pmt Plan Instlmt,' +
010500200409     C                             'Contact Name,' +
010600200409     C                             'Contact Number,' +
010700200409     C                             'Contact Email,' +
010800200409     C                             'Contact Address,' +
010900200409     C                             'Contact City,' +
011000200409     C                             'Contact Zip,' +
011100200409     C                             'GBS Account#,' +
011200200409     C                             'AA,' +
011300200415     C                             'Broker,' +
011400200415     C                             'Number of Monthly Installments,' +
011500200611     C                             'First Repayment Month,'
011600200611    * *       Billing fields
011700200611     C****                         'Total Billed Toward Deferred Amt,' +
011800200611     C****                         'Total Pmts Received Toward Deferred Amt,' +
011900200611     C****                         'Deferred Premium Balance Remaining,' +
012000200611     C****                         'Group Paid Thru Date,' +
012100200611     C****                         'Report Date,' +
012200200611     C****                         'Report Time'
012300150702    * *
012400150702     C                   EXCEPT    OUTFA
012500150702   X* *
012600150702    * *
012700150702     C                   ENDSR
012800150702    * *
012900200507     OPAYDFCSCP EADD         OUTFA
013000200409     O                       @OUTPUT           1000
