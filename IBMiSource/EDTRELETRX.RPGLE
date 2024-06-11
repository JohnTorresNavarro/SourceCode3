000100170420      *========================================================================
000200170420     H option(*noDebugIo)
000300150326      *========================================================================
000400170420      * EDTRELETR - EDT Renewal Letter
000500170420      *========================================================================
000600150326      *   Created by:  J. Torres - March 26, 2015
000700150326      *========================================================================
000800150323
000900170420     Fplnmst    if   e           k disk    rename(plnmsr:planFile)
001000170420     F                                     extfile('F.PLNMST')
001100170420      * Plan master...
001200150326
001300170420     Faccmst    if   e           k disk    rename(accmsr:acctFile)
001400170420     F                                     extfile('F.ACCMST')
001500170420      * Account master...
001600170420
001700170424     Fac2mstl2  if   e           k disk    rename(accmsr2:acct2File)
001800170424      * Account master...
001900170424
002000170420     Fplnauxp   if   e           k disk    rename(plnauxr:auxFile)
002100170420      * Plan Auxiliary...
002200170420
002300170420     Fgrate     if   e           k disk    rename(grater:groupFile)
002400170420     F                                     extfile('F.GRATE')
002500170420      * Group rate...
002600170420
002700170421     Fsman      if   e           k disk    rename(smanr:salesmFile)
002800170421     F                                     extfile('F.SMAN')
002900170421      * Salesman...
003000170424
003100170424     Fsman2l    if   e           k disk    rename(sman2r:sales2File)
003200170424     F                                     extfile('F.SMAN2L')
003300170424      * Salesman additional info...
003400170421
003500170421     Fcmct14    if   e           k disk    rename(comcxr:commFile)
003600170421     F                                     extfile('F.CMCT14')
003700170421      * Commission...
003800170421
003900170421     Fgratehold if   e           k disk    rename(gratehr:ratehFile)
004000170421     F                                     usropn
004100170421      * Group rate...
004200170421
004300170420     Fedtrelet  o    e             disk    rename(edtrlr:renwFile)
004400170420      * Renewal letter...
004500170421
004600170421     Fedtaginf  o    e             disk    rename(edtagr:agentFile)
004700170421      * Agent information...
004800170421
004900170421     Fedtrnlag  o    e             disk    rename(edtrnagr:reagtFile)
005000170421      * xRef...
005100170421
005200170420      //=======================================================================
005300170420
005400170420    ?d trust           s              3  0 inz(5)
005500170420     D ISOdate         s               d   datfmt(*iso) inz(*sys)
005600170420    ?d currentMonth    s              2  0
005700170420    ?d processMonth    s              2  0
005800170420    ?D date_toSearch   s              8  0
005900170421    ?D date_toSearch2  s              8  0
006000170421    ?D holdDate        s              8
006100170421    ?D count           s              1  0
006200170421    ?D pos             s              1  0
006300170510    ?D testnumber      s              6
006400170510    ?D testnumberd     s              6  2
006500170420
006600170421     d xRef            pr                  extpgm('ADVXREFR')
006700170421     d  pxtrst                        3  0
006800170421     d  pxsub#                        3  0
006900170421     d  pxacct                        4  0
007000170421     d  plplan                        4
007100170421
007200170424     D edtreletr       pi
007300170424     d  month#                        2
007400170424
007500150430      //=======================================================================
007600150430      // mainline
007700150430      //=======================================================================
007800150323
007900170510        testnumberd = 052.650;
008000170510        testnumber = %trim(%editc(testnumberd : 'J'));
008100170510        //testnumber = %char(testnumberd);
008200170510        exsr exit;
008300170510
008400150323       exsr init;
008500150323       exsr main;
008600150323       exsr exit;
008700150323
008800170420       //=======================================================================
008900150323       // main subr
009000170420       //=======================================================================
009100150323
009200150323       begsr main;
009300150324
009400170420        setll trust planFile;
009500170420        reade trust planFile;
009600170420
009700170420        dow not %eof;
009800170420
009900170420        if prenew = processMonth;
010000170421         exsr write_acctRecords;
010100170420        endif;
010200150330
010300170420        reade trust planFile;
010400170420        enddo;
010500150326
010600150323       endsr;
010700150430
010800170420       //=======================================================================
010900170421       // write acct records
011000170420       //=======================================================================
011100170420
011200170421       begsr write_acctRecords;
011300170420
011400170424        clear renwFile;
011500170424
011600170420        chain (pltrst : plsub# : plplan) auxFile;
011700170420        if %found ;
011800170420
011900170420         chain (pxtrst : pxsub# : pxacct) acctFile;
012000170420         if %found;
012100170420          if acdltd = 'A';
012200170420           awacct# = %editc(acacct:'X');
012300170420            awname = acnam1;
012400170420             awaddr1 = aaddr1;
012500170420              awaddr2 = aaddr2;
012600170420               awcity = acity;
012700170421               awstate = astate;
012800170424                awzip = %subst(%editc(azip:'X'):1:5);
012900170424               exsr getGroup;
013000170424              exsr write_additionalAddress;
013100170424             write renwFile;
013200170421            exsr write_agentRecords;
013300170421           exsr write_xRefRecords;
013400170420          endif;
013500170420         endif;
013600170420
013700170420        endif;
013800170420
013900170420       endsr;
014000170420
014100170420       //=======================================================================
014200170420       // Get group #
014300170420       //=======================================================================
014400170420
014500170420       begsr getGroup;
014600170420
014700170420       setll (pltrst : plsub# : plplan) groupFile;
014800170420       reade (pltrst : plsub# : plplan) groupFile;
014900170420
015000170420       dow not %eof;
015100170420        if (date_toSearch >= frmdat) and (date_toSearch <= todat);
015200170420         aweffdate = %char(%date(frmdat):*iso);
015300170421           awrendate = %char(%date(date_toSearch2):*iso);
015400170421          exsr getAmounts;
015500170421         leavesr;
015600170420        endif;
015700170420
015800170420       reade (pltrst : plsub# : plplan) groupFile;
015900170420       enddo;
016000170420
016100170420       endsr;
016200170420
016300170421       //=======================================================================
016400170421       // get amounts
016500170421       //=======================================================================
016600170421
016700170421       begsr getAmounts;
016800170421
016900170421       xref (pxtrst : pxsub# : pxacct : plplan);
017000170421
017100170421       if not %open(gratehold);
017200170421        open gratehold;
017300170421       endif;
017400170421
017500170421       count = 0;
017600170421
017700170421       setll *loval ratehFile;
017800170421       read ratehFile;
017900170421
018000170421       dow not %eof;
018100170421
018200170421        count = count + 1;
018300170421
018400170421       read ratehFile;
018500170421       enddo;
018600170421
018700170421       if count <= 3;
018800170421       setll *loval ratehFile;
018900170421       read ratehFile;
019000170421
019100170421       dow not %eof;
019200170421
019300170421        pos = %scan('TIN' : type);
019400170421        if pos > 0;
019500170421         aweonrate = %char(rate);
019600170421        endif;
019700170421
019800170421        pos = %scan('TFA' : type);
019900170421        if pos > 0;
020000170421         awcfmrate = %char(rate);
020100170421        endif;
020200170421
020300170421       read ratehFile;
020400170421       enddo;
020500170421       endif;
020600170421
020700170421       if count = 4;
020800170421       setll *loval ratehFile;
020900170421       read ratehFile;
021000170421
021100170421       dow not %eof;
021200170421
021300170421        pos = %scan('TIN' : type);
021400170421        if pos > 0;
021500170421         aweonrate = %char(rate);
021600170421        endif;
021700170421
021800170421        pos = %scan('THW' : type);
021900170421        if pos > 0;
022000170421         awesprate = %char(rate);
022100170421        endif;
022200170421
022300170421        pos = %scan('TPC' : type);
022400170421        if pos > 0;
022500170421         awechrate = %char(rate);
022600170421        endif;
022700170421
022800170421        pos = %scan('TP2' : type);
022900170421        if pos > 0;
023000170421         awechrate = %char(rate);
023100170421        endif;
023200170421
023300170421        pos = %scan('TFA' : type);
023400170421        if pos > 0;
023500170421         awcfmrate = %char(rate);
023600170421        endif;
023700170421
023800170421       read ratehFile;
023900170421       enddo;
024000170421       endif;
024100170421
024200170421       if %open(gratehold);
024300170421        close gratehold;
024400170421       endif;
024500170421
024600170421       endsr;
024700170421
024800170424       //=======================================================================
024900170424       // write additional records
025000170424       //=======================================================================
025100170424
025200170424       begsr write_additionalAddress;
025300170424
025400170424       chain (pxtrst : pxsub# : pxacct) acct2File;
025500170424       if %found;
025600170424
025700170424       select;
025800170424        when awaddr1 <> a2address1;
025900170424         if a2address1 > ' ';
026000170424          exsr moveAdditional;
026100170424          leavesr;
026200170424         endif;
026300170424
026400170424        when awaddr2 <> a2address2;
026500170424         if a2address2 > ' ';
026600170424          exsr moveAdditional;
026700170424          leavesr;
026800170424         endif;
026900170424
027000170424        when awstate <> a2state;
027100170424         if a2state > ' ';
027200170424          exsr moveAdditional;
027300170424          leavesr;
027400170424         endif;
027500170424
027600170424        when awzip <> %subst(%editc(a2zip5:'X'):1:5);
027700170424         if a2zip5 > 0;
027800170424          exsr moveAdditional;
027900170424          leavesr;
028000170424         endif;
028100170424
028200170424        endsl;
028300170424
028400170424       endif;
028500170424
028600170424       endsr;
028700170424
028800170424       //=======================================================================
028900170424       // write additional acct fields
029000170424       //=======================================================================
029100170424
029200170424       begsr moveAdditional;
029300170424
029400170424       awaname = acnam1;
029500170424       awaaddr1 = a2address1;
029600170425       awaaddr2 = a2address2;
029700170424       awacity = a2city;
029800170424       awastate = a2state;
029900170424       awazip = %subst(%editc(a2zip5:'X'):1:5);
030000170424
030100170424       endsr;
030200170424
030300170421       //=======================================================================
030400170421       // write agent records
030500170421       //=======================================================================
030600170421
030700170421       begsr write_agentRecords;
030800170421
030900170424       clear agentFile;
031000170424
031100170421       chain (pxtrst : pxsub# : pxacct : plplan) commFile;
031200170421       if %found;
031300170421        agagt# = %subst(cmrelid:5:4);
031400170421       endif;
031500170421
031600170421       chain smancd salesmFile;
031700170421       if %found;
031800170421        agname = %trim(sfname) + ' ' + %trim(slname);
031900170421         agaddr1 = saddr;
032000170421          agaddr2 = ' ';
032100170421           agcity = scity;
032200170424            agstate = sstate;
032300170424            agzip = %subst(%editc(szipcd:'X'):1:5);
032400170424           agssn = ' ';
032500170424          agtin = %subst(stin:1:2) + %trim('-') + %subst(stin:3:7);
032600170424         exsr write_additionalAddress2;
032700170421        write agentFile;
032800170421       endif;
032900170421
033000170421       endsr;
033100170421
033200170424       //=======================================================================
033300170424       // write additional records 2
033400170424       //=======================================================================
033500170424
033600170424       begsr write_additionalAddress2;
033700170424
033800170424       chain sgrp sales2File;
033900170424       if %found;
034000170424
034100170424       select;
034200170424        when agaddr1 <> sbrbadd1;
034300170424         if sbrbadd1 > ' ';
034400170424          exsr moveAdditional2;
034500170424          leavesr;
034600170424         endif;
034700170424
034800170424        when agaddr2 <> sbrbadd2;
034900170424         if sbrbadd2 > ' ';
035000170424          exsr moveAdditional2;
035100170424          leavesr;
035200170424         endif;
035300170424
035400170424        when agstate <> sbrbst;
035500170424         if sbrbst > ' ';
035600170424          exsr moveAdditional2;
035700170424          leavesr;
035800170424         endif;
035900170424
036000170424        when agzip <> %subst(%editc(sbrbzip5:'X'):1:5);
036100170424         if sbrbzip5 > 0;
036200170424          exsr moveAdditional2;
036300170424          leavesr;
036400170424         endif;
036500170424
036600170424        endsl;
036700170424
036800170424       endif;
036900170424
037000170424       endsr;
037100170424
037200170424       //=======================================================================
037300170424       // write additional agent records
037400170424       //=======================================================================
037500170424
037600170424       begsr moveAdditional2;
037700170424
037800170424       aganame = agname;
037900170424       agaaddr1 = sbrbadd1;
038000170425       agaaddr2 = sbrbadd2;
038100170424       agacity = sbrbcty;
038200170424       agastate = sbrbst;
038300170424       agazip = %subst(%editc(sbrbzip5:'X'):1:5);
038400170424
038500170424       endsr;
038600170424
038700170421       //=======================================================================
038800170424       // write acct/agent xRef records
038900170421       //=======================================================================
039000170421
039100170421       begsr write_xRefRecords;
039200170424
039300170424       setll (pxtrst : pxsub# : pxacct : plplan) commFile;
039400170424       reade (pxtrst : pxsub# : pxacct : plplan) commFile;
039500170421
039600170424       dow not %eof;
039700170424
039800170424        clear reagtFile;
039900170424
040000170424        xacct# = %editc(acacct:'X');
040100170424        agagt# = %subst(cmrelid:5:4);
040200170424        xagt# = agagt#;
040300170421
040400170424        write reagtFile;
040500170421
040600170424       reade (pxtrst : pxsub# : pxacct : plplan) commFile;
040700170424       enddo;
040800170424
040900170421       endsr;
041000170421
041100170420       //=======================================================================
041200170420       // month to process
041300170420       //=======================================================================
041400170420
041500170420       begsr month_toProcess;
041600170420
041700170420        currentMonth = %subdt(ISOdate : *months);
041800170420
041900170420       endsr;
042000170420
042100170420       //=======================================================================
042200150324       // exit subr
042300170420       //=======================================================================
042400150323
042500150323       begsr exit;
042600150323
042700170420        *inlr = '1';
042800150323        return;
042900150323
043000150323       endsr;
043100150323
043200170420       //=======================================================================
043300150323       // init subr
043400170420       //=======================================================================
043500150323
043600150323       begsr init;
043700150323
043800170510
043900170421        if %parms > 0;
044000170421         processMonth = %dec(month#:2:0);
044100170421          date_toSearch = %dec(%date(%subst(%char(%date):1:8) +
044200170421                        '01':*ISO) + %months(3));
044300170421         exsr month_toProcess;
044400170421
044500170421         if %dec(month#:2:0) < currentMonth;
044600170421           date_toSearch2 = %dec(%date + %years(1));
044700170421             holdDate = %char(date_toSearch2);
044800170421             holdDate = %replace(month#:holdDate:5);
044900170421            holdDate = %replace('01':holdDate:7);
045000170421           date_toSearch2 = %dec(holdDate:8:0);
045100170421         else;
045200170421           date_toSearch2 = %dec(%date());
045300170421             holdDate = %char(date_toSearch2);
045400170421              holdDate = %replace(month#:holdDate:5);
045500170421            holdDate = %replace('01':holdDate:7);
045600170421           date_toSearch2 = %dec(holdDate:8:0);
045700170421         endif;
045800170421
045900170421        else;
046000170421         exsr month_toProcess;
046100170421          processMonth = currentMonth + 3;
046200170421           date_toSearch = %dec(%date(%subst(%char(%date):1:8) +
046300170421                        '01':*ISO) + %months(3));
046400170421           date_toSearch2 = date_toSearch;
046500170421        endif;
046600170420
046700170510
046800170510
046900150323       endsr;
047000150323
047100170420       //=======================================================================
