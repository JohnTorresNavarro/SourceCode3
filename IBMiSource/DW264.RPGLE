0001000210290015  ******************************************************************
000200031002      * dw264          Group Benefit Services, Inc.                    *
000300021029      *                                                                *
000400021029      *    WRITTEN BY - DAVID KETTERMAN                                *
000500030930      *    DATE       - 09/30/03                                       *
000600021029      *                                                                *
000700030930      * This program will clear the paid date in F.INVDET for records  *
000800030930      * just paid in the DBE remittance that have groups in the        *
0009000309300015  * DBFBRNHS file.                                                 *
0010000309300015  *                                                                *
0011000711300014 F* 11/30/07 DLK - change late indicator                          *
0012001002250014  * 02/24/10 DLK - change to allow clear of IDPAID and/or IDCOMDT  *
0013001002240015  *                since commission payments are now held when a   *
0014001002240015  *                group is in the neg FBR.                        *
0015002109170014  * 09/17/21 DLK - Field IDTDDT will now be the Tab 5 date field.  *
0016002109170015  *                This was needed so that DW330 will know exatcly *
0017002109170015  *                what records make up tab 5. When COBRA was      *
0018002109170015  *                changed to pay seperately from accounts this    *
0019002109170015  *                made the records that make up tab 5 no longer   *
0020002109170015  *                exactly match every invdet record for the acct  *
0021002109170015  *                in the current run so a way was needed to flag  *
0022002109170015  *                only the tab 5 records.                         *
0023002109170015  *                                                                *
0024000210290015  ******************************************************************
002500031001     Finvdet    up   E             DISK
002600031001     Fdbfbrnhs  if   E           k DISK
0027001002250030 FQSYSPRT   O    F  132        PRINTER OFLIND(*INOF)
0028000310010055 D                 DS
0029000310010056 D  idgrp#                 1     15
0030000310010056 D   groupid               1      8
0031000310010056 D   subgroupid            9     12
003200030930     D                UDS
0033000309300125 D  Leffmdy               85     92  0
0034000310010125 D  Leffmd                85     88  0
0035000310010125 D  Leffy                 89     92  0
0036000711300125 D  lseq                  21     22  0
0037000308070054 D  CONAME               201    240
0038000310010125 D  Lruny                400    403
0039000310010125 D  Lrunmd               404    407
004000031001
0041001002240125 D totpayrem       s             10  2
0042001002240125 D totrecrem       s              6  0
0043001002240125 D lrpayrem        s             11  2
0044001002240125 D lrrecrem        s              7  0
0045001002240125 D totdifrem       s             10  2
0046001002240125 D lrdifrem        s             11  2
004700100224
0048001002240125 D totpaycom       s             10  2
0049001002240125 D totreccom       s              6  0
0050001002240125 D lrpaycom        s             11  2
0051001002240125 D lrreccom        s              7  0
0052001002240125 D totdifcom       s             10  2
0053001002240125 D lrdifcom        s             11  2
0054000310010053 Iinvdr
005500031001     I                                          idgrp#        L1
005600030909
005700100224      * clear the paid date(s) in all invdet records paid this day that
005800031001      * are in the negative FBR file
005900210917      * 09/17/21 - also fill the tab 5 date (idtddt)
006000030827
006100031001     c                   if        *inl1
006200031001     c     dbfbrnkey     chain     dbfbrnhs
006300031001     c                   end
006400031001
006500031001     C                   if        %found(dbfbrnhs)
006600100224
006700100224      * remittance paid date
006800100224     c                   if        idpaid = lrunymd
006900100224     c                   add       idtram        totpayrem
007000100224     c                   add       1             totrecrem
007100031001     c                   clear                   idpaid
007200210917     c                   move      lrunymd       idtddt
007300100224     c                   end
007400100224
007500100224      * commission paid date
007600100224     c                   if        idcomdt = lrunymd
007700100224     c                   add       idtram        totpaycom
007800100224     c                   add       1             totreccom
007900100224     c                   clear                   idcomdt
008000210917     c                   move      lrunymd       idtddt
008100100224     c                   end
008200100224
008300031006     c                   update    invdr
008400031001     c                   end
008500031001
008600031001     cl1                 exsr      #l1sr
008700030828     clr                 except    total
008800031001
008900031001     c     #l1sr         begsr
009000100224     c                   if        totrecrem <> 0 or totreccom <> 0
009100100224     c                   eval      totdifrem = totpayrem - dnpaid
009200100224     c                   eval      totdifcom = totpaycom - dnpaid
009300100224     c                   add       totrecrem     lrrecrem
009400100224     c                   add       totreccom     lrreccom
009500100224     c                   add       totpayrem     lrpayrem
009600100224     c                   add       totpaycom     lrpaycom
009700100224     c                   add       totdifrem     lrdifrem
009800100224     c                   add       totdifcom     lrdifcom
009900100812     c   of              except    head
010000100812     c                   except    detail
010100031001     c                   end
010200100225
010300100225     c                   clear                   totrecrem
010400100225     c                   clear                   totpayrem
010500100225     c                   clear                   totdifrem
010600100225     c                   clear                   totreccom
010700100225     c                   clear                   totpaycom
010800100225     c                   clear                   totdifcom
010900031001     c                   endsr
011000031001
011100021106     C     *inzsr        begsr
011200021106     C                   TIME                    HTIME             6 0
011300030807
011400031001     c     dbfbrnkey     klist
011500031001     c                   kfld                    leffymd
011600071130     c                   kfld                    lseq
011700031001     c                   kfld                    groupid
011800031001     c                   kfld                    subgroupid
011900021118
012000031001     c                   movel     leffy         leffymd           8 0
012100031001     c                   move      leffmd        leffymd
012200031001     c                   movel     lrunmd        lrunmdy           8 0
012300031001     c                   move      lruny         lrunmdy
012400100225     c                   move      lrunmd        lrunymd           8 0
012500100225     c                   movel     lruny         lrunymd
012600030827
012700030827     c                   except    head
012800021106     C                   ENDSR
012900030909
0130000310010237 OQSYSPRT   E            HEAD           2  3
0131000310010239 O                       CONAME              85
0132001002250237 O          E            HEAD           1
0133001008050248 O                                           14 'PROGRAM: DW264'
0134001008050244 O                                           42 'INVOICE DETAIL UPDATE TO'
0135001008050244 O                                           68 ' CLEAR THE REMITTANCE AND '
0136001008050244 O                                           93 'COMMISSION PAID DATES ON '
0137001008050244 O                                          111 'ALL NEG FBR GROUPS'
0138000308280249 O                                          122 'PAGE :'
0139000308280250 O                       PAGE          Z    131
0140001002250237 O          E            HEAD           1
0141001008050253 O                                            9 'RUN DATE:'
0142001008050254 O                       UDATE         Y     18
014300031001 244 O                                           50 'EFFECTIVE :'
014400031001 244 O                       LEFFMDY             61 '  /  /    '
014500100224 244 O                                           75 'PAID DATE :'
014600031001 244 O                       LRUNMDY             86 '  /  /    '
0147000308270255 O                                          122 'TIME :'
0148000308270256 O                       HTIME              131 '  :  :  '
0149001002250237 O          E            HEAD           1
0150000308270259 O                                           24 '------------------------'
0151000308270260 O                                           48 '------------------------'
0152000308270261 O                                           72 '------------------------'
0153000308270262 O                                           96 '------------------------'
0154000308270263 O                                          120 '------------------------'
0155000308270286 O                                          132 '------------'
0156001002250237 O          E            HEAD           1
0157001002240267 O                                           15 'GROUP/'
0158001002240268 O                                           25 '# REMIT'
0159001002240268 O                                           34 '# COMM '
0160001002250268 O                                           50 'REMIT PAID'
0161001002250268 O                                           66 'COMM PAID '
0162001002250268 O                                           82 'PAID AMOUNT  '
0163001002250268 O                                           98 'REMITTANCE'
0164001002250268 O                                          114 'COMMISSION'
0165001002250237 O          E            HEAD           1
0166001002240267 O                                           15 'SUB GROUP'
0167001002240268 O                                           25 'DATES'
0168001002240268 O                                           34 'DATES'
0169001002250268 O                                           50 'AMOUNT    '
0170001002250268 O                                           66 'AMOUNT    '
0171001002250268 O                                           82 'FROM DBFBRNHS'
0172001002250268 O                                           98 'DIFFERENCE'
0173001002250268 O                                          114 'DIFFERENCE'
0174001002250237 O          E            HEAD           2
0175000308270259 O                                           24 '------------------------'
0176000308270260 O                                           48 '------------------------'
0177000308270261 O                                           72 '------------------------'
0178000308270262 O                                           96 '------------------------'
0179000308270263 O                                          120 '------------------------'
0180000308270286 O                                          132 '------------'
0181001002250287 O          E            DETAIL         1
0182000310010288 O                       IDGRP#              15
0183001002240288 O                       TOTRECREM     2     25
0184001002240288 O                       TOTRECCOM     2     34
0185001002250288 O                       TOTPAYREM     J     50
0186001002250288 O                       TOTPAYCOM     J     66
0187001002250288 O                       DNPAID        J     82
0188001002250288 O                       TOTDIFREM     J     98
0189001002250288 O                       TOTDIFCOM     J    114
0190001002250287 O          E            TOTAL       1  1
0191000308270288 O                                            7 'TOTAL :'
0192001002250288 O                       LRRECREM      2     25
0193001002250288 O                       LRRECCOM      2     34
0194001002250288 O                       LRPAYREM      J     50
0195001002250288 O                       LRPAYCOM      J     66
0196001002250288 O                       LRDIFREM      J     98
0197001002250288 O                       LRDIFCOM      J    114
