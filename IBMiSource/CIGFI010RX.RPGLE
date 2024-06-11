000100160513      *===========================================================================
000200160512     H option(*noDebugIo)
000300160513      *===========================================================================
000400180323      * CIGFI010R - Cigna FI - Non Facets Generate extract
000500180313      *================================================================================
000600180313      * Date        Int   Description
000700180313      * ----------  ---   -------------------------------------------------------------
000800180313      * 03/13/2018  jt    Original creation
000801201202      * 12/02/2020  jt    Added plan active check from mapping file
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
002100200110     F*mcov39    if   e           k disk    extfile('F.MCOV39')
002101200110     Fmcov42    if   e           k disk    extfile('F.MCOV42')
002200170619
002300190715     F*mcovc17   if   e           k disk    rename(MCOVR:COVC17)
002301200110     F*mcovc16   if   e           k disk    extfile('F.MCOVC16')
002500200110     Fmcovc18   if   e           k disk
002501200110     F                                     rename(mcovr:covc18)
002502200110
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
004400180627     fcignafix  uf a e           k disk    rename(cignar:cignaFile)
004500160513
004600180628     fcignatrmx uf a e           k disk    rename(cignatr:termFile)
004700180523
004800160512      *=================================================================
004900061017
005000180309     d carrierCode     s              3
005100180309     d carrierCode1    s              3
005200180309     d carrierCode2    s              3
005300160519     d term_dt_limit   s               d
005301191031     d cancelDate      s               d
005302191031     d cancelh         s              8  0
005400160519     d today           s              8  0
005500180313     d hiredatet       s               d
005600180313     d yrsService      s              8  0
005700180313     d catType         s              3
005800180313     d updateRecord    s              1
005900180313     d writeRecord     s              1
006000180411     d pos             s              2  0
006100180605     d pos2            s              2  0
006200180523     d unique          s             10
006300180523     d alreadySent     s              1
006301190719     d alreadySentM    s              1
006302190719     d alreadySentV    s              1
006303190719     d alreadySentD    s              1
006400180523     d ssn             s              9  0
006500180523     d seq#            s              2  0
006600180523     d ctype           s              3
006700180523     d termdt          s              8  0
006800180523     d covtp           s              2
006801201202     d planFound       s              1
006900150820
007000190125     d cigfi010rx      pi
007100211216     d  intype                        1
007200190125
007300160511      //==================================================================
007400160511      // mainline
007500160511      //===================================================================
007600150820
007700160511       exsr init;
007800160511       exsr main;
007900160511       exsr exit;
008000160511
008100160511      //===================================================================
008200160511      // main
008300160511      //===================================================================
008400160511
008500160511       begsr main;
008600160511
008700180309        carrierCode = carrierCode1;
008800180309        exsr main2;
008900180309
009000180309        carrierCode = carrierCode2;
009100180309        exsr main2;
009200180424
009300180424        exsr clearSSN;
009301190719        exsr checkFile;
009400180424
009500160511       endsr;
009600160511
009700180309      //===================================================================
009800180309      // main2
009900180309      //===================================================================
010000180309
010100180309       begsr main2;
010200180309
010300180309        setll carrierCode plnmsr;
010400180309        reade carrierCode plnmsr;
010500180309
010600180309        dow not %eof;
010700180309
010800200110         setll (pltrst : plsub# : plplan) mcov42;
010801200110         reade (pltrst : plsub# : plplan) mcov42;
010802200110
011100180313         dow not %eof;
011200180309
011300180313          exsr process;
011400180309
011401200110         reade (pltrst : plsub# : plplan) mcov42;
011600180313         enddo;
011700180309
011800180309        reade carrierCode plnmsr;
011900180309        enddo;
012000180309
012100180309       endsr;
012200180309
012300160511      //===================================================================
012400160511      // process
012500160511      //===================================================================
012600160511
012700160511       begsr process;
012800160511
012900180523        chain (unique : pltrst : plsub# : acc#) setupFile;
013000180523        if %found;
013100190125        if castatus = intype;
013200180523
013300180523         chain mcssno member;
013400160511
013500190715         //chain (pltrst : plsub# : acc# : mcssno : plplan) covc17;
013600200110        setll (pltrst : plsub# : acc# : mcssno) covc18;
013601200110        reade (pltrst : plsub# : acc# : mcssno) covc18;
013602200110        dow not %eof;
013603200110          if plplan = mcplan;
013700180523         // if record is termed see if we need to stop sending...
013800190715         if candt > 0;
013900160511
014000180523          term_dt_limit = %date(candt);
014100190508          if %date() > term_dt_limit + %days(60);
014200180523           leavesr;
014300180523          else;
014400180523           exsr writeMember;
014500180523          endif;
014600160511
014700180523         else;
014800180523          exsr writeMember;
014900180523         endif;
014901200110
014902200110         endif;
015000200110        reade (pltrst : plsub# : acc# : mcssno) covc18;
015001190715        enddo;
015100180523        endif;
015200180523        endif;
015300180523
015400160511       endsr;
015500160511
015600160513      //===================================================================
015700180313      // Write Member
015800160513      //===================================================================
015900160513
016000180313       begsr writeMember;
016100160513
016200180313        updateRecord = 'N';
016300180313        writeRecord = 'N';
016400180313
016500180313        chain
016600180313        (%editc(mbssno:'X'):%editc(mbssno:'X'):%char(birth):mlname:mfname:mmi)
016700180313        cignaFile;
016800180313        if %found;
016900180313         updateRecord = 'Y';
017000180313        else;
017100180313         writeRecord = 'Y';
017200191031         alreadySentM = 'N';
017201191031         alreadySentD = 'N';
017202191031         alreadySentV = 'N';
017203191031        endif;
017300180313
017400180313        exsr determineType;
017500180313        if catType = ' ';
017600180313         leavesr;
017700180313        endif;
017800180313
017801210401
017802200702        if policy# = ' ';
017803200702         exsr getgrp;
017804200702        endif;
017805200702
018100180313        if writeRecord = 'Y';
018200180313         clear cignaFile;
018300180313        endif;
018400180312
018403200702        //policy# = %subst(group#:1:7);
018404200702        //pos2 = %scan(' ' : policy# : 1);
018405200702        //if pos2 = 7;
018406200702        // policy# = %trim('0') + %trim(policy#);
018407200702        //endif;
018408200702
018500180427        chain (pltrst : plsub# : acc#) actFile;
018600180427        if %found;
018700180427         groupnam = acnam1;
018800180427        endif;
018900180427
019000180427        chain (pltrst : plsub# : acc#) act2File;
019100180427        if %found;
019200180427         grouptid = %editc(a2tax_id#:'X');
019300180427        endif;
019400180427
020100180312        recid = '01';
020200180312        prkeyty = 'S';
020300180312        memid = %editc(mbssno:'X');
020400180312        lastname = mlname;
020500180313        firstname = mfname;
020600180312        mi = mmi;
020700180312        dateofbth = %char(birth);
020800180312        gender = sex;
020900180424
021000180312        mbrssn = %editc(mbssno:'X');
021100180424        //if mbrssn = '000000000';
021200180424        // mbrssn = ' ';
021300180424        // tssn = ' ';
021400180424        //endif;
021500180312
021600180312        oritype = ' ';
021700180312        orikey = ' ';
021800180312
021900180313        cphone = %editc(area:'X') + %editc(phone:'X');
022000180312        bphone = ' ';
022100180312
022200180312        address1 = addr1;
022300180312        address2 = addr2;
022400180312        ccity = city;
022500180405        cstate = state;
022600180313        czip = %editc(zip:'X');
022700180312        wzip = ' ';
022800180312        ftstdnt = ' ';
022900180312        relcd = 'EE';
023000180312        deceased = ' ';
023100180312        decdate = ' ';
023200180312
023300180313        if hndicp > ' ';
023400180312         disabled = 'H';
023500180312        endif;
023600180312
023700180312        retired = ' ';
023800180312        retdate = ' ';
023900180312        oritype2 = ' ';
024000180312        orikey2 = ' ';
024100180312
024200180312        if salary > 0;
024300180313         cursalary = %char(salary);
024400180312         salfreq = 'A';
024500180312        endif;
024600180312
024700180312        saldate = ' ';
024800180312
024900180312        if empdt > 0;
025000180312         hiredate = %char(empdt);
025100180312          hiredateT = %date(empdt);
025200180312          yrsService = %diff(%date():hiredateT:*years);
025300180312         yrofserv = %char(yrsService);
025400180312        endif;
025500180312
025600180312        email = ' ';
025700180312        eid = ' ';
025800180312
025900180312        oins = ' ';
026000180312        mhicid = ' ';
026100180312
026200180312        covtype = ' ';
026300180312        carrier = ' ';
026400180312        medtype = ' ';
026500180312        oeffdate = ' ';
026600180312        ocandate = ' ';
026700180312        pcode = ' ';
026800180312        fresp = ' ';
026900180312        covtype2 = ' ';
027000180312        carrier2 = ' ';
027100180312        medtype2 = ' ';
027200180312        oeffdate2 = ' ';
027300180312        ocandate2 = ' ';
027400180312        pcode2 = ' ';
027500180312        fresp2 = ' ';
027600180312        policy#2 = ' ';
027700180312        covtype3 = ' ';
027800180312        carrier3 = ' ';
027900180312        medtype3 = ' ';
028000180312        oeffdate3 = ' ';
028100180312        ocandate3 = ' ';
028200180312        pcode3 = ' ';
028300180312        fresp3 = ' ';
028400180312        policy#3 = ' ';
028500180312
028600180313        estatus = ' ';
028700180313        select;
028800180313         when empst = 'A';
028900180313          estatus = 'A';
029000180313         when empst <> 'A';
029100180313          estatus = 'I';
029200180313        endsl;
029300180312
029400180312        estatusdt = ' ';
029500180312
029600180312        tssn = %editc(mbssno:'X');
029700180312
029800180312        eloc = ' ';
029900180313        feditin = %editc(mbssno:'X');
030000180312
030100180313        if catType = 'MED';
030101191031         ctype = catType;
030200190719         termdt = candt;
030202190719         seq# = 0;
030203191031         ssn = mcssno;
030204190719         exsr checkTerm;
030205191031         //alreadySentM = alreadySent;
030207190719         if alreadySentM = 'N';
030208190719
030300180313         macct# = group#;
030400180605         pos2 = %scan(' ' : macct# : 1);
030500180605         if pos2 = 7;
030600180605          macct# = %trim('0') + %trim(macct#);
030601200702         endif;
030602200702
030603200702         if policy# = ' ';
030604200702          policy# = macct#;
030605200702         endif;
030800180605
030801191031         if mcovedate > ' ' and mcovcdate = ' ';
030802191031          updateRecord = 'N';
030803191031         endif;
030805191031
030900180423         mtype = 'HLT';
030901191031
031000180313         mcovedate = %char(enrldt);
031001191031
031100191031         mcovcdate = ' ';
031101191031         if candt > 0;
031102191031          cancelh = candt;
031103191031           exsr sub1_fromDate;
031104191031          mcovcdate = %char(cancelh);
031105191031
031200191031          if candt = enrldt;
031300191031           mcovcdate = %char(candt);
031400191031          endif;
031401191031
031500191031         endif;
031501191031
031600180313         exsr coverageType;
031700180313
031800180313         if qedt > 0 and empst = 'C';
031900180313          mcbovedate = %char(qedt);
032000180313          mcbpddate = %char(cexpdt);
032100180313         endif;
032200180313
032300180524         exsr getValues;
032400180411
032500180313         mnetid = ' ';
032600180313         medpcpid = ' ';
032700180313         medestpid = ' ';
032800180313         mpnetefdt = ' ';
032900180313         mpeclmedt = ' ';
033000180313        endif;
033001190719        endif;
033100180312
033200180313        if catType = 'DEN';
033201191031         ctype = catType;
033202190719         termdt = candt;
033203190719         seq# = 0;
033204191031         ssn = mcssno;
033205190719         exsr checkTerm;
033206191031         //alreadySentD = alreadySent;
033207190719         if alreadySentD = 'N';
033208190719
033300180313         dacct# = group#;
033400180605         pos2 = %scan(' ' : dacct# : 1);
033500180605         if pos2 = 7;
033600180605          dacct# = %trim('0') + %trim(dacct#);
033601200702         endif;
033602200702
033603200702         if policy# = ' ';
033604200702          policy# = dacct#;
033605200702         endif;
033701191031
033800191031         if dcovedate > ' ' and dcovcdate = ' ';
033801191031          updateRecord = 'N';
033802191031         endif;
033803191031
033900180423         dtype = 'DEN';
033901191031
034000180313         dcovedate = %char(enrldt);
034100180313
034101191031         dcovcdate = ' ';
034102191031         if candt > 0;
034103191031          cancelh = candt;
034104191031           exsr sub1_fromDate;
034105191031          dcovcdate = %char(cancelh);
034106191031
034200191031          if candt = enrldt;
034300191031           dcovcdate = %char(candt);
034400191031          endif;
034500180313
034501191031         endif;
034502191031
034600180313         exsr coverageType;
034700180313
034800180313         if qedt > 0 and empst = 'C';
034900180313          dcbovedate = %char(qedt);
035000180313          dcbpddate = %char(cexpdt);
035100180313         endif;
035200180313
035300180524         exsr getValues;
035400180411
035500180313        endif;
035501190719        endif;
035600180411
035700180313        if catType = 'VIS';
035701191031         ctype = catType;
035702190719         termdt = candt;
035703190719         seq# = 0;
035704191031         ssn = mcssno;
035705190719         exsr checkTerm;
035706191031         //alreadySentV = alreadySent;
035707190719         if alreadySentV = 'N';
035708190719
035800180313         vacct# = group#;
035900180605         pos2 = %scan(' ' : vacct# : 1);
036000180605         if pos2 = 7;
036100180605          vacct# = %trim('0') + %trim(vacct#);
036101200702         endif;
036102200702
036103200702         if policy# = ' ';
036104200702          policy# = vacct#;
036105200702         endif;
036300180605
036301191031         if vcovedate > ' ' and vcovcdate = ' ';
036302191031          updateRecord = 'N';
036303191031         endif;
036304191031
036400180423         vtype = 'VIS';
036401191031
036500180313         vcovedate = %char(enrldt);
036501191031
036600191031         vcovcdate = ' ';
036601191031         if candt > 0;
036602191031          cancelh = candt;
036603191031           exsr sub1_fromDate;
036604191031          vcovcdate = %char(cancelh);
036605191031
036700191031          if candt = enrldt;
036800191031           vcovcdate = %char(candt);
036900191031          endif;
036901191031
036902191031         endif;
037000180313
037100180313         exsr coverageType;
037200180313
037300180313         if qedt > 0 and empst = 'C';
037400180313          vcbovedate = %char(qedt);
037500180313          vcbpddate = %char(cexpdt);
037600180313         endif;
037700180313
037800180524         exsr getValues;
037900180411
037901190719        endif;
038000180313        endif;
038100180411
038200180523        ssn = mcssno;
038300180523        seq# = 0;
038400180523        ctype = catType;
038500180523        termdt = candt;
038600180523
038700190719        //exsr checkTerm;
038800190719        //if alreadySent = 'N';
038900190719        if alreadySentM = 'N' or alreadySentD = 'N' or alreadySentV = 'N';
038901201202         if planFound = 'Y';
039000201202          if writeRecord = 'Y';
039100201202           write cignaFile;
039200201202          endif;
039201190719
039300201202          if updateRecord = 'Y';
039400201202           update cignaFile;
039500201202          endif;
039501201202         endif;
039502201202
039600201202        exsr setFlags;
039700180523        endif;
039800180523
039900180313        if mcovtp <> 'TIN';
040000180313         exsr dependent;
040100180313        endif;
040200160518
040300160516       endsr;
040400060817
040401191031      //===================================================================
040402191031      // sub 1 from cancel date
040403191031      //===================================================================
040404191031
040405191031       begsr sub1_fromDate;
040406191031
040407191031        cancelDate = %date(cancelh) - %days(1);
040408191031        cancelh = %dec(cancelDate);
040409191031
040410191031       endsr;
040411191031
040500180523      //===================================================================
040600180523      // check termed records;
040700180523      //===================================================================
040800180523
040900180523       begsr checkTerm;
041000180523
041100191031       //alreadySent = 'N';
041200191031       alreadySentM = 'N';
041201191031       alreadySentD = 'N';
041202191031       alreadySentV = 'N';
041203191031
041300180523       if termdt > 0;
041400180523
041500180523        chain (pltrst:plsub#:acc#:ssn:seq#:ctype:plplan:termdt) termFile;
041600180523        if %found;
041601191031
041602191031         if ctype = 'MED';
041603191031          alreadySentM = 'Y';
041604191031         endif;
041605191031
041606191031         if ctype = 'DEN';
041607191031          alreadySentD = 'Y';
041608191031         endif;
041609191031
041610191031         if ctype = 'VIS';
041611191031          alreadySentV = 'Y';
041612191031         endif;
041613191031
041900191031        endif;
042000180523
042001191031        if not %found;
042002191031         if termdt > %dec(%date);
042016191031           leavesr;
042019191031         endif;
042020191031        endif;
042021191031
042100180523        if not %found;
042200180523         ttrst = pltrst;
042300180523          tsub# = plsub#;
042400180523           tacct = acc#;
042500180524            tssno = ssn;
042600180523             tseq# = seq#;
042700180523             ttype = ctype;
042800180523            tplan = plplan;
042900180523           ttermdt = termdt;
043000180523          ttrnsdt = %dec(%date);
043100180523         write termFile;
043200180523        endif;
043300180523
043400180523       endif;
043500180523
043600180523       endsr;
043700180523
043800180523      //===================================================================
043900180523      // get values
044000180523      //===================================================================
044100180523
044200180523       begsr getValues;
044300180523
044301201202        planFound = 'N';
044302201202
044400180523        covtp = %subst(mcovtp:2:2);
044500180523        chain (unique:mbtrst:mbsub#:plplan:mbacct:state:covtp) planFile;
044600180523        if %found;
044601201202         planFound = 'Y';
044700201202          exsr get_valuesCategory;
044800180524         leavesr;
044900180524        endif;
045000180523
045100180523        covtp = %subst(mcovtp:2:2);
045200180523        chain (unique:mbtrst:mbsub#:plplan:mbacct:'ALL':covtp) planFile;
045300180523        if %found;
045301201202         planFound = 'Y';
045400201202          exsr get_valuesCategory;
045500180524         leavesr;
045600180524        endif;
045700180523
045800180525        chain (unique:mbtrst:mbsub#:plplan:mbacct:state:'ALL') planFile;
045900180525        if %found;
045901201202         planFound = 'Y';
046000201202          exsr get_valuesCategory;
046100180525         leavesr;
046200180525        endif;
046300180525
046400180525        chain (unique:mbtrst:mbsub#:plplan:mbacct:'ALL':'ALL') planFile;
046500180525        if %found;
046501201202         planFound = 'Y';
046600201202          exsr get_valuesCategory;
046700180525         leavesr;
046800180525        endif;
046900180525
047000180523       endsr;
047100180523
047101191031      //===================================================================
047102191031      // setflags
047103191031      //===================================================================
047104191031
047105191031       begsr setFlags;
047106191031
047107191031        if catType = 'MED';
047108191031         alreadySentM = 'Y';
047109191031        endif;
047110191031
047111191031        if catType = 'DEN';
047112191031         alreadySentD = 'Y';
047113191031        endif;
047114191031
047115191031        if catType = 'VIS';
047116191031         alreadySentV = 'Y';
047117191031        endif;
047118191031
047119191031       endsr;
047120191031
047200180524      //===================================================================
047300180524      // get values
047400180524      //===================================================================
047500180524
047600180524       begsr get_valuesCategory;
047700180524
047800180524        if catType = 'MED';
047900180524         mplanid = cpcid4;
048000180524          mbranchcd = cpcid3;
048100180524         mboptcode = cpcid2;
048200180524        endif;
048300180524
048400180524        if catType = 'DEN';
048500180524         dplanid = cpcid4;
048600180524          dbranchcd = cpcid3;
048700180524         dboptcode = cpcid2;
048800180524        endif;
048900180524
049000180524        if catType = 'VIS';
049100180524         vplanid = cpcid4;
049200180524          vbranchcd = cpcid3;
049300180524         vboptcode = cpcid2;
049400180524        endif;
049500180524
049600180524       endsr;
049700180524
073000160512      //===================================================================
073100160512      // process
073200160512      //===================================================================
073300160512
073400160512       begsr dependent;
073500160512
073600160512        setll mcssno depenr;
073700160512        reade mcssno depenr;
073800160512
073900160512        dow not %eof;
074000160512
074100180313        chain (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
074200160512        if %found;
074300180313         exsr dependentCoverage;
074400160512        endif;
074500160512
074600160512        reade mcssno depenr;
074700160512        enddo;
074800160512
074900190719       endsr;
075000160512
075100160516      //===============================================================
075200160512      // Dependent coverage
075300160512      //===============================================================
075400160513
075500180313       begsr dependentCoverage;
075600160512
075700180313        setgt (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
075800180313        readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
075900160512
076000160512        dow not %eof;
076100160512
076200180313         if ccandt <> 0;
076300160512
076400160516          term_dt_limit = %date(ccandt);
076500160516          if %date() > term_dt_limit;
076600160512           leavesr;
076700160512          else;
076800160512
076900160516           exsr writeDep;
077000160512          endif;
077100160512
077200160512         else;
077300160516          exsr writeDep;
077400160512          leavesr;
077500160512         endif;
077600160512
077700180313        readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
077800160512        enddo;
077900160512
078000160512       endsr;
078100160512
078200160516      //===============================================================
078300160516      // write dependent
078400160516      //===============================================================
078500160516
078600160516       begsr writeDep;
078700180313
078800180313        updateRecord = 'N';
078900180313        writeRecord = 'N';
079000180313
079100180313        chain
079200180313        (%editc(mbssno:'X'):%editc(depss#:'X'):%char(dbirth):dlname:dfname:dmi)
079300180313        cignaFile;
079400180313        if %found;
079500180313         updateRecord = 'Y';
079600180313        else;
079700180313         writeRecord = 'Y';
079701191031         alreadySentM = 'N';
079702191031         alreadySentD = 'N';
079703191031         alreadySentV = 'N';
079800180313        endif;
079900180313
080000180313        exsr determineType;
080100180313        if catType = ' ';
080200180313         leavesr;
080300180313        endif;
080400180313
080500180313        exsr getgrp;
080600180313
080700180313        if writeRecord = 'Y';
080800180313         clear cignaFile;
080900180313        endif;
081000180313
081100180427        chain (pltrst : plsub# : acc#) actFile;
081200180427        if %found;
081300180427         groupnam = acnam1;
081400180427        endif;
081500180427
081600180427        chain (pltrst : plsub# : acc#) act2File;
081700180427        if %found;
081800180427         grouptid = %editc(a2tax_id#:'X');
081900180427        endif;
082000180427
082100200702        //policy# = %subst(group#:1:7);
082200200702        //pos2 = %scan(' ' : policy# : 1);
082300200702        //if pos2 = 7;
082400200702        // policy# = %trim('0') + %trim(policy#);
082500200702        //endif;
082600180605
082700180313        recid = '02';
082800180313        prkeyty = 'S';
082900180313        memid = %editc(mbssno:'X');
083000180313        lastname = dlname;
083100180313        firstname = dfname;
083200180313        mi = dmi;
083300180313        dateofbth = %char(dbirth);
083400180313        gender = dsex;
083500180424
083600180313        mbrssn = %editc(depss#:'X');
083700180424        //if mbrssn = '000000000';
083800180424        // mbrssn = ' ';
083900180502           tssn = ' ';
084000180424        //endif;
084100180313
084200180313        oritype = ' ';
084300180313        orikey = ' ';
084400180313
084500180313        cphone = %editc(area:'X') + %editc(phone:'X');
084600180313        bphone = ' ';
084700180313
084800180313        address1 = daddr1;
084900180313        address2 = daddr2;
085000180313        ccity = dcity;
085100180405        cstate = dstate;
085200180313        czip = %editc(dzip:'X');
085300180313        wzip = ' ';
085400180313        ftstdnt = ' ';
085500180313
085600180313        exsr relCodes;
085700180313
085800180313        deceased = ' ';
085900180313        decdate = ' ';
086000180313
086100180313        if dhndcp > ' ';
086200180313         disabled = 'H';
086300180313        endif;
086400180313
086500180313        retired = ' ';
086600180313        retdate = ' ';
086700180313        oritype2 = ' ';
086800180313        orikey2 = ' ';
086900180313
087000180313        cursalary = ' ';
087100180313        salfreq = ' ';
087200180313        saldate = ' ';
087300180313
087400180313        hiredate = ' ';
087500180313        yrofserv = ' ';
087600180313
087700180313        email = ' ';
087800180313        eid = ' ';
087900180313
088000180313        oins = ' ';
088100180313        mhicid = ' ';
088200180313
088300180313        covtype = ' ';
088400180313        carrier = ' ';
088500180313        medtype = ' ';
088600180313        oeffdate = ' ';
088700180313        ocandate = ' ';
088800180313        pcode = ' ';
088900180313        fresp = ' ';
089000180313        covtype2 = ' ';
089100180313        carrier2 = ' ';
089200180313        medtype2 = ' ';
089300180313        oeffdate2 = ' ';
089400180313        ocandate2 = ' ';
089500180313        pcode2 = ' ';
089600180313        fresp2 = ' ';
089700180313        policy#2 = ' ';
089800180313        covtype3 = ' ';
089900180313        carrier3 = ' ';
090000180313        medtype3 = ' ';
090100180313        oeffdate3 = ' ';
090200180313        ocandate3 = ' ';
090300180313        pcode3 = ' ';
090400180313        fresp3 = ' ';
090500180313        policy#3 = ' ';
090600180313
090700180313        estatus = ' ';
090800180313
090900180313        estatusdt = ' ';
091000180313
091100180313        tssn = %editc(depss#:'X');
091200180313
091300180313        eloc = ' ';
091400180313        feditin = %editc(depss#:'X');
091500180313
091600180313        if catType = 'MED';
091601190719        ssn = mcssno;
091602190719        seq# = dpseq#;
091603190719        ctype = catType;
091604190719        termdt = ccandt;
091605190719        exsr checkTerm;
091606191031        //alreadySentM = alreadySent;
091607190719
091608190719        if alreadySentM = 'N';
091609190719
091700180313         macct# = group#;
091800180605         pos2 = %scan(' ' : macct# : 1);
091900180605         if pos2 = 7;
092000180605          macct# = %trim('0') + %trim(macct#);
092001200702         endif;
092002200702
092003200702         if policy# = ' ';
092004200702          policy# = macct#;
092005200702         endif;
092301191031
092400191031         if mcovedate > ' ' and  mcovcdate = ' ';
092401191031          updateRecord = 'N';
092402191031         endif;
092403191031
092404191031         mtype = 'HLT';
092405191031
092500180313         mcovedate = %char(denrdt);
092600180313
092700180607         if denrdt < enrldt;
092800180607          mcovedate = %char(enrldt);
092900180607         endif;
093000180607
093100180607         if dbirth > denrdt;
093200180607          mcovedate = %char(dbirth);
093300180607         endif;
093400180607
093500191031         mcovcdate = ' ';
093501191031         if ccandt > 0;
093502191031          cancelh = ccandt;
093503191031           exsr sub1_fromDate;
093504191031          mcovcdate = %char(cancelh);
093505191031
093506191031          if ccandt = denrdt;
093507191031           mcovcdate = %char(candt);
093508191031          endif;
093509191031
093510191031         endif;
093800180313
093900180313         mecovin = ' ';
094000180313         mscovin = ' ';
094100180313         mccovin = ' ';
094200180313         mcocovin = ' ';
094300180313         decovin = ' ';
094400180313         dscovin = ' ';
094500180313         dccovin = ' ';
094600180313         dcocovin = ' ';
094700180313         vecovin = ' ';
094800180313         vscovin = ' ';
094900180313         vccovin = ' ';
095000180313         vcocovin = ' ';
095100180313
095200180423         exsr coverageType;
095300180423
095400180313         if qedt > 0 and empst = 'C';
095500180313          mcbovedate = %char(qedt);
095600180313          mcbpddate = %char(cexpdt);
095700180313         endif;
095800180313
095900180524         exsr getValues;
096000180411
096100180313         mnetid = ' ';
096200180313         medpcpid = ' ';
096300180313         medestpid = ' ';
096400180313         mpnetefdt = ' ';
096500180313         mpeclmedt = ' ';
096600180313        endif;
096601190719        endif;
096700180313
096800180313        if catType = 'DEN';
096801190719        ssn = mcssno;
096802190719        seq# = dpseq#;
096803190719        ctype = catType;
096804190719        termdt = ccandt;
096805190719        exsr checkTerm;
096806191031        //alreadySentD = alreadySent;
096807190719
096808190719        if alreadySentD = 'N';
096900180523         //dplanid = '42803';
097000180313         dacct# = group#;
097100180605         pos2 = %scan(' ' : dacct# : 1);
097200180605         if pos2 = 7;
097300180605          dacct# = %trim('0') + %trim(dacct#);
097301200702         endif;
097302200702
097303200702         if policy# = ' ';
097304200702          policy# = dacct#;
097305200702         endif;
097500180605
097501191031         if dcovedate > ' ' and dcovcdate = ' ';
097502191031          updateRecord = 'N';
097503191031         endif;
097504191031
097600180423         dtype = 'DEN';
097700180405
097800180313         dcovedate = %char(denrdt);
097900180313
098000180607         if denrdt < enrldt;
098100180607          dcovedate = %char(enrldt);
098200180607         endif;
098300180607
098400180607         if dbirth > denrdt;
098500180607          dcovedate = %char(dbirth);
098600180607         endif;
098700180607
098701191031         dcovcdate = ' ';
098800191031         if ccandt > 0;
098801191031          cancelh = ccandt;
098802191031           exsr sub1_fromDate;
098803191031          dcovcdate = %char(cancelh);
098804191031
098805191031          if ccandt = denrdt;
098806191031           dcovcdate = %char(candt);
098807191031          endif;
098808191031
099000180313         endif;
099001191031
099100191031         decovin = ' ';
099101191031         dscovin = ' ';
099102191031         dccovin = ' ';
099103191031         dcocovin = ' ';
099104191031
099200180313         exsr coverageType;
099300180313
099400180313         if qedt > 0 and empst = 'C';
099500180313          dcbovedate = %char(qedt);
099600180313          dcbpddate = %char(cexpdt);
099700180313         endif;
099800180313
099900180524         exsr getValues;
099901190719
099902190719        endif;
100100180313        endif;
100200180313
100300180313        if catType = 'VIS';
100301190719        ssn = mcssno;
100302190719        seq# = dpseq#;
100303190719        ctype = catType;
100304190719        termdt = ccandt;
100305190719        exsr checkTerm;
100306191031        //alreadySentV = alreadySent;
100307190719
100308190719        if alreadySentV = 'N';
100400180313         vacct# = group#;
100500180605         pos2 = %scan(' ' : vacct# : 1);
100600180605         if pos2 = 7;
100700180605          vacct# = %trim('0') + %trim(vacct#);
100701200702         endif;
100702200702
100703200702         if policy# = ' ';
100704200702          policy# = vacct#;
100705200702         endif;
100801191031
100900191031         if vcovedate > ' ' and vcovcdate = ' ';
100901191031          updateRecord = 'N';
100902191031         endif;
100903191031
101000180423         vtype = 'VIS';
101001191031
101100180313         vcovedate = %char(denrdt);
101200180313
101300180607         if denrdt < enrldt;
101400180607          vcovedate = %char(enrldt);
101500180607         endif;
101600180607
101700180607         if dbirth > denrdt;
101800180607          vcovedate = %char(dbirth);
101900180607         endif;
102000180607
102001191031         vcovcdate = ' ';
102100180523         if ccandt > 0;
102200191031          cancelh = ccandt;
102201191031           exsr sub1_fromDate;
102202191031          vcovcdate = %char(cancelh);
102203191031
102204191031          if ccandt = denrdt;
102205191031           vcovcdate = %char(candt);
102206191031          endif;
102207191031
102208191031         endif;
102209191031
102210191031         vecovin = ' ';
102211191031         vscovin = ' ';
102212191031         vccovin = ' ';
102213191031         vcocovin = ' ';
102500180313         exsr coverageType;
102600180313
102700180313         if qedt > 0 and empst = 'C';
102800180313          vcbovedate = %char(qedt);
102900180313          vcbpddate = %char(cexpdt);
103000180313         endif;
103100180313
103200180524         exsr getValues;
103300180411
103301190719        endif;
103400180313        endif;
103500180313
103600190719        //ssn = mcssno;
103700190719        //seq# = dpseq#;
103800190719        //ctype = catType;
103900190719        //termdt = ccandt;
104000180523
104100190719        //exsr checkTerm;
104200190719        //if alreadySent = 'N';
104300180523
104301191031        if alreadySentM = 'N' or alreadySentD = 'N' or alreadySentV = 'N';
104302201202         if planFound = 'Y';
104400201202          if writeRecord = 'Y';
104500201202           write cignaFile;
104600201202          endif;
104601190719
104700201202          if updateRecord = 'Y';
104800201202           update cignaFile;
104900201202          endif;
104901201202         endif;
104902201202
104903201202        exsr setFlags;
105100180523        endif;
105200180523
105300160516       endsr;
105400160511
105500160519      //===================================================================
105600160519      // Get group number
105700160519      //===================================================================
105800160519
105900160519       begsr getgrp;
106000160519
106100160519        setll (pltrst : plsub# : plplan) grater;
106200160519        reade (pltrst : plsub# : plplan) grater;
106300160519
106400160519        dow not %eof;
106500160519
106600160519         if today >= frmdat;
106700160519          if today <= todat;
106800160519           leavesr;
106900160519          else;
107000160519           group# = ' ';
107100160519          endif;
107200160519         endif;
107300160519
107400160519        reade (pltrst : plsub# : plplan) grater;
107500160519        enddo;
107600160519
107700190719       endsr;
107800160519
107900180312      //===================================================================
108000180312      // Coverage Type
108100180312      //===================================================================
108200180312
108300180312       begsr coverageType;
108400180312
108500180313        if catType = 'MED';
108600180313         mecovin = 'N';
108700180313         mscovin = 'N';
108800180313         mccovin = 'N';
108900180313         mcocovin = 'N';
109000180313
109100180313         select;
109200180313          when mcovtp = 'TIN';
109300180313           mecovin = 'Y';
109400180313
109500180313          when mcovtp = 'THW';
109600180313           mecovin = 'Y';
109700180313           mscovin = 'Y';
109800180313
109900180313          when mcovtp = 'TPC' or mcovtp = 'TP2';
110000180313           mecovin = 'Y';
110100180313           mccovin = 'Y';
110200180313
110300180313          when mcovtp = 'TFA';
110400180313           mecovin = 'Y';
110500180313           mscovin = 'Y';
110600180313           mccovin = 'Y';
110700180313         endsl;
110800180313        endif;
110900180312
111000180313        if catType = 'DEN';
111100180313         decovin = 'N';
111200180313         dscovin = 'N';
111300180313         dccovin = 'N';
111400180313         dcocovin = 'N';
111500180313
111600180313         select;
111700180313          when mcovtp = 'TIN';
111800180313           decovin = 'Y';
111900180313
112000180313          when mcovtp = 'THW';
112100180313           decovin = 'Y';
112200180313           dscovin = 'Y';
112300180313
112400180313          when mcovtp = 'TPC' or mcovtp = 'TP2';
112500180313           decovin = 'Y';
112600180313           dccovin = 'Y';
112700180313
112800180313          when mcovtp = 'TFA';
112900180313           decovin = 'Y';
113000180313           dscovin = 'Y';
113100180313           dccovin = 'Y';
113200180313         endsl;
113300180313        endif;
113400180313
113500180313        if catType = 'VIS';
113600180313         vecovin = 'N';
113700180313         vscovin = 'N';
113800180313         vccovin = 'N';
113900180313         vcocovin = 'N';
114000180313
114100180313         select;
114200180313          when mcovtp = 'TIN';
114300180313           vecovin = 'Y';
114400180313
114500180313          when mcovtp = 'THW';
114600180313           vecovin = 'Y';
114700180313           vscovin = 'Y';
114800180313
114900180313          when mcovtp = 'TPC' or mcovtp = 'TP2';
115000180313           vecovin = 'Y';
115100180313           vccovin = 'Y';
115200180313
115300180313          when mcovtp = 'TFA';
115400180313           vecovin = 'Y';
115500180313           vscovin = 'Y';
115600180313           vccovin = 'Y';
115700180313         endsl;
115800180313        endif;
115900180313
116000180312       endsr;
116100180312
116200180313      //===================================================================
116300180313      // Determine Type
116400180313      //===================================================================
116500180313
116600180313       begsr determineType;
116700180313
116800180319        catType = ' ';
116900180313        chain ('P' : %subst(plncat:2:2)) codesFile;
117000180313        if %found;
117100180313
117200180313         select;
117300180313          when action = 'M';
117400180313           catType = 'MED';
117500180313
117600180313          when action = 'D';
117700180313           catType = 'DEN';
117800180313
117900180313          when action = 'V';
118000180313           catType = 'VIS';
118100180313         endsl;
118200180313
118300180313        endif;
118400180313
118500180313       endsr;
118600180313
118700180313      //===================================================================
118800180313      // Relationship Codes
118900180313      //===================================================================
119000180313
119100180313       begsr relCodes;
119200180313
119300180313        select;
119400180313         when drelcd = 'RHU' or drelcd = 'RWI' or drelcd = 'RPA';
119500180313          relcd = 'SP';
119600180313
119700180313         when drelcd = 'RDA' or drelcd = 'RSO';
119800180313          relcd = 'CH';
119900180313
120000180313         when drelcd = 'RDA' or drelcd = 'RSO';
120100180313          relcd = 'CH';
120200180313        endsl;
120300180313
120400180313       endsr;
120500180313
120600180424      //===================================================================
120700180424      // clear ssn
120800180424      //===================================================================
120900180424
121000180424       begsr clearSSN;
121100180424
121200180424        setll *loval cignaFile;
121300180424        read cignaFile;
121400180424        dow  not %eof;
121500180424         if mbrssn = '000000000';
121600180424          mbrssn = ' ';
121700180424           tssn = ' ';
121800180424          update cignaFile;
121900180424         endif;
122000180424
122100180424        read cignaFile;
122200180424        enddo;
122300180424
122400180424       endsr;
122500180424
122600190719      //===================================================================
122601190719      // clear file
122602190719      //===================================================================
122603190719
122604190719       begsr checkFile;
122605190719
122606190719        setll *loval cignaFile;
122607190719        read cignaFile;
122608190719        dow  not %eof;
122609190719
122610190719        if MACCT# = ' ' and  MTYPE  = ' ' and  MPLANID = ' ' and
122611190719            MBRANCHCD = ' ' and MBOPTCODE = ' ' and  MCOVEDATE = ' ' and
122612190719            MCOVCDATE = ' ' and  MECOVIN = ' ' and  MSCOVIN = ' ' and
122613190719             MCCOVIN  = ' ' and  MCOCOVIN = ' ' and
122614190719
122615190719           dACCT# = ' ' and  dTYPE  = ' ' and  dPLANID = ' ' and
122616190719            dBRANCHCD = ' ' and dBOPTCODE = ' ' and  dCOVEDATE = ' ' and
122617190719            dCOVCDATE = ' ' and  dECOVIN = ' ' and  dSCOVIN = ' ' and
122618190719             dCCOVIN  = ' ' and  dCOCOVIN = ' ' and
122619190719
122620190719           vACCT# = ' ' and  vTYPE  = ' ' and  vPLANID = ' ' and
122621190719            vBRANCHCD = ' ' and vBOPTCODE = ' ' and  vCOVEDATE = ' ' and
122622190719            vCOVCDATE = ' ' and  vECOVIN = ' ' and  vSCOVIN = ' ' and
122623190719             vCCOVIN  = ' ' and  vCOCOVIN = ' ';
122624190719           delete cignaFile;
122625190719           endif;
122626190719
122627190719        read cignaFile;
122628190719        enddo;
122629190719
122630190719       endsr;
122631190719
122632190719      //===================================================================
122700160511      // exit
122800160511      //===================================================================
122900160511
123000160511       begsr exit;
123100160511
123200160511        *inlr = '1';
123300160511        return;
123400160511
123500180523        unique = '0000000251';
123600180523
123700180523        today = %dec(%char(%date:*iso0):8:0);
123800180523
123900160511       endsr;
124000160511
124100160511      //===================================================================
124200160511      // init
124300160511      //===================================================================
124400160520
124500160511       begsr init;
124600160511
124700180309        carrierCode1 = 'CIG';
124800180309        carrierCode2 = 'CID';
124900180523        unique = '0000000251';
125000180309
125100160519        today = %dec(%char(%date:*iso0):8:0);
125101211216
125102211216        if intype = 'F';
125103211216         intype = 'P';
125104211216        endif;
125200170710
125300160511       endsr;
125400010412
125500160511       //==============================================================
