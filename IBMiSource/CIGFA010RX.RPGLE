000100160513      *===========================================================================
000200160512     H option(*noDebugIo)
000300160513      *===========================================================================
000400180323      * CIGFA010R - Cigna FI - Facets Generate extract
000500200424      *===========================================================================
000600180313      * Date        Int   Description
000700200424      * ----------  ---   --------------------------------------------------------
000800220106      * 01/19/2022  jt    Original creation
000900160513      *===========================================================================
001000160512
001100180427     Faccmst    if   e           k disk    extfile('F.ACCMST')
001200211129     F                                     rename(accmsr:actFile) prefix(M)
001300180427
001400180427     Fac2mstl2  if   e           k disk    rename(accmsr2:act2File)
001500180427
001600160516     Fplnmstn1  if   e           k disk    extfile('F.PLNMSTN1')
001700160513
001800160516     Fplnmst    if   e           k disk    extfile('F.PLNMST')
001900180503     F                                     rename(plnmsr:plnr) prefix(P)
002000170619
002100180503     Fplnauxl   if   e           k disk    rename(plnauxr:auxFile)
002200180412
002201200109     Fmcov42    if   e           k disk    extfile('F.MCOV42')
002503200115     Fmcov44    if   e           k disk
002504200115     F                                     rename(mcovr:covc44)
002505200115
002800160516     Fmcov      if   e           k disk    extfile('F.MCOV')
002900180503     F                                     rename(mcovr:covr) prefix(M)
003000160513
003100180309     Fmember    if   e           k disk    extfile('F.MEMBER')
003200160513
003300160516     Fdepndc    if   e           k disk    extfile('F.DEPNDC')
003400160513
003500160516     Fdcov22    if   e           k disk    extfile('F.DCOV22')
003600160518
003700160518     Fgrate     if   e           k disk    extfile('F.GRATE')
003800160518
003900180313     fcodes     if   e           k disk    extfile('F.CODES')
004000180313     f                                     rename(codesr:codesFile)
004001190509
004002211129     faacode    if   e           k disk    rename(aacodr:aaFile)
004003190509
004100180313
004200180508     fcaraccp   if   e           k disk    rename(caraccr:setupFile)
004300180508
004400180518     fcarplnm   if   e           k disk    rename(carplnr:planFile)
004500180508
004503190509
004600220106     fcignafax  uf a e           k disk    rename(cignar:cignaFile)
004700160513
004800180523     fcignatrm  uf a e           k disk    rename(cignatr:termFile)
004900180523
004901190509     fcignafaer o    e             disk    rename(cignaer:errorFile)
004902190509
005000160512      *=================================================================
005100061017
005200180309     d carrierCode     s              3
005300180309     d carrierCode1    s              3
005400180309     d carrierCode2    s              3
005500180314     d carrierCode3    s              3
005600160519     d term_dt_limit   s               d
005700180913     d cancelDate      s               d
005800180913     d cancelh         s              8  0
005900160519     d today           s              8  0
006000180313     d hiredatet       s               d
006100180313     d yrsService      s              8  0
006200180313     d catType         s              3
006300180313     d updateRecord    s              1
006400180313     d writeRecord     s              1
006500180411     d hgroup#         s              6
006501200728     d hgroup#2        s              8
006600180503     d pos             s              2  0
006700180508     d unique          s             10
006800180523     d alreadySent     s              1
006801190715     d alreadySentM    s              1
006802190715     d alreadySentV    s              1
006803190715     d alreadySentD    s              1
006804210715     d alreadySentF    s              1
006900180523     d ssn             s              9  0
007000180523     d seq#            s              2  0
007100180523     d ctype           s              3
007200180523     d termdt          s              8  0
007300180523     d covtp           s              2
007301201202     d planFound       s              1
007400150820
007401220106     d cigfa010rx      pi
007402220106     d  intype                        1
007403220106
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
009400180309
009500180314        carrierCode = carrierCode3;
009600180314        exsr main2;
009700180314
009800180424        exsr clearSSN;
009801190719        exsr checkFile;
009802200424        exsr doHardcodes;
009900180424
010000160511       endsr;
010100160511
010200180309      //===================================================================
010300180309      // main2
010400180309      //===================================================================
010500180309
010600180309       begsr main2;
010700180309
010800180309        setll carrierCode plnmsr;
010900180309        reade carrierCode plnmsr;
011000180309
011100180309        dow not %eof;
011200180309
011300200109         setll (pltrst : plsub# : plplan) mcov42;
011400200109         reade (pltrst : plsub# : plplan) mcov42;
011500180313
011600180313         dow not %eof;
011700180309
011800180313          exsr process;
011900180309
012000200109         reade (pltrst : plsub# : plplan) mcov42;
012100180313         enddo;
012200180309
012300180309        reade carrierCode plnmsr;
012400180309        enddo;
012500180309
012600180309       endsr;
012700180309
012800160511      //===================================================================
012900160511      // process
013000160511      //===================================================================
013100160511
013200160511       begsr process;
013300160511
013400180508        chain (unique : pltrst : plsub# : acc#) setupFile;
013500220106        if %found;
013600220106        if castatus = intype;
013700180508
013800180508         chain mcssno member;
013900160511
014003200115        setll (pltrst : plsub# : acc# : mcssno) covc44;
014004200115        reade (pltrst : plsub# : acc# : mcssno) covc44;
014005190611        dow not %eof;
014100200109          if plplan = mcplan;
014200180508         // if record is termed see if we need to stop sending...
014300180914         if candt > 0;
014400180508
014500180914          term_dt_limit = %date(candt);
014600190508          if %date() > term_dt_limit + %days(60);
014700180914           leavesr;
014800180914          else;
014900180914           exsr writeMember;
015000180914          endif;
015100180508
015200180914         else;
015300180508          exsr writeMember;
015400180913         endif;
015401200109
015402200109         endif;
015500200109        //readpe (pltrst : plsub# : acc# : mcssno : plplan) covc16;
015501200115        reade (pltrst : plsub# : acc# : mcssno) covc44;
015502190611        enddo;
015600180523        endif;
015700180518        endif;
015800180508
015900160511       endsr;
016000160511
016100160513      //===================================================================
016200180313      // Write Member
016300160513      //===================================================================
016400160513
016500180313       begsr writeMember;
016600160513
016700180313        updateRecord = 'N';
016800180313        writeRecord = 'N';
016900180313
017000180313        chain
017100180313        (%editc(mbssno:'X'):%editc(mbssno:'X'):%char(birth):mlname:mfname:mmi)
017200180313        cignaFile;
017300180313        if %found;
017400180313         updateRecord = 'Y';
017500180313        else;
017600180313         writeRecord = 'Y';
017601190828         alreadySentM = 'N';
017602190828         alreadySentD = 'N';
017603190828         alreadySentV = 'N';
017604210715         alreadySentF = 'N';
017700180313        endif;
017800180313
017900180313        exsr determineType;
018000180313        if catType = ' ';
018100180313         leavesr;
018200180313        endif;
018300180313
018400160519        exsr getgrp;
018500160513
018600180313        if writeRecord = 'Y';
018700180313         clear cignaFile;
018800180313        endif;
018900180312
019000180427        chain (pltrst : plsub# : acc#) actFile;
019100180427        if %found;
019200211129         groupnam = macnam1;
019300180427        endif;
019400180427
019500180427        chain (pltrst : plsub# : acc#) act2File;
019600180427        if %found;
019700180427         grouptid = %editc(a2tax_id#:'X');
019800180427        endif;
019900180427
020000180312        recid = '01';
020100180312        prkeyty = 'S';
020200180312        memid = %editc(mbssno:'X');
020300180312        lastname = mlname;
020400180313        firstname = mfname;
020500180312        mi = mmi;
020600180312        dateofbth = %char(birth);
020700180312        gender = sex;
020800180417
020900180312        mbrssn = %editc(mbssno:'X');
021000180417        if mbrssn = '000000000';
021100180417         mbrssn = ' ';
021200180417         tssn = ' ';
021300180417        endif;
021400180312
021500180312        oritype = ' ';
021600180312        orikey = ' ';
021700180312
021800180313        cphone = %editc(area:'X') + %editc(phone:'X');
021900180312        bphone = ' ';
022000180312
022100180312        address1 = addr1;
022200180312        address2 = addr2;
022300180312        ccity = city;
022400180405        cstate = state;
022500180313        czip = %editc(zip:'X');
022600180312        wzip = ' ';
022700180312        ftstdnt = ' ';
022800180312        relcd = 'EE';
022900180312        deceased = ' ';
023000180312        decdate = ' ';
023100180312
023200180313        if hndicp > ' ';
023300180312         disabled = 'H';
023400180312        endif;
023500180312
023600180312        retired = ' ';
023700180312        retdate = ' ';
023800180312        oritype2 = ' ';
023900180312        orikey2 = ' ';
024000180312
024100180312        if salary > 0;
024200180313         cursalary = %char(salary);
024300180312         salfreq = 'A';
024400180312        endif;
024500180312
024600180312        saldate = ' ';
024700180312
024800180312        if empdt > 0;
024900180312         hiredate = %char(empdt);
025000180312          hiredateT = %date(empdt);
025100180312          yrsService = %diff(%date():hiredateT:*years);
025200180312         yrofserv = %char(yrsService);
025300180312        endif;
025400180312
025500180312        email = ' ';
025600180312        eid = ' ';
025700180312
025800180312        oins = ' ';
025900180312        mhicid = ' ';
026000180312
026100180312        covtype = ' ';
026200180312        carrier = ' ';
026300180312        medtype = ' ';
026400180417        oeffdate = %char(frmdat);
026500180417        //oeffdate = ' ';
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
029600180417        //tssn = %editc(mbssno:'X');
029700180312
029800180312        eloc = ' ';
029900180313        feditin = %editc(mbssno:'X');
030000180411
030100180411        hgroup# = group#;
030101200728        hgroup#2 = group#;
030102200109        if hgroup# = ' ';
030103200109         hgroup# = cacid3;
030104200728         hgroup#2 = cacid3;
030105200109        endif;
030106200728
030107210401        //pos = %scan('00' : group# : 1);
030108210401        //if pos = 1;
030109210401        // policy# = %trim(hgroup#2) + %trim('-F');
030110210401        //else;
030111210401        // policy# = %trim('00') + %trim(hgroup#) + %trim('-F');
030112210401        //endif;
030113200728
030200200728        //policy# = %trim('00') + %trim(hgroup#) + %trim('-F');
030201210401
030202210401        policy# = cacid6 + %trim('-F');
030300180411
030400180313        if catType = 'MED';
030401191101         ssn = mcssno;
030402190903         ctype = catType;
030403190715         termdt = candt;
030414190715         seq# = 0;
030415190715         exsr checkTerm;
030416190828         //alreadySentM = alreadySent;
030417190715         if alreadySentM = 'N';
030418200109
030419200728         //macct# = group#;
030420200728         //if macct# = ' ';
030421200109          macct# = cacid3;
030422200728         //endif;
030423200109
030600180410         mtype = 'HLT';
030700180313
030800180524         exsr getValues;
030900180503
031000180524         mcovedate = %char(enrldt);
031100180313
031200180313         if candt > 0;
031300180913          cancelh = candt;
031400180913           exsr sub1_fromDate;
031500180913          mcovcdate = %char(cancelh);
031600180313         endif;
031700180312
031800180313         exsr coverageType;
031900180313
032000180313         if qedt > 0 and empst = 'C';
032100180313          mcbovedate = %char(qedt);
032200180313          mcbpddate = %char(cexpdt);
032300180313         endif;
032400180313
032500180313         mnetid = ' ';
032600180313         medpcpid = ' ';
032700180313         medestpid = ' ';
032800180313         mpnetefdt = ' ';
032900180313         mpeclmedt = ' ';
033000190715         endif;
033001190715        endif;
033100180312
033200180313        if catType = 'DEN';
033201190903         ctype = catType;
033202191101         ssn = mcssno;
033203190715         termdt = candt;
033204190715         seq# = 0;
033205190715         exsr checkTerm;
033206190923         //alreadySentD = alreadySent;
033207190715         if alreadySentD = 'N';
033208200109
033300200728         //dacct# = group#;
033301200728         //if dacct# = ' ';
033302200109          dacct# = cacid4;
033303200728         //endif;
033304200109
033400180410         dtype = 'DEN';
033500180313
033600180510          exsr getValues;
033700180503
033800180524          dcovedate = %char(enrldt);
033900180313
034000180524          if candt > 0;
034100180913           cancelh = candt;
034200180913            exsr sub1_fromDate;
034300180913           dcovcdate = %char(cancelh);
034400180524          endif;
034500180313
034600180313         exsr coverageType;
034700180313
034800180313         if qedt > 0 and empst = 'C';
034900180313          dcbovedate = %char(qedt);
035000180313          dcbpddate = %char(cexpdt);
035100180313         endif;
035200180313
035300190715         endif;
035301190715        endif;
035400180313
035500180313        if catType = 'VIS';
035501191101         ssn = mcssno;
035502190903         ctype = catType;
035503190715         termdt = candt;
035504190715         seq# = 0;
035505190715         exsr checkTerm;
035506190923         //alreadySentV = alreadySent;
035507190715         if alreadySentV = 'N';
035508200109
035600200728         //vacct# = group#;
035601200728         //if vacct# = ' ';
035602200109          vacct# = cacid5;
035603200728         //endif;
035604200109
035700180410         vtype = 'VIS';
035800180405
035900180524         exsr getValues;
036000180502
036100180524         vcovedate = %char(enrldt);
036200180313
036300180313         if candt > 0;
036400180913          cancelh = candt;
036500180913           exsr sub1_fromDate;
036600180913          vcovcdate = %char(cancelh);
036700180313         endif;
036800180313
036900180313         exsr coverageType;
037000180313
037100180313         if qedt > 0 and empst = 'C';
037200180313          vcbovedate = %char(qedt);
037300180313          vcbpddate = %char(cexpdt);
037400180313         endif;
037401190715        endif;
037500180313
037600180313        endif;
037700180313
037701210715        if catType = 'FSA';
037702210715         ssn = mcssno;
037703210715         ctype = catType;
037704210715         termdt = candt;
037705210715         seq# = 0;
037706210715         exsr checkTerm;
037707210715         //alreadySentM = alreadySent;
037708210715         if alreadySentF = 'N';
037709210715
037710210715         //macct# = group#;
037711210715         //if macct# = ' ';
037712210715          facct# = cacid3;
037713210715         //endif;
037714210715
037715210715         ftype = 'AH ';
037716210715
037717210715         exsr getValues;
037718210715
037719210715         fcovedate = %char(enrldt);
037720210715
037721210715         if candt > 0;
037722210715          cancelh = candt;
037723210715           exsr sub1_fromDate;
037724210715          fcovcdate = %char(cancelh);
037725210715         endif;
037726210715
037727210715         exsr coverageType;
037728210715
037739210715         endif;
037740210715        endif;
037741210715
037800180523        ssn = mcssno;
037900180523        seq# = 0;
038000180523        ctype = catType;
038100180523        termdt = candt;
038200180523
038300190715        //exsr checkTerm;
038400190715        //if alreadySent = 'N';
038500180523
038501210715         if alreadySentM = 'N' or alreadySentD = 'N' or alreadySentV = 'N'
038502210715          or alreadySentF = 'N';
038503201202          if planFound = 'Y';
038600201202           if writeRecord = 'Y';
038700201202            write cignaFile;
038800201202           endif;
038801190715
038900201202           if updateRecord = 'Y';
039000201202            update cignaFile;
039100201202           endif;
039101201202          endif;
039102201202
039103190828         exsr setFlags;
039105190715         endif;
039200180523
039300190715        //endif;
039400180523
039500180523        if mcovtp <> 'TIN';
039600180523         exsr dependent;
039700180523        endif;
039800180523
039900160516       endsr;
040000060817
040100180913      //===================================================================
040200180913      // sub 1 from cancel date
040300180913      //===================================================================
040400180913
040500180913       begsr sub1_fromDate;
040600180913
040700180913        cancelDate = %date(cancelh) - %days(1);
040800180913        cancelh = %dec(cancelDate);
040900180913
041000180913       endsr;
041100180913
041200180523      //===================================================================
041300180523      // check termed records;
041400180523      //===================================================================
041500180523
041600180523       begsr checkTerm;
041700180523
041800190903       //alreadySent = 'N';
041801190903       alreadySentM = 'N';
041802190903       alreadySentD = 'N';
041803190903       alreadySentV = 'N';
041804210715       alreadySentF = 'N';
041900180523
042000180523       if termdt > 0;
042100180523
042200180523        chain (pltrst:plsub#:acc#:ssn:seq#:ctype:plplan:termdt) termFile;
042300180523        if %found;
042301190903
042302190903         if ctype = 'MED';
042303190903          alreadySentM = 'Y';
042304190903         endif;
042305190903
042306190903         if ctype = 'DEN';
042307190903          alreadySentD = 'Y';
042308190903         endif;
042309190903
042310190903         if ctype = 'VIS';
042311190903          alreadySentV = 'Y';
042312190903         endif;
042313190903
042314210715         if ctype = 'FSA';
042315210715          alreadySentF = 'Y';
042316210715         endif;
042317210715
042400190903         //alreadySent = 'Y';
042500190903         //leavesr;
042600180523        endif;
042700180523
042800180523        if not %found;
042900180523         ttrst = pltrst;
043000180523          tsub# = plsub#;
043100180523           tacct = acc#;
043200180524            tssno = ssn;
043300180523             tseq# = seq#;
043400180523             ttype = ctype;
043500180523            tplan = plplan;
043600180523           ttermdt = termdt;
043700180523          ttrnsdt = %dec(%date);
043800180523         write termFile;
043900180523        endif;
044000180523
044100180523       endif;
044200180523
044300180523       endsr;
044400180508
044500180518      //===================================================================
044600180518      // get values
044700180518      //===================================================================
044800180518
044900180518       begsr getValues;
045000180518
045001201202        planFound = 'N';
045002201202
045100180523        covtp = %subst(mcovtp:2:2);
045200180523        chain (unique:mbtrst:mbsub#:plplan:mbacct:state:covtp) planFile;
045300180518        if %found;
045301201202         planFound = 'Y';
045400201202          exsr get_valuesCategory;
045500180524         leavesr;
045600180524        endif;
045700180518
045800180523        covtp = %subst(mcovtp:2:2);
045900180523        chain (unique:mbtrst:mbsub#:plplan:mbacct:'ALL':covtp) planFile;
046000180523        if %found;
046001201202         planFound = 'Y';
046100201202          exsr get_valuesCategory;
046200180524         leavesr;
046300180524        endif;
046400180523
046500180525        chain (unique:mbtrst:mbsub#:plplan:mbacct:state:'ALL') planFile;
046600180525        if %found;
046601201202         planFound = 'Y';
046700201202          exsr get_valuesCategory;
046800180525         leavesr;
046900180525        endif;
047000180525
047100180525        chain (unique:mbtrst:mbsub#:plplan:mbacct:'ALL':'ALL') planFile;
047200180525        if %found;
047201201202         planFound = 'Y';
047300201202          exsr get_valuesCategory;
047400180525         leavesr;
047500180525        endif;
047600180525
047601190509        exsr errorReport;
047602190509
047700180518       endsr;
047800190828      //===================================================================
047801190828      // setflags
047802190828      //===================================================================
047803190828
047804190828       begsr setFlags;
047805190828
047806190828        if catType = 'MED';
047807190828         alreadySentM = 'Y';
047808190828        endif;
047809190828
047810190828        if catType = 'DEN';
047811190828         alreadySentD = 'Y';
047812190828        endif;
047813190828
047814190828        if catType = 'VIS';
047815190828         alreadySentV = 'Y';
047816190828        endif;
047817190828
047818210715        if catType = 'FSA';
047819210715         alreadySentF = 'Y';
047820210715        endif;
047821210715
047822190828       endsr;
047823190828
047900180524      //===================================================================
048000180524      // get values category
048100180524      //===================================================================
048200180524
048300180524       begsr get_valuesCategory;
048400180524
048500180524        if catType = 'MED';
048600180524         mplanid = cpcid4;
048700180524          mbranchcd = cpcid3;
048800190509         mboptcode = cpcid2;
048900180524        endif;
049000180524
049100180524        if catType = 'DEN';
049200180524         dplanid = cpcid4;
049300180524          dbranchcd = cpcid3;
049400190509         dboptcode = cpcid2;
049500180524        endif;
049600180524
049700180524        if catType = 'VIS';
049800180524         vplanid = cpcid4;
049900180524          vbranchcd = cpcid3;
050000190509         vboptcode = cpcid2;
050100180524        endif;
050200180524
050201210715        if catType = 'FSA';
050202210715         fplanid = cpcid4;
050203210715          fbranchcd = cpcid3;
050204210715         fboptcode = cpcid2;
050205210715        endif;
050206210715
050300180524       endsr;
050400180524
050500160512      //===================================================================
050600160512      // process
050700160512      //===================================================================
050800160512
050900160512       begsr dependent;
051000160512
051100160512        setll mcssno depenr;
051200160512        reade mcssno depenr;
051300160512
051400160512        dow not %eof;
051500160512
051600180313        chain (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
051700160512        if %found;
051800180313         exsr dependentCoverage;
051900160512        endif;
052000160512
052100160512        reade mcssno depenr;
052200160512        enddo;
052300160512
052400190509       endsr;
052500160512
052600160516      //===============================================================
052700160512      // Dependent coverage
052800160512      //===============================================================
052900160513
053000180313       begsr dependentCoverage;
053100160512
053200180313        setgt (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
053300180313        readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
053400160512
053500160512        dow not %eof;
053600160512
053700180313         if ccandt <> 0;
053800160512
053900160516          term_dt_limit = %date(ccandt);
054000160516          if %date() > term_dt_limit;
054100160512           leavesr;
054200160512          else;
054300160512
054400160516           exsr writeDep;
054500160512          endif;
054600160512
054700160512         else;
054800160516          exsr writeDep;
054900160512          leavesr;
055000160512         endif;
055100160512
055200180313        readpe (mctrst:mcsub#:mcplan:mcssno:dpseq#) dcovr;
055300160512        enddo;
055400160512
055500160512       endsr;
055600160512
055700160516      //===============================================================
055800160516      // write dependent
055900160516      //===============================================================
056000160516
056100160516       begsr writeDep;
056200180313
056300180313        updateRecord = 'N';
056400180313        writeRecord = 'N';
056500180313
056600180313        chain
056700180313        (%editc(mbssno:'X'):%editc(depss#:'X'):%char(dbirth):dlname:dfname:dmi)
056800180313        cignaFile;
056900180313        if %found;
057000180313         updateRecord = 'Y';
057100180313        else;
057200180313         writeRecord = 'Y';
057201190828         alreadySentM = 'N';
057202190828         alreadySentD = 'N';
057203190828         alreadySentV = 'N';
057204210715         alreadySentF = 'N';
057300180313        endif;
057400180313
057500180313        exsr determineType;
057600180313        if catType = ' ';
057700180313         leavesr;
057800180313        endif;
057900180313
058000180313        exsr getgrp;
058100180313
058200180313        if writeRecord = 'Y';
058300180313         clear cignaFile;
058400180313        endif;
058500180313
058600180427        chain (pltrst : plsub# : acc#) actFile;
058700180427        if %found;
058800211129         groupnam = macnam1;
058900180427        endif;
059000180427
059100180427        chain (pltrst : plsub# : acc#) act2File;
059200180427        if %found;
059300180427         grouptid = %editc(a2tax_id#:'X');
059400180427        endif;
059500180427
059600180313        recid = '02';
059700180313        prkeyty = 'S';
059800180313        memid = %editc(mbssno:'X');
059900180313        lastname = dlname;
060000180313        firstname = dfname;
060100180313        mi = dmi;
060200180313        dateofbth = %char(dbirth);
060300180313        gender = dsex;
060400180417
060500180313        mbrssn = %editc(depss#:'X');
060600180417        if mbrssn = '000000000';
060700180502         //mbrssn = ' ';
060800180417         tssn = ' ';
060900180417        endif;
061000180313
061100180313        oritype = ' ';
061200180313        orikey = ' ';
061300180313
061400180313        cphone = %editc(area:'X') + %editc(phone:'X');
061500180313        bphone = ' ';
061600180313
061700180313        address1 = daddr1;
061800180313        address2 = daddr2;
061900180313        ccity = dcity;
062000180405        cstate = dstate;
062100180313        czip = %editc(dzip:'X');
062200180313        wzip = ' ';
062300180313        ftstdnt = ' ';
062400180313
062500180313        exsr relCodes;
062600180313
062700180313        deceased = ' ';
062800180313        decdate = ' ';
062900180313
063000180313        if dhndcp > ' ';
063100180313         disabled = 'H';
063200180313        endif;
063300180313
063400180313        retired = ' ';
063500180313        retdate = ' ';
063600180313        oritype2 = ' ';
063700180313        orikey2 = ' ';
063800180313
063900180313        cursalary = ' ';
064000180313        salfreq = ' ';
064100180313        saldate = ' ';
064200180313
064300180313        hiredate = ' ';
064400180313        yrofserv = ' ';
064500180313
064600180313        email = ' ';
064700180313        eid = ' ';
064800180313
064900180313        oins = ' ';
065000180313        mhicid = ' ';
065100180313
065200180313        covtype = ' ';
065300180313        carrier = ' ';
065400180313        medtype = ' ';
065500180417        oeffdate = %char(frmdat);
065600180417        //oeffdate = ' ';
065700180313        ocandate = ' ';
065800180313        pcode = ' ';
065900180313        fresp = ' ';
066000180313        covtype2 = ' ';
066100180313        carrier2 = ' ';
066200180313        medtype2 = ' ';
066300180313        oeffdate2 = ' ';
066400180313        ocandate2 = ' ';
066500180313        pcode2 = ' ';
066600180313        fresp2 = ' ';
066700180313        policy#2 = ' ';
066800180313        covtype3 = ' ';
066900180313        carrier3 = ' ';
067000180313        medtype3 = ' ';
067100180313        oeffdate3 = ' ';
067200180313        ocandate3 = ' ';
067300180313        pcode3 = ' ';
067400180313        fresp3 = ' ';
067500180313        policy#3 = ' ';
067600180313
067700180313        estatus = ' ';
067800180313
067900180313        estatusdt = ' ';
068000180313
068100180417        //tssn = %editc(depss#:'X');
068200180313
068300180313        eloc = ' ';
068400180313        feditin = %editc(depss#:'X');
068500180411
068600200728        //hgroup# = group#;
068601200728        //if hgroup# = ' ';
068602200728         //hgroup# = cacid3;
068603200728        //endif;
068700200728        //policy# = %trim('00') + %trim(hgroup#) + %trim('-F');
068701200728
068703200728        hgroup# = group#;
068704200728        hgroup#2 = group#;
068705200728        if hgroup# = ' ';
068706200728         hgroup# = cacid3;
068707200728         hgroup#2 = cacid3;
068708200728        endif;
068709200728
068710200728        pos = %scan('00' : group# : 1);
068711200728        if pos = 1;
068712200728         policy# = %trim(hgroup#2) + %trim('-F');
068713200728        else;
068714200728         policy# = %trim('00') + %trim(hgroup#) + %trim('-F');
068715200728        endif;
068716210401
068800210401        policy# = cacid6 + %trim('-F');
068801210401
068900180313        if catType = 'MED';
068901190715        ssn = mcssno;
068902190715        seq# = dpseq#;
068903190715        ctype = catType;
068904190715        termdt = ccandt;
068906190715        exsr checkTerm;
068907190828        //alreadySentM = alreadySent;
068908190715
068909190715        if alreadySentM = 'N';
068910190715
069000200728         //macct# = group#;
069001200728         //if macct# = ' ';
069002200728          macct# = cacid3;
069003200728         //endif;
069004200109
069100180410         mtype = 'HLT';
069200180508
069300180524         exsr getValues;
069400180503
069500180524         mcovedate = %char(denrdt);
069600180606
069700180606         if denrdt < enrldt;
069800180606          mcovedate = %char(enrldt);
069900180606         endif;
070000180606
070100180606         if dbirth > denrdt;
070200180606          mcovedate = %char(dbirth);
070300180606         endif;
070400180313
070500180523         if ccandt > 0;
070600180913          cancelh = ccandt;
070700180913           exsr sub1_fromDate;
070800180913          mcovcdate = %char(cancelh);
070900180313         endif;
071000180413
071100180313         mecovin = ' ';
071200180313         mscovin = ' ';
071300180313         mccovin = ' ';
071400180313         mcocovin = ' ';
071500180313         decovin = ' ';
071600180313         dscovin = ' ';
071700180313         dccovin = ' ';
071800180313         dcocovin = ' ';
071900180313         vecovin = ' ';
072000180313         vscovin = ' ';
072100180313         vccovin = ' ';
072200180313         vcocovin = ' ';
072201210715         fecovin = ' ';
072202210715         fscovin = ' ';
072203210715         fccovin = ' ';
072204210715         fcocovin = ' ';
072300180313
072400180413         exsr coverageType;
072500180413
072600180313         if qedt > 0 and empst = 'C';
072700180313          mcbovedate = %char(qedt);
072800180313          mcbpddate = %char(cexpdt);
072900180313         endif;
073000180313
073100180313         mnetid = ' ';
073200180313         medpcpid = ' ';
073300180313         medestpid = ' ';
073400180313         mpnetefdt = ' ';
073500180313         mpeclmedt = ' ';
073600180313        endif;
073601190715        endif;
073700180313
073800180313        if catType = 'DEN';
073801190715        ssn = mcssno;
073802190715        seq# = dpseq#;
073803190715        ctype = catType;
073804190715        termdt = ccandt;
073805190715        exsr checkTerm;
073806190828        //alreadySentD = alreadySent;
073807190715
073808190715        if alreadySentD = 'N';
073809200109
073900200728         //dacct# = group#;
073901200728         //if dacct# = ' ';
073902200109          dacct# = cacid4;
073903200728         //endif;
073904200109
074000180410         dtype = 'DEN';
074100180313
074200180524         exsr getValues;
074300180503
074400180524         dcovedate = %char(denrdt);
074500180606
074600180606         if denrdt < enrldt;
074700180606          dcovedate = %char(enrldt);
074800180606         endif;
074900180606
075000180606         if dbirth > denrdt;
075100180606          dcovedate = %char(dbirth);
075200180606         endif;
075300180313
075400180523         if ccandt > 0;
075500180913          cancelh = ccandt;
075600180913           exsr sub1_fromDate;
075700180913          dcovcdate = %char(cancelh);
075800180313         endif;
075900180313
076000180313         exsr coverageType;
076100180313
076200180313         if qedt > 0 and empst = 'C';
076300180313          dcbovedate = %char(qedt);
076400180313          dcbpddate = %char(cexpdt);
076500180313         endif;
076501190715         endif;
076600180313
076700180313        endif;
076800180313
076900180313        if catType = 'VIS';
076901190715        ssn = mcssno;
076902190715        seq# = dpseq#;
076903190715        ctype = catType;
076904190715        termdt = ccandt;
076905190715        exsr checkTerm;
076906190828        //alreadySentV = alreadySent;
076907190715
076908190715        if alreadySentV = 'N';
076909200109
077000200728         //vacct# = group#;
077001200728         //if vacct# = ' ';
077002200109          vacct# = cacid5;
077003200728         //endif;
077005200109
077006180410         vtype = 'VIS';
077200180313
077300180524         exsr getValues;
077400180503
077500180524         vcovedate = %char(denrdt);
077600180606
077700180606         if denrdt < enrldt;
077800180606          vcovedate = %char(enrldt);
077900180606         endif;
078000180606
078100180606         if dbirth > denrdt;
078200180606          vcovedate = %char(dbirth);
078300180606         endif;
078400180313
078500180523         if ccandt > 0;
078600180913          cancelh = ccandt;
078700180913           exsr sub1_fromDate;
078800180913          vcovcdate = %char(cancelh);
078900180313         endif;
079000180313
079100180313         exsr coverageType;
079200180313
079300180313         if qedt > 0 and empst = 'C';
079400180313          vcbovedate = %char(qedt);
079500180313          vcbpddate = %char(cexpdt);
079600180313         endif;
079601190715         endif;
079700180313
079800180313        endif;
079900180313
079901210715        if catType = 'FSA';
079902210715        ssn = mcssno;
079903210715        seq# = dpseq#;
079904210715        ctype = catType;
079905210715        termdt = ccandt;
079906210715        exsr checkTerm;
079907210715        //alreadySentM = alreadySent;
079908210715
079909210715        if alreadySentF = 'N';
079910210715
079911210715         //macct# = group#;
079912210715         //if macct# = ' ';
079913210715          facct# = cacid3;
079914210715         //endif;
079915210715
079916210716         ftype = 'AH ';
079917210715
079918210715         exsr getValues;
079919210715
079920210715         fcovedate = %char(denrdt);
079921210715
079922210715         if denrdt < enrldt;
079923210715          fcovedate = %char(enrldt);
079924210715         endif;
079925210715
079926210715         if dbirth > denrdt;
079927210715          fcovedate = %char(dbirth);
079928210715         endif;
079929210715
079930210715         if ccandt > 0;
079931210715          cancelh = ccandt;
079932210715           exsr sub1_fromDate;
079933210715          fcovcdate = %char(cancelh);
079934210715         endif;
079935210715
079936210715         fecovin = ' ';
079937210715         fscovin = ' ';
079938210715         fccovin = ' ';
079947210715         fcocovin = ' ';
079948210715
079949210715         exsr coverageType;
079950210715
079961210715        endif;
079962210715        endif;
079963210715
080000190715        //ssn = mcssno;
080100190715        //seq# = dpseq#;
080200190715        //ctype = catType;
080300190715        //termdt = ccandt;
080400180523
080500190715        //exsr checkTerm;
080600190715        //if alreadySent = 'N';
080700180523
080701210715         if alreadySentM = 'N' or alreadySentD = 'N' or alreadySentV = 'N'
080702210715           or alreadySentF = 'N';
080703201202          if planFound = 'Y';
080800201202           if writeRecord = 'Y';
080900201202            write cignaFile;
081000201202           endif;
081001190715
081100201202           if updateRecord = 'Y';
081200201202            update cignaFile;
081300201202           endif;
081301201202          endif;
081302201202
081303190828         exsr setFlags;
081304190715         endif;
081400160516
081500190715        //endif;
081600180523
081700160516       endsr;
081800160511
081900160519      //===================================================================
082000160519      // Get group number
082100160519      //===================================================================
082200160519
082300160519       begsr getgrp;
082400160519
082500160519        setll (pltrst : plsub# : plplan) grater;
082600160519        reade (pltrst : plsub# : plplan) grater;
082700160519
082800160519        dow not %eof;
082900160519
083000160519         if today >= frmdat;
083100160519          if today <= todat;
083200160519           leavesr;
083300160519          else;
083400160519           group# = ' ';
083500160519          endif;
083600160519         endif;
083700160519
083800160519        reade (pltrst : plsub# : plplan) grater;
083900160519        enddo;
084000160519
084100190509       endsr;
084200160519
084300180312      //===================================================================
084400180312      // Coverage Type
084500180312      //===================================================================
084600180312
084700180312       begsr coverageType;
084800180312
084900180313        if catType = 'MED';
085000180313         mecovin = 'N';
085100180313         mscovin = 'N';
085200180313         mccovin = 'N';
085300180313         mcocovin = 'N';
085400180313
085500180313         select;
085600180313          when mcovtp = 'TIN';
085700180313           mecovin = 'Y';
085800180313
085900180313          when mcovtp = 'THW';
086000180313           mecovin = 'Y';
086100180313           mscovin = 'Y';
086200180313
086300180313          when mcovtp = 'TPC' or mcovtp = 'TP2';
086400180313           mecovin = 'Y';
086500180313           mccovin = 'Y';
086600180313
086700180313          when mcovtp = 'TFA';
086800180313           mecovin = 'Y';
086900180313           mscovin = 'Y';
087000180313           mccovin = 'Y';
087100180313         endsl;
087200180313        endif;
087300180312
087400180313        if catType = 'DEN';
087500180313         decovin = 'N';
087600180313         dscovin = 'N';
087700180313         dccovin = 'N';
087800180313         dcocovin = 'N';
087900180313
088000180313         select;
088100180313          when mcovtp = 'TIN';
088200180313           decovin = 'Y';
088300180313
088400180313          when mcovtp = 'THW';
088500180313           decovin = 'Y';
088600180313           dscovin = 'Y';
088700180313
088800180313          when mcovtp = 'TPC' or mcovtp = 'TP2';
088900180313           decovin = 'Y';
089000180313           dccovin = 'Y';
089100180313
089200180313          when mcovtp = 'TFA';
089300180313           decovin = 'Y';
089400180313           dscovin = 'Y';
089500180313           dccovin = 'Y';
089600180313         endsl;
089700180313        endif;
089800180313
089900180313        if catType = 'VIS';
090000180313         vecovin = 'N';
090100180313         vscovin = 'N';
090200180313         vccovin = 'N';
090300180313         vcocovin = 'N';
090400180313
090500180313         select;
090600180313          when mcovtp = 'TIN';
090700180313           vecovin = 'Y';
090800180313
090900180313          when mcovtp = 'THW';
091000180313           vecovin = 'Y';
091100180313           vscovin = 'Y';
091200180313
091300180313          when mcovtp = 'TPC' or mcovtp = 'TP2';
091400180313           vecovin = 'Y';
091500180313           vccovin = 'Y';
091600180313
091700180313          when mcovtp = 'TFA';
091800180313           vecovin = 'Y';
091900180313           vscovin = 'Y';
092000180313           vccovin = 'Y';
092100180313         endsl;
092200180313        endif;
092300180313
092301210715        if catType = 'FSA';
092302210715         fecovin = 'N';
092303210715         fscovin = 'N';
092304210715         fccovin = 'N';
092305210715         fcocovin = 'N';
092306210715
092307210715         select;
092308210715          when mcovtp = 'TIN';
092309210715           fecovin = 'Y';
092310210715
092311210715          when mcovtp = 'THW';
092312210715           fecovin = 'Y';
092313210715           fscovin = 'Y';
092314210715
092315210715          when mcovtp = 'TPC' or mcovtp = 'TP2';
092316210715           fecovin = 'Y';
092317210715           fccovin = 'Y';
092318210715
092319210715          when mcovtp = 'TFA';
092320210715           fecovin = 'Y';
092321210715           fscovin = 'Y';
092322210715           fccovin = 'Y';
092323210715         endsl;
092324210715        endif;
092325210715
092400180312       endsr;
092500180312
092600180313      //===================================================================
092700180313      // Determine Type
092800180313      //===================================================================
092900180313
093000180313       begsr determineType;
093100180313
093200180319        catType = ' ';
093300180319
093400180313        chain ('P' : %subst(plncat:2:2)) codesFile;
093500180313        if %found;
093600180313
093700180313         select;
093800180313          when action = 'M';
093900180313           catType = 'MED';
094000180313
094100180313          when action = 'D';
094200180313           catType = 'DEN';
094300180313
094400180313          when action = 'V';
094500180313           catType = 'VIS';
094501210715
094502210715          when action = 'U' and code = 'FS';
094503210715           catType = 'FSA';
094504210715         endsl;
094505210715
094800180313        endif;
094900180313
095000180313       endsr;
095100180313
095200180313      //===================================================================
095300180313      // Relationship Codes
095400180313      //===================================================================
095500180313
095600180313       begsr relCodes;
095700180313
095800180313        select;
095900180313         when drelcd = 'RHU' or drelcd = 'RWI' or drelcd = 'RPA';
096000180313          relcd = 'SP';
096100180313
096200180313         when drelcd = 'RDA' or drelcd = 'RSO';
096300180313          relcd = 'CH';
096400180313
096500180313         when drelcd = 'RDA' or drelcd = 'RSO';
096600180313          relcd = 'CH';
096700180313        endsl;
096800180313
096900180313       endsr;
097000180313
097100180424      //===================================================================
097200180424      // clear ssn
097300180424      //===================================================================
097400180424
097500180424       begsr clearSSN;
097600180424
097700180424        setll *loval cignaFile;
097800180424        read cignaFile;
097900180424        dow  not %eof;
098000180424         if mbrssn = '000000000';
098100180424          mbrssn = ' ';
098200180424           tssn = ' ';
098300180424          update cignaFile;
098400180424         endif;
098500180424
098600180424        read cignaFile;
098700180424        enddo;
098800180424
098900180424       endsr;
099000180424
099001190719      //===================================================================
099002190719      // clear file
099003190719      //===================================================================
099004190719
099005190719       begsr checkFile;
099006190719
099007190719        setll *loval cignaFile;
099008190719        read cignaFile;
099009190719        dow  not %eof;
099010190719
099011190719        if MACCT# = ' ' and  MTYPE  = ' ' and  MPLANID = ' ' and
099012190719            MBRANCHCD = ' ' and MBOPTCODE = ' ' and  MCOVEDATE = ' ' and
099013190719            MCOVCDATE = ' ' and  MECOVIN = ' ' and  MSCOVIN = ' ' and
099014190719             MCCOVIN  = ' ' and  MCOCOVIN = ' ' and
099015190719
099016190719           dACCT# = ' ' and  dTYPE  = ' ' and  dPLANID = ' ' and
099017190719            dBRANCHCD = ' ' and dBOPTCODE = ' ' and  dCOVEDATE = ' ' and
099018190719            dCOVCDATE = ' ' and  dECOVIN = ' ' and  dSCOVIN = ' ' and
099019190719             dCCOVIN  = ' ' and  dCOCOVIN = ' ' and
099020190719
099021190719           vACCT# = ' ' and  vTYPE  = ' ' and  vPLANID = ' ' and
099022190719            vBRANCHCD = ' ' and vBOPTCODE = ' ' and  vCOVEDATE = ' ' and
099023190719            vCOVCDATE = ' ' and  vECOVIN = ' ' and  vSCOVIN = ' ' and
099024190719             vCCOVIN  = ' ' and  vCOCOVIN = ' ';
099025190719           delete cignaFile;
099026190719           endif;
099027190719
099028190719        read cignaFile;
099029190719        enddo;
099046200423
099047190719       endsr;
099048190719
099049200423      //===================================================================
099050200424      // hardcodes
099051200423      //===================================================================
099052200423
099053200423       begsr doHardcodes;
099054200424
099055200424        exsr akvarr;
099056200617        exsr childrensHome;
099057200512        exsr ase;
099058200424
099059200424       endsr;
099060200423
099061200424      //===================================================================
099062200424      // Akvarr
099063200424      //===================================================================
099064200424
099065200424       begsr akvarr;
099066200424
099067200423        setll *loval cignaFile;
099068200423        read cignaFile;
099069200423        dow  not %eof;
099070200423
099071200423         if macct# = '622407';
099072200423          if mcovcdate = ' ';
099073200423           if mcovedate < '20200501';
099074200423            mcovedate = '20200501';
099075200423           endif;
099076200423          endif;
099077200423         endif;
099078200423
099079200423         if dacct# = '622407';
099080200423          if dcovcdate = ' ';
099081200423           if dcovedate < '20200501';
099082200423            dcovedate = '20200501';
099083200423           endif;
099084200423          endif;
099085200423         endif;
099086200423
099087200423         if vacct# = '622407';
099088200423          if vcovcdate = ' ';
099089200423           if vcovedate < '20200501';
099090200423            vcovedate = '20200501';
099091200423           endif;
099092200423          endif;
099093200423         endif;
099094200423
099095200424         update cignaFile;
099096200423
099097200423        read cignaFile;
099098200423        enddo;
099099200423
099100200423       endsr;
099101200423
099102200424      //===================================================================
099103200424      // Childrens Home
099104200424      //===================================================================
099105200424
099106200424       begsr childrensHome;
099107200424
099108200424        setll *loval cignaFile;
099109200424        read cignaFile;
099110200424        dow  not %eof;
099111200424
099112200424         if macct# = '622524';
099113200424          if mcovcdate = ' ';
099114200424           if mcovedate < '20200601';
099115200424            mcovedate = '20200601';
099116200424           endif;
099117200424          endif;
099118200424         endif;
099119200424
099135200424         update cignaFile;
099136200424
099137200424        read cignaFile;
099138200424        enddo;
099139200424
099140200424       endsr;
099141200424
099142200512      //===================================================================
099143200512      // American Society of Engineering
099144200512      //===================================================================
099145200512
099146200512       begsr ase;
099147200512
099148200512        setll *loval cignaFile;
099149200512        read cignaFile;
099150200512        dow  not %eof;
099151200512
099152200512         if macct# = '611156';
099153200512          if mcovcdate = ' ';
099154200512           if mcovedate < '20200601';
099155200512            mcovedate = '20200601';
099156200512           endif;
099157200512          endif;
099158200512         endif;
099159200512
099160200512         update cignaFile;
099161200512
099162200512        read cignaFile;
099163200512        enddo;
099164200512
099165200512       endsr;
099166200512
099167190509      //===================================================================
099168190509      // error report
099169190509      //===================================================================
099170190509
099171190509       begsr errorReport;
099172190509
099173190509        if macct# > ' ';
099174190509
099175190509         if mplanid = ' ';
099176190509          ctext = 'Plan ID/Benefit Opt missing';
099177190509          exsr writeError;
099178190509         endif;
099179190509
099180190509         if mbranchcd = ' ';
099181190509          ctext = 'Class ID/Branch Code missing';
099182190509          exsr writeError;
099183190509         endif;
099184190509
099185190509         if mboptcode = ' ';
099186190509          ctext = 'Subgroup/Parent Branch Code missing';
099187190509          exsr writeError;
099188190509         endif;
099189190509
099190190509        endif;
099191190509
099192190509        if dacct# > ' ';
099193190509
099194190509         if dplanid = ' ';
099195190509          ctext = 'Plan ID/Benefit Opt missing';
099196190509          exsr writeError;
099197190509         endif;
099198190509
099199190509         if dbranchcd = ' ';
099200190509          ctext = 'Class ID/Branch Code missing';
099201190509          exsr writeError;
099202190509         endif;
099203190509
099204190509         if dboptcode = ' ';
099205190509          ctext = 'Subgroup/Parent Branch Code missing';
099206190509          exsr writeError;
099207190509         endif;
099208190509
099209190509        endif;
099210190509
099211190509        if vacct# > ' ';
099212190509
099213190509         if vplanid = ' ';
099214190509          ctext = 'Plan ID/Benefit Opt missing';
099215190509          exsr writeError;
099216190509         endif;
099217190509
099218190509         if vbranchcd = ' ';
099219190509          ctext = 'Class ID/Branch Code missing';
099220190509          exsr writeError;
099221190509         endif;
099222190509
099223190509         if vboptcode = ' ';
099224190509          ctext = 'Subgroup/Parent Branch Code missing';
099225190509          exsr writeError;
099226190509         endif;
099227190509
099228190509        endif;
099229190509
099230210715        if facct# > ' ';
099231210715
099232210715         if fplanid = ' ';
099233210715          ctext = 'Plan ID/Benefit Opt missing';
099234210715          exsr writeError;
099235210715         endif;
099236210715
099237210715         if fbranchcd = ' ';
099238210715          ctext = 'Class ID/Branch Code missing';
099239210715          exsr writeError;
099240210715         endif;
099241210715
099242210715         if fboptcode = ' ';
099243210715          ctext = 'Subgroup/Parent Branch Code missing';
099244210715          exsr writeError;
099245210715         endif;
099246210715
099247210715        endif;
099248210715
099249190509       endsr;
099250190509
099251190509      //===================================================================
099252190509      // Write Error
099253190509      //===================================================================
099254190509
099255190509       begsr writeError;
099256190509
099257190509        mbrid = memid;
099258190509        ctrust = %char(mbtrst);
099259190509        csub# = %char(mbsub#);
099260190509        cacct = %char(mbacct);
099261190509        mbrlast = mlname;
099262190509        mbrfirst = mfname;
099263190509        mbrplan = plplan;
099264190509        mbrst = state;
099265190509
099266190509        chain (mbtrst : mbsub# : mbacct) actFile;
099267190509        if %found;
099268190509
099269211129         chain (maacode) aaFile;
099270190509         if %found;
099271190509          acctaa = %trim(afnam) + ' ' + %trim(alnam);
099272190509         endif;
099273190509
099274190509         write errorFile;
099275190509        endif;
099276190509
099277190509       endsr;
099278190509
099279160511      //===================================================================
099280160511      // exit
099300160511      //===================================================================
099400160511
099500160511       begsr exit;
099600160511
099700160511        *inlr = '1';
099800160511        return;
099900160511
100000160511       endsr;
100100160511
100200160511      //===================================================================
100300160511      // init
100400160511      //===================================================================
100500160520
100600160511       begsr init;
100700160511
100800180314        carrierCode1 = 'CIR';
100900180314        carrierCode2 = 'CIE';
101000180314        carrierCode3 = 'CIF';
101100180508        unique = '0000000251';
101200180309
101300160519        today = %dec(%char(%date:*iso0):8:0);
101301220106
101302220106        if intype = 'P';
101303220106         intype = 'F';
101304220106        endif;
101305220106
101400170710
101500160511       endsr;
101600010412
101700160511       //==============================================================
