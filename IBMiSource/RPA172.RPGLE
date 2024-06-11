000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Salesman Agency Override Report - Step 2
000400000000      *
000500000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - February 01, 2001
000800030618      *  agency override project
000900030703      * 07/03/03 dlk - add agency and SA description
000901050902      * 09/02/05 dlk - fix date in heading
000902110630      * 06/29/11 dlk - add effdt, com rate, com method, prem split,
000903110630      *                override method, override rate
000904110630      *                to L1 break and print on L1 so this report
000905110629      *                matches the main salesman report (RPA163) in that it
000906110629      *                will not print duplicate lines with the same effdt.
001000000000      *_________________________________________________________________________
001100030416     FRPA171WK  IP   E             DISK
001200030703     Fagency    If   E           k DISK
001300030703     Fsupragcy  If   E           k DISK
001400010201     FRPA172P   O    E             Printer oflind(*IN91)
001500030416   X***X
001600010227     D Elements        s              3  0 inz
001700010227
001800010227     D                 DS                           inz
0019000102270032 D ary                           77    Dim(200)                             carrier array
0020000102270032 D Car                            3    Overlay(ary)                         carrier array
0021000102270032 D cad                           40    Overlay(ary:*Next)                   carrier desc array
0022000102270032 D nbr                            7  2 Overlay(ary:*Next)                   members array
0023000102270032 D pre                            9  2 Overlay(ary:*Next)                   prem array
0024000102270032 D com                            9  2 Overlay(ary:*Next)                   comm array
0025000102270032 D ovr                            9  2 Overlay(ary:*Next)                   comm array
002600010227
002700010227     D                 DS                           inz
0028000102270032 D arya                          77    Dim(200)                             carrier array
0029000102270032 D Cara                           3    Overlay(arya)                        carrier array
0030000102270032 D cada                          40    Overlay(arya:*Next)                  carrier desc array
0031000102270032 D nbra                           7  2 Overlay(arya:*Next)                  members array
0032000102270032 D prea                           9  2 Overlay(arya:*Next)                  prem array
0033000102270032 D coma                           9  2 Overlay(arya:*Next)                  comm array
0034000102270032 D ovra                           9  2 Overlay(arya:*Next)                  comm array
003500030416
003600030416     D                 DS                           inz
0037000304160032 D aryS                          77    Dim(200)                             carrier array
0038000304160032 D CarS                           3    Overlay(aryS)                        carrier array
0039000304160032 D cadS                          40    Overlay(aryS:*Next)                  carrier desc array
0040000304160032 D nbrS                           7  2 Overlay(aryS:*Next)                  members array
0041000304160032 D preS                           9  2 Overlay(aryS:*Next)                  prem array
0042000304160032 D comS                           9  2 Overlay(aryS:*Next)                  comm array
0043000304160032 D ovrS                           9  2 Overlay(aryS:*Next)                  comm array
004400010227
004500010227     D                 DS                           inz
0046000102270032 D aryf                          77    Dim(200)                             carrier array
0047000102270032 D Carf                           3    Overlay(aryf)                        carrier array
0048000102270032 D cadf                          40    Overlay(aryf:*Next)                  carrier desc array
0049000102270032 D nbrf                           7  2 Overlay(aryf:*Next)                  members array
0050000102270032 D pref                           9  2 Overlay(aryf:*Next)                  prem array
0051000102270032 D comf                           9  2 Overlay(aryf:*Next)                  comm array
0052000102270032 D ovrf                           9  2 Overlay(aryf:*Next)                  comm array
005300010204
005400010201     D                UDS
005401050902     D  ldateymd               4     11  0
005402050902     D  ldatey                 4      7  0
005403050902     D  ldatemd                8     11  0
005500010201     D  CMPNAM               201    240
005600030416   X***X
005700030416     IRPA170R       01
005701110629     I                                          RPSUPER       L8
005800010201     I                                          RPCCDE        L7
005900010201     I                                          RPSMCD        L6
006000010201     I                                          RPTRST        L5
006100010201gsp  I                                          RPSUB         L4
006200010201     I                                          RPACC         L4
006300010201gsp  I                                          RPGRP         L3
006400010201     I                                          RPPLAN        L2
006401110629     I                                          RPefdt        L1
006402110630     I                                          RPcmrt        L1
006403110630     I                                          RPmthd        L1
006404110630     I                                          RPpspl        L1
006405110630     I                                          RPaomthd      L1
006406110630     I                                          RPaorate      L1
006600030703      * get super agency name
006700030703     c                   if        *inl8
006800030703     c                   clear                   saname1out
006900030703     c     rpsuper       chain     supragcy
007000030703     c                   if        %found(supragcy)
007100030703     c                   movel     saname1       saname1out
007200030703     c                   end
007300030703     c                   end
007400030703
007500030703      * get agency name
007600030703     c                   if        *inl7
007700030703     c                   clear                   agnam1out
007800030703     c     rpccde        chain     agency
007900030703     c                   if        %found(agency)
008000030703     c                   movel     agnam1        agnam1out
008100030703     c                   end
008200030703     c                   end
008300030703
008400010204     C   L6              Exsr      SalesmanBreak
008500010201     C   L4              Exsr      AccountBreak
008501110629     C   L1              Exsr      clearl1
008502110629
008503110629      * accululate totals
008504110629     C                   Exsr      accumulatedet
008505110629
008701110629      * print l1 totals
008702110629     Cl1                 Exsr      CheckOverflow
008703110629     Cl1                 Exsr      printl1
008704110629
008800010201     CL4                 Exsr      AccountTotal
008900010201     CL5                 Exsr      TrustTotal
009000010201     CL6                 Exsr      SalesmanTotal
009100010204     CL7                 Exsr      AgencyTotal
009200030416     CL8                 Exsr      SUPERTotal
009300030416    ***
009400010204     CLR                 Exsr      FinalTotal
009401110629
009402110629      *********************************
009403110629      * clear l1 totals
009404110629      *********************************
009405110629     C     clearl1       BEGSR
009406110629     c                   clear                   l1mcnt
009407110629     c                   clear                   l1prem
009408110629     c                   clear                   l1com
009409110629     c                   clear                   l1agovr
009410110629     C                   ENDSR
009411110629
009412110629      *********************************
009413110629      * Accumulate every record
009414110629      *********************************
009415110629     C     accumulatedet BEGSR
009416110629     c                   add       rpmcnt        l1mcnt
009417110629     c                   add       rppprm        l1prem
009418110629     c                   add       rppcom        l1com
009419110629     c                   add       WAGOVR        l1agovr
009420110629     C                   ENDSR
009500010201      *___________________________________________________________________
009600010201      * Salesman Break
009700010201      *___________________________________________________________________
009800010201     C     SalesmanBreak BEGSR
009900010201     C                   Move      *on           *In91
010000010201     C                   Exsr      CheckOverflow
010100010201     C                   ENDSR
010200010201      *___________________________________________________________________
010300010201      * Account Break
010400010201      *___________________________________________________________________
010500010201     C     AccountBreak  BEGSR
010600010201     C                   Exsr      CheckOverflow
010700010201     C                   Write     PRTACH
010800010201     C                   ENDSR
010900010201      *___________________________________________________________________
011000110629      * Print Detail at l1 time
011100010201      *___________________________________________________________________
011200110629     C     Printl1       BEGSR
011201110630
011202110630      * if all 4 of these l1 fields net to zero then do not print the line
011204110630     c                   if        l1mcnt = 0 and l1prem  = 0 and
011205110630     c                             l1com  = 0 and l1agovr = 0
011206110630     c                   leavesr
011207110630     c                   end
011209110630
011300010201     C                   Exsr      CheckOverflow
011400010201     C     RPEFDT        Mult      10000.0001    WPEFDT
011500010201     C                   Movel     RPPDSC        WPPDSC
011504110614
012100010201     C                   Write     PRTDTL
012200110629     C                   Exsr      Accuml1
012300010201     C                   ENDSR
012400010201      *___________________________________________________________________
012500010201      * Accumulate Detail
012600010201      *___________________________________________________________________
012700110629     C     Accuml1       BEGSR
012800110629     C                   Eval      W1MCNT   =    W1MCNT + l1mcnt
012900110629     C                   Eval      W1PPRM   =    W1PPRM + l1prem
013000110629     C                   Eval      W1PCOM   =    W1PCOM + l1com
013100110629     C                   Eval      W1AMT    =    W1AMT  + l1agovr
013200110629     C                   Eval      W2MCNT   =    W2MCNT + l1mcnt
013300110629     C                   Eval      W2PPRM   =    W2PPRM + l1prem
013400110629     C                   Eval      W2PCOM   =    W2PCOM + l1com
013500110629     C                   Eval      W2AMT    =    W2AMT  + l1AGOVR
013600110629     C                   Eval      W3MCNT   =    W3MCNT + l1mcnt
013700110629     C                   Eval      W3PPRM   =    W3PPRM + l1prem
013800110629     C                   Eval      W3PCOM   =    W3PCOM + l1com
013900110629     C                   Eval      W3AMT    =    W3AMT  + l1AGOVR
014000010201      *
014100010204      * Salesman Break
014200010201     C                   z-add     1             pos               3 0
014300010201     C     RPPCAR        Lookup    car(pos)                               80
014400010201     C                   If        %Equal
014500110629     C                   Eval      nbr(pos) =    nbr(pos) + l1mcnt
014600110629     C                   Eval      pre(pos) =    pre(pos) + l1prem
014700110629     C                   Eval      com(pos) =    com(pos) + l1com
014800110629     C                   Eval      ovr(pos) =    ovr(pos) + l1AGOVR
014900010201     C                   Else
015000010201     C                   Eval      Pos      =    Last + 1
015100010201     C                   Eval      car(pos) =    RPPCAR
015200010201     C                   Eval      cad(pos) =    RPCNAM
015300110629     C                   Eval      nbr(pos) =    nbr(pos) + l1mcnt
015400110629     C                   Eval      pre(pos) =    pre(pos) + l1prem
015500110629     C                   Eval      com(pos) =    com(pos) + l1com
015600110629     C                   Eval      ovr(pos) =    ovr(pos) + l1AGOVR
015700010201     C                   Z-add     Pos           Last              3 0
015800010201     C                   End
015900010204      *
016000010204      * Agency Break
016100010204     C                   z-add     1             pos               3 0
016200010204     C     RPPCAR        Lookup    cara(pos)                              80
016300010204     C                   If        %Equal
016400110629     C                   Eval      nbra(pos) =   nbra(pos) + l1mcnt
016500110629     C                   Eval      prea(pos) =   prea(pos) + l1prem
016600110629     C                   Eval      coma(pos) =   coma(pos) + l1com
016700110629     C                   Eval      ovra(pos) =   ovra(pos) + l1AGOVR
016800010204     C                   Else
016900010204     C                   Eval      Pos      =    Lasta + 1
017000010204     C                   Eval      cara(pos) =    RPPCAR
017100010204     C                   Eval      cada(pos) =    RPCNAM
017200110629     C                   Eval      nbra(pos) =    nbra(pos) + l1mcnt
017300110629     C                   Eval      prea(pos) =    prea(pos) + l1prem
017400110629     C                   Eval      coma(pos) =    coma(pos) + l1com
017500110629     C                   Eval      ovra(pos) =    ovra(pos) + l1AGOVR
017600010204     C                   Z-add     Pos           Lasta             3 0
017700010204     C                   End
017800010204      *
017900030416      * SUPER Break
018000030416     C                   z-add     1             pos               3 0
018100030416     C     RPPCAR        Lookup    carS(pos)                              80
018200030416     C                   If        %Equal
018300110629     C                   Eval      nbrS(pos) =   nbrS(pos) + l1mcnt
018400110629     C                   Eval      preS(pos) =   preS(pos) + l1prem
018500110629     C                   Eval      comS(pos) =   comS(pos) + l1com
018600110629     C                   Eval      ovrS(pos) =   ovrS(pos) + l1AGOVR
018700030416     C                   Else
018800030416     C                   Eval      Pos      =    LastS + 1
018900030416     C                   Eval      carS(pos) =    RPPCAR
019000030416     C                   Eval      cadS(pos) =    RPCNAM
019100110629     C                   Eval      nbrS(pos) =    nbrS(pos) + l1mcnt
019200110629     C                   Eval      preS(pos) =    preS(pos) + l1prem
019300110629     C                   Eval      comS(pos) =    comS(pos) + l1com
019400110629     C                   Eval      ovrS(pos) =    ovrS(pos) + l1AGOVR
019500030416     C                   Z-add     Pos           LastS             3 0
019600030416     C                   End
019700030416      *
019800010204      * Final Totals
019900010204     C                   z-add     1             pos               3 0
020000010204     C     RPPCAR        Lookup    carf(pos)                              80
020100010204     C                   If        %Equal
020200110629     C                   Eval      nbrf(pos) =   nbrf(pos) + l1mcnt
020300110629     C                   Eval      pref(pos) =   pref(pos) + l1prem
020400110629     C                   Eval      comf(pos) =   comf(pos) + l1com
020500110629     C                   Eval      ovrf(pos) =   ovrf(pos) + l1AGOVR
020600010204     C                   Else
020700010204     C                   Eval      Pos      =    Lastf + 1
020800010204     C                   Eval      carf(pos) =    RPPCAR
020900010204     C                   Eval      cadf(pos) =    RPCNAM
021000110629     C                   Eval      nbrf(pos) =    nbrf(pos) + l1mcnt
021100110629     C                   Eval      pref(pos) =    pref(pos) + l1prem
021200110629     C                   Eval      comf(pos) =    comf(pos) + l1com
021300110629     C                   Eval      ovrf(pos) =    ovrf(pos) + l1AGOVR
021400010204     C                   Z-add     Pos           Lastf             3 0
021500010204     C                   End
021600010201      *
021700010201     C                   ENDSR
021800010201      *___________________________________________________________________
021900010201      * Account Total
022000010201      *___________________________________________________________________
022100010201     C     AccountTotal  BEGSR
022200010201     C                   If        *In91    =   *On
022300010201     C                   Exsr      CheckOverflow
022400010201     C                   Write     PRTACH
022500010201     C                   Endif
022600010201     C                   Write     PRTDAT
022700010201     C                   Eval      W1MCNT   =    0
022800010201     C                   Eval      W1PPRM   =    0
022900010201     C                   Eval      W1PCOM   =    0
023000010201     C                   Eval      W1AMT    =    0
023100010201     C                   ENDSR
023200010201      *___________________________________________________________________
023300010201      * Trust Total
023400010201      *___________________________________________________________________
023500010201     C     TrustTotal    BEGSR
023600010201     C                   Exsr      CheckOverflow
023700010201     C                   Write     PRTDTT
023800010201     C                   Eval      W2MCNT   =    0
023900010201     C                   Eval      W2PPRM   =    0
024000010201     C                   Eval      W2PCOM   =    0
024100010201     C                   Eval      W2AMT    =    0
024200010201     C                   ENDSR
024300010201      *___________________________________________________________________
024400010201      * Salesman Total
024500010201      *___________________________________________________________________
024600010201     C     SalesmanTotal BEGSR
024700010201     C                   Exsr      CheckOverflow
024800010201     C                   Write     PRTDST
024900010201     C                   Eval      W3MCNT   =    0
025000010201     C                   Eval      W3PPRM   =    0
025100010201     C                   Eval      W3PCOM   =    0
025200010201     C                   Eval      W3AMT    =    0
025300010201     C                   Move      *on           *In91
025400010201     C                   Exsr      CheckOverflow
025500010201     C                   Write     PRTSBC
025600010227     C                   sorta     ary
025700010227     C                   Eval      Elements =    %elem(ary)
025800010227     C                   Do        Elements      pos
025900010201     C                   Eval      W4CARR   =    car(pos)
026000010201     C                   Eval      W4CNAM   =    cad(pos)
026100010201     C                   z-add     nbr(pos)      W4MCNT
026200010201     C                   z-add     pre(pos)      W4PPRM
026300010201     C                   z-add     com(pos)      W4PCOM
026400010201     C                   z-add     ovr(pos)      W4AMT
026500010227     C                   If        car(pos) <> *Blanks
026600010201     C                   Write     PRTSBD
026700010227     C                   End
026800010201     C                   Eval      W5MCNT   =    W5MCNT + W4MCNT
026900010201     C                   Eval      W5PPRM   =    W5PPRM + W4PPRM
027000010201     C                   Eval      W5PCOM   =    W5PCOM + W4PCOM
027100010201     C                   Eval      W5AMT    =    W5AMT  + W4AMT
027200010201     C                   Enddo
027300010201     C                   Write     PRTSBT
027400010201     C                   Eval      W4MCNT   =    0
027500010201     C                   Eval      W4PPRM   =    0
027600010201     C                   Eval      W4PCOM   =    0
027700010201     C                   Eval      W4AMT    =    0
027800010201     C                   Eval      W5MCNT   =    0
027900010201     C                   Eval      W5PPRM   =    0
028000010201     C                   Eval      W5PCOM   =    0
028100010201     C                   Eval      W5AMT    =    0
028200010201     C                   Eval      Last     =    0
028300010201     C                   Clear                   car
028400010201     C                   Clear                   cad
028500010201     C                   Clear                   nbr
028600010201     C                   Clear                   pre
028700010201     C                   Clear                   com
028800010201     C                   Clear                   ovr
028900010201     C                   ENDSR
029000010204      *___________________________________________________________________
029100010204      * Agency Total
029200010204      *___________________________________________________________________
029300010204     C     AgencyTotal   BEGSR
029400010204     C                   Move      *on           *In91
029500010204     C                   Exsr      CheckOverflow
029600010204     C                   Write     PRTSBCA
029700010227     C                   sorta     arya
029800010227     C                   Eval      Elements =    %elem(arya)
029900010227     C                   Do        Elements      pos
030000010204     C                   Eval      W6CARR   =    cara(pos)
030100010204     C                   Eval      W6CNAM   =    cada(pos)
030200010204     C                   z-add     nbra(pos)     W6MCNT
030300010204     C                   z-add     prea(pos)     W6PPRM
030400010204     C                   z-add     coma(pos)     W6PCOM
030500010204     C                   z-add     ovra(pos)     W6AMT
030600010227     C                   If        cara(pos) <> *Blanks
030700010204     C                   Write     PRTSBDA
030800010227     C                   End
030900010204     C                   Eval      W7MCNT   =    W7MCNT + W6MCNT
031000010204     C                   Eval      W7PPRM   =    W7PPRM + W6PPRM
031100010204     C                   Eval      W7PCOM   =    W7PCOM + W6PCOM
031200010204     C                   Eval      W7AMT    =    W7AMT  + W6AMT
031300010204     C                   Enddo
031400010204     C                   Write     PRTSBTA
031500010204     C                   Eval      W6MCNT   =    0
031600010204     C                   Eval      W6PPRM   =    0
031700010204     C                   Eval      W6PCOM   =    0
031800010204     C                   Eval      W6AMT    =    0
031900010204     C                   Eval      W7MCNT   =    0
032000010204     C                   Eval      W7PPRM   =    0
032100010204     C                   Eval      W7PCOM   =    0
032200010204     C                   Eval      W7AMT    =    0
032300010204     C                   Eval      Lasta    =    0
032400010204     C                   Clear                   cara
032500010204     C                   Clear                   cada
032600010204     C                   Clear                   nbra
032700010204     C                   Clear                   prea
032800010204     C                   Clear                   coma
032900010204     C                   Clear                   ovra
033000010204     C                   ENDSR
033100030416      *___________________________________________________________________
033200030416      * SUPER Total
033300030416      *___________________________________________________________________
033400030416     C     SUPERTotal    BEGSR
033500030416     C                   Move      *on           *In91
033600030416     C                   Exsr      CheckOverflow
033700030416     C                   Write     PRTSBCS
033800030416     C                   sorta     aryS
033900030416     C                   Eval      Elements =    %elem(aryS)
034000030416     C                   Do        Elements      pos
034100030416     C                   Eval      W6CARR   =    carS(pos)
034200030416     C                   Eval      W6CNAM   =    cadS(pos)
034300030416     C                   z-add     nbrS(pos)     W6MCNT
034400030416     C                   z-add     preS(pos)     W6PPRM
034500030416     C                   z-add     comS(pos)     W6PCOM
034600030416     C                   z-add     ovrS(pos)     W6AMT
034700030416     C                   If        carS(pos) <> *Blanks
034800030416     C                   Write     PRTSBDS
034900030416     C                   End
035000030416     C                   Eval      W7MCNT   =    W7MCNT + W6MCNT
035100030416     C                   Eval      W7PPRM   =    W7PPRM + W6PPRM
035200030416     C                   Eval      W7PCOM   =    W7PCOM + W6PCOM
035300030416     C                   Eval      W7AMT    =    W7AMT  + W6AMT
035400030416     C                   Enddo
035500030416     C                   Write     PRTSBTS
035600030416     C                   Eval      W6MCNT   =    0
035700030416     C                   Eval      W6PPRM   =    0
035800030416     C                   Eval      W6PCOM   =    0
035900030416     C                   Eval      W6AMT    =    0
036000030416     C                   Eval      W7MCNT   =    0
036100030416     C                   Eval      W7PPRM   =    0
036200030416     C                   Eval      W7PCOM   =    0
036300030416     C                   Eval      W7AMT    =    0
036400030416     C                   Eval      LastS    =    0
036500030416     C                   Clear                   carS
036600030416     C                   Clear                   cadS
036700030416     C                   Clear                   nbrS
036800030416     C                   Clear                   preS
036900030416     C                   Clear                   comS
037000030416     C                   Clear                   ovrS
037100030416     C                   ENDSR
037200010204      *___________________________________________________________________
037300010204      * Final Total
037400010204      *___________________________________________________________________
037500010204     C     FinalTotal    BEGSR
037600010204     C                   Move      *on           *In91
037700010204     C                   Exsr      CheckOverflow
037800010204     C                   Write     PRTSBCF
037900010227     C                   sorta     aryf
038000010227     C                   Eval      Elements =    %elem(aryf)
038100010227     C                   Do        Elements      pos
038200010204     C                   Eval      W8CARR   =    carf(pos)
038300010204     C                   Eval      W8CNAM   =    cadf(pos)
038400010204     C                   z-add     nbrf(pos)     W8MCNT
038500010204     C                   z-add     pref(pos)     W8PPRM
038600010204     C                   z-add     comf(pos)     W8PCOM
038700010204     C                   z-add     ovrf(pos)     W8AMT
038800010227     C                   If        carf(pos) <> *Blanks
038900010204     C                   Write     PRTSBDF
039000010227     C                   End
039100010204     C                   Eval      W9MCNT   =    W9MCNT + W8MCNT
039200010204     C                   Eval      W9PPRM   =    W9PPRM + W8PPRM
039300010204     C                   Eval      W9PCOM   =    W9PCOM + W8PCOM
039400010204     C                   Eval      W9AMT    =    W9AMT  + W8AMT
039500010204     C                   Enddo
039600010204     C                   Write     PRTSBTF
039700010204     C                   Eval      W8MCNT   =    0
039800010204     C                   Eval      W8PPRM   =    0
039900010204     C                   Eval      W8PCOM   =    0
040000010204     C                   Eval      W8AMT    =    0
040100010204     C                   Eval      W9MCNT   =    0
040200010204     C                   Eval      W9PPRM   =    0
040300010204     C                   Eval      W9PCOM   =    0
040400010204     C                   Eval      W9AMT    =    0
040500010204     C                   Eval      Lastf    =    0
040600010204     C                   Clear                   carf
040700010204     C                   Clear                   cadf
040800010204     C                   Clear                   nbrf
040900010204     C                   Clear                   pref
041000010204     C                   Clear                   comf
041100010204     C                   Clear                   ovrf
041200010204     C                   ENDSR
041300010201      *___________________________________________________________________
041400000000      * Key Lists
041500000000      *___________________________________________________________________
041600000000     C     KLIST         BEGSR
041700000000     C                   ENDSR
041800010201      *___________________________________________________________________
041900010201      * Check Overflow - Print Header
042000010201      *___________________________________________________________________
042100010201     C     CheckOverflow BEGSR
042200010201     C                   If        *in91  = *on
042400010201     C                   Write     PRTHDR
042500010201     C                   Move      *off          *In91
042600010201     C                   End
042700010201     C                   ENDSR
042800010201      *___________________________________________________________________
042900010201      * Program Open
043000010201      *___________________________________________________________________
043100010201     C     *INZSR        BEGSR
043101050902     c                   movel     ldatemd       comprd
043102050902     c                   move      ldatey        comprd
043200010201     C                   Move      *on           *In91
043300010201     C                   ENDSR
