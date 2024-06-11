000100170420      *========================================================================
000200170523     H option(*noDebugIO)
000300150326      *========================================================================
000400170420      * EDTRELETR - EDT Renewal Letter
000500170420      *========================================================================
000600170523
000700170523      * Date      Int   Description
000800170523      * ========  ===   =======================================================
000900170523      * 04/21/17  JT    Original creation
001000170523
001100150326      *========================================================================
001200150323
001300170420     Fplnmst    if   e           k disk    rename(plnmsr:planFile)
001400170420     F                                     extfile('F.PLNMST')
001500170420      * Plan master...
001600150326
001700170420     Faccmst    if   e           k disk    rename(accmsr:acctFile)
001800170420     F                                     extfile('F.ACCMST')
001900170420      * Account master...
002000170420
002100170424     Fac2mstl2  if   e           k disk    rename(accmsr2:acct2File)
002200170424      * Account master...
002300170424
002400170420     Fplnauxp   if   e           k disk    rename(plnauxr:auxFile)
002500170420      * Plan Auxiliary...
002600170420
002700170601     Fgrate     if   e           k disk    rename(grater:rateFile)
002800170420     F                                     extfile('F.GRATE')
002900170420      * Group rate...
003000170420
003100170421     Fsman      if   e           k disk    rename(smanr:salesmFile)
003200170421     F                                     extfile('F.SMAN')
003300170421      * Salesman...
003400170424
003500170424     Fsman2l    if   e           k disk    rename(sman2r:sales2File)
003600170424     F                                     extfile('F.SMAN2L')
003700170424      * Salesman additional info...
003800170421
003900170421     Fcmct14    if   e           k disk    rename(comcxr:commFile)
004000170421     F                                     extfile('F.CMCT14')
004100170421      * Commission...
004200170421
004300170421     Fgratehold if   e           k disk    rename(gratehr:ratehFile)
004400170421     F                                     usropn
004500170421      * Group rate...
004600170421
004700170420     Fedtrelet  o    e             disk    rename(edtrlr:renwFile)
004800170420      * Renewal letter...
004900170421
005000170616     Fedtaginf  if a e           k disk    rename(edtagr:agentFile)
005100170421      * Agent information...
005200170421
005300170421     Fedtrnlag  o    e             disk    rename(edtrnagr:reagtFile)
005400170421      * xRef...
005500170421
005600170420      //=======================================================================
005700170420
005800170420    ?d trust           s              3  0 inz(5)
005900170523     d ISOdate         s               d   datfmt(*iso) inz(*sys)
006000170420    ?d currentMonth    s              2  0
006100170420    ?d processMonth    s              2  0
006200170523    ?d date_toSearch   s              8  0
006300170523    ?d date_toSearch2  s              8  0
006400170601    ?d date_toSearch3  s              8  0
006500170523    ?d holdDate        s              8
006600170523    ?d count           s              1  0
006700170523    ?d pos             s              1  0
006800170420
006900170421     d xRef            pr                  extpgm('ADVXREFR')
007000170421     d  pxtrst                        3  0
007100170421     d  pxsub#                        3  0
007200170421     d  pxacct                        4  0
007300170421     d  plplan                        4
007400170421
007500170523     d edtreletr       pi
007600170424     d  month#                        2
007700170424
007800150430      //=======================================================================
007900150430      // mainline
008000150430      //=======================================================================
008100150323
008200150323       exsr init;
008300150323       exsr main;
008400150323       exsr exit;
008500150323
008600170420       //=======================================================================
008700150323       // main subr
008800170420       //=======================================================================
008900150323
009000150323       begsr main;
009100150324
009200170420        setll trust planFile;
009300170420        reade trust planFile;
009400170420
009500170420        dow not %eof;
009600170420
009700170420        if prenew = processMonth;
009800170421         exsr write_acctRecords;
009900170420        endif;
010000150330
010100170420        reade trust planFile;
010200170420        enddo;
010300150326
010400150323       endsr;
010500150430
010600170420       //=======================================================================
010700170421       // write acct records
010800170420       //=======================================================================
010900170420
011000170421       begsr write_acctRecords;
011100170420
011200170424        clear renwFile;
011300170424
011400170420        chain (pltrst : plsub# : plplan) auxFile;
011500170420        if %found ;
011600170420
011700170420         chain (pxtrst : pxsub# : pxacct) acctFile;
011800170420         if %found;
011900170420          if acdltd = 'A';
012000171114
012100171114            awname = acnam1;
012200171114            awacct# = %editc(acacct:'X');
012300171114           chain (pxtrst : pxsub# : pxacct) acct2File;
012400171114           if %found;
013000171114             awaddr1 = A2ADDRESS1;
013100171114              awaddr2 = A2ADDRESS2;
013200171114               awcity = A2CITY;
013300171114                awstate = A2STATE;
013400171114                 awzip = %editc(A2ZIP5:'X');
013500170523                awtsplan = %editc(pltrst:'X')+%editc(plsub#:'X')+%trim(plplan);
013600170424               exsr getGroup;
013800171114              exsr write_additionalAddressB;
014000170421            exsr write_agentRecords;
014100170421           exsr write_xRefRecords;
014101190319           if cmdltd = 'A';
014102190319             write renwFile;
014103190319          endif;
014200171114          endif;
014300171114
014400170420          endif;
014500170420         endif;
014600170420
014700170420        endif;
014800170420
014900170420       endsr;
015000170420
015100170420       //=======================================================================
015200170420       // Get group #
015300170420       //=======================================================================
015400170420
015500170420       begsr getGroup;
015600170420
015700170816        setll (pltrst : plsub# : plplan) rateFile;
015800170816        reade (pltrst : plsub# : plplan) ratefile;
015900170420
016000170816        dow not %eof;
016100170816         if (date_toSearch >= frmdat) and (date_toSearch3 <= todat);
016200170816          aweffdate = %char(%date(frmdat):*iso);
016300170816           awrendate = %char(%date(date_toSearch2):*iso);
016400170816            awgroup# = group#;
016500170816           exsr getAmounts;
016600170816          leavesr;
016700170816         endif;
016800170816
016900170816        reade (pltrst : plsub# : plplan) rateFile;
017000170816        enddo;
017100170420
017200170420       endsr;
017300170420
017400170421       //=======================================================================
017500170421       // get amounts
017600170421       //=======================================================================
017700170421
017800170421       begsr getAmounts;
017900170421
018000170421       xref (pxtrst : pxsub# : pxacct : plplan);
018100170421
018200170421       if not %open(gratehold);
018300170421        open gratehold;
018400170421       endif;
018500170421
018600170421       count = 0;
018700170421
018800170421       setll *loval ratehFile;
018900170421       read ratehFile;
019000170421
019100170421       dow not %eof;
019200170421
019300170421        count = count + 1;
019400170421
019500170421       read ratehFile;
019600170421       enddo;
019700170421
019800170421       if count <= 3;
019900170421       setll *loval ratehFile;
020000170421       read ratehFile;
020100170421
020200170421       dow not %eof;
020300170421
020400170421        pos = %scan('TIN' : type);
020500170421        if pos > 0;
020600170421         aweonrate = %char(rate);
020700170421        endif;
020800170421
020900170421        pos = %scan('TFA' : type);
021000170421        if pos > 0;
021100170421         awcfmrate = %char(rate);
021200170421        endif;
021300170421
021400170421       read ratehFile;
021500170421       enddo;
021600170421       endif;
021700170421
021800170421       if count = 4;
021900170421       setll *loval ratehFile;
022000170421       read ratehFile;
022100170421
022200170421       dow not %eof;
022300170421
022400170421        pos = %scan('TIN' : type);
022500170421        if pos > 0;
022600170421         aweonrate = %char(rate);
022700170421        endif;
022800170421
022900170421        pos = %scan('THW' : type);
023000170421        if pos > 0;
023100170421         awesprate = %char(rate);
023200170421        endif;
023300170421
023400170421        pos = %scan('TPC' : type);
023500170421        if pos > 0;
023600170421         awechrate = %char(rate);
023700170421        endif;
023800170421
023900170421        pos = %scan('TP2' : type);
024000170421        if pos > 0;
024100170421         awechrate = %char(rate);
024200170421        endif;
024300170421
024400170421        pos = %scan('TFA' : type);
024500170421        if pos > 0;
024600170421         awcfmrate = %char(rate);
024700170421        endif;
024800170421
024900170421       read ratehFile;
025000170421       enddo;
025100170421       endif;
025200170421
025300170421       if %open(gratehold);
025400170421        close gratehold;
025500170421       endif;
025600170421
025700170421       endsr;
025800170421
025900170424       //=======================================================================
026000170424       // write additional records
026100170424       //=======================================================================
026200170424
026300171114       begsr write_additionalAddressB;
026400170816
026500170816        select;
026600171114         when awaddr1 <> AADDR1;
026700171114          if AADDR1 > ' ';
026800170816           exsr moveAdditional;
026900170816           leavesr;
027000170816          endif;
027100170816
027200171114         when awaddr2 <> AADDR2;
027300171114          if AADDR2 > ' ';
027400170816           exsr moveAdditional;
027500170816           leavesr;
027600170816          endif;
027700170424
027800171114         when awstate <> ASTATE;
027900171114          if ASTATE > ' ';
028000170816           exsr moveAdditional;
028100170816           leavesr;
028200170816          endif;
028300170424
028400171114         when awzip <> %subst(%editc(AZIP:'X'):1:5);
028500171114          if AZIP > 0;
028600170816           exsr moveAdditional;
028700170816           leavesr;
028800170816          endif;
028900170424
029000170816         endsl;
029100170424
029200170424
029300170424       endsr;
029400170424
029500171114       //=======================================================================
029600171114       // write additional records
029700171114       //=======================================================================
029800171114
029900171114       begsr write_additionalAddress;
030000171114
030100171114        chain (pxtrst : pxsub# : pxacct) acct2File;
030200171114        if %found;
030300171114
030400171114        select;
030500171114         when awaddr1 <> a2address1;
030600171114          if a2address1 > ' ';
030700171114           exsr moveAdditional;
030800171114           leavesr;
030900171114          endif;
031000171114
031100171114         when awaddr2 <> a2address2;
031200171114          if a2address2 > ' ';
031300171114           exsr moveAdditional;
031400171114           leavesr;
031500171114          endif;
031600171114
031700171114         when awstate <> a2state;
031800171114          if a2state > ' ';
031900171114           exsr moveAdditional;
032000171114           leavesr;
032100171114          endif;
032200171114
032300171114         when awzip <> %subst(%editc(a2zip5:'X'):1:5);
032400171114          if a2zip5 > 0;
032500171114           exsr moveAdditional;
032600171114           leavesr;
032700171114          endif;
032800171114
032900171114         endsl;
033000171114
033100171114        endif;
033200171114
033300171114       endsr;
033400171114
033500170424       //=======================================================================
033600170424       // write additional acct fields
033700170424       //=======================================================================
033800170424
033900170424       begsr moveAdditional;
034000170424
034100170816        awaname = acnam1;
034200171114        awaaddr1 = AADDR1;
034300171114        awaaddr2 = AADDR2;
034400171114        awacity = ACITY;
034500171114        awastate = ASTATE;
034600171114        awazip = %subst(%editc(AZIP:'X'):1:5);
034700170424
034800170424       endsr;
034900170424
035000170421       //=======================================================================
035100170421       // write agent records
035200170421       //=======================================================================
035300170421
035400170421       begsr write_agentRecords;
035500170421
035600170816        clear agentFile;
035700170421
035800170816        setll (pxtrst : pxsub# : pxacct : plplan) commFile;
035900170816        reade (pxtrst : pxsub# : pxacct : plplan) commFile;
036000170816        dow not %eof;
036100170816         if cmdltd = 'A';
036200170816          agagt# = %subst(cmrelid:5:4);
036300170717
036400170816          chain SLSMAN salesmFile;
036500170816          if %found;
036600170816           agname = %trim(sfname) + ' ' + %trim(slname);
036700170816            agaddr1 = saddr;
036800170816             agaddr2 = ' ';
036900170816              agcity = scity;
037000170816               agstate = sstate;
037100170816               agzip = %subst(%editc(szipcd:'X'):1:5);
037200170816              agssn = ' ';
037300170816             agtin = %subst(stin:1:2) + %trim('-') + %subst(stin:3:7);
037400170816            exsr write_additionalAddress2;
037500170616
037600170816            chain (%subst(cmrelid:5:4)) agentFile;
037700170816            if not %found;
037800170816             write agentFile;
037900170816            endif;
038000170816
038100170816          endif;
038200170816
038300170816         endif;
038400170816
038500170816        reade (pxtrst : pxsub# : pxacct : plplan) commFile;
038600170816        enddo;
038700170421
038800170421       endsr;
038900170421
039000170424       //=======================================================================
039100170424       // write additional records 2
039200170424       //=======================================================================
039300170424
039400170424       begsr write_additionalAddress2;
039500170424
039600170816        chain sgrp sales2File;
039700170816        if %found;
039800170816
039900170816        select;
040000170816         when agaddr1 <> sbrbadd1;
040100170816          if sbrbadd1 > ' ';
040200170816           exsr moveAdditional2;
040300170816           leavesr;
040400170816          endif;
040500170816
040600170816          when agaddr2 <> sbrbadd2;
040700170816          if sbrbadd2 > ' ';
040800170816           exsr moveAdditional2;
040900170816           leavesr;
041000170816          endif;
041100170816
041200170816         when agstate <> sbrbst;
041300170816          if sbrbst > ' ';
041400170816           exsr moveAdditional2;
041500170816           leavesr;
041600170816          endif;
041700170424
041800170816         when agzip <> %subst(%editc(sbrbzip5:'X'):1:5);
041900170816          if sbrbzip5 > 0;
042000170816           exsr moveAdditional2;
042100170816           leavesr;
042200170816          endif;
042300170424
042400170816         endsl;
042500170424
042600170816        endif;
042700170424
042800170424       endsr;
042900170424
043000170424       //=======================================================================
043100170424       // write additional agent records
043200170424       //=======================================================================
043300170424
043400170424       begsr moveAdditional2;
043500170424
043600170816        aganame = agname;
043700170816        agaaddr1 = sbrbadd1;
043800170816        agaaddr2 = sbrbadd2;
043900170816        agacity = sbrbcty;
044000170816        agastate = sbrbst;
044100170816        agazip = %subst(%editc(sbrbzip5:'X'):1:5);
044200170424
044300170424       endsr;
044400170424
044500170421       //=======================================================================
044600170424       // write acct/agent xRef records
044700170421       //=======================================================================
044800170421
044900170421       begsr write_xRefRecords;
045000170424
045100170816        setll (pxtrst : pxsub# : pxacct : plplan) commFile;
045200170816        reade (pxtrst : pxsub# : pxacct : plplan) commFile;
045300170816
045400170816        dow not %eof;
045500170816
045600170816         clear reagtFile;
045700170816
045800170816         if cmdltd = 'A';
045900170816          xacct# = %editc(acacct:'X');
046000170816           agagt# = %subst(cmrelid:5:4);
046100170816           xagt# = agagt#;
046200170816          write reagtFile;
046300170816         endif;
046400170421
046500170816        reade (pxtrst : pxsub# : pxacct : plplan) commFile;
046600170816        enddo;
046700170424
046800170421       endsr;
046900170421
047000170420       //=======================================================================
047100170420       // month to process
047200170420       //=======================================================================
047300170420
047400170420       begsr month_toProcess;
047500170420
047600170420        currentMonth = %subdt(ISOdate : *months);
047700170420
047800170420       endsr;
047900170420
048000170420       //=======================================================================
048100150324       // exit subr
048200170420       //=======================================================================
048300150323
048400150323       begsr exit;
048500150323
048600170420        *inlr = '1';
048700150323        return;
048800150323
048900150323       endsr;
049000150323
049100170420       //=======================================================================
049200150323       // init subr
049300170420       //=======================================================================
049400150323
049500150323       begsr init;
049600150323
049700170421        if %parms > 0;
049800170421         processMonth = %dec(month#:2:0);
049900170421          date_toSearch = %dec(%date(%subst(%char(%date):1:8) +
050000170421                        '01':*ISO) + %months(3));
050100170421         exsr month_toProcess;
050200170421
050300170421         if %dec(month#:2:0) < currentMonth;
050400170421           date_toSearch2 = %dec(%date + %years(1));
050500170421             holdDate = %char(date_toSearch2);
050600170421             holdDate = %replace(month#:holdDate:5);
050700170421            holdDate = %replace('01':holdDate:7);
050800170421           date_toSearch2 = %dec(holdDate:8:0);
050900170421         else;
051000170421           date_toSearch2 = %dec(%date());
051100170421             holdDate = %char(date_toSearch2);
051200170421              holdDate = %replace(month#:holdDate:5);
051300170421            holdDate = %replace('01':holdDate:7);
051400170421           date_toSearch2 = %dec(holdDate:8:0);
051500170421         endif;
051600170421
051700170421        else;
051800170421         exsr month_toProcess;
051900170421          processMonth = currentMonth + 3;
052000170421           date_toSearch = %dec(%date(%subst(%char(%date):1:8) +
052100170421                        '01':*ISO) + %months(3));
052200170421           date_toSearch2 = date_toSearch;
052300170421        endif;
052400170420
052500170601           date_toSearch3 = %dec(%date(%subst(%char(%date):1:8) +
052600170601                        '01':*ISO) + %months(3) - %days(1));
052700170601
052800150323       endsr;
052900150323
053000170420       //=======================================================================
