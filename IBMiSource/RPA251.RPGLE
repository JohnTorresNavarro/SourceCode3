0001009102150002 F******************************************************************
0002001205150003 F* rpa251     GROUP BENEFIT SERVICES SOFTWARE                     *
0003009102150004 F*                                                                *
0004001205150004 F*          DLK - 05/15/12                                        *
0005009510040004 F*                                                                *
0006001205150013 F*          Read CR130ALL, get current agency code and carrier    *
0007001205170014 F*          group code and create workfile. Then read dbcr130ng   *
0008001205170015 F*          to add the tab 5 data.                                *
0009000304300015 F*                                                                *
0010001404250015 F* 04/25/14 dlk - add date selection to work file because the     *
0011001404250015 F*                it will now be available for Finance to query.  *
0012001404280015 F* 04/28/14 dlk - add tab 5 indicator to detail file              *
0013001703060015 F* 03/06/17 dlk - add acct state to rpa251wk for other use of     *
0014001703060015 F*                detail data by acct state                       *
001500180109      * 01/09/18 jt  - Added changes for Advanced Mobile
001600200110      * 01/10/20 jt  - Added changes for Advanced Mobile
0017001703060015 F*                                                                *
0018009102150016 F******************************************************************
0019001205150018 FCR130all  Ip   E             DISK    rename(cr130all:cr130allr)
0020001205150018 FCarmst    If   E           k DISK    prefix(c_)
002100030430     fspragxr2  if   e           k disk
002200030430     fsmanrlt   if   e           k disk
002300030430     fagency    if   e           k disk
002400120515     fstatecd   if   e           k disk
002500120515     FHYPERCARR IF   E           K DISK
002600120517     fdbcr130ng if   e           k disk    prefix(n_)
002700120518     ftrsmst    if   e           k disk
002800170306     faccmst    if   e           k disk
0029001205160027 Frpa251wk  O  a e             disk
003000120517     d wkcarrier       s                   like(ccarcd)
003100120517     d wkrelid         s                   like(crelid)
003200120517     d wkagcod         s                   like(cagcod)
003300120518     d wktrust         s                   like(ctrust)
003400120518     d skiptrust       s              1
003500120517     D                 DS
003600120517     D PARMINds                1     17A
003700120517     D  parmfromdt             1      8  0
003800120517     D  parmtodt               9     16  0
003900070131
004000120518      * skip all of Senior Dental
004100120518     c                   movel     ctrust        wktrust
004200120518     c                   exsr      #chktrs
004300120518     c                   if        skiptrust = 'Y'
004400120518     c                   goto      #end
004500120518     c                   end
004600120518
004700120515      * clear work file record
004800120516     c                   clear                   rpa251wkr
004900120515
005000120517      * get carrier group code
005100120517     c                   movel     ccarcd        wkcarrier
005200120517     c                   exsr      #getcar
005300120517
005400120515      * get current agency code and info
005500120517     c                   movel     crelid        wkrelid
005600120517     c                   movel     cagcod        wkagcod
005700120515     c                   exsr      #getag
005800120515
005900120516     c                   z-add     cpamt         r2aprem
006000120516     c                   z-add     ccome         r2acom
006100120516     c                   z-add     cadme         r2aaf
006200120516     c                   z-add     cbond         r2abd
006300120516     c                   z-add     clives        r2alives
006400120521     c                   z-add     CTRUST        r2TRUST
006500120521     c                   z-add     CSUB          r2SUB
006600120521     c                   z-add     CACCT         r2ACC
006700140425     c                   move      ceffdt        r2effdt
006800140425     c                   move      parmfromdt    r2frdt
006900140425     c                   move      parmtodt      r2todt
007000120515
007100170306      * get acct state
007200170306       chain (ctrust:csub:cacct) accmst;
007300170306       if %found(accmst);
007400170306        eval r2acstate = astate;
007500170306        chain (astate) statecd;
007600170306        if %found(statecd);
007700170306        eval r2acstnam = stname;
007800170306        endif;
007900170306       endif;
008000170306
008100120516     c                   write     rpa251wkr
008200120515
008300120518     c     #end          tag
008400120517      * get tab 5 data at end
008500120517     clr                 exsr      #lr
008600120518      ***********************************
008700120518      * check trsmst
008800120518      ***********************************
008900120518     c     #chktrs       begsr
009000120518    *
009100120518      * skip senior dental
009200120518     c                   clear                   skiptrust
009300120518     c     wktrust       chain     trsmst
009400120518     c                   if        not %found(trsmst) or tscode = 'O N'
009500200110     C                             or tscode = 'O M' or tscode = 'O D'
009600120518     c                   move      'Y'           skiptrust
009700120518     c                   end
009800120518
009900120518     c                   endsr
010000120517
010100120515      ***********************************
010200120517      * get carrier group info
010300180109      ***********************************
010400120517     c     #getcar       begsr
010500031218    *
010600120521     c                   movel     wkcarrier     r2carcod
010700120521
010800120517     c     wkcarrier     chain     carmst
010900120517     c                   if        %found(carmst)
011000120517     c                   movel     c_cgrpcd      r2cargrp
011100140425     c                   movel     c_cname       r2carnam
011200120517     C     c_cgrpcd      chain     hypercarr
011300120517     C                   if        %found(hypercarr)
011400120517     c                   movel     hcname        r2grpnam
011500120517     C                   end
011600120517     c                   end
011700031218
011800030430     c                   endsr
011900120517
012000120517      ***********************************
012100120517      * get current agency info - code from cr211
012200120517      ***********************************
012300120517     c     #getag        begsr
012400120517    *
012500120517      * if blank relation, then use current agency code from cr130hst rec
012600120517     c                   if        wkrelid = *blanks
012700120517     c                   exsr      #agcylkup
012800120517     c                   leavesr
012900120517     c                   endif
013000120517    ***
013100120517    * * get sman relation
013200120517     c     wkrelid       chain     smanrlt
013300120517     c                   if        not %found(smanrlt)
013400120517     c                   exsr      #agcylkup
013500120517     c                   leavesr
013600120517     c                   endif
013700120517
013800120517    * * get agency from xref file
013900120517     c     srasid        chain     spragxr2
014000120517     c                   if        not %found(spragxr2)
014100120517     c                   exsr      #agcylkup
014200120517     c                   leavesr
014300120517     c                   endif
014400120517    *
014500120517      * use the agency from the xref file
014600120517     c                   eval      wkagcod  = sxagcy
014700120517     c                   exsr      #agcylkup
014800120517
014900120517     c                   endsr
015000031218   S*
015100120515      ******************************************************
015200120515      * get agency info
015300120515      ******************************************************
015400120517     c     #agcylkup     begsr
015500031218    *
015600120517     c                   movel     wkagcod       r2agcode
015700120515
015800120517     c     wkagcod       chain     agency
015900030430     c                   if        %found(agency)
016000120516     c                   movel     AGNAM1        r2agname
016100120516     c                   movel     AGSTAT        r2stcode
016200120515     c     agstat        chain     statecd
016300120515     c                   if        %found(statecd)
016400120516     c                   movel     stname        r2stname
016500030430     c                   endif
016600120515     c                   endif
016700030430    ***
016800030430     c                   endsr
016900120517      ******************************************************
017000120517      * get tab 5 data from dbcr130ng file
017100120517      ******************************************************
017200120517     c     #lr           begsr
017300120517    *
017400120517      * read by effective date, select using date range entered by user
017500120518      * and include all records with the acct cancel date filled in
017600120517
017700120517     c     parmfromdt    setll     dbcr130ng
017800120517
017900120517     c                   dou       %eof(dbcr130ng)
018000120517     c                   read      dbcr130ng
018100120517
018200120517     c                   if        not %eof(dbcr130ng) and
018300120518     c                             n_caccandt <> 0 and
018400120518     c                             n_ceffdt >= parmfromdt and
018500120517     c                             n_ceffdt <= parmtodt
018600120517
018700120518
018800120518      * skip all of Senior Dental
018900120518     c                   movel     n_ctrust      wktrust
019000120518     c                   exsr      #chktrs
019100120518     c                   if        skiptrust = 'Y'
019200120518     c                   iter
019300120518     c                   end
019400120518
019500120517      * clear work file record
019600120517     c                   clear                   rpa251wkr
019700120517
019800120517      * get carrier group code
019900120517     c                   movel     n_ccarcd      wkcarrier
020000120517     c                   exsr      #getcar
020100120517
020200120517      * get current agency code and info
020300120517     c                   movel     n_crelid      wkrelid
020400120517     c                   movel     n_cagcod      wkagcod
020500120517     c                   exsr      #getag
020600120517
020700120517     c                   z-add     n_cpamt       r2aprem
020800120517     c                   z-add     n_ccome       r2acom
020900120517     c                   z-add     n_cadme       r2aaf
021000120517     c                   z-add     n_cbond       r2abd
021100120517     c                   z-add     n_clives      r2alives
021200120521     c                   z-add     n_CTRUST      r2TRUST
021300120521     c                   z-add     n_CSUB        r2SUB
021400120521     c                   z-add     n_CACCT       r2ACC
021500140425     c                   move      n_ceffdt      r2effdt
021600140425     c                   move      parmfromdt    r2frdt
021700140425     c                   move      parmtodt      r2todt
021800140428     c                   move      'Y'           r2tab5
021900120517
022000170306      * get acct state
022100170306       chain (n_ctrust:n_csub:n_cacct) accmst;
022200170306       if %found(accmst);
022300170306        eval r2acstate = astate;
022400170306        chain (astate) statecd;
022500170306        if %found(statecd);
022600170306        eval r2acstnam = stname;
022700170306        endif;
022800170306       endif;
022900170306
023000140428     c                   write     rpa251wkr
023100120517     c                   end
023200120517
023300120517      * since dbcr130ng is keyed by the effective date first, once a record
023400120517      * is read past the todate, this read can stop
023500120517     c                   if        n_ceffdt > parmtodt
023600120517     c                   leave
023700120517     c                   end
023800120517
023900120517     c                   enddo
024000120517
024100120517     c                   endsr
024200120517
024300120517     c     *inzsr        begsr
024400120517     C     *ENTRY        PLIST
024500120517     C                   PARM                    parmin           17
024600120517     c                   move      parmin        parminds
024700120517     c                   endsr
