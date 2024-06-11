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
012000170420           awacct# = %editc(acacct:'X');
012100170615            awname = acnam1;
012200170420             awaddr1 = aaddr1;
012300170420              awaddr2 = aaddr2;
012400170420               awcity = acity;
012500170523                awstate = astate;
012600170523                 awzip = %subst(%editc(azip:'X'):1:5);
012700170523                awtsplan = %editc(pltrst:'X')+%editc(plsub#:'X')+%trim(plplan);
012800170424               exsr getGroup;
012900170424              exsr write_additionalAddress;
013000170424             write renwFile;
013100170421            exsr write_agentRecords;
013200170421           exsr write_xRefRecords;
013300170420          endif;
013400170420         endif;
013500170420
013600170420        endif;
013700170420
013800170420       endsr;
013900170420
014000170420       //=======================================================================
014100170420       // Get group #
014200170420       //=======================================================================
014300170420
014400170420       begsr getGroup;
014500170420
014600170816        setll (pltrst : plsub# : plplan) rateFile;
014700170816        reade (pltrst : plsub# : plplan) ratefile;
014800170420
014900170816        dow not %eof;
015000170816         if (date_toSearch >= frmdat) and (date_toSearch3 <= todat);
015100170816          aweffdate = %char(%date(frmdat):*iso);
015200170816           awrendate = %char(%date(date_toSearch2):*iso);
015300170816            awgroup# = group#;
015400170816           exsr getAmounts;
015500170816          leavesr;
015600170816         endif;
015700170816
015800170816        reade (pltrst : plsub# : plplan) rateFile;
015900170816        enddo;
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
025400170816        chain (pxtrst : pxsub# : pxacct) acct2File;
025500170816        if %found;
025600170816
025700170816        select;
025800170816         when awaddr1 <> a2address1;
025900170816          if a2address1 > ' ';
026000170816           exsr moveAdditional;
026100170816           leavesr;
026200170816          endif;
026300170816
026400170816         when awaddr2 <> a2address2;
026500170816          if a2address2 > ' ';
026600170816           exsr moveAdditional;
026700170816           leavesr;
026800170816          endif;
026900170424
027000170816         when awstate <> a2state;
027100170816          if a2state > ' ';
027200170816           exsr moveAdditional;
027300170816           leavesr;
027400170816          endif;
027500170424
027600170816         when awzip <> %subst(%editc(a2zip5:'X'):1:5);
027700170816          if a2zip5 > 0;
027800170816           exsr moveAdditional;
027900170816           leavesr;
028000170816          endif;
028100170424
028200170816         endsl;
028300170424
028400170816        endif;
028500170424
028600170424       endsr;
028700170424
028800170424       //=======================================================================
028900170424       // write additional acct fields
029000170424       //=======================================================================
029100170424
029200170424       begsr moveAdditional;
029300170424
029400170816        awaname = acnam1;
029500170816        awaaddr1 = a2address1;
029600170816        awaaddr2 = a2address2;
029700170816        awacity = a2city;
029800170816        awastate = a2state;
029900170816        awazip = %subst(%editc(a2zip5:'X'):1:5);
030000170424
030100170424       endsr;
030200170424
030300170421       //=======================================================================
030400170421       // write agent records
030500170421       //=======================================================================
030600170421
030700170421       begsr write_agentRecords;
030800170421
030900170816        clear agentFile;
031000170421
031100170816        setll (pxtrst : pxsub# : pxacct : plplan) commFile;
031200170816        reade (pxtrst : pxsub# : pxacct : plplan) commFile;
031300170816        dow not %eof;
031400170816         if cmdltd = 'A';
031500170816          agagt# = %subst(cmrelid:5:4);
031600170717
031700170816          chain SLSMAN salesmFile;
031800170816          if %found;
031900170816           agname = %trim(sfname) + ' ' + %trim(slname);
032000170816            agaddr1 = saddr;
032100170816             agaddr2 = ' ';
032200170816              agcity = scity;
032300170816               agstate = sstate;
032400170816               agzip = %subst(%editc(szipcd:'X'):1:5);
032500170816              agssn = ' ';
032600170816             agtin = %subst(stin:1:2) + %trim('-') + %subst(stin:3:7);
032700170816            exsr write_additionalAddress2;
032800170616
032900170816            chain (%subst(cmrelid:5:4)) agentFile;
033000170816            if not %found;
033100170816             write agentFile;
033200170816            endif;
033300170816
033400170816          endif;
033500170816
033600170816         endif;
033700170816
033800170816        reade (pxtrst : pxsub# : pxacct : plplan) commFile;
033900170816        enddo;
034000170421
034100170421       endsr;
034200170421
034300170424       //=======================================================================
034400170424       // write additional records 2
034500170424       //=======================================================================
034600170424
034700170424       begsr write_additionalAddress2;
034800170424
034900170816        chain sgrp sales2File;
035000170816        if %found;
035100170816
035200170816        select;
035300170816         when agaddr1 <> sbrbadd1;
035400170816          if sbrbadd1 > ' ';
035500170816           exsr moveAdditional2;
035600170816           leavesr;
035700170816          endif;
035800170816
035900170816          when agaddr2 <> sbrbadd2;
036000170816          if sbrbadd2 > ' ';
036100170816           exsr moveAdditional2;
036200170816           leavesr;
036300170816          endif;
036400170816
036500170816         when agstate <> sbrbst;
036600170816          if sbrbst > ' ';
036700170816           exsr moveAdditional2;
036800170816           leavesr;
036900170816          endif;
037000170424
037100170816         when agzip <> %subst(%editc(sbrbzip5:'X'):1:5);
037200170816          if sbrbzip5 > 0;
037300170816           exsr moveAdditional2;
037400170816           leavesr;
037500170816          endif;
037600170424
037700170816         endsl;
037800170424
037900170816        endif;
038000170424
038100170424       endsr;
038200170424
038300170424       //=======================================================================
038400170424       // write additional agent records
038500170424       //=======================================================================
038600170424
038700170424       begsr moveAdditional2;
038800170424
038900170816        aganame = agname;
039000170816        agaaddr1 = sbrbadd1;
039100170816        agaaddr2 = sbrbadd2;
039200170816        agacity = sbrbcty;
039300170816        agastate = sbrbst;
039400170816        agazip = %subst(%editc(sbrbzip5:'X'):1:5);
039500170424
039600170424       endsr;
039700170424
039800170421       //=======================================================================
039900170424       // write acct/agent xRef records
040000170421       //=======================================================================
040100170421
040200170421       begsr write_xRefRecords;
040300170424
040400170816        setll (pxtrst : pxsub# : pxacct : plplan) commFile;
040500170816        reade (pxtrst : pxsub# : pxacct : plplan) commFile;
040600170816
040700170816        dow not %eof;
040800170816
040900170816         clear reagtFile;
041000170816
041100170816         if cmdltd = 'A';
041200170816          xacct# = %editc(acacct:'X');
041300170816           agagt# = %subst(cmrelid:5:4);
041400170816           xagt# = agagt#;
041500170816          write reagtFile;
041600170816         endif;
041700170421
041800170816        reade (pxtrst : pxsub# : pxacct : plplan) commFile;
041900170816        enddo;
042000170424
042100170421       endsr;
042200170421
042300170420       //=======================================================================
042400170420       // month to process
042500170420       //=======================================================================
042600170420
042700170420       begsr month_toProcess;
042800170420
042900170420        currentMonth = %subdt(ISOdate : *months);
043000170420
043100170420       endsr;
043200170420
043300170420       //=======================================================================
043400150324       // exit subr
043500170420       //=======================================================================
043600150323
043700150323       begsr exit;
043800150323
043900170420        *inlr = '1';
044000150323        return;
044100150323
044200150323       endsr;
044300150323
044400170420       //=======================================================================
044500150323       // init subr
044600170420       //=======================================================================
044700150323
044800150323       begsr init;
044900150323
045000170421        if %parms > 0;
045100170421         processMonth = %dec(month#:2:0);
045200170421          date_toSearch = %dec(%date(%subst(%char(%date):1:8) +
045300170421                        '01':*ISO) + %months(3));
045400170421         exsr month_toProcess;
045500170421
045600170421         if %dec(month#:2:0) < currentMonth;
045700170421           date_toSearch2 = %dec(%date + %years(1));
045800170421             holdDate = %char(date_toSearch2);
045900170421             holdDate = %replace(month#:holdDate:5);
046000170421            holdDate = %replace('01':holdDate:7);
046100170421           date_toSearch2 = %dec(holdDate:8:0);
046200170421         else;
046300170421           date_toSearch2 = %dec(%date());
046400170421             holdDate = %char(date_toSearch2);
046500170421              holdDate = %replace(month#:holdDate:5);
046600170421            holdDate = %replace('01':holdDate:7);
046700170421           date_toSearch2 = %dec(holdDate:8:0);
046800170421         endif;
046900170421
047000170421        else;
047100170421         exsr month_toProcess;
047200170421          processMonth = currentMonth + 3;
047300170421           date_toSearch = %dec(%date(%subst(%char(%date):1:8) +
047400170421                        '01':*ISO) + %months(3));
047500170421           date_toSearch2 = date_toSearch;
047600170421        endif;
047700170420
047800170601           date_toSearch3 = %dec(%date(%subst(%char(%date):1:8) +
047900170601                        '01':*ISO) + %months(3) - %days(1));
048000170601
048100150323       endsr;
048200150323
048300170420       //=======================================================================
