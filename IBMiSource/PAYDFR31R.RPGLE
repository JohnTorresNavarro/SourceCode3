000100200424     FPAYDFRCP  IPE  E           K DISK
000200200507     FPAYDFCSGP O  A F 1000        DISK
000300050823   X***X
000400200409     D @OUTPUT         S           1000A   INZ
000500161221     D @C              C                   CONST('","')
000600051108    ***
0007000704030025  *
0008000704030250 D                 DS
0009002004090251 Dafrmdt           S             10
0010002004090251 Datodt            S             10
0011002004150251 Dainfrm           S             10
0012002004090251 Dadamt            S             20
0013002004150251 Damamt            S             20
0014002004150251 Dainst#           S             20
0015001612300025  *
0016000704030025  *
0017001507020250 D                 DS
0018001507280037 D wkdate          S               D   datfmt(*iso)
001900150728     D usadt           S               D   DATFMT(*USA/)
002000081114   X* *
002100200409     C                   movel     pffrmdt       wkdate
002200200409     C                   move      wkdate        usadt
002300200409     C                   move      usadt         afrmdt
002400200409   X* *
002500200409     C                   movel     pftodt        wkdate
002600200409     C                   move      wkdate        usadt
002700200409     C                   move      usadt         atodt
002800200415   X* *
002900200415     C                   movel     pfinfrm       wkdate
003000200415     C                   move      wkdate        usadt
003100200415     C                   move      usadt         ainfrm
003200150728      *
003300200409     C                   eval      adamt = %EDITC(pfdamt:'A')
003400200409     C                   eval      amamt = %EDITC(pfmamt:'A')
003500200415     C                   eval      ainst# = %EDITC(pfinst#:'A')
003600200409      *
003700150728     C                   CLEAR                   @OUTPUT
003800200409     C                   EVAL      @OUTPUT = '"' + %TRIM(pfacnm) + '"' + ',' +
003900200409     C                             '"' + %TRIM(pfgrp#) + '"' + ',' +
004000200409     C                             %TRIM(pfst) + ',' +
004100200409     C                             %TRIM(afrmdt) + ',' +
004200200409     C                             %TRIM(atodt) + ',' +
004300200409     C                             '"' + %TRIM(adamt) + '"' + ',' +
004400200409     C                             '"' + %TRIM(amamt) + '"' + ',' +
004500200409     C                             %TRIM(pfcntc) + ',' +
004600200409     C                             %TRIM(pfcnph) + ',' +
004700200415     C                             '"' + %TRIM(pfcnem) + '"' + ',' +
004800200415     C                             '"' + %TRIM(pfcnad) + '"' + ',' +
004900200409     C                             %TRIM(pfcnct) + ',' +
005000200409     C                             %TRIM(pfcnzp) + ',' +
005100200409     C                             %TRIM(pfgtsa) + ',' +
005200200409     C                             %TRIM(pfaa) + ',' +
005300200415     C                             '"' + %TRIM(pfbrkr) + '"' + ',' +
005400200415     C                             %TRIM(ainst#) + ',' +
005500200415     C                             %TRIM(ainfrm)
005600150702    * *
005700060315     C                   EXCEPT    OUTFA
005800150702   S* *
005900150929   S* *
006000150702     C     *INZSR        BEGSR
006100150702    * *
006200150911    * *        Build Column Headings Row
006300150702     C                   CLEAR                   @OUTPUT
006400200409     C                   EVAL      @OUTPUT = 'Group Name,' +
006500200409     C                             'Group ID,' +
006600200409     C                             'Jurisdiction,' +
006700200409     C                             'Deferral Start Month,' +
006800200409     C                             'Deferral End Month,' +
006900200409     C                             'Total Deferred Amount,' +
007000200409     C                             'Monthly Pmt Plan Instlmt,' +
007100200409     C                             'Contact Name,' +
007200200409     C                             'Contact Number,' +
007300200409     C                             'Contact Email,' +
007400200409     C                             'Contact Address,' +
007500200409     C                             'Contact City,' +
007600200409     C                             'Contact Zip,' +
007700200409     C                             'GBS Account#,' +
007800200409     C                             'AA,' +
007900200415     C                             'Broker,' +
008000200415     C                             'Number of Monthly Installments,' +
008100200415     C                             'First Repayment Month'
008200150702    * *
008300150702     C                   EXCEPT    OUTFA
008400150702   X* *
008500150702    * *
008600150702     C                   ENDSR
008700150702    * *
008800200507     OPAYDFCSGP EADD         OUTFA
008900200409     O                       @OUTPUT           1000
