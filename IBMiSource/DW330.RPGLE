0001000210290015  ******************************************************************
000200030827      * dw330          Group Benefit Services, Inc.                    *
000300021029      *                                                                *
000400021029      *    WRITTEN BY - DAVID KETTERMAN                                *
000500030827      *    DATE       - 08/27/03                                       *
000600021029      *                                                                *
000700030827      * This program will update f.invdet for the cancelled accts      *
000800030827      * in DBCR130NG that finance manually entered.                    *
0009000308070015  *                                                                *
0010000309090015  * 09/09/03 dlk - force update of all outstanding records for     *
0011000309090015  *                the account #.                                  *
0012000804030015  * 04/03/08 dlk - change printer file name to allow emailing report *
0013000909180015  * 09/18/09 dlk - use system date instead of *date                *
0014001002260015  * 02/25/10 dlk - update idcomdt field and copy dbrpa06ng records *
0015001002260015  *                to rpa060wk so the neg fbr commission records   *
0016001002260015  *                are released based on Finance entering the      *
0017001002260015  *                acct cancel date.                               *
0018001107120015  * 07/12/11 dlk - change logic to update the original rpa060wk    *
0019001107070015  *                record with the saved values instead of copying *
0020001107130015  *                the entire record back. If an error occurs that *
0021001107130015  *                prevents a successful update then the rec will  *
0022001107130015  *                be copied to a save file (DW330ER).             *
0023002109170014  * 09/17/21 DLK - Field IDTDDT will now be the Tab 5 date field.  *
0024002109170015  *                This program will select only the invdet        *
0025002109170015  *                records with idtddt <> 0 (these are only from   *
0026002109170015  *                the most current bill file tab 5 run)           *
0027002109170015  *                                                                *
0028000210290015  ******************************************************************
002900030909     Fdbcr130ng ip   E             DISK
003000030827     Finvdet    uf   E           k DISK
003100100226     Fdbrpa06ng if   E           k DISK    rename(rpa60r:dbrpa60r)
003200110707     Frpa060l2  uf   E           k DISK    prefix(r_)
003300110713     Fdw330er   o  a E           k DISK
0034000804030030 Fdw330p    O    F  132        PRINTER OFLIND(*INOF)
003500960408     D                UDS
0036000308270125 D  Leffymd                1      8  0
0037000308270125 D  Lefy                   1      4  0
0038000308270125 D  Lefmd                  5      8  0
0039000712140125 D  Lseq                   9     10
0040000308070054 D  CONAME               201    240
004100030827
0042001002260125 D totpayrem       s             10  2
0043001002260125 D totrecrem       s              6  0
0044001002260125 D lrpayrem        s             11  2
0045001002260125 D lrrecrem        s              7  0
0046001002260125 D totpaycom       s             10  2
0047001002260125 D totreccom       s              6  0
0048001002260125 D lrpaycom        s             11  2
0049001002260125 D lrreccom        s              7  0
0050000308270125 D lefmdy          s              8  0
0051000909180002 D systemdate      S               d   datfmt(*ISO)
005200030909
0053000309090053 Icrhstr
005400030909     I                                          ctrust        L1
005500030909     I                                          csub          L1
005600030909     I                                          cacct         L1
005700030807
005800210917      * update all billed but not paid invdet records with tab 5 date <> 0
005900210917      * for this account to make  them appear as paid (fill IDPAID with
006000210917      * the remittance date)
006100210920      * 09/17/21 - tab 5 date added to selection so we only update the
006200210917      *            exact records part of tab 5 since COBRA members paid
006300210917      *            status is now done seperate.
006400210917      *        * - I am going to leave the tab 5 date filled in the invdet
006500211011      *            record to show it was paid in the tab 5 udpate.
006600210917
006700030909     c                   if        *inl1
006800030909
006900100226     c                   clear                   totpayrem
007000100226     c                   clear                   totrecrem
007100100226     c                   clear                   totpaycom
007200100226     c                   clear                   totreccom
007300030827
007400030827     c     invkey        setll     invdet
007500030827     C                   dou       %eof(invdet)
007600030827     c     invkey        reade     invdet
007700030807
007800030828     c                   if        not %eof(invdet) and idbccc = 'D' and
007900210917     c                             idtrnd <> 0 and idtddt <> 0 and
008000100226     c                             (idpaid = 0 or idcomdt = 0)
008100030909
008200100226      * update remittance paid date
008300100226     c                   if        idpaid = 0
008400030827     c                   move      leffymd       idpaid
008500100226     c                   add       idtram        totpayrem
008600100226     c                   add       1             totrecrem
008700210917     c**** don't clear   clear                   idtddt
008800100226     c                   end
008900080909
009000100226      * update commission paid date
009100100226     c                   if        idcomdt = 0
009200100226     c                   move      uymd          idcomdt
009300100226     c                   add       idtram        totpaycom
009400100226     c                   add       1             totreccom
009500210917     c**** don't clear   clear                   idtddt
009600100226     c                   end
009700080909
009800030827     c* u1 = update
009900030827     c   u1              update    invdr
010000030807     c                   end
010100030807
010200030807     c                   enddo
010300030807
010400100226     c                   if        totrecrem <> 0 or totreccom <> 0
010500030827     c   of              except    head
010600030827     c                   except    detail
010700100226     c                   add       totrecrem     lrrecrem
010800100226     c                   add       totpayrem     lrpayrem
010900100226     c                   add       totreccom     lrreccom
011000100226     c                   add       totpaycom     lrpaycom
011100080909
011200080909     c                   end
011300030909
011400110712      * 07/12/11 - change logic to
011500110712      * update the original rpa060wk record with the saved values in
011600110712      * dbrpa060ng instead of copying the whole record back because it
011700110712      * caused dup rec on the rpa060l2 key and that caused the maint pgm
011800110713      * to not see them
011900100226     c                   move      lseq          lseqnum           2 0
012000100226
012100100226     c     dbrpakey      setll     dbrpa06ng
012200100226     C                   dou       %eof(dbrpa06ng)
012300100226     c     dbrpakey      reade     dbrpa06ng
012400100226
012500110712      * update the original rpa060wk record with the saved values in
012600110712      * dbrpa06ng and the change field = F to indicate it was added
012700110712      * by the neg fbr process (this program)
012800110712      * *note - this pgm must be run before the rpa060wk update is run
012900110712      *         or else the rpcpddt (comm paid date) will not match and
013000110712      *         the update will fail
013100110712
013200100226     c                   if        not %eof(dbrpa06ng) and rpseq# = lseqnum
013300100226     c                             and RPACCANDT <> 0
013400110712
013500110712     c     rpa060l2key   chain     rpa060l2
013600110712     c                   if        %found(rpa060l2) and r_rppaid = 'N' and
013700110712     c                             r_rppprm = 0 and r_rppcom = 0 and
013800110712     c                             r_rpmcnt = 0 and r_rpaomthd = *blanks and
013900110712     c                             r_rpaorate = 0 and r_rpaoamt = 0
014000110712     c                   move      rppprm        r_rppprm
014100110712     c                   move      rppcom        r_rppcom
014200110712     c                   move      rpmcnt        r_rpmcnt
014300110712     c                   move      rpaomthd      r_rpaomthd
014400110712     c                   move      rpaorate      r_rpaorate
014500110712     c                   move      rpaoamt       r_rpaoamt
014600110712     c                   move      rppaid        r_rppaid
014700110713     c                   move      'F'           r_rpchg
014800110712     c                   update    rpa60r
014900110712     c                   else
015000110713
015100110712      * error - rec not found or values changed
015200110713      * write record to hold file for possible manual update or research
015300110713      * and print on error report
015400110713     c                   move      'F'           rpchg
015500110713     c                   move      systemdate    DW3DATE
015600110713     c                   move      systime       DW3TIME
015700110713     c                   write     dw330err
015800110712     c                   except    err1
015900100226     c                   end
016000110712
016100110712     c                   end
016200100226     c                   enddo
016300100226
016400030909     c                   endif
016500030827
016600030828     clr                 except    total
016700030807
016800021106     C     *inzsr        begsr
016900021106     C                   TIME                    HTIME             6 0
017000030807
017100030827     c     invkey        klist
017200030827     c                   kfld                    ctrust
017300030827     c                   kfld                    csub
017400030827     c                   kfld                    cacct
017500100226
017600100226     c     dbrpakey      klist
017700100226     c                   kfld                    leffymd
017800100226     c                   kfld                    ctrust
017900100226     c                   kfld                    csub
018000100226     c                   kfld                    cacct
018100110712
018200110712     c     rpa060l2key   klist
018300110712     c                   kfld                    RPCPDDT
018400110712     c                   kfld                    RPCDAT
018500110712     c                   kfld                    RPSEQ#
018600110712     c                   kfld                    RPRELID
018700110712     c                   kfld                    RPTRST
018800110712     c                   kfld                    RPSUB
018900110712     c                   kfld                    RPACC
019000110712     c                   kfld                    RPGRP
019100110712     c                   kfld                    RPPLAN
019200110712     c                   kfld                    RPEFDT
019300021118
019400030827     c                   movel     lefmd         lefmdy
019500030827     c                   move      lefy          lefmdy
019600090918
019700090918      * put system date in systemdate field (*ISO = YYYYMMDD)
019800090918      /free
019900090918       systemdate = %date();
020000090918      /end-free
020100090918     C                   MOVE      systemdate    UYMD              8 0
020200110713     C                   time                    systime           6 0
020300030827
020400030827     c                   except    head
020500021106     C                   ENDSR
020600030909
0207000804030237 Odw330p    E            HEAD           2 03
0208002109210241 O                       coname              85
0209000308270242 O          E            HEAD           1
0210000308280248 O                                           24 'PROGRAM NAME: DW330'
0211000308280244 O                                           60 'INVOICE DETAIL UPDATE FO'
0212000308280244 O                                           +0 'R CANCELLED ACCTS IN DBC'
0213000308280244 O                                           +0 'R130NG.'
0214000308280249 O                                          122 'PAGE :'
0215000308280250 O                       PAGE          Z    131
0216000308270242 O          E            HEAD           1
0217000308270253 O                                           14 'RUN DATE:'
0218000308270254 O                       UDATE         Y     25
021900030828 244 O                                           59 'FOR :'
022000030828 244 O                       lefmdy              70 '  /  /    '
022100071214 244 O                                           +3 'SEQ :'
022200071214 244 O                       lseq                +2
0223000308270255 O                                          122 'TIME :'
0224000308270256 O                       HTIME              131 '  :  :  '
0225000308270242 O          E            HEAD           1
0226000308270259 O                                           24 '------------------------'
0227000308270260 O                                           48 '------------------------'
0228000308270261 O                                           72 '------------------------'
0229000308270262 O                                           96 '------------------------'
0230000308270263 O                                          120 '------------------------'
0231000308270286 O                                          132 '------------'
0232000308270242 O          E            HEAD           1
0233000308270267 O                                           12 'ACCOUNT'
0234001002260268 O                                           30 'TOTAL PAID'
0235000309090268 O                                           51 'TOTAL REC UPDATED'
0236001002260268 O                                           68 'TOTAL PAID'
0237001002260268 O                                           89 'TOTAL REC UPDATED'
0238001002260242 O          E            HEAD           1
0239001002260268 O                                           30 'REMITTANCE'
0240001002260268 O                                           51 'REMITTANCE       '
0241001002260268 O                                           68 'COMMISSION'
0242001002260268 O                                           89 'COMMISSION       '
0243000308270242 O          E            HEAD           2
0244000308270259 O                                           24 '------------------------'
0245000308270260 O                                           48 '------------------------'
0246000308270261 O                                           72 '------------------------'
0247000308270262 O                                           96 '------------------------'
0248000308270263 O                                          120 '------------------------'
0249000308270286 O                                          132 '------------'
0250000308270287 O          E            DETAIL         1
0251000308270288 O                       ctrust               3
0252000308270288 O                                            4 '-'
0253000308270288 O                       csub                 7
0254000308270288 O                                            8 '-'
0255000308270288 O                       cacct               12
0256001002260288 O                       totpayrem     j     30
0257001002260288 O                       totrecrem     2     51
0258001002260288 O                       totpaycom     j     68
0259001002260288 O                       totreccom     2     89
0260001107120287 O          E            err1           1
0261001107120288 O                       rptrst               3
0262001107120288 O                                            4 '-'
0263001107120288 O                       rpsub                7
0264001107120288 O                                            8 '-'
0265001107120288 O                       rpacc               12
026600110712     o                                           +1 'Rem dt:'
026700110712     o                       RPCDAT              +1
026800110712     o                                           +1 'Sq:'
026900110712     o                       RPSEQ#              +1
027000110712     o                                           +1 'Rel:'
027100110712     o                       RPRELID             +1
027200110712     o                                           +1 'Grp:'
027300110712     o                       RPGRP               +1
027400110712     o                                           +1 'Pln:'
027500110712     o                       RPPLAN              +1
027600110712     o                                           +1 'Efdt:'
027700110712     o                       RPEFDT              +1
027800110712     o                                           +2 '<-- RPA060WK UPDATE ERROR'
0279001002260287 O          e            total       1  1
0280000308270288 O                                            7 'TOTAL :'
0281001002260288 O                       lrpayrem      j     30
0282001002260288 O                       lrrecrem      2     51
0283001002260288 O                       lrpaycom      j     68
0284001002260288 O                       lrreccom      2     89
