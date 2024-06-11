0001000210290015  ******************************************************************
000200031002      * dw265          Group Benefit Services, Inc.                    *
000300021029      *                                                                *
000400021029      *    WRITTEN BY - DAVID KETTERMAN                                *
000500031001      *    DATE       - 10/01/03                                       *
000600021029      *                                                                *
000700031001      * This program will clear the paid & comm amts in dbrec for      *
000800031001      * groups in the DBFBRNHS file.                                   *
0009000309300015  *                                                                *
0010000711300015  * 11/30/07 dlk - change late field to seq                        *
0011001911010015  * 11/01/09 dlk - also clear life volume field                    *
0012002107010015  * 07/01/21 dlk - fix totdif on detail line                       *
0013000309090015  *                                                                *
0014000210290015  ******************************************************************
001500031001     Fdbrec     up   E             DISK
001600031001     Fdbfbrnhs  if   E           k DISK
0017000308290030 Fqsysprt   O    F  132        PRINTER OFLIND(*INOF)
0018000310010055 D                 DS
0019000310010056 D  bcgn                   1     15
0020000310010056 D   groupid               1      8
0021000310010056 D   subgroupid            9     12
002200030930     D                UDS
0023000309300125 D  Leffmdy               85     92  0
0024000310010125 D  Leffmd                85     88  0
0025000310010125 D  Leffy                 89     92  0
0026000711300125 D  lseq                  21     22  0
0027000308070054 D  CONAME               201    240
002800031001
0029000310010125 D totpay          s             10  2
0030000310010125 D totrec          s              6  0
0031000310010125 D lrpay           s             11  2
0032000310010125 D lrrec           s              7  0
0033000310010125 D totdif          s             10  2
0034000310010125 D lrdif           s             11  2
0035000310010053 Ibcrecr
003600031001     I                                          bcgn          L1
003700030909
003800031001      * clear the paid & comm amts in dbrec for all groups in
003900031001      * the negative FBR file
004000030827
004100031001     c                   if        *inl1
004200031001     c     dbfbrnkey     chain     dbfbrnhs
004300031001     c                   end
004400031001
004500031001     C                   if        %found(dbfbrnhs)
004600031002     c                   add       bcpada        totpay
004700031002     c                   add       1             totrec
004800031002
004900031002      * if the billed or adj amt are not zero then this is a new record
005000031002      * that will have the paid & comm amts cleared.
005100031002
005200031002     c                   if        bcbila <> 0 or bcadja <> 0
005300031001     c                   clear                   bcpada
005400031001     c                   clear                   bcmcnt
005500031001     c                   clear                   bcdchg
005600031001     c                   clear                   bcfchg
005700031001     c                   clear                   bccchg
005800191101     c                   clear                   bclifev
005900031006     c                   update    bcrecr
006000031002
006100031002     c                   else
006200031002      * billed & adj are zero
006300031002
006400031002      * If the paid amount is not zero then delete it
006500031002      * If the paid amt is zero this record could be a zero rate plan
006600031002      * so do not delete it since we can not tell if it is the first
006700031002      * time through.
006800031002
006900031002     c                   if        bcpada <> 0
007000031013     c                   delete    bcrecr
007100031002     c                   end
007200031001     c                   end
007300031002
007400031002     c                   end
007500031001
007600031001     cl1                 exsr      #l1sr
007700030828     clr                 except    total
007800031001
007900031001     c     #l1sr         begsr
008000031001     c                   if        totrec <> 0
008100210701     c                   eval      totdif = totpay - dnpaid
008200031001     c   of              except    head
008300031001     c                   except    detail
008400031001     c                   add       totrec        lrrec
008500031001     c                   add       totpay        lrpay
008600031001     c                   add       totdif        lrdif
008700031001     c                   clear                   totrec
008800031001     c                   clear                   totpay
008900031001     c                   clear                   totdif
009000031001     c                   end
009100031001     c                   endsr
009200031001
009300021106     C     *inzsr        begsr
009400021106     C                   TIME                    HTIME             6 0
009500030807
009600031001     c     dbfbrnkey     klist
009700031001     c                   kfld                    leffymd
009800071130     c                   kfld                    lseq
009900031001     c                   kfld                    groupid
010000031001     c                   kfld                    subgroupid
010100021118
010200031001     c                   movel     leffy         leffymd           8 0
010300031001     c                   move      leffmd        leffymd
010400030827
010500030827     c                   except    head
010600021106     C                   ENDSR
010700030909
0108000308290237 Oqsysprt   E            HEAD           2 03
0109000310010239 O                       coname              85
0110000308270242 O          E            HEAD           1
0111000310020248 O                                           24 'PROGRAM NAME: DW265'
0112000310010244 O                                           55 'DBREC UPDATE TO CLEAR THE'
0113000310010244 O                                           +0 ' PAID AND COMM AMOUNTS FOR'
0114000310010244 O                                           +0 ' ALL NEG FBR GROUPS'
0115000308280249 O                                          122 'PAGE :'
0116000308280250 O                       PAGE          Z    131
0117000308270242 O          E            HEAD           1
0118000308270253 O                                           14 'RUN DATE:'
0119000308270254 O                       UDATE         Y     25
012000031001 244 O                                           50 'EFFECTIVE :'
012100031001 244 O                       leffmdy             +1 '  /  /    '
0122000308270255 O                                          122 'TIME :'
0123000308270256 O                       HTIME              131 '  :  :  '
0124000308270242 O          E            HEAD           1
0125000308270259 O                                           24 '------------------------'
0126000308270260 O                                           48 '------------------------'
0127000308270261 O                                           72 '------------------------'
0128000308270262 O                                           96 '------------------------'
0129000308270263 O                                          120 '------------------------'
0130000308270286 O                                          132 '------------'
0131000308270242 O          E            HEAD           1
0132000310010267 O                                           15 'GROUP/SUB GROUP'
0133000310010268 O                                           35 'TOTAL REC UPDATED'
0134000310010268 O                                           51 'TOTAL PAID'
0135000310010268 O                                           74 'PAID $ FROM DBFBRNHS'
0136000310010268 O                                           90 'DIFFERENCE'
0137000308270242 O          E            HEAD           2
0138000308270259 O                                           24 '------------------------'
0139000308270260 O                                           48 '------------------------'
0140000308270261 O                                           72 '------------------------'
0141000308270262 O                                           96 '------------------------'
0142000308270263 O                                          120 '------------------------'
0143000308270286 O                                          132 '------------'
0144000308270287 O          E            DETAIL         1
0145000310010288 O                       bcgn                15
0146000310010288 O                       totrec        2     35
0147000310010288 O                       totpay        j     51
0148000310010288 O                       dnpaid        j     74
0149000310010288 O                       totdif        j     90
0150000308270287 O          e            total       1  1
0151000310010288 O                                           35 '------------'
0152000310010288 O                                           51 '---------------'
0153000310010288 O                                           90 '---------------'
0154000308270287 O          e            total          1
0155000308270288 O                                            7 'TOTAL :'
0156000310010288 O                       lrrec         2     35
0157000310010288 O                       lrpay         j     51
0158000310010288 O                       lrdif         j     90
