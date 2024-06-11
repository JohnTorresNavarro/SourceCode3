0001000509130002 F******************************************************************
0002001301230003 F* rpa990     GROUP BENEFIT SERVICES, INC.                        *
0003000509130004 F*                                                                *
0004000509130005 F*            WRITTEN BY - David Ketterman                        *
0005001301230006 F*            DATE - 01/23/13                                     *
0006000509130007 F*                                                                *
000700050913     F*
0008001301230008 F*  DESCRIPTION - THIS PROGRAM WILL CREATE THE ADMIN PORTION OF   *
0009001301230009 F*                THE COMBINED ADMIN & GA COMMISSION FILE.        *
0010000802280015 F*                                                                *
0011002209140015 F* 09/14/22 dlk - add commission split field to l1 break and      *
0012002209140015 F*                fill it in output rec                           *
0013002209140015 F*                                                                *
0014000509130013 F******************************************************************
0015000509120005 Frpa060wk  ip   e             disk
001600130125     fsman      if   e           k disk
001700130125     fsmanrlt   if   e           k disk
001800130123     fspragxr2  if   e           k disk
001900130123     fagency    if   e           k disk
002000130123     fsupragcy  if   e           k disk
002100130123     fcarmst    if   e           k disk
002200130123     fplnmst    if   e           k disk
002300130123     fcodesl1   if   e           k disk
002400130124     faccmst    if   e           k disk
002500130129     fcomok     if   e           k disk
0026001301230005 Fcmbhs1p   o  a e             disk
002700050913
0028001301230002 D sysdatmdy       S               d   datfmt(*usa)
0029001301230002 D sysdatymd       S               d   datfmt(*iso)
003000130123     d holdsman        s                   like(C1SMAN)
003100130123     d holdsmname      s                   like(C1SMNAME)
003200130123     d holdsaname      s                   like(C1SUNAME)
003300130124     d holdsa          s                   like(sxsuper)
003400130124     d holdag          s                   like(sxagcy)
003500130123     d holdagname      s                   like(C1AGNAME)
003600130124     d holdrel         s                   like(rprelid)
003700130124     d holdcarr        s                   like(pcarr)
003800130124     d holdplan        s                   like(rpplan)
003900130124     d holdpct         s                   like(action)
004000130124     d holdefdt        s                   like(rpefdt)
004100220914     d holdpspl        s                   like(c1split)
004200130124     d holdcgrpcd      s                   like(cgrpcd)
004300130124     d holdgrp#        s                   like(rpgrp)
004400130124     d holdacname      s                   like(acnam1)
004500130124     d holdrptrst      s                   like(rptrst)
004600130124     d holdrpsub       s                   like(rpsub)
004700130124     d holdrpacc       s                   like(rpacc)
004800130125     d holdrpcpddt     s                   like(rpcpddt)
004900130129     d holdapaiddt     s                   like(c1apaiddt)
005000130124     d holdtsa         s             10  0
005100130125     d l1rppprm        s                   like(C1CMPREM)
005200130125     d l1rppcom        s                   like(C1CMAMT)
005300130125     d l1rpmcnt        s                   like(C1CMCOUNT)
005400130130     d l1rpaoamt       s                   like(C1AOVRAMT)
005500050913     d cntrpcmrt       s              7  0
005600050913     D                 DS
005700130123     D  tsa                    1     10  0
005800130123     D  rptrst                 1      3  0
005900130123     D  rpsub                  4      6  0
006000130123     D  rpacc                  7     10  0
006100050913
006200050913     irpa60r
006300130129     i                                          rpcpddt       l2
006400130123     i                                          rprelid       l1
006500130123     i                                          rptrst        l1
006600050913     i                                          rpsub         l1
006700050913     i                                          rpacc         l1
006800130123     i                                          rpgrp         l1
006900130123     i                                          rpplan        l1
007000130123     i                                          rpefdt        l1
007100220914     i                                          rppspl        l1
007200130125     i*****                                     rpseq#
007300050912
007400130129      * get actual paid date
007500130129     c                   if        *inl2
007600130129     c                   clear                   holdapaiddt
007700130129     c     rpcpddt       chain     comok
007800130129     c                   if        %found(comok)
007900130129     c                   move      COACPDT       holdapaiddt
008000130129     c                   end
008100130129     c                   end
008200130129
008300130129     c                   if        *inl1
008400130129     c                   clear                   cmbhs1r
008500130123     c                   clear                   holdrel
008600130123     c                   clear                   holdsman
008700130123     c                   clear                   holdsmname
008800130123     c                   clear                   holdag
008900130123     c                   clear                   holdagname
009000130123     c                   clear                   holdsa
009100130123     c                   clear                   holdsaname
009200130123     c                   clear                   holdrptrst
009300130123     c                   clear                   holdrpsub
009400130123     c                   clear                   holdrpacc
009500130125     c                   clear                   holdrpcpddt
009600130123     c                   clear                   holdtsa
009700130123     c                   clear                   holdacname
009800130123     c                   clear                   holdgrp#
009900130123     c                   clear                   holdcgrpcd
010000130123     c                   clear                   holdcarr
010100130123     c                   clear                   holdplan
010200130123     c                   clear                   holdpct
010300130123     c                   clear                   holdefdt
010400220914     c                   clear                   holdpspl
010500130123     c                   clear                   l1rppprm
010600130123     c                   clear                   l1rppcom
010700130123     c                   clear                   l1rpmcnt
010800130130     c                   clear                   l1rpaoamt
010900130125     c                   clear                   cntrpcmrt
011000050707     c                   end
011100010403
011200050913      * accumulate totals from commission history
011300050913
011400130123     c                   add       rpmcnt        l1rpmcnt
011500130123     c                   add       rppprm        l1rppprm
011600130123     c                   add       rppcom        l1rppcom
011700130130     c                   add       rpaoamt       l1rpaoamt
011800130123     c                   add       1             cntrpcmrt
011900050913
012000050914     cl1                 if        cntrpcmrt <> 0
012100050913     cl1                 exsr      #l1tot
012200050914     cl1                 end
012300010403
012400050913      ***********************************************************
012500130123      * At end of commission paid date/relid/t/s/a/g#/p/effdt
012600130123      * write total rec that combines all sequences
012700050913      ***********************************************************
012800050913     c     #l1tot        begsr
012900050914
013000130123     c                   move      rprelid       holdrel
013100130123     c                   exsr      #getrel
013200130123
013300130123      * get plan category type
013400130125     c     keyplan       chain     plnmst
013500130123     c                   if        %found(plnmst)
013600130123     c                   move      pcarr         holdcarr
013700130123     c     plncat        chain     codesl1
013800130123     c                   if        %found(codesl1)
013900130123     c                   move      action        holdpct
014000130123     c                   end
014100130123     c     pcarr         chain     carmst
014200130123     c                   if        %found(carmst)
014300130123     c                   move      cgrpcd        holdcgrpcd
014400130123     c                   end
014500130123     c                   end
014600130123
014700130123      * other fields
014800130125     c                   move      rpcpddt       holdrpcpddt
014900130123     c                   movel     tsa           holdtsa
015000130123     c                   move      rptrst        holdrptrst
015100130123     c                   move      rpsub         holdrpsub
015200130123     c                   move      rpacc         holdrpacc
015300130123     c                   movel     rpgrp         holdgrp#
015400130123     c                   movel     rpefdt        holdefdt
015500220915
015600220914      * convert split representation from whole number (GBS is 50.0000)
015700220914      * to decimal (GA version is .5000). Request from Mick G.
015800220915      * work file field needed to be 11.6 to hold 6 digits to the right of
015900220914      * decimal after dividing 7.4 by 100. Also becusae the GA field is
016000220914      * 9.4 it has up to 5 digits to the left of the decimal so that
016100220915      * meant 5 + 6 = a new field of 11.6
016200220915
016300220914       holdpspl = rppspl / 100;
016400220915
016500130123     c                   movel     rpplan        holdplan
016600050913
016700130123     c     keyacc        chain     accmst
016800130123     c                   if        %found(accmst)
016900130123     c                   movel     acnam1        holdacname
017000130123     c                   end
017100130123
017200130123     C                   exsr      #writefile
017300050915
017400050913     c                   endsr
017500130123
017600130123      *************************************
017700130123      * get relation info
017800130123      *************************************
017900130123     c     #getrel       begsr
018000130125
0181001301230063 C     holdrel       CHAIN     smanrlt
018200130123     c                   if        not %found(smanrlt)
018300130123     c                   leavesr
018400130123     c                   end
018500130123
018600130123    * * sman info from relation
018700130123     c                   eval      holdsman = srsman
018800130123     c     srsman        chain     sman
018900130123     c                   if        %found(sman)
019000130123     c                   eval      holdsmname = %trim(sfname)
019100130123     c                   if        smi <> ' '
019200130123     c                   cat       smi:1         holdsmname
019300130123     c                   end
019400130123     c                   cat       slname:1      holdsmname
019500130123     c                   endif
019600130123    *
019700130123      * get SA xref
019800130123     c     srasid        chain     spragxr2
019900130123     c                   if        %found(spragxr2)
020000130123     c                   eval      holdsa = sxsuper
020100130123     c                   eval      holdag = sxagcy
020200130123      * get super agency name
020300130123     c     sxsuper       chain     supragcy
020400130123     c                   if        %found(supragcy)
020500130123     c                   eval      holdsaname = %trim(saname1)
020600130123     c                   end
020700130123      * get agency name
020800130123     c     sxagcy        chain     agency
020900130123     c                   if        %found(agency)
021000130123     c                   eval      holdagname = %trim(agnam1)
021100130123     c                   end
021200130123     c                   end
021300130123
021400130123     c                   endsr
0215000509130313 C*
0216000509130164 C*************************************************************
0217000509130164 C*                                                           *
0218001301230164 C* Write to output file                                      *
0219000509130164 C*                                                           *
0220000509130164 C*************************************************************
022100130123     C     #Writefile    BEGSR
022200130125     C*
022300130129     c                   move      holdrpcpddt   C1PAIDTE
022400130129     c                   move      holdapaiddt   C1apaiddt
022500130123     c                   movel     'A'           C1ADOGA
022600130123     c                   movel     holdtsa       C1ACCOUNT
022700130123     c                   movel     holdacname    C1ACCNAME
022800130123     c                   movel     holdgrp#      C1CGN
022900130123     c                   movel     holdcgrpcd    C1CARGRP
023000130123     c                   movel     holdcarr      C1PRODUCT
023100130123     c                   move      holdplan      C1PLAN
023200130123     c                   movel     holdpct       C1PCAT
023300130125
023400130129     c                   move      holdefdt      C1PAYEFF
023500220914     c                   move      holdpspl      C1SPLIT
023600130123     c                   move      l1rppprm      C1CMPREM
023700130123     c                   move      l1rppcom      C1CMAMT
023800130123     c                   move      l1rpmcnt      C1CMCOUNT
023900130130     c                   move      l1rpaoamt     C1AOVRAMT
024000130123     c                   clear                   C1WHPREM
024100130123     c                   clear                   C1WHAMT
024200130123     c                   clear                   C1WHCOUNT
024300130123     c                   movel     holdrel       C1RELID
024400130123     c                   movel     holdsman      C1SMAN
024500130123     c                   movel     holdsmname    C1SMNAME
024600130123     c                   movel     holdag        C1AGCY
024700130123     c                   movel     holdagname    C1AGNAME
024800130123     c                   movel     holdsa        C1SUPER
024900130123     c                   movel     holdsaname    C1SUNAME
025000130123     c                   move      holdrptrst    C1TRS#
025100130123     c                   move      holdrpsub     C1SUB#
025200130123     c                   move      holdrpacc     C1ACC#
025300130129     c                   move      udate8ymd     C1RUNDATE
025400130123     c                   move      htime         C1RUNTIME
025500050915
025600130123     C                   Write     cmbhs1r
0257000509130320 C                   ENDSR
025800130125
0259001301250103 C***************************************************
0260001301250104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0261001301250105 C***************************************************
0262001301250107 C*
0263001301250107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0264001301250107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0265001301250107 C*
0266001301250106 C     #DATYM        BEGSR
026700130125     C                   MOVE      @DATIN        @MD               4 0
026800130125     C                   MOVEL     @DATIN        @Y                4 0
026900130125     C                   MOVEL     @MD           @DATOU            8 0
027000130125     C                   MOVE      @Y            @DATOU
027100130125     C                   MOVE      *ZEROS        @DATIN            8 0
0272001301250120 C                   ENDSR
0273001301250107 C*
027400050913     C*
0275000509130103 C***************************************************
0276000509130104 C* FIRST CYCLE                                     *
0277000509130105 C***************************************************
0278000509130106 C     *INZSR        BEGSR
027900050913
028000130123      * put system date in sysdatmdy field
028100130123      /free
028200130123       sysdatmdy = %date();
028300130123       sysdatymd = %date();
028400130123      /end-free
028500130125     C                   MOVE      sysdatmdy     UDATE8mdy         8 0
028600130129     C                   MOVE      sysdatymd     udate8ymd         8 0
028700130123
028800130123     C                   TIME                    HTIME             6 0
028900050913
029000130125     c     keyacc        klist
029100050913     c                   kfld                    rptrst
029200050913     c                   kfld                    rpsub
029300050913     c                   kfld                    rpacc
029400130125
029500130125     c     keyplan       klist
029600130125     c                   kfld                    rptrst
029700130125     c                   kfld                    rpsub
029800130125     c                   kfld                    rpplan
029900130125
030000050913     C                   endsr
