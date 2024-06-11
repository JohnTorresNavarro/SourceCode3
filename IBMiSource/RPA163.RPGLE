000100000000      *_________________________________________________________________________
000200000000      *
000300010524      *  Description:  Salesman Commission Report
000400000000      *
000500000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700010524      *    Created by:  JALLEN - May 24, 2001
000800030210      *? CHANGES: LOWER TO UPPER CASE 02/10/03 TWP
000900030415      * 04/15/03 dlk - add super agency sort / break / totals above agency.
001000030415      *                This required a new input file (joined qry).
001100030625      *              - use agency from spragxrf file
001101041124      * 11/24/04 dlk - trim SA address line
001102051031      * 10/28/05 dlk - add totals for Care First medical
001103060110      * 01/10/06 dlk - change Care First contract totals to seperate prem
001104060110      *                and comm for all care first carriers used in the
001105060110      *                persistencty bonus.
001106060220      * 02/20/06 dlk - use new fields in carmst for persistency bonus
001107060220      *                carrier selection to show Care First totals at end
001108060220      *                of salesman.
001109060313      * 03/13/06 dlk - remove trust totals & fix summary when carrier is
001110060313      *                blank (manual entry w/o carrier)
001111060323      * 03/23/06 dlk - remove sman info from top of final total page
001112080207      * 02/07/08 dlk - remove note field from report - it sometimes
001113080207      *                contains info we do not want the broker to see.
001114080312      * 03/12/08 dlk - add seq# to report
001115080925      * 09/25/08 dlk - change rpa163J sort - ACH field from agency master
001116080925      *                is first, then agency, then super agency then the
001117080926      *                rest stays the same. Add text to agency mailing
001118080926      *                sheet when ach = Y. Add deposit date to prompt screen
001119080926      *                that will print when ach = Y. Add RPA163WK file
001120080926      *                that will accumulate totals by carrier for each
001121080926      *                super agency.
001122081009      * 10/09/08 dlk - add paid Y/N to report detail line
001123081009      *              - add account cancel date
001124081111      * 11/11/08 dlk - change to print at L1 total time so we summarize
001125081111      *                multiple lines & sequence numbers within the same
001126090918      *                ach/ag/sa/sm/t/s/a/g#/plan/effdt comrate mthd split.
001127090918      *                remove paid Y/N from report detail line
001128090127      * 01/27/09 dlk - add dental persistency count
001129090529      * 05/29/09 dlk - exclude senior dental trusts from rpa163j (Done in
001130090604      *                opnqryf in cl) and United Healthcare carrier.
001131101027      * 10/27/10 dlk - change to use account name from accmst instead of
001132101027      *                from rpa060wk in order to always show current name
001133101027      *                when name changed during the month.
001134110628      * 06/28/11 dlk - Remove agency tax id from the mailing sheet - Liliane
001135110628      *                request.
001136180109      * 01/09/18 dlk - Advanced mobile trusts also excluded in opnqryf in CL
001137180327      * 03/27/18 dlk - Remove Care First totals. Persistency calculations
001138180327      *                changed this year so these numbers are not valid now.
001142090127      *
001201060110      *_________________________________________________________________________
001300030415     FRPA163j   IP   E             Disk
001400010524     FAGENCY    IF   E           K Disk
001500030415     Fsupragcy  IF   E           K Disk
001502080917     Frpa163wk  uF a E           K Disk
001503081009     Faccmst    IF   E           K Disk    prefix(a_)
001600010524     FRPA163P   O    E             Printer oflind(*IN91)
001700030210
001800030210     D UP              C                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
001900030210     D LO              C                   'abcdefghijklmnopqrstuvwxyz'
002000030210     D AGNAM1_H        S                   LIKE(AGNAM1)
002100030210     D AGNAM2_H        S                   LIKE(AGNAM1)
002200030210     D AGADD1_H        S                   LIKE(AGADD1)
002300030210     D AGADD2_H        S                   LIKE(AGADD2)
002400030210     D AGCITY_H        S                   LIKE(AGCITY)
002500030210     D AGSTAT_H        S                   LIKE(AGSTAT)
002501080917     D ddtext          S                   LIKE(ddtextout)
002600030210     D WHERE           S              5S 0 INZ(*ZEROS)
002605060313     D W2MCNT          S              9s 2
002606060313     D W2PPRM          S             11s 2
002607060313     D W2PCOM          S             11s 2
002700030210     D                 DS                           inz
0028000302100032 D AGZIP5                                                                   carrier array
0029000302100032 D  AGZIP5_DS                     5    Overlay(AGZIP5)                      carrier array
003000010227
003100010227     D Elements        s              3  0 inz
003200010227
003300010227     D                 DS                           inz
0034000105240032 D ary                           68    Dim(200)                             carrier array
0035000102270032 D Car                            3    Overlay(ary)                         carrier array
0036000102270032 D cad                           40    Overlay(ary:*Next)                   carrier desc array
0037000102270032 D nbr                            7  2 Overlay(ary:*Next)                   members array
0038000102270032 D pre                            9  2 Overlay(ary:*Next)                   prem array
0039000102270032 D com                            9  2 Overlay(ary:*Next)                   comm array
004000010227
004100030416      * Agency
004200010227     D                 DS                           inz
0043000105240032 D arya                          68    Dim(200)                             carrier array
0044000102270032 D Cara                           3    Overlay(arya)                        carrier array
0045000102270032 D cada                          40    Overlay(arya:*Next)                  carrier desc array
0046000102270032 D nbra                           7  2 Overlay(arya:*Next)                  members array
0047000102270032 D prea                           9  2 Overlay(arya:*Next)                  prem array
0048000102270032 D coma                           9  2 Overlay(arya:*Next)                  comm array
004900010227
005000030416      * Super Agency
005100030416     D                 DS                           inz
0052000304160032 D arysa                         74    Dim(200)                             Super agency array
0053000304160032 D Carsa                          3    Overlay(arysa)                       carrier
0054000304160032 D cadsa                         40    Overlay(arysa:*Next)                 carrier desc
0055000304160032 D nbrsa                          9  2 Overlay(arysa:*Next)                 members
0056000304160032 D presa                         11  2 Overlay(arysa:*Next)                 prem
0057000304160032 D comsa                         11  2 Overlay(arysa:*Next)                 comm
005800030416
005900030416      * final
006000010227     D                 DS                           inz
0061000304160032 D aryf                          74    Dim(200)                             carrier array
0062000102270032 D Carf                           3    Overlay(aryf)                        carrier array
0063000102270032 D cadf                          40    Overlay(aryf:*Next)                  carrier desc array
0064000304160032 D nbrf                           9  2 Overlay(aryf:*Next)                  members array
0065000304160032 D pref                          11  2 Overlay(aryf:*Next)                  prem array
0066000304160032 D comf                          11  2 Overlay(aryf:*Next)                  comm array
006700010204
006800010201     D                UDS
006900010201     D  CMPNAM               201    240
007000010201
007100010524     IRPA60R        01
007200080916     I                                          agach         L8
007300030625     I                                          sxagcy        L7
007301080925     I                                          sxsuper       L7
007400010201     I                                          RPSMCD        L6
007500010201     I                                          RPTRST        L5
007600010201gsp  I                                          RPSUB         L4
007700010201     I                                          RPACC         L4
007800010201gsp  I                                          RPGRP         L3
007900010201     I                                          RPPLAN        L2
007901081111     I                                          RPEFDT        L1
007902081112     I                                          RPCMRT        L1
007903081112     I                                          RPMTHD        L1
007904081112     I                                          RPPSPL        L1
008000010201      *
008001060313     c                   if        rppcar = *blanks
008002060313     c                   eval      rppcar = '!!!'
008003060313     c                   end
008004060313
008100080916     C*  L8              Exsr      superagbreak
008200030415     C   L7              Exsr      AgencyBreak
008300010524     C   L6              Exsr      SalesmanBreak
008400010201     C   L4              Exsr      AccountBreak
008401081112     C   L1              Exsr      clearl1
008402081112      * accululate totals
008403081112     C                   Exsr      accumulatedet
008404081111
008405081111      * print l1 totals
008500081111     Cl1                 Exsr      CheckOverflow
008600081112     Cl1                 Exsr      printl1
008601081111
008700010201     CL4                 Exsr      AccountTotal
008800060313     CL5                 Exsr      TrustTotal
008900010201     CL6                 Exsr      SalesmanTotal
009000010204     CL7                 Exsr      AgencyTotal
009100080916     C*8                 Exsr      superagtotal
009200010204     CLR                 Exsr      FinalTotal
009201081112
009400081112      *********************************
009401081112      * clear l1 totals
009402081112      *********************************
009600081112     C     clearl1       BEGSR
009701081112     c                   clear                   l1mcnt
009702081112     c                   clear                   l1prem
009703081112     c                   clear                   l1com
010900081112     C                   ENDSR
010901081112
010902081112      *********************************
010903081112      * Accumulate every record
010904081112      *********************************
010905081112     C     accumulatedet BEGSR
010906081112     c                   add       rpmcnt        l1mcnt
010907081112     c                   add       rppprm        l1prem
010908081112     c                   add       rppcom        l1com
010909081112     C                   ENDSR
011000010524      *___________________________________________________________________
011001081112      *___________________________________________________________________
011002081112      * Super Agency Break
011003081112      *___________________________________________________________________
011004081112     C*    superagbreak  BEGSR
011005081112     c*                  clear                   saname1
011006081112     c*                  clear                   saname2
011007081112     c*                  clear                   saadd1
011008081112     c*                  clear                   saadd2
011009081112     c*                  clear                   sacsz
011010081112     C*    sxsuper       Chain     supragcy
011011081112     C*                  If        %found(supragcy)
011012081112     c*                  eval      sacsz = %trim(sacity) + '  ' +
011013081112     c*                            sastate + '  ' + sazip
011014081112     C*                  END
011015081112     C*                  Write     prtsuper
011016081112      *
011017081112     C*                  ENDSR
011018081112      *___________________________________________________________________
011100030415      *___________________________________________________________________
011200030415      * Agency Break
011300030415      *___________________________________________________________________
011400030415     C     AgencyBreak   BEGSR
011500030625     C     sxagcy        Chain     AGENCY
011600030415     C                   If        %Found
011700030415      *? LOWER TO UPPER CASE *******************************************
011800030415     C     LO:UP         XLATE     AGNAM1        AGNAM1_H
011900030415     C                   EVAL      AGNAM1      = AGNAM1_H
012000030415     C     LO:UP         XLATE     AGNAM2        AGNAM2_H
012100030415     C                   EVAL      AGNAM2      = AGNAM2_H
012200030415     C     LO:UP         XLATE     AGADD1        AGADD1_H
012300030415     C                   EVAL      AGADD1      = AGADD1_H
012400030415     C     LO:UP         XLATE     AGADD2        AGADD2_H
012500030415     C                   EVAL      AGADD2      = AGADD2_H
012600030415     C     LO:UP         XLATE     AGCITY        AGCITY_H
012700030415     C                   EVAL      AGCITY      = AGCITY_H
012800030415     C     LO:UP         XLATE     AGSTAT        AGSTAT_H
012900030415     C                   EVAL      AGSTAT      = AGSTAT_H
013000030415     C                   MOVEL     AGCITY        CITY_STAT
013100030415     C                   EVAL      WHERE = %SCAN(',':CITY_STAT)
013200030415     C                   IF        WHERE  = *ZEROS
013300030415     C     CITY_STAT     CAT(P)    ',':0         CITY_STAT
013400030415     C                   END
013500030415     C     CITY_STAT     CAT(P)    AGSTAT:1      CITY_STAT
013600030415     C     CITY_STAT     CAT(P)    AGZIP5_DS:2   CITY_STAT
013700030415     C                   IF        AGADD2    = *BLANKS
013800030415     C                   EVAL      AGADD2 = CITY_STAT
013900030415     C                   EVAL      CITY_STAT = *BLANKS
014000030415     C                   END
014100030415     C                   IF        AGADD1    = *BLANKS
014200030415     C                   EVAL      AGADD1 = AGADD2
014300030415     C                   EVAL      AGADD2    = CITY_STAT
014400030415     C                   EVAL      CITY_STAT = *BLANKS
014500030415     C                   END
014600030415     C                   IF        AGNAM2    = *BLANKS
014700030415     C                   EVAL      AGNAM2 = AGADD1
014800030415     C                   EVAL      AGADD1    = AGADD2
014900030415     C                   EVAL      AGADD2    = CITY_STAT
015000030415     C                   EVAL      CITY_STAT = *BLANKS
015100030415     C                   END
015200030415
015201080917      * set direct deposit text
015202080917     c                   clear                   ddtextout
015203080917     c                   if        agach = 'Y'
015204080917     c                   eval      ddtextout = ddtext
015205080917     c                   end
015206080917
015400030415     C                   Write     PRTMAIL
015401080917     c                   clear                   ddtextout
015500030415     C                   End
015600030415     C                   ENDSR
015700010524      * Salesman Break
015800010524      *___________________________________________________________________
015900010524     C     SalesmanBreak BEGSR
016000010524     C                   Eval      wslsmn = %trim(RPSFNM) +
016100010524     C                             ' ' + %Trim(RPSLNM)
016200010201     C                   Move      *on           *In91
016300010201     C                   Exsr      CheckOverflow
016400010201     C                   ENDSR
016500010201      *___________________________________________________________________
016600010201      * Account Break
016700010201      *___________________________________________________________________
016800010201     C     AccountBreak  BEGSR
016801081009
016802081009     c                   clear                   actcantxt
016803101027     C                   clear                   anameout
016804081009     c     acckey        chain     accmst
016805101027     c                   if        %found(accmst)
016806101027     C                   MOVEl     a_acnam1      anameout
016807101027     c                   if        a_atrmdt <> 0
016808081009     C                   MOVE      a_atrmdt      @DATIN
016809081009     C                   EXSR      #DATYM
016810081009     C                   MOVE      @DATOU        atrmmdy           8 0
016811081009     c                   eval      actcantxt = 'CANCEL DATE = ' +
016812081009     c                             %editc(atrmmdy:'Y')
016813101027     c                   end
016814101027     c                   end
016815081009
016900010201     C                   Exsr      CheckOverflow
017000010201     C                   Write     PRTACH
017100010201     C                   ENDSR
017200010201      *___________________________________________________________________
017300081112      * Print L1 Totals
017400010201      *___________________________________________________________________
017500081112     C     printl1       BEGSR
017600010201     C                   Exsr      CheckOverflow
017700010201     C     RPEFDT        Mult      10000.0001    WPEFDT
017800010201     C                   Movel     RPPDSC        WPPDSC
017900081112     C                   Write     PRTL1
018300081112     C                   Exsr      Accumulatel1
018400010201     C                   ENDSR
018500010201      *___________________________________________________________________
018600081112      * Accumulate L1 totals
018700010201      *___________________________________________________________________
018800081112     C     Accumulatel1  BEGSR
018900081112     C                   Eval      W1MCNT   =    W1MCNT + l1mcnt
019000081112     C                   Eval      W1PPRM   =    W1PPRM + l1prem
019100081112     C                   Eval      W1PCOM   =    W1PCOM + l1com
019200081112     C                   Eval      W2MCNT   =    W2MCNT + l1mcnt
019300081112     C                   Eval      W2PPRM   =    W2PPRM + l1prem
019400081112     C                   Eval      W2PCOM   =    W2PCOM + l1com
019500081112     C                   Eval      W3MCNT   =    W3MCNT + l1mcnt
019600081112     C                   Eval      W3PPRM   =    W3PPRM + l1prem
019700081112     C                   Eval      W3PCOM   =    W3PCOM + l1com
019800010201      *
019900010204      * Salesman Break
020000010201     C                   z-add     1             pos               3 0
020100010201     C     RPPCAR        Lookup    car(pos)                               80
020200010201     C                   If        %Equal
020300081112     C                   Eval      nbr(pos) =    nbr(pos) + l1mcnt
020400081112     C                   Eval      pre(pos) =    pre(pos) + l1prem
020500081112     C                   Eval      com(pos) =    com(pos) + l1com
020600010201     C                   Else
020700010201     C                   Eval      Pos      =    Last + 1
020800010201     C                   Eval      car(pos) =    RPPCAR
020900010201     C                   Eval      cad(pos) =    RPCNAM
021000081112     C                   Eval      nbr(pos) =    nbr(pos) + l1mcnt
021100081112     C                   Eval      pre(pos) =    pre(pos) + l1prem
021200081112     C                   Eval      com(pos) =    com(pos) + l1com
021300010201     C                   Z-add     Pos           Last              3 0
021400010201     C                   End
021500030416
021600030416      * Accumulate Super Agency totals
021700080917     C*                  z-add     1             pos               3 0
021800080917     C*    rppcar        Lookup    carsa(pos)                             80
021900080917     C*                  If        %Equal
022000081112     C*                  Eval      nbrsa(pos) =   nbrsa(pos) + l1mcnt
022100081112     C*                  Eval      presa(pos) =   presa(pos) + l1prem
022200081112     C*                  Eval      comsa(pos) =   comsa(pos) + l1com
022300080917     C*                  Else
022400080917     C*                  Eval      Pos      =    Lastsa + 1
022500080917     C*                  Eval      carsa(pos) =    RPPCAR
022600080917     C*                  Eval      cadsa(pos) =    RPCNAM
022700081112     C*                  Eval      nbrsa(pos) =    l1mcnt
022800081112     C*                  Eval      presa(pos) =    l1prem
022900081112     C*                  Eval      comsa(pos) =    l1com
023000080917     C*                  Z-add     Pos           Lastsa            3 0
023100080917     C*                  End
023101080917
023102080917     ***********************
023103080917      * Accumulate Super Agency totals in workfile
023300030416      *
023301080917     c                   clear                   rpa163wr
023302080917     C     rpa163wkey    Chain     rpa163wk
023304081112     c                   add       l1mcnt        r1wmem
023305081112     c                   add       l1prem        r1wprem
023306081112     c                   add       l1com         r1wcom
023319080917
023320080917     C                   If        %found(rpa163wk)
023321080917     c                   update    rpa163wr
023322080917     c                   else
023323080917     c                   move      sxsuper       r1wsa
023324080917     c                   move      rppcar        r1wcar
023325080917     c                   movel     rpcnam        r1wcarnam
023326080917     C     sxsuper       Chain     supragcy
023327080917     C                   If        %found(supragcy)
023328080917     c                   movel     saname1       r1wsanam
023329080917     C                   END
023330080917     c                   write     rpa163wr
023331080917     C                   END
023332080917
023333080917     ***********************
023334080917
023400030416      * Agency Break
023500030416     C                   z-add     1             pos               3 0
023600030416     C     RPPCAR        Lookup    cara(pos)                              80
023700030416     C                   If        %Equal
023800081112     C                   Eval      nbra(pos) =   nbra(pos) + l1mcnt
023900081112     C                   Eval      prea(pos) =   prea(pos) + l1prem
024000081112     C                   Eval      coma(pos) =   coma(pos) + l1com
024100030416     C                   Else
024200030416     C                   Eval      Pos      =    Lasta + 1
024300030416     C                   Eval      cara(pos) =    RPPCAR
024400030416     C                   Eval      cada(pos) =    RPCNAM
024500081112     C                   Eval      nbra(pos) =    nbra(pos) + l1mcnt
024600081112     C                   Eval      prea(pos) =    prea(pos) + l1prem
024700081112     C                   Eval      coma(pos) =    coma(pos) + l1com
024800030416     C                   Z-add     Pos           Lasta             3 0
024900030416     C                   End
025000030416      *
025100010204      * Final Totals
025200010204     C                   z-add     1             pos               3 0
025300010204     C     RPPCAR        Lookup    carf(pos)                              80
025400010204     C                   If        %Equal
025500081112     C                   Eval      nbrf(pos) =   nbrf(pos) + l1mcnt
025600081112     C                   Eval      pref(pos) =   pref(pos) + l1prem
025700081112     C                   Eval      comf(pos) =   comf(pos) + l1com
025800010204     C                   Else
025900010204     C                   Eval      Pos      =    Lastf + 1
026000010204     C                   Eval      carf(pos) =    RPPCAR
026100010204     C                   Eval      cadf(pos) =    RPCNAM
026200081112     C                   Eval      nbrf(pos) =    nbrf(pos) + l1mcnt
026300081112     C                   Eval      pref(pos) =    pref(pos) + l1prem
026400081112     C                   Eval      comf(pos) =    comf(pos) + l1com
026500010204     C                   Z-add     Pos           Lastf             3 0
026600010204     C                   End
026700010201      *
026800010201     C                   ENDSR
026900010201      *___________________________________________________________________
027000010201      * Account Total
027100010201      *___________________________________________________________________
027200010201     C     AccountTotal  BEGSR
027300010201     C                   If        *In91    =   *On
027400010201     C                   Exsr      CheckOverflow
027500010201     C                   Write     PRTACH
027600010201     C                   Endif
027700010201     C                   Write     PRTDAT
027800010201     C                   Eval      W1MCNT   =    0
027900010201     C                   Eval      W1PPRM   =    0
028000010201     C                   Eval      W1PCOM   =    0
028100010201     C                   ENDSR
028200010201      *___________________________________________________________________
028300010201      * Trust Total
028400010201      *___________________________________________________________________
028500010201     C     TrustTotal    BEGSR
028600060313     C**                 Exsr      CheckOverflow
028700060313     C**                 Write     PRTDTT
028800010201     C                   Eval      W2MCNT   =    0
028900010201     C                   Eval      W2PPRM   =    0
029000010201     C                   Eval      W2PCOM   =    0
029100010201     C                   ENDSR
029200010201      *___________________________________________________________________
029300010201      * Salesman Total
029400010201      *___________________________________________________________________
029500010201     C     SalesmanTotal BEGSR
029600010201     C                   Exsr      CheckOverflow
029700010201     C                   Write     PRTDST
029800010201     C                   Eval      W3MCNT   =    0
029900010201     C                   Eval      W3PPRM   =    0
030000010201     C                   Eval      W3PCOM   =    0
030100010201     C                   Move      *on           *In91
030200010201     C                   Exsr      CheckOverflow
030300010201     C                   Write     PRTSBC
030400010227     C                   sorta     ary
030500010227     C                   Eval      Elements =    %elem(ary)
030600010227     C                   Do        Elements      pos
030700010201     C                   Eval      W4CARR   =    car(pos)
030800010201     C                   Eval      W4CNAM   =    cad(pos)
030900010201     C                   z-add     nbr(pos)      W4MCNT
031000010201     C                   z-add     pre(pos)      W4PPRM
031100010201     C                   z-add     com(pos)      W4PCOM
031101051031
031200060313     C                   If        car(pos) <> *Blanks or
031201060313     C                             cad(pos) <> *Blanks or
031202060313     C                             nbr(pos) <> *zeros  or
031203060313     C                             pre(pos) <> *zeros  or
031204060313     C                             com(pos) <> *zeros
031300010201     C                   Write     PRTSBD
031400010227     C                   End
031401051028
031500010201     C                   Eval      W5MCNT   =    W5MCNT + W4MCNT
031600010201     C                   Eval      W5PPRM   =    W5PPRM + W4PPRM
031700010201     C                   Eval      W5PCOM   =    W5PCOM + W4PCOM
031800010201     C                   Enddo
031801051031
031900010201     C                   Write     PRTSBT
032000010201     C                   Eval      W4MCNT   =    0
032100010201     C                   Eval      W4PPRM   =    0
032200010201     C                   Eval      W4PCOM   =    0
032300010201     C                   Eval      W5MCNT   =    0
032400010201     C                   Eval      W5PPRM   =    0
032500010201     C                   Eval      W5PCOM   =    0
032600010201     C                   Eval      Last     =    0
032700010201     C                   Clear                   car
032800010201     C                   Clear                   cad
032900010201     C                   Clear                   nbr
033000010201     C                   Clear                   pre
033100010201     C                   Clear                   com
033200010201     C                   ENDSR
033300010204      *___________________________________________________________________
033400010204      * Agency Total
033500010204      *___________________________________________________________________
033600010204     C     AgencyTotal   BEGSR
033700010204     C                   Move      *on           *In91
033800010204     C                   Exsr      CheckOverflow
033900010204     C                   Write     PRTSBCA
034000010227     C                   sorta     arya
034100010227     C                   Eval      Elements =    %elem(arya)
034200010227     C                   Do        Elements      pos
034300010204     C                   Eval      W6CARR   =    cara(pos)
034400010204     C                   Eval      W6CNAM   =    cada(pos)
034500010204     C                   z-add     nbra(pos)     W6MCNT
034600010204     C                   z-add     prea(pos)     W6PPRM
034700010204     C                   z-add     coma(pos)     W6PCOM
034701051031
034801060313     C                   If        cara(pos) <> *Blanks or
034802060313     C                             cada(pos) <> *Blanks or
034803060313     C                             nbra(pos) <> *zeros  or
034804060313     C                             prea(pos) <> *zeros  or
034805060313     C                             coma(pos) <> *zeros
034900010204     C                   Write     PRTSBDA
035000010227     C                   End
035001051031
035100010204     C                   Eval      W7MCNT   =    W7MCNT + W6MCNT
035200010204     C                   Eval      W7PPRM   =    W7PPRM + W6PPRM
035300010204     C                   Eval      W7PCOM   =    W7PCOM + W6PCOM
035400010204     C                   Enddo
035401051031
035500010204     C                   Write     PRTSBTA
035600010204     C                   Eval      W6MCNT   =    0
035700010204     C                   Eval      W6PPRM   =    0
035800010204     C                   Eval      W6PCOM   =    0
035900010204     C                   Eval      W7MCNT   =    0
036000010204     C                   Eval      W7PPRM   =    0
036100010204     C                   Eval      W7PCOM   =    0
036200010204     C                   Eval      Lasta    =    0
036300010204     C                   Clear                   cara
036400010204     C                   Clear                   cada
036500010204     C                   Clear                   nbra
036600010204     C                   Clear                   prea
036700010204     C                   Clear                   coma
036800010204     C                   ENDSR
036900010204      *___________________________________________________________________
037000030415      * Super Agency Total
037100030415      *___________________________________________________________________
037200080917     C*    superagtotal  BEGSR
037300030415
037400080917     C*                  Move      *on           *In91
037500080917     C*                  Exsr      CheckOverflow
037600080917     C*                  Write     prtsbcsa
037700080917     C*                  sorta     arysa
037800080917     C*                  Eval      Elements =    %elem(arysa)
037900030416
038000030416      * print each line
038100080917     C*                  Do        Elements      pos
038200080917     C*                  Eval      w10CARR   =   carsa(pos)
038300080917     C*                  Eval      w10CNAM   =   cadsa(pos)
038400080917     C*                  z-add     nbrsa(pos)    W10MCNT
038500080917     C*                  z-add     presa(pos)    W10PPRM
038600080917     C*                  z-add     comsa(pos)    W10PCOM
038601051031
038701080917     C*                  If        carsa(pos) <> *Blanks or
038702080917     C*                            cadsa(pos) <> *Blanks or
038703080917     C*                            nbrsa(pos) <> *zeros  or
038704080917     C*                            presa(pos) <> *zeros  or
038705080917     C*                            comsa(pos) <> *zeros
038800080917     C*                  Write     prtsbdsa
038900080917     C*                  End
038901051031
039000080917     C*                  add       W10MCNT       W11MCNT
039100080917     C*                  add       W10PPRM       W11PPRM
039200080917     C*                  add       W10PCOM       W11PCOM
039300080917     C*                  Enddo
039400030416
039500030416      * print total
039600080917     C*                  Write     prtsbtsa
039700080917     C*                  clear                   w10mcnt
039800080917     C*                  clear                   w10pprm
039900080917     C*                  clear                   w10pcom
040000080917     C*                  clear                   w11mcnt
040100080917     C*                  clear                   w11pprm
040200080917     C*                  clear                   w11pcom
040300080917     C*                  clear                   lastsa
040400080917     C*                  Clear                   carsa
040500080917     C*                  Clear                   cadsa
040600080917     C*                  Clear                   nbrsa
040700080917     C*                  Clear                   presa
040800080917     C*                  Clear                   comsa
040900080917     C*                  ENDSR
041000030415      *___________________________________________________________________
041100010204      * Final Total
041200010204      *___________________________________________________________________
041300010204     C     FinalTotal    BEGSR
041301060323     c                   move      'Y'           finaltotfld       1
041400010204     C                   Move      *on           *In91
041500010204     C                   Exsr      CheckOverflow
041600010204     C                   Write     PRTSBCF
041700010227     C                   sorta     aryf
041800010227     C                   Eval      Elements =    %elem(aryf)
041900010227     C                   Do        Elements      pos
042000010204     C                   Eval      W8CARR   =    carf(pos)
042100010204     C                   Eval      W8CNAM   =    cadf(pos)
042200010204     C                   z-add     nbrf(pos)     W8MCNT
042300010204     C                   z-add     pref(pos)     W8PPRM
042400010204     C                   z-add     comf(pos)     W8PCOM
042401051031
042501060313     C                   If        carf(pos) <> *Blanks or
042502060313     C                             cadf(pos) <> *Blanks or
042503060313     C                             nbrf(pos) <> *zeros  or
042504060313     C                             pref(pos) <> *zeros  or
042505060313     C                             comf(pos) <> *zeros
042506051031     C                   Exsr      CheckOverflow
042600010204     C                   Write     PRTSBDF
042700010227     C                   End
042701051031
042800010204     C                   Eval      W9MCNT   =    W9MCNT + W8MCNT
042900010204     C                   Eval      W9PPRM   =    W9PPRM + W8PPRM
043000010204     C                   Eval      W9PCOM   =    W9PCOM + W8PCOM
043100010204     C                   Enddo
043101051031
043102051031     C                   Exsr      CheckOverflow
043200010204     C                   Write     PRTSBTF
043300010204     C                   Eval      W8MCNT   =    0
043400010204     C                   Eval      W8PPRM   =    0
043500010204     C                   Eval      W8PCOM   =    0
043600010204     C                   Eval      W9MCNT   =    0
043700010204     C                   Eval      W9PPRM   =    0
043800010204     C                   Eval      W9PCOM   =    0
043900010204     C                   Eval      Lastf    =    0
044000010204     C                   Clear                   carf
044100010204     C                   Clear                   cadf
044200010204     C                   Clear                   nbrf
044300010204     C                   Clear                   pref
044400010204     C                   Clear                   comf
044402080917     c                   exsr      #prtsatot
044500010204     C                   ENDSR
044600010201      *___________________________________________________________________
044700000000      * Key Lists
044800000000      *___________________________________________________________________
044900000000     C     KLIST         BEGSR
044901080917
044902080917     c     rpa163wkey    klist
044903080917     c                   kfld                    sxsuper
044904080917     c                   kfld                    rppcar
044905081009     c     acckey        klist
044906081009     c                   kfld                    RPTRST
044907081009     c                   kfld                    RPSUB
044908081009     c                   kfld                    RPACC
045000000000     C                   ENDSR
045100010201      *___________________________________________________________________
045200010201      * Check Overflow - Print Header
045300010201      *___________________________________________________________________
045400010201     C     CheckOverflow BEGSR
045500010524     C                   If        DUMMY  = 'Y'
045600010524     C                   Move      *On           *IN55
045700010524     C                   End
045800010201     C                   If        *in91  = *on
045801060323
045802060323      * do not print sman in header on final total
045803060323     C                   If        finaltotfld <> 'Y'
045900010201     C                   Write     PRTHDR
045901060323     c                   else
045903060323     C                   Write     PRTHDRlr
045904060323     c                   end
045905060323
046000010201     C                   Move      *off          *In91
046100010201     C                   End
046200010201     C                   ENDSR
046251051031
046252080917      **********************************************************
046253080917      * print super agency totals
046254080917      **********************************************************
046255080917     C     #prtsatot     begsr
046256080917     c                   clear                   sabreak           3
046261080917
046262080917     c     *loval        setll     rpa163wk
046263080917     c                   dou       %eof(rpa163wk)
046264080917     c                   read      rpa163wk
046265080917     c                   if        not%eof(rpa163wk)
046266080917
046267080917      * new sa, skip to new page and print headings
046268080917     c                   if        r1wsa <> sabreak
046269080918      * print SA totals (not first time)
046270080917     c                   if        firstt <> ' '
046271080917     c                   write     satottot
046277080918     c                   clear                   w11mcnt
046278080918     c                   clear                   w11pprm
046279080918     c                   clear                   w11pcom
046280080918     c                   else
046281080918     c                   move      'Y'           firstt            1
046282080917     c                   end
046283080918      * skip to new page on SA change
046284080917     c                   move      r1wsa         sabreak
046285080917     c                   move      'Y'           finaltotfld       1
046286080917     C                   Move      *on           *In91
046287080918     C                   Move      *on           *In90
046288080917     C                   Exsr      CheckOverflow
046289080917     c                   end
046290080917
046291080918      * print detail line and accumulate totals
046292080918     C                   Exsr      CheckOverflow
046293080917     C                   Write     satotdet
046294080917     c                   add       r1wmem        w11mcnt
046295080917     c                   add       r1wprem       w11pprm
046296080917     c                   add       r1wcom        w11pcom
046301080917
046302080917     c                   end
046303080917     c                   enddo
046308080917
046309080918      * force final SA totals
046310080918     c                   write     satottot
046312080917     C                   endsr
046313080917
0463400810090103 C***************************************************
0463410810090104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0463420810090105 C***************************************************
0463430810090107 C*
0463440810090107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0463450810090107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0463460810090107 C*
0463470810090106 C     #DATYM        BEGSR
046348081009     C                   MOVE      @DATIN        @MD               4 0
046349081009     C                   MOVEL     @DATIN        @Y                4 0
046350081009     C                   MOVEL     @MD           @DATOU            8 0
046351081009     C                   MOVE      @Y            @DATOU
046352081009     C                   MOVE      *ZEROS        @DATIN            8 0
0463530810090120 C                   ENDSR
0463540810090107 C*
046355010524      *___________________________________________________________________
046400010524      * Plist
046500010524      *___________________________________________________________________
046600010524     C     PLIST         BEGSR
046700010524     C     *ENTRY        PLIST
046800010524     C                   Parm                    DUMMY             1
046900030417     C                   Parm                    parmdateymd       8
046901080917     C                   Parm                    parmdddatemdy     8
047000010524     C                   ENDSR
047100010201      *___________________________________________________________________
047200010201      * Program Open
047300010201      *___________________________________________________________________
047400010201     C     *INZSR        BEGSR
047500010201     C                   Move      *on           *In91
047600030415     C                   movel     parmdateymd   y                 4 0
047700030415     C                   move      parmdateymd   md                4 0
047800030415     C                   movel     md            COMPRD
047900030415     C                   move      y             COMPRD
047901080917     C                   move      parmdddatemdy parmdddatemdyn    8 0
047902080917
047903080917     c                   eval      ddtext = 'YOUR GBS COMMISSIONS HAVE BEEN +   +
047904080917     c                             DIRECT DEPOSITED ON ' +
047905080917     c                             %editc(parmdddatemdyn:'Y')
048000010201     C                   ENDSR
