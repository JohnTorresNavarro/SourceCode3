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
012200170615            //awname = %scanrpl(',' : ' ' : acnam1);
012300170420             awaddr1 = aaddr1;
012400170420              awaddr2 = aaddr2;
012500170420               awcity = acity;
012600170523                awstate = astate;
012700170523                 awzip = %subst(%editc(azip:'X'):1:5);
012800170523                awtsplan = %editc(pltrst:'X')+%editc(plsub#:'X')+%trim(plplan);
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
014700170601       setll (pltrst : plsub# : plplan) rateFile;
014800170601       reade (pltrst : plsub# : plplan) ratefile;
014900170420
015000170420       dow not %eof;
015100170601        if (date_toSearch >= frmdat) and (date_toSearch3 <= todat);
015200170420         aweffdate = %char(%date(frmdat):*iso);
015300170725          awrendate = %char(%date(date_toSearch2):*iso);
015400170725           awgroup# = group#;
015500170421          exsr getAmounts;
015600170421         leavesr;
015700170420        endif;
015800170420
015900170601       reade (pltrst : plsub# : plplan) rateFile;
016000170420       enddo;
016100170420
016200170420       endsr;
016300170420
016400170421       //=======================================================================
016500170421       // get amounts
016600170421       //=======================================================================
016700170421
016800170421       begsr getAmounts;
016900170421
017000170421       xref (pxtrst : pxsub# : pxacct : plplan);
017100170421
017200170421       if not %open(gratehold);
017300170421        open gratehold;
017400170421       endif;
017500170421
017600170421       count = 0;
017700170421
017800170421       setll *loval ratehFile;
017900170421       read ratehFile;
018000170421
018100170421       dow not %eof;
018200170421
018300170421        count = count + 1;
018400170421
018500170421       read ratehFile;
018600170421       enddo;
018700170421
018800170421       if count <= 3;
018900170421       setll *loval ratehFile;
019000170421       read ratehFile;
019100170421
019200170421       dow not %eof;
019300170421
019400170421        pos = %scan('TIN' : type);
019500170421        if pos > 0;
019600170421         aweonrate = %char(rate);
019700170421        endif;
019800170421
019900170421        pos = %scan('TFA' : type);
020000170421        if pos > 0;
020100170421         awcfmrate = %char(rate);
020200170421        endif;
020300170421
020400170421       read ratehFile;
020500170421       enddo;
020600170421       endif;
020700170421
020800170421       if count = 4;
020900170421       setll *loval ratehFile;
021000170421       read ratehFile;
021100170421
021200170421       dow not %eof;
021300170421
021400170421        pos = %scan('TIN' : type);
021500170421        if pos > 0;
021600170421         aweonrate = %char(rate);
021700170421        endif;
021800170421
021900170421        pos = %scan('THW' : type);
022000170421        if pos > 0;
022100170421         awesprate = %char(rate);
022200170421        endif;
022300170421
022400170421        pos = %scan('TPC' : type);
022500170421        if pos > 0;
022600170421         awechrate = %char(rate);
022700170421        endif;
022800170421
022900170421        pos = %scan('TP2' : type);
023000170421        if pos > 0;
023100170421         awechrate = %char(rate);
023200170421        endif;
023300170421
023400170421        pos = %scan('TFA' : type);
023500170421        if pos > 0;
023600170421         awcfmrate = %char(rate);
023700170421        endif;
023800170421
023900170421       read ratehFile;
024000170421       enddo;
024100170421       endif;
024200170421
024300170421       if %open(gratehold);
024400170421        close gratehold;
024500170421       endif;
024600170421
024700170421       endsr;
024800170421
024900170424       //=======================================================================
025000170424       // write additional records
025100170424       //=======================================================================
025200170424
025300170424       begsr write_additionalAddress;
025400170424
025500170424       chain (pxtrst : pxsub# : pxacct) acct2File;
025600170424       if %found;
025700170424
025800170424       select;
025900170424        when awaddr1 <> a2address1;
026000170424         if a2address1 > ' ';
026100170424          exsr moveAdditional;
026200170424          leavesr;
026300170424         endif;
026400170424
026500170424        when awaddr2 <> a2address2;
026600170424         if a2address2 > ' ';
026700170424          exsr moveAdditional;
026800170424          leavesr;
026900170424         endif;
027000170424
027100170424        when awstate <> a2state;
027200170424         if a2state > ' ';
027300170424          exsr moveAdditional;
027400170424          leavesr;
027500170424         endif;
027600170424
027700170424        when awzip <> %subst(%editc(a2zip5:'X'):1:5);
027800170424         if a2zip5 > 0;
027900170424          exsr moveAdditional;
028000170424          leavesr;
028100170424         endif;
028200170424
028300170424        endsl;
028400170424
028500170424       endif;
028600170424
028700170424       endsr;
028800170424
028900170424       //=======================================================================
029000170424       // write additional acct fields
029100170424       //=======================================================================
029200170424
029300170424       begsr moveAdditional;
029400170424
029500170615       awaname = acnam1;
029600170615       //awaname = %scanrpl(',' : ' ' : acnam1);
029700170424       awaaddr1 = a2address1;
029800170425       awaaddr2 = a2address2;
029900170424       awacity = a2city;
030000170424       awastate = a2state;
030100170424       awazip = %subst(%editc(a2zip5:'X'):1:5);
030200170424
030300170424       endsr;
030400170424
030500170421       //=======================================================================
030600170421       // write agent records
030700170421       //=======================================================================
030800170421
030900170421       begsr write_agentRecords;
031000170421
031100170424       clear agentFile;
031200170424
031300170717       //chain (pxtrst : pxsub# : pxacct : plplan) commFile;
031400170717       //if %found;
031500170717       // agagt# = %subst(cmrelid:5:4);
031600170717       //endif;
031700170421
031800170717       setll (pxtrst : pxsub# : pxacct : plplan) commFile;
031900170717       reade (pxtrst : pxsub# : pxacct : plplan) commFile;
032000170717       dow not %eof;
032100170717        if cmdltd = 'A';
032200170717         agagt# = %subst(cmrelid:5:4);
032300170815         //leave;
032400170816        //endif;
032500170815       //reade (pxtrst : pxsub# : pxacct : plplan) commFile;
032600170815       //enddo;
032700170717
032800170815       //chain smancd salesmFile;
032900170815       chain SLSMAN salesmFile;
033000170421       if %found;
033100170421        agname = %trim(sfname) + ' ' + %trim(slname);
033200170421         agaddr1 = saddr;
033300170421          agaddr2 = ' ';
033400170421           agcity = scity;
033500170424            agstate = sstate;
033600170424            agzip = %subst(%editc(szipcd:'X'):1:5);
033700170424           agssn = ' ';
033800170424          agtin = %subst(stin:1:2) + %trim('-') + %subst(stin:3:7);
033900170424         exsr write_additionalAddress2;
034000170616
034100170616         chain (%subst(cmrelid:5:4)) agentFile;
034200170616         if not %found;
034300170616          write agentFile;
034400170616         endif;
034500170616
034600170421       endif;
034700170815
034800170816       endif;
034900170815       reade (pxtrst : pxsub# : pxacct : plplan) commFile;
035000170815       enddo;
035100170421
035200170421       endsr;
035300170421
035400170424       //=======================================================================
035500170424       // write additional records 2
035600170424       //=======================================================================
035700170424
035800170424       begsr write_additionalAddress2;
035900170424
036000170424       chain sgrp sales2File;
036100170424       if %found;
036200170424
036300170424       select;
036400170424        when agaddr1 <> sbrbadd1;
036500170424         if sbrbadd1 > ' ';
036600170424          exsr moveAdditional2;
036700170424          leavesr;
036800170424         endif;
036900170424
037000170424        when agaddr2 <> sbrbadd2;
037100170424         if sbrbadd2 > ' ';
037200170424          exsr moveAdditional2;
037300170424          leavesr;
037400170424         endif;
037500170424
037600170424        when agstate <> sbrbst;
037700170424         if sbrbst > ' ';
037800170424          exsr moveAdditional2;
037900170424          leavesr;
038000170424         endif;
038100170424
038200170424        when agzip <> %subst(%editc(sbrbzip5:'X'):1:5);
038300170424         if sbrbzip5 > 0;
038400170424          exsr moveAdditional2;
038500170424          leavesr;
038600170424         endif;
038700170424
038800170424        endsl;
038900170424
039000170424       endif;
039100170424
039200170424       endsr;
039300170424
039400170424       //=======================================================================
039500170424       // write additional agent records
039600170424       //=======================================================================
039700170424
039800170424       begsr moveAdditional2;
039900170424
040000170424       aganame = agname;
040100170424       agaaddr1 = sbrbadd1;
040200170425       agaaddr2 = sbrbadd2;
040300170424       agacity = sbrbcty;
040400170424       agastate = sbrbst;
040500170424       agazip = %subst(%editc(sbrbzip5:'X'):1:5);
040600170424
040700170424       endsr;
040800170424
040900170421       //=======================================================================
041000170424       // write acct/agent xRef records
041100170421       //=======================================================================
041200170421
041300170421       begsr write_xRefRecords;
041400170424
041500170424       setll (pxtrst : pxsub# : pxacct : plplan) commFile;
041600170424       reade (pxtrst : pxsub# : pxacct : plplan) commFile;
041700170421
041800170424       dow not %eof;
041900170424
042000170424        clear reagtFile;
042100170424
042200170718        if cmdltd = 'A';
042300170718         xacct# = %editc(acacct:'X');
042400170718          agagt# = %subst(cmrelid:5:4);
042500170718          xagt# = agagt#;
042600170718         write reagtFile;
042700170718        endif;
042800170421
042900170424       reade (pxtrst : pxsub# : pxacct : plplan) commFile;
043000170424       enddo;
043100170424
043200170421       endsr;
043300170421
043400170420       //=======================================================================
043500170420       // month to process
043600170420       //=======================================================================
043700170420
043800170420       begsr month_toProcess;
043900170420
044000170420        currentMonth = %subdt(ISOdate : *months);
044100170420
044200170420       endsr;
044300170420
044400170420       //=======================================================================
044500150324       // exit subr
044600170420       //=======================================================================
044700150323
044800150323       begsr exit;
044900150323
045000170420        *inlr = '1';
045100150323        return;
045200150323
045300150323       endsr;
045400150323
045500170420       //=======================================================================
045600150323       // init subr
045700170420       //=======================================================================
045800150323
045900150323       begsr init;
046000150323
046100170421        if %parms > 0;
046200170421         processMonth = %dec(month#:2:0);
046300170421          date_toSearch = %dec(%date(%subst(%char(%date):1:8) +
046400170421                        '01':*ISO) + %months(3));
046500170421         exsr month_toProcess;
046600170421
046700170421         if %dec(month#:2:0) < currentMonth;
046800170421           date_toSearch2 = %dec(%date + %years(1));
046900170421             holdDate = %char(date_toSearch2);
047000170421             holdDate = %replace(month#:holdDate:5);
047100170421            holdDate = %replace('01':holdDate:7);
047200170421           date_toSearch2 = %dec(holdDate:8:0);
047300170421         else;
047400170421           date_toSearch2 = %dec(%date());
047500170421             holdDate = %char(date_toSearch2);
047600170421              holdDate = %replace(month#:holdDate:5);
047700170421            holdDate = %replace('01':holdDate:7);
047800170421           date_toSearch2 = %dec(holdDate:8:0);
047900170421         endif;
048000170421
048100170421        else;
048200170421         exsr month_toProcess;
048300170421          processMonth = currentMonth + 3;
048400170421           date_toSearch = %dec(%date(%subst(%char(%date):1:8) +
048500170421                        '01':*ISO) + %months(3));
048600170421           date_toSearch2 = date_toSearch;
048700170421        endif;
048800170420
048900170601           date_toSearch3 = %dec(%date(%subst(%char(%date):1:8) +
049000170601                        '01':*ISO) + %months(3) - %days(1));
049100170601
049200150323       endsr;
049300150323
049400170420       //=======================================================================
