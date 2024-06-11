000100160513      *===========================================================================
000200160512     H option(*noDebugIo)
000300160513      *===========================================================================
000400180323      * CIGFI010R - Cigna FI - Non Facets Generate extract
000500180313      *================================================================================
000600180313      * Date        Int   Description
000700180313      * ----------  ---   -------------------------------------------------------------
000800180313      * 03/13/2018  jt    Original creation
000801200707      * 07/07/2020  jt    Fixed issue with policy#
000802201202      * 12/02/2020  jt    Check for plan being active in mapping file.
000803211112      * 11/29/2021  jt    Recomliled to use AACODE instead of AACODEL1
000804211202      * 12/02/2021  jt    Added new status to prevent both Proclaim/Facets to be sent
000900160513      *===========================================================================
001000160512
001100180427     Faccmst    if   e           k disk    extfile('F.ACCMST')
001200211112     F                                     rename(accmsr:actFile) prefix(M)
001300180427
001400180427     Fac2mstl2  if   e           k disk    rename(accmsr2:act2File)
001500180427
001600160516     Fplnmstn1  if   e           k disk    extfile('F.PLNMSTN1')
001700160513
001800160516     Fplnmst    if   e           k disk    extfile('F.PLNMST')
001900160516     F                                     rename(PLNMSR:PLNR) prefix(P)
002000170619
002100200128     F*mcov39    if   e           k disk    extfile('F.MCOV39')
002101200128     Fmcov42    if   e           k disk    extfile('F.MCOV42')
002200170619
002300190611     F*mcovc17   if   e           k disk    rename(mcovr:covc17)
002400200128     F*mcovc16   if   e           k disk    extfile('F.MCOVC16')
002500200128     F*                                     rename(mcovr:covc16)
002501190923     F*mcovc18   if   e           k disk    rename(mcovr:covc18)
002502200128     Fmcov44    if   e           k disk
002503200128     F                                     rename(mcovr:covc44)
002504200128
002600160513
002700160516     Fmcov      if   e           k disk    extfile('F.MCOV')
002800160516     F                                     rename(MCOVR:COVR) Prefix(M)
002900160513
003000180309     Fmember    if   e           k disk    extfile('F.MEMBER')
003100160513
003200160516     Fdepndc    if   e           k disk    extfile('F.DEPNDC')
003300160513
003400160516     Fdcov22    if   e           k disk    extfile('F.DCOV22')
003500160518
003600160518     Fgrate     if   e           k disk    extfile('F.GRATE')
003700160518
003800180313     fcodes     if   e           k disk    extfile('F.CODES')
003900180313     f                                     rename(codesr:codesFile)
004000190514
004100211112     faacode    if   e           k disk    rename(aacodr:aaFile)
004200180313
004300180523     fcaraccp   if   e           k disk    rename(caraccr:setupFile)
004400180523
004500180523     fcarplnm   if   e           k disk    rename(carplnr:planFile)
004600180523
004700180313     fcignafi   uf a e           k disk    rename(cignar:cignaFile)
004800160513
004900180523     fcignatrm  uf a e           k disk    rename(cignatr:termFile)
005000190514
005100190514     fcignafier o    e             disk    rename(cignaer:errorFile)
005200180523
005300160512      *=================================================================
005400061017
005500180309     d carrierCode     s              3
005600180309     d carrierCode1    s              3
005700180309     d carrierCode2    s              3
005800160519     d term_dt_limit   s               d
005900180913     d cancelDate      s               d
006000180913     d cancelh         s              8  0
006100160519     d today           s              8  0
006200180313     d hiredatet       s               d
006300180313     d yrsService      s              8  0
006400180313     d catType         s              3
006500180313     d updateRecord    s              1
006600180313     d writeRecord     s              1
006700180411     d pos             s              2  0
006800180605     d pos2            s              2  0
006900180523     d unique          s             10
007000180523     d alreadySent     s              1
007001190715     d alreadySentM    s              1
007002190715     d alreadySentV    s              1
007003190715     d alreadySentD    s              1
007100180523     d ssn             s              9  0
007200180523     d seq#            s              2  0
007300180523     d ctype           s              3
007400180523     d termdt          s              8  0
007500180523     d covtp           s              2
007501201202     d planFound       s              1
007600150820
007700160511      //==================================================================
007800160511      // mainline
007900160511      //===================================================================
008000150820
008100160511       exsr init;
008200160511       exsr main;
008300160511       exsr exit;
008400160511
008500160511      //===================================================================
008600160511      // main
008700160511      //===================================================================
008800160511
008900160511       begsr main;
009000160511
009100180309        carrierCode = carrierCode1;
009200180309        exsr main2;
009300180309
009400180309        carrierCode = carrierCode2;
009500180309        exsr main2;
009600180424
009700180424        exsr clearSSN;
009701190719        exsr checkFile;
009800180424
009900160511       endsr;
010000160511
010100180309      //===================================================================
010200180309      // main2
010300180309      //===================================================================
010400180309
010500180309       begsr main2;
010600180309
010700180309        setll carrierCode plnmsr;
010800180309        reade carrierCode plnmsr;
010900180309
011000180309        dow not %eof;
011100180309
011200200128         //setll (pltrst : plsub# : plplan) mcov39;
011300200128         //reade (pltrst : plsub# : plplan) mcov39;
011301200128         setll (pltrst : plsub# : plplan) mcov42;
011302200128         reade (pltrst : plsub# : plplan) mcov42;
011400180313
011500180313         dow not %eof;
011600180309
011700180313          exsr process;
011800180309
011900200128         //reade (pltrst : plsub# : plplan) mcov39;
011901200128         reade (pltrst : plsub# : plplan) mcov42;
012000180313         enddo;
012100180309
012200180309        reade carrierCode plnmsr;
012300180309        enddo;
012400180309
012500180309       endsr;
012600180309
012700160511      //===================================================================
012800160511      // process
012900160511      //===================================================================
013000160511
013100160511       begsr process;
013200160511
013300180523        chain (unique : pltrst : plsub# : acc#) setupFile;
013400180523        if %found;
013500211202        if castatus = 'Y' or castatus = 'P';
013600180523
013700180523         chain mcssno member;
013800160511
014101200128         //setgt (pltrst : plsub# : acc# : mcssno : plplan) covc16;
014102200128         setll (pltrst : plsub# : acc# : mcssno) covc44;
014103200128         reade (pltrst : plsub# : acc# : mcssno) covc44;
014104200128         //readpe (pltrst : plsub# : acc# : mcssno : plplan) covc16;
014200190611         dow not %eof;
014201200128         if plplan = mcplan;
014500180914         if candt > 0;
014600160511
014700180914          term_dt_limit = %date(candt);
014800190508          if %date() > term_dt_limit + %days(60);
014900180914           leavesr;
015000180914          else;
015100190923           exsr writeMember;
015200180914          endif;
015300160511
015400180914         else;
015500180523          exsr writeMember;
015600180523         endif;
015701190819
015702200128         endif;
015703200128         reade (pltrst : plsub# : acc# : mcssno) covc44;
015704200128         //readpe (pltrst : plsub# : acc# : mcssno : plplan) covc16;
015900190611        enddo;
016000180523        endif;
016100180523        endif;
016200180523
016300160511       endsr;
016400160511
016500160513      //===================================================================
016600180313      // Write Member
016700160513      //===================================================================
016800160513
016900180313       begsr writeMember;
017000160513
017100180313        updateRecord = 'N';
017200180313        writeRecord = 'N';
017300180313
017400180313        chain
017500180313        (%editc(mbssno:'X'):%editc(mbssno:'X'):%char(birth):mlname:mfname:mmi)
017600180313        cignaFile;
017700180313        if %found;
017800180313         updateRecord = 'Y';
017900180313        else;
018000180313         writeRecord = 'Y';
018001190819         alreadySentM = 'N';
018002190819         alreadySentD = 'N';
018003190819         alreadySentV = 'N';
018100180313        endif;
018200180313
018300180313        exsr determineType;
018400180313        if catType = ' ';
018500180313         leavesr;
018600180313        endif;
018700180313
018800180417        exsr getgrp;
018900160513
019000180313        if writeRecord = 'Y';
019100180313         clear cignaFile;
019200180313        endif;
019300180312
019400180427        chain (pltrst : plsub# : acc#) actFile;
019500180427        if %found;
019600211112         groupnam = macnam1;
019700180427        endif;
019800180427
019900180427        chain (pltrst : plsub# : acc#) act2File;
020000180427        if %found;
020100180427         grouptid = %editc(a2tax_id#:'X');
020200180427        endif;
020300180427
020400200707        //policy# = %subst(group#:1:7);
020500200707        //pos2 = %scan(' ' : policy# : 1);
020600200707        //if pos2 = 7;
020700200707        // policy# = %trim('0') + %trim(policy#);
020800200707        //endif;
020900180605
021000180312        recid = '01';
021100180312        prkeyty = 'S';
021200180312        memid = %editc(mbssno:'X');
021300180312        lastname = mlname;
021400180313        firstname = mfname;
021500180312        mi = mmi;
021600180312        dateofbth = %char(birth);
021700180312        gender = sex;
021800180424
021900180312        mbrssn = %editc(mbssno:'X');
022000180424        //if mbrssn = '000000000';
022100180424        // mbrssn = ' ';
022200180424        // tssn = ' ';
022300180424        //endif;
022400180312
022500180312        oritype = ' ';
022600180312        orikey = ' ';
022700180312
022800180313        cphone = %editc(area:'X') + %editc(phone:'X');
022900180312        bphone = ' ';
023000180312
023100180312        address1 = addr1;
023200180312        address2 = addr2;
023300180312        ccity = city;
023400180405        cstate = state;
023500180313        czip = %editc(zip:'X');
023600180312        wzip = ' ';
023700180312        ftstdnt = ' ';
023800180312        relcd = 'EE';
023900180312        deceased = ' ';
024000180312        decdate = ' ';
024100180312
024200180313        if hndicp > ' ';
024300180312         disabled = 'H';
024400180312        endif;
024500180312
024600180312        retired = ' ';
024700180312        retdate = ' ';
024800180312        oritype2 = ' ';
024900180312        orikey2 = ' ';
025000180312
025100180312        if salary > 0;
025200180313         cursalary = %char(salary);
025300180312         salfreq = 'A';
025400180312        endif;
025500180312
025600180312        saldate = ' ';
025700180312
025800180312        if empdt > 0;
025900180312         hiredate = %char(empdt);
026000180312          hiredateT = %date(empdt);
026100180312          yrsService = %diff(%date():hiredateT:*years);
026200180312         yrofserv = %char(yrsService);
026300180312        endif;
026400180312
026500190618        email = fill66;
026600180312        eid = ' ';
026700180312
026800180312        oins = ' ';
026900180312        mhicid = ' ';
027000180312
027100180312        covtype = ' ';
027200180312        carrier = ' ';
027300180312        medtype = ' ';
027400180312        oeffdate = ' ';
027500180312        ocandate = ' ';
027600180312        pcode = ' ';
027700180312        fresp = ' ';
027800180312        covtype2 = ' ';
027900180312        carrier2 = ' ';
028000180312        medtype2 = ' ';
028100180312        oeffdate2 = ' ';
028200180312        ocandate2 = ' ';
028300180312        pcode2 = ' ';
028400180312        fresp2 = ' ';
028500180312        policy#2 = ' ';
028600180312        covtype3 = ' ';
028700180312        carrier3 = ' ';
028800180312        medtype3 = ' ';
028900180312        oeffdate3 = ' ';
029000180312        ocandate3 = ' ';
029100180312        pcode3 = ' ';
029200180312        fresp3 = ' ';
029300180312        policy#3 = ' ';
029400180312
029500180313        estatus = ' ';
029600180313        select;
029700180313         when empst = 'A';
029800180313          estatus = 'A';
029900180313         when empst <> 'A';
030000180313          estatus = 'I';
030100180313        endsl;
030200180312
030300180312        estatusdt = ' ';
030400180312
030500180312        tssn = %editc(mbssno:'X');
030600180312
030700180312        eloc = ' ';
030800180313        feditin = %editc(mbssno:'X');
030900180312
031000180313        if catType = 'MED';
031001190903         ctype = catType;
031100190715         termdt = candt;
031101190715         seq# = 0;
031102190725         ssn = mcssno;
031103190715         exsr checkTerm;
031104190819         //alreadySentM = alreadySent;
031105190715         if alreadySentM = 'N';
031106190715
031200180313         macct# = group#;
031300180605         pos2 = %scan(' ' : macct# : 1);
031400180605         if pos2 = 7;
031500180605          macct# = %trim('0') + %trim(macct#);
031501200707         endif;
031502200707
031503200707         if policy# = ' ';
031504200707          policy# = macct#;
031505200707         endif;
031700190725
031702190725         if mcovedate > ' ' and mcovcdate = ' ';
031703190725          updateRecord = 'N';
031704190725         endif;
031705190725
031800180423         mtype = 'HLT';
031801190725
031900180313         mcovedate = %char(enrldt);
032000180313
032001190725         mcovcdate = ' ';
032100180313         if candt > 0;
032200180913          cancelh = candt;
032300180913           exsr sub1_fromDate;
032400180913          mcovcdate = %char(cancelh);
032401190725
032402190725          if candt = enrldt;
032403190725           mcovcdate = %char(candt);
032404190725          endif;
032405190725
032500180313         endif;
032600180312
032700180313         exsr coverageType;
032800180313
032900180313         if qedt > 0 and empst = 'C';
033000180313          mcbovedate = %char(qedt);
033100180313          mcbpddate = %char(cexpdt);
033200180313         endif;
033300180313
033400180524         exsr getValues;
033500180411
033600180313         mnetid = ' ';
033700180313         medpcpid = ' ';
033800180313         medestpid = ' ';
033900180313         mpnetefdt = ' ';
034000180313         mpeclmedt = ' ';
034100180313        endif;
034101190715        endif;
034200180312
034300180313        if catType = 'DEN';
034301190903         ctype = catType;
034302190715         termdt = candt;
034304190715         seq# = 0;
034305190725         ssn = mcssno;
034306190715         exsr checkTerm;
034307190819         //alreadySentD = alreadySent;
034308190715         if alreadySentD = 'N';
034309190715
034400180313         dacct# = group#;
034500180605         pos2 = %scan(' ' : dacct# : 1);
034600180605         if pos2 = 7;
034700180605          dacct# = %trim('0') + %trim(dacct#);
034701200707         endif;
034702200707
034703200707         if policy# = ' ';
034704200707          policy# = dacct#;
034705200707         endif;
034900180605
034901190725         if dcovedate > ' ' and dcovcdate = ' ';
034902190725          updateRecord = 'N';
034903190725         endif;
034904190725
035000180423         dtype = 'DEN';
035001190725
035100180313         dcovedate = %char(enrldt);
035200180313
035201190725         dcovcdate = ' ';
035300180313         if candt > 0;
035400180913          cancelh = candt;
035500180913           exsr sub1_fromDate;
035600180913          dcovcdate = %char(cancelh);
035601190725
035602190725          if candt = enrldt;
035603190725           dcovcdate = %char(candt);
035604190725          endif;
035606190725
035700180313         endif;
035800180313
035900180313         exsr coverageType;
036000180313
036100180313         if qedt > 0 and empst = 'C';
036200180313          dcbovedate = %char(qedt);
036300180313          dcbpddate = %char(cexpdt);
036400180313         endif;
036500180313
036600180524         exsr getValues;
036700180411
036800180313        endif;
036801190715        endif;
036900180411
037000180313        if catType = 'VIS';
037001190903         ctype = catType;
037002190715         termdt = candt;
037003190715         seq# = 0;
037004190725         ssn = mcssno;
037005190715         exsr checkTerm;
037006190819         //alreadySentV = alreadySent;
037007190715         if alreadySentV = 'N';
037008190715
037100180313         vacct# = group#;
037200180605         pos2 = %scan(' ' : vacct# : 1);
037300180605         if pos2 = 7;
037400180605          vacct# = %trim('0') + %trim(vacct#);
037401200707         endif;
037402200707
037403200707         if policy# = ' ';
037404200707          policy# = vacct#;
037405200707         endif;
037600180605
037601190725         if vcovedate > ' ' and vcovcdate = ' ';
037602190725          updateRecord = 'N';
037603190725         endif;
037604190725
037700180423         vtype = 'VIS';
037701190725
037800180313         vcovedate = %char(enrldt);
037900180313
037901190725         vcovcdate = ' ';
038000180313         if candt > 0;
038100180913          cancelh = candt;
038200180913           exsr sub1_fromDate;
038300180913          vcovcdate = %char(cancelh);
038301190725
038302190725          if candt = enrldt;
038303190725           vcovcdate = %char(candt);
038304190725          endif;
038305190725
038400180313         endif;
038500180313
038600180313         exsr coverageType;
038700180313
038800180313         if qedt > 0 and empst = 'C';
038900180313          vcbovedate = %char(qedt);
039000180313          vcbpddate = %char(cexpdt);
039100180313         endif;
039200180313
039300180524         exsr getValues;
039400180411
039401190715        endif;
039500180313        endif;
039600180411
039700180523        ssn = mcssno;
039800180523        seq# = 0;
039900180523        ctype = catType;
040000180523        termdt = candt;
040100180523
040200190715        //exsr checkTerm;
040300190715        //if alreadySent = 'N';
040301190715        if alreadySentM = 'N' or alreadySentD = 'N' or alreadySentV = 'N';
040400201202         if planfound = 'Y';
040500201202          if writeRecord = 'Y';
040600201202           write cignaFile;
040700201202          endif;
040701190715
040800201202          if updateRecord = 'Y';
040900201202           update cignaFile;
040901201202          endif;
040902201202         endif;
040903201202
041100190819         exsr setFlags;
041200180523        endif;
041300180523
041400180313        if mcovtp <> 'TIN';
041500180313         exsr dependent;
041600180313        endif;
041700160518
041800160516       endsr;
041900060817
042000180913      //===================================================================
042100180913      // sub 1 from cancel date
042200180913      //===================================================================
042300180913
042400180913       begsr sub1_fromDate;
042501190725
042600180913        cancelDate = %date(cancelh) - %days(1);
042700180913        cancelh = %dec(cancelDate);
042800180913
042900180913       endsr;
043000180913
043100180523      //===================================================================
043200180523      // check termed records;
043300180523      //===================================================================
043400180523
043500180523       begsr checkTerm;
043600180523
043700190903       //alreadySent = 'N';
043701190903       alreadySentM = 'N';
043702190903       alreadySentD = 'N';
043703190903       alreadySentV = 'N';
043800180523
043900180523       if termdt > 0;
044000180523
044100180523        chain (pltrst:plsub#:acc#:ssn:seq#:ctype:plplan:termdt) termFile;
044200180523        if %found;
044201190903
044202190903         if ctype = 'MED';
044203190903          alreadySentM = 'Y';
044204190903         endif;
044205190903
044206190903         if ctype = 'DEN';
044207190903          alreadySentD = 'Y';
044208190903         endif;
044209190903
044210190903         if ctype = 'VIS';
044211190903          alreadySentV = 'Y';
044212190903         endif;
044214190903
044300190903        //if alreadySent = 'Y';
044400190903        // leavesr;
044401190903         endif;
044600180523
044700180523        if not %found;
044800180523         ttrst = pltrst;
044900180523          tsub# = plsub#;
045000180523           tacct = acc#;
045100180524            tssno = ssn;
045200180523             tseq# = seq#;
045300180523             ttype = ctype;
045400180523            tplan = plplan;
045500180523           ttermdt = termdt;
045600180523          ttrnsdt = %dec(%date);
045700180523         write termFile;
045800180523        endif;
045900180523
046000180523       endif;
046100180523
046200180523       endsr;
046300180523
046400180523      //===================================================================
046500180523      // get values
046600180523      //===================================================================
046700180523
046800180523       begsr getValues;
046900180523
046901201202        planFound = 'N';
046902201202
047000180523        covtp = %subst(mcovtp:2:2);
047100180523        chain (unique:mbtrst:mbsub#:plplan:mbacct:state:covtp) planFile;
047200180523        if %found;
047201201202         planFound = 'Y';
047300201202          exsr get_valuesCategory;
047400180524         leavesr;
047500180524        endif;
047600180523
047700180523        covtp = %subst(mcovtp:2:2);
047800180523        chain (unique:mbtrst:mbsub#:plplan:mbacct:'ALL':covtp) planFile;
047900180523        if %found;
047901201202         planFound = 'Y';
048000201202          exsr get_valuesCategory;
048100180524         leavesr;
048200180524        endif;
048300180523
048400180525        chain (unique:mbtrst:mbsub#:plplan:mbacct:state:'ALL') planFile;
048500180525        if %found;
048501201202         planFound = 'Y';
048600201202          exsr get_valuesCategory;
048700180525         leavesr;
048800180525        endif;
048900180525
049000180525        chain (unique:mbtrst:mbsub#:plplan:mbacct:'ALL':'ALL') planFile;
049100180525        if %found;
049101201202         planFound = 'Y';
049200201202          exsr get_valuesCategory;
049300180525         leavesr;
049400180525        endif;
049500190514
049600190514        exsr errorReport;
049700180525
049800180523       endsr;
049900180523
049901190819      //===================================================================
049902190819      // setflags
049903190819      //===================================================================
049904190819
049905190819       begsr setFlags;
049906190819
049907190819        if catType = 'MED';
049908190819         alreadySentM = 'Y';
049914190819        endif;
049915190819
049916190819        if catType = 'DEN';
049917190819         alreadySentD = 'Y';
049921190819        endif;
049922190819
049923190819        if catType = 'VIS';
049924190819         alreadySentV = 'Y';
049928190819        endif;
049929190819
049930190819       endsr;
049931190819
050000180524      //===================================================================
050100180524      // get values
050200180524      //===================================================================
050300180524
050400180524       begsr get_valuesCategory;
050500180524
050600180524        if catType = 'MED';
050700180524         mplanid = cpcid4;
050800180524          mbranchcd = cpcid3;
050900180524         mboptcode = cpcid2;
051000180524        endif;
051100180524
051200180524        if catType = 'DEN';
051300180524         dplanid = cpcid4;
051400180524          dbranchcd = cpcid3;
051500180524         dboptcode = cpcid2;
051600180524        endif;
051700180524
051800180524        if catType = 'VIS';
051900180524         vplanid = cpcid4;
052000180524          vbranchcd = cpcid3;
052100180524         vboptcode = cpcid2;
052200180524        endif;
052300180524
052400180524       endsr;
052500180411
052600160512      //===================================================================
052700160512      // process
052800160512      //===================================================================
052900160512
053000160512       begsr dependent;
053100160512
053200160512        setll mcssno depenr;
053300160512        reade mcssno depenr;
053400160512
053500160512        dow not %eof;
053600160512
053700180313        chain (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
053800160512        if %found;
053900180313         exsr dependentCoverage;
054000160512        endif;
054100160512
054200160512        reade mcssno depenr;
054300160512        enddo;
054400160512
054500190715       endsr;
054600160512
054700160516      //===============================================================
054800160512      // Dependent coverage
054900160512      //===============================================================
055000160513
055100180313       begsr dependentCoverage;
055200160512
055300180313        setgt (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
055400180313        readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
055500160512
055600160512        dow not %eof;
055700160512
055800180313         if ccandt <> 0;
055900160512
056000160516          term_dt_limit = %date(ccandt);
056100160516          if %date() > term_dt_limit;
056200160512           leavesr;
056300160512          else;
056400160512
056500160516           exsr writeDep;
056600160512          endif;
056700160512
056800160512         else;
056900160516          exsr writeDep;
057000160512          leavesr;
057100160512         endif;
057200160512
057300180313        readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
057400160512        enddo;
057500160512
057600160512       endsr;
057700160512
057800160516      //===============================================================
057900160516      // write dependent
058000160516      //===============================================================
058100160516
058200160516       begsr writeDep;
058300180313
058400180313        updateRecord = 'N';
058500180313        writeRecord = 'N';
058600180313
058700180313        chain
058800180313        (%editc(mbssno:'X'):%editc(depss#:'X'):%char(dbirth):dlname:dfname:dmi)
058900180313        cignaFile;
059000180313        if %found;
059100180313         updateRecord = 'Y';
059200180313        else;
059300180313         writeRecord = 'Y';
059301190819         alreadySentM = 'N';
059302190819         alreadySentD = 'N';
059303190819         alreadySentV = 'N';
059400180313        endif;
059500180313
059600180313        exsr determineType;
059700180313        if catType = ' ';
059800180313         leavesr;
059900180313        endif;
060000180313
060100180313        exsr getgrp;
060200180313
060300180313        if writeRecord = 'Y';
060400180313         clear cignaFile;
060500180313        endif;
060600180313
060700180427        chain (pltrst : plsub# : acc#) actFile;
060800180427        if %found;
060900211112         groupnam = macnam1;
061000180427        endif;
061100180427
061200180427        chain (pltrst : plsub# : acc#) act2File;
061300180427        if %found;
061400180427         grouptid = %editc(a2tax_id#:'X');
061500180427        endif;
061600180427
061700200707        //policy# = %subst(group#:1:7);
061800200707        //pos2 = %scan(' ' : policy# : 1);
061900200707        //if pos2 = 7;
062000200707        // policy# = %trim('0') + %trim(policy#);
062100200707        //endif;
062200180605
062300180313        recid = '02';
062400180313        prkeyty = 'S';
062500180313        memid = %editc(mbssno:'X');
062600180313        lastname = dlname;
062700180313        firstname = dfname;
062800180313        mi = dmi;
062900180313        dateofbth = %char(dbirth);
063000180313        gender = dsex;
063100180424
063200180313        mbrssn = %editc(depss#:'X');
063300180424        //if mbrssn = '000000000';
063400180424        // mbrssn = ' ';
063500180502           tssn = ' ';
063600180424        //endif;
063700180313
063800180313        oritype = ' ';
063900180313        orikey = ' ';
064000180313
064100180313        cphone = %editc(area:'X') + %editc(phone:'X');
064200180313        bphone = ' ';
064300180313
064400180313        address1 = daddr1;
064500180313        address2 = daddr2;
064600180313        ccity = dcity;
064700180405        cstate = dstate;
064800180313        czip = %editc(dzip:'X');
064900180313        wzip = ' ';
065000180313        ftstdnt = ' ';
065100180313
065200180313        exsr relCodes;
065300180313
065400180313        deceased = ' ';
065500180313        decdate = ' ';
065600180313
065700180313        if dhndcp > ' ';
065800180313         disabled = 'H';
065900180313        endif;
066000180313
066100180313        retired = ' ';
066200180313        retdate = ' ';
066300180313        oritype2 = ' ';
066400180313        orikey2 = ' ';
066500180313
066600180313        cursalary = ' ';
066700180313        salfreq = ' ';
066800180313        saldate = ' ';
066900180313
067000180313        hiredate = ' ';
067100180313        yrofserv = ' ';
067200180313
067300180313        email = ' ';
067400180313        eid = ' ';
067500180313
067600180313        oins = ' ';
067700180313        mhicid = ' ';
067800180313
067900180313        covtype = ' ';
068000180313        carrier = ' ';
068100180313        medtype = ' ';
068200180313        oeffdate = ' ';
068300180313        ocandate = ' ';
068400180313        pcode = ' ';
068500180313        fresp = ' ';
068600180313        covtype2 = ' ';
068700180313        carrier2 = ' ';
068800180313        medtype2 = ' ';
068900180313        oeffdate2 = ' ';
069000180313        ocandate2 = ' ';
069100180313        pcode2 = ' ';
069200180313        fresp2 = ' ';
069300180313        policy#2 = ' ';
069400180313        covtype3 = ' ';
069500180313        carrier3 = ' ';
069600180313        medtype3 = ' ';
069700180313        oeffdate3 = ' ';
069800180313        ocandate3 = ' ';
069900180313        pcode3 = ' ';
070000180313        fresp3 = ' ';
070100180313        policy#3 = ' ';
070200180313
070300180313        estatus = ' ';
070400180313
070500180313        estatusdt = ' ';
070600180313
070700180313        tssn = %editc(depss#:'X');
070800180313
070900180313        eloc = ' ';
071000180313        feditin = %editc(depss#:'X');
071100180313
071200180313        if catType = 'MED';
071201190715        ssn = mcssno;
071202190715        seq# = dpseq#;
071203190715        ctype = catType;
071204190715        termdt = ccandt;
071205190715        exsr checkTerm;
071206190819        //alreadySentM = alreadySent;
071207190715
071208190715        if alreadySentM = 'N';
071209190715
071300180313         macct# = group#;
071400180605         pos2 = %scan(' ' : macct# : 1);
071500180605         if pos2 = 7;
071600180605          macct# = %trim('0') + %trim(macct#);
071601200707         endif;
071602200707
071603200707         if policy# = ' ';
071604200707          policy# = macct#;
071700180605         endif;
071800180605
071801190725         if mcovedate > ' ' and  mcovcdate = ' ';
071802190725          updateRecord = 'N';
071803190725         endif;
071804190725
071900190725         mtype = 'HLT';
072000180313
072100180313         mcovedate = %char(denrdt);
072200180313
072300180607         if denrdt < enrldt;
072400180607          mcovedate = %char(enrldt);
072500180607         endif;
072600180607
072700180607         if dbirth > denrdt;
072800180607          mcovedate = %char(dbirth);
072900180607         endif;
073000180607
073001190725         mcovcdate = ' ';
073100180523         if ccandt > 0;
073200180913          cancelh = ccandt;
073300180913           exsr sub1_fromDate;
073400180913          mcovcdate = %char(cancelh);
073401190725
073402190725          if ccandt = denrdt;
073403190725           mcovcdate = %char(candt);
073404190725          endif;
073406190725
073500180313         endif;
073600180313
073700180313         mecovin = ' ';
073800180313         mscovin = ' ';
073900180313         mccovin = ' ';
074000180313         mcocovin = ' ';
074100180313         decovin = ' ';
074200180313         dscovin = ' ';
074300180313         dccovin = ' ';
074400180313         dcocovin = ' ';
074500180313         vecovin = ' ';
074600180313         vscovin = ' ';
074700180313         vccovin = ' ';
074800180313         vcocovin = ' ';
074900180313
075000180423         exsr coverageType;
075100180423
075200180313         if qedt > 0 and empst = 'C';
075300180313          mcbovedate = %char(qedt);
075400180313          mcbpddate = %char(cexpdt);
075500180313         endif;
075600180313
075700180524         exsr getValues;
075800180411
075900180313         mnetid = ' ';
076000180313         medpcpid = ' ';
076100180313         medestpid = ' ';
076200180313         mpnetefdt = ' ';
076300180313         mpeclmedt = ' ';
076400180313        endif;
076401190715        endif;
076500180313
076601190715        if catType = 'DEN';
076602190715        ssn = mcssno;
076603190715        seq# = dpseq#;
076604190715        ctype = catType;
076605190715        termdt = ccandt;
076606190715        exsr checkTerm;
076607190819        //alreadySentD = alreadySent;
076608190715
076609190715        if alreadySentD = 'N';
076700180523         //dplanid = '42803';
076800180313         dacct# = group#;
076900180605         pos2 = %scan(' ' : dacct# : 1);
077000180605         if pos2 = 7;
077100180605          dacct# = %trim('0') + %trim(dacct#);
077101200707         endif;
077102200707
077103200707         if policy# = ' ';
077104200707          policy# = dacct#;
077105200707         endif;
077300180605
077301190725         if dcovedate > ' ' and dcovcdate = ' ';
077302190725          updateRecord = 'N';
077303190725         endif;
077304190725
077400180423         dtype = 'DEN';
077500180405
077600180313         dcovedate = %char(denrdt);
077700180313
077800180607         if denrdt < enrldt;
077900180607          dcovedate = %char(enrldt);
078000180607         endif;
078100180607
078200180607         if dbirth > denrdt;
078300180607          dcovedate = %char(dbirth);
078400180607         endif;
078500180607
078501190725         dcovcdate = ' ';
078600180523         if ccandt > 0;
078700180913          cancelh = ccandt;
078800180913           exsr sub1_fromDate;
078900180913          dcovcdate = %char(cancelh);
078901190725
078902190725          if ccandt = denrdt;
078903190725           dcovcdate = %char(candt);
078904190725          endif;
078905190725
079000180313         endif;
079100180313
079101190725         decovin = ' ';
079102190725         dscovin = ' ';
079103190725         dccovin = ' ';
079104190725         dcocovin = ' ';
079105190725
079200180313         exsr coverageType;
079300180313
079400180313         if qedt > 0 and empst = 'C';
079500180313          dcbovedate = %char(qedt);
079600180313          dcbpddate = %char(cexpdt);
079700180313         endif;
079800180313
079900180524         exsr getValues;
080000180411
080100180313        endif;
080101190715        endif;
080200180313
080300180313        if catType = 'VIS';
080301190715        ssn = mcssno;
080302190715        seq# = dpseq#;
080303190715        ctype = catType;
080304190715        termdt = ccandt;
080305190715        exsr checkTerm;
080306190819        //alreadySentV = alreadySent;
080307190715
080308190715        if alreadySentV = 'N';
080400180313         vacct# = group#;
080500180605         pos2 = %scan(' ' : vacct# : 1);
080600180605         if pos2 = 7;
080700180605          vacct# = %trim('0') + %trim(vacct#);
080701200707         endif;
080702200707
080703200707         if policy# = ' ';
080704200707          policy# = vacct#;
080705200707         endif;
080900180605
080901190725         if vcovedate > ' ' and vcovcdate = ' ';
080902190725          updateRecord = 'N';
080903190725         endif;
080904190725
081000180423         vtype = 'VIS';
081001190725
081100180313         vcovedate = %char(denrdt);
081200180313
081300180607         if denrdt < enrldt;
081400180607          vcovedate = %char(enrldt);
081500180607         endif;
081600180607
081700180607         if dbirth > denrdt;
081800180607          vcovedate = %char(dbirth);
081900180607         endif;
082000180607
082001190725         vcovcdate = ' ';
082100180523         if ccandt > 0;
082200180913          cancelh = ccandt;
082300180913           exsr sub1_fromDate;
082400180913          vcovcdate = %char(cancelh);
082401190725
082402190725          if ccandt = denrdt;
082403190725           vcovcdate = %char(candt);
082404190725          endif;
082405190725
082500180313         endif;
082600180313
082601190725         vecovin = ' ';
082602190725         vscovin = ' ';
082603190725         vccovin = ' ';
082604190725         vcocovin = ' ';
082700180313         exsr coverageType;
082800180313
082900180313         if qedt > 0 and empst = 'C';
083000180313          vcbovedate = %char(qedt);
083100180313          vcbpddate = %char(cexpdt);
083200180313         endif;
083300180313
083400180524         exsr getValues;
083500180411
083600180313        endif;
083601190715        endif;
083700180313
083800190715        //ssn = mcssno;
083900190715        //seq# = dpseq#;
084000190715        //ctype = catType;
084100190715        //termdt = ccandt;
084200180523
084300190715        //exsr checkTerm;
084400190715        //if alreadySent = 'N';
084401190715
084402190715        if alreadySentM = 'N' or alreadySentD = 'N' or alreadySentV = 'N';
084500201202         if planFound = 'Y';
084600201202          if writeRecord = 'Y';
084700201202           write cignaFile;
084800201202          endif;
084801190715
084900201202          if updateRecord = 'Y';
085000201202           update cignaFile;
085100201202          endif;
085101201202         endif;
085102201202
085103190819         exsr setFlags;
085300180523        endif;
085400180523
085500160516       endsr;
085600160511
085700160519      //===================================================================
085800160519      // Get group number
085900160519      //===================================================================
086000160519
086100160519       begsr getgrp;
086200160519
086300160519        setll (pltrst : plsub# : plplan) grater;
086400160519        reade (pltrst : plsub# : plplan) grater;
086500160519
086600160519        dow not %eof;
086700160519
086800160519         if today >= frmdat;
086900160519          if today <= todat;
087000160519           leavesr;
087100160519          else;
087200160519           group# = ' ';
087300160519          endif;
087400160519         endif;
087500160519
087600160519        reade (pltrst : plsub# : plplan) grater;
087700160519        enddo;
087800160519
087900160519    ?  endsr;
088000160519
088100180312      //===================================================================
088200180312      // Coverage Type
088300180312      //===================================================================
088400180312
088500180312       begsr coverageType;
088600180312
088700180313        if catType = 'MED';
088800180313         mecovin = 'N';
088900180313         mscovin = 'N';
089000180313         mccovin = 'N';
089100180313         mcocovin = 'N';
089200180313
089300180313         select;
089400180313          when mcovtp = 'TIN';
089500180313           mecovin = 'Y';
089600180313
089700180313          when mcovtp = 'THW';
089800180313           mecovin = 'Y';
089900180313           mscovin = 'Y';
090000180313
090100180313          when mcovtp = 'TPC' or mcovtp = 'TP2';
090200180313           mecovin = 'Y';
090300180313           mccovin = 'Y';
090400180313
090500180313          when mcovtp = 'TFA';
090600180313           mecovin = 'Y';
090700180313           mscovin = 'Y';
090800180313           mccovin = 'Y';
090900180313         endsl;
091000180313        endif;
091100180312
091200180313        if catType = 'DEN';
091300180313         decovin = 'N';
091400180313         dscovin = 'N';
091500180313         dccovin = 'N';
091600180313         dcocovin = 'N';
091700180313
091800180313         select;
091900180313          when mcovtp = 'TIN';
092000180313           decovin = 'Y';
092100180313
092200180313          when mcovtp = 'THW';
092300180313           decovin = 'Y';
092400180313           dscovin = 'Y';
092500180313
092600180313          when mcovtp = 'TPC' or mcovtp = 'TP2';
092700180313           decovin = 'Y';
092800180313           dccovin = 'Y';
092900180313
093000180313          when mcovtp = 'TFA';
093100180313           decovin = 'Y';
093200180313           dscovin = 'Y';
093300180313           dccovin = 'Y';
093400180313         endsl;
093500180313        endif;
093600180313
093700180313        if catType = 'VIS';
093800180313         vecovin = 'N';
093900180313         vscovin = 'N';
094000180313         vccovin = 'N';
094100180313         vcocovin = 'N';
094200180313
094300180313         select;
094400180313          when mcovtp = 'TIN';
094500180313           vecovin = 'Y';
094600180313
094700180313          when mcovtp = 'THW';
094800180313           vecovin = 'Y';
094900180313           vscovin = 'Y';
095000180313
095100180313          when mcovtp = 'TPC' or mcovtp = 'TP2';
095200180313           vecovin = 'Y';
095300180313           vccovin = 'Y';
095400180313
095500180313          when mcovtp = 'TFA';
095600180313           vecovin = 'Y';
095700180313           vscovin = 'Y';
095800180313           vccovin = 'Y';
095900180313         endsl;
096000180313        endif;
096100180313
096200180312       endsr;
096300180312
096400180313      //===================================================================
096500180313      // Determine Type
096600180313      //===================================================================
096700180313
096800180313       begsr determineType;
096900180313
097000180319        catType = ' ';
097100180313        chain ('P' : %subst(plncat:2:2)) codesFile;
097200180313        if %found;
097300180313
097400180313         select;
097500180313          when action = 'M';
097600180313           catType = 'MED';
097700180313
097800180313          when action = 'D';
097900180313           catType = 'DEN';
098000180313
098100180313          when action = 'V';
098200180313           catType = 'VIS';
098300180313         endsl;
098400180313
098500180313        endif;
098600180313
098700180313       endsr;
098800180313
098900180313      //===================================================================
099000180313      // Relationship Codes
099100180313      //===================================================================
099200180313
099300180313       begsr relCodes;
099400180313
099500180313        select;
099600180313         when drelcd = 'RHU' or drelcd = 'RWI' or drelcd = 'RPA';
099700180313          relcd = 'SP';
099800180313
099900180313         when drelcd = 'RDA' or drelcd = 'RSO';
100000180313          relcd = 'CH';
100100180313
100200180313         when drelcd = 'RDA' or drelcd = 'RSO';
100300180313          relcd = 'CH';
100400180313        endsl;
100500180313
100600180313       endsr;
100700180313
100800180424      //===================================================================
100900180424      // clear ssn
101000180424      //===================================================================
101100180424
101200180424       begsr clearSSN;
101300180424
101400180424        setll *loval cignaFile;
101500180424        read cignaFile;
101600180424        dow  not %eof;
101700180424         if mbrssn = '000000000';
101800180424          mbrssn = ' ';
101900180424           tssn = ' ';
102000180424          update cignaFile;
102100180424         endif;
102200180424
102300180424        read cignaFile;
102400180424        enddo;
102500180424
102600180424       endsr;
102700190514
102701190719      //===================================================================
102702190719      // clear file
102703190719      //===================================================================
102704190719
102705190719       begsr checkFile;
102706190719
102707190719        setll *loval cignaFile;
102708190719        read cignaFile;
102709190719        dow  not %eof;
102717190719
102719190719        if MACCT# = ' ' and  MTYPE  = ' ' and  MPLANID = ' ' and
102722190719            MBRANCHCD = ' ' and MBOPTCODE = ' ' and  MCOVEDATE = ' ' and
102723190719            MCOVCDATE = ' ' and  MECOVIN = ' ' and  MSCOVIN = ' ' and
102724190719             MCCOVIN  = ' ' and  MCOCOVIN = ' ' and
102725190719
102726190719           dACCT# = ' ' and  dTYPE  = ' ' and  dPLANID = ' ' and
102727190719            dBRANCHCD = ' ' and dBOPTCODE = ' ' and  dCOVEDATE = ' ' and
102728190719            dCOVCDATE = ' ' and  dECOVIN = ' ' and  dSCOVIN = ' ' and
102729190719             dCCOVIN  = ' ' and  dCOCOVIN = ' ' and
102730190719
102731190719           vACCT# = ' ' and  vTYPE  = ' ' and  vPLANID = ' ' and
102732190719            vBRANCHCD = ' ' and vBOPTCODE = ' ' and  vCOVEDATE = ' ' and
102733190719            vCOVCDATE = ' ' and  vECOVIN = ' ' and  vSCOVIN = ' ' and
102734190719             vCCOVIN  = ' ' and  vCOCOVIN = ' ';
102735190719           delete cignaFile;
102739190719           endif;
102740190719
102742190719        read cignaFile;
102752190719        enddo;
102753190719
102754190719       endsr;
102755190719
102800190514       //===================================================================
102900190514      // error report
103000190514      //===================================================================
103100190514
103200190514       begsr errorReport;
103300190514
103400190514        if macct# > ' ';
103500190514
103600190514         if mplanid = ' ';
103700190514          ctext = 'Plan ID/Benefit Opt missing';
103800190514          exsr writeError;
103900190514         endif;
104000190514
104100190514         if mbranchcd = ' ';
104200190514          ctext = 'Class ID/Branch Code missing';
104300190514          exsr writeError;
104400190514         endif;
104500190514
104600190514         if mboptcode = ' ';
104700190514          ctext = 'Subgroup/Parent Branch Code missing';
104800190514          exsr writeError;
104900190514         endif;
105000190514
105100190514        endif;
105200190514
105300190514        if dacct# > ' ';
105400190514
105500190514         if dplanid = ' ';
105600190514          ctext = 'Plan ID/Benefit Opt missing';
105700190514          exsr writeError;
105800190514         endif;
105900190514
106000190514         if dbranchcd = ' ';
106100190514          ctext = 'Class ID/Branch Code missing';
106200190514          exsr writeError;
106300190514         endif;
106400190514
106500190514         if dboptcode = ' ';
106600190514          ctext = 'Subgroup/Parent Branch Code missing';
106700190514          exsr writeError;
106800190514         endif;
106900190514
107000190514        endif;
107100190514
107200190514        if vacct# > ' ';
107300190514
107400190514         if vplanid = ' ';
107500190514          ctext = 'Plan ID/Benefit Opt missing';
107600190514          exsr writeError;
107700190514         endif;
107800190514
107900190514         if vbranchcd = ' ';
108000190514          ctext = 'Class ID/Branch Code missing';
108100190514          exsr writeError;
108200190514         endif;
108300190514
108400190514         if vboptcode = ' ';
108500190514          ctext = 'Subgroup/Parent Branch Code missing';
108600190514          exsr writeError;
108700190514         endif;
108800190514
108900190514        endif;
109000190514
109100190514       endsr;
109200190514
109300190514      //===================================================================
109400190514      // Write Error
109500190514      //===================================================================
109600190514
109700190514       begsr writeError;
109800190514
109900190514        mbrid = memid;
110000190514        ctrust = %char(mbtrst);
110100190514        csub# = %char(mbsub#);
110200190514        cacct = %char(mbacct);
110300190514        mbrlast = mlname;
110400190514        mbrfirst = mfname;
110500190514        mbrplan = plplan;
110600190514        mbrst = state;
110700190514
110800190514        chain (mbtrst : mbsub# : mbacct) actFile;
110900190514        if %found;
111000190514
111100211112         chain (maacode) aaFile;
111200190514         if %found;
111300190514          acctaa = %trim(afnam) + ' ' + %trim(alnam);
111400190514         endif;
111500190514
111600190514         write errorFile;
111700190514        endif;
111800190514
111900190514       endsr;
112000180424
112100160511      //===================================================================
112200160511      // exit
112300160511      //===================================================================
112400160511
112500160511       begsr exit;
112600160511
112700160511        *inlr = '1';
112800160511        return;
112900160511
113000180523        unique = '0000000251';
113100180523
113200180523        today = %dec(%char(%date:*iso0):8:0);
113300180523
113400160511       endsr;
113500160511
113600160511      //===================================================================
113700160511      // init
113800160511      //===================================================================
113900160520
114000160511       begsr init;
114100160511
114200180309        carrierCode1 = 'CIG';
114300180309        carrierCode2 = 'CID';
114400180523        unique = '0000000251';
114500180309
114600160519        today = %dec(%char(%date:*iso0):8:0);
114700170710
114800160511       endsr;
114900010412
115000160511       //==============================================================
