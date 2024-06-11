000100160513      *===========================================================================
000200160512     H option(*noDebugIo)
000300160513      *===========================================================================
000400180323      * CIGFI010R - Cigna FI - Non Facets Generate extract
000500180313      *================================================================================
000600180313      * Date        Int   Description
000700180313      * ----------  ---   -------------------------------------------------------------
000800180313      * 03/13/2018  jt    Original creation
000900160513      *===========================================================================
001000160512
001100180427     Faccmst    if   e           k disk    extfile('F.ACCMST')
001200180427     F                                     rename(accmsr:actFile)
001300180427
001400180427     Fac2mstl2  if   e           k disk    rename(accmsr2:act2File)
001500180427
001600160516     Fplnmstn1  if   e           k disk    extfile('F.PLNMSTN1')
001700160513
001800160516     Fplnmst    if   e           k disk    extfile('F.PLNMST')
001900160516     F                                     rename(PLNMSR:PLNR) prefix(P)
002000170619
002100180313     Fmcov39    if   e           k disk    extfile('F.MCOV39')
002200170619
002300170619     Fmcovc15   if   e           k disk    extfile('F.MCOVC15')
002400170619     F                                     rename(MCOVR:COVC15)
002500160513
002600160516     Fmcov      if   e           k disk    extfile('F.MCOV')
002700160516     F                                     rename(MCOVR:COVR) Prefix(M)
002800160513
002900180309     Fmember    if   e           k disk    extfile('F.MEMBER')
003000160513
003100160516     Fdepndc    if   e           k disk    extfile('F.DEPNDC')
003200160513
003300160516     Fdcov22    if   e           k disk    extfile('F.DCOV22')
003400160518
003500160518     Fgrate     if   e           k disk    extfile('F.GRATE')
003600160518
003700180313     fcodes     if   e           k disk    extfile('F.CODES')
003800180313     f                                     rename(codesr:codesFile)
003900180313
004000180523     fcaraccp   if   e           k disk    rename(caraccr:setupFile)
004100180523
004200180523     fcarplnm   if   e           k disk    rename(carplnr:planFile)
004300180523
004400180313     fcignafi   uf a e           k disk    rename(cignar:cignaFile)
004500160513
004600180523     fcignatrm  uf a e           k disk    rename(cignatr:termFile)
004700180523
004800160512      *=================================================================
004900061017
005000180309     d carrierCode     s              3
005100180309     d carrierCode1    s              3
005200180309     d carrierCode2    s              3
005300160519     d term_dt_limit   s               d
005400180913     d cancelDate      s               d
005500180913     d cancelh         s              8  0
005600160519     d today           s              8  0
005700180313     d hiredatet       s               d
005800180313     d yrsService      s              8  0
005900180313     d catType         s              3
006000180313     d updateRecord    s              1
006100180313     d writeRecord     s              1
006200180411     d pos             s              2  0
006300180605     d pos2            s              2  0
006400180523     d unique          s             10
006500180523     d alreadySent     s              1
006600180926     d alreadySentM    s              1
006700180926     d alreadySentD    s              1
006800180926     d alreadySentV    s              1
006900180523     d ssn             s              9  0
007000180523     d seq#            s              2  0
007100180523     d ctype           s              3
007200180523     d termdt          s              8  0
007300180523     d covtp           s              2
007400150820
007500160511      //==================================================================
007600160511      // mainline
007700160511      //===================================================================
007800150820
007900160511       exsr init;
008000160511       exsr main;
008100160511       exsr exit;
008200160511
008300160511      //===================================================================
008400160511      // main
008500160511      //===================================================================
008600160511
008700160511       begsr main;
008800160511
008900180309        carrierCode = carrierCode1;
009000180309        exsr main2;
009100180309
009200180309        carrierCode = carrierCode2;
009300180309        exsr main2;
009400180424
009500180424        exsr clearSSN;
009600180424
009700160511       endsr;
009800160511
009900180309      //===================================================================
010000180309      // main2
010100180309      //===================================================================
010200180309
010300180309       begsr main2;
010400180309
010500180309        setll carrierCode plnmsr;
010600180309        reade carrierCode plnmsr;
010700180309
010800180309        dow not %eof;
010900180309
011000180313         setll (pltrst : plsub# : plplan) mcov39;
011100180313         reade (pltrst : plsub# : plplan) mcov39;
011200180313
011300180313         dow not %eof;
011400180309
011500180313          exsr process;
011600180309
011700180313         reade (pltrst : plsub# : plplan) mcov39;
011800180313         enddo;
011900180309
012000180309        reade carrierCode plnmsr;
012100180309        enddo;
012200180309
012300180309       endsr;
012400180309
012500160511      //===================================================================
012600160511      // process
012700160511      //===================================================================
012800160511
012900160511       begsr process;
013000160511
013100180523        chain (unique : pltrst : plsub# : acc#) setupFile;
013200180523        if %found;
013300180523        if castatus = 'Y';
013400180523
013500180523         chain mcssno member;
013600160511
013700180523         chain (pltrst : plsub# : acc# : mcssno : plplan) covc15;
013800170619
013900180523         // if record is termed see if we need to stop sending...
014000180914         if candt > 0;
014100160511
014200180914          term_dt_limit = %date(candt);
014300180914          if %date() > term_dt_limit;
014400180914           leavesr;
014500180914          else;
014600180914           exsr writeMember;
014700180914          endif;
014800160511
014900180914         else;
015000180523          exsr writeMember;
015100180523         endif;
015200160511
015300180523        endif;
015400180523        endif;
015500180523
015600160511       endsr;
015700160511
015800160513      //===================================================================
015900180313      // Write Member
016000160513      //===================================================================
016100160513
016200180313       begsr writeMember;
016300160513
016400180313        updateRecord = 'N';
016500180313        writeRecord = 'N';
016600180313
016700180313        chain
016800180313        (%editc(mbssno:'X'):%editc(mbssno:'X'):%char(birth):mlname:mfname:mmi)
016900180313        cignaFile;
017000180313        if %found;
017100180313         updateRecord = 'Y';
017200180313        else;
017300180313         writeRecord = 'Y';
017400180313        endif;
017500180313
017600180313        exsr determineType;
017700180313        if catType = ' ';
017800180313         leavesr;
017900180313        endif;
018000180313
018100180417        exsr getgrp;
018200160513
018300180313        if writeRecord = 'Y';
018400180313         clear cignaFile;
018500180313        endif;
018600180312
018700180427        chain (pltrst : plsub# : acc#) actFile;
018800180427        if %found;
018900180427         groupnam = acnam1;
019000180427        endif;
019100180427
019200180427        chain (pltrst : plsub# : acc#) act2File;
019300180427        if %found;
019400180427         grouptid = %editc(a2tax_id#:'X');
019500180427        endif;
019600180427
019700180417        policy# = %subst(group#:1:7);
019800180605        pos2 = %scan(' ' : policy# : 1);
019900180605        if pos2 = 7;
020000180605         policy# = %trim('0') + %trim(policy#);
020100180605        endif;
020200180605
020300180312        recid = '01';
020400180312        prkeyty = 'S';
020500180312        memid = %editc(mbssno:'X');
020600180312        lastname = mlname;
020700180313        firstname = mfname;
020800180312        mi = mmi;
020900180312        dateofbth = %char(birth);
021000180312        gender = sex;
021100180424
021200180312        mbrssn = %editc(mbssno:'X');
021300180424        //if mbrssn = '000000000';
021400180424        // mbrssn = ' ';
021500180424        // tssn = ' ';
021600180424        //endif;
021700180312
021800180312        oritype = ' ';
021900180312        orikey = ' ';
022000180312
022100180313        cphone = %editc(area:'X') + %editc(phone:'X');
022200180312        bphone = ' ';
022300180312
022400180312        address1 = addr1;
022500180312        address2 = addr2;
022600180312        ccity = city;
022700180405        cstate = state;
022800180313        czip = %editc(zip:'X');
022900180312        wzip = ' ';
023000180312        ftstdnt = ' ';
023100180312        relcd = 'EE';
023200180312        deceased = ' ';
023300180312        decdate = ' ';
023400180312
023500180313        if hndicp > ' ';
023600180312         disabled = 'H';
023700180312        endif;
023800180312
023900180312        retired = ' ';
024000180312        retdate = ' ';
024100180312        oritype2 = ' ';
024200180312        orikey2 = ' ';
024300180312
024400180312        if salary > 0;
024500180313         cursalary = %char(salary);
024600180312         salfreq = 'A';
024700180312        endif;
024800180312
024900180312        saldate = ' ';
025000180312
025100180312        if empdt > 0;
025200180312         hiredate = %char(empdt);
025300180312          hiredateT = %date(empdt);
025400180312          yrsService = %diff(%date():hiredateT:*years);
025500180312         yrofserv = %char(yrsService);
025600180312        endif;
025700180312
025800180312        email = ' ';
025900180312        eid = ' ';
026000180312
026100180312        oins = ' ';
026200180312        mhicid = ' ';
026300180312
026400180312        covtype = ' ';
026500180312        carrier = ' ';
026600180312        medtype = ' ';
026700180312        oeffdate = ' ';
026800180312        ocandate = ' ';
026900180312        pcode = ' ';
027000180312        fresp = ' ';
027100180312        covtype2 = ' ';
027200180312        carrier2 = ' ';
027300180312        medtype2 = ' ';
027400180312        oeffdate2 = ' ';
027500180312        ocandate2 = ' ';
027600180312        pcode2 = ' ';
027700180312        fresp2 = ' ';
027800180312        policy#2 = ' ';
027900180312        covtype3 = ' ';
028000180312        carrier3 = ' ';
028100180312        medtype3 = ' ';
028200180312        oeffdate3 = ' ';
028300180312        ocandate3 = ' ';
028400180312        pcode3 = ' ';
028500180312        fresp3 = ' ';
028600180312        policy#3 = ' ';
028700180312
028800180313        estatus = ' ';
028900180313        select;
029000180313         when empst = 'A';
029100180313          estatus = 'A';
029200180313         when empst <> 'A';
029300180313          estatus = 'I';
029400180313        endsl;
029500180312
029600180312        estatusdt = ' ';
029700180312
029800180312        tssn = %editc(mbssno:'X');
029900180312
030000180312        eloc = ' ';
030100180313        feditin = %editc(mbssno:'X');
030200180312
030300180313        if catType = 'MED';
030400180405
030500180313         macct# = group#;
030600180605         pos2 = %scan(' ' : macct# : 1);
030700180605         if pos2 = 7;
030800180605          macct# = %trim('0') + %trim(macct#);
030900180605         endif;
031000180605
031100180423         mtype = 'HLT';
031200180313         mcovedate = %char(enrldt);
031300180313
031400180313         if candt > 0;
031500180913          cancelh = candt;
031600180913           exsr sub1_fromDate;
031700180913          mcovcdate = %char(cancelh);
031800180313         endif;
031900180312
032000180313         exsr coverageType;
032100180313
032200180313         if qedt > 0 and empst = 'C';
032300180313          mcbovedate = %char(qedt);
032400180313          mcbpddate = %char(cexpdt);
032500180313         endif;
032600180313
032700180524         exsr getValues;
032800180411
032900180313         mnetid = ' ';
033000180313         medpcpid = ' ';
033100180313         medestpid = ' ';
033200180313         mpnetefdt = ' ';
033300180313         mpeclmedt = ' ';
033400180926
033500180926        exsr checkTerm;
033600180926        if alreadySentM = 'Y';
033700180926         macct# = ' ';
033800180926         mtype = ' ';
033900180926         mplanid = ' ';
034000180926         mbranchcd = ' ';
034100180926         mboptcode = ' ';
034200180926         mcovedate = ' ';
034300180926         mcovcdate = ' ';
034400180926         mecovin = ' ';
034500180926         mscovin = ' ';
034600180926         mccovin = ' ';
034700180926         mcocovin = ' ';
034800180926        endif;
034900180926
035000180313        endif;
035100180312
035200180313        if catType = 'DEN';
035300180313         dacct# = group#;
035400180605         pos2 = %scan(' ' : dacct# : 1);
035500180605         if pos2 = 7;
035600180605          dacct# = %trim('0') + %trim(dacct#);
035700180605         endif;
035800180605
035900180423         dtype = 'DEN';
036000180313         dcovedate = %char(enrldt);
036100180313
036200180313         if candt > 0;
036300180913          cancelh = candt;
036400180913           exsr sub1_fromDate;
036500180913          dcovcdate = %char(cancelh);
036600180313         endif;
036700180313
036800180313         exsr coverageType;
036900180313
037000180313         if qedt > 0 and empst = 'C';
037100180313          dcbovedate = %char(qedt);
037200180313          dcbpddate = %char(cexpdt);
037300180313         endif;
037400180313
037500180524         exsr getValues;
037600180411
037700180926        exsr checkTerm;
037800180926        if alreadySentD = 'Y';
037900180926         dacct# = ' ';
038000180926         dtype = ' ';
038100180926         dplanid = ' ';
038200180926         dbranchcd = ' ';
038300180926         dboptcode = ' ';
038400180926         dcovedate = ' ';
038500180926         dcovcdate = ' ';
038600180926         decovin = ' ';
038700180926         dscovin = ' ';
038800180926         dccovin = ' ';
038900180926         dcocovin = ' ';
039000180926        endif;
039100180313        endif;
039200180411
039300180313        if catType = 'VIS';
039400180313         vacct# = group#;
039500180605         pos2 = %scan(' ' : vacct# : 1);
039600180605         if pos2 = 7;
039700180605          vacct# = %trim('0') + %trim(vacct#);
039800180605         endif;
039900180605
040000180423         vtype = 'VIS';
040100180313         vcovedate = %char(enrldt);
040200180313
040300180313         if candt > 0;
040400180913          cancelh = candt;
040500180913           exsr sub1_fromDate;
040600180913          vcovcdate = %char(cancelh);
040700180313         endif;
040800180313
040900180313         exsr coverageType;
041000180313
041100180313         if qedt > 0 and empst = 'C';
041200180313          vcbovedate = %char(qedt);
041300180313          vcbpddate = %char(cexpdt);
041400180313         endif;
041500180313
041600180524         exsr getValues;
041700180411
041800180926        exsr checkTerm;
041900180926        if alreadySentV = 'Y';
042000180926         vacct# = ' ';
042100180926         vtype = ' ';
042200180926         vplanid = ' ';
042300180926         vbranchcd = ' ';
042400180926         vboptcode = ' ';
042500180926         vcovedate = ' ';
042600180926         vcovcdate = ' ';
042700180926         vecovin = ' ';
042800180926         vscovin = ' ';
042900180926         vccovin = ' ';
043000180926         vcocovin = ' ';
043100180926        endif;
043200180313        endif;
043300180411
043400180523        ssn = mcssno;
043500180523        seq# = 0;
043600180523        ctype = catType;
043700180523        termdt = candt;
043800180523
043900180926        //exsr checkTerm;
044000180926        //if alreadySent = 'N';
044100180926        if alreadySentM = 'N' or alreadySentD = 'N' or alreadySentV = 'N';
044200180523
044300180523         if writeRecord = 'Y';
044400180523          write cignaFile;
044500180523         endif;
044600180523         if updateRecord = 'Y';
044700180523          update cignaFile;
044800180523         endif;
044900180313
045000180523        endif;
045100180523
045200180313        if mcovtp <> 'TIN';
045300180313         exsr dependent;
045400180313        endif;
045500160518
045600160516       endsr;
045700060817
045800180913      //===================================================================
045900180913      // sub 1 from cancel date
046000180913      //===================================================================
046100180913
046200180913       begsr sub1_fromDate;
046300180913
046400180913        cancelDate = %date(cancelh) - %days(1);
046500180913        cancelh = %dec(cancelDate);
046600180913
046700180913       endsr;
046800180913
046900180523      //===================================================================
047000180523      // check termed records;
047100180523      //===================================================================
047200180523
047300180523       begsr checkTerm;
047400180523
047500180926       alreadySentM = 'N';
047600180926       alreadySentD = 'N';
047700180926       alreadySentV = 'N';
047800180523       alreadySent = 'N';
047900180523
048000180523       if termdt > 0;
048100180523
048200180523        chain (pltrst:plsub#:acc#:ssn:seq#:ctype:plplan:termdt) termFile;
048300180523        if %found;
048400180523         alreadySent = 'Y';
048500180926
048600180926         if ctype = 'MED';
048700180926          alreadySentM = 'Y';
048800180926         endif;
048900180926
049000180926         if ctype = 'DEN';
049100180926          alreadySentD = 'Y';
049200180926         endif;
049300180926
049400180926         if ctype = 'VIS';
049500180926          alreadySentV = 'Y';
049600180926         endif;
049700180926
049800180523        endif;
049900180523
050000180523        if not %found;
050100180523         ttrst = pltrst;
050200180523          tsub# = plsub#;
050300180523           tacct = acc#;
050400180524            tssno = ssn;
050500180523             tseq# = seq#;
050600180523             ttype = ctype;
050700180523            tplan = plplan;
050800180523           ttermdt = termdt;
050900180523          ttrnsdt = %dec(%date);
051000180523         write termFile;
051100180523        endif;
051200180523
051300180523       endif;
051400180523
051500180523       endsr;
051600180523
051700180523      //===================================================================
051800180523      // get values
051900180523      //===================================================================
052000180523
052100180523       begsr getValues;
052200180523
052300180523        covtp = %subst(mcovtp:2:2);
052400180523        chain (unique:mbtrst:mbsub#:plplan:mbacct:state:covtp) planFile;
052500180523        if %found;
052600180524         exsr get_valuesCategory;
052700180524         leavesr;
052800180524        endif;
052900180523
053000180523        covtp = %subst(mcovtp:2:2);
053100180523        chain (unique:mbtrst:mbsub#:plplan:mbacct:'ALL':covtp) planFile;
053200180523        if %found;
053300180524         exsr get_valuesCategory;
053400180524         leavesr;
053500180524        endif;
053600180523
053700180525        chain (unique:mbtrst:mbsub#:plplan:mbacct:state:'ALL') planFile;
053800180525        if %found;
053900180525         exsr get_valuesCategory;
054000180525         leavesr;
054100180525        endif;
054200180525
054300180525        chain (unique:mbtrst:mbsub#:plplan:mbacct:'ALL':'ALL') planFile;
054400180525        if %found;
054500180525         exsr get_valuesCategory;
054600180525         leavesr;
054700180525        endif;
054800180525
054900180523       endsr;
055000180523
055100180524      //===================================================================
055200180524      // get values
055300180524      //===================================================================
055400180524
055500180524       begsr get_valuesCategory;
055600180524
055700180524        if catType = 'MED';
055800180524         mplanid = cpcid4;
055900180524          mbranchcd = cpcid3;
056000180524         mboptcode = cpcid2;
056100180524        endif;
056200180524
056300180524        if catType = 'DEN';
056400180524         dplanid = cpcid4;
056500180524          dbranchcd = cpcid3;
056600180524         dboptcode = cpcid2;
056700180524        endif;
056800180524
056900180524        if catType = 'VIS';
057000180524         vplanid = cpcid4;
057100180524          vbranchcd = cpcid3;
057200180524         vboptcode = cpcid2;
057300180524        endif;
057400180524
057500180524       endsr;
057600180411
057700160512      //===================================================================
057800160512      // process
057900160512      //===================================================================
058000160512
058100160512       begsr dependent;
058200160512
058300160512        setll mcssno depenr;
058400160512        reade mcssno depenr;
058500160512
058600160512        dow not %eof;
058700160512
058800180313        chain (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
058900160512        if %found;
059000180313         exsr dependentCoverage;
059100160512        endif;
059200160512
059300160512        reade mcssno depenr;
059400160512        enddo;
059500160512
059600160512    ?  endsr;
059700160512
059800160516      //===============================================================
059900160512      // Dependent coverage
060000160512      //===============================================================
060100160513
060200180313       begsr dependentCoverage;
060300160512
060400180313        setgt (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
060500180313        readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
060600160512
060700160512        dow not %eof;
060800160512
060900180313         if ccandt <> 0;
061000160512
061100160516          term_dt_limit = %date(ccandt);
061200160516          if %date() > term_dt_limit;
061300160512           leavesr;
061400160512          else;
061500160512
061600160516           exsr writeDep;
061700160512          endif;
061800160512
061900160512         else;
062000160516          exsr writeDep;
062100160512          leavesr;
062200160512         endif;
062300160512
062400180313        readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
062500160512        enddo;
062600160512
062700160512       endsr;
062800160512
062900160516      //===============================================================
063000160516      // write dependent
063100160516      //===============================================================
063200160516
063300160516       begsr writeDep;
063400180313
063500180313        updateRecord = 'N';
063600180313        writeRecord = 'N';
063700180313
063800180313        chain
063900180313        (%editc(mbssno:'X'):%editc(depss#:'X'):%char(dbirth):dlname:dfname:dmi)
064000180313        cignaFile;
064100180313        if %found;
064200180313         updateRecord = 'Y';
064300180313        else;
064400180313         writeRecord = 'Y';
064500180313        endif;
064600180313
064700180313        exsr determineType;
064800180313        if catType = ' ';
064900180313         leavesr;
065000180313        endif;
065100180313
065200180313        exsr getgrp;
065300180313
065400180313        if writeRecord = 'Y';
065500180313         clear cignaFile;
065600180313        endif;
065700180313
065800180427        chain (pltrst : plsub# : acc#) actFile;
065900180427        if %found;
066000180427         groupnam = acnam1;
066100180427        endif;
066200180427
066300180427        chain (pltrst : plsub# : acc#) act2File;
066400180427        if %found;
066500180427         grouptid = %editc(a2tax_id#:'X');
066600180427        endif;
066700180427
066800180417        policy# = %subst(group#:1:7);
066900180605        pos2 = %scan(' ' : policy# : 1);
067000180605        if pos2 = 7;
067100180605         policy# = %trim('0') + %trim(policy#);
067200180605        endif;
067300180605
067400180313        recid = '02';
067500180313        prkeyty = 'S';
067600180313        memid = %editc(mbssno:'X');
067700180313        lastname = dlname;
067800180313        firstname = dfname;
067900180313        mi = dmi;
068000180313        dateofbth = %char(dbirth);
068100180313        gender = dsex;
068200180424
068300180313        mbrssn = %editc(depss#:'X');
068400180424        //if mbrssn = '000000000';
068500180424        // mbrssn = ' ';
068600180502           tssn = ' ';
068700180424        //endif;
068800180313
068900180313        oritype = ' ';
069000180313        orikey = ' ';
069100180313
069200180313        cphone = %editc(area:'X') + %editc(phone:'X');
069300180313        bphone = ' ';
069400180313
069500180313        address1 = daddr1;
069600180313        address2 = daddr2;
069700180313        ccity = dcity;
069800180405        cstate = dstate;
069900180313        czip = %editc(dzip:'X');
070000180313        wzip = ' ';
070100180313        ftstdnt = ' ';
070200180313
070300180313        exsr relCodes;
070400180313
070500180313        deceased = ' ';
070600180313        decdate = ' ';
070700180313
070800180313        if dhndcp > ' ';
070900180313         disabled = 'H';
071000180313        endif;
071100180313
071200180313        retired = ' ';
071300180313        retdate = ' ';
071400180313        oritype2 = ' ';
071500180313        orikey2 = ' ';
071600180313
071700180313        cursalary = ' ';
071800180313        salfreq = ' ';
071900180313        saldate = ' ';
072000180313
072100180313        hiredate = ' ';
072200180313        yrofserv = ' ';
072300180313
072400180313        email = ' ';
072500180313        eid = ' ';
072600180313
072700180313        oins = ' ';
072800180313        mhicid = ' ';
072900180313
073000180313        covtype = ' ';
073100180313        carrier = ' ';
073200180313        medtype = ' ';
073300180313        oeffdate = ' ';
073400180313        ocandate = ' ';
073500180313        pcode = ' ';
073600180313        fresp = ' ';
073700180313        covtype2 = ' ';
073800180313        carrier2 = ' ';
073900180313        medtype2 = ' ';
074000180313        oeffdate2 = ' ';
074100180313        ocandate2 = ' ';
074200180313        pcode2 = ' ';
074300180313        fresp2 = ' ';
074400180313        policy#2 = ' ';
074500180313        covtype3 = ' ';
074600180313        carrier3 = ' ';
074700180313        medtype3 = ' ';
074800180313        oeffdate3 = ' ';
074900180313        ocandate3 = ' ';
075000180313        pcode3 = ' ';
075100180313        fresp3 = ' ';
075200180313        policy#3 = ' ';
075300180313
075400180313        estatus = ' ';
075500180313
075600180313        estatusdt = ' ';
075700180313
075800180313        tssn = %editc(depss#:'X');
075900180313
076000180313        eloc = ' ';
076100180313        feditin = %editc(depss#:'X');
076200180313
076300180313        if catType = 'MED';
076400180313         macct# = group#;
076500180605         pos2 = %scan(' ' : macct# : 1);
076600180605         if pos2 = 7;
076700180605          macct# = %trim('0') + %trim(macct#);
076800180605         endif;
076900180605
077000180423          mtype = 'HLT';
077100180313
077200180313         mcovedate = %char(denrdt);
077300180313
077400180607         if denrdt < enrldt;
077500180607          mcovedate = %char(enrldt);
077600180607         endif;
077700180607
077800180607         if dbirth > denrdt;
077900180607          mcovedate = %char(dbirth);
078000180607         endif;
078100180607
078200180523         if ccandt > 0;
078300180913          cancelh = ccandt;
078400180913           exsr sub1_fromDate;
078500180913          mcovcdate = %char(cancelh);
078600180313         endif;
078700180313
078800180313         mecovin = ' ';
078900180313         mscovin = ' ';
079000180313         mccovin = ' ';
079100180313         mcocovin = ' ';
079200180313         decovin = ' ';
079300180313         dscovin = ' ';
079400180313         dccovin = ' ';
079500180313         dcocovin = ' ';
079600180313         vecovin = ' ';
079700180313         vscovin = ' ';
079800180313         vccovin = ' ';
079900180313         vcocovin = ' ';
080000180313
080100180423         exsr coverageType;
080200180423
080300180313         if qedt > 0 and empst = 'C';
080400180313          mcbovedate = %char(qedt);
080500180313          mcbpddate = %char(cexpdt);
080600180313         endif;
080700180313
080800180524         exsr getValues;
080900180411
081000180313         mnetid = ' ';
081100180313         medpcpid = ' ';
081200180313         medestpid = ' ';
081300180313         mpnetefdt = ' ';
081400180313         mpeclmedt = ' ';
081500180926         exsr checkTerm;
081600180926         if alreadySentM = 'Y';
081700180926          macct# = ' ';
081800180926          mtype = ' ';
081900180926          mplanid = ' ';
082000180926          mbranchcd = ' ';
082100180926          mboptcode = ' ';
082200180926          mcovedate = ' ';
082300180926          mcovcdate = ' ';
082400180926          mecovin = ' ';
082500180926          mscovin = ' ';
082600180926          mccovin = ' ';
082700180926          mcocovin = ' ';
082800180926        endif;
082900180926
083000180313        endif;
083100180313
083200180313        if catType = 'DEN';
083300180313         dacct# = group#;
083400180605         pos2 = %scan(' ' : dacct# : 1);
083500180605         if pos2 = 7;
083600180605          dacct# = %trim('0') + %trim(dacct#);
083700180605         endif;
083800180605
083900180423         dtype = 'DEN';
084000180405
084100180313         dcovedate = %char(denrdt);
084200180313
084300180607         if denrdt < enrldt;
084400180607          dcovedate = %char(enrldt);
084500180607         endif;
084600180607
084700180607         if dbirth > denrdt;
084800180607          dcovedate = %char(dbirth);
084900180607         endif;
085000180607
085100180523         if ccandt > 0;
085200180913          cancelh = ccandt;
085300180913           exsr sub1_fromDate;
085400180913          dcovcdate = %char(cancelh);
085500180313         endif;
085600180313
085700180313         exsr coverageType;
085800180313
085900180313         if qedt > 0 and empst = 'C';
086000180313          dcbovedate = %char(qedt);
086100180313          dcbpddate = %char(cexpdt);
086200180313         endif;
086300180313
086400180524         exsr getValues;
086500180411
086600180926         exsr checkTerm;
086700180926         if alreadySentD = 'Y';
086800180926          dacct# = ' ';
086900180926          dtype = ' ';
087000180926          dplanid = ' ';
087100180926          dbranchcd = ' ';
087200180926          dboptcode = ' ';
087300180926          dcovedate = ' ';
087400180926          dcovcdate = ' ';
087500180926          decovin = ' ';
087600180926          dscovin = ' ';
087700180926          dccovin = ' ';
087800180926          dcocovin = ' ';
087900180926         endif;
088000180926
088100180313        endif;
088200180313
088300180313        if catType = 'VIS';
088400180313         vacct# = group#;
088500180605         pos2 = %scan(' ' : vacct# : 1);
088600180605         if pos2 = 7;
088700180605          vacct# = %trim('0') + %trim(vacct#);
088800180605         endif;
088900180605
089000180423         vtype = 'VIS';
089100180313         vcovedate = %char(denrdt);
089200180313
089300180607         if denrdt < enrldt;
089400180607          vcovedate = %char(enrldt);
089500180607         endif;
089600180607
089700180607         if dbirth > denrdt;
089800180607          vcovedate = %char(dbirth);
089900180607         endif;
090000180607
090100180523         if ccandt > 0;
090200180913          cancelh = ccandt;
090300180913           exsr sub1_fromDate;
090400180913          vcovcdate = %char(cancelh);
090500180313         endif;
090600180313
090700180313         exsr coverageType;
090800180313
090900180313         if qedt > 0 and empst = 'C';
091000180313          vcbovedate = %char(qedt);
091100180313          vcbpddate = %char(cexpdt);
091200180313         endif;
091300180313
091400180524         exsr getValues;
091500180411
091600180926         exsr checkTerm;
091700180926         if alreadySentV = 'Y';
091800180926          vacct# = ' ';
091900180926          vtype = ' ';
092000180926          vplanid = ' ';
092100180926          vbranchcd = ' ';
092200180926          vboptcode = ' ';
092300180926          vcovedate = ' ';
092400180926          vcovcdate = ' ';
092500180926          vecovin = ' ';
092600180926          vscovin = ' ';
092700180926          vccovin = ' ';
092800180926          vcocovin = ' ';
092900180926         endif;
093000180926
093100180313        endif;
093200180313
093300180523        ssn = mcssno;
093400180523        seq# = dpseq#;
093500180523        ctype = catType;
093600180523        termdt = ccandt;
093700180523
093800180926        //exsr checkTerm;
093900180926        //if alreadySent = 'N';
094000180926        if alreadySentM = 'N' or alreadySentD = 'N' or alreadySentV = 'N';
094100180523
094200180523         if writeRecord = 'Y';
094300180523          write cignaFile;
094400180523         endif;
094500180523         if updateRecord = 'Y';
094600180523          update cignaFile;
094700180523         endif;
094800160516
094900180523        endif;
095000180523
095100160516       endsr;
095200160511
095300160519      //===================================================================
095400160519      // Get group number
095500160519      //===================================================================
095600160519
095700160519       begsr getgrp;
095800160519
095900160519        setll (pltrst : plsub# : plplan) grater;
096000160519        reade (pltrst : plsub# : plplan) grater;
096100160519
096200160519        dow not %eof;
096300160519
096400160519         if today >= frmdat;
096500160519          if today <= todat;
096600160519           leavesr;
096700160519          else;
096800160519           group# = ' ';
096900160519          endif;
097000160519         endif;
097100160519
097200160519        reade (pltrst : plsub# : plplan) grater;
097300160519        enddo;
097400160519
097500160519    ?  endsr;
097600160519
097700180312      //===================================================================
097800180312      // Coverage Type
097900180312      //===================================================================
098000180312
098100180312       begsr coverageType;
098200180312
098300180313        if catType = 'MED';
098400180313         mecovin = 'N';
098500180313         mscovin = 'N';
098600180313         mccovin = 'N';
098700180313         mcocovin = 'N';
098800180313
098900180313         select;
099000180313          when mcovtp = 'TIN';
099100180313           mecovin = 'Y';
099200180313
099300180313          when mcovtp = 'THW';
099400180313           mecovin = 'Y';
099500180313           mscovin = 'Y';
099600180313
099700180313          when mcovtp = 'TPC' or mcovtp = 'TP2';
099800180313           mecovin = 'Y';
099900180313           mccovin = 'Y';
100000180313
100100180313          when mcovtp = 'TFA';
100200180313           mecovin = 'Y';
100300180313           mscovin = 'Y';
100400180313           mccovin = 'Y';
100500180313         endsl;
100600180313        endif;
100700180312
100800180313        if catType = 'DEN';
100900180313         decovin = 'N';
101000180313         dscovin = 'N';
101100180313         dccovin = 'N';
101200180313         dcocovin = 'N';
101300180313
101400180313         select;
101500180313          when mcovtp = 'TIN';
101600180313           decovin = 'Y';
101700180313
101800180313          when mcovtp = 'THW';
101900180313           decovin = 'Y';
102000180313           dscovin = 'Y';
102100180313
102200180313          when mcovtp = 'TPC' or mcovtp = 'TP2';
102300180313           decovin = 'Y';
102400180313           dccovin = 'Y';
102500180313
102600180313          when mcovtp = 'TFA';
102700180313           decovin = 'Y';
102800180313           dscovin = 'Y';
102900180313           dccovin = 'Y';
103000180313         endsl;
103100180313        endif;
103200180313
103300180313        if catType = 'VIS';
103400180313         vecovin = 'N';
103500180313         vscovin = 'N';
103600180313         vccovin = 'N';
103700180313         vcocovin = 'N';
103800180313
103900180313         select;
104000180313          when mcovtp = 'TIN';
104100180313           vecovin = 'Y';
104200180313
104300180313          when mcovtp = 'THW';
104400180313           vecovin = 'Y';
104500180313           vscovin = 'Y';
104600180313
104700180313          when mcovtp = 'TPC' or mcovtp = 'TP2';
104800180313           vecovin = 'Y';
104900180313           vccovin = 'Y';
105000180313
105100180313          when mcovtp = 'TFA';
105200180313           vecovin = 'Y';
105300180313           vscovin = 'Y';
105400180313           vccovin = 'Y';
105500180313         endsl;
105600180313        endif;
105700180313
105800180312       endsr;
105900180312
106000180313      //===================================================================
106100180313      // Determine Type
106200180313      //===================================================================
106300180313
106400180313       begsr determineType;
106500180313
106600180319        catType = ' ';
106700180313        chain ('P' : %subst(plncat:2:2)) codesFile;
106800180313        if %found;
106900180313
107000180313         select;
107100180313          when action = 'M';
107200180313           catType = 'MED';
107300180313
107400180313          when action = 'D';
107500180313           catType = 'DEN';
107600180313
107700180313          when action = 'V';
107800180313           catType = 'VIS';
107900180313         endsl;
108000180313
108100180313        endif;
108200180313
108300180313       endsr;
108400180313
108500180313      //===================================================================
108600180313      // Relationship Codes
108700180313      //===================================================================
108800180313
108900180313       begsr relCodes;
109000180313
109100180313        select;
109200180313         when drelcd = 'RHU' or drelcd = 'RWI' or drelcd = 'RPA';
109300180313          relcd = 'SP';
109400180313
109500180313         when drelcd = 'RDA' or drelcd = 'RSO';
109600180313          relcd = 'CH';
109700180313
109800180313         when drelcd = 'RDA' or drelcd = 'RSO';
109900180313          relcd = 'CH';
110000180313        endsl;
110100180313
110200180313       endsr;
110300180313
110400180424      //===================================================================
110500180424      // clear ssn
110600180424      //===================================================================
110700180424
110800180424       begsr clearSSN;
110900180424
111000180424        setll *loval cignaFile;
111100180424        read cignaFile;
111200180424        dow  not %eof;
111300180424         if mbrssn = '000000000';
111400180424          mbrssn = ' ';
111500180424           tssn = ' ';
111600180424          update cignaFile;
111700180424         endif;
111800180424
111900180424        read cignaFile;
112000180424        enddo;
112100180424
112200180424       endsr;
112300180424
112400160511      //===================================================================
112500160511      // exit
112600160511      //===================================================================
112700160511
112800160511       begsr exit;
112900160511
113000160511        *inlr = '1';
113100160511        return;
113200160511
113300180523        unique = '0000000251';
113400180523
113500180523        today = %dec(%char(%date:*iso0):8:0);
113600180523
113700160511       endsr;
113800160511
113900160511      //===================================================================
114000160511      // init
114100160511      //===================================================================
114200160520
114300160511       begsr init;
114400160511
114500180309        carrierCode1 = 'CIG';
114600180309        carrierCode2 = 'CID';
114700180523        unique = '0000000251';
114800180309
114900160519        today = %dec(%char(%date:*iso0):8:0);
115000170710
115100160511       endsr;
115200010412
115300160511       //==============================================================
