0001000510210002  ******************************************************************
0002001001200003  * rpa022     GROUP BENEFIT SERVICES, INC.                        *
0003000510210004  *                                                                *
0004000510210005  *            WRITTEN BY - David Ketterman                        *
0005001002010006  *            DATE - 02/01/10                                     *
0006000510210007  *                                                                *
000700051021      *
0008001002010008  *  DESCRIPTION - THIS PROGRAM WILL CREATE THE workfile that will *
0009001002020009  *                be used to create the A/R spreadsheet. This 2nd *
0010001002020015  *                workfile is needed to resort the data after     *
0011001002120015  *                the unpaid records and tab4 records were added. *
0012001401090015  *                                                                *
0013001401090015  * 01/09/14 dlk - dep seq# from work file will be used to know    *
0014001401090015  *                when not to add to the member count             *
0015001903080015  * 03/08/19 dlk - add commission amount to paid amount for PSF    *
0016001903080015  *                carriers since they only have the net rate      *
0017001903110015  *                in the remittance in order to calc the PSF      *
0018001903080015  *                off of net. When Finance sends the remittance   *
0019001903080015  *                to CF they manually add the PSF (COM) to the    *
0020001903080015  *                paid amt so that same thing must happen here.   *
0021001904260015  * 04/26/19 dlk - fix paid_wk fill in second check for rec w/o    *
0022001904260015  *                invele rec, it was not being set correctly      *
0023001904260015  *                for tab4.                                       *
0024002105130015  * 05/13/21 dlk - change to how memcnt views subsidy plans.       *
0025002105130015  *                Remove the skip of subsidy plans (sfadm = Y),   *
0026002105130015  *                add skip of zero billed records. This will count*
0027002105130015  *                the fed subsidy plan but not the members real   *
0028002105130015  *                coverage plan (fed and state).                  *
0029002105130015  *                                                                *
0030002105130015  *                                                                *
0031000510210013  ******************************************************************
0032001001210005 Frpa021wk  ip   e           k disk
0033001001200005 Faccmst    if   e           k disk
0034001003100005 Fplnmst    if   e           k disk
0035001003100005 Fcodesl1   if   e           k disk
0036001001210005 Frpa022l1  uf   e           k disk
0037001002010005 Frpa022bwk o  a e             disk
003800100121
0039001001210125 Dcsv              c                   const('","')
004000100219     D  l1billed       s             11s 2
0041001001210056 D  cycleout       s                   like(r2inveff)
0042001001210056 D  invout         s                   like(r2inv#)
0043001001210056 D  tsaout         s             10s 0
0044001001210056 D  acnamout       s             40
0045001001210056 D  groupout       s                   like(r2group)
0046001001210056 D  effout         s                   like(r2treff)
0047001002020056 D  holdinv#       s                   like(r2inv#)
0048001002010056 D  baout          s             12s 2
0049001003100056 D  mcout          s              8s 0
0050001003100056 D  l1memcnt       s              8s 0
0051001001210056 D  payout1        s             11s 2
0052001001210056 D  payout2        s             11s 2
0053001001210056 D  payout3        s             11s 2
0054001002040056 D  payout4        s             11s 2
0055001002120056 D  payout5        s             11s 2
0056001001220056 D  payouttot      s             12s 2
0057001001210056 D  paytot1        s             11s 2
0058001001210056 D  paytot2        s             11s 2
0059001001210056 D  paytot3        s             11s 2
0060001002040056 D  paytot4        s             11s 2
0061001002090056 D  paytot5        s             11s 2
0062001002010056 D  paytot         s             12s 2
0063001001220056 D  firstrec       s              1
0064001002020056 D  holdcobra      s              1
0065001002020056 D  cobraout       s              1
0066001903080056 D  paid_wk        s             11s 2
0067001001210055 D                 DS
0068001001210056 D  tsa                    1     10  0
0069001001210056 D  R2TRUST                1      3  0
0070001001210056 D  R2SUB                  4      6  0
0071001001210056 D  R2ACCT                 7     10  0
0072001001210055 D                 DS
0073001001210056 D  r2treff                1      8  0
0074001001210056 D  R2try                  1      4  0
0075001001210056 D  R2trm                  5      6  0
0076001001210056 D  R2trd                  7      8  0
0077001001220055 D                 DS
0078001001220056 D  l1ctl                  1     31
0079001001220056 D  CEFFDT                 1      8  0
008000100122     D  CGROUP                 9     23
0081001001220056 D  CEFIYY                24     27  0
0082001001220056 D  CEFIMM                28     29  0
0083001001220056 D  CEFIDD                30     31  0
0084001001220055 D                 DS
0085001001220056 D  l1ctlhold              1     31
0086001001220056 D  h_CEFFDT               1      8  0
008700100122     D  h_CGROUP               9     23
0088001001220056 D  h_CEFIYMD             24     31  0
0089001001210055 D                UDS
0090001001210056 D  Ltrust                 1      3  0
0091001001210056 D  Lsub                   4      6  0
0092001001210056 D  Lacc                   7     10  0
009300100121     irpa021r
009400100121     i                                          R2INVEFF      l1
009500100121     i                                          R2GROUP       l1
009600100121     i                                          R2TREFF       l1
009700051025
009800100121     c                   if        *inl1
009900100121     c                   clear                   l1billed
010000100310     c                   clear                   l1memcnt
010100100202     c                   clear                   holdinv#
010200100202     c                   clear                   holdcobra
010300100121     c                   end
010400100121
010500100121     c                   add       r2billed      l1billed
010600100202
010700100202      * collect account invoice # only
010800100202     c                   if        holdinv# = 0 and
010900100202     c                             r2inv# <> 0 and r2cobra <> 'C'
011000100202     c                   move      r2inv#        holdinv#
011100100202     c                   end
011200100202      * are there any cobra invoices in this L1
011300100202     c                   if        r2cobra = 'C'
011400100202     c                   move      'Y'           holdcobra
011500100202     c                   end
011600100310      * get member count
011700100310     c                   exsr      #getmem
011800100310
011900051024      * write spreadsheet
012000051020     cl1                 exsr      #write
012100100122
012200100122      * check for unreported payments
012300100122     clr                 exsr      #unrep
012400051020
012500051024      *******************************
012600100201      * write workfile
012700051024      *******************************
012800051020     c     #write        begsr
012900051020
013000100121      * get current acct name
013100100121     c                   clear                   acnamout
013200100121     c     acckey        chain     accmst
013300100121     c                   if        %found(accmst)
013400100121     c                   eval      acnamout = acnam1
013500051025     c                   end
013600051025
013700100201     C                   MOVE      r2inveff      cycleout
013800100121
013900100202     C                   MOVE      holdinv#      invout
014000100202     C                   MOVE      holdcobra     cobraout
014100100121     C                   MOVE      tsa           tsaout
014200100121     C                   MOVE      r2group       groupout
014300100121
014400100201     C                   MOVE      r2treff       effout
014500100121
014600100121     C                   MOVE      l1billed      baout
014700100310     C                   MOVE      l1memcnt      mcout
014800100121
014900100121      * get payment info
015000100121     c                   exsr      #getpayinf
015100100121
015200100201      * write to workfile
015300100201     c                   exsr      writewk
015400100121
015500051020     c                   endsr
015600100310      *******************************
015700100310      * get member count
015800100310      *******************************
015900100310     c     #getmem       begsr
016000100310
016100210513      * skip transactions that do not affect member count such as
016200210513      * dependent transactions and adjustments
016300210513     c                   if        r2dep# <> 0 or r2reccod = '30'
016400140109     c                   leavesr
016500140109     c                   end
016600210513
016700210513      * exclude employer billed (federal) cobra subsidy plans (sfadm=Y)
016800210513      * 05/13/21 - do not skip subsidy plans now, need to count them
016900210513      *            since they hold 100% of premium billed
017000100310     c     plnkey        chain     plnmst
017100210513     c                   if        not %found(plnmst)
017200210513     c                   leavesr
017300210513     c                   end
017400210513
017500100310      * include only medical
017600210513      * positive amt = +1, negative amt = -1 (cobra void inv are in here)
017700210513      * 05/13/21  stop counting zero billed plans
017800100310     c     plncat        chain     codesl1
017900100310     c                   if        %found(codesl1) and action = 'M'
018000210513     c                   select
018100210513     c                   when      r2billed > 0
018200100310     c                   add       1             l1memcnt
018300210513     c                   when      r2billed < 0
018400100310     c                   sub       1             l1memcnt
018500210513     c                   endsl
018600100310     c                   end
018700210513
018800100310
018900100310     c                   endsr
0190001001210103 C***************************************************
0191001001210104 C* get payment info
0192001001210105 C***************************************************
0193001001210107 C*
0194001001210106 C     #getpayinf    BEGSR
019500100121
019600100121     c                   clear                   paytot1
019700100121     c                   clear                   paytot2
019800100121     c                   clear                   paytot3
019900100204     c                   clear                   paytot4
020000100209     c                   clear                   paytot5
020100100122     c                   clear                   paytot
020200100121     c                   clear                   payout1
020300100121     c                   clear                   payout2
020400100121     c                   clear                   payout3
020500100204     c                   clear                   payout4
020600100209     c                   clear                   payout5
020700100122     c                   clear                   payouttot
020800100121
020900190308
021000100121     c     paykey        setll     rpa022L1
021100100121     c                   dou       %eof(rpa022L1)
021200100121     c     paykey        reade     rpa022L1
021300100121     c                   if        not %eof(rpa022L1)
021400190308      * payment work field
021500190308     c                   exsr      #paywk
021600190308      * non-tab4 records
021700100212     c                   if        caccandt = 0
021800100121     c                   select
021900100121     c                   when      cseq = 1
022000190308     c                   add       paid_wk       paytot1
022100100121     c                   when      cseq = 2
022200190308     c                   add       paid_wk       paytot2
022300100121     c                   when      cseq = 3
022400190308     c                   add       paid_wk       paytot3
022500100121     c                   other
022600100204      * seq # > 3
022700190308     c                   add       paid_wk       paytot4
022800100121     c                   endsl
022900100212
023000100212      * tab4 records
023100100212     c                   else
023200190308     c                   add       paid_wk       paytot5
023300100212     c                   end
023400100212
023500100121
023600100121      * update workfile
023700100121     c                   move      '!'           cstat
023800100121     c                   update    rpa022wr
023900100121     c                   end
024000100121
024100100121     c                   enddo
024200100121
024300100121     c                   move      paytot1       payout1
024400100121     c                   move      paytot2       payout2
024500100121     c                   move      paytot3       payout3
024600100204     c                   move      paytot4       payout4
024700100212     c                   move      paytot5       payout5
024800100204     c                   eval      paytot = paytot1 + paytot2 + paytot3 +
024900100212     c                             paytot4 + paytot5
025000100122     c                   move      paytot        payouttot
025100100121
0252001001210120 C                   ENDSR
0253001001210107 C*
0254001001220103 C***************************************************
0255001001220104 C* check for un reported payments
0256001001220105 C***************************************************
0257001001220107 C*
0258001001220106 C     #unrep        BEGSR
025900100122
026000100122     c                   clear                   paytot1
026100100122     c                   clear                   paytot2
026200100122     c                   clear                   paytot3
026300100204     c                   clear                   paytot4
026400100212     c                   clear                   paytot5
026500100122     c                   clear                   paytot
026600100122     c                   clear                   payout1
026700100122     c                   clear                   payout2
026800100122     c                   clear                   payout3
026900100204     c                   clear                   payout4
027000100212     c                   clear                   payout5
027100100122     c                   clear                   payouttot
027200100122
027300100122      * find all records not flagged as having a matching invele record
027400100202      * these need to be added to the work file without a billed amount
027500100122     c     acckey        setll     rpa022L1
027600100122     c                   dou       %eof(rpa022L1)
027700100122     c     acckey        reade     rpa022L1
027800100122     c                   if        not %eof(rpa022L1) and cstat <> '!'
027900190426      * payment work field
028000190426     c                   exsr      #paywk
028100190426
028200100122      * force first rec control field
028300100122     c                   if        firstrec <> 'N'
028400100122     c                   move      'N'           firstrec
028500100122     c                   move      l1ctl         l1ctlhold
028600100122     c                   end
028700100122
028800100202      * write line to work file when remit dt, group#, effdt changes
028900100209      * using hold data
029000100122     c                   if        l1ctl <> l1ctlhold
029100100122     c                   exsr      #writerem
029200100122     c                   move      l1ctl         l1ctlhold
029300100122     c                   end
029400100122
029500100212      * non-tab4 records
029600100212     c                   if        caccandt = 0
029700100122     c                   select
029800100122     c                   when      cseq = 1
029900190308     c                   add       paid_wk       paytot1
030000100122     c                   when      cseq = 2
030100190308     c                   add       paid_wk       paytot2
030200100122     c                   when      cseq = 3
030300190308     c                   add       paid_wk       paytot3
030400100122     c                   other
030500100204      * seq # > 3
030600190308     c                   add       paid_wk       paytot4
030700100122     c                   endsl
030800100212      * tab4 records
030900100212     c                   else
031000190308     c                   add       paid_wk       paytot5
031100100212     c                   end
031200100212
031300100122      * update workfile
031400100122     c                   move      '!'           cstat
031500100122     c                   update    rpa022wr
031600100122     c                   end
031700100122     c                   enddo
031800100202
031900100202      * write to workfile at end of file if at least one rec was read
032000100202     c                   if        paytot1 <> 0 or paytot2 <> 0 or
032100100212     c                             paytot3 <> 0 or paytot4 <> 0 or
032200100212     c                             paytot5 <> 0
032300100202     c                   exsr      #writerem
032400100202     c                   end
032500100122
0326001001220120 C                   ENDSR
032700100122
032800100122      *******************************
032900100201      * write to workfile for unreported remittance info from hold fields
033000100122      *******************************
033100100122     c     #writerem     begsr
033200100122
033300100122      * get current acct name
033400100122     c                   clear                   acnamout
033500100122     c     acckey        chain     accmst
033600100122     c                   if        %found(accmst)
033700100122     c                   eval      acnamout = acnam1
033800100122     c                   end
033900100122     C                   MOVE      tsa           tsaout
034000100122
034100100122      * use hold field (H_)
034200100201     C                   MOVE      h_ceffdt      cycleout
034300100122
034400100201     C                   MOVE      h_cefiymd     effout
034500100122
034600100122     C                   MOVE      h_cgroup      groupout
034700100122
034800100122      * clear billed fields
034900100122     C                   MOVE      *zeros        invout
035000100122     C                   MOVE      *zeros        baout
035100100310     C                   MOVE      *zeros        mcout
035200100202
035300100202     C                   clear                   cobraout
035400100122
035500100122     c                   move      paytot1       payout1
035600100122     c                   move      paytot2       payout2
035700100122     c                   move      paytot3       payout3
035800100204     c                   move      paytot4       payout4
035900100212     c                   move      paytot5       payout5
036000100204     c                   eval      paytot = paytot1 + paytot2 + paytot3 +
036100100212     c                             paytot4 + paytot5
036200100122     c                   move      paytot        payouttot
036300100122
036400100201      * write workfile
036500100201     c                   exsr      writewk
036600100122
036700100122     c                   clear                   paytot1
036800100122     c                   clear                   paytot2
036900100122     c                   clear                   paytot3
037000100204     c                   clear                   paytot4
037100100212     c                   clear                   paytot5
037200100122     c                   clear                   paytot
037300100122     c                   clear                   payout1
037400100122     c                   clear                   payout2
037500100122     c                   clear                   payout3
037600100204     c                   clear                   payout4
037700100212     c                   clear                   payout5
037800100122     c                   clear                   payouttot
037900100122
038000100122     c                   endsr
038100190308
0382001001210103 C***************************************************
0383001001210104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0384001001210105 C***************************************************
0385001001210107 C*
0386001001210107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0387001001210107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0388001001210107 C*
0389001001210106 C     #DATYM        BEGSR
039000100121     C                   MOVE      @DATIN        @MD               4 0
039100100121     C                   MOVEL     @DATIN        @Y                4 0
039200100121     C                   MOVEL     @MD           @DATOU            8 0
039300100121     C                   MOVE      @Y            @DATOU
039400100121     C                   MOVE      *ZEROS        @DATIN            8 0
0395001001210120 C                   ENDSR
0396001001210107 C*
039700051024
039800100209     C*
0399000510240164 C*************************************************************
0400000510240164 C*                                                           *
0401001002010164 C* Write workfile                                            *
0402000510240164 C*                                                           *
0403000510240164 C*************************************************************
040400100201     C     Writewk       BEGSR
040500051024
040600100201     c                   clear                   rpa022br
040700100201
040800100201     c                   eval      RBBILCYC = cycleout
040900100201     c                   eval      RBINV    = invout
041000100202     c                   eval      RBCOBRA  = cobraout
041100100201     c                   eval      RBACC    = tsaout
041200100201     c                   eval      RBACNAM  = acnamout
041300100201     c                   eval      RBGRP#   = groupout
041400100201     c                   eval      RBCOVMON = effout
041500100201     c                   eval      RBBILA   = baout
041600100310     c                   eval      RBmemcnt = mcout
041700100201     c                   eval      RBPAY1   = payout1
041800100201     c                   eval      RBPAY2   = payout2
041900100201     c                   eval      RBPAY3   = payout3
042000100204     c                   eval      RBPAY4   = payout4
042100100209     c                   eval      RBPAY5   = payout5
042200100201     c                   eval      RBPAYTOT = payouttot
042300100308     c                   eval      RBbaldue = rbbila - rbpaytot
042400051024
042500100201     C                   Write     rpa022br
042600100219
0427000510240320 C                   ENDSR
042800190308
042900190308      *******************************
043000190308      * payment work field
043100190308      *******************************
043200190308     c     #paywk        begsr
043300190308
043400190308      * 3/8/19 - psf carriers need to have the commision amount added
043500190308      * to the paid amount because it is not part of the net paid amt
043600190308     c                   clear                   paid_wk
043700190308     c                   add       cpamt         paid_wk
043800190308     c                   if        ccarcd = 'PSM' or ccarcd = 'PSX'
043900190308     c                   add       ccome         paid_wk
044000190308     c                   end
044100190308
044200190308     c                   endsr
0443001903080107 C*
0444000510240103 C***************************************************
0445000510240104 C* FIRST CYCLE                                     *
0446000510240105 C***************************************************
0447000510240106 C     *INZSR        BEGSR
044800051024
044900100121     c     acckey        klist
045000100121     c                   kfld                    R2TRUST
045100100121     c                   kfld                    R2SUB
045200100121     c                   kfld                    R2ACCT
045300100121
045400100310     c     plnkey        klist
045500100310     c                   kfld                    R2TRUST
045600100310     c                   kfld                    R2SUB
045700100310     c                   kfld                    R2plan
045800100310
045900100121     c     paykey        klist
046000100121     c                   kfld                    R2TRUST
046100100121     c                   kfld                    R2SUB
046200100121     c                   kfld                    R2ACCT
046300100121     c                   kfld                    R2INVEFF
046400100121     c                   kfld                    R2GROUP
046500100121     c                   kfld                    R2try
046600100121     c                   kfld                    R2trm
046700100121     c                   kfld                    R2trd
046800100121
046900051024
047000051024     C                   endsr
