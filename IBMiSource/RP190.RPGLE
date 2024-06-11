0001009102260002 F******************************************************************
0002009102260003 F* RP190      GROUP BENEFIT SERVICES SOFTWARE           1990      *
0003009102260004 F*                                                                *
0004009102260005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005009102260006 F*            DATE - 01/31/91                                     *
0006009102260007 F*                                                                *
0007009102260008 F*  DESCRIPTION - THIS PROGRAM WILL PRODUCE AN ADDED ACCOUNTS     *
0008009102260009 F*            REPORT.                                             *
0009009102260010 F*                                                                *
0010009811230011 F*                                                                *
0011009811230010 F*  Y2K CONVERT - 1998                                            *
0012000111270012 F* 11/27/01 dlk - convert from RPGII                              *
001300060317      * 03/17/06 dlk - add agency selection                            *
001400091230      * 12/30/09 dlk - add cancel date to report                       *
001500180521      * 05/21/18 dlk - change report to run by enroll date range and   *
0016001805210011  *                remove printed report                           *
001700180530      * 05/30/18 dlk - change to use hist primary                      *
001800211213      * 12/13/21 dlk - few changes to fields used in output per        *
001900211213      *                request by Annette to more closely match        *
002000211213      *                the accounts cancelled report rp180             *
0021001805210011 F*                                                                *
0022009102260012 F******************************************************************
0023009102260013 F*                                                                *
0024001805300014 Fhist      IP   e             DISK
0025001805300014 FACCMST    If   e           k DISK    extfile('F.ACCMST')
0026001609280015 FMEMAC#    IF   e           k DISK    extfile('F.MEMAC#')
0027001609280005 Fcmct14    if   e           k disk    extfile('F.CMCT14')
002800160928     fspragxr2  if   e           k disk    extfile('F.SPRAGXR2')
002900160928     fsmanrlt   if   e           k disk    EXTFILE('F.SMANRLT')
003000180521     fsman      if   e           k disk
003100180530     faacode    if   e           k disk
003200211214     fcodesl1   if   e           k disk
003300211214     fhypercarr if   e           k disk
003400211214     fplnmst    if   e           k disk
003500211214     fcarmst    if   e           k disk
003600160928     FRP190xl   o  a e             disk
003700060317     fqsysprt   o    f  132        printer oflind(*inog)
003800160930
003900160930      *=======================================================================
004000160930
004100060317     D agfound         S              1
0042000603170020 D ag              S              3    DIM(10)                              Agency selection
0043000603170037 D holdrel         S                   like(cmrelid)
0044000603170037 D holdag          S                   like(sxagcy)
0045001609300037 D firstTime       s              1    inz('Y')
0046001805210037 D phone_o         s             12
0047001805210037 D phone_wk        s             10s 0
0048001805210037 D smannam_o       s             32
004900180530     Dcovmdy           s                   like(covtdt)
005000211213     Denrmdy           s                   like(enroll)
005100180530     Dtrdmdy           s                   like(trdate)
005200180530     Daaname           s             43
005300211214     Dcsv              c                   const('","')
005400211214     D gbsbdmdy        s              8  0
0055002112140037 D workdt          S               d   datfmt(*iso)
0056002112140020 D car             S             30    DIM(10)
005700211213
005800211213     D                 DS
005900211213     D  TSA#                   1     10  0 inz
006000211213     D  actrst                 1      3  0
006100211213     D  acsub#                 4      6  0
006200211213     D  acacct                 7     10  0
006300160930
0064009102260037 D                UDS
0065009102260038 D  LTRUST                 1      3
0066001805210039 D  Lfromymd               4     11  0
0067001805210039 D  Ltoymd                12     19  0
006800060317     D  Lagency               31     60
006900060317     D  Lag1                  31     33
007000060317     D  Lag2                  34     36
007100060317     D  Lag3                  37     39
007200060317     D  Lag4                  40     42
007300060317     D  Lag5                  43     45
007400060317     D  Lag6                  46     48
007500060317     D  Lag7                  49     51
007600060317     D  Lag8                  52     54
007700060317     D  Lag9                  55     57
007800060317     D  Lag10                 58     60
0079009102260040 D  CONAME               201    240
0080009102260041 D  TIME                 242    247  0
008100180530     Iaccmsr
008200180530     i              aacode                      a_aacode
008300160930
008400180530
008500180530      * get account record
008600180530     C     h_ackey       CHAIN     accmst
008700180530     c                   if        (not %found(accmst))
008800180530     c                   goto      #end
008900180530     c                   end
009000180530
009100180530      * get aa name
009200180530     c                   clear                   aaname
009300180530     C     a_aacode      CHAIN     aacode
009400180530     c                   if        %found(aacode)
009500180530       aaname = %trim(afnam) + ' ' + %trim(alnam);
009600180530     c                   end
009700180530
009800180530     C                   eval      @datin = trdate
009900180530     C                   exsr      #datym
010000180530     C                   eval      trdmdy = @datou
010100180530
010200180530     C                   eval      @datin = covtdt
010300180530     C                   exsr      #datym
010400180530     C                   eval      covmdy = @datou
010500180530
010600211213     C                   eval      @datin = enroll
010700180530     C                   exsr      #datym
010800211213     C                   eval      enrmdy = @datou
010900180530
011000060317      * select agency?
011100060317     c                   if        lagency <> *blanks
011200060317     c                   exsr      #agchk
011300060317     c                   if        agfound <> 'Y'
011400060317     c                   goto      #end
011500060317     c                   end
011600060317     c                   end
011700060317
011800180530
011900180530       if firstTime = 'Y';
012000180530        exsr writeHeader;
012100180530        firstTime = 'N';
012200180530       endif;
012300180530
0124009102260059 C*
0125009102260060 C***************************************************************
0126009102260061 C* READ MEMBERS IN ACCOUNT                                     *
0127009102260062 C***************************************************************
0128009102260063 C*
0129000111270064 C                   clear                   ACMEM             4 0
0130009102260065 C                   SETOFF                                       11
0131009102260066 C     KEYACC        SETLL     MEMAC#
013200011127
013300011127     c                   DOW       not *in11
0134009102260068 C     KEYACC        READE     MEMAC#                                 11
013500011127     c   11              leave
013600180521     C                   if        termdt <> 0 and termdt <= enroll
013700011127     C                   iter
013800921222     C                   END
0139009102260078 C                   ADD       1             ACMEM
0140000111270089 C                   ENDDO
0141002112130096 C****
014200180521     c                   clear                   atrmmdy_o        10
014300180521     c                   if        atrmdt <> 0
014400091230     C                   MOVE      atrmdt        @DATIN
014500091230     C                   EXSR      #DATYM
014600091230     C                   MOVE      @DATOU        atrmmdy           8 0
014700180521     c                   eval      atrmmdy_o = %editc(atrmmdy:'Y')
014800180521     c                   end
014900180521
015000180521     C                   clear                   phone_o
015100180521     C                   clear                   phone_wk
015200180521     C                   MOVEl     aarea         phone_wk
015300180521     C                   MOVE      aphone        phone_wk
015400180521       phone_o = %editw(phone_wk:'0   -   -    ');
015500180521
015600180521      * get sman name
015700180521       clear smannam_o;
015800180521       chain smancd sman;
015900180521       clear smannam_o;
016000180521       if %found(sman);
016100180521        smannam_o = %trim(sfname) + ' ' + %trim(slname);
016200180521       endif;
016300211214
016400211214      * gbs begin admin date as mdy
016500211214        @datin = gbsbdt;
016600211214        exsr #datym;
016700211214        gbsbdmdy = @datou;
016800211214
016900211214      *
017000211214      * find all medical carriers based on comctx on gbs begin admin date
017100211214      *
017200211214        clear car;
017300211214     c                   clear                   comctxfound       1
017400211214     c                   z-add     gbsbdt        searchdt          8 0
017500211214     c                   exsr      #getcar
017600211214      * if not found, try again with 1 day later
017700211214     c                   if        comctxfound = *blank
017800211214     c                   move      gbsbdt        workdt
017900211214     C                   adddur    1:*d          workdt
018000211214     C                   move      workdt        searchdt
018100211214     c                   exsr      #getcar
018200211214     c                   end
018300211214
018400180521
018500211214      * write spreadsheet detail
018600160930       exsr writexldet;
018700211214
018800060317     c     #end          tag
018900160930
0190001609300164  *============================================================
0191001609300164  * Write Spreadsheet Detail
0192001609300164  *============================================================
019300160930
019400160930     C     writexldet    BEGSR
019500160930
019600160930     c                   clear                   rp190fld
019700160930     C                   Eval      rp190fld  =   '"' +
019800211214     C                             %trim(%editw(tsa#:'0   -   -    ')) + csv +
019900211214     C                             %trim(acnam1)                       + csv +
020000211214     C                             %trim(contac)                       + csv +
020100211214     C                             %char(phone_o)                      + csv +
020200211214     C                             %trim(%editw(covmdy:'0  /  /    ')) + csv +
020300211214     C                             %trim(%editw(trdmdy:'0  /  /    ')) + csv +
020400211214     C                             %trim(%editw(enrmdy:'0  /  /    ')) + csv +
020500211214     C                             %trim(%editw(gbsbdmdy:'0  /  /    ')) + csv +
020600211214     C                             %trim(atrmmdy_o)                    + csv +
020700211214     C                             %trim(%editc(acmem:'J'))            + csv +
020800211214     C                             %trim(%editc(apremi:'J'))           + csv +
020900211214     C                             %trim(aaname)                       + csv +
021000211214     C                             %trim(smannam_o)                    + csv +
021100211214     C                             %trim((car(1)))                     + csv +
021200211214     C                             %trim((car(2)))                     + csv +
021300211214     C                             %trim((car(3)))                     + csv +
021400211214     C                             %trim((car(4)))                     + csv +
021500211214     C                             %trim((car(5)))                     + csv +
021600211214     C                             %trim((car(6)))                     + csv +
021700211214     C                             %trim((car(7)))                     + csv +
021800211214     C                             %trim((car(8)))                     + csv +
021900211214     C                             %trim((car(9)))                     + csv +
022000211214     C                             %trim((car(10)))                    + csv +
022100211214     C                             ' '                          + '",'
022200160930
022300160930     C                   Write     rp190xr
022400160930
0225001609300320 C                   ENDSR
022600160930
0227001609300164  *============================================================
0228001609300164  * Write Spreadsheet Header
0229001609300164  *============================================================
023000160930
023100160930     C     writeHeader   BEGSR
023200160928
023300160930     c                   clear                   rp190fld
023400160930
023500211213     C                   Eval      rp190fld  =   '"' +
023600211214     C                                           'ACCOUNT #'           + csv +
023700211214     C                                           'ACCOUNT NAME'        + csv +
023800211214     C                                           'CONTACT'             + csv +
023900211214     C                                           'PHONE'               + csv +
024000211214     C                                           'ADD ENROLL DATE'     + csv +
024100211214     C                                           'DATE PROCESSED'      + csv +
024200211214     C                                           'CURRENT ENROLL DATE' + csv +
024300211214     C                                           'BEGIN ADMIN DATE'    + csv +
024400211214     C                                           'CANCEL DATE'         + csv +
024500211214     C                                           '# OF MEM'            + csv +
024600211214     C                                           'LAST INV $'          + csv +
024700211214     C                                           'AA NAME'             + csv +
024800211214     C                                           'SMAN NAME'           + csv +
024900211214     C                                           'CARRIER 1'           + csv +
025000211214     C                                           'CARRIER 2'           + csv +
025100211214     C                                           'CARRIER 3'           + csv +
025200211214     C                                           'CARRIER 4'           + csv +
025300211214     C                                           'CARRIER 5'           + csv +
025400211214     C                                           'CARRIER 6'           + csv +
025500211214     C                                           'CARRIER 7'           + csv +
025600211214     C                                           'CARRIER 8'           + csv +
025700211214     C                                           'CARRIER 9'           + csv +
025800211214     C                                           'CARRIER 10'          + csv +
025900160930     C                                                 ' '             + '",'
026000160930     C                   Write     rp190xr
026100160928
0262001609280320 C                   ENDSR
026300160930
0264000603170069 C**************************************************************
026500060317JGE01C* agency check                                               *
0266000603170069 C**************************************************************
026700060317JGE01C     #agchk        BEGSR
026800060317
026900060317     c                   clear                   holdrel
027000060317     c                   clear                   holdag
027100060317     c                   clear                   agfound
027200060317
027300180521      * find all comctx for the acct enroll date
027400060317     c     keyacc        setll     cmct14
027500060317     c                   dou       %eof(cmct14)
027600060317     c     keyacc        reade     cmct14
027700180521     c                   if        (not %eof(cmct14)) and (enroll >= effdat)
027800180521     c                             and (cmcan = 0 or cmcan >= enroll)
027900060317     c                             and (cmcan <> effdat)
028000060317     c                   move      cmrelid       holdrel
028100060317     c                   exsr      #chkrel
028200060317     c                   if        agfound = 'Y'
028300060317     c                   leavesr
028400060317     c                   end
028500060317     c                   end
028600060317     c                   enddo
028700060317
028800060317      * missing commission
028900060317     c                   if        holdrel = *blanks
029000060317     c                   if        firste <> 'N'
029100060317     c                   move      'N'           firste            1
029200060317     c                   except    errhed
029300060317     c                   end
029400060317     c   og              except    errhed
029500060317     c                   except    errcom
029600060317     c                   end
029700060317
029800060317     c                   endsr
029900060317
030000060317      **************************************************************
030100060317      * check this relation for a match to the selected agency
030200060317      **************************************************************
030300060317     c     #chkrel       begsr
030400060317
0305000603170063 C     holdrel       CHAIN     smanrlt
030600060317     c                   if        not %found(smanrlt)
030700060317     c                   leavesr
030800060317     c                   else
030900180521    * * the relation is not active for the acct enroll date
031000060317     c                   if        (sreffdte = srtrmdte) or
031100180521     c                             (sreffdte > enroll) or (srtrmdte <> 0
031200180521     c                             and srtrmdte <= enroll)
031300060317     c                   leavesr
031400060317     c                   end
031500060317     c                   end
031600060317      * get SA xref
031700060317     c     srasid        chain     spragxr2
031800060317     c                   if        %found(spragxr2)
031900060317     c                   eval      holdag = sxagcy
0320000603170309 C                   Z-ADD     1             X                 2 0
032100060317     c     holdag        lookup    ag(x)                                  88
032200060317     c                   if        %found
032300060317     c                   eval      agfound = 'Y'
032400060317     c                   end
032500060317     c                   end
032600060317
032700060317JGE01C                   ENDSR
0328002112140069 C**************************************************************
032900211214JGE01C* get carriers
0330002112140069 C**************************************************************
033100211214JGE01   begsr #getcar;
033200211214
033300211214      * find all comctx for the acct cancel date
033400211214           setll (hstrst : hssub# : hsacct) cmct14;
033500211214           dou %eof(cmct14);
033600211214           reade (hstrst : hssub# : hsacct) cmct14;
033700211214           if (not %eof(cmct14)) and (searchdt >= effdat)
033800211214               and (cmcan = 0 or cmcan >= searchdt)
033900211214               and (cmcan <> effdat);
034000211214              comctxfound = 'Y';
034100211214
034200211214      * get plan and carrier, only show medical
034300211214           chain (cmtrst : csubdv : cmplan) plnmst;
034400211214           if %found(plnmst);
034500211214            chain (plncat) codesl1;
034600211214            if %found(codesl1) and action = 'M';
034700211214             chain (pcarr) carmst;
034800211214             if %found(carmst);
034900211214              chain (cgrpcd) hypercarr;
035000211214              exsr #storcar;
035100211214             endif;
035200211214            endif;
035300211214           endif;
035400211214
035500211214           endif;
035600211214           enddo;
035700211214
035800211214           endsr;
035900211214
0360002112140351 C****************************************************************
0361002112140352 C*    STORE carrier group name                                  *
0362002112140354 C****************************************************************
036300211214     C     #storcar      BEGSR
036400211214
036500211214     C                   Z-ADD     1             X                 2 0
036600211214     C     #T0080        TAG
036700211214
036800211214     C                   IF        car(x) = *BLANKS
036900211214     C                   MOVE      hcname        car(X)
037000211214     C                   leavesr
037100211214     C                   ELSE
037200211214     c                   if        car(x) = hcname
037300211214     C                   leavesr
037400211214     C                   ELSE
037500211214     C                   ADD       1             X
037600211214     C*
037700211214     C     X             IFLE      10
037800211214     C                   GOTO      #T0080
037900211214     C                   END
038000211214
038100211214     C                   END
038200211214     C                   END
038300211214
038400211214     C                   ENDSR
038500211214
038600211214
038700060317
0388000912300103 C***************************************************
0389000912300104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0390000912300105 C***************************************************
0391000912300107 C*
0392000912300107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0393000912300107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0394000912300107 C*
0395000912300106 C     #DATYM        BEGSR
039600091230     C                   MOVE      @DATIN        @MD               4 0
039700091230     C                   MOVEL     @DATIN        @Y                4 0
039800091230     C                   MOVEL     @MD           @DATOU            8 0
039900091230     C                   MOVE      @Y            @DATOU
040000091230     C                   MOVE      *ZEROS        @DATIN            8 0
0401000912300120 C                   ENDSR
0402000912300107 C*
040300011127     C     *inzsr        begsr
040400180530     c     h_ackey       klist
040500180530     c                   kfld                    hstrst
040600180530     c                   kfld                    hssub#
040700180530     c                   kfld                    hsacct
040800180530
040900011127     c     keyacc        klist
041000011127     c                   kfld                    actrst
041100011127     c                   kfld                    acsub#
041200011127     c                   kfld                    acacct
041300180530
041400180521     c                   move      lfromymd      lfrommd           4 0
041500180521     c                   movel     lfromymd      lfromy            4 0
041600180521     c                   movel     lfrommd       lfrommdy          8 0
041700180521     c                   move      lfromy        lfrommdy
041800060317
041900180521     c                   move      ltoymd        ltomd             4 0
042000180521     c                   movel     ltoymd        ltoy              4 0
042100180521     c                   movel     ltomd         ltomdy            8 0
042200180521     c                   move      ltoy          ltomdy
042300180521
042400060317     C                   movea     lagency       ag
042500011127     C                   ENDSR
042600060317     oqsysprt   e            errhed         2  2
0427000603170142 O                                           14 'RUN DATE:'                 RP020
0428000603170143 O                       UDATE         Y     25                             RP020
042900060317     O                                           70 'RP190 (ACCOUNTS ADDED REP'
043000060317     O                                           +0 'ORT) - ERRORS'
0431001805210134 O                       lfrommdy           109 '  /  /    '
0432001805210134 O                                          111 '-'
0433001805210134 O                       ltomdy             122 '  /  /    '
043400060317     o          e            errcom         1
043500060317     O                       actrst              20
043600060317     O                       acsub#              24
043700060317     O                       acacct              29
043800060317     O                                           80 'NO COMMISSION FOUND - AC'
043900060317     O                                           +0 'COUNT WILL NOT BE SELECTED'
