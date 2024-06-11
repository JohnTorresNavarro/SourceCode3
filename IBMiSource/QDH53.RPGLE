0001002211220002 F**********************************************************************
0002002211220003 F* qdh53      Written by - David Ketterman                            *
0003002211220006 F*            DATE - 11/21/22                                         *
0004002211220007 F*                                                                    *
0005002211220011 F* List related account changes and send to Kevin for Amwins View     *
0006002211220011 F* access update. This will be run from ROBOT each day for the        *
0007002211220011 F* previous day.                                                      *
0008002211220013 F**********************************************************************
0009001011040005 Fhist      ip   e             disk
001000221121     Faccmst    IF   E           K DISK
0011002211210018 Fgbsecure  IF   e           k DISK
0012002211210018 Fcodesl1   IF   e           k DISK
0013002211210005 Fqdh53xl   o  a e             disk
001400050303
001500221121     D  csv            c                   const('","')
001600221121     d  user_o         s                   like(scname)
001700221121     d  acnam_o        s                   like(acnam1)
001800221121     d  desc_o         s                   like(ldescr)
001900221121     d  onerec         s              1
002000050302     D                 dS
0021000503020125 D  tsa                    1     10  0
0022001011040125 D  hstrst                 1      3  0
0023001011040125 D  hssub#                 4      6  0
0024001011040125 D  hsacct                 7     10  0
002500050624
002600101104
002700221121      * get account name
002800221121       clear acnam_o;
0029002211210171   CHAIN (hstrst:hssub#:hsacct) accmst;
003000221121       if %found(accmst);
003100221121        acnam_o = acnam1;
003200221121       endif;
003300130408
003400221121      * get user name
003500221121       clear user_o;
0036002211210171   CHAIN (hoper) gbsecure;
003700221121       if %found(gbsecure);
003800221121        user_o = scname;
003900221121       endif;
004000130408
004100221121      * get trans description
004200221121       clear desc_o;
0043002211210171   CHAIN (trcode) codesl1;
004400221121       if %found(codesl1);
004500221121        desc_o = ldescr;
004600221121       endif;
004700221121
004800221122      * write record to file
004900221122       exsr writexldet;
005000101104
0051002211210164  *************************************************************
0052002211210164  * Write Spreadsheet Detail                                  *
0053002211210164  *************************************************************
005400221121        begsr Writexldet;
005500221121
005600221121        if onerec <> 'Y';
005700221121        onerec = 'Y';
005800221121         Exsr Writexlhead;
005900221121        endif;
006000101104
006100221121        clear qdh53fld;
006200221121            qdh53fld  = '"' +
006300221121              %trim(%editw(trdate:'    /  /  '))     + csv +
006400221121              %char(hstrtime)                        + csv +
006500221121              %trim(desc_o)                          + csv +
006600221121              %trim(%editw(tsa:'0   -   -    '))     + csv +
006700221121              %trim(acnam_o)                         + csv +
006800221121              %trim(ck#not)                          + csv +
006900221121              %trim(note2)                           + csv +
007000221121              %trim(user_o)                          + csv +
007100221121              ' '                                    +
007200221121              '"';
007300221121
007400221121        Write qdh53r;
007500221121
0076002211210320    ENDSR;
007700221121
007800221121      *************************************************************
007900221121      * Write Spreadsheet heading                                 *
008000221121      *************************************************************
008100221121        begsr Writexlhead;
008200101104
008300221121        clear qdh53fld;
008400221121            qdh53fld  = '"' +
008500221121              'TRANS DATE'                           + csv +
008600221121              'TRANS TIME'                           + csv +
008700221121              'TRANS DESCRIPTION'                    + csv +
008800221121              'T-S-A'                                + csv +
008900221121              'ACCT NAME'                            + csv +
009000221121              'NOTE 1'                               + csv +
009100221121              'NOTE 2'                               + csv +
009200221121              'USER'                                 + csv +
009300221121              ' '                                    +
009400221121              '"';
009500221121
009600221121        Write qdh53r;
009700221121
0098002211210320    ENDSR;
