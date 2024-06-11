0000010510210002  ******************************************************************
0000021002010003  * rpa023     GROUP BENEFIT SERVICES, INC.                        *
0000030510210004  *                                                                *
0000040510210005  *            WRITTEN BY - David Ketterman                        *
0000051002010006  *            DATE - 02/01/10                                     *
0000060510210007  *                                                                *
000007051021      *
0000081001200008  *  DESCRIPTION - THIS PROGRAM WILL CREATE THE SPREADSHEET THAT   *
0000091002020009  *                HOLDS THE CARE FIRST A/R REPORT. IT READS       *
0000131002020015  *                RPA022BWK THAT IS KEYED BY BILL CYCLE, GROUP #  *
0000141002020015  *                AND COVERAGE MONTH SO THE OUTPUT SPREADSHEET    *
0000151002190015  *                IS SORTED BY THOSE FIELDS.                      *
0000161002020015  *                                                                *
0000170510210013  ******************************************************************
0017001002010005 Frpa022bwk ip   e           k disk
0017031002010005 Frpa023xl  o  a e             disk
001704100121
0017051001210125 Dcsv              c                   const('","')
0017061002010056 D  cycleout       s                   like(RBBILCYC)
0017071002190056 D  invout         s              7
0017081002020056 D  cobraout       s                   like(RBCOBRA)
0017091002010056 D  tsaout         s                   like(RBACC)
0017101002010056 D  acnamout       s                   like(RBACNAM)
0017111002010056 D  groupout       s                   like(RBGRP#)
0017121002010056 D  effout         s                   like(RBCOVMON)
0017131002190056 D  baout          s             +1    like(RBBILA)
0017141003100056 D  mcout          s             +1    like(RBmemcnt)
0017151002190056 D  lrbil          s             +1    like(RBBILA)
0017161002190056 D  lrpay1         s             +1    like(RBPAY1)
0017171002190056 D  lrpay2         s             +1    like(RBPAY2)
0017181002190056 D  lrpay3         s             +1    like(RBPAY3)
0017191002190056 D  lrpay4         s             +1    like(RBPAY4)
0017201002190056 D  lrpay5         s             +1    like(RBPAY5)
0017211002190056 D  lrpay          s             +1    like(RBPAYTOT)
0017221003080056 D  lrbaldue       s             +1    like(RBbaldue)
0017231002190056 D  payout1        s             +1    like(RBPAY1)
0017241002190056 D  payout2        s             +1    like(RBPAY2)
0017251002190056 D  payout3        s             +1    like(RBPAY3)
0017261002190056 D  payout4        s             +1    like(RBPAY4)
0017271002190056 D  payout5        s             +1    like(RBPAY5)
0017281002190056 D  payouttot      s             +1    like(RBPAYTOT)
0017291003080056 D  baldueout      s             +1    like(RBbaldue)
0017301003090056 D  runbal         s             +1    like(RBbaldue)
0037401001210055 D                UDS
0037411001210056 D  Ltrust                 1      3  0
0037421001210056 D  Lsub                   4      6  0
0037431001210056 D  Lacc                   7     10  0
003905051025
004328051024
004329051024      * write spreadsheet
011800100201     c                   exsr      #write
011801100219
011802100219     clr                 exsr      #writelr
011804051020
011845051024      *******************************
011846051024      * write spreadsheet
011847051024      *******************************
011848051020     c     #write        begsr
011853051020
011854100204     c                   eval      acnamout = rbacnam
011861051025
011862100201     C                   MOVE      RBBILCYC      @DATIN
011863100121     C                   EXSR      #DATYM
011864100121     C                   MOVE      @DATOU        cycleout
011865100121
011866100219     C                   clear                   invout
011867100219     c                   if        rbinv <> 0
011868100202     C                   MOVE      RBINV         invout
011869100219     c                   end
011870100202     C                   MOVE      RBCOBRA       cobraout
011871100201     C                   MOVE      RBACC         tsaout
011872100201     C                   MOVE      RBGRP#        groupout
011873100121
011874100201     C                   MOVE      RBCOVMON      @DATIN
011875100121     C                   EXSR      #DATYM
011876100121     C                   MOVE      @DATOU        effout
011877100121
011878100201     C                   MOVE      RBBILA        baout
011879100310     C                   MOVE      RBMEMCNT      mcout
011880100201     C                   MOVE      RBPAY1        payout1
011881100201     C                   MOVE      RBPAY2        payout2
011882100201     C                   MOVE      RBPAY3        payout3
011883100204     C                   MOVE      RBPAY4        payout4
011884100209     C                   MOVE      RBPAY5        payout5
011885100201     C                   MOVE      RBPAYTOT      payouttot
011886100309     C                   add       RBBALDUE      runbal
011887100309     C                   MOVE      runbal        baldueout
011888100121
011889100121      * write spreadsheet detail line
011890051024     c                   exsr      writexldet
011891100121
011892100219      * accumulate totals
011893100219     c                   add       rbbila        lrbil
011894100219     c                   add       rbpaytot      lrpay
011895100308     c                   add       rbbaldue      lrbaldue
011896100219     c                   add       rbpay1        lrpay1
011897100219     c                   add       rbpay2        lrpay2
011898100219     c                   add       rbpay3        lrpay3
011899100219     c                   add       rbpay4        lrpay4
011900100219     c                   add       rbpay5        lrpay5
011901100219
011902051020     c                   endsr
011903100219      *******************************
011904100219      * write totals
011905100219      *******************************
011906100219     c     #writelr      begsr
011907100219
011908100219     c                   clear                   acnamout
011909100219     c                   move      'FINAL TOTAL' acnamout
011910100219     C                   clear                   cycleout
011911100219     C                   clear                   invout
011912100219     C                   clear                   cobraout
011913100219     C                   clear                   tsaout
011914100219     C                   clear                   groupout
011916100219     C                   clear                   effout
011917100310     C                   clear                   mcout
011918100219     C                   move      lrpay1        payout1
011919100219     C                   move      lrpay2        payout2
011920100219     C                   move      lrpay3        payout3
011921100219     C                   move      lrpay4        payout4
011922100219     C                   move      lrpay5        payout5
011923100219     C                   MOVE      lrbil         baout
011924100219     C                   MOVE      lrpay         payouttot
011925100308     C                   MOVE      lrbaldue      baldueout
011926100219
011927100219      * write spreadsheet detail line
011928100219     c                   exsr      writexldet
011929100219
011933100219     c                   endsr
0120501001220107 C*
0120511001210103 C***************************************************
0120521001210104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0120531001210105 C***************************************************
0120541001210107 C*
0120551001210107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0120561001210107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0120571001210107 C*
0120581001210106 C     #DATYM        BEGSR
012059100121     C                   MOVE      @DATIN        @MD               4 0
012060100121     C                   MOVEL     @DATIN        @Y                4 0
012061100121     C                   MOVEL     @MD           @DATOU            8 0
012062100121     C                   MOVE      @Y            @DATOU
012063100121     C                   MOVE      *ZEROS        @DATIN            8 0
0120641001210120 C                   ENDSR
0120651001210107 C*
012066051024
0120670510240164 C*************************************************************
0120680510240164 C*                                                           *
0121000510240164 C* Write Spreadsheet Detail                                  *
0122000510240164 C*                                                           *
0123000510240164 C*************************************************************
012400051024     C     Writexldet    BEGSR
012500051024
012600100201     c                   clear                   rpa023xfld
012900051024
013100100201     C                   Eval      rpa023xfld =                            '"' +
013101100121     C                             %trim(%editw(cycleout: '  /  /    ')) + csv +
013200100219     C                             %trim(invout)                         + csv +
013201100202     C                             %trim(cobraout)                       + csv +
013202100121     C                             %trim(%editw(tsaout:'   -   -    '))  + csv +
013300100121     C                             %trim(acnamout)                       + csv +
013301100121     C                             %trim(groupout)                       + csv +
013302100121     C                             %trim(%editw(effout: '  /  /    '))   + csv +
013303100310     C                             %trim(%editc(mcout:'N'))              + csv +
013900100219     C                             %trim(%editc(baout:'N'))              + csv +
014400100219     C                             %trim(%editc(payout1:'N'))            + csv +
014401100219     C                             %trim(%editc(payout2:'N'))            + csv +
014402100219     C                             %trim(%editc(payout3:'N'))            + csv +
014403100219     C                             %trim(%editc(payout4:'N'))            + csv +
014404100219     C                             %trim(%editc(payout5:'N'))            + csv +
014405100308     C                             %trim(%editc(payouttot:'N'))          + csv +
014406100308     C                             %trim(%editc(baldueout:'N'))          + '",'
016100051024
016200100201     C                   Write     rpa023xr
0163000510240320 C                   ENDSR
016400051024     C*
016500051024     C*************************************************************
016600051024     C*                                                           *
016700051024     C* Write Spreadsheet heading                                 *
016800051024     C*                                                           *
016900051024     C*************************************************************
017000051024     C     Writexlhead   BEGSR
017100051024
017200100201     c                   clear                   rpa023xfld
017300100201     C                   Eval      rpa023xfld =                   '"' +
017400100121     C                             'BILL CYCLE'                         + csv +
017401100121     C                             'INV #'                              + csv +
017402100202     C                             'COBRA INCLUDED'                     + csv +
017403100121     C                             'ACCT #'                             + csv +
017404100121     C                             'ACCT NAME'                          + csv +
017405100121     C                             'GROUP #'                            + csv +
017406100122     C                             'COVERAGE MONTH'                     + csv +
017407100310     C                             'MEDICAL CNT'                        + csv +
017408100121     C                             'BILL + ADJ'                         + csv +
018008100121     C                             'PAYMENT SEQ 1'                      + csv +
018009100121     C                             'PAYMENT SEQ 2'                      + csv +
018010100122     C                             'PAYMENT SEQ 3'                      + csv +
018011100204     C                             'PAYMENT SEQ OTHER'                  + csv +
018012100309     C                             'APPROVED ADJ/TAB4'                  + csv +
018013100308     C                             'TOTAL PAID'                         + csv +
018014100309     C                             'RUNNING BALANCE'                    + '",'
018700100201     C                   Write     rpa023xr
018800051024     C*
0189000510240320 C                   ENDSR
0190000510240103 C***************************************************
0191000510240104 C* FIRST CYCLE                                     *
0192000510240105 C***************************************************
0193000510240106 C     *INZSR        BEGSR
019421100121
019500051024     C                   Exsr      Writexlhead
019600051024
020400051024     C                   endsr
